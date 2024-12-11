Return-Path: <linux-kernel+bounces-441283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0005D9ECC53
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AD3F28865B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C7C236914;
	Wed, 11 Dec 2024 12:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="exONFUOJ"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA1B22913C;
	Wed, 11 Dec 2024 12:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733920936; cv=fail; b=Z3fPWSH/gNb09qBWiEbs2v46HO+Ec9rG/IjXVIzovzFuHf9y/fuobxNgiRtsZVXJ2YmRHExcQ/28mZ1F/k9uOdSsOpVkDvlyRpyD5w8VwgThzIxOsija+UYBEuzrYsfdEKP0Hn6MbhBWK2nbfFEyNAvb3ByARUiy2HXC226KMcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733920936; c=relaxed/simple;
	bh=3qrUrBtuhBnnZSQTgmEtH25j94U9RyWbaX9FTwyGxm8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WPPGz13uqsOEscC5sqlXwZ0ZRVgTYOt0t5DrnjrfX3LiPzYpbl37Dv2b/pkel1HwyK4imGjkBEZ7rJeR70FqqWvmWZmmBojixXH1+htB12c/x3/yLGuXiwSyrdnFbrhkA1uLQ3dIyZkEalpHyr1QxM8JLoFKreezCXpLffSeYis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=exONFUOJ; arc=fail smtp.client-ip=40.107.93.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ribF24IU14857LBhDrGUkO80F/HMw2HUWmJERU74YZV9XRcYlhAfhr8LLUyfaUN7uKslZDKSxp/NNqFBOAEmPGaK4G033EscF8XkHih10Mlec/ca0So/Q4tPjH01wIjjuvUE5bJdM/XVJ8yTLYEYlbvu5mt3NfOJTYcyb/jpK5oGZmwE5wbOczsOvxiktvTWVjqCjYdH3q2Sdo+5Oqd78DjjWzyudI5oXgdhoX5GonU07AQew0geWC5oilf4n0W9kfHeuVCLlBDasTo+nzUP8BU3vgFzudO9RhTkXz3seiWORwrgL98uNug5UPJQEsUuBFgxA2RTSn0NdYZ944P3qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyWuSrwGh2uIN4uMcExQ+AtnkZvIoxxlQFK+PZ7us7k=;
 b=f12d0KPqynt8QiT/Z7ckaqTBObk5wEWSM+lJ30glRMYOh39RsHzw/8dgWxhcf1Xob1HfD/nVcWe7DqX6ARc89ESJcuvSHth2evKujh4Rjbt3nYjmgwEpVIhJIjTety7UTEb0A8R231AdTpwEFvWZyncKwH9uxvinoFeYuGqziTQfpOLcdBQiMngKKE4jkHH4VL4drEmd1XsSFl5aOHS1jiX/Vtlw28WKCWdtIwQbjFzzrmxa5SFh0tyHE5Q09DOm57yXHwKVLvQjAz36rFKzCtJqy0ua5Mrku6vT5qNkM+TM7HGL102XVcPu5Vt7LdmR9Ra8lBKyL/hOJWdbvaIejg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyWuSrwGh2uIN4uMcExQ+AtnkZvIoxxlQFK+PZ7us7k=;
 b=exONFUOJo1Q6vT6OaHEDM/yDA1ClEuKqrnfa1+07Z6tTbTu6CKq6A29OLFKCmWUipP80kyIwiJa9sDxYYVQy5tghtZtW9aVqiCGJuMVNz1aR1U5mX7V+fO38RT2h9zglCMO5MUhnCL42p3ytBzJzJeutX19D/n04zUU36yZI6Yo=
Received: from BN0PR03CA0011.namprd03.prod.outlook.com (2603:10b6:408:e6::16)
 by MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Wed, 11 Dec
 2024 12:42:11 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:408:e6:cafe::1e) by BN0PR03CA0011.outlook.office365.com
 (2603:10b6:408:e6::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Wed,
 11 Dec 2024 12:42:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 12:42:11 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 06:42:00 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, "open list:OPEN FIRMWARE
 AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated
 list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 06/15] ARM: zynq: Wire smcc with nand/nor memories on zc770 platform
