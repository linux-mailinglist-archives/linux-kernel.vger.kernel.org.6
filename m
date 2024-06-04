Return-Path: <linux-kernel+bounces-200208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1FF8FACFB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35001284BBB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 08:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4039A1419A9;
	Tue,  4 Jun 2024 08:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="K+hP4aPF"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7EE1384B1
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 08:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717488008; cv=none; b=hRZT2nnaDllM93+CDj44mIqOS1tK3WZG5TA8jTe9TJP9sZtJBAmJCEwxEhioiOgSFY0Xkpcf5mZS6QF3gxSK7iEoVZUWn2xBWX2huBs10ZS8IEXYZRvPfbKgo2VdvErxcTOy8ziG/LeAuXfqDtTvfea1LpOpjVJi1vL++bz7Rgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717488008; c=relaxed/simple;
	bh=2FwahE66ZXIwspaC/JRsBaR02QEmRxDVlA8r/UgHIEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhdqR0H6HAVO7gfBJ0BgXyJiVUPRtPe79epyHQT4szwbMGuPL+/qlaNmo6vuiTs4WOazQuIYdt48kohJt1+q0Ik5ddZuK7y9RCJUF/xaNwqrZ622zEtdar27VDx66eT9nNd0pjMckJ4vk6p/safEmS0bhBYrM96kdEl69lvWw4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=K+hP4aPF; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=2Fwa
	hE66ZXIwspaC/JRsBaR02QEmRxDVlA8r/UgHIEo=; b=K+hP4aPFlCRH0h5xXLEU
	/9kHCA592KKdKg2kYjOpCrj2AGOjxuI4HbrrWY65K8A21X4TsoEzevkLMrIjB72W
	spvmeNCHEThU1Rv+8ov/Xw2KWy3c5V+V1M2YjUBkwl+L3OmU6844eIIYs/YGdCj9
	GqG9VW6VFpUe0gAjGdTv7sXWUOsX7gQ03PwDMiHNmqT+2YbgN3i7PenBiygglTVP
	OjKhK4Awt5pZpTz55ic35oXH7SjG399geGItpv1GWADy+lf9P13r/IDJxRjOw2tN
	6dVyQ8LDjbn7EPHEBtFHGxl313eAl4t4kulHNSkXgcPie33QQiLCU9fjGLt+x2h1
	HQ==
Received: (qmail 2214748 invoked from network); 4 Jun 2024 10:00:05 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Jun 2024 10:00:05 +0200
X-UD-Smtp-Session: l3s3148p1@Lttt1gsaVscgAwDPXzLGAH1eNELjOc3g
Date: Tue, 4 Jun 2024 10:00:04 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, Hans Hu <hanshu@zhaoxin.com>, 
	Arnd Bergmann <arnd@arndb.de>, Wentong Wu <wentong.wu@intel.com>, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] i2c: viai2c: turn common code into a proper module
Message-ID: <bi3lwgeh5egvd4g6aspwvefibk3cviwuzinvgkmnwy4f3bvua4@nf5a6w77cr7v>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Arnd Bergmann <arnd@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, Hans Hu <hanshu@zhaoxin.com>, 
	Arnd Bergmann <arnd@arndb.de>, Wentong Wu <wentong.wu@intel.com>, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240528120710.3433792-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hzrqra7phcm27hy4"
Content-Disposition: inline
In-Reply-To: <20240528120710.3433792-1-arnd@kernel.org>


--hzrqra7phcm27hy4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 02:06:30PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The i2c-viai2c-common.c file is used by two drivers, but is not a proper
> abstraction and can get linked into both modules in the same configuratio=
n,
> which results in a warning:
>=20
> scripts/Makefile.build:236: drivers/i2c/busses/Makefile: i2c-viai2c-commo=
n.o is added to multiple modules: i2c-wmt i2c-zhaoxin
>=20
> The other problems with this include the incorrect use of a __weak functi=
on
> when both are built-in, and the fact that the "common" module is sprinked
> with 'if (i2c->plat =3D=3D ...)' checks that have knowledge about the dif=
ferences
> between the drivers using it.
>=20
> Avoid the link time warning by making the common driver a proper module
> with MODULE_LICENCE()/MODULE_AUTHOR() tags, and remove the __weak function
> by slightly rearranging the code.
>=20
> This adds a little more duplication between the two main drivers, but
> those versions get more readable in the process.
>=20
> Fixes: a06b80e83011 ("i2c: add zhaoxin i2c controller driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Andi, I am tempted to include this in my for-current pull request this
week. Are you okay with this or do you want to review it more closely?


--hzrqra7phcm27hy4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmZeyYQACgkQFA3kzBSg
KbYxrhAAjGLtahAsSRKZR0KV4UQzJCnGB4IHLqh5jGCTvKMNxQxfdvTSUg23MCi/
4MmtcLezzjSmCbd6Z6Apk4za6PxzLRyeSw+rpp7imXh6RSII2QkWAodG7wyU7jir
szjfA58A2pHdCIFcGcNziygwVx+W8kNcn2GRVNMn2NJP2EuyXS+hkMvYh6CdjOVK
VYwkh5jeRjlUt8c2jQ5uMufQvsFF0tuYI87awEiRUSSUU1TjrJDdMfo3+L4wTusi
9y+fNVGfaA4Bsd1bdB3Ex7K/tUCkqh+1QsStMWKiLEr/kfmvTtG7p3wsFZOvU+Rd
dvJ5jYJ34j2aN8XsrFlf7huuNd3TFdDbAPjUV2+ty+ZznqsRi+YCmsjWticWCFs3
nna9B05vIHjcM/4ZU2WRR3NbHJAzhtxjnxOg2HVRvE0RRPVhlTy6C86H1bUnaatK
4KKKT7Xeh/Ounx1XenE0PAsWkOYyoLGM/TDJI67SQI3KS1rL7P2I5wycEc26CfOx
YzRr8d7UZ0gi0jYXvEFsuNUw/kW59PcBUspGAOfqZ7gmuUafWjsAQeFHBCe6iQ0Z
xVR/1O48JqD6neGR8VM6aNhvhSuNzTb5C9APPSAqzut2nJbY29Bj/gtvbodlejUQ
neZtHetUCiGwmXiIW0t1xz+w3FPvD1JgwcCVYz4dfznJmZHmz14=
=mOV+
-----END PGP SIGNATURE-----

--hzrqra7phcm27hy4--

