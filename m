Return-Path: <linux-kernel+bounces-188683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4688CE54D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F2ABB2267A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C55127B4E;
	Fri, 24 May 2024 12:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3g556N1E"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1EB12A179;
	Fri, 24 May 2024 12:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716553539; cv=fail; b=UkMvYvBrc0mkgZ/HWM3sr6zEvn71ulEiaWCgU5aaUrEKcZsqlT1+GRrMjd6rm6EgQI8GK/Vhhr90uPFnsCRqWLXCzhsXuC1g1F1PKrWI/XVcMufM1IcxQ4YEO5Q3+RjiyFSSoJjwc5MR4jwMJmkSDoATw4p3otR4gI8nDSj63RQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716553539; c=relaxed/simple;
	bh=BO/mg9Oa3+id2fyN558L49n3Z9fEwRniQaXWE193NNc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mQBvYaTGXqmipc33sYHQ/P7+dYTMSLbdx5adjVDaoeXRH7K315H53yqW8WocoHLCUuzyKviATKhxX2fO/GPN5BrYK1HVc9JhHnU5T46sIaSWXak+g0r8+REXlxHU2ynmZ0wJJ1yHe7wSmEd16KR2tT4SVBz1RHmK9T3jK1KO5Io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3g556N1E; arc=fail smtp.client-ip=40.107.102.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lK0mEpb1lJkxr6i+KmLKJK0Gb9DYvNBObx4vyWp7Qf+HpLblGhVZ++mxgqqkE2rOv1drxkjoaOtBRvkxry4N0bvczzkVX8nkpNK/VQ8BrN+cI/YICX60JxHiUwvb/Ca39iEviRLzjtuO+m/2HiXCZ/kpuIk1gYNLYNw2Jf9/N8dAsonu4iXESO8NuKsV6mR79rprXr6R6ZtXGvjXrEkrDdugUXddz427iedBZ6eVvnJvvEx5XqitE54PChmMOjFnn1qLgrsNrSP8MeptSxgx4LBexvAy7X7nMJZdPPCqBAjDKEz/XGXjrCtqElQ168x/HSm99cQzCKdD9bltu61K+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YA+X2yipnjQ0VmBME9SVD28255wEo6nyallXoTMonXQ=;
 b=lo4Z2wGxx+t2KIZRgaBiPWWY6HKg6qljZuc4vYEIa3+zrYnpfIJW5JMlmsSrPESrCz3Uk5z6aYY5yQPO9vbORdtTlZIdl8cU+BYwE3QtksCsJbLZpcqzRvQX4aFGY83J1klpZZg2T0ukNd9FDyeC9k/xkkaw1C5/wVJgozBoVWNEhXV0RiqOIqrXyHqBkDE6/Kdi4cmIyzIxbkvklmFiyOqiSfzHUKZ7diiXcX4WzsoWdMfd8YRZVQws4SxHhLpUI67tZrALFuu33e4stV7KmoRXqovI+UrHYiar/9reGr44Ma5+aN3mrZ4sBRxO5z9JRhpLAlf/LMfNdkKOa0S30A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YA+X2yipnjQ0VmBME9SVD28255wEo6nyallXoTMonXQ=;
 b=3g556N1EM1p+oOfxmtOiD2q44q/Mp6BnoM+dpc6+IQxzjLCV2mutqZbVzG6ZYZ+xtEx9/LLlRADG8JIvDt0K40p4uc4GNFqdlDESwyzXcd2ldRNqwbeQfLOwNzUTHKzWPtBrtK6Zyy8/KMPwpcnZTCsOvO/aIt66GTFiYPjoMrA=
