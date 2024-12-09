Return-Path: <linux-kernel+bounces-438193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8789E9E02
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 19:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90AE31671A6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF66817BB2E;
	Mon,  9 Dec 2024 18:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OzqNGcXF"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1E7155C8A
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 18:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733768619; cv=fail; b=XfwxTDRibYw0YfknOGDdKpZnYn9ofoqW/dnS4XlSYv1bb7AdQGmP7iBkHHT4yrjW3h70Sc1uP1XXmzsPviv2uylJJpISau2C9b61DqzcdWBYGZCZ6yWToHb/MWbi2/uF0XtgVPg8DPU9R/2WreU5LdHogw88p9z4KURAwGDabEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733768619; c=relaxed/simple;
	bh=jS60T0iFQCQ7nh42ZWZRFrgSnS72cVhkQh6FKk/T/kA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j3CbrFuoXk+nY5q8C3sDpyxDU9Al4XKjH1wS85tS5bwVrKirQypjGOrGCWwa+3orPwvkNHaSJiHo9WTfFJrtNA/eY9WTMEa6oCjzfiFuGf/zXX2cVYOjn/qUFo5MwNRu6WTMyBppIJFp2lmE6quL+O48ivucyfrJe2dFcd+Jelc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OzqNGcXF; arc=fail smtp.client-ip=40.107.237.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ncthLPGUhndRbuOtRUZ0+42Y/+QtInYROsbBHzixKDhL+jQqdA+oz2zbiSKNBY47TV8K/SeB4pURgSOh9EfQsyyZJb5bckrsicyNY6fqDzblCbsQWiQsUimRxnRMSA2l6+vgptnqs5MvtmunUsYUfBxVljnlZHP1nYfX90vDEenu6Dd/xdePiFNbkTSCFnkOqD7E0DRf1Hqxf5Iy9KWjg74cAF6yn4bc7jvfzjX4mrHLp7Y5FLrvF8w/NklpaykrqgMlfMYv9HNs61NQ3ONYeDjxraeQSmTy+mQEMwJDIcOUxvjui1jqF8HpI5Bu7OlTctyHxSI4REV31mD3QGs9bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0aRe51ucj+XlZojf/byPAJX0T4BItCc1xHjUV04rccw=;
 b=iRFuWUI3J7aK5nXvEn3PU8P78/k5CT8pVc+zNEUK6h2cuH/nTkceFSLHyY6bYUZrL3jRTfWFVubc3SAtfGLdYd1Vq9L6BsVG4/J2CdKoifk/BCf04/mmILpwCd86VKV20+l/uGmODsPQedPlncycuUOQt8UbFMZ3l07rhN9ox4H/Mwwo9JTGyerjtWtsY2O/Yfhw2a4Q7uF/SZKqAZNQzju7egmN8Ayg4dfOZiMxvuLZtBrr6L62DfawIC1LhyfCYW7VnuI6qF9F1DmQ6hT9N0ZxHBNeHCHV7KK7ezgz6QoGWIWVmjj/860i5C0LBz7hs3Ij1UsqUegqW41pTs0hvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aRe51ucj+XlZojf/byPAJX0T4BItCc1xHjUV04rccw=;
 b=OzqNGcXFZrITm9n1UhAeWEJzQ1oBK+wvsilDM7G9PsEycyi64YuUZCnDlQZiMaDd7EnnGjGDqfN9J8dG3c+/OoO0dD5c26ykCJBw9w7IfS2Apip83jGPlOzd5vxNS893VkfAEz1rASfjO2LCNrx4u4B4TnyEA0Hdcx/ykMirK56S8MLZ1bEITCdoh37roaSeYdmrVvCNfGJ6oUkvluJw4N08P+D9c0aN1nMvRmayPuuO2Z3h/nqV0VJSBttDBEgx+AruWtPI31gDuOPUnX2iR3ooXO5TA/oK9UOeC8K/+Babf/nPkjPg+jO5hRBP0JTdTVjxDC83FDvG4ohD/0262A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MN2PR12MB4487.namprd12.prod.outlook.com (2603:10b6:208:264::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 18:23:32 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%3]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 18:23:32 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	David Hildenbrand <david@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	John Hubbard <jhubbard@nvidia.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Alexander Potapenko <glider@google.com>,
	Kees Cook <keescook@chromium.org>,
	Vineet Gupta <vgupta@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	Zi Yan <ziy@nvidia.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH mm-hotfixes v5 2/2] mm: use clear_user_(high)page() for arch with special user folio handling
Date: Mon,  9 Dec 2024 13:23:26 -0500
Message-ID: <20241209182326.2955963-2-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241209182326.2955963-1-ziy@nvidia.com>
References: <20241209182326.2955963-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:208:52f::16) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MN2PR12MB4487:EE_
X-MS-Office365-Filtering-Correlation-Id: b817a1c7-a0e4-4c59-2c4e-08dd187e9622
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pxjxwHXlHrvuRoGY22/ksxcWrF3XPxCy9BZjMgeM1Q4f73cP4E/1VK+bfW5k?=
 =?us-ascii?Q?4ZatWh2WY3cTzG8VWd6TVBaNsSJkPANYJgw6WO0pTeIkz696jlmL0t6NnMbv?=
 =?us-ascii?Q?nIcsIeUMbRtJOMhnICoUU7dvrsWSdJEED9Aru9n8qPD2Ib8HJefQJ+pRJ6qY?=
 =?us-ascii?Q?2Fq8iGFqYWSD3r7oysdHc8iKa82JJ+fGRGODhoRLPJ0rTYs4pxjzBjgV5pOT?=
 =?us-ascii?Q?4dyL9UZRDymt0V7gevrcEkY7kkdjCchm1vi30+F8F7sX84nhvUDxpGmjITWS?=
 =?us-ascii?Q?WfpEEabFKAFpoPmpKfQL/sb3gNKZmoohZCA7Xuc1qBjrLoJgL9GM2pxQbc0Z?=
 =?us-ascii?Q?59XDJMz2EDV8gc4iNh+tOFlWeuY7DuqT6xsvpG5dFjVQe2QUXi4EaEfcL+ci?=
 =?us-ascii?Q?wBOTUwnkSkFXmAUUtWRg2pwWg8zm+uHZ0ZcOwG+aG6mH6+HLsWHHSiVOcyJf?=
 =?us-ascii?Q?xWi0yDKZQuWpGe1XS9k6A/EAKaFDWmh8mmd7mu8mK9blXg9Yfx2iNawbDgIV?=
 =?us-ascii?Q?WI+LvKQo74tk6skMKB1Rjz+p1O8OBUYdzE1shdOmwdsnIYXBsxI51mVPZ6ES?=
 =?us-ascii?Q?+LeXKXK3jyYmW2yru/6agnRFrWS3eB3W0KNVxa+fv28OWl9KaeDZFvJ5mQPZ?=
 =?us-ascii?Q?OteambMvWkykXmHeTBTDepgZaMOghuocSZnf70rAlGiLxXzJbps1raQx7/Q8?=
 =?us-ascii?Q?RM7llNfkxl0tWeU1QCFsqBDizxf6rrZ7FWrD/CpWtDmOcLZshf5fr1w9wXbw?=
 =?us-ascii?Q?9Gxo+rSe5ho/CbgLkjvNIcUCLeb8hjT7wcmymwHSX7lQWud8Xswt143PEdF1?=
 =?us-ascii?Q?Pt6Ok+1Oo1rfFODrMTmjFpQgDv8xUOkCdqYsA4QOwPzVzhi5xqBg9GZLhXPn?=
 =?us-ascii?Q?Khmbh4dO7kS22CHSaAE/RdWXhWTXWNBD1M265CQA5NvvInnA/1m3xjd0ro78?=
 =?us-ascii?Q?m339PMdcLZkkOrm60ExZhcoT68rmtgUuni3TZlUIJIvM7aL7pXWvXorCELSY?=
 =?us-ascii?Q?Fhno5cMR9RqbEEgLmbnUUbJ1uA2R28KAkiNJvEJITG6XpnpBHonUwsSd4u2U?=
 =?us-ascii?Q?8jWlQaUXk9Yoi0DaDggluZL0t0ROR5gDNP9enRL6kYfAv2aneaASJyJ79U06?=
 =?us-ascii?Q?Dm8FR/flo30UY+gxAJJOqXxzCjzYcj19U5d0MVVbUaIrhlln+naX03l1Fvh0?=
 =?us-ascii?Q?fMC8mkBXsKv0b7iJtFjShkBqyQs2alh8cv4veCz2rXX22EbSCzox4kS6ZDgz?=
 =?us-ascii?Q?if59IAUadUQYfGLR7nIaZdHI+Kn6OzU2dMPvei5q6nrVOxzzdJc3bqUIOmow?=
 =?us-ascii?Q?DsYLjyJMHzVUCleK2twoq4K2CTfdJHbmFlUF2ap7Nl9ZmOYCL2NSybKCc0tR?=
 =?us-ascii?Q?HOcoE64=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wueGeFTKEdYil4ikEUaSIvYGrCypNGvuP6PKEy7s9U+vAeW/J5bojjItXVIt?=
 =?us-ascii?Q?alHbqAI8kaTt5ORrQDAXn/93QIXu6P29/udpqp1kpw5+ajzBmwujJBRwPPxN?=
 =?us-ascii?Q?rDJM3v8WpZdyq/3iwxsn1B30HxWL4NKDrkwZssEvwft3Kw4MTbyEnNJ4XAQW?=
 =?us-ascii?Q?MDN4WyFxCOQBoR9ej6x8Pubaq6GOgDtuqf8bxxniyeh5udNphGZG7YxePRDB?=
 =?us-ascii?Q?TeTIDDePrlfH535i5+mTp4X4LE5B2Jm1MsBdspoDHYXGfp4n7rUD6Hy1NmzT?=
 =?us-ascii?Q?hG4w7YsHdlnl7/vJdLA8Z3MNApa8v7TugvxtiYyny5/BjJ9OzDA+QaVyI5kS?=
 =?us-ascii?Q?duzOMHxBQ/44rRtoO4eUIAEyUG5y1Jy6gd8b2I3SD/4bwZa769LvqUda+dCn?=
 =?us-ascii?Q?DqaIdm4lSCX9ruZ9wGv9YCts84ZZbH2oD2w+6Dig0tWt5GWeFC0/ULLd6K5y?=
 =?us-ascii?Q?X9zIny33zzetYeXNmgoBSeGKeAxDTbK62SBK6Jg+cFGsY5+BXXfdNBf9b27j?=
 =?us-ascii?Q?2vmjTMdw8pQW8Jgd3/IW0ZotrUuGmsPJ/Rbm8fo3nr6Fb1xtV5bGV21vP+wE?=
 =?us-ascii?Q?7zgu6jqW+SEkV0SPrCfiy+z53Dl03P4iG/28fak3QAETYxEuE+O7nZ6dEF0d?=
 =?us-ascii?Q?+xAd7Ik4DTjQfEPxwnjWBeRwf9GjG13XoSZ882ml+WAbMbUiqNvVMFl/q6ku?=
 =?us-ascii?Q?GpgyawpgVXBDehHJegZ+8d+NmMW0N/37hA7cGnToYmhfXFQujqHx/z3nCTi6?=
 =?us-ascii?Q?wv/+mFnuUxNKdM3NeEWko5z7wKLdmUY5YDonk5Q8kYhPjThFs4gOFhIl3iZN?=
 =?us-ascii?Q?HGVICzJ3AZt29HNtj8VprYwdi6/lDoxpnVxN9wil2Vi42g+ivkOeWdnTY4c8?=
 =?us-ascii?Q?rCptuP+Xhqqc+1yMFxNGq5AMBTiZ6IH+QjwaARM0WiVA6em6K1FI1r78Fi5S?=
 =?us-ascii?Q?tIt0g6md+CP6qvw6qim+ziza0Qq6AWQeGY8YbY13YKYQxB08jaTcniT/uloN?=
 =?us-ascii?Q?DUqkvLhv/lPplc8PZ9WEVTnL8Fk2xdfXryVqG2E6qJRzPtWovim6P5wqAHi3?=
 =?us-ascii?Q?aTkvpc2ZXQL/1WDqcMgJAHKSXfhPR8A2CF9EdYvNIssEQ1ltY5o2qzTzVVAY?=
 =?us-ascii?Q?O/c6yiuOSupxJycs/cJvgDIaqr9pJo3qO9tSeInbjtCwkSIWyWzhvdGoMQzv?=
 =?us-ascii?Q?bs+vBx971Paxi4h2kNkm+GVNmvo7qWT9HkR20Vl19CPA2wn1/LDu2PDtiKPD?=
 =?us-ascii?Q?0riLqB/E7ILcq1yZiOS2pgg682vL1kGhSYLx/pWId666yGSpFgJUHY/Qx7xu?=
 =?us-ascii?Q?aH9ks6tKVxr7u0xvddPbytgHjuMeI/n+NKbOf77EH+NvW+C4sTGphlYsastH?=
 =?us-ascii?Q?ig3eVM8mQT0F3qt7WXP87OT3o/HxfulJrOXUakNAgXWyI5wmOuGlMl5J6/4f?=
 =?us-ascii?Q?iRZclrmMer1UJwS/LMLcERbfIKsRH0HtZ+7rc4/fhY8SDSS9n6ZshJTHG9C6?=
 =?us-ascii?Q?hEW9+gdvk4wAkjDS7xrRaFX9KEvSvPa7jKju6JNsvmIQ03B9NVho+ZHz0K47?=
 =?us-ascii?Q?mAaEFQ6uYuIBV9u4I10=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b817a1c7-a0e4-4c59-2c4e-08dd187e9622
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:23:32.1531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2D/Cc3PUJn50Bprvk8/9fGf31vXdeVKjxjpPJkneXWsAehbx24Bu46NNf5mRQDe5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4487

Some architectures have special handling after clearing user folios:
architectures, which set cpu_dcache_is_aliasing() to true, require
flushing dcache; arc, which sets cpu_icache_is_aliasing() to true, changes
folio->flags to make icache coherent to dcache. So __GFP_ZERO using only
clear_page() is not enough to zero user folios and clear_user_(high)page()
must be used. Otherwise, user data will be corrupted.

Fix it by always clearing user folios with clear_user_(high)page() when
cpu_dcache_is_aliasing() is true or cpu_icache_is_aliasing() is true.
Rename alloc_zeroed() to user_alloc_needs_zeroing() and invert the logic
to clarify its intend.

Fixes: 5708d96da20b ("mm: avoid zeroing user movable page twice with init_on_alloc=1")
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Closes: https://lore.kernel.org/linux-mm/CAMuHMdV1hRp_NtR5YnJo=HsfgKQeH91J537Gh4gKk3PFZhSkbA@mail.gmail.com/
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Zi Yan <ziy@nvidia.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/highmem.h |  8 +++++++-
 include/linux/mm.h      | 18 ++++++++++++++++++
 mm/huge_memory.c        |  9 +++++----
 mm/internal.h           |  6 ------
 mm/memory.c             | 10 +++++-----
 5 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 6e452bd8e7e3..5c6bea81a90e 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -224,7 +224,13 @@ static inline
 struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
 				   unsigned long vaddr)
 {
-	return vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, vaddr);
+	struct folio *folio;
+
+	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vaddr);
+	if (folio && user_alloc_needs_zeroing())
+		clear_user_highpage(&folio->page, vaddr);
+
+	return folio;
 }
 #endif
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c39c4945946c..6c853b0c4f91 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -31,6 +31,7 @@
 #include <linux/kasan.h>
 #include <linux/memremap.h>
 #include <linux/slab.h>
