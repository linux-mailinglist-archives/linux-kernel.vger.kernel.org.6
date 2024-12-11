Return-Path: <linux-kernel+bounces-441290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D0E9ECC5E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1135289D6E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A496233682;
	Wed, 11 Dec 2024 12:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="drKgeb4Z"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7655322912F;
	Wed, 11 Dec 2024 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733920956; cv=fail; b=hPDtaC9pxoEztPQaJlKbIseAF/X6LRowPrfENH/wCe6dG637Uy6nhZ895UMmSJrVlnY9TA3GKMgdF2wXlRX+sFr162H4XDJ0v4T/25e4fG0QeZdRscxalO/E77FAJHm9hx2XVaKDLAbsqPQMssR+oDBsNZPt6UXILtwcnqyDBQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733920956; c=relaxed/simple;
	bh=Nb+vDAcyGcl4IICg+eRsDw+6lU+o+9KQYFKXiiedgQ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uLO5wl8EDVY5I4U/wXe83ZnKnzOTr8mJDZfdW30FY2htMhWr0vy4zS+AgrF/M3ZKuruAtioCorgAPg8ZlWIj6HG4h2H/UCUeve+w7iz17kA4FHYVAUz+O2AcRMTVy0HpIxqSIP0iA31XpjTkkBrH8u7TbKMzw7h0h18/dIO6vcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=drKgeb4Z; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xPVBsCJzj7VOx5Jgzwhbb9JWJHEVNjEP3XWYFJJwG8CCrVPLjWDhQRw7qeNUMlkRG6CrQvBT7GkX/S6CWbcpVOeI6UD8V4Vc5yw6ZOkJTjLfXKqZXYhUu/DtzfenDHIsMf0mHUb+dgp2C2s5dcx+3TjlX1ClNB6I7LqTZM+tvrA6s5KaT375GFSWrQha3qH2opnEU5Jk3IIcffBsHQaLZ9eRfThGxP9rgLBOSW8GaXxzOdZvA0EXWhbChUhdQI1wEEJP8n9mAfycAUD4cbWXCCBeJBwir+g5Flb3hQ8VowQUdD7zlPBcaGaBgZJFmJhd2praJ6T+hxoWaT9UEbWhQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pnzhbF2A6r21LSfyTQppPmzc6RIpM8bnNFqeUhsFHw=;
 b=P6HwgyWW7rzSayl0/KJ/eilsTFT7/yk+HzdY4ICk3BrzPkPa+JhNgiA54MXiPpk54YUPP+sNyrc0QQ1tQz+er8tEA1vPSvVRuBUCDnPXj8BGPMu+sB0mNVz7Ec+V5Ip4xxW166YZee783go1EY9q5sVY+Zqc5snqR8FXQ5Ky2Imix7kbZFw2PbHBvZ9nua2uBOPi4F0FkPArD53NyHC7gjrmteTxNiwNUvUzIuJclgCWtUDbP9xCJfFhtgsNrDQGwThMnaakU6ysJRbvOuQXt+Ug6Hk25MPVy7Urq+Nau3AOEF3IFxa65k+iXeeYIE0xrpx/Ta1HTqLpPv6vfgM1rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pnzhbF2A6r21LSfyTQppPmzc6RIpM8bnNFqeUhsFHw=;
 b=drKgeb4Zu4jL6msPD3yNGqQDy5Lx2cJFhIrOz+QtKp3B7+94AiDGW/GbldSk+qTm0xP50StMK8Tf9a2L88NMSHV7m57GBrxbOasBrHhBdqzhO8b19m2v/bXYzJh/jyLwYG2RuqCl0rvTZS/IrmOfzmZlGbgu2wnsQ2XBoncDpjE=
Received: from MN2PR19CA0071.namprd19.prod.outlook.com (2603:10b6:208:19b::48)
 by SN7PR12MB8057.namprd12.prod.outlook.com (2603:10b6:806:34a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Wed, 11 Dec
 2024 12:42:29 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:19b:cafe::a0) by MN2PR19CA0071.outlook.office365.com
 (2603:10b6:208:19b::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend Transport; Wed,
 11 Dec 2024 12:42:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 12:42:29 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 06:42:26 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, "open list:OPEN FIRMWARE
 AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated
 list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 13/15] ARM: zynq: Enable QSPIs on platforms
