Return-Path: <linux-kernel+bounces-342359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4FF988DF3
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 08:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E9281F21D78
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 06:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C0519CCE7;
	Sat, 28 Sep 2024 06:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="raNXYYiX"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931DB4A08
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 06:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727503576; cv=none; b=Tq7gd7jq6dlefKeJrr9gJGkfVsNZ9Pg2jJgOtPKp07T2MYFM1IpjKOXyyhUTxgO2RNvagfZPStsdO75sUVLuuOzTGMNwabT9JHR+Mq+FY4eBM7M+e+U+MfoADZK6BrFscyiAU9TbMV0WDjGTT2Ij7aofBauXp4HwCmmtQZZk7vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727503576; c=relaxed/simple;
	bh=YTlgB5FsYs3yuLlUnmzhB+p4gSPBpwX3hgZzvfjo9P0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jk2E/xf+9swbLVom0Mo9CSiJlg6AJynTEDqWcHWit/j9dKCA3VptPeZUb2pw2tH/ONQb0TFkRZ7dlXNCi8wOghNNTWeBau8BDnUwGDlj2ZqOkZCkeesQuGOazWnvNy3Fsy+6x2rGdEhAiJ6MGHwZxvbUVE3i2yG/gc1IuGLNYTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=raNXYYiX; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1fb8ce55-c8d2-48ed-9ce0-ff000affa5ca@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727503568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FhPJc1NCmKsTKcCzxVVEFYIbxaUeBFvjnxthw0Ep+is=;
	b=raNXYYiXN1ISAouEuSeya4/wFkmUxdFB1TaRR6Hryz0awFPTqs9dMAEIkdeKsEbM3WLN9/
	9hkf9qiHIazdq5TXqjSfl8QvNbqFrSGcZYB+wo8oJE1TWVLNEby8LB7IlF8RSJ8IgsAmnT
	u0hxVSOg7+Klc/EMLMO954QD2/yxI44=
Date: Sat, 28 Sep 2024 14:05:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v8 6/8] mm: zswap: Support large folios in zswap_store().
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org,
 yosryahmed@google.com, nphamcs@gmail.com, usamaarif642@gmail.com,
 shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com,
 21cnbao@gmail.com, akpm@linux-foundation.org
Cc: nanhai.zou@intel.com, wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
References: <20240928021620.8369-1-kanchana.p.sridhar@intel.com>
 <20240928021620.8369-7-kanchana.p.sridhar@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240928021620.8369-7-kanchana.p.sridhar@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/9/28 10:16, Kanchana P Sridhar wrote:
> zswap_store() will store large folios by compressing them page by page.
> 
> This patch provides a sequential implementation of storing a large folio
> in zswap_store() by iterating through each page in the folio to compress
> and store it in the zswap zpool.
> 
> Towards this goal, zswap_compress() is modified to take a page instead
> of a folio as input.
> 
> Each page's swap offset is stored as a separate zswap entry.
> 
> We check the cgroup zswap limit and the zpool utilization against
> the zswap max/accept_threshold limits once, at the beginning of
> zswap_store. We also obtain a percpu_ref_tryget() reference to the
> current zswap_pool at the start of zswap_store to prevent it from
> being deleted while the folio is being stored.
> 
> If these one-time checks pass, we compress the sub-pages of the folio,
> while maintaining a running count of compressed bytes for all the folio's
> sub-pages. If all pages are successfully compressed and stored, we do the
> cgroup zswap charging with the total compressed bytes, and batch update
> the zswap_stored_pages atomic/zswpout event stats with folio_nr_pages()
> once, before returning from zswap_store.
> 
> The patch adds a new zswap_pool_get() function that is called in the
> sub-page level "zswap_store_page()" function.
> 
> If an error is encountered during the store of any page in the folio,
> all pages in that folio currently stored in zswap will be invalidated.
> Thus, a folio is either entirely stored in zswap, or entirely not stored
> in zswap.
> 
> This patch forms the basis for building compress batching of pages in a
> large folio in zswap_store by compressing up to say, 8 pages of the folio
> in parallel in hardware using the Intel In-Memory Analytics Accelerator
> (Intel IAA).
> 
> This change reuses and adapts the functionality in Ryan Roberts' RFC
> patch [1]:
> 
>    "[RFC,v1] mm: zswap: Store large folios without splitting"
> 
>    [1] https://lore.kernel.org/linux-mm/20231019110543.3284654-1-ryan.roberts@arm.com/T/#u
> 
> Also, addressed some of the RFC comments from the discussion in [1].
> 
> Co-developed-by: Ryan Roberts
> Signed-off-by:

This seems not right.

> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> ---
>   mm/zswap.c | 227 ++++++++++++++++++++++++++++++++++++++---------------
>   1 file changed, 165 insertions(+), 62 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 43e4e216db41..b8395ddf7b7c 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -411,6 +411,16 @@ static int __must_check zswap_pool_tryget(struct zswap_pool *pool)
>   	return percpu_ref_tryget(&pool->ref);
>   }
>   
> +/*
> + * Note: zswap_pool_get() should only be called after zswap_pool_tryget()
> + * returns success. zswap_pool_tryget() returns success only if the "pool" is
> + * non-NULL and the "&pool->ref" is non-0.
> + */
> +static void zswap_pool_get(struct zswap_pool *pool)
> +{
> +	percpu_ref_get(&pool->ref);
> +}

percpu_ref_tryget_many() could be considered? But this looks ok too.

Thanks.

> +
>   static void zswap_pool_put(struct zswap_pool *pool)
>   {
>   	percpu_ref_put(&pool->ref);
> @@ -1402,38 +1412,35 @@ static void shrink_worker(struct work_struct *w)
>   /*********************************
>   * main API
>   **********************************/
> -bool zswap_store(struct folio *folio)
> +
> +/*
> + * Stores the page at specified "index" in a folio.
> + *
> + * @folio: The folio to store in zswap.
> + * @index: Index into the page in the folio that this function will store.
> + * @objcg: The folio's objcg.
> + * @pool:  The zswap_pool to store the compressed data for the page.
> + *         The caller should have obtained a reference to a valid
> + *         zswap_pool by calling zswap_pool_tryget(), to pass as this
> + *         argument.
> + * @compressed_bytes: The compressed entry->length value is added
> + *                    to this, so that the caller can get the total
> + *                    compressed lengths of all sub-pages in a folio.
> + */
> +static bool zswap_store_page(struct folio *folio, long index,
> +			     struct obj_cgroup *objcg,
> +			     struct zswap_pool *pool,
> +			     size_t *compressed_bytes)
>   {
> +	struct page *page = folio_page(folio, index);
>   	swp_entry_t swp = folio->swap;
> -	pgoff_t offset = swp_offset(swp);
>   	struct xarray *tree = swap_zswap_tree(swp);
> +	pgoff_t offset = swp_offset(swp) + index;
>   	struct zswap_entry *entry, *old;
> -	struct obj_cgroup *objcg = NULL;
> -	struct mem_cgroup *memcg = NULL;
> -
> -	VM_WARN_ON_ONCE(!folio_test_locked(folio));
> -	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> +	int type = swp_type(swp);
>   
> -	/* Large folios aren't supported */
> -	if (folio_test_large(folio))
> -		return false;
> -
> -	if (!zswap_enabled)
> -		goto check_old;
> -
> -	/* Check cgroup limits */
> -	objcg = get_obj_cgroup_from_folio(folio);
> -	if (objcg && !obj_cgroup_may_zswap(objcg)) {
> -		memcg = get_mem_cgroup_from_objcg(objcg);
> -		if (shrink_memcg(memcg)) {
> -			mem_cgroup_put(memcg);
> -			goto reject;
> -		}
> -		mem_cgroup_put(memcg);
> -	}
> -
> -	if (zswap_check_limits())
> -		goto reject;
> +	if (objcg)
> +		obj_cgroup_get(objcg);
>   
>   	/* allocate entry */
>   	entry = zswap_entry_cache_alloc(GFP_KERNEL, folio_nid(folio));
> @@ -1442,24 +1449,21 @@ bool zswap_store(struct folio *folio)
>   		goto reject;
>   	}
>   
> -	/* if entry is successfully added, it keeps the reference */
> -	entry->pool = zswap_pool_current_get();
> -	if (!entry->pool)
> -		goto freepage;
> +	/*
> +	 * We get here only after the call to zswap_pool_tryget() in the
> +	 * caller, zswap_store(), has returned success. Hence it is safe
> +	 * to call zswap_pool_get().
> +	 *
> +	 * if entry is successfully added, it keeps the reference
> +	 */
> +	zswap_pool_get(pool);
>   
> -	if (objcg) {
> -		memcg = get_mem_cgroup_from_objcg(objcg);
> -		if (memcg_list_lru_alloc(memcg, &zswap_list_lru, GFP_KERNEL)) {
> -			mem_cgroup_put(memcg);
> -			goto put_pool;
> -		}
> -		mem_cgroup_put(memcg);
> -	}
> +	entry->pool = pool;
>   
> -	if (!zswap_compress(&folio->page, entry))
> +	if (!zswap_compress(page, entry))
>   		goto put_pool;
>   
> -	entry->swpentry = swp;
> +	entry->swpentry = swp_entry(type, offset);
>   	entry->objcg = objcg;
>   	entry->referenced = true;
>   
> @@ -1480,11 +1484,6 @@ bool zswap_store(struct folio *folio)
>   	if (old)
>   		zswap_entry_free(old);
>   
> -	if (objcg) {
> -		obj_cgroup_charge_zswap(objcg, entry->length);
> -		count_objcg_event(objcg, ZSWPOUT);
> -	}
> -
>   	/*
>   	 * We finish initializing the entry while it's already in xarray.
>   	 * This is safe because:
> @@ -1496,36 +1495,140 @@ bool zswap_store(struct folio *folio)
>   	 *    an incoherent entry.
>   	 */
>   	if (entry->length) {
> +		*compressed_bytes += entry->length;
>   		INIT_LIST_HEAD(&entry->lru);
>   		zswap_lru_add(&zswap_list_lru, entry);
>   	}
>   
> -	/* update stats */
> -	atomic_long_inc(&zswap_stored_pages);
> -	count_vm_event(ZSWPOUT);
> -
>   	return true;
>   
>   store_failed:
>   	zpool_free(entry->pool->zpool, entry->handle);
>   put_pool:
> -	zswap_pool_put(entry->pool);
> -freepage:
> +	zswap_pool_put(pool);
>   	zswap_entry_cache_free(entry);
>   reject:
>   	obj_cgroup_put(objcg);
> -	if (zswap_pool_reached_full)
> -		queue_work(shrink_wq, &zswap_shrink_work);
> -check_old:
> +	return false;
> +}
> +
> +bool zswap_store(struct folio *folio)
> +{
> +	long nr_pages = folio_nr_pages(folio);
> +	swp_entry_t swp = folio->swap;
> +	struct xarray *tree = swap_zswap_tree(swp);
> +	pgoff_t offset = swp_offset(swp);
> +	struct obj_cgroup *objcg = NULL;
> +	struct mem_cgroup *memcg = NULL;
> +	struct zswap_pool *pool;
> +	size_t compressed_bytes = 0;
> +	bool ret = false;
> +	long index;
> +
> +	VM_WARN_ON_ONCE(!folio_test_locked(folio));
> +	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> +
> +	if (!zswap_enabled)
> +		goto reject;
> +
>   	/*
> -	 * If the zswap store fails or zswap is disabled, we must invalidate the
> -	 * possibly stale entry which was previously stored at this offset.
> -	 * Otherwise, writeback could overwrite the new data in the swapfile.
> +	 * Check cgroup zswap limits:
> +	 *
> +	 * The cgroup zswap limit check is done once at the beginning of
> +	 * zswap_store(). The cgroup charging is done once, at the end
> +	 * of a successful folio store. What this means is, if the cgroup
> +	 * was within the zswap_max limit at the beginning of a large folio
> +	 * store, it could go over the limit by at most (HPAGE_PMD_NR - 1)
> +	 * pages.
>   	 */
> -	entry = xa_erase(tree, offset);
> -	if (entry)
> -		zswap_entry_free(entry);
> -	return false;
> +	objcg = get_obj_cgroup_from_folio(folio);
> +	if (objcg && !obj_cgroup_may_zswap(objcg)) {
> +		memcg = get_mem_cgroup_from_objcg(objcg);
> +		if (shrink_memcg(memcg)) {
> +			mem_cgroup_put(memcg);
> +			goto put_objcg;
> +		}
> +		mem_cgroup_put(memcg);
> +	}
> +
> +	/*
> +	 * Check zpool utilization against zswap limits:
> +	 *
> +	 * The zswap zpool utilization is also checked against the limits
> +	 * just once, at the start of zswap_store(). If the check passes,
> +	 * any breaches of the limits set by zswap_max_pages() or
> +	 * zswap_accept_thr_pages() that may happen while storing this
> +	 * folio, will only be detected during the next call to
> +	 * zswap_store() by any process.
> +	 */
> +	if (zswap_check_limits())
> +		goto put_objcg;
> +
> +	pool = zswap_pool_current_get();
> +	if (!pool)
> +		goto put_objcg;
> +
> +	if (objcg) {
> +		memcg = get_mem_cgroup_from_objcg(objcg);
> +		if (memcg_list_lru_alloc(memcg, &zswap_list_lru, GFP_KERNEL)) {
> +			mem_cgroup_put(memcg);
> +			goto put_pool;
> +		}
> +		mem_cgroup_put(memcg);
> +	}
> +
> +	/*
> +	 * Store each page of the folio as a separate entry. If we fail to
> +	 * store a page, unwind by deleting all the pages for this folio
> +	 * currently in zswap.
> +	 */
> +	for (index = 0; index < nr_pages; ++index) {
> +		if (!zswap_store_page(folio, index, objcg, pool, &compressed_bytes))
> +			goto put_pool;
> +	}
> +
> +	/*
> +	 * All pages in the folio have been successfully stored.
> +	 * Batch update the cgroup zswap charging, zswap_stored_page atomic,
> +	 * and ZSWPOUT event stats.
> +	 */
> +	if (objcg) {
> +		obj_cgroup_charge_zswap(objcg, compressed_bytes);
> +		count_objcg_events(objcg, ZSWPOUT, nr_pages);
> +	}
> +
> +	/* update stats */
> +	atomic_long_add(nr_pages, &zswap_stored_pages);
> +	count_vm_events(ZSWPOUT, nr_pages);
> +
> +	ret = true;
> +
> +put_pool:
> +	zswap_pool_put(pool);
> +put_objcg:
> +	obj_cgroup_put(objcg);
> +reject:
> +	/*
> +	 * If the zswap store fails or zswap is disabled, we must invalidate
> +	 * the possibly stale entries which were previously stored at the
> +	 * offsets corresponding to each page of the folio. Otherwise,
> +	 * writeback could overwrite the new data in the swapfile.
> +	 */
> +	if (!ret) {
> +		struct zswap_entry *entry;
> +		long i;
> +
> +		for (i = 0; i < nr_pages; ++i) {
> +			entry = xa_erase(tree, offset + i);
> +			if (entry)
> +				zswap_entry_free(entry);
> +		}
> +
> +		if (zswap_pool_reached_full)
> +			queue_work(shrink_wq, &zswap_shrink_work);
> +	}
> +
> +	return ret;
>   }
>   
>   bool zswap_load(struct folio *folio)

