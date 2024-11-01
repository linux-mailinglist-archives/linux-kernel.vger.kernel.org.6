Return-Path: <linux-kernel+bounces-392424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 366639B93F0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 16:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 594141C21144
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 15:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD2E1AB507;
	Fri,  1 Nov 2024 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oFJuAa+K"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F8B19F131
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730473464; cv=fail; b=Shf6OuteucGNU4IHvrStSlNjqwBb06EO2v8I+W36QpTX/4H8a86cKvmTxGUevBeGH7JKdHe7LoV+QO6revqpJKdWBBhH4GZ6NRmYUrLKlc9BblD4S3hHv3ANykoEW1//IgdZ9fh9fzrys0VvUIweyyXYXQ0mCayIf+y+gerFGoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730473464; c=relaxed/simple;
	bh=HL3X04qkydD4bB+r3Hnt729ZOIX6O8hAQQwzaJYfVsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nhfy5VOLIwF9kyrMqD8EcnwhJbCAq8sLgDJkJBJdklVSePmUn9FlyAnP0FTszrJ82AtSRNPH5uLvbEsB8/fmrl8t3LHuxec8y04OS0lGByjz5Z5AI5LBE5+2iwfw0SdONZZwpneF48zMbWO4ca2uVoIEwTMzPQ99kaSXut9RGUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oFJuAa+K; arc=fail smtp.client-ip=40.107.223.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jjUBhVB4kJdF27GMJG0+tDiN1sMLXJraRLU5N5J/8NBuchCYwlMv27ctu1YhQ3udxO220zOkHdGQ5bhPRdqlnrceZqR3eo6JRCz5VppNI3c6RAnL2GfXVTMZakr7RDaY3NXb8X84IoAcV0FpVnhpMAgrxhaEGD8USDm8yNEFRWTSpz8jx1PzUV/rD6H9z8OZz6XOz7NiHQuR/9+y2ePgp9wxPmjoJaomL9+IIi6gY6ZzzvigoP0yntOq49MfeC501LoJmSct34z4P0hNaNwOkelaVudj+ITQgetZjyBOHQL65qn9x5bX/Mv2LYmWJYvqy6jVZdud4gEGPB0oZDc5tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lI+AH28x7kVbKn6FgZA82KmuNv3qy1tf+VlP9HU+4jY=;
 b=rQA7kRukg0BB7HhdXxeT1jJSvloOCvW2MIEii1pw+Rh1wNPbLuQw5FhMW2inop2m3Fpw55IV2s1UAIYwtGlKCToK6tYBMDynN8FcWXThLvBy78Th1ux6WrKsHfbH3uQfH/I/T/4QjMhvYic3tKGfVMySqZPD0J/FWYwSU1ngbyOB4OiadS1J+oZDs3iw3TRzHI2+eQbDENsMeeDV5TXj/V0Li1J6V7dhTA9Hwgx3yuJno/bh/vsUTz+Js71NdsMaKBXT+2ykjRt55gGl6WTJKXT4M1zwvJ8XimWmdteK+KL8kVf0gNVDgRCrL9iTxyjnoIDUWRNFkcIzvG8yIsysFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lI+AH28x7kVbKn6FgZA82KmuNv3qy1tf+VlP9HU+4jY=;
 b=oFJuAa+KNelwsqXgZ2POTq0xuAs+q6SOqKPX8ZX63jBts5BOq1hl8gxl+w5v7nn5a9hs1o3EPtvs5TEeCsOMe4HeSB8oFNKC9zdNf+X6brZM48B1j+3FIGyRcXBbwm959vTREOnc6CurtrvVo8kZkhkHtrw4sz8fTMFg+la8qvkep6IcXazlZztiY/RkOksq7qvqmKho3B3kWJiZ9bygoputHr32jzTSGcQbE/Xz76gSx6dt43pnURAMom+peaZObk861ta+p40Ke/Ts2D+xhV2YknB878B8Qky9OGovY83bbVzUBm7bLQ7tgOwbDesJkx6vruB/CgfGJld+S6HvrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH3PR12MB9453.namprd12.prod.outlook.com (2603:10b6:610:1c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.18; Fri, 1 Nov
 2024 15:04:16 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%7]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 15:04:16 +0000
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
Subject: [PATCH v2 6/6] mm/truncate: use folio_split() for truncate operation.
Date: Fri,  1 Nov 2024 11:03:57 -0400
Message-ID: <20241101150357.1752726-7-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241101150357.1752726-1-ziy@nvidia.com>
References: <20241101150357.1752726-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0130.namprd04.prod.outlook.com
 (2603:10b6:408:ed::15) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH3PR12MB9453:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cd5493d-1c37-43c5-c054-08dcfa867438
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E7+tN4QhvbR50Mn6ojl/YYLw4YEa1wxSEem39qSRpT2cOjQKYhtCM1wqbSCI?=
 =?us-ascii?Q?6+shx1MyNs/SfKRX+gdnu2ZxQpItHOLPtsDCxkLO1SFPDEAH7zJIRqONDjVi?=
 =?us-ascii?Q?yTJktxnCinViSTZgkJX9ZnyvpWF6phV9XkWd8TbKfK8s0SFyplly8iARO8KD?=
 =?us-ascii?Q?uXL3gwl4aGs9EYNeiUVdWrORX3kSNoGtXBz3LkAOOctQRWsizqp7r/PHZd50?=
 =?us-ascii?Q?h5uE9hDenMg/YCcdnZtrqZJa+OJ4rMJ/2NKu/MlexR/NpuqWQBk+9nb+kxYY?=
 =?us-ascii?Q?SkEns6rZ91I61KPA2qmJVipxWtT2fMtW/k/lIY9MAk/RAZ7+RjTDzfhsj3Vb?=
 =?us-ascii?Q?pXghAEFInm8aj9llzATrQiAnUbOMDDbrLno1V6nEEk9B3w3XselfVIrwO6LF?=
 =?us-ascii?Q?Wn4M0nnfA+aKvmXktQGNrQNMiUcV/izFdRUvkkhEaUmhy2tD+ZYs6b3KS+Jp?=
 =?us-ascii?Q?M2rV1nvO5hCUmFKn90LtNiD2MRJUYR3F7LC6TWG9jBuF7LULLkKkExtwn6xI?=
 =?us-ascii?Q?kl5iNu4vfzGeMkz+lm7c4x5r+SdFcbEhBpxD2GmDJSUG7txZs6ljeYaKpUnC?=
 =?us-ascii?Q?L+SJoPwtPqwx9TlCTjM5P5TIXzg9tQvFY9p5uw5oxjJWo2JtsBdId6IosYPD?=
 =?us-ascii?Q?E2snLNwbunbY09J0bdimXVn930Z+puq0MQyhpuPenbOEmf0pwEh+G4VcB6K+?=
 =?us-ascii?Q?lTIw1KFyxLFM2zwBuyteueTkF+/rYiRSbyeoDf9h6DsYkk+4pnZFyfvFEXf4?=
 =?us-ascii?Q?0hzhvgq4hWFGcxSX/Cc6jAwAew16DHOhPPVa1indkaqyYr2JBSdgutMwWkO2?=
 =?us-ascii?Q?rSmb1yKEdahfKBjK6tDcYOW/nuv8yGtFYOHoYqjRG6jVUetD9jkGLFGL1vIy?=
 =?us-ascii?Q?k8TzMM/UOP2vICh6vNP73EJaoajLKn3+X5rWN8Gd4ZKy8a5Oq7RmnwitXUfX?=
 =?us-ascii?Q?2kOeMWCVF2crm3suOPuXbC4VZMLPEaQZK0bMJiQ/l/BYe5b8w2CRfjqZHeMY?=
 =?us-ascii?Q?kxTsIi5tyfuczIGcI+OXqktjQdDUnpz5/ngfYygzvr7N3Kv0pklJMl6Hys6O?=
 =?us-ascii?Q?ajm81feF323sbTDBhk27puKrCpPC9a4N3ajnHtIdGOyiHi9qBzDjhpflCBYH?=
 =?us-ascii?Q?Zw/ZuPgMFlpK3oBGzE2WVrkkZfzTwcuiJHaE023lYcgFwzInjBE9jzfXzof9?=
 =?us-ascii?Q?OOrpPyupI7ErUayD+Nh66UXOWRB78KpeOOD8mXM/DvkKN+8SRLZxmdd+Yhme?=
 =?us-ascii?Q?xRwQWfoQWj8LOHANlohXI9ePArTQXcap1e/RZGU8vOk5+zp9USlfIktEl8d3?=
 =?us-ascii?Q?/mjnnB1n3ZftkhyLiE+D9xnV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bm70WWlL0Zgu9Y8GJvMkTLecZhz8T+Cnc/o7YJuonvewZGHmSN4QmKrO/0KG?=
 =?us-ascii?Q?OFWcmQZCPSIP9K/19xPrQVh2HZt5mSrIeokIL8YAuenM1K9hDBLgPl4E0m54?=
 =?us-ascii?Q?kAHHtirTRWltECQ+tE5rLuWhYPMu1EmaDfKSnHcOkg23JYSDj/zOTGEqs4oi?=
 =?us-ascii?Q?fK/Ejx2Gntbt7kuJ/DImCSMmVz4SOM+bFyIOvgTfgDMCf4nS0tg7AXmltC7g?=
 =?us-ascii?Q?C4WqzusQF4txrj+adTgA9qQ3gsmGbib+NBi5SEqU5qTHZBIiZWui04sG70uR?=
 =?us-ascii?Q?Banjpsg4W89ldl5/Gp0E7VCGzCfbJjTj6jfvNGJIqr5Ao8iOZzjMpCJk/Jef?=
 =?us-ascii?Q?L9DxpNv2VSdtldjEjuKUQBDB6V9hYuxhXV3GMtCvJl8m0PHNs6U4kisZHUH3?=
 =?us-ascii?Q?uybA26ReDhaiZCCE0PCKsaGFLu6aXVj5eg1l8O2Oc08uvbutCoZC0cLkoEsk?=
 =?us-ascii?Q?lcS51nvWquAfQbiqMLFsTnqx5MPfn4rSAeCVqrx4uq2IMlXuu7HVPZDOti/A?=
 =?us-ascii?Q?/TPcNYAH4EYqqIUFp1YksjAMPd8krBSjPO/IWrtd8QTe97/RSK2XGw+2oBKL?=
 =?us-ascii?Q?zE/EKvAgmJcmTDeFqu8bpLvCY18j6oUkFK5LMuEvW9mPtdzfveq7uQ2wL4AW?=
 =?us-ascii?Q?zEHS/oQcl9FL8nHSKlaeInSorNz9xeCKlVexNtx1W+xfrpW7A+XGonNg8kVK?=
 =?us-ascii?Q?hPYeGjdl0lgYBWtMdzDPcQRoNlEIu+8mj4l+mYvkX4GNfxbNKj32V4Gunzwo?=
 =?us-ascii?Q?0vy+pGVBEWKHZ0Nem4fcftRUxyKnmunZpPxmaA17zyi+Bv05AeFeLALtDOdL?=
 =?us-ascii?Q?66gO/ai3Fl85SQ2gmdzi5grV17sw0eHVABjChzJs8LErnsO7dRlgML2vjpaA?=
 =?us-ascii?Q?nRijoCTo6T2CTcxXBBMZbOppiBig4wTXw5NCt1LFkNZ/zjyjp454emPCpLbC?=
 =?us-ascii?Q?JCgaIFOmCc1K1oHIduZ+8eJJVvPW6An1at2AiVYxfG8znwbk2B7r53SegJVD?=
 =?us-ascii?Q?HlHaj9rCmmTmY74TM4THVkTKxJkzd8P/JyAf0hWYQAvn5Rnl81OQXMEZZOB7?=
 =?us-ascii?Q?VfGMAyM1wllw6mCxa4H/hifCQ3A8xfkwmFndcD+3uS3WOd91+lu5yyyCIsm9?=
 =?us-ascii?Q?cPR0iNIodboaBD5jKVdDPwsflfKM4huOJ9RTtjPN6M47Ict5gslsX+/TuA1K?=
 =?us-ascii?Q?2Ef+NEkQvmYLdSpfcYD2QSHLnTZJ12j/oI3/rRNALwt7h+p7Qm7mPNGUqkgi?=
 =?us-ascii?Q?eyzqiv0iaAaaRPKxr85B/KmEBMxu0x4+p2pGIGz3YIi+HlDAi2SRqrN9u5RI?=
 =?us-ascii?Q?sUTCC8IXHYiN5OKW6OJFdR5vL/AermKI8LX4p3CEd/hg4RuBv6JDoz4nbrhY?=
 =?us-ascii?Q?zon68+FLxXZebjsINOYkwmNHj0I/czd4/jrUG7g0GCCkdU0Ikkub7WS9ihaq?=
 =?us-ascii?Q?rlLcdkbVlCbHU8t6hJVgjHKC6xN2PhBBnqt7nARHlnfyFqSh5AiQPWzTcw6R?=
 =?us-ascii?Q?WI/tIWYJ6002GAWPHsAoXthCob+MXm+qIJC1+WlZhxEpPFDIwIP1sN1XDYb8?=
 =?us-ascii?Q?Qe8dHIGt+x9vfppp+k+t0bym8cbp4xCuwh7kpnHw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd5493d-1c37-43c5-c054-08dcfa867438
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 15:04:16.3650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OljR/ToYuKDg40rgbQSGjP8Y2qY204OfODaQ+qkAJkU27A9HCVIn0V8hrVHqWyAK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9453

