Return-Path: <linux-kernel+bounces-532429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B93EA44DA2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B452F3B2DC9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B198E221545;
	Tue, 25 Feb 2025 20:29:38 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FE9220698
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 20:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740515378; cv=none; b=KK0yMqn5p/lg4SC07TZzIWKqM4t3ZmvqNtQKqWskvoukwE5J2Dvp24W75RMWiToFbAdkFRHSSSsK0LR1rmLv32D1Ig2H70VGvRB07b85B/lK4M/QqAGC397+oqeTFNvF6STsFxXEyUrb3DyrxVnAYCZHmsMegIYBByw1/UWujCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740515378; c=relaxed/simple;
	bh=wFQ41lsmj13psuBC2ya1xEADvNt4FAs3TaaprU7t4Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOrNXg+19zvcxpf/P/eoQhDDdKpZFDVuJgNmSgjXBQ2riKvkeE/WPtRQBhppQRVeGpQZskwX2GJr+Wytem9opo+XPcPYlk1N0KJGcaKKwOSkksttc6GxqUD1lvz1wyG+UN0fH5DzctEA2D2inVe0ZoYS68ecTn9M3tUOheLRkWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tn1YL-0004PK-Uh; Tue, 25 Feb 2025 21:29:17 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tn1YL-002pgi-1j;
	Tue, 25 Feb 2025 21:29:17 +0100
