Return-Path: <linux-kernel+bounces-190338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 343238CFD0B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B87D21F24770
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D4B13B78F;
	Mon, 27 May 2024 09:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G4cGvhCn"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576EE13AA47;
	Mon, 27 May 2024 09:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716802486; cv=fail; b=m/V5kOyeZqBz9Lw0QF5CF1JKm8fkeA6b2WFkNT8v7O1/mPj6dPtLAVt4tdOXac+cFrBnDDEymi1o4nS4Rapwt/+kq5eSaZd7DyytOXtTeir14RntXU8FpmXON1Nd0eMdrXDZXA94smUTqscXGiw+sFSpeih5zYHuHFuDVOxdKJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716802486; c=relaxed/simple;
	bh=3WFAAFf8axk2Ru1SaBDm/18b1HWFyaMSLeHra6irwqc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kruqjFa4TiKPYOhN/v26OPCzErhsrYSwzeyjWnyqLxsRVyk0Ew9gF6K3lfCRwtulyU8Yc23Em9JsKeVIdiVwZXtRCJzqgXNbolb3Kw6zWXfhjOU4mWZcn5TT6erQv1sXtKKppW3V0wV69/4aTaSKfHLZOiJXBVN3zzT8j0DyZRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G4cGvhCn; arc=fail smtp.client-ip=40.107.92.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPhvfta6+K50+VSceSqYWHmPyK5WrH1scLU0lKDRP9CcCatakv1/zlGyymRLHXJzW7p3F0CNTjNiGqkMzyqp+jD/8CycaoF6TgGpjpWOTT7KZ2ChIPnd7r6mtyklkxoUaR+oLyLxc7AQerwt8iHQahObgS88jPPkPM4b2zMb1zVvC9mxZarpDNRrrz3NYIUx09khjLmfKhxleSyFz6ztilXFoxEiMtlU5SxcCTfGlK2BrPfutZw/qMSKHUsuBonaYhaHzE2/Gpmif7/nJMFQylNclEDIXLvHPxXsOtDnNM8Urica6MbVhXbyZA3GNhLi0aSJtFBl8DoajRU60ArJnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DD/tV0KOBlxGb+I6SYCtCa7V4eEalTHynhatTatgvPg=;
 b=C0CygQgrr9XWN3KStwknKlEH8+XHHbXC1lJh7fkyseSzSAVvpn2+QTektt5uCRNb/kPl0ZGPlFI1BUjwssqYxR5THU6TbJmbUFQzTMuK/ECp1zlvbbT4VuoL/IWaKInClhnxmK3OjK4cbGDTQEwBlL/cUL41hl59l571nbc9ngDgNpOXpEDzj/m+6wMs79F8EeZuZiNvfLpD9Yxk96R/X+ew6NS5SNGr1uCPFKmgyjKg134cj4roz/OrdJpWNl9XmZtHwbqLP5GPvvGHKFTfUYOoNRdlsgiFfRLgSFScW24k/2yXjUUk0I6qsLsgrmz0Y5eP5Y18llTAJJ++RPLttA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DD/tV0KOBlxGb+I6SYCtCa7V4eEalTHynhatTatgvPg=;
 b=G4cGvhCnMEPOFR6+JgsyGQmv1Pk84dINyN1uLHqz2YEW395cUY6fbGigGHiOxLrnCAB9IUm+dLSS/PVwBFRzHh+g4QONrITkDOjDSw7zd6vht6Gn/4anou9+Vu7Tc1TDtZNnfrhZdYSoLorkrM0DXqnjNqiQ9e8LWehXzDWBXLs=
