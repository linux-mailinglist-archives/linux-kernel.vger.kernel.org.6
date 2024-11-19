Return-Path: <linux-kernel+bounces-413724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 544EF9D1DB6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 02:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E752828D4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 01:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF2E136331;
	Tue, 19 Nov 2024 01:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WVk/ebUt"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA95813EFF3;
	Tue, 19 Nov 2024 01:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731981525; cv=fail; b=Cn3YH3GneUUmqAYzHAeOzbkyM5uqElTqaB5p+Bdh3iLFQg2tgihMDt1RHKqcULcY9ALSBM/SXdZY4Oyo81mO6p/0c18bNaBu6kWrzlup939XRT9d32p54nYrPOHOygfzLwH9ZVmFNtwaEF9Iq8y/wrx8MTEo9njOxn0Cc4P9Kfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731981525; c=relaxed/simple;
	bh=NpRPPW8OzkETPFL66TrqaQcqPU4M+Sw44nFQ0YrbMyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LPKbhtdFfNe1ouCRRpPW2RAKV+Thmf6k/XIKPpt0YvKrjHByALTvIO87W/4PJRzIF67u11AlzDSYyypEAOxqiBrVEVduTm6GBaRvDqlaqP0CFfAIiAKV0gxeR4IGCU9VaQhjhblbX3h3zrgH5m0S5w9ZXkR5aAaeQup7OwEiT3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WVk/ebUt; arc=fail smtp.client-ip=40.107.20.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C5uPIFbBFsiEa6xrpXbP1iXXtk7vySe8P62kOV1adkaw1NVgGfeLoTwCpl/vDLsSCAKMjkq21iUE25/oqM5Ylx/VEj5/RrxCWcMPUhdWgaE3suen4rxJNh4wVhHax/yEAKT5b/Wgwzs15f58qHD6XG8duTPY7cHsZfL1bo2POiyU2UsIYnWfiLNHdCA8ddkGJawvVoV2xm+JVokuUpbUNrjEuGlBjYQDT+mP30uYUhACp9QDZCBRFbYFZbThJnE7x/Nur/tsG4Xi8zq3wxiz/BGfufGdpRISfoGxrXbKf+kPd6aJjIpAMXMoondWvynKImL8SPXG5DvWwNHMZEgjjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0QHeFb71Cg1Cu/b4Ab2c/shHYZYxbqW6Nz4N3zlbyA=;
 b=d2Metkmwp3iBAETvHKM3BDfXK1XLxZEatFFBgyUMgd9cDFGBcruu5impka1RyvPywa4ldHfZIVQP5uogDRHJIEofZHSEmenCxSy8BVxU1kH2c+5Rzw7iqBPjEtk52UTUx1ElZP2L6brjoznPMDBVEFZxbe8ro3LrzD+ct9NlSIw4pNSJi9OpGD7ms0eHRYJcGWTBN3UqCGqCcs8gAqRS+XFnykiMomSpr05TTYkzdWTbUCX4yDshhxJmBn8UBDP69F7OGv24vIuWNSy6w+LbBNXkMW4JyJVArgmY3J85+J3HprpRUSxsJF6mknzlvbJcuo/CBAyAQ6L/R+zKZuXIKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0QHeFb71Cg1Cu/b4Ab2c/shHYZYxbqW6Nz4N3zlbyA=;
 b=WVk/ebUtb8e4TbbVUcFXp+YxDymaNmlSwocynQnJ9ZG9//egpqVqJojTa1nu+a8ft3SLS13sVWbspH66u9wZ83764IvCq/VhkapLfW+1qLS/ye5KRv2zVwvg0X1EbM3qrGcJLFftRARxsG3D7oAldIiGQjtYzsz0EKhct6A68/PocH9MjzjwyW19W62rB5jDLCdJpMjwTIDiSw578RGwkLuj+4J/ZuOLU8lEIDZNyYxzwbY+auv7LJKZxDpCWmyVg46ey/OFgyiGOfgGd4iWI/+gxObg/RLxmuutZGGndVZDGLoAZLngahsDKqcrq1llb8ZyyE6ol9dE4dc342r8Pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by AM8PR04MB7297.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Tue, 19 Nov
 2024 01:58:41 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%6]) with mapi id 15.20.8158.013; Tue, 19 Nov 2024
 01:58:41 +0000
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
Subject: [PATCH v3 2/3] clk: imx93: Add IMX93_CLK_SPDIF_IPG clock
Date: Tue, 19 Nov 2024 09:58:04 +0800
Message-Id: <20241119015805.3840606-3-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241119015805.3840606-1-shengjiu.wang@nxp.com>
References: <20241119015805.3840606-1-shengjiu.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::26)
 To AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|AM8PR04MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: b5d14c18-bcba-4c53-f633-08dd083db0c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KXFd/08ZbUr4SfvAXYa0fcXiEVfNwatiCySVX2XojiwlR65bGacgBDSGPhr7?=
 =?us-ascii?Q?CyBRYWcWwbYobkjnET04b4myVjVx+1PrVldKzpLr57K/otHk3SHSPFmCV0nE?=
 =?us-ascii?Q?unuj6+wz3ZgqfyPX1yaaRpiOW4q0PcS4v3LUjjUNtEgNSVRozU/pWtI/PoC8?=
 =?us-ascii?Q?sdVpgqSMva/Qt4uMRg4BVHPNUZqKcIACBfsbcSpPaP0Yvo6J4avb2LJElkR8?=
 =?us-ascii?Q?YQzPJqStkriNXCw8LF+I8UUQdGrA+ufyh9ec/FxEI0jKEGAwTLEByVQr++qT?=
 =?us-ascii?Q?IdvKl6Mv/nBuPAYj0WszGXgHilldKCo1c+6AqTOhezGEjapmqKyYw4WZrjZ6?=
 =?us-ascii?Q?4OqDybEPUOalNX6a2CztEc0TGq8GRbLrmb5ja5CF8AVFrB0hJyyO4m/jzdy6?=
 =?us-ascii?Q?JB+Q6uovzZBW6maDamYBRxI9H8JrvREe8l7Ot5o9kmYcdYWcv3MMB6z15QGy?=
 =?us-ascii?Q?zqmItQo7bdXH2o+4quMa/0bI8do5D6lWdf9uvogRmB7nfmQ4y+GdsWc3xMW6?=
 =?us-ascii?Q?bMVxklyj++RHi1i59bBUAS50bf2QhQDrHN8Wcm/IesqzhN59KS0AoFt4pGw0?=
 =?us-ascii?Q?3HP9OYo3kfTQjSMtlsdQ3ikciAMsm53D5SOzTLyJ7gnAsgeLqdZavSLUWkgq?=
 =?us-ascii?Q?AALpmDQcWwCyMY8hduO1UeSzUKOf+VQgXeNvC4/UC4K7/A097SRpbz5Mkog6?=
 =?us-ascii?Q?q5b5XUnTjEX90+ryBMZa2sRWwgQzp+gv2Pb2vHNR2kMFRFrEidW7iaIPa3vz?=
 =?us-ascii?Q?nDkj7IOPckhox+gnbiZ3rCbgtZtwPr0eXPqU6Zpu/ANtDWNbyKdhSGQ8UfUq?=
 =?us-ascii?Q?GRVvoothPe6KEy0IEieRBttufYiL32v9u0HsjBnpRKmld9YI9kloIZDQPxzf?=
 =?us-ascii?Q?QvUufv67qpn7BsmFG6pxtfcXfUtphjAtmWVVoFoJTwXWlZhQHKSzdZObIkc9?=
 =?us-ascii?Q?zYjYNVghQlwooqeQEE4NnHT04krAPstBdcSTCfPBV7cDmC7tRqx8UpQqYQn/?=
 =?us-ascii?Q?OifbG6/diwevR0IWrcNzOwR3Dw6Sd54fv2b1hBFbvd8mDJkUktnB7Tcy9fam?=
 =?us-ascii?Q?+XODjn/tbiW8LqaPbrwkoGeMtrK9ZEsvoc5UFSz6dL6YHjepE/IguAg9ZdY9?=
 =?us-ascii?Q?+9jJ9LfJbD9JozNoWFebXs2T6U09PIV1BzMQ83lLQa5pAS/feZ7TdbzZZap4?=
 =?us-ascii?Q?a3mr0JF4jrTYT5ijWrK1O9W2AXEINalvDdzMl9kpYdfnmC8xfro12UWN0Lzg?=
 =?us-ascii?Q?E5P3tqtYoszXuSOkO60ETQGLFutwrhiOmgeMJdcDtxkN0Yaj5fUNE+XmKhQv?=
 =?us-ascii?Q?GH9SUGYe6Q8dvXmWR2q/yS3gFTfNty7IbuFczWjkG+UvEUyy/ohp6UK5lu7Q?=
 =?us-ascii?Q?AadlfS3TNETHXz+YxnZ1Av/xGNyS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mjUGAeSheFN8Z1+dCc6AshSVNpIXERf+Nk08OSiLOIRZ+kYm4ty+YmYgIdjd?=
 =?us-ascii?Q?biQ56hxUiIyM1HpXJkhqJHuRaPmMeiFDBMYm1SosHPASv9OKo1JLoLepN5Ua?=
 =?us-ascii?Q?qb1/04hOId+twtXOBk06w9MjGYNbe6wvmx2xfLolULrnhimdYyBTGcV68h5U?=
 =?us-ascii?Q?Xip5sj0TO9wek+PIcfrPs5x6uLKcABSFNIg9usiiLUsWVFsHbW7fWF5P3zZk?=
 =?us-ascii?Q?tAwXroCYIEDU1PxHcXFP3rg4dsv5Kl4JF37T+tervHNw67EbfgfAInUWpyER?=
 =?us-ascii?Q?mXwAAKnlEMNv3gJpBaLUzCjum4LB++asPX8t+YZF+Vti7bATg5v/G6cCaJrF?=
 =?us-ascii?Q?ji8bwX79exVPQfWGfUlS93b8rn1QBLoFv4db8FVn4id8jH14Pke5PCQsk30g?=
 =?us-ascii?Q?+eA6JyO6jxX1zbuDWhaDg1GmVZ/GNvQLZD07b2W7CWJo9y096fcNuHCtw8yx?=
 =?us-ascii?Q?SQBro3hNI0IPEtQZPwTBqeuZBqvVtPs+oW9FRFJ6UXgKrPcGNDK+gt12+d4c?=
 =?us-ascii?Q?CTfu7qqDnK1THBpKb1r1QLSRDWDthwxtRuMCo1KsEUD0fcIsP5Om9FV3krBa?=
 =?us-ascii?Q?NeLv1FJkim8J0trjPLKqdcFWULMPyJ9JpfW70MPmbVKAZSgoMg5QJOsQc//v?=
 =?us-ascii?Q?8BXItyo3NbmNT3KJUDZUnQarqEhi1YGef7hpqpSWkh7XWWFnFkufgfZozjnn?=
 =?us-ascii?Q?Lab6mpwLoKfsZj7a6k76B/nv346g53P36qPjlVrI3aGI0wahwpRsuyXBVyXr?=
 =?us-ascii?Q?YymoExGgmsC6PMqdPyPaP/7HFeZoxhcFponUdmV6JJqJaVAywv9+XRnYQLF8?=
 =?us-ascii?Q?nxnWMoYtQRkm0yUJ83KlXGbDQhvjndV+gu/Y33sdVrYxVhuH1pN/uc4E5sy4?=
 =?us-ascii?Q?kCEMOocW2+bXvvbH7BsD9ykiWhxSnKoYTD8jbzFR88f2xqD1AgiVCApu576/?=
 =?us-ascii?Q?2Zn2FIFLrnuvKxqUkHWaBy/hH8z6ILwxitsQz6iZwOuna3twnbOlwHGCSfOF?=
 =?us-ascii?Q?6M+dD73VPFoqB7SZMZn0PlNxj13EcmmBsED4FzLuKp/+t6MGSaUE49l/Q0O8?=
 =?us-ascii?Q?1+squ5p18bPXkbV5VzFSF2EUZ+A05ZWhDctd+wxY9fcoLX1Olv30NXQHp5eI?=
 =?us-ascii?Q?SrcH7HcIWpV2pZYXpVnA1KG+njbkNv7d7LVItQa+I/e2/dxdBB/DAyBduC9v?=
 =?us-ascii?Q?1jqsyb1hUOBXK5vBQnUR3itDGpQCrc5kXyoazowHaxUYa7NTPoJRPREiIzUt?=
 =?us-ascii?Q?6CI0BTGex/SfTb7m+KGQTopdF1iNmJmsybojLlzzoOEwWxis+cwBDzk+/OXk?=
 =?us-ascii?Q?PWhZCJ8dXPevEpCke0Z4bz89wm1YUQTIwHNayumBYj145Q8S7dYVhyvgfHKt?=
 =?us-ascii?Q?ksRnRTv5UAE0ibE1EXEPprUgxh0Eeww59xuGaVu8TPe3MIANZzFM1G12QOdZ?=
 =?us-ascii?Q?+gW8/P4agPGrc1Jzu9fckUW9RCMdku/9FkaY3rIpB6Ce8P5xcgDJNmvxINsu?=
 =?us-ascii?Q?EWu+iAKhq/S3WbdVzKblvnC0ZBYnhszK4X1FQAOvSVZNvRVEhD159Epyg6av?=
 =?us-ascii?Q?SVgol29yyCyigWjKzmL+ULCrkLVBfSrgTRCK5i8O?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d14c18-bcba-4c53-f633-08dd083db0c6
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 01:58:41.2196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZNUIcbPFWoySh2z3B5XW6SVl4wQjFa5i3f+4yaZ1GiX/WQtlO5zZIzMiI+1w0aCcrZupuNLUpfsm+b+MHw2XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7297

