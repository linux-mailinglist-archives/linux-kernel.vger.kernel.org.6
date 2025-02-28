Return-Path: <linux-kernel+bounces-538311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 408AFA49701
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97D151748BB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DB825F791;
	Fri, 28 Feb 2025 10:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="Tx3a/8XW"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2125.outbound.protection.outlook.com [40.107.21.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C530A25DB09;
	Fri, 28 Feb 2025 10:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737923; cv=fail; b=jPcjpUUvNw2Z1Txnql2XIJURuvS2ra7Se8z084IksWcHFUeOTasrjhf0mwgXNwUbVA5EyPGq5LYu7cbSl2pwlZBI7NyOJGX0ujdlSCLElLV4kanzNgi7ORddnLd/XDo5rVRhzKrAG35MSFCgcUYq5HRCoBuZD/evIMoA+tg18Qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737923; c=relaxed/simple;
	bh=YBOzJVefrmYjDtOBYvayoO3Wp8/JYGzAM/UtZcjWPuM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G854Jzxfdf63qeboY0zxoM5sre9ojuKnnwEjYhzcp7t1+7PRRe5iFLhpNFDw5cV1KGb4M09IKdeNKbvSDytvLbnhJNdXkQ3kxM7VfnCI71xo1qQQsuYijBIPd8CiucfPnldtcFmGyXaeZIsuYKK9T1jNoOZHhVv5ZMv4i98ASZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=Tx3a/8XW; arc=fail smtp.client-ip=40.107.21.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/k0FCPTUJSzXEHT3c2IySyhs0iL6NSNtHmYWMfAHUzSO0zfUOXFpeme/OOMXOvZCj7rWx6l+C0/42vJqIybVVvhwz9O++fCB78CH5frGtN3lViKGiwjCQo22/iT2BC8XUB8cj33Hpr3PyCePJISW4jPk64BghXo6ItJnX7pjdAHOloSFZluwYCEWQ3sIBPAy7aqhd10/hAEZzKWCDElnLzdclKZ+9ND3rMppz0Bce2ZG9ANlHqZLI1r9yjw9Dh8G381iUci6eG0uWcU9zhBS0Qdda7uVnLPkbCHvpDV/4ZV9/5V2e9XWPkxnRkkpZ8Kw7PGmbWstz1+JU8tLK3qwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKRzO8iJdE9AdOFwiOC4jOji87/asZAhQHWRgXUurKw=;
 b=QWfJBMAjZRtYTE2Pj0VnXoL1Mjs3dBZ9qqBdQWaWj3v2SUbebpWP9+XhPxSpxcbeVoTf0TighNnKGZPjf+beX5Qw2kNHsPZ6ln6zWXZfqwyRArQzUzCwE9tY8X866ftktGqYEFgT1QGgY/sr3tcrrPsgfUJr1zx14mzGlZlwXwk1bIusgPABbMGJN+WsZcrxjNwRBxAkJyP6uKo0Y50yDAfum5f1qjvD8AsQP8wVIMRnu7fvHNp+dFZNI1FkMgqTotlqu1Z/GgLRB6jAE4XKWRTSMGmfhLSHn9Hg2Ryj6FII9C9knUCFNO+yj7ke6aR8OAJyaQ2B5KzwvdCYilzvDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=ti.com smtp.mailfrom=phytec.de; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine header.from=phytec.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKRzO8iJdE9AdOFwiOC4jOji87/asZAhQHWRgXUurKw=;
 b=Tx3a/8XWbOT5jcHlldsYM3V2fJbB7W4ZLbj7O4eoNzpkxAMs0g5YBFQ9Jw1Odc6676OaDUbPfCPPUJP3Cn33+1fD/r8BnAzUouXOU+CfFFwrV+MmggfP/U6txFZSwZStqS27sorfgcJlXIQbPWt1GZtNhxh9Rbgfi5BmwoPgZxdpvKQ2102orZuTcjJk4lLdVjrqAbt2s2Io3iao/s5V0/Zlf1CrIcy7xKLkHO6BS8UNZIyW+dk9nO5q+MQzme7LKy0IwJV7uF3o839fO0gWaOC4qXIaS4BxWuSXoQHV5Nhdadt4hlfN0YmgrRWfXQfromuAK2RRHnViuJov4GpdAw==
Received: from PR3P193CA0001.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:50::6) by
 AS1P195MB1447.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4a7::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.19; Fri, 28 Feb 2025 10:18:35 +0000
