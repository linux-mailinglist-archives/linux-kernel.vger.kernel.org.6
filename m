Return-Path: <linux-kernel+bounces-233068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0696391B1E3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 00:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 274081C22229
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 22:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACBC1A2C22;
	Thu, 27 Jun 2024 22:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="me5vTOtn"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2041.outbound.protection.outlook.com [40.107.241.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86401A2551;
	Thu, 27 Jun 2024 22:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719525628; cv=fail; b=B3fFQu/SdpT89OobCm2+2EB18TKfW9ERS91YBR5+EXpdaGPrqRxkSBeoaSbeWk/mMpReQo5VCdPQJfx4EvNb9u28txA0ca5ala5u36CB1k589awO7LNWGryKMQAstqCZsY1AE9Z6w+B4d0wckmDihDU08PjRbag9VTRLqPnrngU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719525628; c=relaxed/simple;
	bh=wzJqaX2YyHCSp/ZEhNIp/sGOCrJI+xgXk+tl9oNMfGo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EGVD6HrYheSXXuGMAuDVq6IPwkMz05SULpLwwtEk5mqx/8dwcVcNvQoS58/RM//PuIQUYpzEzcLLyj6V62G2vOJdM4zlgt58Hfea/INVEv9Y/l9aql5r9S8uiY8TtuCo4ZuFZG42Av+smKwTzPI2FizOGGza/HzCxBDAXutnfUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=me5vTOtn; arc=fail smtp.client-ip=40.107.241.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKZ03DgZsSs/zcr2/AOPh7M3S59q4vAGJ0aHfcTQeFfn4XCQ1b7TzI621/r0Jf/wMxOVgVy4jCqolu6PVrDUDhCuHXe3fpLwE41Z6VI7q52K4piIujDUbNhPvTjlfNYSggum8jhHuDaNVQ7nIUXZaUREQF/oVgy/6S+MJTFO4umkyAjolUxaqYtGup8luWbkMI7xS7AIKSqY/t/kywKE/lH7NfFe2s3RazbVHFkjq9vg4rbYgEDhsKtyBl4ctI8HbUhT8PtOeIzI1nufpm7BgW3cMw+CGYNiGSB7q1aLFog787ilcy8SDZXyIfPOxSt0Fa/NTwFg4o2Ia59wagQ/Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJQKC/VhijgXqnbrv8d04OKQlW8vdwbdxQLB6CAhemc=;
 b=RmExRC/LcEu1XEkYiywafQ7Yxbq9Qdq+NSyWnPGwBsCskCDXttz63r0jp3rhSmkb3uK3+mQYrL4Gw8rXD0qkHNq1iu72XydzfU1WDYxCslmBvRPW/D2XcGOAX4lQjEuaO5BFcVpv0fL+cyXVcJRC+KjPGXCTl+/uTRpIb4e/kBGaiFqbcoPpsfKGfWSM4APq6AWq7Ux0f4vdJJnqw1BTOPTxfuUyxL1ciH8+aOF5YDOMqG+2quEfFzbpEou3GezVTUjnSbKtynhvsefUmGf9FI7iOwi0qpEem6/YY+KrfKNXikIQ3b7yMEFE6G2j8rqnSQNB4S0d+abiz5u7lOjdLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJQKC/VhijgXqnbrv8d04OKQlW8vdwbdxQLB6CAhemc=;
 b=me5vTOtnvp551+I6jTs0WNad0sJ2YpNsaA3pfA3LKoyEnExkiE6c/SeYpVCgICMJ3WrJpr5LBBisR1tjD6rl5n76hZbPx11JlZB+T3LTLo+xI9oAx1mv/lCGtRwaAg4xpt+uxV34G1NdxpbibTsxE2W4bKDhnGHQtEOAm/vuOOI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7259.eurprd04.prod.outlook.com (2603:10a6:102:8a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 22:00:20 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 22:00:20 +0000
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
Subject: [PATCH 3/7] arm64: dts: imx95-19x19-evk: Add audio related nodes
Date: Thu, 27 Jun 2024 17:59:57 -0400
Message-Id: <20240627220001.692875-3-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: d65f299e-223d-4d82-b00a-08dc96f48950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|7416014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jeYJTX1QgZGEUrgJzZQ6Wf5hjSKXu37hU7htSle9xVSsdsmXvHv8Es/jT+Sh?=
 =?us-ascii?Q?+vMzlrMlZVXPwNspqQXm1UBCcdNEgBjVIxsgEB2OiTOtq+5vVITmb47Y8C+w?=
 =?us-ascii?Q?RnwEZggfoy/CRnmwiVKFopysEvwBJLJ+6hbK/eklPV7Y0Kwbi41fbpletQ/+?=
 =?us-ascii?Q?LGeC9xLiM1ja7Rtc+S12nOdJwDv9rilzL5ivdQrE1rutQSCBjd13InTqPh0H?=
 =?us-ascii?Q?qEQ7pPZM+OO05j6VEuDNcRF6+eaSKId3/hesiZh2GmTHaKmhuwGRxlSUYR+P?=
 =?us-ascii?Q?SeHIut/8eW4S4YTjiJoWBV8K+5UGhJpd+XyVQbWKnWT0+gk+axmQYKTA4xDd?=
 =?us-ascii?Q?4Jz+l7MutKKjY7Lg2e5nBRIkbsA1YjDwC5K7TCaGPDItNAFd5ftAdaYDvlYM?=
 =?us-ascii?Q?kCm7S/D2o3AnBJv6yTjhQ9HJS3LqyNHPLIL1uj885ll42nvU7uJU4oFtQ4Wx?=
 =?us-ascii?Q?dXPWJbNF5fxi0ULOavoGXi5UmrR/cGZGY5b+J4D6LwSEbYcOiKO02rlIDuAB?=
 =?us-ascii?Q?zZdFTv5ErLboapxnKmRsQUGVXOEiZiJ7sNLf0Pkl+RMxHufskZL3PlyVOKoR?=
 =?us-ascii?Q?Au7uq94SKe2c0JOBU1RcarRGkwc+F/McOxo/7dTi2/tLCGkVJ/cjUfoY+0PN?=
 =?us-ascii?Q?nJYQb9hUNoi8qOUlBRVgNDkxEcqh2TEI8n4iBrtyepYK0+YJzqHu3enCOCpt?=
 =?us-ascii?Q?pix/V6WwrXYy4UFgiSP+z2MY29UnZheVMvpwGDMLrRRkRfZ4gfoI3ool+IW5?=
 =?us-ascii?Q?omcwwn5tFAVOpMchPYRJcDba0Ux8xhXzfIQcuhnh+9EI6VYjwLtwYI48In+p?=
 =?us-ascii?Q?tvAQHuoxDCamG2gnId0ugX+T7J+e1VM4ZfFHTYnaMe1KNFSQhUgDXBzGgpni?=
 =?us-ascii?Q?tYUGLZHe0D+kH0xGX3vaa23/V5hrkRyQVtrpm3EEIs+rAav0j8LxRfEOhCRk?=
 =?us-ascii?Q?9w273yHeGc2a6T/C6cAFq1Z+2UabFClgNS1d1RQYu0iDVgl+mag4azJP4iTJ?=
 =?us-ascii?Q?X9trDGMIC7GBrpqroB43MCxqY/Tp3TEFH1ihLwjKDI2tDnpJWW/FHFGRMpZT?=
 =?us-ascii?Q?9lnmWGrq6i6m8qnjZa4hV4v9owQZ3bwMfwTdHdwi0DjJAFGUARSTgLdgRhf5?=
 =?us-ascii?Q?JeaxbdqV4O5rLW/UTSJRnXesvTIGleH5LONYLxSwIr1fYifXDmdJdYA9Gh1x?=
 =?us-ascii?Q?nChvt3PRSCNsfoP2u4o97e2qa1aDciu7sIkPeFl3wXe7hMdh0BGGmQCaC0wR?=
 =?us-ascii?Q?uQ3DzRdfB1xiEUuhD/xmOdZvzQ455ai8Nlfx1m4bUtEWkHVZ0sWK47RkLFLX?=
 =?us-ascii?Q?2S0Kh9M8CuoeoFEhSoJ+JsChZTwU85c6E7OuuuwDb1KYAo7VlJFvakyR036p?=
 =?us-ascii?Q?R0kIKCQ9pYcShn+wMTTXepiF93BBzu3RwYyrbgIT/43uC7ew6bwxt6Sedmfr?=
 =?us-ascii?Q?YhybZphB5aI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(7416014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hafPSDOzRQg9oKwiD1J8um79kKJ7IxsYqDdLIYQsysut6vNWO2BLhDuApAjL?=
 =?us-ascii?Q?Kx1IJOisQ0Rb5egErwtZ2R8Liv4vJOYXhfbdmQhq9aDOBNnC+4KGoZpc1z2n?=
 =?us-ascii?Q?3HTa9gFxqJms53c0gLgpgN0JU8G0avxsOgsy6yZiZOUOSR+fJQT4hvKYg6/u?=
 =?us-ascii?Q?31zR/NKuo4hKQTzFMKtgQ9wsFxvjaww7FKclxi+0vzFLdNbvj03Cis3eLa6y?=
 =?us-ascii?Q?UFE0/ftSzoCUGjKeCRi1s8n91Ncefv1yi/990MKitAIqsAjzVKt4QHFnx4yL?=
 =?us-ascii?Q?AQUBC3x6L8MJRAIBhb1EjGgx0Ca6nVWPMcZyqh3n+YKwqjU3YDtpVLQLiHOu?=
 =?us-ascii?Q?6Fqvq+bYXX/o/cSdEBBD65HAqr1CeSGOYpFi4QL3Ae5vMt5Lr9iRrbTsfICh?=
 =?us-ascii?Q?7yhSGBtsCWag0BTRQrsNQRRVPZVojdKqGgS41G4t/+RwgHGhkYKMTkqfwjMC?=
 =?us-ascii?Q?TOHA7XyeU4rsG7dptFEAiPwApQL86RUYt58f7uS6EubtXOExbf9TovtJxKDr?=
 =?us-ascii?Q?PfpBUssESjVZ8JRTkU6DxnTAAtl/Qlm0BotJ7N3yxXheunGOszPV1qczQ9n0?=
 =?us-ascii?Q?OK/oKEeDNnG77Gjd/foVp6yk/DDQhLak3awLVFj+4n7OmKktVVD5POoovLHV?=
 =?us-ascii?Q?moe+nJZulVsQeIP5h+2goJ+VB5kqfgJQoEQ+t8smuGaeBdOh/52OZBPCUw6+?=
 =?us-ascii?Q?pPLVOVRGN5/coIwOZly4t+/MTut6nfCVDw3lY+5xnSewa1TDk/0VTyCvlD88?=
 =?us-ascii?Q?vfO8zsiUI28ht9n8QDGXEODTATn/b3xhroHONyhiiHDeV6vmm+P3GBDwKzFF?=
 =?us-ascii?Q?krj92kPzW5Moz4RNBKYJc8IV9kXIwpMFicjeqmhS3H4OIyoDyVDZdkjORdWw?=
 =?us-ascii?Q?CmcX2TxMY2ObWsGMYnDSC4qrPv0SLraSFjIWUsPLFwE2SDZc+Snq9vl6hOqp?=
 =?us-ascii?Q?xPyBxYiemjQD84EIIS3CguR6jCxnZ4EKPaERieSe3FRhC/jbxCwSx22MN64X?=
 =?us-ascii?Q?UBmgVsipuw6AWPFve+zyMEl2Pp9EyAmGNVdyUB3lYArO9tOakKtTYWYMNbKs?=
 =?us-ascii?Q?NwRdibbRUl/GtxD6Rpfgg4xlstbQFMZtAoJHlF6g1NYpD8JcxtKR+tOpHFD1?=
 =?us-ascii?Q?lL8ZQko8oaIO5aVjMzSA/709ppg4B882mXbWNu8JOIwzy5SaYJvbd6OfC2/2?=
 =?us-ascii?Q?snMHQnf1d1X4ILOCszzjOS6IiIyjZnutc68n8E0bKEB39DrR70G4dICm743A?=
 =?us-ascii?Q?oB+RI2hRU9c0mfHJOAq4iHI5CRM0oPGAbsCZ3n5DGJ750sNritJ9libZFXkp?=
 =?us-ascii?Q?eaRtB35ivcIMSeUNa8AMxHHPpchcAGrtYETj1krw5EaqoC3VlpFiGKGDhstY?=
 =?us-ascii?Q?fzhUT14rsYW1pmAS/1vwsQExHJTtiyAvzMUQdmus/HKcBLbcb01d48H05zlR?=
 =?us-ascii?Q?K+2ZGFTgsqbEg6u4VTZVcRo/133Doul2slq12o8g92TsxQWKt8aV7/pSXAR8?=
 =?us-ascii?Q?Yn2liGFunCuGTTiRPwpCKLCIj+3mjIspiWvlRaTbgCvUB4pKJZIg1+K8G6D7?=
 =?us-ascii?Q?Rd3dZGQw5uL7uwLlU90=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d65f299e-223d-4d82-b00a-08dc96f48950
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 22:00:20.0689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kGnhE7AJhlt0u4rKREjXUQiZBGHXgZM7EahachowZAJqkQ74NZD34S2pSEz11J3mrYS50MUC77QJzJHZrjs0Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7259

Add sai1, sai2. Add i2c4 and wm8962 and other dependent nodes.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../boot/dts/freescale/imx95-19x19-evk.dts    | 238 ++++++++++++++++++
 1 file changed, 238 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
index d14a54ab4fd47..660e623f4f964 100644
--- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -17,6 +17,11 @@ aliases {
 		serial0 = &lpuart1;
 	};
 
+	bt_sco_codec: audio-codec-bt-sco {
+		#sound-dai-cells = <1>;
+		compatible = "linux,bt-sco";
+	};
+
 	chosen {
 		stdout-path = &lpuart1;
 	};
@@ -40,6 +45,34 @@ linux_cma: linux,cma {
 		};
 	};
 
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "+V3.3_SW";
+	};
+
+	reg_audio_pwr: regulator-audio-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "audio-pwr";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&i2c4_gpio_expander_21 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	reg_audio_slot: regulator-audio-slot {
+		compatible = "regulator-fixed";
+		regulator-name = "audio-wm8962";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&i2c4_gpio_expander_21 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+		status = "disabled";
+	};
+
 	reg_m2_pwr: regulator-m2-pwr {
 		compatible = "regulator-fixed";
 		regulator-name = "M.2-power";
@@ -79,6 +112,97 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
 		enable-active-high;
 		off-on-delay-us = <12000>;
 	};
+
+	sound-bt-sco {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "bt-sco-audio";
+		simple-audio-card,format = "dsp_a";
+		simple-audio-card,bitclock-inversion;
+		simple-audio-card,frame-master = <&btcpu>;
+		simple-audio-card,bitclock-master = <&btcpu>;
+
+		btcpu: simple-audio-card,cpu {
+			sound-dai = <&sai1>;
+			dai-tdm-slot-num = <2>;
+			dai-tdm-slot-width = <16>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&bt_sco_codec 1>;
+		};
+	};
+
+	sound-micfil {
+		compatible = "fsl,imx-audio-card";
+		model = "micfil-audio";
+
+		pri-dai-link {
+			link-name = "micfil hifi";
+			format = "i2s";
+			cpu {
+				sound-dai = <&micfil>;
+			};
+		};
+	};
+
+	sound-wm8962 {
+		compatible = "fsl,imx-audio-wm8962";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_hp>;
+		model = "wm8962-audio";
+		audio-cpu = <&sai3>;
+		audio-codec = <&wm8962>;
+		hp-det-gpio = <&gpio2 11 GPIO_ACTIVE_HIGH>;
+		audio-routing = "Headphone Jack", "HPOUTL",
+				"Headphone Jack", "HPOUTR",
+				"Ext Spk", "SPKOUTL",
+				"Ext Spk", "SPKOUTR",
+				"AMIC", "MICBIAS",
+				"IN3R", "AMIC",
+				"IN1R", "AMIC";
+	};
+};
+
+&lpi2c4 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpi2c4>;
+	status = "okay";
+
+	wm8962: audio-codec@1a {
+		compatible = "wlf,wm8962";
+		reg = <0x1a>;
+		clocks = <&scmi_clk IMX95_CLK_SAI3>;
+		DCVDD-supply = <&reg_audio_pwr>;
+		DBVDD-supply = <&reg_audio_pwr>;
+		AVDD-supply = <&reg_audio_pwr>;
+		CPVDD-supply = <&reg_audio_pwr>;
+		MICVDD-supply = <&reg_audio_pwr>;
+		PLLVDD-supply = <&reg_audio_pwr>;
+		SPKVDD1-supply = <&reg_audio_pwr>;
+		SPKVDD2-supply = <&reg_audio_pwr>;
+		gpio-cfg = < 0x0000 /* 0:Default */
+			     0x0000 /* 1:Default */
+			     0x0000 /* 2:FN_DMICCLK */
+			     0x0000 /* 3:Default */
+			     0x0000 /* 4:FN_DMICCDAT */
+			     0x0000 /* 5:Default */
+			   >;
+	};
+
+	i2c4_gpio_expander_21: gpio@21 {
+		compatible = "nxp,pcal6408";
+		reg = <0x21>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <18 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c4_pcal6408>;
+		vcc-supply = <&reg_3p3v>;
+	};
 };
 
 &lpi2c7 {
@@ -108,6 +232,23 @@ &lpuart1 {
 	status = "okay";
 };
 
+&micfil {
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pdm>;
+	assigned-clocks = <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL1>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL2>,
+			  <&scmi_clk IMX95_CLK_PDM>;
+	assigned-clock-parents = <0>, <0>, <0>, <0>,
+				 <&scmi_clk IMX95_CLK_AUDIOPLL1>;
+	assigned-clock-rates = <3932160000>,
+			       <3612672000>, <393216000>,
+			       <361267200>, <49152000>;
+	status = "okay";
+};
+
 &mu7 {
 	status = "okay";
 };
@@ -128,6 +269,42 @@ &pcie1 {
 	status = "okay";
 };
 
+&sai1 {
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai1>;
+	assigned-clocks = <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL1>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL2>,
+			  <&scmi_clk IMX95_CLK_SAI1>;
+	assigned-clock-parents = <0>, <0>, <0>, <0>,
+				 <&scmi_clk IMX95_CLK_AUDIOPLL1>;
+	assigned-clock-rates = <3932160000>,
+			       <3612672000>, <393216000>,
+			       <361267200>, <12288000>;
+	fsl,sai-mclk-direction-output;
+	status = "okay";
+};
+
+&sai3 {
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai3>;
+	assigned-clocks = <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL1>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL2>,
+			  <&scmi_clk IMX95_CLK_SAI3>;
+	assigned-clock-parents = <0>, <0>, <0>, <0>,
+				 <&scmi_clk IMX95_CLK_AUDIOPLL1>;
+	assigned-clock-rates = <3932160000>,
+			       <3612672000>, <393216000>,
+			       <361267200>, <12288000>;
+	fsl,sai-mclk-direction-output;
+	status = "okay";
+};
+
 &usdhc1 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
 	pinctrl-0 = <&pinctrl_usdhc1>;
@@ -159,12 +336,31 @@ &wdog3 {
 };
 
 &scmi_iomuxc {
+	pinctrl_hp: hpgrp {
+		fsl,pins = <
+			IMX95_PAD_GPIO_IO11__GPIO2_IO_BIT11		0x31e
+		>;
+	};
+
+	pinctrl_i2c4_pcal6408: i2c4pcal6498grp {
+		fsl,pins = <
+			IMX95_PAD_GPIO_IO18__GPIO2_IO_BIT18			0x31e
+		>;
+	};
+
 	pinctrl_i2c7_pcal6524: i2c7pcal6524grp {
 		fsl,pins = <
 			IMX95_PAD_GPIO_IO36__GPIO5_IO_BIT16			0x31e
 		>;
 	};
 
+	pinctrl_lpi2c4: lpi2c4grp {
+		fsl,pins = <
+			IMX95_PAD_GPIO_IO30__LPI2C4_SDA			0x40000b9e
+			IMX95_PAD_GPIO_IO31__LPI2C4_SCL			0x40000b9e
+		>;
+	};
+
 	pinctrl_lpi2c7: lpi2c7grp {
 		fsl,pins = <
 			IMX95_PAD_GPIO_IO08__LPI2C7_SDA			0x40000b9e
@@ -184,6 +380,48 @@ IMX95_PAD_GPIO_IO35__HSIOMIX_TOP_PCIE2_CLKREQ_B		0x4000031e
 		>;
 	};
 
+	pinctrl_pdm: pdmgrp {
+		fsl,pins = <
+			IMX95_PAD_PDM_CLK__AONMIX_TOP_PDM_CLK				0x31e
+			IMX95_PAD_PDM_BIT_STREAM0__AONMIX_TOP_PDM_BIT_STREAM_BIT0	0x31e
+		>;
+	};
+
+	pinctrl_sai1: sai1grp {
+		fsl,pins = <
+			IMX95_PAD_SAI1_RXD0__AONMIX_TOP_SAI1_RX_DATA_BIT0    0x31e
+			IMX95_PAD_SAI1_TXC__AONMIX_TOP_SAI1_TX_BCLK      0x31e
+			IMX95_PAD_SAI1_TXFS__AONMIX_TOP_SAI1_TX_SYNC     0x31e
+			IMX95_PAD_SAI1_TXD0__AONMIX_TOP_SAI1_TX_DATA_BIT0    0x31e
+		>;
+	};
+
+	pinctrl_sai2: sai2grp {
+		fsl,pins = <
+			IMX95_PAD_ENET2_MDIO__NETCMIX_TOP_SAI2_RX_BCLK			0x31e
+			IMX95_PAD_ENET2_MDC__NETCMIX_TOP_SAI2_RX_SYNC			0x31e
+			IMX95_PAD_ENET2_TD3__NETCMIX_TOP_SAI2_RX_DATA_BIT0		0x31e
+			IMX95_PAD_ENET2_TD2__NETCMIX_TOP_SAI2_RX_DATA_BIT1		0x31e
+			IMX95_PAD_ENET2_TXC__NETCMIX_TOP_SAI2_TX_BCLK			0x31e
+			IMX95_PAD_ENET2_TX_CTL__NETCMIX_TOP_SAI2_TX_SYNC		0x31e
+			IMX95_PAD_ENET2_RX_CTL__NETCMIX_TOP_SAI2_TX_DATA_BIT0		0x31e
+			IMX95_PAD_ENET2_RXC__NETCMIX_TOP_SAI2_TX_DATA_BIT1		0x31e
+			IMX95_PAD_ENET2_RD0__NETCMIX_TOP_SAI2_TX_DATA_BIT2		0x31e
+			IMX95_PAD_ENET2_RD1__NETCMIX_TOP_SAI2_TX_DATA_BIT3		0x31e
+			IMX95_PAD_ENET2_RD2__NETCMIX_TOP_SAI2_MCLK			0x31e
+		>;
+	};
+
+	pinctrl_sai3: sai3grp {
+		fsl,pins = <
+			IMX95_PAD_GPIO_IO17__SAI3_MCLK				0x31e
+			IMX95_PAD_GPIO_IO16__SAI3_TX_BCLK			0x31e
+			IMX95_PAD_GPIO_IO26__SAI3_TX_SYNC			0x31e
+			IMX95_PAD_GPIO_IO20__SAI3_RX_DATA_BIT0			0x31e
+			IMX95_PAD_GPIO_IO21__SAI3_TX_DATA_BIT0			0x31e
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			IMX95_PAD_UART1_RXD__AONMIX_TOP_LPUART1_RX      0x31e
-- 
2.34.1


