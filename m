Return-Path: <linux-kernel+bounces-255850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D699345AE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 03:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 874DF1C213B8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 01:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8411B86CB;
	Thu, 18 Jul 2024 01:20:54 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DEA4A0A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 01:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721265654; cv=none; b=kZ22RxfJY5liREHAGzMX67iezSwU7gpn355gwtpQb8DmVP8INNcURvLS7o4PXviuuKmWHmYIK1iakvjRQlgTbVJNHlI8Pm/Fqi/Zotw8GjZz/tgDgSOcjhgb8Pul8dqeO/AucuWpzY6c31lTqfQkKUJpBo/LunuGmAdw9rx8wLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721265654; c=relaxed/simple;
	bh=Jg5Aoae1esaeX8ATJo72dY58/SLCW2WI/kN1mSt2eQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GGrJo9kndHeK1FbW1YGZEiRm7WqxmvWZ176pCwDK6+z7xiVD8DB2WbFNKrdg3HkkR3ZOzXzNaKn1nsmNUE/Ze39t/0xbECdYSiuJ6Gg26bcftbLOrw0NCgA8dPSKR8shXufAXeRT9oQONeEwGW0Djs3FLKolCv8Xp6inRUk9OAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WPZdL5JWNz1X4jH;
	Thu, 18 Jul 2024 09:16:22 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 418D01402D0;
	Thu, 18 Jul 2024 09:20:42 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 18 Jul 2024 09:20:41 +0800
Message-ID: <5193478a-b72c-0f96-a34b-c467f02effb5@huawei.com>
Date: Thu, 18 Jul 2024 09:20:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next] crash: fix x86_32 memory reserve dead loop retry
 bug at "high"
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>
CC: <vgoyal@redhat.com>, <dyoung@redhat.com>, <akpm@linux-foundation.org>,
	<kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240717070904.2671147-1-ruanjinjie@huawei.com>
 <ZpfJYcjZ0QmFUpPf@MiWiFi-R3L-srv>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <ZpfJYcjZ0QmFUpPf@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi100008.china.huawei.com (7.221.188.57)



On 2024/7/17 21:38, Baoquan He wrote:
> On 07/17/24 at 03:09pm, Jinjie Ruan wrote:
>> Similar to commit 8f9dade5906a ("crash: fix x86_32 memory reserve dead loop
>> retry bug") and in the symmetry case, on x86_32 Qemu machine with
>> 1GB memory, the cmdline "crashkernel=512M" will also cause system stall
>> as below:
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
>> Fix it by also changing the another out check condition, the fixed base
>> situation has no problem because it warn out if it fail to alloc.
>>
>> After this patch, it prints:
>> 	cannot allocate crashkernel (size:0x20000000)
>>
>> Fixes: 9c08a2a139fe ("x86: kdump: use generic interface to simplify crashkernel reservation code")
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  kernel/crash_reserve.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
>> index 03e455738e75..36c13cf942f4 100644
>> --- a/kernel/crash_reserve.c
>> +++ b/kernel/crash_reserve.c
>> @@ -409,7 +409,7 @@ void __init reserve_crashkernel_generic(char *cmdline,
>>  		 * low memory, fall back to high memory, the minimum required
>>  		 * low memory will be reserved later.
>>  		 */
>> -		if (!high && search_end == CRASH_ADDR_LOW_MAX) {
>> +		if (!high && !search_base) {
> 
> Hmm, this may not be good. We can't guarantee that CRASH_ADDR_LOW_MAX must
> not be 0. I still suggest you testing below draft patch to see if it works
> well. And we should revert the patch in Andrew's tree since it's not good.
> Posting like these mess will confuse people and add difficulty when
> backporting.

OK，let me get this straight and test your draft patches, if it is ok,
I'll send them sooner.

> 
> You haven't responded to my earlier request to test those two draft
> patches. When you tested below code and it's good, you can post this as
> a formal patch. So my suggestion to the whole work is:
> 
> 1) revert commit 8f9dade5906a in Andrew's tree;
> 
> 2) post two patches I suggested to prevert crashkernel=,high for 32bit
> system, and fix the issue you found;
> 
> 3) post patchset to make arm32 use generic crashkernel reservation.

Sorry, I didn't quite understand your real intentions before. Thanks for
the suggestion. I'll retest and submit the patch based on your suggestion.

> 
> diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
> index 5b2722a93a48..ac087ba442cd 100644
> --- a/kernel/crash_reserve.c
> +++ b/kernel/crash_reserve.c
> @@ -414,7 +414,8 @@ void __init reserve_crashkernel_generic(char *cmdline,
>  			search_end = CRASH_ADDR_HIGH_MAX;
>  			search_base = CRASH_ADDR_LOW_MAX;
>  			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> -			goto retry;
> +			if (search_base != search_end)
> +				goto retry;
>  		}
>  
>  		/*
> 
> 

