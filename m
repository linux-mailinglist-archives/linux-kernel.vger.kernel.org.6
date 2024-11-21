Return-Path: <linux-kernel+bounces-417346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F2E9D52D9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05041F22F88
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AF61DB940;
	Thu, 21 Nov 2024 18:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t2zOiWS9"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217701D932F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732215168; cv=fail; b=W93efWXo5y49uWPsn/rkOh39rQ6S1HRsUtKL6mxCHx5BDOJxFz4YM4yT766zbiu7/HT7aT+p0KHebF9CEkD0Yt66So4x1EY9FKkOhiJ4vapGiPN2I2cfooIJnWEG/Lkj/XA0ktvzwTPQyyykEg9wc734Lhw5CEIyOVr74NNA5Wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732215168; c=relaxed/simple;
	bh=b9ZAjUbBuvGec6yMxeVYIW6fIsYIzdb8qo1Prkv6kLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q91N9a5KKVh9bJYJTjg1Wzd8MMHVsgBSTd5+F24PuHYewz48SwTOSlNS+7EnNn+gx392CW9PhddjJqJuokEHW/DYNnQvnRovs+Qdm4sY8IjQY8xpGW4fbKVFwSP2oUyjulfKQwtpUgwBvCIZUbiTIuO5MmAD0jVblu3tUdcr8Ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t2zOiWS9; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=odmP8xx/H2RJIEu7jJwDSB6G1nTlObgsoIZvlM+rQOfwQ+ARqhbltupXRnW98hVWdBVdVZSp4WqBrcxw1wkRQ2YvLH7Urr46lCIh67g83KZIxpn9JJd3Ln+s23RUVSs4296LhOTb3SkLWQ4IkMckIQUjTQcSbtNOahQvUZJw1UfKnJCLXj6bmXacJTUhu54WbImBDKA/S3mknHfUgMafgB7N4iJ24i3GUjXn3hhzydsBEvddKEE2p2zXTUd5jxhwuowaeyyAixY31F9m1Kbehbcofz/HHiW8YXM6uQBwEv/CPCie5HIJ7u4M6C7Fo84ax5DkJ3KcmcVNswBF05hzKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKlBDIl4xrdnKlrWfw8XLDZsIOdmGI3JDlSG+Z0iz/4=;
 b=J5oHsDkZ352Jt5h4vaTtx0RyaH8hYvx/ZlxNupnRfK4Gu9zxcZERx7QC3QoDFLj1pkf+mfkMdmPchGgpzBsS0/EOWz7W6e5B19Q69XQex+WaQwc8XQPbiZqyXgpfZyjvow3Y+rpW6tsBGUg6D58Tu9LAsnuk1tPUIETN/Ocw/AljXd0L+y9gFLfpRsDr5EtD2cCvpQ6PRhO5deoiUd+sEi5DBdKymiXmE0bU4ZMTBcsUv2dFVrqfIy7dBfgyZCzCCO99CMlbndw79N20k4WMmkG783RRZX1SzYQ6f6gPF7xOykfmFRzrHv0lAqp2zRF6tD6DgXy7WNfQiAYq0idyUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKlBDIl4xrdnKlrWfw8XLDZsIOdmGI3JDlSG+Z0iz/4=;
 b=t2zOiWS9BWppiTs1AWRAsyjBsxCObECUieKUf/z/SQ7aVIzdsgSx9UmJBArqJ+hQr84vqoi1J0RAMFZmcMucrnLO6WZnu7K7Fm8nYRkQfvAfvcvtHUV8H33a08J7Xa5UTbbxSc1lHibnuOkzulyjekFODtifUVvJirtfln/j3ZS5Zv7qoMGE9A0HWdiPkLHkhcBwuu5NUVIjZk+txIIaC5hBeC7YxoFXXZSYwA3Zl6aUJyfmbBmKXd1PMb5IK+yZXj50EG5k3Mn41A+qRfMaNx5lwpwLTqwfyI/OPrDLF0BB80tGPbFiyX3Fr/kA7niK4lB7pSlvNp10xTMjF88uHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9)
 by MW6PR12MB8834.namprd12.prod.outlook.com (2603:10b6:303:23c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17; Thu, 21 Nov
 2024 18:52:36 +0000
Received: from BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9]) by BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9%5]) with mapi id 15.20.8158.024; Thu, 21 Nov 2024
 18:52:36 +0000
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
Subject: [PATCH v3 4/9] mm/huge_memory: remove the old, unused __split_huge_page()
Date: Thu, 21 Nov 2024 13:52:15 -0500
Message-ID: <20241121185220.2271520-5-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241121185220.2271520-1-ziy@nvidia.com>
References: <20241121185220.2271520-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0213.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::8) To BL4PR12MB9478.namprd12.prod.outlook.com
 (2603:10b6:208:58e::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9478:EE_|MW6PR12MB8834:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a323e4a-f4eb-4661-b6ff-08dd0a5daa55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l8nFepLP1LGeAaG9ZAdxhJ9ygX0qR6BmS+r4SX7YwBLRnNaZAfoH7FCC3JRS?=
 =?us-ascii?Q?lTjfNWFYS8qS0e++rheL11fnPtv/MJ8L72wMX51E4Pt8KyhvWYhiWe8MOXKc?=
 =?us-ascii?Q?4jwbvcocyS4mUErVAto5sKPyHP3nIDbNWwjC5lUweLrDcj1XaEjDpG9y91Zs?=
 =?us-ascii?Q?yLtxGZkJ5SXXNReppA38e2drSP2G4UVqdz5fvehIgQUboWZXsFkUgvm+DIWp?=
 =?us-ascii?Q?ArIr1UombvMm5qyzkq2NF4dJ3H6xHt8Us4vh7ki90ptYYawqqUDoRNLi1F4g?=
 =?us-ascii?Q?eWeRhziBkygCPDbDCsY3h4RMFe66wpqJpJ3Zk/OKpv62OpSwhFnOCPsfY3xF?=
 =?us-ascii?Q?7CMj9/OatPIfJ/9gOIjU5YGT6VQPuEKZiXkKeRNK76KyijAntUynQ5jeh8Mw?=
 =?us-ascii?Q?2p6SVWDNLWi75JvtyUZ42Va5k1AkKmKezE5wp9/rumKsDMO/63B/tj/bZY2o?=
 =?us-ascii?Q?7nMD9JdiJYd5Qawve1YyBgvj00CYJAdBGtqU/GCXI6r5Qveb80ipqMFzbNNd?=
 =?us-ascii?Q?vHPo9kf1h7KN2TpPcqgNC0V51Sb7jBQh9aKRmskXvK1B0y4eZN9XNvkgauNU?=
 =?us-ascii?Q?g1/zhVICXwfe42i8FDfhk9Y3jmjgWRstTDnu+BA4xU9xIpduMMQ0M0V2fASF?=
 =?us-ascii?Q?rdzuUieSoxMl0tH0mDRblD44UvKZ/S1tAr0hK2FPb3xuciafTtf7DDGxRJid?=
 =?us-ascii?Q?gRWRfViJU3q1aoSyjrUbg1xyf95zgPljwTqMTOS3+bYe5IO/NMIQodnd0IrF?=
 =?us-ascii?Q?nwrdpnpMMopRfkNITzWJZiYK3PRasWBBPFU1BhL4frbPPkyU0H0DpWwRzLv2?=
 =?us-ascii?Q?wOKEJ9PQHvqfgQTtR6zvQUkdLiCSWx1QDzALs8julDQgBK2APJ/mBrdywJi2?=
 =?us-ascii?Q?6Q5OyLAN+j47CEi4fUr7vKxb7p5PMNmrBRKHCbAYMCHaDlE3FSbBQx17hbIZ?=
 =?us-ascii?Q?4ek2yScZkQKnlyCl+Yo244RK4iND7mHLC9/OTOx1ynEOnqYvzaZjcAYbUodk?=
 =?us-ascii?Q?Yq5ggJAjU1+eRsaiCcLq7VhCJkAPS8u+c8opBVMm2Zt/LUYZWrcy7I590TQp?=
 =?us-ascii?Q?+pBmjqjHV3F9+l6tbPQmY68GUafpZjZZSAJq0uxNd0grbHWctC5REb4obcZR?=
 =?us-ascii?Q?WiBxCHQVdpLf55b/ZTludc46J8iiYGZV+a0uclZeQO6RaHMuXG3KzIrsWYj3?=
 =?us-ascii?Q?bEaxvR6F9OOlXZJBd/PmP++nFGkNINIET1a/7RiBrQ90hrB0rFHiL88YzuMP?=
 =?us-ascii?Q?8ICo2wKxvPWN36J54VjoWLID2vq4kci1sP+wwGJng+xfY4u/7kQfExDIuDFq?=
 =?us-ascii?Q?hv9SIgvERzqKKB3gPV+ddJit?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9478.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KII3TseLC2jiAdvkGOMl6Lnkdj80sDHhwCyQ2gdBvg/yKgoZZJEA4v5HuI5m?=
 =?us-ascii?Q?LHYnFMppWClTk9z+VJSYRmDaPUagfve68lJHwSx+ohVdrFZZY6N4iZEx7NFg?=
 =?us-ascii?Q?cqtUXZlj/CgtX4qtVJqW5CBElWIpQaM5UmMUlmi1ADS+6kpGkEu5775RqQwx?=
 =?us-ascii?Q?axm7zvIQjEHfI4xhsYDb2vN4UF8G710UAVdtAcMfo9mXAqrsk7V9ZjxR3jiv?=
 =?us-ascii?Q?semUJ3Bd4BRuQI/CKoxUWzMwjwclIpjZaGJSPQrs5NhtqOfqcLvTTasfIHbt?=
 =?us-ascii?Q?Y8c7u2WZ8xdtghMxay+CHMuQNs0M2giEjAEejUp1Ip6340qKhoX7hycj9dNs?=
 =?us-ascii?Q?WTr5tK2Ljhlp85zMVzsoh8Io/3JNngVKwarAg8b1YnkVbdJctdZtqWYN502V?=
 =?us-ascii?Q?NhvN8gxad2oSaAhu0ce826PYKx94mMssKOWH2xnXTCQuG/Ko1Y2qYR0+ReHn?=
 =?us-ascii?Q?LZKKob+yjmpJTV8Aqu4+fjc8zmGr8LEo6XMrBi7XzcJ98cCeR8yzh4cHXIoT?=
 =?us-ascii?Q?jjAEQtp6GLGql9XLpIzcDia8wNebOPToywhVMj6Sh0Hal/Qs1XdlcYeXcpVv?=
 =?us-ascii?Q?/jaWSXvYxS6oU7ObaT6eOEq9MAhciTqL/GPKD48dmWYkXWmCdERvi+y/ZHA4?=
 =?us-ascii?Q?o6jH8AEq8pFjiyCN0PWngFxJNIzJ3KNtLNUMzqf6SwlmV8p+kgP3YWt62gB1?=
 =?us-ascii?Q?pwsF1dcC6F8POXW7NDAO30NiHEOm8MNgY1gfskqnNF7uog97mjdsfk5Yxqe7?=
 =?us-ascii?Q?NUAagOIXjTj44WMs65M2foKIFTFaGRjdN/hxq3nLTyYmAAxibOzYbtbVxvzd?=
 =?us-ascii?Q?EF6IQjNYIQ3dv5Rl9IA1ft1pUQMEnD5B8NGa72NEZ9mvFFUsstmJeUJWNNvb?=
 =?us-ascii?Q?N0Su+fb2jzmQk3WzgqpHUb02Dp0VHmVGGtR50uVpzZP4F/UL76C9KwryHerJ?=
 =?us-ascii?Q?Lpw421T786+eQzNLqS41CobL0siAJob8/Lr9CWYbxjDnf0lICqJu9SYX19J7?=
 =?us-ascii?Q?HxI7Wi7rd/kxYTU8Y1TBfVncWyCymHfrIAN2RxLqoe/UX3uQf/ShXY3j99ii?=
 =?us-ascii?Q?JqkSOxu8lbZhe9I2yxO6VKW5kIgtDVpbpkQe2S4bVYS2uxQVc7rYaatrbSqH?=
 =?us-ascii?Q?hBd4qYrd00sJrqw/wd8qyHadMBeAudzHXrTtFj4oB/+/h5SSnj8jKoQh5nme?=
 =?us-ascii?Q?MuVzySmjAlgN1FRoHCey9A1tvXkJN5G45x+nSBADB7UJ6r0FbLEIZv1RJeC5?=
 =?us-ascii?Q?9HIWyzP13FATACY/0wKfogzkhmQW4GTEFu/iSiwfywSgC2BwAsX+g62t7Fl+?=
 =?us-ascii?Q?nNILRxY3DCWVNsyWYnhKkMXU3tEY7GsipppJsRbzm6HtnmgkLq/wlZuQa41C?=
 =?us-ascii?Q?GoSMeaA++zog70rOYLo9G0q0AU0w7nRqKZsBz7Ax44ed4sc499/0kzZdq/sU?=
 =?us-ascii?Q?oPW/dyqa82ufeyPqvXatGKvvf3IcZIowtaQZSVJVIvgf3cquD+REGf9BO+W2?=
 =?us-ascii?Q?WW/8Db+3EWh1Nrzzl9BDCa47Hr7NLoQEmhwuKSlsmYMyVlHyIllbKoaX/4d0?=
 =?us-ascii?Q?T6ts7K38qGTQ+R6LNro=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a323e4a-f4eb-4661-b6ff-08dd0a5daa55
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 18:52:36.3643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RspBYy5LcZecZYwfVe26IbB8sTKIu4vAlfsnl7d3JHhSaEaLormmHJ8na+s0zWdc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8834

Now split_huge_page_to_list_to_order() uses the new backend split code in
__folio_split_without_mapping(), the old __split_huge_page() and
__split_huge_page_tail() can be removed.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 207 -----------------------------------------------
 1 file changed, 207 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 3704e14b823a..9b3688870a16 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3146,213 +3146,6 @@ static void lru_add_page_tail(struct folio *folio, struct page *tail,
 	}
 }
 
