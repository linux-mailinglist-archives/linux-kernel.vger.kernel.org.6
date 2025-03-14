Return-Path: <linux-kernel+bounces-561779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 993EBA6160D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7F4F16F9CB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DD020297B;
	Fri, 14 Mar 2025 16:17:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9006112B63
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741969057; cv=none; b=cFoh6JPTLojlx1pwmDpxlfvGd/y2Anz+MtZDlc1VrGfwNmj4GYEjzwThynxGAg3oewXqoB2oiPaoUd2GnEc6ujAnaQy4Ie3oQI6tJFimhNEdlcB2t4Fk9py8lUcJzR5x6J/C5ewjf3q93ILfCrfL4y96ACa5t94HwheaEawLiR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741969057; c=relaxed/simple;
	bh=f3iNj/jayXnTdUaGYfDDd9UXJoV5RgQeQDddQbXxVmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k4UXYqe2D95lbY8yt4SmXJj6SfBVUxOsAS7r51di9Nw7VOG8oojMcDNkSHbxeONX+qo1ylsxfwkYfud1A+TsmryghGBuNsmJwPoVIGTT7KdJZZZsHf9I1E6+7LaKuaDYcVJnblDjOfZcVWIIjSXCS+sSmNkYIFb044gnMdBWLGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0C4713D5;
	Fri, 14 Mar 2025 09:17:43 -0700 (PDT)
Received: from [10.1.26.16] (e122027.cambridge.arm.com [10.1.26.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09ECF3F5A1;
	Fri, 14 Mar 2025 09:17:30 -0700 (PDT)
Message-ID: <25408ea8-475a-424e-8fb4-8c6772de63bb@arm.com>
Date: Fri, 14 Mar 2025 16:17:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/6] drm/panfrost: Set IOMMU_CACHE flag
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: boris.brezillon@collabora.com, robh@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, kernel@collabora.com,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 sjoerd@collabora.com
References: <20250310195921.157511-1-ariel.dalessandro@collabora.com>
 <20250310195921.157511-2-ariel.dalessandro@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250310195921.157511-2-ariel.dalessandro@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/03/2025 19:59, Ariel D'Alessandro wrote:
> Panfrost does not support uncached mappings, so flag them properly. Also
> flag the pages that are mapped as response to a page fault as cached.

As I understand it the hardware only sort-of supports uncached mappings.
The legacy page table format has two options: cached, or "implementation
defined" (ARM_MALI_LPAE_MEMATTR_IMP_DEF). When selecting IMP_DEF that
means that the internal units signal to the cache whether a particular
access should be cached or not. I believe the theory is that they can
decide whether it makes sense to store in the cache or not.

Having said all that, I have never observed any actual performance
difference and I suspect it won't make any actual difference. And of
course the AArch64 page tables need this to be set. I just thought I
should explain the background and that this wasn't wrong for the legacy
page tables.

Reviewed-by: Steven Price <steven.price@arm.com>

Steve

> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_mmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> index b91019cd5acb1..9e6f198ef5c1b 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -327,7 +327,7 @@ int panfrost_mmu_map(struct panfrost_gem_mapping *mapping)
>  	struct drm_gem_object *obj = &shmem->base;
>  	struct panfrost_device *pfdev = to_panfrost_device(obj->dev);
>  	struct sg_table *sgt;
> -	int prot = IOMMU_READ | IOMMU_WRITE;
> +	int prot = IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE;
>  
>  	if (WARN_ON(mapping->active))
>  		return 0;
> @@ -528,7 +528,7 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
>  		goto err_map;
>  
>  	mmu_map_sg(pfdev, bomapping->mmu, addr,
> -		   IOMMU_WRITE | IOMMU_READ | IOMMU_NOEXEC, sgt);
> +		   IOMMU_WRITE | IOMMU_READ | IOMMU_CACHE | IOMMU_NOEXEC, sgt);
>  
>  	bomapping->active = true;
>  	bo->heap_rss_size += SZ_2M;


