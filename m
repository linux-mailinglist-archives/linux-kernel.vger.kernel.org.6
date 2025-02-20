Return-Path: <linux-kernel+bounces-523618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A693A3D948
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A80D518936D8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D01C1F4636;
	Thu, 20 Feb 2025 11:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+Eg4qtP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D391F4611;
	Thu, 20 Feb 2025 11:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740052714; cv=none; b=Q3+FJG/jNG6aQCeEjaIOnVHYrAsx8NR74THBXhGKhxlhwgdKBJ2d3vOy9+unkYcI21qowD09OpFzxhENkl1WXVmWmzSFd/MYfFnpO9d5Rjt+rbapOwW+yKV8D4/hSrkvgKsBDSvTvdd9tYKnV+YR/bzYt/4mpytxLuM2CZf36JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740052714; c=relaxed/simple;
	bh=A+pBhXsrKiI9TzxWiBBxgW90MXEZJeSooMsZ82URFgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZNISu/edVKUleaVhPhE81scEHXhWs7LUbLdw1hwna08gd4bSbBqDEQX4bPfu3XwGxg2ncMCduW2ahgrRfVNtDSmSGKozT7M7NrK/z4ANVDLT+2RK/aXjP6PzHkIl5FDuqwsbIXB3kCAYzHkxZXbvqRQC3UKCObUKQXyAwnUR3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+Eg4qtP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF124C4CED1;
	Thu, 20 Feb 2025 11:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740052714;
	bh=A+pBhXsrKiI9TzxWiBBxgW90MXEZJeSooMsZ82URFgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C+Eg4qtPsHQ5CG4gDt/hFRt8KMk4god0R4jHpg75FFWW+qA/494OYgshurJZwzlmi
	 olcU0yZ5v56KQrSairG2fTltH8TsdWeAQEVaBcbUfEQ2K1pplEP8VBXheL2kKzGEgZ
	 zOj5tIxJNhjG4bXB9w02Hlnb/+kSBcvPXGtaCcxmlb95Culto072shL5Y/7J9fiOjh
	 I47RXujevAXU4whJMDuKuEmDobbED+KEyoqqAXtaxJ04MqH5PzUUdJe7XHmxFW7qT2
	 THCXaZcC69mXH2Zqy1H3077s8JXP0q+CmIA8pi1UuUE/UgpWlmnyhuRM2Y6k2bHMOA
	 J33mhRqvGId7A==
Date: Thu, 20 Feb 2025 11:58:30 +0000
From: Mark Brown <broonie@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: lgirdwood@gmail.com, sebastian.reichel@collabora.com,
	sjoerd.simons@collabora.co.uk, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, a.hindborg@kernel.org,
	benno.lossin@proton.me, aliceryhl@google.com, tmgross@umich.edu,
	dakr@kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: regulator: add a bare minimum regulator abstraction
Message-ID: <Z7cY5pr8DW92zt46@finisterre.sirena.org.uk>
References: <20250219162517.278362-1-daniel.almeida@collabora.com>
 <Z7ZjzJ2Rfrt8j0s1@finisterre.sirena.org.uk>
 <5E354BB7-9CD5-4615-8EAF-98B9F498713A@collabora.com>
 <Z7aHQBYXZ5jlGRte@finisterre.sirena.org.uk>
 <7099F7DD-C806-4DA9-A7C5-595428289497@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wUCTRlCbFOMPt/KK"
Content-Disposition: inline
In-Reply-To: <7099F7DD-C806-4DA9-A7C5-595428289497@collabora.com>
X-Cookie: Editing is a rewording activity.


--wUCTRlCbFOMPt/KK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 06:42:25AM -0300, Daniel Almeida wrote:

> >> I asked for a few opinions privately and was told that =E2=80=9Cif the=
 C API prefers not to do that
> >> why should you?=E2=80=9D

> > Well, the C API also doesn't ignore either enable or disable attempts...
> > the theory is that if the consumer messed up it's safer to not power the
> > hardware off suddenly when something might not have been cleaned up.
> > The general approach the API takes is to only take actions it's been
> > explicitly asked to do, that way we're not hard coding anything that
> > causes trouble for consumers and since we need constraints to enable any
> > action that gets taken we're less likely to have default behaviour
> > causing hardware damage somehow.  If we think we've lost track of the
> > reference counting we just scream about it but don't try to take
> > corrective action.

> So, are you OK with this approach? i.e.:

> > ```
> >  fn drop(&mut self) {
> >=20
> >    while self.enabled_count > 0 {
> >=20
> >            if let Err(e) =3D self.disable() {
> >              break;
> >            }
> >        }
> >  }
> > ```

> Where `enable()` increments self.enable_count and `disable()` decrements =
it.

It's not ideal since it'll just silently clean up any enables that were
done, ideally the Rust bindings would prevent leaks of enables like they
are intended to prevent memory leaks and this wouldn't come up at all.
This seems less safe than the C API since we don't even detect any
possible isues, we'll just silently hide leaks.

> >>> Perhaps an enable should be an object that's allocated and carried ab=
out
> >>> by whatever's holding the reference, I don't know if that plays nicely
> >>> with how Rust likes to ensure safety with this stuff?

> >> As I said, this doesn=E2=80=99t work very well, unless someone correct=
s my reasoning on a

> > I don't think I saw the previous mail?

> You didn=E2=80=99t get this?

> https://lore.kernel.org/rust-for-linux/Z7aHQBYXZ5jlGRte@finisterre.sirena=
=2Eorg.uk/T/#m9348ad4fdc056d7f6d0bfec6529d4c80afdcd335

Don't think so (but the copy I'm getting from the archive has mangled
formatting with weird line lengths, it's possible that it got hit by
spam filtering or I discarded it manually as junk due to the
formatting).  I'm not sure I understand the concerns raised there, but
it's possible Rust is less helpful for this stuff than I had imagined,
or that the whole thing with layering Rust on top of the C code is
getting in the way of whatever idioms fully native Rust code would use
to avoid issues.  I'll reply there...

--wUCTRlCbFOMPt/KK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme3GOQACgkQJNaLcl1U
h9DDAAf9EJB96D8QCHIfDsl/Zc8SC6ndACVxKFtDUqI5Q+n6keKZu9mh+zNK3IiZ
1G5gFr2qP7UxS9VvsCgDDd7nBlV2PLS2yZ+I0G3FVKx8JxE7kEjLS0wdqai4CZcC
czqA36rejT9AIXxDcNRwf32y1afLPpKi8millOe3hfFj1dfFr65nnl6ePMSGMlC3
KegiGWpRUm+7CHJvGCfbOitZcTQkpa5FPj04lBJh/QVUtVcB+rnz4+jHN73JfhJc
HGf48VdzjCsolBrclYfGgM1ROJF2RhukTgnDhpOg5HGZG3YJGiIPVTwL6LTr1PfV
t5fbMX6dXseP4qiiwIPcET8etl4tzw==
=38Mv
-----END PGP SIGNATURE-----

--wUCTRlCbFOMPt/KK--

