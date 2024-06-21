Return-Path: <linux-kernel+bounces-225109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1D6912BE1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 18:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FB8C1C271E4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8663D178CEE;
	Fri, 21 Jun 2024 16:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iqzND1/w"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2078.outbound.protection.outlook.com [40.107.14.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27B9178369;
	Fri, 21 Jun 2024 16:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718988737; cv=fail; b=irs6KdVL5gZKw/sybloXEyXNVq5SryAo2+U05MMQyWMC/ljTzYp69ePJ4wpRWgS1ZYP7fS7gKbBP2dHj4TxIx79Mudm86rheuRBdcdJbPoA694QYAYyZy/LbcCo+UPSYulI+yAo3xLzvK+tq6eCBRCZk7ngiAnXBXUcvIqIl0BI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718988737; c=relaxed/simple;
	bh=tOOD5xuI8F1n2ZGQa4iyg4K5CPd8xD1hhBRWt4azMBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VhdxObjKaMmqPgvbfqlO4tQiXXtvz7WW3n2VuH9YQtgMVBrlb8qkT66n4D2C79Z6B0vsQL96VrNTQe7CDLoSsqPhsF/lP+wiDV+BlmjYrzocqIISmqueEcXdvHZm5BTPX0phPs+qfjsLd4j/5H8EQo/QyOSMU5eIvDeZvLoxfgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=iqzND1/w; arc=fail smtp.client-ip=40.107.14.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DS+mTZH1H5nwW3Al9BoV3aaC8jGRmcDxhkOhMRxO+t5hiGUqeyzjWdtumePvlrosD75VIGxmbOb8S9McaJD2cHP0IvH6CK781WK12YNs+CKCq2eN/A9gMqCX0LGnMFzu70IL3xrN6a4knPjgHF8asF0KBpclOH0EtJIuRI5WnhJkJthltMY6wxVttMM6/zjErV9566VHK+jro5fEAHKveZ7W/Vyx+VfXwz4UrAsOHBmiqtIUmmBl+FZ3/i02x+/Z7AVrIJznU1HGqnhBfsb67kOwbz7OU97WcA3szpmqKXR8A4XqoyoXZTCrAADhRUgsyQ/cx43mxmQXAChFsfGPWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWzHJKaNVotSUhETyUlQAaE3csZ2M9rmxEF6c4Hiza4=;
 b=gVg0LcBLDQrIJrumQwHZGRh1bXaLLY57OHCavAL0c9rrUOklRssWxTvk5d2R6+UdZvpIg9bdfJvV12xPXXrGMz9HtUG6eO5BWemjR7PHIzXaSjijrdcK2dML76HuuD7HOj6GIl4PliNEvU95G6W6IBsvJ/i0Lg58NVTGvOrGKg2/veeOWQYsYIdWX/jqq7YMJPlVH0K6ubEtxFIoQBg/FC1Amj+0upYq8jSGYOjZod1p1LOYzQ3FsGFVAH89lNOUzMnbPPc9oO/uIwlBdeP6c7c1xdJ5nOVxU4fxL7ggB9G4/7UoWJDQxIw5mlYEJeDYbhYMF4dwbkxpIuBCdDac/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWzHJKaNVotSUhETyUlQAaE3csZ2M9rmxEF6c4Hiza4=;
 b=iqzND1/wpf9h4p4pCbunGgOZAqQVPI13gnUFB74AE3NdCQxeCHetqcStUy9Xb2wGxBm8RRrq4MMMeP0+f116ZzgB/gOaIdPuKhe1PA7k6YEpo2+zUqs0GjiPkuBes4NbrqWHuVqGmorIdigcAHKsbxApPZ2qNf1SnFtSEWccDjc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7937.eurprd04.prod.outlook.com (2603:10a6:20b:248::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 16:52:14 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 16:52:14 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 4/6] arm64: dts: fsl-ls1012a: remove property 'snps,host-vbus-glitches'
