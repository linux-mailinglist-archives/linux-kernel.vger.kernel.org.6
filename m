Return-Path: <linux-kernel+bounces-422708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE7A9D9D40
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 19:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C8A1B21F63
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B791DD879;
	Tue, 26 Nov 2024 18:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gr/MOB9A"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9CABA3F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 18:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732645239; cv=none; b=JCy7wAA9qnrJNB9gb7MR+/jDVwm1HASvKqUA4UA382nrR0wBscv6kbYOZSSK4SCfa45PLW442nRNAwG/kE1dgVCxda3y1icFe/Ef9xUfXEEA0783cy3nAkmu4ZaYsF4iuQVoMHiHfA4sMwe0z6UH3Qbc896fU26T5lrskHwJ0a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732645239; c=relaxed/simple;
	bh=gEOmfxCi0/kNKWZfQ/cVVD/Zd9DadeuVFE8hxNNpyWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UVQMbP43ZLWQsFB/HeAiQFwKRVGMM/IVgJ38hqYq+38qMy2dTbZHVF1jiibaXwUcJqKqMn+S7cZsF+WUOgFx5jywf0dOpoGD1/4+ZkU0B9MxLIrD6fN/pdXAOIIjf6U1ZckQPScKaAc/s7gzvfT5SszrZnEcrG+EE+BqpGeuSQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gr/MOB9A; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 232041BF204;
	Tue, 26 Nov 2024 18:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732645234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KkyX2X06zytO6TVv+IA60LIOSPbrut56J3+dT2CsRNk=;
	b=gr/MOB9A27zuKSxyCt1Ej81XTVN09nS14dcV6OIEWYZG3VXj7rcz9Sa7YaaLZ07nQqued6
	t4nniGxLKyqSb9vrwxwqVYGYntcr3lTcctJgUsfgLD8D2mqahwfDlvwB1y8txa8aM8pLKm
	IMg5xNu6EXE0WEjyVOHtWan3jRhehPNPhS9aA1/gXGhAi1frngwpe30y1pyg0sMsuFt7xY
	FYKOh27uKCFG3UhU7WEwh+aOz+VToTkMPQYmZm3LWHJp3XXJLbJq7tgoYNV5kkQUzPbZ2R
	MYesXwGVUa2d0Bc2cjR7D4In4KkiWfKEvQ5AxlcdfCBIwDCmiHbz1m2Qy21lcA==
Date: Tue, 26 Nov 2024 19:20:31 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Nikolaus Voss <nv@vosn.de>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>, Liu Ying
 <victor.liu@nxp.com>, Fabio Estevam <festevam@denx.de>, Marek Vasut
 <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 nikolaus.voss@haag-streit.com, Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH] drm: bridge: fsl-ldb: fixup mode on freq mismatch
Message-ID: <20241126192031.34884a76@booty>
In-Reply-To: <20241126172610.AD8B51622C@mail.steuer-voss.de>
References: <20241126172610.AD8B51622C@mail.steuer-voss.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: luca.ceresoli@bootlin.com

+Cc: Miqu=C3=A8l, who is actively working on imx8mp video clock rates.

On Tue, 26 Nov 2024 16:45:54 +0100
Nikolaus Voss <nv@vosn.de> wrote:

> LDB clock has to be a fixed multiple of the pixel clock.
> As LDB and pixel clock are derived from different clock sources
> (at least on imx8mp), this constraint cannot be satisfied for
> any pixel clock, which leads to flickering and incomplete
> lines on the attached display.
>=20
> To overcome this, check this condition in mode_fixup() and
> adapt the pixel clock accordingly.
>=20
> Cc: <stable@vger.kernel.org>
>=20
> Signed-off-by: Nikolaus Voss <nv@vosn.de>
> ---
>  drivers/gpu/drm/bridge/fsl-ldb.c | 40 ++++++++++++++++++++++++++++----
>  1 file changed, 36 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/bridge/fsl-ldb.c b/drivers/gpu/drm/bridge/fs=
l-ldb.c
> index 0e4bac7dd04ff..e341341b8c600 100644
> --- a/drivers/gpu/drm/bridge/fsl-ldb.c
> +++ b/drivers/gpu/drm/bridge/fsl-ldb.c
> @@ -104,12 +104,14 @@ static inline struct fsl_ldb *to_fsl_ldb(struct drm=
_bridge *bridge)
>  	return container_of(bridge, struct fsl_ldb, bridge);
>  }
> =20
> +static unsigned int fsl_ldb_link_freq_factor(const struct fsl_ldb *fsl_l=
db)
> +{
> +	return fsl_ldb_is_dual(fsl_ldb) ? 3500 : 7000;
> +}
> +
>  static unsigned long fsl_ldb_link_frequency(struct fsl_ldb *fsl_ldb, int=
 clock)
>  {
> -	if (fsl_ldb_is_dual(fsl_ldb))
> -		return clock * 3500;
> -	else
> -		return clock * 7000;
> +	return clock * fsl_ldb_link_freq_factor(fsl_ldb);
>  }
> =20
>  static int fsl_ldb_attach(struct drm_bridge *bridge,
> @@ -121,6 +123,35 @@ static int fsl_ldb_attach(struct drm_bridge *bridge,
>  				 bridge, flags);
>  }
> =20
> +static bool fsl_ldb_mode_fixup(struct drm_bridge *bridge,
> +				const struct drm_display_mode *mode,
> +				struct drm_display_mode *adjusted_mode)
> +{
> +	const struct fsl_ldb *fsl_ldb =3D to_fsl_ldb(bridge);
> +	unsigned long requested_link_freq =3D
> +		mode->clock * fsl_ldb_link_freq_factor(fsl_ldb);
> +	unsigned long freq =3D clk_round_rate(fsl_ldb->clk, requested_link_freq=
);
> +
> +	if (freq !=3D requested_link_freq) {
> +		/*
> +		 * this will lead to flicker and incomplete lines on
> +		 * the attached display, adjust the CRTC clock
> +		 * accordingly.
> +		 */
> +		int pclk =3D freq / fsl_ldb_link_freq_factor(fsl_ldb);
> +
> +		if (adjusted_mode->clock !=3D pclk) {
> +			dev_warn(fsl_ldb->dev, "Adjusted pixel clk to match LDB clk (%d kHz -=
> %d kHz)!\n",
> +				 adjusted_mode->clock, pclk);
> +
> +			adjusted_mode->clock =3D pclk;
> +			adjusted_mode->crtc_clock =3D pclk;
> +		}
> +	}
> +
> +	return true;
> +}
> +
>  static void fsl_ldb_atomic_enable(struct drm_bridge *bridge,
>  				  struct drm_bridge_state *old_bridge_state)
>  {
> @@ -280,6 +311,7 @@ fsl_ldb_mode_valid(struct drm_bridge *bridge,
> =20
>  static const struct drm_bridge_funcs funcs =3D {
>  	.attach =3D fsl_ldb_attach,
> +	.mode_fixup =3D fsl_ldb_mode_fixup,
>  	.atomic_enable =3D fsl_ldb_atomic_enable,
>  	.atomic_disable =3D fsl_ldb_atomic_disable,
>  	.atomic_duplicate_state =3D drm_atomic_helper_bridge_duplicate_state,



--=20
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

