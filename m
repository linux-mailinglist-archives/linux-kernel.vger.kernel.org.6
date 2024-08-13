Return-Path: <linux-kernel+bounces-284044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4DF94FC57
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 05:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C0851C20F23
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 03:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9B71B948;
	Tue, 13 Aug 2024 03:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hNt23rEd"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5DB2C9D
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 03:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723520391; cv=fail; b=ba5FPWLY45TZrF4KwPoRd49znNffn2Jvjdm2RkEp12w47/Nm004MJBIm3O1U3Ifo9vB71N355xTJR5LAfujq3vaTBNcRraWSLbn/nx9w8BnL7C8CW17WCUrV5kYfodZ1Vf+IgbCwUo9UVhj5PC+Mt/1weCXZtWWPH5/h9JTCYwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723520391; c=relaxed/simple;
	bh=AwQFMX/j9j0thCm40lh+gXW4nJn2IqU3K7GiVdHE/tI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OOSLY18BlTU2B459aQBxxz3qs96y/x2RRTUxgx1KYBYj3u/2XZaNNDMPELWhozvpXEcE9wyRxlCfT6/tzyU2RHYofUaHFcikly4TWg0npburCfPoC+Wtbgl/Iw9zx146Nn1cgKRBdlQt9Tv/2E8Bi43t0eg/wg88/H4+2i+JqB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hNt23rEd; arc=fail smtp.client-ip=40.107.236.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a6A3WUdBmQKbwZ4cPftxiyIqnKdbURmXb3kaIFQsPuVl2opJd7wdOVYg++DZSHbco8WaT6fHuDypxt+54CNpTHFzZyA0e0k1ALZxFZE20nZqoMU4tTZF0NPpfrk+AiRY4SWOAq8M5zYPzX6xd6xtIOwZ/z6ESP7SyIENxh85q30OcY6n06W5YOo6vRlOQFrbaMKZhGALl6dumw5tcloKOb+No2MNTjAjlv8NVYyw5a3UY6Lv4k1CrL/P0JmXo1J9kYr+wxfcC1yKKWndS3Yx3IdNPcQ/BxG37N7ihvcW7c0uBW6lrdHjf1M9JnF0SQtIgNxg+8GSrdim+DZ8PnKJpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZq2xL8EziZehBt4q69526X9FqfC2ZgWERmqpl0hRMk=;
 b=h4vVn7ftOlPuE4U/DhHAuvijvKX3SeybTVIfbDiNKg2LDZDKjpusNiLeqM5svOMzf80sYETLW9nwcN94RIU5KVYoUvt7H/0SMCYIACWbI5hsGjGKWXWPQzetQmRtA34UzAG8B1nEFWqu0vDSrX/dDDtxlSGPIBgxV/OUyGh0YxbF679BHJfY4bCBxim3BUU0L2NYEKPuDC05RM6JEkGl8KE+Zp4ZQlNz0kde73UMZxUaBL0Mxk17BnSaQDlXnQnsyaaUlAeBbvf9WSSVb9igMcugwvA6KYKIPL4VF+bKBjo5urfIiFj3fyeSc0Oy2nLZcFMKRh09dmtpV090Vm0O5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZq2xL8EziZehBt4q69526X9FqfC2ZgWERmqpl0hRMk=;
 b=hNt23rEdUVv2yAuxd/MV4AOtnk95UtIBG/pDdVmtNoWFAuCSQFGHdou5VcoM2hnQgvRKb5R6OFi8cRgGcYh6UwJM3hplnaagHdISB9DVtrbUmnwWEdYp5a3Ew0p/E/mU/wmkss8yUm8GfW5EWPsnkqDmS36YwEc/S/EF/KeDzLrbjJjQurpym8ibjAkuTQbdldpEZW+1SqF0uvfHQD1BogPrN6q7eEmjsGnidTEOSwi3HzhnVAlqnu/ehDlPgecI9b7L5yzw7+bSNBI9XfgbEJoJfeAZPV7kdi8pR9LUYtGimlRo9DkTIgj+B+SbMJt6oj7n38Rsiag2qCQtmQXMOg==
