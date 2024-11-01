Return-Path: <linux-kernel+bounces-392425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 043DF9B93F1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 16:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5BB7280F25
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 15:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFC41AB52F;
	Fri,  1 Nov 2024 15:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Eo2gG95e"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B5D1AA792
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 15:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730473465; cv=fail; b=i3Od3pOnzFaSt/U02nQ7rK9CQbzK0JcFlC5QSN0d8QWF+EalTZJH+1SglSdAsJeqLn8jnJfu6YpzSMYALLuVlt2qpfBFVZFG1lS+9ZpUF29CEZ8xZb3Lhg+YeY1LBSmJ0vT/UoJL/9ga7E5XkH7q7VSnwTAa3S6LjYReKoVdTOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730473465; c=relaxed/simple;
	bh=MbFvptQaohBLwgHytlTvxV6fSSSBEH2B6x9YFoX+AJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PPAofJfQ2eEZ5VHYKJ5YE0Y4as+S38M3Rk2rvAzPIsifM76TexUYUHeupGFfEnkY+6zyW9JscrZ18DJE/c+6Z3pcaXRaLrNgg1jl+86zufxWa4GH4bqxsCSNh91SU4rOlQqXaPn+zNrUJJYKpDqbGjdam1P/YoK9tmZeYEGhlVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Eo2gG95e; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+3dZDJYJTsFXi9IjFNOva9oVaYsqWUklTS8atRzfxKEtDPWplFaK1j11CjkgkkYitLDkj4rU1w6O10iIKxuPlQvJVWMP3O704zJbv6QsHkxR1yzcsJZbwCQNR+xves89uMMA64LbyGxjraPKWS1PQm9f6FQ77NkgRY0FQQu9y6rjUHx6Vmw/Bm4tLcuuR1RrMCmwDMhVig2c4qPUcTLFrApw79unqTXdApYhrD+lTkkIH5CKt4ZmykjcF3TpPEzURleodkBFs/OFCyS6fnrq3ytNiYpkEJUaBNaJOrJk5/oXGYyy3re/L4FvrTMyuHKEzWNARKFRJavT4KiwioHIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKioLr1HycFarfrZhAg1ByCjDsmUJhCDoEV444XxKIE=;
 b=MZRlOAbGcbwGp9du39Pm12CdH2fmLgkQs97foLeWcHrTiCj8rXj72exvHlwTb7UkgZ9fm/BzsKkJs53+rTzeeVUmnW6Yf1V2hjr30HImlkiLJ6SlA/mc2JkkcGY73Ga0YOAWr8pguOBzVJWJr3TPzpHo/58UWH4qBivwDpuPZwvaMkfC2mU56tb0iI2B8ox5PzITx8NcWD43+S0hCQkkJjRUIi3o8G58GWiv4q6dx20x2VZLhdzNbtg9E1YZnCrQE6wWUzP3hoioNO/sZIY4BgGi/YZx7fD5voqiBHHSMOpFN21BAI/nhbxEO9RPbMjQFUrxU0YGka75Spx215a4kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKioLr1HycFarfrZhAg1ByCjDsmUJhCDoEV444XxKIE=;
 b=Eo2gG95e23JftwobdxP9NxR0XvbDR7F191JuyHUjKUdZIDNjf3MZFK0fZYLKjFL3X04/Qz7gJBUmcTJ0Png1kR2mYwNfC1Mi153c0KgmiOXYNm/FkhrXDkFYm+fIzbrCz5SpsnoYSA3dx38aqHNatgI+qzao5DerHfi0pyIpLKuyDkIbBcsyCTktjll2Z3PsVI4BMUTXWpr3oqBfK+1PRqs3NNEPP99B8naB1HTxkBXYjnDyGgyXbvwydf15Vq5pZzWZvM2V1k1QeBopfLI6DQHCzfLQf8buuhDdcgr2UyG95/WxXMF8iTTMz2SR84nh7XHWkDH8hpJWGsBh6Nl5bA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY5PR12MB6621.namprd12.prod.outlook.com (2603:10b6:930:43::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.20; Fri, 1 Nov 2024 15:04:14 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%7]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 15:04:14 +0000
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
Subject: [PATCH v2 3/6] mm/huge_memory: add buddy allocator like folio_split()
Date: Fri,  1 Nov 2024 11:03:54 -0400
Message-ID: <20241101150357.1752726-4-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241101150357.1752726-1-ziy@nvidia.com>
References: <20241101150357.1752726-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0104.namprd03.prod.outlook.com
 (2603:10b6:408:fd::19) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY5PR12MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f806450-3353-41e3-a9b0-08dcfa867195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2xLtUKd59diCwbYnvUE1rCj9K5pkd6OHA+BwvnMsSwf0rPYwzuVQT584elsL?=
 =?us-ascii?Q?/WnyE4Wqtj1A/Wvs9Lgb/UPD0p+1eQ7G1ZCPuc/Gelgrm/l2lGhzH55sQOrf?=
 =?us-ascii?Q?EU5A8kBQOTpSymrx+Dxh6RW7OpQk5bithpI66SZ7XO0+k/srY+T2Pzibgbi7?=
 =?us-ascii?Q?QVUHfSEy+Xpe9XPHKVOBNfsEhbmAOz3FE1DYgQcJHO9snUlwCzPqQX6JhV/y?=
 =?us-ascii?Q?cdDDV7jZ0jROpres4ya7JEFIWgXRl9GKA0THAZesSAg3ncoeNTU57i3hBwau?=
 =?us-ascii?Q?uo/0+/RSSX/oZwPYokIk86sK+/KI7QmXrdkQBYB9v90WUs0nGpS1I/6aSGs+?=
 =?us-ascii?Q?HpR1T/15DyNY3dFmj8npqYljZOnzW3lpLRH6ocwrEKGXPXmNbm13J2MHl3yw?=
 =?us-ascii?Q?Rgkq6HSqRbZbJDijonh4NGFmyLB75h07GXYGjbXcPVm61x39k83iopeiqF8K?=
 =?us-ascii?Q?J1/Xk1Hx9oQwHud5OZxtcmeUQYQiM0K8KTYTnlO01Cqq2DsdCG6cuwPOShXc?=
 =?us-ascii?Q?T1byDGNe+yfWBVvDkH9yPJ4AieZI+8hW5Zw1YfL1aXUKRyyWDg+KOROJPtbw?=
 =?us-ascii?Q?pCPIZyPnXQwAFHo7c7g5VCvSJt3N8G5h7WiqyOTRUaEOhLJfu5jFOeLe2oOa?=
 =?us-ascii?Q?DGCr8fXf3LitmeOvlim3b7H0bejY3yLmAJIC6BbUUjJ515TsVjeEa5MKaYBG?=
 =?us-ascii?Q?jf5m0uARLFhKkPn9ZplcM88bu/57vVnSrGOjaLelTLZcmNyZf/xKZR0LO4wR?=
 =?us-ascii?Q?g4N2FyS52pryN+kQyD3dIp4UwY5JAJqyPgIFax7UIYk2vAI01/GweQeL5h2I?=
 =?us-ascii?Q?oHsweUVSr5rExoSQk1vkAkBviJ7ti4ZuesrxZ6g5L9We64kfXmdCR8BLlvRT?=
 =?us-ascii?Q?XYKdB6VHl30AOjoHSs12aMoqOu8QY0vF+H4oMPSDz3sl+bdWWwxKOn/pBHQ2?=
 =?us-ascii?Q?woTpfHV9a6bgBgfMndd8Dny/me/AJ0gFilHdVuZ7ziSKkKkXuYIkLGF7QP0f?=
 =?us-ascii?Q?i5KkS5cJDc90fGqfdIw+eURdBmRHDNCFIrllcl+R6AjaTolQEjeg1aGbzgbq?=
 =?us-ascii?Q?3klO1DmCezujTy680vaoJu6y/qB5At46AJRHDViTZvXr2HAmOdnp0RiRBM76?=
 =?us-ascii?Q?U8GZJRUzlhU+NxOkFZfmTBdbs/XJVvnla9YZwiDSCyMD3pz4i56mNccISeky?=
 =?us-ascii?Q?RsRBp5OZXTiTHZaHjQaAFyKFZXyg6zh1Hb/6b/5Bv9EQGwGNPvazFI8M+JMq?=
 =?us-ascii?Q?LSRDr5mvB3H6MQSaUOnK5hD0Q9ocQiipx4A4cd24fswboepYIo3FVcjllelG?=
 =?us-ascii?Q?svXjvXcAp0hHAPYN5cgF045h?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+uYK1geha0o2VRJocO2907wiRjG6hNi1tdzSGb4a+k7SWA8qRq0BNj0+IJ0x?=
 =?us-ascii?Q?G48smVVbH7rlo1ZS0N48jqD7GbHPz5xOebEr8A0KQTolUET6eRMNO34ooVB+?=
 =?us-ascii?Q?2/0yrx3/s+Q4fze+Blsu9KmHVuysLa8q/I3aZDrSox+0pF0glfc8G9qlEjjX?=
 =?us-ascii?Q?v+ZzHK72kTr+602CrAV5LStC20lcq3n67l4xffjcBH2xyEQjaCbNS3JzthbV?=
 =?us-ascii?Q?qIWI6fWGGOSHgp7ciE/kMBN+vQpHCqdOR1PSM4dD64Stlc4r6hee0ZnxDKcq?=
 =?us-ascii?Q?HTuC540+ZrOfaEQHPRwcbHgds+w7W0Xsp1+wwpSHjPeeAtFLOPTOgsd76axw?=
 =?us-ascii?Q?p3HEfTQyTNHSEu1/Gdy+rn6D2q3J1Qxq87149PASUOoUUJsxOR7UETNjXfjF?=
 =?us-ascii?Q?AGnN+20W+xOPiQnOBIEQADoj8a/AJDpwT/uiQRw2k20VF46Zn/8TXGpVM8Nv?=
 =?us-ascii?Q?Y4DYfR/8IskLuUmhT16QxNp+Qz0LhaPIVjlufhhrtbmdaRQwf9t3anT/nxOm?=
 =?us-ascii?Q?yen2/lYtkKLmsevpwA9NoTvCIAqSsSrVSODKcK3GGkLC7pDxTMF7wCvIta8R?=
 =?us-ascii?Q?yHtPJ27kfemY2/bOJ9Dy/7Qf5eLfMXy+VVFEbofhIalzf6ezEYxKDX1miYX3?=
 =?us-ascii?Q?15uGZxP1x9QdiCgtMWqH0IEbBulgXPvKqCsrz9oN4cw9ZeVAjt/k7fdT9aSC?=
 =?us-ascii?Q?6Z27QrZbvF9cQlJSn6richBMalHhtm/JOpZrsNThy/MVA/L1TACCFYwc6UN4?=
 =?us-ascii?Q?kz+wqwTqpLQ3L1VBGNCeletXn4sDK74IPnzAjLhfdVzqXYrwytITOHFHreBn?=
 =?us-ascii?Q?KEs9N5OGT6/LthCdVkjv6IRYrlevkf07fOdh9iOF8eSIAyCO4znxvYxKf8VK?=
 =?us-ascii?Q?y9fVcHaVkVSA1ZL7tEib9ankGruJV4WnO4QX4IMLqVSLw2jPp1DJO0gSV1QA?=
 =?us-ascii?Q?ru59W9l/IcdWWcf/ZL2a0h+yalV/xtoE4qOaL7v3qk3m5Wya+C0ohPw6BjH5?=
 =?us-ascii?Q?5eM4Q+MriahsoRP2uaBOluAIjYlHbQamMGxfU/tA/wcZJ4hrdWW3t/mNM8hx?=
 =?us-ascii?Q?H1+b155Y3xoG1ctN0CfSTAebLbyJLIR8Nn5Yy4o05c7HK6sB0LVMRpjmH/Ld?=
 =?us-ascii?Q?z5bCNVKQRY6QAAj8FJEYhbxoBIse0XXaDERqT6LUID5r5IC9SCTm/28DWW7Q?=
 =?us-ascii?Q?YAC0Y9vPftIr+f2ULLV7mdHdyEWNldjknPsOjrOe6F1uyYmvsI+t+00hwbeK?=
 =?us-ascii?Q?fnwidhpJ2FNhAmBcWcE1Lb1J0/JgfGG7WhtuIdF/Go856HVrwA1qrjRPujOy?=
 =?us-ascii?Q?Dj2XIHvPzTjwZuRCn33IXqI7d7B1CE7lK7H911GWPO6LHZ1bdzCddu4dc3ax?=
 =?us-ascii?Q?wP/1kwYR8zJSLQpEYSpGdVEFdlunFAj8lIB8koesZDmBAdK9PzW5P4fvk34F?=
 =?us-ascii?Q?Rm0Za77qVBquJ3cpHBIKgxmddn5csQgZTef9eaFoFyiXuRYCK1x51OvzNCts?=
 =?us-ascii?Q?JkvCRJSeuIlVIQCn6TcCAAkhQz+oHq6Lod/akUN0SFpLB7T+TJzLqiUSFDw8?=
 =?us-ascii?Q?0pXH1grj3VHxLIx8kkl/Yt6UBhxTNT5vepWOb0Iv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f806450-3353-41e3-a9b0-08dcfa867195
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 15:04:11.9369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gWhB/mhHh1S3cKk54Ffm4G7e0O59KhunT/Sq8f1zmTpfByb/sskKmI2gVP/xkEal
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6621

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

