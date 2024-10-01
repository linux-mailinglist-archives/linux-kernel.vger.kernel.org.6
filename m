Return-Path: <linux-kernel+bounces-346064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B5998BF07
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D1571F21736
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6797C1C68A7;
	Tue,  1 Oct 2024 14:07:50 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF0817FD
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 14:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791670; cv=none; b=LLDos9FIkXYbyoomsnF8cAMCyDn+vILokk9lssC4mEBBwe+OLZd9/mA4hDtl3UaehgEdRyY/GNndn67pqTjG9zYnRHpBB2JxfEUQA6HWcsYMjr+/s0InMwyrMWjNXhdWW9+vAcuCNV6k1Kdxw+sxJJeN/x+ncxmHZtZkWtJwp/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791670; c=relaxed/simple;
	bh=XTYIAVSe5E678qX32MRbo/0jEVuYJFtTXYmFr/kfgik=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F9mq9XtJSpbeUFb+wj4ThLLuO5dDw0keVIj1lRB9DxnXHI641VHsL82uh/lB6UM8GMhKpeaNME4wxiTM/qG/Vfr6RXMm52AfE43Hiti7D4B9x+PXsAVb5pWotoj5JZVhCGdVOEvUwhIJ8ygv4P40wyPUfqWFMKeaoNqxeCWQ+Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1svdXP-000659-VL; Tue, 01 Oct 2024 16:07:40 +0200
Message-ID: <8a517e50ae08ee777a9b3465167d7ac4721e6f9f.camel@pengutronix.de>
Subject: Re: [PATCH v15 09/19] drm/etnaviv: Add constructor and destructor
 for the etnaviv_drm_private structure
From: Lucas Stach <l.stach@pengutronix.de>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>, Russell King
	 <linux+etnaviv@armlinux.org.uk>, dri-devel@lists.freedesktop.org, 
	etnaviv@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Tue, 01 Oct 2024 16:07:39 +0200
In-Reply-To: <20240908094357.291862-10-sui.jingfeng@linux.dev>
References: <20240908094357.291862-1-sui.jingfeng@linux.dev>
	 <20240908094357.291862-10-sui.jingfeng@linux.dev>
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

Am Sonntag, dem 08.09.2024 um 17:43 +0800 schrieb Sui Jingfeng:
> Because there are a lot of data members in the struct etnaviv_drm_private=
,
> which are intended to be shared by all GPU cores. It can be lengthy and
> daunting on error handling, the 'gem_lock' of struct etnaviv_drm_private
> just be forgeten to destroy on driver leave.
>=20
As you seem to have based this patch on top of "drm/etnaviv: Fix
missing mutex_destroy()", the last part of the above sentence doesn't
match the code. Please drop.

