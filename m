Return-Path: <linux-kernel+bounces-426649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC979DF648
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 16:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E009CB21604
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 15:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B391D61AF;
	Sun,  1 Dec 2024 15:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y8QWYVS4"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDB31D7985
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 15:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733067573; cv=fail; b=Wxa1B6KHYsGRv0C4BE7nScXyVSrLatD3q7bubg1CnWuxr/5pYFOgzkVAmNkNplqCQ8GCqmXcWhNzsJ5Z7w9BvYB85tw0+LjgFUlNzxGwvmnjOeKove6tmMAQI/rtPn8IPcIlPIrjepPbOLUX6rVBmgtdfkzAvoNuBhFtrLGojyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733067573; c=relaxed/simple;
	bh=Q363yhiptxTVnDokhH8vdNq3s9Pk9lI+CS8MFqXpNo0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U3eL7+NYECvkt1LZ3EZDsGaiTdcGyIuYXWE2s8Wjtq7cSUpAXKjAxjXuyta6iWjndqr70LCzH/P6Y05pAlmF7b0SfnBuAD4q4sRHPxC747hzpWZB+jxANWy+t90qUvbOmYGuwNxW23cXfMVoql2NfuPECAkHNguV2NvU8q1MC8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y8QWYVS4; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v3M2GiJ+5HnqwjHBsSj1ySGBLVfJlf6m9svftCOjuVzok9n+RfA665XN7LKH2C2QkATUW8eVrqE3erQ+VSqBE7RyzAd7b+9kJSaxTeRnhTPwd5r0EGjPOQ6MUvIvLXpGTdsQ/bUfuZoYRU5sPDqEcZO9ual73VygZNtubyhYKuOxxNKA8vfT6gw5rSNHihXhgvEEb3YjCyIIoB6kgZvZ+AH6kdlFbEykGb3fAGazhFKNAv4W5HYazsjVYk8b3HWha17hnM6HxZTsCu6zZA1w23Bks9pD6LGBXJxYh5aQEGECPuc95GJaEFgW/FRZclC11pAdnpLBI2BvZOaIh1z09A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dwe8vbJBrdvHNicsKKFYYBYqThCiOEgC4bm7rduMFtg=;
 b=l46RNy1KWyPdgfrEMguBb7Cw8u2+XUzDSZ8GSUvE3eeTaX50br9FgPpxzaXdsYarIUaooi3AXoQ7hfY6j8LRdzYqAD0IRdmskd3FtMCYXKROXRik2Ec7Vvp07r/oMUzaSHQ/V+Lfb/Kn5+g1mMVLgba7rS2YnPGBqfUy66HYcFbkNwYN6LZbxll3RNF2PX4Pm0KZIfWsBitbZG1fFJxIQa7T/TVdepl+pr59+q1leIxUbNfH/ohQDNn1R2IV4Ej0/MyV399iFjg4kv1mikbskWiVI3pOln3Mx4fmBAe2ajN07bi9iFlWxw8sH/dWLRw41lE0Om3IdikaHcnO8k3OIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kvack.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dwe8vbJBrdvHNicsKKFYYBYqThCiOEgC4bm7rduMFtg=;
 b=Y8QWYVS4sjsQcE+1BVJbHA4/pflFsca7fkQy/cN7b9M7D9h338V7IC6R6mewtZvrF78zzsti2407sLZB0XeH3lrKxsOB+yvwCDHH+HjOLrVb0hJ4N8diAYQsvXKTYf5bCvCFd6NV/UKr7x2GrIKF4swe0b9wq40exNcKDvGH4N0=
