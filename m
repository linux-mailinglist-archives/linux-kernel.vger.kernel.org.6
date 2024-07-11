Return-Path: <linux-kernel+bounces-249672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A270192EE5C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CE16284923
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF09016DC1F;
	Thu, 11 Jul 2024 18:02:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4088E16D4FA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 18:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720978; cv=none; b=OxlcRlgjN9aoNwAuAJrkNA0Elq9faexfd3K5mV0aAsnvRnyzWVRcY+J39cS3qBXHM0J7ZdmhBL+FjusFi2af5r4X2VqgkQmN+EwmKmUtPK3BaEeCJjPR5JvuDvxCMz+b8XNaE9nSKY3mLOUWdphmKxmqWwH8C4s8Tq1z+3nsjNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720978; c=relaxed/simple;
	bh=/b9okvaaC1rTIiEDjxKRa8CcXKvVKnj5+Q/x678IcFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FDZTIrvE4yzn7cLrb5A0AloPuGBXyGu6+XFBvxhCpx6VqOkf+kjaIi1ubxhhOHoCjI5dA3Qwzn+eNuFYPwfeNfF6Tqj1O8qSw26czvPFq62t8hxR46wz0J01aPV9HiB6/IAsBTY976ymcQBFiZkCvr4ubTrBSuqnBzd1+Ytgnvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C3A71007;
	Thu, 11 Jul 2024 11:03:20 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 184D43F766;
	Thu, 11 Jul 2024 11:02:48 -0700 (PDT)
Message-ID: <7ef6cd1e-3dc6-452e-ac1c-128ee98acdb0@arm.com>
Date: Thu, 11 Jul 2024 19:02:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dma: call unconditionally to unmap_page and unmap_sg
 callbacks
To: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, Jason Gunthorpe <jgg@nvidia.com>
References: <98d1821780028434ff55b5d2f1feea287409fbc4.1720693745.git.leon@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <98d1821780028434ff55b5d2f1feea287409fbc4.1720693745.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/07/2024 11:38 am, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Almost all users of ->map_page()/map_sg() callbacks implement
> ->unmap_page()/unmap_sg() callbacks too. One user which doesn't do it,
> is dummy DMA ops interface, and the use of this interface is to fail
> the operation and in such case, there won't be any call to
> ->unmap_page()/unmap_sg().
> 
> This patch removes the existence checks of ->unmap_page()/unmap_sg()
> and calls to it directly to create symmetrical interface to
> ->map_page()/map_sg().

Now that all the common cases have been mopped up by dma-direct, I'm 
inclined to agree that this seems reasonable. For sure there is code out 
there still abusing random DMA API calls as a cache maintenance 
interface because it thinks it knows better, but even that's going to be 
running on platforms where it expects unmap to have the desired effect 
anyway, so the chance of somehow ending up with the dummy ops and 
crashing seems sufficiently unlikely.

However, I'm a little wary of the static checker brigade noticing that 
and trying to "fix" it by reinstating these tests, so perhaps it's worth 
just adding unmaps to the dummy ops (with a WARN() in them) as well for 
the sake of cleanliness and avoidance of any doubt.

Thanks,
Robin.

> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>   kernel/dma/mapping.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 81de84318ccc..6832fd6f0796 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -177,7 +177,7 @@ void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
>   	if (dma_map_direct(dev, ops) ||
>   	    arch_dma_unmap_page_direct(dev, addr + size))
>   		dma_direct_unmap_page(dev, addr, size, dir, attrs);
> -	else if (ops->unmap_page)
> +	else
>   		ops->unmap_page(dev, addr, size, dir, attrs);
>   	debug_dma_unmap_page(dev, addr, size, dir);
>   }
> @@ -291,7 +291,7 @@ void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>   	if (dma_map_direct(dev, ops) ||
>   	    arch_dma_unmap_sg_direct(dev, sg, nents))
>   		dma_direct_unmap_sg(dev, sg, nents, dir, attrs);
> -	else if (ops->unmap_sg)
> +	else
>   		ops->unmap_sg(dev, sg, nents, dir, attrs);
>   }
>   EXPORT_SYMBOL(dma_unmap_sg_attrs);

