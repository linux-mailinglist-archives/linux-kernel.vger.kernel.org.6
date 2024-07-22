Return-Path: <linux-kernel+bounces-259163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5E593920C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17E6F1F21EFC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5359A16E870;
	Mon, 22 Jul 2024 15:49:37 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1583016D4FD
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721663376; cv=none; b=Rb6UJXaLoylxGqqXJSExX3Hq+GDRfFX1jQC/5PFK4vgKsXc0BFKcPqMqKNAo/lCvVoT9tHM/IHgRAqyH7OoSdcCnVRG+zA6M/LDRvPKQMfvunxXWKq+XRdZVdl+DWFQJWAiLFIMbByvyOY5bfq/tgdFNvVx9sadCGf/aTQz5/ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721663376; c=relaxed/simple;
	bh=w3eN+6Q483pj2ELRK8Ywnt5zazxOb+ttAUyXyJVK3NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=faD6FBqCZEOqFC6GqGjAPJylzaDxTRoLF7AzH1qMPPnjBffP16UCO/Qq0boPLBff82+YVpSvU1/nyqHCnKpLYuOKatwEpSwCYOlx/WCp26cfiB04vEtcyPITyUezgAI3PicDP9XtcnHlovAGBLtI3W50TReLoL/eSUtMhghqzaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 137A768C7B; Mon, 22 Jul 2024 17:49:30 +0200 (CEST)
Date: Mon, 22 Jul 2024 17:49:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 2/2] dma: add IOMMU static calls with clear default
 ops
Message-ID: <20240722154929.GA26317@lst.de>
References: <cover.1721547902.git.leon@kernel.org> <bf0b200d4600edd9d6d12168e89f9f3abd6b9789.1721547902.git.leon@kernel.org> <20240722151037.GA25001@lst.de> <20240722154458.GA7022@unreal>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240722154458.GA7022@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 22, 2024 at 06:44:58PM +0300, Leon Romanovsky wrote:
> On Mon, Jul 22, 2024 at 05:10:37PM +0200, Christoph Hellwig wrote:
> > On Sun, Jul 21, 2024 at 10:49:11AM +0300, Leon Romanovsky wrote:
> > > -static void iommu_dma_free_noncontiguous(struct device *dev, size_t size,
> > > -		struct sg_table *sgt, enum dma_data_direction dir)
> > > +void iommu_dma_free_noncontiguous(struct device *dev, size_t size,
> > > +				  struct sg_table *sgt,
> > > +				  enum dma_data_direction dir)
> > 
> > Why are you reformatting these to a much less readable coding style?
> 
> I'm relying on clang-formatter to format the code, see .clang-format
> file in the kernel root directory.

Well, that uses a really horrible default then.  Aligning to the opening
brace not only is hard to read, but requireѕ reformatting with every
addition and removal of a static like here, or when trivially changing
the function name.

> > > +static inline void dma_common_free_pages(struct device *dev, size_t size,
> > > +					 struct page *vaddr,
> > > +					 dma_addr_t dma_handle,
> > > +					 enum dma_data_direction dir)
> > > +{
> > > +}
> > 
> > dma-iommu very much depends on these.  So we'll need to also
> > build ops_helpers.o if dma-iommu is enabled.  So we'll probably need
> > a separate Kconfig option for it that the various users select.
> > 
> 
> I removed them from dma-iommu.c and there are no calls to them in that file.
> ➜  kernel git:(m/dma-v2) git grep dma_common_alloc_pages drivers/iommu/ | wc -l

Well, you replaced them with direct calls from mapping.c, which now
needs them if dma-iommu is supported.  So while strictly speaking
dma-iommu doesn't need them, proper operation with dma-iommu still
needs them.


