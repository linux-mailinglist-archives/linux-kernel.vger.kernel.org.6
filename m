Return-Path: <linux-kernel+bounces-538308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D87A496FC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B665F3B1A41
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C6425DCE4;
	Fri, 28 Feb 2025 10:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="idGz34hR"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2113.outbound.protection.outlook.com [40.107.104.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BAB25D91D;
	Fri, 28 Feb 2025 10:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737921; cv=fail; b=HugIimZPAyQUpeUm3DHMsrmJfEvizBYVGnCuYj4OQaCUktTGkiHyX12zWX5OZJaxjf4Q/Ks9nHoLvOMPRx2FXW/mr8ephZWwqMVTklrgIAuXnjCZ9Yc8XYWPPqohkoj6TQ74Q671zqdGrTW9EUEd08Bgl+iQRKnw6i00rodYQAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737921; c=relaxed/simple;
	bh=oBNbO0YDsFSxcHDjL0raH5Ni/8EmxVK8mOwFePfFI+E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F0hj4rWEmY6SRUg6jqGaf1xvvF6n+UP0oSB0zrxMVA7Patd2ONcUheaHqyCaIFATWWD/+sKQmKNByrGkNsD+CmJs5ToetpLnmNAmH5TpA1tA1fimnbt7OSBi4C4596uOk5kZk8nA63XoWnqgO+BRz36SFwuJ+c7sAlfhTdXNMq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=idGz34hR; arc=fail smtp.client-ip=40.107.104.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEeykX0cOrj2PayJ+tPTZe74OY+RSLfgKh8eM8h9cp9RUuxD4Lc3yDlp+HyZvvYVOnYUPbgNgBzM1oaPXfwd+/ezsrL/L0KRi53fqVQ/O6Cms72m13ZK7puj3TQoSUdja6xn8OXiAws5qaF3FnGlpUWruOjJVIJIPUb4ry+cMBv+a/v/DBFxvlgjhfpM2aSo46sqn9avX5CvcfHTZwTFEEm4S3xerDRnyc0I6FpZmh1mRlSpSkXb39iA7T5+d4UyYlOVZI2g49hY3xWrx1Q/pUNDIAYk93oTfxfaqx6rLVxljrkoGHPFAqXAup/OqE3mgOR7Zw7n3BqqVB7dkwlUsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOjEf/vwG5NtXAxyilKF2t/fnUdyLrxQir2soHUfYmY=;
 b=f6sROkemC2MkP/JegvQmscUNq/QkgvpWtEMe7qBu8s7ky3MAp71P/4ZcIuJtArWa6KkwMgapk/edC7SiQ658yJ6tB5kD94czDeCbKi++wQmMC1mUPE8j77fvLe+8n5lySurrU4Lrt2rj74HXeie0AFINvJc8E8Y2CSUbo0OM3rAdFEhxYUPLY2uvo5KxFVziyrJVwkRPbGtvjPi+4j992ip4qWddnWnz2mSe+rAWEDvtBl3la0+6XjJ057L09H39W64ifrg0z1MCyCg+lLw1xDii9n8k62ohQN1CouEtvo3Zcd7AT+qVRXN6E3uJca/rdgQhSf6oLKjYzvHuWDG7SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=ti.com smtp.mailfrom=phytec.de; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine header.from=phytec.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOjEf/vwG5NtXAxyilKF2t/fnUdyLrxQir2soHUfYmY=;
 b=idGz34hR1jUj0BcD0p/FCBi6NXirVy+5q//z9ZnvWXZkZe2AocucrG65zeMf0046Oob98LC6LKFUKCnkxnHU7kbwuVs4GhZ0ilUtgdHNc+HzgjpCBE+SV6WZLQj3Hqc46AWKA7p2up9f/zH3Ik3VQLWrPeyfMAEyCYaAxbU6n8GibPMgmPsHXU0/+u+cX9QNtD2KwXVhE7bxgVvn1ki7V2jRXXPImlw5Tn1ivNzVVqv9JTaHNLCQHbYnv1Pu2yqdheJWTGsI/Ra2MxOkMA3WxHrfA1CmyhjlzW6Ah/t8dGHDawDXdNjSAqiKMWxAguM/b/Sp8vPKA9ZyW9upEe5bew==
Received: from PR3P193CA0010.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:50::15)
 by PA2P195MB2535.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:407::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.21; Fri, 28 Feb
 2025 10:18:33 +0000
