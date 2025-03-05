Return-Path: <linux-kernel+bounces-546331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3909FA4F948
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C39916BF39
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD4B1FFC42;
	Wed,  5 Mar 2025 08:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="bmRv7GZX"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2126.outbound.protection.outlook.com [40.107.20.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D375A1FDA78;
	Wed,  5 Mar 2025 08:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741164956; cv=fail; b=AFBbhXnbVLPA12NoX/SLUIOXIcahusoUErATa3R4brW6uK9UrKxHsbTpCgCCEbsNzx7BtaDuhz0Qwdxfg/wMdc9f2mNMvm7NYoFWWIbpJIfFSIHmPWKy2a5gaWx7oqgDnNPnbVWF1+i436iIpZh8KehkBt/HJNCPmwDxB+frzrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741164956; c=relaxed/simple;
	bh=IjH1hRQBLdaBnfMVNtzDKdFJWDXLV3LmMUk472A/2uQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EKwsMqVwCBQh/mcLVJfkTPz/P+JN7BrttRhQ0oLJcDz7kzNcLiq0xJOE6lysNn/KV1dMRE1mn9dBhR68FIqLv2yKDWGDLGCSkvFqvtu0k39gGNH4uioUczU4bKKdw6o8kRBcPrOBKiOOV9IFf/XXNiEG0hzZQeVInPCJajSICg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=bmRv7GZX; arc=fail smtp.client-ip=40.107.20.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vpk9Xi6QCr+YntwMNkwBMZbHl0TRBDsPXAM1d2SRApYqRBy38NZcysRdJB37AhA/JrUJLEbjUnmISUXNeoayQSQvvxYuTa3wCmA6/jLO9Z+cGvCRdZfcDbp/9WgS+4axKLPMQuAI+NBUK1I7DMnEUTI4NwrGXUyBay+QT0YdPA8n7kyPbSnOWoDlAG95/T2I4tG5LCT9lH0ak2tmLumj+dBOzD0FUbdkY8HjLJgnhCYQ5swvlk5nTz+VGRCuf8TBSRmwKieduJo0pgY4lQjiXx2ZjlMcXuh9YnSnR8h+Fumkoa483n5+Ea2XVJeWG9t0nkk8D2B04lttISjvxtE+cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZB0M2ql2N3QuDBtnDe0WgWufbOOAZ2mz7GO6nTfo3aw=;
 b=AISTGoeTxxsPj2gCR/TgcAHS6QbctPpWwryQ0AvouCDPl9Y1UmbDMHvHpY1I6NbILDc50kvPGCPC8h7On5AF0+SrtppAoGmPwkkEcjE+wl0UBSjsFrMupxeM01gBIthWGyx35GmE1AD6iMj5GwTMMS2jOAMO/hlJptAPAFnIqGc/CUno8gsCktRyMX7rf99QlgmF51YRvnkeYNU9QiX+MVNahLA3GeitL7VI1Hwm8X22ph2mn8N+t2Y0uKHRBpW9LtrF00QVUvfmltANPg/4UxRlZSXcOyD0IkyKYjK5XwWvBRe7tfLZfE6n698IDCmEAOY/Q4XXTOV4EnmjBIEUFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=ti.com smtp.mailfrom=phytec.de; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine header.from=phytec.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZB0M2ql2N3QuDBtnDe0WgWufbOOAZ2mz7GO6nTfo3aw=;
 b=bmRv7GZXcJ42mjCAEuNO18EMjW2AJsGoqmczDoKGQUWtFKbyOMbF811ctyJP9s5MoVGgrJxnAMc7YYbB8UkGyS7wut1E8upyMGs9iJZBABF3XWGjJAu5swJwWKfmxDd0P7f7SII8ucQO8FcnF5xp3y7oHfw9THurC17prgiHe1ot8nLPORsNSw+X1zBkseQJDkFSRQ+D2fuhdEpdaBoGjGE6h9s2Ghv05XLytqx4Dey++gEMAUilZiu4ynKO9PR6L+niasQaAZBfPUnIpaXLTH+FENc9ZEmsNIA8iO1YzX3rCz5m1nSD5SmIAK6kxIIf7ZR/ZbFqTC7fl9pfybrItg==
Received: from DB8PR06CA0053.eurprd06.prod.outlook.com (2603:10a6:10:120::27)
 by PAXP195MB1463.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:282::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 08:55:46 +0000
Received: from DU6PEPF0000A7DF.eurprd02.prod.outlook.com
 (2603:10a6:10:120:cafe::40) by DB8PR06CA0053.outlook.office365.com
 (2603:10a6:10:120::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.17 via Frontend Transport; Wed,
 5 Mar 2025 08:55:46 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU6PEPF0000A7DF.mail.protection.outlook.com (10.167.8.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 08:55:45 +0000
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
Subject: [PATCH v2 1/5] arm64: dts: ti: k3-am62x-phyboard-lyra: Add boot phase tags
Date: Wed, 5 Mar 2025 09:55:33 +0100
Message-ID: <20250305085537.3976579-1-w.egorov@phytec.de>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7DF:EE_|PAXP195MB1463:EE_
X-MS-Office365-Filtering-Correlation-Id: 05f8d279-0ffe-4ca1-9a58-08dd5bc384b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4MDB8nNyC0q2iRtzgETDpItBtNgC5PZNf9xFxrWDtj+MyhlUes1je2l3OXIn?=
 =?us-ascii?Q?qwsSjXFZ0gS64L4uXfSllMuTuJ4zElwFdOPXnZbf6bYjnLFmax26fOcYm8sd?=
 =?us-ascii?Q?3uvA99cscnA4Gt51BtvZIw6GBAvo2EC4uhZjmx9qmXJ8yqarJcYCAS+cthOz?=
 =?us-ascii?Q?lKCsKstFOsemJIxtAoLTCnYrR05a4vQkktY2d+3C7XAUU9DU7+WAp1KDoD9K?=
 =?us-ascii?Q?jyZVHqbUSMOpG97DFLa671PdKzsB50l/w/iVKTZH5G+dMMUkliHb+REVmsSN?=
 =?us-ascii?Q?Wz7rC2in98zsibnfCbErPYdGb25jPDedGzp1NpluC/E2C1ugWmWJA3yV+MQ6?=
 =?us-ascii?Q?vSxI8ltLzcvo7d3prTZU2yUWIdFSSjfQ4cY5Ux/y91bcNamcBVNTOS1iuMT5?=
 =?us-ascii?Q?30ltHoqrJDIKqiAVSr9k2b595XYMadEPUiDMS1LLSmoPVlqHwjZWw+mjb/e4?=
 =?us-ascii?Q?k64BouLQq0s+PTa+r+m/+KT1dE6QgCeA8C4lBh+HmIUplJH2ZqV7nz0sAR+H?=
 =?us-ascii?Q?/s5Icq7x9lf63FYRHufmcRuBLuKIY4smGuvSS6Z8VduNgLvXVIBXP6iP3Mz4?=
 =?us-ascii?Q?w5TBCfjo69CP+z6wVguDGKKci9OoZSeSngEJL1N0yY66SzCXa2iB9WgTpM2Y?=
 =?us-ascii?Q?LYjXvC6weveOnm3Vnyugl9ibj7lKhCU+L3NLBThD4K+riHORQ0bkszNjrK6m?=
 =?us-ascii?Q?j/wDo28UBnH3DjaQRbSoBmBtPifxIxXkFK2VKsSo+GSpakX6cbNixrIV5DVy?=
 =?us-ascii?Q?SpVKRpfIbY4R37+mZEyuDVyHFwaY9ycJtEcWjoZJS7KJ6Y+JylVoJPoe2RbM?=
 =?us-ascii?Q?6LH/83VH0EKTwhXTR7946jdIzt37e1msBGPFML2QS+UFgxb49rX/qFMLT1qR?=
 =?us-ascii?Q?XZC3hBsPuJtDITFVaCVT1SnnX6D5AGVXCYLKGl/yYqly2lMYrZGUvSk1FqvC?=
 =?us-ascii?Q?jhkv7f+dHQEn6VyWqQjhH7L5tmyV0IkeogNOTykg4mjs+gMcwcyxfyfr7JsS?=
 =?us-ascii?Q?GyGWa8mHBktarnnbb2UUUVfCAjab98u/MBRQa3FhPOM+qUSeOESQOiYinmj+?=
 =?us-ascii?Q?c7LNUGUXWFmCrncgI93UzZONz9Klo/3SYXRL/Y8eCgqwZK68CH16kkm2DEuX?=
 =?us-ascii?Q?39OryPN4kQD8Jaltmta9/y3HN5CuIgXiwZ+aYmL9O1K/Y1E3VdMGysygSDrg?=
 =?us-ascii?Q?o92hTPrIAVCJodfFKXoeP0hNhwQAi0si63Cn2PA/5C5MpaxJURl/kS1tVdzM?=
 =?us-ascii?Q?eMdynUqsJKio2F6CDEdfp4yfn55kHhGOC1rQOrF2Ek4GxiS2ymxgTtvsxvi3?=
 =?us-ascii?Q?n/eHhEp5ERejtjSck0ZzH8kX0wZZWL4Z79O258YZYsl5YP2MYNxoqYClqADU?=
 =?us-ascii?Q?vYDVvC7jHW2J9QGIziv7FVBrZmf09DYOO1v7HRCxdUcTFHhQCxTHbouUsD+D?=
 =?us-ascii?Q?0gIbsQx9+JZPlJ3LEwkCsN+IPnl8glGxoYny5ZIQ1iWNaPFdgC01rMqL1dhk?=
 =?us-ascii?Q?l6P/peZ3aSomReI=3D?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:Diagnostix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 08:55:45.8145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f8d279-0ffe-4ca1-9a58-08dd5bc384b0
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP195MB1463

The bootph-all and bootph-pre-ram tags were introduced in dt-schema
(dtschema/schemas/bootph.yaml) to define node usage across different
boot phases.

Add boot phase tags to all required nodes to ensure boot support from
all sources, including UART, USB (DFU), Ethernet, uSD card, eMMC, and
OSPI NOR Flash.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2025-February/1006239.html
v2:
  - Add bootph-all to cpsw_port1 and main_pktma 
  - Remove bootph-all from cpsw3g
---
 arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi   | 15 +++++++++++++++
 .../arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi |  9 +++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
index 2ef4cbaec789..effab2f810c2 100644
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
@@ -210,6 +216,7 @@ &cpsw3g {
 &cpsw_port1 {
 	phy-mode = "rgmii-rxid";
 	phy-handle = <&cpsw3g_phy1>;
+	bootph-all;
 };
 
 &cpsw3g_mdio {
@@ -220,6 +227,7 @@ &cpsw3g_mdio {
 	cpsw3g_phy1: ethernet-phy@1 {
 		compatible = "ethernet-phy-id2000.a231", "ethernet-phy-ieee802.3-c22";
 		reg = <1>;
+		bootph-all;
 		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
 		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
 	};
@@ -232,10 +240,15 @@ mbox_m4_0: mbox-m4-0 {
 	};
 };
 
+&main_pktdma {
+	bootph-all;
+};
+
 &main_i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c0_pins_default>;
 	clock-frequency = <400000>;
+	bootph-all;
 	status = "okay";
 
 	pmic@30 {
@@ -355,6 +368,7 @@ serial_flash: flash@0 {
 		cdns,tchsh-ns = <60>;
 		cdns,tslch-ns = <60>;
 		cdns,read-delay = <0>;
+		bootph-all;
 	};
 };
 
@@ -363,5 +377,6 @@ &sdhci0 {
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


