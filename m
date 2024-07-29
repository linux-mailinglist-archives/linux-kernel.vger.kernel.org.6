Return-Path: <linux-kernel+bounces-265780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EC293F5DC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81EC328181A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF451494AB;
	Mon, 29 Jul 2024 12:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lUc196LX"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFEB146D6D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 12:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722257368; cv=none; b=ft7zRnDm60LFgAtXTkewNSdWH3ye4n18tAJp2zbbL8oqyEsSZtR+VvpNzi1KGZ/6i531dbo1AZu+GZDyGQDDJJHw7kNEFQ+3K9MlMY68clmIqZzvQR+N3tpgqShiYbhSrAecG3gGu/IMYi4bpl60GPrccQdX8meAVqeFtJuP0IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722257368; c=relaxed/simple;
	bh=85sy6IJHbWGRtad0MPENG91FKTJ/cs0GZq95rzXvfFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHNenktTHkYUDJCmF4z1hD7vWNOXJXkBBeSmPpYsZe9L8EL+CK/s/AzCyX52nh7/Kkv4Bc1zEDDOCNFSFFSTovoiQpAAfq6y84KHN383LiqjerZPtEIRxBEBfCRG/HZKCOqKct4kMjGcjOpLL7vXVTH/muAlUzHxlhqKTpdErRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lUc196LX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=CUzNSkVbhIag+ard2YVZr+G/AEzI8BDb93+haUOAT98=; b=lUc196LXunlWJ4AfCO67OE6fV7
	vf7RXnhgZgRE7fvZd2UMv6CZJl8ENONI4uSfWeh6iTFZtz/97IhMtY2qBM/+309g6m0Xw4dHuGk6z
	FMTivIWUyTdj3YfxR6WNhRodxpJqtmekVz4TXovyT/j30VFBWZfQ0u9I4iEs1xsp5jiEHqao9li5L
	RvxqIMT9xPIXofLq3vejO2ztPFj7Cp1HKdHjaVUj394COCBAZkCYrwuENhgFtjDRpF4QLxrbXzn1x
	kyCJYD6TzXR8nzh70Et0lDHMOP8wRdDG/dEIX6wi+G8leSjE/77Zi3z3WRvUnX4417vO7ETBdwNMg
	aedL0Ryg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYPoI-0000000DZYp-1mMx;
	Mon, 29 Jul 2024 12:49:06 +0000
Date: Mon, 29 Jul 2024 13:49:06 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, ying.huang@intel.com,
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
Message-ID: <ZqePwtX4b18wiubO@casper.infradead.org>
References: <20240726094618.401593-1-21cnbao@gmail.com>
 <20240726094618.401593-4-21cnbao@gmail.com>
 <ZqcRqxGaJsAwZD3C@casper.infradead.org>
 <CAGsJ_4xQkPtw1Cw=2mcRjpTdp-c9tSFCuW_U6JKzJ3zHGYQWrA@mail.gmail.com>
 <CAGsJ_4wxUZAysyg3cCVnHhOFt5SbyAMUfq3tJcX-Wb6D4BiBhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4wxUZAysyg3cCVnHhOFt5SbyAMUfq3tJcX-Wb6D4BiBhA@mail.gmail.com>

On Mon, Jul 29, 2024 at 04:46:42PM +1200, Barry Song wrote:
> On Mon, Jul 29, 2024 at 4:41 PM Barry Song <21cnbao@gmail.com> wrote:
> >
> > On Mon, Jul 29, 2024 at 3:51 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Fri, Jul 26, 2024 at 09:46:17PM +1200, Barry Song wrote:
> > > > -                     folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
> > > > -                                             vma, vmf->address, false);
> > > > +                     folio = alloc_swap_folio(vmf);
> > > >                       page = &folio->page;
> > >
> > > This is no longer correct.  You need to set 'page' to the precise page
> > > that is being faulted rather than the first page of the folio.  It was
> > > fine before because it always allocated a single-page folio, but now it
> > > must use folio_page() or folio_file_page() (whichever has the correct
> > > semantics for you).
> > >
> > > Also you need to fix your test suite to notice this bug.  I suggest
> > > doing that first so that you know whether you've got the calculation
> > > correct.
> >
> > I don't understand why the code is designed in the way the page
> > is the first page of this folio. Otherwise, we need lots of changes
> > later while mapping the folio in ptes and rmap.

What?

        folio = swap_cache_get_folio(entry, vma, vmf->address);
        if (folio)
                page = folio_file_page(folio, swp_offset(entry));

page is the precise page, not the first page of the folio.

> For both accessing large folios in the swapcache and allocating
> new large folios, the page points to the first page of the folio. we
> are mapping the whole folio not the specific page.

But what address are we mapping the whole folio at?

> for swapcache cases, you can find the same thing here,
> 
>         if (folio_test_large(folio) && folio_test_swapcache(folio)) {
>                 ...
>                 entry = folio->swap;
>                 page = &folio->page;
>         }

Yes, but you missed some important lines from your quote:

                page_idx = idx;
                address = folio_start;
                ptep = folio_ptep;
                nr_pages = nr;

We deliberate adjust the address so that, yes, we're mapping the entire
folio, but we're mapping it at an address that means that the page we
actually faulted on ends up at the address that we faulted on.

