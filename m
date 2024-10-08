Return-Path: <linux-kernel+bounces-355988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D06C6995A4E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 00:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23A631F2290C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 22:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92C22194B0;
	Tue,  8 Oct 2024 22:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jv+9dY5W"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F9B218D8D
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 22:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728427083; cv=fail; b=Kn1UYC9wKbjUCKFuRoEkb3vIxzD386MKGH/Zuq1ps81ixBAEHOCt7qY7b05c45cfNY2Ht94GlHWHXvNfAZkVwQtOKEgDNhlsCQSr8ztVhpyZM9bZix8ArCvB+yzdddP/9kDZP0YPpZ6pDrg3usmH57UglePjCLnZfUV6K91KCwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728427083; c=relaxed/simple;
	bh=J8bMaijFMJ6xi64zNBeQtmCVSHCS2BorbQcwoo2cQjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g4WIH6L/VsUcLFPCynEes5WJg2Wa/27WLRbNRCA2LmzMNalT5Y95J8Lr6EEQiwnNR6aaehKVUmMdeF1enQAd0vdrX1RdynV1x2J5VTCdJ2t+uJjioUQTdmpPeCEWEeN8T4n8e6OacCpYXRmtPwwcD/Ms0uiS/W4b7xTxL6J9vLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jv+9dY5W; arc=fail smtp.client-ip=40.107.236.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wcQYe6N5HBjIXwdL092CGnB0mIPIUYpiDg40E6Cj/gPlYiD3UrGZ4z3eDU598dio/K1tHQWa8FyTDxRiHTaZIHadL0HraqyYvNnNL6jdY9TLyEGXelI28h9Tbp0PPoT39eCnSnNP0cKL+/Tg7TeyycTcWzcynYwS5dGUR2jLL/tA/d2nvR/fQFfXsIiZ4hIOhAIoBG1lJKa3W5nAXUdvN5sA2b0nrWBfCeq2zTeLr8Qn9EyVXvvIdwAQszSlS4hB4pkPzDb4sOcqVqSD5GRddprBC6AVyfKkrUClqmUGRWi0RjPYD33LG/0P6pAllG/DwpczL27dpMg2ZCTIwt/URA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnlRgieAPTFu/UbLIX/ubFaHgcjnYAX+IZHLfkWY1IU=;
 b=h8gLutZz4KO3OOCMm/WuJm/di+ZYTGVS3do6+W+VkCAmXA3OdrKKprmvSc1QG6/lByaMoQClEWOjfOxrNTGDRL0njNPWBdVKxNZasu1egF7he/1/CJX+MGBJmXyToAamyGmbWSKYrraJUgH+TJ33Ot0s4RMQOkIcmke0pWrp4veUdpIs4SgeaxN6Rl9bpY0iMNgbcfzei6MNMgjoBi6s3HzxXJQehz05KA+nBexq4bdToi5BCwcMpiIkVI4kfLfJVzJ26tM4i4R0w8A+EQeSwfLxAZBsSw6JQbJf6WUVwHoAvchUUZQ8D5nYk2oecheZ+NmvFvaMF1kESGna5z2syg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnlRgieAPTFu/UbLIX/ubFaHgcjnYAX+IZHLfkWY1IU=;
 b=Jv+9dY5WTMWvlUBeGrMfPpyc9feNnTDCFgGcoOh+qPP7odwEFF6Bjc3b1IxNP5E3Ldg1sJ/AQCa0EDK9Z4p+rXNa7vflruuLhhNWECJxuoezLIszdClYJu9NeBm+0HlCtJk7HvkNihaMJ5xOeik3vh8kfskF78ApoTesv0F3FDccguJfxH0e2Go8XxK/sWeutq+30fvBpzt0dBS1+SpP7sYtPA0yn7/TkkCtLvTvR8+aEm60bmBj63Z6xcLaFpPraJs9gQMxsOuIOSPpX+fm6IeTVqBS+Nv2GRUyKOygOHSDsSsp1iQtF66Qp3HRJ1KC5iorUslc4kfqs+E+EuWKiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY5PR12MB6322.namprd12.prod.outlook.com (2603:10b6:930:21::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.23; Tue, 8 Oct 2024 22:37:53 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8048.007; Tue, 8 Oct 2024
 22:37:53 +0000
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
Subject: [RFC PATCH 1/1] mm/huge_memory: buddy allocator like folio_split()
Date: Tue,  8 Oct 2024 18:37:48 -0400
Message-ID: <20241008223748.555845-2-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241008223748.555845-1-ziy@nvidia.com>
References: <20241008223748.555845-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR11CA0001.namprd11.prod.outlook.com
 (2603:10b6:208:23b::6) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY5PR12MB6322:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c99b065-cfa8-4224-c493-08dce7e9d8c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eeOdeiUTbwUKXeX9wTm2srObZ8ZxZVc4uoWGvDB/vf1VSjvNcDMfas75WEub?=
 =?us-ascii?Q?b0h4M2wtO85afhuB8JwmShHMCZTBHIbvm1bJSne4p8qYh8tSVSfP/TjUiCdY?=
 =?us-ascii?Q?CXycDr8oWNQZYuZrsqQRjtmles8NKdhf/ObNVnvs4PAdupVIj4B64PBVs8Te?=
 =?us-ascii?Q?bpEoXlmLj74xMqpIw+lg1LFvdxNmmGnaudCr5pQlDyFa5TV3ZDdFvpgZToVj?=
 =?us-ascii?Q?2K/LRz9r23E3xJo65dMI2s3wbXs2BqGHzLwBYuvo9mCXngbra2YocNt06E1v?=
 =?us-ascii?Q?nUAptFwKrsgkiXZPmok5Ths08s4FQbirSM1h5Tk2WyHBLZQEBk3Ko/LULgg1?=
 =?us-ascii?Q?VruMb57Z9fdscKyb+uavB4qUx/rcU7KhLBEQhnH6V014069l8ATq8eaxPZFt?=
 =?us-ascii?Q?mNYHHMDyWrwTe8SoMRg3r2y5kfIWIG25Q5QmGsNo9UULMmvZuMuwSln0v0vY?=
 =?us-ascii?Q?Jl35UKkYmXjyqI8pDF4VNxyzpGszYEzxF3rDIkkOvSAV8nnxcSUf/m681K15?=
 =?us-ascii?Q?4NAzoJn/VWxBrsFGBMsSIlfDiIHolK4mfUxNNX6GI439G7GLb/e92RBHPm36?=
 =?us-ascii?Q?sfsCvdw528NcMFPOXtcS6YbDLur7AXffaFMPIzy57e2a3u1kR8xRgt6fmOKh?=
 =?us-ascii?Q?IhUIef8vRcaWOgCbkEWnNIeuOA+t1fo7D3WBw8oBYmKctYC7XWQ5KwvTDAja?=
 =?us-ascii?Q?6k9/JIb0QSs+w/Dln/2hN/aSVehcmwcXN9C5lukMlUdAcFAFrV3UP9xbCUOl?=
 =?us-ascii?Q?83qLYAcLQYLjnNLvxxDvHKsNZoMmi17iH7Ord9XoIMOlWEnX+Kqk0gKAVGyp?=
 =?us-ascii?Q?bM4Ibci9sWaaWnXRVCqunuwAVDTfxmaImw2h/AeOvtRwH7ACgZWIH/+85MWP?=
 =?us-ascii?Q?d+igtmR73nL3r5Vo4VeQyFTBO+9uDIK3lrPPSkaS6BCmIBH4niuk9XUOFyQ5?=
 =?us-ascii?Q?XjEXOHGNMDCTQw1QaGJcAc21XuCJDhLzTmHOAwOysdjx5qQauajH2Yl+mGKv?=
 =?us-ascii?Q?QMDBtx35G66hO5+hckjS2hibINPijinL915E4bBXjdbPbabtyVwHdBjQ+tX/?=
 =?us-ascii?Q?kdUs2eMb4low0FxJwJ/kfAN9Qnsg9PDZSwnmYJ0wUGZC6UX38NQZH5UuNe9i?=
 =?us-ascii?Q?zTWFesDPZ9dUlRTJH0Qj36JMe52VP2+6ulHtNjIW2wJGNsTemxUDaZoxdbOn?=
 =?us-ascii?Q?u5Z8ThwL/FdO2kMnVPWBY1X4UKcKgRiLsP25oCTC8vGe5A3nKaZPA/r/tBNJ?=
 =?us-ascii?Q?wuTp6KIJ+2j1OMsFcbfX4mUDnCnNEMBLQWjC0SRoLA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7F3ELcD3wte38Hwn26cPfPi1EKjYTJq8Ru9kxARj2VYa24YBYevgD+tK1lot?=
 =?us-ascii?Q?tKynTvh0wyHkAUQ8qQ4OEeb+dvKj35QMZ2e4VsVGD/RyimY2pQHNDbzwoDIf?=
 =?us-ascii?Q?BMhpG0L5Ik5ZTvnyqCd3tWbrItdBaK1qrF0pSDZQxinqEcqLCZ9w184Z7cBo?=
 =?us-ascii?Q?g/NIgoBI0lozTN28AnLPLkyBM+0/nXbbYAN0yTsha0BIJDS9Kuvhbgbfgb6P?=
 =?us-ascii?Q?YKCeJOc+X3fNX5SCFyMBskACmpX/gG5kbR6hlQN3fNjoCCGDQYNyzg50Kk4I?=
 =?us-ascii?Q?ErYrFTRrQvDqy5HE0e7VIuR29+RY5e13QBzODGxaexHfnoDsmgQBwPeFC32u?=
 =?us-ascii?Q?gtknS3xO23nLMDrKWJXDsqTymO3oyRTJ6QKtjIRwxW7XsBKBjzLV94h2zN5V?=
 =?us-ascii?Q?1XeZhwRXJ33LXnKbkPNopFols8vPR2RkMYRu5picGAgmJUv+H8xQVQWhnelK?=
 =?us-ascii?Q?nITPUHyeqLG3NmzQ0/Ak/kcJOKvwwp4a3qrtFeW9CwoCaTXDeC4EE/DH+GWZ?=
 =?us-ascii?Q?XmreEJCXcxMx7VZ1sLGYc2U9H55S9Epq+zoe4SD5dPm91LdP+SnUzO+RPZ92?=
 =?us-ascii?Q?N5+KCfW7VitrHW2T/GIqxpUv0jUE1RJ1RbTtRqnA9rQMNaEN4QjOxJUMHcMs?=
 =?us-ascii?Q?ZgzUk95ZnbgD24jRlBgzAJ9gSyEsVrpxefJxsLBBepg98hLgs6vWOEm4t92q?=
 =?us-ascii?Q?NIxyFKATEXV9fdKqWdVy3bS5KS4u2/Ei9Emp1U87icGonERN8Dl8ufux8z/C?=
 =?us-ascii?Q?GmFHHpOguRfTgdmHVrGqGnTSbcUbAT0+wKq0MfkFGBu7UIuyDakTrVyAhcNp?=
 =?us-ascii?Q?NToID7OWUvRU/prFn/QibanCI/7EXCFhgrEjCtjuWNTqFsQ8tnYS1KTrtSRL?=
 =?us-ascii?Q?rp8xYsbfUOJaA3HDUN9Ovlrk+OJAZEUpNYOfIbC8Hd1HFsJlEjwXAcu1OVbE?=
 =?us-ascii?Q?MuxEym26CiPq/mBZzOTNF/vsMv3y1onMrIkbI/kcPohHCj1qCzYXaRyjtRUK?=
 =?us-ascii?Q?gKjouUIfN+Qg7JZFKpA+XgV1MDH6n9SiVwV6mKUvfL34yLxHU6eYLZvgfJYD?=
 =?us-ascii?Q?MysEuAtTgZowbvbiwy85xezMmWRFrf2zGFXopcTi2UO8uP148xEwepb9666j?=
 =?us-ascii?Q?jHTxZHDIvUSq47ilM/LNIjtaK5fxkAIpneuAxDFk7R0aaRn6eqOjBGNfnYUt?=
 =?us-ascii?Q?CeG5HZ+CFnufVpZ2Mf+GjuMVpnVcW3FfYd4+EcRYcuFNQaGsG//XqfCPAEIP?=
 =?us-ascii?Q?FBnJHKrzl5GyV/eMAsYN46dejqPQhdSSyGNa0/8RJsQ2q8WRocisJrMIiJYf?=
 =?us-ascii?Q?Se+tQ428pT2uHTJOPCvWuO63+zzdwDBm11M+qQ5rZ39/MN+izrJMTGmpING2?=
 =?us-ascii?Q?UtpEC2p16dPtCfra/VQHhRuYyJS9bdmSCMOl8Qvow1eJjrKhvm7NOplY4jSI?=
 =?us-ascii?Q?YNMVRCGzFbW2KtootD6HO78o5MVqUE9K30c0XGEEm27XM4ICyRwFEyJF9tjT?=
 =?us-ascii?Q?lzuO80qGqHis9k0KQHQNKxN6sqte6IGGKpwIsIOjz7OxRYTPSTQS1xpbWr5Z?=
 =?us-ascii?Q?VFXKMYOzhryPC0VKpbw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c99b065-cfa8-4224-c493-08dce7e9d8c5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 22:37:53.2398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jvf5Ew6o5tQBaRL/heOdSx15WRP0PgUPM47AnPu81Rreh2wpkbNCTyB4rWJ1/8Dq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6322

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

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 648 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 647 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a7b05f4c2a5e..bde8aeeaae52 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3067,7 +3067,6 @@ static void remap_page(struct folio *folio, unsigned long nr, int flags)
 static void lru_add_page_tail(struct folio *folio, struct page *tail,
 		struct lruvec *lruvec, struct list_head *list)
 {
-	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
 	VM_BUG_ON_FOLIO(PageLRU(tail), folio);
 	lockdep_assert_held(&lruvec->lru_lock);
 
@@ -3601,6 +3600,484 @@ int split_folio_to_list(struct folio *folio, struct list_head *list)
 	return split_huge_page_to_list_to_order(&folio->page, list, ret);
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
+static int __split_folio_to_order(struct folio *folio, int new_order)
+{
+	int curr_order = folio_order(folio);
+	long nr_pages = folio_nr_pages(folio);
+	long new_nr_pages = 1 << new_order;
+	long new_index;
+
+	if (curr_order <= new_order)
+		return -EINVAL;
+
+	for (new_index = new_nr_pages; new_index < nr_pages; new_index += new_nr_pages) {
+		struct page *head = &folio->page;
+		struct page *second_head = head + new_index;
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
+		VM_BUG_ON_PAGE(new_nr_pages > 2 && second_head->mapping != TAIL_MAPPING,
+			       second_head);
+		second_head->mapping = head->mapping;
+		second_head->index = head->index + new_index;
+
+		/*
+		 * page->private should not be set in tail pages. Fix up and warn once
+		 * if private is unexpectedly set.
+		 */
+		if (unlikely(second_head->private)) {
+			VM_WARN_ON_ONCE_PAGE(true, second_head);
+			second_head->private = 0;
+		}
+		if (folio_test_swapcache(folio))
+			new_folio->swap.val = folio->swap.val + new_index;
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
+		clear_compound_head(second_head);
+		if (new_order) {
+			prep_compound_page(second_head, new_order);
+			folio_set_large_rmappable(new_folio);
+
+			folio_set_order(folio, new_order);
+		} else {
+			if (PageHead(head))
+				ClearPageCompound(head);
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
+	return 0;
+}
+
+#define for_each_folio_until_end_safe(iter, iter2, start, end)	\
+	for (iter = start, iter2 = folio_next(start);		\
+	     iter != end;					\
+	     iter = iter2, iter2 = folio_next(iter2))
+
+static int __folio_split_without_mapping(struct folio *folio, int new_order,
+		struct page *page, struct list_head *list, pgoff_t end,
+		struct xa_state *xas, struct address_space *mapping)
+{
+	struct lruvec *lruvec;
+	struct address_space *swap_cache = NULL;
+	struct folio *origin_folio = folio;
+	struct folio *next_folio = folio_next(folio);
+	struct folio *new_folio;
+	struct folio *next;
+	int order = folio_order(folio);
+	int split_order = order - 1;
+	int nr_dropped = 0;
+
+	if (folio_test_anon(folio) && folio_test_swapcache(folio))
+		return -EINVAL;
+
+	if (folio_test_anon(folio))
+		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
+	/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
+	lruvec = folio_lruvec_lock(folio);
+
+	/* work on the other folio contains page */
+	for (split_order = order - 1; split_order >= new_order; split_order--) {
+		int old_order = folio_order(folio);
+		struct folio *release;
+		struct folio *end_folio = folio_next(folio);
+		int status;
+
+		if (folio_test_anon(folio) && split_order == 1)
+			continue;
+
+		if (mapping) {
+			xas_set_order(xas, folio->index, split_order);
+			xas_split_alloc(xas, folio, old_order, 0);
+			if (xas_error(xas)) {
+				unlock_page_lruvec(lruvec);
+				local_irq_enable();
+				return -ENOMEM;
+			}
+			xas_split(xas, folio, old_order);
+		}
+
+		/* complete memcg works before add pages to LRU */
+		split_page_memcg(&folio->page, old_order, split_order);
+		split_page_owner(&folio->page, old_order, split_order);
+		pgalloc_tag_split(folio, old_order, split_order);
+
+		status = __split_folio_to_order(folio, split_order);
+
+		if (status < 0)
+			return status;
+
+		/*
+		 * Add folios without page to list, since they are no longer
+		 * going to be split, but if its index > end, drop it.
+		 */
+		/* Unfreeze refcount first. Additional reference from page cache. */
+		for_each_folio_until_end_safe(release, next, folio, end_folio) {
+			if (page_in_folio_offset(page, release) >= 0) {
+				folio = release;
+				continue;
+			}
+			if (folio_test_anon(release))
+				mod_mthp_stat(folio_order(release),
+						MTHP_STAT_NR_ANON, 1);
+
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
+				return -EINVAL;
+			}
+		}
+	}
+
+	/* Some pages can be beyond EOF: drop them from page cache */
+	if (folio->index >= end) {
+		if (shmem_mapping(folio->mapping))
+			nr_dropped++;
+		else if (folio_test_clear_dirty(folio))
+			folio_account_cleaned(folio,
+				inode_to_wb(folio->mapping->host));
+		__filemap_remove_folio(folio, NULL);
+		folio_put(folio);
+	} else if (!folio_test_anon(folio)) {
+		__xa_store(&folio->mapping->i_pages, folio->index,
+				&folio->page, 0);
+	} else if (swap_cache) {
+		return -EINVAL;
+	}
+	if (folio_test_anon(folio))
+		mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
+
+	if (folio != origin_folio)
+		lru_add_page_tail(origin_folio, &folio->page, lruvec, list);
+
+	unlock_page_lruvec(lruvec);
+	/* Caller disabled irqs, so they are still disabled here */
+
+	if (folio_test_anon(folio)) {
+		/* Additional pin to swap cache */
+		if (folio_test_swapcache(folio))
+			return -EINVAL;
+		folio_ref_inc(folio);
+	} else {
+		/* Additional pin to page cache */
+		folio_ref_add(folio, 1 + (1 << new_order));
+		xa_unlock(&folio->mapping->i_pages);
+	}
+
+	local_irq_enable();
+
+	remap_page(origin_folio, 1 << order, 0);
+
+	for_each_folio_until_end_safe(new_folio, next, origin_folio, next_folio) {
+		if (new_folio == folio)
+			continue;
+
+		folio_unlock(new_folio);
+		free_page_and_swap_cache(&new_folio->page);
+	}
+	return 0;
+}
+
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
+ */
+static int folio_split(struct folio *folio, unsigned int new_order, struct page *page)
+{
+	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
+	bool is_anon = folio_test_anon(folio);
+	struct address_space *mapping = NULL;
+	struct anon_vma *anon_vma = NULL;
+	int extra_pins, ret;
+	pgoff_t end;
+	bool is_hzp;
+	unsigned int order = folio_order(folio);
+	long page_offset = page_in_folio_offset(page, folio);
+	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
+
+	if (!folio_test_locked(folio))
+		return -EINVAL;
+	if (!folio_test_large(folio))
+		return -EINVAL;
+
+	if (is_anon) {
+		/* order-1 is not supported for anonymous THP. */
+		if (new_order == 1) {
+			VM_WARN_ONCE(1, "Cannot split to order-1 folio");
+			return -EINVAL;
+		}
+	} else if (new_order) {
+		/* Split shmem folio to non-zero order not supported */
+		if (shmem_mapping(folio->mapping)) {
+			VM_WARN_ONCE(1,
+				"Cannot split shmem folio to non-0 order");
+			return -EINVAL;
+		}
+		/*
+		 * No split if the file system does not support large folio.
+		 * Note that we might still have THPs in such mappings due to
+		 * CONFIG_READ_ONLY_THP_FOR_FS. But in that case, the mapping
+		 * does not actually support large folios properly.
+		 */
+		if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
+		    !mapping_large_folio_support(folio->mapping)) {
+			VM_WARN_ONCE(1,
+				"Cannot split file folio to non-0 order");
+			return -EINVAL;
+		}
+	}
+
+	/* Only swapping a whole PMD-mapped folio is supported */
+	if (folio_test_swapcache(folio) && new_order)
+		return -EINVAL;
+
+	is_hzp = is_huge_zero_folio(folio);
+	if (is_hzp) {
+		pr_warn_ratelimited("Called %s for huge zero page\n", __func__);
+		return -EBUSY;
+	}
+
+	if (folio_test_writeback(folio))
+		return -EBUSY;
+
+	if (page_offset < 0)
+		return -EINVAL;
+
+	if (new_order >= order)
+		return -EINVAL;
+
+	/* adjust page pointer to the first page of the new folio */
+	page = folio_page(folio, ALIGN_DOWN(page_offset, (1L<<new_order)));
+
+	if (is_anon) {
+		/*
+		 * The caller does not necessarily hold an mmap_lock that would
+		 * prevent the anon_vma disappearing so we first we take a
+		 * reference to it and then lock the anon_vma for write. This
+		 * is similar to folio_lock_anon_vma_read except the write lock
+		 * is taken to serialise against parallel split or collapse
+		 * operations.
+		 */
+		anon_vma = folio_get_anon_vma(folio);
+		if (!anon_vma) {
+			ret = -EBUSY;
+			goto out;
+		}
+		end = -1;
+		mapping = NULL;
+		anon_vma_lock_write(anon_vma);
+	} else {
+		unsigned int min_order;
+		gfp_t gfp;
+
+		mapping = folio->mapping;
+
+		/* Truncated ? */
+		if (!mapping) {
+			ret = -EBUSY;
+			goto out;
+		}
+
+		min_order = mapping_min_folio_order(folio->mapping);
+		if (new_order < min_order) {
+			VM_WARN_ONCE(1, "Cannot split mapped folio below min-order: %u",
+				     min_order);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		gfp = current_gfp_context(mapping_gfp_mask(mapping) &
+							GFP_RECLAIM_MASK);
+
+		if (!filemap_release_folio(folio, gfp)) {
+			ret = -EBUSY;
+			goto out;
+		}
+
+		anon_vma = NULL;
+		i_mmap_lock_read(mapping);
+
+		/*
+		 *__split_huge_page() may need to trim off pages beyond EOF:
+		 * but on 32-bit, i_size_read() takes an irq-unsafe seqlock,
+		 * which cannot be nested inside the page tree lock. So note
+		 * end now: i_size itself may be changed at any moment, but
+		 * folio lock is good enough to serialize the trimming.
+		 */
+		end = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE);
+		if (shmem_mapping(mapping))
+			end = shmem_fallocend(mapping->host, end);
+	}
+
+	/*
+	 * Racy check if we can split the page, before unmap_folio() will
+	 * split PMDs
+	 */
+	if (!can_split_folio(folio, 1, &extra_pins)) {
+		ret = -EAGAIN;
+		goto out_unlock;
+	}
+
+	unmap_folio(folio);
+
+	/* block interrupt reentry in xa_lock and spinlock */
+	local_irq_disable();
+	if (mapping) {
+		/*
+		 * Check if the folio is present in page cache.
+		 * We assume all tail are present too, if folio is there.
+		 */
+		xas_lock(&xas);
+		xas_reset(&xas);
+		if (xas_load(&xas) != folio)
+			goto fail;
+	}
+
+	/* Prevent deferred_split_scan() touching ->_refcount */
+	spin_lock(&ds_queue->split_queue_lock);
+	if (folio_ref_freeze(folio, 1 + extra_pins)) {
+		if (folio_order(folio) > 1 &&
+		    !list_empty(&folio->_deferred_list)) {
+			ds_queue->split_queue_len--;
+			if (folio_test_partially_mapped(folio)) {
+				__folio_clear_partially_mapped(folio);
+				mod_mthp_stat(folio_order(folio),
+					      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED,
+					      -1);
+			}
+			/*
+			 * Reinitialize page_deferred_list after removing the
+			 * page from the split_queue, otherwise a subsequent
+			 * split will see list corruption when checking the
+			 * page_deferred_list.
+			 */
+			list_del_init(&folio->_deferred_list);
+		}
+		spin_unlock(&ds_queue->split_queue_lock);
+
+		__folio_split_without_mapping(folio, new_order, page, NULL,
+				end, &xas, mapping);
+
+		ret = 0;
+	} else {
+		spin_unlock(&ds_queue->split_queue_lock);
+fail:
+		if (mapping)
+			xas_unlock(&xas);
+		local_irq_enable();
+		remap_page(folio, folio_nr_pages(folio), 0);
+		ret = -EAGAIN;
+	}
+
+out_unlock:
+	if (anon_vma) {
+		anon_vma_unlock_write(anon_vma);
+		put_anon_vma(anon_vma);
+	}
+	if (mapping)
+		i_mmap_unlock_read(mapping);
+out:
+	xas_destroy(&xas);
+	return ret;
+}
+
 void __folio_undo_large_rmappable(struct folio *folio)
 {
 	struct deferred_split *ds_queue;
@@ -4119,10 +4596,179 @@ static const struct file_operations split_huge_pages_fops = {
 	.write	 = split_huge_pages_write,
 };
 
+static int folio_split_pid(int pid, unsigned long vaddr_start,
+			unsigned long vaddr_end, unsigned long split_offset,
+			unsigned int new_order)
+{
+	int ret = 0;
+	struct task_struct *task;
+	struct mm_struct *mm;
+	unsigned long total = 0, split = 0;
+	unsigned long addr;
+
+	vaddr_start &= PAGE_MASK;
+	vaddr_end &= PAGE_MASK;
+
+	task = find_get_task_by_vpid(pid);
+	if (!task) {
+		ret = -ESRCH;
+		goto out;
+	}
+
+	/* Find the mm_struct */
+	mm = get_task_mm(task);
+	put_task_struct(task);
+
+	if (!mm) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	pr_debug("Split huge pages in pid: %d, vaddr: [0x%lx - 0x%lx], to new order: %d, at %lu th page\n",
+		 pid, vaddr_start, vaddr_end, new_order, split_offset);
+
+	mmap_read_lock(mm);
+	/*
+	 * always increase addr by PAGE_SIZE, since we could have a PTE page
+	 * table filled with PTE-mapped THPs, each of which is distinct.
+	 */
+	for (addr = vaddr_start; addr < vaddr_end; addr += PAGE_SIZE) {
+		struct vm_area_struct *vma = vma_lookup(mm, addr);
+		struct folio_walk fw;
+		struct folio *folio;
+		struct page *split_point;
+		struct address_space *mapping;
+		unsigned int target_order = new_order;
+		unsigned int origin_order;
+
+		if (!vma)
+			break;
+
+		/* skip special VMA and hugetlb VMA */
+		if (vma_not_suitable_for_thp_split(vma)) {
+			addr = vma->vm_end;
+			continue;
+		}
+
+		folio = folio_walk_start(&fw, vma, addr, 0);
+		if (!folio)
+			continue;
+
+		if (!is_transparent_hugepage(folio))
+			goto next;
+
+		origin_order = folio_order(folio);
+
+		if (!folio_test_anon(folio)) {
+			mapping = folio->mapping;
+			target_order = max(new_order,
+					   mapping_min_folio_order(mapping));
+		}
+
+		if (target_order >= origin_order)
+			goto next;
+
+		if (split_offset >= folio_nr_pages(folio))
+			goto next;
+
+		total++;
+		/*
+		 * For folios with private, split_huge_page_to_list_to_order()
+		 * will try to drop it before split and then check if the folio
+		 * can be split or not. So skip the check here.
+		 */
+		if (!folio_test_private(folio) &&
+		    !can_split_folio(folio, 0, NULL))
+			goto next;
+
+		if (!folio_trylock(folio))
+			goto next;
+		folio_get(folio);
+		folio_walk_end(&fw, vma);
+
+		if (!folio_test_anon(folio) && folio->mapping != mapping)
+			goto unlock;
+
+		split_point = folio_page(folio, split_offset);
+		if (!folio_split(folio, new_order, split_point)) {
+			split++;
+			folio = page_folio(split_point);
+			addr += (1 << origin_order) * PAGE_SIZE - PAGE_SIZE;
+		}
+
+unlock:
+
+		folio_unlock(folio);
+		folio_put(folio);
+
+		cond_resched();
+		continue;
+next:
+		folio_walk_end(&fw, vma);
+		cond_resched();
+	}
+	mmap_read_unlock(mm);
+	mmput(mm);
+
+	pr_debug("%lu of %lu THP split\n", split, total);
+
+out:
+	return ret;
+}
+
+static ssize_t folio_split_write(struct file *file, const char __user *buf,
+				size_t count, loff_t *ppops)
+{
+	static DEFINE_MUTEX(split_debug_mutex);
+	ssize_t ret;
+	/*
+	 * hold pid, start_vaddr, end_vaddr, new_order or
+	 * file_path, off_start, off_end, new_order
+	 */
+	char input_buf[MAX_INPUT_BUF_SZ];
+	int pid;
+	unsigned long vaddr_start, vaddr_end, split_offset;
+	unsigned int new_order = 0;
+
+	ret = mutex_lock_interruptible(&split_debug_mutex);
+	if (ret)
+		return ret;
+
+	ret = -EFAULT;
+
+	memset(input_buf, 0, MAX_INPUT_BUF_SZ);
+	if (copy_from_user(input_buf, buf, min_t(size_t, count, MAX_INPUT_BUF_SZ)))
+		goto out;
+
+	input_buf[MAX_INPUT_BUF_SZ - 1] = '\0';
+
+	ret = sscanf(input_buf, "%d,0x%lx,0x%lx,%lu,%d", &pid, &vaddr_start,
+			&vaddr_end, &split_offset, &new_order);
+	if (ret != 4 && ret != 5) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = folio_split_pid(pid, vaddr_start, vaddr_end, split_offset, new_order);
+	if (!ret)
+		ret = strlen(input_buf);
+out:
+	mutex_unlock(&split_debug_mutex);
+	return ret;
+
+}
+
+static const struct file_operations folio_split_fops = {
+	.owner	 = THIS_MODULE,
+	.write	 = folio_split_write,
+};
+
 static int __init split_huge_pages_debugfs(void)
 {
 	debugfs_create_file("split_huge_pages", 0200, NULL, NULL,
 			    &split_huge_pages_fops);
+	debugfs_create_file("folio_split", 0200, NULL, NULL,
+			    &folio_split_fops);
 	return 0;
 }
 late_initcall(split_huge_pages_debugfs);
-- 
2.45.2


