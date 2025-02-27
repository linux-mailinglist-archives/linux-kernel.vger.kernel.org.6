Return-Path: <linux-kernel+bounces-536054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E17A47B02
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE5163B248E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A692B22A7E7;
	Thu, 27 Feb 2025 10:58:15 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58EC229B03
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 10:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740653895; cv=none; b=E75qgR3IuoMGqmrOnc4bVcVjk8j8z9O2YG+Uhm6jTTKrqjvPwPUfq8G6/cB416N+ilZ/j4za8dvJCL1X7FC+WkQDyf88iQO3cA03YTTzN1N3IwR/Q/H1kPW1Pd7D6J9NeuinDnr6esJfrOmhO2mYrvx5ySlZZVebFpnj/48vir4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740653895; c=relaxed/simple;
	bh=M229xz7sJxjtA/Uv0ymIAtI/MmcxmVuJ18d7ilVsX6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WaYspQSEI2Zdo7Qb2Q9grA+kkXyHfjiVMZayE7Ek9fpWU/UJcc55Ccu93LBYz78YMbGNALzcUdT+cqgLHDai1HEIlw8XWCam+qm7u3jTd1aTZf8vnrMgVYXXcKggQZYYcYPP4RDEFofElLAvmuNU2jc9dkTsnAHNW0awZejNg6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tnbaV-0008AV-Km; Thu, 27 Feb 2025 11:57:55 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tnbaV-0036wT-18;
	Thu, 27 Feb 2025 11:57:55 +0100
Received: from pengutronix.de (p5b164285.dip0.t-ipconnect.de [91.22.66.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id DA0BA3CD463;
	Thu, 27 Feb 2025 10:57:54 +0000 (UTC)
Date: Thu, 27 Feb 2025 11:57:54 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Mihalcea Laurentiu <laurentiumihalcea111@gmail.com>
Cc: Frank Li <Frank.li@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	Fabio Estevam <festevam@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/5] arm64: dts: imx8mp: convert 'aips5' to 'aipstz5'
Message-ID: <20250227-monumental-whale-of-security-b1c84e-mkl@pengutronix.de>
References: <20250221191909.31874-1-laurentiumihalcea111@gmail.com>
 <20250221191909.31874-5-laurentiumihalcea111@gmail.com>
 <Z7jahtO3bxjkMfnc@lizhi-Precision-Tower-5810>
 <cd6a84cd-ff17-45df-becc-9bfc74522f73@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="khvk74ne4kfr3emu"
Content-Disposition: inline
In-Reply-To: <cd6a84cd-ff17-45df-becc-9bfc74522f73@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--khvk74ne4kfr3emu
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4/5] arm64: dts: imx8mp: convert 'aips5' to 'aipstz5'
MIME-Version: 1.0

On 25.02.2025 16:14:34, Mihalcea Laurentiu wrote:
>=20
> On 21.02.2025 21:56, Frank Li wrote:
> > On Fri, Feb 21, 2025 at 02:19:08PM -0500, Laurentiu Mihalcea wrote:
> >> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> >>
> >> AIPS5 is actually AIPSTZ5 as it offers some security-related
> >> configurations. Since these configurations need to be applied before
> >> accessing any of the peripherals on the bus, it's better to make AIPST=
Z5
> >> be their parent instead of keeping AIPS5 and adding a child node for
> >> AIPSTZ5. Also, because of the security configurations, the address spa=
ce
> >> of the bus has to be changed to that of the configuration registers.
> > The orginal 0x30c0_0000..0x31200000 include 0x30df0000, why not map only
> > config address part in your drivers.
> >
> > Frank
>=20
>=20
> Any concerns/anything wrong with current approach?
>=20
>=20
> I find it a bit awkward to have the whole bus address space
> in the DT given that we're only interested in using the access
> controller register space.
>=20
>=20
> I'm fine with the approach you suggested but I don't see a
> reason for using it?

Looking at the "AIPS5 Memory Map" (page 34/35 in i.MX 8M Plus
Applications Processor Reference Manual, Rev. 3, 08/2024), the
AIPS5_Configuration is part of the AIPS5 bus. IMHO the bus is something
different than the bus configuration. Why not model it as part of the
bus?

> >> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/bo=
ot/dts/freescale/imx8mp.dtsi
> >> index e0d3b8cba221..a1d9b834d2da 100644
> >> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> >> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> >> @@ -1399,11 +1399,13 @@ eqos: ethernet@30bf0000 {
> >>  			};
> >>  		};
> >>
> >> -		aips5: bus@30c00000 {
> >> -			compatible =3D "fsl,aips-bus", "simple-bus";
> >> -			reg =3D <0x30c00000 0x400000>;
> >> +		aips5: bus@30df0000 {
                       ^^^^^^^^^^^^
> >> +			compatible =3D "fsl,imx8mp-aipstz", "simple-bus";
> >> +			reg =3D <0x30df0000 0x10000>;
> >> +			power-domains =3D <&pgc_audio>;
> >>  			#address-cells =3D <1>;
> >>  			#size-cells =3D <1>;
> >> +			#access-controller-cells =3D <0>;
> >>  			ranges;
> >>
> >>  			spba-bus@30c00000 {
                        ^^^^^^^^^^^^^^^^^

This looks very strange: The aips5 bus starts at 0x30df0000 and has a
child bus starting at 0x30c00000?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--khvk74ne4kfr3emu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmfARS8ACgkQDHRl3/mQ
kZy1eAf+NIqSit01hbOk1TNt3Hmnml2DOG0v3yFMt3q0JGMriHkU9Rfgf+J6HLQF
+7ZiOn+KkncBW72Or3hAO4/BjlQoHwaf7ds4d+INbRY9JZxlqc1HovkScesRV+Gi
ce/CK0cz7sG02xqvFf4D08p3GaC5Do6oGtXmlOt8Mi45HC3ulKLnri/In9ZnfGXb
HZQr89ukWg67YwLxVd+wwIQzoGPH/qWZAhe+f6lfB8SGd1Jcp+vLoFLBJ2LctquC
wShPsn0p+dzhjANxj8yNc3uIncdU5yToRwWTTjodk6xQez9Duc+JZplVPMx6ptoJ
W1mmqIcEGNHve3tu7qHKeKwmrpiH+w==
=8kNX
-----END PGP SIGNATURE-----

--khvk74ne4kfr3emu--

