Return-Path: <linux-kernel+bounces-265763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D6693F5A5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EE781F22A52
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FA51487EF;
	Mon, 29 Jul 2024 12:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xgz+rRad"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33051487C1
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 12:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722256884; cv=none; b=hIpunux7t5oTWaz+v8DQlzll1J16nIwAscStH4UGKOYFpVb2c0pDR8tlmW90wVCeLHNajWmOrxuIli0DnTosNBe7yzgw84isRhw9aNPNXXNrV+e+ELDuBFZaSnp2zrHCjf6XtVIjfOMTw7UIJnNiPHVnIa6qeSd+C5Mg4oL2gww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722256884; c=relaxed/simple;
	bh=r31T+JXAwJZkIFi46ldkznhcaL9ecNWFOaUcZUxb2sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZcgYKthW3kRmgjA1/LBshtEbgeqUFMuEp8Uh5sFBRlnfdsQbsfny/KAMiR700zofTAlsQXhBLHW77X0L3qjDuaCwOqSMazdZy5ihEmZ9GrLxQBUBfyByRUAjcQ9Lf+mxvzrqKvpZAgRuL2lmYZ6KHhIzrYgJq2g7H778ZBxvC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xgz+rRad; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-428078ebeb9so60325e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 05:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722256880; x=1722861680; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HRvU9jBrQZ4KhrHUkb5saHujlHE2yZAyI+l7wKk3MGA=;
        b=xgz+rRadr+8OgDWm6ESREd08exk6BYP9nyX/AOdUTjG0c/sUSPpdvXIJttpiIToRxh
         tn9FEm14WCPdld3pOWwWfU6SFuJfNLEWVfBYttuC977xopGlDOgzYU6kVPLCfJGVISQt
         YBIWq3d7BQj/RhleENVzvrSKM7wIg9CTcnPnQ1qWo1Bcgz8jDi99touI167iqYPBOQix
         QtSEjvStG6m3segI65gxOW0OEEhXUWrgoT57R63qMtucE7TTt07LVNPnZCEmRCC2s5j+
         gSCsJyI+z34eu+0iMlH7L4WIX/LVWtSnPIjr6uQsNLLVCQ3NQ3uMagOphlFrMUZRzzuR
         anVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722256880; x=1722861680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRvU9jBrQZ4KhrHUkb5saHujlHE2yZAyI+l7wKk3MGA=;
        b=KHoBkIcq6h4l8XIFOuwPhIR8bv5vavrM3D+BxuSuZQ0SVFNTgVdYZPNo5weoMpm7SB
         sMFGogAu0TSLh6vwCSY5kZ46l5crR3yJQC/1JdwVegfTRw6tQp1oWWkMX/KeS6Zlv/C4
         I8DU239n1B7kAKdg5O6KEf1cpkNEnMXSrIPj9DhS141w0qeTS8WTx1mybmvKi7ioWOWQ
         8uHPXI922al5def5mUWJ5Vapw1Vn5Tu74U4OfvTBOdw6rTfDmH1unRqgiNHr10/lfz/3
         aQhYv9oUB+g32O0VY3/QHrZceHkZYiWINgv48vp37LLCtUkO7Z40h0TcaaVkQYJKj6Ly
         ySaA==
X-Forwarded-Encrypted: i=1; AJvYcCU7yuhrQSYX5rB8AeD3lXfMjNoKZ+Lk7pQM1grrKJuhm7ABX4lEWVUKFj4zbv85rxCvPLMyppz9ubtRakm4VpzRv39lhbJzJ+aayPEY
X-Gm-Message-State: AOJu0Yyhy4aO0JA2VaVgQwoRN+uTfW1dp6vlTZtwDGueOk/UIbONgbFQ
	5xDeuQltAFHbQGESFHIMNpKQMpdFA3NUogyxqEGgCKFkPEgN47B8gfNFOYzmyQ==
X-Google-Smtp-Source: AGHT+IFbNN0BaMKZ679r6Uoybwfx46sNe39vp7PJTzZsectyoRFSqSsERWdIyjotcZM4xU+YuKWmVQ==
X-Received: by 2002:a05:600c:1d10:b0:426:7018:2e2f with SMTP id 5b1f17b1804b1-428131e3f34mr3061765e9.5.1722256879519;
        Mon, 29 Jul 2024 05:41:19 -0700 (PDT)
