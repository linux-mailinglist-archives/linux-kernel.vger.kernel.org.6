Return-Path: <linux-kernel+bounces-398036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D45E9BE490
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 11:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F78F1F23BAC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D701DE2DB;
	Wed,  6 Nov 2024 10:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j85Ez2JO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D482F44
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 10:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730889960; cv=none; b=JfvOANJrAoUScFplEGY8tFgGwvaZ9uOWW+X4v3qRkcnb994l6tTXtyPeMnfRZLuD6CQ7v6u7hs89XnLavTjhuXojeb/ueS4rYVbtw1tx4pE7tGIESwfRTa8jZj1SmEKzEjXNUlsOV0S4kALR53QDpmKvYKzrVqJmmtNbqH0oA+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730889960; c=relaxed/simple;
	bh=4hxFSfObS2fESiq8+i+IHUyDgOVaYAj4EnPemDLRDsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qw/l2eA3HMQZB9gF9EQGinLcliu9Sg+8pHFKWOBtJGdnSQDPDvWAs5p/yPRS2EIlHN/hwCZ88B+TblN2ZHNkMS0Qrr0jlnjbvncvtkMJQwVCcK41ZijHWRTw8B08SilockGO/CquizXd3Ie29XWCT65Fxp+L8+rJk2LwKEwUXF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j85Ez2JO; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730889959; x=1762425959;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4hxFSfObS2fESiq8+i+IHUyDgOVaYAj4EnPemDLRDsg=;
  b=j85Ez2JOUxFUiWhB0//2ja+LPOGM7NUaZGcpVp2o+5ocD8JnNGfxlL2Z
   hJS3eCxKI2b4n/6IclwWm/QQY760TmYaHS72N0qDaZjDXIdj9oHCeGSB+
   hmp6J0+mMxHLQNW2KeSwbkTozT9Lh7qVuoftjBAFhnYVjxFR4ndnRFgjd
   etju7RPj0g4IJXFgS5NqqKPN3+8hvNRGf/3B0E4EbM0JSRf2maX4Hckvr
   n6oz8EZYsvWl4uQhbxHcgXIJbEy1TGyyrxCtGeblXKenljvldBe9oGDfZ
   XW0wi5A4Of+NJpy8c4X1iSC8or5jdok56p74mDVXhrUr2NrOxeQ+5pbFQ
   A==;
X-CSE-ConnectionGUID: MR+HecxuQp+MmgTjc5RiWA==
X-CSE-MsgGUID: 19efjOdbQW2XPzcnqVUVDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="33525497"
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="33525497"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 02:45:58 -0800
X-CSE-ConnectionGUID: kftTS9oPQM+CbRYMnlTO1A==
X-CSE-MsgGUID: bevkhD42R1+lNOUTbMQ+RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="84380251"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 06 Nov 2024 02:44:47 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id C68C2A4B; Wed, 06 Nov 2024 12:44:45 +0200 (EET)
Date: Wed, 6 Nov 2024 12:44:45 +0200
From: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>, 
	David Hildenbrand <david@redhat.com>, Yang Shi <yang@os.amperecomputing.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	Yu Zhao <yuzhao@google.com>, John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] mm/huge_memory: add two new (yet used) functions
 for folio_split()
Message-ID: <e6ppwz5t4p4kvir6eqzoto4y5fmdjdxdyvxvtw43ncly4l4ogr@7ruqsay6i2h2>
References: <20241101150357.1752726-1-ziy@nvidia.com>
 <20241101150357.1752726-2-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101150357.1752726-2-ziy@nvidia.com>

On Fri, Nov 01, 2024 at 11:03:52AM -0400, Zi Yan wrote:
> This is a preparation patch, both added functions are not used yet.
> 

In subject: s/yet/not yet/

