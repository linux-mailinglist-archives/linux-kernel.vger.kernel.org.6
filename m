Return-Path: <linux-kernel+bounces-549917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB8FA55894
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09EA83AA23D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AC8207E00;
	Thu,  6 Mar 2025 21:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hnnseqM2"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A930B206F2C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 21:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741295835; cv=none; b=YxuyCUOv9JvwOMWGPeX+MrK8tIfJF15dolZSgwBT8rhzh0HTJeMRKHEenvlfB0AgftOWFidoiVMhcyYsUdZXasb5UNSZiGhDlBgg2a4g0GpczD2p6uAQiwFh8vpkUemOD51VN4rYPMDyq0OP6XtFcIsb2eBVW0ZITEui+2U46QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741295835; c=relaxed/simple;
	bh=lKUnc+k2tCvdgvcgqcJ/La7e5vNDvCgOT1ZWRtfXcTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXK96z92N28Me07HG3ZPStVaDQMP3gDSMOFOS+/Yh88aOGrOAJt2gmhio5t1dSZOnibn/cNHEa/u1PWHhLDY9KTGbRE2cuUfZ/mQLfregZfa7XiKuYZQfKVr9RY4fDUqixzihyewBSqv7LLBiZio/H5FWjciPxExW3n1xCaPu/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hnnseqM2; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 6 Mar 2025 21:17:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741295829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ci0UMv23gg6vQ2IQ5PhtLQi5ohObGD7OtEDCpRfB8wA=;
	b=hnnseqM2ic3VKuKVEcPt2jEMspBNkSDlqojhTPZqJj22gFmqe1hRtLh3hGsF079n88Hb80
	WeDYpFJ8Z0dmU8l8jqoz7v1jb0SKmp+1JU51RjaF0tTiHxhGP50TjNNvlEf17mZ8xEv5DT
	npjgXaoLUtRQDmSXxaWVmn5gervKefo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org,
	nphamcs@gmail.com, chengming.zhou@linux.dev, usamaarif642@gmail.com,
	ryan.roberts@arm.com, 21cnbao@gmail.com,
	ying.huang@linux.alibaba.com, akpm@linux-foundation.org,
	linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
	davem@davemloft.net, clabbe@baylibre.com, ardb@kernel.org,
	ebiggers@google.com, surenb@google.com, kristen.c.accardi@intel.com,
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Subject: Re: [PATCH v8 14/14] mm: zswap: Compress batching with request
 chaining in zswap_store() of large folios.
Message-ID: <Z8oQzmL_P9W5Mad2@google.com>
References: <20250303084724.6490-1-kanchana.p.sridhar@intel.com>
 <20250303084724.6490-15-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303084724.6490-15-kanchana.p.sridhar@intel.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 03, 2025 at 12:47:24AM -0800, Kanchana P Sridhar wrote:
> This patch introduces three new procedures:
> 
>  zswap_store_folio()
>  zswap_store_pages()
>  zswap_batch_compress()
> 
> zswap_store_folio() stores a folio in chunks of "batch_size" pages. If the
> compressor supports batching and has multiple acomp_ctx->nr_reqs, the
> batch_size will be the acomp_ctx->nr_reqs. If the compressor does not
> support batching, the batch_size will be ZSWAP_MAX_BATCH_SIZE. The
> compressor having multiple acomp_ctx->nr_reqs is passed as a bool
> "batching" parameter to zswap_store_pages() and zswap_batch_compress().
> This refactorization allows us to move the loop over the folio's pages from
> zswap_store() to zswap_store_folio(), and also enables batching.
> 
> zswap_store_pages() implements all the computes done earlier in
> zswap_store_page() for a single-page, for multiple pages in a folio, namely
> a "batch". zswap_store_pages() starts by allocating all zswap entries
> required to store the batch. Next, it calls zswap_batch_compress() to
> compress the batch. Finally, it adds the batch's zswap entries to the
> xarray and LRU, charges zswap memory and increments zswap stats.
> 
> The error handling and cleanup required for all failure scenarios that can
> occur while storing a batch in zswap are consolidated to a single
> "store_pages_failed" label in zswap_store_pages().
> 
> And finally, this patch introduces zswap_batch_compress(), which does the
> following:
>   - If the compressor supports batching, sets up a request chain for
>     compressing the batch in one shot. If Intel IAA is the zswap
>     compressor, the request chain will be compressed in parallel in
>     hardware. If all requests in the chain are compressed without errors,
>     the compressed buffers are then stored in zpool.
>   - If the compressor does not support batching, each page in the batch is
>     compressed and stored sequentially. zswap_batch_compress() replaces
>     zswap_compress(), thereby eliminating code duplication and facilitating
>     maintainability of the code with the introduction of batching.
> 
> The call to the crypto layer is exactly the same in both cases: when batch
> compressing a request chain or when sequentially compressing each page in
> the batch.
> 
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> ---

