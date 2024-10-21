Return-Path: <linux-kernel+bounces-374994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3229B9A72EA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB3361F22873
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A551FBF74;
	Mon, 21 Oct 2024 19:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DQAtF/V4"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DB11FBC87;
	Mon, 21 Oct 2024 19:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729537591; cv=fail; b=HfRxrpnQNRrstDMRvuOzpJ+apAUCcPj2z540jFl/OIVPXlym5b2e+TfIl4a7Wokq62qR1M+YPI1FdVFPo0TMGh3spB2DE/gCbae2t/sxodpE1KWdtZezsQhoxt5TnmI89/pnlMn3aR8tyHAB1YZbdn9P/TN9dnx/jjD1pJABAu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729537591; c=relaxed/simple;
	bh=q88ozZ1oLt3VLVzdodUasr6UXBsRd/xL+PCCN90/Du4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jgJr8VqFixjasQkz8qJoXSmpZYq/7mw7OVvq4PMxH9ObfPfRUTYhtbwCICL3GUcHt/AYakacBQf7oT8zHQNlAMBKbZnWNGqWnlOAi41G7Tdd1UveJSRE7F0xD2l5GNDQs7+8KkEjO5LqAwAasoAFGdf28RM08rpFDZ3NZvgDzGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DQAtF/V4; arc=fail smtp.client-ip=40.107.20.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvqCEtOhenzxtUPbJxD+Zhuz8yhpivREjkMmsib0RMWTUC3wbXmbGzPPUvMnA4z0TUAT5eVGTAU/ndbWbxiG+wZthr4IQE746+wYTu+FX/jYJT/swbHr6pbQSqvWB9COPkkhFbHwLULIJ5euJXOtHevvDheDf78hRAsUgHCgngmCGMYNvU4EdmyIdcCMBC5FGKXHWYf3b5vkKWDx7Fk4hNDEKLnrZy9oUQK8zOkEru+x3Gd2tJBQOybgW4M5f7/xL4gImCYWZl0m5FIx5oJ22+JwpH96kHD/TfHudqbSQeBRKIbdusKiBafjAnLoX6+hUz0xyBwoqmhYjhFyG6Wi6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lapmvN6n1m96p9uW6EntsCN4o+a7YLrPIMUGDGUkCTM=;
 b=kCRLUcv6FwW42rUAM6NMGvsKNRuDMuD6bbmhcWWfNohb5TMqul8eIS2LLLISdOA/jeQWhpQRCoyD2lP2CLBWoupSd3wiEvZVgKqnrR77BSv+vXJALh3a+Sh5HqOx2Gq9lkIqmLR0xvXJo8iUIu17sV2c7FjfIxxbUdfv16ktGMX+iEFOfGKuluxoXrCUbEeMR+IB6aiMJXg2OQhtdpYAnLsQi5+ii8xJqv9TuVLh+YpEW01PqhbMvnrBJNSHAH2NYWSjUM1jmqItiI+FW7dq8Bk8tto0bWkkFvpWC4t16j7/Q9lJdUOB2XvtD1wW/lrmUbJNTdgflt5mh9aDtMKklA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lapmvN6n1m96p9uW6EntsCN4o+a7YLrPIMUGDGUkCTM=;
 b=DQAtF/V4U8QjP9m0sds9xQwIfVKx4q/zWPl8WSMJvBVrg1hwLmpiXYNU1kqE8+KUh3Qnc2umZVVbaUoS8gyu3ZdjIN0nMgW4bdC4SyyJ6ZVJGPWBKYf73qWiPEuAjYjOAGLLWsmvbioWY7xNlpZcaPa08CK+X6A2qxCtVV/GD2TcXePIInJLGXaFHofF87FHMAHqUQsCK6Ix9veNN02J43WHLmO7C/W76qu2ucUGTrUpWez7XPIth6OXTWowbbyZYWnHkk+ar9bC28JB/OcmMts0YB5s3FNTn33+FVC+z/Ot8EQiePEWkymcX2y+C7L3WMYvl8Rhf3X5e7tKBGxMsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9939.eurprd04.prod.outlook.com (2603:10a6:10:4c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 19:06:25 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 19:06:25 +0000
From: Frank Li <Frank.Li@nxp.com>
To: shawnguo2@yeah.net
Cc: Frank.Li@nxp.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	festevam@gmail.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v3 3/4] arm64: dts: imx8qxp-mek: Add PCIe support
Date: Mon, 21 Oct 2024 15:06:01 -0400
Message-Id: <20241021190602.1056492-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021190602.1056492-1-Frank.Li@nxp.com>
References: <20241021190602.1056492-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0006.namprd07.prod.outlook.com
 (2603:10b6:a03:505::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9939:EE_
X-MS-Office365-Filtering-Correlation-Id: a4c55fea-1c82-4ab0-ebf0-08dcf20375d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f6sGgozH8bfA/DXv9pte96rP3YrcTIqwNG7tM8KsrBzTMfp3udN5rUgEouzl?=
 =?us-ascii?Q?dwsPLkNS9DJnniZChnLQlHApDJU5F2kOsUs5sIEoLHhLPKhBdmuUR/SDLmOu?=
 =?us-ascii?Q?prNuHcuW/IYpwNwmgTK+et4NObuXnDhfLg/zX5+sbkJzClWbAEHAF46VnEgd?=
 =?us-ascii?Q?1CCr81yj9hvBleyNRPzcoliEsFMgxt5NhGRrGaMKmW90CAW+dF+D3OIBvrEr?=
 =?us-ascii?Q?kUeP5mA1MZXxzJn3Se/uhDe26cBeE1uKeXwMh2OmDvma7ocQcdIiOcJVrBbP?=
 =?us-ascii?Q?0K4xf2tkf+jzdTwjLkzFkOGTGW1YPyw6wHYV1h92UaLhmN0Tx7PQaZBy4L+7?=
 =?us-ascii?Q?7sjA70csh2UDol06M//Twuyah11HweuFxZ5xSgKwxTmE6qjjBSd+ObdcAbSV?=
 =?us-ascii?Q?jXatANyysE+1LbBpxk6wCCm9GAivjiSakr1HsoleA5qccjIQ18EucUxw+1q/?=
 =?us-ascii?Q?PFw473Id9Fv4kZwrk5P7pfwQSyI/9jgT+G7fBKCvUhouANa72mPadHLGFPcs?=
 =?us-ascii?Q?sGqQM+kIMGa4yCe9qbuoqHxkJ+9g6n/RzEBGlDSzw/GmoorkJsQ+5mPY+1P/?=
 =?us-ascii?Q?qKmteD+hS1yNvpKZpozDS+TX0Xeh1XqrVWEqtvVxNkBl9O8QuJb3MpUXTjBj?=
 =?us-ascii?Q?XYJ9uJSiLMUvrzWfMjS7rw2GyjS5nWAlQmE2qmMy3mzGKBBmxWhfXOdXDv7A?=
 =?us-ascii?Q?kKnZ2zeeQh2aF0HE8CxcHLa+CI558NZvSHenIjuioW0+vLfe3Yq5G6t8eyQM?=
 =?us-ascii?Q?geJCn+16FwciBIo/Lxogd417m0eMbu8v5OUZuu8DtFspp4PrSQv3XM350Vwx?=
 =?us-ascii?Q?+jNlyLys8EhfLwA4swTI9AIsa3lqIDEFNLGse+UpHBghm+gCm6c75ZTLfXiW?=
 =?us-ascii?Q?1HQaG5Ab7+uumc+zshWoVpigUy7VN/nXRArdMY2SfAeNoI3igHWjgPT1YG1H?=
 =?us-ascii?Q?Zs6Zz3c0SEP+N4W2Kk7sbui5sp2vyUhz8DWjQ/1DwU0NC+/Mmn4e6WQJoLSa?=
 =?us-ascii?Q?dX17jKMhIjk9lEWxwW2c8U96CVyQsvlQhp4kIiXn8RfGDmfav+WuqX1X8aIh?=
 =?us-ascii?Q?dSdhH+t+bkuiN8Dc231/zfE9K7lYPmzJ5h4TsTdp5nPrE9LarBsJfC3Xmg2n?=
 =?us-ascii?Q?v1wCNW2g/ZdYNpc2vffVbRto0gXY1qw577IOSqDLclnwBpZ5XOWrAVRIBA3P?=
 =?us-ascii?Q?Kpd/D05QyfbpP7AUzHX+hPL1/CcMRk81QEgSy6HU9/5ez/VJxcq4CLTVfP/C?=
 =?us-ascii?Q?l2xPt39QS5ig26sx/q7Bg2dpM8IkyhqBkGYOdEPQslA4UYIpJHdO/BWEyGIc?=
 =?us-ascii?Q?XVnYShAkEQIoMYlDQnyCoo/aHhk9kw7BBlGCqEhNN0voeIDffN/0z4a+rtMh?=
 =?us-ascii?Q?wNb+fl8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mzcIqUovnhlABFsLpGDBcFC5PWJONAJ9qy5jUBLx7WXMJgussVxxwCoIrfsG?=
 =?us-ascii?Q?D68V0NuxWQ2oIryWXDh7yhoQdcd2ttIh0kyF/MdXpYNrUAHNQ4xZ5cyS91JK?=
 =?us-ascii?Q?+cB40Du40stNzoBaOWWN9LnGCyRUnyv+1TPHCy9ip5m4BcAiBw3rShWZFrzt?=
 =?us-ascii?Q?I0FB1NsUi0DI8P9Eebst3ALHcS1qKqoI0hJr8Th9tQY66TSeFr5bvdExAzOj?=
 =?us-ascii?Q?4UQiSywhEcFkRPxAbYoglkukyqz0hQyc7O2neqLIN5O6Zq6ZzE2pN4eIZ/4b?=
 =?us-ascii?Q?PJTYUBuoCkJ7It4mpeTZ4LyOpMPuwIoo+cwIXm5XU4MMkZEpy/hv05X3TZjb?=
 =?us-ascii?Q?9oDB4uMc2gO7M0EjzFx3Oq4CbmiIyi0E5SzpBxwCKb+dBLIsq+KlVRyCvqg3?=
 =?us-ascii?Q?jRhqC1EAuJQ/9SIAbxE5c8l1RkwooThMMzuxRiiWMhdOIwdSfwD+it2CjDK/?=
 =?us-ascii?Q?weY3XyHPFX6mRvuD4oDOIqapQ9c7/8P1YuMQzGGgk4wIkdcMJvKNhAuRG/XA?=
 =?us-ascii?Q?l3wKFUF8d7SkQ2LEKTNTbiY37EDA9wdK9gIlCcQXkwdt/mhDCPMVPRrRzc0Y?=
 =?us-ascii?Q?hVubvrTy+1tSNrkiQ6fuh2fBnRAYBm9sXHX5Nesu2MIc1/JtqDrq5ANlHlu7?=
 =?us-ascii?Q?wRLHHXAKAYtZsa7NA8PARoPzb8QFDzd/fYU7BY5x1OhmwVyi4QwEc9IEklaT?=
 =?us-ascii?Q?NkwUAS1NUV53e623oIaKVJuHMSFdo7clez3iZrODpHV6pY3B8aR/ZnE2CdYW?=
 =?us-ascii?Q?F4j/rRvMVNUuGMWJmIn3WvdL9KJpK63TMzRnToLDLdFcgNWj+LpYRwpgm4bE?=
 =?us-ascii?Q?iFQXm1PJFeu34od4jicEpsDjKHQ+5Hj0Anlc6fKgwsECzh+OdqQ4rP+j24m4?=
 =?us-ascii?Q?Z0URKETDDakUhMTtkpXZGKbH9cuE8uePpUVN2aNEIdlNyjedP3AGHbTNjAY6?=
 =?us-ascii?Q?8qNwpq9iRgknXGwDc70k29ZkaCpSMWgT6Fdh4dcRYnKwkKaQCbX//MuBZ4VR?=
 =?us-ascii?Q?lIWcx3DPmtwWWgGvFfmNmfMOsgMjOitezF+IkNyJ9PedZ3NyoO2T6wS+8jxw?=
 =?us-ascii?Q?gGjqtbWYuH4AmpDABD6kbyHX6Wrxw5ovWEPH9oB29Px2jTXYzsMS1kfiwvzB?=
 =?us-ascii?Q?W5WNe+5fcJ2hSlQbyoTR0NggWEDj16hpaCvPHjBRMJhLJrAB6bcgiZEIaEkH?=
 =?us-ascii?Q?0mYi+9rpTdQbACL6t4Uu82BjWFlAmdvQjrY3rMW7iqyLGQe6SWLIeccKGd7q?=
 =?us-ascii?Q?1ltEe4L68wcwQHhBcMQLPVDybxpixJwrisfU8SWDFxM7NfYN1tdjy7uR5OVD?=
 =?us-ascii?Q?aIgq7ZnmFNgBXC+ZklRyEhrOstkg14JWuSTJYWVb/k9hkvzA2K1JAw6rGgfy?=
 =?us-ascii?Q?JqXZwrkmR04K5ugz9dbooxc3YtgQQB+WnS6IzWUBFFkLFRd/xEtJC34lmQuk?=
 =?us-ascii?Q?CVPsumBmlQx4NhwZ5TTuVToK+5uayPBkc/H81OOvuQ6Ey4mC0qobNecSCQjN?=
 =?us-ascii?Q?j7TA9vJTF/f0zThCOUAnZp2jfqy9Lspo9hlZGI8vpwM2t/4/IlIC3zuIUej7?=
 =?us-ascii?Q?xbEAk4uidb8x5GfQbOqixYjqj+bS+jZVwE8JA5la?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c55fea-1c82-4ab0-ebf0-08dcf20375d3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 19:06:25.7516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ws3jMVpjoO2InkrF9bikc4qYF3T39JI1NTYft/Jew2EYaer4ytobjqed5bYfrOuBxyeQMQ0/qNr3DSwvvk06hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9939

Add PCIe support for i.MX8QXP MEK board.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Chagne from v1 to v3
- none
---
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 936ba5ecdcac7..facabd8478bbf 100644
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
+			IMX8QXP_PCIE_CTRL0_CLKREQ_B_HSIO_PCIE0_CLKREQ_B		0x06000021
+			IMX8QXP_PCIE_CTRL0_WAKE_B_LSIO_GPIO4_IO02		0x04000021
+		>;
+	};
+
 	pinctrl_typec: typecgrp {
 		fsl,pins = <
 			IMX8QXP_SPI2_SCK_LSIO_GPIO1_IO03                        0x06000021
-- 
2.34.1


