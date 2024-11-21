Return-Path: <linux-kernel+bounces-417345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4189D52D6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8444B281D7E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E527D1D95B3;
	Thu, 21 Nov 2024 18:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s2bpx/VE"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DE81D86EC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732215165; cv=fail; b=Rc/33KnpAtQBWOM4qDCVa6cFCplWUQAY9aPytAfUt/h6Gl4MJnKNS4K7O9gAnDuLxBs/hzF3H/KuScKvgsr65AuvX/Qi5DBIB+AAF4izDUU/y7p0y9dBdaiKbFdf39WzNQXPnieWMkZkSgaJteSJZ0aBZKlvHb3B/p9V2AdqTYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732215165; c=relaxed/simple;
	bh=3MQJz7ztXelZ/7Z8AyHLJa7KXq36Vn4IiZtpTiEns4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OYwB5AgaRdYu71ZDVltY6fQRH7t3Rov3mrzsk2AbWyLntbHJltqi8DgdWzN8ntKoFFixw66Fq8TdBxf67uFER2lefHY9jhBo2vW1bClIHvtusctCNSzi0Gi+uSvBVYG883IYi2/SDDomHQFWSy19lp7RLjgnyHgSAh6sU/dw90Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s2bpx/VE; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRIWmgE2MlO0UrKdo8G+8P2lSSwDRe6abG0imrtZFXqpGMFSlcE8lH4oOY4M9E+SNbuPqG2Z++0KPqHW3YoaSkdMCUU160Yq45tyogj1BGEeFT+zeutFA9Q7qyD0ken41euypr10R1ssRZ9E5LQlNLV+HXuE96WNiSgmtzN0IDHK8jZKqkqUroj0rS103+BmMXyc/faUZst9GTYgPlOeNz2PGqJdh+836rv30MDM7W+JJunTq7SA3hDuUYxZEIrm2/B9TCsxTqCtnH3pNJx4b2gjWP1eb7S5Q1op2MViE+bkoExoUpWW7yeFlzDYg4I86nHlHkD/bNc9VWcrfjTgdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ts7Qc9/C05pLsaXYWIu3CbN2/lxdspXHxDrSlMv5iU0=;
 b=rja76Xrl5iDNrn+XHZhknkXnBPgXIGT5QzvRzdrArlnUQ98bSrre2eHOAp//y/2OKiIwMt3gKuUW0l5UOSqclyrxRIx8+Xq8C525Yop9XGouFlyq/uOWZRriI1jL25AYsaTeVk5uRd4Y3wIyVuFIByVCcXL69dTs+RpP1vf1mWSpIz3XAwIonj6MSGt2Ud7cyY3OWP/MaCTYdp+1Hs56vb/jOEh71NGgSnLcwQp22s8R/M9Er1RuPrywmU5+Dkt5gMDiU/ATKAWuQPKhgAOF+2w3DKEe8ol20PaoEQB0beCv7/m+O2RrMdCeluv9bh9GJTjRoGLDU3kGX6+o3txA8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ts7Qc9/C05pLsaXYWIu3CbN2/lxdspXHxDrSlMv5iU0=;
 b=s2bpx/VENLghMTFsEFYu79KDdXfHc/BB8xPy3KAk8B8P4GNcenGgg9R/xkLPORDdfj7qnWl4kZ2tqRK/BnT7N7nFVpdBERGYQIHXnzVXyRIq4nLrBh+QT+H6nMuKBIrk5UtxnbRHtIe9TrwbIT59DbkAiqEBKZU/eBvmnElIzCdrIQUNvo3a6t91puAjcP2eCQgUUS8ckMlBW0ShNNh7AbLzTOtAvCwepotJ/xEz2y6uWOAIHB3HAWraAHAz5FT8xHe9fLlDg8sXu3AX3BIIhdswtTwMN0qpQnpdUrh9MuBYnDh7F2tGg9m5Yld3tsKDpRx7p5RiAlDvy2L6aEv04Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9)
 by MW6PR12MB8834.namprd12.prod.outlook.com (2603:10b6:303:23c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17; Thu, 21 Nov
 2024 18:52:35 +0000
Received: from BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9]) by BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9%5]) with mapi id 15.20.8158.024; Thu, 21 Nov 2024
 18:52:35 +0000
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
Subject: [PATCH v3 3/9] mm/huge_memory: add buddy allocator like folio_split()
Date: Thu, 21 Nov 2024 13:52:14 -0500
Message-ID: <20241121185220.2271520-4-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241121185220.2271520-1-ziy@nvidia.com>
References: <20241121185220.2271520-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0231.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::26) To BL4PR12MB9478.namprd12.prod.outlook.com
 (2603:10b6:208:58e::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9478:EE_|MW6PR12MB8834:EE_
X-MS-Office365-Filtering-Correlation-Id: c8da9061-af52-4db3-a33f-08dd0a5da9ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RhqHIy1oK8JKs4lAjUjUkY//sTJ9NB5RDT5/nRwvy6QEh6d82MnWO14Pme+c?=
 =?us-ascii?Q?A5aLcYOjV+fNO8nV24U9fGTIxBCq3sd8iLC/34WN2xWd9MezDTHNGmD9rkV+?=
 =?us-ascii?Q?Xv0mLnfIQtGUbejpOONPLbwFDB2K1t+/OgpX2Ox7Y6vOYHgRSimTDALk3UgC?=
 =?us-ascii?Q?9mRZ5xvqCZ+NRxck7fQHHdpFrnpU0xnRpeCPh0fCNOkgLT8g1TeDwgOPeie1?=
 =?us-ascii?Q?YP72Bi1QIP0kRVhxSyRw5zsuW/XDsfIUTpL+MPz9VEW7ohKRZiC7ydU1Pn5d?=
 =?us-ascii?Q?zE9LkjCj8UhuBoGWWfVyNKeoumO4ZgYEtGJNZjJ6rRGO4s6+SH7kqiFNmZR4?=
 =?us-ascii?Q?GZlUUvldAAJq2D5j08O2aIzEXS2itXZaA0I1fperQVLJpi74aCqSx1fgbYCC?=
 =?us-ascii?Q?ya8GenNosF0BblHixL88mRNc8SCsWowqHx0xNIgHavUqTV1tlF0/iNBKiYbs?=
 =?us-ascii?Q?H0ESd6z8vmnpWbtPmjrjHo51JshQ6qOU/hO/+6O+V+bKKUY13XKUsReIa5/9?=
 =?us-ascii?Q?aAkafxgGik5E+Amy2BcGVSUpoLAMJ1TzdMJS9zEQ7GM5EFijkasSNM9Ta5fn?=
 =?us-ascii?Q?TErO4pv3ghW0SGblFl96tWUYTQ7Lr3ZGHM0+pKTWGAWxtuzsmUydyuz6fAfV?=
 =?us-ascii?Q?0cGKaauPFmV1BvPDi1lo6cHg1XWGtVMgRHc4LIlXRgvVMvh9xR2sK9vlYOT2?=
 =?us-ascii?Q?nSp+Xb0Hx5Zz185ESXwi4nHX5T41ER1WlUnRIIjMkDoVfRfolLBc3LlpZ03B?=
 =?us-ascii?Q?/o1oaeepjbjwmpdsDR4lwkh/lSlb+VYfiBYv4CBy3Sb8vvoEmla6Y/YQMyvu?=
 =?us-ascii?Q?N9/d0ncKEfz+O+OoVFQ8y14PoKdXA332wbwchTJF2kwTsRmWRf2GiGt/6UkN?=
 =?us-ascii?Q?CFCwiBN/39bRp4Yv/t96rEXbr903AJCErT9PYxoTSkFdaZh1Bsg3M75tg+Yn?=
 =?us-ascii?Q?qiiHMi6fO3R2CnaXNRRMoSomkbeduNjoFigGfFNlNmrr0EBZ9NYW/twEC7QE?=
 =?us-ascii?Q?mpTqGd/X6PylPViD2YYNsTlIHLDfQwPTypNd8ivA2nh1cCHtmV0WmYyHxS5w?=
 =?us-ascii?Q?JbaOym/CNMHl4vrUpDFHTDcerqrm0/0YWgesGRWwu0mJTOX87z2eXSTdAg2s?=
 =?us-ascii?Q?O6ijiJvTNYMhs1Bs+InB5GkyC1lIiYy+1PC3CU7O8pT9D7OtAttV+jva4Y4M?=
 =?us-ascii?Q?wPqSUyBfpJVmaXnBsV2RyXlMGj+rpUWaEpfCKxhgKIokFNGhy1N8Gsw5lxAH?=
 =?us-ascii?Q?NfiT57/mRGOguQkkLCAdmCgF9R8vBhUX5Qyu3bOM84r+dgMJbSOcuRbbU/IA?=
 =?us-ascii?Q?nkQQeXVBM643pjy3yWR8cjOM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9478.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MF7noa2DQX4uZPEfYUIBjyUSf3WZZI/IGvHOMFwF15TJzS40HUUQwwGnqZOU?=
 =?us-ascii?Q?MNz0RSFWcjoyIPaNVf4qXH0bgtqSgQSeeUj/YHyfMotnCq0Fz+OwL0c5Cvtv?=
 =?us-ascii?Q?W9yE+o10lndYmr1bejaou+lecB3fAQ8cByZdm0Nl7rG/68ZCBNCf56LWUmPq?=
 =?us-ascii?Q?4EvLLQIGn7MhovTXWRKD++BZauWpOgR/VhI8hJaX7ie201BlvQ3Kufqtvd5M?=
 =?us-ascii?Q?285/tZ1FY4CQY6Dn+W3r0yET8eSzQMyR8wN/EGMMHV8ifAl3+zbFcTW7kY8k?=
 =?us-ascii?Q?FQuWuMsSgl2WTOAohqpow2h5euv9HOQRSDz9hoTKE1SwqS+vSL6i00icjbGz?=
 =?us-ascii?Q?zndco39tE9DTXQOpYGxM7l0c9jtRh2MGm0eByhaTzWlHZ9EZrHl6xa6bKJLn?=
 =?us-ascii?Q?SBrw+x9oXFm/UX3XRs4ZL98BjqAf5txbL0QBPYHCrdZIVrc8DVOEy065rpyV?=
 =?us-ascii?Q?0Fg2g7O29nG2r5evIEq/HgsWRmW9I5AN9XgccuC4Pahf1Dh0DHTAalMHO9qx?=
 =?us-ascii?Q?QP5Y0JuoHP4qbB3ggbyAxnRDj0mYbAC9T60UFyd959+2OPHt/t1v3tQ4cBjZ?=
 =?us-ascii?Q?LiPc/WbiVxmd5TJslD/NE782TFhBo4XPDVV+q/XU09oVyA37qGcZEKwtbeaG?=
 =?us-ascii?Q?wq6wMtYjoJfgxedIFUofP7/u8fjeHKBErtTu5O6Bd5mPnkIa/m0gP9+iqw16?=
 =?us-ascii?Q?/K6cJ1/T4R1PiC2F8ZMl6IKjCZQsTcE1z9GCB4xNihOi0iQ8cJXHe1jZhvQf?=
 =?us-ascii?Q?wlz1LuymIQp5X2Bc24ZR/aUbzeuopRYyIqXEhz/66mi/KJPQwzze6g+aa9BR?=
 =?us-ascii?Q?xCEig/mlr4SHw9OKeMQ5123AEFWTZWOsk8/HDapAU2N04e28DCMtkeZzdFU0?=
 =?us-ascii?Q?AucPKxoCWrRDrLAn3rWPgZ4pPylULJYNFEpIJqg+YLRSeLS/RwsbnfiiQVn+?=
 =?us-ascii?Q?YqKx2sS2ISF2Mu/DBWxyOuYkHGOCkeF8SHiNogs3Miuvxkg8PS5Vv3C4NOdb?=
 =?us-ascii?Q?CWnRJqymp9bn5Q1J5WxDyuw/Kdr+Wrmyq8y1VE/4oj82ANKzQgdK6K2QJ2lr?=
 =?us-ascii?Q?QEwA4t7Z+1QZWTUv7LMnyOQfvysatV2UtoPjgza0v6uJgF8XvXhaXNLoVsyD?=
 =?us-ascii?Q?2dUuSzs17TzZWRFZXjXeaQnouWwu8iuVlfcQgLQIMwpOCYmJ8SpbQf/Fj+uM?=
 =?us-ascii?Q?R8bFqFkTemwYkv2wCXumicZLqKt35bK119fu3PGEg9IUqtBoxYiDyAESIdzp?=
 =?us-ascii?Q?gL9YDBSElT6KyYSxRni/KMvpQipFkbfPT0MbIKigj9inog8wp1puDeGavSPi?=
 =?us-ascii?Q?QBs2TSHBDfTcQb+JRVoX0kfYyrnpRV4lcrm2zVJCfx64zmRK0pMF1PNBYSkW?=
 =?us-ascii?Q?DmD7u+zvkJI4FfuXzqgCxdX2LJQB7N4kb1THP9TiVI+WxMOnuvPXo9d9TExW?=
 =?us-ascii?Q?CHF9fr0u/jH0fE0z0MFUOPCc1w/caO6ODz8EkGjLjxMxDUe7glprJEmMADpI?=
 =?us-ascii?Q?w8f7XsVQZ7fSdrbknCb1lejc/1uGc+Jv1ZMX96P0LaXS6o8OmYg5B0oGIms8?=
 =?us-ascii?Q?8Lgv8uVwtRE/dzWpcSw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8da9061-af52-4db3-a33f-08dd0a5da9ae
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 18:52:35.2663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: APSAXxENTHtEjwbNjSyST0vqdhAIrOtQ/3G33xuoxMb3B5awhI5dokoG0AGk6GQO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8834

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
backend split code in __split_unmapped_folio() using
uniform_split variable to distinguish their operations.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 56 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 15 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 65dd2a383e29..3704e14b823a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3731,11 +3731,10 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
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
@@ -3756,9 +3755,10 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
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
@@ -3769,7 +3769,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		 * CONFIG_READ_ONLY_THP_FOR_FS. But in that case, the mapping
 		 * does not actually support large folios properly.
 		 */
-		if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
+		if (new_order && IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
 		    !mapping_large_folio_support(folio->mapping)) {
 			VM_WARN_ONCE(1,
 				"Cannot split file folio to non-0 order");
@@ -3778,7 +3778,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	}
 
 	/* Only swapping a whole PMD-mapped folio is supported */
-	if (folio_test_swapcache(folio) && new_order)
+	if (folio_test_swapcache(folio) && (!uniform_split || new_order))
 		return -EINVAL;
 
 	is_hzp = is_huge_zero_folio(folio);
@@ -3835,10 +3835,13 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
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
@@ -3903,7 +3906,6 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		if (mapping) {
 			int nr = folio_nr_pages(folio);
 
-			xas_split(&xas, folio, folio_order(folio));
 			if (folio_test_pmd_mappable(folio) &&
 			    new_order < HPAGE_PMD_ORDER) {
 				if (folio_test_swapbacked(folio)) {
@@ -3921,8 +3923,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 			mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
 			mod_mthp_stat(new_order, MTHP_STAT_NR_ANON, 1 << (order - new_order));
 		}
-		__split_huge_page(page, list, end, new_order);
-		ret = 0;
+		ret = __split_unmapped_folio(page_folio(page), new_order,
+				page, list, end, &xas, mapping, uniform_split);
 	} else {
 		spin_unlock(&ds_queue->split_queue_lock);
 fail:
@@ -4000,7 +4002,31 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
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


