Return-Path: <linux-kernel+bounces-532883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D14A45366
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 03:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F026C189ED8C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B2621CA09;
	Wed, 26 Feb 2025 02:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RE174lwr"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA191A83E2
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 02:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740537949; cv=none; b=C4FG62UgWnhqbZ88Yg3PSeJPxxaoE1lOR5O6pycbuGUX9IU1re7+6RyOfwVrZ8VOfX74Pyv0OrgYuuctrl/YMFyKxiXhXtrjuKsUTLSsxFtXf+zbHwWvOMCXBcBx18wWBH1nlOK562Bj6zVI8f4rjf7FrtKs9VpqFlfQ376JqZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740537949; c=relaxed/simple;
	bh=ufIhsNpJNIKTz7qi+ACIkLpnIbfyzu448vrnHVHRuKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRvDI/zGNdl1tmJgfmYHMHssxoUBmLUGCHGe4c8XQh335QFfeeUcpC4C0dokZFpow1A4ZEeVWCJnfKVhaI0h8X4gGBjRaws1zPRfjr4a0G9AbVTfJkzwffXGVySNgVyCFMZSjZ3lAp2HC9MqCxml2jjeQkoB/oTjbRcDVwDzD/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RE174lwr; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 26 Feb 2025 02:45:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740537945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EbNoSRS6T8/zeLVgnP2O9DvEYvJLEH4yFWVyXWJJlAw=;
	b=RE174lwrbqIhruEE5ZFxcFQqYkGomE0iMBhYKd5kYBF+tCEmtemIxMjbgyJOHRUSsMXiC0
	XjTiTo47k0Lv9D82WYjqrzIkJRt7X73tBH9V56uUV3gW7G9fg5tKs9qEGsGOfDNCKVjah+
	EbZZcy8pS2nZkDwe0bFlG7QdaUBSbcs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
	chengming.zhou@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zswap: do not crash the kernel on decompression failure
Message-ID: <Z76AVZ_tjq2NvmLT@google.com>
References: <20250225213200.729056-1-nphamcs@gmail.com>
 <20250226005149.GA1500140@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226005149.GA1500140@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 25, 2025 at 07:51:49PM -0500, Johannes Weiner wrote:
> On Tue, Feb 25, 2025 at 01:32:00PM -0800, Nhat Pham wrote:
> > Currently, we crash the kernel when a decompression failure occurs in
> > zswap (either because of memory corruption, or a bug in the compression
> > algorithm). This is overkill. We should only SIGBUS the unfortunate
> > process asking for the zswap entry on zswap load, and skip the corrupted
> > entry in zswap writeback.
> > 
> > See [1] for a recent upstream discussion about this.
> > 
> > [1]: https://lore.kernel.org/all/ZsiLElTykamcYZ6J@casper.infradead.org/
> > 
> > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > Suggested-by: Yosry Ahmed <yosryahmed@google.com>
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > ---
> >  mm/zswap.c | 85 +++++++++++++++++++++++++++++++++++++-----------------
> >  1 file changed, 58 insertions(+), 27 deletions(-)
> > 
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index f6316b66fb23..31d4397eed61 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -62,6 +62,8 @@ static u64 zswap_reject_reclaim_fail;
> >  static u64 zswap_reject_compress_fail;
> >  /* Compressed page was too big for the allocator to (optimally) store */
> >  static u64 zswap_reject_compress_poor;
> > +/* Load and writeback failed due to decompression failure */
> > +static u64 zswap_reject_decompress_fail;
> 
> "reject" refers to "rejected store", so the name doesn't quite make
> sense. zswap_decompress_fail?
> 
> >  /* Store failed because underlying allocator could not get memory */
> >  static u64 zswap_reject_alloc_fail;
> >  /* Store failed because the entry metadata could not be allocated (rare) */
> > @@ -953,11 +955,12 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
> >  	return comp_ret == 0 && alloc_ret == 0;
> >  }
> >  
> > -static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
> > +static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
> >  {
> >  	struct zpool *zpool = entry->pool->zpool;
> >  	struct scatterlist input, output;
> >  	struct crypto_acomp_ctx *acomp_ctx;
> > +	bool ret = true;
> >  	u8 *src;
> >  
> >  	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
> > @@ -984,12 +987,19 @@ static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
> >  	sg_init_table(&output, 1);
> >  	sg_set_folio(&output, folio, PAGE_SIZE, 0);
> >  	acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, PAGE_SIZE);
> > -	BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait));
> > -	BUG_ON(acomp_ctx->req->dlen != PAGE_SIZE);
> > +	if (crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait) ||
> > +			acomp_ctx->req->dlen != PAGE_SIZE) {
> > +		ret = false;
> > +		zswap_reject_decompress_fail++;
> > +		pr_alert_ratelimited(
> > +			"decompression failed on zswap entry with offset %08lx\n",
> > +			entry->swpentry.val);
> 
> Since this is a pretty dramatic failure scenario, IMO it would be
> useful to dump as much info as possible.
> 
> The exact return value of crypto_wait_req() could be useful,
> entry->length and req->dlen too.
> 
> entry->pool->tfm_name just to make absolute sure there is no
> confusion, as the compressor can be switched for new stores.
> 
> Maybe swp_type() and swp_offset() of entry->swpentry? Those could be
> easy markers to see if the entry was corrupted for example.
> 
> > +	}
> >  	mutex_unlock(&acomp_ctx->mutex);
> >  
> >  	if (src != acomp_ctx->buffer)
> >  		zpool_unmap_handle(zpool, entry->handle);
> > +	return ret;
> >  }
> >  
> >  /*********************************
> > @@ -1018,6 +1028,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
> >  	struct writeback_control wbc = {
> >  		.sync_mode = WB_SYNC_NONE,
> >  	};
> > +	int ret = 0;
> >  
> >  	/* try to allocate swap cache folio */
> >  	mpol = get_task_policy(current);
> > @@ -1034,8 +1045,8 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
> >  	 * and freed when invalidated by the concurrent shrinker anyway.
> >  	 */
> >  	if (!folio_was_allocated) {
> > -		folio_put(folio);
> > -		return -EEXIST;
> > +		ret = -EEXIST;
> > +		goto put_folio;
> >  	}
> >  
> >  	/*
> > @@ -1048,14 +1059,17 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
> >  	 * be dereferenced.
> >  	 */
> >  	tree = swap_zswap_tree(swpentry);
> > -	if (entry != xa_cmpxchg(tree, offset, entry, NULL, GFP_KERNEL)) {
> > -		delete_from_swap_cache(folio);
> > -		folio_unlock(folio);
> > -		folio_put(folio);
> > -		return -ENOMEM;
> > +	if (entry != xa_load(tree, offset)) {
> > +		ret = -ENOMEM;
> > +		goto fail;
> >  	}
> >  
> > -	zswap_decompress(entry, folio);
> > +	if (!zswap_decompress(entry, folio)) {
> > +		ret = -EIO;
> > +		goto fail;
> > +	}
> > +
> > +	xa_erase(tree, offset);
> >  
> >  	count_vm_event(ZSWPWB);
> >  	if (entry->objcg)
> > @@ -1071,9 +1085,14 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
> >  
> >  	/* start writeback */
> >  	__swap_writepage(folio, &wbc);
> > -	folio_put(folio);
> > +	goto put_folio;
> >  
> > -	return 0;
> > +fail:
> > +	delete_from_swap_cache(folio);
> > +	folio_unlock(folio);
> > +put_folio:
> > +	folio_put(folio);
> > +	return ret;
> >  }
> 
> Nice, yeah it's time for factoring out the error unwinding. If you
> write it like this, you can save a jump in the main sequence:
> 
> 	__swap_writepage(folio, &wbc);
> 	ret = 0;
> put:
> 	folio_put(folio);
> 	return ret;
> delete_unlock:

(I like how you sneaked the label rename in here, I didn't like 'fail'
either :P)

