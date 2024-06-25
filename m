Return-Path: <linux-kernel+bounces-228374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68589915EF9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 08:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 253941F2253F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 06:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4B3145FFD;
	Tue, 25 Jun 2024 06:37:30 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E2E145FED
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 06:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719297450; cv=none; b=DaaPJIvQJWTm5afY5AFWKH1efT14Pdo7bKULvWTKOsLdWofywB6X9gZ35pV90qZqbDSLygZzCs401yCJf2smfpo/srTku/GafTp5ypKmFBQDGoPfJUFdRLc0pQNI4W3KIXYQXVwkIez2/mXAC163j06sYpojo6t29XZElZHMWCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719297450; c=relaxed/simple;
	bh=JNlLSOL/3gwxtX1zUgIEaLV+KJOCSyW9SpsxGeVD7Eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nK/3/snHKIq9oYz7l4UwweSMWMY0dKoR5Eth57Sf3GwpyOKd2HTFSEDwO44c6FDPO3zkcpTX3yAVTZKIGo7mZ1SXLGlYS4M1xGXCoqIYbANLnXZ4Uewu99opZ2oLOE4rp1dhHTsBczJQ8uYhcjT8j+/lg43Yc+z4h3f46jh3pww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4W7ZrJ1BjYznXkm;
	Tue, 25 Jun 2024 14:37:20 +0800 (CST)
Received: from dggpemd100004.china.huawei.com (unknown [7.185.36.20])
	by mail.maildlp.com (Postfix) with ESMTPS id 92F3C180064;
	Tue, 25 Jun 2024 14:37:24 +0800 (CST)
Received: from [10.67.109.211] (10.67.109.211) by
 dggpemd100004.china.huawei.com (7.185.36.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 25 Jun 2024 14:37:24 +0800
Message-ID: <cf29a1aa-add7-4a39-a9c6-f9bcc24d99f0@huawei.com>
Date: Tue, 25 Jun 2024 14:37:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RISC-V: Dynamically allocate cpumasks and further
 increase range and default value of NR_CPUS
Content-Language: en-US
To: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>
References: <20240614075306.357861-1-liuyuntao12@huawei.com>
From: "liuyuntao (F)" <liuyuntao12@huawei.com>
In-Reply-To: <20240614075306.357861-1-liuyuntao12@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemd100004.china.huawei.com (7.185.36.20)

Gentle ping

On 2024/6/14 15:53, Yuntao Liu wrote:
> Currently default NR_CPUS is 64 for riscv64, since the latest QEMU virt
> machine supports up to 512 CPUS, so set default NR_CPUS 512 for riscv64.
> 
> Under the promotion of RISC-V International and related chip
> manufacturers, RISC-V has also begun to enter the server market, which
> demands higher performance. Other major architectures (such as ARM64,
> x86_64, MIPS, etc) already have a higher range, so further increase
> this range up to 4096 for riscv64.
> 
> Due to the fact that increasing NR_CPUS enlarges the size of cpumasks,
> there is a concern that this could significantly impact stack usage,
> especially for code that allocates cpumasks on the stack. To address
> this, we have the option to enable CPUMASK_OFFSTACK, which prevents
> cpumasks from being allocated on the stack. we choose to enable this
> feature only when NR_CPUS is greater than 512, why 512, since then
> the kernel size with offstack is smaller.
> 
> vmlinux size comparison(difference to vmlinux_onstack_NR_CPUS baseline):
> 
> NR_CPUS     256         512         1024        2048        4096
> onstack     19814536    19840760    19880584    19969672    20141704
> offstack    19819144    19840936    19880480    19968544    20135456
> difference  +0.023%     +0.001%     -0.001%     -0.001      -0.031%
> is_smaller  n           n           y           y           y
> 
> Signed-off-by: Yuntao Liu <liuyuntao12@huawei.com>
> ---
>   arch/riscv/Kconfig | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 0525ee2d63c7..5960713b3bf9 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -77,6 +77,7 @@ config RISCV
>   	select CLINT_TIMER if RISCV_M_MODE
>   	select CLONE_BACKWARDS
>   	select COMMON_CLK
> +	select CPUMASK_OFFSTACK if NR_CPUS > 512
>   	select CPU_PM if CPU_IDLE || HIBERNATION || SUSPEND
>   	select EDAC_SUPPORT
>   	select FRAME_POINTER if PERF_EVENTS || (FUNCTION_TRACER && !DYNAMIC_FTRACE)
> @@ -428,11 +429,11 @@ config SCHED_MC
>   config NR_CPUS
>   	int "Maximum number of CPUs (2-512)"
>   	depends on SMP
> -	range 2 512 if !RISCV_SBI_V01
> +	range 2 4096 if !RISCV_SBI_V01
>   	range 2 32 if RISCV_SBI_V01 && 32BIT
>   	range 2 64 if RISCV_SBI_V01 && 64BIT
>   	default "32" if 32BIT
> -	default "64" if 64BIT
> +	default "512" if 64BIT
>   
>   config HOTPLUG_CPU
>   	bool "Support for hot-pluggable CPUs"

