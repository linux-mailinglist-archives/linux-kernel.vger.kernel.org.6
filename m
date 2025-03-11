Return-Path: <linux-kernel+bounces-556414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45945A5C78A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5356B3B705D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7DD25EFB8;
	Tue, 11 Mar 2025 15:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXAjj4A6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AAD25E83E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 15:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741707016; cv=none; b=hQIcSfdyRa9goqPpCmhX3SNcKI5uXeRuHBoTJ2Xj7BYNrMgD5txbbdeszNGbtrJ3neHNWx3QbY3le4oqHW00zi9Vy9hZZZ0vh+5bbErsoxQILC3Z23RHxqWfBEQEr2e6SMh8TxIV/DDTArFsIbJocyZ9rd2oOb4GeMw/TayGN8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741707016; c=relaxed/simple;
	bh=gnsDuxEK7ajjvA8C8lxp+hRGEr56RnksDKUW21yjdJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+x3gGNofz4BTum27y7Q5TBcUUGcdo6hl5gEFEF+ppPLLvUWToAZkZgeVAUx89YjsMqTBtftKwOhl3x0iDaz0rHmnktrYVF4mGHh1sWgQBRDkJqQeGsz6es06C5hRl6ADedCj34aSgAcuhU4s//cJU6uLfjSofo2J93fnVs+DK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXAjj4A6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39623C4CEE9;
	Tue, 11 Mar 2025 15:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741707016;
	bh=gnsDuxEK7ajjvA8C8lxp+hRGEr56RnksDKUW21yjdJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AXAjj4A6QLLWeMy5JZK+kDw9L8FhsPKnSoO/Jm1HXmmXxi3HVzkgs/R69t5nCbO5D
	 Iyi/34sJl+BjKG/hr2Nkg2BCXBetjhM/YwQ/Jg5YqxID9s+BjdW5OZuOUimU2vgNo6
	 NKPDQkgtViERWssCds13y55IcYy5dM1/8ORo/8K1yM1qP8P7C/WEBxKx1MLDLCZQHT
	 4bRvoibOOnJg+E7H+4THhVRPCTn7e6xd2xX6UKiiL+izWj14nLe+MRrx1GMdxx+/lk
	 URSwW9Z9NhgDw0pDh2aAQe9a1UqOy7zpo7fN1l5tXacDWMwe3N6VDsli8SCvX4RWu5
	 UzkSZ89ZpMQVg==
Date: Tue, 11 Mar 2025 16:30:13 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, kernel@collabora.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] drm/connector: hdmi: Add support for YUV420
 format verification
Message-ID: <20250311-spectral-utopian-poodle-4feadb@houat>
References: <20250311-hdmi-conn-yuv-v2-0-fbdb94f02562@collabora.com>
 <20250311-hdmi-conn-yuv-v2-2-fbdb94f02562@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qeeroqqbm4g4zr6w"
Content-Disposition: inline
In-Reply-To: <20250311-hdmi-conn-yuv-v2-2-fbdb94f02562@collabora.com>


--qeeroqqbm4g4zr6w
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/7] drm/connector: hdmi: Add support for YUV420
 format verification
MIME-Version: 1.0

On Tue, Mar 11, 2025 at 12:57:34PM +0200, Cristian Ciocaltea wrote:
> Provide the necessary constraints verification in
> sink_supports_format_bpc() in order to support handling of YUV420
> output format.
>=20
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 40 +++++++++++++++++++=
++++--
>  1 file changed, 37 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gp=
u/drm/display/drm_hdmi_state_helper.c
> index 6bc96d5d1ab9115989e208d9899e16cd22254fb6..e99d868edc1854eddc5ebf869=
2ccffb9e2338268 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> @@ -3,6 +3,7 @@
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_connector.h>
>  #include <drm/drm_edid.h>
> +#include <drm/drm_modes.h>
>  #include <drm/drm_print.h>
> =20
>  #include <drm/display/drm_hdmi_audio_helper.h>
> @@ -115,6 +116,12 @@ sink_supports_format_bpc(const struct drm_connector =
*connector,
>  		return false;
>  	}
> =20
> +	if (drm_mode_is_420_only(info, mode) && format !=3D HDMI_COLORSPACE_YUV=
420) {
> +		drm_dbg_kms(dev, "%s format unsupported by the sink for VIC%u.\n",
> +			    drm_hdmi_connector_get_output_format_name(format), vic);

We don't necessarily have a VIC for the mode we pass, so it's not super
useful to pass it. I'd rather mention that the mode is supposed to be
YUV420 only, but the format isn't YUV420.

> +		return false;
> +	}
> +
>  	switch (format) {
>  	case HDMI_COLORSPACE_RGB:
>  		drm_dbg_kms(dev, "RGB Format, checking the constraints.\n");
> @@ -145,9 +152,36 @@ sink_supports_format_bpc(const struct drm_connector =
*connector,
>  		return true;
> =20
>  	case HDMI_COLORSPACE_YUV420:
> -		/* TODO: YUV420 is unsupported at the moment. */
> -		drm_dbg_kms(dev, "YUV420 format isn't supported yet.\n");
> -		return false;
> +		drm_dbg_kms(dev, "YUV420 format, checking the constraints.\n");
> +
> +		if (!(info->color_formats & DRM_COLOR_FORMAT_YCBCR420)) {
> +			drm_dbg_kms(dev, "Sink doesn't support YUV420.\n");
> +			return false;
> +		}
> +
> +		if (!drm_mode_is_420(info, mode)) {
> +			drm_dbg_kms(dev, "Sink doesn't support YUV420 for VIC%u.\n", vic);

Again, we shouldn't print the VIC here. There's a printk format we can
use to print drm_display_mode if you want to, but we should keep things
consistent.

Maxime

--qeeroqqbm4g4zr6w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZ9BXBQAKCRDj7w1vZxhR
xbfmAP4tQ/0s+jugmqqicuWqzhQXNIyH7ZrdXDlGGkGZfCQLSgEAsEV7mz0+n8kO
AogCOF3vgOw9AG7FwornHV+UipTxEAk=
=EgXU
-----END PGP SIGNATURE-----

--qeeroqqbm4g4zr6w--

