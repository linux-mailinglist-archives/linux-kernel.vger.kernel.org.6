Return-Path: <linux-kernel+bounces-426650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB989DF649
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 16:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EE1D1632C1
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 15:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3321D6DA4;
	Sun,  1 Dec 2024 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FkuzqLkv"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9E91D61AC
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 15:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733067575; cv=fail; b=THdGVAzvC1iWeS22VKinmiZjsa2x4Yq7o+RMSc7PQ0t5zaRa3O3odGgGEKSjie3NoxZshEWZT7nNG+a3a36+0RkXvg4Zj+gfUOUGidfh8scTDz3Z6GELCde8+zH+PnHprdETJGxJ1FQprtaXpY6l1nQwsFqrpb728lSGXQhdz3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733067575; c=relaxed/simple;
	bh=HhQi3rDUNjGoDJYn0Yk5tmdNkFAkWcYhXub5r6gsKAU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q/tSaVrN+553t4TSIEC6Bd3lr3Fve5YfH9oj3DnDahKL7IsLfY+PIi0CxM6NjmWrceXSGAsqUCFRc4/cylfUbczylw6dJshNHL2WP+wjBR006ipTgN6mQPJOts5UaPAIgsydrOBOCXfcxmx9JA1Xf4sTPQc1NSXUGIK1ordPDkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FkuzqLkv; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qgAZtCd/K6oEdWFTayvuFfzXTd4GuFgE868qmOAu5uKBC6bSYvikBUfsvCE87fcXYR0YPM89pE9Ezsx3rnSNzw8uigmJH53xLZ/fYuEbFIZ/GybZk8iJrG8sPXEUWhcapTYYuDU6+KTmLl8ujmssGf18BCjF+V2mMfbfAICFCjARiEDkj2WxB56Wv4Ie0a0A01FEuOtWhHAYTRxuo9bwfZVHxgQFQBA/qKM1BKKxlmbgbPlZtc9bO1RWL2wZA50vlWDXKVytnamcTDmFwfB9oN1BoCIOW0lDLrZiZ7LWIa/l8FriYD5ow6mmxMuymaKEohG4p59ITVSGCJum7QyNeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJv7WsTryDOyfwOqO3A2L59wJ0uSEjn6EgRQcX/ccfU=;
 b=L6Xj9vE+QOQd3XpfeG+9d/ujtNUbb58Bzqve2shGYYgHanLAFgcIPWnuh4I9RqgTN4Owbb49DD7vCSLO7iM2Zo2ko45XHl4Mvm4XjsKMhr5fEHREYXyssaplL3iVzKuforNQfZZLmdZQJL0yH+NZIBcmiBEFnTW4lxDvdHNscYBnvjQpP4cl3ub1G/SiMOGz0Xnj+kODSnLchvWxAJ6ktm0mYK54jY+SBIpIpmoZJpy7iH30JnXbp3uqMJrdfKLTe936jPVLCMvt4PXxQaz7jiOv5vTT9/ytoDTif6lP8BG1muE5wwR8+QJ4usKuKLx0rMDYsPK8JFIBFyuS2eR3Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kvack.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJv7WsTryDOyfwOqO3A2L59wJ0uSEjn6EgRQcX/ccfU=;
 b=FkuzqLkvKgZ+efC58wH+CVac4vcFL9HyTepB5JnTT+/5wDZ0VPtNkkpjAX7n2Xps6TIiX459+Sp/jUAZRQEdtWwHzFIk7Qbs4+Vjd2weZEpgEwu2yYkwnueWpcgGjVhThePOwkDTTB/6cw8B6+Mo5T0QZ6wPN096kJxhxhHkaUM=
