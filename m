Return-Path: <linux-kernel+bounces-305002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2057B9627F0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A183A1F24F91
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4032E17AE0C;
	Wed, 28 Aug 2024 12:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ArbjxBj3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB25117BED6
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 12:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724849840; cv=none; b=So63YLVImqewm2K+h6O3pzbb4gdVCfTcWHoGMgfqPJiYRhuTO0cBuYF3lW0NINdWqzyeYiTXCvXZuO444VREinjaWmDWmLkrSZza4icQ2bzJcJ/j2qcLTZEgR7hkdR5haHG+c3cUK0HOjJDUd4HdeUJ/M/Toj8MvRUXcsmATcdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724849840; c=relaxed/simple;
	bh=EXRf8xcwu7HGERZuO8oLu3cM6L2Z1Ajtvf6sRzj5QV0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eUQ5UoPVDRkVoDHmkcoFJ2ikH/GMAZuArrCZvW90z9lXBrUyGP5RNL4L9xKn9NbBpDTCi14sC2p9oiXEckNEAOoey9bCpU8aRckLpOBH22tX9pvP9nEDYeDcOJVV+rtB2t1XBKC7ZjjCbM3liKrKAYJYjqTkdXTrArtTMRBCjd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ArbjxBj3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724849837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IObnPhTVGYc0oDOQLNaca7it9FDta78II2gOMX6ooMA=;
	b=ArbjxBj3tvsZl+I4zObqeDRNuI6vdDf1UnxUcCeCMz7oWKij9FmP/x6zlV/qyRs6KNR8R0
	hNw/9jUlvVcWJVWId/5dDhsZFsvHJNi9JqC/R6NvDh56R2ZNs7J798KX163HspW9qC/J5r
	QQiKU7WVz6AsVvuzrm4swIYSOVGfhJQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-vd0UcT0gOJ2o3Yi-Lu6h4g-1; Wed, 28 Aug 2024 08:57:16 -0400
X-MC-Unique: vd0UcT0gOJ2o3Yi-Lu6h4g-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4280d8e685eso60991995e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 05:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724849835; x=1725454635;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IObnPhTVGYc0oDOQLNaca7it9FDta78II2gOMX6ooMA=;
        b=ckJleNx4qNP3VacbYFt41Rhs28lVN5dPwpN1HNoeikKfpn/wd5UEt6QU1Rsds3ie1n
         irq6qmklEHS3mEJ9f6UIPsieVPYde8I39vhiLS9FAN/GRG2g1HwmY4onngpIYgD308j3
         qV5GxiuA2AlAByl0twYOaW4Da29hB0gphq3A9C/qUQZQgEIukQ/16LFzyoKR/xXNOV7H
         KBl2wOYal7iU1zXm0/7LLRSwVpeI5cQqcJlxl9pLNc/hiqoxzSHi6pODw3LWn9/6FosH
         qa0iz+z9s9qQqmkk0pOF64/ovI3IH7Y4uiC+BrWERVSoZC/qSRyHgdP6Y+eVHd+0KBoV
         +kzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUut2J2GN9ySGIE/M0MOovTxVxVe6Ad5aEBoQfjRNDrMDGOl0NVh4+HijXJiejwN9Gqfkn936ebuFy5Yjw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs7fv4OwvJYd6MdhynDnCrF1lE4tEa7X1jgcNG51Kgh0NRAuCM
	6TjcA2IbVPVmDzsn7taXS04hU2N/WTx5uKzAMqi9y2SieL4hv9981SZ+Vb8B9+uAlkD6Jr+suOK
	rQrl/ZDOsXyUcHD93BfxyVF1X2tZ4MfbuAJP5LYOvdp9YCoc54hvmZ6KofjsD0Q==
X-Received: by 2002:a05:6000:b8e:b0:36d:2984:ef6b with SMTP id ffacd0b85a97d-37311888373mr10696349f8f.11.1724849834862;
        Wed, 28 Aug 2024 05:57:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcGzZzODngC+pGZEJw8FL8ceFblDSz/vUkxp8vzzvF3O0hg/Y0wZ4RAVeE2/uUuSRD5b5IDQ==
X-Received: by 2002:a05:6000:b8e:b0:36d:2984:ef6b with SMTP id ffacd0b85a97d-37311888373mr10696329f8f.11.1724849834290;
        Wed, 28 Aug 2024 05:57:14 -0700 (PDT)
Received: from dhcp-64-16.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730811042bsm15792010f8f.4.2024.08.28.05.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 05:57:13 -0700 (PDT)
Message-ID: <75c06da11741d46cd67dbb685b7473ae94c2feb5.camel@redhat.com>
Subject: Re: [PATCH] drm/meson: switch to a managed drm device
From: Philipp Stanner <pstanner@redhat.com>
To: Anastasia Belova <abelova@astralinux.ru>, Neil Armstrong
	 <neil.armstrong@linaro.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Kevin Hilman
 <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>,
 dri-devel@lists.freedesktop.org,  linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
Date: Wed, 28 Aug 2024 14:57:12 +0200
In-Reply-To: <20240828110421.14956-1-abelova@astralinux.ru>
References: <20240828110421.14956-1-abelova@astralinux.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-28 at 14:04 +0300, Anastasia Belova wrote:
> Switch to a managed drm device to cleanup some error handling
> and make future work easier.

It's best to state what the current situation is like and then how this
patch addresses it.

If the cleanup topic is separate from the addressed NULL pointer issue
referenced below, it might make sense to split it into two patches, one
that does the cleanup, and another that addresses the NULL pointer
deref.

>=20
> Fix dereference of NULL in meson_drv_bind_master by removing
> drm_dev_put(drm) before meson_encoder_*_remove where drm
> dereferenced.

(-> "where drm *is* dereferenced" )

Can this be backported to older versions?

If yes, stable@vger.kernel.org should be put on CC.


>=20
> Co-developed by Linux Verification Center (linuxtesting.org).
>=20
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>

Should also include:

Cc: stable@vger.kernel.org # vX.Y
Fixes: <commit>

=D0=A1=D0=BF=D0=B0=D1=81=D0=B8=D0=B1=D0=BE,
P.

