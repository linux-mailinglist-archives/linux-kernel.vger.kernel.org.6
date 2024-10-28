Return-Path: <linux-kernel+bounces-385258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6065B9B34B5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3AEB1F22BF5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A021DE3B3;
	Mon, 28 Oct 2024 15:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fIXk/2Py"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D451E1DD0C7
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730128957; cv=none; b=EU3NVbD31nUIJK+gWpR2c4FSn2JVZ5M+1rbAEShoTZoClybEP/KgA8m9PWxXtTz1lge9aw27mmzcSHLzDzwjEM5hk4S55whQZ2L0hWKKUXTN6IAlZZtjOStoZygEN298HFreh8c7+ncwpRdsJjfhjZEAFojsXWN4668XKOJ2OEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730128957; c=relaxed/simple;
	bh=Swawbxe28vykfVUj/8Xf+/FlNYmS6gbmMvdVaG7mRoc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuXV0ORJDEuWGKuXndYRhYVOL7MR6aMIqQEKxnMuzUOA5CvqZ0lWzujLdiqs8qYw32hrxDKdHVFLs+Z72gt2FHVK17sy/2jz57jjcmKwwLmEBPz/BqR7v6Cd0IyJy3EeqL8KsPeo8plWdtSDn86fJu/BMK/QBnCSLGrrDYtT0Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fIXk/2Py; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49SFMMeh027800;
	Mon, 28 Oct 2024 10:22:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730128942;
	bh=Ek231t06jS6RkmTQz1qzd1xmke7zrYrcAAhEd0EtWxE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=fIXk/2PyUIoV18k7oq+/iYmIgFv8YqrilOnQaSMGifnxCTP35qN3QXGPnlmyooBpc
	 mLMeclC3EGwfL3ZO/HfYf22ULLB075gHoJD5mIIfJyi6u3Pgq6mYJ1Zg7BqY4tclov
	 S4hkeaVoiGOPihomMJo0t225ufWzS+m2hXvAdApw=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49SFMMv0049529
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Oct 2024 10:22:22 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Oct 2024 10:22:22 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Oct 2024 10:22:22 -0500
Received: from localhost (ula0507357.dhcp.ti.com [172.24.227.166])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49SFMLNi017857;
	Mon, 28 Oct 2024 10:22:22 -0500
Date: Mon, 28 Oct 2024 20:52:21 +0530
From: Suhaas Joshi <s-joshi@ti.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <s-vadapalli@ti.com>,
        <devarsht@ti.com>, <vigneshr@ti.com>, <b-brnich@ti.com>,
        <danishanwar@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC: <c-shilwant@ti.com>, <praneeth@ti.com>
Subject: Re: [PATCH 6.6] arm64: configs: Enable additional docker configs
Message-ID: <20241028152221.bnawg4wz4y7oqd55@ula0507357>
References: <20241028045340.1079402-1-s-joshi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241028045340.1079402-1-s-joshi@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi all,

This patch is a mistake. Please disregard it. I will send a new patch
across the latest baseline, with a better commit message.

Thanks
Suhaas

