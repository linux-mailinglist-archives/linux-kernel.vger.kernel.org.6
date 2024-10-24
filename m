Return-Path: <linux-kernel+bounces-379699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5339AE264
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 12:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3706B2829B0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139521C233E;
	Thu, 24 Oct 2024 10:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlPGooEU"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E461C303D
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 10:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729765220; cv=none; b=kReip/zXXE+W4RVezJ5wVFmsd1E8gNfWycf/ijXHnVo2cdFJoTS4yi2473NqTnGRCqFId+Za8dwFptJF8C2GnmV+t2xrqQtHikLNXAXc6GP+AeWKMASckTrZi3BD0eOXkFQsw/8M5qeix6wkUW/+QKiM52uyzjMRr4B9Cf0XSXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729765220; c=relaxed/simple;
	bh=hQC9wdKV4vZAHUPwSLHAY9OjOwouynxOks2ORhe7DW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N65OusLTWtjrwdXV895/30WH02aD2lGNZMBZQgoPV6N4WMkzPxondzsd+efGEGz6879y4/WVP4KPrKIbI72w/YRe8+Ub+Yh8Z8pNC4EFQdcL3TJseToRTjkL5VGTl8+qEe2v38kYjeW8sTR9GL18SKNZd68SOhYWmDgPJHoEmAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlPGooEU; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c937b5169cso1185029a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 03:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729765216; x=1730370016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iA8XsUv9ZiRb6klI05HB7Oq4fmXPGR/w8amvD8JEpMA=;
        b=QlPGooEU2fRIvIu7iDRiNNPlecd/ag/IO8AW1spYit5taZspGPB0YCYzdLG59o3RCh
         CY3XGYYnSD1rPjMITXuK3qmGw8dqv6lvhx3OaMh4b2wU4+YlqL815gxC7vJ+qDqo1G0m
         knVNx5NPjsIyDY4fp6Am32I8R01Zkhavsvwbe7M9crOClZIUsLPp0Wut0NoYbT2oEdg2
         8wDG5O96mFO9x0UrU1fR/b5rjM+MzaO+mlFzPt4ZYdlTqv8UPb7v0S3AP9r4eLRz7CAU
         yaai4eIQ+srrXLOVxvkuyIgstINQy/V/5lV9Hc84QyfvG9RAV4sOlRsrO1yZOVdv4nfj
         mOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729765216; x=1730370016;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iA8XsUv9ZiRb6klI05HB7Oq4fmXPGR/w8amvD8JEpMA=;
        b=qWr4ZVg0Ar4+/GBVt1BsJOKdC18UL66OLGWQcvGCUXY1e+KC7dtZvBZgdAUK2WcTUq
         Rv6R9ANLg3tjm3WJA0PM3kbwcvcyV5R/j9FKycPKLi9NU6iC/p4lxx3L018cVxYkX9U/
         zMN6r3d9dhzHkbyG7910bkkCRwIOaLWAUYyBTmir+BFc6gMO9OU/cMhoAIE5yvTIpr/r
         xy83lFt+CVyb+ZMhFG/AZG6PIEzYC3VlgS5SMKpqiYLgh4GoNO5SwANTlSWUrhq8ciqG
         UjkSferx5foU/QNfe9hWqDf4g86tNVojU9DWK0tXz+QoiWXjKz6yuzljVxL6LTAFPF8Y
         W1GA==
X-Forwarded-Encrypted: i=1; AJvYcCVOkxMWbfnJoGKFQKloyIQvrRKy+3/564yGNAI/BFG/8ZggSJXlcJq52RWGp9x7PfqEkTYlLxxHHKfW4Zk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm522IE7cP8UJNCx2cJ+x/hKcLX6Z9XDec42nUycnaChr4gYFD
	JLsWp3VtOaI1pNr0W0qmDcjiqUMQo/ceB9Tm5ePeDAJh58BSK6YG
X-Google-Smtp-Source: AGHT+IGUsj/cRGtaDvz+F0J9nNmkVXRZfqrOpZd7s6gYfKwD8/kx33LqFr/jokfnX0ukDrqnm18jLg==
X-Received: by 2002:a05:6402:234b:b0:5ca:18c9:f382 with SMTP id 4fb4d7f45d1cf-5cba1fdb9f2mr1766787a12.3.1729765215369;
        Thu, 24 Oct 2024 03:20:15 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::6:222b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c6b9d1sm5741285a12.70.2024.10.24.03.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 03:20:14 -0700 (PDT)
Message-ID: <82d32616-9135-4b30-9e91-b190a03bcb54@gmail.com>
Date: Thu, 24 Oct 2024 11:20:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hotfix 1/2] mm/thp: fix deferred split queue not
 partially_mapped
