Return-Path: <linux-kernel+bounces-324610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A444974EC0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC4028AE74
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEA9183CCB;
	Wed, 11 Sep 2024 09:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y27qBEEQ"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA012183CBB
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 09:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047439; cv=none; b=c3qH6B13EiXCz/1/8jcgrQww4+iwqrhjCdJuQyngj1cZA08m5yRcFocey/4rVmSwah+aKiJ9tQ5jde8W8o2AWPqSAeEo5DRtFoU2hy4VCkJ9k2r3Vrtg0x0awsQWd+y7kuBYATpmaggNVDKu1pDugyTQjhCOBkDpwXhFqwmgHwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047439; c=relaxed/simple;
	bh=yBMKOl/gAUub/Sr1ir/lQCy4wM5FZXO9kTzEomV52+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GhgViNgdD2+jnrzg7Ex2XfI5SoFR7Lr/FXwBb4Ob5LV8zmlsgB05ZdEZ3Zk2giySCFSjsvDqOk3Ql6hIvf1JdbOh2fnskHnHH0uQnZlyH8S9HfxGVDK/pLQjYFZJJ7aVOYhHgbfZ06dDhP5zTTvaBqwChbWjASmZxhKwZVG6wD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y27qBEEQ; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b0c651c1-acd6-4ca0-8791-f6bc16821a1e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726047434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RHDHiEMHosYpLAW4Qgb4jQgwOUHe1qbO/5lSaaVcNzU=;
	b=Y27qBEEQSl6iBpTk/r6wFrosW192/nqtNwOuLxYqVJwqsmocFAiKxc11h3vImROIjhsvrS
	eqWpR0tkwQMYwACTqamCVPxWCtGjq31v3nJ2ivHX3S2eTCIu1HTVLQMFqvWwBfrVMShk+W
	SNGtY4kz80KGfzUgiFglN3MjczOj3nw=
Date: Wed, 11 Sep 2024 17:37:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] drm/etnaviv: Request pages from DMA32 zone on
 addressing_limited
To: Xiaolei Wang <xiaolei.wang@windriver.com>, l.stach@pengutronix.de,
 linux+etnaviv@armlinux.org.uk, christian.gmeiner@gmail.com,
 airlied@gmail.com, daniel@ffwll.ch
Cc: etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240903020857.3250038-1-xiaolei.wang@windriver.com>
Content-Language: en-US, en-AU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20240903020857.3250038-1-xiaolei.wang@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Humble ping ?

On 9/3/24 10:08, Xiaolei Wang wrote:
> Remove __GFP_HIGHMEM when requesting a page from DMA32 zone,
> and since all vivante GPUs in the system will share the same
> DMA constraints, move the check of whether to get a page from
> DMA32 to etnaviv_bind().
> 
> Fixes: b72af445cd38 ("drm/etnaviv: request pages from DMA32 zone when needed")
> Suggested-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> ---
> 
> change log
> 
> v1:
>    https://patchwork.kernel.org/project/dri-devel/patch/20240806104733.2018783-1-xiaolei.wang@windriver.com/
> 
> v2:
>    Modify the issue of not retaining GFP_USER in v1 and update the commit log.
> 
> v3:
>    Use "priv->shm_gfp_mask = GFP_USER | __GFP_RETRY_MAYFAIL | __GFP_NOWARN;"
> instead of
>    "priv->shm_gfp_mask = GFP_HIGHUSER | __GFP_RETRY_MAYFAIL | __GFP_NOWARN;"
> and move the check of whether to get a page from DMA32 to etnaviv_bind().
> 
>   drivers/gpu/drm/etnaviv/etnaviv_drv.c | 10 +++++++++-
>   drivers/gpu/drm/etnaviv/etnaviv_gpu.c |  8 --------
>   2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> index 6500f3999c5f..8cb2c3ec8e5d 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> @@ -536,7 +536,15 @@ static int etnaviv_bind(struct device *dev)
>   	mutex_init(&priv->gem_lock);
>   	INIT_LIST_HEAD(&priv->gem_list);
>   	priv->num_gpus = 0;
> -	priv->shm_gfp_mask = GFP_HIGHUSER | __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
> +	priv->shm_gfp_mask = GFP_USER | __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
> +
> +	/*
> +	 * If the GPU is part of a system with DMA addressing limitations,
> +	 * request pages for our SHM backend buffers from the DMA32 zone to
> +	 * hopefully avoid performance killing SWIOTLB bounce buffering.
> +	 */
> +	if (dma_addressing_limited(dev))
> +		priv->shm_gfp_mask |= GFP_DMA32;
>   
>   	priv->cmdbuf_suballoc = etnaviv_cmdbuf_suballoc_new(drm->dev);
>   	if (IS_ERR(priv->cmdbuf_suballoc)) {
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> index 7c7f97793ddd..5e753dd42f72 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -839,14 +839,6 @@ int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
>   	if (ret)
>   		goto fail;
>   
> -	/*
> -	 * If the GPU is part of a system with DMA addressing limitations,
> -	 * request pages for our SHM backend buffers from the DMA32 zone to
> -	 * hopefully avoid performance killing SWIOTLB bounce buffering.
> -	 */
> -	if (dma_addressing_limited(gpu->dev))
> -		priv->shm_gfp_mask |= GFP_DMA32;
> -
>   	/* Create buffer: */
>   	ret = etnaviv_cmdbuf_init(priv->cmdbuf_suballoc, &gpu->buffer,
>   				  PAGE_SIZE);

-- 
Best regards
Sui


