Return-Path: <linux-kernel+bounces-417343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C49C9D52D4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B54C9B253D8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6931D6DDA;
	Thu, 21 Nov 2024 18:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pflVSGV1"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B760E1C304F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732215161; cv=fail; b=HSYm5DSDduIuVIZridZ1OvBH/c7+lOumgrAT22T4ggYt6YKcJd1IEeRo6GFEOkgzZRuTidhVfc50R/JG3CKIpT3yXj71s44zONsAuNnDtWkVb/IjFxDGRflgs9CSciXIZ90cw4Y0B6yX/pCDqMA3rGt7+QKX2760JWF5Vhag7iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732215161; c=relaxed/simple;
	bh=52LeFe1st1CjZTP86MLhQxrEOecrFkd5PTHPk+LkTMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GEAhHX627Fk/xrT/d1gFJ2qCDFRa+IYfuuvEofGXTTj/LJY6yxPBD0EhbnOjD3nTX7e72R8HvMDy2ypgf6/r3RAX5ZO74t6sbvz9yllmDPCcAoKZyP4rWgMBvZfJQ9WfnVq+PsHBFkMqNIqL/+L4VLJGTcGMixnAYa4cwNJFuys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pflVSGV1; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6Oiu/F5cUK7JWG1+aTiMYohtzUqc+yeC9X/vZ82CMyBPQYekC6ivD6u2c/PAxxNem+eB8X1eJn7Bz7uoSqYTz6Qbng+ISSkcotBynt4FYk6fpxVqE1flvW+skpEV4P24TRUTk5y4mcV36xIXwcE1VYmTqeDDfEi5lezxaoZhHTsx/1GdnMnR4D51lgMVpA2ghFI98XBNRH+40xyenhJSwzDqth6aJ5PYFPR5taBs2uXv/4M8o2y1oyTmb1HlPA5NYi/GvJXdWDAp9N81RC6hzR0dHO3Vi6PC4mXlYuV5hvaPlKcfkuug+Z1bMXrx/NARpRpCXJrxz92v339mrZAzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLbs+IMXe9PXriC98Ps/VfSjdrTeu2gdIoj8pxpjo7M=;
 b=SElSr3IqMFQbSgNmtVTFOEz0ODGy0twFE2AuWh39/I75mBTz+3moEsy6uvZS3fFI49dR41sHT7QUQlTYEa2ksRRWOvNM558KBLDRHmwJEYuUjT8d5dfjDmaXRCJr4l9iPZhxW6ttAw92eauS/+UzcBW8oAG8hFXMX0YDPENiyQbQWzNvwZrS74v3B+NAr5Fgs/qgnbI1lze6mgIrFLlmkZvcUOQrt81Xwe9TlH/wF9SLGjTMZFKpDmdgrGRz/v1tUjwbFSbxanHqihT7t9Na2hJ+ipJkB2kbNRSZUeEG6WwcwLmjiEqlOSpn+6JaVQzFGVKXRSQv9w+dYc4JA4RGMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLbs+IMXe9PXriC98Ps/VfSjdrTeu2gdIoj8pxpjo7M=;
 b=pflVSGV1ix9YBhxJmvE+Tb1I2wbP1XJAKL/crjfiE3ZFkzMK7046QvWwIgxqMAkME6SJGgW6xlZXMB+vorwX9sMyyPPUNB2kQGSIe1Z0uth/F5dOjVDb0dQ+CIKIXkci11+ycizbUntSzxr5aD8zL+qzEHEjCb2oCdXuYH6r45qoqLRhYsZJuMOETLM8bRI1dNCx09dpTxRWWmJZcMDpLqo4X1ZaZdioLgtqTWC0ybs8e7ZSHGp/8v1CpUX7rRRs//8FQVi9NSnVb37gdhqOnZs1KUX/+jsjp/bb9M6PJ27aC2RUzn6CKuEgrhHKwk0BQwoKP6bB2b4qmp6QoOxnjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9)
 by MW6PR12MB8834.namprd12.prod.outlook.com (2603:10b6:303:23c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17; Thu, 21 Nov
 2024 18:52:33 +0000
Received: from BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9]) by BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9%5]) with mapi id 15.20.8158.024; Thu, 21 Nov 2024
 18:52:33 +0000
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
Subject: [PATCH v3 1/9] mm/huge_memory: add two new (not yet used) functions for folio_split()
Date: Thu, 21 Nov 2024 13:52:12 -0500
Message-ID: <20241121185220.2271520-2-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241121185220.2271520-1-ziy@nvidia.com>
References: <20241121185220.2271520-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0232.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::27) To BL4PR12MB9478.namprd12.prod.outlook.com
 (2603:10b6:208:58e::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9478:EE_|MW6PR12MB8834:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b892ab1-fb77-494a-70f5-08dd0a5da85c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rYZ7i/cqgg4ynwSmUbyx4bJMIuT4lp84HfHTRlogUhNfRMKy3F0WoWN5O0m0?=
 =?us-ascii?Q?WanfgxEiqh5MksK12a9fKLHKvWBKtnz4cMEDmlz2/DqJmmwKpLe114iITtKf?=
 =?us-ascii?Q?Je46NByLla3fvbuufpv3YWIMVgFzjVnyZMg8t1dzc0JlVVacjU6PM7JLgg/u?=
 =?us-ascii?Q?gmL7PbafwSUDgdCBZx9m1cxszS4H6YipitTlOr70UsfkCT4cVuyle2hH/TxG?=
 =?us-ascii?Q?1BbwTZu/S7CUMCUKBUtNFGxC2YiBCkbhHpCSvvO5HiMncIXmONFvLH6CnlqJ?=
 =?us-ascii?Q?PNRd1ute3myXFpC53ckfbEN7UJidDui+gR/6sNd50ZqIfVJmAlmvAu4hlytM?=
 =?us-ascii?Q?Myzu22+wvXIhyOITiup4e2fGSuOA9bxlkwsGlAUCU4rYIlCU7kvS8rpU/FHR?=
 =?us-ascii?Q?rZkgu2XoR2rWw+PETacdwfWyWbGSBbCsM0VkUCWEGAuPOkE07y1s6PXeLAna?=
 =?us-ascii?Q?zaIbyEIOIEmZd1xJKrEzXx2zQuaoxVduUtzNUfpx37QydwYPeQ407o9HLCf5?=
 =?us-ascii?Q?UjY5VFpOY07rLPxVWIeph0W9nIT7V3aCC/MV7fzpYzhStabd+PvbqCc3WSjR?=
 =?us-ascii?Q?d+VSu74LKq7PP14lEC/NWzmHBOvwED3kYcBJR7LYMnM2ZsgAhuuBrbSNzis7?=
 =?us-ascii?Q?2zHCmuJvBXTxA7XaH0NWDmDVQ+tWe8Sr3XSuOg3H16W05LjXbQ/tcCMNezgF?=
 =?us-ascii?Q?kikU0IiMO+wINGEo0UQN6UchPAyN0SK/0HOG9Fs9WTYjO5BuXDbU3ZPWXP/L?=
 =?us-ascii?Q?c7wJ1GL/UnITOQ8ZW6DVhPFEn08kmJRnMEE8NUA1hi2t2FkHCYIp+hgcYaWA?=
 =?us-ascii?Q?1UwtIevIZ36smVu4FwkvSEbe26qtvuQUIaSOwK4apbs4MTvo9zdqFi9b5/0i?=
 =?us-ascii?Q?FWhlmyxkAdCJ7oJJHAwwOadTsEBxV5FHC4DvydGKxBC7BecO2eBUpAvHfoma?=
 =?us-ascii?Q?5DbQv68CGGn7A9Ko20cMNWgrKnugJYevM59OS+UYBvzAAdfAjco/jsrImJwy?=
 =?us-ascii?Q?nagbOflSofVByujtp8QVwPzJv/LOv8YPcnQNGcFrVtsL1dci77kAGdmBZ053?=
 =?us-ascii?Q?sotaejoTUTC7xTqrdI9wbPvynVMDXeonlI5gTOo9JWXCySOZq1GlR+sFu/90?=
 =?us-ascii?Q?KIO8qDW/W1D3pNn88CZnwbscTBplNURc0MMNBlK1L26pxbGL20519S9w/rRs?=
 =?us-ascii?Q?+7q9HPkyMXpSeGrnd3PlHBZ4PNuo+0PyZsupC+jbwrokLqhbM5EWa8DJ07k7?=
 =?us-ascii?Q?uZFXsz8cwcyc1XriRAL2MWKOEANTqpoNmsTkPLS+3dHUkQF7qR2kD1qAFxPY?=
 =?us-ascii?Q?wBoJPRx6GXE5fEDIPL/csTos?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9478.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lVNdXfh6XZvufwtUUGmoaX9YaTAIhz4ZZoMld6q3g9TKPym24QFc+3tlCF7M?=
 =?us-ascii?Q?uHq76TJpvRIkF9Xqpdr6WuD5TJ5BPw4695lR7Wkui1lmBdoJkXLkmP0qvuXd?=
 =?us-ascii?Q?0ENP/oAjPT5gsJ8NoT9B9j1vGDgFtahLkYTY5MjVO+DK6uSYVqgcW1SL54pp?=
 =?us-ascii?Q?LOetngAqs0SN+qsurG+fCPWGuwH6YEMazZOOIfF+VJfNyonRinp7orIdXJjl?=
 =?us-ascii?Q?OQrZ1Mkv2XiYPwSrbkJF1tEEDQn/V++JKnGx8Sykk51mL3wEdY0a5j0RddxQ?=
 =?us-ascii?Q?dL+qN8Gr6+B08BlJCg0+D5iimylvCfaclZw8MHmLu81VPr7JtG6hPrXw+0ig?=
 =?us-ascii?Q?hurYgfegUsFBztkb1hMtdXUm23keSMd7vCZZwA2JS7cgw+7Y7qjKJUdqDKyk?=
 =?us-ascii?Q?Bls4L0Rsh2hcyQHXbryb7rm0SahGhGHKlrYn0pz3CBjB4o+swqFTehsqUXbK?=
 =?us-ascii?Q?8k4xMmRY9v1gQwnduXpLNoX9h55ORhsEedE4v6x2D3hONxvu0f/PcI16MEsq?=
 =?us-ascii?Q?1j7w7hbV2clbLTUPhTodv7rsjVR/QuvH//YZVu3DSZraBAxGrxwbDQngRNTh?=
 =?us-ascii?Q?XLut3mPoltGNnkfCTIB2nA6IQnTctVQ/aCy2yJXqXhIzrVyFsk7zDmHzk6Ow?=
 =?us-ascii?Q?u1M+aFYgOs84spm0Q+ZVKMBhuFyydRT7gnBCS5ax0P+1eFCYuHkRktR3AKBc?=
 =?us-ascii?Q?tP5t3YH9FuY8NzQOU2MPVF2ks+F3EaaOGgTqGH8M5xx29DAa7ucoNPmEop7F?=
 =?us-ascii?Q?ez9ApRGW2aDA7rPPISmj/vbA/6c81VLZAmqyrDs7AWm1PX1A0xtREhks3v3W?=
 =?us-ascii?Q?mSehGLmWrLw23qM57r01hFsmLIx8QTGnVaxwUgR0QsTk7OI0uFj2KJCWPWT9?=
 =?us-ascii?Q?/MgPL02sxtUvMJ5vaaUi9+cy8Kd8F0ytyQfE0Q8dQLQRmHObDA5cxFqkTWA1?=
 =?us-ascii?Q?VU8VnCLJvAdHg3ytaCK8Td0wZSLupw2HR8wM6/Q66//6B4xP5fUhntH4Frpk?=
 =?us-ascii?Q?k6CRT0TLaI3z+5+nTGijp50X6OhpoHbqeZAZNupnyvTumSeZTPa52aMqPTKc?=
 =?us-ascii?Q?Kqgt75BgAwVvhslh7A7MZt7KHquPFNilKPR53CDh8Zdz25zgT2OPBaQJKTUL?=
 =?us-ascii?Q?dLF/oNycw3kYmudYrIitj5dL9Yw4z9Dt9xE2jrlI5rF1dwRHj/Ju88hZhNzQ?=
 =?us-ascii?Q?o93A8wUXo5umsOpr2X14XjWb7goh+hj6KDmJnVmpwPaxYA9djjncNZGh6nMN?=
 =?us-ascii?Q?SO4MjGbhVy9+vY4zr4nYTcrZxVxdGSMzrsNctLf6g6d5h6VLwFoaSAz44xvB?=
 =?us-ascii?Q?LWq4kn6M3PRbKoPYV2xWSYwn/KrJwRPBFV0M5XCCvsUIo7snkSTyiErfT9Ba?=
 =?us-ascii?Q?kOmVRlnRBrysEEZHQjKmxlHGg/LI12Cm8AdYfbE36XvYJ/TaxOVTa5AZXGxa?=
 =?us-ascii?Q?HBx+zrROShjzzrGz3WDsTaioFhzgYqi6HxkxftknG6XUJeQ/Gf3QiGLEj4Uf?=
 =?us-ascii?Q?Il91PBgrG9TIvDjgSoYe9DYoy/xvlNpvYD0u8VxahItLl8S4L9bNvi0uLThg?=
 =?us-ascii?Q?iHFIybmOBVsK6KGm+sI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b892ab1-fb77-494a-70f5-08dd0a5da85c
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 18:52:33.0529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tHvUHztjdJcmMBUKz+ji9uXBQKJmv1NkE0sNflb1CYpFNrE/4ByLRzJQfbAsfegm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8834

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
index ee335d96fc39..5ebacb08996c 100644
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


