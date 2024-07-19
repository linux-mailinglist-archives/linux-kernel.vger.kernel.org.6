Return-Path: <linux-kernel+bounces-256978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0D593737C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22A8D1F22901
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 06:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F3856B72;
	Fri, 19 Jul 2024 05:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="TgV5e2rk"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2066.outbound.protection.outlook.com [40.107.215.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE6C42ABE;
	Fri, 19 Jul 2024 05:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721368777; cv=fail; b=Y6GRGmfJ0E5z9kxPYlOcUttIbWxKQ6L/ZbfXoP5QAemiz13MOarG271A1C2BpDlJHk5SjPjqf+ishpuPHzS/CcJLGbKrfsyIJpyWd45ZBoTV0LSaQoqAvwjqiNMhMBeERjk152NSVLn0z54XcpKQssq/HNb/0vBtjrEg+Q5B9q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721368777; c=relaxed/simple;
	bh=aiaTf8XPpaA3BScB6mYDXX0MorBG0OGd83cATmJc2GQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ez7NSVoIpbMs+fxsmEpWQ2v7yy9nqQT2OFeQIupPPXthZZOkrz/dl6YTOXi/+bTOJ+HYlKVEO9CWFKyd0OeUpBgGfeXebo3rpKtR8Ffc17Cl9y59ga5KpaLVVNG6Bl2L1td5MbKxGDs1oaTshanRXqMA+ukPnmNPiz+NM34w200=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=TgV5e2rk; arc=fail smtp.client-ip=40.107.215.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSGnlx6nBjyGfNEdmJ5QMyoXx9oEjwEhkeKK32LhQqywzfWb5UzIdP6bjw3WVUU0BhRtVfAVWLw0Y5wWjXnjdUXBqJiZ3UMKp9a6v2hxapiWx7Tx9Q2G4PIK8q/d8pUtbWDxi49FQhQU7qn0UFBqxP2tBgXYo9dhuYdl4IPBY9wCfx3X6CXYt9DhhP3DhVFVp02lPthdfvRmsUPuvbucYxtLGqiGYys60/pCWrhLne2SB6SlRi3ptjiKuuGEWMKZCKJTzNbKqsw31bMZKO5sImHkG9hlowdCq41wN6WtAZVZNNSoFZ9eOFNS7MHQp/dUhjKj/0yml/rvbh1DAjQ/vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DIe7675LKkKmPyG6VqKrZMsMV8GiNtMS1alBZCvnz8=;
 b=aeVX5d0IWcoBXZasHnt+sfhrYxNnRw29czKBD81vrX2gGSQPPa3xKMOLabTC0JT5vziVma1DiafRAcx/RutRGZmX0DvAzULwRW5f17G6NOH6uJQetO56cKEIRJrWoNGN71f63rK44uHlipOfZzgnmhDiBbeZAELtq4mWVVOrpHI0LvVMOfS/TCCs00LqR768K0z3RohT812loBToHRuAudYvI9K50U22oxkSyR1OdEzFx1FbpLvYY+CeVSMYLC9Vd7/Z74W5VVk9YxFAni0EuiFk5clbMqPRcvovwdlfrXMlvL6nbp7VYk0xs56OOE8zrQg4FNXj3cEFFvPE4cloqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DIe7675LKkKmPyG6VqKrZMsMV8GiNtMS1alBZCvnz8=;
 b=TgV5e2rkgCyrWg4bN7H0RMQY5RxDLFdYcQgQLx1pbekDwhnK2g2Kxk6EbRarJN/hcenuYl+dH1mOxSWbrH2bOq1YsZpVYzygUeGA1WpUmCZBwn7+G6ZIr+QuYjTpduF+wuk3we74GuJMhgBWhNkeCuY7Q57YpZuCZaYw+1wYJa76BuI5kOoyLxaNwMTDTbuu0P487UX6svvc5P65WzcHWpKHXiI8/lpKkQTtRv7zzLIJYtpxj6hTJAq3w4MwoBHEPcw0akvR81gzo6/Ep88rl0QZD0YRAJfbsr2gcPNZzU1Cjn34c5D/qv4kh5Jx6Qp2UCDJUTuZYevM/jvkzWkakg==
Received: from KL1PR01CA0075.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::15) by SEYPR04MB7600.apcprd04.prod.outlook.com
 (2603:1096:101:1e3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Fri, 19 Jul
 2024 05:59:29 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:820:2:cafe::45) by KL1PR01CA0075.outlook.office365.com
 (2603:1096:820:2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Fri, 19 Jul 2024 05:59:28 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.7784.11 via Frontend Transport; Fri, 19 Jul 2024 05:59:28
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
Subject: [PATCH v10 03/27] ARM: dts: aspeed: yosemite4: Enable spi-gpio setting
Date: Fri, 19 Jul 2024 13:58:32 +0800
Message-Id: <20240719055859.4166887-4-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|SEYPR04MB7600:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8c8806e4-5d91-4a9f-6d7e-08dca7b7f38f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|34020700016|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eXfSWLsqcO2b4JTKXA8Jsk0EWlwuhM5CqTO6vBQwxFhbEBuH9PG0BMg+ngpc?=
 =?us-ascii?Q?5eMtXlIpHNQpUnXNahncEiEvRRshfY0ppBBYnuKiQYvVFm9ZC4xnqebXL+h5?=
 =?us-ascii?Q?D/CV9AXgQfJD9pSchgue8xPpdlMe9rUp9cwz7GoBa3fC8nz5RCUAhzi4rV5K?=
 =?us-ascii?Q?Hvu1R8NedB7F+mgBLSOZ6oxCifBj3WRDdaF1Iyb9+gHBXtOk1e4l3nK5bYlH?=
 =?us-ascii?Q?Xofdig/5r1SVeCY8LXzqZwASePPpqGk61S1di2cL7kt1C74dHE+H0zC4rUsj?=
 =?us-ascii?Q?7yAevA1l6bEDOKcoVyGahV/Nn0GGgaJ6puWxWFMPh4B/lGowuofDQFq2HJ4O?=
 =?us-ascii?Q?uXfgXkD3wCSNPDzqJL501tvqChQtXgozSmRX+Un+vnVj1snAj1ge7+sHk92m?=
 =?us-ascii?Q?8lYp/KD10a4896t0ehaHlpB93RjBuACPD9CEm21WH7S5kj6kxRakzvn5nmvG?=
 =?us-ascii?Q?N3r9lzrUKsykOn+xydA0Tgd5X4faP2wSuuDgEK1Lc0Ki4g4EYJ74uwnWD032?=
 =?us-ascii?Q?y0ohfcobbkce01cOf6O3JMjproodSSobPNuw87d1yyPLWuTeNqQ4g5U35GRU?=
 =?us-ascii?Q?1X+PlqacpZJ19rxBEoXZXKdIxxfrok4L+xv30CfIkRY3lJidBPez75seXK5O?=
 =?us-ascii?Q?V1PlXKVjD3TXs/692r417GLZCFl4r7jpCRKm6e8YxAMc1/7VT8W75/SyBEXb?=
 =?us-ascii?Q?gn70YBxSzD8iHdQP3qd07G1zBZlh4J5Bwln0AiwMpcgBnb0uejyrQqwZ0ptX?=
 =?us-ascii?Q?2cCYl88TybyiEWmMRqW8Vu1Pbf1Wzlhu40S+V7YlseRwCJ6mrflFS6djZy9E?=
 =?us-ascii?Q?Zd3wX/3P6+hF54bPV+nysTi/KcCQo1UC3o5lfck7ykGLHGwhttZmXrPr8o8L?=
 =?us-ascii?Q?0bo8kkEYAj+5FgiU6LQYpYG35nM+93BIeBeqcW4g/e7q6yUlXfGZNCOnfz8l?=
 =?us-ascii?Q?EW2Gw4gkqx0PVBKO7tj2hiOaVreRzneuG+POtoqIqeY8WsJ0m0U+R7vnMCS0?=
 =?us-ascii?Q?TlwvobW/Roe2xWO9cVT4BgGJyZyfQqxxNHGCjcpSzkEkeU0xFEx0rsm8b8M4?=
 =?us-ascii?Q?IDQfs4W8p7fWJxoc11y8YPBXvJZ0/cTRJzCUcPBmrmTVDL8tbsPEyWKVpJkK?=
 =?us-ascii?Q?2GntZ555y4k6xAj1RqaFudR+yKKmvyGz5R5gFupD+HbPMokHq1a698QjzoaZ?=
 =?us-ascii?Q?hduMacq3mUL5S4EqnnRHJOrCEpNE2H2ADIExKjL7nwNmApBxwZ0oRgWaERSR?=
 =?us-ascii?Q?nJI2uxsyp5JXOfeU6+KYo3/9LpCsupKM2O5AsseQM6L6QEGhI6DFFmctNvem?=
 =?us-ascii?Q?iZtOcgAGnu/UbDs/mYb7+WBcFS8TcgESd8UaMnymrp+CbjNnOfZUuP/iohgl?=
 =?us-ascii?Q?sctxjajUotgc4gMxzEEmUEs4Mg9Q9vRarrxbPwC0ay89KKJr5Ut4y6Z7oWE9?=
 =?us-ascii?Q?d4aFQcRGpiA=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(34020700016)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 05:59:28.4697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8806e4-5d91-4a9f-6d7e-08dca7b7f38f
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7600

enable spi-gpio setting for spi flash

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index dd88be47d1c8..effc2af636a4 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -53,6 +53,24 @@ iio-hwmon {
 				<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
 				<&adc1 0>, <&adc1 1>, <&adc1 7>;
 	};
+
+	spi_gpio: spi-gpio {
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-sck = <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
+		gpio-mosi = <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH>;
+		gpio-miso = <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH>;
+		num-chipselects = <1>;
+		cs-gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>;
+
+		tpmdev@0 {
+			compatible = "tcg,tpm_tis-spi";
+			spi-max-frequency = <33000000>;
+			reg = <0>;
+		};
+	};
 };
 
 &uart1 {
-- 
2.25.1


