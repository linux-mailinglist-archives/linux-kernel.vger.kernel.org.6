Return-Path: <linux-kernel+bounces-210396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0108904319
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A9B81F243D4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2375471B30;
	Tue, 11 Jun 2024 18:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bmniwLSp"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40FD482D7
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 18:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718129014; cv=none; b=QriPedAFEZvjaKWsvHZkkUgMEhzdt6UfWn+hsUSkmjQGndRbgYHfioZnI9ReKQDU1zXlK57Tf8JKennow9RVzIb4UxoRYEnUPpKZWGnbJTBcCbXq4WI3MjMkO+ma4GCWr2WsGexOK/sP7iykGkVswF8hmuBQ/4xfCZ88/CQArzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718129014; c=relaxed/simple;
	bh=IHVC82MbvcFJnblh+nTRI+KDvlao5m55Q/mjLrrzV5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWXDy+7BJlHdwBKZlDuVhp0v6Oxf56o88bRJA+5f4bdWCEt+HAKU/ll0tHjQAR5izK2mvNlS4aq744HE1MeP+qC9Gx7KsZ8bIGs3Ru7rXksuHRU1o6XbR1YcJ80UFi5bhnzfpZLJUGlrPbKbaGm9B+Cppah0ZeoB39dfHamygYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bmniwLSp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EKRPx/5e30QjM78Bp1bs9Bf04T9QRk5msSWXRd/SGY0=; b=bmniwLSpk47muRNBaDHHzaTMK0
	Sq+X8xA30x+fVqgNsGDqgNOEBFOTLyhPhIqv+84sMGfGJmrOQ+Ius4DsC2apeHZRpdQvQtR4Q3UOF
	DggiNGkLMkT65LpGQDrFmVEeXmKNcVz2RbnMEVS9Jq7tp2THQQVGE8aig9XSZTuOlSj+BefdOtg54
	UO7ql7VmxZoyeAxOKsoQvpmWX2UdbsJ0X3mS4oA1GaBktmdVayCS+jsMD05pSlKvvg+k3E026zoEe
	40wJqV8jIvOaENmVZmG3pCchqEKddxuE+1IbLuGLnVyhRajwg+0SBHGOxM6aIqxoUp9dWfMsrYcBh
	UNttY9Vg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH5qD-0000000Dvws-0d0l;
	Tue, 11 Jun 2024 18:03:29 +0000
Date: Tue, 11 Jun 2024 19:03:29 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Bresticker <abrestic@rivosinc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/memory: Don't require head page for do_set_pmd()
Message-ID: <ZmiRcUYxrZ5NQQX8@casper.infradead.org>
References: <20240611153216.2794513-1-abrestic@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611153216.2794513-1-abrestic@rivosinc.com>

On Tue, Jun 11, 2024 at 08:32:16AM -0700, Andrew Bresticker wrote:
> -	if (page != &folio->page || folio_order(folio) != HPAGE_PMD_ORDER)
> +	if (folio_order(folio) != HPAGE_PMD_ORDER)
>  		return ret;
> +	page = &folio->page;

This works today, but in about six months time it's going to be a pain.

+	page = folio_page(folio, 0);

is the one which works today and in the future.

Of course, as I'm writing this now I'm thinking we could make this work
for folios which are larger than PMD size.  Which we currently prohibit
(at least in part because this function doesn't work with folios larger
than PMD size)

	pgoff_t idx = ((haddr - vma->vm_start) / PAGE_SIZE) + vma->vm_pgoff;
	page = folio_file_page(folio, idx);

(there might be a more succinct way to write that, and I might have
messed up the polarity on something).

Worth starting to fix these places that don't work with folios larger
than PMD size?  I think it'd be worth supporting, eg 4MB folios.

Current bandwidth of a gen5 x8 link is 32GB/s, so we can read 8,000
4MB pages/second at a latency of 125us.  My laptop only has a gen4 x2
SSD, so a 4MB folio would take 1ms to read which might be a little
excessive for normal use.  Of course allocating an order 10 folio is
hard, so it's not going to happen terribly often anyway.

