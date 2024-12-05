Return-Path: <linux-kernel+bounces-432422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CB49E4B05
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EE0C1881257
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68799F4E2;
	Thu,  5 Dec 2024 00:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ak7Kk8SW"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FAB64A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 00:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733357932; cv=fail; b=eRaEwLEPuw2IJQCgyvyfLUfqysFD0Wi4aTaRgjGsw3EoJgYNwF+NNLhOZK0w2uoNQdq4qu04y39Cl1SNNiyE5b1d4ORVEbmAB1mj1BjvKm8D2PYXGF5MjTGNXp5wQPQKeSbl8e7Wdy7rE/X4W7kdgcvfPjjA3z7cFD0huG+YRIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733357932; c=relaxed/simple;
	bh=iwTwrxEAUli/+PQHwMnfd5H5ga6jfuDPLkw+1gBw7d0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VUbyxA7KDzeCeKDaCIuxiAm6YklSgBe8tayJEud0cxoOspHcl8bN/wW5JI1GPg5t8QX8Im2IXbb5EmazJRq3dG8c7XlLUg+8fMP0/Qimx7Ra/ikDP2XXrYlahhtEs/g4O93WipJ6Gchw4/gzrGCWAoKSRz/6THkyKOHjplj3bKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ak7Kk8SW; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oN+5qogiez2NgcifIL1b/9Uxg6pTc8GGnmWDogYvYA8xmY41gvuTbBlbSoWAvewSZ+iP5z0aQqAcLNsHvJnIo2lmkxw2rBTwIjSuyZdDctBojkG6tmsuiIM6DRAvWE3doDuoegJ8ZCLUBdpbPVVNrAMZ89NXrtgX6e2O0K5saaDK+3Pwidev7N0Y8vayGd+SU6MzgTZb838yoUAV1HYEkP5euMWZaniU/cmDZiVIc9gR7x5xqOX0LnJwgrJjn3IBLVXXT6gGBGrk6U5+6QRAfh7J0NC8TuxhReBJ5nbmOQ0A7GtJ6NrZIVhesvTt8ReeTUwc3CSlpMqr3SGk74GQ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+3spWHdN2EMOLZhAL3VZ/AE7EL0e8oC5PEvi8fneRU=;
 b=LcWylKiZrXb8x+tfXeGnqZM8GNc0nRD0x7vZ7EYba748KtAW/cmdpY5Ny7oCIiL3lB8ox9cLSlFErgo+yZVU1uaFNE8eNHAUpMoFOJCFfJk1NRbb9cRMH6x+XZn9G6AbhIyuCV126AfdGAJ5G2LnnQlgqL0086KrcNx8b5EiwBDsjkqLnyzTFMsoSjiid8OvI4gdfY7t7KZ9PnGdEaWRJW0XAvlB/PWKWSFlZtsLQ/VtvOngF4kjqRUlSD1DdLOKCIi0xwxkJLGeJBimM7eeXSzO50joZUZvEfOCA2fUWbsViA0KWGPIpaBahJGY3/SuI+9+Dgmq2Pz/rWDMFScJlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+3spWHdN2EMOLZhAL3VZ/AE7EL0e8oC5PEvi8fneRU=;
 b=Ak7Kk8SWZLEsM0pq+jI56diIOKrSoYgm80zOCxHpDx2p4InJL15fUfcVfXf0nRMNPw4EeJS4PMKC4ECAiWmiBOQa4GdYbKeFIe7C3MG6kGP3UXV1wsVcdCXUv+SW40MvvTG81BV/2/giOlZ0Cxt9rT+Khoxz3w0JGd05vJyu3ww7NqjlcqFHxV0fYtYwBXPUVKpc4PyWyYnmGIHYheGGOfsndZ7TcZNqVeCXbd5Nml0ToqK+i3ddCYyU3q98F4E+PhRyucr/gWiM4EwixmeNWqUgJALhEsauVpnADHdHvlyt4crwzjdfn4q/BtjJ9tGuYGJ7mN5fdz7Je3ZMVsJ1Jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9)
 by IA1PR12MB7589.namprd12.prod.outlook.com (2603:10b6:208:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 00:18:44 +0000
Received: from BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9]) by BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9%6]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 00:18:44 +0000
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
Subject: [PATCH RESEND v3 1/9] mm/huge_memory: add two new (not yet used) functions for folio_split()
Date: Wed,  4 Dec 2024 19:18:31 -0500
Message-ID: <20241205001839.2582020-2-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241205001839.2582020-1-ziy@nvidia.com>
References: <20241205001839.2582020-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0063.namprd04.prod.outlook.com
 (2603:10b6:408:ea::8) To BL4PR12MB9478.namprd12.prod.outlook.com
 (2603:10b6:208:58e::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9478:EE_|IA1PR12MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: 36185e56-4f05-46a8-1c71-08dd14c26166
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s6pyskzxu24QNu2sQsXfCShkcCx3pS2RuJVk3nURn2Ua+DCxBOG7gLcbkmJ3?=
 =?us-ascii?Q?ht6bDhe6fBo7M8vipL3IZaqbAH2q+T37nil6W2vKTs8zHHQvX9H/CrRufVr6?=
 =?us-ascii?Q?J7aNd97wX8jKW49xy3A9CVleOS7EOfJNfZxUlEzGWGIrEnIBgvjQYUu8/fHa?=
 =?us-ascii?Q?rRdK9MZRb9MThCEgw5pNoONcXVywvXQQUklFL6aLynUa/914gZku35cf32Oy?=
 =?us-ascii?Q?pWArV5y68SHWARSDuEE2/r0cMP9Wxfpx8RRCo2M3bglQ1niKQOMrCqF0sfGn?=
 =?us-ascii?Q?P+GV1e2R4G9/mGStLKPZiZGP0E6v68ozMMR00YqVi8mHGEMPMCZBryfi9zbZ?=
 =?us-ascii?Q?i4KpwTOTrjbuy2DjCdugpMvjwO3emfqlQhHceh3+Hbork5DqgcITsjHoxHG+?=
 =?us-ascii?Q?63JDEycEGRkDAK3AWgRFbOb00q6ElFVu0EQrmb1qC3UzQcqBIU58A1QKfXx+?=
 =?us-ascii?Q?gVkDdB0ayF1bjOLS1RMp1tzLLA7276eSv62ZvRW+OLu6Gg42FHGzgQMVBPsV?=
 =?us-ascii?Q?w1z3zQk2uaqtFR3cW/GACyjB3EPRYVX/ouubEuzDGEGYrnnPl2nH1uq3BNuY?=
 =?us-ascii?Q?xJmBEP73AHXtMuOmu1IaBAnq9YXBaogC/x0tiUOacxo+CJs22bZTNCGphBJW?=
 =?us-ascii?Q?q84g0LsF7QUK91kQkdqoBkh3J/QuxSAo7bhvYj+DYSEQ51SVIfl8u4O4q428?=
 =?us-ascii?Q?qaZ6Co0YJGyl1GeOM9hmyTaR4aR+atJxZWFkbOFK1WEZ0eMQwltpZyrv7/Of?=
 =?us-ascii?Q?rrNj/DR5oHAwAMmKG37Eau2ooU7FrqWp1PF/7xS4xl/jXSaM35oaCxOhaLPM?=
 =?us-ascii?Q?WN6cFmWhNTUvEthvyqw8ZXgK0I8BnUmp/KM/MkS3kzt9VloBW3ukTBLK/Z0P?=
 =?us-ascii?Q?Fhzadc6zMrKvTYzyALkiPDnsWA6e3Aeiosm/73NZ6aQpMHMwCjAE9RSzsTwq?=
 =?us-ascii?Q?NQ88NT4ET8D3j6gQwNIb6xWhEL/mwEwQN+hKF0UlS2I5BxlCOCxlFqI4CV0H?=
 =?us-ascii?Q?T79HNBg7QSpbTGtB/mYApvWuLH7voO8JQj+PF4NUjPgC+uzdgI1YoylDIef8?=
 =?us-ascii?Q?zQZdZlzA2jO/1U/netmLt5Hj48QwjB8z5tGxhgR7cI5yVe8L5ZJrA56d9d0t?=
 =?us-ascii?Q?ysYWZ49yI4yQp0UnhC8R6yDnz+fngVfR/leLWt+9rPAvr/aY6gyrsiXlhNsO?=
 =?us-ascii?Q?q+KV6adWm//IM3juH6xG+Dvr1nzPkYKcD3wqAttXNma0/m/2rQvPbfjQ4wTp?=
 =?us-ascii?Q?tzQhL9DQZY3qByab1zbaIMDKMPzC2bvPU0ogVC1iwyfHzyfp1ZokBMuah35X?=
 =?us-ascii?Q?TeS7Q874fmojPXLrJ+0e1urwzZNGSHpWlWxx6ZrlB+Sr5g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9478.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nir4wRO24tGE7X/Ms5NgF1e9GpVg8wmwtl96KRQbztBELwfPphRJkmiAZjU7?=
 =?us-ascii?Q?deN//wDuthZDVudBbtGJ4aj3lIygL4e7HF3ZLbhu2ZwB9r2sfo6tYDjY2sAF?=
 =?us-ascii?Q?UKxofefjj5Hy3MbpDqnSo4i1boK/EAAWPyQwLy8ZxSkOatKw7eWZvhIeWcAW?=
 =?us-ascii?Q?kTBhKCaXmzamnVJ5SOO7+2fmPmMznRGb17lSjyKHtHDGe9sgdpN8a49Pwqpv?=
 =?us-ascii?Q?4R3OUSHHZDnyX9SKQa5LLKFXVeG/WAAVRET13TinRPzgSoZLuxHfRPGnr/wc?=
 =?us-ascii?Q?GyveVGwzFpWp2D5gTiwA7Sosqgk/11f/AVIRdxAqriWd1kV63qxzs4QQdyh/?=
 =?us-ascii?Q?5owxstvpV/KXAKuzRKmSeXk7hrKxse+fTqm5R7zldOXhjWu7pSr/pfkemQqv?=
 =?us-ascii?Q?3PwHxuq1HtIL9lU0dGWnClvh7hn/V14URkwGgsAeUxsDntjpgMmoR4dHVj/d?=
 =?us-ascii?Q?TAcfAgH9EB1gBdChDbOXLkl3Wn1D2DOmnsrP8OtVK19etEjrCyiWlOGGfhNk?=
 =?us-ascii?Q?tRDqbX55JCvytRLMKrTz/kxUwAqY8/F1pufJ5g8DLfvBQGo/2O+wkaGADpbP?=
 =?us-ascii?Q?mqtgNeYE56vdOorViLDn7RezCJKKn+MSDzIRX/c08ooeIBoSyJAbnPSQOllg?=
 =?us-ascii?Q?maHiGKGzNY9GRZMeBCVG5EQP9qPtzcvjDRJ5GTzchLJdNBIDjuVbSCo8D5SV?=
 =?us-ascii?Q?Vr762qZV0c4EkCtLdI3cZ3E/avBEw2wTbedwZqE5OHjUIAgLBDh//YClR8Em?=
 =?us-ascii?Q?gq6S+ofnBKfUIuPdUrJ4Hn8bq31/sMtCm1s5GhZJnMpmPHkuYoHbC4GHyCpN?=
 =?us-ascii?Q?jwem9htEf+rzQEKc1Yisejy7KAEi8jlEGfo9ztscMWsGgrYh6Nyfd+MHjrqo?=
 =?us-ascii?Q?5MCAYrG7BktlJa+Yxm/hpJlgJcV94htKx15K6pukV23DYQpCKdqRgY4qdvr8?=
 =?us-ascii?Q?QH35A1DphRstbjVTSk3c9SHFEeAc7MnuYGs+WSY9o+hkJTrvG9HfUzQ9fq4i?=
 =?us-ascii?Q?vEWCI7sLnEIZZOjl2PMVUDyxPFmdtZmrbdu1hzTVZ6S2twP0aECnhqUDtSmn?=
 =?us-ascii?Q?FGEf4TOyb/Q1ocB8k4GsRZxvZA88hhExxJxyXDyz/wntQ740p5qQ0PVHLZag?=
 =?us-ascii?Q?ZjlUJQQsIDjDBsvqRoURrkwSIhWcFCNNQhoKAjKR4VI0soQYyEPj+PmDzeee?=
 =?us-ascii?Q?P5vupwrhEAEfNdOJ2tBj1aixHXliHXXHABLJ6KZJRQn6K/eX7wyldsPO2/FV?=
 =?us-ascii?Q?1wqu8NvoAoPfRU5G6EcQG1Njbd1CNuUYk07os30astJUuan5I5/D5mPcaSfs?=
 =?us-ascii?Q?JupzHjtr5w6Ej7QwEyD6ZjY+CjUIgdIbCaGVBXZNwW1pAG9daW979I53AfDk?=
 =?us-ascii?Q?mGns2RsNTRWA6L8VJyawW2I/Y6xg85ao6LryK8rTZ4Jp1icsgbU0YdQKvXMi?=
 =?us-ascii?Q?RoWpMNDQyqdyxDzVI+Xd8liBDbMeWZA1WYBJokxuZXgZx+l/2lcIu7EZWtKj?=
 =?us-ascii?Q?ArEOCK3RWJ3WK7xqVLm7Dp/9igNDHQgDnePjjnTuvmJhcqd67HkyJDhORc/l?=
 =?us-ascii?Q?tchG3eEbHlCOyoFPY+3tYJ7cOh8heJOPC4an3Iy/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36185e56-4f05-46a8-1c71-08dd14c26166
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 00:18:44.7556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GloXxXsUr9TmYrGIEXCwtbGIIAT9yudJcykIsFMLm9lnEise6T/iQOEaWfTwuLrm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7589

This is a preparation patch, both added functions are not used yet.

The added __split_unmapped_folio() is able to split a folio with
its mapping removed in two manners: 1) uniform split (the existing way),
and 2) buddy allocator like split.

