Return-Path: <linux-kernel+bounces-407124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B049C6921
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 07:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCEA1281794
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 06:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D8215D5A1;
	Wed, 13 Nov 2024 06:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QGoQpMB4"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FDD17625F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 06:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731478503; cv=none; b=ckQQsK5moeGI7v0mB6a0Mplu6nDSQIfBm8jTa4+acuc0BE9w+BKDsNkl/3R7++qL/r8Hk4ynVmO12p9QgIDSyV8aaX5PBD/aJRsO8pblhwftCXhmqsxe2YDCeGczTTKGwHb0znPEmimFQWZrNBGu+1oFq8CwJUoVHyl3iqF/2g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731478503; c=relaxed/simple;
	bh=v6xHIJGaZy2hO2FdCwhlrrQlKleeqLbI6AWuv06zolY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DuwxtS7pcCmX+7DIWmbpWe37ych9YMouwQUuOGVnLxvU/Vzg5IrdmR7bOTardzDH7AEixA3BeTa7pA88HNqytRAAf1U9GzU9Iz5DFuR5pzfirTP/T6BHalDA147W6jwuFZHS5QkPGhesjRoqIUjsDHiVrf8zERUh1REwSiV5Wao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QGoQpMB4; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a2bcfd4a-8276-2544-7a1a-367635e031c6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731478498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iznfGCpYbJwUp5ETkMWKQlT7qKI0pW/GHJyy2cYs/dc=;
	b=QGoQpMB4YgFerLeeRk2DN/3v3YRAEtXtw0Dy/PjKhdfVk+Yxy8MSsCb+/d3OGU6SRkUBJZ
	JAKKHhnluLLmpD+YrWrlP/TT2pUZKhVEqMsdhXa7TTEIXkTiG4of7+OkslOAIA5sn7pIcP
	sRg4V2bHcbQrLkGuIlh083c1Qg2zeqw=
Date: Wed, 13 Nov 2024 14:14:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] lib/alloc_tag: Remove the sysctl configuration to prevent
 users from disabling it at runtime
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, Hao Ge <gehao@kylinos.cn>
References: <20241108075004.131911-1-hao.ge@linux.dev>
 <CAJuCfpEp_3Dz32fdpUaUbPaP6KZ+0fXmXBvBV1jRt9Q+LMRQAQ@mail.gmail.com>
 <71703c20-8311-ce3f-fbed-27d2ec3a2c82@linux.dev>
 <tcz7mmykp7wi4h3cezhbh53wmsabzvd5shejae6vrku7haynzl@4te6hgxve3s2>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <tcz7mmykp7wi4h3cezhbh53wmsabzvd5shejae6vrku7haynzl@4te6hgxve3s2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 11/13/24 02:14, Kent Overstreet wrote:
> On Tue, Nov 12, 2024 at 11:30:39AM +0800, Hao Ge wrote:
>> Hi Suren
>>
>>
>> Firstly, please forgive me for my improper wording in the commit message.
>>
>> After sending it, I realized that I should have used "suggestion" instead of
>> "decided".
>>
>> Secondly, please forgive me for taking a few days to respond. I've been
>> quite busy these days.
>>
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
>> Actually, my original intention was also to make /proc/allocinfo empty when
>> disabling it,
>>
>> but I considered the following scenario: after we disable it and clear
>> /proc/allocinfo,
>>
>> we then start a memory-intensive application,
>>
>> such as our OOM (Out-Of-Memory) test program.
>>
>> If we later enable it again, the issue described in my commit message would
>> still arise.
>>
>> Perhaps we need to further consider how to handle this situation.
> Why would you do such a thing?
>
> We put a lot of effort into making memory allocation profiling cheap
> enough to leave on, and I haven't seen a single complaint about
> performance overhead.


Hi Kent


Thank you very much for your and Suren's hard work.

For me, this feature is still very useful

As I mentioned in my previous reply to Suren's email, I did overlook 
some things, and for that, I apologize.


Thanks

Best regards

Hao



