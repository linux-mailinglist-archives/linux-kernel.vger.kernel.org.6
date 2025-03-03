Return-Path: <linux-kernel+bounces-542768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF74A4CD6D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 22:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3793D1893365
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 21:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6866123717D;
	Mon,  3 Mar 2025 21:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QrCDFm39"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B446235BE4
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 21:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741036895; cv=none; b=Ux1PYHW9oPXZJOPyVBlx3kzZsfDbAmkCzGCe1TN5xDjJopWdo+xub/87WnINMrq3R2vcOlHEu/HiH8H/T3X3MRmqCwpZmVIj19V2VUpwPKSywXTTmjpQGUdimCRouJUPuT1wXT1UcGQtk5Cgnn4eq62lMKnHjK4r7Rr56500xCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741036895; c=relaxed/simple;
	bh=HyITMfrLvX38brwsnBLfqY6XryQdGoMR2XqVoGe7jkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISde+/S9uFt07eGOWE/4TJihosSHhnQYaQ6CxD6WP/HUZhfMJkhU9ZrvFhFg5myVMVlCTTFPpdU/XyrCLxBzzuqWKp0qfwp+fIW6fblYRM3RzmAjRVVsyTT2dU95XQjmv9mhytKtQvA0JpFe5K0AzeUQ7Gi5b2Pjjtzyxxhl7zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QrCDFm39; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 3 Mar 2025 21:21:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741036891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kL4tjzMzQo5uwMm6YTN0FCnZCyssi5BQcb9r960YpQM=;
	b=QrCDFm39CXH/h6DfmdEqATr6J1otV52h8hTQ+i3zgc+71cFLdP0gtJLzho/ndfwRJhDQ+r
	n2MLTJxLk9F/xVzHyO75zhyjlz8FMduaRGENeTdfBZuPB1Dt19yyJ1gvapYh81IE23VKju
	++Zyy+mTS73/a0gs5N+no8NgHbKZqB0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, chengming.zhou@linux.dev,
	linux-mm@kvack.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] page_io: zswap: do not crash the kernel on
 decompression failure
