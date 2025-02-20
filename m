Return-Path: <linux-kernel+bounces-522824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F554A3CED0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E23F189B234
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 01:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0099719004A;
	Thu, 20 Feb 2025 01:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8VZJLad"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB377082E;
	Thu, 20 Feb 2025 01:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740015428; cv=none; b=FLQt2okhceJt/YYL4E7IRxKHvRt0R811fKz1BTFjDxDQ/91W3y4RuZzD0ETTv904YeU0XFuO+tjBUcwFsUBq/uzTzBoxkqppkLh5UeJeieRCd4C+rHZHSitxDyekswQZEXxvqPtCee0s+ayn/vE8Z/kVxERuKpljtNUFTN6x6/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740015428; c=relaxed/simple;
	bh=VPcuvEk0iI9GFGUTnNy8HOu+Mf7ZlLyBHNfRr5sIbiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cckhU+g9ABMZGpeUVmNtitpN6K9NOWLnJg7uoXw3M8LWwK2xV6aERoS01rk/foeYe+kOTdWOGgt7kQpwLk6Br3/0pshaPmdHI2MTbKMZrYNESymxzRAhkkAGCGIIb+6HK68naJmNnBZisYOmih6XMTSmBimojje96xbwzmQIric=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8VZJLad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A41AC4CED1;
	Thu, 20 Feb 2025 01:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740015427;
	bh=VPcuvEk0iI9GFGUTnNy8HOu+Mf7ZlLyBHNfRr5sIbiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O8VZJLad05CT2+FTceie6emBPRSqFMwJas7oNKKqlWX/Zp4eXdiRxRq965AzTwY2q
	 0JHRI+6BVSVs5T4u2yipe88OdS345a8Mf7AnNobMPTGntHdWW5ja1pOnGEbw12Lpbc
	 iLZb14aCx4Re0nuHNVsgT8NhnajegQ6mILOmLqNm656z8cYw9XuMXCLX7S0f7egedT
	 NnJTotYDmuHe0MTlzpuOS5oSsBUqXHq0c1oFoSMf9yQa4r1aX2aBrRYNNSmibDOcc/
	 pbAIlI4GQQ4MBSFtAysoa2gD30tFCpotIaqHTPR0jYaTOhc5Z9iM4qtk2lhv4G+SEI
	 eI+H0rCVSc0lg==
Date: Thu, 20 Feb 2025 01:37:04 +0000
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
Message-ID: <Z7aHQBYXZ5jlGRte@finisterre.sirena.org.uk>
References: <20250219162517.278362-1-daniel.almeida@collabora.com>
 <Z7ZjzJ2Rfrt8j0s1@finisterre.sirena.org.uk>
 <5E354BB7-9CD5-4615-8EAF-98B9F498713A@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jlR5tKu8Pp0dmxDQ"
Content-Disposition: inline
In-Reply-To: <5E354BB7-9CD5-4615-8EAF-98B9F498713A@collabora.com>
X-Cookie: Editing is a rewording activity.


--jlR5tKu8Pp0dmxDQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 08:35:47PM -0300, Daniel Almeida wrote:
> > On 19 Feb 2025, at 20:05, Mark Brown <broonie@kernel.org> wrote:

> > If you're going to support both enable and disable (and all things
> > considered you probably should TBH) it would be better to just reference
> > count the enables like the C code does and then complain about it if
> > someone tries to free the regulator object without underwinding their
> > enables, or just possibly just clean them up.  Silently ignoring
> > duplicate enables or overflowing disables doesn't seem like it plays
> > well with the safety goals that Rust has, it's asking for bugs - a big
> > part of the reason the C API does things the way it does is that it will
> > notice if the enables and disables aren't joined up.  You can easily
> > wind up with one part of the code disabling the regulator underneath
> > another part that's still trying to use the hardware and things tend not
> > to go well when that happens.

> I thought about that, something like:

> ```
>   fn drop(&mut self) {
>=20

> I asked for a few opinions privately and was told that =E2=80=9Cif the C =
API prefers not to do that
> why should you?=E2=80=9D

Well, the C API also doesn't ignore either enable or disable attempts...
the theory is that if the consumer messed up it's safer to not power the
hardware off suddenly when something might not have been cleaned up.
The general approach the API takes is to only take actions it's been
explicitly asked to do, that way we're not hard coding anything that
causes trouble for consumers and since we need constraints to enable any
action that gets taken we're less likely to have default behaviour
causing hardware damage somehow.  If we think we've lost track of the
reference counting we just scream about it but don't try to take
corrective action.

> > Perhaps an enable should be an object that's allocated and carried about
> > by whatever's holding the reference, I don't know if that plays nicely
> > with how Rust likes to ensure safety with this stuff?

> As I said, this doesn=E2=80=99t work very well, unless someone corrects m=
y reasoning on a

I don't think I saw the previous mail?

> previous email. Having a single type =E2=80=9CRegulator=E2=80=9D is proba=
bly much saner than =E2=80=9CRegulator=E2=80=9D
> and =E2=80=9CEnabledRegulator=E2=80=9D.

OK.  It's a bit of a shame that there's not an idiomatic way to help
with the reference counting here.

--jlR5tKu8Pp0dmxDQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme2hz0ACgkQJNaLcl1U
h9CrrAf/YBzZZMHNWVte3uV3zeSAnj3ol+1bKYACfLySI1EEAhZXtVQFEN8ujKc2
bVvaAP9ngSwZqtOy1JUQ1ZlWKvY9rsq3oplUFaTlx/PNXoiX1Dp2L5kekA2iHhy6
jisn+brT3/u0LY3N4f72RJc7JM9iKdhmTFTuwyI8WQHV0bPxJljGthb6+sEgTXen
PN1EtSIXm7vJiCccPy2m+gzbi9muwcRdxN9cyDIBaUtkRMy/FmX5NZ9oB1lNB7UP
xrPE3tVoKxwGqV0ppAUraG2PSKYcImZ7KUcGuasfagqnRZD4eFHhyq/hVKyMgyCn
nqexGLhGlkimzl/xTR3pNsIzyiCnSw==
=jJ1N
-----END PGP SIGNATURE-----

--jlR5tKu8Pp0dmxDQ--

