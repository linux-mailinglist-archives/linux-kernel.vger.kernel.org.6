Return-Path: <linux-kernel+bounces-259115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 912C6939173
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1C991C2176C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7A316DEA8;
	Mon, 22 Jul 2024 15:10:45 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFE21F954
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 15:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721661045; cv=none; b=cD9sAcfBXYY83npxmIQrsbl1CzJF+SPWGz2gUJu7VoUT7ewG/Z6WszepOxBj/6GbwQ4MpN+HkJjX/uEGstmeR8XE4N5II0LpP/3HzeCX5ZBmUmXhehVo4dsAAPWyTgft0s29Glwr3skCj4msoicCO1jy11xQWdDbWYw+7HZ6FNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721661045; c=relaxed/simple;
	bh=h0avLBh1l9SpGT34z41LHtNgE3HKNHjT+leiPk8F7lM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETkZDXg6gGmnAWGRfrbAAIAf0gbvZCydt9WPH+A7kO9h6zew0dzHhopT8DA0WG0F1/sREOiVTlGFLptYj72GszKqYSzpOTWDpK9A5Y4OFvEZGw3s57OVHc26hHuEk56RfppysAw2mA6isN2Do+KTse/kgR3L8S2fWAYQph/s0ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1E0D968C7B; Mon, 22 Jul 2024 17:10:38 +0200 (CEST)
Date: Mon, 22 Jul 2024 17:10:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 2/2] dma: add IOMMU static calls with clear default
 ops
Message-ID: <20240722151037.GA25001@lst.de>
References: <cover.1721547902.git.leon@kernel.org> <bf0b200d4600edd9d6d12168e89f9f3abd6b9789.1721547902.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf0b200d4600edd9d6d12168e89f9f3abd6b9789.1721547902.git.leon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Jul 21, 2024 at 10:49:11AM +0300, Leon Romanovsky wrote:
> -static void iommu_dma_free_noncontiguous(struct device *dev, size_t size,
> -		struct sg_table *sgt, enum dma_data_direction dir)
> +void iommu_dma_free_noncontiguous(struct device *dev, size_t size,
> +				  struct sg_table *sgt,
> +				  enum dma_data_direction dir)

Why are you reformatting these to a much less readable coding style?

> +static inline struct page *
> +dma_common_alloc_pages(struct device *dev, size_t size, dma_addr_t *dma_handle,
> +		       enum dma_data_direction dir, gfp_t gfp)
> +{
> +	return NULL;
> +}
> +static inline void dma_common_free_pages(struct device *dev, size_t size,
> +					 struct page *vaddr,
> +					 dma_addr_t dma_handle,
> +					 enum dma_data_direction dir)
> +{
> +}

dma-iommu very much depends on these.  So we'll need to also
build ops_helpers.o if dma-iommu is enabled.  So we'll probably need
a separate Kconfig option for it that the various users select.


