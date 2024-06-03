Return-Path: <linux-kernel+bounces-199333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C128D85B2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11985B211C7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D2BB65F;
	Mon,  3 Jun 2024 15:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kZVXbNpf"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B9A391
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 15:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717426900; cv=none; b=Rgst7ZhReGXz/7h9hEurE91ENjq/wuo7wRb5YuNJBbm0zGZ2eMGGONovQrx1N8Cm/XRGEef0+lj7GFBWz286VYCCUEHf7wKhPJpHazbJJ8NE1SGkxVqr6GNgXL3kI96h6UfUHG07W9lZ+WUuC6ta0H8UGoZ/fwMpCi3bLxfV7tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717426900; c=relaxed/simple;
	bh=8o10VpHMrb1mtP+6cygme2pqxmERvzP68d8JCGUocbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YK375gTLz1c4bmcAAEznphbzdaH6/qDEiO2WMuZzHGlLaZbb69BA6tNiRlOHN9qiKqjR4mjI1mJ8JBOoZxKI76IEaWzzYiyE/ddcMskd5CNTbx01PxmB1fwVpJp/XQNkWYqdAVPr2s33CMMSUJc9IUIleuLHcrnMuSy5ZAUy70g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kZVXbNpf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wXyQsZpNIhV7YfkPDWeQ10552Fsy3kdrNbaiTAeqreE=; b=kZVXbNpfrIWVe/sMZLELAg9RMI
	zbp4TEZgUmVC4nfTsBuoWEmpQmUMNOg7sHzerT9ctiS+ySXgcKrJtp18J0Z+mX6+AnuOPkayDeAbf
	smp+4SqbbrILcY+mtGqfOX5fNekzEiqVoUmTB1VEIuIaKcVJFhVvOBbQsRGZYS++1LWSHzXPBHCRB
	CFwd0+SD0LjFqO4gXQOpzOgjpW8ig3CfPFm62KCXiaiBRECs8KfUgD9hQOWUW+jrvD9GmK+rVriV7
	pz4u9ifYXvU9bHAn9EsOKYnbYDHBVJNp6VmxKWGiId39Sj0VJxDuMxJ+vJD8Hy5kW+Q4fp8OJEXEn
	1yRSLitA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE9Bd-0000000EB68-1GVJ;
	Mon, 03 Jun 2024 15:01:25 +0000
Date: Mon, 3 Jun 2024 16:01:25 +0100
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org,
	ryan.roberts@arm.com, 21cnbao@gmail.com,
	baolin.wang@linux.alibaba.com, ziy@nvidia.com,
	fengwei.yin@intel.com, ying.huang@intel.com, libang.li@antgroup.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] mm/mlock: implement folio_mlock_step() using
 folio_pte_batch()
Message-ID: <Zl3axbhcljTg_X0C@casper.infradead.org>
References: <20240603140745.83880-1-ioworker0@gmail.com>
 <Zl3Wjh9_aGY8Xxm7@casper.infradead.org>
 <c0309ab6-8bae-42b7-8d27-1df895689fb8@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0309ab6-8bae-42b7-8d27-1df895689fb8@redhat.com>

On Mon, Jun 03, 2024 at 04:56:05PM +0200, David Hildenbrand wrote:
> On 03.06.24 16:43, Matthew Wilcox wrote:
> > On Mon, Jun 03, 2024 at 10:07:45PM +0800, Lance Yang wrote:
> > > +++ b/mm/mlock.c
> > > @@ -307,26 +307,15 @@ void munlock_folio(struct folio *folio)
> > >   static inline unsigned int folio_mlock_step(struct folio *folio,
> > >   		pte_t *pte, unsigned long addr, unsigned long end)
> > >   {
> > > -	unsigned int count, i, nr = folio_nr_pages(folio);
> > > -	unsigned long pfn = folio_pfn(folio);
> > > +	const fpb_t fpb_flags = FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
> > > +	unsigned int count = (end - addr) >> PAGE_SHIFT;
> > 
> > This is a pre-existing bug, but ... what happens if you're on a 64-bit
> > system and you mlock() a range that is exactly 2^44 bytes?  Seems to me
> > that count becomes 0.  Why not use an unsigned long here and avoid the
> > problem entirely?
> > 
> > folio_pte_batch() also needs to take an unsigned long max_nr in that
> > case, because you aren't restricting it to folio_nr_pages().
> 
> Yeah, likely we should also take a look at other folio_pte_batch() users
> like copy_present_ptes() that pass the count as an int. Nothing should
> really be broken, but we might not batch as much as we could, which is
> unfortunate.

You did include:

        VM_WARN_ON_FOLIO(!folio_test_large(folio) || max_nr < 1, folio);

so at the least we have a userspace-triggerable warning.

