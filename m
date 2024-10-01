Return-Path: <linux-kernel+bounces-346143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE1D98C03E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD4D71F22276
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380091C8FAE;
	Tue,  1 Oct 2024 14:39:12 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606241C8FA0
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727793551; cv=none; b=W9ICrHEJsnXJu/Lbf780saBcC5qU9jARSngx04i5Tr0M6vMoZLInhxlu9va8NdM7E0e1D7wKv25GXiKS6vX9/C0Bu7u5DwcKQjzrOeDX64wmBPURBKNfeYHrwnNDaNu/+lCd1Se98wFKx/meGiTDRtdwWDyicOb+TQaofR29HA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727793551; c=relaxed/simple;
	bh=y27Ihc/0icryEUWdEXYZzt0Rc2dmGVbWel11HD6Aiho=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=taAGaRHuLSOILXV8MozessxY5o1SqZ1xdcyw3Dox6TiF9ieyFeFT7MdFhVbLv9SJ/3XYkwNTo9wRGPKmI4QmBV62nANA7i/mxsTNom+FDCf4jDOGM667euPgws9NZc8G4q/mgZ1Y4e6KCSO3ClN4qIJgmRkpri5lso0TjhPYLzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1sve1m-0006jp-2R; Tue, 01 Oct 2024 16:39:02 +0200
Message-ID: <67cce03c96f5e4d08d837b77c723fdaf214f7c0d.camel@pengutronix.de>
Subject: Re: [PATCH v15 16/19] drm/etnaviv: Call etnaviv_gem_obj_add() in
 ernaviv_gem_new_private()
From: Lucas Stach <l.stach@pengutronix.de>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>, Russell King
	 <linux+etnaviv@armlinux.org.uk>, dri-devel@lists.freedesktop.org, 
	etnaviv@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Tue, 01 Oct 2024 16:39:01 +0200
In-Reply-To: <20240908094357.291862-17-sui.jingfeng@linux.dev>
References: <20240908094357.291862-1-sui.jingfeng@linux.dev>
	 <20240908094357.291862-17-sui.jingfeng@linux.dev>
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
> The etnaviv_gem_obj_add() a common operation, the 'etnaviv_drm_private::
> gem_list' is being used to record(track) all of the etnaviv GEM buffer
> object created in this driver.
>=20
> Once a etnaviv GEM buffer object has been allocated successfully, we
> should add it into the global etnaviv_drm_private::gem_list'. Because
> we need to free it and remove it free the list if the invoke of the
> subsequent functions fail.
>=20
> The only way that destroy etnaviv GEM buffer object is the implementation
> of etnaviv_gem_free_object() function. The etnaviv_gem_free_object() firs=
t
> remove the etnaviv GEM object from the list, then destroy its mapping and
> finally free its memory footprint. Therefore, in order to corresponding
> this, we add the freshly created etnaviv GEM buffer object immediately
> after it was successfully created.
>=20
> A benifit is that we only need to call etnaviv_gem_obj_add() once now,
> since the ernaviv_gem_new_private() has been unified. Make the
> etnaviv_gem_obj_add() static is a next nature thing.
>=20
Seeing this patch, I would really ask you to drop patch 11 from this
series and go the other way around: remove etnaviv_gem_obj_add() here
altogether and simply inline the few lines of code into
etnaviv_gem_new_private().

Regards,
Lucas

> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gem.c       | 8 +++-----
>  drivers/gpu/drm/etnaviv/etnaviv_gem.h       | 1 -
>  drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c | 2 --
>  3 files changed, 3 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etna=
viv/etnaviv_gem.c
> index 27e4a93c981c..ee799c02d0aa 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> @@ -584,7 +584,7 @@ void etnaviv_gem_free_object(struct drm_gem_object *o=
bj)
>  	kfree(etnaviv_obj);
>  }
> =20
> -void etnaviv_gem_obj_add(struct drm_device *dev, struct drm_gem_object *=
obj)
> +static void etnaviv_gem_obj_add(struct drm_device *dev, struct drm_gem_o=
bject *obj)
>  {
>  	struct etnaviv_drm_private *priv =3D to_etnaviv_priv(dev);
>  	struct etnaviv_gem_object *etnaviv_obj =3D to_etnaviv_bo(obj);
> @@ -719,8 +719,6 @@ int etnaviv_gem_new_handle(struct drm_device *dev, st=
ruct drm_file *file,
>  	 */
>  	mapping_set_gfp_mask(obj->filp->f_mapping, priv->shm_gfp_mask);
> =20
> -	etnaviv_gem_obj_add(dev, obj);
> -
>  	ret =3D drm_gem_handle_create(file, obj, handle);
> =20
>  	/* drop reference from allocate - handle holds it now */
> @@ -751,6 +749,8 @@ int etnaviv_gem_new_private(struct drm_device *dev, s=
ize_t size, u32 flags,
>  		drm_gem_private_object_init(dev, obj, size);
>  	}
> =20
> +	etnaviv_gem_obj_add(dev, obj);
> +
>  	*res =3D to_etnaviv_bo(obj);
> =20
>  	return 0;
> @@ -849,8 +849,6 @@ int etnaviv_gem_new_userptr(struct drm_device *dev, s=
truct drm_file *file,
>  	etnaviv_obj->userptr.mm =3D current->mm;
>  	etnaviv_obj->userptr.ro =3D !(flags & ETNA_USERPTR_WRITE);
> =20
> -	etnaviv_gem_obj_add(dev, &etnaviv_obj->base);
> -
>  	ret =3D drm_gem_handle_create(file, &etnaviv_obj->base, handle);
> =20
>  	/* drop reference from allocate - handle holds it now */
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.h b/drivers/gpu/drm/etna=
viv/etnaviv_gem.h
> index b174a9e4cc48..8d8fc5b3a541 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.h
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.h
> @@ -121,7 +121,6 @@ int etnaviv_gem_new_private(struct drm_device *dev, s=
ize_t size, u32 flags,
>  			    bool shmem, const struct etnaviv_gem_ops *ops,
>  			    struct etnaviv_gem_object **res);
> =20
> -void etnaviv_gem_obj_add(struct drm_device *dev, struct drm_gem_object *=
obj);
>  struct page **etnaviv_gem_get_pages(struct etnaviv_gem_object *obj);
>  void etnaviv_gem_put_pages(struct etnaviv_gem_object *obj);
> =20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c b/drivers/gpu/dr=
m/etnaviv/etnaviv_gem_prime.c
> index 64a858a0b0cf..04ee31461b8c 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> @@ -127,8 +127,6 @@ struct drm_gem_object *etnaviv_gem_prime_import_sg_ta=
ble(struct drm_device *dev,
>  	if (ret)
>  		goto fail;
> =20
> -	etnaviv_gem_obj_add(dev, &etnaviv_obj->base);
> -
>  	return &etnaviv_obj->base;
> =20
>  fail:


