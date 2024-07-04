Return-Path: <linux-kernel+bounces-241054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A6F92767B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D66B81C20FCB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A071AE0BC;
	Thu,  4 Jul 2024 12:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0+zJB/X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDA91DA316
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 12:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720097697; cv=none; b=EwzNCtaAdhnBnV022mBrxcLFmsUQIxv2oP0MdxUazK2H4h/fuyk5+oq+QPdf2L8BWpMhOQAgdxNpc/pOuE5VjKFO1SqC7ofW8uWkVK1l/yCP4BqIVh7398z0POX2MDr4fPmDbFbQdfeYMDjOHgSLSRnolqfwKQk57maZEG1ceds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720097697; c=relaxed/simple;
	bh=ILajwhC59+opIAZWjmIhHmcIsJqEnvwOwuO3gniO6zE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejqTmZEFsWHua81O1JLaLRrwon2IyzFcfIesTLa9uxcoakO+m2amKdxDcNcN/b2j3n033upNLDjrprDqWpklQtDjODjSiUrFIcUErW0QaJ0+FidBUcYeeS+q7WQz3QVhnrg2MgDt12jaQcD9zGKaKgh94iqa1+q9vqPNr5hApmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0+zJB/X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB88C3277B;
	Thu,  4 Jul 2024 12:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720097697;
	bh=ILajwhC59+opIAZWjmIhHmcIsJqEnvwOwuO3gniO6zE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W0+zJB/XTUP0SS4KNMmps+Q4v6tiTpFbTSKIZCQZ4XBVDYl/hIpQC8V8F07SaUMld
	 l8EQohBBNGPoumtKE5mmLBqnGJRANF5qFVxMOivfNuWmFXuAsu9uB89BtAKnkCuDWQ
	 bkAn0Bo38QRkj2qV3jTZN4NgEmPlylaClkEZu9IHBI541G+5xl7JgpBjd4QtzjZ1Uk
	 4iBYVBsZ6I6oVBesMU7QjoXesk5UQoi+nwd98uZPbCNrWNTp3qPjAhfSlpQO4tcZLX
	 noO/cG+hVeA9BN+ZXeDMZbkdR8I5HPOfMWFJw1GNBzb9b+j6PLrWL44ZGzq+uoPOOz
	 D3TCE1Ebdo4ng==
Date: Thu, 4 Jul 2024 14:54:54 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	dri-devel@lists.freedesktop.org, igt-dev@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] drm/bridge-connector: move to DRM_DISPLAY_HELPER
 module
Message-ID: <20240704-roaring-aromatic-seal-d046af@houat>
References: <20240702-drm-bridge-connector-fix-hdmi-reset-v3-0-12b0e3124ca4@linaro.org>
 <20240702-drm-bridge-connector-fix-hdmi-reset-v3-3-12b0e3124ca4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="maf4l2nobzwgnwrm"
Content-Disposition: inline
In-Reply-To: <20240702-drm-bridge-connector-fix-hdmi-reset-v3-3-12b0e3124ca4@linaro.org>


--maf4l2nobzwgnwrm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2024 at 12:48:54PM GMT, Dmitry Baryshkov wrote:
> drm_bridge_connector is a "leaf" driver, belonging to the display
> helper, rather than the "CRTC" drm_kms_helper module. Move the driver
> to the drm/display and add necessary Kconfig selection clauses.
>=20
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/gpu/drm/Makefile                             | 1 -
>  drivers/gpu/drm/bridge/Kconfig                       | 1 +
>  drivers/gpu/drm/display/Kconfig                      | 6 ++++++
>  drivers/gpu/drm/display/Makefile                     | 2 ++
>  drivers/gpu/drm/{ =3D> display}/drm_bridge_connector.c | 0
>  drivers/gpu/drm/imx/dcss/Kconfig                     | 2 ++
>  drivers/gpu/drm/imx/lcdc/Kconfig                     | 2 ++
>  drivers/gpu/drm/ingenic/Kconfig                      | 2 ++
>  drivers/gpu/drm/kmb/Kconfig                          | 2 ++
>  drivers/gpu/drm/mediatek/Kconfig                     | 2 ++
>  drivers/gpu/drm/meson/Kconfig                        | 2 ++
>  drivers/gpu/drm/msm/Kconfig                          | 1 +
>  drivers/gpu/drm/omapdrm/Kconfig                      | 2 ++
>  drivers/gpu/drm/renesas/rcar-du/Kconfig              | 2 ++
>  drivers/gpu/drm/renesas/rz-du/Kconfig                | 2 ++
>  drivers/gpu/drm/renesas/shmobile/Kconfig             | 2 ++
>  drivers/gpu/drm/rockchip/Kconfig                     | 4 ++++
>  drivers/gpu/drm/tegra/Kconfig                        | 1 +
>  drivers/gpu/drm/tidss/Kconfig                        | 2 ++
>  drivers/gpu/drm/xlnx/Kconfig                         | 1 +
>  20 files changed, 38 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index 68cc9258ffc4..fa432a1ac9e2 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -128,7 +128,6 @@ obj-$(CONFIG_DRM_TTM_HELPER) +=3D drm_ttm_helper.o
>  drm_kms_helper-y :=3D \
>  	drm_atomic_helper.o \
>  	drm_atomic_state_helper.o \
> -	drm_bridge_connector.o \
>  	drm_crtc_helper.o \
>  	drm_damage_helper.o \
>  	drm_encoder_slave.o \
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kcon=
fig
> index c621be1a99a8..3eb955333c80 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -390,6 +390,7 @@ config DRM_TI_SN65DSI86
>  	depends on OF
>  	select DRM_DISPLAY_DP_HELPER
>  	select DRM_DISPLAY_HELPER
> +	select DRM_BRIDGE_CONNECTOR
>  	select DRM_KMS_HELPER
>  	select REGMAP_I2C
>  	select DRM_PANEL
> diff --git a/drivers/gpu/drm/display/Kconfig b/drivers/gpu/drm/display/Kc=
onfig
> index 479e62690d75..1a192a45961b 100644
> --- a/drivers/gpu/drm/display/Kconfig
> +++ b/drivers/gpu/drm/display/Kconfig
> @@ -6,6 +6,12 @@ config DRM_DISPLAY_HELPER
>  	help
>  	  DRM helpers for display adapters.
> =20
> +config DRM_BRIDGE_CONNECTOR
> +	bool
> +	depends on DRM && DRM_BRIDGE && DRM_DISPLAY_HELPER
> +	help
> +	  DRM connector implementation terminating DRM bridge chains.
> +

Is there any reason to put it in there instead of under DRM_BRIDGE like
DRM_PANEL_BRIDGE?

Maxime

--maf4l2nobzwgnwrm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZoabnQAKCRDj7w1vZxhR
xVF4AQCZGUdy5RSxRNia33KLSVe6JlbEwmPRPfCDXIxddM0AuAD+NAnI7f0ZL1Up
42ruWE1J6+8pytttkHv86vqf50lp0wc=
=h9NG
-----END PGP SIGNATURE-----

--maf4l2nobzwgnwrm--

