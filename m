Return-Path: <linux-kernel+bounces-282601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F04594E64C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 07:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E20DF1F22448
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 05:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0E514E2D4;
	Mon, 12 Aug 2024 05:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Bjp8f1VE"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B2514D70F
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 05:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723441956; cv=none; b=HqM77k25ynYhwjtdF89E/vMGQTSxp0SGp7VJki8cWrE/V58slCs3p+6z3jJZI9cJ5Q1Fw9UyMDoRyyHIDlJiXN0jWwhfjg7rmdF5uJNqh0z9Ty/+2B0vQiFoarowm2Z+IhWyZdmB8Up+w4ZNQSmuO6tlbAyG5D7fvq46hz258JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723441956; c=relaxed/simple;
	bh=+jF/0UHCz+92Kn5b+ZdcYKfaZPYw3KWvlAIdXWehlHo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U6TEzVeT4gLe+p4S5z3XGo/01W5Ww4EqRa7C5UYnlo+6YTcDE7cpa1zYkllM9eqBVOWK21RfKNpwC/2fP53bTzBPf/UDmf5L0wWsP+nLM/TAi93QolaNgmmcQXh67Yx0S0YNe3GEDNuMobaPdQaXanwrDqCoXF3Ue3BbDHsZ8sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Bjp8f1VE; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7aa4ca9d72so473410766b.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 22:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723441951; x=1724046751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLZ35+IU8yTpW/0qUhS27F2h1YLsbUiAnfQoXC1WVeQ=;
        b=Bjp8f1VEbFWYNIJRFsQeyKqJ3RK6euHUJiO7s+AEGag/aTAcNMQJHXbbXIXoOB24Q+
         r1vElu5gF6A1gsLoPN15vMr6d1kuCMPbXL3lYSOdpGQXImsX6AFrCTj85OiRyaMK96ZE
         R6gg9y0YNA89QAiaX3KqaQQa/TekhmUS3fGVL6IpAmJg0ovd7MJoCbb+GeBGpVDDPIy2
         h1wZzyeAmqrhpY9sulvIRn7QxiSL+kU8e9LnxrOuFzNwHtliz+XZa1784Wn5aQAwmzt3
         /hZaegzyD6cH4AEceQZRHGgNsUplZhP+jryXJU+xV9vTiUFpiDnmYRmvSPI0Co1I1ujs
         VVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723441951; x=1724046751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLZ35+IU8yTpW/0qUhS27F2h1YLsbUiAnfQoXC1WVeQ=;
        b=OBVbzCjRdUCaHaVIwLZsawglx0Y56lWqY4nauMaaSEQ4xVNfUgM12snnNIcTxhuzhm
         FuhAD5js/Q7U0HuuDMHWfJNHPZQmUKmSYjljJ8ccjVJQ4FvY7yy7Cu7J2xHUsXrrv5CL
         z8uIgj1GeOKuI4mzU0cZsrq7zQtXQn6LVV+aPLMelq1egAl7lWxTlZFhD5ehGjBernka
         S1YDRcMaakk7+Gc6vS0m5IslmhOmyuDq4VSdNYfEDcGmvNWA6nCng1wn7Z556Q1DoXw0
         2H1FjJrd9i6+a1ZBlvtqe6jS8gGt2MLKjYYd0j0+Lc5rFXZMN/rdrRLdbBQjH9ISwssw
         V2RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfdl+2jpEz+nnijsAPZisms6EHryxuHvJq2vRU/WnArpXf9oANtIWvz46VfuiNYwedxKKbrrTNIv5Ti5W6+BznhUNlQFsvHe+1phsC
X-Gm-Message-State: AOJu0Yw6kOO92w3/HlCzzQ7aB6buaceFxO9Y0QfXuM0z9DlP2Rnp7BI7
	DBKOdnz7yKTtR2BSt2ghM7mLqK1XF+iDS4Nswmf0UH05J81srcCWB1CCoVGwxZU=
X-Google-Smtp-Source: AGHT+IFMvEB3G12c8wLUv6Tbdwb0/ALbjS7/MCfQmLzvHgcVkX7XPyPkeillfb+dwuofuhmb3Ikxng==
X-Received: by 2002:a17:907:846:b0:a7a:bae8:f29e with SMTP id a640c23a62f3a-a80aa5dae5bmr689141666b.29.1723441951081;
        Sun, 11 Aug 2024 22:52:31 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb11c75asm200467366b.97.2024.08.11.22.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 22:52:30 -0700 (PDT)
Date: Mon, 12 Aug 2024 07:52:29 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, Ramon Fried <ramon@neureality.ai>, Elad Nachman
 <enachman@marvell.com>, Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Subject: Re: [PATCH v6 RESED 1/2] dma: replace zone_dma_bits by
 zone_dma_limit
Message-ID: <20240812075229.7caf7bab@mordecai.tesarici.cz>
In-Reply-To: <17c067618b93e5d71f19c37826d54db4299621a3.1723359916.git.baruch@tkos.co.il>
References: <cover.1723359916.git.baruch@tkos.co.il>
	<17c067618b93e5d71f19c37826d54db4299621a3.1723359916.git.baruch@tkos.co.il>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 Aug 2024 10:09:35 +0300
