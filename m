Return-Path: <linux-kernel+bounces-261724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B263E93BB56
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 05:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C8372859F5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 03:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EF917BAF;
	Thu, 25 Jul 2024 03:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="wSiUlbpE"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2056.outbound.protection.outlook.com [40.107.255.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A135112B72
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 03:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721879627; cv=fail; b=OCF4ll30ToEpirybEyfFRFtAHOoPCz9M+LO6lngXzvWMkfPkaHn/I4BGHzjtykUDlVmdG1dmYpwZuQaUJgjghLUadu7PAwPwVzd9NnX+rbSmOnJ3Mlh7o86w1DxioQjwIhFlmpRK9fuFn5Abv8/WYB+BpVSVqa0N25dftBUYgt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721879627; c=relaxed/simple;
	bh=WW1DU5lbaeG0FmIjIYbxP79nejqpBH6H71+5CP0xCUU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GT/p0yiuBQ8dP4AkZaDDOtbqw+0yUtiKWwqf0aIumSy2KpZdItudRjctZUUBCqDrd48DvNidwCzphbSe8mhAw72HEYli4lxrATEHqRzx/SFrbR3AT7vUU/lUyvUlf8jsl6f8i1Hz6f/BH8aKEbs+R/dWTKTF1HaPlrtdnc1+itQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=wSiUlbpE; arc=fail smtp.client-ip=40.107.255.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RxbW38cibKc06RAVvM60ifKPyAff78tECCNtr4tdABsru8PwpHh1mTDiXfh1qDB8J/gIYX+ZIa1pe0YpLSDs+vu1nf4hCH4TTUr9KRjjXj79dL4PLNV+8gSPHbam24KJo/QjPbk2VAPTS2RDOIlsjJAbwcNXQV++5tl40TsPaR+pJ6LklA9O6ex9rGS8g3LtDETTWaGcTo9Q+48tqfNQxyUr8VTbJej3q3E3aDRlTnZp+iMqoP7+RsJj9AU27obC3Wvf7Vam54/dB+xeHE/B/prFCGcLz4mH5Ymo9dNaRwAB+MYcEtczRUf+qAgrGGcA1TV2mqM7pMBSTEl2dvIRuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmnIhMzJ44mVfaOUTSFbb1BP8k4pmqbGQeixeOFAlHE=;
 b=ovLmrsW4QcjhuG0fMedlvZHVLFhQXQZgx+gMjT8MkC8xLxtO6vFgvLiUUuluaDmu2wfZLuFgYZPBrCJvbEyxCxCOrvtefdAS7YAGrPRaSrG8G1DZkhN2qOCtVfO9pN/HIZumjS92KnR9MTQCZ6cQJixtuRe/ImZZM0B9OIhtR+pAQV6nRV/+8ykg1RDtMTP3dMECrLq7ITuHnBiwlL7ddIXtZn52a0mNkn5qUe7L8nTG2zcdiABLGzJ3q5X0VwmqTKPzUEAeUUBAgcQmFFHATW7/gHTF+1M+GzKJSXpJhDc5phyoqXLyQ/yG7sbDWEZCh1Fk6sST6rziJtZVTl6R/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=oppo.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=oppo.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmnIhMzJ44mVfaOUTSFbb1BP8k4pmqbGQeixeOFAlHE=;
 b=wSiUlbpESf1Uta+T68LKHx/u1Ln9N5ySEBN2IfAwxS+uh155CLITiSw4G6x0rPVmZGu7B0zaZvwQNckX9yRUs0/+HfxLQmkYbEW+t55XiPgwaue4Uf37anqDpi09kq9sBneiKXS9VlVaYzckiLRH5R8AGLynT1plmG2aYx/+OWc=
Received: from KL1PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:820::20) by SEYPR02MB7175.apcprd02.prod.outlook.com
 (2603:1096:101:1a8::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Thu, 25 Jul
 2024 03:53:39 +0000
Received: from HK2PEPF00006FB3.apcprd02.prod.outlook.com
 (2603:1096:820:0:cafe::29) by KL1PR01CA0008.outlook.office365.com
 (2603:1096:820::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28 via Frontend
 Transport; Thu, 25 Jul 2024 03:53:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK2PEPF00006FB3.mail.protection.outlook.com (10.167.8.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 03:53:38 +0000
Received: from PH80250894.adc.com (172.16.40.118) by mailappw31.adc.com
 (172.16.56.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 11:53:37 +0800
From: <hailong.liu@oppo.com>
To: Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki
	<urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes
	<lstoakes@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko
	<mhocko@suse.com>
CC: Hailong.Liu <hailong.liu@oppo.com>, Barry Song <21cnbao@gmail.com>,
	Baoquan He <bhe@redhat.com>, Matthew Wilcox <willy@infradead.org>, "Tangquan
 . Zheng" <zhengtangquan@oppo.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v2] mm/vmalloc: fix incorrect __vmap_pages_range_noflush() if vm_area_alloc_pages() from high order fallback to order0
Date: Thu, 25 Jul 2024 11:53:15 +0800
Message-ID: <20240725035318.471-1-hailong.liu@oppo.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mailappw30.adc.com (172.16.56.197) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB3:EE_|SEYPR02MB7175:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bfd25cc-4ff3-4112-8253-08dcac5d5dfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VhfRYumsqorIgQkA9CrDCJoodQWJ+BTlN3Hkq1IbksvuMaUfAENQZObq3WGh?=
 =?us-ascii?Q?K1SScUYxBLexu5kkKFCTIJ1P2Qs8vDedGARg3Bxn12TNpDkWNS0S0Sqd7avZ?=
 =?us-ascii?Q?JmxYW7Frh9RIsvz5fTAU2kGxShZ4iIZQ5lhHELhy6n9TrmacF2k4Mvgf4zsu?=
 =?us-ascii?Q?CLtA6MJ0olEZYluK/wRGu0vcLINjs48NlxYZAOoOdkXP2513gl/im7mv2C9r?=
 =?us-ascii?Q?IrY1AAzXwvGvr9Vig5MLvQyY/K0DmU+ZQI/s8gcKg16MNmazRC+IFIPg1Z3Y?=
 =?us-ascii?Q?z+1nES3OgZAIMg8/tTOTbS8rwG9HVRMmNMRYhKhapBGfNUwRdM4KYZ5CC1vE?=
 =?us-ascii?Q?/pbmqTYaTP9ODsJ2AUpbAxC/qLghOojOy44x+JIbRsynhVbqcnTQ1pq93ZDJ?=
 =?us-ascii?Q?O0xBiKBvbKSiUWWDdCFMkwbykacJQ7AJ1ubjFk63d55LKB3mwGuSMLDbueF1?=
 =?us-ascii?Q?txo7FzqtvzghazqJnjonqp8rALZiwXaFj8VIUWYseD6s7DCSYschJfyHGwR/?=
 =?us-ascii?Q?ezvCK60/wmFd7/UTLhcg5ww1i1ojl8RrQhoaRn7P2v1Xs2yVQm74JV8K153J?=
 =?us-ascii?Q?g2IWApPayRm90LLd0+ROy/5b8ErW9tod3hBzRhG6AH+hmczQLdbg0l7C4CzC?=
 =?us-ascii?Q?zcChwJrR0x+TRtzvjTy6w3OqdjpLNDJEcldx0qde9wKcC38xI25shXKUYLKA?=
 =?us-ascii?Q?yr6pctNRKeb8BGYHPDuamEGbnqyhSy5b9VYz05bghK7irB7FeDMPI9b+rIuQ?=
 =?us-ascii?Q?gJUE5cYpJgmRhvIte3cXr2WLkcrBtiP6Ujw9AbunrkZAyzivi+0X8EHddf2Q?=
 =?us-ascii?Q?IddRIMhlIJxVlakc3xthFQdyaMcHFqeGbTWC3wph4/N4000/a68EyyBQa16n?=
 =?us-ascii?Q?eMEm6jK5Dt/u4hSfY4kXg0EbviJEKztKbYCfbNMtXM3lvzSJLVQB9+9ZzHMl?=
 =?us-ascii?Q?D9sDYl3ZAzrieyPuOtQUHtBg7LdHzlJwfYYNzvRQ+m7d6RXq82ysVRKI89/U?=
 =?us-ascii?Q?6bA+qBhqcGqRhdrC2GMdLg86H2pIiR3rWAjD6tSQk7Mf0oflpYJG0hb+LYdG?=
 =?us-ascii?Q?/QqkkrUvcGsfRmdCkIvqeJEECxlrLHUQQKL9c4NYCLQjeYmGc7cRtlr0WyTX?=
 =?us-ascii?Q?V4ZA020eLShE196AU+aGFL+cNFRQpsqwMz9AAFEFokTaepIvK6/ZHvbKZoWT?=
 =?us-ascii?Q?SghXlNbHPbkvckC2eGVeS/Zy1O+daMd/leo60s9iA1BQa15eSZtPeQI38wC/?=
 =?us-ascii?Q?iWwnRrxdyHE/bwrSAbHqoqFWi0cnqPkU0n/loE/PLvqmn+pa1vuEhCLn4FFO?=
 =?us-ascii?Q?sY/apbZYLvgg5ovYbJAs35aSN0hCmu/pN4dfdReP9cF0F0p9mahmbk48T7LH?=
 =?us-ascii?Q?I6QRcOCTvkXBmmObPSwma4bxpwlh2SGZwEKl7dFUvi+zZw3wHQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 03:53:38.6814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bfd25cc-4ff3-4112-8253-08dcac5d5dfc
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB3.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB7175

From: "Hailong.Liu" <hailong.liu@oppo.com>

The scenario where the issue occurs is as follows:
CONFIG: vmap_allow_huge = true && 2M is for PMD_SIZE
kvmalloc(2M, __GFP_NOFAIL|GFP_XXX)
    __vmalloc_node_range(vm_flags=VM_ALLOW_HUGE_VMAP)
        vm_area_alloc_pages(order=9) --->allocs order9 failed and fallback to order0
                                        and phys_addr is aligned with PMD_SIZE
            vmap_pages_range
                vmap_pages_range_noflush
                    __vmap_pages_range_noflush(page_shift = 21) ----> incorrect vmap *huge* here

In fact, as long as page_shift is not equal to PAGE_SHIFT, there
might be issues with the __vmap_pages_range_noflush().

The patch also remove VM_ALLOW_HUGE_VMAP in kvmalloc_node(), There
are several reasons for this:
- This increases memory footprint because ALIGNMENT.
- This increases the likelihood of kvmalloc allocation failures.
- Without this it fixes the origin issue of kvmalloc with __GFP_NOFAIL may return NULL.
Besides if drivers want to vmap huge, user vmalloc_huge instead.

Fix it by disabling fallback and remove VM_ALLOW_HUGE_VMAP in
kvmalloc_node().
Fixes: e9c3cda4d86e ("mm, vmalloc: fix high order __GFP_NOFAIL allocations")

CC: Barry Song <21cnbao@gmail.com>
CC: Baoquan He <bhe@redhat.com>
CC: Matthew Wilcox <willy@infradead.org>
Reported-by: Tangquan.Zheng <zhengtangquan@oppo.com>
Signed-off-by: Hailong.Liu <hailong.liu@oppo.com>
---
 mm/util.c    | 2 +-
 mm/vmalloc.c | 9 ---------
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/mm/util.c b/mm/util.c
index 669397235787..b23133b738cf 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -657,7 +657,7 @@ void *kvmalloc_node(size_t size, gfp_t flags, int node)
 	 * protection games.
 	 */
 	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
-			flags, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
+			flags, PAGE_KERNEL, 0,
 			node, __builtin_return_address(0));
 }
 EXPORT_SYMBOL(kvmalloc_node);
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 03c78fae06f3..1914768f473e 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3577,15 +3577,6 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 			page = alloc_pages(alloc_gfp, order);
 		else
 			page = alloc_pages_node(nid, alloc_gfp, order);
-		if (unlikely(!page)) {
-			if (!nofail)
-				break;
-
-			/* fall back to the zero order allocations */
-			alloc_gfp |= __GFP_NOFAIL;
-			order = 0;
-			continue;
-		}

 		/*
 		 * Higher order allocations must be able to be treated as
--
After 1) I check the code and I can't find a resonable band-aid to fix
this. so the v2 patch works but ugly. Glad to hear a better solution :)

[1] https://lore.kernel.org/lkml/20240724182827.nlgdckimtg2gwns5@oppo.com/
2.34.1

