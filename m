Return-Path: <linux-kernel+bounces-531995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0160A447A6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32B55866946
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0EE19048D;
	Tue, 25 Feb 2025 17:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HYGpa7hR"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2068.outbound.protection.outlook.com [40.107.247.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539C118DB10;
	Tue, 25 Feb 2025 17:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503303; cv=fail; b=Yz1p7R8eRNMtZex+8GswolwYXkerKLAif3MHCf6OE2xl84iq9VgP6/rYkYHJ1vuo76zvYTrhDRy9qSJFcX9BcLwV0TOUXb4kgNurQSSkvXIoLBNvRNVcPRl9R7Z5RMex8NEJIqm5KTSIRnj/DuBPQc/t5Pa3KcuOBpxCrm2npz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503303; c=relaxed/simple;
	bh=99ZfC5hAPmu8W6QEU5oapLglhNMCwlKyYj92FBA7Oek=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=MQig4AVgbjZBwhheIRr2nbENHHq5Wgs6VrH6tYc/KTKet25m5sbyYeZkXhLQOAmiI+NtFHFUoSAQlsuxJd/nCXYa3T0hn9qMuE000yoxc5NpOPnxl69E1JMrNime1vLP/teU2vpkjwPbZdpLiZ9TEkmznGf9gVBpT5DOvEm5YN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HYGpa7hR; arc=fail smtp.client-ip=40.107.247.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fM+TTTrPQnXs0oYAcyWLQ7ZEhi4nX9t91dOQ/sFfej+g6ajaLfavNlvkV4T4SITlWJmCF/BJ15U50wqrZjWFodUbwFmsNpHwMJnoObrcBxEX6JKc20AaeNdmbiB/aVgjDF7V6RhUtQkHejlnFQ6UMkAzF0lXTg+tlcCCbOihKQSBFLy0hsfAIISV5XReaGo61Y+pAaZIfwJF4LJ/0ky6cWo5Mm6KCTXbJc+BWibRN5aNquVZrQ7vS8AEO0SYS7TGA0ZM89Q0V26mbN49s0jX2VKWJVrQoHJpfjGdoJx9R6G/vDbfxS0PRoInr+gSISmnwdbFZoZwOuSbU3SXChG6Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IyRcL0g1jRe+/iFg5sLskj4FCwUkTQfSPSOlEIXo7b8=;
 b=xOu7w3Iq1Rb/H+uokg7o1ZYpPATNsY4Ev0klXAhmll9RL/9YabNleID4CoeNVI0U3H4iGDUzwKQ3a1w5v5IMcJLlvX1Gwa4lQDK9369ibj9B0pnDHW4gIx4xFtQA8ArPDIrEbNoLyLPLSVJMpOPmOWq7y5OQajIm5FKZLECPl+QpQUdXbvwO+bSM6eWObMMR+w3hMq+XjHsO+aVlCDsCQk9q7Dlg4aWSXyhhC1W+D/YwHt883uzB7wmQBOeaelB8wkFSOxXz2ewkVM6pHpKbmiywGKSJHb3s2Au9iQG4wN0Y/wvf14dd8hQ6ODhy4RGuk/M7sAnw5sqHQagunmL/dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IyRcL0g1jRe+/iFg5sLskj4FCwUkTQfSPSOlEIXo7b8=;
 b=HYGpa7hRBmJXh7PZB9sn1YValQqzgYL4Z+TF6jzbm/13I9DngdE+1ABG1AbzvLK4K1Phzh2nOr5Ro2tH3gR5eKtFiiaua7uloRjgSdl1KmhHrOczYCl1DcuRpXPvnBvYxnkd+BZF8rzgvXb4+kfmV1ddleA6FaOqdva2DFoiW0Fvplgvmg4iroapfteEYwmjoUewvJ2NROf80FPXhYvX16axE7/TMJZ4Az0pWmT0TWFJHpft/Qdd1iq5QPgza0HXMlWdkjJXx5irFRWy9q7JIGOPW62OD+cEiLv0vKzWS/pseM5rFkyX38uwlbQbXF5ghfqHPq+iPSVd4l99HJy5bQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9308.eurprd04.prod.outlook.com (2603:10a6:10:36c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 17:08:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 17:08:18 +0000
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
Subject: [PATCH v2 1/1] arm64: dts: imx95: add ref clock for pcie nodes
Date: Tue, 25 Feb 2025 12:08:02 -0500
Message-Id: <20250225170802.2671972-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0025.namprd08.prod.outlook.com
 (2603:10b6:a03:100::38) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9308:EE_
X-MS-Office365-Filtering-Correlation-Id: aba17cdf-3559-4012-fbc1-08dd55beffba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x72NuTW8zlcDJRe/h7Rteoq0gTWlbUe1ViWeXtkM+GdlCcf3mIo7ixIqsBqa?=
 =?us-ascii?Q?zi3Jc42vrq6oa4Nzs2kKZSPvlj7qF96UeJ+4IPX2lk4j8XkRl0Qqpil2ldR0?=
 =?us-ascii?Q?YfQKO7fjvpF1e+i9tEE0pGhqTiKcgktDDwUB4upzKPjwzMayLFunLnKMw1H9?=
 =?us-ascii?Q?CoaAylnL7vAw3NQiAWz6Y3egWem+eL5Tbbzq3X1PT6I3XGpaoJU9C27KC3LN?=
 =?us-ascii?Q?z7eE3CCXNvaQTMSU0NtcpSR9aHkbw3EpJr+ohpwNEq1PSfCBDTdLw3LV90oQ?=
 =?us-ascii?Q?JD6u1JaZeSMpYCs6aYY2Xk14E5WdfNDwQbI+6K4MSxU8F9Ofke8i44yKClwp?=
 =?us-ascii?Q?9n3vRZOumM7sc/6/k2XQ/2jxrShq1RqavkERjD7l4W38JsNr/kKUJzXfk434?=
 =?us-ascii?Q?GZz5XjYQFHoFHSzhlBWkhEAmiucEmbYzyG1CorRdTb7cdyosKXmsdgfIRHIK?=
 =?us-ascii?Q?cwsZOCHAMVvQELkM2UyeqfEQYwMcmNVhNL5Tx1Wi638XdOXUiR0Pwba3oBzW?=
 =?us-ascii?Q?CBfE717DYmRfwze450CboT7GqE8Ibm1DDL5TyNVUOVdD2y/FN2FqNeAwRK/8?=
 =?us-ascii?Q?HPhsSmyeun0cmiT5YwqUjwchLAGEW8meqHgqNwOYlbGyDo3wznWBia7pCISf?=
 =?us-ascii?Q?4LTdqbiT7XcZBGx9lm4cfycOW+gvlWa1EOO7kHC6juiShh3ub9CQHBzq8Vnt?=
 =?us-ascii?Q?3UarIrJ/qQy9D8+bYPExx/3N079Y6H2g3pzT34LXcOac3XQQGpVwCRGFW+ZO?=
 =?us-ascii?Q?uIg2d5pNqNswItfjc2IixmF30blcO77CtxWqfsoWjhVUUVXqitmIw5eYFGYQ?=
 =?us-ascii?Q?JBBO4svoirNiM+xWULduCABsQgRxyxnn8e+DbLNaP94YVrnsINNgxWf6XdQG?=
 =?us-ascii?Q?f/pzsS5j6c11dkEYGyU3PEGkMjZm751aXl0JCDjdoniOZSonz5scDCO91FSK?=
 =?us-ascii?Q?L+epWju7Saf6fFbWHsVXdyq+hcjYGn6LesJrn2rS5vRgeXchnFeVXmIyG/5w?=
 =?us-ascii?Q?CDbw8rzwoCbOVktOibGHQkZru8te34dJBaz8driOf0XU6/bV1pRkZjWAI1iI?=
 =?us-ascii?Q?owRm5B5lo0GIHMNXvvo24xu2TrJxjB7iGOKtFQSCIP808d/Q2xcXIIQazSCR?=
 =?us-ascii?Q?Y2aCtJfjYGJNWsqBE6/UNsWxXJJ6PoM4+ZWFlDMtTA8Oy1S2HgDJj1pKgLPt?=
 =?us-ascii?Q?PCXJZ5iYz5Gji969uDvDCuI6llancQEgOvkpX83Tk0Xz8dcvFZo9LxgpqUOW?=
 =?us-ascii?Q?CBhJJeuN5BMICEDIafly0eooGITVxSXkolNJswe6Yfq5GhC8rKyLIKwitrfp?=
 =?us-ascii?Q?iFhXhTXgsOyNt9UG9asP8vdr9P5NEsy7VUJiq9nTxApFkOl6KsC80Ak3/UAp?=
 =?us-ascii?Q?9x6WjtYKnlkm+iiHJRlIT/Ev7/BKUp5bfJo7i2cfICjXmcGNRg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?urwJiDWfTbvJ3HgWjgCsr9FcF14wbhleomOIzqs2UzNYRmmX6V0xSvOtaF0r?=
 =?us-ascii?Q?V7eHGbeJ2xH6XZsCm9O5EYbXYldyYU5beznxp/vHY8SUtkB9ATxjsMKEPZHq?=
 =?us-ascii?Q?4iHpyf79Y1KaHPa54uM6OzbJ7WeBP0oE0HWzXqAO8zTjWp1nEROQTl5Q84iB?=
 =?us-ascii?Q?Dzv6nWZlmh9hcuoHfRXO60qgd3+PDmfTAeqlbrn9j+ez4EOvYb7J8LiM72uI?=
 =?us-ascii?Q?FqvDiJ2/emNRg7xno+0YhPJ4XyT7L16UVHBOOn4CN2zhwmBgWXNG8Rdfx2w4?=
 =?us-ascii?Q?hmWgqKXi42viPvSCDTFztU4CO2WPSCmkpyOfWu+KFYtfmmzHHQzWHmc+1LLM?=
 =?us-ascii?Q?iJQSAQL9yxX3BxlXmpu13Kv4ItMcjW9jEbH74Of9b4xQhAPHunPvygNH1S6W?=
 =?us-ascii?Q?JAVbPfiqqD44z3PTeW1CfssOOcSJ4gT6W+8PvhJGk3sZJaiScd6wrcP+lOFp?=
 =?us-ascii?Q?seW1yuvuIq/S/jMNiPXvF1kLqFs2rY8111Bgj/0RFU84xARviM/6mlARjEw4?=
 =?us-ascii?Q?hSU4aDZ/Mkp1zw4sgubg40Ilpq+icY3vAMCLKhYn3lsyE6Re0wrxCbTPDC64?=
 =?us-ascii?Q?eoexIrLYlFoPJeTwUvWEcENCQYADvezuCROIJt77mpF+ZAAWjqDLV+xuaXAN?=
 =?us-ascii?Q?//J0IPgEfJ5cFu9+0Abf88/cjGw5XRk3FizRVKqXHb0DU2mi8gGJZw4er32i?=
 =?us-ascii?Q?CKewNLTUeD7U6klMHn8b2oH8Qlqjk+JV/pRK58VIsq+tmJgKP1roxzpuKrfm?=
 =?us-ascii?Q?HhFp8FLQcbgkjSV/7JfLtI1VeTxVGzUi0fYJzGsgrGOL7JCgkyiCCUYZDDY2?=
 =?us-ascii?Q?M1m0fKNwyfWCk8n7W5plniUkEZtrcXQ2gXjDMXexUYVXNu9YElnj89crf4um?=
 =?us-ascii?Q?zjVOgMEvnwFM3b/dyTHasPLaBkR5ARHVoT3dPzNxIKrFCzpHMFs75VRd06Kd?=
 =?us-ascii?Q?NUKuaucdyttVBeNiiaXbKxQjjPMlCl/TcANngrpWet4fwTWYdGdNP2vw+Og6?=
 =?us-ascii?Q?NVC2wvFcMN4kjfssCf40gTR/HrQCQQOPtnvtVmTh5VEmI/3xOm1yNmmV7TrH?=
 =?us-ascii?Q?0YGXJhr5AqbIPYoVH8rf+yZ5QDhVS+PPkx0Uh4gLqM7OthAfM8cbMk8jirxe?=
 =?us-ascii?Q?znLZBtauFkEyzywDK3g+GoeNgq2hXZKOPTXhhnkpXVY4ktPpX0zUVKMAv+ab?=
 =?us-ascii?Q?LncZcEDBMsdblfvNRCPrnjkjz8ektMvuuZOPlAfHg7wl6oh/a3ptFzjWQpTy?=
 =?us-ascii?Q?ODFInCb+mY7Gq5mXFSjVvVEfbfz+3OKOfcV3tXuXk+o64hL9hCgjlCNMUVT6?=
 =?us-ascii?Q?NDjdqYKnXqJOM+2Qr9x8epsfsTXHKY9jTf6e4u2CaVNPVAjsJth3r3YYGGCm?=
 =?us-ascii?Q?tftSWPLFVMZSprvyTu4UdJXlnBk7Tp43yfGe0usrKetAIK8gzT5pjdKInvLu?=
 =?us-ascii?Q?GWrB5JiDFlnwpLvK7ES7o835cY5uWP4IR9QFGGHYGiH66pwi0h0R5MNStrVH?=
 =?us-ascii?Q?Ocm3kmG8038LuB1jMUJVa9KUa1fPbEE6kgk/yPTYUfPj29WxIhLXWp6wkh99?=
 =?us-ascii?Q?N/erwzTEAU/YkRVcTdY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aba17cdf-3559-4012-fbc1-08dd55beffba
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 17:08:18.2506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yO5mzqMj/LMgh/Vnl/+/vXUv5qWLCyVDWTQapiY0cm11okfyjBFZP2hYRJh3mLTY+8U3VIuTn/kuBeWRlu3ZDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9308

Add "ref" clock for i.MX95's pcie and fix below CHECK_DTBS warnings:
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: pcie@4c300000: clock-names: ['pcie', 'pcie_bus', 'pcie_phy', 'pcie_aux'] is too short
	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v2 - v3
- fix typo 1000000

change from v1 - v2
- rebase to dt/dt64
- add clock 100mhz
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 25 ++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 51625bc9154ec..9bb26b466a061 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -291,6 +291,13 @@ sai5_mclk: clock-sai-mclk5 {
 		clock-output-names = "sai5_mclk";
 	};
 
+	clk_sys100m: clock-sys100m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+		clock-output-names = "clk_sys100m";
+	};
+
 	osc_24m: clock-24m {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -1595,6 +1602,14 @@ usb3_dwc3: usb@4c100000 {
 			};
 		};
 
