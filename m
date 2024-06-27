Return-Path: <linux-kernel+bounces-231916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6AF91A050
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA0B01C214AB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C7D4D8A2;
	Thu, 27 Jun 2024 07:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="Wy6f4jxC"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A5A481DB
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 07:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719472855; cv=none; b=fQh9Oq7lamRb/G2GBwBr6rm3OGAcroDZzWWeE/WcpMalD+AkQoO9mIN2fGNe1b+Pe8i7fG0okxWz9PknUjQg0463+ljYEvfl4osh0iNM3kk0e34nRmacsc+GeZ92tlSkHdfIbTTUO3S/O3YhyNDEsVf7CMNj61OcBzjCVwoJDy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719472855; c=relaxed/simple;
	bh=cR9FEKCa2gS2z+8cfqQdZ6GM82VUSMMa/7sy/fvCqXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TZbGYto0Z2ZGq0apoUqYS6mZOXd4mqnAX08MTahMuQO8Zx6YD8RzQiVXl11CUfv8vrpNWcyFfcYqFRfwxc4GBSa6TY3rMJXxT98Jd1cpuOv2zMB1dwaJo4v/d2/wsa4qBhZ3FpFgNEjWE2nsF7u6eOPRtgCfFnH17oGYYhrpW4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=Wy6f4jxC; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id B4DF91D69E7;
	Thu, 27 Jun 2024 09:20:49 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1719472849; bh=DTI2vKAaPElhD/HmfPpLCB/eYaiu2AD162KN4TedODc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Wy6f4jxCvx2KElFgvo2FeiER2+AWkeP6jmjpKkqw3DKZDFugiJsLOI3l2du2PPKe9
	 SA0vAxWRN7DHcaCnlWuD/fog4FyFf376PY1FONrJJFz37CstS5k1Kp1N/UrdDtQDK1
	 lE7AThyFR8O1BtpmNpjbkHNEgMCDMri9S/fW4vT/pK3mlPEsMyVd00wLOoNX5CKz1C
	 V131ap92UHIUfhKw33g/+OGwxvYTGqjFoy+/2Ntp1lxdxmjc95R3qh6nCzUJshGq/c
	 VbV7umsqzkHIhWPgeo0flPaFAJRUvhnwB/gYYvfeE9nG1SVCZ+K2dYcj3Kw2vlysRr
	 vg5aLMmV07ycQ==
Date: Thu, 27 Jun 2024 09:20:49 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: mhkelley58@gmail.com
Cc: mhklinux@outlook.com, robin.murphy@arm.com, joro@8bytes.org,
 will@kernel.org, jgross@suse.com, sstabellini@kernel.org,
 oleksandr_tyshchenko@epam.com, hch@lst.de, m.szyprowski@samsung.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 xen-devel@lists.xenproject.org
Subject: Re: [RFC 1/1] swiotlb: Reduce calls to swiotlb_find_pool()
Message-ID: <20240627092049.1dbec746@meshulam.tesarici.cz>
In-Reply-To: <20240607031421.182589-1-mhklinux@outlook.com>
References: <20240607031421.182589-1-mhklinux@outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Jun 2024 20:14:21 -0700
mhkelley58@gmail.com wrote:

