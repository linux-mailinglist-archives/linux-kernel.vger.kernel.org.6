Return-Path: <linux-kernel+bounces-568702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF39A69977
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3921E42465F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EC721A95D;
	Wed, 19 Mar 2025 19:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L2lXQwqg"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8045218AA3
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412761; cv=fail; b=rzxbDi3gn1IUlYUR4zqmK688ySzJwWsEoXO24ucw9nYLD/P3LH2326bmcpvCo3fvgUJELfHYO0ERrvusRIRDWRVmeaRNsknHydFxIgapO2vHz8HEhsuXDIO98FXbJXZd5LDLasQMY++VTA8fLKVhPcxjzdZg0cGN1/UWZ2Zz7wM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412761; c=relaxed/simple;
	bh=Ea7kqqzHF5klzC94BE/SaIJNEU6+sSe9LZg3e6WgOCM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fbyoYZznWket74QLiiEFe7K4xmlUg7B0uyntYx5L8tcI8hr3xiqs0dLXrX2A0OsyhsKejUNcMkJb1KwcD4qHmyp6ECvyj0njQmS2Jzm0QlxAJyuO74iWhk5SLa6AaWeLaatwlwJxjOzLobhx6Wa70lV28DP9ZY4Hqa3Fai8geOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L2lXQwqg; arc=fail smtp.client-ip=40.107.236.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MqGRPycymWQayi5YBWyQAECzfD0Igb5HuJ1v8IUah1ESpXcTRjPE/1a6KfmWVGaXbpfEcr6DaRor8rRB9eNoaO3X/cYF1lQXZ/4GYLPqmLlf2tTQys5S1YysfYvxO769C9iA7fpKjqGEyZiGbwGtXVbZ3Mzi/12uOYBjYZGyQ3+u6rCUZm/y2K+rEuH4PBIDpioYawKic8xPVTTi5uZvsiU6yN0a1MMqnqv++a2cI51N5feHP7Fyca9W/dbbGDYhVeY9CYixxJxW38dlbq11FLxU7zRoYUaW2Ord3Zl0M/apxxasCgAwn1d798JHCNBRO8HkGe61490+lTzVbvspzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3JobkGtP3Dd44LrrvsSjv2D3CsygQXYXyfCaumfB9Hk=;
 b=lfisZdkpKVMdNpvdLTaxf4Z70bEXrcXO7ygHjYpIOiYPlHGB5syIa5rB5IPdn9ItR8Ca2hORVmKDtoF6M0nTUVd4Kh8uHf3E135cB+Li5HLYmCgGXDjZAJ0Bcs6treIpRCvsc9AzvjhS2TfsCU5gbsTRtSu476/ka0MN5f48nM3Xg7PPdySze+KO7rR4/IXP7zeFTKuPHp6yABBZ8BERaqzPbK9el4vslcAKKAN8uUA1EfMxqmSACtQ7554FgA4GA0WZrhM4VbyhorobjIlylBVQg8E7+N1gMP4TG19rfH99OtSP/tM0l+JmKecUIDUMutMzieVBYA+7IZ4T+1csxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arm.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JobkGtP3Dd44LrrvsSjv2D3CsygQXYXyfCaumfB9Hk=;
 b=L2lXQwqgg3ziT7XgoNHqKtaFbmXyDj68hmkdNeNou/eETuOQJf0V74A7tEFeVFgrnLsnbnJ/6nWv8nrt4Ia9B2LI3I5wcER8omV+r3ybIe5zDheECHdN1Zs/Mq9NU3Yz2W4fs4LSKveNLY6G1YyYwJ4zrK5g6WLm0MVY0cvj8wM=
Received: from SA9PR13CA0096.namprd13.prod.outlook.com (2603:10b6:806:24::11)
 by MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 19:32:32 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:24:cafe::be) by SA9PR13CA0096.outlook.office365.com
 (2603:10b6:806:24::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 19:32:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 19:32:31 +0000
Received: from tunga.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 14:32:21 -0500
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
Subject: [RFC PATCH V1 09/13] mm: Add heuristic to calculate target node
Date: Wed, 19 Mar 2025 19:30:24 +0000
Message-ID: <20250319193028.29514-10-raghavendra.kt@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|MN2PR12MB4110:EE_
X-MS-Office365-Filtering-Correlation-Id: 89c7117f-eac1-4ed3-7784-08dd671ccae1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?epnti3YhX8xkc7q4GWx1wq3kfO81RLoY3glgj+4tJV44spY3HwAKppiQO7/K?=
 =?us-ascii?Q?YM4+dk+jZFH/PCtXjS+byH884CxZqpGzwFpck+TfRfycWqA7MOZypkWVVbT9?=
 =?us-ascii?Q?mCC7dyldfY76kBFsuMH8B767I1+6PFjieR8O7zwa4PmrBnLkjPJUcakzWFtc?=
 =?us-ascii?Q?lBorCyknsiPqN0KwsCIpattrMcLmLXbcWtwAby6gNWetKHT3OugXD4kICgZG?=
 =?us-ascii?Q?47COWjBnSezE7evblWVscKkpC29e4TpOH7W9pu8RFMDbwytF0ygm/O//zc0m?=
 =?us-ascii?Q?VK7iNtttWKXZWUKz/0+7BvzRlRo7/0IcShIpnw0hNCm5I7G241CYjyrGMWl2?=
 =?us-ascii?Q?fQ5Y2eTUYEZKdQMWaAFzhe1+Wgo9SVY7vTGGFfpXCZB8kpEMVreLv6WjRx5K?=
 =?us-ascii?Q?/HD/JuIOy6/1bK+IH4Y5covYUmwkVBfeiZVoRypSxRyfn1kr/soQ+Uhpgogl?=
 =?us-ascii?Q?rstWV7KRfMjBVTVnJXgLHw49ObNqeWN3AE6J4IJUzVJFpemgVvfidyMZ1wA0?=
 =?us-ascii?Q?FF5UPO2SM/0xoTlJp6KTh/fTNqqQ5foGx+SPFi+Cs93S6kCs3nfU47fZIcu4?=
 =?us-ascii?Q?4K7LOU1y7o+6p76G5MVZJdOBmEMLgSUmWnYYBUZ4/Qz2Wa6AfMG3nbMgNJjH?=
 =?us-ascii?Q?AKOEKiDh6tJoqx1S0EqFJ6gEe+rd8JcnI9fxHbvU0lDGE/qSmtze370PLpNI?=
 =?us-ascii?Q?qjzrJXudETSVEeB+jHchxI2JmgIzMjGC4gmTqF9Oq2TyCd8wX3UFmcZE/jbr?=
 =?us-ascii?Q?S90Z3JBT3TyN8hu5D+zc4ihSOLX56L8IkVfcgTdDNOWbo9K/qisH3E3g61ZO?=
 =?us-ascii?Q?29bcSTJlCTMr1iEm1JjTuX3TGD6AUfbDDw3aqPCem1GgtJjyY7U5nNqaacMb?=
 =?us-ascii?Q?4VSIwS9WMfbtQYI1DT8UaxBOwgAbMT1Qs2P3qE4Rs8QUg7+/VC0y/uaJdlH4?=
 =?us-ascii?Q?EOg6YOqHowsW4h6hq+Ia5ojcZewUewjwbk9m6URCEkhgdBYeZoKAHkwLsZIs?=
 =?us-ascii?Q?VuEIIj6NI1wR8iB3iCLLDC5vPVIhgPsywHTPsFxFrRd9znhPAqwRqdOvlu/r?=
 =?us-ascii?Q?rJ7I2FmCq0LV7nYemNWFBbZRdw3P1mnfwg7fRdrCDiHwAkXnAXTe/R/Q34M8?=
 =?us-ascii?Q?GXkiWyvEgOnlAiCZkOEX4BYs24sDHpNtKgIgm0VeelvcxnCZ/Tq3HgVsO7ko?=
 =?us-ascii?Q?NIENn9xs7/Is1p8Vke6ec7YtSw2nKWKkFgVS6fdozwDGSayM7DYvy7JZp8ik?=
 =?us-ascii?Q?gM7xicWvE5dW/sLeJR1wX8YBv5/cDdSxzWxf5Xh6HMfvQdY6BgGp3SfsrAwr?=
 =?us-ascii?Q?KCUX4eNiQnDKsnImyu7hiZQb9p5NH2GVCi9d8E1wXuADrnOXneHTa7/Y/JCh?=
 =?us-ascii?Q?4dR7CMkJmpdqFm7mMmUHgZtYwPGs5/Lg5NuSlEb3h1eFvG20FI5cOw5frGj/?=
 =?us-ascii?Q?cRbVqwq5MzOIo1SIlnK+nSV7UgMMhXzwQfMJeUFinMbo8G6TD9/JX2A0vijt?=
 =?us-ascii?Q?Bt9XdIekMLBNeok=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 19:32:31.5747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89c7117f-eac1-4ed3-7784-08dd671ccae1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110

One of the key challenges in PTE A bit based scanning is to find right
target node to promote to.

Here is a simple heuristic based approach:
   While scanning pages of any mm we also scan toptier pages that belong
to that mm. We get an insight on the distribution of pages that potentially
belonging to particular toptier node and also its recent access.

Current logic walks all the toptier node, and picks the one with highest
accesses.

Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
PS: There are many potential idea possible here.
1. we can do a quick sort on toptier nodes scan and access info
  and maintain the list of preferred nodes/fallback nodes
 in case of current target_node is getting filled up

2. We can also keep the history of access/scan information from last
scan used its decayed value to get a stable view etc etc.


 include/linux/mm_types.h |   4 +
 mm/kmmscand.c            | 174 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 174 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 0234f14f2aa6..eeaedc7473b1 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1015,6 +1015,10 @@ struct mm_struct {
 		/* numa_scan_seq prevents two threads remapping PTEs. */
 		int numa_scan_seq;
 #endif
+#ifdef CONFIG_KMMSCAND
+		/* Tracks promotion node. XXX: use nodemask */
+		int target_node;
+ #endif
 		/*
 		 * An operation with batched TLB flushing is going on. Anything
 		 * that can move process memory needs to flush the TLB when
diff --git a/mm/kmmscand.c b/mm/kmmscand.c
index 84140b9e8ce2..c2924b2e8a6d 100644
--- a/mm/kmmscand.c
+++ b/mm/kmmscand.c
@@ -88,6 +88,14 @@ static DEFINE_READ_MOSTLY_HASHTABLE(kmmscand_slots_hash, KMMSCAND_SLOT_HASH_BITS
 
 static struct kmem_cache *kmmscand_slot_cache __read_mostly;
 
+/* Per memory node information used to caclulate target_node for migration */
+struct kmmscand_nodeinfo {
+	unsigned long nr_scanned;
+	unsigned long nr_accessed;
+	int node;
+	bool is_toptier;
+};
+
 /* Per mm information collected to control VMA scanning */
 struct kmmscand_mm_slot {
 	struct mm_slot slot;
@@ -100,6 +108,7 @@ struct kmmscand_mm_slot {
 	unsigned long scan_size;
 	long address;
 	bool is_scanned;
+	int target_node;
 };
 
 /* Data structure to keep track of current mm under scan */
@@ -118,7 +127,9 @@ struct kmmscand_scan kmmscand_scan = {
  */
 struct kmmscand_scanctrl {
 	struct list_head scan_list;
+	struct kmmscand_nodeinfo *nodeinfo[MAX_NUMNODES];
 	unsigned long address;
+	unsigned long nr_to_scan;
 };
 
 struct kmmscand_scanctrl kmmscand_scanctrl;
@@ -208,6 +219,98 @@ static void kmmmigrated_wait_work(void)
 			migrate_sleep_jiffies);
 }
 
+static unsigned long get_slowtier_accesed(struct kmmscand_scanctrl *scanctrl)
+{
+	int node;
+	unsigned long accessed = 0;
+
+	for_each_node_state(node, N_MEMORY) {
+		if (!node_is_toptier(node) && scanctrl->nodeinfo[node])
+			accessed += scanctrl->nodeinfo[node]->nr_accessed;
+	}
+	return accessed;
+}
+
+static inline void set_nodeinfo_nr_accessed(struct kmmscand_nodeinfo *ni, unsigned long val)
+{
+	ni->nr_accessed = val;
+}
+static inline unsigned long get_nodeinfo_nr_scanned(struct kmmscand_nodeinfo *ni)
+{
+	return ni->nr_scanned;
+}
+
+static inline void set_nodeinfo_nr_scanned(struct kmmscand_nodeinfo *ni, unsigned long val)
+{
+	ni->nr_scanned = val;
+}
+
+static inline void reset_nodeinfo_nr_scanned(struct kmmscand_nodeinfo *ni)
+{
+	set_nodeinfo_nr_scanned(ni, 0);
+}
+
+static inline void reset_nodeinfo(struct kmmscand_nodeinfo *ni)
+{
+	set_nodeinfo_nr_scanned(ni, 0);
+	set_nodeinfo_nr_accessed(ni, 0);
+}
+
+static void init_one_nodeinfo(struct kmmscand_nodeinfo *ni, int node)
+{
+	ni->nr_scanned = 0;
+	ni->nr_accessed = 0;
+	ni->node = node;
+	ni->is_toptier = node_is_toptier(node) ? true : false;
+}
+
+static struct kmmscand_nodeinfo *alloc_one_nodeinfo(int node)
+{
+	struct kmmscand_nodeinfo *ni;
+
+	ni = kzalloc(sizeof(*ni), GFP_KERNEL);
+
+	if (!ni)
+		return NULL;
+
+	init_one_nodeinfo(ni, node);
+
+	return ni;
+}
+
+/* TBD: Handle errors */
+static void init_scanctrl(struct kmmscand_scanctrl *scanctrl)
+{
+	struct kmmscand_nodeinfo *ni;
+	int node;
+
+	for_each_node(node) {
+		ni = alloc_one_nodeinfo(node);
+		if (!ni)
+			WARN_ON_ONCE(ni);
+		scanctrl->nodeinfo[node] = ni;
+	}
+}
+
+static void reset_scanctrl(struct kmmscand_scanctrl *scanctrl)
+{
+	int node;
+
+	for_each_node_state(node, N_MEMORY)
+		reset_nodeinfo(scanctrl->nodeinfo[node]);
+
+	/* XXX: Not rellay required? */
+	scanctrl->nr_to_scan = kmmscand_scan_size;
+}
+
+static void free_scanctrl(struct kmmscand_scanctrl *scanctrl)
+{
+	int node;
+
+	for_each_node(node)
+		kfree(scanctrl->nodeinfo[node]);
+}
+
 /*
  * Do not know what info to pass in the future to make
  * decision on taget node. Keep it void * now.
@@ -217,6 +320,24 @@ static int kmmscand_get_target_node(void *data)
 	return kmmscand_target_node;
 }
 
+static int get_target_node(struct kmmscand_scanctrl *scanctrl)
+{
+	int node, target_node = NUMA_NO_NODE;
+	unsigned long prev = 0;
+
+	for_each_node(node) {
+		if (node_is_toptier(node) && scanctrl->nodeinfo[node] &&
+				get_nodeinfo_nr_scanned(scanctrl->nodeinfo[node]) > prev) {
+			prev = get_nodeinfo_nr_scanned(scanctrl->nodeinfo[node]);
+			target_node = node;
+		}
+	}
+	if (target_node == NUMA_NO_NODE)
+		target_node = kmmscand_get_target_node(NULL);
+
+	return target_node;
+}
+
 extern bool migrate_balanced_pgdat(struct pglist_data *pgdat,
 					unsigned long nr_migrate_pages);
 
@@ -469,6 +590,14 @@ static int hot_vma_idle_pte_entry(pte_t *pte,
 	}
 	srcnid = folio_nid(folio);
 
+	scanctrl->nodeinfo[srcnid]->nr_scanned++;
+	if (scanctrl->nr_to_scan)
+		scanctrl->nr_to_scan--;
+
+	if (!scanctrl->nr_to_scan) {
+		folio_put(folio);
+		return 1;
+	}
 
 	if (!folio_test_lru(folio)) {
 		folio_put(folio);
@@ -479,11 +608,14 @@ static int hot_vma_idle_pte_entry(pte_t *pte,
 			mmu_notifier_test_young(mm, addr) ||
 			folio_test_referenced(folio) || pte_young(pteval)) {
 
+		scanctrl->nodeinfo[srcnid]->nr_accessed++;
+
 		/* Do not try to promote pages from regular nodes */
 		if (!kmmscand_eligible_srcnid(srcnid)) {
 			folio_put(folio);
 			return 0;
 		}
+
 		info = kzalloc(sizeof(struct kmmscand_migrate_info), GFP_NOWAIT);
 		if (info && scanctrl) {
 
@@ -571,6 +703,7 @@ static void kmmscand_collect_mm_slot(struct kmmscand_mm_slot *mm_slot)
 static void kmmscand_migrate_folio(void)
 {
 	int ret = 0, dest = -1;
+	struct mm_struct *oldmm = NULL;
 	struct kmmscand_migrate_info *info, *tmp;
 
 	spin_lock(&kmmscand_migrate_lock);
@@ -596,7 +729,16 @@ static void kmmscand_migrate_folio(void)
 			spin_unlock(&kmmscand_migrate_lock);
 
 			if (info->mm) {
-				dest = kmmscand_get_target_node(NULL);
+				if (oldmm != info->mm) {
+					if (!mmap_read_trylock(info->mm)) {
+						dest = kmmscand_get_target_node(NULL);
+					} else {
+						dest = READ_ONCE(info->mm->target_node);
+						mmap_read_unlock(info->mm);
+					}
+					oldmm = info->mm;
+				}
+
 				ret = kmmscand_promote_folio(info, dest);
 			}
 
@@ -658,7 +800,7 @@ static void kmmscand_migrate_folio(void)
  *		Increase scan_size by (1 << SCAN_SIZE_CHANGE_SHIFT).
  */
 static inline void kmmscand_update_mmslot_info(struct kmmscand_mm_slot *mm_slot,
-				unsigned long total)
+				unsigned long total, int target_node)
 {
 	unsigned int scan_period;
 	unsigned long now;
@@ -706,6 +848,7 @@ static inline void kmmscand_update_mmslot_info(struct kmmscand_mm_slot *mm_slot,
 	mm_slot->scan_period = scan_period;
 	mm_slot->scan_size = scan_size;
 	mm_slot->scan_delta = total;
+	mm_slot->target_node = target_node;
 }
 
 static unsigned long kmmscand_scan_mm_slot(void)
@@ -714,6 +857,7 @@ static unsigned long kmmscand_scan_mm_slot(void)
 	bool update_mmslot_info = false;
 
 	unsigned int mm_slot_scan_period;
+	int target_node, mm_slot_target_node, mm_target_node;
 	unsigned long now;
 	unsigned long mm_slot_next_scan;
 	unsigned long mm_slot_scan_size;
@@ -746,6 +890,7 @@ static unsigned long kmmscand_scan_mm_slot(void)
 	mm_slot_next_scan = mm_slot->next_scan;
 	mm_slot_scan_period = mm_slot->scan_period;
 	mm_slot_scan_size = mm_slot->scan_size;
+	mm_slot_target_node = mm_slot->target_node;
 	spin_unlock(&kmmscand_mm_lock);
 
 	if (unlikely(!mmap_read_trylock(mm)))
@@ -756,6 +901,9 @@ static unsigned long kmmscand_scan_mm_slot(void)
 		goto outerloop;
 	}
 
+	mm_target_node = READ_ONCE(mm->target_node);
+	if (mm_target_node != mm_slot_target_node)
+		WRITE_ONCE(mm->target_node, mm_slot_target_node);
 	now = jiffies;
 
 	if (mm_slot_next_scan && time_before(now, mm_slot_next_scan))
@@ -763,11 +911,17 @@ static unsigned long kmmscand_scan_mm_slot(void)
 
 	VMA_ITERATOR(vmi, mm, address);
 
+	/* Either Scan 25% of scan_size or cover vma size of scan_size */
+	kmmscand_scanctrl.nr_to_scan =	mm_slot_scan_size >> PAGE_SHIFT;
+	/* Reduce actual amount of pages scanned */
+	kmmscand_scanctrl.nr_to_scan =	mm_slot_scan_size >> 1;
+
 	for_each_vma(vmi, vma) {
 		kmmscand_walk_page_vma(vma, &kmmscand_scanctrl);
 		vma_scanned_size += vma->vm_end - vma->vm_start;
 
-		if (vma_scanned_size >= kmmscand_scan_size) {
+		if (vma_scanned_size >= mm_slot_scan_size ||
+					!kmmscand_scanctrl.nr_to_scan) {
 			next_mm = true;
 			/* Add scanned folios to migration list */
 			spin_lock(&kmmscand_migrate_lock);
@@ -789,9 +943,19 @@ static unsigned long kmmscand_scan_mm_slot(void)
 
 	update_mmslot_info = true;
 
+	total = get_slowtier_accesed(&kmmscand_scanctrl);
+	target_node = get_target_node(&kmmscand_scanctrl);
+
+	mm_target_node = READ_ONCE(mm->target_node);
+
+	/* XXX: Do we need write lock? */
+	if (mm_target_node != target_node)
+		WRITE_ONCE(mm->target_node, target_node);
+	reset_scanctrl(&kmmscand_scanctrl);
+
 	if (update_mmslot_info) {
 		mm_slot->address = address;
-		kmmscand_update_mmslot_info(mm_slot, total);
+		kmmscand_update_mmslot_info(mm_slot, total, target_node);
 	}
 
 outerloop:
@@ -988,6 +1152,7 @@ static int stop_kmmscand(void)
 		kthread_stop(kmmscand_thread);
 		kmmscand_thread = NULL;
 	}
+	free_scanctrl(&kmmscand_scanctrl);
 
 	return err;
 }
@@ -1044,6 +1209,7 @@ static void init_list(void)
 	spin_lock_init(&kmmscand_migrate_lock);
 	init_waitqueue_head(&kmmscand_wait);
 	init_waitqueue_head(&kmmmigrated_wait);
+	init_scanctrl(&kmmscand_scanctrl);
 }
 
 static int __init kmmscand_init(void)
-- 
2.34.1


