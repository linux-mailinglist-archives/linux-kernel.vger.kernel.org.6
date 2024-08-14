Return-Path: <linux-kernel+bounces-285859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F20C951381
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 06:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5CF11F26150
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 04:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FC34D8AF;
	Wed, 14 Aug 2024 04:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NhD32DZC"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BF63F9D2
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 04:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723609739; cv=none; b=gaOA1YhYFIMS+wrnSYcQSAWghEjAtvtJEEFwf+6HdFJnZfUDSGiBYnejhCEu1gC0ALgZB3mraC2Z87c4cK/PGYXhPuLoH9SC8t6/bi4GQcAF7Q69sZXYlWiJyGDXSH5Q4zW7yRAVpNb6DdAfRW21/F/evgFQhtBU6mSKIimtduI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723609739; c=relaxed/simple;
	bh=UO7ZXDyV3cy0xfVUzwh3JVtT3nU04nMmPxbllZzsChA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TnFRGmLxLaZix8jsP5h8d575NpFqF4bY1v+fsl7zzHNlkzv2VPzvAU031QI8MooNIxYx69KRWP5j44iVbGfsPh1ZZobhMdeQsNukFkNswVH87lhHEjd5jEMrWw1Hb+Fr7Z4zKTakzhK+Y1K2/tSIb9UQYRcbvecWR/zTUTqVcE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NhD32DZC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JJT/QYYv5cHtmW1x6ENpvX6XEnhbv7o4FA8VLiTScJw=; b=NhD32DZCJVfd03hecvO+gTrQ30
	J5UR09AXTGRevc4534q2YT1pTYc1EOd5zVZSzIeAnYUe0z0/pr3p2kROzDKw6hg7q5nA+h0h4SbIC
	rVPDEfPXtUwuBvXgj1gnbP/Rva10p/syIOpK64rl2cVDesXuNX1/yjeGvrojDB4hCdyVjFlJZ1G5w
	ZbzYFwHuNd35FzpHdtQDyI5ETj22d+vbvIjA2LWQknF4olt5abjImlMMrJE6HGJJB5jN5BntnZuH/
	JikBnxfJXAlh6Xqkt6MKjyfE2LeHsHV2PCTkGPrQiEcp2arAQNYTsRYUTsvI32ijVXeu5WBD3dOiJ
	T3Rh7zXA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1se5d1-00000005hSL-3ZcC;
	Wed, 14 Aug 2024 04:28:55 +0000
Date: Tue, 13 Aug 2024 21:28:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Max Ramanouski <max8rr8@gmail.com>
Cc: x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
	peterz@infradead.org, linux-kernel@vger.kernel.org,
	jniethe@nvidia.com, jhubbard@nvidia.com, linux-mm@kvack.org,
	tglx@linutronix.de
Subject: Re: [PATCH v2] x86/ioremap: Use is_ioremap_addr() in iounmap()
Message-ID: <Zrwyh9bKGVzkLzeA@infradead.org>
References: <20240812203538.82548-1-max8rr8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812203538.82548-1-max8rr8@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Modulo the fixes discussion (and any commit log adjustments related to
that), is_ioremap_addr is the right interface to check for an
ioremap address.  So for the actual code change:

Reviewed-by: Christoph Hellwig <hch@lst.de>


