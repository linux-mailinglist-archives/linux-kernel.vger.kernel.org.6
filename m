Return-Path: <linux-kernel+bounces-385570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B211F9B38C3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36B791F22E0F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957421DF981;
	Mon, 28 Oct 2024 18:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BxId04BJ"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72929155A52
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 18:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730139007; cv=fail; b=Jl3iS17JymmO3E7mLNsp+LL+Y++LD1SpnPlch27Gl6TbgcBSogoh7MvA1IMvI804IERJsCQifSPfo9uHdsfyYp3J1C2EDmWW2ITaSLRIXug4OxsnA8ticTQjLhFRAV2UBOEJQU0xAIhGhKvOBf1kvU0eyrw/nc9CPFyLKw+qge0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730139007; c=relaxed/simple;
	bh=ELhnFejCOX9/Q/xjJYGwHq6ws1xeWI9BqUAUXH+1hVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HKq/W4BljpjA/224yeLG8c1UM0pdWZchB34u6QoSuRfoWqQ/KbFmxvkMObysxS+K8BFbq36lBXPk1fRctmg6qp7lyqfAncJv81af7iGG8Ng5KBAlkWqBULjqLjf1Z3M6ti+PsaGjdomr2Xv/Aa2CwBFx+eq0ebrvDk6FxqTyqdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BxId04BJ; arc=fail smtp.client-ip=40.107.102.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fp7FUmdMsEZkttOfOuuTAYpndT9T6J5kwHEJ7FR4Net3/1/Gqt28jsr3GexpcBMik/1HWaCkTfhgbZFWY9rtm1wi4HMVHkvJApWh3JPsJKrlKwc8K6XAxAB1M/FiwNwTNLDXSxL69zVWc7skcZkyqUpQm5pguxy4sUrY0wkTAS4cJGI5wVRubwLDd7J8CxNBZNhRX92LhiU2TSfwVUjSTK4HwwUub8YzkxCRI+ekvqKvZZ6Yh4LzubYcSX+GH/bxRHVpGPQCANL/iYm7eRlUcP3Fq8bprhgWz2StRukVccn+ROn48rCHLcqVR4gTAllfuCrWa7BVdRHwWvp8n/sm0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0R6/pYkkl5arlhdrpyVf+Fol2LxCndeTYdRd5JsWGm4=;
 b=Eh9nVFaiJov3g36UgWH8IMmOTUfQi1sR0hkGL8DjDQuYMDBNEFTZ7YbSoKCyGaRC7SzzmB2BnQNXovPgBlbhYZjm7URi26LOUelpy3ISA1YoBQe9pLSlo+vaoiCGEl29hxQ/IE6oquHRR3qIpZ5xVhiKEJ7+YaISoP37Iwyo88DrNh/s1XUNtOntAWmuD64W9ju211zu5TI2oblYnb1FbvrsVRAZcUVppwRLALgX1eOEmakFdjenJ9c0eT3hcM1475hTgwRaxC6twYtarfweQbNUUGoyhPe4asWpM7IsnYiDjsWK4QTW9Lw8Wkdp7fjHhtnjxpvHvxX3l20Q9327Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0R6/pYkkl5arlhdrpyVf+Fol2LxCndeTYdRd5JsWGm4=;
 b=BxId04BJSWbKlXB4JTANnSbO9Jnhh4jPEzb4c1y24qB31y4PWIgxGmDDLp3/ETOf5jR7kRK7H09Lqte9NBnOAX432bL8dxV8jLYXlz+B9zdu1I36w9GtOaDtsUTRscHo1q2OBqmKoSenLtrZzjSdkRiw9XtBQkmLY9TunVBdpt5S+rlxLtMQFZn0s9DT/aKIaTLndi7JMzO0yYGBHt0oz2OBlgq5jSZCCsS2yNtRNtte5gI1S9LDHAb5UGhi9sYJ7KSKsjrTqWPgj2XfYcbI1RBWYX0U2ts/NqGQ/MkGI8yVa/N5namxN9KE2X5R1sCaxe+h2JUMeQQjtW+inhDBEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CYYPR12MB8701.namprd12.prod.outlook.com (2603:10b6:930:bf::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.27; Mon, 28 Oct 2024 18:09:58 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%7]) with mapi id 15.20.8093.021; Mon, 28 Oct 2024
 18:09:58 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	Hugh Dickins <hughd@google.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Yu Zhao <yuzhao@google.com>,
	John Hubbard <jhubbard@nvidia.com>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v1 2/3] mm/huge_memory: add folio_split() to debugfs testing interface.
