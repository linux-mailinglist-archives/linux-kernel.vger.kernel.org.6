Return-Path: <linux-kernel+bounces-180741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 361C38C727B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 10:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC8501F21B13
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 08:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38D16D1AF;
	Thu, 16 May 2024 08:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFfq3JU9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EF14501A
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715847061; cv=none; b=Ssa5F0/XiDx1vWRluZIMmfv/y2sH1JeY3WKUOEu/Jj22sBTw34C7Qzl+xrH8VPklUU+KtRX07MiDA2uG5j4jOxwGKZP/F6t7jSmL9/Hqt3KMgnhI1Mp7REtmnJfeuD79l/Qd/u/OGoClOevNut3CqskOqyZ0b9hn3SNg7DqnUUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715847061; c=relaxed/simple;
	bh=BRmFhShoWqXO+RMaXZ6QcmRSB4WF0s9bSCjoMQyYH+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTjC5gWth0MSUxTI6w/YzIIPXWp8LHyzSZFPMabI0D1aajpfyJ5VvbqEjUIM37+s6ptnDdq6W4/CsaxgGcqlE9yETPEODCO0YyZK6fl5pZVsBHPUEzpDWJEiV+fQf0Q5QOadJFqH99lH67HA0qFSGVWiS0swt0VoyqPNScTvgzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFfq3JU9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E717EC113CC;
	Thu, 16 May 2024 08:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715847060;
	bh=BRmFhShoWqXO+RMaXZ6QcmRSB4WF0s9bSCjoMQyYH+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TFfq3JU9kClf6Fd7tvIXE7Y56dguu22/4+EVp//3L9GvgEtaTwLKo80BP/JNqDGn0
	 4oyiZLkES47mbrMfnkd1xZ0S/0rn6hSaDj50ygyofk1df7KQcm1KHL17DAw9elTEtN
	 H7vt8ugQ9PRgramYdz68rMo7K35332ScZ2sPcizX0kFO461G8t0cPakJqyxsRu1Oas
	 qUTfqTljA0AzQPHYl96LuAWE5ObFm2v4iehRrHeuUS5lP/cUzMeFEUXtqdKFXYwT9f
	 f1En5jxzRikHvxswPCjB+qnRNjLupZ8opoaYNCqdcRcDlwuwzQHSObsCJU0qTRfDAY
	 JYuBUoq/7i0Wg==
Date: Thu, 16 May 2024 10:10:56 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Aradhya Bhatia <a-bhatia1@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Jyri Sarha <jyri.sarha@iki.fi>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, DRI Development List <dri-devel@lists.freedesktop.org>, 
	Linux Kernel List <linux-kernel@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>, 
	Thierry Reding <treding@nvidia.com>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
	Boris Brezillon <boris.brezillon@bootlin.com>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Praneeth Bajjuri <praneeth@ti.com>, Udit Kumar <u-kumar1@ti.com>, 
	Devarsh Thakkar <devarsht@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
	Jai Luthra <j-luthra@ti.com>
Subject: Re: [PATCH 1/7] drm/tidss: Add CRTC mode_fixup
Message-ID: <20240516-tuscan-mamba-of-debate-c4cddf@penduick>
References: <20240511153051.1355825-1-a-bhatia1@ti.com>
 <20240511153051.1355825-2-a-bhatia1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="mgwxmljliai55uxs"
Content-Disposition: inline
In-Reply-To: <20240511153051.1355825-2-a-bhatia1@ti.com>


--mgwxmljliai55uxs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, May 11, 2024 at 09:00:45PM +0530, Aradhya Bhatia wrote:
> Add support for mode_fixup for the tidss CRTC.
>=20
> Some bridges like the cdns-dsi consume the crtc_* timing parameters for
> programming the blanking values. Allow for the normal timing parameters
> to get copied to crtc_* timing params.
>=20
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
>  drivers/gpu/drm/tidss/tidss_crtc.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/tidss/tidss_crtc.c b/drivers/gpu/drm/tidss/t=
idss_crtc.c
> index 94f8e3178df5..797ef53d9ad2 100644
> --- a/drivers/gpu/drm/tidss/tidss_crtc.c
> +++ b/drivers/gpu/drm/tidss/tidss_crtc.c
> @@ -309,12 +309,23 @@ enum drm_mode_status tidss_crtc_mode_valid(struct d=
rm_crtc *crtc,
>  	return dispc_vp_mode_valid(tidss->dispc, tcrtc->hw_videoport, mode);
>  }
> =20
> +static
> +bool tidss_crtc_mode_fixup(struct drm_crtc *crtc,
> +			   const struct drm_display_mode *mode,
> +			   struct drm_display_mode *adjusted_mode)
> +{
> +	drm_mode_set_crtcinfo(adjusted_mode, 0);
> +
> +	return true;
> +}
> +
>  static const struct drm_crtc_helper_funcs tidss_crtc_helper_funcs =3D {
>  	.atomic_check =3D tidss_crtc_atomic_check,
>  	.atomic_flush =3D tidss_crtc_atomic_flush,
>  	.atomic_enable =3D tidss_crtc_atomic_enable,
>  	.atomic_disable =3D tidss_crtc_atomic_disable,
> =20
> +	.mode_fixup =3D tidss_crtc_mode_fixup,
>  	.mode_valid =3D tidss_crtc_mode_valid,
>  };

mode_fixup is deprecated for atomic drivers, so the solution must be
different there.

It's also not clear to me how it could change anything there:
drm_mode_set_crtcinfo with no flags will make crtc_* field exactly
identical to their !crtc counterparts.

Maxime

--mgwxmljliai55uxs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZkW/jwAKCRAnX84Zoj2+
dhopAX9rYsjJXGouUM2wpIcUr0980woll7lZpm+3BsbWdQnFxhf6beZRHsBDAQ6+
F2BYULABgK7TsoZbNSb5Q12oWnnuWVM9+qXVDwDDzzSRwFIK3QrhqLBb/cGxoqUi
dgdthA19rg==
=Kkys
-----END PGP SIGNATURE-----

--mgwxmljliai55uxs--

