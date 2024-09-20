Return-Path: <linux-kernel+bounces-334382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A76197D68C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 16:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94ACAB23032
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 14:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBAC16C695;
	Fri, 20 Sep 2024 14:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RnEP+KJJ"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C140C2AE69
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 14:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726841050; cv=none; b=bsIdPaTxB7hU+zNFUCnXR4OhO1VTXOBuTN6HOREUV8FzPSqiAtOHqzopWFm7ZLU9YUulCUqVzgq0+yxyhaQ5Cl1B/BFQXxWYq3dHhRFL4oULPSeZKLPggy0b/OgKl+5bEqRzikNC3wEsR06JCtCSLg/iN3lIhy251q4Qxn4PWZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726841050; c=relaxed/simple;
	bh=INwMnjrw6XY2PUL5tCabPluVjGp8LD61b2twB3W7CaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XiSwDMfi8bpq7+UgZxY1Xdayi2DtL0/t0FXvmCqssmCZ9Ak64rDsE7P0smWRXH6qSx5tupZeuw7yZ20e4pCAPrLAhLnxzOKEIWl5DIDyCM3Ua37lsii/SVu1dst/a+9ycIP4T3ZDBFZSm5Lj1RNN5WCApisKRQWrwu2PjWYlYTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RnEP+KJJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RCwlKLEJXQ81sm67JF7/OQA8EjktrgnBwq8TDvkYkrU=; b=RnEP+KJJVour4Wz2TFpMO2awow
	dciUCqYfTUUpPqPx7hl88uS9bw0ASNFt/qia735KVxZWkE6iY7UcFeRxg2MMbWigSzKi2JVQN8ser
	GXOrClbTLj1jU6mwSBmyI85Ix8U6HXDjNV9Sac0L9HZ4DqIOcDp/Xi6hp/cHch1wbHeGpcfQtFDOJ
	gC/8LOnfu7Idg1caicV3Atx0ieiH08dgd9cA8aKgu3NDjItfoL3Ij50BjqaejBPnRwekqSSIWQjNa
	+qWNox54k/NzEOmU9ohjHe8/UaBk2gxFT3rpO/vowzS4gGzDH/ate3NT0aekeLh1A4e2pMBD3ozJE
	yWdDL9zw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sreEw-0000000CK7O-25DY;
	Fri, 20 Sep 2024 14:04:06 +0000
Date: Fri, 20 Sep 2024 07:04:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] riscv: make ZONE_DMA32 optional
Message-ID: <Zu2A1l_cX36sOVcB@infradead.org>
References: <20240827113611.537302-1-vladimir.kondratiev@mobileye.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827113611.537302-1-vladimir.kondratiev@mobileye.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Aug 27, 2024 at 02:36:11PM +0300, Vladimir Kondratiev wrote:
> It is not necessary any RISCV platform has ZONE_DMA32.

That is an odd statement.  The point of ZONE_DMA32 is to make sure
that drivers can always allocate 32-bit DMAable memory, and without
ZONE_DMA32 that is very hard to provide unless you always have an
IOMMU.

> Example - if platform has no DRAM in [0..4G] region,
> it will report failure like below each boot.

ZONE_DMA32 is supposed to contain the 32-bit dma addressable memory,
not 32-bit physical.

Take a look at the changes that just went into Linus' tree for that.


