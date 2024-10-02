Return-Path: <linux-kernel+bounces-348232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5411098E466
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1593B282E1C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA0B217331;
	Wed,  2 Oct 2024 20:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="k/BwoJTd"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010052.outbound.protection.outlook.com [52.101.69.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D730D217312;
	Wed,  2 Oct 2024 20:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727902100; cv=fail; b=rx7V1mutRmOAhbCpmDkog8VXTGRKNLxM3raVpTGSzU74yg7URb/FuICy5cZKP+dh90bV+9lVU2PEJcuJ9QYBLNukWUkD1911Fmm203jOvIcbLEC2xQCTUSCbgiCwpGQMxqE5us7Y9UJGnxe4aCkkyl+11ufXomzSyDDfUw6rHI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727902100; c=relaxed/simple;
	bh=OqHPofx4YtRsPP5wkQme02rGCdVBVWQ/+2Bp1lv4uC0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HZ5DoL4ec0T88hE4/zm3WatUWeOMdtVy6gkhMmFKtJsdjlWvDX/K6Xx+Fc2bRManGe9mtA9kuokZG/HLsBwOKf8UNBhuDX+Rx2l6FwpxW55i6cfcH2apyjJ8q753Nw2rRcpTv4BvOCeh0N659HG8hYmKPALGy42DCx10fr98I+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=k/BwoJTd; arc=fail smtp.client-ip=52.101.69.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZ/7pwPrDy0+5UWaKbGzhWr0qQNgmJWu+gVnirBV+iStVxsiGw0cA86jokh1AaD7+dn/ChvhDfBOeihiXaCiDCubHxnu+G1PEOKds7YEUfP2xSHRa4vXL11p0+og8EiHgRM2Ibj6rRxptlOMC24pTrnt6kbNyOufOMRMVU+njQB0PsJFTbtpXxMf9epP248YXePK3Z+HU3mBjjofbzLWYb1MET0J9/++V6CHxYELuvG0p95nUgvxYkISKytEWg4ewrEx5uWG/jEQFFi7nYMWU3kwukUxI1FmGLFo3Gs7/lT6LgPtIMr0AcNBL72Ft8QSfFs4DfI6etcPDT9sEN1M4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkaMU690Wr870eGwA73ZRI7FupnpdplJlYe30oJZEuA=;
 b=WKQQOBwdzLbspm06rZ8MXEbFZkMmp/zSoyhieVEXN6wVFFrEEt4RLVLrpkPTelUBtECjYoKcjl9lhlSb3MJOYufcgj5QeNppjQX/+uSEZ/aaRjHKiyX4Gj4kmV1xx7gDVpWh3+5XcuHDqeeyd6uEuV6T/zV7HXPspOYR8TjmMcCSHu9PToS/qo6OCpxUQxQyMxdNki6E1ulRgo93B3dL3VC/pq3rxzou5Rn1ng+otCqNAqdwGNnRpj7oOi3GsEEbYg7WyJGo/nE6oQMUIxoUELgM1WnTRD+v6ze6ZcqGcG3B14EddjuYgdEXnf9BGVOZcUFR1n5gM2+ni+qE6FHK1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkaMU690Wr870eGwA73ZRI7FupnpdplJlYe30oJZEuA=;
 b=k/BwoJTdICTPNfOBQVN6j1nELKgSKKTopXI1eOC7dCtX6NsUfTBQ5pEwTQuaXTwneFDiaFLI16AGpaAj73xq3kFn9S10jZ4m8RsgSM2tqiRSUn7mFblnGBStyc+RkjVXO8c6y5Ku5A//1NvLq1IPr3mIn4lUGIPUqzuW/khs6l9PfRlv7wfgF2I7BPA0ZyU8l7SLpjt+L/PZylYlsVpNMFadAp24kVTk/dN7UDwfSHahaxmVvQF/FZ84ci4skaDK1Qv7OHsu0nxFD+gVS+PnSzRXvRMIaUKTdVGC2IRPuNx2ekHc6esL/jW2PFONHT9x08AGOt0oVO/dAk8Is/DG1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9454.eurprd04.prod.outlook.com (2603:10a6:20b:4d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 20:48:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 20:48:13 +0000
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
Subject: [PATCH 2/4] arm64: dts: imx8dxl-evk: Add PCIe support
Date: Wed,  2 Oct 2024 16:47:46 -0400
Message-Id: <20241002204750.597337-2-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7763b5f7-f20a-4bae-6f44-08dce3238874
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YN3wfaJY1EMwOdn7BBrNos152uPGzAR50Wczn659Ya65syyX6vOzSTmCsmRY?=
 =?us-ascii?Q?UFBu7RgcvIVia3adz8HmgBonXrPagCNj4a8xxtdq4UpdmRJhtl19QmcUavxb?=
 =?us-ascii?Q?oLqbxUffhAGHVw/m0ZnQHSdZJDVhN3e+ljYNs12s0KYXZDs2ht4xN566A9UE?=
 =?us-ascii?Q?Bl0j+DSG2k5ZXS3WXI1SljmeyM2M1/Kw1MWxfQvMFK1uoq4KvvjV7OKZDgXt?=
 =?us-ascii?Q?t4ZyvLx3k5tN480DigRuAfVlYxF4auHVcaZCt63dCSsi1bhEpOHuSHR6odIu?=
 =?us-ascii?Q?Ei7BVlkJiILtRFdOtwCJbmf25uHaOuxUeWRp+XpNj9l+QmrW1Epr+OCweyjO?=
 =?us-ascii?Q?vTXxBwZAFADjGlmYrXqLj/p03E7A+dFZI48MT3pyd0enWhCFOY6uLZtqMZrc?=
 =?us-ascii?Q?/cOenc9N73SQoSU4rUPo9bc3sc07D7FQpjkb8gzSIHTYUM5q75tQqchhzbsY?=
 =?us-ascii?Q?9WjrpLlgK80iv/TVaaSyHVrvdkXaBZZzRKFcuWnDYYQmA8Sgmz4ElM8URSBJ?=
 =?us-ascii?Q?8kKyjZZp+pZOFHfUmv/nIuu3xRaaJEO+y18OVHe/w2uP1yn3/ItvJzBhEA72?=
 =?us-ascii?Q?I8l9exjlUedQvZqAiM+PZr9zmyV+/lOR1blkCGZIgsgchGp8nab6kHU5CZZ6?=
 =?us-ascii?Q?7Ge62lowapyps72m6kJO5kVoLeJ1Negc3i391dz1bELnF3Q6gO3nz6EEkGXq?=
 =?us-ascii?Q?Unc2uGLA3lwDWZBOZdnL3Dh60GGEqVw6OS4s54f6RcijyeWTK1W5fdMypWKf?=
 =?us-ascii?Q?jN5OQA4UZ/C9DykovaIf661beg1FWN1CH6urA+IiSu6FKC7vM9fGndxbC36f?=
 =?us-ascii?Q?H86Hrgm22NcpDxxV7Bzlqaqo54dakjsHF91QshGnxw95jNMhE6w8t9kt5t11?=
 =?us-ascii?Q?1udEUK5IRl1AJ6/dFdSb+/A/cghj+NTuYcV385/ed6r+0JkIQaObkpaN+38O?=
 =?us-ascii?Q?aZyyZcvO4fvb5OQWfg/xfgiGcAXhR4z/HtyJs8cYOYAMWNFR410hDmjbb4Qe?=
 =?us-ascii?Q?HDRW9f4UaBx9h93V+laNTdq+TnCeb2kbNSTZwWa6ozKTCOw1oYCPTXs4GbjI?=
 =?us-ascii?Q?fNtb9E3dWhtuCmYQXEqqT27vl34Nky5M+2h980EYmvotUkF7HLMp6po6vpTR?=
 =?us-ascii?Q?7kqQjd12EASrkvJBagTep4okisH9/LPiMEJHA8xQHIqX46fRtIjh2J9cIzqE?=
 =?us-ascii?Q?lX3EJ8EhWp4oVyEDM5TF1U/j1Nbf7N6hqID7nkQLR8PXY17/xpxvbTPndsZk?=
 =?us-ascii?Q?7AY1cHdcwjoH9SG6avvGsofqHpmbWKAh7AzDMjZI+XsY8aKp5/c3wZsHrwJc?=
 =?us-ascii?Q?3VG1Y//Vz5Cfrs+Kk3B+vNXxFdlXvmwfxB0DajFuNFYxw2k7B6J8Bnz+CwpE?=
 =?us-ascii?Q?XkBTwak=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jyEShZ1bplxjd/+uIsiQMQOwJ84vZyFVcahAxLeFLHNZr1rjQLnsWKZe5rTq?=
 =?us-ascii?Q?Qep8KdcZrmXCf75ioHUb1v5aM5I693kWcaN5AMhTCYE5I1KBrFAIc3FyI0Vu?=
 =?us-ascii?Q?E17uLZBHVcPLzwGmR8kCQlcbI6vurVzWmnSR8eTEBsOuJzwdrKsiATq1HxL7?=
 =?us-ascii?Q?6sKMcJb0WwzenIKERVUevgLbQTJrgioylWsygoZHumUmCxBmy+4089NGLgom?=
 =?us-ascii?Q?MZ/tvIH3mDN//jaHXWKeeDOeeQTxMiScqiCXHPtRy/h2V+6kW03vgB6cUIu1?=
 =?us-ascii?Q?0SB6DZyBCsJqeffOISBLJoZ4mDJy4Mb2ldoXLn9d4rdVbY/z0BwNXBJzEZAr?=
 =?us-ascii?Q?2L0IFdkyXCrL7w5ES0HdSBte84Kcg0fIZq8tjhZIlSnBlUGfrUnzmM29iv0G?=
 =?us-ascii?Q?HuYsKI277TxT5pSDQw/aYiApnjDbPPAr6kN75+ZOq3MMgHOBljREbEAyrrr5?=
 =?us-ascii?Q?ILo6kdH0a1joceF36QqEjxxph/SS4Gi1xT/EFzRAuhkauQhRgxnn9oPfdENQ?=
 =?us-ascii?Q?JBw2RWYhUK09dPtp+jDnoewACAXx/+eQa8MkyaW+8v2uXk4Z2SpaAmNXCc3O?=
 =?us-ascii?Q?gukzUVD7r+upXoC3d8JQwQgfMtNmG28XLSn8EJQKGnqM2eR9C6VHjfHX3Ydj?=
 =?us-ascii?Q?/jum9NL+7wJig+byfr1TleLnH8qf4dp0GwHUetIFf2+7FixKcz3LupzyaKBm?=
 =?us-ascii?Q?BqpRA1RBELjsJAzESZfpEL0LRq+v27hyk4FoR6ct6ZE8jJ4toj0MkiXL7+uS?=
 =?us-ascii?Q?iA/LxXsPbK2/M1DdR3R/D3SMHXLrt2SAgoP4RaRSqtPwpG0gvyUhpd/Kez7p?=
 =?us-ascii?Q?uFGI6KSG5P3wWHwOjYDiwS04YxBjL5JnE6E4XLE5JmFJezGeQf8y0kEPfxW1?=
 =?us-ascii?Q?AzNGbJMrVKTNjrDYXakuZVtuZNM5JydEXDf1WJR/hOxqmsCbahSYyTWEBdLP?=
 =?us-ascii?Q?AlpSFtrm0YeMImY0b2bJizeZ3x80gq2i5a68HYy838MvfYIORs/zlL88CaWy?=
 =?us-ascii?Q?SaLVIdydMz4/PROVl/bqPBtVy3nSXk/e68v7cmGjoG4C7LMZ9WCZzLnPtRDT?=
 =?us-ascii?Q?GzrXQL0/zphJZsxSisonjBJl9EttTYHApCbmzolMGxEoZfj47pPoYkAeI1F5?=
 =?us-ascii?Q?IJePiqwRyUaAI7ceyu1shVZzXFn0elTderW5Zn/2CuczzFDp4jzTncIKgNM5?=
 =?us-ascii?Q?wA/5lciGHurrn4bUr+Zaskwueocz/yJiqu7GDBv4u0/faFPnfM3uMrqeK2Mf?=
 =?us-ascii?Q?cz5OT7yZhBEiBWbJX7anbvEOKNmCehOdmSXOraUu4n8Wf+XaHVwgIkZN3tMq?=
 =?us-ascii?Q?Mfc9ctbmgDGnfkaRqNyKr9CheW+vh4BywlkhxzLalLzhSxoO5Mdwv7s6nJIO?=
 =?us-ascii?Q?KQU9b6JixDuNMXPcEXpmt8lllsAayjj33Of1FxQjTDmmCb9+PnuikKHwGQyJ?=
 =?us-ascii?Q?82nM3dw55R61Qc3NiawTfcBAR2JRf+z/6sfwtQ0m1i7B/1BdbeRYedGoXPnl?=
 =?us-ascii?Q?Yasg3cDs4+oRW1T6XfD9CYj1I/CBjDBKNB9joyAv+Cts7I48HW7IZVXsn0Pe?=
 =?us-ascii?Q?Ba/YpTXKhEcccQXtO5kyMLRiM5T8VltK5aqznE1L?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7763b5f7-f20a-4bae-6f44-08dce3238874
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 20:48:13.3859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G7AfoXb7TNbJVHx+avUNYF2NwkucXjW/tHSPO91pDqwpQ/Bm35LrMVCJXehnkMjJie5fQ1D/rDCbWh631z6Nbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9454

From: Richard Zhu <hongxing.zhu@nxp.com>

Add PCIe supports on i.MX8DXL EVK board.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index 4caaecc192277..5ded27a26097b 100644
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
 
+&hsio_phy{
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
 
+&pcieb{
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
 
+	pinctrl_pcieb: pcieagrp{
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


