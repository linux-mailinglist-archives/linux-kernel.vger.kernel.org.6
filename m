Return-Path: <linux-kernel+bounces-568699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A41AA69978
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4C781885EF9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79731E991B;
	Wed, 19 Mar 2025 19:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sa7knc7K"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2AD214A97
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412729; cv=fail; b=ZnAS5WF17ATbozhhZa1u1QSxMhHhMh1qkekmwVSCYwN9QuNYBExX5n1tiVVrm6JGPo+1xhHBySfQsR2drLjVHbJnocG5uQNnRyEoD9azRl7I7Dc+UNuWr1amlewGFwsuC4AnztgvtTXNjkN8stErWNw65o/dpN/z16xhEGzWd50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412729; c=relaxed/simple;
	bh=6AGBjKenBHAhwaYNC+MD2M8hWUUxdKb9TBugHzpmkqs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O2GOKak6qu0LOq91e0KvB4CL2LV8bJcSW6KZdQeO4AqJnlYFZ/uQ1MXcRkn+YlFNGBj/r8L6Ag/LHikoiC1enGlID9y+iueq2iUnJkwA5lSJXH8mbChW6AETQW3+RPL69z9S5m2n5RM6Ln6ML+PD/cEwFhrCSxOj0MYndKTVEc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sa7knc7K; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ec0JQ5oTyYwgXEw+UGkjBJk8LeoTOfpWlqoggoTT9BJdYZyUleAU5GOsjqlnq+q29BGAW7be9IsxfcwsvAzT30rbrasSungoUvFusfzZB3OwQdjJX11cBGuvRUafJ1r19O93eOcflrWqpWNOCcAQSGvrAbz1zrY+qBZ3KQ19hvlTrE1lBMTHBly7ADA+gu/9NRfO7BJkgKCGP/o0W05ymuPPIyKxJers+GynWtNr+iKGKiTpGEedgu/W865YET31Pz+kQkjn+obxkbDBXkIfpsPXjthRD0HsV/LL33CpI8B+0vqIgIYjju/Te2Jud3C49SpBOvlsXoyaF1CGIqtRMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wGhb7LYtxUiwXUG0HCYGUwtr/i49pZpHiAdkz0j43g=;
 b=LKqQSltTEfcAvDtNKc2gmntGYa/Z8RWPKgrEkNhw8ye0SLOjFW7IIORd4n3dPF2xHpfukvH+5OlR5l4DtxUTzISiVSZkarMQ1n8MY3i8Qlsw7uyZKsULUTEXY89DpmcIeEerWJfS/H4C8u8WK7Q2tSADVwij47zoAxhbHcof6talKy+PYbxjgiX4GRmuXebWhkFy4fCfDcQ9OIel1wOwStA1k1wg/AO3lGeNPIcIvAK8UPnTSZ/cBryvJ9parg4rSQNZJALxbnS8dANxFBrz3UGqUJuFWIVfIi/qR6IMjDTBDcYgVltWAbAWK5fZ+9+XKnfL4URteT6JgKX52bOBLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arm.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wGhb7LYtxUiwXUG0HCYGUwtr/i49pZpHiAdkz0j43g=;
 b=sa7knc7KDjngonBEJXlqBh6UWjTsT87vDOGx9x/GK9LEtwCW3XN4QoGNKjmW062H0cbNtA2WLNFHx0l5CpE783xKbngoVJOIx2H6/KtP5lZDhJWtL+qJGLYO3sB7qUPEEOeIRmqOmPdPXW6wXq/zxBlXYQhMmAJw5Mj9Ex+UEBs=
Received: from SA9PR13CA0118.namprd13.prod.outlook.com (2603:10b6:806:24::33)
 by SN7PR12MB7370.namprd12.prod.outlook.com (2603:10b6:806:299::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 19:32:02 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:24:cafe::21) by SA9PR13CA0118.outlook.office365.com
 (2603:10b6:806:24::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Wed,
 19 Mar 2025 19:32:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 19:32:01 +0000
Received: from tunga.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 14:31:52 -0500
From: Raghavendra K T <raghavendra.kt@amd.com>
To: <raghavendra.kt@amd.com>
CC: <AneeshKumar.KizhakeVeetil@arm.com>, <Hasan.Maruf@amd.com>,
	<Michael.Day@amd.com>, <akpm@linux-foundation.org>, <bharata@amd.com>,
	<dave.hansen@intel.com>, <david@redhat.com>, <dongjoo.linux.dev@gmail.com>,
	<feng.tang@intel.com>, <gourry@gourry.net>, <hannes@cmpxchg.org>,
	<honggyu.kim@sk.com>, <hughd@google.com>, <jhubbard@nvidia.com>,
	<jon.grimm@amd.com>, <k.shutemov@gmail.com>, <kbusch@meta.com>,
	<kmanaouil.dev@gmail.com>, <leesuyeon0506@gmail.com>, <leillc@google.com>,
	<liam.howlett@oracle.com>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <mgorman@techsingularity.net>, <mingo@redhat.com>,
	<nadav.amit@gmail.com>, <nphamcs@gmail.com>, <peterz@infradead.org>,
	<riel@surriel.com>, <rientjes@google.com>, <rppt@kernel.org>,
	<santosh.shukla@amd.com>, <shivankg@amd.com>, <shy828301@gmail.com>,
	<sj@kernel.org>, <vbabka@suse.cz>, <weixugc@google.com>,
	<willy@infradead.org>, <ying.huang@linux.alibaba.com>, <ziy@nvidia.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>
Subject: [RFC PATCH V1 06/13] mm: Add throttling of mm scanning using scan_period
Date: Wed, 19 Mar 2025 19:30:21 +0000
Message-ID: <20250319193028.29514-7-raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250319193028.29514-1-raghavendra.kt@amd.com>
References: <20250319193028.29514-1-raghavendra.kt@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|SN7PR12MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d38bf76-7eaa-4fd3-927a-08dd671cb923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EZMw0dXOIE1FJAwUi3ajEr3mFpLDxIn4VgVVCm5R4kyu/DrBTEZyjMekcC2b?=
 =?us-ascii?Q?hQAEauWrNTLX2108tSbLMDDAaMD/AcjFCB2hmRdnctwE9UeyAsaUgOHxq8OG?=
 =?us-ascii?Q?8NAEkJ2UlSbmU3lVFKzD0hv9WqBDX4KRg+VA5LfYiVV3HL5saMlDUHW6+Ir8?=
 =?us-ascii?Q?/boPiGN6NI92qriPAEavNWrYnvZrb6rlSXw86cABtkmxaNKcdugbvcGtuah8?=
 =?us-ascii?Q?GNKz54tyUNvtOcRNk9ha5WgcTc9f1A0Zy2U6Z+CQq+Sm98V5Ks+CQmyRQ9BG?=
 =?us-ascii?Q?ZFWUEAiiYSit2oYBJEbQMqH+O3RV0XZVE/pW+B9pPTD9nF15wNodahVpbDAF?=
 =?us-ascii?Q?xEDFG4Be29ir0NJ9VYHgPcS4BaXCxEOWgVAS2zw5wVTsVk2tq6pjALwd7Qpn?=
 =?us-ascii?Q?f8NQVQ41kITpMm5Rd0jx4bG87lo1QToTvR56b82DOxFFhNDCe9WrCbN8qH2D?=
 =?us-ascii?Q?9CuTifXTglOr2/cPalvYswuybkevKY4EoL2U22YWgnmsRxOVj4fSXxPtBDzZ?=
 =?us-ascii?Q?aGg5M3GAEimkSwRQCNmui6UlvyFrZ1yU+fGbdAPQl8Grh0iJtwzoE4xKcxmQ?=
 =?us-ascii?Q?0IhMXlMhdC0RMBLLVuiANTvd3i/JncY/8dfS+lwjKgcc0N5aKur5fh3czrxr?=
 =?us-ascii?Q?aHN7zE3G+KVFoeI5QH3UltTDd1Zuha1bnziDN/3UAWabbX2fkf/W7/MGRVMf?=
 =?us-ascii?Q?8z/RxPA0s9Faas5+fYyFzY8xhUhsC5mLHg+fZIUIVlpYSyzlrExj3v5SYQqO?=
 =?us-ascii?Q?ktpruj7RXclvFfmzmifmiko1mnONk4DSJSOOYtu46jOlYP8ZtXL5Mh60R7dQ?=
 =?us-ascii?Q?yqhDLjP9YbUvLzalXv1VjTwuSeuxpGfe62Q+b5pIN7zsLOjosUwEui65ThZa?=
 =?us-ascii?Q?xcXvQY9AZohdePwr71eJL1O1iWOTDYVUb6p5y2Y8i47CcFmq/bUcimXfX9db?=
 =?us-ascii?Q?14aoHo1ByqeSBX32NTh9rTqFO5x8anVp00+heLvh2nSHBP2F/JlBzQc0d9f3?=
 =?us-ascii?Q?cN8tgfxGC37nMIUXrwegakiGRU6ljaBkmBAr5sAyYP5UvxWDQIKLKfauHgyo?=
 =?us-ascii?Q?ZXrw6L6rw7W2PygQrQ6fG4ovFqhsnKHtZ3uVXljIfoL+q8/P0SSBZ+cfKM3r?=
 =?us-ascii?Q?IUja3uJtpXoMCzkL3mE67a6blvFu3JwttdMBJs6taw5ki8cVgsdtQMESUVcB?=
 =?us-ascii?Q?82OPvr2VrnbVfwag5y4KqvJ2pxgHkfzjxdPeWWu+AfaII19kkTO/K4LwCgxZ?=
 =?us-ascii?Q?gvfD7GYwvAyNF7s23Z/wDzqxRkO+DXRijRiGjikOcE/QgnXifpDHJivBhp2p?=
 =?us-ascii?Q?1TLIq4I2tWXAgoxReMC6C0KqfytzWxMKawRYTll/hcN44oavhwSr3osQXv37?=
 =?us-ascii?Q?mEyI81ZNmq2fQYZuj53zJF7Hnb54d7BSnnwrXTBwTGXZmBEH2r4GiD1Vc++l?=
 =?us-ascii?Q?LTu0MHHFao4aH58AqrBtkZy4IJiPke5NdGGXNTdNiuh2Z2LplMjk+GzjM4Gg?=
 =?us-ascii?Q?srAFvy8KElPsfms=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 19:32:01.8714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d38bf76-7eaa-4fd3-927a-08dd671cb923
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7370

Before this patch, scanning of tasks' mm is done continuously and also
at the same rate.

Improve that by adding a throttling logic:
1) If there were useful pages found during last scan and current scan,
decrease the scan_period (to increase scan rate) by TUNE_PERCENT (15%).

