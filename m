Return-Path: <linux-kernel+bounces-523868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1937A3DC46
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AF0218940A5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9A31F709E;
	Thu, 20 Feb 2025 14:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmQ940Zh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CBE1C5D50;
	Thu, 20 Feb 2025 14:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740060885; cv=none; b=NmmbsBJb0y25szzWongJfuFQwXpLg0HnrssdHkbgGMd+s9+/5uCrKYYlhuhcBQ1+YXCVIfScIPHVDC1MRQVSZO4c//5OvBEyb0SdRafDAoNb0UpO/7aroxhJjCdObiEFOD6bMnfCnpZXgEBkTQb47o3cADoNcvdIbF4i6YbxqpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740060885; c=relaxed/simple;
	bh=tRvBsp0FoTr3Xw2gpKLC0wmeZR2OTTjOzu4hfQPoswY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KU/7/AaOwrCAgu2PtcBhkfYpjNUzplyFwmMGkOWUdr/eihFGDZF+tO95t1gUv5zdAOK9NOMK1jRWiqWzXn1Y6scowLOUv1vAA3v2rAIXiPlhEBuQWlsHweRQsAgIhjIGf+A5gJNDQrr7uD3JP2bwf+Zc2gWCk01qPf1vRJeOauU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmQ940Zh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A720C4CED1;
	Thu, 20 Feb 2025 14:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740060885;
	bh=tRvBsp0FoTr3Xw2gpKLC0wmeZR2OTTjOzu4hfQPoswY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fmQ940ZhDJ9WVV7a49mjcrFFFKqur53Blpcjd7d/xN9S+aHr1siSXs0wralhMoehc
	 Sag/gfBjLWaxlat4yMYzDBUx0q86F7zZouTPiWZUG5k6V/rvINkX9SUD9PE8sfrqgr
	 4RFBXqkgT9K/O+FSdvaRgRWornmX/JKNmC/NmGtw+XG9yI+4BKUPl4Ludooqv7FiP0
	 imFMpdQ9jyt7Q/oyHu8YuGe0BA1iiG5IV2STqTPl+l2Nvnm84sb79wlaFP8tDycDlG
	 1//u4Lja0VI5G9D7Jx5Xllvvp1ANVTGKA3t3+/h8TDsfibnz2yIyCNw/nBHOsFIWpR
	 tIxCdkLchVaww==
Date: Thu, 20 Feb 2025 14:14:41 +0000
From: Mark Brown <broonie@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Alice Ryhl <aliceryhl@google.com>, lgirdwood@gmail.com,
	sebastian.reichel@collabora.com, sjoerd.simons@collabora.co.uk,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org,
	benno.lossin@proton.me, tmgross@umich.edu, dakr@kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: regulator: add a bare minimum regulator abstraction
Message-ID: <Z7c40fpQVelj20gE@finisterre.sirena.org.uk>
References: <20250219162517.278362-1-daniel.almeida@collabora.com>
 <CAH5fLgiErvnziU-hSCV6djNq7Q56ZfX9gZudmX7+r06hWoX0Tw@mail.gmail.com>
 <E24A1EA3-DC87-4A33-AD93-1E3B307942E8@collabora.com>
 <Z7cbkfvJqkWaSwKR@finisterre.sirena.org.uk>
 <53A50677-CB35-441F-8E58-0FB1EA577C4E@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GQKO3yGFd7H6YRNI"
Content-Disposition: inline
In-Reply-To: <53A50677-CB35-441F-8E58-0FB1EA577C4E@collabora.com>
X-Cookie: Editing is a rewording activity.


--GQKO3yGFd7H6YRNI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 10:48:31AM -0300, Daniel Almeida wrote:
> > On 20 Feb 2025, at 09:09, Mark Brown <broonie@kernel.org> wrote:

> > Having an enabled regulator object depend on a regulator object seems
> > like a goal rather than a problem, surely it's common to need such
> > relationships and there's an idiomatic way to do it?  It seems to be how
> > Rust does mutexes=E2=80=A6