Received: from CH0PR08CA0016.namprd08.prod.outlook.com (2603:10b6:610:33::21)
 by BL1PR12MB5900.namprd12.prod.outlook.com (2603:10b6:208:398::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Sun, 1 Dec
 2024 15:39:24 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:33:cafe::10) by CH0PR08CA0016.outlook.office365.com
 (2603:10b6:610:33::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.16 via Frontend Transport; Sun,
 1 Dec 2024 15:39:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sun, 1 Dec 2024 15:39:23 +0000
Received: from tunga.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 1 Dec
 2024 09:39:16 -0600
From: Raghavendra K T <raghavendra.kt@amd.com>
To: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <gourry@gourry.net>,
	<nehagholkar@meta.com>, <abhishekd@meta.com>, <david@redhat.com>,
	<ying.huang@intel.com>, <nphamcs@gmail.com>, <akpm@linux-foundation.org>,
	<hannes@cmpxchg.org>, <feng.tang@intel.com>, <kbusch@meta.com>,
	<bharata@amd.com>, <Hasan.Maruf@amd.com>, <sj@kernel.org>
CC: <willy@infradead.org>, <kirill.shutemov@linux.intel.com>,
	<mgorman@techsingularity.net>, <vbabka@suse.cz>, <hughd@google.com>,
	<rientjes@google.com>, <shy828301@gmail.com>, <Liam.Howlett@Oracle.com>,
	<peterz@infradead.org>, <mingo@redhat.com>, Raghavendra K T
	<raghavendra.kt@amd.com>
Subject: [RFC PATCH V0 05/10] mm: Add throttling of mm scanning using scan_period
Date: Sun, 1 Dec 2024 15:38:13 +0000
Message-ID: <20241201153818.2633616-6-raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241201153818.2633616-1-raghavendra.kt@amd.com>
References: <20241201153818.2633616-1-raghavendra.kt@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|BL1PR12MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a0f1a83-c50a-4a53-3fc2-08dd121e54b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dz0MkRLMoL2exnRuum9I7KSoT0Yy8/A4NJZW0jUkYTbBPP+KWXlOOPaUyvHE?=
 =?us-ascii?Q?wSWciQEQzXcCmtsoHNfaPNFDTrs3LrNOe5ame/fZLel/EhSWspJeZNx4EIV5?=
 =?us-ascii?Q?9Wlb6CuvbtgwsSOecym9GKSQkRUi3vufqEb8T3+E8oDoZlN0JwANIwaDfTgN?=
 =?us-ascii?Q?KzcM/0ZfUlPb83PVHImqJOsoczcjn2D5SpbRkIvG345bfDRkg4bxf1IHZHS5?=
 =?us-ascii?Q?NPqlbWoogqD8TvR1WCXdgsWEV8XHXwF3s+Enp/4PyXj81ON6Z3VCU9mTP5nA?=
 =?us-ascii?Q?H9zzg4e73lZ/UkHEo5Go0HI1iU4WjU3+rpfkPcag2Uv2QN+Qteaaa0qCxv3h?=
 =?us-ascii?Q?qn8tPgtohpGyWP2MnqcfVqW1vgEemheHDlGoeRpu+WpiU/hBjwGuiwGYYuGm?=
 =?us-ascii?Q?CWPk3lTlOUxqh+jElzGFmO6LDyOT4UMvQ104go6KIOw+/z+aWETIdm64f7BB?=
 =?us-ascii?Q?H5irrhUAHh39buDz9tnmowoM0IuyFcz34qkrbL0BiORzD62hBvRIGvtPDzkI?=
 =?us-ascii?Q?HnRfAAXMYpqqkPUyHeAyHshjN8d+tbC8mRm8G4pk3cHZNa7TQLoPzR3/dEmE?=
 =?us-ascii?Q?+W3GqKTHkF1Qi3tkeo5h9Y9us6Q+iEEd+tf5pcSIlU/lheM/C2YI+XRTTkki?=
 =?us-ascii?Q?StyNKZmsfyZ6vKVnnIC4jJ68qQn7VuFKjIMOUkHXXX+32JyGKWtE/TMmgi3u?=
 =?us-ascii?Q?uLtXxL+F0v+NNxA5ol26hFbn3JDe0bWuhcqYhv6yqrHZZuSSfKf4tD05r2CD?=
 =?us-ascii?Q?70RfS0fXq7gkuNNQRk8/H97PK2li0KJHFaJM2SQomlhZPLn9VYiaaIAvKlg8?=
 =?us-ascii?Q?4kokLb0nrZywC/QA9e2ObOGU2jHn3HupwTE+Cfgd+jyxiO+Ek5ZdAKsX9XEh?=
 =?us-ascii?Q?+DEH58E6DxsKUPrL+YrdOkhMI7p/N7xR6XKRjTsONVoxEQ+wrioBY8JbI59h?=
 =?us-ascii?Q?Y+jgsCMoY85d6m8Gz2Jgjypxp466GMMEIHReKbsIvSF7rZ8W9atM9mZeZl6d?=
 =?us-ascii?Q?uRE2AY8i8Z48RW4WxU0AhRVJQ1V58dIu2GX+F7GBzIH9kuVYWOgqIJFOsIED?=
 =?us-ascii?Q?Erpzwd5x+kNH0u1yahQO+nbrspgVqUtWvk2YYYgw4CzElFTBuqsw/eJ5ZxZM?=
 =?us-ascii?Q?zsOcyV03JwtMKGnqLg5u4r1gRV8Q7z/0Q0AvEVxZSTxZ5bUWBdv+m34NMmz/?=
 =?us-ascii?Q?Gv5b8pgzRU5vAhflFCyM3r/CTwGTi4OQdghrNvdufr1ieMp08LF6wSYVj5ki?=
 =?us-ascii?Q?kCS2XYIfDWz59luPszNdp1kENQvr46jOtY2ZWnIcmlhWlLcYRkw4ld8AZHpr?=
 =?us-ascii?Q?iQOqrT6EOO12lnxVICevqhTKmYp93edkMhJupY3S3zCq6d2sU2e4KbZ/RUrT?=
 =?us-ascii?Q?y5fCzlPNw2JyUIjJc20HevXO4WgXtFZeHvuvnviUwSGHRTxMKsvicWXf9L7A?=
 =?us-ascii?Q?VTE17WXKE4vHEcgXBI+EBacuBppNoaSowsds2XJmwFFVIL7cuGdrSQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2024 15:39:23.5115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a0f1a83-c50a-4a53-3fc2-08dd121e54b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5900

Before this patch, scanning of tasks' mm is done continuously and also
at the same rate.

Improve that by adding a throttling logic:
1) if there were useful pages found during last scan and current scan,
decrease the scan_period (to increase scan rate) by TUNE_PERCENT (15%).