The added __split_folio_to_order() can split a folio into any lower order.
For uniform split, __split_unmapped_folio() calls it once to split
the given folio to the new order. For buddy allocator split,
__split_unmapped_folio() calls it (folio_order - new_order) times
and each time splits the folio containing the given page to one lower
order.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 361 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 360 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ab46ef718b44..0cde13286bb0 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3127,7 +3127,6 @@ static void remap_page(struct folio *folio, unsigned long nr, int flags)
 static void lru_add_page_tail(struct folio *folio, struct page *tail,
 		struct lruvec *lruvec, struct list_head *list)
 {
-	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
 	VM_BUG_ON_FOLIO(PageLRU(tail), folio);
 	lockdep_assert_held(&lruvec->lru_lock);
 
@@ -3371,6 +3370,366 @@ bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins)
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
+	/*
+	 * Skip the first new_nr_pages, since the new folio from them have all
+	 * the flags from the original folio.
+	 */
+	for (index = new_nr_pages; index < nr_pages; index += new_nr_pages) {
+		struct page *head = &folio->page;
+		struct page *new_head = head + index;
+
+		/*
+		 * Careful: new_folio is not a "real" folio before we cleared PageTail.
+		 * Don't pass it around before clear_compound_head().
+		 */
+		struct folio *new_folio = (struct folio *)new_head;
+
+		VM_BUG_ON_PAGE(atomic_read(&new_head->_mapcount) != -1, new_head);
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
+		new_head->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
+		new_head->flags |= (head->flags &
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
+		VM_BUG_ON_PAGE(new_nr_pages > 2 && new_head->mapping != TAIL_MAPPING,
+			       new_head);
+		new_head->mapping = head->mapping;
+		new_head->index = head->index + index;
+
+		/*
+		 * page->private should not be set in tail pages. Fix up and warn once
+		 * if private is unexpectedly set.
+		 */
+		if (unlikely(new_head->private)) {
+			VM_WARN_ON_ONCE_PAGE(true, new_head);
+			new_head->private = 0;
+		}
+
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
+		clear_compound_head(new_head);
+		if (new_order) {
+			prep_compound_page(new_head, new_order);
+			folio_set_large_rmappable(new_folio);
+
+			folio_set_order(folio, new_order);
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
+	if (!new_order)
+		ClearPageCompound(&folio->page);
+
+	return 0;
+}
+
+/*
+ * It splits an unmapped @folio to lower order smaller folios in two ways.
+ * @folio: the to-be-split folio
+ * @new_order: the smallest order of the after split folios (since buddy
+ *             allocator like split generates folios with orders from @folio's
+ *             order - 1 to new_order).
+ * @page: in buddy allocator like split, the folio containing @page will be
+ *        split until its order becomes @new_order.
+ * @list: the after split folios will be added to @list if it is not NULL,
+ *        otherwise to LRU lists.
+ * @end: the end of the file @folio maps to. -1 if @folio is anonymous memory.
+ * @xas: xa_state pointing to folio->mapping->i_pages and locked by caller
+ * @mapping: @folio->mapping
+ * @uniform_split: if the split is uniform or not (buddy allocator like split)
+ *
+ *
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
+ *
+ * For !uniform_split, when -ENOMEM is returned, the original folio might be
+ * split. The caller needs to check the input folio.
+ */
+static int __split_unmapped_folio(struct folio *folio, int new_order,
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
+	int split_order;
+	int start_order = uniform_split ? new_order : order - 1;
+	int nr_dropped = 0;
+	int ret = 0;
+	bool stop_split = false;
+
+	if (folio_test_anon(folio) && folio_test_swapcache(folio)) {
+		/* a swapcache folio can only be uniformly split to order-0 */
+		if (!uniform_split || new_order != 0)
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
+	 * folio is split to new_order directly.
+	 */
+	for (split_order = start_order;
+	     split_order >= new_order && !stop_split;
+	     split_order--) {
+		int old_order = folio_order(folio);
+		struct folio *release;
+		struct folio *end_folio = folio_next(folio);
+		int status;
+
+		/* order-1 anonymous folio is not supported */
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
+				if (xas_nomem(xas, GFP_NOWAIT))
+					xas_split(xas, folio, old_order);
+				else {
+					stop_split = true;
+					ret = -ENOMEM;
+					goto after_split;
+				}
+			}
+		}
+
+		/* complete memcg works before add pages to LRU */
+		split_page_memcg(&folio->page, old_order, split_order);
+		split_page_owner(&folio->page, old_order, split_order);
+		pgalloc_tag_split(folio, old_order, split_order);
+
+		status = __split_folio_to_order(folio, split_order);
+
+		if (status < 0) {
+			stop_split = true;
+			ret = -EINVAL;
+		}
+
+after_split:
+		/*
+		 * Iterate through after-split folios and perform related
+		 * operations. But in buddy allocator like split, the folio
+		 * containing the specified page is skipped until its order
+		 * is new_order, since the folio will be worked on in next
+		 * iteration.
+		 */
+		for (release = folio, next = folio_next(folio);
+		     release != end_folio;
+		     release = next, next = folio_next(next)) {
+			/*
+			 * for buddy allocator like split, the folio containing
+			 * page will be split next and should not be released,
+			 * until the folio's order is new_order or stop_split
+			 * is set to true by the above xas_split() failure.
+			 */
+			if (page_in_folio_offset(page, release) >= 0) {
+				folio = release;
+				if (split_order != new_order && !stop_split)
+					continue;
+			}
+			if (folio_test_anon(release)) {
+				mod_mthp_stat(folio_order(release),
+						MTHP_STAT_NR_ANON, 1);
+			}
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
+	 * At this point, folio should contain the specified page.
+	 * For uniform split, it is left for caller to unlock.
+	 * For buddy allocator like split, the first after-split folio is left
+	 * for caller to unlock.
+	 */
+	for (new_folio = origin_folio, next = folio_next(origin_folio);
+	     new_folio != next_folio;
+	     new_folio = next, next = folio_next(next)) {
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


