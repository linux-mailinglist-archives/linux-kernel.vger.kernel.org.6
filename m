Return-Path: <linux-kernel+bounces-426647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D76E59DF646
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 16:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 316D9B21927
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 15:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B8018AEA;
	Sun,  1 Dec 2024 15:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fSCkw3cU"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053CF1494DD
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 15:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733067557; cv=fail; b=tzPY6QOUYTom7mX0y1HfQFN2W+zrmRmsHRW52gOziSJ7uCTlehQtUDTP/yS+/FzyeRBfhXSjIDtf/YY4o1kTU5pqgGijBeEUcX9HppfAtlYADc/y+HgiXHY4e/037JDvzMuZsJ6joFYopqT6x7M/Fq+z6hOeIipwUIqYc5poWG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733067557; c=relaxed/simple;
	bh=FWT2RbyW5fpOd7+VBI6RDDWiseonuI1NviEWMWwWQxU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oT/nYYDSlujlY8IeWiwYNahR1Q9uJfFs9T26rmr6FTvo4deLVMgaCLin3Z99nlAa0KHBcKRrfMItPZw22j5MCmE5IojwlHqc0yw4v5DfzMapRotpEMSPZVYiOMDKJ9F9EMzWmErZxPElBvFJlEi+Hv0F5tivKoUfl7k+9N/8J/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fSCkw3cU; arc=fail smtp.client-ip=40.107.92.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=syGeH+gKJgDqE7aysx9U6Z0bB2HqRrtiiv7quCdbiYReQQjqzriVDRkpNNiSvkNao4YkyhEPVjHPSvWs4bYioNaJx8zmX5pJ/3lcjQDkQpjiiQcFduwgNiDTzWE+zTxJ11/3W30mr9MrRzAt0lKnz6P0RtuHU2T0xiZCydFXqmRQyCA9WoZuI9OLI7JDi6qmvQ9x+ujCA8Vz6Pom7IGCyT5DBcUZSzUOB9+w57WDBEVEsLGNmD2tfF+d1joqcjdpPv9U2Ibj9Dp0kr1X4webr50mT5E2zA9bo+ECLVydtHcxq9460jIiWpEqpz+kvKiHsy2qVX0aVFs0V0jbynfxTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3EzOrANg4iCE+eMwCm/oM95tbuBSCOb5dUX6vHV3Qk=;
 b=yPShB/E8V/tCWx3dq786jK41SFxdccRxJVFLGkDk2XIqf/HBS1ObOb4Q5HhadDjzeGKfjc22TOk19brqPLzKTqiffLawLwjo6xOujQogltmo0jiFtx+vA0B0yui5KpClJSXz7R4hSVNFG1z6JMuNU/Y8DSGBJfBA1S3ftikmboiM4lxhYx+Udc66B+Cc2r7fBy4wLBpwewcz27TKnPxTsz8HWQNE8JegmKo3/s2ANwiBp8loDRBpHaMSZXv1ouSb9YoRfvLbOvRbkh3pLF5kHrecJIEpJfwJS5XZiUdsHfQRXuJqBg6O4gycYRsb/VT/m2g7w0ijDd4wVQtqm/Xo6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kvack.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3EzOrANg4iCE+eMwCm/oM95tbuBSCOb5dUX6vHV3Qk=;
 b=fSCkw3cUeIDnNCP3YdvcVXpStLU9kT+jaOn15dr973dKYm6J6YnN3K9fa6VFCJLb6gETXotTCkEWklBs54dT+mwz1FHxGS9faPeOtRfrh9gwbjpm3fBJiQ+nAKiZEAsCwMri5p3FJtjULP6n/v+Yo8E1y4hmu/qvYzgTvXk8CGA=
Received: from SJ0PR03CA0190.namprd03.prod.outlook.com (2603:10b6:a03:2ef::15)
 by IA1PR12MB6412.namprd12.prod.outlook.com (2603:10b6:208:3af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Sun, 1 Dec
 2024 15:39:10 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::75) by SJ0PR03CA0190.outlook.office365.com
 (2603:10b6:a03:2ef::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.15 via Frontend Transport; Sun,
 1 Dec 2024 15:39:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.1 via Frontend Transport; Sun, 1 Dec 2024 15:39:10 +0000
Received: from tunga.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 1 Dec
 2024 09:39:02 -0600
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
Subject: [RFC PATCH V0 03/10] mm: Scan the mm and create a migration list
Date: Sun, 1 Dec 2024 15:38:11 +0000
Message-ID: <20241201153818.2633616-4-raghavendra.kt@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|IA1PR12MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: d5669c10-1f3d-411e-08b9-08dd121e4cd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wcg2HOEFQwkfbNvf+WHCIRz5/Qxg20G66Dn9ZbJ4zwcEqNmZV0YpLt3e7PD0?=
 =?us-ascii?Q?wid7dlFa8XGPAevX37fgiU8SD8eZdYReHL62U5iPgA5HVVqGfUqr/YnwW7kV?=
 =?us-ascii?Q?nPXfJeLb7HZFY/690TfWYNOqW2uJtjbE3OIGyqELGz0vBhILYRMfnCMDZFbV?=
 =?us-ascii?Q?LScv5NgA525XdEZQGo6yhU/cUibe4FEZn+kYFiW7UWmNSVggjw2/nqlrsvdl?=
 =?us-ascii?Q?DHdus3yNen7flSPSGnqbLM08L79f7ZqX66Oc117bOEV5NuSeFbuiSDnUQyfC?=
 =?us-ascii?Q?VPHxBUwE20VOTTFNOHKf3/5k54EjRXlF3bdE5306FcNweiwxJnfBM8I6NOLP?=
 =?us-ascii?Q?SRTkhB9UaGQXwgfpn8X37S8vrA2Jm9OVaNiSOkbFZG5DBIN7bNsbon9nLpWG?=
 =?us-ascii?Q?tz0WdlQVIFKeg+gSGwD+prrAUDN99ESsh7kulUm56xqNDWDGSXjm5JHCsikM?=
 =?us-ascii?Q?cPVSAujFSCgISUoTrwT01amvbG+Bq6mTldyBBEX1ZXgh7WkEtqZezW0py07L?=
 =?us-ascii?Q?l4/JY2zORCwmbe62VAwMk/QW9f7l/PoLEi3qv6ZGOaRWGGxk2W3IOB5UlqoY?=
 =?us-ascii?Q?ew5LrLe/qOVVksldY3Fyu9al2taD1vjva9N+2S+VWzCT9cPFv/tvXg4ArjHl?=
 =?us-ascii?Q?EcLYc7er8jGXy2VUYmiU2R09bVMLNneG+HVN+sTmnqXcPhew2jf2NI+q9+fM?=
 =?us-ascii?Q?sdXvofFgb7DNe97ODTvwDd+ugDzJOwAJEB86OgSsCrdbsWfwIeyj5mL2e541?=
 =?us-ascii?Q?HS7haYt6G2tyKxLPHLx0kuH5xK6Hbzko2+ncCGOONVTRJmd3WgoRJTTpDKSX?=
 =?us-ascii?Q?X+OQeWcaa+27PhUhUL8MaoqHMBRZ5it8RkhHMJsJPoEwQebEkGAURzJYkHQI?=
 =?us-ascii?Q?RYiHeKpS2VzoOC1SgGEBpkVLWnLZJo0X0H0ceqeSQ0kJB/Dqm0ciCI8ENeM7?=
 =?us-ascii?Q?dbk4xQAUZx1kSRVpIJWHzMfwRTPR09hVFm1iN9f4lUbcvOD8YVyuFcD05w14?=
 =?us-ascii?Q?70P2Fc9tkdwHEuHyCTf0SvKnLNiVN2lvxsT7eOUgmBKcCcG/fRL1WFuOPlRE?=
 =?us-ascii?Q?IV3GwSRvLZZB83ZQ0cUiSSK3hW6K65KTuXCnop437BIp6CsVnhHG6D9pk3xN?=
 =?us-ascii?Q?pcVHyDWEgRWbIGlSkcc2BVzC+VyALW6hgDvODas7bU7HBfU4YoQHOGbQWMhZ?=
 =?us-ascii?Q?xOT2lfk6Q62hpal7IK90KBnBVhKstka4SeXynxobJlEeRUjng87m9wm7IQ7S?=
 =?us-ascii?Q?IMPFJkCjYcfl/OI6ZRYigilvXNbVrBnduZBHKa1BxNZWJXV5blAN5TWykwaN?=
 =?us-ascii?Q?dY6CNgjxf8fDnGAP+qaq/8RtMQInIkvlIlkaPeW8J7mgEqzmj1YL+SmN6pud?=
 =?us-ascii?Q?18KZ0C+9dnIhYoZLOiZAczZeUaY7YM7JxeLyHEufPUvaVr6ZPD9b912edFk3?=
 =?us-ascii?Q?RGkrAV82EJqdvjtOQkc6gHR22tPSQS8b?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2024 15:39:10.1690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5669c10-1f3d-411e-08b9-08dd121e4cd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6412

Since we already have list of mm_struct in the system, add a module to
scan each mm that walks VMAs of each mm_struct and scan all the pages
associated with that.

 In the scan path: Check for the recently acccessed pages (folios) belonging to
slowtier nodes. Add all those folios to a migration list.

Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 mm/kmmscand.c | 268 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 264 insertions(+), 4 deletions(-)

diff --git a/mm/kmmscand.c b/mm/kmmscand.c
index 957128d4e425..0496359d07f5 100644
--- a/mm/kmmscand.c
+++ b/mm/kmmscand.c
@@ -4,12 +4,19 @@
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
 #include <linux/mmu_notifier.h>
+#include <linux/rmap.h>
+#include <linux/pagewalk.h>
+#include <linux/page_ext.h>
+#include <linux/page_idle.h>
+#include <linux/page_table_check.h>
+#include <linux/pagemap.h>
 #include <linux/swap.h>
 #include <linux/mm_inline.h>
 #include <linux/kthread.h>
 #include <linux/kmmscand.h>
+#include <linux/memory-tiers.h>
+#include <linux/mempolicy.h>
 #include <linux/string.h>
-#include <linux/delay.h>
 #include <linux/cleanup.h>
 
 #include <asm/pgalloc.h>
@@ -32,6 +39,7 @@ static bool need_wakeup;
 static unsigned long kmmscand_sleep_expire;
 
 static DEFINE_SPINLOCK(kmmscand_mm_lock);
+static DEFINE_SPINLOCK(kmmscand_migrate_lock);
 static DECLARE_WAIT_QUEUE_HEAD(kmmscand_wait);
 
 #define KMMSCAND_SLOT_HASH_BITS 10
@@ -41,6 +49,7 @@ static struct kmem_cache *kmmscand_slot_cache __read_mostly;
 
 struct kmmscand_mm_slot {
 	struct mm_slot slot;
+	long address;
 };
 
 struct kmmscand_scan {
@@ -52,6 +61,21 @@ struct kmmscand_scan kmmscand_scan = {
 	.mm_head = LIST_HEAD_INIT(kmmscand_scan.mm_head),
 };
 
+struct kmmscand_migrate_list {
+	struct list_head migrate_head;
+};
+
+struct kmmscand_migrate_list kmmscand_migrate_list = {
+	.migrate_head = LIST_HEAD_INIT(kmmscand_migrate_list.migrate_head),
+};
+
+struct kmmscand_migrate_info {
+	struct list_head migrate_node;
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;
+	struct folio *folio;
+	unsigned long address;
+};
 static int kmmscand_has_work(void)
 {
 	return !list_empty(&kmmscand_scan.mm_head);
@@ -84,8 +108,140 @@ static void kmmscand_wait_work(void)
 	}
 }
 
-static void kmmscand_migrate_folio(void)
+static bool kmmscand_eligible_srcnid(int nid)
 {
+	if (!node_is_toptier(nid))
+		return true;
+	return false;
+}
+
+static bool folio_idle_clear_pte_refs_one(struct folio *folio,
+					 struct vm_area_struct *vma,
+					 unsigned long addr,
+					 pte_t *ptep)
+{
+	bool referenced = false;
+	struct mm_struct *mm = vma->vm_mm;
+	pmd_t *pmd = pmd_off(mm, addr);
+
+	if (ptep) {
+		if (ptep_clear_young_notify(vma, addr, ptep))
+			referenced = true;
+	} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
+		if (!pmd_present(*pmd))
+			WARN_ON_ONCE(1);
+		if (pmdp_clear_young_notify(vma, addr, pmd))
+			referenced = true;
+	} else {
+		WARN_ON_ONCE(1);
+	}
+
+	if (referenced) {
+		folio_clear_idle(folio);
+		folio_set_young(folio);
+	}
+	return true;
+}
+
+static void page_idle_clear_pte_refs(struct page *page, pte_t *pte, struct mm_walk *walk)
+{
+	bool need_lock;
+	struct folio *folio =  page_folio(page);
+	unsigned long address;
+
+	if (!folio_mapped(folio) || !folio_raw_mapping(folio))
+		return;
+
+	need_lock = !folio_test_anon(folio) || folio_test_ksm(folio);
+	if (need_lock && !folio_trylock(folio))
+		return;
+	address = vma_address(walk->vma, page_pgoff(folio, page), compound_nr(page));
+	VM_BUG_ON_VMA(address == -EFAULT, vma);
+	folio_idle_clear_pte_refs_one(folio, walk->vma, address, pte);
+
+	if (need_lock)
+		folio_unlock(folio);
+}
+
+static int hot_vma_idle_pte_entry(pte_t *pte,
+				 unsigned long addr,
+				 unsigned long next,
+				 struct mm_walk *walk)
+{
+	struct page *page;
+	struct folio *folio;
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;
+	struct kmmscand_migrate_info *info;
+	struct kmmscand_migrate_list *migrate_list = walk->private;
+	int srcnid;
+
+	pte_t pteval = ptep_get(pte);
+
+	if (pte_none(pteval))
+		return 1;
+	vma = walk->vma;
+	mm = vma->vm_mm;
+	page = pte_page(*pte);
+
+	page_idle_clear_pte_refs(page, pte, walk);
+
+	folio = page_folio(page);
+	folio_get(folio);
+
+	if (!folio || folio_is_zone_device(folio)) {
+		folio_put(folio);
+		return 1;
+	}
+
+	srcnid = folio_nid(folio);
+
+	if (!folio_test_idle(folio) || folio_test_young(folio) ||
+			mmu_notifier_test_young(mm, addr) ||
+			folio_test_referenced(folio) || pte_young(pteval)) {
+
+		/* Do not try to promote pages from regular nodes */
+		if (!kmmscand_eligible_srcnid(srcnid))
+			goto end;
+
+		info = kzalloc(sizeof(struct kmmscand_migrate_info), GFP_KERNEL);
+		if (info && migrate_list) {
+
+			info->mm = mm;
+			info->vma = vma;
+			info->folio = folio;
+
+			spin_lock(&kmmscand_migrate_lock);
+			list_add_tail(&info->migrate_node, &migrate_list->migrate_head);
+			spin_unlock(&kmmscand_migrate_lock);
+		}
+	}
+end:
+	folio_set_idle(folio);
+	folio_put(folio);
+	return 0;
+}
+
+static const struct mm_walk_ops hot_vma_set_idle_ops = {
+	.pte_entry = hot_vma_idle_pte_entry,
+	.walk_lock = PGWALK_RDLOCK,
+};
+
+static void kmmscand_walk_page_vma(struct vm_area_struct *vma)
+{
+	if (!vma_migratable(vma) || !vma_policy_mof(vma) ||
+	    is_vm_hugetlb_page(vma) || (vma->vm_flags & VM_MIXEDMAP)) {
+		return;
+	}
+
+	if (!vma->vm_mm ||
+	    (vma->vm_file && (vma->vm_flags & (VM_READ|VM_WRITE)) == (VM_READ)))
+		return;
+
+	if (!vma_is_accessible(vma))
+		return;
+
+	walk_page_vma(vma, &hot_vma_set_idle_ops, &kmmscand_migrate_list);
 }
 
 static inline int kmmscand_test_exit(struct mm_struct *mm)
@@ -93,10 +249,113 @@ static inline int kmmscand_test_exit(struct mm_struct *mm)
 	return atomic_read(&mm->mm_users) == 0;
 }
 
+static void kmmscand_collect_mm_slot(struct kmmscand_mm_slot *mm_slot)
+{
+	struct mm_slot *slot = &mm_slot->slot;
+	struct mm_struct *mm = slot->mm;
+
+	lockdep_assert_held(&kmmscand_mm_lock);
+
+	if (kmmscand_test_exit(mm)) {
+		/* free mm_slot */
+		hash_del(&slot->hash);
+		list_del(&slot->mm_node);
+
+		mm_slot_free(kmmscand_slot_cache, mm_slot);
+		mmdrop(mm);
+	}
+}
+
+static void kmmscand_migrate_folio(void)
+{
+}
+
 static unsigned long kmmscand_scan_mm_slot(void)
 {
-	/* placeholder for scanning */
-	msleep(100);
+	bool update_mmslot_info = false;
+
+	unsigned long address;
+
+	struct mm_slot *slot;
+	struct mm_struct *mm;
+	struct vma_iterator vmi;
+	struct vm_area_struct *vma = NULL;
+	struct kmmscand_mm_slot *mm_slot;
+
+	/* Retrieve mm */
+	spin_lock(&kmmscand_mm_lock);
+
+	if (kmmscand_scan.mm_slot) {
+		mm_slot = kmmscand_scan.mm_slot;
+		slot = &mm_slot->slot;
+		address = mm_slot->address;
+	} else {
+		slot = list_entry(kmmscand_scan.mm_head.next,
+				     struct mm_slot, mm_node);
+		mm_slot = mm_slot_entry(slot, struct kmmscand_mm_slot, slot);
+		address = mm_slot->address;
+		kmmscand_scan.mm_slot = mm_slot;
+	}
+
+	mm = slot->mm;
+
+	spin_unlock(&kmmscand_mm_lock);
+
+	if (unlikely(!mmap_read_trylock(mm)))
+		goto outerloop_mmap_lock;
+
+	if (unlikely(kmmscand_test_exit(mm)))
+		goto outerloop;
+
+
+	vma_iter_init(&vmi, mm, address);
+
+	for_each_vma(vmi, vma) {
+		/* Count the scanned pages here to decide exit */
+		kmmscand_walk_page_vma(vma);
+
+		address = vma->vm_end;
+	}
+
+	if (!vma)
+		address = 0;
+
+	update_mmslot_info = true;
+
+outerloop:
+	/* exit_mmap will destroy ptes after this */
+	mmap_read_unlock(mm);
+
+outerloop_mmap_lock:
+	spin_lock(&kmmscand_mm_lock);
+	VM_BUG_ON(kmmscand_scan.mm_slot != mm_slot);
+
+	if (update_mmslot_info)
+		mm_slot->address = address;
+	/*
+	 * Release the current mm_slot if this mm is about to die, or
+	 * if we scanned all vmas of this mm.
+	 */
+	if (unlikely(kmmscand_test_exit(mm)) || !vma) {
+		/*
+		 * Make sure that if mm_users is reaching zero while
+		 * kmmscand runs here, kmmscand_exit will find
+		 * mm_slot not pointing to the exiting mm.
+		 */
+		if (slot->mm_node.next != &kmmscand_scan.mm_head) {
+			slot = list_entry(slot->mm_node.next,
+					struct mm_slot, mm_node);
+			kmmscand_scan.mm_slot =
+				mm_slot_entry(slot, struct kmmscand_mm_slot, slot);
+
+		} else
+			kmmscand_scan.mm_slot = NULL;
+
+		if (kmmscand_test_exit(mm))
+			kmmscand_collect_mm_slot(mm_slot);
+	}
+
+	spin_unlock(&kmmscand_mm_lock);
 	return 0;
 }
 
@@ -159,6 +418,7 @@ void __kmmscand_enter(struct mm_struct *mm)
 	if (!kmmscand_slot)
 		return;
 
+	kmmscand_slot->address = 0;
 	slot = &kmmscand_slot->slot;
 
 	spin_lock(&kmmscand_mm_lock);
-- 
2.39.3


