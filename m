Return-Path: <linux-kernel+bounces-202584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 847BB8FCE42
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC1741F2BFAA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEBC19A28B;
	Wed,  5 Jun 2024 12:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VV0gchmo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41131990D5
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 12:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717590036; cv=none; b=LDinC6hMF45X28QSvWz83MA8IHt+F15hclAzIkgR+W2QUGKbp4cDXYFNS2rbrLJeuqm3LZDcriCDLU11Wh4IaSHI8QMVQtWGkNqst6tGGxS2kZbJPZCWWURiKxO7cUv/wXGHHJaOF3plPxbn/1YNkO88msG3ryknXd0vHeTrDw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717590036; c=relaxed/simple;
	bh=0yWzQviCpDfDhQt1HRukTfnS5OmVr7XESitJROdMyO0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MUu0RfgoR6/AqiC0ck9oZ1mOcuPmFZ1zcqdJVv/R6Zs6Dt998JxWuIjX+aBSp6x3VQUM3RFemJy/QGWDJK9xo90/YOtVbzbnWH08eGvAT1Yc/0Lyo1x05B6uMsUjGmYGamZiT0VK5ajWcuDG62R0qpX7W7bd82tzdvezCmkUkWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VV0gchmo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717590033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Zq0+4R19zuVMgUASPBZu/DhgUc3jIiuWXA3pl9ldDZA=;
	b=VV0gchmoD03HHJhNMY6V5Kh+MKto6jwQ6oE4adslyvTw95ZIv42IxPGMyEAmMWXhvDxOA8
	+FtHb85I9emCP0rekAsI7vHHNztNz4X/ln7Ltjm9Aunl5QC7dq3aeLsPqlPE5WPpEpDV+z
	HBNXKsSe6FvE6JVqsp8WiVNmnVgb2z8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-yvcqtlkNOJ2NFDs6_pN9Hw-1; Wed, 05 Jun 2024 08:20:32 -0400
X-MC-Unique: yvcqtlkNOJ2NFDs6_pN9Hw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52b84eb911dso4373667e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 05:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717590030; x=1718194830;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zq0+4R19zuVMgUASPBZu/DhgUc3jIiuWXA3pl9ldDZA=;
        b=qCn1RjUwFLFb4wYsaN7ynn3x4LT88keRztQ6ciug4tuf8+j3DOqv+wXXSxALhPII/i
         9a7Wgf1EC6N67uZbwIJGtRgk41ziKXfMV9llq+MMc/APkgwSmLfWOQGg833LMD7JaFUd
         sHqv0orlzduN2ycXd8qSeXI97gjpdwnwul8tPT+T7xYl4uF3D1pDsMdnMmHaRMb9tm6v
         K8mh/QwUmZC4zsgYk+Csx/1eWmjcwgYvr1sNVEWNW6QdwBq12j0PNzPDdTXXrIeAqidJ
         Xm7vSxNQQPKg6nR4IeF1GYoprYvnp9hWSofkslR9qNdeDzxtx2MKoeR6y+7NNyph8NGu
         E3Tg==
X-Forwarded-Encrypted: i=1; AJvYcCW2ZNLb1EHOM9rM0eWwWwl1Cd1xjRNCReeGMVT5tuNvF2EJzssS6v2t+A5SIcSmo/XCHsIOzVKdLhwZgCCd7FhvEFx8IeJWo3jQ19Gx
X-Gm-Message-State: AOJu0YxocbNtMsD+JUpBdznuOyNLepS8M1fxN7x5bdr+a60rNzDhAydG
	sF2ASLMo54QAxqYq/HtFIkFInKn7xYICX3MMhMNMqGOueLe6AabQCZYDO4F2mk+JbS6hV2767l4
	dods+/ThN5COrYQ/eoP+0tThgkctWMr6HZhgKJ4NpdnSdhAfw7iCepXveuiWVVg==
X-Received: by 2002:ac2:4314:0:b0:52b:aa4c:49e2 with SMTP id 2adb3069b0e04-52bab4fc014mr1314442e87.57.1717590030565;
        Wed, 05 Jun 2024 05:20:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5e2rx27ksYpU8/oUecVgAheYaF3etGZZauI0vRISAuA3SbfvgBAgQ2hzD0K0PDCnneixYiQ==
