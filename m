Return-Path: <linux-kernel+bounces-252686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2569316CA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A358AB212E7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01BF18EA9D;
	Mon, 15 Jul 2024 14:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BlYtjQfa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C622D18EFD6;
	Mon, 15 Jul 2024 14:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721053795; cv=none; b=HTB71mVLDLyk72WiD+uxcl+SoX1VBpoiKm6FmpHs17CDTI8vnWf4o6C/vjGDIXCv91V4EDufoXBj+Ao2j5zX5590V0XX0/R+CpXPgNa//AvL7ljLzULC9f8/k1+LEpYKdSNpTEDZWadcHH3L47AlCoaj1P63Id16CAShJH/QU60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721053795; c=relaxed/simple;
	bh=nxq0+TBcPx//9WPCN3IZTTvsyzqcjAq5NWop8L7I0wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JknbjSl1ekFBv/6ogPIRsgzDv6xNX4lTPce0MAnZYwwXAEUspGW4RSWkghXZf2sOozLXweGDu7kVAOTphiY0n+9XNkePFpvrkyaMaKwt6D5/mFEkwb8JabjgJyOfnwQzNpA5g6jxCyMyn6mhQHG/cKi38g/Ayxi9Bpct6sFSItU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BlYtjQfa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75F5C32782;
	Mon, 15 Jul 2024 14:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721053795;
	bh=nxq0+TBcPx//9WPCN3IZTTvsyzqcjAq5NWop8L7I0wk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BlYtjQfabuJ16UBKJUdA8PBluyZ66h0gMgx79ICqTbn57T0szbKi+gfw2TLQjOlCq
	 dvM2UZhQJX5u3qBJsvpFXFQQtd/JYPo5pPy3cg/aEgIax5yJKbgMVaGoL2p/pQrllz
	 lIraA1AXKivn4VC4mvfDTm/klLDw+VrOn/a2h+4zpzjqdF6T7zYtNHCBlN6H+EyyAj
	 hKqeZomt8Q0zHwMsImLFeHbNGADNObDT4SzXqxiQSkX+ILAG5FStKoygg/QbmlU5xu
	 qDoWBwBkFQWN31aByS9aGF+ONJULUNzYTXCaRi3yevPtZBGuUK2JAWPfbGd+d4GeSI
	 LlI1XtEpUGDQw==
Date: Mon, 15 Jul 2024 16:29:52 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Marcus Cooper <codekipper@gmail.com>, =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>, 
	linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ASoC: sunxi: sun4i-i2s: fix LRCLK polarity in i2s
 mode
Message-ID: <20240715-rigorous-bipedal-sloth-c8df1b@houat>
References: <20240529140658.180966-2-matteomartelli3@gmail.com>
 <20240529140658.180966-3-matteomartelli3@gmail.com>
 <20240606-savvy-wallaby-of-champagne-d4a50e@houat>
 <6662bf1b61bbc_2f51737023@njaxe.notmuch>
 <20240702-copperhead-of-unusual-intensity-7f43a8@houat>
 <668419fb8ef9f_2a76d370f1@njaxe.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="ggci2m6r2jctn4b5"
Content-Disposition: inline
In-Reply-To: <668419fb8ef9f_2a76d370f1@njaxe.notmuch>


--ggci2m6r2jctn4b5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2024 at 05:17:15PM GMT, Matteo Martelli wrote:
> Maxime Ripard wrote:
> > On Fri, Jun 07, 2024 at 10:04:43AM GMT, Matteo Martelli wrote:
> > > Maxime Ripard wrote:
> > > > > -	/*
> > > > > -	 * DAI clock polarity
> > > > > -	 *
> > > > > -	 * The setup for LRCK contradicts the datasheet, but under a
> > > > > -	 * scope it's clear that the LRCK polarity is reversed
> > > > > -	 * compared to the expected polarity on the bus.
> > > > > -	 */
> > > >=20
> > > > I think we should keep that comment somewhere.
> > >=20
> > > I think that keeping that comment would be very misleading since the =
LRCLK
> > > setup would not contradict the datasheet anymore [1][2].
> > >
> > > Also, do you recall any details about the mentioned scope test setup?=
 Was i2s
> > > mode tested in that occasion? It would help clarify the situation.
> >=20
> > I can't remember if I tested i2s, I think I did though. But most of the
> > work was done on either TDM or DSP modes, and I remember very clearly
> > that the LRCK polarity was inverted compared to what Allwinner document=
s.
> >=20
> > So the doc was, at best, misleading for these formats and we should keep
> > the comments.
>=20
> Thanks for the reply Maxime, would you be able to point out the Allwinner
> document part that is (or was) misleading? The current datasheets (see li=
nks
> [1][2]) look correct, the current driver setup for TDM and DSP modes resp=
ects
> those datasheets and it's not "reversed compared to the expected polarity=
 on
> the bus" as the comment states.=20

I clearly remember having to debug something there, but I don't remember
much more, sorry.

I guess if you have tested on the H3 I2S, TDM and DSP and it all works
as expected with your changes, go ahead and ignore my comment then.

> Also I didn't find any related errata in their changelog.=20

Yeah... Allwinner doesn't do errata.

> Could it be possible that during those mentioned tests you
> were still referring to the datasheets of other SoCs like A10 for
> instance? Or maybe that the misleading information was in another
> document rather than the main datasheets? If that's the case, would
> you still think that the comment should be kept as it is?

Possibly, or an older version of the datasheet, I really can't remember.

Maxime

--ggci2m6r2jctn4b5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZpUyVwAKCRAnX84Zoj2+
dpRhAX9rVoOPV7K1v5rwd1iUrmkhEORAmr0cfgUZNxyR8/cSEim1hcX57CmTWGSm
e0tAKXABfjp2ifpTGlhcNzUrMX3C4k1OAzdhLXmS0m3xq1NAhBIUXvnDrtB5j+78
1ezliQOBSg==
=t7qy
-----END PGP SIGNATURE-----

--ggci2m6r2jctn4b5--

