Return-Path: <linux-kernel+bounces-247292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD46C92CDAE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84DEF1F24F92
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226B817CA14;
	Wed, 10 Jul 2024 08:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nwmNI9AE"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2056.outbound.protection.outlook.com [40.107.104.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8875C17D35D;
	Wed, 10 Jul 2024 08:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720601812; cv=fail; b=lSsuUONQeT9fC1zC4noMbVULAneH7c6AKICbJoF9SXj+rvKzI2gfvL4vlmu1ZOUP7bbwtdqAIGVF7486HiQQBkC8/q4OKEDhZBVd6eGtAItjK1MPGGQfQGy4pVve8qgEIrDNHyNn2KGJL7fya+Rj8qhbwVT9Ogt9UOaz/Jf0/Ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720601812; c=relaxed/simple;
	bh=ZJztUT1hcONg6e6tHli72TZEArqAFVRXfv9Z/nMwyiw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kX7xU7amJfKyMhM7/7YyoxZz4sQJr0rvnCk0wBkwaTksln89GWmEwN60DFnvPhGA9ULua+MrqUZISIFkxxF5NSYc/TBrwJ6sjzMYKSpnqy1AU710yoCaK8vFRm9fpZPawO1knC7YdCXjxOH2hqlX1fePOj0TVwC29wbm+jTIPpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=nwmNI9AE; arc=fail smtp.client-ip=40.107.104.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XyJ2g2z+VeGxfGSqf/g/lQHpodK1EIwU4hSMCMArUDUOLoqsfUctwIkuYNZh8Ej9nRga7cdM8MvkgjpGX//IwYJcVWiwC6dJIRnMJmCppmu13TBos3p53AbXzcGyLH+eYp0VFHI9ZCKOIPKDE05RlgEHS4Tm6d2Md24lTVsACGBuG+hilwD7cpqXRLnOseqyAa7l0Xj6N79ACsbKbrym44gKpYp9cpQm3lBR7Wj7gWnN5Yz/w9peRElV8CEUcL34p2mb1fOtju9VQyI56GffMxkAwYQ5o1B1gm1YrgCcYd2ecjEVyt2LkFajB5JokZR53ttWUc6WXhD1PvW865vLew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=illhekRzRB1muU9vg27w4ONaFFi+YPeoa4W7X/v8Gxg=;
 b=m6YbtF8Ai1iEm99du4E3ZbPJPpuM672ZNArcuQOqBu7l31py5h8fyN8AwaaGkAMkTq5cwDDQJHKuBjlxS1ItJ4+ZlsVV7Qdn8ppteJgQMoaOSrgdfS9U/KDhxpv3zkau/BCsA125ivQzByrffUHAhnCM8WiLa8zMr9B0xXPuMf2cIbAZCUoVmChzxMklikyYi0XUV6WJfMdpHFpTTtNcIcFLGaD2OwE09EN5sqwENJPnkwYnMA5D2oml6XDHutEE7Sr14a+bGhZ5KdgrG7ctbwyTPoIVO/SAcHiEq5I7HASn941ovIr27CN7eOdjW5wKci5BbTYwSTPG+Qk7Sqh8FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=illhekRzRB1muU9vg27w4ONaFFi+YPeoa4W7X/v8Gxg=;
 b=nwmNI9AE8tK+tXAj27xz/EvDnfC67SmO1CELqOb2AB93Aywi2me/9e+8AFvzdEAs6EzgP/dtRw0qWN1460lbCS2jeS01R7bmYEeXDgX4099IAZqPNo6cf80uO5hiqZD5UELAcK477SoJ5q6bDAIQjbRPj0MzuTIRTARaikyLjro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8580.eurprd04.prod.outlook.com (2603:10a6:20b:427::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 08:56:47 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 08:56:47 +0000
From: Wei Fang <wei.fang@nxp.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	abelvesa@kernel.org,
	peng.fan@nxp.com
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] dt-bindings: clock: add RMII clock selection
Date: Wed, 10 Jul 2024 16:43:43 +0800
Message-Id: <20240710084345.2016687-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710084345.2016687-1-wei.fang@nxp.com>
References: <20240710084345.2016687-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS8PR04MB8580:EE_
X-MS-Office365-Filtering-Correlation-Id: ef2189fc-8db4-42f0-d5f8-08dca0be3ada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uaU/ATmAoiTol/GlCFRL/TRI4Fz9tya8EVeCQbXuilsOb9HKqqQW/SmJMBEs?=
 =?us-ascii?Q?lzDIMovqLWxX6HVyeIQIFbypLoCORFjsWdosVAR7JjqI6tQ0t5S+t/0IyfZq?=
 =?us-ascii?Q?P+QUOWyvCIT5I8M5ov3vD7s5dpkRdr7XqtJWBLnCPLVHCOMN9OkWIuPyykrp?=
 =?us-ascii?Q?MiLHCEy/dpMr5mvcsrvzlUv7Jjn+WNPlWNZW3Z3+K5KGgO+siBYXfNkqHTJr?=
 =?us-ascii?Q?mzog+3bcPc1ej7WxGhTk8LyWyNHrqgWSFFIGjYcapQfwGl2Onxuuwa6yxGRX?=
 =?us-ascii?Q?tmVJxJ5zZ2W6lFTStMU/fOwN0VKl1DTk0uCYK0HFn5+Xwv3pA+WQ6iuH32P1?=
 =?us-ascii?Q?6e6bplndkS1SxD6NmdKyqXVprkFmPrLC7qjhexGNf3y+xJnN/xZiL1wenpio?=
 =?us-ascii?Q?KSbt6vvZrM85FAPG8/rM0ECSbaJjU7dn+Vx8BKrkMruxcfphHZ3p9FTToGB1?=
 =?us-ascii?Q?0OPbifQMQicLAHpKfR1H9hdrXusNW3llSWW0/L4nYFIPuUcX7N6i3at3EJc/?=
 =?us-ascii?Q?ExR65lvShHhH5Syr762c4o0g9U4PzOFCrMPXgunBIMa6zspHtxykfO6mvGtK?=
 =?us-ascii?Q?3Me3QU64W5QSq75apu+AyJ5k8z9Ixjg3ZdokuwDPAuZAuRmMo32EOoZKpFmf?=
 =?us-ascii?Q?PO32MJSbZntuLad0U5vJuJCmRCIpwmMFgXDzsyHhhnC+VpmWQNGEdT0YSWFj?=
 =?us-ascii?Q?Dg7/wBwpJLC3pniqQWl0KxtvAqwUj438DI59dUw0zxd8HpZEs5SApjCthJ07?=
 =?us-ascii?Q?6LkOZHAgWTPoc5YFhawf+JqhfRmbVmW5SaCjPfCqHvUahiAxBR68DfhQphdV?=
 =?us-ascii?Q?hQLlFkLrgK/JR7p/Zl5icGhhBiE2wspODYgzE4DeR3xTvc8ZklfaPi1MJvnF?=
 =?us-ascii?Q?vjlqgXEFMzK3/HTY+O5gsL/C3fRIon39clSEgcKWjc9P0GuKIc5+MYMnxI3P?=
 =?us-ascii?Q?Hf01eMaaX0TwL2jl1LQDSw4qNNBfHr3WCZxO0mvs903Nt3pB1yYhGSOpHCUD?=
 =?us-ascii?Q?3+4+rlEvJExAZjzqaAGDFSQc6yR6gR6CUknwitrQ4J/zidJPD3B37cFUViti?=
 =?us-ascii?Q?K3w2b1kVCcsCoNtGn8ZQLuGlh9HMy3A9/4cyVEZZKb74ESR/LuI9IGGSHt2K?=
 =?us-ascii?Q?Ajq9THIANonn3T5Z57XbPR9V2plkTcUsdZS3dP+yR9xFqDxgudUAlj/msXTN?=
 =?us-ascii?Q?+aumBNz8SRmyyXAObPL1iR6yVIwfWd6nwgEkIGiD4Z7Os43VzPrxhmOCYONH?=
 =?us-ascii?Q?eXOdgl7GrB6APOYjXdYmVEtTRLsvKCYhkFidYmypAJhXmI46Btz67hcTF0Rw?=
 =?us-ascii?Q?X8CmLEgtFgozCHnxjRGWr5voJLrUzOFOWu09JxPl9p2RuAXDQoCintF7jmW4?=
 =?us-ascii?Q?RTajQAR65aq0Ify4+1gwAD5QhSMCx8i0EAvrHz1RwXHIovz6NA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BbTREgl9zZBEKqzaSKQLEnfO9MU76oQZkxUT+au4uRdEU9i7G8MmgwZm/LqD?=
 =?us-ascii?Q?VmrLzB8Eqyv3il8mb+ou8pC5WUySXO2TIaa7rED3dQBCDOA1ifWnos75wc4A?=
 =?us-ascii?Q?4RLRX7rIQ2/S9zKXxKe1gquj7J+B335OjYu2ylPasgV75uFeXnrYrVHtjEIj?=
 =?us-ascii?Q?OUsvEUW/WHa1fiy6iBCHPoGP0e8T4Vey0hBLL5tZhvuH+iZ3WFAj+zu1toP3?=
 =?us-ascii?Q?9oGFRbUBVaNZbH6PRf1713nREe3MaLqRupzoECCaQ6EDppnEwl0rafjsQ3+i?=
 =?us-ascii?Q?gaShd/FQndWap+0IkTzqrzauiX/ynPf4kq/vnYMX1GdzuCFNL0rvWLBIjQjT?=
 =?us-ascii?Q?xbnaFHs3ZmAA1grrIKx29oU9amk7mYOQigpXYOBDHYUO1wy/+q8s3o7uj051?=
 =?us-ascii?Q?0/djqOQtWGn/8KKM6FuXObTDPOa6KvrZ6qYTLLECuMSuSDWBHfV2NPFRCADx?=
 =?us-ascii?Q?KuAie1hJ+xByxcGY/Q1Evy/iU5OFqoX4Ckuaz4Cd1cm/qjH7E5EGLPYOOIEz?=
 =?us-ascii?Q?b6dWygcmK4P89rX+LvZCO/ot5gZn2Mvlb4UQZuNsWJPC25gQs/qr+QssHzcb?=
 =?us-ascii?Q?LXvS1H5H01z7GRQuJZ90KxpIvWm6NCESX0ihfAt+0cbUtXeMz8wtWm4EBrRv?=
 =?us-ascii?Q?gaFOi5Rz4O3SgcaKwoXj0Ec7NxQ53v3CgHZmWsd88loMvp0VmEvLqr+t8aX+?=
 =?us-ascii?Q?2bD5Aoep2bd40JWyOfDZYsWZxQPoqMRyFXPzXis19lieak7i5/tJQbNhLiBG?=
 =?us-ascii?Q?02Zx19ScohL48JZR3e6IPCovYoKlU4jMJjjWrj0TExR6UjEfvnsdodAwl0Jb?=
 =?us-ascii?Q?yJ4vufTp9U/9W/ajLqPz/vvcR7r00SBKHXiYKcue2oQFCYl2adTo1p6CShm3?=
 =?us-ascii?Q?fBw48YlmwzQJvW6hmq9nEwEXj1tkamp9C0qH84nNOAgmX8fvwDphD88d1NDh?=
 =?us-ascii?Q?+pslM/WnoYkVX9OMkyiD6FiFTXrpfTvYfv3bDLF9A9Drwn4CYeuJpjdhptfU?=
 =?us-ascii?Q?bWsCRj4ruUlDhPyy4O8E6E952HNoY9Jb+9e+rKlUMCWRs1tSh+xCmUCF3EoH?=
 =?us-ascii?Q?B6In0tfDaysqCxgVOx7qGTLGFfNwkY+LCN944ik9ql0fsSS1x4FD6iQwHS5p?=
 =?us-ascii?Q?N8ugXlz8YLONGn4GxclWzLE4atKO0r/RYVkk+zJrZeQYI8IICds3yacxeVak?=
 =?us-ascii?Q?ZVeIhZlZb4XbBXnREttF/nP3NpbfpEYhLMz1FYpUt5uD3FjNyETIGTQVG7TA?=
 =?us-ascii?Q?4Ep/piWOzu2+lqStH5eRzV97cN1d2QEntVd5wF5/n1gnyzz39bxRiR1YFS5a?=
 =?us-ascii?Q?d6Kaw7wboyhWx/JcvKYmgRLDScSJ2wc3WPLhTrnqUe/wohgj8NvCBXR6sw95?=
 =?us-ascii?Q?Ej5kl8pfUEqR8E8jcu72/kA2eC6ssp7GR3I0LBq+5nBFYcEkPWnAepNZnjTq?=
 =?us-ascii?Q?gTOJvau45pzrQmvqfc8l6mYZolq30Gx4HP+zc7a9bf5gg6kOw1tcXPFlPvwX?=
 =?us-ascii?Q?VPOvUfDswAEaklevxV6ON2KwRydh/PY9ulSzdKa9bhnHHLJ9dDPDOlxIDihO?=
 =?us-ascii?Q?lRRRA/T7VTlm6BIJ/VNAPr5y8L4MF/enG7bM28lZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2189fc-8db4-42f0-d5f8-08dca0be3ada
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 08:56:47.6206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4ScS9zz5BdoA7h4E2wP9RMqCUCiXdJNGdq+sjdM2MIniPs/elLsjw2+suSfpnTX/9j9cY78uBQUN2JTCbZ4LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8580

Add RMII clock selection for ENETC0 and ENETC1.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
V2:
new patch.
---
 include/dt-bindings/clock/nxp,imx95-clock.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/clock/nxp,imx95-clock.h b/include/dt-bindings/clock/nxp,imx95-clock.h
index 782662c3e740..b7a713a9ac8c 100644
--- a/include/dt-bindings/clock/nxp,imx95-clock.h
+++ b/include/dt-bindings/clock/nxp,imx95-clock.h
@@ -25,4 +25,7 @@
 #define IMX95_CLK_DISPMIX_ENG0_SEL		0
 #define IMX95_CLK_DISPMIX_ENG1_SEL		1
 
+#define IMX95_CLK_NETCMIX_ENETC0_RMII		0
+#define IMX95_CLK_NETCMIX_ENETC1_RMII		1
+
 #endif	/* __DT_BINDINGS_CLOCK_IMX95_H */
-- 
2.34.1


