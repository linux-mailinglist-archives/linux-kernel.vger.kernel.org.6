Return-Path: <linux-kernel+bounces-421292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EEA9D892B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48022284CFD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6001B412D;
	Mon, 25 Nov 2024 15:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ujx6U0RQ"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2070.outbound.protection.outlook.com [40.107.104.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A872B1B3935;
	Mon, 25 Nov 2024 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732548206; cv=fail; b=o0hNYAD9tW7FqKcr4PMQiLs1rQuH+BTbbcBLdCGg7k2cx2HG1OHfzQYH6J5+1ybYH9S4Q5EjbqS/DS9TLZ30PAfkAsy8nfWro9ckbJlw0AimSMmsHSrqYVKD8ZdHnbdqHiz0/kptlJOsc3VKVvf9XwEALz3znZ4GiGf9rcWe6zY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732548206; c=relaxed/simple;
	bh=jFsliURGOA9gzY3Cds/a7Tjkgu68NQA7A/EZJoS4aD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hgSiWE+FbJJ6hXnLy2LXEHr4o8kmeIsLC/Zoo0yjddCdXIWtIArEbKrT8n6luUaX9q8ad6+FSU/cdVWaR8VWqC6mz73S3AAHWjfZbzYCbGqpUJkc8yVFwViFDZ9/ktEesiqkfiGRlm6pnraj6RT580w8qu5M5QftmJ3CKr4MvHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ujx6U0RQ; arc=fail smtp.client-ip=40.107.104.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBnC1ys22y8r0D1GoXMHY4JOk3KEJd+4rzd0kKahiqCKiVZDjx3/54Nnw44KteMiUI6dEnghgHBc9FjbSZL9klvoCuUxMHG0a6vE7TM2VzgOEz4Tg7jHIMeA0LLN/KBKypGwVurdGkLXePYQjq6yCW1ouyA8qs2IOBNipKw2iiwns1CQ6PfvtGauWCJ9mp27EdC2JahDZGDS5kjZs+f7oXIN1lvVzzrHZ6PredK8YO39gOaQflzYjK2htz0qQfAd/zAkeV0eNkuKo1RyXUZQOi4nKn9VSsclxwUJlmgmkfOlUEhxdGJ5iFOKKsGfBqFqVuP9gNgkEPQ2mhaecR8jOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHs/QexNsI87nfrFEjGqp8PsuJswXpphxUyvrR/OBvM=;
 b=UJavbLD0KRTgx5PQewu302+rNeJs7ViIJl4rpp72MUMl7FMvFQPFqDEmRUQLx3M8ntqbEakUg5HbOkLgywLqiZ8hcQFimZ2Cb5bCcXCv6TeqOPLR1QzCKa+lp8XT20OEWkqfWIE/5ztMVMYYdmu/QfgMzs+apmJRdEOp8aDgkfKuXqPvj9G036/n6AE/xsQKq1JBsbLHK2jaErisqjhSLVhnY0Uxujp9LMhHGVepdRB6LeVDI/0zxf2RT+coD+p9L/txbGufSzOHtas3Xc+oFcqf9Fc6QHBOuTFgV8s6SnW/T5jLrX2DD9El+FvCAhHJoOeEaoZ8miI4WAy8oi9qBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHs/QexNsI87nfrFEjGqp8PsuJswXpphxUyvrR/OBvM=;
 b=Ujx6U0RQBtAJoextHmITcrGs3lDzlNMIyF9q8ydwhi3t4+UF+M2zazn9Av5rgWoKbrCXNDpMBM8yM4MiKBObXZxm9aq0hyqWNHXGbozsqQqbdWZlzRMKMOkpNBKHb6NWFu7aAjr70Sc0kiblJTCz5+cL2ig0Err62VawIDTdrNbiiyIjtmEjurw1xaf8TfgfG8y5h0PvVOsG2Rxe3TrOcdYDEUzRpt4blhyCmtzFYhT2PVjRvLJIzx5bqNdL20scB/le/RlwW05c5qs5WYX2coWsXkmYe5cTZ0fiIwHUY3TgQgC7fyawvvXRYEZ39wKWI43TTnZnC5NF3VAbY9fM8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13)
 by DU4PR04MB10886.eurprd04.prod.outlook.com (2603:10a6:10:580::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Mon, 25 Nov
 2024 15:23:20 +0000
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6]) by AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6%4]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 15:23:20 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de
Cc: robh@kernel.org,
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
	Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 1/6] arm64: dts: imx8mp: Add mu2 root clock