Message-ID: <Z8YdV4Vqju2w7hqI@google.com>
References: <20250303200627.2102890-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303200627.2102890-1-nphamcs@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 03, 2025 at 12:06:27PM -0800, Nhat Pham wrote:
> Currently, we crash the kernel when a decompression failure occurs in
> zswap (either because of memory corruption, or a bug in the compression
> algorithm). This is overkill. We should only SIGBUS the unfortunate
> process asking for the zswap entry on zswap load, and skip the corrupted
> entry in zswap writeback.
> 
> See [1] for a recent upstream discussion about this.
> 
> The zswap writeback case is relatively straightforward to fix. For the
> zswap_load() case, we reorganize the swap read paths, having
> swap_read_folio_zeromap() and zswap_load() return specific error codes:
> 
> * 0 indicates the backend owns the swapped out content, which was
>   successfully loaded into the page.
> * -ENOENT indicates the backend does not own the swapped out content.
> * -EINVAL and -EIO indicate the backend own the swapped out content, but
>   the content was not successfully loaded into the page for some
>   reasons. The folio will not be marked up-to-date, which will
>   eventually cause the process requesting the page to SIGBUS (see the
>   handling of not-up-to-date folio in do_swap_page() in mm/memory.c).
> 
> zswap decompression failures on the zswap load path are treated as an
> -EIO error, as described above, and will no longer crash the kernel.
> 
> As a side effect, we require one extra zswap tree traversal in the load
> and writeback paths. Quick benchmarking on a kernel build test shows no
> performance difference:
> 
> With the new scheme:
> real: mean: 125.1s, stdev: 0.12s
> user: mean: 3265.23s, stdev: 9.62s
> sys: mean: 2156.41s, stdev: 13.98s
> 
> The old scheme:
> real: mean: 125.78s, stdev: 0.45s
> user: mean: 3287.18s, stdev: 5.95s
> sys: mean: 2177.08s, stdev: 26.52s
> 
> [1]: https://lore.kernel.org/all/ZsiLElTykamcYZ6J@casper.infradead.org/
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Suggested-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  include/linux/zswap.h |   4 +-
>  mm/page_io.c          |  35 ++++++++----
>  mm/zswap.c            | 130 ++++++++++++++++++++++++++++++------------
>  3 files changed, 120 insertions(+), 49 deletions(-)
> 
> diff --git a/include/linux/zswap.h b/include/linux/zswap.h
> index d961ead91bf1..9468cb3e0878 100644
> --- a/include/linux/zswap.h
> +++ b/include/linux/zswap.h
> @@ -26,7 +26,7 @@ struct zswap_lruvec_state {
>  
>  unsigned long zswap_total_pages(void);
>  bool zswap_store(struct folio *folio);
> -bool zswap_load(struct folio *folio);
> +int zswap_load(struct folio *folio);
>  void zswap_invalidate(swp_entry_t swp);
>  int zswap_swapon(int type, unsigned long nr_pages);
>  void zswap_swapoff(int type);
> @@ -46,7 +46,7 @@ static inline bool zswap_store(struct folio *folio)
>  
>  static inline bool zswap_load(struct folio *folio)

int?

>  {
> -	return false;
> +	return -ENOENT;
>  }
>  
>  static inline void zswap_invalidate(swp_entry_t swp) {}
> diff --git a/mm/page_io.c b/mm/page_io.c
> index 9b983de351f9..8a44faec3f92 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -511,7 +511,21 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
>  	mempool_free(sio, sio_pool);
>  }
>  
> -static bool swap_read_folio_zeromap(struct folio *folio)
> +/*
> + * Return: one of the following error codes:

nit: 
"Returns 0 on success, or one of the following errors on failure:"

Also might as well make this a full kerneldoc?

> + *
> + *  0: the folio is zero-filled (and was populated as such and marked
> + *  up-to-date and unlocked).
> + *
> + *  -ENOENT: the folio was not zero-filled.
> + *
> + *  -EINVAL: some of the subpages in the folio are zero-filled, but not all of
> + *  them. This is an error because we don't currently support a large folio
> + *  that is partially in the zeromap. The folio is unlocked, but NOT marked
> + *  up-to-date, so that an IO error is emitted (e.g. do_swap_page() will
> + *  sigbus).
> + */
> +static int swap_read_folio_zeromap(struct folio *folio)
>  {
>  	int nr_pages = folio_nr_pages(folio);
>  	struct obj_cgroup *objcg;
> @@ -523,11 +537,13 @@ static bool swap_read_folio_zeromap(struct folio *folio)
>  	 * that an IO error is emitted (e.g. do_swap_page() will sigbus).
>  	 */

This comment says "Return true", so it needs to be updated. We probably
don't need to explain the return value anymore since it's documented
above.

>  	if (WARN_ON_ONCE(swap_zeromap_batch(folio->swap, nr_pages,
> -			&is_zeromap) != nr_pages))
> -		return true;
> +			&is_zeromap) != nr_pages)) {
> +		folio_unlock(folio);
> +		return -EINVAL;
> +	}
>  
>  	if (!is_zeromap)
> -		return false;
> +		return -ENOENT;
>  
>  	objcg = get_obj_cgroup_from_folio(folio);
>  	count_vm_events(SWPIN_ZERO, nr_pages);
> @@ -538,7 +554,8 @@ static bool swap_read_folio_zeromap(struct folio *folio)
>  
>  	folio_zero_range(folio, 0, folio_size(folio));
>  	folio_mark_uptodate(folio);
> -	return true;
> +	folio_unlock(folio);
> +	return 0;
>  }
>  
>  static void swap_read_folio_fs(struct folio *folio, struct swap_iocb **plug)
> @@ -635,13 +652,11 @@ void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
>  	}
>  	delayacct_swapin_start();
>  
> -	if (swap_read_folio_zeromap(folio)) {
> -		folio_unlock(folio);
> +	if (swap_read_folio_zeromap(folio) != -ENOENT)
>  		goto finish;

I would split the zeromap change into a separate patch, but it's
probably fine either way.

> -	} else if (zswap_load(folio)) {
> -		folio_unlock(folio);
> +
> +	if (zswap_load(folio) != -ENOENT)
>  		goto finish;
> -	}
>  
>  	/* We have to read from slower devices. Increase zswap protection. */
>  	zswap_folio_swapin(folio);
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 6dbf31bd2218..b67481defc6c 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -62,6 +62,8 @@ static u64 zswap_reject_reclaim_fail;
>  static u64 zswap_reject_compress_fail;
>  /* Compressed page was too big for the allocator to (optimally) store */
>  static u64 zswap_reject_compress_poor;
> +/* Load or writeback failed due to decompression failure */
> +static u64 zswap_decompress_fail;
>  /* Store failed because underlying allocator could not get memory */
>  static u64 zswap_reject_alloc_fail;
>  /* Store failed because the entry metadata could not be allocated (rare) */
> @@ -996,11 +998,12 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
>  	return comp_ret == 0 && alloc_ret == 0;
>  }
>  
> -static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
> +static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
>  {
>  	struct zpool *zpool = entry->pool->zpool;
>  	struct scatterlist input, output;
>  	struct crypto_acomp_ctx *acomp_ctx;
> +	int decomp_ret, dlen;
>  	u8 *src;
>  
>  	acomp_ctx = acomp_ctx_get_cpu_lock(entry->pool);
> @@ -1025,12 +1028,31 @@ static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
>  	sg_init_table(&output, 1);
>  	sg_set_folio(&output, folio, PAGE_SIZE, 0);
>  	acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, PAGE_SIZE);
> -	BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait));
> -	BUG_ON(acomp_ctx->req->dlen != PAGE_SIZE);
> +	decomp_ret = crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait);
> +	dlen = acomp_ctx->req->dlen;
>  
>  	if (src != acomp_ctx->buffer)
>  		zpool_unmap_handle(zpool, entry->handle);
>  	acomp_ctx_put_unlock(acomp_ctx);
> +
> +	if (decomp_ret || dlen != PAGE_SIZE) {
> +		zswap_decompress_fail++;
> +		pr_alert_ratelimited(
> +			"decompression failed with returned value %d on zswap entry with "

nit: Decompression*

I am also wondering how this looks like in dmesg? Is the line too long
to be read? Should we add some line breaks (e.g. like
warn_sysctl_write()), we could probably also put this in a helper to
keep this function visually easy to follow.

> +			"swap entry value %08lx, swap type %d, and swap offset %lu. "
> +			"compression algorithm is %s. compressed size is %u bytes, and "
> +			"decompressed size is %u bytes.\n",
> +			decomp_ret,
> +			entry->swpentry.val,
> +			swp_type(entry->swpentry),
> +			swp_offset(entry->swpentry),
> +			entry->pool->tfm_name,
> +			entry->length,
> +			acomp_ctx->req->dlen);

We should probably be using 'dlen' here since we're outside the lock.

> +
> +		return false;
> +	}
> +	return true;
>  }
>  
>  /*********************************
[..]
> @@ -1620,7 +1651,29 @@ bool zswap_store(struct folio *folio)
>  	return ret;
>  }
>  
> -bool zswap_load(struct folio *folio)
> +/**
> + * zswap_load() - load a page from zswap
> + * @folio: folio to load
> + *
> + * Return: one of the following error codes:

nit: Returns 0 on success, or ..

> + *
> + *  0: if the swapped out content was in zswap and was successfully loaded.
> + *  The folio is unlocked and marked up-to-date.
> + *
> + *  -EIO: if the swapped out content was in zswap, but could not be loaded
> + *  into the page (for e.g, because there was a memory corruption, or a
> + *  decompression bug). The folio is unlocked, but NOT marked up-to-date,
> + *  so that an IO error is emitted (e.g. do_swap_page() will SIGBUS).
> + *
> + *  -EINVAL: if the swapped out content was in zswap, but the page belongs
> + *  to a large folio, which is not supported by zswap. The folio is unlocked,
> + *  but NOT marked up-to-date, so that an IO error is emitted (e.g.
> + *  do_swap_page() will SIGBUS).
> + *
> + *  -ENOENT: if the swapped out content was not in zswap. The folio remains
> + *  locked on return.
> + */
> +int zswap_load(struct folio *folio)
>  {
>  	swp_entry_t swp = folio->swap;
>  	pgoff_t offset = swp_offset(swp);
[..]