Received: from CH2PR11CA0027.namprd11.prod.outlook.com (2603:10b6:610:54::37)
 by LV8PR12MB9109.namprd12.prod.outlook.com (2603:10b6:408:18a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Sun, 1 Dec
 2024 15:39:29 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:54:cafe::99) by CH2PR11CA0027.outlook.office365.com
 (2603:10b6:610:54::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.16 via Frontend Transport; Sun,
 1 Dec 2024 15:39:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sun, 1 Dec 2024 15:39:29 +0000
Received: from tunga.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 1 Dec
 2024 09:39:22 -0600
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
Subject: [RFC PATCH V0 06/10] mm: Add throttling of mm scanning using scan_size
Date: Sun, 1 Dec 2024 15:38:14 +0000
Message-ID: <20241201153818.2633616-7-raghavendra.kt@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|LV8PR12MB9109:EE_
X-MS-Office365-Filtering-Correlation-Id: e76979ae-80a3-4302-3fb7-08dd121e5822
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qfe4CLmuE/yJGcj7rRTQxFqxAuS7SWsVNnRs79Eg93zeovjtISjqO8t7H5sZ?=
 =?us-ascii?Q?fhTr/1VImRAmQWSQeaiguX02isW02L7gp3c+kP6ijdoWhkWD9Y+IJyKyC283?=
 =?us-ascii?Q?p68Otiirq+s+XG6ALt3HwGBX3YjvIYdIXqetDIkFW5wdrZx2fwtwM/huOYXY?=
 =?us-ascii?Q?2ELccibFoVez5DEmTbPq9pemcGp2MHmx8MsnplLDG1+K2oti4IVT7Z3O2PFA?=
 =?us-ascii?Q?SZ2HZQlDGjxLPvJsUydWzJmDXhjwIdyQ/Nss11ql/yxxuCKJZNyvnk/1gfsO?=
 =?us-ascii?Q?u6anmFXz99ZSOqNWKkMPgprAvVGVmeg+W6EwcduVYEymtTKEWzjAGGNa1gH8?=
 =?us-ascii?Q?vc6ljRpzWHZmY5MA0K7HU3tlC34WXEzxg+GbLl7LtkH5dVX3LbTy28xoKNu9?=
 =?us-ascii?Q?/NeKIB5cNYKTq+ext6EHTrYpJ8QBt/JJwTckh0hSou1lxWkNq2nBpT5Nc57N?=
 =?us-ascii?Q?U0OnjpqStpGgS8Y8sdFGFAGpptOZnYkxKUro2qHoVBqBvvcxd8cc3uUE10Pc?=
 =?us-ascii?Q?EoODyZ1Al+2/xPKrYvrrDbcB4ebHE4+nWeLyuhF6T6f+TdOdUG4R1DSVT16Z?=
 =?us-ascii?Q?T7CbOcqSPe4RvSflh/zy0PYfgHv1ySSZpFNFfEP6i5F27DO/B5ECYl4Hr896?=
 =?us-ascii?Q?mtPXGaPVvaWkhsa47T3idbideaudyQiiCF0QEE8UU3HJo8VD7ujLaWsC7gCp?=
 =?us-ascii?Q?BLlRFEershS6rOe4OBa3fm1e9eDyQr3Uo5rWdqQ9u+iZOHYXZzi/pPv/RZMB?=
 =?us-ascii?Q?KzbPOWBzzImH5Z+VD8disInrSIf09PN06xR+o9RGw2iuRpNbGDnp8x3PFtub?=
 =?us-ascii?Q?TPCVMrCtlwl5IL9y/qXIprfQ+nvgbA70tHLjB9SQM0ktoQm8my59Vk7I74cD?=
 =?us-ascii?Q?RS1MrLlhVUZC13cHJ06k3d9q8FDO9P1AsfsGCpokuqq3Cogbmp8ByYrFaNkp?=
 =?us-ascii?Q?85wzUPYT2Tgmhk9wI3RDt3j/WeHGgua4cGbZlAxnHpFubh/qkrY1HXtQwbkO?=
 =?us-ascii?Q?ZISKzLPaK3jHVs8+jHzYuVcjb1iWLpTLYWXP7GVMJ6kgWCxiP/LcYuI2BlTp?=
 =?us-ascii?Q?D+BPyLaDHbTlzBURVsWHE9hqe0jNNFlZWtgRHUDpeANkPBFlBa1bXeG7J7pr?=
 =?us-ascii?Q?ooeEmZLaTj+A0gcEAG552hFP+QjlS6huqZnBMlF5AGmBDbtzsvF8YC+ybP4T?=
 =?us-ascii?Q?B6x4hy8TBmfswAaoHD2HMgq/uj3ZQY+IYOyMmty12pMsYxw08xGV0g1eVjWA?=
 =?us-ascii?Q?X6etxKOl24IoWyadepRFVCeq0GeflW1f2OgsdtGWd3qOeP+eZ3rRHzK8s3eW?=
 =?us-ascii?Q?H/qL+00WI3vucEFf+aignMe9H/QRHEWno4hQCm6y4XZRKcls2EI/c586zTbC?=
 =?us-ascii?Q?KhWuBDod7DP+jEXbNClwTvAsBrwfcs1pvBojpePCFv/x/apLNncYi7eTiZJ2?=
 =?us-ascii?Q?E0AuX4xJpQbMQ2nND20fRJr5iMcqypqB6OuWQtcgK4eZ2YFeZZbNJg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2024 15:39:29.2655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e76979ae-80a3-4302-3fb7-08dd121e5822
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9109

Before this patch, scanning is done on entire virtual address space
of all the tasks. Now the scan size is shrunk or expanded based on the
useful pages found in the last scan.

This helps to quickly get out of unnecessary scanning thus burning
lesser CPU.

Drawback: If a useful chunk is at the other end of the VMA space, it
will delay scanning and migration.

Shrink/expand algorithm for scan_size:
X : Number of useful pages in the last scan.
Y : Number of useful pages found in current scan.
Initial scan_size is 4GB
 case 1: (X = 0, Y = 0)
  Decrease scan_size by 2
 case 2: (X = 0, Y > 0)
  Aggressively change to MAX (16GB)
 case 3: (X > 0, Y = 0 )
   No change
 case 4: (X > 0, Y > 0)
   Increase scan_size by 2

Scan size is clamped between MIN (512MB) and MAX (16GB)).
TBD:  Tuning this based on real workload

