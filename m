Return-Path: <linux-kernel+bounces-396236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 910289BC9CA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50C5D282AF7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE8A1D172E;
	Tue,  5 Nov 2024 09:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="safyjPiD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658E418BC37;
	Tue,  5 Nov 2024 09:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730800686; cv=none; b=AnQhAi5xfQuufK1mODPaF8fgHw6WchskV6Xk3U7MzU4MFIf738guFhRPctga/W6zKSfjY94GtXRnYK62Md7lT6V/JFSNIO43Dr6n0JbYytESKAxLO6aob/cCm4e52mqth8edK+SkhyLRmFYw9MaUstgDOuCPbITdgAxrhOehvak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730800686; c=relaxed/simple;
	bh=+Pfv4OvZxCbNoCRHQ2hN7BLIiGnXEX0iiM+k2iVisqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ce1/+1GXVkAA1PUyohon4bqxUJ2XTOLvAx8V0k9OSFZB2k2KcVl239ulWTwWfybtvVQsoj/v10LJqlAOThfFbGfh/JImQAxvM0y7tEl53zXCOyQmGDe7+uy02cWM26E3ZkvxQBKRT0qo63WxQU7EVXNorvDteyGt2sKGOydkB3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=safyjPiD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745F5C4CECF;
	Tue,  5 Nov 2024 09:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730800685;
	bh=+Pfv4OvZxCbNoCRHQ2hN7BLIiGnXEX0iiM+k2iVisqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=safyjPiDS4oE00HQJaU8DZ2LoY0Ds7BRc7TIrsCl5qNXmax8+nc6kCcZpRfeHRI5N
	 F750gz0MBzFz5LrpEO5pRtaVNt22kCQVuw+2q2rEiz89HiggDoqXvKvB6MvNr2OiSU
	 3kuTqoEV6szkP6+7R1Jpbuoo4hzc1s+xZuX3s/i5ifwMjfcZUxSkwXOaP0aoW5dYST
	 YVlhki4VpZjlRtOZiv6P1e8tyU5qby9XcD3kSCVoev3nQhcNLrHqa+sdA+ZlOQ+lyZ
	 XD7I2dCgOR8epDIaNT2YdLVqvFEYTzBurhpd1sTVPwXTpNpfP+YDyqAG1q4L0ZZ8bl
	 vPilsiKseC9Zg==
Date: Tue, 5 Nov 2024 10:58:02 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/2] drm: bridge: ti-sn65dsi83: Add error recovery
 mechanism
Message-ID: <20241105-juicy-cooperative-squid-76deee@houat>
References: <20241024095539.1637280-1-herve.codina@bootlin.com>
 <20241024095539.1637280-3-herve.codina@bootlin.com>
 <20241027162350.GA15853@pendragon.ideasonboard.com>
 <20241028091331.6f67e29e@bootlin.com>
 <20241028112857.GF24052@pendragon.ideasonboard.com>
 <20241028-nebulous-yellow-dragon-2cfb5f@houat>
 <20241028132858.GE6081@pendragon.ideasonboard.com>
 <20241028-great-charming-flounder-23fc9b@houat>
 <20241028140913.GG6081@pendragon.ideasonboard.com>
 <20241105091503.48f69586@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="vfdw7visqqzoxdex"
Content-Disposition: inline
In-Reply-To: <20241105091503.48f69586@bootlin.com>


--vfdw7visqqzoxdex
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] drm: bridge: ti-sn65dsi83: Add error recovery
 mechanism
MIME-Version: 1.0

On Tue, Nov 05, 2024 at 09:15:03AM +0100, Herve Codina wrote:
> Hi Maxime, Laurent,
>=20
> On Mon, 28 Oct 2024 16:09:13 +0200
> Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:
>=20
> > On Mon, Oct 28, 2024 at 02:55:47PM +0100, Maxime Ripard wrote:
> > > On Mon, Oct 28, 2024 at 03:28:58PM +0200, Laurent Pinchart wrote: =20
> > > > On Mon, Oct 28, 2024 at 01:21:45PM +0100, Maxime Ripard wrote: =20
> > > > > On Mon, Oct 28, 2024 at 01:28:57PM +0200, Laurent Pinchart wrote:=
 =20
