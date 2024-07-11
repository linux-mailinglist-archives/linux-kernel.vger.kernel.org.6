Return-Path: <linux-kernel+bounces-249119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 519E392E72A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8442D1C2029D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9C414C5AF;
	Thu, 11 Jul 2024 11:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbHe96H5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D1315990E;
	Thu, 11 Jul 2024 11:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720697966; cv=none; b=INTeACxupoSGka98Z6mO0oYs7axSR9+f6f5wJzdmOIN6EqDbomjWRHGeVm8tfZBcBF6h9r8gatLQ+XMtWJo9m+mqNKm4J2+dp3kLNIwshG+kMINCy4MaD49SUXoWbhbUGKCaac2PYvk8MElFTsELvQKJA0SVVkTgN9C8+nqKNTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720697966; c=relaxed/simple;
	bh=P2UKQXxkiVk7LZSgzqxmGZ9XP7NujTD9p8IuQKO02Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNRHkhi+pRu1mI6k21+YvOshOcPcGlKkfa+7OPFAkKV7UpU3RjgKM89euyUhzeKdSKmrPDguPS6uPbJBIaRfmgWaqJZPJ0c+C5AtKWqvMSuqPv3h9sOvm2RZ0XQPIKIuQHaLfSPLfaVRX2sI+Lg6U0YnX2WEMBOydzIXljcyM44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbHe96H5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8948CC4AF07;
	Thu, 11 Jul 2024 11:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720697966;
	bh=P2UKQXxkiVk7LZSgzqxmGZ9XP7NujTD9p8IuQKO02Gw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LbHe96H5cGkZxPGlnY8ylL9Svdz6YhC64nwk2NiRxNVYQxqRDsa8DQxbwEUfoT6XN
	 ww1GsHoADiPGc/7Wv0SOW8mVVINZ/bBgjwrC7SgpuLUNQyDjDuT7q6AYd7aCrifGbA
	 1l4RO6HNG1XYESfUrx9B/bnE+mczwnhzWDSkXBTqlIAcmxLasTD4J0/F28Mfo/H8DK
	 3GDcL71PmBXh6S8/+aEg6zVuzzY8U0GLTPI05fYfqkkakg8bsF2KkPwssf1FxxnklL
	 b3OHcnGYlFhf2r9dYBZRO1hqMU197hxw4+7X0nGZyZmHeuXnZsfcNPKxdSbaX0GIbJ
	 0RDmF6SqbrWYQ==
Date: Thu, 11 Jul 2024 12:39:21 +0100
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] regmap: Implement regmap_multi_reg_read()
Message-ID: <c3d37e4f-68f6-4d6e-a9f6-94db61fbd756@sirena.org.uk>
References: <20240710015622.1960522-1-linux@roeck-us.net>
 <Zo8yECqjvhw6dNGy@finisterre.sirena.org.uk>
 <ddb24ce3-a8a7-4535-9d8f-9368440d502e@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Dz7xD1tUbyXus4hE"
Content-Disposition: inline
In-Reply-To: <ddb24ce3-a8a7-4535-9d8f-9368440d502e@roeck-us.net>
X-Cookie: Individualists unite!


--Dz7xD1tUbyXus4hE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 10, 2024 at 08:33:42PM -0700, Guenter Roeck wrote:
> On 7/10/24 18:14, Mark Brown wrote:

> > It would be nice to have KUnit coverage for the new function too.

> Agreed, makes sense. I'll have a look and see what I can come up with.
> I assume you'd also like to have a unit test for regmap_multi_reg_write() ?

Yes, indeed - thanks for sending that.  In general it'd be nice to fill
out the whole API and things like formatting as well.

--Dz7xD1tUbyXus4hE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaPxGgACgkQJNaLcl1U
h9DjPAf/R9KkKBLY32W6QcfEsaFFRPHls4Qe/WkJbe5DZ88dKJbac5bEHIjdclkG
be5D8mvRBax4b431fM3yVHuLUaZh0uiAHkIF058Qf65ocSUJCuGSnFfkW3363zKX
+X2mIIPPcEz9HRSyOLzwbyHbMmxIiaSu94t4s6SKEFxH0kqKpLMbAJZYiDquvKye
/CGbGvc/dzVkNwDWGY/p/5JlAUVl7eKCNsXzmrdjkk5S1n7/W0pa998RmbEkwBv5
fAyruAsTjSeCobPon2yQ6cxoZd6uDrOvW+fEddsEzIbrExdl5kAqdZFGhH5+hv1B
ZMh7mjIWD/tdJ+cIa4rydmixF8PKqw==
=Oaf3
-----END PGP SIGNATURE-----

--Dz7xD1tUbyXus4hE--

