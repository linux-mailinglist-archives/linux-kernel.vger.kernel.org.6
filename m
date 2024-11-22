Return-Path: <linux-kernel+bounces-418066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F739D5C97
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 472CAB259F7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729701DC1B7;
	Fri, 22 Nov 2024 09:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GKqnaG9p"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAB91D63FC;
	Fri, 22 Nov 2024 09:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732269445; cv=fail; b=fhGAmuuAPBr/eUa3VxnlyFtX6CTWohocm5mckuVYs3qw4X0b9g0tOQPdjTS1Xj6hYQC37ReTW0CAgiczAyi2BV7ItxHJv6xzYCZ/FOsFYC7UF7yo212uHvy2XMyyuNm1g9pDNTFRgZoId2oj/47lTKnpdnY+fNN3zWzBfylSpb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732269445; c=relaxed/simple;
	bh=3CZ+mHqjNZuKuoFt5h/Dzy+0DvFsjt2wUunbGRE/Js8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GOsXT9XkQ+zhOZbVjijCYdBWVLzAnluycPzt4jY6Uy0aRn3QSKldo3OfWC0O9YUIl4Tn8L6iYFxna5VPP4TfCgMqxtU//Fa7OtuQ4JZG4TkOtdNWQ3ZpuLeVkoOcvKOtkNLpEZUnsho8g7206WIIYq2ijPZNRGnOvUh7/ZQv7Nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GKqnaG9p; arc=fail smtp.client-ip=40.107.92.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qzk54WaBoQIedqASaDVkDXo0htK1XfRUq8cEc3SASClcMw9meElj2NiCPVaMKin/VKLuvhPM3JJ6TB0E8Ht0bQY1LEWRHE04H6xA2nQaS7U6c1C+F1rXnsQTwtTYpE8E+B12Yxp1ClsrYhNkntuPQ5sTeK4VPdbPFDOh/c9Qd4oD8dPccGX+kzw09xNTO603bEEAfEpAA1iq9fDJIwzY/gy9KWiuHuVlmcuusaVkW4Y1RG71T76OdISqyct+GzVrXJEFdDk7+zgpIiXatFfivX4MIvXbeS/AIPZtD8J59nS5B6/EeNGS9kqIPuX3KHbDKuWgh2pvvdTgj1O64oKQHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rdeCnBSJluG5jTTgeN6PQcOlpDr2fg/d8wdCEXhE6s=;
 b=NPX1ZchGw/ZW5WAyt3fN+okgumR5Wcl0hpC03QuFfhEv4rIe9EbVCaLWV/IXwGMCSayCruTGXj/xD3b5KKAWwmMrlXPJEmnqGEa1QA6yo9DcyQ+H5TWhHUna4vuFNPe7Cbh3fZqPfNkM3Rwkp32rDmse8YjF6r/H2npIoJbcKSP4rOhaP7LDzGBNce8C3tZrpOL67r+EVl1FTmsqAU7E/CaE2iHC2rPUduWi8rltmwXbEfiBDJxYx/mOLcNpr0gm84gaWYIHamiUT7VRaBUuOXenPodHWQIypYss7/cnERnknHSCkS4woJPeYyMutwRwtCNRmXws8nR95i6VLhKDAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rdeCnBSJluG5jTTgeN6PQcOlpDr2fg/d8wdCEXhE6s=;
 b=GKqnaG9pTWvFqFYXFsGiv+hHUctZ9RXgYTygHxgW633msBXnXK/CYI/rNcSuyRSEcGDRuesy/MOeZyR4m1bQsozk1CIt+IrxFqnOhTkFjffnwg//FbODgkOF3xwGoy1Zqa8UthGbQJMNvkFx1PbrzHhH3x6LjxQqH6qUXN0tXwI=
Received: from BN7PR06CA0046.namprd06.prod.outlook.com (2603:10b6:408:34::23)
 by PH8PR12MB7327.namprd12.prod.outlook.com (2603:10b6:510:215::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Fri, 22 Nov
 2024 09:57:15 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:408:34:cafe::20) by BN7PR06CA0046.outlook.office365.com
 (2603:10b6:408:34::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Fri, 22 Nov 2024 09:57:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.12) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Fri, 22 Nov 2024 09:57:14 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 03:57:13 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 03:57:13 -0600
