Return-Path: <linux-kernel+bounces-548254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40222A54268
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 06:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 660AB1893C9F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 05:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A16919924D;
	Thu,  6 Mar 2025 05:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dOabVrly"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDB7A94F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 05:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741240077; cv=fail; b=XNgtDCFq2IogUfkuTNXCoQvBw6EQYldbZpqf0QWtN4gI5aCXZj7Ie4AXCeqMESAIAY0drZw+oeN2ANTDCJQTcl9WcCRxtbCQV1MnI5wARpI0BXPZOdnDTMx4/rpLIR6YrXTot3n56r4GKuvB0g+EBByErgfnlBC/nqVs6KJWWBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741240077; c=relaxed/simple;
	bh=ZcjF4HXtag9/HZvlTGLQ5AyuMdb9QCIoFmNOAB+yFus=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KWbD3De1AqTP/FuIABUJ3UsyLfyLFZZHUKceogaqAe7icDP6gv7fba+69sShsZzAKS6zhpyyfv5PHAMav35rmkGrYao/RQ56hTgKPZlX1gHt9WDjtaKng4o9vUvC1c6b2Arr6aDGDUKZmg9w0aOEVgbWwbGV1jgyhUiNZgppWno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dOabVrly; arc=fail smtp.client-ip=40.107.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X66Ih8nAJHTbQiaZ8BS+CSERp5KEgTdbw0j3w+6asauWc/uu/q2kirkr7caTDpUMHPi6sBsKZqk8dOUU6NwPICE0nJgoQalFhEQ2I0GVXWtWHqSUMlZ1tbv5ehoR5AuqSLv5+GGOJm9OMgBXVkXF5ZAzkm+iMzNYnl7n/H5pOkDbJkhSag6Of/ERJSm9523vympQdjrLpEVSd1bOFLz3dmi4gDlpuTXhldJvL6udKjEfsKmt/LVWHBOraN0meelyER+6elay92eIqemesFRRkL47cSY8tjyLiq7gDLdoVgm8DrBDYzlnheuvxq5aMeuFC9Xdp/J7zgCCu3u5nacsJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7TvrwplZzQShquHVeI1Ot4r7G3WbzWt6WnN16CBkVw=;
 b=mjJwzpza0LL7IJmP0iKnjKZaTWcLYxNnAFYutH9tA+xPptjLx3D95BeMmb3XuSc2eYbv7QCAM1yce8bwzoC2ulxTyxTqCRhT53bkBp0KPPE1dLoCr5O9AqW4ak0cnNWLgMlD+1jgM9FkMvK+Mk8lqU80E3iBYo4oSgu4upaItgdTjR8P5aKcAaR2ZMk/TzMg0iT/iVNCt8qVORKhgHWuFacQ5bEADg5p0MU35LXwTbpt/cf9Thn78P3zmzQtYVcmZKWbDpZsrU1ngfMxevAlUwtmkWFTMTFgsvIbV1FYf2jJx+MESpzfYBKLPVnvOL3k8RYoSEr+VS+lVJiKo8wElQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7TvrwplZzQShquHVeI1Ot4r7G3WbzWt6WnN16CBkVw=;
 b=dOabVrly3Ag5+998i+HaBbiOaWfi+gYdr2z932Kdf65NkMjp+mMKU/CDeb6utc1rlbgSm1qeySeqdDI7/54mc2z2/frPd6l0tPk3pM2gV+o5nE5Tgtw/wscImaaArpKb6US/6A/5QKCqcVHW1cA0k0w61rfzjSsuCNXorc0mArY=
