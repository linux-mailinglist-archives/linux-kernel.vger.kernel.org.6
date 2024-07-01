Return-Path: <linux-kernel+bounces-236968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A193691E930
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 22:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D00E282493
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75B8171076;
	Mon,  1 Jul 2024 20:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cK9mOG7+"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2087.outbound.protection.outlook.com [40.107.20.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E5416FF47;
	Mon,  1 Jul 2024 20:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719864472; cv=fail; b=uA7Rl+myqcnjdrGPhFh13jb0fKMbs2YNfP6RMZYY2g6s0Cb8YWBT6N1sO9nqzshYgC5RmQ7Zk3n/tpbpcdeo72d+Rh9eQdHnUWzQiM0EY9OYokOPhJIRGkTentw7x4grmX/vMz6p93pncmJnOMtqCESwMbnlynRFb7kMuw4BlK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719864472; c=relaxed/simple;
	bh=hOPKPi/cLz+ZFoUbpqohNrYHC8DLS1oK17oCXXuRzME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HNsC6ZDiAzgYsMCZB1jMA06/xby0mSyOTRBnZqGkvUlNLL/BXSL8xZNCJ6U1lKP45cMkDPubz/U3jw5jJd1Mg2RIwFg4SGG9VoYg5NBLWffgEn/i/FVGF5btToT/GP3L1kprTa5G4yu5kJIAkl1Ut4Naobh24kLHCOAUbxgiIkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cK9mOG7+; arc=fail smtp.client-ip=40.107.20.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evj1lSqX9pm2zJTQdfYajyYMEH5VKJg3dP780kergPHP/4D+7j60qnm2xIhTMIBYYNJ/+SVOcRzU3FTPZ6Wlyil6W+U/g2+oPzKRLHIgxl6wsFJGikd2F6kKqirKMPeBelivQfJN3rcMKQZDNMlvtIrQiMK+OzMa0FCbITcyYHqbz+4by9flW2RMoYQ7cY5fs9vVoczWtDrtR6AOP4OCe1PxYgxVU0QybBpV0+lzKeB+zTruNxtl2TnKLjuaB83x38OHMRHXnU47kKvDiFyCl7quQO8wAGcdc4R1xmAazBkTucwMlMhw/B4ZcKzIVc2ILArk9krv/QaNAYSdZG4m+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6l1OBpPQ4KwLUyNpjnmY50jFtE2Yrjo/uLTxxTojol8=;
 b=axtem1+MGFgkZgH8/iLrhiS3N2wzyCf4cdRbnAckE/DjuVElIa1mRB9AIKYgljIx9KR+FTa0nXZ6KIcDOXsicVCFmcil3PkXozug2xNhn4e2PeQ7ci79ZufnHStdnij5viUn72JbTVEBL15mF83OFpcICGYlot3G3YSm5eGg8F8WlmnG+MbvoTo8PWU5/8EOWRhZIBvjBQ5QY9rwgv4MW4L6PCY/+ORNLRXi+Re/KarRsOJMsfKsuSv7ZJGYpMzBZfXHAgp+o4OpboR6zlgitTDpnaDmrtH9qSfmo5pcw/Krcvu1fWuXKtTBp5RLtG0uHzoOfu0ZtIuXzmF45ELOvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6l1OBpPQ4KwLUyNpjnmY50jFtE2Yrjo/uLTxxTojol8=;
 b=cK9mOG7+qQ7XiSlmd1Ag2FPvnIxVGyICqnr77SAWXeERMj9KZ/BEDI2qrMNWftP8ZHr/gOZIUK8+cUVVIVUo8/RLuF2r63kk+QHZnd5nzM55rLeHAycorasPSrtJc6SP9sYT2Ye6fNf3fDTrpA2G8qFGye2y9qJLFGQVVN/6hHw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8638.eurprd04.prod.outlook.com (2603:10a6:102:21d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Mon, 1 Jul
 2024 20:07:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 20:07:48 +0000
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
Subject: [PATCH v2 2/7] arm64: dts: imx95: add sai[1..6], xcvr and micfill
Date: Mon,  1 Jul 2024 16:07:23 -0400
Message-Id: <20240701200728.1887467-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701200728.1887467-1-Frank.Li@nxp.com>
References: <20240701200728.1887467-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0079.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8638:EE_
X-MS-Office365-Filtering-Correlation-Id: 12f94c9e-e805-4de2-eaed-08dc9a097abb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MzM4UwRo/XTEXBfwr51WgSUqXaJyV/0+Ql+QsXXRt6A7djpUp37bc0dh7tPu?=
 =?us-ascii?Q?FXN38lDDskwqcIbX2/9MBKogBQD7hEDx8YoSfzFZ0ITIByIlmEqXhIq5n5kA?=
 =?us-ascii?Q?32YT87TYloMTiO2GNfVn/CJhVpmhBPf1JU4A+H4RDJg6zhp2ZwqUPtrq3HON?=
 =?us-ascii?Q?t1njezqL1YktYFfGsVwmm8Jhv/oU0Qrb7ogJ8nKStSaFR4I6toPn7CRgeUuU?=
 =?us-ascii?Q?mHrtT/ad44N4z3OvrY40X3r413T2bveqzkjPUCowVYCJ5/r1RleIJUu82W1I?=
 =?us-ascii?Q?alGlEvlIG3aqjRdwUSvqid1lOn26k0xWhk+dxMmcG4F9qBWMV42koTy432q2?=
 =?us-ascii?Q?1bMFPATNSaPhncLEXEFRuJqF1+9IKLHEBzg3GQaYVlfP1MoJRAKlPQl3t+eZ?=
 =?us-ascii?Q?idszyVxBhwucey7SMqSSb8MJ3fMunRbInOT/9f+dcOgyU868BkOhFWdARJqR?=
 =?us-ascii?Q?hLVGUN6QSCPCHqea6tYm9dWi/lzpX7T1MTEJadTf+Uqv5emHGOQEMPXIENey?=
 =?us-ascii?Q?hknINR5HbreR8GiXmJDPXDS+jOqKIp9UQOrs3IJL38x1VLs+tM0YFsVwhALS?=
 =?us-ascii?Q?z+LyQ94jJQ247ExWzLb0igLWNKf6HKhZ0+oD1pZmkgliHL/otzIdATqTrchC?=
 =?us-ascii?Q?4Y9F+L5rzxdLlFpngg4KrbYQlVAol9pGPyhqQf78th9nXNH2sSgfuZS/IRib?=
 =?us-ascii?Q?qUVxcD8Jt705BQGga73yV5FWCa/Bh/d6b6SkF6OfeRzPDQ0PSmzxb/1xat7V?=
 =?us-ascii?Q?7lkKcOUp6gJXEde+h5muYL18xVTczEFiZRU2vGBtXISbqLIYcuLGSx3RLauz?=
 =?us-ascii?Q?r1jLKt2qva5eAl654hXJSqc8AuRjbB3boHfszRy/OIWIW3ttRa3AQaz6pYWY?=
 =?us-ascii?Q?eP7/JRa0li809mePJ98GPygOHLMmw7CveYFUm2NJKNiIJwfalH27o1kqvd56?=
 =?us-ascii?Q?hfRt4UdMNfJhEfFZFC2F5+blZiXsOBpMqp5pnicDj3OVkHG0BhgSeICQs+Cn?=
 =?us-ascii?Q?w+24keiZRn1XlE57Grva4rBEdiji1XrV2CHs1U2jnIo2Ac20xGlg5snZPShU?=
 =?us-ascii?Q?+lqKHSwhdswQpRk7JpPuB66myP65H7B0nUq3L/P5iyqZyLenNY16fSmn6PYi?=
 =?us-ascii?Q?9e5LFn9fiCEuyRUYnne/dQUG8guv21+CiIVov8PWVyweD15ukIcrJHZ5K6vL?=
 =?us-ascii?Q?uu44KrMvRXoF4OOAsfprDHfaKZYo3/p+OCrc30ppdTjeIFC2y0PqFa5AkNcc?=
 =?us-ascii?Q?2BzRJaVt2g6PN5ue+V4T8Zok9O1PAxSXm50sD1Xiv6IAvjgJXFINgSwR9964?=
 =?us-ascii?Q?79Nx26lVjRVDJhRgj55jym8YAzQIcYA0CQjKc5TN2QgiAaXknCboOCZUouG1?=
 =?us-ascii?Q?48gxLRYaskivOL1pxynEb7ZjCUp4y8ftqBPVk/k5vpfnVquhBMjfTX1v9Mig?=
 =?us-ascii?Q?L7mo99seDko=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jNNcvIkj7r112h/ZsTY2I+o3NslUEY4RpGK8PVBYZ8Cd/89PJs72xO1ZCAlK?=
 =?us-ascii?Q?jXccL2NgFksWhPAik3U/wfOR+egnOmEMxQ3TTnzYtILDRD9QSpAn3yuLxoVl?=
 =?us-ascii?Q?sWtI6EAfUhDEBrSk9cf7KpQ9SeLdPvzF36VQDk0WeUoTGMeMxvTQASJQ/RKB?=
 =?us-ascii?Q?v//+lkjryBA03DAiAQ4kFjiU/GnGFN72vh7nLaQmEq6075Sn13TBSaCTuiIm?=
 =?us-ascii?Q?nuxqeM8GS29IWAjcZlQndg7lGJGEToU7a623Z8EnVk/whTEx2k9X969FjGqg?=
 =?us-ascii?Q?Dl7KRKGAKzAOwSRt7wv00QQDo8zvVel8SN7y6WhNiYJKs5a8gEErK6DJ3fkS?=
 =?us-ascii?Q?eqDM07XuYQxunQFlzI3ZlsAPmjd1rWvcXwJl2lpZtVsroxHetihQV7ccrFQw?=
 =?us-ascii?Q?4s1kcvGHf0oElRA5ccgcMenruCzUZsr5NKsQlTK5v12KLP4v5YqLcPxrxg6e?=
 =?us-ascii?Q?niNufcC9drUC+0HolDLyj1nTLvlcjlPdNZyuoKgmuFawiRC+jyGTJTekWm6Z?=
 =?us-ascii?Q?FKZMVJ81gA2GvUQIU/0mpO8gHWfgvgthdGUcxIhkEFT8fJI9PcqeC94QYFJc?=
 =?us-ascii?Q?t+XJuP/GhIikTc165QwzM53fTAUrIFwxEMlKzP+W351JZlEVrOpZlkzmpN5Y?=
 =?us-ascii?Q?NjioO5yAzBbLanv5hzjlbVgEHeOQXzoXzj6AzbHlVNrF8qDn49MVQewekJUr?=
 =?us-ascii?Q?iPNhUGWZAo9tXtrgYXCJfWUWRICdQjQeEx1UzDi8sHcmwWGRWbVztQ/uq6n0?=
 =?us-ascii?Q?NKVMcQqlRt6/kofze2qctkqb64gqIW8JhrPZ/jeydpD7t7cXNPw/cxXh75iv?=
 =?us-ascii?Q?JLZawB1eqtJb45UJpZIy4+wo+83GFeT1IrOHgcuafT6VTM1FocIcoKV4Py5X?=
 =?us-ascii?Q?k3IYO+A5j77J9noPKj04zU5GsDEpdX2H9lEtzFXnPD5nyTpDpXavyApSkjnR?=
 =?us-ascii?Q?pMF0CU5ojtkUsurO5UrjNmQj2R52DDqOtcydi0+4HQeskBOBcDIJCKvXapmT?=
 =?us-ascii?Q?aQxQyx/p67sG7J1w1ajrToVl4AcjSHuN6aZXu8jrVlUdRgP/V75gJF68jTf1?=
 =?us-ascii?Q?KrzftPncbXAaERxaIT4iyPJkDShNZLgavcKUz/E7qOu09WMCPIDrmfxet4nj?=
 =?us-ascii?Q?VebvMFrSi9dW8yhcw2SUxcfI0oGBZbMDhOJLDr9yhFv9qA5IhZVJVFdAZ2y4?=
 =?us-ascii?Q?jlL5MB9ZGHYY5IfEb52+bCGN9rpikA4S/MYETxB/hnBfeWI9up/Kvr90KaE6?=
 =?us-ascii?Q?SMGW2SIJCAFtUQzN9Nod4i03Q/u5/mJJxfcOa3OO3pvz27cHZdD80iFumPqp?=
 =?us-ascii?Q?/aMK7tLO3I+K14S5725QuU8/EKNmCQesqSBAEuf8ysg8wV46jZHpzPZbsYqG?=
 =?us-ascii?Q?Fsbkzh1ALSflRVF6+y93ohT1pjiYwQFlvpf+jQKbumhOw19jJFDecUefe2v+?=
 =?us-ascii?Q?5jN6BH6GsV2V29Focn7jMeBzMnA/D6ioYtGRFEC8tXb/4kKrJ+i7X77CiZEN?=
 =?us-ascii?Q?/86r4sDUYkpciBvUnWt2AEK+W5gbS0AygXIAFzvc22DW9+SqtFAiPi9d/Y0Q?=
 =?us-ascii?Q?JjINmfVpH7uaosryX2I8VNMyKTAD3K73KEHmYtW1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f94c9e-e805-4de2-eaed-08dc9a097abb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 20:07:48.5602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xK+KngjbXjERfP1hSOraPT/7vwHVGTmMMqhJJfh9SEsaLPxjmUvn88UO4fkrxIw2K4s721ay/TCRnZIohHoafA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8638

Add sai[1..6], NXP Audio Transceiver (XCVR) Controller and  MICFIL Digital
Audio Interface (MICFIL).

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- Add Peng Fan's review tag
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 111 +++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 12f7ac52c2589..d32127cf7018a 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -222,6 +222,13 @@ core5 {
 		};
 	};
 
