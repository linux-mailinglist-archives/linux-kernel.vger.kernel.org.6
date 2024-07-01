Return-Path: <linux-kernel+bounces-236967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 617D091E92E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 22:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2A9A1F22BAF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C50617084B;
	Mon,  1 Jul 2024 20:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SQ9STMsA"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2087.outbound.protection.outlook.com [40.107.20.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D87716EB71;
	Mon,  1 Jul 2024 20:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719864470; cv=fail; b=Dv05Hx88hL87aUi92Pk84+y3ty1N0U8BfV+Gq6RHK0KqdhX8YGK8hUoczXd+mqDrXuZiRojPxXRkXwignd1MIpiBaD4ZwV+D4Y6yUJHREjoXsS6wqSyNcxcsPuhLfdQok0U3X8wCq8ZdqBgT43gijpHDBmgJj+ocnXDYkEozlSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719864470; c=relaxed/simple;
	bh=s6ubK/VeNjYExpHLwSYXNUJAvfb9IjAvCy9Fe1mGO/k=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Bk5za5fc2tR3Psr0XXPg5G3/JIgFATZqDkRFO5XLFzXwZdHU96fXCQQp7LMDSdacriYlrDg3AmAtJpElTFTPSpWkgAFslVKTFR38+UoiCpwWXA4D+BdyT3lQc6Ls8pd3wie8l9yV/G/mYevEi95ceqDS3K/jrmgn8OoP+GYzZxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=SQ9STMsA; arc=fail smtp.client-ip=40.107.20.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KguYqotxJyA+El/c1KkuEjfmPJGE4krw1p/pYSPVFOgpD+TcGA4jGlcn82HWssJl5l5KhdI5F+7/GQZyNHJniWVRVGp6XxyxWMascMgbaEGY+Oxtdqy3gOZ14wVJABuL9991jUZf+LdJlCfN14TqNR7NLKkgK4bhHQhsqUhOMvruMdPkQlwta3qhbyb+Hd6BJHFACf5o834ZVFBaNb0LXUmYM82v4yNTOU77bdgVPhYTidZMjdmPfvs9ZzwfouaEAiCJnoogvttb3F3RAczxB4lbwu3vhR/X8nF+HThPx5gqRHoqnG9auxa9XHFi4cTMGsccdAvVFHK4Nk2m9bTipw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCCRXHBpId2sMowzOwjcJlJoOKHF1Z6X80az2kNPvls=;
 b=ILjMWymcm3CcuyA33Mc4SwCgb+CeH9Il9K6nTcF5WYknkhZ2PCcSHI9H6fq8Y45NL5bLYur5c8x3Sl2ZjRH93cihjQMM8VoM72Bj2trylDISJWBiEwZ9Ki/oMxMJS9jl1LoVgp9sa0Y60+X5yW7aopxjlB09MKlpIPxssNXMrVBZqpnAQXRHQvY1CwgMzGtD1vWTOXQv9gfbunIdQOjGWEsTyzixJ6l/TjW4zwIYRe9tzJUXjLcXTinKjH4CAcH7e8AkhsS3f1O0eV/moc4QKTNZEeWmy1rC7raTSUDLFSsm5GKUSS+C/Z99CVn5QRFZUqpR6m9SweyZ0hlpUeRXiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCCRXHBpId2sMowzOwjcJlJoOKHF1Z6X80az2kNPvls=;
 b=SQ9STMsARUIV+wXdpsAgBthZQl3mOnnZ0qNap8CAOlul7RYnpBKPN/k/qTrGBrYcET0FpKLJs+4KnQb/bciribg1/Cz19CAMHlbst2WdIO6Q0qAMjWoUxNXC04X83wzX7Vc7QY1hio/LzMH0cVfPKbGwcefocbLhApFOrd/N3kk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8638.eurprd04.prod.outlook.com (2603:10a6:102:21d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Mon, 1 Jul
 2024 20:07:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 20:07:45 +0000
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
Subject: [PATCH v2 1/7] arm64: dts: imx95: add edma[1..3] nodes
Date: Mon,  1 Jul 2024 16:07:22 -0400
Message-Id: <20240701200728.1887467-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0079.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8638:EE_
X-MS-Office365-Filtering-Correlation-Id: 958ee150-bf22-4c8c-5c95-08dc9a0978b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AfjDgb9S8jQ2TJj4Y/dOY+7BecWkb6vA2PghvDs1A+0+QLwf/bfrV7nMuyMT?=
 =?us-ascii?Q?vxLv1roKo1EOgBjOOucShHQYKzxvgAZSlbMl4iT89SaDNedmKq2ZBo2m2WuB?=
 =?us-ascii?Q?XHdfe0DC7MWIPi8e9Tqt17ebg7sG17c8s4FpRzg/NIBPGw7hUFtBY7prGvMn?=
 =?us-ascii?Q?bROWL7LRxT8zkr5FqqvqhycRBtT25Emc5t/M+QysbPT5GwalWILQdg+RpaEW?=
 =?us-ascii?Q?nEJNdvFHJpES8jlxrhAf1kv2lSWzL5ClAjukL+JF5OLG9gLnRwJMthAf1jHT?=
 =?us-ascii?Q?Fpq1i4DoFGpa/paZKuQrax652hBdpBjhYV/KbUJh9FoQfaZE4UlJiOsdKEwJ?=
 =?us-ascii?Q?clyWbGMFbqEnQUjGYFO0L5ukBrRohzuOz/2iKI+7UGzAzrMVwbPowmvA/a8z?=
 =?us-ascii?Q?FVvSc1fTT7pLOV9eux53NcBEIODedVkAhUpx018DbnjGO5k1ShF6IZO5ptdm?=
 =?us-ascii?Q?rApJip68Lv9YRJI3t1sWdUoidzGbgchCOWMyC9T3tdSIz4cans9blDrX9VtN?=
 =?us-ascii?Q?byPtzZa0QHmOJJ+Q5BDueYKIyq9UVED0jP9hOuEaZ72ULcAtAFLx+UZSaz0O?=
 =?us-ascii?Q?Vnx8ovKBKOgEaEf+d108gE222ZpLJvfwGx18KjwhKmBAByQqpEeXmrwVfHvV?=
 =?us-ascii?Q?YbcALeJ1ixBsroX6+9RS9CMO4QRBtJ+Y7Go/nurDJ+pegv5KhQBZaJiASHpI?=
 =?us-ascii?Q?hACBHZsiEqklTE1egq+1YXNmzUZdIXH4KHxPEgF0vdVY4PcbyJ9zaGphREQ1?=
 =?us-ascii?Q?2/VgcWm2a7Vtbxoqm6GM6NbxgfLjp+Gpyjt5QvSCPy+anSujChyTpTeL1qdr?=
 =?us-ascii?Q?efQBS+1FbYezEYxn/Whz09chGAbmiRh87Rxq4hXLjqiFlTUTgmSDb+kV1wQa?=
 =?us-ascii?Q?VX6AsKjN4oXSZyLRkrs8S7zip8NpOz76lsGsXMRNHrhTCSR08XUleh+DZozE?=
 =?us-ascii?Q?i1F1X9fgSuIDK62cI4oxcrBpKx0TddT5qBPHF1eJURz8bDxeWgmVl0k34Wpv?=
 =?us-ascii?Q?Hi88habX6QBhuCX8CnP8OEJubSCr6hSno54MVUepWp5qlW764GjcP8PDcyvz?=
 =?us-ascii?Q?rbdbNK3tb1jFJo7CrJjAF996wgUZimMh7qIZ5K2Q5FnkiKRZvhRYFG7Jqpt2?=
 =?us-ascii?Q?o+/b+ACNJXYY5en/scSYvnmCnUCxYVu7OnKJcgN3IjAdRXM0oqCKOYlXb043?=
 =?us-ascii?Q?fyuvOLE/cMG8b4Qu2MqFQ1Dljm/QQyK43M8lxjWw2UrRVv5R+M2E7SCrwlmR?=
 =?us-ascii?Q?uFUIqqspPR/zAhxHNqcgnXs+sC9bx8KTkSHA+cONWgI38lJdv/VAv1bm1U3W?=
 =?us-ascii?Q?HWMREYYj2xXU09ADPzGV6x6GMx4XanlTxFgnsYE0y3zxAQgvKnE7oJsvxR5N?=
 =?us-ascii?Q?Bnug5omYtklZR2rZVJBFvXEtlj9Hj9ArhiY5pHU2GANzqvlrzmlQUJ6qu4ig?=
 =?us-ascii?Q?TPgPu1U1BtA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zbhE8Yr/gG6HfTsRMCGj34EUTAeoq9Qsmraf15v6Cm7HvAMwqiErOW0+aoXZ?=
 =?us-ascii?Q?Etr4XqNDRS9H7GCElZ4KSENX4c1gtpdMAuoByCWJRYW0NBjw4htwNBypMUmC?=
 =?us-ascii?Q?KWWWvQdAm7FS+hFNAjUtAiCjoPwGIsRFqhzg7LT/v8lT97tJlNKJF1FJB0t6?=
 =?us-ascii?Q?L7dS+gZ8pzzMGtmwbdEXDmh6dwJsDRyZaDGRJhLnYJAYRE42zobqGQKpHSrM?=
 =?us-ascii?Q?BvWv21xR0/q0BliLjHh3uleqBokT83gp7aVBuGQWqy3kwNdG3NRpW0ONdF0f?=
 =?us-ascii?Q?PwwbNR1fYA/2YQPXQh2KYux5XqbRne4CnBp1C5nEn/LKZN8ff49EVjRDA0Gc?=
 =?us-ascii?Q?a6g/BITwAMOR/sMOEaUYn/I3+LCM2XSTGp53ZZQ/fR+3A/nUT4suP1LThhlf?=
 =?us-ascii?Q?/Df9uoI0vO0P6CywiJs/esC1Fj1Pjx6mGQFrcUmFOFcNpqYMg+E99jElE5ra?=
 =?us-ascii?Q?GerwdxFy/C1i5KOB2hl74uWIh8HBspmJ5os1wTnE35R+9FBWoHh1fqororQg?=
 =?us-ascii?Q?0qOYEDGrMajqT3jfsE6CPE3e0P93aXYq1LWNS7AltEiD2hmynwxXJWtDgpOh?=
 =?us-ascii?Q?K/Fw7796lcbcf670iFvWULnK2e5/RW4bBGT/ApivOYU34TV/gTXpdDse3Q8t?=
 =?us-ascii?Q?VAWErnVdiHk/PBUvijx653KuOF355vcs55iEyBsbkdKnWnvTtaajs059g9zJ?=
 =?us-ascii?Q?f0EP0HoeX0id2H9KJ5bYT6xxXZ8O8yufv8/OcJxx9NEzFu/Bf98Ax3r+65Ou?=
 =?us-ascii?Q?DfxDQ4Y+C0sL97cO7l9ApVXdoiJq2k7l3nXrIhYiHu8QddONsFAZw1pOcaWm?=
 =?us-ascii?Q?uAsCGtRraRR2WdhtrHARc3iFcf7KwNJrpQvnKb0ENLx0sHLtJCgZ9TZEc3/T?=
 =?us-ascii?Q?j9NoHF0XaTgUzb/TwRSUPNMChtwzssxscxycNlQ14jKEZO8yg3waJRVdQSJX?=
 =?us-ascii?Q?LFhvd9b3mwq02MyWyc5cjiwOXWbZqdGFVzjkzpVKwSc7+S70H1qjCWWG9JzY?=
 =?us-ascii?Q?rW3ekaMMmSQwsuf+t/ZmhtNCu24OhTxywkL1gGj0BuCO+Cornt9RzbESI1eK?=
 =?us-ascii?Q?AjmNJfEtUwclsAkL1AlV1MxbLfadrRH60WIfM6QGt2Hj4PrnkO8hYqFo9emW?=
 =?us-ascii?Q?Iqb35xKnonbNxRwqeK8zf+ekvl67YUdZwoivVLnnY8MuC0GxEUSDYcKqF8Su?=
 =?us-ascii?Q?sdSGO/26bKubJ4/rX382oz8otXKJ2CLvCPLhgZZpPsu9SN9BDAys+hOxkZNa?=
 =?us-ascii?Q?Q8qxDijDEcmY7ywIbWAZyzcOL0pX1On+yp7BV0IDAU7nXGjLagob9MFwaU1T?=
 =?us-ascii?Q?QQLbTgwpTk9a/Ft1etbKkSXW4f+WqAY+nEX/uCygX4DfiFdhQQPyG+QcNXH7?=
 =?us-ascii?Q?x5/c0/r9vVUmK/oF6s9qbyG2NvHChOxoBVujpaovKca/z/q+UPhm9uHriY3/?=
 =?us-ascii?Q?agFt0NLzaioUsbojveIBB3bLmvD39hM59tB+xgZ6usrnlwhZxyQtGTq0osaF?=
 =?us-ascii?Q?oES/erIbsOqxnNgbtxst2KAw1M8P5/zcDTMQI301BADUrQoDXCI+E8chSrVK?=
 =?us-ascii?Q?1lzU8BKCMf4bmVDcuvTqEVQ4KdF85nt+Ry45C5jQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 958ee150-bf22-4c8c-5c95-08dc9a0978b9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 20:07:45.3339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x7oZQIeIaydzTsMUMkR6FA9DO9B0088OTRJlhRUSlHXZh2HstA2q1Hbf5ipH0V6zPCy9jQObY/1E/f17baqlGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8638

Add eDMA1, eDMA2 and eDMA3 support for iMX95.
Add dmas and dma-names for each peripheral, which use eDMA.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v1 to v2
- none
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 235 +++++++++++++++++++++++
 1 file changed, 235 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 1bbf9a0468f69..12f7ac52c2589 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -3,6 +3,7 @@
  * Copyright 2024 NXP
  */
 
+#include <dt-bindings/dma/fsl-edma.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -405,6 +406,152 @@ aips2: bus@42000000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 
+			edma2: dma-controller@42000000 {
+				compatible = "fsl,imx95-edma5";
+				reg = <0x42000000 0x210000>;
+				#dma-cells = <3>;
+				dma-channels = <64>;
+				interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>;
+				clock-names = "dma";
+			};
+
+			edma3: dma-controller@42210000 {
+				compatible = "fsl,imx95-edma5";
+				reg = <0x42210000 0x210000>;
+				#dma-cells = <3>;
+				dma-channels = <64>;
+				interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 276 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 276 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>;
+				clock-names = "dma";
+			};
+
 			mu7: mailbox@42430000 {
 				compatible = "fsl,imx95-mu";
 				reg = <0x42430000 0x10000>;
@@ -464,6 +611,8 @@ lpi2c3: i2c@42530000 {
 				clock-names = "per", "ipg";
 				#address-cells = <1>;
 				#size-cells = <0>;
+				dmas = <&edma2 8 0 0>, <&edma2 9 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -476,6 +625,8 @@ lpi2c4: i2c@42540000 {
 				clock-names = "per", "ipg";
 				#address-cells = <1>;
 				#size-cells = <0>;
+				dmas = <&edma2 10 0 0>, <&edma2 11 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -488,6 +639,8 @@ lpspi3: spi@42550000 {
 				clocks = <&scmi_clk IMX95_CLK_LPSPI3>,
 					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
 				clock-names = "per", "ipg";
+				dmas = <&edma2 12 0 0>, <&edma2 13 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -500,6 +653,8 @@ lpspi4: spi@42560000 {
 				clocks = <&scmi_clk IMX95_CLK_LPSPI4>,
 					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
 				clock-names = "per", "ipg";
+				dmas = <&edma2 14 0 0>, <&edma2 15 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -510,6 +665,8 @@ lpuart3: serial@42570000 {
 				interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&scmi_clk IMX95_CLK_LPUART3>;
 				clock-names = "ipg";
+				dmas = <&edma2 18 0 FSL_EDMA_RX>, <&edma2 17 0 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
@@ -520,6 +677,8 @@ lpuart4: serial@42580000 {
 				interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&scmi_clk IMX95_CLK_LPUART4>;
 				clock-names = "ipg";
+				dmas = <&edma2 20 0 FSL_EDMA_RX>, <&edma2 19 0 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
@@ -530,6 +689,8 @@ lpuart5: serial@42590000 {
 				interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&scmi_clk IMX95_CLK_LPUART5>;
 				clock-names = "ipg";
+				dmas = <&edma2 22 0 FSL_EDMA_RX>, <&edma2 21 0 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
@@ -540,6 +701,8 @@ lpuart6: serial@425a0000 {
 				interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&scmi_clk IMX95_CLK_LPUART6>;
 				clock-names = "ipg";
+				dmas = <&edma2 24 0 FSL_EDMA_RX>, <&edma2 23 0 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
@@ -550,6 +713,8 @@ lpuart7: serial@42690000 {
 				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&scmi_clk IMX95_CLK_LPUART7>;
 				clock-names = "ipg";
+				dmas = <&edma2 26 0 FSL_EDMA_RX>, <&edma2 25 0 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
@@ -560,6 +725,8 @@ lpuart8: serial@426a0000 {
 				interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&scmi_clk IMX95_CLK_LPUART8>;
 				clock-names = "ipg";
+				dmas = <&edma2 28 0 FSL_EDMA_RX>, <&edma2 27 0 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
@@ -572,6 +739,8 @@ lpi2c5: i2c@426b0000 {
 				clock-names = "per", "ipg";
 				#address-cells = <1>;
 				#size-cells = <0>;
+				dmas = <&edma2 71 0 0>, <&edma2 72 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -584,6 +753,8 @@ lpi2c6: i2c@426c0000 {
 				clock-names = "per", "ipg";
 				#address-cells = <1>;
 				#size-cells = <0>;
+				dmas = <&edma2 73 0 0>, <&edma2 74 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -596,6 +767,8 @@ lpi2c7: i2c@426d0000 {
 				clock-names = "per", "ipg";
 				#address-cells = <1>;
 				#size-cells = <0>;
+				dmas = <&edma2 75 0 0>, <&edma2 76 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -608,6 +781,8 @@ lpi2c8: i2c@426e0000 {
 				clock-names = "per", "ipg";
 				#address-cells = <1>;
 				#size-cells = <0>;
+				dmas = <&edma2 77 0 0>, <&edma2 78 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -620,6 +795,8 @@ lpspi5: spi@426f0000 {
 				clocks = <&scmi_clk IMX95_CLK_LPSPI5>,
 					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
 				clock-names = "per", "ipg";
+				dmas = <&edma2 79 0 0>, <&edma2 80 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -632,6 +809,8 @@ lpspi6: spi@42700000 {
 				clocks = <&scmi_clk IMX95_CLK_LPSPI6>,
 					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
 				clock-names = "per", "ipg";
+				dmas = <&edma2 81 0 0>, <&edma2 82 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -644,6 +823,8 @@ lpspi7: spi@42710000 {
 				clocks = <&scmi_clk IMX95_CLK_LPSPI7>,
 					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
 				clock-names = "per", "ipg";
+				dmas = <&edma2 83 0 0>, <&edma2 84 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -656,6 +837,8 @@ lpspi8: spi@42720000 {
 				clocks = <&scmi_clk IMX95_CLK_LPSPI8>,
 					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
 				clock-names = "per", "ipg";
+				dmas = <&edma2 85 0 0>, <&edma2 86 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -796,6 +979,46 @@ aips1: bus@44000000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 
+			edma1: dma-controller@44000000 {
+				compatible = "fsl,imx93-edma3";
+				reg = <0x44000000 0x200000>;
+				#dma-cells = <3>;
+				dma-channels = <31>;
+				interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_BUSAON>;
+				clock-names = "dma";
+			};
+
 			mu1: mailbox@44220000 {
 				compatible = "fsl,imx95-mu";
 				reg = <0x44220000 0x10000>;
@@ -830,6 +1053,8 @@ lpi2c1: i2c@44340000 {
 				clock-names = "per", "ipg";
 				#address-cells = <1>;
 				#size-cells = <0>;
+				dmas = <&edma1 12 0 0>, <&edma1 13 0 FSL_EDMA_RX> ;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -842,6 +1067,8 @@ lpi2c2: i2c@44350000 {
 				clock-names = "per", "ipg";
 				#address-cells = <1>;
 				#size-cells = <0>;
+				dmas = <&edma1 14 0 0>, <&edma1 15 0 FSL_EDMA_RX> ;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -854,6 +1081,8 @@ lpspi1: spi@44360000 {
 				clocks = <&scmi_clk IMX95_CLK_LPSPI1>,
 					 <&scmi_clk IMX95_CLK_BUSAON>;
 				clock-names = "per", "ipg";
+				dmas = <&edma1 16 0 FSL_EDMA_RX>, <&edma1 17 0 0> ;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -866,6 +1095,8 @@ lpspi2: spi@44370000 {
 				clocks = <&scmi_clk IMX95_CLK_LPSPI2>,
 					 <&scmi_clk IMX95_CLK_BUSAON>;
 				clock-names = "per", "ipg";
+				dmas = <&edma1 18 0 FSL_EDMA_RX>, <&edma1 19 0 0> ;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -876,6 +1107,8 @@ lpuart1: serial@44380000 {
 				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&scmi_clk IMX95_CLK_LPUART1>;
 				clock-names = "ipg";
+				dmas = <&edma1 21 0 FSL_EDMA_RX>, <&edma1 20 0 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
@@ -886,6 +1119,8 @@ lpuart2: serial@44390000 {
 				interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&scmi_clk IMX95_CLK_LPUART2>;
 				clock-names = "ipg";
+				dmas = <&edma1 23 0 FSL_EDMA_RX>, <&edma1 22 0 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
-- 
2.34.1


