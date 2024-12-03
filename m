Return-Path: <linux-kernel+bounces-428641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6B39E11AD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 04:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18630B226C9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 03:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE2E154C1D;
	Tue,  3 Dec 2024 03:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LbSI0OVY"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6211632DE
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 03:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733196236; cv=none; b=btz758dq6ZX7SnvkBDt/kc01HocFXXs1UKu2/A7yhv+bud9lAQb/2PHn4TCMT5DYNaTJXaVE8m96p1hd518J9e1SgrSkKMG78cO7UfjVa5NAEB+2VMAnyp4OtqnoTfvJwALJDlkbHKzLT/DaFWe127VuIZLCVrK+gEVGygxau7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733196236; c=relaxed/simple;
	bh=1NBpPnj7JsyXCH2gT2QzRrg/GNj+xmAw/ZMCFHqtpJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZwmdAx3egU+6ru1MxWBjp+H2oCju3s4n90i0+fqu58RTEyKSq5p1lOSpyFBSuGsPq6v8qUnEUUb56mI96heXm6emLOX5X8tFcLnORihchWIiKGNxT22osbGIm8KBT47+Nsbx8ZezuJ/k+UP6bprV3B49XbPwq8EabCquFOMm67k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LbSI0OVY; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d3d9e9f5-b296-4a30-9284-e5570b1ddfce@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733196230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wj+5GXCu0vCAWHxv1tYtK3ssQIvbHpWALbj9FVJY9Ro=;
	b=LbSI0OVYtJnBrx+mEg4u1wsqtcmCXYMfLfARm/pPW0w4ZRQh4S/I/GaOMFUXrTegzxX/Oc
	Mo4+CgwnaYB+KtF5r4UqnQVRyGDKZeByhFLpIvvYLAJg6hqDd8QHWUVbI92J04wVYuDQlA
	FPhi86/thgzzlf01WoC/zq9uNTQvEYU=
Date: Tue, 3 Dec 2024 11:23:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 1/2] mm: zswap: Modified zswap_store_page() to process
 multiple pages in a folio.
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org,
 yosryahmed@google.com, nphamcs@gmail.com, usamaarif642@gmail.com,
 ryan.roberts@arm.com, 21cnbao@gmail.com, akpm@linux-foundation.org
Cc: wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
References: <20241127225324.6770-1-kanchana.p.sridhar@intel.com>
 <20241127225324.6770-2-kanchana.p.sridhar@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20241127225324.6770-2-kanchana.p.sridhar@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/11/28 06:53, Kanchana P Sridhar wrote:
> Modified zswap_store() to store the folio in batches of
> SWAP_CRYPTO_BATCH_SIZE pages. Accordingly, refactored zswap_store_page()
> into zswap_store_pages() that processes a range of pages in the folio.
> zswap_store_pages() is a vectorized version of zswap_store_page().

Maybe I missed something, but this refactor change looks confused to me.

Why not zswap_store_pages() just reuse the existing zswap_store_page()?
```
zswap_store_pages()
	compressed_bytes = 0
	for each page in this batch
		size = zswap_store_page(page)
		if (size < 0)
			return size;
		compressed_bytes += size;
	return compressed_bytes;
```

Thanks.

