Return-Path: <linux-kernel+bounces-237877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0A2923F41
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FBBE1C21F9C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65871B4C52;
	Tue,  2 Jul 2024 13:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/IjLzG6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE011B47AC;
	Tue,  2 Jul 2024 13:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719927743; cv=none; b=Qu4UZgEIr1l8zoMgpAz7Yn+JbQQOb6XGOBzsTi/LaZA1zb18A6xByGmwaDNcjal/ShLVLG9TwdxaX0rUQc+ziigttEYFmkFgSPl9XsBykO+9mvALxsU67F/Gn2Mw44AUnVlifC8gHkHxUkR9gvd4Dj2bffR3fMvqcZC84gpUhjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719927743; c=relaxed/simple;
	bh=viWMyuSLPQcT8QQfWmFKUsU7APOiO0XeiC0Q+5KtxT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYh6UTVHxdexVdQh5O7qAkz2/0XrfgEE4ZxHufOhlhqYGa58OkzkaqjZOFMudaMQ7GV3/NzDoFKhA23Y+i+7FtdwIh3NCa7u3MwlzqCaCwpM5xsQ8RKq/ms+L2JSQ6Nve88bZFByFkkEaGHWG43bI3nI+8CJu+42FJl3vv07wJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/IjLzG6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 162A0C116B1;
	Tue,  2 Jul 2024 13:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719927742;
	bh=viWMyuSLPQcT8QQfWmFKUsU7APOiO0XeiC0Q+5KtxT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W/IjLzG68TM7rttv/YSFDQ9jMMSBPjODnfFodJoeJ5QyC4HQ6T3fjQnPpmdMwgFVJ
	 eZT8d2HZY4+j7w7knSNvIgOCH3a5IySSXvxW0AXQx1cXkD1imNArNtL23XjsXVgi/+
	 sSPShsEL/2h1Q8NRhqNFYrg1AvDQJVCWUhDNfJMX+EixW+zr97l+NGIoXXZnjK0pMq
	 +qxgC4UE3uNSY3XTkR24D+PUHigiyKt98Jxja9aeD8njc7B0IsEkhsZMXg2usEhLze
	 vuHzs/177SP+CKODtMQQaYtXdR+yJSGJTTcR6TtUWq93kCUNLZQEXLNB6wHqzLg+hg
	 rx1eF23fe7tHA==
Date: Tue, 2 Jul 2024 15:42:18 +0200
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
Message-ID: <20240702-copperhead-of-unusual-intensity-7f43a8@houat>
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
	protocol="application/pgp-signature"; boundary="6xqnwajdqjhkbqhg"
Content-Disposition: inline
In-Reply-To: <6662bf1b61bbc_2f51737023@njaxe.notmuch>


--6xqnwajdqjhkbqhg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 07, 2024 at 10:04:43AM GMT, Matteo Martelli wrote:
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
>
> Also, do you recall any details about the mentioned scope test setup? Was=
 i2s
> mode tested in that occasion? It would help clarify the situation.

I can't remember if I tested i2s, I think I did though. But most of the
work was done on either TDM or DSP modes, and I remember very clearly
that the LRCK polarity was inverted compared to what Allwinner documents.

So the doc was, at best, misleading for these formats and we should keep
the comments.

Maxime

--6xqnwajdqjhkbqhg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZoQDugAKCRDj7w1vZxhR
xVvRAPwJR6VO4KkT6NwzPIFmZLjnVJpctsukmqnb9lXstjDJGAEA1SlfjzCl4zUa
deqV6VITIqV5aIAAfkYTA5gnQ9iasAI=
=K/Rr
-----END PGP SIGNATURE-----

--6xqnwajdqjhkbqhg--

