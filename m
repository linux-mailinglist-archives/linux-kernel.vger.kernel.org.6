Return-Path: <linux-kernel+bounces-399908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBE89C0629
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 767DB284697
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FEF20FA8A;
	Thu,  7 Nov 2024 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="PoZbjKYE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="OvymNaxW"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A301EF087;
	Thu,  7 Nov 2024 12:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730983811; cv=none; b=q7J32uUG28hp1Z2vtw3dq1YynTdwCm3I+G5XShP8E1WAC2Qwodnn/BCnilMDhgnBcXZ22tVebrPK8xIUTKEIwbGCQk+4WD4qh6YAe49thHZzmc056vDZkW+pFFSgHo+h45UBgz1FUkvHiZhkeDL6hAVnhMDqzgWbUPKMX+akTBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730983811; c=relaxed/simple;
	bh=ynzNPieJ7yxZZ783JIzDriVrkQ0y/pSBGewzVyU7ruo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n9tz1L8hoJ2nhQceRykbGkmh9oLPRDFOQtYR+FuOppgft62KJvrrEG2n6aJukQRD1KPdk2amJUdIwTAgVc0bftssh5FNMcHKvV0q0SgeokjD757EMfamVMu0rRR1Eiu4fMd0Vsix71adZOGLUtWl3wkA5X5Wfh1ppdal+yHNvrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=PoZbjKYE; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=OvymNaxW reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1730983807; x=1762519807;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rVq9b6pcFOHREaNN9fex606hOk1inbkqT9uhtMs6aJA=;
  b=PoZbjKYEnRqkNtQn4sShsQxJts81SPUPGcFvtR/57lsxxN9d9JxWezt0
   2Ye3h59+qczOezyLNrIwF9aSHKU5ifnxHIpqxC5bFIFKzRApbmzR0E5vu
   omVbQH5ellXtm+37V763jvZ+8FBYKiUjA/268LwQguZ/P5HG79gry5lKw
   AeMLlPiCZCZisG1vSUMZFrDcGmVTVIoOxsDhFFRfpr/zS80TpuPEOT0rs
   aZAi529wxMryMJjRpiZykkvXg6+l2Nxodm9gpp5y2AJPn0pDb4NP9duE1
   Po0cfHsn2EpO/GIfHqnbvhMwbmQ+BAZUgppKacHcXpCi4r8CcCEs9tQDv
   g==;
X-CSE-ConnectionGUID: fz1iyEChRgivj0WuDUOC6A==
X-CSE-MsgGUID: zE11X43+SWGtsSl6cj6ZLg==
X-IronPort-AV: E=Sophos;i="6.12,266,1728943200"; 
   d="scan'208";a="39911625"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 07 Nov 2024 13:49:58 +0100
X-CheckPoint: {672CB776-13-90CD5875-E0265C0B}
X-MAIL-CPID: 5630CB42D6C5881B1DECA5A00818660C_3
X-Control-Analysis: str=0001.0A682F28.672CB776.00BE,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EF3F5160A41;
	Thu,  7 Nov 2024 13:49:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1730983793;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=rVq9b6pcFOHREaNN9fex606hOk1inbkqT9uhtMs6aJA=;
	b=OvymNaxWbHJgVj9vxdqQ3uuum2UfzC+CLSQ4JBH6IvTuTH3US6xD+qIv0XOF+o/LtsLBHk
	4xmrj5mW0Patp4egGwKF94z9YzISIS6JSBZvEaepmEaHbScQ6pQA6kYoUDjQHu1Z1tZWSV
	WGhp4dOkHMPiOsoTSIpeOUW2W1RfAdzLT8ERF8XRAShA1A4J94+TfaSEs8bp6GqvuKsfV4
	CFRhysC0O0JzhXJY5oGI38zGYyz/eUsGZkVsHdgNQEzDe0y8kdVWwvTV12HCuWtWh7D3w9
	D6PmzK9QdSH9RqRtdLTInBw4/J2dm8xY+x2avdzr8Pe1sBjdm9ENQRULKPTDiA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, Pengfei Li <pengfei.li_1@nxp.com>
Cc: joao.goncalves@toradex.com, frieder.schrempf@kontron.de, marex@denx.de, hvilleneuve@dimonoff.com, peng.fan@nxp.com, m.othacehe@gmail.com, mwalle@kernel.org, Max.Merchel@ew.tq-group.com, hiago.franco@toradex.com, tharvey@gateworks.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, ping.bai@nxp.com, ye.li@nxp.com, aisheng.dong@nxp.com, frank.li@nxp.com
Subject: Re: [PATCH 2/3] arm64: dts: freescale: Add i.MX91 dtsi support
Date: Thu, 07 Nov 2024 13:49:50 +0100
Message-ID: <2350046.ElGaqSPkdT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20241108022703.1877171-3-pengfei.li_1@nxp.com>
References: <20241108022703.1877171-1-pengfei.li_1@nxp.com> <20241108022703.1877171-3-pengfei.li_1@nxp.com>
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

