Return-Path: <linux-kernel+bounces-543724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE5EA4D93D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E68473B45D8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2941FBEB1;
	Tue,  4 Mar 2025 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lBT1mA7F"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012039.outbound.protection.outlook.com [52.101.66.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2561FC0F0
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 09:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081452; cv=fail; b=kskGm75mnz04J82/fZbgZbP0FdaNYKrp1gPHXrALGPlMhyGXt6btVuWoJ4maMwKbDdpflM07uPuhmaBm/Wk5NhJ3HK6uWyhJiPzKOqDUGzApLFzc09hKQW/qNdXnftFBamtrWMKly76cvp4EBy/G1Zp00gKFpnR8wkNj9VqSZxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081452; c=relaxed/simple;
	bh=5OsHPE5V8BHGmOYJyP90+vg7T5YeL1FX+R9mwvqhRUI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=k2JiyX0S+nOsQUnj5WAQwFIKMBcJ6unMN3u5u0WA5i1DA3Rxa0s81Ix2fEtW6U747h4zXcmCb9EJ1zEBTdcXcssn6p7F7PRfdU0QX4uA58F3o9D3EIBwgpW3F3jJXBUDeWD1IGaBO4p2LPe9Mfs9y5zaUOKDMicYMLH45STNvtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lBT1mA7F; arc=fail smtp.client-ip=52.101.66.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymXKIsqzgynuf75LL9uQgKlulKB7HsmbWO34s/R7Ui/jNXcIa3yihNt0/Iiwd/ZAaaogH1ZvWsytJkgLSh+sjNKOSoofAOzKWAB9JDpnvm5Xltd+53KpjpEjH78xFQww0QLOVeFYJcSA2w1F1bdlKscCrJV8zk6Im9PHDBGD5LWaU1EBgZZlxePH/fa9yO2yZAJjeAliktQhGa782mEyNSXAcOm6nJMrC1e6lgKq+M9sE/SqRtYRYR3s5GvK1X8GbwOA4sDB0IsPt/Bh2m3JW0BeuGaa8XHJT8vsg6CuR5Xt4Q9YlTww5kaolEA0chXy2kBL7Rx40Yxl6cY2Ryqzqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2kHQuxdz+r0X5OHCy7CZo+O//quVVETxPoj980sC+E=;
 b=arxu7Wnw3Q+2yUK9LGR2qrY+HlDfK54dOlFR42OQVexWfLEZn+DDZttQDjVzhcwh1TZktbrScNQfJKMF0XW+NlyVRbxGbTAZFjUESKZwLQQteGA0xCmdTtcGU3i3ZdBtoSosGJkawkYuXDqfATfAax3QJy1cXzAnQw3IGcfK7uUqmz2IC2nLAHdOC4Zdx5YaWKIFvSjAaHdGNiroVF/ZmLTDYtaNKl/dyGRDDFm82ICfq95p4wjHgbYE9TkJqNvw2gHKCIRESRAzpM2VrI/fPSogvP9Pi/QgyTT3Ve3Np/zE8p+O9YecBlrDtHbZIOx6JuWHoPWhs5NbrE+ee/DwjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2kHQuxdz+r0X5OHCy7CZo+O//quVVETxPoj980sC+E=;
 b=lBT1mA7Fswf9jRHmxfkvJBQ4mZiBMtzvW1fru3SH8GIpWr9W1BR89EBcl/a8RdXDA+iYpiiOxUc4WZQIuacqq2/CiQugE9qJRmS6W93iJYnmlNx799LG7rT2vgnVM67//I0oN/hIHxJbg5MejMgFSChBiXAoTTBm+O5wkAxW5eygc22hI0cHUmuCv3iCFXy76wCvQYe8vxRNkUZfi+GiKDGsY70NfBqvl5MiqFvRAWaBrJnlXLYeg7viybd1OJ96CNX+GtO1OUlaZIKdfk7GOB9zNsOLSVbN8JpoiX+9R86voeGDkJzNbAGZmsTMhmM7W119ZDs6LYl/XuutrqR+Qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by VI1PR04MB9977.eurprd04.prod.outlook.com (2603:10a6:800:1d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 09:44:07 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%7]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 09:44:07 +0000
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
Subject: [PATCH] irq: imx-irqsteer: irq_count can larger than registered irq
Date: Tue,  4 Mar 2025 17:45:13 +0800
Message-Id: <20250304094513.1964356-1-ping.bai@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0161.apcprd04.prod.outlook.com (2603:1096:4::23)
 To AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8642:EE_|VI1PR04MB9977:EE_