Received: from AMS0EPF000001A0.eurprd05.prod.outlook.com
 (2603:10a6:102:50:cafe::82) by PR3P193CA0001.outlook.office365.com
 (2603:10a6:102:50::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.23 via Frontend Transport; Fri,
 28 Feb 2025 10:18:34 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF000001A0.mail.protection.outlook.com (10.167.16.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 10:18:34 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 28 Feb
 2025 11:18:32 +0100
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 28 Feb
 2025 11:18:32 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
Subject: [PATCH 4/5] arm64: dts: ti: k3-am642-phyboard-electra: Reorder properties per DTS coding style
Date: Fri, 28 Feb 2025 11:18:16 +0100
Message-ID: <20250228101817.865811-4-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250228101817.865811-1-w.egorov@phytec.de>
References: <20250228101817.865811-1-w.egorov@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A0:EE_|AS1P195MB1447:EE_
X-MS-Office365-Filtering-Correlation-Id: 3454ee86-64dd-4cf4-bb3b-08dd57e14258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rX8kkLdeZFDsy+8RsWWlpbHB0oygVRowtqxM8ZUS+ElUlj//a+E1mp2GqXlS?=
 =?us-ascii?Q?8SCF2tChIIekpHicHiopNbQSISbjgiV8i9sIrk5bS+uZk4sk8ckmukmYUx4b?=
 =?us-ascii?Q?iBXUyzTBWohOVLEDk0bXDHXuh1jcqcqa90ouGm0e6ZLznfwHG9QAQZWZXSdi?=
 =?us-ascii?Q?upKwNYbblYC0KvdJujKWmbG8ELBNA9Fx6obHLnMizqE+CAEM/RSNImp71Apj?=
 =?us-ascii?Q?0Xe14fdYLxufazZov0YDXxsGDN9gbqoGj2Zg0zchvLfhzVbdIQjiNsarSWKj?=
 =?us-ascii?Q?YyNB7o3Vsi8FMdxkZDFYbxfy+zvWZglMOvDni0e5J3qgaqm4ofzU1P4JttkL?=
 =?us-ascii?Q?aD2CAyCa4BWGh8MSg5pd9Jy2BpFt3QN/NBgdFzNMKEF1eun/ypw0uF76T3yp?=
 =?us-ascii?Q?HT46OvNLx3ZTRpQ1uJHkfHMNtLik9OugLb2NjX5tPey2n2iZ55m5tB5t1VQ1?=
 =?us-ascii?Q?P6NVtMbgDk2k6CxergyRiGfybz9m5C/ru9GOXjKZAlDpJs+Miou6mmqF4JJw?=
 =?us-ascii?Q?Hk7o4wUw6mBJ9ug04U1QKEm8bvKHMcJ0paOTJUIBKHrGAPXK1Z7ZT2FsvVnc?=
 =?us-ascii?Q?XxV/44zzAySJN+dcZACRTtbM0J9vvIDBHaFy/mBWtVL+c8S3yPmFLSXotLsT?=
 =?us-ascii?Q?IdH0dKMcxg3B3Mama/jnmfQZ+tTrYLAcajntcGSL+jMr/RXfpUIYze5L3XIe?=
 =?us-ascii?Q?S7j5xvH5I8nptLlwDIBKuio68QD0tZZA96D9HaS+TVzR2JWyGthmd7mwr5F4?=
 =?us-ascii?Q?Dr66YKxCU7YqW8uoQP7oP1JRj4jhpiWGeUhuH7sUaktn2ihW43nXPQZqL5Sm?=
 =?us-ascii?Q?i3G9ZdjOODkGs9eJzDJJDFJPNyRJeR2mMHen49PPHGrkzXzTo0U9DlFOtW+x?=
 =?us-ascii?Q?lS4r4sEry77AFLZd9hSGKZiUPDvgzEu75WnYXsZuJzQ6kJJUqPZ7WhjEWeSJ?=
 =?us-ascii?Q?h3Lgm1Vu1X10MqvwbQgJwS5m9QspVcWBwNHs4gtv+3Qi20jqxLxpogHLm7uA?=
 =?us-ascii?Q?ThsyLMr5a1Ax6MVKi8ZvxnRYx+chYCkpZaqE8gJ1EcZdLWMMw9mO9Qwk5jgH?=
 =?us-ascii?Q?CWDXUbW7ncHWl2EDtWzcFioL3FAJ1Fp0+5skQdwAaNAOrBlgTGHC5hcpNiEd?=
 =?us-ascii?Q?UKw6rBP9LALIa+6r4za4P8W8CgWNL5iL5hAow+sY/fj3+fogBr6NK/GbQOHw?=
 =?us-ascii?Q?0Typ+EchgsybfnhfDo4iyrXScPXsyvpVFoBKCiIMY9Jyutk62E+y3sA0l4cv?=
 =?us-ascii?Q?y3yTdMryGUH8JrtogMX1wa/MDCQwIBSpzlyVF73iS/i0DnSUTC72CVr0KR5M?=
 =?us-ascii?Q?/8GRQbbvU7dLOMtPyZELo3NfzG/DqlnRPrXL494IEytmsckSQyN294g8lhzS?=
 =?us-ascii?Q?8lURXDLZyfyZcp9Jk8tK0RVdF3bgKTDObygjnVQN3ejJ/Qt8f4TS1taXfxOJ?=
 =?us-ascii?Q?EoNz6BdaBvy27WeZSdLuOWxhqpdqs6Fh67TyJ1HWBv3Z4D12xIzEtCx+mnx/?=
 =?us-ascii?Q?GxROFfw/ZIYNT28=3D?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:Diagnostix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 10:18:34.8535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3454ee86-64dd-4cf4-bb3b-08dd57e14258
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A0.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1P195MB1447

Reorder properties to comply with the DeviceTree coding style guidelines:
https://docs.kernel.org/devicetree/bindings/dts-coding-style.html

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi    | 12 ++++++------
 .../boot/dts/ti/k3-am642-phyboard-electra-rdk.dts  | 14 +++++++-------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
index 52d53b690ac9..4697c395fcb9 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
@@ -207,22 +207,22 @@ &cpsw3g {
 };
 
 &cpsw3g_mdio {
-	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&cpsw_mdio_pins_default>;
 	bootph-all;
+	status = "okay";
 
 	cpsw3g_phy1: ethernet-phy@1 {
 		compatible = "ethernet-phy-id2000.a231", "ethernet-phy-ieee802.3-c22";
 		reg = <1>;
 		interrupt-parent = <&main_gpio0>;
 		interrupts = <84 IRQ_TYPE_EDGE_FALLING>;
-		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
-		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
 		reset-gpios = <&main_gpio0 63 GPIO_ACTIVE_LOW>;
 		reset-assert-us = <1000>;
 		reset-deassert-us = <1000>;
 		bootph-all;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
 	};
 };
 
@@ -271,11 +271,11 @@ mbox_m4_0: mbox-m4-0 {
 };
 
 &main_i2c0 {
-	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c0_pins_default>;
 	clock-frequency = <400000>;
 	bootph-all;
+	status = "okay";
 
 	eeprom@50 {
 		compatible = "atmel,24c32";
@@ -372,9 +372,9 @@ &mcu_m4fss {
 };
 
 &ospi0 {
-	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&ospi0_pins_default>;
+	status = "okay";
 
 	serial_flash: flash@0 {
 		compatible = "jedec,spi-nor";
@@ -392,12 +392,12 @@ serial_flash: flash@0 {
 };
 
 &sdhci0 {
-	status = "okay";
 	non-removable;
 	ti,driver-strength-ohm = <50>;
 	disable-wp;
 	keep-power-in-suspend;
 	bootph-all;
+	status = "okay";
 };
 
 &tscadc0 {
diff --git a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
index 6fbd8d932396..f63c101b7d61 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
@@ -352,10 +352,10 @@ &i2c_som_rtc {
 };
 
 &main_i2c1 {
-	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c1_pins_default>;
 	clock-frequency = <400000>;
+	status = "okay";
 
 	eeprom@51 {
 		compatible = "atmel,24c02";
@@ -385,25 +385,25 @@ led-5 {
 };
 
 &main_mcan0 {
-	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mcan0_pins_default>;
 	phys = <&can_tc1>;
+	status = "okay";
 };
 
 &main_mcan1 {
-	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mcan1_pins_default>;
 	phys = <&can_tc2>;
+	status = "okay";
 };
 
 &main_spi0 {
-	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_spi0_pins_default>;
 	cs-gpios = <0>, <&main_gpio1 43 GPIO_ACTIVE_LOW>;
 	ti,pindir-d0-out-d1-in;
+	status = "okay";
 
 	tpm@1 {
 		compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
@@ -413,27 +413,27 @@ tpm@1 {
 };
 
 &main_uart0 {
-	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart0_pins_default>;
 	bootph-all;
+	status = "okay";
 };
 
 &main_uart1 {
-	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart1_pins_default>;
 	uart-has-rtscts;
+	status = "okay";
 };
 
 &sdhci1 {
-	status = "okay";
 	vmmc-supply = <&vcc_3v3_mmc>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc1_pins_default>;
 	disable-wp;
 	no-1-8-v;
 	bootph-all;
+	status = "okay";
 };
 
 &serdes0 {
-- 
2.34.1


