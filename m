Return-Path: <linux-kernel+bounces-432424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B67F9E4B07
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A59F16201D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1937F539A;
	Thu,  5 Dec 2024 00:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZUrlaFgw"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479A3D26D
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 00:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733357936; cv=fail; b=VQFefU8YrkpWQWkR60zbf41su/5NRcjAHn8gTPcEJo+xfhzkHCJoV5keAOQR4C0vggA2cwYSzN4JFv2oMOfkQtuVIpZaCrYPwDy9+jr8L1QfjPIlIgJe6IHdUt2Pk2fiQaBC+HeB9Tcxe0jCf1D6vLKlaeLmYy+Rb/fDFPBit/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733357936; c=relaxed/simple;
	bh=FaOnpn+JhYHkxtru8rclOsob1LBPDks/N0yQcKKS3jQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GvujDETsqIPpLGVOuv/TPsbfIp5wxfZFzwq1KSufhERdCCnQGjTLh/bhRmVS9v0ER9P+UsW0/Dl96r0NotfKTpT8yK/356jFtP/12BDb8ESBbMY+ZmhIkkClRYLNeQ6s39hYRxmjSM79MPIVi/Yw56+AvLC/0HDTPMqKNHjQsLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZUrlaFgw; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A6jE9GEgRd+teJ/e5Dcuio5DT+TsLXpnJ5UI8Jw3EWgE0HMHz9zlVNjGtsSqNmvO67RkkIlOzl8UQVbZr58WSByEyBtpMnf7bxIlgpNFJJJP9AUtP06p2JHCzFPJUujD7iy7pGnk/IajMf8GBIbjedQoaquPEUT49RUaoO4URNyQeNsU5NPHqFeIvhwwwhviG1NxbRLRp3H1SP97n8MZy9BLivpvucj0NxA91OkF+CHVRBucCJCis74hZuhHXzD1LByA5K4NVIPTeYaNNzaIRT4SOI2Pvd/K5zjj7E1mHFIQOoYOpVXQzIX3VkmCBb251N9JugoSq7mKfd+eqU9p0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aecB1bzSv7lUIxU7S6qbIrcsPh+7bGet1pzIbTFfV5s=;
 b=lEdtsd5i+MatIalLwsN7qLi5PhRnvn3CsmmR34c1RnsSeShv5fDpOROiPDGXTpQ+VKn9yF7YJwDT6gaJxvFs/AhdQ2uQn/Wc7OcBT5j2thNvRlMXv08fX/glQ1ovmtANa4U02B99OzhiYuoK19UyRne4ioxEokOp4U6s2FlcPWSrlP0wAM9wgNlFAkgE5wiEj+PKhoMpdDyVsRGvJbQqgvpzqpR3c7FweLBLLdHJ17zyqmeIdcc8M07EP4b/y/xeXgJsV8G2shkYqCIe+WXf0+u8VIN1jcEgpcTt4coYJigvP/cn9F/RXZ5WoLmAa+ts8e4a29XtC6JpfaasdaDgkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aecB1bzSv7lUIxU7S6qbIrcsPh+7bGet1pzIbTFfV5s=;
 b=ZUrlaFgwaKRBFg48x+1ITBRlj0TUjkgbDOFooR194CoKjTOWpB764aYlJscZ6/NGWnpdWHW94VChbDMKquWfqJlT5rNWW6O1z+XoB2Sgu8kU8dF4Ob8hfeBEp8g7CQwMQKB+psVKGh168R3OI7YN5+3bRZTqRoye8TITqw2nsqKsXCM4SyARRycQKtHCPzLxxo13OiSea3t2xaN3q/YV5ptkny1V7c/TFrjiEdYWJj1XeSkywJ4s5z1PbhmBjr8213YmveKOZ+eFPIDwGLwEsBmpYNaMW9YSWVscZlbZveTK93B3QFIld9APk9XItwjcpyp6za53rtFI70qMid9pWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9)
 by IA1PR12MB7589.namprd12.prod.outlook.com (2603:10b6:208:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 00:18:47 +0000
Received: from BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9]) by BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9%6]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 00:18:47 +0000
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
Subject: [PATCH RESEND v3 3/9] mm/huge_memory: add buddy allocator like folio_split()
Date: Wed,  4 Dec 2024 19:18:33 -0500
Message-ID: <20241205001839.2582020-4-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241205001839.2582020-1-ziy@nvidia.com>
References: <20241205001839.2582020-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0084.namprd04.prod.outlook.com
 (2603:10b6:408:ea::29) To BL4PR12MB9478.namprd12.prod.outlook.com
 (2603:10b6:208:58e::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9478:EE_|IA1PR12MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: e77bfd14-1ad6-4963-57a7-08dd14c262be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z1fvhnqYpg4VtTjRMkmHYsA9KR0tVqTf0HA1/FKxnAzfVZZsp7xQSYLfy84k?=
 =?us-ascii?Q?/wS6CnQeAgpe8GWy7X5ierCuV2hrwvUZYr53MvXBAoqfKHypm1uFzDYvH7ci?=
 =?us-ascii?Q?g8Ue7yqBflM2lF0cnN/OyQgLFa8Xx/KnBBq5Kw2Kxozjy6uzY5f+FHGchoWC?=
 =?us-ascii?Q?xo0Vy/RnF5BrdaqGZK7d4sOY96SU+QAn6m33yUbtzZbfx6UwuY1am6NzSiUQ?=
 =?us-ascii?Q?hoRlTR3zWyPutEo6epqsiGUfE9BJY+hc+LZ45YsODrZfXolSt+VKIvOoEXhp?=
 =?us-ascii?Q?nl8Y3w2vHFevN3dWU+7DBd2Ep//zT/Qz2mrU1F7jLoS7sj3Mz0Fipeuwg3aU?=
 =?us-ascii?Q?YfP6Jo0zZ1C7rkBJlWDxHFa9GoTmbxNfEniEz1yZw9kN9TGvsiCi0lxpDxJR?=
 =?us-ascii?Q?sxUJM64DY/59Uh+4zPirvFz44Ahg4d3OVuBN6mZjJmrpZXyV8Deqz+9Zpsza?=
 =?us-ascii?Q?Xc5l6BzphHBUHgIGtiEWpJLucA8kwTNC4OvGqyk+WHYdfCgjoeJgg2GvNBs0?=
 =?us-ascii?Q?vnP7WAIouu5OTvezWvuenmyAylU3KcR5zosFSR1u6In2FR66kd4LGXMz3stz?=
 =?us-ascii?Q?9drEpaQJQUq9BudvTpJJCWkNaZ6XHm/2fqX3HfcYXTO/9Ablw/bcB0F48Y7C?=
 =?us-ascii?Q?yvDxfD4UqOOQPxe6fnh8o2q0lWXz+s9axieR4D4fcmh5boi1Am3wodZgSXeo?=
 =?us-ascii?Q?6GLyyxga5crfwhyIFtkkCTQ5tNtnOEjg2s67raoQghPxAhyNW7r/2hnQsmOS?=
 =?us-ascii?Q?hEtunoBEQrPukHg9f9U3nAIxKOchPnSeTu8npoVa/uFMyxLtbisP2t3xGeYR?=
 =?us-ascii?Q?XRsnf9ZZbfYFq1U4iUW9KbJJ1y8sH011wVWgSvkKFHEWK8b6VwrP5tzZGrtI?=
 =?us-ascii?Q?GgXTUdnzbs0jQCGD0pPFrQlJvgJnsnJrAKPdTct6BpLJuhez8Cc72UMMg85h?=
 =?us-ascii?Q?se+T1RQsdljnY2AjRLNefTelY/GADOGmC6yf4nLm76lJCclpuXWMVAjUMuyW?=
 =?us-ascii?Q?Wg8EqJMItMpKm/KrNSReOpAdFX9kYIionoAAzT2/HxUSx2jDoCi5yeUkqtyM?=
 =?us-ascii?Q?9Fv3gfUwjlAtP9wtDSvBf1PvsPSRCD5RqimNbPCRQPbR1bm2EHFvAuHxwByA?=
 =?us-ascii?Q?F9HsQ7K4OE0jqS6WD56c9kGWgV+latAiqLQC7UPeDYmp7RkUGO4wnkhWDUFr?=
 =?us-ascii?Q?E8L1xMJqWtZ5tr5E2Wsd/ryVWRmDCPFXfTJCS/bTkdJ72Yjg6mnwsdNMhfcF?=
 =?us-ascii?Q?o+Wt/3SwBNO3YWbzVogok0bufP/XlYEkVA6fCN7bALg6H6HHe+8XkgH8gvd1?=
 =?us-ascii?Q?eujibk2s8eOcIKI7F208PR3GIjEugcBEnllNVZT2aKUK3g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9478.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hNDNGPSm8DlF8Li1QB4WiuJ5v0uu++9w0jo+TPELyeHwumBs8WfdkfFSiin9?=
 =?us-ascii?Q?/er4bzpKXVdA67VJsil6QBZo/ox7jiwLScfpM6gA6k8j9uqW78T6Vpj+iuAL?=
 =?us-ascii?Q?vH+WR/9ypj26UhuNMDbVW75RVHCu02u77Am9JzKNfKbkk0IWqvYp4Xz+dMuH?=
 =?us-ascii?Q?yv65UW195vxsfoedN5OZ7bvbL33Up91vmscP9MJSzrKDzmjGZ3ImgdDYUh9Q?=
 =?us-ascii?Q?rZWDOFzK4+6OE0sBTPxNKRTk+L7a1k1bJw93DsrQ7A2IEc/GTjyeacZzrhJb?=
 =?us-ascii?Q?1DyFWbYBocqDFCT1r7+wtRsGgvbmnH6PgIJxl5fADQd4hmwkYsexunIt0aWj?=
 =?us-ascii?Q?8MRReakepBw3ClsRD/PzmmCCqih7elhZkiV6NKBJeLMkfZ+AHywcZ98Lppjg?=
 =?us-ascii?Q?WCFGkQc4cWI4BZpFYFPG1vHTxS0BJqF7Jgol9tgdpw8i/HC6vTigtPHca00x?=
 =?us-ascii?Q?A6DE8ybdYBRh42DAVgFHbIZHLH5sQ2BMnAyeiCFjkOYZ0IcDJwlZgLVux46y?=
 =?us-ascii?Q?m/g92YCekyUntDida2Tm2wlSES7U6Te0hdboTbk6s/Dix5yg4jbH8qVtoQDv?=
 =?us-ascii?Q?90kJVJNSXIZqLHu2ojNtfzZLj+aTOEko/zH0UPPC0KzpObzirdJKXElyB/Nb?=
 =?us-ascii?Q?Mm0y3RT6C9ynlO28aDj/KzCbbx/7CoKioQn03wkOXVPKDZKcjvJK1IBdg8b8?=
 =?us-ascii?Q?pUuz4+CkGAxMT7CiJWbnEivG3wLh5VZOnGDbWZ9ycUq95pWoEotlti+mU3H0?=
 =?us-ascii?Q?/aQCuNbDdvj/984Khk2o9lNaz1iMQnXyS59ZEzyVUmomf/8GhFx46Cj0ut6L?=
 =?us-ascii?Q?k/HleC9RE5tWMk76mD8+Ov3oR7+LM/fNUjyzkXVnYWDzyr5XltdBs48z28DH?=
 =?us-ascii?Q?xlPycOUOyYxcfTpF+nF2BqKW4lhKz9QmDlgjE5itZ5UrgpJKxWvilIj1xN1V?=
 =?us-ascii?Q?HzDvHvw6RDQE0FEdvylkrmb1CR9mwz3/Ukhy3hqo7Dxjf8ssyIieqFUALSW5?=
 =?us-ascii?Q?yWCKQYAgrJe0DlahqjYwVxBgdndMxKv+Mgbo2kvSquR99WMfUlm+RxxFfXJL?=
 =?us-ascii?Q?n3M2qgmQFvhLF8zy2DP6XTEX5Xxq2C16IsqCzS7vBX+cvocR4NvJkWbDFf19?=
 =?us-ascii?Q?4KaBQWAwoIjrOL3yyKjGqvW6Bo4/V3E7MG/q/Q78fNyzk7FYAs1/FoclLpzi?=
 =?us-ascii?Q?Mt52hLwWzKR8j8qD/y54jDQy6LXLCIKsENF5sf+Jd0KrB+/hlcr9g8h3L0MS?=
 =?us-ascii?Q?zGJ2bhCOnezqQzF6koKxUv2l0NN4T8LQhlGy4EyDD+IzNEG5+J860XrHG2uq?=
 =?us-ascii?Q?9hw4a6aLspGU99lwIiL7Nok87WaTolW1W7PxhZFr+ctikic4Dm8lTxMGo2xI?=
 =?us-ascii?Q?CvqlN2vU+p1PpxfxftrzKmEhG7VgutGMeuhAAErFauRRVSygEZgld1SsdI57?=
 =?us-ascii?Q?soM+C6LFohIZc7m22iiSDwug6xxXqEYjhu+E1WR+K1TO0tM1BucIL2d9uZyv?=
 =?us-ascii?Q?xVWQtX9moZXTw8AJiX22afGvRPyryjb8UYKoKyqmqhM1dvzFttWiXk0qGLcX?=
 =?us-ascii?Q?f2QyoP80jM5GBfq4zCf/NGZkZbiC6zBc7vC+tI36?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e77bfd14-1ad6-4963-57a7-08dd14c262be
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 00:18:47.0320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHrPxPob2I8r/EODqtdVkCgs1zISpQHa+QwglnI0OSdQH1VdK2eRH6lFovU9tV7s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7589

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
index e928082be3b2..4f4f3b50c537 100644
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