Date: Mon, 25 Nov 2024 17:24:21 +0200
Message-ID: <20241125152427.136883-2-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241125152427.136883-1-daniel.baluta@nxp.com>
References: <20241125152427.136883-1-daniel.baluta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE0P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:a::13) To AS8PR04MB8247.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8247:EE_|DU4PR04MB10886:EE_
X-MS-Office365-Filtering-Correlation-Id: c27d16b0-6eb1-4a6b-f394-08dd0d6517bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/QYdyNGMFH1AcE2mCoQz466VL6BomV2B8lckwcmwbYabt5vwu+7mV9KHo8mQ?=
 =?us-ascii?Q?1HdtEoorzNmzCPAmwzZNt6li0sTfauqEex1gZas0prJQ27TYHcahUjOz/WTg?=
 =?us-ascii?Q?32dqHjuBN01pLdYLBMgill1aMi1f22gf0aXQDxtNVxmL+ARwCI+DhOaWXbqI?=
 =?us-ascii?Q?wM7QY/pJtvf/XPieFLHbFbf9kinN8ErOBOjn7XApgmTyJuGHyrZz6G1XJulW?=
 =?us-ascii?Q?YwVmzwJ8OgtjETMVL6iFmXPaYuBTlW4y8/pd20ydUN7AiCy39SAwiTABt6Ny?=
 =?us-ascii?Q?MV2cDAvuaiYlB4Lh9C/hWoZ6k5GHC/BIvwYoOAk4u/fPALmCnBq2o31JLZne?=
 =?us-ascii?Q?NQ5EzQiMY5+1xmarMMjnuUQR2KUEbA9cduFL4jFKFreualhlLg3gqkeqc3ev?=
 =?us-ascii?Q?RF2TVgJ8eC9ZaqgC7DMYCoIYG/DmS3bgLhEFGo6cs0tfnJw6Qh3KXaZqohmm?=
 =?us-ascii?Q?ZUbFYFFEdPjVCcnla7XPfsmVP/Zw7+tJNQQBV16Hlh+QZTdQ5j3p6gw4+EcT?=
 =?us-ascii?Q?1In/ab7bkZuxnuBXe4Jy0uivMPH987m/o/Xn9YpenrGHS8zUzLN3vgARzc6M?=
 =?us-ascii?Q?gllcKq/2PP3NnLIUjxKX9ayTiuOXfy5B3jn/g5Ly8Fj8ENKdsoVtgJTLE2Xr?=
 =?us-ascii?Q?7tpVPP2p2/nWMefezFe36y5fI68y6vnTEtzrJeDrt1xGVDIRyhBrILHN2SFC?=
 =?us-ascii?Q?n+xQBHEO9U3/FiIHX8Ywugz4fu3/0LQVxVl+sjAV6n/QFAUVz9QaTkUThpB9?=
 =?us-ascii?Q?/TCJDsXdPToAbusbi1K2zp9i+c7AhEkssStshouDmSTcxGjYizdzLwQT2vsk?=
 =?us-ascii?Q?iw6WicFI+P7s/sZuj5sp+T82acGsn+mRXOTfxRQwVyVax0XL3j5MQDQziLae?=
 =?us-ascii?Q?KavNfRsAAG3Uo/HlFxEaUJrY76KkqMfp8eBUveB1mn1znAlZApIMrmxSmoWD?=
 =?us-ascii?Q?xhducw1IWwWvA0Qi4AJ2yprciv2kH5ceOfYAj2iOnxUApPazw75G1960g9h+?=
 =?us-ascii?Q?9TDcsHiNv+LaqmWuOOFhjkF7nPfFzN5G2asPXr7Z5hmTQpaXb+wVwmFVlrZp?=
 =?us-ascii?Q?tGHHrvt/3aLwb8GD+qhuuXAz1S8unH85jx/8/1gaIeLqkBCRF3R27bRCKmG8?=
 =?us-ascii?Q?DBApdLYsgMJo5YAyQwHb9uyNx64Cgq1aN82eLX9EhXf4uPdUYj64JXGEKj1l?=
 =?us-ascii?Q?0roqo67vvhzHA+J89IH9855025ghFSf9J4IlY+7Bk9R+aveuietrVfBaS0bA?=
 =?us-ascii?Q?7Aq+W96olhwXETOLdbNKIjDMKy0AbdfEVwRR8iJ8zHkTTANO7hr+wO5crcLr?=
 =?us-ascii?Q?aGkSh0fGluI6M/3hxPng/k0Ll4BoF8jkdGrxeHDlY+vcrPYO3R5RVqokmY2B?=
 =?us-ascii?Q?C10//JbJpO18NBGdfCBZghb9obcSJa5hEDLK42FUfDwCkOD4DA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8247.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KqxCLHF2JAvJ1w8aRwqm6FDtpj3SNao01JBX/PEE8TCD8q20pgm8lUd8yOKs?=
 =?us-ascii?Q?KkhBYdwa28CvbFBUrEhFLmavO4IW7+QXOQ0ybgCDs9DZ/6NSza+uoE/FN5vP?=
 =?us-ascii?Q?XWRFW3CrTY3Mmt4cGRAILc3B+tTswqOfbTzdp3tLUeyN3fymHDOe74XnrfQB?=
 =?us-ascii?Q?Kr9Ga9BKjxoqUPmygSTkUC+LjPe3NDf1AkSzS1FCQrvHspV2wngkPoEabl+m?=
 =?us-ascii?Q?bUTwrVwUbelOWz4a2RFDmxjDaf3Vsjase1ixASQ01lkWZ0PoAzU/vcopgICu?=
 =?us-ascii?Q?IqZMXrhMiqPTJpEke0ksJD8Ag1n5oCA85EKQOzCDNobwuNO828qYSTlLmQmr?=
 =?us-ascii?Q?8QsiKYNA0Nok5hnku6WVNnkjiEJ7+i/EzoVtR8SmL8mHPnDm8hkTGi5GuQbr?=
 =?us-ascii?Q?SHztcaq9+jvZ1dTlH5czWAikk0vwRbgk7X2a3LPDAVR+4mc3bFfnQ9GgGw0U?=
 =?us-ascii?Q?F6+h5sM6u/zjPpc+T6xuuK3sSD+o5hQFmgt5Gc9e+EyGgixNmVn1Ud3FxRfp?=
 =?us-ascii?Q?qb7OcR6GU1Kb9LixFYsTbbAHldRiNiV3OHFTQBLFJGY3Zj2iugLSKSYEO7a2?=
 =?us-ascii?Q?3Ls/zezp2/0kuRBrfd9v7Mw2iFiNIN8lA8kXJ5fUFni4UYl6kD+DgaqfYBkb?=
 =?us-ascii?Q?kZpZCFLWQjD+APH/kzQkVzZGJXjhx8W9PCWXy19qpDWZ2AkvNkvd5htFrgME?=
 =?us-ascii?Q?LfLEAdNP08JFfsPfBYtjMhEGPV7QG0rsUXnpFhF7+VKkF3Z2aFvx78g5JMs1?=
 =?us-ascii?Q?GlZvGDGbrnsnpmTBP7MepNMdwV5toHNWPwG6zohiNUvSqQjl54t9d+93Zhdq?=
 =?us-ascii?Q?6YwZ2ZmHCfZiiIYXoxOnE9ZNTCcfh/lBUpjm8LWACnrAcg8ls8AJlDouHpIU?=
 =?us-ascii?Q?ksER1DZHLiHmqd71Vud6XS6+TOl52kBO9n9FGPZcMMRFEQffPPWHAywbfXAI?=
 =?us-ascii?Q?M+zmy01yHwHUmAPWPMszyoFwyiZV2AVI8949FBbXfl0qbpYN4jMttQhBHwos?=
 =?us-ascii?Q?Mx/2m/WmZL9zuyIXjYE2op1hbl2ykz6AYx5bnpoRlMM3gegeJyPCGfUG/p58?=
 =?us-ascii?Q?y7iQfB20y0CAxD1ArMtr+1NrGquvFCsDlnnVJzIdchZy3Fg4mAvYwfvzrKOz?=
 =?us-ascii?Q?aT/Uu/ahAnL/a5BGzRj4whU4de8abJlWF1NRC+8rtXu7TtBISWoM28J+L/os?=
 =?us-ascii?Q?M7lg0EXavBi4Vun30LOfVggXBYQP1L4wKdCF1RL1qXXX28sxr2r6TI2TljkY?=
 =?us-ascii?Q?Om7KL7s3oxfnyOYnjQnFPAvHgK5s8STbEtSkLAA8Xxixbvz/39YSbOX2xWHR?=
 =?us-ascii?Q?9SwaBFLUct5B4UInBsJmamPO4xB/vwYxtr1xhKIA++I5tLSscZ6ABg/joxhS?=
 =?us-ascii?Q?mR7YCUvjvdPJsNhaGpMe7ocaB6d36rtfgS12z8/64r2hb+TRp7K71xDFkt73?=
 =?us-ascii?Q?G5iKgA+T1dFwp+Pv0zgg+tB9cL04C5q3eneFShpWrCOCeYBPEg42/Clo8UGB?=
 =?us-ascii?Q?cP+qfBKO/gj117wLc34gDYtZ7rnf7X8amTVAi/JqBM1bWywgAUM0r1wFNtQl?=
 =?us-ascii?Q?rOHmzi4PyH8Zl6Il/m47lGFI2fH/dWx0oLEbj7O6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c27d16b0-6eb1-4a6b-f394-08dd0d6517bf
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8247.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 15:23:20.0258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AuxGxWzsqaXpqNcZOvoIzxoL4TZOnXizjctZrnCJuZ8GB3Y1SogrQ8mIfTN91MANf3Hb3iemJa5Yn9IzO5nmXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10886

Enable MU2 node and add mu2 root clock.
MU2 is used to communicate with DSP core.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index e0d3b8cba221..00924e0836db 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1252,7 +1252,7 @@ mu2: mailbox@30e60000 {
 				reg = <0x30e60000 0x10000>;
 				interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
 				#mbox-cells = <2>;
-				status = "disabled";
+				clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_MU2_ROOT>;
 			};
 
 			i2c5: i2c@30ad0000 {
-- 
2.43.0