+	dummy: clock-dummy {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "dummy";
+	};
+
 	clk_ext1: clock-ext1 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -706,6 +713,64 @@ lpuart6: serial@425a0000 {
 				status = "disabled";
 			};
 
+			sai3: sai@42650000 {
+				compatible = "fsl,imx95-sai";
+				reg = <0x42650000 0x10000>;
+				interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>, <&dummy>,
+					 <&scmi_clk IMX95_CLK_SAI3>, <&dummy>,
+					 <&dummy>;
+				clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+				dmas = <&edma2 61 0 FSL_EDMA_RX>, <&edma2 60 0 0>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
+			sai4: sai@42660000 {
+				compatible = "fsl,imx95-sai";
+				reg = <0x42660000 0x10000>;
+				interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>, <&dummy>,
+					 <&scmi_clk IMX95_CLK_SAI4>, <&dummy>,
+					 <&dummy>;
+				clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+				dmas = <&edma2 68 0 FSL_EDMA_RX>, <&edma2 67 0 0>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
+			sai5: sai@42670000 {
+				compatible = "fsl,imx95-sai";
+				reg = <0x42670000 0x10000>;
+				interrupts = <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>, <&dummy>,
+					 <&scmi_clk IMX95_CLK_SAI5>, <&dummy>,
+					 <&dummy>;
+				clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+				dmas = <&edma2 70 0 FSL_EDMA_RX>, <&edma2 69 0 0>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
+			xcvr: xcvr@42680000 {
+				compatible = "fsl,imx95-xcvr";
+				reg = <0x42680000 0x800>, <0x42680800 0x400>,
+				      <0x42680c00 0x080>, <0x42680e00 0x080>;
+				reg-names = "ram", "regs", "rxfifo", "txfifo";
+				interrupts = /* XCVR IRQ 0 */
+					     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
+					     /* XCVR IRQ 1 */
+					     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>,
+					 <&scmi_clk IMX95_CLK_SPDIF>,
+					 <&dummy>,
+					 <&scmi_clk IMX95_CLK_AUDIOXCVR>;
+				clock-names = "ipg", "phy", "spba", "pll_ipg";
+				dmas = <&edma2 65 0 1>, <&edma2 66 0 0>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
 			lpuart7: serial@42690000 {
 				compatible = "fsl,imx95-lpuart", "fsl,imx8ulp-lpuart",
 					     "fsl,imx7ulp-lpuart";
@@ -1124,6 +1189,38 @@ lpuart2: serial@44390000 {
 				status = "disabled";
 			};
 
+			sai1: sai@443b0000 {
+				compatible = "fsl,imx95-sai";
+				reg = <0x443b0000 0x10000>;
+				interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_BUSAON>, <&dummy>,
+					 <&scmi_clk IMX95_CLK_SAI1>, <&dummy>,
+					 <&dummy>;
+				clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+				dmas = <&edma1 25 0 FSL_EDMA_RX>, <&edma1 24 0 0>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
+			micfil: micfil@44520000 {
+				compatible = "fsl,imx95-micfil", "fsl,imx93-micfil";
+				reg = <0x44520000 0x10000>;
+				interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_BUSAON>,
+					 <&scmi_clk IMX95_CLK_PDM>,
+					 <&scmi_clk IMX95_CLK_AUDIOPLL1>,
+					 <&scmi_clk IMX95_CLK_AUDIOPLL2>,
+					 <&dummy>;
+				clock-names = "ipg_clk", "ipg_clk_app",
+					      "pll8k", "pll11k", "clkext3";
+				dmas = <&edma1 6 0 5>;
+				dma-names = "rx";
+				status = "disabled";
+			};
+
 			adc1: adc@44530000 {
 				compatible = "nxp,imx93-adc";
 				reg = <0x44530000 0x10000>;
@@ -1423,5 +1520,19 @@ pcie1_ep: pcie-ep@4c380000 {
 			power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
 			status = "disabled";
 		};
+
+		sai2: sai@4c880000 {
+			compatible = "fsl,imx95-sai";
+			reg = <0x0 0x4c880000 0x0 0x10000>;
+			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&scmi_clk IMX95_CLK_BUSNETCMIX>, <&dummy>,
+				 <&scmi_clk IMX95_CLK_SAI2>, <&dummy>,
+				 <&dummy>;
+			clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+			power-domains = <&scmi_devpd IMX95_PD_NETC>;
+			dmas = <&edma2 59 0 FSL_EDMA_RX>, <&edma2 58 0 0>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
 	};
 };
-- 
2.34.1


