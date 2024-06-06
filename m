Return-Path: <linux-kernel+bounces-203504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B068FDC32
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 03:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D386A1C23178
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B74111CB8;
	Thu,  6 Jun 2024 01:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="enOQm9qm"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D078317C9B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 01:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717637783; cv=none; b=LygaRDBPJKW4R1C7dt2Ms24CGexz5r6c9mwW4WcKRkE48iIFXraUN0ImoBgCmEFJoO7nzuu990ds/CWRmiMqbgWkJq01aHc/Uxac7jDzJ2xyUgBrvgrZBRpBZAfZ67Av66INXIo3UbuzKgJ5JXUXI7NRYXQt8Tb0OdwfRNBN/Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717637783; c=relaxed/simple;
	bh=Y9t3oPP6etcUeR60jFj491c5uNwFLZ2LzDswEXwt+Hk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lVIBvIHhrnFJ61plWYRMvsnEa3+9NPp6oLU1MAKLnGUdU+EttUqrJ7TCuCvCfxwLTvF2TPgmjANJocaqwtDdK42pitbtRivUgyWNzXGnriVIO21jJt6UTkgd7/IUx+rOBNsf1GEMw5NqXvj3XkApQllQj/XwZq6JtU5SPyFh1ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=enOQm9qm; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version:
	Content-Type; bh=1g6h3u62HKNyMsAaXhRTD1sfN/Q2RI3J8MBfg5F040k=;
	b=enOQm9qmsirFAzWGPdv9CExUBVgtai+D393mZixhFcpmj+mScUPvSKr+nDGYiA
	TmrrBzm5OUZNpe5ZoB0sQJWlbAs+hEkkD/eY/gQdHSS7XQp5Lqzk1g+5aiWd8etw
	DqtKyypPWovOWTTEL9uafykPwzKykW1QZWkKtDB03Xj2M=
Received: from [172.21.21.216] (unknown [118.242.3.34])
	by gzga-smtp-mta-g0-3 (Coremail) with SMTP id _____wCXfxFnEmFmkeFGBQ--.47631S2;
	Thu, 06 Jun 2024 09:35:36 +0800 (CST)
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
From: yangge1116 <yangge1116@126.com>
Message-ID: <a30ee643-8690-16f1-c315-c252d2c16e4a@126.com>
Date: Thu, 6 Jun 2024 09:35:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7063920f-963a-4b3e-a3f3-c5cc227bc877@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXfxFnEmFmkeFGBQ--.47631S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtrWfurWxWrWrZFWrGFy5XFb_yoW7Aw15pF
	WUGF1qqFWDGF1DCr42qF15Ar10kr9Iqr4UZF4xGry2yFn0qw1q9F47Kw13CFsxJr18uFn2
	va4jqFn2q3WYqF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bwrW7UUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiWQT1G2VLalDc2AAAsj



在 2024/6/5 下午5:53, David Hildenbrand 写道:
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

With your changes, we will call folio_test_clear_lru(folio) firstly to 
clear the LRU flag, and then call folio_get(folio) to pin the folio, 
seems a little unreasonable. Normally, folio_get(folio) is called 
firstly to pin the page, and then some other functions is called to 
handle the folio.


