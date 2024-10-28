Return-Path: <linux-kernel+bounces-385569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E4E9B38C2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5DD41F22F7D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C89E1534E9;
	Mon, 28 Oct 2024 18:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EFlYRX+j"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394E61DE889
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 18:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730139005; cv=fail; b=dWrqdDoi6Mqo1lGXmW6bl0NmbiD66AV4KiXheiREqTpA0bPIPGX8syu7zumv9UG7HcCfsEfw6LRsuavHRy4GmlPr0lKOY6KpBSmu5EhTegcvhx0MSiKOGqTBwm6FUTAUQsbgv6knxpkg3bHDqzWKUAVg88yw47eGDhc+/3MGjJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730139005; c=relaxed/simple;
	bh=2YGzWVub5YWMFU362aD2g/TqReqqaHqmsttbpkuASok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XwOLtVAflZVclUOucwJi6J5vrep9SC7gdk9eN0/L1yCJO3MIUU0E7zw6uz/jHQi9yc2Eazk2Qjwc8rkhXzYpRnLafQr2MSsQl2Bb1b+4aUuSZHuW09t3v16Ymgp0yhKaGig/COyyR0yr098y+cSjbIJy/4Uu0TNwZbiUwHMTVYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EFlYRX+j; arc=fail smtp.client-ip=40.107.102.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xHDDeu5CSHczR+PJgw+iKhN0R8bD5XB2TljRxi/SLhIhNuizaWclOs2lUwlw+/vtQ3QSkuNkgecaQPK8EF6EajmzT2pSepJRljXQC0YcJsw+Mc/joPoLEBARkrjoO3AtyWYUqE8vDSLDHG0jiM5GKnyNJ2ckq5BW+jIGBiv3xLA8CwuMBxbE6e3o/wuqKlrRpw7OquFHM6EOwxcEskrGCav8TZzohORDUYJfvb1qT/SRBW/IdF+dIszMQ2ItGJlXOuUaSxbfip49gnJc9ZytRQ90VzDgo5p1wteMH3AN4I3/Fg64ZhqJcRgTgMKYMEgOp2WJcbR+YpQK7Gd13cVoKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWbxoUTlysn6+s9pyYwnQFKvbkOuokF7+PjqeWI/yJY=;
 b=H+uWv0waFNphAbQ/8yOJHjlPyYRElmqNcEXRM0iB9AzY5X+OWy7A6JqmRG6zKjNqz6O2x0ni8eCa/cnNhv/I7jjp8gMC9Ndn6jjTlDR/dpTuW+bT1yAwAjGLfqKO53V6D0Ujbj/L8OnZg0Q36cXi0eVjuA+x9PLIRhcLCmm5IrzWX0AMqnWGK1egXko/SIocUXp9VWcB6j+id5OxUq40ITlxNV9naqVJ8lvtss/lTDL6i8vKog7IYT/AMdsU8ku7Jod5UM9UsOI54vUuE4ZhtJdUFqx/B9+KiKJsKQKlxq9JdoXOZLby9PzucvVKe00E+dfiUju2kJ/Kll3k+eL8Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWbxoUTlysn6+s9pyYwnQFKvbkOuokF7+PjqeWI/yJY=;
 b=EFlYRX+j4T/82muwz/Rg0b2jDpAYWeuq7EVDdin5j/W+gQ58xdYxT8PfhidN1dX8hzla1qBNQGXr3NxgSKOFfELOLe00D7eD+CsuGqyaV2tyGoM3+Y7E52sgSzaV22eYI3hh8q/PTpp+ycrGSaoQMUefSf/odIFtxuXxqRi0zkJQuQCR+vcezIADncYhkRxk4YiyBC5EG9vO3MeEW+jWiS0QnTFvyeimL0gUu21q+bBdyMGdsY4GmPCeYdGXxwhTyT73hCS0pTgi2S4nggQTEAFeNGISxIa0dmRbOVydZEWEQMq0njLmpCt5kMNG7ZdwI3lk3K2hxnS6TgkM3sRH5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CYYPR12MB8701.namprd12.prod.outlook.com (2603:10b6:930:bf::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.27; Mon, 28 Oct 2024 18:09:57 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%7]) with mapi id 15.20.8093.021; Mon, 28 Oct 2024
 18:09:57 +0000
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
Subject: [PATCH v1 1/3] mm/huge_memory: buddy allocator like folio_split()
Date: Mon, 28 Oct 2024 14:09:30 -0400
Message-ID: <20241028180932.1319265-2-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241028180932.1319265-1-ziy@nvidia.com>
References: <20241028180932.1319265-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: IA1P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:461::12) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CYYPR12MB8701:EE_
X-MS-Office365-Filtering-Correlation-Id: 92dd34dc-c917-458b-5f14-08dcf77bbaf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fAnwf5kevMysWzAuxK0JSPQ4ayWeGaQBTtMQonDPKD/Ko8HaPu3Ztx1DPIpK?=
 =?us-ascii?Q?1BW/13V/K1erxMkGcOhehSqQJA2Fz1/jDSag70srOcd6dMaEPkU5fN6EvWu0?=
 =?us-ascii?Q?Kg1CcgEdQXHY7ewYabbnMDLPdcqNYjAsh8C7wBY1QT+VZRIs4YKT+4Q9OA/s?=
 =?us-ascii?Q?rTFGc8t3fXNbwtIq9vpoNi3649y/DmCVEmGcugdHoSZQPDQ7idRsa84WDmQD?=
 =?us-ascii?Q?1z1ncDBvjhsfOfwugSjwkRlI3fNLuq6/xITwiAYZBErNy1Zn3fs3pjICDDqd?=
 =?us-ascii?Q?kTtJxSUXcaVaddWSsAXH6beQNlAPD6DhIqRnwzdeD+G9MmqvPdU/osQ2Slq6?=
 =?us-ascii?Q?4mrVatJ0ZBDT+4SBFB/VxYrwE2U+tLix3mjbT3mzO7bKnI+9j0HHwYIvAT8V?=
 =?us-ascii?Q?WBODtnm6koNfE+sPDKpaeboPxWGIYQR6dGoGWe+l3SHlZJWj2YaIAlDRl/x6?=
 =?us-ascii?Q?L0SCYLCYS5tl5MenBHWb+RWAul7WSOMmHl/xaDPnBU27em4wJ9Z+rJOnPplq?=
 =?us-ascii?Q?ZbR9jMTzTNjl8w4T05vnVDdPS+1+srjnSD1FJ8GanGHS5JvZkr8hgDKQO+YA?=
 =?us-ascii?Q?7Qz31bOj7xxe5cFgjCdfou+dJ0Pw+mIdGLPWgRrbDQg0n1fHMs0fyRSYCcml?=
 =?us-ascii?Q?n7UBtcl568dkWBa6k93ky2VT4HW+ibJ32yGug/sef3VUs6jrdSItDWabbt0K?=
 =?us-ascii?Q?t292GBYc3UPjjDNym8XD8FMTXTg1dqEQh4JSfDMh0zGfUmF2eFtEnf3rEdro?=
 =?us-ascii?Q?uYrvZISX+sOm/5n5gltipXAD10dd4tV0KdoVehPeIbN4sRja5OAVXNKrKnb4?=
 =?us-ascii?Q?RUiPTYglPzufTf55s6XASVwELiZkrk/GYClNMur+aqROsjyE9iLyAjxrSFXH?=
 =?us-ascii?Q?OBhe8vzx48fjsDWwOqhpUNQb37UQUgS6qSDWm7ugEIJ8izk4NTd0/DUsGn8o?=
 =?us-ascii?Q?zlWy8l6HlfayJWnR1QSphtio3TW/Of2nr/OUPSprLiP5fYdMzY1UGBn3MuD5?=
 =?us-ascii?Q?mcBr5rauUkclGngFO5oavu1ehZnWidI9FyBVfQ6RKJ5BaYmOjRFhZYmrXRP6?=
 =?us-ascii?Q?4S3cQoaT2FQ9InKlsMiv1A2kBtGnsTRr6e7T9xoQKagMqCHw5dEp4C81VQC/?=
 =?us-ascii?Q?vqKquaTi4+TaNFwiSMeEwzYU/EJFdKXg9xH1n3ilOjZH8frI3gRQkrpcA7vt?=
 =?us-ascii?Q?ape/7nQtIQaogFePXq7zUtmAEUs6x52DyoX/S4XHyKNrAQNmmDKYDj4e77nh?=
 =?us-ascii?Q?qJ962fWEFJsiI/Vh6GVRq1tWxpaHWf+s0VGc2DobOlz0txeRnXvvTC1eTXR/?=
 =?us-ascii?Q?dpCuG2OWO0ki9tp03w8klBA3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hnr+nL/IHiiKx05h6wk0JYit5l+UGuqUBPbFqPr3LBpG8UDW+KOHEcSpdvDL?=
 =?us-ascii?Q?GqripA37gdQiFOZX11yPOuLu/LS0oI1w17VyvUXfobDJc0P8Iv9ppx2VN1Lv?=
 =?us-ascii?Q?V4GRCiblhKRn/7rO4xCFdejcinIbEKojXj+6IWrJOkjo3O0UVIW5jU9YPSac?=
 =?us-ascii?Q?MZlU2XZM2pyLUHJj1CXo73zOEoNlOCbEx73MvtqZBoiZzOpAwiYgGwu61Q4m?=
 =?us-ascii?Q?k4Emp5fF62f0M0t9P1oD2Ra7eFikxehwzf1zRBuen6VIKPoeNr98QJ++y9O0?=
 =?us-ascii?Q?CG4i8bqDpIpT+XWQ65Ngd39TDnSy+LTfJDSsHw9TswEtsmjhDdxwrtJXmyi4?=
 =?us-ascii?Q?F6PuBTgS17i2Gd+TaCZGPu5EjVXwpOXkPoItFyHOFeoJd5JmP/I27rgTIiPB?=
 =?us-ascii?Q?IhTlYBEE/LkH0tBGjItsBbtEd+PzXKRu6CBc183m1uwTHSDbXN1rwE4MrP0e?=
 =?us-ascii?Q?0LXl15egXMvplht7LBdhdr/OgdvBTDywcg6HbCc+gsCPJxyDawywRPSqxzlM?=
 =?us-ascii?Q?nBLldyn6/+7Qh6f1pOXbHwHqGQF8q4vYM67xTe/XjbIx0eVs5dveCiauUvpR?=
 =?us-ascii?Q?XsIBHd/L6toGjz0fNPkJHz/lmmSQ0lstw5OuzNQ5HkrtAQEtkkVGowzxL0tb?=
 =?us-ascii?Q?sAgY0qfRhcHKZfmqLal0XAsaQPXAxCgGXZepG/G7Qul+hmDtPlu/eGeSoJtu?=
 =?us-ascii?Q?64gxI4OxaXEGTkPeZlneprNNEu1AVZF9koddPaCjznz+/VR3S46Lar1sUQTb?=
 =?us-ascii?Q?fuL9vmCZ711ObGR9vRNM+CfqjQX3wKpLic9s0HZ3mM6G4uagSZeIG5m8/4ZQ?=
 =?us-ascii?Q?RkP6P3fCBonfYOobbFyxT0BAzN8oXG0u2QBPwPRxF5zd1Wk4BdPUHE0+TFrN?=
 =?us-ascii?Q?T45SC9bKViRPc0FAVDARbTGVeBL7wi82Rx4fpwILvanLzREUnGb/bu29GSE1?=
 =?us-ascii?Q?gkz+GaXiqIsGFzhE2iCyxamZRkoY20fTEl1rRZfIcVImD4EGDadYBxqX5U/S?=
 =?us-ascii?Q?Iwbvby5EpYbVpG9ssH2eEpIMm5M7muUASfKb4rx1jeufMlOrdSwHnrXdUj6l?=
 =?us-ascii?Q?+Td7BSjR6qHqP9Ikn+x+wudLxytJnfD/WfpfTsjFHhNdHJi1CGj5shKAaThx?=
 =?us-ascii?Q?+SGXg4OSjLtUvF6NU9+H1BEq2SN7i+1Sxi65UBV/BZsi0ownyYpjUwcSYKm8?=
 =?us-ascii?Q?xGmuiz8AwypwBAoOLVcTlH4JFxr1wLfJpjiMv1uCmCo6nzaK9dYjCrEg4c1I?=
 =?us-ascii?Q?CJcWcFQodSnk019sDI2pls7qxUMzCg9jXiJevQdfc8wss73jsA1JUH8lp5bY?=
 =?us-ascii?Q?CwpYru+294H/lttitf4hJRGdoiV9rZJNdm8nHkN3O1BziZe3n6Lr+poQ9Gk3?=
 =?us-ascii?Q?SfTspFOJ0PVv74+sxymnjHsdrqNk3d/NJWZfI/0Cyu7tebd9h8M4LP0r/GgV?=
 =?us-ascii?Q?w+7MEWfTGZartY08sZXsV7Utxco4s6Dj1n3OzVFVY6dPp4zEG5ApDS4Zkrru?=
 =?us-ascii?Q?NQXDifk4Ev6YMr99FNkKuUFVgHcUgnj01y8uM4E0d8z3HkGvtijGov1GiOBf?=
 =?us-ascii?Q?Ay7IGIGjj2cZ0TWCLSBDjq9ZZFHSo6rFPw3QH+P/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92dd34dc-c917-458b-5f14-08dcf77bbaf7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 18:09:57.1195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FlYCNtvEdZAECMa8jFAHZmCukjpwfmwYSGEiTWGMN4lseJl5wLr6+aMlyIiFN09E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8701

