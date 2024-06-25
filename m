Return-Path: <linux-kernel+bounces-229023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DE49169D4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE17CB230F1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793F915FCE9;
	Tue, 25 Jun 2024 14:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b3anXdf6"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C6A1B7F7
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719324425; cv=none; b=MA8iA4Qd9UFziJBTQguPKFqJKuRBTu2f6x78NLBqK53KaD3T06fuBpYg9dltbwWH3WD+YQS27y5J8YzwwYYZR309Y1zDTn2rtRHaFT9Tqair56OMsuJxqTsIUeHViE71TWU5YM3pdC0+H0SL3LH4kTa1Gm3sVWwxbYoaOWhVxs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719324425; c=relaxed/simple;
	bh=HurV4YlLhMcDPGGBVRrfcSvNLYL6IdEFP1wBB8tq47w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZZp7EF18KNLB2yOqSw3LHY31CYKbVAWiMWQsWJs0o4iMLlHn3l2rcbsIiOe03Yae61FQCHbP5WeZTxLAEZbRmwi0K3uHNb+FptFUrq5ezHa0tiNvFNUUGUkj+32v6duO0d5R38Sm26yiCiwZY98Bjt6GBFksRqSj5+uifbJQ70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b3anXdf6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hGiPM6C5L/nRqsdu3jq0C7CbnwzvLeffETFeFxTX0+E=; b=b3anXdf6y1JVACdaTmYa87Qdwz
	IXn7N2bJIfzk9KNwWXeg8tumh7lqXZTBdx3GEINGv9BNJyMrvBKM/tmlyIK+vjWWO7lMBqI2/gW4N
	XQP8c9u0eYpqkmTL11wjuLbSi2rQCqK2/qoiw2rq7DlGfa9/ApwsOpqEbj3j0JZ+Uy58IC72wpm44
	RVUjYWXi/WdkaINNa8n4X8Kgwq91tskrXsMl9afIlOrW59G3xNzWOCh56uVJUJram+C2/i0JjGNRT
	VvpU11sKddLUsxQfVklfujUBPT4Ny+My7k0dM+8H17DBjtzWVsKSKnjwEbtWus2udI+8mjTe8+C63
	EkRPsf+A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sM6oT-0000000BCMT-2TZf;
	Tue, 25 Jun 2024 14:06:25 +0000
Date: Tue, 25 Jun 2024 15:06:25 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	David Hildenbrand <david@redhat.com>,
	John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
	Barry Song <21cnbao@gmail.com>,
	Alistair Popple <apopple@nvidia.com>,
	Yang Shi <shy828301@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Yin, Fengwei" <fengwei.yin@intel.com>,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 18/18] arm64/mm: Automatically fold contpte mappings
Message-ID: <ZnrO4clYoEH_67Ur@casper.infradead.org>
References: <20240215103205.2607016-19-ryan.roberts@arm.com>
 <1285eb59-fcc3-4db8-9dd9-e7c4d82b1be0@huawei.com>
 <8d57ed0d-fdd0-4fc6-b9f1-a6ac11ce93ce@arm.com>
 <018b5e83-789e-480f-82c8-a64515cdd14a@huawei.com>
 <b75aa60d-e058-4b5c-877a-9c0cd295e96f@linux.alibaba.com>
 <b6b485ee-7af0-42b8-b0ca-5a75f76a69e2@arm.com>
 <43a5986a-52ea-4090-9333-90af137a4735@linux.alibaba.com>
 <306874fe-9bc1-4dec-a856-0125e4541971@arm.com>
 <ZnrAzjm5Fqg0d1CL@casper.infradead.org>
 <dbeb71ca-8aba-4aed-9123-c4d07c3da004@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbeb71ca-8aba-4aed-9123-c4d07c3da004@arm.com>

On Tue, Jun 25, 2024 at 02:41:18PM +0100, Ryan Roberts wrote:
> On 25/06/2024 14:06, Matthew Wilcox wrote:
> > On Tue, Jun 25, 2024 at 01:41:02PM +0100, Ryan Roberts wrote:
> >> On 25/06/2024 13:37, Baolin Wang wrote:
> >>
> >> [...]
> >>
> >>>>> For other filesystems, like ext4, I did not found the logic to determin what
> >>>>> size of folio to allocate in writable mmap() path
> >>>>
> >>>> Yes I'd be keen to understand this to. When I was doing contpte, page cache
> >>>> would only allocate large folios for readahead. So that's why I wouldn't have
> >>>
> >>> You mean non-large folios, right?
> >>
> >> No I mean that at the time I wrote contpte, the policy was to allocate an
> >> order-0 folio for any writes that missed in the page cache, and allocate large
> >> folios only when doing readahead from storage into page cache. The test that is
> >> regressing is doing writes.
> > 
> > mmap() faults also use readahead.
> > 
> > filemap_fault():
> > 
> >         folio = filemap_get_folio(mapping, index);
> >         if (likely(!IS_ERR(folio))) {
> >                 if (!(vmf->flags & FAULT_FLAG_TRIED))
> >                         fpin = do_async_mmap_readahead(vmf, folio);
> > which does:
> >         if (folio_test_readahead(folio)) {
> >                 fpin = maybe_unlock_mmap_for_io(vmf, fpin);
> >                 page_cache_async_ra(&ractl, folio, ra->ra_pages);
> > 
> > which has been there in one form or another since 2007 (3ea89ee86a82).
> 
> OK sounds like I'm probably misremembering something I read on LWN... You're
> saying that its been the case for a while that if we take a write fault for a
> portion of a file, then we will still end up taking the readahead path and
> allocating a large folio (filesystem permitting)? Does that apply in the case
> where the file has never been touched but only ftruncate'd, as is happening in
> this test? There is obviously no need for IO in that case, but have we always
> taken a path where a large folio may be allocated for it? I thought that bit was
> newer for some reason.

The pagecache doesn't know whether the file contains data or holes.
It allocates folios and then invites the filesystem to fill them; the
filesystem checks its data structures and then either issues reads if
there's data on media or calls memset if the records indicate there's
a hole.

Whether it chooses to allocate large folios or not is going to depend
on the access pattern; a sequential write pattern will use large folios
and a random write pattern won't.

Now, I've oversimplified things a bit by talking about filemap_fault.
Before we call filemap_fault, we call filemap_map_pages() which looks
for any suitable folios in the page cache between start and end, and
maps those.

