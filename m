Return-Path: <linux-kernel+bounces-325424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFF0975987
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 19:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BA5D1F2322D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806AB1B3F20;
	Wed, 11 Sep 2024 17:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYn4k6wC"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F461AE852
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 17:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726076158; cv=none; b=pUT/ouG+C7xZeKeZ3eTxX0DgPB139dlDGYaVRyrOgduODGEAXkZLtO1YCrJQHZgP9Rdj+CmnEFryY89t00M0DbuX+b+L4AabYvrwkXor8ghp65L/X5D/tWAuDrFR42MmQOCMXX3JqmQ9aDcaYm9nZsGzAACuwddxIvoF0HbnEyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726076158; c=relaxed/simple;
	bh=K3Ucla6qHWdsNk6bbDi2C9tCMIqfaV06d3MCVH//ehI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y6YbOmUWPc3lGLbhr4bWNkWIT8iBgh8Ka7k/KTA5IbY1Y1qdGZoQ3pUpRZS9dXhJZR4OzQpobDFzT5qi4P3hv0iP2ZYiMK/i/NndNjZ0hatv0JYnpXwRM0h2tkA0S2HX7bSA46lzq5TSHiV15wyrQd4H7Ywv1ThQ+hgNmmEePtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYn4k6wC; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2da4e84c198so55890a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726076157; x=1726680957; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J+zugMFoquGTXa/VfqrdIPbdRGro0VHIjtqIBxGTLnU=;
        b=AYn4k6wCGx+gdP4Jo+FRr/6+tK1OUl0OfWeAUSatHy0CsQaGByd8UMoMbVncJgtOUI
         9oDJJpgH6/V4owhH523FFkvQG0tdCowAEKWy4O6xcblFDOpCt0+S5gSbTnQH9QYa82Jv
         7tgnGgKDFjLxkRkBPhZwT5tGoXslKIGsqoD0Ul0+BcvWyXTd4UKpsv67lWVPloOXYfUP
         34/JXf76ZqdW78fDdzrVfdb33Q7UEqZnolNFXM3rFAC0k3mBgcahmuy1ltsDu7kLdgMp
         i/RLJMNI1KZ8XOJMetbfbk2s0BlMdyDQyeDzRAKrg/NItofxh4KU1kwisQ1vZwjVENWf
         TgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726076157; x=1726680957;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J+zugMFoquGTXa/VfqrdIPbdRGro0VHIjtqIBxGTLnU=;
        b=XGt1hQJfE1vq/QYJSk0T9o3H+1ZYaUrIW4mL/DhYwR7dfbIy96cqtetTrBiv/yAkw1
         SQpjouik3d/mEjDdaIPoIEmh/uFJ30lf+DJlqGRsuEsNXEXEIuTlDp8IJeTZZrCMoYmv
         /RLhkIH86EPI+lW1ESrpZhV5Z/9pVwTGLcsXSSCFX6rd0txFFJZE+dgR+SjQ2H6H8XH6
         afE1oB/BfJYYuBND38Oxf+xRX6/8dW5Zb4jaoq3ax897/Y7tndTf+wg8yHid79VG13yn
         b/VmtDJ+8TEbLD6JA19/HkgQjF1gunKaQ8U/soI0XHNxcLBlAjYvzX/fGa/buv5NS++z
         hScA==
X-Forwarded-Encrypted: i=1; AJvYcCUxCcSf5RUwIfc/0srP29rh3IMOIJkuJVE6pZHb1oATKMRYzvkEqjwW2SFyiCJcxG0f8UOdZXwwtmAXuEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh9MFCA9qAf6xiZxIS7VGQc9O4z+cMQ+ktU/bK/8q+uRHWoXJK
	gdfQ/29OSXESVZYWOqCzqQqe65kZmj57htnCBTKtbWSovJXP/YXsYJhdKgYS6/pbp2m1pXencj7
	ZV3AxMzbk+Hb0uLg8DbuwkwyWyqs=