High-level comment: It may be better to break this down into two
patches, one reworking the code to process folios in batches, and one to
add support for compression batching and request chaining. This may make
it more digestable.

>  mm/zswap.c | 396 ++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 270 insertions(+), 126 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index fae59d6d5147..135d5792ce50 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1051,74 +1051,141 @@ static void acomp_ctx_put_unlock(struct crypto_acomp_ctx *acomp_ctx)
>  	mutex_unlock(&acomp_ctx->mutex);
>  }
>  
> -static bool zswap_compress(struct page *page, struct zswap_entry *entry,
> -			   struct zswap_pool *pool)
> +/*
> + * Unified code paths for compressors that do and do not support
> + * batching. This procedure will compress multiple @nr_pages in @folio,
> + * starting from @index.
> + * If @batching is set to true, it will create a request chain for
> + * compression batching. It is assumed that the caller has verified
> + * that the acomp_ctx->nr_reqs is at least @nr_pages.
> + * If @batching is set to false, it will process each page sequentially.
> + * In both cases, if all compressions were successful, it will proceed
> + * to store the compressed buffers in zpool.
> + */
> +static bool zswap_batch_compress(struct folio *folio,
> +				 long index,
> +				 unsigned int nr_pages,
> +				 struct zswap_entry *entries[],
> +				 struct zswap_pool *pool,
> +				 struct crypto_acomp_ctx *acomp_ctx,
> +				 bool batching)

If we have a single compress function let's keep it called
zswap_compress() please.

