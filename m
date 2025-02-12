Return-Path: <linux-kernel+bounces-510751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE90A3217A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A33ED7A21CC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9666F205AC0;
	Wed, 12 Feb 2025 08:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GMAWb/yn"
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012047.outbound.protection.outlook.com [52.101.71.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07723205E22;
	Wed, 12 Feb 2025 08:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739350305; cv=fail; b=ZHLf2DWjOIZGUE4t+APZMLm9lVxOzWU1rfTfIe1FzXIAY1mMUZJZPTMWKWsReQe4PgKMyR2RjJVhjWQZWTi4/uZCOjaosPi7DLev9Zf/ttHuNXYvRmhBUrEWANWT3Fwhmb6nc2+2i9qRi/Vkl0TC9UMMD8v3sOUip552fKyQWv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739350305; c=relaxed/simple;
	bh=b1aIxIdh2gfc2HVj24h6AE7IofIwiAq+8fKYVR/A6WM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UpN0/DA6TzBs8Zw+kPr4CafjMwLsRIT0zA9ytiWN+2fUz+akwMnnFCvVaBEd1NoMw8TB1lxcwVSHg+nYSjroQTO3XF0S1WYKKqBHs6C9KKTFuDZTcwJs8uFrFSG/PlOs8IAQLsRW9LgXndWzqJiBhzcB1lPA4ICkj0RNHnNuK2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GMAWb/yn; arc=fail smtp.client-ip=52.101.71.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kXaO3irZL87JVbt09MR5ovgITvx0jZ/HIYuCVTwPYmK1zkXG3iq4JxlS8QInDJfhCYK9u3R8EcjrStexNK6EMzWaL0Af1WOEVW+kfPvsEvm6PsOc/hhXXZrjvq4zZklETST3bRCRxDjsCSp4u2IXmBKj9tTkJSFYqCeb00QPNyPLmKTeC5U3vvkrUw4PtL0xPLVowSeJ7+saWwJqTOlUcqFvSFOs4QhCDY+mLSn1b5aLtYw6HnZH4SPM9s0YS7gg9+w92WalDHwVbv7mlpq9xP8Nv0x/rPUNEgjnZbQk61HOPfJ4HacE1fD8zoPfId2wizIAyghzDcLIlm64FIW31Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+95mQg81KOQzbrq/XJiKokwdbquX6+poR2o8U9z2kPI=;
 b=Evz9Gf9mjpp6s4T8ZXXWkkP4Yg5qgmHOEq8nUVM9hxAc0+31Y0liwMFIpjWTB8I3rlhdC6DruUp7g3xN8MKVTO1orMTUBMhJNZ5e37MzUInxpZvDZldZ4ZU0eOAgu//nHePH56625qn97fZQY+AkXhQeQm7PV3BLfckYEi5hUF4POOB6/qCa1kTS9K5tfHbgqTI94j0YX/U+3Nn4UeK9wtB6+VEx1DOH12lS7p59P0eZPlAncA/LyMMKBziDXnsjQ0tiF9fByN0of8H+1XPhhAU7J0XPVQiIdfr65rgj5nNZgQG+uuyP9eZ8j8l7M1kP75MxtuUMS7lyc44eHBzJpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+95mQg81KOQzbrq/XJiKokwdbquX6+poR2o8U9z2kPI=;
 b=GMAWb/ynZ6CUz7lzxQjXHIOGMiPwmcJV25DSXup58Hjwo3FxJ73rhJ0TAQhT+hcjCSCUeEhiyizZOmFufulnI4UQh3h62fjkagAwlHSNqecg2I+K0vgCAQ1fZjSmOH6WbE+16eHfNz7cnhQ/MkEg3xjVZ4H1DbswLzktOcGs1RMuYKHhFZ1gkVCQAwaBbWkP5QSfENEOVY7RokkZgt/Udx1GS//u321o1umy72iBDJ99t9aXrKtYHDM/A6/D8d/OGiIMG21wc1aeZ9tYPmcwIqYxowwSG+uaxAoknI07xanr3z4BINFTkJ+pDiMGlKg8/9YOmztJAU7kOrshBWBiqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13)
 by AS4PR04MB9576.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Wed, 12 Feb
 2025 08:51:41 +0000
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6]) by AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6%4]) with mapi id 15.20.8445.013; Wed, 12 Feb 2025
 08:51:41 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: shawnguo@kernel.org,
	robh@kernel.org
