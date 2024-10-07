Return-Path: <linux-kernel+bounces-352941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2C8992662
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 172301C22831
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 07:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B81118800D;
	Mon,  7 Oct 2024 07:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GK8EWprj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAFB1534E9;
	Mon,  7 Oct 2024 07:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728287445; cv=none; b=RivKZH2QRxRmOe497rtdFj5lO1QIfDC8JDUwb4PDvjv5tNaRLbHkoT7VUI/ZQcJqGwfcW+AgQ4UUjApxyGhu6ZVJCkrqscRBUZ2DfNN6Q+MYI8b/cTwH9kNNbUlr5Nl50FgjcKbwVb6P2D5gvXeeBpLzmXhaXHirlYGxAsOPhEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728287445; c=relaxed/simple;
	bh=LZwLhPcihpVwhqUd44bHekSn+fvPmdtdSBIxwelAqgU=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=qAAYwWiFCDpi6Q5WbGcuQYI1xqxhdvRk95W29Z9aaV+jMIOszyt9d7ChKLokfpMBMAJgf4Curf06MHV51aGpr/aCVhhn5khdLmMlREYvOVruHflKHcaIsUN8LpoPXHYX6fBIyfTcM/BGenMPePmZ66ZBji4QPhx7+hVKr+J2LFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GK8EWprj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557DBC4CEC6;
	Mon,  7 Oct 2024 07:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728287443;
	bh=LZwLhPcihpVwhqUd44bHekSn+fvPmdtdSBIxwelAqgU=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=GK8EWprjujC9Tfvzj6WVPbnrV2bF6TKHAk2EAEqU41FrNmpVkNiQZ4sJBWYAqDWEF
	 0KB9XVHtxTc7/rv21PlOB0YBw46iOu9cX+WnSX79m0cVdJgDQ84i4HRjL0c6vmxOuX
	 DQr5O05dm1qtHgasFGHJk5B/52rCgL68ohQme0HRkOBqeYUwn7zHI6BReTf+NX3FI+
	 vbcHvcuquWjy1orykoi97YVXsCVD3t/5RvJ65AYRqu8YmjgwryBldzdRVQg4aT1fP7
	 n0VxLzbNachbfkfInMr9jW5/2OIYYy3d+CZRgu0U/hVziwX9tbzzCHckyPYWvm1K7w
	 1/CDpp+F5UmLA==
Content-Type: multipart/signed;
 boundary=4f89559e3e3addf49573992635c3f51e2eb8df6bf427dc56eda58fc4e794;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 07 Oct 2024 09:50:39 +0200
Message-Id: <D4PERKZ4GL6B.1WKA1I3MYSQVL@kernel.org>
Subject: Re: [PATCH v2 2/3] mtd: spi-nor: support vcc-supply regulator
Cc: "Rob Herring" <robh@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Fabio Estevam" <festevam@gmail.com>, "Vignesh Raghavendra"
 <vigneshr@ti.com>, <devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
 "Richard Weinberger" <richard@nod.at>, "Sascha Hauer"
 <s.hauer@pengutronix.de>, "Marco Felsch" <m.felsch@pengutronix.de>,
 <linux-kernel@vger.kernel.org>, "Tudor Ambarus" <tudor.ambarus@linaro.org>,
 <linux-mtd@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
 "Pengutronix Kernel Team" <kernel@pengutronix.de>, "Miquel Raynal"
 <miquel.raynal@bootlin.com>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Shawn Guo" <shawnguo@kernel.org>, "Peng Fan" <peng.fan@nxp.com>, "Pratyush
 Yadav" <pratyush@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Peng Fan (OSS)"
 <peng.fan@oss.nxp.com>
X-Mailer: aerc 0.16.0
References: <20240930-spi-v2-0-ed7f6bcbe0df@nxp.com>
 <20240930-spi-v2-2-ed7f6bcbe0df@nxp.com>
 <20240930-wonderful-wealthy-aardwolf-b455d6-mkl@pengutronix.de>
 <20240930-amaranth-stallion-of-fantasy-67701d-mkl@pengutronix.de>
In-Reply-To: <20240930-amaranth-stallion-of-fantasy-67701d-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--4f89559e3e3addf49573992635c3f51e2eb8df6bf427dc56eda58fc4e794
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

> > > +	ret =3D devm_regulator_get_enable(dev, "vcc");
> > > +	if (ret)
> > > +		return ret;
> > > +
> >=20
> > What happens if the SPI-NOR doesn't have a "vcc" regulator?
>
> ...the SPI-NOR will use the dummy regulator.

Which then prints a warning "using dummy regulator". Is that the
usual way to go?
I mean the regulator is actually mandatory because it is the main
voltage rail for the flash. To get rid of the warning one can add a
fixed-regulator (which is correct anyway). But OTOH, the device tree
lists it as optional (marking it as required isn't an option either
because virtually all device trees won't have that property).

-michael

--4f89559e3e3addf49573992635c3f51e2eb8df6bf427dc56eda58fc4e794
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZwOS0BIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/itIQGAlVlJTTCQIXmqzui5WhdsuBn8I74X+Pl7
YIOZ5srEjl+s75tdMuZ79ixoF50nGGX2AXwJv/geIp9+ua4N3snMvPChaw43SAbu
nfe1itE/wQHdobQbIS5fXEZsl0asg29UJfg=
=bBef
-----END PGP SIGNATURE-----

--4f89559e3e3addf49573992635c3f51e2eb8df6bf427dc56eda58fc4e794--

