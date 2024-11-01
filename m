Return-Path: <linux-kernel+bounces-392422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7919B93EE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 16:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DD621F21D28
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 15:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D5E1AAE09;
	Fri,  1 Nov 2024 15:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LSccG+AY"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885B21A4F2B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 15:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730473462; cv=fail; b=aGsBK03g+ZZZB1CQ5GYKZzgQZoFNezYlkSiMdWUZnmvYR2BV6/k4jGUDaWf5iMN2TdN/D8WrprwGISHsDagHXMfbOmNqwDieZ0ZWPXve9njQZElpLoqPE3CN7KfpNOKIiJUfHSShAvtFYFNHxlOwUPAvsn3hMyKfq3SampTf4vQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730473462; c=relaxed/simple;
	bh=Jamppz00floVL1Vvvg54h/DIra0JoskiFGBq2mcKi64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ki9ZBpGxNYuf2ypLkyPQCW7pEV89zzPWpwwDJ7jkk6doR1g/n14jdCcLk6GdAPUx4FX0j4jJizDwjkrALP6EvFj77rAJf2X/c1bIc60AnF3pifPBdy7zbjGifAQfgyzcn1xoi+f0+cjck7Q1EojwE2UBBXTf+QUASSbUg8dwMKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LSccG+AY; arc=fail smtp.client-ip=40.107.223.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHVz29DmmK6auSY3sMz9Qh+l8gmdgEDZKlgfVhikODDLaoNPWE3k7WHJekV4hSYTZuE864ZhEDc6mqlaCwFPRh/x9oZvDKLPKmQFzCc6ufydaQW4XTT5mlQ8Kz8k/sg/jlHKHoJIhCM8sxbFsVmGWj8LPmU01zLg75GmMdybJs+lBnuAzPRjvwmV6GMizC0QhxxOz6c9Gk3my97guqN0ki7FF4ugojSqwHAGOS6KxAhByZU7QVFy7O3KjPQtCLRM0y2jaTKD7YITPZtXBX7IKxSN+hC3pwMHAU0bNsXUtJRv+DOgMzbiIFY9OkQDTNjbfZ+9fxdmI/yndZTinyTtVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJ7mtvl5+aRqSZmDpJAAE0enIUlEdEtuMZ5VoenL7co=;
 b=fWzUWqZRQnqTQHDe85hGeqtyp1TRjT4G69iPXVRQOkn3ahq7AopW7j5lHoQlF63/TJs/YdzK2SyIuRYdj7Y4k/QzaowQBEqbe/davsjIirZcwQIVA34xqE2zIw+Q+9YCA4yBHOT+Pq5q94kTGFmSU7N6I+JwJdUgaH0JaZ2ezHvM7I+WwrpxO4c8uGMabztfVaHUfyNyMfwoREuzjuONKKOj6q60zBGoZR7Z2mtIlGv8/QZzPPDvJMYGfgK0FlrNK4XkP9x4epIgQUiJPCAtqX+ylJ58NwZSMDufIxnexBSN8glWs+LxR39SeFu1Uu0MYRyqo/X37dT7On7eaSiI8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJ7mtvl5+aRqSZmDpJAAE0enIUlEdEtuMZ5VoenL7co=;
 b=LSccG+AYEttToFeO0f+mF13iWqqGGEQj0x2F8D1elSMexwrfO9RuzKzPCNKKVlRgoPZGcdj6yd9GqeryQQCNIdddKdQT3arH7Kab0NgEXUE8EF6IO3BcdmHKOeULrPBStpbp/f/xeCinytKYUXZABj5WsQmZ5Yk5Q+4xstI+MJK91NQgNmtpeWkRPCE5UmbZUfB7qpGruLTn2JzgIX9QTck7byYQ/kkUlLxFZVvzqGO/bYgFFJYJCI7tN4hMTkgcFkpEYbIEGrgDXULeQhya7XEU8O6GINNwTOj2bkqaS0S85ogzzBaHL5hbW8qOucgwNX9DnJ7n73TRGv0GJMqIWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH3PR12MB9453.namprd12.prod.outlook.com (2603:10b6:610:1c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.18; Fri, 1 Nov
 2024 15:04:08 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%7]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 15:04:08 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Yu Zhao <yuzhao@google.com>,
	John Hubbard <jhubbard@nvidia.com>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v2 1/6] mm/huge_memory: add two new (yet used) functions for folio_split()
