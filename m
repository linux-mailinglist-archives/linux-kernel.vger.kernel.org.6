Return-Path: <linux-kernel+bounces-203514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B158FDC60
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 03:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D58BDB22F3B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905561401B;
	Thu,  6 Jun 2024 01:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="J3r+22pC"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522BC179A8
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 01:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717639075; cv=none; b=sSpkCjStbBqA27R4QLFEBREGd93txKYG6l1zFNclAeOKQVoLOupN/iufQZxde0Gpy2W8PeCqs01iWVj52lNPi/fPsYhkNKHdLnCe9rhsClT9nDS23vS8GrY2ARGrxV3Z7uEdOUI8gR9Wj/nMpbifNix/ZSg7PO1BdWuIOLexF3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717639075; c=relaxed/simple;
	bh=Kedn0XvN3fUHJVPqItSvKExWCqOWwSLF67S5nqn3Psc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BlimJRq6Dq+CdJ97TvioY/0M0TAvVKpQl3kB/+TLfhFCBxS+YwVw+1njZOMIStcqkjTDsd1c9ACUeyOajKT4mwWbwT/mIghsiL3aTtDkZuTbkSnd/kIK1rtBGKPrh9TUOxWCM4GX7UfhwNCy8U2TvdK/aRUxE9gvRtYw3t1vaw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=J3r+22pC; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717639069; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=S92oigTI4DbA9DJ4iXLbVTH+mvSy0U0OHozBRnHwsFY=;
	b=J3r+22pCKZfjSP8lJgxsbV0HEgg2oCb7mPC7LNJt24orbmxZcGdos4UekzOZmpwSG4uoH/72uaapqks9bXHXDbQ2K0Dbg0ezzP0nnd8FzOsHlmduCfTAnVj6OZtWFnEoAFXL8W9YKFay9XwWOYGV4bbs9iJlXitw/o/euKVdl2g=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W7wW1k-_1717639067;
Received: from 30.97.56.72(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W7wW1k-_1717639067)
          by smtp.aliyun-inc.com;
          Thu, 06 Jun 2024 09:57:48 +0800
Message-ID: <d6deb928-3466-45ea-939b-cb5aca9bc7b4@linux.alibaba.com>
Date: Thu, 6 Jun 2024 09:57:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/gup: don't check page lru flag before draining it
To: David Hildenbrand <david@redhat.com>, yangge1116 <yangge1116@126.com>,
 akpm@linux-foundation.org, Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, liuzixing@hygon.cn
References: <1717498121-20926-1-git-send-email-yangge1116@126.com>
 <0d7a4405-9a2e-4bd1-ba89-a31486155233@redhat.com>
 <dc7a0b61-8d3f-7205-2f6d-c2b12500947a@126.com>
 <776de760-e817-43b2-bd00-8ce96f4e37a8@redhat.com>
 <7063920f-963a-4b3e-a3f3-c5cc227bc877@redhat.com>
 <48150a28-ed48-49ff-9432-9cd30cda4da4@linux.alibaba.com>
 <11ef3deb-d1e3-46d5-97ed-9ba3c1fbbba9@redhat.com>
 <697a9bc2-a655-4035-aa5e-7d3acb23e79d@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <697a9bc2-a655-4035-aa5e-7d3acb23e79d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/6/5 20:20, David Hildenbrand wrote:
> On 05.06.24 13:41, David Hildenbrand wrote:
>> On 05.06.24 13:37, Baolin Wang wrote:
>>>
>>>
>>> On 2024/6/5 17:53, David Hildenbrand wrote:
>>>> On 05.06.24 11:41, David Hildenbrand wrote:
>>>>> On 05.06.24 03:18, yangge1116 wrote:
>>>>>>
>>>>>>
>>>>>> 在 2024/6/4 下午9:47, David Hildenbrand 写道:
>>>>>>> On 04.06.24 12:48, yangge1116@126.com wrote:
>>>>>>>> From: yangge <yangge1116@126.com>
>>>>>>>>
>>>>>>>> If a page is added in pagevec, its ref count increases one, remove
>>>>>>>> the page from pagevec decreases one. Page migration requires the
>>>>>>>> page is not referenced by others except page mapping. Before
>>>>>>>> migrating a page, we should try to drain the page from pagevec in
>>>>>>>> case the page is in it, however, folio_test_lru() is not sufficient
>>>>>>>> to tell whether the page is in pagevec or not, if the page is in
>>>>>>>> pagevec, the migration will fail.
>>>>>>>>
>>>>>>>> Remove the condition and drain lru once to ensure the page is not
>>>>>>>> referenced by pagevec.
>>>>>>>
>>>>>>> What you are saying is that we might have a page on which
>>>>>>> folio_test_lru() succeeds, that was added to one of the 
>>>>>>> cpu_fbatches,
>>>>>>> correct?
>>>>>>
>>>>>> Yes
>>>>>>
>>>>>>>
>>>>>>> Can you describe under which circumstances that happens?
>>>>>>>
>>>>>>
>>>>>> If we call folio_activate() to move a page from inactive LRU list to
>>>>>> active LRU list, the page is not only in LRU list, but also in one of
>>>>>> the cpu_fbatches.
>>>>>>
>>>>>> void folio_activate(struct folio *folio)
>>>>>> {
>>>>>>          if (folio_test_lru(folio) && !folio_test_active(folio) &&
>>>>>>              !folio_test_unevictable(folio)) {
>>>>>>              struct folio_batch *fbatch;
>>>>>>
>>>>>>              folio_get(folio);
>>>>>>              //After this, folio is in LRU list, and its ref count 
>>>>>> have
>>>>>> increased one.
>>>>>>
>>>>>>              local_lock(&cpu_fbatches.lock);
>>>>>>              fbatch = this_cpu_ptr(&cpu_fbatches.activate);
>>>>>>              folio_batch_add_and_move(fbatch, folio, 
>>>>>> folio_activate_fn);
>>>>>>              local_unlock(&cpu_fbatches.lock);
>>>>>>          }
>>>>>> }
>>>>>
>>>>> Interesting, the !SMP variant does the folio_test_clear_lru().
>>>>>
>>>>> It would be really helpful if we could reliably identify whether LRU
>>>>> batching code has a raised reference on a folio.
>>>>>
>>>>> We have the same scenario in
>>>>> * folio_deactivate()
>>>>> * folio_mark_lazyfree()
>>>>>
>>>>> In folio_batch_move_lru() we do the folio_test_clear_lru(folio).
>>>>>
>>>>> No expert on that code, I'm wondering if we could move the
>>>>> folio_test_clear_lru() out, such that we can more reliably identify
>>>>> whether a folio is on the LRU batch or not.
>>>>
>>>> I'm sure there would be something extremely broken with the following
>>>> (I don't know what I'm doing ;) ), but I wonder if there would be a way
>>>> to make something like that work (and perform well enough?).
>>>>
>>>> diff --git a/mm/swap.c b/mm/swap.c
>>>> index 67786cb771305..642e471c3ec5a 100644
>>>> --- a/mm/swap.c
>>>> +++ b/mm/swap.c
>>>> @@ -212,10 +212,6 @@ static void folio_batch_move_lru(struct 
>>>> folio_batch
>>>> *fbatch, move_fn_t move_fn)
>>>>            for (i = 0; i < folio_batch_count(fbatch); i++) {
>>>>                    struct folio *folio = fbatch->folios[i];
>>>>
>>>> -               /* block memcg migration while the folio moves between
>>>> lru */
>>>> -               if (move_fn != lru_add_fn && 
>>>> !folio_test_clear_lru(folio))
>>>> -                       continue;
>>>> -
>>>>                    folio_lruvec_relock_irqsave(folio, &lruvec, &flags);
>>>>                    move_fn(lruvec, folio);
>>>>
>>>> @@ -255,8 +251,9 @@ static void lru_move_tail_fn(struct lruvec *lruvec,
>>>> struct folio *folio)
>>>>      */
>>>>     void folio_rotate_reclaimable(struct folio *folio)
>>>>     {
>>>> -       if (!folio_test_locked(folio) && !folio_test_dirty(folio) &&
>>>> -           !folio_test_unevictable(folio) && folio_test_lru(folio)) {
>>>> +       if (folio_test_lru(folio) && !folio_test_locked(folio) &&
>>>> +           !folio_test_dirty(folio) && 
>>>> !folio_test_unevictable(folio) &&
>>>> +           folio_test_clear_lru(folio)) {
>>>>                    struct folio_batch *fbatch;
>>>>                    unsigned long flags;
>>>>
>>>> @@ -354,7 +351,7 @@ static void folio_activate_drain(int cpu)
>>>>     void folio_activate(struct folio *folio)
>>>>     {
>>>>            if (folio_test_lru(folio) && !folio_test_active(folio) &&
>>>> -           !folio_test_unevictable(folio)) {
>>>> +           !folio_test_unevictable(folio) &&
>>>> folio_test_clear_lru(folio)) {
>>>
>>> IMO, this seems violate the semantics of the LRU flag, since it's clear
>>> that this folio is still in the LRU list.
>>
>> Good point.
>>
>> But regarding "violation": we already do clear the flag temporarily in
>> there, so it's rather that we make the visible time where it is cleared
>> "longer". (yes, it can be much longer :) )
> 
> Some random thoughts about some folio_test_lru() users:
> 
> mm/khugepaged.c: skips pages if !folio_test_lru(), but would fail skip 
> it either way if there is the unexpected reference from the LRU batch!
> 
> mm/compaction.c: skips pages if !folio_test_lru(), but would fail skip 
> it either way if there is the unexpected reference from the LRU batch!
> 
> mm/memory.c: would love to identify this case and to a lru_add_drain() 
> to free up that reference.
> 
> mm/huge_memory.c: splitting with the additional reference will fail 
> already. Maybe we'd want to drain the LRU batch.

Agree.

> 
> mm/madvise.c: skips pages if !folio_test_lru(). I wonder what happens if 
> we have the same page twice in an LRU batch with different target goals ...

IIUC, LRU batch can ignore this folio since it's LRU flag is cleared by 
folio_isolate_lru(), then will call folios_put() to frop the reference.


> Some other users (there are not that many that don't use it for sanity 
> checks though) might likely be a bit different.

mm/page_isolation.c: fail to set pageblock migratetype to isolate if 
!folio_test_lru(), then alloc_contig_range_noprof() can be failed. But 
the original code could set pageblock migratetype to isolate, then 
calling drain_all_pages() in alloc_contig_range_noprof() to drop 
reference of the LRU batch.

mm/vmscan.c: will call lru_add_drain() before calling 
isolate_lru_folios(), so seems no impact.

BTW, we also need to look at the usage of folio_isolate_lru().

It doesn’t seem to have major obstacles, but there are many details to 
analyze :)

