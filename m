Return-Path: <linux-kernel+bounces-427279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2A59DFF06
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33951281EDE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323F41FA854;
	Mon,  2 Dec 2024 10:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I63s1N3z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B581FCCF4;
	Mon,  2 Dec 2024 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733135544; cv=none; b=S7u1fZQEmVSCqJ4f7tTZbyVwCKVE1qHpd6HkzyUamSYLQnQzFy42JDRQVKxTwPPIqoDVqjpqayWz4l47PmhMBlwaKmEztKgU9vvurLEsiwXfJCrxb/sM2Bo4TNk2BZ0gH4Q5NVVcxB050IbXGFNSX9zqxWmtVLdD0s3lRRHH21Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733135544; c=relaxed/simple;
	bh=YNX+vtim4wPZJIk1OfZDjYYPEiiBQR0VOr9a8vWD2QI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQf13T0hq1KdTS0LoUckE6Qf/uJSQEm/MpROmpVqXCw8srk7xP6e0gIsZ3dRUJZDhZEMt7+l/RP+JGrziRcAtF6zNgYBU5J3ZwZJF/FIze9IGLgywHDkHr4UERo3dSxl/k7YQ6Qaq4J3MOZL2m+BbgyluiWnvn/dksPY01LJnG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I63s1N3z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5FD1C4CED1;
	Mon,  2 Dec 2024 10:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733135544;
	bh=YNX+vtim4wPZJIk1OfZDjYYPEiiBQR0VOr9a8vWD2QI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I63s1N3zfrfrbvkEfMtGs435oMJwprLnFVwyqZGSUHQWnx0D/JaOjCQ2O+6PPA9C9
	 EwC7O5rtJBaZR4eUArUUJ/+7q1n2WALsdEnRHSGva1EHwPg7yiSmpFoYO3Ep7q43/S
	 lUQBDtk2TfOpunkcn61IIS95BWSHPFP58kc8MuLbJNZYRAgmEKwpADKq16qXNLIze5
	 CtluBevWFNMxVf4Hitg8FJ3kRLoWWrRY5L5fXdTdSu3u51+1OR1L4CxpTFWeaAiVkW
	 AuRFHNnIWMVJMQpstRhHlGboHN8bBbyOJ23v/riDQPRs9jYYkeDjbHimeZy/UcUKtf
	 2vaNkplqCFosQ==
Date: Mon, 2 Dec 2024 11:32:21 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Yannick Fertre <yannick.fertre@foss.st.com>, Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
	Philippe Cornu <philippe.cornu@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 1/3] drm/modes: introduce drm_mode_validate_mode()
 helper function
Message-ID: <20241202-nickel-rottweiler-of-hail-c9ec8b@houat>
References: <20241125-dsi-relax-v2-0-9113419f4a40@geanix.com>
 <20241125-dsi-relax-v2-1-9113419f4a40@geanix.com>
 <20241125-gleaming-anteater-of-perfection-42bd2b@houat>
 <bfuj6w6hsbfpdw24th6dl3ugvj45op6jb45gx5ab5pulud7hiz@o2zbn45z3lt4>
 <tzcjzgp7xalhhezcv5hfa7cjscxg44phqcw2ap54lesly4gk6o@6dtco2d3jahj>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="ivbwnrarbwqca5xp"
Content-Disposition: inline
In-Reply-To: <tzcjzgp7xalhhezcv5hfa7cjscxg44phqcw2ap54lesly4gk6o@6dtco2d3jahj>


--ivbwnrarbwqca5xp
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/3] drm/modes: introduce drm_mode_validate_mode()
 helper function
MIME-Version: 1.0

On Tue, Nov 26, 2024 at 02:30:53PM +0100, Sean Nyekjaer wrote:
> Hi Maxime,
>=20
> On Tue, Nov 26, 2024 at 08:36:01AM +0100, Sean Nyekjaer wrote:
> > Hi Maxime,
> >=20
>=20
> [...]
>=20
> > >=20
> > > We probably need some kunit tests here too.
> >=20
> > Good idea, will be my first :)
> >=20
>=20
> Would something like this work?
>=20
> diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers=
/gpu/drm/tests/drm_hdmi_state_helper_test.c
> index 294773342e71..26e4ff02df85 100644
> --- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
> +++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
> @@ -1364,6 +1364,7 @@ static void drm_test_check_output_bpc_format_displa=
y_rgb_only(struct kunit *test
>  	struct drm_connector_state *conn_state;
>  	struct drm_display_info *info;
>  	struct drm_display_mode *preferred;
> +	enum drm_mode_status mode_status;
>  	unsigned long long rate;
>  	struct drm_connector *conn;
>  	struct drm_device *drm;
> @@ -1408,6 +1409,9 @@ static void drm_test_check_output_bpc_format_displa=
y_rgb_only(struct kunit *test
>  	rate =3D drm_hdmi_compute_mode_clock(preferred, 12, HDMI_COLORSPACE_YUV=
422);
>  	KUNIT_ASSERT_LT(test, rate, info->max_tmds_clock * 1000);
> =20
> +	mode_status =3D drm_mode_check_pixel_clock(preferred, rate);
> +	KUNIT_ASSERT_EQ(test, mode_status, MODE_OK);
> +

Not really. You need to test that function, and ideally only that
function, with a bunch of random inputs, including the error conditions.

Maxime

--ivbwnrarbwqca5xp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ02MtAAKCRAnX84Zoj2+
dsuWAX0eSysvVggNKHnyuBE+8Rz7YOBscN6mBZYUgtssEAyp5cpCoqjzQx8yMf5Z
kDz+dB8Bf2t8VtXvAAOtTW5epqM0PuPE2F67EoJN+5eQBc95ywPDx51OucBNqL3Y
Ja65ubL3mg==
=gqfV
-----END PGP SIGNATURE-----

--ivbwnrarbwqca5xp--

