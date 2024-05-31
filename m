Return-Path: <linux-kernel+bounces-197538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E418D6BF1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 23:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FDF31F2A6A9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A1612F5B8;
	Fri, 31 May 2024 21:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bi8YGMlQ"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2057.outbound.protection.outlook.com [40.107.7.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198B2823DF;
	Fri, 31 May 2024 21:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717192247; cv=fail; b=MaQOr7o5qcs9nRDLdtQsXQdc/sb8UCfeGxjWNqqvC03VpzFmD60Cqc/76gVBfzKTwWK70lkjheQ9j54vzwHYwJy6NuqwjTkIPk9fW5iJKksxWKN80WUc2HfnQE+uTi+LdRL8sVR21Ml7FklI+woulNabL7Za8LY1CdAXr4W3sMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717192247; c=relaxed/simple;
	bh=3fP8hn2xf4jIyEX5zKjgCjZUBcNCynjfJlgkl+FujUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kGAMLjZCZvYCmQoWQIze+YfgX7eFZzt2HvjqGmqo4Q4M0yyRfszPZQ5BlKeaLlf53sm1W6iB4M92FOJKUpHk852RRdHKS/bz683Xf75WKtCc+rfuQakPup9MuDXu3O2FjX1teOcHnYPA7OVvQ6D9GxjfYOe2hG8amdP+jni8N6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=bi8YGMlQ; arc=fail smtp.client-ip=40.107.7.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGxp1CHRZ846nUbVjuvcfLl/dNqrNAimfXlPf8GZgV1ODHRWeRBqGxakWJphQMX+oMOISpom4EAZHJDz0DjV6fUgkQb3ltfqmWbMMuKk4s+bR9d40guXCwZkoljGV8+7vrDvbsJMlncXA7+Ns/1uGW/Zz9Y3beuMM3paw1xFsRlUmeZ9RcDAlGC1yw3mXe0vquPNmaZ9jtmwulC8D4GfZTPYxDTW18jbaHS6Pi7FBbFqEWDzn06rvVmCLifbTNfWGmZYZEtq5SP9B9oZMyKDkzy0W7ziaTQ10q2a73jOMVNx06wT6jj2uJPZgLAG6OyQAw1oZkbGqbtS5Ki+7LSJYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QuBmYtDoGcI1gnlQp3BdgLBFjUfQYFHWmxE+sDTfc0k=;
 b=EqYOS7sCnSZhrAQ9TodVeb++VABYnd3+wvHrMLYmaRznPfaoWW8N/EcTxMl6Yscz/0qk1ufIQ5MNc5wBwV9Z6meqNi3qlCXVv7Shu5MyT7GtXV7ZzaNTKhrrQS2yjns1JX5bQxPSh4Xlu+Kn669SerCpJKKZjiUdTvTInteMafEmwxwLmrBVnnxgWaE93ENFQr9Yfh45wQsIypMCSjkmJwYlrux0jjkwBFjNgBsJFqwnSLzPyO1cSsAlTz65z8Jf3S0KAdEXLvdVZF241jqTyKNx291Y4VHgSgkrFj2j8oO57hC+dcFeotow7mpwoXhVO/ebm3NexHzFi80geCJnsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuBmYtDoGcI1gnlQp3BdgLBFjUfQYFHWmxE+sDTfc0k=;
 b=bi8YGMlQLzWNI8AGjCX3yVJBjgZezKTlMh56wd1Lp0VSo5+O59UzbDfcK8Yj/AVGnlFxGUbgojybMjP+9HMiVS1fFMXpl5rOzSH3rPRaqe1nw5Z2XaRHSD2DAb4RXs2OUdP+7xKgRmi68G6EiSV5F8r3pcb9cK2rJT0V5Az4cbc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10748.eurprd04.prod.outlook.com (2603:10a6:102:485::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 31 May
 2024 21:50:42 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 21:50:42 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com,
	shawnguo@kernel.org
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org
Subject: [PATCH 4/4] arm64: dts: ls2160a: Change I2C clock name to ipg to fix DTB_CHECK warning
Date: Fri, 31 May 2024 17:50:17 -0400
Message-Id: <20240531215017.1969431-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531215017.1969431-1-Frank.Li@nxp.com>
References: <20240531215017.1969431-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0036.prod.exchangelabs.com (2603:10b6:a02:80::49)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10748:EE_
X-MS-Office365-Filtering-Correlation-Id: 1299fce2-5d6d-4743-45f7-08dc81bbb7c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|376005|366007|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3Gl8B5PvH1CNbFaMLz9luY4NsxpjnKhGe5MRjwIJqICGZ4q4uBR/2Am1WFmV?=
 =?us-ascii?Q?CWdD6z1dua/Tb+ynnSDKEAB6wtHTMgfSXz8MVM6nj3ljp0GsTe4BulHAzoas?=
 =?us-ascii?Q?hLGnA/yxz1JBy62gO0Fj/u6zPOWbB5rZ+eGnttC1d+EfzJrA5+KZDIi0Z+au?=
 =?us-ascii?Q?prLQET7JwwFpY4hEKeYwMOuTgHdsqxeh5BBqKvAEOCUXp08XOj5E7nzxVhQq?=
 =?us-ascii?Q?ekx82k/ftBx8UBFMdqbwYrG/wvN+Rq+0vdsymdslI6lG7Pqcht9lSEFV2fj1?=
 =?us-ascii?Q?xwPEAA4R8Jb8aUmRu4VMiYp+T25i+ptGcab0ykTwfidUJJYsnK9Nns8eSfhv?=
 =?us-ascii?Q?rlxk3x2/gJKCBtpfqP/ggaX4cvFsOF5pk9gBPODCnISq085FYbTbvn/UZiON?=
 =?us-ascii?Q?1BvOMb48Nmp9+6cD190X63nB9tfexaWdPyBw3hUQEcIuGnLELzlMcwHiQdLt?=
 =?us-ascii?Q?JDtC6/0BJqxMfttvZc8N0VDB72FU2pOAyeMR9y8oKeYYuoLwGHyPzUalC+Vw?=
 =?us-ascii?Q?WylPWae7A62THfyw9Sx5yD+GSwngNlfUyWOxa4nEHx2M8twucq1Mhiq84pFv?=
 =?us-ascii?Q?iQ0L475KCskjMuwcCtYy/QsL5/z5R84ByY5ecKjTtJu25CtcsLTm5m9oO+66?=
 =?us-ascii?Q?zV+RVrExBA+RnreA+8L0xvTZfDeyaH92s/hfpzOobBLyxU9jcQvO/QwEenTL?=
 =?us-ascii?Q?SrL/CouO4ntFjeShE29bHyBkDPuOOVyFSMR6iJchR+aJgIuHndEdzqvCA7NP?=
 =?us-ascii?Q?XsQVeNpP6j6ao5eEKhBcruP5xXifhwSaXzAoHQRSTPFqygU9qkcybqXHziyk?=
 =?us-ascii?Q?MAZgjX8ztrDlHApc5U6fiwMytVBu4uQYPOmJXiUbPQkgxw8qvwzp1VdHsQg4?=
 =?us-ascii?Q?ZHK9KTjtCpJl1b/SAi/ffwJXOI4Z4vxVFxs5rAVq65rhZMZGaK1szDTjcRve?=
 =?us-ascii?Q?8aVDa6cNrpkN0LwfN7VgJOugeM6eBn1GWuaPH88FdcwJzuPUKsbBuoR9p2Zt?=
 =?us-ascii?Q?zWA23s4jey4koj/y1oDQ4WH0vtyW4aAhXIrorNItMzaMcTkdcroH293Eydf7?=
 =?us-ascii?Q?tVqNYW4PC7fCwkoRFKwULClT/j/tp75XdpFAAxcOXB8QeK6BaV7iAsepkLEr?=
 =?us-ascii?Q?3kDm0ufQC0xo+K+Xz3hwFoEeOhzM6C/L7tYT53fB1tUerWMVF/iXkB98ZiVe?=
 =?us-ascii?Q?RLoiROH7cOfDt0GuWyBCPAldIN6ySNeOx+8sMinFVAZ5wW510t9IB4LSsdTV?=
 =?us-ascii?Q?kr1FnAyHoonB2v/D0zZeYvvC/woZB6njzcyohKq/zA4VwGUsb5MVlle8ogrg?=
 =?us-ascii?Q?RUlWsBx9ZHwTqpsXWe3ifU8mmaTI5XyvJQcVRZWpTjrMAA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OB7uj5YaSh8EPs7VQQnkbZtMHVfh/4MLK0VWI0C1hzdLeqoFJVZqrnrmal3S?=
 =?us-ascii?Q?SL8MsyAUSyt+zRzrCRfMNvZ+l/xh/ZxDe6Jd8Ppe1w/7FBr/QQJabFSAmO12?=
 =?us-ascii?Q?evxC1TNLvXJuSkv5S3wI/iYjY7hQNvP5DQl/SEfcziNROBDHq8UbTjk0eF+K?=
 =?us-ascii?Q?QEBbMVjyzUeGc+8p2NSIoJ1myNOQMhgbf+w+7NOaH+xsGHGUDy1rzQD2XuIc?=
 =?us-ascii?Q?IyrXo3v6sazOPv3mx5rz2dHWdXwNH7VGH9t77/SKqbsneToLf7LMuQd/QLty?=
 =?us-ascii?Q?x1HWjJ8JsQ9P3wKSyoMcDhWtNP98efks6bulIhCr6M/Y2YWpWf6SzKa7myj0?=
 =?us-ascii?Q?kRy/dLWS3ua7NdeA3uVCbGFwNtYh/OVzT8l0u6xOAA580qgGlCAWbVC3sj0b?=
 =?us-ascii?Q?2Z9Ysbps4Oz8d2v/mbMTzl0Pe45QwE7tbTasbFWk//FBuOFFVsLCeqbcGnNQ?=
 =?us-ascii?Q?M78fff1U8CmH4Zj7SDnWPbiK0yynYqG1CBNELojNI+ht5NF8+AX2uYrkiVSW?=
 =?us-ascii?Q?8IUtpdL0y0TveHu9IiWfIg8kDLJpnqciwJc/i3X0uhbQi05QkwZN4GWoB5gu?=
 =?us-ascii?Q?Gm5JbKwp6m+JIG+kZ9BbXTySXHSAAa+T1ifoysoD3duXPEyQsklqryBZU5CV?=
 =?us-ascii?Q?xONC7vLlDMSt2tv/81sZ3Y4myFOt19SsvebsRMIottmE81UqJnJBkoi+jfKS?=
 =?us-ascii?Q?pvY8LTypale1Z6vSqkHT37R/GmsnJF+Dr9/hKPsc0JDuXQIKQLl36Dh+KCaD?=
 =?us-ascii?Q?MHvLKAZUnWVvseCZz6FsOt6nGFHcnD6FUjOFFy/uiIcEx/JhxYkUc7eN/lmp?=
 =?us-ascii?Q?8MRiBRKzAZkE22wH5lGzxtslV0DNHbCKHnmtzVXJJJmZ5YWUfn51jG0n7RQP?=
 =?us-ascii?Q?je55M7tiQeZ9FhzQ7nGCT3JFhDOUUVq2zpOe7XVCDMVzQpckZFL1YGV1S4WX?=
 =?us-ascii?Q?BqCdHtWfIziPtZ4VkLxVTZLJWXyM8MawEd8SLDNOiSeyYXeVEIrh65IpSzi5?=
 =?us-ascii?Q?/34hxi9ie55iPY89WSWEJnlyLSH9oGMTAYk/5DIopiV0vBmTfe0ls3oN/FeT?=
 =?us-ascii?Q?gAYBhG9jRp3JGCRRHuwDM8BrEBhHMiKvRTDah4Smh1QrhFDy2fNUv5lXL7oT?=
 =?us-ascii?Q?H8RRDNQ6iDyayBq2p05627FRKQT7odhDWV+xXDKRQQLKqZp1UqEK7fgaT9zf?=
 =?us-ascii?Q?SY37yTEZ2TWd+I4AqR2LDylXJXcigyDsz/i0UWz6JEF82xgJHCTPkr8ij5Nx?=
 =?us-ascii?Q?BrNdV4PhxfFGP/rb14f2mmLZKG9oRqmND7rjRYJr0q1jpWS0Cizwsss23uUE?=
 =?us-ascii?Q?DyqTbAfPeJ302337WHhKmATItX5mehz+YiWkHRyzyoNdN9m34owQa78IIECI?=
 =?us-ascii?Q?6eBuRZ4v5PFiWET+6+SJ1Gz+Qg4CluIPSbwU+K9CXOshbVevDGg88Cr6i4jz?=
 =?us-ascii?Q?kWcR2klCu08RGUQf+ilQB7jyJzdue+uJfdgPjtDEhRTH5fYS77Hxs/U3Tkmq?=
 =?us-ascii?Q?VF5RYaBqsD4NkhtHGgnNK2MVbCoOT8c1mYhBGUGWX5JduKvzYlUB6EuwpH94?=
 =?us-ascii?Q?nhZuhIh6KVu7dpiFyVx+UIdXE9kGaUL2VYxhAP3z?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1299fce2-5d6d-4743-45f7-08dc81bbb7c1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 21:50:42.2689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RlrA98ImN6jMuTthuRzbWVAmLyAxylC5agE89aqXAn//8pGv15XXo1xllkov4M5ReK952DFJNbPDTam5yKlcxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10748

dt_binding require I2C's clock name is "ipg". Change it to "ipg" from "i2c"
to fix below DTB_CHECK warning.
arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dtb: i2c@2010000: clock-names:0: 'ipg' was expected

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 96055593204ab..7dc98cb0ffc93 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -745,7 +745,7 @@ i2c0: i2c@2000000 {
 			#size-cells = <0>;
 			reg = <0x0 0x2000000 0x0 0x10000>;
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
-			clock-names = "i2c";
+			clock-names = "ipg";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(16)>;
 			pinctrl-names = "default", "gpio";
@@ -761,7 +761,7 @@ i2c1: i2c@2010000 {
 			#size-cells = <0>;
 			reg = <0x0 0x2010000 0x0 0x10000>;
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
-			clock-names = "i2c";
+			clock-names = "ipg";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(16)>;
 			pinctrl-names = "default", "gpio";
@@ -777,7 +777,7 @@ i2c2: i2c@2020000 {
 			#size-cells = <0>;
 			reg = <0x0 0x2020000 0x0 0x10000>;
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
-			clock-names = "i2c";
+			clock-names = "ipg";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(16)>;
 			pinctrl-names = "default", "gpio";
@@ -793,7 +793,7 @@ i2c3: i2c@2030000 {
 			#size-cells = <0>;
 			reg = <0x0 0x2030000 0x0 0x10000>;
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
-			clock-names = "i2c";
+			clock-names = "ipg";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(16)>;
 			pinctrl-names = "default", "gpio";
@@ -809,7 +809,7 @@ i2c4: i2c@2040000 {
 			#size-cells = <0>;
 			reg = <0x0 0x2040000 0x0 0x10000>;
 			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
-			clock-names = "i2c";
+			clock-names = "ipg";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(16)>;
 			pinctrl-names = "default", "gpio";
@@ -825,7 +825,7 @@ i2c5: i2c@2050000 {
 			#size-cells = <0>;
 			reg = <0x0 0x2050000 0x0 0x10000>;
 			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
-			clock-names = "i2c";
+			clock-names = "ipg";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(16)>;
 			pinctrl-names = "default", "gpio";
@@ -841,7 +841,7 @@ i2c6: i2c@2060000 {
 			#size-cells = <0>;
 			reg = <0x0 0x2060000 0x0 0x10000>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
-			clock-names = "i2c";
+			clock-names = "ipg";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(16)>;
 			pinctrl-names = "default", "gpio";
@@ -857,7 +857,7 @@ i2c7: i2c@2070000 {
 			#size-cells = <0>;
 			reg = <0x0 0x2070000 0x0 0x10000>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
-			clock-names = "i2c";
+			clock-names = "ipg";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(16)>;
 			pinctrl-names = "default", "gpio";
-- 
2.34.1


