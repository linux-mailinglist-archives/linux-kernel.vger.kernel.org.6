Return-Path: <linux-kernel+bounces-550302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B32A55DB6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 03:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F17203B4BA5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 02:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6697915E5AE;
	Fri,  7 Mar 2025 02:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OPru8tbs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF5E14F90
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 02:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741314692; cv=none; b=a6CQ5rW+zvraqsTW8JcjEYg8veosEDVGO3rO7JFbJ4lC4GtC7M+1SzcH0aSsioVLEYXJgMhmDdr45qnVPVapKgkU/NHX6QKQMaGPAbH3PgDQQY26T5UESOZuKbJhjTPDi2NZRfnnEGNFXJnBJAYDSSmDWdXBbXgOtbjaHiOQRts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741314692; c=relaxed/simple;
	bh=33xmGYM9rKfYOIraEg//ke1v96sAZt3vXnoJsFqpgMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pg+KohjsWddwh0FhbcEmRQrXCD5W9mrgwK84w9VquFOuPeLybq3SlRyq8GwEVfCqactrMoxLlrejl5DYCPHHZNO2WGlD5P+QpK8ptiQssGSZTJWdyZP8nqZjjsAD782eaw/H8Hb4KCQslwvcIKp6wtUQ1wgl2vOJRkFZ+kpiVSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OPru8tbs; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741314690; x=1772850690;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=33xmGYM9rKfYOIraEg//ke1v96sAZt3vXnoJsFqpgMo=;
  b=OPru8tbsXO94+AuPuaDw63vVMH9ECDOLm1wlRvP6KMT6KgBhJXPQBMmC
   E+VPMLK4jjXOAEjzK1eCtymN7YUpM2l7sEEy1y20NIme5t1+iAbq4iQd/
   +1ZG5uRvRseVvmedahNoA5lIbDQJFa0fVx/ctXAlb18CXeOBzv7kGYLQm
   8apZiNptucLGu4Mm3iwBwwD9C9tLo3qFaNYvh9qUonn2oN5PSpKoLQlhc
   KMnD/UNXAeHfuoifYWz4eDI1D8z1VqVNLa/B/lyNw6A7jIvJ9KkDHkaNV
   KJs9PJ/KJca+RwsVapkx6bSVwfE4uze6in8B1YhoreGzSe4r9LhdtKhde
   A==;
X-CSE-ConnectionGUID: hBbaQGU1TuOHF8vbdu/RTw==
X-CSE-MsgGUID: wzNvRxptQfKPuoToIRZFoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="41604269"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="41604269"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 18:31:30 -0800
X-CSE-ConnectionGUID: 9EccSzcPTaqVd9I/FVNy2A==
X-CSE-MsgGUID: EY/03IJQTyq/FCNMrf6jDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="124230492"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 18:31:27 -0800
Message-ID: <fabd6483-af48-4893-b539-2835640c5316@linux.intel.com>
Date: Fri, 7 Mar 2025 10:28:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] iommu: Sort out domain user data
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com,
 robin.murphy@arm.com, joro@8bytes.org, will@kernel.org
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1741294235.git.nicolinc@nvidia.com>
 <da7cc6d365ec6a77f6e6007f898eb3de2e581f80.1741294235.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <da7cc6d365ec6a77f6e6007f898eb3de2e581f80.1741294235.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/7/25 05:00, Nicolin Chen wrote:
> From: Robin Murphy<robin.murphy@arm.com>
> 
> When DMA/MSI cookies were made first-class citizens back in commit
> 46983fcd67ac ("iommu: Pull IOVA cookie management into the core"), there
> was no real need to further expose the two different cookie types.
> However, now that IOMMUFD wants to add a third type of MSI-mapping
> cookie, we do have a nicely compelling reason to properly dismabiguate
> things at the domain level beyond just vaguely guessing from the domain
> type.
> 
> Meanwhile, we also effectively have another "cookie" in the form of the
> anonymous union for other user data, which isn't much better in terms of
> being vague and unenforced. The fact is that all these cookie types are
> mutually exclusive, in the sense that combining them makes zero sense
> and/or would be catastrophic (iommu_set_fault_handler() on an SVA
> domain, anyone?) - the only combination which*might* be reasonable is
> perhaps a fault handler and an MSI cookie, but nobody's doing that at
> the moment, so let's rule it out as well for the sake of being clear and
> robust. To that end, we pull DMA and MSI cookies apart a little more,
> mostly to clear up the ambiguity at domain teardown, then for clarity
> (and to save a little space), move them into the union, whose ownership
> we can then properly describe and enforce entirely unambiguously.
> 
> Signed-off-by: Robin Murphy<robin.murphy@arm.com>
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> [nicolinc: rebase on latest tree; use prefix IOMMU_COOKIE_; merge unions
>             in iommu_domain; add IOMMU_COOKIE_IOMMUFD for iommufd_hwpt]
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> ---
>   drivers/iommu/dma-iommu.h            |   5 +
>   include/linux/iommu.h                |  20 ++-
>   drivers/iommu/dma-iommu.c            | 194 ++++++++++++++-------------
>   drivers/iommu/iommu-sva.c            |   1 +
>   drivers/iommu/iommu.c                |  18 ++-
>   drivers/iommu/iommufd/hw_pagetable.c |   3 +
>   6 files changed, 143 insertions(+), 98 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.h b/drivers/iommu/dma-iommu.h
> index c12d63457c76..9cca11806e5d 100644
> --- a/drivers/iommu/dma-iommu.h
> +++ b/drivers/iommu/dma-iommu.h
> @@ -13,6 +13,7 @@ void iommu_setup_dma_ops(struct device *dev);
>   
>   int iommu_get_dma_cookie(struct iommu_domain *domain);
>   void iommu_put_dma_cookie(struct iommu_domain *domain);
> +void iommu_put_msi_cookie(struct iommu_domain *domain);
>   
>   int iommu_dma_init_fq(struct iommu_domain *domain);
>   
> @@ -40,6 +41,10 @@ static inline void iommu_put_dma_cookie(struct iommu_domain *domain)
>   {
>   }
>   
> +static inline void iommu_put_msi_cookie(struct iommu_domain *domain)
> +{
> +}
> +
>   static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
>   {
>   }
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index e93d2e918599..06cc14e9993d 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -41,6 +41,7 @@ struct iommu_dirty_ops;
>   struct notifier_block;
>   struct iommu_sva;
>   struct iommu_dma_cookie;
> +struct iommu_dma_msi_cookie;
>   struct iommu_fault_param;
>   struct iommufd_ctx;
>   struct iommufd_viommu;
> @@ -165,6 +166,15 @@ struct iommu_domain_geometry {
>   	bool force_aperture;       /* DMA only allowed in mappable range? */
>   };
>   
> +enum iommu_domain_cookie_type {
> +	IOMMU_COOKIE_NONE,
> +	IOMMU_COOKIE_DMA_IOVA,
> +	IOMMU_COOKIE_DMA_MSI,
> +	IOMMU_COOKIE_FAULT_HANDLER,
> +	IOMMU_COOKIE_SVA,
> +	IOMMU_COOKIE_IOMMUFD,
> +};
> +
>   /* Domain feature flags */
>   #define __IOMMU_DOMAIN_PAGING	(1U << 0)  /* Support for iommu_map/unmap */
>   #define __IOMMU_DOMAIN_DMA_API	(1U << 1)  /* Domain for use in DMA-API
> @@ -211,12 +221,12 @@ struct iommu_domain_geometry {
>   
>   struct iommu_domain {
>   	unsigned type;
> +	enum iommu_domain_cookie_type cookie_type;
>   	const struct iommu_domain_ops *ops;
>   	const struct iommu_dirty_ops *dirty_ops;
>   	const struct iommu_ops *owner; /* Whose domain_alloc we came from */
>   	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
>   	struct iommu_domain_geometry geometry;
> -	struct iommu_dma_cookie *iova_cookie;
>   	int (*iopf_handler)(struct iopf_group *group);
>   
>   #if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
> @@ -224,10 +234,10 @@ struct iommu_domain {
>   		      phys_addr_t msi_addr);
>   #endif
>   
> -	union { /* Pointer usable by owner of the domain */
> -		struct iommufd_hw_pagetable *iommufd_hwpt; /* iommufd */
> -	};
> -	union { /* Fault handler */
> +	union { /* cookie */
> +		struct iommu_dma_cookie *iova_cookie;
> +		struct iommu_dma_msi_cookie *msi_cookie;
> +		struct iommufd_hw_pagetable *iommufd_hwpt;
>   		struct {
>   			iommu_fault_handler_t handler;
>   			void *handler_token;

My feeling is that IOMMU_COOKIE_FAULT_HANDLER isn't exclusive to
IOMMU_COOKIE_DMA_IOVA; both might be used for kernel DMA with a paging
domain.

I am afraid that iommu_set_fault_handler() doesn't work anymore as the
domain's cookie type has already been set to IOMMU_COOKIE_DMA_IOVA.

void iommu_set_fault_handler(struct iommu_domain *domain,
                                         iommu_fault_handler_t handler,
                                         void *token)
{
         if (WARN_ON(!domain || domain->cookie_type != IOMMU_COOKIE_NONE))
                 return;

         domain->cookie_type = IOMMU_COOKIE_FAULT_HANDLER;
         domain->handler = handler;
         domain->handler_token = token;
}
EXPORT_SYMBOL_GPL(iommu_set_fault_handler);

Anybody has a chance to test whether above WARN_ON will be triggered?

Thanks,
baolu

