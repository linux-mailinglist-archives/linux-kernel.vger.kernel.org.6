Return-Path: <linux-kernel+bounces-420673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8B19D8204
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19430B23839
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6124190462;
	Mon, 25 Nov 2024 09:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kl37uair"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C8B190055;
	Mon, 25 Nov 2024 09:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732526104; cv=none; b=D/U6tc4+w0F6qzB7bfeQZibnzU/Z62ssd7NKuCqISygd1Zt2W54L0ObzB3Uw0NThEfnMLCcN0HEt1cuLXPrUJrdFXLPixD3jvC0P5MCm7RIk1kTHUeAqlSw15QGirINO1d4etASvOGz5+B1ZYZjV3M6hk2g5OSCGBu81FbJ3IxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732526104; c=relaxed/simple;
	bh=l2aVA8vVFVYNGR2zFgk1p6wGxiDGbMc6CYQeb4SKoOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4ftM5GrIfmk+eMS8La3KL62Bo30Lpk4PnByiBKDFJhEbSOfANieUZWzL4jot0k7y8EaMz5belEAuLWfpJrBLCwq3mV++gA6LAmNaQyWy42/RoRMSbpjQIUVr65Q5pHftdBfgxVYXjincaZ+roK6fqGZi6vv32Vs5gE989gk/EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kl37uair; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60842C4CECE;
	Mon, 25 Nov 2024 09:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732526103;
	bh=l2aVA8vVFVYNGR2zFgk1p6wGxiDGbMc6CYQeb4SKoOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kl37uairFXYBbHHwAuIoo7e8D64bTeeB6knTN8A1trLOMdBpUtYBgYFtyfcdoVWsn
	 KZ3VBmmeHHFlSRdaS2cVFOBPoo2/imYXJUOutXGATw0ws2U8ELBoQJgkjc7noQJBSr
	 MwayUudDPpus4rsLnL3QCLiDH5rTHBYzGAtc8kN+v4xTZsFo4wmHqWOZNqaY+LgszC
	 O7ab83H6ZObm260B+cZoTijEaiRu7TLvj2kxCjdxzxLRE/2yKJEI5uHtjZ+sEQoDiJ
	 Xg/wyXNbnPhVsDnVY9aCeH6mYbSXx+URF+LSJuDTtG2duiwQ3+OumqtQzKDwbf/bXE
	 bnMYx/pnt2mHw==
Date: Mon, 25 Nov 2024 10:15:00 +0100
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
Subject: Re: [PATCH v4 02/10] drm/tests: hdmi: rename connector creation
 function
Message-ID: <20241125-keen-clever-quokka-c637b2@houat>
References: <20241122-hdmi-mode-valid-v4-0-2fee4a83ab79@linaro.org>
 <20241122-hdmi-mode-valid-v4-2-2fee4a83ab79@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="5nvxg2sjvsyk3e7c"
Content-Disposition: inline
In-Reply-To: <20241122-hdmi-mode-valid-v4-2-2fee4a83ab79@linaro.org>


--5nvxg2sjvsyk3e7c
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 02/10] drm/tests: hdmi: rename connector creation
 function
MIME-Version: 1.0

On Fri, Nov 22, 2024 at 11:12:58AM +0200, Dmitry Baryshkov wrote:
> As pointed out by Maxime, the drm_atomic_helper_connector_hdmi_init()
> isn't a good name for a function inside KUnit tests. Rename it to
> drm_kunit_helper_connector_hdmi_init().
>=20
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 58 +++++++++++-----=
------
>  1 file changed, 29 insertions(+), 29 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers=
/gpu/drm/tests/drm_hdmi_state_helper_test.c
> index 1e77689af6549f162eb3026c7bd2bbd59516ed98..d81254d46975e8af0d7822499=
28217a1ebb7646e 100644
> --- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
> +++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
> @@ -164,7 +164,7 @@ static const struct drm_connector_funcs dummy_connect=
or_funcs =3D {
> =20
>  static
>  struct drm_atomic_helper_connector_hdmi_priv *
> -drm_atomic_helper_connector_hdmi_init(struct kunit *test,
> +drm_kunit_helper_connector_hdmi_init(struct kunit *test,
>  				      unsigned int formats,
>  				      unsigned int max_bpc)
>  {
> @@ -247,7 +247,7 @@ static void drm_test_check_broadcast_rgb_crtc_mode_ch=
anged(struct kunit *test)
>  	struct drm_crtc *crtc;
>  	int ret;
> =20
> -	priv =3D drm_atomic_helper_connector_hdmi_init(test,
> +	priv =3D drm_kunit_helper_connector_hdmi_init(test,
>  						     BIT(HDMI_COLORSPACE_RGB),
>  						     8);

The alignment is off now. With that fixed,

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Maxime

--5nvxg2sjvsyk3e7c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ0RAFAAKCRAnX84Zoj2+
dh+SAX9rgI2nb5O0z3ETsjtoX/QZlU3rBnbmhHEwAbJFUPMrzNJL44xVeCcncyF/
bnAChXcBf2C8MyZ3uQBADGQ2JpJlzrcAmW9SOPR3crnLIPFzw9SpjxX08GXSq9Fb
g9OOkGL/cw==
=MCsN
-----END PGP SIGNATURE-----

--5nvxg2sjvsyk3e7c--

