Return-Path: <linux-kernel+bounces-380649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B9C9AF41D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 22:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D86B2854A0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB72198A30;
	Thu, 24 Oct 2024 20:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TQuRzmqO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8417E14601C
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 20:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729803163; cv=none; b=lKx2iMWuiMiibb74KLEU6+sfiRxulYmiLvGjxbho+SUB4WIuszMPEExhQ3xuRUccrfbRvmBStqhFwuxM0GoX3awQGfOJ8K3qGsQROz8n8KOZPiLC/e0J+qXc/PCvpjuvGf14Lan/yUDQNDXot+vwQ6zm3u9MLbMuqRhqMTEV5AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729803163; c=relaxed/simple;
	bh=U705VLQYC1G2zxVS39rAlwBg1h8Al9nDzcGdY1LNKQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dxEn1HHS5zDO0V3NPaK7Sc79voREKCYSByz1Kbhf6mpB6L0JJv/r0Zj/Ix9BQTmqTT23jpiuaK0IXNEVGM/AXXbIlZNRofLrKWI43cj1MSmFVY6aVl+FAeCKfAJgXi2TKZKZGSafhxQ19KQ3v8jmuZS1yozhBIE2Q6VhNrnM4VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TQuRzmqO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729803158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FuZJUbDSgNUtl7t3nj6Vs3iM+nzxhz+VlpkyNKeY3ZU=;
	b=TQuRzmqOGKpWnXRvRWkEEaS4f4MD4Lypf21O+Wd/a/SjXNCLiSm7oxMigt0arTDjSYr/9n
	CtwKmiZXDsLdi+lfmRcjB01oTv4Cd4HRzPiBUAtEtPEG+2rR8s3/zC4VRBH9VXXUXctEdM
	mjAWXCNf6O8j9XZAYD/bz/F6kmqW1eQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-yM9bfbfVPtKAfm6KxbeyWQ-1; Thu, 24 Oct 2024 16:52:37 -0400
X-MC-Unique: yM9bfbfVPtKAfm6KxbeyWQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d5ca5bfc8so700994f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 13:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729803156; x=1730407956;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FuZJUbDSgNUtl7t3nj6Vs3iM+nzxhz+VlpkyNKeY3ZU=;
        b=Gv4vH2cf5qoSsiKtr+MdqfImimWkX/szJVY/R9fOSA2aEQBbQ2N9l1P48TqmD7vOCs
         DdaCZdwcKLa7isllAKFij9hxaPq1E+Jkv39td+YFjuYARLHBxKg1Upg7IAlKsf8bLjKk
         uiA1uODRb2HK+qvbqRjp7HV6fLokdrqP2KCsQsBFCOMa4ZtzWJJ/cWE9f8BZpAzL4OrA
         NjggydL07XSfc78Cb1SugLsbXbH4VvtOg1ZuD9TMqdfxqeN+s+kn/I2L/Kqx8g+3jR8F
         1/oKaZOCr8ButGShZi5uSd/sNTvPzK8BhSlQAR3Jpn8FWHJKW3L4nGhvbGqugs0osnOa
         EPyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+5q73LWxDUHdGFKh3s5KgDXFuYv6LwPZeK57Vn4uTWJLeq1wuWisgMGzEHWrWm0NKCT+jTGLR6caUkhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU6KYI0G0EcZUQcFdS/reMdOPRz20xyCdNjQvh5fQxmqAHYUEt
	tusheYILZkLE1mtnApDF45fMKXVkf3FgS8P1sfRkVbsFQwn/RNR1Grq74WbiJ5SFEWSCGLQODaF
	DAU8vahuPmkZvQBcjLFiRdMrlcMjyMe8ViIEKcNSah6PlX0yy00Xvpxnmz4eE3A==
