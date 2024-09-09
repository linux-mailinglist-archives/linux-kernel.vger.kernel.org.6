Return-Path: <linux-kernel+bounces-320512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CCA970B6B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 03:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370E42845A3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 01:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B88B2263A;
	Mon,  9 Sep 2024 01:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="hEaPUO7X"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2057.outbound.protection.outlook.com [40.107.215.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466A7210E7;
	Mon,  9 Sep 2024 01:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725845891; cv=fail; b=ndVVgUsWTeQlpsVOsaaCEeyYgKrmBjB7d98/TYbPbPZBBLaiCAX5n8MWwokUyFbioPCkYAu30fupZ1wxY5YUSbAl0rZDM1JVqSmS/rLpu5rTDJsOLkQ01nLtlH4RBuen/fjuogJyMLwjtlLptdjPkDhMmPiKn8VbhMYHT+yZmFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725845891; c=relaxed/simple;
	bh=HAgJNmgwDv5jtPx52LRROkSk9Xl4PlmluzXmx8sA4hg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ok7N+BfNvEx/onDfIbOeJkBVvml0D/5vxwezfQTNQzswUUDo8m+KpGWOW6cwSJNh9wc3pNaiT8FbeqfrTF2ACCSU1MEEaUQ1qftikKV27dFSo1HOYYFrnQ8RJSRLvVUX4wgJQ/WPQag8MK6eSdQhm2FjXMXQrombHBxoMt4ZjZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=hEaPUO7X; arc=fail smtp.client-ip=40.107.215.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJk+6OOh5lp3v+kuLwlQfwt3wYz02p79Z1j4JELQ+hbAH3W/o2Lv7PLNLTK8bDSeVT9MIlYaDmZG2so43VO2WV5XoHPG6aeM7ZwDXOvZAyHCnUH7B7v6ZZwXIkyf+dQ1L15T/VA1INCXNnL8sIvP84LyyC6115BUkbh1rcN0f4k+4XB7W73PSFX5yz1kevY/0wwpTrikSQYPwaeWM5cozpHT4kFcVgCZ7tgeN+d56K4sLYBCH+p5j9OEsGqWxCRD4IVC5i6QIrY61GY4DRMZPITZYEqiU0zB2vrNmU7F1U1IVeQFT2WeZV2mlw4cbE2WhJNimyhy++ETNZuvb6bt3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5zP2+SdO2VuN/9VDpzOm7YZo0yhXjxAtwchYJ8fTL0=;
 b=e4bZFxN+s1V/zMHsjJfaULbd3flqFfiI46tonYRBaO6HjDiP5IBXTeWHgM5kCuD7pzXS0+pu/gDF4GI/jgWt+jQn8ZHI3kl2ypQOONkvlvHq004UoQH7w8QfbzSAZ2HrVCmopsxfHWEqxORO1vJt4Ow/MUPxZ6YRNcj3mni+oeNy2ZMnIKmEyaJloDXuEuY4V8XA9Zz8FEMIJtd9GLp9UnG0JRJBPI5KSDN3fh3Ezbu6WCUOs2rghrFbtTa11Ql7myn9XcujPX3TXVH5eJYKI9+2G1MSQIZ+lezjebNsgktCpi6S5u/Nv3+fhouyS9s5dfro/gZ2D7aHYPeTKUQHbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5zP2+SdO2VuN/9VDpzOm7YZo0yhXjxAtwchYJ8fTL0=;
 b=hEaPUO7XvquKGsmaWj/DWv1OWPI2kpnl+hc25c21WJjNqDMSkgwN+itIfrYTdMhyyeraBi+NwdyVmKzVe888hOtcTYflGAT/C0G+SYbCFIvMIkMQ6vMQ8X1zTcFC6LXMXhi1hHG0+bUTcDFrGRrJkFxy30i9o6QyJIRmkCZxww/HgIRgkwLdHbOh6DKzVHk8hPS1cl+ESjAcp/0XNKy/RD9RyKfHd0YfjU1vBX0Kx6He5BIQvnIupHDQyjACv8AzvOpoZCCI9ET1/prGTi/VEjuzmNqoI+hf6AXphCqMrPruC9Htw0cj+AhqTR+3VqtEcvW8mRmtvlbgDCq+lv77Xw==
Received: from SG2PR02CA0006.apcprd02.prod.outlook.com (2603:1096:3:17::18) by
 TYZPR04MB6569.apcprd04.prod.outlook.com (2603:1096:400:26b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Mon, 9 Sep
 2024 01:38:04 +0000
Received: from SG1PEPF000082E3.apcprd02.prod.outlook.com
 (2603:1096:3:17:cafe::ee) by SG2PR02CA0006.outlook.office365.com
 (2603:1096:3:17::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Mon, 9 Sep 2024 01:38:03 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E3.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server id 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 01:38:03
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
Subject: [PATCH v17 3/3] ARM: dts: aspeed: yosemite4: add fan led config
Date: Mon,  9 Sep 2024 09:37:44 +0800
Message-Id: <20240909013745.3306365-4-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E3:EE_|TYZPR04MB6569:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3bb5f608-7d0b-4417-0b70-08dcd0700c19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hYNdmcqP2tw9LQo7TvYl2bd/97xcyaOhJtMklwAsBLMwXTOyTq3ucMp9aOr9?=
 =?us-ascii?Q?HNXgmBag9fo85M2Tf4XJeHlafKEykxzSNSLOsfmhjVnWrLt7AuTo0kub2Qxk?=
 =?us-ascii?Q?A0d9xvXcxo+oEX1N9tKxaw3bbv64kIQl57UUDD+tKQxLV0RaTJ8+MMzAKUif?=
 =?us-ascii?Q?sI4cVTwQ/o71Wv6hKdAYDiTodc7EH8XKU9S6+cZCVxCUI/HuzBexmUnO0kpC?=
 =?us-ascii?Q?oPQZO1mp2gVYg+OXKFiDxPvPUbAnOMgjyGzAdVSBC2VRh6Pyemh6nyMDsyo1?=
 =?us-ascii?Q?rQTYroiLIiTnz/NWMNtXr+tGPB967KedcNNXnHjsx5+4+Db6T6Wb1I8c5oCd?=
 =?us-ascii?Q?rBsZ99F8p4W/2v9dClJOW0/w3OGziY0tXHs+C5x0V91VmwkNFWCJGHfJdVlX?=
 =?us-ascii?Q?kNnKls7BtyEmATlxm45ybBqS7kceEBMcZT2D0keriq/q7A0+yK2UW9AYqzVz?=
 =?us-ascii?Q?DAP2HHYBMN8qeeM0p/Jn7SO7qiN/8uV8NUjlIUFeprbUOIbRw61vejeUYE9t?=
 =?us-ascii?Q?wQk9gahVNaFSgQNjwjLr9nAiDZVVxZvyyFxM56KBwqMhsDZ/wSjJZqjKYT9M?=
 =?us-ascii?Q?Tcriv7Uf30Kn/WN2gSdQhbEOaPFJevEQmQz8uThCH0gSMaJHRx9xX5y3wv1A?=
 =?us-ascii?Q?Qq18BwAayk9Mvo4V4xPAUtAwrM3a1/GtpHuhyR2g0ZTMxw3VF4cRPpiYP6rZ?=
 =?us-ascii?Q?vIGipWXbefhSrUjj3WJw8FAfHcZjgyEOMWaMlkM4FYT864gIS+nt9dtOf2hn?=
 =?us-ascii?Q?3fWa72PuGmbRDGuA6xL2v2xjwOVmvXcjwHDgJp6p7pXRtNhSikktxAc23t4q?=
 =?us-ascii?Q?e7NkRTnstmEjpH//0SX5itp425wdjSNzKiqhClufMbqdqfKVdYUY9rMtHGP/?=
 =?us-ascii?Q?aqu4yh5t24iE0vJ+t3p8drpieC2OyDTIfv6t4v9t2Swa1lPVmT9zqTNNcGbs?=
 =?us-ascii?Q?h72rIFQPFM+rrIOPzb6V233ZyJxAW5Yg4SUzLsCxJWmn7Ty7thm/vN0O5yQj?=
 =?us-ascii?Q?N/CERasz8JfW//AlZUAIpBEPB4I6YME/16YuZ1tmu+0qHc8mRkd3IfqB/Rg/?=
 =?us-ascii?Q?NoyraZnvTRKYmlRoeAdEshy+RySnBBki19ZyibXgaFG+JyR9f3mqUeY6iRI6?=
 =?us-ascii?Q?jNykfMENamFnXNtPkyL3wmVB36O/rXxtD9KKEBbzZrgucdoFi8vIMOgU3CHg?=
 =?us-ascii?Q?7/gYpWxeqhaS138iGDsAO0umtbxvkXPXuDWYxy3G4Elk5E0xXz9DcfHtEXb/?=
 =?us-ascii?Q?3njW+AE79u6i1ljJflRHr8J5aYxSe7sJ4FTfvudaeWtcN0y7+6FR+y0H/XQU?=
 =?us-ascii?Q?jTx8ji+/i8JPcOi/Jyqj2pqlin+TQymCAoJ0MQQs+gHzUUdI9RAbjUh/UMFV?=
 =?us-ascii?Q?CAgp+wzY/zjr2KexajVjNBmNShOVLmTql0rSKXq/THYKydWDDl1ans7mluEl?=
 =?us-ascii?Q?x4s+TcncpFU2JeJI3ee85X1ZfW05KriH?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 01:38:03.0306
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb5f608-7d0b-4417-0b70-08dcd0700c19
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E3.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6569

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Set fan led config in yosemite4 DTS so that BMC could set different
color LED according to the status of the Fan.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 177 +++++++++++++++++-
 1 file changed, 175 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 9ddeccf650cd..6d64d87bf144 100644
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
@@ -822,7 +995,7 @@ eeprom@52 {
 				reg = <0x52>;
 			};
 
-			gpio@61 {
+			led_gpio1: gpio@61 {
 				compatible = "nxp,pca9552";
 				reg = <0x61>;
 				#address-cells = <1>;
@@ -874,7 +1047,7 @@ eeprom@52 {
 				reg = <0x52>;
 			};
 
-			gpio@61 {
+			led_gpio0: gpio@61 {
 				compatible = "nxp,pca9552";
 				reg = <0x61>;
 				#address-cells = <1>;
-- 
2.25.1


