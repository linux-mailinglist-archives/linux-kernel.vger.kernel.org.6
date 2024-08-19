Return-Path: <linux-kernel+bounces-292037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF338956A66
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00D551C237DA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C0116E870;
	Mon, 19 Aug 2024 12:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="CzBkwdWO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Ptm6UHb4"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2F416C438;
	Mon, 19 Aug 2024 12:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724069097; cv=none; b=CPGjFL2RkIAjs3wGFPkl5iQU7A9hlwqmhEqAM9eMUYunIaK/KqdnrVvbpreJy6brp393xr31Nsp9v8QNioUBimsAExo5hcAuWhsc1GQGfx5r/ekHQqzYAz63llSb/LbMldDtmqjkqJQyzThO2WDsXyrEYpJGwbUNaEc7Rz6fGJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724069097; c=relaxed/simple;
	bh=r+EK16k+0OcYTQsoxzEajdx0kI0EJakC5dlFLmN59Dc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R/WsUAeoryUJlAWD3l3R3cbgFMVF3zKB/beP8YAd/XD/L3t/5H57oS1zdj+YF/X56XmafCufahqO3DbR+XLLYWAK68jMJsZBsZYAVrU/e8tmR/G8cMx55sgCYE/fRo3iyY8p9cQGOQBeY8+2ejXslgLmaBoyCfnuoK3hO0WH6FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=CzBkwdWO; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Ptm6UHb4 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1724069096; x=1755605096;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JumtuzK8XLrkvwXQmvob2btUs9cZwoIh8escPZtwZ2M=;
  b=CzBkwdWOD8Qoe+fT9JUnhvbx8pp9fs1Jzw9Msd+LjlmIkLJlJ4l4FthU
   HOYN4eb1wYtTPTX9CLoFmbXRy8DT3TMK9nMsR301jkoVJww1dh1HSqe8U
   WvwmAUysGWgGR9L2QOIYs175ciASGDhZSjwwMlNEt7KqLn0/w8tst6lBm
   wKevSLD/EXTYQW1s3rtM8hKvpgkM3lLX/lbRtdtt8TWg0VN1Nfu8QBbCN
   LUg6RQ1FTe679lsZmhHUxLTmglctR556VHlpTAxXfx/55g0F32p51G5uB
   dwnFqZ6b1pWmddU5rK6lAhetiDpTFYDbAp2owN6q408vSk98Q6LhsKmdG
   A==;
X-CSE-ConnectionGUID: H6ylRNp4QGOYzmWAkP3+0g==
X-CSE-MsgGUID: /m5zX0iyQGO0UST+0rz0jw==
X-IronPort-AV: E=Sophos;i="6.10,159,1719871200"; 
   d="scan'208";a="38467155"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 19 Aug 2024 14:04:55 +0200
X-CheckPoint: {66C334E7-2-2C7A84BB-EFCBC4CF}
X-MAIL-CPID: 044AA1D7A1F585426253344FFDE0D044_2
X-Control-Analysis: str=0001.0A782F1D.66C334E7.0043,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E89D9168943;
	Mon, 19 Aug 2024 14:04:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1724069090; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=JumtuzK8XLrkvwXQmvob2btUs9cZwoIh8escPZtwZ2M=;
	b=Ptm6UHb4n6hSq52LmHYASzQjRBZxZRJAtJTo7UGhEDQrTng0PUUyYiyQNjk1wIIK83r5Kg
	zG4tp2T8xcIPT9NeYTPwoc0TKjYvYiWN4WlXOK8iUrMHieP6fCDKYCcKU/eRyxZTxPF819
	tjDJQ3cH4zdzwP7Ss+57zqaYdXxp4lqmOebSlaKTD8lHrWU69YYmTH27eb83R1Q3MX3B79
	Dzc0za5d4h+FxxZNbo/WWNsj1vXdy7IQTJIaiHcABI5p+kPfEf5kIou1tRGzBu4oMV5ioh
	kijTElMn04Ez2vZpykSA3Q2zq4RfQJqWw3Vah0DKfwZBNTDy+9DN4Awy8nV5cg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [PATCH v2 14/14] arm64: dts: freescale: imx93-tqma9352: set SION for cmd and data pad of USDHC
Date: Mon, 19 Aug 2024 14:03:28 +0200
Message-Id: <20240819120328.229622-15-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819120328.229622-1-alexander.stein@ew.tq-group.com>
References: <20240819120328.229622-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