Received: from BN0PR04CA0148.namprd04.prod.outlook.com (2603:10b6:408:ed::33)
 by SJ2PR12MB9086.namprd12.prod.outlook.com (2603:10b6:a03:55f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 05:47:51 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:408:ed:cafe::82) by BN0PR04CA0148.outlook.office365.com
 (2603:10b6:408:ed::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Thu,
 6 Mar 2025 05:47:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 05:47:50 +0000
Received: from BLR-L-BHARARAO.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 23:47:39 -0600
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
Subject: [RFC PATCH 2/4] mm: kpromoted: Hot page info collection and promotion daemon
Date: Thu, 6 Mar 2025 11:15:30 +0530
Message-ID: <20250306054532.221138-3-bharata@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|SJ2PR12MB9086:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f4d5aa1-d7c6-47df-6753-08dd5c726ea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gw28esoDq6GcKpFuFQUQr/AHda2qIh2uVIf+PaK9Etud3PbieELC/9QY2+78?=
 =?us-ascii?Q?hR+LoIKDIEUcPZ5h6uTYLv6KNkn+EyTXj9EzBEOmJvk29t5rl4b0DkSBEPfG?=
 =?us-ascii?Q?h4yK+9hdjoeWmW2eGf96eIgN8wJ614VPDWVthf67nvqqcFphHHJQhLxDSG9D?=
 =?us-ascii?Q?Ut0Igon+0qkA7X12FLn6sO79iycHcNeWfjja4a3J+OZdZwH+3+mImOy5O7K4?=
 =?us-ascii?Q?2zaeedK6rjGMRRFtfsCYjawBR/ZydvA2HNtRV/l5QNfFrt5V5/aX1v5lNFyJ?=
 =?us-ascii?Q?E7GNk0Djfepd7cN11MO5dhKe2Dhj6Rq8q8qmJeNivb8TjnxfSexYJ3bqjjrA?=
 =?us-ascii?Q?o0IjtTdIFfwVjir4osWgBW6YTBO422k1isRlBrKbG0KiVaMt5OBk6KSTLw63?=
 =?us-ascii?Q?a2q1N2c2iksHcM1MKFFx0w+eVncqLQWUUQsKidN/DM7kPg20FU6r+TkI/geD?=
 =?us-ascii?Q?adrOw/njK4XPUh2+h/IEAi7WcAVlgeINwqw7EkV4lVHpZotklGd+GHYQNjzJ?=
 =?us-ascii?Q?PLj7Tu+Cikyeok/zqJpSYd9Y6K3hKQKrQOnOsDdoY7hXc38T6qWCUtAILWIG?=
 =?us-ascii?Q?0Tu1zg1PqyhT/OvfV4aIMspu9jx+RXM1AfwI/REBKauHKBfWcMkUwuGRt0HB?=
 =?us-ascii?Q?8k7a/tb19pCF3NAc7JaQI+xxPC5ndofhqeJKXd5A1LHj9s5htNYVlYtc277L?=
 =?us-ascii?Q?gosUN8VvqxJEkxiTlSB7SSCWD2SHPWNjSQbShLexREfWXY1plsbPyODjQEHM?=
 =?us-ascii?Q?z7Hi10+uKtwxhU+C4ZDyxPu7o3qglTbD4uJoJM3IbFCnFei2lsrdssMwEPco?=
 =?us-ascii?Q?TUvCSDhxxyd83cCMnnV4U2oQJjEquYBRacFw+NfhL3R8DQstdE/dd3Oxslea?=
 =?us-ascii?Q?FYDJx66dBdKLcut5eONChTA0T3fziAxRushPvQuMtbBUkqucnvaH50cuuhqo?=
 =?us-ascii?Q?jMA6ACpVT9FbGRqJoW0KMs2CVAc4Z5BqKwLy2E9zyOCw+n1Y5xsBsCsxqkg8?=
 =?us-ascii?Q?Sb9tI4xLyFV3CAf5ei5Xl+FcVkS7tV8cLMZOws9ZCQxxOQEHavhVKNjI22gS?=
 =?us-ascii?Q?9KQ8nBnE67OaWvmZha0Gw4ZbzMDZt1rRrR28oxK6GvHN+tia2is2vhoAzjQg?=
 =?us-ascii?Q?OMj0WOF3L0AkcPjGXpdkApYzBxPI9I2pt/JET0VIkN4AB95ruOFNJtqJZ9xF?=
 =?us-ascii?Q?n/U6tCK2ftlnd0GDMc2uYmdFqT6QKwyVair2OEWMyEil82KUY38PKa3b0Jif?=
 =?us-ascii?Q?+chfFbv4HrXPhledpHxIz11Ov9WnL92poYyDFgDAjsLFf6R7lK9UUuB1vUq+?=
 =?us-ascii?Q?JM5bPAFLyI5dZYxAenTW5NzrScre0qmv2rF6HQ9FqZE3wVNYhextpbvf76sb?=
 =?us-ascii?Q?TcmxpMRGLvzVoI/lBdFNbSkk8AlLDB9vP1/PghyfHZlrV13O4TkOdpXmKHWL?=
 =?us-ascii?Q?W9rXfX95F6uuvnt5o85opKjuhGmazIaZhGGEE5ynSH0uKw1RDez++A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 05:47:50.8173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f4d5aa1-d7c6-47df-6753-08dd5c726ea2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9086

kpromoted is a kernel daemon that accumulates hot page info
from different sources and tries to promote pages from slow
tiers to top tiers. One instance of this thread runs on each
node that has CPUs.

Subsystems that generate hot page access info can report that
to kpromoted via this API:

int kpromoted_record_access(u64 pfn, int nid, int src,
			    unsigned long time)

@pfn: The PFN of the memory accessed
@nid: The accessing NUMA node ID
@src: The temperature source (subsystem) that generated the
      access info
@time: The access time in jiffies

Some temperature sources may not provide the nid from which
the page was accessed. This is true for sources that use
page table scanning for PTE Accessed bit. Currently the toptier
node to which such pages should be promoted to is hard coded.

Also, the access time provided some sources may at best be
considered approximate. This is especially true for hot pages
detected by PTE A bit scanning.

kpromoted currently maintains the hot PFN records in hash lists
hashed by PFN value. Each record stores the following info:

struct page_hotness_info {
	unsigned long pfn;

	/* Time when this record was updated last */
	unsigned long last_update;

	/*
	 * Number of times this page was accessed in the
	 * current window
	 */
	int frequency;

	/* Most recent access time */
	unsigned long recency;

	/* Most recent access from this node */
	int hot_node;

	struct hlist_node hnode;
};

The way in which a page is categorized as hot enough to be
promoted is pretty primitive now.

Signed-off-by: Bharata B Rao <bharata@amd.com>
---
 include/linux/kpromoted.h     |  54 ++++++
 include/linux/mmzone.h        |   4 +
 include/linux/vm_event_item.h |  13 ++
 mm/Kconfig                    |   7 +
 mm/Makefile                   |   1 +
 mm/kpromoted.c                | 305 ++++++++++++++++++++++++++++++++++
 mm/mm_init.c                  |  10 ++
 mm/vmstat.c                   |  13 ++
 8 files changed, 407 insertions(+)
 create mode 100644 include/linux/kpromoted.h
 create mode 100644 mm/kpromoted.c

diff --git a/include/linux/kpromoted.h b/include/linux/kpromoted.h
new file mode 100644
index 000000000000..2bef3d74f03a
--- /dev/null
+++ b/include/linux/kpromoted.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_KPROMOTED_H
+#define _LINUX_KPROMOTED_H
+
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/workqueue_types.h>
+
+/* Page hotness temperature sources */
+enum kpromoted_src {
+	KPROMOTED_HW_HINTS,
+	KPROMOTED_PGTABLE_SCAN,
+};
+
+#ifdef CONFIG_KPROMOTED
+
+#define KPROMOTED_FREQ_WINDOW	(5 * MSEC_PER_SEC)
+
+/* 2 accesses within a window will make the page a promotion candidate */
+#define KPRMOTED_FREQ_THRESHOLD	2
+
+#define KPROMOTED_HASH_ORDER	16
+
+struct page_hotness_info {
+	unsigned long pfn;
+
+	/* Time when this record was updated last */
+	unsigned long last_update;
+
+	/*
+	 * Number of times this page was accessed in the
+	 * current window
+	 */
+	int frequency;
+
+	/* Most recent access time */
+	unsigned long recency;
+
+	/* Most recent access from this node */
+	int hot_node;
+	struct hlist_node hnode;
+};
+
+#define KPROMOTE_DELAY	MSEC_PER_SEC
+
+int kpromoted_record_access(u64 pfn, int nid, int src, unsigned long now);
+#else
+static inline int kpromoted_record_access(u64 pfn, int nid, int src,
+					  unsigned long now)
+{
+	return 0;
+}
+#endif /* CONFIG_KPROMOTED */
+#endif /* _LINUX_KPROMOTED_H */
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 9540b41894da..a5c4e789aa55 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1459,6 +1459,10 @@ typedef struct pglist_data {
 #ifdef CONFIG_MEMORY_FAILURE
 	struct memory_failure_stats mf_stats;
 #endif
+#ifdef CONFIG_KPROMOTED
+	struct task_struct *kpromoted;
+	wait_queue_head_t kpromoted_wait;
+#endif
 } pg_data_t;
 
 #define node_present_pages(nid)	(NODE_DATA(nid)->node_present_pages)
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index f70d0958095c..b5823b037883 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -182,6 +182,19 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		KSTACK_REST,
 #endif
 #endif /* CONFIG_DEBUG_STACK_USAGE */
+		KPROMOTED_RECORDED_ACCESSES,
+		KPROMOTED_RECORD_HWHINTS,
+		KPROMOTED_RECORD_PGTSCANS,
+		KPROMOTED_RECORD_TOPTIER,
+		KPROMOTED_RECORD_ADDED,
+		KPROMOTED_RECORD_EXISTS,
+		KPROMOTED_MIG_RIGHT_NODE,
+		KPROMOTED_MIG_NON_LRU,
+		KPROMOTED_MIG_COLD_OLD,
+		KPROMOTED_MIG_COLD_NOT_ACCESSED,
+		KPROMOTED_MIG_CANDIDATE,
+		KPROMOTED_MIG_PROMOTED,
+		KPROMOTED_MIG_DROPPED,
 		NR_VM_EVENT_ITEMS
 };
 
