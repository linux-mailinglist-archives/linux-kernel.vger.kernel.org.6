Return-Path: <linux-kernel+bounces-348233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3A598E468
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A7681C21AC4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3271C2178F3;
	Wed,  2 Oct 2024 20:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DO2WgtEL"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010052.outbound.protection.outlook.com [52.101.69.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879D6217327;
	Wed,  2 Oct 2024 20:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727902102; cv=fail; b=Yakqlk+Yljg+qejD6FmjkdzfO7KgI+6JMJVfHve36PMHyEDDPVteS6369fFqctpInSkT57QkelLsw4aOPL4Mv6nFf1+IEM1SgeoD+MmgDfXyjNIZxOuIDrjZRiy54ZjIhggXPNS4djN+vhVqUKWwH8yvVoVyUZH8clZ063FGcBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727902102; c=relaxed/simple;
	bh=0nFQvWAIPyR7GC7XD2bTUFLzd3FupB+yXrn6n2au1g0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WndIlOFwgFqNl9MUuRoVWa5gwbc2+Ptl1cXDBg8DsQR4DeNAbxpJhKXgeAEjRGfDzek+QGS4nj5u4oXopykouz9mHtutauGRmP3gT3sUW18tBz3hTmjSo4SM53PMAD7Pnq+CxZLpgApeH4n8mNd2SjUfI6rZd8S1cS5L8bT3B9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DO2WgtEL; arc=fail smtp.client-ip=52.101.69.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ae1+AfP3j/K7QddmgIuHLdrMjfI5C25GSFrT6Ys8U1HeI8LttLWmYXkMBQcsk35AwjiyuDU/fkhVILYde4JfU9HcZZ+FG7Bg7B6BHmTZJ0H+UQ75Y/8hTfyqYaeexKXcVyXwup63x95wchcY/5gy083H69IFm1jh4qHIAP5lvlSi70Wvvcz6uYkWkYNf5mBc1fK+qGzVuMIG4dCweFkCDIegTexNReJimgNaPUc6vPZDb0+Uc1+AMkmBXNZMDOrkVwQTYBTBwb1g9gZ9P87wFFUp5TN4GWsngOUbzmQCWN7FWpnYLaXw2OBecd529aawFfLD/FBritEFFw0/gDkdlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZI4zlyTDdt8mx6v608QR1MmWbS4HnSbbjkzUd0Gk0/g=;
 b=Ia1LtJjYladZUvcx84RsAZz2xzi/80hhydAJfpZLDavOATnZ73xRI9FMIfTGES+7GuQgrw4hmfyYr0TbuOQKmcSuZ+EsscoS4au2n7vbFfWS1Vk2/iJP1GnFy6RPOky1eyeB0jwRhr2M2RgQ5rzrqvM//827yK1u08h4ZKTGumLcYFj+1MRJg8qFxLf/QfeQRRKmxlvd0OkGZrFnz9VXtx1oW9vardAZNYMh6XgahqtVsl4ur07zpi1VnSlHWG9VbPtSzx9OVqzd0E6hhfmPmWxYTvM2Sw+6/jESrIKaiFS1uJmOkyQpmcsRyyWY+Dp+seXjyuHcZYS6yYwCA7FT0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZI4zlyTDdt8mx6v608QR1MmWbS4HnSbbjkzUd0Gk0/g=;
 b=DO2WgtEL0NlqDUT5/3ZgXUJEw3Eqm1wfWbHE5gsMJcMkSpRMnZKapcBYUjQtrPQAay+nbmw45iv21qRHid9xXFwt4oVeKn/nb0LD+lIsOLClgcRYLDIO8CjGcjN0L4nPERB14PTr8QqG7/qmM5TiUcqn4Fk+5YHaFg0skLqF0JYpZHHSzsEcIyuW1+VJXRw0Ig0aRJXECayigOY8709cu2+0Uu8uUhk76fijGsZDsmeBtqazQvO+LLZu5Rl5doOZwlvKdrIq4mAj98bCs1/BEYGyIh9VPoYKeDpvDqN596IOK3rwWUs31JuzZdXeqdQQcEnlnK49AsrKTcQqo3pSpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9454.eurprd04.prod.outlook.com (2603:10a6:20b:4d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 20:48:16 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 20:48:16 +0000
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
Subject: [PATCH 3/4] arm64: dts: imx8qxp-mek: Add PCIe support
Date: Wed,  2 Oct 2024 16:47:47 -0400
Message-Id: <20241002204750.597337-3-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3e52f990-0294-4ce9-56d0-08dce3238a6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yv8Z1SjqZqxa/WA2oVWbI7WfYDobGdS/h5lUWAFCfvP2/gS7dnx0paoapJzM?=
 =?us-ascii?Q?jLvYoHgOtSOsNyvNv1bhRbFeKNSn2uuffyXo/RPnlh2ibKYzHbBcFdt1Fvqi?=
 =?us-ascii?Q?3kVr6vebDyUZeQeVLDjSYDFI/InLKRXj8fY43/hDvKd9kwSrgtbpNXNtex4E?=
 =?us-ascii?Q?Fk+e7CBwFWF4NjDulXmfItMDfcXRsnfy21cBQtk/XbMJubMloQqoJQFMQau7?=
 =?us-ascii?Q?sNjSZcevbvQUQX6zyLwdt36zQhBxatxzuKYVXkZmkhpjWPhYTmnPRtwHkwRx?=
 =?us-ascii?Q?vFFlR5TMbbSTNp3Pkl586AOzp4qookf4shYwlqOrArItnnZXWDVIzMC8o5D2?=
 =?us-ascii?Q?FCl8vKAS8w04DzQR3D5suDGIPU4Ug8zQ7W3V4Cfg8XPy97U3u20ZwkGvp9na?=
 =?us-ascii?Q?bkjsfhpQmhYP9ECEGqSgqG9uoM96D5CwshZ2YDUc7zyGXy3DmKbSSNGUm8Dl?=
 =?us-ascii?Q?p7w+u8WGsZUVM8DPn+W4cot+FSWrpUydi5Gm4e1SViL6tJoPHa/AJ60UuZpi?=
 =?us-ascii?Q?qxrxHnqCLBCB/dUyI6Q4+y2a9wOhnKpEdz902cVMJwEUQ7+XqKadQQruazeH?=
 =?us-ascii?Q?h3uG+Ado147xvsoR6yhkkrdYn1sdTBm2cNKXT20oL0QqY6Fu9PERDxzipkkp?=
 =?us-ascii?Q?jXtGkf/SN/tPfG7cCgtHnezb8egS2ZsYZpCfhfbOAKSkJbN/OaOjFPAqsCWh?=
 =?us-ascii?Q?R1uFz7lvGjdPeE38sy7ZF2Q93QL23oWV8EIYklb0A4w2xpwdLErzTuv5CEet?=
 =?us-ascii?Q?VSP/gBvpsxW46KwwD3XASih+FcBgy8N4ba7xV0qaostcD68Lzeq7xTClHCZg?=
 =?us-ascii?Q?RZlo3E0L/OfoCGVNvpr06N5hcyWdgLUbQ03upW8QzxPsyXMhdqNM3/Nl7+gh?=
 =?us-ascii?Q?iTJQq9ccoidQr9VFWrtPMP7uxM76VgUQBKHfxlw8nC3EdWsyho6MfHT+WxRY?=
 =?us-ascii?Q?jxKHJfkrg0Y6vzjYzo5NVNBwAo5lYkCyB3nlzxOgFFWm1pvan0jxJME8PsIE?=
 =?us-ascii?Q?xhKnaOe3bwf0OlOk+fMx2RgXNHCsQT/F6RWpjmKP0u0DDUntrUx/olXL+OpU?=
 =?us-ascii?Q?jXz8++kMv6fuO7YDSkSy7FyHhVng5ktcaAhdEMxZbxU3mnC5UAaiDjpN+LHt?=
 =?us-ascii?Q?JfkdYEdAzT/MPBnwvaMLux+p4DP1NqR95H07GADa2qqbAg2qgnKkSSvck9TP?=
 =?us-ascii?Q?CBeHFxyZrWBO4qtEBbotNwRloC21Srhs63bZZ7GmuDY92alhkJxvJD/dkEjl?=
 =?us-ascii?Q?KnJnrfZ71O0E3hrtRMC63EQEdyrsGxKWma+BMoqiVe1jsa0smh2MYK5ZXsiw?=
 =?us-ascii?Q?DHNMtK09kacnx/u7/ZdhUGNdnsCua0eERTzVzkB+Uk7SULF0RfqHLkEn3Bcc?=
 =?us-ascii?Q?LP8jZZA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RXp1E7/dA2hhxeE46HEViU0+lqlsKpsB2hM3AwhNbo/S1WBbAnCFXqT6lPok?=
 =?us-ascii?Q?VUSi9Z506F1OALVQ1j0Osa9UeTHU1RX16c1psROrtsuO0lqoF10tFknQ4TLP?=
 =?us-ascii?Q?USaZ16e7rYlMELTjzbB5KrJ24yWkaiqboKuZlqENu+F8f2StPIjneTmHMWmO?=
 =?us-ascii?Q?OO/82aQv7s3C+8RQmabcgi8y/CLdWvCdHD90PXAGFTNJGSx4vwUlvQxnwZXl?=
 =?us-ascii?Q?wP7gQLJl5ffsY2SUXhRcQdej/pjNGkYmXub+1iceNtLyifvLOJObCDhaJJu0?=
 =?us-ascii?Q?cpB/IVA9od5cJKj3v/EElgZGZGQXsoDbDDruAgPqPBgtDJfxAfXPx7MG623w?=
 =?us-ascii?Q?XE2Me9rgGYJI+8tih5+WPivGU7Pt3p2UcPPNV7qJvkI1ohXQ44X6OZZpsMxg?=
 =?us-ascii?Q?fqEvImIBJGXXN5IMoUqO0tkyQ2+gdghilDLbznBWv6VGWQOMLTFES/IBogpx?=
 =?us-ascii?Q?s6j6Cek2RuDZDZ2MNvZNy0chMxW536mnzkxZXSEtuvv1BVeGOn8LtEytalhS?=
 =?us-ascii?Q?ID8BYJDerLoDqelrYU90TkqPhallnsdKoJKO8FPsw8qct+6UUFUEP8zEv6ti?=
 =?us-ascii?Q?ENJCtvQ13Q1WKrtjmVhqPZaB1B9+bvmCSfdniCZAy6zxYyrnl4k0YGscIR47?=
 =?us-ascii?Q?TtDq13RkRjwVn78TluaSuOkqeD9q744pmAsRcM3U1REFF2zxWETPTYVgWDVj?=
 =?us-ascii?Q?BzM6M/6To66ixMyoyVlNhpEi36JQG23ALRiYxm/lkmu2QktnA6E6RoknCgLb?=
 =?us-ascii?Q?yWmLWhm16DSt9ZSU8Ef2/SFiN5Et/VRUHFEa4NkGqHzFMI0bNBj5RPbjiF/k?=
 =?us-ascii?Q?kWZd037PgWrD9+JQILxsTi48pDpAvh5gZ3ue1QWcf9cRd4DR7+AjODk2Zp26?=
 =?us-ascii?Q?XQ3xwsB7S4+iv1fdQAaWNA6QJiDtwwHgO87qYVrY/QXPqX1H8oFB1I2rJVpw?=
 =?us-ascii?Q?z+URoEIatV0ixnEKv3r6M+VR0HaXTTnVPfLoyCceb3NlpicJykGqA7wolKtQ?=
 =?us-ascii?Q?h9hRWL7yfZ5pQbew3D+F3K0H1X5dnOW0WGRX8oys+IDuExgW4wRnr+aE/9c7?=
 =?us-ascii?Q?MeL6pXPxJKDLytDTTuLM9OYDNjWWqrYX/3TcZWRA9GA5F98FwKEJtRGXLwNk?=
 =?us-ascii?Q?4vtlaYhxTWU7XohGIASkKzuXp8acFOVCyBsbks8q+43y60RnNsog2+ei56bo?=
 =?us-ascii?Q?S1lEWZ9FUtAFX2A+UsX3gxhsO2dM4IP5HlFRQkH3ev7KuZLH7g8rZVkAZHlU?=
 =?us-ascii?Q?XLtHRVld47PbORUw8aYDce86mZZA3MXY3R1GNoFXxhVHqltiE3+g0cIi/yQR?=
 =?us-ascii?Q?kTP0tjMrnqhsQDKKEytcw8CQ/5TXYbrRNHvVrnnqLF0+qK0JbL72iRylPS8u?=
 =?us-ascii?Q?kHTNesqsVBx9/FeAqw31henIfAS9jC0crxJ72ftOdZeS9AYNBsKt5yin3A9f?=
 =?us-ascii?Q?5BnCghXZ2Xt1wXEaUDn8qjZOKjpnujau02pY3/wNCoq7IEzr3JY7/76wsZI+?=
 =?us-ascii?Q?mAT3B0+RFaA+vMWBHkva7j48UzBk7vaknTARSRskXNfm/uGPHXptvfEDlInW?=
 =?us-ascii?Q?LwEnS+Pf1nosnKNR9+HeD2PkWNV+ylqGMS3UL3jE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e52f990-0294-4ce9-56d0-08dce3238a6e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 20:48:16.6831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U8dOr/7ZnFJ43s+J5ehib7zEh963gNMeOCe7Lc6ESJfTqrAGnbHrZKruDaDxs15VO9kRKg5UvzlfuC/AhZjalg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9454

Add PCIe support for i.MX8QXP MEK board.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 936ba5ecdcac7..9f643a4ce8ae7 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -45,6 +45,15 @@ usb3_data_ss: endpoint {
 		};
 	};
 
