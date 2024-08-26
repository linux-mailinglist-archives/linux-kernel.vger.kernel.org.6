Return-Path: <linux-kernel+bounces-302194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C53B595FAFF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C801284E97
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B259519AD5C;
	Mon, 26 Aug 2024 20:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VbmDwyPo"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012063.outbound.protection.outlook.com [52.101.66.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8593199EA4;
	Mon, 26 Aug 2024 20:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724705635; cv=fail; b=Q1shDlmseETyoElgtx07EARSBRV8yjrmyrHggUkZvKm3OByH3xACPtLi11YkRFI+0R9b/25qwDzBXKKDowUX/UTw4sZommYWiteDylvjWoK2w9Ce/qvkUuKgSwaH5PnHce5hSD1GGqSbogqSmNqrtO98d9gOpie6LDTKdBLFzvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724705635; c=relaxed/simple;
	bh=9859Zj7j3dvKIFWbdrI6k95xziCKvXmbfENk621qLMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GkxK1c+Xsm1wRfsKx5X8jlMLIX05biOMWO2vfyin/STovQiRsq0DifEF6T64EmbNi3LGmIQWGbjSh9ZyUNvEg1tab85fNRWLhBAXH/VLjgEt0f8Ti2OFKjqwVcP5cKCwg/dvyqaI+c8//UPojYFVn96HWXoCiW1vIwyN/fR3JsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VbmDwyPo; arc=fail smtp.client-ip=52.101.66.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FLNwKts1UD4n1hm6fhQ52NRRscL5ECpMa7FjOrZmM1VkM+hDFLzDfz8XNGy+cL/EJbPZeAs9fGbF7wQ65zRdrzg/DSg+s9yapW8oeH7tyx+8g9UY/0BsJ0ExMJ/GXTIe1f3NhQq2szOsZCZcGNzybIZ6F8DumItaxH2rhwDEpNSgKo9YtZdfnD034rVntiMbSfaVkhUnHeVgSrSy4xM4QRbxqFoGmGxvN2AzijEb76L4azyfjLAOxGsUJes05uByFJtpTAWlpZioPYbccbi7fsYyFCJ7skPOlbn1cL7XbEr9ZDiSYxnJOg/638iRor/DEbenG3ri5mw3Y++jb7/EQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x70BgxwZyrRaKDvDfEhw8nbjPwQanM1oDdbKvdcdQlU=;
 b=HLoCJ1+iZyKSAjW+O9o/ge+AVAnKZ46vEulJrOzAa3F1z50s2p7vhbPWeunP6L89f8p186pPJNL5MKeJQj9KP/sip1LGd0aaa9seiWgAjrh4sCQgElqf4NZt6tKDRbITxPkBSGulCDuAPvRKYDIT5Swvk+x8r2GbXj2tHPbnaZSF3fGW+jE404Ky/C2aG6HbhV9ZfEDt0cZ+soh6hUw6c6vDZWWyoNhLm0kU6914pAV3M6x45TGcLdSiSSVVTQaJsR2hF+PciS1igzTmWZsZ5kqB3X/gkHCp3/N6F4KV/M2jFILfbu5iRVRF/i+uYYzfCNtyZct/ETHImkc628Gdtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x70BgxwZyrRaKDvDfEhw8nbjPwQanM1oDdbKvdcdQlU=;
 b=VbmDwyPokYQ01C2XlhyB01Fo5lLrSfXRFu8bF4QapZBnKgwEJezQn4NtUvJZRUqP32YA4AR7ncjrzv4+JbV+oo9JdrN7d3KpgynBBtHkluVSohO3g76FIgcpswcRYaRLbBofTuoUJ3p4weyXPX/mCrwPkS964wV789ZFjEzk/zqPKGctmYTyiSrYwxrw3AM10m9WVkITdyGWaQvercnjf5L8MH0Tx5mrP13mad3epn0O6nFa0G128WQoaDCjY9uOVrBMUrfZU/0olaQHu8UvGT8B24jDgphWWURLz3RR/ev2hl1vtd34iuEdTpO953ZLSl72ey63wHHESabcF35vlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10681.eurprd04.prod.outlook.com (2603:10a6:150:226::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 20:53:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7875.019; Mon, 26 Aug 2024
 20:53:50 +0000
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
Subject: [PATCH 2/3] arm64: dts: imx93-11x11-evk: add flexcan support
Date: Mon, 26 Aug 2024 16:53:33 -0400
Message-Id: <20240826205334.975272-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826205334.975272-1-Frank.Li@nxp.com>
References: <20240826205334.975272-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10681:EE_
X-MS-Office365-Filtering-Correlation-Id: 79ee578b-2389-45ca-d640-08dcc611301f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ITEF5GpN3p20xJ0bx0Mxov6BvyMNVWDL4sMvd9FD9iNNoHdrdaMsuN4SkOQg?=
 =?us-ascii?Q?+DN/IileKs34JQHgakmP/jErn57Ov40IUBwqs8bfS3DztHvH+SRoKxnbjnps?=
 =?us-ascii?Q?MvyJe1Z7m/H66n0c/gGf6kKg4Vx31+5Wyl6FjEP/B+BeDW9ePSl/qcoXZX+n?=
 =?us-ascii?Q?KaqOIetQJeC6MGuo/uLsVUfMyH+6l2wz3E05jYzRvv4d7PrUwCj2oQ0hrPbY?=
 =?us-ascii?Q?4i7sPX9h/XQyoYP5FI8SACXtQpx4cpFz8aFJedcEIvJfo4NX7cwnPwOSzsIA?=
 =?us-ascii?Q?b/8FcxsWQyuoEEvUcLM9ARIRvw7mwwOZl2NDaUxiFKKHg7tkvPWCYl6XSP4u?=
 =?us-ascii?Q?PhEgvEVm5oZY8owGh2VBOyw61jHMPR0r/XdE6yXAdQIkPNLArEi5NaR+K+sZ?=
 =?us-ascii?Q?b+gKtR1MCdn07YG3C+ZZBXvhUXcbPQAEg+synj9GnN+ltWC/RVIfGlY2atIb?=
 =?us-ascii?Q?30k1QvPqJ/CTBoPK7ChNN+e2vRavgN0/O39fBjQicVGRcNHTL8RpZPIo0Hwq?=
 =?us-ascii?Q?5tEJq9LQptSx5jKCvVmT6F624aiDUOypkAXI/cEtsAQmmY7l/wd+oNOYjw5w?=
 =?us-ascii?Q?Kppk2VPiA6Xfg/czwIL5pFE6d0Sb63J7chnUX1w/F80dr0kFTvvUJV9hJ8Cw?=
 =?us-ascii?Q?lqNnueaIOdS51VgM33EYQKf1EeCpX/vr2ARtjFyPZAlN6tmTfn3R1yoKhTou?=
 =?us-ascii?Q?3jMgsjrjOiJSB7XadkSRJ6QgsTtuYPck7Smj/5DvCKSs7yhkg61npxuioAbi?=
 =?us-ascii?Q?GHTnKc2st8wQQuLyxdzb9ACKXiV4o79JcwmY9LLOJtJ9GiPaIhVPVefdGg3z?=
 =?us-ascii?Q?cl8xJvRme63QFfX6A3+syj1MsQghXaSm12jc4ZyesCkXvkBpTk5LWakjnNyy?=
 =?us-ascii?Q?AArnj0cloEt6kAkal2SbUW7la6h7v6F2NHd42OCxWaK6TGtbHjMK3LKuPQl0?=
 =?us-ascii?Q?YNNzNMF0opMHEJYjegQGy8pZEMw3sWVfPoqN3BEhAxw1QwHV7NGSBot8Hn3u?=
 =?us-ascii?Q?/v4Ef9wER0F6UeSXP+B4VfotD5H44KuYOmBNmWlxSsGVRLKvOgdEnfE8jN99?=
 =?us-ascii?Q?8Llbli8fx/uSUu2P4I18ug+1l8PTC0/4uA5uplj7XPopuvA00phshuquDB8C?=
 =?us-ascii?Q?+7sV4P/1sokE8x21O6dOl+Ks8/Z1gq6pmb+KiZVfBnllKTxud8RhiRR8irfk?=
 =?us-ascii?Q?vc5nWRhE5Kmx96a6WA83SlP0aTeGkeYrCo2CDf8Ah0a0HSkpoRnMtMt1obIk?=
 =?us-ascii?Q?7/LFq5ofp0zsXYB875ee4HX4dKBtSLBXKwgPNG1w65PFIihRhL9hshHWv5HO?=
 =?us-ascii?Q?wrDIxc8DcOhAno+WhbUXIhWfCS3v3G8mkBHXc7yCduWkmQN5EcjANSUQhpHD?=
 =?us-ascii?Q?seJ159aDickmxzDEeFgYr4wo5QVvOn1CIinezvHlwgDxTvLAhjupcOJUBaTV?=
 =?us-ascii?Q?hMhQCaEi4Kc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TV/kbHNgh1I/28DNty7dfJUf2+N1qRejPCj9CJ5NW1HlpjfwpkKmwmRIndEf?=
 =?us-ascii?Q?I8OHfuGKIPq7g2kfW7NLz6e9LOzhiTr4w7dsHDsb4IkHfujehbLVl6p/G7Gh?=
 =?us-ascii?Q?plGgvxf1fG6vhpfsn9hc1nv9cQGUWf/Kh+q3n1YXaIkdGGOGA0yeS8cPQH38?=
 =?us-ascii?Q?j2p/hW5IykF3SHGf4NrPQF0ZQPDretQIfcjTu/9KuDqXK+3ioV5fVhJuc3/N?=
 =?us-ascii?Q?/97691fQA7oOu5X13JxOAiL70bhA3mUvY50vhIjlDyFCjq/MvLzFiMcla7fS?=
 =?us-ascii?Q?0f26NeAaHBKd398AtZGBfkEh00u760vhMDFWt7JiVFyQqf5Crj3uz6+Foa3Z?=
 =?us-ascii?Q?6VV5n+mlRxMIz7s0HulqXKV3VxRWciQghcRtznyrkFS3Yv6jj7nnbt1EdQJz?=
 =?us-ascii?Q?Q8xvOMKCu3CgYzrjXkwKAymCOrp/6gG+GlRi8e1inzyCeZXv52caHD4IgbQN?=
 =?us-ascii?Q?0U0Fn/Hd8LEcT87xcLdlBwpNqrjLyTgxVN6z6taoZDSOUbV8KeN6XB+qPmiM?=
 =?us-ascii?Q?RNoZrqQi3I6Hy0YHY5gzLhQKDIQX8irajmpERqORgxW0/f1j6jg3NW+XhdGo?=
 =?us-ascii?Q?eU77NoNPWJLm9WnfkjTbcqd8amhcCblmWpH4mTTcM985AW+roS7kY88zOpVj?=
 =?us-ascii?Q?mdZnzsQqlb5LKhRHR3nIin0VeUQ0uOt0IGeldUxwpfd+stM/JMM0juFRP0Iw?=
 =?us-ascii?Q?CtznZ2FlBP2nsVZDBHaRgTGAJ8ENlZeEqeOj8Vni8wJaxbqEr0f8bXeZfqha?=
 =?us-ascii?Q?H98Kl6ecnTRJ1OqxlZgBAQQrJk8Lkr7fstG1xBpg6EH0I5kPgsBlimxCbSNT?=
 =?us-ascii?Q?rKZjRxO8adaPkfOeZefz//1/zuxw+q7ghtBbkb2D17kwYANN2cpTYFmy65uu?=
 =?us-ascii?Q?nf3w1rbDePYXD85JW7fAdKLBqAgF57WJz7bWyyBMeYFQqfHhnuG15US6/TXz?=
 =?us-ascii?Q?h7mGKauTGvU27eImrdgquOztO6twkvezexkZBMzLQBF1V5SvIkX7GiNL8R1q?=
 =?us-ascii?Q?Gj1DdqlkhPLHpPb8Vfi1Jhwzs+SSa20WJjbOLYpIQN6+CsKtfRD2bJ9ETGt/?=
 =?us-ascii?Q?2SVPSbL09hjjtCMGvO2VIQFNjk9Yk/XKnjqChwVOkQBAfexnMHcxSVDtK6Kj?=
 =?us-ascii?Q?0ZF7XkMzRQ2QjcOXe+HXJIkn/MXfzUNU42aV6zHzS+afQNUbxKTqbsxSDvVk?=
 =?us-ascii?Q?ouOl2l/0F+3GMgcPnnzUsU2faH+yIGiEBFiv3S93WPH3P4m2rH4ksIwGYz7x?=
 =?us-ascii?Q?ZASQOmIO9B3bGeGDtgCrJhYMb+F+Bblp40u5b4VbRse9wEp42FRfXlBC6hCc?=
 =?us-ascii?Q?6flPC461we64T9mGVSGMf2pFUMh4UGPoHn8iZu22n5YM96l81tizGi5fHlFh?=
 =?us-ascii?Q?KcfLccP3njnGVoYaC56t26AGmxcLsX5ZvR+mVaJNULAXnn+WC2Mst4Z3QYyY?=
 =?us-ascii?Q?LQdb8LJeLUTc77+Sgck2QFjceeng94A1YesZKwoChokQ+X9sF+6K2SUzh/K/?=
 =?us-ascii?Q?iA/mc9NXidt3UvbZH3tD3bOSFouOawKAabiOGI+bICmazYDIN+0/9rBseglh?=
 =?us-ascii?Q?u2Reet2DPLrY80d5yLXUMoGAXzEIDKIPr+bXuXOx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79ee578b-2389-45ca-d640-08dcc611301f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 20:53:50.5170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lYi0WHJYk2TLWWNXQMZ7gvloJp/8gORezJpBBxKVrghvLnlgPvPTJ2JUgTvL5YU6qOZ+wsmUaELxKPVRomKT0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10681

From: Haibo Chen <haibo.chen@nxp.com>

Add flexcan support.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Reviewed-by: Jun Li <jun.li@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 7629b6b44aa43..f20d281531734 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -69,6 +69,14 @@ reg_vref_1v8: regulator-adc-vref {
 		regulator-max-microvolt = <1800000>;
 	};
 
+	reg_can2_standby: regulator-can2-standby {
+		compatible = "regulator-fixed";
+		regulator-name = "can2-stby";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&adp5585gpio 6 GPIO_ACTIVE_LOW>;
+	};
+
 	reg_usdhc2_vmmc: regulator-usdhc2 {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -196,6 +204,13 @@ ethphy2: ethernet-phy@2 {
 	};
 };
 
+&flexcan2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+	xceiver-supply = <&reg_can2_standby>;
+	status = "okay";
+};
+
 &lpi2c1 {
 	clock-frequency = <400000>;
 	pinctrl-names = "default";
@@ -602,6 +617,13 @@ MX93_PAD_ENET2_TX_CTL__GPIO4_IO20               0x51e
 		>;
 	};
 
+	pinctrl_flexcan2: flexcan2grp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO25__CAN2_TX	0x139e
+			MX93_PAD_GPIO_IO27__CAN2_RX	0x139e
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX93_PAD_UART1_RXD__LPUART1_RX			0x31e
-- 
2.34.1