-static void __split_huge_page_tail(struct folio *folio, int tail,
-		struct lruvec *lruvec, struct list_head *list,
-		unsigned int new_order)
-{
-	struct page *head = &folio->page;
-	struct page *page_tail = head + tail;
-	/*
-	 * Careful: new_folio is not a "real" folio before we cleared PageTail.
-	 * Don't pass it around before clear_compound_head().
-	 */
-	struct folio *new_folio = (struct folio *)page_tail;
-
-	VM_BUG_ON_PAGE(atomic_read(&page_tail->_mapcount) != -1, page_tail);
-
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
-#ifdef CONFIG_ARCH_USES_PG_ARCH_2
-			 (1L << PG_arch_2) |
-#endif
-#ifdef CONFIG_ARCH_USES_PG_ARCH_3
-			 (1L << PG_arch_3) |
-#endif
-			 (1L << PG_dirty) |
-			 LRU_GEN_MASK | LRU_REFS_MASK));
-
-	/* ->mapping in first and second tail page is replaced by other uses */
-	VM_BUG_ON_PAGE(tail > 2 && page_tail->mapping != TAIL_MAPPING,
-			page_tail);
-	new_folio->mapping = folio->mapping;
-	new_folio->index = folio->index + tail;
-
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
-
-	/* Page flags must be visible before we make the page non-compound. */
-	smp_wmb();
-
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
-
-	/* Finally unfreeze refcount. Additional reference from page cache. */
-	page_ref_unfreeze(page_tail,
-		1 + ((!folio_test_anon(folio) || folio_test_swapcache(folio)) ?
-			     folio_nr_pages(new_folio) : 0));
-
-	if (folio_test_young(folio))
-		folio_set_young(new_folio);
-	if (folio_test_idle(folio))
-		folio_set_idle(new_folio);
-
-	folio_xchg_last_cpupid(new_folio, folio_last_cpupid(folio));
-
-	/*
-	 * always add to the tail because some iterators expect new
-	 * pages to show after the currently processed elements - e.g.
-	 * migrate_pages
-	 */
-	lru_add_page_tail(folio, page_tail, lruvec, list);
-}
-
-static void __split_huge_page(struct page *page, struct list_head *list,
-		pgoff_t end, unsigned int new_order)
-{
-	struct folio *folio = page_folio(page);
-	struct page *head = &folio->page;
-	struct lruvec *lruvec;
-	struct address_space *swap_cache = NULL;
-	unsigned long offset = 0;
-	int i, nr_dropped = 0;
-	unsigned int new_nr = 1 << new_order;
-	int order = folio_order(folio);
-	unsigned int nr = 1 << order;
-
-	/* complete memcg works before add pages to LRU */
-	split_page_memcg(head, order, new_order);
-
-	if (folio_test_anon(folio) && folio_test_swapcache(folio)) {
-		offset = swap_cache_index(folio->swap);
-		swap_cache = swap_address_space(folio->swap);
-		xa_lock(&swap_cache->i_pages);
-	}
-
-	/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
-	lruvec = folio_lruvec_lock(folio);
-
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
-		}
-	}
-
-	if (!new_order)
-		ClearPageCompound(head);
-	else {
-		struct folio *new_folio = (struct folio *)head;
-
-		folio_set_order(new_folio, new_order);
-	}
-	unlock_page_lruvec(lruvec);
-	/* Caller disabled irqs, so they are still disabled here */
-
-	split_page_owner(head, order, new_order);
-	pgalloc_tag_split(folio, order, new_order);
-
-	/* See comment in __split_huge_page_tail() */
-	if (folio_test_anon(folio)) {
-		/* Additional pin to swap cache */
-		if (folio_test_swapcache(folio)) {
-			folio_ref_add(folio, 1 + new_nr);
-			xa_unlock(&swap_cache->i_pages);
-		} else {
-			folio_ref_inc(folio);
-		}
-	} else {
-		/* Additional pin to page cache */
-		folio_ref_add(folio, 1 + new_nr);
-		xa_unlock(&folio->mapping->i_pages);
-	}
-	local_irq_enable();
-
-	if (nr_dropped)
-		shmem_uncharge(folio->mapping->host, nr_dropped);
-	remap_page(folio, nr, PageAnon(head) ? RMP_USE_SHARED_ZEROPAGE : 0);
-
-	/*
-	 * set page to its compound_head when split to non order-0 pages, so
-	 * we can skip unlocking it below, since PG_locked is transferred to
-	 * the compound_head of the page and the caller will unlock it.
-	 */
-	if (new_order)
-		page = compound_head(page);
-
-	for (i = 0; i < nr; i += new_nr) {
-		struct page *subpage = head + i;
-		struct folio *new_folio = page_folio(subpage);
-		if (subpage == page)
-			continue;
-		folio_unlock(new_folio);
-
-		/*
-		 * Subpages may be freed if there wasn't any mapping
-		 * like if add_to_swap() is running on a lru page that
-		 * had its mapping zapped. And freeing these pages
-		 * requires taking the lru_lock so we do the put_page
-		 * of the tail pages after the split is complete.
-		 */
-		free_page_and_swap_cache(subpage);
-	}
-}
-
 /* Racy check whether the huge page can be split */
 bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins)
 {
-- 
2.45.2


