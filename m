Return-Path: <linux-kernel+bounces-427578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B531D9E02FD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77322287F08
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E91E1FDE2E;
	Mon,  2 Dec 2024 13:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="soDbz1pV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A4DB667;
	Mon,  2 Dec 2024 13:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733145260; cv=none; b=GxttSCxqi3U9wXmGDZhi870F1jpQoNEtojeNY2rCklb3YyYw0SXsBRNLFpGsC8rDppRcGLesSYljtTcoR/F64DptmUWtBjH4oy6V+IKJrYlletAa9ZSEBrpl98rhD8OqxaPL9A09lLJ0EozSw7W3wl5tHX2HlFlH5+jlcOURe/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733145260; c=relaxed/simple;
	bh=Oq8cdROWwi46qvRnOg4xje8ETX94g0KCIdfHBgScQPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRVTPdWR3SqqeWMrUYgilnEK4me3F8LcaOK7TdQW6KtsQ9KM6O47ijmJVgR0t5FDU+L2AY7AnJlP5RHs4uYWmOs/REAU9T6UNq0c70zwvf4CxhnbEWkd1TR/tTP+YI8vqkTXU92y9XUCTTvcCgh4BZ5ilw/74RAPqyyZgG4J3yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=soDbz1pV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3474C4CED1;
	Mon,  2 Dec 2024 13:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733145260;
	bh=Oq8cdROWwi46qvRnOg4xje8ETX94g0KCIdfHBgScQPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=soDbz1pVpVht2Z9g1o6O8zg6zSGO5IAg6n/IWUaiT0bIGTzkkK3NCL0HGsMyXuLE+
	 oljc1vaDyR0ixerFQVrLSzFuNdSCXT84CuI1K8zAmGwOrBEKwDRleMCk5z+DrQGt9+
	 bPo4DYuMYLxWiSP8FqaBcSX3zKzIY4V+O8Mm61My7suTj3HsLKztJ4fr+LB2PmE0Zm
	 6eqkjDBFtaL0WcFQwRcFEoOzNlD9XI8i6/c75DEpSDzzpN+nD8+Zb8nw3WViLsF0mO
	 rJoZaZgi32eLEpa64ndkCtuVulvOmmxa7DV9g6d91WBTEocssnNJOzF9vepeft9uVt
	 lX+K1SNe+GxqQ==
Date: Mon, 2 Dec 2024 13:14:15 +0000
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>
Cc: linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	Mesih Kilinc <mesihkilinc@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v5 1/3] ASoC: sun4i-codec: Add DMA Max Burst field
Message-ID: <fe02df7f-16ae-4128-9af8-7de7f76734bc@sirena.org.uk>
References: <20241102125712.2647325-1-csokas.bence@prolan.hu>
 <20241102125712.2647325-2-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E1U5ubuOCjUxwE98"
Content-Disposition: inline
In-Reply-To: <20241102125712.2647325-2-csokas.bence@prolan.hu>
X-Cookie: So much food


--E1U5ubuOCjUxwE98
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 02, 2024 at 01:57:10PM +0100, Cs=F3k=E1s, Bence wrote:
> From: Mesih Kilinc <mesihkilinc@gmail.com>
>=20
> Allwinner suniv F1C100s has similar DMA engine to sun4i but it has
> smaller max burst size compared to sun4i. Add a quirk field to
> differantitate between them.

This doesn't apply against current code, please check and resend.

--E1U5ubuOCjUxwE98
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdNsqYACgkQJNaLcl1U
h9Cragf7BHf9JlYlAH05EzWdN3AkXOHmdKfOoeDAALsWLpvI9myoKM9zORQsPvYO
R8amQktnMEplFBGcXUAchI2Qf+5Dms8biBBKcO7WcALqPZI5G+foEeeVmWqmrKll
I+UlBOazkSFpHfJzNg9dsC48lhOr4BroFXwI7xr0aMoZOOhZ+OiUOFhZv0F5E5/5
xiUIhofuAK4HoiGkOmkBU9pN9xDD9K3wHoLYnyNAxH+zuZYb28EC9zZo0jQfdIb7
ZtM9N8M/cdIut3eWlm7WTWXWvuI9G+Ce3nvRkKiRXgv/SNMlMeILt1E5kzBOEKFO
q2i7hYDBbqWCbSAnrX/bSb1+9yNLNA==
=DBp8
-----END PGP SIGNATURE-----

--E1U5ubuOCjUxwE98--

