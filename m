Return-Path: <linux-kernel+bounces-257002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4492B9373C1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98AF1F25971
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 06:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA0B146A7A;
	Fri, 19 Jul 2024 06:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="md2pTfBy"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2078.outbound.protection.outlook.com [40.107.117.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145B6145B01;
	Fri, 19 Jul 2024 06:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721368875; cv=fail; b=dzqxWXv/r86/jVO+EUXxJaDlrMCnX8KtwVR2E4b5LTlau1BiHaR7w38AHfhowfNdpkgVceXzKTTmr/v88EXp46RuweG+QhJ53SKXoeUVgbsybtpr6mxjzyM9gUesbz1gluyJ/BEijNs5uRCKOEAzs82MtXLfgdnHiyNpg2bnW78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721368875; c=relaxed/simple;
	bh=Ly+junl6CLrg62qRekrI1DEEkC0LHasX5bWeFy9CIWY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fIuho8bnExN9D/VMH6Qj3K/Obvbf//JvLUP8g83u64wR94IFE8N6bCMdOW+fqsuq+43nCfboPjdQ3G3RfEU2mqLzodLaBj9xFr1abch2Eem/Pbj6lD4Ildsrqd1neDQFtiDBtbCjTYInR2snuFkAEdYxyc8PUSH1Q9KYQNb4vyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=md2pTfBy; arc=fail smtp.client-ip=40.107.117.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGMO+/ifBGRTIIWVC2HiwvIESUztGTcXvNtrXAne71m/SsdBaG1xvDcHgZkNO3609JRRxa8iXI+Xrod3xK4ZyQUBpsBDzzS0C4Q1MzQpdM8pKOZkH/p4j9cP4DSskKeaCghOozGDdKza0/2bE/0g0MbEs71UGCh3/2jKn0ZnzsBR4yo6APXnZ4I9w2QDGhfHeGvlIkM8jIla9ZYSnF+8yeeUISwKVvkLUca17uAzsKwFtUWSrrEX4K0eVK+d0CMj7wQguWzdt46A4gJdB2YLCwidjrHHmMTJCXSIOwfGGBA4NHFBjoCJqtBgYSDOXnUs1WROv0uttJrYwmV9IpzZlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMDXk1/rvsAAHqhM7xPae/xOMl06+Tx5uzZbzGXhucU=;
 b=bZxveXkuIymq8k1IYCHn6bGb/wJo6ARMWlm9go9nl7KPk6HlXb7VH0pHuems6btEANpZczwU/Ou6T5e+5VIx8DgqCfGV+CO5D1FP44BlKTJ19ADMeS/XOrUEDF4kmCO5U7q99tlLMKZmGqMi/bLeGTuAoyWOQPKNHvD7C5vnEPZFY++rvpdjScdLggh/iTc0bxb5a2TbHU1BS1Uk7Mg4rkzfjO+YzwENH92G0G7JPrNXlP9Unh+u7veDHSf8YmaI9P2xFHRGCdRYweiejb8fD1p0hy1T9jz97CuFgcSsNyi6qfqhzHF8jnpgsGj4Ewlzsg1B7SoXOQY27sofc78pIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMDXk1/rvsAAHqhM7xPae/xOMl06+Tx5uzZbzGXhucU=;
 b=md2pTfByImpZw4pogf+asAs7QnKkVJ9fM+XT5Qb0SKJLIM/nk/RfuMIbvPJUk1pKAYdUTzN0mYmasNIYs5XQucTpeXmgQyxfaFjvvjAOBXQ6Lk5beBCkF0EqUC44FROkDMAeHZDnp8DbhNEA3sCWEpNSUdNcsUwrJXdsPZ/hU3bQ/moJzZAsGWfRlunHssDMJ76LyGEuhmxyAo7j2fHqHm7P4PXcdF68lJm2blRebfiZmGstxNyeX37KwQrpPOe5prJwN68jjaX8Q4+bopI3cIkeaSDMNBJfu7Yj3IyZU3PECXUmrfsFxcwSoclyyPdAGrQOavHacUNTcTIOZxIarg==
Received: from KL1PR0401CA0027.apcprd04.prod.outlook.com (2603:1096:820:e::14)
 by TYZPR04MB5904.apcprd04.prod.outlook.com (2603:1096:400:203::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.6; Fri, 19 Jul
 2024 06:01:06 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:820:e:cafe::d) by KL1PR0401CA0027.outlook.office365.com
 (2603:1096:820:e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17 via Frontend
 Transport; Fri, 19 Jul 2024 06:01:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.7784.11 via Frontend Transport; Fri, 19 Jul 2024 06:01:05
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
Subject: [PATCH v10 27/27] ARM: dts: aspeed: yosemite4: Adjust ioexp bus and remove mctp driver
Date: Fri, 19 Jul 2024 13:58:56 +0800
Message-Id: <20240719055859.4166887-28-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|TYZPR04MB5904:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f6228078-df17-4ba1-71a7-08dca7b82d3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|34020700016|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ki81l56q/TdRkZi4bkeTDlbaMlrZVg3J0eoNA+GGZlJz3FMRw0XzZOFyQgKS?=
 =?us-ascii?Q?W2e/QX//Kn+lYJ5oWCIFKgocqURfE/IRD1cd/07swD1hTdh6UHpu9CRFnITV?=
 =?us-ascii?Q?NRpIQOGhusgrr0gNwf44smGusoEmkTzZ28Vo9xcuzOwcFaUy4KHgbcAD88YD?=
 =?us-ascii?Q?K1pRTr74uvZlHPefbj3byjtcFiy8nvAdPFemNv5KdxJKDBx3rd/Lwx+C/RM8?=
 =?us-ascii?Q?yWUkTabbo669LDh+G0qZuYu5meIJ52o59WmKneWsyikxNDISO5aMGrWOSeQA?=
 =?us-ascii?Q?/v2k5MRCKnWAatuGLM9eP3AdRE7tRmH/A03cpLyj598OSC0MkzBm8Wfu0Erp?=
 =?us-ascii?Q?r3uTxVuhzhzRb+rr74ABjDdPXIb0CT3L3s7ztgpEbjQzhZ83CuM21F+Uk+ao?=
 =?us-ascii?Q?NBd4kGXJY+6n2squ6ZDMdc5/h4N8XTxBQ7/fPHtpr4MA35d9zGkHqhsKIqvM?=
 =?us-ascii?Q?tf+jTILEHVGXc8PnNbLgIGVebxUoah70lf5vivIzq4CviY/9eJXzbKCtbuo7?=
 =?us-ascii?Q?i5lA5Tho72REhqLeole3KgDMtC9iETFJqbO3RF+0NRLVjo6g8KFf/Egv6jzD?=
 =?us-ascii?Q?Efgp/wvOeNPyxZPsHlolvkmRJhOZ8bVTMERaZWTc6fEdvEPFF/pJ4gL0YOQH?=
 =?us-ascii?Q?m3gWrTgRg82xIHpAdOcPbMYfusJ8NwW1rSmZ56YjkXOmQ2X4hVmi7fE3bMbH?=
 =?us-ascii?Q?749ltQR8U7NOknQC7l5bTK4GK2a+jd1An6lCr5qHcusN254Psp1nUaZYlYT+?=
 =?us-ascii?Q?l4I3b2VF4E4ONGzzo0CV2XjEpPg0F6b/XI/JCT8VoQCgbje/y2IpQYRO+dVj?=
 =?us-ascii?Q?6eDbZ6QGyybZ5pkQoB+79kHQsLuyptnjEx3sIA4fMa54PsQ/25qWp52b+P0L?=
 =?us-ascii?Q?5CFF4J2zVgVzXTtNQG9hYngNpNM0/7hd+0OuRTt3FRWCm2E3KYUDg77P8GHM?=
 =?us-ascii?Q?DaJ4MtJFWo+4bKNQBIOQYdu3FxiYcsinZuxMN/TVhsCLDdZ9eMLzhlmrioD+?=
 =?us-ascii?Q?RUyV2Q861AdHKwJN7JlIL+BSBrDKkj/q7xGwl+yCZ8Klu9wKZr4GwNQW/nem?=
 =?us-ascii?Q?79YPJm7OA2E6jqr5qbwmIuK9UBGT9mj1LkTT0uSNJx1TWKiFkh9BcMim0lU3?=
 =?us-ascii?Q?fiRULKihj0ExbohZGsPnBcoBXjqJ8wx4xbM02995TzY6a/mhoxqeTHtH8Dps?=
 =?us-ascii?Q?+IeHbHMuc2mw0XsQmp1/YpYZooj7npWzNoSwzmE0ldG/jpDbv+QAp6+wBN8G?=
 =?us-ascii?Q?yzJc+XIKNidK9xOFhe8OONiqQccK+ts6DidgKXfAoPAwQrmnfgdJpR4sayi7?=
 =?us-ascii?Q?+EcWNtpEbUQKh+Z6ncxs74/9oYNXcKh9TRrqyFuwIQ0HKT8GU22wZCm7BLwd?=
 =?us-ascii?Q?Gt/vvx4O4EyDe43Okf7IRoiL6qxHTOvVZrQ7LB3dp0GFo+nvEHnfzfXWZw95?=
 =?us-ascii?Q?x0G1iBVyV91x4/QYmnmQjEgngA+kZfr0?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(34020700016)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 06:01:05.1112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6228078-df17-4ba1-71a7-08dca7b82d3a
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB5904

Adjust CPLD io expender for PVT stage.
Add GPIO name for GPIOO7.
Only binding MCTP driver on the down-stream port of the mux.
Remove unnecessary driver binding since there's no MCTP device before the mux.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 59 +++++++++----------
 1 file changed, 29 insertions(+), 30 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 7ad080e3f432..1edde3923ae7 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1156,6 +1156,34 @@ rtc@6f {
 				compatible = "nuvoton,nct3018y";
 				reg = <0x6f>;
 			};
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
 		};
 
 		imux35: i2c@1 {
@@ -1188,34 +1216,6 @@ ipmb@10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 		i2c-protocol;
 	};
-
-	gpio@20 {
-		compatible = "nxp,pca9506";
-		reg = <0x20>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
-	gpio@21 {
-		compatible = "nxp,pca9506";
-		reg = <0x21>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
-	gpio@22 {
-		compatible = "nxp,pca9506";
-		reg = <0x22>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
-	gpio@23 {
-		compatible = "nxp,pca9506";
-		reg = <0x23>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
 };
 
 &i2c14 {
@@ -1470,7 +1470,6 @@ adc@35 {
 
 &i2c15 {
 	status = "okay";
-	mctp-controller;
 	multi-master;
 	bus-frequency = <400000>;
 	i2c-clk-high-min-percent = <40>;
@@ -1680,7 +1679,7 @@ &pinctrl_gpio3_unbiased &pinctrl_gpio4_unbiased
 			"FM-BMC-READY-R2","RST-SMB-NIC0-R-N","","",
 	/*O0-O7*/       "AC-ON-OFF-BTN-CPLD-SLOT8-N","RST-SMB-NIC1-R-N",
 			"RST-SMB-NIC2-R-N","RST-SMB-NIC3-R-N",
-			"","","","",
+			"","","","FM_BMC_SLED_CYCLE_R",
 	/*P0-P7*/       "ALT-SMB-BMC-CPLD1-N","'BTN-BMC-R2-N",
 			"EN-P3V-BAT-SCALED-R","PWRGD-P5V-USB-BMC",
 			"FM-BMC-RTCRST-R","RST-USB-HUB-R-N",
-- 
2.25.1


