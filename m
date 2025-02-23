Return-Path: <linux-kernel+bounces-527546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90878A40C81
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 02:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA7E23B3408
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 01:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FF6CA4E;
	Sun, 23 Feb 2025 01:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c+7Y3LOQ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38AB28F4
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 01:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740275279; cv=none; b=mzvnSSyKrZ5a5VwbxXaDnTHCN++j2qUDStCLg+xniLjI1Kc9xsWymjih/02cRFRIW/0ZCtFd+mqLSUmeIetX8WqIh658AAU4k/9NSB6ghV4ifvJpAzQFgkCTEch6/yWJpNLyPV0i/LwdqpwjfCoGGoc6hFh1maK0f1OfMFmsxd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740275279; c=relaxed/simple;
	bh=DSNmryvK08Azzojx44xanC00/OwsHw861kHFHD2Dhts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d46GWR5jHNPnoX0eWegbWa3yugRb5AStZjwyIkMtYBqTwH0lm0UJI3kd7PsdGJeCuOqhRlFjI/TdVpWigiH8wjHZgvI361Surw1m1jqULDB39pwK7RpCNzGrRU+c0coD+5i5BBkpp6+Vo3jT90nAMEjDFtTPNEubQQI/R2QJLJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=c+7Y3LOQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tO6tOZLCUciZBJnG/Rw817r3O8VM969b6bQPUS7fc/c=; b=c+7Y3LOQdt3ZEU9PdFiZ+vjJqt
	eTS4RgngV2dHy+DpdpzHSqYWw7dWcqSEZmk3Q1Xv3PsaGleg1LKCab0iQ1Vu3oZDppCc4CMHoL7MY
	bwWrm3dLFxF+KiapF5WEWN63f1luIiR6ytmNgonmS1IFv/VrcrcA7qKoHqGRj+/60DSG10KR+bRbP
	yqPC+lgRPvBjyXYVxKCipqGE4AeRXps2kufsq03QEU4IGiOecCtCsfLRO896XLCi5kTX041ukCznR
	iguT0g+go7fC3LBzEyAFpCLRLx1uGvRzJYZ/604s2iBb5WFJD0nuDA6SkqcA1Aa0PFGdYKC7r0Xvc
	2XbM5w0Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tm161-00000001vcW-0Mqa;
	Sun, 23 Feb 2025 01:47:53 +0000
Date: Sun, 23 Feb 2025 01:47:52 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Frank <david@davidfrank.ch>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Efficient mapping of sparse file holes to zero-pages
Message-ID: <Z7p-SLdiyQCknetc@casper.infradead.org>
References: <CAOR27cSr9yxodkctfp-Yjybh1NsKBeSkhdbZYeK7O5M87PfEYw@mail.gmail.com>
 <Z7cygtpjGDJadgg0@casper.infradead.org>
 <CAOR27cQ8oHmA8fWnmB7Wk5pTL4TRjMPzRuqT=uA1cVROYZH7UA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOR27cQ8oHmA8fWnmB7Wk5pTL4TRjMPzRuqT=uA1cVROYZH7UA@mail.gmail.com>

On Thu, Feb 20, 2025 at 09:46:08PM +0100, David Frank wrote:
> Thank you, Matthew, for your reply.
> 
> What do you think about the complexity of this task? I'd be interested
> in taking a look but I don't have kernel development experience so I
> would need guidance.

Unfortunately, I would say this is a high complexity task.  At a high
level, I think we'd need:

 - Choose a data structure in the VFS to store this range information
   (a tree of some kind)
 - Design a protocol such that the VFS can query this information about
   a range of a particular file, and the filesystem can invalidate the
   VFS's knowledge
 - Use that range information when performing readahead [1]
 - Put zero entries into the page cache
 - Handle retrieving zero entries appropriately at all the points which
   currently retrieve folios from the page cache
 - Handle tearing down mmaps of zero entries when written to

Probably a few other things, but that's about the size of it.

I started hinting at a way to do the second point, and it was not
well-received.

https://lore.kernel.org/linux-fsdevel/Ytcd2a0RVCccWOmC@casper.infradead.org/
got no responses
https://lore.kernel.org/linux-fsdevel/Zs97qHI-wA1a53Mm@casper.infradead.org/
got a lot of push-back.

I consider most of the responses on that thread to be from people who
understand the problems far better than I do, so I'd need to learn a
lot more before making another proposal.

[1] Little secret, almost all reads / page faults are handled by
readahead

> On Thu, 20 Feb 2025 at 14:47, Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Thu, Feb 20, 2025 at 01:48:18PM +0100, David Frank wrote:
> > > I'd like to efficiently mmap a large sparse file (ext4), 95% of which
> > > is holes. I was unsatisfied with the performance and after profiling,
> > > I found that most of the time is spent in filemap_add_folio and
> > > filemap_alloc_folio - much more than in my algorithm:
> > >
> > >  - 97.87% filemap_fault
> > >     - 97.57% do_sync_mmap_readahead
> > >        - page_cache_ra_order
> > >           - 97.28% page_cache_ra_unbounded
> > >              - 40.80% filemap_add_folio
> > >                 + 21.93% __filemap_add_folio
> > >                 + 8.88% folio_add_lru
> > >                 + 7.56% workingset_refault
> > >              + 28.73% filemap_alloc_folio
> > >              + 22.34% read_pages
> > >              + 3.29% xa_load
> >
> > Yes, this is expected.
> >
> > The fundamental problem is that we don't have the sparseness information
> > at the right point.  So the read request (or pagefault) comes in, the
> > VFS allocates a page, puts it in the pagecache, then asks the filesystem
> > to fill it.  The filesystem knows, so could theoretically tell the VFS
> > "Oh, this is a hole", but by this point the "damage" is done -- the page
> > has been allocated and added to the page cache.
> >
> > Of course, this is a soluble problem.  The VFS could ask the filesystem
> > for its sparseness information (as you do in userspace), but unlike your
> > particular usecase, the kernel must handle attackers who are trying to
> > make it do the wrong thing as well as ill-timed writes.  So the VFS has
> > to ensure it does not use stale data from the filesystem.
> >
> > This is a problem I'm somewhat interested in solving, but I'm a bit
> > busy with folios right now.  And once that project is done, improving
> > the page cache for reflinked files is next on my list, so I'm not likely
> > to get to this problem for a few years.
> >