To: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Yang Shi <shy828301@gmail.com>, Wei Yang <richard.weiyang@gmail.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Nhat Pham <nphamcs@gmail.com>,
 Zi Yan <ziy@nvidia.com>, Chris Li <chrisl@kernel.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <760237a3-69d6-9197-432d-0306d52c048a@google.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <760237a3-69d6-9197-432d-0306d52c048a@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 24/10/2024 05:10, Hugh Dickins wrote:
> Recent changes are putting more pressure on THP deferred split queues:
> under load revealing long-standing races, causing list_del corruptions,
> "Bad page state"s and worse (I keep BUGs in both of those, so usually
> don't get to see how badly they end up without).  The relevant recent
> changes being 6.8's mTHP, 6.10's mTHP swapout, and 6.12's mTHP swapin,
> improved swap allocation, and underused THP splitting.
> 
> The new unlocked list_del_init() in deferred_split_scan() is buggy.
> I gave bad advice, it looks plausible since that's a local on-stack
> list, but the fact is that it can race with a third party freeing or
> migrating the preceding folio (properly unqueueing it with refcount 0
> while holding split_queue_lock), thereby corrupting the list linkage.
> 
> The obvious answer would be to take split_queue_lock there: but it has
> a long history of contention, so I'm reluctant to add to that. Instead,
> make sure that there is always one safe (raised refcount) folio before,
> by delaying its folio_put().  (And of course I was wrong to suggest
> updating split_queue_len without the lock: leave that until the splice.)
> 

Thanks for this, I imagine this was quite tricky to debug.

Avoiding taking the split_queue_lock by keeping reference of the
preceding folio is really nice.

And I should have spotted in the original patch that split_queue_len
shouldn't be changed without holding split_queue_lock.

Acked-by: Usama Arif <usamaarif642@gmail.com>

> And remove two over-eager partially_mapped checks, restoring those tests
> to how they were before: if uncharge_folio() or free_tail_page_prepare()
> finds _deferred_list non-empty, it's in trouble whether or not that folio
> is partially_mapped (and the flag was already cleared in the latter case).
> 
> Fixes: dafff3f4c850 ("mm: split underused THPs")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  mm/huge_memory.c | 21 +++++++++++++++++----
>  mm/memcontrol.c  |  3 +--
>  mm/page_alloc.c  |  5 ++---
>  3 files changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2fb328880b50..a1d345f1680c 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3718,8 +3718,8 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>  	struct deferred_split *ds_queue = &pgdata->deferred_split_queue;
>  	unsigned long flags;
>  	LIST_HEAD(list);
> -	struct folio *folio, *next;
> -	int split = 0;
> +	struct folio *folio, *next, *prev = NULL;
> +	int split = 0, removed = 0;
>  
>  #ifdef CONFIG_MEMCG
>  	if (sc->memcg)
> @@ -3775,15 +3775,28 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>  		 */
>  		if (!did_split && !folio_test_partially_mapped(folio)) {
>  			list_del_init(&folio->_deferred_list);
> -			ds_queue->split_queue_len--;
> +			removed++;
> +		} else {
> +			/*
> +			 * That unlocked list_del_init() above would be unsafe,
> +			 * unless its folio is separated from any earlier folios
> +			 * left on the list (which may be concurrently unqueued)
> +			 * by one safe folio with refcount still raised.
> +			 */
> +			swap(folio, prev);
>  		}
> -		folio_put(folio);
> +		if (folio)
> +			folio_put(folio);
>  	}
>  
>  	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>  	list_splice_tail(&list, &ds_queue->split_queue);
> +	ds_queue->split_queue_len -= removed;
>  	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
>  
> +	if (prev)
> +		folio_put(prev);
> +
>  	/*
>  	 * Stop shrinker if we didn't split any page, but the queue is empty.
>  	 * This can happen if pages were freed under us.
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 7845c64a2c57..2703227cce88 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4631,8 +4631,7 @@ static void uncharge_folio(struct folio *folio, struct uncharge_gather *ug)
>  	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
>  	VM_BUG_ON_FOLIO(folio_order(folio) > 1 &&
>  			!folio_test_hugetlb(folio) &&
> -			!list_empty(&folio->_deferred_list) &&
> -			folio_test_partially_mapped(folio), folio);
> +			!list_empty(&folio->_deferred_list), folio);
>  
>  	/*
>  	 * Nobody should be changing or seriously looking at
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 8afab64814dc..4b21a368b4e2 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -961,9 +961,8 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
>  		break;
>  	case 2:
>  		/* the second tail page: deferred_list overlaps ->mapping */
> -		if (unlikely(!list_empty(&folio->_deferred_list) &&
> -		    folio_test_partially_mapped(folio))) {
> -			bad_page(page, "partially mapped folio on deferred list");
> +		if (unlikely(!list_empty(&folio->_deferred_list))) {
> +			bad_page(page, "on deferred list");
>  			goto out;
>  		}
>  		break;


