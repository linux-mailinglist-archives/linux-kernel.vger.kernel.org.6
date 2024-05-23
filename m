Return-Path: <linux-kernel+bounces-187246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C6F8CCF01
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37A85B22350
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22C613D60E;
	Thu, 23 May 2024 09:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="gUQkLA1L"
Received: from SINPR02CU002.outbound.protection.outlook.com (mail-southeastasiaazon11011005.outbound.protection.outlook.com [52.101.133.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3908314B94D;
	Thu, 23 May 2024 09:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.133.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716455949; cv=fail; b=mA9h7Yg/BLyjPoBsCa9ifjdUHhHis/eXz7GLr7kx4UznGWInT2l99h2h6z2APE6eD0WDJcFJIntDZ5kfVZCBnGn9STJyyWP9pdJfmlIgD/Cz2vTZTdw2SQBK+NzLPWxKX049qgpVeIfno34SvLOC1QJqMhzDmW6hoOuRmx7vsJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716455949; c=relaxed/simple;
	bh=FReh6MBF7e+wsHlImkrS7+qksdnnHJVP3YlsJeVxPf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=epeRbDYfamMXaRM808NhzlDQ4Odl0H47QssOeEeNG1I/n7f0GLVSMAe0FHQ8eaCPtDVvvF3NGmEeesQQFP1b2aopqaR3sM562odG1Nohwkcq+jIgTrJXgBfN3QWNAom810SGGepL/sQOI4AR59HlN0AcI+nbXOX7dRPqZAgUJ8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=gUQkLA1L; arc=fail smtp.client-ip=52.101.133.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0HwiHhh1CujrV9zxeBBVp5ydmLhwKtHrnuMyWCqAuxDK09l4JytLoml3pS0KIZ2atW1Gxw+je/YMa3airc/6I+/zB0WMO8rv7hRiLUv7AmIcBzheF4bZvsa9MPs2gHcBioiopYFoLlW41I1E2pESHtZkuRbtdOjXqqLrBO2Dj5LWe4Ibgebgq+VRHzMktak1f4s0Kzu7CH5GCVee6tBXVxga9zjDFx7fFdLeYaksZn3V6FQVKMlqI+SRtE5tqs76k2u0FPR8i6AdPo3VCSCAg0eNsljnpqRHkfNHJAGAFoArOpUdvNoItVWInl4sO8TSqdDAxZhnKJkeWnJdM03NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrss1LFTszE1pis/nUOnfDY03qkapLfO8Yjsln0bIZ0=;
 b=SZ+yFDl6VG/ivjA3k4WtHKeKooI6VRlxkprSPJDjyf2ZcjefukTNu0Hge/Irj5qHtPANp7uRvJRspgIAnGAXSJ++8nRp2DZFodYOAoN48zN1aDXPNut3qvYhlioPCGe+Mk+RMaX384xHPjDtvbZk56/+6LQbKaiKOT3VFB0M3tFLQszbpZqlJRGHAr5AKIigLFeKAw/maLOtmGU+92y6v6euwkuyBKg7sPWT9qdshJItpqx9B0urdtobnDQp5itAWeUQHg2rR7ZKwfv1VjdohodldDw66I0fmtmUgu6xWVrb4oiOikeBTecO7vCngI0st7bJr1eo/MdND0uGMT+q/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrss1LFTszE1pis/nUOnfDY03qkapLfO8Yjsln0bIZ0=;
 b=gUQkLA1L9jI9azVgXPJveEI7mU4lbrCXfFfAv0nEHCBfWFALzxOr6fTa3cQS8tJSgwI5lCSDl55Qz/AjuYFyxmxC/916L5Ss44T+lzQiGiKn7Kn/w9escHrRTKzbB8HiZzVeUXeoX151b0NdztPaAH1caTkKOYZ64OhkN2r4ZnlM4kBkVExFg84l/92+lZmInkzbD4RQLNaP4G7D89lqyrOPpMbWUMrqACByXk7nxpOOW3BdG4D/XTzNQgk1E1bKTn6fL8el7GJcSpp/HonozAWQfz78H6OOvMKxPT3hWXRDHqd4kq2yEAfXMdKgeUugj36ea9AJsueibcB42RrS7g==
Received: from PS2PR03CA0008.apcprd03.prod.outlook.com (2603:1096:300:5b::20)
 by SEZPR04MB7987.apcprd04.prod.outlook.com (2603:1096:101:225::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 09:19:02 +0000
Received: from HK3PEPF0000021E.apcprd03.prod.outlook.com
 (2603:1096:300:5b:cafe::3b) by PS2PR03CA0008.outlook.office365.com
 (2603:1096:300:5b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Thu, 23 May 2024 09:19:02 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021E.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server id 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 09:19:02
 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 14/23] ARM: dts: aspeed: yosemite4: Revise ina233 config for yosemite4 schematic change
Date: Thu, 23 May 2024 17:18:01 +0800
Message-Id: <20240523091812.2032933-15-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240523091812.2032933-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240523091812.2032933-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021E:EE_|SEZPR04MB7987:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 91342f98-13fe-4132-c4e3-08dc7b0962d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|7416005|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KC72tsoLEuZgyYn9CMEsZH7XU9Q9IssbTDdJ1apI/arj0sXwse05bBG39Kfl?=
 =?us-ascii?Q?OBix+K1d/DeJsabxPG4lv0RA7Y1wZsUTs5fC4L/kWuRyaBlAca+tB0Sb2sJg?=
 =?us-ascii?Q?YFy/6aIkfN4ZkEV9Lq9RAJKYI7//hnzaJ2QwuwXaCdQ1B1wno5jLgCrkwpsM?=
 =?us-ascii?Q?ewkdBw8to3GHp48vJQw2cseQY4bTFvcCZz4u1ildsDCqSnJeWGCjY1SUigPr?=
 =?us-ascii?Q?AFIwC9Ac6MLSw869Hv4438cZexm/0msoKVPaXQgsb/VL+3G2jolvra1Ifkcm?=
 =?us-ascii?Q?5FbnY7Bpl0UooTK6mA5M2dCX585qjMU48+GHZfhCITPN3YObThaUM69PVyI5?=
 =?us-ascii?Q?mNh5FH9HnOmF9xeu/C+5KntydirPbhI7ZITOSF/dNz+d8P59tRq30sVm0eND?=
 =?us-ascii?Q?WftLqoAp7UwUokgI6S5UjHakO6dXm6L0ZC3v8vyYb+xWKCj71RN0HQa4Mif/?=
 =?us-ascii?Q?BU5e2oIZEMIzrCUy4CK3IENIeN1mJyEL95hN+QpOiL6p6NUibyUVONNUBdgA?=
 =?us-ascii?Q?RMdsuVeAUXcdvnuUw7k4wYaCWSjy8cffG/v2w1uQcb1hWjoBfdAsKEIqY3Mz?=
 =?us-ascii?Q?vSbu55MeAlsYnIx5wb10IxL+dUjmzPObgxje8QAUwCtQddjUknV9UJIAd0cv?=
 =?us-ascii?Q?sshs37vmrIbkImhCZgH0A8PcOQg19Jeba+hA+gKBuH9uPZzw5b6P7MyyYFTM?=
 =?us-ascii?Q?qM+AUp+N7Ei3dNozdaZ5vCMvF5cZj1sSgL3lCGtlbjakRHW7KQkUMJ7mLiS+?=
 =?us-ascii?Q?1/EOGITQWvjsUBiSll+qjrnFIgMcMczHSg0QpOL0RKkKrViTdEC81pp91RtJ?=
 =?us-ascii?Q?bgOBcJOJa4Bpq8wIIsOd2i0nLP9ejeXpqHpcIcENDcSKEptwYiw5lzd97bSL?=
 =?us-ascii?Q?EucYuYm8wLyT5hu2yp9Q3BJQKD0lBcvQCn5f6k/rh8YOar2SBEfmFxfd05vJ?=
 =?us-ascii?Q?JVUu+7k5pbWMQzLjRyZfdr2dgge/i4/jIyuW/NlcRSjEZczCskAt0WEITGk4?=
 =?us-ascii?Q?qvVp4uPb+VU/1HjytgdTMNFvcrTjPir6rqxgXaXyQkcZiJ69yo6+WU/JamcC?=
 =?us-ascii?Q?GY2qPtKzN5ZLMaWJPEAT1D+NcwY66KBbqxY5piCNiGYw/T8ePYC6X0vMtfpK?=
 =?us-ascii?Q?/AfPQdgY8kz3wFGpltZ20I5BhkBFaLxPS56WLq7GU8qw63MX6ObzEMpTr5kl?=
 =?us-ascii?Q?xgoSi8NCeGKI9/jmLqG9cJwZ+ip1XSgF7I72ZPlvtPxavH5qPrlaGOEJi7nH?=
 =?us-ascii?Q?MmCT1VaSGCTaqVZ/CYXR/c17YnzzmA/fhPXw2NNlL9ly46ahZT+sikgBpGpi?=
 =?us-ascii?Q?/qb0QvjaojaTPgb49u0/sUivZqFeGF0sWGnSyaC8RQvJavIKiOBt+jYqAwF9?=
 =?us-ascii?Q?t0ND4Kw=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(7416005)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 09:19:02.0482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91342f98-13fe-4132-c4e3-08dc7b0962d2
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021E.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB7987

Revise ina233 config for yosemite4 schematic change

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 20 ++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 0c7d85ff4360..67e3c787d675 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1034,28 +1034,38 @@ adc@37 {
 	};
 
 	power-sensor@40 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x40>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@41 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x41>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@42 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x42>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@43 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x43>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@44 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x44>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	temperature-sensor@4e {
-- 
2.25.1


