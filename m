Return-Path: <linux-kernel+bounces-536626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7DDA48231
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BC18189FD4D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3F723ED62;
	Thu, 27 Feb 2025 14:44:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F16239594
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740667470; cv=none; b=nmRQ2obYSRNdwRkSJkIt0RLEf+rlhwtJ1x+DaOuqWZfFdxmGBM7YnzYkTEu2OjuTtyve2Sg2o+UF6Apgk9nUQQ8WoFA/fIqHBo47nqrnR/DaScDglNE1U+K0H/mclQhIFAfwtyii/P7psqjiypeQyIr1xEujtxhW8ESsQHzI3Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740667470; c=relaxed/simple;
	bh=zAINs7GPCk8/jWoubUq2mFznEb7e0XOW/hlE5X8vq2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ouxj0m9RKBdFAj/k7Yfj0Yx0nwflfuHI1H+8ZyGspp63mEQOa0VNgsC9HSurWQPBrFij3Zb5JZLMb9YlQDchbPZwyW2fdU2G5TZbsJbAMNMPm7/rj+AYiT4yxsx8O/iLHH727rUCOOqen2WkCEV1wDZ95s6qvqYbmaWUyCTE4eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C9032BCA;
	Thu, 27 Feb 2025 06:44:44 -0800 (PST)
Received: from [10.1.30.50] (e122027.cambridge.arm.com [10.1.30.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BFEC3F673;
	Thu, 27 Feb 2025 06:44:25 -0800 (PST)
Message-ID: <2876ee3a-8725-43fc-aee3-3c4b10a62f67@arm.com>
Date: Thu, 27 Feb 2025 14:44:23 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] drm/panfrost: Use
 GPU_MMU_FEATURES_VA_BITS/PA_BITS macros
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: boris.brezillon@collabora.com, robh@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
References: <20250226183043.140773-1-ariel.dalessandro@collabora.com>
 <20250226183043.140773-2-ariel.dalessandro@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250226183043.140773-2-ariel.dalessandro@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/02/2025 18:30, Ariel D'Alessandro wrote:
> As done in panthor, define and use these GPU_MMU_FEATURES_* macros,
> which makes code easier to read and reuse.
> 
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_mmu.c  | 6 ++++--
>  drivers/gpu/drm/panfrost/panfrost_regs.h | 2 ++
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> index b91019cd5acb..7df2c8d5b0ae 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -615,6 +615,8 @@ static void panfrost_drm_mm_color_adjust(const struct drm_mm_node *node,
>  
>  struct panfrost_mmu *panfrost_mmu_ctx_create(struct panfrost_device *pfdev)
>  {
> +	u32 va_bits = GPU_MMU_FEATURES_VA_BITS(pfdev->features.mmu_features);
> +	u32 pa_bits = GPU_MMU_FEATURES_PA_BITS(pfdev->features.mmu_features);
>  	struct panfrost_mmu *mmu;
>  
>  	mmu = kzalloc(sizeof(*mmu), GFP_KERNEL);
> @@ -633,8 +635,8 @@ struct panfrost_mmu *panfrost_mmu_ctx_create(struct panfrost_device *pfdev)
>  
>  	mmu->pgtbl_cfg = (struct io_pgtable_cfg) {
>  		.pgsize_bitmap	= SZ_4K | SZ_2M,
> -		.ias		= FIELD_GET(0xff, pfdev->features.mmu_features),
> -		.oas		= FIELD_GET(0xff00, pfdev->features.mmu_features),
> +		.ias		= va_bits,
> +		.oas		= pa_bits,
>  		.coherent_walk	= pfdev->coherent,
>  		.tlb		= &mmu_tlb_ops,
>  		.iommu_dev	= pfdev->dev,
> diff --git a/drivers/gpu/drm/panfrost/panfrost_regs.h b/drivers/gpu/drm/panfrost/panfrost_regs.h
> index c7bba476ab3f..b5f279a19a08 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_regs.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_regs.h
> @@ -16,6 +16,8 @@
>  #define   GROUPS_L2_COHERENT		BIT(0)	/* Cores groups are l2 coherent */
>  
>  #define GPU_MMU_FEATURES		0x014	/* (RO) MMU features */
> +#define  GPU_MMU_FEATURES_VA_BITS(x)	((x) & GENMASK(7, 0))
> +#define  GPU_MMU_FEATURES_PA_BITS(x)	(((x) >> 8) & GENMASK(7, 0))
>  #define GPU_AS_PRESENT			0x018	/* (RO) Address space slots present */
>  #define GPU_JS_PRESENT			0x01C	/* (RO) Job slots present */
>  