> > > > > > On Mon, Oct 28, 2024 at 09:13:31AM +0100, Herve Codina wrote: =
=20
> > > > > > > On Sun, 27 Oct 2024 18:23:50 +0200 Laurent Pinchart wrote:
> > > > > > >=20
> > > > > > > [...] =20
> > > > > > > > > +static int sn65dsi83_reset_pipeline(struct sn65dsi83 *sn=
65dsi83)
> > > > > > > > > +{
> > > > > > > > > +	struct drm_device *dev =3D sn65dsi83->bridge.dev;
> > > > > > > > > +	struct drm_modeset_acquire_ctx ctx;
> > > > > > > > > +	struct drm_atomic_state *state;
> > > > > > > > > +	int err;
> > > > > > > > > +
> > > > > > > > > +	/* Use operation done in drm_atomic_helper_suspend() fo=
llowed by
> > > > > > > > > +	 * operation done in drm_atomic_helper_resume() but wit=
hout releasing
> > > > > > > > > +	 * the lock between suspend()/resume()
> > > > > > > > > +	 */
> > > > > > > > > +
> > > > > > > > > +	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, err);
> > > > > > > > > +
> > > > > > > > > +	state =3D drm_atomic_helper_duplicate_state(dev, &ctx);
> > > > > > > > > +	if (IS_ERR(state)) {
> > > > > > > > > +		err =3D PTR_ERR(state);
> > > > > > > > > +		goto unlock;
> > > > > > > > > +	}
> > > > > > > > > +
> > > > > > > > > +	err =3D drm_atomic_helper_disable_all(dev, &ctx);
> > > > > > > > > +	if (err < 0)
> > > > > > > > > +		goto unlock;
> > > > > > > > > +
> > > > > > > > > +	drm_mode_config_reset(dev);
> > > > > > > > > +
> > > > > > > > > +	err =3D drm_atomic_helper_commit_duplicated_state(state=
, &ctx);   =20
> > > > > > > >=20
> > > > > > > > Committing a full atomic state from a bridge driver in an a=
synchronous
> > > > > > > > way seems quite uncharted territory, and it worries me. It'=
s also a very
> > > > > > > > heavyweight, you disable all outputs here, instead of focus=
sing on the
> > > > > > > > output connected to the bridge. Can you either implement so=
mething more
> > > > > > > > local, resetting the bridge only, or create a core helper t=
o handle this
> > > > > > > > kind of situation, on a per-output basis ? =20
> > > > > > >=20
> > > > > > > A full restart of the bridge (power off/on) is needed and so =
we need to
> > > > > > > redo the initialization sequence. This initialization sequenc=
e has to be
> > > > > > > done with the DSI data lanes (bridge inputs) driven in LP11 s=
tate and so
> > > > > > > without any video stream. Only focussing on bridge outputs wi=
ll not be
> > > > > > > sufficient. That's why I brought the pipeline down and restar=
ted it. =20
> > > > > >=20
> > > > > > Fair point.
> > > > > >  =20
> > > > > > > Of course, I can copy/paste sn65dsi83_reset_pipeline() to a c=
ore helper
> > > > > > > function. Is drm_atomic_helper_reset_all() could be a good ca=
ndidate? =20
> > > > > >=20
> > > > > > The helper should operate on a single output, unrelated outputs=
 should
> > > > > > not be affected. =20
> > > > >=20
> > > > > Also, you don't want to reset anything, you just want the last co=
mmit to
> > > > > be replayed. =20
> > > >=20
> > > > I'm not sure about that. If the last commit is just a page flip, th=
at
> > > > won't help, will it ? =20
> > >=20
> > > The alternative would be that you start anew with a blank state, which
> > > effectively drops every configuration that has been done by userspace.
> > > This is terrible.
> > >=20
> > > And a page flip wouldn't have affected the connector and
> > > connector->state would still be to the last state that affected it, so
> > > it would work. =20
> >=20
> > Ah right, you didn't mean replaying the last commit then, but first
> > disabling the output and then restoring the current state ? That should
> > work.
> >=20
>=20
> Thanks for the feedback.
>=20
> If I understand correctly, I should try to disable the output.
> What is the 'output' exactly, the connector?

At the very least, the encoder, connector and everything in between. And
maybe the CRTC.

> How can I disable it? Can you give me some pointers?

See my mail here:
https://lore.kernel.org/all/20241028-thankful-boar-of-camouflage-3de96c@hou=
at/

> Further more, is disabling the "output" disable the whole path where the
> bridge is located?

Not the whole path, but most of it, yeah.

> I mean, I need to power off/on the bridge and re-init it with its input D=
SI
> lines in LP11.

Right, and that might work with that bridge in particular, but it's
definitely not generic.

Maxime

--vfdw7visqqzoxdex
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZynsJQAKCRAnX84Zoj2+
dhLOAYDt01kViqQ/zoJQY4o0IdYFzdJuwgmOYrpuf5x2TcRmVkT0Re5bBwgxejlW
ClZ3LW0BgKNrr0V98uXOvIW+2fZArO84dQzPE8DkZTbpFqWUhqqZbad/t2sy+Hrc
4F68LJop3g==
=eiWl
-----END PGP SIGNATURE-----

--vfdw7visqqzoxdex--

