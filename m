Return-Path: <linux-kernel+bounces-535289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7BBA470EC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5EFA188E35C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A5C1B21B4;
	Thu, 27 Feb 2025 01:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wzcuMUHd"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2721D1B21B8
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 01:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740619182; cv=none; b=rfWVG2u3QE7V5JpRLOmZsaHYr1nxn1QPb00M3fIdXKnGFQZ2ocjvkJq8Ao/oI+WtK+FAVR4Z1GThFIqU8ab8sSqw1b8QBNVBhGVzoqye405tbNauCf3/Lt4XOdFPWK+Zu4J7zJDLCKJFag4PCwgOH6CKmAdbNbMmnbCs/AMIeNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740619182; c=relaxed/simple;
	bh=muCxjCHO7J+3+X5r8iv+4HI0QOLZcNmEcwoDvK/pCAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7if9salBCRgC0AhxwTILGPNOxNq399ulHhkDttjGWKHlSSXpY7gsFnoYEJr6LwUHKG7ShgqIqLy4NaZgREQ+m3ZorE8zGEMRgumjiO6LpzzNDsrsAClwPoxnycwkKuVDTRCt08FXNaakfW2xaSfM3DSMzSyN6n6YiBp+ecoI4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wzcuMUHd; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 27 Feb 2025 01:19:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740619177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tn0bCA8vmXCFisYbnlg1+ph/3V4Z5kayGOAi96rwN8M=;
	b=wzcuMUHdz0UHoju4Vymz/grmhzKu69MtfKKpZuR2AUxFB5rLy3rxM3mv0ZT6WpPHlRkPis
	cPRtdqF2M8MYc+F08qt2usqXhfnVa5ydVHH8eB+jPxbuxwkZEFp8xpvCQdtd5Ii53Lv0pN
	M0xIPAGDUL1AyUyI5X5qoulOf5Iq20c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, chengming.zhou@linux.dev,
	linux-mm@kvack.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] zswap: do not crash the kernel on decompression
 failure
Message-ID: <Z7-9o81kBfw4tFSz@google.com>
References: <20250227001445.1099203-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227001445.1099203-1-nphamcs@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 26, 2025 at 04:14:45PM -0800, Nhat Pham wrote:
> Currently, we crash the kernel when a decompression failure occurs in
> zswap (either because of memory corruption, or a bug in the compression
> algorithm). This is overkill. We should only SIGBUS the unfortunate
> process asking for the zswap entry on zswap load, and skip the corrupted
> entry in zswap writeback. The former is accomplished by returning true
> from zswap_load(), indicating that zswap owns the swapped out content,
> but without flagging the folio as up-to-date. The process trying to swap
> in the page will check for the uptodate folio flag and SIGBUS (see
> do_swap_page() in mm/memory.c for more details).

We should call out the extra xarray walks and their perf impact (if
any).

> 
> See [1] for a recent upstream discussion about this.
> 
> [1]: https://lore.kernel.org/all/ZsiLElTykamcYZ6J@casper.infradead.org/
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Suggested-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  mm/zswap.c | 94 ++++++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 67 insertions(+), 27 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 6dbf31bd2218..e4a2157bbc64 100644
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
> @@ -996,11 +998,13 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
>  	return comp_ret == 0 && alloc_ret == 0;
>  }
>  
> -static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
> +static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
>  {
>  	struct zpool *zpool = entry->pool->zpool;
>  	struct scatterlist input, output;
>  	struct crypto_acomp_ctx *acomp_ctx;
> +	int decomp_ret;
> +	bool ret = true;
>  	u8 *src;
>  
>  	acomp_ctx = acomp_ctx_get_cpu_lock(entry->pool);
> @@ -1025,12 +1029,25 @@ static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
>  	sg_init_table(&output, 1);
>  	sg_set_folio(&output, folio, PAGE_SIZE, 0);
>  	acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, PAGE_SIZE);
> -	BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait));
> -	BUG_ON(acomp_ctx->req->dlen != PAGE_SIZE);
> +	decomp_ret = crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait);
> +	if (decomp_ret || acomp_ctx->req->dlen != PAGE_SIZE) {
> +		ret = false;
> +		zswap_decompress_fail++;
> +		pr_alert_ratelimited(
> +			"decompression failed with returned value %d on zswap entry with swap entry value %08lx, swap type %d, and swap offset %lu. compression algorithm is %s. compressed size is %u bytes, and decompressed size is %u bytes.\n",

This is a very long line. I think we should break it into multiple
lines. I know multiline strings are frowned upon by checkpatch, by this
exist (see the warning in mem_cgroup_oom_control_write() for example),
and they are definitely better than a very long line imo.

> +			decomp_ret,
> +			entry->swpentry.val,
> +			swp_type(entry->swpentry),
> +			swp_offset(entry->swpentry),
> +			entry->pool->tfm_name,
> +			entry->length,
> +			acomp_ctx->req->dlen);
> +	}
>  
>  	if (src != acomp_ctx->buffer)
>  		zpool_unmap_handle(zpool, entry->handle);
>  	acomp_ctx_put_unlock(acomp_ctx);
> +	return ret;

Not a big deal but we could probably store the length in a local
variable and move the check here, and avoid needing 'ret'.

