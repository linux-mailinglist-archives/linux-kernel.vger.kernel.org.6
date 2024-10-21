Return-Path: <linux-kernel+bounces-373976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA389A601A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3B90B28E34
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF001E32CA;
	Mon, 21 Oct 2024 09:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="di5V5vWq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5B01E32C6;
	Mon, 21 Oct 2024 09:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729503127; cv=none; b=jM6cRkuIVDKs6Dd/TU+ptXDt6JgKYZXpATn5qId50QpZR//+Jul7prm8+M8aY5sUV/0h8QG3erv3VBkKxv/UmCjPa6tn/PrH3TQ3qyVmvrt5ojaCiVD0AeZuHEQ0D1z8rS/JaqTTfGQe+8kGEskUc8g4V4Frq5oX8gFwoUZWt5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729503127; c=relaxed/simple;
	bh=o9GSQ+2j89yvUpyu6yj/PhTEqoO1iN3ay/vQtVCBN8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=axAYZX82Z3uGZPIBurRewJBHELGfLWnK4EjWugcPKP4KKNi8SPLUO98hWvTIUrUB2x0ekOrN+2qjyryZlPvOS0zYwNhmo2plmydpsx2nzBw1X09QmoFWLtBe+POMhmfc1J2PUJPCw1qz1VlDm5BsmAJA1X/ZVDQ/5phdJ7e6j1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=di5V5vWq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3ADC4CEC3;
	Mon, 21 Oct 2024 09:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729503126;
	bh=o9GSQ+2j89yvUpyu6yj/PhTEqoO1iN3ay/vQtVCBN8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=di5V5vWqwW+KJSZ7QJGLtQSJW0Cp6BUJCqjmfGS/DJ4h5D0mydS5i5fzg7+evEXUC
	 +ZgXk+9SmieeSU+4VBrLXuTxQdT07bMalBh28OC7N0vUha/ZD5EpFsPDxuwm4hFtsY
	 I9/A+bbqQX7QIqjBFs7l4vKNMmlxsSWXO1CcXtl3TdoOMHq9FgqacMomDbajJPW1xc
	 mKHf5ZpCaVs7588P7ZgikGDOII4AyTOMT6pV7JbFltZQfU5WcamZLtT6f37aSo7WwR
	 1MAeb/ORrpd7n/q1gfqWyxpoTNQGkFK22lXZXrCWJr2mHi6wAx3R1XWKsTFI2PP+xp
	 IYjQuAhVIdouw==
Date: Mon, 21 Oct 2024 11:32:03 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 1/6] drm/display: hdmi: add generic mode_valid helper
Message-ID: <20241021-chubby-fascinating-labradoodle-144990@houat>
References: <20241018-hdmi-mode-valid-v1-0-6e49ae4801f7@linaro.org>
 <20241018-hdmi-mode-valid-v1-1-6e49ae4801f7@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="ifj5lbqztqmt6mh7"
Content-Disposition: inline
In-Reply-To: <20241018-hdmi-mode-valid-v1-1-6e49ae4801f7@linaro.org>


--ifj5lbqztqmt6mh7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/6] drm/display: hdmi: add generic mode_valid helper
MIME-Version: 1.0

On Fri, Oct 18, 2024 at 11:34:19PM +0300, Dmitry Baryshkov wrote:
> Add drm_hdmi_connector_mode_valid(), generic helper for HDMI connectors.
> It can be either used directly or as a part of the .mode_valid callback.
>=20
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/gpu/drm/display/drm_hdmi_helper.c | 25 +++++++++++++++++++++++++
>  include/drm/display/drm_hdmi_helper.h     |  4 ++++
>  2 files changed, 29 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/display/drm_hdmi_helper.c b/drivers/gpu/drm/=
display/drm_hdmi_helper.c
> index 74dd4d01dd9b..0ac5cb000ee2 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_helper.c
> @@ -256,3 +256,28 @@ drm_hdmi_compute_mode_clock(const struct drm_display=
_mode *mode,
>  	return DIV_ROUND_CLOSEST_ULL(clock * bpc, 8);
>  }
>  EXPORT_SYMBOL(drm_hdmi_compute_mode_clock);
> +
> +/**
> + * drm_hdmi_connector_mode_valid() - Check if mode is valid for HDMI con=
nector
> + * @connector: DRM connector to validate the mode
> + * @mode: Display mode to validate
> + *
> + * Generic .mode_valid implementation for HDMI connectors.
> + */
> +enum drm_mode_status
> +drm_hdmi_connector_mode_valid(const struct drm_connector *connector,
> +			      const struct drm_display_mode *mode)
> +{
> +	const struct drm_connector_hdmi_funcs *funcs =3D connector->hdmi.funcs;
> +	unsigned long long rate;
> +
> +	rate =3D drm_hdmi_compute_mode_clock(mode, 8, HDMI_COLORSPACE_RGB);
> +	if (!rate)
> +		return MODE_ERROR;
> +
> +	if (!funcs || !funcs->tmds_char_rate_valid)
> +		return MODE_OK;
> +
> +	return funcs->tmds_char_rate_valid(connector, mode, rate);
> +}
> +EXPORT_SYMBOL(drm_hdmi_connector_mode_valid);

As discussed in the discussion that sparked that change, I believe that
we should use hdmi_clock_valid.

AFAIU, your concern was that max_tmds_clock might get stale, but then it
would not only prevent mode_valid from running but also the commit
entirely.

We don't have any evidence from that, so I'd rather try to keep
consistency between the two. And we can always try to address whatever
issue we might have if it turned out to be a bad idea :)

Maxime

--ifj5lbqztqmt6mh7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZxYfkwAKCRAnX84Zoj2+
dmkBAX4jObYHXj/SHbJRC5WTl3MBXQxOAgkEQpbyhFO5V+xPAbvV698NYOoHdja5
FBhM/noBfRcjFfvP1ocpWgpWF2Z6tm439LxZtf87jWDk62fy3ha3vmEp6ZNWbC44
1jIzo18utA==
=2ErT
-----END PGP SIGNATURE-----

--ifj5lbqztqmt6mh7--