folio_split() splits a large folio in the same way as buddy allocator
splits a large free page for allocation. The purpose is to minimize the
number of folios after the split. For example, if user wants to free the
3rd subpage in a order-9 folio, folio_split() will split the order-9 folio
as:
O-0, O-0, O-0, O-0, O-2, O-3, O-4, O-5, O-6, O-7, O-8 if it is anon
O-1,      O-0, O-0, O-2, O-3, O-4, O-5, O-6, O-7, O-9 if it is pagecache
Since anon folio does not support order-1 yet.

It generates fewer folios than existing page split approach, which splits
the order-9 to 512 order-0 folios.

To minimize code duplication, __split_huge_page() and
__split_huge_page_tail() are replaced by __folio_split_without_mapping()
and __split_folio_to_order() respectively.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 604 +++++++++++++++++++++++++++++------------------
 1 file changed, 372 insertions(+), 232 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 832ca761b4c3..0224925e4c3c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3135,7 +3135,6 @@ static void remap_page(struct folio *folio, unsigned long nr, int flags)
 static void lru_add_page_tail(struct folio *folio, struct page *tail,
 		struct lruvec *lruvec, struct list_head *list)
 {
-	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
 	VM_BUG_ON_FOLIO(PageLRU(tail), folio);
 	lockdep_assert_held(&lruvec->lru_lock);
 
@@ -3155,202 +3154,325 @@ static void lru_add_page_tail(struct folio *folio, struct page *tail,
 	}
 }
 
