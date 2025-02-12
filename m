Return-Path: <linux-kernel+bounces-510754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EACD0A32181
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9017F1646FF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E857207667;
	Wed, 12 Feb 2025 08:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JBsIUGg/"
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012005.outbound.protection.outlook.com [52.101.71.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EFA2063EE;
	Wed, 12 Feb 2025 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739350315; cv=fail; b=sCEd+LFuTpwGD5p5P+hixfqlMj9+XiTYxMf7LJA7We1UfN6XKw7fmjqbD66HuvhpbEnrukg2S/3cXiacJ2X54f4DI7/H9xd7AuBc6GKMrjszfqNvffqs0irAzgkB/Itzxmo4FOl0m2VPOVtGeHjDwT7IVvymG/4jRrgkCxWqXSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739350315; c=relaxed/simple;
	bh=yu7XuHtQqf32QnzPuYtDWFZvTkOuQ8RV4L2i8+8dt9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rMxBMu5+Z/YG9utohixu+qLpFJc4x/kfrfKcTPfB324sTKMREbBlXub7nf2tBBOS1f8oJJ7AC6hUCXKNLy4FUCimxWGGZte3ZGcDm05hEjzgFm3wo/uyeIpDDh4DixRtFgFm8imMae0nG+gs+OLcrdFTh+lDqcWrsZGS0T7G1ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JBsIUGg/; arc=fail smtp.client-ip=52.101.71.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ou4yiaErSluQ8nJsjb+v1hvPB5K8AhwkOKOniff7hDh0I88eKeiZDihgzTxzMaB8l996hJMWeQ1X2iAQjx0iLv9aY4cL3pp0CSgo0mvqQGAY5guKEP/GDjJnamhtNBVfYou3PKOD4v28l7hheSfk8keIjMHl2qdvaRsXBpbyF8F6TmF4RUF7X1IPhq8qT4WqeflsRVoX+q41NXvwJEEmSGIQIjfvn6NYr4Ws3KT9EZGLqeVA+3QJ3QsEODh8hu0OuJROlxn7qg8lE7Y+bnyPWRjPsOR6IrOxcEUcSVrG8ZsCxZjvKpdTkQBjp78msMM9fysAdVzlyTDJ7kUwCfgB1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxQY3CiQymUsGFABvT4yAvRTbg4v3j/ynbMc8OVHL5U=;
 b=rF+E9h5xuTckDwv+GbM7LBErHYeeNTQMqltlhiXSEeUHSUNLBnFvOcodfCqwEkUZ70m5xQwQ+TTj6Ke5Jz1BLRiPYGWgChjX8I29+iOdjtmNob1DFozmLdbSlIloonetAf5j6Y7i0/jF3u8fuGf3So3wfba5OZwnX9AyvsYsF+gw4A7UJiv06w+yjUH//SP1lF3SkrzoLUGGHoRHhy58x+Z4IS8rNNQs3bNBmTAl0QYfBDhjT0wlOpQYIqyceV7m17ZQ4STHCEiWVvCRziE0VB+kWQovQq5QM68FDdrN5YG9KBAGr7GVgW6rIdEqsQv7hGxcrlcXyoJ/ps+LzqvAvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxQY3CiQymUsGFABvT4yAvRTbg4v3j/ynbMc8OVHL5U=;
 b=JBsIUGg/6FXJZuOFsGItC9BKe+D0cwYsb/PZ6OQeK+cgRCTnROqCVk7ccrQQCU1CJaH7AnWXY+CRGF9GUwYyvDGDJZ8iwsfnVF9ccjJm8XSxVFmTYFndMZpngJp1wOfhrsQZ5oadrw2srD8AXue+FveH6MuqTmEZJ82uKBOS7Sde6/K80w+qt9oHKyQ74Q9tCX+R1TcNu6bO2xf7f42+4acNVN0H+dhjZE5C8l6N8hdIu33bCeTBAAtDcwIbqFiXLFqhmyYx8tO4RSt9GSTRccj9U0cMA/Qn6EARcYQxFMMYOQWfcwZM35gBKDdshcKNBNeMoof91FiL7/WRNwXpCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13)
 by AS4PR04MB9576.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Wed, 12 Feb
 2025 08:51:52 +0000
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6]) by AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6%4]) with mapi id 15.20.8445.013; Wed, 12 Feb 2025
 08:51:52 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: shawnguo@kernel.org,
	robh@kernel.org
