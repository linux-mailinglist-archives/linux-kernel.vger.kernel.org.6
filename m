Return-Path: <linux-kernel+bounces-320510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6021970B67
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 03:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0046E1C2199A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 01:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0B71C68F;
	Mon,  9 Sep 2024 01:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="qju2txkU"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2048.outbound.protection.outlook.com [40.107.255.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8131BF2A;
	Mon,  9 Sep 2024 01:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725845885; cv=fail; b=VTSduT2IeJ127ICjIxqF84+tzjMQtw0TBx6cIQ1lPurfyqwHtuUk3c/c4z+awjs4RgW+Bat6vW9X4rIdU+838MVHby+z1Tg29XGUOU5oMCNSxBIwq4qH1uGmx3WMK2t0X1wwaCI1wLU81berDQUooAwkpBaMlnXuVdy8fZoNI9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725845885; c=relaxed/simple;
	bh=QWuBkdeh09JL40y8cgduv+dKQxUY92+QyrmEqgmI5TY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y+p7x/5ywcYE291sKcHSW55aqK/pZ9RiKzNLLbD0Lj5cBUpXIt1AV0JYYwwXe1JneDifaJ8pVvl2qCAu6ek6JmC91aktTs+cYGbrTL0sE9Gpl/N7upNc4vcRXf5Ll22RqYImDv8s6zxXgkl5svsTJ8UHWOypikX+C4tH45V04X8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=qju2txkU; arc=fail smtp.client-ip=40.107.255.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y0yMltHvmvmpaHJ3ZRux3DPuihhxi0txJkieszYV0pLW8x8bWGOan///XJteMhOdHPl8vW3TY0lXkjISer0CRIvDmRYgod9EI/GW7GeUbF0ttIvQNkqcfYGXE623WR5g4cyNpihv2pSOXEM5g0emLwWlwxhv5ypyV2w7JplMRNuNaFcyhwRwxEpO09cZd3K2OmdJPlpCq/8rFt7ykbVeASwYHglmjQDcFWbv50fLECgzz5IlrFrSlCmlAKs4Z1ilnuUfzK4tZXONa/oXIj50Yzqual/JBWTvCLPdoJnWLWcbZWiGrqhvb1jrXUZIIm5hqB2w1s/fDA+H7l3wpF3NTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3sSQ0O5z38D/bQZfyLIioqB4KHzzcdGRAymnR4aMUA=;
 b=h235zH8bosIP/zScuCnPSTTOrfZyzP8tkxLH76DJcihGadmNCKdQvvca6pzEZyi08W9b+BTDXdYOYWUWFAIuoWYO3Ai143JneVdREJkZlqGwvxFk2TAFFC5xho+zRKMhxby0NlIMBwII7fHqAlcLSJUfxw8gY4p0OSvtlmwm1nmirOHY1fKzz1nQu9IwT25HdwyLaECDhZiK0RzFu2mg7QnelXF5wTeFlICaDn3LlsCck0Th8cSe4cXWvK3CrY6LPWzZ7nhAs2ybXYpBMe8dTFKKGTSXQY6+D6cRmHA2q4O6lW4l2qp6oWlHS7JP6xPvgeutqagYmKWk8KrtF412NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3sSQ0O5z38D/bQZfyLIioqB4KHzzcdGRAymnR4aMUA=;
 b=qju2txkUrTmM/7KeWt23ijaeXKdiLS+n4MKKvB/pmpQd8R32hcJezburiQuvadGteTFun5x0sb1lESqeRnm2hQsKPk2IfzZikCkOBgLWdq9hsKyAANlKIm0OFO2nsq40FJJ5C+atxCGBDLFCcmVkMiBE+N1PxpxCFw6uBeDosXf4dZjS07y+diubFY7QPJTU1jzHq1lfVwTnaWQSQu4DdaryQxnZc/f5NCUSCv3w/uLxNi88w2wMpo74ixUiFQYp/QP9pS44WFu9SjxH0Bm+Nfc5jDqlTngi0361Ry91CpVzEdpJjAzRXE8Ag7I7Xk0FeqIvnAf1WNO4x81FSG5dFQ==
Received: from SG2PR02CA0010.apcprd02.prod.outlook.com (2603:1096:3:17::22) by
 SEYPR04MB5977.apcprd04.prod.outlook.com (2603:1096:101:8f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.20; Mon, 9 Sep 2024 01:37:55 +0000
Received: from SG1PEPF000082E3.apcprd02.prod.outlook.com
 (2603:1096:3:17:cafe::7f) by SG2PR02CA0010.outlook.office365.com
 (2603:1096:3:17::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Mon, 9 Sep 2024 01:37:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E3.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server id 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 01:37:54
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
Subject: [PATCH v17 1/3] ARM: dts: aspeed: yosemite4: Revise i2c-mux devices
Date: Mon,  9 Sep 2024 09:37:42 +0800
Message-Id: <20240909013745.3306365-2-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240909013745.3306365-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240909013745.3306365-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E3:EE_|SEYPR04MB5977:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d82911c7-f44c-4519-cd9c-08dcd07006ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AmJQytW1ARAUsoTxwHckOJnRFjpNkWNE/8nOynbk4k/hR8kvdFGIWIPiuzUZ?=
 =?us-ascii?Q?I8qgPRj+cE7tAOtN7tRTWPfryjzOEA8Vg2c9s2/81MDG5pW/JMirY/PpxUTp?=
 =?us-ascii?Q?X/aT/hrywvM+t5bZnyFkBhPrh61MKwufg+BrQVwd2ST9RMoLmKsU3ekf7dkx?=
 =?us-ascii?Q?x2zdv9LMf2rdi+rnKvLOfJwHTycBHKNhGrVsTgijisobDfSQQMM6PB+tLT6H?=
 =?us-ascii?Q?9M+UM2LlQWIq6n0PE7a9hXEfoMNCEOeVu7gZBenkW+nTw8jVeA8mQ8AlsNja?=
 =?us-ascii?Q?xCZC4lmtkK33g1phykfxG1Dn/Y+RHlggNO8b/HRcirmjuCB1gV1YLTCrKCVr?=
 =?us-ascii?Q?2gUlh19zwN7A1VYpoGv//nsShWbHRfDaGiqCko8u8a5Bz3cUrnqiL1UgjlQa?=
 =?us-ascii?Q?Pv+Zg9YAPSryKj3H+4UyoBy/fwQ7QEGWpJT/nHGHAxkHSFX/kkh3ziuwx7wr?=
 =?us-ascii?Q?FxaxyZtnkXcX6bPvCALYZW9xukW562q4GIek8hj2JGt/ahac45/zAtI5ODMe?=
 =?us-ascii?Q?YQXt9YQk5rfSaav2EoVVW3mTB8p74t4u6DP8HxnqT/ZGEdcdqYL5gsqzmV62?=
 =?us-ascii?Q?96zTJ2AbD6JqbUWbXfaLpOuNAeCisw1Zmqx/1bYmywnxHeEbJdzuQFtBdHxF?=
 =?us-ascii?Q?0nMWXEerHI64VVuGuKoEqQLWMzUMZ/bZu7yy1IVY9Gqdc3JeBm3o/SpSq+X6?=
 =?us-ascii?Q?kGR9sDS8dZFrgx89KXV1ifBLEJIiaq7as7riFrs0OAdDaxlmog7PV0bwNW+R?=
 =?us-ascii?Q?CxnDcks83z11XKt/eelj1Izr8n9WqTZqJwePgUcqFWzmED2qIVEIx8XjRAwy?=
 =?us-ascii?Q?ISSNqTJaJDuTmOqBi4KoTgobXCvYe3maVTo6Rfc93eLV1tygoxNFXPXsS8r2?=
 =?us-ascii?Q?7trfmt5qMgki6qOAcsMeyBVG+9d1D8R48zCxXlVjWDOJvB3myn4Xr7Jzvif2?=
 =?us-ascii?Q?sBv1CX7w8CwrVI7qS+9HXebzXsWZE0WoKOSsOg6gbar5cNasryw76j2gaKiV?=
 =?us-ascii?Q?3VTZ01fFmdNq6fwNL7QFVEYvukoXEFJ13z3AeWy4k7K7VcrgUMf+zUxW7mXv?=
 =?us-ascii?Q?xlxVvLHpaYSJsuzYLkGxNCdO0FYwTfEfUeLvc0E8Hz6/DNA6zmCyP5mOGHeY?=
 =?us-ascii?Q?ubh3xD4kOzG/UYEokzV1rFjr4FnTm/oKhB7JA5122TGABvbOR9w4D7ZQmGbh?=
 =?us-ascii?Q?ZuMAzKBsGbl2pWgHnFnusRM9FBzQeuqatqO1N16I6wLF+gf4HlY5h8rqXoVt?=
 =?us-ascii?Q?CNJYToS89zrpRSAKr8XRCZuDhFFUBRRvuZwAY6c5DNCwzhk1pwm/FNqXjnzv?=
 =?us-ascii?Q?G8qq0Q9t92bPLr/86+gzDgq+BnB5A3u8y5Fa+TQsuosc6YYC0A9kNIWjp4Hp?=
 =?us-ascii?Q?HFJSVvE/fOkLej407hiAHf+ZiLHtfIL1hqoIFsbulSoWhaRpHm9+qYZuOIsk?=
 =?us-ascii?Q?jU23drsJnjWRgPFJeqUBbT1D1355RB5i?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 01:37:54.3898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d82911c7-f44c-4519-cd9c-08dcd07006ed
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E3.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB5977

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Revise Yosemite 4 devicetree for devices behind i2c-mux
- Add gpio and eeprom behind i2c-mux
- Remove redundant idle-state setting for i2c-mux
- Revise address of max31790 devices after i2c-mux.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 450 ++++++++++++++++--
 1 file changed, 411 insertions(+), 39 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 98477792aa00..96039ffbf8ef 100644
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
@@ -259,9 +282,117 @@ &i2c8 {
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
 
@@ -270,26 +401,193 @@ &i2c9 {
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
 
@@ -351,19 +649,54 @@ &i2c12 {
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
+
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
 
-	rtc@6f {
-		compatible = "nuvoton,nct3018y";
-		reg = <0x6f>;
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
 
@@ -440,16 +773,14 @@ eeprom@51 {
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
@@ -457,11 +788,11 @@ i2c@0 {
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
@@ -470,11 +801,13 @@ pwm@20{
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
@@ -499,19 +832,19 @@ gpio@61 {
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
@@ -520,11 +853,13 @@ pwm@20{
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
@@ -554,12 +889,10 @@ i2c-mux@73 {
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
@@ -570,10 +903,10 @@ adc@35 {
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
@@ -596,9 +929,48 @@ mctp@10 {
 
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


