Return-Path: <linux-kernel+bounces-300817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA7095E8CB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A738A1F21F8D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B2483CC8;
	Mon, 26 Aug 2024 06:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="ki/GxjlE"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2057.outbound.protection.outlook.com [40.107.117.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097A51369AA;
	Mon, 26 Aug 2024 06:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653596; cv=fail; b=BHWdpDM8D5lGZiQ0aGhQtaqvTOHrduqO0m1Fhooeq/Xr2LWRmp+BEYt9ikgLHvNhTyyG3guCHRvbSq+cb4hTV/XUZevEqUeC5Sm4D3wBhP3n6VHe2b4IkXltFL0cgBQLIslytq3xmRPdnr3Vx2ITKZyjsKRPlyJlVZeHbwYCIJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653596; c=relaxed/simple;
	bh=n1VEhUcraB2L6lx1OzD6PjBTJW2T0K4J34nm/ZXFIVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0hdadRD4SowBdv8L6bbQuOYH7k3lkcZ71V739c+/QKABFALQjpGkmtQ1ySznYf8a93JXntDe3Bs7FmoTvfalNJa/4SHAjk6a7dL3cqHPEPLkmD9DjshZ6UfbxQfJ/JEPlxmpeSpHxHHLtFx+kU0qslpInqF9QZjjeNXl7yqZoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=ki/GxjlE; arc=fail smtp.client-ip=40.107.117.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GDZUnNuxesX51XzezsUMlviNnLrui1VWihog1lbczvgzulGGsQCjCWGp2A53AnyyJMMKTKfMECmDG8SQkOwi7xszXzJHBEF39366IQqFYbD73Lv0Vfm54avAsIAzY5ugyKBhG8yXcqzChgZF1QQkWZfPucW/tybhMaFQGNrRIHw0CzfEltF2O3syqBbyc/cirVPVgMeWa1z+ywbC2ku0Sj+mAoaDe/TjU9M9Od8eUr3zc8iyitLbG5RM0Rqifk2bLy4RYaCBDMrE30DShMQeDaD4I8EtJOU4Rx+kgaPxiviFMDcwi+cxGw/k4yoFs10aW6rXjoZw565PKafgWDofRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgT/6R4EC/XEEfY2gUrLR0f3dvDaYSzSpR2s+GBhOIk=;
 b=W9QWebBjZmOUasR8Evm+JsTgN10QSSnMQtiVaz3bz7AL63PiTE3RC5ZYxMFEJi3KQeXcMzj6h1om+idrnCu2cfWR5jRihJfo2ZeUmwzMp7e8CB0Mob2h/zvkMCEp4SB5aMJmgswLWJGCn6xxy6LbfGY58AcaMSXDAJvaQpHmInwqkxTVfMiHANveBJhEUELRa4UxMiJsbAKydfKdTDwflFptaadRWPMD2huNkwQxCxnAJHtzQy4zyL69MIyHe21z2V6JTauPnmcLNlPfKjo9FU6mMXxXGxRbH18sT3fZtvgy+HddDdabS4PuN8Kv5NsFTbWp7rlFzBaJhcuZjD2I0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgT/6R4EC/XEEfY2gUrLR0f3dvDaYSzSpR2s+GBhOIk=;
 b=ki/GxjlEQYa4/CeeBjBzWgPYQsnRGmdIjivgsjpyITB6/Q3twpGmUQUt357t3kFxl7E5eftAgRH/iaOBqxRFPZDyfbfnwXTBJ4ngYqpxlWRlSomHGZTjGTPK2w9CYN9yM3l9Hj4/PAmhTeFF/tTDL87B0h7EGdPBGTsqqzs7iuq/yEdLNzwcf9OBZwW8R5Wygy7p3GGkqjwWEjAe0/chNg5QBweqT+7wP8fJ0bA3d0WpW1YKWg3b4qnpvYkKz/ItEVqkL4PqCs66HyWUUy74Qb3c9SrJKc3XW958nx8hSA9NPBcoKIFY9pwtAi3o2dZAMaRMdBVJcfBHip7Gio6t4w==
Received: from PS1PR03CA0019.apcprd03.prod.outlook.com (2603:1096:803:3d::31)
 by PUZPR04MB6315.apcprd04.prod.outlook.com (2603:1096:301:fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 06:26:30 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:803:3d:cafe::19) by PS1PR03CA0019.outlook.office365.com
 (2603:1096:803:3d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14 via Frontend
 Transport; Mon, 26 Aug 2024 06:26:29 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server id 15.20.7918.13 via Frontend Transport; Mon, 26 Aug 2024 06:26:29
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
Subject: [PATCH v14 25/31] ARM: dts: aspeed: yosemite4: add RTQ6056 support
Date: Mon, 26 Aug 2024 14:23:59 +0800
Message-Id: <20240826062408.2885174-26-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240826062408.2885174-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240826062408.2885174-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|PUZPR04MB6315:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 79a28a51-41a6-4915-7882-08dcc5980556
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?263nL3vaaV2T4fyKGrucqLy6872OeICQ4h/75PuGiEPdvVX2qHjG1myPWf1g?=
 =?us-ascii?Q?AY1IVenpr71C3PHL69kMPON+9FSR9A+j7mQfVl8/iwDM9xf+mzviZY/zy1hK?=
 =?us-ascii?Q?AO+F70egMEMzO1eL+ezwegr9P/LLE+2L6Ip4eF7SxSrrdQRb/leUKj3bCbFf?=
 =?us-ascii?Q?7IiGeMsQSRhCCOoY5NP1gwpsrquo7gRgtTNnpO806Lhu68ajusni5EMUQuw9?=
 =?us-ascii?Q?1A5CTMfQQprC3CmALHLIrhx/UlaeN5muv7x4No3xJOVHGLr9gKqVoByp2b8i?=
 =?us-ascii?Q?5gOmaELxkTVaUZZznAtqs7SdSiGsRRhhooYaUsoui6AUTEOuxoSqErYf+GXW?=
 =?us-ascii?Q?7qCX/+5VI6dCCGMpo+UlM+0q4aAOn7MGdNdXe0XQ+ePsNNrgSku0gvI5vO4S?=
 =?us-ascii?Q?Kq/Oj2y6cE40Wk6vo7aROWxop8b1MQv+GLGVgykSJP6tEHRRu1ipe/TDHVGz?=
 =?us-ascii?Q?VHpg6bqlJkS1vyLjHvvQ7DfGu6SCkwD16zRM+fNmdIgqHNgV6FrYvzdwjJ8E?=
 =?us-ascii?Q?59FC0uZ0Y6vIwb2drqxOerHmaqAFcr+396/YpswpJRopORSeS3zxjLcXzUET?=
 =?us-ascii?Q?wdj2+1xWMONkragnJuROlZF3jUpO1blst+HQAoXaZt5kGeNQASwekTLqZEhB?=
 =?us-ascii?Q?QfFTgPXvNd91T8LbqtZ+ZZPMHEw1VfDXlnLQONdH9ohK4CfzHo6Sl6HX5ajN?=
 =?us-ascii?Q?C/j2qqZYZ3FZ544dwyr/NB/Uz/f3DRSSR4qMNFkXzV0gPX7GzdE4vybz4Yu7?=
 =?us-ascii?Q?nW+MLzAyDLABEfyVXYy2dSwHtknR1lH/Rx2AlNa6alePHlbj81dt/w9zYnEm?=
 =?us-ascii?Q?/bfV63iNV/psJCJCmWVdCLqI6CbaAtBA7mDCpe4yma0ZNZiLjzQxHC6gFE2+?=
 =?us-ascii?Q?8+tP6Z8w3tx4RdQfrQqZ3OSh/yEQ6gHfeew6Ld4nmSANTaRqc8vHIQ6FxBn5?=
 =?us-ascii?Q?AyIDUrg9lLWRUP21ssgNEvcvtQ2WgSZ9XAh/Q2pWJoeeHwPAJ9eHcbt8C0+y?=
 =?us-ascii?Q?KIQi8sq1jT8H0fQDI3skrzGQmIgOx0oJ0cc/3eMnKzSS3k4TDtaxeNWuygWP?=
 =?us-ascii?Q?wzs3XAE1ZQiGGgpl7AoABfpOJzhPyQlDarjNN326D8TnZp0oTdQy6e68PWeY?=
 =?us-ascii?Q?X10P90o0z4wVIhl8bP7bEUy/YsHhHHemG3hog4j4qAtPTfXkhJC4vj7KKa6n?=
 =?us-ascii?Q?ZLlhkahcIt/EL7hL4wq+JarmGaE02JEPmMM6N4Fpb/wT4ye7VfgDEHoIxpqX?=
 =?us-ascii?Q?Va+68H57OxgugUgtPcHmkFf4TC6bc92cPtObIuebGEzZ4Jb/S/Z/uap9qleM?=
 =?us-ascii?Q?gCYhEjURTlcsM9V+tYx3gIoQurB1Pnq8HKpSAjBCuRPeJjIvDQQYrXpzILLK?=
 =?us-ascii?Q?8FFdcLv1aNo2WLXoyhXPsIMFEVYhPFYUBYvuHR3ulGrTFzG/6itW7Y15q0ml?=
 =?us-ascii?Q?UcacQMvJvwXio7tA0+6hqAoX8J6Yrjxl?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 06:26:29.2834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a28a51-41a6-4915-7882-08dcc5980556
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6315

Add RTQ6056 (spider board 3rd source) support in yosemite4 DTS.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts  | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index f73719b3c2f1..03a1e41312e3 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1240,35 +1240,35 @@ adc@37 {
 	};
 
 	power-sensor@40 {
-		compatible = "ti,ina233";
+		compatible = "ti,ina233", "richtek,rtq6056";
 		reg = <0x40>;
 		resistor-calibration = /bits/ 16 <0x0a00>;
 		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@41 {
-		compatible = "ti,ina233";
+		compatible = "ti,ina233", "richtek,rtq6056";
 		reg = <0x41>;
 		resistor-calibration = /bits/ 16 <0x0a00>;
 		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@42 {
-		compatible = "ti,ina233";
+		compatible = "ti,ina233", "richtek,rtq6056";
 		reg = <0x42>;
 		resistor-calibration = /bits/ 16 <0x0a00>;
 		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@43 {
-		compatible = "ti,ina233";
+		compatible = "ti,ina233", "richtek,rtq6056";
 		reg = <0x43>;
 		resistor-calibration = /bits/ 16 <0x0a00>;
 		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@44 {
-		compatible = "ti,ina233";
+		compatible = "ti,ina233", "richtek,rtq6056";
 		reg = <0x44>;
 		resistor-calibration = /bits/ 16 <0x0a00>;
 		current-lsb= /bits/ 16 <0x0001>;
-- 
2.25.1


