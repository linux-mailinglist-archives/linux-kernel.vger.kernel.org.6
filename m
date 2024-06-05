Return-Path: <linux-kernel+bounces-202284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 657A28FCAB9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5314B21BAC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE04199224;
	Wed,  5 Jun 2024 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fMtaJ9/M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90945195FF9
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 11:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717587717; cv=none; b=qDT8jDs40xH2RC1nxb+yiFQV+26X6lZhGJ4HEIisWApL4qYucEwjy/D2qoQ4Qn8smdCd0IOnnDjhUaEMidvGQuPiDteBLpoRR6aeN3+tjkl3ANl/ODEkvIniFtb4YGJ/K48BMVz7R5+pw96nQp/q0UFJVGrAAhUyIe9z1CmysPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717587717; c=relaxed/simple;
	bh=mMMDJVzfgne5wCbgQtmPMjJ4X3mWuQ/2pYRML4YfOMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GxpG4GKnmQAen8ADEsvZtCzxfEx/tjtCxan8b20fAG8cUZoIXfd45Qs2yvSnyE7T9bwD/VuhbAuHZy6lyjF0mbdAXcz4OWinGtVregZkFpZ0hzr8vJaHURxLSmGMf51UaK5MoVKQFuIkcfxm8ApEhsUPQBITu3/aQHK0dZcz68c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fMtaJ9/M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717587714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SF+Me2aSDkkEWoS3Q1TYNoVa2ZP036aQFF3kEPllkVI=;
	b=fMtaJ9/Mw+k4HKB6hi998fo+UlRd6y6KgBRyetxfafAW3WYgAIA3rEKs8BnB9FdwlEI88L
	KmmIIFBMFfNvsVaJ0zOAbBKmNQl4Vj6gkuvgrJ1FdVd0rpgKrSGg2B6viidijyleTyHaFF
	dVequvzlEww5W6Ax3XdSNKhns4VMIyg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-6nZXfh-OOtiqkdB5ZZI_sA-1; Wed, 05 Jun 2024 07:41:53 -0400
X-MC-Unique: 6nZXfh-OOtiqkdB5ZZI_sA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-35dca4a8f2dso3821053f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 04:41:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717587712; x=1718192512;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SF+Me2aSDkkEWoS3Q1TYNoVa2ZP036aQFF3kEPllkVI=;
        b=CTx/5sa/qzPTyp29fiDAx2EFdUydE0+KA1lQvkCjSObLEkbsC1HsbnPSnvfzt2bS46
         a9vBgKuW8SzCKiZlYeaGiCVf8MxwW9tF3Xx5KHxHJtjQid7ZA/HkrlTl8ZlqCJ3S1rB7
         tfxPu5jDnZLGWmGzgbMqRzSNi6lyQec6SrXoHSWfoT7z4gOp/vnLqyabD2DmRzOpququ
         hUVY2UnaJdf8KyjCSzeMbGnIp+3kyFCcB42YYIEmLfmILbTUc49Muw1oUfkn6UOPcV31
         lPG5UHjNWbz/gdZGPoMvIycC7SRBjyEAG8W51eqm1J8oQMoNOBFBvzjwjaUiPFbPZ6/Z
         4aZw==
X-Forwarded-Encrypted: i=1; AJvYcCVzInthUJahy67BxLelfHGia6qRPWjhYR6cyECxXBamqWhD1TteDB2GEL3cHLUVZ7DZd2YeWomm1dTCLsSV6LGIy474ODfVAExm31XT
X-Gm-Message-State: AOJu0YwNdTeDstEBfHIec+PrMUHPTwCSDP0mZg7axuNGAk0OGU/IQZSl
	0Xl8dwwkyhTk/2xxriSLARjCJOl9SwlzOuDTvNwpcKchWgTegXyY+CHvpk32Oiq4YZE/fZj4xJT
	4B2oso8K1PJ0GhRMPaKLq8I/b+sTOUQgP+eWOIvRlTtBpBFLQuVa7G8bozwJoQA==
X-Received: by 2002:a5d:4d0f:0:b0:355:a6:d3d8 with SMTP id ffacd0b85a97d-35e98098f91mr1614649f8f.71.1717587712050;
        Wed, 05 Jun 2024 04:41:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMYSTZqXVZvX9SkKdrK2tIpAQZwoi3N3MF3PLr4cGDpsoi8RQwCCA0VyN44zREcot0++hs8g==
