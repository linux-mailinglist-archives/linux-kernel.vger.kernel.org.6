Return-Path: <linux-kernel+bounces-231464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD9991990C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF8401F22BDB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5681946B3;
	Wed, 26 Jun 2024 20:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Qnz7c/rZ"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2041.outbound.protection.outlook.com [40.107.249.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A278A1946AC;
	Wed, 26 Jun 2024 20:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719433576; cv=fail; b=bB3vzhvIcfzpaILNXckXBRoIPT+hVhbDv6tChG34V0JiblDcGNhDjfVLAOWL0Z/GQi5Kd5kGzlFjB/lqVVp4yRDaXu1LaiS9udnsB/ikFS/EJ7jon2PVQwImbyNs64gkvsap1lLbkxPEBA1cfct12OvIpv1XvPh+UYsbvLzNbSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719433576; c=relaxed/simple;
	bh=NMhjrqpVzmYlgSOVA2PRX43G/RlSh1VdJJaQOC1vS+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Aexv9ijh9UEzke3kXyKbq4PPQcJDZv+0nIhaqINVkAROGNOPHOP0FG5IJYgpJKOM9o1QvT2IAzQHTwSdFK7hTTFUc7OW1Pa2Yr4zLqRpPHUJiriQumNXjvpIMAqO/TRP/Za60dacS4VrCiYn2rwg/7LYaK/DHLFq0dHJA/2H+/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Qnz7c/rZ; arc=fail smtp.client-ip=40.107.249.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9NUdAmhNLwUATPEXvdWw8oWYuRxdXJ9OgjVDdwErn7+PigAnyQg93nSImAzh+DzJdHqci9MqB8sS6+0VgdK4H6b3ej9aDksqW+G/1R/3hYTHhlnADmfLn4rievMZ+YKkxF9ajyWpF/8medig6vqGegPsM5JCZUvtL/qreNHY+WvmY15QzrIY0fTvDuS9PjZJjzN6ru+ArVlgGmsmGQ4b37wpmemaRSp2wPZMrKW6U+7HIJJ36L4A4/+8Ru8++PUUZXXaGbwKpWH/RjoM7/W/NxntzytuBQCDXXEeucYl3VXtuWPV/PUCfT1wWDB1O+zmVYvvD2TUBR+f9wGHdXCjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfBwtOS0d62KiCvCcUgM8CMLvM7VdgkJAkwetdescA0=;
 b=GLs8kcCzGwJ6YqaPOC+ktcczsCWkLFdGqz2WXZbX1R1GD3kvnBsOk4iBSOuK5JmE3StYjccqBB3RFexvDfgPtLfeszzgcFUpZXnpvP5kpwIT8zFU/u8+IS8iUzOLYRRd8PMbIRl+u937NcPYA8W65dfQ2C9aVjyu1MnkSDD+ldz2qKmUnKpI8KVejFUE9lr9Sm1TSFBUh2khYP4PG0eXP+oPfRp0u8qU6nLxJh0NFb9pyJLPG0s7QVXf8FUE3DpGHTglbc1qFS4iS5uQwNF9iZawVeN4ho+Cn6Ye+YRJZ3eTYNcbGC0GJvtJ+6rhOH1f38N/mXxg1UQs87gEeBf9pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfBwtOS0d62KiCvCcUgM8CMLvM7VdgkJAkwetdescA0=;
 b=Qnz7c/rZiZPNhm2atOatOk8nGN7op4BJP+6p4v9Xh4Is7o+3CLXCaUpw5ZTTObM42LHxeDe4z8mdqNIrCQAwg/CgjFZAKQXiEHeEh4d+OnYeQVi+SbIWK9jRMKEyc/cbuFZzeXZtKZlYEzmG9PMHYC+N2xeBVWWM1oGVp1FJaO4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10838.eurprd04.prod.outlook.com (2603:10a6:10:581::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.25; Wed, 26 Jun
 2024 20:26:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 20:26:13 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 08/13] arm64: dts: layerscape: rename node name "wdt" to "watchdog"
Date: Wed, 26 Jun 2024 16:25:28 -0400
Message-Id: <20240626202533.2182846-9-Frank.Li@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10838:EE_
X-MS-Office365-Filtering-Correlation-Id: d0232456-0947-4ddb-c191-08dc961e3910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|366014|52116012|376012|1800799022|38350700012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LC6unZTHYvti9xVE7PqJ6BhDo5++ZcmCWHCI1Ucbo3QhLhZdUV2U8U87XwPF?=
 =?us-ascii?Q?D+FWLg4v6BoPplIyd0O+qhaRD+TsgqPxKlGawgMdIHc8gdrYA4wMlQt5kK1k?=
 =?us-ascii?Q?kEcIihIwmClgMiTiOduVHUEND7caCR65SOAE+EaPXIWU//n4QVAE7NLJmFGQ?=
 =?us-ascii?Q?H+TOy22so4YTzQtXWqpMIArhZWsG/chHwfGRR8kZ9WeO3Z4FYWhNEtVbqvmO?=
 =?us-ascii?Q?DQxcbdwlrww0iJAiBzfreB52zOeYQ3lhgUffgMmOw0r01GATjrV57Uq1+if9?=
 =?us-ascii?Q?33hwVYrnInnkv9Amx1nLO6ck8cRInk0eCiWxbWtMGCKS2KazY2VCn++fQ+2z?=
 =?us-ascii?Q?mOxd812RvPRaKAU1P8X9+i2xGNuhzCiyCwbUsbB+rCtQkPo3Yw+gEWDBvZZG?=
 =?us-ascii?Q?RF01cNuR0qJW6UzyYLZ1gctmO+CjnYCYXdY2bkTrhEyxJUOd3T7mVsZtwtkb?=
 =?us-ascii?Q?3JVyc9m6y9Kpc3rJQZhETHHIB4KB3ytZd+BCBKKoV/SdosubgbzHOq7SZs1x?=
 =?us-ascii?Q?EGxrJufNU56bmywPy7TGFOpWLhaspspzFGbMQxx0k8ffLNRRAvfjukDDTe4h?=
 =?us-ascii?Q?mZOtRSoPOIRtfsidMH+EM2TcAEFTH1XsynPftMV43y0RKOpBnTHErEB913ry?=
 =?us-ascii?Q?3D0U54Z62NoKcvpgDqWXTArbB59LvXxK98bx2gUg0ox+oJmnT69gTsNzMl6s?=
 =?us-ascii?Q?vQmC31GGGbPCO36delHYy5TdcRTF4+o+IKILr2GM0tPNKDm2OWwbBMEXE0JM?=
 =?us-ascii?Q?8TN//gmyLHSxQCxlvf5ocYAqQS59o4jjhaq91r+gG1WJE6yF4w/kwiiu5bSa?=
 =?us-ascii?Q?AdM7KR1KymW2kXmKaiOKY8aeSkrswIbi7f57nEOCVXlmRlI/7QnmAMqQe8Wi?=
 =?us-ascii?Q?JE7QkteL3JRBqV6JP3obBlTNon07gpEQUi7bevxrmEsevYotHMf7n1VNSJDj?=
 =?us-ascii?Q?2FFVHFfpmorAF7sUPIC1vC4VuTNHqScgFSeY30un7STyJ3Fxzdu0pfi2rDaj?=
 =?us-ascii?Q?3g3VLTV0cIe7jN5OMKCUguYGwxpRm6IoVbRUaYA9bhuVAWamoblFlwT3UZZY?=
 =?us-ascii?Q?UndNJzDeRjuAOtMsY0fn5m2BquEhkboS6IyptngSx6LUcfDN+OEDXUTVGGUK?=
 =?us-ascii?Q?mZLOEVd7Ba49jidzaWszNsUChj88XCD4N2+5k/Q/pfUBwY9A/xZYS54XHfPc?=
 =?us-ascii?Q?dV4Q4SBFV2AMD4gmADmJ3XOgUsO3dt8mSmz+N5IyMhcucle+Z56mgrcU/mZx?=
 =?us-ascii?Q?LAhr2sgUA/L1s4uLOYgEeuCZ4Gqa7B14aXAUGLtAexMjyZFV0G8a3zLSaecx?=
 =?us-ascii?Q?yECvmyUKyCMUbZpFv6RlN2G2r17LVd4YuNntgBZkRKdu/txmdcEjcb2T/EX/?=
 =?us-ascii?Q?OfOhaLI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(52116012)(376012)(1800799022)(38350700012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zK2P1gwEz9F0hrLOOJnv/HP4sOyHDorHglK3Ld13PLpXHPW1/KWfUTje5thR?=
 =?us-ascii?Q?Y26Tdoz5VK+l7eBceXTTAnUlxR7WJ70IOnYyHph71HVppP0wBWCGRW+kKRyB?=
 =?us-ascii?Q?z8P2ms3wAWsJZjvYru5ENnxUMqAqVPpqOPeGbRuTpJPepaNKUdsvL7GBD6RL?=
 =?us-ascii?Q?I4AgnoiuTIqaaVOIvO07jI70Y94gs4YgqVrQRumgQxr96n2UxI8RdJ+DQqyf?=
 =?us-ascii?Q?2qOWumYrB58kLMbQt3xcNoQPxoyzv4WY9QfAiT92Z35h9/dx+80n17dzO+Hg?=
 =?us-ascii?Q?JFkR8wGIGbVbrKSo+2ujGRTaIKAdN8yYzyx8tzlw+zBWjZqouN6dBp6fPOPh?=
 =?us-ascii?Q?HMOM0sDoL2IqZ6NtjElQXPPOZFsmTmj7LLbHxoKx/HwtESNe3Z5W/BP87Esd?=
 =?us-ascii?Q?sq0I446kN4XwuFA9minE+P5VHr81WXQEZrnQZCpFwuybnxsQ0wbkj3mwX0dj?=
 =?us-ascii?Q?JVN9zaKflEMEpzWqLbUOXl6Z3Sd3VazU2N/yYYLYm+AXHbV4m1hijmSP4Rtc?=
 =?us-ascii?Q?DOAC9MhMX5e7ZYY1UBx9VUwMm/qoR4s7i0NdmmKsbV9MTw7xdfvEe8F5zMwW?=
 =?us-ascii?Q?g72xDB2BFkNIuYgoEcU9ONs55ReUjxVG/Z1WKQ/9Z7p/biTy+rbu/fI9NOiP?=
 =?us-ascii?Q?vge8PZZcfbcZAGUVIvdO9MSkbjRRa+khqYJE7hsWZj+jQfoczlYQz0pnhgee?=
 =?us-ascii?Q?tJVVuuhtviIOwRrFe7V+NJ7n90wOXbTS223ccaMhBpWotcAXH04IOoExLrC8?=
 =?us-ascii?Q?tUZp4PUJh7imynIZkmcAHLIIgcCe9sZ+m8X7K79Vy1mFRYMKXX8aOkVuEXsK?=
 =?us-ascii?Q?vbr2g79N1EfPCXOQsqvgNLgqT6Oq0HwQZJyj561qJrP2czUo2oK2YWyAyJrs?=
 =?us-ascii?Q?CAhXZpLSIN6wSVXdh9wSoZZgkbdcRS1GXS7fgmgVUesB+i7Q7aajAj2JDJFY?=
 =?us-ascii?Q?y1ybkiVhAbxHbhw3UWYBu7zwXfj7oXMH5ZsizTS2MIgJKRdAWFj7+qoXVe0D?=
 =?us-ascii?Q?0pR4fJuUwahf/8ySDKLNQs3VZGvn4YBjhvmGiKPpZUfyBwEhdxre3sVMVjhk?=
 =?us-ascii?Q?iZb/v/9I9uB1IGh3MIuDIyE1Cn2+FkSJ0mRQ3r1AvZSAL+rsJ+QRHqp0LITZ?=
 =?us-ascii?Q?FY0Zw9etFHKclx2EzuVnkrWSVIMx9y+h1v0ja/UNeLoVEmfk+UDxDMQXt/Zc?=
 =?us-ascii?Q?QpRGaCm5mzbx322gPSrmsP5aIHtJBHwc5YoWAXufyyZ7H1iHaDEaXKHBxIgj?=
 =?us-ascii?Q?PF2B80y6/UZvo1EegnGbU/6SkoyGI+QTX/vKArtkqLG9jlbh+6lAZiorbwr7?=
 =?us-ascii?Q?T3iW3BcrSFx42JUVeEVJXCC9K3xS6Cc9/IlZsO61NYDzrGk7pDzPZ8s6MQhh?=
 =?us-ascii?Q?+DXXEjVhH7fAeDe47VnidcgJ69aXGccoOxl8NzjeclMYovGmApoYLyeJZPDC?=
 =?us-ascii?Q?C93nmk2ogMZOkDjuuDZ+9X5rQrFkFgp+/zOnvkm725v1Fb/mIxrt1yIJyAX4?=
 =?us-ascii?Q?QJv6TDJmL5cVEDCHCJu8DbDPbg6Whf5EnYywZ+0gFzjNpu7eFXwte+M0bVPe?=
 =?us-ascii?Q?j6gTtnyzPOR/4Q/z/nQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0232456-0947-4ddb-c191-08dc961e3910
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 20:26:13.1588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GXu3iFaYxly5A31an4mMJYqNfWUNQLzKcbI9DOdAHZ8yVdcmxxyW2puWgf8s+oR3gVR41xKlc2dQxzTP54EY6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10838

Rename node name "wdt" to "watchdog" to fix below warning:

arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dtb:
wdt@c000000: $nodename:0: 'wdt@c000000' does not match '^(timer|watchdog)(@.*|-([0-9]|[1-9][0-9]+))?$

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 16 ++++++++--------
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 16 ++++++++--------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 81b80b6b27d31..83236428e4cfd 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -880,7 +880,7 @@ pcs7_3: ethernet-phy@3 {
 			};
 		};
 