2) if there were no useful pages found in last scan, and there are
candidate migration pages in the current scan decrease the scan_period
aggressively by 2 power SCAN_CHANGE_SCALE (2^3 = 8 now).

Vice versa is done for the reverse case.
Scan period is clamped between MIN (400ms) and MAX (5sec).

Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 include/linux/mm_types.h |   4 ++
 mm/kmmscand.c            | 123 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 125 insertions(+), 2 deletions(-)

Future improvements:
1. Consider the slope of useful pages found in last
scan and current scan for finer tuning.
2. Use migration failure information.

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 7361a8f3ab68..620b360b06fe 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -978,6 +978,10 @@ struct mm_struct {
 
 		/* numa_scan_seq prevents two threads remapping PTEs. */
 		int numa_scan_seq;
+#endif
+#ifdef CONFIG_KMMSCAND
+		/* Tracks number of pages with PTE A  bit set after scanning. */
+		atomic_long_t nr_accessed;
 #endif
 		/*
 		 * An operation with batched TLB flushing is going on. Anything
diff --git a/mm/kmmscand.c b/mm/kmmscand.c
index 3b4453b053f4..589aed604cd6 100644
--- a/mm/kmmscand.c
+++ b/mm/kmmscand.c
@@ -19,6 +19,7 @@
 #include <linux/mempolicy.h>
 #include <linux/string.h>
 #include <linux/cleanup.h>
+#include <linux/minmax.h>
 
 #include <asm/pgalloc.h>
 #include "internal.h"
@@ -27,6 +28,16 @@
 static struct task_struct *kmmscand_thread __read_mostly;
 static DEFINE_MUTEX(kmmscand_mutex);
 
+/*
+ * Scan period for each mm.
+ * Min: 400ms default: 2sec Max: 5sec
+ */
+#define KMMSCAND_SCAN_PERIOD_MAX	5000U
+#define KMMSCAND_SCAN_PERIOD_MIN	400U
+#define KMMSCAND_SCAN_PERIOD		2000U
+
+static unsigned int kmmscand_mm_scan_period_ms __read_mostly = KMMSCAND_SCAN_PERIOD;
+
 /* How long to pause between two scan and migration cycle */
 static unsigned int kmmscand_scan_sleep_ms __read_mostly = 16;
 
@@ -58,6 +69,11 @@ static struct kmem_cache *kmmscand_slot_cache __read_mostly;
 
 struct kmmscand_mm_slot {
 	struct mm_slot slot;
+	/* Unit: ms. Determines how aften mm scan should happen. */
+	unsigned int scan_period;
+	unsigned long next_scan;
+	/* Tracks how many useful pages obtained for migration in the last scan */
+	unsigned long scan_delta;
 	long address;
 };
 
@@ -85,6 +101,7 @@ struct kmmscand_migrate_info {
 	struct folio *folio;
 	unsigned long address;
 };
+
 static int kmmscand_has_work(void)
 {
 	return !list_empty(&kmmscand_scan.mm_head);
@@ -324,6 +341,12 @@ static int hot_vma_idle_pte_entry(pte_t *pte,
 			spin_lock(&kmmscand_migrate_lock);
 			list_add_tail(&info->migrate_node, &migrate_list->migrate_head);
 			spin_unlock(&kmmscand_migrate_lock);
+
+			/*
+			 * XXX: Should nr_accessed be per vma for finer control?
+			 * XXX: We are increamenting atomic var under mmap_readlock
+			 */
+			atomic_long_inc(&mm->nr_accessed);
 		}
 	}
 end:
@@ -446,11 +469,85 @@ static void kmmscand_migrate_folio(void)
 	spin_unlock(&kmmscand_migrate_lock);
 }
 
