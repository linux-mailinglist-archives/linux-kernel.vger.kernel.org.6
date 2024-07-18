Return-Path: <linux-kernel+bounces-256360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8BC934CF9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 14:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E5C41F21D84
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 12:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A54113B587;
	Thu, 18 Jul 2024 12:11:47 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFFB59164
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 12:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721304707; cv=none; b=Z+uj6MeJeqzUvXdcrLSNnb4EAF1fwQ8ZYsiz7Xqo3pK8LayH2aBjyL7GDYnXETrcfELxe/KyMf7ZZbiZfmydmImBnjqpLYYyo73dgjIxFeI8t1ih28p2CNDVE8mRQseXViL2W10AQlboKVX0s21+DCRAunze++Zhu9+Fs2bwizU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721304707; c=relaxed/simple;
	bh=smLC8HSoky1gAyXDIIvU8mYjvfylHVKxbCcEa0K1XnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Orr/fTGY7x6KHMZM0p4aM8VcIhSbESDhcv2/I0p1PWBa9h9uZ620/6idK9EXrhplWncAMO7kBQYSCFgvlTLPOqM+1HecSwtLSiGswroCigHwTNM8iQDJ8Oj1KpUqbx+gIR3A8YNq5epj2o2LIUzlo9FBkuW5Xi43zvYJ2iqMcK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WPs7T1x7fzdjDQ;
	Thu, 18 Jul 2024 20:09:57 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 7FA0B180087;
	Thu, 18 Jul 2024 20:11:41 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 18 Jul 2024 20:11:40 +0800
Message-ID: <42e69f31-44da-0525-0a79-8d4b5f3e4c57@huawei.com>
Date: Thu, 18 Jul 2024 20:11:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 1/3] crash: Fix x86_32 crash memory reserve dead loop
 bug
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>
CC: <linux@armlinux.org.uk>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <vgoyal@redhat.com>,
	<dyoung@redhat.com>, <arnd@arndb.de>, <afd@ti.com>,
	<linus.walleij@linaro.org>, <akpm@linux-foundation.org>,
	<eric.devolder@oracle.com>, <gregkh@linuxfoundation.org>,
	<javierm@redhat.com>, <deller@gmx.de>, <robh@kernel.org>,
	<hbathini@linux.ibm.com>, <thunder.leizhen@huawei.com>,
	<chenjiahao16@huawei.com>, <linux-kernel@vger.kernel.org>,
	<kexec@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>
References: <20240718035444.2977105-1-ruanjinjie@huawei.com>
 <20240718035444.2977105-2-ruanjinjie@huawei.com>
 <Zpj4OUsTPshBK4JZ@MiWiFi-R3L-srv>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <Zpj4OUsTPshBK4JZ@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi100008.china.huawei.com (7.221.188.57)



On 2024/7/18 19:10, Baoquan He wrote:
> On 07/18/24 at 11:54am, Jinjie Ruan wrote:
>> On x86_32 Qemu machine with 1GB memory, the cmdline "crashkernel=1G,high"
>> will cause system stall as below:
>>
>> 	ACPI: Reserving FACP table memory at [mem 0x3ffe18b8-0x3ffe192b]
>> 	ACPI: Reserving DSDT table memory at [mem 0x3ffe0040-0x3ffe18b7]
>> 	ACPI: Reserving FACS table memory at [mem 0x3ffe0000-0x3ffe003f]
>> 	ACPI: Reserving APIC table memory at [mem 0x3ffe192c-0x3ffe19bb]
>> 	ACPI: Reserving HPET table memory at [mem 0x3ffe19bc-0x3ffe19f3]
>> 	ACPI: Reserving WAET table memory at [mem 0x3ffe19f4-0x3ffe1a1b]
>> 	143MB HIGHMEM available.
>> 	879MB LOWMEM available.
>> 	  mapped low ram: 0 - 36ffe000
>> 	  low ram: 0 - 36ffe000
>> 	 (stall here)
>>
>> The reason is that the CRASH_ADDR_LOW_MAX is equal to CRASH_ADDR_HIGH_MAX
>> on x86_32, the first high crash kernel memory reservation will fail, then
>> go into the "retry" loop and never came out as below.
>>
>> -> reserve_crashkernel_generic() and high is true
>>  -> alloc at [CRASH_ADDR_LOW_MAX, CRASH_ADDR_HIGH_MAX] fail
>>     -> alloc at [0, CRASH_ADDR_LOW_MAX] fail and repeatedly
>>        (because CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX).
>>
>> Fix it by prevent crashkernel=,high from being parsed successfully on 32bit
>> system with a architecture-defined macro.
>>
>> After this patch, the 'crashkernel=,high' for 32bit system can't succeed,
>> and it has no chance to call reserve_crashkernel_generic(), therefore this
>> issue on x86_32 is solved.
>>
>> Fixes: 9c08a2a139fe ("x86: kdump: use generic interface to simplify crashkernel reservation code")
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> Signed-off-by: Baoquan He <bhe@redhat.com>
> 
> Just adding my Suggested-by is fine. If multiple people cooperate on one
> patch, the Co-developed-by tag is needed. As a maintainer, I prefer to
> have the Suggested-by tag in this case.

