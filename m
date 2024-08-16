Return-Path: <linux-kernel+bounces-289368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2257B954586
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CA2F1F2627F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9791465A4;
	Fri, 16 Aug 2024 09:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="HZG1GOUR"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2072.outbound.protection.outlook.com [40.107.255.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05821411FD;
	Fri, 16 Aug 2024 09:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723800285; cv=fail; b=FTJMgqR0UrI9U7H4cVZGyfT5/R4hGkXkK0tGzyqVUjLamG5uj62ApVyW1LcA/YdMcuR/xX21yOfPww6afj6RyZ8zLOFPM1rTg+iN8OyIQFANJMnMzxP/NFcZ+aLBMHic2sNsrB1xyhaCKosaSWflGKHDlfbRwCpl4zm2SPOCRQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723800285; c=relaxed/simple;
	bh=SQk4F+mwjmMZ0tJryZeIZeeSIQDAwn6IazerrRIyUUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bj0IRgJsiz92Q8x9iLBRr2S0jGkIOtrjPEoB/wLjKm32nAJmJYsi+BDoBDnBpyCBCm5XazjXppDhg53O7Z9MDiMXwCy6u613RDtH7/UIHh/go+W8nqAwjZQFRRhUPAoC358cZzzjpw9ey+xgAY+MfSa9M4eq4l0ygDnd9hF1OEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=HZG1GOUR; arc=fail smtp.client-ip=40.107.255.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WBkzpKqRPyodw/Lt7u560EZ9WLqr21ywt6B3YzniBTEEMOE55H7QOKlxIBJwzEQumH7M3dsQIGjU5gDRdj4oOHivxexVsz6Xr+noFVmPGgHrtOVokAdW5z3GWZzvasTSR62R397l70t/xdBBSOD4lWJfuC3vOQZYwCMvlZMzqHUr7ewKmy3ce97l4pqNPxJedVu+XFLhOPFjY4hETLBTtE9YTJOyVAUtAR1dB9nHI97/a+KKbIARrOzYhJvJsRI0uBxtfdkvjC2nMVQgfCkSnPiTpbidKg7DGMo5Kxf4VA8CgufBij9ZLv42ahQpFwZ9otD+HeNPtBc7oGPMvhqYNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MpSriWfetK7algw9l4MNrHnpp7Z7wNyiJZzZzENk6Z0=;
 b=S38+F2UsuawH2F3Lej8Nxi39sGZYF75HnfGFY/blPMLpnYTnSrBMGBxcZazMlc3WWL7gSxcsN3PYWa0JNCZZzfaat50tVveD252z0ijm/ipLH6VpY4vV+sy21L7lDCnxHtYB4RQ/wQUQBxFYvGY6YG/RFUMcsGoFM+8E79NeOHPd1+ML/rZFq3mZil8cehZNgbAfgV7h9joqRTYyeiQ0HEEyHMbTEUNTb4vPkELuW1GS0EaEmNal2usOuK01ynmWdcyPMPete5gUXYBvEynaJ+DvUHMsgDi5Z1Y2nQPTGIU9839YZB/+jyz2GYyN2cg0J8rFPyG2N6QUwrs/N/MIkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpSriWfetK7algw9l4MNrHnpp7Z7wNyiJZzZzENk6Z0=;
 b=HZG1GOURG9i5PF+W2/AxRB+QAKZ7NILd7ANbaFay0fmGOUi6CXGyhoJsgE6Oq4Bx2KPcF7sIqRktSSZl0Cf2UcPK0Ybuf4iUttU8RAstugXfjJdSfMSvLBRxoYwm3DpcQVuCvFZZ/J6n/eAA0pF8kN7fEsmr8ysR1ZL+a8ondBjLHlJKFtz+vuLjgcVIEFbscJAMos1gpcLG7gARvuGvMXmrSLTL39jTjDc1Bxg1iEv8xWt++hqM/W2a9yltLnPcmrIzoMCoq9fa20YPPBnH7MCRPIlR+pA7+b2xIt+Vun+rGw6aC9vrM4E9MD6cZJXNFhnP6MGHTtUpLdsigr/VwA==
Received: from SI2PR01CA0044.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::8) by SEYPR04MB7671.apcprd04.prod.outlook.com
 (2603:1096:101:1e3::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 09:24:33 +0000
Received: from HK3PEPF0000021D.apcprd03.prod.outlook.com
 (2603:1096:4:193:cafe::c9) by SI2PR01CA0044.outlook.office365.com
 (2603:1096:4:193::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19 via Frontend
 Transport; Fri, 16 Aug 2024 09:24:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021D.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server id 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 09:24:32
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
Subject: [PATCH v12 01/28] ARM: dts: aspeed: yosemite4: Revise i2c-mux devices
Date: Fri, 16 Aug 2024 17:23:48 +0800
Message-Id: <20240816092417.3651434-2-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021D:EE_|SEYPR04MB7671:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ee9c3fb5-d570-4f3e-7d2a-08dcbdd53cfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4zjA57FM0a/rEl/r9GJ0nhgR6NVeiQuheubjtjpbBFGTlFhkGPSu8kiNSmLr?=
 =?us-ascii?Q?cH16C3YgJI4or9HXcsPVuvpw6bXz2NSFYUnBQKCwfsALwO08zTkiJv6O4zE3?=
 =?us-ascii?Q?KnUUA+uFIGIlQMSlKR+G3f4CH3RjQLngVoX9YQOQdccSgnIBDbEP/oXuoyDp?=
 =?us-ascii?Q?BrZtCU9HTCOAStcbsh+9KNwLcxBrzQ5lFfYWn9ayEkVF345Dio2rMHzhAG4A?=
 =?us-ascii?Q?McVDS8CBuPIz81pLv3YgT7nrkQ58r7X/vtKzucTfIz6YQAe5Dd+PHtMXlZLc?=
 =?us-ascii?Q?vHgOGn7T6z/Gmm2FP7WAKdvtC54bFOdJtIp2CbjkfF/QMqSGX/Ra2J4nC+tz?=
 =?us-ascii?Q?TjQMEgICZGdVR3vW8kjnjIBVxJwZx6eNo2NwHpUH06XIaNM/sNMOZVOHJvgm?=
 =?us-ascii?Q?fSYMrx28weBrL1T4WB8Hct787aEdcCqGh1Hizu7p+XpPt8F+dBdRzfPTAYJk?=
 =?us-ascii?Q?qEhxVsJI4whPQdeD0m68z64jH48wI1PC+dtSwppUv94sTMacBNChYhMtBlyN?=
 =?us-ascii?Q?3pOzJEVrjtwvWwWf0rrUzmOnuxSrkol4hZk9jtKsub+DK8bttzXTxDuQ32VG?=
 =?us-ascii?Q?k6t5P0IuiD9P46ahpY++K7o7EAAH+XqbANnc/YTxFHPRPGm3APPGvI7qlBXs?=
 =?us-ascii?Q?y5OuRzRdmkq5YHEOYg5qlfj1SLXr6ZlorG7pMmGkXKS1kEe9sUJnGB9Rjym4?=
 =?us-ascii?Q?/wjZvF6FR8WbENVJAt9tQXOJ4sG0tCRs5/vN85Rr4/9dIXcPVEIHoTh35ie3?=
 =?us-ascii?Q?3k6f3ZHiL0b79jtqiZBioxKenLqCZuGq03w7w+DVvTv/1HHnYzVpB9HRk44X?=
 =?us-ascii?Q?Rqae/VpBUFarIE08SDn6X0MwtKH/+DWzgioK/nuXDrFpMgJABr8dEZy7e6UQ?=
 =?us-ascii?Q?VqO6+NZfcJr/u78WJHDl9GaTqd82NvVmXamqKjdusEhYoGVSEqvlJgaRb9Uv?=
 =?us-ascii?Q?NiA4Fb0xZGJpyS1QkxV51M/4xD64jMUnkbqU6Gm20snvegFt/GUImC9ybtf8?=
 =?us-ascii?Q?/urCdhLRD5UvWdYjwN18QrVgFWJwYjj8vIGzSwU3i2n+UPxr39bsLIZ7xkvU?=
 =?us-ascii?Q?Tma0K08qM+1pAh1gPNM9bGNalHEtDr5P+DFF4s5jQc5+HUnb66WC9HtMa+Qs?=
 =?us-ascii?Q?fVtff2LVOHwif/1hDaWNAd5kbDVCVs6C0aOH2fklACd+TkLFoQQEtgXBlde4?=
 =?us-ascii?Q?vwN902CnJ0rhnB3mgTliuru+Z6HN52krn0OgDw6vZUJFA1Xba6CahrmoWEWe?=
 =?us-ascii?Q?MF8m5NFLcxmH4YSeYo0rDpxvHVcd0IX84DQkM16ksSEajW/zU/tk5jI79baK?=
 =?us-ascii?Q?0lGBC5LnS9PcoriDi/DdIsb5f90oQtTDn5MxlGxJ1/x9u+gDyp7S/4EDvmlD?=
 =?us-ascii?Q?NYllNO7LI+7KGbweBB8H4z9+/u97REKqLJdXnvkOtw5JQ7TQvKYWYT5kTw56?=
 =?us-ascii?Q?kOfE1hX3Y/iATOBk0EpYr5zg1DwlPElZ?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 09:24:32.6378
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee9c3fb5-d570-4f3e-7d2a-08dcbdd53cfb
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7671

Revise Yosemite 4 devicetree for devices behind i2c-mux
- Add gpio and eeprom behind i2c-mux
- Remove redundant idle-state setting for i2c-mux

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 381 ++++++++++++++++--
 1 file changed, 347 insertions(+), 34 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 98477792aa00..ce206e2c461b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -17,6 +17,25 @@ aliases {
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
 	};
 
 	chosen {
@@ -259,9 +278,109 @@ &i2c8 {
 	bus-frequency = <400000>;
 	i2c-mux@70 {
 		compatible = "nxp,pca9544";
-		idle-state = <0>;
 		i2c-mux-idle-disconnect;
 		reg = <0x70>;
+
+		imux16: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
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
 
@@ -270,15 +389,174 @@ &i2c9 {
 	bus-frequency = <400000>;
 	i2c-mux@71 {
 		compatible = "nxp,pca9544";
-		idle-state = <0>;
 		i2c-mux-idle-disconnect;
 		reg = <0x71>;
+
+		imux20: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
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
 	status = "okay";
 	bus-frequency = <400000>;
+	i2c-mux@74 {
+		compatible = "nxp,pca9544";
+		i2c-mux-idle-disconnect;
+		reg = <0x74>;
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
@@ -440,16 +718,14 @@ eeprom@51 {
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
@@ -457,26 +733,26 @@ i2c@0 {
 			adc@1f {
 				compatible = "ti,adc128d818";
 				reg = <0x1f>;
-				ti,mode = /bits/ 8 <2>;
+				ti,mode = /bits/ 8 <1>;
 			};
 
 			pwm@20{
-				compatible = "max31790";
+				compatible = "maxim,max31790";
+				pwm-as-tach = <4 5>;
 				reg = <0x20>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 			};
 
 			gpio@22{
 				compatible = "ti,tca6424";
 				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
 			};
 
-			pwm@23{
-				compatible = "max31790";
-				reg = <0x23>;
-				#address-cells = <1>;
-				#size-cells = <0>;
+			pwm@2f{
+				compatible = "maxim,max31790";
+				pwm-as-tach = <4 5>;
+				reg = <0x2f>;
 			};
 
 			adc@33 {
@@ -499,34 +775,34 @@ gpio@61 {
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
+				pwm-as-tach = <4 5>;
 				reg = <0x20>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 			};
 
 			gpio@22{
 				compatible = "ti,tca6424";
 				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
 			};
 
-			pwm@23{
-				compatible = "max31790";
-				reg = <0x23>;
-				#address-cells = <1>;
-				#size-cells = <0>;
+			pwm@2f{
+				compatible = "maxim,max31790";
+				pwm-as-tach = <4 5>;
+				reg = <0x2f>;
 			};
 
 			adc@33 {
@@ -554,12 +830,10 @@ i2c-mux@73 {
 		compatible = "nxp,pca9544";
 		#address-cells = <1>;
 		#size-cells = <0>;
-
-		idle-state = <0>;
 		i2c-mux-idle-disconnect;
 		reg = <0x73>;
 
-		i2c@0 {
+		imux32: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
@@ -570,10 +844,10 @@ adc@35 {
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
@@ -596,9 +870,48 @@ mctp@10 {
 
 	i2c-mux@72 {
 		compatible = "nxp,pca9544";
-		idle-state = <0>;
 		i2c-mux-idle-disconnect;
 		reg = <0x72>;
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


