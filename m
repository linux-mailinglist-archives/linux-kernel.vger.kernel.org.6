Return-Path: <linux-kernel+bounces-401761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 562EC9C1ED3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7100D1C217FA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6911F4267;
	Fri,  8 Nov 2024 14:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="OPQLluKc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Ap9IBUM2"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2991E907D;
	Fri,  8 Nov 2024 14:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731074882; cv=none; b=gG1RswrkbxXDp4D8I1tMB6jUk4zdKnJnx0l4sB32+XuPHqblSZGwfGg9I2TFdN/+XuZyNivbNd0La82sjh3D6pQ5pmym+CQcd2G/jPQ2WOFeQKAl2S9DsqfxA2COwVhmDX5Tpr3LAalGwydQSfvhBGYyCdc3O0z1a8t95zvRcOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731074882; c=relaxed/simple;
	bh=IV2jJwwPztBmVdNNo2UAGdXaR2jpn1yjxMdF+kIGC74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qYMNxBdnNXnZC7qYbpNoM70hXkO/fFmEZiqQbrQADH8PGY/yp2ayhyeDY2IN4R5molXt3dW6AeTaQooEuYgCEWvILMNf4qfXBYc5ws39w1/21p0+43OUhu8L7TkKun+UQ1UlkIq91xXEcRnW3ROFgTAcytuUx2XYu0izp7oCjzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=OPQLluKc; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Ap9IBUM2 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1731074879; x=1762610879;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s+Cyc37Aq2SqEqQNiVMSAKYIXK5UFxn2rcs0yp6pEPU=;
  b=OPQLluKcU+9U2SQC+TF1iax3Y7BXiR6vVaxHv+eJ8qhWILH2q5ZFkIZk
   2G2MAe22o66ImRQa6v1u2L1yKf+yI9M+FmNcm9UaQGzE4ppCRwRaZp31X
   tgPmS2NGlSHQ7QyUvsLTu7B4TO2/6lntX6q81b7DK3/M3WySWlQExlUF6
   G1qq7EvkagdxzwmTN1EkBG5d2XkNxr9SLwr+X3JzTngi2gLO+G87EG1jl
   Gcufnnsyhy4H20jeDyl59qAo0hBE+Ci5eFpGVPQeFEcdS+kXs+nTfeCHq
   +bDnsYnGNbHMgmeaMoNyYlPvwXDvb3C17F8FHc7N0rYajs7KsEDaxi9NB
   w==;
X-CSE-ConnectionGUID: RDdKthBGQN+7Kl3ZuVXfAA==
X-CSE-MsgGUID: HKOVV5zSTpy6vXPgHcraYA==
X-IronPort-AV: E=Sophos;i="6.12,138,1728943200"; 
   d="scan'208";a="39937306"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 08 Nov 2024 15:07:56 +0100
X-CheckPoint: {672E1B3C-1D-D31EDE1A-D52D6119}
X-MAIL-CPID: 055CE465A85CD3B3BFEBFFD4B4365DE4_5
X-Control-Analysis: str=0001.0A682F22.672E1B3C.00AB,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7A66E160F33;
	Fri,  8 Nov 2024 15:07:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1731074871;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=s+Cyc37Aq2SqEqQNiVMSAKYIXK5UFxn2rcs0yp6pEPU=;
	b=Ap9IBUM2OYs1Nzp8SCXNQopPY1ICjrAfq0TgeeuSVZXAgavVLvzdd7cguQ5dCRe6GaakbC
	u0t7Slv2OMHxGfyNU9qDGDmVicgKxICglbFChHZNQw39NmAw3bgVuD5PMDcxnhXIuos9aZ
	h9fhY9bQbRLYS3fGWeS2JqtWVacTlchFzjyWUl4wX7Va2wTyU4zVuFQdfaKTxuKK/SLUf9
	N62miwuRchBhkUGii15wUnSPiINg7McU7++RFlOH+BvgG7uXWsb0NMsYUpXKXXN3oJMV5r
	GfAU0g5ZJVowLSuATTQM6VAqq0LYU8DjmkAGNQwq6iJlL2GdIi4S0na1GwiOaA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Pengfei Li <pengfei.li_1@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-arm-kernel@lists.infradead.org, joao.goncalves@toradex.com, frieder.schrempf@kontron.de, marex@denx.de, hvilleneuve@dimonoff.com, peng.fan@nxp.com, m.othacehe@gmail.com, mwalle@kernel.org, Max.Merchel@ew.tq-group.com, hiago.franco@toradex.com, tharvey@gateworks.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, ping.bai@nxp.com, ye.li@nxp.com, aisheng.dong@nxp.com, frank.li@nxp.com
Subject: Re: [PATCH 2/3] arm64: dts: freescale: Add i.MX91 dtsi support
Date: Fri, 08 Nov 2024 15:07:50 +0100
Message-ID: <22489205.EfDdHjke4D@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <Zy3iogT7jOLEvf1S@pengfei-OptiPlex-Tower-Plus-7010>
References: <20241108022703.1877171-1-pengfei.li_1@nxp.com> <1907807.tdWV9SEqCh@steina-w> <Zy3iogT7jOLEvf1S@pengfei-OptiPlex-Tower-Plus-7010>
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

