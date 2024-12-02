Return-Path: <linux-kernel+bounces-427441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A829E0119
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ED39162A0A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0BA1FE46A;
	Mon,  2 Dec 2024 11:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQU65M29"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D894E1FE457
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 11:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733140788; cv=none; b=G+KYG/rWsmLr/lCkjkQp8WpE0AOLDMolvG2Msu4zj/nTNKXSCwxV5H7zczKE4e73Cw96vpBGr9eCFPeLZx4sCVKHFsMRIgRwQqCoOBpxXy96dmw46SpVOQohzaIeX/Agq6X/+KhWahrfZrU7IgwiAxDKOo3lUn5m3bnAZpUifng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733140788; c=relaxed/simple;
	bh=JT1goFQcBxa4ii8FS7z1ezsrRpulliTnkPm8vr3KN/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uaZFxTBztzk8M5Ecpb29hhRYoSXoFYIQP01BzK4gGx6ITuf+ylTrTkhDGGbjO8BAEn+tLqwnpncPQZP3kNyZ6pMt2lopGgd8oyFjoNh8/7/7yoelaplHT3dlBwa6rTWZ9LYXmdqpXwfMdP0Jj6mBLECOBqOSlXohitj+5dO1x3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQU65M29; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11493C4CED1;
	Mon,  2 Dec 2024 11:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733140788;
	bh=JT1goFQcBxa4ii8FS7z1ezsrRpulliTnkPm8vr3KN/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IQU65M29d4OkFYaktMObE4+dzjrLv2EARU7k8bNOGcBEZKTpy11ajBjFV3NjkfxDc
	 ipAeZoa4J75VD+tj9FpOD1vSnEpb+wGzbwpcPpCQm2CEgEh5Dw29RVkE/CQUBRtZK/
	 VRO3oMkNytO3tw3kY25QZeiJ9vqn5EfonwofWCUNmO0/55tsQ4bHUrCCw7/kk962jp
	 h6wA9MFZZlJHxicg8reArWn21AGwxnociD8DQoeRpWEULZQwNDjvDNoWgXe7jMNmI4
	 zgeeXOcw6QavU+12hqcUqVYMBcwBBttzcAEzLOoegU3zto2RqbjyIOalcG490m/NWv
	 bkOOYIvgL1cHA==
Date: Mon, 2 Dec 2024 12:59:45 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, kernel@collabora.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] drm/connector: hdmi: Add support for YUV420 format
 verification
Message-ID: <20241202-divergent-holistic-seal-b24cd6@houat>
References: <20241130-hdmi-conn-yuv-v1-0-254279a08671@collabora.com>
 <20241130-hdmi-conn-yuv-v1-2-254279a08671@collabora.com>
 <20241202-determined-sloppy-impala-2ca0f1@houat>
 <a00ba6bb-aa91-4ecf-a4e7-88d80e29dedc@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="qszps75hpkmz2px4"
Content-Disposition: inline
In-Reply-To: <a00ba6bb-aa91-4ecf-a4e7-88d80e29dedc@collabora.com>


--qszps75hpkmz2px4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/3] drm/connector: hdmi: Add support for YUV420 format
 verification
MIME-Version: 1.0

