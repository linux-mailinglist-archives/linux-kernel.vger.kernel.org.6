Return-Path: <linux-kernel+bounces-392423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA739B93EF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 16:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17E67B219C9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 15:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA22B1AAE10;
	Fri,  1 Nov 2024 15:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ljC0i1Hy"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8105F1A4E9E
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 15:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730473462; cv=fail; b=W/LzFkwWWSdDzAOi7AP1nGDiS4/4q8Kh4mSJhU5Q6LUTb7w9OeKHz6dZTMoUAa8XqzD1aX4ZfwtMZ1U2SrMw7ScGt78NR8ZMNRmr+4Eiy4UXMed1Dz6Y7BiFmdtebt7BhTqaVQmnJmdSudGIgtLQnNs0/yzo+AbjQmL3VPRwhcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730473462; c=relaxed/simple;
	bh=LKCSIu5pehvAt8c894JqZpQNSfF6MISdOps70TIpgms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ma2s/qFI6SHkd6RoLOw+8XTMkT/fkh9s5HLBV+jSylwgTPIslFvULuvjxIhlS7uiF8TJKMS/TuKZOXSeCiTzi4bK3BwOzzsaTV89whupMdf95LBxeJ6vkY5NkjDO6mlZ9WpaJT0WlwkZHXbLxuyZkByM/i3bg/AAowQBiHW3U2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ljC0i1Hy; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k62DSH0vuRFqfyFHGdTrWLaZSUXJ1466kLuBPxbT88gv2Z33SqBmKew1KRAkykXF4hquWGpbP6hSoBiP1cCwUIGr7YIjIIrlWJiESkfp9AHYQfkkO3dK/mNw0auXsG39QuuDJU7XZzfhfmgtg2HTlyc40Ad0c8gUsfCK5ERbUQBqVeiMh8IusVWDLcY+ZfE0EbJOaEH1jYU314DUxe7CzsFUDOlBddfFUP33q/TMfHuIKciS+cgcDnC8jnZNrqxy3RB4MTMa0NKq2TKg/VieX8Y6SPiYfalOnlcqNwgz6Qc1U9ThLrymxNs19VjQZDHNheJ7xJgLQ3rQQdSl9DkB/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ls+U6Awbsximkn/QkNJbncmd3R1uDypxcexS3nCzLLo=;
 b=Sk/Hq+TdD3UjwlQMsfgZQ8PKa6L4PH0yBKT3aIOuiz0ykG15hHmuvFqEoX21e1z57NN7bwC7lB/javorK1sVtFFGMeOkDx7D/jrZkB8oGe09usbXwdiR0ImrkuFODmTbpSqILFzQmVC8mmJdjqQznuIPY3+v4xVTMGXMQ2fF6kaUhpmAwv2k+HeGtgQyXLMV0RZaSPjcOJdReSPrU8oaSbID85PtWzxcEwmsqTN6heAPxqJ9zb3fkrs8q1j43U+X8HjWfy4bWiuP/6wvBO7M7GavjD0h8tUwDgqDjkNik0eMOrWRri6Ohh+KMgOPGTrggffcZfDBnpwjdIgoV5q/ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ls+U6Awbsximkn/QkNJbncmd3R1uDypxcexS3nCzLLo=;
 b=ljC0i1Hy/4ewI3gN5e1vPV3z7v643B/I2beBTgWDvjeiLL+kesfIl0Vf9CxO6iszqvyCFFeEoh8bgBwlhmBwzHqcYH73CT9NK5EvYqSVTnIRbYX4R/dXM32rqYmvaU0HJvEBjaUWxgJ31tXG44sHDUj5aXN7nGR39tWSoESbBeUhJELW4kLQmvpk2DeNUn6TOdmRNuWOdOFqzRce9LadUtXCDFW3/qajX7NUk0jxRZtfldhNYdFXNVLZUXOvpKnvIs8T5h1HAEgKaMNqxJzCOHwfAKIigZifOBifcTVdyk3FoUXEUnG2eDez9HA86YSq5UG+s0hxEvcM9PfPL/SIYQ==
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
Subject: [PATCH v2 2/6] mm/huge_memory: move folio split common code to __folio_split()
Date: Fri,  1 Nov 2024 11:03:53 -0400
Message-ID: <20241101150357.1752726-3-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241101150357.1752726-1-ziy@nvidia.com>
References: <20241101150357.1752726-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0107.namprd03.prod.outlook.com
 (2603:10b6:408:fd::22) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY5PR12MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: cffa0d44-24cb-4c23-5a11-08dcfa8670a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tgLLugnwwLJWq5ZOuj+yJsrQskDyptgQNrsb7qZu1kIw6jkOYfKID955bXyN?=
 =?us-ascii?Q?XdUUFDGmxpUe/j0wUi+V8N8WM3iKjH/1TwJ9OQRGUgzDbplovu+MiM62q9TP?=
 =?us-ascii?Q?HUFiGxfWfwngyQlLDAkFm/9hZ3jnfUTguzjujNfaHkCvLFuDe35V2XKBzQqr?=
 =?us-ascii?Q?n1ja3v5Q42EInXoEgnbUXll6vi3xkVUNPs8pRX+9uN+vG5/QFrSQZUzjFQue?=
 =?us-ascii?Q?Z76eg/bhSVsD+kTOXPN9mgXJl06KDNLM9KH/z/Knaxgy6yJxUUGLWpN2ioK7?=
 =?us-ascii?Q?VO1qP7fDXyF6unp2mzbqarJj/nObh4hFpZfHHlN8SAqMiEiH853a6j6Mp4RP?=
 =?us-ascii?Q?/fQsC2oNzKVFv5nTvGamhpmL848fCwHfaUhwGuUCC6eJD0Gi7WnXDZKcDqRS?=
 =?us-ascii?Q?Wnmqv3GFLrZwwv8jMNIseddSPV1pAOZKMfjdeAmPxM1ECRb5fLYh2m6HEZbX?=
 =?us-ascii?Q?XLDfdrTcTis/E4uMMFW9B0FXw6ShFWJuDdHb/vWuAQ31+Ny9RHQEs/ai7Bfm?=
 =?us-ascii?Q?CnkHhjWUsR+M7S20kmsdVMmiqWmoPOqwl6A3+o7HsQDvEodNTKNz+vjK1Zr0?=
 =?us-ascii?Q?9hexyRngoOk0wWgS1MUrvoN8UoWDhPX2iTFv1HaArml3PjhxoIQc8RKGGHOr?=
 =?us-ascii?Q?ai43ojeHqsIZNUFluW2u657lD9esDpVVUy0FQJtZdUDwPiWLreiXRlTKoeN/?=
 =?us-ascii?Q?jblQmTvPoncYyHGm5AKKuH0AHtPpub2qJ5arQHLpFqwz9k6XNb9sicaRKtYD?=
 =?us-ascii?Q?DRUU73jaLz6/PBWebJhiW2B59g1kUKD/Ztqssczh/rEKoLzsoZD9n2XrAHnN?=
 =?us-ascii?Q?lAOkUlrXUtKwQ5lRIdxsOA2R9GXaXvXkszpwTUVw6MuxJufj+YQu1p3zJ9lV?=
 =?us-ascii?Q?9wOQBFDsOvo4oSjOpnxs7YtbAb0pE8PiUALpgJNbgygJuKNnfvLi5hvh/iqM?=
 =?us-ascii?Q?59eKKYtCXa60VPy5hnsMO/6sHRFI0grrXWsj7zT1a+0IBPlzY805aeHWmQdH?=
 =?us-ascii?Q?0zUyb1srRjfObtg3ltVA8zUZZlNaHgQolHZ035mCx6Op9XiSuOKMjyvf03sG?=
 =?us-ascii?Q?Z/zCtY4qreEWVBL2QCT+MECNrUXt+nCmwCo34lFy367ndB6XS8L4HF9kaKpL?=
 =?us-ascii?Q?xadQvTualBuYTpbs0B//+B3/074aL0zLt+g16b+uvKNIfPdPKf9CutwB6+Hw?=
 =?us-ascii?Q?xZsYEskLKpMTT91H7oKHssqwf7WWK4B1R8zGQdb8DXuxBDIG7cRaLPQNywJO?=
 =?us-ascii?Q?j2+9NIfgTd9urEBp0EpcW7FJkIwPsBvATVkEgXkdsNPdXnXx7/HekPPmru4F?=
 =?us-ascii?Q?oUwGHfj2dp6MZiKx0RK20yJI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mVY18KV+DRA891tghXeycdKct+BoHR8C60T+yFDI0rGQtkvH8qlZILGphxao?=
 =?us-ascii?Q?PvMnUAb4b6IVKs0UE+imN5YkKG9w9yp3aG0zjS8/PtTCNZrri/V4J8+efwRI?=
 =?us-ascii?Q?QoWM6hbW1wi9mqK8dIIALutY8w+ziTwZ97YYoI6tT0XLWXDmf2cMaTCs2Q8K?=
 =?us-ascii?Q?K5CDVkqit3KF15lddt+2KyjvtyuHLLDYCugm4jaJMKT8Td3zbJFMSVZk69/u?=
 =?us-ascii?Q?0rBhgjbNtdtREDe0jvc51fn8M+7FWXgeky9rif/7EZp9aSdyYAbx8Ma+U8Hf?=
 =?us-ascii?Q?c2926etIpxd35FUJG8cz3pgUXsY7Z10biWSBr/6VwHMbp5TuFgS2nSRgELAe?=
 =?us-ascii?Q?NQXCuL23N3CkRoSG5pKW1WCfqJdjCZyvilSENhTvfM/UzHdSevdsJXzS50Wr?=
 =?us-ascii?Q?YZLyiMYV9de1cISX9uPBIZLGGQ2/cN9kYKoV/K499ZC8vnpmPT+cHbacY0H5?=
 =?us-ascii?Q?Aj4sPSuc3SQyqdwxm4x1jhFpPFsbjl4IgFS3VG7f8PoHiXLtzOnWv/K7/9RB?=
 =?us-ascii?Q?y+yoRmPJj3vFs2f4kLrzKAaKwqzUXIN/dR7Ux1xzXaEbs5p0yPyUbb7p8eoH?=
 =?us-ascii?Q?sspm2I5O08R30fDz/f20AMkSdusRCD+AMYSMCEwfTDXeTla0kvMPfPCqDGRn?=
 =?us-ascii?Q?7EpA2Tr8NWP9pAiMADL0dXNqg6AK5mhFFvjk+52maR4zwv91d9xef6350B75?=
 =?us-ascii?Q?SELaRb2E1EVl+x2liUDIYdgvKZiUP/gnMYq5d9FwsPnru5cBBh2EpAIaTbcm?=
 =?us-ascii?Q?9HM+Q+Uq2TTYhK2dhrqiP3VJ//r19gb39aoG0Ks/3byIt2WKaqVIwH+j3bU+?=
 =?us-ascii?Q?wsUsXV+6ilL92nmLeLbm4mLXbwB0sG3QRJZHsg4b4+lgoSy2uBz7p2aQaZw9?=
 =?us-ascii?Q?Mu3T1SUPbkZ2J6x//ZroVbB+rvPNyipbHiXX1PYL18sD/70EgieBNWYmVLAi?=
 =?us-ascii?Q?QoQ3GUqv8MpNheyhi14mDrDx93Spd5qLIlQtacKQ3iBTXJxlSw/tHivN8Nar?=
 =?us-ascii?Q?jN7VFXUPmokNnZLVlQpLa7GTHJ3W6QMprXnE4PoKPkcSaQnbASYCbUHiO4fq?=
 =?us-ascii?Q?4/EJ12vBmSydvyi32SQ9LK1tfPWf/gxZp3j0tKABYg6ThRuom0tQRoUNv7MJ?=
 =?us-ascii?Q?JvJiF6ebpfSUzbt8l65fF/EU8ZdmKoVyQDkGH531fYQUbK6ZkWTwdXG+7pEH?=
 =?us-ascii?Q?BYVoEzxYtwIQQ60fMCM2ljb9FA6TzGlmai7wPZ+aZE0vQrbeb1L8LmvnWoWT?=
 =?us-ascii?Q?cMeeQdITsNjMY0pj4n8BATShzTuvgttcZ9iZoUS2M9rAHnY14333HOuFl27Z?=
 =?us-ascii?Q?sbD8p7Wiqxd9HBy6dW4WMjnjst3ej8FFDWY4Id9hJu65dpLsD6oiZqqwrdVY?=
 =?us-ascii?Q?zgTUpJQAabpialqADbDbEtvj/zQhiJht7OQtw0l0LqifYDI4Noq+TAV75WSX?=
 =?us-ascii?Q?+R2g9S7YXuhkAFF+ZDwzUlNHlmCHwnWJooXCw6UsQ7M0Eovr7O/gRtdZ+iHA?=
 =?us-ascii?Q?I3gcx8UPnoncY9pugYfANAUAUMGySdWNUUmDXCDrQiDgoPnDu3l9bc5nc/vI?=
 =?us-ascii?Q?wIwCGbozd3Vf/d8AiFLXCWY+YNxmQDpGu6uG786U?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cffa0d44-24cb-4c23-5a11-08dcfa8670a4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 15:04:10.3552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D96vuK6PyP89Br657QAtqqCpL5tDdEtTOGLmkS0IRjWi3L0E1gs8Kppa4MBA4Vs9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6621

This is a preparation patch for folio_split().

In the upcoming patch folio_split() will share folio unmapping and
remapping code with split_huge_page_to_list_to_order(), so move the code
to a common function __folio_split() first.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 107 +++++++++++++++++++++++++----------------------
 1 file changed, 57 insertions(+), 50 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f7649043ddb7..63ca870ca3fb 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3705,57 +3705,9 @@ static int __folio_split_without_mapping(struct folio *folio, int new_order,
 	return ret;
 }
 
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
+		struct page *page, struct list_head *list)
 {
-	struct folio *folio = page_folio(page);
 	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
 	/* reset xarray order to new order after split */
 	XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new_order);
@@ -3971,6 +3923,61 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
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
+	return __folio_split(folio, new_order, page, list);
+}
+
 int min_order_for_split(struct folio *folio)
 {
 	if (folio_test_anon(folio))
-- 
2.45.2