-static void __split_huge_page_tail(struct folio *folio, int tail,
-		struct lruvec *lruvec, struct list_head *list,
-		unsigned int new_order)
+/* Racy check whether the huge page can be split */
+bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins)
 {
-	struct page *head = &folio->page;
-	struct page *page_tail = head + tail;
-	/*
-	 * Careful: new_folio is not a "real" folio before we cleared PageTail.
-	 * Don't pass it around before clear_compound_head().
-	 */
-	struct folio *new_folio = (struct folio *)page_tail;
+	int extra_pins;
 
-	VM_BUG_ON_PAGE(atomic_read(&page_tail->_mapcount) != -1, page_tail);
+	/* Additional pins from page cache */
+	if (folio_test_anon(folio))
+		extra_pins = folio_test_swapcache(folio) ?
+				folio_nr_pages(folio) : 0;
+	else
+		extra_pins = folio_nr_pages(folio);
+	if (pextra_pins)
+		*pextra_pins = extra_pins;
+	return folio_mapcount(folio) == folio_ref_count(folio) - extra_pins -
+					caller_pins;
+}
 
-	/*
-	 * Clone page flags before unfreezing refcount.
-	 *
-	 * After successful get_page_unless_zero() might follow flags change,
-	 * for example lock_page() which set PG_waiters.
-	 *
-	 * Note that for mapped sub-pages of an anonymous THP,
-	 * PG_anon_exclusive has been cleared in unmap_folio() and is stored in
-	 * the migration entry instead from where remap_page() will restore it.
-	 * We can still have PG_anon_exclusive set on effectively unmapped and
-	 * unreferenced sub-pages of an anonymous THP: we can simply drop
-	 * PG_anon_exclusive (-> PG_mappedtodisk) for these here.
-	 */
-	page_tail->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
-	page_tail->flags |= (head->flags &
-			((1L << PG_referenced) |
-			 (1L << PG_swapbacked) |
-			 (1L << PG_swapcache) |
-			 (1L << PG_mlocked) |
-			 (1L << PG_uptodate) |
-			 (1L << PG_active) |
-			 (1L << PG_workingset) |
-			 (1L << PG_locked) |
-			 (1L << PG_unevictable) |
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
 #ifdef CONFIG_ARCH_USES_PG_ARCH_2
-			 (1L << PG_arch_2) |
+				 (1L << PG_arch_2) |
 #endif
 #ifdef CONFIG_ARCH_USES_PG_ARCH_3
-			 (1L << PG_arch_3) |
+				 (1L << PG_arch_3) |
 #endif
-			 (1L << PG_dirty) |
-			 LRU_GEN_MASK | LRU_REFS_MASK));
+				 (1L << PG_dirty) |
+				 LRU_GEN_MASK | LRU_REFS_MASK));
 
