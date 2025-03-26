Return-Path: <linux-kernel+bounces-577558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C72A71EB7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 491D81897521
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1AC253B68;
	Wed, 26 Mar 2025 18:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMVgNDrU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC87253331;
	Wed, 26 Mar 2025 18:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743015420; cv=none; b=WC7f6vHIQQv12xjPG1GTz84qe727SUv3HlkLz3cSXTZqOInexlI8Q1FVVW/oQJG9cJA6UKssgXg/7dwH+1pT/cnarwQKUJa2pjtPbfac68IF2QJqcvDUjYzRY8+8ozcr56WTN99W3hdhvg7e8BmiLrOz8tLVf6DE7h3KN3nocq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743015420; c=relaxed/simple;
	bh=vhJ0Tb5U1AY57SCv1ZXjDfFqvaTeHvCrc/GjSTQFBCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLBNZW2XM8lEUiRCcbLCqj6b4U6dblTkpOa9n6+5Q29GWzZiUjCFJT9qR0EFJa9vpRobVg7wzweQRoIvi1j1P77UlHwm/Ga51xfV+hQgC42N9ZbEriMeDKO5QTyStN2KRJvhqMDkwBEj4nNJXR17bL2SAZBSSMtKDZAOU6JcdNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMVgNDrU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59C9C4CEE2;
	Wed, 26 Mar 2025 18:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743015420;
	bh=vhJ0Tb5U1AY57SCv1ZXjDfFqvaTeHvCrc/GjSTQFBCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sMVgNDrUebCui4P5SprMxEmz62g3VXNMAoaweCwL7DHAJvR6Ehp+/war/Thm7TQPE
	 FTUBeiKsSGAggsDOxRmRdiRX6OK+AP9hHQ9lwvRINE2nmEjRNUdmPYnzH6pL7EOSxc
	 TBrxZA1qvlZJKrCWUJowc00Ddc+iI9fD03fVmxaAUkAaG9WcJ65fk9Qi6WUpb5YNSn
	 fvZUlKlXVpEgI4qLHZvVTyWiAlGlyAzFhsRZiyCVHUhaWdJeGjVyOmpabXh3vo5Nro
	 MJImFUUNd7mgys5vMha7eJ3fv5D0+sohFpvCCzW4n6y+gPuChwgOZR5Ukgelh40fby
	 gqzn8g4dy0E/g==
Date: Wed, 26 Mar 2025 18:56:54 +0000
From: Mark Brown <broonie@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH RESEND v2] rust: regulator: add a bare minimum regulator
 abstraction
Message-ID: <a98eb789-4c49-4607-ad15-76e260888d64@sirena.org.uk>
References: <20250326-topics-tyr-regulator-v2-1-780b0362f70d@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Aq86MDoKVXEMFFxc"
Content-Disposition: inline
In-Reply-To: <20250326-topics-tyr-regulator-v2-1-780b0362f70d@collabora.com>
X-Cookie: To err is humor.


--Aq86MDoKVXEMFFxc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 26, 2025 at 03:39:33PM -0300, Daniel Almeida wrote:

This is flagged as a resend but appears to be the first copy I've
seen...

> Add a bare minimum regulator abstraction to be used by Rust drivers.
> This abstraction adds a small subset of the regulator API, which is
> thought to be sufficient for the drivers we have now.

> +//! Regulators are modeled with two types: [`Regulator`] and
> +//! [`EnabledRegulator`].

It would be helpful to see what the client code actually looks like
here.

> +    /// Enables the regulator.
> +    pub fn enable(self) -> Result<EnabledRegulator> {
> +        // SAFETY: Safe as per the type invariants of `Regulator`.
> +        let res = to_result(unsafe { bindings::regulator_enable(self.inner.as_ptr()) });
> +        res.map(|()| EnabledRegulator { inner: self })
> +    }

I assume this map does soemthing to report errors?

> +impl EnabledRegulator {

> +    /// Disables the regulator.
> +    pub fn disable(self) -> Result<Regulator> {
> +        // Keep the count on `regulator_get()`.
> +        let regulator = ManuallyDrop::new(self);
> +
> +        // SAFETY: Safe as per the type invariants of `Self`.
> +        let res = to_result(unsafe { bindings::regulator_disable(regulator.as_ptr()) });
> +
> +        res.map(|()| Regulator {
> +            inner: regulator.inner.inner,
> +        })
> +    }

This looks like user code could manually call it which feels like asking
for trouble?

> +    /// Sets the voltage for the regulator.
> +    pub fn set_voltage(&self, min_uv: Microvolt, max_uv: Microvolt) -> Result {
> +        // SAFETY: Safe as per the type invariants of `Regulator`.
> +        to_result(unsafe { bindings::regulator_set_voltage(self.as_ptr(), min_uv.0, max_uv.0) })
> +    }

set_voltage() is only implemented for enabled regulators.  It is
reasonable for a driver to want to set the voltage for a regulator prior
to enabling it in order to ensure that the device powers up cleanly,
there may be different requirements for power on from on and idle so the
constraints may not be enough to ensure that a device can power on
cleanly.

> +    /// Gets the current voltage of the regulator.
> +    pub fn get_voltage(&self) -> Result<Microvolt> {
> +        // SAFETY: Safe as per the type invariants of `Regulator`.
> +        let voltage = unsafe { bindings::regulator_get_voltage(self.as_ptr()) };
> +        if voltage < 0 {
> +            Err(Error::from_errno(voltage))
> +        } else {
> +            Ok(Microvolt(voltage))
> +        }
> +    }

Same issue here.

--Aq86MDoKVXEMFFxc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfkTfUACgkQJNaLcl1U
h9AzjAf/cmwK4P3P9KAmsDyhcKj+AURoWPuwFnSzehEDZ5UHKFRMut9EvalKLxPt
CwDomA6rvYUQukQPDGKCcD6u5MqMshnrM3d7VLbg8fAcyhPuVGuoLXjiu58QmiKn
RzqeQ/px3sEuM9BX+sUEpcayLosTpZuTs3uE+j0Z05d11ciPAP+4kBlWPvWvYbmL
TJeR9ZDzWnFZtY+9BL3omRfcnHPGrS8SqFVbC08DFAICwnDhP+WNbO+9PkzZBCiT
WU4uEQGoU30HogiRNU6mKI4LMCrldTdYwRYovjURCfdXtGEMKIDUaEZfnB5ZyQ5v
nscLCShaRINdAne2Dc44GkVUW0d/OQ==
=eZ9O
-----END PGP SIGNATURE-----

--Aq86MDoKVXEMFFxc--

