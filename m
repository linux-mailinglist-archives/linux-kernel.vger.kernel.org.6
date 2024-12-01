Return-Path: <linux-kernel+bounces-426654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEA89DF64D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 16:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D05FB281184
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 15:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3313F1D86C4;
	Sun,  1 Dec 2024 15:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VNrTv36v"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1D51D7E47
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733067602; cv=fail; b=DfP9NltBqtUxXigZl1PXYJvWFWxnnkJzrA88KG9wiaCA6TXY/eQZPLQM7kTO4FIM9N910DK2A46CX95mRCV/tTco8pQrxoUGQT3dgJ2z2FoQh3CT/5QnfEuWOGUcdP2y24Jpnm36noZ15E04iAx9CmGh9sIo73TD8af0d0gFpzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733067602; c=relaxed/simple;
	bh=vUMKifGphLk2rkjeITLewD7MDjD9cBi8oTvcEFCa13w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a8jk/opCWnbX9ot3j472i5WnjEX0Sohy0WOejkP9ECiEaoY5m53V5C1luTu8nLNnD04CWwgD36AVlcvyvFDkULy28JiKsJh9Rrzt/2ckcb2bjJyZ4HcLfDKkvZS0n18fMyea3TL3QliF4KFitt5wXAFqhe1raVvvB8w7pNXT2qM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VNrTv36v; arc=fail smtp.client-ip=40.107.220.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U7DXZ6v5yJrhxkR96+O9CrE5Fha5lhaxIUAM5WyfyrdJ+dViehcoe4Gj5GQD22PqkUiOKQ8DOZnKo1epyR+ZZbHR8dW14dvIv4DtZ37dXQkueLvTu6Y2P+2i+lMuLqcbJKtAZz/TAGDxXJ2RnYos8hgd8snJOUd5Vaj1303n+mw4zmgJafPDyjo4/o2vH6y0WnDYjLc7S3Ga7YtE/TQPU/CtgiO6LPFnfzxLkzQGYKb9G+eXtm42yiz3ofskWPjEgB2859284+8HUQvBpqeRqzs6KPu1miGqG4pume2AzS5VPJ3vl0RVKT9L+3j7NRVg6PDK9bI6gCd90X48DpQ4ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KPvoZ18wyLsmWIQuLjOWxUMZNiR39hSPKzJVIw8JaU=;
 b=w4ZLdPDr8dGvTnlRcyOAppeX2RlHULMXij3OF6/in0hhwONLuLKTUlx70KB0plsSTxu0+45VSE23DZ6EEZZzBJop+4KYIQxvqoQ4Dob40edJfN73DQIJHkm7s5I1hrlP5fIBqwUTR+WkqbolcjifycKQdrSAfHgyAcoEWv0eVK7Lex3EkrEuwCm2q25g8Relzy5HDCRr022N+N8i1ZxUZpKs50sAwEG0WXFkWHwvc/ITjJ5B8RkkMf1lu5/QKt7gqoZaLXdaNcGBXvwVLGPOzUvYbUWP/R41+whY/2E+RiNB/y8nyGF5BELvMQqV+JbipW0XZuN6yhoRciS4DJzmEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kvack.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KPvoZ18wyLsmWIQuLjOWxUMZNiR39hSPKzJVIw8JaU=;
 b=VNrTv36vsW4GZdK/uBhiEKIq56oHWfdk5nLtgCR+dfz1CB/gGvheeE77VxDP3emRFtKsVRrWOyGpwbl6DTuLQ2baOqHfFSOXEQHcD+w0c6wklBTDgztCC5nlx4I4LMlxPDnKlZWSg97NVHrR7Ob4zs2GZdb+yqRyry3jk6OPxAw=
Received: from CH0PR08CA0030.namprd08.prod.outlook.com (2603:10b6:610:33::35)
 by MW6PR12MB8899.namprd12.prod.outlook.com (2603:10b6:303:248::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Sun, 1 Dec
 2024 15:39:56 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:33:cafe::e8) by CH0PR08CA0030.outlook.office365.com
 (2603:10b6:610:33::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.16 via Frontend Transport; Sun,
 1 Dec 2024 15:39:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sun, 1 Dec 2024 15:39:55 +0000
Received: from tunga.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 1 Dec
 2024 09:39:48 -0600
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
Subject: [RFC PATCH V0 DO NOT MERGE 10/10] kmmscand: Add scanning
Date: Sun, 1 Dec 2024 15:38:18 +0000
Message-ID: <20241201153818.2633616-11-raghavendra.kt@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|MW6PR12MB8899:EE_
X-MS-Office365-Filtering-Correlation-Id: 9487d1b8-ca1e-4444-29d4-08dd121e67da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qRHIFNS3ZA5Ti26MqSvOA3U+lhXfOwORwh7krx2bdo1WG/e0162tr8qJHlVr?=
 =?us-ascii?Q?WXdCBNPBk0pShVTaY3V0dbVG1Sskh6SnOjCJQRnfPUOA82PibX4enD+Bak/J?=
 =?us-ascii?Q?aeBcAWbI9ZUA9XabADYADutSoa9NXv7E8goT7NCxra4x8DE8Qm09WoPF1YK+?=
 =?us-ascii?Q?0oNQvGhkylkLoaki53aIvmmlVzcdgSitcHq4biKvBR31uDdpkZFWE7Wv1ICn?=
 =?us-ascii?Q?277j8zMb/Y+Rk+vLPxODYYSvPUiALyHomWRHkatempm9w2mwc0I6+baEco1+?=
 =?us-ascii?Q?pOMJMuxYJlKMlm9lbNP5UPGOnIJIEHpj9XHYDbWFFuTRbWC1hBwf5fxQCLEU?=
 =?us-ascii?Q?jkd+QrYkngSGbZJ/CQwGDo7itKB90iuXgMhjo7jvtk0P9B0ZKYuJqswXW+DT?=
 =?us-ascii?Q?F+EGsRhoNTlkHVIfo4rQp9Xa8it+KqAqgb1ryW9QM60InxElYjuEgDTxwt+Z?=
 =?us-ascii?Q?G9Ygk+4zIvVXk4WsBm/uN34P3m/N6KduI0V7mXXvTtF5qvUhANXzqJab42ZI?=
 =?us-ascii?Q?jvFz6VhonyK2R4oKvyh351yqpOnFduEoMoQ2czNakM7eimrNTYa343A6+O9r?=
 =?us-ascii?Q?NUTKHY84uswbN2qtoXYpr+Cxg/RdBjidlHTbNrV8EVXj24oGJok/QXL405zx?=
 =?us-ascii?Q?fH9rE1izR8Kh+7fecKIZgVc6qcIA0n/rOn5DjVsPSMphXImnjkiEn4j1ZVYT?=
 =?us-ascii?Q?NiKXgdneSmx1LdBKUFCyJ18RVap9T6llTg/oE5O/j7iErb5b+hLXvb0/M2os?=
 =?us-ascii?Q?Zh3fY0N6qBgpO6M7im6C6TPfUi1fPJc9dziP0Fva/0wCk5Cu6luGn2obBn1v?=
 =?us-ascii?Q?2kMqu801CNw7kbFo0fTc0mkHpyr7EWLik7VncZNIp3nI+ve1PpfOZt6keyEA?=
 =?us-ascii?Q?Pud+nyfTlbXbTDCurKIhsSJBtjw/tNeFhX8JK08pOaCPHHsbOPJWD0cgKT6O?=
 =?us-ascii?Q?bd4PPGzmNOhV5yCBl+ieNspzfihc9CkVRt5rTgGABpWBr2WG8jfRsGCSrSu1?=
 =?us-ascii?Q?u8sUK5DjId3HTz1xO/ngexKOhSw0x9GihXwjmDgp2xa/XaR9S7nffFv6NFHG?=
 =?us-ascii?Q?Fpni9JYDCu6raSwS3jN2JXCPWxD4I+mreHj3+a9Z+xrMMYSjbtihrVSmDZoo?=
 =?us-ascii?Q?1xSYt08sZDxHzLzfp4AzkEdi0/eanCK06TlTzHsdKJXoBLJKCchoc91LZDqY?=
 =?us-ascii?Q?RWRQZ0tKNR8epFIpgoCXd9z80nHnzqKhK4KhF/os5QVwHFmdtJZV7L5L0YfD?=
 =?us-ascii?Q?K+OGVnc0HB5azKzmcZWrdQArQgdjjgq/fZVoXa53g/JZupLwFbbPn7VWxo7s?=
 =?us-ascii?Q?5R+DfR//NhB7oLNjwmMFsnlpl8/Y+E1t8W2Q0SinKoSuDDZNCPy4IMVK+ubD?=
 =?us-ascii?Q?KOa/byqGy8XRaaJqMR1i4yzoNXNsB0j4d/kbZ6trFZVxdKMdsvqW8YEdDmNE?=
 =?us-ascii?Q?yYXPgpHF50Phxa32M6EItnsPFOXBhKPrsiGBFhk/aHCM4NFi+sWkXg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2024 15:39:55.6366
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9487d1b8-ca1e-4444-29d4-08dd121e67da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8899

overhead caclulation support

Intended to be used only for experimental purpose.
Not to be merged.

Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 include/linux/mm.h            |  3 +++
 include/linux/vm_event_item.h |  4 ++++
 kernel/sched/fair.c           | 13 ++++++++-----
 mm/huge_memory.c              |  1 +
 mm/kmmscand.c                 |  9 +++++++++
 mm/memory.c                   | 12 ++++++++----
 mm/vmstat.c                   |  4 ++++
 7 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 306452c11d31..7380aab1fa62 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -600,6 +600,7 @@ struct vm_fault {
 					 * page table to avoid allocation from
 					 * atomic context.
 					 */
+	unsigned long start_time;
 };
 
 /*
@@ -690,6 +691,8 @@ void count_kmmscand_migrate_failed(void);
 void count_kmmscand_slowtier(void);
 void count_kmmscand_toptier(void);
 void count_kmmscand_idlepage(void);
+void count_kmmscand_scan_oh(long delta);
+void count_kmmscand_migration_oh(long delta);
 #endif
 
 #ifdef CONFIG_NUMA_BALANCING
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index b2ccd4f665aa..4c7eaea01f13 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -64,6 +64,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		NUMA_HINT_FAULTS,
 		NUMA_HINT_FAULTS_LOCAL,
 		NUMA_PAGE_MIGRATE,
+		NUMA_TASK_WORK_OH,
+		NUMA_HF_MIGRATION_OH,
 #endif
 #ifdef CONFIG_KMMSCAND
 		KMMSCAND_MM_SCANS,
@@ -74,6 +76,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		KMMSCAND_SLOWTIER,
 		KMMSCAND_TOPTIER,
 		KMMSCAND_IDLEPAGE,
+		KMMSCAND_SCAN_OH,
+		KMMSCAND_MIGRATION_OH,
 #endif
 #ifdef CONFIG_MIGRATION
 		PGMIGRATE_SUCCESS, PGMIGRATE_FAIL,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fbdca89c677f..d205be30ae6c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3299,6 +3299,7 @@ static void task_numa_work(struct callback_head *work)
 	struct vma_iterator vmi;
 	bool vma_pids_skipped;
 	bool vma_pids_forced = false;
+	unsigned long old = jiffies;
 
 	SCHED_WARN_ON(p != container_of(work, struct task_struct, numa_work));
 
@@ -3312,7 +3313,7 @@ static void task_numa_work(struct callback_head *work)
 	 * work.
 	 */
 	if (p->flags & PF_EXITING)
-		return;
+		goto out1;
 
 	if (!mm->numa_next_scan) {
 		mm->numa_next_scan = now +
@@ -3324,7 +3325,7 @@ static void task_numa_work(struct callback_head *work)
 	 */
 	migrate = mm->numa_next_scan;
 	if (time_before(now, migrate))
-		return;
+		goto out1;
 
 	if (p->numa_scan_period == 0) {
 		p->numa_scan_period_max = task_scan_max(p);
@@ -3333,7 +3334,7 @@ static void task_numa_work(struct callback_head *work)
 
 	next_scan = now + msecs_to_jiffies(p->numa_scan_period);
 	if (!try_cmpxchg(&mm->numa_next_scan, &migrate, next_scan))
-		return;
+		goto out1;
 
 	/*
 	 * Delay this task enough that another task of this mm will likely win
@@ -3345,11 +3346,11 @@ static void task_numa_work(struct callback_head *work)
 	pages <<= 20 - PAGE_SHIFT; /* MB in pages */
 	virtpages = pages * 8;	   /* Scan up to this much virtual space */
 	if (!pages)
-		return;
+		goto out1;
 
 
 	if (!mmap_read_trylock(mm))
-		return;
+		goto out1;
 
 	/*
 	 * VMAs are skipped if the current PID has not trapped a fault within
@@ -3526,6 +3527,8 @@ static void task_numa_work(struct callback_head *work)
 		u64 diff = p->se.sum_exec_runtime - runtime;
 		p->node_stamp += 32 * diff;
 	}
+out1:
+	__count_vm_events(NUMA_TASK_WORK_OH, jiffies_to_usecs(jiffies - old));
 }
 
 void init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ee335d96fc39..d948d1fbbffd 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1250,6 +1250,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 		spin_unlock(vmf->ptl);
 	}
 
+	__count_vm_events(NUMA_HF_MIGRATION_OH, jiffies_to_usecs(jiffies - vmf->start_time));
 	return 0;
 unlock_release:
 	spin_unlock(vmf->ptl);
diff --git a/mm/kmmscand.c b/mm/kmmscand.c
index 70f588a210dd..bd2c65f38da2 100644
--- a/mm/kmmscand.c
+++ b/mm/kmmscand.c
@@ -644,8 +644,10 @@ static void kmmscand_cleanup_migration_list(struct mm_struct *mm)
 static void kmmscand_migrate_folio(void)
 {
 	int ret = 0;
+	unsigned long tstart, tend;
 	struct kmmscand_migrate_info *info, *tmp;
 
+	tstart = jiffies;
 	spin_lock(&kmmscand_migrate_lock);
 
 	if (!list_empty(&kmmscand_migrate_list.migrate_head)) {
@@ -691,6 +693,8 @@ static void kmmscand_migrate_folio(void)
 		}
 	}
 	spin_unlock(&kmmscand_migrate_lock);
+	tend = jiffies;
+	__count_vm_events(KMMSCAND_MIGRATION_OH, jiffies_to_usecs(tend - tstart));
 }
 
 /*
@@ -788,6 +792,8 @@ static unsigned long kmmscand_scan_mm_slot(void)
 
 	unsigned int mm_slot_scan_period;
 	unsigned long now;
+
+	unsigned long tstart, tend;
 	unsigned long mm_slot_next_scan;
 	unsigned long mm_slot_scan_size;
 	unsigned long scanned_size = 0;
@@ -800,6 +806,7 @@ static unsigned long kmmscand_scan_mm_slot(void)
 	struct vm_area_struct *vma = NULL;
 	struct kmmscand_mm_slot *mm_slot;
 
+	tstart  = jiffies;
 	/* Retrieve mm */
 	spin_lock(&kmmscand_mm_lock);
 
@@ -917,6 +924,8 @@ static unsigned long kmmscand_scan_mm_slot(void)
 	}
 
 	spin_unlock(&kmmscand_mm_lock);
+	tend = jiffies;
+	__count_vm_events(KMMSCAND_SCAN_OH, jiffies_to_usecs(tend - tstart));
 	return total;
 }
 
diff --git a/mm/memory.c b/mm/memory.c
index 75c2dfd04f72..baea436124b0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5590,7 +5590,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 
 	if (unlikely(!pte_same(old_pte, vmf->orig_pte))) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
-		return 0;
+		goto out;
 	}
 
 	pte = pte_modify(old_pte, vma->vm_page_prot);
@@ -5629,17 +5629,18 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 		nid = target_nid;
 		flags |= TNF_MIGRATED;
 		task_numa_fault(last_cpupid, nid, nr_pages, flags);
-		return 0;
+		goto out;
 	}
 
 	flags |= TNF_MIGRATE_FAIL;
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
 				       vmf->address, &vmf->ptl);
 	if (unlikely(!vmf->pte))
-		return 0;
+		goto out;
+
 	if (unlikely(!pte_same(ptep_get(vmf->pte), vmf->orig_pte))) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
-		return 0;
+		goto out;
 	}
 out_map:
 	/*
@@ -5656,6 +5657,8 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 
 	if (nid != NUMA_NO_NODE)
 		task_numa_fault(last_cpupid, nid, nr_pages, flags);
+out:
+	__count_vm_events(NUMA_HF_MIGRATION_OH, jiffies_to_usecs(jiffies - vmf->start_time));
 	return 0;
 }
 
@@ -5858,6 +5861,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		.flags = flags,
 		.pgoff = linear_page_index(vma, address),
 		.gfp_mask = __get_fault_gfp_mask(vma),
+		.start_time = jiffies,
 	};
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long vm_flags = vma->vm_flags;
diff --git a/mm/vmstat.c b/mm/vmstat.c
index d758e7155042..b7fe51342970 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1339,6 +1339,8 @@ const char * const vmstat_text[] = {
 	"numa_hint_faults",
 	"numa_hint_faults_local",
 	"numa_pages_migrated",
+	"numa_task_work_oh",
+	"numa_hf_migration_oh",
 #endif
 #ifdef CONFIG_KMMSCAND
 	"nr_kmmscand_mm_scans",
@@ -1349,6 +1351,8 @@ const char * const vmstat_text[] = {
 	"nr_kmmscand_slowtier",
 	"nr_kmmscand_toptier",
 	"nr_kmmscand_idlepage",
+	"kmmscand_scan_oh",
+	"kmmscand_migration_oh",
 #endif
 #ifdef CONFIG_MIGRATION
 	"pgmigrate_success",
-- 
2.39.3


