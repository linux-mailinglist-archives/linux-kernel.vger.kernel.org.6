Return-Path: <linux-kernel+bounces-301678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B6395F3F0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 244631F22529
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8A218BC01;
	Mon, 26 Aug 2024 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKV6M+99"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1DC143C70
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 14:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724682845; cv=none; b=gM2/7YZdiKf1DCltP0TNNmh76pctVC1MQlZMk2hU97S04j9YKVJpIKeKU3i7oJmS7KY/Nmjj0y4G0DUmmMUPfKKUfw4uFEOcff85EH1vEhfp9DVMwoqRXoYofNsXsp9pRd73uCGSNPx2y5o1UHBgtEIL1JwZyUSupE4FnJ+tOaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724682845; c=relaxed/simple;
	bh=iBji9l3Mq5YlFk7xqpjOu4g46H0DO+fbEUaOKCGqD5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ORWbgbfBe7Hbb4TRecRTb5Z+gEMqPjyjLz0Mk2zxQC4bijZwXSr6O2NXCKqvu6b8z/TPHeBjieegiHMGgg14dzQdtbIt3fi2Zokzd3ZRi9AxJaL3oddmRTmnbp8Byv0V2jkW7OzOuSR0ET5KteB5miX2Z3dQQMlMg4N5MM058bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKV6M+99; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d3c071d276so2889154a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 07:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724682843; x=1725287643; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NAtqRu/b0jhdd68hvf5beb85uHO+b3KNcBWcH7+HYbA=;
        b=KKV6M+993cnxHjAIqLrFjASvq1utr10rECCHF6Sfks/m0/yC8UjjO2ePCBan9vLgw3
         XPGbwdLAc30Khm9t9DMzkkqemOE597f+fOkJG0fxdQ6TAxBLwUVLkaUeskgKZnKg4tp1
         j/m+bLdychSN1Dsc1YOLzowyiHYVA2YJftMoYIMPanKnmIgZeFZcfVFOdo92CSTknTDO
         ujMEI8nNC2/0W0pF1f2yIlfgXTrkvGTimHhGqpBvC+3bRsBnC6AZ8pRWWgQGF/zGt8o6
         DKvFJy0la1ijvBHRGzUQvoDMSwIylq1L5qeTbAvnVX5wzTXQ2f6kPdsFtbqntMJr9EEe
         rD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724682843; x=1725287643;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NAtqRu/b0jhdd68hvf5beb85uHO+b3KNcBWcH7+HYbA=;
        b=SPyi8KXuTKkDyi/W37PHUeK2Wawt7f5BShAXnxE7VAHsX23hB18bVV/0MWijQdYEmp
         CyHWclJU6Gjx+3x4pTkdF/oZB+XjD5Yj3yDVDXxaEKQnOQNE1wnD2ECztwnu1sYOsUan
         vzA9UNsSt7gZzEGCRnFQcsCpd9qp2WOKiqLhM756XZNHq9iki7MjYVFAxY87WPxfUIX4
         DA5UPgLryWRw7agz8piv90F1SMEotHNjaqkIhM1piFhZrM5ahhWH6/SdsEtnsrY8LaKO
         WqcHFuGUDYSjveUSOwrCr2AIz7vLvMoiIoHAev46aYN7Jgh5q0NrVR9ytTPyfh4pguLV
         aysA==
X-Forwarded-Encrypted: i=1; AJvYcCXlRIBKqn7/QZzy5Ar5qCob3s/xwcmqHG2VpdC5y1IWsiBMIFb1IwiMU0KdZxC8GrkRYrenMXoISVR873o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRJQW3CrBfgC0s7Mzs9HKo0v45XavhLfLkQ8DH4z82TPQKwyb4
	viW7v/c6Df/YdPBjYbY3Tp3+HmoWNiQq4y7US+9TxXAM5wepNhoUoPSf/vRIqsOMyphNKO5N+68
	edSbsd8tTXO+QxDPmXnWFKq/LtYY=
X-Google-Smtp-Source: AGHT+IHGswmu4skCSJTV0utPI/Jjq8Beu87ivVDe/S41pb2YNsrW0F54bj3C8C2XPPfoOu3Cyfsxm1RuQtIteMKHkZA=
X-Received: by 2002:a17:90b:b0c:b0:2c9:e0d3:1100 with SMTP id
 98e67ed59e1d1-2d646be07c3mr8467021a91.19.1724682843343; Mon, 26 Aug 2024
 07:34:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240825121452.363342-1-sui.jingfeng@linux.dev>
