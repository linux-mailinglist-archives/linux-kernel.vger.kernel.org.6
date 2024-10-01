Return-Path: <linux-kernel+bounces-345854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFA498BBE9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 455A4B20CAA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A321C1AD2;
	Tue,  1 Oct 2024 12:17:47 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CC6188938
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 12:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727785067; cv=none; b=LQXz+YLTZRnDLFbZLo/qVhh3mCLzocakXE7wGN+CQ7tgC3drvxcDY3bKwpG+6gzf39hLurHhhB0fg4AB81Y8AxAU3e1IDf7pXQrfYoSP2zIcdDbU1altm/ypDMyUkfE6cILPttMYIok6t90USnZ08MLz4gnzZuErHbMyhKfhk+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727785067; c=relaxed/simple;
	bh=qGHEKYSmb8F+9ic1OBITeeITzhZaKFUd8K/5VkL9txQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QsbiizPA5OSLtG2kY0c2ab9kHkwq6uY0/zkyz1INRm4Dywhd66aFMxsjzI9R5zwC1ZaGY1cQA0LmA91kQHQk87+0mRWMnXizzq6IlwayOQT2qHvRrMph6Up5nI5oygYvxLNY0tgSpWfopdCPrGsJRCYxc+iORwactsrcM0kud+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1svboq-00079m-FC; Tue, 01 Oct 2024 14:17:32 +0200
Message-ID: <7a6ffbb773784dee0ea3ee87e563ac4e4f7c9c90.camel@pengutronix.de>
Subject: Re: [PATCH v3] drm/etnaviv: Request pages from DMA32 zone on
 addressing_limited
From: Lucas Stach <l.stach@pengutronix.de>
To: Xiaolei Wang <xiaolei.wang@windriver.com>, sui.jingfeng@linux.dev, 
 linux+etnaviv@armlinux.org.uk, christian.gmeiner@gmail.com,
 airlied@gmail.com,  daniel@ffwll.ch
Cc: etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 01 Oct 2024 14:17:31 +0200
In-Reply-To: <20240903020857.3250038-1-xiaolei.wang@windriver.com>
References: <20240903020857.3250038-1-xiaolei.wang@windriver.com>
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

Hi Xiaolei,

Am Dienstag, dem 03.09.2024 um 10:08 +0800 schrieb Xiaolei Wang:
> Remove __GFP_HIGHMEM when requesting a page from DMA32 zone,
> and since all vivante GPUs in the system will share the same
> DMA constraints, move the check of whether to get a page from
> DMA32 to etnaviv_bind().
>=20
> Fixes: b72af445cd38 ("drm/etnaviv: request pages from DMA32 zone when nee=
ded")
> Suggested-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> ---
>=20
> change log
>=20
> v1:
>   https://patchwork.kernel.org/project/dri-devel/patch/20240806104733.201=
8783-1-xiaolei.wang@windriver.com/
>=20
> v2:
>   Modify the issue of not retaining GFP_USER in v1 and update the commit =
log.
>=20
> v3:
>   Use "priv->shm_gfp_mask =3D GFP_USER | __GFP_RETRY_MAYFAIL | __GFP_NOWA=
RN;"
> instead of
>   "priv->shm_gfp_mask =3D GFP_HIGHUSER | __GFP_RETRY_MAYFAIL | __GFP_NOWA=
RN;"

I don't understand this part of the changes in the new version. Why
should we drop the HIGHMEM bit always and not only in the case where
dma addressing is limited? This seems overly restrictive.

Regards,
Lucas

> and move the check of whether to get a page from DMA32 to etnaviv_bind().
>=20
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c | 10 +++++++++-
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c |  8 --------
>  2 files changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etna=
viv/etnaviv_drv.c
> index 6500f3999c5f..8cb2c3ec8e5d 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> @@ -536,7 +536,15 @@ static int etnaviv_bind(struct device *dev)
>  	mutex_init(&priv->gem_lock);
>  	INIT_LIST_HEAD(&priv->gem_list);
>  	priv->num_gpus =3D 0;
> -	priv->shm_gfp_mask =3D GFP_HIGHUSER | __GFP_RETRY_MAYFAIL | __GFP_NOWAR=
N;
> +	priv->shm_gfp_mask =3D GFP_USER | __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
> +
> +	/*
> +	 * If the GPU is part of a system with DMA addressing limitations,
> +	 * request pages for our SHM backend buffers from the DMA32 zone to
> +	 * hopefully avoid performance killing SWIOTLB bounce buffering.
> +	 */
> +	if (dma_addressing_limited(dev))
> +		priv->shm_gfp_mask |=3D GFP_DMA32;
> =20
>  	priv->cmdbuf_suballoc =3D etnaviv_cmdbuf_suballoc_new(drm->dev);
>  	if (IS_ERR(priv->cmdbuf_suballoc)) {
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etna=
viv/etnaviv_gpu.c
> index 7c7f97793ddd..5e753dd42f72 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -839,14 +839,6 @@ int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
>  	if (ret)
>  		goto fail;
> =20
> -	/*
> -	 * If the GPU is part of a system with DMA addressing limitations,
> -	 * request pages for our SHM backend buffers from the DMA32 zone to
> -	 * hopefully avoid performance killing SWIOTLB bounce buffering.
> -	 */
> -	if (dma_addressing_limited(gpu->dev))
> -		priv->shm_gfp_mask |=3D GFP_DMA32;
> -
>  	/* Create buffer: */
>  	ret =3D etnaviv_cmdbuf_init(priv->cmdbuf_suballoc, &gpu->buffer,
>  				  PAGE_SIZE);


