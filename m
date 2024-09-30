Return-Path: <linux-kernel+bounces-344852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB0398AEF6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE46A282092
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D711A2578;
	Mon, 30 Sep 2024 21:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nc5Am/7F"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013061.outbound.protection.outlook.com [52.101.67.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B704817BED0;
	Mon, 30 Sep 2024 21:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727731586; cv=fail; b=h3PqUw4f3GjsDpejEcmATjuXNEN341RhX2q2AYR4JjWlfxWV8dtIOs0zG/6x4gYe8THjAZMQ4Xl+AXlJRyHpa+c7kcY8KySIuizorGPv08kUgNTHb1RdXp4RmhfQxZ09qpBOcBAFMPNSvdvh+xCe1a/VT3zGC31AZzjXVcZkMVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727731586; c=relaxed/simple;
	bh=WI7P/dIqZCwRqmz8lL2M7+YuY+LBe3Sg+D2ofOQv/yE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pHgUy0G1k8G0Itmt6L+xvdOz418ipI/dMb+jhSIbo375dkenWULmTS12Ww+Bc42eU3z2R2AvkZHW5qf+dzs94XsG5ZUz3kDZ6fSXpzIXTHGu+vJTBSSnSHqeKXDiAWDNfDaCp8grT6alKM7QBYyGI3SHhgS7YS9IGeVTi/MlZZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nc5Am/7F; arc=fail smtp.client-ip=52.101.67.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iGjSlEzppRIYDrOrc6BnuqQwasnWZ83gB32BoeFIZn7lgfDz+MrGTwT+6+sLc0bbsIlhInyxc8apFKuGzUzlnbX1rimDaujylhr9uO4/8lCKTX3BhDskDb+mKfnoRgtz9t+whgtFfROrRH5eTku3fshkUC5gljBEbAza6j5CZ90dfn4eHaD+w9LzS7tg6nVbJWY6C5Se/H6icn0ZqeYG88jFWjzjXlWSA9aLNY86R/K7xOvZ6QMl/SYUJ6Hpsxj9g1Adafsrdq+qNVSxrvFYKhITV2Jv16lBNS8J1KPDvSL5wQjjNGNNdbHl0yk6YpYC55BmBHoY6le3fHongYYakQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XsvbHooE5MW027NZJYlDhK4MSbJsvG/ULLR5K9VaiMg=;
 b=BV5GrLKsSxbZPErt65jRoB+CgMv+5tsR6e8caFDUnorsEoZvhCHgj1XdQ9eU37vt3jIxyWrVbuzscYL7yJFlBcaJd2zJLAjN0oy9EbAHLhH0iEQkWuyJEPN2z05rQeGU9AUdDTMvjiQC/umUSK/NZOw4PO2OztlGG/tyfIGrcsPiApHT/9pgK1k7v138YIXr9aWfxlCrcxl165WMxEVHGap61XLn8Ra+cIohEbgVq6K0KlHe+I++qhcaWtq5NTmOiRIbPViRUrOsN8h2GOnI3dwhrh2CzEbDRluE3GRlu4WSUB6wy/ZElsaJsBd33QYxSLmEN90tQPZwROIFV6Bflg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsvbHooE5MW027NZJYlDhK4MSbJsvG/ULLR5K9VaiMg=;
 b=nc5Am/7FLwLvaODCo/vXMYbbvbH4EAcoTcBUXbKQ2GVEOBsROC5LLjXTju8DsaxbnhxzLnZahC9zq/zxoS9Q320aBFouTMSa2OMZC20wQHcoky5WOKbTgVD4dEotcsH+EBjTXTqhd0YbvOOp8GUv29AihARPq0wTT4gMyTfcf0fCpxwbH2dW1b/COJeHUsuYGXLTBI7rD+p7Wdryrci7TPuq6AUuIuepXe2dBPUehuS+hNqnuNcXKDuLHyMt0crrf4uluX0DNwY4ZjsblIhJRgEKddA23ja4JdkUgNzBhblpS7y1PVzm5V0Vn5otYiLOOnhzjTxh/4mYYH2EFwAz1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB7601.eurprd04.prod.outlook.com (2603:10a6:20b:285::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 21:26:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 21:26:21 +0000
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
Subject: [PATCH 1/6] arm64: dts: imx8qxp-mek: add bluetooth audio codec
Date: Mon, 30 Sep 2024 17:25:58 -0400
Message-Id: <20240930212604.118756-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: 1d3aa9d1-a0aa-4b6f-8805-08dce1968769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+M84K4eNdriK20MuFsZ211xDgwfTeckuzW+2mGZhWhc86X05GR1oF/VF6mvd?=
 =?us-ascii?Q?HcjdGeUfBoHNXW+qjIxCEksElj/07542IBpVSkTn2TJ7Q8a3esbuADUOJi0+?=
 =?us-ascii?Q?PZA6J4JNrG3PT9Pawmku6SalOwqPsZ6MEApdFEoYBKXrJCKrWHCj61eq+wwf?=
 =?us-ascii?Q?xUSJr1l5Xf21dCfHSnjDyq3Z+X1yZmdJRLiU6FlrWKIZvAm5E2b2UJCioO3z?=
 =?us-ascii?Q?ReoIVh/Owc9Uua5LRgjOZafGtCOCGNELyhDI5oNXckUXIu61rlPyAnaZTWuF?=
 =?us-ascii?Q?fCQmS59rowvv5D4MzRtc61fCY1yPbf/RgH6UCA5VA/j93LcqKAEafDUsLkFq?=
 =?us-ascii?Q?uUmIxTIyG+wvFKRd1tRQ4o+MNp6gmW2ZgV50ESOqY103fSeUlfp6QCmh2cBH?=
 =?us-ascii?Q?ao502tc+O2xqbiNAxTPg1BsaWxW2a+UmUaHHloDw8iiMXTA4WTjADx65A32F?=
 =?us-ascii?Q?+N4/tnZFQr2xGli2oY+m7VcSiy9CIdk78LurOOsc0NivONGgX7CcCy8/OeBC?=
 =?us-ascii?Q?KGk+haRw4KdC37YUU7INZ81XbrMogy8nwfkIWk01WrSY/p9R2ysI0CWRxFAM?=
 =?us-ascii?Q?MtLhCpgSXCoRtjhbZOJ3ZZTeyG4cVzSBK+Sz7HwicADQop3nW7Ton3/ZErCz?=
 =?us-ascii?Q?amkrafcSPhRR8XBiZXhqXDFUwT4l4pczlNVPGruxNwrxcQLw9qiiF4ezTL6X?=
 =?us-ascii?Q?mOWxifuR1frE/HS27jkp5j1CFVhHWRPudr6YJAy0Pv2CLMuoM6RFUpXXUrzu?=
 =?us-ascii?Q?MSeAWiDm3LCzAuOsMAw0Opt6XlS+JH0+ZG02ZbaxkflvtpqkIaedU0CTybYG?=
 =?us-ascii?Q?gkdW2JWvObvA8grcYllKhqFVIbPS3HFEAXenEjdBZo5WgYfhS8nm0lmF2J2E?=
 =?us-ascii?Q?nZBG2ayvw50+SbHmZKZ/qAlfMO5Ymdfna7fgpShtBuyGPb77kS3P2p8P2Zm6?=
 =?us-ascii?Q?QI/nU+GbrBs4eUE+L1Jg72tqvQX/XZrbrqt759wTYrgNlOTGq51ueoZyYQgV?=
 =?us-ascii?Q?sVQeawh6WzuFePVJfinWLs9sfLgB5e8I3hKm0Ly6G1gELRsSaOiE/W/or4DZ?=
 =?us-ascii?Q?sT+F9rskHtNiAkplFGHT4e+1qOmiFk1pdlp5uTzYuzvxhEb/sHFdCmFhTYxX?=
 =?us-ascii?Q?Z9j1APg42fOgdUCKRTcDaQIYiwLkkuyPD4jYh1TYidt3IpoPJA78QNz6W7uo?=
 =?us-ascii?Q?g78Q5HeKBc8CKkzNc0IzmIhB0kFn2AE1uLwipJ6VMZJMqO19qKxLytpK7nBA?=
 =?us-ascii?Q?QzQesoKvdhlaoFi4XR06Rg+FPWGsw9LR6KGYROpB0Omy0bbVhAix/3TEp06u?=
 =?us-ascii?Q?CkhwYzKVNBqOxDs/Pgw9koONp3T0qV+0WkAJk3iQEbSd2lkwHcHSY9cdPME6?=
 =?us-ascii?Q?r8l+wT6xmnVvEfsLL7g2v74hg4UA8xcxygYVtpc452qbpSzP1hHhyGv2KvMn?=
 =?us-ascii?Q?QA8PsViCbG0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/ZoObrrEiBOSs768grJDQg+1jLegxvS1MUA1T8vZ/LO64wt/VCjDRBJmCtzy?=
 =?us-ascii?Q?XBr8dVgbj+HtlppigmkX0E9YKsaRiCwvBpRpGn19mooa82pEd0yn//E+Ysf2?=
 =?us-ascii?Q?XxwbjXDmtdqOPSh1XRl1yOgKPDQZFPnaelSVpiCrsUxPHwcpsh8ztjiItXz2?=
 =?us-ascii?Q?W3e7nn5Mo4xcDroqPC5o6S1RdvfeGpBtewJT9Yj/+P6+XYBNQRqJXVOla6Kn?=
 =?us-ascii?Q?bjdfYMSobwnDN8K4BRKXXw8WqhPWrTdM/PQ7c9u4MeOicFsrZrqazoKfzzZt?=
 =?us-ascii?Q?YFNW9t3TAchXwL6qmtAHqJldIbj7CBt4ERxXJHxt1aDIwI75htlhSOFqfdZ8?=
 =?us-ascii?Q?hvvqF+RAw7xAviQF0rO+J1iPtYdj/6tAcdc8HQl3Ch+lHuquPNJRAm2+bfjl?=
 =?us-ascii?Q?V5eCtkbgPEBSjwkZ7aW/Q6lwA9MuTEY9Y6ZNHfCQ+u51LYJFxW3/H5fIfYp1?=
 =?us-ascii?Q?ICnbzY0iHN/Vtpt3sJh0IR5qHMXrPsaaAwgpuxIp7cD/m+5J2hNCCSZSo336?=
 =?us-ascii?Q?rQLkztgBeVJuwXZ3AgXIzJZLC+/t8gpEve8/hDOVh+4clcjGL+1X2xi6GaU/?=
 =?us-ascii?Q?Xuw+WEnkgT1Q4j13U32qhoM5SPrxzZAlS5t6/IG983LJwswZkoGfhah0klA3?=
 =?us-ascii?Q?1X/pw6w0yfxCarBHfKP/tu3bwEqCY69iz1scz0P2lc3JUmaePi9l+lQSYUcY?=
 =?us-ascii?Q?wb+20380ltiCV0UA/gzUkooQ70K++C/j9jLu6qz55G8XoSqy3loBaHmig89R?=
 =?us-ascii?Q?/GsFx8nZRn1q258XbLowrC1Mx6dX38weoBdQ7GfCCIqEp04xHUJr+Rzpa1fM?=
 =?us-ascii?Q?tafiZFnBsqUdh2Pz5AhutqBOBep/jV4NJB/H7hUkgwHsNY63k8RM0yOGVr/c?=
 =?us-ascii?Q?sroX6yUKDVgynH5ihY/Ze9uetwDHlKmZISRbDqM53ZJW0RBNBn54P2Gh47OG?=
 =?us-ascii?Q?3QkbTPfvfqjSqXY63WheXv4yx8iq9ct0V+Id33UmpZFA1wjKf2deZJMNohc+?=
 =?us-ascii?Q?Cov5zd2v1dNmuVNlLYx6vUZblk95Fo6jAZvFwYSIK9VDYTNVwIJdvMjr1rK4?=
 =?us-ascii?Q?cV6WvJgFrijOClng/CUB1fsmQKd99rNFZaaIyb30my8FwOafExgH2K0+PB0T?=
 =?us-ascii?Q?ErEQbSHKk3kohjc55YNQRJr1qHtqw4YyukNsn8LonKXcw4ACDZi8Hq3C+78y?=
 =?us-ascii?Q?OcOHCM2kjlfkBEVEdJUj8gNBtzF1FcMFuJrjx01jWG0bWSH1iXXPOSG11Jom?=
 =?us-ascii?Q?ONbtxHs9JIeatxATf0giCIdz9U2KfKlhpsoV6ytVBsd6HyLr1cMvdr/48IJm?=
 =?us-ascii?Q?nyqfdRghm4QxrxUjo+unXZUFHlxLvrQY6chodrChHBXVN08Qw6eOgc/6k1xk?=
 =?us-ascii?Q?8dTUTo7kNrROCFnx6W9xeiMSKr6vN0zkdlhBMdnGfXaHbuUaaff0oEfL+Qjy?=
 =?us-ascii?Q?ZKSqBDqtjzDdRLidJmNuwIxbPCscRXHuxTRHC4O23aewsYp3jTaNLjGDlhrM?=
 =?us-ascii?Q?FaKrPsjaDNvHt2+p3TraIXT33u66+28XePKC0cIzpOXbYsHQGBUpR0Iyc3Pv?=
 =?us-ascii?Q?5eZHeAAWn+GLnJWPUMU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d3aa9d1-a0aa-4b6f-8805-08dce1968769
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 21:26:21.6131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nryYDIiVQJLH2Mx2eIqakerZe9Zf9ey4OBBHgQ5MH0EGCuW3uv2HN2FpL3zSJQb9KItyJXKVbEzOdkz8sTIDsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7601

Add bluetooth audio codec.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 936ba5ecdcac7..d8d9e2883caf7 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -12,6 +12,11 @@ / {
 	model = "Freescale i.MX8QXP MEK";
 	compatible = "fsl,imx8qxp-mek", "fsl,imx8qxp";
 
+	bt_sco_codec: audio-codec-bt {
+		compatible = "linux,bt-sco";
+		#sound-dai-cells = <1>;
+	};
+
 	chosen {
 		stdout-path = &lpuart0;
 	};
@@ -45,6 +50,25 @@ usb3_data_ss: endpoint {
 		};
 	};
 
+	sound-bt-sco {
+		compatible = "simple-audio-card";
+		simple-audio-card,bitclock-inversion;
+		simple-audio-card,bitclock-master = <&btcpu>;
+		simple-audio-card,format = "dsp_a";
+		simple-audio-card,frame-master = <&btcpu>;
+		simple-audio-card,name = "bt-sco-audio";
+
+		simple-audio-card,codec {
+			sound-dai = <&bt_sco_codec 1>;
+		};
+
+		btcpu: simple-audio-card,cpu {
+			dai-tdm-slot-num = <2>;
+			dai-tdm-slot-width = <16>;
+			sound-dai = <&sai0>;
+		};
+	};
+
 	sound-wm8960 {
 		compatible = "fsl,imx-audio-wm8960";
 		model = "wm8960-audio";
-- 
2.34.1


