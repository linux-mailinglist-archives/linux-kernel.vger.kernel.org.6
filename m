Return-Path: <linux-kernel+bounces-227947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A2491586E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 23:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E79F1C22583
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 21:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88551A08A6;
	Mon, 24 Jun 2024 21:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BXAPkxbo"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8B149650
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 21:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719262932; cv=none; b=OEuVDL5ELG+mJ4qmkI+qqrWP/qUqMn8+usuVWmF5r5EofpgYizJsb0SVWOhDVd3a6h5QJFiAFbqW3Z3ayNSDUxjg6feSC36uubAYXLqsbCPn00wVoXZ5Y3uL5EhcYtA8nXHvdgPst79X0j9LABj/mZVEM1rsF6V5c58I5aKCTPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719262932; c=relaxed/simple;
	bh=gq8UWYtCwgpZFbFeaTyaBqOOi/ah9Bnx1Kxv5+ZyUdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnIpRfxCU6vkFRQRnWORIURFreyCzcEGadxr/CidvWvE7KI2IZEePZA7z139upWc/EC5udEXPDyYTWlfJZdlyHFhb8AlE9qdn0qkXfbbot6tYISweOnFeotnWvpNlkikvLZvfcPcHLIR9RrDFm4nLyn4xJ3UN+I2UnnrpTVCCg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BXAPkxbo; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: willy@infradead.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719262928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LqCwlhhk7HAreetP8u9djrnWVZC/rtZIAaJkpetLXsM=;
	b=BXAPkxbovgKKMxwLwrXlUk5BSkuGi42Xt0jUCsHXIKPYHYji9CNlIWCHg862/VUg/YxcC4
	reI/TEXHcbEFvV+pYhbgL1sDy0rTy6a18eKpp7VhkKfIlTjDQzZn3yQMyneeP8WD07wfVG
	fDBUli96uxmwdiJDDhSyf9UH3aczvxM=
X-Envelope-To: yosryahmed@google.com
X-Envelope-To: oliver.sang@intel.com
X-Envelope-To: usamaarif642@gmail.com
X-Envelope-To: oe-lkp@lists.linux.dev
X-Envelope-To: lkp@intel.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: chengming.zhou@linux.dev
X-Envelope-To: nphamcs@gmail.com
X-Envelope-To: david@redhat.com
X-Envelope-To: ying.huang@intel.com
X-Envelope-To: hughd@google.com
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: ak@linux.intel.com
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Mon, 24 Jun 2024 14:02:02 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, 
	kernel test robot <oliver.sang@intel.com>, Usama Arif <usamaarif642@gmail.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Nhat Pham <nphamcs@gmail.com>, David Hildenbrand <david@redhat.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [linux-next:master] [mm] 0fa2857d23:
 WARNING:at_mm/page_alloc.c:#__alloc_pages_noprof
Message-ID: <wfsev2j7ehjsrwxacrbnokdfaozfgz7nnl56g4plcqhxgtglq3@3rwa3jbliafa>
References: <CAJD7tkbqHyNUzQg_Qh+-ZryrKtMzdf5RE-ndT+4iURTqEo3o6A@mail.gmail.com>
 <Znm74wW3xARhR2qN@casper.infradead.org>
 <CAJD7tkbF9NwKa4q5J0xq1oG6EkTDLz8UcbekSfP+DYfoDSqRhQ@mail.gmail.com>
 <ZnnBVBItTNWZE42u@casper.infradead.org>
 <CAJD7tkaC6d_RkhRhMpEeS1zTEtoQYw56J3LLdzD1aM9_qu-3BA@mail.gmail.com>
 <ZnnId18scFvE_a6K@casper.infradead.org>
 <CAJD7tkZZHxXR9cFE=ZHQOnYXakrhXg0+ScT2ExxihovSgDz7_g@mail.gmail.com>
 <ZnnOFSNKKMf5IpCU@casper.infradead.org>
 <fv7c4554hex6vnnujhqz2fuxob6pqlumwxudx2zgrdeovq3vf4@vaypceu5y6po>
 <ZnncVRuHeeN7GnTJ@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZnncVRuHeeN7GnTJ@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 24, 2024 at 09:51:33PM GMT, Matthew Wilcox wrote:
> On Mon, Jun 24, 2024 at 01:39:45PM -0700, Shakeel Butt wrote:
> > On Mon, Jun 24, 2024 at 08:50:45PM GMT, Matthew Wilcox wrote:
> > > On Mon, Jun 24, 2024 at 12:34:04PM -0700, Yosry Ahmed wrote:
> > > > On Mon, Jun 24, 2024 at 12:26 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > > >
> > > > > On Mon, Jun 24, 2024 at 11:57:45AM -0700, Yosry Ahmed wrote:
> > > > > > On Mon, Jun 24, 2024 at 11:56 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > > > > >
> > > > > > > On Mon, Jun 24, 2024 at 11:53:30AM -0700, Yosry Ahmed wrote:
> > > > > > > > After a page is swapped out during reclaim, __remove_mapping() will
> > > > > > > > call __delete_from_swap_cache() to replace the swap cache entry with a
> > > > > > > > shadow entry (which is an xa_value).
> > > > > > >
> > > > > > > Special entries are disjoint from shadow entries.  Shadow entries have
> > > > > > > the last two bits as 01 or 11 (are congruent to 1 or 3 modulo 4).
> > > > > > > Special entries have values below 4096 which end in 10 (are congruent
> > > > > > > to 2 modulo 4).
> > > > > >
> > > > > > You are implying that we would no longer have a shadow entry for such
> > > > > > zero folios, because we will be storing a special entry instead.
> > > > > > Right?
> > > > >
> > > > > umm ... maybe I have a misunderstanding here.
> > > > >
> > > > > I'm saying that there wouldn't be a _swap_ entry here because the folio
> > > > > wouldn't be stored anywhere on the swap device.  But there could be a
> > > > > _shadow_ entry.  Although if the page is full of zeroes, it was probably
> > > > > never referenced and doesn't really need a shadow entry.
> > > > 
> > > > Is it possible to have a shadow entry AND a special entry (e.g.
> > > > XA_ZERO_ENTRY) at the same index? This is what would be required to
> > > > maintain the current behavior (assuming we really need the shadow
> > > > entries for such zeroed folios).
> > > 
> > > No, just like it's not possible to have a swap entry and a shadow entry
> > > at the same location.  You have to choose.  But the zero entry is an
> > > alternative to the swap entry, not the shadow entry.
> > > 
> > > As I understand the swap cache, at the moment, you can have four
> > > possible results from a lookup:
> > > 
> > >  - NULL
> > >  - a swap entry
> > >  - a shadow entry
> > >  - a folio
> > > 
> > > Do I have that wrong?
> > 
> > I don't think we have swap entry in the swapcache (underlying xarray).
> > The swap entry is used as an index to find the folio or shadow entry.
> 
> Ah.  I think I understand the procedure now.
> 
> We store a swap entry in the page table entry.  That tells us both where
> in the swap cache the folio might be found, and where in the swap device
> the data can be found (because there is a very simple calculation for
> both).  If the folio is not present, then there's a shadow entry which
> summarises the LRU information that would be stored in the folio had it
> not been evicted from the swapcache.
> 
> We can't know at the point where we unmap the page whether it's full
> of zeroes or not, because we can't afford to scan its contents.  At the
> point where we decide to swap out the folio, we can afford to make that
> decision because the cost of doing the I/O is high enough.
> 
> So the question is whether we can afford to throw away the shadow
> information and just store the information that this was a zero entry.
> I think we can, but it is a more bold proposal than I realised I was
> making.

I agree that we can throw away shadow in the favor of zero entry but, as
you already noted, it requires changes at mutiple places. At the moment
I can think of:

1. Zero entry is not reclaimable like shadow entry.
2. Need to decide the right place to allocate the zero folio on swapin.
3. Should this be treated as major fault for stats purpose.

Definitely I have missed more points as well.

