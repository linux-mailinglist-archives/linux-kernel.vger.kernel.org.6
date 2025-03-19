Return-Path: <linux-kernel+bounces-568676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F6FA69937
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D1141B6316B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D4E2144CE;
	Wed, 19 Mar 2025 19:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pSL+Qafx"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2062.outbound.protection.outlook.com [40.107.102.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8328A2144C8
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412270; cv=fail; b=q1Y/tVuLjM54wVTrq18hY7ucgsY4ECFaD4JNcRuU8fX0OsMeRTymqiY6ejB7nrsthN7OSjsWlB8aXxw/bDhgI+yfZrgEMb+UQjZizdbsf8wsBMF10pOrEFodYLTkvndEFk7/ZnyJDnnYuJ/fKmFO+zor4JoBR1QXb3OWzuDeCi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412270; c=relaxed/simple;
	bh=NKRZ/xWWdUU4TQOO73M07MNOWFvDUFQGTrnUqZA+lEo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XYnO6xS/IEmNroPTRhx+LF6Db5dG7rv6NYGoiN7uRAWKQHsIFWuW25sU4iGrgOCaFx8RrCjsDCFh48LYLo2oV4Hdbzs/+soi6r9lY4MjAaDGeIKGfcm+xQ2WDFkIUogExxzThdTw2N77UfkmNUU/GJAAHWXq0lM5HRwOeV04rBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pSL+Qafx; arc=fail smtp.client-ip=40.107.102.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nQriWq3ZXlUSxGN5mClOuyTuKJs+tFeNJP1FAOXrL9IIdT8K7Ll/vgxUqNq8K+T4NtNZO7EFFvTuZNQspcFg71iw4q6mu/IYDwrr/65BLHTOVHI6dchw2UxP0QTIzqHOCgVoL654h8D0zAcSXBy2G3b5y0HtajDUEChiZY/qsUVogpf3wlevtD3xMcYD8cNXGBnYNfH5PZbWN6wnYexsa02b7HJe3tm8uotzK8uRNF/uLLxvNl5HkryL2janmh+6TlxmfkqI0YTB0N20dvQPtFTaStT18oMWC0QNYTz7+BFyuMkVkF8fIHWDMGj/nCHvdngjr2buk2OxuSX0/xdCyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8P+xOLNadTEZ5L2TBrKUW55HXRM6KmjsOy9cLgaKdE=;
 b=IPYtHdfe3hSXcZ6uJU7Ga5DgIB8zFXak0nffgG60ApzPCN/P17O4LkwjOzIBYlj5wfePX+imc0GxgGLx4oSmGWecIbKs8S5esI3tjePRQey1hR+Sl2Y6/JGrHinMbG7KJlzPiPqB1E1xbkFuiV1e+9M7eejnDICYwwkCCrynzzK65rJE3cDjmMPlfIRYO5PUFq0EGn6K+8Knl1OIzyv0/3pS0aFCzycC2yqqdyRxvNwmY5j+HUX01EQlqmmCAlPDXLKYTMQdXgnjWcH3PxhiMnUNk1+m1Kt7eeQeh2ljxji68h5XaIX0PLZOmv7fGGX+CJoA1UqVex963lbMLI3/Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8P+xOLNadTEZ5L2TBrKUW55HXRM6KmjsOy9cLgaKdE=;
 b=pSL+QafxoE77gAYvKVjOIo28l49ybnj3kTIfqekB0W6EODp2JmbGnDdPW5pOPjTWnEfviVSh1h4psoSGTSU2NZEydTea8nbeBgHPz+nKsnCVhkzPMESunmXwt3xu9r46BKEWwxh+iX3pbbf9n17+W04F/yP+jSoNxdht4Ke3Za0=
