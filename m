Return-Path: <linux-kernel+bounces-344853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C94898AEF9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 242A31F239BA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BDC1A2657;
	Mon, 30 Sep 2024 21:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hqVooCjt"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013061.outbound.protection.outlook.com [52.101.67.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABB21A255D;
	Mon, 30 Sep 2024 21:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727731589; cv=fail; b=fo0w8GpeDy8dPJKjjha7aL7a7eFf0XfpXT6AAbwVWQ7CGnGukYz/CFfe6/SI6jm5hw0LQSzHHy6taIBaoa28d+AQ8fJguPaDM9nr9Jq1PI2hA1tbyR/Wi6ADDm1EMrmga2icKV9uD8TBdLfGyWWrx55cRDo3UrSE4wu3EKMDPEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727731589; c=relaxed/simple;
	bh=l8w2g6G5IYNmzAemWU0DYb0QitEiAVuXLhbeYUjd/H4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RGF2J4sHsvxUvA0XMQ5Ju9+j3Jnkbvz9MSCHkVaiT2tmkP0OG1OZpm25cGVDSucycDy/rR8ZnHrHYTxByxeNLiRkCxEi7chGZ28J0zVkPxKzuMVOP7ei6wP6vjz3RhullKagCutsGulY0tAZQ6oHJC+sbsgO5rL0vQXQmFnsT9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hqVooCjt; arc=fail smtp.client-ip=52.101.67.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDeMyWbMhpnXly7liktLKmbvv2qs0LmQ/XteofuIOAfG7u6q6CXNN6MpvDmheMb/Lz+WcQDoC2gmPjm9EcxIvM9ykA9KIYDSf6pKdpgTVbXU5uE1wsHKn3mqpJEfVKP+pKRa7mvEsrGbfTjOG7DfcwEDKYLevBkDOgj3cD0yqo10NwMTxIIOYTjpW1oyvhLk/OETG0DWkvL5C4p0mfUF5tPzNicBq2KdqTpU2QEyOCCNZ86jFAHZmqd9pxEL7XkGMN1EfwlI47DCKrsraCyd1B1LoJh+cbmIXiB+hAbUQD3/auwpU7lJ2uzDDUZa7sG/2k3LeafWmEqOApwWtNIkoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDB+aVrP+AVnW9kt2EdWDtNEGhvgOvo0zG+tOG9OKlE=;
 b=KHQNVPpvJfU4wnjBXN6H9Tq7V7cFVMRyb08SMcUpvJBz3GWCSujA1u1Z91VfosKur980Ma/awgkDVACh41xfJ39SSHiAl+gP17/hsAfej7WPRiUyS3L5r5Vi4ypPu9DE+MaM3wbM+frDcSVz0DoqRIGKi6/BvmpiSndqZaktmNwdAq5wXklz7cCR9L7F7hwkkI0CEZjSjjZw1KSuW0YHVu8Qwy6a57PcekAf7mOm80lxDzWKNvtObyZ6D3eudpCiqPa1jOvp6UQCBBL0s4oLPPZ8z+YydCXnLaNPXv3XYXPymQfMox9axiyzlZ/eT0Lpb5cnjQYmYfWw6reOBaShjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDB+aVrP+AVnW9kt2EdWDtNEGhvgOvo0zG+tOG9OKlE=;
 b=hqVooCjt0X2Jk3LrZpauvbtT7HNgEbVfYLxRsIsKiY08PCNlMtL60kaGugudaoMHIE/a8pVo9XvEADJ9p2b98HpsQKxBWSuctGHjyQjugQN5+Km3jIkRlHBo5+5SM1gybcT0N3PMeYbjayLPRz1psBESfUHlFWMJlWgBo2KGgiy33xmw3hbYlPeZk7Syr+KweYhFHz3eVz8oZro8TGUcRv0AeVpCLHwWNNFx+C6qXUoQRkaGsKN09k32JHLcW+AuZUs64Xl4jcTcyu3y+45yXTtCFfO/fvK6nVOEuWD7ozfsYJbvr+ebc4VjOP//26QeTmDh7cSgtwRbDPQmA2VV6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB7601.eurprd04.prod.outlook.com (2603:10a6:20b:285::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 21:26:25 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 21:26:25 +0000
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
Subject: [PATCH 2/6] arm64: dts: imx8qxp-mek: add esai, cs42888 and related node
Date: Mon, 30 Sep 2024 17:25:59 -0400
Message-Id: <20240930212604.118756-2-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1a2ea2b6-8f7d-4af7-7b96-08dce196899b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2rDZbfS6rC+M+bcKr3olF16Xy/Q4P7NI3bQMdF/EnfpjATMpsPj8bnmyynsX?=
 =?us-ascii?Q?H8QTaqKDUohZn2v1JtqU9TH/GLxYQGbItTY0OLUAoxG9jEy9Fa5dx/xqoD9l?=
 =?us-ascii?Q?IDrFFXbWV/1E70qv02FBK02EOUvUCr00Tu5rr4uj844qB97GvRe8Uhkx8HEz?=
 =?us-ascii?Q?PnmSp38vioHQH3jYpaOm7ILKSpzT/x1CsjVA1C+QbtSDex6V+ElK3a5R+i3V?=
 =?us-ascii?Q?ygl2EbXD8OYo9JbQrVqAO/YZb2jCFXuFGj2wlL3xkCQMG73FfwsFeyQ5t2bp?=
 =?us-ascii?Q?ceYLHPyIcc+T4Dgfun/4X8Ta4PHoRUDlodKzm1io7NtuDFX+vbN5tuK9dJvV?=
 =?us-ascii?Q?QTYctGFAIoxehfOVv1ajhXcZ65UOO/LaMsrkxyPM3S84773DXlIMo1wBMpbe?=
 =?us-ascii?Q?+Fva3tfpIxYyDertayQceb6nrJHd6TOWYWEhA1GaeLOol/M4OFweDsSaMosH?=
 =?us-ascii?Q?urnguwA341bmYbPsSG5IUHFy7y1lRhVl8NAvItRfQqTXmB8nU6FoGkvW8TKb?=
 =?us-ascii?Q?oxaXJbs9N0a9oOHKoP5zAqJ6gqeQXyTAsoScF0uPX9UG6jVUD0IlWruyufaL?=
 =?us-ascii?Q?B8s3xRe1YaYuhi7sPxVJ/mi5VVJhX7pxdMVKfoxz7ZIBUFp4AgcHphT1KKgA?=
 =?us-ascii?Q?pu15ThV9zPFhx3wr6qa7NIDDh5vKeTUBwVyQm5FtK1eOFxc5lBWP9yD5fKDe?=
 =?us-ascii?Q?2yXT/0Au+ULy1Ih4V/uSuifM78x67D1AXCDxPqXyldD2VL5xMpsnzcg9Pr0O?=
 =?us-ascii?Q?qvxhqONXHr9qQQT767z9xZO52AG2AzFGeP2GEWP/H2wh4CrI2DUx9rkzOJce?=
 =?us-ascii?Q?eElDr7BQ2Hm9wXEgwQDE+fK2QcHZWl8Cg2CXSTnviPGyK0NqKNMbOklwWWDv?=
 =?us-ascii?Q?Pio3PGCxEPmWNNU8bk0yYEYwfW4jyaLkIWhPYMEPZ9WY7G6kuZzUMguFkdHv?=
 =?us-ascii?Q?P48XoXa1v2P9T4mumjzAZXI3yhPqAbn+wq2Z3P9RSnkCnxe1fHs63HBKKyXs?=
 =?us-ascii?Q?5ePBjN6o6IrrDmR8ofHaQ0I8yunwIXZ3O5UgDhkoRzWZ6GLz/t3aKboaCeEM?=
 =?us-ascii?Q?oDHsx6QKlz8DgCXcbX4pXlS4tUgVQWrztJZ9YaahmeU5gieVNTzuBVN3ucUs?=
 =?us-ascii?Q?N3W0Si9jW+GCG4Klx1ibhizkrwn5BXExeb7Wbz8ZyHUEMKuiNXBtPuQsFNRb?=
 =?us-ascii?Q?ErPr6IvRdBtki2uomppg9IxmasIJ2wMZ4oNlHS3gQfSlV9I4NiXbJGqGtR6X?=
 =?us-ascii?Q?ie/Yje0ujOblJE4ksAbFXEOJqsYyJcHJIZj5dIugmcQMoBl3ZI8xH8uBvKRj?=
 =?us-ascii?Q?tSzBMuOuoWulZ1+OhPeNzNS/1+WN4n+weNRxDNjpwQum1kl412M6GioAlNII?=
 =?us-ascii?Q?cB6+bL1rjYfKoBdPL6ECPK4n3VDUsEY1siWQp0fYnVHJCJpYUbmr6XJzoCIv?=
 =?us-ascii?Q?PvGzZESxDDI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GqA/l8qQkFnb35j7HZmQ6mul4NfO37hsFRCu1fxoPUHtGwKv/i9P10h3P9ID?=
 =?us-ascii?Q?Ybvl/FC09NpVyHMpDWnnxJkHSiakN5LaVGw5G1mHR4tnOZZx5xFQMiC7eUXc?=
 =?us-ascii?Q?CPtLY8PgV2NTcKwsMTIVICMMsqnqDnRip5xoOqLTNeCLezlOuuabaLxb3w/T?=
 =?us-ascii?Q?pwWynzKPBCPqJhyQdpkpxGDwOtRr2pRVRLfotR9vzXOSwzKW415X9qrV0g/g?=
 =?us-ascii?Q?Cg8xhdNVPR5pacg+kjkwSz6bL9buQiq7g4YP5nQuVlTTrcJgvNH5BGznn+NH?=
 =?us-ascii?Q?clPC2S/mtBsX9nUbcQ9gCPhqOCJp+hseVliZfbTzV7Os6y/4rOUBB6Q3Xaim?=
 =?us-ascii?Q?xYUvMCm/iT5wRtf9v92oKq8TUKBkNStDuPScJu4gtRlk6ZC12sH8tGtn0jU7?=
 =?us-ascii?Q?ryb5FZhvXdJj1pEc6WXS/9+66HLiI7gROfLvad6ByB71TP1q0BPtnYqnp7m8?=
 =?us-ascii?Q?8fRIxPxe+5uX2m5BYyU6FajNp5FpVO9ZLfSRKZa8/OXkq1f3izSCFDwUKvik?=
 =?us-ascii?Q?POs/E0cZOEMO2y3i5MeCwBWSoswCFuF9q1ujTmzA43AyvDTef/YFE6VuHquU?=
 =?us-ascii?Q?f/tOsgjqkLH//wwfAdUQnjAZ3LO+C07TL+DknHOvS7UFh8avvrZQmUCj2Gbm?=
 =?us-ascii?Q?fT+K/Kh02hInAI5g1Z90xf5xQ3nn0aSZHRaJQ88uusXvWIQoHU5oGdqdlCg2?=
 =?us-ascii?Q?IjcH9QAy/PHAoCci0Hn55WhyQZdXRYGNimFIiRTBNjHim2wjbxO+cL5As9b8?=
 =?us-ascii?Q?cZVYdBKrGrNNkiFDZ+yL2nfGdvlq3ZUDaJRnJAxply9ZkIyDQYz8HTeeJaBd?=
 =?us-ascii?Q?XexsU5wa+OdbiBzSi0wFureYBhfioOA/qCOgkax5dsHN5ujths6mc/EesKOp?=
 =?us-ascii?Q?tSgsKp7j+DmENHWUWroR/pAxY4mVTE7rKZQI29UN9Svza8uV1xMepdv/Q5yW?=
 =?us-ascii?Q?iZKd4mgJnR5HKS8kYmkVgXjHgXp6KhI7An/nyvjiDUOEd+eV+BoYOweeKIKt?=
 =?us-ascii?Q?X6lF1V2jW+zPLaw/124y95gVzhUuzAVKZ9yRVLe8ISVd+3T0osSKUL4J+Ha8?=
 =?us-ascii?Q?awOWG6gCeemn8hsPSEiWSvILX91oOViHcejeHld3odccw5pgORtujxi1nPq2?=
 =?us-ascii?Q?aojpkY4LlAsL/kp546+uyqoreMJ6qei6uB1ng4KAnhN9Xovv2o0Rd513bB12?=
 =?us-ascii?Q?6kg1JzaaIYka0H0E3M6q76+FaWPpr4nQlfYDZAiGAlOA9XRfDrYf6/Whg3W8?=
 =?us-ascii?Q?fbuNfrbA5BAyVcp2b8HMHaClO1MTRwQlTYauVZkImTsaJPp26qu47okbAt6u?=
 =?us-ascii?Q?cR9aLK9fOui7+QBf5YDiFswKi9AS7C2Gftha23ex0sGztaT29ZL9TP6LREh3?=
 =?us-ascii?Q?rqUy3MF7vCmLZJIq6EPyQoyo7gYnJ2nQSKU5nY0Bno5DhkFpD0JYCRHTWWiu?=
 =?us-ascii?Q?HUBa3ye2mR+b688B5qMNjlVu2BQQ2UuLjFQPRc+5zoNv4R/ADTRDcfC9NI6J?=
 =?us-ascii?Q?v6Nq9tsnZnNJIIhvmziw5+USzYb9NNzVp4HCaQlUgb6C/4+nrRh0fAN4rFEU?=
 =?us-ascii?Q?xuP9qFSg5E2Hk6VRcRw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a2ea2b6-8f7d-4af7-7b96-08dce196899b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 21:26:25.1708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 32y6pMZxXU2WzhXtB3pHIIXFv5B9JhLg8XblSJF8i2/kgRq0bF8ozFmpjFwUJcB2CVp+3VSaQRwOjHYJ22ckQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7601