2) If there were no useful pages found in last scan, and there are
candidate migration pages in the current scan decrease the scan_period
aggressively by 2 power SCAN_CHANGE_SCALE (2^3 = 8 now).

Vice versa is done for the reverse case.
Scan period is clamped between MIN (500ms) and MAX (5sec).

Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 mm/kmmscand.c | 110 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 109 insertions(+), 1 deletion(-)

diff --git a/mm/kmmscand.c b/mm/kmmscand.c
index feca775d0191..cd2215f2e00e 100644
--- a/mm/kmmscand.c
+++ b/mm/kmmscand.c
@@ -20,6 +20,7 @@
 #include <linux/string.h>
 #include <linux/delay.h>
 #include <linux/cleanup.h>
+#include <linux/minmax.h>
 
 #include <asm/pgalloc.h>
 #include "internal.h"
@@ -33,6 +34,16 @@ static DEFINE_MUTEX(kmmscand_mutex);
 #define KMMSCAND_SCAN_SIZE	(1 * 1024 * 1024 * 1024UL)
 static unsigned long kmmscand_scan_size __read_mostly = KMMSCAND_SCAN_SIZE;
 
+/*
+ * Scan period for each mm.
+ * Min: 500ms default: 2sec Max: 5sec
+ */
+#define KMMSCAND_SCAN_PERIOD_MAX	5000U
+#define KMMSCAND_SCAN_PERIOD_MIN	500U
+#define KMMSCAND_SCAN_PERIOD		2000U
+
+static unsigned int kmmscand_mm_scan_period_ms __read_mostly = KMMSCAND_SCAN_PERIOD;
+
 /* How long to pause between two scan and migration cycle */
 static unsigned int kmmscand_scan_sleep_ms __read_mostly = 16;
 