On 10:23-20241028, Suhaas Joshi wrote:
> Docker requires a list of config options to be enabled in the kernel.
> This list is generated by the script at [1]. The list has "mandatory"
> configs and "optional" ones. The mandatory ones are already enabled, so
> Docker works well with some images. But many of the optional ones,
> particularly security and network configs, aren't enabled. So
> enable those so that Docker can pull and run all valid images.
> 
> The configs generated are listed below.
> 
> Generally Necessary
> ...
> - CONFIG_MEMCG_SWAP: enabled
> - CONFIG_BLK_DEV_THROTTLING: enabled
> - CONFIG_NET_CLS_CGROUP: enabled (as module)
> - CONFIG_CGROUP_NET_PRIO: enabled
> - CONFIG_CFS_BANDWIDTH: enabled
> - CONFIG_IP_NF_TARGET_REDIRECT: enabled (as module)
> - CONFIG_IP_VS_NFCT: enabled
> - CONFIG_IP_VS_PROTO_TCP: enabled
> - CONFIG_IP_VS_PROTO_UDP: enabled
> - CONFIG_IP_VS_RR: enabled (as module)
> - CONFIG_SECURITY_SELINUX: enabled
> - CONFIG_SECURITY_APPARMOR: enabled
> - CONFIG_EXT3_FS_XATTR: enabled
> - CONFIG_EXT3_FS_POSIX_ACL: enabled
> - CONFIG_EXT3_FS_SECURITY: enabled
> - CONFIG_EXT4_FS_SECURITY: enabled
> - CONFIG_VXLAN: enabled (as module)
> - CONFIG_CRYPTO_SEQIV: enabled (as module)
> - CONFIG_XFRM: enabled
> - CONFIG_XFRM_USER: enabled
> - CONFIG_XFRM_ALGO: enabled
> - CONFIG_INET_ESP: enabled
> - CONFIG_NETFILTER_XT_MATCH_BPF: enabled (as module)
> - CONFIG_IPVLAN: enabled (as module)
> - CONFIG_DUMMY: enabled (as module)
> - CONFIG_NF_NAT_FTP: enabled (as module)
> - CONFIG_NF_CONNTRACK_FTP: enabled (as module)
> - CONFIG_NF_NAT_TFTP: enabled (as module)
> - CONFIG_NF_CONNTRACK_TFTP: enabled (as module)
> ...
> 
> [1] https://github.com/moby/moby/blob/25.0/contrib/check-config.sh
> 
> Signed-off-by: Suhaas Joshi <s-joshi@ti.com>
> ---
>  arch/arm64/configs/defconfig | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 7ffb46b74ae5..c37f18bddd38 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1,6 +1,7 @@
>  CONFIG_SYSVIPC=y
>  CONFIG_POSIX_MQUEUE=y
>  CONFIG_AUDIT=y
> +CONFIG_DUMMY=m
>  CONFIG_NO_HZ_IDLE=y
>  CONFIG_HIGH_RES_TIMERS=y
>  CONFIG_BPF_SYSCALL=y
> @@ -16,7 +17,9 @@ CONFIG_IKCONFIG=y
>  CONFIG_IKCONFIG_PROC=y
>  CONFIG_NUMA_BALANCING=y
>  CONFIG_MEMCG=y
> +CONFIG_MEMCG_SWAP=y
>  CONFIG_BLK_CGROUP=y
> +CONFIG_CFS_BANDWIDTH=y
>  CONFIG_CGROUP_PIDS=y
>  CONFIG_CGROUP_FREEZER=y
>  CONFIG_CGROUP_HUGETLB=y
> @@ -28,6 +31,7 @@ CONFIG_CGROUP_BPF=y
>  CONFIG_USER_NS=y
>  CONFIG_SCHED_AUTOGROUP=y
>  CONFIG_BLK_DEV_INITRD=y
> +CONFIG_BLK_DEV_THROTTLING=y
>  CONFIG_KALLSYMS_ALL=y
>  CONFIG_PROFILING=y
>  CONFIG_KEXEC=y
> @@ -135,22 +139,33 @@ CONFIG_IP_PNP=y
>  CONFIG_IP_PNP_DHCP=y
>  CONFIG_IP_PNP_BOOTP=y
>  CONFIG_IPV6=m
> +CONFIG_IPVLAN=m
>  CONFIG_NETFILTER=y
>  CONFIG_BRIDGE_NETFILTER=m
>  CONFIG_NF_CONNTRACK=m
>  CONFIG_NF_CONNTRACK_EVENTS=y
> +CONFIG_NF_NAT_FTP=m
> +CONFIG_NF_NAT_TFTP=m
> +CONFIG_NF_CONNTRACK_FTP=m
> +CONFIG_NF_CONNTRACK_TFTP=m
>  CONFIG_NETFILTER_XT_MARK=m
>  CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
>  CONFIG_NETFILTER_XT_TARGET_LOG=m
>  CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
>  CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
>  CONFIG_NETFILTER_XT_MATCH_IPVS=m
> +CONFIG_NETFILTER_XT_MATCH_BPF=m
>  CONFIG_IP_VS=m
> +CONFIG_IP_VS_PROTO_TCP=y
> +CONFIG_IP_VS_PROTO_UDP=y
> +CONFIG_IP_VS_RR=m
> +CONFIG_IP_VS_NFCT=y
>  CONFIG_IP_NF_IPTABLES=m
>  CONFIG_IP_NF_FILTER=m
>  CONFIG_IP_NF_TARGET_REJECT=m
>  CONFIG_IP_NF_NAT=m
>  CONFIG_IP_NF_TARGET_MASQUERADE=m
> +CONFIG_IP_NF_TARGET_REDIRECT=m
>  CONFIG_IP_NF_MANGLE=m
>  CONFIG_IP6_NF_IPTABLES=m
>  CONFIG_IP6_NF_FILTER=m
> @@ -171,6 +186,7 @@ CONFIG_NET_SCH_TAPRIO=m
>  CONFIG_NET_SCH_MQPRIO=m
>  CONFIG_NET_SCH_INGRESS=m
>  CONFIG_NET_CLS_BASIC=m
> +CONFIG_NET_CLS_CGROUP=m
>  CONFIG_NET_CLS_ROUTE4=m
>  CONFIG_NET_CLS_FW=m
>  CONFIG_NET_CLS_U32=m
> @@ -198,6 +214,7 @@ CONFIG_NET_ACT_GATE=m
>  CONFIG_HSR=m
>  CONFIG_QRTR_SMD=m
>  CONFIG_QRTR_TUN=m
> +CONFIG_CGROUP_NET_PRIO=y
>  CONFIG_CAN=m
>  CONFIG_BT=m
>  CONFIG_BT_HIDP=m
> @@ -1573,7 +1590,12 @@ CONFIG_HTE_TEGRA194=y
>  CONFIG_HTE_TEGRA194_TEST=m
>  CONFIG_EXT2_FS=y
>  CONFIG_EXT3_FS=y
> +CONFIG_EXT3_FS_XATTR=y
> +CONFIG_EXT3_FS_POSIX_ACL=y
> +CONFIG_EXT3_FS_SECURITY=y
>  CONFIG_EXT4_FS_POSIX_ACL=y
> +CONFIG_EXT4_FS_SECURITY=y
> +CONFIG_VXLAN=m
>  CONFIG_BTRFS_FS=m
>  CONFIG_BTRFS_FS_POSIX_ACL=y
>  CONFIG_FANOTIFY=y
> @@ -1598,6 +1620,8 @@ CONFIG_9P_FS=y
>  CONFIG_NLS_CODEPAGE_437=y
>  CONFIG_NLS_ISO8859_1=y
>  CONFIG_SECURITY=y
> +CONFIG_SECURITY_SELINUX=y
> +CONFIG_SECURITY_APPARMOR=y
>  CONFIG_CRYPTO_USER=y
>  CONFIG_CRYPTO_TEST=m
>  CONFIG_CRYPTO_ECHAINIV=y
> @@ -1628,6 +1652,11 @@ CONFIG_CRYPTO_DEV_HISI_HPRE=m
>  CONFIG_CRYPTO_DEV_HISI_TRNG=m
>  CONFIG_CRYPTO_DEV_SA2UL=m
>  CONFIG_CRYPTO_DEV_TI_MCRC64=m
> +CONFIG_CRYPTO_SEQIV=m
> +CONFIG_XFRM=y
> +CONFIG_XFRM_USER=y
> +CONFIG_XFRM_ALGO=y
> +CONFIG_INET_ESP=y
>  CONFIG_DMA_RESTRICTED_POOL=y
>  CONFIG_CMA_SIZE_MBYTES=32
>  CONFIG_PRINTK_TIME=y
> -- 
> 2.40.0
> 

