Return-Path: <linux-kernel+bounces-548257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C435A5426D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 06:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB90D166C27
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 05:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A50199FC9;
	Thu,  6 Mar 2025 05:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RZ2SfdV+"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49E145C18
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 05:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741240139; cv=fail; b=Rdbnf0wSdAK9eOjT6FyVedDf17l8Y1YoOLXZbMGjJl69i89U/oXDNlVnbcVNxLh1I7ZjTxlDEH2c5z4nEnkFitJxfPAzFFBTAHJ0r34EaBxIVNXV0koQVJXvGwDdxQ7WqLvhpp7XaT/3IdKA4wxndNDanyLFJxWVuz/rAq7isHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741240139; c=relaxed/simple;
	bh=50f7EuVrkIUuMEZMbQuCwZ7HPipm02E4y904aHiW+4s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mDd+gKBR3NYd9tnFAAp+Ivu97kiw2qqyRr4gElJ86QEyp4OrY8r1nofUM7RoPGVutKH6IxvgeIhCiyfRDiYkb+IUF/SJI1u0YXdjH96NkzV0Q02gvV8QBsID3T+nHJQqpBf5d1X90aU6K3/yseJFeVt+Du/KAKYenfQ1LgaLlg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RZ2SfdV+; arc=fail smtp.client-ip=40.107.92.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xCT1GsWWk34tpTfQQgf99NKvnmJsM1si86SaFIrgv8Y2smkBcqLc62yi7t2ITDkIPunXJ34QPJMC90xER8xRk9rxcZ9uaNHlBnMpewmx1048Bopw/ZTvJl8rt6joFWXxqcLRBs06Up+Ydms0ZyZsI7tpz2h/wQP8IOrKuKlKIFDN05xreS0muIiJVsZWDOthiBdFIjygAbvoRqIWoKZDbBaF3LPWg6REmEPkVBrPaO+94FGEMQiNJEMuH9L9yGeaQleEcGau7hEanMAq/4UZ+zZJum8GDqPvxfepAycqBx7LZJ56t8Qf8Ix93Sbd/6vAfQ2unAFblVxPq6zmoK3LVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0Ndj2upTDNcAeObFctsa70itOmQpn0tcJK4ZgSMTeY=;
 b=kV8QeVFjJqMN80tlWEUkjnnJ99WrfPUyR/SH9ANop8Mi8TJGCcVW0o9kmCgSVQvoGhByek6Aavb+H0uNnBvpSRGe14Agz/tOMIxRyJZs9fRVQ1Jxt2PJfscyM2JLDUV2F5N1AvvBpNKcyManFRa4eYxQyD7aw75enx5A/+lIQitEd6TgkPTIVdr1V+S3FKM/8ng6KcU5JiFIjoq53NRQBm0RwSqq25b+Bs3j8NeuR/FgdSiv8zsSGKCShN7zzmmZ4c++9pSxMudO8ZlWLyTa4FaY8GQTeKLyzx+LPIYGc3v84wUcraE4SGgyqvooZyvS6RP8VUAOeW0s4dXv1KmNBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0Ndj2upTDNcAeObFctsa70itOmQpn0tcJK4ZgSMTeY=;
 b=RZ2SfdV+Cp5+1NsYwlEWFZZwV07QHda3XVkOGEo55xXjFPKwDCmgENZ6LcYAU4TxMx/EyKoayPZRoDAgaV/Q0KJQE91Y9m/La6PyftjosKm6JdQeWq0Y6xgfj74h76UCdzZXrZ5FRi04Y1gNTIl5YDMr0m3kc3jDKiRFS3CRLco=
