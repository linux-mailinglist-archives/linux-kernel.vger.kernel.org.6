Return-Path: <linux-kernel+bounces-281081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF2094D2CE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F9311F21D7C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24C0198E96;
	Fri,  9 Aug 2024 14:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="msMk/chR"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2056.outbound.protection.outlook.com [40.107.102.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8303519885D
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 14:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723215572; cv=fail; b=I0ya5PQG92hi0eKonIaDT6b68awBoQBT6CMggZva+d37PDxlx15bdm7pRj3M33z8kz7jIvvTQhNLMr2pJe3jrbADSt0OFp8GjtlUWAkvDg3hPNy/r5isPmnBkRaMYSJeyu8p4CW1typYf1HA1gdg9CHHpyk5nXhE5PHFh2FDoOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723215572; c=relaxed/simple;
	bh=OjsoFSvB+Zz86ZG4BUemaFe/IEbkn0GSHNyKdnpOL8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ci8dJ3+KBbxukV0+gVjyrsW6hjrqAVoMz3Sw9HvGZlqIGfNvhRkOh0rKm2Zygz+U3aILas4xirzRw6E2L9nvEIq4uoQ5jKZQnFrOi9Tab5j/hfNV8L59eqrs4eDA8JcTwmFNb2ixeX0OCe1Oo19ySdW6PioE7sRoO3jG74QvdW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=msMk/chR; arc=fail smtp.client-ip=40.107.102.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DbKuD2iwF4gFglTo+WrcYagwHK7VSz+mZGVDbqL1N4yhQxmgqyFkc1RhcOIWb4z48EgdbnMhSCKGcGzPu5oLu5KI8Mi/ID1jmbbLAPnNI4guKHnInZslbpxjjQ3/US9BUn748w1D5fSeYIqvIXgdCvJxfuQuB5RPVqmDJSAUw6UrrvCRhRAfXoCssU5GdAcv6IYxlleisu5BTwxFJTCxax6CjqWz9m2p/my7w0gG5KLJAdnByAScDtcUPzbTF7teJW5i+3RkD8ekSxJLomF6IQ7tdFPzhLLnsuGxmR8q2glzCSCTKBUkw2ZdIYHT+rYzc97ZUnp/xdz6G5ABSytihQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jp1ggtAq2TPL+tWQv2b9sD0zy1Lqc8F9tl7KovE4HMg=;
 b=k0oJ1BcH0CK6azo2E/wqHYrp5oBnaQJDsjf3xZnJ0vemrNbFMgtN4Rvn2QxF578VT05IVz1wqBdcoVkxr9bIBgF/TJDUr2aLPdFXu8LQtO38tXhPk/kcDuavJ1I1q5LMdquP/ECE7SFWwq7TYusS93nBzLuL6GSKLZjZg1l574Z15MKVjrnVae3aVOaIeSFdkR63gntkBxsYpfT71/6UWEJplOr/yqV2ivT/MHa/4fO0fYOHF+UaR79/5/YFclYqecm18p8LGYu14hAIQfzwzH/lLAhcwjcCiA8liA69cEkz36a8JX2oKjycV0G+VCgfVV1S553nOY3vdmRx4z5+ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jp1ggtAq2TPL+tWQv2b9sD0zy1Lqc8F9tl7KovE4HMg=;
 b=msMk/chRuSZUhIUp4Hy93Ik51puNiRdC0d3LILReIOE2R4V4l+LYQP0y/W2Qvagig+hW3V04Wwj86uugUIMAM4qZWesxgAVK7v2ZPcjfh2q03UafUypvQJ96EpehWCEkiOkrpqpUl6Y11ybMWYwJ4r2SiTbS9rUkbBanIkp5i9gZwe0PQK4IxnpxmU7AqVA+9AYeYxczL/MvLxu9A5M3tDiUNCwunv60XFf+S1zaTIaA6SlDxsAysU5fLqvUUplzvA2UYJ0zYKLHsdAhVM5+H55ntK/vrh3q4vO2EvD0eVY3qYnV7/bYzfjpR0X0KTghHyE3LKBt9yskxvD0MRiYrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
 by SA1PR12MB6823.namprd12.prod.outlook.com (2603:10b6:806:25e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Fri, 9 Aug
 2024 14:59:23 +0000
Received: from CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f]) by CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f%3]) with mapi id 15.20.7849.014; Fri, 9 Aug 2024
 14:59:23 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Yang Shi <shy828301@gmail.com>,
	Mel Gorman <mgorman@suse.de>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v3 3/3] mm/migrate: move common code to numa_migrate_check (was numa_migrate_prep)
Date: Fri,  9 Aug 2024 10:59:06 -0400
Message-ID: <20240809145906.1513458-4-ziy@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240809145906.1513458-1-ziy@nvidia.com>
References: <20240809145906.1513458-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0088.namprd03.prod.outlook.com
 (2603:10b6:208:329::33) To CYXPR12MB9320.namprd12.prod.outlook.com
 (2603:10b6:930:e6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9320:EE_|SA1PR12MB6823:EE_
X-MS-Office365-Filtering-Correlation-Id: fcc233f4-6fe5-404b-b093-08dcb883db08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ooUYHu3jv0TDp6L6f7V/oUy+zyp/KNRRBspA8U9Wyvh0DcWa11G6/Z22yMMO?=
 =?us-ascii?Q?auztTJ0T5uWKXfclU0Ymr1mRwLLJFg/d4MzULAzyv822MoY3OZo9nmE/5tSu?=
 =?us-ascii?Q?ZiXp1xpXyIMkcsBzeotfzWG99NLegOarrCwJc8zzmXz87rLI6uJgdnBpVcXi?=
 =?us-ascii?Q?K0iz/5+/i3DgaeOz8FPz9yZXF9SS+8lSp9rRCr3lfVEM3XnAuUs+wG5irV+W?=
 =?us-ascii?Q?1LLuqrvAgPV9/K2Tpwc79K08m0kAFTbTuKZMsV6zyTXoT7tFXDl0u3P18Jpx?=
 =?us-ascii?Q?g5JdKw/qbzcHtgTid8x/+UhKcxBziQmEHngyFCnVmyN1CH3UIO8QoG6gIHNr?=
 =?us-ascii?Q?0ZCLu+9o682Tdf5MBQZNQwYgJvJD6XC7BvIRoC628RWbxcLGEFAIeWGfv08H?=
 =?us-ascii?Q?T7/Bom4VhEt681iY5JagMOblk80R+/4yLQjoI+D1NBvt8nCpAD9mzNMCsXXU?=
 =?us-ascii?Q?4e+PakHwDxp7AO0LdlO90TnfB6LoHgPw+qufOAe3g9N9S5HcafdLiiw8wM0x?=
 =?us-ascii?Q?z/70dx1qHK6OGs/xY2YWJQ9nsMB+ivMnY92ATojeuP7xbelxEYEsRhupFNNP?=
 =?us-ascii?Q?JpmpJc9KFFdKNUFkzJATCiitBQ7ylI4n4lk+pPSj4/OQEW4fdoYBjtAZA0FD?=
 =?us-ascii?Q?xaORzbsYniXleO3Bj4MxEldnDZhiTbT4R/h9qYqoQZviJ5dkhdglDyfCye3W?=
 =?us-ascii?Q?3NYg4IShwKdGzWY6il3BKu4wgGgKE0uk2tbYafCGRUoaRH3Fldto3q3g+VpI?=
 =?us-ascii?Q?CKNEYrtvL1EC1TyRbov+pmWlSuDKE5x5BMYi/BMP2GvGn8K58Mk4ftYvH1rO?=
 =?us-ascii?Q?5zEfzwt7hCYNHC0p/JW68q2WX3jX3ntTWxpJ8/yktwuAW3sznAJhYSiixox/?=
 =?us-ascii?Q?N3uUY7Hx9WJnukUri/fdc0Z8uPLB2gV4mHtBzQenH6GS5n5dgMpRkF+28hAk?=
 =?us-ascii?Q?EuGw0pTaZdKGIXypx5ItEeTXYprFkCnFrwQtEJlCa2WCyS18DpEHnhxytlsz?=
 =?us-ascii?Q?QrFVodL0ONVsi4HrIW2wK/kKX0MSZOg6G+z0dmwlb0nogUCJmQ+9mz7JXMNf?=
 =?us-ascii?Q?fPYO43wFatyZAvCroCo5yagq35gpVjySDPg+He0mz8kd3FjwagKO+eAI5LZD?=
 =?us-ascii?Q?tTyWbLaDnOBSFGqEKvi4OjaGUC4RhgpiCAQLreHM3oAO8aqhLr+Lu/L8HJtT?=
 =?us-ascii?Q?C4xTxYpLcroVVBuy98TioGoyKAMcREmyuMZ8P50fN8Xy6mEuPpzZybV3Eths?=
 =?us-ascii?Q?SB86kLyWLFvc7020XWucboInPl5pltX0OWd8MtU6ssDmz38jf81U5eJ4M3MF?=
 =?us-ascii?Q?2o+R+sVQeDc+XzoSYMR3Wgj3q38MD0xTTaMGK29nhL/fdA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EnIpbK5dj9/xYPibNM3XPy4mXGaS6lCzJzruuk5AREgyCupp5uLXB8662rzH?=
 =?us-ascii?Q?37IXWGV6xC1VuGcrDOZntHNcv5NftEddccj4qdv7HHSYD0esqL4e8D4PGWJX?=
 =?us-ascii?Q?si7dZ0pnAs61NKtx09ApDMg86FLRutEDmEZbDGGyt3LoOM6N3c+ZvOWkjB2k?=
 =?us-ascii?Q?NDUpK0TbCrWSd9e1zUrXrNsFrSONHu9u6d4K5EE7Q0CWjrdSOhpJ4xdIF39K?=
 =?us-ascii?Q?f/5j1uSYGnmIEgi/pu2sTNBO9Ah0egRLGbqkKRz4eAIvA7MXHz9HeIwkkFgt?=
 =?us-ascii?Q?1D08JmkXawj1Ganinj/BRe4FONgtS0Qvo8gXjiypE8NarCI2ArqjMJqwpEC5?=
 =?us-ascii?Q?ogNvDa4OLPYG2EHskOEhP5q9Ca2Xie58bcnvx+RF8f9IjuPKMiRvPYrORDFg?=
 =?us-ascii?Q?aK9V+xRg2hN+fKkhKPbKZa63rDWhdePgmGbSm+VPOwQbWoIMGQp8Xvz3SrcO?=
 =?us-ascii?Q?5A2V+87wEv5PTWxu2k2RxYHWKZ8EUZfclbv1epzqhOlFApfFqoiat6cKPMon?=
 =?us-ascii?Q?Fbe3T03saQ1zirqY1k8ia0szB1yiNvlYnxoIGyF5FmlW919byysPhQn6TnAj?=
 =?us-ascii?Q?NVd8Mtw9f17h+EIqbSedao3VwEOzoQEJAda8Q5GWjFdIq1Ju82/0J9veXp1i?=
 =?us-ascii?Q?1oPeDh8SSGHICXxJKqRnkT+flPPrTLBWPVQlEwDtbcDCtjPkzxKzvPKBbg+E?=
 =?us-ascii?Q?mCJxRaJFmD1hPcjNyXbfI7paOHjAXWTNbbrQtInwUCWBKw05OHzgpLGkrvhH?=
 =?us-ascii?Q?oSoeXl6EN5qdA6ZqFVtfuCkPv1Iu1GJdmLXpxNtGfIwyo3+35lTBn3NX5Sw9?=
 =?us-ascii?Q?TYl1NRpDyLjR0Pw6bHcGBQPlSTSJR0FfAS5EFWKKCBwIJA2peEtDVjv3v34H?=
 =?us-ascii?Q?NFJimcXO0qUH1LL2i4OzuwmC3oE9NYpZM3NOGNv7wX5KCpoT0RcR6QJ6VX6C?=
 =?us-ascii?Q?1I00AxybhGHqgHuq7KVKgF2BDt7Qvc2apN8QJ5kdIBXcJ7tjQy6P3wd5Uhz1?=
 =?us-ascii?Q?8p7XrefQpXYleoni//I19RDJtgAzgu02a3HeR6KV184mxEvHyOKVr5sE7u0q?=
 =?us-ascii?Q?Xuy0glHfgHUTsFFfDTh2b1rKjSLss4fPPQlbIFosjGIwgD5JOBccd4UqbdBp?=
 =?us-ascii?Q?QKrs1o6e5sKs7rOLh0d2MpyxgvNePEE9LbgMPAGOOOwL10VOMvkctEU10Kuw?=
 =?us-ascii?Q?VutQ29ZsZgsG/IPL4xzF47irdn5ws9nLlLk5x74RZ180FqfqUN/xxWdjncPn?=
 =?us-ascii?Q?gpuMG8bMBQ2COFTWhAsS/rK2/Q9keJYtRGZj5vBArkrv73eqRI8QFvXj0P3A?=
 =?us-ascii?Q?pCCN9+jIaEjHyIbar4g6dxQbfewVMJXShX18kWKBB3fVTPorb27cLAz8CKQ1?=
 =?us-ascii?Q?1/Vc+0DrSiiT4KnteFTeW/hlo7rLar48AxA2VRk9VAIJrBUNDgUoKEk2MAWl?=
 =?us-ascii?Q?Lw0HbGLu3xN3An5t9p5e15cbkZ2v8c2+ssQ+GJ0MAOpK8mmpY6srtuJS3JUv?=
 =?us-ascii?Q?dde9SJePX6rDRCZepa0VzWKntEAep8dLSq9eLsbqSDIb//cPsFbNKafB5a7W?=
 =?us-ascii?Q?B2M7XLnZpqkdNTjYUGvOP6znYSEpBeMdsDWrFuoE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc233f4-6fe5-404b-b093-08dcb883db08
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 14:59:23.5882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Df0qtp2IIRRfrJzjzaQPUeVR0ovLobssFrabwTHHkUoiRx1d22byt8FwOVnVpBlw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6823

do_numa_page() and do_huge_pmd_numa_page() share a lot of common code. To
reduce redundancy, move common code to numa_migrate_prep() and rename
the function to numa_migrate_check() to reflect its functionality.

Now do_huge_pmd_numa_page() also checks shared folios to set TNF_SHARED
flag.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/huge_memory.c | 29 +++++++++-------------
 mm/internal.h    |  5 ++--
 mm/memory.c      | 63 +++++++++++++++++++++++++-----------------------
 3 files changed, 47 insertions(+), 50 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 666fa675e5b6..f2fd3aabb67b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1669,22 +1669,23 @@ static inline bool can_change_pmd_writable(struct vm_area_struct *vma,
 vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
-	pmd_t oldpmd = vmf->orig_pmd;
-	pmd_t pmd;
 	struct folio *folio;
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
 	int nid = NUMA_NO_NODE;
-	int target_nid, last_cpupid = (-1 & LAST_CPUPID_MASK);
+	int target_nid, last_cpupid;
+	pmd_t pmd, old_pmd;
 	bool writable = false;
 	int flags = 0;
 
 	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
-	if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
+	old_pmd = pmdp_get(vmf->pmd);
+
+	if (unlikely(!pmd_same(old_pmd, vmf->orig_pmd))) {
 		spin_unlock(vmf->ptl);
 		return 0;
 	}
 
-	pmd = pmd_modify(oldpmd, vma->vm_page_prot);
+	pmd = pmd_modify(old_pmd, vma->vm_page_prot);
 
 	/*
 	 * Detect now whether the PMD could be writable; this information
@@ -1699,18 +1700,10 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	if (!folio)
 		goto out_map;
 
-	/* See similar comment in do_numa_page for explanation */
-	if (!writable)
-		flags |= TNF_NO_GROUP;
-
 	nid = folio_nid(folio);
-	/*
-	 * For memory tiering mode, cpupid of slow memory page is used
-	 * to record page access time.  So use default value.
-	 */
-	if (!folio_use_access_time(folio))
-		last_cpupid = folio_last_cpupid(folio);
-	target_nid = numa_migrate_prep(folio, vmf, haddr, nid, &flags);
+
+	target_nid = numa_migrate_check(folio, vmf, haddr, &flags, writable,
+					&last_cpupid);
 	if (target_nid == NUMA_NO_NODE)
 		goto out_map;
 	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
@@ -1730,13 +1723,13 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 
 	flags |= TNF_MIGRATE_FAIL;
 	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
-	if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
+	if (unlikely(!pmd_same(pmdp_get(vmf->pmd), vmf->orig_pmd))) {
 		spin_unlock(vmf->ptl);
 		return 0;
 	}
 out_map:
 	/* Restore the PMD */
-	pmd = pmd_modify(oldpmd, vma->vm_page_prot);
+	pmd = pmd_modify(pmdp_get(vmf->pmd), vma->vm_page_prot);
 	pmd = pmd_mkyoung(pmd);
 	if (writable)
 		pmd = pmd_mkwrite(pmd, vma);
diff --git a/mm/internal.h b/mm/internal.h
index 52f7fc4e8ac3..fb16e18c9761 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1191,8 +1191,9 @@ void vunmap_range_noflush(unsigned long start, unsigned long end);
 
 void __vunmap_range_noflush(unsigned long start, unsigned long end);
 
-int numa_migrate_prep(struct folio *folio, struct vm_fault *vmf,
-		      unsigned long addr, int page_nid, int *flags);
+int numa_migrate_check(struct folio *folio, struct vm_fault *vmf,
+		      unsigned long addr, int *flags, bool writable,
+		      int *last_cpupid);
 
 void free_zone_device_folio(struct folio *folio);
 int migrate_device_coherent_page(struct page *page);
diff --git a/mm/memory.c b/mm/memory.c
index bf791da57cab..e4f27c0696cb 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5368,16 +5368,43 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
 	return ret;
 }
 
-int numa_migrate_prep(struct folio *folio, struct vm_fault *vmf,
-		      unsigned long addr, int page_nid, int *flags)
+int numa_migrate_check(struct folio *folio, struct vm_fault *vmf,
+		      unsigned long addr, int *flags,
+		      bool writable, int *last_cpupid)
 {
 	struct vm_area_struct *vma = vmf->vma;
 
+	/*
+	 * Avoid grouping on RO pages in general. RO pages shouldn't hurt as
+	 * much anyway since they can be in shared cache state. This misses
+	 * the case where a mapping is writable but the process never writes
+	 * to it but pte_write gets cleared during protection updates and
+	 * pte_dirty has unpredictable behaviour between PTE scan updates,
+	 * background writeback, dirty balancing and application behaviour.
+	 */
+	if (!writable)
+		*flags |= TNF_NO_GROUP;
+
+	/*
+	 * Flag if the folio is shared between multiple address spaces. This
+	 * is later used when determining whether to group tasks together
+	 */
+	if (folio_likely_mapped_shared(folio) && (vma->vm_flags & VM_SHARED))
+		*flags |= TNF_SHARED;
+	/*
+	 * For memory tiering mode, cpupid of slow memory page is used
+	 * to record page access time.  So use default value.
+	 */
+	if (folio_use_access_time(folio))
+		*last_cpupid = (-1 & LAST_CPUPID_MASK);
+	else
+		*last_cpupid = folio_last_cpupid(folio);
+
 	/* Record the current PID acceesing VMA */
 	vma_set_access_pid_bit(vma);
 
 	count_vm_numa_event(NUMA_HINT_FAULTS);
-	if (page_nid == numa_node_id()) {
+	if (folio_nid(folio) == numa_node_id()) {
 		count_vm_numa_event(NUMA_HINT_FAULTS_LOCAL);
 		*flags |= TNF_FAULT_LOCAL;
 	}
@@ -5479,35 +5506,11 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	if (!folio || folio_is_zone_device(folio))
 		goto out_map;
 
-	/*
-	 * Avoid grouping on RO pages in general. RO pages shouldn't hurt as
-	 * much anyway since they can be in shared cache state. This misses
-	 * the case where a mapping is writable but the process never writes
-	 * to it but pte_write gets cleared during protection updates and
-	 * pte_dirty has unpredictable behaviour between PTE scan updates,
-	 * background writeback, dirty balancing and application behaviour.
-	 */
-	if (!writable)
-		flags |= TNF_NO_GROUP;
-
-	/*
-	 * Flag if the folio is shared between multiple address spaces. This
-	 * is later used when determining whether to group tasks together
-	 */
-	if (folio_likely_mapped_shared(folio) && (vma->vm_flags & VM_SHARED))
-		flags |= TNF_SHARED;
-
 	nid = folio_nid(folio);
 	nr_pages = folio_nr_pages(folio);
-	/*
-	 * For memory tiering mode, cpupid of slow memory page is used
-	 * to record page access time.  So use default value.
-	 */
-	if (folio_use_access_time(folio))
-		last_cpupid = (-1 & LAST_CPUPID_MASK);
-	else
-		last_cpupid = folio_last_cpupid(folio);
-	target_nid = numa_migrate_prep(folio, vmf, vmf->address, nid, &flags);
+
+	target_nid = numa_migrate_check(folio, vmf, vmf->address, &flags,
+					writable, &last_cpupid);
 	if (target_nid == NUMA_NO_NODE)
 		goto out_map;
 	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
-- 
2.43.0


