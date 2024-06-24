Return-Path: <linux-kernel+bounces-227839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2A791571D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 21:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC72E1C22209
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F161A00F5;
	Mon, 24 Jun 2024 19:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O5Z1R62R"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D3D3A1A8;
	Mon, 24 Jun 2024 19:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719257213; cv=none; b=t3l+Ncj0xfDMO3x5fGP3JusIFHei3Tt3D1rZH58KGs5hQhalxDwtHww0lUQyAAxzVIyHNY7lQ39HQ6FXlsm00Pg2O/JQZP1uGbbP1CE/D/354RuL4HU9jvovWGwaqkHA9YdQ3zUHg/RhGGLtPJYqO5cLEVHg231qas5GyWXI9oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719257213; c=relaxed/simple;
	bh=hgp34vR7CJ1TExcCjyfAzGRk69I6tcnwK5xq7DVAkz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhTnNyFe6Mew6lt9uLzQrok2HNvEFFtqD203Rf97HPejHu8Uaj1l9n7Ul54zGMO1KgpL6UTpqV27mKzxsoWjIs5q4fBflpIXInL7k5/HwzLRfgtr4atVz4clSKyL23eJxoqp6FSWOXVNofKrCVV94lNDmyjQRVj1LtVwLDpafdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=O5Z1R62R; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=2ze4lo7T22dkN683PR4LGCHaCsLSG6Pgxy5Fyl8OuRo=; b=O5Z1R62RnZnqiIOsEyR5avK426
	puj1m8I7kYzzPBFXfUyZZeikV/zaWA4UI5r1FCq79Fc0N/1G3t6YHmGYdzomqxXr28TjjsIzhRKpv
	YQX3XFWVJIp6tZKXO/E52rUyTprf6/TqyadRDfanXwOa/TNyQjBj4H89ZT62ZbzhRkkUJoNAR2UF8
	Vr9hq1DnRl99Mh2a0uwAfQ2+F4TJSgzqTtccGctvZ26zfdf7tZJmYT0F7fkBXvL5T7V+nnK+n1m/k
	x6EEgPBCznF3LKa9ca5Hpn669DR6d3liQGDOwC0R0sgC8lArkssAyQzcN+o/A4ax3yjkesn7EhZSu
	sICN1jbw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLpKx-0000000AN1L-2GDk;
	Mon, 24 Jun 2024 19:26:47 +0000
Date: Mon, 24 Jun 2024 20:26:47 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: kernel test robot <oliver.sang@intel.com>,
	Usama Arif <usamaarif642@gmail.com>, oe-lkp@lists.linux.dev,
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
Message-ID: <ZnnId18scFvE_a6K@casper.infradead.org>
References: <202406241651.963e3e78-oliver.sang@intel.com>
 <CAJD7tkbqHyNUzQg_Qh+-ZryrKtMzdf5RE-ndT+4iURTqEo3o6A@mail.gmail.com>
 <Znm74wW3xARhR2qN@casper.infradead.org>
 <CAJD7tkbF9NwKa4q5J0xq1oG6EkTDLz8UcbekSfP+DYfoDSqRhQ@mail.gmail.com>
 <ZnnBVBItTNWZE42u@casper.infradead.org>
 <CAJD7tkaC6d_RkhRhMpEeS1zTEtoQYw56J3LLdzD1aM9_qu-3BA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkaC6d_RkhRhMpEeS1zTEtoQYw56J3LLdzD1aM9_qu-3BA@mail.gmail.com>

On Mon, Jun 24, 2024 at 11:57:45AM -0700, Yosry Ahmed wrote:
> On Mon, Jun 24, 2024 at 11:56 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Mon, Jun 24, 2024 at 11:53:30AM -0700, Yosry Ahmed wrote:
> > > After a page is swapped out during reclaim, __remove_mapping() will
> > > call __delete_from_swap_cache() to replace the swap cache entry with a
> > > shadow entry (which is an xa_value).
> >
> > Special entries are disjoint from shadow entries.  Shadow entries have
> > the last two bits as 01 or 11 (are congruent to 1 or 3 modulo 4).
> > Special entries have values below 4096 which end in 10 (are congruent
> > to 2 modulo 4).
> 
> You are implying that we would no longer have a shadow entry for such
> zero folios, because we will be storing a special entry instead.
> Right?

umm ... maybe I have a misunderstanding here.

I'm saying that there wouldn't be a _swap_ entry here because the folio
wouldn't be stored anywhere on the swap device.  But there could be a
_shadow_ entry.  Although if the page is full of zeroes, it was probably
never referenced and doesn't really need a shadow entry.