Received: from xsjwillw50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 22 Nov 2024 03:57:13 -0600
From: Naman Trivedi <naman.trivedimanojbhai@amd.com>
To: <robh@kernel.org>, <michal.simek@amd.com>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <senthilnathan.thangaraj@amd.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] arm64: zynqmp: add clock-output-names property in clock nodes
Date: Fri, 22 Nov 2024 01:57:12 -0800
Message-ID: <20241122095712.1166883-1-naman.trivedimanojbhai@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|PH8PR12MB7327:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b243870-f736-4402-9d5e-08dd0adc0a98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QvhdRRlLviOOleRwtcKWYnCvUpR5XUG+CFAfZURlXS78CeqxT1/FHqYtHBh9?=
 =?us-ascii?Q?xpPL80qEcGgWA5sDOhHJz+4EC0eQ8hWzew+25YGrfZFJ3qmaYKWaVr25Ex8U?=
 =?us-ascii?Q?ZLGTv2cQj7XeZBeWvsnB32sxYDlPEhNaE6iucJUwmDQcxD4TdQcojuZYr3Tu?=
 =?us-ascii?Q?AfO+4wsAtAS3nfmarYEjyG8E6SzW/eg4kDiUT/YM9Qc4+h0PwiWpfl8u1x+V?=
 =?us-ascii?Q?4LIZNj0nBjm/VASlAHyELziuiXPmbExPY+upq2XIdCwT63gwwt5XEMafKQG2?=
 =?us-ascii?Q?jvPDqG9guxZ1eM/HBfbVFPd58fvKCXeBUOIe8BRbVrqNcPtp1Bcvj+SfCWRN?=
 =?us-ascii?Q?67peBesXQDg03jsKz2zzQCevovbPJMav7g3VNL8zaZua9g9EYWzVrridxF8b?=
 =?us-ascii?Q?oRmdTqsDD/4wCSDzcBGYUQ5dNhFK9fS2xKG7QqH5psKyEMQiDrvTO0TpA3j+?=
 =?us-ascii?Q?TvlWUlhzXr+7hRhRXTc4IKucPDUZkzR48/XyvDE1xMKGTTZTkTstnfjAgVao?=
 =?us-ascii?Q?3ZhNM2CNxbgWhLMNF3KndX/qA1uu8UbOo1Rs4VcChF6iWWhhI1A4jD7j6NbM?=
 =?us-ascii?Q?2vAGGxYyHoWDCAukm1A+Hvhx6huaLmrQTdkBbkMJbG9ui22MuJNqfAFai6xv?=
 =?us-ascii?Q?lg5tHuULPbvFLCLntj+s9rRkU5R5dRE4hAQ/Sa7MWPqzJuFBujXMiE/LgRUV?=
 =?us-ascii?Q?pZnKzzGxxbDRYo05I6kqplemtaM7iyEpFmom6Ec+qg+rcxaBVoXi3LYjKtct?=
 =?us-ascii?Q?5SLlwgMbOcnCmTz1uJcpu1/UuRVE0aBoWZb/CJAHNBKRgSE+ycq9NdwTxc/h?=
 =?us-ascii?Q?J9NdHrCh38yxfA3/YeMAOFNwYLk2sGxBvQbpzbnYzP4EgpOg3s15AilrcdGz?=
 =?us-ascii?Q?EtCkbnlX0iUOs+ZoCDtryBQbsyMn7cTplvX+w2LUdRMkh7Aa5evAgwlrnAr4?=
 =?us-ascii?Q?A7+A00VdrWCkCmVgXlUEoPgTM1ZyBGn2kqxiEwB41RlT8TrZBDGxpXDuoXqq?=
 =?us-ascii?Q?hJQbo2I3VmTBxvJxmDUEKATfNIsE6yvYcsYVi9jYK383BfUTr9ekaDHmVn6Y?=
 =?us-ascii?Q?gihaZE3GMe41vIkn2VcVEqzl3szwKm7bmUde00tfdVHzzI8s4MKEgO9wbzMm?=
 =?us-ascii?Q?Dg5QzB1lZurnsozKjBEHTGp4TTkUeMxMqGI9ZaJ0bIe8iPSsmlMDgRcSrQ3w?=
 =?us-ascii?Q?sVeRe2+YauNXdZW4q2SuiVRWFtGFhHpyivJJRqvJHYikUGmWmMrBq5RWUdYI?=
 =?us-ascii?Q?4tcCOXgX2kWrkF+/OHurX/bumMY735dLV5WMb+n6xsxRjnGjhmcw46sGsfNc?=
 =?us-ascii?Q?ND0czxN+wXWtD8kecWNdU9GmNRA0hdO2gHmG3f148ySzQ5h32cXj4+AV/PEV?=
 =?us-ascii?Q?cdiqS14=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 09:57:14.2085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b243870-f736-4402-9d5e-08dd0adc0a98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7327

Add clock-output-names property to clock nodes, so that the resulting
clock name do not change when clock node name is changed.
Also, replace underscores with hyphens in the clock node names as per
dt-schema rule.

Signed-off-by: Naman Trivedi <naman.trivedimanojbhai@amd.com>
---
v1: https://lore.kernel.org/all/c5d6effa-bdcf-49e3-a4bf-3713db889b70@kernel.org
Changes v1 -> v2:
- Fix the clock node names by replacing underscore with hyphen.
---
 arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
index 60d1b1acf9a0..385fed8a852a 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
@@ -10,39 +10,44 @@
 
 #include <dt-bindings/clock/xlnx-zynqmp-clk.h>
 / {
-	pss_ref_clk: pss_ref_clk {
+	pss_ref_clk: pss-ref-clk {
 		bootph-all;
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <33333333>;
+		clock-output-names = "pss_ref_clk";
 	};
 
-	video_clk: video_clk {
+	video_clk: video-clk {
 		bootph-all;
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <27000000>;
+		clock-output-names = "video_clk";
 	};
 
-	pss_alt_ref_clk: pss_alt_ref_clk {
+	pss_alt_ref_clk: pss-alt-ref-clk {
 		bootph-all;
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <0>;
+		clock-output-names = "pss_alt_ref_clk";
 	};
 
-	gt_crx_ref_clk: gt_crx_ref_clk {
+	gt_crx_ref_clk: gt-crx-ref-clk {
 		bootph-all;
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <108000000>;
+		clock-output-names = "gt_crx_ref_clk";
 	};
 
-	aux_ref_clk: aux_ref_clk {
+	aux_ref_clk: aux-ref-clk {
 		bootph-all;
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <27000000>;
+		clock-output-names = "aux_ref_clk";
 	};
 };
 
-- 
2.25.1


