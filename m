Return-Path: <linux-kernel+bounces-385307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DAE9B3569
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B7051C2164B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6BE1DE3D1;
	Mon, 28 Oct 2024 15:53:48 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64909189913
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730130828; cv=none; b=GRB4QnxZvjmfCxd2ynW1DeNojvWZcKx2kJ3Mpn9AEuQCfYJ20lVtX/ojAR4tP5UGlPekDrOxEcT4QALCNjGL77dqSYXIfX8EvGEq9Cm0b2kxTN7HZ6F1035ZT7rRGgmzl8DhQhHSLdnu740IIPGPVEAaF3/FZ1NqFYR1JLFg1ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730130828; c=relaxed/simple;
	bh=AkqaXmkEuQ0bNQtkJInNM4PEhU+FwCLgA7P2Nxpnb0Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ktB16LYexbB2ANnXuBf9ZAmud47l+6DFK5SLgVlGof+TxE28HyZvWy42QgD6iMlHfVOzRNF2FTDq0GPZQCyVuANiTMDG4ulPwv+s00WTVfstozwQRg6Rat9Dx4FZAWowM5tvk86hX90NSk1HlupHUucVYKYipVYBEIa12j9Y9dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1t5S3c-000401-OB; Mon, 28 Oct 2024 16:53:28 +0100
Message-ID: <15a386d0093af21447aeb5c2f1ee98d61e89e9b2.camel@pengutronix.de>
Subject: Re: [PATCH v4] drm/etnaviv: Request pages from DMA32 zone on
 addressing_limited
From: Lucas Stach <l.stach@pengutronix.de>
To: Xiaolei Wang <xiaolei.wang@windriver.com>, sui.jingfeng@linux.dev, 
	christian.gmeiner@gmail.com, airlied@gmail.com, daniel@ffwll.ch, 
	linux+etnaviv@armlinux.org.uk
Cc: etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 28 Oct 2024 16:53:27 +0100
In-Reply-To: <20241001233430.4072268-1-xiaolei.wang@windriver.com>
References: <20241001233430.4072268-1-xiaolei.wang@windriver.com>
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

Am Mittwoch, dem 02.10.2024 um 07:34 +0800 schrieb Xiaolei Wang:
> Remove __GFP_HIGHMEM when requesting a page from DMA32 zone,
> and since all vivante GPUs in the system will share the same
> DMA constraints, move the check of whether to get a page from
> DMA32 to etnaviv_bind().
>=20
> Fixes: b72af445cd38 ("drm/etnaviv: request pages from DMA32 zone when nee=
ded")
> Suggested-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> Reviewed-by: Christian Gmeiner <cgmeiner@igalia.com>

Thanks, applied to etnaviv/next.

> ---
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
>=20
> v4:
>   drop the HIGHMEM bit only if dma addressing is limited.
>=20
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c | 10 ++++++++++
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c |  8 --------
>  2 files changed, 10 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etna=
viv/etnaviv_drv.c
> index 6500f3999c5f..19ec67a5a918 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> @@ -538,6 +538,16 @@ static int etnaviv_bind(struct device *dev)
>  	priv->num_gpus =3D 0;
>  	priv->shm_gfp_mask =3D GFP_HIGHUSER | __GFP_RETRY_MAYFAIL | __GFP_NOWAR=
N;
> =20
> +	/*
> +	 * If the GPU is part of a system with DMA addressing limitations,
> +	 * request pages for our SHM backend buffers from the DMA32 zone to
> +	 * hopefully avoid performance killing SWIOTLB bounce buffering.
> +	 */
> +	if (dma_addressing_limited(dev)) {
> +		priv->shm_gfp_mask |=3D GFP_DMA32;
> +		priv->shm_gfp_mask &=3D ~__GFP_HIGHMEM;
> +	}
> +
>  	priv->cmdbuf_suballoc =3D etnaviv_cmdbuf_suballoc_new(drm->dev);
>  	if (IS_ERR(priv->cmdbuf_suballoc)) {
>  		dev_err(drm->dev, "Failed to create cmdbuf suballocator\n");
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


