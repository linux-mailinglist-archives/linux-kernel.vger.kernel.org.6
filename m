Return-Path: <linux-kernel+bounces-182054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 855418C85AE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 13:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 840341C22F9F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 11:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD0F3E48F;
	Fri, 17 May 2024 11:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsT8kEiu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6743CF74
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 11:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715945291; cv=none; b=SfFvq1nKa4pNdP9QCPKAR0cIKWhYlYepaoCGHhWz45viTjWDmnUGc1nepgQrL11FXfwnI1D1ylRMGtN7IVeJFDY8KbJwdvS8XCwqLq9LtdyorIDDAs/tulPGBu7fRgwm8Iye46oM0k61wIdzfmzhQjBh/GFtU6uQWIaB6MQEwng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715945291; c=relaxed/simple;
	bh=0mXDSrSJCDndoAiFbLR5LRn7Epq80zlD2jMKGw9YPz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YLu2Mq7bZzwuYlV0tR8kEtd8kcJNeH1EDuo3MFCY6O7nMR9BNosraOIsgQHOnvl/U/3oChNVxos00mPfZAVwFVvD4zU7kWQ0MNS3MBn3p7Z/Ik1LfBhmlK5Y7IOrv7M0b4QceP1GnDmLyL/BCOmzww831heWSdV5yiiDlBksInM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsT8kEiu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A926AC2BD10;
	Fri, 17 May 2024 11:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715945290;
	bh=0mXDSrSJCDndoAiFbLR5LRn7Epq80zlD2jMKGw9YPz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OsT8kEiuSR3HYoe/IlFQg8gfBjBLsYPi5xhNgc13kTXXDv0Jnk1iopxe6EGTp3UdZ
	 dfGvSlHc7ErOjTKjBL9FnKktzQZAEK5eFhxtZv6Bl8hIHs9IA0Z0Wy8lLqs7EVYRa1
	 ZFLi8tcmkrR9s0qdyWGCXxZn9x3hmuwFHNMNKbGA3jCmOPbDuIq4L21nZRg1fLBUPC
	 ZMuLg/6VDiklIsNM0AgAIqdUvoFDgsV0Zq0ZYpRtAIpQeQp8O8MkS2S9mipe8qOUqB
	 1pmF0um+hHzNjjhlOaK+q1XatAQzCKv6Ff3nVxViDfagu3IdL/tYMlBNJqz/UGlhWb
	 jcCx45vIFWVTA==
Date: Fri, 17 May 2024 12:28:06 +0100
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>,
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 04/11] regmap: kunit: Run sparse cache tests at non-zero
 register addresses
Message-ID: <5cccbf9e-d706-441a-87f9-578975f8e81a@sirena.org.uk>
References: <20240408144600.230848-1-rf@opensource.cirrus.com>
 <20240408144600.230848-5-rf@opensource.cirrus.com>
 <5c1daddb-d8b3-420a-839f-208e0a6e168b@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SZGm3XT+YV/fSDfU"
Content-Disposition: inline
In-Reply-To: <5c1daddb-d8b3-420a-839f-208e0a6e168b@roeck-us.net>
X-Cookie: Function reject.


--SZGm3XT+YV/fSDfU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 12:53:34PM -0700, Guenter Roeck wrote:

>=20
> With this patch in mainline, I get lots of errors such as
>=20
> [   23.494308] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> [   23.496391] BUG kmalloc-64 (Tainted: G                 N): kmalloc Red=
zone overwritten
>=20
> Bisect log and first of many backtraces attached for reference.

What's your kernel architecture and config for this - it looks like
there's some sanitiser enabled?

--SZGm3XT+YV/fSDfU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZHP0UACgkQJNaLcl1U
h9AM7wf/Zuw27uRSAL2MWdrl3tLFhAfyPV/xTuPHant528BVufACC6+m/jJaL3bu
LLbaNv8TjfdGFWZAPcN26opeYo1LqePzsIvO7jPHaR/XFKpHCp5t7yR9yp232Pzm
XN0FeBiUfgvpU9X9TatCTCzix7JbuY2RIvfERNdZxw1+mK9rSjo+UaQdiiSHKsN5
j7ITNBnTO/Pgv8U8tiG7KAyhneGrl9FfmE8UywSPmG4JctJVhRWoqbmVjNfd5m49
NXrNhRA+qD3bdnjZQISiEHfM/zarm1I5/upgJfufoM9o6Qmx4OGGwVxLO7TCctar
rxbDzGV0hkkTksLwiMEOAVVsrXg/9g==
=I5Fa
-----END PGP SIGNATURE-----

--SZGm3XT+YV/fSDfU--