Date: Wed, 11 Dec 2024 13:41:25 +0100
Message-ID: <12e697975a1d026e811c2f63aa8bbbd0b9ff4f70.1733920873.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733920873.git.michal.simek@amd.com>
References: <cover.1733920873.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3125; i=michal.simek@amd.com; h=from:subject:message-id; bh=3qrUrBtuhBnnZSQTgmEtH25j94U9RyWbaX9FTwyGxm8=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvTIjmoNqbbkF2ueXFLuf7x79WfWOydNLsub1N03l58lN P2K/fLHHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAipmsZFvQx/JjeP8v+dmRF 88ROr1kvUmcyzWSYZ3S5N3dmgeT/sx0h3l47NTcVH9kaDgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|MN0PR12MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a501a8a-ca19-4bc1-8aed-08dd19e13b74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0pANIQ5uYAXVGVGyBn5QtZnNXuRNsp16vbIUdVCO73QrN7pLZa4jMGthN8Te?=
 =?us-ascii?Q?topfKDteN1+lzX979RJQxUppzAPNEjT+z8ETc+VvSnhSMzF5BwvvnHWEMXZD?=
 =?us-ascii?Q?7qSRwnpCcAAeyBIGU1IFmODPuPmGXpCSBWs9aC1223KzUMLCgOZAJSkD9lT/?=
 =?us-ascii?Q?nIZHa7IL+E88IzKKyKL0GoDf1PX15WhrwRBKer2eHpymIcksFoEbao5eUrXe?=
 =?us-ascii?Q?Bf3RynjMSA5J3DQvVBO15aEzWk1dSwZ0v3uOYOoPsdsSASP7tAZYvfiorXA2?=
 =?us-ascii?Q?A8meSHh8Z9dfK/fhqlno2C/EPA5p+apUrOP4VTax4vFWbB9kHpTOJ7HE6X9A?=
 =?us-ascii?Q?3msYiXD1nuAAYVQuyRp4QcbqwVE+Dkr/R0ilaANM0CgITK/Z0lGTwsAuOaZ/?=
 =?us-ascii?Q?m3ISFOxovLz6DoSyc9GeL72Wx5zRuxtgTZcfUhmSSn7O/Bk2KNy124BWBPrj?=
 =?us-ascii?Q?hZSY0P5lfy4APmWQ0Rb5oXZFV5o4bViH781qHZvAuosPou6l0sjt8etAQtXK?=
 =?us-ascii?Q?shdH8akMOSkPz29p6ic5pue9EYRS7FD78/ukD+a0w/AT+n84MIeEi5aQ5Hzm?=
 =?us-ascii?Q?3zui6+YvN7b3s8diaXBHq+M+F8E7cI2EGYGau6qurY8M0O6Lfhay8ONYvokW?=
 =?us-ascii?Q?iUR8CS0p8MrmvhQ7ypYArJHekIZUzbUlOTa/zgedMrPFce3+HWBJsWj0591L?=
 =?us-ascii?Q?PYYDVFPsia15/pYO97XZqWeU6oS1mBVafuumdURlyjLIOZukdvzzI84w4eb1?=
 =?us-ascii?Q?44gdDft7HFZBnFmHFbApL4pB0oHfReCRtiEO+ql+e2lmJWSz+CzTvazorH8x?=
 =?us-ascii?Q?idpNDVbJyFmnXbmWwLo0k0NLf/yYsry7SjAdLr2ioYAkQ//dQBTn6i+cnnTm?=
 =?us-ascii?Q?I4EaVw5YcfulgtuJANX8ozNyJ66VnOuEIRbzNV/vDIHb4Ym5BZYKkioJ/nST?=
 =?us-ascii?Q?XlLGVbMwPucdLd/CMxGotXjVLcDHylsYTAKF6U+okXmOGkKXzuG5+ryFdGyC?=
 =?us-ascii?Q?EXIu9LZCJI4G9wVHRF/j2/PrIINwaI/k+tg+mT8r/LgDrLC9XLd3n/mZ0ddT?=
 =?us-ascii?Q?h0tZXLYBCYhzkMwSIssFYnokANA5spaB73KVWTQZTmOIRcqa6WnOKuasAi7f?=
 =?us-ascii?Q?L1IPwI4Bw3puLW16tLLhqM+pR9rNTZ3p15q81YFRkDM5TZrF50XwFYnL5Ipj?=
 =?us-ascii?Q?NwUOMPQ/u5nIbTeqbAxC/4jhsiZciftSYwDiLnkdUUkrUI6NXitDcD/nNnwT?=
 =?us-ascii?Q?r5/MKHvR5Nz9itciGGP9q70zXf2Bs2aqkf3TZU6sD5rAB866GzdVnJ5jmDqB?=
 =?us-ascii?Q?2/07PzU4OqhtRzn46CYHF8GF8V6OrtI8gmU88LPhG6CqoUXP4BFeiu6K2U1K?=
 =?us-ascii?Q?6D/6QF+75l7TempGbu+znYd7nWRihMKYSlHH8eR7m5h32OhlVmE8Qn9axO0a?=
 =?us-ascii?Q?3dqLvCPdqKP8GaQOhsldbSFc3OWpeJhT?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 12:42:11.1682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a501a8a-ca19-4bc1-8aed-08dd19e13b74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5977

