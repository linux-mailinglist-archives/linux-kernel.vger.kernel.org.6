Return-Path: <linux-kernel+bounces-233254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7339791B4DC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 04:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 287291F21172
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 02:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F5917583;
	Fri, 28 Jun 2024 02:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BfxYwPyX"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2081.outbound.protection.outlook.com [40.107.103.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE2A1C694;
	Fri, 28 Jun 2024 02:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719540065; cv=fail; b=OCBMULQvh3abCUFVOaAuSWGlyPebcBK/gGIFIjDPPYstWYCj2adJlWFfvGHzsU4j83l0an3ke6UO9yckcAe9wZKd/JEKcxwBBcHdyWGtfnqJvuZF8gpFJhDuqcxDxO9It6saUrLpL/VLj99MA1e8Kzajb1v/+7y3UcowA9HzsUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719540065; c=relaxed/simple;
	bh=TnfcRs5FWp8A1DYZJguXqehvdGJbG/aHU1PPPc8ZFj4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BC1CoXbwKQihv+4h4wF6pz/me7WiI3l9ssRgKFHg7gryeVtQr97R486Fl9XXNinO9Ynx6JrWOXp96pqCmO36NcX8WrrW/Jo2OWuDqWtNNrSN8g6wPpOC/cHr9P4FT8vRE0MwnvVrpzgqxdeEWcL/84daCBugWK8Wttq7h1DFyVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=BfxYwPyX; arc=fail smtp.client-ip=40.107.103.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AExgOBcBwpgltPn2uZTG5FrSMG4JHGKWBgwVc4xyk6n0izI2MvpZcy0kIaJ75GjUmjfshRr/cEyHQX2NLfzroBfL9ByVVeKDQ1GvqPtX2pXCYiScmBd9J1yrh47bUjx8bVtf1eldvZSHVQhZcuaHe2fGTjL49wBoMejIxIyK0GBnhgDVzq5HjhN2JF+/hospYKM3CEyncGJr5il11gvfac/WWnff7qkeVv0F0Nsvx7CD9jCNKSD0rHOL83fuDxaeFBO4KfSxHSYSTFJ4L60dmQq8tiL7LAD6JSGeLcNsyuOSvxx582Q0TF+G9OWkKzbRaik0SxXw8g97YMuItuAFQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2mJ/OJzD9TIAdcFuQkRTVWl4cSIZ7QjwhKrGt9zIPw=;
 b=JMY9awNy1/yj8Tano4Vntr/ANeOBbfRX/QwLSiyr/UDBdAwFBn1wMx0hCMOw64HsB4+Al1K4EtHA4kNM40l+U/r1zr+5TwFiWskJ8+Vsiu0yxQ9UVepPzmetbYu+dR5jc9cwVbSrrzE2vy4qqu9O3jm/vSHojJjrhX7wVk2Rgqh38NNSJxgUKSR/iJHqPm1ASO10ShB+fSdV3CgcstHjtUmRSw5nUWGHUvls15t7djMtEIScDTfVyqv9YuBnutJRHjk5UE3pLyEYM6jk1777J73qNe8mS3qEwsuCvtlA8lc8mbszfxuaftSSJVVs5/FYEw3aU2ItybqBnhpochn9pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2mJ/OJzD9TIAdcFuQkRTVWl4cSIZ7QjwhKrGt9zIPw=;
 b=BfxYwPyXYx+qdtDxoEVhd0c2OIc03OmBtHbisX8XWdtu2I+Kidv734G/wQ62d89nufzJG7fFdhUNMqhqWeokw2ZrhDN5vxt1pEfJY0XFKX4LmQ0HTsS/LoPIhMgOC5JS74LPZu0l04L7QYWpc2USexdqRTl4pPf5L9BtqFMUTD4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by VI2PR04MB10618.eurprd04.prod.outlook.com (2603:10a6:800:27d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Fri, 28 Jun
 2024 02:00:59 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 02:00:59 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] arm64: dts: imx93: drop duplicated properties
Date: Fri, 28 Jun 2024 10:09:53 +0800
Message-Id: <20240628020953.1108967-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0119.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::23) To AM6PR04MB5941.eurprd04.prod.outlook.com
 (2603:10a6:20b:9e::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5941:EE_|VI2PR04MB10618:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aff0144-6491-4f49-c541-08dc97162776
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HgSE37ZsKMbm9W3NiDkMj9vbTpdRRM1sVhJOVkKT7+KzaKjXBAiu3weWaogz?=
 =?us-ascii?Q?I//3vfWg48d/E6Eq4yt493L/a6cE+r1AcImI5YJdnkGal++yvsr7/cexUOj7?=
 =?us-ascii?Q?HqJV7UGZQck4h2YqDJ9ZoiBlm9tEgAIFFPTqblq+7zmWcsnNqIFFUryTZAbp?=
 =?us-ascii?Q?TxQbd1Rd+ic/E29mDUt1Q463m4316kOcwnLRGOeo7/JwirEzDc4sE+dtzYBT?=
 =?us-ascii?Q?BKfIFtAH89Q81CZCvKHjjttQGwX9D1Ecv5MUYrUGx+iNTk6T9XY3zQEOh1/J?=
 =?us-ascii?Q?kW5l7VTLYMuOSysN1GRde4PC/70T2nXjkmapD0svmFEzBKLY5UMHdwQfl8vb?=
 =?us-ascii?Q?id/s4q2rWAIc6FjlWuNjN+9ZG9al5f+floFwpmEDu6Uq1aEZNWRL0ZGO6DAB?=
 =?us-ascii?Q?0UUXxCABi4FDNvIA3rRXcp/C78hD/V+QKNVtABCWGV0Kv3qj9EAj8rTwc4xZ?=
 =?us-ascii?Q?zvj4tUx6ADGSiqtBr+9O3qrCMkMjbc55KGvPqEnxjie0ORis3L+GJfRS4L7P?=
 =?us-ascii?Q?t8skPiKwCiJNrlFDo08aiK8xqxmpOFNaGUmFtAbVg8DoI3wjM01UtMlZer8k?=
 =?us-ascii?Q?SWye7BSuvUjWpjRBmqqg28Hn82JkDiXN8dsv+NgNyRye0stLeou1p24tUyBa?=
 =?us-ascii?Q?54EweQQeNxM3NbQgtAewO9MFxu3gFWM1JS5HPAwkZMsz/QpVnU/+Dy8eRt53?=
 =?us-ascii?Q?2cfG+nzO7TkDDyBEB0NBnBp/79vJCFGZpNHL/IGLV4dfJtN4jCVIeRXPYgbN?=
 =?us-ascii?Q?TDv544Fuk5v09wHHiL1uW5+nbYSFdTQUe0WohrS7PJal0yOCAu/Q2pj/dvBu?=
 =?us-ascii?Q?qk3ZIocMEWlSbCNL/x6fXdF5Ly/AyITw1FDg9oAta/n6HuMQltCifqafpoY0?=
 =?us-ascii?Q?NaSvqJFseBnS5iLP2iL+9F0+IoSvhQRUbviOjMetCg4hmfp8VNmr+LZK+A0l?=
 =?us-ascii?Q?1lyRQZe084tqQ4kS0EHO7V1QqJRX8ucg70L5/w+DMbt2alqNOkM87PZGeUB2?=
 =?us-ascii?Q?2qqSsEFU0xUHf+bxqSMrYn3e8JMD5LK9RqNgnDhLhAheNd6ez6YnUVEm+8Ir?=
 =?us-ascii?Q?GOUVDqlhklTQt8CykWCe+fnbFGOyHy781cZJ7zSLt7HBrRuNa859AZKAHIo7?=
 =?us-ascii?Q?kBZZ+o3sciOYEbHfa1BxX28nSYpsxmEHZHkk8/yvwlCOf06bpOtYiOUk3y4s?=
 =?us-ascii?Q?zyf2dQCy39FrbE7lCKv+TQh6Y3iWCEmF7cwu+vM8aUaAAva0pr5NnD7/riYy?=
 =?us-ascii?Q?aIAqliEOjon7zQHxL7svImeac3AY4U3NqBpE8otAliEOn15VCpura0HZ3TWl?=
 =?us-ascii?Q?gBQECBWVSTx26xMwXrx2O309FSY3SQ8MaIhTxEb/pvqjGBW3Mf1emZvhmShl?=
 =?us-ascii?Q?6/g+gMHcO9HzpkJzDcc+amBFuT8APahiYWrfpKe06DEWAIegHQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k7q0aORhskIZuiIq/ClSUDXWSX0DaTG3RypMvZhz7NjuyZISbYNqKe8Shibr?=
 =?us-ascii?Q?3knHhBLqgsEu2T68LK6mJ54Z1S9fZcG04TZjeVRCZATb31XWH632nSkubXjq?=
 =?us-ascii?Q?nOFN4gs3FvrrMHxXJgHA3xInPsy4SXHLxBlWWdiKWQoLrOua1/ZLpJsiU4rC?=
 =?us-ascii?Q?00l0bcgDR1vW67x1Gkxd25Bwg3GCAUtQ01jOAYTHiMDhO97gZKXY9xRwb6XB?=
 =?us-ascii?Q?YWpXONRooXOjOysHk/GgG43UVi7OL9qYKS+UHeMrEDt2x2eLmcAQYUyJzxGm?=
 =?us-ascii?Q?vTa0p2NvupcqYUQjp9RQHrmUgrMFeD5IHhGUc6p/ktndJRluR6R/vpZoCCyi?=
 =?us-ascii?Q?oDQv6TYSMmFGsIJ9/YrRSGllqv6Qs0o8Gh9bBckVFuiwsPAUKjWFt55V/ojE?=
 =?us-ascii?Q?G2AxYVRSh4dzMyFweaq2k44jfRdHyEM2TBePeDQeYnF6pY8KrZJIZiZM9l0p?=
 =?us-ascii?Q?DZWIVhXNRYXaqkiMVzitrTtHVO+v4H/fl0sfis2kcXTgBdmpe9XVTIzlRkKs?=
 =?us-ascii?Q?t8K8r4fz9s4UYDL+6B3ANUx0fKLyzAZ0baV9EMzDvR408SQrJyk2Yh/YYhje?=
 =?us-ascii?Q?9g0pH5zl6xq3RrHIrAo3L175RAu7wWtUVySUpaxaXX2dFWW/LsssJULVjPWY?=
 =?us-ascii?Q?tvrOmvhK7DtX4jSB2SQN2k7Jnd48yzbJzgBlS8qiubJhaUvB+i8zhHhQegbQ?=
 =?us-ascii?Q?P6RXX3um3Q9UOlNi2QsR3t75E35Go4E3dpeiR59+OLYRGoy7KG+p8ZB391EQ?=
 =?us-ascii?Q?OsXWhCwMElHOtdG1k7gk+8EM8eHbvEiAUV3vNoCcyVOwt3PvS+PwFu73IpMv?=
 =?us-ascii?Q?LYf2KmR5r+0BMcfesd5FmFYxEcU0D9Ct1aEV7y2cZFLgh7CE1YKo5s5GnKcw?=
 =?us-ascii?Q?lpV3AEd0r9P0zzYBF1djR2Yw0rbMRVh1I0bCCGAWVP6xumwzjwaC/MMM8MMg?=
 =?us-ascii?Q?9Br9LQguALzHYiDJgzQgsJUlxR2l7ZIkkE/0CAWf30hS0lBHnj/7afpRwoGF?=
 =?us-ascii?Q?+HE7udwi7vmSVi9Y8wSOoj/l33qO7CpOk4Tm+3Jy5SB5fBx0VUXIx0LxUJQW?=
 =?us-ascii?Q?1VU8jacI25ftb6sw/7kbKQ72YrhKtV6OWZaV+7bglDI84w1tSUl1Hn0A9MXS?=
 =?us-ascii?Q?1ny6O9xOSC6Cr0MwhtbuQuagyQZ2KTd7uut9gMevc9N/JvLdK/HemO8Bt6Rz?=
 =?us-ascii?Q?3z68IXKyIUaU+lZjQrWKlRf8xaLokH37Wk7I42g7GbBLBGYgDnDxtt2oPrGY?=
 =?us-ascii?Q?Cx5Mk5Kgo++zpore5OMkie0V/NFD5sm4bubIJI9mf4cPorVf9/DTFbZEfHqN?=
 =?us-ascii?Q?bV3MVF5YcBhlfYdva2hgBy5leqhmi2h+tbmHb/68C+ShgUpf7b6QLF4KVJ45?=
 =?us-ascii?Q?G2bZOEp7Bx55+MBWvDIqwlgi4NUHw3ldY6filMFM5NEjsqaY4SUTvm3V8sE1?=
 =?us-ascii?Q?KMUCbl+wZLA7qPL+IpFrcV3S57JFb1fkIpvPbS7aLYVWJaNFPbdXT2saTzQa?=
 =?us-ascii?Q?ztMBsMSdT+CXMsZz1nP8nyNq0p1Sw0yrGUei6zGps7vKxwi4fxjp/DpGhoKI?=
 =?us-ascii?Q?8gSa+9QICUJTU1l4SA2SesT4zBbMrFAE4KBPxV19?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aff0144-6491-4f49-c541-08dc97162776
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 02:00:59.1176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rT5LQoD7pItdqq6ZlrrTTqlqysTYxcG7qV+47btnHG96NQrWj7sLQ1chVZ8RL/QoIDlZYtLaB5In+WtMSFtjFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10618

From: Peng Fan <peng.fan@nxp.com>

'#address-cells' and '#size-cells' are already included in soc device tree,
no need add them in board device tree.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Just resend with maillist included

 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 4 ----
 arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts   | 2 --
 2 files changed, 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index a15987f49e8d..2597c5b2eacb 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -146,8 +146,6 @@ ethphy2: ethernet-phy@2 {
 };
 
 &lpi2c2 {
-	#address-cells = <1>;
-	#size-cells = <0>;
 	clock-frequency = <400000>;
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&pinctrl_lpi2c2>;
@@ -244,8 +242,6 @@ ldo5: LDO5 {
 };
 
 &lpi2c3 {
-	#address-cells = <1>;
-	#size-cells = <0>;
 	clock-frequency = <400000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lpi2c3>;
diff --git a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
index 950dece83c24..f8a73612fa05 100644
--- a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
@@ -178,8 +178,6 @@ rtc@53 {
 };
 
 &lpi2c2 {
-	#address-cells = <1>;
-	#size-cells = <0>;
 	clock-frequency = <400000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lpi2c2>;
-- 
2.37.1