imx93 pad integrate has one issue, refer to ERR052021:

ERR052021 uSDHC: Sometimes uSDHC does not work under VDD_SOC low
		 drive mode and nominal mode
Description:
uSDHC PADs have one integration issue.
When CMD/DATA lines direction change from output to input, uSDHC
controller begin sampling, the integration issue will make input
enable signal from uSDHC propagated to the PAD with a long delay,
thus the new input value on the pad comes to uSDHC lately. The
uSDHC sampled the old input value and the sampling result is wrong.

Workaround:
Set uSDHC CMD/DATA PADs iomux register SION bit to 1, then PADs will
propagate input to uSDHC with no delay, so correct value is sampled.

This issue will wrongly trigger the start bit when sample the USDHC
command response, cause the USDHC trigger command CRC/index/endbit
error, which will finally impact the tuning pass window, espically
will impact the standard tuning logic, and can't find a correct delay
cell to get the best timing.

This follows changes made for i.MX93 EVK with commit bb89601282fc ("arm64:
dts: imx93-11x11-evk: set SION for cmd and data pad of USDHC")

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 .../freescale/imx93-tqma9352-mba93xxca.dts    | 22 ++++++++++---------
 .../freescale/imx93-tqma9352-mba93xxla.dts    | 22 ++++++++++---------
 .../boot/dts/freescale/imx93-tqma9352.dtsi    | 19 ++++++++--------
 3 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
index 79b9f13de4af5..599df32976e24 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
@@ -870,32 +870,34 @@ MX93_PAD_SD2_CD_B__GPIO3_IO00			0x1000
 		>;
 	};
 
+	/* enable SION for data and cmd pad due to ERR052021 */
 	pinctrl_usdhc2_hs: usdhc2hsgrp {
 		fsl,pins = <
 			/* PD | FSEL_3 | DSE X5 */
 			MX93_PAD_SD2_CLK__USDHC2_CLK			0x05be
 			/* HYS | PU | FSEL_3 | DSE X4 */
-			MX93_PAD_SD2_CMD__USDHC2_CMD			0x139e
+			MX93_PAD_SD2_CMD__USDHC2_CMD			0x4000139e
 			/* HYS | PU | FSEL_3 | DSE X3 */
-			MX93_PAD_SD2_DATA0__USDHC2_DATA0		0x138e
-			MX93_PAD_SD2_DATA1__USDHC2_DATA1		0x138e
-			MX93_PAD_SD2_DATA2__USDHC2_DATA2		0x138e
-			MX93_PAD_SD2_DATA3__USDHC2_DATA3		0x138e
+			MX93_PAD_SD2_DATA0__USDHC2_DATA0		0x4000138e
+			MX93_PAD_SD2_DATA1__USDHC2_DATA1		0x4000138e
+			MX93_PAD_SD2_DATA2__USDHC2_DATA2		0x4000138e
+			MX93_PAD_SD2_DATA3__USDHC2_DATA3		0x4000138e
 			/* FSEL_2 | DSE X3 */
 			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT		0x010e
 		>;
 	};
 
+	/* enable SION for data and cmd pad due to ERR052021 */
 	pinctrl_usdhc2_uhs: usdhc2uhsgrp {
 		fsl,pins = <
 			/* PD | FSEL_3 | DSE X6 */
 			MX93_PAD_SD2_CLK__USDHC2_CLK			0x05fe
 			/* HYS | PU | FSEL_3 | DSE X4 */
-			MX93_PAD_SD2_CMD__USDHC2_CMD			0x139e
-			MX93_PAD_SD2_DATA0__USDHC2_DATA0		0x139e
-			MX93_PAD_SD2_DATA1__USDHC2_DATA1		0x139e
-			MX93_PAD_SD2_DATA2__USDHC2_DATA2		0x139e
-			MX93_PAD_SD2_DATA3__USDHC2_DATA3		0x139e
+			MX93_PAD_SD2_CMD__USDHC2_CMD			0x4000139e
+			MX93_PAD_SD2_DATA0__USDHC2_DATA0		0x4000139e
+			MX93_PAD_SD2_DATA1__USDHC2_DATA1		0x4000139e
+			MX93_PAD_SD2_DATA2__USDHC2_DATA2		0x4000139e
+			MX93_PAD_SD2_DATA3__USDHC2_DATA3		0x4000139e
 			/* FSEL_2 | DSE X3 */
 			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT		0x010e
 		>;
diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
index 3f8726180bba2..0b4b3bb866d06 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
@@ -832,32 +832,34 @@ MX93_PAD_SD2_CD_B__GPIO3_IO00			0x1000
 		>;
 	};
 