OK, thank you very much!

> 
>> Tested-by: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> You can't add Tested-by tag for your own patch. When you post patch,
> testing it is your obligation.
> 
> Other than these tag adding concerns, this patch looks good to me. You
> can post v4 to update and add my:

Thank you, I'll fix it next version.

> 
> Acked-by: Baoquan He <bhe@redhat.com>>
>> ---
>> v3:
>> - Fix it as Baoquan suggested.
>> - Update the commit message.
>> v2:
>> - Peel off the other two patches.
>> - Update the commit message and fix tag.
>> ---
>>  arch/arm64/include/asm/crash_reserve.h | 2 ++
>>  arch/riscv/include/asm/crash_reserve.h | 2 ++
>>  arch/x86/include/asm/crash_reserve.h   | 1 +
>>  kernel/crash_reserve.c                 | 2 +-
>>  4 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/include/asm/crash_reserve.h b/arch/arm64/include/asm/crash_reserve.h
>> index 4afe027a4e7b..bf362c1a612f 100644
>> --- a/arch/arm64/include/asm/crash_reserve.h
>> +++ b/arch/arm64/include/asm/crash_reserve.h
>> @@ -7,4 +7,6 @@
>>  
>>  #define CRASH_ADDR_LOW_MAX              arm64_dma_phys_limit
>>  #define CRASH_ADDR_HIGH_MAX             (PHYS_MASK + 1)
>> +
>> +#define HAVE_ARCH_CRASHKERNEL_RESERVATION_HIGH
>>  #endif
>> diff --git a/arch/riscv/include/asm/crash_reserve.h b/arch/riscv/include/asm/crash_reserve.h
>> index 013962e63587..8d7a8fc1d459 100644
>> --- a/arch/riscv/include/asm/crash_reserve.h
>> +++ b/arch/riscv/include/asm/crash_reserve.h
>> @@ -7,5 +7,7 @@
>>  #define CRASH_ADDR_LOW_MAX		dma32_phys_limit
>>  #define CRASH_ADDR_HIGH_MAX		memblock_end_of_DRAM()
>>  
>> +#define HAVE_ARCH_CRASHKERNEL_RESERVATION_HIGH
>> +
>>  extern phys_addr_t memblock_end_of_DRAM(void);
>>  #endif
>> diff --git a/arch/x86/include/asm/crash_reserve.h b/arch/x86/include/asm/crash_reserve.h
>> index 7835b2cdff04..24c2327f9a16 100644
>> --- a/arch/x86/include/asm/crash_reserve.h
>> +++ b/arch/x86/include/asm/crash_reserve.h
>> @@ -26,6 +26,7 @@ extern unsigned long swiotlb_size_or_default(void);
>>  #else
>>  # define CRASH_ADDR_LOW_MAX     SZ_4G
>>  # define CRASH_ADDR_HIGH_MAX    SZ_64T
>> +#define HAVE_ARCH_CRASHKERNEL_RESERVATION_HIGH
>>  #endif
>>  
>>  # define DEFAULT_CRASH_KERNEL_LOW_SIZE crash_low_size_default()
>> diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
>> index 5b2722a93a48..c5213f123e19 100644
>> --- a/kernel/crash_reserve.c
>> +++ b/kernel/crash_reserve.c
>> @@ -306,7 +306,7 @@ int __init parse_crashkernel(char *cmdline,
>>  	/* crashkernel=X[@offset] */
>>  	ret = __parse_crashkernel(cmdline, system_ram, crash_size,
>>  				crash_base, NULL);
>> -#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
>> +#ifdef HAVE_ARCH_CRASHKERNEL_RESERVATION_HIGH
>>  	/*
>>  	 * If non-NULL 'high' passed in and no normal crashkernel
>>  	 * setting detected, try parsing crashkernel=,high|low.
>> -- 
>> 2.34.1
>>
> 
> 

