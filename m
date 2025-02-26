Return-Path: <linux-kernel+bounces-532867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1103CA4532D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 03:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 121AF7A13E8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1457421C9E4;
	Wed, 26 Feb 2025 02:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e2OVFNAh"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DF3EAFA
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 02:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740537644; cv=none; b=uabmlrzhUeLhEMQ4p80zmNc2XTxkgB5k7CU9Y/ksP9RQWMUjRMtrc6GRT20KsTuOD0H+P/hN3mr6IUQAPuJsalU18PBVrO2upt/laT0ASImo5/CFfLmXqAtKsyaNzRVqqlyjih4PQWoOWoxKYywGqjLRGI786EQu+7a3OIppvNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740537644; c=relaxed/simple;
	bh=mdlUM44W6T3CT/yr++Cknq12keUsOkANBqZ+Qf5Lqh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVPFjU9G2KrEIXf1C6fo9FWchTIs/oblgohfQAoyz1NmHyldQ+Pw6NzCR40Sc3nxpOlHSUJp0tGVfvVXIPuHLlHt3bfo+Q8TmRLSIwMNzN//CF7A/vroHl0B9z0v4fjMSHfqNIB/66ht4fV8St5ZxKY7Fk7u+MArs02caz77qtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e2OVFNAh; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 26 Feb 2025 02:40:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740537640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T4DzSfTGqtZ157FLjSkApLN27i1udx1HK0g7eBQ4qlk=;
	b=e2OVFNAh1Js8neIqKUlPIsThYM4fHZZbV1ukHdf/latkSmhpIrdvAJ+TIgX0UOG2m9daj4
	u5wVBpuvGqWitQiV9pW9gCOBd5/sA/f8iub0nmZREPY15veMA953lVeaXq7qPNaErOV1r2
	6wvPmKOVkcewBQGzDCXBq8MG4CPzbqQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, chengming.zhou@linux.dev,
	linux-mm@kvack.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zswap: do not crash the kernel on decompression failure
Message-ID: <Z75_I5q7Qm_oPgMA@google.com>
References: <20250225213200.729056-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225213200.729056-1-nphamcs@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 25, 2025 at 01:32:00PM -0800, Nhat Pham wrote:
> Currently, we crash the kernel when a decompression failure occurs in
> zswap (either because of memory corruption, or a bug in the compression
> algorithm). This is overkill. We should only SIGBUS the unfortunate
> process asking for the zswap entry on zswap load, and skip the corrupted
> entry in zswap writeback.

It's probably worth adding more details here. For example, how the
SIGBUS is delivered (it's not super clear in the code), and the
distinction between handling decompression failures for loads and
writeback.

> 
> See [1] for a recent upstream discussion about this.
> 
> [1]: https://lore.kernel.org/all/ZsiLElTykamcYZ6J@casper.infradead.org/
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Suggested-by: Yosry Ahmed <yosryahmed@google.com>

It's Yosry Ahmed <yosry.ahmed@linux.dev> now :P

> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  mm/zswap.c | 85 +++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 58 insertions(+), 27 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index f6316b66fb23..31d4397eed61 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -62,6 +62,8 @@ static u64 zswap_reject_reclaim_fail;
>  static u64 zswap_reject_compress_fail;
>  /* Compressed page was too big for the allocator to (optimally) store */
>  static u64 zswap_reject_compress_poor;
> +/* Load and writeback failed due to decompression failure */

Nit: Load or writeback?

> +static u64 zswap_reject_decompress_fail;
>  /* Store failed because underlying allocator could not get memory */
>  static u64 zswap_reject_alloc_fail;
>  /* Store failed because the entry metadata could not be allocated (rare) */
> @@ -953,11 +955,12 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
>  	return comp_ret == 0 && alloc_ret == 0;
>  }
>  
> -static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
> +static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
>  {
>  	struct zpool *zpool = entry->pool->zpool;
>  	struct scatterlist input, output;
>  	struct crypto_acomp_ctx *acomp_ctx;
> +	bool ret = true;
>  	u8 *src;
>  
>  	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
> @@ -984,12 +987,19 @@ static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
>  	sg_init_table(&output, 1);
>  	sg_set_folio(&output, folio, PAGE_SIZE, 0);
>  	acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, PAGE_SIZE);
> -	BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait));
> -	BUG_ON(acomp_ctx->req->dlen != PAGE_SIZE);
> +	if (crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait) ||
> +			acomp_ctx->req->dlen != PAGE_SIZE) {
> +		ret = false;
> +		zswap_reject_decompress_fail++;
> +		pr_alert_ratelimited(
> +			"decompression failed on zswap entry with offset %08lx\n",
> +			entry->swpentry.val);
> +	}