In-Reply-To: <20240825121452.363342-1-sui.jingfeng@linux.dev>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Mon, 26 Aug 2024 16:33:52 +0200
Message-ID: <CAH9NwWf-BODALL3dPgERY6i-KzeghbsWR_zHFv_BPjkiLQbQhw@mail.gmail.com>
Subject: Re: [PATCH] drm/etnaviv: Fix missing mutex_destroy()
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Lucas Stach <l.stach@pengutronix.de>, Russell King <linux+etnaviv@armlinux.org.uk>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Am So., 25. Aug. 2024 um 14:15 Uhr schrieb Sui Jingfeng
<sui.jingfeng@linux.dev>:
>
> Currently, the calling of mutex_destroy() is ignored on error handling
> code path. It is safe for now, since mutex_destroy() actually does
> nothing in non-debug builds. But the mutex_destroy() is used to mark
> the mutex uninitialized on debug builds, and any subsequent use of the
> mutex is forbidden.
>
> It also could lead to problems if mutex_destroy() gets extended, add
> missing mutex_destroy() to eliminate potential concerns.
>
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>

Reviewed-by: Christian Gmeiner <cgmeiner@igalia.com>

> ---
>  drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c | 3 +++
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c    | 1 +
>  drivers/gpu/drm/etnaviv/etnaviv_gem.c    | 1 +
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c    | 5 +++++
>  drivers/gpu/drm/etnaviv/etnaviv_mmu.c    | 2 +-
>  5 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c b/drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c
> index 721d633aece9..1edc02022be4 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c
> @@ -79,6 +79,9 @@ void etnaviv_cmdbuf_suballoc_destroy(struct etnaviv_cmdbuf_suballoc *suballoc)
>  {
>         dma_free_wc(suballoc->dev, SUBALLOC_SIZE, suballoc->vaddr,
>                     suballoc->paddr);
> +
> +       mutex_destroy(&suballoc->lock);
> +
>         kfree(suballoc);
>  }
>
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> index 6500f3999c5f..7844cd961a29 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> @@ -564,6 +564,7 @@ static int etnaviv_bind(struct device *dev)
>  out_destroy_suballoc:
>         etnaviv_cmdbuf_suballoc_destroy(priv->cmdbuf_suballoc);
>  out_free_priv:
> +       mutex_destroy(&priv->gem_lock);
>         kfree(priv);
>  out_put:
>         drm_dev_put(drm);
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> index fe665ca20c02..b68e3b235a7d 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> @@ -515,6 +515,7 @@ void etnaviv_gem_free_object(struct drm_gem_object *obj)
>         etnaviv_obj->ops->release(etnaviv_obj);
>         drm_gem_object_release(obj);
>
> +       mutex_destroy(&etnaviv_obj->lock);
>         kfree(etnaviv_obj);
>  }
>
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> index af52922ff494..d6acc4c68102 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -1929,8 +1929,13 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
>
>  static void etnaviv_gpu_platform_remove(struct platform_device *pdev)
>  {
> +       struct etnaviv_gpu *gpu = dev_get_drvdata(&pdev->dev);
> +
>         component_del(&pdev->dev, &gpu_ops);
>         pm_runtime_disable(&pdev->dev);
> +
> +       mutex_destroy(&gpu->lock);
> +       mutex_destroy(&gpu->sched_lock);
>  }
>
>  static int etnaviv_gpu_rpm_suspend(struct device *dev)
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
> index e3be16165c86..ed6c42384856 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
> @@ -361,7 +361,7 @@ static void etnaviv_iommu_context_free(struct kref *kref)
>                 container_of(kref, struct etnaviv_iommu_context, refcount);
>
>         etnaviv_cmdbuf_suballoc_unmap(context, &context->cmdbuf_mapping);
> -
> +       mutex_destroy(&context->lock);
>         context->global->ops->free(context);
>  }
>  void etnaviv_iommu_context_put(struct etnaviv_iommu_context *context)
> --
> 2.34.1
>


-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy

