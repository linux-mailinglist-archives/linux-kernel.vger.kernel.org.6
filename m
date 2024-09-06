Return-Path: <linux-kernel+bounces-318517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C0D96EF17
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CACF71F243D2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F381C8FB1;
	Fri,  6 Sep 2024 09:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="wIZq7F0O"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010056.outbound.protection.outlook.com [52.101.128.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3CB1C8717;
	Fri,  6 Sep 2024 09:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725614702; cv=fail; b=mT7/fWK4phUemcB46opUkEJqkjS53nb1wkh74UQ854weP2smBOTtCKamKbSh8MEFUzdIAzipR9EdO8RTymoj1gTz2FHkVDXGuwie0OLuO6KG9rlh67Qi0bXpwIxWHuncx2NDyxO0/jiltuUZEu8Qf9t30q4ILdU0nlcecVwkagk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725614702; c=relaxed/simple;
	bh=W9Hc26/4uptywLQloebkOc5sBxRIKl5GnWLZpZ5j8xY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=seC9dlmfnBii+Lpyx3cLWUYRgBKj9DGkJHhvq8TWucSzLA1fK6BkqURey+KEGMMPW3I2W3Yy7jmeSliTt9vKgxz/V9d51tLENjLNSAjBuHZrMqV0JBfpJIkVd5H9IxL+FSa0mucSPN5hRetUeqE/nfELg7nn+KGpVdtCQTCyZQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=wIZq7F0O; arc=fail smtp.client-ip=52.101.128.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bcrJAlE+vCgtatPlHxecTQxJgcoTN84uymsT021U6OjqCTp3T5xSWu5KuCPOnjyJ9PJKRXY0+1Ujg6FF/Sb67v+a2kfecAzmma6GUArp4ZhiKPx9SFDQd8Yk5YYNIPe2GlFZMBKv3x1g5vOymh5odnQLP83KA3nAM8iwks3jYd23KqqWV4l3MONVQ2HUv1j/Z+1xcSyJ1nHcMP6vOUkh25uWI5retsuTZjcplh8nP7FrCPfi+PHDnRPWJeSftyI+X37Ep/EW8ue0i0Xa3qTdmeaAxI2XKZ6RIInOkXKkFFpzyXNhJRwUrjOX0Chkd2JAiUN7myyxRqCMVyd7NJfJMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JYXMuufNP+1KFHLCDGDnx6vheVaZ9RhKwZf/5q2z1w=;
 b=qyPnQfvEc3DRAku5FAD0Qc+dEZrky26v2CFl0z/+Rz+shvqmjQPPSyUqu2np8bzXKvTThkgwFwEKRWXJBMwwd7/3x0oQ40R8KkaJIX8O2htqiWed2dKMGq/okZzAX+j+PeyaVdH7GmLIMsXc5Teth+4kPq/ljylHjAUEv7anQfKCQmdj6Jh0+SM8ISrDwxHvZUKN4nzsMIbJsmeGtzC+WpiqkqxNdSvR7hBRQ83cpitoqCV24NVD/xQGJcUJWYi2dU1TD0OXfibS5r6cUZgJQEyeK/1zxvRVucuhbA+gafRXdhCyJaf8Qz/DUQGpe9a5wlArIwviOTdBHDVqp8mURw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JYXMuufNP+1KFHLCDGDnx6vheVaZ9RhKwZf/5q2z1w=;
 b=wIZq7F0OLjoeYgY674Ylz1+YHuHMxQegf8WvxzrFK7wRXAwWYU1K0YrgyuD71UV57CufT9ooRMkCrNgxKoTkI/g5Ad88mtiGgfgdGu8mEf0buZfS82BmZeI84UcgV5m4T/kK7XSfdO/I3W4TPKcIPH0YstRkrqVqecUeRyOmG781Q9kqVY1XZIRtx3bw987NJTZOyFJV2xeJApTMPZOghGWN8waBAa06O/IpiL6qlu9igpIGw0495qcfsQfYrJMwUvW0JSuN4b5JwF+GVzHwKtq19v+X+oa+A5SVlYC04Eo4VshG0A5e+isodithA8CW6m3ciu7agpa73CpG5tRrNA==
Received: from SI1PR02CA0022.apcprd02.prod.outlook.com (2603:1096:4:1f4::16)
 by OSQPR04MB7958.apcprd04.prod.outlook.com (2603:1096:604:294::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 6 Sep
 2024 09:24:54 +0000
Received: from SG2PEPF000B66C9.apcprd03.prod.outlook.com
 (2603:1096:4:1f4:cafe::f8) by SI1PR02CA0022.outlook.office365.com
 (2603:1096:4:1f4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17 via Frontend
 Transport; Fri, 6 Sep 2024 09:24:53 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66C9.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server id 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 09:24:52
 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v16 3/3] ARM: dts: aspeed: yosemite4: add fan led config
Date: Fri,  6 Sep 2024 17:24:37 +0800
Message-Id: <20240906092438.1047225-4-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240906092438.1047225-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240906092438.1047225-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66C9:EE_|OSQPR04MB7958:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 826a4673-ab51-4248-33f0-08dcce55c402
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jwG7dLiNm9ZCd6WWFh7c1EfGs1lpenvUAN/UotDK05MURPS5kdBppGX8NE1U?=
 =?us-ascii?Q?Z8XVnEQy1ONo4a2xeu6QILlb8Fmh9raImtcyX7n/YAu3lPZzXEHqFpUaKE0W?=
 =?us-ascii?Q?tQvWoMxE6GRoqoUTPkN+aegO99xbnA5/9eth3esZ7tXO6pyRdD+yw5FcpoOp?=
 =?us-ascii?Q?iKFxXPnDQCZ/KFRouur9XOy6WrrqZ3EkBeG3/HXHz6yVlBAdnSgHxUobuG2t?=
 =?us-ascii?Q?LLlvxkmgf3n3OK4nS0dAJmm/Fh/iVJZa6TiAhelv/raYRWuVczOCgIkcBSvI?=
 =?us-ascii?Q?QSBUna53McK/8MxJZZrRcw5ecnQIs8qUas8CD+9Dql61akgVyHerJcFmQZau?=
 =?us-ascii?Q?NLVefizDF2cmWKMf3/EQ6GAtZAYoMvr8NNhMfyYK92MGs9w7Lru2qiHFA2cZ?=
 =?us-ascii?Q?nbu967jW1+mso+fdeMy5jcLEuKi96pfglDoePi/fVqxgBO8ZEoBlejqQuNrF?=
 =?us-ascii?Q?d68kuc+vx24HuyJyUqgWoTDRZTb+1f/ObyFxMpyaY7LHU+7K6KwyuYDeSWGl?=
 =?us-ascii?Q?cv9iFCG+3iKswOdOJ/Fh+uMchZlVL3ScJfSq9K2jrxRAZC1rpOOwO5eR4ipx?=
 =?us-ascii?Q?TG/gzyTAgxYdbhZZ/vfp9F44YN46mYSHFXIIO6UreaPpvyyd3FO44VoprOAE?=
 =?us-ascii?Q?T4HBAbvTve/g2zbrAy1O6xYxVnVG3yT19p5S0dCCCLvjdHyBwFtMIWlffrkv?=
 =?us-ascii?Q?/l24OOMVW3WZ4E+UQx3Ov5nkxDlhXSE7GZOc+WC++BHKD0PlUweMdKiyYai0?=
 =?us-ascii?Q?sEgfdponp06vyvH7FtTv4XwYRn56iqB9MmBqzpWUlM8FZ2I2NeEhkmjBxYTR?=
 =?us-ascii?Q?vnn2siMVKQhxtSRm6ILytlQRsMbhsH5z88ujhIGgtASbJegn77AS/ycNnzD/?=
 =?us-ascii?Q?ghEqchN6Xh+Hs+u9fPQ2YIyIT3R1Z3ZaCrSPEgLDoAoTWDGdto4mTBfs+lqZ?=
 =?us-ascii?Q?LjF1CCsFZmTcXZdkEA3c5Z+FA//znoUJKVLTzJNT7m1sQmZ5dbFCNxG6TRD2?=
 =?us-ascii?Q?QFoToGBDTjxqbKWP1i9kMnMzOmgX3F9uaC3xtNo3QRTsctOUYB4REhKMtWOC?=
 =?us-ascii?Q?2Zi+3ChHxU/o1nqv8xUGjguiTwD3XANQYytcwoVGrmgjekosYBTbTHcFs0ss?=
 =?us-ascii?Q?HWqOrPpVsW2LEsRRRVpBMFR9vLjZu+zChOJ1RT1S6/x1QwjyulLQ4V447blZ?=
 =?us-ascii?Q?Gu/+h/aPKi4M3TOqrLo+yCXQkN2JcKYgrgYOV20D0dsuUrnjx9ERxhoEEvFB?=
 =?us-ascii?Q?6TqGeoTHSMR9sePtT7JobmYcby4rMn0K3Smm6zTmrBMcqRq1sbVstKz1BcR4?=
 =?us-ascii?Q?5JcJRyLlRBDOURJxnr5uzEiKV6PxBbBNhtvvs2ZaCGOxu50v1vkV3DLtGxu6?=
 =?us-ascii?Q?FRknp8UxUWh01b/6DpDec5O67qvMSauMWgI1VUSkAvfP3mdwcGIisDZlDYp/?=
 =?us-ascii?Q?YCoIS3rUdBUpG/4+zbAC/1u6APEvoc3F?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 09:24:52.9538
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 826a4673-ab51-4248-33f0-08dcce55c402
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66C9.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR04MB7958

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Set fan led config in yosemite4 DTS so that BMC could set different
color LED according to the status of the Fan.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
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


