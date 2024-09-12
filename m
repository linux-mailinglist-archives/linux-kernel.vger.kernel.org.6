Return-Path: <linux-kernel+bounces-327085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F96C9770D9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 20:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C41D1C2117F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 18:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2E91AC892;
	Thu, 12 Sep 2024 18:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xqn7J6rY"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFE9126BED
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 18:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726166221; cv=none; b=gVu1hJRH+2mkIC0SYfhyd1kldy/BiACze/klcdY7rNmWXLRJ1KFXcCSV4UJDrS4TmyS781Eo/t9g01drzEpyicJSzofJcbj5gDtPWtxYeEFyzLQiZzCikzfDb0YKAdtc7+hsCHlyceWUt4ThehP0ncfyuBIPoJwZ/7zflAyhVq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726166221; c=relaxed/simple;
	bh=BrBJ//8d7nIVm5GY439yYIcJnvWcP7zHf9P56xf5eis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvOJMf32DzYzKl9ablJpr9VmL4QH/0ir7MBePZ2Zi/5eE1sZzZUUlNRlN1hd5pN3werVmB8H6YVW3KqkxwBCttE5RZ7fNeTgJrBHTZaYrx4BNZjDJIjlt2pHRshUbekxYlmuKzYU2FTYPU7PytdOcLQQw1CD2Q8uqJE37/tv7vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Xqn7J6rY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=GlMyCZu9+Lsqxl/xIEpOnb3yyyCsAgN++PzCZFz7wRw=; b=Xqn7J6rYZqZmcicmqhhCo5Km34
	yuxcq7MHodaODL/pQKx6TzmpL+undXNoBeuTt1jmLE+S2aUrrLBWvqCH1KSvdHBfLgEQyUP2RHG7M
	lC42ZhDTWchkqnSiQcj5n8S6h3KgmC0hvltSvRlxoI5ircPW2LkulSlTjyFYZqpFoZBefjN46bDXl
	WNtz7wqrA6N0tT6VbLt36qYmJotq/gMHjsgB4BgExaDkwbY4TxOJJ/mJ2EzDwDSrLWgXMYl5F2x3T
	6N6XCg2isdYPm9RZkZsDy2LH1oNaPRX7wCu3ITw7f2SeyGSiPWw8XoJuZJJI5VlPYf17DAOyoWy3p
	nnEwq2RA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1soogX-00000009o66-0Opm;
	Thu, 12 Sep 2024 18:36:53 +0000
Date: Thu, 12 Sep 2024 19:36:52 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Richard Weinberger <richard@nod.at>
Cc: Li Zetao <lizetao1@huawei.com>,
	anton ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um <linux-um@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] hostfs: Convert hostfs_writepage to use folio
Message-ID: <ZuM0xHQqSpen_xxY@casper.infradead.org>
References: <20240820025045.13339-1-lizetao1@huawei.com>
 <731546887.37035.1726165368713.JavaMail.zimbra@nod.at>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <731546887.37035.1726165368713.JavaMail.zimbra@nod.at>

On Thu, Sep 12, 2024 at 08:22:48PM +0200, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
> > Von: "Li Zetao" <lizetao1@huawei.com>
> > An: "richard" <richard@nod.at>, "anton ivanov" <anton.ivanov@cambridgegreys.com>, "Johannes Berg"
> > <johannes@sipsolutions.net>
> > CC: lizetao1@huawei.com, "linux-um" <linux-um@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>
> > Gesendet: Dienstag, 20. August 2024 04:50:45
> > Betreff: [PATCH -next] hostfs: Convert hostfs_writepage to use folio
> 
> > convert to use folio, so that we can get rid of 'page->index' to
> > prepare for removal of 'index' field in structure page [1].

Ideally, we would not do this, instead converting hostfs to use
writepages instead of writepage.  I haven't done this work; would
someone like to do it?

> > static int hostfs_writepage(struct page *page, struct writeback_control *wbc)
> > {
> > -	struct address_space *mapping = page->mapping;
> > -	struct inode *inode = mapping->host;
> > +	struct folio *folio = page_folio(page);
> > +	struct address_space *mapping = folio->mapping;
> > +	struct inode *inode = folio_inode(folio);

Don't use folio_inode() here, leave it as it was.

> > -	if (page->index >= end_index)
> > +	if (folio->index >= end_index)
> > 		count = inode->i_size & (PAGE_SIZE-1);
> > 
> > -	buffer = kmap_local_page(page);
> > +	buffer = kmap_local_folio(folio, 0);

These two lines assume that hostfs remains a non-large-folio filesystem.
I'm not sure what the plans are for hostfs.


