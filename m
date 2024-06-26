Return-Path: <linux-kernel+bounces-231374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D954919534
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 21:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D4D41C220F2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 19:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB22190491;
	Wed, 26 Jun 2024 19:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfBtbXZr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDBB14F134;
	Wed, 26 Jun 2024 19:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719428704; cv=none; b=hQPmi8XAL0vhQfpp0H+K2rv3iZwI9QuPgV1JTt0APQJhvWi5TEqkKH2TjCtem4b8+7cAY3GgI8XL0vybXU2Unm66yOZ2WEiz6juSJUJ8jeCF+lQTRNjhBkopTCnnLvpzJeGEdhti+TV5E5oYFUQHXueFyCaJOvI0k5CATkcTih0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719428704; c=relaxed/simple;
	bh=bWzjNCjmmPmpw45GxfdFgpAMeYdRjrSECxcv1hgHaOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ahi46QCHkqxkPmGAPBygyh218sBgspukZLPzyLPiaY1oLav3GjqO5aBASHWMJCMy03YaVsZQkZKTcsvMMW4k+ytLubqoKg/I1IB6+wcGULmx+uA5nhLX9ZP3ttNBQNfd10R+2tcoAh2VQKXHF9r5uy/nsjTc7a1L/szzkxUaoj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfBtbXZr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2BCC116B1;
	Wed, 26 Jun 2024 19:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719428704;
	bh=bWzjNCjmmPmpw45GxfdFgpAMeYdRjrSECxcv1hgHaOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UfBtbXZrz6Gu+dElulr03dTkrIGgI3XSAFojGeEH/hCrFwKACQNZ7qeE3DkNmWx5g
	 9pHqV49MzXV4k7+YR84FGaeBFzNoLtf1xyqL/udqkJHDAiz0iy5hlkoPWrjsE7XiSt
	 8EJL+7VyyC1UZlMnIogwOKKjAwhl4KHA9Zu0re9mYnBLM5thrREXsZRNKmVzkFQpzt
	 uLdi8ZSB7nKIp/ikdYH7uurEdnfxYuSWjbqiv3t18YJ3XMk17hbcEBmFSAshnJGCx0
	 B9T7cq8bE92JbMWcebFSX0UdvjiBWqr31ZwDBwcCjFMPvL0Yq4SEwc2b0762O4/M7c
	 Qpt6lwm0YalmA==
Date: Wed, 26 Jun 2024 20:04:58 +0100
From: Mark Brown <broonie@kernel.org>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Marcus Cooper <codekipper@gmail.com>,
	=?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
	linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ASoC: sunxi: sun4i-i2s: fix LRCLK polarity in i2s
 mode
Message-ID: <d614f04e-3609-48e3-bd30-9e57c69cd94d@sirena.org.uk>
References: <20240529140658.180966-2-matteomartelli3@gmail.com>
 <20240529140658.180966-3-matteomartelli3@gmail.com>
 <20240606-savvy-wallaby-of-champagne-d4a50e@houat>
 <6662bf1b61bbc_2f51737023@njaxe.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="brRwIUwfo+xty56n"
Content-Disposition: inline
In-Reply-To: <6662bf1b61bbc_2f51737023@njaxe.notmuch>
X-Cookie: Results vary by individual.


--brRwIUwfo+xty56n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 07, 2024 at 10:04:43AM +0200, Matteo Martelli wrote:
> Maxime Ripard wrote:
> > > -	/*
> > > -	 * DAI clock polarity
> > > -	 *
> > > -	 * The setup for LRCK contradicts the datasheet, but under a
> > > -	 * scope it's clear that the LRCK polarity is reversed
> > > -	 * compared to the expected polarity on the bus.
> > > -	 */
> >=20
> > I think we should keep that comment somewhere.
>=20
> I think that keeping that comment would be very misleading since the LRCLK
> setup would not contradict the datasheet anymore [1][2].
>=20
> Also, do you recall any details about the mentioned scope test setup? Was=
 i2s
> mode tested in that occasion? It would help clarify the situation.
>=20
> Could anyone verify this patch against H3/H6 SoCs?

Any news on any of this?

--brRwIUwfo+xty56n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ8ZloACgkQJNaLcl1U
h9AW3Qf/S8w6LdQE07HH9i/c1/AtUnm7Oe9sG1q6TztFJXGX8wvFBYA3+t1896Hd
LkFkm9asqUvCjn9z+D5/GfQhfc7xixh5T806AuouKiiihsAmWqyc6NicztYHgC2u
1PzTWb49EyFiW74xItn2pIExpzeBAaE8SA1Y7cRPoNmE95ru82zu4K+kROV2usut
XkX/NnybgjzIZ2WAwyyGuu0+pIBs539YXSdB/s2OUBrmn7gKjOBaD8cvX70NMP0Y
iP23wh1FaDV7JE1Gm27DX5E0u8ibDRL2cjmSP2x7NswG0B7rCv3gtRe0Z0NozuTJ
3zfr6um33uVy8saT12jEtBW4oPeIww==
=J+fn
-----END PGP SIGNATURE-----

--brRwIUwfo+xty56n--