>  }
>  
>  /*********************************
> @@ -1060,6 +1077,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
>  	struct writeback_control wbc = {
>  		.sync_mode = WB_SYNC_NONE,
>  	};
> +	int ret = 0;
>  
>  	/* try to allocate swap cache folio */
>  	si = get_swap_device(swpentry);
> @@ -1081,8 +1099,8 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
>  	 * and freed when invalidated by the concurrent shrinker anyway.
>  	 */
>  	if (!folio_was_allocated) {
> -		folio_put(folio);
> -		return -EEXIST;
> +		ret = -EEXIST;
> +		goto put_folio;
>  	}
>  
>  	/*
> @@ -1095,14 +1113,17 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
>  	 * be dereferenced.
>  	 */
>  	tree = swap_zswap_tree(swpentry);
> -	if (entry != xa_cmpxchg(tree, offset, entry, NULL, GFP_KERNEL)) {
> -		delete_from_swap_cache(folio);
> -		folio_unlock(folio);
> -		folio_put(folio);
> -		return -ENOMEM;
> +	if (entry != xa_load(tree, offset)) {
> +		ret = -ENOMEM;
> +		goto delete_unlock;
> +	}
> +
> +	if (!zswap_decompress(entry, folio)) {
> +		ret = -EIO;
> +		goto delete_unlock;
>  	}
>  
> -	zswap_decompress(entry, folio);
> +	xa_erase(tree, offset);
>  
>  	count_vm_event(ZSWPWB);
>  	if (entry->objcg)
> @@ -1118,9 +1139,14 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
>  
>  	/* start writeback */
>  	__swap_writepage(folio, &wbc);
> -	folio_put(folio);
>  
> -	return 0;
> +put_folio:
> +	folio_put(folio);
> +	return ret;
> +delete_unlock:
> +	delete_from_swap_cache(folio);
> +	folio_unlock(folio);
> +	goto put_folio;

I think I suggested a way to avoid this goto in v1:
https://lore.kernel.org/lkml/Z782SPcJI8DFISRa@google.com/.

Did this not work out?

>  }
>  
>  /*********************************
> @@ -1620,6 +1646,20 @@ bool zswap_store(struct folio *folio)
>  	return ret;
>  }
>  
> +/**
> + * zswap_load() - load a page from zswap
> + * @folio: folio to load
> + *
> + * Returns: true if zswap owns the swapped out contents, false otherwise.
> + *
> + * Note that the zswap_load() return value doesn't indicate success or failure,
> + * but whether zswap owns the swapped out contents. This MUST return true if
> + * zswap does own the swapped out contents, even if it fails to write the
> + * contents to the folio. Otherwise, the caller will try to read garbage from
> + * the backend.
> + *
> + * Success is signaled by marking the folio uptodate.
> + */
>  bool zswap_load(struct folio *folio)
>  {
>  	swp_entry_t swp = folio->swap;
> @@ -1644,6 +1684,17 @@ bool zswap_load(struct folio *folio)

The comment that exists here (not visible in the diff) should be
abbreviated now that we already explained the whole uptodate thing
above, right?

>  	if (WARN_ON_ONCE(folio_test_large(folio)))
>  		return true;
>  
> +	entry = xa_load(tree, offset);
> +	if (!entry)
> +		return false;
> +

A small comment here pointing out that we are deliberatly not setting
uptodate because of the failure may make things more obvious, or do you
think that's not needed?

> +	if (!zswap_decompress(entry, folio))
> +		return true;
> +
> +	count_vm_event(ZSWPIN);
> +	if (entry->objcg)
> +		count_objcg_events(entry->objcg, ZSWPIN, 1);
> +
>  	/*
>  	 * When reading into the swapcache, invalidate our entry. The
>  	 * swapcache can be the authoritative owner of the page and
> @@ -1656,21 +1707,8 @@ bool zswap_load(struct folio *folio)
>  	 * files, which reads into a private page and may free it if
>  	 * the fault fails. We remain the primary owner of the entry.)
>  	 */
> -	if (swapcache)
> -		entry = xa_erase(tree, offset);
> -	else
> -		entry = xa_load(tree, offset);
> -
> -	if (!entry)
> -		return false;
> -
> -	zswap_decompress(entry, folio);
> -
> -	count_vm_event(ZSWPIN);
> -	if (entry->objcg)
> -		count_objcg_events(entry->objcg, ZSWPIN, 1);
> -
>  	if (swapcache) {
> +		xa_erase(tree, offset);
>  		zswap_entry_free(entry);
>  		folio_mark_dirty(folio);
>  	}
> @@ -1771,6 +1809,8 @@ static int zswap_debugfs_init(void)
>  			   zswap_debugfs_root, &zswap_reject_compress_fail);
>  	debugfs_create_u64("reject_compress_poor", 0444,
>  			   zswap_debugfs_root, &zswap_reject_compress_poor);
> +	debugfs_create_u64("decompress_fail", 0444,
> +			   zswap_debugfs_root, &zswap_decompress_fail);
>  	debugfs_create_u64("written_back_pages", 0444,
>  			   zswap_debugfs_root, &zswap_written_back_pages);
>  	debugfs_create_file("pool_total_size", 0444,
> 
> base-commit: 598d34afeca6bb10554846cf157a3ded8729516c
> -- 
> 2.43.5

