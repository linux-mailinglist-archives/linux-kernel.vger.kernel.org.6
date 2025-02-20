Return-Path: <linux-kernel+bounces-523640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A322A3D98C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC98917AB01
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE641F4E21;
	Thu, 20 Feb 2025 12:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+zerApZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27E91BD01F;
	Thu, 20 Feb 2025 12:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740053397; cv=none; b=Cgna1GmRKHh8s7ZJrHYaQQTqycJorDw1tCf5xx89I+b2yL4eZL3tjmfbX/rl/E6Lfs4y5EOHv9F/clgLUOpSxlW1JI1VxGyvTe8vEasFYm+6QJKb9B3D6q2uWPgKsinYJ7xm5VsXzDjkU9LlfGzLAhBWClmOCWeFMzCAJNz2c6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740053397; c=relaxed/simple;
	bh=DHc2ZnDpd/ndTACySFf2mux2IOTN4Zj1k7w/Smad8/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDg/nw0wSuc2LS4sM/OMW5V4x6C6ArBWMUgJhk1WaVZiDQ9dUgyjY+VUqF7LGVpPJbdPubynNYfAaZM0rlfstBlz+qIDdT15eEN5czmzKtLD62H2P9owq3i5ldYXCcFpkf2r7Gho0yhUsao+gevtoMM+bJMaEREr8RYwmQtR1KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+zerApZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F69C4CED1;
	Thu, 20 Feb 2025 12:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740053396;
	bh=DHc2ZnDpd/ndTACySFf2mux2IOTN4Zj1k7w/Smad8/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V+zerApZQ1+17V1NcaXibO4W4REKKZb9sW93j7dOI2AwGNYNfugtP+rh71FItJZ+T
	 e5XjPfBo5IuqNdY/PTlpzRnbG9v449OW73PKg6KNaQa/f4z2+bl9gjpT5qXqM84Dm9
	 DrnxVLyUe0SZAxLwIB29aepC+PrAMN8CjaTOKsR0mOUrb866HFVzgE4DEfm/K8RdvT
	 9prvVAar2GXS5CVZxOEyhWSy3wAXSiqzmOAKjrlyJKcsaqxSAfNw4eFhzp29Pd1zoa
	 jQL1fsVkDd5+lHiY08LET+sBpTkBj0sqWR8UGAR4iR4raZ19Wzyw585ktOO2aED9F/
	 v4saGWvpTHNWg==
Date: Thu, 20 Feb 2025 12:09:53 +0000
From: Mark Brown <broonie@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Alice Ryhl <aliceryhl@google.com>, lgirdwood@gmail.com,
	sebastian.reichel@collabora.com, sjoerd.simons@collabora.co.uk,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org,
	benno.lossin@proton.me, tmgross@umich.edu, dakr@kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: regulator: add a bare minimum regulator abstraction
Message-ID: <Z7cbkfvJqkWaSwKR@finisterre.sirena.org.uk>
References: <20250219162517.278362-1-daniel.almeida@collabora.com>
 <CAH5fLgiErvnziU-hSCV6djNq7Q56ZfX9gZudmX7+r06hWoX0Tw@mail.gmail.com>
 <E24A1EA3-DC87-4A33-AD93-1E3B307942E8@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g+TnyzgYxnjAXCAf"
Content-Disposition: inline
In-Reply-To: <E24A1EA3-DC87-4A33-AD93-1E3B307942E8@collabora.com>
X-Cookie: Take your Senator to lunch this week.


--g+TnyzgYxnjAXCAf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 02:10:24PM -0300, Daniel Almeida wrote:

> This means that now, `EnabledRegulator` has to depend on `Regulator` some=
how to ensure
> a proper drop order. Otherwise you might have an enabled regulator for wh=
ich you don=E2=80=99t own
> the refcount. Furthermore, if Regulator drops while EnabledRegulator is a=
live, you get a splat.

Having an enabled regulator object depend on a regulator object seems
like a goal rather than a problem, surely it's common to need such
relationships and there's an idiomatic way to do it?  It seems to be how
Rust does mutexes...=20

> In a driver, you now have to store both Regulator - for the refcount - an=
d EnabledRegulator
> - as a way to tell the system you need that regulator to be active.

That's true, unless you can make a type of enable that just fully takes
ownership of the regulator (which TBH people want, people really want a
devm_regulator_get_enable() C API which just gets and holds an enabled
regulator for the simple case where you don't actually ever manage the
power).  It's possible there's a need to split simple and complex
consumer APIs in Rust?

> If EnabledRegulator is a guard type, this doesn=E2=80=99t work, as it cre=
ates a self-reference - on top
> of being extremely clunky.
>=20
> You can then have EnabledRegulator consume Regulator, but this assumes th=
at the regulator
> will be on all the time, which is not true. A simple pattern of

I don't understand the self reference thing?

> ```
> regulator_enable()
> do_fancy_stuff()
> regulator_disable()
> ```

> Becomes a pain when one type consumes the other:
>=20
> ```
> self.my_regulator.enable() // error, moves out of `&self`
> ```=20

Your second block of code doesn't look obviously painful there?

> I am sure we can find ways around that, but a simple `bool` here seems to=
 fix this problem.

> Now you only have to store `Regulator`. If you need another part of your =
code to also keep
> the regulator enabled, you store a `Regulator` there and enable that as w=
ell. All calls to
> enable and disable will be automatically balanced for all instances of `R=
egulator` by
> virtue of the `enabled` bool as well.

What you're describing here with creating one Regulator object per
enable sounds more like you want it to be an error to do multiple
enables on a single regulator.  Instead of reference counting or
silently ignoring duplicate enables it should error out on a duplicate
enable.

--g+TnyzgYxnjAXCAf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme3G5AACgkQJNaLcl1U
h9BN9Qf+J7Y9KQpmRVSzK1x1M74LYSURyUvqicD7HFcGtdn/COrS/9goQ0SCkgLI
XQeYmCvdEzKMQXF2w7fHQjLDyYg/ZuusoaGvSR0F7MrMA2qHwXI7LIRFHynBR4MG
3jmys8vmyOH2DUhRpTb2fZmZ+sIFCZzSqncwJhdyuwRTJQKSZF/r58a4jrh8/gsH
jTWKTOyhhDpBrcyRQqhKqf8adDSJC0zZQIxPEghNpSwTKDlvj+eIckZ7aXgfAJrX
BeIOFCy1TnAzmXEhTZdi6bYGuZ2bT0Pb0swRPjSQQzs5U2f0dARPZFiBIYbs5U33
8ltcH1Cn/kfAv+qah87sQufRUYMVhA==
=1CFV
-----END PGP SIGNATURE-----

--g+TnyzgYxnjAXCAf--

