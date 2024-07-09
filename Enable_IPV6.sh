    #!/bin/bash

    # 检查是否是以 root 身份执行脚本
    if [ "$(id -u)" -ne 0 ]; then
        echo "这个脚本需要以 root 权限执行，请使用 sudo 或以 root 用户执行此脚本。"
        exit 1
    fi

    # 启用 IPv6
    sed -i '/net.ipv6.conf.all.disable_ipv6/d' /etc/sysctl.conf
    sed -i '/net.ipv6.conf.default.disable_ipv6/d' /etc/sysctl.conf

    # 应用新的 sysctl 配置
    sysctl -p

    # 验证启用状态
    if [ "$(cat /proc/sys/net/ipv6/conf/all/disable_ipv6)" -eq 0 ] && [ "$(cat /proc/sys/net/ipv6/conf/default/disable_ipv6)" -eq 0 ]; then
        echo "IPv6 已成功启用。"
    else
        echo "IPv6 启用失败，请检查配置文件。"
    fi
