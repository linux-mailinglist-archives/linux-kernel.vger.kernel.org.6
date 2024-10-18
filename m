Return-Path: <linux-kernel+bounces-372229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 004329A45EA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76C391F24D92
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 18:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885CF20409D;
	Fri, 18 Oct 2024 18:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UwZ1QFh+"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2057.outbound.protection.outlook.com [40.107.103.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AAF17A58F;
	Fri, 18 Oct 2024 18:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729276125; cv=fail; b=QvHB3xrmAOFhN4lmqMbp+w0qFm8XRE2nV85BHmDqaxW5vUZTUApERkRGa1T4wL/rku5FPlJ39CkYiTgaVe8BrqPXQ5EnOwOfVBK3jnoetv8oTGuym0lYfszXNT87kH9anXMUSxnZERYzpi3o8i9aoK7gV3rA2C3A7dkBBbNesE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729276125; c=relaxed/simple;
	bh=chxR8J3P53d/hICJhEnpcZO8g+H0RngpGLDQwhHVmZY=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=AdagXPfD+0ann4byhMtlOPPNek53eGiZn5W9DnC67hooj3Iu/m+x7egsYiAHhHew+zdqSeiVGDHYX9ILoZ5ZLj71CrpAwSqXgofQAbC7dmKBsUHd3JbUqP4uTa7yTGSu3YAFJPSJp6iQOfqvi8BCmfY7ECP0iHj5NRbAgrBf9LI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UwZ1QFh+; arc=fail smtp.client-ip=40.107.103.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ehMm+whoyKQsClaAIDzGIF/FfENJWfybQuhlNp97Wn3Rs5oWijhnobWEYYyYkIk7o5N069ROr2BCcbTYDAKhABHJYA4Xm8m9KpahUsxYXo+kuv2EIBqqHXcgAjanW7pjaIgdstak4KvHTlD7VAcwU/kov7VBcF8hz5E+34CzNhkZX1FySUw6rR6gyVi7mjtrqclCsgXbc4n4wPwdGMG795A9s1pYPVWQuk8OFaof2ufDxWEhFWw6TY8zmNeIflojtxEew7ri1JIQAK6JwvXszQLOmkDdVMJRB8Qfa+YeeKReVDHTHcmE9I48M4JJa9OIxRx6D9TBrmE//iu7dLLi+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sm4aqwCWm08D6BU+pkmi2S7st3ZfljzSIUpg+psCh7Q=;
 b=Jh0q3uUX1L6ng8K3XSU0tCVBB46yt293DgX1hgIRnLA+SWSCt0OdM5u3nCdjMp0MPX6TYFQparMlfsy5dkCcoEvhl4fsg0z2Vl67d1yMllV/RaBfWnfnw5lFeDBchtE5d4LBkegOdnHjo2pFEak7gJAlapWUvfhZ5fjK2Fdk/YfapTBbdKubdkY5Cl/QLOEfAx2hX/x1iX19sdpaXVDOtPXjEbntkcuthJCVhzAGl8UHdhm0w6bqBovhMqgffm5uH7hb3OE08J5pggmFtzhAQeKiWXjY/MYlcdhEycxzAOb+mBVkRldRaNY81Ls9UTYJztpTorSlzMFkh0uhQ7qH7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sm4aqwCWm08D6BU+pkmi2S7st3ZfljzSIUpg+psCh7Q=;
 b=UwZ1QFh+6fgjaKaWD54RKLaprpukmRf+HgxJM7SZEKD03moy9In7G3coIswWvASFZ/ITycykLFlWuu7MeE0mEz2RAbp2o3iVSYubTaQgktxv5AoGuD6823q5M6QFQFaJLszNAxK4oobwPzEh/tBtSxNTQbQglpTQBTu1ENFo9jHWk5W+C1nnQlTHZ8ZZi1JmcFRVqHaWHOgxU2hcveKjFt/z80v4IgkAX8Nhu8jf6GK6CVQodoD0h0GiToorIaBBN6/MN9ggzcl5xoEwDNNnAj0eIGncnfVDAEU3pPEtPF7NsUd9nHNKs4HqLapsBDq0nee9Xxxjl7Yc4v4JMeffag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10416.eurprd04.prod.outlook.com (2603:10a6:102:446::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 18:28:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 18:28:39 +0000
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
Subject: [PATCH 1/1] arm64: dts: imx8mm-venice-gw73xx: remove compatible in overlay file
Date: Fri, 18 Oct 2024 14:28:23 -0400
Message-Id: <20241018182824.740133-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10416:EE_
X-MS-Office365-Filtering-Correlation-Id: ea2f1f13-aadc-4c4c-0bdb-08dcefa2afc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hi8q2n6Xq4yaTv2EhObWscYvG+Z0tQ1vH+yN2lG2xQNZnvHkfmTkXRK+4zM/?=
 =?us-ascii?Q?b3L+y5B9IhtqnRB582HfXOAn4UnzojRDg3Zqhh6z6BiunVVLNrTOKqbDC5xu?=
 =?us-ascii?Q?xwZ4XU7TbM0x0bRNwRdsh3/rTMneq+yvXpwniXay2/q9wNIoLuVBgqnlKC6C?=
 =?us-ascii?Q?EgSj5jfi8Or6TyvoOqUdRr/hsGlZqx+rfYvioF5ATGuAIxISdZfVdsTP4pRh?=
 =?us-ascii?Q?g7ElIrFv6ydM7V4Q+EBv8Oy+g97eDhEpdSwEqgy6r4p3JrIfF+uGrWe5R6Bg?=
 =?us-ascii?Q?jnONsmp/hoWDdX6+dIvRqq8nnbawX4VpmGwFYQRXvTNfrAz4+0ZtwcieJY2+?=
 =?us-ascii?Q?CjXRG9kslvgRIHqLIkLVuCu/ycJIkMAHtIqIDSRokKXcwvdsfkv9IwU+QAf0?=
 =?us-ascii?Q?gIXGNJOE32nNDKnFn5j8kyuAfsVV5DreONCzj2QZ4njrhU8Rnrs/7CKR+ODm?=
 =?us-ascii?Q?l0FG4SoZL3+lt7Q33Cuaij2CYD61YK4su4xgrpbDrrDqEFmh2ojVCs7zazFj?=
 =?us-ascii?Q?3h2lk6bowSkh8xb6/BtSYxophHkHnCm4Wflzn8sULNf3zR8ERvbt5hMhs4mt?=
 =?us-ascii?Q?uMOKAQkYFSy1u9f3gjnVMQZ/4ECw2uhaF62lMI1HxmCS30ipExllfX7WPQ5N?=
 =?us-ascii?Q?ELbIKTGfdi1MPaqzKKY7N4KaygRQV1NwWAYvz7isI+gTWBwJR4dPMasO1irJ?=
 =?us-ascii?Q?aJxOXeaojbNULbQ0BXc1FVZ2eKPZUm0zthSwwpklJG/8XNLjTyJOWRA04gYJ?=
 =?us-ascii?Q?SZRvtfhxPwWt3dEkJpg0368SajIZs2MOTiWZKqn949+wyCyf0Cjcrmo9ao8t?=
 =?us-ascii?Q?oONZPwmN5wnN0upp3DYQYfhKhbmFxFsO7d3GD3KKtfmWUumh00mVeNEeAxLF?=
 =?us-ascii?Q?xSGCHZUAlBqhSJ4r7f8Rlxk4WeDjW0qpw1977g5/ZvS+viABctfnMy8qlRDO?=
 =?us-ascii?Q?cOeoCbGFuugjGENjLWJMGzbIpHyljk7jkFkP9hGLYf2JgoITaDgNO5AnUl3D?=
 =?us-ascii?Q?blOJWdkrBT9ocBZMTtkxzb589qBWiqIURWe6FYcE53gpdE7tqB0xfFCEm04k?=
 =?us-ascii?Q?tZoAgb/Kg1sZwp2iyBseIZh9Llu3A2tZSmbv3YSUADGWr4jG7H/OEd12HQat?=
 =?us-ascii?Q?dDBMy4RMY0jLeofO8pN5z1QXFcm96SfRgsLk2hbHa4ZoHuzBb4mwOOu3h3L0?=
 =?us-ascii?Q?7sfWt9cZ8DVFpCF170fwUAmTKAvXWibwjClyvJFwDlzbbIX9voSZDPU2rWIp?=
 =?us-ascii?Q?nXj2uWMVyQ0r3RATSVKV6CU8ELsFfCXvWKGUw1K28Rp/FA9xwbXG1C0bj83s?=
 =?us-ascii?Q?e/EaxiXkQNNkuArRNAN7EDHKmDtziB3bCmbEKyMfRCjhPeHjnaAyuramNnkx?=
 =?us-ascii?Q?0gUAudS2gPXdl3xNAhpWuZ9cPceG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MaZhf6euVdeGIN28p9bpg06ItNPDb3VCQn0HzpsVHlPMMvAP69aywpMHxuw9?=
 =?us-ascii?Q?9gWzxArGhjsCHHRJSswCB4NXopESTTe9grZ5JDYzu7wJCcyqEqszRYpw6kxv?=
 =?us-ascii?Q?XMEl/IeFPb0+hgL19QSuIjXSzC3tsOGVfBpZz993VVYHveBs8mXYSlNfqZK4?=
 =?us-ascii?Q?aljCbGe1F+XYLKClK6aBQwe32apFLwE8bo6/K+ZkqWUgy47x2yIAgYQi+oxk?=
 =?us-ascii?Q?RnKPMhae59UoLGzcT2HtzWkfmIHmvoAmalZpEfuW/pSBx2trINBfP5fIZpuR?=
 =?us-ascii?Q?jCY/q3UfBQzRAog7gXqvgRoUbebSkiavM0wny7ejz71kO+71VzS9RvCVD4jc?=
 =?us-ascii?Q?Ep5EnMEcmOBKKEKUmIpoThgkraCIAfq8ggDkGbf8yuUOmBzD0Pypq/72+xFy?=
 =?us-ascii?Q?3h1ybVipbe2DuT76ilOwkJkVGcS3DEi7buYu+rU4s3NSeUINVzdxu/eQBgOs?=
 =?us-ascii?Q?8uIgDeXksGbbd7ldNfdUFzjikXQjv/hswGCnyhK2gJDHNtzmyPcYVmRJ3/hW?=
 =?us-ascii?Q?rMKiUXPYMxgzn95/nr4cL8d1B5I7itUggr2bGwoZKM/QorAkWhyleD29AqCB?=
 =?us-ascii?Q?JIXRSvEB5ySBxbLYJmE03i6cOdbJfU8QhTf2PtyDzTcjzzuA75Ny5QNyyscN?=
 =?us-ascii?Q?COQL7MM8ZevoBhG7M/ZvkGrAYlPou5uZLh/Zbl1eMV2erj2YNEZ3zf4oPIlp?=
 =?us-ascii?Q?tU/vWfEhZ04ZWNdYa5Sg91naiBApwDu/RMnKdI1+0tQj/pmWdftzwpnNk5sa?=
 =?us-ascii?Q?P+FsWY/gDRqjebfV5mWAvQv0cimOa78Dyb3F+i16xIio622UmM4w2iEax79k?=
 =?us-ascii?Q?2Wyd7GP3CDPDgVTpXwfCs5dqayng71pFR4gL4MSVyesQqghZxgIzO7Jmyt2k?=
 =?us-ascii?Q?gRs825UkiuUJGVN+NeGOyaWlb1n6jix5mdje6IjTM+++HwJW7S3fkIuczEf+?=
 =?us-ascii?Q?RS9Kshnr2ciA0C+jp2xJn6chie3/QnoforpkQq6V98IgKwrMUomg6g0jkj2k?=
 =?us-ascii?Q?qmU3tO2/Y4f6a7D+Hfown7elmhwqYDWyR5oROZH4+8JY+g2GIby+RNE8hTN7?=
 =?us-ascii?Q?GcRZ+VLCed42xPDRXyEuUTjl8ITpPTEN/I6nf0VNDlljVv/ImJfB5ieX3jLq?=
 =?us-ascii?Q?LQ/egvsRzGolMusOKj/Rio9bVP3cOBUnij+85i+al85qOAvgOe4SpnyigfoU?=
 =?us-ascii?Q?/4eACNng+9wxzz1IWwSJ5pUzhZEVMIANagnffdSEgMsWNNvCpPeYEhikGO5N?=
 =?us-ascii?Q?tRujClG9Z/vKZ9Bew63x8EDGptmUgHlsFrfyfjD+NpDoGL0mfGnu35uERqrn?=
 =?us-ascii?Q?kvv4B2/wc2AgU1hniQuMY3Qqx7M/PyiRTrtHTQxR+aqGxIP3lAd13IkVGdBA?=
 =?us-ascii?Q?/hgcXDTs84qalR9LnyuPSoG2ETspZIMVGMRgNx79S02DYdiQvy6kCIv5A0r3?=
 =?us-ascii?Q?EIdncKdnRmG/+zW9lLyfdIAZ7CXzQaJwHIyFdAzF1aN6Bi0h/RgjhpV7v1WM?=
 =?us-ascii?Q?3vJWSYtU3nuhu1wdRK7I9Db6mgWgzcrhBxRUY3B4OR5s0hDL4v6JzYovVITk?=
 =?us-ascii?Q?5+XCY833UPU/6Ce7TJWpiX+tfCHJCZpfmkO0rqpe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea2f1f13-aadc-4c4c-0bdb-08dcefa2afc9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 18:28:39.3910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7P/ZKIxai+1kgcYwDVeDCYksI2TeL+Eu+avF1Ux8XLNhZNg7N3NT5rbZk/vHG4Zl1R3aFmhQxTzENUWXiV/Ncw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10416

Remove compatible string in overlay file to fix below warning:
'gw,imx8mm-gw73xx-0x' is not one of ['fsl,ls1043a-rdb', 'fsl,ls1043a-qds']

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtso | 4 ----
 .../boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtso     | 4 ----
 .../boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtso     | 4 ----
 3 files changed, 12 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtso b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtso
index 9bee7159a67b5..b1a9f35e1dfa7 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtso
@@ -15,10 +15,6 @@
 /dts-v1/;
 /plugin/;
 
-&{/} {
-	compatible = "gw,imx8mm-gw73xx-0x";
-};
-
 &gpio4 {
 	rs485-en-hog {
 		gpio-hog;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtso b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtso
index e98f50bcec57f..44ebc0a58c51a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtso
@@ -18,10 +18,6 @@
 /dts-v1/;
 /plugin/;
 
-&{/} {
-	compatible = "gw,imx8mm-gw73xx-0x";
-};
-
 &gpio4 {
 	rs485-en-hog {
 		gpio-hog;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtso b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtso
index e875ff4637bd5..2f8a7ac408739 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtso
@@ -18,10 +18,6 @@
 /dts-v1/;
 /plugin/;
 
-&{/} {
-	compatible = "gw,imx8mm-gw73xx-0x";
-};
-
 &gpio4 {
 	rs485-en-hog {
 		gpio-hog;
-- 
2.34.1