Date: Mon, 28 Oct 2024 14:09:31 -0400
Message-ID: <20241028180932.1319265-3-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241028180932.1319265-1-ziy@nvidia.com>
References: <20241028180932.1319265-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: IA1P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:461::10) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CYYPR12MB8701:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f48d684-8b3f-4ebb-7000-08dcf77bbbbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bZoEaxJv0FNq/X/1OeoQP22yEYtuFX3cmwcChyukL9dOZoU0qr4eW7oSGdX4?=
 =?us-ascii?Q?Y/P01xALVPRd20sRc3AVhu3zrMSAbfxzDLUMr0GJ5dqZi+OzFD7f8pWmpAge?=
 =?us-ascii?Q?Q3Xe9SQQatvw03Uh6ogEEq91uYXWperxyJxLTMZ/ivncyS6AQ3F6kth69VaZ?=
 =?us-ascii?Q?9rHOWV0rIBNOxNsXBW47LW2MANMOVIvfeP3TfyOzo/PL1EevxYIKmsuN6lAV?=
 =?us-ascii?Q?fdS4X69tQ3Vy0APObMcipV/N7yD6jGSmFjRjqTTt+dtOmWg/CE/6p0RQFLvm?=
 =?us-ascii?Q?rQis1oOMxOzV4+d0cL0a9NN+EKRASSrn3kHlSrZm4BljURzDQJj1fpEq35op?=
 =?us-ascii?Q?ylfhD7XhE3i+NAq7zSYpUtJRZWDqedbMXBS0khOkd3LDeNftFhlz4C8Tizv6?=
 =?us-ascii?Q?1DGfuGynZmVvQIkvSBT7KxuAe1AGz37hXpyjdmHBtnIIuwodA4dHpRCf/BY0?=
 =?us-ascii?Q?Rd4FVtIpsUOXZkUgHglB3xVN4G7/OUBXr6krmZqDE5C8udrdHa1fZOMbpgf0?=
 =?us-ascii?Q?24vZbI+7FbDuhcMjrIaKJE0z4Iw2ZAwlmWRbIdKNYJWK0OwOqmheKHjWyf6I?=
 =?us-ascii?Q?fhRbLXjB7CFmAeWsIsolWztmXMKDQIoVG/vedVFaevK3LUr/ROeD2Nh2W9y6?=
 =?us-ascii?Q?qT5HODKT+Ae1GICYksrXZK2B1bNzTyU/sufV7np0yx4mwcaBcdDGs4KY3hvo?=
 =?us-ascii?Q?rO7YPht2AV+HdUfQUZEDP3CYLv1ywQ7VXuX/35Xbh4GGAhlGMDXelBMVQxC6?=
 =?us-ascii?Q?C+rqYPGNA8O4rYPYLmkHkMboVAZ2LbSXgWi35UN/GtNUF9tysMXcq9EtsZsE?=
 =?us-ascii?Q?IZi0UqhydkuWqPjIAQp4WlL0+B5iXjKgmCrw3XxMMO0Rc5c5jd2ACIT3Ankr?=
 =?us-ascii?Q?IteIRKlIfkWYKEBV4O69tTSPkimj03ygnnO26Fn8WcAZR+i+vQqGZReMGbHT?=
 =?us-ascii?Q?kv421Uns9zu02jb8xgQ3G+SZH/UbTxNU7eaPT7UWZLUYA2G87CCgfWkdl8qk?=
 =?us-ascii?Q?qiCMxlXkGyosX1PH9/Nako9XUcQkbEQP+ORRhwN6ulUIp3idP35O1sPN7cnE?=
 =?us-ascii?Q?f/alMhq/gpxmJTAQz5d6+zz9KM/hJP7fakj61BJRIdLiOMJmFiwcYxeIUCCw?=
 =?us-ascii?Q?3Gc+HYNOyq1rzfvwkA+zB4+VXbkM0Ie0e1rurEharcrbW2i0VHM1NW94p+i0?=
 =?us-ascii?Q?1ubpDsgLzv+4eo15TQbuFcZ/Gn3oa0UH6nWBj/7ZHCmagrFc8pYvJQ/hgZTO?=
 =?us-ascii?Q?DTY7RXl8Jo6GCaWWTZE52QdzsmtrqpjjmotFaQ/aslpk71pdBe6jpGy313G3?=
 =?us-ascii?Q?ae+WgLU8M+lynw66WotOvlgr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z5Pq/7WUO6mhj8zcfq0rXf5pScZ8ZCXFC3tVCOHlwVht/Ad0LfV3pLiAkuSL?=
 =?us-ascii?Q?4k8+1tvWtLc8rwhxxUVIid6hGBdokOYIWmOroM2+t6xkGOmOBSZ79PrrRDoE?=
 =?us-ascii?Q?GV/hjDAxuTEm7yWYhjOFyPrfeQQ3jl91lD5QHXyDyJKrlkQy706rxQrUIx9L?=
 =?us-ascii?Q?xtn6L9/8u0uuVB2tGEWPQ29rr0bEDbtBmHJrXZ23zocXuvOgvz8ZvlASr6mm?=
 =?us-ascii?Q?zEn39BhWAk3ShAn27eM1hF+dE7ut2lY7IAlXb/AO1agNy+jIaJcfEvU2ZAr/?=
 =?us-ascii?Q?5y1i62Q+ZMAQNJKtZfm251ToTI8sAmgyl+W/cXrCz8QmmgRL9nf6dwDshxF7?=
 =?us-ascii?Q?i666k+7IdZvciAXq9VzE/ZS+1AUqaVlc9Tug7v67H6BQtzf/E+FOC2TQFlSr?=
 =?us-ascii?Q?4GgR8/qSjvLHubp8GwRaZeEOcL8zMSG7hSO9NfoDx/p/amNTdWPGf3lA1EBq?=
 =?us-ascii?Q?ujDVTurUP0pWV5eSGOYrbM9B+J6axUB8THFUDsawJwtIhvAPDmGiO91Wm/UI?=
 =?us-ascii?Q?YMXcEWL6kwXRtsz5HchHb+U/jHrlhJFLrzRRvBIePsHDLJs2K4HSAkEnoApg?=
 =?us-ascii?Q?5Qdiv/0btpV9MHKVPlCQRi4oCQl12X5d4B/ectUeGPW3S41HaP5NYNLCzw0A?=
 =?us-ascii?Q?7wuYF2aY3+C+EohZxbBTDoMvN9sAAAr9CALlQSRLqSS0GZj4ywklRfWc0P+b?=
 =?us-ascii?Q?rB76eYm5dz6QYAovkRVJK1jbM2fgc1lUk3cLdfOoXqxvQJlOpcXsLk/zHuud?=
 =?us-ascii?Q?DwftsRWKg3bAbwdYt9TOc/ltU6YmPFAKc6fwvpCdkWHNAN1STiKRUiErmsub?=
 =?us-ascii?Q?tJl2sgXfg+zzMSGvLcOQ+zA9fN5sh7KuLGQU26OUy05beEXHdqRyXGtk9snM?=
 =?us-ascii?Q?kTTeh+hRF3XLcTD+blBidHjigXhF189UkGX0AsY0mFzAUZhOJ6+newpO7pEo?=
 =?us-ascii?Q?TTxqHIspuxHqDCPZ7DKAZXNAlRPFoJq92psPYFshgwXKKlN3oIoTXquej8Ab?=
 =?us-ascii?Q?P3ELVuu4MxuFJpPN2DetyZYjqJoLjTPS4Y5Dd7QOziRieobsWCo+ceYN0FQw?=
 =?us-ascii?Q?krdHc9Y4Iq+IwMYQypQocBCiHDfccIXPQutx0oii1dzF/UZl8kiSPTlNE+tH?=
 =?us-ascii?Q?Qeop2AMQacw6xZfw4xZbWJE/MdU/Ushw9L/7lC6EwAXeVd2Q2ZVVNgYpBL8Z?=
 =?us-ascii?Q?fTCoa3x7gxy4wEgouQ4h1HgmILxnPJLmWBeFPNk/dDkEWYewEB6No2A8SfBQ?=
 =?us-ascii?Q?mEESyIoOxoA9rgTDd53tbZzk7dW5P1iT7VlxAprqpo4TYkXloeWgHYVztvst?=
 =?us-ascii?Q?1PcTGDAeDSPQEPgjOp1wkV2uL0kmOeevTzE0a2p6lgVKfOXtsQTPpk7OIYmK?=
 =?us-ascii?Q?S5sdHKcv2N1T09qM0fG6hox2udMqwaBKk6W72TJj05TJuXtPG7ojM6BOMnTJ?=
 =?us-ascii?Q?zJStqM/Wdt1RFVULv7i2/qVr79uoOd+b923wUtT+ebUnJLb62vtpMn038pdp?=
 =?us-ascii?Q?cE1ckkB2G4rnj23NWp1T8Z9l0JmjjoZXDVGYHNONA38zQ4GYaGqGfYBw+/bi?=
 =?us-ascii?Q?qowLK79FTMN+ppNDgYvcUJ3otbgndYwVNDJwhGWE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f48d684-8b3f-4ebb-7000-08dcf77bbbbc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 18:09:58.3401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Cmq1RcvaZLYlQIjz6XfL1lkQmNUw6CKQIQuFKNzuEDCJwryMJedH4oOBFSfvXTf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8701

