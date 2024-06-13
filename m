Return-Path: <linux-kernel+bounces-214061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 393C6907ED0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 00:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A31A1C21BA6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 22:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5D914B96D;
	Thu, 13 Jun 2024 22:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="E6j+rrmn"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2067.outbound.protection.outlook.com [40.107.241.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC76E81AB5;
	Thu, 13 Jun 2024 22:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718317477; cv=fail; b=FZQNvOAnRUPSoXik1eKFRHDPljQpMKzQ1KD6mf0O5gJHNuEhL0FbegULZ0x6tbMrTTC6/nsO78cskwJYZ7GszBA+aov31LeRVpDcPXPAmyT874Q6mc1PsIqMPfPSc26OAEQzhen8jO/wY1uRtCLKXmzZesUZSMUagmIgByfOZZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718317477; c=relaxed/simple;
	bh=0FqgNoG3LmU4JEYGTvICQGjwW4rAj0XO6Xd72n2/3Bs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=jaG3syqI8MYeL7d5/61K5ZQExNmOzdwHLHU7K0fc1rniSNC8xf1+YPtYYIH+AQokzfqwJnqOgHTsnuu95w8eL7l5EZFuJLg8JzS9NhrVvnhZ8tjYBPFGr1uSli0cbOCHli1trJ9Kl3xuu+v/GSBLaaLIsCRTNM0taJ7tIhFBL1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=E6j+rrmn; arc=fail smtp.client-ip=40.107.241.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBKHORgxLzZLREVoIQQtyOuiGYb6DIDQADNPrj3YDEJEaYtKgw5QIVW8EDTEHlazkkYu0wO0/B0bc/feNG616BJvYscXS7Pl73WOTo8OumEp4U/MFWOwRQ7XxvP0G8Cbn21IYxHbhOWBN2iiZDvUr5TtcsA7cTTYubeixoVgicU+4dAJVw+sG+OMAXr+z6gePzpgNanCsdS7+ti6/cbFiFFxbLSduwvP/hkfwWlussvJCyWFsl0Uro6etvs3cot18GnzKz3uEYpP+FbJYqc/r9OBDT3n3ppVykeLTX/e1i6T55VEYR43hU1+88sGNdRayUSqEzUjDcPjev+Bccd3tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQZyoxA0S5WV21DZGG3x2m1hs/SSIRhX3vk2dIedibg=;
 b=WiT9TQbbCo9CCfH7EXfTydXZoaMgwgLi1r8beCfXKv5lIEjIotGARDe+0CY2trYIKPpqQUnvbWnqdT2zlSMqewRRzJ4VXxiJdxgIn0sZ/0VgaFpox2nv7gBn4YtKN8pXXMq7KMqweRAbleBya6QZRwCR1pqqJpYxJCZ5h6YsAfpmiuQL+2O7v7RL96pjbpRAHJmcEsG7vltOnMOvJmwB8QSFCXaTgMUZbt+DxQgpqLXR+sl/F+iKiflIVx82LkfBqdKKEYUdYWdXTZzKvT5dfpUiQunbDzYd8UcdrtNwX+C51XwF/y/jd+X+K16XptTvtcsj4eoqjqlRgkFLTWRHDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQZyoxA0S5WV21DZGG3x2m1hs/SSIRhX3vk2dIedibg=;
 b=E6j+rrmnlCQrMOtPS/1YOwVECycw81gqtbzyNVpyD/08RBHOSmBBfkoN2XP7hF15GxXzB/R+Po6e1OTz6GDfMHl7Xl+ojt0JGIzCd4UKqdCrgZiYiT7GYop6n0UL6WZFqti+G001GALBsgE0Ir9WgqvY1mpyVk3hHtQKy7qXlMY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10911.eurprd04.prod.outlook.com (2603:10a6:10:58c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 22:24:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7677.024; Thu, 13 Jun 2024
 22:24:30 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] arm64: dts: layerscape: change thermal node name
Date: Thu, 13 Jun 2024 18:24:12 -0400
Message-Id: <20240613222413.182662-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0017.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10911:EE_
X-MS-Office365-Filtering-Correlation-Id: a697ea37-8cd7-4b57-5d2d-08dc8bf79837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|52116009|376009|1800799019|366011|38350700009;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6fE4J7sU0swTrpetcpckukUdmNUM36An2IRJS3aycm5OTc2UD16ao4k4hUsy?=
 =?us-ascii?Q?+q7vefSB16wBuqG14MFQ6HkKisIv+BYfGM017154oAc9JRNxyKNYKm9RaYe8?=
 =?us-ascii?Q?c4/b8iPdT2BPiKD4pf2MBLsh7nmcoxr3VwWqfPGEIEx3nQ12tI+b3I7xRs/0?=
 =?us-ascii?Q?g/W+iKZ7u1oaIPKK0/6biXuAJhB+bILvBjsOvWPB09pubs1g4+T5ovWXLEu4?=
 =?us-ascii?Q?0buHQTcQ0oNtXdy9aUvRRJItdal4NDHrsH90G6RXNHCdfzFtXAEhZpkPZA4U?=
 =?us-ascii?Q?7WxzBYz6m963RXXCTZ/QH3Me4MlXeCWickqgY3VyRw2wkuNCpsMVpNj6Aufk?=
 =?us-ascii?Q?B15A3y1doSSmd8qyoWMXSLirhtRNreXkWHIL37eLgRZKpfzsClOU+bXHpMBF?=
 =?us-ascii?Q?m+3jyKMatc4iOkoSDRiuSJ9hwhXsbUUTTIssM5NQDh80XLwDCcofPSp4xuSq?=
 =?us-ascii?Q?ORDE2ZER6xGKfqyZVdmvEUbCsGy1+ohU23ocA4pNgnZWE2FjSzTj4Lx47ypm?=
 =?us-ascii?Q?K9Cxy4ivhVLR9kE0N8nZPpDSJE/zfkw3jvhrA44DsPLI0UB3vEW2uoX9zNrd?=
 =?us-ascii?Q?JIs7a0G+B/Zv2UmKDB7DL7GRSuLnasbFBtPF7DtL1QrsD8Gyv+JuARz2YmM9?=
 =?us-ascii?Q?zkTx/8YZqrMnDRidVIF1HDiDz3ezvJa3cklK0FrNsLeoNGAnIWFDzT0+p/pB?=
 =?us-ascii?Q?zzzLmKULfViKmwN7wB63lZL5Xs+pwYe9KmGPtERhYipIM/KCPawqw74cC0ig?=
 =?us-ascii?Q?NazaRawj83LryRPoQ/QYZ3l80+UcDKz1jVj2LDFaj0IW42gGZryxwBrl9jZi?=
 =?us-ascii?Q?xN+8hRdctFr8QxNaRa5D5Eqf0Ymx7PGh97mXjnqlko41V4jjzSBid5fDlxp1?=
 =?us-ascii?Q?/ZFNM9n8dma/z400I0M+H9qXUUASNItbQqxBCnnHwD0p9IVCtn83mrHLZtFK?=
 =?us-ascii?Q?b1SrMm9hQIsmVhgzr65y0D+XMIQD2DHxV+otMSnWAsiegVmFMayNXihbZAr3?=
 =?us-ascii?Q?oZntZ80WGqtG7qnS7CqDp/gEQe/j7pxCFXMJieNIfE/jD2bkHqnrdA1bbe9/?=
 =?us-ascii?Q?uhnczrgyKQx68Peco54QNtJevyIASDKMTBwI9Gh0JAqxyu6tF61Kvy+b5lk7?=
 =?us-ascii?Q?2/gVPZyPyMcdq03pgcpB2KQtZQLr+UE0B1sk6pgxmSH/G6EhdxIzB/3VNo5l?=
 =?us-ascii?Q?mhQ0DcaJmhJBskhoOlmoX6FXPHaUAu2NUPWXORR9RRvCYZUBoJEfUnJiZdSN?=
 =?us-ascii?Q?lrrw1J6oRcwin/8hTKg3dHUAI6sETTvNUWeCGsCnjbx/dJzhG0vGxQxnRmGf?=
 =?us-ascii?Q?DQfhSBWEl1tIh6jII78w1Ej0CCyQ3dp5NJAsz49Mmn2PzpzvkJeoPbDgUDn3?=
 =?us-ascii?Q?NuFlcT0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(52116009)(376009)(1800799019)(366011)(38350700009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X6LXBfX7YPqEZEwLUJJt2K9x/a1MDdz2ndkUqKnPAEM7SCBHh4aOa2qw12Qi?=
 =?us-ascii?Q?Yu0Qm3Qs9fOtyH4L+bZB2az4x01DqvOKklV8cnsi1vxrKPOxuBGN5F4u6w9o?=
 =?us-ascii?Q?U0OULkQbbOVem0QoXFBwndUXlHP7RkxFJqXDizguT4qjifmZ86+atpqboYfT?=
 =?us-ascii?Q?1bWQ+aRWNnKDEx8Gur1u1ivHFbdcntRI2vh0gn02hYM6Zf5B+vQVfZS/d4f7?=
 =?us-ascii?Q?d62RWI3hhGANsdvIjipni/zP3t/+mN/UwAmgoAB6qbswcVdCJnnAEP2Uhcvy?=
 =?us-ascii?Q?ICU6FCQGlbynbUNaYv4vitRUa3aRIBZ8s9QhQkVLGnlUQOLP+Wy8xSuR2ZmQ?=
 =?us-ascii?Q?AMAMvwxY6EplR8TbJ0FHWaPeFBkd/xdPW4YVUHEZmsI4Ltjl8O2N4kYUdWE7?=
 =?us-ascii?Q?dyEa3hj8SHNXhdtyZBggNceJjBKxd3cLfqdqpuoiksLodfU2NI6zSn5MlgQF?=
 =?us-ascii?Q?cIav/OlA+TF9MmCUG4s6cIrNgoKYp09SKSq6HeEl/O1YPxp+8ifRSY03BI29?=
 =?us-ascii?Q?h39JbJk3/lQuoYDCbfw30pJshlRhO7sySVUwV1vGRGTzG8S0Z3GC5ddnTXy7?=
 =?us-ascii?Q?qKgtsfgU3WD2VYQBsfC564wjYJakSjJ9Hf/AvgKiF3eqOW2RLa6joOYszBNh?=
 =?us-ascii?Q?iR/UWBItAuPBZDVXzXO2caqH7pL+oCked/B3NPAHkhqmjr2ZHhYo6qhWpPV/?=
 =?us-ascii?Q?ied8fS7Oyt+HYDVJC915ZGuqW2Yx7HL7+cKzjfxN0e1I+mK8LFx/2mwRIeKk?=
 =?us-ascii?Q?DY2XyEnob8lEcqyTCzO7fQvuX93B+01EHYOzcxGTYsYx28tND802ijJePaUF?=
 =?us-ascii?Q?Oapgm0ZSA2nZ8udqPSfbhqvxsszo5CB3/G0CTvlkax6SyW0IDIWyVshH2hZJ?=
 =?us-ascii?Q?YGGV00zyRhdNrJoX7J1zYM/hFtunmNL7whiz1zhEWk/XCaYLjyhuuV/s5Fmx?=
 =?us-ascii?Q?F2qB3/HHOeAnpuFdK+DF5S7B2fF4I29vu/k9MBM9/6anxMMVZ8Q67wbnpCc0?=
 =?us-ascii?Q?FySecZkP39dKjTXKolcF8gUqbYJEoZ8TrinCJahPs+zXG1FC3hutaTDWFWSd?=
 =?us-ascii?Q?YyFMepx5Ubw33JblKOXHaQ57jRxUrmBdw96DRjliZNMX61bb54+9hp0Eb7/O?=
 =?us-ascii?Q?zfYfhqhTTTZbfbRiMbhcuBf7fov4SFemiDcRTO8xEoPs6e7QlTdYHcxPdKsS?=
 =?us-ascii?Q?OynSRcaliXYyR/A0FN+HMvLfwtfc70yiVTZVL+ih4KGx9E08o6D8EuESzJl2?=
 =?us-ascii?Q?nJY2q7kdpRIbuAUJAlg+6q0AcqOqnwwbGfGxQD1jLnXi/Tt9RZ1P3uXldq+k?=
 =?us-ascii?Q?p1NuVT8ofNmazgzCbfmIjYwEM29rUR4Na3aluW5VR4ybYkcoWrsLYpZpmh9p?=
 =?us-ascii?Q?S3K+PqqWXphnE/OT/LXy8hXsGPQqRYlUrTjdSOyQ2sRsLPaeVdaLW48IeHoG?=
 =?us-ascii?Q?qdE0P/KlQX8HNRnYJQg7gZdiLYSz4qiYMlEWj0w/xl98FwcL7vmomgUaAynX?=
 =?us-ascii?Q?FXszugElgByy/p6+ZMoaCg3qwoMjGwN2ccSpD1sepon1eOP6oc54w1u7psAV?=
 =?us-ascii?Q?Z+3PDwXQEi8rZ+YKSwoZkcXEOjYf90rTzBmlsjQT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a697ea37-8cd7-4b57-5d2d-08dc8bf79837
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 22:24:30.8329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qoOCQJqIh90c09ASFtJzYhsqWo9QYChSqGbE4G+qyAZF+1UrN0pWPCGu3wKc6rhmIyU9uUcoGzHXmGOV9e0O3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10911

Add thermal subfix for thermal node name to fix DTB_CHECK warning:

    thermal-zones: '...' do not match any of the regexes:
    '^[a-zA-Z][a-zA-Z0-9\\-]{1,12}-thermal$'

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi |  4 ++--
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 10 +++++-----
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi |  4 ++--
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 14 +++++++-------
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 14 +++++++-------
 5 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 6552d404d1310..4685f1cb5d5ff 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -155,7 +155,7 @@ its: msi-controller@6020000 {
 	};
 
 	thermal-zones {
-		ddr-controller {
+		ddr-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 0>;
@@ -175,7 +175,7 @@ ddr-ctrler-crit {
 			};
 		};
 
-		core-cluster {
+		core-cluster-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 1>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index a4a476b04ebe3..45b5d1b16e34e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -154,7 +154,7 @@ reboot {
 	};
 
 	thermal-zones {
-		ddr-controller {
+		ddr-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 0>;
@@ -174,7 +174,7 @@ ddr-ctrler-crit {
 			};
 		};
 
-		serdes {
+		serdes-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 1>;
@@ -194,7 +194,7 @@ serdes-crit {
 			};
 		};
 
-		fman {
+		fman-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 2>;
@@ -214,7 +214,7 @@ fman-crit {
 			};
 		};
 
-		core-cluster {
+		core-cluster-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 3>;
@@ -245,7 +245,7 @@ map0 {
 			};
 		};
 
-		sec {
+		sec-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 4>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 604bf88d70b3a..a16590032a72c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -131,7 +131,7 @@ its: msi-controller@6020000 {
 	};
 
 	thermal-zones {
-		core-cluster {
+		core-cluster-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 0>;
@@ -166,7 +166,7 @@ map0 {
 			};
 		};
 
-		soc {
+		soc-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 1>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 9064e6de7d107..0164cc646904a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -80,7 +80,7 @@ reboot {
 	};
 
 	thermal-zones {
-		ddr-controller1 {
+		ddr-ctrl1-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 1>;
@@ -94,7 +94,7 @@ ddr-ctrler1-crit {
 			};
 		};
 
-		ddr-controller2 {
+		ddr-ctrl2-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 2>;
@@ -108,7 +108,7 @@ ddr-ctrler2-crit {
 			};
 		};
 
-		ddr-controller3 {
+		ddr-ctrl3-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 3>;
@@ -122,7 +122,7 @@ ddr-ctrler3-crit {
 			};
 		};
 
-		core-cluster1 {
+		core-cluster1-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 4>;
@@ -151,7 +151,7 @@ map0 {
 			};
 		};
 
-		core-cluster2 {
+		core-cluster2-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 5>;
@@ -180,7 +180,7 @@ map0 {
 			};
 		};
 
-		core-cluster3 {
+		core-cluster3-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 6>;
@@ -209,7 +209,7 @@ map0 {
 			};
 		};
 
-		core-cluster4 {
+		core-cluster4-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 7>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 7dc98cb0ffc93..bb4e4f7803ce7 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -449,7 +449,7 @@ sysclk: sysclk {
 	};
 
 	thermal-zones {
-		cluster6-7 {
+		cluster6-7-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 0>;
@@ -492,7 +492,7 @@ map0 {
 			};
 		};
 
-		ddr-cluster5 {
+		ddr-cluster5-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 1>;
@@ -512,7 +512,7 @@ ddr-cluster5-crit {
 			};
 		};
 
-		wriop {
+		wriop-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 2>;
@@ -532,7 +532,7 @@ wriop-crit {
 			};
 		};
 
-		dce-qbman-hsio2 {
+		dce-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 3>;
@@ -552,7 +552,7 @@ dce-qbman-crit {
 			};
 		};
 
-		ccn-dpaa-tbu {
+		ccn-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 4>;
@@ -572,7 +572,7 @@ ccn-dpaa-crit {
 			};
 		};
 
-		cluster4-hsio3 {
+		cluster4-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 5>;
@@ -592,7 +592,7 @@ clust4-hsio3-crit {
 			};
 		};
 
-		cluster2-3 {
+		cluster2-3-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 6>;
-- 
2.34.1


