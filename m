Return-Path: <linux-kernel+bounces-376894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 331539AB727
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AACA81F247D9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01851CB328;
	Tue, 22 Oct 2024 19:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbYK2bYz"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D0C14EC55;
	Tue, 22 Oct 2024 19:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729626600; cv=none; b=m+Yg930lm+BKZHwjVqjA1C9TJJPZhgfkjhOklsQX9EQQyAnhY8vpQpNqa9bTtVAKb++ju4E51SwfAdpQlIOU7fj6Zia5YlDztI4VpU0UwaKbBVd8m8Jsqyy1T5ZbeeDjZw4p0MSbJf50pbW26IwdYSO0h6RA3Q3ZxTZJC7gc2fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729626600; c=relaxed/simple;
	bh=juIc/4yzPGt1ci6DodjLKeXbwqpyGcjXhDSi6BWuhzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HwV5fqkVDLQ+hUYpqF24m50Vs9z4lDOmqIfNn8KS5fgfNzacuuRYVkNHgpwQtn1VQWcKf21H1WzHvwezCqilHzqUk8X2ULITbDDI5ZTXSAZw7vfmcs99WX3Sut1kQ6A1nfApgXTXG2CIccNrQbxxf9VpAcrn9PV3Ap8sShc5xTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbYK2bYz; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4315baec69eso56170975e9.2;
        Tue, 22 Oct 2024 12:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729626597; x=1730231397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Om8WNrLakif7Mhwf/ZQEjA/zwexTSLBa065Q5gUDMMA=;
        b=cbYK2bYz1f8oDIYAQBb1uYv6yBfkmvAf2tg+p7y7Q23ThxKSc+iUTy5Pp7a7C2Olbd
         kPBOvMZA/mE52qecow4NhzigM9m/K+aNeWHeIZ9l/2txBUTO5d9NZNh+2dXBmWLM/9pV
         cV5NC4Kvbi8SW7cUquWa1FUMuiq5GqNkBNpMooXoJaCpJTSREKq+JcuodEb1tJZQm82h
         dGUEXZ2hQHtNsWU31cAm4gR5kF0L1nRaoDKX0VSpq3BVdCJFFf6vdU/xk0bThacSUWWc
         ilyL2x9KVQrL0tymD4IvkdzU2f6nT9sZq0GnaKPHPReEj5nXD8A72G4OpZ3xgukSruPe
         wOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729626597; x=1730231397;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Om8WNrLakif7Mhwf/ZQEjA/zwexTSLBa065Q5gUDMMA=;
        b=evYlmYe+wap7HZpZak+IIkuktVHRUF36aZmpUYjPHzpVvDqYs8ZCK4ElQkkvXmWZRK
         6mNUohA7ZJ7MoggoLgekcFo2MtXfC4ftsDZzs7/fiVxDVttr80dOV5icT93sjnJCLJ2d
         lTQbeuJi6sPww/AnDiu09bRZeqf9rbyMOUVktjvV7qHnTLnEeg2B1U3atHmMRPohqnv0
         KgjjFaA9lzBkVCB1q4LO/Y21tMTmeVFevwFK3h7CpsCcVd6HOLrFdacAwXAr3B2lhc77
         PoNZCLtIbHa2P3iDE1aA1fT5ALBoH4r88UkpQerjZbbfF/8tVg5rTGbTfsoRMHrc1hmZ
         9g/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+vbTiIvdxoqtI/j2h7fww1LcFvqO9kNPLfzkL+dOqIiKJELNdtmqTzSCVG+RLZjUTbVXczdbzt6aDb7OG@vger.kernel.org, AJvYcCVQ8N1cFgXgkL+gpygtD61I1X+rKgzSulfwyy28TlUzmiLz/fh5sYtDid6YZ6GNctArIQSNeH4Hhuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXABcZqxOBmAfu7WVMZ8ch33DnK+o0zX1bVCsCDjrFiydZEuDf
	bCvOG76UVTcWFyiIYrn+giu0DXrxv3C0bgbWToSuxwnnHnaX5AxL
X-Google-Smtp-Source: AGHT+IGibnWVWeS2iZbwYvF7fVTYjLscZTS2+1Ef2GRNwZ9NL00np1X/pEcDpTv3q/DxXXIeSHBmBg==
X-Received: by 2002:a05:600c:4ed4:b0:426:6edf:6597 with SMTP id 5b1f17b1804b1-431842207d9mr2317525e9.19.1729626596350;
        Tue, 22 Oct 2024 12:49:56 -0700 (PDT)