Date: Fri,  1 Nov 2024 11:03:52 -0400
Message-ID: <20241101150357.1752726-2-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241101150357.1752726-1-ziy@nvidia.com>
References: <20241101150357.1752726-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0109.namprd03.prod.outlook.com
 (2603:10b6:408:fd::24) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH3PR12MB9453:EE_
X-MS-Office365-Filtering-Correlation-Id: 681b0ca5-bfe9-42c1-9813-08dcfa866f9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SkIMXVg5P3jbKaLprVOdyJ+Y2Z0AMp+iAnXsp83b2L5381qlPrcm3TXbxBfR?=
 =?us-ascii?Q?fR66ZgC+Jjpt6YQ5qZq7r4Sq2Lyvw/hWW5axeC8KmTgIfVySd7WjeMSY215e?=
 =?us-ascii?Q?LPi7fJR1V2StsYgnlLKNRP9wLmCOogcQ7hYI90p+pKk7FQxzFmUK/0/h0TYn?=
 =?us-ascii?Q?3rsiG9rHjUlCGwaOs7RZQip7POlP8C4AFIm1/0qS9UalLadnCsR6KyJKuUqm?=
 =?us-ascii?Q?pYlYQgugOmkFFUVgvcmYHNWEB769cosimwdPgelNlWAKFhLH2YwD6vZF/3/r?=
 =?us-ascii?Q?POTzzlHBnsKYTFI4zTQQFGhgIo6ehQ+dvkykbw5k+GUWEdVL6Cbtirx3bDbc?=
 =?us-ascii?Q?1oHVUuBqD+FFQHUZ+xQhJ0eLAc3mrSEZgmuXhwy6/abmkQarBbgPpu28EJgW?=
 =?us-ascii?Q?bb7l4XtT+pYFFoF9zEiY6EjXTgAeWT4WyrBa/ZwuW3az8IgD+7Noe4E6dbWR?=
 =?us-ascii?Q?Btdi7MoivSD+7XYIW0ARSCBzXd6Bqv8zk0mB5JGgF4wIvMQyuopEDXn9uOlJ?=
 =?us-ascii?Q?DbBeAOmxVQiXpT7GrPlv9XUG+FLZ8KineiFabwqThpRMB5S1SAD5VqmpH04y?=
 =?us-ascii?Q?HZtu3akR3xp36tKSi7vfFjTyFMrhZs381MjZY0/V6whsauiBhbeOWMWrQM8C?=
 =?us-ascii?Q?7mjLtoEIuBhmtBSDWwpREiDfh+h8Hu0T3L3CjQyl289+PwnGVg9URUJRIivR?=
 =?us-ascii?Q?3qqChyAuXhQMZArNIojl6BRbDlJYAB0iq2kExa86kNmlF93vwvNzIrrOOWYO?=
 =?us-ascii?Q?p2tJPe9iudC8uZftvVdgj3YON8dnHEimaValUyGN1BLpC52uB11pJQDcAPsQ?=
 =?us-ascii?Q?u2Uy5Bz31/IZWCxkNTWpRLYb37fjoOElM1lw3Yix2QchoYLFVaPjWll92mhW?=
 =?us-ascii?Q?t5djYZnirUPHaIXKwVJNC4TTkm+0Tf5k3pfE8ZolwQXf1zBeK6mp9O0/zZoI?=
 =?us-ascii?Q?iSx9aL+zFS/uydxgSraJkVem2DVY7mswB1gFAAlcSdyLlUYw8CXsF9oS0c4h?=
 =?us-ascii?Q?F2zuY/OjuwTwa4saTH+6Mkmc8em+KJkKSrec8JCmj2SQ9Am7M8t1WgArfvze?=
 =?us-ascii?Q?yWc0RgufdKPFWfj3pn3B5zGPMlggLkwVU+dJuZD/HZjNeU6okROdpEJu/N9v?=
 =?us-ascii?Q?FMNrwJPqnXcFM03imgjuJ1WEoA5u+K7NzyL0djVoaq++ZktAtp88GNKl+t77?=
 =?us-ascii?Q?EPRET/uSHVF1vGUxwULpcuKdLmhWyv6ULqkIgta0hkNR9iyp9tkqd0LdTgqD?=
 =?us-ascii?Q?nA+BZPMFoiegnTzPduCTzFhz3boHXpNRjBvteWOGX1LracXKGCyn++oe1gxy?=
 =?us-ascii?Q?ezsKyEJHBXnCw2wACiY/7WsM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qnp1EXSvt4oAOH81UHBiKlnSm8eZJSN29g6q73v6oUv8jtHHKVfmJGYR/Zna?=
 =?us-ascii?Q?OWh43nLtoO1zdExsd7JfAMYeS3ZTPonJoDXIdcX1/WtaE7YbCw+w8CAUFVvR?=
 =?us-ascii?Q?f6S5viXxuKveOrbWaDLiZP+XBp/QvQ+X2YSMs79NxOBT3b+S0vgBxda2RFAZ?=
 =?us-ascii?Q?M83kthAzMTFx4F79IBQ4OpQZnr9zctfOJ3guDDMq1YlvGLjAxOrKtQWh+CeP?=
 =?us-ascii?Q?BvhSqMmWH3cdispeP6DFcPsbgcFIV1e7j6fYLfhfv005JpLt5f3d7BMe6EGU?=
 =?us-ascii?Q?mrhC/RceFQq/Dc/tYVjNdlCTXVUlzQBvMikv0ApP9QX7LRlRqvtnaJT0HWBf?=
 =?us-ascii?Q?Rk6XPKr/5ATAgcijQO7q3O+2WfFC8oYcS+tcBUXkIBq9r8/ynXGsl/qDLIyZ?=
 =?us-ascii?Q?fKXSpPTAoyuWP5vkpCRldht0vpqDbw+cf+SPwYFuJU5UbHiqlEZKmkqdnguS?=
 =?us-ascii?Q?dMsNrh3l3KpMHvU7i3nMyaEm6eBGoOsI4S6W6bCPqtMBHmm9JraAX0IIyUQr?=
 =?us-ascii?Q?ABIwi2ip0l5FY3TfCkAnqx2Exldqwsq8rRV9b6ewOwRr7adsKuQ8ERmgrHqw?=
 =?us-ascii?Q?acRNOc7TrNM4oK09171qKxXgkzSXipMA/Cii4SHcL8hAExoKdJQ9+nNd3uGf?=
 =?us-ascii?Q?gWg49hL07FXEnkSD/GIjkfgwIZI/NaPFnvb5SIX9KcTyx1lAFlyH5TV6yJ6v?=
 =?us-ascii?Q?xBwOW6b+oRiUnN/qFEzX3y2ZZ5cNEB/d2rmX7qqz6tnXvS4A1MZtlTUO3FaC?=
 =?us-ascii?Q?8tKem99Ps8AKl27iBm1iJU4IIEdeJIbv+1/TQSzK8MOGouMb2I1feikWol1K?=
 =?us-ascii?Q?SpdDkLTMFPPDVHJwOOHZ5BJRJzOyhm4vh23ifaMWUD0w/logbGap6NSyhVrb?=
 =?us-ascii?Q?6fDcXp+sCTFKx72uNmXuw2F9laBHLF85G7yeSPcqrONPir4HgSWuurdyq9lC?=
 =?us-ascii?Q?Gn3/jDwZg6Mnl5f1hdSHQhp+DfwMtsjm10ClgOZzxczxYa7/dXpG7ccDEaPO?=
 =?us-ascii?Q?HG5ZNBSeOuhdoiNuL9/qdh0Wwwa0RbLO+ILUFOVVxWxVWwN7rsz72An+D+PI?=
 =?us-ascii?Q?nJXAaroMS8C6bC4wWpOBymAwoSaJ0/hFmtONeSh1SpA+We/Fm9Qivl31wUvS?=
 =?us-ascii?Q?ZGlBoZy9avZSHA0kjAs0j6xCVXRGZYotxUq5BFEN7dN7oFWPzLdT7bg0yMDp?=
 =?us-ascii?Q?81oSkGhSsmcZEPSFxV0Ehjt4F3FYAzrkH0Opw1SDtXVfpa4+RKAbG4QQDCjF?=
 =?us-ascii?Q?fPJXlefZDF0xIsMitVhkLa1ZYTXtDggVDAUSU368HHFajFcj0C4rC1hj7B58?=
 =?us-ascii?Q?QE7LHaplwW9Pb9h5Lto1mIVuJolL0Dnz5/clfH5f99OTdl3HHLgN5ohVWHYJ?=
 =?us-ascii?Q?pJStEuO1XmzA8h4FRCgBekjLU31WEQiqu5R/Q/geDaGJodD8oUIhnADWV2/F?=
 =?us-ascii?Q?wNBAcV9OBRxYo+xbp1CPUvxdfAqqNpi5UMmD78x70iVTyyBHJQzOneHgdY8c?=
 =?us-ascii?Q?F3f63j5zoiDIwUqC6LhZmPS7supr8LPynq3Ayh++cOyAgpRUBrTMg7GUoWsN?=
 =?us-ascii?Q?O79Om6usN/m2LzHrrKv9Klv8kC/1aLaah2BewqZR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 681b0ca5-bfe9-42c1-9813-08dcfa866f9f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 15:04:08.6370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PD/jTcoBynkQMgMF/tkvN8EHQdzLdfxV5C/XloNNzL+OaNZJKniqep0GnGEleZcu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9453