X-Received: by 2002:ac2:4314:0:b0:52b:aa4c:49e2 with SMTP id 2adb3069b0e04-52bab4fc014mr1314420e87.57.1717590030077;
        Wed, 05 Jun 2024 05:20:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:3100:19a8:d898:8e69:6aff? (p200300cbc706310019a8d8988e696aff.dip0.t-ipconnect.de. [2003:cb:c706:3100:19a8:d898:8e69:6aff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42158129592sm20607265e9.22.2024.06.05.05.20.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 05:20:29 -0700 (PDT)
Message-ID: <697a9bc2-a655-4035-aa5e-7d3acb23e79d@redhat.com>
Date: Wed, 5 Jun 2024 14:20:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/gup: don't check page lru flag before draining it
From: David Hildenbrand <david@redhat.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 yangge1116 <yangge1116@126.com>, akpm@linux-foundation.org,
 Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, liuzixing@hygon.cn
References: <1717498121-20926-1-git-send-email-yangge1116@126.com>
 <0d7a4405-9a2e-4bd1-ba89-a31486155233@redhat.com>
 <dc7a0b61-8d3f-7205-2f6d-c2b12500947a@126.com>
 <776de760-e817-43b2-bd00-8ce96f4e37a8@redhat.com>
 <7063920f-963a-4b3e-a3f3-c5cc227bc877@redhat.com>
 <48150a28-ed48-49ff-9432-9cd30cda4da4@linux.alibaba.com>
 <11ef3deb-d1e3-46d5-97ed-9ba3c1fbbba9@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <11ef3deb-d1e3-46d5-97ed-9ba3c1fbbba9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05.06.24 13:41, David Hildenbrand wrote:
> On 05.06.24 13:37, Baolin Wang wrote:
>>
>>
>> On 2024/6/5 17:53, David Hildenbrand wrote:
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
>>>>>          if (folio_test_lru(folio) && !folio_test_active(folio) &&
>>>>>              !folio_test_unevictable(folio)) {
>>>>>              struct folio_batch *fbatch;
>>>>>
>>>>>              folio_get(folio);
>>>>>              //After this, folio is in LRU list, and its ref count have
>>>>> increased one.
>>>>>
>>>>>              local_lock(&cpu_fbatches.lock);
>>>>>              fbatch = this_cpu_ptr(&cpu_fbatches.activate);
>>>>>              folio_batch_add_and_move(fbatch, folio, folio_activate_fn);
>>>>>              local_unlock(&cpu_fbatches.lock);
>>>>>          }
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
>>>            for (i = 0; i < folio_batch_count(fbatch); i++) {
>>>                    struct folio *folio = fbatch->folios[i];
>>>
>>> -               /* block memcg migration while the folio moves between
>>> lru */
>>> -               if (move_fn != lru_add_fn && !folio_test_clear_lru(folio))
>>> -                       continue;
>>> -
>>>                    folio_lruvec_relock_irqsave(folio, &lruvec, &flags);
>>>                    move_fn(lruvec, folio);
>>>
>>> @@ -255,8 +251,9 @@ static void lru_move_tail_fn(struct lruvec *lruvec,
>>> struct folio *folio)
>>>      */
>>>     void folio_rotate_reclaimable(struct folio *folio)
>>>     {
>>> -       if (!folio_test_locked(folio) && !folio_test_dirty(folio) &&
>>> -           !folio_test_unevictable(folio) && folio_test_lru(folio)) {
>>> +       if (folio_test_lru(folio) && !folio_test_locked(folio) &&
>>> +           !folio_test_dirty(folio) && !folio_test_unevictable(folio) &&
>>> +           folio_test_clear_lru(folio)) {
>>>                    struct folio_batch *fbatch;
>>>                    unsigned long flags;
>>>
>>> @@ -354,7 +351,7 @@ static void folio_activate_drain(int cpu)
>>>     void folio_activate(struct folio *folio)
>>>     {
>>>            if (folio_test_lru(folio) && !folio_test_active(folio) &&
>>> -           !folio_test_unevictable(folio)) {
>>> +           !folio_test_unevictable(folio) &&
>>> folio_test_clear_lru(folio)) {
>>
>> IMO, this seems violate the semantics of the LRU flag, since it's clear
>> that this folio is still in the LRU list.
> 
> Good point.
> 
> But regarding "violation": we already do clear the flag temporarily in
> there, so it's rather that we make the visible time where it is cleared
> "longer". (yes, it can be much longer :) )

Some random thoughts about some folio_test_lru() users:

mm/khugepaged.c: skips pages if !folio_test_lru(), but would fail skip 
it either way if there is the unexpected reference from the LRU batch!

mm/compaction.c: skips pages if !folio_test_lru(), but would fail skip 
it either way if there is the unexpected reference from the LRU batch!

mm/memory.c: would love to identify this case and to a lru_add_drain() 
to free up that reference.

mm/huge_memory.c: splitting with the additional reference will fail 
already. Maybe we'd want to drain the LRU batch.

mm/madvise.c: skips pages if !folio_test_lru(). I wonder what happens if 
we have the same page twice in an LRU batch with different target goals ...


Some other users (there are not that many that don't use it for sanity 
checks though) might likely be a bit different.

-- 
Cheers,

David / dhildenb