Date: Wed, 11 Dec 2024 13:41:32 +0100
Message-ID: <b10d922fec7fde0948205b266bf7e960113859c5.1733920873.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733920873.git.michal.simek@amd.com>
References: <cover.1733920873.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10956; i=michal.simek@amd.com; h=from:subject:message-id; bh=Nb+vDAcyGcl4IICg+eRsDw+6lU+o+9KQYFKXiiedgQ8=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvTIjrqbaYueVq+JebJQksGSpzvtjqHjzk83/z8ytzZPD JrBvjOnI5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEzkszHDPMW+P/GX2PL0fqsa KR1ICPNk5FTZyDDP4iSDx9VjuayR7pPjzSZpNBhvqQgBAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|SN7PR12MB8057:EE_
X-MS-Office365-Filtering-Correlation-Id: 98151308-19fd-470d-b729-08dd19e1461c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G9etWbqvHtNYB9RIipEx5ouGJ9zMedwqiWk8dLtQTjOvi7Se10O4yHwftkJm?=
 =?us-ascii?Q?ouYonsSTDmL4r/0wPUiJuneUoy9KCJOmA6jze0sWyTAKwZHIhW+aHi5PGE6L?=
 =?us-ascii?Q?B5vA2fN/qvwwVZ00aST23ragSptA3s3e3FJIkSE7xr6dS19CQtJKMqO4B0G9?=
 =?us-ascii?Q?LIMv72vhkoQJ6vVZ8zPyi1e4fWs9ya+HkrHiwxXAPTQVjdORxQ08EMJqM88B?=
 =?us-ascii?Q?ivNNoRzwZ2XUecs3OIPuzYCWpDNs3yHLoBaOAwE2O9pP87VKXWdKVed70IEg?=
 =?us-ascii?Q?1mezhUEoRugOUa+Fuv06zmSNJ+DwZuSwn/J++m+1fdsET2e5H3prDAQfassx?=
 =?us-ascii?Q?HohLhps4ifK1eG4fjskdUi/sFspxXDloTNDgPMTg4qu1Fj7zQpjVgsD4IS72?=
 =?us-ascii?Q?q/nBOF5vSIrvc6Kpm9z7upkFktB9GFd6hcobb62IHkpXF0YY7mjri6EFE+oP?=
 =?us-ascii?Q?qyi5l30l8Ytl7PboSnha6VNtl0ZX5CY0Ib3UjT6S2hkYSoiRMqt+ZXhSbU2z?=
 =?us-ascii?Q?DcUlMEyvmwXRrlxxJtlHc7Ff4FCKaAmzyFgfrrrJXanVOuxjxabU1t3uzLWW?=
 =?us-ascii?Q?cNOEPFmWvhR3sTKMA6m/lrroDIvLIC57cGyku+7mcgJAIEukUZnwrevN/imr?=
 =?us-ascii?Q?13KX79NMeDDLp3v34VtRFLo00j/J+DfgdHLhMH4dDjMS/3mzuEPxqqAM61PX?=
 =?us-ascii?Q?8RIv5CrLG4W+tr4uDHldFPSe4AjabgDbsEt5x6zcz/VQEDM+Cxyd+KOmjGTI?=
 =?us-ascii?Q?EDdr7NHoYWZHQ4FALSMTHsjuhn56BvEuECV8DpLlWxkQ8TvLlpHr/e9Bf16q?=
 =?us-ascii?Q?vlYC3bkVzr5Tdp8Xssv8ea1T7z3PCGZOKVeIY8miVTAhrPn4FSZuJ5JTuA9s?=
 =?us-ascii?Q?D+LHCe2P5GBX9I7odaGnsmqvym0fy1Ksoxq3LH8fKR+Jq/BZ6N8m4D6CK0kj?=
 =?us-ascii?Q?jmWF22MGSH1ICD7HYanPk7LRm1QDXQaHTL+5m6ropuQajoJyasGJYegoROpP?=
 =?us-ascii?Q?NKxzxOJAktlo8XCvk+Bcx+Dj+aCaULSFyxUr52dVYh7xfxg4TY1Aj62fif9J?=
 =?us-ascii?Q?OmFsbwiCLvXhlgAq1470u0HASJytxr83F905pbprrthVhIgNdksysDg+H5zV?=
 =?us-ascii?Q?IqpdQgutAABH9x0dWzfw5P+PdBfnZgY7GZ1NO+3KQ/JPVrBfC/K07tK2TW3a?=
 =?us-ascii?Q?yO1my1GweZwW99LeKZpDH2+r6vQc3U+g52g23cxePFR+BXcYdmhzJe/Nh01U?=
 =?us-ascii?Q?5ssQ14PnH/o8sBoLJHDmxuiatwcW0RYe5rGKK1IdqWb7bKoH8suAnkJEjvLB?=
 =?us-ascii?Q?+neFdpqmGNi/wMDSSsyyKHN1LzeMdAb8eJK8yP4dycyx2KvFPQMVPr4utk7q?=
 =?us-ascii?Q?hwErSo+HCNlNk3yhQ65w8kV/whfLUvgrmR6k6c2XtJaoQW+GDhaW8+bq/vV6?=
 =?us-ascii?Q?WvWWRihWFK1aiEIt0FdJUzaFNu/nSiEW?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 12:42:29.0320
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98151308-19fd-470d-b729-08dd19e1461c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8057

