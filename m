Return-Path: <linux-kernel+bounces-175444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1248C1FCE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 10:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF4901C20CFB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A9C76020;
	Fri, 10 May 2024 08:35:00 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249264C8E
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 08:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715330099; cv=none; b=sCy8czvUph+dorH2y4s7U4H235teCHOA9UoMly3yuwPHp1cym72UgmHDDwM0FWfJSGsiS61XDLkQAkZsrLMci7xWkDa9W1VmANZGtEhmfbjoR8wYPLp1g7NUkgyCrMFdx9pxovcf3qZRFFyEcPYLMOd6kLDAM61pcwf57m/z4Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715330099; c=relaxed/simple;
	bh=vZWUoNmqRjHSrak22YzHspxbzh2s/o2BGk72PD9s83M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ht8YZPYreQEV1DSH1xtFiItMIH29eIWn9/DHUA+h7Nsff9L5A4NUhW+7cnYYhw8Yfo/ophVWsWXX54bMnXU8mkryRAhFBkeqsDvoe4Px7UtJbfAfWnAMFxmQ6BhMAF4lC5ZXS54LMUeRQsP1jrJhWFFD+unLK22oku4Ua9F6J/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1s5LiP-0003WU-RF; Fri, 10 May 2024 10:34:53 +0200
Message-ID: <97eadcba7cabe56f0f4b4d753bd3d53f8540ef4b.camel@pengutronix.de>
Subject: Re: [PATCH] drm/etnaviv: Create an accel device node if compute-only
From: Lucas Stach <l.stach@pengutronix.de>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, linux-kernel@vger.kernel.org
Cc: Oded Gabbay <ogabbay@kernel.org>, Russell King
 <linux+etnaviv@armlinux.org.uk>, Christian Gmeiner
 <christian.gmeiner@gmail.com>,  David Airlie <airlied@gmail.com>, Daniel
 Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
Date: Fri, 10 May 2024 10:34:47 +0200
In-Reply-To: <20240424063753.3740664-1-tomeu@tomeuvizoso.net>
References: <20240424063753.3740664-1-tomeu@tomeuvizoso.net>
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

Hi Tomeu,

Am Mittwoch, dem 24.04.2024 um 08:37 +0200 schrieb Tomeu Vizoso:
> If we expose a render node for NPUs without rendering capabilities, the
> userspace stack will offer it to compositors and applications for
> rendering, which of course won't work.
>=20
> Userspace is probably right in not questioning whether a render node
> might not be capable of supporting rendering, so change it in the kernel
> instead by exposing a /dev/accel node.
>=20
> Before we bring the device up we don't know whether it is capable of
> rendering or not (depends on the features of its blocks), so first try
> to probe a rendering node, and if we find out that there is no rendering
> hardware, abort and retry with an accel node.
>=20
I thought about this for a while. My opinion is that this is the wrong
approach. We are adding another path to the kernel driver, potentially
complicating the userspace side, as now the NPU backend needs to look
for both render and accel nodes. While currently accel and drm are
pretty closely related and we can share most of the driver, it might
still be a maintenance hassle in the long run.

On the other hand we already have precedence of compute only DRM
devices exposing a render node: there are AMD GPUs that don't expose a
graphics queue and are thus not able to actually render graphics. Mesa
already handles this in part via the PIPE_CAP_GRAPHICS and I think we
should simply extend this to not offer a EGL display on screens without
that capability.

Regards,
Lucas

> Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
> Cc: Oded Gabbay <ogabbay@kernel.org>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c | 46 ++++++++++++++++++++++-----
>  1 file changed, 38 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etna=
viv/etnaviv_drv.c
> index 6500f3999c5f..8e7dd23115f4 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> @@ -11,6 +11,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/uaccess.h>
> =20
> +#include <drm/drm_accel.h>
>  #include <drm/drm_debugfs.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_file.h>
> @@ -488,10 +489,10 @@ static const struct drm_ioctl_desc etnaviv_ioctls[]=
 =3D {
>  	ETNA_IOCTL(PM_QUERY_SIG, pm_query_sig, DRM_RENDER_ALLOW),
>  };
> =20
> -DEFINE_DRM_GEM_FOPS(fops);
> +DEFINE_DRM_GEM_FOPS(render_fops);
> +DEFINE_DRM_ACCEL_FOPS(accel_fops);
> =20
> -static const struct drm_driver etnaviv_drm_driver =3D {
> -	.driver_features    =3D DRIVER_GEM | DRIVER_RENDER,
> +static struct drm_driver etnaviv_drm_driver =3D {
>  	.open               =3D etnaviv_open,
>  	.postclose           =3D etnaviv_postclose,
>  	.gem_prime_import_sg_table =3D etnaviv_gem_prime_import_sg_table,
> @@ -500,7 +501,6 @@ static const struct drm_driver etnaviv_drm_driver =3D=
 {
>  #endif
>  	.ioctls             =3D etnaviv_ioctls,
>  	.num_ioctls         =3D DRM_ETNAVIV_NUM_IOCTLS,
> -	.fops               =3D &fops,
>  	.name               =3D "etnaviv",
>  	.desc               =3D "etnaviv DRM",
>  	.date               =3D "20151214",
> @@ -508,15 +508,20 @@ static const struct drm_driver etnaviv_drm_driver =
=3D {
>  	.minor              =3D 4,
>  };
> =20
> -/*
> - * Platform driver:
> - */
> -static int etnaviv_bind(struct device *dev)
> +static int etnaviv_bind_with_type(struct device *dev, u32 type)
>  {
>  	struct etnaviv_drm_private *priv;
>  	struct drm_device *drm;
> +	bool is_compute_only =3D true;
>  	int ret;
> =20
> +	etnaviv_drm_driver.driver_features =3D DRIVER_GEM | type;
> +
> +	if (type =3D=3D DRIVER_RENDER)
> +		etnaviv_drm_driver.fops =3D &render_fops;
> +	else
> +		etnaviv_drm_driver.fops =3D &accel_fops;
> +
>  	drm =3D drm_dev_alloc(&etnaviv_drm_driver, dev);
>  	if (IS_ERR(drm))
>  		return PTR_ERR(drm);
> @@ -553,6 +558,18 @@ static int etnaviv_bind(struct device *dev)
> =20
>  	load_gpu(drm);
> =20
> +	for (unsigned int i =3D 0; i < ETNA_MAX_PIPES; i++) {
> +		struct etnaviv_gpu *g =3D priv->gpu[i];
> +
> +		if (g && (g->identity.minor_features8 & chipMinorFeatures8_COMPUTE_ONL=
Y) =3D=3D 0)
> +			is_compute_only =3D false;
> +	}
> +
> +	if (type =3D=3D DRIVER_RENDER && is_compute_only) {
> +		ret =3D -EINVAL;
> +		goto out_unbind;
> +	}
> +
>  	ret =3D drm_dev_register(drm, 0);
>  	if (ret)
>  		goto out_unbind;
> @@ -571,6 +588,19 @@ static int etnaviv_bind(struct device *dev)
>  	return ret;
>  }
> =20
> +/*
> + * Platform driver:
> + */
> +static int etnaviv_bind(struct device *dev)
> +{
> +	int ret =3D etnaviv_bind_with_type(dev, DRIVER_RENDER);
> +
> +	if (ret =3D=3D -EINVAL)
> +		return etnaviv_bind_with_type(dev, DRIVER_COMPUTE_ACCEL);
> +
> +	return ret;
> +}
> +
>  static void etnaviv_unbind(struct device *dev)
>  {
>  	struct drm_device *drm =3D dev_get_drvdata(dev);