Received: from BN0PR04CA0113.namprd04.prod.outlook.com (2603:10b6:408:ec::28)
 by PH7PR12MB8106.namprd12.prod.outlook.com (2603:10b6:510:2ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 05:48:52 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:408:ec:cafe::9a) by BN0PR04CA0113.outlook.office365.com
 (2603:10b6:408:ec::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.17 via Frontend Transport; Thu,
 6 Mar 2025 05:48:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 05:48:52 +0000
Received: from BLR-L-BHARARAO.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 23:48:41 -0600
From: Bharata B Rao <bharata@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC: <AneeshKumar.KizhakeVeetil@arm.com>, <Hasan.Maruf@amd.com>,
	<Jonathan.Cameron@huawei.com>, <Michael.Day@amd.com>,
	<akpm@linux-foundation.org>, <dave.hansen@intel.com>, <david@redhat.com>,
	<feng.tang@intel.com>, <gourry@gourry.net>, <hannes@cmpxchg.org>,
	<honggyu.kim@sk.com>, <hughd@google.com>, <jhubbard@nvidia.com>,
	<k.shutemov@gmail.com>, <kbusch@meta.com>, <kmanaouil.dev@gmail.com>,
	<leesuyeon0506@gmail.com>, <leillc@google.com>, <liam.howlett@oracle.com>,
	<mgorman@techsingularity.net>, <mingo@redhat.com>, <nadav.amit@gmail.com>,
	<nphamcs@gmail.com>, <peterz@infradead.org>, <raghavendra.kt@amd.com>,
	<riel@surriel.com>, <rientjes@google.com>, <rppt@kernel.org>,
	<shivankg@amd.com>, <shy828301@gmail.com>, <sj@kernel.org>, <vbabka@suse.cz>,
	<weixugc@google.com>, <willy@infradead.org>, <ying.huang@linux.alibaba.com>,
	<ziy@nvidia.com>, <dave@stgolabs.net>, <yuanchu@google.com>,
	<hyeonggon.yoo@sk.com>, Bharata B Rao <bharata@amd.com>
Subject: [RFC PATCH 4/4] x86: ibs: Enable IBS profiling for memory accesses
Date: Thu, 6 Mar 2025 11:15:32 +0530
Message-ID: <20250306054532.221138-5-bharata@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306054532.221138-1-bharata@amd.com>
References: <20250306054532.221138-1-bharata@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|PH7PR12MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: d29b96e1-9abc-4b22-afb6-08dd5c72934c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5U+1RGArTFxV6bVbuT4JAc6TWwHesgkeMv6dYtuNWUXCRuKJlunwuVZGrPX6?=
 =?us-ascii?Q?wQWlhI8n0Jj6+/axbSCZUGVO5VRwAj8150wBYW6yV1zXWQlLEZ40ll6PzHxH?=
 =?us-ascii?Q?dUr67czReJGi3LORUPA+A4XUF3KpIizOdroxlN0y8tpk9jwqjqAvdKEdDV2r?=
 =?us-ascii?Q?osca6K61cdxd9ExAin4tGYLOuC35trn9sARUY5XN3Ixu+Nat6Gl4DwFAY6Rs?=
 =?us-ascii?Q?Po1ZsUAeM9tOUpZsz7OeHDxCOWcpn4LRy/l6QzPZXNdG72RBbMrl/y+Rp8ZN?=
 =?us-ascii?Q?UY5YAD3r4X5dnVInn5ngjkE8lm29PEmLSNK7gMNJClFDpiGcnWcu+3n0RPTB?=
 =?us-ascii?Q?Tp34bqQx2Be3CmanTfC+Sx78pvGkQHVOAsQgD9Po7c+eAp3XrWJjYAHnAyJ9?=
 =?us-ascii?Q?HPObnsVVgWFMdXEtedJNkfuSJ0N3GXN5vu2E3PbTLGlP6LPIX7z2bu5Bqp/y?=
 =?us-ascii?Q?xsiA8kXow9JtTuRYfiB4i3gwbnWOZD/H2ZPvCRV58i0BgOTr+hcyI2k3mHkC?=
 =?us-ascii?Q?TrpkEw8p1GPW0Z949tB9fZX5WxCFK3RlF45GwYIKwjbU7q9ieBi48cnfKPSD?=
 =?us-ascii?Q?g3Gkin7sAR+jtliTUnuvq3789F7P14Z9k1hYBVjkgTqefn6MXZjAwEoWKTel?=
 =?us-ascii?Q?qsxKmIv3y3p+ytiu2G9TbkbStZyZb9C5gIBi1B9jM4XwWF34jjchtRGx3c5H?=
 =?us-ascii?Q?pTlVYT0qsTszbj9G+tQo82pTV3xRYy+jlTB/V/VfwgmTc3w1XjHUi/wXIXj/?=
 =?us-ascii?Q?YK9pEY03eMN48SeaHWuQ+q0JwnpIR7KRwtdSHkH8SM2HR1unzw9Gt/PQHz0U?=
 =?us-ascii?Q?1+wEw+rRaeBwgV+BYRBMnn3UkQr9kd8ZFgQm1nDd4dOiP5o5HZJlbMG70mU/?=
 =?us-ascii?Q?XDmGf6MzvGJroS1DSvDb+rTuHVU6iSpIhTWIzghKPwLgvb7xG34VbylSOexv?=
 =?us-ascii?Q?B70Bo1QzqGf5Sd+Y9Nye2RGu0x55bLD02FsXJu45zz3yFdiq+adgHwnyMoPW?=
 =?us-ascii?Q?UIoJv9HFu4qcSnKyq/cowJJQJ9tC2RM6whJ4yLKnhBdVwCtDAYdD1TWYJvPP?=
 =?us-ascii?Q?gUPRXQ/q9b4zDr/mgxUKSBspzwW5f9aMco3idcwQNHdYzN7eSckiq8xAl3Lc?=
 =?us-ascii?Q?9l/gzxoYqUkfWqDtxbbaZHr9THgNO4Yp0PSEphb7pAJvz0/2U6/ij1+bW3Bc?=
 =?us-ascii?Q?wFOzj5HvCTeSQghgHN6epLIEfqXmAPeFbD/sV7+kf0X3EVokzTzD0CsVm9/H?=
 =?us-ascii?Q?pB6Do7lBdwOk2lDqkzMTQ0OleIQ80lahCqe1NoZgvshvHVMONOA1x9Xy2129?=
 =?us-ascii?Q?jHWauzxpoWn0SINuPR302aqj9bJGCCagnFHjdTCrybriLoQOaB4yAl+B/cbt?=
 =?us-ascii?Q?JcT5mnBQMykRHX+wpNVJuCDYjI8IEs07r3YZdLte9dz67a1uXMz4mvfqvPge?=
 =?us-ascii?Q?wK1zYYzPb0x1WIx/i4ZfYUfkcFnZVsU3fW9+Y5HBMGyYhxZErXZ4wElWIyRS?=
 =?us-ascii?Q?LOhYsBe/3KGrg7U=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 05:48:52.3157
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d29b96e1-9abc-4b22-afb6-08dd5c72934c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8106

Enable IBS memory access data collection for user memory
accesses by programming the required MSRs. The profiling
is turned ON only for user mode execution and turned OFF
for kernel mode execution. Profiling is explicitly disabled
for NMI handler too.

TODOs:

- IBS sampling rate is kept fixed for now.
- Arch/vendor separation/isolation of the code needs relook.

Signed-off-by: Bharata B Rao <bharata@amd.com>
---
 arch/x86/include/asm/entry-common.h |  3 +++
 arch/x86/include/asm/hardirq.h      |  2 ++
 arch/x86/include/asm/ibs.h          |  2 ++
 arch/x86/mm/ibs.c                   | 32 +++++++++++++++++++++++++++++
 4 files changed, 39 insertions(+)

diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index 77d20555e04d..8127111c6ad3 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -9,10 +9,12 @@
 #include <asm/io_bitmap.h>
 #include <asm/fpu/api.h>
 #include <asm/fred.h>
+#include <asm/ibs.h>
 
 /* Check that the stack and regs on entry from user mode are sane. */
 static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs)
 {
+	hw_access_profiling_stop();
 	if (IS_ENABLED(CONFIG_DEBUG_ENTRY)) {
 		/*
 		 * Make sure that the entry code gave us a sensible EFLAGS
@@ -98,6 +100,7 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 static __always_inline void arch_exit_to_user_mode(void)
 {
 	amd_clear_divider();
+	hw_access_profiling_start();
 }
 #define arch_exit_to_user_mode arch_exit_to_user_mode
 
diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
index 6ffa8b75f4cd..b928fbbcf3e5 100644
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -91,4 +91,6 @@ static __always_inline bool kvm_get_cpu_l1tf_flush_l1d(void)
 static __always_inline void kvm_set_cpu_l1tf_flush_l1d(void) { }
 #endif /* IS_ENABLED(CONFIG_KVM_INTEL) */
 
+#define arch_nmi_enter()	hw_access_profiling_stop()
+#define arch_nmi_exit()		hw_access_profiling_start()
 #endif /* _ASM_X86_HARDIRQ_H */
diff --git a/arch/x86/include/asm/ibs.h b/arch/x86/include/asm/ibs.h
index b5a4f2ca6330..6b480958534e 100644
--- a/arch/x86/include/asm/ibs.h
+++ b/arch/x86/include/asm/ibs.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_IBS_H
 #define _ASM_X86_IBS_H
 
+void hw_access_profiling_start(void);
+void hw_access_profiling_stop(void);
 extern bool arch_hw_access_profiling;
 
 #endif /* _ASM_X86_IBS_H */
diff --git a/arch/x86/mm/ibs.c b/arch/x86/mm/ibs.c
index 5c966050ad86..961d0c67ca50 100644
--- a/arch/x86/mm/ibs.c
+++ b/arch/x86/mm/ibs.c
@@ -15,6 +15,7 @@ bool arch_hw_access_profiling;
 static u64 ibs_config __read_mostly;
 static u32 ibs_caps;
 
+#define IBS_SAMPLE_PERIOD      10000
 #define IBS_NR_SAMPLES	50
 
 /*
@@ -99,6 +100,36 @@ static void ibs_irq_handler(struct irq_work *i)
 	schedule_work_on(smp_processor_id(), &ibs_work);
 }
 
+void hw_access_profiling_stop(void)
+{
+	u64 ops_ctl;
+
+	if (!arch_hw_access_profiling)
+		return;
+
+	rdmsrl(MSR_AMD64_IBSOPCTL, ops_ctl);
+	wrmsrl(MSR_AMD64_IBSOPCTL, ops_ctl & ~IBS_OP_ENABLE);
+}
+
+void hw_access_profiling_start(void)
+{
+	u64 config = 0;
+	unsigned int period = IBS_SAMPLE_PERIOD;
+
+	if (!arch_hw_access_profiling)
+		return;
+
+	/* Disable IBS for kernel thread */
+	if (!current->mm)
+		goto out;
+
+	config = (period >> 4)  & IBS_OP_MAX_CNT;
+	config |= (period & IBS_OP_MAX_CNT_EXT_MASK);
+	config |= ibs_config;
+out:
+	wrmsrl(MSR_AMD64_IBSOPCTL, config);
+}
+
 /*
  * IBS NMI handler: Process the memory access info reported by IBS.
  *
@@ -305,6 +336,7 @@ static int __init ibs_access_profiling_init(void)
 			  x86_amd_ibs_access_profile_startup,
 			  x86_amd_ibs_access_profile_teardown);
 
+	arch_hw_access_profiling = true;
 	pr_info("IBS setup for memory access profiling\n");
 	return 0;
 }
-- 
2.34.1


