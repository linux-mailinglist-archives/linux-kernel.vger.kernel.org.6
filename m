Return-Path: <linux-kernel+bounces-260978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B39793B130
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0C551F21E87
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F005B15956C;
	Wed, 24 Jul 2024 12:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="S/Wcgq59";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="gRBlNP76"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015F3158A37;
	Wed, 24 Jul 2024 12:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721825962; cv=none; b=KcPeHnSVyeG7/CDemKTuWLz86IukBUmTyUjG5xxDjG8S1IJrII3U+lbriU1vrOnFlaPhdG8KnFxCyXnHf0gpUu4vqJOfbzMb0oGatd/cA0GAY7ky0QTFN3/6kUnbMQ2FIk9P7nvL5RuUdPbIPT9HDR+surefIHcSuOyvmwIAChA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721825962; c=relaxed/simple;
	bh=BG/dwMvgMNRX1JmywXfxAb5bKKmq1PcR9ZYOaeTWktI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lfNNtdfS0TxGfU39XGlj7ANji7rWkD5gNJg5v76wEe8NOdQb/ywmo1A65oAWyusawgnwICe4Yygk7wxNA6Qeg9OQH8Yh3C+NmMC4vuDQnylvPDlkFU2pLMo0nUyEOJeIG26zGmn2iYxjCiMnfH8rjXNwj1W7Z7q43qb+abB6szo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=S/Wcgq59; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=gRBlNP76 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1721825960; x=1753361960;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hv25ePapYAQ9rGCH8Sa4/dvjI6aBtQFGfXN2ENEDJR4=;
  b=S/Wcgq59McO0fZouj159macWyv5zt+pWIndm8/lrriB64BHBmESD2PoZ
   moNhu8caFoAylH6LxwV9beM6O+42nUcAMTlaQ7FFjfcf4kp20mQb3hCif
   rpEvkCEEsuA9wFK6ZVGMhywaHnzwQ/J0goZDOSHx71ku6utfvj7S4zG4P
   0QWs8gGt/+09O/SILqNnmiwlBJVlctfO96HP4C2vzxRlUglvSVBvyUrgY
   qyZhqBg750Ur024Bx44b6qZD+mVj521U2BakE1IGHPCpaSBGA1BG8o9B6
   TQ9msruvLh6OjX+iK3rpgIQ7M/1rUVGpt5rKHITM6U3oe9cYs6kRrfjfE
   Q==;
X-CSE-ConnectionGUID: y1KKMC8ZShGm4R4piPe0/Q==
X-CSE-MsgGUID: bC+h0Y4aRjGK0USJ5h27iQ==
X-IronPort-AV: E=Sophos;i="6.09,232,1716242400"; 
   d="scan'208";a="38058822"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 24 Jul 2024 14:59:12 +0200
X-CheckPoint: {66A0FAA0-28-4CE528BA-FB7867F1}
X-MAIL-CPID: A95C370CCC726801890E1031FD844832_2
X-Control-Analysis: str=0001.0A782F17.66A0FAA1.0028,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E433F166524;
	Wed, 24 Jul 2024 14:59:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1721825952; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Hv25ePapYAQ9rGCH8Sa4/dvjI6aBtQFGfXN2ENEDJR4=;
	b=gRBlNP76rZjAs4eTAyXmjj12eXJPZ3eb4rEQyDBFrLVHo2fFXc3xAXP01B4iyfEd9ak9gH
	GSZftq2oGEouFlSHlA92AV1mdvPQXO3hK3wh+WEYCmx6tNeUmVszqN0DNTlJVgePQmIvhk
	fyzqhkgsiRIvvh/DFUpHhHEpJZLnTrLlzN7KqcLV4OGxFJFAyIZUU7hqt8G5E62Pyfu0AG
	rxuvE1a0R4qQII1ex74AcfmgulNNtwK42SOLOlu60j33CS0YVGU0+aVq1J29Kg5yKW/LLT
	xmEqbvKr065ztBh6TBkotUoT6CLcCHDjJ+yHFAizO+UUFJpwnI1hkyrmPVXTTA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/14] arm64: dts: freescale: imx93-tqma9352: improve pad configuration
Date: Wed, 24 Jul 2024 14:58:49 +0200
Message-Id: <20240724125901.1391698-3-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724125901.1391698-1-alexander.stein@ew.tq-group.com>
References: <20240724125901.1391698-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

