Return-Path: <linux-kernel+bounces-343680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B1A989E20
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9BC61C21DB6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACD9189B8D;
	Mon, 30 Sep 2024 09:26:15 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18D71885B1
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 09:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727688375; cv=none; b=cPDuPFgrmuaPLSzv6AQHXJpYnCZQKlh0iFzkG8+48lGXuyHa6eQV/GvM8145fT1VyCGvoGVdKphSSOCqDQPOkIsVgEAM+VyoXvZnWiobYQsv4YWQ4ChhzRUG/YXrjuMnGHHUJyKzreSxto9HMQgV7vEiTnkJdkPVadwzTG7b2Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727688375; c=relaxed/simple;
	bh=C3s3W2qmoaiWLzUH6cCOwWXBY9oPAdEih6frCPpdF0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ItRo1ypHaqaeZ7lqrtPr8bgwaKux+Y7Es0Jao1hMnzFiTjx6g4aPU/V5mcXNtH7CIhwNRk/iwEwzkmVxciJDkFSfz9r/Q/n0iI+3vrrnOEYFh2XTyCALN6SQrBDLrtWrUXzX1sZeF60k8xheWsjuOoBcYrzfv+hwQ44fEApr/oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1svCfC-0007Dn-Ca; Mon, 30 Sep 2024 11:25:54 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1svCf8-002bCP-Sa; Mon, 30 Sep 2024 11:25:50 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7412834682F;
	Mon, 30 Sep 2024 09:25:50 +0000 (UTC)
Date: Mon, 30 Sep 2024 11:25:50 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Fabio Estevam <festevam@gmail.com>, Michael Walle <mwalle@kernel.org>, 
	Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	Richard Weinberger <richard@nod.at>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Marco Felsch <m.felsch@pengutronix.de>, linux-kernel@vger.kernel.org, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, linux-mtd@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
	Pratyush Yadav <pratyush@kernel.org>
Subject: Re: [PATCH v2 2/3] mtd: spi-nor: support vcc-supply regulator
Message-ID: <20240930-amaranth-stallion-of-fantasy-67701d-mkl@pengutronix.de>
References: <20240930-spi-v2-0-ed7f6bcbe0df@nxp.com>
 <20240930-spi-v2-2-ed7f6bcbe0df@nxp.com>
 <20240930-wonderful-wealthy-aardwolf-b455d6-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2tcsiwghsi2hwzwq"
Content-Disposition: inline
In-Reply-To: <20240930-wonderful-wealthy-aardwolf-b455d6-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--2tcsiwghsi2hwzwq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 30.09.2024 11:21:27, Marc Kleine-Budde wrote:
> On 30.09.2024 17:22:25, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >=20
> > SPI NOR flashes needs power supply to work properly. The power supply
> > maybe software controllable per board design. So add the support
> > for an vcc-supply regulator.
> >=20
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/mtd/spi-nor/core.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >=20
> > diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> > index 9d6e85bf227b..5249c8b13916 100644
> > --- a/drivers/mtd/spi-nor/core.c
> > +++ b/drivers/mtd/spi-nor/core.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/mtd/spi-nor.h>
> >  #include <linux/mutex.h>
> >  #include <linux/of_platform.h>
> > +#include <linux/regulator/consumer.h>
> >  #include <linux/sched/task_stack.h>
> >  #include <linux/sizes.h>
> >  #include <linux/slab.h>
> > @@ -3462,6 +3463,10 @@ int spi_nor_scan(struct spi_nor *nor, const char=
 *name,
> >  	if (!nor->bouncebuf)
> >  		return -ENOMEM;
> > =20
> > +	ret =3D devm_regulator_get_enable(dev, "vcc");
> > +	if (ret)
> > +		return ret;
> > +
>=20
> What happens if the SPI-NOR doesn't have a "vcc" regulator?

=2E..the SPI-NOR will use the dummy regulator.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--2tcsiwghsi2hwzwq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmb6bpsACgkQKDiiPnot
vG8hIwf/QXZytZ4ZzSbdjv9wXw1kBOy5ES/7Ay5dQoy1vBiQR5ta8KzKASWSHygA
SXpI1/i6UM3ZRu33nqVRFKqUBaAplExv/X5b5wnKXGY8ZmdU7eIfZQZPSRKqnqpl
KSADiG+M9FMpO/KKCVpceHGAs210B1Xh9PPza8Yl2mN4V0S3Usya5bKUI1mFR/lD
zL+rSWO7FPBdQ74xGoTOFFxaWQfCdc1i4B1v2sPbDXy5sRq0QYS71BRIWShDJvDt
a/0wyjiD2xg4gurQenOurY9RjeHtfs2nQRn0JkGRrd+VEJk53ZIABXYBHj2Bf8pn
fYkmdYXTwWFlqvKy1gTeQbLsi6YTJw==
=1jx1
-----END PGP SIGNATURE-----

--2tcsiwghsi2hwzwq--

