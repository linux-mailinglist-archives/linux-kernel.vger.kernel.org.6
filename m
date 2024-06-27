Return-Path: <linux-kernel+bounces-231921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD12191A061
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37834B21607
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BECA4D8D1;
	Thu, 27 Jun 2024 07:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eWpdZTPf"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A17524D6
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 07:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719473149; cv=none; b=RFSzzmM7vV7aIA72RlDMcZk2Ce9C3hxRjNw34IJ/aJ0n774JLnyE3rklncmsuh+xlbLI/oaKRS/ejVd7NKFrznSxnyc/P7RXziPnuQNEjVfdjdV0Z4tSUUFt5149GO48SeWCXutPn9ClcaR1eIix8zrexC8tE20Gqvx8tLPJQnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719473149; c=relaxed/simple;
	bh=8yxiy/onMSQcihoLqUVM4QBD7j+bFpwIkG6dif+2IoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZjKAd4f2TOVndByjRfL2NxVhSlaHx6HPDnmCYZHtmJ6thT7WW2DOpwl3pFDG8u7fQpWWcYt5Fzh63n3KqSusOt7Ii/7yJMXpeQl6TIZ2JQOHzgse5VzMkyHxXce6vF+o/E1GeUQiOf/qDNHW46yzb02Tlt0VKA8eAP1X2PqDPyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eWpdZTPf; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: yuzhao@google.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719473144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BWojZVzNV+zDBRMlFD0vl4NDHhcBHwAHj5cUBFwCx3o=;
	b=eWpdZTPfnQZKYMN5SijH159CRiCl+KjK0QW/HCRf4jkukk19vjdTtBovoaN00nNhG5HeUl
	YzxDn89bu3JpLhRnrBdxTMFhQJe4YA3QLgx+Eb6/BE8J+qR24cBUKAt1pM2qvMxo2yoc6B
	1EISdHm8u6JWWeialf4kPBSCnZvcH8o=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: david@redhat.com
X-Envelope-To: fvdl@google.com
X-Envelope-To: willy@infradead.org
X-Envelope-To: peterx@redhat.com
X-Envelope-To: yang@os.amperecomputing.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Message-ID: <379a225a-3e26-4adc-9add-b4d931c55a9a@linux.dev>
Date: Thu, 27 Jun 2024 15:25:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-unstable v1] mm/hugetlb_vmemmap: fix race with
 speculative PFN walkers
To: Yu Zhao <yuzhao@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
 Frank van der Linden <fvdl@google.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Peter Xu
 <peterx@redhat.com>, Yang Shi <yang@os.amperecomputing.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240627044335.2698578-1-yuzhao@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240627044335.2698578-1-yuzhao@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2024/6/27 12:43, Yu Zhao wrote:
> While investigating HVO for THPs [1], it turns out that speculative
> PFN walkers like compaction can race with vmemmap modifications, e.g.,
>
>    CPU 1 (vmemmap modifier)         CPU 2 (speculative PFN walker)
>    -------------------------------  ------------------------------
>    Allocates an LRU folio page1
>                                     Sees page1
>    Frees page1
>
>    Allocates a hugeTLB folio page2
>    (page1 being a tail of page2)
>
>    Updates vmemmap mapping page1
>                                     get_page_unless_zero(page1)
>
> Even though page1->_refcount is zero after HVO, get_page_unless_zero()
> can still try to modify this read-only field, resulting in a crash.
>
> An independent report [2] confirmed this race.
>
> There are two discussed approaches to fix this race:
> 1. Make RO vmemmap RW so that get_page_unless_zero() can fail without
>     triggering a PF.
> 2. Use RCU to make sure get_page_unless_zero() either sees zero
>     page->_refcount through the old vmemmap or non-zero page->_refcount
>     through the new one.
>
> The second approach is preferred here because:
> 1. It can prevent illegal modifications to struct page[] that has been
>     HVO'ed;
> 2. It can be generalized, in a way similar to ZERO_PAGE(), to fix
>     similar races in other places, e.g., arch_remove_memory() on x86
>     [3], which frees vmemmap mapping offlined struct page[].
>
> While adding synchronize_rcu(), the goal is to be surgical, rather
> than optimized. Specifically, calls to synchronize_rcu() on the error
> handling paths can be coalesced, but it is not done for the sake of
> Simplicity: noticeably, this fix removes ~50% more lines than it adds.

I suggest adding some user-visible effect here like for use
case of nr_overcommit_hugepages, synchronize_rcu() will make
this use case worse.

>
> [1] https://lore.kernel.org/20240229183436.4110845-4-yuzhao@google.com/
> [2] https://lore.kernel.org/917FFC7F-0615-44DD-90EE-9F85F8EA9974@linux.dev/
> [3] https://lore.kernel.org/be130a96-a27e-4240-ad78-776802f57cad@redhat.com/
>
> Signed-off-by: Yu Zhao <yuzhao@google.com>