Split IMX93_CLK_SPDIF_IPG from IMX93_CLK_SPDIF_GATE
because the IMX93_CLK_SPDIF_GATE controls the gate
of IPG clock and root clock. Without this change,
disabling IMX93_CLK_SPDIF_GATE would also disable
the IPG clock, causing register access failures.

Fixes: 1c4a4f7362fd ("arm64: dts: imx93: Add audio device nodes")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/clk/imx/clk-imx93.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index 58a516dd385b..eb818db008fb 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -15,7 +15,7 @@
 
 #include "clk.h"
 
-#define IMX93_CLK_END 207
+#define IMX93_CLK_END 208
 
 #define PLAT_IMX93 BIT(0)
 #define PLAT_IMX91 BIT(1)
@@ -38,6 +38,7 @@ static u32 share_count_sai2;
 static u32 share_count_sai3;
 static u32 share_count_mub;
 static u32 share_count_pdm;
+static u32 share_count_spdif;
 
 static const char * const a55_core_sels[] = {"a55_alt", "arm_pll"};
 static const char *parent_names[MAX_SEL][4] = {
@@ -252,7 +253,8 @@ static const struct imx93_clk_ccgr {
 	{ IMX93_CLK_MQS1_GATE,		"mqs1",		"sai1_root",		0x9b00, },
 	{ IMX93_CLK_MQS2_GATE,		"mqs2",		"sai3_root",		0x9b40, },
 	{ IMX93_CLK_AUD_XCVR_GATE,	"aud_xcvr",	"audio_xcvr_root",	0x9b80, },
-	{ IMX93_CLK_SPDIF_GATE,		"spdif",	"spdif_root",		0x9c00, },
+	{ IMX93_CLK_SPDIF_IPG,		"spdif_ipg_clk", "bus_wakeup_root",	0x9c00, 0, &share_count_spdif},
+	{ IMX93_CLK_SPDIF_GATE,		"spdif",	"spdif_root",		0x9c00, 0, &share_count_spdif},
 	{ IMX93_CLK_HSIO_32K_GATE,	"hsio_32k",	"osc_32k",		0x9dc0, },
 	{ IMX93_CLK_ENET1_GATE,		"enet1",	"wakeup_axi_root",	0x9e00, 0, NULL, PLAT_IMX93, },
 	{ IMX93_CLK_ENET_QOS_GATE,	"enet_qos",	"wakeup_axi_root",	0x9e40, 0, NULL, PLAT_IMX93, },
-- 
2.34.1


