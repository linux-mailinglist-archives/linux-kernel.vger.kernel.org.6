Return-Path: <linux-kernel+bounces-515227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22959A36207
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0437B189442D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFCA2676CF;
	Fri, 14 Feb 2025 15:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WokOkzZC"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B61C267384
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547758; cv=fail; b=KiOV0mYiQztQsUIAzOoovimvWSoEtkKc6rw0ZWH8OprUDMFwQT3Nm/KlbeRt8km+vmX6yiDB5Dlw9bliL5ZTH7IZUPLUcuL1W8mIOA5H+jkoAIQ2e/cz/5REoshJWM9DPnt+rXZt+dcs+o1Ztnil5k8LJCrCUSOpTl4kjPM7nC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547758; c=relaxed/simple;
	bh=95TAqSnbMUxiycANJHOWr0E+7GMDlT/YmTXghrjOSNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jxJmTDJQ7Tyz0pwfEIW/27sskzm60Qs30IJ86dwueebAM+9S/Eysv9LBjDj+6mfDBbrAehamXmwPhZ46ED8xrchaQpPYCMRy0IU8raDBKmT4YkHVUY+sGhBsmylh8sK/rZm+XIh1LjzHsQ8LlVPB6RKrDMyQLVtEwK1lUuyRrFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WokOkzZC; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UnWSmqMgt0aUV+4oTTJHrsv/9u6AajD7JjuqhWoB8k/KWUbINnc+xBrsh6mKoWJZFkIsAK7OJ2hIGTboLQ5xcZLvJUppaTk8J6edIIhtzg+zc68OrOBz7XCjSmDZB8+tYBewHh1+o8vn3h6GtzAFjFAyobi/MGnTpXwAxo/fXr+7l3c8/ky9oSgpwILIfC64Dl2pNrhY2na7wUcGHeU0a8SFLtrYof/ypF1K9dwteGsf6MnS4GjWBC2Wpp3JvZy5H5i6uQqe+3XGdzB765idaj9jkxAiNIu9n6rwTUejYjgPexPzgueM/ZoFyx2Ry8hQ8WIp1q0O0PMwrwBmD7f2Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sizwI47ZLkUjZJnH3dOI3jZ9Fu2HYfFAi247w0Nv8A=;
 b=LvCJlymzbnE71AlQYRKW5Orjhpm/xiMmJ5vEX9XmT0nh1wGJ1EYnHvLhqXsHjLqnW2QzRGzud9dquxLYVvXwIIhJZeehd62P/uFXuiCoWV/Xc/jtNm+DJ8aqphIgY7MNUs8WmLCNxVs6vr7tesKMXzQNI93cOKL53LuPtvnLsykpe0TLYsVJN+2ZERzbIFwzPklGzOyWrEbIzJL5ZTP/8IAgq0cEdwJFOVZmNd2Q0kvQgk0PgwoRr8Vk6DvUM2LtJU0naRF2Cp/d3mHF8hQ69OXuaxSJ2t2WRaSTlU6r5atIxH47TgDq9DZrxYHVPKAo89iA1lY8awRYZMycA8v3mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sizwI47ZLkUjZJnH3dOI3jZ9Fu2HYfFAi247w0Nv8A=;
 b=WokOkzZC0h/qwkvM9waNljhg1R8kdCPm+BEnJKuPRwcxYEZ/XSaTiEDHM7eZz2Se9MzyuguvDX06K9mukSnr36Ej8EaXzUex2d8m+S84K0VI6wbAJSEE3w2xyK55OCN+G/ase7cm8pZR7Du5ea7InltgzWdUWNbm5ujXTKe5uKheBNj9ybCG+12NTcIrY6JTJQw+hyZeL0sC9DsszrV9PcVMuJul0s0GEewZHu9kHkXwxIkL2pKmH4FknhBnOoLdZpnon+sTOIdghpC0rSWabkR7Lm2VyuutLjVOxyirTzxl58rVUgbcKOgGm+qw5XfmAI2QqO6Hy4JZ9yhVf2nAyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY8PR12MB8339.namprd12.prod.outlook.com (2603:10b6:930:7e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.14; Fri, 14 Feb 2025 15:42:27 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 15:42:27 +0000
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
Subject: [PATCH v2 3/4] mm/page_isolation: remove migratetype from undo_isolate_page_range()
Date: Fri, 14 Feb 2025 10:42:14 -0500
Message-ID: <20250214154215.717537-4-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250214154215.717537-1-ziy@nvidia.com>
References: <20250214154215.717537-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::9) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY8PR12MB8339:EE_
X-MS-Office365-Filtering-Correlation-Id: 47e1e1be-5606-4a10-e9a2-08dd4d0e2f2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lsT9itf52KMQqJXn776MRUdHBzrpBCOVWqkPGmJrV2FuvwQtEZ7chIrtF61C?=
 =?us-ascii?Q?wsr714Rf63FiT+8WoWo2pC1zdA9pwOyoXpr/Ov3dYBhun9Kcre2/2z2Ghb6H?=
 =?us-ascii?Q?bWHJBIHJdEmYe+l53U4r77/fITgR31nY1xSu3dbx4lARUU3rmNBell/5Jek9?=
 =?us-ascii?Q?yCA8lRebZEx2liXo/qm960ly7jS1InGNITXMFtY44haKxFSUtmnWzmxur1RU?=
 =?us-ascii?Q?55G0cEpPXkIZVU7tQPY1BS0Iz3La51RjkoMp922ICwvozxvIDFM75ifLb0W+?=
 =?us-ascii?Q?CYpZlMgu9kpMnPrYY6dBbHhGAduJfZ4P+YJeUb8HfDsOCwdU9FPcAgwvg5hj?=
 =?us-ascii?Q?dK5nsy4qLp2qZWWmRpbwRABdy//dPyoopOHDj7hwZXvDXKg8VykG3fHURuAF?=
 =?us-ascii?Q?QdYsGOO5Riida+HUrfQP9SO4kFL0mHeY6vgdZZzA9m+GGsWFCjHBxI7yp+8F?=
 =?us-ascii?Q?WJ+N5m23iWFPULHsWt978UOwRmcpN118RpNNDpkE2/PuQIQg1owD9L60VbXx?=
 =?us-ascii?Q?NkesEj60WM8Ye8/QF2NZcW6SEcWvF1RgaWACBLwg6WMauB3yn2tXopVZju9l?=
 =?us-ascii?Q?nGSy+ccxJcgPwiBVtpGHqUdABAqboMUdpaTAsB9Tpss7O39BbcubQ6pw5PC8?=
 =?us-ascii?Q?FJuGmSi31wxyeq0suc5W7cLYJxikFkSZRO25Em/4PaEiHM5Wdtm7+Cn3PoXN?=
 =?us-ascii?Q?93ISrQuP3WpwZJHxg/8RCu/0uNNArwZDJQCtDx3PGum/ZpjtBr1exvjgO8V1?=
 =?us-ascii?Q?RMPn9YQlmHthhybjX7bvAh+rMmGOjwZDaLU0wxyoR5MeSWOIeLxw83x5YnoT?=
 =?us-ascii?Q?bI2uhqWyiIx9uXM7HLRSUgy8Zu37kmiQ6SYj7xad7z6nJzPzeYJFATidGMqn?=
 =?us-ascii?Q?T49xyI6jQGRW6YX6+62ciE13/fewdsTowtbHxOFHXhcYwkNFm7/5/+Zfsr4E?=
 =?us-ascii?Q?fI/qGoszNEvTJkxCvljGabRO6CBfCIc+YftxBlPpAvk70SA0lETyl8qTtGGt?=
 =?us-ascii?Q?lyExYkTNwDEWLl2lVv28Xd0ZDRv/S4ZCTCFiK9Bz39DYmjH0E1/RFvDQcKqg?=
 =?us-ascii?Q?Jjl77toL/EwkP0FbMNUbcFytkjGXnvlyqoZpYTG0+G2Fa6jXRceJPdBkuQCB?=
 =?us-ascii?Q?afeXt5IvLVepuFaQF3ubdGW5K2QGWFVrjaLxG1+XAtykf3Z1o2h237PmjdB9?=
 =?us-ascii?Q?+BkqJlMKd6iYPvsyIL7hC311oLs4ZF/MM7Grd3gU1dQL5BheFQA78PwRJ2xZ?=
 =?us-ascii?Q?WnX20FwOngexY9gUrGkivLh8YTIgoGVYAKZRRunWOF6MF/7tdBJ4DFqRqYmA?=
 =?us-ascii?Q?g9rwBkBg0f3r/T2cFszbNKj9Fkk69vzVjSj34XQcLrU4RTV4HT3J3MTqmJ4I?=
 =?us-ascii?Q?pWPQvwW0mOQ3cvTmBs/Kqo26S+mq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dSBupQgC4fo4tAGvaYdU2BylL075qwT6WmahjUrMTos/lFdFQyP4TT09cSwS?=
 =?us-ascii?Q?jXTY1AapQClXYYttefdDqZ4DpGlBoHeT5qJnJQ47qgZ4yibCwKA2z0OXAe1O?=
 =?us-ascii?Q?70aSRaRd0WUqjehQVOPf2J/fSBAD7ldr2KAwDAiCyZjZHnQZHHIZNtVZFfE3?=
 =?us-ascii?Q?mBYXd5HrSlSOA5u1FssIWzjZF0yJKu1wRXHavJSrZw5w0J30bRVGAwMuEkks?=
 =?us-ascii?Q?EH5DV0Znj26b774rx1CxeN440vwJNO/7j1bpmYKgtTjkCySaD3UP4RRYhUSu?=
 =?us-ascii?Q?vK/YR6/kz9nGkw6eZUJjUPhMSDHSPhCAZO+f+4FavQdkCv04/eRgYRu8wxEe?=
 =?us-ascii?Q?htiK110DW9U9L4uUakfrGDEXg39cURlgGRFnptqJzpVjXCiP9fFekVFfvL7h?=
 =?us-ascii?Q?zbF8vuJEU4hD7NkSnBy+sTDmZHcJOPqtoJCNTfxt6n+AyPOTGmTXOLnPXZjV?=
 =?us-ascii?Q?9AD6hChwd+N5b+NZIMJY3xn9CN9nkgkhUUc1ZGvKLBOGPl6828XIqdcInrUX?=
 =?us-ascii?Q?EyZgQAWqf0k0WPRf2f/Hxdn+uDyBW2KyxdoGs+qPypjyJjPn6Uvpun9F0Pa3?=
 =?us-ascii?Q?iY+E5UcSfM8hOa2Hx24uUIWjbFHJ78NskO3VZhb2U2F9Zl/xCZsBi9kGdGBK?=
 =?us-ascii?Q?1MMTNJQ41JtHuN/+eb1OnweVlqKaHvTFpRONxNgdMhMJKz4rbMA78hgOn9Oc?=
 =?us-ascii?Q?EtMBlaV1ZxmdA0FEZiM7WdtOqE5fKpT4M/i6KEFJg6TZS/kuOKkWB2uteu6C?=
 =?us-ascii?Q?PvZVLeZcWEreQDau024q2BvDnbJ7ge1EZEi1a6dEaI30IPjGWMt5zmX6b1R8?=
 =?us-ascii?Q?BfvL4Q4DFsiASJDWq5E5Y865qP08FbXPsM7w0akckwZwV0FjpLUw9ffJdrKl?=
 =?us-ascii?Q?eCJeIzNcCSDeGJg43uUGxWJ6pT0YlHMEf0GUyVjnhXlNjtjF7/HOaBS1Y2aN?=
 =?us-ascii?Q?vqoAvddGhWPvuVULWucsKbzeg/ZurMJmPuGzIZMgkFjuDAvMcIR7r5GGMt/u?=
 =?us-ascii?Q?lhU5sGCxbQFvQ9V+a6GSHzB1v16GCWIuRFm2YmK3V0Bf7OX7Ig4bompPlgq1?=
 =?us-ascii?Q?lFa6GZLfZnk0c2hev3BvhVCNRwE37K74L4IxvVBvHr2v0KcvykLPaN6LFEIY?=
 =?us-ascii?Q?P3HCIbgQJUAEHiJ5lPB4D+/6+Sx2FhcsTv5jSWTbqY/oezM2TiNGY74k+uxJ?=
 =?us-ascii?Q?auKNNNfArk/t+H1wn6aWY0eZy9z2Gw4XVq6t5bS5YM278WpiubkLndE3fspH?=
 =?us-ascii?Q?wchR6cduein3p2y5P9FyLcOPdNLFpr2Z6oGhaEppeYnMycnoqpETNCbIP9E1?=
 =?us-ascii?Q?LmcTph3UhrtQMgEDX5fr2QA6fNqwcNM9MERqoazjiEWtLpX7HRvJXvii4ix2?=
 =?us-ascii?Q?Oi0JQAcxa/oiCNrCQfHs/lrC2z9Bxkd/46kzpjMquEd8zxXNSKUxG9nrgFQH?=
 =?us-ascii?Q?VSkOd3+9mBZSr1IeHvbM5S5wUmzL7M5EN2nrddn+tm9zFdPo8GAW+XGTRLR5?=
 =?us-ascii?Q?rbVQ1XsXh6v3toTWhVNOQyxMpMjFFjUGx9+gWOqUq/RXNDRISMfSFHHCqYgQ?=
 =?us-ascii?Q?DACZeOe/UImfWWRNVosHm0kBIFSBaqlDb3jpXCK4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e1e1be-5606-4a10-e9a2-08dd4d0e2f2e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 15:42:27.4232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/fWrmggcDwZdEVLzkBY8y9r8/ewd/G4KM0zljlgY6SC0U4YsfG8dcD9OaolWriP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8339

