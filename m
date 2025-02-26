Return-Path: <linux-kernel+bounces-534319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC76A4657C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 901FB1897B67
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9716223302;
	Wed, 26 Feb 2025 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y92Tuumh"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C2721CA1E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584531; cv=none; b=VDV4jZqIIfGpjFXBTwV9XZV1HpXI5wSsgIrr+/hkhZm4P/s0UGpR6WecLEBChYzmsIV49/rmouib1uYAVl9Xrm9QelEoInrenH7szdxEOiqVrbNThwfmOEf3RfnsecbHe+WeGyqmyR7aUmnbDjo+GN3yalJdCZ5KARsFX9w/bok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584531; c=relaxed/simple;
	bh=X/2mRuNpOCsKfLqIY1rhKBcbI/1znlC5uDg55ux+Qk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXvcFv/cV33KVLBqcdOwJthPX9V+QQCTBa+JbrltW4c04ItpOfEPD7s/oN7DCR/Xy8TTAUazt3Yssas6reM4kHxizcPZ7Ey0bPN1jK4z9ueqqW2P6q4sHSAakJdUVuxizoykdKUEuTZ/T1JvZWaby6wI7GTv0XDu/Z5SuiyYfDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y92Tuumh; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 26 Feb 2025 15:42:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740584525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G0ka5+57U6hHrywsA4GiXl4SPgDlHG+Ia84OVSI5zrg=;
	b=Y92TuumhhX48sxCcHAtjxEUE7+wn9akk6NdxpMBZJJQsRa2Iy/RzGC+H5P165D76CAHDX5
	DnFw39WGfHZ9cBqyX3lD2rUlsB4zi9iWbAP89TxnMojgduqiPwtqjvR5Fc3jZhS6wd5wYt
	fGHMPDavMUJaD9WK+vXJ/G//pOYAJOk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
	chengming.zhou@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zswap: do not crash the kernel on decompression failure
Message-ID: <Z782SPcJI8DFISRa@google.com>
References: <20250225213200.729056-1-nphamcs@gmail.com>
 <20250226005149.GA1500140@cmpxchg.org>
 <Z76AVZ_tjq2NvmLT@google.com>
 <20250226035730.GA1775487@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226035730.GA1775487@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 25, 2025 at 10:57:30PM -0500, Johannes Weiner wrote:
> On Wed, Feb 26, 2025 at 02:45:41AM +0000, Yosry Ahmed wrote:
> > On Tue, Feb 25, 2025 at 07:51:49PM -0500, Johannes Weiner wrote:
> > > On Tue, Feb 25, 2025 at 01:32:00PM -0800, Nhat Pham wrote:
> > > > +	}
> > > >  	mutex_unlock(&acomp_ctx->mutex);
> > > >  
> > > >  	if (src != acomp_ctx->buffer)
> > > >  		zpool_unmap_handle(zpool, entry->handle);
> > > > +	return ret;
> > > >  }
> > > >  
> > > >  /*********************************
> > > > @@ -1018,6 +1028,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
> > > >  	struct writeback_control wbc = {
> > > >  		.sync_mode = WB_SYNC_NONE,
> > > >  	};
> > > > +	int ret = 0;
> > > >  
> > > >  	/* try to allocate swap cache folio */
> > > >  	mpol = get_task_policy(current);
> > > > @@ -1034,8 +1045,8 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
> > > >  	 * and freed when invalidated by the concurrent shrinker anyway.
> > > >  	 */
> > > >  	if (!folio_was_allocated) {
> > > > -		folio_put(folio);
> > > > -		return -EEXIST;
> > > > +		ret = -EEXIST;
> > > > +		goto put_folio;
> > > >  	}
> > > >  
> > > >  	/*
> > > > @@ -1048,14 +1059,17 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
> > > >  	 * be dereferenced.
> > > >  	 */
> > > >  	tree = swap_zswap_tree(swpentry);
> > > > -	if (entry != xa_cmpxchg(tree, offset, entry, NULL, GFP_KERNEL)) {
> > > > -		delete_from_swap_cache(folio);
> > > > -		folio_unlock(folio);
> > > > -		folio_put(folio);
> > > > -		return -ENOMEM;
> > > > +	if (entry != xa_load(tree, offset)) {
> > > > +		ret = -ENOMEM;
> > > > +		goto fail;
> > > >  	}
> > > >  
> > > > -	zswap_decompress(entry, folio);
> > > > +	if (!zswap_decompress(entry, folio)) {
> > > > +		ret = -EIO;
> > > > +		goto fail;
> > > > +	}
> > > > +
> > > > +	xa_erase(tree, offset);
> > > >  
> > > >  	count_vm_event(ZSWPWB);
> > > >  	if (entry->objcg)
> > > > @@ -1071,9 +1085,14 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
> > > >  
> > > >  	/* start writeback */
> > > >  	__swap_writepage(folio, &wbc);
> > > > -	folio_put(folio);
> > > > +	goto put_folio;
> > > >  
> > > > -	return 0;
> > > > +fail:
> > > > +	delete_from_swap_cache(folio);
> > > > +	folio_unlock(folio);
> > > > +put_folio:
> > > > +	folio_put(folio);
> > > > +	return ret;
> > > >  }
> > > 
> > > Nice, yeah it's time for factoring out the error unwinding. If you
> > > write it like this, you can save a jump in the main sequence:
> > > 
> > > 	__swap_writepage(folio, &wbc);
> > > 	ret = 0;
> > > put:
> > > 	folio_put(folio);
> > > 	return ret;
> > > delete_unlock:
> > 
> > (I like how you sneaked the label rename in here, I didn't like 'fail'
> > either :P)
> > 
> > > 	delete_from_swap_cache(folio);
> > > 	folio_unlock(folio);
> > > 	goto put;
> > 
> > I would go even further and avoid gotos completely (and make it super
> > clear what gets executed in the normal path vs the failure path):
> > 
> > 	__swap_writepage(folio, &wbc);
> > 	folio_put(folio);
> > 	if (ret) {
> > 		delete_from_swap_cache(folio);
> > 		folio_unlock(folio);
> > 	}
> > 	return ret;
> 
> The !folio_was_allocated case only needs the put. I guess that could
> stay open-coded.

We also do:

	if (ret && ret != -EEXIST) {
		...
	}

or

	if (ret && !folio_was_allocated) {
		...
	}

Probably the latter is clearer. If the folio was already there, we
didn't add it to the swapcache or lock it ourselves so we don't unwind
that.

> 
> And I think you still need one goto for the other two error legs to
> jump past the __swap_writepage.

Oh yeah I meant eliminate the jumps within the cleanup/return code, not
entirely. Sorry for the confusion. We still need an 'out' label or
similar after __swap_writepage().

> 
> > > Something like this?
> > > 
> > > 	if (!zswap_decompress(entry, folio)) {
> > > 		/*
> > > 		 * The zswap_load() return value doesn't indicate success or
> > > 		 * failure, but whether zswap owns the swapped out contents.
> > > 		 * This MUST return true here, otherwise swap_readpage() will
> > > 		 * read garbage from the backend.
> > > 		 *
> > > 		 * Success is signaled by marking the folio uptodate.
> > > 		 */
> > 
> > We use the same trick in the folio_test_large() branch, so maybe this
> > should be moved to above the function definition. Then we can perhaps
> > refer to it in places where we return true wihout setting uptodate for
> > added clarity if needed.
> 
> That makes sense to me. Nhat, what do you think?

