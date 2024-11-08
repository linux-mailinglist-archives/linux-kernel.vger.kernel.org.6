Return-Path: <linux-kernel+bounces-401755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CF29C1EC1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45B762836AB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9902B1EF0AF;
	Fri,  8 Nov 2024 14:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="eCMBUV4/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="sWU5Qszw"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803901E47BE;
	Fri,  8 Nov 2024 14:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731074681; cv=none; b=Kc0FkyU/d3ySsVONh+Sjmwkv8dscFF7Mht0kXL7u+7SoPVzn0UrzDi0lB2gebNnEz+034VPkPiF0fVjW7wmLGyGe596/jZzZQCMh7EGjhGj5isrpUBCCl+KzVtY32D7xoM9rGqGhKDyx3y8/tNM+fbDCoosRWB2kdyfZc7Ozs2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731074681; c=relaxed/simple;
	bh=zSXO4oai+fP6s2/qch5CjMT48ma+8G2NVlL5zBus7Fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=blCs11YOxSjaNrUI6gW3qL3DbT78+dZ1VCB/jv4PK7LwOVVqC/DYV7WqTYB55ZjKuQB2YqXlKh19roXB8Oxp/cq4Jd68QVKZYb77cSYfqojWBIo6TrqbsUdiLGwfIymnYt5P6zKPNe9q24jzcGPKpTawApTS71dFZM9P+xWYqIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=eCMBUV4/; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=sWU5Qszw reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1731074679; x=1762610679;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ERNHBkanBqKFL3ox9eUbC/F74vANoxKE7ufPEj4aVYk=;
  b=eCMBUV4/tFLfFJiUfFUnk6fvdM0ZqidzgAukZCYNd1+opxPHba5aInMD
   aOixqa7x0J18JLC5pSfdRFnr7/ossQqLGVNEUL74Hu7D7hzayjEbiQL1P
   G/NNMRZh6NDk52hDV+ncMzjm7tDZel2KopYZSOCE2wqgatzzKKv7Dzb8j
   FHdCvOA1OIVBYVbwgc6CCXtetMhxT2aB/s59OFnAbRFY9fiWW8TuVLgb2
   EbjmjiKwivbxfUZrqU9CtoB0QrX2Q8Cd1AdQ3kXhok7LfgeH/BiXo1llO
   g91gX9TGvBZzYR9TbkiVlG9dJv/0NkVyWqyDur2JaTR3aEQ/t9hsS2tVm
   A==;
X-CSE-ConnectionGUID: buIqScCRRSqM1NGVvIff2Q==
X-CSE-MsgGUID: Cuwk4pU8SquUSdlrlunCag==
X-IronPort-AV: E=Sophos;i="6.12,138,1728943200"; 
   d="scan'208";a="39937249"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 08 Nov 2024 15:04:36 +0100
X-CheckPoint: {672E1A74-A-5736D786-D50827BE}
X-MAIL-CPID: EF367DDD2A39F4625B8CF4B973AAEAE0_2
X-Control-Analysis: str=0001.0A682F26.672E1A74.0090,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D9F3E160D5C;
	Fri,  8 Nov 2024 15:04:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1731074671;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ERNHBkanBqKFL3ox9eUbC/F74vANoxKE7ufPEj4aVYk=;
	b=sWU5QszwvFP/gLmWvlo/us2SLOtRCvPL4eiaeekEVUxGrKVu0IpTdQlv2Kyq9EFUXM2swr
	f5b8iqekGnKlwQ7vN7vpKvFxkrsQ0X9XRzWOiT9rYaAVHVyQTDDf9M+3oXin+KmXKmyoZF
	X7oRD/tpP9ULHbqRMva0p3Ez9I3MApjpkzBWWH5kJQAOGk74mwIi3hc7IJzcvj235U0ha+
	YO1Gk3e6ol5J8HmH2PDCotoJ38RNSZJWxJTILEuKp4h80aEc4pSeDZYnt6+JiimzE3z2su
	rz2GF8waLrYJpQY1p2xS9NdqiN1NHDFqyJGEdZ7C2rf1BkmAWdmJMWBtap5OQg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Pengfei Li <pengfei.li_1@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, joao.goncalves@toradex.com, frieder.schrempf@kontron.de, marex@denx.de, hvilleneuve@dimonoff.com, peng.fan@nxp.com, m.othacehe@gmail.com, mwalle@kernel.org, Max.Merchel@ew.tq-group.com, hiago.franco@toradex.com, tharvey@gateworks.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, ping.bai@nxp.com, ye.li@nxp.com, aisheng.dong@nxp.com, frank.li@nxp.com
