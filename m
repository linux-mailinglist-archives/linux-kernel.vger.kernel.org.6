Return-Path: <linux-kernel+bounces-233067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6AB91B1E1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 00:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9B55B21A33
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 22:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC071A2549;
	Thu, 27 Jun 2024 22:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g+2jpLNl"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2041.outbound.protection.outlook.com [40.107.241.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52F419CD0E;
	Thu, 27 Jun 2024 22:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719525625; cv=fail; b=RBSGumQtRcCfGMU49PadX+YQvGLFat5FFjNdW7yjsMYPWS6X4cVmtuDrA1fELsfE9YMeNtSdVD9pzwA9QHHA0pCSA5H3O8TaCokVd3KxvaLloTpESTi/qwWSECBsiEeDh2XbB85lD4jsn5ndCvZHX5LaLSJI2ZlnYNNOlfitbio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719525625; c=relaxed/simple;
	bh=1QPhVck+8vl6O+Hw6+vyhAw0vdGpBk5HrKrOmVnKBOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jY8oEGdp9Z1e1ZpT4RIzO6wnacISjTsVWPjb3lbr1jQC2gRfrUM9L9ildgWzLRHyv8MyZbhpvcUyHZMixS0/uMrDZ8uTfOVuygMWUz3Jf5HQnLeWfWKrWOoi8nLKkdby6s1oV1TSvb1fHxZqhSZzR5KhteZnybvAX9SLvylp8Do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=g+2jpLNl; arc=fail smtp.client-ip=40.107.241.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FE529TMZNdBsbvYCwaB+SEjp0QyxKO9yoCVf+LER4xR8bq6vo87RmA2j6SSO6OW2tp43Vnv2kHjOBoV5wxT3W/ZuHGnXMDe5xfUTIkC/xdWNjFBYh6q0ID1r19DBN7DIpUdeUTCLyWgD1IhBJP/p2G2gmz8Lr2X/r4oGb9lUNnXl8DQUPRuYQWwdiNDXNrSuFc/Lbd5Zvn1vQMQqOam+bpU/LkbYzFvrudVXekkvKKrCNxed273c9vioazg4WhdBRXIPxwGprXbOD27f0ipqBBJLd/VIlT+EWa9zIR3S26itWnje4MZNjeocwHJ5XoFtvyXMVWH8QE0Y/ELhXqh40A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrEydm4wBP1ZJ7lpvkYnhmT6/fih9oki6mMdnoJM+oI=;
 b=Koj+jSbBkt0CU3H3puETWuyLaDuS76yY9tmGeojN6YirKAT76o89qSBZoFU5fIHC92sQM+T6rKiy1pcCzG3o7FCQrAsiRshKQBXzx8KDSlPWDXjg9YoSlX07VRF8DA+v6VK0CioENCXl/FyR9hBKqK09rKh2a1JuDrJO+jbu4rtKiCdquKEh5k1v1/ifm+CISUidzM2YJB3yy9rsbjnOEF+WLKJiZe7uhLm/E6Vldohs6eNNEXgyQZVpPcaEP38u+jzC7J/G2nov9xmLb08bYoHqMrZT0cT/K005I71bZpSEcdShIWBbXVHqbbAq5p6v+cTyXQZDkWBU+JpjnTnnqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrEydm4wBP1ZJ7lpvkYnhmT6/fih9oki6mMdnoJM+oI=;
 b=g+2jpLNlht73fV+T8enS1V+N90fMg6LC5zoAqMi3OgoQPm2mKC99z9jbdciaCRzvWgxBn2SblujiRFE4l+ZP3RbyElfgkAnfhGUzD72tTmriZ2/Derek/z3tQBZT+trx64AL7kcSX3yQoGAIXtXI1IiK5yXbNpwHtSO9wWVxgnM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7259.eurprd04.prod.outlook.com (2603:10a6:102:8a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 22:00:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 22:00:17 +0000
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
Subject: [PATCH 2/7] arm64: dts: imx95: add sai[1..6], xcvr and micfill
Date: Thu, 27 Jun 2024 17:59:56 -0400
Message-Id: <20240627220001.692875-2-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1b9c2f65-dc85-4286-e062-08dc96f487eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|7416014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GQwfi4jbFnUtONz2nGeYulF54MZbw45P9HGKN+876YmNufgLa4sD48O6zA7i?=
 =?us-ascii?Q?IS9/j1Iti2AZXl/5DTb+FVFBZ8WIV7kIW3IQtZFpL1EdYpMLwOPpK5MLFxME?=
 =?us-ascii?Q?S6tOHLMsVY4Od05AHhKod6QReA4FSuRNOx15aS+qkuG+4BG02p42aLrgGA3m?=
 =?us-ascii?Q?AgH+0YNkfSzp171H2puWKytXZhNrASQYmxhFCC8ipozxWSK3YzWpis+JwN+b?=
 =?us-ascii?Q?p0mlrMlbSsuaH9RnwiL+RNoua8t3mU6WaF6H5JaQ9REeQ6xTYhM5QJwGRKUf?=
 =?us-ascii?Q?oa+1VZ29hBZb44fA9ETfmZyQ0lVC0DrduIjqnmTnmTn6AlD1aVZk0f3x9Ff2?=
 =?us-ascii?Q?Dpd4b1S0v447PMzUk29g1xuvyakR1GicQDRd/XFsR2KWtlO/8Jq8i/DCxfAd?=
 =?us-ascii?Q?0XcQl/qAUg0C75gMEKIRgoCjWf8d+jxjtM4KQP3AW7g1lit2U8Bag1UlVz/U?=
 =?us-ascii?Q?LoewJn1RoBFIGuga1jdvmByy350+CntiiVqwAKM/dOzEqTfW22fgxT8bFIbI?=
 =?us-ascii?Q?q7Sssk7dIhri3YK3Fw5RnoJzVlhQ0wrcZ455zwJhnuK1NsGq6mc8Je2sG7f4?=
 =?us-ascii?Q?iVAubYneCJfMCx0rOm+2MRRW7HrmQYg5bv11cTNvydXXVdoqRSS3EnolzfmO?=
 =?us-ascii?Q?5vzDRpnb6wNKa0JF9CAhObG1zmI0y16/ssM97lqS0YGzX3LJ7/oiiIFjf+UH?=
 =?us-ascii?Q?ePAxRNTIuhlQXE2ee/kubDZfx6wcwU1bnFzPCSJ9NNT66BXqwKx3doDUbctW?=
 =?us-ascii?Q?wYHQdRLtbwPOBnmyed46vijzCnROi2vBDL85B7quJBg1Qm/Fha9cyZqaA8/7?=
 =?us-ascii?Q?IeHNpBhxBAkX8B6FgCIBzK4vfzcz01r442KNv5zDNCS/bJU4TMJzcUn3Z5LH?=
 =?us-ascii?Q?yS1xIn9pJF66SFnA3vV6xRxNAJPMmAVQww1jUvOIqFLr7kvEPSFF1fP4KClI?=
 =?us-ascii?Q?qczuCDMUiksYxkBjNM/zaxLZ84D/Om262Ny7qnLFTkwaSZhsqqkVNY1VAm69?=
 =?us-ascii?Q?ED41LBrnIb/VWWQ/gLO7DTCYpLcv3pIXAXCmGQL0n0w7yopfsaHDmTo76hlf?=
 =?us-ascii?Q?i57day4BkWzkeLxlk5IrqX3svO3DZu1uyq9DetmKz+hmbEhAu4fVoo918KaY?=
 =?us-ascii?Q?mNPKfJ5y02Mf/ZreEkkbkaMJJkyBsR/sqz36oSXUri1ue6ow3vfXQn77wfgb?=
 =?us-ascii?Q?79CaTpCXFzxZNbcSHHuIYkE+l5UivMs2T336NdEN49spY16HzYwTD4jD6h35?=
 =?us-ascii?Q?lWRLLGIqJw8itroxwj2gtZ18HTNZqWOVzgUiH2wD17IP6ZPNVx4fSgqHtrcx?=
 =?us-ascii?Q?OLO/lUoTnKNtmeGPNVneZJR0alNyNZKHtQQSj3iMiHnhkGo3H7VRkOL99k7/?=
 =?us-ascii?Q?x4vTANww1W/yeqZErFxAqfDwACbgAQxe5XBzlh8ElAE2Il48bLzEvl51cyCZ?=
 =?us-ascii?Q?P/uDkt5Qij0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(7416014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P4+5oV5LY6DKZhs8QfnuAFlIVctKKJ9MPPnETz6xxqyf71mOt5Soh/o0Xepx?=
 =?us-ascii?Q?iE8yYTI8G+87la8QKGaJcWIC5byyYQMESyKjC7N3Z4WpqPutPcIX8cMuCbws?=
 =?us-ascii?Q?HhDAJ2rBqlt+jAIxKul8H96W3IMNJnbYsWDMOS2prVtx6RjbWc8To46+kHjO?=
 =?us-ascii?Q?DtCIsUB1BonDDIwGNhA8AYD6JmfU41YoccuGNFBLJX4uDmTOlP4p+HxBJixd?=
 =?us-ascii?Q?TofYeZGZOEHD7PY5v8F37gDHexFOde9rOe/LzKr25ex3XqTSqYjLT9zQKcQo?=
 =?us-ascii?Q?cqHkR9JvoxNrh+LyXRK8LF0MW8Txw9YwhpKRQoDtdEiJ3TtMSbaFDrGIen0O?=
 =?us-ascii?Q?+DYPa9+LYcbs1Z8MEy0ZNtCRlgA15nfXZWVJpiaO3ZKa+bhTqaGp4WFBTIgx?=
 =?us-ascii?Q?66lPWzvmgZFR61LNyU/pQ5yslSwatm3hH3szc8lA28XicBuh8oDRmQG9mKEL?=
 =?us-ascii?Q?n5Q1/oy0mhFg1fY/9t3Vmp4q/3/AUrDkjvVCClMM2jFZaUWwfv1tybZsmlyf?=
 =?us-ascii?Q?9LRYcNl3ohLF0HLgQX257dn13q4sOuy+qPTOcePQfkNc7OmvKBbbE5CZOmeK?=
 =?us-ascii?Q?nxmFnMYKzk2cbH0UCztTjGj0pc96UptK06zvP5yUdU6qpyYLTSeyIDqj9rcb?=
 =?us-ascii?Q?cco4DE24lLpoZgCJ9QnfVMVZty7wEHlpW11SQmy0r2NorcEtqnQbg7dYnZb0?=
 =?us-ascii?Q?1YzsUrmTMaNW9U+ju25ROW/dSz9JIiZTMIAjMJyAM/wmE8kXYpHqbQ1+K+x2?=
 =?us-ascii?Q?pOZFVFGU9N2XAGWimgLTnAlnXYXn406jdQZRyfrIl3jUPuBwTQcjYjWwa36W?=
 =?us-ascii?Q?hr1JK9htpvYRXVP6mfSXPe01QMxSQYfbkmiw3riC23+uvalHoWxe4Pg7Urv6?=
 =?us-ascii?Q?pki0gguWCKB2aHsablaGOq4zqWz5kKKJ6lU5WILQQWLPWKqp5z/rcNgv0cVU?=
 =?us-ascii?Q?jEQs7ZaE3R+zenbj9jjm773LqUYUhUvm2TBElIazpGZRRx6zLTLewQFUXU0J?=
 =?us-ascii?Q?IhoL0wWrlpKN8svVIPSQfWufdctAQC+OLE9n+RDcXl9e2bRtKim3POE5JBzK?=
 =?us-ascii?Q?j86dvHylJsSlXZcTba1wMSR1GVMueMoXoNwpj8aOrxeR90TwJysMHDXq8KST?=
 =?us-ascii?Q?AuCN8xGTSR6kMfHClAUIyfM67I7lu0x2sNGzY/LJsbwf0iEjWHu3vwZ6WLJh?=
 =?us-ascii?Q?f9unF+jW+IEXU8HSvHBwpI2LWVED+tP/JRPIaNVF7W/aFRQxOrQj9Ny30VyW?=
 =?us-ascii?Q?gH1RXIM3dxTNjXyblQ3IzyKD8YkUW4UsFrFK3G3mo/du+raOF6GRN4SyaNEA?=
 =?us-ascii?Q?41g2UdZu0QMAcZHWhOlrE4jz2n8i/7iFkI629TYff5f2ygQpiMS59DvNl/bP?=
 =?us-ascii?Q?PVVunjfOq2EAvXdr0E6LTWMGbzVrrTi+egQY5Wt5885lVFKr6utqRAOaWwON?=
 =?us-ascii?Q?EmgfWjmGo/83md+DM3xQSfi4axzYeo1xlGVZ1tAVe3dkvdyYfRKdT7/WaoM3?=
 =?us-ascii?Q?2a7BHZhiSGgkiFIu4dn9tUUQnK8HRK9xS3UNFSfvFwGCLzw/rrY3ugaytQcq?=
 =?us-ascii?Q?RIP2koCUkRrtXqMJzIc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9c2f65-dc85-4286-e062-08dc96f487eb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 22:00:17.7385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /82M+O8Qh23y6WkMvXE5JGbNiBsycTgLWT9HqNDDth7yi3u14cxUngGKR0CZqZ8S8YJtqUOc7G7ovW4puaL9cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7259

Add sai[1..6], NXP Audio Transceiver (XCVR) Controller and  MICFIL Digital
Audio Interface (MICFIL).

Signed-off-by: Frank Li <Frank.Li@nxp.com>
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


