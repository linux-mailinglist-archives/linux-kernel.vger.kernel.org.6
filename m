Return-Path: <linux-kernel+bounces-210449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAAE9043CA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92F53287DCA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204145731B;
	Tue, 11 Jun 2024 18:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XjLISa1L"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD91C14A96
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 18:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718131103; cv=none; b=R3nNV5Jz6rdR9UYKRmyZec6JrA+yucyNs1JwxPA8lIpQXWWpb3vfn/fXn+JVm1y0G8n61An66Gv6RKEmbnX4FEFm295On7ZXd/ORyWU+wFLvMpCiN1GYcB9vjGQtJJGzso/zQ6iw/F9oTRRbmmvWcX2hu5JDMATBiQd2mmpXgmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718131103; c=relaxed/simple;
	bh=nfvRHoWp/rIu9lvl3GRugnjsTVVcJGUzIvVMQ8fMiCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwgKQcX6qZsePrcGio8VlxuKxDS6jrfucI3nho4YqZspD5tSF39YeYAHb9k5WRZGvX3ERbQan1pNQTdqfTKFrUhUWvOQsrL9hDZ78UdrfoL3dzG2fIIWerpgZZUxfACc/tLALc2+2jDG+r2sIDSEdclVHtueBHLuZ7fc0/5aB1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XjLISa1L; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=83fNU0MNwSzqwgtODf62MkYz4vEm6mlTKKVUN+RH0+A=; b=XjLISa1LThAiAx3lUDwhs3Ss3i
	dWlWf1j4YKPl/1/MwvgyjN2tlFh57JMkYEVGByLyMU+FMPDv/xP2ojwcLogbVFg1D7d5S1MQDkfSN
	rE65RHZJQLOl6O/ClYDW/aUpdLddEoxbKb4w2KmRwWIEItNu81LTESRbGSx2Fxdswa/Yaahxym1wF
	mKL5TqAyTcnmdOtTXyEkq9X58TY/+lCM/kyu91vzcsVmlptpG1yZSrVKem9MPLZ+ifhmekTxJ7x5D
	nydnevREER8UpdqARMQgIElDAlwFMEsJ/b5VDczG4OznOJ9sCZOx09EFxDOgKYEKS3wfwU9X9M9VN
	iQXg1eug==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH6Nu-0000000DxX4-0IGK;
	Tue, 11 Jun 2024 18:38:18 +0000
Date: Tue, 11 Jun 2024 19:38:17 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrew Bresticker <abrestic@rivosinc.com>,
	David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/memory: Don't require head page for do_set_pmd()
Message-ID: <ZmiZmX_yR4wDHR1h@casper.infradead.org>
References: <20240611153216.2794513-1-abrestic@rivosinc.com>
 <ZmiRcUYxrZ5NQQX8@casper.infradead.org>
 <20240611112131.25925b8ee5198668b88de35f@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611112131.25925b8ee5198668b88de35f@linux-foundation.org>

On Tue, Jun 11, 2024 at 11:21:31AM -0700, Andrew Morton wrote:
> On Tue, 11 Jun 2024 19:03:29 +0100 Matthew Wilcox <willy@infradead.org> wrote:
> 
> > On Tue, Jun 11, 2024 at 08:32:16AM -0700, Andrew Bresticker wrote:
> > > -	if (page != &folio->page || folio_order(folio) != HPAGE_PMD_ORDER)
> > > +	if (folio_order(folio) != HPAGE_PMD_ORDER)
> > >  		return ret;
> > > +	page = &folio->page;
> > 
> > This works today, but in about six months time it's going to be a pain.
> > 
> > +	page = folio_page(folio, 0);
> > 
> > is the one which works today and in the future.
> 
> I was wondering about that.
> 
> hp2:/usr/src/25> fgrep "&folio->page" mm/*.c | wc -l
> 84
> hp2:/usr/src/25> fgrep "folio_page(" mm/*.c | wc -l 
> 35
> 
> Should these all be converted?  What's the general rule here?

The rule is ...

 - If we haven't thought about it, use &folio->page to indicate that
   somebody needs to think about it.
 - If the code needs to be modified to split folio and page apart, use
   &folio->page.
 - If the code is part of compat code which is going to have to be
   removed, use &folio->page (eg do_read_cache_page()).

To *think* about it, and use folio_page() or folio_file_page(), don't
just blindly pass 0 as the second argument.  Think about which page
within the folio is expected by the function you're working on.
Often that is "the first one!" and so folio_page(folio, 0) is the
right answer.  But that should be justified.

It might be the right answer is "Oh, that function should take a folio".

