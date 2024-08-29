Return-Path: <linux-kernel+bounces-306487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28897963FB5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0B67B22F39
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA18618D63B;
	Thu, 29 Aug 2024 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="EZyI9WjC"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DE518D63A;
	Thu, 29 Aug 2024 09:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724923033; cv=none; b=WPGkEeyDif1wMWsN0fyovdozgqTFiWeyA/ubVwdCYNuU6XLkyXmHKdek1xwIExHNMG+MUW74LRf40A5H7BipzQ2In62pjMCw8tyQkQZwQwN+RuYD3gpELfEuNq6Sbjpxr36qHIexKYrCvmY5BDkvCuBP7uls/QCtysExfvNJCBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724923033; c=relaxed/simple;
	bh=SgVTgRK+0wNwUFBeTxPLOnEYRB/KBJtDw35oxosAxKc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K37wVvc+IoTqdRc3C18BWgdqrcYwyMqbdG1nL26dxuYE/7wia+ICjoCTTHW4Fk3swdfoCLGITK9I3UIH8IuICy2hwjghhqcIW4z0vTnvPJjsGofWj3ktzfYFyvoPfCvVT++6ycyVy6oz1xYdrm7K1V2R3efqjpyIG6cg4I35nyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=EZyI9WjC; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 8B6AE831A1;
	Thu, 29 Aug 2024 11:17:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724923024;
	bh=LXR1nPUxSyWrjiNK8lZ2WFyKiKdIj/aOb1xeF3UDSZ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EZyI9WjCigWoVTNUoR6lXPGvtvBGy/9gYISWGZg/DsJUaWvzESZVu/T0J1PxTabZ7
	 g5siNPtwgFdz7cXCs/LBCFzW2pLjj2AvPxBDqQJ6pHyya90Wey0rMY24feW5sxZhHn
	 Qm2/ex2hjKkjVMdhq7bE4TtR39V9QROthtXHofhblqi0+6uwsEf93CEXro1nCyhpsG
	 wnkGn5GPqY1sQUqYAbKcMNLo4OCGH56rCu2l+3v+r2vhAU6I0m/RxqODCjZ2q/LXGC
	 O5xGtx42cls5LvhPRSktmVS2wBhgHKV8CYXag4YxGFlbtC8an62x+/xfEakG/xEhm/
	 saQ6HL130L1Tw==
Date: Thu, 29 Aug 2024 11:17:02 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dts: nxp: mxs: Add descriptions for imx287 based
 btt3-[012] devices
Message-ID: <20240829111702.7ee999b6@wsk>
In-Reply-To: <CAOMZO5BOCOuf9t5uH1TfcWyoi-ECrw=3HztRVVXi0WR4K6EqZA@mail.gmail.com>
References: <20240828112139.2665814-1-lukma@denx.de>
	<CAOMZO5BOCOuf9t5uH1TfcWyoi-ECrw=3HztRVVXi0WR4K6EqZA@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3vwl=3nO.Iz6tuJ3+b+0v3H";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/3vwl=3nO.Iz6tuJ3+b+0v3H
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

> Hi Lukasz,
>=20
> On Wed, Aug 28, 2024 at 8:21=E2=80=AFAM Lukasz Majewski <lukma@denx.de> w=
rote:
> >
> > The btt3 device' HW revisions from 0 to 2 use imx287 SoC and are to
> > some extend similar to already upstreamed XEA devices, hence are
> > using common imx28-lwe.dtsi file.
> >
> > New, btt3.dtsi has been added to embrace common DTS properties for
> > different HW revisions for this device.
> >
> > As a result - changes introduced in btt3-[012].dts are minimal.
> >
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> >  arch/arm/boot/dts/nxp/mxs/Makefile   |   3 +
> >  arch/arm/boot/dts/nxp/mxs/btt3-0.dts |  12 +
> >  arch/arm/boot/dts/nxp/mxs/btt3-1.dts |   8 +
> >  arch/arm/boot/dts/nxp/mxs/btt3-2.dts |  12 +
> >  arch/arm/boot/dts/nxp/mxs/btt3.dtsi  | 320
> > +++++++++++++++++++++++++++ =20
>=20
> All the i.MX devicetrees start with the SoC name.
>=20
> What about naming them imx28-btt3-0.dts, imx28-btt3-1.dts and so on?

+1


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/3vwl=3nO.Iz6tuJ3+b+0v3H
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmbQPI4ACgkQAR8vZIA0
zr021AgAqtBaMmL5HMHSJ5Im0KRg2EoTHjIdiCB5Dr/YLQ62Bj/w0SBiRz1r2gor
q2D1nmS9jB5dS1ASNBOzJakRG7gQNqBhVnELo0MyzWVQpc8ilVFEoPqfaTu87Ab0
5eHcjguXFYLFPRp3DlH3sHkZ4Oz/EwZ9EvsRrjya9y+rgtGyBfU9sVncoryLEDCE
b+FnAPx2Nf7TsM0Zuh+se8l3Zyx4Rz/gK/y1kxha0AwRfDPWL3VwNgOcLx7Q0Sye
JbAsKKqlClPVNVMYaVmhsg7L5d44hMiwrQ2e9mh/BU5FATKoLrBjRHkzcbkbKAfa
uIqBQrZ3uHYDOO7OFoO3I3EssKGIMQ==
=sIRF
-----END PGP SIGNATURE-----

--Sig_/3vwl=3nO.Iz6tuJ3+b+0v3H--