> From: Michael Kelley <mhklinux@outlook.com>
> 
> With CONFIG_SWIOTLB_DYNAMIC enabled, each round-trip map/unmap pair
> in the swiotlb results in 6 calls to swiotlb_find_pool(). In multiple
> places, the pool is found and used in one function, and then must
> found again in the next function that is called because only the
> tlb_addr is passed as an argument. These are the six call sites:
> 
> dma_direct_map_page:
> 1. swiotlb_map->swiotlb_tbl_map_single->swiotlb_bounce
> 
> dma_direct_unmap_page:
> 2. dma_direct_sync_single_for_cpu->is_swiotlb_buffer
> 3. dma_direct_sync_single_for_cpu->swiotlb_sync_single_for_cpu->
> 	swiotlb_bounce
> 4. is_swiotlb_buffer
> 5. swiotlb_tbl_unmap_single->swiotlb_del_transient
> 6. swiotlb_tbl_unmap_single->swiotlb_release_slots
> 
> Reduce the number of calls by finding the pool at a higher level, and
> passing it as an argument instead of searching again. A key change is
> for is_swiotlb_buffer() to return a pool pointer instead of a boolean,
> and then pass this pool pointer to subsequent swiotlb functions.
> With these changes, a round-trip map/unmap pair requires only 2 calls
> to swiotlb_find_pool():
> 
> dma_direct_unmap_page:
> 1. dma_direct_sync_single_for_cpu->is_swiotlb_buffer
> 2. is_swiotlb_buffer
> 
> These changes come from noticing the inefficiencies in a code review,
> not from performance measurements. With CONFIG_SWIOTLB_DYNAMIC,
> swiotlb_find_pool() is not trivial, and it uses an RCU read lock,
> so avoiding the redundant calls helps performance in a hot path.
> When CONFIG_SWIOTLB_DYNAMIC is *not* set, the code size reduction
> is minimal and the perf benefits are likely negligible, but no
> harm is done.
> 
> No functional change is intended.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
> This patch trades off making many of the core swiotlb APIs take
> an additional argument in order to avoid duplicating calls to
> swiotlb_find_pool(). The current code seems rather wasteful in
> making 6 calls per round-trip, but I'm happy to accept others'
> judgment as to whether getting rid of the waste is worth the
> additional code complexity.
> 
>  drivers/iommu/dma-iommu.c | 27 ++++++++++++++------
>  drivers/xen/swiotlb-xen.c | 25 +++++++++++-------
>  include/linux/swiotlb.h   | 54 +++++++++++++++++++++------------------
>  kernel/dma/direct.c       | 12 ++++++---
>  kernel/dma/direct.h       | 18 ++++++++-----
>  kernel/dma/swiotlb.c      | 43 ++++++++++++++++---------------
>  6 files changed, 106 insertions(+), 73 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index f731e4b2a417..ab6bc37ecf90 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1073,6 +1073,7 @@ static void iommu_dma_sync_single_for_cpu(struct device *dev,
>  		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
>  {
>  	phys_addr_t phys;
> +	struct io_tlb_pool *pool;
>  
>  	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev, size, dir))
>  		return;
> @@ -1081,21 +1082,25 @@ static void iommu_dma_sync_single_for_cpu(struct device *dev,
>  	if (!dev_is_dma_coherent(dev))
>  		arch_sync_dma_for_cpu(phys, size, dir);
>  
> -	if (is_swiotlb_buffer(dev, phys))
> -		swiotlb_sync_single_for_cpu(dev, phys, size, dir);
> +	pool = is_swiotlb_buffer(dev, phys);
> +	if (pool)
> +		swiotlb_sync_single_for_cpu(dev, phys, size, dir, pool);
>  }
>  
>  static void iommu_dma_sync_single_for_device(struct device *dev,
>  		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
>  {
>  	phys_addr_t phys;
> +	struct io_tlb_pool *pool;
>  
>  	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev, size, dir))
>  		return;
>  
>  	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
> -	if (is_swiotlb_buffer(dev, phys))
> -		swiotlb_sync_single_for_device(dev, phys, size, dir);
> +
> +	pool = is_swiotlb_buffer(dev, phys);
> +	if (pool)
> +		swiotlb_sync_single_for_device(dev, phys, size, dir, pool);
>  
>  	if (!dev_is_dma_coherent(dev))
>  		arch_sync_dma_for_device(phys, size, dir);
> @@ -1189,8 +1194,12 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
>  		arch_sync_dma_for_device(phys, size, dir);
>  
>  	iova = __iommu_dma_map(dev, phys, size, prot, dma_mask);
> -	if (iova == DMA_MAPPING_ERROR && is_swiotlb_buffer(dev, phys))
> -		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
> +	if (iova == DMA_MAPPING_ERROR) {
> +		struct io_tlb_pool *pool = is_swiotlb_buffer(dev, phys);
> +
> +		if (pool)
> +			swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs, pool);
> +	}
>  	return iova;
>  }
>  
> @@ -1199,6 +1208,7 @@ static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
>  {
>  	struct iommu_domain *domain = iommu_get_dma_domain(dev);
>  	phys_addr_t phys;
> +	struct io_tlb_pool *pool;
>  
>  	phys = iommu_iova_to_phys(domain, dma_handle);
>  	if (WARN_ON(!phys))
> @@ -1209,8 +1219,9 @@ static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
>  
>  	__iommu_dma_unmap(dev, dma_handle, size);
>  
> -	if (unlikely(is_swiotlb_buffer(dev, phys)))
> -		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
> +	pool = is_swiotlb_buffer(dev, phys);
> +	if (unlikely(pool))
> +		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs, pool);
>  }
>  
>  /*
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index 6579ae3f6dac..7af8c8466e1d 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -88,7 +88,7 @@ static inline int range_straddles_page_boundary(phys_addr_t p, size_t size)
>  	return 0;
>  }
>  
> -static int is_xen_swiotlb_buffer(struct device *dev, dma_addr_t dma_addr)
> +static struct io_tlb_pool *is_xen_swiotlb_buffer(struct device *dev, dma_addr_t dma_addr)
>  {
>  	unsigned long bfn = XEN_PFN_DOWN(dma_to_phys(dev, dma_addr));
>  	unsigned long xen_pfn = bfn_to_local_pfn(bfn);
> @@ -100,7 +100,7 @@ static int is_xen_swiotlb_buffer(struct device *dev, dma_addr_t dma_addr)
>  	 */
>  	if (pfn_valid(PFN_DOWN(paddr)))
>  		return is_swiotlb_buffer(dev, paddr);
> -	return 0;
> +	return NULL;
>  }
>  
>  #ifdef CONFIG_X86
> @@ -228,7 +228,8 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
>  	 */
>  	if (unlikely(!dma_capable(dev, dev_addr, size, true))) {
>  		swiotlb_tbl_unmap_single(dev, map, size, dir,
> -				attrs | DMA_ATTR_SKIP_CPU_SYNC);
> +				attrs | DMA_ATTR_SKIP_CPU_SYNC,
> +				swiotlb_find_pool(dev, map));
>  		return DMA_MAPPING_ERROR;
>  	}
>  
> @@ -254,6 +255,7 @@ static void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
>  		size_t size, enum dma_data_direction dir, unsigned long attrs)
>  {
>  	phys_addr_t paddr = xen_dma_to_phys(hwdev, dev_addr);
> +	struct io_tlb_pool *pool;
>  
>  	BUG_ON(dir == DMA_NONE);
>  
> @@ -265,8 +267,9 @@ static void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
>  	}
>  
>  	/* NOTE: We use dev_addr here, not paddr! */
> -	if (is_xen_swiotlb_buffer(hwdev, dev_addr))
> -		swiotlb_tbl_unmap_single(hwdev, paddr, size, dir, attrs);
> +	pool = is_xen_swiotlb_buffer(hwdev, dev_addr);
> +	if (pool)
> +		swiotlb_tbl_unmap_single(hwdev, paddr, size, dir, attrs, pool);
>  }
>  
>  static void
> @@ -274,6 +277,7 @@ xen_swiotlb_sync_single_for_cpu(struct device *dev, dma_addr_t dma_addr,
>  		size_t size, enum dma_data_direction dir)
>  {
>  	phys_addr_t paddr = xen_dma_to_phys(dev, dma_addr);
> +	struct io_tlb_pool *pool;
>  
>  	if (!dev_is_dma_coherent(dev)) {
>  		if (pfn_valid(PFN_DOWN(dma_to_phys(dev, dma_addr))))
> @@ -282,8 +286,9 @@ xen_swiotlb_sync_single_for_cpu(struct device *dev, dma_addr_t dma_addr,
>  			xen_dma_sync_for_cpu(dev, dma_addr, size, dir);
>  	}
>  
> -	if (is_xen_swiotlb_buffer(dev, dma_addr))
> -		swiotlb_sync_single_for_cpu(dev, paddr, size, dir);
> +	pool = is_xen_swiotlb_buffer(dev, dma_addr);
> +	if (pool)
> +		swiotlb_sync_single_for_cpu(dev, paddr, size, dir, pool);
>  }
>  
>  static void
> @@ -291,9 +296,11 @@ xen_swiotlb_sync_single_for_device(struct device *dev, dma_addr_t dma_addr,
>  		size_t size, enum dma_data_direction dir)
>  {
>  	phys_addr_t paddr = xen_dma_to_phys(dev, dma_addr);
> +	struct io_tlb_pool *pool;
>  
> -	if (is_xen_swiotlb_buffer(dev, dma_addr))
> -		swiotlb_sync_single_for_device(dev, paddr, size, dir);
> +	pool = is_xen_swiotlb_buffer(dev, dma_addr);
> +	if (pool)
> +		swiotlb_sync_single_for_device(dev, paddr, size, dir, pool);
>  
>  	if (!dev_is_dma_coherent(dev)) {
>  		if (pfn_valid(PFN_DOWN(dma_to_phys(dev, dma_addr))))
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 14bc10c1bb23..ce8651949123 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -42,24 +42,6 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
>  	int (*remap)(void *tlb, unsigned long nslabs));
>  extern void __init swiotlb_update_mem_attributes(void);
>  
> -phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t phys,
> -		size_t mapping_size,
> -		unsigned int alloc_aligned_mask, enum dma_data_direction dir,
> -		unsigned long attrs);
> -
> -extern void swiotlb_tbl_unmap_single(struct device *hwdev,
> -				     phys_addr_t tlb_addr,
> -				     size_t mapping_size,
> -				     enum dma_data_direction dir,
> -				     unsigned long attrs);
> -
> -void swiotlb_sync_single_for_device(struct device *dev, phys_addr_t tlb_addr,
> -		size_t size, enum dma_data_direction dir);
> -void swiotlb_sync_single_for_cpu(struct device *dev, phys_addr_t tlb_addr,
> -		size_t size, enum dma_data_direction dir);
> -dma_addr_t swiotlb_map(struct device *dev, phys_addr_t phys,
> -		size_t size, enum dma_data_direction dir, unsigned long attrs);
> -
>  #ifdef CONFIG_SWIOTLB
>  
>  /**
> @@ -168,12 +150,12 @@ static inline struct io_tlb_pool *swiotlb_find_pool(struct device *dev,
>   * * %true if @paddr points into a bounce buffer
>   * * %false otherwise
>   */
> -static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
> +static inline struct io_tlb_pool *is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
>  {
>  	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
>  
>  	if (!mem)
> -		return false;
> +		return NULL;
>  
>  #ifdef CONFIG_SWIOTLB_DYNAMIC
>  	/*
> @@ -187,10 +169,13 @@ static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
>  	 * This barrier pairs with smp_mb() in swiotlb_find_slots().
>  	 */
>  	smp_rmb();
> -	return READ_ONCE(dev->dma_uses_io_tlb) &&
> -		swiotlb_find_pool(dev, paddr);
> +	if (READ_ONCE(dev->dma_uses_io_tlb))
> +		return swiotlb_find_pool(dev, paddr);
> +	return NULL;
>  #else
> -	return paddr >= mem->defpool.start && paddr < mem->defpool.end;
> +	if (paddr >= mem->defpool.start && paddr < mem->defpool.end)
> +		return &mem->defpool;

Why are we open-coding swiotlb_find_pool() here? It does not make a
difference now, but if swiotlb_find_pool() were to change, both places
would have to be updated.

Does it save a reload from dev->dma_io_tlb_mem? IOW is the compiler
unable to optimize it away?

What about this (functionally identical) variant:

#ifdef CONFIG_SWIOTLB_DYNAMIC
	smp_rmb();
	if (!READ_ONCE(dev->dma_uses_io_tlb))
		return NULL;
#else
	if (paddr < mem->defpool.start || paddr >= mem->defpool.end);
		return NULL;
#endif

	return swiotlb_find_pool(dev, paddr);

Petr T