@@ -74,6 +85,11 @@ static struct kmem_cache *kmmscand_slot_cache __read_mostly;
 /* Per mm information collected to control VMA scanning */
 struct kmmscand_mm_slot {
 	struct mm_slot slot;
+	/* Unit: ms. Determines how aften mm scan should happen. */
+	unsigned int scan_period;
+	unsigned long next_scan;
+	/* Tracks how many useful pages obtained for migration in the last scan */
+	unsigned long scan_delta;
 	long address;
 	bool is_scanned;
 };
@@ -590,13 +606,92 @@ static void kmmscand_migrate_folio(void)
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
+#define KMMSCAND_IGNORE_SCAN_THR	256
+
+/* Maintains stability of scan_period by decaying last time accessed pages */
+#define SCAN_DECAY_SHIFT	4
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
+static inline void kmmscand_update_mmslot_info(struct kmmscand_mm_slot *mm_slot,
+				unsigned long total)
+{
+	unsigned int scan_period;
+	unsigned long now;
+	unsigned long old_scan_delta;
+
+	scan_period = mm_slot->scan_period;
+	old_scan_delta = mm_slot->scan_delta;
+
+	/* decay old value */
+	total = (old_scan_delta >> SCAN_DECAY_SHIFT) + total;
+
+	/* XXX: Hack to get rid of continuously failing/unmigrateable pages */
+	if (total < KMMSCAND_IGNORE_SCAN_THR)
+		total = 0;
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
 	bool next_mm = false;
 	bool update_mmslot_info = false;
 
+	unsigned int mm_slot_scan_period;
+	unsigned long now;
+	unsigned long mm_slot_next_scan;
 	unsigned long vma_scanned_size = 0;
 	unsigned long address;
+	unsigned long total = 0;
 
 	struct mm_slot *slot;
 	struct mm_struct *mm;
@@ -620,6 +715,8 @@ static unsigned long kmmscand_scan_mm_slot(void)
 
 	mm = slot->mm;
 	mm_slot->is_scanned = true;
+	mm_slot_next_scan = mm_slot->next_scan;
+	mm_slot_scan_period = mm_slot->scan_period;
 	spin_unlock(&kmmscand_mm_lock);
 
 	if (unlikely(!mmap_read_trylock(mm)))
@@ -630,6 +727,11 @@ static unsigned long kmmscand_scan_mm_slot(void)
 		goto outerloop;
 	}
 
+	now = jiffies;
+
+	if (mm_slot_next_scan && time_before(now, mm_slot_next_scan))
+		goto outerloop;
+
 	VMA_ITERATOR(vmi, mm, address);
 
 	for_each_vma(vmi, vma) {
@@ -658,8 +760,10 @@ static unsigned long kmmscand_scan_mm_slot(void)
 
 	update_mmslot_info = true;
 
-	if (update_mmslot_info)
+	if (update_mmslot_info) {
 		mm_slot->address = address;
+		kmmscand_update_mmslot_info(mm_slot, total);
+	}
 
 outerloop:
 	/* exit_mmap will destroy ptes after this */
@@ -759,6 +863,10 @@ void __kmmscand_enter(struct mm_struct *mm)
 		return;
 
 	kmmscand_slot->address = 0;
+	kmmscand_slot->scan_period = kmmscand_mm_scan_period_ms;
+	kmmscand_slot->next_scan = 0;
+	kmmscand_slot->scan_delta = 0;
+
 	slot = &kmmscand_slot->slot;
 
 	spin_lock(&kmmscand_mm_lock);
-- 
2.34.1


