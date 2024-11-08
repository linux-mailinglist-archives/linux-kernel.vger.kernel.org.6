Return-Path: <linux-kernel+bounces-401395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 756489C19B5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03BBE1F24598
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D791E3772;
	Fri,  8 Nov 2024 09:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cmdbe6vD"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2046.outbound.protection.outlook.com [40.107.103.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2451E32CA;
	Fri,  8 Nov 2024 09:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731059910; cv=fail; b=f+yLsaVXJw/SEs9HMfG5g5VGu9aeOWosVIxOFqVpnoNAeb1juIlXFPWobQpuGCx6qHjIBAsghvBgohXWhtwich987OWhzxDLTjN5yJRdyxLu73vQgceQxnJlqZgoiSgJ8F5QWsp9XTUWF2M8oTAyvwDIRHXmnbwUuRSk9p15178=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731059910; c=relaxed/simple;
	bh=+1Ha5+s4AZ3kImPmZQesI7QEmTlK1D8zFZri4gsDALg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dmbldY4CI1HdYl7phlopJAMtNzTezDbzQcFMh2n4hvi0tidt8qK1/2G+f9kbAFMxmnLlCcLloyNoso8BSmLOk8BJLvcUnj/oPUvHo/S4FpgoEkQ3aIKJZf5usNK/slZYpbs4Uenv7hQW4yP71w60IgfdCpFujsgA1XV+arF6TpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Cmdbe6vD; arc=fail smtp.client-ip=40.107.103.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCK6PHF32PL/elARPqTKBeyrbd1v65BEUZkgfJ9CW788f5vqSFIwluEYT9Js8JE/IeaIxDdvlQhwLu8HNw6Wdj+7/WqH20RSpjkmwWHURE1DSXNkoM/Gdr0XJnQT9NpuIRp1k/crBaJuAJpddUYvAG5O83HrjZrgM3PylcUc4FRheDKlcLykY0I3NX16W37OW+7s5OBirPjRMuc/GNv4niTZMkvEzL6rPeWrORDAbOLlIZQUP+9b9Ms2W7kdiDRiVV/B5o4AUDtF82E/kfOxuasZJcCnRJJpGD9a+QRPPUkx5d/A9lLYQ08tfTUmcCl4Sl6NwWDa9tNG3TmDJBK4wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgxAIMaybu/ZK2DPePBvHp1WB19g4SJ/g36gX8KkyKM=;
 b=To0aA8IT+pgmjJaVDet8HGoQQEfwFTCUrtXV4aRwm2KeBe88H968gDUo2gxF1b0gkgkYx1DAKAyNar4Frc3xWb2bKa8sqvneBghor2cqUdIoVBuyj5Wv2dth5z57ywwuCzDriqTMvBkrUfbf6jZBYHmG/h7ZLYaJE3lUlsLGrzVkvK+5CAjhH6fzp3ZxZKUV+5F1jQMCl9sqOXvVT7vsBm5VHnPYD0ECI8DQ2JCInHQWw71wkLQnW8yh6qUQWCHBmsBsYYcGw+kIdz9Ez/Vov0ApQasFeeK0edU/+T0m8C2PLAF3IbxLpGdaWq6BjEyEWzCBmIZLGOOiEmxLXJxMFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgxAIMaybu/ZK2DPePBvHp1WB19g4SJ/g36gX8KkyKM=;
 b=Cmdbe6vDrX4Yk45tdzKhFL6Jq4tL2RJu7ZLJ6TI/Ri46ckQGeXNqXHVM7ugy2BWAqr9qTky8y5wJ1GS9Mb7NiT8mvrYCO6GAwRE0cmEGKrGKdjyYLXRCJL6Tvn9WRvoTGz5wMXB92dYyHgri9DRuhf9N9TubABRqTt/FxtzEnyCiSuh4QyBdUaIR2BIcpQiEqexSvdgcbI6OY9zwnF/tNFPMeD0ywCDCJmJhgitc8UeqmkgOgcf1LYjD5CnY+wOWhT313YjdEgzLNMW1P2VRLIXB8NyE/Q9T/uYExHKggs2TcFcFlPOp/1uMmF0QYatqBrzeS6XGUlSjTL6g7zM54A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by GV1PR04MB9216.eurprd04.prod.outlook.com (2603:10a6:150:2b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 09:58:24 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%6]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 09:58:24 +0000
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
Subject: [PATCH v2 3/3] arm64: dts: imx93: Use IMX93_CLK_SPDIF_IPG as SPDIF IPG clock
Date: Fri,  8 Nov 2024 18:07:59 +0800
Message-Id: <20241108100759.682260-4-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241108100759.682260-1-shengjiu.wang@nxp.com>
References: <20241108100759.682260-1-shengjiu.wang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|GV1PR04MB9216:EE_
X-MS-Office365-Filtering-Correlation-Id: 66b1bd4b-e17d-49c4-1fb2-08dcffdbe277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?drVr88eE8g8+qFpkE3Hf1D586B5u4Sl/emJn5Cn1nbkAGgG7DB7L2KEBoO10?=
 =?us-ascii?Q?PW1CB0CmwncTTnOnJTeZcaKOW+rpQRx1PmNPemmIdrchPCi4Y+lIXkDn0d/N?=
 =?us-ascii?Q?TCD7O/O+yE/pEs90AOrpnH6f1Gc/2FHEadOihWZirYMJ4p5dRX78/NYiwqOU?=
 =?us-ascii?Q?1HHoEJwLphVZztGqPONQ4Nt/Em3GiV71gCm/GjFUqOeOP3nDk8ettA9eX02M?=
 =?us-ascii?Q?dbsEgvEdUPg5HVNkwXg3xc16qbAcO+Z3zzL3d9p1I2+2yGFudq23bxEd1/MM?=
 =?us-ascii?Q?1cgiBgXND3wpMgNYA3H4vFuUGoaLB3Ai83B7DeIwBoAqYdoHN36rhej8aysh?=
 =?us-ascii?Q?pDfHfj6BjS4ZjbMK4V038NOl98Ta8WkIYijecTEkO9CsxvmtrNA6d9sp6d+8?=
 =?us-ascii?Q?LuEHtG3p2QK8+6FwxraIzCmtUc0kt/YElE8911CpgPw41y+fbMZ16T9UNhIt?=
 =?us-ascii?Q?uv5VCz5YBG1wtZLnP+zIRLKKAgDlGhC54BmdtrE2Viug02hFBT/03au4z4sy?=
 =?us-ascii?Q?URttHSKaScf0vrSMKisEjUCcv7+m+wIbRmzAfVK2fS0da347tgbyoqgp6bgX?=
 =?us-ascii?Q?1mLC/ICyA8vS9fQ3caLs//M/jsmvbYIOFoRw8LV7PYcjYajPejX/R4Kh7ar2?=
 =?us-ascii?Q?dO2Rp/ZYZdQIg5kzoVZNaU/gD+uVuym96fNSJulGXfkMJO8aB604d3vaYP4K?=
 =?us-ascii?Q?JBY8wWSjMmtgSOIpsQEnT+BgMPDSuD5sMd3EH7XTwS8e3p2/E0O3pvvfF6jH?=
 =?us-ascii?Q?mUaIPGqoJPohLP98OeRA+ltGfdJHIaiS4rg18pTsvlGLA4+ufUtTrLVJDaJU?=
 =?us-ascii?Q?AaNqLzKRHJIJ4/cWML+pli5SK3Lb78Y5PTsbUVlHiEK2FP6Sr7BTJI+0YFvX?=
 =?us-ascii?Q?Xhi7n+zuV0hWD/CUmZa+E3Fs4mnMvZM+iSZi0jHmL7jWDHXI7yCw64M2PKAa?=
 =?us-ascii?Q?7CKgXS4WJj+adz3s1RRuVX6164V3tcUDSJzOegjV8BQ7xTTHZwy2XLejSFbg?=
 =?us-ascii?Q?khGY+XW9M/x1xgU5geXkN78x7dYdCyBGPo6/mVDYmLqLSoNBXOazmenYmVhE?=
 =?us-ascii?Q?O9H7Ab7V4NLiKeTbUr7ggcyg2ZmRBYfSXQuAFzvfb6tpaWZ6L4kt1HqTF1hO?=
 =?us-ascii?Q?BRKmJqiMn989OECDTHBY2ahS2AcMw75KC4egTxPBRb+Y+3Jc7Q+D1t2iQbZ/?=
 =?us-ascii?Q?zMjY9cT68zdnP+2U0eKnrTAhInoDXWCrLhyVDI6PG+gKVx2BSrubCL6a70jr?=
 =?us-ascii?Q?TXURuFuonGKAbGaCl1/kObKhr/Lw5D6WWGN/jVHylQu8BCzdg0LBA4bdYgQ2?=
 =?us-ascii?Q?Nk/SeXZvS/qb/LYU37b9ve9Jha3/zPigihY+xLfki9+q+cxbEbvhz4IIj6jk?=
 =?us-ascii?Q?TPz6A1cVzoGOZ9niKznA7FqleeAC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xzYVqbPPRswiKFm3wAOZ/YZDEPUdAbS139p38R4ln+aZmy1Yc+GW4vijIfR9?=
 =?us-ascii?Q?zPJyClmXR7+pzJu+7w/5mkdIToxAaB36KfV6+4irIBmZ6GreteuF3n+LBPyB?=
 =?us-ascii?Q?KIutk064Q9uo5QhuIVyAPkT3AoxO7+hBJrteihAe7QFUQUvk4+vIFo/FLyjW?=
 =?us-ascii?Q?TKS4m+//ricc813enn0YnCJDAkzacGAJ0GtuIEOp19fZH9KJByDsy+WvrSAQ?=
 =?us-ascii?Q?yFdkWgHfB2lEtOMSSC5cyYwOMpBxYjoM1rVlWXjnFSA51ZjnMBjWRreVWUQm?=
 =?us-ascii?Q?DiKum0PzidO6Op9XI2nxpN/dGdFSo+P7MbDgX1z9za3WHtxGLHRmOOVA2QF+?=
 =?us-ascii?Q?MeFVp6P5In19dHhwcqKK2n3YayD/vkJo/MnTUWHksZOGomx8uAEbjsEzKFK2?=
 =?us-ascii?Q?xiBiuySQxU07ssmdMAuXLKCInKA8XbVnJmatm66aqZlJvolCrSuLqTKGbrcX?=
 =?us-ascii?Q?0pLmfQ24RqnfYw52UJUZanwrZ64DklnC7yHS0OI4GC+Iv9cdTCRZAQL3zVP0?=
 =?us-ascii?Q?D5/aLYd94azB0UtiwwHUTJooBX7cUbmKvWZFZ49BUYLeMtPV/QcL/MstscQ4?=
 =?us-ascii?Q?yjlwh3+lelBbTJoZOL5MHv4d7qUuSpkQ2b+Axy5DgYiR9LHA0apPYXR7iLuE?=
 =?us-ascii?Q?IL0PDNvnnd2fBP+zdR1PKGGrsNsppurBsonNS6wcCMBq87zNu0SpJQHe1mBv?=
 =?us-ascii?Q?q9ae46dTiF02VXVI5MU+OVMgoW/SbaRXLE2WVLJfRU350CwiBXZ5LF0Uox3g?=
 =?us-ascii?Q?wzcGZiKBDuPFHYzGtvgNeTL9ZiO2oZyqK3ihzM2EeKj1w+ISQXqfWBJkl1g9?=
 =?us-ascii?Q?DEtHYHp82LHkUn6X1M/J7y2zaGxKjwuXmKJVLPByEz22hHtkpoesn//iRjhh?=
 =?us-ascii?Q?U69SQNOxTRrkh+aXp8JB9xj7T1Gw1wz3yk3cdNaxqDARlGWjHBtTs077msyj?=
 =?us-ascii?Q?Z7TEnCfKxzxW05VxELh4paVEF8mHtJQT+/aqPmTQ/RMU5p6RHEYspvVjoo6w?=
 =?us-ascii?Q?cVHwYOK/tPqXdm8Yno623tQPo/IF6SGhvvoD92+pgjW7IFhMKnlHFroJG2m7?=
 =?us-ascii?Q?Q0iU6hLppRU8xQEJg7DbZHxHs+Y6VLRozXqcc9RV12ucHLAhZAbETnvKwOm4?=
 =?us-ascii?Q?pszh1D0zH1RYagvhEcru/D+4KbZkpPd8ndKKh9WrPjM88+hqPsyFaX6S0Pah?=
 =?us-ascii?Q?wK9KQHPDjOTDyn2cE2r/YdsPqmtLXb5RrDQK+ZPNjtx1OtHmw3bnGGIRO3SX?=
 =?us-ascii?Q?u32sG87sQYJI7I1OboX48+eiuFJQPpJRDpjqE4cRs2Fa75L7ppSZcaALC0ro?=
 =?us-ascii?Q?2Za8W1f+dOWCJcfL0mphgalDz0/hcwegr9itFp5Ojpdu9DzUTllng/VprnfU?=
 =?us-ascii?Q?PqRt9pLCx/yfrBddkOEiIRJy7+d0lk94Uh83pNro3iM1ARfU4nqK15cM6Vcm?=
 =?us-ascii?Q?c5C5ra7l2SRLlWGwez28ANr+ZNBJMMOJ/MFlTP/sDIuKikx2iVfyt/OTJR41?=
 =?us-ascii?Q?QVk3N2EvOBz4Umd/IkD4DiutWbyec7wgmU/xHeSsV+A5Nom/hNt+r9shyU35?=
 =?us-ascii?Q?d0x7qG9Jw/NmafJGVOq4L+IREGIw85L8G+dLEMPb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b1bd4b-e17d-49c4-1fb2-08dcffdbe277
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 09:58:24.5797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bo9aX/0HTQSA9RWe5jtNpMg/R03QiiIm1n9BXaOHQP/ZKGXERbTbvSGlNhZ4C0feT6/cEDqc/Q0eb+DYFAnzlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9216

IMX93_CLK_BUS_WAKEUP is not accurate IPG clock, which
missed the clock gate part.

IMX93_CLK_SPDIF_IPG is the correct clock.

Fixes: 1c4a4f7362fd ("arm64: dts: imx93: Add audio device nodes")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 688488de8cd2..56766fdb0b1e 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -925,7 +925,7 @@ xcvr: xcvr@42680000 {
 				reg-names = "ram", "regs", "rxfifo", "txfifo";
 				interrupts = <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_BUS_WAKEUP>,
+				clocks = <&clk IMX93_CLK_SPDIF_IPG>,
 					 <&clk IMX93_CLK_SPDIF_GATE>,
 					 <&clk IMX93_CLK_DUMMY>,
 					 <&clk IMX93_CLK_AUD_XCVR_GATE>;
-- 
2.34.1


