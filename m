Return-Path: <linux-kernel+bounces-344861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2170D98AF09
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFC031F23936
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5E41A4E60;
	Mon, 30 Sep 2024 21:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dO7vk5Ym"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011048.outbound.protection.outlook.com [52.101.65.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF031A3A80;
	Mon, 30 Sep 2024 21:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727731599; cv=fail; b=eaDEFjwCsqVXSO1SHLZLr9qzN0uRjEJ49rZNiy/hkCvhQNDeZTeQ4MxEqT54EqGMXzqf2kT7vOBB3OC66JM/tPYxLar81mSbXKrNZFZJuTEPSosdDsog170pXAd5iPWDff2S34Qu1LDJ/4M431Qm6y/tgWJyhPcgs9h8m88LCbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727731599; c=relaxed/simple;
	bh=BicUZn/HGTgAXuaDtHnmUnIuMSCG5Yct/V+pKFvjO2E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pc0QFtmmrxLTUeeHfc2lyPlV982/QYjtv6CfwMlG+beftB4L8sdUzrgKNeYGyXdjEiD0rBEcdjFLr3WLQM6ObMZ7sDNgpGvWQKJrZlRSeHpMjIc4upSfshXxlBWpe72OGu83bgw223u2W6B6Lw7OlqbANsanJ6/NZvc5yu67aeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dO7vk5Ym; arc=fail smtp.client-ip=52.101.65.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IEEQ/YzA4B/jByhvLD7x2lCrvK4c1dSq+Gp76kkAZ52+BiZQeOcbABfXn9ezzTmyuXRBbCRhYac/iofrf4fGdcCe0TBiD5QRNjzOxg2Pf/xk13snfooSUA/TSkFDg0Zk2kB7DGHl3p95ini6tNiF0GAR+0mWgFVzBAflGXM4Tbczy8q/y2XAR0cvwFb0yDus9bOogA80P0uCndCDwgbDjw1/tTcW6ya8VqE5vfdXUUlZIMpKZnx0DJmz5rkikBkFwytd13u1Uhmt5g3ys3YHehzVzpyK3Rc1pzEP9IaAoLlJbMX7lmjtbrKSauOh5aUPc87DlUu+vcqOohogigNKgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZB5I+4S+SSkVpLQXdrhF5uIKMz118p1yGci+ztJEcQ=;
 b=nuf9hjJxmIzaDvWDdeOrdD56OLovQJQ+4jULD80ko/US38HBgbJ2RPvz2An7/ygHGYgJwYk9J9c1vYTisTd8Lon+kABdOdBL86yYR0x6KQYX5MnC7k+tmV6Hysp4CcE5Q6m7dHP0ICSkbZhLTBD/OKs/dxSi/rji0s4fiM+UkX89q/fc9Eq82vRkgNoHv9MPqejl2pWSczn01vomLgNtQ6VFGBvG3WbkXE4E5Enn5nsshrKiluo4GpivRqqP0E0Ou1C4R1bCpe7jdPPE+1P90Q2t+fgIamSFqt76qqMH6j1xNERx/ggic/QERhFbunQeg9/pj+c27LFoiBZgqLwX9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZB5I+4S+SSkVpLQXdrhF5uIKMz118p1yGci+ztJEcQ=;
 b=dO7vk5YmN0cSe/1XRZzZ8TI+F2lMe8birKa3G7IHKELBwACK+UKk3wmqydHFJRL+uQVO1oIzCYE/lvoSvOzc6483n9+fYALUGsBYxCcrtbccdPZC19mToXPEU9jz8MkvzD7LZT2kt/okjl3dB4+ejJYMsuC8sWWuJr0USbBXIXmMJYML67GuakvIu/lmFg+MFWEywe+rHF3uL9H8H7xvDD5pOzhPPaEBmHwJdbM0CKxCvwxMVB+x3PX/B2dvfUAc/Kc0OFG8as4n5Fy+hnkOkJkIYDeXLJcNDqxP8JOvj6JSWcoqwsXRP0iGddVraP1KMuxNDPdQorcYX8PTH0VS0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB7601.eurprd04.prod.outlook.com (2603:10a6:20b:285::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 21:26:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 21:26:35 +0000
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
Subject: [PATCH 5/6] arm64: dts: imx8qxp-mek: add usbotg1 and related node
Date: Mon, 30 Sep 2024 17:26:02 -0400
Message-Id: <20240930212604.118756-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930212604.118756-1-Frank.Li@nxp.com>
References: <20240930212604.118756-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0335.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB7601:EE_
X-MS-Office365-Filtering-Correlation-Id: 71c5ee55-112f-41e8-5844-08dce1968fec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kFFqdtsMu0FKkcBgou0aNEiLo5E6a+CXhso6OaukWEk4wp59HiPc7QXhPHf3?=
 =?us-ascii?Q?Cm+nQ98x+6ur6Mw6UwWnAOT8LJJZwjs33x0wzOlOyV358HDgEW59lVxy8vDy?=
 =?us-ascii?Q?gAPS5jymF+2flR/5EBLB7If1CsOxodibuoKClYIbRtavXVDrCTgo3c4GMn5C?=
 =?us-ascii?Q?6JUjy8LGb+8d5S3i3Xms2LjpEKLAn9uMuOOKRLDhH4gEmtQ2x3z2gjJOfdfW?=
 =?us-ascii?Q?3j+DavigzWYLfHftPzLbPu+Az0o0wfDtX9hqTtaIPlbsNElYGC1LMzN6ZFYR?=
 =?us-ascii?Q?DZhz20ifXap0wV4SOfSylUWNdkM881kxZKARE4zMz1Zw4Ix5whn68+Rsg1Cn?=
 =?us-ascii?Q?/QX6fkpNSL0QkQR7sVsV9/2adYH7QPdy4Lg/+sa/obbY7kDHmGMCoeTtQBfr?=
 =?us-ascii?Q?DGEU1fqqYOm1W7PJa1P4jHALlWy8zhOZk8NmbpPv/fykBDgHVWyFlac5cqdQ?=
 =?us-ascii?Q?LIcfeimvQDIkhJdtcQA6HZRDUGeZQzKppIBy0R3Xt4yQnsfqVI40sDSVfdhw?=
 =?us-ascii?Q?TeeP3S5a6uegUzllVBoFL0SUNJbmWLD5D8aza9F2TEFrDyXZCc2TAc4U8BpF?=
 =?us-ascii?Q?jKsqXvqbuNmSyHaWJvJTY8v9Q6zgVhPYE++lTYeIpgAe/k/loUEVGQw56fc0?=
 =?us-ascii?Q?y6rg4tqO6+HkyY2OOAJiLdR4msXZ52OTQ5iQFKvCDEAk4/x7yFPAEBPXBvMQ?=
 =?us-ascii?Q?vaJiFOUxMda+g2W2e9w7my8qA1/e2Yu68K2cY7/Yg311zA1ttjCcwugLbilb?=
 =?us-ascii?Q?eBy5KCCVKFIukla9iLO4QvzoqCPFq1mhdgRHh2UqiOcp1VaQNqz2ZpU6MGSA?=
 =?us-ascii?Q?r3BC0l9nSzQjRXRJ0hWSR3P2q6u4NppIQu03/jnKIztAIifod+Oouyti4TCB?=
 =?us-ascii?Q?f4iPNW28m625lu5NA/NaeElje7viefIFCWVZFVben5utM/wQe1zAlHVzQvIw?=
 =?us-ascii?Q?cozDl+QudMyOPBbqKeT8I3YqER4kKRX2IaEG/KT70Y0mUvi2vOFzSRAfQrBh?=
 =?us-ascii?Q?AL7uYWgPOHzCIljbREnMcgtD2wyalgI6Yp0+f8TOeCE0xS+y1+bTpa8yT/3n?=
 =?us-ascii?Q?gROafBqytRDVr27gZgvJ2eAQj4ppfPxqao+3bTp8gTNS1lOwYQA9R1dtBDDP?=
 =?us-ascii?Q?y5fUnoqRD6SMVg92XR0p3j5nGz0tNrzq4IYff6/UJTE8IL5NEkwjVjKpCEbG?=
 =?us-ascii?Q?bPsGVfiujGJUzKBfQlDO4XxFkk8Dw/gRYtKktcWDW4nFrHnr/oCGYbk2iSC/?=
 =?us-ascii?Q?eqf7rw2/XRLiS10cCB+KZgNKYwe7qRIREPhe8t3af1ca2EkpKnWdSGsVvia5?=
 =?us-ascii?Q?Ntxt/hVFf8gbGmgv1Hwff4IX5MojmJiNWZSoMjxaP+p9YpTwT2y09jd++ehQ?=
 =?us-ascii?Q?50/3BAdz2UJLlZS1/3Itxh0LUH2AUS3SNFP/DxaF3XXVxgwGmBNSNQibdmkI?=
 =?us-ascii?Q?jTnnHWz9yE4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q1DnoY+KkxBJMVfMN4qQUKKFPxI/sgRpOOD+qp0/nkLzVruAG0ssSEssphMa?=
 =?us-ascii?Q?Gls+RCFQcd9fRONCRLdrOxrZbEDpuwZguv0/GREIfLEQwu3x9MQ1G09r5gTs?=
 =?us-ascii?Q?hN82ufOIDV68byM6nriDMZFmuMS5ApkwQF1dFSxYrbQsW7XEnNgKoKSo6ekg?=
 =?us-ascii?Q?UsFKt+5X8c5Oq5I/JK8F46d8AXR43lwVpOBbjOwwSJ7+8LWZi/K/JPOQ/VlO?=
 =?us-ascii?Q?BFXuMBp9EKbLlYF9b7nicK2Wfs3R5ehQNulBSDsieVMZpsqr9zftXewXy1E1?=
 =?us-ascii?Q?Pb3DAyZKmJvOyXLxuIB9eqidSced+hFzTLZ8Sruu3mePnaatJoKvXYtlWGub?=
 =?us-ascii?Q?PJVjTScqXqlKZPBv0mhbj4VDAX5LuzMKTJCdmhT9ihXqe3QVix5IXLoQNsko?=
 =?us-ascii?Q?Y8ln1qSb2EXAYkWtrDNLcEr52Eip8Y/U6r5eURsrQx7Qa0hpQwG9RpIK8+kH?=
 =?us-ascii?Q?9cZcasOWyztv8PmCfRtTJQOv5n7Tdy8SshlRHP0Gn+sOOkrWaSBwRSqRvHqn?=
 =?us-ascii?Q?EulwywmE6VLUZu84Pzzj8ligPkUbHaY04zYny/KwvXaI+aJ7tc5v/0KyoU0N?=
 =?us-ascii?Q?/jwh277Kj0EkXp8k0aL+/FsJrSf1Y3Gm2sZmx824brqOJSZ1XxFCIj56J1WK?=
 =?us-ascii?Q?8wk2vF/ZWxSR8zwQxzNZ9faP5+On3XW4LQujiqA1O6KcRJP3ChnucJDz8+GH?=
 =?us-ascii?Q?Nk+VHOW/Al2zqazuQmaQT8HLi7BmpzL3vPO0YRF5CRviYMSKvG+KpdbZid1M?=
 =?us-ascii?Q?dvk8FFny26edHG/5odcqRAD4nWnrmOZvlnKF1upgXudGT6t3wiwQ6Ds+M7V/?=
 =?us-ascii?Q?MjNeNgqD9YS7PTu5IG/piqpRzgz1wIbLkh1FlQydZCFYXnlzrjpBBnShPQGN?=
 =?us-ascii?Q?pzUfzXy7LMIgSBO1X94Oa8U7igGoj3qPF0s8W5rPqY3EgxD9zSe85MPvhdZZ?=
 =?us-ascii?Q?VoJzhfvfgYHx82LaNWP/MXbsH4aJ6s9NMEZigL9A8xAnbPHJJ8/pzeEOuTjb?=
 =?us-ascii?Q?AUsfdaEsLvyr33qejtub0A/tVhSa/ZmHE9j1OvgJrSO4AtYKFeoJeRwc9hOH?=
 =?us-ascii?Q?DV5jIjlmjmG55LM/TGVMM+dKjPA780Ct5vJKjfiaVg/fsw7d8IdM4DdMbIhs?=
 =?us-ascii?Q?gsfusC3qBjvzGbAeTyMBBg9CvdWXCgonzxfnLZSPH86JkfkWbS6Qziu8AE+9?=
 =?us-ascii?Q?XGlMiL28Q2MgowU8gok2yGJFxcoBP1WwHmMjuSe61FmRGSTd2rz99ZPH2Du6?=
 =?us-ascii?Q?HhAvQmFdR9xGyJMD/TdQcsykytK3NQhMlGC7RiIXDi7vKJJU3zoRfXw5Wx/R?=
 =?us-ascii?Q?j5db/ZXn3y/ooEYmplc/ouxeV8tFpnl1SQSIYNFfxXqyHOt95q0jxD/YibaW?=
 =?us-ascii?Q?6jDgE8U2CZBrkdt+Kiv8hR0lJdEpncilOynsNl524H4K6ghknPvLsTrN4l3I?=
 =?us-ascii?Q?j9ZD7i0uW/UExxz1fEzFQSIm+MtZQjD41c7XFBsNobw3LCRx2IqDGAKLImXb?=
 =?us-ascii?Q?mtwcYHYgnYF6Z0HkZBenlf47U+PHHyEcv3xgS8b4ANpLgiUS/Y0rXwGXtdKy?=
 =?us-ascii?Q?AUDTVEJIQZy2Vg0VXxw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c5ee55-112f-41e8-5844-08dce1968fec
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 21:26:35.8577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bmDxRPJjHaZGSi8oxDa5SWdGmd1tkZyA9do7B8KWcHR+nUCCfikP2R5abqd2RmBXYSibRM5tOa7ocl7xCMoiZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7601

Add usbotg1, usbphy1 and related regulator nodes.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 621ad618aee7b..bbb94adfd64f0 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -76,6 +76,15 @@ reg_can_stby: regulator-can-stby {
 		vin-supply = <&reg_can_en>;
 	};
 
+	reg_usb_otg1_vbus: regulator-usbotg1-vbus {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "usb_otg1_vbus";
+		gpio = <&pca9557_b 2 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	sound-bt-sco {
 		compatible = "simple-audio-card";
 		simple-audio-card,bitclock-inversion;
@@ -518,6 +527,20 @@ &usb3_phy {
 	status = "okay";
 };
 
+&usbphy1 {
+	status = "okay";
+};
+
+&usbotg1 {
+	adp-disable;
+	hnp-disable;
+	srp-disable;
+	disable-over-current;
+	power-active-high;
+	vbus-supply = <&reg_usb_otg1_vbus>;
+	status = "okay";
+};
+
 &usbotg3 {
 	status = "okay";
 };
-- 
2.34.1