thanks for putting me on CC.

Am Freitag, 8. November 2024, 03:27:02 CET schrieb Pengfei Li:
> The i.MX 91 family features an Arm Cortex-A55 running at up to
> 1.4GHz, support for modern LPDDR4 memory to enable platform longevity,
> along with a rich set of peripherals targeting medical, industrial
> and consumer IoT market segments.
>=20
> The design of the i.MX91 platform is very similar to i.MX93.
> The mainly difference between i.MX91 and i.MX93 is as follows:
> - i.MX91 removed some clocks and modified the names of some clocks.
> - i.MX91 only has one A core
>=20
> Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx91-pinfunc.h | 770 ++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx91.dtsi      |  66 ++
>  2 files changed, 836 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx91-pinfunc.h
>  create mode 100644 arch/arm64/boot/dts/freescale/imx91.dtsi
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx91-pinfunc.h b/arch/arm64/b=
oot/dts/freescale/imx91-pinfunc.h
> new file mode 100644
> index 000000000000..bc58ce2102b2
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx91-pinfunc.h

=46WIW this is a 1:1 copy from downstream kernel

> diff --git a/arch/arm64/boot/dts/freescale/imx91.dtsi b/arch/arm64/boot/d=
ts/freescale/imx91.dtsi
> new file mode 100644
> index 000000000000..a9f4c1fe61cc
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx91.dtsi
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#include "imx91-pinfunc.h"
> +#include "imx93.dtsi"
> +
> +&{/thermal-zones/cpu-thermal/cooling-maps/map0} {
> +	cooling-device =3D
> +		<&A55_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +};
> +
> +&clk {
> +	compatible =3D "fsl,imx91-ccm";
> +};
> +
> +&eqos {
> +	clocks =3D <&clk IMX91_CLK_ENET1_QOS_TSN_GATE>,
> +			<&clk IMX91_CLK_ENET1_QOS_TSN_GATE>,
> +			<&clk IMX91_CLK_ENET_TIMER>,
> +			<&clk IMX91_CLK_ENET1_QOS_TSN>,
> +			<&clk IMX91_CLK_ENET1_QOS_TSN_GATE>;
> +	assigned-clocks =3D <&clk IMX91_CLK_ENET_TIMER>,
> +				<&clk IMX91_CLK_ENET1_QOS_TSN>;
> +	assigned-clock-parents =3D <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
> +					<&clk IMX93_CLK_SYS_PLL_PFD0_DIV2>;

Is it just me or is the alignment of new lines not matching?


> +};
> +
> +&fec {
> +	clocks =3D <&clk IMX91_CLK_ENET2_REGULAR_GATE>,
> +			<&clk IMX91_CLK_ENET2_REGULAR_GATE>,
> +			<&clk IMX91_CLK_ENET_TIMER>,
> +			<&clk IMX91_CLK_ENET2_REGULAR>,
> +			<&clk IMX93_CLK_DUMMY>;
> +	assigned-clocks =3D <&clk IMX91_CLK_ENET_TIMER>,
> +				<&clk IMX91_CLK_ENET2_REGULAR>;
> +	assigned-clock-parents =3D <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
> +					<&clk IMX93_CLK_SYS_PLL_PFD0_DIV2>;

Here as well: Is it just me or is the alignment of new lines not matching?

> +	assigned-clock-rates =3D <100000000>, <250000000>;
> +};
> +
> +&i3c1 {
> +	clocks =3D <&clk IMX93_CLK_BUS_AON>,
> +			<&clk IMX93_CLK_I3C1_GATE>,
> +			<&clk IMX93_CLK_DUMMY>;
> +};
> +
> +&i3c2 {
> +	clocks =3D <&clk IMX93_CLK_BUS_WAKEUP>,
> +			<&clk IMX93_CLK_I3C2_GATE>,
> +			<&clk IMX93_CLK_DUMMY>;
> +};
> +
> +&tmu {
> +	status =3D "disabled";

Why does the TMU needs to be disabled instead of deleted?

> +};
> +
> +/* i.MX91 only has one A core */
> +/delete-node/ &A55_1;
> +
> +/* i.MX91 not has cm33 */
> +/delete-node/ &cm33;
> +
> +/* i.MX91 not has power-domain@44461800 */
> +/delete-node/ &mlmix;
>=20

Shouldn't the following node also be removed?
* mipi_csi
* dsi
* lvds_bridge
* lcdif_to_dsi
* lcdif_to_ldb

Also in downstream kernel IMX91_CLK_MEDIA_AXI, which is IMX93_CLK_MEDIA_AXI
upstream, is set to 200 MHz. Is this applicable here as well?

Best regards,
Alexander

=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