Since migratetype is no longer overwritten during pageblock isolation,
undoing pageblock isolation no longer needs which migratetype to restore.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-isolation.h | 3 +--
 mm/memory_hotplug.c            | 4 ++--
 mm/page_alloc.c                | 2 +-
 mm/page_isolation.c            | 9 +++------
 4 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index 28c56f423e34..b8b44d3aacd4 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -33,8 +33,7 @@ bool pageblock_unisolate_and_move_free_pages(struct zone *zone, struct page *pag
 int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 			     int migratetype, int flags);
 
-void undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
-			     int migratetype);
+void undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn);
 
 int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
 			int isol_flags);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index e3655f07dd6e..fb2216f267d8 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1229,7 +1229,7 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
 		build_all_zonelists(NULL);
 
 	/* Basic onlining is complete, allow allocation of onlined pages. */
-	undo_isolate_page_range(pfn, pfn + nr_pages, MIGRATE_MOVABLE);
+	undo_isolate_page_range(pfn, pfn + nr_pages);
 
 	/*
 	 * Freshly onlined pages aren't shuffled (e.g., all pages are placed to
@@ -2128,7 +2128,7 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 
 failed_removal_isolated:
 	/* pushback to free area */
-	undo_isolate_page_range(start_pfn, end_pfn, MIGRATE_MOVABLE);
+	undo_isolate_page_range(start_pfn, end_pfn);
 	memory_notify(MEM_CANCEL_OFFLINE, &arg);
 failed_removal_pcplists_disabled:
 	lru_cache_enable();
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9bba5b1c4f1d..4b251aa35b73 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6673,7 +6673,7 @@ int alloc_contig_range_noprof(unsigned long start, unsigned long end,
 		     start, end, outer_start, outer_end);
 	}
 done:
-	undo_isolate_page_range(start, end, migratetype);
+	undo_isolate_page_range(start, end);
 	return ret;
 }
 EXPORT_SYMBOL(alloc_contig_range_noprof);
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 01d9a4eace7a..095cb2152fae 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -515,7 +515,7 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 		page = __first_valid_page(pfn, pageblock_nr_pages);
 		if (page && set_migratetype_isolate(page, migratetype, flags,
 					start_pfn, end_pfn)) {
-			undo_isolate_page_range(isolate_start, pfn, migratetype);
+			undo_isolate_page_range(isolate_start, pfn);
 			unset_migratetype_isolate(
 				pfn_to_page(isolate_end - pageblock_nr_pages));
 			return -EBUSY;
@@ -528,13 +528,10 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
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
2.47.2


