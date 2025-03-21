Return-Path: <linux-kernel+bounces-571411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D72DA6BCD3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE54F16A30D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D8D1422DD;
	Fri, 21 Mar 2025 14:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h28JaQj+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8729C189913
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742566680; cv=none; b=ewH0l3oZaS6XFczJb6Jjz2RjT7umvnNvqM2VWMG8iWvI2gXJDxeAFIU4AV2o3viMESom3rW3vfo0s6FnO6u9gD5jtbZ/0NmMZLQi6aJvgaWrUFvQe9rCoArnBrOohwuRgf5hikY4xZ9CSfFQ080d2/0giX3k8mXkORi//zlmS34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742566680; c=relaxed/simple;
	bh=0amfkrO3B1zq5t8fnOfrUB4M+QOIpfFLARmwtZZfJw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJCR7mnAth4ZngPL0+PXDjRyvdm1T1bqoh9+4WJRjop9cEURlJFlnNL61VFpL/AuOpQTKNVvHhhOVxy3ma/EIZMaXFI+mV9qnSTptSOWQX7RLg4+BGe8z3Hs8NPDP9QCfVIwgbBh4sSgcWdaKB/JinCbPgRYEL1I72vZhjSo5CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h28JaQj+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77ACFC4CEEC;
	Fri, 21 Mar 2025 14:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742566680;
	bh=0amfkrO3B1zq5t8fnOfrUB4M+QOIpfFLARmwtZZfJw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h28JaQj+Cuj1LkqH51sg7oXGnIp4dVVxPZLz+0RAoJ/cvMEaPF8oIsuaNLxg6oydV
	 r1yJNsBhghnpG5hehz+YWKOib6wlXmRNYJP7ecTb3km28qnRD6pBOoGxDewxc4Udqp
	 M3VCQqx7xzCwXw05YFYf0I++tTrBW3LCeKuiIctyDlwgH9flhmRhKbywagZErNUwkl
	 z+mg2s7FssEr24uOfvVkTLbAuEnEKhf3y/Qzh1gNfpYQYjqJpFejFsahS/CASq8/IB
	 ZlJyi2L7eqISoLmTCRdL3u9zf1QNz6RraU3518vXPG/QTtwiQLFWd2PA6UUZZMcqLT
	 qZ8Zkfy0Bycew==
Date: Fri, 21 Mar 2025 15:17:57 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Jyri Sarha <jyri.sarha@iki.fi>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, Francesco Dolcini <francesco@dolcini.it>, 
	Aradhya Bhatia <aradhya.bhatia@linux.dev>, Devarsh Thakkar <devarsht@ti.com>
Subject: Re: [PATCH 03/18] drm/tidss: Add mode_fixup to adjust the clock
 based on HW
Message-ID: <20250321-adaptable-astonishing-adder-ceeb6f@houat>
References: <20250320-cdns-dsi-impro-v1-0-725277c5f43b@ideasonboard.com>
 <20250320-cdns-dsi-impro-v1-3-725277c5f43b@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="bchtvmz6w2bii2si"
Content-Disposition: inline
In-Reply-To: <20250320-cdns-dsi-impro-v1-3-725277c5f43b@ideasonboard.com>


--bchtvmz6w2bii2si
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 03/18] drm/tidss: Add mode_fixup to adjust the clock
 based on HW
MIME-Version: 1.0

On Thu, Mar 20, 2025 at 05:59:58PM +0200, Tomi Valkeinen wrote:
> At the moment the driver just sets the clock rate with clk_set_rate(),
> and if the resulting rate is not the same as requested, prints a debug
> print, but nothing else.
>=20
> Add mode_fixup(), in which the clk_round_rate() is used to get the
> "rounded" rate, and set that to the adjusted_mode.
>=20
> In practice, with the current K3 SoCs, the display PLL is capable of
> producing very exact clocks, so most likely the rounded rate is the same
> as the original one.
>=20
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/gpu/drm/tidss/tidss_crtc.c  | 22 ++++++++++++++++++++++
>  drivers/gpu/drm/tidss/tidss_dispc.c |  6 ++++++
>  drivers/gpu/drm/tidss/tidss_dispc.h |  2 ++
>  3 files changed, 30 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/tidss/tidss_crtc.c b/drivers/gpu/drm/tidss/t=
idss_crtc.c
> index 1604eca265ef..b3338dac25bc 100644
> --- a/drivers/gpu/drm/tidss/tidss_crtc.c
> +++ b/drivers/gpu/drm/tidss/tidss_crtc.c
> @@ -309,7 +309,29 @@ enum drm_mode_status tidss_crtc_mode_valid(struct dr=
m_crtc *crtc,
>  	return dispc_vp_mode_valid(tidss->dispc, tcrtc->hw_videoport, mode);
>  }
> =20
> +static bool tidss_crtc_mode_fixup(struct drm_crtc *crtc,
> +				  const struct drm_display_mode *mode,
> +				  struct drm_display_mode *adjusted_mode)
> +{
> +	struct tidss_crtc *tcrtc =3D to_tidss_crtc(crtc);
> +	struct drm_device *ddev =3D crtc->dev;
> +	struct tidss_device *tidss =3D to_tidss(ddev);
> +	long rate;
> +
> +	rate =3D dispc_vp_round_clk_rate(tidss->dispc, tcrtc->hw_videoport,
> +				       adjusted_mode->clock * 1000);
> +	if (rate < 0)
> +		return false;
> +
> +	adjusted_mode->clock =3D rate / 1000;
> +
> +	drm_mode_set_crtcinfo(adjusted_mode, 0);
> +
> +	return true;
> +}

mode_fixup is deprecated in favor of atomic_check. If you can't use it
for some reason, it should be documented one way or another.

Maxime

--bchtvmz6w2bii2si
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ911EQAKCRAnX84Zoj2+
dgndAYCh/YgKmD2eT0IGBSW4oFScUbO0JiE0c6rJgT/fOlLd8ZyEQUmNR3/ihtKv
L3mLPUwBgN2SlLXG4F2ri8LKeYXjbpOagi9fMufwxwGrEzWDluOQ6RSb6Ak7/Y/H
uemPVUoFyg==
=QyZO
-----END PGP SIGNATURE-----

--bchtvmz6w2bii2si--

