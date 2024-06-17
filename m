Return-Path: <linux-kernel+bounces-218385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B32C90BDA9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BE49B21BE0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 22:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4104D199248;
	Mon, 17 Jun 2024 22:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TL4EYB7W"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2063.outbound.protection.outlook.com [40.107.8.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1DB7492;
	Mon, 17 Jun 2024 22:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718663488; cv=fail; b=QLk/Amq23CugsSy+Arp26S2M4ZHcQhxg/VGdxGsFNuxzWYcyFanMnMYBoRg5hZgZTyM4EvblaL9TZllFMACk+jTa2sqa/2KErlbQMIBnDjRKfnsyL1vP3y296XeR/8/EhlPonppTaoiT/mRP3AbgoFj05jwrFixiPaLgwkA+7po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718663488; c=relaxed/simple;
	bh=my6hAhGl9LJ0Ns9ZarEIramNUUmVbi8hCSY2CxFkOQg=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=IhupLGD/eoJPmTpJ+Ivlz6b7crXKUyCaSB72wqC9/G3o0F8PaATpcYtWe6bT49ANWcpRFZ5Oi70r2/xKEXwdmKoYDWiBEg/HQA9BTSEH/yVwWc65ReYfltJ6h+ZyT9DVdsFx9FiMH0OCXemutLsxqsA70+sjP9CVpIRUew5ayIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TL4EYB7W; arc=fail smtp.client-ip=40.107.8.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kh4hYRjUy0L41IXrTYI78zWSP/jdQzBX/bLVcTp3dilbKb9yyv9rpZrD5F0JJH2bzRNdGf8mXVGtx/0QbvdmnUNEb8O8RxZtot601tM17MwB9UysxCRKxVbzYU5pfY2D1PbX81rkLJRo51FnNS/wEQ9p/ZdSh/HuYXX9AZFde4u96oVjs1hyvJqLNOBkqOzl9IwsHeIH3BuMhbvgEmDMYeW9Ozk5VkRfqgb4EV1jAzRpkq0/z9P2fOJBWWJ96inlsSO2B3/X/NUOa7WZ23L1l1E9bOfpuH6hjM9lVZ/H+ibLMnMXiFHIQ8mDr3gcJItisQafPKSi6PeDO4/DQHruqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btdIluEdK/Z96b0yaZ5hUceGroEVZvEIpjtUcUINDzk=;
 b=lIXGihMkLwXEDbwME5JGfq4FHFxmJgNL3sZF/z50bahfBWT1HePkXERzbP4ar8ORcvLmv6XKrwS1g1xXeC2Vre82vVeZsAjOGM/7Y+IH6plcKjVSnfc9b3J7G352Nnld+4A3Jr87zOsIExTTRyL7iffMH/FPH2Ck8taUNCX0TMW3perlg8DTmRvL25vrTSAu2pXLssXWgkSCSCa/BCIQrU1xQhbobOZQ/wx6IfLpf+YmiFpYksCSIgd/8kV26hn1jtwkcR7e7AekyZVALoFTtZy8po2vPf8Y1lPUfCt0oTrsfcRmIdlC3iSJjWIGC1MY07UJ0CjBWvvj2ZznlLteNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btdIluEdK/Z96b0yaZ5hUceGroEVZvEIpjtUcUINDzk=;
 b=TL4EYB7Wsij/LGG4SvOOZJkj7Qw1RkBbmzok1Nlfind8SKNSD5UBt98upT7Vc9PBlemGiBo3P04LoAzOJE7bjvqHg0Ppp/eCWCix1PKT2vxQaAKVX2CqVgX3Td3GlqEX/iJL3SnWmWREtkEVWB87QpysLFXR2qbHpAij0WezQaQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8150.eurprd04.prod.outlook.com (2603:10a6:20b:3f0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Mon, 17 Jun
 2024 22:31:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 22:31:21 +0000
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
Subject: [PATCH 1/4] arm64: dts: imx95: add '#address-cells' and '#size-cells' for all i2c
Date: Mon, 17 Jun 2024 18:30:57 -0400
Message-Id: <20240617223100.1539796-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8150:EE_
X-MS-Office365-Filtering-Correlation-Id: bd6f3f7d-16f8-4ae6-fd1c-08dc8f1d368a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|7416011|52116011|366013|376011|38350700011|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PdPDVeviKNEQNy+aDAKiVV6bcsZqGJJR6hq9mHzotNZaLbSn7dIU7DWWjZfs?=
 =?us-ascii?Q?UGUYYnMGDSKnbFUPW3eFWECFni/41tOeAjqv/OwwGT+qaL7p+BxgypHBOk5B?=
 =?us-ascii?Q?BzW1ZHNVftA54EmuAI+thAu+Bw2ojCRMQjc8wBJK0yRLceXqec+Jw5okezM8?=
 =?us-ascii?Q?i4QuAq2CGmvByBzmepymNOfY9X/zqhVgaznGOjPJmQd60aUg5MBtze/ovR4Q?=
 =?us-ascii?Q?lyOrBn70+w9zdG98GASlgcUfeankGy9zAGorHNdm1UlMNbMbEqGsPB37dkuo?=
 =?us-ascii?Q?XpZ/Uf0I07nmM0WRVavm2uSAwZLZIEYOqO6G5i9eNrYogfECR2YF5mQ3qHjx?=
 =?us-ascii?Q?U/eGv6UCj3uTMjJbWlMssdHXZ++RJADqriuDRC/HiRYxr/7PEejxXI1ocrYb?=
 =?us-ascii?Q?6yUplBckBMruwBj811exCpIlPOeeXHi8wQd7Dn++12hCx5RpHEajdb9Zg5OS?=
 =?us-ascii?Q?ZLr/if6SS+aoLIurWgayn6QNIltBBxiCPZoHwRL+SMduqbm3+krKsRnJkJPf?=
 =?us-ascii?Q?q2iamrZdqSmyJluR8rDAYcZoaJsvJ59yU2Sox7HYKRWqx9HA7C4uWsPArG6L?=
 =?us-ascii?Q?FRLKJEMLF3PEct2KY7e9chSZ/1tzUprOIMYoCBPGPi++qM+7/wQ4JSeRIqQE?=
 =?us-ascii?Q?YdpJgH8vrckxJ3YCCDFhkklNLqWvKU4tAc/JxIqS4YVaw52KBKak0Kc7HOay?=
 =?us-ascii?Q?LxzdS8yQ6f3lSSapck+bFl0OC0X85Rj3J4hkDxllfLSyicgiN2aaLO9Mu7IA?=
 =?us-ascii?Q?Q45LWGHGFb8rMoVrvo3Y5Y1dQ4617147+YexYYjCm4qYm/IHQbByclOzs62y?=
 =?us-ascii?Q?7Np4akiGqDwiNa/RSZmhx5Ga2MNwy/ZA3U/0m06a2F6UOVjMt7TAvtpnFeL0?=
 =?us-ascii?Q?y33bbfP9bu3xkBaOfN1FpGl58iTyZL/sUUF9kDf7R93ff95gFRjnLGRE/F6i?=
 =?us-ascii?Q?WyIDuY2+Soa6BJmTw6gve+to0+kl+ltJRPwG1586iIk7ziaHZKN92X1TfwTD?=
 =?us-ascii?Q?M7XKyHQ8u3+SA3kaSyQI8zm4+Ha+ck0A+OFOo5e/w9gok3gtwWy75PsXh1lz?=
 =?us-ascii?Q?urD9VbAasyxBLEb91BPKGDvSdPcolzDI2W8g2z1Ms0kF46syr6NMVpqhZuac?=
 =?us-ascii?Q?1KemjJZDu95+MHVbSrAv0rsiPAYiUdkoxL42BvlbECEyzddluFKZ7E8fJDR0?=
 =?us-ascii?Q?Sg94sLQJAAuP4dFlxJkfUasjcBWOg4nJx7A3pF8CHlQCMSwBWLS4UQnOJuSa?=
 =?us-ascii?Q?aYPToTQ9kHoG2FaJJYTQ7Xx6jWbx3fyxtbdroq05QjXODOfuTUECMKZyw3tN?=
 =?us-ascii?Q?A0oSnic4XDTLSNjDLjyFVnBpW8GBKuXGHmRiP4k0L6+9/2/S/NE27kJSGmMo?=
 =?us-ascii?Q?ZZPpEHXfKmFm/86Qs6MEtVoCLVNN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(7416011)(52116011)(366013)(376011)(38350700011)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iPAqkSJIJCGGniPMXHhUjo5IcStgIb9R3WRPpNtEB7SkHQTasyL00gVKVyNu?=
 =?us-ascii?Q?H/zxLD4LyNt+m7GUkKWQlwIKVik6BNCGFL43Pq/QRQPqawUcw4GkEdajwirq?=
 =?us-ascii?Q?CfX0YFvDyziMwJF6vUTmm9LfGaw+op0fufGko/jnm00wzD28YZV8/oXC7Zj4?=
 =?us-ascii?Q?Yqrk6+XJEVbssSJI/Ss3Rt3jRZRM9dXZGLEFQoFe0/hHFCrz8cuULTQbjscq?=
 =?us-ascii?Q?ozYAAEE5sGrwi0rP/5Ge871xJgoBwWXSkP6tEIJ3r+Y0tChMfo1M0b8Ogfl4?=
 =?us-ascii?Q?e+9hGdoxGhS8SrIM+aY0xXY6iuFPflcCvCSvKIQWwCc8PAxdGP+hM8okHFCQ?=
 =?us-ascii?Q?2p83tgX8WuFiSmoaZr5mybqGcVydd9YnhyqVnzZhpDsTNywYk2MUHB0eg6SU?=
 =?us-ascii?Q?1EgV2nPHYGpSEq2vwzJOV784n9aEnXgjY+B72qqcZZvoxCQ36ei46WByWCbU?=
 =?us-ascii?Q?A6ufN37cBNbyEMxXUneZECEwa67nh9t0+0k/xEKzL3z9xHrEMPGSWIU6BkRi?=
 =?us-ascii?Q?/QW8s4MTkzY44Lp7Tbx6OQq0W/u9Rtte2bDt7egrEpUHDCVQwWHNZjK0jq1z?=
 =?us-ascii?Q?ie4yxPpDeOv09hWQ7LKa2JR7sXrDUqGptvQH7TaF7Wp4D1h9Iv9mDBk6G8C1?=
 =?us-ascii?Q?iEX/NRc5ZLN+AjPdoRXIK9gj0fvemhsyrlAk/AW1PdSB0uaCnBECmFCYkbtU?=
 =?us-ascii?Q?UGyZzXlqN9+ErXgxlmmtcgXiBtifythz0EU2SA1rkLGI4t2GyJ9qEsHTrRQD?=
 =?us-ascii?Q?AyiQ1p8Flb+dNLM7HVGeDy2dSQkZBy481KoiY6PQTSItbAlR6ryuhWPCYREN?=
 =?us-ascii?Q?2Ye51xsPHUTilhkg/f0KR7tcrAN5QfsgjQ1a7pKkSN3haJuI2zfaC9/Amn1i?=
 =?us-ascii?Q?mBKWP5Z27QIb5EO4iv+xQNqTDFQehl7pyu2SQ2zYjfCDRQqMu23IYPiknsnm?=
 =?us-ascii?Q?fjywFfDR2Gwp8Xv0vF+GvDri7ViU0U2rWgFqzXvurngSdV59Ep8bKbMTqYWa?=
 =?us-ascii?Q?vxTlm1TbngVkwA0E5uerxg2wbCljPIpS7bo3u50e7IxJQD9UFnH7z5rIy/Am?=
 =?us-ascii?Q?F2DCe9vaqnLCgKMZFSll+LDS97GUvrEsaAa2111qkQpgSnigGr/pBiGekKSZ?=
 =?us-ascii?Q?f8+G03G7MUp0lLjNrccgaEambScH69ENMY1si3AjuqK32UC3qPKoVz4WmhD2?=
 =?us-ascii?Q?GTSeDay5Bf9p8tAkAwLLEH45LIReV272hDRuJVEW0GRjjivMTou0qoYMW97y?=
 =?us-ascii?Q?R6WKOw2ExitTVLnElu4QP5eUZaF/9ILAsOXolAcYMfqCUQu0j3emg4QSd5Rg?=
 =?us-ascii?Q?IaKojc0+ipCfyr3XLuwNJY2Y2lNTfLHTsKXeHUXWrOP8tScnMj6YPRucyRzx?=
 =?us-ascii?Q?xi06uazylFeHkCXKbdJRhm8mG8Xz8o8GqWYSB33OBmFg4swJboN2Jomf/BLW?=
 =?us-ascii?Q?EcQ2By7DwNkRItMT1dJWNTUkOs60b231EszwJt12fUqtmKcEkr0OKnDySxL7?=
 =?us-ascii?Q?3ujzsCqU/Feg9+z4Fhk3vg0ct4LFDP+MLCy8c3zQOsXYcT1zD2JM6ioNXCuX?=
 =?us-ascii?Q?UQJfYi3fuEhNxidtilo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6f3f7d-16f8-4ae6-fd1c-08dc8f1d368a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 22:31:21.3310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hVZfCwpWwUue5mtWLFtZoIKpaO++LJ+X/hexICZ4WELgxN5UGqCiKhTm+vXNw1jP3jYdqg8/dGhPBzc3Hz817A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8150

Add '#address-cells' and '#size-cells' for all I2C to avoid duplicate these
at every board files.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index f98cec944eeed..cc5e829e76cc5 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -462,6 +462,8 @@ lpi2c3: i2c@42530000 {
 				clocks = <&scmi_clk IMX95_CLK_LPI2C3>,
 					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
 				clock-names = "per", "ipg";
+				#address-cells = <1>;
+				#size-cells = <0>;
 				status = "disabled";
 			};
 
@@ -472,6 +474,8 @@ lpi2c4: i2c@42540000 {
 				clocks = <&scmi_clk IMX95_CLK_LPI2C4>,
 					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
 				clock-names = "per", "ipg";
+				#address-cells = <1>;
+				#size-cells = <0>;
 				status = "disabled";
 			};
 
@@ -566,6 +570,8 @@ lpi2c5: i2c@426b0000 {
 				clocks = <&scmi_clk IMX95_CLK_LPI2C5>,
 					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
 				clock-names = "per", "ipg";
+				#address-cells = <1>;
+				#size-cells = <0>;
 				status = "disabled";
 			};
 
@@ -576,6 +582,8 @@ lpi2c6: i2c@426c0000 {
 				clocks = <&scmi_clk IMX95_CLK_LPI2C6>,
 					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
 				clock-names = "per", "ipg";
+				#address-cells = <1>;
+				#size-cells = <0>;
 				status = "disabled";
 			};
 
@@ -586,6 +594,8 @@ lpi2c7: i2c@426d0000 {
 				clocks = <&scmi_clk IMX95_CLK_LPI2C7>,
 					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
 				clock-names = "per", "ipg";
+				#address-cells = <1>;
+				#size-cells = <0>;
 				status = "disabled";
 			};
 
@@ -596,6 +606,8 @@ lpi2c8: i2c@426e0000 {
 				clocks = <&scmi_clk IMX95_CLK_LPI2C8>,
 					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
 				clock-names = "per", "ipg";
+				#address-cells = <1>;
+				#size-cells = <0>;
 				status = "disabled";
 			};
 
@@ -816,6 +828,8 @@ lpi2c1: i2c@44340000 {
 				clocks = <&scmi_clk IMX95_CLK_LPI2C1>,
 					 <&scmi_clk IMX95_CLK_BUSAON>;
 				clock-names = "per", "ipg";
+				#address-cells = <1>;
+				#size-cells = <0>;
 				status = "disabled";
 			};
 
@@ -826,6 +840,8 @@ lpi2c2: i2c@44350000 {
 				clocks = <&scmi_clk IMX95_CLK_LPI2C2>,
 					 <&scmi_clk IMX95_CLK_BUSAON>;
 				clock-names = "per", "ipg";
+				#address-cells = <1>;
+				#size-cells = <0>;
 				status = "disabled";
 			};
 
-- 
2.34.1