> Not when you need to store both of them at the same time.

> For Mutex<T>, for example, you don=E2=80=99t store both Mutex<T> and Mute=
xGuard<'_,T>
> at the same time. You store a Mutex<T>, and create MutexGuard<'_, T> on t=
he
> stack by locking the Mutex when you need to access T. When MutexGuard goe=
s away,
> the Mutex is automatically unlocked.

> The equivalent behavior for us here would be to enable a regulator on the
> stack, perform some work, and then have this regulator be automatically
> disabled. There would be no way to keep it enabled for a longer period.

Surely this need also exists with other lock types in Rust?  Holding a
semaphore for a long lived series of operations or similar.  It seems
surprising that this isn't a standard pattern.

> >> ```
> >> self.my_regulator.enable() // error, moves out of `&self`
> >> ```

> > Your second block of code doesn't look obviously painful there?

> It is painful in the sense that it won=E2=80=99t even compile.

> This example assumes a different API where EnabledRegulator consumes Regu=
lator
> to exist, instead of keeping an internal reference:

As I mentioned that sounds like something users do want.

> But this is extremely unergonomic because Option<T> is meant for cases wh=
ere we
> may or may not have something, but this is not the case here. We're simply
> abusing its API to make our own Regulator API work.

Are we?  We may or may not have enabled the regulator.

> >> I am sure we can find ways around that, but a simple `bool` here seems=
 to fix this problem.
> >=20
> >> Now you only have to store `Regulator`. If you need another part of yo=
ur code to also keep
> >> the regulator enabled, you store a `Regulator` there and enable that a=
s well. All calls to
> >> enable and disable will be automatically balanced for all instances of=
 `Regulator` by
> >> virtue of the `enabled` bool as well.

> > What you're describing here with creating one Regulator object per
> > enable sounds more like you want it to be an error to do multiple
> > enables on a single regulator.  Instead of reference counting or
> > silently ignoring duplicate enables it should error out on a duplicate
> > enable.

> The problem here isn't necessarily forbiding multiple enables, but figuri=
ng out
> a way to make sure they are balanced in Rust. Let me think this through s=
ome
> more, because I do not have a solution in hand right now.

Right, what I'm saying is that when you talk above about each part of
the code getting another Regulator for the same underlying regulator and
doing it's enable there that sounds like a pattern where each Regulator
has a maximum enable count of one - if it's idiomatic to have different
Regulator objects for different uses then you can say that each use
can have only one enable and needs to resolve it's own concurrency
issues.  The C regulator API is perfectly happy with this (modulo
exclusive regulators which you've not covered here) so if it simplifies
things that should be fine.

Your formatting here is still odd BTW, line lengths are too long (though
less long than on the prior mail) and it looks like there's some '''
formatting rather than indents around code that looks like one of the
structured text formats?

--GQKO3yGFd7H6YRNI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme3ONAACgkQJNaLcl1U
h9BBlwf9FFGzDfZGnuMx586lEWURM6YNmL0aXnBnq/EnMUOchEdBRDcZ+RotXD5T
OT75ha/HOrh5PMFv82jTj7mzZOt6WfgzAEUAP+EUHfx9OX1Iw3YVlFk7LyO9JHpK
yqR4OtScz5aeFNZIMuICNz2M+sdV2VnDoBtcCKGuOeUCULD4BYU8wutnILCHXzXR
U8HkLOIG030BB3t1CAYIxdX69cOADQV9WcbqQav2MNsrkdQi+Xdfw8r65ZqtkGHf
raNmAXHJUk9n0YHhYp9PsPh5JFldYMRBfh91xV+D1oGnTla8DxEijwIDm3iRrKYX
lK2ZsecW6icPU/6SXonl9XTSPU75IQ==
=CDQq
-----END PGP SIGNATURE-----

--GQKO3yGFd7H6YRNI--

