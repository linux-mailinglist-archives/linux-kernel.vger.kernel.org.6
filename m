Return-Path: <linux-kernel+bounces-548256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC410A5426C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 06:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D266F1893EC3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 05:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CAB1990AB;
	Thu,  6 Mar 2025 05:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L6zAb5lP"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8D443166
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 05:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741240107; cv=fail; b=WTqrMsPFgOZXm+0/yzOQ7zFVEk2E7ulNodI1z45r01NKKATOywfaLT/NXA4NO6tb+u8Aqk6ZjX4NcAa8b2SzK2FYpCHmrZJqEuBOffXRZGR/iCiQnk5DR7D7sZplN74C0hId3LS4lKPZuu/ZIf7Xa6m/SkJdgWbsXC06CUr9NDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741240107; c=relaxed/simple;
	bh=rcAsL3rL7EC95QH12SWPEfab5BNAnJ5eCK6i/IgT7rE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DwilEEz+PQUUj9midbnwF05hggxn04OEHTF2quPjXYRjvdRuFa0cQpVAalsnh4ydf/plusMkzjjpw+OktTkeEEdmk0M+QcMV4k3B5S6VdZBqp0qMWD3ZdoepVy4vYYW4pAyn2BqVsZG0/An6gettjljHxJvVbANJU/iXpCQLAig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L6zAb5lP; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kieDVAnnyw/YEz71KjoqB9PMqD7cp1ANpIDoWhGTRAPoGavQgMtwNBwrt3YYDxT285AVYeCyzZZTywRn0BYa61yNoHNTfXOMsE8EQ1DLCesE2v5PY/vVj45dLjbo4h4pOCeiG7P1vC0u3PANIfvC5NXHhsh4tltBTW3WsueHHNhZrYKYNQcaTESVXzcQ3ksJtWgo4UhuF1mZJUsn/DHPsBQEwHqHdINtG6x0/DoPQ3739pyYixD76Hj1XQcf2bZhklkqMSEZO0797evpKGqnvEWuQvnwcPi9Nb3FIXBe3sSa0NYzT0rpkMlwBjGlpkIxZQtpWzF8BWgrdThEPEFB+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5juOMg1h6w8SYB34nVKzLjnpS6LJy7kqJtjxvaQIYKE=;
 b=eJKRB3R5rniazFptDF8sGsEA2zzKWSids1ERpSvpR4DdAKv7adImRiJOoNMrfy1Qo+gfOSb6ImOXw5TetO7Zd54XLrQW9ZL6xT3SO6pA8K0WRynra+bYOV9ZbYsHl9VYwut44iXLBKwNr3qZdwAykTPWppQv7zMGK83kdAP5whA2EzgTX61wHtTOYCN/BoKeOgmDNN+ewlQI1ssbxX3EVneGeuzCe03p4wt+JoOYvpnYvqfzc4MLQM1H8z+XVfWoH0dQVH51443pqeLrPMJmP9g4++VX2bMzNgiskUx5/2XxqELaJv4NqQbTIdFmHxFBIR+Dha8Ei+houJgsVKTn3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5juOMg1h6w8SYB34nVKzLjnpS6LJy7kqJtjxvaQIYKE=;
 b=L6zAb5lP0pZYS0jnFvVPsw2EnxuVLsFI5JCEDgSU7QcT9LHecRAx0wUcfUw3e0YTufTOw3NQlEQ87wV7oPxGfTZYjy2s8ow4P3+4LiPVOtPKEV83SW2f1nHZTUIPF3dl32iD9GrlbHzm0nhUo+fEheaRtWI7owOxm4y9UFgC+2A=
Received: from BN9PR03CA0198.namprd03.prod.outlook.com (2603:10b6:408:f9::23)
 by DS7PR12MB5765.namprd12.prod.outlook.com (2603:10b6:8:74::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 05:48:19 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:408:f9:cafe::a1) by BN9PR03CA0198.outlook.office365.com
 (2603:10b6:408:f9::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Thu,
 6 Mar 2025 05:48:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 05:48:18 +0000
Received: from BLR-L-BHARARAO.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 23:48:07 -0600
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
Subject: [RFC PATCH 3/4] x86: ibs: In-kernel IBS driver for memory access profiling
Date: Thu, 6 Mar 2025 11:15:31 +0530
Message-ID: <20250306054532.221138-4-bharata@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|DS7PR12MB5765:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f40f431-1813-490f-9d26-08dd5c727f57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nKxSD6bJboedXI2jBlnJp6C+CoAgPR4UhaMxs1MyUX9DxLsOdbruOGz5vOHK?=
 =?us-ascii?Q?SuTNPIuezT1WYdwT2Ka1W2MTM5zI+6iAmbH7CPchw+znPRxUT43CJBbtx5o8?=
 =?us-ascii?Q?DsefkNsGdmTSS0fUMq7oQ60XexlyE9W1rKHwRTLslasWcSGL8cfCbz+f4QHh?=
 =?us-ascii?Q?Xd3L8qkQRUioJ/09zSjESyGrSxmMov7BL4O5/8bz++rhPQ2C8PMRTynwF5CA?=
 =?us-ascii?Q?W1bHqnJNEOMiUwoscPwOqsv7EiYtkuxoOZqxc4XmV4dz2QjVlDqHIZMsH3wJ?=
 =?us-ascii?Q?jT5UzMCFrJkOgWgH1WuWv/SzcqpPIpmxfgmQVu6ZXeXKCFrrAn7EVZE0amHF?=
 =?us-ascii?Q?jPRr/LtFlSE5prYJRD8AVzOyHwumli1pHieREnqEMA02W/LdT6kuw3SuVrza?=
 =?us-ascii?Q?epSiAgadkeDZu0qiGlE2HESb6K0ZwF1Y9RC3RoncxCelamvOdINWrZX6xD3Y?=
 =?us-ascii?Q?9NSynfts8Yg08JzrwQk5CNAKhoMsaQ2IHzp84lIuEOq7gvxtzUydSbKpVCKj?=
 =?us-ascii?Q?QiNgSfC48almNnEvPZoUKLZn7WSI3H4Qw+9PXaD0tFL7ncYotj3FlwRbvb5T?=
 =?us-ascii?Q?HcAhxfmiH/02fpoPgtsm5GYQYeUUABiRfQEMDvnHPOPF9im6TDjfLHSfnjcy?=
 =?us-ascii?Q?REUl126XHlEXp7B6+zD5x10+vt5gIQ7WiUN0iBECcdg7dfMDdqnMlYmulpA4?=
 =?us-ascii?Q?GYsT3w13SdbJNdo7adMchx55YUB+9LCDyit1cFOStzgFxIW1Tyiri37CgJkE?=
 =?us-ascii?Q?wydWii3L8EyA6He7q+Pax+j3WVVCHwEVu9apsXlrku1T8UwTc51BvuIB3k05?=
 =?us-ascii?Q?FdD/oidhwGfMbmHClZI+kDRE/TkpMG3Ac8aLfBd84vetiRi12l4FeMTHbYDu?=
 =?us-ascii?Q?Wo7h6Kt/W8xSJFUCtwd9yaYQTTNTqm/9Pq18gzM/AjZI1zRGTT6BVNbXwtuF?=
 =?us-ascii?Q?+jOjCszctjlLAatKftOt05RDrfkV5jvAU2Wf2TQbd98BZUbzuSWsjajaoI8R?=
 =?us-ascii?Q?9AAgVTP1WTqNGuhXXjTh4lTkvYGDRQIS8dzfW+nRSfe6+vvJ1o9KiYbXLuv6?=
 =?us-ascii?Q?BHvYAoX0uAahxsc1Uvj6e95Noj6gmlxPMdaK3wQP1KLqnZQai9Q2NS0k4Yx3?=
 =?us-ascii?Q?lG48jY5ZhrhBWV9CxfSdPS/8a9ry1QtBdbozg5DagFpWK9r9u3aHEKRKfVqE?=
 =?us-ascii?Q?mdNgannpWg0rZ+UUixJ/0iPTieK4INXuSmdgr/zPeQyLDq1ZzMoMr1lQJ5/7?=
 =?us-ascii?Q?p41tweC7SrZtXdbVpeY8yeo3FMGuryjNfloXNZxr5JxchCXT45SoI18MuMx+?=
 =?us-ascii?Q?1PMhjnlTv1WE0Vy0udqKgmw3jZj/XVAj0tpEGl/YTxtCEGZU7ocGLHxRNl7P?=
 =?us-ascii?Q?Iew9ejrn/12Qk0KmAGYwJfzhMyAbtgIdTkNttFpcyplkAICgVmbrF/o8VQnT?=
 =?us-ascii?Q?6JwqSPTd0AYv7S0eJFL87XFrTR0+HPJY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 05:48:18.8485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f40f431-1813-490f-9d26-08dd5c727f57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5765

Use IBS (Instruction Based Sampling) feature present
in AMD processors for memory access tracking. The access
information obtained from IBS via NMI is fed to kpromoted
daemon for futher action.

In addition to many other information related to the memory
access, IBS provides physical (and virtual) address of the access
and indicates if the access came from slower tier. Only memory
accesses originating from slower tiers are further acted upon
by this driver.

The samples are initially accumulated in percpu buffers which
are flushed to kpromoted using irq_work.

About IBS
---------
IBS can be programmed to provide data about instruction
execution periodically. This is done by programming a desired
sample count (number of ops) in a control register. When the
programmed number of ops are dispatched, a micro-op gets tagged,
various information about the tagged micro-op's execution is
populated in IBS execution MSRs and an interrupt is raised.
While IBS provides a lot of data for each sample, for the
purpose of  memory access profiling, we are interested in
linear and physical address of the memory access that reached
DRAM. Recent AMD processors provide further filtering where
it is possible to limit the sampling to those ops that had
an L3 miss which greately reduces the non-useful samples.

While IBS provides capability to sample instruction fetch
and execution, only IBS execution sampling is used here
to collect data about memory accesses that occur during
the instruction execution.

More information about IBS is available in Sec 13.3 of
AMD64 Architecture Programmer's Manual, Volume 2:System
Programming which is present at:
https://bugzilla.kernel.org/attachment.cgi?id=288923

Information about MSRs used for programming IBS can be
found in Sec 2.1.14.4 of PPR Vol 1 for AMD Family 19h
Model 11h B1 which is currently present at:
https://www.amd.com/system/files/TechDocs/55901_0.25.zip

Signed-off-by: Bharata B Rao <bharata@amd.com>
---
 arch/x86/events/amd/ibs.c        |  11 ++
 arch/x86/include/asm/ibs.h       |   7 +
 arch/x86/include/asm/msr-index.h |  16 ++
 arch/x86/mm/Makefile             |   3 +-
 arch/x86/mm/ibs.c                | 312 +++++++++++++++++++++++++++++++
 include/linux/vm_event_item.h    |  17 ++
 mm/vmstat.c                      |  17 ++
 7 files changed, 382 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/include/asm/ibs.h
 create mode 100644 arch/x86/mm/ibs.c

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index e7a8b8758e08..35497e8c0846 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -13,8 +13,10 @@
 #include <linux/ptrace.h>
 #include <linux/syscore_ops.h>
 #include <linux/sched/clock.h>
+#include <linux/kpromoted.h>
 
 #include <asm/apic.h>
+#include <asm/ibs.h>
 
 #include "../perf_event.h"
 
@@ -1539,6 +1541,15 @@ static __init int amd_ibs_init(void)
 {
 	u32 caps;
 
+	/*
+	 * TODO: Find a clean way to disable perf IBS so that IBS
+	 * can be used for memory access profiling.
+	 */
+	if (arch_hw_access_profiling) {
+		pr_info("IBS isn't available for perf use\n");
+		return 0;
+	}
+
 	caps = __get_ibs_caps();
 	if (!caps)
 		return -ENODEV;	/* ibs not supported by the cpu */
diff --git a/arch/x86/include/asm/ibs.h b/arch/x86/include/asm/ibs.h
new file mode 100644
index 000000000000..b5a4f2ca6330
--- /dev/null
+++ b/arch/x86/include/asm/ibs.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_IBS_H
+#define _ASM_X86_IBS_H
+
+extern bool arch_hw_access_profiling;
+
+#endif /* _ASM_X86_IBS_H */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 72765b2fe0d8..12291e362b01 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -719,6 +719,22 @@
 /* AMD Last Branch Record MSRs */
 #define MSR_AMD64_LBR_SELECT			0xc000010e
 
+/* AMD IBS MSR bits */
+#define MSR_AMD64_IBSOPDATA2_DATASRC			0x7
+#define MSR_AMD64_IBSOPDATA2_DATASRC_LCL_CACHE		0x1
+#define MSR_AMD64_IBSOPDATA2_DATASRC_PEER_CACHE_NEAR	0x2
+#define MSR_AMD64_IBSOPDATA2_DATASRC_DRAM		0x3
+#define MSR_AMD64_IBSOPDATA2_DATASRC_FAR_CCX_CACHE	0x5
+#define MSR_AMD64_IBSOPDATA2_DATASRC_EXT_MEM		0x8
+#define	MSR_AMD64_IBSOPDATA2_RMTNODE			0x10
+
+#define MSR_AMD64_IBSOPDATA3_LDOP		BIT_ULL(0)
+#define MSR_AMD64_IBSOPDATA3_STOP		BIT_ULL(1)
+#define MSR_AMD64_IBSOPDATA3_DCMISS		BIT_ULL(7)
+#define MSR_AMD64_IBSOPDATA3_LADDR_VALID	BIT_ULL(17)
+#define MSR_AMD64_IBSOPDATA3_PADDR_VALID	BIT_ULL(18)
+#define MSR_AMD64_IBSOPDATA3_L2MISS		BIT_ULL(20)
+
 /* Zen4 */
 #define MSR_ZEN4_BP_CFG                 0xc001102e
 #define MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT 5
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 690fbf48e853..3b1a5dbbac64 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -26,7 +26,8 @@ CFLAGS_REMOVE_pgprot.o			= -pg
 endif
 
 obj-y				:=  init.o init_$(BITS).o fault.o ioremap.o extable.o mmap.o \
-				    pgtable.o physaddr.o tlb.o cpu_entry_area.o maccess.o pgprot.o
+				    pgtable.o physaddr.o tlb.o cpu_entry_area.o maccess.o pgprot.o \
+				    ibs.o
 
 obj-y				+= pat/
 
diff --git a/arch/x86/mm/ibs.c b/arch/x86/mm/ibs.c
new file mode 100644
index 000000000000..5c966050ad86
--- /dev/null
+++ b/arch/x86/mm/ibs.c
@@ -0,0 +1,312 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/init.h>
+#include <linux/kpromoted.h>
+#include <linux/percpu.h>
+#include <linux/workqueue.h>
+#include <linux/irq_work.h>
+
+#include <asm/nmi.h>
+#include <asm/perf_event.h> /* TODO: Move defns like IBS_OP_ENABLE into non-perf header */
+#include <asm/apic.h>
+#include <asm/ibs.h>
+
+bool arch_hw_access_profiling;
+static u64 ibs_config __read_mostly;
+static u32 ibs_caps;
+
+#define IBS_NR_SAMPLES	50
+
+/*
+ * Basic access info captured for each memory access.
+ */
+struct ibs_sample {
+	unsigned long pfn;
+	unsigned long time;	/* jiffies when accessed */
+	int nid;		/* Accessing node ID, if known */
+};
+
+/*
+ * Percpu buffer of access samples. Samples are accumulated here
+ * before pushing them to kpromoted for further action.
+ */
+struct ibs_sample_pcpu {
+	struct ibs_sample samples[IBS_NR_SAMPLES];
+	int head, tail;
+};
+
+struct ibs_sample_pcpu __percpu *ibs_s;
+
+/*
+ * The workqueue for pushing the percpu access samples to kpromoted.
+ */
+static struct work_struct ibs_work;
+static struct irq_work ibs_irq_work;
+
+/*
+ * Record the IBS-reported access sample in percpu buffer.
+ * Called from IBS NMI handler.
+ */
+static int ibs_push_sample(unsigned long pfn, int nid, unsigned long time)
+{
+	struct ibs_sample_pcpu *ibs_pcpu = raw_cpu_ptr(ibs_s);
+	int next = ibs_pcpu->head + 1;
+
+	if (next >= IBS_NR_SAMPLES)
+		next = 0;
+
+	if (next == ibs_pcpu->tail)
+		return 0;
+
+	ibs_pcpu->samples[ibs_pcpu->head].pfn = pfn;
+	ibs_pcpu->samples[ibs_pcpu->head].time = time;
+	ibs_pcpu->head = next;
+	return 1;
+}
+
+static int ibs_pop_sample(struct ibs_sample *s)
+{
+	struct ibs_sample_pcpu *ibs_pcpu = raw_cpu_ptr(ibs_s);
+
+	int next = ibs_pcpu->tail + 1;
+
+	if (ibs_pcpu->head == ibs_pcpu->tail)
+		return 0;
+
+	if (next >= IBS_NR_SAMPLES)
+		next = 0;
+
+	*s = ibs_pcpu->samples[ibs_pcpu->tail];
+	ibs_pcpu->tail = next;
+	return 1;
+}
+
+/*
+ * Remove access samples from percpu buffer and send them
+ * to kpromoted for further action.
+ */
+static void ibs_work_handler(struct work_struct *work)
+{
+	struct ibs_sample s;
+
+	while (ibs_pop_sample(&s))
+		kpromoted_record_access(s.pfn, s.nid, KPROMOTED_HW_HINTS,
+					s.time);
+}
+
+static void ibs_irq_handler(struct irq_work *i)
+{
+	schedule_work_on(smp_processor_id(), &ibs_work);
+}
+
+/*
+ * IBS NMI handler: Process the memory access info reported by IBS.
+ *
+ * Reads the MSRs to collect all the information about the reported
+ * memory access, validates the access, stores the valid sample and
+ * schedules the work on this CPU to further process the sample.
+ */
+static int ibs_overflow_handler(unsigned int cmd, struct pt_regs *regs)
+{
+	struct mm_struct *mm = current->mm;
+	u64 ops_ctl, ops_data3, ops_data2;
+	u64 laddr = -1, paddr = -1;
+	u64 data_src, rmt_node;
+	struct page *page;
+	unsigned long pfn;
+
+	rdmsrl(MSR_AMD64_IBSOPCTL, ops_ctl);
+
+	/*
+	 * When IBS sampling period is reprogrammed via read-modify-update
+	 * of MSR_AMD64_IBSOPCTL, overflow NMIs could be generated with
+	 * IBS_OP_ENABLE not set. For such cases, return as HANDLED.
+	 *
+	 * With this, the handler will say "handled" for all NMIs that
+	 * aren't related to this NMI.  This stems from the limitation of
+	 * having both status and control bits in one MSR.
+	 */
+	if (!(ops_ctl & IBS_OP_VAL))
+		goto handled;
+
+	wrmsrl(MSR_AMD64_IBSOPCTL, ops_ctl & ~IBS_OP_VAL);
+
+	count_vm_event(HWHINT_NR_EVENTS);
+
+	if (!user_mode(regs)) {
+		count_vm_event(HWHINT_KERNEL);
+		goto handled;
+	}
+
+	if (!mm) {
+		count_vm_event(HWHINT_KTHREAD);
+		goto handled;
+	}
+
+	rdmsrl(MSR_AMD64_IBSOPDATA3, ops_data3);
+
+	/* Load/Store ops only */
+	/* TODO: DataSrc isn't valid for stores, so filter out stores? */
+	if (!(ops_data3 & (MSR_AMD64_IBSOPDATA3_LDOP |
+			   MSR_AMD64_IBSOPDATA3_STOP))) {
+		count_vm_event(HWHINT_NON_LOAD_STORES);
+		goto handled;
+	}
+
+	/* Discard the sample if it was L1 or L2 hit */
+	if (!(ops_data3 & (MSR_AMD64_IBSOPDATA3_DCMISS |
+			   MSR_AMD64_IBSOPDATA3_L2MISS))) {
+		count_vm_event(HWHINT_DC_L2_HITS);
+		goto handled;
+	}
+
+	rdmsrl(MSR_AMD64_IBSOPDATA2, ops_data2);
+	data_src = ops_data2 & MSR_AMD64_IBSOPDATA2_DATASRC;
+	if (ibs_caps & IBS_CAPS_ZEN4)
+		data_src |= ((ops_data2 & 0xC0) >> 3);
+
+	switch (data_src) {
+	case MSR_AMD64_IBSOPDATA2_DATASRC_LCL_CACHE:
+		count_vm_event(HWHINT_LOCAL_L3L1L2);
+		break;
+	case MSR_AMD64_IBSOPDATA2_DATASRC_PEER_CACHE_NEAR:
+		count_vm_event(HWHINT_LOCAL_PEER_CACHE_NEAR);
+		break;
+	case MSR_AMD64_IBSOPDATA2_DATASRC_DRAM:
+		count_vm_event(HWHINT_DRAM_ACCESSES);
+		break;
+	case MSR_AMD64_IBSOPDATA2_DATASRC_EXT_MEM:
+		count_vm_event(HWHINT_CXL_ACCESSES);
+		break;
+	case MSR_AMD64_IBSOPDATA2_DATASRC_FAR_CCX_CACHE:
+		count_vm_event(HWHINT_FAR_CACHE_HITS);
+		break;
+	}
+
+	rmt_node = ops_data2 & MSR_AMD64_IBSOPDATA2_RMTNODE;
+	if (rmt_node)
+		count_vm_event(HWHINT_REMOTE_NODE);
+
+	/* Is linear addr valid? */
+	if (ops_data3 & MSR_AMD64_IBSOPDATA3_LADDR_VALID)
+		rdmsrl(MSR_AMD64_IBSDCLINAD, laddr);
+	else {
+		count_vm_event(HWHINT_LADDR_INVALID);
+		goto handled;
+	}
+
+	/* Discard kernel address accesses */
+	if (laddr & (1UL << 63)) {
+		count_vm_event(HWHINT_KERNEL_ADDR);
+		goto handled;
+	}
+
+	/* Is phys addr valid? */
+	if (ops_data3 & MSR_AMD64_IBSOPDATA3_PADDR_VALID)
+		rdmsrl(MSR_AMD64_IBSDCPHYSAD, paddr);
+	else {
+		count_vm_event(HWHINT_PADDR_INVALID);
+		goto handled;
+	}
+
+	pfn = PHYS_PFN(paddr);
+	page = pfn_to_online_page(pfn);
+	if (!page)
+		goto handled;
+
+	if (!PageLRU(page)) {
+		count_vm_event(HWHINT_NON_LRU);
+		goto handled;
+	}
+
+	if (!ibs_push_sample(pfn, numa_node_id(), jiffies)) {
+		count_vm_event(HWHINT_BUFFER_FULL);
+		goto handled;
+	}
+
+	irq_work_queue(&ibs_irq_work);
+	count_vm_event(HWHINT_USEFUL_SAMPLES);
+
+handled:
+	return NMI_HANDLED;
+}
+
+static inline int get_ibs_lvt_offset(void)
+{
+	u64 val;
+
+	rdmsrl(MSR_AMD64_IBSCTL, val);
+	if (!(val & IBSCTL_LVT_OFFSET_VALID))
+		return -EINVAL;
+
+	return val & IBSCTL_LVT_OFFSET_MASK;
+}
+
+static void setup_APIC_ibs(void)
+{
+	int offset;
+
+	offset = get_ibs_lvt_offset();
+	if (offset < 0)
+		goto failed;
+
+	if (!setup_APIC_eilvt(offset, 0, APIC_EILVT_MSG_NMI, 0))
+		return;
+failed:
+	pr_warn("IBS APIC setup failed on cpu #%d\n",
+		smp_processor_id());
+}
+
+static void clear_APIC_ibs(void)
+{
+	int offset;
+
+	offset = get_ibs_lvt_offset();
+	if (offset >= 0)
+		setup_APIC_eilvt(offset, 0, APIC_EILVT_MSG_FIX, 1);
+}
+
+static int x86_amd_ibs_access_profile_startup(unsigned int cpu)
+{
+	setup_APIC_ibs();
+	return 0;
+}
+
+static int x86_amd_ibs_access_profile_teardown(unsigned int cpu)
+{
+	clear_APIC_ibs();
+	return 0;
+}
+
+static int __init ibs_access_profiling_init(void)
+{
+	if (!boot_cpu_has(X86_FEATURE_IBS)) {
+		pr_info("IBS capability is unavailable for access profiling\n");
+		return 0;
+	}
+
+	ibs_s = alloc_percpu_gfp(struct ibs_sample_pcpu, __GFP_ZERO);
+	if (!ibs_s)
+		return 0;
+
+	INIT_WORK(&ibs_work, ibs_work_handler);
+	init_irq_work(&ibs_irq_work, ibs_irq_handler);
+
+	/* Uses IBS Op sampling */
+	ibs_config = IBS_OP_CNT_CTL | IBS_OP_ENABLE;
+	ibs_caps = cpuid_eax(IBS_CPUID_FEATURES);
+	if (ibs_caps & IBS_CAPS_ZEN4)
+		ibs_config |= IBS_OP_L3MISSONLY;
+
+	register_nmi_handler(NMI_LOCAL, ibs_overflow_handler, 0, "ibs");
+
+	cpuhp_setup_state(CPUHP_AP_PERF_X86_AMD_IBS_STARTING,
+			  "x86/amd/ibs_access_profile:starting",
+			  x86_amd_ibs_access_profile_startup,
+			  x86_amd_ibs_access_profile_teardown);
+
+	pr_info("IBS setup for memory access profiling\n");
+	return 0;
+}
+
+arch_initcall(ibs_access_profiling_init);
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index b5823b037883..24279c46054c 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -195,6 +195,23 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		KPROMOTED_MIG_CANDIDATE,
 		KPROMOTED_MIG_PROMOTED,
 		KPROMOTED_MIG_DROPPED,
+		HWHINT_NR_EVENTS,
+		HWHINT_KERNEL,
+		HWHINT_KTHREAD,
+		HWHINT_NON_LOAD_STORES,
+		HWHINT_DC_L2_HITS,
+		HWHINT_LOCAL_L3L1L2,
+		HWHINT_LOCAL_PEER_CACHE_NEAR,
+		HWHINT_FAR_CACHE_HITS,
+		HWHINT_DRAM_ACCESSES,
+		HWHINT_CXL_ACCESSES,
+		HWHINT_REMOTE_NODE,
+		HWHINT_LADDR_INVALID,
+		HWHINT_KERNEL_ADDR,
+		HWHINT_PADDR_INVALID,
+		HWHINT_NON_LRU,
+		HWHINT_BUFFER_FULL,
+		HWHINT_USEFUL_SAMPLES,
 		NR_VM_EVENT_ITEMS
 };
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 618f44bae5c8..a21d3118d6f6 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1479,6 +1479,23 @@ const char * const vmstat_text[] = {
 	"kpromoted_mig_candidate",
 	"kpromoted_mig_promoted",
 	"kpromoted_mig_dropped",
+	"hwhint_nr_events",
+	"hwhint_kernel",
+	"hwhint_kthread",
+	"hwhint_non_load_stores",
+	"hwhint_dc_l2_hits",
+	"hwhint_local_l3l1l2",
+	"hwhint_local_peer_cache_near",
+	"hwhint_far_cache_hits",
+	"hwhint_dram_accesses",
+	"hwhint_cxl_accesses",
+	"hwhint_remote_node",
+	"hwhint_invalid_laddr",
+	"hwhint_kernel_addr",
+	"hwhint_invalid_paddr",
+	"hwhint_non_lru",
+	"hwhint_buffer_full",
+	"hwhint_useful_samples",
 #endif /* CONFIG_VM_EVENT_COUNTERS || CONFIG_MEMCG */
 };
 #endif /* CONFIG_PROC_FS || CONFIG_SYSFS || CONFIG_NUMA || CONFIG_MEMCG */
-- 
2.34.1


