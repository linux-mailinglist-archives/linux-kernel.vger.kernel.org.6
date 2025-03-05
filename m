Return-Path: <linux-kernel+bounces-546449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE810A4FAD5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 052723AE708
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BF51FFC56;
	Wed,  5 Mar 2025 09:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ej5AYRDs"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2056.outbound.protection.outlook.com [40.107.103.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52A6207A10
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 09:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741168459; cv=fail; b=FSelJYHPQEN/WImNoOlI8vjN+XD/6E8T3DxoDKKdpdGgZKOh9n8o6AWrcyD5eLKbm20BikxrZOFu2xIZf5oDcPd8vuWSen79ynurKLLlAL+Ftpon0a2SVFuz+eRspwVj8OYgpZrHtBGbJdejsqnrG6bypvxkNZ2x1EVgeYiNdQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741168459; c=relaxed/simple;
	bh=duMFWqUnh/NlcFs+XbOIJ6ajyss0rAhbO+K3EPAC1xo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=uBvJzFGxQYJz2k8OOu3PZyQYTLQCDY0PjNy3lON/TBEBZeKuih401iXwCo/C/MIxZGknhc8V/sPNLegIftf5YAGPib3K6QjH6HssiJL/Tq7h0+/TLhG/tgi+T4c6PxLt5n0UzstRoK/9dvv2HXTzP0Cu3CQ8vcr/s9ceG4stQcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ej5AYRDs; arc=fail smtp.client-ip=40.107.103.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yWohazJQml9/QPIujT77Y7j8EbMYb5NdSInr8evM1buAgdDvLdbsFSHN9HmSx2xhxTQB3dLqqCC7yAyBKrPrKolmP/Vz8gCG2BCYhNKT4FG7YLD//E2pFOQ5aP/43TXfT17iVLLzSSk6A8wAObODEGy53G6CMZIWJRt3SUGe5DUf0KOIWqyGHOWfgk1b5KBmOJ0VP8naypZVtG+PvHgCLyzWlZKwja4LT/OyVPz4I8Ks1iLHWZtRtj+o29PUWYmis1mJIPrWjjRoLB7GTB+x77Unii9FsbdaxJlixSH+DW1JKJj7N8SWJ/q1VotsDeySzPcOTRUdwXsnb/L/uzJwrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrzNQ6xxO5XMmPy5DdCSSCRGmCtzogcRV3KQzK46K9w=;
 b=ByiA3YNOtStYkaENpKFf6TTM7hBPawTSUJjgUrvtu6rn21Jcc+GKBd02qHV28b4saeu09c+vJSnKTSnGWpHewteIU1xQK7GLeJ6AAklyVSspTOraCg/oOJZkSOERrMVmALRLfotLH7mTgc6MeWmLF+UmCSGdlioGZuC0egHruFCp+o8NoMsANbR8U56ijfWL8CugLhzmCLW6va6GxbN5g4+MWyND25ABCwmSeg9X8unri4zlD9VKCSIEkxN8af+F7TE3mwpWsuYZjHXNYTQLCkwR6OVYFpQxlZhFaurd8Ra+AObXyBfaOov8ZRJSlWaxldV2p/i+cIxV2cgBIGQokg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrzNQ6xxO5XMmPy5DdCSSCRGmCtzogcRV3KQzK46K9w=;
 b=ej5AYRDsxAYFdLU8oRUDWy/MWkVdQG/cjcSwznJBLl/sOFRMqfECHw59armiHCvqT3n6NHBD0B6+XHBImuCZamXl8Af+OtNO/1zjkCpGVs4jy3nUyRGCsUmfeB+6dAKHFmfyERKl27J69nkwOT32sHzKkq5MQTIU8Vrpi9UzXmTr7v2DUZm0rtfz0IWt//lErnwmn1ct2Fj546JcMRgpxGprCo9QYFvQWn6akS398+ft9EuCbXyBiH8FkbcwLIglmhzoII+fsKrM7S+9onzIJqcfDjrQssafRiEy2rvWfZ7Y/E9Lr95sQJiJQU7HLGMQajNeEJqblVQwUNIqnLe4Rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by PA4PR04MB7552.eurprd04.prod.outlook.com (2603:10a6:102:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 09:54:15 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%7]) with mapi id 15.20.8511.015; Wed, 5 Mar 2025
 09:54:14 +0000
