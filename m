Return-Path: <linux-kernel+bounces-441279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F00879ECC45
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA45C163DFD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D959D231CA4;
	Wed, 11 Dec 2024 12:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yZBROrdu"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D44C22914C;
	Wed, 11 Dec 2024 12:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733920918; cv=fail; b=In8VSDznmFTsKD1OLWTH8EuIXJ5bAhXa+WnMuzzzgK/ph2n1NRfgw535tvbBy1cGn/FTrlvnNtFXqwCoke8s6p7M0b5rm7kz1gD3LZ/w+ChRc4+khzYlxwdNsGpJ3xKAxOaunwxvY7Me59c4QWAtlIou2RxI2DA8QhJcwtbsmGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733920918; c=relaxed/simple;
	bh=vCX5c/u70Tf41pW6QQTnFGvQj+NMuh/HI/9/N/N3Fy0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AW55REdNR2nbLl3orkxljljTgYALE3KOV/QvAQluvbyig0W49zse/EUlXDphmzBH6GYmeslyVP1bQLSqBGU6Fk1bRLSvPH/51UWYKuCCxsDSFxduv5Ii2W0EOGNFq8x/K2kYLt8p9+6TQ08N89bXcXGhwgTm2sNdzkyET6K9PD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yZBROrdu; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hu4PY4juWP2H6S5+roRgZkqk7W4YmaeuQhzkFGZK1IrALgbTjTeOXrnxSQK3niThXgjq2IPrPT4JjnwDRKbkBszMGZRXcNEFFOqlbijR14GlDlwTl4BuEyzvjqLT/ODBEzIeEZXuK9lAAwyRCnsHJf8rnCFVv6QbYyv2JJr/oDh447NQvMlVrv4TwhYuVtFEIDPybeMMlXsyPRibTbJqYs6T9eGGrXTrGP5SyDYcQ5bh7mNxD8nJIYbYyYqj2cipHUUs+y9/PanNDhc1/lIX5aOjcFjH7J1Ks6z+FY9Gs035Lz9OEPPyOoeYYBFbLMJJfrbApIhtCwSo6qRYTS5+EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqdGVRUq/bgBvUb4/qasaH4Mb/mv9t6JEUqbuayqmWo=;
 b=iRRvvzbHWEVw/kDO33NvKLzq1c/MTrc0+wmBooeaBYHVGl9D/kd8Joubopo5GQhmatHveOLAikF265RtVQ3stUDhLJL3SmRDsGyh2KxIkPdpabKloVGQ4vyG7Hm2xanpe0Smbt4XKIw/UG6b47rBbWyx7qo2SmRxt/P64aL8R25ddpk+QzclpJgZv+3EHt9o5pMgdsx+ZCjG1qCc6UYSfl6z/R4stF3xthdNTV60Ws+CwilH+X8GmEsihPd7psUaGz1FWKGCVReCK+A1mDFY7XUrPGrSDMXV+aJrRdc0la+YKY4hzldR9tp6c2jJVCweuNBagoAXBXzqENOSc4ifjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqdGVRUq/bgBvUb4/qasaH4Mb/mv9t6JEUqbuayqmWo=;
 b=yZBROrdukV82K+WchvsvvB1zXqIX6ZBeojifCI+hlM5nNTuwlZddSLSuK5HIeKRkln3ZSLXBLvwDCOWLPE+8L1+cPBoFi3DXIfu/sLnXT4nGhbuq8+R/DmpzS6prAtu+pMXK52PQFf78SHb14J1D8cUB90XZz/0DprjZUThvAf4=
Received: from MN2PR11CA0005.namprd11.prod.outlook.com (2603:10b6:208:23b::10)
 by PH0PR12MB8798.namprd12.prod.outlook.com (2603:10b6:510:28d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 12:41:52 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:23b:cafe::2b) by MN2PR11CA0005.outlook.office365.com
 (2603:10b6:208:23b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.20 via Frontend Transport; Wed,
 11 Dec 2024 12:41:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 12:41:51 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 06:41:49 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, "open list:OPEN FIRMWARE
 AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated
 list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 03/15] ARM: zynq: DT: List OCM memory for all platforms
