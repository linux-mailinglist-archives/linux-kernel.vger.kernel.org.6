Return-Path: <linux-kernel+bounces-303280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D580960A26
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BB78B20793
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA1E1B5EAF;
	Tue, 27 Aug 2024 12:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="WwUROeAJ"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27151B5301;
	Tue, 27 Aug 2024 12:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761575; cv=none; b=XYITbRLgnv1dpGEPeTNVAFC4fVskArTtIXGnDP9rV/OGUpS79eUg0lqSv5MQUaDnFbeHBt1RHdHqwij/HurQyJJA42Dk0B6AQhxVgJ/cU9I/K0yfbxspaAPt+yxS1M7wBoNTOrIR5z/vrWzSsu6z92QbASvgQ3lmC28RuYZSpOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761575; c=relaxed/simple;
	bh=90csS7TzFomY9kk2SlVaXzWefeCJC2GYS7YDcIm7oD8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hLQBS61wTED0KSahJ5/LxABrFLIQR6uZ8f7YSNcj82Zoc2ck/9yzGP8oqwy1lj3ycbVuPnbCYB9cnxGrxO2JCCSs+/3FqrAsVqRg7O6i3UICTrSM5hvb+GBEJIDahFkLrzpWkON8rACzRkUg/8ID3x9VN8/59egl/1tYQw9HTAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=WwUROeAJ; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 4889B8882C;
	Tue, 27 Aug 2024 14:26:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724761570;
	bh=3LM+F6Jdtc9cR249fkM14T/K09xqnRGCL1nraIQ28HE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WwUROeAJMcqJW+p2pZ1SOeMdOiebljbf5K79F6jEX4jKk0vqjwLD2xtImfsd/0NBW
	 /+RbNQsjZNaV0SKZLYZL+lXGEw3pw5on67bpgeTWvGTnfZh6Xlt5mMGMq5akpmGeEj
	 jniB2rFKZSmt/AcN0zESunAnRUaQ+xyGanFVCz/LFPtNJc6uxSuXx8ATyBnBOvyR2t
	 77KPbm/ZUuGz2xKspb2xavFedeuEXWygWO3Br4PYod87FHgAXjdReyEg+xQ2w16iE9
	 cqh9lIJdkPQHR9vkHkXEqr7BguwIPlMSehCjk4tpE6eJb6V16ItY11pqds57gM0u8S
	 XJaVikG5ly7Yg==
Date: Tue, 27 Aug 2024 14:26:08 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dts: nxp: mxs: Update device tree description for LWE
 imx28 based devices
Message-ID: <20240827142608.36961a3d@wsk>
In-Reply-To: <737edb34-688d-4800-bb50-2374ac94ac75@kernel.org>
References: <20240827084255.2120864-1-lukma@denx.de>
	<737edb34-688d-4800-bb50-2374ac94ac75@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IW_JTQw4WwK+ijFjBb0rCcO";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/IW_JTQw4WwK+ijFjBb0rCcO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

> On 27/08/2024 10:42, Lukasz Majewski wrote:
> > The description for imx28 based devices needs to be updated after
> > some further development. =20
>=20
> Everything is an update, please be specific in commit subject and
> message.

Ok.

