Return-Path: <linux-kernel+bounces-302993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F16F9605DA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E5CEB22C9C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6681A072D;
	Tue, 27 Aug 2024 09:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RCx4QAH4"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDCB1A0708;
	Tue, 27 Aug 2024 09:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724751476; cv=fail; b=b3C6w1wxtyQwREmxrqcjNXt2VEp55sAWxDAhmb3n23q3xGYYu1at3hzU+4tQe+B0bxFH6riM2Lyck8cwGcB0uwwOwCwogIAQ3aZLlUdLO85ojJ2e6t2FYWVV324+yU8zZo3LqMokzdPCZGLeAlshBmRNMjzMfCDucvgIbGLVvCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724751476; c=relaxed/simple;
	bh=68hKaFLnYw8/mXDitCZbqTm27iCu2PbQkz832og0OoA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OdFyUweQYEv16efP9R0zEoNaijubM3ZP78dagKOlou8jSrub6hQeF4S9uCytDQg0IFxppxdEgLf1kAR3zvYAkqDbiHWqQ1hp4Th8dzIUMlg5Hex50z7hH67hSGYfcWz/JrmYraWuWfgbdWx/DZJ91erFbWptwvi8x2sMhvxnqEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RCx4QAH4; arc=fail smtp.client-ip=40.107.94.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H15juIC+7NfHgUJVO4OAicX5d6QypQNtVZ4bz3xN+T6X3nDe+ibVFlDkTl7LDgCAqfHD9sHaC49W9dqnAumODmRn+rJDAV0Lqp0+BBYyzsECsX++sU7JqD6MppwpWQy5q9Xdzd6cy5/eF0hC+Ol7WNX6ZQsh5YgYLivEe8Vo4KQQCxZH5aeGUxjmyJYlAekCkutIRwiAa31C3i4hmS+1/mesj41NY+4wgz4m9n4RkUxJLgGKv/XdgyZBPCUquh0XkDH0GQNwh86ETcit2Oau8YFGz4BgJBnL/8hB8QRuCis15IrUTo5f0fNMLQkENWDrDxHYjRLO/SgIs+UMhTPIjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MKDFanQWgd0EAiVDTKgKUOU6q7SJxPcs60yln3Z4PkQ=;
 b=bmH/Tjx40yPQAcXLVFJzLqSl0v7x3+oy3c6E4OqwxuplpfOztH0UDIgTK0K/9mprSrxNksnUZElQqbP/JVq+JPnc1/iObv5FyX3UYslJa8EIJZ3H/IfsNz8H/hquSPVJDqK0iJV+ooFy+Ka9s/wV5CDEYI1fuNpwFnC7IEEdtdmFNdb4eZxQZtfIs3RwX9FjHyU2QPl3nt5ZhBK694xeTMq0GphDw0XFmMgFVc8VBe8SQlgcENCc5rof8zzm3bCuzeY3SKxkR3j0PM00Eptqv2t8lVpbud8ehtRKgxoyzhFtUl9lk9bxi9MaXldtr5UrAHe0AShwYlz6xBU2JEnaCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKDFanQWgd0EAiVDTKgKUOU6q7SJxPcs60yln3Z4PkQ=;
 b=RCx4QAH4eRqWY0R4EG4X/qpS0D1mwEgB95gK4alYrtbbnQ0oYTWEGNBCY6cKa1aZHRqRHnn42Md02fT45h9V1KIec6ko/nm/cuj8/f6rFVS81+D5eZOJNU1vpGhH0WoyGEoVLV0r/lRf3atCaLKL1RyQpu2gKjetdO9AyXP+OyI=
