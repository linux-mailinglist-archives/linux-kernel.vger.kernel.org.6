Return-Path: <linux-kernel+bounces-523817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCCDA3DBA1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D82F19C17DC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45B51F8BA4;
	Thu, 20 Feb 2025 13:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PnQQrtwu"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898711F6679
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 13:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740059270; cv=none; b=bj1uK30wgxGN7ZG/h5z33MPab+zsUhB8EVi4/mbN3whLkVMjMx6ZkoAJY9+iZoc5/WWMWCMEmJd60o81y/UkwsMhMiJ0SVabzfbBtHtz9Y8qmuqr5F4gZgCjeNCyazf7vopRKiaKtANPWK3z2lbtD/eUkpbKTtUt5yD3fdwymFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740059270; c=relaxed/simple;
	bh=9SbVlTM2sdprFphyHjCmpQjtuQqNFqZ9WqbaN3g83B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibCyOsBLxWR+qriQRDCFzrwZgSo87BQ4SZNW1K94ENCTSlah/ihh+wMZYVKu8s4+dVQg7m02U+0Z0jR5gg7ZxE6yrWoG2jtqre0HYYfyexReSWpfUJHwPOvxGq9uIwwg4Ev0WJqp/TkJBRSKg4MMzRpVjlyxD0M7IlAJlXHXVvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PnQQrtwu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WdR55ufWkYvXzh1JLeCQ0Bl5Q+PBA4XAk6E7b3brbGw=; b=PnQQrtwuIxU+6F2PP2fW9NJHuX
	tyLy5psy/wgNTGMgXnkPWUZnoT1GHQ5B+qU7HiL50V80UU86Esq7R0tLoR264O7fD5T8WAiMdE8mk
	/eAXxbpHvzG9mOuoj3pPxGsWNK82sxI2hfjTLY4UrX/v5yxdMNI+jYIUzE35d0WyOqIJ5UiSs/+Fo
	NYFsbj06K/ebOtHeJKODUbFfSl0yDv94Q8Z7m17IdWrLIWH6iSJ/oiiT9ZO95NmjBlovqHIbkybE/
	emTBV3BSPEiAJOv519Qq3vlRlFzIlB6zWDPs7Fic5LiyVQjaQE9NeVIDP3NpTMmnuKVIT6BAQRc6M
	rE/lD4rw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tl6u2-00000009liP-2FaF;
	Thu, 20 Feb 2025 13:47:46 +0000
Date: Thu, 20 Feb 2025 13:47:46 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Frank <david@davidfrank.ch>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Efficient mapping of sparse file holes to zero-pages
Message-ID: <Z7cygtpjGDJadgg0@casper.infradead.org>
References: <CAOR27cSr9yxodkctfp-Yjybh1NsKBeSkhdbZYeK7O5M87PfEYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOR27cSr9yxodkctfp-Yjybh1NsKBeSkhdbZYeK7O5M87PfEYw@mail.gmail.com>

On Thu, Feb 20, 2025 at 01:48:18PM +0100, David Frank wrote:
> I'd like to efficiently mmap a large sparse file (ext4), 95% of which
> is holes. I was unsatisfied with the performance and after profiling,
> I found that most of the time is spent in filemap_add_folio and
> filemap_alloc_folio - much more than in my algorithm:
> 
>  - 97.87% filemap_fault
>     - 97.57% do_sync_mmap_readahead
>        - page_cache_ra_order
>           - 97.28% page_cache_ra_unbounded
>              - 40.80% filemap_add_folio
>                 + 21.93% __filemap_add_folio
>                 + 8.88% folio_add_lru
>                 + 7.56% workingset_refault
>              + 28.73% filemap_alloc_folio
>              + 22.34% read_pages
>              + 3.29% xa_load

Yes, this is expected.

The fundamental problem is that we don't have the sparseness information
at the right point.  So the read request (or pagefault) comes in, the
VFS allocates a page, puts it in the pagecache, then asks the filesystem
to fill it.  The filesystem knows, so could theoretically tell the VFS
"Oh, this is a hole", but by this point the "damage" is done -- the page
has been allocated and added to the page cache.

Of course, this is a soluble problem.  The VFS could ask the filesystem
for its sparseness information (as you do in userspace), but unlike your
particular usecase, the kernel must handle attackers who are trying to
make it do the wrong thing as well as ill-timed writes.  So the VFS has
to ensure it does not use stale data from the filesystem.

This is a problem I'm somewhat interested in solving, but I'm a bit
busy with folios right now.  And once that project is done, improving
the page cache for reflinked files is next on my list, so I'm not likely
to get to this problem for a few years.


