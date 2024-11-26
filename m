Return-Path: <linux-kernel+bounces-422094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE599D9490
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 10:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58A52B2C794
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 09:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F271B6D04;
	Tue, 26 Nov 2024 09:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQdq2LZE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171AF84D0E;
	Tue, 26 Nov 2024 09:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732613411; cv=none; b=cIQh61RUhJFAqh+oln3tMo7To2WctSaQfjzkygMOyzoDF2UimomM1MPQvTWU+8VstaBixG7aAFcGRhmEODzHwTrChHN6LwSp09wPdCQmmEnr+L+ZWo4UFzXc1OJ6Fy05mr6SmH4ifJiGmI0amuVP6718CxvtZ3aRn37KGb/ZYy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732613411; c=relaxed/simple;
	bh=9Ay6+imSrXagOd8Xd0hPE8chBJ5GelgKMPvVGoiR2e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5Nvp3vXG31B0kQXZZRLB7oyfk2d0L8vyhQfftYZ+R2XAGKyQJzGweSFenE8gbq4R4AFi80IXFf4pmla5Bdh8qIqXpslfNgFq7mvV4ebNgQJr2KcHs9ZDmweTPJwnS5CaCzBDrP3PBXG7Jyj+osQ0dOQ6sDSzbiMwBxegUrCD28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQdq2LZE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0A3C4CECF;
	Tue, 26 Nov 2024 09:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732613410;
	bh=9Ay6+imSrXagOd8Xd0hPE8chBJ5GelgKMPvVGoiR2e8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WQdq2LZE9YTWOxAyv7FnmGEL6ltFHnouW2WMUelybvVewvAWZm15QH/lf4XnmpQIj
	 rlQos5T4MqJKm0b4DQ+XG/dwzrlSHYISKPwh1eT8EYKMDTbHpep6jNgk2xbMKdFDiJ
	 hn4GR7SeIgMtyW1i5NZi60c+PAJdj3CDW3nvknu4LQcgmMSBr9kw1YUcB0r0hL6u0b
	 AfWWeTAU1kj3t137X4AI3F7clejrXfnU7TD+LNP9Sb/TNVQXlciE6FtXt9h8HzQmly
	 XJFQtHV2onhmWl+5d/rCLPRImcGfpHpSC1OHCVSX9Yh2hwq7dtq9rUmpxlO9EKusN2
	 dq3Ud11z9oHyg==
Date: Tue, 26 Nov 2024 10:30:07 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Cc: Sean Nyekjaer <sean@geanix.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Yannick Fertre <yannick.fertre@foss.st.com>, Philippe Cornu <philippe.cornu@foss.st.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 1/3] drm/modes: introduce drm_mode_validate_mode()
 helper function
Message-ID: <20241126-silver-skylark-of-expertise-bba576@houat>
References: <20241125-dsi-relax-v2-0-9113419f4a40@geanix.com>
 <20241125-dsi-relax-v2-1-9113419f4a40@geanix.com>
 <20241125-gleaming-anteater-of-perfection-42bd2b@houat>
 <bfuj6w6hsbfpdw24th6dl3ugvj45op6jb45gx5ab5pulud7hiz@o2zbn45z3lt4>
 <725aafb8-abfa-40c0-967a-62122206f736@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="ivjgiyez6uyhrxcb"
Content-Disposition: inline
In-Reply-To: <725aafb8-abfa-40c0-967a-62122206f736@foss.st.com>


--ivjgiyez6uyhrxcb
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/3] drm/modes: introduce drm_mode_validate_mode()
 helper function
MIME-Version: 1.0

