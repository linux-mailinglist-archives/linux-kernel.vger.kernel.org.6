Return-Path: <linux-kernel+bounces-556491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7151BA5CA7F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A40D3176733
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13CA25F988;
	Tue, 11 Mar 2025 16:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KM0sz2kL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A56D25F782
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 16:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741709566; cv=none; b=KWQBAWXlGFJVNsL8yQ4AouTEPY5+bOTaxDvKanARKfECiAbBgPbbBQRVftv3sDoU0oMpwAN+wC2rTcg6wtMpJlyhiM36kDz3Ux5MqesnLPDu7fu/JDhHU1vk+7scXLui85rnztRPOAr8RjAFqAZmHfltHzY8YyLlzA/VUDYeMYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741709566; c=relaxed/simple;
	bh=Vv+W8BWsFIppfBrJLl0xt21IvxzSdTfjfugnv+BbV0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNxqXw9wLMpaUv8ccdrmzAqNUc/nvd62qYEv7dB68NcWNNiCUs33bRwH3QkPZSl2uQQWjl+/Zvwoy+KdDQ9AhNnwKHaRy5TWlxczO79nSgXmsmaLmY/B6eEy8q/aXg4f44KlfWrSqhrKKcArgRXuhvFDCwAsp285B9Ef5gR5s/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KM0sz2kL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AEA8C4CEE9;
	Tue, 11 Mar 2025 16:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741709565;
	bh=Vv+W8BWsFIppfBrJLl0xt21IvxzSdTfjfugnv+BbV0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KM0sz2kLlgIEOGF3OtSqFogA8Rmo8q8WX37MYFiIEKqkHGKYSaY7bTOBsT/xXLh/Q
	 wfUFMWhut+plVI6fu95jyUAjRsllmezflUIEg+AqBA5UpdmCE1Y18mPoGtte9V39hL
	 WilpP39C5rm3SxsmxmLnX5CT0zFbsz8Q0tEp9/839Qjukp3cvmhxbhW8xdN0G0X+WK
	 3myKIRnSTXnuExb9sVqvX8HodJn1scg5rBf6654KrdBTOWkse3hdGwsIL/xtJGWJkG
	 exFtj9Gng4QHT/Vg4f8wdzpC+CIEorxtqjQ+Uopa6J4y0MnunpbBLoAYuK5FFGCvti
	 HJ6Ef3L3cy5Fw==
Date: Tue, 11 Mar 2025 17:12:42 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, kernel@collabora.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] drm/tests: hdmi: Add macros to simplify EDID setup
Message-ID: <20250311-spiritual-hornet-of-prestige-ef4132@houat>
References: <20250311-hdmi-conn-yuv-v2-0-fbdb94f02562@collabora.com>
 <20250311-hdmi-conn-yuv-v2-5-fbdb94f02562@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ehgan4hodvsqo6jl"
Content-Disposition: inline
In-Reply-To: <20250311-hdmi-conn-yuv-v2-5-fbdb94f02562@collabora.com>


--ehgan4hodvsqo6jl
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 5/7] drm/tests: hdmi: Add macros to simplify EDID setup
MIME-Version: 1.0