diff --git a/mm/Kconfig b/mm/Kconfig
index 1b501db06417..ceaa462a0ce6 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1358,6 +1358,13 @@ config PT_RECLAIM
 
 	  Note: now only empty user PTE page table pages will be reclaimed.
 
+config KPROMOTED
+	bool "Kernel hot page promotion daemon"
+	def_bool y
+	depends on NUMA && MIGRATION && MMU
+	help
+	  Promote hot pages from lower tier to top tier by using the
+	  memory access information provided by various sources.
 
 source "mm/damon/Kconfig"
 
diff --git a/mm/Makefile b/mm/Makefile
index 850386a67b3e..bf4f5f18f1f9 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -147,3 +147,4 @@ obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
 obj-$(CONFIG_EXECMEM) += execmem.o
 obj-$(CONFIG_TMPFS_QUOTA) += shmem_quota.o
 obj-$(CONFIG_PT_RECLAIM) += pt_reclaim.o
+obj-$(CONFIG_KPROMOTED) += kpromoted.o
diff --git a/mm/kpromoted.c b/mm/kpromoted.c
new file mode 100644
index 000000000000..2a8b8495b6b3
--- /dev/null
+++ b/mm/kpromoted.c
@@ -0,0 +1,305 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * kpromoted is a kernel thread that runs on each node that has CPU i,e.,
+ * on regular nodes.
+ *
+ * Maintains list of hot pages from lower tiers and promotes them.
+ */
+#include <linux/kpromoted.h>
+#include <linux/kthread.h>
+#include <linux/mutex.h>
+#include <linux/mmzone.h>
+#include <linux/migrate.h>
+#include <linux/memory-tiers.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/cpuhotplug.h>
+#include <linux/hashtable.h>
+
+static DEFINE_HASHTABLE(page_hotness_hash, KPROMOTED_HASH_ORDER);
+static struct mutex page_hotness_lock[1UL << KPROMOTED_HASH_ORDER];
+
+static int kpromote_page(struct page_hotness_info *phi)
+{
+	struct page *page = pfn_to_page(phi->pfn);
+	struct folio *folio;
+	int ret;
+
+	if (!page)
+		return 1;
+
+	folio = page_folio(page);
+	ret = migrate_misplaced_folio_prepare(folio, NULL, phi->hot_node);
+	if (ret)
+		return 1;
+
+	return migrate_misplaced_folio(folio, phi->hot_node);
+}
+
+static int page_should_be_promoted(struct page_hotness_info *phi)
+{
+	struct page *page = pfn_to_online_page(phi->pfn);
+	unsigned long now = jiffies;
+	struct folio *folio;
+
+	if (!page || is_zone_device_page(page))
+		return false;
+
+	folio = page_folio(page);
+	if (!folio_test_lru(folio)) {
+		count_vm_event(KPROMOTED_MIG_NON_LRU);
+		return false;
+	}
+	if (folio_nid(folio) == phi->hot_node) {
+		count_vm_event(KPROMOTED_MIG_RIGHT_NODE);
+		return false;
+	}
+
+	/* If the page was hot a while ago, don't promote */
+	if ((now - phi->last_update) > 2 * msecs_to_jiffies(KPROMOTED_FREQ_WINDOW)) {
+		count_vm_event(KPROMOTED_MIG_COLD_OLD);
+		return false;
+	}
+
+	/* If the page hasn't been accessed enough number of times, don't promote */
+	if (phi->frequency < KPRMOTED_FREQ_THRESHOLD) {
+		count_vm_event(KPROMOTED_MIG_COLD_NOT_ACCESSED);
+		return false;
+	}
+	return true;
+}
+
+/*
+ * Go thro' page hotness information and migrate pages if required.
+ *
+ * Promoted pages are not longer tracked in the hot list.
+ * Cold pages are pruned from the list as well.
+ *
+ * TODO: Batching could be done
+ */
+static void kpromoted_migrate(pg_data_t *pgdat)
+{
+	int nid = pgdat->node_id;
+	struct page_hotness_info *phi;
+	struct hlist_node *tmp;
+	int nr_bkts = HASH_SIZE(page_hotness_hash);
+	int bkt;
+
+	for (bkt = 0; bkt < nr_bkts; bkt++) {
+		mutex_lock(&page_hotness_lock[bkt]);
+		hlist_for_each_entry_safe(phi, tmp, &page_hotness_hash[bkt], hnode) {
+			if (phi->hot_node != nid)
+				continue;
+
+			if (page_should_be_promoted(phi)) {
+				count_vm_event(KPROMOTED_MIG_CANDIDATE);
+				if (!kpromote_page(phi)) {
+					count_vm_event(KPROMOTED_MIG_PROMOTED);
+					hlist_del_init(&phi->hnode);
+					kfree(phi);
+				}
+			} else {
+				/*
+				 * Not a suitable page or cold page, stop tracking it.
+				 * TODO: Identify cold pages and drive demotion?
+				 */
+				count_vm_event(KPROMOTED_MIG_DROPPED);
+				hlist_del_init(&phi->hnode);
+				kfree(phi);
+			}
+		}
+		mutex_unlock(&page_hotness_lock[bkt]);
+	}
+}
+
+static struct page_hotness_info *__kpromoted_lookup(unsigned long pfn, int bkt)
+{
+	struct page_hotness_info *phi;
+
+	hlist_for_each_entry(phi, &page_hotness_hash[bkt], hnode) {
+		if (phi->pfn == pfn)
+			return phi;
+	}
+	return NULL;
+}
+
+static struct page_hotness_info *kpromoted_lookup(unsigned long pfn, int bkt, unsigned long now)
+{
+	struct page_hotness_info *phi;
+
+	phi = __kpromoted_lookup(pfn, bkt);
+	if (!phi) {
+		phi = kzalloc(sizeof(struct page_hotness_info), GFP_KERNEL);
+		if (!phi)
+			return ERR_PTR(-ENOMEM);
+
+		phi->pfn = pfn;
+		phi->frequency = 1;
+		phi->last_update = now;
+		phi->recency = now;
+		hlist_add_head(&phi->hnode, &page_hotness_hash[bkt]);
+		count_vm_event(KPROMOTED_RECORD_ADDED);
+	} else {
+		count_vm_event(KPROMOTED_RECORD_EXISTS);
+	}
+	return phi;
+}
+
+/*
+ * Called by subsystems that generate page hotness/access information.
+ *
+ * Records the memory access info for futher action by kpromoted.
+ */
+int kpromoted_record_access(u64 pfn, int nid, int src, unsigned long now)
+{
+	struct page_hotness_info *phi;
+	struct page *page;
+	struct folio *folio;
+	int ret, bkt;
+
+	count_vm_event(KPROMOTED_RECORDED_ACCESSES);
+
+	switch (src) {
+	case KPROMOTED_HW_HINTS:
+		count_vm_event(KPROMOTED_RECORD_HWHINTS);
+		break;
+	case KPROMOTED_PGTABLE_SCAN:
+		count_vm_event(KPROMOTED_RECORD_PGTSCANS);
+		break;
+	default:
+		break;
+	}
+
+	/*
+	 * Record only accesses from lower tiers.
+	 * Assuming node having CPUs as toptier for now.
+	 */
+	if (node_is_toptier(pfn_to_nid(pfn))) {
+		count_vm_event(KPROMOTED_RECORD_TOPTIER);
+		return 0;
+	}
+
+	page = pfn_to_online_page(pfn);
+	if (!page || is_zone_device_page(page))
+		return 0;
+
+	folio = page_folio(page);
+	if (!folio_test_lru(folio))
+		return 0;
+
+	bkt = hash_min(pfn, KPROMOTED_HASH_ORDER);
+	mutex_lock(&page_hotness_lock[bkt]);
+	phi = kpromoted_lookup(pfn, bkt, now);
+	if (!phi) {
+		ret = PTR_ERR(phi);
+		goto out;
+	}
+
+	if ((phi->last_update - now) > msecs_to_jiffies(KPROMOTED_FREQ_WINDOW)) {
+		/* New window */
+		phi->frequency = 1; /* TODO: Factor in the history */
+		phi->last_update = now;
+	} else {
+		phi->frequency++;
+	}
+	phi->recency = now;
+
+	/*
+	 * TODOs:
+	 * 1. Source nid is hard-coded for some temperature sources
+	 * 2. Take action if hot_node changes - may be a shared page?
+	 * 3. Maintain node info for every access within the window?
+	 */
+	phi->hot_node = (nid == NUMA_NO_NODE) ? 1 : nid;
+	mutex_unlock(&page_hotness_lock[bkt]);
+out:
+	return 0;
+}
+
+/*
+ * Go through the accumulated mem_access_info and migrate
+ * pages if required.
+ */
+static void kpromoted_do_work(pg_data_t *pgdat)
+{
+	kpromoted_migrate(pgdat);
+}
+
+static inline bool kpromoted_work_requested(pg_data_t *pgdat)
+{
+	return false;
+}
+
+static int kpromoted(void *p)
+{
+	pg_data_t *pgdat = (pg_data_t *)p;
+	struct task_struct *tsk = current;
+	long timeout = msecs_to_jiffies(KPROMOTE_DELAY);
+
+	const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
+
+	if (!cpumask_empty(cpumask))
+		set_cpus_allowed_ptr(tsk, cpumask);
+
+	while (!kthread_should_stop()) {
+		wait_event_timeout(pgdat->kpromoted_wait,
+				   kpromoted_work_requested(pgdat), timeout);
+		kpromoted_do_work(pgdat);
+	}
+	return 0;
+}
+
+static void kpromoted_run(int nid)
+{
+	pg_data_t *pgdat = NODE_DATA(nid);
+
+	if (pgdat->kpromoted)
+		return;
+
+	pgdat->kpromoted = kthread_run(kpromoted, pgdat, "kpromoted%d", nid);
+	if (IS_ERR(pgdat->kpromoted)) {
+		pr_err("Failed to start kpromoted on node %d\n", nid);
+		pgdat->kpromoted = NULL;
+	}
+}
+
+static int kpromoted_cpu_online(unsigned int cpu)
+{
+	int nid;
+
+	for_each_node_state(nid, N_CPU) {
+		pg_data_t *pgdat = NODE_DATA(nid);
+		const struct cpumask *mask;
+
+		mask = cpumask_of_node(pgdat->node_id);
+
+		if (cpumask_any_and(cpu_online_mask, mask) < nr_cpu_ids)
+			/* One of our CPUs online: restore mask */
+			if (pgdat->kpromoted)
+				set_cpus_allowed_ptr(pgdat->kpromoted, mask);
+	}
+	return 0;
+}
+
+static int __init kpromoted_init(void)
+{
+	int nid, ret, i;
+
+	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+					"mm/promotion:online",
+					kpromoted_cpu_online, NULL);
+	if (ret < 0) {
+		pr_err("kpromoted: failed to register hotplug callbacks.\n");
+		return ret;
+	}
+
+	for (i = 0; i < (1UL << KPROMOTED_HASH_ORDER); i++)
+		mutex_init(&page_hotness_lock[i]);
+
+	for_each_node_state(nid, N_CPU)
+		kpromoted_run(nid);
+
+	return 0;
+}
+
+subsys_initcall(kpromoted_init)
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 2630cc30147e..d212df24f89b 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1362,6 +1362,15 @@ static void pgdat_init_kcompactd(struct pglist_data *pgdat)
 static void pgdat_init_kcompactd(struct pglist_data *pgdat) {}
 #endif
 