+/*
+ * This is the normal change percentage when old and new delta remain same.
+ * i.e., either both positive or both zero.
+ */
+#define SCAN_PERIOD_TUNE_PERCENT	15
+
+/* This is to change the scan_period aggressively when deltas are different */
+#define SCAN_PERIOD_CHANGE_SCALE	3
+/*
+ * XXX: Hack to prevent unmigrated pages coming again and again while scanning.
+ * Actual fix needs to identify the type of unmigrated pages OR consider migration
+ * failures in next scan.
+ */
+#define KMMSCAND_IGNORE_SCAN_THR	100
+
+/*
+ * X : Number of useful pages in the last scan.
+ * Y : Number of useful pages found in current scan.
+ * Tuning scan_period:
+ *	Initial scan_period is 2s.
+ *	case 1: (X = 0, Y = 0)
+ *		Increase scan_period by SCAN_PERIOD_TUNE_PERCENT.
+ *	case 2: (X = 0, Y > 0)
+ *		Decrease scan_period by (2 << SCAN_PERIOD_CHANGE_SCALE).
+ *	case 3: (X > 0, Y = 0 )
+ *		Increase scan_period by (2 << SCAN_PERIOD_CHANGE_SCALE).
+ *	case 4: (X > 0, Y > 0)
+ *		Decrease scan_period by SCAN_PERIOD_TUNE_PERCENT.
+ */
+static inline void kmmscand_update_mmslot_info(struct kmmscand_mm_slot *mm_slot, unsigned long total)
+{
+	unsigned int scan_period;
+	unsigned long now;
+	unsigned long old_scan_delta;
+
+	/* XXX: Hack to get rid of continuously failing/unmigrateable pages */
+	if (total < KMMSCAND_IGNORE_SCAN_THR)
+		total = 0;
+
+	scan_period = mm_slot->scan_period;
+
+	old_scan_delta = mm_slot->scan_delta;
+
+	/*
+	 * case 1: old_scan_delta and new delta are similar, (slow) TUNE_PERCENT used.
+	 * case 2: old_scan_delta and new delta are different. (fast) CHANGE_SCALE used.
+	 * TBD:
+	 * 1. Further tune scan_period based on delta between last and current scan delta.
+	 * 2. Optimize calculation
+	 */
+	if (!old_scan_delta && !total) {
+		scan_period = (100 + SCAN_PERIOD_TUNE_PERCENT) * scan_period;
+		scan_period /= 100;
+	} else if (old_scan_delta && total) {
+		scan_period = (100 - SCAN_PERIOD_TUNE_PERCENT) * scan_period;
+		scan_period /= 100;
+	} else if (old_scan_delta && !total) {
+		scan_period = scan_period << SCAN_PERIOD_CHANGE_SCALE;
+	} else {
+		scan_period = scan_period >> SCAN_PERIOD_CHANGE_SCALE;
+	}
+
+	scan_period = clamp(scan_period, KMMSCAND_SCAN_PERIOD_MIN, KMMSCAND_SCAN_PERIOD_MAX);
+
+	now = jiffies;
+	mm_slot->next_scan = now + msecs_to_jiffies(scan_period);
+	mm_slot->scan_period = scan_period;
+	mm_slot->scan_delta = total;
+}
+
 static unsigned long kmmscand_scan_mm_slot(void)
 {
 	bool update_mmslot_info = false;
 
+	unsigned int mm_slot_scan_period;
+	unsigned long now;
+	unsigned long mm_slot_next_scan;
 	unsigned long address;
+	unsigned long folio_nr_access_s, folio_nr_access_e, total = 0;
 
 	struct mm_slot *slot;
 	struct mm_struct *mm;
@@ -473,6 +570,8 @@ static unsigned long kmmscand_scan_mm_slot(void)
 		kmmscand_scan.mm_slot = mm_slot;
 	}
 
