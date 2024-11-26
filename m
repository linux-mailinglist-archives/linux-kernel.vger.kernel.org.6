Return-Path: <linux-kernel+bounces-422017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D0D9D936B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 09:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47338B224E5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 08:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6E719F410;
	Tue, 26 Nov 2024 08:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSGeqoOn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CAE18E37B;
	Tue, 26 Nov 2024 08:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732610338; cv=none; b=O2zYVU/TGvEg+oQHipMIfBQVAYT1qT7o6y6ozCL2O3yAB26R1WokkkybQttsJASxLPiE7enq5nk8V/W+hzGlxGK1Vkd23PawqmcLNmKFt9IFudf6CVaB/xaFXXTr/MIOLMJWD0EVNuSDksWpJ6lKnhBAAGIRH4KG1PgJ0+K6rL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732610338; c=relaxed/simple;
	bh=np3gVh2vdVMzwJbdelK/6cS6+cbSugtEMQAtU2/XSG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmoxvPIQBD5oLO3sidcqFmSKF64elChmcydoclSgZKB8rqWVSsQG+1C9WS3ncNxM0uXUkT3UL45ZT2NT9/6xgkJ/AqIw+jaumDTG4gr/f5zz+iSFwhQOeNEptdIMOZ3zRrfwM+Zs3EV/U/rYO7p5vjoE6pa/E8nsEPYmIn7J7Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSGeqoOn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1860C4CED2;
	Tue, 26 Nov 2024 08:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732610338;
	bh=np3gVh2vdVMzwJbdelK/6cS6+cbSugtEMQAtU2/XSG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nSGeqoOn1S3dD4mvA4bOozPQKUShhg1mWWMrX9sdkefP4KreZ5C12Lvw13dCIlF8o
	 dBax9EngjiuB2f3zEbgw3yXwgrIPUef8ZT1q0Un11iqeJx3tcTJtqEURMF15ZZNqUP
	 CWmTLCHLhGw5sJVGMd4MjASQsdDnT6i1Kj3qRj0ehClBz0uRhDRmZZbriJjx9ul450
	 YVp5bDU5Y2piARlIPhRDCulRvmgGCPLExHoKIUfWzkoK4lVFRBNsJTf9OmHlKCTUVz
	 XTM+V5WBnj0mx8jrGJkSazCeedawve01dDdUTxnkdM2zemIF222ICHxzmoeNZ85EjD
	 cUg84GF5JgSKg==
Date: Tue, 26 Nov 2024 09:38:55 +0100
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
Message-ID: <20241126-refreshing-slick-pig-baebab@houat>
References: <20241125-dsi-relax-v2-0-9113419f4a40@geanix.com>
 <20241125-dsi-relax-v2-1-9113419f4a40@geanix.com>
 <20241125-gleaming-anteater-of-perfection-42bd2b@houat>
 <bfuj6w6hsbfpdw24th6dl3ugvj45op6jb45gx5ab5pulud7hiz@o2zbn45z3lt4>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="lhbvkcbp3c3gosel"
Content-Disposition: inline
In-Reply-To: <bfuj6w6hsbfpdw24th6dl3ugvj45op6jb45gx5ab5pulud7hiz@o2zbn45z3lt4>


--lhbvkcbp3c3gosel
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/3] drm/modes: introduce drm_mode_validate_mode()
 helper function
MIME-Version: 1.0

Hi,

On Tue, Nov 26, 2024 at 08:36:00AM +0100, Sean Nyekjaer wrote:
> On Mon, Nov 25, 2024 at 05:00:56PM +0100, Maxime Ripard wrote:
> > On Mon, Nov 25, 2024 at 02:49:26PM +0100, Sean Nyekjaer wrote:
> > > Check if the required pixel clock is in within .5% range of the
> > > desired pixel clock.
> > > This will match the requirement for HDMI where a .5% tolerance is all=
owed.
> > >=20
> > > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > > ---
> > >  drivers/gpu/drm/drm_modes.c | 34 ++++++++++++++++++++++++++++++++++
> > >  include/drm/drm_modes.h     |  2 ++
> > >  2 files changed, 36 insertions(+)
> > >=20
> > > diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
> > > index 6ba167a3346134072d100af0adbbe9b49e970769..4068b904759bf80502efd=
e6e4d977b297f5d5359 100644
> > > --- a/drivers/gpu/drm/drm_modes.c
> > > +++ b/drivers/gpu/drm/drm_modes.c
> > > @@ -1623,6 +1623,40 @@ bool drm_mode_equal_no_clocks_no_stereo(const =
struct drm_display_mode *mode1,
> > >  }
> > >  EXPORT_SYMBOL(drm_mode_equal_no_clocks_no_stereo);
> > > =20
> > > +/**
> > > + * drm_mode_validate_mode
> > > + * @mode: mode to check
> > > + * @rounded_rate: output pixel clock
> > > + *
> > > + * VESA DMT defines a tolerance of 0.5% on the pixel clock, while the
> > > + * CVT spec reuses that tolerance in its examples, so it looks to be=
 a
> > > + * good default tolerance for the EDID-based modes. Define it to 5 p=
er
> > > + * mille to avoid floating point operations.
> > > + *
> > > + * Returns:
> > > + * The mode status
> > > + */
> > > +enum drm_mode_status drm_mode_validate_mode(const struct drm_display=
_mode *mode,
> > > +					    unsigned long long rounded_rate)
> > > +{
> > > +	enum drm_mode_status status;
> > > +	unsigned long long rate =3D mode->clock * 1000;
> > > +	unsigned long long lowest, highest;
> > > +
> > > +	lowest =3D rate * (1000 - 5);
> > > +	do_div(lowest, 1000);
> > > +	if (rounded_rate < lowest)
> > > +		return MODE_CLOCK_LOW;
> > > +
> > > +	highest =3D rate * (1000 + 5);
> > > +	do_div(highest, 1000);
> > > +	if (rounded_rate > highest)
> > > +		return MODE_CLOCK_HIGH;
> > > +
> > > +	return MODE_OK;
> > > +}
> > > +EXPORT_SYMBOL(drm_mode_validate_mode);
> >=20
> > Thanks a lot for doing that!
> >=20
> > I wonder about the naming though (and prototype). I doesn't really
> > validates a mode, but rather makes sure that a given rate is a good
> > approximation of a pixel clock. So maybe something like
> > drm_mode_check_pixel_clock?
>=20
> Naming is hard :) I will use drm_mode_check_pixel_clock() for V2.
>=20
> Would it make sense to have the pixel clock requirement as a input
> parameter? For HDMI it is 0.5%

This code was only used for panels so far. It reuses the same tolerance
than HDMI because we couldn't come up with anything better, but it
should totally apply to other things.

> and in my case the LVDS panel 10%.

10% is a lot, and I'm not sure we'll want that. The framerate being
anywhere between 54 and 66 fps will trip a lot of applications too.

Why do you need such a big tolerance?

Maxime

--lhbvkcbp3c3gosel
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ0WJGgAKCRAnX84Zoj2+
dgyFAYDpVbD0+B1OXcBahhvUgiMgYgY8W64szTv09wv/4HohtzWS1pIp3K2R38QQ
wOL5h3QBf0hLFnVFqmeGdio6nM2Us2phuUAbokXf6Z7YXiUN8CVJPQw1vBRsPHG9
zYgs3yNCQA==
=bqF0
-----END PGP SIGNATURE-----

--lhbvkcbp3c3gosel--

