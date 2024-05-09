Return-Path: <linux-kernel+bounces-174132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B258C0A8D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 06:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CD73B21FEF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 04:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3492810E5;
	Thu,  9 May 2024 04:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gjbG+/e+"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3705613BC3C
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 04:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715229867; cv=fail; b=LcmjOQuh43jFNk2koC+EAoxUiJ82B1tsCHUW2jjwzCEVsTosEjL7XW0lrj+eKf+vKn5zjsUxgEUAm9eqQjPknaf5FLdUPb3669yFkVnArov/54cpnAA73PUyp4m8sqcmsIfztnAVRZKkRY8CGDjF5lCBUziXc68sRbm22D0mEVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715229867; c=relaxed/simple;
	bh=4giIsb9r+dfxboJFitbfuWqZoE118UhGpBzfdy5dCOs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kxEkLjfSt9eFWgMvEhZYY0WH6jjC4CFmZR4bHHPn020EqKEr3dsqWGUzASUEn/iblo9BJroRpJ5/1Ev+CsSpHoPCpRYY6ISGhy5eYlIXRH4d1paNFsgcbZD1ATGjpt1V/zj7heLLLdJS2YN/KKSAwTz0eJpM0cVFmedl4Mdq838=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gjbG+/e+; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzjrnCtmWrzctjb8LHHDCxh4/4Uz+HdoOz6osnrGB5hjVrJMHknPnH/QezWy5IZig/9VTMqzFKokQRs5ux5gpBCKfgaLeF9PSyAohrHmTusGBIF6YVxITH8R+7fzRNMSsJOTxssBaX/7QSgDe2tXe8x41dRZBBalc5YKHEGYu6JA0FAu84vE4V6FqDddm1ws8Py1EQXmtPnHf6qYQcIhqLmJcuJcynXH7FchxKpWbkZGC5US3CivJ9Vc1PlUBKd/hOeOWIYSA7uxeep/5l0oBac/GX9iYOA7KLfsBj3KZbr5Jnynk9N8leSpcIz2v+L0AhomCKktXaafEWdzlzSk9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAj4Hl4Ej3ikJtQd+WA0hhpE8n5LNgIJcXfYekN7Jx8=;
 b=kXjEGGcOvEj/VE8mu+wnulAWJTgSwJwG2Y3UmL9Pw8lxGDN/dFwk8U7D0zpVwbtAJOqFcZBr9cuca+4gI29pR7PZB6vtgBUz0Oe8RtIqVmZzyg7OEHZNzlE7vcDKGEDUAy3BO+RM6hTQt6irQs0634G+GjO744h89hTBJFU6TU5f4uUqG8sUx+XaeGIXTTwB5Azx/f0h2ovWulv7PV3ZRiFIWZuyrU/kxPML4k98DAqcongkwURSYLrt/ikUYXYP2/1zr6nYAKPo06fn6fv8krardLV7aROO9bk6jaLAZSE7gdYdW1fQV05XlMc+Mj2YVQRoISzK3MjqIm0mZISqgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAj4Hl4Ej3ikJtQd+WA0hhpE8n5LNgIJcXfYekN7Jx8=;
 b=gjbG+/e+jAKuKxxrloLUAYUgxTQvuVDUNVW+FiE+UlfmQPoIOqcuYurnIjuB6RwjbDckgCXoVD86HKuH+Ny22hS/kNnyTe0QSzYRSiInBfy0zVAYdx6oMoYqBDLaHWe3CmlVnlWW9adU5i2X6zv5OK7sRtzeQrLH9VK8o6E7q48=
