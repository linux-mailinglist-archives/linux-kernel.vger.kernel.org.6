Return-Path: <linux-kernel+bounces-407118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 061209C6915
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 07:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4065AB24B74
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 06:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214D217107F;
	Wed, 13 Nov 2024 06:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gXzFZJfm"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0036D10F1
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 06:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731478057; cv=none; b=U2kC6lS9GlaFfkHrcRGMgm9CjDnaIdDMJcVb+mOGe13sWxlYw8I3Yx0zz5rJ+hmyuCKVOp/Ias2sIj+8toNd9SaLUsDS2ielpoEYaNOH07H5NdQnNpEZLHz3osRRxiM9IgLDJDsCSSUZmiSyURegJye6KW5ONON4jHqTvzL5CqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731478057; c=relaxed/simple;
	bh=XZMhijhRb3IuxjJT4NqdQeSFH8I705uMyWart2p7tHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QSQozskceeYpXzb3VZ9XhNKmkkOQOkeifa6KJhfHEUjJTkfErXZUZwrTJN1h3Bwq44aCfOlxDc+Zgx2N4U1HiNJJhKt6dokk8XOqYNJrmclTX/uGW4AY+PhiqvnuWwTG//X4NpbKz8A62Wkpcnu/77YYd+3BuP4EAwMhVCoNv6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gXzFZJfm; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <53bd8343-7b3c-1fb0-6524-4d8f6763ad07@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731478051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eje8MhYnLHzRt5A+hGT1S6lJyvS9D/C/LgMzq1mDSAk=;
	b=gXzFZJfmw1wK8b+Gzg4pRiooM4ldDSQjS2hKHFTclyqH8b03KdZzb5/FjMfxdBuMbVMYHu
	340bjxCorbNGZQGn2HOEga48V2VwnrZgySO3HL7ndRmFanF3zeAnDcF4fi5e9wW3ZntjG3
	p/xDeyalVrECHMMLcDcxGD39eS8ELJY=
Date: Wed, 13 Nov 2024 14:07:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] lib/alloc_tag: Remove the sysctl configuration to prevent
 users from disabling it at runtime
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, Hao Ge <gehao@kylinos.cn>
References: <20241108075004.131911-1-hao.ge@linux.dev>
 <CAJuCfpEp_3Dz32fdpUaUbPaP6KZ+0fXmXBvBV1jRt9Q+LMRQAQ@mail.gmail.com>
 <71703c20-8311-ce3f-fbed-27d2ec3a2c82@linux.dev>
 <CAJuCfpGpU6TsbbFvR2pw54YFg17+od3BLtxLoxRY_6o6mhopyA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <CAJuCfpGpU6TsbbFvR2pw54YFg17+od3BLtxLoxRY_6o6mhopyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 11/12/24 23:26, Suren Baghdasaryan wrote:
> On Mon, Nov 11, 2024 at 7:31 PM Hao Ge <hao.ge@linux.dev> wrote:
>> Hi Suren
>>
>>
>> Firstly, please forgive me for my improper wording in the commit message.
>>
>> After sending it, I realized that I should have used "suggestion"
>> instead of "decided".
>>
>> Secondly, please forgive me for taking a few days to respond. I've been
>> quite busy these days.
> No worries.
>
>>
>> Let's continue to discuss this issue.
>>
>>
>> On 11/9/24 02:16, Suren Baghdasaryan wrote:
>>> On Thu, Nov 7, 2024 at 11:50 PM Hao Ge <hao.ge@linux.dev> wrote:
>>>> From: Hao Ge <gehao@kylinos.cn>
>>>>
>>>> After much consideration,I have decided to remove
>>>> the "mem_profiling" sysctl interface to prevent
>>>> users from dynamically enabling or disabling the
>>>> MEMORY ALLOCATION PROFILING feature at runtime.
>>>>
>>>> I have taken the following actions: I set
>>>> CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=y to
>>>> enable memory allocation profiling by default,
>>>> and then made adjustments to mem_profiling dynamically
>>>> during runtime.
>>>>
>>>> When I ran the OOM test program, I obtained useful
>>>> information that was indeed very helpful for debugging.
>>>>
>>>> [ 1023.065402] Memory allocations:
>>>> [ 1023.065407]     12.8 GiB     6546 mm/huge_memory.c:1328 func:do_huge_pmd_anonymous_page
>>>> [ 1023.065412]      873 MiB   229985 arch/arm64/mm/fault.c:986 func:vma_alloc_zeroed_movable_folio
>>>> [ 1023.065415]      187 MiB    29732 mm/slub.c:2412 func:alloc_slab_page
>>>> [ 1023.065418]     99.8 MiB    25560 mm/memory.c:1065 func:folio_prealloc
>>>> [ 1023.065421]     47.2 MiB     3189 mm/readahead.c:434 func:ra_alloc_folio
>>>> [ 1023.065424]     30.0 MiB       15 mm/khugepaged.c:1072 func:alloc_charge_folio
>>>> [ 1023.065428]     28.6 MiB      514 mm/compaction.c:1880 func:compaction_alloc
>>>> [ 1023.065430]     25.8 MiB     6592 mm/page_ext.c:271 func:alloc_page_ext
>>>> [ 1023.065433]     25.6 MiB     6546 mm/huge_memory.c:1161 func:__do_huge_pmd_anonymous_page
>>>> [ 1023.065436]     23.5 MiB     6017 mm/shmem.c:1771 func:shmem_alloc_folio
>>>>
>>>> After running echo 0 > /proc/sys/vm/mem_profiling
>>>> and then executing the same test program,
>>>> I obtained the following results
>>>>
>>>> [ 1156.509699] Memory allocations:
>>>> [ 1156.509703]      187 MiB    29645 mm/slub.c:2412 func:alloc_slab_page
>>>> [ 1156.509707]      142 MiB     9357 mm/readahead.c:434 func:ra_alloc_folio
>>>> [ 1156.509710]      136 MiB    41325 arch/arm64/mm/fault.c:986 func:vma_alloc_zeroed_movable_folio
>>>> [ 1156.509713]     99.7 MiB    25531 mm/memory.c:1065 func:folio_prealloc
>>>> [ 1156.509716]     56.0 MiB       28 mm/huge_memory.c:1328 func:do_huge_pmd_anonymous_page
>>>> [ 1156.509719]     30.0 MiB       15 mm/khugepaged.c:1072 func:alloc_charge_folio
>>>> [ 1156.509723]     28.6 MiB      514 mm/compaction.c:1880 func:compaction_alloc
>>>> [ 1156.509725]     26.3 MiB     7460 mm/readahead.c:264 func:page_cache_ra_unbounded
>>>> [ 1156.509728]     25.8 MiB     6592 mm/page_ext.c:271 func:alloc_page_ext
>>>> [ 1156.509730]     23.5 MiB     6016 mm/shmem.c:1771 func:shmem_alloc_folio
>>>>
>>>> Because mem_profiling was disabled by executing
>>>> echo 0 > /proc/sys/vm/mem_profiling,we are unable to
>>>> record memory allocation information after the disablement.
>>> Naturally you are unable to track the allocations after disabling it.
>>> You disabled it as root, so I assume you know what you are doing.
>>>
>>>> These output logs can mislead users. And similarly, the same
>>>> applies to alloc_info.
>>> I would understand if you made /proc/allocinfo empty after disabling
>>> it to avoid confusing the user, but ripping out the ability to
>>> enable/disable profiling at runtime does not make sense to me. Once
>>> you collect required data, disabling profiling gets you back the
>>> performance that you pay for it. There are usecases when a program on
>>> a remote device periodically enables profiling for some time, records
>>> the difference in allocations and then disables it. Your change breaks
>>> such users.
>>
>> Actually, my original intention was also to make /proc/allocinfo empty
>> when disabling it,
>>
>> but I considered the following scenario: after we disable it and clear
>> /proc/allocinfo,
>>
>> we then start a memory-intensive application,
>>
>> such as our OOM (Out-Of-Memory) test program.
>>
>> If we later enable it again, the issue described in my commit message
>> would still arise.
> The absolute values won't mean anything once profiling is disabled. In
> cases when profiling gets disabled, the only useful way to use it
> again is to enable it and record the initial states, let your workload
> run, capture the states after the workload is complete and compare it
> with the recorded initial state. Deltas can be useful, the absolute
> values would not matter.
> But maybe I'm not getting your usecase. Could you please explain what
> you are trying to achieve and what are your expectations of how
> profiling should act?
> Thanks,
> Suren.