This is a preparation patch, both added functions are not used yet.

The added __folio_split_without_mapping() is able to split a folio with
its mapping removed in two manners: 1) uniform split (the existing way),
and 2) buddy allocator like split.

The added __split_folio_to_order() can split a folio into any lower order.
For uniform split, __folio_split_without_mapping() calls it once to split
the given folio to the new order. For buddy allocator split,
__folio_split_without_mapping() calls it (folio_order - new_order) times
and each time splits the folio containing the given page to one lower
order.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 328 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 327 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f92068864469..f7649043ddb7 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3135,7 +3135,6 @@ static void remap_page(struct folio *folio, unsigned long nr, int flags)
 static void lru_add_page_tail(struct folio *folio, struct page *tail,
 		struct lruvec *lruvec, struct list_head *list)
 {
-	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
 	VM_BUG_ON_FOLIO(PageLRU(tail), folio);
 	lockdep_assert_held(&lruvec->lru_lock);
 
@@ -3379,6 +3378,333 @@ bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins)
 					caller_pins;
 }
 
+static long page_in_folio_offset(struct page *page, struct folio *folio)
+{
+	long nr_pages = folio_nr_pages(folio);
+	unsigned long pages_pfn = page_to_pfn(page);
+	unsigned long folios_pfn = folio_pfn(folio);
+
+	if (pages_pfn >= folios_pfn && pages_pfn < (folios_pfn + nr_pages))
+		return pages_pfn - folios_pfn;
+
+	return -EINVAL;
+}
+
+/*
+ * It splits @folio into @new_order folios and copies the @folio metadata to
+ * all the resulting folios.
+ */
+static int __split_folio_to_order(struct folio *folio, int new_order)
+{
+	int curr_order = folio_order(folio);
+	long nr_pages = folio_nr_pages(folio);
+	long new_nr_pages = 1 << new_order;
+	long index;
+
+	if (curr_order <= new_order)
+		return -EINVAL;
+
+	for (index = new_nr_pages; index < nr_pages; index += new_nr_pages) {
+		struct page *head = &folio->page;
+		struct page *second_head = head + index;
+
+		/*
+		 * Careful: new_folio is not a "real" folio before we cleared PageTail.
+		 * Don't pass it around before clear_compound_head().
+		 */
+		struct folio *new_folio = (struct folio *)second_head;
+
+		VM_BUG_ON_PAGE(atomic_read(&second_head->_mapcount) != -1, second_head);
+
+		/*
+		 * Clone page flags before unfreezing refcount.
+		 *
+		 * After successful get_page_unless_zero() might follow flags change,
+		 * for example lock_page() which set PG_waiters.
+		 *
+		 * Note that for mapped sub-pages of an anonymous THP,
+		 * PG_anon_exclusive has been cleared in unmap_folio() and is stored in
+		 * the migration entry instead from where remap_page() will restore it.
+		 * We can still have PG_anon_exclusive set on effectively unmapped and
+		 * unreferenced sub-pages of an anonymous THP: we can simply drop
+		 * PG_anon_exclusive (-> PG_mappedtodisk) for these here.
+		 */
+		second_head->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
+		second_head->flags |= (head->flags &
+				((1L << PG_referenced) |
+				 (1L << PG_swapbacked) |
+				 (1L << PG_swapcache) |
+				 (1L << PG_mlocked) |
+				 (1L << PG_uptodate) |
+				 (1L << PG_active) |
+				 (1L << PG_workingset) |
+				 (1L << PG_locked) |
+				 (1L << PG_unevictable) |
+#ifdef CONFIG_ARCH_USES_PG_ARCH_2
+				 (1L << PG_arch_2) |
+#endif
+#ifdef CONFIG_ARCH_USES_PG_ARCH_3
+				 (1L << PG_arch_3) |
+#endif
+				 (1L << PG_dirty) |
+				 LRU_GEN_MASK | LRU_REFS_MASK));
+
+		/* ->mapping in first and second tail page is replaced by other uses */
+		VM_BUG_ON_PAGE(new_nr_pages > 2 && second_head->mapping != TAIL_MAPPING,
+			       second_head);
+		second_head->mapping = head->mapping;
+		second_head->index = head->index + index;
+
+		/*
+		 * page->private should not be set in tail pages. Fix up and warn once
+		 * if private is unexpectedly set.
+		 */
+		if (unlikely(second_head->private)) {
+			VM_WARN_ON_ONCE_PAGE(true, second_head);
+			second_head->private = 0;
+		}
+		if (folio_test_swapcache(folio))
+			new_folio->swap.val = folio->swap.val + index;
+
+		/* Page flags must be visible before we make the page non-compound. */
+		smp_wmb();
+
+		/*
+		 * Clear PageTail before unfreezing page refcount.
+		 *
+		 * After successful get_page_unless_zero() might follow put_page()
+		 * which needs correct compound_head().
+		 */
+		clear_compound_head(second_head);
+		if (new_order) {
+			prep_compound_page(second_head, new_order);
+			folio_set_large_rmappable(new_folio);
+
+			folio_set_order(folio, new_order);
+		} else {
+			if (PageHead(head))
+				ClearPageCompound(head);
+		}
+
+		if (folio_test_young(folio))
+			folio_set_young(new_folio);
+		if (folio_test_idle(folio))
+			folio_set_idle(new_folio);
+
+		folio_xchg_last_cpupid(new_folio, folio_last_cpupid(folio));
+	}
+
+	return 0;
+}
+
+#define for_each_folio_until_end_safe(iter, iter2, start, end)	\
+	for (iter = start, iter2 = folio_next(start);		\
+	     iter != end;					\
+	     iter = iter2, iter2 = folio_next(iter2))
+
+/*
+ * It splits a @folio (without mapping) to lower order smaller folios in two
+ * ways.
+ * 1. uniform split: the given @folio into multiple @new_order small folios,
+ *    where all small folios have the same order. This is done when
+ *    uniform_split is true.
+ * 2. buddy allocator like split: the given @folio is split into half and one
+ *    of the half (containing the given page) is split into half until the
+ *    given @page's order becomes @new_order. This is done when uniform_split is
+ *    false.
+ *
+ * The high level flow for these two methods are:
+ * 1. uniform split: a single __split_folio_to_order() is called to split the
+ *    @folio into @new_order, then we traverse all the resulting folios one by
+ *    one in PFN ascending order and perform stats, unfreeze, adding to list,
+ *    and file mapping index operations.
+ * 2. buddy allocator like split: in general, folio_order - @new_order calls to
+ *    __split_folio_to_order() are called in the for loop to split the @folio
+ *    to one lower order at a time. The resulting small folios are processed
+ *    like what is done during the traversal in 1, except the one containing
+ *    @page, which is split in next for loop.
+ *
+ * After splitting, the caller's folio reference will be transferred to the
+ * folio containing @page. The other folios may be freed if they are not mapped.
+ *
+ * In terms of locking, after splitting,
+ * 1. uniform split leaves @page (or the folio contains it) locked;
+ * 2. buddy allocator like split leaves @folio locked.
+ *
+ * If @list is null, tail pages will be added to LRU list, otherwise, to @list.
+ *
+ * For !uniform_split, when -ENOMEM is returned, the original folio might be
+ * split. The caller needs to check the input folio.
+ */
+static int __folio_split_without_mapping(struct folio *folio, int new_order,
+		struct page *page, struct list_head *list, pgoff_t end,
+		struct xa_state *xas, struct address_space *mapping,
+		bool uniform_split)
+{
+	struct lruvec *lruvec;
+	struct address_space *swap_cache = NULL;
+	struct folio *origin_folio = folio;
+	struct folio *next_folio = folio_next(folio);
+	struct folio *new_folio;
+	struct folio *next;
+	int order = folio_order(folio);
+	int split_order = order - 1;
+	int nr_dropped = 0;
+	int ret = 0;
+
+	if (folio_test_anon(folio) && folio_test_swapcache(folio)) {
+		if (!uniform_split)
+			return -EINVAL;
+
+		swap_cache = swap_address_space(folio->swap);
+		xa_lock(&swap_cache->i_pages);
+	}
+
+	if (folio_test_anon(folio))
+		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
+
+	/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
+	lruvec = folio_lruvec_lock(folio);
+
+	/*
+	 * split to new_order one order at a time. For uniform split,
+	 * intermediate orders are skipped
+	 */
+	for (split_order = order - 1; split_order >= new_order; split_order--) {
+		int old_order = folio_order(folio);
+		struct folio *release;
+		struct folio *end_folio = folio_next(folio);
+		int status;
+		bool stop_split = false;
+
+		if (folio_test_anon(folio) && split_order == 1)
+			continue;
+		if (uniform_split && split_order != new_order)
+			continue;
+
+		if (mapping) {
+			/*
+			 * uniform split has xas_split_alloc() called before
+			 * irq is disabled, since xas_nomem() might not be
+			 * able to allocate enough memory.
+			 */
+			if (uniform_split)
+				xas_split(xas, folio, old_order);
+			else {
+				xas_set_order(xas, folio->index, split_order);
+				xas_set_err(xas, -ENOMEM);
+				if (xas_nomem(xas, 0))
+					xas_split(xas, folio, old_order);
+				else {
+					stop_split = true;
+					ret = -ENOMEM;
+					goto after_split;
+				}
+			}
+		}
+
+		split_page_memcg(&folio->page, old_order, split_order);
+		split_page_owner(&folio->page, old_order, split_order);
+		pgalloc_tag_split(folio, old_order, split_order);
+
+		status = __split_folio_to_order(folio, split_order);
+
+		if (status < 0)
+			return status;
+
+after_split:
+		/*
+		 * Iterate through after-split folios and perform related
+		 * operations. But in buddy allocator like split, the folio
+		 * containing the specified page is skipped until its order
+		 * is new_order, since the folio will be worked on in next
+		 * iteration.
+		 */
+		for_each_folio_until_end_safe(release, next, folio, end_folio) {
+			if (page_in_folio_offset(page, release) >= 0) {
+				folio = release;
+				if (split_order != new_order && !stop_split)
+					continue;
+			}
+			if (folio_test_anon(release))
+				mod_mthp_stat(folio_order(release),
+						MTHP_STAT_NR_ANON, 1);
+
+			/*
+			 * Unfreeze refcount first. Additional reference from
+			 * page cache.
+			 */
+			folio_ref_unfreeze(release,
+				1 + ((!folio_test_anon(origin_folio) ||
+				     folio_test_swapcache(origin_folio)) ?
+					     folio_nr_pages(release) : 0));
+
+			if (release != origin_folio)
+				lru_add_page_tail(origin_folio, &release->page,
+						lruvec, list);
+
+			/* Some pages can be beyond EOF: drop them from page cache */
+			if (release->index >= end) {
+				if (shmem_mapping(origin_folio->mapping))
+					nr_dropped++;
+				else if (folio_test_clear_dirty(release))
+					folio_account_cleaned(release,
+						inode_to_wb(origin_folio->mapping->host));
+				__filemap_remove_folio(release, NULL);
+				folio_put(release);
+			} else if (!folio_test_anon(release)) {
+				__xa_store(&origin_folio->mapping->i_pages,
+						release->index, &release->page, 0);
+			} else if (swap_cache) {
+				__xa_store(&swap_cache->i_pages,
+						swap_cache_index(release->swap),
+						&release->page, 0);
+			}
+		}
+		xas_destroy(xas);
+	}
+
+	unlock_page_lruvec(lruvec);
+
+	if (folio_test_anon(origin_folio)) {
+		if (folio_test_swapcache(origin_folio))
+			xa_unlock(&swap_cache->i_pages);
+	} else
+		xa_unlock(&mapping->i_pages);
+
+	/* Caller disabled irqs, so they are still disabled here */
+	local_irq_enable();
+
+	if (nr_dropped)
+		shmem_uncharge(mapping->host, nr_dropped);
+
+	remap_page(origin_folio, 1 << order,
+			folio_test_anon(origin_folio) ?
+				RMP_USE_SHARED_ZEROPAGE : 0);
+
+	/*
+	 * At this point, folio should contain the specified page, so that it
+	 * will be left to the caller to unlock it.
+	 */
+	for_each_folio_until_end_safe(new_folio, next, origin_folio, next_folio) {
+		if (uniform_split && new_folio == folio)
+			continue;
+		if (!uniform_split && new_folio == origin_folio)
+			continue;
+
+		folio_unlock(new_folio);
+		/*
+		 * Subpages may be freed if there wasn't any mapping
+		 * like if add_to_swap() is running on a lru page that
+		 * had its mapping zapped. And freeing these pages
+		 * requires taking the lru_lock so we do the put_page
+		 * of the tail pages after the split is complete.
+		 */
+		free_page_and_swap_cache(&new_folio->page);
+	}
+	return ret;
+}
+
 /*
  * This function splits a large folio into smaller folios of order @new_order.
  * @page can point to any page of the large folio to split. The split operation
-- 
2.45.2