+	/* enable SION for data and cmd pad due to ERR052021 */
 	pinctrl_usdhc2_hs: usdhc2hsgrp {
 		fsl,pins = <
 			/* PD | FSEL_3 | DSE X5 */
 			MX93_PAD_SD2_CLK__USDHC2_CLK			0x05be
 			/* HYS | PU | FSEL_3 | DSE X4 */
-			MX93_PAD_SD2_CMD__USDHC2_CMD			0x139e
+			MX93_PAD_SD2_CMD__USDHC2_CMD			0x4000139e
 			/* HYS | PU | FSEL_3 | DSE X3 */
-			MX93_PAD_SD2_DATA0__USDHC2_DATA0		0x138e
-			MX93_PAD_SD2_DATA1__USDHC2_DATA1		0x138e
-			MX93_PAD_SD2_DATA2__USDHC2_DATA2		0x138e
-			MX93_PAD_SD2_DATA3__USDHC2_DATA3		0x138e
+			MX93_PAD_SD2_DATA0__USDHC2_DATA0		0x4000138e
+			MX93_PAD_SD2_DATA1__USDHC2_DATA1		0x4000138e
+			MX93_PAD_SD2_DATA2__USDHC2_DATA2		0x4000138e
+			MX93_PAD_SD2_DATA3__USDHC2_DATA3		0x4000138e
 			/* FSEL_2 | DSE X3 */
 			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT		0x010e
 		>;
 	};
 
+	/* enable SION for data and cmd pad due to ERR052021 */
 	pinctrl_usdhc2_uhs: usdhc2uhsgrp {
 		fsl,pins = <
 			/* PD | FSEL_3 | DSE X6 */
 			MX93_PAD_SD2_CLK__USDHC2_CLK			0x05fe
 			/* HYS | PU | FSEL_3 | DSE X4 */
-			MX93_PAD_SD2_CMD__USDHC2_CMD			0x139e
-			MX93_PAD_SD2_DATA0__USDHC2_DATA0		0x139e
-			MX93_PAD_SD2_DATA1__USDHC2_DATA1		0x139e
-			MX93_PAD_SD2_DATA2__USDHC2_DATA2		0x139e
-			MX93_PAD_SD2_DATA3__USDHC2_DATA3		0x139e
+			MX93_PAD_SD2_CMD__USDHC2_CMD			0x4000139e
+			MX93_PAD_SD2_DATA0__USDHC2_DATA0		0x4000139e
+			MX93_PAD_SD2_DATA1__USDHC2_DATA1		0x4000139e
+			MX93_PAD_SD2_DATA2__USDHC2_DATA2		0x4000139e
+			MX93_PAD_SD2_DATA3__USDHC2_DATA3		0x4000139e
 			/* FSEL_2 | DSE X3 */
 			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT		0x010e
 		>;
diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi b/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi
index 48ba60832eb3e..2cabdae242273 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi
@@ -270,6 +270,7 @@ MX93_PAD_SD2_RESET_B__GPIO3_IO07	0x106
 		>;
 	};
 
+	/* enable SION for data and cmd pad due to ERR052021 */
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			/* PD | FSEL 3 | DSE X5 */
@@ -277,16 +278,16 @@ MX93_PAD_SD1_CLK__USDHC1_CLK		0x5be
 			/* HYS | FSEL 0 | no drive */
 			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x1000
 			/* HYS | FSEL 3 | X5 */
-			MX93_PAD_SD1_CMD__USDHC1_CMD		0x11be
+			MX93_PAD_SD1_CMD__USDHC1_CMD		0x400011be
 			/* HYS | FSEL 3 | X4 */
-			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x119e
-			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x119e
-			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x119e
-			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x119e
-			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x119e
-			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x119e
-			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x119e
-			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x119e
+			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x4000119e
+			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x4000119e
+			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x4000119e
+			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x4000119e
+			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x4000119e
+			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x4000119e
+			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x4000119e
+			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x4000119e
 		>;
 	};
 
-- 
2.34.1