Received: from SJ0PR03CA0192.namprd03.prod.outlook.com (2603:10b6:a03:2ef::17)
 by MW4PR12MB7262.namprd12.prod.outlook.com (2603:10b6:303:228::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Fri, 24 May
 2024 12:25:34 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::a3) by SJ0PR03CA0192.outlook.office365.com
 (2603:10b6:a03:2ef::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Fri, 24 May 2024 12:25:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Fri, 24 May 2024 12:25:34 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 24 May
 2024 07:25:32 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <babu.moger@amd.com>, <kim.phillips@amd.com>,
	<lukas.bulwahn@gmail.com>, <seanjc@google.com>, <jmattson@google.com>,
	<leitao@debian.org>, <jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <james.morse@arm.com>
Subject: [PATCH v4 13/19] x86/resctrl: Add data structures for ABMC assignment
Date: Fri, 24 May 2024 07:23:32 -0500
Message-ID: <a68ff64d52eff2de91a3c6030c2650396ea7fb8c.1716552602.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1716552602.git.babu.moger@amd.com>
References: <cover.1716552602.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|MW4PR12MB7262:EE_
X-MS-Office365-Filtering-Correlation-Id: bad5bf8c-6a6f-49d7-65f2-08dc7bec9c26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|36860700004|82310400017|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zmx6VkRWVFIxeWNHYnBhMkxXQUp4dE5jR20zTjNCQktoMTNpQ0lJUC9ZYXRp?=
 =?utf-8?B?a3FPZ3oyaG55bnprdmlXd0x5dGw4c3A4L1pJcFNtd1MzbkF0aVhtNE5KdWRC?=
 =?utf-8?B?Y3lPQ28reFRPUEFVRGdoL3ROaVNhVC9YM0huaklFbkpzMk5Mei9kbXNnMlh5?=
 =?utf-8?B?SlFLSk9IeGE0S3BVZys3SUcrK1V3NVhLYjJDaGdqS3ptalNXR05BeVBIZitu?=
 =?utf-8?B?US95UWdodm5yRXJhdFd4cFZmQVRURlhhOHA4eTdNbElqcElRcnFyK1F4bWxB?=
 =?utf-8?B?Lzc1NTBYNXJzMUhOb3hWNHJPMm5salNwNjhBZE51UURCZ3JmM0NYTkFIV25h?=
 =?utf-8?B?Tmt6aHVMRllZSWQzSmZ0UEgxakJQTndBeHgxU25oRUlScTdPRFE4ZGZjSTZE?=
 =?utf-8?B?T3FvYm5PQjF4QkRmYlJpdlNHMEV1eUJiOGV6U0ZEYzNYUDBNTHd3c0MzaUEw?=
 =?utf-8?B?VVlDdDU1QVF2eC9KNHBrU0h6WXVodWNGbHlaSCs0SlpYb2RNVjhkZC9mQndC?=
 =?utf-8?B?VTFhSWkvSHZmbmlpOVRzUjFLVlNMazNVb1dnd2NNM1J1NFcvSDZrSG5QbFd5?=
 =?utf-8?B?TzkyTFltQWN4MUlCNkVLeXB1d3RubjdEQy9lYnRIWms4Nk1iSmxvRXIzTzNr?=
 =?utf-8?B?NHgvMGQ3Wjk0eFl5Q3cyVHI2TytSeU5JZ1p1SlNCMm5URDNzc2VnSWdLYmti?=
 =?utf-8?B?MmJJNVYwTy82UEIxaUNSQWU1WlpNb1h0YzRPa2pQU09jaEhiWG53RHZjaXJC?=
 =?utf-8?B?TWVXVUNYZFQ0by9ScnY5RDFOQ3pSbndQZEpVcHBPK2tQK2JNa0JtUGVpdlJZ?=
 =?utf-8?B?cndhdGxGZ09oWEpBQUJ2TE5EN2syS3piclAyRisyUDFOT2g1QXFmSWNhUkdU?=
 =?utf-8?B?a0dlaTVrQlZZVWt2R0ZPemZsaFJjMk1UdXlsY21UVUozOHRlM0xvK3dGUkR0?=
 =?utf-8?B?SXVJVHJjTFRRMWZsdGRsRDFQM3VlUHQwOHEreGdBK1RNaEUvWGIreVBUVUNv?=
 =?utf-8?B?UWY0ZDVQczlEUXJudGRTZUhrR21mU3o0c0c2OXQ2azJhclpvUVJSR2d3RnhV?=
 =?utf-8?B?Qm96aEw1VUM1b3FCQkc1dkxTSTZ1anpZelB0YWtpV2h6VWNKcmtJMG1kV0J5?=
 =?utf-8?B?bFFRU1VkbmFrZHFkNU5wL29mSzJ2TEo5bTJ3dWQ4TWVQd0hycnVYUTZrWVh0?=
 =?utf-8?B?YjRUZXVqOTAzTkR3dE5yVUhVYlp3SjR3aHBMeFg2YmdDVG11SzgvQm1KNnB0?=
 =?utf-8?B?VlFUZzdvNXRqWnFMOThscGh5U1Y3Y0RBdG5VR25LK1ZJUXE5clBBYlFIWENh?=
 =?utf-8?B?OXNLNWg4QUZiZm13MlVDTXZoZlNrTTBDN1lUZTFiTHBIanJUKzVqQVQ5MlZ5?=
 =?utf-8?B?K1Q3NkMydVZlYzZZcENFWUxBbFBaY0JkemVhOUJpblVranVYYThPZFdqQVJD?=
 =?utf-8?B?MUFGVWQ2ZkNmVkdUeW5vNUpIMmRDajhKS01lbWFGSUtPS0p5bERDY2ZxWUpM?=
 =?utf-8?B?a3ZqSWh1aFZ3dDJRcHdMU2xZYWMxeGdCR3lIZDB0Y1Q2MTcyeE5TUzJhQVho?=
 =?utf-8?B?Rkx4RTRsOE1lTjJaVm42U1FrTmxBd0owNitKazdGWjNYR0wwWWNqYWhmWjRX?=
 =?utf-8?B?MS92MXQyYlEzY24zeDNlaUpOY0oyL1NoZGM4Y3pFeFBXMWc3MjVSMGtoSU1Q?=
 =?utf-8?B?aHhUcDFLUU1WdkRtMXd2QlhGY0xCSUlrbk5wdVV2RFlsNUNRM050Qzh5R2dU?=
 =?utf-8?Q?ooglOh3BAMFnZIJI7fEL9MKxVG0nRtaKmzzlKlm?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 12:25:34.0309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bad5bf8c-6a6f-49d7-65f2-08dc7bec9c26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7262

The ABMC feature provides an option to the user to assign a hardware
counter to an RMID and monitor the bandwidth as long as the counter
is assigned. The bandwidth events will be tracked by the hardware until
the user changes the configuration. Each resctrl group can configure
maximum two counters, one for total event and one for local event.

The counters are configured by writing to MSR L3_QOS_ABMC_CFG.
Configuration is done by setting the counter id, bandwidth source (RMID),
bandwidth types. Reading L3_QOS_ABMC_DSC returns the configuration of
the counter id specified in L3_QOS_ABMC_CFG.

Attempts to read or write these MSRs when ABMC is not enabled will result
in a #GP(0) exception.

MSR L3_QOS_ABMC_CFG (0xC000_03FDh) and L3_QOS_ABMC_DSC (0xC000_03FEh)
details.
==========================================================================
Bits 	Mnemonic	Description		Access Type   Reset Value
==========================================================================
63 	CfgEn 		Configuration Enable 	R/W 		0

62 	CtrEn 		Counter Enable 		R/W 		0

61:53 	– 		Reserved 		MBZ 		0

52:48 	CtrID 		Counter Identifier	R/W		0

47 	IsCOS		BwSrc field is a COS	R/W		0
			(not an RMID)

46:44 	–		Reserved		MBZ		0

43:32	BwSrc		Bandwidth Source	R/W		0
			(RMID or COS)

31:0	BwType		Bandwidth types to	R/W		0
			track for this counter
==========================================================================

The feature details are documented in the APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
Monitoring (ABMC).

Signed-off-by: Babu Moger <babu.moger@amd.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
---
v4: Added more descriptions.
    Changed the name abmc_ctr_id to ctr_id.
    Added L3_QOS_ABMC_DSC. Used for reading the configuration.

v3: No changes.

v2: No changes.
---
 arch/x86/include/asm/msr-index.h       |  2 ++
 arch/x86/kernel/cpu/resctrl/internal.h | 30 ++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 5f9a0139e98c..6d2fe39ac68f 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1172,6 +1172,8 @@
 #define MSR_IA32_SMBA_BW_BASE		0xc0000280
 #define MSR_IA32_EVT_CFG_BASE		0xc0000400
 #define MSR_IA32_L3_QOS_EXT_CFG		0xc00003ff
+#define MSR_IA32_L3_QOS_ABMC_CFG	0xc00003fd
+#define MSR_IA32_L3_QOS_ABMC_DSC	0xc00003fe
 
 /* MSR_IA32_VMX_MISC bits */
 #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 60a1ca0a11a7..45ed33f4f0ff 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -107,6 +107,9 @@ cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
 #define ASSIGN_TOTAL			BIT(QOS_L3_MBM_TOTAL_EVENT_ID)
 #define ASSIGN_LOCAL			BIT(QOS_L3_MBM_LOCAL_EVENT_ID)
 
+/* Maximum assignable counters per resctrl group */
+#define MAX_CNTRS		2
+
 struct rdt_fs_context {
 	struct kernfs_fs_context	kfc;
 	bool				enable_cdpl2;
@@ -211,6 +214,7 @@ enum rdtgrp_mode {
  * @crdtgrp_list:		child rdtgroup node list
  * @rmid:			rmid for this rdtgroup
  * @mon_state:			Assignment state of the group
+ * @ctr_id:			ABMC counter ids assigned to this group
  */
 struct mongroup {
 	struct kernfs_node	*mon_data_kn;
@@ -218,6 +222,7 @@ struct mongroup {
 	struct list_head	crdtgrp_list;
 	u32			rmid;
 	u32			mon_state;
+	u32			ctr_id[MAX_CNTRS];
 };
 
 /**
@@ -568,6 +573,31 @@ union cpuid_0x10_x_edx {
 	unsigned int full;
 };
 
+/*
+ * ABMC counters can be configured  by writing to L3_QOS_ABMC_CFG.
+ * @bw_type		: Bandwidth types to track for this counter
+ * @bw_src		: Bandwidth Source (RMID or CLOSID)
+ * @reserved1		: Reserved
+ * @is_cos		: BwSrc field is a COS (not an RMID)
+ * @ctr_id		: Counter Identifier
+ * @reserved		: Reserved
+ * @ctr_en		: Counter Enable bit
+ * @cfg_en		: Configuration Enable bit
+ */
+union l3_qos_abmc_cfg {
+	struct {
+		unsigned long  bw_type	:32,
+			       bw_src	:12,
+			       reserved1: 3,
+			       is_cos	: 1,
+			       ctr_id	: 5,
+			       reserved	: 9,
+			       ctr_en	: 1,
+			       cfg_en	: 1;
+	} split;
+	unsigned long full;
+};
+
 void rdt_last_cmd_clear(void);
 void rdt_last_cmd_puts(const char *s);
 __printf(1, 2)
-- 
2.34.1