Received: from google.com (180.232.140.34.bc.googleusercontent.com. [34.140.232.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36862549sm12131546f8f.106.2024.07.29.05.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 05:41:19 -0700 (PDT)
Date: Mon, 29 Jul 2024 12:41:12 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 2/2] dma: add IOMMU static calls with clear default ops
Message-ID: <ZqeN6MP4o2JNLcUz@google.com>
References: <cover.1721219730.git.leon@kernel.org>
 <dd34bf3ecef252b4910d70aa21ff5273b5e8b19b.1721219730.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd34bf3ecef252b4910d70aa21ff5273b5e8b19b.1721219730.git.leon@kernel.org>

Hi Leon,

On Wed, Jul 17, 2024 at 03:37:11PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Most of the arch DMA ops (which often, but not  always, involve
> some sort of IOMMU) are using the same DMA operations. These DMA
> operations are default ones implemented in drivers/iomem/dma-iommu.c.
> 
> So let's make sure to call them directly without need to perform function
> pointers dereference.

Just out of curiosity, is there any observed improvement from that?
As from my experience the DMA-IOMMU path is quite dense so it won't
be senstive to such micro-optimizations.

Thanks,
Mostafa

> 
> During system initialization, the arch can set its own DMA and in such case,
> the default DMA operations will be overridden.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Leon Romanovsky <leon@kernel.org>
> ---
>  MAINTAINERS                 |   1 +
>  drivers/iommu/Kconfig       |   1 -
>  drivers/iommu/dma-iommu.c   | 117 ++++++++++---------------
>  include/linux/device.h      |   3 +
>  include/linux/dma-map-ops.h |  13 ---
>  include/linux/iommu-dma.h   | 169 ++++++++++++++++++++++++++++++++++++
>  kernel/dma/mapping.c        |  84 +++++++++++++++---
>  7 files changed, 292 insertions(+), 96 deletions(-)
>  create mode 100644 include/linux/iommu-dma.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 958e935449e5..ce06c4df7e05 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11525,6 +11525,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
>  F:	Documentation/devicetree/bindings/iommu/
>  F:	Documentation/userspace-api/iommu.rst
>  F:	drivers/iommu/
> +F:	include/linux/iommu-dma.h
>  F:	include/linux/iommu.h
>  F:	include/linux/iova.h
>  F:	include/linux/of_iommu.h
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index c04584be3089..e0dd30c1b08a 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -151,7 +151,6 @@ config OF_IOMMU
>  # IOMMU-agnostic DMA-mapping layer
>  config IOMMU_DMA
>  	def_bool ARM64 || X86 || S390
> -	select DMA_OPS
>  	select IOMMU_API
>  	select IOMMU_IOVA
>  	select IRQ_MSI_IOMMU
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 43520e7275cc..174b84f9cd92 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -17,6 +17,7 @@
>  #include <linux/gfp.h>
>  #include <linux/huge_mm.h>
>  #include <linux/iommu.h>
> +#include <linux/iommu-dma.h>
>  #include <linux/iova.h>
>  #include <linux/irq.h>
>  #include <linux/list_sort.h>
> @@ -1039,9 +1040,9 @@ static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
>  	return NULL;
>  }
>  
> -static struct sg_table *iommu_dma_alloc_noncontiguous(struct device *dev,
> -		size_t size, enum dma_data_direction dir, gfp_t gfp,
> -		unsigned long attrs)
> +struct sg_table *iommu_dma_alloc_noncontiguous(struct device *dev, size_t size,
> +					       enum dma_data_direction dir,
> +					       gfp_t gfp, unsigned long attrs)
>  {
>  	struct dma_sgt_handle *sh;
>  
> @@ -1058,8 +1059,9 @@ static struct sg_table *iommu_dma_alloc_noncontiguous(struct device *dev,
>  	return &sh->sgt;
>  }
>  
> -static void iommu_dma_free_noncontiguous(struct device *dev, size_t size,
> -		struct sg_table *sgt, enum dma_data_direction dir)
> +void iommu_dma_free_noncontiguous(struct device *dev, size_t size,
> +				  struct sg_table *sgt,
> +				  enum dma_data_direction dir)
>  {
>  	struct dma_sgt_handle *sh = sgt_handle(sgt);
>  
> @@ -1069,8 +1071,8 @@ static void iommu_dma_free_noncontiguous(struct device *dev, size_t size,
>  	kfree(sh);
>  }
>  
> -static void iommu_dma_sync_single_for_cpu(struct device *dev,
> -		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
> +void iommu_dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle,
> +				   size_t size, enum dma_data_direction dir)
>  {
>  	phys_addr_t phys;
>  
> @@ -1085,8 +1087,8 @@ static void iommu_dma_sync_single_for_cpu(struct device *dev,
>  		swiotlb_sync_single_for_cpu(dev, phys, size, dir);
>  }
>  
> -static void iommu_dma_sync_single_for_device(struct device *dev,
> -		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
> +void iommu_dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle,
> +				      size_t size, enum dma_data_direction dir)
>  {
>  	phys_addr_t phys;
>  
> @@ -1101,9 +1103,8 @@ static void iommu_dma_sync_single_for_device(struct device *dev,
>  		arch_sync_dma_for_device(phys, size, dir);
>  }
>  
> -static void iommu_dma_sync_sg_for_cpu(struct device *dev,
> -		struct scatterlist *sgl, int nelems,
> -		enum dma_data_direction dir)
> +void iommu_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sgl,
> +			       int nelems, enum dma_data_direction dir)
>  {
>  	struct scatterlist *sg;
>  	int i;
> @@ -1117,9 +1118,8 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
>  			arch_sync_dma_for_cpu(sg_phys(sg), sg->length, dir);
>  }
>  
> -static void iommu_dma_sync_sg_for_device(struct device *dev,
> -		struct scatterlist *sgl, int nelems,
> -		enum dma_data_direction dir)
> +void iommu_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sgl,
> +				  int nelems, enum dma_data_direction dir)
>  {
>  	struct scatterlist *sg;
>  	int i;
> @@ -1134,9 +1134,9 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
>  			arch_sync_dma_for_device(sg_phys(sg), sg->length, dir);
>  }
>  
> -static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
> -		unsigned long offset, size_t size, enum dma_data_direction dir,
> -		unsigned long attrs)
> +dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
> +			      unsigned long offset, size_t size,
> +			      enum dma_data_direction dir, unsigned long attrs)
>  {
>  	phys_addr_t phys = page_to_phys(page) + offset;
>  	bool coherent = dev_is_dma_coherent(dev);
> @@ -1194,8 +1194,9 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
>  	return iova;
>  }
>  
> -static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
> -		size_t size, enum dma_data_direction dir, unsigned long attrs)
> +void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
> +			  size_t size, enum dma_data_direction dir,
> +			  unsigned long attrs)
>  {
>  	struct iommu_domain *domain = iommu_get_dma_domain(dev);
>  	phys_addr_t phys;
> @@ -1348,8 +1349,8 @@ static int iommu_dma_map_sg_swiotlb(struct device *dev, struct scatterlist *sg,
>   * impedance-matching, to be able to hand off a suitably-aligned list,
>   * but still preserve the original offsets and sizes for the caller.
>   */
> -static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
> -		int nents, enum dma_data_direction dir, unsigned long attrs)
> +int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
> +		     enum dma_data_direction dir, unsigned long attrs)
>  {
>  	struct iommu_domain *domain = iommu_get_dma_domain(dev);
>  	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> @@ -1468,8 +1469,8 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>  	return ret;
>  }
>  
> -static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
> -		int nents, enum dma_data_direction dir, unsigned long attrs)
> +void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
> +			enum dma_data_direction dir, unsigned long attrs)
>  {
>  	dma_addr_t end = 0, start;
>  	struct scatterlist *tmp;
> @@ -1518,16 +1519,18 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
>  		__iommu_dma_unmap(dev, start, end - start);
>  }
>  
> -static dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
> -		size_t size, enum dma_data_direction dir, unsigned long attrs)
> +dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
> +				  size_t size, enum dma_data_direction dir,
> +				  unsigned long attrs)
>  {
>  	return __iommu_dma_map(dev, phys, size,
>  			dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO,
>  			dma_get_mask(dev));
>  }
>  
> -static void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
> -		size_t size, enum dma_data_direction dir, unsigned long attrs)
> +void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
> +			      size_t size, enum dma_data_direction dir,
> +			      unsigned long attrs)
>  {
>  	__iommu_dma_unmap(dev, handle, size);
>  }
> @@ -1563,8 +1566,8 @@ static void __iommu_dma_free(struct device *dev, size_t size, void *cpu_addr)
>  		dma_free_contiguous(dev, page, alloc_size);
>  }
>  
> -static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
> -		dma_addr_t handle, unsigned long attrs)
> +void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
> +		    dma_addr_t handle, unsigned long attrs)
>  {
>  	__iommu_dma_unmap(dev, handle, size);
>  	__iommu_dma_free(dev, size, cpu_addr);
> @@ -1607,8 +1610,8 @@ static void *iommu_dma_alloc_pages(struct device *dev, size_t size,
>  	return NULL;
>  }
>  
> -static void *iommu_dma_alloc(struct device *dev, size_t size,
> -		dma_addr_t *handle, gfp_t gfp, unsigned long attrs)
> +void *iommu_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
> +		      gfp_t gfp, unsigned long attrs)
>  {
>  	bool coherent = dev_is_dma_coherent(dev);
>  	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
> @@ -1642,9 +1645,9 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
>  	return cpu_addr;
>  }
>  
> -static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
> -		void *cpu_addr, dma_addr_t dma_addr, size_t size,
> -		unsigned long attrs)
> +int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
> +		   void *cpu_addr, dma_addr_t dma_addr, size_t size,
> +		   unsigned long attrs)
>  {
>  	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
>  	unsigned long pfn, off = vma->vm_pgoff;
> @@ -1673,9 +1676,9 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
>  			       vma->vm_page_prot);
>  }
>  
> -static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
> -		void *cpu_addr, dma_addr_t dma_addr, size_t size,
> -		unsigned long attrs)
> +int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
> +			  void *cpu_addr, dma_addr_t dma_addr, size_t size,
> +			  unsigned long attrs)
>  {
>  	struct page *page;
>  	int ret;
> @@ -1700,19 +1703,19 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
>  	return ret;
>  }
>  
> -static unsigned long iommu_dma_get_merge_boundary(struct device *dev)
> +unsigned long iommu_dma_get_merge_boundary(struct device *dev)
>  {
>  	struct iommu_domain *domain = iommu_get_dma_domain(dev);
>  
>  	return (1UL << __ffs(domain->pgsize_bitmap)) - 1;
>  }
>  
> -static size_t iommu_dma_opt_mapping_size(void)
> +size_t iommu_dma_opt_mapping_size(void)
>  {
>  	return iova_rcache_range();
>  }
>  
> -static size_t iommu_dma_max_mapping_size(struct device *dev)
> +size_t iommu_dma_max_mapping_size(struct device *dev)
>  {
>  	if (dev_is_untrusted(dev))
>  		return swiotlb_max_mapping_size(dev);
> @@ -1720,32 +1723,6 @@ static size_t iommu_dma_max_mapping_size(struct device *dev)
>  	return SIZE_MAX;
>  }
>  
> -static const struct dma_map_ops iommu_dma_ops = {
> -	.flags			= DMA_F_PCI_P2PDMA_SUPPORTED |
> -				  DMA_F_CAN_SKIP_SYNC,
> -	.alloc			= iommu_dma_alloc,
> -	.free			= iommu_dma_free,
> -	.alloc_pages_op		= dma_common_alloc_pages,
> -	.free_pages		= dma_common_free_pages,
> -	.alloc_noncontiguous	= iommu_dma_alloc_noncontiguous,
> -	.free_noncontiguous	= iommu_dma_free_noncontiguous,
> -	.mmap			= iommu_dma_mmap,
> -	.get_sgtable		= iommu_dma_get_sgtable,
> -	.map_page		= iommu_dma_map_page,
> -	.unmap_page		= iommu_dma_unmap_page,
> -	.map_sg			= iommu_dma_map_sg,
> -	.unmap_sg		= iommu_dma_unmap_sg,
> -	.sync_single_for_cpu	= iommu_dma_sync_single_for_cpu,
> -	.sync_single_for_device	= iommu_dma_sync_single_for_device,
> -	.sync_sg_for_cpu	= iommu_dma_sync_sg_for_cpu,
> -	.sync_sg_for_device	= iommu_dma_sync_sg_for_device,
> -	.map_resource		= iommu_dma_map_resource,
> -	.unmap_resource		= iommu_dma_unmap_resource,
> -	.get_merge_boundary	= iommu_dma_get_merge_boundary,
> -	.opt_mapping_size	= iommu_dma_opt_mapping_size,
> -	.max_mapping_size       = iommu_dma_max_mapping_size,
> -};
> -
>  void iommu_setup_dma_ops(struct device *dev)
>  {
>  	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> @@ -1756,10 +1733,10 @@ void iommu_setup_dma_ops(struct device *dev)
>  	if (iommu_is_dma_domain(domain)) {
>  		if (iommu_dma_init_domain(domain, dev))
>  			goto out_err;
> -		dev->dma_ops = &iommu_dma_ops;
> -	} else if (dev->dma_ops == &iommu_dma_ops) {
> +		dev->dma_iommu = true;
> +	} else if (dev->dma_iommu) {
>  		/* Clean up if we've switched *from* a DMA domain */
> -		dev->dma_ops = NULL;
> +		dev->dma_iommu = false;
>  	}
>  
>  	return;
> diff --git a/include/linux/device.h b/include/linux/device.h
> index ace039151cb8..7fa1e40b617a 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -822,6 +822,9 @@ struct device {
>  #ifdef CONFIG_DMA_NEED_SYNC
>  	bool			dma_skip_sync:1;
>  #endif
> +#ifdef CONFIG_IOMMU_DMA
> +	bool			dma_iommu : 1;
> +#endif
>  };
>  
>  /**
> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> index 02a1c825896b..077b15c93bb8 100644
> --- a/include/linux/dma-map-ops.h
> +++ b/include/linux/dma-map-ops.h
> @@ -13,20 +13,7 @@
>  struct cma;
>  struct iommu_ops;
>  
> -/*
> - * Values for struct dma_map_ops.flags:
> - *
> - * DMA_F_PCI_P2PDMA_SUPPORTED: Indicates the dma_map_ops implementation can
> - * handle PCI P2PDMA pages in the map_sg/unmap_sg operation.
> - * DMA_F_CAN_SKIP_SYNC: DMA sync operations can be skipped if the device is
> - * coherent and it's not an SWIOTLB buffer.
> - */
> -#define DMA_F_PCI_P2PDMA_SUPPORTED     (1 << 0)
> -#define DMA_F_CAN_SKIP_SYNC            (1 << 1)
> -
>  struct dma_map_ops {
> -	unsigned int flags;
> -
>  	void *(*alloc)(struct device *dev, size_t size,
>  			dma_addr_t *dma_handle, gfp_t gfp,
>  			unsigned long attrs);
> diff --git a/include/linux/iommu-dma.h b/include/linux/iommu-dma.h
> new file mode 100644
> index 000000000000..622232fc9510
> --- /dev/null
> +++ b/include/linux/iommu-dma.h
> @@ -0,0 +1,169 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved
> + *
> + * DMA operations that map physical memory through IOMMU.
> + */
> +#ifndef _LINUX_IOMMU_DMA_H
> +#define _LINUX_IOMMU_DMA_H
> +
> +#include <linux/dma-direction.h>
> +
> +#ifdef CONFIG_IOMMU_DMA
> +dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
> +			      unsigned long offset, size_t size,
> +			      enum dma_data_direction dir, unsigned long attrs);
> +void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
> +			  size_t size, enum dma_data_direction dir,
> +			  unsigned long attrs);
> +int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
> +		     enum dma_data_direction dir, unsigned long attrs);
> +void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
> +			enum dma_data_direction dir, unsigned long attrs);
> +void *iommu_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
> +		      gfp_t gfp, unsigned long attrs);
> +int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
> +		   void *cpu_addr, dma_addr_t dma_addr,
> +		   size_t size, unsigned long attrs);
> +int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
> +			  void *cpu_addr, dma_addr_t dma_addr, size_t size,
> +			  unsigned long attrs);
> +unsigned long iommu_dma_get_merge_boundary(struct device *dev);
> +size_t iommu_dma_opt_mapping_size(void);
> +size_t iommu_dma_max_mapping_size(struct device *dev);
> +void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
> +		    dma_addr_t handle, unsigned long attrs);
> +dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
> +				  size_t size, enum dma_data_direction dir,
> +				  unsigned long attrs);
> +void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
> +			      size_t size, enum dma_data_direction dir,
> +			      unsigned long attrs);
> +struct sg_table *iommu_dma_alloc_noncontiguous(struct device *dev, size_t size,
> +					       enum dma_data_direction dir,
> +					       gfp_t gfp, unsigned long attrs);
> +void iommu_dma_free_noncontiguous(struct device *dev, size_t size,
> +				  struct sg_table *sgt,
> +				  enum dma_data_direction dir);
> +void iommu_dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle,
> +				   size_t size, enum dma_data_direction dir);
> +void iommu_dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle,
> +				      size_t size, enum dma_data_direction dir);
> +void iommu_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sgl,
> +			       int nelems, enum dma_data_direction dir);
> +void iommu_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sgl,
> +				  int nelems, enum dma_data_direction dir);
> +#else
> +static inline dma_addr_t iommu_dma_map_page(struct device *dev,
> +					    struct page *page,
> +					    unsigned long offset, size_t size,
> +					    enum dma_data_direction dir,
> +					    unsigned long attrs)
> +{
> +	return DMA_MAPPING_ERROR;
> +}
> +static inline void iommu_dma_unmap_page(struct device *dev,
> +					dma_addr_t dma_handle, size_t size,
> +					enum dma_data_direction dir,
> +					unsigned long attrs)
> +{
> +}
> +static inline int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
> +				   int nents, enum dma_data_direction dir,
> +				   unsigned long attrs)
> +{
> +	return -EINVAL;
> +}
> +static inline void iommu_dma_unmap_sg(struct device *dev,
> +				      struct scatterlist *sg, int nents,
> +				      enum dma_data_direction dir,
> +				      unsigned long attrs)
> +{
> +}
> +static inline void *iommu_dma_alloc(struct device *dev, size_t size,
> +				    dma_addr_t *handle, gfp_t gfp,
> +				    unsigned long attrs)
> +{
> +	return NULL;
> +}
> +static inline int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
> +				 void *cpu_addr, dma_addr_t dma_addr,
> +				 size_t size, unsigned long attrs)
> +{
> +	return -EINVAL;
> +}
> +static inline int iommu_dma_get_sgtable(struct device *dev,
> +					struct sg_table *sgt, void *cpu_addr,
> +					dma_addr_t dma_addr, size_t size,
> +					unsigned long attrs)
> +{
> +	return -EINVAL;
> +}
> +static inline unsigned long iommu_dma_get_merge_boundary(struct device *dev)
> +{
> +	return 0;
> +}
> +static inline size_t iommu_dma_opt_mapping_size(void)
> +{
> +	return 0;
> +}
> +static inline size_t iommu_dma_max_mapping_size(struct device *dev)
> +{
> +	return 0;
> +}
> +static inline void iommu_dma_free(struct device *dev, size_t size,
> +				  void *cpu_addr, dma_addr_t handle,
> +				  unsigned long attrs)
> +{
> +}
> +static inline dma_addr_t iommu_dma_map_resource(struct device *dev,
> +						phys_addr_t phys, size_t size,
> +						enum dma_data_direction dir,
> +						unsigned long attrs)
> +{
> +	return DMA_MAPPING_ERROR;
> +}
> +static inline void iommu_dma_unmap_resource(struct device *dev,
> +					    dma_addr_t handle, size_t size,
> +					    enum dma_data_direction dir,
> +					    unsigned long attrs)
> +{
> +}
> +static inline struct sg_table *
> +iommu_dma_alloc_noncontiguous(struct device *dev, size_t size,
> +			      enum dma_data_direction dir, gfp_t gfp,
> +			      unsigned long attrs)
> +{
> +	return NULL;
> +}
> +static inline void iommu_dma_free_noncontiguous(struct device *dev, size_t size,
> +						struct sg_table *sgt,
> +						enum dma_data_direction dir)
> +{
> +}
> +static inline void iommu_dma_sync_single_for_cpu(struct device *dev,
> +						 dma_addr_t dma_handle,
> +						 size_t size,
> +						 enum dma_data_direction dir)
> +{
> +}
> +static inline void iommu_dma_sync_single_for_device(struct device *dev,
> +						    dma_addr_t dma_handle,
> +						    size_t size,
> +						    enum dma_data_direction dir)
> +{
> +}
> +static inline void iommu_dma_sync_sg_for_cpu(struct device *dev,
> +					     struct scatterlist *sgl,
> +					     int nelems,
> +					     enum dma_data_direction dir)
> +{
> +}
> +static inline void iommu_dma_sync_sg_for_device(struct device *dev,
> +						struct scatterlist *sgl,
> +						int nelems,
> +						enum dma_data_direction dir)
> +{
> +}
> +#endif /* CONFIG_IOMMU_DMA */
> +#endif /* _LINUX_IOMMU_DMA_H */
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 6832fd6f0796..feaa69c35f79 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -8,6 +8,7 @@
>  #include <linux/memblock.h> /* for max_pfn */
>  #include <linux/acpi.h>
>  #include <linux/dma-map-ops.h>
> +#include <linux/iommu-dma.h>
>  #include <linux/export.h>
>  #include <linux/gfp.h>
>  #include <linux/kmsan.h>
> @@ -113,12 +114,24 @@ void *dmam_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
>  }
>  EXPORT_SYMBOL(dmam_alloc_attrs);
>  
> +static inline bool dma_is_default_iommu(struct device *dev)
> +{
> +#ifdef CONFIG_IOMMU_DMA
> +	return dev->dma_iommu;
> +#else
> +	return false;
> +#endif
> +}
> +
>  static bool dma_go_direct(struct device *dev, dma_addr_t mask,
>  		const struct dma_map_ops *ops)
>  {
> -	if (likely(!ops))
> +	WARN_ON_ONCE(ops && dma_is_default_iommu(dev));
> +	if (likely(!ops) && !dma_is_default_iommu(dev))
>  		return true;
> +
>  #ifdef CONFIG_DMA_OPS_BYPASS
> +	WARN_ON_ONCE(dev->dma_ops_bypass && dma_is_default_iommu(dev));
>  	if (dev->dma_ops_bypass)
>  		return min_not_zero(mask, dev->bus_dma_limit) >=
>  			    dma_direct_get_required_mask(dev);
> @@ -159,6 +172,8 @@ dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
>  	if (dma_map_direct(dev, ops) ||
>  	    arch_dma_map_page_direct(dev, page_to_phys(page) + offset + size))
>  		addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
> +	else if (dma_is_default_iommu(dev))
> +		addr = iommu_dma_map_page(dev, page, offset, size, dir, attrs);
>  	else
>  		addr = ops->map_page(dev, page, offset, size, dir, attrs);
>  	kmsan_handle_dma(page, offset, size, dir);
> @@ -177,6 +192,8 @@ void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
>  	if (dma_map_direct(dev, ops) ||
>  	    arch_dma_unmap_page_direct(dev, addr + size))
>  		dma_direct_unmap_page(dev, addr, size, dir, attrs);
> +	else if (dma_is_default_iommu(dev))
> +		iommu_dma_unmap_page(dev, addr, size, dir, attrs);
>  	else
>  		ops->unmap_page(dev, addr, size, dir, attrs);
>  	debug_dma_unmap_page(dev, addr, size, dir);
> @@ -197,6 +214,8 @@ static int __dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
>  	if (dma_map_direct(dev, ops) ||
>  	    arch_dma_map_sg_direct(dev, sg, nents))
>  		ents = dma_direct_map_sg(dev, sg, nents, dir, attrs);
> +	else if (dma_is_default_iommu(dev))
> +		ents = iommu_dma_map_sg(dev, sg, nents, dir, attrs);
>  	else
>  		ents = ops->map_sg(dev, sg, nents, dir, attrs);
>  
> @@ -291,6 +310,8 @@ void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>  	if (dma_map_direct(dev, ops) ||
>  	    arch_dma_unmap_sg_direct(dev, sg, nents))
>  		dma_direct_unmap_sg(dev, sg, nents, dir, attrs);
> +	else if (dma_is_default_iommu(dev))
> +		iommu_dma_unmap_sg(dev, sg, nents, dir, attrs);
>  	else
>  		ops->unmap_sg(dev, sg, nents, dir, attrs);
>  }
> @@ -309,6 +330,8 @@ dma_addr_t dma_map_resource(struct device *dev, phys_addr_t phys_addr,
>  
>  	if (dma_map_direct(dev, ops))
>  		addr = dma_direct_map_resource(dev, phys_addr, size, dir, attrs);
> +	else if (dma_is_default_iommu(dev))
> +		addr = iommu_dma_map_resource(dev, phys_addr, size, dir, attrs);
>  	else if (ops->map_resource)
>  		addr = ops->map_resource(dev, phys_addr, size, dir, attrs);
>  
> @@ -323,8 +346,12 @@ void dma_unmap_resource(struct device *dev, dma_addr_t addr, size_t size,
>  	const struct dma_map_ops *ops = get_dma_ops(dev);
>  
>  	BUG_ON(!valid_dma_direction(dir));
> -	if (!dma_map_direct(dev, ops) && ops->unmap_resource)
> -		ops->unmap_resource(dev, addr, size, dir, attrs);
> +	if (!dma_map_direct(dev, ops)) {
> +		if (dma_is_default_iommu(dev))
> +			iommu_dma_unmap_resource(dev, addr, size, dir, attrs);
> +		else if (ops->unmap_resource)
> +			ops->unmap_resource(dev, addr, size, dir, attrs);
> +	}
>  	debug_dma_unmap_resource(dev, addr, size, dir);
>  }
>  EXPORT_SYMBOL(dma_unmap_resource);
> @@ -338,6 +365,8 @@ void __dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr, size_t size,
>  	BUG_ON(!valid_dma_direction(dir));
>  	if (dma_map_direct(dev, ops))
>  		dma_direct_sync_single_for_cpu(dev, addr, size, dir);
> +	else if (dma_is_default_iommu(dev))
> +		iommu_dma_sync_single_for_cpu(dev, addr, size, dir);
>  	else if (ops->sync_single_for_cpu)
>  		ops->sync_single_for_cpu(dev, addr, size, dir);
>  	debug_dma_sync_single_for_cpu(dev, addr, size, dir);
> @@ -352,6 +381,8 @@ void __dma_sync_single_for_device(struct device *dev, dma_addr_t addr,
>  	BUG_ON(!valid_dma_direction(dir));
>  	if (dma_map_direct(dev, ops))
>  		dma_direct_sync_single_for_device(dev, addr, size, dir);
> +	else if (dma_is_default_iommu(dev))
> +		iommu_dma_sync_single_for_device(dev, addr, size, dir);
>  	else if (ops->sync_single_for_device)
>  		ops->sync_single_for_device(dev, addr, size, dir);
>  	debug_dma_sync_single_for_device(dev, addr, size, dir);
> @@ -366,6 +397,8 @@ void __dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
>  	BUG_ON(!valid_dma_direction(dir));
>  	if (dma_map_direct(dev, ops))
>  		dma_direct_sync_sg_for_cpu(dev, sg, nelems, dir);
> +	else if (dma_is_default_iommu(dev))
> +		iommu_dma_sync_sg_for_cpu(dev, sg, nelems, dir);
>  	else if (ops->sync_sg_for_cpu)
>  		ops->sync_sg_for_cpu(dev, sg, nelems, dir);
>  	debug_dma_sync_sg_for_cpu(dev, sg, nelems, dir);
> @@ -380,6 +413,8 @@ void __dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
>  	BUG_ON(!valid_dma_direction(dir));
>  	if (dma_map_direct(dev, ops))
>  		dma_direct_sync_sg_for_device(dev, sg, nelems, dir);
> +	else if (dma_is_default_iommu(dev))
> +		iommu_dma_sync_sg_for_device(dev, sg, nelems, dir);
>  	else if (ops->sync_sg_for_device)
>  		ops->sync_sg_for_device(dev, sg, nelems, dir);
>  	debug_dma_sync_sg_for_device(dev, sg, nelems, dir);
> @@ -405,7 +440,7 @@ static void dma_setup_need_sync(struct device *dev)
>  {
>  	const struct dma_map_ops *ops = get_dma_ops(dev);
>  
> -	if (dma_map_direct(dev, ops) || (ops->flags & DMA_F_CAN_SKIP_SYNC))
> +	if (dma_map_direct(dev, ops) || dma_is_default_iommu(dev))
>  		/*
>  		 * dma_skip_sync will be reset to %false on first SWIOTLB buffer
>  		 * mapping, if any. During the device initialization, it's
> @@ -446,6 +481,9 @@ int dma_get_sgtable_attrs(struct device *dev, struct sg_table *sgt,
>  	if (dma_alloc_direct(dev, ops))
>  		return dma_direct_get_sgtable(dev, sgt, cpu_addr, dma_addr,
>  				size, attrs);
> +	if (dma_is_default_iommu(dev))
> +		return iommu_dma_get_sgtable(dev, sgt, cpu_addr, dma_addr,
> +				size, attrs);
>  	if (!ops->get_sgtable)
>  		return -ENXIO;
>  	return ops->get_sgtable(dev, sgt, cpu_addr, dma_addr, size, attrs);
> @@ -482,6 +520,8 @@ bool dma_can_mmap(struct device *dev)
>  
>  	if (dma_alloc_direct(dev, ops))
>  		return dma_direct_can_mmap(dev);
> +	if (dma_is_default_iommu(dev))
> +		return true;
>  	return ops->mmap != NULL;
>  }
>  EXPORT_SYMBOL_GPL(dma_can_mmap);
> @@ -508,6 +548,9 @@ int dma_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
>  	if (dma_alloc_direct(dev, ops))
>  		return dma_direct_mmap(dev, vma, cpu_addr, dma_addr, size,
>  				attrs);
> +	if (dma_is_default_iommu(dev))
> +		return iommu_dma_mmap(dev, vma, cpu_addr, dma_addr, size,
> +				      attrs);
>  	if (!ops->mmap)
>  		return -ENXIO;
>  	return ops->mmap(dev, vma, cpu_addr, dma_addr, size, attrs);
> @@ -559,6 +602,8 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
>  
>  	if (dma_alloc_direct(dev, ops))
>  		cpu_addr = dma_direct_alloc(dev, size, dma_handle, flag, attrs);
> +	else if (dma_is_default_iommu(dev))
> +		cpu_addr = iommu_dma_alloc(dev, size, dma_handle, flag, attrs);
>  	else if (ops->alloc)
>  		cpu_addr = ops->alloc(dev, size, dma_handle, flag, attrs);
>  	else
> @@ -591,6 +636,8 @@ void dma_free_attrs(struct device *dev, size_t size, void *cpu_addr,
>  	debug_dma_free_coherent(dev, size, cpu_addr, dma_handle);
>  	if (dma_alloc_direct(dev, ops))
>  		dma_direct_free(dev, size, cpu_addr, dma_handle, attrs);
> +	else if (dma_is_default_iommu(dev))
> +		iommu_dma_free(dev, size, cpu_addr, dma_handle, attrs);
>  	else if (ops->free)
>  		ops->free(dev, size, cpu_addr, dma_handle, attrs);
>  }
> @@ -611,6 +658,8 @@ static struct page *__dma_alloc_pages(struct device *dev, size_t size,
>  	size = PAGE_ALIGN(size);
>  	if (dma_alloc_direct(dev, ops))
>  		return dma_direct_alloc_pages(dev, size, dma_handle, dir, gfp);
> +	if (dma_is_default_iommu(dev))
> +		return dma_common_alloc_pages(dev, size, dma_handle, dir, gfp);
>  	if (!ops->alloc_pages_op)
>  		return NULL;
>  	return ops->alloc_pages_op(dev, size, dma_handle, dir, gfp);
> @@ -635,6 +684,8 @@ static void __dma_free_pages(struct device *dev, size_t size, struct page *page,
>  	size = PAGE_ALIGN(size);
>  	if (dma_alloc_direct(dev, ops))
>  		dma_direct_free_pages(dev, size, page, dma_handle, dir);
> +	else if (dma_is_default_iommu(dev))
> +		dma_common_free_pages(dev, size, page, dma_handle, dir);
>  	else if (ops->free_pages)
>  		ops->free_pages(dev, size, page, dma_handle, dir);
>  }
> @@ -697,6 +748,8 @@ struct sg_table *dma_alloc_noncontiguous(struct device *dev, size_t size,
>  
>  	if (ops && ops->alloc_noncontiguous)
>  		sgt = ops->alloc_noncontiguous(dev, size, dir, gfp, attrs);
> +	else if (dma_is_default_iommu(dev))
> +		sgt = iommu_dma_alloc_noncontiguous(dev, size, dir, gfp, attrs);
>  	else
>  		sgt = alloc_single_sgt(dev, size, dir, gfp);
>  
> @@ -725,6 +778,8 @@ void dma_free_noncontiguous(struct device *dev, size_t size,
>  	debug_dma_unmap_sg(dev, sgt->sgl, sgt->orig_nents, dir);
>  	if (ops && ops->free_noncontiguous)
>  		ops->free_noncontiguous(dev, size, sgt, dir);
> +	else if (dma_is_default_iommu(dev))
> +		iommu_dma_free_noncontiguous(dev, size, sgt, dir);
>  	else
>  		free_single_sgt(dev, size, sgt, dir);
>  }
> @@ -787,17 +842,14 @@ bool dma_pci_p2pdma_supported(struct device *dev)
>  {
>  	const struct dma_map_ops *ops = get_dma_ops(dev);
>  
> -	/* if ops is not set, dma direct will be used which supports P2PDMA */
> -	if (!ops)
> -		return true;
> -
>  	/*
>  	 * Note: dma_ops_bypass is not checked here because P2PDMA should
>  	 * not be used with dma mapping ops that do not have support even
>  	 * if the specific device is bypassing them.
>  	 */
>  
> -	return ops->flags & DMA_F_PCI_P2PDMA_SUPPORTED;
> +	/* if ops is not set, dma direct and default IOMMU support P2PDMA */
> +	return (!ops || dma_is_default_iommu(dev));
>  }
>  EXPORT_SYMBOL_GPL(dma_pci_p2pdma_supported);
>  
> @@ -865,6 +917,8 @@ size_t dma_max_mapping_size(struct device *dev)
>  
>  	if (dma_map_direct(dev, ops))
>  		size = dma_direct_max_mapping_size(dev);
> +	else if (dma_is_default_iommu(dev))
> +		size = iommu_dma_max_mapping_size(dev);
>  	else if (ops && ops->max_mapping_size)
>  		size = ops->max_mapping_size(dev);
>  
> @@ -877,9 +931,10 @@ size_t dma_opt_mapping_size(struct device *dev)
>  	const struct dma_map_ops *ops = get_dma_ops(dev);
>  	size_t size = SIZE_MAX;
>  
> -	if (ops && ops->opt_mapping_size)
> +	if (dma_is_default_iommu(dev))
> +		size = iommu_dma_opt_mapping_size();
> +	else if (ops && ops->opt_mapping_size)
>  		size = ops->opt_mapping_size();
> -
>  	return min(dma_max_mapping_size(dev), size);
>  }
>  EXPORT_SYMBOL_GPL(dma_opt_mapping_size);
> @@ -888,7 +943,12 @@ unsigned long dma_get_merge_boundary(struct device *dev)
>  {
>  	const struct dma_map_ops *ops = get_dma_ops(dev);
>  
> -	if (!ops || !ops->get_merge_boundary)
> +	if (!ops)
> +		return 0;	/* can't merge */
> +	if (dma_is_default_iommu(dev))
> +		return iommu_dma_get_merge_boundary(dev);
> +
> +	if (!ops->get_merge_boundary)
>  		return 0;	/* can't merge */
>  
>  	return ops->get_merge_boundary(dev);
> -- 
> 2.45.2
> 

