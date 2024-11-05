Return-Path: <linux-kernel+bounces-395947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C89AB9BC534
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 07:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88256281099
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 06:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069251C4A1B;
	Tue,  5 Nov 2024 06:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bHBnXVgh"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2049.outbound.protection.outlook.com [40.107.22.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CCD383;
	Tue,  5 Nov 2024 06:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730786498; cv=fail; b=uPg6KN1+0m1QwWrNlnIZq9pHzkumlolHdCbcY0IfThlC28UOg9Yeu0HLMPJ9B001u1g4XUkEOG2ylmoJx+oCuoln5Ehnhr1Ob+Gdk1WXmA14tQOFgo0+B97rEsW4DgoRMBLzcd+HEa6eoWdK2cKHyqZ01cN75BqQu+6/3sqHTJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730786498; c=relaxed/simple;
	bh=PbTZWat9Nz2/mQCS/Rc1uasM0prccUKTZMNcApLS7KI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=qY9st+rhSNfV9er215hRGPAIj2wk+j+5hssDz+6e86nCIqdJYhIexQZPwd4tTjb1YxRbc71q7W6v0SAeE+0B3S7qlYLcZkdRYoC7FkXFO1uEM3RgbrwHjl+PzK/IL8iHNwQkvfps82CIaHTfnnAKxYP986US1oyjJep3ioNkHoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bHBnXVgh; arc=fail smtp.client-ip=40.107.22.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IkaTFiSR7w3TfJ9bnLlEpF0g29dmrq2zw375LrFrbY4pc/DJ/1m1aE1m1MqhRHwx7qcoZiGGVBAiNQUJ/HwcUeZtI+VjGmW4D+I2C2RT+oJNDsyk2yamR8LJ7y8Hb9Ik/2GQay9MINIl760E3VPIG075lLigvPmAkwD6fcACeTAdhvY0EOBa/bR6HgNbOhsmMFhJmeUdyAKBzPLyiUotTMi//AqA5/ZBrJlt6Vbecf3iP8EPQdqAb/20my4WRO/qAN/+ibm5iN8o19yUlC82+ifXBxHlaTAS1BxzYYMEq4fnT8a2p05NHKwH4Cv/T36Bbor2P6HSgJ5K0j78pvlxXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOpCbIfJf4G3UaKhanNSH98fpbcQb6XosEQOUA3kUXg=;
 b=aBQFcs7NEvDg+w+kX/89jVVvoj2say3pTJh4m5p2GERaoeaCs1xZw0a6EYyyjdw1hp1nHtk+F9jmXrYMGJ4if0eMOAwrWZ0V1IKTXx+JPnH0KclkS2KZLuel48IgKIIZ1++yfPa3mlLyKBlmBpbmlTthP8VjyFcarCBSCa5nfTzL5QlLbEsuLvoMnal1k+96PQ2YUdiT3V7a7Ozi9C/y6kGa62hJ/dO4sPQOdBnLJZj5uQXVt1DL0memmDToHcHQENi5EH1YG04spnmX6SxowfhfJmM89Gi2KfSFCIw5CVElH1N1m9LBUcph1+HYAYrd9HLultfURgdxkqbZAd0/rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOpCbIfJf4G3UaKhanNSH98fpbcQb6XosEQOUA3kUXg=;
 b=bHBnXVghwaLuFN9nNfV6B3elLPkvzGqMfhJKQtTXc1kxnqMJXU46GMo/p6cQYVsQwOj7XMUxdYXq0NmJDCV7o8p+zWhZ0lPWdyf18S3fr4znybn2M9ziJK5ATSR1SXnUzd4bvA3UF1DZvLrobnr1gyO34I6G2C26aDCbyH/7fT9EjguPX5QCub5E/ijUVCOqGouJTenQMzKFsIXX5htKKRFTszHjvhgJBt8ysnVuSnX4JXERm1ZU8aaiV8eHSWpe6+o07Mv9AYdNGiWL71T2xPhagjHwCKNC6vD/q0RPrphwI+XMHTdFPLpTUMPq2scy4RZXBm4nsHOdEoWsutyxKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV1PR04MB10895.eurprd04.prod.outlook.com (2603:10a6:150:20b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 06:01:32 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8114.031; Tue, 5 Nov 2024
 06:01:32 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx95: correct the address length of netcmix_blk_ctrl
Date: Tue,  5 Nov 2024 13:46:02 +0800
Message-Id: <20241105054603.1470260-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|GV1PR04MB10895:EE_
X-MS-Office365-Filtering-Correlation-Id: c7ec75cd-be43-449e-b1f5-08dcfd5f4c51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QdlXgnRvbVhF4NoQihS4fMa6cwlL8WuTRGhXElbvsU2GBjebnRDu9JQ2X/pA?=
 =?us-ascii?Q?w6Z7ir/VhR16VnqqvBCLmav/U1+lxOoaLHf26f36as+BufE45YlrOmPO70pA?=
 =?us-ascii?Q?Vzezfq3TFKu/nVehzd0u+GVefcnuG4FUGHt6oqGW3dvzsBCngSe2s7wxpUrb?=
 =?us-ascii?Q?4GVYaVd2eICtOOYKr0gVkgUTyzOYDBIP7n2SPk5IDUWIvZOS3bYp+e0xoVaT?=
 =?us-ascii?Q?3yKBEfrJmheHWs3r/rEO7xFB5vas0vqx/X9hnerqDAjMVqhO6ylgZ0+eEhiI?=
 =?us-ascii?Q?Xzh1l0Bzdj9OkYAm4tNxlGE5rcdU/smPfCb34ZUdEeLNTEMIxD3LPz9QaDgT?=
 =?us-ascii?Q?N+y8jeEmU8+pnIQ6Nr4ywWerkSFusVjxp4G8B0p1XwTHzieGDhKTyP0yfQ+y?=
 =?us-ascii?Q?rSR3mQoQ2JLkGf2fnLHE786IcFsXCBbcp20LYhVIKaxgZCJmwHWVK6Kltt70?=
 =?us-ascii?Q?yKVKEffo2QSkyiN1QV++LV3RlbzLOffTxSlYlwEhwGSRF04RJcxAa+YPHKq3?=
 =?us-ascii?Q?y/UGKNwVhazvqbGj1Yz1e2NKH85zVtKlDqqIA0nI6KyfCyPVjOW8u7V5LPuG?=
 =?us-ascii?Q?fOwD/4+Z6fim7fbAyPV5w2L85mrfxzGm0/ixn5FW1ALY5qChxWStdRh8Pz9/?=
 =?us-ascii?Q?ytpuTKyqKSca72nDOAIbikZDhXAxrZxkirc3QdIbEYIXLHCJpA1jTTyaGG0W?=
 =?us-ascii?Q?ftbRCvRPV5uvQD1c/pEWdOHeTfp5tEIUhf1IQbrVoUEOTn7CuT4hHd+iGYkR?=
 =?us-ascii?Q?auvvFOOWRTerdT4L19EZ9ncRhBgQPfOqq6tbVDRk2HA8paESjqQGjOVhDXwC?=
 =?us-ascii?Q?guwp6zURaZk5tlUZz6cjzfAiApG2D4XxHb2DHwb2MzshDukp/yysZ+RUgJ+d?=
 =?us-ascii?Q?lrU75gadWyjEWcCMaf070x9vbWUWH4tGwj0WPK9uT7/ZElmmG8wxG6AZNdX/?=
 =?us-ascii?Q?E0BMjZJzzVCXxkNlNQjaxDiI1e3A8+N4nxaEIrQjbq3yW+H14g4Db5EDGd9Z?=
 =?us-ascii?Q?7z8Ar+3W9fGM9H2t/VBxjerrHcpgk8yafKNdj5nXCEfF0hjkHFil4oxN5P8c?=
 =?us-ascii?Q?Jhlf3s/SK0BWWBBAyzU9dAl/Mh0SaJxEA9LGm+ymWkhRGEww1m1E6N+wDebv?=
 =?us-ascii?Q?6NSRdYNJVxwj1ZcneGRLW0Rm5ZaCASGDdnXtJzO+71Ibqi5bczD5pEcYAs/y?=
 =?us-ascii?Q?jBO+TQaDuoZuKZcocrPvJeUJKi/q9D/dPjnxUeY32veg79daOIcKmcsdM9PR?=
 =?us-ascii?Q?YJLNJtfK4V6ZrlJjp2w6KEhmGjg2p6whDYAJwOQcEu3CMnOKDpptQk+y2K5I?=
 =?us-ascii?Q?fddD2chz8cQEFH98iuPT0lkSL+ao3O+EY/gHD8xJkpCn0DnQbPSUtA89hRiM?=
 =?us-ascii?Q?3pM5ihg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gwL7XhjIV7txYpyKFhxhOoM/fihuqkWczp2Mg9PEx1tJcqGNO5mZxRwdJKfA?=
 =?us-ascii?Q?JA3noju3rsja5UAfJP1AH5IwU2YdIcthu57ilo8z3xLUDRM6aHySA35jYZQY?=
 =?us-ascii?Q?6ZQxnbNAAyyDWY0PIOQw4vY3LJhGQwhkp8xP+P5a2iz1/mqiZ3Tq/tmnA2Gh?=
 =?us-ascii?Q?wa42p5RrigeM2Tw66NDthTSZhF+1jD1PFIOlbmKWWeFd673JBdAsSBB60LjQ?=
 =?us-ascii?Q?N+gCyWFOyfOGb8P0jJ7G+F8VDwBqVLZzgsx6LHOrNZemX7+S3AvXr6HWX/I+?=
 =?us-ascii?Q?w5NaFm6G/nh6i7fzue8ezfesLvlnotlw8OrvOX7mgm42hCc+HY5rpcbvvkS9?=
 =?us-ascii?Q?VugMy/0Dh2mzwMkCzZs/nlgkc8rMs4a+8RUkhTxz/u3X7nEhPG9AR+uBlCK2?=
 =?us-ascii?Q?+BuJ1MKMaA+Xj0/yjPRdObnnuUkUhIaHMphs7DYqPPLzMZc/hpqSiEZVfTqL?=
 =?us-ascii?Q?olfYSN438JujqL5TQ+M/aUX070fbpNBjvNHWwcAxhu4SqlWfyaw/rvOvj2Iq?=
 =?us-ascii?Q?sWQweQBMsO8UgPtidvK0CVWQtoq6RopWEVlsU4Vd0KsL5yTNfHBNOEDvR98W?=
 =?us-ascii?Q?Of6VTbA+/RcEfP3kh1gqghlD7p+3W4jOMAG7JWyxdUSV4qYoRMbCdbGyDElk?=
 =?us-ascii?Q?1sQ0LGOWvsbxIs7A4PaHsHEbSwDt3RAnBwF0Y9dplhYUJKV1/vu8LlFpqPH3?=
 =?us-ascii?Q?+xfFWZ2U/F9FxDqQIdW8bX9Q+R6y4QTcQoJgnSSbVURQz7bI/G8B8/f0fNUB?=
 =?us-ascii?Q?3aqwGqubu6WW4yaQxRAS98497IrEyNDSCsr2djx3dJPYf+t5tV6haNxmoNtc?=
 =?us-ascii?Q?+/LmCOnVjLr7HReu7VVs9txQ5eAOP0awxqROyKziOlb1/iWu19pqf4xfhcwR?=
 =?us-ascii?Q?zBTpGMDPwTC+tUube1K5ZjAoFb9iWj7m9VLZBCFQuuqqIY8ZBLPDxWkLRV53?=
 =?us-ascii?Q?8mAg/nHzZN6OLPOgl/qY2P9LdHVsjprxBNNA/qTkDDLY5v48vtVxh76bTTwY?=
 =?us-ascii?Q?3OHQpHTIDYqarhjTx0kcc2xp7ljC+0rBJtbtCQzX8HtN6Pj3OBsuABYjT//7?=
 =?us-ascii?Q?PAddDc3P8VcXUBcL0FiGxcCmxBTOk9hsVARakRe+vhYJizr0i10s8U9Hzq0B?=
 =?us-ascii?Q?Hr+slWPPyMEdcCc1/8szjC88KfMGoy2QCJPKYRGhQ9X/xxtFKKASJzaPCOQ5?=
 =?us-ascii?Q?nLS5l8Xhc58eZXsVBWTsXkfNHG0xz+Y+xKxqCICrhlcrRPyP9xHWd2W+4miE?=
 =?us-ascii?Q?LH9fnt7GsOA1bo+lcL7IeV2X5dMMpByGSt+WdN9jtGPoyM22V67+NRFaPT2J?=
 =?us-ascii?Q?kGCv+R64xCrapIk7AAQHcqsWNAfcQcwnKlbrAHj5q1F5djIvNRJqkABPTWnJ?=
 =?us-ascii?Q?Kqaxj7fMh9IboOc2ccOvgCCcXbb6kY5SY/ZCdmZqF0qk5yhXLwsab3Y5fI0Y?=
 =?us-ascii?Q?kFI7pppYzzrwtH/E3uelJE6W9f0zxi8VwiJF0jUR6xbQR3PFJClcqF8LJXop?=
 =?us-ascii?Q?mrfheDiw+SqP51M+dXfPQIyqszcyhae46eSGcEW3YN9s2ZlhkAFgCU5KOkCw?=
 =?us-ascii?Q?DHZ1dYJihHlwTEf28oopowoVCjLVU1gndGDeQX1y?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ec75cd-be43-449e-b1f5-08dcfd5f4c51
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 06:01:32.7187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ewaAlFcN47i4asxrkHwvCIa6OlQpYfY4CzvS8aMW/mSDEX+VN019N8CHViwhNrM9hyehK5VsjdqrO0FvTs93sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10895

The netc_blk_ctrl is controlled by the imx95-blk-ctl clock driver and
provides relevant clock configurations for NETC, SAI and MQS. Its address
length should be 8 bytes instead of 0x1000.

Fixes: 7764fef26ea9 ("arm64: dts: imx95: Add NETCMIX block control support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index d10f62eacfe0..e9c7a8265d71 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1673,7 +1673,7 @@ pcie1_ep: pcie-ep@4c380000 {
 
 		netcmix_blk_ctrl: syscon@4c810000 {
 			compatible = "nxp,imx95-netcmix-blk-ctrl", "syscon";
-			reg = <0x0 0x4c810000 0x0 0x10000>;
+			reg = <0x0 0x4c810000 0x0 0x8>;
 			#clock-cells = <1>;
 			clocks = <&scmi_clk IMX95_CLK_BUSNETCMIX>;
 			assigned-clocks = <&scmi_clk IMX95_CLK_BUSNETCMIX>;
-- 
2.34.1


