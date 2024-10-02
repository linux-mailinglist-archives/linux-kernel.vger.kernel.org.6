Return-Path: <linux-kernel+bounces-348234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C635D98E46A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0DE31C221F0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A672217911;
	Wed,  2 Oct 2024 20:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LVot6T8C"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010052.outbound.protection.outlook.com [52.101.69.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC2D2178EB;
	Wed,  2 Oct 2024 20:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727902104; cv=fail; b=aoMy7HK5py2o90YGh8tJl0Lk9ysoy7qiIOJa4cSSPjhPScCme3IJ0QC5+HAqc+j/r393DnpUcnSSpZVImbz5nl6pqGPFd7fcvHioPAnSz4IPAZPcKgmF2K5snl/tu1R8ApnUU/SdBJmFmkiFTNJYHeErKkl+MB5+TKR+LHi26AY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727902104; c=relaxed/simple;
	bh=c9N7iWzQ5+mDk597bdeGrncb+CA7+MGVUya5Yy3xTu0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j10Y4FhFOOuQNmdgGr1b8RK529AnwkHdpxtNthTsIFmdctDC19jMDDjAc1hSh4ROBXCV4TaUw7SHWHPCmpCQKRxtWBznbzz0GaZuFTO8dtDHqBIcr0n0YJbesuTknMgF9Pc7y8pXnTlDSIpR1Ds2oDOWlEsQtfdOe4RqDgyzPhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LVot6T8C; arc=fail smtp.client-ip=52.101.69.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RpgjnWw2ONSK4upGvMaHwzeo+fxWPeJrVtlKIplXUon2pqbRb5nL52Q8/dTwnqQVKLsMpnBPoHZ5B3/VEr2TykDE8fhEibzp3AtV6lF8WF2GSl/9XfJ2q7oa2CT8kzFf4R/SginwJ9po4Q2G/z5RBxjGzRxfJOQBoicPhFPjH11Ag/cScpmBPwdNrYa8706gz5tL81LamJz2gL1ub9FzJ4dnc5HB7fnpxzQUI33/Dbdr4sFN3EBn1EzcZgF3QQRP1RZ77sgCFJ/TONd2QEVF278dRpJbf6OJiqGJHIvlI44SN88+CtfkdXQyaV36PgeXE03yG26MrgHRUHWGdHq9NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VaFwRVdxg258hQjgBYQTLJItTfN0T46hFEPCoznzKj8=;
 b=BkD/MtZQmmlpmKUjx9ver/bUbQFBlaa1b8EBuwe19YBQwPrOQgzkSafzEWjBGyDHaiqgh+J8BaFmEGXXyCgBVEltc0XzL05uChrkcVXfILnrlNZ50/6nCQnty94lQi4PT8jSZvdPwH2mMPuFdrLFfW1ym72x0ILbOZqwlILoaInWyc05lyc3xwKQ8ete1/vb/cTFQ5nBxo214/nNN93GwIyE9FSIIB8+bvfTVW7p2rLgZJTUPUQGDvnNwdkK7+yBzZbi2xTRUDVwxDAi8WDQO46PsjhQubgeYUpNjLVEfCh5ZQa9sCszK5o3vAij0lLYj0DNCWUgyS0RBT2WiLSHdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VaFwRVdxg258hQjgBYQTLJItTfN0T46hFEPCoznzKj8=;
 b=LVot6T8CGpqGIt7sQ7Wd5gSCrgmCNv20/18vLfSFwh9mroTOatFKROLXQW3HtlHCrtgiAeujiwRmSZ/e0PVFedlXHTcc0PHOWnsFAth6/8revxlLsTdVRfw8XI+mYk8jBDip/H1L4XypNyimTYvC5y04zlDygLJZir1UY6YaKkrHDC945qYM5Xj3Lb4Ux4KXbzHBEETpppAJKRhElXArHWpIfjVt9Dr+fA+vWdO9UNpRbExxnBPjE6v5387oyEOyStJBffLAET0hGZOhyyaqYT3fvjZVs+w/mCzcL8gdxUdRgyTMdbUt8JG9cELej1kVgElnC24166wZtRrbExd3Bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9454.eurprd04.prod.outlook.com (2603:10a6:20b:4d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 20:48:20 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 20:48:20 +0000
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
Subject: [PATCH 4/4] arm64: dts: imx8qm-mek: Add PCIe and sata
Date: Wed,  2 Oct 2024 16:47:48 -0400
Message-Id: <20241002204750.597337-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002204750.597337-1-Frank.Li@nxp.com>
References: <20241002204750.597337-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0048.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9454:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c9d6e60-a221-412a-a4b2-08dce3238c8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?78HRzAFQQwDFa/qMBSHL3W87tnAVO/jpuMpvOszjtFh0s4fa3kjtHluAhnBL?=
 =?us-ascii?Q?v9hqTzvTu+bK/jlMP+saM7JQcLIwpui/Tl7r/Qw6XnKaa0+VY8CI8X6uCc20?=
 =?us-ascii?Q?oZCda5AbSoZ41XTPCsIitiR4CD7IMa0qdthYq5E/KPqtf/6Ow72PHaLUl7mt?=
 =?us-ascii?Q?VK+qNxkByJiMI0XOVddopSGuwNJGxXPxR6KZWkqJIJDCXtJITPRbYZWl6i30?=
 =?us-ascii?Q?6dKwl5uCOIK2NgSuv+Nis9EYHJxjX3xHj4V+8EDRdiqiw/1TEbT6QsZ+r45t?=
 =?us-ascii?Q?tdKGDFGg4Tj5tKiXwYErebsmKCGMLqagZ44+xeHDFWApFSnAjpF8KqZmdHE2?=
 =?us-ascii?Q?oo7ZuMAxeMUUznAH9gOuYaZR7M0C3lripcbiCHKjMIyfmX+SYI5VcqwmScpI?=
 =?us-ascii?Q?AUzAQAebyN4Wl7FF7vC1b5dvTCE++BfGLfOllfluxbIcQTot6np5IfE/s7ex?=
 =?us-ascii?Q?RpuA1kHKNG/kfTgXcuLrTvkCZEkO5Dohz3x6Sk2WMuDRBPC2yDWx9SgQMeJq?=
 =?us-ascii?Q?uXo8KpbhLbUTaNPstyXq4NY/KDUZROAy0fZ6aBzEsVi8khCVbF0R4p7X5QF8?=
 =?us-ascii?Q?gu/E3O4AQ4i8cHjJLy+WJ2QqrUayxizCc/0sDDWkkVzb0DwFrJwtCX5rMUah?=
 =?us-ascii?Q?EBWTHfPIGT7sSJI1pc2nU5mvsUT31srMVH1nga2/5hYYIHQYz88wEb6ClHmw?=
 =?us-ascii?Q?zmj555BWf46rdJvXIWXKrZ5ZpTflwsX/EcFlhDmqX6ETiQLpKEH+ild2K0SQ?=
 =?us-ascii?Q?lfpcyzILg5M0qHrjjLxkmt+nptdr2MCvvpFuRyIo9bYhepvRiKvPgT7GZoU/?=
 =?us-ascii?Q?vK1QaYZuI1AecqYcxFMMCDG178OxXL6wLRYEQoAPwDhZb3wq2OjfsAN9eAK9?=
 =?us-ascii?Q?E0cLYhpZBMgY9OGxeR/jZJWOgCD7dfzFip1DbjoLnXEiKS05ICrel1OzpeN3?=
 =?us-ascii?Q?MKi+JU/uRsEqKRiUA9Ii4XhiDFUV2U5mnK2yllCoX9GKId1kmSfyFCkslVDc?=
 =?us-ascii?Q?0SidDNgvo6U0PRgLE1C5qg6MXGK9FbSF5ZBkhMJqQkeUVDk3HNLiDqG9EgZa?=
 =?us-ascii?Q?08TrnPsNVY4D3qZKDMRwrBbbyF0Insam+9QGL6t1+ksuoTZD1pKyIjK5E5a3?=
 =?us-ascii?Q?0kSRCvCVHkSCFpyNRlNKWbiQ+BNoVO1grrjLuhymWuDZApMuVIcBEqVZdAj7?=
 =?us-ascii?Q?wmf5Mh7DiWb7k10VGjwOqvUlx+3fZB9mr5dINZkelJ8NIyt6fHmz9q/A0pfT?=
 =?us-ascii?Q?q1KYEKaPixsQStOOBb29D8DXxis6M8F4NoqzHCnFC0tSP0+hSTNl5hdBh+EJ?=
 =?us-ascii?Q?77diYNEe/JVUD2FqcZbON3DZZj1Pw4IhsGH1WFO5fa4IKWrQEP8JV7tFkjCU?=
 =?us-ascii?Q?tyQV6J0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f35Ep2VbVd4yDAS51S5+uYd9c3QZ2fubbMRyg5w80jh8GByH1FwHvDFWwXhb?=
 =?us-ascii?Q?yRHp+4bSc6mlQgzmVUCxkxawb6gYKOSN9yhSDVKtkrAwXJJKMDm1t6M++f9D?=
 =?us-ascii?Q?xHiSaMkMJqPxLz7nLGKRisbO8aupJLPp7s2xzOS8mq3DLbFYO3X+7n/QBEMU?=
 =?us-ascii?Q?E7F8pymwckSL2uua9RatLg4/vp8FoQLOfEDYpthBW9bP2GH4CIbmfCvkD1H3?=
 =?us-ascii?Q?+L0bxEriQg1fzTUNMm0HxXgSbpHsdsgoaChk2ojZhqLuQxsRbe79pOAtn5XY?=
 =?us-ascii?Q?F07fjv6nk7xG6QSavv6nPO05dst94p9JiJWY6+19047ylNoifim+qHRp0BWY?=
 =?us-ascii?Q?eBH3orLJzZm+6yKOPcIxJr6PAaU6W5ogHNsEFjTUJEp0udBFhwxmGgpZfitB?=
 =?us-ascii?Q?uRXPPUnv1183B/GKv6lt+8CPYMJKOWSsSXMeQZEFS1BUEnHIOPUoOxvJZgZF?=
 =?us-ascii?Q?xlGALEji2LuXf0GfsG8ASatyqEQucmsGWMwLLZZG5IL/vj+qc7ntR7NM26RS?=
 =?us-ascii?Q?D9ZJOVOZJtNnQmwGJ77jnFc68SBTvpiVxGf7qUKstuIEV4o9C6A7qDhI455v?=
 =?us-ascii?Q?uotzoonmF7nGl4hiHcUWsJiFRVPnrM+W0TAntCpkR5xpQIuAy0f9w/2+nzYS?=
 =?us-ascii?Q?P9kQOuQkXBg51NX9lFO3H6gzpHw1vpHXy6l3k5FrD0VhU+ayvZP2H9irfQQv?=
 =?us-ascii?Q?Yfcl7+tnF+7U1t/xLjY60Q3uigI5K4toUZJOAXb1DwwEydclWzKWhAS5km38?=
 =?us-ascii?Q?q7daKfgwQj8sDPC9JsMI9iLnGiHgLhyVvQoXAem7Y09AwHYMijCRtebmRtRn?=
 =?us-ascii?Q?PzWYjUdsOpPz70rqJAN1aGuLY77BVtAdy92D/H3Vw2G5Mf74xa2s8T1+Z0J8?=
 =?us-ascii?Q?Z+LZ1KfCBdXiYVUk2wXz8tpLcZHm4jkyl3/HAPEfU4UB9y4kLzzSitjhQM7/?=
 =?us-ascii?Q?IfKPlvp4klu4o3pa5zlD6j3eQ95y2x98F3HSXb7em9Ff7HB75PnfxcLBiXal?=
 =?us-ascii?Q?eHSUnKxLQjUtVqx7hA5Jtzwx71u97Wl8ZK7epotpIup0UxkYXaVTgJ4tZ419?=
 =?us-ascii?Q?wJm+ZHP1PeEFIIAXquPFwolrg+RrDEUhMk7QZX2vsu9gRk1vt5WKbzHalgVl?=
 =?us-ascii?Q?1TDteIxrvEIPHvI+PDZaxuQa9fXgeITH2sZQc4ne1Ndzuinctx6UcApHZ5q4?=
 =?us-ascii?Q?251E4cB+rAwC+IvtlAdLANsUH8MYafl5heXOgI0rbOeSK+Ewwm/JavAaCExz?=
 =?us-ascii?Q?+wbukarp1W/vdd9mPfpPDBipNB9xl/5IKo9/uCTNvrVpWvjCTwEmHR14DdE9?=
 =?us-ascii?Q?ZPiJa82eIVw8PVPjLV4QtDdTfZCLsqWYppaSaTqeTipPBwY1ej0DU25WeUmw?=
 =?us-ascii?Q?EYa3lYW7+THhzYWA7eH/tTpob4j7PP19JesIRGaHmwde0niLwQD376gq280n?=
 =?us-ascii?Q?N297nxaDB9DNmNnUAx6CHpHmTV1988EuKXSpNoHY+ot1+NLL4ta15HErpgIN?=
 =?us-ascii?Q?J4gfuNdX+BG99nRzWXvKIDXfTZdMYT95jNfabrgI+cwzmBQ6tjtD/Gi2RYFs?=
 =?us-ascii?Q?I00Iy4rWJ50rQ6phcugMqFEUieyfJRIrCzqce3ne?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c9d6e60-a221-412a-a4b2-08dce3238c8d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 20:48:20.3090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4agi+IF4MhY9PSaJwSUt4DfYVqWNlIcC9fApto2ZBF6AjZxAwS6aQJOJBdMldg4WcqJNH7b3G9QnvwspAsmE9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9454

Add PCIe[a,b] and sata support for i.MX8QM-MEK board.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 62 ++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 62203eed6a6cb..1245dd535d636 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -181,6 +181,17 @@ reg_can2_stby: regulator-can2-stby {
 		vin-supply = <&reg_can2_en>;
 	};
 
+	reg_pciea: regulator-pcie {
+		compatible = "regulator-fixed";
+		pinctrl-0 = <&pinctrl_pciea_reg>;
+		pinctrl-names = "default";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "mpcie_3v3";
+		gpio = <&lsio_gpio1 13 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	reg_vref_1v8: regulator-adc-vref {
 		compatible = "regulator-fixed";
 		regulator-name = "vref_1v8";
@@ -296,6 +307,12 @@ &cm41_intmux {
 	status = "okay";
 };
 
+&hsio_phy {
+	fsl,hsio-cfg = "pciea-pcieb-sata";
+	fsl,refclk-pad-mode = "input";
+	status = "okay";
+};
+
 &i2c0 {
 	#address-cells = <1>;
 	#size-cells = <0>;
@@ -541,6 +558,25 @@ &fec2 {
 	status = "okay";
 };
 
+&pciea{
+	phys = <&hsio_phy 0 PHY_TYPE_PCIE 0>;
+	phy-names = "pcie-phy";
+	pinctrl-0 = <&pinctrl_pciea>;
+	pinctrl-names = "default";
+	reset-gpio = <&lsio_gpio4 29 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_pciea>;
+	status = "okay";
+};
+
+&pcieb{
+	phys = <&hsio_phy 1 PHY_TYPE_PCIE 1>;
+	phy-names = "pcie-phy";
+	pinctrl-0 = <&pinctrl_pcieb>;
+	pinctrl-names = "default";
+	reset-gpio = <&lsio_gpio5 0 GPIO_ACTIVE_LOW>;
+	status = "disabled";
+};
+
 &qm_pwm_lvds0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm_lvds0>;
@@ -640,6 +676,10 @@ &sai7 {
 	status = "okay";
 };
 
+&sata {
+	status = "okay";
+};
+
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
@@ -829,6 +869,28 @@ IMX8QM_LVDS1_I2C1_SDA_LVDS1_I2C1_SDA	0xc600004c
 		>;
 	};
 
+	pinctrl_pciea: pcieagrp{
+		fsl,pins = <
+			IMX8QM_PCIE_CTRL0_WAKE_B_LSIO_GPIO4_IO28		0x04000021
+			IMX8QM_PCIE_CTRL0_PERST_B_LSIO_GPIO4_IO29		0x06000021
+			IMX8QM_SCU_GPIO0_07_SCU_DSC_RTC_CLOCK_OUTPUT_32K	0x20
+		>;
+	};
+
+	pinctrl_pciea_reg: pcieareggrp {
+		fsl,pins = <
+			IMX8QM_LVDS1_I2C0_SDA_LSIO_GPIO1_IO13			0x06000021
+		>;
+	};
+
+	pinctrl_pcieb: pciebgrp{
+		fsl,pins = <
+			IMX8QM_PCIE_CTRL1_CLKREQ_B_HSIO_PCIE1_CLKREQ_B		0x06000021
+			IMX8QM_PCIE_CTRL1_WAKE_B_LSIO_GPIO4_IO31		0x04000021
+			IMX8QM_PCIE_CTRL1_PERST_B_LSIO_GPIO5_IO00		0x06000021
+		>;
+	};
+
 	pinctrl_pwm_lvds0: pwmlvds0grp {
 		fsl,pins = <
 			IMX8QM_LVDS0_GPIO00_LVDS0_PWM0_OUT		0x00000020
-- 
2.34.1


