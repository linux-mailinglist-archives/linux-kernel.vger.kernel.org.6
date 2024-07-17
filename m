Return-Path: <linux-kernel+bounces-255003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61497933A59
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68E321C21248
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2CE17E8EC;
	Wed, 17 Jul 2024 09:51:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF071442F1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 09:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721209866; cv=none; b=g7t+uP2HNNqSeGBG5xjHvzeCLKtCO4pYCdl1GHkN1qYSdDJGzF4dek8iius62Q/+z9aCImRr9UGTcfKb5RnVKDA8EQTjfrwd5TaW5XKLDBYNejPStYpgP1fdcyZ74X/m3RhdQKTCIVKjdtC34xWBaFYhh16YrfwJqjCrJmQqtgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721209866; c=relaxed/simple;
	bh=CHi6MJtPH/X6jYwyrF3rT1GCF1ZD5jZh+3VumXmuAs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PxZumzfx8ePArUYlhgzsUiRvHJvBD5WFVTdF4w+ml5ddtKga72G7x099j2rY8tlwjKnWvaDpbKsZVCOuVBGAOXr+fgi9u/wNYBORb29P84R97BU59QX/eK/ylRc1FNUUIUcSrF+anKK/gnIoZnrDBSThMvTtxSdjJ0WARcQLbDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 071621063;
	Wed, 17 Jul 2024 02:51:26 -0700 (PDT)
Received: from [10.57.77.222] (unknown [10.57.77.222])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 428BA3F73F;
	Wed, 17 Jul 2024 02:50:59 -0700 (PDT)
Message-ID: <dca879ca-e430-4759-b992-4f763344319c@arm.com>
Date: Wed, 17 Jul 2024 10:50:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] mm: mTHP stats for pagecache folio allocations
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, Lance Yang <ioworker0@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
 <hughd@google.com>, Jonathan Corbet <corbet@lwn.net>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240711072929.3590000-1-ryan.roberts@arm.com>
 <20240711072929.3590000-3-ryan.roberts@arm.com>
 <9e0d84e5-2319-4425-9760-2c6bb23fc390@linux.alibaba.com>
 <CAK1f24nCDZM8aa9z_ZtgLbdj695JJri01q2HJUJb9pJt2uqy=w@mail.gmail.com>
 <756c359e-bb8f-481e-a33f-163c729afa31@redhat.com>
 <8c32a2fc-252d-406b-9fec-ce5bab0829df@arm.com>
 <a8441245-ae35-443f-9aea-325007492741@arm.com>
 <5c58d9ea-8490-4ae6-b7bf-be816dab3356@redhat.com>
 <f03deb7c-9a67-4096-9d33-32b357b52152@arm.com>
 <9052f430-2c5a-4d9d-b54c-bd093b797702@redhat.com>
 <f84bd34d-ac64-4e2f-90c0-d637c00b5055@arm.com>
 <5472faf5-1fbe-4a89-a17e-83716fc00b5a@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <5472faf5-1fbe-4a89-a17e-83716fc00b5a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/07/2024 09:44, David Hildenbrand wrote:
