Return-Path: <linux-kernel+bounces-346050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C1098BEC1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B60012842A2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76B71C6892;
	Tue,  1 Oct 2024 13:59:07 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8421C57AB
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791147; cv=none; b=bYxe1OE0drSIeyoj1FuFVjIT4Uopaup7pHeFvJfwpj52fEcF9P2JuTFwCoryAW2QGL9N+2sJ4lMz6mTiVtjEC1Ltw2fD/80swUUIZrFpTjTkuyH/xKVDk/By46VMv2inwhproJLqCfXSms5nII33C6hpUB5fevYVQxDQFxskiRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791147; c=relaxed/simple;
	bh=QSfE/EfW3OmK0cqD9D+QRR0RvqdrthUzBExDMCdnBPk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i526JpkKZfriS0y4Uw6bkYJG5O6IrN+c+3f6Y4b7UgJzFBvapeZiml0rNHegy0MViAMbNKX5pA6Pl1jLJG5jdI96Dwhq/2D/dF3ku8KsQ8IvIp3P7esQ/ynAhofpH3DV9iaF+4I/sQuNmBtMKKSyIZtrxUSA84hKrBFWLzQsAgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1svdP2-0000gU-A8; Tue, 01 Oct 2024 15:59:00 +0200
Message-ID: <006d7bacd2df40b9d6bc8d36836a6c1dd6dfb939.camel@pengutronix.de>
Subject: Re: [PATCH v15 08/19] drm/etnaviv: Fix wrong caching mode being
 used for non writecombine buffers
From: Lucas Stach <l.stach@pengutronix.de>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>, Russell King
	 <linux+etnaviv@armlinux.org.uk>, dri-devel@lists.freedesktop.org, 
	etnaviv@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Tue, 01 Oct 2024 15:58:59 +0200
In-Reply-To: <20240908094357.291862-9-sui.jingfeng@linux.dev>
References: <20240908094357.291862-1-sui.jingfeng@linux.dev>
	 <20240908094357.291862-9-sui.jingfeng@linux.dev>
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
> In the etnaviv_gem_vmap_impl() function, the driver vmap whatever buffers
> with write combine(WC) page property. This is incorrect, as some platform=
s
> are cached coherent. Cached buffers should be mapped with cached page
> property.
>=20
> Fixes: a0a5ab3e99b8 ("drm/etnaviv: call correct function when trying to v=
map a DMABUF")
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gem.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etna=
viv/etnaviv_gem.c
> index 1fd2cff20ef4..b899aea64e22 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> @@ -393,6 +393,7 @@ static void etnaviv_gem_object_vunmap(struct drm_gem_=
object *obj,
>  static void *etnaviv_gem_vmap_impl(struct etnaviv_gem_object *obj)
>  {
>  	struct page **pages;
> +	pgprot_t prot;
> =20
>  	lockdep_assert_held(&obj->lock);
> =20
> @@ -400,8 +401,19 @@ static void *etnaviv_gem_vmap_impl(struct etnaviv_ge=
m_object *obj)
>  	if (IS_ERR(pages))
>  		return NULL;
> =20
> -	return vmap(pages, obj->base.size >> PAGE_SHIFT,
> -			VM_MAP, pgprot_writecombine(PAGE_KERNEL));
> +	switch (obj->flags) {

obj->flags & ETNA_BO_CACHE_MASK

> +	case ETNA_BO_CACHED:
> +		prot =3D PAGE_KERNEL;
> +		break;
> +	case ETNA_BO_UNCACHED:
> +		prot =3D pgprot_noncached(PAGE_KERNEL);
> +		break;
> +	case ETNA_BO_WC:
> +	default:
> +		prot =3D pgprot_writecombine(PAGE_KERNEL);
> +	}
> +
> +	return vmap(pages, obj->base.size >> PAGE_SHIFT, VM_MAP, prot);
>  }
> =20
>  static inline enum dma_data_direction etnaviv_op_to_dma_dir(u32 op)