This allows to test folio_split() by specifying an additional in folio
page offset parameter to split_huge_page debugfs interface.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 46 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0224925e4c3c..4ccd23473e2b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4072,7 +4072,8 @@ static inline bool vma_not_suitable_for_thp_split(struct vm_area_struct *vma)
 }
 
 static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
-				unsigned long vaddr_end, unsigned int new_order)
+				unsigned long vaddr_end, unsigned int new_order,
+				long in_folio_offset)
 {
 	int ret = 0;
 	struct task_struct *task;
@@ -4156,8 +4157,16 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 		if (!folio_test_anon(folio) && folio->mapping != mapping)
 			goto unlock;
 
-		if (!split_folio_to_order(folio, target_order))
-			split++;
+		if (in_folio_offset < 0 ||
+		    in_folio_offset >= folio_nr_pages(folio)) {
+			if (!split_folio_to_order(folio, target_order))
+				split++;
+		} else {
+			struct page *split_at = folio_page(folio,
+							   in_folio_offset);
+			if (!folio_split(folio, target_order, split_at, NULL))
+				split++;
+		}
 
 unlock:
 
@@ -4180,7 +4189,8 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 }
 
 static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
-				pgoff_t off_end, unsigned int new_order)
+				pgoff_t off_end, unsigned int new_order,
+				long in_folio_offset)
 {
 	struct filename *file;
 	struct file *candidate;
@@ -4229,8 +4239,15 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
 		if (folio->mapping != mapping)
 			goto unlock;
 
-		if (!split_folio_to_order(folio, target_order))
-			split++;
+		if (in_folio_offset < 0 || in_folio_offset >= nr_pages) {
+			if (!split_folio_to_order(folio, target_order))
+				split++;
+		} else {
+			struct page *split_at = folio_page(folio,
+							   in_folio_offset);
+			if (!folio_split(folio, target_order, split_at, NULL))
+				split++;
+		}
 
 unlock:
 		folio_unlock(folio);
@@ -4263,6 +4280,7 @@ static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
 	int pid;
 	unsigned long vaddr_start, vaddr_end;
 	unsigned int new_order = 0;
+	long in_folio_offset = -1;
 
 	ret = mutex_lock_interruptible(&split_debug_mutex);
 	if (ret)
@@ -4291,29 +4309,33 @@ static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
 			goto out;
 		}
 