-	/* ->mapping in first and second tail page is replaced by other uses */
-	VM_BUG_ON_PAGE(tail > 2 && page_tail->mapping != TAIL_MAPPING,
-			page_tail);
-	new_folio->mapping = folio->mapping;
-	new_folio->index = folio->index + tail;
+		/* ->mapping in first and second tail page is replaced by other uses */
+		VM_BUG_ON_PAGE(new_nr_pages > 2 && second_head->mapping != TAIL_MAPPING,
+			       second_head);
+		second_head->mapping = head->mapping;
+		second_head->index = head->index + index;
 
-	/*
-	 * page->private should not be set in tail pages. Fix up and warn once
-	 * if private is unexpectedly set.
-	 */
-	if (unlikely(page_tail->private)) {
-		VM_WARN_ON_ONCE_PAGE(true, page_tail);
-		page_tail->private = 0;
-	}
-	if (folio_test_swapcache(folio))
-		new_folio->swap.val = folio->swap.val + tail;
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
 
-	/* Page flags must be visible before we make the page non-compound. */
-	smp_wmb();
+		/* Page flags must be visible before we make the page non-compound. */
+		smp_wmb();
 
-	/*
-	 * Clear PageTail before unfreezing page refcount.
-	 *
-	 * After successful get_page_unless_zero() might follow put_page()
-	 * which needs correct compound_head().
-	 */
-	clear_compound_head(page_tail);
-	if (new_order) {
-		prep_compound_page(page_tail, new_order);
-		folio_set_large_rmappable(new_folio);
-	}
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
 
