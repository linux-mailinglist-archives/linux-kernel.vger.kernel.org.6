Return-Path: <linux-kernel+bounces-385312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B75709B3577
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BC16283062
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237291DE8BA;
	Mon, 28 Oct 2024 15:56:11 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BB31DE892
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730130970; cv=none; b=de6sBU7Yh4E0k8FQZS8w6oiy8A1YP6yagxc1Xp3sLrq3jD7ScIlvUywJsIi5iXd8W2qb9LFY4w5872EUkmQKhPx6/Ctgxrz7K29i7/+VfWN+IfwDwcgXEiZPbaez67+xWHTskJ7pqHgdyFjjdnVl9M/WDaT9LRtu59NMdzA2T2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730130970; c=relaxed/simple;
	bh=Eo/gzLsHoPGrJf8V082Nr/1NVCyEnodg/cWRyIE84sk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JizLkSHophVb/ur+zg8EapUJsoEDCOgdewTnkY8t5i0JfbbGUw8W7bdRguW7YE7uEpZzXXlj/u96X7A3uKk7EEdYRdP/Ev0KazLhDc7pcuivgm/YwXSokQpODoA4yrGXicdU/Z+PIB48zpIup2n19oKBarwcbOi3B2HCKI47jjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1t5S65-0004NU-9n; Mon, 28 Oct 2024 16:56:01 +0100
Message-ID: <436b5d7896951199b7a6bed5e8b432221c878a4c.camel@pengutronix.de>
Subject: Re: [PATCH] drm/etnaviv: Fix missing mutex_destroy()
From: Lucas Stach <l.stach@pengutronix.de>
To: Sui Jingfeng <sui.jingfeng@linux.dev>, Russell King
 <linux+etnaviv@armlinux.org.uk>, Christian Gmeiner
 <christian.gmeiner@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 28 Oct 2024 16:56:00 +0100
In-Reply-To: <20240825121452.363342-1-sui.jingfeng@linux.dev>
References: <20240825121452.363342-1-sui.jingfeng@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Am Sonntag, dem 25.08.2024 um 20:14 +0800 schrieb Sui Jingfeng:
> Currently, the calling of mutex_destroy() is ignored on error handling
> code path. It is safe for now, since mutex_destroy() actually does
> nothing in non-debug builds. But the mutex_destroy() is used to mark
> the mutex uninitialized on debug builds, and any subsequent use of the
> mutex is forbidden.
>=20
> It also could lead to problems if mutex_destroy() gets extended, add
> missing mutex_destroy() to eliminate potential concerns.
>=20
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>

Thanks, applied to etnaviv/next.

> ---
>  drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c | 3 +++
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c    | 1 +
>  drivers/gpu/drm/etnaviv/etnaviv_gem.c    | 1 +
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c    | 5 +++++
>  drivers/gpu/drm/etnaviv/etnaviv_mmu.c    | 2 +-
>  5 files changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c b/drivers/gpu/drm/e=
tnaviv/etnaviv_cmdbuf.c
> index 721d633aece9..1edc02022be4 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c
> @@ -79,6 +79,9 @@ void etnaviv_cmdbuf_suballoc_destroy(struct etnaviv_cmd=
buf_suballoc *suballoc)
>  {
>  	dma_free_wc(suballoc->dev, SUBALLOC_SIZE, suballoc->vaddr,
>  		    suballoc->paddr);
> +
> +	mutex_destroy(&suballoc->lock);
> +
>  	kfree(suballoc);
>  }
> =20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etna=
viv/etnaviv_drv.c
> index 6500f3999c5f..7844cd961a29 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> @@ -564,6 +564,7 @@ static int etnaviv_bind(struct device *dev)
>  out_destroy_suballoc:
>  	etnaviv_cmdbuf_suballoc_destroy(priv->cmdbuf_suballoc);
>  out_free_priv:
> +	mutex_destroy(&priv->gem_lock);
>  	kfree(priv);
>  out_put:
>  	drm_dev_put(drm);
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etna=
viv/etnaviv_gem.c
> index fe665ca20c02..b68e3b235a7d 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> @@ -515,6 +515,7 @@ void etnaviv_gem_free_object(struct drm_gem_object *o=
bj)
>  	etnaviv_obj->ops->release(etnaviv_obj);
>  	drm_gem_object_release(obj);
> =20
> +	mutex_destroy(&etnaviv_obj->lock);
>  	kfree(etnaviv_obj);
>  }
> =20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etna=
viv/etnaviv_gpu.c
> index af52922ff494..d6acc4c68102 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -1929,8 +1929,13 @@ static int etnaviv_gpu_platform_probe(struct platf=
orm_device *pdev)
> =20
>  static void etnaviv_gpu_platform_remove(struct platform_device *pdev)
>  {
> +	struct etnaviv_gpu *gpu =3D dev_get_drvdata(&pdev->dev);
> +
>  	component_del(&pdev->dev, &gpu_ops);
>  	pm_runtime_disable(&pdev->dev);
> +
> +	mutex_destroy(&gpu->lock);
> +	mutex_destroy(&gpu->sched_lock);
>  }
> =20
>  static int etnaviv_gpu_rpm_suspend(struct device *dev)
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c b/drivers/gpu/drm/etna=
viv/etnaviv_mmu.c
> index e3be16165c86..ed6c42384856 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
> @@ -361,7 +361,7 @@ static void etnaviv_iommu_context_free(struct kref *k=
ref)
>  		container_of(kref, struct etnaviv_iommu_context, refcount);
> =20
>  	etnaviv_cmdbuf_suballoc_unmap(context, &context->cmdbuf_mapping);
> -
> +	mutex_destroy(&context->lock);
>  	context->global->ops->free(context);
>  }
>  void etnaviv_iommu_context_put(struct etnaviv_iommu_context *context)


