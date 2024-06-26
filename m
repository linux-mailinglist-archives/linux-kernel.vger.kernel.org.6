Return-Path: <linux-kernel+bounces-231458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE559198FE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10D0FB2290F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91879192B90;
	Wed, 26 Jun 2024 20:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="E/Dt0cKk"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2080.outbound.protection.outlook.com [40.107.22.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEE2192B96;
	Wed, 26 Jun 2024 20:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719433560; cv=fail; b=OBx7KaCtBKFtqJFhuRQ/k2QlP2nG0UJRG/Iv9tBsVRcbrjf8mcdMfBsen5BBA7qdamgq1eEc5tkLtnnD+HEp3Qk87pK7h64GoZziGwcV7qhsDpbfTaebhzcVIFXTBHcFyTQs5cJyNJ5eXvKG7G2KW66MzAVfpJCzer09Zp5BDSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719433560; c=relaxed/simple;
	bh=E8Pd/H3Sr2qrimEIE3maDh3fVhrfvbNDz85WpDm3j5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZzwOFtUeQ2Jl+dQtqmOO5CcqNms3oGw722mj7gAQW5OhKAsBPjQjCY8J3XY7og7TydFsN6qmt21bIB0g+Qvuy7J0P8bnhSxcSv+cCC1yrM9/QmWt1pNkPkXw4/AqkGj/5nLeY32u3Vmu7QHzRiPPq6GFKDFC0Hbp9F1tegsJnBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=E/Dt0cKk; arc=fail smtp.client-ip=40.107.22.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHlrA4AwzgF5KwUxdBy2b0K5vuMfuO+rpd5jodYHmaUd+W4+/enNCk7Ty33zCuG7zDp5dM8xS0nOEjr1VB0HwjCdmt1RR10IhFVOQ2LPd9+ewRMdNF7zDgaO5tc1ATB8n60dnlPTzF5ZZv17oLz3l14UlO23wZryrCpCBQ3Q9GbZ94JLaP0wYW6OOJg8TA3j0S7yBQXcFo1eoMEIRA506zJSxlsPjHULX3zKMlfqasU/PPXpzWplHBSC97R4ISXZIQoHgWFXSpoeg15ASl5aPJaaOvyn9F4SuhXdqkpOUrORDgDu1CwwPoGQwIws0HUrn5MVzu8m7WUKDx2683xaPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+T0J3y6c0syj+9yAo6aDyKuF2l4258cT5VqL0+22c8=;
 b=FLC3sr2/Su0nIKyfvzA1QWjTZIiYQxxBtaahzQqlWn3/nCiaqqDfMY+9u+LWRzITKTdaDT2GiFy1w4rAhA5W1e25UKRLARU1H9q85cyJ/EwayS4Og4BRfc/cwGyMMqu4i475zKUr5xW8ySQOb9NzOLlRIvEEShweD0OOh9D2yQ/Jf91yfS9/jOex4cqbJ2UskdmHFytyyurmyzDcQat4xlVQyIU3LvljxlbX524VqUTT3yOr92i70i+4ihvooqmTalowueCSXjqvpAOowkT7trkM0lVNtX0K0bsyC38bpZldi+Qwmld38Lospo9nwqL+uQKjegJYdYFrsWnJxsnWXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+T0J3y6c0syj+9yAo6aDyKuF2l4258cT5VqL0+22c8=;
 b=E/Dt0cKklvJJXIBE7/uOcT3Q7mYlLBn6x9Yi3V0WL/77SB88m2pdK4DmspM0iaO2asukFbZgtwGxOLvoDJIw938TvL2Hs3dBcqh84c0trKgswtc8R3w51WeY3rz7gMZKe6PybSkKafIlpuStwRrJfbzei59A1XEgH3PvXTLm0pw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB8012.eurprd04.prod.outlook.com (2603:10a6:10:1e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 20:25:55 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 20:25:55 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 02/13] arm64: dts: layerscape: add platform special compatible string for gpio
Date: Wed, 26 Jun 2024 16:25:22 -0400
Message-Id: <20240626202533.2182846-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626202533.2182846-1-Frank.Li@nxp.com>
References: <20240626202533.2182846-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:a03:331::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB8012:EE_
X-MS-Office365-Filtering-Correlation-Id: 74f9ac2d-e0b3-45ed-d653-08dc961e2e91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|376012|1800799022|52116012|366014|38350700012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rywMDRcHh7slBOloVtQwv8acnIErrekhn3eqcIgegRXXCa8bcue3Wj3OrxST?=
 =?us-ascii?Q?5alq+RcoTXrfS+/yRTnJxElfbKNGMye8OA16hMQD1GYHRTh81f/Uncu2M/lb?=
 =?us-ascii?Q?UrAnKFGTbe9lIVdgc+tHvOGob4n1V/ehy7NE0/hQaan5H5YzLv143WXkQy6O?=
 =?us-ascii?Q?tSCa4DSHqsVeU3FBobozT04bEIcuA4f/4L6grPy1oAMHB/G3EXXkQ1B70iNa?=
 =?us-ascii?Q?WHw9UkViFGwISVL3g9bhYryiIpu1Gr9omT7dFhy+eaDcDuzIcPr9IWtxK7Lm?=
 =?us-ascii?Q?0wQS37RleNzXHlmuiGSi+gWHlPWCJ8ySOLFO26PJkXxifu46RPWS3WEsy3PQ?=
 =?us-ascii?Q?U1EdKwB83NLQAngPsJqOdiOUKCjkYXPRcz1fyyQXjo4eqwCY/T1JlNSexCzO?=
 =?us-ascii?Q?qmaiO7G3IaG44ldWmyTkdSGPWRk1PTgcg692uU47bDf3MVwBAze28uV9MqpV?=
 =?us-ascii?Q?X6BwiPJf3cUq+fRpS+paa7WvTiyTNHa/Fp+NYOolOG+pC7GCAlmZZGULFxEw?=
 =?us-ascii?Q?K+WyF3ssQKdy8jqxGBCFhMutlnyQKwqXWDymFWUqVNJT1R8mXiTsECh7MWeP?=
 =?us-ascii?Q?cmUTlT92PMekbzunMYj+4C7q4ePUEEqaREYp1UH5uFhra7qh1ggL+lgJdibc?=
 =?us-ascii?Q?lW744/6uHFgEZWu5r9KgiEBHtTpDcxKrujIhguFnE+ZHylQWk5b2l0D3Sfup?=
 =?us-ascii?Q?ZGW0+Me4lQgCyS0GqvOyy6Vo/BBGxgq4ejdkcSErW4IiibkX4kPeM3OY5noF?=
 =?us-ascii?Q?2e6zqXEaonxFUMPjhoiwnotzfzvxy6rWCtTbeFhBEVOEZAB/tb0TsiuUO4tu?=
 =?us-ascii?Q?M/LVJJDF1K1jXpW6ZxFg9Ug+SF26WY1xy6DaS7TMVAP+jxvKka8oDsxLRXB6?=
 =?us-ascii?Q?Xptfw7aoaDfL+hP5We5EDTeYNK+R31YAImbARH15rr83Rp6/F7jl8n2BaKHm?=
 =?us-ascii?Q?DVVIppKVEAr1DML9N16kpiYiz3uPPffvjazRLZND2ovKSfNcJd5eqD+403wI?=
 =?us-ascii?Q?lOm1tiKhRZopqMrFc5dsXVu0rl9Jkt8E4xZ4AzTjaYkMbcBS1r4t7iIZn/9Q?=
 =?us-ascii?Q?D9Zb7F9TNUbB1O+/tapjwZZiHeexRC25AGIF0yEVg+OhIktj2S4CikEIgvun?=
 =?us-ascii?Q?eyK6Yc0rjGd1Eg+bnmXpo+4w7GGFm2zBdolqaeR7W+mSdy919KPh8npatHKk?=
 =?us-ascii?Q?K89kSNFzUs5E6UQiIbWFWiZPRvkjccqUMlsm1/Ix8SY5scja1zRa8KqkM5DC?=
 =?us-ascii?Q?7HLavrfMG5AvT8XXoB69fNbuSnYJgmDAjskxKDVjopTJVHwstj+Rh0w+eOg/?=
 =?us-ascii?Q?EiNVpVEP++xHyQfyuWxC8lwHtQsZwY+Ye12ctcHP3fBrqaHToXksj9M0XrCV?=
 =?us-ascii?Q?eezv3Vw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(376012)(1800799022)(52116012)(366014)(38350700012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iTnjlCXYZif8ENIt5NGryP7AlKDFHfjG8BY2NrbtiLBvfYdxVqsyIrFyup4I?=
 =?us-ascii?Q?BGwoGoizsEKG5m5GCk+ob6TZDHif0OTvImz58aBx0s9367ruYABjJs0wK9xp?=
 =?us-ascii?Q?x59VQ8/6QFx/KdMAFtheLtHm3HBHUVeLTOxqY/NjnDx3H45oJFQ9pjYWUvza?=
 =?us-ascii?Q?dEOAX5+h+OEXDWRQGOj2/Clc268RlZhzqR/rHfCQQBoJfv3hpxE8T4eKSU5n?=
 =?us-ascii?Q?m6jS7J7hEzxxP2CzhEz5bLftTtOcghDw9DeKDzeww5QqB5tqvdXLzUb1v0y+?=
 =?us-ascii?Q?v19YvPbRAxVtCfudBb4uvC2d4daBIMSRf4ONsG79bHFEQ5MQCTa7M8JEZJ1z?=
 =?us-ascii?Q?xwUv3pVLxISO3oLAm485RNoy+UgTmi71sYYNrrtI6hLnGDhBTiGOgVie4V20?=
 =?us-ascii?Q?Be/XkCkAV2ZJiLe1I2EJ0HBA5ZUDFDuIHGgQUr3oNLY0GYS72fqc1ycptizw?=
 =?us-ascii?Q?oEQ9tIed+UabGnw0RYxeyd8/O2dda6m3tetT7lxCCdJWJ0Un2OwWM6pALOg0?=
 =?us-ascii?Q?YFOkRlVuIWK+juzkxe4RW/qMfgVoNuQWqsej32z3xgU1VebhFZ0wq8uYOJsO?=
 =?us-ascii?Q?eLD7n94pNSpHaP4Kk0YGHhs3nlXuRVYiRvdWTSZydxcCjyH/ixeC1Rv+H6xw?=
 =?us-ascii?Q?YF58B7ieXKkk17nEOJFnIHvxK7k8oYwzyUuPO7C7w8Y2oFsfYzA4uqGep+rA?=
 =?us-ascii?Q?++i2uPQ5XkVMshXnE+zGIvb2U0k8KheWd4lf4AEcLmjIIqGQ70cxbDU8+rUB?=
 =?us-ascii?Q?Ef0X/71LIDV0jcogHynbhQYSD2RR3TaURiet8rvHiJmlFyIphVLf4qpEjQ/o?=
 =?us-ascii?Q?DZDF15G4A1ucWuo8EIiGHTE6uleWVDItHergHDSccu6+T1aQYkMCsa24H0Pl?=
 =?us-ascii?Q?nvfuzHwneUhntojbdNQX9l04+h9KuLnwcMjLkHxqkk/f9EF56a3VD+77kDBl?=
 =?us-ascii?Q?WwaKpj1eqHiOId4my/woPCq9+oQBrm+FI7hkjhsDVoVo0Donm9sKoU3EyTbI?=
 =?us-ascii?Q?QiNiizZ3+f0D0SGwbso+FZSkmKB2vrIE/UJv2HvWc9r6OTH2mcim+rsnelkw?=
 =?us-ascii?Q?8s6q+YAbEtTvK7+BiJi6RVZSK+QRd+L+jO0sKIn1miMvKe/QfAw0YVZctEtL?=
 =?us-ascii?Q?/F9xwWacgyeDLmkKoy2BPNXqjyZiQxasHgFlGt0y58yXbYwBrPea8suzIG1c?=
 =?us-ascii?Q?9itromELbJYzQqhwF/y2SR8P2rad6fVR1QICe7YUcMZ4jbcHGZCC1ntm0jiF?=
 =?us-ascii?Q?WR2y95QZh3vPJbrP5xdvo3gKrH3xWhnu6BjP52dKZhSdZQqv+3yhw1FC7KeM?=
 =?us-ascii?Q?vSUjmkZ+XHUoBeGhBdgWfldvBa2XY0v+5fTJBV65KHBue6f8EoQVbU0ifKpD?=
 =?us-ascii?Q?KlcN1Mohq8sYpz0K1RPhf5mo7Jx3agYrrR0GcxfQNEUNtwN7uGWIoGhT0lzv?=
 =?us-ascii?Q?vtcm0xUphlLzfYcz1w22k19MoYgvwJjgmumnsjuHBzPa1aYnMN5tNJ1hfUqg?=
 =?us-ascii?Q?AsVdihH9ATZ1QMSc81mGxo8jCZT0wYgCWsjZXFsWMEH7D1vg70l3pF4ytNTs?=
 =?us-ascii?Q?XlmYq7JS0t+kBwheJtpkIaAzVjxymuKfwzSO1jNy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f9ac2d-e0b3-45ed-d653-08dc961e2e91
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 20:25:55.5516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VB+nhfzzocrObVSSK1x8KCk13aMKYySw30wsc4bo068aHtieoR+w2MZaKW7XSHk9aQEnVvzAhWzkg6NlUtWY/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8012

Add platform special compatible string for all gpio controller to fix
below warning.

 gpio@2300000: compatible: 'oneOf' conditional failed, one must be fixed:
        ['fsl,qoriq-gpio'] is too short
        'fsl,qoriq-gpio' is not one of ['fsl,mpc5121-gpio', 'fsl,mpc5125-gpio', 'fsl,mpc8349-gpio', 'fsl,mpc8572-gpio', 'fsl,mpc8610-gpio', 'fsl,pq3-gpio']
        'fsl,qoriq-gpio' is not one of ['fsl,ls1021a-gpio', 'fsl,ls1028a-gpio', 'fsl,ls1043a-gpio', 'fsl,ls1088a-gpio', 'fsl,ls2080a-gpio']

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 4 ++--
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 8 ++++----
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 2e1cddc11bf47..1b6ab9550cce9 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -407,7 +407,7 @@ duart1: serial@21c0600 {
 		};
 
 		gpio0: gpio@2300000 {
-			compatible = "fsl,qoriq-gpio";
+			compatible = "fsl,ls1021a-gpio", "fsl,qoriq-gpio";
 			reg = <0x0 0x2300000 0x0 0x10000>;
 			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
@@ -417,7 +417,7 @@ gpio0: gpio@2300000 {
 		};
 
 		gpio1: gpio@2310000 {
-			compatible = "fsl,qoriq-gpio";
+			compatible = "fsl,ls1021a-gpio", "fsl,qoriq-gpio";
 			reg = <0x0 0x2310000 0x0 0x10000>;
 			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index f8c9489507e7a..524b44f424272 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -589,7 +589,7 @@ duart3: serial@21d0600 {
 		};
 
 		gpio0: gpio@2300000 {
-			compatible = "fsl,qoriq-gpio";
+			compatible = "fsl,ls1046a-gpio", "fsl,qoriq-gpio";
 			reg = <0x0 0x2300000 0x0 0x10000>;
 			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
@@ -599,7 +599,7 @@ gpio0: gpio@2300000 {
 		};
 
 		gpio1: gpio@2310000 {
-			compatible = "fsl,qoriq-gpio";
+			compatible = "fsl,ls1046a-gpio", "fsl,qoriq-gpio";
 			reg = <0x0 0x2310000 0x0 0x10000>;
 			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
@@ -609,7 +609,7 @@ gpio1: gpio@2310000 {
 		};
 
 		gpio2: gpio@2320000 {
-			compatible = "fsl,qoriq-gpio";
+			compatible = "fsl,ls1046a-gpio", "fsl,qoriq-gpio";
 			reg = <0x0 0x2320000 0x0 0x10000>;
 			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
@@ -619,7 +619,7 @@ gpio2: gpio@2320000 {
 		};
 
 		gpio3: gpio@2330000 {
-			compatible = "fsl,qoriq-gpio";
+			compatible = "fsl,ls1046a-gpio", "fsl,qoriq-gpio";
 			reg = <0x0 0x2330000 0x0 0x10000>;
 			interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 40159f58c6f94..da49f274e9d5a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -1027,7 +1027,7 @@ QORIQ_CLK_PLL_DIV(8)>,
 		};
 
 		gpio0: gpio@2300000 {
-			compatible = "fsl,qoriq-gpio";
+			compatible = "fsl,ls2080a-gpio", "fsl,qoriq-gpio";
 			reg = <0x0 0x2300000 0x0 0x10000>;
 			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
@@ -1038,7 +1038,7 @@ gpio0: gpio@2300000 {
 		};
 
 		gpio1: gpio@2310000 {
-			compatible = "fsl,qoriq-gpio";
+			compatible = "fsl,ls2080a-gpio", "fsl,qoriq-gpio";
 			reg = <0x0 0x2310000 0x0 0x10000>;
 			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
@@ -1049,7 +1049,7 @@ gpio1: gpio@2310000 {
 		};
 
 		gpio2: gpio@2320000 {
-			compatible = "fsl,qoriq-gpio";
+			compatible = "fsl,ls2080a-gpio", "fsl,qoriq-gpio";
 			reg = <0x0 0x2320000 0x0 0x10000>;
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
@@ -1060,7 +1060,7 @@ gpio2: gpio@2320000 {
 		};
 
 		gpio3: gpio@2330000 {
-			compatible = "fsl,qoriq-gpio";
+			compatible = "fsl,ls2080a-gpio", "fsl,qoriq-gpio";
 			reg = <0x0 0x2330000 0x0 0x10000>;
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
-- 
2.34.1


