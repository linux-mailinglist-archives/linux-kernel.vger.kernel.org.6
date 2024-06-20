Return-Path: <linux-kernel+bounces-223010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 367FF910BC0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFEBE1F2115A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD3D1B14F2;
	Thu, 20 Jun 2024 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mjRKfJo8"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2451CD3D;
	Thu, 20 Jun 2024 16:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900203; cv=fail; b=GINchZy42IMdGVE4YexByBB31HeZRXaJgluSO14xDLWtt8CEQzZtPGo/flYvjMV7e4gHpnvdUPLqD6LFh2H8kvEGRetQMcqk0IvR4JyOhC0W3e+EYulEPG0X7UmQzDI37TnbiY3tS7DACoMbtKVk8aVGI2I0xFRolDptuZd8iCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900203; c=relaxed/simple;
	bh=+Zh3XCVpXyhdJju3l6eo6jL6LRWL/TTc40Dy9Wo5S0Y=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lW4akDPeU9irryEOlivAOLJv273SlqRqjS7fT1zx7LotGGGcmm2cJXaTnKVED3gJT9wP5bOKtLeBBYJjr8Tdeer0E4peW4pFMTBuaBsxnk3i5lUp+HY470A4Wz4K/HyAOq7MZaxlUoiT9iIAVFt7HenJHRdVukGPJaz0A18bjXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=mjRKfJo8; arc=fail smtp.client-ip=40.107.21.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TO7qCbkl5BGZbUn2BUh4xgMzSGQHkdO1fp9nKUBxqplktMGvhOXUt841zwmSgl+KMKyGKOFHaQ0lJXOuQN1Nm7esBHlNCp6bGjA8HuNTAIwZUFqqWUfwZjUTcifc8ddp3ZWaDqzyTj8QMjklSz7Nm9AJ8urwCHRjpfZL/aUVLiesTUqpSGhRvQEe8fqjGZBZ3bwon1bAAKMHTQVJFg1sGBpnVya3n2WDU/1T8pJEHhzdeQkHaei//7GO0TnoZABCwHIypqewt27/a9DmETX+3CjLORDICMp6XKoUbTlWSj8d8elq1rMoGIpTq+E6ujHevycCR6FdPaaOTjNcumRrpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0anTbJF5zATUNBmiHQqKVN1Zfm8xzJn9ma7xELzOZE=;
 b=Ly8vSPk44TPno6M8K2NEow/mZYQUPQsE/PBDrkFu1Tr83LFzfvwQoe9MdXYDhfO65EEqgKB0v5RD2PWXuImatMZRvDjmyJg5i9pzAVxHtuU5n5rg0/SX1WsSiSlFP6mTZdSrDpNF1RLCwxraUfE/miiA6ysv9zqv/nN4/OA1zml4FOainArQg0tBnCljO2UgFiMRCpXz1PNoNvti6gQMgNWadHmXwOvUl9nZdNpLezMKVWIrPxOp/1HfFHUHbzgYwjTV2DQNoBsTFuEM1GTk6llreOBNsLE4GjnYCFx405RyM4arK8435Cm3SMossRUUKPyiZg2k6M2oQDnlO8rX+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0anTbJF5zATUNBmiHQqKVN1Zfm8xzJn9ma7xELzOZE=;
 b=mjRKfJo8YodKgl+69NmIOJxA0K3Y8QzyoCXsVdD52Kiq12nZPTuCtJUoagtT5qFTYUwSzvRI5LwPU2zQffxN3+Qj0f+v54ofhOE62c47kr7h/6pvdpHBRMQ4RVh3Roq7glKGwCMgnnsAl35crCjTRR8krfpiBfK+eDKuP+huxvA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10582.eurprd04.prod.outlook.com (2603:10a6:150:211::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 16:16:38 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 16:16:37 +0000
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
Subject: [PATCH v2 1/4] arm64: dts: imx95: add '#address-cells' and '#size-cells' for all i2c
Date: Thu, 20 Jun 2024 12:16:19 -0400
Message-Id: <20240620161622.3986692-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0197.namprd05.prod.outlook.com
 (2603:10b6:a03:330::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10582:EE_
X-MS-Office365-Filtering-Correlation-Id: 2469edd0-acf4-4bf3-68fe-08dc91445c87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|376011|7416011|52116011|1800799021|921017|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7oTtYmVB3QbGJF2BRDtTeLklolxp1iJVzRQBdJqNPBFtTRto77Bo7DPofDZk?=
 =?us-ascii?Q?ilTJwHpq5+zlHgZKk9NegxO3HgMAaVH+lc3HnMx5TzWle6DH0GAqx3jMrWdR?=
 =?us-ascii?Q?XPzj3ScA+r1cP1ISdhyIwwh1i20xVZjpYOnIGtulRfbIp9x5r5F23tYxlWyU?=
 =?us-ascii?Q?4b5YHDmZwIKH2eHwUs9wj+roVzX4F8/RJJGVk+0SVUJx5vQQdpxkiE3K2yGE?=
 =?us-ascii?Q?0u20aHOkW0GSHSYri+vPEDvP42QeZPlc0eJiky4aWC00z6z6rFK3G146tBhm?=
 =?us-ascii?Q?QHy6qih8Sq3RGvmNXI2TvZLF6qb+1mP4piJlaC21AKqyzq+b/EkzaQvesfbQ?=
 =?us-ascii?Q?j+mE1o+0IayA/nQGxR0UwzKKYjCFhP88rMgD1EhV43SjJ1wop0F/5tOtNuRq?=
 =?us-ascii?Q?4ziS3bYyyiiAb/adlJ4pSiIZirVvXkXzZ/FYWoE9d17kR0Bra/QJR7FXyL47?=
 =?us-ascii?Q?dNCoeUP/wSWJDCTIIR0yj6/6QDdn3dbkjndgmhKYLjLhE0ETkGhNwkJgunEg?=
 =?us-ascii?Q?h+76x0CjzK3p9ijkfKQqdukKbcj8DU448GHEuBLfNTOHL+a8MNv4dRoULyMz?=
 =?us-ascii?Q?LdbwTcU42efFiCwcpHW1GbqRqhvoYvqbiTusaTmMhxUdmPmET3vdaMSsKOd4?=
 =?us-ascii?Q?d46wZgaZg3uGOH/xFqayxj7N0KTjoBnZBlJQPvp8DZLYBo2uwjlZuI2xPJST?=
 =?us-ascii?Q?UePoHp7HE/hEeaTdblw03XnZAeX/hL/1da5xkQZ5JaER4lkp3Uv6D/Lbte5Z?=
 =?us-ascii?Q?nHLnFHL2GPv307noPxqGYbSmE4IJGpiJrcWKMdAKyz1pe7yg7vNlqNO1puPi?=
 =?us-ascii?Q?ujjaSQglTUvJlTPKDXjmesDlPr4bNYMYshFVUzu4Z8U6ZuvCitdOxr5H3vhp?=
 =?us-ascii?Q?EPVu84laxRT1BnnACCk25Ip6EdzYosCJB+VQ5uhnCwsVOgClAyKJYl/HMyge?=
 =?us-ascii?Q?bUNWXabvJAyVu0mJyGhQLkoSdOgYYLL77Vlz0Oygzwh2VY7ISxBYD99biAiP?=
 =?us-ascii?Q?mDxf4QXMFZrjQbyShO5KQC6Aw+zkdyGfx4HyYoWH86j9CI4DD2jufqXNN0cV?=
 =?us-ascii?Q?SFr5bdJ3MCCF4A5FygMEZhz2o2fEmZrkBYCEUJfBjCAOtisu6nQPxmnLXpzw?=
 =?us-ascii?Q?/uctc8ElBhuH/v3U6ezc3I0T0ywM+ZX/fJQn02DoY34I2fvCeKhF1KR8IN4l?=
 =?us-ascii?Q?h9X/iwffGQZTkbYhfX21vJanjJqswGLmEq6oGAWzrNId2f5sYSFJWsBEm9e2?=
 =?us-ascii?Q?keALuTReetnh6Q37nU/ueE9xBI8VZkj7Z8XP4T1nEai0UU11rVQOmxIzwEr6?=
 =?us-ascii?Q?z110owwY5iE11LmIsQ0766Y3evpYoFNhJ0Gqvku4U4JYj8mOyl3txZgdv0UL?=
 =?us-ascii?Q?i3IdFknCpReQH3f7ULg7/1g7UfEe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(52116011)(1800799021)(921017)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FbHwUyVdojeyDzwsOFPNY54pszhghCmK1OPfYoZInU3NzuKlsfc1Rh4SxXgo?=
 =?us-ascii?Q?8oStTk9N3NAOFDevLfAmtsS6hjffRiGKBwVKRf9vQgttVHmXWAbTZU2YKQpg?=
 =?us-ascii?Q?gKKpKlNr7rmBRbpzZvOt2M4YH2RP/8apnglowr5a4PI+zwtvGJj3X7a3HX3i?=
 =?us-ascii?Q?EnheGhxudh9ULthAGl9pZbUsjejbUdMBQQKLjjXGoviPhDC1IFaLE3fI7p7Q?=
 =?us-ascii?Q?aYNby+sIO3iyWKkEggpk3bJU9WJJYD16wfh+Hwp5bFLLiL5qlhF9jKvbwMTw?=
 =?us-ascii?Q?r08DK7tOA5nezSnKaztPZNxBj6Nzvzn1/t/NaysIwyYdQzbokhMSXP7Ceqs2?=
 =?us-ascii?Q?mCXzDqs2Sd2j1D7HYMAwZ2yi4VRO0R4+mwT4xY0mK4fJEw47c1aLk645p+EO?=
 =?us-ascii?Q?9NDGrfrh8j+sHuQ7q1d9dIHpBhfNdacozUgxnGlILUKi2DJ0otb0vLQ6yXRM?=
 =?us-ascii?Q?zSyVrVDp7j9jgEfmulgJByuF6E5Gy8W4Nb+IicMhekrM2t/632oTfBuU7flN?=
 =?us-ascii?Q?KQuqzzQ6gAmo7bJ22wms11x6oHrCKZ4oPD3FuOCIdmljbXKTKl7qy+OXbXq1?=
 =?us-ascii?Q?2JgogN9v1p1QVrww+3u+vgpfpKGnfbQCFZ8bHLZmwExoUGmcbCE+pjMjiRr0?=
 =?us-ascii?Q?yb//ZE3gomv5rZJfZAYBCwY3NihKJvHrPe8udtxtj5oSGrpNscsh7bk2LnSw?=
 =?us-ascii?Q?sQNQ3gzt7g869M9XuX3mh8M4pvDYnrnPow4NMLF1IX/LF9ljoTcK6yOUtQiM?=
 =?us-ascii?Q?iVriQmmm0Dns6q/ZnlsiPQ8MWLCj7sUFurEUh0tcvFtBNfrgJKSnOdJTpDZj?=
 =?us-ascii?Q?c+RrvN9s7i5+tG2Y2MT2Qp52wNgRl5sy12wSs2m14+QGOjgZ500ZF+kDeMww?=
 =?us-ascii?Q?N3pv8cjeARnyojBgZyfeWv2csaV8Pl3iOQ2KvTVbFIH7QyZ4c/5JOdjFgu7T?=
 =?us-ascii?Q?hgjzgrp0/3Rw9GCnlQTIOiMZv8EVJlXE/OXvFCln5Sl3mPVs+LaxTwgTPQ7Z?=
 =?us-ascii?Q?NwpaUsjwAimEVn9HaxfXkZV6ycI6sbbhezUZFIgef6lCLALUg7ft22e8cw8v?=
 =?us-ascii?Q?QOuq0AHDuCXaLuBhB7YUg6w8jxPTUdkwHHGWJZHjQA/3z6cFLGjmej76tdkx?=
 =?us-ascii?Q?WQCZDIOtIh5kdi9lRBlPsV/9GAvhLWtXmPxtGSmWtyfgwlDvdlqbRIemLTU7?=
 =?us-ascii?Q?Ut5ls3XL7QvtWJ9CF1vjKF7ymDyrJkBk989OVI2LNFVHv20D3WQMFIgpcv2Z?=
 =?us-ascii?Q?lX2Oh+NaKgEqbiIa6bb6U4XJ4GUjcyM74sqg1U9f865ZMHgvuOr06/NxPf3H?=
 =?us-ascii?Q?PNuTqmW2I68FMA9EFXMm0PS/9FNFNwKRQDpTyp8DmH1qQKFRc8jv5HAOgLqQ?=
 =?us-ascii?Q?NuPOMx0sCkfyjoJV68KXg02UmK5zMOYzbBFaLujVgDmLFO9l67ZROoSyLEBg?=
 =?us-ascii?Q?wImjIOLWNXW2tQRqIDgqShJXV/8wH/culzEX6Ag6isRVc0wY03JklYgW5jLr?=
 =?us-ascii?Q?Xv7v2Jf+Dm9sNReJSo0iGzh8h7HXJ7l479hNrlVOdkpxfEue+1HdJanD2XK7?=
 =?us-ascii?Q?LOARmzFF4G16i1hUFB8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2469edd0-acf4-4bf3-68fe-08dc91445c87
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:16:37.7367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3t1QCNLqX1+wLci/zfPDsskCM8Zj5Vr4assNE92FbwHCBVi7c/9Mief8N0i9nHoEoSTFpW7NG4YLoxbTh+HloA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10582

Add '#address-cells' and '#size-cells' for all I2C to avoid duplicate these
at every board files.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>

---
Change from v1 to v2
- Add Peng Fan's review tag
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index f98cec944eeed..cc5e829e76cc5 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -462,6 +462,8 @@ lpi2c3: i2c@42530000 {
 				clocks = <&scmi_clk IMX95_CLK_LPI2C3>,
 					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
 				clock-names = "per", "ipg";
+				#address-cells = <1>;
+				#size-cells = <0>;
 				status = "disabled";
 			};
 
@@ -472,6 +474,8 @@ lpi2c4: i2c@42540000 {
 				clocks = <&scmi_clk IMX95_CLK_LPI2C4>,
 					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
 				clock-names = "per", "ipg";
+				#address-cells = <1>;
+				#size-cells = <0>;
 				status = "disabled";
 			};
 
@@ -566,6 +570,8 @@ lpi2c5: i2c@426b0000 {
 				clocks = <&scmi_clk IMX95_CLK_LPI2C5>,
 					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
 				clock-names = "per", "ipg";
+				#address-cells = <1>;
+				#size-cells = <0>;
 				status = "disabled";
 			};
 
@@ -576,6 +582,8 @@ lpi2c6: i2c@426c0000 {
 				clocks = <&scmi_clk IMX95_CLK_LPI2C6>,
 					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
 				clock-names = "per", "ipg";
+				#address-cells = <1>;
+				#size-cells = <0>;
 				status = "disabled";
 			};
 
@@ -586,6 +594,8 @@ lpi2c7: i2c@426d0000 {
 				clocks = <&scmi_clk IMX95_CLK_LPI2C7>,
 					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
 				clock-names = "per", "ipg";
+				#address-cells = <1>;
+				#size-cells = <0>;
 				status = "disabled";
 			};
 
@@ -596,6 +606,8 @@ lpi2c8: i2c@426e0000 {
 				clocks = <&scmi_clk IMX95_CLK_LPI2C8>,
 					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
 				clock-names = "per", "ipg";
+				#address-cells = <1>;
+				#size-cells = <0>;
 				status = "disabled";
 			};
 
@@ -816,6 +828,8 @@ lpi2c1: i2c@44340000 {
 				clocks = <&scmi_clk IMX95_CLK_LPI2C1>,
 					 <&scmi_clk IMX95_CLK_BUSAON>;
 				clock-names = "per", "ipg";
+				#address-cells = <1>;
+				#size-cells = <0>;
 				status = "disabled";
 			};
 
@@ -826,6 +840,8 @@ lpi2c2: i2c@44350000 {
 				clocks = <&scmi_clk IMX95_CLK_LPI2C2>,
 					 <&scmi_clk IMX95_CLK_BUSAON>;
 				clock-names = "per", "ipg";
+				#address-cells = <1>;
+				#size-cells = <0>;
 				status = "disabled";
 			};
 
-- 
2.34.1