>>>> I guess the real supported orders are:
>>>>
>>>>     anon:
>>>>       min order: 2
>>>>       max order: PMD_ORDER
>>>>     anon-shmem:
>>>>       min order: 1
>>>>       max order: MAX_PAGECACHE_ORDER
>>>>     tmpfs-shmem:
>>>>       min order: PMD_ORDER <= 11 ? PMD_ORDER : NONE
>>>>       max order: PMD_ORDER <= 11 ? PMD_ORDER : NONE
>>>>     file:
>>>>       min order: 1
>>>>       max order: MAX_PAGECACHE_ORDER
>>>
>>> That's my understanding. But not sure about anon-shmem really supporting
>>> order-1, maybe we do.
>>
>> Oh, I thought we only had the restriction for anon folios now (due to deferred
>> split queue), so assumed it would just work. With Gavin's
>> THP_ORDERS_ALL_FILE_DEFAULT change, that certainly implies that shmem must
>> support order-1. If it doesn't then we we might want to tidy that further.
>>
>> Baolin, perhaps you can confirm either way?
> 
> Currently there would not have been a way to enable it, right? (maybe I'm wrong)

__thp_vma_allowable_orders() doesn't do anything special for shmem if TVA_IN_PF
is set, so I guess it could concievably return order-1 in that path. Not sure if
it ever gets called that way for shmem though - I don't think so. But agree that
shmem_allowable_huge_orders() will not currently return order-1.

> 
>>
>>>
>>>>
>>>> But today, controls and stats are exposed for:
>>>>
>>>>     anon:
>>>>       min order: 2
>>>>       max order: PMD_ORDER
>>>>     anon-shmem:
>>>>       min order: 2
>>>>       max order: PMD_ORDER
>>>>     tmpfs-shmem:
>>>>       min order: PMD_ORDER
>>>>       max order: PMD_ORDER
>>>>     file:
>>>>       min order: Nothing yet (this patch proposes 1)
>>>>       max order: Nothing yet (this patch proposes MAX_PAGECACHE_ORDER)
>>>>
>>>> So I think there is definitely a bug for shmem where the minimum order control
>>>> should be order-1 but its currently order-2.
>>>
>>> Maybe, did not play with that yet. Likely order-1 will work. (although probably
>>> of questionable use :) )
>>
>> You might have to expand on why its of "questionable use". I'd assume it has the
>> same amount of value as using order-1 for regular page cache pages? i.e. half
>> the number of objects to manage for the same amount of memory.
> 
> order-1 was recently added for the pagecache to get some device setups running
> (IIRC, where we cannot use order-0, because device blocksize > PAGE_SIZE).
> 
> You might be right about "half the number of objects", but likely just going for
> order-2, order-3, order-4 ... for shmem might be even better. And simply falling
> back to order-0 when you cannot get the larger orders.

Sure, but then you're into the territory of baking in policy. Remember that
originally I was only interested in 64K but the concensus was to expose all the
sizes. Same argument applies to 8K; expose it and let others decide policy.

> 
> I could have sworn you mentioned something like that in your "configurable
> orders for pagecache" RFC that I only briefly skimmed so far :P

I'm exposing the 8K control for pagecache in that series.

> 
> ... only enabling "order-1" and none of the other orders for shmem sounds rather
> "interesting".
> 
> But yeah, maybe there is valid use for it, so I'm all for allowing it if it can
> be done.
> 
>>
>>>
>>>>
>>>> I also wonder about PUD-order for DAX? We don't currently have a stat/control.
>>>> If we wanted to add it in future, if we take the "expose all stats/controls for
>>>> all orders" approach, we would end up extending all the way to PUD-order and
>>>> all
>>>> the orders between PMD and PUD would be dummy for all memory types. That really
>>>> starts to feel odd, so I still favour only populating what's really supported.
>>>
>>> I would go further and say that calling the fsdax thing a THP is borderline
>>> wrong and we should not expose any new toggles for it that way.
>>>
>>> It really behaves much more like hugetlb folios that can be PTE-mapped ... we
>>> cannot split these things, and they are not allocated from the buddy. So I
>>> wouldn't worry about fsdax for now.
>>>
>>> fsdax support for compound pages (now large folios) probably never should have
>>> been glued to any THP toggle.
>>
>> Yeah fair enough. I wasn't really arguing for adding any dax controls; I was
>> just trying to think of examples as to why adding dummy controls might be a bad
>> idea.
> 
> Yes.
> 
>>>
>>>>
>>>> I propose to fix shmem (extend down to 1, stop at MAX_PAGECACHE_ORDER) and
>>>> continue with the approach of "indicating only what really exists" for v2.
>>>>
>>>> Shout if you disagree.
>>>
>>> Makes sense.
>>
>> Excellent. I posted v2, which has these changes, yesterday afternoon. :)
> 
> Yes, still digging through mails ... in-between having roughly 1000 meetings a
> day :)

No problem. You're in-demand. I can wait. :)


