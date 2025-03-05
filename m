Return-Path: <linux-kernel+bounces-546333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6003CA4F94B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 957B63ACB3E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CB920101E;
	Wed,  5 Mar 2025 08:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="pw0/lO4h"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2135.outbound.protection.outlook.com [40.107.249.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233411FECC1;
	Wed,  5 Mar 2025 08:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741164958; cv=fail; b=RqHQLFu4hrbwGpM9IhhPaG4G5fqtoBucHOUBId9iyzwy/xZroNGvDLyJHwaf91QMkaCUX8SHBph2ZLbO1oKw5zR7TpMX6Kj9BGTpTpgoQowzG6CovOQMxyk0xGdJCx7zc71PspUmRJLJwe6Xp7c1cCtOVrWisym3KuLz9Qv4f04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741164958; c=relaxed/simple;
	bh=7hqN39bEOeX2T1Imzyy5C4veaKYpkubcEU4CzqYIiG0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kcYZojiTncfPazW1qOivslZ1MsrkzMxTxrqpJaWyP91y0JcsKmhB+kXgGN84Zgb0fTCCTMQbqQBc2l3qAMyfyiISb8qvsUItWqSu+60EcjLV2Fc6W9xaXXZgz+sDDDHVB02A8lNalCvSKtjrigad8+AM6l64vTml4kcojaTvXbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=pw0/lO4h; arc=fail smtp.client-ip=40.107.249.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LUWrsV4gWe34NPj4BIgcAJ3XpYOdpbwkmhYiAoBfZ1DmVp5+LJkK/ZK8xEesJt4gQOvevInTYRqFKiY3ge12vYq4ceWS0EFYYX4D6VomsarQptpmsKm+2jyChcwwzwLcoZyYt1LSVfXNUkJLXvJV/LMRUAgcW0j7bhAVLyifd6CxIcM7Kdj1gE7HrB7d22KJD0wJyK7ogt+IDAaqLu/LXgI47/gNvgukrOzsV0qz0uk2vom7ASiv49qmZEjoTFKRnY+I/gzfkAv1n39HFUhgjJRVqRJN/3QMvgY9JZiGoWZumPzpduA+up13GitWVB4+vYM3lji6gx2JsItD0nJo/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxKNlImoN2AOlzPNEZlqNtFJleNQ2TIIneB9K4bjIOA=;
 b=SMW3A1qX17mCn/4WpwSxIXJNrEwJXqULNsgkpZzo1vIXRP/5g0jImAMav0sy8ZU6edR/mXdJXSjxmmRmWTag7hfY6unyf9/f/5iXvTH8NswXqPFEFysNX7VXTKTP+93BVK08XXM/PFh/NoF6WlMJfGz99L1nqsNfXF6hy6E97MtqaG+ctwuVjZBV0L6wbCR47g0fGDtAt/ht5RWTiuJpVFOTtrNd0+XCciciRb+6aEbw8hD4J9kb5D84IJ01MTHelcDVu1SSX4Z+eiRoTKU07CgV1XyFMW0AwfL0bdH9ZEq8lhqr7EjuH0xjFhVdca8TIKkPacRoiBUK7NDedkVwsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=ti.com smtp.mailfrom=phytec.de; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine header.from=phytec.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxKNlImoN2AOlzPNEZlqNtFJleNQ2TIIneB9K4bjIOA=;
 b=pw0/lO4hvIaNnb6bjkppm8hEJbKfB8xntXjPnMS1LP208jmujQqfHZWF0YLfSWrtU/5VlJD+ht5FEKQaNEQbazIIddXxyT7orpbIbyuQlzRyfcQ3vJtGRfY3fXJixUIUltkgbB1iyRX1+QAkn9t5dQxQUjQKa84/Vg9kJwrpCEx6npcfMPaBHofWMNVA5nUyCWpz7AQUJFhXBwqUFhgsE9xw99qP5MaKgs34p6Mk0j+x1OfdUF8gCwNPS+aH6eJgDg4BHRywOg5lQSft8lHYgpeiJx4u+Er1ltc/IcqiYRmgPgggXZmZE3Dqti7t2dIyCkv6qjVAJnLdU879nJVCtg==
Received: from DB8PR06CA0047.eurprd06.prod.outlook.com (2603:10a6:10:120::21)
 by AS8P195MB2120.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:56d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Wed, 5 Mar
 2025 08:55:48 +0000
Received: from DU6PEPF0000A7DF.eurprd02.prod.outlook.com
 (2603:10a6:10:120:cafe::ee) by DB8PR06CA0047.outlook.office365.com
 (2603:10a6:10:120::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 08:55:48 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU6PEPF0000A7DF.mail.protection.outlook.com (10.167.8.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 08:55:48 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Mar
 2025 09:55:45 +0100
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Mar
 2025 09:55:45 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
Subject: [PATCH v2 4/5] arm64: dts: ti: k3-am642-phyboard-electra: Reorder properties per DTS coding style
Date: Wed, 5 Mar 2025 09:55:36 +0100
Message-ID: <20250305085537.3976579-4-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250305085537.3976579-1-w.egorov@phytec.de>
References: <20250305085537.3976579-1-w.egorov@phytec.de>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7DF:EE_|AS8P195MB2120:EE_
X-MS-Office365-Filtering-Correlation-Id: 26a2084b-4105-4618-4f2a-08dd5bc3860a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7WxeLMA8s0eLdiD9NemT66oT/F92EW7ygSq0Bsgoc/S1pIEihBw4O5xfnOA6?=
 =?us-ascii?Q?utrU1cw4Ex8iTDWkkXDxgne3qP0VaA/viKEJBX8cIq9oeQD4mhmKi0oAI71o?=
 =?us-ascii?Q?SHUCVGyzSUposnbANKF5QIFLRdJeETNNYXzCG5gKEtrj6WDQmA8iorTXSU+F?=
 =?us-ascii?Q?krwjG7RKu7gFZ9EKYWIOfqlVgmZy2bie9HntfHLOtE2x59RZRSeGp5oz+8mj?=
 =?us-ascii?Q?6qk7qTxRG/5q9LtGx8QsEJVWg4Gbg+mx9m6VYkdinsKa+HUpyqPdYv24YGDn?=
 =?us-ascii?Q?asSAQKieEfNhdiNhC4jNbnVIeAEfBhO5Pq2HTtMTjcdrHamb7nuGKXDtAX9E?=
 =?us-ascii?Q?jmPWB0Jt1OMUb0dk73T3x8KvOQvEG3HBqc9XXasRQ7pWFJO1EWjIOlclzjRx?=
 =?us-ascii?Q?BOt1Rb0k6WMKhowJLxxuJajFDv93PcXfFVLHZfcAqE2wNFoLzRoZB6NHd2Wh?=
 =?us-ascii?Q?rqtxd4+ipChYm8GmNZ+tMnPDLtsyWPGracQM3we8/dckmH8BfcAmCUsB4EqS?=
 =?us-ascii?Q?Vg9a22CnHM3XRoHaOZVfuFbJ7rkD7yn8IZ0gd3CSXdet7euYx4Ig10pSUZzM?=
 =?us-ascii?Q?+V6Db0SJ4q9209m45vlz3j8+KVH5OeHm5++VZpUiUS1LWSz9Xr3OZGyUsbF3?=
 =?us-ascii?Q?Lb2/ttNBg6dHg6GkRToWFDqBqkxG6yTWGiMWsDdZnTQQUpK9eoMAeYNi4w0k?=
 =?us-ascii?Q?nx8fj8+OnNS9ZnzjL+RPQrPJCSa58nzZ1mnS41VTo1Y61eM1msmLF8q5BG9k?=
 =?us-ascii?Q?Jv/CQcMpflHPU4NbzmwqYAeRnZbMeyRFUEOLWURYaul5h0KpAraLYgHz/jj4?=
 =?us-ascii?Q?CFPtXOfmzds+kK5I+pBHUmxp80f8NTDL4Pm5Aa6uqh7dqfzGnDQ1en//ZPNw?=
 =?us-ascii?Q?8yy7sGPrlGTW7fSFngPkFhLT5R7ZAdizHt8ZdgoEY72RzQY0SNwonYLcJxE9?=
 =?us-ascii?Q?BjdSStjEasxKvnsL3BdWbfZqO8kfiwWogmob5wmtzge562kCm99x8KOrW7r5?=
 =?us-ascii?Q?QsWzntcJ6pRBkMDeEk4d8xOPi65x+zdjOa22z0/blnY1o7g1qQCpAljodfIp?=
 =?us-ascii?Q?oV3DEp9Cxh2HE4TaWzF378hy91xpi8OUzfT+IQZv+56qNbaj7dCsX9B55nOQ?=
 =?us-ascii?Q?OacIShnvPULiWi/jhM8tw+qhz4K5LVFuZH+OPu9rvAwvrfmPvHjfS9Di5LYu?=
 =?us-ascii?Q?TYYBRkBdXh+2pE7YYr84uXbeRPetWKS3xfbNcQdWtyJFBRggKzXrwYLkYyIv?=
 =?us-ascii?Q?Z2sMxzXY08oI2i8bD295lAwOWehPaWhsUVLbzX+yeS3ZEdsiVrwhkb5MDqh7?=
 =?us-ascii?Q?szjlRQL2zyldzO1rwJqs14MNeMBmCHe3JgbVUQNDcgP/wLK4v0AW+35YnG3I?=
 =?us-ascii?Q?ZfD0S+p3mOoTvNoEvmtd7QECoASQUoAfmrywdbWPQvYuMEUbKIYZvoGusdFI?=
 =?us-ascii?Q?tqydAeqmQENn9Vtpx5WaZqTnpJZZ0Ssd54wXDudgRKpqz8Ct91dU2eaLsH2T?=
 =?us-ascii?Q?0oHkgbp8vxg8Ves=3D?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:Diagnostix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 08:55:48.1426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a2084b-4105-4618-4f2a-08dd5bc3860a
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB2120

Reorder properties to comply with the DeviceTree coding style guidelines:
https://docs.kernel.org/devicetree/bindings/dts-coding-style.html

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
v2: No changes
---
 arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi    | 12 ++++++------
 .../boot/dts/ti/k3-am642-phyboard-electra-rdk.dts  | 14 +++++++-------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
index 74423ca3204f..5d7da292eeb9 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
@@ -206,22 +206,22 @@ &cpsw3g {
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
 
@@ -270,11 +270,11 @@ mbox_m4_0: mbox-m4-0 {
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
@@ -375,9 +375,9 @@ &mcu_m4fss {
 };
 
 &ospi0 {
-	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&ospi0_pins_default>;
+	status = "okay";
 
 	serial_flash: flash@0 {
 		compatible = "jedec,spi-nor";
@@ -395,12 +395,12 @@ serial_flash: flash@0 {
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


