Return-Path: <linux-kernel+bounces-240161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D299269C9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 22:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42F0B1F22A1B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 20:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA37191F89;
	Wed,  3 Jul 2024 20:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sMRKrG6T"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2079.outbound.protection.outlook.com [40.107.241.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94AB19148A;
	Wed,  3 Jul 2024 20:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720040348; cv=fail; b=sQ+GlpGKHYo/zrZdb5Rptl4hOJA50coktVu/uHtGHbZz1rBBxHN8JQvURhDUBliKJA3PKx+PbCmZEPGzxQUUnTDf5U1Kva+An/+WgTU3r1UCiGkmutOKYlxiwhn+4HB5zLSYyfDm0Ce2sVdSSNqacda9yuVsZ83B41cAc03yKIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720040348; c=relaxed/simple;
	bh=5vt2D+J/2sLqi4ceLbRahf0KYA9nSaJYRUr9Z6ox0dI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Psp0NPr5rDEwrX0g9+vLo/XVf8+f0hPi1E86/OcQdOFlPRl70UImymuoQTuhf1+PfTpZn4QbbfOm8lwoq3oPru8Sf8SaXlneL3dxxw6chE1kJScg3Hy1EupY0BZTkPlsx3Ceyz3VNOPNXZ4qJItf0JM8THli63IS9v7pMRq5c54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=sMRKrG6T; arc=fail smtp.client-ip=40.107.241.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LltxiX5e6xdgKxMqyG/rSH0f5pBp7fGejeHkcHTWBgbGXf6c3Y3UX9+tymKHV9UOMx+vZIvNvVlp3J86Ysmj5UAvUQvUcmcjUc2Y5eUWqFoXkOzlHUc+uics/sMrpS9z7l/1YilyQ4fWYzt53dtHldrTxGD70umehF1F1zHa8R5lRr0hm91U5oxa0ji1pH0o7DiWPHXxVntfjyQMhopY2s4ficyBySCpIeZIZv7IqwUIPnAi+9hTsy6y8Bd0Uh5VQYUrv2+Iq33d9xKKbgMo/Yr+UiIATwPVbLox+UaCGGbWBj8scWH4JCen2MWpRcRBn9/T+TJBlx/UTf2VWuGf2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIJyeQVnccwYK5gH11SdCl0dh32d4XLD7PYSodLOz3A=;
 b=jR0jsj8UvTQChkYkYatb8QLnK8PLvfGudxoo1mcgI5qrv+R+fv1vypQ0f5p4jbZfg6DmPYGUDpMYWRe+Tn6w9F3eiIQILiuEj5fmuS6qBTtIV28+b2VkP+rO1J/lu6BwFAAcJMih7MFx/v9BgPW/uPbGNjgycEQMBsJF7JaqipkDqtV2xWW0gpMg8LUIg3Nvi/NmzXo7VIleJdoQRZHhvxHvP9u8/aTPGtDDLxYc0N9u7Ai7v0QdiPlT6xL2D1xC9miKloA0pOSTNYP64Ww6coWuuBp6PvQl55bRIqgBcmG3ptia6WP2O0zVhrcEG10JAbKE4DWLKF5cHVqmZ8uxzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIJyeQVnccwYK5gH11SdCl0dh32d4XLD7PYSodLOz3A=;
 b=sMRKrG6TQonjZncfAVi8ankQnGAwjdrpUrjWUhPnOMDKrwrFiXkhnBB5wCuj4heiLHzM2pcFr21xYpDK57Np0a7Kq7FbYbI58dt2u45O/PKrbQXzRI7R2RmmwLpgg7JsRKtczsZmJBew2KVFv/JD+/hS+xGcYdqdIDcpV843KYo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB10049.eurprd04.prod.outlook.com (2603:10a6:800:1db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Wed, 3 Jul
 2024 20:59:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 20:59:01 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 2/5] arm64: dts: layerscape: remove big-endian for mmc nodes
