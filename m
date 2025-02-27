Return-Path: <linux-kernel+bounces-537026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7313BA4872D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E12C3B8BCE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594401EB5DA;
	Thu, 27 Feb 2025 18:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MeFjGhMz"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8DC1B85D1
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740679303; cv=none; b=fe81LP0TbpjThXnhqebPebZIshjQgOE6+pnb7gI2xmnywRzVGmC0AAs3xH30BGz7vIrUxO2qfR3iYNynMGeu2UBXLH1DeoGlgFF2TcvsgjoTAqrsMS3/MGX7gLf7CRtXqZglhqC+S23n0vXTj04C/DQa1TCUHGS+kEr1XryXq4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740679303; c=relaxed/simple;
	bh=Ems5tkxmi0uschNxvAxkEqx9V9tPFa+XrwR81nrEY+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhO9Q1jrG3SBVCAgBs7QBh/SU3yzk4PWjeNbb766Vx8m5lzLUO4JoUEDERgongWE5l0PF5O7bXP8C83QWpXdt9MHEc6KBgKJ6xy8JhMmbecNoe1FU7Jvk8TpMtQkwGJ/KXSe6wIjA7XEacYfTp6k0KHxzv+9UPkUoYZGIYjsGyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MeFjGhMz; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 27 Feb 2025 18:01:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740679297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pwBsgEVKDn0GJpd6GPiEBOIf24UR9yocMEJl9yXiBk0=;
	b=MeFjGhMzpxmQ03GvSJsJ5lNFLjVz4HpQbrClhJHaCKGp8ddDwBcERXWF3HNRafAQ5MBYMb
	bnIegsQ+iXQ+CFuamWJZbR506NAyFv0F3d8ySCAXOdnFLQ9+14yDnyh4VQQQEGSEzGia3v
	bwnpjFf9pV/QPBwifkhlPwvrRZ5tuuk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
	chengming.zhou@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] zswap: do not crash the kernel on decompression
 failure
Message-ID: <Z8CofKw5Klcus_LM@google.com>
References: <20250227001445.1099203-1-nphamcs@gmail.com>
 <Z7-9o81kBfw4tFSz@google.com>
 <20250227043141.GB110982@cmpxchg.org>
 <Z7_7vah_U1JzmpCX@google.com>
 <20250227061616.GD110982@cmpxchg.org>
 <Z8AQPyY7Qpux0mO0@google.com>
 <Z8AUaQamubA9lWae@google.com>
 <20250227160528.GF110982@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227160528.GF110982@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 27, 2025 at 11:05:28AM -0500, Johannes Weiner wrote:
> On Thu, Feb 27, 2025 at 07:29:45AM +0000, Yosry Ahmed wrote:
> > Maybe we can do something like this:
> > 
> > /* Returns true if the folio was in the zeromap or zswap */
> > bool swap_read_folio_in_memory(struct folio *folio)
> > {
> > 	int ret;
> > 
> > 	ret = swap_read_folio_zeromap(folio);
> > 	if (ret == -ENOENT)
> > 		ret = zswap_load(folio);
> > 
> > 	if (ret == 0) {
> > 		folio_mark_uptodate(folio);
> > 		folio_unlock(folio);
> > 		return true;
> > 	} else if (ret != -ENOENT) {
> > 		folio_unlock(folio);
> > 		return true;
> > 	} else {
> > 		return false;
> > 	}
> > }
> 
> Eh, I think we're getting colder again.
> 
> This looks repetitive, zswap_load() is kind of awkward in that error
> leg, and combining the two into one function is a bit of a stretch.
> 
> There is also something to be said about folio_mark_uptodate() and
> folio_unlock() ususally being done by the backend implementation - in
> what the page cache would call the "filler" method - to signal when
> it's done reading, and what the outcome was.
> 
> E.g. for fs it's always in the specific ->read implementation:
> 
> static int simple_read_folio(struct file *file, struct folio *folio)
> {
> 	folio_zero_range(folio, 0, folio_size(folio));
> 	flush_dcache_folio(folio);
> 	folio_mark_uptodate(folio);
> 	folio_unlock(folio);
> 	return 0;
> }
> 
> and not in the generic manifold:
> 
> $ grep -c folio_mark_uptodate mm/filemap.c 
> 0
> 
> I'd actually rather push those down into zeromap and zswap as well to
> follow that pattern more closely:

Hmm yeah for the sake of consistency I think we can do that. My main
concern was the comments clarifying the 'true' return value without
marking uptodate is a fail in a lot of places in zswap and zeromap code.
However, I think returning an error code as you suggested makes it more
obvious and reduces the need for comments.

So yes I think your proposed approach is better (with a few comments).

> 
> diff --git a/mm/page_io.c b/mm/page_io.c
> index 9b983de351f9..1fb5ce1884bd 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -538,6 +538,7 @@ static bool swap_read_folio_zeromap(struct folio *folio)
>  
>  	folio_zero_range(folio, 0, folio_size(folio));
>  	folio_mark_uptodate(folio);
> +	folio_unlock(folio);
>  	return true;

So I think we should double down and follow the same pattern for
swap_read_folio_zeromap() too. Return an error code too to clarify the
skip uptodate case.

>  }
>  
> @@ -635,13 +636,11 @@ void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
>  	}
>  	delayacct_swapin_start();
>  
> -	if (swap_read_folio_zeromap(folio)) {
> -		folio_unlock(folio);
> +	if (swap_read_folio_zeromap(folio))
>  		goto finish;

and this ends up being closer to the zswap pattern:

	if (swap_read_folio_zeromap(folio) != -ENOENT)
		goto finish;

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
> index 6dbf31bd2218..76b2a964b0cd 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1620,7 +1620,7 @@ bool zswap_store(struct folio *folio)
>  	return ret;
>  }
>  

And here we should explain the different return codes and when we return
with the folio locked/unlocked or marked uptodate.

> -bool zswap_load(struct folio *folio)
> +int zswap_load(struct folio *folio)
>  {
>  	swp_entry_t swp = folio->swap;
>  	pgoff_t offset = swp_offset(swp);
> @@ -1631,7 +1631,7 @@ bool zswap_load(struct folio *folio)
>  	VM_WARN_ON_ONCE(!folio_test_locked(folio));
>  
>  	if (zswap_never_enabled())
> -		return false;
> +		return -ENOENT;
>  
>  	/*
>  	 * Large folios should not be swapped in while zswap is being used, as
> @@ -1641,8 +1641,25 @@ bool zswap_load(struct folio *folio)
>  	 * Return true without marking the folio uptodate so that an IO error is
>  	 * emitted (e.g. do_swap_page() will sigbus).
>  	 */
> -	if (WARN_ON_ONCE(folio_test_large(folio)))
> -		return true;
> +	if (WARN_ON_ONCE(folio_test_large(folio))) {
> +		folio_unlock(folio);
> +		return -EINVAL;
> +	}
> +
> +	entry = xa_load(tree, offset);
> +	if (!entry)
> +		return -ENOENT;
> +
> +	if (!zswap_decompress(entry, folio)) {
> +		folio_unlock(folio);
> +		return -EIO;
> +	}
> +
> +	folio_mark_uptodate(folio);
> +
> +	count_vm_event(ZSWPIN);
> +	if (entry->objcg)
> +		count_objcg_events(entry->objcg, ZSWPIN, 1);
>  
>  	/*
>  	 * When reading into the swapcache, invalidate our entry. The
> @@ -1656,27 +1673,14 @@ bool zswap_load(struct folio *folio)
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
> -		zswap_entry_free(entry);
>  		folio_mark_dirty(folio);
> +		xa_erase(tree, offset);
> +		zswap_entry_free(entry);
>  	}
>  
> -	folio_mark_uptodate(folio);
> -	return true;
> +	folio_unlock(folio);
> +	return 0;
>  }
>  
>  void zswap_invalidate(swp_entry_t swp)

