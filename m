Return-Path: <linux-kernel+bounces-564096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A48C6A64DC3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27CF21896E27
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAB6238166;
	Mon, 17 Mar 2025 12:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SBuV626O"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2051.outbound.protection.outlook.com [40.107.96.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C8921D5A7
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 12:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742212827; cv=fail; b=NI42EP18oBBHWerkrK7pAdLuzHOKM4rsILhSbZcg+32KhNpgMi235oxMGO3yhcBAB3OMokVFmBgtoB9b6/BExeSlaT/8T0xet1Add684iWeixmswipeaty+MJArKv0bxYEegA8gEIgdp+j5pGUG7qYjfVyuvSPCUoZIGIoVLaiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742212827; c=relaxed/simple;
	bh=+odrWHFjENnj566FDvXk5m9hfRO41C+iVATxpQy3CNI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mfMjtZIoRmZiULBriB/07WoBlewt4JjV+IzYyRxVwtLqrFjR94C3WqBgipPhUXCyZH/eAS0e7srOtEXucigrhlijZj2SWa1RJOrawKFHolWaVcISluKVLZDLSwRb0vZXBf7XM36c74fubv01hV4l6utIpiFAB2ZK8v4KSmJB4P0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SBuV626O; arc=fail smtp.client-ip=40.107.96.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFslR0/G0LZ9Bm30a6zlQoYCcILGZoCwb0pDXrG8RTbKlQIOlRl/gpv0IBR8HtoBQG6/LcPnjd1NxMxHpt95UMw/vBbtMEneA33KCqiiAv83G2yjkMRb9iUl0V2IaY545GAbwvodwzVo2qm3jqD7+GZY6WfS+0wYwYLD6fCDxFhywjEV5jX12EPmO90khjeompTZUdb10uhpZ+7Z3Lb7fHPn27JsRRWcAC/gqQQV4tSgTcigdN8NUZELPj+PZr/JBgW63/cQ2t1dIWxLRuZYgPqP2Hr+RemBC+mHwQvTNP+pfdD8WE94lRYN1hun/V/4du3gUSjzMk8iDUDShn53Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxZ6Q+Qk3CMRhNQCLaNvbGx9WD2qItxt4GAD2FPx/64=;
 b=VmwD8ussPtTG1s0x4o80yqBHprANVuaawbfpPLs/ixzIIKJJULZEaHK8JJ2GXytlTaRelYwXKS/pIh64MP2LzeH4kxU3j6CHBZFduiBT+jG53ynX0aB9YlvWnH6+r9+2ziohZSfq8UJkRIHUk5rWhNdjPNcGv0tqyd9moSVwC9utkyC+7Y6aqHgtaxIVu1Q9DwDusosrj/QGsinjX49A056a3MVaNz1Zupq5rHDyFxw0G8bCC/+5Nacx6ZHdBo6bIFdkTA5K7XpCH2Gv7j8r2sjTt/1JkrjP+yFpKQGwOQiauuXDmgJXxEIFbe44aMqfo4X8ziFxYuAK5QQNLttPOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxZ6Q+Qk3CMRhNQCLaNvbGx9WD2qItxt4GAD2FPx/64=;
 b=SBuV626OUDrh/vUQmEg39KF6ZGKNk37Q/B80x39lXITIBHnXruJSTpBg76kg9dLiyk4XBbqglbcIA6ktFGfKJM/dMySqwsqfGPIexDLfaUFPizYdfJyFBr7tkP13kJThDQs0sEkqtKXmvzxEJ6kGWelgS910V+rgqniGjgCoyFU=
