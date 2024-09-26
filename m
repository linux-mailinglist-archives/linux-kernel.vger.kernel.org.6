Return-Path: <linux-kernel+bounces-339818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E35A6986AF8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 04:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E9D0283BBD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 02:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072F7173346;
	Thu, 26 Sep 2024 02:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="zLHKiRLh"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2084.outbound.protection.outlook.com [40.107.117.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984171D5AAD;
	Thu, 26 Sep 2024 02:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727317894; cv=fail; b=GyrRRGbkaNPVvtRbsrxhMOC5L24X5icQXRVw6HpOwJ2Enir91RnJxXw6qUVl9cDJ5TpwRPoiZO7QYfCQ8Y3oSkpm7k0irDd9cVmeirIhTiZa1OA+lsHqxRI78PZ7fDK4jBAgXPMCI3RDZXrbjn2CFVUtAUOaLqaVO+CEshuaVww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727317894; c=relaxed/simple;
	bh=vI24t4FzHicwJY/ZeHBC0gUnd9jdhdD2YOI2gQ+PlG8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kW126TGaU7zmnvFmS9XEnGOCcFbPaFFo927XSfc0n0Ye6Be7qOQfzRVOCGBfYfMGYYh1pai74RGENttpA/jvl7emuDJJHJ4xYLnp4t0XjNL+mTQGeZib4dlwRLVBElyz62TFGShE/tnllZ2qonuV2sqv7A6LDqcEDnlk2cAC7/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=zLHKiRLh; arc=fail smtp.client-ip=40.107.117.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NBy6nLUfZcYPaH0XNBriT9JF3BkXvAuqEDSznqVWrZWWEM6r4Z0D0rufnGS4JVDOtB6aXUr9OL+IE50w/qvHIVseO7pBS0rYndoeabM6AyLHGV94E0PC/5VYWsaOIDU++D79VXKkdSrJiqYUc5BQlAz1WmyIoltZ3sv6n8Zjq/nRl8VeBOtNgad5ltgt6szlze+WtAztWYRd49LFLnHUy0MY+3ROcUE9tfFwGvvwmaEggijeNym1ooU7WKr+YeZOej+zckZ+8JyoS7w00lKhHb1IKzGwyuxX3/mz6FMLLEzJK1BiJstjWTzIdZhO+olvvy7hiU5NxPFxW1k5cPzXiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fw21jEefcpn7QiOgNdCQtdLTqlctJ02DQWSa7aOQxp0=;
 b=ix6vxHgUtLGM83L9SM+GuTBfCokw2L9TlodHyza5QnJc+ZcD1jToZUEyX+5GSoFHhmlYMwND7BRe9GLXRjHsYCTErdX1tE6SP9JorJzaFdicWL+hlpb4016QEmQkWi4LVUTJBaAz6u0tS+kVfXdGfUytoxlzLaWLSGGNWsMaWulsxF8UsckmcUzdELhQdZu2sOoPBKIWiwe0PIuV3xn8CQtmN6Tv9AAbY03cZoxdOEhCwKh7Yy5bFMkUMrIsHBJkTwMIqHdgXwycudN6Lo8lB8mDM9WmOxcYKc+mkscX9HhoKtYXONGbiJleafkl/eCrrryNMSyezEi3f48ES6Srqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fw21jEefcpn7QiOgNdCQtdLTqlctJ02DQWSa7aOQxp0=;
 b=zLHKiRLh05Zio5Z8p4BO7Fljm7dE67+uC2nXaKhj2ekMiLRsKJHQBAw/WX1gs8qeAyZPgteFtF+CYOPYtyECcGSiCTL5nD5au7BBAqel/4UMnuHThaik6MTVrjAcv/NyuhKHdql1YxuFnstA5BbmcXprmitORMuLkpDVjzXh6GsiAcWJ23hfwHmhBcPMntjmeHiBbyjGrXHTZOi7GsDatiTkBvq1EoCMDAA8BdW3uz8yarOED4HhsconX1yyN0MfXOWVn+Jw64gNKaQdlSFpCPuR/KRxMi9svhI6hrWk7m8w0u4/znndVN0ix667VBldX9/jjpcnur08EhuOaQcj0Q==
Received: from SI2PR06CA0003.apcprd06.prod.outlook.com (2603:1096:4:186::14)
 by SI2PR04MB5672.apcprd04.prod.outlook.com (2603:1096:4:1a7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.20; Thu, 26 Sep
 2024 02:31:25 +0000
Received: from SG2PEPF000B66CD.apcprd03.prod.outlook.com
 (2603:1096:4:186:cafe::82) by SI2PR06CA0003.outlook.office365.com
 (2603:1096:4:186::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21 via Frontend
 Transport; Thu, 26 Sep 2024 02:31:25 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CD.mail.protection.outlook.com (10.167.240.27) with Microsoft
 SMTP Server id 15.20.8005.15 via Frontend Transport; Thu, 26 Sep 2024
 02:31:22 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>,
	Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] ARM: dts: aspeed: yosemite4: Add i2c-mux for four NICs
Date: Thu, 26 Sep 2024 10:31:19 +0800
Message-Id: <20240926023120.3785292-1-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CD:EE_|SI2PR04MB5672:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0258af21-a6c3-45cb-3f48-08dcddd3507a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E9Hx17tYJNP5pmowQcHVPuQGNyeRdoDXMLQS16kFN9zfW/YybiBn+3qaJCXs?=
 =?us-ascii?Q?hozmeHFoSnIqqEpu5cBOZ8rn1Gyg1/Tr1pluNVeNgd6C9DqIwC6cCQ/Fd8Bm?=
 =?us-ascii?Q?LnBZsdxZ9XQbVzodyY2K89J65eprOaEKWibmJ7ex310wgjxgr+zYPSj0l+vg?=
 =?us-ascii?Q?XahY/C5F8BjqOrjWHUUKP4GOYNFFCoDsDm83kGtS3FS8Ai1BdIRIvwbi8mzG?=
 =?us-ascii?Q?L+t45ac1ZtzRecMHHuPxHnREtChXZH4+2ZgQGi9a63lKNWubC8UrtLH34aqT?=
 =?us-ascii?Q?rsolyspYIwxOONLkQIdXB3Zq1za6ZTHz6dneiBKNprWaFNu83oP+f8HJEhkk?=
 =?us-ascii?Q?x4e01kDan6BD2lLWNfz6CeGUrPs9oSVk75i0fZPE110Yoeu0il6DEgBtuzf6?=
 =?us-ascii?Q?byGPKpxxrYNqLDE/GIt9uiTcC/Jm6tAMLz8ixV+1ZH69eCIq15jdh02r4FxW?=
 =?us-ascii?Q?1vvWnugpVPkp3Cn1A0gNcho6l+UtexyUfoIGxxywwxfBKV8BpToFKfCs8c0/?=
 =?us-ascii?Q?2Kd+x+0RZkjCOyp68u95UE45ycXiV34hRna1ghUS6LXb+7PK0VDYeE6ad5kn?=
 =?us-ascii?Q?vyVAJdopBwwuHv8pjw1bf7r+m7im6PG5CaXTXvwBUMa7NzKLEoSvH4GkopAC?=
 =?us-ascii?Q?tL0Yq6HbTAbSOj1Yw6FUX7zeZ1m1fz7X1xhtC1kK/08lJwETXb+AUxUihsTd?=
 =?us-ascii?Q?ATYJzyp0v7iFqcuOsbdZbhtKkC21NKik5aiUB6RVlJ42G5ZcjkwIBOAGzd1x?=
 =?us-ascii?Q?VFB8jz4QxxuNcph1Frjmzj7I3pR5LK509ABFj4NOEve4B0sWp33ZeQHbn3Ig?=
 =?us-ascii?Q?fhye00u+Bda9isNgYZDgn94JdodEvMI9WDq1RPIcYmoRgkGtcCiZyt+lnBAf?=
 =?us-ascii?Q?9LdJn58NOTBscVykW2T5UNNMOYSK0+rFP9db9JXMvggae4/PQ0YFVYrFRCOT?=
 =?us-ascii?Q?0ogNiKpbjH9sxxsDnltGvo33pApiVumf4HUKFFXQXxsMpWIRDXxr7xpLc20I?=
 =?us-ascii?Q?AvqZU0oEOZ41Q+NLlWMcR7bOV66lv7YNUF91h+FqhHfJSCA9GGNU2QaA8p8q?=
 =?us-ascii?Q?d0tYfqU0qbT6H73bjtyGyWkf86TAsJVehXWs2yd64l1EKh/b3VgIS2j/Frqc?=
 =?us-ascii?Q?8BXwMzjjY6MI7RoiJcv9QtrliDMF/xHgan+en650/C3a9/CbxXyH9HtImBEy?=
 =?us-ascii?Q?NekKLURgZU2VYjU2BphEPV8rKzxlC+3zYlyZoF4feio4f9Y4V0Lfzt0PDTX+?=
 =?us-ascii?Q?2QsJvrGi7eqvLq6xhKrF33fEfdzLX8A8RWS1utJg9vS7ZWRIKKUMJsYQfRY8?=
 =?us-ascii?Q?Bz9pU38S7GYWV+LEl5R+p8xte++4+yLYLGEgASIxrWJVJMKgwp5Ad7N0tQu4?=
 =?us-ascii?Q?/E0OHNc=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 02:31:22.6544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0258af21-a6c3-45cb-3f48-08dcddd3507a
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CD.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB5672

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Add i2c-mux on Spider board for four NICs and add the temperature sensor
and EEPROM for the NICs.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 76 ++++++++++++++++++-
 1 file changed, 73 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 98477792aa00..d6b1742605c1 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -17,6 +17,11 @@ aliases {
 		serial6 = &uart7;
 		serial7 = &uart8;
 		serial8 = &uart9;
+
+		i2c24 = &imux24;
+		i2c25 = &imux25;
+		i2c26 = &imux26;
+		i2c27 = &imux27;
 	};
 
 	chosen {
@@ -584,8 +589,9 @@ adc@35 {
 };
 
 &i2c15 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
-	mctp-controller;
 	multi-master;
 	bus-frequency = <400000>;
 
@@ -596,9 +602,73 @@ mctp@10 {
 
 	i2c-mux@72 {
 		compatible = "nxp,pca9544";
-		idle-state = <0>;
-		i2c-mux-idle-disconnect;
 		reg = <0x72>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		imux24: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			mctp-controller;
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+
+		imux25: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			mctp-controller;
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+
+		imux26: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			mctp-controller;
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+
+		imux27: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			mctp-controller;
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
 	};
 };
 
-- 
2.25.1


