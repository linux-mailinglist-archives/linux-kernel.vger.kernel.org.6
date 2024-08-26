Return-Path: <linux-kernel+bounces-300801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F70C95E89F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6B492815F9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C446013A250;
	Mon, 26 Aug 2024 06:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="TIviubcw"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2066.outbound.protection.outlook.com [40.107.215.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE27137775;
	Mon, 26 Aug 2024 06:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653505; cv=fail; b=pcbTbGPgMWpm4j5hPtORH+7EMWCYxgcrExbbAEtoemp5TKQyxs0Iou4AcX92yvsLJ0KcM3cZVV6BQ5/B70VV3T359v/3xDchtQFy7/88rcYkdU5sfIygOqv/TUogEWgFh6YSrtt4+SQX4AJXmJgFRZ6FsV+OTOTfNRUzgTYjseQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653505; c=relaxed/simple;
	bh=jlqOSxEPKHkI5dL52Ybr7lYRxAF7bp9tTwUj9yreez0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ty8lvcrGR52MLz3KYcxvQxG6UjqppM9dz8uYph360PsvGOZwX4NjOSq2cXSeYjvfMxZr4o3hbkKEepN3Dmd1yzphHU4nQVs0cKqlM+qmZ53e7s9gg6dGubkpetvTpYLChtdzITJIBP+F2lnnaqE62RwtqkZTZieNrXmr1OPkJFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=TIviubcw; arc=fail smtp.client-ip=40.107.215.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=daPiPalBo8rLKUgUC6NBnoX8ASX0i/mwOx8CflryUSkx8o8Bh0ZbTYfgHAu6P2xBWu0eLOY3tH7iAGhj9jXPgi2/ya7gwPASHG8alhtCFncFydYwxSSt6JhBy+aJsrt9YV7Yz3UTjoo/NfxAAqFLXlFMlTpCJeTOm9BqtG7OPqwbpOEyqeIdkQNRe5pDCWETcj6M4up6vh0jGcy3J5obHZATf7SwZhGuMfi2s4Mgw74Xk8mBWNmcvRiDy5dnEXOupCqg+BpNN6sP2GBWJJTSaQ0MSylCTxYBi8UN61d2gStpnPn2ZTy8GxiJqq73pM4IHYw2BAcpPgsjQm2Hp+QBFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JazR4JFYH/44Q8aeFrnjOL2rYIPNbPmPhwoAEXWC6OQ=;
 b=knJUgA/ALqmSvvgcP51k5haIiQRid0TN7ma5TOjlDret+WeSqvFOlkQ/P0vaCcjRxJCeE6xH426brlvu80foJsFD3HlvA4/PLGBA0ZfKCqgzGUgKIxR/KKxsJVFDQO5QdlueUbW4ejIk73KESVQzRYkZ+FE1MFHHOcYBDrxhz63GKcfoaAA3BhZcSRX6t57kf4t7Wg8arTS2Sqx5emZ20fGd5zFKZgWU8A4d2lgneKc623vVsJATyL/iphWZA7K+3SnI6G/r56V4co99vBuyKzT+n63f1Pqr9Hy1inLO6tFR/BrMEMbYwbRAOmnt8hzufgZq+1mW8hhHx5Vm+DnJLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JazR4JFYH/44Q8aeFrnjOL2rYIPNbPmPhwoAEXWC6OQ=;
 b=TIviubcwDNaJjSvRPjeOYdvCM/7u9Hk8XzTWGyv7TBPT1Tetf9/AM537jDOwCKP0kxrRpzR+AIqg68IwfBhx6LxrS0zP50rFrqDfFIAJhnJkfa7QnZayAa3qFn56coiW+JJ8q9qmRHRhG/ENh/LQZqxoCPY+VQ/QRnJupoNRVH3qbSU0Ui5dgUT3PZ/iXo38XZ8uwvESHD6k+KkbynG1vSxIwUVhwxoBTppwD8g+UDBA9zrX1zZyMjyL4aTgKFpmgj/Iss+95uxDFN8MbTEyp8243Kk52QxpR2dM17Lry5gvOTTqGIh2VNcVZ9vgKifBNvuZtcDVU3lOS7lu+SFmGw==
Received: from PUZP153CA0008.APCP153.PROD.OUTLOOK.COM (2603:1096:301:c2::23)
 by TYZPR04MB8018.apcprd04.prod.outlook.com (2603:1096:405:ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 06:24:57 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:301:c2:cafe::b0) by PUZP153CA0008.outlook.office365.com
 (2603:1096:301:c2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14 via Frontend
 Transport; Mon, 26 Aug 2024 06:24:56 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server id 15.20.7918.13 via Frontend Transport; Mon, 26 Aug 2024 06:24:56
 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v14 09/31] ARM: dts: aspeed: yosemite4: Enable interrupt setting for pca9555
Date: Mon, 26 Aug 2024 14:23:43 +0800
Message-Id: <20240826062408.2885174-10-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240826062408.2885174-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240826062408.2885174-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|TYZPR04MB8018:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e2bcbe45-2866-4d29-ac72-08dcc597ce0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TngEAp84m1WUqCj6bckUlCHIdjbvGs9tdaql/Sv6l9nX44ttndrn9RWMDcba?=
 =?us-ascii?Q?9TkKjwywEim9lBSq3zn28AnPAaI8bMqDIOHNUoJDhdvcnGnjzNCkIeXBY0ky?=
 =?us-ascii?Q?eRBLURhLYW8QofgsRSQjQqJkE3a//1HdBl8gUk+sFp/N19AQNcHaBDj4zamN?=
 =?us-ascii?Q?FLL4LlO74Kikr+QpnfdEoTk2tsaGzmnQAFkfO6u9VilWssDLNwLCZDKftYi4?=
 =?us-ascii?Q?hQBSEVx4fEEr+qdErub3J0VEiMdGng9j7S5d/S1YggukhGxA906UyZ9DaMJe?=
 =?us-ascii?Q?V48p3M+Ejro2FihYiC7duikpk9DF2emxjL3ZF3Q500cRxrrH2L6WVGWunLzh?=
 =?us-ascii?Q?tQyVr+VQak2Sa7Rxbt0BITbIeBGFvI+RIEvesPmOLMk8Ai8liRl5mii5qkCQ?=
 =?us-ascii?Q?7W9iS1xiBYLnU3wEjEKHME1U/CsZZaq864TRFzRKk/GCi7dVtwvTFx2kJQgW?=
 =?us-ascii?Q?CrB0+PZOG0xBFY/GPJkL5rcim/efXZA/BP1j3cMZpDiSCTiEeZGo74IsgSyo?=
 =?us-ascii?Q?50hYEVD0CECJJwDE5WhDUoqQJQXIpP520OfT56brCWuOX5PGZpDuu2VoRUZO?=
 =?us-ascii?Q?6wKmFP11QD136tGizhNL8PYbB88aaypBIshrNYtNIMM8KcFMpoWOQs9O7hlY?=
 =?us-ascii?Q?BnKN1+V9Z+w04qRxvt93AFG8mo33wnTA+NEaXvKaQkwvuV9xCcflXyk242R7?=
 =?us-ascii?Q?NMYdAWEs4dZ29O8acxmG6mWtDGwH3I+0Joc/rKR95JPouCIS448euW7zzo1E?=
 =?us-ascii?Q?kzkgDxTASa3JRMrceetVxAFVJrwy04L6JIwEuHGJhyghxpgEcd1oFqF7ebdD?=
 =?us-ascii?Q?6yJRCCUJ4WnLCEd2557pfP6a4fPrUdrobsUBHLUOYvUaXv6lDNkrHRRxzeg3?=
 =?us-ascii?Q?YFlOha7PDFo1JW9E+d0MdSiSN6OB4qKxXzN9968BUTuhX+EGomABA94QaEVL?=
 =?us-ascii?Q?Ifa7GBac0Zwy9NlOTL5zZzybHdw6WXN7RiL7TdiBr8Xo8JgFebNFF9c8fSvD?=
 =?us-ascii?Q?Yuv+KAJfJdUrtee1hUAXwP31sUn0SCTpib4xFmALQ8oWKiod1QBmgLxnG+7Y?=
 =?us-ascii?Q?pcLf+qfjwmA9CVHVQenh/iVDYJy1+lU3lMD6t0gFd7K0oHVqITwk9tuzgiUK?=
 =?us-ascii?Q?ot6cJHMMEe+TpxyhzA+lQJdWGqGLYc+o33sWwlhgCQSj+Q+z4u7AIQsOhbVX?=
 =?us-ascii?Q?7rpS9kFbX5z/Th7z5EoTKO6J4/KCaj9Atipn4MHbVw0sLJMJEOcNNuxjdDXH?=
 =?us-ascii?Q?5IN/crYTfePfJSvM26e8r1nXRk/xanRBUTcfs1HjfXXTpkYBzx+gxIEAiJr5?=
 =?us-ascii?Q?23z2EPTWqBI6ZllW46LPyCA+uGom+TVAqfHS6UaYaSXqxSxbJFtuEYhB0S1x?=
 =?us-ascii?Q?tC7Ks8LDIWz5cyoRaveOhGoR9/MQlfo5mvi/WDIuaaWmDwEnjWE9oxaZVxDK?=
 =?us-ascii?Q?htYdxURacWpoaBmQi6F2Zk26bCMWglts?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 06:24:56.4872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2bcbe45-2866-4d29-ac72-08dcc597ce0b
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB8018

Enable interrupt setting for pca9555

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 56 +++++++++++++++++--
 1 file changed, 52 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index b11951c2f71e..09bbbcb192f5 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -832,30 +832,78 @@ power-sensor@12 {
 
 	gpio@20 {
 		compatible = "nxp,pca9555";
-		reg = <0x20>;
+		pinctrl-names = "default";
 		gpio-controller;
 		#gpio-cells = <2>;
+		reg = <0x20>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <98 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names =
+		"P48V_OCP_GPIO1","P48V_OCP_GPIO2",
+		"P48V_OCP_GPIO3","FAN_BOARD_0_REVISION_0_R",
+		"FAN_BOARD_0_REVISION_1_R","FAN_BOARD_1_REVISION_0_R",
+		"FAN_BOARD_1_REVISION_1_R","RST_MUX_R_N",
+		"RST_LED_CONTROL_FAN_BOARD_0_N","RST_LED_CONTROL_FAN_BOARD_1_N",
+		"RST_IOEXP_FAN_BOARD_0_N","RST_IOEXP_FAN_BOARD_1_N",
+		"PWRGD_LOAD_SWITCH_FAN_BOARD_0_R","PWRGD_LOAD_SWITCH_FAN_BOARD_1_R",
+		"","";
 	};
 
 	gpio@21 {
 		compatible = "nxp,pca9555";
-		reg = <0x21>;
+		pinctrl-names = "default";
 		gpio-controller;
 		#gpio-cells = <2>;
+		reg = <0x21>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <98 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names =
+		"HSC_OCP_SLOT_ODD_GPIO1","HSC_OCP_SLOT_ODD_GPIO2",
+		"HSC_OCP_SLOT_ODD_GPIO3","HSC_OCP_SLOT_EVEN_GPIO1",
+		"HSC_OCP_SLOT_EVEN_GPIO2","HSC_OCP_SLOT_EVEN_GPIO3",
+		"ADC_TYPE_0_R","ADC_TYPE_1_R",
+		"MEDUSA_BOARD_REV_0","MEDUSA_BOARD_REV_1",
+		"MEDUSA_BOARD_REV_2","MEDUSA_BOARD_TYPE",
+		"DELTA_MODULE_TYPE","P12V_HSC_TYPE",
+		"","";
 	};
 
 	gpio@22 {
 		compatible = "nxp,pca9555";
-		reg = <0x22>;
+		pinctrl-names = "default";
 		gpio-controller;
 		#gpio-cells = <2>;
+		reg = <0x22>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <98 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names =
+		"CARD_TYPE_SLOT1","CARD_TYPE_SLOT2",
+		"CARD_TYPE_SLOT3","CARD_TYPE_SLOT4",
+		"CARD_TYPE_SLOT5","CARD_TYPE_SLOT6",
+		"CARD_TYPE_SLOT7","CARD_TYPE_SLOT8",
+		"OC_P48V_HSC_0_N","FLT_P48V_HSC_0_N",
+		"OC_P48V_HSC_1_N","FLT_P48V_HSC_1_N",
+		"EN_P48V_AUX_0","EN_P48V_AUX_1",
+		"PWRGD_P12V_AUX_0","PWRGD_P12V_AUX_1";
 	};
 
 	gpio@23 {
 		compatible = "nxp,pca9555";
-		reg = <0x23>;
+		pinctrl-names = "default";
 		gpio-controller;
 		#gpio-cells = <2>;
+		reg = <0x23>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <98 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names =
+		"HSC1_ALERT1_R_N","HSC2_ALERT1_R_N",
+		"HSC3_ALERT1_R_N","HSC4_ALERT1_R_N",
+		"HSC5_ALERT1_R_N","HSC6_ALERT1_R_N",
+		"HSC7_ALERT1_R_N","HSC8_ALERT1_R_N",
+		"HSC1_ALERT2_R_N","HSC2_ALERT2_R_N",
+		"HSC3_ALERT2_R_N","HSC4_ALERT2_R_N",
+		"HSC5_ALERT2_R_N","HSC6_ALERT2_R_N",
+		"HSC7_ALERT2_R_N","HSC8_ALERT2_R_N";
 	};
 
 	temperature-sensor@48 {
-- 
2.25.1