Cc: s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	festevam@gmail.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	frank.li@nxp.com,
	aisheng.dong@nxp.com,
	daniel.baluta@gmail.com,
	laurentiu.mihalcea@nxp.com,
	shengjiu.wang@nxp.com,
	iuliana.prodan@nxp.com,
	a.fatoum@pengutronix.de,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v4 3/6] arm64: dts: imx8mp: Add DSP clocks
Date: Wed, 12 Feb 2025 10:52:19 +0200
Message-ID: <20250212085222.107102-4-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212085222.107102-1-daniel.baluta@nxp.com>
References: <20250212085222.107102-1-daniel.baluta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0003.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::9) To AS8PR04MB8247.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8247:EE_|AS4PR04MB9576:EE_
X-MS-Office365-Filtering-Correlation-Id: 2819334f-5c4c-4eb2-3a04-08dd4b427802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EFYF+7qzggv0jJ2tgRZO8nXv2CILJidRzrEYY8iw8VyCa4Lo/yhRv//5ldBT?=
 =?us-ascii?Q?pa2XzjC64QK3XuaTlnk9sGTXIG1/qyvNgciOIFNYbWwovrrJgtofMuScOd6x?=
 =?us-ascii?Q?H+8gGoTKU/Y4dqKNLuR5tyxxL/2NP8kguMcg6rhSBKv96NBhRf0uw22EpXp0?=
 =?us-ascii?Q?OAfu/dmEYwREKfC7fKypnT6Ov+iTc7Ietgl/MB6I1cBnubriEWYrV6xmet2J?=
 =?us-ascii?Q?M/4FL4+FzDy/ghCIbEkmqZrE/Mv6R10EQtOp5yAXLnps/mewEWJSsErsRW91?=
 =?us-ascii?Q?2dr1fkgSz833Vbio7aa2ju8jukAWzxO9V0HqkMjsR4upfA6fG2PA31N8NUuB?=
 =?us-ascii?Q?l6ApBho91apItxsUh2DgpmXOEJwabDT4VRtWU9NOdXB4QIcpbmJgpxzi6bce?=
 =?us-ascii?Q?wH9qJWJRUT6JnA+Yp536IC9DALL2ekhPwo13Fx+fwjtG2thO9U4GOdvIWAfP?=
 =?us-ascii?Q?7vfNikkU3AMkO2ffzn+IaS7XvgbFfPuGVGBUtX1lNQ7Jxi/WB4pla39b/I64?=
 =?us-ascii?Q?E0cV+WOvC+vfbaEpgchzEUDvWNpq6rCdxE3smLqD2acWrc/eBIpukZUHJ4FR?=
 =?us-ascii?Q?3Bb10iNYh6r8Ro99Fta94tzjhXcUqa67m/mBe0Lq03owGJH95YHRhx9lExhX?=
 =?us-ascii?Q?zol8CWCAK6FUIfJtn8nrnLRG1olfaMePLNAdY68V6d769tZop6btmX1wklxk?=
 =?us-ascii?Q?5SNyHdfXji/9/07Ewc6OEXQuV01W2Ak+HuTDZrj+iDXBcypfwpja/2JJKtxC?=
 =?us-ascii?Q?/yKDf8Tw/tIgbpbjIkMCLmyoqr88rrZbzwPQ/kVamKmbta7NQxdG54PXQycn?=
 =?us-ascii?Q?06Aix1cET/ZRfrEMVh7zUBPvF9z4PHijiiLU+FcOa0T9ShCSHOAGVaOGSfEl?=
 =?us-ascii?Q?JjdMPTiOWb4CCmwWQi3G9Kx5zNtKUkhaOCznUI1zR0yu1Ok/IGPlnnmLJ07A?=
 =?us-ascii?Q?HExI2ivpGkr9zxdyqHxI4BhYzzqd9y4b2HQPQ9inad3Erx0a+g0nLhvYFp/6?=
 =?us-ascii?Q?gmraXL2QqRLsdF/6KcrulRD2vVbLqXwfdRcsTEE17ab2hzwXiTdqq/QLQjtG?=
 =?us-ascii?Q?HGMaEaCoJ4IbzlFlHIFeb3bFdZVxbeuGw6uHrHHEhiVpwZNnJnW2F+PS9pwd?=
 =?us-ascii?Q?t2S26NZhDkypAPQ1cE/VTPYVh7PZjxXpSaYgf0T+qAn5FyleMGDIHUiXPsGL?=
 =?us-ascii?Q?+iasU+BEGTAkNubvLLYYxLBbCTRhqmYeThfkskTyMN0dsDlLPoj6ybQlRPee?=
 =?us-ascii?Q?OgvuprzrAVG7B6ZBziSUu+Y5nZaUIvNnmQ7bXi9GwEE8SeseiKU6j2sPHL8w?=
 =?us-ascii?Q?5NmS/bG9uc6mJsC533xIkZPCj8YkF6HoSXW0+hOZhuIFoD33C3//fvRPX02j?=
 =?us-ascii?Q?KEhRfI0XqvY5AawihGXzsjsSzZa2/LKi8+ryBJtkNCPj1QZRuQfIVBG1SjQz?=
 =?us-ascii?Q?TmEdduwA6CgzpvOUtoSOttzzsHzpCxkc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8247.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oswgW2YtI2mrIVe9fqhtETGk2hjSVV/EqhQp08eHO17eRk/yhv7Ajjj/n1Ae?=
 =?us-ascii?Q?ea1UI4Z1kvJaVPmHgaynV+vAfJMPpeXiJaKt0FVfhdsAGdDldltPCoz6/tkl?=
 =?us-ascii?Q?vMgH/H7WXUqi1aMWrGVs4kT0iUu5KYJ9Lnkvm/zDsk1qoevRgkVzvmbSqLoi?=
 =?us-ascii?Q?+JkOY5l2omB50x6kZBu5Cf5HkpAVi5OW9yD4eNLLxH0cqOlGp5dQ6qdS7Zkz?=
 =?us-ascii?Q?B8bYLe/sN7GV23dRwUvBpPmzOwCuFcVkN2JLk1ZQ4cxWaONl1UIcQcrR6GDF?=
 =?us-ascii?Q?Vm5GSeZ53EwpIVGncIgrpCG4ZVxR5Xtcfjkd+5hZU/5iJLsbbsCyxLVamdjP?=
 =?us-ascii?Q?cohxtyRNdEQsi5l111zruzMjn9n5Jo7PZY4xwvGFMdXa3lp6UQhyYjKZ9Rx/?=
 =?us-ascii?Q?lGqtJzsJF5T0qJRTp7Y76O5TUv1xT0OExhStZgu/FnOlbslQv9JIqTei3VUo?=
 =?us-ascii?Q?XpUel7vrE85e7LLdyG8I4sMWauI8Zi+c+usYeEM6Yw+PQtPA5GTpNojLr9U0?=
 =?us-ascii?Q?szor/fImmegcWtUvxRnOcQp5fknqWEE7et2O0FtTL2w7TbQgsUOWfr/pp5eR?=
 =?us-ascii?Q?zeNAfVSgacm/iYZzMtZZ0m6CYqMWDKPHUmG+J+sQQHXxADSQe6l0sbvgp1na?=
 =?us-ascii?Q?eXn5f/z8XEmugQTumLwmiI67qanjz+R0KMtZZRiYm97ZQ9QsUspo2m9hwMKp?=
 =?us-ascii?Q?tK1dEl+QGaqAwt82sAlX8O0ffhza80YraU+g3p+Vi+iay4IqfIw0y/c/60kD?=
 =?us-ascii?Q?hlRrt7jgysHyXprjPKjxNFsw9RscT1p13WkNgrGMwyZsplIdNAxy0wdBwAYj?=
 =?us-ascii?Q?ViVBFW/zyaDSioICxQ60iCC9ip0lIBSfkvD85TsqkrhlBqX6LcviZPpcP2wE?=
 =?us-ascii?Q?5TOZ+aiSFDZ7++tHCWiZNI4dfRLoob5AI69iQvrCIfBchjiILB493yexB9/z?=
 =?us-ascii?Q?LPeXhZ+hkMCjUN2lBtgC9qITosUUAgwI30gcptqkL+3FZM3kMDdeiNxFDx4i?=
 =?us-ascii?Q?DXxEDSPOLdmZbXb/J9VhYrKK6EAqsKXMgG5GWFBaIwYTNrHHkP3sdPGq1nEa?=
 =?us-ascii?Q?YmNE9CvNKxG+0F+B6wtTuFT34wuHqdQdE47EyJ5XCJqRgMZIQMVlQ/tRgtDF?=
 =?us-ascii?Q?75Y+0T9RQ1NEus/8mUHyZBIJzO9AsWeaoeEoIVidjH7ah4DMoT3+fe3yqEF5?=
 =?us-ascii?Q?BPSR9NT41VETTDpHUo5wVzsepE+lA3+G8PV2Vt5onp4nQ+MHtwxUWW70SPez?=
 =?us-ascii?Q?8CROtGANssAg11G9QCQzei26USkGAzjgoowiudjaeHRr2bDy5g1B0erqIs4n?=
 =?us-ascii?Q?oaqf0DjRbQLPjCnpkMlYD6nbXNI7JITOk3D3RmZLMN1A4EyEYJ/iWP4so+Hg?=
 =?us-ascii?Q?oaAVgPPmY/aXrvk3LRYKi4UbBxz1PHQRlWN36P/C6hQYbWXr8bLuf+tNc/G0?=
 =?us-ascii?Q?EQb9BU6k6JWFp6WZZ2KGqzKOqNwqOLdleDtoFmjo6oI7/xoGrg7DGlXUfink?=
 =?us-ascii?Q?kXYoXdh0p7TQPuv014oawQiRScZljJSXlQMQw1xomSqK+J1igE1PY7XlRZSa?=
 =?us-ascii?Q?rRVNABo9GMxZKogCyR/Zozz5bXkkEukMa6F4IvLA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2819334f-5c4c-4eb2-3a04-08dd4b427802
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8247.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 08:51:41.3166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w0fEvtyy96lfe9TztfhbRTwzAu1jugMXnNK235xtHfX/9wmfBbvomg+CyW5zT8qx3BgAZQfwvwImrKKkS5vlyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9576

DSP core needs ocram, core and debug clocks.

Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 2f94c55e4999..14cfbd228b45 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -2416,6 +2416,10 @@ usb_dwc3_1: usb@38200000 {
 		dsp: dsp@3b6e8000 {
 			compatible = "fsl,imx8mp-hifi4";
 			reg = <0x3b6e8000 0x88000>;
+			clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_OCRAMA_IPG>,
+				 <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_DSP_ROOT>,
+				 <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_DSPDBG_ROOT>;
+			clock-names = "ocram", "core", "debug";
 			power-domains = <&pgc_audio>;
 			mbox-names = "tx", "rx", "rxdb";
 			mboxes = <&mu2 0 0>, <&mu2 1 0>, <&mu2 3 0>;
-- 
2.43.0


