Return-Path: <linux-kernel+bounces-447920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DF19F3893
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19B1A16D51C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A42207E02;
	Mon, 16 Dec 2024 18:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RbDgqQhO"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6560C206F2A
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 18:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734372761; cv=none; b=nSZjKAZFw8n0w4mphrhf+UFv6/civ06xbP0QKSQMtdtmAbwl4EEuQOXiy3T5OR0GP73dBPm2lbVC2drJ6oPBSlD6L0hPIWuoNnXdnXWqeAaQnsReXl07uSMWMUZz95K9qo/tLf+R3gA+f1g/iiNZkOftfkh6ywFjWXx/ou8RO9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734372761; c=relaxed/simple;
	bh=yY1yrK+N26VVl0t557Xt75LNeVQRHDNplKud+houM2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOeA8r9QsEbfa1B4BaMRmmhtpnrjF5PnI6a8Pj17nzqchJ0xwJnzzf/aphFJG7j1/whsvGqlCnrjzoQ+2VtkuQgUEmqTPDOE5HT5djptuCS+wV/AbSQiNzeFuE2vb+xfsNTTiHhlYjn04ZMUVCcr9R97B4zs/Zp946SX9y1asSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RbDgqQhO; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dFpvSUWFeW3zR72pUQLwloomfFaQnTy1YdSxpYqv4Vk=; b=RbDgqQhOfL2hVF8rgIkkTvqvuv
	t6Vem3NMUmy8fAODof7J2j8Z6Z8fQ4gknaSC0Fny4PqOYwhehmMiT3G2V6Mqb53q4QhKsQWX8H9dV
	lALF8ojtyB842+z1akKWFrcjO5StlahY1TAi/ysdRiCDMKAuxrxicAiw1htikifXldHPKRhGxZFLz
	yoBiIO0zm726l62HEWO3SZxDVGsgucBmsxjqjB+CmYoY4cmtQYGwP8t08urqi1Zc4H8dGAdANRV1f
	uvgjGli2pLtDcL116wQi+pdRVfSYHYIZgf7VK7IFRxAUpO8z2BscPLLfGxPr8o4tpOdJrlI73s0Kd
	Y8ZfHz5A==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNFZy-00000004vB6-0fQn;
	Mon, 16 Dec 2024 18:12:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5709E30031E; Mon, 16 Dec 2024 19:12:25 +0100 (CET)
Date: Mon, 16 Dec 2024 19:12:25 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: tglx@linutronix.de, david@redhat.com, jannh@google.com,
	hughd@google.com, yuzhao@google.com, willy@infradead.org,
	muchun.song@linux.dev, vbabka@kernel.org,
	lorenzo.stoakes@oracle.com, akpm@linux-foundation.org,
	rientjes@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] mm: pgtable: introduce generic __tlb_remove_table()
Message-ID: <20241216181225.GB11133@noisy.programming.kicks-ass.net>
References: <cover.1734164094.git.zhengqi.arch@bytedance.com>
 <271e58cd4ab808c4f402539b76d5916924e2bc6f.1734164094.git.zhengqi.arch@bytedance.com>
 <20241216120043.GA11133@noisy.programming.kicks-ass.net>
 <efc3f9c9-5040-44c1-82dd-59361281336c@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efc3f9c9-5040-44c1-82dd-59361281336c@bytedance.com>

On Mon, Dec 16, 2024 at 08:52:06PM +0800, Qi Zheng wrote:
> 
> 
> On 2024/12/16 20:00, Peter Zijlstra wrote:
> > On Sat, Dec 14, 2024 at 05:02:57PM +0800, Qi Zheng wrote:
> 
> [...]
> 
> > > +#ifndef __HAVE_ARCH_TLB_REMOVE_TABLE
> > > +static inline void __tlb_remove_table(void *_table)
> > > +{
> > > +	struct ptdesc *ptdesc = (struct ptdesc *)_table;
> > > +
> > > +	pagetable_dtor(ptdesc);
> > > +	pagetable_free(ptdesc);
> > > +}
> > > +#endif
> > 
> > 
> > Spot the fail...
> > 
> > That said, all this ptdesc stuff is another giant trainwreck. Let me
> > clean that up for you.
> 
> It looks like you want to revert what was done in this patch series:
> 
> https://lore.kernel.org/all/20230807230513.102486-1-vishal.moola@gmail.com/
> 
> But why? It seems that splitting ptdesc from struct page is a good
> thing?

Because we're explicitly allocating pages for the page-tables, and also,
code like:

tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));

static inline void tlb_remove_page_ptdesc(struct mmu_gather *tlb, struct ptdesc *pt)
{
	tlb_remove_page(tlb, ptdesc_page(pt));
}

Just makes me upset.

Just bloody write tlb_remove_page() and call it a day.

All that nonsense is just obfuscation at this point.

