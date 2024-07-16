Return-Path: <linux-kernel+bounces-253319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EC9931F71
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 05:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6968CB223DD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 03:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B7114A84;
	Tue, 16 Jul 2024 03:44:53 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A196FBE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 03:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721101492; cv=none; b=IncyFrBlt0c3xuYb33MoTmRVFKNWU4rype2JAL2kNGI1f/C7XDRa+g0f0EOyrbtVF5xiz9qF3aZ5PmxctO7Dq/05p6Q+RNIKTlGMJYIMJ4QsiDFdpU/gKIFS7TU4ysp7BrJSiq/jpkK/L/omWSFOmpn/bvtcxVwqixL3+GTV5yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721101492; c=relaxed/simple;
	bh=Wt6MxHzEZ/JFijsetsefFaRz5L3cf94mZaCrzIEdocg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pzArF/jhOhyCON6eZEuboZGzp+rENIpyKbKlQffGLa7kZsbVBzwoSVzUtYl8jvHWm/iqdxwKzFrRL4gIk1XQAMV1csGXa/HzdXEiYAuquEda2MG4VDyyIy9/9fo8Oo9BT37+FIJvGfiLvlqrTO9uetcCDWVh883nXwpbgJv1j70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WNPzW4g3bzdhwf;
	Tue, 16 Jul 2024 11:43:03 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id BD6AF1403D1;
	Tue, 16 Jul 2024 11:44:46 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 11:44:46 +0800
Message-ID: <ff8d5b8c-088c-9e05-53b2-f86335a18b8f@huawei.com>
Date: Tue, 16 Jul 2024 11:44:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2] crash: Fix x86_32 and arm32 memory reserve bug
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>, <akpm@linux-foundation.org>
CC: <vgoyal@redhat.com>, <dyoung@redhat.com>, <austindh.kim@gmail.com>,
	<rmk+kernel@armlinux.org.uk>, <kexec@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20240713014808.1689915-1-ruanjinjie@huawei.com>
 <ZpU2rJ1aKyqlu8IN@MiWiFi-R3L-srv>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <ZpU2rJ1aKyqlu8IN@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi100008.china.huawei.com (7.221.188.57)



On 2024/7/15 22:48, Baoquan He wrote:
> On 07/13/24 at 09:48am, Jinjie Ruan wrote:
>> On x86_32 Qemu machine with 1GB memory, the cmdline "crashkernel=4G" is ok
>> as below:
>> 	crashkernel reserved: 0x0000000020000000 - 0x0000000120000000 (4096 MB)
>>
>> And on Qemu vexpress-a9 with 1GB memory, the crash kernel "crashkernel=4G"
>> is also ok as below:
>> 	Reserving 4096MB of memory at 2432MB for crashkernel (System RAM: 1024MB)
>>
>> The cause is that the crash_size is parsed and printed with "unsigned long
>> long" data type which is 8 bytes but allocated used with "phys_addr_t"
>> which is 4 bytes in memblock_phys_alloc_range().
>>
>> Fix it by limiting the "crash_size" to phys_addr_t and bypass the invalid
>> input size.
> 
> I am not sure if this is a good idea. Shouldn't we handle this in
> arch_reserve_crashkernel() to check the system RAM size?
> 
> With this patch, if you specify crashkernel=4352M (namely 4G+256M) in
> kernel cmdline, then you will reserve 256M crashkernel in system, don't
> you think that is confusing?

You are right!

In the case you mentioned, it can still allocate 256M successfully, but
the log shows 4352M successfully allocated, which is not taken into
account by this patch.

And handle this in arch_reserve_crashkernel() is a good idea, which will
 bypass all these corner case, I'll do it next version.

> 
> By the way, I am considering changing code to apply generic crashkernel
> reservation to 32bit system. Maybe below draft code can prevent
> crashkernel=,high from being parsed successfully on 32bit system.
> 
> What do you think?

I agree with you, I've thought about passing in a parameter in the
generic interface whether high is supported or not to implement it,
which is so incompatible. An architecture-defined macro to filter out
parsing of "high" fundamentally avoid using the generic interface to
allocate memory in "high" for the architecture that does not support
"high". The below code do prevent "crashkernel=,high" from being parsed
successfully on 32bit system.

But if it is to support 32 bit system to use generic crash memory
reserve interface, reserve_crashkernel_generic() needs more modification
, as it may try to allocate memory at high.

> 
> diff --git a/arch/arm64/include/asm/crash_reserve.h b/arch/arm64/include/asm/crash_reserve.h
> index 4afe027a4e7b..bf362c1a612f 100644
> --- a/arch/arm64/include/asm/crash_reserve.h
> +++ b/arch/arm64/include/asm/crash_reserve.h
> @@ -7,4 +7,6 @@
>  
>  #define CRASH_ADDR_LOW_MAX              arm64_dma_phys_limit
>  #define CRASH_ADDR_HIGH_MAX             (PHYS_MASK + 1)
> +
> +#define HAVE_ARCH_CRASHKERNEL_RESERVATION_HIGH
>  #endif
> diff --git a/arch/riscv/include/asm/crash_reserve.h b/arch/riscv/include/asm/crash_reserve.h
> index 013962e63587..8d7a8fc1d459 100644
> --- a/arch/riscv/include/asm/crash_reserve.h
> +++ b/arch/riscv/include/asm/crash_reserve.h
> @@ -7,5 +7,7 @@
>  #define CRASH_ADDR_LOW_MAX		dma32_phys_limit
>  #define CRASH_ADDR_HIGH_MAX		memblock_end_of_DRAM()
>  
> +#define HAVE_ARCH_CRASHKERNEL_RESERVATION_HIGH
> +
>  extern phys_addr_t memblock_end_of_DRAM(void);
>  #endif
> diff --git a/arch/x86/include/asm/crash_reserve.h b/arch/x86/include/asm/crash_reserve.h
> index 7835b2cdff04..24c2327f9a16 100644
> --- a/arch/x86/include/asm/crash_reserve.h
> +++ b/arch/x86/include/asm/crash_reserve.h
> @@ -26,6 +26,7 @@ extern unsigned long swiotlb_size_or_default(void);
>  #else
>  # define CRASH_ADDR_LOW_MAX     SZ_4G
>  # define CRASH_ADDR_HIGH_MAX    SZ_64T
> +#define HAVE_ARCH_CRASHKERNEL_RESERVATION_HIGH
>  #endif
>  
>  # define DEFAULT_CRASH_KERNEL_LOW_SIZE crash_low_size_default()
> diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
> index 5b2722a93a48..c5213f123e19 100644
> --- a/kernel/crash_reserve.c
> +++ b/kernel/crash_reserve.c
> @@ -306,7 +306,7 @@ int __init parse_crashkernel(char *cmdline,
>  	/* crashkernel=X[@offset] */
>  	ret = __parse_crashkernel(cmdline, system_ram, crash_size,
>  				crash_base, NULL);
> -#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
> +#ifdef HAVE_ARCH_CRASHKERNEL_RESERVATION_HIGH
>  	/*
>  	 * If non-NULL 'high' passed in and no normal crashkernel
>  	 * setting detected, try parsing crashkernel=,high|low.
> 
> 