Date: Wed,  3 Jul 2024 16:58:44 -0400
Message-Id: <20240703205847.2826263-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703205847.2826263-1-Frank.Li@nxp.com>
References: <20240703205847.2826263-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0055.namprd04.prod.outlook.com
 (2603:10b6:806:120::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB10049:EE_
X-MS-Office365-Filtering-Correlation-Id: e6f44796-5d00-435b-251b-08dc9ba2f748
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pepeytv60ZFXMopQg4UAJo1fbnJD2ZuPJ0B6CsrOvDzKH+8J2/lw6cwTpRhB?=
 =?us-ascii?Q?FadDABBJp9ouYzSRROlVgzusz6ECVbB9BPm3thxX5EkFLYEnXxhydsatxFZx?=
 =?us-ascii?Q?V9eUbwdXHKd5YWVi/vHuF7K/Moy9HE3n5aAEBlnd5/QEznWw21Q7Wp9KBBwY?=
 =?us-ascii?Q?CDRiBc/VhYfAo+oUe0/87mEEDU6/d5Dcv0BTYXf7heh0Svo2F48UKfNvG04f?=
 =?us-ascii?Q?fbwXse7g+xJzuyCh9GRS27rjiWaHRkdKphcfOkC4fMokLSiGYx9D4yz5cT04?=
 =?us-ascii?Q?j07Q3hKefm5jPOzRZUPTRJksFX7gxOVkf0twfgWNuaUqEA8Ywng81WpiIg91?=
 =?us-ascii?Q?Wg/QBhzv1Wpk3hLsIm3WNPRqwR5Z85688v99w6irDhfFb7wF2bXdB4S7rnic?=
 =?us-ascii?Q?fCNWJSUSKU8mf9rpInDxZ6FvJCi0cVHn1Vtk+rE3nChFraViH67gCOpt5LNz?=
 =?us-ascii?Q?3ed6f+0eygPJhSaaEyiUv4b4rwaNLI7RMYjytS31jEbRb67nRf9FtXUV6vYV?=
 =?us-ascii?Q?WYc9bTZ+tide6AF7kZ/dIAGQFTGavvo/n2U29oSGMWRQaH9nYMYIftrGIxjG?=
 =?us-ascii?Q?NCb52xwYUTibA2oP/J8nPXei399Za5DmvidPaXUbCoxZkW0O04ryXvxlv1Ru?=
 =?us-ascii?Q?6quRbk07gi5uTzeSLk+xP+wFThKDz3Rf18hyEUvBfnzoSXTAcBP8x1bybKvX?=
 =?us-ascii?Q?tk2DipwvHIhQzlgcy4eN2W643NuXDX30skjPKzPqAiP8N+5VlxyQdpuNHYdf?=
 =?us-ascii?Q?1aw11V43ChoSou45qLWQjP4LjWa3dXhIElaGzOiDKLJAAuxnToUvks6xrfPU?=
 =?us-ascii?Q?GKIJFez4vr001ETlHuL1qLOC+yUkelAbPFebiPHIlHfJc90v3VEF/Lr1/Ww7?=
 =?us-ascii?Q?qSgnZLBPj7Wkt5LErv964j2l0cVXyKvzNa1MTAW7qm4nLxl4RkZVBgA2OZGT?=
 =?us-ascii?Q?mJ3s2AfOdWk6PAk4suYowsnR+8tAneAYtxeKs/8XCWxQRhCLdYLFL+EBBu1M?=
 =?us-ascii?Q?wa49ldkVJjspw3r20ctxmg0z9fzNevq+JGnpA7cJKLqlyza8cLG5lIZTK1f6?=
 =?us-ascii?Q?8IKL27ZXd15wGWt8kMY3tMLT6PfAwPN5kfUfESEG4EK0LH189hWBhuQy8kaI?=
 =?us-ascii?Q?dnmez820IABeveeL9G8pIRspZmoQgod8IaLBalXKZ/NNLd4Yb/vNnPn+u/Gc?=
 =?us-ascii?Q?CzvefY5snwEM2Bl265V636WGm1SwV27POytWWl3XRBAAPDqtIHL1zS9KVY84?=
 =?us-ascii?Q?+erFOPHO2FspxjKzyLztUsSR8vD+6R2VbsIjnKWN36iifJ6xxusVeXel21a3?=
 =?us-ascii?Q?DVW6nEX1g2pHULS0WXgyRYEAIQggEH4odGQPTASrsdfKgoM0AU8PDANiEr+8?=
 =?us-ascii?Q?Vk1VqAE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YRYgcIpBhQk9hA9zVSNV3zIRh0vLuW8ECbjtZAwdikDQc6HJ+rIxpZux0Oer?=
 =?us-ascii?Q?/zpfo2zAxdDxUtE1dKTH6tq7E/V44AQZ65Ws5SzCBp1PMuKZ8PSkrtmGRtDU?=
 =?us-ascii?Q?3iWD0L1y6bmI1QF5+0fSRlRpURgK8bVA+jgaz9s6AB4Xeyh4sRJe6IkE3vLT?=
 =?us-ascii?Q?emmWHXYYTkFt61gFpBrgW/LphUMhki12mYnTwokORqlWr5V8NQBAIngIm2MJ?=
 =?us-ascii?Q?+OnDIehD6nPVkNDTDVm0rNwVZrNocgQ8kGwscKxxptVS4VIQhZ0Ir25fYAXZ?=
 =?us-ascii?Q?K0wiVjTGHtUAIG882EshWAxpasUOjsezbHG0QSfpBTtyUpGJvTcSZz9AlG6J?=
 =?us-ascii?Q?uJ/IH6a3OQ8o5DW2KR5pzLHSJQokQYJTPiEnZc0jK2Y0/Tv9oCIzl2gNXpfe?=
 =?us-ascii?Q?wUMPJQxE8YPHivPNYeLUSxEtE8zov0S8Vavd25lKOq9t+S/NXrmqZ+3c8tGY?=
 =?us-ascii?Q?/wriJkynOrQ1RQLMCsiydewka+hkqfby8Zrn27Y88Es9uSjdF5++jL6kVbib?=
 =?us-ascii?Q?RjhdZv4bjKOyPdEGA0Z6SdU4c3uufe5/vPVNp6V4/xrZCsQPBq9PL69bwGlC?=
 =?us-ascii?Q?k28SC6YbILzx0diYl5QMZuGfRN/Vm8kAMsN1da0jz6HeKv4moSXi8zp1Pyfs?=
 =?us-ascii?Q?1oXI2nT1NP6Ma+VZJLkWu8C8Q1CHH/ZaQULsgiXGxrchxLGJmzq5NsdGNNbZ?=
 =?us-ascii?Q?BtTNLqF6nheo8JbDfZff7eWC4fHX3j13I6G9UTDc29QxPH0mSoV6RTMo3QL9?=
 =?us-ascii?Q?ZAb/E8buURi3KwbnCvgUZ1lv3ic+UdrTlfPoe+MpU4fp3V5q7BWbY8Ui3M4X?=
 =?us-ascii?Q?IZXrAEIgOVaLa6j1+m5iU/+eXyDyWS6XaCU4hCX8BiwNChPw4w6TV5dkequV?=
 =?us-ascii?Q?THq3xG/uZZ9i0Y9EbnCEiNhiX45c1EHSgyDwhS3N+IsbUlIbGvw87UclU6rZ?=
 =?us-ascii?Q?q248rQwexQAbj/OhkJGOrO+xwCPOdrMyoUNiqaPA/l6JrUyFYZL4TqNrP3Fp?=
 =?us-ascii?Q?pudNQCG3Qe611yHfGNsRQDwO8MJLvQY91P90umc69nGmu08GTBOnWu3GmhqS?=
 =?us-ascii?Q?IUmTAyPOoc7PlW28qpQC9d1QMMec7tu/Oin370CXiOy340da6bGWVIWEJ+Ln?=
 =?us-ascii?Q?BBT1s61FGrhEeeYhmJIKWj3Qrbdcwp01j2ezNUGSaoCN+utJGc0WIAMkWbWt?=
 =?us-ascii?Q?XARy/zmi6HHqmoeU1CNlevjgLL62taHx61XEDCVFOZYQdPuJ82nHnUMGCC8Z?=
 =?us-ascii?Q?KuFX/1K46SEti90z7IFdsX5CFSxkarSegvvzyBn8/cPr7WcbsUyn2MfBVuuD?=
 =?us-ascii?Q?OLUD7wzkImg4G1PY6Hhj4pmJv0xBTXfTb7k1pUEnHKHZU9g/SFd6d03+Adv9?=
 =?us-ascii?Q?/E6CYU01jth1hBawmilTHEHb1/x2zy+lFjQX4iLV2LJrXhYLW11dBggcdkKZ?=
 =?us-ascii?Q?VFtvNElWhckWzK7FsMjRK7s+AcAOD7Fdw/hhGY/F1r1vQP1NfwlANj4aAdev?=
 =?us-ascii?Q?uGGcDyzsXhhuFRxOUagwhFxLSLBEFcQStgGPGI0tXPssXDW0GrIYjvNiDlMI?=
 =?us-ascii?Q?joRVDGvrH/nFd2w5/HdJMXO/w1Qy69hEwYkBcgHG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f44796-5d00-435b-251b-08dc9ba2f748
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 20:59:01.6631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2oiEIuGCJMa19zlPO/gDUJuyMLz0uZYJH1Yk+ERxMrXRWfkpHTLsLdbE1srjaDNm7EklJT/AXtSCjyXFfwEkGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10049

According to binding doc fsl,esdhc.yaml, the default endian mode is
big-endian. So remove big-endian property to fix below CHECK_DTBS warnings:

arm64/boot/dts/freescale/fsl-ls1012a-qds.dtb: mmc@1560000: Unevaluated properties are not allowed ('big-endian' was unexpected)
        from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 2 --
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 1 -
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 2 --
 3 files changed, 5 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index e61ea7e0737e4..42d2134b8170b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -164,7 +164,6 @@ esdhc0: mmc@1560000 {
 					    QORIQ_CLK_PLL_DIV(1)>;
 			voltage-ranges = <1800 1800 3300 3300>;
 			sdhci,auto-cmd12;
-			big-endian;
 			bus-width = <4>;
 			status = "disabled";
 		};
@@ -183,7 +182,6 @@ esdhc1: mmc@1580000 {
 					    QORIQ_CLK_PLL_DIV(1)>;
 			voltage-ranges = <1800 1800 3300 3300>;
 			sdhci,auto-cmd12;
-			big-endian;
 			broken-cd;
 			bus-width = <4>;
 			status = "disabled";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 17f4e31711209..9a19bcd1850d9 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -431,7 +431,6 @@ esdhc: mmc@1560000 {
 			clock-frequency = <0>;
 			voltage-ranges = <1800 1800 3300 3300>;
 			sdhci,auto-cmd12;
-			big-endian;
 			bus-width = <4>;
 		};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 200e52622f998..9bbe2d686a39f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -315,7 +315,6 @@ esdhc: mmc@1560000 {
 			clocks = <&clockgen QORIQ_CLK_HWACCEL 1>;
 			voltage-ranges = <1800 1800 3300 3300>;
 			sdhci,auto-cmd12;
-			big-endian;
 			bus-width = <4>;
 		};
 
@@ -694,7 +693,6 @@ wdog0: watchdog@2ad0000 {
 			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(2)>;
-			big-endian;
 		};
 
 		edma0: dma-controller@2c00000 {
-- 
2.34.1