Describe nor child flash node under smcc and enable it for xm012 extension
card. And also describe nand flash memory for xm011 card.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/boot/dts/xilinx/zynq-7000.dtsi       |  7 ++++
 arch/arm/boot/dts/xilinx/zynq-zc770-xm011.dts | 30 ++++++++++++++++
 arch/arm/boot/dts/xilinx/zynq-zc770-xm012.dts | 34 +++++++++++++++++++
 3 files changed, 71 insertions(+)

diff --git a/arch/arm/boot/dts/xilinx/zynq-7000.dtsi b/arch/arm/boot/dts/xilinx/zynq-7000.dtsi
index d334b5f75c8e..268647668db2 100644
--- a/arch/arm/boot/dts/xilinx/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/xilinx/zynq-7000.dtsi
@@ -289,12 +289,19 @@ smcc: memory-controller@e000e000 {
 				  0x2 0x0 0xe4000000 0x2000000>; /* SRAM/NOR CS1 region */
 			#address-cells = <2>;
 			#size-cells = <1>;
+			interrupt-parent = <&intc>;
+			interrupts = <0 18 4>;
 
 			nfc0: nand-controller@0,0 {
 				compatible = "arm,pl353-nand-r2p1";
 				reg = <0 0 0x1000000>;
 				status = "disabled";
 			};
+			nor0: flash@1,0 {
+				status = "disabled";
+				compatible = "cfi-flash";
+				reg = <1 0 0x2000000>;
+			};
 		};
 
 		sdhci0: mmc@e0100000 {
diff --git a/arch/arm/boot/dts/xilinx/zynq-zc770-xm011.dts b/arch/arm/boot/dts/xilinx/zynq-zc770-xm011.dts
index ba040743e10d..f9a086fe66d3 100644
--- a/arch/arm/boot/dts/xilinx/zynq-zc770-xm011.dts
+++ b/arch/arm/boot/dts/xilinx/zynq-zc770-xm011.dts
@@ -47,6 +47,36 @@ eeprom: eeprom@52 {
 	};
 };
 
+&nfc0 {
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	nand@0 {
+		reg = <0>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition@0 {
+				label = "nand-fsbl-uboot";
+				reg = <0x0 0x1000000>;
+			};
+			partition@1000000 {
+				label = "nand-linux";
+				reg = <0x1000000 0x2000000>;
+			};
+			partition@3000000 {
+				label = "nand-rootfs";
+				reg = <0x3000000 0x200000>;
+			};
+		};
+	};
+};
+
+&smcc {
+	status = "okay";
+};
+
 &spi0 {
 	status = "okay";
 	num-cs = <4>;
diff --git a/arch/arm/boot/dts/xilinx/zynq-zc770-xm012.dts b/arch/arm/boot/dts/xilinx/zynq-zc770-xm012.dts
index d6392d4ece9c..24520e7d3965 100644
--- a/arch/arm/boot/dts/xilinx/zynq-zc770-xm012.dts
+++ b/arch/arm/boot/dts/xilinx/zynq-zc770-xm012.dts
@@ -53,6 +53,40 @@ eeprom1: eeprom@52 {
 	};
 };
 
+&nor0 {
+	status = "okay";
+	bank-width = <1>;
+	partitions {
+		compatible = "fixed-partitions";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		partition@0 {
+			label = "nor-fsbl-uboot";
+			reg = <0x0 0x100000>;
+		};
+		partition@100000 {
+			label = "nor-linux";
+			reg = <0x100000 0x500000>;
+		};
+		partition@600000 {
+			label = "nor-device-tree";
+			reg = <0x600000 0x20000>;
+		};
+		partition@620000 {
+			label = "nor-rootfs";
+			reg = <0x620000 0x5e0000>;
+		};
+		partition@c00000 {
+			label = "nor-bitstream";
+			reg = <0xc00000 0x400000>;
+		};
+	};
+};
+
+&smcc {
+	status = "okay";
+};
+
 &spi1 {
 	status = "okay";
 	num-cs = <4>;
-- 
2.43.0