> 
> For now, zswap_store_pages() will sequentially compress these pages with
> zswap_compress().
> 
> These changes are follow-up to code review comments received for [1], and
> are intended to set up zswap_store() for batching with Intel IAA.
> 
> [1]: https://patchwork.kernel.org/project/linux-mm/patch/20241123070127.332773-11-kanchana.p.sridhar@intel.com/
> 
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> ---
>   include/linux/zswap.h |   1 +
>   mm/zswap.c            | 154 ++++++++++++++++++++++++------------------
>   2 files changed, 88 insertions(+), 67 deletions(-)
> 
> diff --git a/include/linux/zswap.h b/include/linux/zswap.h
> index d961ead91bf1..05a81e750744 100644
> --- a/include/linux/zswap.h
> +++ b/include/linux/zswap.h
> @@ -7,6 +7,7 @@
>   
>   struct lruvec;
>   
> +#define SWAP_CRYPTO_BATCH_SIZE 8UL
>   extern atomic_long_t zswap_stored_pages;
>   
>   #ifdef CONFIG_ZSWAP
> diff --git a/mm/zswap.c b/mm/zswap.c
> index f6316b66fb23..b09d1023e775 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1409,78 +1409,96 @@ static void shrink_worker(struct work_struct *w)
>   * main API
>   **********************************/
>   
> -static ssize_t zswap_store_page(struct page *page,
> -				struct obj_cgroup *objcg,
> -				struct zswap_pool *pool)
> +/*
> + * Store multiple pages in @folio, starting from the page at index @si up to
> + * and including the page at index @ei.
> + */
> +static ssize_t zswap_store_pages(struct folio *folio,
> +				 long si,
> +				 long ei,
> +				 struct obj_cgroup *objcg,
> +				 struct zswap_pool *pool)
>   {
> -	swp_entry_t page_swpentry = page_swap_entry(page);
> +	struct page *page;
> +	swp_entry_t page_swpentry;
>   	struct zswap_entry *entry, *old;
> +	size_t compressed_bytes = 0;
> +	u8 nr_pages = ei - si + 1;
> +	u8 i;
> +
> +	for (i = 0; i < nr_pages; ++i) {
> +		page = folio_page(folio, si + i);
> +		page_swpentry = page_swap_entry(page);
> +
> +		/* allocate entry */
> +		entry = zswap_entry_cache_alloc(GFP_KERNEL, page_to_nid(page));
> +		if (!entry) {
> +			zswap_reject_kmemcache_fail++;
> +			return -EINVAL;
> +		}
>   
> -	/* allocate entry */
> -	entry = zswap_entry_cache_alloc(GFP_KERNEL, page_to_nid(page));
> -	if (!entry) {
> -		zswap_reject_kmemcache_fail++;
> -		return -EINVAL;
> -	}
> -
> -	if (!zswap_compress(page, entry, pool))
> -		goto compress_failed;
> +		if (!zswap_compress(page, entry, pool))
> +			goto compress_failed;
>   
> -	old = xa_store(swap_zswap_tree(page_swpentry),
> -		       swp_offset(page_swpentry),
> -		       entry, GFP_KERNEL);
> -	if (xa_is_err(old)) {
> -		int err = xa_err(old);
> +		old = xa_store(swap_zswap_tree(page_swpentry),
> +			       swp_offset(page_swpentry),
> +			       entry, GFP_KERNEL);
> +		if (xa_is_err(old)) {
> +			int err = xa_err(old);
>   
> -		WARN_ONCE(err != -ENOMEM, "unexpected xarray error: %d\n", err);
> -		zswap_reject_alloc_fail++;
> -		goto store_failed;
> -	}
> +			WARN_ONCE(err != -ENOMEM, "unexpected xarray error: %d\n", err);
> +			zswap_reject_alloc_fail++;
> +			goto store_failed;
> +		}
>   
> -	/*
> -	 * We may have had an existing entry that became stale when
> -	 * the folio was redirtied and now the new version is being
> -	 * swapped out. Get rid of the old.
> -	 */
> -	if (old)
> -		zswap_entry_free(old);
> +		/*
> +		 * We may have had an existing entry that became stale when
> +		 * the folio was redirtied and now the new version is being
> +		 * swapped out. Get rid of the old.
> +		 */
> +		if (old)
> +			zswap_entry_free(old);
>   
> -	/*
> -	 * The entry is successfully compressed and stored in the tree, there is
> -	 * no further possibility of failure. Grab refs to the pool and objcg.
> -	 * These refs will be dropped by zswap_entry_free() when the entry is
> -	 * removed from the tree.
> -	 */
> -	zswap_pool_get(pool);
> -	if (objcg)
> -		obj_cgroup_get(objcg);
> +		/*
> +		 * The entry is successfully compressed and stored in the tree, there is
> +		 * no further possibility of failure. Grab refs to the pool and objcg.
> +		 * These refs will be dropped by zswap_entry_free() when the entry is
> +		 * removed from the tree.
> +		 */
> +		zswap_pool_get(pool);
> +		if (objcg)
> +			obj_cgroup_get(objcg);
>   
> -	/*
> -	 * We finish initializing the entry while it's already in xarray.
> -	 * This is safe because:
> -	 *
> -	 * 1. Concurrent stores and invalidations are excluded by folio lock.
> -	 *
> -	 * 2. Writeback is excluded by the entry not being on the LRU yet.
> -	 *    The publishing order matters to prevent writeback from seeing
> -	 *    an incoherent entry.
> -	 */
> -	entry->pool = pool;
> -	entry->swpentry = page_swpentry;
> -	entry->objcg = objcg;
> -	entry->referenced = true;
> -	if (entry->length) {
> -		INIT_LIST_HEAD(&entry->lru);
> -		zswap_lru_add(&zswap_list_lru, entry);
> -	}
> +		/*
> +		 * We finish initializing the entry while it's already in xarray.
> +		 * This is safe because:
> +		 *
> +		 * 1. Concurrent stores and invalidations are excluded by folio lock.
> +		 *
> +		 * 2. Writeback is excluded by the entry not being on the LRU yet.
> +		 *    The publishing order matters to prevent writeback from seeing
> +		 *    an incoherent entry.
> +		 */
> +		entry->pool = pool;
> +		entry->swpentry = page_swpentry;
> +		entry->objcg = objcg;
> +		entry->referenced = true;
> +		if (entry->length) {
> +			INIT_LIST_HEAD(&entry->lru);
> +			zswap_lru_add(&zswap_list_lru, entry);
> +		}
>   
> -	return entry->length;
> +		compressed_bytes += entry->length;
> +		continue;
>   
>   store_failed:
> -	zpool_free(pool->zpool, entry->handle);
> +		zpool_free(pool->zpool, entry->handle);
>   compress_failed:
> -	zswap_entry_cache_free(entry);
> -	return -EINVAL;
> +		zswap_entry_cache_free(entry);
> +		return -EINVAL;
> +	}
> +
> +	return compressed_bytes;
>   }
>   
>   bool zswap_store(struct folio *folio)
> @@ -1492,7 +1510,7 @@ bool zswap_store(struct folio *folio)
>   	struct zswap_pool *pool;
>   	size_t compressed_bytes = 0;
>   	bool ret = false;
> -	long index;
> +	long si, ei, incr = SWAP_CRYPTO_BATCH_SIZE;
>   
>   	VM_WARN_ON_ONCE(!folio_test_locked(folio));
>   	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> @@ -1526,11 +1544,13 @@ bool zswap_store(struct folio *folio)
>   		mem_cgroup_put(memcg);
>   	}
>   
> -	for (index = 0; index < nr_pages; ++index) {
> -		struct page *page = folio_page(folio, index);
> +	/* Store the folio in batches of SWAP_CRYPTO_BATCH_SIZE pages. */
> +	for (si = 0, ei = min(si + incr - 1, nr_pages - 1);
> +	     ((si < nr_pages) && (ei < nr_pages));
> +	     si = ei + 1, ei = min(si + incr - 1, nr_pages - 1)) {
>   		ssize_t bytes;
>   
> -		bytes = zswap_store_page(page, objcg, pool);
> +		bytes = zswap_store_pages(folio, si, ei, objcg, pool);
>   		if (bytes < 0)
>   			goto put_pool;
>   		compressed_bytes += bytes;
> @@ -1565,9 +1585,9 @@ bool zswap_store(struct folio *folio)
>   		struct zswap_entry *entry;
>   		struct xarray *tree;
>   
> -		for (index = 0; index < nr_pages; ++index) {
> -			tree = swap_zswap_tree(swp_entry(type, offset + index));
> -			entry = xa_erase(tree, offset + index);
> +		for (si = 0; si < nr_pages; ++si) {
> +			tree = swap_zswap_tree(swp_entry(type, offset + si));
> +			entry = xa_erase(tree, offset + si);
>   			if (entry)
>   				zswap_entry_free(entry);
>   		}

