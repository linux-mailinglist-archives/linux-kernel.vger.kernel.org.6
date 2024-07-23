Return-Path: <linux-kernel+bounces-259807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFEE939D79
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35B052834BF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8A914E2CD;
	Tue, 23 Jul 2024 09:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="L8spurwJ"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010070.outbound.protection.outlook.com [52.101.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D786B14D6F6;
	Tue, 23 Jul 2024 09:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721726615; cv=fail; b=l7iO7GJmCOIw3U1vooFVc8KFudgHL7KbTZAJVx/AohgI0D3Bu3xKiKEybJ3rQuXibv3X8r2W9zwFO1XZFIKvHXAf52znGnTa3ourTLYXtQg3ah3R0D4jAa7R3cTgCQKAPDD5RJJm99Bpfg5XWzORbmFpyrxgn9QpRjByD7NpZ4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721726615; c=relaxed/simple;
	bh=8kUwonoYyYB6FHmWPqpT9IgUk9yz6V38DdWLkRxT/ZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=StjH9eUdYGGyNj2P48FTasxxC5jpjFYyOeisxLakGNADD9k/bo0UccQsd0PjMdPQn+MO7f2B+m+YPeFGR18QT4xrr84oPlQOPyIYGaXMm8KoXs3UX6hC41gfOgRoF6mZZJmPJp24AUCY1hMqei7C7J1pryVzKQycbQvY2CUHl+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=L8spurwJ; arc=fail smtp.client-ip=52.101.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PekgKxob06+7gsVFCZj7LmfsYa2BTMtCGw6YBJ4fBTuLCqj8cJhIcXBL8Z2BW8H8NdchZ0IGWjGELxxIThc4DiwXdImH0NUJ51EOXAzAq4//cbWolEWXNBenqccDPhIpqAPj7rbWZGykd2dvyeSlVpbw71AET1QYwLTQlHmP1tNFZ7LWbzrzaNH5+Pa4S3g71OWO+wLIOUG4o5GMoxpz/1wttn8hyFa8158umqgz08OAfBNTk7GxEXMGudFjacMo8Wc7bbdzU9dZPM61lJjyrAxqOj3ZqJx9a9mx+PCVNSpENYEKa8OhQCky6L3JoEpyyYgC9IoQXDJblvT1tGjBZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmHAwAuLtww6S7Kx24cCQt5tMxYWDkSMHxAXTvM1SXo=;
 b=JHMvTPB5aRjEEerWRLJ/SkSH9GBm7qczJnyutLI1kj+AVOq8pssS4yMO10BDmdzGzdchg6rF3A5nKtcQFYPwZlYQqCUMKmTSewK51uciIn1gZGzVU4T42rYOMXot84M+lDFhMAVdezi40vFjpxe6RKr/60XgoaplQbakLGrNIIm7uS++wXDhFRprQ8rUK6WvK0a9/0xDTONGCQMIcnhARRzoF51LUuez1Mxh4IoSH0hR98A2r6W5vKI+cbIcVDTUnNRPYwZaSOOxAX1oheFr3rGPv3TXDw33pI7r9Ab4WrzqZn9ZwXdtoD+zb+KWXpntX1fQMsSJPD+Z0ZTv5iktCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmHAwAuLtww6S7Kx24cCQt5tMxYWDkSMHxAXTvM1SXo=;
 b=L8spurwJKa46KIdLDJ8CThPM8CXWzVjGm/xVk2eWk/BeDOWLZ9tdH5fqkNGTN7CokHKA2QYkZdlSzaEaSwUAhjS4Q2f2wDLFn2FpppyomMqhxoXaeSQCp5tQZddcezncPhGdjMhz+/UR8btKw6Kp+rCKgaElWJI6Og/K/nWoU1RGvujCCQ37tuJYhuqyTSqFXS4nKsj6y4l4JMvN1tVXDeSxp0bc0bc8gNbT4Z9cSa9tCe8aIDKik9L03CVoBYv3BX1sAKlVx5RHPfdjajkUtMG25tfntnbu6qGPWrmpf0AjzAtoCx0hUXHlzehpPWmFmGwsHZy6Dw8+pvOCCdmduw==
Received: from PS1PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:300:75::32) by KL1PR04MB8172.apcprd04.prod.outlook.com
 (2603:1096:820:13f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Tue, 23 Jul
 2024 09:23:30 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:300:75:cafe::94) by PS1PR01CA0020.outlook.office365.com
 (2603:1096:300:75::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18 via Frontend
 Transport; Tue, 23 Jul 2024 09:23:30 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.7784.11 via Frontend Transport; Tue, 23 Jul 2024 09:23:29
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
Subject: [PATCH v11 03/27] ARM: dts: aspeed: yosemite4: Enable spi-gpio setting
Date: Tue, 23 Jul 2024 17:22:44 +0800
Message-Id: <20240723092310.3565410-4-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240723092310.3565410-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240723092310.3565410-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|KL1PR04MB8172:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b7a68b10-dfd5-40f1-7e1d-08dcaaf91d98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8GGsPZQ4oqAIms5LderLoXiQ4dyXbh7FZdB3lYSN0icA964TCt7fWOYhshl4?=
 =?us-ascii?Q?kk+oLzZQdDU76BpwyCAbpe0GMLtn/+fdmzASkUm6YklIdeo3Om2xJgdR4ZNS?=
 =?us-ascii?Q?MG6gyAEW3DyGZOEjJnKydWp1POV6sdoEsFVYgte4emWKUy/ldOkFU+ECAzVA?=
 =?us-ascii?Q?ZwvWmKNMllLx3wmlhwDgGLdtus24RLd8qS2KUKAjG1WZUZAFUlzyvQvhiTYa?=
 =?us-ascii?Q?uE4c020UW5e9R9zkD5va69PmwCQr7rhtQzWg+pRxKbO9Ib//i1RfSJmw03mO?=
 =?us-ascii?Q?sOk+tJHLmIr4wKGzMSi0+pc0dAde0B29x1PPgcipjEwqBM4KB5GvkBzAwZWS?=
 =?us-ascii?Q?U/v4m96EmE72k5kHpMfmdD8jyrKL/xpjiUfUdkPNF6jEn39vK48un3kUPPNX?=
 =?us-ascii?Q?MU1Lycr7eHHoiEGQz2FZbLeVnblZnh0ANm8hPE7eR93NSaOjiOys1UaUJHOV?=
 =?us-ascii?Q?sY5FyZTMs0AxwhSzIFsob0N+rIRH5JhQruN2hBOy7mgxXC0LmWRvCS+k43Q3?=
 =?us-ascii?Q?SEnPABcpbdHffUbumwOVoShOnEHONUBu7x/TeG5Ncu4Fln7dPuKc+9iya5zk?=
 =?us-ascii?Q?XlNg2jB1UPKnxBEmROyA0sH3L2DasDtgO/xLPZbf1AgUXs9TRLjBVMto883k?=
 =?us-ascii?Q?bGLUFB5SqQyWWiCDLxupeAE47oPElt2r4vK6jEZ1GOOuNCplcueMRETF6tqB?=
 =?us-ascii?Q?jGIAi7f99U3BKFrGoOur7VzCVvXLtToKovagngurC97EA+QJShV1GLLJ5UaW?=
 =?us-ascii?Q?ajwy6yKAwBTUhzPzAw/PXV6kfyIjXFYokAU6gc5DQJHxwi5Jb6UDD9gTK2Yc?=
 =?us-ascii?Q?SCYA5n/VCCYzXozvGWg5IxYhMGZS3jCFk58qNc3Zvw4Zyqj5kJUIWh82+EAZ?=
 =?us-ascii?Q?Sl0R9DXDEI8f+xyXln2m17LdG0jdpe+jbA8odDfIuy45roeESvztRh01t8VQ?=
 =?us-ascii?Q?jxw9IsJyRSa1xtAtMP87UPwVCeyQnwmQKxlojoI//Z8bOYPbUHxTA+KEs868?=
 =?us-ascii?Q?TkDai2eNDxmu+CLBYbd1/q7B2uo/qjyI/+mPzF4h4nLIs0YeGPwhwRpCYNi2?=
 =?us-ascii?Q?xcaRhJqYFsGBKaQl/xPPxePAersASfyyi7iq6HNceakP2glUYGsIIyI1gu2W?=
 =?us-ascii?Q?oqG9pcMIElzyv86eYzpZeFW1J2pZFHpcG/QFYjV7+IkxzRJpw4tkQ8euvGgm?=
 =?us-ascii?Q?dGgi/RI07QYD5H7XfPAlqWGbhp0YP5nJWT0EPcrE9ei+5+1HI50s3itH8rh0?=
 =?us-ascii?Q?IMLFYdt/ztDZlRAjb5alkvLQ9GmLOLDIM8ydZ81WcRuugg9xhQNRScs9B/ZI?=
 =?us-ascii?Q?irqJfIaQwnT/A4dB4DilSri4eRs1JWs5Soim5kk3KRniKyVjEfmUvW/MfyzG?=
 =?us-ascii?Q?zPqrh51CQL/r/RfJA9E0urY3PrHhhR5n0yMvNj9xXcy4oLMjnSGCfhODBSrA?=
 =?us-ascii?Q?eWFQwz12DhPwu5T0LRCg1TwKimsGRJmS?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 09:23:29.7691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a68b10-dfd5-40f1-7e1d-08dcaaf91d98
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB8172

enable spi-gpio setting for spi flash

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 0d659ee2bc19..575abdd530df 100644
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