Acked-by: Muchun Song <muchun.song@linux.dev>

A nit below.

> ---
>   include/linux/page_ref.h |  8 +++++-
>   mm/hugetlb.c             | 53 ++++++----------------------------------
>   mm/hugetlb_vmemmap.c     | 16 ++++++++++++
>   3 files changed, 30 insertions(+), 47 deletions(-)
>
> diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
> index 490d0ad6e56d..8c236c651d1d 100644
> --- a/include/linux/page_ref.h
> +++ b/include/linux/page_ref.h
> @@ -230,7 +230,13 @@ static inline int folio_ref_dec_return(struct folio *folio)
>   
>   static inline bool page_ref_add_unless(struct page *page, int nr, int u)
>   {
> -	bool ret = atomic_add_unless(&page->_refcount, nr, u);
> +	bool ret = false;
> +
> +	rcu_read_lock();
> +	/* avoid writing to the vmemmap area being remapped */
> +	if (!page_is_fake_head(page) && page_ref_count(page) != u)
> +		ret = atomic_add_unless(&page->_refcount, nr, u);
> +	rcu_read_unlock();
>   
>   	if (page_ref_tracepoint_active(page_ref_mod_unless))
>   		__page_ref_mod_unless(page, nr, ret);
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 9691624fcb79..1ddaf25737da 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1629,13 +1629,10 @@ static inline void destroy_compound_gigantic_folio(struct folio *folio,
>    * folio appears as just a compound page.  Otherwise, wait until after
>    * allocating vmemmap to clear the flag.
>    *
> - * A reference is held on the folio, except in the case of demote.
> - *
>    * Must be called with hugetlb lock held.
>    */
> -static void __remove_hugetlb_folio(struct hstate *h, struct folio *folio,
> -							bool adjust_surplus,
> -							bool demote)
> +static void remove_hugetlb_folio(struct hstate *h, struct folio *folio,
> +							bool adjust_surplus)
>   {
>   	int nid = folio_nid(folio);
>   
> @@ -1657,6 +1654,7 @@ static void __remove_hugetlb_folio(struct hstate *h, struct folio *folio,
>   		h->surplus_huge_pages_node[nid]--;
>   	}
>   
> +	folio_clear_hugetlb_freed(folio);

I'd suggest putting this into the above "if" statement (if 
(folio_test_hugetlb_freed(folio))).
Then, if the flag is already cleared, there is nothing to do.

Thanks.

>   	/*
>   	 * We can only clear the hugetlb flag after allocating vmemmap
>   	 * pages.  Otherwise, someone (memory error handling) may try to write
> @@ -1665,33 +1663,13 @@ static void __remove_hugetlb_folio(struct hstate *h, struct folio *folio,
>   	if (!folio_test_hugetlb_vmemmap_optimized(folio))
>   		__folio_clear_hugetlb(folio);
>   
> -	 /*
> -	  * In the case of demote we do not ref count the page as it will soon
> -	  * be turned into a page of smaller size.
> -	 */
> -	if (!demote)
> -		folio_ref_unfreeze(folio, 1);
> -
>   	h->nr_huge_pages--;
>   	h->nr_huge_pages_node[nid]--;
>   }
>   
> -static void remove_hugetlb_folio(struct hstate *h, struct folio *folio,
> -							bool adjust_surplus)
> -{
> -	__remove_hugetlb_folio(h, folio, adjust_surplus, false);
> -}
> -
> -static void remove_hugetlb_folio_for_demote(struct hstate *h, struct folio *folio,
> -							bool adjust_surplus)
> -{
> -	__remove_hugetlb_folio(h, folio, adjust_surplus, true);
> -}
> -
>   static void add_hugetlb_folio(struct hstate *h, struct folio *folio,
>   			     bool adjust_surplus)
>   {
> -	int zeroed;
>   	int nid = folio_nid(folio);
>   
>   	VM_BUG_ON_FOLIO(!folio_test_hugetlb_vmemmap_optimized(folio), folio);
> @@ -1715,21 +1693,6 @@ static void add_hugetlb_folio(struct hstate *h, struct folio *folio,
>   	 */
>   	folio_set_hugetlb_vmemmap_optimized(folio);
>   
> -	/*
> -	 * This folio is about to be managed by the hugetlb allocator and
> -	 * should have no users.  Drop our reference, and check for others
> -	 * just in case.
> -	 */
> -	zeroed = folio_put_testzero(folio);
> -	if (unlikely(!zeroed))
> -		/*
> -		 * It is VERY unlikely soneone else has taken a ref
> -		 * on the folio.  In this case, we simply return as
> -		 * free_huge_folio() will be called when this other ref
> -		 * is dropped.
> -		 */
> -		return;
> -
>   	arch_clear_hugetlb_flags(folio);
>   	enqueue_hugetlb_folio(h, folio);
>   }
> @@ -1783,6 +1746,8 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
>   		spin_unlock_irq(&hugetlb_lock);
>   	}
>   
> +	folio_ref_unfreeze(folio, 1);
> +
>   	/*
>   	 * Non-gigantic pages demoted from CMA allocated gigantic pages
>   	 * need to be given back to CMA in free_gigantic_folio.
> @@ -3106,11 +3071,8 @@ static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
>   
>   free_new:
>   	spin_unlock_irq(&hugetlb_lock);
> -	if (new_folio) {
> -		/* Folio has a zero ref count, but needs a ref to be freed */
> -		folio_ref_unfreeze(new_folio, 1);
> +	if (new_folio)
>   		update_and_free_hugetlb_folio(h, new_folio, false);
> -	}
>   
>   	return ret;
>   }
> @@ -3965,7 +3927,7 @@ static int demote_free_hugetlb_folio(struct hstate *h, struct folio *folio)
>   
>   	target_hstate = size_to_hstate(PAGE_SIZE << h->demote_order);
>   
> -	remove_hugetlb_folio_for_demote(h, folio, false);
> +	remove_hugetlb_folio(h, folio, false);
>   	spin_unlock_irq(&hugetlb_lock);
>   
>   	/*
> @@ -3979,7 +3941,6 @@ static int demote_free_hugetlb_folio(struct hstate *h, struct folio *folio)
>   		if (rc) {
>   			/* Allocation of vmemmmap failed, we can not demote folio */
>   			spin_lock_irq(&hugetlb_lock);
> -			folio_ref_unfreeze(folio, 1);
>   			add_hugetlb_folio(h, folio, false);
>   			return rc;
>   		}
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index fa00d61b6c5a..829112b0a914 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -455,6 +455,8 @@ static int __hugetlb_vmemmap_restore_folio(const struct hstate *h,
>   	unsigned long vmemmap_reuse;
>   
>   	VM_WARN_ON_ONCE_FOLIO(!folio_test_hugetlb(folio), folio);
> +	VM_WARN_ON_ONCE_FOLIO(folio_ref_count(folio), folio);
> +
>   	if (!folio_test_hugetlb_vmemmap_optimized(folio))
>   		return 0;
>   
> @@ -490,6 +492,9 @@ static int __hugetlb_vmemmap_restore_folio(const struct hstate *h,
>    */
>   int hugetlb_vmemmap_restore_folio(const struct hstate *h, struct folio *folio)
>   {
> +	/* avoid writes from page_ref_add_unless() while unfolding vmemmap */
> +	synchronize_rcu();
> +
>   	return __hugetlb_vmemmap_restore_folio(h, folio, 0);
>   }
>   
> @@ -514,6 +519,9 @@ long hugetlb_vmemmap_restore_folios(const struct hstate *h,
>   	long restored = 0;
>   	long ret = 0;
>   
> +	/* avoid writes from page_ref_add_unless() while unfolding vmemmap */
> +	synchronize_rcu();
> +
>   	list_for_each_entry_safe(folio, t_folio, folio_list, lru) {
>   		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
>   			ret = __hugetlb_vmemmap_restore_folio(h, folio,
> @@ -559,6 +567,8 @@ static int __hugetlb_vmemmap_optimize_folio(const struct hstate *h,
>   	unsigned long vmemmap_reuse;
>   
>   	VM_WARN_ON_ONCE_FOLIO(!folio_test_hugetlb(folio), folio);
> +	VM_WARN_ON_ONCE_FOLIO(folio_ref_count(folio), folio);
> +
>   	if (!vmemmap_should_optimize_folio(h, folio))
>   		return ret;
>   
> @@ -610,6 +620,9 @@ void hugetlb_vmemmap_optimize_folio(const struct hstate *h, struct folio *folio)
>   {
>   	LIST_HEAD(vmemmap_pages);
>   
> +	/* avoid writes from page_ref_add_unless() while folding vmemmap */
> +	synchronize_rcu();
> +
>   	__hugetlb_vmemmap_optimize_folio(h, folio, &vmemmap_pages, 0);
>   	free_vmemmap_page_list(&vmemmap_pages);
>   }
> @@ -653,6 +666,9 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
>   
>   	flush_tlb_all();
>   
> +	/* avoid writes from page_ref_add_unless() while folding vmemmap */
> +	synchronize_rcu();
> +
>   	list_for_each_entry(folio, folio_list, lru) {
>   		int ret;
>   