Received: from SN6PR01CA0026.prod.exchangelabs.com (2603:10b6:805:b6::39) by
 BY5PR12MB4161.namprd12.prod.outlook.com (2603:10b6:a03:209::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 09:34:41 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:805:b6:cafe::7b) by SN6PR01CA0026.outlook.office365.com
 (2603:10b6:805:b6::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Mon, 27 May 2024 09:34:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 27 May 2024 09:34:41 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 27 May
 2024 04:34:39 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh@kernel.org>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "moderated list:ARM/ZYNQ ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 04/12] arm64: zynqmp: Describe USB wakeup interrupt
Date: Mon, 27 May 2024 11:34:10 +0200
Message-ID: <8c11ac7d73c822ee207cecd1445205f19fcaf004.1716802450.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1716802450.git.michal.simek@amd.com>
References: <cover.1716802450.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1676; i=michal.simek@amd.com; h=from:subject:message-id; bh=3WFAAFf8axk2Ru1SaBDm/18b1HWFyaMSLeHra6irwqc=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrSQ4KkLNsdYLBJNevP+XOO12XxV4a9uCjS//TiLVZF9+ qev+dX9HbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAi3/4xzNOZeP3MSnnhvNIe tdupwhl3L+unejHML8iWkZyauCxk8c+54rqrDwrX3UzwBgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|BY5PR12MB4161:EE_
X-MS-Office365-Filtering-Correlation-Id: a75a583b-0e50-4f95-c8cc-08dc7e303c2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xyWZI43cmiFbR8ncNrZJh611y+wrCYpzZUnwtGDsNHYyCvJvQ+aiVcVUtPtZ?=
 =?us-ascii?Q?CQ6vkxu4h0RRyjgANQfV/kJSeRzU6WcSU2xhgfFRe7Hctz8rJ8JM/gDcecEb?=
 =?us-ascii?Q?h9gc3yFxI0akJx5rNR9tMu1y0jMmxKWKOsPibzoyKeOquHmB0/fsYzZVKynu?=
 =?us-ascii?Q?oprU25g+dLKHzbVaVrYEtwm92BGcSKDntgPR1f/OkoLG6xxOBiBsE1UhWy3u?=
 =?us-ascii?Q?zrdaCYTXIBnuuMFILbJ4ILnYT3BS6VNBdUPSp5+2cNgdR9k3qcYEwKX45Hdf?=
 =?us-ascii?Q?xg3ElxcKM5t/587zULE3aC0L7brW4niocze2oEsW6ZVnTIavsPRAEF7aPSmx?=
 =?us-ascii?Q?KQJMVpS7r+eAHaBefJZJWnwRXptmYE/A1aRRvZ3dik9dLO/Coqx7wQTyvRUI?=
 =?us-ascii?Q?lwB153mw6yBxrcd4u1Y4VJ262ROuolPdleI6UhvZ7pYiZbOgrPadJ31Q6knV?=
 =?us-ascii?Q?iJvsyML3p8NmYwpuhhqcBpR0J9H3NKIvlGSTGp85D1WsvhduAfspuWwzRMh0?=
 =?us-ascii?Q?ltpoS32I9BK4ozYmpYNbN+p6JPLyrr3/DVtyGSAzS3R5LfrmSpOevmo92A6e?=
 =?us-ascii?Q?zemZWGM6kUZVzZiM+WWFd2ambz6lij9QXYHZgVMC48B8EsdoCrPnmlEw4y2c?=
 =?us-ascii?Q?k47djaitgVteDpnjZ67o8uwB1RxwUclPa8RkWOW36WehzYD24631XTi9/vOh?=
 =?us-ascii?Q?SgP6MD2D5fKSuWPNcwMCi6PECAfxTnCshWp6ogB6NPMI+bz87WSYdOQFLrfG?=
 =?us-ascii?Q?lnJShkiu/1oMFFFtnYO+F7KBbhSNUa2+D8xrTTG/tWHdmvE3LqoCyQapzw35?=
 =?us-ascii?Q?ZOkxe2v7qyhRHiekcC5bAXwvLnT2MfTqn6eu6Rj7/nJMXskZSelhOL5V5XF9?=
 =?us-ascii?Q?gv1DM8bcQzHz5FxJpMXnkFaWs69I7ps5/WqSbnuIEo6hBmzxMUyGfytsR8m9?=
 =?us-ascii?Q?bkOUHmSvqmRUNdkfuo8k+VAcMDAFNMq8cl4AlwoHEoq+FhtTMZEGPSW2jNqs?=
 =?us-ascii?Q?3lRdhpS1vS7Qj/GL3DpzyK9Z6RZRQ9vNN0zDo7B+UGVsLjZusHL8zjG/GDNy?=
 =?us-ascii?Q?7NrMzfEnOEnai7S5rrk5zaQbuPgK5kOvo+jYIuH9FWzgexfoYvLXFAGNyKaT?=
 =?us-ascii?Q?j684xdWkERrrl91MpfO6nQPQbvVQMcENKM9u78ftS4Q6sOJeUaHKvadYfy0s?=
 =?us-ascii?Q?lYnK9+P1ys7vx7hijTnYTEMxIVZSEMa5wT77n1SH8JfXxi3fSvfOTYjlSJM7?=
 =?us-ascii?Q?xPAK8lQxbX1HukEkCZjRBiRYnudVy4pACyimgA25ZJZzsNNjf+XBqeTlLGeo?=
 =?us-ascii?Q?R8oJp9Nbu5ONtIUGEHP+cVqcNNUqURnC47PZ1j5ZFZI8aKGhlXxEn5mXtJqv?=
 =?us-ascii?Q?qRNopiI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 09:34:41.2265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a75a583b-0e50-4f95-c8cc-08dc7e303c2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4161

Describe usb wakeup interrupt.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index c82275f1e79c..90fccae7ff5f 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -1054,10 +1054,11 @@ dwc3_0: usb@fe200000 {
 				status = "disabled";
 				reg = <0x0 0xfe200000 0x0 0x40000>;
 				interrupt-parent = <&gic>;
-				interrupt-names = "host", "peripheral", "otg";
+				interrupt-names = "host", "peripheral", "otg", "wakeup";
 				interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+					     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
 				clock-names = "ref";
 				/* iommus = <&smmu 0x860>; */
 				snps,quirk-frame-length-adjustment = <0x20>;
@@ -1085,10 +1086,11 @@ dwc3_1: usb@fe300000 {
 				status = "disabled";
 				reg = <0x0 0xfe300000 0x0 0x40000>;
 				interrupt-parent = <&gic>;
-				interrupt-names = "host", "peripheral", "otg";
+				interrupt-names = "host", "peripheral", "otg", "wakeup";
 				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+					     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
 				clock-names = "ref";
 				/* iommus = <&smmu 0x861>; */
 				snps,quirk-frame-length-adjustment = <0x20>;
-- 
2.40.1


