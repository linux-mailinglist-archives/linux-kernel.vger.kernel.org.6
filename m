Return-Path: <linux-kernel+bounces-284678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4486D9503FF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3DF21F246CB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514941991B5;
	Tue, 13 Aug 2024 11:46:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC641990CE
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 11:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723549590; cv=none; b=SDjcJo1rS6WaF55BeYrwxPunhf8w5b415knjIxE0jMUVDPgy3xOm/sygRQCKL869hOw/DXj/+jHiQp9jRFKgsFN6h/MOYu3J1pIfjgZOsnaKg9fOmEz8bCclSuxCPMDPuJSuXrjjZC8ilJa3P6m5YAldsd5ADae4Z4B4bTDT3qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723549590; c=relaxed/simple;
	bh=FkG8eAW9Ih4myl4ll11jeD/+VIhj+idpMSixGVmnH7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X138xmedMZyB9noIHqgq7j/56DHuegHylONdO8zMHA0y7jm0Bk9JbXxMbH7YIZ71ifZKXxeTqNXYChjpkknIWiX4YYtHJF8MuU6NPgT8zYfRp8KQ2NH/R8WzYVoYDNIkAXfK7EDIT+Hfs1DqOxAfVCh8pLDJE203GGflyAfVk5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BFFC12FC;
	Tue, 13 Aug 2024 04:46:54 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5115D3F587;
	Tue, 13 Aug 2024 04:46:27 -0700 (PDT)
Message-ID: <fc80ffde-2d19-4bd6-9590-a80049302ad7@arm.com>
Date: Tue, 13 Aug 2024 12:46:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iommu/arm-smmu-v3: Match Stall behaviour for S2
To: Mostafa Saleh <smostafa@google.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 will@kernel.org, joro@8bytes.org
Cc: jgg@ziepe.ca, nicolinc@nvidia.com, mshavit@google.com
References: <20240812205255.97781-1-smostafa@google.com>
 <20240812205255.97781-2-smostafa@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240812205255.97781-2-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/08/2024 9:52 pm, Mostafa Saleh wrote:
> S2S must be set when stall model is forced "ARM_SMMU_FEAT_STALL_FORCE".
> But at the moment the driver ignores that, instead of doing the minimum
> and only set S2S for “ARM_SMMU_FEAT_STALL_FORCE” we can just match what

This was highly confusing, until the 3rd reading when I realised that 
maybe "instead of..." does not in fact belong to the description of the 
current behaviour, and it does start making sense if you swap the 
previous comma and full stop with each other.

> S1 does which also set it for “ARM_SMMU_FEAT_STALL” and the master
> has requested stalls.
> This makes the driver more consistent when running on different SMMU
> instances with different supported stages.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 5 +++++
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 1 +
>   2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index a31460f9f3d4..8d573d9ca93c 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1562,6 +1562,11 @@ void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
>   		(cd_table->cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
>   		FIELD_PREP(STRTAB_STE_0_S1CDMAX, cd_table->s1cdmax));
>   
> +	/* S2S is ignored if stage-2 exists but not enabled. */
> +	if (master->stall_enabled &&
> +	    smmu->features & ARM_SMMU_FEAT_TRANS_S2)
> +		target->data[0] |= FIELD_PREP(STRTAB_STE_2_S2S, 1);

In the middle of the ASID?

Thanks,
Robin.

> +
>   	target->data[1] = cpu_to_le64(
>   		FIELD_PREP(STRTAB_STE_1_S1DSS, s1dss) |
>   		FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_WBRA) |
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 14bca41a981b..0dc7ad43c64c 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -267,6 +267,7 @@ struct arm_smmu_ste {
>   #define STRTAB_STE_2_S2AA64		(1UL << 51)
>   #define STRTAB_STE_2_S2ENDI		(1UL << 52)
>   #define STRTAB_STE_2_S2PTW		(1UL << 54)
> +#define STRTAB_STE_2_S2S		(1UL << 57)
>   #define STRTAB_STE_2_S2R		(1UL << 58)
>   
>   #define STRTAB_STE_3_S2TTB_MASK		GENMASK_ULL(51, 4)