> The added __folio_split_without_mapping() is able to split a folio with
> its mapping removed in two manners: 1) uniform split (the existing way),
> and 2) buddy allocator like split.
> 
> The added __split_folio_to_order() can split a folio into any lower order.
> For uniform split, __folio_split_without_mapping() calls it once to split
> the given folio to the new order. For buddy allocator split,
> __folio_split_without_mapping() calls it (folio_order - new_order) times
> and each time splits the folio containing the given page to one lower
> order.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  mm/huge_memory.c | 328 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 327 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index f92068864469..f7649043ddb7 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3135,7 +3135,6 @@ static void remap_page(struct folio *folio, unsigned long nr, int flags)
>  static void lru_add_page_tail(struct folio *folio, struct page *tail,
>  		struct lruvec *lruvec, struct list_head *list)
>  {
> -	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>  	VM_BUG_ON_FOLIO(PageLRU(tail), folio);
>  	lockdep_assert_held(&lruvec->lru_lock);
>  
> @@ -3379,6 +3378,333 @@ bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins)
>  					caller_pins;
>  }
>  
> +static long page_in_folio_offset(struct page *page, struct folio *folio)
> +{
> +	long nr_pages = folio_nr_pages(folio);
> +	unsigned long pages_pfn = page_to_pfn(page);
> +	unsigned long folios_pfn = folio_pfn(folio);
> +
> +	if (pages_pfn >= folios_pfn && pages_pfn < (folios_pfn + nr_pages))
> +		return pages_pfn - folios_pfn;
> +
> +	return -EINVAL;
> +}
> +
> +/*
> + * It splits @folio into @new_order folios and copies the @folio metadata to
> + * all the resulting folios.
> + */
> +static int __split_folio_to_order(struct folio *folio, int new_order)
> +{
> +	int curr_order = folio_order(folio);
> +	long nr_pages = folio_nr_pages(folio);
> +	long new_nr_pages = 1 << new_order;
> +	long index;
> +
> +	if (curr_order <= new_order)
> +		return -EINVAL;
> +
> +	for (index = new_nr_pages; index < nr_pages; index += new_nr_pages) {

Hm. It is not clear why you skip the first new_nr_pages range. It worth a
comment.

> +		struct page *head = &folio->page;
> +		struct page *second_head = head + index;

I am not sure about 'second_head' name. Why it is better than page_tail?

> +
> +		/*
> +		 * Careful: new_folio is not a "real" folio before we cleared PageTail.
> +		 * Don't pass it around before clear_compound_head().
> +		 */
> +		struct folio *new_folio = (struct folio *)second_head;
> +
> +		VM_BUG_ON_PAGE(atomic_read(&second_head->_mapcount) != -1, second_head);
> +
> +		/*
> +		 * Clone page flags before unfreezing refcount.
> +		 *
> +		 * After successful get_page_unless_zero() might follow flags change,
> +		 * for example lock_page() which set PG_waiters.
> +		 *
> +		 * Note that for mapped sub-pages of an anonymous THP,
> +		 * PG_anon_exclusive has been cleared in unmap_folio() and is stored in
> +		 * the migration entry instead from where remap_page() will restore it.
> +		 * We can still have PG_anon_exclusive set on effectively unmapped and
> +		 * unreferenced sub-pages of an anonymous THP: we can simply drop
> +		 * PG_anon_exclusive (-> PG_mappedtodisk) for these here.
> +		 */
> +		second_head->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
> +		second_head->flags |= (head->flags &
> +				((1L << PG_referenced) |
> +				 (1L << PG_swapbacked) |
> +				 (1L << PG_swapcache) |
> +				 (1L << PG_mlocked) |
> +				 (1L << PG_uptodate) |
> +				 (1L << PG_active) |
> +				 (1L << PG_workingset) |
> +				 (1L << PG_locked) |
> +				 (1L << PG_unevictable) |
> +#ifdef CONFIG_ARCH_USES_PG_ARCH_2
> +				 (1L << PG_arch_2) |
> +#endif
> +#ifdef CONFIG_ARCH_USES_PG_ARCH_3
> +				 (1L << PG_arch_3) |
> +#endif
> +				 (1L << PG_dirty) |
> +				 LRU_GEN_MASK | LRU_REFS_MASK));
> +
> +		/* ->mapping in first and second tail page is replaced by other uses */
> +		VM_BUG_ON_PAGE(new_nr_pages > 2 && second_head->mapping != TAIL_MAPPING,
> +			       second_head);
> +		second_head->mapping = head->mapping;
> +		second_head->index = head->index + index;
> +
> +		/*
> +		 * page->private should not be set in tail pages. Fix up and warn once
> +		 * if private is unexpectedly set.
> +		 */
> +		if (unlikely(second_head->private)) {
> +			VM_WARN_ON_ONCE_PAGE(true, second_head);
> +			second_head->private = 0;
> +		}

New line.

> +		if (folio_test_swapcache(folio))
> +			new_folio->swap.val = folio->swap.val + index;
> +
> +		/* Page flags must be visible before we make the page non-compound. */
> +		smp_wmb();
> +
> +		/*
> +		 * Clear PageTail before unfreezing page refcount.
> +		 *
> +		 * After successful get_page_unless_zero() might follow put_page()
> +		 * which needs correct compound_head().
> +		 */
> +		clear_compound_head(second_head);
> +		if (new_order) {
> +			prep_compound_page(second_head, new_order);
> +			folio_set_large_rmappable(new_folio);
> +
> +			folio_set_order(folio, new_order);
> +		} else {
> +			if (PageHead(head))
> +				ClearPageCompound(head);

Huh? You only have to test for PageHead() because it is inside the loop.
It has to be done after loop is done.

> +		}
> +
> +		if (folio_test_young(folio))
> +			folio_set_young(new_folio);
> +		if (folio_test_idle(folio))
> +			folio_set_idle(new_folio);
> +
> +		folio_xchg_last_cpupid(new_folio, folio_last_cpupid(folio));
> +	}
> +
> +	return 0;
> +}
> +
> +#define for_each_folio_until_end_safe(iter, iter2, start, end)	\
> +	for (iter = start, iter2 = folio_next(start);		\
> +	     iter != end;					\
> +	     iter = iter2, iter2 = folio_next(iter2))

I am not sure if hiding it inside the macro helps reading the code.

> +
> +/*
> + * It splits a @folio (without mapping) to lower order smaller folios in two
> + * ways.

What do you mean by "without mapping". I initially thought that ->mapping
is NULL, but it is obviously not true. 

Do you mean unmapped?

> + * 1. uniform split: the given @folio into multiple @new_order small folios,
> + *    where all small folios have the same order. This is done when
> + *    uniform_split is true.
> + * 2. buddy allocator like split: the given @folio is split into half and one
> + *    of the half (containing the given page) is split into half until the
> + *    given @page's order becomes @new_order. This is done when uniform_split is
> + *    false.
> + *
> + * The high level flow for these two methods are:
> + * 1. uniform split: a single __split_folio_to_order() is called to split the
> + *    @folio into @new_order, then we traverse all the resulting folios one by
> + *    one in PFN ascending order and perform stats, unfreeze, adding to list,
> + *    and file mapping index operations.
> + * 2. buddy allocator like split: in general, folio_order - @new_order calls to
> + *    __split_folio_to_order() are called in the for loop to split the @folio
> + *    to one lower order at a time. The resulting small folios are processed
> + *    like what is done during the traversal in 1, except the one containing
> + *    @page, which is split in next for loop.
> + *
> + * After splitting, the caller's folio reference will be transferred to the
> + * folio containing @page. The other folios may be freed if they are not mapped.
> + *
> + * In terms of locking, after splitting,
> + * 1. uniform split leaves @page (or the folio contains it) locked;
> + * 2. buddy allocator like split leaves @folio locked.
> + *
> + * If @list is null, tail pages will be added to LRU list, otherwise, to @list.
> + *
> + * For !uniform_split, when -ENOMEM is returned, the original folio might be
> + * split. The caller needs to check the input folio.
> + */
> +static int __folio_split_without_mapping(struct folio *folio, int new_order,
> +		struct page *page, struct list_head *list, pgoff_t end,
> +		struct xa_state *xas, struct address_space *mapping,
> +		bool uniform_split)

It is not clear what state xas has to be on call.