Date: Wed, 11 Dec 2024 13:41:22 +0100
Message-ID: <68da82d3d0733e33672562487a9df4a9374d8e1a.1733920873.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733920873.git.michal.simek@amd.com>
References: <cover.1733920873.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1566; i=michal.simek@amd.com; h=from:subject:message-id; bh=vCX5c/u70Tf41pW6QQTnFGvQj+NMuh/HI/9/N/N3Fy0=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvTIjqqbr58vUH3+KqT1weOZN+alrmQrXe0s5tFQN99bb tPb7YvEOmJZGASZGGTFFFmkba6c2Vs5Y4rwxcNyMHNYmUCGMHBxCsBE2mYzzOEz1ZvnOllbVmrl zyubTms8DJfkvcow32FlzEImzSW3fa76X9hZ42Dpl3PvCwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|PH0PR12MB8798:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d29e78c-daa4-4c2b-cce6-08dd19e12fb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HCApxj8VpUp8bObCtlpHT8gfQKsAK1zsAH0GlBQe6K6yPbw9LmYUrOIGbuRf?=
 =?us-ascii?Q?prO+sEWntykumbiipru5BVRV8VWMYH8j/6goigrIhiI0OJXG8cHsJ+JZjGgG?=
 =?us-ascii?Q?JuiaPnfJHhWne5I4ktMF1V21Y5hVSVM7wFPis908+0l3lxswTJlEVyFqMH8j?=
 =?us-ascii?Q?to2T5lHgJoZE2febvW4Y4+A/E61zCyeGNwN2hICAIBs06PYgzSFCjdeFQnXx?=
 =?us-ascii?Q?gqpBY3rsjKX8zWCjC0epxT4He/waHdw37wA0ozzM0fsMbsKp3EQL9DMA0+/s?=
 =?us-ascii?Q?qXyy2nBASU6t37s71rq1D67OmIQ6wWETd64SlkLu9YrTpVsaJmXDb6GJqOOA?=
 =?us-ascii?Q?pyz9XU9VWnyKL4FiXTm7yjuqHDLwAm8T25VNsqygX86OoGXbvDSteX1k2zJD?=
 =?us-ascii?Q?E67YDc4GO7Mp5FoK9W74nmv3ztPwq/Z5s0aoMqVyofRJecfk6YeHOHKJxLYy?=
 =?us-ascii?Q?0nQdnNBmb3n/J1xHgIeppL5P/9kcYEI6XUQX3zjcwK9rM1P//EkZ/eQr6Foi?=
 =?us-ascii?Q?rNSc7S0GB3J3HTXivnyYvtDYalYmveOEenkDlpfsuXxB5Dv+ecJ9eb/8v+MC?=
 =?us-ascii?Q?qKPP/P3vSXeSkb1+HeUB2+yzsTjKCc/7sx4Iwg/U63WWVJ1QeUkqJkRVXlRN?=
 =?us-ascii?Q?YzI3wM4wZ5ldVN0jtpai5mZ8zhCIwPTsmX/zKRUXATYVAHbEZq4Aq2kimu/K?=
 =?us-ascii?Q?OHKFMnMCpG3feH3DXL5VByXw7LdhD2pe/ztK6gN8wn8AkZ5SqYM3C33TXi9y?=
 =?us-ascii?Q?7kkhPMEhJB1ZXpZvot+Dh5JLNKnSuDu971yuCDLmi5o9deG8DCAAcnpwDIH7?=
 =?us-ascii?Q?riSLv+kJ9UAMyy8RU6n44MORy1a7t7NgBeZXyR9sjS3WvBnPRABwxktAp89c?=
 =?us-ascii?Q?yl1P0aMp21zUX1NzupfI3xUFozine2xRal47ZrOnOgYKuSRmGm5v2AiIf4L+?=
 =?us-ascii?Q?Z1npx25LhPnTsLwcdB+oKe75mFHiVXZg2R66d1BImW8oFuc4QqB2VqUFszT1?=
 =?us-ascii?Q?d0DGz7LUDwevq89EKqg+IIS2hNiCmSxCEUGwgW4imi5PW/5xE0v7Viv6/cAF?=
 =?us-ascii?Q?ovsm28jh9/LDtNLBmA4xvjdbUlJKs9qePSYlX+e8QiBPOho1+xqeYi0zgQ3h?=
 =?us-ascii?Q?lWCJRnrQ6ZTrjUFYTXG729zkLHQqiAubIyhPdFwgTxHs1fYbxaDQnDjG6ov4?=
 =?us-ascii?Q?NiIZdo97P4OQQ+iRmJaNsk/d7A+iGkZVJg6TIPTbu1NoMcj0+R2H1v43VL/f?=
 =?us-ascii?Q?SUF13ilI+vex2Sb141qgD1yi2FW53le46qO2kwttGSoPXbvxKQrlQ2Zx9gZz?=
 =?us-ascii?Q?6Y6REbMzg+AvUCr5Kt99NW0jA1cee5hWaVywe0eP8dXYkNt4k/q4Z5yndWfq?=
 =?us-ascii?Q?zTzFTzEKr+b2dewXtTMk7p6LXAVLGYlhHQMSXRHYA6CiR6sWMew8dLbtznOO?=
 =?us-ascii?Q?89CFpmSjAEHhuRrQKtz17KD2nXvQH1zk?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 12:41:51.4829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d29e78c-daa4-4c2b-cce6-08dd19e12fb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8798

Move OCM description from zc702 to all zynq boards.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/boot/dts/xilinx/zynq-7000.dtsi | 11 +++++++++++
 arch/arm/boot/dts/xilinx/zynq-zc702.dts | 13 -------------
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/xilinx/zynq-7000.dtsi b/arch/arm/boot/dts/xilinx/zynq-7000.dtsi
index a7db3f3009f2..fe224d41320c 100644
--- a/arch/arm/boot/dts/xilinx/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/xilinx/zynq-7000.dtsi
@@ -190,6 +190,17 @@ mc: memory-controller@f8006000 {
 			reg = <0xf8006000 0x1000>;
 		};
 
+		ocm: sram@fffc0000 {
+			compatible = "mmio-sram";
+			reg = <0xfffc0000 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0xfffc0000 0x10000>;
+			ocm-sram@0 {
+				reg = <0x0 0x10000>;
+			};
+		};
+
 		uart0: serial@e0000000 {
 			compatible = "xlnx,xuartps", "cdns,uart-r1p8";
 			status = "disabled";
diff --git a/arch/arm/boot/dts/xilinx/zynq-zc702.dts b/arch/arm/boot/dts/xilinx/zynq-zc702.dts
index b77d2ae82606..126c0b0ecdda 100644
--- a/arch/arm/boot/dts/xilinx/zynq-zc702.dts
+++ b/arch/arm/boot/dts/xilinx/zynq-zc702.dts
@@ -63,19 +63,6 @@ usb_phy0: phy0 {
 	};
 };
 
-&amba {
-	ocm: sram@fffc0000 {
-		compatible = "mmio-sram";
-		reg = <0xfffc0000 0x10000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0 0xfffc0000 0x10000>;
-		ocm-sram@0 {
-			reg = <0x0 0x10000>;
-		};
-	};
-};
-
 &can0 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.43.0


