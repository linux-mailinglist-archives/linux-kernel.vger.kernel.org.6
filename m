Return-Path: <linux-kernel+bounces-236970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B960791E934
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 22:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE107B21B3F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBD9171E52;
	Mon,  1 Jul 2024 20:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PeO5QTH4"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB6A17166A;
	Mon,  1 Jul 2024 20:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719864479; cv=fail; b=TZTurcU/RhDZFAY9DPai/Ws4VVX7Vu6SC5Pnke+BECSvQUugvCQukyOnv6dBVP97+P1TFBQluIa1criegjxPZEXwsGerKRhRmFsXA/9sYURYwZRnvr3Auux1oMTZtrMjCuNN38dknlCwkJnE/AXVXMIduDfS6dEyjEDi3q3NM2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719864479; c=relaxed/simple;
	bh=aylw2MFLh+Q7lVb7dyxw51VbqyE25Z9FvED687YMsFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PK5NwIX4wVqzZCUt/YqWFiENuYW2Mhatexi2ZgGrbgm+jxXKHUoIW4+C58moR5250aqeO0otm0/boTgMG/n2B3XIt+a6WuPB5KXcH+GGAvtXI49R3ay4hE7gexAFWH3vOQmOSufegy+cC9xHPwOFC/qPTWM0buJ+5Zunbwm3i6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=PeO5QTH4; arc=fail smtp.client-ip=40.107.20.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yr13hw3Us59iCA4LhE7gYijuhlUxUls8D0/XGDoXJ2KHjwviXTtBzkeAEZAqAb3vcQUgEXr7rfhYfYHXoNliDSWtyph61bKaVICQgqMIlWcvOfUk1XO65KqzI/2+L5dPciDYMTGcHU6pI9iTafw6TrpcZ57VntE86W8TCwmhjx8eplQ6qmYBS5cczgmN5J9Z+xxcKjF9xmQmsX54/EzunqfzxDKtSjxI/wjMFnFOfDt1oLeJXmTFQ1XYny57nau3ZHWbzzZ0Fps1PkgtIxW2dFFU+PtXRs1IntDe5IxV+XY+5/6UqZQQo7i3sG0JWwkE/5c8NOcxeq+as5cmw40Dig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdGd1WGT++GRR4sb8/KXApXbR4Jo2B1dDoP/WwX1ziA=;
 b=b9cGBi/P0X4N3F/Ul6pElG6F0UlDRL79z2M06lHQojK37dKRE9hQorVvclWBSowTRan7KFqCqWlx2S1iX3Ta3g6hPRkPXbiBn8jdNn5FoXFLPjmRVmcvjD+zJwSJRM8hmY3w/SOTpFRLdRbzqhxpnhWSqVL+9LrG/J6DtK2Tp5P4cMrclW3XP3uk+yu0IlrdYGoBJ/UxTctJ107MpPWE2kaIwNQXjAX8uKtdMEWFhiyti7ANaQPqGKVAgwPEMeM67fftHM9IIcj7uiQf+gCXjHC8R2Ts648LIx6u+E+3uGaZt5HPvFifJWzVvV2si8+JtdAjUcTUR1NIEbDcqD8e+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdGd1WGT++GRR4sb8/KXApXbR4Jo2B1dDoP/WwX1ziA=;
 b=PeO5QTH491Qf7Snj6NAUvYA4oaeOtC2ta/lbt+7ZKpE8hFx+/Cjox2Yq/ucEqh8T7Xgw++xxkggpHf1td4GybY2N/972rrVSxt27jHixJJbLkQBavGQ40rUOJrjU1vuV/7E2I1sCh5G4DRzQQjAaRcQLme8klQo7xPqkE9aKVIM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8638.eurprd04.prod.outlook.com (2603:10a6:102:21d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Mon, 1 Jul
 2024 20:07:55 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 20:07:55 +0000
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
Subject: [PATCH v2 4/7] arm64: dts: imx95: add flexspi node
Date: Mon,  1 Jul 2024 16:07:25 -0400
Message-Id: <20240701200728.1887467-4-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: abd9ad6a-5e9c-43ba-65d4-08dc9a097e93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tNz4pfp35vvPxRz3NdcQ7YJWg8zp7svOPVj6gH5iv9N+Czi3+75QYyIodocZ?=
 =?us-ascii?Q?LnpoolytWlW+B7rR+ZH33NHyFtqOVvL3mkI8krO1PLzpeU0BbgM827fbxKVM?=
 =?us-ascii?Q?3XFp1FhXhVBeoQDel7ozdHai0leCQCSXC2WFEZ3vvjVDxd405naHHGVfQoRz?=
 =?us-ascii?Q?v9WNLH00Hnii41b5O9606g2G8+G+oxvksrJfC3R04bBIeiA/a8Ygou/XHobZ?=
 =?us-ascii?Q?3mE7OLgruIOtBHbLp1GFSsgBv5PsbPOOgsL5BksA2hSTk6nmxSxLFQEBLnkl?=
 =?us-ascii?Q?eloMmvUcSQwhazJURYHwvB1tdC8sNpVUW4BWPcT2lLfCe40lTxe1H8eGPf9L?=
 =?us-ascii?Q?/3eCR9NnZyJDZU56CYTLGolouKC7rbCyGPISdxSWatFvrI1XiaRRzoZvPO6q?=
 =?us-ascii?Q?fhfXlarAbEbCQazOVDmvXC2NVDu3O3dEMqVKIh0qkWv44rsKvkxGtsgKNDYu?=
 =?us-ascii?Q?awD95nlithXHvot9VLHxra7NBaaWtEMSMtHZUTo+U+tiVD4xor5AqBTPvfXe?=
 =?us-ascii?Q?zC9Ny40v7X8eNB4nbO2NbwniSEGZiwoftWkSayHy85wZX4T40vgGC3E10mnW?=
 =?us-ascii?Q?PT0DE3oq3BK58u7Op8rB1ES6RVb/I2wUjBhPm6rIyXEtmAezAIMqTg5gPBkJ?=
 =?us-ascii?Q?GrzG9LleQw9LCmkpHU1rR4AabqPdhTnUj25Nbw7XeJG1K8X+X8FbJOTBQz/z?=
 =?us-ascii?Q?w5rb1k4NrRFBTcGhCfezsyJTuV5RfEMh6y6O87U5GEfAG+EJ+YwKT4AhiDa0?=
 =?us-ascii?Q?pRpC5KOXV1MrQqiDP77vCrx9pxxQ4+OAq6+tVR5pGrDPQy6eqG9tdslavpkQ?=
 =?us-ascii?Q?lB4cjJ/4ImGhV83WonvJGQZAIUhdQx65//1OFiCPkPvuZh8i9XcOTzRttJ5H?=
 =?us-ascii?Q?xlB1LC2YkaRtPn7XoKbro6jIvVfr92D3MSTlyFclWGoIbmxpvi6Zr2/arxyl?=
 =?us-ascii?Q?L3sZyi81DrgkZhy2lNnNgCcGqmR5xecNs+vkYUTkdaKNiJjp30mAsRu3XiLq?=
 =?us-ascii?Q?QqhVUv6gzeAJ4nweGbCZjIaTTxS5enn+UvJ8+FGBegFFFhnEf+i8wpA5qv+O?=
 =?us-ascii?Q?UtYg7o47lN/a+oFDwSvL+iedFCovGXzi4YGFVNdhcyqg75ShcglGCIREVWq2?=
 =?us-ascii?Q?7zhi38jrAWVGW0V4U+njRf7HHlgWuL2Lc+HhICGbEnWNpet5gzJRm22UZOGY?=
 =?us-ascii?Q?QDpcir6X2VeaAEo3StxyoDm05cZc2tj8MjbTX5M1kQmZ0aWX+ch23MXhXXoC?=
 =?us-ascii?Q?ffHhgf1KHd09NzkRobCS0LPk2Rr+q7k8it+Jot/tfvycS17GR+VfAKpTBkAO?=
 =?us-ascii?Q?Ioyxua2OvCUbWFCVJrs5jtTEbOf2NvaWFJfGlVsLABJtRcgcko+ul54EpEdc?=
 =?us-ascii?Q?DTq0uTzGyX+KJ4dcTr3lVkcuzOE1b2rg2a+E6oyOTARGNyLfNbV7iWmip3MJ?=
 =?us-ascii?Q?o6Acs0pFvYs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BSSAT3ZeF0gXBovqjgeWnmdd1Pcyy3c5g3k0DMHX5nY3Kjdfku418sdXAbj+?=
 =?us-ascii?Q?SHoeRrsizyvrb1AUbxorEFGFlvgP0/sXfhN2b7dtMQuGuLlRNCBOq2JBExya?=
 =?us-ascii?Q?edMidUbyPPMmfohScxtHxG9tzd09FgymBSgPQDlqMbGobIRVV/P7rspsjvK5?=
 =?us-ascii?Q?gAlEaZcmrvRhGFXyrOyA75J2cwDOfC/EJbS/H1g5zo/exxvKFO4nmQiNeJ25?=
 =?us-ascii?Q?qBUyRo0Qv9N4S8vtgVSsZ7qSRjEWLF1v1glYMyVJhURn6OZ98SQxiiVLV3ww?=
 =?us-ascii?Q?LeCXKwbp/QGOMpsYPQuS21BG2x5GnE/dHTvhjdNjfSlkE2K+9T7S5/tGS5D4?=
 =?us-ascii?Q?77C5FLdnq59bYxrKYletdRMiEQbIyxjoAeysl2CNEPUBhWwUTzxH8AAIl4D5?=
 =?us-ascii?Q?32Ns4ay91v2Q6T9ElgjCeWq+vXRvrcQIhCbwn2qYgs5jzCfUEdn1HpaV1LVG?=
 =?us-ascii?Q?p2asmHZDIESG4TvcMVY0hjl2us+8VCAWFKtf9ktKDHxCioTRKQ9ZoD5ElbwF?=
 =?us-ascii?Q?zTc455ONhOyN0cM26keg12tJjRjIp1PkmknCLsIHgu4/pOZCdvs9brtSIYKd?=
 =?us-ascii?Q?Ade0TD/OF6a3l5QVaaDAUnF+kXBKHe/PoaoyLxsHymzrRyc1B7rV1hqw/22+?=
 =?us-ascii?Q?iKl++chs/6DapoEKgOuve66F/2QcbPfElXMzaq6X7pFmPoqiQjx7ooGXa/A/?=
 =?us-ascii?Q?i2q8wHNoN3xdsnVJ5bNDHP/GjGoCPlQtiN9nLUbcdnwIu7pHI0qpaS/z/qH9?=
 =?us-ascii?Q?8etR2vC+94iQsrVui75DQdb1ePwj8ZUd0bbuk+/r8/5q2FclaZQ/fxW2Ks0C?=
 =?us-ascii?Q?kgPMSd2o9EMXWwf+J92eZpSAqazoCI59Csk3g44S/YukAShYyCecr+al7izL?=
 =?us-ascii?Q?CrGBEu3GWZgWv0TNf/l3eHHZ3dysofNCQ8zx4qjPcfVKrduQP4FSHN8RgUNx?=
 =?us-ascii?Q?bYjwPJZbnp1XmHX0CydZHCwCYwB4Y0ARNLBLjrgctLSxzsi8c2W9g3WjtGpW?=
 =?us-ascii?Q?es9LKDs3YVvFJAOw+iYU8bNUb9aoS/2158thmKAXfg2QFm6Nq0eGgjoCEfTp?=
 =?us-ascii?Q?5JPNzAxER7dwXhVZYE6garqflH0qZT+e7ZvtlgCqCZWVGND4fVDiNvksBJZM?=
 =?us-ascii?Q?t3xVApg6hswrBL7L1RQ/xQefKsWrxzE9pWF0iR2wWsHsONBSyd80bm613VXC?=
 =?us-ascii?Q?UsrdfAw3lIuJZsjItVlpC41PQ6XmKJP/PfDbKiPRv06fMVMxBOZxQfmkXdsC?=
 =?us-ascii?Q?j/NdLb4Ctu7xZhQ1oxEpn7HiGb4X7CWnRVJlNvHt0hEk7yjf9NJRFDcHAN5j?=
 =?us-ascii?Q?N/DraVjaFuWX/VXgwX6ewTTANAy43K/dd/j4WW7yFkBjyyLiv12XaUxg4oht?=
 =?us-ascii?Q?gDqVXzSyCEOJK58N2X8IMBZ9ovy18iDGRGaOIunXW22Y+rreNgp8sZCbVRlS?=
 =?us-ascii?Q?siJR8OfMgY+uJJGpp4qfkQAzJm2K4xeDDETco1CKXpuQYJ7mEVKw8AO6vP3w?=
 =?us-ascii?Q?q85SiWWmFyK/i9WtIg2XAq33RLcR0n8KyIYRDOGSiZGcFBUSwJgSpoLtfhX0?=
 =?us-ascii?Q?9dfBIQPf+xp6NcKUGmvMJdnVDA01D6I0lth3ihA0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abd9ad6a-5e9c-43ba-65d4-08dc9a097e93
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 20:07:55.1472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QVWgPWsY8DPQYTX1a1Q2k8ruaRZbL2feCpBpOhLXHJEHBFPf2cYPCRMlUXnVMJOxc2pylbjqBn9X/ROU4xvqDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8638

Add flexspi support.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- add Peng fan's review tag
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index d32127cf7018a..0870c0d13e041 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -713,6 +713,22 @@ lpuart6: serial@425a0000 {
 				status = "disabled";
 			};
 
+			flexspi1: spi@425e0000 {
+				compatible = "nxp,imx8mm-fspi";
+				reg = <0x425e0000 0x10000>, <0x28000000 0x8000000>;
+				reg-names = "fspi_base", "fspi_mmap";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_FLEXSPI1>,
+					 <&scmi_clk IMX95_CLK_FLEXSPI1>;
+				clock-names = "fspi_en", "fspi";
+				assigned-clocks = <&scmi_clk IMX95_CLK_FLEXSPI1>;
+				assigned-clock-parents = <&scmi_clk IMX95_CLK_SYSPLL1_PFD1>;
+				assigned-clock-rates = <200000000>;
+				status = "disabled";
+			};
+
 			sai3: sai@42650000 {
 				compatible = "fsl,imx95-sai";
 				reg = <0x42650000 0x10000>;
-- 
2.34.1


