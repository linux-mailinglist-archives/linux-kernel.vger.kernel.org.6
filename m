Return-Path: <linux-kernel+bounces-227809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4F09156BE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E05811C212DC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0CA1A00CE;
	Mon, 24 Jun 2024 18:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d87c12vY"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E78225D9;
	Mon, 24 Jun 2024 18:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719255270; cv=none; b=mhZs3vOMgbgM1U6mDEZ72PlEMYHGGk/JEfduTvECJ528upzuuax1jWTWXu0Ynb3pJsTLDWGNGrGIOyIT7szXDoq2U96kmbOuvvE9RBrdjYDs5EDh/UrJpxMsJYJtfEErpnFstycPSfAjMIr1H1wJXRHZOPgohzCHolJJIL+x/3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719255270; c=relaxed/simple;
	bh=fzmtYv24eQZO1QGqbvDRhNoi7jf5Oueo76z6+lwR000=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JU0oQ5QCLFX9fg2425SoHxRyOSCvGgULm4kAc5UT22p3mfyr2W45mLpX4BBcq2SJjYPlq3yYZq5N4mt6BvKpgYpIOKcQ4Q9PHkchcdkc6aKskJLi+yQrKIaCNhfHqV7qcThpUnjj0zUDCxJGXvOsuF0vIHlS6fViJGuBWnbhHZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d87c12vY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=TzlUaFbysJxYqg4lFli1LHYXJm8gggtlo9u9TQd/iss=; b=d87c12vYIxHPF1bPYLUMuXQ9S3
	wGlIDoB6w7W/hQ0e0piEKYxV1DvlIKBOW7JXbzODG4ngYSGGs0aBNncD5H+9Pp4WqB5pgx7pBN3DD
	WZau1vtBf5PCWYKRor3THVohr1nYxdjqu7m0cOfYehZlWOGg9FvaMhWxpVkeBG/UscBVBM5TRsJ6X
	P1y3Ls2Hqt9mOBlRkEMe12OlaKyCIQd2cUDjFsUoQ1pn/MHfwfCt8GWQ9Pj+UpR4DpJxYJc0+nNxu
	xZA4BouKSI4Icz5gRFCgBPUtDEZcG63qagW6OSn22FHshH1Cu5Zh2wQ9k8QB7nGWcygRLvYIZ16nZ
	Wsylqf8A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLopc-0000000ALXV-1LNO;
	Mon, 24 Jun 2024 18:54:24 +0000
Date: Mon, 24 Jun 2024 19:54:24 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>,
	kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>, David Hildenbrand <david@redhat.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Hugh Dickins <hughd@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [linux-next:master] [mm] 0fa2857d23:
 WARNING:at_mm/page_alloc.c:#__alloc_pages_noprof
Message-ID: <ZnnA4BswPcyedF2B@casper.infradead.org>
References: <202406241651.963e3e78-oliver.sang@intel.com>
 <CAJD7tkbqHyNUzQg_Qh+-ZryrKtMzdf5RE-ndT+4iURTqEo3o6A@mail.gmail.com>
 <Znm74wW3xARhR2qN@casper.infradead.org>
 <ad18c6fb-7d00-494b-a1f6-3d4acfbd2323@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad18c6fb-7d00-494b-a1f6-3d4acfbd2323@gmail.com>

On Mon, Jun 24, 2024 at 09:50:21PM +0300, Usama Arif wrote:
> On 24/06/2024 21:33, Matthew Wilcox wrote:
> > On Mon, Jun 24, 2024 at 05:05:56AM -0700, Yosry Ahmed wrote:
> > > On Mon, Jun 24, 2024 at 1:49 AM kernel test robot <oliver.sang@intel.com> wrote:
> > > > kernel test robot noticed "WARNING:at_mm/page_alloc.c:#__alloc_pages_noprof" on:
> > > > 
> > > > commit: 0fa2857d23aa170e5e28d13c467b303b0065aad8 ("mm: store zero pages to be swapped out in a bitmap")
> > > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > > This is coming from WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp), and
> > > is triggered by the new bitmap_zalloc() call in the swapon path. For a
> > > sufficiently large swapfile, bitmap_zalloc() (which uses kmalloc()
> > > under the hood) cannot be used to allocate the bitmap.
> > Do we need to use a bitmap?
> > 
> > We could place a special entry in the swapcache instead (there's
> > XA_ZERO_ENTRY already defined, and if we need a different entry that's
> > not XA_ZERO_ENTRY, there's room for a few hundred more special entries).
> 
> I was going for the most space-efficient and simplest data structure, which
> is bitmap. I believe xarray is either pointer or integer between 0 and
> LONG_MAX? We could convert the individual bits into integer and store them,
> and have another function to extract the integer stored in xarray to a bit,
> but I think thats basically a separate bitmap_xarray API (which would
> probably take more space than a traditional bitmap API, and I dont want to
> make this series dependent on something like that), so I would prefer to use
> bitmap.

But we already _have_ an xarray.  Instead of storing a swap entry in
it, we could store an XA_ZERO_ENTRY.

If there are long runs of zero pages, then this may not be the best
idea.  But then a bitmap isn't the best data structure for long runs
either.

