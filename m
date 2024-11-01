Return-Path: <linux-kernel+bounces-392426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4FC9B93F2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 16:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CFAA1C20FC9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 15:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9D01AAE05;
	Fri,  1 Nov 2024 15:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l4OYe1+0"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E5C1AB50C
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730473468; cv=fail; b=dILrORR5nymt3THwVRsOHkR1gBlHkymTC3HpPwKsnhUZtUxXhRmMtW697XQLOIbMA28jKHldb3oYjFxxarLvl6jsv1hbEWzpCxHukY3jxQPDv7ZXJmqNlQ5Kz6DmN2mFlR3iU3NhvcOkq6De6jwZHT3z2hm9HzffqiujWRh4V9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730473468; c=relaxed/simple;
	bh=OkBxp+xM9B0gZQ2+9JngD8H/sxIDxX+RqKQR1gWv0nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G0LjgCXtvLIvrdiI8UQhlF6ixuxE5ox0YeIHRVON2Hqubff2iCxcvt0++GHd3vTUONILAczi7EW9ObtKtP5Ch6dI6T3byBl3ct9aYbty9ERsx5yn4JNCJiDpYUzKrbDvK3hfWyoV+sixL3lOUDXrJYNYrv6QOMszbH44QO+bsWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l4OYe1+0; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZlRRYN70X2vT2olV8qJKpPEvrbACTgC7ac1YX3T2T7PjOK4Qj/19trLjsc9ngQwOdv188OIHSaKtwG2PFh4WVl2myOwANQCHFmmqu8sMJ5k7Spge7CxRGP1ygOM7aR/4sEPbOn51J6k+XJeOeYQQgawsmgySXk5oPpv+bVBhNsbqub5ABExyPEDvGakWNd1yQm3fORDNfD6HvyB2QB0PuVO0l3gXi1dy2FjN68yQ9SI83PHP2EFcC0tiN2QLVp/w6DRVMJdv+osgfpWqHwkbuLoHpKCJ/FzBbgszj8TBgfrZBmrbMCpXWP/B4m4f9Ec/7pjKwm0Sx/6wgZjLiey/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suGnhTcndxZ9XndQoK2ebKftv0rgruxD+X4FouvzF9c=;
 b=CdM1W1g8jXCKqKU841PkUewl6/czv1xW8JnEz5IXgqog5nVl9tpmwuL3gIZdmYapwlXlt6Q7aCLrll1CEhK9UdDR7JIcIRIFeLoG9/dOprAx25hENOEFW+zPC+rswFPSAO3J5MV43x1+3WHIz1ghdEX0PzP9dCFTvtmRp/GR1d0oiJSOw3ExczvrlBqlQPqaDmApkfvrUGFhwCtNBUkJ43ZmD4Z6qx/H4waOis1hAfCfOCTI3NR/PtPeqXn2g/PZXXJ1ZZV1N5mUx+Z2WSeU73lWfzYYjbAdNMEVPfsj6SjP8LKIl6PNX9kMvTPnoQq8ZmX64LNXPUDEMH8/UU8JMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suGnhTcndxZ9XndQoK2ebKftv0rgruxD+X4FouvzF9c=;
 b=l4OYe1+0RpmXoQxhZ4LoAV/5/23E1WGMrIhO8IDZpVdgIDcy4s40ON4XZ5oojkEascDWqhMPPakLgBTRUCNhbGInHczUG0/V/Cr/N81SJ2uKwOD81dtt4YYLlXsr7aGB/ORuX4lLJ8oU3lFjNpyL6q1cqKCHjEgIsG0IWv4aniWoeRQaHEGaC1pQRsjDn7uxbn3iT0tcQsp7u2yOhRWn10GGd3WS4yEkY8NEusfKrEAN3BloIHyNErL1suI2KGx317Ls3bxyGBnPZuaAxYCpzMLu6nd9rASK0WQx0VqF0o0y7PMKp6txmb3m4ssPPmcPKF0lwsSNbQ9ztHSX1H/zFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY5PR12MB6621.namprd12.prod.outlook.com (2603:10b6:930:43::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.20; Fri, 1 Nov 2024 15:04:15 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%7]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 15:04:15 +0000
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
Subject: [PATCH v2 4/6] mm/huge_memory: remove the old, unused __split_huge_page()
Date: Fri,  1 Nov 2024 11:03:55 -0400
Message-ID: <20241101150357.1752726-5-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241101150357.1752726-1-ziy@nvidia.com>
References: <20241101150357.1752726-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0134.namprd04.prod.outlook.com
 (2603:10b6:408:ed::19) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY5PR12MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: f2b5bfad-d154-4ba6-0c20-08dcfa867283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KODxz14H2Z+04WtnCRS86SP8e1cgftFdKIpf4i7flPSneg38dPYqkHJp1kGk?=
 =?us-ascii?Q?nd91pt+kJRKjr+XSIz0dMUwUE1+0kHFfJaYnaMqxs7fn+1jidOQjPPitpyak?=
 =?us-ascii?Q?C8taqBtRKtmxB8z2iRQ9GEWPRnlNjZ1d9lkkGKFr/PP9dv34ILYWWXkEPpAb?=
 =?us-ascii?Q?krtLWfMW8CENd3vgsREFb+8nK0+JoSyHm0DEzni2YO4I72g1zdfn/OX6yyDd?=
 =?us-ascii?Q?o+3ZIfFMQdfqDgBw++6riPaZDGKyQBeYxZsOSne5kDfAzlyX6VVvo67fy3hg?=
 =?us-ascii?Q?L1pNtVLk/1tSc2xkFBRlp69BRLJU82hyrxi0m5LCwPEqwpdnc8mOkZYEtWon?=
 =?us-ascii?Q?sAvrdXX6D4heXVDuRzCOp8svRvrSBAgZksHOknYWIWMUwkx5qa72XMVzPhTT?=
 =?us-ascii?Q?7vlYwbDN/Q9I26D122e9YHKFkA8Vr/c9jsiPmsP9xMV08DP0EzTVi/CKGh6x?=
 =?us-ascii?Q?SXsWWvlaI9bKbm0HGaW5pfDvXNAOCSvvO9iIAHEZCqD+yZL6VaOnPF2oGKJ0?=
 =?us-ascii?Q?o8RPjfygVdOQ51zqnYAphPe2eVYm44Vk6TDTVNEX7ewKirVlJsv2Xf/BhUzB?=
 =?us-ascii?Q?Tf7NwwxNBvO0pAXpcYsLw+7bUAAVqCJNBNokh903HEOPzTL2DwECK8CvlUir?=
 =?us-ascii?Q?5iWuNqeix3Mps0akUL7EIJrei48icXqYdljKm8AqnUW0ulC9FgyTheGQsfyW?=
 =?us-ascii?Q?0tFIJ83csjhxQDvhivJxzP7M7rDsyqS/90YxnkJvqaQfsuWFfPqCdmg019Eo?=
 =?us-ascii?Q?l5i2wGszjoJJN73iN6dGDiOPlwqxTBZJKmRM1WSIjI2rcFqcffl0nNlnMjdl?=
 =?us-ascii?Q?68wCQzqUp4GFCUTi+pPVOYIPC297tcmgX75R1gpi4b2yp74GbsLPoRnnxuV+?=
 =?us-ascii?Q?Ha6Kq5Ed66dLrQrZGCYwDaURrokTjAW3mxLYVKFd/igP7g8vBEv+807E0BPn?=
 =?us-ascii?Q?SOQvXwMPmDEow1uI6IBPIDrrsvw0zq5EHmeCXawMlgdHyxotTcXPD9xikg/s?=
 =?us-ascii?Q?gZl752J0tL7OnmC+WfYCudOWga0QfJ1YzPrH3fQ4DGWnepnFPUMfOYdWhMw3?=
 =?us-ascii?Q?Lh4LJoJP/sdY/D0ysdkQcxqDAWdBBIXYDuXJbPmmrNBdm//YcXIOnUn2ed+5?=
 =?us-ascii?Q?DYN/MdOdVfvhYrJLWB5gBMLgqHEg4Q2CatQHEv3yTTYe7qaqx3IBp9XQ7sdA?=
 =?us-ascii?Q?q/rBu/yd0Gbj8KzXH/FqwyiE9+XL+BVtEcY3Jp0tsycagEzhIOLVlJeGGuni?=
 =?us-ascii?Q?M0ykuX8VumndIBR8T+lFSkbaSVsX6Qu4Q8ZuMHmwzthCIat5P0VP80ZGt08t?=
 =?us-ascii?Q?YBN3+yTDr1AKBuHTa1xMKdI2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yec7W7Z+gHe7zdlQHiexxmyyfpYRIIHe+i1r0Gf0xYf7hkwtTsGCI01vpTT2?=
 =?us-ascii?Q?j9txV0KD38Y9DdH2N9sGF5RXBXFKlZ6xIXNjOYVDUThl55FWuGusYwwbI6eg?=
 =?us-ascii?Q?4WPHMQJUMmF4KeVzp8Gym9Gnryf/K3rY05kDzJMG9xqbyXvu6B4JHYST8usP?=
 =?us-ascii?Q?/j1/TlS1CrgTn9b0l5eMTiNYfJNZ39jpZBYk6GcERaqsb2ml9Orsd3ok3yMp?=
 =?us-ascii?Q?vdZb6XaUYYot+lYPj79Dc06yjtMBCQEVauz4Ydmo1XB1G5HLMuk1wNJqP/CH?=
 =?us-ascii?Q?g1ohPsu5qcjx3+cbw0v+vxyDuJeqvLsm0z/yKaOP+X7gC0CiUQCW6oWUJFfS?=
 =?us-ascii?Q?nmnK7CsPClJ+upvLx1FTlcl6cX94iTt0DJ6Rp7R54GXYPHGDH6P8kdbudIcd?=
 =?us-ascii?Q?tdRWFZDcFHICwRKPUDNNklKgpmedHIxLlnS2pgJKaktByKTaVFz1RxmIcvGa?=
 =?us-ascii?Q?u0lOPP295rkopWqUa/E+yJ4lfwHDkEb+qJZjC0QOoTITFRbkVgrI0GUv73f9?=
 =?us-ascii?Q?H8qi8M5ZqS839f7kUb4hqnQUwtbMk3RfplIyD+kam0AuAUSfjA0G7l3WDJIn?=
 =?us-ascii?Q?xKH0clXqQB+LcznesXb01DbrTwcvurw8A/ljjpskDDtVM/3Fuoi7TiF41CdR?=
 =?us-ascii?Q?GuNjCGDDd4a7V0ZyzwmuaDqImm3SxYF9vE4qLAVLW5BeN25u6Wml2fA0nNB1?=
 =?us-ascii?Q?jJyQWj0M9zIeECru0KUlzEmuI5+T1hsp2LDgI7WORR6HtbONl41Foi4NBNWx?=
 =?us-ascii?Q?OMjg+lT4MzqtV75iWCi1fGK3fVcn4rGaQDSGZ+CAPNnIT3TflA+1D8+pMeG9?=
 =?us-ascii?Q?MMpJ2dKLHt3dsFbdpZWYYLGoGUTe+1M7xVdyGZ9k4nBu/EkzCFPDFFAA4WYE?=
 =?us-ascii?Q?7uv5Pq4txt5zqjKc8dDUYzbfIVgDKtK0/0xuIXFIPGMbBfuoiixHn710UQjZ?=
 =?us-ascii?Q?R/LxntCH/vEOLrprlOfmv2KfSWt6+dn+07jp4VjNe9UNOQK+VbYmiJFSDdgZ?=
 =?us-ascii?Q?S5zi35g5U01ybZyf+71zTa+wZsoWUbzD+qGVWQjTyb561Ysc7XHKurJr8ls6?=
 =?us-ascii?Q?t6G76uKpmHZrxy4uQYGnFyNItmbt2z7KhTiZP1sYHEC1yF80uT/9yCShErHt?=
 =?us-ascii?Q?AqdJXVVtiZXMb8kfmDzbMvs9mSZbH3Oznub3YjFe5/JmDp3cQ7H58R0bI4RX?=
 =?us-ascii?Q?BTjy+p+eEmiTuMG+jfJUMRUvCQpjiMAErwA4nlwtn41KTksJ8ZzpN2nJSXEc?=
 =?us-ascii?Q?RZgIEb0A4lym5HTfoLm5cBB0mVoAn+3+u32pbTWgnX41H83YxyoOLBdEOd2t?=
 =?us-ascii?Q?4Rzj7ar42m5VftERUAo4iHqsiyIMTAZUN1pJxjgRN6WCmtpueryXfPTbcsfD?=
 =?us-ascii?Q?oksl3OLh4bKLFG4zlUGb53i1SMzC74XlPfSBPLfY5pOz48Tedoo5iCql4rav?=
 =?us-ascii?Q?WakKzuQjjCGQ30ARbLGe60PWC+jomkm24T76NQlF6KyexWmYdr4s+Etkp6eB?=
 =?us-ascii?Q?mjv2BqVKB5e7KdrSs9GbyltEDaaNdm9VIYbp0k9DUvNB3Njh4DqIACqaHG6C?=
 =?us-ascii?Q?G+jdg9XUqZwjl+hZvFi3zpFA/ZVVfNY77K1zLsNW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2b5bfad-d154-4ba6-0c20-08dcfa867283
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 15:04:13.4858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lqibmb7cZzV3h34dzGD9OwOJR0D6vQs1p1EIJjCro09XO1IaUwX8UsAQLY0MlVA8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6621

Now split_huge_page_to_list_to_order() uses the new backend split code in
__folio_split_without_mapping(), the old __split_huge_page() and
__split_huge_page_tail() can be removed.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 207 -----------------------------------------------
 1 file changed, 207 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4f227d246ac5..f5094b677bb8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3154,213 +3154,6 @@ static void lru_add_page_tail(struct folio *folio, struct page *tail,
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


