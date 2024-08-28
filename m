Return-Path: <linux-kernel+bounces-305291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7643962C72
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BEB31F21126
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83771A2560;
	Wed, 28 Aug 2024 15:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="AcwAc6jm"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746C313D8B4;
	Wed, 28 Aug 2024 15:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859220; cv=none; b=ZSLmoqfQn5sKZe4VGIrc4jZ1rENp7i7ZB71AUlcX0UzAcvBhOGsJ/A7fCM4xklvlcnO3B8KZM+oWdUecT9jkvSy/yUtBfSjgZ9Zsk4SMu0ZfnnAkQICGBT6Lpm1FD9nh7pKzlO1tCscLMJ6PF8glhu99DVuhn3ctsOhTL0PfFIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859220; c=relaxed/simple;
	bh=o56S8pLMGrt4CkvaoCu9w5pHDJBsrZKUDQNBoIaCEpU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UUtYlPlFVAV0IihH1sKpquKm/dYYpcRXwbtfJJyHJzwFnmXNZ+SmrqV/TAwzb6ihvgbYsm/aHr1sIycjMWtIT9min/cqNMJM1yYUJuxfUPytsgflgXvyn88AXexV2XTao6Xo8mT/nAKGcv52+vWK94CCqO2xhbNmDKa6XDqE9OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=AcwAc6jm; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 16BD1885A0;
	Wed, 28 Aug 2024 17:33:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724859216;
	bh=pgIBv8xSZ60paxL7JPQGAQxBEmzFpSxLivN1lCW3iI8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AcwAc6jmYoBxdS+F2EIASSPI4YXEVA+nBDE8Fq7ED18W6DpV9S8Kc9sjopHI4bHaC
	 NVnsVhNF/tAWTTfsnquliEt2Sp95HVMwt+UDEPmCyGZCK2i6c/rkVdzl2dYxNNm34T
	 21V3J4Q7K4hIkEOWF/vfdh1+12JZbi/6M6eMmoypEI0MMQrwlwHZ9T6JZShu6TnuB6
	 7W5/h3Lhg0PAeCgu9YiaKIHxpCZqTMHo1a/PihjqgqxRcXjrS0oMerZ9j7p0Yfvkkq
	 dpM6hjmW3SCcYDU/eqN7favAySmpkdMRWkkD8+qdCryE38Gamfm25m1JuqepZ3UOxy
	 cUAEZI8aFT3Eg==
Date: Wed, 28 Aug 2024 17:33:34 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: dts: mxs: Remove not used "fsl,imx2[38]-icoll'
 compatibles
Message-ID: <20240828173334.21dcdeb2@wsk>
In-Reply-To: <f4b7e56f-50d1-486b-9866-ee1f82262b53@kernel.org>
References: <20240828093518.2628817-1-lukma@denx.de>
	<f4b7e56f-50d1-486b-9866-ee1f82262b53@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LKKBY4fh8LtwIHI2=HgFYHN";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/LKKBY4fh8LtwIHI2=HgFYHN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

> On 28/08/2024 11:35, Lukasz Majewski wrote:
> > The 'fsl,imx23-icoll' and 'fsl,imx28-icoll' are not used at any
> > place in the Linux kernel - instead for imx2[38] the 'fsl,icoll' is
> > used.
> >=20
> > Hence, it is possible to remove them. =20
>=20
> Preference is to have SoC-specific compatibles in the front, so
> instead of dropping it, these should be documented as bindings.
>=20
> imx23 and imx28 are quite old platforms, so I think no one really
> cared about dtbs_check and their bindings. If the platform is being
> actively used (as judging by your contributions) then some bigger
> cleanup could be useful. Also, drop your email somewhere in the files
> or maintainer entry, so we will know whom to ping when asking for
> platform removal.\

>=20
> But if there is no product on imx23/28, then I am afraid it might be
> wasted effort - isn't it planned for deprecation/removal by Arnd?
>=20

I cannot say about imx23, but for sure imx287 will stay with us for
many, many years.

imx287 (arm9) is still in active production, for extended life time
devices...

It is just pervasive in the industry.

> Best regards,
> Krzysztof
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/LKKBY4fh8LtwIHI2=HgFYHN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmbPQ04ACgkQAR8vZIA0
zr14qAgAxSvE4qlOjSzUXqF7+zIEVZTP4mBonJa6mWpx46jie3dTr1gKZhB7qOFg
UTiWKH3cleVbqMngkfGQnyjhixhfLJrKNJNrY46Wk9c9o8Nt/U/qcWjrR0EzOCAf
kTBqwu8u1pgMONsUqWp1sMFW1BcaC4E4xR8MMjZ4msaMZKRnsE9ddGgvhteg1nuv
1TzABHV7FFxemuamdrwXMAVjpvMhHdLdWxlkxfeIX8Xykmasj13hK3EIuuWXdxML
zUrGOni1V0tIrCQna6gvuNBazlUhrib9O5TdX1kUmo2kbNIa/aCq4n5XHo5NHoKv
DRh8axbd8BWOjYbkk90srtYXMQioLg==
=s7nd
-----END PGP SIGNATURE-----

--Sig_/LKKBY4fh8LtwIHI2=HgFYHN--