> Switch to use the dedicated helpers introduced, etnaviv_bind() and
> etnaviv_unbind() gets simplified. Another potential benefit is that
> we could put the struct drm_device into struct etnaviv_drm_private
> in the future, which made them share the same life time.
>=20
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c | 73 +++++++++++++++++----------
>  1 file changed, 46 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etna=
viv/etnaviv_drv.c
> index 6591e420a051..809e5db85df4 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> @@ -41,6 +41,45 @@ static struct device_node *etnaviv_of_first_available_=
node(void)
>  	return NULL;
>  }
> =20
> +static struct etnaviv_drm_private *etnaviv_alloc_private(struct device *=
dev)
> +{
> +	struct etnaviv_drm_private *priv;
> +
> +	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return ERR_PTR(-ENOMEM);
> +
> +	xa_init_flags(&priv->active_contexts, XA_FLAGS_ALLOC);
> +
> +	mutex_init(&priv->gem_lock);
> +	INIT_LIST_HEAD(&priv->gem_list);
> +	priv->num_gpus =3D 0;
> +	priv->shm_gfp_mask =3D GFP_HIGHUSER | __GFP_RETRY_MAYFAIL | __GFP_NOWAR=
N;
> +
> +	priv->cmdbuf_suballoc =3D etnaviv_cmdbuf_suballoc_new(dev);
> +	if (IS_ERR(priv->cmdbuf_suballoc)) {

If this is supposed to do everything by the books, we should also
destroy the gem_lock mutex and active_contexts xarray here.

Regards,
Lucas

> +		kfree(priv);
> +		dev_err(dev, "Failed to create cmdbuf suballocator\n");
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	return priv;
> +}
> +
> +static void etnaviv_free_private(struct etnaviv_drm_private *priv)
> +{
> +	if (!priv)
> +		return;
> +
> +	etnaviv_cmdbuf_suballoc_destroy(priv->cmdbuf_suballoc);
> +
> +	xa_destroy(&priv->active_contexts);
> +
> +	mutex_destroy(&priv->gem_lock);
> +
> +	kfree(priv);
> +}
> +
>  static void load_gpu(struct drm_device *dev)
>  {
>  	struct etnaviv_drm_private *priv =3D dev->dev_private;
> @@ -521,35 +560,21 @@ static int etnaviv_bind(struct device *dev)
>  	if (IS_ERR(drm))
>  		return PTR_ERR(drm);
> =20
> -	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
> -	if (!priv) {
> -		dev_err(dev, "failed to allocate private data\n");
> -		ret =3D -ENOMEM;
> +	priv =3D etnaviv_alloc_private(dev);
> +	if (IS_ERR(priv)) {
> +		ret =3D PTR_ERR(priv);
>  		goto out_put;
>  	}
> +
>  	drm->dev_private =3D priv;
> =20
>  	dma_set_max_seg_size(dev, SZ_2G);
> =20
> -	xa_init_flags(&priv->active_contexts, XA_FLAGS_ALLOC);
> -
> -	mutex_init(&priv->gem_lock);
> -	INIT_LIST_HEAD(&priv->gem_list);
> -	priv->num_gpus =3D 0;
> -	priv->shm_gfp_mask =3D GFP_HIGHUSER | __GFP_RETRY_MAYFAIL | __GFP_NOWAR=
N;
> -
> -	priv->cmdbuf_suballoc =3D etnaviv_cmdbuf_suballoc_new(drm->dev);
> -	if (IS_ERR(priv->cmdbuf_suballoc)) {
> -		dev_err(drm->dev, "Failed to create cmdbuf suballocator\n");
> -		ret =3D PTR_ERR(priv->cmdbuf_suballoc);
> -		goto out_free_priv;
> -	}
> -
>  	dev_set_drvdata(dev, drm);
> =20
>  	ret =3D component_bind_all(dev, drm);
>  	if (ret < 0)
> -		goto out_destroy_suballoc;
> +		goto out_free_priv;
> =20
>  	load_gpu(drm);
> =20
> @@ -561,11 +586,8 @@ static int etnaviv_bind(struct device *dev)
> =20
>  out_unbind:
>  	component_unbind_all(dev, drm);
> -out_destroy_suballoc:
> -	etnaviv_cmdbuf_suballoc_destroy(priv->cmdbuf_suballoc);
>  out_free_priv:
> -	mutex_destroy(&priv->gem_lock);
> -	kfree(priv);
> +	etnaviv_free_private(priv);
>  out_put:
>  	drm_dev_put(drm);
> =20
> @@ -581,12 +603,9 @@ static void etnaviv_unbind(struct device *dev)
> =20
>  	component_unbind_all(dev, drm);
> =20
> -	etnaviv_cmdbuf_suballoc_destroy(priv->cmdbuf_suballoc);
> -
> -	xa_destroy(&priv->active_contexts);
> +	etnaviv_free_private(priv);
> =20
>  	drm->dev_private =3D NULL;
> -	kfree(priv);
> =20
>  	drm_dev_put(drm);
>  }