+	mm_slot_next_scan = mm_slot->next_scan;
+	mm_slot_scan_period = mm_slot->scan_period;
 	mm = slot->mm;
 
 	spin_unlock(&kmmscand_mm_lock);
@@ -483,6 +582,16 @@ static unsigned long kmmscand_scan_mm_slot(void)
 	if (unlikely(kmmscand_test_exit(mm)))
 		goto outerloop;
 
+	now = jiffies;
+	/*
+	 * Dont scan if :
+	 * This is not a first scan AND
+	 * Reaching here before designated next_scan time.
+	 */
+	if (mm_slot_next_scan && time_before(now, mm_slot_next_scan))
+		goto outerloop;
+
+	folio_nr_access_s = atomic_long_read(&mm->nr_accessed);
 
 	vma_iter_init(&vmi, mm, address);
 
@@ -492,6 +601,8 @@ static unsigned long kmmscand_scan_mm_slot(void)
 
 		address = vma->vm_end;
 	}
+	folio_nr_access_e = atomic_long_read(&mm->nr_accessed);
+	total = folio_nr_access_e - folio_nr_access_s;
 
 	if (!vma)
 		address = 0;
@@ -506,8 +617,12 @@ static unsigned long kmmscand_scan_mm_slot(void)
 	spin_lock(&kmmscand_mm_lock);
 	VM_BUG_ON(kmmscand_scan.mm_slot != mm_slot);
 
-	if (update_mmslot_info)
+
+	if (update_mmslot_info) {
 		mm_slot->address = address;
+		kmmscand_update_mmslot_info(mm_slot, total);
+	}
+
 	/*
 	 * Release the current mm_slot if this mm is about to die, or
 	 * if we scanned all vmas of this mm.
@@ -532,7 +647,7 @@ static unsigned long kmmscand_scan_mm_slot(void)
 	}
 
 	spin_unlock(&kmmscand_mm_lock);
-	return 0;
+	return total;
 }
 
 static void kmmscand_do_scan(void)
@@ -595,6 +710,10 @@ void __kmmscand_enter(struct mm_struct *mm)
 		return;
 
 	kmmscand_slot->address = 0;
+	kmmscand_slot->scan_period = kmmscand_mm_scan_period_ms;
+	kmmscand_slot->next_scan = 0;
+	kmmscand_slot->scan_delta = 0;
+
 	slot = &kmmscand_slot->slot;
 
 	spin_lock(&kmmscand_mm_lock);
-- 
2.39.3


