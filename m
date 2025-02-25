Return-Path: <linux-kernel+bounces-532310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8100DA44B49
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71112177CC3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2F51DA634;
	Tue, 25 Feb 2025 19:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gegX5Smw"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013051.outbound.protection.outlook.com [40.107.159.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BBB1A2567;
	Tue, 25 Feb 2025 19:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740511574; cv=fail; b=Te2x3qEVClb1W849r9+RV8gRQe+53Rzf2kW0xY7i3fXwKqY39eQZflW+BE+QiG9solg5/xUFUOvjUVU1G/WG/0xhr+1VMivpXvxixKVMqJzrQpI4FlDBfh3jCyTRjKvhW4ib+Wj5D0rdPSvQ2iFbOyKHcik+kcaXv3/QjT2k0pA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740511574; c=relaxed/simple;
	bh=5WFyyI0NllRGAo+rJDHY+Q5m97YxEg3XKFG3TPO3J7Q=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=dh9ygunMyr+iW6mVkOJM4wG9aVU6xivs/jgXoHw9DjDBz20efbaQKndHqQ8QL+wpgdIlzArOMgVhFhvrF0Vf19TWdp634wC2pe2FvvePnBZIBnFJ/wEQolcSmemTmotkIH27pbZHFwKTpl7iNFPUMwcLNFZWfKlmnYMBgd4sZKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gegX5Smw; arc=fail smtp.client-ip=40.107.159.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kewEfTl6qDQUVo2AulH1hYYHOrD6r2dse2pKEnild2q9/agmsnJQhCzS4MaoZ7O5X0BUvX5m4DcV2ZAen2f8yKo773sUo58+05FBOCuXv61WtQUftq/fD3IgNMP3ioKWwqMRxWmutE1VXUecQ9Q2YI+gE4yGdGHdQEoh/Bo0mDa/7hjgZGxn5OpBqDTj1UqT7YU2dOez34dJY15EARyv2TxiT/je9W8AuL0cap5p/cKIIbwdrxOg144flxjoO8XE+JQSIL707HaFZMnQTIrNIHXM34sSytJKHKZgdboSIGR4pIpI7sxzPWNmsqlvuFFPGOHxUB9YS+kcLcKxnDprdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4R+xBHnzCZjZW3BWCqcH9jicmXAMCRJy503Na1AlqrM=;
 b=Mz3fHGscExB4jfBA1wy8/5BlQn5cO5QjmzOk6XKPgMmvrwxCaO3uY+3XMzDVh1HpH1fgp+0+2qbS9hVY8H+5o/zE88MZN/2ADN2v+CleWx+Gv8ZnjJquUvuw/3f7c7RGPE3CQXFG+ocUuVWMufYwNdYfyfd4+x812EJCFh5ykm6kvdKAVYT3EjlnHwGMpu7QZB/3oVzHNJBVSz4XODPcbPJVRA2fiOKJds3kdpAEqEhRHiyhqfFDqj1Z4lcBzea/L8Co3GNZ0yuOUNNITO2qPX0IRvm5SNaznHQYUXIqKwG2uhKh36y7mVrUteLxZGcQzFeLFsEIgdH+u6wt81lxtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4R+xBHnzCZjZW3BWCqcH9jicmXAMCRJy503Na1AlqrM=;
 b=gegX5Smwd4hGQ8F4d816gyyOIOVzoIstreGH+BJUHLbrN+WzIk+FQbtomUWswy1oS+9BVG5MI53Df00MkN0jF6bgpbj68hXmb997p6Lxv2J0fuU+YDx4c59AbEwmGKF4qJvWLe3RhwW5UhfS+d63ufOu1gBYaIxHFkrQxHZZ6E9TPCohHLpmNUH094gjgUdK0AHs1R2itbuszAI2270kXP49NVt16Qmn6AOLimYC0NW95hwMjI1FFcpCXJAtgKvwwM8vYyJQ9esgRKoW63VtuWHBPSvZNMhKEK/BSHPy3lbsVKKocdE1MqKA3M8CIVjIpKw6CGZuEeg0Je8f1Xl5Wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB7177.eurprd04.prod.outlook.com (2603:10a6:10:127::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 19:26:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 19:26:09 +0000
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
Subject: [PATCH v1 1/1] arm64: dts: imx93: Add the 'fsl,ext-reset-output' property for wdog3
Date: Tue, 25 Feb 2025 14:25:56 -0500
Message-Id: <20250225192557.2914684-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: 1502e40c-bbe8-4103-c422-08dd55d241f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|52116014|1800799024|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GzWoUwtmhk7542BSXlOnPbtf6HR9m+4sQUv2RQFfb7o6pba8uox7ThpS9Z1f?=
 =?us-ascii?Q?su1tcJ99ljQZNu+LSrjg3ejXlVA5+NV/tIoL8kpQa715jm7vLxtALDR9Txmu?=
 =?us-ascii?Q?QbUpkZqbrzPiU7WLaLsxoEolWRNsRyiB0s43pcHPMyS8obyctbwyf/dqfCel?=
 =?us-ascii?Q?JcOYywopfUnzUMjyNRjGAwls/o4mBWooSNNyz/av8Zr8XRjnvGrbnNXiDpon?=
 =?us-ascii?Q?BsEE9HtznieGh6/wIw3kbBt9mGC77MG5HRxqavXQw8nYlQpAYuVkQyEHc1mq?=
 =?us-ascii?Q?jF2tN7QIZWDRSsAlJ3P/TSH3Ey+QW4f1SBwJznH01Ei9S6W4ebeEvgwiKnTG?=
 =?us-ascii?Q?VwlrlA4XySNd9C3kDPacsqwVqJHvyqenq8HF6X/0Emh+xpgqwIUrTK5YlpuJ?=
 =?us-ascii?Q?sXSl4j+MKsuZ9GCHL5vDiMtCTp/l3cO8YyTZslD21BXlsOaRd52Y34hIlSy0?=
 =?us-ascii?Q?mVnuQF8DnP5ZE1SaEVyvXxXEsQahUJnhVA6KmCx47PP9mA6Bx1PzDEAgWFYt?=
 =?us-ascii?Q?zT6Yu+GZLJDhF1zXGNBJGu2H4AZmJ2CRiniIyUyDzWbe7T7xdmY3nwe7gitV?=
 =?us-ascii?Q?a1LLxChgTDum025TOU1Sf6P6rfEg4AJ5TTvqytVFY6BFmbGalf683u5WtHTN?=
 =?us-ascii?Q?O2sVzQ0OLGtS8A/QVoOKnwGW49Ab1dbYszTByiq8WT4IUHqds91mwu7BafQQ?=
 =?us-ascii?Q?957PvieW4YhvlA1KgcbH+VotIZKFJdQSqZYtWZLnEJRDzGYRzMTMZRr7MEAK?=
 =?us-ascii?Q?LuRBE4/54M1038H5JsEZ2E7/AKMCaPcZFNs8GUDatB6MnjpK033ulcVr8+yf?=
 =?us-ascii?Q?Np/b5r33fuc5Og/N6aATc8ytK5QTozadI+XGNuHAvmP+WBBe3f5KDGxiDsPf?=
 =?us-ascii?Q?m/txV5khEV4jCtayx/W7VbC25dGBIqCqy2nwMMt5MnFqC7bdJf/ox8/R/4EF?=
 =?us-ascii?Q?PRdDTxz4dCLUFUFFFBtPleCTVqOcpapBDp5uvF0OvdMD1ADy7CFs7CCu/CWU?=
 =?us-ascii?Q?DWL7krA9M5KDFA6XftMcN6T/jwljGM82rPfmXN9cSTG/o3nNv68xkyLAhLHU?=
 =?us-ascii?Q?RJO2E90pV/PfusB9fiIkF9e67dr4maqiK2tvgLK+SDp0g4FVg525g6uw4Kfo?=
 =?us-ascii?Q?R/q715T9pzne3CyUo0ok/9lthzLQNXZAbVJHdqsKDFRwxtZIuZNLMkUlTsnj?=
 =?us-ascii?Q?GDGZvFHi1b9SsYBxcKy1UZxdZUmMGk6Ln6mTua/Z4MMqYIdsFdkuS8Iud5SH?=
 =?us-ascii?Q?bIwVkAPaQT/uGITqkX6q2YP/D+uKJacswo+fq7Wx5CWE2RsJewAKXbR5VBMi?=
 =?us-ascii?Q?waTXYWmL34PTJemp9bXORbgmhrEu73jzTc93I3t4cR2EXUgRcQ1cXN0hbt+7?=
 =?us-ascii?Q?TP5WvZxWMZeKsYvxI1FeDB4IrIQjvHjD+DOmN0ugHfSgWtOO7yK4ndu1MGXg?=
 =?us-ascii?Q?fxnG1KqIart/W6T7Z/wVEkl0eTxNLXNtD4n03PGss7SIFMlfmf+9lA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(52116014)(1800799024)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?shWZizcKCkk/sQfKf4AsraPHvnuS0AJiCyVYX+g8rVJTlAnkY6rLhOZ3rIr8?=
 =?us-ascii?Q?hBE0pS/COXc6UfOT21fdl6c2Gne6jXhZQZg/YkRyfk1xHvIUO4GhEhnRLU0l?=
 =?us-ascii?Q?qblJYNoeFuN+nngNxle8/GCDrVjDqMTTGrGiK/S7q6EV82PuS79dPMdMqEjV?=
 =?us-ascii?Q?cNDhOFDi6YbpvmiN2PRk1NCKqx/JHN1UjVCd1PNXFuvXBvgOjQJb4dvzEpe6?=
 =?us-ascii?Q?LrstjHtJEhNawgO3pZvHPb1IGJoCxjXXeTB4YQFu+dK6E3VJb//ieAVD/qge?=
 =?us-ascii?Q?AorCODQinTl7N1ZASH0RuV3r/7gN5UlirGQHsVf5sOzoQLiAw2DU7wbd3gZz?=
 =?us-ascii?Q?LmvrJ91sQ9lnU/UM+wa++EHYS4NRLau/GLHdxIS9TbodRMhSuGJriHY+G/tr?=
 =?us-ascii?Q?rqBwdHn7SMf9fH6cLcLOIJZ3xQQJh+PNEmLBe0gHVricNKic5izVUAi2JxZq?=
 =?us-ascii?Q?xSMua437CLNHkbQy+NIRFillGQ7s9ugEk7RjHDT9R3Qd/QQXI0oglXkIanP7?=
 =?us-ascii?Q?+xr8k8b38kTIlM+rLRjuG3O7sPI88Ckx0kvkLXVA3V3oYPEBQawUx36wVmlc?=
 =?us-ascii?Q?Y0EkpWUKpuzmNYVxfxHKCU20tHXTzzro2afaBirkEQCm7LKgj3wYFSkoMFqn?=
 =?us-ascii?Q?leU+28qqE1PU4MnHrKmMWlxikfptLhQYozTk+PS/vkPIjvkAZYyGR2lI0xou?=
 =?us-ascii?Q?wFP0+vjwGaoxNa8nknrrv/a20Yj0Se4hEOuKigjpLhK9uvnSwbWl6GG1k6Yc?=
 =?us-ascii?Q?Es4bYyXp2jW8tXEylfwFwRB0GuMbZXOtMcY232UFf2pM/MxnVxwnPeNCbpsp?=
 =?us-ascii?Q?39nA+EIFGbRhj+at7wWjGDLuZk9u+I3FtUJG53wsQwVf6MSo48Lh4yFRgH2h?=
 =?us-ascii?Q?sEaeNClddY/1YPQAH7sJZnHQP43KdBti1R0RVs63IPdgit/Ac4gsC2ExoL2v?=
 =?us-ascii?Q?cp7bJU+UjKjAG3Isq6RhRYDxafApn+MF1OwgZjtHLzyRVc4Ia19a9mGsawoh?=
 =?us-ascii?Q?qzjzkw/XhXEs4aj7Ki0mOpIebZGatryEOcyNKoV2tixCvyoXzAb2VRA9YR2/?=
 =?us-ascii?Q?9RPGtOCxCZ/GA97U2owgh+p9XJ7G2SruDQwtB1ZJDEhXBMnHP+tmTHki2Q5j?=
 =?us-ascii?Q?4CVoq1AUWkCE28bzidVfgDM2ZrKGU/W0ZmPQPyU1b/TOCo0zR/q/bkQu0raO?=
 =?us-ascii?Q?lovigJL8rc53LM+z0Kkme8iONfyLA4RCxSU87BzbCKsyKR9Kcb/IH/NQZTPf?=
 =?us-ascii?Q?5+ksGMl4IYZcY7feq+p2P2rLnk1vAdTiLZG7wxheqFHMf+7jZ4MRHetB+3Xu?=
 =?us-ascii?Q?+FBne5Gk95J/hH88zfzPwy9464zPh9ifca6BtR/0OCF9I+XnAaYxZjdf03b/?=
 =?us-ascii?Q?G5qh5uQQxPPdjo3Oeqeahzly44+k4vWzC/oQTBeepamlmfHXjJSNGVR+lm5U?=
 =?us-ascii?Q?TXbgOJ8eQla8iwRiBDjhZFxUulWKLDess58Fpup0BIk1KJr/GpZs4YYlG3OA?=
 =?us-ascii?Q?N1XKXZ1wdfcU/0i66LmgT0sltEI1ryHZXRRqKGZzi2OTyksNRMoF2xy3bFte?=
 =?us-ascii?Q?yxvWjy8d6a7iqDPhpQTk5l1pgC3ZcmaeTiik3HGE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1502e40c-bbe8-4103-c422-08dd55d241f0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 19:26:09.7260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rtRFruCzQc3e0plUegpv55JGRLibnwpCTWfgamRW4iPhA0LdwTA9eON3WPjdTfpm/a2jtryAm72U4sM/vok8Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7177

From: Jacky Bai <ping.bai@nxp.com>

Add 'fsl,ext-reset-output' property for wdog3 to let it to trigger
external reset through wdog_any pin.

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 64cd0776b43d3..ddfd57cedff73 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -692,6 +692,7 @@ wdog3: watchdog@42490000 {
 				interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_WDOG3_GATE>;
 				timeout-sec = <40>;
+				fsl,ext-reset-output;
 				status = "disabled";
 			};
 
-- 
2.34.1