> 	delete_from_swap_cache(folio);
> 	folio_unlock(folio);
> 	goto put;

I would go even further and avoid gotos completely (and make it super
clear what gets executed in the normal path vs the failure path):

	__swap_writepage(folio, &wbc);
	folio_put(folio);
	if (ret) {
		delete_from_swap_cache(folio);
		folio_unlock(folio);
	}
	return ret;

> 
> >  
> >  /*********************************
> > @@ -1600,6 +1619,29 @@ bool zswap_load(struct folio *folio)
> >  	if (WARN_ON_ONCE(folio_test_large(folio)))
> >  		return true;
> >  
> > +	/*
> > +	 * We cannot invalidate the zswap entry before decompressing it. If
> > +	 * decompression fails, we must keep the entry in the tree so that
> > +	 * a future read by another process on the same swap entry will also
> > +	 * have to go through zswap. Otherwise, we risk silently reading
> > +	 * corrupted data for the other process.
> > +	 */
> > +	entry = xa_load(tree, offset);
> > +	if (!entry)
> > +		return false;
> 
> The explanation in the comment makes sense in the context of this
> change. But fresh eyes reading this function and having never seen
> that this *used to* open with xa_erase() will be confused. It answers
> questions the reader doesn't have at this point - it's just a function
> called zswap_load() beginning with an xa_load(), so what?
> 
> At first I was going to suggest moving it down to the swapcache
> branch. But honestly after reading *that* comment again, in the new
> sequence, I don't think the question will arise there either. It's
> pretty self-evident that the whole "we can invalidate when reading
> into the swapcache" does not apply if the read failed.

+1

> 
> > +	/*
> > +	 * If decompression fails, we return true to notify the caller that the
> > +	 * folio's data were in zswap, but do not mark the folio as up-to-date.
> > +	 * This will effectively SIGBUS the calling process.
> > +	 */
> 
> It would be good to put a lampshade on this weirdness that the return
> value has nothing to do with success or not. This wasn't as important
> a distinction, but with actual decompression failures I think it is.

+1

> 
> Something like this?
> 
> 	if (!zswap_decompress(entry, folio)) {
> 		/*
> 		 * The zswap_load() return value doesn't indicate success or
> 		 * failure, but whether zswap owns the swapped out contents.
> 		 * This MUST return true here, otherwise swap_readpage() will
> 		 * read garbage from the backend.
> 		 *
> 		 * Success is signaled by marking the folio uptodate.
> 		 */

We use the same trick in the folio_test_large() branch, so maybe this
should be moved to above the function definition. Then we can perhaps
refer to it in places where we return true wihout setting uptodate for
added clarity if needed.

> 		return true;
> 	}
> 
> 	folio_mark_uptodate(folio);
> 
> > +	if (!zswap_decompress(entry, folio))
> > +		return true;
> > +
> > +	count_vm_event(ZSWPIN);
> > +	if (entry->objcg)
> > +		count_objcg_events(entry->objcg, ZSWPIN, 1);
> > +
> >  	/*
> >  	 * When reading into the swapcache, invalidate our entry. The
> >  	 * swapcache can be the authoritative owner of the page and
> > @@ -1612,21 +1654,8 @@ bool zswap_load(struct folio *folio)
> >  	 * files, which reads into a private page and may free it if
> >  	 * the fault fails. We remain the primary owner of the entry.)
> >  	 */
> > -	if (swapcache)
> > -		entry = xa_erase(tree, offset);
> > -	else
> > -		entry = xa_load(tree, offset);
> > -
> > -	if (!entry)
> > -		return false;
> > -
> > -	zswap_decompress(entry, folio);
> > -
> > -	count_vm_event(ZSWPIN);
> > -	if (entry->objcg)
> > -		count_objcg_events(entry->objcg, ZSWPIN, 1);
> > -
> >  	if (swapcache) {
> > +		xa_erase(tree, offset);
> >  		zswap_entry_free(entry);
> >  		folio_mark_dirty(folio);
> >  	}
> 

