Return-Path: <linux-kernel+bounces-304573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B36639621FA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 694A82826C5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CF815ADB3;
	Wed, 28 Aug 2024 08:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="TgJ+SDcI"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107DF157E88;
	Wed, 28 Aug 2024 08:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724832077; cv=none; b=j1FUtoyAXC73z46Wp1dSBpmxwZcaFczVm0R0MM6jijHAvUlcKqHd0uscDrCFhjIoSCIwCEAodMD+w3xnlfimjXZEBDc+7V8eKUFjIRts0yYATU8sThnE9vwd9WJkPXrFnQ9XOFydTYTxOSRyoiDLZIpNTOydEKUM/g8ZVhSwYAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724832077; c=relaxed/simple;
	bh=q3+yV9/2nn6kuWyLCUtijxbnMcgqxCbfqe44GUBUAMg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f1vhmddFLvmu8rvv2jdpcTUWv1mhKRoONDJl/OUvdRJIn1vs8kdnrLsPgO07PCB2Nz1sQEeB7ayDXeWYB2y+Co3tAuZmirJ9ItEe93Udk4NmyL1+jNEZWAdNR99atmLvLSftnPTxDosgZ1tHNSWB/gYPtk4Zp1lrmaQAempbjDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=TgJ+SDcI; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 7CD5788852;
	Wed, 28 Aug 2024 10:01:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724832073;
	bh=JgwDc4JoAWGEkDqG8w6tT/QjJOG2yEkAJ/ckjkJ7Zbw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TgJ+SDcIaqS8QIrG/USFV3z2fOt0siiMwRBvil59u4Y6eFAn42912G+HFkUEO/ZvW
	 TBwFwOtdwdzvLCPoB5VVfRl21vZNELas2Fgp2Er/CIdG/PzXaWJwloAX5XKj9YXZ0C
	 /L+rKbHAFDP3T0Y42P/lNMJXxT/lA2Yctvt9OEvHcrdqd/nno7EbfIDu/ECWW5/MuA
	 YJ8O/RhyXaeI1b8/byvIdOp2q0Cvs+B1sbHncsL6fMJUxTslI9Gfg5C/2IYtIvIhJC
	 ZbF/QQgUAL1CYSDcIoS8uYb3qAUIwN4EkPFmHPLfaJOVjSPHcMda5vYTqNVGEicZR0
	 G7ylfdF8QBruw==
Date: Wed, 28 Aug 2024 10:01:11 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio
 Estevam <festevam@gmail.com>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: Add dt bindings definition file for
 imx28 saif
Message-ID: <20240828100111.10852309@wsk>
In-Reply-To: <mzlrm7zkzuue4xsxehz32ffiesigy2dzbos2osirzfoi525q6q@7klbgtmht74a>
References: <20240827180528.2315563-1-lukma@denx.de>
	<mzlrm7zkzuue4xsxehz32ffiesigy2dzbos2osirzfoi525q6q@7klbgtmht74a>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_gimqZ3VPAw3ipv3ud7YrZ7";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/_gimqZ3VPAw3ipv3ud7YrZ7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

> On Tue, Aug 27, 2024 at 08:05:28PM +0200, Lukasz Majewski wrote:
> > This file allows correct check of DTS node for imx287 based
> > "fsl,imx28-saif" compatible device.
> >=20
> > It corresponds to Documentation/devicetree/bindings/fsl,imx28-saif
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> >  .../devicetree/bindings/sound/fsl,saif.yaml   | 79
> > +++++++++++++++++++ 1 file changed, 79 insertions(+) =20
>=20
> There is a binding. Please perform conversion from TXT to DT schema,
> mentioning in commit msg any changes from pure conversion (e.g. new
> properties to match DTS).

Hmm.... OK.

>=20
> Few more comments below.
>=20
> >  create mode 100644
> > Documentation/devicetree/bindings/sound/fsl,saif.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/sound/fsl,saif.yaml
> > b/Documentation/devicetree/bindings/sound/fsl,saif.yaml new file
> > mode 100644 index 000000000000..747faa411a50
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/fsl,saif.yaml
> > @@ -0,0 +1,79 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/sound/fsl,saif.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Freescale MXS Serial Audio Interface (SAIF)
> > +
> > +maintainers:
> > +  - Lukasz Majewski <lukma@denx.de>
> > +
> > +description: | =20
>=20
> Do not need '|' unless you need to preserve formatting.

Ok.

>=20
> > +  The SAIF is based on I2S module that is used to communicate with
> > audio codecs,
> > +  but only with half-duplex manner (i.e. it can either transmit or
> > receive PCM
> > +  audio).
> > +
> > +properties:
> > +  compatible:
> > +    const: fsl,imx28-saif
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  "#sound-dai-cells":
> > +    const: 0
> > +
> > +  assigned-clock-parents: true
> > +  assigned-clock-rates: true
> > +  assigned-clocks: true =20
>=20
> These three should be dropped, redundant.

Last two are present in definition of saif[01] in imx28.dtsi - so IMHO
it shall be added.

Moreover, those are present in fsl,sg5000.yaml dt-schema description.

>=20
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  dmas:
> > +    maxItems: 1
> > +
> > +  dma-names:
> > +    const: rx-tx
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  fsl,saif-master:
> > +    description: Indicate that saif is a slave and its phandle
> > points to master
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - dmas
> > +  - dma-names
> > +  - "#sound-dai-cells" =20
>=20
> Keep the same order as in "properties:" block.

Ok.

>=20
> and here allOf: with $ref to dai-common.yaml

Ok.

>=20
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    saif0: saif@80042000 {
> > +        #sound-dai-cells =3D <0>;
> > +        compatible =3D "fsl,imx28-saif";
> > +        reg =3D <0x80042000 2000>;
> > +        interrupts =3D <59>;
> > +        clocks =3D <&clks 53>;
> > +        dmas =3D <&dma_apbx 4>;
> > +        dma-names =3D "rx-tx";
> > +    };
> > +  - |
> > +    saif1: saif@80046000 { =20
>=20
> Just one example, could be this one as more complete.

This is important, as saif1 has "fsl,saif-master" which allows to have
full duplex PCM communication (by default on imx28 single saif is
half-duplex).

>=20
> > +        #sound-dai-cells =3D <0>; =20
>=20
> Keep it after "reg" (compatible and reg are always first).

Ok.

>=20
> Best regards,
> Krzysztof
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/_gimqZ3VPAw3ipv3ud7YrZ7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmbO2UcACgkQAR8vZIA0
zr1QcQf/euu7IT1NcD2+dD6eT2Od2udmPLT+RnskvAcYRZfe15b5OBOpDygNrTIr
Aujol4WGW+JZHN2mwMQkFf6iMVgE2RgMUaipfdsMX3h73eGPo6us0OY/Tld6NF29
N/bQNZTUHoZZ03c+QIVHqX2ZcdIk40UzZ27JcT33CizCbncbPMM4aFF5EGynFyg7
sB6N738GcDCrgJvgpy7vVJ1bxh1psUarXf04+mQMemJ5T3cFffhE4iSW+/hEq6Pj
Okor54NDlTvvXqkRR9VBHzzrDyD6jHAp0AMGYrkWvX07VUAeI2GOIBaEpaihjqva
mSxmdTBxaPk33JlG38Wp5Sft/oZH/g==
=8HeM
-----END PGP SIGNATURE-----

--Sig_/_gimqZ3VPAw3ipv3ud7YrZ7--