Received: from MW4PR03CA0078.namprd03.prod.outlook.com (2603:10b6:303:b6::23)
 by DS0PR12MB9446.namprd12.prod.outlook.com (2603:10b6:8:192::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Thu, 9 May
 2024 04:44:13 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:303:b6:cafe::fe) by MW4PR03CA0078.outlook.office365.com
 (2603:10b6:303:b6::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43 via Frontend
 Transport; Thu, 9 May 2024 04:44:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 04:44:12 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 8 May
 2024 23:44:11 -0500
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 8 May 2024 23:44:11 -0500
From: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To: <michal.simek@amd.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH RESEND] soc: xilinx: rename cpu_number1 to dummy_cpu_number
Date: Wed, 8 May 2024 21:44:04 -0700
Message-ID: <20240509044404.21673-1-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jay.buddhabhatti@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|DS0PR12MB9446:EE_
X-MS-Office365-Filtering-Correlation-Id: c8838529-34fe-4d3a-dc5e-08dc6fe2ac66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h+MEcJXhBT1Mbxgf6ndH4ISU1Ah8N8AfhhAZTS42wboFLDSY64NWZbCHbs31?=
 =?us-ascii?Q?f73sCLh0cfZb0+WJBRAobpnk9Py+tumtGJ8Wx9gRknm/A9FQ23GyPSgK+jZY?=
 =?us-ascii?Q?orePnsn/gyU1vnHzjhWSdHO3uHfpg/svq/U9GLjU19J11prDrZ9pq9IzTIHG?=
 =?us-ascii?Q?6pLuIfkyUrD4lH+WR2paPIC7but8Y/0aBzW+h6f1lhdofISKi56AiPUL2LEu?=
 =?us-ascii?Q?6CoDSfUYRmoCeLui6mvn61Rop2vaUAaFfan8hRTf1IGv2MhrwrWNf8eC2s2J?=
 =?us-ascii?Q?F48fxka/Gm4bFMcGl8TQt3TWdLwB/63SCUg4wtNwLazluQ45RD/S8eVAVUxB?=
 =?us-ascii?Q?LKjG7t6wdVqdDoSz7C0imAbfXFDpUwvCHDFvMg4RBytc3td5rauyA9uZ40gf?=
 =?us-ascii?Q?vUwUA+xMEKJUSmXsdTj2c8Rt2DfH9FC5TK/CnT5pPNsj60OkWeeXW6md/fqS?=
 =?us-ascii?Q?WZblFu4EM46G4PCM80yF01f5vEzCkpY9iW4f3BDce6Phqn/uQuETWWgprMJc?=
 =?us-ascii?Q?6+8CoCI8tEAzgDa8AaRwnR0RKlufWTfH2oWnlmXVyWcFoD5gORx4gPxWWYH5?=
 =?us-ascii?Q?cNlGDHKHhuNIZrYahj9AsiX/w496JQIat6ugVg+Q61+mu+PGVrtYodXHrBzX?=
 =?us-ascii?Q?oYtbjy4xjbp3bhyUqCdJEs1nhwhH9zvAhJj3p12C3mlM9t6Jtz6srgzcAn9+?=
 =?us-ascii?Q?dPdvRTYNKS+8X3Itgzy7pYcfC4sO4nmyphiO6OpSJDNbs79KMfI9I6Dkn+6M?=
 =?us-ascii?Q?rL67CZMl793DOjU6gPxNp57dvq/XMGBxRuVPD5y32l6bO+9vhWbkgxzpuXw+?=
 =?us-ascii?Q?flb0IlwREES8JLsLHdVMTSj3v1JY0SMUV2fSz8NQ5z2Ss1HLzIzSE4/bvt+w?=
 =?us-ascii?Q?AarEeKyzHqm2s3QhkYP/+tBo+LkA+MRNgbvr92xqqAlHyC+LOattFWrLW9+L?=
 =?us-ascii?Q?MrgMuoHbM4TIwUW1fPWWaHsHS/To4ItkC1zMKxp0u78QAoRi5+1PY7N3CMZh?=
 =?us-ascii?Q?C1iXlKLKqw0lPOMpeReBDHfv8v41w//jxVzMJHrdWz4xTMLkpre1l4ov7I7Y?=
 =?us-ascii?Q?8pmwkzj3cmHnXp6FKTe2rsdkOohJF2d8o3U5gl90ruuJXcs68MDr4v4bfsq+?=
 =?us-ascii?Q?u3e5HIBwvnkHq1tZvyB9GRu/9r+rqeqv972DW5pfKGuPVc2plr9Oefdoyk5z?=
 =?us-ascii?Q?RzIEKTDDQJhww/7ZOCxSk2CiPQyttwIVqjpAoFG2k8TGuupzcJvSbGFu2heI?=
 =?us-ascii?Q?V9h09J7+mZyGfE2t2V7/6Yg21BnbzpcDA16o70IM7fXVbxs6l00Zj/pIkFVm?=
 =?us-ascii?Q?1FUmoQNqXlqVtTJWt0AtZPzChz09Yv4nwOSCNTuLDrrx+oA7kNKoBtMJlpis?=
 =?us-ascii?Q?6Pb6ztDrqL2sRRPybVqm30vVLVIT?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 04:44:12.4075
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8838529-34fe-4d3a-dc5e-08dc6fe2ac66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9446

