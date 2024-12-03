Return-Path: <linux-kernel+bounces-429969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B69D9E29D2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 18:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 804F0160609
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5892B1FBE9B;
	Tue,  3 Dec 2024 17:46:22 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11471F892F
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 17:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733247982; cv=none; b=AAlnb7CBf88RSpPJhDsluwoe71Ve1LEQp3bjl297l7A8oaOgY1MRi1OB0dzoKYzXD4ltURGWPLaJ92EAtE9fDCR9peQCMDozDFY66XuNf8B3oebeQFCDzNVujQ+uKmx7BeLMZMZn2ytsMpYhnIkszEGiNaqNu8svyxWdBOMwDvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733247982; c=relaxed/simple;
	bh=8qUM+s0Bl7lCWEZpNYt3clTxFF5yfYs/BJyLD3pOnAE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jj9WLuBNAAsZSC0zvn8xbkhFPwNztoOEWkfmBAFS1P1PiTJ7PZ4wbVduoaTE6j8f5L+0ugmwbGPqLcxschZQmR0rACExb6cX5z2Ktxqj6hJDhaqyBt8V/kQu3hjRjI6iObP9tEOxnoTwC1BfIIAtRgawKkZXGRnkMdPFNcQUSqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1tIWyN-0003yC-P7; Tue, 03 Dec 2024 18:46:07 +0100
Message-ID: <fa93f48960c9ea5f5cb5693e6870e885fb1957ee.camel@pengutronix.de>
Subject: Re: [PATCH] drm/etnaviv: Add fdinfo support for memory stats
From: Lucas Stach <l.stach@pengutronix.de>
To: Christian Gmeiner <christian.gmeiner@gmail.com>, Russell King
	 <linux+etnaviv@armlinux.org.uk>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, tursulin@igalia.com, Christian Gmeiner
	 <cgmeiner@igalia.com>, etnaviv@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Tue, 03 Dec 2024 18:46:07 +0100
In-Reply-To: <20241121092409.3859592-1-christian.gmeiner@gmail.com>
References: <20241121092409.3859592-1-christian.gmeiner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
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

Am Donnerstag, dem 21.11.2024 um 10:24 +0100 schrieb Christian Gmeiner:
> From: Christian Gmeiner <cgmeiner@igalia.com>
>=20
> Use the new helper to export stats about memory usage.
>=20
Thanks, applied to etnaviv/next.

Regards,
Lucas

> Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c | 12 +++++++++++-
>  drivers/gpu/drm/etnaviv/etnaviv_gem.c | 12 ++++++++++++
>  2 files changed, 23 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etna=
viv/etnaviv_drv.c
> index 6500f3999c5f..35f47dd6367f 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> @@ -488,7 +488,16 @@ static const struct drm_ioctl_desc etnaviv_ioctls[] =
=3D {
>  	ETNA_IOCTL(PM_QUERY_SIG, pm_query_sig, DRM_RENDER_ALLOW),
>  };
> =20
> -DEFINE_DRM_GEM_FOPS(fops);
> +static void etnaviv_show_fdinfo(struct drm_printer *p, struct drm_file *=
file)
> +{
> +	drm_show_memory_stats(p, file);
> +}
> +
> +static const struct file_operations fops =3D {
> +	.owner =3D THIS_MODULE,
> +	DRM_GEM_FOPS,
> +	.show_fdinfo =3D drm_show_fdinfo,
> +};
> =20
>  static const struct drm_driver etnaviv_drm_driver =3D {
>  	.driver_features    =3D DRIVER_GEM | DRIVER_RENDER,
> @@ -498,6 +507,7 @@ static const struct drm_driver etnaviv_drm_driver =3D=
 {
>  #ifdef CONFIG_DEBUG_FS
>  	.debugfs_init       =3D etnaviv_debugfs_init,
>  #endif
> +	.show_fdinfo        =3D etnaviv_show_fdinfo,
>  	.ioctls             =3D etnaviv_ioctls,
>  	.num_ioctls         =3D DRM_ETNAVIV_NUM_IOCTLS,
>  	.fops               =3D &fops,
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etna=
viv/etnaviv_gem.c
> index 5c0c9d4e3be1..e81c261b0017 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> @@ -527,6 +527,17 @@ void etnaviv_gem_obj_add(struct drm_device *dev, str=
uct drm_gem_object *obj)
>  	mutex_unlock(&priv->gem_lock);
>  }
> =20
> +static enum drm_gem_object_status etnaviv_gem_status(struct drm_gem_obje=
ct *obj)
> +{
> +	struct etnaviv_gem_object *etnaviv_obj =3D to_etnaviv_bo(obj);
> +	enum drm_gem_object_status status =3D 0;
> +
> +	if (etnaviv_obj->pages)
> +		status |=3D DRM_GEM_OBJECT_RESIDENT;
> +
> +	return status;
> +}
> +
>  static const struct vm_operations_struct vm_ops =3D {
>  	.fault =3D etnaviv_gem_fault,
>  	.open =3D drm_gem_vm_open,
> @@ -540,6 +551,7 @@ static const struct drm_gem_object_funcs etnaviv_gem_=
object_funcs =3D {
>  	.get_sg_table =3D etnaviv_gem_prime_get_sg_table,
>  	.vmap =3D etnaviv_gem_prime_vmap,
>  	.mmap =3D etnaviv_gem_mmap,
> +	.status =3D etnaviv_gem_status,
>  	.vm_ops =3D &vm_ops,
>  };
> =20


