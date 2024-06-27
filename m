Return-Path: <linux-kernel+bounces-233073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE0691B1ED
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 00:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F729285401
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 22:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201C11A3BB6;
	Thu, 27 Jun 2024 22:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qUYzlT83"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2041.outbound.protection.outlook.com [40.107.241.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D39E1A38D6;
	Thu, 27 Jun 2024 22:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719525637; cv=fail; b=feiVE2KdfTJyF+JVtkB5xmNkElxZ2IV8z0k2KGVmOSC0InPMtG8lIiXpcqhBeS/KVFF/C83k/dK2/W4DVeK9YjGdvYxZMIZGB6YZrwL/d3EMMj6B0/VrV8m3SdqMvAvl5LhSiL4OpevvlfwwADLZfT7cb60DFAr38aVvG9kk0Yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719525637; c=relaxed/simple;
	bh=o6hiuXedRx9JglRbVuBqOh+PVMg3BIMB21TBNyXbWpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Iy+OLKZtkFmo9s+X2IHS1TJJ5nHz5AdaTcXMJ+Uw4qKivYcuxIp7YSEUzh0ahNbRmOpg6ms4mA1qZq324Pcuf6FpFM6UTpK/g30bVO3GQ0e4vGGXgfR0N9oEgOaY7kAwqkXHRl6X4qX77ukdXSoGSb5aIUNPhmGskA9w+vqLjjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=qUYzlT83; arc=fail smtp.client-ip=40.107.241.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjSsNu8M642y0MMb5mrWlgZ2HCk/Q9LtP6v2dOBuYCWItOZCFVGB01ewUKVGi2z0hg3fh+zdGqteUf78g5NsggxGbTAb2on5E91bG2HkUXRGCuxuC6eZn2HPGI4O4Y/6hBeRcsjv2yEKMCQUdKSgng81RJgJIIdbdt2RFpxTnOFZ+UZg6a7zUTRrBAMYiErjVynOSXuIC2NCadBqbIL2U1cmnyocVTAudgfIpgjYLG7Kc3nHiiRCfKa80tRD8IeNTSnZDzD62QmEeyTZSCCELtTqIHUMjt0zLky1sjUzEdN64kUQVzn9kjZ/6X5w6qNtupY8XGl7HlNjjC72q7m77A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNfWPBbn480Wqd+8f4Ey7HkdDTmU61syZJI42fZcyrQ=;
 b=CK1yI15zjDAKee5qNfZjPHg7Bl1+75/r0HyiIxoYhzCTsYvh6FqgtdL1g6cL1pQPiSHniafA/ub18DlcKGgEizsTRWKz9zsRuIpO9swPVN6t5Qnl5iH/F51z287YNatMY32VV9IJ3bIb4ouQOVZb/jOTWotSRyQh3uWK024GSVuAo6E1zjVZkHdWoQAmI7bKo3+YHlNjI0gJn8UcTeMz8Owkgb+Jub8Xs+ZggIRsa4ymE/M1iE/7HRwBa83WZ3DsIUXx1npuhhDIDFM6hxVEfLPM8BkR/QBr+GE8RfBcGThp4rtlqCeXSWTxw9eXYuxxoncTN9Mg3Elgg0wJdyo/BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNfWPBbn480Wqd+8f4Ey7HkdDTmU61syZJI42fZcyrQ=;
 b=qUYzlT83RpwHP2NpmR5YqcO9cMGdxftzyxrSRz9FgyTWKm54Lj6eRGGQ1EQZeObjT6SU8280NXqBAnka9jieCxAGf1OKM4Gu6wrz5t8w5nA0dUGwbIv6gm6iW3xbwR0YY4EfAH+TTEDapYIRMSxrZ02PAfaPnkRfyLCIphOT5LU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7259.eurprd04.prod.outlook.com (2603:10a6:102:8a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 22:00:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 22:00:29 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 7/7] arm64: dts: imx95-19x19-evk: add pwm fan control
