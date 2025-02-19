Return-Path: <linux-kernel+bounces-522661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABB2A3CD07
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FBA63B6F57
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE8B25A338;
	Wed, 19 Feb 2025 23:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxncCs9K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105402144C8;
	Wed, 19 Feb 2025 23:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740006353; cv=none; b=UPl5eog6QNJ6zcATXCDPt/VzCNEcPS1MLFgasP2egO9pBRQ1n2RWl4ovhRoO27rjtWs7yud9wGoKKgioOn1n/5Uk0T8DQy7FZoYaknizBKI+FJuWKyNG/FIbNIHjcEMuV3S6jlbEpQ3NL7RYKQ/CS8jPxsVX1a3dPsU2SIy/PxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740006353; c=relaxed/simple;
	bh=DTzPPqe0O4cNq4p4RtACXCPaCu/r7pdVALi3NsTKirk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8yMF/J6HguoZaaCppuVEV1doquBLHRfKzgY/9wB58bZ6TLc4mrNWffDsxxJ9yQpBR2KNhdv8eeZVsQTKBydEoe9VxzWDrttrvExd90GwyzDcfFh3Ko1slfz3ysFfFlZlqSUxh6190g/XpNk6Rx+FGTYGoH0yVwgg9UVxIpdf0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxncCs9K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B942BC4CED1;
	Wed, 19 Feb 2025 23:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740006352;
	bh=DTzPPqe0O4cNq4p4RtACXCPaCu/r7pdVALi3NsTKirk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oxncCs9KZCUT5oDWQN6XL+IYhZCqePwCA4BwRvMg9HCfxJf+ubR67n6gmt2fKwPol
	 C74znfVmqw084fAxE3iIqoP8GZL2Cv++OBmv2eu65VT09r7AJMy5xoD3iiprI7emNl
	 aKEUl/8ZlHfjovILr71IEo8v+W76SX6t3GFTeZ5Dwu46H1Du1qd1dyc6XV1ZG75gRy
	 E0MAOk7ehTWpNYER7CtxZJ1AErrrXO1RV7uIKNG5wt6RBrhvkdGoMqTp5kZfHHdeMh
	 oc7SSqAPC5vv2YTLlmCYNdqmgI2hvkhYDSweNONbrHadjsA1nSvzo1GxFNH1dg2tVa
	 X/sr7t5AJM7aw==
Date: Wed, 19 Feb 2025 23:05:48 +0000
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
Message-ID: <Z7ZjzJ2Rfrt8j0s1@finisterre.sirena.org.uk>
References: <20250219162517.278362-1-daniel.almeida@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5Fr4XABoh4dw3S0W"
Content-Disposition: inline
In-Reply-To: <20250219162517.278362-1-daniel.almeida@collabora.com>
X-Cookie: Editing is a rewording activity.


--5Fr4XABoh4dw3S0W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 19, 2025 at 01:25:16PM -0300, Daniel Almeida wrote:

> Add a bare minimum regulator abstraction to be used by Rust drivers.
> This abstraction adds a small subset of the regulator API, which is
> thought to be sufficient for the drivers we have now.

...

> Note that each instance of [`Regulator`] obtained from
> `Regulator::get()` can only be enabled once. This ensures that the calls
> to enable and disable are perfectly balanced before `regulator_put()` is
> called, as mandated by the C API.

This sounds very wrong, a major use case for consumers is to enable and
disable regulators at runtime.  I would expect that the Rust code might
want to have it's own reference counting (and probably should), but not
being able to disable a regulator after enabling it seems to be a great
big red flag.

> +    /// Enable the regulator.
> +    pub fn enable(&mut self) -> Result {
> +        if self.enabled {
> +            return Ok(());
> +        }

This isn't what the changelog claimed, it's silently ignoring duplicate
attempts to enable and...

> +        // SAFETY: Safe as per the type invariants of `Regulator`.
> +        let res = to_result(unsafe { bindings::regulator_disable(self.inner.as_ptr()) });
> +        if res.is_ok() {
> +            self.enabled = false;
> +        }

...we actually support disabling and reenabling multiple times, it's
just that there's a maximum of one enable at once from the consumer and
we silently ignore duplicated enables and disables.  That's better but
it's asking for trouble.

If you're going to support both enable and disable (and all things
considered you probably should TBH) it would be better to just reference
count the enables like the C code does and then complain about it if
someone tries to free the regulator object without underwinding their
enables, or just possibly just clean them up.  Silently ignoring
duplicate enables or overflowing disables doesn't seem like it plays
well with the safety goals that Rust has, it's asking for bugs - a big
part of the reason the C API does things the way it does is that it will
notice if the enables and disables aren't joined up.  You can easily
wind up with one part of the code disabling the regulator underneath
another part that's still trying to use the hardware and things tend not
to go well when that happens.

Perhaps an enable should be an object that's allocated and carried about
by whatever's holding the reference, I don't know if that plays nicely
with how Rust likes to ensure safety with this stuff?

--5Fr4XABoh4dw3S0W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme2Y8wACgkQJNaLcl1U
h9CT5ggAhRkr4SzbYtDwL6cfX2kD58rUcq69T1ulK8Wj/Q+AIBo5mONaGiR8BcAt
rQJ7y0vJnkMPKkpTTwaUmVJ71A850XNs6Qt5ovadztkwzGAdOowpEd1A93u0hVKZ
HQLBKYF/hxvttJeAparl8NniOqHBQr9VT2UQDNKo4dOjxxKCONxJAcnh/LPxWMPL
zIJGd3nqEluz+DJNJpj0lFa5PSnaUj1Am/okVJC5FBxT4GAitG02cZcRvkIo999/
9mMwaLnurr1L2ep1ozT3YVzD1EJcl8ouTP+DG/pV90/eZBgO1OHP1fP2kreqEuIg
Sl+7cxA8hX/qGgrHbrFtWUGqRbPFRg==
=xR9t
-----END PGP SIGNATURE-----

--5Fr4XABoh4dw3S0W--