Add audio codec cs42888 and related node.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
arch/arm64/boot/dts/freescale/imx8qxp-mek.dtb: esai@59010000: Unevaluated properties are not allowed ('power-domains' was unexpected)
update binding patch already sent
https://lore.kernel.org/linux-devicetree/20240927205618.4093591-1-Frank.Li@nxp.com/#R
---
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index d8d9e2883caf7..9b9ad389a807a 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -50,6 +50,13 @@ usb3_data_ss: endpoint {
 		};
 	};
 
+	reg_audio: regulator-audio {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "cs42888_supply";
+	};
+
 	sound-bt-sco {
 		compatible = "simple-audio-card";
 		simple-audio-card,bitclock-inversion;
@@ -69,6 +76,28 @@ btcpu: simple-audio-card,cpu {
 		};
 	};
 
+	sound-cs42888 {
+		compatible = "fsl,imx-audio-cs42888";
+		audio-asrc = <&asrc0>;
+		audio-codec = <&cs42888>;
+		audio-cpu = <&esai0>;
+		audio-routing =
+			"Line Out Jack", "AOUT1L",
+			"Line Out Jack", "AOUT1R",
+			"Line Out Jack", "AOUT2L",
+			"Line Out Jack", "AOUT2R",
+			"Line Out Jack", "AOUT3L",
+			"Line Out Jack", "AOUT3R",
+			"Line Out Jack", "AOUT4L",
+			"Line Out Jack", "AOUT4R",
+			"AIN1L", "Line In Jack",
+			"AIN1R", "Line In Jack",
+			"AIN2L", "Line In Jack",
+			"AIN2R", "Line In Jack";
+		model = "imx-cs42888";
+		status = "okay";
+	};
+
 	sound-wm8960 {
 		compatible = "fsl,imx-audio-wm8960";
 		model = "wm8960-audio";
@@ -86,6 +115,15 @@ sound-wm8960 {
 	};
 };
 
