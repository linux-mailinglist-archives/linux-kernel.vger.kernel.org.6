Return-Path: <linux-kernel+bounces-511696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C378A32E6B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 19:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31BF71639D7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597EF2627FE;
	Wed, 12 Feb 2025 18:18:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5CE260A57
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 18:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739384302; cv=none; b=Z+55Yd/afA0yzRC1Y1PVdE9xsTKaqxT86xeeNBNYaEIcHHWhsP3u7I6xRa763XtfMDkiRIyzhco2p3zvKIDsp0AAjMF8qFVtX68ajr/dpBqoq2Doc4Zc1IzAKumg/TKlEKnqkKNuT9bTV4stbmPprMvekgK2u6aSyfXw8IY5oNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739384302; c=relaxed/simple;
	bh=JREQ/z2tc1QmgY0MYZnyTWu9WZ+Z7Rcm84RwuBV6sPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bz5br8408RPVak+fgK+ZPE8wAN0U+JitkyaO+sbAcM2EiDwFTrNG+vhkhi0lbQLpAsId6TkimhELFpAyXySDrdVfY3I0rQmeKk1fygB23vpCcRmr9/3zRegwBS1z4Il4LZak/74z+lOZBsgn/G2OBn/fqvc61eauccM2KLowMpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A518212FC;
	Wed, 12 Feb 2025 10:18:40 -0800 (PST)
Received: from [10.57.36.235] (unknown [10.57.36.235])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE5E93F58B;
	Wed, 12 Feb 2025 10:18:17 -0800 (PST)
Message-ID: <7ebe959b-132e-468a-bad5-5273427b6928@arm.com>
Date: Wed, 12 Feb 2025 18:18:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] arm64: realm: Use aliased addresses for device DMA to
 shared buffers
To: Suzuki K Poulose <suzuki.poulose@arm.com>, will@kernel.org,
 maz@kernel.org, catalin.marinas@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org, aneesh.kumar@kernel.org, steven.price@arm.com,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Christoph Hellwig <hch@lst.de>, Tom Lendacky <thomas.lendacky@amd.com>
References: <20250212171411.951874-1-suzuki.poulose@arm.com>
 <20250212171411.951874-2-suzuki.poulose@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250212171411.951874-2-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-02-12 5:14 pm, Suzuki K Poulose wrote:
> When a device performs DMA to a shared buffer using physical addresses,
> (without Stage1 translation), the device must use the "{I}PA address" with the
> top bit set in Realm. This is to make sure that a trusted device will be able
> to write to shared buffers as well as the protected buffers. Thus, a Realm must
> always program the full address including the "protection" bit, like AMD SME
> encryption bits.
> 
> Add the support for this by providing arm64 version of the phys_to_dma(). We
> cannot use the __sme_mask as it assumes the "encryption" always "sets a bit",
> which is the opposite for CCA. i.e., "set a bit" for "decrypted" address. So,
> move the common code that can be reused by all - i.e., add __phys_to_dma() and
> __dma_to_phys() - and do the arch specific processing.
> 
> Please note that the VMM needs to similarly make sure that the SMMU Stage2 in
> the Non-secure world is setup accordingly to map IPA at the unprotected alias.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Steven Price <steven.price@arm.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>   arch/arm64/Kconfig                  |  1 +
>   arch/arm64/include/asm/dma-direct.h | 38 +++++++++++++++++++++++++++++
>   include/linux/dma-direct.h          | 35 +++++++++++++++++---------
>   3 files changed, 62 insertions(+), 12 deletions(-)
>   create mode 100644 arch/arm64/include/asm/dma-direct.h
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index fcdd0ed3eca8..7befe04106de 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -41,6 +41,7 @@ config ARM64
>   	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
>   	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>   	select ARCH_HAS_NONLEAF_PMD_YOUNG if ARM64_HAFT
> +	select ARCH_HAS_PHYS_TO_DMA
>   	select ARCH_HAS_PTE_DEVMAP
>   	select ARCH_HAS_PTE_SPECIAL
>   	select ARCH_HAS_HW_PTE_YOUNG
> diff --git a/arch/arm64/include/asm/dma-direct.h b/arch/arm64/include/asm/dma-direct.h
> new file mode 100644
> index 000000000000..37c3270542b8
> --- /dev/null
> +++ b/arch/arm64/include/asm/dma-direct.h
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef __ASM_DMA_DIRECT_H
> +#define __ASM_DMA_DIRECT_H
> +
> +#include <asm/pgtable-prot.h>
> +
> +static inline unsigned long addr_to_shared(unsigned long addr)
> +{
> +	if (is_realm_world())
> +		addr |= prot_ns_shared;
> +	return addr;
> +}
> +
> +static inline unsigned long addr_to_private(unsigned long addr)
> +{
> +	if (is_realm_world())
> +		addr &= prot_ns_shared - 1;
> +	return addr;
> +}
> +
> +static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
> +{
> +	return __phys_to_dma(dev, paddr);
> +}
> +
> +static inline dma_addr_t phys_to_dma_unencrypted(struct device *dev,
> +						 phys_addr_t paddr)
> +{
> +	return addr_to_shared(__phys_to_dma(dev, paddr));
> +}
> +#define phys_to_dma_unencrypted phys_to_dma_unencrypted
> +
> +static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dma_addr)
> +{
> +	return addr_to_private(__dma_to_phys(dev, dma_addr));
> +}
> +
> +#endif	/* __ASM_DMA_DIRECT_H */
> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
> index d7e30d4f7503..3e9bf6ca640e 100644
> --- a/include/linux/dma-direct.h
> +++ b/include/linux/dma-direct.h
> @@ -72,18 +72,36 @@ static inline dma_addr_t dma_range_map_max(const struct bus_dma_region *map)
>   	return ret;
>   }
>   
> +static inline dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
> +{
> +	if (dev->dma_range_map)
> +		return translate_phys_to_dma(dev, paddr);
> +	return paddr;
> +}
> +
> +static inline phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dma_addr)
> +{
> +	phys_addr_t paddr;
> +
> +	if (dev->dma_range_map)
> +		paddr = translate_dma_to_phys(dev, dma_addr);
> +	else
> +		paddr = dma_addr;
> +
> +	return paddr;
> +}
> +
>   #ifdef CONFIG_ARCH_HAS_PHYS_TO_DMA
>   #include <asm/dma-direct.h>
>   #ifndef phys_to_dma_unencrypted
>   #define phys_to_dma_unencrypted		phys_to_dma
>   #endif
>   #else
> +
>   static inline dma_addr_t phys_to_dma_unencrypted(struct device *dev,
>   		phys_addr_t paddr)
>   {
> -	if (dev->dma_range_map)
> -		return translate_phys_to_dma(dev, paddr);
> -	return paddr;
> +	return __phys_to_dma(dev, paddr);
>   }
>   
>   /*
> @@ -94,19 +112,12 @@ static inline dma_addr_t phys_to_dma_unencrypted(struct device *dev,
>    */
>   static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
>   {
> -	return __sme_set(phys_to_dma_unencrypted(dev, paddr));
> +	return __sme_set(__phys_to_dma(dev, paddr));

Hmm, it really feels like we should generalise __sme_{set,clr} at this 
level, rather than drag in the entire ARCH_HAS_PHYS_TO_DMA override for 
the purposes of setting/clearing an address bit just because the 
"generic" mechanism for doing that is unashamedly AMD-specific.

Maybe something like:

#define dma_shared(x)  sme_clr(x)
#define dma_private(x) sme_set(x)

for x86, then go from there?

Thanks,
Robin.

>   }
>   
>   static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dma_addr)
>   {
> -	phys_addr_t paddr;
> -
> -	if (dev->dma_range_map)
> -		paddr = translate_dma_to_phys(dev, dma_addr);
> -	else
> -		paddr = dma_addr;
> -
> -	return __sme_clr(paddr);
> +	return __sme_clr(__dma_to_phys(dev, dma_addr));
>   }
>   #endif /* !CONFIG_ARCH_HAS_PHYS_TO_DMA */
>   