Received: from pengutronix.de (p5b164285.dip0.t-ipconnect.de [91.22.66.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1E0533CBC87;
	Tue, 25 Feb 2025 20:29:17 +0000 (UTC)
Date: Tue, 25 Feb 2025 21:29:16 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Chester Lin <chester62515@gmail.com>, 
	Matthias Brugger <mbrugger@suse.com>, Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev, 
	Enric Balletbo <eballetb@redhat.com>, linux-arm-kernel@lists.infradead.org, 
	Christophe Lizzi <clizzi@redhat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	linux-kernel@vger.kernel.org, Alberto Ruiz <aruizrui@redhat.com>, NXP S32 Linux <s32@nxp.com>, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: s32g: add FlexCAN[0..3] support for s32g2
 and s32g3
Message-ID: <20250225-private-savvy-caracal-3e7f47-mkl@pengutronix.de>
References: <20250224134016.3921196-1-ciprianmarian.costea@oss.nxp.com>
 <174051414934.2971045.13322665811292325537.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hyjls6qa3nf4o47i"
Content-Disposition: inline
In-Reply-To: <174051414934.2971045.13322665811292325537.robh@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--hyjls6qa3nf4o47i
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] arm64: dts: s32g: add FlexCAN[0..3] support for s32g2
 and s32g3
MIME-Version: 1.0

On 25.02.2025 14:12:30, Rob Herring (Arm) wrote:
>=20
> On Mon, 24 Feb 2025 15:40:16 +0200, Ciprian Costea wrote:
> > From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> >=20
> > Add FlexCAN[0..3] for S32G2 and S32G3 SoCs.
> >=20
> > Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/s32g2.dtsi      | 52 ++++++++++++++
> >  arch/arm64/boot/dts/freescale/s32g3.dtsi      | 56 +++++++++++++++
> >  .../boot/dts/freescale/s32gxxxa-evb.dtsi      | 72 +++++++++++++++++++
> >  .../boot/dts/freescale/s32gxxxa-rdb.dtsi      | 48 +++++++++++++
> >  4 files changed, 228 insertions(+)
> >=20
>=20
>=20
> My bot found new DTB warnings on the .dts files added or changed in this
> series.

The dt-bindings patch that documents support for the S32G2/S32G3 is in
net-next/main: 51723790b718 ("dt-bindings: can: fsl,flexcan: add
S32G2/S32G3 SoC support")

> New warnings running 'make CHECK_DTBS=3Dy for arch/arm64/boot/dts/freesca=
le/' for 20250224134016.3921196-1-ciprianmarian.costea@oss.nxp.com:
>=20
> arch/arm64/boot/dts/freescale/s32g399a-rdb3.dtb: /soc@0/can@401b4000: fai=
led to match any schema with compatible: ['nxp,s32g3-flexcan', 'nxp,s32g2-f=
lexcan']
> arch/arm64/boot/dts/freescale/s32g399a-rdb3.dtb: /soc@0/can@401b4000: fai=
led to match any schema with compatible: ['nxp,s32g3-flexcan', 'nxp,s32g2-f=
lexcan']
> arch/arm64/boot/dts/freescale/s32g399a-rdb3.dtb: /soc@0/can@401be000: fai=
led to match any schema with compatible: ['nxp,s32g3-flexcan', 'nxp,s32g2-f=
lexcan']
> arch/arm64/boot/dts/freescale/s32g399a-rdb3.dtb: /soc@0/can@401be000: fai=
led to match any schema with compatible: ['nxp,s32g3-flexcan', 'nxp,s32g2-f=
lexcan']
> arch/arm64/boot/dts/freescale/s32g399a-rdb3.dtb: /soc@0/can@402a8000: fai=
led to match any schema with compatible: ['nxp,s32g3-flexcan', 'nxp,s32g2-f=
lexcan']
> arch/arm64/boot/dts/freescale/s32g399a-rdb3.dtb: /soc@0/can@402a8000: fai=
led to match any schema with compatible: ['nxp,s32g3-flexcan', 'nxp,s32g2-f=
lexcan']
> arch/arm64/boot/dts/freescale/s32g399a-rdb3.dtb: /soc@0/can@402b2000: fai=
led to match any schema with compatible: ['nxp,s32g3-flexcan', 'nxp,s32g2-f=
lexcan']
> arch/arm64/boot/dts/freescale/s32g399a-rdb3.dtb: /soc@0/can@402b2000: fai=
led to match any schema with compatible: ['nxp,s32g3-flexcan', 'nxp,s32g2-f=
lexcan']
> arch/arm64/boot/dts/freescale/s32g274a-evb.dtb: /soc@0/can@401b4000: fail=
ed to match any schema with compatible: ['nxp,s32g2-flexcan']
> arch/arm64/boot/dts/freescale/s32g274a-evb.dtb: /soc@0/can@401be000: fail=
ed to match any schema with compatible: ['nxp,s32g2-flexcan']
> arch/arm64/boot/dts/freescale/s32g274a-evb.dtb: /soc@0/can@402a8000: fail=
ed to match any schema with compatible: ['nxp,s32g2-flexcan']
> arch/arm64/boot/dts/freescale/s32g274a-evb.dtb: /soc@0/can@402b2000: fail=
ed to match any schema with compatible: ['nxp,s32g2-flexcan']
> arch/arm64/boot/dts/freescale/s32g274a-rdb2.dtb: /soc@0/can@401b4000: fai=
led to match any schema with compatible: ['nxp,s32g2-flexcan']
> arch/arm64/boot/dts/freescale/s32g274a-rdb2.dtb: /soc@0/can@401be000: fai=
led to match any schema with compatible: ['nxp,s32g2-flexcan']
> arch/arm64/boot/dts/freescale/s32g274a-rdb2.dtb: /soc@0/can@402a8000: fai=
led to match any schema with compatible: ['nxp,s32g2-flexcan']
> arch/arm64/boot/dts/freescale/s32g274a-rdb2.dtb: /soc@0/can@402b2000: fai=
led to match any schema with compatible: ['nxp,s32g2-flexcan']

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--hyjls6qa3nf4o47i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAme+KBkACgkQDHRl3/mQ
kZxdrwf+JXiYSAtNXsvcQpYo6OfO9ld3hbOKggakubUaLFftujJA/9iNVFaUgqHg
1m1/pAgYThwS+zVAVPn8w7zgfznQj5iF45qigUAugkGANBrPwvcr4YBYqrATQTpq
WHsWnaz5A8Emg9AC9kmg7nfFDM6uMR7SEWXwlvp3YXUzqC5Ujh2scrKg9nh/NUNj
BIDoOyWb0YrNyJoPfVd7ooG6GnMxmg6oPqWr7xIRwR+FkJVFwEtcBmPk71Xk9foX
yXLZlC92qTwQBn/0pgj/q/8XyX8UuGgL28Wfo2bg2q67iPqc/yQdi6QW/C+OMRuG
qJmoE2guvBD9ho/u4NtPJ307RtGZqQ==
=dAC0
-----END PGP SIGNATURE-----

--hyjls6qa3nf4o47i--