> ---
> =C2=A0drivers/gpu/drm/meson/meson_crtc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 10 +--
> =C2=A0drivers/gpu/drm/meson/meson_drv.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 71 ++++++++++----------
> --
> =C2=A0drivers/gpu/drm/meson/meson_drv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0drivers/gpu/drm/meson/meson_encoder_cvbs.c |=C2=A0 8 +--
> =C2=A0drivers/gpu/drm/meson/meson_overlay.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 8 +--
> =C2=A0drivers/gpu/drm/meson/meson_plane.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 10 +--
> =C2=A06 files changed, 51 insertions(+), 58 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/meson/meson_crtc.c
> b/drivers/gpu/drm/meson/meson_crtc.c
> index d70616da8ce2..e1c0bf3baeea 100644
> --- a/drivers/gpu/drm/meson/meson_crtc.c
> +++ b/drivers/gpu/drm/meson/meson_crtc.c
> @@ -662,13 +662,13 @@ void meson_crtc_irq(struct meson_drm *priv)
> =C2=A0
> =C2=A0	drm_crtc_handle_vblank(priv->crtc);
> =C2=A0
> -	spin_lock_irqsave(&priv->drm->event_lock, flags);
> +	spin_lock_irqsave(&priv->drm.event_lock, flags);
> =C2=A0	if (meson_crtc->event) {
> =C2=A0		drm_crtc_send_vblank_event(priv->crtc, meson_crtc-
> >event);
> =C2=A0		drm_crtc_vblank_put(priv->crtc);
> =C2=A0		meson_crtc->event =3D NULL;
> =C2=A0	}
> -	spin_unlock_irqrestore(&priv->drm->event_lock, flags);
> +	spin_unlock_irqrestore(&priv->drm.event_lock, flags);
> =C2=A0}
> =C2=A0
> =C2=A0int meson_crtc_create(struct meson_drm *priv)
> @@ -677,18 +677,18 @@ int meson_crtc_create(struct meson_drm *priv)
> =C2=A0	struct drm_crtc *crtc;
> =C2=A0	int ret;
> =C2=A0
> -	meson_crtc =3D devm_kzalloc(priv->drm->dev,
> sizeof(*meson_crtc),
> +	meson_crtc =3D devm_kzalloc(priv->drm.dev,
> sizeof(*meson_crtc),
> =C2=A0				=C2=A0 GFP_KERNEL);
> =C2=A0	if (!meson_crtc)
> =C2=A0		return -ENOMEM;
> =C2=A0
> =C2=A0	meson_crtc->priv =3D priv;
> =C2=A0	crtc =3D &meson_crtc->base;
> -	ret =3D drm_crtc_init_with_planes(priv->drm, crtc,
> +	ret =3D drm_crtc_init_with_planes(&priv->drm, crtc,
> =C2=A0					priv->primary_plane, NULL,
> =C2=A0					&meson_crtc_funcs,
> "meson_crtc");
> =C2=A0	if (ret) {
> -		dev_err(priv->drm->dev, "Failed to init CRTC\n");
> +		dev_err(priv->drm.dev, "Failed to init CRTC\n");
> =C2=A0		return ret;
> =C2=A0	}
> =C2=A0
> diff --git a/drivers/gpu/drm/meson/meson_drv.c
> b/drivers/gpu/drm/meson/meson_drv.c
> index 4bd0baa2a4f5..2e7c2e7c7b82 100644
> --- a/drivers/gpu/drm/meson/meson_drv.c
> +++ b/drivers/gpu/drm/meson/meson_drv.c
> @@ -182,7 +182,6 @@ static int meson_drv_bind_master(struct device
> *dev, bool has_components)
> =C2=A0	struct platform_device *pdev =3D to_platform_device(dev);
> =C2=A0	const struct meson_drm_match_data *match;
> =C2=A0	struct meson_drm *priv;
> -	struct drm_device *drm;
> =C2=A0	struct resource *res;
> =C2=A0	void __iomem *regs;
> =C2=A0	int ret, i;
> @@ -197,17 +196,13 @@ static int meson_drv_bind_master(struct device
> *dev, bool has_components)
> =C2=A0	if (!match)
> =C2=A0		return -ENODEV;
> =C2=A0
> -	drm =3D drm_dev_alloc(&meson_driver, dev);
> -	if (IS_ERR(drm))
> -		return PTR_ERR(drm);
> +	priv =3D devm_drm_dev_alloc(dev, &meson_driver,
> +				 struct meson_drm, drm);
> =C2=A0
> -	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> -	if (!priv) {
> -		ret =3D -ENOMEM;
> -		goto free_drm;
> -	}
> -	drm->dev_private =3D priv;
> -	priv->drm =3D drm;
> +	if (IS_ERR(priv))
> +		return PTR_ERR(priv);
> +
> +	priv->drm.dev_private =3D priv;
> =C2=A0	priv->dev =3D dev;
> =C2=A0	priv->compat =3D match->compat;
> =C2=A0	priv->afbcd.ops =3D match->afbcd_ops;
> @@ -215,7 +210,7 @@ static int meson_drv_bind_master(struct device
> *dev, bool has_components)
> =C2=A0	regs =3D devm_platform_ioremap_resource_byname(pdev, "vpu");
> =C2=A0	if (IS_ERR(regs)) {
> =C2=A0		ret =3D PTR_ERR(regs);
> -		goto free_drm;
> +		goto remove_encoders;
> =C2=A0	}
> =C2=A0
> =C2=A0	priv->io_base =3D regs;
> @@ -223,13 +218,13 @@ static int meson_drv_bind_master(struct device
> *dev, bool has_components)
> =C2=A0	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
> "hhi");
> =C2=A0	if (!res) {
> =C2=A0		ret =3D -EINVAL;
> -		goto free_drm;
> +		goto remove_encoders;
> =C2=A0	}
> =C2=A0	/* Simply ioremap since it may be a shared register zone */
> =C2=A0	regs =3D devm_ioremap(dev, res->start, resource_size(res));
> =C2=A0	if (!regs) {
> =C2=A0		ret =3D -EADDRNOTAVAIL;
> -		goto free_drm;
> +		goto remove_encoders;
> =C2=A0	}
> =C2=A0
> =C2=A0	priv->hhi =3D devm_regmap_init_mmio(dev, regs,
> @@ -237,18 +232,18 @@ static int meson_drv_bind_master(struct device
> *dev, bool has_components)
> =C2=A0	if (IS_ERR(priv->hhi)) {
> =C2=A0		dev_err(&pdev->dev, "Couldn't create the HHI
> regmap\n");
> =C2=A0		ret =3D PTR_ERR(priv->hhi);
> -		goto free_drm;
> +		goto remove_encoders;
> =C2=A0	}
> =C2=A0
> =C2=A0	priv->canvas =3D meson_canvas_get(dev);
> =C2=A0	if (IS_ERR(priv->canvas)) {
> =C2=A0		ret =3D PTR_ERR(priv->canvas);
> -		goto free_drm;
> +		goto remove_encoders;
> =C2=A0	}
> =C2=A0
> =C2=A0	ret =3D meson_canvas_alloc(priv->canvas, &priv-
> >canvas_id_osd1);
> =C2=A0	if (ret)
> -		goto free_drm;
> +		goto remove_encoders;
> =C2=A0	ret =3D meson_canvas_alloc(priv->canvas, &priv-
> >canvas_id_vd1_0);
> =C2=A0	if (ret)
> =C2=A0		goto free_canvas_osd1;
> @@ -261,7 +256,7 @@ static int meson_drv_bind_master(struct device
> *dev, bool has_components)
> =C2=A0
> =C2=A0	priv->vsync_irq =3D platform_get_irq(pdev, 0);
> =C2=A0
> -	ret =3D drm_vblank_init(drm, 1);
> +	ret =3D drm_vblank_init(&priv->drm, 1);
> =C2=A0	if (ret)
> =C2=A0		goto free_canvas_vd1_2;
> =C2=A0
> @@ -284,10 +279,10 @@ static int meson_drv_bind_master(struct device
> *dev, bool has_components)
> =C2=A0	ret =3D drmm_mode_config_init(drm);
> =C2=A0	if (ret)
> =C2=A0		goto free_canvas_vd1_2;
> -	drm->mode_config.max_width =3D 3840;
> -	drm->mode_config.max_height =3D 2160;
> -	drm->mode_config.funcs =3D &meson_mode_config_funcs;
> -	drm->mode_config.helper_private	=3D
> &meson_mode_config_helpers;
> +	priv->drm.mode_config.max_width =3D 3840;
> +	priv->drm.mode_config.max_height =3D 2160;
> +	priv->drm.mode_config.funcs =3D &meson_mode_config_funcs;
> +	priv->drm.mode_config.helper_private =3D
> &meson_mode_config_helpers;
> =C2=A0
> =C2=A0	/* Hardware Initialization */
> =C2=A0
> @@ -308,9 +303,9 @@ static int meson_drv_bind_master(struct device
> *dev, bool has_components)
> =C2=A0		goto exit_afbcd;
> =C2=A0
> =C2=A0	if (has_components) {
> -		ret =3D component_bind_all(dev, drm);
> +		ret =3D component_bind_all(dev, &priv->drm);
> =C2=A0		if (ret) {
> -			dev_err(drm->dev, "Couldn't bind all
> components\n");
> +			dev_err(priv->drm.dev, "Couldn't bind all
> components\n");
> =C2=A0			/* Do not try to unbind */
> =C2=A0			has_components =3D false;
> =C2=A0			goto exit_afbcd;
> @@ -339,26 +334,26 @@ static int meson_drv_bind_master(struct device
> *dev, bool has_components)
> =C2=A0	if (ret)
> =C2=A0		goto exit_afbcd;
> =C2=A0
> -	ret =3D request_irq(priv->vsync_irq, meson_irq, 0, drm-
> >driver->name, drm);
> +	ret =3D request_irq(priv->vsync_irq, meson_irq, 0, priv-
> >drm.driver->name, &priv->drm);
> =C2=A0	if (ret)
> =C2=A0		goto exit_afbcd;
> =C2=A0
> -	drm_mode_config_reset(drm);
> +	drm_mode_config_reset(&priv->drm);
> =C2=A0
> -	drm_kms_helper_poll_init(drm);
> +	drm_kms_helper_poll_init(&priv->drm);
> =C2=A0
> =C2=A0	platform_set_drvdata(pdev, priv);
> =C2=A0
> -	ret =3D drm_dev_register(drm, 0);
> +	ret =3D drm_dev_register(&priv->drm, 0);
> =C2=A0	if (ret)
> =C2=A0		goto uninstall_irq;
> =C2=A0
> -	drm_fbdev_dma_setup(drm, 32);
> +	drm_fbdev_dma_setup(&priv->drm, 32);
> =C2=A0
> =C2=A0	return 0;
> =C2=A0
> =C2=A0uninstall_irq:
> -	free_irq(priv->vsync_irq, drm);
> +	free_irq(priv->vsync_irq, &priv->drm);
> =C2=A0exit_afbcd:
> =C2=A0	if (priv->afbcd.ops)
> =C2=A0		priv->afbcd.ops->exit(priv);
> @@ -370,15 +365,14 @@ static int meson_drv_bind_master(struct device
> *dev, bool has_components)
> =C2=A0	meson_canvas_free(priv->canvas, priv->canvas_id_vd1_0);
> =C2=A0free_canvas_osd1:
> =C2=A0	meson_canvas_free(priv->canvas, priv->canvas_id_osd1);
> -free_drm:
> -	drm_dev_put(drm);
> +remove_encoders:
> =C2=A0
> =C2=A0	meson_encoder_dsi_remove(priv);
> =C2=A0	meson_encoder_hdmi_remove(priv);
> =C2=A0	meson_encoder_cvbs_remove(priv);
> =C2=A0
> =C2=A0	if (has_components)
> -		component_unbind_all(dev, drm);
> +		component_unbind_all(dev, &priv->drm);
> =C2=A0
> =C2=A0	return ret;
> =C2=A0}
> @@ -391,7 +385,7 @@ static int meson_drv_bind(struct device *dev)
> =C2=A0static void meson_drv_unbind(struct device *dev)
> =C2=A0{
> =C2=A0	struct meson_drm *priv =3D dev_get_drvdata(dev);
> -	struct drm_device *drm =3D priv->drm;
> +	struct drm_device *drm =3D &priv->drm;
> =C2=A0
> =C2=A0	if (priv->canvas) {
> =C2=A0		meson_canvas_free(priv->canvas, priv-
> >canvas_id_osd1);
> @@ -404,7 +398,6 @@ static void meson_drv_unbind(struct device *dev)
> =C2=A0	drm_kms_helper_poll_fini(drm);
> =C2=A0	drm_atomic_helper_shutdown(drm);
> =C2=A0	free_irq(priv->vsync_irq, drm);
> -	drm_dev_put(drm);
> =C2=A0
> =C2=A0	meson_encoder_dsi_remove(priv);
> =C2=A0	meson_encoder_hdmi_remove(priv);
> @@ -428,7 +421,7 @@ static int __maybe_unused
> meson_drv_pm_suspend(struct device *dev)
> =C2=A0	if (!priv)
> =C2=A0		return 0;
> =C2=A0
> -	return drm_mode_config_helper_suspend(priv->drm);
> +	return drm_mode_config_helper_suspend(&priv->drm);
> =C2=A0}
> =C2=A0
> =C2=A0static int __maybe_unused meson_drv_pm_resume(struct device *dev)
> @@ -445,7 +438,7 @@ static int __maybe_unused
> meson_drv_pm_resume(struct device *dev)
> =C2=A0	if (priv->afbcd.ops)
> =C2=A0		priv->afbcd.ops->init(priv);
> =C2=A0
> -	return drm_mode_config_helper_resume(priv->drm);
> +	return drm_mode_config_helper_resume(&priv->drm);
> =C2=A0}
> =C2=A0
> =C2=A0static void meson_drv_shutdown(struct platform_device *pdev)
> @@ -455,8 +448,8 @@ static void meson_drv_shutdown(struct
> platform_device *pdev)
> =C2=A0	if (!priv)
> =C2=A0		return;
> =C2=A0
> -	drm_kms_helper_poll_fini(priv->drm);
> -	drm_atomic_helper_shutdown(priv->drm);
> +	drm_kms_helper_poll_fini(&priv->drm);
> +	drm_atomic_helper_shutdown(&priv->drm);
> =C2=A0}
> =C2=A0
> =C2=A0/*
> diff --git a/drivers/gpu/drm/meson/meson_drv.h
> b/drivers/gpu/drm/meson/meson_drv.h
> index 3f9345c14f31..c4c6c810cb20 100644
> --- a/drivers/gpu/drm/meson/meson_drv.h
> +++ b/drivers/gpu/drm/meson/meson_drv.h
> @@ -53,7 +53,7 @@ struct meson_drm {
> =C2=A0	u8 canvas_id_vd1_1;
> =C2=A0	u8 canvas_id_vd1_2;
> =C2=A0
> -	struct drm_device *drm;
> +	struct drm_device drm;
> =C2=A0	struct drm_crtc *crtc;
> =C2=A0	struct drm_plane *primary_plane;
> =C2=A0	struct drm_plane *overlay_plane;
> diff --git a/drivers/gpu/drm/meson/meson_encoder_cvbs.c
> b/drivers/gpu/drm/meson/meson_encoder_cvbs.c
> index d1191de855d9..ddca22c8c1ff 100644
> --- a/drivers/gpu/drm/meson/meson_encoder_cvbs.c
> +++ b/drivers/gpu/drm/meson/meson_encoder_cvbs.c
> @@ -104,7 +104,7 @@ static int meson_encoder_cvbs_get_modes(struct
> drm_bridge *bridge,
> =C2=A0	for (i =3D 0; i < MESON_CVBS_MODES_COUNT; ++i) {
> =C2=A0		struct meson_cvbs_mode *meson_mode =3D
> &meson_cvbs_modes[i];
> =C2=A0
> -		mode =3D drm_mode_duplicate(priv->drm, &meson_mode-
> >mode);
> +		mode =3D drm_mode_duplicate(&priv->drm, &meson_mode-
> >mode);
> =C2=A0		if (!mode) {
> =C2=A0			dev_err(priv->dev, "Failed to create a new
> display mode\n");
> =C2=A0			return 0;
> @@ -221,7 +221,7 @@ static const struct drm_bridge_funcs
> meson_encoder_cvbs_bridge_funcs =3D {
> =C2=A0
> =C2=A0int meson_encoder_cvbs_probe(struct meson_drm *priv)
> =C2=A0{
> -	struct drm_device *drm =3D priv->drm;
> +	struct drm_device *drm =3D &priv->drm;
> =C2=A0	struct meson_encoder_cvbs *meson_encoder_cvbs;
> =C2=A0	struct drm_connector *connector;
> =C2=A0	struct device_node *remote;
> @@ -256,7 +256,7 @@ int meson_encoder_cvbs_probe(struct meson_drm
> *priv)
> =C2=A0	meson_encoder_cvbs->priv =3D priv;
> =C2=A0
> =C2=A0	/* Encoder */
> -	ret =3D drm_simple_encoder_init(priv->drm,
> &meson_encoder_cvbs->encoder,
> +	ret =3D drm_simple_encoder_init(&priv->drm,
> &meson_encoder_cvbs->encoder,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DRM_MODE_ENCODER_TVDAC);
> =C2=A0	if (ret)
> =C2=A0		return dev_err_probe(priv->dev, ret,
> @@ -273,7 +273,7 @@ int meson_encoder_cvbs_probe(struct meson_drm
> *priv)
> =C2=A0	}
> =C2=A0
> =C2=A0	/* Initialize & attach Bridge Connector */
> -	connector =3D drm_bridge_connector_init(priv->drm,
> &meson_encoder_cvbs->encoder);
> +	connector =3D drm_bridge_connector_init(&priv->drm,
> &meson_encoder_cvbs->encoder);
> =C2=A0	if (IS_ERR(connector))
> =C2=A0		return dev_err_probe(priv->dev, PTR_ERR(connector),
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "Unable to create CVBS bridge
> connector\n");
> diff --git a/drivers/gpu/drm/meson/meson_overlay.c
> b/drivers/gpu/drm/meson/meson_overlay.c
> index 7f98de38842b..60ee7f758723 100644
> --- a/drivers/gpu/drm/meson/meson_overlay.c
> +++ b/drivers/gpu/drm/meson/meson_overlay.c
> @@ -484,7 +484,7 @@ static void meson_overlay_atomic_update(struct
> drm_plane *plane,
> =C2=A0
> =C2=A0	interlace_mode =3D new_state->crtc->mode.flags &
> DRM_MODE_FLAG_INTERLACE;
> =C2=A0
> -	spin_lock_irqsave(&priv->drm->event_lock, flags);
> +	spin_lock_irqsave(&priv->drm.event_lock, flags);
> =C2=A0
> =C2=A0	if ((fb->modifier & DRM_FORMAT_MOD_AMLOGIC_FBC(0, 0)) =3D=3D
> =C2=A0			=C2=A0=C2=A0=C2=A0 DRM_FORMAT_MOD_AMLOGIC_FBC(0, 0)) {
> @@ -717,7 +717,7 @@ static void meson_overlay_atomic_update(struct
> drm_plane *plane,
> =C2=A0
> =C2=A0	priv->viu.vd1_enabled =3D true;
> =C2=A0
> -	spin_unlock_irqrestore(&priv->drm->event_lock, flags);
> +	spin_unlock_irqrestore(&priv->drm.event_lock, flags);
> =C2=A0
> =C2=A0	DRM_DEBUG_DRIVER("\n");
> =C2=A0}
> @@ -838,7 +838,7 @@ int meson_overlay_create(struct meson_drm *priv)
> =C2=A0
> =C2=A0	DRM_DEBUG_DRIVER("\n");
> =C2=A0
> -	meson_overlay =3D devm_kzalloc(priv->drm->dev,
> sizeof(*meson_overlay),
> +	meson_overlay =3D devm_kzalloc(priv->drm.dev,
> sizeof(*meson_overlay),
> =C2=A0				=C2=A0=C2=A0 GFP_KERNEL);
> =C2=A0	if (!meson_overlay)
> =C2=A0		return -ENOMEM;
> @@ -846,7 +846,7 @@ int meson_overlay_create(struct meson_drm *priv)
> =C2=A0	meson_overlay->priv =3D priv;
> =C2=A0	plane =3D &meson_overlay->base;
> =C2=A0
> -	drm_universal_plane_init(priv->drm, plane, 0xFF,
> +	drm_universal_plane_init(&priv->drm, plane, 0xFF,
> =C2=A0				 &meson_overlay_funcs,
> =C2=A0				 supported_drm_formats,
> =C2=A0				 ARRAY_SIZE(supported_drm_formats),
> diff --git a/drivers/gpu/drm/meson/meson_plane.c
> b/drivers/gpu/drm/meson/meson_plane.c
> index b43ac61201f3..13be94309bf4 100644
> --- a/drivers/gpu/drm/meson/meson_plane.c
> +++ b/drivers/gpu/drm/meson/meson_plane.c
> @@ -157,7 +157,7 @@ static void meson_plane_atomic_update(struct
> drm_plane *plane,
> =C2=A0	 * Update Buffer
> =C2=A0	 * Enable Plane
> =C2=A0	 */
> -	spin_lock_irqsave(&priv->drm->event_lock, flags);
> +	spin_lock_irqsave(&priv->drm.event_lock, flags);
> =C2=A0
> =C2=A0	/* Check if AFBC decoder is required for this buffer */
> =C2=A0	if ((meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXM) ||
> @@ -393,7 +393,7 @@ static void meson_plane_atomic_update(struct
> drm_plane *plane,
> =C2=A0
> =C2=A0	priv->viu.osd1_enabled =3D true;
> =C2=A0
> -	spin_unlock_irqrestore(&priv->drm->event_lock, flags);
> +	spin_unlock_irqrestore(&priv->drm.event_lock, flags);
> =C2=A0}
> =C2=A0
> =C2=A0static void meson_plane_atomic_disable(struct drm_plane *plane,
> @@ -536,7 +536,7 @@ int meson_plane_create(struct meson_drm *priv)
> =C2=A0	const uint64_t *format_modifiers =3D format_modifiers_default;
> =C2=A0	int ret;
> =C2=A0
> -	meson_plane =3D devm_kzalloc(priv->drm->dev,
> sizeof(*meson_plane),
> +	meson_plane =3D devm_kzalloc(priv->drm.dev,
> sizeof(*meson_plane),
> =C2=A0				=C2=A0=C2=A0 GFP_KERNEL);
> =C2=A0	if (!meson_plane)
> =C2=A0		return -ENOMEM;
> @@ -549,14 +549,14 @@ int meson_plane_create(struct meson_drm *priv)
> =C2=A0	else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A))
> =C2=A0		format_modifiers =3D format_modifiers_afbc_g12a;
> =C2=A0
> -	ret =3D drm_universal_plane_init(priv->drm, plane, 0xFF,
> +	ret =3D drm_universal_plane_init(&priv->drm, plane, 0xFF,
> =C2=A0					&meson_plane_funcs,
> =C2=A0					supported_drm_formats,
> =C2=A0					ARRAY_SIZE(supported_drm_for
> mats),
> =C2=A0					format_modifiers,
> =C2=A0					DRM_PLANE_TYPE_PRIMARY,
> "meson_primary_plane");
> =C2=A0	if (ret) {
> -		devm_kfree(priv->drm->dev, meson_plane);
> +		devm_kfree(priv->drm.dev, meson_plane);
> =C2=A0		return ret;
> =C2=A0	}
> =C2=A0