Received: from MN2PR01CA0043.prod.exchangelabs.com (2603:10b6:208:23f::12) by
 CH3PR12MB7715.namprd12.prod.outlook.com (2603:10b6:610:151::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 09:37:50 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::3e) by MN2PR01CA0043.outlook.office365.com
 (2603:10b6:208:23f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26 via Frontend
 Transport; Tue, 27 Aug 2024 09:37:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 09:37:50 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 04:37:46 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>,
	<Mario.Limonciello@amd.com>, <Borislav.Petkov@amd.com>,
	<kprateek.nayak@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<bharathprabhu.perdoor@amd.com>, <poonam.aggrwal@amd.com>, <Li.Meng@amd.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Xiaojian.Du@amd.com>
Subject: [PATCH 10/11] x86/process: Clear hardware feedback history for AMD processors
Date: Tue, 27 Aug 2024 17:36:58 +0800
Message-ID: <fa3ad80c1373cba3c07c35862d8fbe296302bb4b.1724748733.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1724748733.git.perry.yuan@amd.com>
References: <cover.1724748733.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|CH3PR12MB7715:EE_
X-MS-Office365-Filtering-Correlation-Id: c2207e16-68db-4b0d-eb7f-08dcc67beac0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1gpW7wr6EepzTYov5ri58SbsDeweNiDzea5M8QfwkgQhYbds6AAiEMX3aXCL?=
 =?us-ascii?Q?EudlHIAFTlkCrkSZl+yguDoM18cKv4VlgQ25w0ytG3i6aQJawh+ktTERquPJ?=
 =?us-ascii?Q?YS4nF3DlfHu+g1F2aHn7BlFIXjEbJra8IE2cHrGGhFgvIjAZV983Ox1D5+fp?=
 =?us-ascii?Q?8K5w7LbTrCcrE9qeVPCBsxCPGoIpotxV7Ugv1FowupYXDNN96QZlGdjHfPmi?=
 =?us-ascii?Q?c0wGGNO6tbRB0Jqrn2RtthQFNehy/7kNIH3b6w2GTL8qYUfhUEggZqfNhVAJ?=
 =?us-ascii?Q?cjCenA5eVD94Eqayg7HWSawYxvq2TBHdc6e2rHPVJydebBFbUH18zEThhQhJ?=
 =?us-ascii?Q?xMx1/WBVXEozVVypPWtw5qfK9USow9698Zy5d+Q6/oqxttHvDOr8Dvy1lDpu?=
 =?us-ascii?Q?CKmqH9/aF8LQ+cjTUDWWbfDgJEdcBO4PmFclqoMr7a61q5/T4K5JuxXKYd6m?=
 =?us-ascii?Q?4s65mrtE89+r8brEmx7Vm2tdquoq6wQLfeYGAO2wikP5UNb2HTNHFxhSyRc/?=
 =?us-ascii?Q?cKYosbC7ZLAdBLKEAMZGdSt/2IRZNG8OlpOvTrnHolMIwcQDuWD8iGTNXUaW?=
 =?us-ascii?Q?wx1miAVofFQ3xMRgaOILsSZH8vf/RYuPrCvi1J3o1aZSJuls8rcDZN0o/cyd?=
 =?us-ascii?Q?IjM/fdMarSm+m38uoqGOxBKsqZMMcquabbRtLXLtzHAGDJ1lzDPMVGom9x8w?=
 =?us-ascii?Q?4CyZ5KYB3IFUx9Pvj6h5wJ0/+sGZDFzzfD6vaKnOBRghq9XYxkZW40m2oem+?=
 =?us-ascii?Q?c+fTDlkRWHoygVjvUzdvsrPhKmzpOzB0umvnfFbcpNwj4iOZxrbn/jvx1s98?=
 =?us-ascii?Q?XZHqLD8D9j/jpg610WuyyxaxMuKEdchUh3mblRWsH+m93XB4JMuBtdbip56t?=
 =?us-ascii?Q?mmDFCIDSazyhgTO378yrT/aExAg6VNv18yGo85z/GTK3f86hF4hPb2FCS9E5?=
 =?us-ascii?Q?2l4YjCr5VSOkOwTx2AjT+wi+crlp+ljHO+wN135CgbkD0eM8ue95Gro9AeW8?=
 =?us-ascii?Q?DO9JH6lo36kWBjZxsOMppa1UplnhaR3kJ/OBCn+97n+ounYxjh6nbJLv/p1C?=
 =?us-ascii?Q?yqBHIFKVWJN9usxMutR+tb7jtu8lFTR6VV6PtdDlDCZJAYkFeE499jeUZOWM?=
 =?us-ascii?Q?9OeI7GtM9kQqWM53iSdFl+n9Hb73V0WS3NW2ps/EC6CdKTcVVzn8YyQBSpg2?=
 =?us-ascii?Q?83cSNYmxzQKfKd2Zmb9F6YPosJztclXHi+uOyoTm1JeGAJITx1V+0SWgWZze?=
 =?us-ascii?Q?xE8N9svbAM/t7dKks4iS7SCEkERpSnuGUoYyEZf36Wj5peQZgL223wl5UXxw?=
 =?us-ascii?Q?FRar3E6FBSVA6pssQBHiSSNPpC51joeeErwhIgBn01IKfI4R2DINndx1kS7Z?=
 =?us-ascii?Q?TRtY1zWkONxcMZmWnEbEGr+h+sNZCUoc7CuLVXqvZFq9CsdzUgq//PrCH1rI?=
 =?us-ascii?Q?QvvNB0b4L0HAAA4XlpCUfYtSYBGE1ImM?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 09:37:50.0306
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2207e16-68db-4b0d-eb7f-08dcc67beac0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7715

Incorporate a mechanism within the context switching code to reset
the hardware history for AMD processors. Specifically, when a task
is switched in, the class ID was read and reset the hardware workload
classification history of CPU firmware and then it start to trigger
workload classification for the next running thread.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 arch/x86/include/asm/hreset.h |  6 ++++++
 arch/x86/kernel/cpu/common.c  | 18 ++++++++++++++++++
 arch/x86/kernel/process_32.c  |  3 +++
 arch/x86/kernel/process_64.c  |  3 +++
 4 files changed, 30 insertions(+)
 create mode 100644 arch/x86/include/asm/hreset.h

diff --git a/arch/x86/include/asm/hreset.h b/arch/x86/include/asm/hreset.h
new file mode 100644
index 000000000000..ae1f72602bbd
--- /dev/null
+++ b/arch/x86/include/asm/hreset.h
@@ -0,0 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_HRESET_H
+
+void reset_hardware_history_hetero(void);
+
+#endif /* _ASM_X86_HRESET_H */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index d4e539d4e158..2ef34669fcb6 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -57,6 +57,7 @@
 #include <asm/mce.h>
 #include <asm/msr.h>
 #include <asm/cacheinfo.h>
+#include <asm/hreset.h>
 #include <asm/memtype.h>
 #include <asm/microcode.h>
 #include <asm/intel-family.h>
@@ -398,6 +399,14 @@ static __always_inline void setup_umip(struct cpuinfo_x86 *c)
 	cr4_clear_bits(X86_CR4_UMIP);
 }
 