Received: from CH2PR10CA0015.namprd10.prod.outlook.com (2603:10b6:610:4c::25)
 by CH3PR12MB8331.namprd12.prod.outlook.com (2603:10b6:610:12f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 19:24:25 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::f9) by CH2PR10CA0015.outlook.office365.com
 (2603:10b6:610:4c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 19:24:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 19:24:25 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 14:24:14 -0500
From: Shivank Garg <shivankg@amd.com>
To: <akpm@linux-foundation.org>, <linux-mm@kvack.org>, <ziy@nvidia.com>
CC: <AneeshKumar.KizhakeVeetil@arm.com>, <baolin.wang@linux.alibaba.com>,
	<bharata@amd.com>, <david@redhat.com>, <gregory.price@memverge.com>,
	<honggyu.kim@sk.com>, <jane.chu@oracle.com>, <jhubbard@nvidia.com>,
	<jon.grimm@amd.com>, <k.shutemov@gmail.com>, <leesuyeon0506@gmail.com>,
	<leillc@google.com>, <liam.howlett@oracle.com>,
	<linux-kernel@vger.kernel.org>, <mel.gorman@gmail.com>,
	<Michael.Day@amd.com>, <Raghavendra.KodsaraThimmappa@amd.com>,
	<riel@surriel.com>, <rientjes@google.com>, <santosh.shukla@amd.com>,
	<shivankg@amd.com>, <shy828301@gmail.com>, <sj@kernel.org>,
	<wangkefeng.wang@huawei.com>, <weixugc@google.com>, <willy@infradead.org>,
	<ying.huang@linux.alibaba.com>, <anannara@amd.com>, <wei.huang2@amd.com>,
	<Jonathan.Cameron@huawei.com>, <hyeonggon.yoo@sk.com>, <byungchul@sk.com>
Subject: [PATCH RFC V2 9/9] mtcopy: spread threads across die for testing
Date: Wed, 19 Mar 2025 19:22:12 +0000
Message-ID: <20250319192211.10092-10-shivankg@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250319192211.10092-1-shivankg@amd.com>
References: <20250319192211.10092-1-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|CH3PR12MB8331:EE_
X-MS-Office365-Filtering-Correlation-Id: 79fb7930-f6ad-44f3-293e-08dd671ba8ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V6niP53U8rM7xPccJMkBaqVBh8LIChEV0FEUf1bYsp+egNW7sxbH7/GapdCy?=
 =?us-ascii?Q?TmBgzqxOS210W+IYR5LkQHSp+EDHDqae/WD4MpZ+4eZOY08VlA3R1GPOOc2+?=
 =?us-ascii?Q?bWUmozKS2KAjflFTRvW8D532aTEH4OYysjWDd5t8429QKl5XPRZUlbPTkWWR?=
 =?us-ascii?Q?Wwnvzxs+GRDgrBZAmB+hp73EDEDrVhNYajX7b3FGnWYHLfLF/kW1AftFaDp8?=
 =?us-ascii?Q?8E7L+q7mrdkj7u4Uw/mc/aKBBQGiEPlI53CUNdV4VmX5jRttjDvR7YqztNtF?=
 =?us-ascii?Q?3vq48wG5n6lUXT7xO2eK/ddIhPnn8L+SxA7oqeJPHfcG7Sl3e3TzMEpLfe1x?=
 =?us-ascii?Q?jZE2K9rL6KCeiEYGNfI6OGI5WfjeVwgL/K8eSvUkuVbU3qHk6TERQOX0ZKda?=
 =?us-ascii?Q?/AmzRj5v0N63gAdf4IgaJJEBwvqeZ3IbL+yFrlfPd66oHf8b3T0Jv3KDpBdI?=
 =?us-ascii?Q?L+f1AtZcohLHRVAKOi0Ud0orsWIOY8XHOjKlnQHRG9E5ZUa8R06MHpF163Zo?=
 =?us-ascii?Q?n/LoJvJZAb2euBxVJihiOyh6sKu381Z3KMR8sQMql7AT2IPzyDqxAizoO45q?=
 =?us-ascii?Q?64g0avJzXu+maDHIZ+M42RZ3HlpuvyVeQ7kwsGU06wLsqp93LyoDxJgT153p?=
 =?us-ascii?Q?M2LjUJGBGlXk30okcNTkeRB0glo4SBkgG6nbcLYyO9hUlF3e4/SF2La+4tNm?=
 =?us-ascii?Q?64LWElBCBgPdbSpY+gMDyfRXwuXi5l6BkHQ577MVQUplVfX9tvt4XEkEQ8E1?=
 =?us-ascii?Q?6y2SX/bzdDW+eq48mZ95TioyLvfaiE+ay8KHq6fGynhjm05Odub9o7Z/gAJr?=
 =?us-ascii?Q?z4f0vbubfVQvyVkujrSijNQCFunj53uaR2bUiaMeB/Q2wkOiRidUtx2LKmKA?=
 =?us-ascii?Q?KeA87ljO7pLgpz/JKMSAJ4Urqw8DAeRdSI5eTH/kQb5d/DUeyhmOdvEhoVp5?=
 =?us-ascii?Q?TWNGl5cmpLHcPjRCK4VhuJfqm3Yf6URIrYiQHnAbDmLGzE7nAHSOnVEkc4Gk?=
 =?us-ascii?Q?bWeKgfDLZ3mSmSTXMlf17jMpzbzpKwkknsoVuX/5c4g0BFLUfQI4LPqrsznX?=
 =?us-ascii?Q?qWCxcJoJPSgPAMvqv0W74dLHvi36QI5Q6EZJgv77cCH1W0axJrrzQs8jtK0R?=
 =?us-ascii?Q?YhXZUe3ao6EKaGHJ0L9E2IF2fxY7tr+CpMWp+xNcTOf7DFbrvHBojm9aE9Zz?=
 =?us-ascii?Q?xEUqnbUtg06cc6xYG8bdsi3FMR1EIuSLBdHKflYUMKCZf8hv68mKk/1QV7rj?=
 =?us-ascii?Q?07AAGJWP1O0O9GFRjQnPfeLzbDL87yJbRUN94mCE5xGHODHwmC8NwSpnZq69?=
 =?us-ascii?Q?yEd7lsOE5q3wPIXPDwHLPdtz+do/UHAcWAM1B+ZBQ4M2iSUvBJm99esk6Bs1?=
 =?us-ascii?Q?Cg2aFWAECwexaBreZs6M+EqIZ22K6hwfGKAiR/l0661YiEKx0tnXh+NpFOE3?=
 =?us-ascii?Q?z6OZ8iIc0lQm6QnazT8PnLjsoGSJkK3gdPhToiTichdLD2Wyq4mIsXE899/Z?=
 =?us-ascii?Q?0t3rgnbAlG7uoXs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 19:24:25.1655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79fb7930-f6ad-44f3-293e-08dd671ba8ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8331

Select CPUs using sysfs
For testing purpose only.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 drivers/migoffcopy/mtcopy/copy_pages.c | 77 +++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 3 deletions(-)

diff --git a/drivers/migoffcopy/mtcopy/copy_pages.c b/drivers/migoffcopy/mtcopy/copy_pages.c
index 4c9c7d90c9fd..5178e6846890 100644
--- a/drivers/migoffcopy/mtcopy/copy_pages.c
+++ b/drivers/migoffcopy/mtcopy/copy_pages.c
@@ -15,11 +15,37 @@
 #include <linux/migrate.h>
 #include <linux/migrate_offc.h>
 
-#define MAX_NUM_COPY_THREADS 64
+#define MAX_NUM_COPY_THREADS 32
 
 unsigned int limit_mt_num = 4;
 static int is_dispatching;
 
+static int cpuselect = 0;
+
+// spread across die
+static const int cpu_id_list_0[] =
+	{0, 8, 16, 24,
+	32, 40, 48, 56,
+	64, 72, 80, 88,
+	96, 104, 112, 120,
+	128, 136, 144, 152,
+	160, 168, 176, 184,
+	192, 200, 208, 216,
+	224, 232, 240, 248};
+
+// don't spread, fill the die
+static const int cpu_id_list_1[] =
+	{0, 1, 2, 3,
+	4, 5, 6, 7,
+	8, 9, 10, 11,
+	12, 13, 14, 15,
+	16, 17, 18, 19,
+	20, 21, 22, 23,
+	24, 25, 26, 27,
+	28, 29, 30, 31};
+
+int cpu_id_list[32] = {0};
+
 static int copy_page_lists_mt(struct list_head *dst_folios,
 		struct list_head *src_folios, int nr_items);
 static bool can_migrate_mt(struct folio *dst, struct folio *src);
@@ -143,6 +169,40 @@ static ssize_t mt_threads_show(struct kobject *kobj,
 	return sysfs_emit(buf, "%u\n", limit_mt_num);
 }
 
+static ssize_t mt_cpuselect_set(struct kobject *kobj, struct kobj_attribute *attr,
+		const char *buf, size_t count)
+{
+	int ccode;
+	unsigned int cpuconfig;
+
+	ccode = kstrtouint(buf, 0, &cpuconfig);
+	if (ccode) {
+		pr_debug("(%s:) error parsing input %s\n", __func__, buf);
+		return ccode;
+	}
+	mutex_lock(&migratecfg_mutex);
+	cpuselect = cpuconfig;
+	switch (cpuselect) {
+	case 1:
+		memcpy(cpu_id_list, cpu_id_list_1, MAX_NUM_COPY_THREADS*sizeof(int));
+		break;
+	default:
+		memcpy(cpu_id_list, cpu_id_list_0, MAX_NUM_COPY_THREADS*sizeof(int));
+		break;
+	}
+
+	mutex_unlock(&migratecfg_mutex);
+
+	return count;
+}
+
+
+static ssize_t mt_cpuselect_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%u\n", cpuselect);
+}
+
 static bool can_migrate_mt(struct folio *dst, struct folio *src)
 {
 	return true;
@@ -218,7 +278,7 @@ int copy_page_lists_mt(struct list_head *dst_folios,
 		}
 
 		for (cpu = 0; cpu < total_mt_num; ++cpu)
-			queue_work(system_unbound_wq,
+			queue_work_on(cpu_id_list[cpu], system_unbound_wq,
 				   (struct work_struct *)work_items[cpu]);
 	} else {
 		int num_xfer_per_thread = nr_items / total_mt_num;
@@ -255,7 +315,7 @@ int copy_page_lists_mt(struct list_head *dst_folios,
 			dst2 = list_next_entry(dst, lru);
 
 			if (per_cpu_item_idx == work_items[cpu]->num_items) {
-				queue_work(system_unbound_wq,
+				queue_work_on(cpu_id_list[cpu], system_unbound_wq,
 					(struct work_struct *)work_items[cpu]);
 				per_cpu_item_idx = 0;
 				cpu++;
@@ -286,6 +346,8 @@ static struct kobj_attribute mt_offloading_attribute = __ATTR(offloading, 0664,
 		mt_offloading_show, mt_offloading_set);
 static struct kobj_attribute mt_threads_attribute = __ATTR(threads, 0664,
 		mt_threads_show, mt_threads_set);
+static struct kobj_attribute mt_cpuselect_attribute = __ATTR(cpuselect, 0664,
+		mt_cpuselect_show, mt_cpuselect_set);
 
 static int __init cpu_mt_module_init(void)
 {
@@ -303,10 +365,18 @@ static int __init cpu_mt_module_init(void)
 	if (ret)
 		goto out_threads;
 
+	ret = sysfs_create_file(mt_kobj_ref, &mt_cpuselect_attribute.attr);
+	if (ret)
+		goto out_cpuselect;
+
+	memcpy(cpu_id_list, cpu_id_list_0, MAX_NUM_COPY_THREADS*sizeof(int));
+
 	is_dispatching = 0;
 
 	return 0;
 
+out_cpuselect:
+	sysfs_remove_file(mt_kobj_ref, &mt_threads_attribute.attr);
 out_threads:
 	sysfs_remove_file(mt_kobj_ref, &mt_offloading_attribute.attr);
 out_offloading:
@@ -324,6 +394,7 @@ static void __exit cpu_mt_module_exit(void)
 	}
 	mutex_unlock(&migratecfg_mutex);
 
+	sysfs_remove_file(mt_kobj_ref, &mt_cpuselect_attribute.attr);
 	sysfs_remove_file(mt_kobj_ref, &mt_threads_attribute.attr);
 	sysfs_remove_file(mt_kobj_ref, &mt_offloading_attribute.attr);
 	kobject_put(mt_kobj_ref);
-- 
2.34.1