>  {
> -	struct crypto_acomp_ctx *acomp_ctx;
> -	struct scatterlist input, output;
> -	int comp_ret = 0, alloc_ret = 0;
> -	unsigned int dlen = PAGE_SIZE;
> -	unsigned long handle;
> -	struct zpool *zpool;
> -	char *buf;
> +	struct scatterlist inputs[ZSWAP_MAX_BATCH_SIZE];
> +	struct scatterlist outputs[ZSWAP_MAX_BATCH_SIZE];
> +	struct zpool *zpool = pool->zpool;
> +	int acomp_idx = 0, nr_to_store = 1;
> +	unsigned int i, j;
> +	int err = 0;
>  	gfp_t gfp;
> -	u8 *dst;
>  
> -	acomp_ctx = acomp_ctx_get_cpu_lock(pool);
> -	dst = acomp_ctx->buffers[0];
> -	sg_init_table(&input, 1);
> -	sg_set_page(&input, page, PAGE_SIZE, 0);
> +	lockdep_assert_held(&acomp_ctx->mutex);
>  
> -	/*
> -	 * We need PAGE_SIZE * 2 here since there maybe over-compression case,
> -	 * and hardware-accelerators may won't check the dst buffer size, so
> -	 * giving the dst buffer with enough length to avoid buffer overflow.
> -	 */
> -	sg_init_one(&output, dst, PAGE_SIZE * 2);
> -	acomp_request_set_params(acomp_ctx->reqs[0], &input, &output, PAGE_SIZE, dlen);
> -
> -	/*
> -	 * it maybe looks a little bit silly that we send an asynchronous request,
> -	 * then wait for its completion synchronously. This makes the process look
> -	 * synchronous in fact.
> -	 * Theoretically, acomp supports users send multiple acomp requests in one
> -	 * acomp instance, then get those requests done simultaneously. but in this
> -	 * case, zswap actually does store and load page by page, there is no
> -	 * existing method to send the second page before the first page is done
> -	 * in one thread doing zwap.
> -	 * but in different threads running on different cpu, we have different
> -	 * acomp instance, so multiple threads can do (de)compression in parallel.
> -	 */
> -	comp_ret = crypto_wait_req(crypto_acomp_compress(acomp_ctx->reqs[0]), &acomp_ctx->wait);
> -	dlen = acomp_ctx->reqs[0]->dlen;
> -	if (comp_ret)
> -		goto unlock;
> -
> -	zpool = pool->zpool;
>  	gfp = __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
>  	if (zpool_malloc_support_movable(zpool))
>  		gfp |= __GFP_HIGHMEM | __GFP_MOVABLE;
> -	alloc_ret = zpool_malloc(zpool, dlen, gfp, &handle);
> -	if (alloc_ret)
> -		goto unlock;
>  
> -	buf = zpool_map_handle(zpool, handle, ZPOOL_MM_WO);
> -	memcpy(buf, dst, dlen);
> -	zpool_unmap_handle(zpool, handle);
> +	for (i = 0; i < nr_pages; ++i) {
> +		struct page *page = folio_page(folio, index + i);
>  
> -	entry->handle = handle;
> -	entry->length = dlen;
> +		sg_init_table(&inputs[acomp_idx], 1);
> +		sg_set_page(&inputs[acomp_idx], page, PAGE_SIZE, 0);
>  
> -unlock:
> -	if (comp_ret == -ENOSPC || alloc_ret == -ENOSPC)
> -		zswap_reject_compress_poor++;
> -	else if (comp_ret)
> -		zswap_reject_compress_fail++;
> -	else if (alloc_ret)
> -		zswap_reject_alloc_fail++;
> +		/*
> +		 * Each dst buffer should be of size (PAGE_SIZE * 2).
> +		 * Reflect same in sg_list.

The existing comment about overcompression was useful, please move it
as-is.

> +		 */
> +		sg_init_one(&outputs[acomp_idx], acomp_ctx->buffers[acomp_idx], PAGE_SIZE * 2);
> +		acomp_request_set_params(acomp_ctx->reqs[acomp_idx], &inputs[acomp_idx],
> +					 &outputs[acomp_idx], PAGE_SIZE, PAGE_SIZE);
> +
> +		if (batching) {
> +			/* Add the acomp request to the chain. */
> +			if (likely(i))
> +				acomp_request_chain(acomp_ctx->reqs[acomp_idx], acomp_ctx->reqs[0]);
> +			else
> +				acomp_reqchain_init(acomp_ctx->reqs[0], 0, crypto_req_done,
> +						    &acomp_ctx->wait);
> +
> +			if (i == (nr_pages - 1)) {
> +				/* Process the request chain. */
> +				err = crypto_wait_req(crypto_acomp_compress(acomp_ctx->reqs[0]), &acomp_ctx->wait);
> +
> +				/*
> +				 * Get the individual compress errors from request chaining.
> +				 */
> +				for (j = 0; j < nr_pages; ++j) {
> +					if (unlikely(acomp_request_err(acomp_ctx->reqs[j]))) {
> +						err = -EINVAL;
> +						if (acomp_request_err(acomp_ctx->reqs[j]) == -ENOSPC)
> +							zswap_reject_compress_poor++;
> +						else
> +							zswap_reject_compress_fail++;
> +					}
> +				}
> +				/*
> +				 * Request chaining cleanup:
> +				 *
> +				 * - Clear the CRYPTO_TFM_REQ_CHAIN bit on acomp_ctx->reqs[0].
> +				 * - Reset the acomp_ctx->wait to notify acomp_ctx->reqs[0].
> +				 */
> +				acomp_reqchain_clear(acomp_ctx->reqs[0], &acomp_ctx->wait);
> +				if (unlikely(err))
> +					return false;
> +				j = 0;
> +				nr_to_store = nr_pages;
> +				goto store_zpool;
> +			}
> +
> +			++acomp_idx;
> +			continue;

The code structure here is really hard to read:

(1) Why do we need 'batching' to begin with? Can't we use the same
request chaining APIs even for the '!batching' case? Are there any
regressions for doing so?

(2) Instead of the control flow having 'continue', 'goto', and nested
loops, can we just have separate loops?

IOW can we do something like:

	for (..) {
		if (i == 0)
			acomp_reqchain_init(..);
		else
			acomp_request_chain(..);
	}

	crypto_wait_req(..);
	/* collect errors */
	acomp_reqchain_clear(..);

	for (..) {
		/* store */
	}

> +		} else {
> +			err = crypto_wait_req(crypto_acomp_compress(acomp_ctx->reqs[0]), &acomp_ctx->wait);
> +
> +			if (unlikely(err)) {
> +				if (err == -ENOSPC)
> +					zswap_reject_compress_poor++;
> +				else
> +					zswap_reject_compress_fail++;
> +				return false;
> +			}
> +			j = i;
> +			nr_to_store = 1;
> +		}
>  
> -	acomp_ctx_put_unlock(acomp_ctx);
> -	return comp_ret == 0 && alloc_ret == 0;
> +store_zpool:
> +		/*
> +		 * All batch pages were successfully compressed.
> +		 * Store the pages in zpool.
> +		 */
> +		acomp_idx = -1;
> +		while (nr_to_store--) {
> +			unsigned long handle;
> +			char *buf;
> +
> +			++acomp_idx;
> +			prefetchw(entries[j]);
> +			err = zpool_malloc(zpool, acomp_ctx->reqs[acomp_idx]->dlen, gfp, &handle);
> +
> +			if (unlikely(err)) {
> +				if (err == -ENOSPC)
> +					zswap_reject_compress_poor++;
> +				else
> +					zswap_reject_alloc_fail++;
> +
> +				return false;
> +			}
> +
> +			buf = zpool_map_handle(zpool, handle, ZPOOL_MM_WO);
> +			memcpy(buf, acomp_ctx->buffers[acomp_idx], acomp_ctx->reqs[acomp_idx]->dlen);
> +			zpool_unmap_handle(zpool, handle);
> +
> +			entries[j]->handle = handle;
> +			entries[j]->length = acomp_ctx->reqs[acomp_idx]->dlen;
> +			++j;
> +		}
> +	}
> +
> +	return true;
>  }
>  
>  static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
> @@ -1581,84 +1648,165 @@ static void shrink_worker(struct work_struct *w)
>  * main API
>  **********************************/
>  
> -static bool zswap_store_page(struct page *page,
> -			     struct obj_cgroup *objcg,
> -			     struct zswap_pool *pool)
> +/*
> + * Store multiple pages in @folio, starting from the page at index @si up to
> + * and including the page at index @ei.

'start' and 'end'?

> + *
> + * The error handling from all failure points is consolidated to the
> + * "store_pages_failed" label, based on the initialization of the zswap entries'
> + * handles to ERR_PTR(-EINVAL) at allocation time, and the fact that the
> + * entry's handle is subsequently modified only upon a successful zpool_malloc()
> + * after the page is compressed.

This comment is not useful here. Instead comment on specific parts of
the function where the intention of the code is not clear.

> + */
> +static bool zswap_store_pages(struct folio *folio,
> +			      long si,
> +			      long ei,
> +			      struct obj_cgroup *objcg,
> +			      struct zswap_pool *pool,
> +			      struct crypto_acomp_ctx *acomp_ctx,
> +			      bool batching)
>  {
> -	swp_entry_t page_swpentry = page_swap_entry(page);
> -	struct zswap_entry *entry, *old;
> +	struct zswap_entry *entries[ZSWAP_MAX_BATCH_SIZE];
> +	int node_id = folio_nid(folio);
> +	u8 i, from_i = 0, nr_pages = ei - si + 1;
>  
> -	/* allocate entry */
> -	entry = zswap_entry_cache_alloc(GFP_KERNEL, page_to_nid(page));
> -	if (!entry) {
> -		zswap_reject_kmemcache_fail++;
> -		return false;
> +	for (i = 0; i < nr_pages; ++i) {
> +		entries[i] = zswap_entry_cache_alloc(GFP_KERNEL, node_id);
> +
> +		if (unlikely(!entries[i])) {
> +			zswap_reject_kmemcache_fail++;
> +			nr_pages = i;
> +			goto store_pages_failed;
> +		}
> +
> +		entries[i]->handle = (unsigned long)ERR_PTR(-EINVAL);
>  	}
>  
> -	if (!zswap_compress(page, entry, pool))
> -		goto compress_failed;
> +	if (!zswap_batch_compress(folio, si, nr_pages, entries, pool, acomp_ctx, batching))
> +		goto store_pages_failed;
>  
> -	old = xa_store(swap_zswap_tree(page_swpentry),
> -		       swp_offset(page_swpentry),
> -		       entry, GFP_KERNEL);
> -	if (xa_is_err(old)) {
> -		int err = xa_err(old);
> +	for (i = 0; i < nr_pages; ++i) {
> +		swp_entry_t page_swpentry = page_swap_entry(folio_page(folio, si + i));
> +		struct zswap_entry *old, *entry = entries[i];
>  
> -		WARN_ONCE(err != -ENOMEM, "unexpected xarray error: %d\n", err);
> -		zswap_reject_alloc_fail++;
> -		goto store_failed;
> -	}
> +		old = xa_store(swap_zswap_tree(page_swpentry),
> +			       swp_offset(page_swpentry),
> +			       entry, GFP_KERNEL);
> +		if (unlikely(xa_is_err(old))) {
> +			int err = xa_err(old);
>  
> -	/*
> -	 * We may have had an existing entry that became stale when
> -	 * the folio was redirtied and now the new version is being
> -	 * swapped out. Get rid of the old.
> -	 */
> -	if (old)
> -		zswap_entry_free(old);
> +			WARN_ONCE(err != -ENOMEM, "unexpected xarray error: %d\n", err);
> +			zswap_reject_alloc_fail++;
> +			from_i = i;

'error_idx' or 'store_fail_idx'?

> +			goto store_pages_failed;
> +		}
>  
> -	/*
> -	 * The entry is successfully compressed and stored in the tree, there is
> -	 * no further possibility of failure. Grab refs to the pool and objcg,
> -	 * charge zswap memory, and increment zswap_stored_pages.
> -	 * The opposite actions will be performed by zswap_entry_free()
> -	 * when the entry is removed from the tree.
> -	 */
> -	zswap_pool_get(pool);
> -	if (objcg) {
> -		obj_cgroup_get(objcg);
> -		obj_cgroup_charge_zswap(objcg, entry->length);
> -	}
> -	atomic_long_inc(&zswap_stored_pages);
> +		/*
> +		 * We may have had an existing entry that became stale when
> +		 * the folio was redirtied and now the new version is being
> +		 * swapped out. Get rid of the old.
> +		 */
> +		if (unlikely(old))
> +			zswap_entry_free(old);
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
> +		/*
> +		 * The entry is successfully compressed and stored in the tree, there is
> +		 * no further possibility of failure. Grab refs to the pool and objcg,
> +		 * charge zswap memory, and increment zswap_stored_pages.
> +		 * The opposite actions will be performed by zswap_entry_free()
> +		 * when the entry is removed from the tree.
> +		 */
> +		zswap_pool_get(pool);
> +		if (objcg) {
> +			obj_cgroup_get(objcg);
> +			obj_cgroup_charge_zswap(objcg, entry->length);
> +		}
> +		atomic_long_inc(&zswap_stored_pages);
> +
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
> +		if (likely(entry->length)) {
> +			INIT_LIST_HEAD(&entry->lru);
> +			zswap_lru_add(&zswap_list_lru, entry);
> +		}
>  	}
>  
>  	return true;
>  
> -store_failed:
> -	zpool_free(pool->zpool, entry->handle);
> -compress_failed:
> -	zswap_entry_cache_free(entry);
> +store_pages_failed:
> +	for (i = from_i; i < nr_pages; ++i) {
> +		if (!IS_ERR_VALUE(entries[i]->handle))
> +			zpool_free(pool->zpool, entries[i]->handle);
> +
> +		zswap_entry_cache_free(entries[i]);
> +	}
> +
>  	return false;
>  }
>  
> +/*
> + * Store all pages in a folio by calling zswap_batch_compress().
> + * If the compressor supports batching, i.e., has multiple acomp requests,
> + * the folio will be compressed in batches of "acomp_ctx->nr_reqs" using
> + * request chaining.
> + * If the compressor has only one acomp request, the folio will be compressed
> + * in batches of ZSWAP_MAX_BATCH_SIZE pages, where each page in the batch is
> + * compressed sequentially.
> + */
> +static bool zswap_store_folio(struct folio *folio,
> +			      struct obj_cgroup *objcg,
> +			      struct zswap_pool *pool)
> +{
> +	long nr_pages = folio_nr_pages(folio);
> +	struct crypto_acomp_ctx *acomp_ctx;
> +	unsigned int batch_size;
> +	bool ret = true, batching;
> +	long si, ei;
> +
> +	acomp_ctx = acomp_ctx_get_cpu_lock(pool);
> +
> +	batching = ((acomp_ctx->nr_reqs > 1) && (nr_pages > 1));
> +
> +	batch_size = batching ? acomp_ctx->nr_reqs : ZSWAP_MAX_BATCH_SIZE;

acomp_ctx->nr_reqs is a function of the compressor. Can we store it in
the pool to avoid having to hold the mutex here just for this?

This would also save a tiny bit of memory as right now we have it
replicated for all CPUs.

> +
> +	if (!batching)
> +		acomp_ctx_put_unlock(acomp_ctx);

So in the batching case we keep the mutex held throughout, otherwise we
hold it for every batch. Why?

IIRC you mentioned that only holding it for every batch removes the zstd
regressions, perhaps because holding the mutex for too long is a
problem. But why not do the same for the batching case too?

Also, the current behavior is that we only hold the mutex during
compression. Now we changed this to do it per-folio or per-batch. Does
the current behavior cause regressions? Ideally we'd like to keep the
mutex held as little as possible.

This is worth explaining in detail.

> +
> +	/* Store the folio in batches of "batch_size" pages. */
> +	for (si = 0, ei = min(si + batch_size - 1, nr_pages - 1);
> +	     ((si < nr_pages) && (ei < nr_pages));
> +	     si = ei + 1, ei = min(si + batch_size - 1, nr_pages - 1)) {

This is too complicated. Can we do:

	for (start = 0; start < nr_pages; start += batch_size) {
		end = min(start + batch_size - 1, nr_pages - 1);
		...
	}

Also, we subtract 1 from ei here and add 1 in zswap_store_pages(), so
perhaps it's better to make it exclusive:

	for (start = 0; start < nr_pages; start += batch_size) {
		end = min(start + batch_size, nr_pages);
		...
	}

> +
> +		if (!batching)
> +			acomp_ctx = acomp_ctx_get_cpu_lock(pool);
> +
> +		if (!zswap_store_pages(folio, si, ei, objcg, pool, acomp_ctx, batching)) {
> +			ret = false;
> +			break;
> +		}
> +
> +		if (!batching)
> +			acomp_ctx_put_unlock(acomp_ctx);
> +	}
> +
> +	if (batching || !ret)
> +		acomp_ctx_put_unlock(acomp_ctx);
> +
> +	return ret;
> +}
> +
>  bool zswap_store(struct folio *folio)
>  {
>  	long nr_pages = folio_nr_pages(folio);
> @@ -1667,7 +1815,6 @@ bool zswap_store(struct folio *folio)
>  	struct mem_cgroup *memcg = NULL;
>  	struct zswap_pool *pool;
>  	bool ret = false;
> -	long index;

These seems like an unrelated change.

>  
>  	VM_WARN_ON_ONCE(!folio_test_locked(folio));
>  	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> @@ -1701,12 +1848,8 @@ bool zswap_store(struct folio *folio)
>  		mem_cgroup_put(memcg);
>  	}
>  
> -	for (index = 0; index < nr_pages; ++index) {
> -		struct page *page = folio_page(folio, index);
> -
> -		if (!zswap_store_page(page, objcg, pool))
> -			goto put_pool;
> -	}
> +	if (!zswap_store_folio(folio, objcg, pool))
> +		goto put_pool;

If we move the locking out of zswap_store_folio() and simplify the loop
there, I belive it will be simple enough for us to inline it here.

>  
>  	if (objcg)
>  		count_objcg_events(objcg, ZSWPOUT, nr_pages);
> @@ -1733,6 +1876,7 @@ bool zswap_store(struct folio *folio)
>  		pgoff_t offset = swp_offset(swp);
>  		struct zswap_entry *entry;
>  		struct xarray *tree;
> +		long index;
>  
>  		for (index = 0; index < nr_pages; ++index) {
>  			tree = swap_zswap_tree(swp_entry(type, offset + index));
> -- 
> 2.27.0
> 