Received: from PH7PR13CA0002.namprd13.prod.outlook.com (2603:10b6:510:174::6)
 by IA1PR12MB8334.namprd12.prod.outlook.com (2603:10b6:208:3ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.30; Mon, 17 Mar
 2025 12:00:20 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:510:174:cafe::78) by PH7PR13CA0002.outlook.office365.com
 (2603:10b6:510:174::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.32 via Frontend Transport; Mon,
 17 Mar 2025 12:00:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8583.3 via Frontend Transport; Mon, 17 Mar 2025 12:00:19 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Mar
 2025 07:00:15 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <suravee.suthikulpanit@amd.com>, <vasant.hegde@amd.com>, "Dheeraj Kumar
 Srivastava" <dheerajkumar.srivastava@amd.com>
Subject: [PATCH v4 4/8] iommu/amd: Add debugfs support to dump IOMMU command buffer
Date: Mon, 17 Mar 2025 17:28:26 +0530
Message-ID: <20250317115830.3416-5-dheerajkumar.srivastava@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250317115830.3416-1-dheerajkumar.srivastava@amd.com>
References: <20250317115830.3416-1-dheerajkumar.srivastava@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|IA1PR12MB8334:EE_
X-MS-Office365-Filtering-Correlation-Id: d38a87e5-28f6-48c2-bec6-08dd654b4a1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1jpsveRKcw6FILP98SXlk4yEf2P41DNj6D3XTS0LuOm8Yu6XPIN1jUM+bCDR?=
 =?us-ascii?Q?PyyemgKnp1QGMTFvtJE/eiHdQTN+aMhpWjo1Cw+X36o/hah6xYJTh98ymIoa?=
 =?us-ascii?Q?8NKA3OMNSdGYvJW/LuHAoJzFvDU9OLoPpiVrRu/FVFRwEXetAFkwpZZ8j0AF?=
 =?us-ascii?Q?7v9kpoSkZgbCsrjGPg4UsGDd02OvqhxYBNGWg8rXH8JDRJVj/AmlPw0DnliY?=
 =?us-ascii?Q?tP9bJWOAxPH/qxzAThOmps5hs3FFMRN80OpuZykP5gw7GKWkyC+6cwWcxTPW?=
 =?us-ascii?Q?vGPgu5NHv6zuSWIYJ6oLjwzUQ8qitkukI1V3gX7N1ZfqiyQC0a4VesuHMxDG?=
 =?us-ascii?Q?vvrolt6XLjmFJAHqFAPP+VFSG0GtJegPytyKc3jhBlz7O6Nt36ZH6BIF2JD/?=
 =?us-ascii?Q?U2IjLepTGagSCLVTUBTeK7H6vw0zCl3w1bdOIWkkveucwtfAB4NKawIX8NZ5?=
 =?us-ascii?Q?+0RwAJpSOjdPETWx50Je7i6l/V2poEuIhsT3mfvgOhwpuBkRXBiOngjPH93r?=
 =?us-ascii?Q?ySCmt9sqUgZkwpT9ycWcmEtZzWuhJvqVboGkXSEVozgsOb5nYu5Vi3VAfjx6?=
 =?us-ascii?Q?tPUn/0zGwlIw4dQVrfbaPZJKXKTioRqk5Rph5a4zBLQWLpkNe6ZCi89+Dc4v?=
 =?us-ascii?Q?+ax8XgE9Rlov0MriDA0wepwtwhe7Bv75RxVO3MXn1qZKXb0+7tqqZPi63pMy?=
 =?us-ascii?Q?cytrJ+a4qEiN1SZmYQZ0tjshumXO5xAoZsT3KancfBSZ43sVjliMlTgb82nk?=
 =?us-ascii?Q?9/4hXgNiEPR2a64iyigast+7AefP/c60ORefeEzquRIo0g6wMR7r6HIkpmYo?=
 =?us-ascii?Q?DZQxu47/rgX+Vk8j2g0rwYmT9bE1cWz5T80k9W2AngaqG19ELU08K8LFCows?=
 =?us-ascii?Q?+HPk/q0+ASaSLVGZQfU9GlX6+NPpZ8IXD0ihFSGeX4VFc+8Ah76H4qCfKIPk?=
 =?us-ascii?Q?aH5jEUwb2JvONt8R+7eg0XDiilSavSR+WrQHy9oSjesHlKCsnNNypQDGWVIt?=
 =?us-ascii?Q?6pIyw7sMie4SNdYM3l9ebQys7cTvUZx8Jgv5QrPCpflz1vPBgO19zTMp9ZA2?=
 =?us-ascii?Q?+YYACxnWk+W04xOSF/G0hBzNI5VuAnFDgeV/Sycr+Fu7Qe0+BU6crhvMy8pm?=
 =?us-ascii?Q?uZw9Gk7RfnyfJReo7hlNdk7tTKMQw4n35OSScTUE3sVSmIEdSmIFWnzwG5xb?=
 =?us-ascii?Q?HDWr5kAfpThczV4VhP1V7OHtAvTWo8PcTyDkwxBZTQ7LLLKhLhnhlWy59Wi3?=
 =?us-ascii?Q?7lSG6jedy5HkoNZH+Wmw0Ei2zsNNvuMvMb65UZ7AzJbG+X7Kd7bRYob1ni5T?=
 =?us-ascii?Q?SXPFbvFlj9BDWk2iRJrK0PNJAsLGfD2s/Zi11tJqvHwmmiuHiSp40K2wtsuy?=
 =?us-ascii?Q?xrahVJg85qbZDyIs99ZJVaFR+DRDLderXzl7ytydWDMG9UvPYYsqaoMqNvIR?=
 =?us-ascii?Q?xtEMmvtWUW0YyaqF/D17P0XJM2E+Tu09EZzFpcOSmny87DgU9kDA+rkPvTjM?=
 =?us-ascii?Q?UJxn2/jFdTwqzuM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 12:00:19.5619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d38a87e5-28f6-48c2-bec6-08dd654b4a1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8334

IOMMU driver sends command to IOMMU hardware via command buffer. In cases
where IOMMU hardware fails to process commands in command buffer, dumping
it is a valuable input to debug the issue.

IOMMU hardware processes command buffer entry at offset equals to the head
pointer. Dumping just the entry at the head pointer may not always be
useful. The current head may not be pointing to the entry of the command
buffer which is causing the issue. IOMMU Hardware may have processed the
entry and updated the head pointer. So dumping the entire command buffer
gives a broad understanding of what hardware was/is doing. The command
buffer dump will have all entries from start to end of the command buffer.
Along with that, it will have a head and tail command buffer pointer
register dump to facilitate where the IOMMU driver and hardware are in
the command buffer for injecting and processing the entries respectively.

Command buffer is a per IOMMU data structure. So dumping on per IOMMU
basis.
eg.
-> To get command buffer dump for iommu<x> (say, iommu00)
   #cat /sys/kernel/debug/iommu/amd/iommu00/cmdbuf

Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  7 +++++++
 drivers/iommu/amd/debugfs.c         | 26 ++++++++++++++++++++++++++
 drivers/iommu/amd/iommu.c           |  7 -------
 3 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 23caea22f8dc..022e32f0a877 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -893,6 +893,13 @@ struct dev_table_entry {
 	};
 };
 