> +{
> +	struct lruvec *lruvec;
> +	struct address_space *swap_cache = NULL;
> +	struct folio *origin_folio = folio;
> +	struct folio *next_folio = folio_next(folio);
> +	struct folio *new_folio;
> +	struct folio *next;
> +	int order = folio_order(folio);
> +	int split_order = order - 1;
> +	int nr_dropped = 0;
> +	int ret = 0;
> +
> +	if (folio_test_anon(folio) && folio_test_swapcache(folio)) {
> +		if (!uniform_split)
> +			return -EINVAL;

Why this limitation?

> +		swap_cache = swap_address_space(folio->swap);
> +		xa_lock(&swap_cache->i_pages);
> +	}
> +
> +	if (folio_test_anon(folio))
> +		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
> +
> +	/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
> +	lruvec = folio_lruvec_lock(folio);
> +
> +	/*
> +	 * split to new_order one order at a time. For uniform split,
> +	 * intermediate orders are skipped
> +	 */
> +	for (split_order = order - 1; split_order >= new_order; split_order--) {
> +		int old_order = folio_order(folio);
> +		struct folio *release;
> +		struct folio *end_folio = folio_next(folio);
> +		int status;
> +		bool stop_split = false;
> +
> +		if (folio_test_anon(folio) && split_order == 1)

Comment is missing.

> +			continue;
> +		if (uniform_split && split_order != new_order)
> +			continue;

What the point in the loop for uniform_split?

> +
> +		if (mapping) {
> +			/*
> +			 * uniform split has xas_split_alloc() called before
> +			 * irq is disabled, since xas_nomem() might not be
> +			 * able to allocate enough memory.
> +			 */
> +			if (uniform_split)
> +				xas_split(xas, folio, old_order);
> +			else {
> +				xas_set_order(xas, folio->index, split_order);
> +				xas_set_err(xas, -ENOMEM);
> +				if (xas_nomem(xas, 0))

0 gfp?

> +					xas_split(xas, folio, old_order);
> +				else {
> +					stop_split = true;
> +					ret = -ENOMEM;
> +					goto after_split;
> +				}
> +			}
> +		}
> +
> +		split_page_memcg(&folio->page, old_order, split_order);

__split_huge_page() has a comment for split_page_memcg(). Do we want to
keep it? Is it safe to call it under lruvec lock?

> +		split_page_owner(&folio->page, old_order, split_order);
> +		pgalloc_tag_split(folio, old_order, split_order);
> +
> +		status = __split_folio_to_order(folio, split_order);
> +
> +		if (status < 0)
> +			return status;
> +
> +after_split:
> +		/*
> +		 * Iterate through after-split folios and perform related
> +		 * operations. But in buddy allocator like split, the folio
> +		 * containing the specified page is skipped until its order
> +		 * is new_order, since the folio will be worked on in next
> +		 * iteration.
> +		 */
> +		for_each_folio_until_end_safe(release, next, folio, end_folio) {
> +			if (page_in_folio_offset(page, release) >= 0) {
> +				folio = release;
> +				if (split_order != new_order && !stop_split)
> +					continue;

I don't understand this condition.

> +			}
> +			if (folio_test_anon(release))
> +				mod_mthp_stat(folio_order(release),
> +						MTHP_STAT_NR_ANON, 1);

Add { } around the block.

> +
> +			/*
> +			 * Unfreeze refcount first. Additional reference from
> +			 * page cache.
> +			 */
> +			folio_ref_unfreeze(release,
> +				1 + ((!folio_test_anon(origin_folio) ||
> +				     folio_test_swapcache(origin_folio)) ?
> +					     folio_nr_pages(release) : 0));
> +
> +			if (release != origin_folio)
> +				lru_add_page_tail(origin_folio, &release->page,
> +						lruvec, list);
> +
> +			/* Some pages can be beyond EOF: drop them from page cache */
> +			if (release->index >= end) {
> +				if (shmem_mapping(origin_folio->mapping))
> +					nr_dropped++;
> +				else if (folio_test_clear_dirty(release))
> +					folio_account_cleaned(release,
> +						inode_to_wb(origin_folio->mapping->host));
> +				__filemap_remove_folio(release, NULL);
> +				folio_put(release);
> +			} else if (!folio_test_anon(release)) {
> +				__xa_store(&origin_folio->mapping->i_pages,
> +						release->index, &release->page, 0);
> +			} else if (swap_cache) {
> +				__xa_store(&swap_cache->i_pages,
> +						swap_cache_index(release->swap),
> +						&release->page, 0);
> +			}
> +		}
> +		xas_destroy(xas);
> +	}
> +
> +	unlock_page_lruvec(lruvec);
> +
> +	if (folio_test_anon(origin_folio)) {
> +		if (folio_test_swapcache(origin_folio))
> +			xa_unlock(&swap_cache->i_pages);
> +	} else
> +		xa_unlock(&mapping->i_pages);
> +
> +	/* Caller disabled irqs, so they are still disabled here */
> +	local_irq_enable();
> +
> +	if (nr_dropped)
> +		shmem_uncharge(mapping->host, nr_dropped);
> +
> +	remap_page(origin_folio, 1 << order,
> +			folio_test_anon(origin_folio) ?
> +				RMP_USE_SHARED_ZEROPAGE : 0);
> +
> +	/*
> +	 * At this point, folio should contain the specified page, so that it
> +	 * will be left to the caller to unlock it.
> +	 */
> +	for_each_folio_until_end_safe(new_folio, next, origin_folio, next_folio) {
> +		if (uniform_split && new_folio == folio)
> +			continue;
> +		if (!uniform_split && new_folio == origin_folio)
> +			continue;
> +
> +		folio_unlock(new_folio);
> +		/*
> +		 * Subpages may be freed if there wasn't any mapping
> +		 * like if add_to_swap() is running on a lru page that
> +		 * had its mapping zapped. And freeing these pages
> +		 * requires taking the lru_lock so we do the put_page
> +		 * of the tail pages after the split is complete.
> +		 */
> +		free_page_and_swap_cache(&new_folio->page);
> +	}
> +	return ret;
> +}
> +
>  /*
>   * This function splits a large folio into smaller folios of order @new_order.
>   * @page can point to any page of the large folio to split. The split operation
> -- 
> 2.45.2
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