Cc: s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	festevam@gmail.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	frank.li@nxp.com,
	aisheng.dong@nxp.com,
	daniel.baluta@gmail.com,
	laurentiu.mihalcea@nxp.com,
	shengjiu.wang@nxp.com,
	iuliana.prodan@nxp.com,
	a.fatoum@pengutronix.de,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v4 5/6] arm64: dts: imx8mp: Add fsl,dsp-ctrl property for dsp
Date: Wed, 12 Feb 2025 10:52:21 +0200
Message-ID: <20250212085222.107102-6-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212085222.107102-1-daniel.baluta@nxp.com>
References: <20250212085222.107102-1-daniel.baluta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0003.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::9) To AS8PR04MB8247.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8247:EE_|AS4PR04MB9576:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aef3e23-39d3-4cd0-a51e-08dd4b427e89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5MMAJueokykX3abqssVi0RNuu+y0XRqWH5P0lJMGwI/bxOjlYzT1B3EPiHeT?=
 =?us-ascii?Q?wj1gOTLSarADgpFfdGs0qUd890PkavRsM4KEsOgpIEMnhbSFw9GzsRSAU47I?=
 =?us-ascii?Q?7YkiEq+u5RdzemQkqVmCLA/LqSVK9lKXMAaqn8vxw+N1m3/wxPK9dImJGNmC?=
 =?us-ascii?Q?uZ0FkcMC4fNjq4omdWegn+m1Am4J5rIDenGWC0Go5O0IjjnW4FDGQuheKL2A?=
 =?us-ascii?Q?6il2V4UGK/EPql7VqTJauuL2XOVgrMutZJuPUms8o4UwrBVpNAPOCNsMzVLD?=
 =?us-ascii?Q?mhG6zG3wSeEuLfw2UdfMHRSkcUWnuvqmIG6BCSBPMfC1EwFEKKz+sLhGFo1d?=
 =?us-ascii?Q?neojRvRRRz1gnRSsitMA+ZT5lcnzrHGoRiphYoRktAldwHMY1pPeI1Vabd54?=
 =?us-ascii?Q?xXrUQVrv8K3dAMtLFpTXC98Ffs57NGUfmcem0lP3eBbcr4wmmWn1lcnkrFxz?=
 =?us-ascii?Q?jINUwjnm5l4vcQh2cHfcLcKrfOGAuAivqUxlmYAPXBEpktsMU4kDG7JbX4Lz?=
 =?us-ascii?Q?VTMSL2rJlrxlem3bsNakbSelD8Crp8xpQoD3BFC3bX4CYRbCZefYddZXtFG5?=
 =?us-ascii?Q?DL4KptBf2x2AZpj1f0XJTBJitr+tC2dv5Z3e7sYOgCLRe1r0p85zADK3oSv1?=
 =?us-ascii?Q?8XXzUQ7O8C76gReD1opdJcFIcLf/8SNQzQyvfoddEZ3RjshYqOKdHxf4dbvm?=
 =?us-ascii?Q?xhzeklgG/eH1hq8MWVc3AQdbgT+G9wKBoBwMkjnkbpN1ljJpDKfc6HE7U5Ec?=
 =?us-ascii?Q?PY8jywsoZo8zxy9JbiNRPCfVZQqvN7nWouMwySuf3su1HqHZ8C2ERGeiZmT1?=
 =?us-ascii?Q?P7pUi3vQE96wCQy+bhIRaeXKMybBhrz3i/AOHa6HMN9HRd5RIAyfSDxbbTvp?=
 =?us-ascii?Q?MUEUV4MYzti2FJV2yagQmUkcUoP+pRTmoeIXjiw+Dfg/XQgF6m6sogQqzPQi?=
 =?us-ascii?Q?zhCX+cKpF4XF9ENxy9yK3EOovH1az0FeZGnzISlS5GWx/OlW92LMK7zbDrRR?=
 =?us-ascii?Q?is402bRsYYEm/u+QtpqhwxdfvsaAgiR0x9NBAWGhSsgAfnofLcH8ds700B9Z?=
 =?us-ascii?Q?Equ6fgJYJfBiTM1L1A+RCge8I/2me72/a5tAPIn+U8GoeZv0refECrldqyB7?=
 =?us-ascii?Q?F7c4sB8whUfah4p/wvAz/XsHN4shMWpp+kwb51mrgb4aYS1TTBitNIyVDWUy?=
 =?us-ascii?Q?iRqFpAcZGSIo5NxqDMuE5mBjiZw/yBklYC14A6RzPlsdRt1Mmc0/vTqr5Ema?=
 =?us-ascii?Q?+SJ7pxxacfmpNH84V9A3RtuCH+3eYNnThfW/mBeHuODKRNQ6adlzAVIGRee1?=
 =?us-ascii?Q?Gh0wisyey9yfCjZ+tOwsGklT/h+fAw/09Zl/+7+aIxptxgKFmNav7E4Pt+ZD?=
 =?us-ascii?Q?R7N9F3qpaZJlMqGuCUEvJlos84ZHvf1fLDmdQNafMmHF4TXr4ojcviUnnT9A?=
 =?us-ascii?Q?96g5hMBhUDS6QYXg7DZsC1KdnZWA3HxS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8247.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KYZYWbXFDf2dJ/8G+h7JjDlUeyxgx8PN2OkQghdf7NZZIiiqBC1t7RgCx4Mk?=
 =?us-ascii?Q?Xi2y42FKXUSiQqltN4M5WvlE64E0QnqQ2JiixYBnsqpz5vCl16yxZqdq+K1O?=
 =?us-ascii?Q?PcCUHpx220x4Qj8T7L2Q35JNSXy3LNb0lHJlb7J3enNt1tmmAX6TsMZS3nbB?=
 =?us-ascii?Q?uBkn5FygmCjtxzywKPsylsUgZC6pN4WeeS3BoOjbFLhGJpinIq+jJFq948LH?=
 =?us-ascii?Q?7yHYKSTgFTWFPDCbRZzjmg8Z2k+ny/8L7P+zGuEFPCXvN5hTUQDozMO7W7nS?=
 =?us-ascii?Q?iiX7ODsHnfrsTFQhwsfx4eYxPprY85WJgqHThpW8SocMW+ZiCxbIxFMJTYyH?=
 =?us-ascii?Q?hgR1+8og8gdMiVPCcfO2T1qbhLE0wDvFkdgZFVSiiBYC01zFa2AVhcG6vl6f?=
 =?us-ascii?Q?Cb7LEe0xy0ZOLnMyvWoAowCjjx7mltVe/VH4roijp7OhYXS0m4jZut2wbSel?=
 =?us-ascii?Q?Ds/txvGMlJ3DY7By7fAyq/baSwNyzwq7Kb1xBJAkzjqwIIvHyF2PAt1xk/gY?=
 =?us-ascii?Q?8DHyryNj5XeHwsf6cI4XhdCMoiXkIL9w5nrwuSnfwPKciIbRSbk9/tPT0HDK?=
 =?us-ascii?Q?T508BF6efC+voW1VR1Lt+aGQtPs573u2sMbFU4Gkj7sXrktd7PZbYpmvYdVL?=
 =?us-ascii?Q?Sd/2qWDJX0V2zJcs6vVCZNUmd6xvaJdXEcvKe6hLZADnpn49GlVVQSiYD+8S?=
 =?us-ascii?Q?r7i6275TrojB8qLhCtmb6WzRKGuskDbbIvo71qMcreP5ejEUsCYVXGCaPAuz?=
 =?us-ascii?Q?G7674pc/3OdDBuzC13XkgdgYkYzvyp8bI1vLTd24SwCECpV5+rpQ2osi4DYv?=
 =?us-ascii?Q?/J6SfVnKpPGE4u8e2X6t6CTVwHGAk/iA0xxFYs5azZu9wMJnOtgni3oeomN5?=
 =?us-ascii?Q?uH1HWuNGIlO2SWrCYzduO/VAft5/QJ37y6O6nj1E2q1EDES7fct4jWed4zC5?=
 =?us-ascii?Q?ED+xe+DYNugPrGudsUO35xY/N1+0pZv6lfk8zq9lZMq/H/ngYeDSb266r/zw?=
 =?us-ascii?Q?DQ2l1Tm8ePK2ub35VkqpguSPSVZIpZmf2fEnjOxtLhBq+XVG0LlWGgePoGoV?=
 =?us-ascii?Q?mG4fwNIwVSEPeihr0xXZ7g43ZuTfhQOgIB8f47Xkc6vy6L17jLAqkc9/jHt4?=
 =?us-ascii?Q?FZx5huWzmT/mA3UkN/toOPQKn3lNhcoX+d1DT1G6KnALfn7cG6NNNgmkV5gB?=
 =?us-ascii?Q?g/R9qhaw2mb/Z9ay/g1D3gBmAL8vgFUD37sE21xZjejZNT63juSZWAf3v4Gn?=
 =?us-ascii?Q?VCXX78bykCK0E+BPPQFxDjcbQQQfYW65ljqkyl6Z0EjAMsjBbqCVpBVlaw+b?=
 =?us-ascii?Q?1lc/TndPKZpM0qU6++3lATOOgZCWMdj2vcgoo1qWflV6VNaPWVyZIUpdgRgy?=
 =?us-ascii?Q?ZADloUCRG8aTWQGLypq1BSfRPcxFrkAzaG8R3yRClQwtsPdiRoHS7pNRTIbP?=
 =?us-ascii?Q?vTl0Y9OWfmt+tj2L3UbVdvYhpZBWvl/pwdXQZ3EaG1x2fDv2yZHmEJ3ZV5/l?=
 =?us-ascii?Q?25tTqL6NA5fjx5LEVsD02rznUx/r5ucQtnkg2H7Hpysozg1nlEEzxkCSASFB?=
 =?us-ascii?Q?K0K+XXmvnfuIemMpJ4TiF7uzqQKmxpAxoNCl6N1P?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aef3e23-39d3-4cd0-a51e-08dd4b427e89
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8247.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 08:51:52.2548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3M2vpF6Wvi97EVRwY/H+R282BlE3Q87yXai+W+hdLrNbx1k8LNVkD9frpD2eWWAtm0X/ENaBVhvfgqRqG4QbXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9576

Audio block control contains a set of registers and some of them used for
DSP configuration.

Drivers (rproc, SOF) are using fsl,dsp-ctrl property in order to control
the DSP, particularly for Run/Stall bit.

Note that audio block control doesn't offer the functionality to reset
thte DSP. Reset is done via DAP interface.

Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 14cfbd228b45..46b33fbb9bd1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1609,7 +1609,7 @@ sdma2: dma-controller@30e10000 {
 			};
 
 			audio_blk_ctrl: clock-controller@30e20000 {
-				compatible = "fsl,imx8mp-audio-blk-ctrl";
+				compatible = "fsl,imx8mp-audio-blk-ctrl", "syscon";
 				reg = <0x30e20000 0x10000>;
 				#clock-cells = <1>;
 				#reset-cells = <1>;
@@ -2425,6 +2425,7 @@ dsp: dsp@3b6e8000 {
 			mboxes = <&mu2 0 0>, <&mu2 1 0>, <&mu2 3 0>;
 			firmware-name = "imx/dsp/hifi4.bin";
 			memory-region = <&dsp_reserved>;
+			fsl,dsp-ctrl = <&audio_blk_ctrl>;
 			status = "disabled";
 		};
 	};
-- 
2.43.0


