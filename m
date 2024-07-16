Return-Path: <linux-kernel+bounces-253323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D87E931F7A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 05:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10C2F281CB5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 03:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA02134A9;
	Tue, 16 Jul 2024 03:52:14 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE09711711
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 03:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721101934; cv=none; b=UDJMwV8CZUqzXhhaodYr/2sf/9/0ZYYqUaiTFMz0rBkKFewXKI87e6zeUuB+3OFZRI5f/lHhf2tz3ygXpnxlk7pBqcZlYm80wnZ5KytLpAmTu8FHEDpzuvk6sEO1yHrfbRnN2hkADEZpScdc9hU9QJ+KIB3vi8CwYGcFBVklNeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721101934; c=relaxed/simple;
	bh=Y5z809XGiZJ3GwvlKxUrERmQBQuxHV1Vv8t1GGkOcvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Hv9gWx3yS1ijHRX7TSLJpUyc/PY75fpPbhG5z2KpSmfcd5lCrMPKOG8J/WWZqVGkVq4Kj/CgzMQo0A4XiQ4q7rAR3ojYWdKVnyv1JAEEPmKziwFcYhqa1u+uEHkxI5CuhUBNu4B9/hOwqVjvlIPwf9w7Cwa17ya8JG3V+1ZqeRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WNQ4J0Sm7z1JCjc;
	Tue, 16 Jul 2024 11:47:12 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 1F49C14041A;
	Tue, 16 Jul 2024 11:52:02 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 11:52:01 +0800
Message-ID: <2cee61df-70fa-9adb-14d9-41d6d17e4ea5@huawei.com>
Date: Tue, 16 Jul 2024 11:52:00 +0800
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
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
> 
> By the way, I am considering changing code to apply generic crashkernel
> reservation to 32bit system. Maybe below draft code can prevent
> crashkernel=,high from being parsed successfully on 32bit system.
> 
> What do you think?

I'll test the below patch on ARM32 an x86_32 sooner.

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

