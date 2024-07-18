Return-Path: <linux-kernel+bounces-256358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8C9934CF1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 14:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07A0FB21534
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 12:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E3113B2A4;
	Thu, 18 Jul 2024 12:10:36 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D98A12C473
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 12:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721304635; cv=none; b=CIyo0W1mwQ8/k3K80llSIhm26J0tYAuSeHe3G/5vOsrg6wz7JaqDBeXrsRx9szE22rz3GBJdzfIWiHQdPPBgfSirpeAGtEgHUPvePg2R/bG+VDQpDX1BVkGY7P/GY77YCLAPim85+yh2WTnnmZguASRpNSr7mAjl9NlgKauAOZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721304635; c=relaxed/simple;
	bh=bpayFljAYTOCRkgTH2zEezy/11pG8Q1CLTDj0tOiq/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rF0SMs7ynOZO7bMRV9CQIVzmaGMQqkKk65Ac4fqcl6rYnxrJz7ObyKVqIoa9Qdf6VvRGy0+wGRFAcq5fJjtXEM6eXTybAkbqzPdNXUKWq1OiO8oukve7TYVPtH0eyrJsuo5xZ6kM/Uwx47B/YOGbngx/RsHPM9ardt0hXpalIdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WPs5z63W3zdjDq;
	Thu, 18 Jul 2024 20:08:39 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 1932B140109;
	Thu, 18 Jul 2024 20:10:24 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 18 Jul 2024 20:10:22 +0800
Message-ID: <aca0795c-f1a8-20c1-3daf-7f39d2ebf1bc@huawei.com>
Date: Thu, 18 Jul 2024 20:10:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 2/3] crash: Fix x86_32 crash memory reserve dead loop
 bug at high
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
 <20240718035444.2977105-3-ruanjinjie@huawei.com>
 <Zpj4+G5OwTYBQGIA@MiWiFi-R3L-srv>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <Zpj4+G5OwTYBQGIA@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi100008.china.huawei.com (7.221.188.57)



On 2024/7/18 19:14, Baoquan He wrote:
> On 07/18/24 at 11:54am, Jinjie Ruan wrote:
> 
> I don't fully catch the subject, what does the 'dead loop bug at high'
> mean?

It means alloc at [CRASH_ADDR_LOW_MAX, CRASH_ADDR_HIGH_MAX] repeatedly
which corresponds to the crashkernel parameter of the "high".

> 
>> On x86_32 Qemu machine with 1GB memory, the cmdline "crashkernel=512M" will
>> also cause system stall as below:
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
>> 	  (stall here)
>>
>> The reason is that the CRASH_ADDR_LOW_MAX is equal to CRASH_ADDR_HIGH_MAX
>> on x86_32, the first "low" crash kernel memory reservation for 512M fails,
>> then it go into the "retry" loop and never came out as below (consider
>> CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX = 512M):
>>
>> -> reserve_crashkernel_generic() and high is false
>>    -> alloc at [0, 0x20000000] fail
>>       -> alloc at [0x20000000, 0x20000000] fail and repeatedly
>>       (because CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX).
>>
>> Fix it by skipping meaningless calls of memblock_phys_alloc_range() with
>> `start = end`
>>
>> After this patch, the retry dead loop is avoided and print below info:
>> 	cannot allocate crashkernel (size:0x20000000)
>>
>> And apply generic crashkernel reservation to 32bit system will be ready.
>>
>> Fixes: 9c08a2a139fe ("x86: kdump: use generic interface to simplify crashkernel reservation code")
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> Signed-off-by: Baoquan He <bhe@redhat.com>
>> Tested-by: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> Also the tag issues, please update.
> 
> Other than above concerns, the patch looks good to me.

Thank you for your review, I'll fix it.

> 
>> ---
>> v3:
>> - Fix it as Baoquan suggested.
>> - Update the commit message.
>> ---
>>  kernel/crash_reserve.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
>> index c5213f123e19..dacc268429e2 100644
>> --- a/kernel/crash_reserve.c
>> +++ b/kernel/crash_reserve.c
>> @@ -414,7 +414,8 @@ void __init reserve_crashkernel_generic(char *cmdline,
>>  			search_end = CRASH_ADDR_HIGH_MAX;
>>  			search_base = CRASH_ADDR_LOW_MAX;
>>  			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
>> -			goto retry;
>> +			if (search_base != search_end)
>> +				goto retry;
>>  		}
>>  
>>  		/*
>> -- 
>> 2.34.1
>>
> 
> 