On Mon, Dec 02, 2024 at 01:15:36PM +0200, Cristian Ciocaltea wrote:
> Hi Maxime,
>=20
> On 12/2/24 12:50 PM, Maxime Ripard wrote:
> > On Sat, Nov 30, 2024 at 01:56:33AM +0200, Cristian Ciocaltea wrote:
> >> Provide the necessary constraints verification in
> >> sink_supports_format_bpc() in order to support handling of YUV420
> >> output format.
> >>
> >> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> >> ---
> >>  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 40 ++++++++++++++++=
+++++++--
> >>  1 file changed, 37 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers=
/gpu/drm/display/drm_hdmi_state_helper.c
> >> index 0cbcee7e77cd8dff387044487ce28ee5748f5587..3a55881a544a519bb12549=
68db891c814f831a0f 100644
> >> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> >> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> >> @@ -3,6 +3,7 @@
> >>  #include <drm/drm_atomic.h>
> >>  #include <drm/drm_connector.h>
> >>  #include <drm/drm_edid.h>
> >> +#include <drm/drm_modes.h>
> >>  #include <drm/drm_print.h>
> >> =20
> >>  #include <drm/display/drm_hdmi_helper.h>
> >> @@ -114,6 +115,12 @@ sink_supports_format_bpc(const struct drm_connect=
or *connector,
> >>  		return false;
> >>  	}
> >> =20
> >> +	if (drm_mode_is_420_only(info, mode) && format !=3D HDMI_COLORSPACE_=
YUV420) {
> >> +		drm_dbg_kms(dev, "%s format unsupported by the sink for VIC%u.\n",
> >> +			    drm_hdmi_connector_get_output_format_name(format), vic);
> >> +		return false;
> >> +	}
> >> +
> >>  	switch (format) {
> >>  	case HDMI_COLORSPACE_RGB:
> >>  		drm_dbg_kms(dev, "RGB Format, checking the constraints.\n");
> >> @@ -144,9 +151,36 @@ sink_supports_format_bpc(const struct drm_connect=
or *connector,
> >>  		return true;
> >> =20
> >>  	case HDMI_COLORSPACE_YUV420:
> >> -		/* TODO: YUV420 is unsupported at the moment. */
> >> -		drm_dbg_kms(dev, "YUV420 format isn't supported yet.\n");
> >> -		return false;
> >> +		drm_dbg_kms(dev, "YUV420 format, checking the constraints.\n");
> >> +
> >> +		if (!(info->color_formats & DRM_COLOR_FORMAT_YCBCR420)) {
> >> +			drm_dbg_kms(dev, "Sink doesn't support YUV420.\n");
> >> +			return false;
> >> +		}
> >> +
> >> +		if (!drm_mode_is_420(info, mode)) {
> >> +			drm_dbg_kms(dev, "Sink doesn't support YUV420 for VIC%u.\n", vic);
> >> +			return false;
> >> +		}
> >> +
> >> +		if (bpc =3D=3D 10 && !(info->hdmi.y420_dc_modes & DRM_EDID_YCBCR420=
_DC_30)) {
> >> +			drm_dbg_kms(dev, "10 BPC but sink doesn't support Deep Color 30.\n=
");
> >> +			return false;
> >> +		}
> >> +
> >> +		if (bpc =3D=3D 12 && !(info->hdmi.y420_dc_modes & DRM_EDID_YCBCR420=
_DC_36)) {
> >> +			drm_dbg_kms(dev, "12 BPC but sink doesn't support Deep Color 36.\n=
");
> >> +			return false;
> >> +		}
> >> +
> >> +		if (bpc =3D=3D 16 && !(info->hdmi.y420_dc_modes & DRM_EDID_YCBCR420=
_DC_48)) {
> >> +			drm_dbg_kms(dev, "16 BPC but sink doesn't support Deep Color 48.\n=
");
> >> +			return false;
> >> +		}
> >> +
> >> +		drm_dbg_kms(dev, "YUV420 format supported in that configuration.\n"=
);
> >> +
> >> +		return true;
> >=20
> > We also need to check whether the source supports it or not.
>=20
> I assumed the following check does already handle that:
>=20
> 	if (!(connector->hdmi.supported_formats & BIT(format))) {
> 		drm_dbg_kms(dev, "%s format unsupported by the connector.\n",
>=20
> Is there anything else missing?

You're right, sorry for the noise :)

Maxime

--qszps75hpkmz2px4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ02hMQAKCRAnX84Zoj2+
dqoHAYCBfSK4ZS5Gd9mS0d+JLRzapEFV5fr78HzDzNKbnbEZQwdYlPBi81IbgIrM
flOgo/ABf1u9jUouNbvdN0FJ83tM0gMkLAXQDn1b0cLqcqx96dSkBZmZwYN++jBs
1ZvUEZJGEw==
=Yos7
-----END PGP SIGNATURE-----

--qszps75hpkmz2px4--