Baruch Siach <baruch@tkos.co.il> wrote:

> From: Catalin Marinas <catalin.marinas@arm.com>
> 
> Hardware DMA limit might not be power of 2. When RAM range starts above
> 0, say 4GB, DMA limit of 30 bits should end at 5GB. A single high bit
> can not encode this limit.
> 
> Use plain address for DMA zone limit.
> 
> Since DMA zone can now potentially span beyond 4GB physical limit of
> DMA32, make sure to use DMA zone for GFP_DMA32 allocations in that case.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Co-developed-by: Baruch Siach <baruch@tkos.co.il>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

LGTM.

Reviewed-by: Petr Tesarik <ptesarik@suse.com>

Petr T

> ---
>  arch/arm64/mm/init.c       | 30 +++++++++++++++---------------
>  arch/powerpc/mm/mem.c      |  5 ++++-
>  arch/s390/mm/init.c        |  2 +-
>  include/linux/dma-direct.h |  2 +-
>  kernel/dma/direct.c        |  6 +++---
>  kernel/dma/pool.c          |  4 ++--
>  kernel/dma/swiotlb.c       |  6 +++---
>  7 files changed, 29 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 9b5ab6818f7f..c45e2152ca9e 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -115,35 +115,35 @@ static void __init arch_reserve_crashkernel(void)
>  }
>  
>  /*
> - * Return the maximum physical address for a zone accessible by the given bits
> - * limit. If DRAM starts above 32-bit, expand the zone to the maximum
> + * Return the maximum physical address for a zone given its limit.
> + * If DRAM starts above 32-bit, expand the zone to the maximum
>   * available memory, otherwise cap it at 32-bit.
>   */
> -static phys_addr_t __init max_zone_phys(unsigned int zone_bits)
> +static phys_addr_t __init max_zone_phys(phys_addr_t zone_limit)
>  {
> -	phys_addr_t zone_mask = DMA_BIT_MASK(zone_bits);
>  	phys_addr_t phys_start = memblock_start_of_DRAM();
>  
>  	if (phys_start > U32_MAX)
> -		zone_mask = PHYS_ADDR_MAX;
> -	else if (phys_start > zone_mask)
> -		zone_mask = U32_MAX;
> +		zone_limit = PHYS_ADDR_MAX;
> +	else if (phys_start > zone_limit)
> +		zone_limit = U32_MAX;
>  
> -	return min(zone_mask, memblock_end_of_DRAM() - 1) + 1;
> +	return min(zone_limit, memblock_end_of_DRAM() - 1) + 1;
>  }
>  
>  static void __init zone_sizes_init(void)
>  {
>  	unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};
> -	unsigned int __maybe_unused acpi_zone_dma_bits;
> -	unsigned int __maybe_unused dt_zone_dma_bits;
> -	phys_addr_t __maybe_unused dma32_phys_limit = max_zone_phys(32);
> +	phys_addr_t __maybe_unused acpi_zone_dma_limit;
> +	phys_addr_t __maybe_unused dt_zone_dma_limit;
> +	phys_addr_t __maybe_unused dma32_phys_limit =
> +		max_zone_phys(DMA_BIT_MASK(32));
>  
>  #ifdef CONFIG_ZONE_DMA
> -	acpi_zone_dma_bits = fls64(acpi_iort_dma_get_max_cpu_address());
> -	dt_zone_dma_bits = fls64(of_dma_get_max_cpu_address(NULL));
> -	zone_dma_bits = min3(32U, dt_zone_dma_bits, acpi_zone_dma_bits);
> -	arm64_dma_phys_limit = max_zone_phys(zone_dma_bits);
> +	acpi_zone_dma_limit = acpi_iort_dma_get_max_cpu_address();
> +	dt_zone_dma_limit = of_dma_get_max_cpu_address(NULL);
> +	zone_dma_limit = min(dt_zone_dma_limit, acpi_zone_dma_limit);
> +	arm64_dma_phys_limit = max_zone_phys(zone_dma_limit);
>  	max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
>  #endif
>  #ifdef CONFIG_ZONE_DMA32
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index d325217ab201..05b7f702b3f7 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -216,7 +216,7 @@ static int __init mark_nonram_nosave(void)
>   * everything else. GFP_DMA32 page allocations automatically fall back to
>   * ZONE_DMA.
>   *
> - * By using 31-bit unconditionally, we can exploit zone_dma_bits to inform the
> + * By using 31-bit unconditionally, we can exploit zone_dma_limit to inform the
>   * generic DMA mapping code.  32-bit only devices (if not handled by an IOMMU
>   * anyway) will take a first dip into ZONE_NORMAL and get otherwise served by
>   * ZONE_DMA.
> @@ -230,6 +230,7 @@ void __init paging_init(void)
>  {
>  	unsigned long long total_ram = memblock_phys_mem_size();
>  	phys_addr_t top_of_ram = memblock_end_of_DRAM();
> +	int zone_dma_bits;
>  
>  #ifdef CONFIG_HIGHMEM
>  	unsigned long v = __fix_to_virt(FIX_KMAP_END);
> @@ -256,6 +257,8 @@ void __init paging_init(void)
>  	else
>  		zone_dma_bits = 31;
>  
> +	zone_dma_limit = DMA_BIT_MASK(zone_dma_bits);
> +
>  #ifdef CONFIG_ZONE_DMA
>  	max_zone_pfns[ZONE_DMA]	= min(max_low_pfn,
>  				      1UL << (zone_dma_bits - PAGE_SHIFT));
> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> index ddcd39ef4346..91fc2b91adfc 100644
> --- a/arch/s390/mm/init.c
> +++ b/arch/s390/mm/init.c
> @@ -97,7 +97,7 @@ void __init paging_init(void)
>  
>  	vmem_map_init();
>  	sparse_init();
> -	zone_dma_bits = 31;
> +	zone_dma_limit = DMA_BIT_MASK(31);
>  	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
>  	max_zone_pfns[ZONE_DMA] = virt_to_pfn(MAX_DMA_ADDRESS);
>  	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
> index edbe13d00776..d7e30d4f7503 100644
> --- a/include/linux/dma-direct.h
> +++ b/include/linux/dma-direct.h
> @@ -12,7 +12,7 @@
>  #include <linux/mem_encrypt.h>
>  #include <linux/swiotlb.h>
>  
> -extern unsigned int zone_dma_bits;
> +extern u64 zone_dma_limit;
>  
>  /*
>   * Record the mapping of CPU physical to DMA addresses for a given region.
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 4480a3cd92e0..f2ba074a6a54 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -20,7 +20,7 @@
>   * it for entirely different regions. In that case the arch code needs to
>   * override the variable below for dma-direct to work properly.
>   */
> -unsigned int zone_dma_bits __ro_after_init = 24;
> +u64 zone_dma_limit __ro_after_init = DMA_BIT_MASK(24);
>  
>  static inline dma_addr_t phys_to_dma_direct(struct device *dev,
>  		phys_addr_t phys)
> @@ -59,7 +59,7 @@ static gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 *phys_limit)
>  	 * zones.
>  	 */
>  	*phys_limit = dma_to_phys(dev, dma_limit);
> -	if (*phys_limit <= DMA_BIT_MASK(zone_dma_bits))
> +	if (*phys_limit <= zone_dma_limit)
>  		return GFP_DMA;
>  	if (*phys_limit <= DMA_BIT_MASK(32))
>  		return GFP_DMA32;
> @@ -580,7 +580,7 @@ int dma_direct_supported(struct device *dev, u64 mask)
>  	 * part of the check.
>  	 */
>  	if (IS_ENABLED(CONFIG_ZONE_DMA))
> -		min_mask = min_t(u64, min_mask, DMA_BIT_MASK(zone_dma_bits));
> +		min_mask = min_t(u64, min_mask, zone_dma_limit);
>  	return mask >= phys_to_dma_unencrypted(dev, min_mask);
>  }
>  
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index d10613eb0f63..7b04f7575796 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -70,9 +70,9 @@ static bool cma_in_zone(gfp_t gfp)
>  	/* CMA can't cross zone boundaries, see cma_activate_area() */
>  	end = cma_get_base(cma) + size - 1;
>  	if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp & GFP_DMA))
> -		return end <= DMA_BIT_MASK(zone_dma_bits);
> +		return end <= zone_dma_limit;
>  	if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp & GFP_DMA32))
> -		return end <= DMA_BIT_MASK(32);
> +		return end <= max(DMA_BIT_MASK(32), zone_dma_limit);
>  	return true;
>  }
>  
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index df68d29740a0..abcf3fa63a56 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -450,9 +450,9 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
>  	if (!remap)
>  		io_tlb_default_mem.can_grow = true;
>  	if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp_mask & __GFP_DMA))
> -		io_tlb_default_mem.phys_limit = DMA_BIT_MASK(zone_dma_bits);
> +		io_tlb_default_mem.phys_limit = zone_dma_limit;
>  	else if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp_mask & __GFP_DMA32))
> -		io_tlb_default_mem.phys_limit = DMA_BIT_MASK(32);
> +		io_tlb_default_mem.phys_limit = max(DMA_BIT_MASK(32), zone_dma_limit);
>  	else
>  		io_tlb_default_mem.phys_limit = virt_to_phys(high_memory - 1);
>  #endif
> @@ -629,7 +629,7 @@ static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
>  	}
>  
>  	gfp &= ~GFP_ZONEMASK;
> -	if (phys_limit <= DMA_BIT_MASK(zone_dma_bits))
> +	if (phys_limit <= zone_dma_limit)
>  		gfp |= __GFP_DMA;
>  	else if (phys_limit <= DMA_BIT_MASK(32))
>  		gfp |= __GFP_DMA32;