Hi Suren

Thank you for your patient discussion on this matter.

For me, this tool is very useful for analyzing certain memory issues.

For a server product, there may be more than one system administrator 
(i.e., more than one root user).

Perhaps Administrator A turned it off, but Administrator B was unaware 
of this, which led to confusion about the logs I mentioned.

After your and Kent's patient explanations, I now understand that this 
switch indeed serves a purpose.

Thank you both for your answers, which have deepened my understanding.

For example, if I want to analyze the memory usage from initialization 
to the present,

disabled can help me eliminate the impact of subsequent changes.

My initial idea and this patch had some flaws. Indeed, we only need to 
provide the appropriate functions for users to choose from,

and it is up to them to decide how to use them.


Thank you very much for teaching me something new.


Thanks

Best regards

Hao


>> Perhaps we need to further consider how to handle this situation.
>>
>> Thanks Best regards Hao
>>
>>>> We already have boot parameters that allow users to
>>>> choose whether to enable or disable.
>>>> In order to maintain the accuracy of memory allocation
>>>> information,I have decided to remove the runtime switch.
>>> Well, I disagree with your decision.
>>> NAK.
>>>
>>>> Signed-off-by: Hao Ge <gehao@kylinos.cn>
>>>> ---
>>>>    lib/alloc_tag.c | 26 --------------------------
>>>>    1 file changed, 26 deletions(-)
>>>>
>>>> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
>>>> index 81e5f9a70f22..47fa969c23f3 100644
>>>> --- a/lib/alloc_tag.c
>>>> +++ b/lib/alloc_tag.c
>>>> @@ -227,31 +227,6 @@ struct page_ext_operations page_alloc_tagging_ops = {
>>>>    };
>>>>    EXPORT_SYMBOL(page_alloc_tagging_ops);
>>>>
>>>> -#ifdef CONFIG_SYSCTL
>>>> -static struct ctl_table memory_allocation_profiling_sysctls[] = {
>>>> -       {
>>>> -               .procname       = "mem_profiling",
>>>> -               .data           = &mem_alloc_profiling_key,
>>>> -#ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
>>>> -               .mode           = 0444,
>>>> -#else
>>>> -               .mode           = 0644,
>>>> -#endif
>>>> -               .proc_handler   = proc_do_static_key,
>>>> -       },
>>>> -};
>>>> -
>>>> -static void __init sysctl_init(void)
>>>> -{
>>>> -       if (!mem_profiling_support)
>>>> -               memory_allocation_profiling_sysctls[0].mode = 0444;
>>>> -
>>>> -       register_sysctl_init("vm", memory_allocation_profiling_sysctls);
>>>> -}
>>>> -#else /* CONFIG_SYSCTL */
>>>> -static inline void sysctl_init(void) {}
>>>> -#endif /* CONFIG_SYSCTL */
>>>> -
>>>>    static int __init alloc_tag_init(void)
>>>>    {
>>>>           const struct codetag_type_desc desc = {
>>>> @@ -264,7 +239,6 @@ static int __init alloc_tag_init(void)
>>>>           if (IS_ERR(alloc_tag_cttype))
>>>>                   return PTR_ERR(alloc_tag_cttype);
>>>>
>>>> -       sysctl_init();
>>>>           procfs_init();
>>>>
>>>>           return 0;
>>>> --
>>>> 2.25.1
>>>>

