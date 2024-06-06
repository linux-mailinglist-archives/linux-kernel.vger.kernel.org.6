Return-Path: <linux-kernel+bounces-203888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6A68FE1A9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA2A8B24BBC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2B2149C77;
	Thu,  6 Jun 2024 08:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="JG0a6zGJ"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7201474BD
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717663906; cv=none; b=DTZXTHR+OxAAqNCDkV5m9a6SuSEVVoR4WzQFuXsk+N6Jdjiy5w6QcvDBlIEMGQtw9x2Sm3yo4NdD9OPUG5BPeh+KIQ4K+zjbRY4Fo2R3Cpc3JLXZQety7Q2TxA2ofybWtNA7txkYX73vT+LeehC8FyGPFJLofVal5xDYhgI4v2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717663906; c=relaxed/simple;
	bh=zYHPUSlxpklsO0n6/0IhIw1302QdrsKhm/V7cSysJk8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DKr4Y5qFS6FP4TkVEvcREtSfKZy1HNaWMOo9JSmcdqS1kiMDTuug8YBLbIbDBRQNxguo/nROCevZh4ofHVZnBtB7rOtwPAR89d4BFyE24cwsIE6xaWmUNAyzBbBKu6WRaL/oppJ68G+5IJSNFRIGquw0V3VHrNx2DTsNe+NHvAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=JG0a6zGJ; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version:
	Content-Type; bh=l9dgqjvvyjtqb4tZl+GZ+hz5ridGS7XuFizCC/+kJg8=;
	b=JG0a6zGJdsac0KUjHwfMDue2zbAzSpXiprd2iMLcDRUPd/40d9dDpKY0FhULg9
	c0kitkA9W23noUTOO8WTryEWXdbKkW3XsdLJCE/+7YDT4MuNHTh8aVnx2q2JW72c
	hE+LEJyTXMeJHHRFKbRAKkoJm39xdLS2QusGXZHPY5Y8A=
Received: from [172.21.21.216] (unknown [118.242.3.34])
	by gzga-smtp-mta-g0-0 (Coremail) with SMTP id _____wD3v81LeGFmGm5wBA--.59082S2;
	Thu, 06 Jun 2024 16:50:21 +0800 (CST)
Subject: Re: [PATCH] mm/gup: don't check page lru flag before draining it
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 baolin.wang@linux.alibaba.com, liuzixing@hygon.cn
References: <1717498121-20926-1-git-send-email-yangge1116@126.com>
 <0d7a4405-9a2e-4bd1-ba89-a31486155233@redhat.com>
 <dc7a0b61-8d3f-7205-2f6d-c2b12500947a@126.com>
 <776de760-e817-43b2-bd00-8ce96f4e37a8@redhat.com>
 <7063920f-963a-4b3e-a3f3-c5cc227bc877@redhat.com>
 <a30ee643-8690-16f1-c315-c252d2c16e4a@126.com>
 <19590664-5190-4d30-ba0d-ec9d0ea373d3@redhat.com>
From: yangge1116 <yangge1116@126.com>
Message-ID: <08a54ebe-bf4d-0560-aaa8-a196c6c88276@126.com>
Date: Thu, 6 Jun 2024 16:50:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <19590664-5190-4d30-ba0d-ec9d0ea373d3@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v81LeGFmGm5wBA--.59082S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Aw15ZF1ruFW7Ar4rtr4Dtwb_yoWxXrWrpF
	W8GF1qgFWDJF1UCr42qF1Fyr10kr90qr4UXF47Gry2yFn8tr1DKF47tw15CFsxJr18uF1I
	va4jqFn3WF1YqFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bwoGLUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiWQ71G2VLalhxNQABsg



