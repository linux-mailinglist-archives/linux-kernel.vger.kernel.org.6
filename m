Return-Path: <linux-kernel+bounces-203239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C318FD82A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6CE1F24BEC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 21:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D71015F3E9;
	Wed,  5 Jun 2024 21:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h4WxDr/K"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3383A4965B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 21:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717621985; cv=none; b=gQmXOlYT9TxklUCcEfmxgaCWCm4SiUKJ12/vifuhaAVHLhMFrS5AWnepnhFdZE3kOCh229Fw0tBI5ef+OMWoEsPjs8ckU6JiQn2StpVDPPhxK6cGlSJmA5uhbtxb8EaWSTnWMUE0I0T7zDkT6fnQiCakrlS3DNbmvpgTha3xepo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717621985; c=relaxed/simple;
	bh=kVVBwhOi4Etc3xbQeGCLfgKd0zzpIISgNf/sZzDmckA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZG0bsJYabU9df2dZd8GsWmSOoiNslbnAXcNLNe1Xw32l+e9JNKJSNvvAIE8aj5YMBvYnOQhvrhBJsC6f1WXOOvMIEP80h/ywpOg2pTsi9VrqUlwwXs2U9Ixwz5YV0N9SeOCEvZt1ksN+bOhj6qHj+ZirwZTpplX+0G/dv0ulO9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h4WxDr/K; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tyPAwm3M+1wVMHk+k1F92p+/vIG4V+hj4p+c1Kn8nfU=; b=h4WxDr/KHzPoTSlsJJsCtT+cv+
	h79QXhcGqTuYAp01kJh9fTZKQIYEFL+I5cNQ9bRz1b3jtHibJw4SfnKXczxJ5ThUoyOesgKKiueA5
	dgIwr/11mhmHDR0Ni44oELi+1c+IJPR176OT55zYhqKzyJa0+8ZQPdjcAB9RVV2pgYkcHSTb8TAen
	jjktNWOFeAELuaWLQZyZcdW/e1LAw7loshY2I+oxjdyuzm78flwaaTHZ0ah4OfJdPOqrmxvJuDiiu
	SZdFc8y4eAyIy21DtfM7uzbSMprsWC05e//u737zLhd9U/2g7Hp0XDGz3P76a7PhGPNKfO59N5ptd
	dHUWN33Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sExvS-00000004CDq-38ak;
	Wed, 05 Jun 2024 21:12:11 +0000
Date: Wed, 5 Jun 2024 22:12:06 +0100
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: Alex Shi <seakeel@gmail.com>, alexs@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, izik.eidus@ravellosystems.com,
	aarcange@redhat.com, chrisw@sous-sol.org, hughd@google.com
Subject: Re: [PATCH 02/10] mm/ksm: skip subpages of compound pages
Message-ID: <ZmDUpryUaVraNF6m@casper.infradead.org>
References: <20240604042454.2012091-1-alexs@kernel.org>
 <20240604042454.2012091-3-alexs@kernel.org>
 <Zl_g7qmXAJDy4vKu@casper.infradead.org>
 <5bb3bbf6-6a22-449f-96f1-b9476357f284@gmail.com>
 <8a614d01-191e-45d1-b6b6-c36ec0bd9e5a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a614d01-191e-45d1-b6b6-c36ec0bd9e5a@redhat.com>

On Wed, Jun 05, 2024 at 09:47:10AM +0200, David Hildenbrand wrote:
> On 05.06.24 08:14, Alex Shi wrote:
> > 
> > 
> > On 6/5/24 11:52 AM, Matthew Wilcox wrote:
> > > On Tue, Jun 04, 2024 at 12:24:44PM +0800, alexs@kernel.org wrote:
> > > > From: "Alex Shi (tencent)" <alexs@kernel.org>
> > > > 
> > > > When a folio isn't fit for KSM, the subpages are unlikely to be good,
> > > > So let's skip the rest page checking to save some actions.
> > > 
> > > Why would you say that is true?  We have plenty of evidence that
> > > userspace allocators can allocate large folios, then use only the first
> > > few bytes, leaving many tail pages full of zeroes.
> > 
> > Um, that do need tail pages...
> > Is there some way to use more folio in ksm?
> 
> My take, and Willy can correct me if I am wrong:
> 
> "struct page" is not going to away any time soon, but it might shrink at
> some point.
> 
> That is, we can use the "struct page" pointer to point at a page frame, and
> use "struct folio" to lookup/manage the metadata.

Right.

> That is, use "struct page" when accessing the actual memory content
> (checksum, testing for identical content), but use the folio part when
> looking up metadata (folio_test_anon() etc). In the future we might want to
> replace the "struct page" pointer by an index into the folio, but that
> doesn't have to happen right now.

My current thinking is that folio->pfn is how we know where the memory
described by the folio is.  Using an index would be memmap[folio->pfn +
index] which isn't terribly expensive, but we may as well pass around the
(folio, page) pair and save the reference to memmap.

> For KSM, that would mean that you have a folio+page (late folio+index) pair
> when possibly dealing with large folios, but you can use a folio without a
> page when dealing with KSM folios, that are always small.

Yes, agreed.