Experiment:
============
Abench microbenchmark,
- Allocates 8GB/32GB of memory on CXL node
- 64 threads created, and each thread randomly accesses pages in 4K
  granularity.
- 512 iterations.

SUT: 512 CPU, 2 node 256GB, AMD EPYC.

3 runs, command:  abench -m 2 -d 1 -i 512 -s <size>

Calculates how much time is taken to complete the task, lower is better.
Expectation is CXL node memory is expected to be migrated as fast as
possible.

Base case: 6.11-rc6    w/ numab mode = 2 (hot page promotion is enabled).
patched case: 6.11-rc6 w/ numab mode = 0 (numa balancing is disabled).
we expect daemon to do page promotion.

Result:
========
         base                    patched
         time in sec  (%stdev)   time in sec  (%stdev)     %gain
 8GB     133.66       ( 0.38 )        113.77  ( 1.83 )     14.88
32GB     584.77       ( 0.19 )        542.79  ( 0.11 )      7.17

Overhead:
The below time is calculated using patch 10. Actual overhead for patched
case may be even lesser.

               (scan + migration)  time in sec
Total memory   base kernel    patched kernel       %gain
8GB             65.743          13.93              78.8114324
32GB           153.95          132.12              14.17992855

Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 mm/kmmscand.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/mm/kmmscand.c b/mm/kmmscand.c
index 589aed604cd6..2efef53f9402 100644
--- a/mm/kmmscand.c
+++ b/mm/kmmscand.c
@@ -28,6 +28,16 @@
 static struct task_struct *kmmscand_thread __read_mostly;
 static DEFINE_MUTEX(kmmscand_mutex);
 
+/*
+ * Total VMA size to cover during scan.
+ * Min: 512MB default: 4GB max: 16GB
+ */
+#define KMMSCAND_SCAN_SIZE_MIN	(512 * 1024 * 1024UL)
+#define KMMSCAND_SCAN_SIZE_MAX	(16 * 1024 * 1024 * 1024UL)
+#define KMMSCAND_SCAN_SIZE	(4 * 1024 * 1024 * 1024UL)
+
+static unsigned long kmmscand_scan_size __read_mostly = KMMSCAND_SCAN_SIZE;
+
 /*
  * Scan period for each mm.
  * Min: 400ms default: 2sec Max: 5sec
@@ -74,6 +84,8 @@ struct kmmscand_mm_slot {
 	unsigned long next_scan;
 	/* Tracks how many useful pages obtained for migration in the last scan */
 	unsigned long scan_delta;
+	/* Determines how much VMA address space to be covered in the scanning */
+	unsigned long scan_size;
 	long address;
 };
 
@@ -484,6 +496,7 @@ static void kmmscand_migrate_folio(void)
  */
 #define KMMSCAND_IGNORE_SCAN_THR	100
 
+#define SCAN_SIZE_CHANGE_SCALE	1
 /*
  * X : Number of useful pages in the last scan.
  * Y : Number of useful pages found in current scan.
@@ -497,11 +510,22 @@ static void kmmscand_migrate_folio(void)
  *		Increase scan_period by (2 << SCAN_PERIOD_CHANGE_SCALE).
  *	case 4: (X > 0, Y > 0)
  *		Decrease scan_period by SCAN_PERIOD_TUNE_PERCENT.
+ * Tuning scan_size:
+ * Initial scan_size is 4GB
+ *	case 1: (X = 0, Y = 0)
+ *		Decrease scan_size by (1 << SCAN_SIZE_CHANGE_SCALE).
+ *	case 2: (X = 0, Y > 0)
+ *		scan_size = KMMSCAND_SCAN_SIZE_MAX
+ *  case 3: (X > 0, Y = 0 )
+ *		No change
+ *  case 4: (X > 0, Y > 0)
+ *		Increase scan_size by (1 << SCAN_SIZE_CHANGE_SCALE).
  */
 static inline void kmmscand_update_mmslot_info(struct kmmscand_mm_slot *mm_slot, unsigned long total)
 {
 	unsigned int scan_period;
 	unsigned long now;
+	unsigned long scan_size;
 	unsigned long old_scan_delta;
 
 	/* XXX: Hack to get rid of continuously failing/unmigrateable pages */
@@ -509,6 +533,7 @@ static inline void kmmscand_update_mmslot_info(struct kmmscand_mm_slot *mm_slot,
 		total = 0;
 
 	scan_period = mm_slot->scan_period;
+	scan_size = mm_slot->scan_size;
 
 	old_scan_delta = mm_slot->scan_delta;
 
@@ -522,30 +547,38 @@ static inline void kmmscand_update_mmslot_info(struct kmmscand_mm_slot *mm_slot,
 	if (!old_scan_delta && !total) {
 		scan_period = (100 + SCAN_PERIOD_TUNE_PERCENT) * scan_period;
 		scan_period /= 100;
+		scan_size = scan_size >> SCAN_SIZE_CHANGE_SCALE;
 	} else if (old_scan_delta && total) {
 		scan_period = (100 - SCAN_PERIOD_TUNE_PERCENT) * scan_period;
 		scan_period /= 100;
+		scan_size = scan_size << SCAN_SIZE_CHANGE_SCALE;
 	} else if (old_scan_delta && !total) {
 		scan_period = scan_period << SCAN_PERIOD_CHANGE_SCALE;
 	} else {
 		scan_period = scan_period >> SCAN_PERIOD_CHANGE_SCALE;
+		scan_size = KMMSCAND_SCAN_SIZE_MAX;
 	}
 
 	scan_period = clamp(scan_period, KMMSCAND_SCAN_PERIOD_MIN, KMMSCAND_SCAN_PERIOD_MAX);
+	scan_size = clamp(scan_size, KMMSCAND_SCAN_SIZE_MIN, KMMSCAND_SCAN_SIZE_MAX);
 
 	now = jiffies;
 	mm_slot->next_scan = now + msecs_to_jiffies(scan_period);
 	mm_slot->scan_period = scan_period;
+	mm_slot->scan_size = scan_size;
 	mm_slot->scan_delta = total;
 }
 
 static unsigned long kmmscand_scan_mm_slot(void)
 {
+	bool next_mm = false;
 	bool update_mmslot_info = false;
 
 	unsigned int mm_slot_scan_period;
 	unsigned long now;
 	unsigned long mm_slot_next_scan;
+	unsigned long mm_slot_scan_size;
+	unsigned long scanned_size = 0;
 	unsigned long address;
 	unsigned long folio_nr_access_s, folio_nr_access_e, total = 0;
 
@@ -572,6 +605,7 @@ static unsigned long kmmscand_scan_mm_slot(void)
 
 	mm_slot_next_scan = mm_slot->next_scan;
 	mm_slot_scan_period = mm_slot->scan_period;
+	mm_slot_scan_size = mm_slot->scan_size;
 	mm = slot->mm;
 
 	spin_unlock(&kmmscand_mm_lock);
@@ -579,8 +613,10 @@ static unsigned long kmmscand_scan_mm_slot(void)
 	if (unlikely(!mmap_read_trylock(mm)))
 		goto outerloop_mmap_lock;
 
-	if (unlikely(kmmscand_test_exit(mm)))
+	if (unlikely(kmmscand_test_exit(mm))) {
+		next_mm = true;
 		goto outerloop;
+	}
 
 	now = jiffies;
 	/*
@@ -598,8 +634,20 @@ static unsigned long kmmscand_scan_mm_slot(void)
 	for_each_vma(vmi, vma) {
 		/* Count the scanned pages here to decide exit */
 		kmmscand_walk_page_vma(vma);
-
+		scanned_size += vma->vm_end - vma->vm_start;
 		address = vma->vm_end;
+
+		if (scanned_size >= mm_slot_scan_size) {
+			folio_nr_access_e = atomic_long_read(&mm->nr_accessed);
+			total = folio_nr_access_e - folio_nr_access_s;
+			/* If we had got accessed pages, ignore the current scan_size threshold */
+			if (total > KMMSCAND_IGNORE_SCAN_THR) {
+				mm_slot_scan_size = KMMSCAND_SCAN_SIZE_MAX;
+				continue;
+			}
+			next_mm = true;
+			break;
+		}
 	}
 	folio_nr_access_e = atomic_long_read(&mm->nr_accessed);
 	total = folio_nr_access_e - folio_nr_access_s;
@@ -627,7 +675,7 @@ static unsigned long kmmscand_scan_mm_slot(void)
 	 * Release the current mm_slot if this mm is about to die, or
 	 * if we scanned all vmas of this mm.
 	 */
-	if (unlikely(kmmscand_test_exit(mm)) || !vma) {
+	if (unlikely(kmmscand_test_exit(mm)) || !vma || next_mm) {
 		/*
 		 * Make sure that if mm_users is reaching zero while
 		 * kmmscand runs here, kmmscand_exit will find
@@ -711,6 +759,7 @@ void __kmmscand_enter(struct mm_struct *mm)
 
 	kmmscand_slot->address = 0;
 	kmmscand_slot->scan_period = kmmscand_mm_scan_period_ms;
+	kmmscand_slot->scan_size = kmmscand_scan_size;
 	kmmscand_slot->next_scan = 0;
 	kmmscand_slot->scan_delta = 0;
 
-- 
2.39.3