Received: from ?IPV6:2a02:6b67:d751:7400:c2b:f323:d172:e42a? ([2a02:6b67:d751:7400:c2b:f323:d172:e42a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f58bbaasm97734835e9.23.2024.10.22.12.49.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 12:49:55 -0700 (PDT)
Message-ID: <07e6018b-bc6f-4e1e-9bc3-07a4b5a384fc@gmail.com>
Date: Tue, 22 Oct 2024 20:49:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/4] mm/zswap: skip swapcache for swapping in zswap pages
To: Yosry Ahmed <yosryahmed@google.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org,
 david@redhat.com, willy@infradead.org, kanchana.p.sridhar@intel.com,
 nphamcs@gmail.com, chengming.zhou@linux.dev, ryan.roberts@arm.com,
 ying.huang@intel.com, 21cnbao@gmail.com, riel@surriel.com,
 shakeel.butt@linux.dev, kernel-team@meta.com, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Kairui Song <kasong@tencent.com>,
 Kairui Song <ryncsn@gmail.com>
References: <20241018105026.2521366-1-usamaarif642@gmail.com>
 <20241018105026.2521366-2-usamaarif642@gmail.com>
 <CAJD7tkYEe10Xw-8azM-80pHv6YjvosZDHTdZfYttAuD5u1+s8A@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAJD7tkYEe10Xw-8azM-80pHv6YjvosZDHTdZfYttAuD5u1+s8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 21/10/2024 22:09, Yosry Ahmed wrote:
> On Fri, Oct 18, 2024 at 3:50 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>
>> As mentioned in [1], there is a significant improvement in no
>> readahead swapin performance for super fast devices when skipping
>> swapcache.
> 
> FYI, Kairui was working on removing the swapcache bypass completely,
> which I think may be a good thing:
> https://lore.kernel.org/lkml/20240326185032.72159-1-ryncsn@gmail.com/
> 
> However, that series is old, since before the large folio swapin
> support, so I am not sure if/when he intends to refresh it.
> 
> In his approach there is still a swapin path for synchronous swapin
> though, which we can still utilize for zswap.
> 
>>
>> With large folio zswapin support added in later patches, this will also
>> mean this path will also act as "readahead" by swapping in multiple
>> pages into large folios. further improving performance.
>>
>> [1] https://lore.kernel.org/all/1505886205-9671-5-git-send-email-minchan@kernel.org/T/#m5a792a04dfea20eb7af4c355d00503efe1c86a93
>>
>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>> ---
>>  include/linux/zswap.h |  6 ++++++
>>  mm/memory.c           |  3 ++-
>>  mm/page_io.c          |  1 -
>>  mm/zswap.c            | 46 +++++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 54 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/zswap.h b/include/linux/zswap.h
>> index d961ead91bf1..e418d75db738 100644
>> --- a/include/linux/zswap.h
>> +++ b/include/linux/zswap.h
>> @@ -27,6 +27,7 @@ struct zswap_lruvec_state {
>>  unsigned long zswap_total_pages(void);
>>  bool zswap_store(struct folio *folio);
>>  bool zswap_load(struct folio *folio);
>> +bool zswap_present_test(swp_entry_t swp, int nr_pages);
>>  void zswap_invalidate(swp_entry_t swp);
>>  int zswap_swapon(int type, unsigned long nr_pages);
>>  void zswap_swapoff(int type);
>> @@ -49,6 +50,11 @@ static inline bool zswap_load(struct folio *folio)
>>         return false;
>>  }
>>
>> +static inline bool zswap_present_test(swp_entry_t swp, int nr_pages)
>> +{
>> +       return false;
>> +}
>> +
>>  static inline void zswap_invalidate(swp_entry_t swp) {}
>>  static inline int zswap_swapon(int type, unsigned long nr_pages)
>>  {
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 03e5452dd0c0..49d243131169 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -4289,7 +4289,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>         swapcache = folio;
>>
>>         if (!folio) {
>> -               if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
>> +               if ((data_race(si->flags & SWP_SYNCHRONOUS_IO) ||
>> +                   zswap_present_test(entry, 1)) &&
>>                     __swap_count(entry) == 1) {
>>                         /* skip swapcache */
>>                         folio = alloc_swap_folio(vmf);
>> diff --git a/mm/page_io.c b/mm/page_io.c
>> index 4aa34862676f..2a15b197968a 100644
>> --- a/mm/page_io.c
>> +++ b/mm/page_io.c
>> @@ -602,7 +602,6 @@ void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
>>         unsigned long pflags;
>>         bool in_thrashing;
>>
>> -       VM_BUG_ON_FOLIO(!folio_test_swapcache(folio) && !synchronous, folio);
>>         VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>>         VM_BUG_ON_FOLIO(folio_test_uptodate(folio), folio);
>>
>> diff --git a/mm/zswap.c b/mm/zswap.c
>> index 7f00cc918e7c..f4b03071b2fb 100644
>> --- a/mm/zswap.c
>> +++ b/mm/zswap.c
>> @@ -1576,6 +1576,52 @@ bool zswap_store(struct folio *folio)
>>         return ret;
>>  }
>>
>> +static bool swp_offset_in_zswap(unsigned int type, pgoff_t offset)
>> +{
>> +       return (offset >> SWAP_ADDRESS_SPACE_SHIFT) <  nr_zswap_trees[type];
> 
> I am not sure I understand what we are looking for here. When does
> this return false? Aren't the zswap trees always allocated during
> swapon?
> 

Hi Yosry,

Thanks for the review!

It becomes useful in patch 3 when trying to determine if a large folio can be allocated.

For e.g. if the swap entry is the last entry of the last tree, and 1M folios are enabled
(nr_pages = 256), then the while loop in zswap_present_test will try to access a tree
that doesn't exist from the 2nd 4K page onwards if we dont have this check in
zswap_present_test.

>> +}
>> +
>> +/* Returns true if the entire folio is in zswap */
> 
> There isn't really a folio at this point, maybe "Returns true if the
> entire range is in zswap"?

Will change, Thanks!

> 
> Also, this is racy because an exclusive load, invalidation, or
> writeback can cause an entry to be removed from zswap. Under what
> conditions is this safe? The caller can probably guarantee we don't
> race against invalidation, but can we guarantee that concurrent
> exclusive loads or writebacks don't happen?
> 
> If the answer is yes, this needs to be properly documented.

swapcache_prepare should stop things from becoming racy.

lets say trying to swapin a mTHP of size 32 pages:
- T1 is doing do_swap_page, T2 is doing zswap_writeback.
- T1 - Check if the entire 32 pages is in zswap, swapcache_prepare(entry, nr_pages) in do_swap_page is not yet called. 
- T2 - zswap_writeback_entry starts and lets say writes page 2 to swap. it calls __read_swap_cache_async -> swapcache_prepare increments swap_map count, writes page to swap.
- T1 - swapcache_prepare is then called and fails and then there will be a pagefault again for it.

I will try and document this better.

> 
>> +bool zswap_present_test(swp_entry_t swp, int nr_pages)
>> +{
>> +       pgoff_t offset = swp_offset(swp), tree_max_idx;
>> +       int max_idx = 0, i = 0, tree_offset = 0;
>> +       unsigned int type = swp_type(swp);
>> +       struct zswap_entry *entry = NULL;
>> +       struct xarray *tree;
>> +
>> +       while (i < nr_pages) {
>> +               tree_offset = offset + i;
>> +               /* Check if the tree exists. */
>> +               if (!swp_offset_in_zswap(type, tree_offset))
>> +                       return false;
>> +
>> +               tree = swap_zswap_tree(swp_entry(type, tree_offset));
>> +               XA_STATE(xas, tree, tree_offset);
> 
> Please do not mix declarations with code.
> 
>> +
>> +               tree_max_idx = tree_offset % SWAP_ADDRESS_SPACE_PAGES ?
>> +                       ALIGN(tree_offset, SWAP_ADDRESS_SPACE_PAGES) :
>> +                       ALIGN(tree_offset + 1, SWAP_ADDRESS_SPACE_PAGES);
> 
> Does this work if we always use ALIGN(tree_offset + 1,
> SWAP_ADDRESS_SPACE_PAGES)?

Yes, I think max_idx = min(offset + nr_pages, ALIGN(tree_offset + 1, SWAP_ADDRESS_SPACE_PAGES)) - 1;
will work. I will test it out, Thanks!


> 
>> +               max_idx = min(offset + nr_pages, tree_max_idx) - 1;
>> +               rcu_read_lock();
>> +               xas_for_each(&xas, entry, max_idx) {
>> +                       if (xas_retry(&xas, entry))
>> +                               continue;
>> +                       i++;
>> +               }
>> +               rcu_read_unlock();
>> +               /*
>> +                * If xas_for_each exits because entry is NULL and
> 
> nit: add () to the end of function names (i.e. xas_for_each())
> 
>> +                * the number of entries checked are less then max idx,
> 
> s/then/than
> 
>> +                * then zswap does not contain the entire folio.
>> +                */
>> +               if (!entry && offset + i <= max_idx)
>> +                       return false;
>> +       }
>> +
>> +       return true;
>> +}
>> +
>>  bool zswap_load(struct folio *folio)
>>  {
>>         swp_entry_t swp = folio->swap;
>> --
>> 2.43.5
>>