+#include <linux/cacheinfo.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -4175,6 +4176,23 @@ static inline int do_mseal(unsigned long start, size_t len_in, unsigned long fla
 }
 #endif
 
+/*
+ * user_alloc_needs_zeroing checks if a user folio from page allocator needs to
+ * be zeroed or not.
+ */
+static inline bool user_alloc_needs_zeroing(void)
+{
+	/*
+	 * for user folios, arch with cache aliasing requires cache flush and
+	 * arc changes folio->flags to make icache coherent with dcache, so
+	 * always return false to make caller use
+	 * clear_user_page()/clear_user_highpage().
+	 */
+	return cpu_dcache_is_aliasing() || cpu_icache_is_aliasing() ||
+	       !static_branch_maybe(CONFIG_INIT_ON_ALLOC_DEFAULT_ON,
+				   &init_on_alloc);
+}
+
 int arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *status);
 int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status);
 int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ee335d96fc39..9bb351caa619 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1176,11 +1176,12 @@ static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
 	folio_throttle_swaprate(folio, gfp);
 
        /*
-	* When a folio is not zeroed during allocation (__GFP_ZERO not used),
-	* folio_zero_user() is used to make sure that the page corresponding
-	* to the faulting address will be hot in the cache after zeroing.
+	* When a folio is not zeroed during allocation (__GFP_ZERO not used)
+	* or user folios require special handling, folio_zero_user() is used to
+	* make sure that the page corresponding to the faulting address will be
+	* hot in the cache after zeroing.
 	*/
-	if (!alloc_zeroed())
+	if (user_alloc_needs_zeroing())
 		folio_zero_user(folio, addr);
 	/*
 	 * The memory barrier inside __folio_mark_uptodate makes sure that
diff --git a/mm/internal.h b/mm/internal.h
index cb8d8e8e3ffa..3bd08bafad04 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1285,12 +1285,6 @@ void touch_pud(struct vm_area_struct *vma, unsigned long addr,
 void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
 	       pmd_t *pmd, bool write);
 
-static inline bool alloc_zeroed(void)
-{
-	return static_branch_maybe(CONFIG_INIT_ON_ALLOC_DEFAULT_ON,
-			&init_on_alloc);
-}
-
 /*
  * Parses a string with mem suffixes into its order. Useful to parse kernel
  * parameters.
diff --git a/mm/memory.c b/mm/memory.c
index 75c2dfd04f72..da8b2e8ab796 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4733,12 +4733,12 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 			folio_throttle_swaprate(folio, gfp);
 			/*
 			 * When a folio is not zeroed during allocation
-			 * (__GFP_ZERO not used), folio_zero_user() is used
-			 * to make sure that the page corresponding to the
-			 * faulting address will be hot in the cache after
-			 * zeroing.
+			 * (__GFP_ZERO not used) or user folios require special
+			 * handling, folio_zero_user() is used to make sure
+			 * that the page corresponding to the faulting address
+			 * will be hot in the cache after zeroing.
 			 */
-			if (!alloc_zeroed())
+			if (user_alloc_needs_zeroing())
 				folio_zero_user(folio, vmf->address);
 			return folio;
 		}
-- 
2.45.2