The per cpu variable cpu_number1 is passed to xlnx_event_handler as
argument "dev_id", but it is not used in this function. So drop the
initialization of this variable and rename it to dummy_cpu_number.
This patch is to fix the following call trace when the kernel option
CONFIG_DEBUG_ATOMIC_SLEEP is enabled:

BUG: sleeping function called from invalid context at include/linux/sched/mm.h:274
    in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1, name: swapper/0
    preempt_count: 1, expected: 0
    CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.1.0 #53
    Hardware name: Xilinx Versal vmk180 Eval board rev1.1 (QSPI) (DT)
    Call trace:
     dump_backtrace+0xd0/0xe0
     show_stack+0x18/0x40
     dump_stack_lvl+0x7c/0xa0
     dump_stack+0x18/0x34
     __might_resched+0x10c/0x140
     __might_sleep+0x4c/0xa0
     __kmem_cache_alloc_node+0xf4/0x168
     kmalloc_trace+0x28/0x38
     __request_percpu_irq+0x74/0x138
     xlnx_event_manager_probe+0xf8/0x298
     platform_probe+0x68/0xd8

Fixes: daed80ed0758 ("soc: xilinx: Fix for call trace due to the usage of smp_processor_id()")
Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
---
 drivers/soc/xilinx/xlnx_event_manager.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/soc/xilinx/xlnx_event_manager.c b/drivers/soc/xilinx/xlnx_event_manager.c
index 253299e4214d..366018f6a0ee 100644
--- a/drivers/soc/xilinx/xlnx_event_manager.c
+++ b/drivers/soc/xilinx/xlnx_event_manager.c
@@ -3,6 +3,7 @@
  * Xilinx Event Management Driver
  *
  *  Copyright (C) 2021 Xilinx, Inc.
+ *  Copyright (C) 2024 Advanced Micro Devices, Inc.
  *
  *  Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
  */
@@ -19,7 +20,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-static DEFINE_PER_CPU_READ_MOSTLY(int, cpu_number1);
+static DEFINE_PER_CPU_READ_MOSTLY(int, dummy_cpu_number);
 
 static int virq_sgi;
 static int event_manager_availability = -EACCES;
@@ -570,7 +571,6 @@ static void xlnx_disable_percpu_irq(void *data)
 static int xlnx_event_init_sgi(struct platform_device *pdev)
 {
 	int ret = 0;
-	int cpu;
 	/*
 	 * IRQ related structures are used for the following:
 	 * for each SGI interrupt ensure its mapped by GIC IRQ domain
@@ -607,11 +607,8 @@ static int xlnx_event_init_sgi(struct platform_device *pdev)
 	sgi_fwspec.param[0] = sgi_num;
 	virq_sgi = irq_create_fwspec_mapping(&sgi_fwspec);
 
-	cpu = get_cpu();
-	per_cpu(cpu_number1, cpu) = cpu;
 	ret = request_percpu_irq(virq_sgi, xlnx_event_handler, "xlnx_event_mgmt",
-				 &cpu_number1);
-	put_cpu();
+				 &dummy_cpu_number);
 
 	WARN_ON(ret);
 	if (ret) {
@@ -627,16 +624,12 @@ static int xlnx_event_init_sgi(struct platform_device *pdev)
 
 static void xlnx_event_cleanup_sgi(struct platform_device *pdev)
 {
-	int cpu = smp_processor_id();
-
-	per_cpu(cpu_number1, cpu) = cpu;
-
 	cpuhp_remove_state(CPUHP_AP_ONLINE_DYN);
 
 	on_each_cpu(xlnx_disable_percpu_irq, NULL, 1);
 
 	irq_clear_status_flags(virq_sgi, IRQ_PER_CPU);
-	free_percpu_irq(virq_sgi, &cpu_number1);
+	free_percpu_irq(virq_sgi, &dummy_cpu_number);
 	irq_dispose_mapping(virq_sgi);
 }
 
-- 
2.17.1


