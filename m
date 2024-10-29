Return-Path: <linux-kernel+bounces-387206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FFC9B4DDC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32121F23776
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D4E19342D;
	Tue, 29 Oct 2024 15:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V9JCgYMt"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2064.outbound.protection.outlook.com [40.107.249.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D543A1922FA;
	Tue, 29 Oct 2024 15:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730215598; cv=fail; b=b1UsP+N0iDrHE7bWJYf3+5G0+xeMhtBUx8gMuf40l5d3hICuYTR6k6KjuQZk9dwa6tk0u6A+CF9woSggU9OYn1V/rBkt3UvxB9PWxW5CEMN3kdrJLvhtlaxV/cOyXrEST5fTpRQMVo1luTBzIWfS93OQnmRRVbCuXalQu6W1RUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730215598; c=relaxed/simple;
	bh=gctR+Qvif27k2eguSJUHFczRaQWiJ0H/8xn8kqyBNIQ=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fysI0LjWfL+CD/4WP12niV5bXtaKylNHsACBszeGpnobC4t3nPRd1uG4oi+d4Ci5uifB4nRFjxupMXHB/hE0ROA4vD+V5KaucrTwKknuEUItWmqdf3D72GnV5MdsJ3X6bwmus3aW396dweyIgd0z8TDASXyFcVISDUminQXgiD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V9JCgYMt; arc=fail smtp.client-ip=40.107.249.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ya4eRUBy2mU3tmy8PK389yx8Zb5vgw97zNZSaHutZn5GHA1SgljbkKZ72uXozaix/PYnH+LcOhQvBv5DCkPVaCXvc0/+XnUvWvXOANnFZRRHlGtQop7yJsC1/y9I2jDIpA2dEeHmuqFKhGkwnlnX3qc/vmYxXsvKVb9KGRkMbwxWkIKuhfgUj3VfAi1SBp42hd7g1nf4E+qMBX3at5KRF4Lcqx1IwqnlT58lRD9Vj1cPlR12rm6/VmHbotAZ6vDfLtHSeGJduH+ycLGmJqf77MYPA4UzIuwsfif3rPCljG2754jsiH9vVHFWqTGpDKOPYtAJ7nUl06+K7R+HCtFIpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwP1vTa/ijCmD4sbhkkX/qtyeZBmGoSiQg3LwCW+PTE=;
 b=QGM6INz3D2xp1vqqhYsnV7rVAyzkv8WbP35Px8ihAm6G48zeX2yYBYB3RgwRUkdThp3YKYvRXqxMFJJMll4F6Ik9TCg8zAeJbU1Jxqe9HBIyxt/1NOKCbBTorBc55mtGCw4pGxKr9zCYofk+CG51DhvMkdOycd9o6ZHLo4DGou0D6g6rZLsnht5TZG/1el6BgQ/A29wzVO7/RgOP4tUTbyzcypevsWaOXnTMHtz3yhxajbrHooWggx6KH/HqLKCEkgUZlcqNGG2DZqbIDrLLxrOGGvqUxpceRafnJ0BMCoLCdf0gUuorVVdm8w21lL0Lg4Uiyy/Vjjz9QId5BPDxJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwP1vTa/ijCmD4sbhkkX/qtyeZBmGoSiQg3LwCW+PTE=;
 b=V9JCgYMtPyoGjoN9WrlfvA6pd37UiowUNK6nY2+syTNbFJVQSbqooKPutraann6anSxzPxgajVymQvvPJqX0+naxtvRfq04PkgZujnDPTXv8xblo+DKFWNyeEKUo04kFjsY9CaBXNJ/VVJY1MJVzndlhYVJLEdr64Nf4fUZV3CIk3XXfdxiuqaitVyt8aU8/7mh82aLJPuyD55/KE+hiGtWArMxyrFd1QybiHMFtzDtO0oTvO7wsNn2XnbSZoSXbq3MBEORB74hzMpD7wc1TP+m6zy/ou9Lr4Wqn5sUd6o4HK1AUPEk85W2HeSrcniu5BCULQPUFdV99vesEfHIrQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS8PR04MB9112.eurprd04.prod.outlook.com (2603:10a6:20b:44b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Tue, 29 Oct
 2024 15:26:31 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%3]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 15:26:31 +0000
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
Subject: [PATCH v2 1/1] arm64: dts: imx8qm-mek: add audio-codec cs42888 and related nodes
Date: Tue, 29 Oct 2024 11:26:13 -0400
Message-Id: <20241029152614.2065950-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0158.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::13) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS8PR04MB9112:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e8f26aa-67a1-4114-4b5a-08dcf82e10aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KKm/QZP6rdvrCk5tmhA/NxNkEX8x2FcmtD9KjxrDeLxXH1RtrB2m5MeS1pnt?=
 =?us-ascii?Q?TlB96evtH6Ck6jvmD+tzyBogAKmr5jn4ZWDW2/JCmSQ7H1fcsMt3Rcb1I3yu?=
 =?us-ascii?Q?LEhAwbPMEr3ofLnjEnTm0QxRiyVQMbwhZaJz0IXrj80UTvOK5RMUmh2P17R4?=
 =?us-ascii?Q?Z8T+j8gFEvJKBuYxMmq81fM9JYCi7X+8BRPWKs0m8mpob72m7sOC3G3WvUXl?=
 =?us-ascii?Q?wIE3xIjskrPkWjVj0S/2TqT+bX2xfaWta7FYOpqzpC2gAjRw/6c9GrVQ3C5Q?=
 =?us-ascii?Q?NVfBubtzndqGudcx7aI3HuTEJrNJccUvL2WsVoAOqf8m1XT1P7z3YC+HMgJ3?=
 =?us-ascii?Q?NW9KCIhc7BrLCHeocbeeivUrigv65Q07TSdIhy9a5MIYtLIsx+vu65LwAJUs?=
 =?us-ascii?Q?+M95ndKZehgZ5gnrIp5fP1VQv4k9ZZIEIcnwO7I3qdcZj5scU4xvu4EGdjT+?=
 =?us-ascii?Q?KFK6jWzgp7fH8P4YG60BsA8n6sIIuLzK4PTJLO7esT2bTss5jI8WSDHFdoI0?=
 =?us-ascii?Q?GArvjJBYFxdFJHFb95tX1LbmIVGO0qzqZSu58p9AbD/2WZDoLwJqrBGATNLq?=
 =?us-ascii?Q?+4KoqNubz3F/3rJkcJO2CUMug0yIzeaLyEwdu+1cc2B45/SnZjAMCcNBIvUG?=
 =?us-ascii?Q?laCSsGgibXMTYb+WjOP7bMLkPQCSzebiREnvcCNL/ZCwQJVnHfPNRzEYDJPC?=
 =?us-ascii?Q?nKy9R3va0I7jatN+lCvvLnfBmzUhOak+vQTEwgDLahSvQGc98gbx0KqISdZy?=
 =?us-ascii?Q?fuRMEMM4NWWBxfnm4uybH3gbkJI1UnjORn0i7yqVU7Q3+//SSK4VK4lwd9ZU?=
 =?us-ascii?Q?VSn74ZIcyD/WTlF4Q4CIjFffPJCbe4VgIpci3okaPhNFfOZ1k/9r5Vq3YGBY?=
 =?us-ascii?Q?0j1cYC35ZJeCr2WtE4Sa32hLzXqaPtqwzC5zrxldfsJQc4du7gL/h3g1R6zF?=
 =?us-ascii?Q?4ViEuskoTW+FdRyva0qkaafNhwf9QFBeea03s7lF7raz6akQP63dyc1IdwFC?=
 =?us-ascii?Q?rzpOqldci6/FrxRzJhhtUacPJAwSa3MQth4YwK8l7gcZGxgWw0SqfG+IJ5DP?=
 =?us-ascii?Q?OjwZzQKNqYFAbcb/XEQTXRErMkmA7BEFUW8EknpVuOGXdLMBxCcvh9sg7LR3?=
 =?us-ascii?Q?xnpDbnOaVXXn+Zfuxquq4WI2ynGJP8WTeFitVpZOgGMDIX8L7N35nNeniVjF?=
 =?us-ascii?Q?cNqfM67ss8yFLuvqBX/aMlB++3QNvfHIEtsYrz/bNvwsFrYfmM9ddIcAyWXY?=
 =?us-ascii?Q?h8czfIVFznehIfIfVGpKmFtSOtUc8e6BMiDsmWjKHZSxE/i9ZhMtCGEeS3xA?=
 =?us-ascii?Q?HnE2F7sMq5Nsxb8ZG34xiKKslcFSCAiQTIuarZLw+n21AP5N75WbN2WJduhJ?=
 =?us-ascii?Q?6pi1wE2HxBJgciqYc+yGA7TtFuYH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fh8F70xk5cMfXqoAvdHhz0T94GwoKbu6PD1zHp4H36AlEPguwag8109mTHzd?=
 =?us-ascii?Q?F9bA4tGDsw8x8g/SM13e/OaqGokiGYd2u7fbASlhxjjdqXgBz4k12g0l8QgE?=
 =?us-ascii?Q?OeDc+bjHz1FEFrqIbPRnWGxBQWDQCUXVA/nplS8WdGrsROJYEpJjs7K133c6?=
 =?us-ascii?Q?yjPojSEWd/wq60hUSjSJFTmJBu5d7ZR0XwSd7clrsiMTLasiGxo1lLEoDW+N?=
 =?us-ascii?Q?iT2PwXYH722Sq79aTOzJgDUEaMwVRwBjTobM8hbb7Zci0QlQ+fErysZWRZGf?=
 =?us-ascii?Q?sqjhWk6P4qEjfFMQRSxbANdPEWW9qbSDZ1Vcp+v8rhB+Kd8+XpofK6sJvaYy?=
 =?us-ascii?Q?2UgTxYWfuxGx/qerY2Rd09exOm2wDE5fDkTadCEaQb6d+QcSVohJYxtOUpQQ?=
 =?us-ascii?Q?mcoyIGVktZhNI3RHm2dMEpyhgGKTIQnEnZdYOy3Op/rx7PMOuB+xm/nBvYvC?=
 =?us-ascii?Q?CdgSCzg4drsYyiLplvWmNfSC92m0GTOdqbst4n56b6FJHhi+KM9zZJjjAoLo?=
 =?us-ascii?Q?bF4bEjEV1XDC2eRgm92p29d7L1NrahbyTe/nRTv60YSqJHYmyTFd1Sh9x7nR?=
 =?us-ascii?Q?dIY3Q0qhrJtdEk/9nTu+VwLMBhayWCwTD+8oCMvpojqEH5yvDPXe2Xj5TY8h?=
 =?us-ascii?Q?ONnWUi3Hpjd0LpDcnysDRybNsPUm9M/W8v0M2Kjw4yFi8fgPdKgyy6fRuwjs?=
 =?us-ascii?Q?XBrwipw99ZW04F34+ZTutraA7dcbc636SRlxQAtcHENHlo6npqPBzMHc/Z1u?=
 =?us-ascii?Q?6PdN28ava8/VpdlwoVUa3mMvvr8BbikURR49+aLnEgfgLZdxjE+Jt2bkgRDZ?=
 =?us-ascii?Q?lFVtIb2IrdVJ84iWoSWedNzRJMyloGjvNFQ2FI9n44e6w/4zNdEXch3Zt8zT?=
 =?us-ascii?Q?kntdYhBMe2N48rrCNit5u1JSXwjgV6SwGARKxRde1VIIU3PzR9fZiBwI55A1?=
 =?us-ascii?Q?fnzdII5aBS3MnoE7ni3avka3ETxb52boj4M1fS2DATPhKv5hLrf/DaSJBYT+?=
 =?us-ascii?Q?sSwnC1D//Sydejl7lk7D2Eoz+8aWVN/nuju7R+LO7oJYfzYgWGWUKjj4UHGy?=
 =?us-ascii?Q?0XrVfQwk5P13fbqElL+I+eFGl1MN4aNZb4t7CdROeKEbiV9roiZlPdOcPXC1?=
 =?us-ascii?Q?Y3y8Cpe3ktQOCjDdQDffOSSHM1eenIZwuaJraRNCig9Dv428FK0RCstn25UN?=
 =?us-ascii?Q?MF5GqbyCvnuWWbPTUEXRcAILYosi1qScv1zNuJX6fxpGZqEAwn3kAVNr/E15?=
 =?us-ascii?Q?yh7P4uiIfYht3Hc72TrSDdDfniGYU4cX9kD99DJsyfA2sCs26l0sEr4zjgHf?=
 =?us-ascii?Q?EkQBadkoDx9yPx3nTGV0rT6Nw7L41BGJNTb9H5JsSiK2jzcWUQWYG4IY7/3c?=
 =?us-ascii?Q?5vB2Kp59SrKtLCqRwP3UVTzep9/TL/5aQZK1ARqok9ZnlZu08nhapb790VFk?=
 =?us-ascii?Q?se6FAWPSPuzbHmsAvbNCZW3hOlh7Y+mJWN/uOz57JK9DMSoIrUh9ipz4xr4I?=
 =?us-ascii?Q?wi86SxHX2hhOrpT1UJlEyejmob2jmNQl9r4Lf5YGXaXjebgG2WCLhXNWl1U6?=
 =?us-ascii?Q?r6AWI6iw2jd8VpvRRt1vP1FMogSGoqfKsTb2K4oC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8f26aa-67a1-4114-4b5a-08dcf82e10aa
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 15:26:31.3859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iAXsGy6emyiYNqLkYrTmwG1rVmqUfEs6blf2dN85KS/Je7i4kN5Q9pKegLWaZYN/SsAnTmMAIkvzUzjpmztdgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9112

Add audio-codec cs42888, enable esai0 and asrc0.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- remove unnecessary status=okay
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 80 ++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index e983633a4bb31..e3275b276a7cc 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -134,6 +134,13 @@ reg_usdhc2_vmmc: usdhc2-vmmc {
 		enable-active-high;
 	};
 
+	reg_audio: regulator-audio {
+		compatible = "regulator-fixed";
+		regulator-name = "cs42888_supply";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
 	reg_fec2_supply: regulator-fec2-nvcc {
 		compatible = "regulator-fixed";
 		regulator-name = "fec2_nvcc";
@@ -223,6 +230,26 @@ simple-audio-card,codec {
 		};
 	};
 
+	sound-cs42888 {
+		compatible = "fsl,imx-audio-cs42888";
+		model = "imx-cs42888";
+		audio-cpu = <&esai0>;
+		audio-codec = <&cs42888>;
+		audio-asrc = <&asrc0>;
+		audio-routing = "Line Out Jack", "AOUT1L",
+				"Line Out Jack", "AOUT1R",
+				"Line Out Jack", "AOUT2L",
+				"Line Out Jack", "AOUT2R",
+				"Line Out Jack", "AOUT3L",
+				"Line Out Jack", "AOUT3R",
+				"Line Out Jack", "AOUT4L",
+				"Line Out Jack", "AOUT4R",
+				"AIN1L", "Line In Jack",
+				"AIN1R", "Line In Jack",
+				"AIN2L", "Line In Jack",
+				"AIN2R", "Line In Jack";
+	};
+
 	sound-wm8960 {
 		compatible = "fsl,imx-audio-wm8960";
 		model = "wm8960-audio";
@@ -301,12 +328,44 @@ pca6416: gpio@20 {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
+
+	cs42888: audio-codec@48 {
+		compatible = "cirrus,cs42888";
+		reg = <0x48>;
+		clocks = <&mclkout0_lpcg IMX_LPCG_CLK_0>;
+		clock-names = "mclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_cs42888_reset>;
+		VA-supply = <&reg_audio>;
+		VD-supply = <&reg_audio>;
+		VLS-supply = <&reg_audio>;
+		VLC-supply = <&reg_audio>;
+		reset-gpios = <&lsio_gpio4 25 GPIO_ACTIVE_LOW>;
+		assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+				  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+				  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+				  <&mclkout0_lpcg IMX_LPCG_CLK_0>;
+		assigned-clock-rates = <786432000>, <49152000>, <12288000>, <12288000>;
+	};
 };
 
 &cm41_intmux {
 	status = "okay";
 };
 
+&esai0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_esai0>;
+	assigned-clocks = <&acm IMX_ADMA_ACM_ESAI0_MCLK_SEL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+			  <&esai0_lpcg IMX_LPCG_CLK_4>;
+	assigned-clock-parents = <&aud_pll_div0_lpcg IMX_LPCG_CLK_0>;
+	assigned-clock-rates = <0>, <786432000>, <49152000>, <12288000>, <49152000>;
+	status = "okay";
+};
+
 &hsio_phy {
 	fsl,hsio-cfg = "pciea-pcieb-sata";
 	fsl,refclk-pad-mode = "input";
@@ -691,6 +750,12 @@ IMX8QM_SCU_GPIO0_03_LSIO_GPIO0_IO31			0x0600004c
 		>;
 	};
 
+	pinctrl_cs42888_reset: cs42888_resetgrp {
+		fsl,pins = <
+			IMX8QM_QSPI1A_DATA1_LSIO_GPIO4_IO25			0x0600004c
+		>;
+	};
+
 	pinctrl_i2c0: i2c0grp {
 		fsl,pins = <
 			IMX8QM_HDMI_TX0_TS_SCL_DMA_I2C0_SCL			0x06000021
@@ -725,6 +790,21 @@ IMX8QM_M41_I2C0_SCL_M41_I2C0_SCL			0x0600004c
 		>;
 	};
 
+	pinctrl_esai0: esai0grp {
+		fsl,pins = <
+			IMX8QM_ESAI0_FSR_AUD_ESAI0_FSR				0xc6000040
+			IMX8QM_ESAI0_FST_AUD_ESAI0_FST				0xc6000040
+			IMX8QM_ESAI0_SCKR_AUD_ESAI0_SCKR			0xc6000040
+			IMX8QM_ESAI0_SCKT_AUD_ESAI0_SCKT			0xc6000040
+			IMX8QM_ESAI0_TX0_AUD_ESAI0_TX0				0xc6000040
+			IMX8QM_ESAI0_TX1_AUD_ESAI0_TX1				0xc6000040
+			IMX8QM_ESAI0_TX2_RX3_AUD_ESAI0_TX2_RX3			0xc6000040
+			IMX8QM_ESAI0_TX3_RX2_AUD_ESAI0_TX3_RX2			0xc6000040
+			IMX8QM_ESAI0_TX4_RX1_AUD_ESAI0_TX4_RX1			0xc6000040
+			IMX8QM_ESAI0_TX5_RX0_AUD_ESAI0_TX5_RX0			0xc6000040
+		>;
+	};
+
 	pinctrl_fec1: fec1grp {
 		fsl,pins = <
 			IMX8QM_ENET0_MDC_CONN_ENET0_MDC				0x06000020
-- 
2.34.1