+#ifdef CONFIG_KPROMOTED
+static void pgdat_init_kpromoted(struct pglist_data *pgdat)
+{
+	init_waitqueue_head(&pgdat->kpromoted_wait);
+}
+#else
+static void pgdat_init_kpromoted(struct pglist_data *pgdat) {}
+#endif
+
 static void __meminit pgdat_init_internals(struct pglist_data *pgdat)
 {
 	int i;
@@ -1371,6 +1380,7 @@ static void __meminit pgdat_init_internals(struct pglist_data *pgdat)
 
 	pgdat_init_split_queue(pgdat);
 	pgdat_init_kcompactd(pgdat);
+	pgdat_init_kpromoted(pgdat);
 
 	init_waitqueue_head(&pgdat->kswapd_wait);
 	init_waitqueue_head(&pgdat->pfmemalloc_wait);
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 16bfe1c694dd..618f44bae5c8 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1466,6 +1466,19 @@ const char * const vmstat_text[] = {
 	"kstack_rest",
 #endif
 #endif
+	"kpromoted_recorded_accesses",
+	"kpromoted_recorded_hwhints",
+	"kpromoted_recorded_pgtscans",
+	"kpromoted_record_toptier",
+	"kpromoted_record_added",
+	"kpromoted_record_exists",
+	"kpromoted_mig_right_node",
+	"kpromoted_mig_non_lru",
+	"kpromoted_mig_cold_old",
+	"kpromoted_mig_cold_not_accessed",
+	"kpromoted_mig_candidate",
+	"kpromoted_mig_promoted",
+	"kpromoted_mig_dropped",
 #endif /* CONFIG_VM_EVENT_COUNTERS || CONFIG_MEMCG */
 };
 #endif /* CONFIG_PROC_FS || CONFIG_SYSFS || CONFIG_NUMA || CONFIG_MEMCG */
-- 
2.34.1