folio_split() and existing split_huge_page_to_list_to_order() share
the folio unmapping and remapping code in __folio_split() and the common
backend split code in __folio_split_without_mapping() using
uniform_split variable to distinguish their operations.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 56 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 15 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 63ca870ca3fb..4f227d246ac5 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3706,11 +3706,10 @@ static int __folio_split_without_mapping(struct folio *folio, int new_order,
 }
 
 static int __folio_split(struct folio *folio, unsigned int new_order,
-		struct page *page, struct list_head *list)
+		struct page *page, struct list_head *list, bool uniform_split)
 {
 	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
-	/* reset xarray order to new order after split */
-	XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new_order);
+	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
 	bool is_anon = folio_test_anon(folio);
 	struct address_space *mapping = NULL;
 	struct anon_vma *anon_vma = NULL;
@@ -3731,9 +3730,10 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
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
@@ -3744,7 +3744,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		 * CONFIG_READ_ONLY_THP_FOR_FS. But in that case, the mapping
 		 * does not actually support large folios properly.
 		 */
-		if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
+		if (new_order && IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
 		    !mapping_large_folio_support(folio->mapping)) {
 			VM_WARN_ONCE(1,
 				"Cannot split file folio to non-0 order");
@@ -3753,7 +3753,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	}
 
 	/* Only swapping a whole PMD-mapped folio is supported */