-		ret = sscanf(buf, "0x%lx,0x%lx,%d", &off_start, &off_end, &new_order);
-		if (ret != 2 && ret != 3) {
+		ret = sscanf(buf, "0x%lx,0x%lx,%d,%ld", &off_start, &off_end,
+				&new_order, &in_folio_offset);
+		if (ret != 2 && ret != 3 && ret != 4) {
 			ret = -EINVAL;
 			goto out;
 		}
-		ret = split_huge_pages_in_file(file_path, off_start, off_end, new_order);
+		ret = split_huge_pages_in_file(file_path, off_start, off_end,
+				new_order, in_folio_offset);
 		if (!ret)
 			ret = input_len;
 
 		goto out;
 	}
 
-	ret = sscanf(input_buf, "%d,0x%lx,0x%lx,%d", &pid, &vaddr_start, &vaddr_end, &new_order);
+	ret = sscanf(input_buf, "%d,0x%lx,0x%lx,%d,%ld", &pid, &vaddr_start,
+			&vaddr_end, &new_order, &in_folio_offset);
 	if (ret == 1 && pid == 1) {
 		split_huge_pages_all();
 		ret = strlen(input_buf);
 		goto out;
-	} else if (ret != 3 && ret != 4) {
+	} else if (ret != 3 && ret != 4 && ret != 5) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	ret = split_huge_pages_pid(pid, vaddr_start, vaddr_end, new_order);
+	ret = split_huge_pages_pid(pid, vaddr_start, vaddr_end, new_order,
+			in_folio_offset);
 	if (!ret)
 		ret = strlen(input_buf);
 out:
-- 
2.45.2


