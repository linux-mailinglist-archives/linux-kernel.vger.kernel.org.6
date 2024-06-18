Return-Path: <linux-kernel+bounces-219970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F90690DAE5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 19:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD1BEB25BEE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F496145B34;
	Tue, 18 Jun 2024 17:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBnpYzQT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C864596F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 17:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718732715; cv=none; b=tTanBQ32+W8dUIjxE7NjwXYu72lDfm3AH5JDPXrRJZsLWGZfxeToj6FTcIaJRt7Z1h2c+4L6Hc3OkeAZ5yI3qG/ee+YeN+jJpwHN7Jx4ZSst2uOdooa/NSugo8tbh6PFCFNRmLTU7Illjx+COFlTNS2ywXYwxitaiOOHlEzbDW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718732715; c=relaxed/simple;
	bh=PWhESQnnUbrUs6R7jb90wicaqTvDBBcZNjGGOTrdK/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qn2F64/MOhDer0GOyTHOxrBBJvu1wysd1PVJQxe7L6Ov5nY0s1/FUBFhwOd3ztheQEKfxYWw2janpPDyY8HQCsaAz5LJLWOfZEzQHjJk5pBdPhQEKcSMksn9vyIsDjqT07UNrm7jZG+OR5C5V794+4JOx+ZoKEM+UE3aMo6GmTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBnpYzQT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5F4C3277B;
	Tue, 18 Jun 2024 17:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718732715;
	bh=PWhESQnnUbrUs6R7jb90wicaqTvDBBcZNjGGOTrdK/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RBnpYzQTatrs5N97Yywp2wmz+5D5X6T2F++Q1b/ECV2cXh8Yr5MVtXcDu3aDl/js5
	 7bIEBa1vCF0y7ytm1JyYdLfXIfvsDBaSEq2wIJMNeO/S9rfc0NWPDrdluTTpVmgRc5
	 14RupBZD6pdqyfQEHYWr8DLNjqtQpj9NgNE9SCyzky1fg244JT65k1mdr6qrPK5MnY
	 UuSujQiW883zrybwzFu9dTdP2GmiFEOaKR7ROOQ0U60oFR/abWuwpqwcOSdRg/X0fA
	 nnMIONIX4IU1aQ6OdmRoxuu1FWKPLBoOKS2tfxc2QSUNlpk9EwkxzQOhU2KfTqjWan
	 A41RTpd8Z2C4w==
Date: Tue, 18 Jun 2024 18:45:09 +0100
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, Armin Wolf <W_Armin@gmx.de>
Subject: Re: Page select register restrictions in regmap core
Message-ID: <44d4fce5-2ec9-4f62-b7ac-a317c7d843db@sirena.org.uk>
References: <e3e11724-794d-423e-9326-ffe8eed5119c@roeck-us.net>
 <4b22e04f-3142-4a5a-a8d1-366c4b8bbb73@sirena.org.uk>
 <78c93d6b-af0e-4d96-b213-e1e402524361@roeck-us.net>
 <adcd5997-84ee-4c72-aa37-2940afdc83bd@sirena.org.uk>
 <c4a5fb5c-90b4-488b-8875-a0b819e24bcd@roeck-us.net>
 <19893519-20a6-47cf-bb3b-c61dada627bc@sirena.org.uk>
 <e6733f56-014e-4ea0-aaf8-059334f2b27f@roeck-us.net>
 <1a62fc39-355c-4885-b5f6-b66f01a1328a@sirena.org.uk>
 <0287c32d-0b63-4873-9f71-0094a912f8bb@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pcjyDHcK3tJEEptl"
Content-Disposition: inline
In-Reply-To: <0287c32d-0b63-4873-9f71-0094a912f8bb@roeck-us.net>
X-Cookie: If you can read this, you're too close.


--pcjyDHcK3tJEEptl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 18, 2024 at 09:14:56AM -0700, Guenter Roeck wrote:

> Anyway, this may be all irrelevant in respect to regmap support.
> It turns out that at least some i801 controllers don't work with the
> access mechanism used by regmap, or maybe the spd5118 chips don't support
> I2C_FUNC_SMBUS_I2C_BLOCK. I already found that those chips don't support
> auto-incrementing the register address and actually reset the address on byte
> reads (i.e., subsequent calls to i2c_smbus_read_byte() always return the data
> from the first register). Since regmap doesn't have a means for me to say
> "don't use I2C_FUNC_SMBUS_I2C_BLOCK even if the controller supports it",
> I may have to drop regmap support entirely anyway. That would be annoying,
> but right now I have no idea how to work around that problem.

You can set the use_single_read and use_single_write flags in the config
to ensure registers are accessed one at a time, that restriction is
moderately common.

--pcjyDHcK3tJEEptl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZxx6UACgkQJNaLcl1U
h9AMQgf9FYPoSFJN61nNawFftRT3KP9cqZPLMV7IUwPmnCuRfZ2gHMt+CJPGcAtD
Xc0MUoppcHz5ORbNovXBEhcqFnmIyRGKYBrqh4f2E/OpbaNGTDvqcm42jirBtHHX
M6aaUZcUCeZTwcEnf/IMoKKcMwmJxdQm+e1/dxLxHjWTQiLjFPC7DkuyR2JVIiJh
8qA9XICgxJ25fY7arREaV3roddsa1g4CgheW3jXsvuRAhqEWCM5VRyk1hOJye6eH
Kr7JSy2zdhjTT3vreMEeyuC3PAF8KHyc6y3zNqFnuMQz0ttV+8VznPwW84Zi7+Gy
+ZtgBsz1smy/h3+22ODan0MHg9qDTA==
=88ti
-----END PGP SIGNATURE-----

--pcjyDHcK3tJEEptl--