-	/* Finally unfreeze refcount. Additional reference from page cache. */
-	page_ref_unfreeze(page_tail,
-		1 + ((!folio_test_anon(folio) || folio_test_swapcache(folio)) ?
-			     folio_nr_pages(new_folio) : 0));
+			folio_set_order(folio, new_order);
+		} else {
+			if (PageHead(head))
+				ClearPageCompound(head);
+		}
 
-	if (folio_test_young(folio))
-		folio_set_young(new_folio);
-	if (folio_test_idle(folio))
-		folio_set_idle(new_folio);
+		if (folio_test_young(folio))
+			folio_set_young(new_folio);
+		if (folio_test_idle(folio))
+			folio_set_idle(new_folio);
 
-	folio_xchg_last_cpupid(new_folio, folio_last_cpupid(folio));
+		folio_xchg_last_cpupid(new_folio, folio_last_cpupid(folio));
+	}
 
-	/*
-	 * always add to the tail because some iterators expect new
-	 * pages to show after the currently processed elements - e.g.
-	 * migrate_pages
-	 */
-	lru_add_page_tail(folio, page_tail, lruvec, list);
+	return 0;
 }
 
-static void __split_huge_page(struct page *page, struct list_head *list,
-		pgoff_t end, unsigned int new_order)
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
+ */
+static int __folio_split_without_mapping(struct folio *folio, int new_order,
+		struct page *page, struct list_head *list, pgoff_t end,
+		struct xa_state *xas, struct address_space *mapping,
+		bool uniform_split)
 {
-	struct folio *folio = page_folio(page);
-	struct page *head = &folio->page;
 	struct lruvec *lruvec;
 	struct address_space *swap_cache = NULL;
-	unsigned long offset = 0;
-	int i, nr_dropped = 0;
-	unsigned int new_nr = 1 << new_order;
+	struct folio *origin_folio = folio;
+	struct folio *next_folio = folio_next(folio);
+	struct folio *new_folio;
+	struct folio *next;
 	int order = folio_order(folio);
-	unsigned int nr = 1 << order;
-
-	/* complete memcg works before add pages to LRU */
-	split_page_memcg(head, order, new_order);
+	int split_order = order - 1;
+	int nr_dropped = 0;
 
 	if (folio_test_anon(folio) && folio_test_swapcache(folio)) {
-		offset = swap_cache_index(folio->swap);
+		if (!uniform_split)
+			return -EINVAL;
+
 		swap_cache = swap_address_space(folio->swap);
 		xa_lock(&swap_cache->i_pages);
 	}
 
+	if (folio_test_anon(folio))
+		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
+
 	/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
 	lruvec = folio_lruvec_lock(folio);
 
-	ClearPageHasHWPoisoned(head);
-
-	for (i = nr - new_nr; i >= new_nr; i -= new_nr) {
-		struct folio *tail;
-		__split_huge_page_tail(folio, i, lruvec, list, new_order);
-		tail = page_folio(head + i);
-		/* Some pages can be beyond EOF: drop them from page cache */
-		if (tail->index >= end) {
-			if (shmem_mapping(folio->mapping))
-				nr_dropped++;
-			else if (folio_test_clear_dirty(tail))
-				folio_account_cleaned(tail,
-					inode_to_wb(folio->mapping->host));
-			__filemap_remove_folio(tail, NULL);
-			folio_put(tail);
-		} else if (!folio_test_anon(folio)) {
-			__xa_store(&folio->mapping->i_pages, tail->index,
-					tail, 0);
-		} else if (swap_cache) {
-			__xa_store(&swap_cache->i_pages, offset + i,
-					tail, 0);
+	/*
+	 * split to new_order one order at a time. For uniform split,
+	 * intermediate orders are skipped
+	 */
+	for (split_order = order - 1; split_order >= new_order; split_order--) {
+		int old_order = folio_order(folio);
+		struct folio *release;
+		struct folio *end_folio = folio_next(folio);
+		int status;
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
+				else
+					return -ENOMEM;
+			}
 		}
-	}
 
-	if (!new_order)
-		ClearPageCompound(head);
-	else {
-		struct folio *new_folio = (struct folio *)head;
+		split_page_memcg(&folio->page, old_order, split_order);
+		split_page_owner(&folio->page, old_order, split_order);
+		pgalloc_tag_split(folio, old_order, split_order);
 
-		folio_set_order(new_folio, new_order);
-	}
-	unlock_page_lruvec(lruvec);
-	/* Caller disabled irqs, so they are still disabled here */
+		status = __split_folio_to_order(folio, split_order);
 
-	split_page_owner(head, order, new_order);
-	pgalloc_tag_split(folio, order, new_order);
+		if (status < 0)
+			return status;
 
-	/* See comment in __split_huge_page_tail() */
-	if (folio_test_anon(folio)) {
-		/* Additional pin to swap cache */
-		if (folio_test_swapcache(folio)) {
-			folio_ref_add(folio, 1 + new_nr);
-			xa_unlock(&swap_cache->i_pages);
-		} else {
-			folio_ref_inc(folio);
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
+				if (split_order != new_order)
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
 		}
-	} else {
-		/* Additional pin to page cache */
-		folio_ref_add(folio, 1 + new_nr);
-		xa_unlock(&folio->mapping->i_pages);
 	}
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
 	local_irq_enable();
 
-	if (nr_dropped)
-		shmem_uncharge(folio->mapping->host, nr_dropped);
-	remap_page(folio, nr, PageAnon(head) ? RMP_USE_SHARED_ZEROPAGE : 0);
+	remap_page(origin_folio, 1 << order,
+			folio_test_anon(origin_folio) ?
+				RMP_USE_SHARED_ZEROPAGE : 0);
 
 	/*
-	 * set page to its compound_head when split to non order-0 pages, so
-	 * we can skip unlocking it below, since PG_locked is transferred to
-	 * the compound_head of the page and the caller will unlock it.
+	 * At this point, folio should contain the specified page, so that it
+	 * will be left to the caller to unlock it.
 	 */
-	if (new_order)
-		page = compound_head(page);
-
-	for (i = 0; i < nr; i += new_nr) {
-		struct page *subpage = head + i;
-		struct folio *new_folio = page_folio(subpage);
-		if (subpage == page)
+	for_each_folio_until_end_safe(new_folio, next, origin_folio, next_folio) {
+		if (uniform_split && new_folio == folio)
+			continue;
+		if (!uniform_split && new_folio == origin_folio)
 			continue;
-		folio_unlock(new_folio);
 
+		folio_unlock(new_folio);
 		/*
 		 * Subpages may be freed if there wasn't any mapping
 		 * like if add_to_swap() is running on a lru page that
@@ -3358,81 +3480,18 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 		 * requires taking the lru_lock so we do the put_page
 		 * of the tail pages after the split is complete.
 		 */
-		free_page_and_swap_cache(subpage);
+		free_page_and_swap_cache(&new_folio->page);
 	}
+	return 0;
 }
 
-/* Racy check whether the huge page can be split */
-bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins)
-{
-	int extra_pins;
 
-	/* Additional pins from page cache */
-	if (folio_test_anon(folio))
-		extra_pins = folio_test_swapcache(folio) ?
-				folio_nr_pages(folio) : 0;
-	else
-		extra_pins = folio_nr_pages(folio);
-	if (pextra_pins)
-		*pextra_pins = extra_pins;
-	return folio_mapcount(folio) == folio_ref_count(folio) - extra_pins -
-					caller_pins;
-}
 
