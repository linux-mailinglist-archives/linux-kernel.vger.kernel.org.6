Return-Path: <linux-kernel+bounces-349429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C4198F5E6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 20:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03D5D282799
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 18:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A1B1AB530;
	Thu,  3 Oct 2024 18:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AFVC2KUT"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010045.outbound.protection.outlook.com [52.101.69.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161DC19D895;
	Thu,  3 Oct 2024 18:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727979368; cv=fail; b=RPziu9ayOQXBIPDeBCuWGSQFYMOTlQ3RtIc7K8mJZIDZMkMzdxjPUogubiMfxKQcH2B75XFha/MnzebsjipD4IiD0HuztSls+O7AqJrx72L/wMP5yuz3A37y/mfw4oWC8t1xsFrfF2U99h20VK+RAhtV4uFd02/dOKBOyHMhX0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727979368; c=relaxed/simple;
	bh=1yAMSbsU674reQ2pCePhNh5BpP18UIkxyo55CSs1I3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JpCmLH0QjGFx74p+xcctVky7N3MICQdeCF7A9+LFhLEf6dO2u/uXqwgdVVDshX0vZ4lY90gHVR8slwxc0ZXlNFFbbQ846ZF7A/2GEgxI8Rhn59bhejI0OCUV651nWbPAWJSg9adN1da6Y1bR3bxWF9tu2INEy8Q240Ptw/mrb7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AFVC2KUT; arc=fail smtp.client-ip=52.101.69.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AGBDOyb6407pyGhIkjrSxrTgWbuHpaG27SRSH1UeCG9b4GkKLkYxS1oAX9jAMEipSmYyl3/FJ6ktAcY1wyTR0NhEFGWD/ZEVuw/oeZmGa6vdDWOYutzobLj+Y2dy6ArPmB/u1jqiAgL80GgJVRXbYFflq06bKGWGAHAfZIgjFXzhDf9zd4ump5r0oxndtqJpe4f8M6P3qRjlA46831En1VS6r+nR51z5I/FPw8tBiU/EKpmFudMb5LGvS1rr18fc+QCWkJvMUdbeLUSLtAfJeIF+CUKZhTOpMY2PtGd8rLTos7A9a0LMLxd/79Od3R3nl6AAc1/VZ5dXoCRG/xf5oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ry3yMsSUAKR3lOdbiah9P0pNrcUap4zX9GbGljGFwvk=;
 b=cPMPHseZc+QzaJidur4ptb31MSkH/HMx8mxs8COBbPVPXjDKijHurOFAH9tnRjp1SlFqkHThlEDaN+7MOzK7foxA+CtKiVh73dvgctNR8l5jdVdG9MJN2rA0RMJysPPBz4DU8AjA/w+bnmadSEMPklbu+AZ5jQzl1k8Iy5lR1+aQpGpzO4wQPmQS1HhE0hYLznJret3DljJWGeuGHZGHIB31DGJ3N/qwq+nuMD6hC+ccNc/RJEsztpdbcOC2zsUnvBa3VjMHeYnhdrmtbclTD464sQrwHXQGsNOhcxL08MrXDdfDAqkGpatH69bvwW26ivoRS2G9FP3LTnOBU+jJew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ry3yMsSUAKR3lOdbiah9P0pNrcUap4zX9GbGljGFwvk=;
 b=AFVC2KUTR3El6cfy4ZVVUg4wBbL/HTKfc+lnWBmxhDyLr60NHrh8y19SthHBpa3YOCByw9Wdsf4ldGiFigOFtd7+vy2ioDkX82dOH+4PveuoqciZLt4OAbD5dM7VbQnyR2dwztpuzLi0QSlmEvGq0kA5h9oncTxTs1h679+saVICHDvYWkncKQjHsSlCR6Te4qYaWf5F4g1orY5nBtoPv0CV71wyRAXYxa2pMIHDlsS1MIAM5ODSflGEOMlVsa77VeZy6TBwsnngYf49+uBvvOQMvOi3H6swdjjs+AoEWZydKYSj6emQ9HrfE2slet9ApJCmvOzBgYbJUCTMzZ/t8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB9194.eurprd04.prod.outlook.com (2603:10a6:10:2f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Thu, 3 Oct
 2024 18:16:03 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 18:16:03 +0000
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
Subject: [PATCH v2 2/4] arm64: dts: imx8dxl-evk: Add PCIe support
Date: Thu,  3 Oct 2024 14:15:38 -0400
Message-Id: <20241003181542.620461-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241003181542.620461-1-Frank.Li@nxp.com>
References: <20241003181542.620461-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0014.namprd21.prod.outlook.com
 (2603:10b6:a03:114::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB9194:EE_
X-MS-Office365-Filtering-Correlation-Id: a1d9fe11-41f1-4e93-8e68-08dce3d770f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KE9hrhVQt9CTlC+SbJlNgG/JqFPDCrAiyvlVmcpzNzvz7lDP0QG0WZB8Mzqe?=
 =?us-ascii?Q?IKoKbpdXNGlO/MLZWLdkuAWOylcTMIzLhtNsl6WuxvG8Aet3ekXSfhcoTvLX?=
 =?us-ascii?Q?sj4VipKsYBngT9casoke78pINHAixYaQuX1h37hj0Yzmedgz4EbeT7cU65FE?=
 =?us-ascii?Q?UkRl07OFglFpt2Ngl/iZlGczKH8n10Xq80hkA805MpcJMmMTM1DUdh2Tdt1R?=
 =?us-ascii?Q?vxBOotOd/W4YXR+ahjybHiK7HeiwUzO0Q2mZe9584uu9QB221IokoXUZADjJ?=
 =?us-ascii?Q?lgwt2XfwcpP1sJSJMa8sLMLr7kvYqLu7fthBJvQrdbRQ2JSuYjLra7hiFhyR?=
 =?us-ascii?Q?Ig3a+oJ9wxoYQhp/RVXMSYP6AGaCoAbapbFTxlssHj5DgSdoEhLSbJAx0ZOz?=
 =?us-ascii?Q?FdgLeX9fW06629aNcF9ayxtuRcC8JPy8kEUzSKn6WzDiXIWfXPRcLRUcxsZd?=
 =?us-ascii?Q?GuDoTfG8neboPBGTnm0ZGoP07K9M4PyykSmTAqXO6YlmRY360pSxcm0H4Pxu?=
 =?us-ascii?Q?UEOAh85dzqjqBFDUfZ5PjwZzU3agXx2G0vfFEFECmWI66bP1bmuOaPAZVhL7?=
 =?us-ascii?Q?qPSGqfhsxroIHb66I2uBY3/pifvTputrCw65+rRxZ/ntBUtKJcVSkLIsbAJ9?=
 =?us-ascii?Q?XqBhJkSCVrgYFa9sAn8uDFH1gkZF4WuSQGCITY6iiuNdPwlRpU0YzByOcaqZ?=
 =?us-ascii?Q?rZ/NqKb+vOS976kaqUC+ofxhkRpYHjmGB5Nloxkgf8eEknJWruCaKJGgSuU/?=
 =?us-ascii?Q?VUGHOGzv3YM+QjoMBgPDv0PVOar/4YqQRWLuJmG6i6IqSyDsWVxdL1mEynai?=
 =?us-ascii?Q?suGJApIZNrrWgyxO+9UDUTI2UiAOFWzSwM6I9TFCfZi1oRiElXfPWR+8pJSP?=
 =?us-ascii?Q?nBhEvbhHu5ik8/FBcxQyA7VVlan1ggXiYJez4BEF/E4D1F6agf9xvkvMZk7P?=
 =?us-ascii?Q?cTg3grPs6VoMtcxmBlkUUp2I3mT9B0MxDDx3psib8SQLG5hXArlufFTTl3+L?=
 =?us-ascii?Q?/iBtW9HRzwuinatLV9yhBHYIwdrkOEX1jcd6KO0056DxkkjX2cNjHVfpSEkV?=
 =?us-ascii?Q?QKT3/IhV6sphT1vFdpMeE6XMQg364aZjpxRDFW3PWrsJotHu+GIaAcrbtc4W?=
 =?us-ascii?Q?nz0eHNq6SM5xXwv5x1Gbm4vaCzv0b6T1Em53UnqQm8G1FpC2wTbIJI/JDOPY?=
 =?us-ascii?Q?y+8Udtpcuwv71zpis2uHUMspref/aGo1jXWgmaY1+1bgCMQbBssKusD4apc+?=
 =?us-ascii?Q?Luo95kCzFEl7CyG6Z+kZbZRavM4uAfVoQKs2/rbe6P1lmj53SesbsxgMzPOt?=
 =?us-ascii?Q?qPC+eywGlveuyXECBJbfmhBaJ19i0IUUnh8rNRBPBqIBc9/FMaOLiVD/qVhW?=
 =?us-ascii?Q?UHMAO+k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8cRqQbWOLKu5epPp9Wp0ZYKTNu7AbD6MFm/Fk8ccP+NPBtAUdYR1BMf/HW4j?=
 =?us-ascii?Q?pt9hPIQO0Q45hssGG+av2R/MPEgNZdfFxLeboe6e+tStUh6uIRm1Uj5Td+sa?=
 =?us-ascii?Q?xAfVlmNZrkTG8g8ewgDKp+Sh5nYKmnYCLFcJ79VrazP1NjhM7mGNRfLql8fp?=
 =?us-ascii?Q?J3INa9ejeUoV9fvxP+916PwmIM5W0aLeR7u5iZePDZV/+bbzBz+pnktWAbOB?=
 =?us-ascii?Q?CNbJhDKaeSzb06VK0uVwYYoDjRP8j852C4gHiDXQq95WrU+ARG60jPj04Roy?=
 =?us-ascii?Q?VQ+mkmcmkjW8/sEaSgOiIPRchZjrRsGq8MjMmo9Ty441a+bN3d+mAWyv2EUl?=
 =?us-ascii?Q?9WbIsFT8CbVtHYBd9wL/ANBL0Py7E6AQq3eU2Rp5U741MFqoEElIOjXUwSmz?=
 =?us-ascii?Q?S8e/Yh66CRKl2m4IoRL68458z2w+MIvk//cxLwerKmp1+7Lydb7yvc19x9W+?=
 =?us-ascii?Q?ZkUzd4rlV27zql0r1c6D7pdKzbKttLBdtDljePbRkxpHTZHmhFFpJHz6PHGn?=
 =?us-ascii?Q?cwkku4Sr7GX0GwKPa5+AVcfog28X43pH7suKOeFPAAWRYi5Lwv9QD3igi9Yq?=
 =?us-ascii?Q?VH2SI2DhUgIXebl7U+05s3VfswQrosGCax7yFI0MabqoUJ2qX3k0lqhDmwGl?=
 =?us-ascii?Q?dMfAIK1uRh+DSOVRv9wSAsuImnawrceNa6YL8rwI4EpF3W4iKW4hTceNubUf?=
 =?us-ascii?Q?Sy/FymZ2F1727vOPm/6bIBK68Qu6CGMj4PbH2sGzXlJzffHFKkI9qiwsDfXm?=
 =?us-ascii?Q?PuuEzruziWqb1etaiAdPn1Ac1+3wRZhlwABAaUIgobLAPNDs6Q9X671RDHNe?=
 =?us-ascii?Q?P36Gf/+U+7gEiPFpzkJkqdzhkcpf6PxNMziX6v9fHJC3hj8H8zr6Nsbp+dsh?=
 =?us-ascii?Q?lpKLTMSwD7lguIaB1e/NNzCxLu/BOBM/oxmthjdwFx6KKyvgG6w1xcru7819?=
 =?us-ascii?Q?L11U85gP6WYeb9f4+Bu7Fd7g4mJjhP+jbfbjRNGxT1cXYLoSzu43hRCUikQ4?=
 =?us-ascii?Q?rVacmZ7vi/evtjp7FBd17XJTMPyzdhyR/6I7ZlffmA0JY5zDN8zM8eDi9Zjv?=
 =?us-ascii?Q?LmkahYF7duPhLjW5ZC12zxC80Vf8YjaY+aGZxxgfYQhc82YNLPluGbVM8ncC?=
 =?us-ascii?Q?wll0yydQFU7G32ZK/DCO/5IDZQqnRhyG+dQtBV4scP7uZ2JFT6LDQaQa0flN?=
 =?us-ascii?Q?q8KOLeYsQtaTAYwp14YMl/ML+ZXTSnNF9UoXsHemIuaBw30udFPZfnr1D+c+?=
 =?us-ascii?Q?9XR9zjZSGrVS9Wqnawv6PZ11CjeM7lNe6VwBA+e05eYo3M+Fe3G5vjLtRN3V?=
 =?us-ascii?Q?upZIMmrBj9nyNZNxZAI495CsIj+IqhXEly9KsXbUJnKt0tg9mwCD15fvvs2j?=
 =?us-ascii?Q?1eNxDDXVhV5EgCWTujgfnJ5bbvixt1lB0/bs4+eFDusVoEOhMgdPe3jA25VZ?=
 =?us-ascii?Q?gZCKR6SIv0PkmG8DUuPRh1HxAi69iXgA3NHDx5gdr4gU5pBAO9dicD6lWc6L?=
 =?us-ascii?Q?Ku9krWipiegyMoBmfKOR2tR/CoroYuDnvZKdbGWHDmafHN39LlBGNoXANqsk?=
 =?us-ascii?Q?6NgzT3fFw4KO5t10zqjoiG2YW+MmTuKtClJTpqW4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d9fe11-41f1-4e93-8e68-08dce3d770f1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 18:16:03.3583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2N8KPOfml958N7kzW5Q4A+frcSB56Gn2VIBSDHlrxVCFkT7ASFq9obgz8dAJbBLyJqSPZBLHi2Kaw3gIKBAxDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9194

From: Richard Zhu <hongxing.zhu@nxp.com>

Add PCIe support on i.MX8DXL EVK board.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
chagne from v1 to v1
- supports -> support
- add space before {
---
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index 4caaecc192277..6259186cd4d92 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -182,6 +182,15 @@ mii_select: regulator-4 {
 		regulator-always-on;
 	};
 
+	reg_pcieb: regulator-pcieb {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "reg_pcieb";
+		gpio = <&pca6416_1 13 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	bt_sco_codec: audio-codec-bt {
 		compatible = "linux,bt-sco";
 		#sound-dai-cells = <1>;
@@ -567,6 +576,12 @@ &flexcan3 {
 	status = "okay";
 };
 
+&hsio_phy {
+	fsl,hsio-cfg = "pciea-x2-pcieb";
+	fsl,refclk-pad-mode = "output";
+	status = "okay";
+};
+
 &cm40_intmux {
 	status = "disabled";
 };
@@ -585,6 +600,16 @@ &lsio_gpio5 {
 	status = "okay";
 };
 
+&pcieb {
+	phys = <&hsio_phy 0 PHY_TYPE_PCIE 0>;
+	phy-names = "pcie-phy";
+	pinctrl-0 = <&pinctrl_pcieb>;
+	pinctrl-names = "default";
+	reset-gpio = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_pcieb>;
+	status = "okay";
+};
+
 &sai0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sai0>;
@@ -868,6 +893,14 @@ IMX8DXL_UART1_CTS_B_ADMA_UART1_CTS_B    0x06000020
 		>;
 	};
 
+	pinctrl_pcieb: pcieagrp {
+		fsl,pins = <
+			IMX8DXL_PCIE_CTRL0_PERST_B_LSIO_GPIO4_IO00	0x06000021
+			IMX8DXL_PCIE_CTRL0_CLKREQ_B_LSIO_GPIO4_IO01	0x06000021
+			IMX8DXL_PCIE_CTRL0_WAKE_B_LSIO_GPIO4_IO02	0x04000021
+		>;
+	};
+
 	pinctrl_sai0: sai0grp {
 		fsl,pins = <
 			IMX8DXL_SPI0_CS0_ADMA_SAI0_RXD		0x06000060
-- 
2.34.1


