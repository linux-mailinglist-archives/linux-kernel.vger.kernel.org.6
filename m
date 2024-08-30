Return-Path: <linux-kernel+bounces-308723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3729660E4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C177C1F25872
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9609190074;
	Fri, 30 Aug 2024 11:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="qRKCeAKq"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2068.outbound.protection.outlook.com [40.107.255.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF9F17BB0C
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 11:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725018012; cv=fail; b=sVS/3gt5nnXbQZzaTWJQS6wik7ihdJAUu7fV7t1esnKO54tf8lpER2Q50+1s+6xHrBhsr+qIw0pObeHPfEzmUgCGUrkry5s7CK7Me6ayu5VIeH9IdZSQrSeRqR1mE7Pozkeq0SX1U4E06B1QUTMT8KWWNjv2D+m0HvsBp0FlVL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725018012; c=relaxed/simple;
	bh=O2EijELpI8uguc4RQ3xnuwkz9ozygpVeLekfFdga8yo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JB8cOBN1aJfZRfhtHYEox+/OwwOCBZ/X6RHXpgxTh46ND71W44C2xDGxSKVySX/955/IBVYi5TkUs0MolR4pWyKxzjypw+BLUt/VIop8oncehtdkBk285ipKISi3ciXTeXKZNP3sLGwWH0P7RRa/VNX3FShQIUrI8OjgSR2ZkEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=qRKCeAKq; arc=fail smtp.client-ip=40.107.255.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fncxkJT8Qoc4Co83sJlXOH4xZbeU0q+Wz7yDNAMJ/NnhV8hFbjG18k8Er4xSRrhOfvGnIH3WGDRDJVMw5i2E8dvg4XrnyUWgA5c1qcfdtseTlwF6Wddv6oCR4r7R3hF8KlMMb4rQTUUBQrIswo2k2Wq5+L6am0+aRCTU9w9G/dTUinpU2Q42cNqxlyGg1ch4bIwVPRNSeMSzNyJNqr1Y+yJKs/ooTvi+ZDW8gTdxQqNI1Ef8tfvhRAobfM7lHBdk8hM/vn9oD2xmR5PkT3nhnNEZwHlPl42hPeKJPDz22MGUiFaBuXBFvdQjALeuv5CP7CM2jDCIzsiiC0DKKPnMQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTa84qFUhH6TIbpbH/KZRjiQgDWvuNe9omEg8s75/JE=;
 b=fhQEN+vV2YGqcaf6vK/JnLDxvDWH1FKdnwInee+JrvsLK7S8MLNA1Ere3+uI2IaNsQPd1qRlLMkZX4utZBtO4p4kZTBaZI4a0N52rNw9+fTWtAIeTdbG6eUPZk9WhU2vZsTdY8gqQe3RW2vKysGEKAjuUY/uYsArW3W9WvNAWYjtCXbBsVM4l60TYCcq2katusSMf346Yf7gBOMGwPC0syd/y1RS6xEWUr2OFSAx+dqJFkStpt2bHFiczno0JMN4p6ZFoGFPsFYwDEpPTXXV2iEhjSzlFsOVgT/KYSyhdE/gVQXp8QtsAInZxTSV2cgzqfjkl4wwbGHvDc56BTr53g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTa84qFUhH6TIbpbH/KZRjiQgDWvuNe9omEg8s75/JE=;
 b=qRKCeAKq3tkdYamktF35uQxITyiIko18ptXy7GrXLsaWdQSp7C8MTsV6FBMsQYyRMoUwwNiBVazQpYcI10jtQkTbp0jR/XcEAXYpKwofQtZW9S2lc8WYnDpYCtS4YdtlohRfJfS8j6XR+VP1ckzrmizW+ZToG6qy5asyC3TAGPok7XDwYvUs46OfYoZE8/Ew5ZTcYGshS8c5wlKwgSbZxRUS77KLiqPfcjMBezdThcVMXpxQ2BT2brA37g6XNiSH6LfvxGWadI9NN8tlToPxahaYvokCxsSmEB/1HJvKjsHWpogaILtBU7MUo7slJi3WjaCkvyAQlOxMiEZjwZkohA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by TYSPR06MB6898.apcprd06.prod.outlook.com (2603:1096:400:468::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Fri, 30 Aug
 2024 11:40:07 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 11:40:06 +0000
From: Zhiguo Jiang <justinjiang@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH] mm: fix vmalloc memcg accounting issue
Date: Fri, 30 Aug 2024 19:39:56 +0800
Message-ID: <20240830113956.1355-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::9)
 To JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|TYSPR06MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: 83561913-239d-42c6-aadc-08dcc8e87e91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gf65yrE6UmzP3o7jyQxrpijmWfYrcNQ5//e/TARaDkYh07kRJEpiaxUepUBz?=
 =?us-ascii?Q?8zoCZe8Kc64002qsRDTNBwglNANYgnlSCENhIHZQMhr4bBZ1kIWJTx0h1it1?=
 =?us-ascii?Q?+DA5nAv2Ia+zDawC7cHSgMpHP5SEOhbzPSpAo4+yQqvlfs+gmNpqb2BOGIec?=
 =?us-ascii?Q?yISct/m39o7IvE25YvqsO2SJ2r5hXP3MnDz3cnanCYn7196R3TnKThtXIEvf?=
 =?us-ascii?Q?RpzpxC7pZqUNpbd/2wDi555qxJM+Pvfoel0aJ7v8s2stux14HPNTsBFOj81H?=
 =?us-ascii?Q?WT9WZyzsoVh8/Zega1E8q9XBIxZvl3AtZXpZql7rvNB75GOMMZoiEBDU7cvo?=
 =?us-ascii?Q?hroVpUFJ2kXGsPIDwqMi076laRI+/Hr59cCAlOhFr+Oww+7w6kVypWDyv2N4?=
 =?us-ascii?Q?44q6AGJCXGlvWKeK4GbdaJkCFY4jrBAgNBlpWwmbMk0rArwORgGCnnFgQvtz?=
 =?us-ascii?Q?QXLwgqMWZ1uVc9yLKK2SBjY9T15Z5TQ3R/6PpjRZRizLZbODtBSvcUUsYKK0?=
 =?us-ascii?Q?4RHY5KE0sQWzGhyH92mRQ6382sur2yn3C3Nk2z/xyQfllR1L+KtmSeORVe3w?=
 =?us-ascii?Q?iGOC+9sNNb58uW7ih1KDvvrzbgEycBGsl+21CierjES77W/CBit/7DVV+vh2?=
 =?us-ascii?Q?O2vpxUOdRyKiO2eBJBmRHQOnYtkzVJiM6PKcV1Mxr7pFwu3Ye7bBw4dTT4eh?=
 =?us-ascii?Q?6TowfvYVHSpZaONXrxuCCBydCpLWDiVXnSqk60CKQ38cw4bFrHvuGw6UdhbH?=
 =?us-ascii?Q?2u6c0/KjZsWiz91Bb909dJSybcYWLc2bNRjhzNtgXJ560CNte9B1qncosLdH?=
 =?us-ascii?Q?hmDz/EKWS56TFyYzRzoYjAsccVbbRWdEi5cmhdmQ+WPEVMvq4vVG9HNBFOjp?=
 =?us-ascii?Q?WwGFlBfOmwwOfLpYle8w8eBrrjIp93OBD6pQmZyDoz4KAONRDias0lXJtuN3?=
 =?us-ascii?Q?cGOzuSxREis5Z6n8orPIP16dBq/qAuWMDdPniXPKl4Bbv9FMUuZfPoPfi1LN?=
 =?us-ascii?Q?5nlCpf2W0K0vA1gKxf53/Mo9dBaE8k2sOiaVHHxe6AMaJJ/8QP1jehEN1kgV?=
 =?us-ascii?Q?AcbrikMrHntVSN1pNnWf8gFasCrlMI1hBDMkYd+gpO8tFQsIxoZPT8/rTuG1?=
 =?us-ascii?Q?CKM//mIauo3VRTjQOjQ8vTxZ+OMPNfbkePuUvUHR1X8pcsuI+J3oAQq1RjOx?=
 =?us-ascii?Q?E2rXevT63vBr3AVTXvioT89K66o20zvkgChFwVLL8bGspcdngTQ7GrSDEm0r?=
 =?us-ascii?Q?tj1kwn8AznTjGTrBhwe4CJUeVqGC7k73Gh6CPyGBp3Qxge3rD3Cxe4hIsEGp?=
 =?us-ascii?Q?C0RrGAreuacMlnNsptWk7aAE4sMw5POwm7+X7j68AAzvr0/UwDIb5zAR6Fo0?=
 =?us-ascii?Q?o3alU5g5//sLWCxX323ckruMxNEu/H8RYeDWoLNJ8u/6vGOIlQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5wE1tN9+Pi/IbeWO+rZdrwhi4/HrBbS/045GOW24QTPDsRpsXFTUhcadYe67?=
 =?us-ascii?Q?go7Q95FOjm9AD2R1fLjzh8sCrojX0CtxoSoqEkp1jcgdMs9bvR8cZRRCWc8b?=
 =?us-ascii?Q?+hxsEs4POV43r4mTcFu596LmeamGBbc3QcDyMQpBvrgLfUxpB6bKCN+H5Tcm?=
 =?us-ascii?Q?tGmGw69deP/NJ7V9bYgts9WW8pEDMSIZABPbvzjKmfQJpk/oR9Nh191q9zuq?=
 =?us-ascii?Q?W1Wfeoo2UsWGTALMJsvSfux0WmvcvMoJM0U2KHdGdBYYxm16yDuwvNv2Rqo9?=
 =?us-ascii?Q?QKEireK8LrDEHtdULyFrS/6K3Mg7POR2+VcHeJJWeYFRVUYsuHoLvkLN/4+L?=
 =?us-ascii?Q?o8nJhfB4Z/IzXjdA+fanjjbIHEYlvnjRkzyqvZwVUJHbza6dalzKIOUayAV+?=
 =?us-ascii?Q?kvlZQgvRMg76LRZ5QYS9eGEYjEU88SbRIvMQHOCJj0RRiJ0Z9+m2CQIYclnm?=
 =?us-ascii?Q?c056QDy0nqR9FOyDitRFmxrvDfhMBbq6umu9/INJRYkAy8MLjfotKpZAq4TO?=
 =?us-ascii?Q?h42dS68HIbkqrJPMuaF9TRSYT6wXYPFSQjFI/HibeIJReonltg183oa2WK5B?=
 =?us-ascii?Q?vXBdJfLMpZSPit2ca8A6lguqRi+O+qxTgY7bvIaiX6Di+1tLQTSZAt6M9d+1?=
 =?us-ascii?Q?OJxQ6fKC5OzVOSLuldjQUypqJb84EPbi3qH7v7XerIz4IJYSzje5/k0pZ/ha?=
 =?us-ascii?Q?GfZaixzjtvlvrXNGfoB2jYSK7AD+dwz/PLM5HYm4sZNew4e3tRjra7sV7+Bd?=
 =?us-ascii?Q?ughbMTDW3JtGsOxL/y4scCMsgcVVjt0W141BMZVYso4m6QT48B2Ice4i/hFM?=
 =?us-ascii?Q?4EYkDECnRViWtIEvKL7CioYWqHxczoRv1cqhW2t9DtRo5ZhwUg4ikJb8OXlA?=
 =?us-ascii?Q?MzaOEB+Cs+umtCTVXo1NzI8lU3gfrk3jo2Pc684tGX1CTNDbgOBXDj0yHDea?=
 =?us-ascii?Q?/mkk69mgTL1AGIRp8SA8N633Ei1G+hDB2Ux+i40Ojrel7BDBGzijZF1UQpNc?=
 =?us-ascii?Q?/nx2HJF4gW7Ua3b1y4ABqf7HErkpzArOrA3LG8JbbArXVVlM9kW30BigDMGZ?=
 =?us-ascii?Q?0L5Co5pmk53ag2bMD4dGs9L8UFR2Gmq5YF0rNjsEOG3OmDSrKAsI1ieIpIlZ?=
 =?us-ascii?Q?txmqT/9PxqbUAvlNSUaZMoDc8jJJbww5WRtXmojq9cyEW2tAhkNls03cQ/sh?=
 =?us-ascii?Q?IWXgnY9V7Wf8ck+gHxawCamB5aaQYxR2F8mA2h62y5xAO2YsvCooTXl3VX15?=
 =?us-ascii?Q?ZnkXAuhJIXEACBdtPHFFLWP1/HCoDzX475sLHcsq90VTZ7/BRPQ+NLkXSv3s?=
 =?us-ascii?Q?52GfEmNkl42hU/8o9ZtNIHVaiP3EW1bVq7jl38MY6vkdQoC8sXi9jUWAeEgG?=
 =?us-ascii?Q?43cnCPGPys0fdQwI6rAZMJhFO8cPBXZG5/vQJHLuuQb4ZxrYiazctwLeIA8M?=
 =?us-ascii?Q?k5tDy9j3/mMZClFluBuO4aqCSqpfKESQZOIMowV85v5uEmBeeDoRVf9jX4wI?=
 =?us-ascii?Q?WvgTjLR730U2E6AvEe970NiiItN9quP3rjN+sskZn+Tk+7MInZqoZjTXmh+F?=
 =?us-ascii?Q?b+cILanhIqHEw7VCuwdqJw0E6Nb/zv5g06sSTpWU?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83561913-239d-42c6-aadc-08dcc8e87e91
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 11:40:06.2281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PLM25dY4qVwV7OK0ekGqVg3djFF6SiMztgNAWhpt6DDR5vsQYWefGgDY8h4SzN2VIVaGpbDos/dsTNhEr8S1Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6898