-		cluster1_core0_watchdog: wdt@c000000 {
+		cluster1_core0_watchdog: watchdog@c000000 {
 			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc000000 0x0 0x1000>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
@@ -890,7 +890,7 @@ QORIQ_CLK_PLL_DIV(16)>,
 			clock-names = "wdog_clk", "apb_pclk";
 		};
 
-		cluster1_core1_watchdog: wdt@c010000 {
+		cluster1_core1_watchdog: watchdog@c010000 {
 			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc010000 0x0 0x1000>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
@@ -900,7 +900,7 @@ QORIQ_CLK_PLL_DIV(16)>,
 			clock-names = "wdog_clk", "apb_pclk";
 		};
 
-		cluster1_core2_watchdog: wdt@c020000 {
+		cluster1_core2_watchdog: watchdog@c020000 {
 			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc020000 0x0 0x1000>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
@@ -910,7 +910,7 @@ QORIQ_CLK_PLL_DIV(16)>,
 			clock-names = "wdog_clk", "apb_pclk";
 		};
 
-		cluster1_core3_watchdog: wdt@c030000 {
+		cluster1_core3_watchdog: watchdog@c030000 {
 			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc030000 0x0 0x1000>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
@@ -920,7 +920,7 @@ QORIQ_CLK_PLL_DIV(16)>,
 			clock-names = "wdog_clk", "apb_pclk";
 		};
 
-		cluster2_core0_watchdog: wdt@c100000 {
+		cluster2_core0_watchdog: watchdog@c100000 {
 			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc100000 0x0 0x1000>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
@@ -930,7 +930,7 @@ QORIQ_CLK_PLL_DIV(16)>,
 			clock-names = "wdog_clk", "apb_pclk";
 		};
 
-		cluster2_core1_watchdog: wdt@c110000 {
+		cluster2_core1_watchdog: watchdog@c110000 {
 			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc110000 0x0 0x1000>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
@@ -940,7 +940,7 @@ QORIQ_CLK_PLL_DIV(16)>,
 			clock-names = "wdog_clk", "apb_pclk";
 		};
 
-		cluster2_core2_watchdog: wdt@c120000 {
+		cluster2_core2_watchdog: watchdog@c120000 {
 			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc120000 0x0 0x1000>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
@@ -950,7 +950,7 @@ QORIQ_CLK_PLL_DIV(16)>,
 			clock-names = "wdog_clk", "apb_pclk";
 		};
 
-		cluster2_core3_watchdog: wdt@c130000 {
+		cluster2_core3_watchdog: watchdog@c130000 {
 			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc130000 0x0 0x1000>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index dac33a3eab841..fe4755c54af2e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -389,7 +389,7 @@ serial3: serial@21d0600 {
 			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		cluster1_core0_watchdog: wdt@c000000 {
+		cluster1_core0_watchdog: watchdog@c000000 {
 			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc000000 0x0 0x1000>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
@@ -399,7 +399,7 @@ QORIQ_CLK_PLL_DIV(4)>,
 			clock-names = "wdog_clk", "apb_pclk";
 		};
 
-		cluster1_core1_watchdog: wdt@c010000 {
+		cluster1_core1_watchdog: watchdog@c010000 {
 			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc010000 0x0 0x1000>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
@@ -409,7 +409,7 @@ QORIQ_CLK_PLL_DIV(4)>,
 			clock-names = "wdog_clk", "apb_pclk";
 		};
 
-		cluster2_core0_watchdog: wdt@c100000 {
+		cluster2_core0_watchdog: watchdog@c100000 {
 			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc100000 0x0 0x1000>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
@@ -419,7 +419,7 @@ QORIQ_CLK_PLL_DIV(4)>,
 			clock-names = "wdog_clk", "apb_pclk";
 		};
 
-		cluster2_core1_watchdog: wdt@c110000 {
+		cluster2_core1_watchdog: watchdog@c110000 {
 			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc110000 0x0 0x1000>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
@@ -429,7 +429,7 @@ QORIQ_CLK_PLL_DIV(4)>,
 			clock-names = "wdog_clk", "apb_pclk";
 		};
 
-		cluster3_core0_watchdog: wdt@c200000 {
+		cluster3_core0_watchdog: watchdog@c200000 {
 			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc200000 0x0 0x1000>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
@@ -439,7 +439,7 @@ QORIQ_CLK_PLL_DIV(4)>,
 			clock-names = "wdog_clk", "apb_pclk";
 		};
 
-		cluster3_core1_watchdog: wdt@c210000 {
+		cluster3_core1_watchdog: watchdog@c210000 {
 			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc210000 0x0 0x1000>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
@@ -449,7 +449,7 @@ QORIQ_CLK_PLL_DIV(4)>,
 			clock-names = "wdog_clk", "apb_pclk";
 		};
 
-		cluster4_core0_watchdog: wdt@c300000 {
+		cluster4_core0_watchdog: watchdog@c300000 {
 			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc300000 0x0 0x1000>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
@@ -459,7 +459,7 @@ QORIQ_CLK_PLL_DIV(4)>,
 			clock-names = "wdog_clk", "apb_pclk";
 		};
 
-		cluster4_core1_watchdog: wdt@c310000 {
+		cluster4_core1_watchdog: watchdog@c310000 {
 			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc310000 0x0 0x1000>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
-- 
2.34.1


