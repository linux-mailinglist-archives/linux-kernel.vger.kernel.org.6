Return-Path: <linux-kernel+bounces-256997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D92F89373B8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 678851F24BE6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 06:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5662142E67;
	Fri, 19 Jul 2024 06:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="zLC/sPAR"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2079.outbound.protection.outlook.com [40.107.255.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632606F2F9;
	Fri, 19 Jul 2024 06:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721368854; cv=fail; b=aNJE6N3ACQJyOn6q8XYfyquCeqN51daIeOgAUTxRc0evkDPA9CLEON6RtLCGDLfdibTF0es3oDlSlx8VN9p+1qfoQXrwdg/ALwafNdq4MApW/4Sy4y0a78apq7/eBPhNKhvnyheGr2iY4q5i2Z7e5HZgv5odjgKP1yHS8XPSgFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721368854; c=relaxed/simple;
	bh=tJI+cvMH06IzP+7yRCYlxf6+HolpNLWHXcUzE2JZf+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ASBWdhYmqL72VFkjSRgicliQcXDJxN9TlbwHA9g6KSAHSsE7V1ujW5Fy9AsoSjUJtX18VO72QuvSUb1YLgTsMrkUNDL/RA3oVQmpBdwyyoC8LCY9VzrPaC6EfvEAn1YmFDytp+N4zWyStjTK783za+n1QBXSYfSZ9B9UXX/n3vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=zLC/sPAR; arc=fail smtp.client-ip=40.107.255.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E0IkSR6Zp+Ekz9Wiv5jjACcAAT0kgqWi5/xotNPHf7mY5V5fvfjRIOwwB3K+uCx/g//O/Fdy5dA+dbunLVD/BrJWneQRS/1AJLnPmWG6ZcPXlPIH/UzfigCjlPPe1vnVmyDIqKWLQ2g8H/aVr+tmxvUl4Ax2WjQ/iIzS7jA0zqcY60ZqQ641QoqaVSgBzKbPV/TdbI62kGcBYYambRPe67foG80i2E2bAk5Y6bW3/SA0yYMaU6T97s/z2xzljTOJuuhtGYf3Wktk2IBNYZ2695FdllgpX1uLyRDyrBwDC+0agOlQbm2XMnObTCeUvKs/621qK6Ut6hZdzNRl1frzig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pycQ4ax5A44iPL+OokI9fmS5xofqcN1wFPCwCzTXGbQ=;
 b=Bqi0xJ0Evf7IjdJqdKeSBUSoJCYwUI5uLHJvGzcfsTBA/iYOBOlTpQQKThuJREqhKHjttNvWU9FJrebpNPFEBu2uwmc55+1nXi8V0jkeYuPxW6c+HO1ESR3D0QdituP8aseMhv9qnnN7BBCjdZQVNtVqOjha/4hf4HWZqVNfYDD6s8u3Hrnv/Px/MYAmjPfqmuvAb/AC4jPbf47lnbZPyLpZFi9uCjyOF0vNpt1IMx2VZcKY+TOImx9h+VkfTJ87Mj5IAO4sFvAzwu/UgePYCtSEkiZRrqPl5vJg6rDfjTJ60hM3GhUe60dTQlHTPIqOk4vmmpwcMbOQINmF4oE24w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pycQ4ax5A44iPL+OokI9fmS5xofqcN1wFPCwCzTXGbQ=;
 b=zLC/sPART1k5rauIl++sJA2rgIZpWHRn3FYlcE4eCyznPs6+HDmzSePviEgdBvV++DiS8Jt5wpSXsOfJvDFXz1QP5feBVU7qiO+shFXwMLTZ5eAFCwqKQ2z2ICND932drbDKq1ygt5ZhFafVkKodRdVQpskn143gDixT4LOr3Oi6442x4ROR6c9NqEe7vTDukKlrkuB3Je0yg9mClRkhA3LAYwcCdBgigFGn5IxZhRYTeggQ2205uyczRcCKYRoumd4WA1Di+qctJKrnEBLoY6yS//P3MsbTlij4HcoGHqWvRX28eOr8G9Z7IHZva1G0XnzB3rudS0cHS8eEuKzFog==
Received: from KL1PR0401CA0021.apcprd04.prod.outlook.com (2603:1096:820:e::8)
 by PUZPR04MB6269.apcprd04.prod.outlook.com (2603:1096:301:103::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Fri, 19 Jul
 2024 06:00:49 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:820:e:cafe::45) by KL1PR0401CA0021.outlook.office365.com
 (2603:1096:820:e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18 via Frontend
 Transport; Fri, 19 Jul 2024 06:00:49 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.7784.11 via Frontend Transport; Fri, 19 Jul 2024 06:00:48
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
Subject: [PATCH v10 23/27] ARM: dts: aspeed: yosemite4: add fan led config
Date: Fri, 19 Jul 2024 13:58:52 +0800
Message-Id: <20240719055859.4166887-24-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240719055859.4166887-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240719055859.4166887-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|PUZPR04MB6269:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d312e468-d5a1-4503-54bc-08dca7b82381
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|34020700016|36860700013|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H6pky+bb3Z5+FHvePhfom0u2t4AlLCz3fWNE6tSkY7SGelRcY3i0930vm4IS?=
 =?us-ascii?Q?0kKRtJeU66iy/ZeA08QkXHyY3+cypMIvAGJVv2YEsOW+BOEgmCRxtRQ6ZcBR?=
 =?us-ascii?Q?DTCerSXVXSHHFpJR9jPDIo1y7qzAdJONBz+EtS39cdmU+jbEKiW9+hHq2QOl?=
 =?us-ascii?Q?tI3JexkPlCSLUnMsv3/5OgN06Y4yM27tTG4vFibIwaUipSMjPUOjV+Gu9V0K?=
 =?us-ascii?Q?rNnAHDi+E70JaZKeBWOFGOHtnIUrkcvLetdHdvo1iS1PvHPWDkgIEgEKxC/z?=
 =?us-ascii?Q?AV0qBS+DY2I82ScBIyvc1hCcuB/MjK89JHPazT2BEiuw7M9+4d6zsL9UtqPS?=
 =?us-ascii?Q?yEpHBZiHh3zX8IgoYCsM4itgCl4kuuDHlkW+juwrfpTBBhUl5DVbSVx5zD2F?=
 =?us-ascii?Q?bczn7h7tN5GDWhILBW0ECHVPbBP7rXu8dYwEcz4BfhLrBtYy2Y9fvKwO1SBm?=
 =?us-ascii?Q?4ibLRvoHjOyYOiCOLDPs+dEhBcJMFPcjMkDIUdfb3nZg31QRFxyUEb7LGFXN?=
 =?us-ascii?Q?709xIOZGVPhk7JosqwKoymsUypm7vEnxazMnfzq1YS6n87E9/JyO2by9OLpb?=
 =?us-ascii?Q?Kr/biLldXAy7KK6aqF6qQvL3WFiZ+ykEU04LYYTHEkRspa4kL7VinDTRO9ct?=
 =?us-ascii?Q?435bANMgestRz6Ysb0eom3XpO3+pHx+XzmjuhKTGFHhM0QikWPQgapy5Ovh7?=
 =?us-ascii?Q?0C8raVCecPLWAH4YxxosDdK3aubGwTI5XIdIlh2POrGBqP0TmWJDSQAj26Lp?=
 =?us-ascii?Q?hF4lXdkWIdHfRFn+EYFkW8cyeVJJjBBv1lkGlFQcbqf3Evxm0BiWQ9ltKZU6?=
 =?us-ascii?Q?KwbfIqmpTRzXQkydGgqvYicoXgzmq9uGOx0+xu7huafTYHdrS9fsWmXHrKm2?=
 =?us-ascii?Q?ErqIuCOY8tCIU9m2qrPQJXo+ZPNzfAZa5EFvuLEKfAsXnrZmAczuBxnxaYzn?=
 =?us-ascii?Q?qNCewgYkXva7VaaHvvjkSRP6L8Ty2VcT4ys+4LQfcqWqu4hwH66hH+JS5gZN?=
 =?us-ascii?Q?9F4B4hnAhCtQoe8ZTj2khD1XdLiw3LbYZ1NNwswtZWVbCS5YbyGJ+dDpTKE4?=
 =?us-ascii?Q?Ccdc1J85eftWDnJrhEk5ikr9dc+6Bk72sbZvLUvsxzQF2L2V23Mwc8G4fvcB?=
 =?us-ascii?Q?q1ChfG0QGkUSrxsqjcOTaLBl+VoEhSpohCe9FgApi2NbKmn4RsF3Ls3qamM6?=
 =?us-ascii?Q?ckg3VxkQvuJ4VzfF/tVightFYnn5xbGoUSFJ51zukrtZkW3vAZVUDvEwx3d9?=
 =?us-ascii?Q?C0ZZdbNSI9Rj6O1z6Dnotja4s9oBbGJEGnYZRb2s2g8XAVI490Ximhd4Cc+r?=
 =?us-ascii?Q?kVKZg8iAaSjxfwLLVDsSK1jYXkH7OhGRrCqMM3xZHuHRF31hp8SUtZAlqtYM?=
 =?us-ascii?Q?QV8xErpVmH4PvQm8kSVYoFz7+kB0Ynz08CJhsUaGhjmKsRNbmrTPv0q6wyU0?=
 =?us-ascii?Q?fXnrqqV6ew5lyisjU3iNOvD6hlU3Wpc3?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(34020700016)(36860700013)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 06:00:48.8142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d312e468-d5a1-4503-54bc-08dca7b82381
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6269

Set fan led config in yosemite4 DTS.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 152 +++++++++++++++++-
 1 file changed, 150 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 21ca22281ef8..2cbb210ed53e 100644
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


