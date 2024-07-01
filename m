Return-Path: <linux-kernel+bounces-236212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 802D591DECC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 380D51F21B1D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9091884D02;
	Mon,  1 Jul 2024 12:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnQG9xaz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD42460BBE;
	Mon,  1 Jul 2024 12:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719835936; cv=none; b=QBcZXo/UVHpw96lpngWHbXCf+yIcaUq8RqU08lj/dUL97232Wt39HKmWIpr8OfMHOq5IK0YU4Bf39Q0jXrTs2STi9nBLzu15fVcbUaZPQ+quMwQYy8YCs3WoxyGnxrIIYpmwj0KRnm1HsE0S65zIqw8vFvGtU3WbgI4HyIPzBOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719835936; c=relaxed/simple;
	bh=l1xklY2Zev/GPyKUlcXxfi6zfjXVvNRWMxSiulovik0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSpyrpzM81Nepsru39l4xLyQ9uxF4L9QnclcytpDYnv3qOduUYHB921P01XmpzZhcBtUExFPwz556Ud6HB9SGmaJHcCetu0TvfMQs30qQk9b56jxXBThKsd4C/xKS8bWLMbP1Ft005KUH9Qc7XjjaNEmFO5UTUteYU/FtAujxGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnQG9xaz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A29C116B1;
	Mon,  1 Jul 2024 12:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719835936;
	bh=l1xklY2Zev/GPyKUlcXxfi6zfjXVvNRWMxSiulovik0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FnQG9xazNlsDRaAjHllhxv+zbCRx9t69JrF7sKxFyLIEfMahQR5aVxh/JG3PGe2pV
	 asgiPbWw19rxl7aZ+J3yYCAGuposUiZSqvyBPIeoXzPNJA8o/iZoSug3VzeAiiwOzF
	 QL1MVInotzbbS12IQBuh4+Kx8qojl/t6C5EzsrZU0bM51NDB8wjzJQs4YKx3bCOiC9
	 Q2C/DKmuMK3D1I73x1bPqFKfrhiItI1AoYaCpca7xL5w1gkPdCs2keLYo833Rviux6
	 PTEmZwBH+NHzUm7IhkblVhCtYAVRM8EdriQsaxQ87+eQgxaBSj8AKYpFqg+ZQvNPRU
	 b9G/ZhPZHOehw==
Date: Mon, 1 Jul 2024 13:12:07 +0100
From: Mark Brown <broonie@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Aishwarya TCV <Aishwarya.TCV@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: Mainline: v6.10-rc6 boot failed across all arm64 devices
Message-ID: <145b39a0-da05-4c60-a019-c1a6211e6c77@sirena.org.uk>
References: <CA+G9fYsXsbHp+0cWoTjEhkpANOav=GLSjPx5ghtUY-FjMPyoSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SErMzyUBNKIJosZk"
Content-Disposition: inline
In-Reply-To: <CA+G9fYsXsbHp+0cWoTjEhkpANOav=GLSjPx5ghtUY-FjMPyoSQ@mail.gmail.com>
X-Cookie: Microwaves frizz your heir.


--SErMzyUBNKIJosZk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 01, 2024 at 05:28:29PM +0530, Naresh Kamboju wrote:
> The mainline kernel v6.10-rc6 boot failed across all arm64 devices and
> qemu-arm64 and no crash log found (earlycon) did not help.
>=20
> But the defconfig builds boot PASS.
>=20
> The boot problem is with defconfig + Extra Kconfigs and builds links
> provided in the bottom of this email.
>=20
> The boot test history shows that,
>   GOOD: v6.10-rc5
>   BAD:  v6.10-rc6

Other CI systems aren't showing this.  I'm guessing you've updated the
toolchain versions you're using and are running into:

   https://sourceware.org/bugzilla/show_bug.cgi?id=3D31924#c9

and will see this with other kernels.  It's probably worth testing
toolchains before deploying them...

--SErMzyUBNKIJosZk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaCnRcACgkQJNaLcl1U
h9DLqQf8DuNdqMpFfWH8UckxMvlJ5nxNQzVWVdvFlhYyZSIS2XLM+nxCRHTTUFfF
ttdjQXc6GDaOrPaimM1tPBVjXrT2mFOFxmmr3aYq/WSX53GXiHDGVLpjAV9ojbGk
wFnIcW4Hkty+BC4z+/WwESwGwu1qRSQHDJeNtoygLMSStD71bUHacIVALZlo/QeV
zbn79KTfW65d+gu99hoprVzHypT90ukUKOVpGhmAP1vScP0QDkj7sTSY62yLDTU2
te88tGSiHxzK2n9Z7gw/57kovCSe5E0/6Mp1dHUybZENyjlbSpkbWKa0RfgNutXL
1GmwzJS/0GHaTuNvBCYc6/lFnhUAHg==
=Oo/v
-----END PGP SIGNATURE-----

--SErMzyUBNKIJosZk--