- disable PU/PD if already done with external resistors
- do not configure Schmitt Trigger for outputs
- do not configure DSE / FSEL for inputs

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 .../boot/dts/freescale/imx93-tqma9352.dtsi    | 56 +++++++++++--------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi b/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi
index 17ccf38ebd56..d07eca6526db 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi
@@ -162,55 +162,63 @@ &wdog3 {
 &iomuxc {
 	pinctrl_flexspi1: flexspi1grp {
 		fsl,pins = <
-			MX93_PAD_SD3_CMD__FLEXSPI1_A_SS0_B	0x3fe
-			MX93_PAD_SD3_CLK__FLEXSPI1_A_SCLK	0x3fe
-			MX93_PAD_SD3_DATA0__FLEXSPI1_A_DATA00	0x3fe
-			MX93_PAD_SD3_DATA1__FLEXSPI1_A_DATA01	0x3fe
-			MX93_PAD_SD3_DATA2__FLEXSPI1_A_DATA02	0x3fe
-			MX93_PAD_SD3_DATA3__FLEXSPI1_A_DATA03	0x3fe
+			/* FSEL 3  | DSE X6 */
+			MX93_PAD_SD3_CMD__FLEXSPI1_A_SS0_B	0x01fe
+			MX93_PAD_SD3_CLK__FLEXSPI1_A_SCLK	0x01fe
+			/* HYS | PU | FSEL 3  | DSE X6 */
+			MX93_PAD_SD3_DATA0__FLEXSPI1_A_DATA00	0x13fe
+			MX93_PAD_SD3_DATA1__FLEXSPI1_A_DATA01	0x13fe
+			/* HYS | FSEL 3  | DSE X6 (external PU) */
+			MX93_PAD_SD3_DATA2__FLEXSPI1_A_DATA02	0x11fe
+			MX93_PAD_SD3_DATA3__FLEXSPI1_A_DATA03	0x11fe
 		>;
 	};
 
 	pinctrl_lpi2c1: lpi2c1grp {
 		fsl,pins = <
-			MX93_PAD_I2C1_SCL__LPI2C1_SCL		0x40000b9e
-			MX93_PAD_I2C1_SDA__LPI2C1_SDA		0x40000b9e
+			/* SION | OD | FSEL 3 | DSE X4 */
+			MX93_PAD_I2C1_SCL__LPI2C1_SCL		0x4000199e
+			MX93_PAD_I2C1_SDA__LPI2C1_SDA		0x4000199e
 		>;
 	};
 
 	pinctrl_pca9451: pca9451grp {
 		fsl,pins = <
-			MX93_PAD_I2C2_SDA__GPIO1_IO03		0x1306
+			/* HYS | PU */
+			MX93_PAD_I2C2_SDA__GPIO1_IO03		0x1200
 		>;
 	};
 
 	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
 		fsl,pins = <
-			MX93_PAD_SD2_RESET_B__GPIO3_IO07	0x1306
+			/* FSEL 2 | DSE X2 */
+			MX93_PAD_SD2_RESET_B__GPIO3_IO07	0x106
 		>;
 	};
 
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
-			/* HYS | PU | PD | FSEL_3 | X5 */
-			MX93_PAD_SD1_CLK__USDHC1_CLK		0x17be
-			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x17be
-			/* HYS | PU | FSEL_3 | X5 */
-			MX93_PAD_SD1_CMD__USDHC1_CMD		0x13be
-			/* HYS | PU | FSEL_3 | X4 */
-			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x139e
-			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x139e
-			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x139e
-			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x139e
-			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x139e
-			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x139e
-			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x139e
-			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x139e
+			/* PD | FSEL 3 | DSE X5 */
+			MX93_PAD_SD1_CLK__USDHC1_CLK		0x5be
+			/* HYS | FSEL 0 | no drive */
+			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x1000
+			/* HYS | FSEL 3 | X5 */
+			MX93_PAD_SD1_CMD__USDHC1_CMD		0x11be
+			/* HYS | FSEL 3 | X4 */
+			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x119e
+			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x119e
+			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x119e
+			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x119e
+			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x119e
+			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x119e
+			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x119e
+			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x119e
 		>;
 	};
 
 	pinctrl_wdog: wdoggrp {
 		fsl,pins = <
+			/* PU | FSEL 1 | DSE X4 */
 			MX93_PAD_WDOG_ANY__WDOG1_WDOG_ANY	0x31e
 		>;
 	};
-- 
2.34.1