-/*
- * This function splits a large folio into smaller folios of order @new_order.
- * @page can point to any page of the large folio to split. The split operation
- * does not change the position of @page.
- *
- * Prerequisites:
- *
- * 1) The caller must hold a reference on the @page's owning folio, also known
- *    as the large folio.
- *
- * 2) The large folio must be locked.
- *
- * 3) The folio must not be pinned. Any unexpected folio references, including
- *    GUP pins, will result in the folio not getting split; instead, the caller
- *    will receive an -EAGAIN.
- *
- * 4) @new_order > 1, usually. Splitting to order-1 anonymous folios is not
- *    supported for non-file-backed folios, because folio->_deferred_list, which
- *    is used by partially mapped folios, is stored in subpage 2, but an order-1
- *    folio only has subpages 0 and 1. File-backed order-1 folios are supported,
- *    since they do not use _deferred_list.
- *
- * After splitting, the caller's folio reference will be transferred to @page,
- * resulting in a raised refcount of @page after this call. The other pages may
- * be freed if they are not mapped.
- *
- * If @list is null, tail pages will be added to LRU list, otherwise, to @list.
- *
- * Pages in @new_order will inherit the mapping, flags, and so on from the
- * huge page.
- *
- * Returns 0 if the huge page was split successfully.
- *
- * Returns -EAGAIN if the folio has unexpected reference (e.g., GUP) or if
- * the folio was concurrently removed from the page cache.
- *
- * Returns -EBUSY when trying to split the huge zeropage, if the folio is
- * under writeback, if fs-specific folio metadata cannot currently be
- * released, or if some unexpected race happened (e.g., anon VMA disappeared,
- * truncation).
- *
- * Callers should ensure that the order respects the address space mapping
- * min-order if one is set for non-anonymous folios.
- *
- * Returns -EINVAL when trying to split to an order that is incompatible
- * with the folio. Splitting to order 0 is compatible with all folios.
- */
-int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
-				     unsigned int new_order)
+static int __folio_split(struct folio *folio, unsigned int new_order,
+		struct page *page, struct list_head *list, bool uniform_split)
 {
-	struct folio *folio = page_folio(page);
 	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
-	/* reset xarray order to new order after split */
-	XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new_order);
+	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
 	bool is_anon = folio_test_anon(folio);
 	struct address_space *mapping = NULL;
 	struct anon_vma *anon_vma = NULL;