+/*
+ * Structure defining one entry in the command buffer
+ */
+struct iommu_cmd {
+	u32 data[4];
+};
+
 /*
  * Structure to sture persistent DTE flags from IVHD
  */
diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
index 33ffa1c7a511..d211c1343f93 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -107,6 +107,30 @@ static int iommu_capability_show(struct seq_file *m, void *unused)
 }
 DEFINE_SHOW_STORE_ATTRIBUTE(iommu_capability);
 
+static int iommu_cmdbuf_show(struct seq_file *m, void *unused)
+{
+	struct amd_iommu *iommu = m->private;
+	struct iommu_cmd *cmd;
+	unsigned long flag;
+	u32 head, tail;
+	int i;
+
+	raw_spin_lock_irqsave(&iommu->lock, flag);
+	head = readl(iommu->mmio_base + MMIO_CMD_HEAD_OFFSET);
+	tail = readl(iommu->mmio_base + MMIO_CMD_TAIL_OFFSET);
+	seq_printf(m, "CMD Buffer Head Offset:%d Tail Offset:%d\n",
+		   (head >> 4) & 0x7fff, (tail >> 4) & 0x7fff);
+	for (i = 0; i < CMD_BUFFER_ENTRIES; i++) {
+		cmd = (struct iommu_cmd *)(iommu->cmd_buf + i * sizeof(*cmd));
+		seq_printf(m, "%3d: %08x %08x %08x %08x\n", i, cmd->data[0],
+			   cmd->data[1], cmd->data[2], cmd->data[3]);
+	}
+	raw_spin_unlock_irqrestore(&iommu->lock, flag);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(iommu_cmdbuf);
+
 void amd_iommu_debugfs_setup(void)
 {
 	struct amd_iommu *iommu;
@@ -122,5 +146,7 @@ void amd_iommu_debugfs_setup(void)
 				    &iommu_mmio_fops);
 		debugfs_create_file("capability", 0644, iommu->debugfs, iommu,
 				    &iommu_capability_fops);
+		debugfs_create_file("cmdbuf", 0444, iommu->debugfs, iommu,
+				    &iommu_cmdbuf_fops);
 	}
 }
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index cd5116d8c3b2..5c51ffe7c956 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -62,13 +62,6 @@ static const struct iommu_dirty_ops amd_dirty_ops;
 
 int amd_iommu_max_glx_val = -1;
 
-/*
- * general struct to manage commands send to an IOMMU
- */
-struct iommu_cmd {
-	u32 data[4];
-};
-
 /*
  * AMD IOMMU allows up to 2^16 different protection domains. This is a bitmap
  * to know which ones are already in use.
-- 
2.25.1