On Tue, Nov 26, 2024 at 09:47:17AM +0100, Raphael Gallais-Pou wrote:
>=20
> On 11/26/24 08:36, Sean Nyekjaer wrote:
> > Hi Maxime,
> >
> > On Mon, Nov 25, 2024 at 05:00:56PM +0100, Maxime Ripard wrote:
> >> Hi Sean,
> >>
> >> On Mon, Nov 25, 2024 at 02:49:26PM +0100, Sean Nyekjaer wrote:
> >>> Check if the required pixel clock is in within .5% range of the
> >>> desired pixel clock.
> >>> This will match the requirement for HDMI where a .5% tolerance is all=
owed.
> >>>
> >>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> >>> ---
> >>>  drivers/gpu/drm/drm_modes.c | 34 ++++++++++++++++++++++++++++++++++
> >>>  include/drm/drm_modes.h     |  2 ++
> >>>  2 files changed, 36 insertions(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
> >>> index 6ba167a3346134072d100af0adbbe9b49e970769..4068b904759bf80502efd=
e6e4d977b297f5d5359 100644
> >>> --- a/drivers/gpu/drm/drm_modes.c
> >>> +++ b/drivers/gpu/drm/drm_modes.c
> >>> @@ -1623,6 +1623,40 @@ bool drm_mode_equal_no_clocks_no_stereo(const =
struct drm_display_mode *mode1,
> >>>  }
> >>>  EXPORT_SYMBOL(drm_mode_equal_no_clocks_no_stereo);
> >>> =20
> >>> +/**
> >>> + * drm_mode_validate_mode
> >>> + * @mode: mode to check
> >>> + * @rounded_rate: output pixel clock
> >>> + *
> >>> + * VESA DMT defines a tolerance of 0.5% on the pixel clock, while the
> >>> + * CVT spec reuses that tolerance in its examples, so it looks to be=
 a
> >>> + * good default tolerance for the EDID-based modes. Define it to 5 p=
er
> >>> + * mille to avoid floating point operations.
> >>> + *
> >>> + * Returns:
> >>> + * The mode status
> >>> + */
> >>> +enum drm_mode_status drm_mode_validate_mode(const struct drm_display=
_mode *mode,
> >>> +					    unsigned long long rounded_rate)
> >>> +{
> >>> +	enum drm_mode_status status;
> >>> +	unsigned long long rate =3D mode->clock * 1000;
> >>> +	unsigned long long lowest, highest;
> >>> +
> >>> +	lowest =3D rate * (1000 - 5);
> >>> +	do_div(lowest, 1000);
> >>> +	if (rounded_rate < lowest)
> >>> +		return MODE_CLOCK_LOW;
> >>> +
> >>> +	highest =3D rate * (1000 + 5);
> >>> +	do_div(highest, 1000);
> >>> +	if (rounded_rate > highest)
> >>> +		return MODE_CLOCK_HIGH;
> >>> +
> >>> +	return MODE_OK;
> >>> +}
> >>> +EXPORT_SYMBOL(drm_mode_validate_mode);
> Hi Sean, Maxime,
> >> Thanks a lot for doing that!
> >>
> >> I wonder about the naming though (and prototype). I doesn't really
> >> validates a mode, but rather makes sure that a given rate is a good
> >> approximation of a pixel clock. So maybe something like
> >> drm_mode_check_pixel_clock?
> > Naming is hard :) I will use drm_mode_check_pixel_clock() for V2.
> >
> > Would it make sense to have the pixel clock requirement as a input
> > parameter? For HDMI it is 0.5% and in my case the LVDS panel 10%.
> >
> > enum drm_mode_status drm_mode_validate_mode(const struct drm_display_mo=
de *mode,
> > 					    unsigned long long rounded_rate, unsigned tolerance)
> > ?
>=20
>=20
> IMO adding the tolerance as input parameter is a good idea.=A0 This
> would useful other than for HDMI pixel clock validation (and LVDS in
> your case).

It depends on the intent. If it's justified, why not. If it's to
workaround another issue, absolutely not. And so, generally speaking, I
don't think it's a good idea.

Maxime

--ivjgiyez6uyhrxcb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ0WVGgAKCRAnX84Zoj2+
dt6vAYD/ha6rSzfdB8Hdtt8QyIin6959mZS2o1Kfzj2g79x6jBpKlT0JtMgi//O3
OUV40OgBfROD6tZDvz9F+STrxg9e7rBW0RrVft6ey02AdwVIWtaNpvVoJEMn/cnG
vhycHMk+wA==
=7JWg
-----END PGP SIGNATURE-----

--ivjgiyez6uyhrxcb--

