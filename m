Return-Path: <linux-kernel+bounces-427325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 609039DFFDA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04A65161114
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4841FDE05;
	Mon,  2 Dec 2024 11:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQLL42vR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEA91FCFE3
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 11:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733137904; cv=none; b=lIZvV4tLLH295Rla25b+sJX5DH8DIDj9nGPLb0Ksvn9tiqUpLBlHdm2hnzLHSNqNLXjobYklTJkYRC1hslWoZP6d+5kST3eWG3qs8tUAdnX3Z1votmqCJ1pk2+2ml0urljklGUbuIUxpZiByD8W7O2YH/vCeh4eMs48UKpKYy3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733137904; c=relaxed/simple;
	bh=JIk+/rOoMqitU5DAC4H1Lz/H4l2OqXEvQwoMMX4VIWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJ6xqeAEXWk7dh5vNsOXBJPvq/1TgbziLENMS1iRqQgyWQLg5vTqwSnOuzNFNdCr1WUAlbTVrUqtUAvrvlDREsRAPeXslvF+uSzCY0cznT27CcEH9EHkgvasGyfGRoBJpGvtsYccR20anO1g3VFAyfwVHkZu2x8jw30jBhYn4dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQLL42vR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7300DC4CED1;
	Mon,  2 Dec 2024 11:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733137903;
	bh=JIk+/rOoMqitU5DAC4H1Lz/H4l2OqXEvQwoMMX4VIWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iQLL42vRehf9GQwzUc1jq6gUi5Uek6EQ4z1BoqUIXkcrZjBCn31TIyj0M1VrQq9jI
	 XAreBypESlQT0fEVkJuG1EAEbFSEoHY/+QcBLUlYpWNLlHPVBItkL6c2KYSPj8Argd
	 2FxcVmjPNflShq1SuARBEjNmF5zpkgirNNFm81Opd9Z+2MXQV3tkOpKecTRFJDFV+b
	 EukjrkZwbT57WsRpEF6vr6b0RgZQVRo4o3uJF5KZqkfKm1dGEUpuZHcbn5RGJjunOs
	 otvImV2bO6y0YjBi0XtWtzv8expTlQe5+JyNV0eZIX6FIFyGxHj0OY33TH3JhDSNn7
	 AB2yVwlTayvEw==
Date: Mon, 2 Dec 2024 12:11:41 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, kernel@collabora.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] drm/connector: hdmi: Use YUV420 output format as an
 RGB fallback
Message-ID: <20241202-tangible-ibis-from-sirius-464b60@houat>
References: <20241130-hdmi-conn-yuv-v1-0-254279a08671@collabora.com>
 <20241130-hdmi-conn-yuv-v1-3-254279a08671@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="r72hxnc5h2m3ceyw"
Content-Disposition: inline
In-Reply-To: <20241130-hdmi-conn-yuv-v1-3-254279a08671@collabora.com>


--r72hxnc5h2m3ceyw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/3] drm/connector: hdmi: Use YUV420 output format as an
 RGB fallback
MIME-Version: 1.0

On Sat, Nov 30, 2024 at 01:56:34AM +0200, Cristian Ciocaltea wrote:
> Introduce the switch to YUV420 when computing the best output format and
> RGB cannot be supported for a given color depth.
>=20
> While at it, add a minor improvement to the debug message indicating the
> supported format.
>=20
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gp=
u/drm/display/drm_hdmi_state_helper.c
> index 3a55881a544a519bb1254968db891c814f831a0f..b4e865e0680f35fd2d8495367=
89f6c1f98a48258 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> @@ -304,7 +304,7 @@ hdmi_try_format_bpc(const struct drm_connector *conne=
ctor,
>  		return false;
>  	}
> =20
> -	drm_dbg_kms(dev, "%s output format supported with %u (TMDS char rate: %=
llu Hz)\n",
> +	drm_dbg_kms(dev, "%s output format supported with %u bpc (TMDS char rat=
e: %llu Hz)\n",
>  		    drm_hdmi_connector_get_output_format_name(fmt),
>  		    bpc, conn_state->hdmi.tmds_char_rate);
> =20
> @@ -319,15 +319,16 @@ hdmi_compute_format(const struct drm_connector *con=
nector,
>  {
>  	struct drm_device *dev =3D connector->dev;
> =20
> -	/*
> -	 * TODO: Add support for YCbCr420 output for HDMI 2.0 capable
> -	 * devices, for modes that only support YCbCr420.
> -	 */

It's something that I had in the back of my mind for a while, but we're
at the point where we need to discuss this I guess :)

Not all HDMI controllers are HDMI2.0+ compliant, and we need to gatekeep
this to the fact the controller supports it.

This will also be useful for things like scrambling support. And
probably to provide some TMDS rate check based on the standard a given
controller supports, since most of the drivers have that check
duplicated everywhere.

I don't really have an opinion on how to do this, so I guess it's really
up for debate. The alternatives I could think of are either to add a new
parameter to the init function, or to create a new callback to query the
driver for its capabilities.

The former doesn't seem great since the parameters set is pretty
extensive already. The latter doesn't seem super idiomatic in KMS, but
it's a common pattern in the rest of the kernel, so maybe it's a good
idea still.

>  	if (hdmi_try_format_bpc(connector, conn_state, mode, bpc, HDMI_COLORSPA=
CE_RGB)) {
>  		conn_state->hdmi.output_format =3D HDMI_COLORSPACE_RGB;
>  		return 0;
>  	}
> =20
> +	if (hdmi_try_format_bpc(connector, conn_state, mode, bpc, HDMI_COLORSPA=
CE_YUV420)) {
> +		conn_state->hdmi.output_format =3D HDMI_COLORSPACE_YUV420;
> +		return 0;
> +	}
> +

During our discussions when we merged this infrastructure, the goal was
to align our behaviour to Intel's. The discussion also pointed out that
we want to degrade the bpc before falling back to a YUV format.

So we need to first try RGB with any bpc, and then try YUV with any BPC
if it didn't work.

We also need plenty of tests based on whether the source supports
YUV420, the sink has YUV420-only modes, that the fallback occurs
properly, etc.

Maxime

--r72hxnc5h2m3ceyw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ02V7AAKCRAnX84Zoj2+
dobDAYDS5UgEopPvn02PuX0bEE1KUKtDnkquD2Ys6RIj/0RkBSu8OeZBnV6S0nKj
ppV2qNQBgL4e2azwWes+p7MtbpzkwFK+pOhXHwdl1UBPAbF0jqMAkNLK7Mgoe8s+
w1MfBYboUQ==
=7Cpf
-----END PGP SIGNATURE-----

--r72hxnc5h2m3ceyw--