+	reg_pcieb: regulator-pcie {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "mpcie_3v3";
+		gpio = <&pca9557_a 2 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	sound-wm8960 {
 		compatible = "fsl,imx-audio-wm8960";
 		model = "wm8960-audio";
@@ -246,6 +255,12 @@ &cm40_intmux {
 	status = "okay";
 };
 
+&hsio_phy {
+	fsl,hsio-cfg = "pciea-x2-pcieb";
+	fsl,refclk-pad-mode = "input";
+	status = "okay";
+};
+
 &lpuart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lpuart0>;
@@ -272,6 +287,16 @@ &mu1_m0 {
 	status = "okay";
 };
 
+&pcieb {
+	phys = <&hsio_phy 0 PHY_TYPE_PCIE 0>;
+	phy-names = "pcie-phy";
+	pinctrl-0 = <&pinctrl_pcieb>;
+	pinctrl-names = "default";
+	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_pcieb>;
+	status = "okay";
+};
+
 &scu_key {
 	status = "okay";
 };
@@ -493,6 +518,14 @@ IMX8QXP_FLEXCAN2_RX_ADMA_UART3_RX       0x06000020
 		>;
 	};
 
+	pinctrl_pcieb: pcieagrp {
+		fsl,pins = <
+			IMX8QXP_PCIE_CTRL0_PERST_B_LSIO_GPIO4_IO00		0x06000021
+			IMX8QXP_PCIE_CTRL0_CLKREQ_B_HSIO_PCIE0_CLKREQ_B 	0x06000021
+			IMX8QXP_PCIE_CTRL0_WAKE_B_LSIO_GPIO4_IO02		0x04000021
+		>;
+	};
+
 	pinctrl_typec: typecgrp {
 		fsl,pins = <
 			IMX8QXP_SPI2_SCK_LSIO_GPIO1_IO03                        0x06000021
-- 
2.34.1


