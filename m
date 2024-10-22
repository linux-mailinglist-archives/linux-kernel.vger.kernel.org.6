Return-Path: <linux-kernel+bounces-375619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B009A983F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56153282B9A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 05:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CB713D251;
	Tue, 22 Oct 2024 05:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="X4Okmezg"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2079.outbound.protection.outlook.com [40.107.103.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0490D13BAEE;
	Tue, 22 Oct 2024 05:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729574380; cv=fail; b=VtMbDTZw/Fj4Djj2TSzHZlAOp5/u7IETN7V3ZH59WBPkXvzV3UAbTowaRoQWfyXvwrbfXRTXDsuTeIgVoQE3WMX21vtbvkJSoxqut/uEnv0oqje7SicS8mkA8Md3RpLULZ9d866CQ0mrfW7d5dm54rJvnX0sSv2WwYp/fFgOW4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729574380; c=relaxed/simple;
	bh=Te3L1RQ5DewJWd1Z3e2P5wkvR0V2l67blCbbLb58RjQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VjJ/gFU0MKNo6LK5LcF4xelb+mrLquSjmBnNPVoaoYKE8UrpsWSRTiYeuLJTRgr6OwSRkQC3TBYevxw4BzVdMju9+KOm+4sn1tl48skoFWZvw05ZW3nfJ2eVq60bf4ESnuACs+cF5Rofq88nsYGqYasG2Zc895ojwPZcB0y0vZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=X4Okmezg; arc=fail smtp.client-ip=40.107.103.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfNNKMLyNa+D8OXxRyo2gvC9QK9x25QtigU4LQw2eV/GQsc5jM9NdNoiEXazbflJL2Nr4C9gZU7glSfwjo6jW+NQYFhjlErP/xUovNRQw+Qg+bpkDrXgXtwP+xCEuhtTA8pp4Zioegiy9MiOBuiUzBpEj7VB5jHwz3KV1+ZmFIzC2WvsavlbYtI5A0FVrBtkAkfTPXajU5Z3aCx19uxSrzJ8OcwfpQXr1xKSONkMDO7KCw1c12lrVEMmUJs45Vy7cjZ9c+38czX5R03gkrLlZ5v7g6uRGyzxSerjmlKeEtwxO+gew/BxWo1/33+wuY6CcekevgPeeD5h2LUlnn7kpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVyCKPSHYrkFONMOlHz3pUEMSfbfPA4T4nlZqPZLYXA=;
 b=wImKm7cQ2s/77bz4Gopzre9hcYvAppbUTIwATpdAr+aUa9DKHXeSV63mYr6gep+7wMe3re1dct2mDiHXa+iSYBJkkiH71ufra1icRnE8zf5741UctxISZVGcAIxReI3wIG74Dc9ZuGXxzfg3msFTPHzAgH1xTeKoz2xGYCWrTLZZt+Tbutki4QmA2HcCnYH2aACVy84RXLntmjgyWX9gFIg9sBCtUNI64kCP6xacAVawiPnOO/7pyOtRjdk7r1eu0rnqzzlJalQD8wd7WKR1K2F3/IwLruuccc/RccdwbHxkg201p0wt5CoorG0rAnXmOdlLF1T9MsE80nwp37H2qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVyCKPSHYrkFONMOlHz3pUEMSfbfPA4T4nlZqPZLYXA=;
 b=X4Okmezgfa76ZOaLT80Hq+6r8fLjFfUcWFBQG+gxLInpn58j9P7A8K4Cl4uSfb2A8hQMkoRDxvYy3ICa0coT9e50fgqvw+Df6uC5qXwfZPhpX7Ns46KInpsWczMNBmPQmmhuWTQp9RBQPeXMNTOI3TF/19clqLF1Pdd85ZZkI+iezd8j8PzGy83KRId6y1l3nnwlzd0G8h3Cx257XR6ekOXvIzciSweoA0mvZKHmnzT8M0J9afH1UWfVuWNfD8pnOQpuTcf+YdZWAp+OhxWqud8jgpnW9PACsGu535QSk19iZHQreMltu7G0mNe5gnVoPXUJuL+uMz5JI92/z8+/6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by AM7PR04MB6853.eurprd04.prod.outlook.com (2603:10a6:20b:107::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 22 Oct
 2024 05:19:36 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%6]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 05:19:36 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com
Subject: [PATCH v2 3/3] arm64: dts: imx8ulp-evk: Add spdif sound card support
Date: Tue, 22 Oct 2024 13:29:19 +0800
Message-Id: <20241022052919.1946074-4-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241022052919.1946074-1-shengjiu.wang@nxp.com>
References: <20241022052919.1946074-1-shengjiu.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To VI1PR04MB7055.eurprd04.prod.outlook.com
 (2603:10a6:800:123::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|AM7PR04MB6853:EE_
X-MS-Office365-Filtering-Correlation-Id: 716478fd-21ea-47c2-b907-08dcf2591e8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3wThhAl4poG/Go6wt9TWpGApxErifRVAPf9xGL1WxLMTgBRI4+rjCYaaM0H7?=
 =?us-ascii?Q?atvapoPQk2tM5Q+jD4tT/FDYKP3l1FwvQsWQtL0pZv/BKZ7UlKkNqGE9/GMu?=
 =?us-ascii?Q?4ygKzdcR08Wae2Fm0VHJuBN8F8W2g/g0HewPXLrbg+fmTpG/u/xofm6dvi4o?=
 =?us-ascii?Q?qH9h2VS+l5mlTUa+B365MSz2LcicgyACjlNc5asr6wClJykztpBQiaXU046J?=
 =?us-ascii?Q?Zm8UX6y83g0YsN81ndovzo+ummG16gGQUzMX8YdYp09eDt9AXIrSjf0/uqDo?=
 =?us-ascii?Q?NKl5X2Vl+6ClC7g1rPVMxmJd93n4wv6etmNZlhBZ/OvcBVGaMbR1+NaNHD3/?=
 =?us-ascii?Q?WV7sAiyAW5hc4Gq6vdyOh+z9Dv21tAxGPKnpgGndMXiRHJhv1RuasTMCDzsW?=
 =?us-ascii?Q?R7tpwUd+FuuAh4xuTv5W7Qkwg6cgGAFQUYTT0MC0JQjTlcVDqNoUEhtusM8t?=
 =?us-ascii?Q?AbGcAoM22kSfvn+2dZtzY7su+WM4xJ61GA0B74m0Vc/wLWSTivqS0G4o+him?=
 =?us-ascii?Q?ECJ76aJKeC8CstiVCu++oODQGSS9yS+AgeoSgrEioVjXA0R7IvzodYl2pdMk?=
 =?us-ascii?Q?NgItA8LFcTnhutE+vRZ19BtPXvX0Jl7KVZoSu6J2nVmJMlWprKxr2h7jx7d4?=
 =?us-ascii?Q?o+VcVrfmi1fDv9owVc6ZTv9vx0WSzH85RY8v9hEvlOLt+FC4NMA2ypHUgorX?=
 =?us-ascii?Q?Kch8mGKoz8O9+wufmGaJRDsYd4F1EoPqU4luYzOLVhoVryBytxC33zjihSuE?=
 =?us-ascii?Q?Vv8d1JKsnXAt0EcX0+20lQ3ghyQf+ddBvsEBxc0iLjQx4esiUOxEFFAkdEkg?=
 =?us-ascii?Q?EPKy60/sA5y4U1sllh7Tg017bPk8txihH+O656vqI5y2h2C7MqH1KHKeAkbA?=
 =?us-ascii?Q?PqBboTbwTDxRATTN8WgplYGMXsVyslnetYFwZoLNR/3wjS9jM6vbLUGoBwM8?=
 =?us-ascii?Q?3HGLaL5SiFSKVd0Qw5LZIVrVJme4PwYrVsZPVj44zKOwaw8fs/SB/yeoDFSs?=
 =?us-ascii?Q?/o3Yekx7YbgHAPUCt5U6FZQJTc9bICDh/OgaKIOYDGaD9eTfMnFIHG1VUAQE?=
 =?us-ascii?Q?EvdERU3A8fn/DxWdLvayWWLafIWn3RyEIS9Ys1S2X4ui0vmE5/1XswQnjh4j?=
 =?us-ascii?Q?NJp7n85AEz2M7GanXfIdGsONmS+N/vI9KurEgMEdApgkMMXPbJqvuaQQIIvA?=
 =?us-ascii?Q?493VllPIjRFMqh1MypqvPxYmTx+DSvy0OF6+cjPQxHDP2YZQ9Pf5FISS4McJ?=
 =?us-ascii?Q?ZIoCfBnos8/Z4keP+oP+p4317PFJIKcIKmWtzHKvTJjM33lRRgTPC1Fh/xHO?=
 =?us-ascii?Q?dBzSlOUhRaelZR2sdkaLnQ1v6o5mRuOEj3fKfewxyGPbGyyLrvBSb7n69X7o?=
 =?us-ascii?Q?Vr1kn+3kh+ECoqmggTQM3xyI03cc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?funrG5nK3U8G0ePLdbQ83cW5JNvZ2DmJQ+a4C/gDazgrhSGmEDIP/ZJskRpL?=
 =?us-ascii?Q?TX1atlULHi2a5kO4wgp26P9VjJtiSjxhbDtP6ZTWhYqWaru5aSQvFtDIzGUn?=
 =?us-ascii?Q?7QpGVDydzku9qCroaukUtI+F0/gPgqjH4/LzhIbIUkz4IeWI1HakUrspy+bH?=
 =?us-ascii?Q?2YdO1NVNC5RWj+wm/ty4A2Rd7eg3EZT/3hW1xh1VEqxprtc8XbLydtMH4od/?=
 =?us-ascii?Q?Xq+FpRmSiSr2eJuMUR4G6kzdZFNRzTKvClD6Oq3fdbmq0aWn8AjSSYUXDdzf?=
 =?us-ascii?Q?pwQopMq48aYfKtkGS075vV9ymK/LK9TbLMMuNNu/iqMA9XiFcBG0G0B+hxFc?=
 =?us-ascii?Q?8TIRdfRcxtddb3Efyo0X95SrOIsiF6qZJvAaH3z5dmBiTHy9LN6qP2UNpNlK?=
 =?us-ascii?Q?e9ianQB2CU4deY2JT3fbS2sr2GsQSBC7GPiebDVCUmstkX6V4ygZ6yDsvnyn?=
 =?us-ascii?Q?XeG1ffPqu/tU0pUFT4/UPAgkg0ekoUNoouTsjjTRHAw6MJ7zdWokakBg0y83?=
 =?us-ascii?Q?ue4ZD4ChcQtbrCDRqrCG1DmCF7sew6alJFkzSnyKztj1pI/PfAcgIT51LnKL?=
 =?us-ascii?Q?SqJ67JwUv78caju/udz7IFcKmJQaQK+5BqUZnwgEUHgg0oT2rvGG/lKvTWoq?=
 =?us-ascii?Q?g6UrXz15DzMewuQdawnpejH3qYRzZL1YMrKWxA6i9WFetktOfnq/H+lHJjBk?=
 =?us-ascii?Q?BUzbYVsXORDLOtzOgiq8CHeBNGjOGeI/ChlQyFfgX+54LAsaQ5FckVpPFv4W?=
 =?us-ascii?Q?gX4GmKrFRqteVkg98nCSvhf2yH5IH3P57GlnUzGb0Te0EsKG0J/ARmXVgZhz?=
 =?us-ascii?Q?e5qpdMVFIbOtI7fZIVabuZ/1EkYzWvctGhoImVL5ogxlxl0iOCZ6rtmeen58?=
 =?us-ascii?Q?oE6vrDvG1UHKQ6JHshvnclS46vjLJ5bsCj4CnOyxNg4i7hUYEKs6ZNknmCRE?=
 =?us-ascii?Q?AkmfYhJ+7J+xSJWiH2w0wyHKBNqJVCNLZDG2B3OMW2tMTMQcFDwckMi6JLzy?=
 =?us-ascii?Q?/071fqLEeq0qfXRk1W8xxv+MPdEIVFMWg9UrSkGdtIqefaWg5y2i98CNEaer?=
 =?us-ascii?Q?2XJVPaiM95zVgyfv0ZdowLvayXMEKEfFLg6UxLceF+gwe+rlA/yY46OubB85?=
 =?us-ascii?Q?RH50NybJyyQ/6QoHdn5xXW8vkyznmnAHxAMCm9/YVfZTZPrQKI8sQOEqe5Xk?=
 =?us-ascii?Q?N0TUX7MlMLmnZ0PZk128VOngAEREhpKFpixUa/LkrYjkbXYw4ihVRxZdVmU7?=
 =?us-ascii?Q?U9TtOb5iPXs1MRnrUCgOKs4Op4KL2a3+bgS00143H7sGw3IV2hOO5yfhZSEb?=
 =?us-ascii?Q?6s0/nFnfJ7D/Y1yu7lz+5DCwXS5rymz9ypWkdyg4w7ClKC7jZEXG00BpSGzG?=
 =?us-ascii?Q?2T9o6hH0lSaRPqK74Z9kWS5yn8Frs9yx2fzeS9UG5zFUEdyHxL1xhi0Qv82k?=
 =?us-ascii?Q?KuL32rtR0SA6zdkqD1n/etxtHNSx8k5o7VXkESPR1tGjU25MgawrEopNoCPA?=
 =?us-ascii?Q?4/GrIYXna/VosRVXdXEebQq+Y50AU80QpSdeqIfBAQUx9NViT8nkW+5uPF2H?=
 =?us-ascii?Q?+JWRL9D8Le7ivzUTQdrIJtpm5QG5RONMaPD9lU0A?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 716478fd-21ea-47c2-b907-08dcf2591e8b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7055.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 05:19:36.2171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nVkq/a0BHs8R/6jYHcq/gnl1fpd0fpPjLvQRFENWaakHGxgRVNqVac667OTOdE9nIgq0b40tWL9kLP2K8GZE3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6853

Add spdif sound card support, configure the pinmux.

This sound card supports only playback sound
through HDMI interface.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
index 7d6d332fa779..290a49bea2f7 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
@@ -107,6 +107,18 @@ simple-audio-card,codec {
 			sound-dai = <&bt_sco_codec 1>;
 		};
 	};
+
+	sound-spdif {
+		compatible = "fsl,imx-audio-spdif";
+		model = "imx-spdif";
+		audio-cpu = <&spdif>;
+		audio-codec = <&spdif_out>;
+	};
+
+	spdif_out: spdif-out {
+		compatible = "linux,spdif-dit";
+		#sound-dai-cells = <0>;
+	};
 };
 
 &cm33 {
@@ -187,6 +199,15 @@ &sai5 {
 	status = "okay";
 };
 
+&spdif {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_spdif>;
+	pinctrl-1 = <&pinctrl_spdif>;
+	assigned-clocks = <&cgc2 IMX8ULP_CLK_SPDIF_SEL>;
+	assigned-clock-parents = <&cgc1 IMX8ULP_CLK_SPLL3_PFD1_DIV1>;
+	status = "okay";
+};
+
 &usbotg1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usb1>;
@@ -325,6 +346,12 @@ MX8ULP_PAD_PTF24__I2S5_RXD3	0x43
 		>;
 	};
 
+	pinctrl_spdif: spdifgrp {
+		fsl,pins = <
+			MX8ULP_PAD_PTF25__SPDIF_OUT1    0x43
+		>;
+	};
+
 	pinctrl_typec1: typec1grp {
 		fsl,pins = <
 			MX8ULP_PAD_PTF3__PTF3           0x3
-- 
2.34.1


