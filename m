Return-Path: <linux-kernel+bounces-202268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D26B8FCA86
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 740452834C6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F19C14D6EF;
	Wed,  5 Jun 2024 11:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fXXDREDu"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD7014D44D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 11:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717587488; cv=none; b=j9HTkgoSCy7qXvBvtcrjac10Ox4cMETyfTUcwewZRQPGzqBC7rOyhflYBXuH/B63yjdLQXS50+TG95fSiKN2kQnc/N7zagwawklNJRkB6SfZMWtPCtpkkWZYqraszFnzhBiJxMatfg04ivsYelpCEcfMoFKVZnwHAQCDdfaPipc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717587488; c=relaxed/simple;
	bh=s58dkB+y+5nc3n6LHhvCXb8auxIBJEAPQ/VL7Kyjni8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nuBs/iQsyf3G2Z2Pb1DyotfYH+jZtjiwGDxZMjf6AwT2WL3R4OF4gyNZKMvXXthnfQuFhaME75FZ/NSKce2uFuHyWDp4ohv9LwgGN6FWJwd6qWFulwzclNYKzMrC+zmWZsvps12l8pL9xpooASQZfri5G23ycmURbr1skVRoWbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fXXDREDu; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717587477; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=GQClWKdIZ+BJLdneee1gIM/rhZDMeoYKUCGbcbAUpmA=;
	b=fXXDREDuQdHjR97hdequiylY76V9zmlgKFJiqA/j+pfbRBkzoaRZZvNWegdnVy/o0m7Hbz2OzzihBkfZCRDpY4w0XQq4U3Z/3TYsL4wYbTTEPqoPFIPKCifK2zVKlC6va5LCmrLa2VQDqr8Kt/4zbSOMtlDi2BrLXKf9uBvpziE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W7v6r4V_1717587475;
Received: from 30.97.56.61(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W7v6r4V_1717587475)
          by smtp.aliyun-inc.com;
          Wed, 05 Jun 2024 19:37:56 +0800
