Return-Path: <linux-kernel+bounces-389258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCDF9B6AAB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF10D1C20891
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B459921892B;
	Wed, 30 Oct 2024 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="A3rfMvaQ"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2D0218329
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 17:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730308048; cv=none; b=fy77johqyf044EZ/mHdsvUULv5g382APQ9SoMSHQgDQ8QLodnD24clR1wZutQ7tSXeGlWAVQOoPmtJHpQX1vekn3odVS8VNf4FdDlFo+X0tZML9FNomCITjtRNpkRg2DKw1jqEE58aI98lLH4/0RwAQv4PfM25oj9hhbRql0Ezc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730308048; c=relaxed/simple;
	bh=LmRmAFj5mgmFzsBLiV06WnmPeH9nLkqqJJdInzflSDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTvC2o0DP2aKmeVp804m/eDRamzHaoMTEcOwrVnYXgJnh2qpTjUh+Z88Ta35R4duAg+NfoTXBJRNZO9oVOGFi8al31vwfUqFBIu8a1d9ZYEwpUTuwUYX0t5dLd/7k7wVKgTKd8sZX1Kj/7ssp60SzrtwIBGo54G9grl+p+ENRUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=A3rfMvaQ; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=LmRm
	AFj5mgmFzsBLiV06WnmPeH9nLkqqJJdInzflSDs=; b=A3rfMvaQ2+u7bA0v/QDz
	tSLmhEPUAorgL4h8injD2nj0rfK2/wpRjAH73QlKw+guLbuMnn86oEJZiGcHx4Q2
	WhxC9ofGvXcJL9KhdddTHKbL8ZuG4VBS90KZwiMtgsjfY+M4Tl8lSYSBTWm/cIGW
	83gn8Z5AsjuvABl+Y7Wavdpv/upxdtBye4Djo5uExq2LeJ8nfHwtgmv0UsWjVwUK
	GmTtnP/LUmdaQ9n2M1UlZQvEj3XjzmRYWYb/oWPntCiWJWuCjg8AGaqqegg661Qj
	nHL2HlAGCL6gN43cVgQRxRVhpL/yjXdo5vSoEqQTPlbmiUH0wkr/hAoZCxkDVG5N
	Lg==
Received: (qmail 3141883 invoked from network); 30 Oct 2024 17:59:58 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Oct 2024 17:59:58 +0100
X-UD-Smtp-Session: l3s3148p1@+93AobQlwMrAwtcC
Date: Wed, 30 Oct 2024 18:59:57 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mary Strodl <mstrodl@csh.rit.edu>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 2/2] gpio: sloppy-logic-analyzer: Check for error code
 from devm_mutex_init() call
Message-ID: <ZyJmDS7WK9U4u-rS@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mary Strodl <mstrodl@csh.rit.edu>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
References: <20241030153201.2078266-1-andriy.shevchenko@linux.intel.com>
 <20241030153201.2078266-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Oe26aHq0LrIkEV49"
Content-Disposition: inline
In-Reply-To: <20241030153201.2078266-3-andriy.shevchenko@linux.intel.com>


--Oe26aHq0LrIkEV49
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 05:30:27PM +0200, Andy Shevchenko wrote:
> Even if it's not critical, the avoidance of checking the error code
> from devm_mutex_init() call today diminishes the point of using devm
> variant of it. Tomorrow it may even leak something. Add the missed
> check.
>=20
> Fixes: 7828b7bbbf20 ("gpio: add sloppy logic analyzer using polling")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks!


--Oe26aHq0LrIkEV49
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmciZgkACgkQFA3kzBSg
KbZsmBAAoA4XEpQgfOvezEW5F/Q4i3W6cmN5BGHKi+oZHFM2xQ/Apr1vGE6ygkzc
HoZF1QyiqYoszdWU3f0m1pOCQS5iKNyNiIzrbb2C1/Sr/m4AFuGcQZ659i2PIsea
bAJzZOPILRttr93EwJz5Gz4oM+8R0KJs477j5DsQJERcH0BWGkO/TAEoEHGx3wHl
dGaLk+LbYZuOEnNX3unc2VZ5VDoAlUu/ykKexkKCWHojI90zSxID4UGxakbAa6XD
/9t5KRaDk2qlExgaL1TdAAEDqGxpR9s2157SqsQEcvNqioiTLbkGpBlRoiyW/wHq
Oux9Gj6YOCmsGV5ZSXX4M+SMP8XnMSHzParL2Y5QYaOAMfGm3p025P1CPL+irDxn
A5JgWwcrEqM7Nlrt+JPl/IZr8KVFzAnT0NgZNg3FyzPu4C+65I4xFhsQ9324UOTj
33vyKwwxbPS8obIvQieqzmi69yJDLTUr4NzN5dLRQv7dvyHlcUT/Wzpp6O+E2Phi
i4FIdVFIInWtP1tO3wdd6I5aKbwTrUp/Q9a1GGSMEJfeEP3645BiJlWHP+WczqGf
hxeLRPq7AMDRKNk6aRukTMdg5KA+2SjXyoVYK4+QDO5Grv0XYpk6L1E1zdHwZq5k
OZZVkjT4/40jYehfSarHyC5YvlIKTSTXJMvbMQudqjke98XLoWI=
=O1PK
-----END PGP SIGNATURE-----

--Oe26aHq0LrIkEV49--

