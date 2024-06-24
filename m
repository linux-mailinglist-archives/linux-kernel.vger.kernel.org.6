Return-Path: <linux-kernel+bounces-227937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFFF915845
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDEFC1C22448
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1C45B1E8;
	Mon, 24 Jun 2024 20:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dWm2Km/v"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5E22E400;
	Mon, 24 Jun 2024 20:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719262300; cv=none; b=sFLfPOp5RrM0LzE4848+KHLUITy6t+wOD0KITB7KeCR+8Y+PTMtZNCcd1bWhD5wiKsJGWnYnla3nUblKMvLhZzi5yTqrilqRmYg75feiizSPHxhEYhFsaDxfR7OIzg06Fj0X4XKaj4AYrnB3oHnlRkpNDFaHyhox4gAnQ2jvnVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719262300; c=relaxed/simple;
	bh=xcXAK/+YPtgQZ8DvlbGOgscZn8PZhxgX7RdIoM4uFpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMelqV6N3EE01jZegxZ2XJRqkDdme734ItulHM5WIFmmbgQhwWZDUb94+uccKCDHqpMnIkAML59+oxR0qC3s9J6MWV9d6OV9vVD9xdphEyx5eJkWmUCOFGM93ThyD1VTV6+SF6D6ZVh2lauy/UmxIU+kfGxUQUyCYDMuaU5qeKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dWm2Km/v; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=bEGUJt2Mi8EMv5BNM/0nl9YsVj5hoU0o3ifiX8cToz8=; b=dWm2Km/vrBkAoRqfMMCAcSG8Mi
	/Om7ODTTUe8UhwCqQTtHMcIyQqKzTOev/KYejSC0w1OYV+jufL033Bg/moAfdTDUxywqVXUHPdQXC
	w6ugLbz+kBjjyPQ/3Oy0wa8H4rNI9wpjLaVT68iazFpdPlooVFf4LzbdGgVrM0RHzIUVbnTzwB9ul
	cMSuKy+sWzcEk3OFDVTP+6m8kxJ57qyHPioxOesVU8KYkG67IWbOUg+Fch295EGa2Wsu25x6s5+qH
	IOySklqrEJbXGm/pUQ+oiYQcnHlt2ptt7MU4hxsVLuhP6aayMQbFk3qNQ8Anxs2oVAV1JqFVqMNkX
	aC/48KxQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLqez-0000000AQmx-1HtP;
	Mon, 24 Jun 2024 20:51:33 +0000
Date: Mon, 24 Jun 2024 21:51:33 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Yosry Ahmed <yosryahmed@google.com>,
	kernel test robot <oliver.sang@intel.com>,
	Usama Arif <usamaarif642@gmail.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>, David Hildenbrand <david@redhat.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Hugh Dickins <hughd@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [linux-next:master] [mm] 0fa2857d23:
 WARNING:at_mm/page_alloc.c:#__alloc_pages_noprof
Message-ID: <ZnncVRuHeeN7GnTJ@casper.infradead.org>
References: <202406241651.963e3e78-oliver.sang@intel.com>
 <CAJD7tkbqHyNUzQg_Qh+-ZryrKtMzdf5RE-ndT+4iURTqEo3o6A@mail.gmail.com>
 <Znm74wW3xARhR2qN@casper.infradead.org>
 <CAJD7tkbF9NwKa4q5J0xq1oG6EkTDLz8UcbekSfP+DYfoDSqRhQ@mail.gmail.com>
 <ZnnBVBItTNWZE42u@casper.infradead.org>
 <CAJD7tkaC6d_RkhRhMpEeS1zTEtoQYw56J3LLdzD1aM9_qu-3BA@mail.gmail.com>
 <ZnnId18scFvE_a6K@casper.infradead.org>
 <CAJD7tkZZHxXR9cFE=ZHQOnYXakrhXg0+ScT2ExxihovSgDz7_g@mail.gmail.com>
 <ZnnOFSNKKMf5IpCU@casper.infradead.org>
 <fv7c4554hex6vnnujhqz2fuxob6pqlumwxudx2zgrdeovq3vf4@vaypceu5y6po>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fv7c4554hex6vnnujhqz2fuxob6pqlumwxudx2zgrdeovq3vf4@vaypceu5y6po>

On Mon, Jun 24, 2024 at 01:39:45PM -0700, Shakeel Butt wrote:
> On Mon, Jun 24, 2024 at 08:50:45PM GMT, Matthew Wilcox wrote:
> > On Mon, Jun 24, 2024 at 12:34:04PM -0700, Yosry Ahmed wrote:
> > > On Mon, Jun 24, 2024 at 12:26 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Mon, Jun 24, 2024 at 11:57:45AM -0700, Yosry Ahmed wrote:
> > > > > On Mon, Jun 24, 2024 at 11:56 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > > > >
> > > > > > On Mon, Jun 24, 2024 at 11:53:30AM -0700, Yosry Ahmed wrote:
> > > > > > > After a page is swapped out during reclaim, __remove_mapping() will
> > > > > > > call __delete_from_swap_cache() to replace the swap cache entry with a
> > > > > > > shadow entry (which is an xa_value).
> > > > > >
> > > > > > Special entries are disjoint from shadow entries.  Shadow entries have
> > > > > > the last two bits as 01 or 11 (are congruent to 1 or 3 modulo 4).
> > > > > > Special entries have values below 4096 which end in 10 (are congruent
> > > > > > to 2 modulo 4).
> > > > >
> > > > > You are implying that we would no longer have a shadow entry for such
> > > > > zero folios, because we will be storing a special entry instead.
> > > > > Right?
> > > >
> > > > umm ... maybe I have a misunderstanding here.
> > > >
> > > > I'm saying that there wouldn't be a _swap_ entry here because the folio
> > > > wouldn't be stored anywhere on the swap device.  But there could be a
> > > > _shadow_ entry.  Although if the page is full of zeroes, it was probably
> > > > never referenced and doesn't really need a shadow entry.
> > > 
> > > Is it possible to have a shadow entry AND a special entry (e.g.
> > > XA_ZERO_ENTRY) at the same index? This is what would be required to
> > > maintain the current behavior (assuming we really need the shadow
> > > entries for such zeroed folios).
> > 
> > No, just like it's not possible to have a swap entry and a shadow entry
> > at the same location.  You have to choose.  But the zero entry is an
> > alternative to the swap entry, not the shadow entry.
> > 
> > As I understand the swap cache, at the moment, you can have four
> > possible results from a lookup:
> > 
> >  - NULL
> >  - a swap entry
> >  - a shadow entry
> >  - a folio
> > 
> > Do I have that wrong?
> 
> I don't think we have swap entry in the swapcache (underlying xarray).
> The swap entry is used as an index to find the folio or shadow entry.

Ah.  I think I understand the procedure now.

We store a swap entry in the page table entry.  That tells us both where
in the swap cache the folio might be found, and where in the swap device
the data can be found (because there is a very simple calculation for
both).  If the folio is not present, then there's a shadow entry which
summarises the LRU information that would be stored in the folio had it
not been evicted from the swapcache.

We can't know at the point where we unmap the page whether it's full
of zeroes or not, because we can't afford to scan its contents.  At the
point where we decide to swap out the folio, we can afford to make that
decision because the cost of doing the I/O is high enough.

So the question is whether we can afford to throw away the shadow
information and just store the information that this was a zero entry.
I think we can, but it is a more bold proposal than I realised I was
making.