Message-ID: <48150a28-ed48-49ff-9432-9cd30cda4da4@linux.alibaba.com>
Date: Wed, 5 Jun 2024 19:37:55 +0800
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
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <7063920f-963a-4b3e-a3f3-c5cc227bc877@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/6/5 17:53, David Hildenbrand wrote:
> On 05.06.24 11:41, David Hildenbrand wrote:
>> On 05.06.24 03:18, yangge1116 wrote:
>>>
>>>
>>> 在 2024/6/4 下午9:47, David Hildenbrand 写道:
>>>> On 04.06.24 12:48, yangge1116@126.com wrote:
>>>>> From: yangge <yangge1116@126.com>
>>>>>
>>>>> If a page is added in pagevec, its ref count increases one, remove
>>>>> the page from pagevec decreases one. Page migration requires the
>>>>> page is not referenced by others except page mapping. Before
>>>>> migrating a page, we should try to drain the page from pagevec in
>>>>> case the page is in it, however, folio_test_lru() is not sufficient
>>>>> to tell whether the page is in pagevec or not, if the page is in
>>>>> pagevec, the migration will fail.
>>>>>
>>>>> Remove the condition and drain lru once to ensure the page is not
>>>>> referenced by pagevec.
>>>>
>>>> What you are saying is that we might have a page on which
>>>> folio_test_lru() succeeds, that was added to one of the cpu_fbatches,
>>>> correct?
>>>
>>> Yes
>>>
>>>>
>>>> Can you describe under which circumstances that happens?
>>>>
>>>
>>> If we call folio_activate() to move a page from inactive LRU list to
>>> active LRU list, the page is not only in LRU list, but also in one of
>>> the cpu_fbatches.
>>>
>>> void folio_activate(struct folio *folio)
>>> {
>>>        if (folio_test_lru(folio) && !folio_test_active(folio) &&
>>>            !folio_test_unevictable(folio)) {
>>>            struct folio_batch *fbatch;
>>>
>>>            folio_get(folio);
>>>            //After this, folio is in LRU list, and its ref count have
>>> increased one.
>>>
>>>            local_lock(&cpu_fbatches.lock);
>>>            fbatch = this_cpu_ptr(&cpu_fbatches.activate);
>>>            folio_batch_add_and_move(fbatch, folio, folio_activate_fn);
>>>            local_unlock(&cpu_fbatches.lock);
>>>        }
>>> }
>>
>> Interesting, the !SMP variant does the folio_test_clear_lru().
>>
>> It would be really helpful if we could reliably identify whether LRU
>> batching code has a raised reference on a folio.
>>
>> We have the same scenario in
>> * folio_deactivate()
>> * folio_mark_lazyfree()
>>
>> In folio_batch_move_lru() we do the folio_test_clear_lru(folio).
>>
>> No expert on that code, I'm wondering if we could move the
>> folio_test_clear_lru() out, such that we can more reliably identify
>> whether a folio is on the LRU batch or not.
> 
> I'm sure there would be something extremely broken with the following
> (I don't know what I'm doing ;) ), but I wonder if there would be a way
> to make something like that work (and perform well enough?).
> 
> diff --git a/mm/swap.c b/mm/swap.c
> index 67786cb771305..642e471c3ec5a 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -212,10 +212,6 @@ static void folio_batch_move_lru(struct folio_batch 
> *fbatch, move_fn_t move_fn)
>          for (i = 0; i < folio_batch_count(fbatch); i++) {
>                  struct folio *folio = fbatch->folios[i];
> 
> -               /* block memcg migration while the folio moves between 
> lru */
> -               if (move_fn != lru_add_fn && !folio_test_clear_lru(folio))
> -                       continue;
> -
>                  folio_lruvec_relock_irqsave(folio, &lruvec, &flags);
>                  move_fn(lruvec, folio);
> 
> @@ -255,8 +251,9 @@ static void lru_move_tail_fn(struct lruvec *lruvec, 
> struct folio *folio)
>    */
>   void folio_rotate_reclaimable(struct folio *folio)
>   {
> -       if (!folio_test_locked(folio) && !folio_test_dirty(folio) &&
> -           !folio_test_unevictable(folio) && folio_test_lru(folio)) {
> +       if (folio_test_lru(folio) && !folio_test_locked(folio) &&
> +           !folio_test_dirty(folio) && !folio_test_unevictable(folio) &&
> +           folio_test_clear_lru(folio)) {
>                  struct folio_batch *fbatch;
>                  unsigned long flags;
> 
> @@ -354,7 +351,7 @@ static void folio_activate_drain(int cpu)
>   void folio_activate(struct folio *folio)
>   {
>          if (folio_test_lru(folio) && !folio_test_active(folio) &&
> -           !folio_test_unevictable(folio)) {
> +           !folio_test_unevictable(folio) && 
> folio_test_clear_lru(folio)) {

IMO, this seems violate the semantics of the LRU flag, since it's clear 
that this folio is still in the LRU list.

With your changes, I think we should drain the page vectors before 
calling folio_test_lru(), otherwise some cases will fail to check 
folio_test_lru() if the folio remain in the page vectors for an extended 
period.

>                  struct folio_batch *fbatch;
> 
>                  folio_get(folio);
> @@ -699,6 +696,8 @@ void deactivate_file_folio(struct folio *folio)
>          /* Deactivating an unevictable folio will not accelerate 
> reclaim */
>          if (folio_test_unevictable(folio))
>                  return;
> +       if (!folio_test_clear_lru(folio))
> +               return;
> 
>          folio_get(folio);
>          local_lock(&cpu_fbatches.lock);
> @@ -718,7 +717,8 @@ void deactivate_file_folio(struct folio *folio)
>   void folio_deactivate(struct folio *folio)
>   {
>          if (folio_test_lru(folio) && !folio_test_unevictable(folio) &&
> -           (folio_test_active(folio) || lru_gen_enabled())) {
> +           (folio_test_active(folio) || lru_gen_enabled()) &&
> +           folio_test_clear_lru(folio)) {
>                  struct folio_batch *fbatch;
> 
>                  folio_get(folio);
> @@ -740,7 +740,8 @@ void folio_mark_lazyfree(struct folio *folio)
>   {
>          if (folio_test_lru(folio) && folio_test_anon(folio) &&
>              folio_test_swapbacked(folio) && 
> !folio_test_swapcache(folio) &&
> -           !folio_test_unevictable(folio)) {
> +           !folio_test_unevictable(folio) &&
> +           folio_test_clear_lru(folio)) {
>                  struct folio_batch *fbatch;
> 
>                  folio_get(folio);
> 
> 
> 

