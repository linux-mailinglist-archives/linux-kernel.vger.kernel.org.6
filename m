Return-Path: <linux-kernel+bounces-188291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C12D8CE01A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 05:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99C8C1F20F9E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 03:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CE8383AE;
	Fri, 24 May 2024 03:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tuIL4tBU"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB06E381B9
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 03:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716523181; cv=none; b=SGshYpTgaI2UjSQvEcblZm/GihDXOL6KWtsL2TYeMhf7pYB1bxypylpZj99BFJODuR6b+zJGj12QrOcvVXLFGv2GyQUGTHOHkQwZ/MfJqpXUYpbXKouTuhL1fBJ6azVJsmysCluq6AZpDuzzy4pql+QmiUUL9GUbsZRqVSlfgrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716523181; c=relaxed/simple;
	bh=BRIE94Uh5NwF0ee0JGA4E0cLLJpDywPC9zz1LVn8thI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vvyk+/kWTsIEcmsaiEUVYqR080PE5qJQdVH8Eh+35psAqkna4NY/H/ECjp6cPHzHMsXD0nIPrIM6hf03RcL+N7yNmTpzecgQ+olrcFpHBkfplrLpb1ZW/fHq73F78yXFkRX1Wv1BrOF9WOEWGJon7oKf5zuJ+47cT7fiovlfp1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tuIL4tBU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TKUxDCU4Matxcb4X80T42SzbEohf2CEMtw7weq8/G6g=; b=tuIL4tBUl3MYDxcWcCbgDxxvk9
	laSyMsv8hX1myUUVW4emGzHles9mYf5jVvRT9JzaYsxRoEF9jXxPKgHs0+hzTR3SkvkO9t/ALthZv
	tTTj6SjQswBvGTfQ5cp5M1Png3GvEkC3COqBI9nI8c3XFafYXizbjpiXqQ05ecsvBdq9fj9KsPOB4
	tQ7RBrRnwfrdDHH/4ayYIWYk5PRTpp6lhfKnQxsg6uTLB5sPjq3OdY7TJd2h+0n9vqsdgdl0JMBXH
	3ts5KOvbthmldq19nDDI5IS7Whav5HCkVqPZ4yXH/CdE4ROKJDho2hj9hWA9o4BOjjNAek+2RDPfs
	onxUcnTg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAM5b-00000002O0p-3GoC;
	Fri, 24 May 2024 03:59:32 +0000
Date: Fri, 24 May 2024 04:59:31 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] mm: zswap: trivial folio conversions
Message-ID: <ZlAQo0P4Z-dgVHn6@casper.infradead.org>
References: <20240524033819.1953587-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524033819.1953587-1-yosryahmed@google.com>

On Fri, May 24, 2024 at 03:38:15AM +0000, Yosry Ahmed wrote:
> Some trivial folio conversions in zswap code.

The three patches themselves look good.

> The mean reason I included a cover letter is that I wanted to get
> feedback on what other trivial conversions can/should be done in
> mm/zswap.c (keeping in mind that only order-0 folios are supported
> anyway).  These are the things I came across while searching for 'page'
> in mm/zswap.c, and chose not to do anything about for now:

I think there's a deeper question to answer before answering these
questions, which is what we intend to do with large folios and zswap in
the future.  Do we intend to split them?  Compress them as a large
folio?  Compress each page in a large folio separately?  I can see an
argument for choices 2 and 3, but I think choice 1 is going to be
increasingly untenable.

> 1. zswap_max_pages(), zswap_accept_thr_pages(), zswap_total_pages():
>   - We can use 'size' instead of 'pages' and shift the return by
>     PAGE_SHIFT. This adds an unnecessary shift, but I doubt it matters
>     at all. The motivation is to get rid of 'page' to find things that
>     should be converted more easily.
> 
> 2. Counters names: zswap_stored_pages, zswap_written_back_pages, etc.
> 
> 3. Comments all over the place reference 'page' instead of 'folio'.
> 
> 4. shrink_memcg_cb(), zswap_shrinker_scan():
>   - Rename encountered_page_in_swap_cache to
>     encounterd_folio_in_swap_cache, or even better: folio_eexist or
>     hit_swap_cache.
> 
> 5. entry_to_nid():
>   - It's tempting to try to use folio_to_nid(virt_to_folio()), but I
>     think this adds an unnecessary call to compound_head(). It may not
>     matter in practice though because the page is always a head page.
> 
> Yosry Ahmed (3):
>   mm: zswap: use sg_set_folio() in zswap_{compress/decompress}()
>   mm :zswap: use kmap_local_folio() in zswap_load()
>   mm: zswap: make same_filled functions folio-friendly
> 
>  mm/zswap.c | 41 ++++++++++++++++++-----------------------
>  1 file changed, 18 insertions(+), 23 deletions(-)
> 
> -- 
> 2.45.1.288.g0e0cd299f1-goog
> 
> 