Am Freitag, 8. November 2024, 11:06:26 CET schrieb Pengfei Li:
> On Thu, Nov 07, 2024 at 02:06:27PM +0100, Alexander Stein wrote:
> > Am Donnerstag, 7. November 2024, 13:49:50 CET schrieb Alexander Stein:
> > > > diff --git a/arch/arm64/boot/dts/freescale/imx91.dtsi b/arch/arm64/=
boot/dts/freescale/imx91.dtsi
> > > > new file mode 100644
> > > > index 000000000000..a9f4c1fe61cc
> > > > --- /dev/null
> > > > +++ b/arch/arm64/boot/dts/freescale/imx91.dtsi
> > > > @@ -0,0 +1,66 @@
> > > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > > +/*
> > > > + * Copyright 2024 NXP
> > > > + */
> > > > +
> > > > +#include "imx91-pinfunc.h"
> > > > +#include "imx93.dtsi"
> > > > +
> > > > +&{/thermal-zones/cpu-thermal/cooling-maps/map0} {
> > > > +	cooling-device =3D
> > > > +		<&A55_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> > > > +};
> > > > +
> > > > +&clk {
> > > > +	compatible =3D "fsl,imx91-ccm";
> > > > +};
> > > > +
> > > > +&eqos {
> > > > +	clocks =3D <&clk IMX91_CLK_ENET1_QOS_TSN_GATE>,
> > > > +			<&clk IMX91_CLK_ENET1_QOS_TSN_GATE>,
> > > > +			<&clk IMX91_CLK_ENET_TIMER>,
> > > > +			<&clk IMX91_CLK_ENET1_QOS_TSN>,
> > > > +			<&clk IMX91_CLK_ENET1_QOS_TSN_GATE>;
> > > > +	assigned-clocks =3D <&clk IMX91_CLK_ENET_TIMER>,
> > > > +				<&clk IMX91_CLK_ENET1_QOS_TSN>;
> > > > +	assigned-clock-parents =3D <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
> > > > +					<&clk IMX93_CLK_SYS_PLL_PFD0_DIV2>;
> > >=20
> > > Is it just me or is the alignment of new lines not matching?
> > >=20
> > >=20
> > > > +};
> > > > +
> > > > +&fec {
> > > > +	clocks =3D <&clk IMX91_CLK_ENET2_REGULAR_GATE>,
> > > > +			<&clk IMX91_CLK_ENET2_REGULAR_GATE>,
> > > > +			<&clk IMX91_CLK_ENET_TIMER>,
> > > > +			<&clk IMX91_CLK_ENET2_REGULAR>,
> > > > +			<&clk IMX93_CLK_DUMMY>;
> > > > +	assigned-clocks =3D <&clk IMX91_CLK_ENET_TIMER>,
> > > > +				<&clk IMX91_CLK_ENET2_REGULAR>;
> > > > +	assigned-clock-parents =3D <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
> > > > +					<&clk IMX93_CLK_SYS_PLL_PFD0_DIV2>;
> > >=20
> > > Here as well: Is it just me or is the alignment of new lines not matc=
hing?
> > >=20
> > > > +	assigned-clock-rates =3D <100000000>, <250000000>;
> > > > +};
> > > > +
> > > > +&i3c1 {
> > > > +	clocks =3D <&clk IMX93_CLK_BUS_AON>,
> > > > +			<&clk IMX93_CLK_I3C1_GATE>,
> > > > +			<&clk IMX93_CLK_DUMMY>;
> > > > +};
> > > > +
> > > > +&i3c2 {
> > > > +	clocks =3D <&clk IMX93_CLK_BUS_WAKEUP>,
> > > > +			<&clk IMX93_CLK_I3C2_GATE>,
> > > > +			<&clk IMX93_CLK_DUMMY>;
> > > > +};
> > > > +
> > > > +&tmu {
> > > > +	status =3D "disabled";
> > >=20
> > > Why does the TMU needs to be disabled instead of deleted?
> > >=20
> > > > +};
> > > > +
> > > > +/* i.MX91 only has one A core */
> > > > +/delete-node/ &A55_1;
> > > > +
> > > > +/* i.MX91 not has cm33 */
> > > > +/delete-node/ &cm33;
> > > > +
> > > > +/* i.MX91 not has power-domain@44461800 */
> > > > +/delete-node/ &mlmix;
> > > >=20
> > >=20
> > > Shouldn't the following node also be removed?
> > > * mipi_csi
> > > * dsi
> > > * lvds_bridge
> > > * lcdif_to_dsi
> > > * lcdif_to_ldb
> >=20
> > Add mu1 and mu2 to that list.
>=20
> Hi, i.MX91 also has mu1 and mu2. so there is no need to remove them here.

Maybe you have more recent information. The RM available to me doesn't
say anything about messaging unit, neither in memory map nor as a separate
section describing the hardware. Memory area is marked as reserved.

If there are actually mu1 and mu2 available, what is on the B-side? There
is no Cortex-M33 after all.

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