+		hsio_blk_ctl: syscon@4c0100c0 {
+			compatible = "nxp,imx95-hsio-blk-ctl", "syscon";
+			reg = <0x0 0x4c0100c0 0x0 0x1>;
+			#clock-cells = <1>;
+			clocks = <&clk_sys100m>;
+			power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
+		};
+
 		usb3_phy: phy@4c1f0040 {
 			compatible = "fsl,imx95-usb-phy", "fsl,imx8mp-usb-phy";
 			reg = <0x0 0x4c1f0040 0x0 0x40>,
@@ -1633,8 +1648,9 @@ pcie0: pcie@4c300000 {
 			clocks = <&scmi_clk IMX95_CLK_HSIO>,
 				 <&scmi_clk IMX95_CLK_HSIOPLL>,
 				 <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
-				 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
-			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
+				 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>,
+				 <&hsio_blk_ctl 0>;
+			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "ref";
 			assigned-clocks =<&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
 					 <&scmi_clk IMX95_CLK_HSIOPLL>,
 					 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
@@ -1706,8 +1722,9 @@ pcie1: pcie@4c380000 {
 			clocks = <&scmi_clk IMX95_CLK_HSIO>,
 				 <&scmi_clk IMX95_CLK_HSIOPLL>,
 				 <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
-				 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
-			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
+				 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>,
+				 <&hsio_blk_ctl 0>;
+			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "ref";
 			assigned-clocks =<&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
 					 <&scmi_clk IMX95_CLK_HSIOPLL>,
 					 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
-- 
2.34.1


