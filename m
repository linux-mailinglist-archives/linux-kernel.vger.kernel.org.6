Return-Path: <linux-kernel+bounces-355986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C52D995A47
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 00:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8397B231FF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 22:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5090B219492;
	Tue,  8 Oct 2024 22:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="guqdgYE5"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70645218D71
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 22:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728427080; cv=fail; b=bb+zpsOnG8VdWXoT1X768Vm6eEOri/H87YTO4Yfz8jyf68lad4nnCc8tdHCVL8fJ+DZl8PVv+47BTWPGy/zoHJgmMBKslH9bfObq1lg6rVRZMackGk1KxnOA2hzjLNi5wtNNWqeVkCHsKFJHzw7MI3MzWSVAs6oS+7e73Qp11BI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728427080; c=relaxed/simple;
	bh=cnCHeJpoY10ux1CoxQvLV0++XDILTUhQuoYfNf9EdOU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YBu3NEqJ9g62ujFTf10oLxuUF0BSJcKarQM9PBDRo4MHlo2UB3GKy/0Dcxy3zCTMIBlFuwaPTy0eRffZY3dh8sPziuNH/0lpH39+01v+aJKZvcxRvpYvwKg3+fLoPqzpS5HRZqYHYQG1vaKpyMFsTAbHRYrSR4GeuwbJXMLHadU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=guqdgYE5; arc=fail smtp.client-ip=40.107.236.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x2kVbvINNM+pb9P5uFZ6s5CVUCBjC31U8L1Y0nWxNGWijTCfkuwHW1QIrl6ZHR3gjVnzK2VqpVRdNJQNVv1jN5RDV6YaHyOCldSOITLVr/qtUiKYDTm8NryO/XXf2z1TRZ5CGSbhjHBYe+czAZMxct1t10bh3SpLbGzGGHV2+yjF0a5zobTJFzWKWCAa5IkDSzvNe/RQ+ooS9hCrvVM/r6QRKTCPPck7Ie+uPUykcpJESIJSUpVcBQ4gadkCKuMe6ZqLI+9RsBZvnXbvQ48MvfGBtVJ+1cKTUM5W/OPenj52RxdIyTmWKBkUvw04oWRm+mIoBW5gyshasTcaPhV0nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6WCnoEIqSYQbubOcNssCApo3QS+5U4vCZcGxPQnwXE=;
 b=QPGCoe5+Vfo2AtVHUq5fmvX+LjYkpd4XYxjtghrXYHuIk7x0DP2vc1vZRD5rWBsCGPLIWe05p9QmU0di4B7UxBTkAQdtUVYIdP+VidmwiKMDMT4f4NsyR1WpZxzyRfQIKfeqdGb7Dk6JOPwDWX/tsTnVDR6V0Ik4vbwxb5mRPQP4gF6DsthgDcm1IGv041KvTpc7oN9RbRQA9r4SjAPTcUBt8P5BWrSSNMH0tMGoKCTdurIEt29NQvMPEKsuj+fQvgplD1xTy32hJ5e+h0sf1DGvNbwdqqptnrIHGSORJrbIkRRzLTvo++H1/n3znU3p0syHbYdZtqAh4jN6uVLbQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6WCnoEIqSYQbubOcNssCApo3QS+5U4vCZcGxPQnwXE=;
 b=guqdgYE5SDPGIUc5P+bKdfV6xFj0PjIS9/SbB1su8AIoF2CfAX3k1STtFGAmiMzt+Qj5uk1yP+ue+lXlcy++bsLEpguoVimnduxfhck6ri8UWy9P5RZ8fk+nUsg0EfWEtipzUsmKZB3azsZhhY9N/WqXqqVEtWTLGkH/vr461Ziumoe6mdgSXA7MCPZRg25VvNN+GLlrGSEq61KSTFNztaIl0iMpKGvu4MryajyTvvoKZvMPoXru5RyY6g8hvKsa+Sdyezn7d8ZZ7UHGi/V5ztYclqbSGbmCZFqb/xCvTB7GAlr1IN95DYV0Iw2p8nVA79RBFPTxgJNUi64kUjmF7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY5PR12MB6322.namprd12.prod.outlook.com (2603:10b6:930:21::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.23; Tue, 8 Oct 2024 22:37:52 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8048.007; Tue, 8 Oct 2024
 22:37:51 +0000
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
Subject: [RFC PATCH 0/1] Buddy allocator like folio split
Date: Tue,  8 Oct 2024 18:37:47 -0400
Message-ID: <20241008223748.555845-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR11CA0009.namprd11.prod.outlook.com
 (2603:10b6:208:23b::14) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY5PR12MB6322:EE_
X-MS-Office365-Filtering-Correlation-Id: cdb624c0-a59f-424e-4e8f-08dce7e9d7fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FOuc9XxB5kVczqj/Ee5rPrrWSQJDAMU1lWNBePcgXRLzAvcqoe52jhoHYE2K?=
 =?us-ascii?Q?8T//K5BRgGUfZcROghy0i0cQMR3EFAhbd+tBfsh3to0Q6QAcPpw/D08OYg+1?=
 =?us-ascii?Q?Qb7npwiwMUiiFvkphB0VUvdHvbo5cAh4ujoMm/CKgTYbTGDZIu7TXW5vae5l?=
 =?us-ascii?Q?ochg0Pe8l5Bu+gXpS26ZoNB/ZaP6yzblHdf9Rg1H5LRpthKq1x1PL8cVG2+p?=
 =?us-ascii?Q?ulBqdrKJ/uPC7eHIfI+A0drndkn8tis2W6EO/r8W8x8iEgSwIGs6kl2s+GRK?=
 =?us-ascii?Q?tSuC1OtahtsHb04n3kNSVuHH2j72cJQloSLWCvZtpXTy2elRMxLjw0Uqg520?=
 =?us-ascii?Q?HF2rmsHI3tcrqnZNTu12pZvtYqEJ1cT7zAP5/bkHj3SeqP2Jp85qggGrJdd0?=
 =?us-ascii?Q?k7h4Lpz8tbdYlCTL9TdNlU+WuUTwyy51v+r6Iqk1mahyfobpcyholTaxyxs2?=
 =?us-ascii?Q?JmKcG4vq/8lKw4CdU/KfeGH/Pv8he/TXkw13LmlPBgwu672NG5+zg3uth1cB?=
 =?us-ascii?Q?EtTV/FUtVK8hZPZt7GcKMF4LeUX4IKd8w4P9S/UGUYLjPscyZHYxKfAVQPiv?=
 =?us-ascii?Q?dHKXNIkwhFRrO1E/Us90us7yPF3q2jAdJ9tZH7UVVVpbdIL4pqUMWe5FIbO/?=
 =?us-ascii?Q?MdpCfYL6RDKicauCSvZ77v26B7Hq8F4pqZy7lP+cgXYkprEqmwmQB4F/nb+R?=
 =?us-ascii?Q?cwSvO7N/3CAoRmZR7AIM+WWGpIJTDX+VkpvMvHjK7oglJkoltbTR2wEU5NM6?=
 =?us-ascii?Q?mj7ncmct5H+vg6d95YoSG+l9hMGnSeg+QiUaENVL7N3VwkCj6hRcJlhYgqIb?=
 =?us-ascii?Q?5hETz/9p0CY+i4m51vIeP4N8xfhVME6/dyyizhqoq77M3SEoj7bsQ0y9hPfL?=
 =?us-ascii?Q?cANwM1W5UoPcLzsTx8T1dEUE2ZyjaPSu7fxmaWrknG1UgOKQPi8YiyAx9Y7S?=
 =?us-ascii?Q?4dn7CJzysYdVhLFVsZS0XCUs0QwW2Ko3GMLbxHX1kA1ZHnlE6G/XA2FzC7bu?=
 =?us-ascii?Q?+8ZhMlX3u0RzmtZ6MI0RvCQuzV2LN3CiC8ZcEPMQue+OWU2+JUYyrJ1Y0NGu?=
 =?us-ascii?Q?M9sqtoMIFb0hdHz1ANIQwXvTGJejmToUsMzcOOc00jyrA9KD7NeQHC+EcZs3?=
 =?us-ascii?Q?8+LpjjhpblmAoErdjpHKfm16gQOEYaHMrVJaCJDh58bGiDsmV8UyVOEWTgh1?=
 =?us-ascii?Q?wFELAgizxMsyDPOoL68nhrE6wP2yNn1sS4rytSY6wLbRnPToJ0KOguP8407x?=
 =?us-ascii?Q?ZtbI/lJRcUAc0BOve7z2yqyKwhXCVzJ94kOGZXWzPg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mCMwUw825M/nCeEmHoS7uuYG565N/9kQ5Sh0C1XUDFq0ntReQIy1Pm9qEntV?=
 =?us-ascii?Q?tW2czcKhAc0I7e9d2iAL2hDPCtiZzwChXV6+24wdYBdUj5RO53dLeGEzd3gm?=
 =?us-ascii?Q?Etb72GSHVHggZTBeSZZhnjjnBR8HXBopfqrDmn0AZaCnmfQeco56y/ZrL0G/?=
 =?us-ascii?Q?sVJJkbd9dk25SbszW1eJ05Gv/MpxrMkPM9yMIn5KwTCx5jMkHKr/UGbvMYyG?=
 =?us-ascii?Q?SzTXoTOpqKlOSCoSUWpJCW6sCIcJ1WrykJ6l3YdH0dtvgeF+O79kiHWEoY2u?=
 =?us-ascii?Q?odawWopdN0rgI+1/b/4qLeKILMTHM372YOnSEvIfXox+KLlEfwjZ4sW5CTEc?=
 =?us-ascii?Q?g53yOESSCGnUp+iBPSmgFh7gUFk0RKydpcZYHHh07iJ0g+kyEiV9ocUogDjC?=
 =?us-ascii?Q?6S4YD40w0UbAdPH2pv5Yc3HvN2kmYFg7rGpt1DjtlptT0yhyXZevD91t2Yh8?=
 =?us-ascii?Q?WtPpJEGKf6cI4JTWbQFnvwsQ+j7s50mCeIT8ImcrFT+rb3UTxrX8mop85cAm?=
 =?us-ascii?Q?d44+HvXxtQcFFOIlRf5goBLq24UT94/c5m25ZFMREnkNH2q9D1n5gUnELoMM?=
 =?us-ascii?Q?NZFdSe+ODhzeHiRzSLu8VZjJ+RVKFhgpaRUHj//i8UHq5D3m+1pqdmJixnQk?=
 =?us-ascii?Q?K5msPr0gLAeQ5BY07Lk9ayf11Lo7IHCx5r8YS4b0GNUIPeu2wTt7NqP8cPGg?=
 =?us-ascii?Q?dd2sZz6TxfjU/XTLwEOE4tQO0YdltBzUZz3+xtt0tJPKdRDiOICFIAGaeBXA?=
 =?us-ascii?Q?7WfTcYRghn7r2cFx7Ma3xyCeSl9PqMivoHekrjZsWm0xAIMZRFagccfBQ1U6?=
 =?us-ascii?Q?UhD9JUv2itqKDWHN73dqhmMUO1p1g+pn2aKGNyL6SvhZSiaJgmpVbVbrFk56?=
 =?us-ascii?Q?fZf2DiaPMXkP79rAY7GBNBIOvY64Y7GJ1dGrfbX4cHbIaopnxtEthh8j0FRU?=
 =?us-ascii?Q?VthZK7XgKmCAUnQeXk1/rN/NXibvFrRPGPSjx3rNTkisc84GndeZI9+etnwN?=
 =?us-ascii?Q?lJky+Ak+Ts5H9p51z8aI6gNrGHBag+bhtYLJ4MZPCbx9S2lbOltf9QBbIYVD?=
 =?us-ascii?Q?vti6Vn8/xDwPUggs1vnI6qaLKXIu6rXvtY06kDoP0Z7mSnzZmDQYAcbqLYWM?=
 =?us-ascii?Q?4ox2J+3GAx4gtKGtHvy9+BUKfejDXRX4htGmhi8WYsb0AWGp4fv6rW321G9D?=
 =?us-ascii?Q?GXTeW6NGypxV4vpIIr4uTD4TwEx0brOj8wK7i4obKE9zqt97kbCPMVEnAzDi?=
 =?us-ascii?Q?eBNMrEeVVYXRc51vZK9sArSlr1oazeabkgWJfeWevRiNKpGEZQurOpe3fedI?=
 =?us-ascii?Q?zYg+hhkVFgfAS9gIQyHJZLhWKMJzgLeDeXi2MXKJD9xI/HBEX8MfX8U6Quf+?=
 =?us-ascii?Q?IvIxrGdAQd7nRcDyO7+jUfU0Jq6lXGCL0mh+4CPBK9/clpU45rodhmAczZ2o?=
 =?us-ascii?Q?tk8duXxQJpBuF9ZvlYDKJUYE8dSW2ghFX1V0lPSTC+NSwgU3PSeaD2yEbkIx?=
 =?us-ascii?Q?+ZBvlB7y9BoEbzExhgGhS0a/FAD6aqdix46sIOmuuu9ZVVjUKeXX/u+L+Ykv?=
 =?us-ascii?Q?OtKD0h+47rB8u+pxRNc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb624c0-a59f-424e-4e8f-08dce7e9d7fd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 22:37:51.8574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /PEIIbmQChBKGbw4lQj3BQPOxhLYN5vgTxQrVyzvGYEYF+Ra6IqmxDdd2gFT06ek
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6322

Hi all,

Matthew and I have discussed about a different way of splitting large
folios. Instead of split one folio uniformly into the same order smaller
ones, doing buddy allocator like split can reduce the total number of
resulting folios, the amount of memory needed for multi-index xarray
split, and keep more large folios after a split. In addition, both
Hugh[1] and Ryan[2] had similar suggestions before.

The patch is an initial implementation. It passes simple order-9 to
lower order split tests for anonymous folios and pagecache folios.
There are still a lot of TODOs to make it upstream. But I would like to gather
feedbacks before that.

Design
===

folio_split() splits a large folio in the same way as buddy allocator
splits a large free page for allocation. The purpose is to minimize the
number of folios after the split. For example, if user wants to free the
3rd subpage in a order-9 folio, folio_split() will split the order-9 folio
as:
O-0, O-0, O-0, O-0, O-2, O-3, O-4, O-5, O-6, O-7, O-8 if it is anon
O-1,      O-0, O-0, O-2, O-3, O-4, O-5, O-6, O-7, O-9 if it is pagecache
Since anon folio does not support order-1 yet.

The split process is similar to existing approach:
1. Unmap all page mappings (split PMD mappings if exist);
2. Split meta data like memcg, page owner, page alloc tag;
3. Copy meta data in struct folio to sub pages, but instead of spliting
   the whole folio into multiple smaller ones with the same order in a
   shot, this approach splits the folio iteratively. Taking the example
   above, this approach first splits the original order-9 into two order-8,
   then splits left part of order-8 to two order-7 and so on;
4. Post-process split folios, like write mapping->i_pages for pagecache,
   adjust folio refcounts, add split folios to corresponding list;
5. Remap split folios
6. Unlock split folios.


TODOs
===

1. For anon folios, the code needs to check enabled mTHP orders and only
split a large folios to enabled orders. But this might be up to debate
since if no mTHP order is enabled, the folio will be split to order-0
ones.

2. Use xas_nomem() instead of xas_split_alloc() as Matthew suggested. The issue
I am having is that when I use xas_set_order(), xas_store(), xas_nomem(),
xas_split() pattern, xas->xa_alloc is NULL instead of some allocated
memory. I must get something wrong and need some help from Matthew about
it.

3. Use folio_split() in pagecache truncate and do more testing.

4. Need to add shmem support if this is needed.

5. Currently, the inputs of folio_split() are original folio, new order,
and a page pointer that tells where to split to new order. For truncate,
better inputs might be two page pointers on the start and end of the
split and the folio_split() figures out the new order.


Any comments and/or suggestions are welcome. Thanks.



[1] https://lore.kernel.org/linux-mm/9dd96da-efa2-5123-20d4-4992136ef3ad@google.com/
[2] https://lore.kernel.org/linux-mm/cbb1d6a0-66dd-47d0-8733-f836fe050374@arm.com/

Zi Yan (1):
  mm/huge_memory: buddy allocator like folio_split()

 mm/huge_memory.c | 648 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 647 insertions(+), 1 deletion(-)

-- 
2.45.2