@@ -3453,9 +3512,10 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 			VM_WARN_ONCE(1, "Cannot split to order-1 folio");
 			return -EINVAL;
 		}
-	} else if (new_order) {
+	} else {
 		/* Split shmem folio to non-zero order not supported */
-		if (shmem_mapping(folio->mapping)) {
+		if ((!uniform_split || new_order) &&
+		    shmem_mapping(folio->mapping)) {
 			VM_WARN_ONCE(1,
 				"Cannot split shmem folio to non-0 order");
 			return -EINVAL;
@@ -3466,7 +3526,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		 * CONFIG_READ_ONLY_THP_FOR_FS. But in that case, the mapping
 		 * does not actually support large folios properly.
 		 */
-		if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
+		if (new_order && IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
 		    !mapping_large_folio_support(folio->mapping)) {
 			VM_WARN_ONCE(1,
 				"Cannot split file folio to non-0 order");
@@ -3475,7 +3535,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 	}
 
 	/* Only swapping a whole PMD-mapped folio is supported */
-	if (folio_test_swapcache(folio) && new_order)
+	if (folio_test_swapcache(folio) && (!uniform_split || new_order))
 		return -EINVAL;
 
 	is_hzp = is_huge_zero_folio(folio);
@@ -3532,10 +3592,13 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 			goto out;
 		}
 
-		xas_split_alloc(&xas, folio, folio_order(folio), gfp);
-		if (xas_error(&xas)) {
-			ret = xas_error(&xas);
-			goto out;
+		if (uniform_split) {
+			xas_set_order(&xas, folio->index, new_order);
+			xas_split_alloc(&xas, folio, folio_order(folio), gfp);
+			if (xas_error(&xas)) {
+				ret = xas_error(&xas);
+				goto out;
+			}
 		}
 
 		anon_vma = NULL;
@@ -3600,7 +3663,6 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		if (mapping) {
 			int nr = folio_nr_pages(folio);
 
-			xas_split(&xas, folio, folio_order(folio));
 			if (folio_test_pmd_mappable(folio) &&
 			    new_order < HPAGE_PMD_ORDER) {
 				if (folio_test_swapbacked(folio)) {
@@ -3618,8 +3680,8 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 			mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
 			mod_mthp_stat(new_order, MTHP_STAT_NR_ANON, 1 << (order - new_order));
 		}
-		__split_huge_page(page, list, end, new_order);
-		ret = 0;
+		ret = __folio_split_without_mapping(page_folio(page), new_order,
+				page, list, end, &xas, mapping, uniform_split);
 	} else {
 		spin_unlock(&ds_queue->split_queue_lock);
 fail:
@@ -3645,6 +3707,61 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 	return ret;
 }
 
+/*
+ * This function splits a large folio into smaller folios of order @new_order.
+ * @page can point to any page of the large folio to split. The split operation
+ * does not change the position of @page.
+ *
+ * Prerequisites:
+ *
+ * 1) The caller must hold a reference on the @page's owning folio, also known
+ *    as the large folio.
+ *
+ * 2) The large folio must be locked.
+ *
+ * 3) The folio must not be pinned. Any unexpected folio references, including
+ *    GUP pins, will result in the folio not getting split; instead, the caller
+ *    will receive an -EAGAIN.
+ *
+ * 4) @new_order > 1, usually. Splitting to order-1 anonymous folios is not
+ *    supported for non-file-backed folios, because folio->_deferred_list, which
+ *    is used by partially mapped folios, is stored in subpage 2, but an order-1
+ *    folio only has subpages 0 and 1. File-backed order-1 folios are supported,
+ *    since they do not use _deferred_list.
+ *
+ * After splitting, the caller's folio reference will be transferred to @page,
+ * resulting in a raised refcount of @page after this call. The other pages may
+ * be freed if they are not mapped.
+ *
+ * If @list is null, tail pages will be added to LRU list, otherwise, to @list.
+ *
+ * Pages in @new_order will inherit the mapping, flags, and so on from the
+ * huge page.
+ *
+ * Returns 0 if the huge page was split successfully.
+ *
+ * Returns -EAGAIN if the folio has unexpected reference (e.g., GUP) or if
+ * the folio was concurrently removed from the page cache.
+ *
+ * Returns -EBUSY when trying to split the huge zeropage, if the folio is
+ * under writeback, if fs-specific folio metadata cannot currently be
+ * released, or if some unexpected race happened (e.g., anon VMA disappeared,
+ * truncation).
+ *
+ * Callers should ensure that the order respects the address space mapping
+ * min-order if one is set for non-anonymous folios.
+ *
+ * Returns -EINVAL when trying to split to an order that is incompatible
+ * with the folio. Splitting to order 0 is compatible with all folios.
+ */
+int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
+				     unsigned int new_order)
+{
+	struct folio *folio = page_folio(page);
+
+	return __folio_split(folio, new_order, page, list, true);
+}
+
 int min_order_for_split(struct folio *folio)
 {
 	if (folio_test_anon(folio))
@@ -3669,6 +3786,29 @@ int split_folio_to_list(struct folio *folio, struct list_head *list)
 	return split_huge_page_to_list_to_order(&folio->page, list, ret);
 }
 
+/*
+ * folio_split: split a folio at offset_in_new_order to a new_order folio
+ * @folio: folio to split
+ * @new_order: the order of the new folio
+ * @page: a page within the new folio
+ *
+ * return: 0: successful, <0 failed
+ *
+ * Split a folio at offset_in_new_order to a new_order folio, leave the
+ * remaining subpages of the original folio as large as possible. For example,
+ * split an order-9 folio at its third order-3 subpages to an order-3 folio.
+ * There are 2^6=64 order-3 subpages in an order-9 folio and the result will be
+ * a set of folios with different order and the new folio is in bracket:
+ * [order-4, {order-3}, order-3, order-5, order-6, order-7, order-8].
+ *
+ * After split, folio is left locked for caller.
+ */
+static int folio_split(struct folio *folio, unsigned int new_order,
+		struct page *page, struct list_head *list)
+{
+	return __folio_split(folio, new_order, page, list, false);
+}
+
 void __folio_undo_large_rmappable(struct folio *folio)
 {
 	struct deferred_split *ds_queue;
-- 
2.45.2