X-Received: by 2002:a5d:44c5:0:b0:37d:4cd5:fff2 with SMTP id ffacd0b85a97d-37efcef1237mr5740833f8f.6.1729803155775;
        Thu, 24 Oct 2024 13:52:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuRpBa5GlsfpG2EZza0/wOqP/0Lt3NYyKrncSHP7fCeVupuTudxG7WCOqwFJH0b98Bkegc0g==
X-Received: by 2002:a5d:44c5:0:b0:37d:4cd5:fff2 with SMTP id ffacd0b85a97d-37efcef1237mr5740815f8f.6.1729803155204;
        Thu, 24 Oct 2024 13:52:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:4f00:9949:9757:8f9a:e10? (p200300cbc7044f00994997578f9a0e10.dip0.t-ipconnect.de. [2003:cb:c704:4f00:9949:9757:8f9a:e10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9b41fsm12027578f8f.93.2024.10.24.13.52.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 13:52:33 -0700 (PDT)
Message-ID: <a5a37ff4-3017-4950-b625-d82871139ebc@redhat.com>
Date: Thu, 24 Oct 2024 22:52:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hotfix 2/2] mm/thp: fix deferred split unqueue naming and
 locking
To: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Usama Arif <usamaarif642@gmail.com>, Yang Shi <shy828301@gmail.com>,
 Wei Yang <richard.weiyang@gmail.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Matthew Wilcox <willy@infradead.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Nhat Pham <nphamcs@gmail.com>,
 Zi Yan <ziy@nvidia.com>, Chris Li <chrisl@kernel.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <760237a3-69d6-9197-432d-0306d52c048a@google.com>
 <7dc6b280-cd87-acd1-1124-e512e3d2217d@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <7dc6b280-cd87-acd1-1124-e512e3d2217d@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.10.24 06:13, Hugh Dickins wrote:
> Recent changes are putting more pressure on THP deferred split queues:
> under load revealing long-standing races, causing list_del corruptions,
> "Bad page state"s and worse (I keep BUGs in both of those, so usually
> don't get to see how badly they end up without).  The relevant recent
> changes being 6.8's mTHP, 6.10's mTHP swapout, and 6.12's mTHP swapin,
> improved swap allocation, and underused THP splitting.
> 
> Before fixing locking: rename misleading folio_undo_large_rmappable(),
> which does not undo large_rmappable, to folio_unqueue_deferred_split(),
> which is what it does.  

Yes please. I stumbled into that myself recently -- leftover from 
previous rework.

It would have been reasonable to move that into a separate (follow-up?) 
patch.

> But that and its out-of-line __callee are mm
> internals of very limited usability: add comment and WARN_ON_ONCEs to
> check usage; and return a bool to say if a deferred split was unqueued,
> which can then be used in WARN_ON_ONCEs around safety checks (sparing
> callers the arcane conditionals in __folio_unqueue_deferred_split()).
> 
> Swapout: mem_cgroup_swapout() has been resetting folio->memcg_data 0
> without checking and unqueueing a THP folio from deferred split list;
> which is unfortunate, since the split_queue_lock depends on the memcg
> (when memcg is enabled); so swapout has been unqueueing such THPs later,
> when freeing the folio, using the pgdat's lock instead: potentially
> corrupting the memcg's list.  __remove_mapping() has frozen refcount to
> 0 here, so no problem with calling folio_unqueue_deferred_split() before
> resetting memcg_data.
> 
> That goes back to 5.4 commit 87eaceb3faa5 ("mm: thp: make deferred split
> shrinker memcg aware"): which included a check on swapcache before adding
> to deferred queue (which can now be removed), but no check on deferred
> queue before adding THP to swapcache (maybe other circumstances prevented
> it at that time, but not now).
> 
> Memcg-v1 move (deprecated): mem_cgroup_move_account() has been changing
> folio->memcg_data without checking and unqueueing a THP folio from the
> deferred list, sometimes corrupting "from" memcg's list, like swapout.
> Refcount is non-zero here, so folio_unqueue_deferred_split() can only be
> used in a WARN_ON_ONCE to validate the fix, which must be done earlier:
> mem_cgroup_move_charge_pte_range() first try to split the THP (splitting
> of course unqueues), or skip it if that fails.  Not ideal, but moving
> charge has been requested, and khugepaged should repair the THP later:
> nobody wants new custom unqueueing code just for this deprecated case.
> 
> The 87eaceb3faa5 commit did have the code to move from one deferred list
> to another (but was not conscious of its unsafety while refcount non-0);
> but that was removed by 5.6 commit fac0516b5534 ("mm: thp: don't need
> care deferred split queue in memcg charge move path"), which argued that
> the existence of a PMD mapping guarantees that the THP cannot be on a
> deferred list.  

I recall this can happen, not sure on 5.6 though: assume we have an anon 
THP with 1 PMD mapping and a single PTE mapping for simplicity.

Assume we want to migrate that folio and first remove the PMD mapping, 
then the PTE mapping. After removing the PMD mapping, we add it to the 
deferred split queue (single PTE mapped).

Now assume migration fails and we remove migration entries -> remap.

We now have a PMD-mapped THP on the deferred split queue.

(again, I might be wrong but that's from memory without digging into the 
code)


> I'm not sure if that was true at the time (swapcache
> remapped?), but it's clearly not true since 6.12 commit dafff3f4c850
> ("mm: split underused THPs").

We only remap PTEs from the swapcache, never PMDs.

> 
> [Note in passing: mem_cgroup_move_charge_pte_range() just skips mTHPs,
> large but not PMD-mapped: that's safe, but perhaps not intended: it's
> arguable whether the deprecated feature should be updated to work
> better with the new feature; but certainly not in this patch.]
> 
> Backport to 6.11 should be straightforward. Earlier backports must take
> care that other _deferred_list fixes and dependencies are included.  It
> is unclear whether these fixes are realistically needed before 6.12.
> 
> Fixes: 87eaceb3faa5 ("mm: thp: make deferred split shrinker memcg aware")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: <stable@vger.kernel.org>
> ---
>   mm/huge_memory.c   | 35 +++++++++++++++++++++--------------
>   mm/internal.h      | 10 +++++-----
>   mm/memcontrol-v1.c | 25 +++++++++++++++++++++++++
>   mm/memcontrol.c    |  8 +++++---
>   mm/migrate.c       |  4 ++--
>   mm/page_alloc.c    |  4 +++-
>   mm/swap.c          |  4 ++--
>   mm/vmscan.c        |  4 ++--
>   8 files changed, 65 insertions(+), 29 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index a1d345f1680c..dc7d5bb76495 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3588,10 +3588,27 @@ int split_folio_to_list(struct folio *folio, struct list_head *list)
>   	return split_huge_page_to_list_to_order(&folio->page, list, ret);
>   }
>   
> -void __folio_undo_large_rmappable(struct folio *folio)
> +/*
> + * __folio_unqueue_deferred_split() is not to be called directly:
> + * the folio_unqueue_deferred_split() inline wrapper in mm/internal.h
> + * limits its calls to those folios which may have a _deferred_list for
> + * queueing THP splits, and that list is (racily observed to be) non-empty.
> + *
> + * It is unsafe to call folio_unqueue_deferred_split() until folio refcount is
> + * zero: because even when split_queue_lock is held, a non-empty _deferred_list
> + * might be in use on deferred_split_scan()'s unlocked on-stack list.
> + *
> + * If memory cgroups are enabled, split_queue_lock is in the mem_cgroup: it is
> + * therefore important to unqueue deferred split before changing folio memcg.
> + */
> +bool __folio_unqueue_deferred_split(struct folio *folio)
>   {
>   	struct deferred_split *ds_queue;
>   	unsigned long flags;
> +	bool unqueued = false;
> +
> +	WARN_ON_ONCE(folio_ref_count(folio));
> +	WARN_ON_ONCE(!mem_cgroup_disabled() && !folio_memcg(folio));
>   
>   	ds_queue = get_deferred_split_queue(folio);
>   	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
> @@ -3603,8 +3620,11 @@ void __folio_undo_large_rmappable(struct folio *folio)
>   				      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
>   		}
>   		list_del_init(&folio->_deferred_list);
> +		unqueued = true;
>   	}
>   	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
> +
> +	return unqueued;	/* useful for debug warnings */
>   }
>   
>   /* partially_mapped=false won't clear PG_partially_mapped folio flag */
> @@ -3626,19 +3646,6 @@ void deferred_split_folio(struct folio *folio, bool partially_mapped)
>   	if (!partially_mapped && !split_underused_thp)
>   		return;
>   
> -	/*
> -	 * The try_to_unmap() in page reclaim path might reach here too,
> -	 * this may cause a race condition to corrupt deferred split queue.
> -	 * And, if page reclaim is already handling the same folio, it is
> -	 * unnecessary to handle it again in shrinker.
> -	 *
> -	 * Check the swapcache flag to determine if the folio is being
> -	 * handled by page reclaim since THP swap would add the folio into
> -	 * swap cache before calling try_to_unmap().
> -	 */
> -	if (folio_test_swapcache(folio))
> -		return;
> -
>   	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>   	if (partially_mapped) {
>   		if (!folio_test_partially_mapped(folio)) {
> diff --git a/mm/internal.h b/mm/internal.h
> index 93083bbeeefa..16c1f3cd599e 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -639,11 +639,11 @@ static inline void folio_set_order(struct folio *folio, unsigned int order)
>   #endif
>   }
>   
> -void __folio_undo_large_rmappable(struct folio *folio);
> -static inline void folio_undo_large_rmappable(struct folio *folio)
> +bool __folio_unqueue_deferred_split(struct folio *folio);
> +static inline bool folio_unqueue_deferred_split(struct folio *folio)
>   {
>   	if (folio_order(folio) <= 1 || !folio_test_large_rmappable(folio))

The rmappable check here is still confusing for me. I assume we want to 
exclude hugetlb or others that reuse the field for other purposes ...

> -		return;
> +		return false;
>   
>   	/*
>   	 * At this point, there is no one trying to add the folio to
> @@ -651,9 +651,9 @@ static inline void folio_undo_large_rmappable(struct folio *folio)
>   	 * to check without acquiring the split_queue_lock.
>   	 */
>   	if (data_race(list_empty(&folio->_deferred_list)))
> -		return;
> +		return false;
>   
> -	__folio_undo_large_rmappable(folio);
> +	return __folio_unqueue_deferred_split(folio);
>   }
>   
>   static inline struct folio *page_rmappable_folio(struct page *page)
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index 81d8819f13cd..f8744f5630bb 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -848,6 +848,8 @@ static int mem_cgroup_move_account(struct folio *folio,
>   	css_get(&to->css);
>   	css_put(&from->css);
>   
> +	/* Warning should never happen, so don't worry about refcount non-0 */
> +	WARN_ON_ONCE(folio_unqueue_deferred_split(folio));
>   	folio->memcg_data = (unsigned long)to;
>   
>   	__folio_memcg_unlock(from);
> @@ -1217,7 +1219,9 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
>   	enum mc_target_type target_type;
>   	union mc_target target;
>   	struct folio *folio;
> +	bool tried_split_before = false;
>   
> +retry_pmd:
>   	ptl = pmd_trans_huge_lock(pmd, vma);
>   	if (ptl) {
>   		if (mc.precharge < HPAGE_PMD_NR) {
> @@ -1227,6 +1231,27 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
>   		target_type = get_mctgt_type_thp(vma, addr, *pmd, &target);
>   		if (target_type == MC_TARGET_PAGE) {
>   			folio = target.folio;
> +			/*
> +			 * Deferred split queue locking depends on memcg,
> +			 * and unqueue is unsafe unless folio refcount is 0:
> +			 * split or skip if on the queue? first try to split.
> +			 */
> +			if (!list_empty(&folio->_deferred_list)) {
> +				spin_unlock(ptl);
> +				if (!tried_split_before)
> +					split_folio(folio);
> +				folio_unlock(folio);
> +				folio_put(folio);
> +				if (tried_split_before)
> +					return 0;
> +				tried_split_before = true;
> +				goto retry_pmd;
> +			}
> +			/*
> +			 * So long as that pmd lock is held, the folio cannot
> +			 * be racily added to the _deferred_list, because
> +			 * __folio_remove_rmap() will find !partially_mapped.
> +			 */
>   			if (folio_isolate_lru(folio)) {
>   				if (!mem_cgroup_move_account(folio, true,
>   							     mc.from, mc.to)) {
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 2703227cce88..06df2af97415 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4629,9 +4629,6 @@ static void uncharge_folio(struct folio *folio, struct uncharge_gather *ug)
>   	struct obj_cgroup *objcg;
>   
>   	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
> -	VM_BUG_ON_FOLIO(folio_order(folio) > 1 &&
> -			!folio_test_hugetlb(folio) &&
> -			!list_empty(&folio->_deferred_list), folio);
>   
>   	/*
>   	 * Nobody should be changing or seriously looking at
> @@ -4678,6 +4675,7 @@ static void uncharge_folio(struct folio *folio, struct uncharge_gather *ug)
>   			ug->nr_memory += nr_pages;
>   		ug->pgpgout++;
>   
> +		WARN_ON_ONCE(folio_unqueue_deferred_split(folio));
>   		folio->memcg_data = 0;
>   	}
>   
> @@ -4789,6 +4787,9 @@ void mem_cgroup_migrate(struct folio *old, struct folio *new)
>   
>   	/* Transfer the charge and the css ref */
>   	commit_charge(new, memcg);
> +
> +	/* Warning should never happen, so don't worry about refcount non-0 */
> +	WARN_ON_ONCE(folio_unqueue_deferred_split(old));
>   	old->memcg_data = 0;
>   }
>   
> @@ -4975,6 +4976,7 @@ void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry)
>   	VM_BUG_ON_FOLIO(oldid, folio);
>   	mod_memcg_state(swap_memcg, MEMCG_SWAP, nr_entries);
>   
> +	folio_unqueue_deferred_split(folio);
>   	folio->memcg_data = 0;
>   
>   	if (!mem_cgroup_is_root(memcg))
> diff --git a/mm/migrate.c b/mm/migrate.c
> index df91248755e4..691f25ee2489 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -489,7 +489,7 @@ static int __folio_migrate_mapping(struct address_space *mapping,
>   		    folio_test_large_rmappable(folio)) {
>   			if (!folio_ref_freeze(folio, expected_count))
>   				return -EAGAIN;
> -			folio_undo_large_rmappable(folio);
> +			folio_unqueue_deferred_split(folio);
>   			folio_ref_unfreeze(folio, expected_count);
>   		}
>   
> @@ -514,7 +514,7 @@ static int __folio_migrate_mapping(struct address_space *mapping,
>   	}
>   
>   	/* Take off deferred split queue while frozen and memcg set */
> -	folio_undo_large_rmappable(folio);
> +	folio_unqueue_deferred_split(folio);
>   
>   	/*
>   	 * Now we know that no one else is looking at the folio:
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 4b21a368b4e2..57f64b5d0004 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2681,7 +2681,9 @@ void free_unref_folios(struct folio_batch *folios)
>   		unsigned long pfn = folio_pfn(folio);
>   		unsigned int order = folio_order(folio);
>   
> -		folio_undo_large_rmappable(folio);
> +		if (mem_cgroup_disabled())
> +			folio_unqueue_deferred_split(folio);
> +

Is it worth adding a comment here where we take care of ths with memcg 
enabled?

It's complicated stuff, nothing jumped at me, but it's late here so my 
brain is not fully functional ...

-- 
Cheers,

David / dhildenb


