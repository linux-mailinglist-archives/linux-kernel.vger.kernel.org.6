Return-Path: <linux-kernel+bounces-556450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A0EA5C991
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B70B53B17CC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655E726036F;
	Tue, 11 Mar 2025 15:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbFJ4VVK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EBE25FA35
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 15:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741708520; cv=none; b=eGhW9IDS7FRQgyUDY4VWy1i3wsqjV1Qg8HePWq6KPnVzqGVKJUfzx9PN8/oIY3tNo1lGG7ElqzdkHboJPelArBHC7HlA+s4sRxOtAENvITBe97IwqZJzgGxaJ8vuSE2ImptNw/yB/c7ghfyWByLcYpD8TBIGJovOTmlYEnlg1T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741708520; c=relaxed/simple;
	bh=IYtDhewtaUWyWDOivakRTHoEu1ryH8eAHQM9iOyRthY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZOV8E5vZqCKl5CvlqCrnfeq2tefmDsmxf9BIqV3lc0CmSREh/LZdcdXzx0wCMO/s7WAFaA153iCGT+hoAD0Sln7AmwZOdrYqjTIQNtx2hQ1K/KKvNZKidl3z2izOmWIhXuQjtTmRJCMD7+SqU3KQXapittxl477XLew605ooBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbFJ4VVK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89A8C4CEF1;
	Tue, 11 Mar 2025 15:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741708520;
	bh=IYtDhewtaUWyWDOivakRTHoEu1ryH8eAHQM9iOyRthY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gbFJ4VVKLZqZMW5KkQJsRkGZmOIEghbQq2s5uNWw9PVLeEeit9ioPgcJQQvpsD2QY
	 lPSteHS0YVpk8+yr5wgh4v8gAxGlWdHPKXiJSzJM2S5NOKfLvgLuS84/4/5Gzv5iGR
	 f0Gq+2GgVrimYVR2qsx1ufp8GZGV2VLuxIGXpenBx3P3Olh4vI3A3E8IydlzC4sBWc
	 8JOyT9VNULmti1XfkBVde4IhjaUcFitMBjfqG4NGhHUDb0A/yQo3j+4HyDx/4iryL7
	 w3xNOkNjGHtQ+2BJveijlYuyp9BkWUEhY58/XTB4mkUgOECNvy22Fdo+gED6IMSW7F
	 Nb6ngylfGJkOg==
Date: Tue, 11 Mar 2025 16:55:17 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, kernel@collabora.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] drm/connector: hdmi: Use YUV420 output format as
 an RGB fallback
Message-ID: <20250311-hypersonic-mature-leopard-d3afdc@houat>
References: <20250311-hdmi-conn-yuv-v2-0-fbdb94f02562@collabora.com>
 <20250311-hdmi-conn-yuv-v2-4-fbdb94f02562@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3fzyhdcufgmstuqi"
Content-Disposition: inline
In-Reply-To: <20250311-hdmi-conn-yuv-v2-4-fbdb94f02562@collabora.com>


--3fzyhdcufgmstuqi
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 4/7] drm/connector: hdmi: Use YUV420 output format as
 an RGB fallback
MIME-Version: 1.0

Hi,

I think the first thing we need to address is that we will need to
differentiate between HDMI 1.4 devices and HDMI 2.0.

It applies to YUV420, which is HDMI 2.0-only, and I guess your patches
are good enough if you consider YUV420 support only, but scrambler setup
for example is a thing we want to support in that infrastructure
eventually, and is conditioned on HDMI 2.0 as well.

