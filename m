Return-Path: <linux-kernel+bounces-321194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D82139715B4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B493B21ED2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135521B5836;
	Mon,  9 Sep 2024 10:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="nlznQLXv"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2048.outbound.protection.outlook.com [40.107.215.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2FE1B580E;
	Mon,  9 Sep 2024 10:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725879281; cv=fail; b=JTfXIGf2HQZRzAN9jAv1jp4SxnZF7wU/5IThcSjN4xQ0/+ZDAQpRQmPHo9nIyh8qL8DVKurAm+gHbItmPwfgO1gj57cnANBjnB9gyovcrz9tKZhluPcPRyyreJdUnZOHMIJ9ShoYgyHdWuccG5PGL76bZhhXEn+n8PIiNVz11II=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725879281; c=relaxed/simple;
	bh=UrQvg69WKZZRPbEAp0Jl0u3tS7wnnDOtSEd/t00srFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ri8pOTlE5m0KK1d2PRD9LtXX4Ik7IWwji74zHsJP24ubX+EEuLBeO02oQTGzSoz79Af/zid/0OQJfHwizUB0u8CuXK9YPvrOLKaAC6oAP86cZMIeF0FncXGGYJDSshWCyECW5KsNxP0dbhY9opXbiWHpax0Ahms1csarQ15wuWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=nlznQLXv; arc=fail smtp.client-ip=40.107.215.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mOQK57rp/aIY2gRsVGI5OELoY0CqcW/I6t9p366esDDC6RkY54Q6brLozeiYHl6L06keI9kJiJSZvNw5aHh7/SLwijsbRmFPLPw/CAk5IcS+5AZ7ijRkMzN8aYN0p49RpPijpFR1zCWkmkan8FTQUpcwuBcS5WzoGKuO4hJhAwtzmuukma0YDC+4xkeSm/qUUJBD8fqy7SRcd//SGUTryQqx5ubr3m1XmmIOhw+H7fVDlXKQaO95X+9Y+VOwAN9R5X6/ZMEBnVyiWwzE5tu5006+z4KJ6vplscoFzvnSuykeZTbGachQdDPVX54WMNIj0MSHqG919TTjmo4Y25Te0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzg41NePDkge44MLYYd7mKZW1SvxZnqJAzXlq5UwtC0=;
 b=rWkeW1+y3yJGmxz0AXdi8Afm24zRnjwYpGONEHmCqqx/W4Yv+YqBo7OvE5iKyd1vTWY+u6uTZR2MMBkUnRTDCcr3NZTRHRcLS4KFKIILsmm+e9Uyq40aLATCc81+B6w07PLrHNtT/NCQAmetFwJJNSIZFPnWcTjziSmoFNLQb42c8G9VAvz8cuBq6NmyydG8Kvrq6En4AdG5c0tseAKS/nR8A4+fU03N4mAG+nWXvem60qyGckE/qQNpYS6SvSeT9AphUpxtGSVptCGRsJCR+Ja5bZZHvZXDyfmDYmNkEH0UQs3oDvUz7pXsfFubmaHluLTMukm7PbCSbF1W3LHOUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzg41NePDkge44MLYYd7mKZW1SvxZnqJAzXlq5UwtC0=;
 b=nlznQLXvjP6UYlIekV2HiMtQo8/LkWZVCzanLXdSIkjlNlzjMx4d6UXCQfcz64T5piUz2spN1rFsCf1/oH9cty349j64DLbR6378oaQz25SKASjqKSoye9+H+v9EgE91rhjjg/IcY81GQK0sOaVWeZMuRjgYG78y5O7gx6zjHSya5H9QUciX4LHfROIT2sjac6VrMSR5h2qIj+vsIaUwsVY1Hbk8e/ykSAk9zcA8QGWTBx6vHgLc3E6n9dqs7wfj7x0VM0CKo7JQBERoOAhq5w7OHWsr3YjBLcvwzt3iIWYTdT6L11N7uGgZzyae+Dh1Ov7hoxMKPErKC2FS1Fgrgw==
Received: from SG2PR06CA0212.apcprd06.prod.outlook.com (2603:1096:4:68::20) by
 SEZPR04MB7339.apcprd04.prod.outlook.com (2603:1096:101:19d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 9 Sep
 2024 10:54:31 +0000
Received: from HK2PEPF00006FB2.apcprd02.prod.outlook.com
 (2603:1096:4:68:cafe::f4) by SG2PR06CA0212.outlook.office365.com
 (2603:1096:4:68::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Mon, 9 Sep 2024 10:54:31 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB2.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server id 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 10:54:30
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
Subject: [PATCH v18 3/3] ARM: dts: aspeed: yosemite4: add fan led config
Date: Mon,  9 Sep 2024 18:54:18 +0800
Message-Id: <20240909105420.441607-4-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB2:EE_|SEZPR04MB7339:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5f388f8f-4435-40ec-fcda-08dcd0bdc862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3nBnj19E940faTzbITKIseCdB6+ErvHVTTc5SAIMK3Gp4BXLhIqurxe1L0NM?=
 =?us-ascii?Q?jdpm5wHWzb6K1BicxUqP2bk1RJq9kQEIWaXMRy1e/2dGeO+PRA7rHOAfsJak?=
 =?us-ascii?Q?ePsP+j4xVBse2KRGz9nhpNf9bl3Quq69PEbh2Agsxizf2tX7sIDKa7DMe9rr?=
 =?us-ascii?Q?oezHKHSxE3hlZZpNulTT95E9HKN//2iM9+9eib4tMPZQCgrtIVWton9snrGp?=
 =?us-ascii?Q?o/8ZLGHvWHILWppMpk7sbp3bSyXzq5v+UI82k7wl8+UeF2av95+CN2tNqLf7?=
 =?us-ascii?Q?mpihKrrwQSQ6kZoJffiH4nl5n6VTbCv4K6Fo3z2AF+x6XXkhewmZbn6QIhGa?=
 =?us-ascii?Q?atzSff8z1KDOJhPr63ffBxOMJIT7PcZNHrMv4gwstGFGahz1GwH+0rffYwsl?=
 =?us-ascii?Q?PDPZdqe9gRuy7p9uhr57/v9OLg+MywTIHqqelzSRd2s4W2aTJhHtZtd7L6Jy?=
 =?us-ascii?Q?mYMI/kTgpQXH/8LfWDvQlVMz7rEAObISWpofLZl28k1GZdKwE9HuSuDw2aBX?=
 =?us-ascii?Q?xN5CAm+1jvh35TGnqoYVfp1lSJzR/rtj4AIV9k04ocu7qlhMCSC1mP9vYS/1?=
 =?us-ascii?Q?rk4GiCUhfPEbww3VDdZKYUkXJ2kERhAOq/+Ke/aIeZ7w6VuAAZk5l0Db6g2i?=
 =?us-ascii?Q?h+qwYV5GJSzS3adtJUoWXcTq9zg/yyY535I5LSL3CuFRwvYk/bg8IZPHsR3S?=
 =?us-ascii?Q?JCZYhLoqwH6II/AvwELRVKS6kZTpMYZurrfDUBVfQm8m3MTVewyMwT/5imFn?=
 =?us-ascii?Q?2Qk7JM4yoMvGc0JsTRrwRyF3S0dt78qQi1ql3wm0kWe6kodTyvYgX/VtUxC4?=
 =?us-ascii?Q?AP/l2YueQ2LqV7BJWCmv3FTSjRVrL1ZQkt+Mipro26Qbh47IukqOee3L6heq?=
 =?us-ascii?Q?Kf9FFOAfdSiD/vOzx5AgbjfHTWr3PomivttjP1MHfDIsHQBX12Qoe+bVJ4Jg?=
 =?us-ascii?Q?K9T0CX/uIC7NWpzuzlcsgrMz3zqOxMU9djdn3TZhMscC32rtrXZxAWwtxEf5?=
 =?us-ascii?Q?o6qMd3OXUFLlmyECySfRjdyjz16bPt6Lo0tnDAvXMbaVYtxSWNj6mCncxYIA?=
 =?us-ascii?Q?pVkwvFRPEdLWd1G5a3W5VArUFMoaXLom2uKcrO020yzXjBUNbkiY3K1pwtBy?=
 =?us-ascii?Q?iYfpgu3xgjVY/w5e/LmZwtDWX3UGNfbiZAY2ztoiFuVOwJz3lcRh7H8488PK?=
 =?us-ascii?Q?HDi0gVHBHSh3fyshkGY2Otso7Ya6vAPwa28r4lxw3LznQdUYMKDZ4/AXEfsq?=
 =?us-ascii?Q?59Lis7vql829HpmV9GukIynCNXMRbtPVm1VuXN4Qpjvvvs7Lc6VTBrRfbL63?=
 =?us-ascii?Q?YUjbspS4Y8E73bFBZnJB7RzrC0bpi00THaIq9q7f3iDM5tF/zSVIexoeUPaY?=
 =?us-ascii?Q?7752i9TTKRdbkm5YNbDm5fzOcbBpdMTDEGVI63dVTJ/aNSWH2z8rc2a+pC28?=
 =?us-ascii?Q?HOJY4yNYysdSE97MBAnSV2wxYQl7IkRT?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 10:54:30.6750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f388f8f-4435-40ec-fcda-08dcd0bdc862
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB7339

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Set fan led config in yosemite4 DTS so that BMC could set different
color LED according to the status of the Fan.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 177 +++++++++++++++++-
 1 file changed, 175 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 7898c4c94b9f..5399fe22e3ae 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -4,6 +4,7 @@
 /dts-v1/;
 #include "aspeed-g6.dtsi"
 #include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/leds/leds-pca955x.h>
 #include <dt-bindings/i2c/i2c.h>
 
@@ -57,6 +58,178 @@ iio-hwmon {
 				<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
 				<&adc1 0>, <&adc1 1>;
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-fan0-blue {
+			color = <LED_COLOR_ID_BLUE>;
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio0 4 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan0-amber {
+			color = <LED_COLOR_ID_AMBER>;
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio0 5 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan1-blue {
+			color = <LED_COLOR_ID_BLUE>;
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio0 10 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan1-amber {
+			color = <LED_COLOR_ID_AMBER>;
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio0 11 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan2-blue {
+			color = <LED_COLOR_ID_BLUE>;
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio1 4 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan2-amber {
+			color = <LED_COLOR_ID_AMBER>;
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio1 5 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan3-blue {
+			color = <LED_COLOR_ID_BLUE>;
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio1 10 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan3-amber {
+			color = <LED_COLOR_ID_AMBER>;
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio1 11 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan4-blue {
+			color = <LED_COLOR_ID_BLUE>;
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio0 2 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan4-amber {
+			color = <LED_COLOR_ID_AMBER>;
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio0 3 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan5-blue {
+			color = <LED_COLOR_ID_BLUE>;
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio0 8 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan5-amber {
+			color = <LED_COLOR_ID_AMBER>;
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio0 9 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan6-blue {
+			color = <LED_COLOR_ID_BLUE>;
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio1 2 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan6-amber {
+			color = <LED_COLOR_ID_AMBER>;
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio1 3 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan7-blue {
+			color = <LED_COLOR_ID_BLUE>;
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio1 8 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan7-amber {
+			color = <LED_COLOR_ID_AMBER>;
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio1 9 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan8-blue {
+			color = <LED_COLOR_ID_BLUE>;
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio0 0 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan8-amber {
+			color = <LED_COLOR_ID_AMBER>;
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio0 1 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan9-blue {
+			color = <LED_COLOR_ID_BLUE>;
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio0 6 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan9-amber {
+			color = <LED_COLOR_ID_AMBER>;
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio0 7 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan10-blue {
+			color = <LED_COLOR_ID_BLUE>;
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio1 0 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan10-amber {
+			color = <LED_COLOR_ID_AMBER>;
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio1 1 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan11-blue {
+			color = <LED_COLOR_ID_BLUE>;
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio1 6 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan11-amber {
+			color = <LED_COLOR_ID_AMBER>;
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio1 7 GPIO_ACTIVE_HIGH>;
+		};
+	};
 };
 
 &uart1 {
@@ -840,7 +1013,7 @@ eeprom@52 {
 				reg = <0x52>;
 			};
 
-			gpio@61 {
+			led_gpio1: gpio@61 {
 				compatible = "nxp,pca9552";
 				reg = <0x61>;
 				#address-cells = <1>;
@@ -892,7 +1065,7 @@ eeprom@52 {
 				reg = <0x52>;
 			};
 
-			gpio@61 {
+			led_gpio0: gpio@61 {
 				compatible = "nxp,pca9552";
 				reg = <0x61>;
 				#address-cells = <1>;
-- 
2.25.1


