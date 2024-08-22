Return-Path: <linux-kernel+bounces-297925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5DB95BF30
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 303A61F25337
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281381D0DD6;
	Thu, 22 Aug 2024 19:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fbDpoz7B"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ED917588
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 19:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724356535; cv=none; b=E0+Aq8OOtXnXHtjrv/h8USFxNH5XJmZ8sHmISvuJBrG6nP4BfokvrgJTGz9frgeqQBnngryhX9yeDZ/8G8I/x2544O/QsJn2dNOZ5iWvPEO+OjXfAGOXVe3Pi0sJdv3jXREiZAr/7wSYA+I9rXutYzSkM2ld+CEGn+ff0Euszac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724356535; c=relaxed/simple;
	bh=hyL5wMMmXTly3QjY59pb6UWQ1Y77qpqlyl/ZBMAVpJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RT+FeacMB9lzqVP9m+wRI1nr4Sla1IeOrWesH9f0Ipi91UNiE+0vCThK0NtK7cit+vfIu6sMmEJS9mNLi+5Nu4095GEbEpJbuu1feJg0fDdh1cRT2WYLkrZjWl5UlUWbxnEfGeJRYQOshXE5P9o9VuI7KMFOol+/kslaeKbTjbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fbDpoz7B; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ao10EILDZ2z6IBxtVG/qLyITy/Khz5skvoVpjBv2kTw=; b=fbDpoz7BbfRITrrF+RnsJy9m+n
	VQ5K0wCcXuhZPDQ1zdn78S82ZVCf1k4iVdzxygyMSw9OPhK84Oapu65m6fu2yJholD17hE8LOqddr
	TgYovE2rSEB0YSHkr/Sw+mg4B2TC83mKu9KG2fIj6Kwu9RHzlA32ImuupH1RctBqtO4MyQWjnPGzW
	pUl37H8/icImB9A7Bi9njVEQQy4t/9MNJQen+Rcv54+oAxEb4E6YL4TYUGLSddF+rEG6GyaxqIqBV
	rZD3h1620HAuTYGvW2FrBYckB2W+yf6mTpZCAocOpn27i3SmidgHZQzv4xU+V+uMYDP3H+qZMNbSX
	JtWFendg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shDtx-0000000Asen-0mYL;
	Thu, 22 Aug 2024 19:55:21 +0000
Date: Thu, 22 Aug 2024 20:55:20 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Mark Brown <broonie@kernel.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	maple-tree@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] maple_tree: Allow external locks to be configured
 with their map
Message-ID: <ZseXqP6q7qyFeiCO@casper.infradead.org>
References: <20240822-b4-regmap-maple-nolock-v1-0-d5e6dbae3396@kernel.org>
 <20240822-b4-regmap-maple-nolock-v1-1-d5e6dbae3396@kernel.org>
 <ZsePxD2FtYcBIaD5@casper.infradead.org>
 <ZseWKBCkxTrJfEot@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZseWKBCkxTrJfEot@finisterre.sirena.org.uk>

On Thu, Aug 22, 2024 at 08:48:56PM +0100, Mark Brown wrote:
> On Thu, Aug 22, 2024 at 08:21:40PM +0100, Matthew Wilcox wrote:
> > On Thu, Aug 22, 2024 at 08:13:35PM +0100, Mark Brown wrote:
> 
> > > Currently the maple tree code allows external locks to be configured by
> > > passing the lock itself. This is generally helpful and convenient but is
> 
> > No, it's a really bad idea.  Stop doing it.  Use the internal lock.
> > It's a temporary hack we put in and I'm really regretting allowing it.
> 
> I mean, we do use the internal lock here since otherwise lockdep moans
> but it's pure overhead which just complicates the code.  It's only ever
> taken within another lock, meaning it winds up protecting nothing for
> these maple trees.  We can't go the other way round and use the maple
> tree lock as the regmap lock since apart from anything else it's a spin
> lock and we need to use a mutex most of the time to support busses that
> sleep during I/O.

When it's an uncontended spinlock, there's really no overhead.  I wish I'd
been firmer on that point earlier and prohibited the external lock hack.

The point is that the lock protects the tree.  If we are ever going to
be able to defragment slabs (and I believe this is an ability that Linux
must gain), we must be able to go from the object (the maple node) to
a lock that will let us reallocate the node.  If there's some external
lock that protects the tree, we can't possibly do that.