Subject: Re: [PATCH 2/3] arm64: dts: freescale: Add i.MX91 dtsi support
Date: Fri, 08 Nov 2024 15:04:29 +0100
Message-ID: <10563047.nUPlyArG6x@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <Zy3gXvuWb76beZKo@pengfei-OptiPlex-Tower-Plus-7010>
References: <20241108022703.1877171-1-pengfei.li_1@nxp.com> <2350046.ElGaqSPkdT@steina-w> <Zy3gXvuWb76beZKo@pengfei-OptiPlex-Tower-Plus-7010>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi,

Am Freitag, 8. November 2024, 10:56:46 CET schrieb Pengfei Li:
> On Thu, Nov 07, 2024 at 01:49:50PM +0100, Alexander Stein wrote:
> > Hi,
> >=20
> > thanks for putting me on CC.
> >=20
> > Am Freitag, 8. November 2024, 03:27:02 CET schrieb Pengfei Li:
> > > The i.MX 91 family features an Arm Cortex-A55 running at up to
> > > 1.4GHz, support for modern LPDDR4 memory to enable platform longevity,
> > > along with a rich set of peripherals targeting medical, industrial
> > > and consumer IoT market segments.
> > >=20
> > > The design of the i.MX91 platform is very similar to i.MX93.
> > > The mainly difference between i.MX91 and i.MX93 is as follows:
> > > - i.MX91 removed some clocks and modified the names of some clocks.
> > > - i.MX91 only has one A core
> > >=20
> > > Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  arch/arm64/boot/dts/freescale/imx91-pinfunc.h | 770 ++++++++++++++++=
++
> > >  arch/arm64/boot/dts/freescale/imx91.dtsi      |  66 ++
> > >  2 files changed, 836 insertions(+)
> > >  create mode 100644 arch/arm64/boot/dts/freescale/imx91-pinfunc.h
> > >  create mode 100644 arch/arm64/boot/dts/freescale/imx91.dtsi
> > >=20
> > > diff --git a/arch/arm64/boot/dts/freescale/imx91-pinfunc.h b/arch/arm=
64/boot/dts/freescale/imx91-pinfunc.h
> > > new file mode 100644
> > > index 000000000000..bc58ce2102b2
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/freescale/imx91-pinfunc.h
> >=20
> > FWIW this is a 1:1 copy from downstream kernel
>=20
> Hi, thanks for the comments.
>=20
> Yes, it is same as downstream kernel.
>=20
> >=20
> > > diff --git a/arch/arm64/boot/dts/freescale/imx91.dtsi b/arch/arm64/bo=
ot/dts/freescale/imx91.dtsi
> > > new file mode 100644
> > > index 000000000000..a9f4c1fe61cc
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/freescale/imx91.dtsi
> > > @@ -0,0 +1,66 @@
> > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > +/*
> > > + * Copyright 2024 NXP
> > > + */
> > > +
> > > +#include "imx91-pinfunc.h"
> > > +#include "imx93.dtsi"
> > > +
> > > +&{/thermal-zones/cpu-thermal/cooling-maps/map0} {
> > > +	cooling-device =3D
> > > +		<&A55_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> > > +};
> > > +
> > > +&clk {
> > > +	compatible =3D "fsl,imx91-ccm";
> > > +};
> > > +
> > > +&eqos {
> > > +	clocks =3D <&clk IMX91_CLK_ENET1_QOS_TSN_GATE>,
> > > +			<&clk IMX91_CLK_ENET1_QOS_TSN_GATE>,
> > > +			<&clk IMX91_CLK_ENET_TIMER>,
> > > +			<&clk IMX91_CLK_ENET1_QOS_TSN>,
> > > +			<&clk IMX91_CLK_ENET1_QOS_TSN_GATE>;
> > > +	assigned-clocks =3D <&clk IMX91_CLK_ENET_TIMER>,
> > > +				<&clk IMX91_CLK_ENET1_QOS_TSN>;
> > > +	assigned-clock-parents =3D <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
> > > +					<&clk IMX93_CLK_SYS_PLL_PFD0_DIV2>;
> >=20
> > Is it just me or is the alignment of new lines not matching?
>=20
> Not sure about others, the alignment on my side is correct.
>=20
> >=20
> >=20
> > > +};
> > > +
> > > +&fec {
> > > +	clocks =3D <&clk IMX91_CLK_ENET2_REGULAR_GATE>,
> > > +			<&clk IMX91_CLK_ENET2_REGULAR_GATE>,
> > > +			<&clk IMX91_CLK_ENET_TIMER>,
> > > +			<&clk IMX91_CLK_ENET2_REGULAR>,
> > > +			<&clk IMX93_CLK_DUMMY>;
> > > +	assigned-clocks =3D <&clk IMX91_CLK_ENET_TIMER>,
> > > +				<&clk IMX91_CLK_ENET2_REGULAR>;
> > > +	assigned-clock-parents =3D <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
> > > +					<&clk IMX93_CLK_SYS_PLL_PFD0_DIV2>;
> >=20
> > Here as well: Is it just me or is the alignment of new lines not matchi=
ng?
>=20
> Same as above.
>=20
> >=20
> > > +	assigned-clock-rates =3D <100000000>, <250000000>;
> > > +};
> > > +
> > > +&i3c1 {
> > > +	clocks =3D <&clk IMX93_CLK_BUS_AON>,
> > > +			<&clk IMX93_CLK_I3C1_GATE>,
> > > +			<&clk IMX93_CLK_DUMMY>;
> > > +};
> > > +
> > > +&i3c2 {
> > > +	clocks =3D <&clk IMX93_CLK_BUS_WAKEUP>,
> > > +			<&clk IMX93_CLK_I3C2_GATE>,
> > > +			<&clk IMX93_CLK_DUMMY>;
> > > +};
> > > +
> > > +&tmu {
> > > +	status =3D "disabled";
> >=20
> > Why does the TMU needs to be disabled instead of deleted?
>=20
> Actually, the i.MX91 also has a TMU, but the i.MX91 uses a different IP t=
han the i.MX93, so a new driver is required.
> However, this new driver is not applied yet on upstream kernel, so it is =
disabled here for now.

Then, the compatible should be changed as well.

> >=20
> > > +};
> > > +
> > > +/* i.MX91 only has one A core */
> > > +/delete-node/ &A55_1;
> > > +
> > > +/* i.MX91 not has cm33 */
> > > +/delete-node/ &cm33;
> > > +
> > > +/* i.MX91 not has power-domain@44461800 */
> > > +/delete-node/ &mlmix;
> > >=20
> >=20
> > Shouldn't the following node also be removed?
> > * mipi_csi
> > * dsi
> > * lvds_bridge
> > * lcdif_to_dsi
> > * lcdif_to_ldb
> >=20
> > Also in downstream kernel IMX91_CLK_MEDIA_AXI, which is IMX93_CLK_MEDIA=
_AXI
> > upstream, is set to 200 MHz. Is this applicable here as well?
> >=20
>=20
> For these nodes, it is only in the downstream kernel and not yet applied =
to the upstream kernel for i.MX93.
> So they cannot be removed in the upstream kernel yet.

Ah, sorry. They originated form my local changes. They need to be removed
later on when they get added to imx93 though.

Best regards,
Alexander

=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



