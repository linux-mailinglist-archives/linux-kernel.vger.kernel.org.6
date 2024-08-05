Return-Path: <linux-kernel+bounces-275308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED885948314
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 22:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59E17B22549
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 20:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A9616EB70;
	Mon,  5 Aug 2024 20:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DaL+Iz28"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010026.outbound.protection.outlook.com [52.101.69.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D550716D9B9;
	Mon,  5 Aug 2024 20:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722888881; cv=fail; b=sfm39jr2IqLt0Rxy/JQXo/8SKyapN9K5s0jFqY8zuZCsTDLwdVp/jLHw/tXhwJE4tJ0BstYabSMvlqwsVfTjevJZ/kqglqPDghlZjGNAks+IwlIF7Dn8SHHvAd1hj6GNp62+ynvUCLQPgg0iLvhgpHO/wnkZns0hGxtnpfy4bGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722888881; c=relaxed/simple;
	bh=9KVj9vN0VWHV0v5SYiqCaqIYlLShlsO/WLSDjqA7xho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XcM++ilylBbEiTQoUtrBPebtrs5aNoBd+KemaJ03jmfTk/DqCwCgNj6NBNnlgxl6io1zIoXmzxgfxxZ+lEYp2UPeGbM71sDFnd0b2yoqKXIX+hsty9Xwp9l6aJoQAfqB1oh5WuEfsAExFQSeUPyDV+fsJ/1T3JKhJcINEDPyDjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DaL+Iz28; arc=fail smtp.client-ip=52.101.69.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yg5eBWNoLuMxEuI/+UQlKgIIx3q1vhh9Oml3eLkO4St6L6aW+901Kr0bJYfQCLUTEgJul2CaZrq+rkmU/CA2mGWZVONB83QNNDjd0GJvBoO3nIwpeT7eA14UptsZKLRvEjFj1sTVyytZA6Nd+b6R5L1hdPJCHMYS1/D2H1F922c1OFXxSx+umlYOcZ3nxaRosbhsowgiTDPCnTdJShfbaiF7oIUGAseJuMG5lm9bQ/IfxiKEYlBqgspqDS+yl4zEwYQUXNv5kd6BBJcII+i4NKVt5bDrgbEMr9D0BzICVWx3WV+bYK60doeF9fSp6w9Mzwb7PwayD1a/RCkRQ4Elxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bt2ZpU/CQHvfIO3Xf5e0hZvbnIFeNYgLjZbK/lyINX4=;
 b=cKiTCxKlWFBtMwK0RRT7wNekiwKr31OSjRUyQHVZEA0ogwFI5NMfhgMHInujBtM3BxCbL5FytrD058j+MHzSbnvG2rwt1oQ6J8C8V2dDc7MCClrhUJtPPGk5+5RkPDIKUKNqADEYKpuNh5KxfB0nt0HjkJvM2RwSsqDww/8q8KwZQt+8UHoQl36St/AW5KYr31J4qWMORm22IFWx3UYPYZoBQBovNkJx5KyV6r4VYfhM4WrTxGm6DEkHAreV775AxapmrCehjMxRcJl3qgJFEk6N78QXWRi3cxORNMBZjIKfbytWDlTcnmhETy4IQ57MLdnus8bSjM54+qkKAMbw9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bt2ZpU/CQHvfIO3Xf5e0hZvbnIFeNYgLjZbK/lyINX4=;
 b=DaL+Iz28DWHEI8wGnubvGfJelbfkX923lXTMJFK36zgeK3tqIjVpc46hY2imCrqSMRVYfOs5tF3oIOO7ZI2d09EWaSy8lIN1/ba4zHVQY16xELH4VEyGs6bQUaki+rokn8uzN+yknGrBeCYpYEOnwUhm6n9ZYBSokZWlubYBPt1Bgep8EifprfsqWCKmivvffNvpr02wqVuy3UiK7G2nF3Ox+FskMZKX+jxlMK2lNATafuwvicWYWt9HNehSWTwPZzR/pgMXach2WMrdSSd/3Z6K/bip9o2GgG4G2NSGqxUaCs2WW3NUkgKH0HTa2jyFHsaTFHvqxcd/LvwEwdgV+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10319.eurprd04.prod.outlook.com (2603:10a6:800:231::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 20:14:36 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 20:14:35 +0000
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
Subject: [PATCH 2/2] arm64: dts: imx95: add flexcan[1..5] support
Date: Mon,  5 Aug 2024 16:14:16 -0400
Message-Id: <20240805201416.2974996-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240805201416.2974996-1-Frank.Li@nxp.com>
References: <20240805201416.2974996-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:a03:217::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10319:EE_
X-MS-Office365-Filtering-Correlation-Id: 5660f1ee-0bb7-4195-eeb8-08dcb58b39fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jNVWJ8cuGnVjJEQGdZN8vWq0FtUvGPnsVQB3YNE3L1b5FX7kw2axu2/oplKG?=
 =?us-ascii?Q?x4kO+YH6bO7X8BteWZZSOczuOpt7eOwQXES3Qe9//CBau/QVjHp+YuRBphwG?=
 =?us-ascii?Q?vTHgt7y49bo6fWeBCpQv8wYf0Yv91RfvMcf2DsuxPrRvtcIuxoPRMfG9ic+C?=
 =?us-ascii?Q?OqHJ5NN+oZV8ZH7Ag/SyFc74qpz8uBq195mEDGQy6Y8USpUS/wwmXeannQfK?=
 =?us-ascii?Q?B0E067QXMt1kF5O+aUTDI8RaP2nUdZeEcqNyIXsJfN/9f28OchLjTVDhH7wB?=
 =?us-ascii?Q?Ahq0DUOPXKRLI2ov8pOoFT81r0Lnbx7fxFxOko3XTW5pPE/VXU6XjYTV54B9?=
 =?us-ascii?Q?a90wG41HAbptyZ4v0jKcRAjOSjN2zvqTX5T7HaiPoEhyv6wKMAUwaCJ8EKZA?=
 =?us-ascii?Q?tTT/H2VAYKr94LG5ui53yu0zUJZ9LbzpCbpwKhcHvaNdpSIT19ufBtpyf5AT?=
 =?us-ascii?Q?5LTqExxrd6oKV2sNY+frzEihrApSR3n9ueOEIhntO8UATs68Tfc6ERBcDgyT?=
 =?us-ascii?Q?/lLSPZksHKpYuG7ZH7KLidqKFdBNx+6S4yaD6Yn83w344OZ+OBce/K8umf2Q?=
 =?us-ascii?Q?0bonqpw/QCX2qQ4SSD08ePIA6v82y5R7uYDYcagesArV5J/o8tpST5adrK7D?=
 =?us-ascii?Q?0ffea7axSuG39/K/ZAQh1672dGynB5gT9g+3aJU91nKKyO/9dnOZ9AK6Ml1b?=
 =?us-ascii?Q?PmI7zo5amSomk7d9rrlYca7+GXfx7pDeK9RW+s3xnD46NhvcKhz5a8bHh6Ai?=
 =?us-ascii?Q?1ceq+KzeguJya/t61DfRwNpKsNRywdaUO7FdZen18mCEhncG74aMGliJGqTi?=
 =?us-ascii?Q?f09tWnIIJCPTE1zYZTH+aQrXJazFlujTiENFXDFLz2w5y+8IAqSw+j849cKJ?=
 =?us-ascii?Q?3t5pwSc6LOAVECs0yIBJGlzZNeLxFaix43DZuEqn2+UTe+9KRgWrYRzNrky4?=
 =?us-ascii?Q?XD+/v/F4YP+YHsrI3XQF473achIP+bsbZ5is3ZThTRrTXuOrXxtDuPDTDv9N?=
 =?us-ascii?Q?fs/ZOePwNMnCGoWZe7NKi5NNZo6iZD3V1fmbtuq2eOhqecuokUtcaWVy4iG5?=
 =?us-ascii?Q?rZQJYcbu3pxz6M97T0TB+FQu0kfswzxelyuan0EQ18pKVy11+RSVvWPAZHgp?=
 =?us-ascii?Q?V0h5ICz/K79sWZ/z3fLJ9dQ8ss5mgGPM2D5uYnNGcquBtYRjCBHQlV2ok/05?=
 =?us-ascii?Q?tZTCxGK4sSRz0lxUjRrJDVrG+1Rq/LiOtqi3YWvFh63aQseveFwaGZh0HKKS?=
 =?us-ascii?Q?YfAtZmqqt40rd7wycl0Ly3QYaTMbw0+wyAIMn1TbzeVS45WflsshZARHpLgR?=
 =?us-ascii?Q?jz/Bas7j27yRAYgMQpEeflNFxklKW7cizXMryf+uc4Woc3caqb1QDtV6R+Nk?=
 =?us-ascii?Q?QrAW/UwCPwXVqOjL5+6Evy6T0dX5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HXN71tnW7SeAGX+yFPUQFjdkWaJgfFBX96zCZFTjaEBzEM2CW/bdbWl3oi2D?=
 =?us-ascii?Q?fhNz0R06rk/OtVzSd0h1K8qdlODN5AZSjH4D+IWtp2ndwR/S6k6mOkd65Yk7?=
 =?us-ascii?Q?GKq3aBRtA2dYqZKV46fdlB0xOxrc3+/ky6vTsQtYtl7ZBgAFZetZs2CKyCL9?=
 =?us-ascii?Q?ykgKmZPVmw9Dw6DJfg7mM9Offkt60hts7A0H6wOg0UpBby//1vHuh5xf5K80?=
 =?us-ascii?Q?aZlyqxqh51YS6XeAqrq7mj2d6SYUXIde3kofyd61hOAOr4YMjQNomgJXGpnH?=
 =?us-ascii?Q?U4j54VR1s9HwLjXt3o+NcBPuXyOSIulfbicRGzCwnitOf0szPFiy341T9IPE?=
 =?us-ascii?Q?/Z9Llt/CyUoP11BrJX+JB0hkV2MPOMreTL0SLLP7TExYU1JcnihGu1Ipx6QM?=
 =?us-ascii?Q?z4p9PHoFIUO7wOUDw0Yoocac21Vav2eZ/Qk8kTKSeXFXuRj0IrqJ9xhwn+jQ?=
 =?us-ascii?Q?B8DskvUun2uY7Ndyn8ki/k7ag9hmUtfYnZPoABttKLMkrzMhd3i9p1fopyDk?=
 =?us-ascii?Q?r4Fveovu0/BD9E8otKXuz2RPnqXbQet4czFCwVRyu8u1PUyEPNQ+9LygS4Qg?=
 =?us-ascii?Q?dUwJXT2bu/iP/d5zSGx3KfYqClFehQvR1e0SQu+TkXcFgaFjEijne8qTRNan?=
 =?us-ascii?Q?xWu3i6kKZv/1xo6b3ArNRobTb64ox0RwNCso2FoKaC+t8/Qyq1depJi1R3FP?=
 =?us-ascii?Q?AKo9PixcF52ts55CaW/6ZoH/Z4yMUW5ChwIxlu3YJxtZD4Lg+favG1ks8qLq?=
 =?us-ascii?Q?QwPFS8auztiveP5mZN/L8vAlUW13rJXuiwkOz1HxZgKpdLqkmr/SMmuOZL40?=
 =?us-ascii?Q?hJjTO7Wx5LQuEDxJPn2E5opO2SgZpP0+F8GEO9BzOiPLGRv56GyBQsNWjcgX?=
 =?us-ascii?Q?CbQGBcbcnyiu76KkhUJAVG79LBb3JjDSp9mLhkryDWqLH4PJQ7Lx6lrVd5OS?=
 =?us-ascii?Q?83zhzDpl+2Vm+PeVxJmDelDDodoEEjTnWZDLatWUH9Mjis4nfBKCOtHHj8xR?=
 =?us-ascii?Q?QanCT5UwVEmEbnZdIcaX44y9t0sdpP6v6z6QQBaMUvUQzDRCBZyusakVocJD?=
 =?us-ascii?Q?MoLeQkghUIOCTsWIHY6WitEeRxFuWYnUq0lrmJr/hW/OUIAp14ZCi8mw7iLq?=
 =?us-ascii?Q?g38rsiSL980YbnT/TOWu1IPBZaDCpcmUlIq10RPw/LUd6z2fv88dh1JnB2AD?=
 =?us-ascii?Q?+MwfwVUNNs+SD1vgMFRwah+Dl8I+CshbaXWy5MGX9HwVYz6Rl6NdCk1bVLRx?=
 =?us-ascii?Q?RLUwC/UpBf2XNzoi/zWDo4Dh9KXj7Ib1SQMdv93M6KovfIQJinm1Y6vegXAE?=
 =?us-ascii?Q?QIx7a0dAqZbHbfhCj6tYYP4/x9ywqpWqmNbjVY4Vymm6avUMoTAMlL8+NrMV?=
 =?us-ascii?Q?AAzEOa2tFZVz3isxWRDzsdGZl/y6lpT/9H6vem5ph+07uLAgbP90O5gzPuI5?=
 =?us-ascii?Q?9LVuq9wnSirfaKpgg0En8T9uKpI79AqYZzfuSdcVvgXl6W5rDAIwXOrHDJg7?=
 =?us-ascii?Q?qNjaJvr3pSIkQsB9gHQMj7jXp/882h7AepS89Y9LKeuftZSD9yKSMk+Mjsqa?=
 =?us-ascii?Q?gOTZEPwkzT3AY+VQewelSGXrJugASzvueEXtPCOF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5660f1ee-0bb7-4195-eeb8-08dcb58b39fe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 20:14:35.9142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vMyuf3zh3MswlVyd459ygaJ5NqUCehhxzT/w4liUpa5xju0vqloPCa6IgC8gVl4n+9JxIG+Q+rBNS2TphOrPjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10319

From: Haibo Chen <haibo.chen@nxp.com>

Add the flexcan[1..5] nodes for imx95.

Reviewed-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
- CHECK_DTB warning should be fixed in linux-can-next tree.
['fsl,imx95-flexcan'] is too short
https://lore.kernel.org/imx/20240805-succinct-didactic-vicugna-e5449a-mkl@pengutronix.de/
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 70 ++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index d25465c947822..7c01cfa318e7f 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -713,6 +713,34 @@ lpuart6: serial@425a0000 {
 				status = "disabled";
 			};
 
+			flexcan2: can@425b0000 {
+				compatible = "fsl,imx95-flexcan";
+				reg = <0x425b0000 0x10000>;
+				interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>,
+					 <&scmi_clk IMX95_CLK_CAN2>;
+				clock-names = "ipg", "per";
+				assigned-clocks = <&scmi_clk IMX95_CLK_CAN2>;
+				assigned-clock-parents = <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
+				assigned-clock-rates = <40000000>;
+				fsl,clk-source = /bits/ 8 <0>;
+				status = "disabled";
+			};
+
+			flexcan3: can@42600000 {
+				compatible = "fsl,imx95-flexcan";
+				reg = <0x42600000 0x10000>;
+				interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>,
+					 <&scmi_clk IMX95_CLK_CAN3>;
+				clock-names = "ipg", "per";
+				assigned-clocks = <&scmi_clk IMX95_CLK_CAN3>;
+				assigned-clock-parents = <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
+				assigned-clock-rates = <40000000>;
+				fsl,clk-source = /bits/ 8 <0>;
+				status = "disabled";
+			};
+
 			flexspi1: spi@425e0000 {
 				compatible = "nxp,imx8mm-fspi";
 				reg = <0x425e0000 0x10000>, <0x28000000 0x8000000>;
@@ -931,6 +959,34 @@ mu8: mailbox@42730000 {
 				#mbox-cells = <2>;
 				status = "disabled";
 			};
+
+			flexcan4: can@427c0000 {
+				compatible = "fsl,imx95-flexcan";
+				reg = <0x427c0000 0x10000>;
+				interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>,
+					 <&scmi_clk IMX95_CLK_CAN4>;
+				clock-names = "ipg", "per";
+				assigned-clocks = <&scmi_clk IMX95_CLK_CAN4>;
+				assigned-clock-parents = <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
+				assigned-clock-rates = <40000000>;
+				fsl,clk-source = /bits/ 8 <0>;
+				status = "disabled";
+			};
+
+			flexcan5: can@427d0000 {
+				compatible = "fsl,imx95-flexcan";
+				reg = <0x427d0000 0x10000>;
+				interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>,
+					 <&scmi_clk IMX95_CLK_CAN5>;
+				clock-names = "ipg", "per";
+				assigned-clocks = <&scmi_clk IMX95_CLK_CAN5>;
+				assigned-clock-parents = <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
+				assigned-clock-rates = <40000000>;
+				fsl,clk-source = /bits/ 8 <0>;
+				status = "disabled";
+			};
 		};
 
 		aips3: bus@42800000 {
@@ -1205,6 +1261,20 @@ lpuart2: serial@44390000 {
 				status = "disabled";
 			};
 
+			flexcan1: can@443a0000 {
+				compatible = "fsl,imx95-flexcan";
+				reg = <0x443a0000 0x10000>;
+				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_BUSAON>,
+					 <&scmi_clk IMX95_CLK_CAN1>;
+				clock-names = "ipg", "per";
+				assigned-clocks = <&scmi_clk IMX95_CLK_CAN1>;
+				assigned-clock-parents = <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
+				assigned-clock-rates = <40000000>;
+				fsl,clk-source = /bits/ 8 <0>;
+				status = "disabled";
+			};
+
 			sai1: sai@443b0000 {
 				compatible = "fsl,imx95-sai";
 				reg = <0x443b0000 0x10000>;
-- 
2.34.1


