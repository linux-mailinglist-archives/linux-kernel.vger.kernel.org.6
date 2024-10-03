Return-Path: <linux-kernel+bounces-349430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 083E698F5E8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 20:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48ACCB22C27
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 18:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0308A1AB6ED;
	Thu,  3 Oct 2024 18:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KGqxg6dv"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010045.outbound.protection.outlook.com [52.101.69.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD881AB524;
	Thu,  3 Oct 2024 18:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727979371; cv=fail; b=AdIoiu9agCi8yO4ZusS+KBXc4KlzIh/lkZkH3sJ/Nzg5+nAfU+A0ILArm7kvDQQqAsNn1sRE3j5xE4rJJ0Zu9I9/443j36MOxnncS+vVYJZwxXFHsvalGLE5uCOJWmE/k1lnuK4TA4tB2/1crgQtglXr0HYkPMAwdMfVnI95xH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727979371; c=relaxed/simple;
	bh=Rxci7kLUyknfSSXHLG/z+QNpEY6dhvzDY9RlKzQaAGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pHFysfKaxkwW8xROmsxYdeQ2OTvZkuLHxfkZxbdrUKweW5hxTduE873vud+vwQvXGDgC/uB01rvCUvtioCIYzxTM2MWHIk/qTXlJ9/6Zx1XSNMQuQzIgvVtJxx5fTXvoAv2OWNAm6l1cfhU2bAoMK1VnsuaurISMWeSKIrAs/rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KGqxg6dv; arc=fail smtp.client-ip=52.101.69.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W5Q+vztwX52UjQ87KVmWHAPOsNoPYfhPMJYyUCpC9BvdeukImWhKWRQx6Kglu2i1/2ozWW2Kdgyr9kIMt7wrCeOEsENgqHyWiITwLfYubU9r9YzuxFVWuWHudn37hpfVvCOqP1IQYtEnhZHJ8Ziz4OHSK36ktr+APSWIsXv7r0/lBASjepktYlZij4TKyCUnEK/1YRQTz0q7YtHUAOdalM9/+94QOPs22FgRCKWwQSdVNwpRuuzDaQ9AxsicmMRQZbfn/4pzHfM19+oJdSGPISNAozXrl1rO4Gh5Z7HC3kGWfy4Mh4eGEEdrjCAjPuwRUUUQ1WO6J6lYrJU3hoWa6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YigBvtdIYapTNxgp5W83vHKbKkQjEEs51+cGPRxPFDg=;
 b=hEhhTJPmHWjVAs7kscazQfEfgaUBERvc2HFaGQo1H4jnnIqbOrxcnzXsDUnun/9t2hzFT3REVfTmuJodotBOVkfg2OgBmJZQVal1tl7ihedzqXU0/c0vgMqyvHQvrxqbbqCf2dfvC+EmeLQx+SbMOygKHAjfMK4V4D2n+CYiNpkVxltO7wnuZ7xqw5wXr3PI1qyrJ1IWBPj0mJPDoqUY1BjP6J6AQxPWKzaJPvFgxeq0gwrlhfWHZXWiUQlo5ANxhW/0zAFm1oNjA31QmerqqDOnlYX6N0s4VsN/svdXVrGCsNAZjnji/xqYq6To9YjiOyEegBne4sIxniTFfBp9qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YigBvtdIYapTNxgp5W83vHKbKkQjEEs51+cGPRxPFDg=;
 b=KGqxg6dvWCZkMMxT5I9dLKZuG8JcMdDpFKsM5aVNH/bOyvss1gH5prbhKI4BMDFH7AQQcLZTIe1auGZhaZFVO7Q7oqlF6aGdK5RTU921WzQAhztTk7PRQTb6HwnvKpO48t1ihcAbo4iZd87pAumkJXipzMpG0hVSKaIxrJPFKydd5dploRhEN0tjAcdZzjcCrnVbAArvaHf00kYU+bH+CDVu8zw3mBFBnYMl91QvN1tOgs5+7M5XSGr3l1/7FAfw3TgLiqf70JVBMz6F1zCDA+evTqqo8mZqWcW4U0x3Hjbv0xVbutU0xA40ZUBdG47XLqqmWOIfY4FbQGYaTtfshw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB9194.eurprd04.prod.outlook.com (2603:10a6:10:2f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Thu, 3 Oct
 2024 18:16:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 18:16:06 +0000
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
Subject: [PATCH v2 3/4] arm64: dts: imx8qxp-mek: Add PCIe support
Date: Thu,  3 Oct 2024 14:15:39 -0400
Message-Id: <20241003181542.620461-3-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 24be7272-7e77-4c16-e655-08dce3d772ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pwHi5yzdbLOrzPZi/6zvw9j03+XNBru1A4eZV9UlskgNL52sC8qqGZMUI1V+?=
 =?us-ascii?Q?YRhJjIybKPu+NTYABcxSiJGTTLe/zlWxZ+YJ19fwEOOe52LDxaGj3stF4Ya4?=
 =?us-ascii?Q?zD87Z65ND5kf7aMNvkAHLL5hedMr+5L97k4GpiQuOnTBwc3lXk8kbD+BF9s1?=
 =?us-ascii?Q?14prWNvGqpViBSjI2JgFx/XVaHx6AzwYxh8lAiZwapZmMiE1/+qR/OnC+MdU?=
 =?us-ascii?Q?MCsEbGl8gXRZzwJ5ncEFKD3nI5Y0iRv3Xiibzm0slavSZ6y/tCslrLYRka2C?=
 =?us-ascii?Q?NF3/RgqNgK3UJb34Zour5fsEB0OvZi4f3OK9l4i8ryJogopdsqbGYuxE+Yj1?=
 =?us-ascii?Q?biG9xbHRoCm2wrKUfBM4UjYYIOHuk/i9sqLw+gz1KxjCZLC4EQTq0AcqHAA6?=
 =?us-ascii?Q?GjdHHrLidC1UTzILMEk1+GcH+J0keKk1Gd9KujQLO3MoOsChuT5XgB+I7HGY?=
 =?us-ascii?Q?UbP2+KSFv9pmVPimD0ucf2lKeOILyGLTrK0gEWkj/LywvzhY7tcW2tAKA/3L?=
 =?us-ascii?Q?0Bi0J9GdsQtW0OeNu810BdSSJMDnGzM2fM66zt/X16sULts1jYpGvaD+oelc?=
 =?us-ascii?Q?5hq4kStjFeLthvQTj4LYn6aAViiDM3pQsET613npa+ScZk3GV2qN1gACaZnG?=
 =?us-ascii?Q?2iVGoyLGMV1jElmRnx4QSJIDr7sEtQEuJvycPw4YuaJHCdE8qlXHByk/9dLx?=
 =?us-ascii?Q?7ch70l5v6m74UEXAE3EmHg+GDIwI99ApNDS+nCAuhkChdhHShBU92RjbfgCr?=
 =?us-ascii?Q?AqadqL33YOrLxhxigdR3k65qGlplIlDPhHQyaRGsiIbzRWQ0vttp4bn8LPJ+?=
 =?us-ascii?Q?Yorenfhy5Xuu/xjnBEKjyrrjgiUghH+esPszGv6ID3lgtVMKB3Xm/ZxubWte?=
 =?us-ascii?Q?qKL234l7enIIowmda2o1n6L6XChyH2ZQQBTS/7DUuyHvZhuwwgNp46AZ/x90?=
 =?us-ascii?Q?87FPvsHXvFomgRFw1ZXrhur9QpUUdJL1dIIuX0FvnGQkKhFRjLDijzq2mDKF?=
 =?us-ascii?Q?pcwFI1k0SANc1AyBKzrKpevTbuyt9+Ghp91z9vU7pm6H1lrlwkFDn53hlYTz?=
 =?us-ascii?Q?CzwqPS6hht7pmrNWubC2jjsbESh0V6qrqmGUHuSN8AhkqLSfRyBmRcd49u9M?=
 =?us-ascii?Q?GCseT7hjIY8VUNLLB89ht2vznaO/ER2ETCrpCWTXaLJ3PZ9jDPCd0eOiEHre?=
 =?us-ascii?Q?mXHzz20IqDNFgoLrEirWLQrLZm9yHiGG/uiljr+VsDhnLEjFH/Tpqp/pXS3m?=
 =?us-ascii?Q?dncWmkZjqmgDwBsc+tdxPQz354BxeWcDqytWJePz3kipHnB7ijbrTM+rrBYW?=
 =?us-ascii?Q?Di7kG87+W/jqUwR5SSXS+qSxvb2e7xN1htpktC9nWQVrVRn89196qfAaEZB6?=
 =?us-ascii?Q?vg9sfpk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZIcw0FN7QiYUOtT/Y10idTobZG27oMWKHcIAd/TCjQVJe0DTOJhTPI/WOMG0?=
 =?us-ascii?Q?CCUoAYgjtZ8OEyfrRKLIlZC/1CLw1u2BjXOvMN4I9yEAINqUhQM7yXA+FeWl?=
 =?us-ascii?Q?OlZQLPCb4N6rza/ZltD92+XsgPfDb3s4/BA/aUW/mO4WPJYeFYfvcKvgJ6z5?=
 =?us-ascii?Q?AGV/YrZzzpSX3rOQVV2MBaGdczW3Z6h5k863sgePJb2neHap4tXuvUZnOo5V?=
 =?us-ascii?Q?jOOWYeOyQZc6Z0lCLRWjDP2TlwVQcEl67obQvm7nYUioy7uh8aJVxBrhtGcT?=
 =?us-ascii?Q?OYnbL3pbn0lR5dXeheMtKuGbhxnLy2cZJu6UwW6cPhOf+mQa6WWfUfHbe/1G?=
 =?us-ascii?Q?ipvqm7Ey5PH7bh3vGixtDo6ME0nfOyu+oRUIZuZUXupw7FacQBpsw1F2O1D9?=
 =?us-ascii?Q?jzx+ZhhAZBxjlYojxlFGjc1T86eGGya7lhzG0fSJ+9u7kJYfaHIhcqScwKET?=
 =?us-ascii?Q?JtKns+S4odMlZeYUndFloSai1yaZUOMCmu0uYKZeLPFXhZspb+n1yzkJ4Nx4?=
 =?us-ascii?Q?zOQta4c5lEOoMvkIHssMnPjjifTwtTtZ/V40D671DAGdE9PToU6g67yyCz5X?=
 =?us-ascii?Q?ckdfIBh135VyzMqerRK5gqL41MVjkzlnnw8rPjSJ1PchtRYRb0J4RaidEAHH?=
 =?us-ascii?Q?XNQZfkS30eOp3fGfrIPtiuoQDK8LWDcZ6llxCjgfIbqx7akfohWFqQG+DbYz?=
 =?us-ascii?Q?Q0Cunjk7YeRqi7JPVz2+OG4Xs8LsnK/CiEyPc6QCb2rd/EbLE4xaSMvOluQQ?=
 =?us-ascii?Q?2GIQwXpSYMFHbEaQ78fyhxzo72z2xdLUvFPhcRJTzYcf88YLV4IVDxA2vBVj?=
 =?us-ascii?Q?ayN+JHVM/9AprPS04buqEBNugE4olJey+F6VW2oJTDJ/BBIHNdX2m//QOGuo?=
 =?us-ascii?Q?brX2NhO37DrqmI7AR9rUW84itOB/TEEwE/UkgJhxAaQWrcr6xJzn4LeQAIUU?=
 =?us-ascii?Q?GEhCYpPh8nBVBnEstLRk8ffOFXCJ2JaxvACnL//1h7JNlnDbVRKj7yC68DV9?=
 =?us-ascii?Q?+EnCObICRPUBiPTdQZ4Kn4z6nexhzlyKV8Gd8y37KnbOfNRpFZ978U94gK4j?=
 =?us-ascii?Q?lHP4gNlPSGIfMIGwS5Zp77faW+3sEpgD/kyW1soM0AoRJZRKzaZswbCS9tuZ?=
 =?us-ascii?Q?+PFoN5z4Fd/kxiL3UeDiqBNyBWbHL7KVc2PiHaFyhkwBBO8fvn3jUvVsMz4j?=
 =?us-ascii?Q?3UPgFQn6jRfcRYsI2GvJdIOH2sGT46W2ueKK97woCsX5X1OOmUMhNJqooSwB?=
 =?us-ascii?Q?zwbrt/LPxtTEd2P07aOoR4p4SsdOW6tTcd/HyrTWS60snjYUpvn6bLhdm6gr?=
 =?us-ascii?Q?RVxPZOm4klHg7dp6HT0bON9Jx3Lyf2nCu7+TDlVpPuh2NniTMo37R5jKFovw?=
 =?us-ascii?Q?gpbHR5A2IHWTZULnE0HMlZidAiETW2VQ9StLYDDV07d+xEU9V/bCvlV8W0C7?=
 =?us-ascii?Q?Eh4/v/dcos9PetYOQdtDMJO1hP52oWyB9bGZPmOjYkoV+ZYSh1h8YgphcOCx?=
 =?us-ascii?Q?dWD2uwiWY49VVKcTkthZfEXxEStGT1PdqbnnncRVB5xr8r2dOUEljOU7qz8F?=
 =?us-ascii?Q?PNERO+3nXi1fcGIiRvQrjavEHIcdzoGCL8+oVccn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24be7272-7e77-4c16-e655-08dce3d772ea
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 18:16:06.7004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: THWxq5PR9Bdmlrdj49MMF/wEURihQxP1qI0xcxiLDPCDfKh8KG3MzufW+M1b8cBLMsFhJ9sJvUEpvepEUd9Vlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9194

Add PCIe support for i.MX8QXP MEK board.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Chagne from v1 to v2
- none
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


