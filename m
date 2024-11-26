Return-Path: <linux-kernel+bounces-422280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C73309D971C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 13:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB9D5B27FE6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 12:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B2F1CEE80;
	Tue, 26 Nov 2024 12:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnYWEvQ/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36251BD9DF;
	Tue, 26 Nov 2024 12:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732622954; cv=none; b=RK6p5bowEfSEtpgJeALjCvqthcZ5T35lYAUuVGLFPZFZXc8v6/BChKwQS/d32I0M/tCZQCLICp2WyTkgz8mTPXtEvLbuIFGu7lLRtnFzKcDeDX0n1R9h6eHJpfHpEXo12Jm7TtbfoYKnhFbPv8ZUfSfJC4Ga7MGbqFWYsKN3baQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732622954; c=relaxed/simple;
	bh=IVaFBfK34WQcQgwisIpVv9lgOwfqn9UOyfA72WAKaeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqWrROIfQtHYClFFVoPqU1nVBVW3LdnqPQUhZIATs6eoJLy8fAP3VsHEfMYPqGVaY6ubXDJR/1Xm+rpMH52W52u4Hqt/X2AmTBpxs1hdU1zNrZY/j0qEQCZyl6mIwXmpsoXNQxsrglyGLlipFKm1JY6AC1vNE4hQypVXe8htGEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnYWEvQ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BCB1C4CECF;
	Tue, 26 Nov 2024 12:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732622953;
	bh=IVaFBfK34WQcQgwisIpVv9lgOwfqn9UOyfA72WAKaeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HnYWEvQ/zxS4VZ3hf1sfYqZ+X1xXtSp89d5itOmnHz9g7lZNXLZwqk1LfHkCSBJty
	 Ws75UYikRO+C2mvCa9fNbOLT/HMNnLGyQzIFgY+4mLcjifHclxhFaLKjskt1jINajs
	 zytQRdsmjTLrgNaUKmja2yDF4Y2VCaHCYjMcPWXTYKxFIiPzW9RSonub3z6dI0nqF1
	 GfJe8zpsu8ptK5Kgf6aVWpu689PTz3yx5f/d9vC6S/2ymFN+d6hJEyfqk9/FvHAF6D
	 J/uz1w0PWLTjbrQnN80zNwy8eDZdCcIb2rtJQ01c/b/zzUTqcIC6QTIlR2msQK7vN1
	 KL/Re40ursfoA==
Date: Tue, 26 Nov 2024 13:09:10 +0100
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
Message-ID: <20241126-observant-coyote-of-glee-3b94dd@houat>
References: <20241125-dsi-relax-v2-0-9113419f4a40@geanix.com>
 <20241125-dsi-relax-v2-1-9113419f4a40@geanix.com>
 <20241125-gleaming-anteater-of-perfection-42bd2b@houat>
 <bfuj6w6hsbfpdw24th6dl3ugvj45op6jb45gx5ab5pulud7hiz@o2zbn45z3lt4>
 <20241126-refreshing-slick-pig-baebab@houat>
 <zmrcuqiyz5gojhusysy7cytluedslqmfgzuslutqeg65iv7ju6@bggk7qbm6eas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="bl5qc3dhl5qjushr"
Content-Disposition: inline
In-Reply-To: <zmrcuqiyz5gojhusysy7cytluedslqmfgzuslutqeg65iv7ju6@bggk7qbm6eas>


--bl5qc3dhl5qjushr
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/3] drm/modes: introduce drm_mode_validate_mode()
 helper function
MIME-Version: 1.0

On Tue, Nov 26, 2024 at 12:34:26PM +0100, Sean Nyekjaer wrote:
> Hi,
>=20
> On Tue, Nov 26, 2024 at 09:38:55AM +0100, Maxime Ripard wrote:
> > Hi,
> >=20
> > On Tue, Nov 26, 2024 at 08:36:00AM +0100, Sean Nyekjaer wrote:
> > > On Mon, Nov 25, 2024 at 05:00:56PM +0100, Maxime Ripard wrote:
> > > > On Mon, Nov 25, 2024 at 02:49:26PM +0100, Sean Nyekjaer wrote:
> > > > > Check if the required pixel clock is in within .5% range of the
> > > > > desired pixel clock.
> > > > > This will match the requirement for HDMI where a .5% tolerance is=
 allowed.
