Return-Path: <linux-kernel+bounces-401391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0E79C19A3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCCD2286492
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B201E1C29;
	Fri,  8 Nov 2024 09:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kjfP7euf"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2041.outbound.protection.outlook.com [40.107.22.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900811E1C0F;
	Fri,  8 Nov 2024 09:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731059894; cv=fail; b=TZ6QEwJwlVr64TBhC8jD3+2BWTemjvaO18OdUQxfxoy9UNfpgya5Y4XXp2Auvy7sR2l/fUopRHlEexi0fWvJZNMR1V3Rdr0cWv3GsUWOOIk8Yjx4fCIRLf2C2IaYL2e9s7L2pZd5lFRkddFTfjosOo4De8P1XsOStnl6T9El2qY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731059894; c=relaxed/simple;
	bh=/kqY7ma79OqGvUyNwPDr4nGkGTpajcBFOkgeKPNb0Fg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=imMFwujX9ZTpOHrGXTRO7wjRI5e/hBMUYL8BRGdR9xOL3yBmwGVnRuqrUOeCMreFaCXB5/XZBP737XrkeONmO8VEcY8wNo42UtbYbdaDcIPPuWR0tsZFq9Ev0/r0x+sZ6M/ZM+DqhRTefiRouXupatbP7jfeOKwBUgBZFXxzeEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kjfP7euf; arc=fail smtp.client-ip=40.107.22.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NUEWIpSyZwMAG2ahV8Bbe41aNOecN+oU+b0MkhzHf9RksayLhuEYSC0LYwN6Vbx4FsR4/689qeyP/v0te+9LQZEY6IFuFdSNJ/uS2OEz2IsUhv/YY1mQVEWwJYTq4YGJJF1+u4Bq5oYzJbgAw9UQ0xVrLjoB7vADxGjE+7ESdT0QjevoNzGpJtPxgpyrbk5XYW2o5lfuzcNgA3SHRYgAYdmWufHZEuTKHXW2cGnNsSStMT/CPvHjQ/bM9mjlSFPwIcAoL86O0KQ2eojWw22YjMCyOV6f4EfA78rjIM3TlyMyetZY1p02Lgw9zfwiovNLkRXLZFQZ01cL0JdO8BGYUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EsO2yI4JblKtxlremYQ8187xUe0MysKnP0+3TW97Pww=;
 b=J+O77iNn3vx512mM5JuA5XD2rTAQ6TiMMsqDYb5eJNnFSuwolCkv/HYaSSNRYOSucrqbRVdSbaryh2CTQmutXcvXoY+2CRUByLiwnigSOCrTlXbKxMa1vlf4RPubEIWj2fCozDlvRPdCG7tyKR/PoRcnTg4mJeFmVGSeqTkxGuuMHaVNgXKXhJkjdQFfxTBoGch9YwUaXpC1y/i5PBLnonZ20zDPipvx8snJZ2iUo6BjU/Gxfh4rEvsYZPLLXk58+e6EsJxRkf6VVqOWSb67OPo+H/kIPyG/paZK6IrGTPJ2I1074MumcSHOlhEKR5ss8axekt/DQZ67K5sWqCvkOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsO2yI4JblKtxlremYQ8187xUe0MysKnP0+3TW97Pww=;
 b=kjfP7euf8M//IfK9qf9aetnbXWpYMpFHQQiKkl4z5apeVC+Sf6cgJB02Jy8fQE4FrbLEA/biwxUiPVWC1lMw0UJy0L+YvuBA0U8GJM5Cx3EdvmzhGo+EcByOyxfMMzoMjdbELIoG/92p276VeUtbtyARPy4XVyvcVPJFnJ1E1VvU6lmV9da3SOxthggaRs2eaz8SS0hywHBkXm10X2j60U+gS1DwebPABs3tzBYIDLnVtHpItmyxGOIOyRoJmuN8Sh8TIyQKarVq7bmQzACtV4L7ej2i5GZqC0txQPCRUZJrcJhucOHo4DVCfO48jJzp3TwdBBk4hwX0bP0/3jTEbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by GVXPR04MB10538.eurprd04.prod.outlook.com (2603:10a6:150:21a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 09:58:09 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%6]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 09:58:09 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: abelvesa@kernel.org,
	peng.fan@nxp.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	shengjiu.wang@gmail.com
Cc: linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 0/3] clk: imx93: Add IMX93_CLK_SPDIF_IPG clock
Date: Fri,  8 Nov 2024 18:07:56 +0800
Message-Id: <20241108100759.682260-1-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0213.apcprd06.prod.outlook.com
 (2603:1096:4:68::21) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|GVXPR04MB10538:EE_
