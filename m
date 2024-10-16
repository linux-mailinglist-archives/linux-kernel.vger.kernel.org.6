Return-Path: <linux-kernel+bounces-368523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BA19A10D6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 19:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A7FDB215F6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07372139DB;
	Wed, 16 Oct 2024 17:38:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C99210C25;
	Wed, 16 Oct 2024 17:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729100312; cv=none; b=uqptiZPr0RmIsxkPOQ9ZML6G4L4yGS/AZ4cK1OFinbtWHY5yHTBAyuTpFsnqWivicl1EbCpLMJZ42SwKtVR543HgSibe9g54AEg0PxayDOCfig2omP1IKsEViYPl6wNzLlECmjMkX86/PAePgOHFmHgua077mi/5/E6g4kUzlHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729100312; c=relaxed/simple;
	bh=SEjjDzCe3fEF6Q0MD/3Ag7e9BKWXuwcxTsJ00FoOQk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hTIdhXaOu/s41N1srdKSmHdXTz8krKrV6iVrgJWp5r4PbynseUKmwDzqfeqMdK9z+oAzBuDz28umF+Kmc5Mq24ejqYfkFImOKSA9WJw9qsGoci1wUDXr0ckHc8cRiI55tFdDZP2nm/25jFtGPyOhvuYdkdY5WXryBtWMQ6/8Yvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6A28FEC;
	Wed, 16 Oct 2024 10:38:58 -0700 (PDT)
Received: from [10.57.87.74] (unknown [10.57.87.74])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 253D33F528;
	Wed, 16 Oct 2024 10:38:25 -0700 (PDT)
Message-ID: <b5e89288-d1c9-4c10-91b3-b1351b623ce6@arm.com>
Date: Wed, 16 Oct 2024 18:38:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/15] drm/rockchip: Set dma mask to 64 bit
To: Andy Yan <andyshrk@163.com>, heiko@sntech.de
Cc: hjc@rock-chips.com, krzk+dt@kernel.org, robh@kernel.org,
 conor+dt@kernel.org, s.hauer@pengutronix.de, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 derek.foreman@collabora.com, minhuadotchen@gmail.com,
 detlev.casanova@collabora.com, Andy Yan <andy.yan@rock-chips.com>
References: <20240920081626.6433-1-andyshrk@163.com>
 <20240920082036.6623-1-andyshrk@163.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240920082036.6623-1-andyshrk@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-09-20 9:20 am, Andy Yan wrote:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> The vop mmu support translate physical address upper 4 GB to iova
> below 4 GB. So set dma mask to 64 bit to indicate we support address
>> 4GB.
> 
> This can avoid warnging message like this on some boards with DDR
>> 4 GB:
> 
> rockchip-drm display-subsystem: swiotlb buffer is full (sz: 266240 bytes), total 32768 (slots), used 130 (slots)
> rockchip-drm display-subsystem: swiotlb buffer is full (sz: 266240 bytes), total 32768 (slots), used 0 (slots)
> rockchip-drm display-subsystem: swiotlb buffer is full (sz: 266240 bytes), total 32768 (slots), used 130 (slots)
> rockchip-drm display-subsystem: swiotlb buffer is full (sz: 266240 bytes), total 32768 (slots), used 130 (slots)
> rockchip-drm display-subsystem: swiotlb buffer is full (sz: 266240 bytes), total 32768 (slots), used 0 (slots)

There are several things wrong with this...

AFAICS the VOP itself still only supports 32-bit addresses, so the VOP 
driver should only be setting a 32-bit DMA mask. The IOMMUs support 
either 32-bit or 40-bit addresses, and the IOMMU driver does set its DMA 
mask appropriately. None of those numbers is 64, so that's clearly 
suspicious already. Plus it would seem the claim of the IOMMU being able 
to address >4GB isn't strictly true for RK3288 (which does supposedly 
support 8GB of RAM).

Furthermore, the "display-subsystem" doesn't even exist - it does not 
represent any actual DMA-capable hardware, so it should not have a DMA 
mask, and it should not be used for DMA API operations. Buffers for the 
VOP should be DMA-mapped for the VOP device itself. At the very least, 
the rockchip_gem_alloc_dma() path is clearly broken otherwise (I guess 
this patch possibly *would* make that brokenness apparent).

> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> Tested-by: Derek Foreman <derek.foreman@collabora.com>
> ---
> 
> (no changes since v1)
> 
>   drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> index 04ef7a2c3833..8bc2ff3b04bb 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> @@ -445,7 +445,9 @@ static int rockchip_drm_platform_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> -	return 0;
> +	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(64));

Finally as a general thing, please don't misuse 
dma_coerce_mask_and_coherent() in platform drivers, just use normal 
dma_set_mask_and_coherent(). The platform bus code has been initialising 
the dev->dma_mask pointer for years now, drivers should not be messing 
with it any more.

Thanks,
Robin.

> +
> +	return ret;
>   }
>   
>   static void rockchip_drm_platform_remove(struct platform_device *pdev)