> > > > >=20
> > > > > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > > > > ---
> > > > >  drivers/gpu/drm/drm_modes.c | 34 +++++++++++++++++++++++++++++++=
+++
> > > > >  include/drm/drm_modes.h     |  2 ++
> > > > >  2 files changed, 36 insertions(+)
> > > > >=20
> > > > > diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_mo=
des.c
> > > > > index 6ba167a3346134072d100af0adbbe9b49e970769..4068b904759bf8050=
2efde6e4d977b297f5d5359 100644
> > > > > --- a/drivers/gpu/drm/drm_modes.c
> > > > > +++ b/drivers/gpu/drm/drm_modes.c
> > > > > @@ -1623,6 +1623,40 @@ bool drm_mode_equal_no_clocks_no_stereo(co=
nst struct drm_display_mode *mode1,
> > > > >  }
> > > > >  EXPORT_SYMBOL(drm_mode_equal_no_clocks_no_stereo);
> > > > > =20
> > > > > +/**
> > > > > + * drm_mode_validate_mode
> > > > > + * @mode: mode to check
> > > > > + * @rounded_rate: output pixel clock
> > > > > + *
> > > > > + * VESA DMT defines a tolerance of 0.5% on the pixel clock, whil=
e the
> > > > > + * CVT spec reuses that tolerance in its examples, so it looks t=
o be a
> > > > > + * good default tolerance for the EDID-based modes. Define it to=
 5 per
> > > > > + * mille to avoid floating point operations.
> > > > > + *
> > > > > + * Returns:
> > > > > + * The mode status
> > > > > + */
> > > > > +enum drm_mode_status drm_mode_validate_mode(const struct drm_dis=
play_mode *mode,
> > > > > +					    unsigned long long rounded_rate)
> > > > > +{
> > > > > +	enum drm_mode_status status;
> > > > > +	unsigned long long rate =3D mode->clock * 1000;
> > > > > +	unsigned long long lowest, highest;
> > > > > +
> > > > > +	lowest =3D rate * (1000 - 5);
> > > > > +	do_div(lowest, 1000);
> > > > > +	if (rounded_rate < lowest)
> > > > > +		return MODE_CLOCK_LOW;
> > > > > +
> > > > > +	highest =3D rate * (1000 + 5);
> > > > > +	do_div(highest, 1000);
> > > > > +	if (rounded_rate > highest)
> > > > > +		return MODE_CLOCK_HIGH;
> > > > > +
> > > > > +	return MODE_OK;
> > > > > +}
> > > > > +EXPORT_SYMBOL(drm_mode_validate_mode);
> > > >=20
> > > > Thanks a lot for doing that!
> > > >=20
> > > > I wonder about the naming though (and prototype). I doesn't really
> > > > validates a mode, but rather makes sure that a given rate is a good
> > > > approximation of a pixel clock. So maybe something like
> > > > drm_mode_check_pixel_clock?
> > >=20
> > > Naming is hard :) I will use drm_mode_check_pixel_clock() for V2.
> > >=20
> > > Would it make sense to have the pixel clock requirement as a input
> > > parameter? For HDMI it is 0.5%
> >=20
> > This code was only used for panels so far. It reuses the same tolerance
> > than HDMI because we couldn't come up with anything better, but it
> > should totally apply to other things.
> >=20
> > > and in my case the LVDS panel 10%.
> >=20
> > 10% is a lot, and I'm not sure we'll want that. The framerate being
> > anywhere between 54 and 66 fps will trip a lot of applications too.
> >=20
> > Why do you need such a big tolerance?
>=20
> I don't need it, it was just from the datasheet for the LVDS panel :)

So you mean the panel accepts a pixel clock within +/- 10%?

That makes sense, but then we should also adjust the mode timings to
match so we still keep 60fps. There's much more to *that* than the
helpers you try to create though, so let's keep it aside for now.

Maxime

--bl5qc3dhl5qjushr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ0W6YgAKCRAnX84Zoj2+
dpXoAYDLeWf70DH69fTHnomK56MfWzFnjFgfHOL2JNGDwN+jsyWwtUS3WtdF0/y2
pknqMxEBf1IBZxjfPUpqweJ/9xN8AsRg6qI+Acufa59QvrHl6wNmv7SdrD5RsgUt
B1PT5dMtYQ==
=sTTD
-----END PGP SIGNATURE-----

--bl5qc3dhl5qjushr--

