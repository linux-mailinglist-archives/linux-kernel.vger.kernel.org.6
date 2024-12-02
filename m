Return-Path: <linux-kernel+bounces-427295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8AD9DFF56
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C68D3B220A7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442E01FC7F6;
	Mon,  2 Dec 2024 10:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDJGsEyZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44A81D86C4
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733136604; cv=none; b=oixNufO/vM8gn3DfGH1pnnBYHGCuKaGG90K7gmz1xAexqieDTKyS7u1oDUJYC7ZNdBXN3S6cs/SXNzI3HRiCbvQwrM4AAcuF1ftbnVBUlWWPWoE50nL8YpiiNmBOUh7z71F78Mq35tU0L7UVdBkjXh9NOWgyO/Wg2CT8WgPAHdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733136604; c=relaxed/simple;
	bh=oa3LWKx0q+hssDkyLf4Ro7qS3vXJd9aWhlR0j5SmrNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xr2D7ccqvFaj+xughemrQ0LeZ5CuhFhLvW95BQBQ5A+2k5Enu2z2EVbGJrQ4kxJdBdNa1GpGZM9G6GYkWbNV7j/stediT/ow/UJCtZOKMSp0CRqArvOeamBAQ8aaPT/RM+/EvIeOFlyiU0aoSkAV0gRXfst35TIeCZ6dmNhkiWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDJGsEyZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A12C4CED1;
	Mon,  2 Dec 2024 10:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733136604;
	bh=oa3LWKx0q+hssDkyLf4Ro7qS3vXJd9aWhlR0j5SmrNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PDJGsEyZNn7/3jzaKsnFLfsOLvRKbSB+0Yw4ffOcBe5gb+cXunKpyikvgNlYv+6NT
	 Y2jbaWu/JL2uG6lCzjyL+C+LxH3eNfwJyAPoW7fmOmEMBuAUUKglUtdwe5DPxtXN7v
	 O0ocONE/0uGlbkttPdun0sGz4t++ebG8LXezpLUL/HpWRWemFhvV12Jru7vaPXrgbP
	 6C/Y6T1sH0s6kQXgcwt4Iis2e4RIVkGYvSxAaFF9hJOJh1lshS2lulEZme3+iX5MUy
	 kv4V2+e4VOJ/UFBkUlXglon7HJlGag4EA3BOR4pEjUpa9AB7A5EIBZn0k+HaD8HPkS
	 WELFS8ZF7vBUg==
Date: Mon, 2 Dec 2024 11:50:01 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, kernel@collabora.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] drm/connector: hdmi: Add support for YUV420 format
 verification
Message-ID: <20241202-determined-sloppy-impala-2ca0f1@houat>
References: <20241130-hdmi-conn-yuv-v1-0-254279a08671@collabora.com>
 <20241130-hdmi-conn-yuv-v1-2-254279a08671@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="7wlqficqr2uskn4l"
Content-Disposition: inline
In-Reply-To: <20241130-hdmi-conn-yuv-v1-2-254279a08671@collabora.com>


--7wlqficqr2uskn4l
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/3] drm/connector: hdmi: Add support for YUV420 format
 verification
MIME-Version: 1.0

On Sat, Nov 30, 2024 at 01:56:33AM +0200, Cristian Ciocaltea wrote:
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
> index 0cbcee7e77cd8dff387044487ce28ee5748f5587..3a55881a544a519bb1254968d=
b891c814f831a0f 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> @@ -3,6 +3,7 @@
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_connector.h>
>  #include <drm/drm_edid.h>
> +#include <drm/drm_modes.h>
>  #include <drm/drm_print.h>
> =20
>  #include <drm/display/drm_hdmi_helper.h>
> @@ -114,6 +115,12 @@ sink_supports_format_bpc(const struct drm_connector =
*connector,
>  		return false;
>  	}
> =20
> +	if (drm_mode_is_420_only(info, mode) && format !=3D HDMI_COLORSPACE_YUV=
420) {
> +		drm_dbg_kms(dev, "%s format unsupported by the sink for VIC%u.\n",
> +			    drm_hdmi_connector_get_output_format_name(format), vic);
> +		return false;
> +	}
> +
>  	switch (format) {
>  	case HDMI_COLORSPACE_RGB:
>  		drm_dbg_kms(dev, "RGB Format, checking the constraints.\n");
> @@ -144,9 +151,36 @@ sink_supports_format_bpc(const struct drm_connector =
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
> +			return false;
> +		}
> +
> +		if (bpc =3D=3D 10 && !(info->hdmi.y420_dc_modes & DRM_EDID_YCBCR420_DC=
_30)) {
> +			drm_dbg_kms(dev, "10 BPC but sink doesn't support Deep Color 30.\n");
> +			return false;
> +		}
> +
> +		if (bpc =3D=3D 12 && !(info->hdmi.y420_dc_modes & DRM_EDID_YCBCR420_DC=
_36)) {
> +			drm_dbg_kms(dev, "12 BPC but sink doesn't support Deep Color 36.\n");
> +			return false;
> +		}
> +
> +		if (bpc =3D=3D 16 && !(info->hdmi.y420_dc_modes & DRM_EDID_YCBCR420_DC=
_48)) {
> +			drm_dbg_kms(dev, "16 BPC but sink doesn't support Deep Color 48.\n");
> +			return false;
> +		}
> +
> +		drm_dbg_kms(dev, "YUV420 format supported in that configuration.\n");
> +
> +		return true;

We also need to check whether the source supports it or not.

Maxime

--7wlqficqr2uskn4l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ02Q2QAKCRAnX84Zoj2+
dh7BAX0dAzaXyvLI3gNrkxk3BA2CMrs0B2KtTMO8lN/cEuyyA2VYZ1/zkanT1wfo
XPQgxtQBfAxGDgj7hXs02LvAfGTlt0bV44mW7HNVhQMKquUEoQzi3FelcpgaXBiI
KraBIbaXdA==
=Kde+
-----END PGP SIGNATURE-----

--7wlqficqr2uskn4l--

