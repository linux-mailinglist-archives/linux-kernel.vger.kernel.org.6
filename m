Return-Path: <linux-kernel+bounces-343485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0A4989B79
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEE7A1C2148F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6B4156653;
	Mon, 30 Sep 2024 07:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBg+Dviw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752BE21105;
	Mon, 30 Sep 2024 07:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727681494; cv=none; b=Vm6D3iMT+QzpDOAP7/pHmq0rBdg7zzUi96fun+M+PfHvbMPqdM9mGvVDnGRkYSgOAaAeBCo5BKolzWx7sCWHGAZHJ3vAiuuARktDEhEm1RNZpW9a08RFqwUdhU/GJAEGNmX7CF5Swu/58Gpb1RFRKxQ/g45i93yqLWPV1XEkVfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727681494; c=relaxed/simple;
	bh=YhK9MVnb7j5WhBPB70Arr1HFN2nVENw6PFRu6sWoH+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTBAG4FilsG1iVfSHKQ3cm411fvrOW2S1byLwSoKrvdTbJvpsYt2F7TVld88avmscjDhkfVYuAzd4a8USPBACHiuMrLMK3mZ/4Air3flnDHOI+p6It9ddwDxR7u43bSTnI7xiqxOsZxmIJba32uWuZ3HLBQohCylAG3o+KROK54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBg+Dviw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E221C4CEC7;
	Mon, 30 Sep 2024 07:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727681493;
	bh=YhK9MVnb7j5WhBPB70Arr1HFN2nVENw6PFRu6sWoH+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JBg+DviwW4KZcSt4aw3rXm+Xi4JK474zqH69w6oxMsVCLNjm42/r14WKQFe3Ke6wB
	 swzRJhCvBNrVANQiXr+l3Z/ovAc6I+DzHdNH4hzkNgxFNXLpa1GatKAMQhuiUZal2c
	 NTiapZ5l49utnCZgdGVENzTSGbH8uDm/PRdmLy+85atr+e/5H1913ZtBrjeI6rUGNq
	 HIHSEWP0D7W6xEF+bKZmoM8ZaFR09FxjczqCybTzvLkd3+mG5YrWRR20UQbfcDE8lT
	 ZabrgWaFOLYs5SVbovTxbBRnvPAjA7FfXx2putvJMP2mtjMPoKPFP/3Jo08nmi/tsy
	 20iFthhHwkTRw==
Date: Mon, 30 Sep 2024 09:31:31 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Liu Ying <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	catalin.marinas@arm.com, will@kernel.org, quic_bjorande@quicinc.com, 
	geert+renesas@glider.be, dmitry.baryshkov@linaro.org, arnd@arndb.de, 
	nfraprado@collabora.com, o.rempel@pengutronix.de, y.moog@phytec.de
Subject: Re: [PATCH 4/8] drm/bridge: fsl-ldb: Use clk_round_rate() to
 validate "ldb" clock rate
Message-ID: <2on4bu5jsxvaxckqz3wouwrf2z6nwbtv34ek4xda2dvobqhbsf@g7z7kxq5xrxi>
References: <20240930052903.168881-1-victor.liu@nxp.com>
 <20240930052903.168881-5-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="rtzanz6gpbkemxsz"
Content-Disposition: inline
In-Reply-To: <20240930052903.168881-5-victor.liu@nxp.com>


--rtzanz6gpbkemxsz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 01:28:59PM GMT, Liu Ying wrote:
> Multiple display modes could be read from a display device's EDID.
> Use clk_round_rate() to validate the "ldb" clock rate for each mode
> in drm_bridge_funcs::mode_valid() to filter unsupported modes out.
>=20
> Also, if the "ldb" clock and the pixel clock are sibling in clock
> tree, use clk_round_rate() to validate the pixel clock rate against
> the "ldb" clock.  This is not done in display controller driver
> because drm_crtc_helper_funcs::mode_valid() may not decide to do
> the validation or not if multiple encoders are connected to the CRTC,
> e.g., i.MX93 LCDIF may connect with MIPI DSI controller, LDB and
> parallel display output simultaneously.
>=20
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
>  drivers/gpu/drm/bridge/fsl-ldb.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/bridge/fsl-ldb.c b/drivers/gpu/drm/bridge/fs=
l-ldb.c
> index b559f3e0bef6..ee8471c86617 100644
> --- a/drivers/gpu/drm/bridge/fsl-ldb.c
> +++ b/drivers/gpu/drm/bridge/fsl-ldb.c
> @@ -11,6 +11,7 @@
>  #include <linux/of_graph.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> +#include <linux/units.h>
> =20
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_bridge.h>
> @@ -64,6 +65,7 @@ struct fsl_ldb_devdata {
>  	u32 lvds_ctrl;
>  	bool lvds_en_bit;
>  	bool single_ctrl_reg;
> +	bool ldb_clk_pixel_clk_sibling;
>  };
> =20
>  static const struct fsl_ldb_devdata fsl_ldb_devdata[] =3D {
> @@ -74,11 +76,13 @@ static const struct fsl_ldb_devdata fsl_ldb_devdata[]=
 =3D {
>  	[IMX8MP_LDB] =3D {
>  		.ldb_ctrl =3D 0x5c,
>  		.lvds_ctrl =3D 0x128,
> +		.ldb_clk_pixel_clk_sibling =3D true,
>  	},
>  	[IMX93_LDB] =3D {
>  		.ldb_ctrl =3D 0x20,
>  		.lvds_ctrl =3D 0x24,
>  		.lvds_en_bit =3D true,
> +		.ldb_clk_pixel_clk_sibling =3D true,
>  	},
>  };
> =20
> @@ -269,11 +273,29 @@ fsl_ldb_mode_valid(struct drm_bridge *bridge,
>  		   const struct drm_display_info *info,
>  		   const struct drm_display_mode *mode)
>  {
> +	unsigned long link_freq, pclk_rate, rounded_pclk_rate;
>  	struct fsl_ldb *fsl_ldb =3D to_fsl_ldb(bridge);
> =20
>  	if (mode->clock > (fsl_ldb_is_dual(fsl_ldb) ? 160000 : 80000))
>  		return MODE_CLOCK_HIGH;
> =20
> +	/* Validate "ldb" clock rate. */
> +	link_freq =3D fsl_ldb_link_frequency(fsl_ldb, mode->clock);
> +	if (link_freq !=3D clk_round_rate(fsl_ldb->clk, link_freq))
> +		return MODE_NOCLOCK;
> +
> +	/*
> +	 * Use "ldb" clock to validate pixel clock rate,
> +	 * if the two clocks are sibling.
> +	 */
> +	if (fsl_ldb->devdata->ldb_clk_pixel_clk_sibling) {
> +		pclk_rate =3D mode->clock * HZ_PER_KHZ;
> +
> +		rounded_pclk_rate =3D clk_round_rate(fsl_ldb->clk, pclk_rate);
> +		if (rounded_pclk_rate !=3D pclk_rate)
> +			return MODE_NOCLOCK;
> +	}
> +

I guess this is to workaround the fact that the parent rate would be
changed, and thus the sibling rate as well? This should be documented in
a comment if so.

Maxime

--rtzanz6gpbkemxsz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZvpT0gAKCRAnX84Zoj2+
dk4PAX9RKdbNYUzaKe3hmulCJ0qwP1+vLwkjQr20vGEfXsXUQeRrnNzmkVHGe4H9
omV9KkYBgIQacO4mH9ISmfZ+XEpZN1H2pkJIWcQR9cCfeift9Lumau2cxnoRTW6V
VOwv91h/Wg==
=xndf
-----END PGP SIGNATURE-----

--rtzanz6gpbkemxsz--