X-Received: by 2002:a5d:4d0f:0:b0:355:a6:d3d8 with SMTP id ffacd0b85a97d-35e98098f91mr1614634f8f.71.1717587711586;
        Wed, 05 Jun 2024 04:41:51 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:3100:19a8:d898:8e69:6aff? (p200300cbc706310019a8d8988e696aff.dip0.t-ipconnect.de. [2003:cb:c706:3100:19a8:d898:8e69:6aff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35e5e3d1902sm7673502f8f.32.2024.06.05.04.41.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 04:41:51 -0700 (PDT)
Message-ID: <11ef3deb-d1e3-46d5-97ed-9ba3c1fbbba9@redhat.com>
Date: Wed, 5 Jun 2024 13:41:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/gup: don't check page lru flag before draining it
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
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <48150a28-ed48-49ff-9432-9cd30cda4da4@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05.06.24 13:37, Baolin Wang wrote:
> 
> 
> On 2024/6/5 17:53, David Hildenbrand wrote:
>> On 05.06.24 11:41, David Hildenbrand wrote:
>>> On 05.06.24 03:18, yangge1116 wrote:
>>>>
>>>>
>>>> 在 2024/6/4 下午9:47, David Hildenbrand 写道:
>>>>> On 04.06.24 12:48, yangge1116@126.com wrote:
>>>>>> From: yangge <yangge1116@126.com>
>>>>>>
>>>>>> If a page is added in pagevec, its ref count increases one, remove
>>>>>> the page from pagevec decreases one. Page migration requires the
>>>>>> page is not referenced by others except page mapping. Before
>>>>>> migrating a page, we should try to drain the page from pagevec in
>>>>>> case the page is in it, however, folio_test_lru() is not sufficient
>>>>>> to tell whether the page is in pagevec or not, if the page is in
>>>>>> pagevec, the migration will fail.
>>>>>>
>>>>>> Remove the condition and drain lru once to ensure the page is not
>>>>>> referenced by pagevec.
>>>>>
>>>>> What you are saying is that we might have a page on which
>>>>> folio_test_lru() succeeds, that was added to one of the cpu_fbatches,
>>>>> correct?
>>>>
>>>> Yes
>>>>
>>>>>
>>>>> Can you describe under which circumstances that happens?
>>>>>
>>>>
>>>> If we call folio_activate() to move a page from inactive LRU list to
>>>> active LRU list, the page is not only in LRU list, but also in one of
>>>> the cpu_fbatches.
>>>>
>>>> void folio_activate(struct folio *folio)
>>>> {
>>>>         if (folio_test_lru(folio) && !folio_test_active(folio) &&
>>>>             !folio_test_unevictable(folio)) {
>>>>             struct folio_batch *fbatch;
>>>>
>>>>             folio_get(folio);
>>>>             //After this, folio is in LRU list, and its ref count have
>>>> increased one.
>>>>
>>>>             local_lock(&cpu_fbatches.lock);
>>>>             fbatch = this_cpu_ptr(&cpu_fbatches.activate);
>>>>             folio_batch_add_and_move(fbatch, folio, folio_activate_fn);
>>>>             local_unlock(&cpu_fbatches.lock);
>>>>         }
>>>> }
>>>
>>> Interesting, the !SMP variant does the folio_test_clear_lru().
>>>
>>> It would be really helpful if we could reliably identify whether LRU
>>> batching code has a raised reference on a folio.
>>>
>>> We have the same scenario in
>>> * folio_deactivate()
>>> * folio_mark_lazyfree()
>>>
>>> In folio_batch_move_lru() we do the folio_test_clear_lru(folio).
>>>
>>> No expert on that code, I'm wondering if we could move the
>>> folio_test_clear_lru() out, such that we can more reliably identify
>>> whether a folio is on the LRU batch or not.
>>
>> I'm sure there would be something extremely broken with the following
>> (I don't know what I'm doing ;) ), but I wonder if there would be a way
>> to make something like that work (and perform well enough?).
>>
>> diff --git a/mm/swap.c b/mm/swap.c
>> index 67786cb771305..642e471c3ec5a 100644
>> --- a/mm/swap.c
>> +++ b/mm/swap.c
>> @@ -212,10 +212,6 @@ static void folio_batch_move_lru(struct folio_batch
>> *fbatch, move_fn_t move_fn)
>>           for (i = 0; i < folio_batch_count(fbatch); i++) {
>>                   struct folio *folio = fbatch->folios[i];
>>
>> -               /* block memcg migration while the folio moves between
>> lru */
>> -               if (move_fn != lru_add_fn && !folio_test_clear_lru(folio))
>> -                       continue;
>> -
>>                   folio_lruvec_relock_irqsave(folio, &lruvec, &flags);
>>                   move_fn(lruvec, folio);
>>
>> @@ -255,8 +251,9 @@ static void lru_move_tail_fn(struct lruvec *lruvec,
>> struct folio *folio)
>>     */
>>    void folio_rotate_reclaimable(struct folio *folio)
>>    {
>> -       if (!folio_test_locked(folio) && !folio_test_dirty(folio) &&
>> -           !folio_test_unevictable(folio) && folio_test_lru(folio)) {
>> +       if (folio_test_lru(folio) && !folio_test_locked(folio) &&
>> +           !folio_test_dirty(folio) && !folio_test_unevictable(folio) &&
>> +           folio_test_clear_lru(folio)) {
>>                   struct folio_batch *fbatch;
>>                   unsigned long flags;
>>
>> @@ -354,7 +351,7 @@ static void folio_activate_drain(int cpu)
>>    void folio_activate(struct folio *folio)
>>    {
>>           if (folio_test_lru(folio) && !folio_test_active(folio) &&
>> -           !folio_test_unevictable(folio)) {
>> +           !folio_test_unevictable(folio) &&
>> folio_test_clear_lru(folio)) {
> 
> IMO, this seems violate the semantics of the LRU flag, since it's clear
> that this folio is still in the LRU list.

Good point.

But regarding "violation": we already do clear the flag temporarily in 
there, so it's rather that we make the visible time where it is cleared 
"longer". (yes, it can be much longer :) )

-- 
Cheers,

David / dhildenb