-	if (folio_test_swapcache(folio) && new_order)
+	if (folio_test_swapcache(folio) && (!uniform_split || new_order))
 		return -EINVAL;
 
 	is_hzp = is_huge_zero_folio(folio);
@@ -3810,10 +3810,13 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
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
@@ -3878,7 +3881,6 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		if (mapping) {
 			int nr = folio_nr_pages(folio);
 
-			xas_split(&xas, folio, folio_order(folio));
 			if (folio_test_pmd_mappable(folio) &&
 			    new_order < HPAGE_PMD_ORDER) {
 				if (folio_test_swapbacked(folio)) {
@@ -3896,8 +3898,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
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
@@ -3975,7 +3977,31 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 {
 	struct folio *folio = page_folio(page);
 
-	return __folio_split(folio, new_order, page, list);
+	return __folio_split(folio, new_order, page, list, true);
+}
+
+/*
+ * folio_split: split a folio at offset_in_new_order to a new_order folio
+ * @folio: folio to split
+ * @new_order: the order of the new folio
+ * @page: a page within the new folio
+ *
+ * return: 0: successful, <0 failed (if -ENOMEM is returned, @folio might be
+ * split but not to @new_order, the caller needs to check)
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
+int folio_split(struct folio *folio, unsigned int new_order,
+		struct page *page, struct list_head *list)
+{
+	return __folio_split(folio, new_order, page, list, false);
 }
 
 int min_order_for_split(struct folio *folio)
-- 
2.45.2