Received: from BN0PR10CA0006.namprd10.prod.outlook.com (2603:10b6:408:143::32)
 by SA1PR12MB7040.namprd12.prod.outlook.com (2603:10b6:806:24f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 03:39:46 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:408:143:cafe::12) by BN0PR10CA0006.outlook.office365.com
 (2603:10b6:408:143::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22 via Frontend
 Transport; Tue, 13 Aug 2024 03:39:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Tue, 13 Aug 2024 03:39:46 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 12 Aug
 2024 20:39:28 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 12 Aug 2024 20:39:27 -0700
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 12 Aug 2024 20:39:27 -0700
From: Shanker Donthineni <sdonthineni@nvidia.com>
To: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Sudeep Holla <sudeep.holla@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Shanker Donthineni <sdonthineni@nvidia.com>
Subject: [PATCH] irqchip/gic-v3: Allow unused SGIs for drivers/modules
Date: Mon, 12 Aug 2024 22:39:25 -0500
Message-ID: <20240813033925.925947-1-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|SA1PR12MB7040:EE_
X-MS-Office365-Filtering-Correlation-Id: 4353afde-62c5-4ee1-157c-08dcbb49938a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lVJzZ27Ou55rZ3d0eFzw1m8+x5czl5i/2rerNDD4whIcl3QmUqdUcK2p+osK?=
 =?us-ascii?Q?o9dYhQWrcpn5x1eEPkHFbkgeBvCEZebpcUTYypsxItDbYeXiRhCVqdQj4sKD?=
 =?us-ascii?Q?IqVDQpIsk1u71R3MILHyFf4QBNa5ysPG9SvBGL0j3lyYYRc2nhElkM2RXo23?=
 =?us-ascii?Q?aFAzrpShRT4loZdYqciUvJNAK6/KRDYybXeDzUSeHZN631ftJ8wF4IKATBTB?=
 =?us-ascii?Q?S1xISI8FBu0Wx0fXqFYYFV+LV5d3+IG8Ijw9dJoTYf7uqelWGoocDwaWWw2u?=
 =?us-ascii?Q?RxsyaW+XUt30/3kAjSyEb/6Ryh+6IxhjtnfgGP1pMacwkSKLsxCyWu6JNum9?=
 =?us-ascii?Q?DJJHRu3dw/cLrj3Xtf6m73C/IYzP6ocAMwf+1dH2kdS+WLNBnKzwLBlHkXgO?=
 =?us-ascii?Q?siErP2neMOCFCoidCxFUsCfUm06Qq6II1Q1EIZo1L7t4qfzLHTKG9svlh+7l?=
 =?us-ascii?Q?ONAz/inuthh2LbfDB5ibeGcfjwmnmxzIsm8w4G0TJwefbGRCJCiMCXv2X++a?=
 =?us-ascii?Q?YRO+hOAxZIkFlg7D+z1E52+4IYO/57DSGm3i3wVGTPMktgLHgMTNK2PrFKRA?=
 =?us-ascii?Q?weAOpCDMsjYpJZ4HVzg9v/1O0ShbHjPzB9dWQZ9pskN4/7PlfcfLn3LrF7eL?=
 =?us-ascii?Q?Bk8s/HRygyZV2Jc7RlAIEK2FGNOJ3SYyJLNHmdftrvESBDMldydbHRPwckoS?=
 =?us-ascii?Q?pDl/y4ZLio0icweL4QMUOy4O4wyOm6CyRh06TALJfm47kg24wVqYJgZ2fRx9?=
 =?us-ascii?Q?LdkXemMgJutERXXWEAf8ztmXfZUWkAbo4jHPbXIR9j8Yp/PCID2KSJmBDCaU?=
 =?us-ascii?Q?owJzCvxrdBtw7/cU2Se2DNpq6mJ7KS+ANLMG2jwCaXRJshjmPbIQQzFObqQB?=
 =?us-ascii?Q?Us1Y15M2T+keemksrapAjMux2GBox/EF2STm/s62Moh/AN53Nr0NQ/KfO4d8?=
 =?us-ascii?Q?cKKfhsn8NLaSoIuopOAT2tjTWUahGtNgrwxR4H0/xX4RNE1VdwQynUNrT9qs?=
 =?us-ascii?Q?rjQc1wt5b4k5qIw9XxGFW4YaZ6hYOYr/87/mocAJvjB0ktC/IOpcRhBAR2tB?=
 =?us-ascii?Q?mvN6Nm3g5G0z8PovjcFT7pzxN5+QyyB2qotvd/z0AfEv65l3H2S1MeI822j6?=
 =?us-ascii?Q?oqcxLTrhrqXbxUrJrJFPTbGjvYiudQC+V61N8Rj+MXKwF4BjuhIezlZLYHcy?=
 =?us-ascii?Q?nGKL8HYzHN1pfNBIwsXKNfDt1c9e023bfX4Xb+mNXTvWl+i4Jdnn8i7IVOPW?=
 =?us-ascii?Q?bWri4FgCwNombEJo3mD5caHWJuTj5T1pNgc4Cj/2jTxnnq6pDh0Gi5APwket?=
 =?us-ascii?Q?QDLf9cmy0bJzrRqlvJDqZkB4FgEKl2NHmrUBIxKS7AFuSv1ufJukpna13EsC?=
 =?us-ascii?Q?FqlSMphzHqnKJe2T9xrHTQ2PQa0VNYLb+IvtcWv2+nksSdAn7w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 03:39:46.0199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4353afde-62c5-4ee1-157c-08dcbb49938a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7040

The commit 897e9e60c016 ("firmware: arm_ffa: Initial support for scheduler
receiver interrupt") adds support for SGI interrupts in the FFA driver.
However, the validation for SGIs in the GICv3 is too strict, causing the
driver probe to fail.

This patch relaxes the SGI validation check, allowing callers to use SGIs
if the requested SGI number is greater than or equal to MAX_IPI, which
fixes the TFA driver probe failure.

This issue is observed on NVIDIA server platform with FFA-v1.1.
 [    7.918099] PTP clock support registered
 [    7.922110] EDAC MC: Ver: 3.0.0
 [    7.945063] ARM FF-A: Driver version 1.1
 [    7.949068] ARM FF-A: Firmware version 1.1 found
 [    7.977832] GICv3: [Firmware Bug]: Illegal GSI8 translation request
 [    7.984237] ARM FF-A: Failed to create IRQ mapping!
 [    7.989220] ARM FF-A: Notification setup failed -61, not enabled
 [    8.000198] ARM FF-A: Failed to register driver sched callback -95
 [    8.011322] scmi_core: SCMI protocol bus registered

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
---
 arch/arm64/include/asm/arch_gicv3.h | 17 +++++++++++++++++
 arch/arm64/kernel/smp.c             | 17 -----------------
 drivers/irqchip/irq-gic-v3.c        |  2 +-
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index 9e96f024b2f19..ecf81df2915c7 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -188,5 +188,22 @@ static inline bool gic_has_relaxed_pmr_sync(void)
 	return cpus_have_cap(ARM64_HAS_GIC_PRIO_RELAXED_SYNC);
 }
 
+enum ipi_msg_type {
+	IPI_RESCHEDULE,
+	IPI_CALL_FUNC,
+	IPI_CPU_STOP,
+	IPI_CPU_CRASH_STOP,
+	IPI_TIMER,
+	IPI_IRQ_WORK,
+	NR_IPI,
+	/*
+	 * Any enum >= NR_IPI and < MAX_IPI is special and not tracable
+	 * with trace_ipi_*
+	 */
+	IPI_CPU_BACKTRACE = NR_IPI,
+	IPI_KGDB_ROUNDUP,
+	MAX_IPI
+};
+
 #endif /* __ASSEMBLY__ */
 #endif /* __ASM_ARCH_GICV3_H */
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 5e18fbcee9a20..373cd815d9a43 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -64,23 +64,6 @@ struct secondary_data secondary_data;
 /* Number of CPUs which aren't online, but looping in kernel text. */
 static int cpus_stuck_in_kernel;
 
-enum ipi_msg_type {
-	IPI_RESCHEDULE,
-	IPI_CALL_FUNC,
-	IPI_CPU_STOP,
-	IPI_CPU_CRASH_STOP,
-	IPI_TIMER,
-	IPI_IRQ_WORK,
-	NR_IPI,
-	/*
-	 * Any enum >= NR_IPI and < MAX_IPI is special and not tracable
-	 * with trace_ipi_*
-	 */
-	IPI_CPU_BACKTRACE = NR_IPI,
-	IPI_KGDB_ROUNDUP,
-	MAX_IPI
-};
-
 static int ipi_irq_base __ro_after_init;
 static int nr_ipi __ro_after_init = NR_IPI;
 static struct irq_desc *ipi_desc[MAX_IPI] __ro_after_init;
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index c19083bfb9432..0d2038d8cd311 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1655,7 +1655,7 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 		if(fwspec->param_count != 2)
 			return -EINVAL;
 
-		if (fwspec->param[0] < 16) {
+		if (fwspec->param[0] < MAX_IPI) {
 			pr_err(FW_BUG "Illegal GSI%d translation request\n",
 			       fwspec->param[0]);
 			return -EINVAL;
-- 
2.25.1


