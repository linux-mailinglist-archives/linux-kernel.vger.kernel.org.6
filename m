Return-Path: <linux-kernel+bounces-560155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AC2A5FECD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F13F18947F5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0001EBFE2;
	Thu, 13 Mar 2025 18:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7GffAg9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402FB1E51EE;
	Thu, 13 Mar 2025 18:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741889241; cv=none; b=eKLzSBwzBOnixqVOgDPLM5he6lNX1BKb7wQ2tUlW7bREPBMJVJHnlBv3rADG30MvUyb4tsjddw7reFiwnz+plThgLhShjU+JIxU9eD7wIGiRstBYZq+2bAqfepAnmBeLok15zn9xcQxNao9tmKtn+J26ns+7EtqlxUbMsTMhrnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741889241; c=relaxed/simple;
	bh=LBDygyoJCrpua6SXIWwJAmys+ep4tEGhwRmA/f8mNFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fwbdb1xBRNuysL4dMX+0oupO1CieJvaYMt9/jAg+TSqk9cXL9paI8AIF107U+/iE97MA1IyLHm2E61IFvvvrtnBtGb42INlm8/8kPe6/nl78D1lmhT0vX/iTc0zgOqRmvt0yUUyxENP7crc1dU9px2lO8mDlHniztvh3JzGY1fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7GffAg9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC9DC4CEDD;
	Thu, 13 Mar 2025 18:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741889240;
	bh=LBDygyoJCrpua6SXIWwJAmys+ep4tEGhwRmA/f8mNFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A7GffAg9ln+8ddpc3XHF5mYodpGPozRjbZE2ASQA0uPitbkBhZ6NoqIBX9GB4S5NR
	 7m02HDdwu86CTDTDcfvQcIEl7LBHY8tj5kglKlk1QwBDPlEO4zdIMqn5AWjkRBc6ZZ
	 Dh9ZnrD/2xCf3f5rIKeEgC7FnL6/t89pBRfQeyc24JFsMgUFzgDq3agV6BQXvOOKZy
	 fdFMj45V+StM2EofnH+HXziQaHNFi4lmcsMVDYyZ+ia9bNY722mEfZPrAG9VY74UVy
	 47v7JlAjAStpJ5nMClcdngU2nrl6ms2/FBm4IG/MruxvU18pZfzIhNWA4EREAb/VaE
	 YuW7R4GmbJjjQ==
Date: Thu, 13 Mar 2025 19:07:17 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Simona Vetter <simona@ffwll.ch>, Inki Dae <inki.dae@samsung.com>, 
	Jagan Teki <jagan@amarulasolutions.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Daniel Thompson <danielt@kernel.org>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Sam Ravnborg <sam@ravnborg.org>, Boris Brezillon <bbrezillon@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Paul Kocialkowski <contact@paulk.fr>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	=?utf-8?B?SGVydsOp?= Codina <herve.codina@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v6 14/26] drm/bridge: add support for refcounted DRM
 bridges
Message-ID: <20250313-flying-crab-of-diversity-fa1db0@houat>
References: <20250206-hotplug-drm-bridge-v6-0-9d6f2c9c3058@bootlin.com>
 <20250206-hotplug-drm-bridge-v6-14-9d6f2c9c3058@bootlin.com>
 <20250207-ingenious-daffodil-dugong-51be57@houat>
 <20250313125656.70448d09@booty>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aukmwjacyebo6tff"
Content-Disposition: inline
In-Reply-To: <20250313125656.70448d09@booty>


--aukmwjacyebo6tff
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 14/26] drm/bridge: add support for refcounted DRM
 bridges
MIME-Version: 1.0

On Thu, Mar 13, 2025 at 12:56:56PM +0100, Luca Ceresoli wrote:
> Hello Maxime,
>=20
> On Fri, 7 Feb 2025 12:47:51 +0100
> Maxime Ripard <mripard@kernel.org> wrote:
> > On Thu, Feb 06, 2025 at 07:14:29PM +0100, Luca Ceresoli wrote:
> > > DRM bridges are currently considered as a fixed element of a DRM card=
, and
> > > thus their lifetime is assumed to extend for as long as the card
> > > exists. New use cases, such as hot-pluggable hardware with video brid=
ges,
> > > require DRM bridges to be added and removed to a DRM card without tea=
ring
> > > the card down. This is possible for connectors already (used by DP MS=
T), so
> > > add this possibility to DRM bridges as well.
> > >=20
> > > Implementation is based on drm_connector_init() as far as it makes se=
nse,
> > > and differs when it doesn't. A difference is that bridges are not exp=
osed
> > > to userspace, hence struct drm_bridge does not embed a struct
> > > drm_mode_object which would provide the refcount. Instead we add to s=
truct
> > > drm_bridge a refcount field (we don't need other struct drm_mode_obje=
ct
> > > fields here) and instead of using the drm_mode_object_*() functions we
> > > reimplement from those functions the few lines that drm_bridge needs =
for
> > > refcounting.
> > >=20
> > > Also add a new devm_drm_bridge_alloc() macro to allocate a new refcou=
nted
> > > bridge.
> > >=20
> > > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com> =20
> >=20
> > So, a couple of general comments:
> >=20
> > - I've said it a couple of times already, but I really think you're
> >   making it harder than necessary for you here. This (and only this!)
> >   should be the very first series you should be pushing. The rest can
> >   only ever work if that work goes through, and it's already hard enough
> >   as it is. So, split that patch into a series of its own, get that
> >   merged, and then we will be able to deal with panels conversion and
> >   whatever. That's even more true with panels since there's ongoing work
> >   that will make it easier for you too. So the best thing here is
> >   probably to wait.
> >=20
> > - This patch really needs to be split into several patches, something
> >   along the lines of:
> >=20
> >   + Creating devm_drm_bridge_alloc()
> >   + Adding refcounting
> >   + Taking the references in all the needed places
> >   + Converting a bunch of drivers
>=20
> After reading Anusha's "[PATCH RFC 0/2] drm/panel: Refcounted panel
> allocation" [0] I think I need a clarification about the 4 steps you had
> outlined in the above quoted text. Are you suggesting those are four
> _series_, and you'd want to see a series only creating
> devm_drm_bridge_alloc() as a first step, similarly to Anusha's work?
>=20
> That was not my understanding so far, and so I've been working on a
> series containing all 4 items, and it's growing very long due to item 3
> needing to touch many dozen drivers which need to put a bridge (many
> are identical oneliner patches though).

I believe I've clarified it already in Anusha's series, but I think a
reasonable series for *early* work would be the bullet points 1, 2, a
bit of 3 and a bit of 4.

Once the API is agreed upon, 1, 2 and 4 should be in the same series. As
you've pointed out, item 3 can be large, so I don't really mind either
way.

Maxime

--aukmwjacyebo6tff
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZ9Me1QAKCRDj7w1vZxhR
xaKTAPwM/vEJ/q5svZVQpJ0vicaocWo+A9AR6r66r2HSCd2dBQEAmADcvB9+ahJx
H0Gi0+cOjYMHnZOS3C3hF1znR1lh2Qw=
=qBFI
-----END PGP SIGNATURE-----

--aukmwjacyebo6tff--

