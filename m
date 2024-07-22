Return-Path: <linux-kernel+bounces-258717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DF9938C12
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B019B1F21AB6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CA916B3B6;
	Mon, 22 Jul 2024 09:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAGy4wrW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2120D16B38D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721640526; cv=none; b=HV8TE9aQstH7AALqMdcMURL2FLUOtzeTsk2JEjx3u7Iu9XW1OwBVL4BdZFunoWHhQ2+HJT/gq6RKFkv0EUYg6TXOMecU59OjTwOFNPlPa9GVUwyYE6bbUBSVAKgKhoy0mftOXGwicmJqlgx0kgEZ3zIQP9BnffZCOMtvPgx1yfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721640526; c=relaxed/simple;
	bh=L5bUTfrXZE1Svfn99KNsFnI0LcGEquBfSerVr0GpQKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZoC+rONSelhcqaxg1M9xr6TRjFxdu1GGZi5syefq2CTUF1aHpv8dCZf9Ke62OaRJyf8Ckb68guQz0R6rdxIwlNnjA+Mcmj6m0k5Ehw4VnngKSoRSdkaisUC8Wspmdj934llVPE86bdxTSYiqAbU5PBoSlmgASc4z5A6ZDUv4ujk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAGy4wrW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8F7C116B1;
	Mon, 22 Jul 2024 09:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721640525;
	bh=L5bUTfrXZE1Svfn99KNsFnI0LcGEquBfSerVr0GpQKc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qAGy4wrWRGEmSwtZEo8UE1qA5yR+nHVSOnTOhRY30P8AHWaKntAOlCRzdGSeUx/j2
	 4dRqccGa1d5b5jXFPgnKw9UZr9pkZMsmuJvroNFPSfn266GBkQMej62pFAjGC+Ck6I
	 dC8ASfgrVN/LEa7Bo2mXje1ZKWGnyEt9w2e7o8L2o9nydENk7kZdUol9gZVvhMJUM8
	 T9ehJZlp9sxX4Yv47VKJ4vdsv2AhLKdhUAADEwthDm472Z50HhySosmbDuNR0UJ3dE
	 PcqCucwFAkxdcnN4Fq4g0VsZhqqkxtb4wxVQWP0f8/fwY/0d76Km1FhUwUPadkk8C9
	 X9/7hhAJmMA5g==
Message-ID: <d535ebaf-1e5a-4f02-9d8b-5231dee317a1@kernel.org>
Date: Mon, 22 Jul 2024 11:28:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/page_alloc: Fix pcp->count race between
 drain_pages_zone() vs __rmqueue_pcplist()
Content-Language: en-US
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
 David Hildenbrand <david@redhat.com>,
 "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
References: <20240722021059.1076399-1-lizhijian@fujitsu.com>
 <8323327f-3386-48ba-8554-10a5a6d12a04@kernel.org>
 <e33a6c42-b7be-46a0-839e-736e8f61102f@fujitsu.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <e33a6c42-b7be-46a0-839e-736e8f61102f@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/24 11:15 AM, Zhijian Li (Fujitsu) wrote:
> Hi David
> 
> Thanks for you quickly reply.
> 
> 
> On 22/07/2024 14:44, Vlastimil Babka (SUSE) wrote:
>> On 7/22/24 4:10 AM, Li Zhijian wrote:
>>> It's expected that no page should be left in pcp_list after calling
>>> zone_pcp_disable() in offline_pages(). Previously, it's observed that
>>> offline_pages() gets stuck [1] due to some pages remaining in pcp_list.
>>>
>>> Cause:
>>> There is a race condition between drain_pages_zone() and __rmqueue_pcplist()
>>> involving the pcp->count variable. See below scenario:
>>>
>>>           CPU0                              CPU1
>>>      ----------------                    ---------------
>>>                                        spin_lock(&pcp->lock);
>>>                                        __rmqueue_pcplist() {
>>> zone_pcp_disable() {
>>>                                          /* list is empty */
>>>                                          if (list_empty(list)) {
>>>                                            /* add pages to pcp_list */
>>>                                            alloced = rmqueue_bulk()
>>>    mutex_lock(&pcp_batch_high_lock)
>>>    ...
>>>    __drain_all_pages() {
>>>      drain_pages_zone() {
>>>        /* read pcp->count, it's 0 here */
>>>        count = READ_ONCE(pcp->count)
>>>        /* 0 means nothing to drain */
>>>                                            /* update pcp->count */
>>>                                            pcp->count += alloced << order;
>>>        ...
>>>                                        ...
>>>                                        spin_unlock(&pcp->lock);
>>>
>>> In this case, after calling zone_pcp_disable() though, there are still some
>>> pages in pcp_list. And these pages in pcp_list are neither movable nor
>>> isolated, offline_pages() gets stuck as a result.
>>>
>>> Solution:
>>> Expand the scope of the pcp->lock to also protect pcp->count in
>>> drain_pages_zone(), to ensure no pages are left in the pcp list after
>>> zone_pcp_disable()
>>>
>>> [1] https://lore.kernel.org/linux-mm/6a07125f-e720-404c-b2f9-e55f3f166e85@fujitsu.com/
>>>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Cc: Vlastimil Babka (SUSE) <vbabka@kernel.org>
>>> Reported-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
>>> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
>> 
>> Can we find a breaking commit for Fixes: ?
> 
> I haven't confirmed the FBC because my reproducer is not fit to run in the old kernel for some reasons.
> but I noticed it didn't read the count without lock held since below commit
> 
> 4b23a68f9536 mm/page_alloc: protect PCP lists with a spinlock
>   
> 
> 
>> 
>>> ---
>>> V2:
>>>      - Narrow down the scope of the spin_lock() to limit the draining latency. # Vlastimil and David
>>>      - In above scenario, it's sufficient to read pcp->count once with lock held, and it fully fixed
>>>        my issue[1] in thounds runs(It happened in more than 5% before).
>> 
>> That should be ok indeed, but...
>> 
>>> RFC:
>>>      https://lore.kernel.org/linux-mm/20240716073929.843277-1-lizhijian@fujitsu.com/
>>> ---
>>>   mm/page_alloc.c | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index 9ecf99190ea2..5388a35c4e9c 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -2323,8 +2323,11 @@ void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
>>>   static void drain_pages_zone(unsigned int cpu, struct zone *zone)
>>>   {
>>>   	struct per_cpu_pages *pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
>>> -	int count = READ_ONCE(pcp->count);
>>> +	int count;
>>>   
>>> +	spin_lock(&pcp->lock);
>>> +	count = pcp->count;
>>> +	spin_unlock(&pcp->lock);
>>>   	while (count) {
>>>   		int to_drain = min(count, pcp->batch << CONFIG_PCP_BATCH_SCALE_MAX);
>>>   		count -= to_drain;
>> 
>> It's wasteful to do a lock/unlock cycle just to read the count.
> 
> How about,
> 
> static void drain_pages_zone(unsigned int cpu, struct zone *zone)
> {
>          struct per_cpu_pages *pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
>          int count, to_drain;
>                                                                                                     
>          do {
>                  spin_lock(&pcp->lock);
>                  to_drain = min(pcp->count, pcp->batch << CONFIG_PCP_BATCH_SCALE_MAX);
>                  free_pcppages_bulk(zone, to_drain, pcp, 0);
>                  spin_unlock(&pcp->lock);
>          } while (to_drain);

Yeah better than break. But I think you still should use
  count = pcp->count;
  ...
  count -= to_drain;
} while(count);

or you make one extra wasteful iteration to find to_drain is zero.
(assuming "it's sufficient to read pcp->count once with lock held", that I
agree with)

> }
>> It could
>> rather look something like this:
>> 
> 
> Sorry, I don't follow your code...
> 
>> while (true)
>>      spin_lock(&pcp->lock);
>>      count = pcp->count;
>>      ...
>>      count -= to_drain;
>>      if (to_drain)
>>          drain_zone_pages(...)
> 
> Which subroutine does this code belong to, why it involves drain_zone_pages

Yeah sorry I meant free_pcppages_bulk()

>>      ...
>>      spin_unlock(&pcp->lock);
>>      if (count)
>>           break;
> 
> Thanks
> Zhijian