Date: Thu, 27 Jun 2024 18:00:01 -0400
Message-Id: <20240627220001.692875-7-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627220001.692875-1-Frank.Li@nxp.com>
References: <20240627220001.692875-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0286.namprd03.prod.outlook.com
 (2603:10b6:610:e6::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: 359b8ea2-3199-4ff7-eabd-08dc96f48ecf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|7416014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q4zU7OLpjScCDzMWMnlXVVAeCt6VBZiJR5Aj9KkkD8FZ5zjxXVn5XsKj188a?=
 =?us-ascii?Q?YDtq+RA9qwOSjQBsjQUWvHWqbe5Epwc0zTGWoR/GnXMomFWC5Ubl7TWW1mC4?=
 =?us-ascii?Q?6LAv5UMva4GSDtvujdoe4YKCrfPwCigRvCde9NNa3m90idQUFucHNHuhrF51?=
 =?us-ascii?Q?wFtj7G7VFAQoA/t6sZZtdCSHVGbGv5ArFnUTHhtERZ/UqYlOVAx+QmcUvVl1?=
 =?us-ascii?Q?Pqo3SKnpuBn3SD2iR/lVqRGeRdWG1tMH2JHcjW1JYeBVo9/xRTE9HeuH6FR2?=
 =?us-ascii?Q?jhN19j+zMQYdCS+W8MTcFe31jJn2aICvPplsFKFErzlubajEA3xz7MQ3/lAQ?=
 =?us-ascii?Q?NDVIfYdip58IgBlq9XG2Qo5DjnTzcwE3WtL9Ct+nG7fxPJWzZGr9IwBxx6go?=
 =?us-ascii?Q?pt7BYj9kXKM+HoqjKGnBZTZ6s4QHohvgAwZ5DRNudlUYtO1Gf3ZJIsB6nF14?=
 =?us-ascii?Q?p6U2EHBVI3sBg/Csbxo4JBsDpnEwF1u7kTXUZZAts5Z9q7GClfbZKVtSTmEQ?=
 =?us-ascii?Q?HgVuIn212yS+O6nemIJvQ1Ud1ZxchXQesOrwrdZ+9qmYVzafEHKwg3TpS4j9?=
 =?us-ascii?Q?y8onUw4aNMnT6u1aNTutnNrqYbpBqPgKXeix90ZeQn9uZeapismz8WjHeuUn?=
 =?us-ascii?Q?Hsb2PsKSr9TsZmnFw5r0v7Bji3qHyxHbRDDB1rZ3gOTAxa+xWF1flqp1a2pl?=
 =?us-ascii?Q?NRnKJlYIUtcsm2nZ+prygt0O9zD4dGNKAPYFWvXD5px+4XFDQf2U+WxjzKYB?=
 =?us-ascii?Q?DmyfBjTX5crM/FrQCemZJDUGgdj2LgZ05h2XFjolPHC5TQlYHXG1zvGJ4aTD?=
 =?us-ascii?Q?C34rQep6/lSsXfYw9y2wrFY1dINxzDGDnuDUhVEzEpUWRr5e1duOkfLgORdc?=
 =?us-ascii?Q?pIFgS6z+WC03O0Yl+mciK7Qu/qY49WEPv2UWTo84K1J1Ye9h2z4tnU60icFe?=
 =?us-ascii?Q?X/Cahuj7kt7JQnttLGzP9xkAboft9N0HIvvqL6eVr4WC37eRNklVVMXScN6c?=
 =?us-ascii?Q?OmSRimNoRQpFiJind2lhHuIhOwZB4sfk8ev2b4EXIYTgM+gssKVWvrDeJ5mT?=
 =?us-ascii?Q?BWowD/70G7q+eGZZ6jKLtb+jh11+BrKdnuEu/Keu2R7nGHOvkDdwqeHxdn57?=
 =?us-ascii?Q?bPzoagz47H2G8eWI4efy4IsB2Yk0CuESP1hV77kSxuRG9Uhg7/LLO6L2dz+K?=
 =?us-ascii?Q?NHceSMNBGNVEGDv1Hfdgq9a7Z/+YIiSUmu7s5CK+4x4QCBnolFFGLSHdg4zw?=
 =?us-ascii?Q?9YYwj+3h9cGfjelXgn8LQQc8cX7OU7tYTNXXLbWWZzYaYWRVFGhT1wrpkBiL?=
 =?us-ascii?Q?sXe2J8AWsSbrO5VP30vphfVNJyUZC1St3VyCN/JEUoAFBRSM8zS96cZ81Zji?=
 =?us-ascii?Q?AFAmszU0/jPIk72PFijAg6F8ypBA8swxa8Rq9baW8TS28uwYUXZtk5+eEZh/?=
 =?us-ascii?Q?rehyI+humOU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(7416014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vWYPs4HvWfDxNp7B5DNssA74Q/1bgneDU2JSOC/Yh71Vz1hV+rqE7QtVYOv2?=
 =?us-ascii?Q?WW6mrOyg05dLJIVEe6LKHnAX2h7AEzaeHdUg/lVxS0Mxc66w1nVPhs9t2Y5T?=
 =?us-ascii?Q?2255fh/DdanhKZd9hUdgZ2765vXjQMkAy0egskgdvEMI27qPDiPi0e60l50r?=
 =?us-ascii?Q?JVcRIC6/WeoB/UiqVNGOzWuRnQy/HF/Pgg0UxY8aMSFPDAZ8tJYxKk1xHvxb?=
 =?us-ascii?Q?Rf2cknvVjCv/5X4ioZJRMn0qGQaYwfCRa28s5sZLmWya9V3Gzvfeo8KFqLSr?=
 =?us-ascii?Q?LpA6ginkp2UJ14F1dBVSsTbJTSXtSwZIflDduXqcfxPevLsk5X2V6I6ZWdXj?=
 =?us-ascii?Q?sa86Kr8bSZRNtN7OphG+ifEYAsb85XEeVrKYqoWPT1Vu08OlTva/sjUfoWFv?=
 =?us-ascii?Q?8CJSm9nEDI1sfEQUmy5xYV5H4t2kdi/ZAzXxV2Z9VufpOySlx+BPStSdMjrC?=
 =?us-ascii?Q?1+pOhyXBpflnyitY1mGe6rmiTBBkcCWE0sTQAngvJeAIAOiyztJe8FJPHWum?=
 =?us-ascii?Q?KKXjzXZt3amse6RiEFFX/pxBlT9F86q4kpkr/dqGqMCVdKMK3IxsBfDj5sFF?=
 =?us-ascii?Q?Ao3YdEYFY9eFEeBnLp4F/3z6+SYygukSx2UIXjH64xIdh8yO9emKtuakaSFj?=
 =?us-ascii?Q?E/32P7ZgeQHBO39bduNnnVyijk9mBQzldXXNzjxY0hfAT7EDu1YyiM+tkBcm?=
 =?us-ascii?Q?B87FKmp/8JgyC7MtSV+OwYBfyKCm98ShScU8xlMlTgUGZcGV/ZjwF73SfY1J?=
 =?us-ascii?Q?+zcCO3PO8sIvNzBlLaiCr5SNj3Oqg/I4jN/KolY8SfTvKCJgpybsKvSAgiCr?=
 =?us-ascii?Q?9YQRBgg7EcobR1DomJIIpmSvfqIWlRxoDuE3+8NAago1y6ec3uTflswhVikf?=
 =?us-ascii?Q?gd+BHFD+RRRrrlOJiVGlM4ckHaqbNiQ3uERfV4Ri4nVSESXXHbW8bOimu21o?=
 =?us-ascii?Q?STMVehhoAr/+owOb4Gx9FrnnmBL2EJksmDkOLO2qTvj2oq+b4CK6MSO9ZpdI?=
 =?us-ascii?Q?zy8gYI61lGSq6VlKSmpbTVMu0AvWXtPnDyAGflgQtXpMW8582uR7DnV+L655?=
 =?us-ascii?Q?Y2OMEVmFwnInTi8VEdQ+Oki0FkOgv54WOBxA2D2iySUVHr/rLD8jOaHM7uIV?=
 =?us-ascii?Q?STpDdMrUF5RNphb0arf5z0EeH+FXJuyO1p28b8hr3b30jID06QEwL6NO1hWY?=
 =?us-ascii?Q?16gs/NTSv+M+zcesIAcs6hzcThQw49WvwXIk7BtkSIT3on8h/JS11Mmx0eyY?=
 =?us-ascii?Q?1Wq0hNOvLlLN4mfOk8FbTOHqHuFYFADwC3f+nr1R/ookgVIhPwqH2h+XB+W2?=
 =?us-ascii?Q?9q2zPAuWW0c6ugUCtRPUcFCwbUFlqVO025Bc/3UXpwFN8pFCQ5qEYoKCrkyL?=
 =?us-ascii?Q?cBcWmn31/grafWjdXoHIQcDPjYVkwqA2giQjs5Rre+tiaB9X4RQt3HDIFIM3?=
 =?us-ascii?Q?We1hI9k2PrGCbY2vATy7yOhiEXA3ORxgezyyzmy0dy9MDfFX3Z578H68wyWJ?=
 =?us-ascii?Q?xBkjwrFvwRmKK47TOudfY2T1e8PDfM/v+0r0X9/D6/z2L+u8FJ/CY47vniLz?=
 =?us-ascii?Q?0fSgRUBraH3J+D6ki3U=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 359b8ea2-3199-4ff7-eabd-08dc96f48ecf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 22:00:29.3139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QzSYKvwzoxd5Ff7eRFvCIgxskItFw4jb454bnZwVRuMEEblhFQUuNaYkgdJruPfxYBK5a+iz/XoAudkVNJ5Jcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7259

Add pwm fan and overwrite default thermal nodes.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../boot/dts/freescale/imx95-19x19-evk.dts    | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
index ed8921d6217b8..0c84efd058ce1 100644
--- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/pwm/pwm.h>
 #include "imx95.dtsi"
 
 / {
@@ -31,6 +32,13 @@ memory@80000000 {
 		reg = <0x0 0x80000000 0 0x80000000>;
 	};
 
+	fan0: pwm-fan {
+		compatible = "pwm-fan";
+		#cooling-cells = <2>;
+		pwms = <&tpm6 2 4000000 PWM_POLARITY_INVERTED>;
+		cooling-levels = <64 128 192 255>;
+	};
+
 	reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -558,3 +566,44 @@ IMX95_PAD_SD2_VSELECT__USDHC2_VSELECT		0x51e
 		>;
 	};
 };
+
+&thermal_zones {
+	a55-thermal {
+		trips {
+			atrip2: trip2 {
+				temperature = <55000>;
+				hysteresis = <2000>;
+				type = "active";
+			};
+
+			atrip3: trip3 {
+				temperature = <65000>;
+				hysteresis = <2000>;
+				type = "active";
+			};
+
+			atrip4: trip4 {
+				temperature = <75000>;
+				hysteresis = <2000>;
+				type = "active";
+			};
+		};
+
+		cooling-maps {
+			map1 {
+				trip = <&atrip2>;
+				cooling-device = <&fan0 0 1>;
+			};
+
+			map2 {
+				trip = <&atrip3>;
+				cooling-device = <&fan0 1 2>;
+			};
+
+			map3 {
+				trip = <&atrip4>;
+				cooling-device = <&fan0 2 3>;
+			};
+		};
+	};
+};
-- 
2.34.1