The oepration of adding 1 for the MEMCG_VMALLOC count value has a
judgment "if (gfp_mask & __GFP_ACCOUNT)" in vmalloc(), but subtracting
1 does not have this judgment in vfree(), which leads to the non-aligned
count value operation. This patch fixes this issue.

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---
 include/linux/vmalloc.h |  1 +
 mm/vmalloc.c            | 13 ++++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index ad2ce7a6ab7a..0253feec371f
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -38,6 +38,7 @@ struct iov_iter;		/* in uio.h */
 #define VM_DEFER_KMEMLEAK	0
 #endif
 #define VM_SPARSE		0x00001000	/* sparse vm_area. not all pages are present. */
+#define VM_MEMCG_ACCOUNT	0x00002000	/* mark vm pages alloced with __GFP_ACCOUNT for memcg accounting. */
 
 /* bits [20..32] reserved for arch specific ioremap internals */
 
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d977c280b1c4..aff1bf7a8798
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3125,6 +3125,12 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
 		size += PAGE_SIZE;
 
 	area->flags = flags;
+	/*
+	 * Set memcg accounting flag in vm_struct, used for
+	 * vfree() align vmalloc here.
+	 */
+	if (gfp_mask & __GFP_ACCOUNT)
+		area->flags |= VM_MEMCG_ACCOUNT;
 	area->caller = caller;
 
 	va = alloc_vmap_area(size, align, start, end, node, gfp_mask, 0, area);
@@ -3367,7 +3373,9 @@ void vfree(const void *addr)
 		struct page *page = vm->pages[i];
 
 		BUG_ON(!page);
-		mod_memcg_page_state(page, MEMCG_VMALLOC, -1);
+
+		if (vm->flags & VM_MEMCG_ACCOUNT)
+			mod_memcg_page_state(page, MEMCG_VMALLOC, -1);
 		/*
 		 * High-order allocs for huge vmallocs are split, so
 		 * can be freed as an array of order-0 allocations
@@ -3662,7 +3670,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 		node, page_order, nr_small_pages, area->pages);
 
 	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
-	if (gfp_mask & __GFP_ACCOUNT) {
+	if (area->flags & VM_MEMCG_ACCOUNT) {
 		int i;
 
 		for (i = 0; i < area->nr_pages; i++)
@@ -3813,7 +3821,6 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 		}
 		goto fail;
 	}
-
 	/*
 	 * Prepare arguments for __vmalloc_area_node() and
 	 * kasan_unpoison_vmalloc().
-- 
2.39.0