X-Google-Smtp-Source: AGHT+IGmCpPj+I32nVJBJWnsPgRGIwZW08YCd5TauOT9KzvM3pY9ncXxsjRUyjSchdeuMp3HLi2SRenTt9L9UoAjmUg=
X-Received: by 2002:a17:90b:3696:b0:2d3:dca0:89b7 with SMTP id
 98e67ed59e1d1-2daffa3a9d4mr15698133a91.3.1726076156520; Wed, 11 Sep 2024
 10:35:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903020857.3250038-1-xiaolei.wang@windriver.com>
In-Reply-To: <20240903020857.3250038-1-xiaolei.wang@windriver.com>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Wed, 11 Sep 2024 19:35:44 +0200
Message-ID: <CAH9NwWczgAmgRbHiKD1614Yc1fAXRYV2ZDUeuEunPDUcRmPwgA@mail.gmail.com>
Subject: Re: [PATCH v3] drm/etnaviv: Request pages from DMA32 zone on addressing_limited
To: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: sui.jingfeng@linux.dev, l.stach@pengutronix.de, 
	linux+etnaviv@armlinux.org.uk, airlied@gmail.com, daniel@ffwll.ch, 
	etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Am Di., 3. Sept. 2024 um 04:09 Uhr schrieb Xiaolei Wang
<xiaolei.wang@windriver.com>:
>
> Remove __GFP_HIGHMEM when requesting a page from DMA32 zone,
> and since all vivante GPUs in the system will share the same
> DMA constraints, move the check of whether to get a page from
> DMA32 to etnaviv_bind().
>
> Fixes: b72af445cd38 ("drm/etnaviv: request pages from DMA32 zone when needed")
> Suggested-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>

Reviewed-by: Christian Gmeiner <cgmeiner@igalia.com>

> ---
>
> change log
>
> v1:
>   https://patchwork.kernel.org/project/dri-devel/patch/20240806104733.2018783-1-xiaolei.wang@windriver.com/
>
> v2:
>   Modify the issue of not retaining GFP_USER in v1 and update the commit log.
>
> v3:
>   Use "priv->shm_gfp_mask = GFP_USER | __GFP_RETRY_MAYFAIL | __GFP_NOWARN;"
> instead of
>   "priv->shm_gfp_mask = GFP_HIGHUSER | __GFP_RETRY_MAYFAIL | __GFP_NOWARN;"
> and move the check of whether to get a page from DMA32 to etnaviv_bind().
>
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c | 10 +++++++++-
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c |  8 --------
>  2 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> index 6500f3999c5f..8cb2c3ec8e5d 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> @@ -536,7 +536,15 @@ static int etnaviv_bind(struct device *dev)
>         mutex_init(&priv->gem_lock);
>         INIT_LIST_HEAD(&priv->gem_list);
>         priv->num_gpus = 0;
> -       priv->shm_gfp_mask = GFP_HIGHUSER | __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
> +       priv->shm_gfp_mask = GFP_USER | __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
> +
> +       /*
> +        * If the GPU is part of a system with DMA addressing limitations,
> +        * request pages for our SHM backend buffers from the DMA32 zone to
> +        * hopefully avoid performance killing SWIOTLB bounce buffering.
> +        */
> +       if (dma_addressing_limited(dev))
> +               priv->shm_gfp_mask |= GFP_DMA32;
>
>         priv->cmdbuf_suballoc = etnaviv_cmdbuf_suballoc_new(drm->dev);
>         if (IS_ERR(priv->cmdbuf_suballoc)) {
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> index 7c7f97793ddd..5e753dd42f72 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -839,14 +839,6 @@ int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
>         if (ret)
>                 goto fail;
>
> -       /*
> -        * If the GPU is part of a system with DMA addressing limitations,
> -        * request pages for our SHM backend buffers from the DMA32 zone to
> -        * hopefully avoid performance killing SWIOTLB bounce buffering.
> -        */
> -       if (dma_addressing_limited(gpu->dev))
> -               priv->shm_gfp_mask |= GFP_DMA32;
> -
>         /* Create buffer: */
>         ret = etnaviv_cmdbuf_init(priv->cmdbuf_suballoc, &gpu->buffer,
>                                   PAGE_SIZE);
> --
> 2.25.1
>


-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy

