Return-Path: <linux-kernel+bounces-305651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 621079631B4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 22:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 342CF284AFA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A101ACDE4;
	Wed, 28 Aug 2024 20:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V09tYkAB"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47211AC89E
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 20:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724876607; cv=fail; b=MzamjYs9xOHaSB/w+e89XEdfZTUnQHI7t3G7/JP5VJjrbYvlczF9iO10rK5xOVmvHvt2Rhovw9t+EGHMdI+4z9vvhA5sqWGYIiKSDWMbKcO+bnL1tha7TUR+sQYaPVzs7VWT9EwNmd5y6mDxyYBuGkDADcdzjg8L1mYUW5zMxH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724876607; c=relaxed/simple;
	bh=0oG7SLRGCeIsf8W4TH2advhCrtjK6l3t+w2NveCHZYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q4ACXCp36CfSI7N24eZ3I3TqAIfMsjZ70+nlMselzq8/OZKvBwGiNqX1tEisTjm+kov/APWlOAe0eQrMOkeRUhQKABnf14pACFzsNkLVz3BcwB7bdWm8T8qkVvcsQzagdSPES3ThW6H85bDktT0kJHpI6tUvSivIp+kQibZLbDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V09tYkAB; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CT4QBUko9vbjNxRgczjzPMc9Z15A3iaRYNRU4TeGuaOgXz1mtWzHcDkcGR2tkvprMZApaBN7S9JJvfq2I4mns/SlpZ827hHSguk5VxyEH8xK9g795BSltJFEWxj0Q0T7wWvhGsPdN4iKtwuRaB0F4eeft6vImCFJnNBP4oEbYTGF/5V9jQpg70OtyEOqBUDGYnYetCzWtmXHJFVfzb6M4+kPrQXMq0ZyaHm9XfmhpYFJvLXic46ZK9nTs1NW19Bq9JdKRmvTPyk3hHZKlpIfVTmBiqfqkAbKs1yFHRKdSkH8FIOq59E6kQsV4O+wIAUGY72CN35tZz54DEscYpN5LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7modIZk/c+cwKVJ1OUQ08Y5sIt5SsC21/jg0tySFpU=;
 b=foNnvJ9b81qGgzenOaUJp2bONIZnB+ahNq7SQC0gdykRcH9ElRbQSXunMarsfW2AiJXGi2l5kD6WNebvfzv22ycvGCmSLS0XAi/t0UjzJTBHK9OLRY4XV8q/lDtMaQvjEY9WG87zjYgRWx+e4AnSfw3IyV1Zo64CwgM3mADJ011FGVInH1pvUh6YoBD7uIM9/AhC3TeuRQP7JBIX8AwJhnsYfC2l8vvSpCo+1WjewxYqfF67mMEFjjW40nIbDRGNzoBxlNEqdw2/yeLBw/IkEs2JRx+JOmJHcWAhA1d3qBi5w85HL+rCX+n4+ALm/fUCadA3xD7AZe3drlixUISFsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7modIZk/c+cwKVJ1OUQ08Y5sIt5SsC21/jg0tySFpU=;
 b=V09tYkABBO3gMBeGFvw1iUR/zLtCWyG3oEi/XNj7MvtGoU4Jk9K9pOxaXLc2CKQ9jNwRgdGRooJufFGPebKamfkcjV6yQcBpKYWKWx/labMdlLwUbodeYeaQyfd+JaRImfd1bkv2kfwkRaw7f5Q1QIvV3dV1WWbZXDROrM5GFHdaY2zmSrK9ucuOjuffu3SeK5LsYuUdcojiH/BsnW65bd58fV96YHpJfppBqZl0giQVOxo9acZQwpEqPc3+iMNjQ4Ufb3DFw9dEA2TPB2deq9ZBAqHGHdt5w7g7nF+KA92Yc8aEUBqzMVRuet1/UYH1GjK8BHActY+wM0HpZDGglA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
 by CH2PR12MB4134.namprd12.prod.outlook.com (2603:10b6:610:a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Wed, 28 Aug
 2024 20:23:22 +0000
Received: from CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f]) by CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f%5]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 20:23:22 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Mel Gorman <mgorman@suse.de>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH 3/4] mm/page_isolation: remove migratetype from undo_isolate_page_range()
Date: Wed, 28 Aug 2024 16:22:39 -0400
Message-ID: <20240828202240.2809740-4-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240828202240.2809740-1-ziy@nvidia.com>
References: <20240828202240.2809740-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR17CA0023.namprd17.prod.outlook.com
 (2603:10b6:208:15e::36) To CYXPR12MB9320.namprd12.prod.outlook.com
 (2603:10b6:930:e6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9320:EE_|CH2PR12MB4134:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c184413-bd0d-4c96-be37-08dcc79f4361
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qXgrcjFlF8eUQlvfFSGqYZuj4p9PHQEg8R+Fg8hFUAXZpiW6opwG0/E8JZKw?=
 =?us-ascii?Q?tf7L589hxc7caEvfvQviG937hxM6tRhdrmBzDn1zZFUW6W/x8vr+A+844AnC?=
 =?us-ascii?Q?UsRShxv5UcbmpAqIh3sClCr2MAnHdv6uYO5wwRFlidSSkne3oUhgz1f6+qXn?=
 =?us-ascii?Q?keYJncgaCuqbW65ihKHtYHg6PpcPgzxPDwLY98jp3N7w+9VlXeqRRc2Xga5U?=
 =?us-ascii?Q?scEVRJo1ZZdcHsyZndtYTBJTO0yz0HO+o4p2H434auZzZRP+XwM7WYucjJXe?=
 =?us-ascii?Q?8bvRCgq9geXhFNFymPY9cA+t0BjVxHIKw8VKbzr1LMMljCXH6yqww1nbaf7l?=
 =?us-ascii?Q?zNd8RB1QUUSIlNzUV1enrslg6XBC5dpTmJ3d2/7dYNag5MhnZPYHy+GZP1Rw?=
 =?us-ascii?Q?DtQ7glPXx01sG+c8xdFuCMO4dYRzABh/G2b+hBmrZzo7I9yksUuvsRpuzqpa?=
 =?us-ascii?Q?8An8TiIoCvBVCkNrUtPn4nwTob3D8nWSCA6Rvfj3guq+rcnJ5O1pkmfiBDqY?=
 =?us-ascii?Q?UAUzbR6hMRssLJE59N5oD8y8/VzmipSoH3e6HOR5TNYD+OTc9T/vEhGNz2Nz?=
 =?us-ascii?Q?2jr+kZ3M8J66Z3Ts5CgqeduCMydIF/lixazu+4i4fFgSGIq9cxXzUchcIIl0?=
 =?us-ascii?Q?IJyHKWt5cQjykRQM6nQcQiXn510UZGd8x9wjKi2V01eGnHSD6MDvMUuT/v08?=
 =?us-ascii?Q?4POQwjInWd4oW/tuCWxCb4GfwlsfFnXGoCBGLPzAG/5JsGIcZ0Wiaxdyrbyw?=
 =?us-ascii?Q?tGMugRL/O13Z/K/ZO5mjrnxpb4JMIN+Hq3lNCPHB5M27ji7JY96xMN7zAbH8?=
 =?us-ascii?Q?p1hRWj3MmptoQnzkcMXd3AoHp3aza3yH93rs+8gYhdjuQJUgEkVQhQWzDy2K?=
 =?us-ascii?Q?+qPmQ8fBE7nvepzB00f48o7krHrGCl1lR6WG4IIheouOHSUwiV5q/8hTCkjp?=
 =?us-ascii?Q?iwdCDD6Q8LaeqD2Y/BsxNbjM1e9pCNdhbKcD3W3P4PRaGVsT0qDvzWoYr0tk?=
 =?us-ascii?Q?LsRDEhTRuLQJYx9/i8Gjw2sgJFjPRZXpUKrbou99hI16oCNS5pzmzbSp9SWL?=
 =?us-ascii?Q?0l/7LTY4UosnzNyHDYdE+IBbZlmT9MMwy8ycb4qB8De7T/joi/Cmym0YRUR5?=
 =?us-ascii?Q?CG/2mQO5LE2uBk+sacDmz0zJ3LTgt6A1Gi02onaQbFLRRfcD63lYUCSg9KPm?=
 =?us-ascii?Q?QBO1fPRkYyfXCMjT894Pliz8x5rtaH4rB85tLQRe6hlZPvGkek89wiSirnob?=
 =?us-ascii?Q?8AiIm48pm0+vq7CNGmlfctp0smVNaH/zfG49FjKOmQrVTf9qOnOPNndnp89I?=
 =?us-ascii?Q?UjdsIjfp+O17zM2LhJmoU1T0qpD+I8HF8JFlHN2PESmhOQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8bb7p364t5AUlyeEHlQL/tLUzXyR8kcZz6kMp675yQh2N2HIDfk4/esmoNjc?=
 =?us-ascii?Q?yJgcHBrx6idA3B+2dw1IqQRVMpQsUrbqHy/LLgBvd9w6PWkmjXE2pU/eEI86?=
 =?us-ascii?Q?hOI06/vDCLyzTDisd29smnJx47TUFsawyfIOw9F2l2oj+w/pcLH+zI5I9k5q?=
 =?us-ascii?Q?AfFgCVURjMrDwwIboxKOFpkLKHm0R+alYD5ZR5orJW+73vvZLE3kUPcZIy/o?=
 =?us-ascii?Q?1rQNSi2es4pL8sYTdScX3s7tgRIjyE5X5CKlxnE5X+QrdUwflvwYDRqltN9B?=
 =?us-ascii?Q?tAZksOVxhFN18YZ+fW3VpOpW/Xhdku0pEFXyijXDZQEktE3BSqDlPjiSqEqH?=
 =?us-ascii?Q?eFd1DIcuBvPVBYox5Mo5tT83SDotG6FkN9EGbc6ylBYLo05pWn6P72ZbXe7S?=
 =?us-ascii?Q?7lf15NbwqM1DU/pm+DeN3e1e4QHzViZJUapjyOl7c2Cjj0gfkFIKRrB4CWvn?=
 =?us-ascii?Q?7FrJXJXVeqahd586Pbj4rsJHTFk8iPWMHG4gU07jNjuCPB39MkiYI6qZ15j6?=
 =?us-ascii?Q?+FOnSunHS+ihER+VnvEFOQfbl6f+vnlBofm2Vcou4H/bvjYwoEcIJcmJfHon?=
 =?us-ascii?Q?n+QnLqW1zXClzseZcl719zrOjswgNWiLJNMwZLdxn6nGQkR/Dpez2Y7z3LHC?=
 =?us-ascii?Q?DU8/TeYSTRVRa+2f75P7f18ylibczjF4Nks+YXUlvgPUCdmPsD7VJle/r6cN?=
 =?us-ascii?Q?xiZmXHpvPjm8NBmU168Vvp6Hx04HnxX5ffQZcSNJ4oPe/YgQAI4i5ABC1P9i?=
 =?us-ascii?Q?ijTPN/WmxOTlLSUkMwrLzZOYKeliiuwwoVxHmmDH16/vU0uyRGXrEm+YgMOD?=
 =?us-ascii?Q?ul7ei1SoN3BH0gduaWxLxvo1RDu4EN/HI40L7f9cH/Wib11kYdmsmt/IYfGc?=
 =?us-ascii?Q?DgSEZQw0CHF4Dc9rjlMNaZt3j1kB998g5Ls79GOgEjNMVtfzs4aSVBoxxcXL?=
 =?us-ascii?Q?Wc4kKdzzX5hb4Bn87okaE33sIuIKc7ISoOKy/qk2YhXrCEgAVc32dwZmZ+rY?=
 =?us-ascii?Q?dicPgRRULoLT1uco0F4oFkELD/+kVHjVGfgtn99wOK4itOhotk1c1VX39wSy?=
 =?us-ascii?Q?vWCPRAdhxcp4s+guQVfVMYX7ccPMOJUbNMBXKt8Hkxs+9vAvfMuq5x2HXsFS?=
 =?us-ascii?Q?ibK3aVWgl57k5fNza8NlywiSG+JjS4itIKa4usFLtNdgWNpDJ5MIkbgtWymK?=
 =?us-ascii?Q?D96cZqqMoFIoc+dtVOqY+uZ9mjesSZCyowif6ScpDmOrOr5gqiHT6ku6FZaq?=
 =?us-ascii?Q?QocvLPlDEGqoLTEdamSO8K3pQnUd8tIOTkeO7Om0+Ccz4f5KwMkjbl960vS1?=
 =?us-ascii?Q?IIUqpwUCu07Wbn8+OVWI4Z8Xe65c47+abmNCvu14XFWhWgsgneyDfRQQXrLz?=
 =?us-ascii?Q?HEprirLf+FJbB7u0gEOCi3zlFJrxenMyZtZHHkhlzbfjyGFY5otaho5pCztR?=
 =?us-ascii?Q?6XrzVIdGJtJVegLCmcikrGvkuintWpl3wAnJJskFB3Zwfn0/OA4z6JTf1oJ4?=
 =?us-ascii?Q?LLiQRoBxd6aXSf5a9h2euI+A3L7MMpGgGOJf2p0Z73ycilyT2iE7DCp/Yx3f?=
 =?us-ascii?Q?pFWeHREQG9E7c++wdrs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c184413-bd0d-4c96-be37-08dcc79f4361
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 20:23:22.6019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R80fIZ2dcJntLH8Iq37sRLmGELf1ZKcbOi2v80z3NFm4H2rXpIos/GrFu/L6oMHK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4134

Since migratetype is no longer overwritten during pageblock isolation,
undoing pageblock isolation no longer needs which migratetype to restore.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/page-isolation.h | 3 +--
 mm/memory_hotplug.c            | 4 ++--
 mm/page_alloc.c                | 2 +-
 mm/page_isolation.c            | 9 +++------
 4 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index 6a62401410c3..c2a1bd621561 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -40,8 +40,7 @@ bool move_freepages_block_isolate(struct zone *zone, struct page *page);
 int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 			     int migratetype, int flags, gfp_t gfp_flags);
 
-void undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
-			     int migratetype);
+void undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn);
 
 int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
 			int isol_flags);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 721392906dcb..4265272faf4c 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1202,7 +1202,7 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
 		build_all_zonelists(NULL);
 
 	/* Basic onlining is complete, allow allocation of onlined pages. */
-	undo_isolate_page_range(pfn, pfn + nr_pages, MIGRATE_MOVABLE);
+	undo_isolate_page_range(pfn, pfn + nr_pages);
 
 	/*
 	 * Freshly onlined pages aren't shuffled (e.g., all pages are placed to
@@ -2104,7 +2104,7 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 
 failed_removal_isolated:
 	/* pushback to free area */
-	undo_isolate_page_range(start_pfn, end_pfn, MIGRATE_MOVABLE);
+	undo_isolate_page_range(start_pfn, end_pfn);
 	memory_notify(MEM_CANCEL_OFFLINE, &arg);
 failed_removal_pcplists_disabled:
 	lru_cache_enable();
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index dc7c36461953..4d06932ba69a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6679,7 +6679,7 @@ int alloc_contig_range_noprof(unsigned long start, unsigned long end,
 		     start, end, outer_start, outer_end);
 	}
 done:
-	undo_isolate_page_range(start, end, migratetype);
+	undo_isolate_page_range(start, end);
 	return ret;
 }
 EXPORT_SYMBOL(alloc_contig_range_noprof);
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 3ffdfddbdd50..4c65157d78ef 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -512,7 +512,7 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 		page = __first_valid_page(pfn, pageblock_nr_pages);
 		if (page && set_migratetype_isolate(page, migratetype, flags,
 					start_pfn, end_pfn)) {
-			undo_isolate_page_range(isolate_start, pfn, migratetype);
+			undo_isolate_page_range(isolate_start, pfn);
 			unset_migratetype_isolate(
 				pfn_to_page(isolate_end - pageblock_nr_pages));
 			return -EBUSY;
@@ -525,13 +525,10 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
  * undo_isolate_page_range - undo effects of start_isolate_page_range()
  * @start_pfn:		The first PFN of the isolated range
  * @end_pfn:		The last PFN of the isolated range
- * @migratetype:	New migrate type to set on the range
  *
- * This finds every MIGRATE_ISOLATE page block in the given range
- * and switches it to @migratetype.
+ * This finds and unsets every MIGRATE_ISOLATE page block in the given range
  */
-void undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
-			    int migratetype)
+void undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn)
 {
 	unsigned long pfn;
 	struct page *page;
-- 
2.45.2