Enable QSPIs with default MTD layout used for testing.
Zybos, Microzed and Zturn are only enabling controller without specifying
MTD map.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/boot/dts/xilinx/zynq-cc108.dts       | 39 ++++++++++++++++++
 arch/arm/boot/dts/xilinx/zynq-microzed.dts    |  6 +++
 arch/arm/boot/dts/xilinx/zynq-zc702.dts       | 39 ++++++++++++++++++
 arch/arm/boot/dts/xilinx/zynq-zc706.dts       | 40 +++++++++++++++++++
 arch/arm/boot/dts/xilinx/zynq-zc770-xm010.dts | 37 +++++++++++++++++
 arch/arm/boot/dts/xilinx/zynq-zc770-xm013.dts | 39 ++++++++++++++++++
 arch/arm/boot/dts/xilinx/zynq-zed.dts         | 40 +++++++++++++++++++
 .../boot/dts/xilinx/zynq-zturn-common.dtsi    |  5 +++
 arch/arm/boot/dts/xilinx/zynq-zybo-z7.dts     |  6 +++
 arch/arm/boot/dts/xilinx/zynq-zybo.dts        |  6 +++
 10 files changed, 257 insertions(+)

diff --git a/arch/arm/boot/dts/xilinx/zynq-cc108.dts b/arch/arm/boot/dts/xilinx/zynq-cc108.dts
index 5e542ded3d0c..f5525c048426 100644
--- a/arch/arm/boot/dts/xilinx/zynq-cc108.dts
+++ b/arch/arm/boot/dts/xilinx/zynq-cc108.dts
@@ -18,6 +18,7 @@ / {
 	aliases {
 		ethernet0 = &gem0;
 		serial0 = &uart0;
+		spi0 = &qspi;
 	};
 
 	chosen {
@@ -51,6 +52,44 @@ ethernet_phy: ethernet-phy@1 {
 	};
 };
 
+&qspi {
+	status = "okay";
+	num-cs = <1>;
+	flash@0 { /* 16 MB */
+		compatible = "jedec,spi-nor";
+		reg = <0x0>;
+		spi-max-frequency = <50000000>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <4>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		partition@0 {
+			label = "qspi-fsbl-uboot-bs";
+			reg = <0x0 0x400000>; /* 4MB */
+		};
+		partition@400000 {
+			label = "qspi-linux";
+			reg = <0x400000 0x400000>; /* 4MB */
+		};
+		partition@800000 {
+			label = "qspi-rootfs";
+			reg = <0x800000 0x400000>; /* 4MB */
+		};
+		partition@c00000 {
+			label = "qspi-devicetree";
+			reg = <0xc00000 0x100000>; /* 1MB */
+		};
+		partition@d00000 {
+			label = "qspi-scratch";
+			reg = <0xd00000 0x200000>; /* 2MB */
+		};
+		partition@f00000 {
+			label = "qspi-uboot-env";
+			reg = <0xf00000 0x100000>; /* 1MB */
+		};
+	};
+};
+
 &sdhci1 {
 	status = "okay";
 	broken-cd ;
diff --git a/arch/arm/boot/dts/xilinx/zynq-microzed.dts b/arch/arm/boot/dts/xilinx/zynq-microzed.dts
index f2f560cc0c0d..4c3e56980c98 100644
--- a/arch/arm/boot/dts/xilinx/zynq-microzed.dts
+++ b/arch/arm/boot/dts/xilinx/zynq-microzed.dts
@@ -13,6 +13,7 @@ / {
 	aliases {
 		ethernet0 = &gem0;
 		serial0 = &uart1;
+		spi0 = &qspi;
 	};
 
 	memory@0 {
@@ -35,6 +36,11 @@ &clkc {
 	ps-clk-frequency = <33333333>;
 };
 
+&qspi {
+	bootph-all;
+	status = "okay";
+};
+
 &gem0 {
 	status = "okay";
 	phy-mode = "rgmii-id";
diff --git a/arch/arm/boot/dts/xilinx/zynq-zc702.dts b/arch/arm/boot/dts/xilinx/zynq-zc702.dts
index e4c9491081f8..a88fc38882aa 100644
--- a/arch/arm/boot/dts/xilinx/zynq-zc702.dts
+++ b/arch/arm/boot/dts/xilinx/zynq-zc702.dts
@@ -15,6 +15,7 @@ aliases {
 		ethernet0 = &gem0;
 		i2c0 = &i2c0;
 		serial0 = &uart1;
+		spi0 = &qspi;
 		mmc0 = &sdhci0;
 		nvmem0 = &eeprom;
 		rtc0 = &rtc;
@@ -393,6 +394,44 @@ conf-tx {
 	};
 };
 
+&qspi {
+	bootph-all;
+	status = "okay";
+	num-cs = <1>;
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0x0>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <4>;
+		spi-max-frequency = <50000000>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition@0 {
+				label = "qspi-fsbl-uboot";
+				reg = <0x0 0x100000>;
+			};
+			partition@100000 {
+				label = "qspi-linux";
+				reg = <0x100000 0x500000>;
+			};
+			partition@600000 {
+				label = "qspi-device-tree";
+				reg = <0x600000 0x20000>;
+			};
+			partition@620000 {
+				label = "qspi-rootfs";
+				reg = <0x620000 0x5e0000>;
+			};
+			partition@c00000 {
+				label = "qspi-bitstream";
+				reg = <0xc00000 0x400000>;
+			};
+		};
+	};
+};
+
 &sdhci0 {
 	bootph-all;
 	status = "okay";
diff --git a/arch/arm/boot/dts/xilinx/zynq-zc706.dts b/arch/arm/boot/dts/xilinx/zynq-zc706.dts
index 1e38c5caec22..3b803c698473 100644
--- a/arch/arm/boot/dts/xilinx/zynq-zc706.dts
+++ b/arch/arm/boot/dts/xilinx/zynq-zc706.dts
@@ -14,6 +14,7 @@ aliases {
 		ethernet0 = &gem0;
 		i2c0 = &i2c0;
 		serial0 = &uart1;
+		spi0 = &qspi;
 		mmc0 = &sdhci0;
 		nvmem0 = &eeprom;
 		rtc0 = &rtc;
@@ -304,6 +305,45 @@ conf-tx {
 	};
 };
 
+&qspi {
+	bootph-all;
+	status = "okay";
+	num-cs = <2>;
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>, <1>;
+		parallel-memories = /bits/ 64 <0x1000000 0x1000000>; /* 16MB */
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <4>;
+		spi-max-frequency = <50000000>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition@0 {
+				label = "qspi-fsbl-uboot";
+				reg = <0x0 0x100000>;
+			};
+			partition@100000 {
+				label = "qspi-linux";
+				reg = <0x100000 0x500000>;
+			};
+			partition@600000 {
+				label = "qspi-device-tree";
+				reg = <0x600000 0x20000>;
+			};
+			partition@620000 {
+				label = "qspi-rootfs";
+				reg = <0x620000 0x5e0000>;
+			};
+			partition@c00000 {
+				label = "qspi-bitstream";
+				reg = <0xc00000 0x400000>;
+			};
+		};
+	};
+};
+
 &sdhci0 {
 	bootph-all;
 	status = "okay";
diff --git a/arch/arm/boot/dts/xilinx/zynq-zc770-xm010.dts b/arch/arm/boot/dts/xilinx/zynq-zc770-xm010.dts
index 02876f6d23a5..5fe799c3c7cf 100644
--- a/arch/arm/boot/dts/xilinx/zynq-zc770-xm010.dts
+++ b/arch/arm/boot/dts/xilinx/zynq-zc770-xm010.dts
@@ -15,6 +15,7 @@ aliases {
 		ethernet0 = &gem0;
 		i2c0 = &i2c0;
 		serial0 = &uart1;
+		spi0 = &qspi;
 		spi1 = &spi1;
 	};
 
@@ -56,7 +57,43 @@ eeprom: eeprom@52 {
 		compatible = "atmel,24c02";
 		reg = <0x52>;
 	};
+};
 
+&qspi {
+	status = "okay";
+	num-cs = <1>;
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0x0>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <4>;
+		spi-max-frequency = <50000000>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition@0 {
+				label = "qspi-fsbl-uboot";
+				reg = <0x0 0x100000>;
+			};
+			partition@100000 {
+				label = "qspi-linux";
+				reg = <0x100000 0x500000>;
+			};
+			partition@600000 {
+				label = "qspi-device-tree";
+				reg = <0x600000 0x20000>;
+			};
+			partition@620000 {
+				label = "qspi-rootfs";
+				reg = <0x620000 0x5e0000>;
+			};
+			partition@c00000 {
+				label = "qspi-bitstream";
+				reg = <0xc00000 0x400000>;
+			};
+		};
+	};
 };
 
 &sdhci0 {
diff --git a/arch/arm/boot/dts/xilinx/zynq-zc770-xm013.dts b/arch/arm/boot/dts/xilinx/zynq-zc770-xm013.dts
index f07af61eaa29..103e87ea7253 100644
--- a/arch/arm/boot/dts/xilinx/zynq-zc770-xm013.dts
+++ b/arch/arm/boot/dts/xilinx/zynq-zc770-xm013.dts
@@ -15,6 +15,7 @@ aliases {
 		ethernet0 = &gem1;
 		i2c0 = &i2c1;
 		serial0 = &uart0;
+		spi0 = &qspi;
 		spi1 = &spi0;
 	};
 
@@ -57,6 +58,44 @@ si570: clock-generator@55 {
 	};
 };
 
+&qspi {
+	status = "okay";
+	num-cs = <2>;
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>, <1>;
+		parallel-memories = /bits/ 64 <0x1000000 0x1000000>; /* 16MB */
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <4>;
+		spi-max-frequency = <50000000>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition@0 {
+				label = "qspi-fsbl-uboot";
+				reg = <0x0 0x100000>;
+			};
+			partition@100000 {
+				label = "qspi-linux";
+				reg = <0x100000 0x500000>;
+			};
+			partition@600000 {
+				label = "qspi-device-tree";
+				reg = <0x600000 0x20000>;
+			};
+			partition@620000 {
+				label = "qspi-rootfs";
+				reg = <0x620000 0x5e0000>;
+			};
+			partition@c00000 {
+				label = "qspi-bitstream";
+				reg = <0xc00000 0x400000>;
+			};
+		};
+	};
+};
+
 &spi0 {
 	status = "okay";
 	num-cs = <4>;
diff --git a/arch/arm/boot/dts/xilinx/zynq-zed.dts b/arch/arm/boot/dts/xilinx/zynq-zed.dts
index ff2b4e06efbb..52ba569b2b9f 100644
--- a/arch/arm/boot/dts/xilinx/zynq-zed.dts
+++ b/arch/arm/boot/dts/xilinx/zynq-zed.dts
@@ -13,6 +13,7 @@ / {
 	aliases {
 		ethernet0 = &gem0;
 		serial0 = &uart1;
+		spi0 = &qspi;
 		mmc0 = &sdhci0;
 	};
 
@@ -46,6 +47,45 @@ ethernet_phy: ethernet-phy@0 {
 	};
 };
 
+&qspi {
+	bootph-all;
+	status = "okay";
+	num-cs = <1>;
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <4>;
+		spi-max-frequency = <50000000>;
+		m25p,fast-read;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition@0 {
+				label = "qspi-fsbl-uboot";
+				reg = <0x0 0x100000>;
+			};
+			partition@100000 {
+				label = "qspi-linux";
+				reg = <0x100000 0x500000>;
+			};
+			partition@600000 {
+				label = "qspi-device-tree";
+				reg = <0x600000 0x20000>;
+			};
+			partition@620000 {
+				label = "qspi-rootfs";
+				reg = <0x620000 0x5e0000>;
+			};
+			partition@c00000 {
+				label = "qspi-bitstream";
+				reg = <0xc00000 0x400000>;
+			};
+		};
+	};
+};
+
 &sdhci0 {
 	bootph-all;
 	status = "okay";
diff --git a/arch/arm/boot/dts/xilinx/zynq-zturn-common.dtsi b/arch/arm/boot/dts/xilinx/zynq-zturn-common.dtsi
index 800e891495f5..defef9c8da13 100644
--- a/arch/arm/boot/dts/xilinx/zynq-zturn-common.dtsi
+++ b/arch/arm/boot/dts/xilinx/zynq-zturn-common.dtsi
@@ -63,6 +63,11 @@ &clkc {
 	ps-clk-frequency = <33333333>;
 };
 
+&qspi {
+	bootph-all;
+	status = "okay";
+};
+
 &gem0 {
 	status = "okay";
 	phy-mode = "rgmii-id";
diff --git a/arch/arm/boot/dts/xilinx/zynq-zybo-z7.dts b/arch/arm/boot/dts/xilinx/zynq-zybo-z7.dts
index 6983caa35b0d..5e4247da2285 100644
--- a/arch/arm/boot/dts/xilinx/zynq-zybo-z7.dts
+++ b/arch/arm/boot/dts/xilinx/zynq-zybo-z7.dts
@@ -10,6 +10,7 @@ / {
 	aliases {
 		ethernet0 = &gem0;
 		serial0 = &uart1;
+		spi0 = &qspi;
 	};
 
 	memory@0 {
@@ -52,6 +53,11 @@ ethernet_phy: ethernet-phy@0 {
 	};
 };
 
+&qspi {
+	bootph-all;
+	status = "okay";
+};
+
 &sdhci0 {
 	bootph-all;
 	status = "okay";
diff --git a/arch/arm/boot/dts/xilinx/zynq-zybo.dts b/arch/arm/boot/dts/xilinx/zynq-zybo.dts
index f365693fe2f7..fbc7d1b12e94 100644
--- a/arch/arm/boot/dts/xilinx/zynq-zybo.dts
+++ b/arch/arm/boot/dts/xilinx/zynq-zybo.dts
@@ -13,6 +13,7 @@ / {
 	aliases {
 		ethernet0 = &gem0;
 		serial0 = &uart1;
+		spi0 = &qspi;
 		mmc0 = &sdhci0;
 	};
 
@@ -47,6 +48,11 @@ ethernet_phy: ethernet-phy@0 {
 	};
 };
 
+&qspi {
+	bootph-all;
+	status = "okay";
+};
+
 &sdhci0 {
 	bootph-all;
 	status = "okay";
-- 
2.43.0


