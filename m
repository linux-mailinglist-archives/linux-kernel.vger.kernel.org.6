Return-Path: <linux-kernel+bounces-289385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0009545B7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ED101F28B4B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1166515A85B;
	Fri, 16 Aug 2024 09:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="Lpjh5alu"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2047.outbound.protection.outlook.com [40.107.117.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954091591E8;
	Fri, 16 Aug 2024 09:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723800360; cv=fail; b=SslNjjXgC1Z4INmoreLTGLGeef16a/J4NQYVIKQiZ7ZGi4yYZYPnCr9kR/0kNs3LAuN8FBSNvctewI1RRTSLQ+zW3frCd3g2eaXZ4ZT7IQQtH11AbjBQpp+38jTkh16TZdiz5PRcQfTQ3Y8fDDSDGnFOenWa/ldNQznqeMnENf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723800360; c=relaxed/simple;
	bh=cikm2FC6auBIaOh1vJuCHO/icFMbB2u/ZGK8PRDbfM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uUpZQHtSFR1VPN919iBETSFdN6w8HOIJdTn10g37wdCeOu7XegL7l0F8E6XjRoG9jlCddrqKkiz/EelhasAZJQUm/DKCFMO6LZiCAZpknyA0SYinL6iO68oZbRYJj7qhq3SvsX9pgiVnbBrrwC0aD7jeHpVWyPPVfGMdCbD6gAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=Lpjh5alu; arc=fail smtp.client-ip=40.107.117.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DGalgoA6dyaNUVW5z5fFLf/9jcS2tzNNU3joh7M5uQaouX9v4552wpSifKMPYxlFXiqBIr+h5EPe27fLGkulJCajhtMWZBEZEsjhCWvCtjnoZ4YiixLwL+0jmNEQ5mUurkfqiL1q/24HuFUlj12vzPSqJjCUIEn9uvL6Eoa9iQ3fLdCALulq1DFPWERejxBi5PgrRkaT4alnbOtmumOwE9Po0hxwFHbQa3zPVVPM3fJzv6g/oKUcbFbl2zm1ulAyJ7pHY8EAPE8G8bsO4TOZTzwBueRiDbHfqsjtAGXiJL+OLW+bO4Fdrz92Y+L++bk4jrsyhp8NEPUCdyZDGNpOmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOLJimcPeCpdCfRBtB9HXjhtSG89GuCrW23kDWg2py8=;
 b=XSQZNIHriSLr1ru5r3oEeugspYnEO50YjsnT48QtaPcaUB89vddow+GUBKegaikzlCQ6T51cBjQ46Sxx+Y5bOPQImyPSLWcl+WHo5F2OvulVzNTWYEhPzfZnbp/7mN1EwbUzWEFFcVy0lWWt0FD5i+g3ZYBxw0aaHX5ps3UQ3fttN9rOzWM2K6f3uzjBwOcl4A6agbIVyHORIq0YGg6JD/h6EaXGKcJP81OThG7/LCJy4DAM8EKVTfYr7FjKXFgusCkG8qE8t8Z01BShxZ6qWUn5cQZHnh/H+RV9N+MBjeb/d88fQN6Z8cj3zXyczTEdPKh11RUy3RkAlDwqTKspeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOLJimcPeCpdCfRBtB9HXjhtSG89GuCrW23kDWg2py8=;
 b=Lpjh5aluIX2Ird1X+AIV33uMpKjnosQ8rBVRJPovWmJQSx//KOQV0GHf96IcXIgH4lnJb7zBEgTooZYo6Yr0p+jxbqpIGptk8OSEH91BmEhsd+pgWdE3ZI43FpUkF9j51zItxjxph3P/a7r+zn4c5uJ3tj86ib9oM627YdeNgdSTi89H+DvNCPWfvuxNhD74WFivrZEptps+FbdjfSxJBcrq21OGcZhNhdy1eGouh5kQ7tvPgqpeG3VukVtT7LromK4GDG2yU2HTB7wTKzYnNk05DqSoQ/Ku2//ETQS97ZcPrRk1+fvY0+AWeKpRCDSxVDszpOOdiljcsTIaIICScQ==
Received: from SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) by SEYPR04MB6629.apcprd04.prod.outlook.com
 (2603:1096:101:c7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 09:25:53 +0000
Received: from HK3PEPF0000021D.apcprd03.prod.outlook.com
 (2603:1096:4:193:cafe::4a) by SI2PR01CA0048.outlook.office365.com
 (2603:1096:4:193::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.24 via Frontend
 Transport; Fri, 16 Aug 2024 09:25:52 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021D.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server id 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 09:25:52
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
Subject: [PATCH v12 19/28] ARM: dts: aspeed: yosemite4: support mux to cpld
Date: Fri, 16 Aug 2024 17:24:06 +0800
Message-Id: <20240816092417.3651434-20-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240816092417.3651434-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240816092417.3651434-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021D:EE_|SEYPR04MB6629:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 75648114-326c-49ac-118d-08dcbdd56c95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wvazU9EwbO9oR9ept9vTAG6qporGJ/3hEW79STtJGfFdBLTAhmyOaisAj2fF?=
 =?us-ascii?Q?kmVO4elEPuM8YFdzbKiHHC1+f3yizuXEjl/N0zaaaQQrRNOhNYePZ3WWw0o5?=
 =?us-ascii?Q?YoPsdiTmlZAM24/XcU9cKn/OeAe/B1u0jsXlxesM9DZrASkZZj2WqjfOJM3m?=
 =?us-ascii?Q?G84Pjz0qBkTSyK35o+C4MeFyljuY41BFfRNWkz5qdJvhxwdDQNMZnLTIV2In?=
 =?us-ascii?Q?eJ+Q/FJMz1Pa19sUIA7CHc7dRzngikgyvVlObiS4BizCtYEkUUjh+Ntb/xXG?=
 =?us-ascii?Q?8Zbbn6Qr8k0UZ2JRbz7m6wqTedTSm87nv16/A8Qm+7h9NA5/cwPEFYWATTt1?=
 =?us-ascii?Q?f0f9aMruJ0uoStCzdc7X/RWC+Nf5LfIV5xLMeBzjOeDNIm+BSM678hgspsR7?=
 =?us-ascii?Q?kB5K7T80t48S0NUF4JySlemRsjX8tVdKSstzILnUjShKwHEriWMWtcrBsnk9?=
 =?us-ascii?Q?xRSmRFc57rdXi8y4B+/Q57hmS+2gyOQux2kOmTl9/XmEdWlk354VKhszny86?=
 =?us-ascii?Q?cJAEAn1tYNnNyLdPBCxmnx7bRwwH4ClTNQS1J7jASnUtuZ+wBkwgritaByeU?=
 =?us-ascii?Q?N56QbtsYQrBNhu5jy3j5LweRuGoHP6vZsOk5EPWGPxfNQK13TErVCGGkWWzG?=
 =?us-ascii?Q?zZtKR2L+YiXOhiDDk7qVGNv3Nx8a+K6sa6VDbvAzlrjrBcZCVeFwrkXK8gX0?=
 =?us-ascii?Q?HiMuShxu4jXmx/nObA0/PwBllu4S5T4Ts9QfR3dW4R5qS1XZ1mFgRRNS6MPo?=
 =?us-ascii?Q?IH9y18j2DTx0/rjJd5IX7mRFRPRxrDMzWvh1AccLjLy8m2JR2K+rxgqiTuN9?=
 =?us-ascii?Q?H/OdEovMy/2+wrLjM6ZR/fEVA9F5oGuV8UrICvdPT0vZz2DBCZvnkmR8IUJm?=
 =?us-ascii?Q?vF0fXCwW8cOqK3Zsbt9t9RNrMr/Q74X2KNuYkAn0gfBqTnjpx3L0vw8cERJz?=
 =?us-ascii?Q?gi6TGhdxElYoDEbLmakx3DEsqDulN1z37WB+5IMJdw69XstpID37bi/vdz9v?=
 =?us-ascii?Q?+2umo4pYl8FqNH1y6EuKP22puCwSSfOeQ9McRixf2WujNk9ApiCE0/XjCdwf?=
 =?us-ascii?Q?BEpY6r1DDRovBJGJj/JYvmVlk9/UtOwih2Vja8n/M7LxPuaO8sUKrLUet/ni?=
 =?us-ascii?Q?E6erRwiFvXZG3quazQm29+q46Mw6b76cOUjmeFCEoWYBwP7ile72v32GmJiL?=
 =?us-ascii?Q?XLjEgOEWVYIjjQInirphG6UCrk3QantbYFSEeYr4G+6QvEpGXpUg2eJqNLQQ?=
 =?us-ascii?Q?XYCcbOIk1omO57jSsqcFbw2EU/LtGZi06fRnQe3nVoPgEwnl9mVdHbM6eyOr?=
 =?us-ascii?Q?19TBHYonXNExuZILcsYb8YHQbKhsQimFjIrMeQdh+mxLdJjLPQhz0cY816bW?=
 =?us-ascii?Q?kuPBLGUQ2T1rxixlHo7IVEm/6An+eeeXwYO1/jswUnr1cyY6cppxb2KfPsy/?=
 =?us-ascii?Q?tuniynjRKPXz/GM4a+R3Sb2PTj6qkGNt?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 09:25:52.4972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75648114-326c-49ac-118d-08dcbdd56c95
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB6629

Mux pca9544 to cpld was added on EVT HW schematic design,
so add dts setting for devices behind mux pca9544 to cpld

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 64 ++++++++++++++-----
 1 file changed, 49 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 7b8a2384d99d..98eeee49b082 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -36,6 +36,10 @@ aliases {
 		i2c31 = &imux31;
 		i2c32 = &imux32;
 		i2c33 = &imux33;
+		i2c34 = &imux34;
+		i2c35 = &imux35;
+		i2c36 = &imux36;
+		i2c37 = &imux37;
 	};
 
 	chosen {
@@ -951,24 +955,54 @@ &i2c12 {
 	status = "okay";
 	bus-frequency = <400000>;
 
-	temperature-sensor@48 {
-		compatible = "ti,tmp75";
-		reg = <0x48>;
-	};
+	i2c-mux@70 {
+		compatible = "nxp,pca9544";
+		i2c-mux-idle-disconnect;
+		reg = <0x70>;
 
-	eeprom@50 {
-		compatible = "atmel,24c128";
-		reg = <0x50>;
-	};
+		imux34: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
 
-	eeprom@54 {
-		compatible = "atmel,24c64";
-		reg = <0x54>;
-	};
+			temperature-sensor@48 {
+				compatible = "ti,tmp75";
+				reg = <0x48>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
 
-	rtc@6f {
-		compatible = "nuvoton,nct3018y";
-		reg = <0x6f>;
+			eeprom@54 {
+				compatible = "atmel,24c64";
+				reg = <0x54>;
+			};
+
+			rtc@6f {
+				compatible = "nuvoton,nct3018y";
+				reg = <0x6f>;
+			};
+		};
+
+		imux35: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		imux36: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		imux37: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
 	};
 };
 
-- 
2.25.1