X-MS-Office365-Filtering-Correlation-Id: 9baab33e-1429-4f54-64aa-08dcffdbd941
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SLoCmEh/knEn7MFRcYlPLeiT/1FOVOH2GbCHOFY/J36koIjwsMX0bzpQS8sZ?=
 =?us-ascii?Q?/3tUPCNZP+UucWtDpOH2LUxBJLzJ/SMYqSK2UZM0k8fk4RAj/z++QOnzAP4z?=
 =?us-ascii?Q?PYskqbi1yz9Fz3X57AZhTyTQ5MTBR7+lZJ1TRJC/Vkj180AbDR8O7Y5wRvs4?=
 =?us-ascii?Q?Y2tpCqBXb8irkWhko2+9gSamv0O4Pu2ghTpV1I9YOiedBg9xrjq4lUG3JPMU?=
 =?us-ascii?Q?2eMuY5lbGRRRoF1YJAmCE2M4796WYcDTfr1zBt6HvoNyfatchHL9SqlikHRt?=
 =?us-ascii?Q?DRdInO6d63OyFDXCkwb4PwBVH+TV2jA/rlSmSyE6gkiNS68QXunlTpkR2PWl?=
 =?us-ascii?Q?jeycKZU4ZeKhYh9aggzrSzfI0jmYrdbluYxnIP3QRhKGMg0Ui4xuKjm+iFDA?=
 =?us-ascii?Q?3vLqk45nB5LgK8AoLgT8W2I+s9JuB6ylgnvgToQ1yQpj4M2bJ+Q3GxDlniX8?=
 =?us-ascii?Q?19pd7+BzkfcwvIAUnN+graFg9PZ8kQGEVLRoPCEntuNgbcEVV+8riOi+1ck1?=
 =?us-ascii?Q?p0Gn+yY5TVQ2Pn5Vw388f0mx/FJ7RoymsWLbDPnPgRpyvoz4xhB6yWkQXKPY?=
 =?us-ascii?Q?7XLY08L2dEa2aGHKeSjY0NvHPLdW+r6dlYDRlvnv/gMc/OtoOxPDEe2yDubK?=
 =?us-ascii?Q?MLm5MrhEJbHMZhU9ks/5ZDdBQ7GP4/wEDlD5M6oPzz1umFJ50H/wCskfoO3C?=
 =?us-ascii?Q?NOygqfv3idWTBM0mRWOFpPqMl8vADl9O+IlFZAtXz+dQL00USePeEK30hKyM?=
 =?us-ascii?Q?jCbyGGEMTMfCN/UJtx7LZmGcgC902yd6lay8EMZ8s+/d8JzoMJwqUk3beaVD?=
 =?us-ascii?Q?FGC7hYAAMBipKeAFMSJx5NIhTA+YP5FVFWQHgwIozMYqBhEtPrBavejmFVhY?=
 =?us-ascii?Q?7EKYWSje4kGMKVdZ9J9LCJdUGVAoSXoD10EnmS2K8Z8Lfx451dhjio8naGzx?=
 =?us-ascii?Q?vG0gTysqWj+KWS2uWS1lIQSSit5qKA1HhKzNxvPzqKebkAAdk+K9TMYW8B+A?=
 =?us-ascii?Q?edBdGZEIkBBzRBKa1879u2fcEiCgonTdg7TN107I94L31JOM/YwpftnAf0AI?=
 =?us-ascii?Q?V6H1WWV4P1vf/WaKmHzLDdCu9NPVg/HQq0LH6D9FnrKcTDJenkxJ8Qe6qy57?=
 =?us-ascii?Q?E42NR+QcycZhBId3E6tupirMkNv/2oxfbORmGIkxOquW6skgMZpi1Q3CNL08?=
 =?us-ascii?Q?PrkOXOaqLmhoCUYYAMg9FSVp0c6h1Cy24/JH723sC38bAJqngvc2dcAKZvr+?=
 =?us-ascii?Q?LyUO2fGyYQfct4RS4BdkNIeDWswoW9koBwvC3I0lw1X1xBOycD7UOYGhD0Kg?=
 =?us-ascii?Q?Icsj2RoE7ZuqZkeN4pDWnRRG19nMsmA4Hoj6m/3Tc/FqTNpImYA9yeL9H2/8?=
 =?us-ascii?Q?V7DH3Bt4JZ2/hFeJMdGdxlMRcy8a?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fgAUP0HQWLBl713uw620VEnAqZUCbHNp5qyu6EMCswZv438zBnsuauxOBARF?=
 =?us-ascii?Q?IanQOywo657wMQ+xgbnKEylqXY9PK7+h7xQDpPaslyoDx9C0qk+Q3xo1s0a7?=
 =?us-ascii?Q?zGtcmgjruB7unPAhIlHCRx/taMbqNk/JzW82cvibEYmMvvSga9PfbCyvPbUb?=
 =?us-ascii?Q?Bc0A4ZdQBe2KpR1B4jpRJQNG4HRdsGFhcObOdefgkW7IJFEGDxG8UMeJeykT?=
 =?us-ascii?Q?fd6LFHbLXQ5hRZ0a9UBJ1LthoobXQDUWh7Mg1HEbxQ4ygRZrfBfMUjAgbaE+?=
 =?us-ascii?Q?FAmOyi2bM81P007h0b+bNiagow3Jz9v1QV4RearXmDHYrF43K3RBOFTubOpN?=
 =?us-ascii?Q?Dhg+YYlxKGW+AD7VfayHyMiqcxi8ugkA763MGHSquwkoU7W1rL4p++62Bf9P?=
 =?us-ascii?Q?kxMFrp3xv4+Vkwcr2LLQhkyTJfeOfHqzAglt0AQ3kRwLCAf6NqLhkZNck2GV?=
 =?us-ascii?Q?3kQFxaseqgJSPPlF3fcaN6Kon/4k+BE4vbf+EML0OG9NwxeMyL7Xt0Qg3OA/?=
 =?us-ascii?Q?dVGlbJ+ttt0fOotjfYZKpvaUDFSRFAanqGgWj5fptMgDXet9qMgLO/Nb37SC?=
 =?us-ascii?Q?f4Rji3dqCFCrtGG5r3lR5neiXPW+2/s1pgARC4y2QTUKwBPpecTt1ZvoF2NW?=
 =?us-ascii?Q?cn2Qa4453EeEk4ZklF0NHpuzBmsers2iZ90NgZjj370C5N9kdEMs9vcD4m05?=
 =?us-ascii?Q?EfSYXos2U3k8uphcjM1SD0GeWtV3DGdGzKyk/zxYsWhJvUsswFJm7mvKDZsB?=
 =?us-ascii?Q?I8sUoDTFGGjJy1jGvIEeFHI2wRQ99sqc3mpISWnaNszMdl8WyrgeJK7070zZ?=
 =?us-ascii?Q?fXS5ROMoyC5UNz29vXKuLfui82zAnqBLA504O9BGZVrzEEQKs1P3KPh+Hf0c?=
 =?us-ascii?Q?ZxXiY/hqq7C4amjaS4sQvOKeIF00rx4vEx5AOUIAnKMDmja5ICPyiIlQC1wt?=
 =?us-ascii?Q?UPJycaLOqbsh1YmuNSZASLtWgyEBAjEP98imqpRyUej5XehbvLXJZbxRDtgn?=
 =?us-ascii?Q?SW3Ek3jzO/WIWBXUnMT7XCjHelYMd1PVrSdZab7V6az7QB02c9loAX6hIJ/y?=
 =?us-ascii?Q?MeE/mgXnLuvBc7TXOISu6bluCV6o4WnWACiNO/GSpWuoyILOGjhE1Kchbqqf?=
 =?us-ascii?Q?Uoeu6h3sfL/EM645KCJOzERyKk8h5vi1ZtK3RTGpSzX7h+b3up2AfF5k94x7?=
 =?us-ascii?Q?tKeCdlLKJCAd8muuEMaWcL/KyGl9etXeJfkSjGkII7FIiQqBVcfOohf3+iSO?=
 =?us-ascii?Q?OZ7Am9qBxN1FNpHPkg0/JQabk7WfRT4acRe6YZr7SPv4uyCyPVHDassHd3hM?=
 =?us-ascii?Q?I8/nVFqZt9lNOEPUsAWJMr+ViQbJA2yIBytkdvvSPdY4dZ2WX8emxLoKWkAc?=
 =?us-ascii?Q?EfXshTB36UPR/76FYsY1IO34yeyy5ogmfqBjmx3BnLl+qifkSSH/2N8hcR6p?=
 =?us-ascii?Q?BtA24lQAdIPB0Uq8s8quR2pVKDLptoefQAewqUAqs0mbd3+sz4wksLvBN/TC?=
 =?us-ascii?Q?AlNHwLn7+WZoMR/kVZ8JEYmidFmPk0JDh/JFmRa8RDxWF8rqvhrUnt5B2fx8?=
 =?us-ascii?Q?Yl2obrkWY6wvpqT0GFVmkBWzoPpaOI0psniP5QoA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9baab33e-1429-4f54-64aa-08dcffdbd941
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 09:58:09.2137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YTEU2Bsnwt+o9Zo3YSjFo6D1nNPiXctRa52N9/4yuTjHfB8D4lQIRGs1nAZ/LIcqgn4Gnx2VIAQNxBEqEuGEtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10538

The IMX93_CLK_SPDIF_GATE also controls the gate of IPG clock
and root clock, need to define them separately.
Otherwise driver disable IMX93_CLK_SPDIF_GATE will cause
IPG clock is also disabled, then register accessing fail.

Changes in v2:
- address comments from Frank Li
- refine commit message and add fixes tag

Shengjiu Wang (3):
  dt-bindings: clock: imx93: Add SPDIF IPG clk
  clk: imx93: Add IMX93_CLK_SPDIF_IPG clock
  arm64: dts: imx93: Use IMX93_CLK_SPDIF_IPG as SPDIF IPG clock

 arch/arm64/boot/dts/freescale/imx93.dtsi | 2 +-
 drivers/clk/imx/clk-imx93.c              | 6 ++++--
 include/dt-bindings/clock/imx93-clock.h  | 1 +
 3 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.34.1


