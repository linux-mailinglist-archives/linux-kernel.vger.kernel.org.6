Return-Path: <linux-kernel+bounces-321193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 237F29715B2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70562B225A5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18CE1B5801;
	Mon,  9 Sep 2024 10:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="yF7aef64"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2075.outbound.protection.outlook.com [40.107.117.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26061B530E;
	Mon,  9 Sep 2024 10:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725879276; cv=fail; b=KnOfGuc0gL2IHi2R01sXgLp5ttOJU+EsEKXELuNS4UcEQ9s393qq6ceh5tKb7q8W1L8aluYJ1qJKehbeoR4+i8CHT0oR9hKV778GmKkrDbiIDUYFOQJrOqYTXZj1S1UnBcKgGN2c3cEhhIfl3DLGlTK0dg2ms5KEWvOGf1WelOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725879276; c=relaxed/simple;
	bh=BUyY2iTF7fmhrS1ysQn+40ByqyVCIHiRD7GXlxXQ0zo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hr82fxc+pJe6lPDIlvfHNp5PChb7GKzEFRI/gmkoZJk9Z3LcE/PnLq7ubqO2D8+jP/B4B9gJGegSkA6D03NgD9f5swkdAM7kff0r4hjJElrzHVHjSfwHNlJzy8Dp2lXFNF9fEkhvXJqhqStN3vk4vylFl7GC9TPGzd0xOAolO4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=yF7aef64; arc=fail smtp.client-ip=40.107.117.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yLxH/NO1it2jDXiGt27cT5vdO5pqBeJFB1Qq52wthAN2Zd2JTeHKqyQQmH0qhUbBa4bwKLFqm7DQtwXVzCvU/rOV+4WvDLDd3zduExEbMpBVcdYMZIezTiT4NxhmLX911jznD6U1lVIrIgWaAdDHZ4e9rrb5yKMbpBhitkzxaLhaDZpUb1g7ob7Bs5esN4Dq8qBS3FWKm8APhxfqpwKAJmBhksT75jyNCXZZGVRyPvJ313+7JUcluIhKNaW+vAsANaxayHQF1y6WEePUnogoo+1pyF6bX/YSYGNX8a9OEcdMRmX9cRZtnMW//pbYSAj3HMjBywIwZfPyCY7DikRK8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86U5XL/AcsvX+iUlUuqlnxrP9a/ZAXQ8UY1mjpc/hLA=;
 b=UnCPBUWfobhrXAj3PiZSHuJKdfmyR9eQqI19y5EAD5XwToW203pewU5cFjCqiBX+PP1LnE0L8nv7MqtbiwRTFgtvCVeXcF6E+T/kkB5klDaqDFWTT7E0JXnVYiM6mzqixWunVZQH6HzsewR4BHHygFJW8sZXOQXtVVl1LNI3ZsZMNhKc7E5I4x5e5LiX02qVtqjk/Qp0PNY8QzN3gqKaBXoRkSyXJ7XkHoddyN7BXBWvqdM/cfkpAcW84BPeBUJNHKJX4RpIzdW8IwBDmdbnD+A2Hci4F2aDVwcdGwbbRUFu7fhtAFZRF83QQ3yBAAEmnPP7Gd0GGJ9ZhZVYF+dlfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86U5XL/AcsvX+iUlUuqlnxrP9a/ZAXQ8UY1mjpc/hLA=;
 b=yF7aef64xLw1+k3IXZI7km9+Pzj/1o3b9LWsNIIpQfSBWQ5OktzEIUjgCtafatQS8UzsMelaArapMSp0qUfiEQvcACPNS2oV3OfEGWWfKZTvukzvRxmsuT9fioDgNrl715HnXTg/HitIGp2jjbLkULoiojEn1dDzUrv96vjDAjfTWZRVfrUnwuGiB14fXGgGR6aRKcTatIr0ZbMWxCCUWqerEqTkzZGRFIjOHyj/N4FmAfctr3HPYfA/yD9HRLkPP3aJKL/wOmlGmcTc37Lf9vVvwAXM2UFhBIhJyHTBFrElHow8arFpDDBtl/5dynjulLCxfjoWeyHhpjpI0YTEEA==
Received: from SG2PR06CA0217.apcprd06.prod.outlook.com (2603:1096:4:68::25) by
 SEYPR04MB5740.apcprd04.prod.outlook.com (2603:1096:101:88::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.17; Mon, 9 Sep 2024 10:54:26 +0000
Received: from HK2PEPF00006FB2.apcprd02.prod.outlook.com
 (2603:1096:4:68:cafe::2e) by SG2PR06CA0217.outlook.office365.com
 (2603:1096:4:68::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Mon, 9 Sep 2024 10:54:25 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB2.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server id 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 10:54:24
 +0000
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
Subject: [PATCH v18 1/3] ARM: dts: aspeed: yosemite4: Revise i2c-mux devices
Date: Mon,  9 Sep 2024 18:54:16 +0800
Message-Id: <20240909105420.441607-2-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240909105420.441607-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240909105420.441607-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB2:EE_|SEYPR04MB5740:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e6a25b28-96bb-4fc2-35f1-08dcd0bdc4f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wUbIC1quTdeVMAI4e4agjCmLQvpFkwTJ6joTs/q11/K3ukH9k+7MlkcvZU+w?=
 =?us-ascii?Q?uBd/zQ9Zhy1+PKOv2DTaDV72YTvba5X2FCHJCQmYbd5AnzQfj+a6TllZ99Ul?=
 =?us-ascii?Q?24nTe957va+kH4pJdPRaUJNGkaJZBb84EcG+7IZe24bChHFZtcLBJafd50Xa?=
 =?us-ascii?Q?iyvmMUVYTFStY+wReBiM9sVRghLsaAG8qads+jmQ3U/LKPl8lBY7WZHXSooK?=
 =?us-ascii?Q?ERJFdjCBLasOqw9YK8/hhvHSonFI8mG924s38Bluil2xdvigx8UGjCc9CSWL?=
 =?us-ascii?Q?7xi8hK/dlKi8TOg8IEf6soh99NDbIc91EDeBRJkkbMIOeHmPNjdBa8Hh5EFM?=
 =?us-ascii?Q?wkSMEmNXdVXEW2RbpYADukvog3LCsF3w2Kqzi4Xy0oeo2sQI+QfP0PoiXIGJ?=
 =?us-ascii?Q?OYCc7vwvFtMb1XKAjrJTkOc2ByW9xQROX+fbNSdVQnniWmgWvu0+slLGRZOh?=
 =?us-ascii?Q?B15+NnmGEHNGa2bPF49t+4C0hyrjS1BmjeqU7iZIaCa5PjYHlNg88UlhRnrn?=
 =?us-ascii?Q?yvQ6H8BGEfu1wMbRrriJb6BiTWFUj7sDy0awRIPVbiNKPh8gZL7hBKscN6PA?=
 =?us-ascii?Q?ny4CtSKB9wzkcA4m94VzYdfNDTONuA+TlSczs5nuIBrqNRMKLiRhsdCRTOqc?=
 =?us-ascii?Q?hUm7C4Tee8mp55YCF3EXJVO5UW4hMMuAqF++iqhUPaXQbeFPPYlr0Q1qEw1Z?=
 =?us-ascii?Q?BxKWLzk5o+mfPKGQ+5Uynxehqje3xnzbpL/yANgnIas4I5mENQ2He/mYeDQV?=
 =?us-ascii?Q?tR2+plyXZTg8WTcq1HpRQwfgIFUPwpJxLSo92kl5zf4yByXQn6Fry0GQUiqM?=
 =?us-ascii?Q?qYjAl59mYdQNQ5VjYYPuSiNzzx/cc7XAtO4SFINijJaatv0osWXUCWnSZ26u?=
 =?us-ascii?Q?YoCyXggOH4T5YEpnghg9OVsFtGDjIIrW+st4HSYIfQyJdGCvobdyplWvOWzM?=
 =?us-ascii?Q?oUC4D0qLNLnj1XK5j81Qrs9UBDU8En0qR5G4Gea101MY4bCvgQBkfjctQcNt?=
 =?us-ascii?Q?JahwqGtYGPWXvzcBtXT29bTBX+7lGA1e6Cr1UTRi7fVt3F6lZiMnRaOQEm67?=
 =?us-ascii?Q?ljCdbvEFwABlYJ11hURIBDHlbzntjBs+FOTmq1Eei7fmQ6k/H2BusrsOCPaP?=
 =?us-ascii?Q?93He+RvlP3qt2cSFcKUmYDN9m+QrQBtLftDOuuQANkiNjJx3dAd9miJYmYcA?=
 =?us-ascii?Q?9xUWee8U/EVvaY9whZrHsitjedCXSVNiOpklTIFhSguQsO2bxasWbZ7sDr/T?=
 =?us-ascii?Q?yVGdKghbER43FZJFU8gFUb0Xq797KJSKvTCSfMEYMx6jo/1C4Wdil/z5IwWW?=
 =?us-ascii?Q?uCpMxoGyJYLoyGhLt+71yCrr21VaxAt58zozKSX/XvfWck0BxQ1qpTEzHtPH?=
 =?us-ascii?Q?VrB12PWeO8KS1E83q7jxbuTM12631y9ZyvXaPMkmj6ZMAiEiP7kWJhhQEHh3?=
 =?us-ascii?Q?5pPcfURKfiAjLzkM70+63X/FhUkommgx?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 10:54:24.9093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a25b28-96bb-4fc2-35f1-08dcd0bdc4f3
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB5740

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Revise Yosemite 4 devicetree for devices behind i2c-mux
- Add gpio and eeprom behind i2c-mux
- Remove redundant idle-state setting for i2c-mux
- Revise address of max31790 devices after i2c-mux.
- Fix warnings reporting by dts checking tool.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 480 ++++++++++++++++--
 1 file changed, 437 insertions(+), 43 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 98477792aa00..bed6bf695496 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -17,6 +17,29 @@ aliases {
 		serial6 = &uart7;
 		serial7 = &uart8;
 		serial8 = &uart9;
+
+		i2c16 = &imux16;
+		i2c17 = &imux17;
+		i2c18 = &imux18;
+		i2c19 = &imux19;
+		i2c20 = &imux20;
+		i2c21 = &imux21;
+		i2c22 = &imux22;
+		i2c23 = &imux23;
+		i2c24 = &imux24;
+		i2c25 = &imux25;
+		i2c26 = &imux26;
+		i2c27 = &imux27;
+		i2c28 = &imux28;
+		i2c29 = &imux29;
+		i2c30 = &imux30;
+		i2c31 = &imux31;
+		i2c32 = &imux32;
+		i2c33 = &imux33;
+		i2c34 = &imux34;
+		i2c35 = &imux35;
+		i2c36 = &imux36;
+		i2c37 = &imux37;
 	};
 
 	chosen {
@@ -255,41 +278,328 @@ power-sensor@40 {
 };
 
 &i2c8 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	bus-frequency = <400000>;
 	i2c-mux@70 {
 		compatible = "nxp,pca9544";
-		idle-state = <0>;
-		i2c-mux-idle-disconnect;
+		#address-cells = <1>;
+		#size-cells = <0>;
 		reg = <0x70>;
+		i2c-mux-idle-disconnect;
+
+		imux16: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom@51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
+
+		imux17: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom@51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
+
+		imux18: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom@51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
+
+		imux19: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom@51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
 	};
 };
 
 &i2c9 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	bus-frequency = <400000>;
 	i2c-mux@71 {
 		compatible = "nxp,pca9544";
-		idle-state = <0>;
-		i2c-mux-idle-disconnect;
+		#address-cells = <1>;
+		#size-cells = <0>;
 		reg = <0x71>;
+		i2c-mux-idle-disconnect;
+
+		imux20: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom@51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
+
+		imux21: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom@51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
+
+		imux22: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom@51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
+
+		imux23: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom@51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
 	};
 };
 
 &i2c10 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	bus-frequency = <400000>;
+	i2c-mux@74 {
+		compatible = "nxp,pca9544";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x74>;
+		i2c-mux-idle-disconnect;
+
+		imux28: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			gpio@20 {
+				compatible = "nxp,pca9506";
+				reg = <0x20>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio@21 {
+				compatible = "nxp,pca9506";
+				reg = <0x21>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio@22 {
+				compatible = "nxp,pca9506";
+				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio@23 {
+				compatible = "nxp,pca9506";
+				reg = <0x23>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio@24 {
+				compatible = "nxp,pca9506";
+				reg = <0x24>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-line-names =
+				"","","","",
+				"NIC0_MAIN_PWR_EN","NIC1_MAIN_PWR_EN",
+				"NIC2_MAIN_PWR_EN","NIC3_MAIN_PWR_EN",
+				"","","","","","","","",
+				"","","","","","","","",
+				"","","","","","","","";
+			};
+		};
+
+		imux29: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+	};
 };
 
 &i2c11 {
 	status = "okay";
 	power-sensor@10 {
-		compatible = "adi, adm1272";
+		compatible = "adi,adm1272";
 		reg = <0x10>;
 	};
 
 	power-sensor@12 {
-		compatible = "adi, adm1272";
+		compatible = "adi,adm1272";
 		reg = <0x12>;
 	};
 
@@ -348,22 +658,61 @@ eeprom@54 {
 };
 
 &i2c12 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	bus-frequency = <400000>;
 
-	temperature-sensor@48 {
-		compatible = "ti,tmp75";
-		reg = <0x48>;
-	};
+	i2c-mux@70 {
+		compatible = "nxp,pca9544";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x70>;
+		i2c-mux-idle-disconnect;
 
-	eeprom@50 {
-		compatible = "atmel,24c128";
-		reg = <0x50>;
-	};
+		imux34: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
 
-	rtc@6f {
-		compatible = "nuvoton,nct3018y";
-		reg = <0x6f>;
+			temperature-sensor@48 {
+				compatible = "ti,tmp75";
+				reg = <0x48>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
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
 
@@ -380,6 +729,8 @@ ipmb@10 {
 };
 
 &i2c14 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	bus-frequency = <400000>;
 	adc@1d {
@@ -440,16 +791,14 @@ eeprom@51 {
 		reg = <0x51>;
 	};
 
-	i2c-mux@71 {
-		compatible = "nxp,pca9846";
+	i2c-mux@74 {
+		compatible = "nxp,pca9546";
 		#address-cells = <1>;
 		#size-cells = <0>;
-
-		idle-state = <0>;
 		i2c-mux-idle-disconnect;
-		reg = <0x71>;
+		reg = <0x74>;
 
-		i2c@0 {
+		imux30: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
@@ -457,11 +806,11 @@ i2c@0 {
 			adc@1f {
 				compatible = "ti,adc128d818";
 				reg = <0x1f>;
-				ti,mode = /bits/ 8 <2>;
+				ti,mode = /bits/ 8 <1>;
 			};
 
 			pwm@20{
-				compatible = "max31790";
+				compatible = "maxim,max31790";
 				reg = <0x20>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -470,11 +819,13 @@ pwm@20{
 			gpio@22{
 				compatible = "ti,tca6424";
 				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
 			};
 
-			pwm@23{
-				compatible = "max31790";
-				reg = <0x23>;
+			pwm@2f{
+				compatible = "maxim,max31790";
+				reg = <0x2f>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 			};
@@ -499,19 +850,19 @@ gpio@61 {
 			};
 		};
 
-		i2c@1 {
+		imux31: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			reg = <0>;
+			reg = <1>;
 
 			adc@1f {
 				compatible = "ti,adc128d818";
 				reg = <0x1f>;
-				ti,mode = /bits/ 8 <2>;
+				ti,mode = /bits/ 8 <1>;
 			};
 
 			pwm@20{
-				compatible = "max31790";
+				compatible = "maxim,max31790";
 				reg = <0x20>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -520,11 +871,13 @@ pwm@20{
 			gpio@22{
 				compatible = "ti,tca6424";
 				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
 			};
 
-			pwm@23{
-				compatible = "max31790";
-				reg = <0x23>;
+			pwm@2f{
+				compatible = "maxim,max31790";
+				reg = <0x2f>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 			};
@@ -554,12 +907,10 @@ i2c-mux@73 {
 		compatible = "nxp,pca9544";
 		#address-cells = <1>;
 		#size-cells = <0>;
-
-		idle-state = <0>;
-		i2c-mux-idle-disconnect;
 		reg = <0x73>;
+		i2c-mux-idle-disconnect;
 
-		i2c@0 {
+		imux32: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
@@ -570,10 +921,10 @@ adc@35 {
 			};
 		};
 
-		i2c@1 {
+		imux33: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			reg = <0>;
+			reg = <1>;
 
 			adc@35 {
 				compatible = "maxim,max11617";
@@ -584,6 +935,8 @@ adc@35 {
 };
 
 &i2c15 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	mctp-controller;
 	multi-master;
@@ -596,9 +949,50 @@ mctp@10 {
 
 	i2c-mux@72 {
 		compatible = "nxp,pca9544";
-		idle-state = <0>;
-		i2c-mux-idle-disconnect;
+		#address-cells = <1>;
+		#size-cells = <0>;
 		reg = <0x72>;
+		i2c-mux-idle-disconnect;
+
+		imux24: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
+		};
+
+		imux25: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
+		};
+
+		imux26: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
+		};
+
+		imux27: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
+		};
 	};
 };
 
-- 
2.25.1


