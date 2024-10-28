Return-Path: <linux-kernel+bounces-385952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DE59B3D76
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA78EB24D14
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F9B1F4272;
	Mon, 28 Oct 2024 22:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V3kpbQL1"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013043.outbound.protection.outlook.com [52.101.67.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117321E0B80;
	Mon, 28 Oct 2024 22:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730153021; cv=fail; b=PRcS5/AmBFzbqERdAK56OB6aW+9FG2uTmImtJDaTqeAsQMpfCpStfoJN21yiL31fNfGygPaSbVAeMW//CacCQEvrsb9dJisLuM4NT85e4LnRcJDo4YT8m556ikhRPNP/PtSzZbuPA7UwkFW2Kbv4fXDTeeFzx3IP+/Ajh/lcZ8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730153021; c=relaxed/simple;
	bh=S2JTh0XQM4nR/4dcjaHLSPPszGiC4Xi+QuApB0XKdj0=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pL8PO6KLRKnOyqgEVTnKY+m8vUp4iQmaP2EHteS4jyeG0ViypQqd+XQoLc6XzWYMbnqTJG4vyi1unRw0DwGmThHR2zmVuKf14F/8r1U9cdKIn5MArC4RK7qXs48uoZ2QqyTPFHP1F2p37hNAcuM1QgP3uNmZRd2VCkQAU2fgCug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V3kpbQL1; arc=fail smtp.client-ip=52.101.67.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aF79/lU3FqHf+7o2cMnGlK4fVhkGc+XAEPX8NSJ34fbFIqcf2R2KCJqjbYLL8IbgsL5RbOFRA62NK7yw0lYITLnCIZ12m0VxhYxy0V1so1FLNyS1u0Yv+h+yhLsv2E2tlT7Y/Mz/ZYlHyRs9OlyEkysGgHcLw7Jd2UlF5gIvoERa2eooLInDKkwI41fn1igqDIqgXaKtTKrsAMO8j2WI+YsyOi5Ld+PM84cQZ2tLW1vzmy43G5ELltiGgkmzXWPP1koDBjitzsoKyyXHO/9E0AgKgFPXyFUct9ro4YZLB3JDcZ884vgWa123zPu4c66XUfIep5u3Sy+N4IMTCgWfGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fyRgYWjnckjF1PPUqUQePRkCFvkPeJF04H7NSKi/3w=;
 b=yXK2Ob7DK7OLwUyQVXEaeF12EmxmmGlqG4AS+K5qBqhZrHYpGbZCyaKtgnSzLqhJMCUn55eJl2lR8uz5ZBSsKQjbhFGQoVnppGDj1bkUXSAJ/do7bcFnA6xtC+DeGPdVs6OEm0Zjhs0BE8aU4yLVOUGjBSsLWdwbzuQRDmBnKcGBbDmnQDAB6kzY+zcPX9vFrc5oaQNj4ZkajMGbjwF1IXFzA2SXyHquNsuwPd0PVesr1tWWN4xRUl9qfi6iGDIqZGOoW+viyN38YOlk+5TPyt8FUSezyzSB0SnYq26oAsZvsj9t7eek/F6H6++jpmg1GgJ+83RHGq15w50sfiU94A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fyRgYWjnckjF1PPUqUQePRkCFvkPeJF04H7NSKi/3w=;
 b=V3kpbQL17ZaYANPxQ/dY54epjV8Pj7cjTN936OmZgIs0FWnWicwaaKFUab+NS3jsOH31EABmKPMP7tdM7UFAVcmuzWnj9Bt3kHlovgX6jswOqejDtnT13EWQJE69zqUgn86CPqmTpSQlHFNflJTcAAgZXS+P7d+pOHk0EL/zGxMTBsE7SWUucLd+3DL1OAfNUaUWQDzJIJbbwxJizYA5D0zvkI41i3kRM4oAmpJkZ6by2gNSx9BkCaMDGZq/rkUp12N7Y3yEh0ooPEzQkQcFAm5L0vLsklZuNULHfCiIqkopwNt0mFD5VsoEUeZJ/O/fn0l8JGh/FNl6QlBhKdDULw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7641.eurprd04.prod.outlook.com (2603:10a6:10:1f7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Mon, 28 Oct
 2024 22:03:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8093.021; Mon, 28 Oct 2024
 22:03:34 +0000
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
Subject: [PATCH 1/1] arm64: dts: imx8qm-mek: add audio-codec cs42888 and related nodes
Date: Mon, 28 Oct 2024 18:03:18 -0400
Message-Id: <20241028220318.2047870-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0090.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: be1dcbd5-3813-4d81-008d-08dcf79c5e41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0kcuuO1CIEhZYSUZId/0YsYbTQiu9KDlAkfV+CIoU0MOFaU5cnQejY6iAqtP?=
 =?us-ascii?Q?kc5hvO2JjFHsq5y2rfD/zazrl93c/LMNvT5df7Gbf3o+BpIKxm9CiD/J1Xf+?=
 =?us-ascii?Q?063hZNbJKhMUS4HuZKnadJ2/IH0UY5njrFwQuvbh4fhcS8phkQMVbXGDjykc?=
 =?us-ascii?Q?a68pg3JqnE/i0LkLN9oStMDPIWDKHCVC6dooFgYOd6XDhcef1jrEIVAk0+VW?=
 =?us-ascii?Q?tuli4Q+D61oZ1Ov1o4A7ABKOWNlqh4gQNX1+SY7wPdkltFw6+bHgg5LAL/KM?=
 =?us-ascii?Q?uXTaD/ovBHjQSbxzTfSFrial+O0ulFBdA7cES1N05yW/v2opZdh/Xi+cTp6o?=
 =?us-ascii?Q?mvwD5Av8CvnDAHHwp7W386y2ah3ibNWGZ1RaAg0lQxTdRdUFt9zv6uRNSWHA?=
 =?us-ascii?Q?eA5XEVLhe6ibQatfuKDmi/UAQGi17gZKZiZ0+84HJdA3VcX0ByYBzgdGxeap?=
 =?us-ascii?Q?6djRiJIj4M+E+g3TIp3akTCAQ5stqrQDLu2zWHFWQNIiQz/2TlC3ZUuqtkR+?=
 =?us-ascii?Q?YrPg37UvP7aonuaWaBc56ZQNe/FTNrGfXb9Bkzg//9ium4OlECqy3feP9Btc?=
 =?us-ascii?Q?yVfooJ5iHk9wroNN8ZiB94bW0U7L7ZLonf+AgAhm62bqIJjUMPvp18UUILq6?=
 =?us-ascii?Q?aAP2q23auMxLX7ZGNmNlo1gROC9mbjOpIPOnp6ZUhsjHMLbiSkRPUfJDzDw8?=
 =?us-ascii?Q?DBfi2A/fqz6m3KebF6QC9uXiaK1Df1VXmsjVwIuWpjZtRLOZ4BIyiCNOHwwO?=
 =?us-ascii?Q?qbNotCvCQQvOj0R8NqEeEZr2vZIT1us1fOPRSfOW5ACWPWKVrPv9BndVkMzp?=
 =?us-ascii?Q?hIWS6hi2zppwIl9pBvLhJQoDTrrSuVmnzROf4h0RicDJdjn3WYKW8M+kpSCS?=
 =?us-ascii?Q?YQs8NDWj6OGV/FlFaO0CtLwuRBv+iNZtEQRQYfwVxOZlulkTYD7gQKfP4yqK?=
 =?us-ascii?Q?UWNSKLFjCa2RitC9TsQTE8TyEV7Od9oaNmCyyG62IHVrok95MdEkF/n8NMr+?=
 =?us-ascii?Q?xPAQ5DGoWCkdfgOtXhvcBGQmiZTYTOQyB0/sbxKuDZzAJMZ0ZMpagKgFvtkg?=
 =?us-ascii?Q?ba9mkV1bMcg57LBjRixTMs0xdFjF8f6weQkWomaqOcV2LwrMdZgDZw16ktmq?=
 =?us-ascii?Q?7RNQ+yob0gh6RgPoeBob6TALINR/yQFyY9kdf/+5R3fEgh2U4J4WdmqVhDYK?=
 =?us-ascii?Q?9NxGUE9j257C7VKACDpGilK5E0F7yd+COlvI2yEPIi263XwCQSPswT1ac80t?=
 =?us-ascii?Q?Mm9TXikkMS0u2FzkoPgFPI1/ax0uVD2PMjfmULX35WZLY9CXCaoxqpwlDsPv?=
 =?us-ascii?Q?6ZO+xr8Py2dLkqmrqoJWl66EiERTdHHbwFdul7nMyO+2csKgnfQEnPEwwCBK?=
 =?us-ascii?Q?+HCOXbiDBi4Iin0njdp+qpulC7um?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iTq17fnDDNqADuAQCgfXZIv77UXXpgYNUl8YJ6ULb1w8ip7mV4A501uGqyGL?=
 =?us-ascii?Q?qlrM1kLgbHajyjcWArPYdDaCMdp+wNhUsGuNkP7nIbu9OzUvDbO5wHMAUc8L?=
 =?us-ascii?Q?O722H7XHLyTyOvGVFOIWC0TI7eq7MUduuqNTPe2TIWP9VC5wF0ibW8RbjUFB?=
 =?us-ascii?Q?bH3u2G/E31k6DxhmdnPHeH7RXLa3JkHvADi9I+StYAP76uLKxUa7zSkcTfhP?=
 =?us-ascii?Q?AwpZDkjSuzWUiLg56ImwD1v7U6FKY82/5T7KsFovdxxN0NBTKduL0k3FcDy2?=
 =?us-ascii?Q?ab0EnfwN6MXIg9x7Dr514KP4/p+1gDKP5MeUIQuY7hw6PJAphjknoJPDkWNA?=
 =?us-ascii?Q?ynE2YQs+iQMqR2DKeYzuPtRwHZWZuo6TgTf7n7MfPaS2HaTFx5jgnGD7lj2t?=
 =?us-ascii?Q?jikP0Kg3QBBL+k2P8Fy/j7pGcrYqR8G4i2SHZp6RMUmu9fnv/cun2+qdl5/p?=
 =?us-ascii?Q?QO7VQOTIcXcQ2Kla8zRVjmJjuMJuww1K2waci8dVYsyqgrAr/1Z3iMfwUc2N?=
 =?us-ascii?Q?Zo84mXzi4heP/lEDRCWFvo7DFuROfr/U5QT93CqCQFZFIcnM4rLfYy+rpgoU?=
 =?us-ascii?Q?Pj6G1yf+FcqI4NaXudGCYHZXkB2KZjtDvJcvn0Smp9kijEYTORYDX68atyPg?=
 =?us-ascii?Q?PsLO0+ChVvNWSYZIqEYeehEH++yAHf5mfEgf/AVmB6ZzOeZTk4TFbQyKW+y2?=
 =?us-ascii?Q?BClxyx1XHN78SI448J55aNrmrfDcHEEdIojA3BfbHbsrwVP4SK6E2poNawag?=
 =?us-ascii?Q?0WZPuteRtc3IpjR1NpLvcvHGzs4nR6Hj3iugHXQOQrEFMZ9ETgqMJsYUfXbJ?=
 =?us-ascii?Q?53mW2zMycL6oEepoQvwGbEHAf19ps4iKjcsQ6x/DIpXkjZCIhNrF4ajlH/zy?=
 =?us-ascii?Q?KOyIuhbkVlxOzCjHInFfh7iN/of6g7dCdJ6+XticZUAJcmcD/TVK58ZL7qcf?=
 =?us-ascii?Q?H/mGZ+fmkC8R/5ckyz8t0WVBh4z/6nR7lROTHBxaEH2a4y4dfpgcxDyGKjtM?=
 =?us-ascii?Q?drq5m6YhJrKz/5Q6wLuFt+tD5z4x+BVRH9b5jl+fP30IslzH6108zJt9HbHt?=
 =?us-ascii?Q?0ZgEr6kUCuhJ1Reu4d1N3tW+tnyhXopaAA+clrBKvZS4Nx9KhLDHr9XDyjL0?=
 =?us-ascii?Q?WSdsQYO9oux0G4I95PyzHNC4M09PiYC1LpDQIESZEnt0hxpSa52w6e4LkgZD?=
 =?us-ascii?Q?Jb6cfUY6LVVDTE3LPDX1h5Uf7ySgiuU0m3liIvUP8onlGxojk2Yt1ITvsWKQ?=
 =?us-ascii?Q?vAmeGc/zToSwEI7N9FpefdVxbt6SZXyS6tPM3nEOKHHYxsAWFIf0PjFBhDGx?=
 =?us-ascii?Q?S9Q0LIKyc17t9opj4+nIMJBQLKT6Yy5EXgOpP13aW/vv4Ai8oiHrJ5aT1n98?=
 =?us-ascii?Q?pxZV5jp6Tw7w/7y7duLV0VxGjbeQNG9b/LjqirYQRpvU0wrsUBq25KNvoN6a?=
 =?us-ascii?Q?QARvxTiBYDKekJbe357g045G2yQztzmmQ6egCOXXXTon6NLQ+gYdQbb2ANnA?=
 =?us-ascii?Q?cYciyhZF/+3WeRVqSYtVCMTkGU4f23TWdGLjInepPucLsXyRh9mb+DG1+1L4?=
 =?us-ascii?Q?2+tNy+rQ8LFi4kxbidSnkTTUCuIhQNdbRRm3PR75?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be1dcbd5-3813-4d81-008d-08dcf79c5e41
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 22:03:34.9630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: thLlxvHWeHZ3NQ1kKPMwHdishKiPxtWnRSZOVngfHTzXv0r+rc1nQI9f3q047FflyYjdpKr3/aLpds8Mx0MZ5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7641

Add audio-codec cs42888, enable esai0 and asrc0.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 82 ++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index e983633a4bb31..31cf02275ca9e 100644
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
@@ -223,6 +230,27 @@ simple-audio-card,codec {
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
+		status = "okay";
+	};
+
 	sound-wm8960 {
 		compatible = "fsl,imx-audio-wm8960";
 		model = "wm8960-audio";
@@ -301,12 +329,45 @@ pca6416: gpio@20 {
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
+		status = "okay";
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
@@ -691,6 +752,12 @@ IMX8QM_SCU_GPIO0_03_LSIO_GPIO0_IO31			0x0600004c
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
@@ -725,6 +792,21 @@ IMX8QM_M41_I2C0_SCL_M41_I2C0_SCL			0x0600004c
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


