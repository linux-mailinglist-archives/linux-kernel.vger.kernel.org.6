Return-Path: <linux-kernel+bounces-208334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CA39023A5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C25EB1C216DC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCE5130ADA;
	Mon, 10 Jun 2024 14:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Klek4tuJ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B70613DDAD
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 14:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718028380; cv=none; b=EBVIgXEvsVFem37L2YkicmiR/rcAvyo7Dvkn9bqP/7RPE3AFRsE90GswfRkdmk8fiJLRtK16DC1mjhR160zKm4PZqDB3+xIHDnCMnXGtMkNJ4sTLcftV4OEXF+z5vndoc/eTH+7MzBZSrGJ1OhYEOq2iU4uEzTlORyRrAN+XK7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718028380; c=relaxed/simple;
	bh=480Ok3bytC96p3793TdOuHvMfnp9/IZ5Mm8iEHbt0Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AyDKvEIquNla9jz7IAMN6IfUbXWf2Tfk6+ed7tjttwE0qvw6nDO9dEyZeZXi7XncLoY7WQf1DhE5BaOyGgsorM7e1AKwWG8/IDtiKD2NzIkyYbIH+p5MV5MJ6x9Em7h4wLGt2HN8Mzu0/5/fi57wTudSkijDcf/ciHuC8HaL5EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Klek4tuJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=XUZmU5NFHw2cThK5KmxTZhU9abWr7JeIWBSXn5de1N0=; b=Klek4tuJXIVYat3MV5eYaZYv5O
	3xWMpsb32Z59b2vat9Yrx8NqSQMHZxnGRgbFFyCWc/zMSfi3boXCdWDHE6vSF3aYhfweXeGOL1CCj
	RjGL+Hlm5LB8gxXwnJ5ySI8WD1krqjrzBptQaYNO+/4DiiTUUunWyazVEIgGflsBDukALmuXGSTo+
	TvflkZwOF43kwfywtteRQ1oTJcA6+sfUDSgI83R5Zd7zWqoZJBUV1wAwEm4W71B8fSx2krQpySa8S
	HZkaAYz4WMNsoQVP1MaWDZlauPmksLvwhtrEcrkZnIrJJLYrVOVVTzL9te/fYi9NiSvszIsriNTPu
	sp1JGnyw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGfeu-00000009DiY-3Ghk;
	Mon, 10 Jun 2024 14:06:04 +0000
Date: Mon, 10 Jun 2024 15:06:04 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, david@redhat.com,
	ying.huang@intel.com, hughd@google.com, yosryahmed@google.com,
	nphamcs@gmail.com, chengming.zhou@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3 1/2] mm: store zero pages to be swapped out in a bitmap
Message-ID: <ZmcITDhdBzUGEHuY@casper.infradead.org>
References: <20240610121820.328876-1-usamaarif642@gmail.com>
 <20240610121820.328876-2-usamaarif642@gmail.com>
 <Zmb6r6vrP2UTDQrK@casper.infradead.org>
 <acb76cdb-a54e-48e0-ba18-a2272d84f0ab@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acb76cdb-a54e-48e0-ba18-a2272d84f0ab@gmail.com>

On Mon, Jun 10, 2024 at 02:56:09PM +0100, Usama Arif wrote:
> I am guessing what you are suggesting is just do this?
> 
>     if (is_folio_zero_filled(folio)) {
>         swap_zeromap_folio_set(folio);
>         folio_unlock(folio);
>         return 0;
>     }

Right.

> This is what I did initially while developing this, but when I started
> looking into why zswap_store does  folio_start_writeback, folio_unlock,
> folio_end_writeback I found:
> 
> https://elixir.bootlin.com/linux/v6.9.3/source/Documentation/filesystems/locking.rst#L336
> 
> "If no I/O is submitted, the filesystem must run end_page_writeback()
> against the page before returning from writepage."

But that's advice to filesystem authors.  File pages don't come this
way; we only put anonyous pages into swap (except tmpfs).

> If we have zswap enabled, the zero filled pages (infact any page that is
> compressed), will be saved in zswap_entry and NR_WRITTEN will be wrongly
> incremented. So the behaviour for NR_WRITTEN does not change in this patch
> when encountering zero pages with zswap enabled (even if its wrong).

We should fiz zswap too.

> In order to fix NR_WRITTEN accounting for zswap, this patch series and any
> other cases where no I/O is submitted but end_page_writeback is called
> before returning to writepage, maybe we could add an argument to
> __folio_end_writeback like below? There are a lot of calls to
> folio_end_writeback and the behaviour of zeropage with regards to NR_WRITTEN
> doesnt change with or without this patchseries with zswap enabled, so maybe
> we could keep this independent of this series? I would be happy to submit
> this as separate patch if it makes sense.

It makes no sense at all.