Date: Fri, 21 Jun 2024 12:51:47 -0400
Message-Id: <20240621165149.2275794-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621165149.2275794-1-Frank.Li@nxp.com>
References: <20240621165149.2275794-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:a03:74::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7937:EE_
X-MS-Office365-Filtering-Correlation-Id: c0503437-b14e-4765-5097-08dc92128081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|52116011|376011|1800799021|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K9OZNo/J4VlELeW4p10QvYVsqMua0t2OmdTQwccN853GEmS1YzJhDRCAw5PM?=
 =?us-ascii?Q?MW1l6w5jVQFaKWBf60Lz2+gzl1I11LTarZVoyj+tBfmTAp96YRseInWVMFJo?=
 =?us-ascii?Q?iOcpWzpB/uXh7Im2Sc9WX2RWERHL9oj/IGjEKV+3/zEOUo+tJMY5pDvKftFU?=
 =?us-ascii?Q?I7IbS4owW3jJskEjG9P/8WX09crjwJatQneUA2N+rVkvF2OC6QL55goei4PT?=
 =?us-ascii?Q?/3BemzVHM6x+TegZJABTtDnkW9Nh0UvBS5IATar/8dn3AGALhazpFDn/UEHX?=
 =?us-ascii?Q?g6VtNvMFiOWm30lCx+fFWwuTJDj5Yc1dAOxQ87hrdTkIOk7fvvZKfAiX8xP3?=
 =?us-ascii?Q?PF0eyNozFM2bqfdn4YRO2GktRkXhX89zXAOctlgTMuH1V7/aPWO/Q1asDjUM?=
 =?us-ascii?Q?SoX7Cnid7SMNRyuvCR68gD94RWsyAUxHqf390s0ozU+se090eHlKUARo3cxK?=
 =?us-ascii?Q?UlZJ24PnCeXLkqy3GnRon1i29QvFOhbuvZJn0aE4sQD+E4LaExxgh0UYAKTF?=
 =?us-ascii?Q?jHQomP+X2iRXzrauUG3JJ7vrNSp//F6NEi6Bvy/QT/xQexkG+qz1ZyTC3Eqc?=
 =?us-ascii?Q?P5w1j2zLwtFzkAaphpdFNIyNbWXRBqjvsHBEb3vnBG5nWJJtZXGIrJ7NnO6M?=
 =?us-ascii?Q?PQHTSoHmmuD6pwh3+b54UG4/cJ9/77fRmnqGbF8ZHDYFI8uqMf8RQaxWT3wi?=
 =?us-ascii?Q?Bnuq7dlqXaHYsYPl0hTCfvcJS64ZJB12WLd2PtstfxU7xEaBOCJ7AEPlVAOw?=
 =?us-ascii?Q?BOY3AxcR8mOZdz1bxDyhccUjno4AunM4w/kmSMdjPuCIpqEqnXikHoXHoJr5?=
 =?us-ascii?Q?KGybmKTaIJZjYqPHaJLM7yBu1bjK0vGfutl6PvnQhsjU4uP/5714M/vWTmrS?=
 =?us-ascii?Q?PQrSJREK5GZ73MAVa0j4h7UIuKbyHgwda/zQMb2r0jgL7wBQCfl2q6oVyesU?=
 =?us-ascii?Q?2YnYDevY4BIp5zrGlF/Z2K4yBI1MnOwHJj0jxpZOqhuEJi4byNl6Gm8+9NmG?=
 =?us-ascii?Q?ID62eSYks5ClLBY22Xa/ofuXAr8RKE+bGjQnC1/kB06KN+uqpmyBWDpI1ZlL?=
 =?us-ascii?Q?P7ES8yA4YIOMK4wY3TpIs/39xM6hHteWXq0zlMG+tQmrNVdw00thEyeEt0GV?=
 =?us-ascii?Q?x5jP50tbCp0LB72em/mvCPIzxThhKWzSB74QZo2OZCQDrahlEspU9ERQA1JO?=
 =?us-ascii?Q?qZRDsPDexTflbkol3pbv/SzeXqWkiePcxvkY+SvF8GSgFvVDF9XbGOkbeD3M?=
 =?us-ascii?Q?/Q81lLseW7Q3rgEYHTP0w2QYlA0wJvYhu4VhJwaE2m/YeMpw7JH058fESOtv?=
 =?us-ascii?Q?Aucb6cXOMDWnnvl5kQo+w38pKqbzhfkqtDfL8qGgkDP3AcD0WcYnCGQaLKBm?=
 =?us-ascii?Q?nLZ4lYs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(52116011)(376011)(1800799021)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?//2qFy7Q4po8TOsg6Ej40SD3f7vPWJhEMc98MD+gvAZiTZQ+nmr14DgwH64m?=
 =?us-ascii?Q?708g1qEnopdpZN0JOr8/HgkF/b8e21YH0W2hY0mlD2lS7XpmKldZw43+PdGw?=
 =?us-ascii?Q?c3P6QE8kPcLQCm1o0ttB72CuQVVgcDjH8nayieXqlml1VmDrisGitlMOuqfh?=
 =?us-ascii?Q?9HGQsJ4wtV4vCKhx5uO7CL05VH/BNYaAtijLpSyhQPzVF52+PgRV/gp5NF7w?=
 =?us-ascii?Q?LWgAVckJeECwHlQGyr7srvkYVTsGj1TN6QM0FipnftMJEOuHG70tUZIFwFH4?=
 =?us-ascii?Q?08a0/BYbkqlENAg2gTYu4wstlkwxkkMe0dBnVIA5M5IBMLJu2k+SRcq++fqh?=
 =?us-ascii?Q?l1Rmjx+ijzcwikpKtE8EK1tRV4R5mUx55W/a2VwNi4q62BL9nEQG/7IkPirn?=
 =?us-ascii?Q?vmG8vEBq6n6t9FTM6anQDG3sjB2sES/F4eQW2mLvZbi++rgLB7yk5EeQzpGS?=
 =?us-ascii?Q?A1mymj9UTtBCiQKCzas+4vwApEK4UVxbV57cXcbpgkrx9eexbJUQK0YKY+pB?=
 =?us-ascii?Q?U2QeMQgXgnJGCUMaeM6L9m2WgVWLO+nPSJxVpaItSMd7EsGP9tAc0DWUIWfI?=
 =?us-ascii?Q?7RlAGW+3l2C2ZNDF0vTFSQNWFimGCmkici4qAE+fINgozrWTv1t8yKcko/PV?=
 =?us-ascii?Q?NyaZOTAgLeZYQ1WXQpGETzrFCKSoIvh3VMhd/etZE3nyDifCPzl/MIdowzQx?=
 =?us-ascii?Q?Z6fcPQMbyJZ5diSBRK0Sg2bIuHSQoAbZIUdUis5fVrqGMXNHM/yHXUzUCJBo?=
 =?us-ascii?Q?91qybAGkImUlZfva/2VJ1tQ/m96ZQJs0xTqO2nMunkVuAWkcJfcBiwW2Hkpe?=
 =?us-ascii?Q?reYL/6CGndYhBTjv9TeaYtEM0+Q6n/Z4CwgvXLZvEfX0OeshdFtG+5OLzVve?=
 =?us-ascii?Q?hgtLJBWjcCQFkicoPY1qURzmZ3b2M2H0XYKT67dbbktfLUmInLr/7qarWJnB?=
 =?us-ascii?Q?VTNWmYH8T88KSwWWeIlD3tx+sJuId8XM4RD/FBlMqWojYx+Fqhoh64DvYt7d?=
 =?us-ascii?Q?3sFzbkt1u2Y+duBqmaGKmGxfxAKQnL4Rd7b2C9yoCfoj1+nvjt/tkx1S6VP3?=
 =?us-ascii?Q?Vd+8aQfiMv6/24FwfMHo9cfcEAkp7LflS1sFPGHMVuGuGNqvawEAz9FmlR83?=
 =?us-ascii?Q?GH0YDx3qPyA2NCfZK6mMWARMB7ye2pn8HE05OmMvIOCr81i8ttN6Se/O3z5d?=
 =?us-ascii?Q?S9IN3uFOhJVT1K1iGvTIHmp9DkV9OL4E6zLYiQcUZjAwaYrX1zrKWgiH+uEY?=
 =?us-ascii?Q?Aex/88TU121awDbi0kf4yx2zADAfwic7LeO0DzEcQubvoZ27CYVywi2J5+U8?=
 =?us-ascii?Q?sT2VHxseLCpOjGZQ1bTrZKjru8cf+hmyYEm+mHpGkzH8eLICnygNQKynBoeX?=
 =?us-ascii?Q?W7uOtCVs/b2Pn9lEkTOFd6PNbAjqB6zjUbDV7zYCTR3v83qj9ZrgbcCbU7mZ?=
 =?us-ascii?Q?mOD9DMzyDykCoiDoR7zHHc2XVSdon2dSwXUY42jeWNj3tkfeaWioUSTiRoc1?=
 =?us-ascii?Q?n2VJPSWaYtAYr8KEYQe1YkW+2ofs9d9MF6KpeV8voxF22OPA6XKdB/f7S29Y?=
 =?us-ascii?Q?iA2JxEWnSWT7sBGhBszHmTKDkw/KRRLwO9WuZazB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0503437-b14e-4765-5097-08dc92128081
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 16:52:14.6644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LAKsUUzO5vxtX8xMGBDhfAm9SfxyPhy0t/QWd+Et87xM9AC4RZEhMyd+fLlboe5WHSZfAJiM8apgBfWfXN/M8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7937

Workaround already applied unconditional at
commit a6ba1e453174 ("usb: dwc3: apply snps,host-vbus-glitches workaround unconditionally")

Remove it to fix CHECK_DTBS warning:
	usb@2f00000: Unevaluated properties are not allowed ('snps,host-vbus-glitches' was unexpected)

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 1b6ab9550cce9..64e14154d5969 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -501,7 +501,6 @@ usb0: usb@2f00000 {
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
 			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
-			snps,host-vbus-glitches;
 		};
 
 		sata: sata@3200000 {
-- 
2.34.1