+static u32 hardware_history_features __ro_after_init;
+
+static __always_inline void setup_hreset(struct cpuinfo_x86 *c)
+{
+	if (cpu_feature_enabled(X86_FEATURE_WORKLOAD_CLASS))
+		hardware_history_features = 1;
+}
+
 /* These bits should not change their value after CPU init is finished. */
 static const unsigned long cr4_pinned_mask = X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_UMIP |
 					     X86_CR4_FSGSBASE | X86_CR4_CET | X86_CR4_FRED;
@@ -1839,6 +1848,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	setup_smep(c);
 	setup_smap(c);
 	setup_umip(c);
+	setup_hreset(c);
 
 	/* Enable FSGSBASE instructions if available. */
 	if (cpu_has(c, X86_FEATURE_FSGSBASE)) {
@@ -2392,3 +2402,11 @@ void __init arch_cpu_finalize_init(void)
 	 */
 	mem_encrypt_init();
 }
+
+__always_inline void reset_hardware_history_hetero()
+{
+	if (!hardware_history_features)
+		return;
+
+	wrmsrl(AMD_WORKLOAD_HRST, 0x1);
+}
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 0917c7f25720..6a3a1339f7a7 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -52,6 +52,7 @@
 #include <asm/switch_to.h>
 #include <asm/vm86.h>
 #include <asm/resctrl.h>
+#include <asm/hreset.h>
 #include <asm/proto.h>
 
 #include "process.h"
@@ -213,6 +214,8 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	/* Load the Intel cache allocation PQR MSR. */
 	resctrl_sched_in(next_p);
 
+	reset_hardware_history_hetero();
+
 	return prev_p;
 }
 
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 6d3d20e3e43a..096ac69bb8db 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -54,6 +54,7 @@
 #include <asm/xen/hypervisor.h>
 #include <asm/vdso.h>
 #include <asm/resctrl.h>
+#include <asm/hreset.h>
 #include <asm/unistd.h>
 #include <asm/fsgsbase.h>
 #include <asm/fred.h>
@@ -709,6 +710,8 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	/* Load the Intel cache allocation PQR MSR. */
 	resctrl_sched_in(next_p);
 
+	reset_hardware_history_hetero();
+
 	return prev_p;
 }
 
-- 
2.34.1