Received: from AMS0EPF000001A0.eurprd05.prod.outlook.com
 (2603:10a6:102:50:cafe::4e) by PR3P193CA0010.outlook.office365.com
 (2603:10a6:102:50::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.23 via Frontend Transport; Fri,
 28 Feb 2025 10:18:33 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF000001A0.mail.protection.outlook.com (10.167.16.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 10:18:32 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 28 Feb
 2025 11:18:32 +0100
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 28 Feb
 2025 11:18:31 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
Subject: [PATCH 1/5] arm64: dts: ti: k3-am62x-phyboard-lyra: Add boot phase tags
Date: Fri, 28 Feb 2025 11:18:13 +0100
Message-ID: <20250228101817.865811-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A0:EE_|PA2P195MB2535:EE_
X-MS-Office365-Filtering-Correlation-Id: f211d8c1-87d4-40f6-1acc-08dd57e140f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3IxQ4+e9r7ABV39Xz7Gpd2O5o/HT/Yd2dMXZatKCefw8gHzgD351idKnORvK?=
 =?us-ascii?Q?nIN+yZjJeNhjO5HHPncPY6jn9wJ9vGACzwO7jlvtirIsbdMH8v4i4KkG1uAc?=
 =?us-ascii?Q?TEQJn3ijJF9qGqsFlS3ejmSMgvTPSYAZpA+XTNaUPDh+j2YMP1P5/PnGr2nO?=
 =?us-ascii?Q?Xjm6IGbPb285GJnfXMjxLWVSvNn1Duj46GRQ6Z5TH7n3bN1WNo4duGte5kQM?=
 =?us-ascii?Q?Dr3ZYuBt9G2O9YB1oGNSPO8f858H27Vai8TsP0Trj5RuZUS2H70325ngomgM?=
 =?us-ascii?Q?3WOTb0E6ZJs0j9DOpE0siyEmrxQ8i2Teg8d0zLqHAzJV0/DzrZp9dEqVdFUt?=
 =?us-ascii?Q?NhrCF+tHF82l2n/ci3ASbuqDLEbIr99ZSUypgF79uSg+xwlQngrjKWSGQ51U?=
 =?us-ascii?Q?CWbVPUx2AxD0BblXrMa60AllRbHSUTT+bFMI23lXz6FKQJLUplLgssG0043g?=
 =?us-ascii?Q?IRK+yqIysm6u7DoPsE5sllNfTLXh4a7dYxZoTrZOnG/oanPNC5HNRLxWEnRE?=
 =?us-ascii?Q?Pcbp1ProJIRYgaQ/broHqgyu5h8eqj2Smf4TDxZO4RQHkiO5b1rS63WLfbTZ?=
 =?us-ascii?Q?aUCq7j2qJuva7kgmuMQvsqA9QoolUFWRWC/A4Q/WnQb299zORQE/y1UFP+Y0?=
 =?us-ascii?Q?EUuBmHRqvb+F0WNsp325FMVxqvYAk1hDgQtOBAjrBPTiCbyMtv9cqVcWLvDT?=
 =?us-ascii?Q?hGVcGy7PBElsfiV+WEuga98vyqZIVqVx4/yPmdOLqCbw1jYNkbKuRi7BXBJe?=
 =?us-ascii?Q?euhxwdt6GBNLOSc72ZqM9tlyFU0MYjuR0OK+tofrDZBxMnsh5efBAn62hqcM?=
 =?us-ascii?Q?CglebT1nxeMg9VlqW/YUbMHFMW3/n0dflVBjbppHH3kc/UT+58fhrAg9bhwx?=
 =?us-ascii?Q?bhvax2PAnjpB/GtbXXP0Hqba43RiY5mowIR9U2hjMWvs6MND5tNjJWvWhKXK?=
 =?us-ascii?Q?y13Aw8ZqXU0GOIL5rgzd/ZQk88rroJgbjxFUb2DAgtW83q3gfPt9vvKfKNsH?=
 =?us-ascii?Q?NEl+x63KcRPxZea60svME7IJFlmPl+DGwSrXVUcAgVnSDrQTF8eombPi5RIi?=
 =?us-ascii?Q?Xa5TsDMzA12T9jBUpJAiksRDYk6xV4LHQYf7CRRDVayiyPhY06Gmf4/P/g2T?=
 =?us-ascii?Q?lgvf8xduRiQwwy3egMZ3b6mG08Sh7L8OG/CEd/Z+LlwrJ6LFuRGHIk2fXZbj?=
 =?us-ascii?Q?wdqnoDhGnDoeliNaFq/NXJbzKA6YMt1zm0myDlNikY5SPjgyQ4KSMvBQA2Tm?=
 =?us-ascii?Q?x/fA3kXq+145b+99TIMGQJS7T1wN3C6Y437QHsgHi+7Crak83NZDXGIMkW8/?=
 =?us-ascii?Q?nL7SFVMoH0lPMew/uouPplRQlDlrWnbS98DTcDZWX5Jmkh9nVfwrJiy29s4Y?=
 =?us-ascii?Q?pd4SBD2VgTXshxjsdpwphKVXoSo6202z5XRwicWLCocE6QfW6JaNKChxNxGi?=
 =?us-ascii?Q?3dCkjkqPKeQkVRBdNpTHswom6PrDXAzPI3HvnvhJfPgmV3QCVizWcA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:Diagnostix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 10:18:32.5098
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f211d8c1-87d4-40f6-1acc-08dd57e140f3
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A0.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2P195MB2535

The bootph-all and bootph-pre-ram tags were introduced in dt-schema
(dtschema/schemas/bootph.yaml) to define node usage across different
boot phases.

Add boot phase tags to all required nodes to ensure boot support from
all sources, including UART, USB (DFU), Ethernet, uSD card, eMMC, and
OSPI NOR Flash.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi    | 12 ++++++++++++
 arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi |  9 +++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
index 2ef4cbaec789..8b845bf9eda1 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
@@ -29,6 +29,7 @@ aliases {
 	memory@80000000 {
 		device_type = "memory";
 		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
+		bootph-all;
 	};
 
 	reserved_memory: reserved-memory {
@@ -131,6 +132,7 @@ main_i2c0_pins_default: main-i2c0-default-pins {
 			AM62X_IOPAD(0x1e0, PIN_INPUT_PULLUP, 0) /* (B16) I2C0_SCL */
 			AM62X_IOPAD(0x1e4, PIN_INPUT_PULLUP, 0) /* (A16) I2C0_SDA */
 		>;
+		bootph-all;
 	};
 
 	main_mdio1_pins_default: main-mdio1-default-pins {
@@ -138,6 +140,7 @@ main_mdio1_pins_default: main-mdio1-default-pins {
 			AM62X_IOPAD(0x160, PIN_OUTPUT, 0) /* (AD24) MDIO0_MDC */
 			AM62X_IOPAD(0x15c, PIN_INPUT, 0) /* (AB22) MDIO0_MDIO */
 		>;
+		bootph-all;
 	};
 
 	main_mmc0_pins_default: main-mmc0-default-pins {
@@ -153,6 +156,7 @@ AM62X_IOPAD(0x200, PIN_INPUT_PULLUP, 0) /* (AC1) MMC0_DAT5 */
 			AM62X_IOPAD(0x1fc, PIN_INPUT_PULLUP, 0) /* (AD2) MMC0_DAT6 */
 			AM62X_IOPAD(0x1f8, PIN_INPUT_PULLUP, 0) /* (AC2) MMC0_DAT7 */
 		>;
+		bootph-all;
 	};
 
 	main_rgmii1_pins_default: main-rgmii1-default-pins {
@@ -170,6 +174,7 @@ AM62X_IOPAD(0x140, PIN_OUTPUT, 0) /* (AD18) RGMII1_TD3 */
 			AM62X_IOPAD(0x130, PIN_OUTPUT, 0) /* (AE19) RGMII1_TXC */
 			AM62X_IOPAD(0x12c, PIN_OUTPUT, 0) /* (AD19) RGMII1_TX_CTL */
 		>;
+		bootph-all;
 	};
 
 	ospi0_pins_default: ospi0-default-pins {
@@ -186,6 +191,7 @@ AM62X_IOPAD(0x024, PIN_INPUT, 0) /* (H25) OSPI0_D6 */
 			AM62X_IOPAD(0x028, PIN_INPUT, 0) /* (J22) OSPI0_D7 */
 			AM62X_IOPAD(0x008, PIN_INPUT, 0) /* (J24) OSPI0_DQS */
 		>;
+		bootph-all;
 	};
 
 	pmic_irq_pins_default: pmic-irq-default-pins {
@@ -205,11 +211,13 @@ opp-1400000000 {
 &cpsw3g {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_rgmii1_pins_default>;
+	bootph-all;
 };
 
 &cpsw_port1 {
 	phy-mode = "rgmii-rxid";
 	phy-handle = <&cpsw3g_phy1>;
+	bootph-all;
 };
 
 &cpsw3g_mdio {
@@ -220,6 +228,7 @@ &cpsw3g_mdio {
 	cpsw3g_phy1: ethernet-phy@1 {
 		compatible = "ethernet-phy-id2000.a231", "ethernet-phy-ieee802.3-c22";
 		reg = <1>;
+		bootph-all;
 		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
 		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
 	};
@@ -236,6 +245,7 @@ &main_i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c0_pins_default>;
 	clock-frequency = <400000>;
+	bootph-all;
 	status = "okay";
 
 	pmic@30 {
@@ -355,6 +365,7 @@ serial_flash: flash@0 {
 		cdns,tchsh-ns = <60>;
 		cdns,tslch-ns = <60>;
 		cdns,read-delay = <0>;
+		bootph-all;
 	};
 };
 
@@ -363,5 +374,6 @@ &sdhci0 {
 	pinctrl-0 = <&main_mmc0_pins_default>;
 	disable-wp;
 	non-removable;
+	bootph-all;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi
index 922cad14c9f8..aab74d6019b0 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi
@@ -138,6 +138,7 @@ vcc_3v3_mmc: regulator-vcc-3v3-mmc {
 		regulator-max-microvolt = <3300000>;
 		regulator-always-on;
 		regulator-boot-on;
+		bootph-all;
 	};
 
 	vcc_3v3_sw: regulator-vcc-3v3-sw {
@@ -233,6 +234,7 @@ AM62X_IOPAD(0x228, PIN_INPUT_PULLUP, 0) /* (C21) MMC1_DAT2 */
 			AM62X_IOPAD(0x224, PIN_INPUT_PULLUP, 0) /* (D22) MMC1_DAT3 */
 			AM62X_IOPAD(0x240, PIN_INPUT_PULLUP, 0) /* (D17) MMC1_SDCD */
 		>;
+		bootph-all;
 	};
 
 	main_rgmii2_pins_default: main-rgmii2-default-pins {
@@ -257,6 +259,7 @@ main_uart0_pins_default: main-uart0-default-pins {
 			AM62X_IOPAD(0x1c8, PIN_INPUT, 0) /* (D14) UART0_RXD */
 			AM62X_IOPAD(0x1cc, PIN_OUTPUT, 0) /* (E14) UART0_TXD */
 		>;
+		bootph-all;
 	};
 
 	main_uart1_pins_default: main-uart1-default-pins {
@@ -266,6 +269,7 @@ AM62X_IOPAD(0x198, PIN_OUTPUT, 2) /* (A19) MCASP0_AXR2.UART1_RTSn */
 			AM62X_IOPAD(0x1ac, PIN_INPUT, 2) /* (E19) MCASP0_AFSR.UART1_RXD */
 			AM62X_IOPAD(0x1b0, PIN_OUTPUT, 2) /* (A20) MCASP0_ACLKR.UART1_TXD */
 		>;
+		bootph-pre-ram;
 	};
 
 	main_usb1_pins_default: main-usb1-default-pins {
@@ -430,12 +434,14 @@ &main_mcan0 {
 &main_uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart0_pins_default>;
+	bootph-all;
 	status = "okay";
 };
 
 &main_uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart1_pins_default>;
+	bootph-pre-ram;
 	/* Main UART1 may be used by TIFS firmware */
 	status = "okay";
 };
@@ -467,11 +473,13 @@ &sdhci1 {
 	pinctrl-0 = <&main_mmc1_pins_default>;
 	disable-wp;
 	no-1-8-v;
+	bootph-all;
 	status = "okay";
 };
 
 &usbss0 {
 	ti,vbus-divider;
+	bootph-all;
 	status = "okay";
 };
 
@@ -482,6 +490,7 @@ &usbss1 {
 
 &usb0 {
 	usb-role-switch;
+	bootph-all;
 
 	port {
 		typec_hs: endpoint {
-- 
2.34.1


