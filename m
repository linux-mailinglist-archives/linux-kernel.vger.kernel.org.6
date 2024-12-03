Return-Path: <linux-kernel+bounces-429973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1755C9E2BC7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C935BA8375
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9638F1FCFF5;
	Tue,  3 Dec 2024 17:47:36 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA94A1FAC51
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 17:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733248056; cv=none; b=ZW/NQWtdL9XLFyvMo4AIeIGIXvKohS9n2VgW3af2cSIAnbCvyz9w1tn7OnCLkslGezK8HQpNPIrfGDHQ1l5b3m9BW/mHeYFGmEfeJDrgVWIPJNIZEOdUIr5KCpps7ZYGMNAzngZZI6+nSoHfQdwqnuhuJjq7VLjBBhI9tLN2S+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733248056; c=relaxed/simple;
	bh=Pnpk+LFPtPGDf8HcHyRlieS6pDvYfmta+c68oAQy++c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S1QgGaAMOkHxa2rtEpeUdJmYCdKw/JMuKmSJrbCvfjK1xAhMGUSm51LRb1me6boT4+n1BS43JGPvVp4HlnByzImCk+XaWRiTCjHiCHh21gkGJ+srpLPH4+RfXxLHz7LIvu0THwEbcYQEUBvyjvr7fSwXy4xM9kuT7jtKNDfuRzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1tIWzf-0004K2-Jw; Tue, 03 Dec 2024 18:47:27 +0100
Message-ID: <14b8f44c080aff186898ace67b636568a91bd7d3.camel@pengutronix.de>
Subject: Re: [PATCH v16] drm/etnaviv: Fix page property being used for non
 writecombine buffers
From: Lucas Stach <l.stach@pengutronix.de>
To: Sui Jingfeng <sui.jingfeng@linux.dev>, Russell King
 <linux+etnaviv@armlinux.org.uk>, Christian Gmeiner
 <christian.gmeiner@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 03 Dec 2024 18:47:27 +0100
In-Reply-To: <20241104004156.8635-1-sui.jingfeng@linux.dev>
References: <20241104004156.8635-1-sui.jingfeng@linux.dev>
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

Am Montag, dem 04.11.2024 um 08:41 +0800 schrieb Sui Jingfeng:
> In the etnaviv_gem_vmap_impl() function, the driver vmap whatever buffers
> with write combine(WC) page property, this is incorrect. Cached buffers
> should be mapped with the cached page property and uncached buffers shoul=
d
> be mapped with the uncached page property.
>=20
Thanks, applied to etnaviv/next.

Regards,
Lucas

> Fixes: a0a5ab3e99b8 ("drm/etnaviv: call correct function when trying to v=
map a DMABUF")
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> ---
> Split from my PCIe device driver wrapper support series, since this proba=
bly
> should be resend as a standalone patch.
>=20
> v15: Use `obj->flags & ETNA_BO_CACHE_MASK` (Lucas)
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gem.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etna=
viv/etnaviv_gem.c
> index d51843d9a476..d2cb9dded051 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> @@ -362,6 +362,7 @@ static void etnaviv_gem_object_vunmap(struct drm_gem_=
object *obj,
>  static void *etnaviv_gem_vmap_impl(struct etnaviv_gem_object *obj)
>  {
>  	struct page **pages;
> +	pgprot_t prot;
> =20
>  	lockdep_assert_held(&obj->lock);
> =20
> @@ -369,8 +370,19 @@ static void *etnaviv_gem_vmap_impl(struct etnaviv_ge=
m_object *obj)
>  	if (IS_ERR(pages))
>  		return NULL;
> =20
> -	return vmap(pages, obj->base.size >> PAGE_SHIFT,
> -			VM_MAP, pgprot_writecombine(PAGE_KERNEL));
> +	switch (obj->flags & ETNA_BO_CACHE_MASK) {
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