On Tue, Mar 11, 2025 at 12:57:36PM +0200, Cristian Ciocaltea wrote:
> Try to make use of YUV420 when computing the best output format and
> RGB cannot be supported for any of the available color depths.
>=20
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 69 +++++++++++++------=
------
>  1 file changed, 35 insertions(+), 34 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gp=
u/drm/display/drm_hdmi_state_helper.c
> index a70e204a8df3ac1c2d7318e81cde87a83267dd21..f2052781b797dd09b41127e33=
d98fe25408a9b23 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> @@ -287,8 +287,9 @@ hdmi_try_format_bpc(const struct drm_connector *conne=
ctor,
>  	struct drm_device *dev =3D connector->dev;
>  	int ret;
> =20
> -	drm_dbg_kms(dev, "Trying %s output format\n",
> -		    drm_hdmi_connector_get_output_format_name(fmt));
> +	drm_dbg_kms(dev, "Trying %s output format with %u bpc\n",
> +		    drm_hdmi_connector_get_output_format_name(fmt),
> +		    bpc);

That part should be in a separate patch, it's independant of the rest.

>  	if (!sink_supports_format_bpc(connector, info, mode, fmt, bpc)) {
>  		drm_dbg_kms(dev, "%s output format not supported with %u bpc\n",
> @@ -313,47 +314,22 @@ hdmi_try_format_bpc(const struct drm_connector *con=
nector,
>  }
> =20
>  static int
> -hdmi_compute_format(const struct drm_connector *connector,
> -		    struct drm_connector_state *conn_state,
> -		    const struct drm_display_mode *mode,
> -		    unsigned int bpc)
> -{
> -	struct drm_device *dev =3D connector->dev;
> -
> -	/*
> -	 * TODO: Add support for YCbCr420 output for HDMI 2.0 capable
> -	 * devices, for modes that only support YCbCr420.
> -	 */
> -	if (hdmi_try_format_bpc(connector, conn_state, mode, bpc, HDMI_COLORSPA=
CE_RGB)) {
> -		conn_state->hdmi.output_format =3D HDMI_COLORSPACE_RGB;
> -		return 0;
> -	}
> -
> -	drm_dbg_kms(dev, "Failed. No Format Supported for that bpc count.\n");
> -
> -	return -EINVAL;
> -}
> -
> -static int
> -hdmi_compute_config(const struct drm_connector *connector,
> -		    struct drm_connector_state *conn_state,
> -		    const struct drm_display_mode *mode)
> +hdmi_try_format(const struct drm_connector *connector,
> +		struct drm_connector_state *conn_state,
> +		const struct drm_display_mode *mode,
> +		unsigned int max_bpc, enum hdmi_colorspace fmt)
>  {
>  	struct drm_device *dev =3D connector->dev;
> -	unsigned int max_bpc =3D clamp_t(unsigned int,
> -				       conn_state->max_bpc,
> -				       8, connector->max_bpc);
>  	unsigned int bpc;
>  	int ret;
> =20
>  	for (bpc =3D max_bpc; bpc >=3D 8; bpc -=3D 2) {
> -		drm_dbg_kms(dev, "Trying with a %d bpc output\n", bpc);
> -
> -		ret =3D hdmi_compute_format(connector, conn_state, mode, bpc);
> -		if (ret)
> +		ret =3D hdmi_try_format_bpc(connector, conn_state, mode, bpc, fmt);
> +		if (!ret)
>  			continue;
> =20
>  		conn_state->hdmi.output_bpc =3D bpc;
> +		conn_state->hdmi.output_format =3D fmt;

I guess it's a matter of semantics, but if it sets the value in the
state, it doesn't try. Maybe the function should be named
hdmi_compute_format_bpc then?

That renaming should be in a separate patch too (possibly several).

>  		drm_dbg_kms(dev,
>  			    "Mode %ux%u @ %uHz: Found configuration: bpc: %u, fmt: %s, clock:=
 %llu\n",
> @@ -368,6 +344,31 @@ hdmi_compute_config(const struct drm_connector *conn=
ector,
>  	return -EINVAL;
>  }
> =20
> +static int
> +hdmi_compute_config(const struct drm_connector *connector,
> +		    struct drm_connector_state *conn_state,
> +		    const struct drm_display_mode *mode)
> +{
> +	unsigned int max_bpc =3D clamp_t(unsigned int,
> +				       conn_state->max_bpc,
> +				       8, connector->max_bpc);
> +	int ret;
> +
> +	ret =3D hdmi_try_format(connector, conn_state, mode, max_bpc,
> +			      HDMI_COLORSPACE_RGB);
> +	if (!ret)
> +		return 0;
> +
> +	if (connector->ycbcr_420_allowed)
> +		ret =3D hdmi_try_format(connector, conn_state, mode, max_bpc,
> +				      HDMI_COLORSPACE_YUV420);

I think that's conditioned on a few more things:
  - That the driver supports HDMI 2.0
  - That the display is an HDMI output
  - That the mode is allowed YUV420 by the sink EDIDs

> +	else
> +		drm_dbg_kms(connector->dev,
> +			    "%s output format not allowed for connector\n",
> +			    drm_hdmi_connector_get_output_format_name(HDMI_COLORSPACE_YUV420)=
);

And I think we should keep the catch-all failure message we had.

Maxime

--3fzyhdcufgmstuqi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZ9Bc5AAKCRDj7w1vZxhR
xVnhAQDl/PvRDiL6mGjPZxZdwRJLBEc8RVnJdGiQHoLoHi1NfwD/aRxpL2aOGpsX
MraY+T7aemKpNHciKkfo4dcCw8FVBgg=
=qFyi
-----END PGP SIGNATURE-----

--3fzyhdcufgmstuqi--

