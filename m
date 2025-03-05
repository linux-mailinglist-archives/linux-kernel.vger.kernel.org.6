Return-Path: <linux-kernel+bounces-546330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E99A4F947
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E091696E2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16B31FF7C4;
	Wed,  5 Mar 2025 08:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="DpopiKp4"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2135.outbound.protection.outlook.com [40.107.249.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935201FCD0D;
	Wed,  5 Mar 2025 08:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741164955; cv=fail; b=iRCon5y2vyc+/Gh9yWbAFin0E2KtgW1MAAGlR15ZOCWE34PZYcgN5RjB3Gq382Ec0MKjdr80DqHew5bhv+jRwF+u5kdYZ1E/e8jv6YrWKsOSw0mRvhLwuczz2cmRQxwFnWXgl8I6UsAkfHk/a/CsxnaA/esCHwgKVpNJOFAL04I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741164955; c=relaxed/simple;
	bh=nmGnNWQKfWfcJTOMZcG4nC4ellALkl/d0mZwhAQ31vY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+Eap18diYuT4rl5umTlhgGcup62TzPJOe0D4nYGWpvyJZPwqddQ3UtSBCQxonX5TJpXCMTGdMkfqRIavxUOIK711BsYayw53WSvE6DnZBq3BaWUD4QC0kNyINIWArR/VRa2+ekN1IYyD8Zqy41Q0he/dgZJaFsAXNK9FY+/BzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=DpopiKp4; arc=fail smtp.client-ip=40.107.249.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EH1A/Tsyw8X3zGkOMNynTLjk+2tsQ8GOk6s/BG6Jhyj/8WdpNCViiUqrfl3UVxemVIV16Gw22Q9pAsr6R0QqzEdcMWpJ49JFaoCjGaawgc6RAcYx/FOKSIeClpZ+hi9W/13Odw6VQsHa6/elbbYbqNVK4Mw9RsaBTzjyCi+89cx3WOWe4zEii5rewrBOsp7l4IGASsuh3T43ketNsQxU5Oriv79mZO43usIlPen8qYVp1w1y6F+6nJgLGX838j4liMRqrcENTkPadCU68GpHCzWJc33izVtHnncz+3pr/uVuC5STqFEG4nSsaxZrB59ioLN4qGwJTYSYzE/d7D6qxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HybTpq0lnFS4mhIWJVLnsRWrXT0DZJ+DM9dhqtvpULw=;
 b=njz1+sUsR30t3a89iZ9InxLvqQhwaSI1OwsGd8SZQyO62SRIJd5UZv6Nu/SCUK9ggzP/yPZAQTukZjlX9OJPBkZnBl3mfN86B9aCsn23XaqtystdKeR8O0KN0vW3KuZyxdu8Ooo5SG5EHPaxLhmuGsJREyom4NR75Sn6eFiJyhLvfrHYvX94ndWGuAlEOERitDucTkcIkNbgtRxshef3/MjxFFev5zNcfjDIS3CINhaYdgHFN1HwcU9T4jBqYOOFiE0bDWci5j6FvjmB6p2WQ5zUIc8o1ypOikRv+n1sgMsHPvDQNydNrNrRYlA0RqHtJVeUb6k6DbMleWUqRPCevw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=ti.com smtp.mailfrom=phytec.de; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine header.from=phytec.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HybTpq0lnFS4mhIWJVLnsRWrXT0DZJ+DM9dhqtvpULw=;
 b=DpopiKp4AYgyEM9Fbhss4mgNzDhj65iKclY2+DIcHXOSCGANQkRM+n6rd+DLFiFHIZHmW0Q8/UmOaFp4BM52am3ng5pBd41yGd6euCBKAd1G5f5X5To50z4FgEW8SZNu19lOTq01wvsqKH+px+XhJDZ81UhRNnUxrWA1OoGQKT97OZXIoMi3UKq+f5mP17y+WtVVhBv9C/BZVr3GseQ7pUkhkJNcpqz5ixMKGidsUxQpHIrz2m7kUlKu0o+j5kHy3j8jwLDtgApl+qOITvjHyQWiQ5zLcNg4AwK8hDZb4+1J3Rl7zkvvkmRhBhg+pN0wGwbWo3+VWK6g0ByBYV79nA==
Received: from DB8PR06CA0047.eurprd06.prod.outlook.com (2603:10a6:10:120::21)
 by AS8P195MB2120.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:56d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Wed, 5 Mar
 2025 08:55:47 +0000
Received: from DU6PEPF0000A7DF.eurprd02.prod.outlook.com
 (2603:10a6:10:120:cafe::b4) by DB8PR06CA0047.outlook.office365.com
 (2603:10a6:10:120::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 08:55:47 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU6PEPF0000A7DF.mail.protection.outlook.com (10.167.8.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 08:55:47 +0000
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
Subject: [PATCH v2 3/5] arm64: dts: ti: k3-am642-phyboard-electra: Add boot phase tags
Date: Wed, 5 Mar 2025 09:55:35 +0100
Message-ID: <20250305085537.3976579-3-w.egorov@phytec.de>
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
X-MS-Office365-Filtering-Correlation-Id: fda44280-e6a5-42c2-520d-08dd5bc385cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WMChxNhna4g/aOlHN/RoGGrvXOvOmqAxtX8tbXPGEI2h4k+lr0cIVoD08MC9?=
 =?us-ascii?Q?0LQNSu6pp8kNszHOWHwAFkzdnrwd9sNX0P3G2e6Hwjl0JOYOYmcxLfHsCEYt?=
 =?us-ascii?Q?oN46Q0dD7dVUE/6UJcgkCMbpWCQ6/EQRQYSYkl+sZouu3Dg4Quo7cFBhgmis?=
 =?us-ascii?Q?LF/5qXmKmmVscTM4bXYvXHZWTCu/07cvlIGtAYIdW02U9tZAwGpVfIVIU04e?=
 =?us-ascii?Q?2aurKz5ZcJHuNtuZmgJgnEoRctbcSXoP15w28x4NB2eC+v2+zCI3vunZxnut?=
 =?us-ascii?Q?zPLPKT0+vE84ly7Eu56rpUxmutOFZDeyH5M66f7+7Ic4gNQDcKsBk6GXFkzu?=
 =?us-ascii?Q?j8szMmByPPuLP6az2QeZ8eh8A7ALiv+tIDHA972dLsPC7H17zPd/d5pHINpA?=
 =?us-ascii?Q?ODDiCCG8CxIu8+TkiKN0e00tEctd63plkSNQwHH0X1Lv9EMIckd8ssDRuC0o?=
 =?us-ascii?Q?dKXSFxk5Ffn0GVvLNkBOlc9FWHPAxKIPF8swtuWFn+7N4cpZ8OaA5mM4XC7E?=
 =?us-ascii?Q?lSjzyklt1jN0KcGVg/xhYnsoT8GdondQiqoK1tS2YNhq6vdSlUUt6IQspEcg?=
 =?us-ascii?Q?3k/lSLAjbupRmqmnBU4v4afWHHdIPfD2uMGwNQNsLs8SjIbTvcWzZTVAThnp?=
 =?us-ascii?Q?nhenw/oSLp99kRIVinEUup+4eCejmj9QeS7rKjQmaw3+/hZ+iCRlwyy/ofxD?=
 =?us-ascii?Q?JgVbKTUTaSYR77HCr0MH27Na6aFT0dANEwSFBCdAgVNAs4mVTVbOfUScdp+o?=
 =?us-ascii?Q?rgmOQhSGiigey63QT2PG+R9p7MRuIrMX7kl3rO/5u7dG/Z3hN75d6onnwrfk?=
 =?us-ascii?Q?uolWMDpPGNAcUxmwAEGiHt4lT4AiNsbF6SlijxwFuMKSt0uLKrl03xGZXl4O?=
 =?us-ascii?Q?vB06hTrs1PIzFRR+ROrfJVs212tOf/oVbbt5/OGegr/e/fOqoIQ7DuDh0vDU?=
 =?us-ascii?Q?srqKPDDhbd4V2uEEh7RlWvQCuyJAv1TBj8JjbLjZ8K5FcqT7vn1oqA9tqKNc?=
 =?us-ascii?Q?cQakb/EOb53ko4jpE6OCxZZPpagvMbCzA7UNh1bcJMjj4ZjTuoboodCh7MxP?=
 =?us-ascii?Q?CrSmzCONmptF7rtFKeSHs3yE2kjfQKKHYZR6t4+KNimlvtGj8X/N8qzgd4Fh?=
 =?us-ascii?Q?l/xokfH/mAdVHXIyMeKNbga2ynQQ14PoxALWQX1NCyO6gtmN0bno+Tn4V8v6?=
 =?us-ascii?Q?BxWP+63LDZ7tTkjrjL5mv+m0Uehp+7iFcbqtlGo39auI1ZQgaVE9drLdCa2F?=
 =?us-ascii?Q?d/km+0fqxRrRNkErsyJxWQeUpmi+FPjfmhSTx+0dIYkvehKXyH4wa/N7Sw+n?=
 =?us-ascii?Q?FpGvAqFsYlq348FSnC/E4gihCphx8CdNmXJxXCrkbSht2oMRqOmHsppKH0DB?=
 =?us-ascii?Q?khX+Ipa6PwSm9QYc0YOCd6pp17bGdFn/q9nYsMdiXbYsNkjyFjFO4Ia8UDri?=
 =?us-ascii?Q?XULgpR0hx/j/GBT5Fp/u5umngImMnonVBufkCg2aSGdJJqTDgzQpTF/4ZXkL?=
 =?us-ascii?Q?L0fauQmKO519h/o=3D?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:Diagnostix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 08:55:47.7363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fda44280-e6a5-42c2-520d-08dd5bc385cc
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB2120

The bootph-all and bootph-pre-ram tags were introduced in dt-schema
(dtschema/schemas/bootph.yaml) to define node usage across different
boot phases.

Add boot phase tags to all required nodes to ensure boot support from
all sources, including UART, Ethernet, uSD card, eMMC, and OSPI NOR Flash.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2025-February/1006243.html
v2:
  - Add bootph-all to main_pktdma
  - Drop bootph-all from cpsw3g
---
 arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi   | 15 +++++++++++++++
 .../boot/dts/ti/k3-am642-phyboard-electra-rdk.dts |  5 +++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
index 99a6fdfaa7fb..74423ca3204f 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
@@ -27,6 +27,7 @@ aliases {
 	memory@80000000 {
 		device_type = "memory";
 		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
+		bootph-all;
 	};
 
 	reserved_memory: reserved-memory {
@@ -132,6 +133,7 @@ AM64X_IOPAD(0x01f8, PIN_INPUT, 4)	/* (P5) PRG0_PRU1_GPO18.MDIO0_MDIO */
 			AM64X_IOPAD(0x01fc, PIN_OUTPUT, 4)	/* (R2) PRG0_PRU1_GPO19.MDIO0_MDC */
 			AM64X_IOPAD(0x0100, PIN_OUTPUT, 7)	/* (V7) PRG1_PRU0_GPO18.GPIO0_63 */
 		>;
+		bootph-all;
 	};
 
 	cpsw_rgmii1_pins_default: cpsw-rgmii1-default-pins {
@@ -150,6 +152,7 @@ AM64X_IOPAD(0x01f4, PIN_INPUT, 4)	/* (V5) PRG0_PRU1_GPO17.RGMII1_RD3 */
 			AM64X_IOPAD(0x014c, PIN_OUTPUT, 4)	/* (AA14) PRG1_PRU1_GPO17.RGMII1_TD3 */
 			AM64X_IOPAD(0x0154, PIN_INPUT, 7)	/* (V12) PRG1_PRU1_GPO19.GPIO0_84 */
 		>;
+		bootph-all;
 	};
 
 	eeprom_wp_pins_default: eeprom-wp-default-pins {
@@ -169,6 +172,7 @@ main_i2c0_pins_default: main-i2c0-default-pins {
 			AM64X_IOPAD(0x0260, PIN_INPUT, 0)	/* (A18) I2C0_SCL */
 			AM64X_IOPAD(0x0264, PIN_INPUT, 0)	/* (B18) I2C0_SDA */
 		>;
+		bootph-all;
 	};
 
 	ospi0_pins_default: ospi0-default-pins {
@@ -185,6 +189,7 @@ AM64X_IOPAD(0x0024, PIN_INPUT, 0)	/* (N18) OSPI0_D6 */
 			AM64X_IOPAD(0x0028, PIN_INPUT, 0)	/* (M17) OSPI0_D7 */
 			AM64X_IOPAD(0x002c, PIN_OUTPUT, 0)	/* (L19) OSPI0_CSn0 */
 		>;
+		bootph-all;
 	};
 
 	rtc_pins_default: rtc-defaults-pins {
@@ -204,6 +209,7 @@ &cpsw3g_mdio {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&cpsw_mdio_pins_default>;
+	bootph-all;
 
 	cpsw3g_phy1: ethernet-phy@1 {
 		compatible = "ethernet-phy-id2000.a231", "ethernet-phy-ieee802.3-c22";
@@ -215,12 +221,14 @@ cpsw3g_phy1: ethernet-phy@1 {
 		reset-gpios = <&main_gpio0 63 GPIO_ACTIVE_LOW>;
 		reset-assert-us = <1000>;
 		reset-deassert-us = <1000>;
+		bootph-all;
 	};
 };
 
 &cpsw_port1 {
 	phy-mode = "rgmii-rxid";
 	phy-handle = <&cpsw3g_phy1>;
+	bootph-all;
 	status = "okay";
 };
 
@@ -266,6 +274,7 @@ &main_i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c0_pins_default>;
 	clock-frequency = <400000>;
+	bootph-all;
 
 	eeprom@50 {
 		compatible = "atmel,24c32";
@@ -330,6 +339,10 @@ vdda_1v8: ldo1 {
 	};
 };
 
+&main_pktdma {
+	bootph-all;
+};
+
 &main_r5fss0_core0 {
 	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
 	memory-region = <&main_r5fss0_core0_dma_memory_region>,
@@ -377,6 +390,7 @@ serial_flash: flash@0 {
 		cdns,tchsh-ns = <60>;
 		cdns,tslch-ns = <60>;
 		cdns,read-delay = <0>;
+		bootph-all;
 	};
 };
 
@@ -386,6 +400,7 @@ &sdhci0 {
 	ti,driver-strength-ohm = <50>;
 	disable-wp;
 	keep-power-in-suspend;
+	bootph-all;
 };
 
 &tscadc0 {
diff --git a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
index bc8e1ce11047..6fbd8d932396 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
@@ -171,6 +171,7 @@ vcc_3v3_mmc: regulator-sd {
 		regulator-max-microvolt = <3300000>;
 		regulator-boot-on;
 		regulator-always-on;
+		bootph-all;
 	};
 };
 
@@ -275,6 +276,7 @@ AM64X_IOPAD(0x0290, PIN_INPUT, 0)		/* MMC1_CLKLB */
 			AM64X_IOPAD(0x0294, PIN_INPUT_PULLUP, 0)	/* (J19) MMC1_CMD */
 			AM64X_IOPAD(0x0298, PIN_INPUT_PULLUP, 0)	/* (D19) MMC1_SDCD */
 		>;
+		bootph-all;
 	};
 
 	main_spi0_pins_default: main-spi0-default-pins {
@@ -291,6 +293,7 @@ main_uart0_pins_default: main-uart0-default-pins {
 			AM64X_IOPAD(0x0230, PIN_INPUT, 0)	/* (D15) UART0_RXD */
 			AM64X_IOPAD(0x0234, PIN_OUTPUT, 0)	/* (C16) UART0_TXD */
 		>;
+		bootph-all;
 	};
 
 	main_uart1_pins_default: main-uart1-default-pins {
@@ -413,6 +416,7 @@ &main_uart0 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart0_pins_default>;
+	bootph-all;
 };
 
 &main_uart1 {
@@ -429,6 +433,7 @@ &sdhci1 {
 	pinctrl-0 = <&main_mmc1_pins_default>;
 	disable-wp;
 	no-1-8-v;
+	bootph-all;
 };
 
 &serdes0 {
-- 
2.34.1