>=20
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> >  arch/arm/boot/dts/nxp/mxs/imx28-lwe.dtsi | 38
> > +++++++++--------------- 1 file changed, 14 insertions(+), 24
> > deletions(-)
> >=20
> > diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-lwe.dtsi
> > b/arch/arm/boot/dts/nxp/mxs/imx28-lwe.dtsi index
> > 69fcb0dde940..6fa1f3e25b08 100644 ---
> > a/arch/arm/boot/dts/nxp/mxs/imx28-lwe.dtsi +++
> > b/arch/arm/boot/dts/nxp/mxs/imx28-lwe.dtsi @@ -55,23 +55,6 @@ &i2c0
> > { status =3D "okay";
> >  };
> > =20
> > -&saif0 {
> > -	pinctrl-names =3D "default";
> > -	pinctrl-0 =3D <&saif0_pins_a>;
> > -	#sound-dai-cells =3D <0>;
> > -	assigned-clocks =3D <&clks 53>;
> > -	assigned-clock-rates =3D <12000000>;
> > -	status =3D "okay";
> > -};
> > -
> > -&saif1 {
> > -	pinctrl-names =3D "default";
> > -	pinctrl-0 =3D <&saif1_pins_a>;
> > -	fsl,saif-master =3D <&saif0>;
> > -	#sound-dai-cells =3D <0>;
> > -	status =3D "okay";
> > -};
> > -
> >  &spi3_pins_a {
> >  	fsl,pinmux-ids =3D <
> >  		MX28_PAD_AUART2_RX__SSP3_D4
> > @@ -109,7 +92,7 @@ &ssp3 {
> > =20
> >  	flash@0 {
> >  		compatible =3D "jedec,spi-nor";
> > -		spi-max-frequency =3D <40000000>;
> > +		spi-max-frequency =3D <20000000>;
> >  		reg =3D <0>;
> > =20
> >  		partitions {
> > @@ -133,14 +116,21 @@ partition@90000 {
> >  				reg =3D <0x90000 0x10000>;
> >  			};
> > =20
> > -			partition@100000 {
> > -				label =3D "kernel";
> > -				reg =3D <0x100000 0x400000>;
> > +			partition@3 { =20
>=20
> This does not look right. It is neither explained in commit msg, nor
> matching reg.

The SPI-NOR memory layout has evolved during time lifetime of the
device - for example special partitions to keep track of booted devices
for A/B booting scheme was added.

>=20
> It does not look like you tested the DTS against bindings. Please run
> `make dtbs_check W=3D1` (see
> Documentation/devicetree/bindings/writing-schema.rst or
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sou=
rces-with-the-devicetree-schema/
> for instructions).

Could you be more specific here?

For example:
CROSS_COMPILE=3D"*-gcc" ARCH=3Darm make -j4 dtbs_check W=3D1

Show:
arch/arm/boot/dts/nxp/mxs/imx28-xea.dtb:
/apb@80000000/apbx@80040000/saif@80042000: failed to match any schema
with compatible: ['fsl,imx28-saif']

Where the 'saif' sound driver is already supported:
git grep -n "fsl,imx28-saif"
Documentation/devicetree/bindings/sound/mxs-saif.txt:27: compatible =3D "fs=
l,imx28-saif";
Documentation/devicetree/bindings/sound/mxs-saif.txt:35: compatible =3D "fs=
l,imx28-saif";
arch/arm/boot/dts/nxp/mxs/imx28.dtsi:1110: compatible =3D "fsl,imx28-saif";
arch/arm/boot/dts/nxp/mxs/imx28.dtsi:1127: compatible =3D "fsl,imx28-saif";

Changes from this patch do not touch the generic imx28.{dtsi} code at
all.

I would assume, that the portion of my patch shall not bring any new,
extra warnings/errors?

>=20
> > +				label =3D "rescue";
> > +				reg =3D <0xA0000 0xF40000>; =20
>=20
> Lowercase hex

Ok.

>=20
> > +			};
> > + =20
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

--Sig_/IW_JTQw4WwK+ijFjBb0rCcO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmbNxeAACgkQAR8vZIA0
zr2Psgf/W6iVmFrnEXvDNjZMnWZoSyJF2CXY1W6zqHPxD2xiA+wAThMyJM3ULs3t
Scj9xt0+k+bRpQbHrsy/FI2x5rQWS23V0FYrIqSOOIZX/+hu34EdUnIU1uf/FMTE
VVdSuKfqSnKDUUuuok7SNRMinPaiUNtpp/5lJ8J+VZDZUUrXrnpKa1jfTAl77wCJ
WkRYrhOfT1ylML2g+Az7yEv/KjYomdSZbkDvuVBI9VeR8FTdarPD7lxO3aFusJwC
WdbmkpPk5TBnWAxWzNfLydV3fv8zIa8JgpP7zcILsQsLoPtIjJ743rM7HnMhkeMj
bvdUFJA1WnlMRmk4pHQgBKZWCEwBzw==
=au73
-----END PGP SIGNATURE-----

--Sig_/IW_JTQw4WwK+ijFjBb0rCcO--

