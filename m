Return-Path: <linux-kernel+bounces-295265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D721D959929
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64AB52822B3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8EF1FFA66;
	Wed, 21 Aug 2024 09:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="AmLUvcwl"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2057.outbound.protection.outlook.com [40.107.215.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBC61FEED6;
	Wed, 21 Aug 2024 09:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233399; cv=fail; b=dbZZPQXofA2VRoUrUFoXKbzinMJTyjhiwIof8DRTjlMsfPAVs3PAPVWKZ2NwoLYctEI6quXpR2njyI2gG68SQlv9oGzjENJZRhF0LVKWPGoo8pCLswOcoIDKJ6kzMcnglvS8oUQaSy9UiD+EDdog6al1ZpNBwmeoJNX4qEV/UqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233399; c=relaxed/simple;
	bh=008+v/O2Jqnp6k+93ZsuoXW1iys2wSbe6kzenP4szZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XFOQvHrkcZCcfR6/Myr5N2w6V+dEq4eFAfsC/Si774cavqOlTgW59WlTRtvCtXVF2cOa7XR1/l3I5E6V/G+qHlffM/3SKjeJajiAp3oVq4kGSWi7f4uPccEH42YJ+btVAQbLFeeSn6dxeAY3p+Dcx9iP7vN/P2pHfX2MdYXwKqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=AmLUvcwl; arc=fail smtp.client-ip=40.107.215.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MoWYjcgtCCVUa9rpZ7+tpy0hilCG05fgin8PBqxuvh0FNqYls33gMAp0KGksmb4xewxXVJDGVyIAPM2pSc7da5jyUzhW5hMS1nEjlRtgM1HPyYN8z/8QvWiI/QYhCUUo98c3m9NaR7svG8yhiw/+FNk750iYaEolsJuZiQ7V0PgdztuCzEE+Fx+w98Up9f8+xsbOGeJyGmdiUxqMfReebxiloxZalMqjMrb+WdBlrqLZdWhA1mBZmmaVa8F9641wwvMzyNsiYq437UkfWTOwuV6MCvo3SrFOQmQ82cv4xRd0D/Tsxk94HGfeu79Im4xPZLnO7UYZM788nUs5yB+7hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QU+JZ1MSglaWLSUKc8QjBu76ufZkEOMMNsu7ns+mPuQ=;
 b=vy4dCggQwXqe5/gzNvvf7tviBEcXesuIc2s9+dcamhMokHgyCjcZmZ0jezAk3KVoen7zMih4vF96C4Ci0mxpMcrqXZWi/RTRGcNraDZHXqsgrwprao+QbqoQSQo/lUYdYuTqnkL2z+PyRA4Zvwko+xpVdRAYz9Qb6j58iNI/S1BmJl3t9LVhgU8qEjDkEQcKwomPm7GOGvGbgv2T96lX7MPq65Hy2QuhJCcg5c8f3hppmq7ZimtCPhGQP8m302qDlTiBLdSVkYFy43TQ+rDhg6LN87mYOxmGvwmYkdoJCdqWbUBoN99cUjeZmQbah+BzzzGicHCmgEugzBp5gGKlQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QU+JZ1MSglaWLSUKc8QjBu76ufZkEOMMNsu7ns+mPuQ=;
 b=AmLUvcwlFBG4piaHovcdRk+aFOiLgPgblCmFzwysuQR2ENtOt07zXciZmPMdCN0/vHsDuxCWOkg9CztfEqtxJvpQgffu9K1jVfePEOHkrAII14teDAwbmEP85r1XFgZrad0nNTtTEE9ZoqSZVl/Fw9Z3U35AW5C0Cs/FkafVQxZt4h5dsewzscvcxL7IOGD4z/xzQ67XJp0+NGLOSoY7VbRmFy+qztKiaM7gpfQw+mhY2v2HhwuDVbbSGApdcpAUe4OhBaH2LJMBEps8XKIM3wV6oaldy8eDOBoYHh0SzpAXCMlpHZPj1Bg3y/PpxP8JY6GYnlU0b2S7DCgc2OikQg==
Received: from SI2PR02CA0022.apcprd02.prod.outlook.com (2603:1096:4:195::23)
 by TYZPR04MB6924.apcprd04.prod.outlook.com (2603:1096:400:33e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 09:43:08 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:195:cafe::e) by SI2PR02CA0022.outlook.office365.com
 (2603:1096:4:195::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18 via Frontend
 Transport; Wed, 21 Aug 2024 09:43:08 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server id 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024
 09:43:07 +0000
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
Subject: [PATCH v13 23/29] ARM: dts: aspeed: yosemite4: add fan led config
Date: Wed, 21 Aug 2024 17:40:34 +0800
Message-Id: <20240821094043.4126132-24-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240821094043.4126132-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240821094043.4126132-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|TYZPR04MB6924:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 888f819f-bc98-4553-adb3-08dcc1c5a9ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DlE1j1v2Umv+S6GVjALK7sEmEUirnGrmkwtyxMDl1gG5pgg399e9KnKRarFm?=
 =?us-ascii?Q?gOoXXsd9bIDPuWIlVrFEuGTsQh5oLnfOrVNlhGpbdZrZjszoHi1Wjg/C9+Xo?=
 =?us-ascii?Q?EPs2QOq3w5FYjWqVRs3IKZlFdZ5eYTHwFsaDewPUmmmsIjBI7g2ZjZ1ATZQE?=
 =?us-ascii?Q?CcHIBYarkUrtVyplXA6QaLfymciflwkjuGlvFfIt3q++WHKg41Xd//gDj5nE?=
 =?us-ascii?Q?TlYHpC8TSIIEEgXsQz3V2GG5BxgThxsnBCZZvXwZDFahAKcQNftSCy7dQPNh?=
 =?us-ascii?Q?cJXR/ENsh8hddZnYyzgv9EH1UP0TZ/WQtEslo56uToBu1VtYXiiBWVuTwhsr?=
 =?us-ascii?Q?BIcW94OmuuoVQNfZaNeDmTXyjJJRVeaLALVLLf5Wife8+lfEXvGFR760KCcB?=
 =?us-ascii?Q?T5W+Ecl6/8uhVQHlQEq0WEivPuxhFN1dIkI5V65yB/Gb/nQB84aF3i1IPaIV?=
 =?us-ascii?Q?4b5FTFcvH7OcDnQpF6lolDT8dyJlESSuB+b9ppeG/veu9FJNdOhAx4fT8RS6?=
 =?us-ascii?Q?+/3M6vzVVWt+4gMnYC7osLhH9dRVOvzYc1MTKSBpfp/SCCD69Y3GAb+0pSRH?=
 =?us-ascii?Q?ngtDcEg8xyqStQ4NYApv6OmBCLQ85Usm69WGzL/ioDZdlQiFrO+UslgvSJiP?=
 =?us-ascii?Q?6jqUSWNl0aTJrZBjDNSzeH0OIMa/RtZHgVQ0je/HI+8N4egkIt84tlIdYtQL?=
 =?us-ascii?Q?g1331u85fO/hysJKWGCQKhuEL8JxZD997NUlxnKnoL/gUnVQ1ZYx2/mktIEc?=
 =?us-ascii?Q?ngVieKhwcoWVRmsN/YvBSGxZpwyjy5iUWu/YVG06VQ46iZPGh9rDxX9x4rui?=
 =?us-ascii?Q?qHTvOmG35Cc9XIuRlZpY2L0d0k0t0woJDJAF5jM997cWyFe5IY+HouFtA7cs?=
 =?us-ascii?Q?oLQS3xMai33vKtwASwvfyLltugPhsfVvXtpN7nBruLwVNp4nCx7NYp6Io/e1?=
 =?us-ascii?Q?MK6MKT1KltiCT2bFuUDAtOjdhql5U7O8I/aYTR8VZzsraxgf7R4rwz3S6104?=
 =?us-ascii?Q?kOqamepYzD5jGCR3NtqCKmBWj7UkJn3ZGzGUyZl35wC+hot29cEe9jVMasCn?=
 =?us-ascii?Q?38u2cAxzBc7KPUcULB7vpTali1UriHEyuL5/I0aerJEuUOc2cM566bhoIvB1?=
 =?us-ascii?Q?LuYctmLZrI9xhicryYG+bFuz/I4I/553BTQBGKMOYiFHFsnAqVPCyh//2sSR?=
 =?us-ascii?Q?6PJSHS0HZr/WnfqpIZQb4ZAW/yRcaaDRFrEwHpZ4BXmr2LlDao69EZz4KPZU?=
 =?us-ascii?Q?YDJS9KGXcCulX8l2Zw1pF/IWrquxzKDo/fD4mdkqni9h+Uq5o31zv51Idd8v?=
 =?us-ascii?Q?OO3lHV3DP8n+2RUNvqW4C4HhnxFVClYW7p/ajHgejdcamGSZb4G0ggTaSeuP?=
 =?us-ascii?Q?P6QK6u0nSrOz3QSxyJhGMTXkm7eYEpOXNTqAgxvVlkEU2XaKLo4EekDF/m+C?=
 =?us-ascii?Q?27AVJZZxoy7anO4WiONLPrDs30uDt6cg?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 09:43:07.5130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 888f819f-bc98-4553-adb3-08dcc1c5a9ce
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6924

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