在 2024/6/6 下午3:39, David Hildenbrand 写道:
> On 06.06.24 03:35, yangge1116 wrote:
>>
>>
>> 在 2024/6/5 下午5:53, David Hildenbrand 写道:
>>> On 05.06.24 11:41, David Hildenbrand wrote:
>>>> On 05.06.24 03:18, yangge1116 wrote:
>>>>>
>>>>>
>>>>> 在 2024/6/4 下午9:47, David Hildenbrand 写道:
>>>>>> On 04.06.24 12:48, yangge1116@126.com wrote:
>>>>>>> From: yangge <yangge1116@126.com>
>>>>>>>
>>>>>>> If a page is added in pagevec, its ref count increases one, remove
>>>>>>> the page from pagevec decreases one. Page migration requires the
>>>>>>> page is not referenced by others except page mapping. Before
>>>>>>> migrating a page, we should try to drain the page from pagevec in
>>>>>>> case the page is in it, however, folio_test_lru() is not sufficient
>>>>>>> to tell whether the page is in pagevec or not, if the page is in
>>>>>>> pagevec, the migration will fail.
>>>>>>>
>>>>>>> Remove the condition and drain lru once to ensure the page is not
>>>>>>> referenced by pagevec.
>>>>>>
>>>>>> What you are saying is that we might have a page on which
>>>>>> folio_test_lru() succeeds, that was added to one of the cpu_fbatches,
>>>>>> correct?
>>>>>
>>>>> Yes
>>>>>
>>>>>>
>>>>>> Can you describe under which circumstances that happens?
>>>>>>
>>>>>
>>>>> If we call folio_activate() to move a page from inactive LRU list to
>>>>> active LRU list, the page is not only in LRU list, but also in one of
>>>>> the cpu_fbatches.
>>>>>
>>>>> void folio_activate(struct folio *folio)
>>>>> {
>>>>>         if (folio_test_lru(folio) && !folio_test_active(folio) &&
>>>>>             !folio_test_unevictable(folio)) {
>>>>>             struct folio_batch *fbatch;
>>>>>
>>>>>             folio_get(folio);
>>>>>             //After this, folio is in LRU list, and its ref count have
>>>>> increased one.
>>>>>
>>>>>             local_lock(&cpu_fbatches.lock);
>>>>>             fbatch = this_cpu_ptr(&cpu_fbatches.activate);
>>>>>             folio_batch_add_and_move(fbatch, folio, 
>>>>> folio_activate_fn);
>>>>>             local_unlock(&cpu_fbatches.lock);
>>>>>         }
>>>>> }
>>>>
>>>> Interesting, the !SMP variant does the folio_test_clear_lru().
>>>>
>>>> It would be really helpful if we could reliably identify whether LRU
>>>> batching code has a raised reference on a folio.
>>>>
>>>> We have the same scenario in
>>>> * folio_deactivate()
>>>> * folio_mark_lazyfree()
>>>>
>>>> In folio_batch_move_lru() we do the folio_test_clear_lru(folio).
>>>>
>>>> No expert on that code, I'm wondering if we could move the
>>>> folio_test_clear_lru() out, such that we can more reliably identify
>>>> whether a folio is on the LRU batch or not.
>>>
>>> I'm sure there would be something extremely broken with the following
>>> (I don't know what I'm doing ;) ), but I wonder if there would be a way
>>> to make something like that work (and perform well enough?).
>>>
>>> diff --git a/mm/swap.c b/mm/swap.c
>>> index 67786cb771305..642e471c3ec5a 100644
>>> --- a/mm/swap.c
>>> +++ b/mm/swap.c
>>> @@ -212,10 +212,6 @@ static void folio_batch_move_lru(struct folio_batch
>>> *fbatch, move_fn_t move_fn)
>>>           for (i = 0; i < folio_batch_count(fbatch); i++) {
>>>                   struct folio *folio = fbatch->folios[i];
>>>
>>> -               /* block memcg migration while the folio moves between
>>> lru */
>>> -               if (move_fn != lru_add_fn && 
>>> !folio_test_clear_lru(folio))
>>> -                       continue;
>>> -
>>>                   folio_lruvec_relock_irqsave(folio, &lruvec, &flags);
>>>                   move_fn(lruvec, folio);
>>>
>>> @@ -255,8 +251,9 @@ static void lru_move_tail_fn(struct lruvec *lruvec,
>>> struct folio *folio)
>>>     */
>>>    void folio_rotate_reclaimable(struct folio *folio)
>>>    {
>>> -       if (!folio_test_locked(folio) && !folio_test_dirty(folio) &&
>>> -           !folio_test_unevictable(folio) && folio_test_lru(folio)) {
>>> +       if (folio_test_lru(folio) && !folio_test_locked(folio) &&
>>> +           !folio_test_dirty(folio) && 
>>> !folio_test_unevictable(folio) &&
>>> +           folio_test_clear_lru(folio)) {
>>>                   struct folio_batch *fbatch;
>>>                   unsigned long flags;
>>>
>>> @@ -354,7 +351,7 @@ static void folio_activate_drain(int cpu)
>>>    void folio_activate(struct folio *folio)
>>>    {
>>>           if (folio_test_lru(folio) && !folio_test_active(folio) &&
>>> -           !folio_test_unevictable(folio)) {
>>> +           !folio_test_unevictable(folio) &&
>>> folio_test_clear_lru(folio)) {
>>>                   struct folio_batch *fbatch;
>>>
>>>                   folio_get(folio);
>>> @@ -699,6 +696,8 @@ void deactivate_file_folio(struct folio *folio)
>>>           /* Deactivating an unevictable folio will not accelerate
>>> reclaim */
>>>           if (folio_test_unevictable(folio))
>>>                   return;
>>> +       if (!folio_test_clear_lru(folio))
>>> +               return;
>>>
>>>           folio_get(folio);
>>>           local_lock(&cpu_fbatches.lock);
>>> @@ -718,7 +717,8 @@ void deactivate_file_folio(struct folio *folio)
>>>    void folio_deactivate(struct folio *folio)
>>>    {
>>>           if (folio_test_lru(folio) && !folio_test_unevictable(folio) &&
>>> -           (folio_test_active(folio) || lru_gen_enabled())) {
>>> +           (folio_test_active(folio) || lru_gen_enabled()) &&
>>> +           folio_test_clear_lru(folio)) {
>>>                   struct folio_batch *fbatch;
>>>
>>>                   folio_get(folio);
>>> @@ -740,7 +740,8 @@ void folio_mark_lazyfree(struct folio *folio)
>>>    {
>>>           if (folio_test_lru(folio) && folio_test_anon(folio) &&
>>>               folio_test_swapbacked(folio) &&
>>> !folio_test_swapcache(folio) &&
>>> -           !folio_test_unevictable(folio)) {
>>> +           !folio_test_unevictable(folio) &&
>>> +           folio_test_clear_lru(folio)) {
>>>                   struct folio_batch *fbatch;
>>>
>>>                   folio_get(folio);
>>
>> With your changes, we will call folio_test_clear_lru(folio) firstly to
>> clear the LRU flag, and then call folio_get(folio) to pin the folio,
>> seems a little unreasonable. Normally, folio_get(folio) is called
>> firstly to pin the page, and then some other functions is called to
>> handle the folio.
> 
> Right, if that really matters (not sure if it does) we could do
> 
> if (folio_test_lru(folio) && ...
>      folio_get(folio);
>      if (!folio_test_clear_lru(folio)) {
>          folio_put(folio)
>      } else {
>          struct folio_batch *fbatch;
>      }
> }
> 

Right, it seems can work.
As discussed above, it will make the visible time where it is cleared
"longer". Other users of lru_add_drain_all() don't check whether folio 
is in lru, seems there's no need to check here.







