Return-Path: <linux-kernel+bounces-300816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 612F995E8C8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5F9EB21C25
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A449320C;
	Mon, 26 Aug 2024 06:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="U+0vxYyV"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010069.outbound.protection.outlook.com [52.101.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939DA145B16;
	Mon, 26 Aug 2024 06:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653589; cv=fail; b=r63OmWME0V6KTcWGbYEC0b0NTtpg2gLJxK0cN/1RDJ1SQ4EqnanrnzDB+hnT2vnnW9gEepQigoCEG5HM0kxRqbAlOIeiXnfl5xNs703L38NJLSRTf895h+RLmtPM7uQkk4zXjvPhJWNI7wB8JrkliTEUoreHSgXx/LirmTOzUas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653589; c=relaxed/simple;
	bh=008+v/O2Jqnp6k+93ZsuoXW1iys2wSbe6kzenP4szZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cKCdK48NNoFmaB3c15JnHrUTDCd6VbauqQGtHBCqpSLaFLDHTMydIlErSAU4GKMyooWIqjZvnWdKRQYHWD63Rl5Es0XiLV5014mSWRnIhA+3y856bXl4oaruibTDhu1Glv27QQMOvDfSuV13Qw6ByQ6Ax5PCs7L6attRlTNh0xQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=U+0vxYyV; arc=fail smtp.client-ip=52.101.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQuOK13DC69/usftEdP2756Hyq7CmPgv1CkwHLIijMMCtacLtY4Z0p2XHklVvbPcOrn6PRHW3Fxb9J7SD6N2NKfoXR59fdCZb077hw1JhENE6TDPIyuLiintnUgahvcV/jKh3XsgKaPDMcOFjAPFWzPUasGagWywNttSbhv5X7s4ZE29dzBQ7GjDT2PGaTDLiqpli2/wjKHcEH7iUJYJRf3Rn9bjuXxpet/SFCRC+cp2l+sw0ngL8aSzy2qdFfelCljrJiEgJ+FKUXbIo7zZ/THPs6Y/ibQ8KpEXJHaxYpWIbGeD8xvP+LTdJg4wAlUgG551lnk5zgaYyXcxydL4Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QU+JZ1MSglaWLSUKc8QjBu76ufZkEOMMNsu7ns+mPuQ=;
 b=Tbrc2R6Ay77ZvEYF2CyF9PbQ7cO7WCqOzueNy8evMbTZV0CU67f1R4bO5RWeJkFUuK7+4UdymFwJZpBfUYdKEwkdkk0qD1NQAIWVxSXOO7wQU+O9y6Uxlps84+/VnU9hqZ2GmBUGAZ/y/L0sPfl7IAPvrOAjTGNtWjFa81UkMp+6LRE/7FrtlG++G2WyvsbcgwDF35qSAksPaw5gv19ig0zlGCdwr5dlFRj6dzihYzVrTM2a+disWkNUj0JcGysfhmHExs5EIQ2hHj1swqQleaYstVcp334n7j1ttezEihgNzxX/nprKJgNC+yCT/Bb5raXZ82BmJqHIZZ+TH96+rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QU+JZ1MSglaWLSUKc8QjBu76ufZkEOMMNsu7ns+mPuQ=;
 b=U+0vxYyV+u06IahDpqc7lo5LjGW8I6vhgfM2Okid6myk5JvEq5XJiBv8UiqLbJ1KIOfJq9Fabs/5ky1Scs0TUl49fSoRE7wGfRKt+b5p6OzafDLAxhndaiDaEB8jdXI+NuKz5rNI6vutYeQmA5s7kf8umCy9zX06PxUFirO/ebSPy8Q+OFd7hB/QBOHmz7KkHuiUWS9k30NeTu1kL0sb1RdFFrnjh8cpOlfyJwZMExG8o7PLTJkyY/lnbKfxiRbSXMuP2/0WiPa8uDZ2slY7SHUZMgInRSC5tKPu8yWgn8Gj/vb0C3XuyrmGPQdiVGpr0CS7xsyQ/m2en8UpOEA8IA==
Received: from PS1PR03CA0003.apcprd03.prod.outlook.com (2603:1096:803:3d::15)
 by TYSPR04MB7923.apcprd04.prod.outlook.com (2603:1096:405:8f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 06:26:20 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:803:3d:cafe::7c) by PS1PR03CA0003.outlook.office365.com
 (2603:1096:803:3d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14 via Frontend
 Transport; Mon, 26 Aug 2024 06:26:19 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server id 15.20.7918.13 via Frontend Transport; Mon, 26 Aug 2024 06:26:19
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
Subject: [PATCH v14 23/31] ARM: dts: aspeed: yosemite4: add fan led config
Date: Mon, 26 Aug 2024 14:23:57 +0800
Message-Id: <20240826062408.2885174-24-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|TYSPR04MB7923:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7752d2f8-52df-411f-d49c-08dcc597ff7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zO+aakoeWXIHv3WFq3x9fTGLKUTQubxfIURZkR7Q1nAFuPf4hymOOzOLyD/d?=
 =?us-ascii?Q?D4V7xrcYW4hHBfYQdGcSfHzlUxVHUj4Ml6ymjhLwULCBRCc0eeL1BLqxOjoR?=
 =?us-ascii?Q?eLX3Q7b0GRnI3YyOltczikAL5Jcq0dpkjAS7ch9t4WGP2DEBCgA8+Li8ASoL?=
 =?us-ascii?Q?DW7f34Dv8nR591kC0RGD8Cft8BzMFdERPUpndlyb3TaWUd05Y4YwTz7hF50t?=
 =?us-ascii?Q?fkDjXdLAaYKFp2YMl5qfXGAifCQUQxmOfw5BQUgSdzVVr7a6sF0FomIeinar?=
 =?us-ascii?Q?nwnM5NBnAc9BRz6Y23WybsblB01gNEfm0IIa0FniQwfZALJ4Yp5xORA0nUkk?=
 =?us-ascii?Q?vI7WokouDdIY7o9mjJs8SSg5MVIuHeNpHuJzzqsahNh6b0HjC51eL2G18xFK?=
 =?us-ascii?Q?IK8cK4PZ8TPNKKSTKGXpo1aDVD97d7dSYH+P+Me5qYF5cVjkR0K6saWLR57Q?=
 =?us-ascii?Q?Xyv+3Cmg1TRuh6Zublbw6Ff2ADu2HZYhbFyZK2l5/JfSGEbPAgD17FBdvxk5?=
 =?us-ascii?Q?ihZ1VuoFqI9k4oBjCBeuG3we/ufh74giQaaYiFgysRqOeWq2pxTfDk47WD4P?=
 =?us-ascii?Q?2jW5rnn63uEANXSIyn1dGKx2xi8SRjA+JJfzFDU1Um9HZ4vsTwNMoQOpjl57?=
 =?us-ascii?Q?t2qudHxxPx/+dtKwY4KX/7rhFWaM7xzTTQkc05KokVZpbztiXlMbnQVpP9Aq?=
 =?us-ascii?Q?pGikm8Jl2aeS6pI0zxjR7I8qhcbtZ9TX7EoElCq1AkbBOJgYrDpmLO4HV4gt?=
 =?us-ascii?Q?kFp3oatEqo6VvuZBeezOSIG7jyMN3hslwVNPaEfBiazAVqCsGaSrMMO/yGKR?=
 =?us-ascii?Q?NpPUBM20ug30TLMlP2j502HTlnbVp4u6PVSpzmHVFzJoJ89Y7ChDB3pof2xG?=
 =?us-ascii?Q?3Z3LMBoNHhqhw8EPl06xtRo1hwIlMz3nSM/XNbOGywodYFX/Dj4pjYlf1wj8?=
 =?us-ascii?Q?QwT0AD02HXoQuv9uizQ1fF9oUw6MJA0wfrMq1gUBz0kSAMgqJTJpZI7mhBxU?=
 =?us-ascii?Q?Zane9XcyGsUEP4i91gR410Y5YLoV3UGOsZgi6iPbAYNPb2Rvieuva+hfOKah?=
 =?us-ascii?Q?vYn/+rAhkMvkap26NMPHFrohfXdjzm3BVluIc/ZMWAfh4GX7ChnRdvzLGkP8?=
 =?us-ascii?Q?IijG1Kmmk6eIH1lWmX8yW1esuO7cPQKl5O7VfshH5xPcWBUpW8cw1W3K099j?=
 =?us-ascii?Q?APW4mo6Yn/0OnrL9iPYhuNte3lPPJCjSFsDfyBY7odrPjbSJqo4SbDktBWCW?=
 =?us-ascii?Q?La8xze8FKo0BcydD9fJSPVYCaiC0rfRsmneLIIeOYHvfd/UzPYi6Cyp+w+oA?=
 =?us-ascii?Q?QWyfKWPUa1AckTJkMwQjS6xCy5AjJxVFRETbbbZHL2oWw/H6bSW/D02ascBc?=
 =?us-ascii?Q?6ZXK/oiDlKdLrkp6M/iJzOxd7ba2xFlbke/X2XxKfC+pvfM8bLs8qu/MynIL?=
 =?us-ascii?Q?yRCn/zwOWpkSBePIFWHEi7mGa2HABhJ1?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 06:26:19.4553
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7752d2f8-52df-411f-d49c-08dcc597ff7a
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7923

Set fan led config in yosemite4 DTS.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 152 +++++++++++++++++-
 1 file changed, 150 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index c940d23c8a4b..2f4e9c5edd5a 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -75,6 +75,154 @@ tpmdev@0 {
 			reg = <0>;
 		};
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		fan0_blue {
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio0 4 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan0_amber {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio0 5 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan1_blue {
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio0 10 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan1_amber {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio0 11 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan2_blue {
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio1 4 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan2_amber {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio1 5 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan3_blue {
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio1 10 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan3_amber {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio1 11 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan4_blue {
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio0 2 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan4_amber {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio0 3 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan5_blue {
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio0 8 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan5_amber {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio0 9 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan6_blue {
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio1 2 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan6_amber {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio1 3 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan7_blue {
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio1 8 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan7_amber {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio1 9 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan8_blue {
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio0 0 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan8_amber {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio0 1 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan9_blue {
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio0 6 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan9_amber {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio0 7 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan10_blue {
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio1 0 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan10_amber {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio1 1 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan11_blue {
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio1 6 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan11_amber {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio1 7 GPIO_ACTIVE_HIGH>;
+		};
+	};
 };
 
 &uart1 {
@@ -1198,7 +1346,7 @@ eeprom@52 {
 				reg = <0x52>;
 			};
 
-			gpio@61 {
+			led_gpio0: gpio@61 {
 				compatible = "nxp,pca9552";
 				reg = <0x61>;
 				#address-cells = <1>;
@@ -1268,7 +1416,7 @@ eeprom@52 {
 				reg = <0x52>;
 			};
 
-			gpio@61 {
+			led_gpio1: gpio@61 {
 				compatible = "nxp,pca9552";
 				reg = <0x61>;
 				#address-cells = <1>;
-- 
2.25.1


