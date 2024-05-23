Return-Path: <linux-kernel+bounces-187241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F93E8CCEF6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8CA7B21B43
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B7A149C60;
	Thu, 23 May 2024 09:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="CoiuN4Gy"
Received: from SINPR02CU002.outbound.protection.outlook.com (mail-southeastasiaazon11011005.outbound.protection.outlook.com [52.101.133.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91BE1465AD;
	Thu, 23 May 2024 09:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.133.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716455930; cv=fail; b=TwEoZHmwe5C1KhFaJXJciwjWTUjZ5V6B0WeQuVQdHxaIVzTNGN9+Jhc//0zt2C9crO3l9lW6rorjdLDu5rAei369GONTBZxuHv+fiAfROJdeVm+b4eASE6ywJMfBYGt+v9hzu+sb+bWuxvyfi05Z2BrfJfCb9grzaAbkTvWwzXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716455930; c=relaxed/simple;
	bh=o/9Ke1ciVypCGX3qK4a2fokIUP/ECV7EhUWW6vjuDZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SjPFHFbtrjcSm1GMM4SauAYrOdcLdT+sB78FpiPhzIou893MJVmS0EjHoj8efhx47LJJqtTZzcUr85nP1uRosIz1WO2I1FsnD80fXHCgDvpaEwdpbgP8B8BNLrj3fhTfHdFk3bQVKBNWE3S85Ydwou/lSqoZuh/YXE8pr6IOTW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=CoiuN4Gy; arc=fail smtp.client-ip=52.101.133.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VulbN2o6k86qCy5QBmu4BTrMwo8TreMDYS0oFopb5vqJKyqiuJUFQKGiej5LdsybNKrrsfr32TOK7+hciZHYmk5fu9cvD/h2NIULkFTnk4bGKnOqyt/nKqNdDpl4rXnZ+k1y/mcqN0Ma0qM88bK1Zn621zCdlB2AA83smEXvnQWIk5XlEncBgHmTI737z3AX5RHlW2EDicl6YcZaRHEWFopjoMYNBq8LVQGGeLGgj3aWvG/TrUXii5aHUeO5oTfmmhdyVa7AYL9EfmXTJFpGdAbNlw/RnBmhYVoTWDtCYJR/uLHSo8XQT83vl7ZbmPor85W9RiCWsDWRUwfBlejYyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbK/2vsfBhS2GguN52/kCxQEVmWfjdwDuSA91VpJMzE=;
 b=QsoiVA3Y7PigSFxBTxdfwLAasMy3cNh2eRU8rwtyFJ7RNg1BRt4Oh6Dt4tm2XfBzIMG4INX4wWxU7GuBVDNA7aYGCzgeHLKBlJlgl1RaXHNMEEifp53bDf/mRQw9cZAGgA/VsEEtU5TmCeuv6TZyyEu18fE2BPRM76LtySsfvHT2ZdXX+J/pzj7RNGRwiaqaZ7a124jwwDHuWNBnyesYRAgRyxlgT0I1Achf6AfZsjWjoGIKc71vt4m32TlOivOIsxv97PP2nZ0F9sVadrMmo65qJ0ZrdNlFGSV7L9TLxeIFUvLyrzBsUBfmvcGJSQ9jLuv5x5hR8Y+7Rqxck/NGdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbK/2vsfBhS2GguN52/kCxQEVmWfjdwDuSA91VpJMzE=;
 b=CoiuN4GyabSKBdNQaiv4lkpzl1n7y5X2QRTUcfbS0XlZVObBSTJScRE0BBd3KQ0mMdt/hgo04f7/7F8nzGvM5MmWe+sx28wE0W9yKdQfN2i6aHZyiLQTDri4M4cWm3lz9cw866bxwwF0opKgEDewR3+s2LWyECcgGTKScC0GoMQ80ht7WX4zAXWLwelqV8GM8a++ze6uG1Ablnt4hY+5qQ/OF4hCSBbfVHuDmXaa4y8CxZJRdOS9ld1hKVZzu14Qde4KP3PJa6+YAnwHKSzCXcSm2SI3//S6UNvHJ4y+vBM4t5t2rt363a1g6vWpb+GSoaG+CQq1rTDMjmmFKA4Jtw==
Received: from PS2PR03CA0009.apcprd03.prod.outlook.com (2603:1096:300:5b::21)
 by TYZPR04MB6981.apcprd04.prod.outlook.com (2603:1096:400:33b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Thu, 23 May
 2024 09:18:44 +0000
Received: from HK3PEPF0000021E.apcprd03.prod.outlook.com
 (2603:1096:300:5b:cafe::6d) by PS2PR03CA0009.outlook.office365.com
 (2603:1096:300:5b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.9 via Frontend
 Transport; Thu, 23 May 2024 09:18:44 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021E.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server id 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 09:18:44
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
Subject: [PATCH v8 09/23] ARM: dts: aspeed: yosemite4: Enable interrupt setting for pca9555
Date: Thu, 23 May 2024 17:17:56 +0800
Message-Id: <20240523091812.2032933-10-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021E:EE_|TYZPR04MB6981:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4036b935-5d12-4395-7cb7-08dc7b095845
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|7416005|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?McfIG5LeTc+Zi3G/jge4QZO9jhbQ9L0R7B32F5K/F+WxAb0J1jah1gWwRFKY?=
 =?us-ascii?Q?jstdZnrRuQaVpwYpOF2+TOkQftMX1CMQDJ9+gGFuebiTdXCJ7YJLDqLhmNsR?=
 =?us-ascii?Q?pEkaCgAqz8YF/WCW7BrunzbjeJBnPJL7sA5MZ+fVTyQz4cnbehL45I8Be7FG?=
 =?us-ascii?Q?UM1Adcrw9TXcUijaKSeFSGvT+TJDR95sFWXfkY4KOAiJhkvPoEt44eLhpssf?=
 =?us-ascii?Q?34CPFI1BGcw6cCIJzGIe3wgA/u9T0vDRUdkgKzs9yRHPWqyFbjYmg+ANUStK?=
 =?us-ascii?Q?1klfrkcBtxT3Dxf9/wirBfJFg6rLZqTIqJflnSIpYeI2b2qGEmfv+mwITh0S?=
 =?us-ascii?Q?krjB4NuYfVRfMgM0Ot9iUu0pbH5IN7//KvV22jKObE77L8S0FsdmlJdXBJ8i?=
 =?us-ascii?Q?3taDuq/Azep4USNIYcpFNNJ6gtOaAosWrkekO9zZ/15IR316/KWBM2GJDPmD?=
 =?us-ascii?Q?Anw7D8QiyYn0nHXS/97bZv1qvBEa2GahkQjyg6YN7Z4z5scWlgSjFxmlbc43?=
 =?us-ascii?Q?k5JAnQrMzu6UiHZsffhPXU8U3fjncJnDvy7r38Y9V5Q5PnHpFqO8BNlH8pnf?=
 =?us-ascii?Q?azaUpdTrW0rAixUUZAA0Ewix1FDpPh7gwipmqVSLGHtKPXzXD5RCkMw5LYOa?=
 =?us-ascii?Q?wJBLNj1ZJLDdzdiJRm1kREo4Iz22IyS8zj52Mna2LXQ15E3n9bXgO0UdzIfw?=
 =?us-ascii?Q?IxyMfD6Ik6bYGvDiqvd5Cm3stQMT3/ZmcptxT6Ac5/dALqDun9I3lBA0YV8+?=
 =?us-ascii?Q?D+UCmapCDRH8cLDhSLGY3qIfTuC5l7MbhQHKJpDqTkBvqmJ9QmK3FlBqiTcU?=
 =?us-ascii?Q?yLih5J5laUPlRGoBiL2da15hCmE6Q8Sg3qTr9tU8mWnaGBv735AkyvQxLJYf?=
 =?us-ascii?Q?MOzdMvoYKLle1+F3mh4jLjh2+XpY2RyAgwrfwUEGYEo5Li3isLoLQe6773Nt?=
 =?us-ascii?Q?Ek8fkbCPLlWRZAP0xjpTbDFo3hAKpUZmIAysIkqCqgmCLRu8VyA9s+Zfrwvj?=
 =?us-ascii?Q?0JJqf8ZakSYNJm9eHvVTNJZzX21ux3D458+86p5rlBJrWknX1GkbwVj79fSl?=
 =?us-ascii?Q?uEh2eB2x8ALHp7yD2F92XquTjGPTyem7lmjcfqq52JGfJQTdzC7VfB4Nh9rb?=
 =?us-ascii?Q?6OYiwg21KliJJd2Id2WUzCDHIhgJMVtoTUlbhL2NzGB4UipFxXBRagZ1dOJi?=
 =?us-ascii?Q?WgugULCwe9HHUYGj5m/sK0/484l7QvpbpInNNVd6UKl8kALv10gG0GW/LPMF?=
 =?us-ascii?Q?Oq/pDEJ4cKIdoHoA3siWGcSZqbKGd/AY/U9ybQgJQoLxl+4j+cL3+YtFQUok?=
 =?us-ascii?Q?FRKfBS5czi31dy9rAOj+tZffyCMvu1QTHmIInCRnEK5vRDGXb0aDqwmcpKdd?=
 =?us-ascii?Q?Ewv+dDSrNvwOaiimEaBr9O6pSv+g?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(7416005)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 09:18:44.3451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4036b935-5d12-4395-7cb7-08dc7b095845
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021E.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6981

Enable interrupt setting for pca9555

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 56 +++++++++++++++++--
 1 file changed, 52 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index ee11b3b8e81f..92733a8ecf0b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -832,30 +832,78 @@ power-sensor@12 {
 
 	gpio@20 {
 		compatible = "nxp,pca9555";
-		reg = <0x20>;
+		pinctrl-names = "default";
 		gpio-controller;
 		#gpio-cells = <2>;
+		reg = <0x20>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <98 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names =
+		"P48V-OCP-GPIO1","P48V-OCP-GPIO2",
+		"P48V-OCP-GPIO3","FAN-BOARD-0-REVISION-0-R",
+		"FAN-BOARD-0-REVISION-1-R","FAN-BOARD-1-REVISION-0-R",
+		"FAN-BOARD-1-REVISION-1-R","RST-MUX-R-N",
+		"RST-LED-CONTROL-FAN-BOARD-0-N","RST-LED-CONTROL-FAN-BOARD-1-N",
+		"RST-IOEXP-FAN-BOARD-0-N","RST-IOEXP-FAN-BOARD-1-N",
+		"PWRGD-LOAD-SWITCH-FAN-BOARD-0-R","PWRGD-LOAD-SWITCH-FAN-BOARD-1-R",
+		"","";
 	};
 
 	gpio@21 {
 		compatible = "nxp,pca9555";
-		reg = <0x21>;
+		pinctrl-names = "default";
 		gpio-controller;
 		#gpio-cells = <2>;
+		reg = <0x21>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <98 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names =
+		"HSC-OCP-SLOT-ODD-GPIO1","HSC-OCP-SLOT-ODD-GPIO2",
+		"HSC-OCP-SLOT-ODD-GPIO3","HSC-OCP-SLOT-EVEN-GPIO1",
+		"HSC-OCP-SLOT-EVEN-GPIO2","HSC-OCP-SLOT-EVEN-GPIO3",
+		"ADC-TYPE-0-R","ADC-TYPE-1-R",
+		"MEDUSA-BOARD-REV-0","MEDUSA-BOARD-REV-1",
+		"MEDUSA-BOARD-REV-2","MEDUSA-BOARD-TYPE",
+		"DELTA-MODULE-TYPE","P12V-HSC-TYPE",
+		"","";
 	};
 
 	gpio@22 {
 		compatible = "nxp,pca9555";
-		reg = <0x22>;
+		pinctrl-names = "default";
 		gpio-controller;
 		#gpio-cells = <2>;
+		reg = <0x22>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <98 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names =
+		"CARD-TYPE-SLOT1","CARD-TYPE-SLOT2",
+		"CARD-TYPE-SLOT3","CARD-TYPE-SLOT4",
+		"CARD-TYPE-SLOT5","CARD-TYPE-SLOT6",
+		"CARD-TYPE-SLOT7","CARD-TYPE-SLOT8",
+		"OC-P48V-HSC-0-N","FLT-P48V-HSC-0-N",
+		"OC-P48V-HSC-1-N","FLT-P48V-HSC-1-N",
+		"EN-P48V-AUX-0","EN-P48V-AUX-1",
+		"PWRGD-P12V-AUX-0","PWRGD-P12V-AUX-1";
 	};
 
 	gpio@23 {
 		compatible = "nxp,pca9555";
-		reg = <0x23>;
+		pinctrl-names = "default";
 		gpio-controller;
 		#gpio-cells = <2>;
+		reg = <0x23>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <98 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names =
+		"HSC1-ALERT1-R-N","HSC2-ALERT1-R-N",
+		"HSC3-ALERT1-R-N","HSC4-ALERT1-R-N",
+		"HSC5-ALERT1-R-N","HSC6-ALERT1-R-N",
+		"HSC7-ALERT1-R-N","HSC8-ALERT1-R-N",
+		"HSC1-ALERT2-R-N","HSC2-ALERT2-R-N",
+		"HSC3-ALERT2-R-N","HSC4-ALERT2-R-N",
+		"HSC5-ALERT2-R-N","HSC6-ALERT2-R-N",
+		"HSC7-ALERT2-R-N","HSC8-ALERT2-R-N";
 	};
 
 	temperature-sensor@48 {
-- 
2.25.1