This can probably be prettier if we save the return value of
crypto_wait_req() in a variable, and then do the check at the end of the
function:

zswap_decompress()
{
	mutex_lock();
	...
	ret = crypto_wait_req(..);
	...
	mutex_unlock();
	...
	if (ret || acomp_ctx->req->dlen != PAGE_SIZE) {
		/* SHIT */
		return false;
	}
	return true;
}


>  	mutex_unlock(&acomp_ctx->mutex);
>  
>  	if (src != acomp_ctx->buffer)
>  		zpool_unmap_handle(zpool, entry->handle);
> +	return ret;
>  }
>  
>  /*********************************
> @@ -1018,6 +1028,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
>  	struct writeback_control wbc = {
>  		.sync_mode = WB_SYNC_NONE,
>  	};
> +	int ret = 0;
>  
>  	/* try to allocate swap cache folio */
>  	mpol = get_task_policy(current);
> @@ -1034,8 +1045,8 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
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
> @@ -1048,14 +1059,17 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
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
> +		goto fail;
>  	}
>  
> -	zswap_decompress(entry, folio);
> +	if (!zswap_decompress(entry, folio)) {
> +		ret = -EIO;
> +		goto fail;
> +	}
> +
> +	xa_erase(tree, offset);
>  
>  	count_vm_event(ZSWPWB);
>  	if (entry->objcg)
> @@ -1071,9 +1085,14 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
>  
>  	/* start writeback */
>  	__swap_writepage(folio, &wbc);
> -	folio_put(folio);
> +	goto put_folio;
>  
> -	return 0;
> +fail:
> +	delete_from_swap_cache(folio);
> +	folio_unlock(folio);
> +put_folio:
> +	folio_put(folio);
> +	return ret;
>  }
>  
>  /*********************************
> @@ -1600,6 +1619,29 @@ bool zswap_load(struct folio *folio)
>  	if (WARN_ON_ONCE(folio_test_large(folio)))
>  		return true;
>  
> +	/*
> +	 * We cannot invalidate the zswap entry before decompressing it. If
> +	 * decompression fails, we must keep the entry in the tree so that
> +	 * a future read by another process on the same swap entry will also
> +	 * have to go through zswap. Otherwise, we risk silently reading
> +	 * corrupted data for the other process.
> +	 */
> +	entry = xa_load(tree, offset);

We are doing load + erase here and in the writeback path now, so two
xarray walks instead of one. How does this affect performance? We had a
similar about the possiblity of doing a lockless xas_load() followed by
a conditional xas_erase() for zswap_invalidate():

https://lore.kernel.org/lkml/20241018192525.95862-1-ryncsn@gmail.com/

Unfortunately it seems like we can't trivially do that unless we keep
the tree locked, which we probably don't want to do throughout
decompression.

How crazy would it be to remove the entry from the tree and re-add it if
compression fails? Does swapcache_prepare() provide sufficient
protection for us to do this without anyone else looking at this entry
(seems like it)?

Anyway, this is all moot if the second walk is not noticeable from a
perf perspective.

