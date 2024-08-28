Return-Path: <linux-kernel+bounces-305648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 110FA9631B0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 22:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 355FF1C21E3E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2D71AC440;
	Wed, 28 Aug 2024 20:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sXFVcIOv"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A788515749A
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 20:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724876601; cv=fail; b=kfq9o2ZFgJp0Uk//ARlLvR+Wz/rgCnnZsmAguS3SEavxXFQcIRNqZEcoAAFV3xoRF0WzeQxFlkyDRXIbsDRXqXkXuaekdNtt9j982ysYtKGFYqj+AHJ0uNjHTOpGbj4saO+ZdIZ9v1uMFRAqVgrc0CYx28L2rBzJtMv0Nqf4heY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724876601; c=relaxed/simple;
	bh=AObhvNKXOnB6S0vkwbdEokzd5/0qSJok3x02Zqivsss=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LKGBoDbuW6N+Yq2R06DmvaWbsuN3Gv+I8w4rgYsmIKkgvm5HG5ySvU7gQ2XNKYYsnfEuQWfrSupRnf+KtDJO/ZLvRH2gmk9vTJzYoTIXdu0VVV1EcvGkvJJK9USTqLNlaaHwnPluInf3cFfdQ5slYopf/q/3GN/Fvv1w8xzh2Bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sXFVcIOv; arc=fail smtp.client-ip=40.107.244.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VL/V0SiQbYRH3QUirWKYz+ksXrkV/jFmnj8F/dzUNR1r4dML9ZoktGnEz1Eksew4ShnR2yEtUekkrpH8jvBldDwjVHYK44GM1fw+XqRXxZkRZpTsQFgMBDVGbm5fkB0RFQJF3sEvZuMeND+BpQFvCUAKl6FnkCMaHTaimt6rZU8j4XO4bN6CldZ6jxMzzCUUrcbkcP5vjsUBAe6pJxeBYzYptmkJ4qvWjmu6FU6Q3DTHwVa3i2XWn/vm1HRFH5WXZrK2YQUKmr5VHvu2GNLWA2UZNLZhPU6FX+pgh/cxSTpaqRontmOksm4r1uLIo+LfoYv3/naylBDNuxzMPcnKeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rF4GFhZtpkAgCDrW2l1v2e2oADWA0x5bUlTOwY/tGE=;
 b=DUoBBqY73edSEHB3YCE93pb+FNjinqApmjSkMqjUuAvM1CdXBK/XFrXnkLUkb5qPQFvVyAikVkfbiFJSJjrrfLJ9rjPVlCugonAAcgof1gYqFFRGrAYN4WgyHSe5Lapkk007TbpkL3zuKfh1V3UQwZBVM2rzJuD1zcr73SU4MPUzrzfnIlQcs+DE2Cs7uJ8bDOGaa5LJlz/tbx51uqVQQwm6MKcrnp/Hyh532lnLsi/597jlKT9kBG8tQ8cmg08Het5SK6/X7faTHmo6dFUE3bLFvkevPJD1RwMlVQw1WZHX7rH9KiuE3PeBhruFqMgJYsRuARA5QT6ii+ezGPs4PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rF4GFhZtpkAgCDrW2l1v2e2oADWA0x5bUlTOwY/tGE=;
 b=sXFVcIOvcJj/jpxvUM5vpTubNwcGQfcvRs0HAA27GdpvNG9rsKxWkjMfD4k+lPz9dQ7eIqJfe9kkeE0Chh61WVPt3ntryCMNn2402qf06+EaXwCQopAilkpQMUHoFkkbJPOziT//zjs/heJim9dUiK9WAqX3kmu6OkLQZCvusJnuGzpTqiE7wxmgfTYzqSbn/AnXnxDzia2U9GcwMsWoSwxQz9Xsj2JmuyKd7att8kEnCLHPYeRyBZaCFhstAlhde0xYijnZoc4HdT/nuqZGnvYq1+LbZ7QBevyHKHT6CxNv7Bhd9il2iFcG5EyL6pndezd+hog8RwcJC4CFZKTHkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
 by DM3PR12MB9414.namprd12.prod.outlook.com (2603:10b6:0:47::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Wed, 28 Aug
 2024 20:23:16 +0000
Received: from CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f]) by CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f%5]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 20:23:16 +0000
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
Subject: [RFC PATCH 0/4] Make MIGRATE_ISOLATE a standalone bit
Date: Wed, 28 Aug 2024 16:22:36 -0400
Message-ID: <20240828202240.2809740-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0978.namprd03.prod.outlook.com
 (2603:10b6:408:109::23) To CYXPR12MB9320.namprd12.prod.outlook.com
 (2603:10b6:930:e6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9320:EE_|DM3PR12MB9414:EE_
X-MS-Office365-Filtering-Correlation-Id: fc6c9d65-8a53-4b71-b5b2-08dcc79f3ff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?00/X4uA/P8pp1ci+19Yalh0pByPO/RrbdpxJkngAOK7BbIkw8f/sgkQlX8HW?=
 =?us-ascii?Q?xr0Q2qsDXjbkZloEundcSgy7IzqmsFEx7+524QrMnwB4b20OeWy4gKlj9KXR?=
 =?us-ascii?Q?ie4cpQ5QvB/mFvd7SUv3apy2wNm0pe3pIFkHwtw7fRn1C2omXScy6ZBU5ciT?=
 =?us-ascii?Q?II2Ii2std+yqBUz57PLFIM4Rq3d6u4q7HeE7/t5rfRJaNH9NyxUxzPsyKl9v?=
 =?us-ascii?Q?+vQuCeqX0U3Tc6IzUt/zVQl/DE/G8RKVghTHvhwkKGvIca0ytyQCTfsQ5Ufs?=
 =?us-ascii?Q?QB+RpZf7hlimlD6XVe5dYX3iiIodWHH7iVVneQGWFzSpRt6OA7YjZf547i+7?=
 =?us-ascii?Q?JJqvngJO/eXc6J+r4sAr0fNMGnzYO30HoYMx0R7md5UNVLdwDpgj7uO5UtO6?=
 =?us-ascii?Q?jVSMbtVzuhDjIjuoFhJJSxSOf4s1mnhuko38GauCo580P9sPatvar4RuHBBf?=
 =?us-ascii?Q?q8nPj9BHr7DLL2gcGkp0P9DltRHq6cbYPGFkmDVRhw0kQ2TLz5nuFdWaDldF?=
 =?us-ascii?Q?223AtvhQjtKmqoY60HTHAAfARDYUXQZm6cnjpbW96Gat9L8jPrGzVn9JvbC9?=
 =?us-ascii?Q?1GxHsGqD3C4KTLgWdrojrKJ5TUEHy4P1Xqex9qpYZsic4rPzG54V/UK8MlJO?=
 =?us-ascii?Q?mWtarM35zLciUIMAfuvWJ1PK8lUwhoZGblunhjo4d0gTCq0mjFg8F7oNMVwY?=
 =?us-ascii?Q?W6iDGr93pSVo3doLPlRPPDekYZ7mEbqBEzamP7f5odDT1Q5j9ne4OUuvtul/?=
 =?us-ascii?Q?utvxY6uuZxn7g071gz26bBJ8x2E5kRTWkHC3RCKdxVGc6/oEADcs/YfXw/EZ?=
 =?us-ascii?Q?88tFt/f/MAx/pOCyLzEy7xpR9L9jUUKI4HtfXPwNkQoqMtJcQ2CzqPFoWBgJ?=
 =?us-ascii?Q?e5JZcKWySpOVcERew7TfSbUWIYUkCA2vxnQLPpJ/T7guOTZdg+HKH5BgAF4A?=
 =?us-ascii?Q?sNsUAT8y246mijp1onQ1nS1npiHdnDPp22oAu4rQi8FP04hFZ8MzDbI8zPv4?=
 =?us-ascii?Q?jYFEzM3+BCU3qeiSzt8WkZ58HHMoSDfbPLXn5yaul5VdQW0CLZhUEmdl64a3?=
 =?us-ascii?Q?HzvvakxHXcDe9wFVQpwh0Asr9algG4eFF9d5GMYys4qx2Z6ymAj9GPtB080r?=
 =?us-ascii?Q?BfoJAdA3N9EO3Jbm7bVqksV0hwndjKeNY0WopTfiCRFhSQT4f9TjZV+HoAPa?=
 =?us-ascii?Q?SlO/vWoybYKxvF4U+Llf9rtGnC9oQ1uYg4zhAGk80sEp1TpByf5pDFmxgPyh?=
 =?us-ascii?Q?A9MmZOkOJtVbVZB8tpQV88T2jkOYtU8sPilPixlmS5ypKpWmPpbuJD++8AN0?=
 =?us-ascii?Q?Y+VO5rHU++bFjVwgzJiAjTXPT6D0o4mIqUOOvNu1BynunQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7L0lTn23nXc7oU1rRGW+n+j8OCwBvbJTjjEiOPReZFWv+Dl7ulJhReX7UpCV?=
 =?us-ascii?Q?GIRrQRJwvYnaowx32IIqah20qWAeNoT12tFnX9Bm/Oyil9epN6e1/yBd2bmX?=
 =?us-ascii?Q?+e+ymoYTVBkA28JTMVGoVHAXVJlaWfwAES9vo24okm1eXPb/K4SpVloS87Rs?=
 =?us-ascii?Q?ZaV96LFIh/9JOdZtYICRzojkvcmhAOgiBRn2kowBKiXZZBORFgGFb/aK4K7K?=
 =?us-ascii?Q?K5OEamKRoMzp4u9TNJ6E73JYk5q98HAZSC+lF/oaP8eY7Q18kQT6fInlMLnO?=
 =?us-ascii?Q?5i+ylkvzc58XFZDY2US2n+2+zeThoqIQLxEXYZs0rOBsto+97nLsay1krZGh?=
 =?us-ascii?Q?iM5/fa97E8EjRHH1OR8bJjTSJRBc194RjipaSYguW1nVkwzmytrJkvcohyg9?=
 =?us-ascii?Q?trKKMTH/GD45+l9JVGziPiwjW7+Os0k52pnE9NQLHNfdtF4bG0nYHHv69zIj?=
 =?us-ascii?Q?D4uG0AeZTmmRZLevRORVT9vbhwrNvdkJ5kpMgufbws5rLr1LUi3zlwTO3Z2s?=
 =?us-ascii?Q?wvF+TdYZDqVUDEVBxBeI/l2RNOV9lVgiMKuDZUbcKF6A59lcRmpzdLE1DweM?=
 =?us-ascii?Q?heTG5OtzJZXEWJMi7nY0Mv/3SsAoHAHx6WKCv1r8BldVToVdP1JToSobfBMz?=
 =?us-ascii?Q?YI6yVlQbvtRZlJFcEmLG20mbdzxglOkwvDctcyBBIp5f7/aLCdW5TJgBargQ?=
 =?us-ascii?Q?uc+UBUhjm90YJw87eZhq+QbaGAo+WOzkrgrgi9o+KFdKnrxDXQ58jr03pX+Y?=
 =?us-ascii?Q?WqmpHe0Vf9vjtZSylJXlgWARtST3vhq6lYLsB4ha1eHgzRr3wMBiErvTsB5S?=
 =?us-ascii?Q?i3GzgE+fF86IaH0DyWA92cYKzIyzx6+57chU8zkdunXYFORBeWVqHHzMcTgr?=
 =?us-ascii?Q?zhUQgZmSLLP5pt0wYoKYuWOXL1/kxO5q5zqY3H7qkshKgxE0IPJagedd2ccD?=
 =?us-ascii?Q?hZk9jj7olQ5LtbRk4RifmGe4L18YPpC+e78A/Yz8AqFB29QIg4qvI1M5D7eh?=
 =?us-ascii?Q?gdj7WFs+GYIg9TCqy9ZcjgypOlXJtFFuIqVqG2lb2JM+9Rj9oAolNlIsKnwv?=
 =?us-ascii?Q?wScjaZnYc8LA9Z7/StNfnFEl3ikWdDqQeK8ufl8pD+aStIS1tfy0yri95Y5k?=
 =?us-ascii?Q?Qyhs0V6EI/0MUl0xPWqHqAIZNIpXp6f7P8WDp4rvswlEotdUDeT0CK13WtJk?=
 =?us-ascii?Q?zqPppPdcPAhzNCA7gdUdMRag5bW+1QOLss0iSsT6XpVf99TmJBOqzwNFPfF+?=
 =?us-ascii?Q?jP8vC/EZ9m+PQgjoocjm+cexohtPj+igkp3nohO8cdbNYIDqvWYnXjzw1b6o?=
 =?us-ascii?Q?NWHqiMOHRI8VQG3S+SXuvdskQHxNmzSi4lfo3FCrshk9HqDnpgevs/z3o96l?=
 =?us-ascii?Q?F7hmvZz8e2zuDYdKpYg7WYqWha4H5QQL3z60/wuHRzJTYfXpZfH3rVq53mCY?=
 =?us-ascii?Q?rMhfX5yX5W0e3uDpvuWX1AL3EnenXh6xhIatM03Q7b5hYjoRfdzymOodvGLY?=
 =?us-ascii?Q?u2hQyxs/ebUIjY58jUi6a7cklcYRxlorxJtkQKhJ+oavw/zZfg0mI3zXb/YN?=
 =?us-ascii?Q?eTcCvOCJdJTF/0vZO2ov/DicGC2gJzete3dIL5wY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc6c9d65-8a53-4b71-b5b2-08dcc79f3ff8
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 20:23:16.8150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ptlVuBMocd+DcWDdIALBOtX53Op0p/QAcOwcyFT8RJWY0ArEFjIrWdF9imZsH2RQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9414

Hi all,

This patchset moves MIGRATE_ISOLATE to a standalone bit to avoid
being overwritten during pageblock isolation process. Currently,
MIGRATE_ISOLATE is part of enum migratetype (in include/linux/mmzone.h),
thus, setting a pageblock to MIGRATE_ISOLATE overwrites its original
migratetype. This causes pageblock migratetype loss during
alloc_contig_range() and memory offline, especially when the process
fails due to a failed pageblock isolation and the code tries to undo the
finished pageblock isolations.

I am also trying to collect feedback on how to handle MIGRATE_ISOLATE in
existing code. As MIGRATE_ISOLATE becomes a standalone bit like
PB_migrate_skip (pageblock skipped by compaction), in theory, existing code
could be changed to use {get,clear,set}_pageblock_isolate() like
{get,clear,set}_pageblock_skip() and MIGRATE_ISOLATE could be removed
from enum migratetype. But free list has a separate MIGRATE_ISOLATE list
and the memory info code used by OOM also shows free memory with
different migratetypes. I wonder if we want more extensive changes to
existing code to remove MIGRATE_ISOLATE. If not, what can I do to improve
the MIGRATE_ISOLATE specialized code in Patch 1? For example:


void set_pageblock_migratetype(struct page *page, int migratetype)
{
	if (unlikely(page_group_by_mobility_disabled &&
		     migratetype < MIGRATE_PCPTYPES))
		migratetype = MIGRATE_UNMOVABLE;

#ifdef CONFIG_MEMORY_ISOLATION
	if (migratetype == MIGRATE_ISOLATE)
		set_pageblock_isolate(page);
	else
#endif
	{
		if (get_pageblock_isolate(page))
			clear_pageblock_isolate(page);
		set_pfnblock_flags_mask(page, (unsigned long)migratetype,
				page_to_pfn(page), MIGRATETYPE_MASK);
	}
}


Design
===

Pageblock flags are read in words to achieve good performance and existing
pageblock flags take 4 bits per pageblock. To avoid a substantial change
to the pageblock flag code, pageblock flag bits are expanded to use 8
and MIGRATE_ISOLATE is moved to use the last bit (bit 7).

It might look like the pageblock flags have doubled the overhead, but in
reality, the overhead is only 1 byte per 2MB/4MB (based on pageblock config),
or 0.0000476 %.

In terms of performance for changing pageblock types, I did a very
simple test by offlining and onlining all memory of a 16GB VM 10 times
and did not see a noticeable runtime difference with the patchset.


TODOs
===

1. improve pageblock migratetype handling code to be less hacky (see the
   example above).
2. more performance tests on pageblock migratetype change.


Any comment and/or suggestion is welcome. Thanks.


Zi Yan (4):
  mm/page_isolation: make page isolation a standalone bit.
  mm/page_isolation: remove migratetype from
    move_freepages_block_isolate()
  mm/page_isolation: remove migratetype from undo_isolate_page_range()
  mm/page_isolation: remove migratetype parameter from more functions.

 include/linux/mmzone.h          | 24 +++++++++++---
 include/linux/page-isolation.h  | 11 +++----
 include/linux/pageblock-flags.h | 29 ++++++++++++++++-
 mm/memory_hotplug.c             |  5 ++-
 mm/page_alloc.c                 | 55 +++++++++++++++++++++++++++------
 mm/page_isolation.c             | 55 ++++++++++++++-------------------
 6 files changed, 123 insertions(+), 56 deletions(-)

-- 
2.45.2