+&amix {
+	status = "okay";
+};
+
+&asrc0 {
+	fsl,asrc-rate  = <48000>;
+	status = "okay";
+};
+
 &dsp {
 	memory-region = <&dsp_reserved>;
 	status = "okay";
@@ -95,6 +133,19 @@ &dsp_reserved {
 	status = "okay";
 };
 
+&esai0 {
+	assigned-clocks = <&acm IMX_ADMA_ACM_ESAI0_MCLK_SEL>,
+			<&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+			<&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+			<&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+			<&esai0_lpcg 0>;
+	assigned-clock-parents = <&aud_pll_div0_lpcg 0>;
+	assigned-clock-rates = <0>, <786432000>, <49152000>, <12288000>, <49152000>;
+	pinctrl-0 = <&pinctrl_esai0>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &fec1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec1>;
@@ -264,6 +315,24 @@ pca6416: gpio@20 {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
+
+	cs42888: audio-codec@48 {
+		compatible = "cirrus,cs42888";
+		reg = <0x48>;
+		clocks = <&mclkout0_lpcg 0>;
+		clock-names = "mclk";
+		assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+				<&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+				<&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+				<&mclkout0_lpcg 0>;
+		assigned-clock-rates = <786432000>, <49152000>, <12288000>, <12288000>;
+		reset-gpios = <&pca9557_b 1 GPIO_ACTIVE_LOW>;
+		VA-supply = <&reg_audio>;
+		VD-supply = <&reg_audio>;
+		VLC-supply = <&reg_audio>;
+		VLS-supply = <&reg_audio>;
+
+	};
 };
 
 &cm40_intmux {
@@ -458,6 +527,21 @@ IMX8QXP_ADC_IN0_LSIO_GPIO1_IO10				0xc600004c
 		>;
 	};
 
+	pinctrl_esai0: esai0grp {
+		fsl,pins = <
+			IMX8QXP_ESAI0_FSR_ADMA_ESAI0_FSR           0xc6000040
+			IMX8QXP_ESAI0_FST_ADMA_ESAI0_FST           0xc6000040
+			IMX8QXP_ESAI0_SCKR_ADMA_ESAI0_SCKR         0xc6000040
+			IMX8QXP_ESAI0_SCKT_ADMA_ESAI0_SCKT         0xc6000040
+			IMX8QXP_ESAI0_TX0_ADMA_ESAI0_TX0           0xc6000040
+			IMX8QXP_ESAI0_TX1_ADMA_ESAI0_TX1           0xc6000040
+			IMX8QXP_ESAI0_TX2_RX3_ADMA_ESAI0_TX2_RX3   0xc6000040
+			IMX8QXP_ESAI0_TX3_RX2_ADMA_ESAI0_TX3_RX2   0xc6000040
+			IMX8QXP_ESAI0_TX4_RX1_ADMA_ESAI0_TX4_RX1   0xc6000040
+			IMX8QXP_ESAI0_TX5_RX0_ADMA_ESAI0_TX5_RX0   0xc6000040
+		>;
+	};
+
 	pinctrl_fec1: fec1grp {
 		fsl,pins = <
 			IMX8QXP_ENET0_MDC_CONN_ENET0_MDC			0x06000020
-- 
2.34.1


