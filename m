Return-Path: <linux-kernel+bounces-253777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8DF9326CF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 14:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24379B22DC4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 12:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AB119AD4B;
	Tue, 16 Jul 2024 12:46:29 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A249119AA7B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 12:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721133989; cv=none; b=jIQ0yu5KonmiGozSL3eCG4jvjvVj8w+bMrlJHcp1+f5w9ofxRXXz3YN/DL2iXQu4yhHi1M5bjRcZ13g51atd7ttAz5m+Aal0N7fs7otcsvCmgSk/o1+puIVyrwAYR7HUOSf8J8cr0AbmJyVqsisEZnWt+gXL3U1SQvK6Ck2huMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721133989; c=relaxed/simple;
	bh=8k3WO5ru+F25JGslFNUzAI/phFca2bsYFgIMG65zMO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MEemUUd361aUN0XylbfV7hb1fuQGRiVuYHgBBYOZwTSGNH+MappI9h41zSrVcWL44oZ6sICugHcgpBEL+D5TSxsBFhUGtrMFDgQqONt2Gedos6CrTn/fWxsDaoVDnOp0/UTWHWU7nhyJE/Naloa5/WfZC53aeXL6ZC8R3JlEhls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WNf1k6JbTznbJ0;
	Tue, 16 Jul 2024 20:45:46 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F62B1400C9;
	Tue, 16 Jul 2024 20:46:23 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 20:46:23 +0800
Message-ID: <5dba2994-5f38-1410-0f3f-ef04993cc169@huawei.com>
Date: Tue, 16 Jul 2024 20:46:22 +0800
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
To: Baoquan He <bhe@redhat.com>
CC: <akpm@linux-foundation.org>, <vgoyal@redhat.com>, <dyoung@redhat.com>,
	<austindh.kim@gmail.com>, <rmk+kernel@armlinux.org.uk>,
	<kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240713014808.1689915-1-ruanjinjie@huawei.com>
 <ZpU2rJ1aKyqlu8IN@MiWiFi-R3L-srv>
 <ff8d5b8c-088c-9e05-53b2-f86335a18b8f@huawei.com>
 <ZpYRrsSLd2ZpUyff@MiWiFi-R3L-srv>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <ZpYRrsSLd2ZpUyff@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi100008.china.huawei.com (7.221.188.57)



On 2024/7/16 14:22, Baoquan He wrote:
> On 07/16/24 at 11:44am, Jinjie Ruan wrote:
>>
>>
>> On 2024/7/15 22:48, Baoquan He wrote:
>>> On 07/13/24 at 09:48am, Jinjie Ruan wrote:
>>>> On x86_32 Qemu machine with 1GB memory, the cmdline "crashkernel=4G" is ok
>>>> as below:
>>>> 	crashkernel reserved: 0x0000000020000000 - 0x0000000120000000 (4096 MB)
>>>>
>>>> And on Qemu vexpress-a9 with 1GB memory, the crash kernel "crashkernel=4G"
>>>> is also ok as below:
>>>> 	Reserving 4096MB of memory at 2432MB for crashkernel (System RAM: 1024MB)
>>>>
>>>> The cause is that the crash_size is parsed and printed with "unsigned long
>>>> long" data type which is 8 bytes but allocated used with "phys_addr_t"
>>>> which is 4 bytes in memblock_phys_alloc_range().
>>>>
>>>> Fix it by limiting the "crash_size" to phys_addr_t and bypass the invalid
>>>> input size.
>>>
>>> I am not sure if this is a good idea. Shouldn't we handle this in
>>> arch_reserve_crashkernel() to check the system RAM size?
>>>
>>> With this patch, if you specify crashkernel=4352M (namely 4G+256M) in
>>> kernel cmdline, then you will reserve 256M crashkernel in system, don't
>>> you think that is confusing?
>>
>> You are right!
>>
>> In the case you mentioned, it can still allocate 256M successfully, but
>> the log shows 4352M successfully allocated, which is not taken into
>> account by this patch.
>>
>> And handle this in arch_reserve_crashkernel() is a good idea, which will
>>  bypass all these corner case, I'll do it next version.
>>
>>>
>>> By the way, I am considering changing code to apply generic crashkernel
>>> reservation to 32bit system. Maybe below draft code can prevent
>>> crashkernel=,high from being parsed successfully on 32bit system.
>>>
>>> What do you think?
>>
>> I agree with you, I've thought about passing in a parameter in the
>> generic interface whether high is supported or not to implement it,
>> which is so incompatible. An architecture-defined macro to filter out
>> parsing of "high" fundamentally avoid using the generic interface to
>> allocate memory in "high" for the architecture that does not support
>> "high". The below code do prevent "crashkernel=,high" from being parsed
>> successfully on 32bit system.
>>
>> But if it is to support 32 bit system to use generic crash memory
>> reserve interface, reserve_crashkernel_generic() needs more modification
>> , as it may try to allocate memory at high.
> 
> You are right. Below change may be able to fix that. 
> 
> And I have been thinking if one case need be taken off in which the
> first attempt was for high memory, then fall back to low memory. Surely,
> this is not related to the 32bit crashkernel reservation.

It seems that ARM64 has the possibility before the refactoring. However,
x86 supports only the "low" -> "high" retry but not the "high" -> "low"
retry before the refactoring. In my opinion, "low" -> "high" retry is
more usefull, but I'm not sure if we should get rid of the other way.

> 
> By the way, do you figure out these issues from code reading and qemu
> testing, or there's need for deploying kdump on 32bit system, e.g i386
> or arm32? Just curious.

I found these problems during testing on QEMU when trying to support
this generic crash memory retention on ARM32, and I further found that
x86_32 also has the same problem by code reading and uncommon
configuration test.

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