Instead of splitting the large folio uniformly during truncation, use
buddy allocator like split at the start of truncation range to minimize
the number of resulting folios.

For example, to truncate a order-4 folio
[0, 1, 2, 3, 4, 5, ..., 15]
between [3, 10] (inclusive), folio_split() splits the folio to
[0,1], [2], [3], [4..7], [8..15] and [3], [4..7] can be dropped and
[8..15] is kept with zeros in [8..10].

It is possible to further do a folio_split() at 10, so more resulting
folios can be dropped. But it is left as future possible optimization
if needed.

Another possible optimization is to make folio_split() to split a folio
based on a given range, like [3..10] above. But that complicates
folio_split(), so it will investigated when necessary.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/huge_mm.h | 12 ++++++++++++
 mm/truncate.c           |  5 ++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index b94c2e8ee918..8048500e7bc2 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -339,6 +339,18 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		unsigned int new_order);
 int min_order_for_split(struct folio *folio);
 int split_folio_to_list(struct folio *folio, struct list_head *list);
+int folio_split(struct folio *folio, unsigned int new_order, struct page *page,
+		struct list_head *list);
+static inline int split_folio_at(struct folio *folio, struct page *page,
+		struct list_head *list)
+{
+	int ret = min_order_for_split(folio);
+
+	if (ret < 0)
+		return ret;
+
+	return folio_split(folio, ret, page, list);
+}
 static inline int split_huge_page(struct page *page)
 {
 	struct folio *folio = page_folio(page);
diff --git a/mm/truncate.c b/mm/truncate.c
index e5151703ba04..dbd81c21b460 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -179,6 +179,7 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 {
 	loff_t pos = folio_pos(folio);
 	unsigned int offset, length;
+	long in_folio_offset;
 
 	if (pos < start)
 		offset = start - pos;
@@ -208,7 +209,9 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 		folio_invalidate(folio, offset, length);
 	if (!folio_test_large(folio))
 		return true;
-	if (split_folio(folio) == 0)
+
+	in_folio_offset = PAGE_ALIGN_DOWN(offset) / PAGE_SIZE;
+	if (split_folio_at(folio, folio_page(folio, in_folio_offset), NULL) == 0)
 		return true;
 	if (folio_test_dirty(folio))
 		return false;
-- 
2.45.2


