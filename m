Return-Path: <linux-kernel+bounces-265786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2558A93F5EE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48EF1F230DC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793881494AB;
	Mon, 29 Jul 2024 12:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z3h2O27S"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC3F1442FB
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 12:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722257740; cv=none; b=oEqp7OQgTRuAkzW6XjJHa14YIm5GNSTHC4o2UN0yIyuwyV9l3ymou0hBor3EzUYFXM0v1+Yyh+jdIMRrD4P0HQcuwHVZoZse3YcQuIRG5L0IOBb9OCUGvUB3dv7wpdkaMJbDUPa2ojJ6+kXpmuKdkfojGTBz1H/ZqiracmJHPaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722257740; c=relaxed/simple;
	bh=ApFBGEKrXGZ5wlAkBjBHyCnfi54MpPWXk2MQoc3J3CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOxDpHEHIDLhlQkaQ9LKYzoh/PAAAQvterCwr9m2C1/VR/ZOwwat5XjX/RUFHh7PPWD4dJNbZZvNwTITAEvC6kA9tqNcntcfxCRsz7HuXA6hYRlGLHtLFJk/vM9CZDJuMRLZrDDyMcn7iKy/GOrlyWAnirPXfhCWC5ztXlC+et0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Z3h2O27S; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=opEWLaRlUPPuTcVF9JQV5B1iYQkixzeRREUKAI6824o=; b=Z3h2O27S0fXUvOG/m2g3CSn1iQ
	s0wXWD8/fD7spO399wDArSxC8+8WM2vk15vnvNiBv6IiUUHSBr7j1wOgH+gyZYk1O+oITdb2j7yeA
	Rb+Qu/d73aXY3LXHhGv+RKBJV6HVpjKUWVS/8k4EnXlbPw4tY5Jo063WyHGZJL/FFDOf5xZqWnU+r
	+1ZyDxJgj72Vr/WDgoM2E4Ek4HaXRc8cORZs/E6UJ91+7it71Y2soJiZtzYpZ6wz1DB/qx7BZxCrd
	H5deqH4KLMRAd6hUqLr5AEhf09bFQHflG8wdayykkjv2OexzpdKaziehGEe5AacQzrxzvgO/7HZlS
	aicELm1w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYPuN-0000000DZnp-1691;
	Mon, 29 Jul 2024 12:55:23 +0000
Date: Mon, 29 Jul 2024 13:55:23 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Chuanhua Han <chuanhuahan@gmail.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, ying.huang@intel.com,
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com,
	hannes@cmpxchg.org, hughd@google.com, kaleshsingh@google.com,
	kasong@tencent.com, linux-kernel@vger.kernel.org, mhocko@suse.com,
	minchan@kernel.org, nphamcs@gmail.com, ryan.roberts@arm.com,
	senozhatsky@chromium.org, shakeel.butt@linux.dev,
	shy828301@gmail.com, surenb@google.com, v-songbaohua@oppo.com,
	xiang@kernel.org, yosryahmed@google.com,
	Chuanhua Han <hanchuanhua@oppo.com>
Subject: Re: [PATCH v5 3/4] mm: support large folios swapin as a whole for
 zRAM-like swapfile
Message-ID: <ZqeRO9gedIPcbm3E@casper.infradead.org>
References: <20240726094618.401593-1-21cnbao@gmail.com>
 <20240726094618.401593-4-21cnbao@gmail.com>
 <ZqcRqxGaJsAwZD3C@casper.infradead.org>
 <CANzGp4J3et+yo8v8iDngvAb3nrn-gSDh0_j0=65OEiw9jKJbPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANzGp4J3et+yo8v8iDngvAb3nrn-gSDh0_j0=65OEiw9jKJbPQ@mail.gmail.com>

On Mon, Jul 29, 2024 at 02:36:38PM +0800, Chuanhua Han wrote:
> Matthew Wilcox <willy@infradead.org> 于2024年7月29日周一 11:51写道：
> >
> > On Fri, Jul 26, 2024 at 09:46:17PM +1200, Barry Song wrote:
> > > -                     folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
> > > -                                             vma, vmf->address, false);
> > > +                     folio = alloc_swap_folio(vmf);
> > >                       page = &folio->page;
> >
> > This is no longer correct.  You need to set 'page' to the precise page
> > that is being faulted rather than the first page of the folio.  It was
> > fine before because it always allocated a single-page folio, but now it
> > must use folio_page() or folio_file_page() (whichever has the correct
> > semantics for you).
> >
> > Also you need to fix your test suite to notice this bug.  I suggest
> > doing that first so that you know whether you've got the calculation
> > correct.
> 
> >
> >
> This is no problem now, we support large folios swapin as a whole, so
> the head page is used here instead of the page that is being faulted.
> You can also refer to the current code context, now support large
> folios swapin as a whole, and previously only support small page
> swapin is not the same.

You have completely failed to understand the problem.  Let's try it this
way:

We take a page fault at address 0x123456789000.
If part of a 16KiB folio, that's page 1 of the folio at 0x123456788000.
If you now map page 0 of the folio at 0x123456789000, you've
given the user the wrong page!  That looks like data corruption.

The code in
        if (folio_test_large(folio) && folio_test_swapcache(folio)) {
as Barry pointed out will save you -- but what if those conditions fail?
What if the mmap has been mremap()ed and the folio now crosses a PMD
boundary?  mk_pte() will now be called on the wrong page.