X-MS-Office365-Filtering-Correlation-Id: 76a37bf9-780d-431d-1f04-08dd5b011b0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bFlHQeIwIMEybSjKE+5ucdgzJl3qmd+SfaP4csMLwLrCk6UIK2NPM656jtIw?=
 =?us-ascii?Q?xfXUWLMByWWY8UMOHaEQEmmF+TYL90SRG5r1gPCCAeeUrROLGz1wZ7UpFT0I?=
 =?us-ascii?Q?TYmbUNL0I/PQH7d/8oWboCpYJ//7oyIxupjx4eBsuCbGrV46rVsQdKaKvRzc?=
 =?us-ascii?Q?N8CNTlwqPCXckyWqLtYSLYA3rSRyK6s3LA2LM3KOcuWZIwZSI7DF2xVDo1l3?=
 =?us-ascii?Q?l1R1zCEKIC006UGYniGAfkGFde5QBTK/xYeKkspk50mEcilroU7AvRtWfUcJ?=
 =?us-ascii?Q?V7tHVtoHQH1E+p4MgWzdcvgB6UoUNtLqVxzca7kHZcofdVAAyeuCMpRLdROl?=
 =?us-ascii?Q?Q+yzusPv74yXLhJoOoPOUsQX/jAD1TdYGhm8uB+vMxhAp2Q83zI7MnOtiUNt?=
 =?us-ascii?Q?tUgch387ijwwGRohTvG73NiH75sFhtfnCh5bXSEmgqWBD6JhsuRYY3fcYb3T?=
 =?us-ascii?Q?SercgY3fDHMh690KECkAk63mOqfEoR/9qjbst1L2iH2VBj7jhOrKyA8Y8Gsk?=
 =?us-ascii?Q?ZrWMCNZNFLkJfnm3MJoI2katTwRIOUU7jybkeZZ6vAGKKgrMcKEOjBZniOaB?=
 =?us-ascii?Q?VAf3lckAO9kD1R8DLUPyzb+P/KeaLqETt3pSH1qtxU6gm2D4kCh/4jLM7U3E?=
 =?us-ascii?Q?CuP4bjOCmkm2C5y5YK7D3LVBa75pmEnokrF4HPyzRq5OPXoqEBcRAHuim4uo?=
 =?us-ascii?Q?bI+kRdlriG6FjfKHukcmgbeFqOU5slpRwn+14JsSR7I3Gj7iYx4rc8Hu/NCn?=
 =?us-ascii?Q?P0c4ReuBQx8gj8Q5cLNt3B/Z0brpYyexCA6Lklqn30RFTYR+CRmnO5++1bRl?=
 =?us-ascii?Q?vVqatEW7BfZBJwTk41Sz0fgJX1aE9kg9CVFtT8ZI79Yh31+aBn5yPwcHMWwg?=
 =?us-ascii?Q?oMV6hheZ4Q3Cp0ThQys+LCA2TxkJmirCgUJBVFI1uIBmy/I5rKOn5edlHaeB?=
 =?us-ascii?Q?FIFPJrzKecHmFgOj0QQr6R3c3G1O3sP5zztTTqZlebCJNLlaJFJ3YVfrwfn2?=
 =?us-ascii?Q?wNFC8Jt1VlpILQ1+PepoXNvhZaF65O1/Jl3/aMrwDS0cRZHu6OlE8kpYD7r6?=
 =?us-ascii?Q?+52+P1tQ5YgWRPWzRVU2sutwzIukRhOT4IVHXu3rNxiAnaqcLAzfX2Z0XGWH?=
 =?us-ascii?Q?yaeO6dfVAHthWLPclZ0XzTdsvsYc/oqs1ZvU9BNlTgyi1vogBh86JS6W4U6b?=
 =?us-ascii?Q?9aSRggMSlHXzvHFuez8CDsCZyLcmEBbIbQ9MK3Rcn6cy9LUsaRZ8rYerzRcV?=
 =?us-ascii?Q?0bsBTEAzLplxBbGyb1U5zLbd4Lh7CFPvL5yfwdFL8Qn9IUozVPl0QhJKi2xO?=
 =?us-ascii?Q?bh6I9EqN2+fiW2V9oJOnP5iSCkX25M/Ee4e3BJaYX1KGwB6GZiJI3LXDMRBl?=
 =?us-ascii?Q?uvHkeuMZIc+Q5QuNK6kOfB32JDzikZQUvWWewv0DdVd7x9NO3bHMAcKvkFVi?=
 =?us-ascii?Q?4HxhBWJP4ii3d6jpOkZpwcuErMiEbbBP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eWvhYflcCxH/us/MG/MtTmTToJZN096o1XIvHCw0YcBXdkHqRkKim/EvVVgm?=
 =?us-ascii?Q?NeGI5A77X8rOp9FzP5aUPC9DKlvD8luA/KRA+hlOS4duIuLvrhG1r/yxYOlh?=
 =?us-ascii?Q?1DMhW4Gv98xqV7RXuIya0gwV3gcEg+o0rBEF0nMgHurhPAasBNGqFia+4zzm?=
 =?us-ascii?Q?mQ8rN4TrXCvoTtB6hY786TcdxOooCIIq0UuJ8cE+Hw5QWWSGlnTcilI2vnW8?=
 =?us-ascii?Q?WeHb2i7nUd+CVxRd5vRsACpwU/6C8uLfvDqMQwEY7qONcuYPRxa2/z8TEbWH?=
 =?us-ascii?Q?bHiuJjCG8jsa1Z0je7yNioPOdQ0IE14YyYI6wIwS+4kaA+Dtq+FPIq93VJyK?=
 =?us-ascii?Q?2On7zcBKRq4ZJMG39ZWndnu/lUm8PSoBorSdAJ4dPldcXSK/JB/K4TRFyV0b?=
 =?us-ascii?Q?tLlpbCMigpgnaVnBQoe32ST3aqcslaEjNorGVuFITtmQIi7CB3DlvRXrZtpk?=
 =?us-ascii?Q?a18OyJ1ZNkN0pjvrxPkLjec6ewVUB3vYAkkjNSIPw/R1YDgjuMD850e0NbDW?=
 =?us-ascii?Q?usFyq+MAyLAZxAR8y50ljfcWazDZ4Lf46XFtkJv6BwjbwavdPEq+Lgg6Zd9T?=
 =?us-ascii?Q?t1hIHYOgUlE7+pT51tSCyp+0rHlHSvAhkEt5tWy9KX5IB0zRFdj2Ocwkeaak?=
 =?us-ascii?Q?F1Ofcod1IQBav5eZvlda7TOlrwHpQXGuieDHUjvP82N0zvTcXeFOm7JdmIAB?=
 =?us-ascii?Q?GAiNHbQaTX7fx7HWV+xfYzX5JnOwg7xdpZwRjlby5tzP3QdMB48dCR5zL2oA?=
 =?us-ascii?Q?ifdfd7/7HDV2tkZkf5KpUud8TpsSKc6eTWhnYSnkFRllx9iYiUe3VdVyxnWB?=
 =?us-ascii?Q?5V18T5jSMKxSUZ+PfV7EspA+BpVfxsLyjTI4uBkhh/c7DGzxbtTgEXZNyk7R?=
 =?us-ascii?Q?B2/kqNXY3lyRFdxwQ/XLiA3CGdUq/m96j/nkPGWx/QzoX8QZh6qvtFNrMy0Q?=
 =?us-ascii?Q?SDaztvqsBAnum8enD2vVzOPnIDx3FsUdg4FvTAmlzGfWb5rHTKrjEXn8K612?=
 =?us-ascii?Q?yChBttR99LPSRmolNAbw2p7aKFeonzvrD7owQHm5B43RjljjYRjd4wHopHpJ?=
 =?us-ascii?Q?ViY1fxWV+PKR03wL6aE+86ys/T0yHh44+WtqUmd2zl19oEzr09tSsJ++mqrp?=
 =?us-ascii?Q?iRTh6W/tnJw2scG0GEPqb6ldfv9R7+VCkJU1qPcHIdv8ZJC0m9TlXrAE7c4q?=
 =?us-ascii?Q?DD0vNs4AQ50zwxdKooRQwgUxV38HdLtUaj7+KnwUFSVhsuHlc37bAKRvqKaf?=
 =?us-ascii?Q?T7wxCbd1eOww11MGoEIJuZebsbPeKGqqwPWBRhYe/Y1EnVqiGkRY5l03lMFL?=
 =?us-ascii?Q?WqIMZ6FEmfiQ5b/sEb/dvrYyETQNjLqnzZiRmhQ0J1ERK3shRQJnPAq0Z5vZ?=
 =?us-ascii?Q?mVJ+rqyngrphTPyUo5CZo07Bj2tcHvxXVr7WALg8rQkQRJmTVePbC4qmSGxj?=
 =?us-ascii?Q?8bzONxY1yOtdBsGZm1FlPRfhbCRI9w/zSJ03Qr0OGvG8j0pWcHlvgozCvPHX?=
 =?us-ascii?Q?hO0XPJBdXQc/4FxvtmcXm9F5n+CVDzy4qiPtTLWPBgZRB0gbfGBQgwVzRYlG?=
 =?us-ascii?Q?JjKl3vnxRzZ6B42IPiMAxDw8h1Hn9xqdLpMdRAiv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a37bf9-780d-431d-1f04-08dd5b011b0a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 09:44:07.0472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UU8Lbvwp2x+0HQVUKXtXe3rhgqCmDm2iDsMbGj8rnisDGNhDsS99QwLPqdqVxSR/0Qfz+kmxhe4H+UNgyfT05Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9977

From: Shengjiu Wang <shengjiu.wang@nxp.com>

The irqsteer IP itself can support up to 5 channels and each
channel can support max 960 IRQs per. The actual number of
channels and IRQ per channel implemented in HW is SoC related.

For previous i.MX SoCs, normally only one channel and max 512
IRQ is implemented, But for i.MX94, the irqsteer HW is implemented
for 960 IRQs, even it only has 384 IRQs connected.

That means on i.MX94, the 'irq_number' is 6 but the 'irq_count' is
15, so we need to increase the CHAN_MAX_OUTPUT_INT to 0xF(960 / 64)
to make sure the irqsteer can work correctly on i.MX94.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
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