From: Jacky Bai <ping.bai@nxp.com>
To: tglx@linutronix.de,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	aisheng.dong@nxp.com,
	peng.fan@nxp.com,
	frank.li@nxp.com,
	shengjiu.wang@nxp.com
Subject: [PATCH v2] irqchip: irq-imx-irqsteer: Update the CHAN_MAX_OUTPUT_INT to 15
Date: Wed,  5 Mar 2025 17:55:22 +0800
Message-Id: <20250305095522.2177843-1-ping.bai@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:195::23) To AS8PR04MB8642.eurprd04.prod.outlook.com
 (2603:10a6:20b:429::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8642:EE_|PA4PR04MB7552:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d553762-1e4a-4464-418e-08dd5bcbaffd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZPPU6BEywHDu+eAKAENYm8E+UncOREm+9/8Hhb8FppfiLrKCOtsFkmejK63N?=
 =?us-ascii?Q?575wryaxUDuSnfjfBVS0cXhUV5+OFHOxskPNs9KTt10BOreDrszZljXxntqW?=
 =?us-ascii?Q?AzlbwhkHJD2Dol+VmL04yna9euNDYRO7nmYTiru2Qu7+mKcCHU8hUgAT+nvD?=
 =?us-ascii?Q?VySWrFgY7Jonz8VMpJ+TRf9z0+bjseJ5BjbuCMW5Ueg7KL+HGHabyrgskDnC?=
 =?us-ascii?Q?RxNt+9ndVcYN8lDrPcTVYDiTmXjQZR9H7Umcnl8ZLAbTtC/wC2LybbgD85G+?=
 =?us-ascii?Q?znfRdC9wXO+HDRVn77vPqniU3mVnHoHKHNuo7RoQoX+GQIpEdqE3mWjT6F6/?=
 =?us-ascii?Q?oTHZygiNhgY73Uh9oG9/nOdpcZ4fiVQLVFPrCEpNsKLoV8KWSU/7Xus6nc9Y?=
 =?us-ascii?Q?zZgN5kQBgk5IEiB727ttsxvV2z6dWBWPloQUvIM6T4zGt7/rlf/fC6QsiAKy?=
 =?us-ascii?Q?N/JZRGl4FOEQ7lQ2R80GUxBYXmXUnfCOuy39ELL71urBN2rgRES5mVzjRo0Q?=
 =?us-ascii?Q?tQiFALmDirXOxhSt6/rLAFHlZtv9tAgLq/U4cvGefP/JalsBBeZc//pt1g4z?=
 =?us-ascii?Q?YWSAX1bxE7pi6E6U2Vjq85c26F5Z7x3cGSc+hf9Uxzw6KFuKtW3TJ7idSpd+?=
 =?us-ascii?Q?8xN/F77Vjx9r+CzOZcusIN+xGXgX7m3uNpEpqs0UiIEMSOsblXR7g/7XeV/F?=
 =?us-ascii?Q?q+0L3UXXo5b4r89H2fOQLuGlcVQiNeagjWDxP9Dca9eDi/GNMh4O/hZtbhUJ?=
 =?us-ascii?Q?nMg+8Mufub1IU4LPcC9jEJ4FJ/BQwMYf3l7ppPaEWKpK8DisXUva89H3SgH2?=
 =?us-ascii?Q?qXIC8z6FskAUWz4ZKgz4EoIcsZlHrmjfAwwS2XEOoy2vLzfd+gKGLAKXlecS?=
 =?us-ascii?Q?TeVXwECfhSAATd4xjyS1X/mdqjAlZzQNii5SbIbp6Ce79Rhc8layQWVu/cGV?=
 =?us-ascii?Q?Ci2tgRfgN40UjVJ+a6Fl28Fmqp1alJ1YsVtGBoY7sdK3g3OKo/9jf982SGja?=
 =?us-ascii?Q?pPpeFHsmt1jmK7ViXJjpG3JTnmxp8jdZ6Kk/GUTDrkf4HW/eUoXPTm4Vx5BN?=
 =?us-ascii?Q?ZWPW4iCcWNZ7aqBuykMU+6fC18RUH/TGFCPwZo8E24/1FJJ/iYmnv7Xn/GcV?=
 =?us-ascii?Q?p5qceNwgQ4abnO+x1fkeeH7x/Sl6pwUmzef1FTDOswHk8WnlRBdMzlRemjtr?=
 =?us-ascii?Q?5aBTnwKy4EMC+L7coYisBsL2+eH2Fsg6HQ6cXlMkqDQctXi56pFpMvTGagNY?=
 =?us-ascii?Q?mEQCYHC83X3C1FZV/u5ZUby4zBxN69QRE7nyeNvUGSyzUARZrKnRt4AZNUeX?=
 =?us-ascii?Q?GMI/wAsuha3+R1m2YGB3kQLMMX5o0J0cy2J40VhE7gIHQ6HBc7G/Xl+R2bLZ?=
 =?us-ascii?Q?5htfTT5MQbk5tKia07jpc7s1FSlNeNTkl4PThXnpacNjXyZH77WjZs/Txgt9?=
 =?us-ascii?Q?D0wdhyipK8HLDitxBoMZOfiORPLYDa7m?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?epsjKApbhPqGJksangejQW9GA8mhk8oBSCGKga3opyhPT8uszrLhoebiG9Mf?=
 =?us-ascii?Q?3BG+rG3rLtxizMyTrEnWbCN/PDymwrM+Uec1y3k2OeXuslp97bv0oJ4w4hEp?=
 =?us-ascii?Q?EOn5fcjj4EtX4JzYj439VJR9QZ3D5KQuXgzY57c+q9QRynOgA+SufZCDRunI?=
 =?us-ascii?Q?kvt6i3qdCGYsxNP2gvM6VKaBffNmVh4YUTUn2eSmwgqb5Uom5Skw+6W4clOb?=
 =?us-ascii?Q?qurHxDGerRmLu9JrYNGHZ47JXHSyhfI/38O6/1byrmnMAHoupUfm2YI7KshP?=
 =?us-ascii?Q?5rW1KaNdFxgOC+5XazZW71Q3ifnD6PQNmrPyvAxQiZ3Llm1QYQgBVJQOFnLP?=
 =?us-ascii?Q?qV4wTPNvf1+f5VuWT3NAZqEScap2VtIPMrazt9b8mng2iOLnRtnFF0jFEID+?=
 =?us-ascii?Q?VTbSuUHy/AVWjpwhQnYrNc0IHutPsJY7+AcYvaxSFqtcB2lRktuZu1PyulMz?=
 =?us-ascii?Q?mxGyw+lLG9riwuk20ov/zCBdpX7maaZPvd/GOb1Xov++qcln2+yyz80ynusk?=
 =?us-ascii?Q?n+h96s95F8LrYIaUSncxSl5t4DMloOSSYRvWIHl3oy/JRk7SqJvV989O7vOK?=
 =?us-ascii?Q?ysGksOkInL5CYLt9xZ1bs+1Xd1jdux0mIeHMboVJzoJAePvVf0l4qmNI0Jl6?=
 =?us-ascii?Q?m4jqp3OkLqhcZtyN9DB1O06CUXT2e+3XYKq+sWbKbSDSVRv4iAZEE1DhdE+7?=
 =?us-ascii?Q?Hp2j7hMMm5kn7+Ov25bJBBI5L9V9Qlui4lzyPvlWgpn20q7YR35YVfaM/VTx?=
 =?us-ascii?Q?O9nYTpW8MGIxnTyc8kfOEjb0dvMJXG/1Wi9U5YV24qM7UZdhX1SSrfbmK3zS?=
 =?us-ascii?Q?fMDwK3DHNAHQ1ZH1zmCwXTrwh4w9ih4WpqgkB7ePd3Fy7SjeMGVDufieCw0F?=
 =?us-ascii?Q?Wddc4mTX7gPTVWCFBNIKYfePDfU2hBWVwHpUz/PkhaV4bhYfTbyf1BQSd3fK?=
 =?us-ascii?Q?FMxgyOiImf6hi5HAOWQFhis8SDdOm4UpGwQ8Fw2pgKEi7NmbyfsMuRvgu45e?=
 =?us-ascii?Q?awlbnMhqzDHCAfphcVjsv00YEf8JqaCWlRwEo0dI9Kte4ugsz/qm7/w6IbsC?=
 =?us-ascii?Q?PSyipEAB5AMHYu0DIFIGgLBxrOSljRXI0rzcN3FGbZzwSBwh1PWn1qFYhGmu?=
 =?us-ascii?Q?qiTv96F/c/Xwswi9gspPK08OnXjeA4l+e/bYQ+vDMVh/TAN8iEGgs/dWKeAs?=
 =?us-ascii?Q?Fpby9qEPDY/OGzqM2u0tV5EPy32xTjTbVDRWpxO/kgpw13gl8FLaZT1tA3LA?=
 =?us-ascii?Q?2BWQuagz0XJtN5VuKA6n2aVr9Hw+tNT9tQsOf/5+YjVVxTVDEhMRvO3SjNo+?=
 =?us-ascii?Q?QaEOT+FgM5XKjTtS5onwfb0svu4qd1hkAdZQqaKBFBm9ICApBx4xWyDP7fBo?=
 =?us-ascii?Q?TTA6JDue9X1hxYyfkXZ+7hIT4+GeTrsNPKhYMZObBYpn8amufXdXsEL0hVTd?=
 =?us-ascii?Q?gTzGu4Q2y2RgWudLQF7VugR9LeVhkHAHl6SpKhqboHYANM28YCBqAMSIMNxD?=
 =?us-ascii?Q?qJytg8l3DXyUiThl6C9IVvk1k3Fo8wbwnrlQaLCBGvO0+jXRj3EEEQe+gwiB?=
 =?us-ascii?Q?1xcn3cLbDRA9EXe8d0ewR68peA1crqrVbObhkGhS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d553762-1e4a-4464-418e-08dd5bcbaffd
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 09:54:14.8756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lWfyraM9uoZTkDve0GAJ3vuX3VObc8acBAplj/n3kk0+dRGBWxRC0bNkMfxBJ3+YchBBodVFVhZ1ZJsAllyh6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7552

From: Shengjiu Wang <shengjiu.wang@nxp.com>

For the irqsteer channel, it can support up to 960 interrupt
inputs. All the interrupt inputs are divided into groups of 64
each. Each group of interrupts uses one irqsteer interrupt output
connected to the parent interrupt controller like GIC.

The CHAN_MAX_OUTPUT_INT is used to define the max interrupt outputs
from the irqsteer. For previous i.MX SoCs, the irqsteer instance is
designed with max 512 interrupt inputs. If the max interrupt
inputs is 512, the max interrupt outputs is 512 / 64 = 8. But for
i.MX94 family, the irqsteer is design with max 960 interrupt inputs
capability, The CHAN_MAX_OUTPUT_INT is 15.

Update the CHAN_MAX_OUTPUT_INT to 15 and do necessary code changes
to support the max 960 interrupt inputs case.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 - v2 changes:
  - Improve the changelog
---
 drivers/irqchip/irq-imx-irqsteer.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irqsteer.c
index b0e9788c0045..afbfcce3b1e3 100644
--- a/drivers/irqchip/irq-imx-irqsteer.c
+++ b/drivers/irqchip/irq-imx-irqsteer.c
@@ -24,7 +24,7 @@
 #define CHAN_MINTDIS(t)		(CTRL_STRIDE_OFF(t, 3) + 0x4)
 #define CHAN_MASTRSTAT(t)	(CTRL_STRIDE_OFF(t, 3) + 0x8)
 
-#define CHAN_MAX_OUTPUT_INT	0x8
+#define CHAN_MAX_OUTPUT_INT	0xF
 
 struct irqsteer_data {
 	void __iomem		*regs;
@@ -228,10 +228,8 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
 
 	for (i = 0; i < data->irq_count; i++) {
 		data->irq[i] = irq_of_parse_and_map(np, i);
-		if (!data->irq[i]) {
-			ret = -EINVAL;
-			goto out;
-		}
+		if (!data->irq[i])
+			break;
 
 		irq_set_chained_handler_and_data(data->irq[i],
 						 imx_irqsteer_irq_handler,
@@ -254,9 +252,13 @@ static void imx_irqsteer_remove(struct platform_device *pdev)
 	struct irqsteer_data *irqsteer_data = platform_get_drvdata(pdev);
 	int i;
 
-	for (i = 0; i < irqsteer_data->irq_count; i++)
+	for (i = 0; i < irqsteer_data->irq_count; i++) {
+		if (!irqsteer_data->irq[i])
+			break;
+
 		irq_set_chained_handler_and_data(irqsteer_data->irq[i],
 						 NULL, NULL);
+	}
 
 	irq_domain_remove(irqsteer_data->domain);
 
-- 
2.34.1


