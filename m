Return-Path: <linux-kernel+bounces-174137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DE28C0AB1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 06:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34F7528443B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 04:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6B51494CA;
	Thu,  9 May 2024 04:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ooWkZOan"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69F6148858;
	Thu,  9 May 2024 04:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715230252; cv=none; b=XFJpe6suuKrE9OUsbjTs0VjN6m5Jahdsz7QTF5ruBB3Q9u965QNZFbVmR93CfvLonhjVnHOUrr2LaaMhyBf6PWOa5uzqf14EmQ51+TgPSvtyzL9n3VRN8oBhmjJyJL5GEnFolLSMi5tDcPJpMhUfcKVRIj1yg/ZwmOstfG63Zgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715230252; c=relaxed/simple;
	bh=a964IG20g0mcJX+qtDAbnau0BEnxx6FVxxZjHZ7Ne84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I04Zk8C8Ne0d3qw069yvqX/pBUgqeGPFXG5eQJGZdEi3lIvPo/nz7hSNBLWAhRiKprpsmZTtSrNjj+yPG5o6k2A4jn9yn1MjLhUFwXloJuTY20Dd+ZQD2f3wIEL7YcPchxoiW8f+nu9jCGW3/R7seXEn7dPc8Tp6X/LXfYEoHCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ooWkZOan; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCAE6C116B1;
	Thu,  9 May 2024 04:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715230252;
	bh=a964IG20g0mcJX+qtDAbnau0BEnxx6FVxxZjHZ7Ne84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ooWkZOan6eU5duQ7F6zmekuSy3fLmut/YQfpbrHptjl2VrtS+Jukly1wPYBDEu13Z
	 jZK5/R2II0jEHQSTka5/vbweIgbbxRtCUxFd+zJkMDtqh0pBOyEDt3LxazbJWDiPMI
	 OjFTl5G4fcqLZ1QpMZXCudRoGPvdv4RzWYl/GQrCQtCYr7UZvgv+kryoODiPbI6CTy
	 JPkRO6hi0CBKYaAzZ0OpIXQnbwxwsWaGobUMpynUOiK2JzaBekCwNHJBgEstyRRuEJ
	 Wosu/YjoyP3fY4Lqe0BLK14Qoobf+6n+ROJZLDWNqleNHPk2GAfbd0T+M9gKcdA4p6
	 4QOCckZN1juxw==
Date: Thu, 9 May 2024 06:50:48 +0200
From: Mark Brown <broonie@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Samuel Holland <samuel@sholland.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	Andre Przywara <andre.przywara@arm.com>,
	Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH RESEND v5 2/2] regulator: sun20i: Add Allwinner D1 LDOs
 driver
Message-ID: <ZjxWKOoLMNQAmhla@finisterre.sirena.org.uk>
References: <20240507041343.272569-1-wens@kernel.org>
 <20240507041343.272569-3-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g1RsFHX7V6ArnC2e"
Content-Disposition: inline
In-Reply-To: <20240507041343.272569-3-wens@kernel.org>
X-Cookie: Sorry.  Nice try.


--g1RsFHX7V6ArnC2e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2024 at 12:13:43PM +0800, Chen-Yu Tsai wrote:
> From: Samuel Holland <samuel@sholland.org>
>=20
> D1 contains two pairs of LDOs, "analog" LDOs and "system" LDOs. They are
> similar and can share a driver, but only the system LDOs have a DT
> binding defined so far.

This doesn't build on at least multi_v5_defconfig, multi_v7_defconfig
and arm64 defconfig:

/build/stage/linux/drivers/regulator/sun20i-regulator.c: In function =E2=80=
=98sun20i_reg
ulator_probe=E2=80=99:
/build/stage/linux/drivers/regulator/sun20i-regulator.c:111:16: error: impl=
icit=20
declaration of function =E2=80=98of_device_get_match_data=E2=80=99 [-Werror=
=3Dimplicit-function-de
claration]
  111 |         data =3D of_device_get_match_data(dev);
      |                ^~~~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/drivers/regulator/sun20i-regulator.c:111:14: warning: as=
signm
ent to =E2=80=98const struct sun20i_regulator_data *=E2=80=99 from =E2=80=
=98int=E2=80=99 makes pointer from inte
ger without a cast [-Wint-conversion]
  111 |         data =3D of_device_get_match_data(dev);
      |              ^
/build/stage/linux/drivers/regulator/sun20i-regulator.c: At top level:
/build/stage/linux/drivers/regulator/sun20i-regulator.c:136:34: error: arra=
y typ
e has incomplete element type =E2=80=98struct of_device_id=E2=80=99
  136 | static const struct of_device_id sun20i_regulator_of_match[] =3D {
      |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/drivers/regulator/sun20i-regulator.c:136:34: warning: =
=E2=80=98sun20i
_regulator_of_match=E2=80=99 defined but not used [-Wunused-variable]

--g1RsFHX7V6ArnC2e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmY8ViUACgkQJNaLcl1U
h9DVRwf/W0u/DsfRiOg544BQO14Ruk6H0o+gXYE8qd5+KA124vKjN3tCXj3M5dfX
wMKDwWXD4MmMHCDdyaQO+ZvlUojvktKtVJTsTmesOXeV6oX1KFgKPd/lVWnI3Hkb
gSBz3iTePYx0olIQFKi0RWvqn2ykvEfKdGMxFiXexCeCKvx59eVf+Prr35cpNvXr
QD57BzTpmHkA0X5zMJayU04imi/IwLoTSCfZFWkfdk4WqeEOaV/VwSpdZ0ZEpKe6
cFsWgmSxIT3SaqPJfHcUAKS9btPLY4pzF2j/4pqS6HUILVLPjULh/0vPiNLF9JOq
E1OYXyruAQ+pa70o/cnO1OkVRec/8g==
=f3+H
-----END PGP SIGNATURE-----

--g1RsFHX7V6ArnC2e--

