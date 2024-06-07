Return-Path: <linux-kernel+bounces-206445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6C29009D6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 18:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 468DD1F24DBB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 16:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936AB199E9A;
	Fri,  7 Jun 2024 16:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ty0t64Zd"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2628C168DE
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 16:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717776130; cv=none; b=p7f8DJpmPNBMXKZPsj2DOzvM6j020xTxBwt+Q27Uam75XEuVCBzi1d0BMOicA4MvdbY8WT6fhFSl2e13ycKE0ChBRFRz/sIn8k4xSwo9zpFb5I5SW9xtK6WuutfxBJ3eIjAB1ZMmo/fh0gduLIzp01Pqyb8Rhv4QG3od/u/TrP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717776130; c=relaxed/simple;
	bh=Z+9m/qleTaeVNnE9xwb25COrIGPFFrhTCVuB+fYOh/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHNkA7Cgz8RZz5ceFB7iQT5twItCQCTaabMtP6GKLCAlgL7gebCFoPF95zihGuxjgO5NzKDi782TOLblQJi88w2UEdUt7jWshGvYvXmnyz9v4F7FJs5/MTu+e0QNzCL1kUteNb2ElokXrWD4Fo/ANhlGyAyl2HA6nGFIo+A3dzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ty0t64Zd; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eCTR4eCQnyDJGr3WoiKlq3Zd4xvRFUfx0w1DxTE2FHk=; b=ty0t64Zdm+td/YOTBVUkZPDwzU
	M7TU31sGn1m9AbG7scYTTj89O6P47eFre0P1XyqEm1C4Uo7n5uq5f4jv+JZtgn3MGp6+til+mO9cz
	XG414ub1uno8xMDJcLQIgIOTLNxklDaaW3397qu3Q9rSYpGbJCPlhh6DtuxCG0+HUGTY3s0POD5nQ
	8KJ2FF4ZNboZsDXFiymYpaXNhDNp9z17dHfYwWdOADhqCK+FVLzyjeUxpTss022hzyHfqHKOgiPfs
	jU4Rs/tDvhRSnntiOTDPcc3DiWkr5K0CviCLv93oiheSC1SGJ61AbJFC5FaVGOzIhhBo+C7cj0mBw
	SPg7c1Gw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFc2Z-00000006NPs-02yC;
	Fri, 07 Jun 2024 16:02:07 +0000
Date: Fri, 7 Jun 2024 17:02:06 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: get rid of buffer_head use
Message-ID: <ZmMu_tnbqZtGJCsE@casper.infradead.org>
References: <20240607101829.389015-1-chao@kernel.org>
 <ZmMMDy9eeCU2igqj@casper.infradead.org>
 <e56b6166-1bb4-411a-a701-51bf452d2369@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e56b6166-1bb4-411a-a701-51bf452d2369@kernel.org>

On Fri, Jun 07, 2024 at 10:10:52PM +0800, Chao Yu wrote:
> On 2024/6/7 21:33, Matthew Wilcox wrote:
> > On Fri, Jun 07, 2024 at 06:18:29PM +0800, Chao Yu wrote:
> > > @@ -1990,6 +1989,12 @@ static inline struct f2fs_super_block *F2FS_RAW_SUPER(struct f2fs_sb_info *sbi)
> > >   	return (struct f2fs_super_block *)(sbi->raw_super);
> > >   }
> > > +static inline struct f2fs_super_block *F2FS_SUPER_BLOCK(struct folio *folio)
> > > +{
> > > +	return (struct f2fs_super_block *)(page_address(folio_page(folio, 0)) +
> > > +							F2FS_SUPER_OFFSET);
> > > +}
> > 
> > This assumes that the superblock is in the first page of the folio.
> > That's not necessarily guaranteed; let's say you have a 64KiB folio
> > that covers the start of the bdev.
> 
> Oh, I missed to add large folio support in this version.
> 
> For the case: page size is 4KiB, and folio size is 64KiB,
> read_mapping_folio(mapping, 0, NULL) and read_mapping_folio(mapping,
> 1, NULL) will return the same #0 folio, right?

That's right.  If you want to pass a page into F2FS_SUPER_BLOCK, that
would be fine.  Assuming you're not trying to support fs blocksize !=
PAGE_SIZE.