On Tue, Mar 11, 2025 at 12:57:37PM +0200, Cristian Ciocaltea wrote:
> Introduce a few macros to facilitate setting custom (i.e. non-default)
> EDID data during connector initialization.
>=20
> This helps reducing boilerplate code while also drops some redundant
> calls to set_connector_edid().
>=20
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 245 ++++++++-------=
------
>  1 file changed, 93 insertions(+), 152 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers=
/gpu/drm/tests/drm_hdmi_state_helper_test.c
> index e97efd3af9ed18e6cf8ee66b4923dfc805b34e19..a3f7f3ce31c73335c2c2643bd=
c5395b6ceb6f071 100644
> --- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
> +++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
> @@ -183,10 +183,12 @@ static const struct drm_connector_funcs dummy_conne=
ctor_funcs =3D {
> =20
>  static
>  struct drm_atomic_helper_connector_hdmi_priv *
> -drm_kunit_helper_connector_hdmi_init_funcs(struct kunit *test,
> -					   unsigned int formats,
> -					   unsigned int max_bpc,
> -					   const struct drm_connector_hdmi_funcs *hdmi_funcs)
> +connector_hdmi_init_funcs_set_edid(struct kunit *test,
> +				   unsigned int formats,
> +				   unsigned int max_bpc,
> +				   const struct drm_connector_hdmi_funcs *hdmi_funcs,
> +				   const char *edid_data,
> +				   size_t edid_len)
>  {
>  	struct drm_atomic_helper_connector_hdmi_priv *priv;
>  	struct drm_connector *conn;
> @@ -240,30 +242,27 @@ drm_kunit_helper_connector_hdmi_init_funcs(struct k=
unit *test,
> =20
>  	drm_mode_config_reset(drm);
> =20
> +	if (edid_data && edid_len) {
> +		ret =3D set_connector_edid(test, &priv->connector, edid_data, edid_len=
);
> +		KUNIT_ASSERT_GT(test, ret, 0);
> +	}
> +
>  	return priv;
>  }
> =20
> -static
> -struct drm_atomic_helper_connector_hdmi_priv *
> -drm_kunit_helper_connector_hdmi_init(struct kunit *test,
> -				     unsigned int formats,
> -				     unsigned int max_bpc)
> -{
> -	struct drm_atomic_helper_connector_hdmi_priv *priv;
> -	int ret;
> +#define drm_kunit_helper_connector_hdmi_init_funcs_set_edid(test, format=
s, max_bpc, funcs, edid) \
> +	connector_hdmi_init_funcs_set_edid(test, formats, max_bpc, funcs, edid,=
 ARRAY_SIZE(edid))
> =20
> -	priv =3D drm_kunit_helper_connector_hdmi_init_funcs(test,
> -							  formats, max_bpc,
> -							  &dummy_connector_hdmi_funcs);
> -	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
> +#define drm_kunit_helper_connector_hdmi_init_funcs(test, formats, max_bp=
c, funcs)		\
> +	connector_hdmi_init_funcs_set_edid(test, formats, max_bpc, funcs, NULL,=
 0)
> =20
> -	ret =3D set_connector_edid(test, &priv->connector,
> -				 test_edid_hdmi_1080p_rgb_max_200mhz,
> -				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_max_200mhz));
> -	KUNIT_ASSERT_GT(test, ret, 0);
> +#define drm_kunit_helper_connector_hdmi_init_set_edid(test, formats, max=
_bpc, edid)		\
> +	drm_kunit_helper_connector_hdmi_init_funcs_set_edid(test, formats, max_=
bpc,		\
> +							    &dummy_connector_hdmi_funcs, edid)
> =20
> -	return priv;
> -}
> +#define drm_kunit_helper_connector_hdmi_init(test, formats, max_bpc)				\
> +	drm_kunit_helper_connector_hdmi_init_set_edid(test, formats, max_bpc,		=
	\
> +						      test_edid_hdmi_1080p_rgb_max_200mhz)

I'd really prefer to have functions to macros here. They are easier to
read, extend, and don't have any particular drawbacks.

I also don't think we need that many, looking at the tests:

  - We need drm_kunit_helper_connector_hdmi_init() to setup a connector
    with test_edid_hdmi_1080p_rgb_max_200mhz and
    dummy_connector_hdmi_funcs()

  - We need to create a
    drm_kunit_helper_connector_hdmi_init_with_edid_funcs() to pass both
    the funcs and edid pointers

And that's it, right?

>  /*
>   * Test that if we change the RGB quantization property to a different
> @@ -771,19 +770,15 @@ static void drm_test_check_output_bpc_crtc_mode_cha=
nged(struct kunit *test)
>  	struct drm_crtc *crtc;
>  	int ret;
> =20
> -	priv =3D drm_kunit_helper_connector_hdmi_init(test,
> -						    BIT(HDMI_COLORSPACE_RGB),
> -						    10);
> +	priv =3D drm_kunit_helper_connector_hdmi_init_set_edid(test,
> +				BIT(HDMI_COLORSPACE_RGB),
> +				10,
> +				test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz);

I think that convertion should be part of another patch.

Maxime

--ehgan4hodvsqo6jl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZ9Bg+gAKCRDj7w1vZxhR
xZ0RAP9ZOjOoFg8CpHr2Bi37SQdP5J9ZAOHIW8zTNCC42bKF4QD/UBVPIUNL6Bc7
5qTju7pvnBUnivSNbLt4ywKJ7QsASAo=
=VrjK
-----END PGP SIGNATURE-----

--ehgan4hodvsqo6jl--

