Return-Path: <linux-kernel+bounces-346038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF58198BE9F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93904287426
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6A61CC158;
	Tue,  1 Oct 2024 13:52:04 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44271CBE90
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 13:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790723; cv=none; b=E6xN8xUi8dzxC8lCzA0qhgw8l2wWIs7SwewGX0Le3InCjj2IMYrAIw7Tuxey9kM2DQRxtzCn62k7/O0Q3oZxRhfqMw5+AXMo+eukrLO3j3Eb44mjBrbfOCay2d6tbUqAybSQgcOaCojwiSQwfBVcDmyj3o1MzQ/n2AfVSTbqClo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790723; c=relaxed/simple;
	bh=OFbZ43A3ubL2ASRArjWjRb9ZoQjZPVm8DauPsKFCEaw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XeW/UOp9Ct2i5hjpH/bBGIieL5IV6Om4V8P5I1eHFKoATMJhC/vTyj448TKyheT9fsJJyWRHxhC8n5G0fYrP6KogHe7rge3NdqP2+pfiAaGPwONwULo2Tr44DBdG50djyXNP2lLbGiY5dCh4Qp06obriGLhNU69Ew8fveLIVGzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1svdID-0005Al-Mh; Tue, 01 Oct 2024 15:51:57 +0200
Message-ID: <663c5f6f0610b7d3b47b115a51320f0eac7c4c06.camel@pengutronix.de>
Subject: Re: [PATCH v15 05/19] drm/etnaviv: Add contructor and destructor
 for etnaviv_gem_get_mapping structure
From: Lucas Stach <l.stach@pengutronix.de>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>, Russell King
	 <linux+etnaviv@armlinux.org.uk>, dri-devel@lists.freedesktop.org, 
	etnaviv@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Tue, 01 Oct 2024 15:51:57 +0200
In-Reply-To: <20240908094357.291862-6-sui.jingfeng@linux.dev>
References: <20240908094357.291862-1-sui.jingfeng@linux.dev>
	 <20240908094357.291862-6-sui.jingfeng@linux.dev>
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
> Because this make the code more easier to understand, When GPU access the
> VRAM, it will allocate a new mapping to use if there don't have one.
>=20
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gem.c | 40 +++++++++++++++++++--------
>  drivers/gpu/drm/etnaviv/etnaviv_gem.h |  6 ++++
>  2 files changed, 34 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etna=
viv/etnaviv_gem.c
> index 85d4e7c87a6a..55004fa9fabd 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> @@ -227,6 +227,30 @@ etnaviv_gem_get_vram_mapping(struct etnaviv_gem_obje=
ct *obj,
>  	return NULL;
>  }
> =20
> +static struct etnaviv_vram_mapping *
> +etnaviv_gem_vram_mapping_new(struct etnaviv_gem_object *etnaviv_obj)
> +{
> +	struct etnaviv_vram_mapping *mapping;
> +
> +	mapping =3D kzalloc(sizeof(*mapping), GFP_KERNEL);
> +	if (!mapping)
> +		return NULL;
> +
> +	INIT_LIST_HEAD(&mapping->scan_node);
> +	mapping->object =3D etnaviv_obj;
> +	mapping->use =3D 1;
> +
> +	list_add_tail(&mapping->obj_node, &etnaviv_obj->vram_list);
> +
> +	return mapping;
> +}
> +
> +static void etnaviv_gem_vram_mapping_destroy(struct etnaviv_vram_mapping=
 *mapping)
> +{
> +	list_del(&mapping->obj_node);
> +	kfree(mapping);
> +}
> +
>  void etnaviv_gem_mapping_unreference(struct etnaviv_vram_mapping *mappin=
g)
>  {
>  	struct etnaviv_gem_object *etnaviv_obj =3D mapping->object;
> @@ -289,27 +313,20 @@ struct etnaviv_vram_mapping *etnaviv_gem_mapping_ge=
t(
>  	 */
>  	mapping =3D etnaviv_gem_get_vram_mapping(etnaviv_obj, NULL);
>  	if (!mapping) {
> -		mapping =3D kzalloc(sizeof(*mapping), GFP_KERNEL);
> +		mapping =3D etnaviv_gem_vram_mapping_new(etnaviv_obj);
>  		if (!mapping) {
>  			ret =3D -ENOMEM;
>  			goto out;
>  		}
> -
> -		INIT_LIST_HEAD(&mapping->scan_node);
> -		mapping->object =3D etnaviv_obj;
>  	} else {
> -		list_del(&mapping->obj_node);
> +		mapping->use =3D 1;
>  	}
> =20
> -	mapping->use =3D 1;
> -
>  	ret =3D etnaviv_iommu_map_gem(mmu_context, etnaviv_obj,
>  				    mmu_context->global->memory_base,
>  				    mapping, va);
>  	if (ret < 0)
> -		kfree(mapping);
> -	else
> -		list_add_tail(&mapping->obj_node, &etnaviv_obj->vram_list);
> +		etnaviv_gem_vram_mapping_destroy(mapping);
> =20
>  out:
>  	mutex_unlock(&etnaviv_obj->lock);
> @@ -544,8 +561,7 @@ void etnaviv_gem_free_object(struct drm_gem_object *o=
bj)
>  		if (context)
>  			etnaviv_iommu_unmap_gem(context, mapping);
> =20
> -		list_del(&mapping->obj_node);
> -		kfree(mapping);
> +		etnaviv_gem_vram_mapping_destroy(mapping);
>  	}
> =20
>  	etnaviv_obj->ops->vunmap(etnaviv_obj);
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.h b/drivers/gpu/drm/etna=
viv/etnaviv_gem.h
> index d4965de3007c..f2ac64d8e90b 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.h
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.h
> @@ -31,6 +31,12 @@ struct etnaviv_vram_mapping {
>  	u32 iova;
>  };
> =20
> +static inline struct etnaviv_vram_mapping *
> +to_etnaviv_vram_mapping(struct drm_mm_node *vram)
> +{
> +	return container_of(vram, struct etnaviv_vram_mapping, vram_node);
> +}
> +
This hunk looks unrelated to this patch. Otherwise patch looks good.

Regards,
Lucas

>  struct etnaviv_gem_object {
>  	struct drm_gem_object base;
>  	const struct etnaviv_gem_ops *ops;


