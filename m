Return-Path: <linux-kernel+bounces-520072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7C6A3A538
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FEBD7A3BE5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969252356CF;
	Tue, 18 Feb 2025 18:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LhUPCnPs"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F0A28136F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902672; cv=none; b=crrJ9CvSGX8euuWmad9AnmRUy/hLU//qyl+7TmdMqcOVKT1qGLFxTBeYtb5yC1Txr7/yyAvMlAaR34JJSQK6tYcclNwQBTaAkkYfDf541i8cUyqzd/JGayqA/WVZi8cLCZlFgqZvnfNMcO+heemEiKKpi4ND7+l1Eb/Hyn/feYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902672; c=relaxed/simple;
	bh=ao/gd4mf5VuuSFaintAKW1qTfRFlCHtLF7rrBH/79Vs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=quKLBkFn/bLb1nss1Cpx4+X9w2KddnXQgCfl6/zBAi9urBWpamM8mLqeSlVORV/djsKHn77v5Uuc1IUtL1K1crcLNonbiEMPjiL5Tkzm+5lySOuoiat27XalGAuWiJO1rY8zf1W7Ia+EDjT9Bz5VWutVapL3x3TCPkAG9rn6NPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LhUPCnPs; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fbfa786a1aso18031685a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739902669; x=1740507469; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m8CyknMDJjzJrkTVy6IkcSYTmou3FMAB5Va5stB7LNQ=;
        b=LhUPCnPsgYFHajiu7Cdi65MZUGzY0SoWGsBCcPIM3QjzBajbpsiAkxV9d6XNHSyQTD
         RhFa05dcmbRHRqvGInZjeYaMArmutCVO0DRMV3okPtc9EBgHDs2MU2FTglZdODlpGzUL
         wV5iq3t6q0cajsni3XxmoiQPqG3lCq7q1ApLHka+JARskY2yDWTMfo2YlEnuy7deDMks
         JRduG2xqFwgAuzkTwbSMkOjRXeQvekCpvmx1n/YzIyS0yXN9PdCCh+W+QRcBi/Dq/ZLx
         UEtFWOghsAEQ4LdPuvgkrMajCCM5eX5tJez8RTw38VAt3LEr6j+a7ZC2vB9NkZu4xmqW
         Ljaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739902669; x=1740507469;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m8CyknMDJjzJrkTVy6IkcSYTmou3FMAB5Va5stB7LNQ=;
        b=keRm8t9xl4bAJh8S1P6mOcLyJZgI0IThV7fFt8svER4d/PKPKFPxTxJhIGZvKZZ2pX
         XTWWzmmIOg6kjFtSO2uHXngNqQSkbfiknK00toam2I3C03mfQbWUW6auIVwTt4p453EQ
         rLF8sKa09yYS1zJWLQ9BLomO2/9sW5IlD57ZOF5Gg403KjN4JZFOYa8Z31l2KPOBB2x7
         dR2L/M5UBz9Y0kmnuu9GqTYk+6jsYTpOHzoL6e0jyjVhi4EbD0bMOfCce2KgmCfZjVmN
         OOzI5luN0Rz/KO+jislihYWccQ54ZRMmR/Mfq9yc8xqAuBgtSUBFKu95UoKJsDXWBqPD
         1g4A==
X-Forwarded-Encrypted: i=1; AJvYcCUhziLhKP5h7hgdMIxT85aQsbZqjCcofKZswNp2/pTsnd/JNz0ivSIKhXDgHg6KthFptHAqd5Z0OXOhiHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqzBdBuQsmp6Z+LWvDFmMwypY0dmcKnjecAkVXcxKSmfq+srrl
	agTzZFrHG2T1Ak7Uj4F3dbLX2qawK5G/ThAeWXhtKGuuOgOYlAIU/JPL2bB/cQk72pxpCw==
X-Google-Smtp-Source: AGHT+IHXMpw6FIP/L3jEDwREl+IdX5acSAi6rD8V1X1Cno/4U0esuOK2FJGg9O734CFyoJuWToI/XP0C
X-Received: from pfbgd3.prod.google.com ([2002:a05:6a00:8303:b0:730:8c7f:979])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1707:b0:732:5276:4ac5
 with SMTP id d2e1a72fcca58-7326179975emr22919412b3a.9.1739902669132; Tue, 18
 Feb 2025 10:17:49 -0800 (PST)
Date: Tue, 18 Feb 2025 18:16:55 +0000
In-Reply-To: <20250218181656.207178-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250218181656.207178-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250218181656.207178-28-fvdl@google.com>
Subject: [PATCH v4 27/27] mm/hugetlb: move hugetlb CMA code in to its own file
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"

hugetlb.c contained a number of CONFIG_CMA ifdefs, and
the code inside them was large enough to merit being in
its own file, so move it, cleaning up things a bit.

Hide some direct variable access behind functions to
accommodate the move.

No functional change intended.

Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 MAINTAINERS      |   2 +
 mm/Makefile      |   3 +
 mm/hugetlb.c     | 269 +++------------------------------------------
 mm/hugetlb_cma.c | 275 +++++++++++++++++++++++++++++++++++++++++++++++
 mm/hugetlb_cma.h |  57 ++++++++++
 5 files changed, 354 insertions(+), 252 deletions(-)
 create mode 100644 mm/hugetlb_cma.c
 create mode 100644 mm/hugetlb_cma.h

diff --git a/MAINTAINERS b/MAINTAINERS
index efee40ea589f..04edbbfcb467 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10702,6 +10702,8 @@ F:	fs/hugetlbfs/
 F:	include/linux/hugetlb.h
 F:	include/trace/events/hugetlbfs.h
 F:	mm/hugetlb.c
+F:	mm/hugetlb_cma.c
+F:	mm/hugetlb_cma.h
 F:	mm/hugetlb_vmemmap.c
 F:	mm/hugetlb_vmemmap.h
 F:	tools/testing/selftests/cgroup/test_hugetlb_memcg.c
diff --git a/mm/Makefile b/mm/Makefile
index 850386a67b3e..810ccd45d270 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -79,6 +79,9 @@ obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o swap_slots.o
 obj-$(CONFIG_ZSWAP)	+= zswap.o
 obj-$(CONFIG_HAS_DMA)	+= dmapool.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
+ifdef CONFIG_CMA
+obj-$(CONFIG_HUGETLBFS)	+= hugetlb_cma.o
+endif
 obj-$(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP)	+= hugetlb_vmemmap.o
 obj-$(CONFIG_NUMA) 	+= mempolicy.o
 obj-$(CONFIG_SPARSEMEM)	+= sparse.o
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 664ccaaa717a..3ee98f612137 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -49,19 +49,13 @@
 #include <linux/page_owner.h>
 #include "internal.h"
 #include "hugetlb_vmemmap.h"
+#include "hugetlb_cma.h"
 #include <linux/page-isolation.h>
 
 int hugetlb_max_hstate __read_mostly;
 unsigned int default_hstate_idx;
 struct hstate hstates[HUGE_MAX_HSTATE];
 
-#ifdef CONFIG_CMA
-static struct cma *hugetlb_cma[MAX_NUMNODES];
-static unsigned long hugetlb_cma_size_in_node[MAX_NUMNODES] __initdata;
-#endif
-static bool hugetlb_cma_only;
-static unsigned long hugetlb_cma_size __initdata;
-
 __initdata struct list_head huge_boot_pages[MAX_NUMNODES];
 static unsigned long hstate_boot_nrinvalid[HUGE_MAX_HSTATE] __initdata;
 
@@ -128,14 +122,11 @@ static struct resv_map *vma_resv_map(struct vm_area_struct *vma);
 
 static void hugetlb_free_folio(struct folio *folio)
 {
-#ifdef CONFIG_CMA
-	int nid = folio_nid(folio);
-
 	if (folio_test_hugetlb_cma(folio)) {
-		WARN_ON_ONCE(!cma_free_folio(hugetlb_cma[nid], folio));
+		hugetlb_cma_free_folio(folio);
 		return;
 	}
-#endif
+
 	folio_put(folio);
 }
 
@@ -1492,31 +1483,9 @@ static struct folio *alloc_gigantic_folio(struct hstate *h, gfp_t gfp_mask,
 	if (nid == NUMA_NO_NODE)
 		nid = numa_mem_id();
 retry:
-	folio = NULL;
-#ifdef CONFIG_CMA
-	{
-		int node;
-
-		if (hugetlb_cma[nid])
-			folio = cma_alloc_folio(hugetlb_cma[nid], order, gfp_mask);
-
-		if (!folio && !(gfp_mask & __GFP_THISNODE)) {
-			for_each_node_mask(node, *nodemask) {
-				if (node == nid || !hugetlb_cma[node])
-					continue;
-
-				folio = cma_alloc_folio(hugetlb_cma[node], order, gfp_mask);
-				if (folio)
-					break;
-			}
-		}
-
-		if (folio)
-			folio_set_hugetlb_cma(folio);
-	}
-#endif
+	folio = hugetlb_cma_alloc_folio(h, gfp_mask, nid, nodemask);
 	if (!folio) {
-		if (hugetlb_cma_only)
+		if (hugetlb_cma_exclusive_alloc())
 			return NULL;
 
 		folio = folio_alloc_gigantic(order, gfp_mask, nid, nodemask);
@@ -3179,47 +3148,14 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	return ERR_PTR(-ENOSPC);
 }
 
-static bool __init hugetlb_early_cma(struct hstate *h)
-{
-	if (arch_has_huge_bootmem_alloc())
-		return false;
-
-	return (hstate_is_gigantic(h) && hugetlb_cma_only);
-}
-
 static __init void *alloc_bootmem(struct hstate *h, int nid, bool node_exact)
 {
 	struct huge_bootmem_page *m;
-	unsigned long flags;
-	struct cma *cma;
 	int listnode = nid;
 
-#ifdef CONFIG_CMA
-	if (hugetlb_early_cma(h)) {
-		flags = HUGE_BOOTMEM_CMA;
-		cma = hugetlb_cma[nid];
-		m = cma_reserve_early(cma, huge_page_size(h));
-		if (!m) {
-			int node;
-
-			if (node_exact)
-				return NULL;
-			for_each_online_node(node) {
-				cma = hugetlb_cma[node];
-				if (!cma || node == nid)
-					continue;
-				m = cma_reserve_early(cma, huge_page_size(h));
-				if (m) {
-					listnode = node;
-					break;
-				}
-			}
-		}
-	} else
-#endif
-	{
-		flags = 0;
-		cma = NULL;
+	if (hugetlb_early_cma(h))
+		m = hugetlb_cma_alloc_bootmem(h, &listnode, node_exact);
+	else {
 		if (node_exact)
 			m = memblock_alloc_exact_nid_raw(huge_page_size(h),
 				huge_page_size(h), 0,
@@ -3238,6 +3174,11 @@ static __init void *alloc_bootmem(struct hstate *h, int nid, bool node_exact)
 			if (m)
 				listnode = early_pfn_to_nid(PHYS_PFN(virt_to_phys(m)));
 		}
+
+		if (m) {
+			m->flags = 0;
+			m->cma = NULL;
+		}
 	}
 
 	if (m) {
@@ -3252,8 +3193,6 @@ static __init void *alloc_bootmem(struct hstate *h, int nid, bool node_exact)
 		INIT_LIST_HEAD(&m->list);
 		list_add(&m->list, &huge_boot_pages[listnode]);
 		m->hstate = h;
-		m->flags = flags;
-		m->cma = cma;
 	}
 
 	return m;
@@ -3703,7 +3642,8 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 	 * Skip gigantic hugepages allocation if early CMA
 	 * reservations are not available.
 	 */
-	if (hstate_is_gigantic(h) && hugetlb_cma_size && !hugetlb_early_cma(h)) {
+	if (hstate_is_gigantic(h) && hugetlb_cma_total_size() &&
+	    !hugetlb_early_cma(h)) {
 		pr_warn_once("HugeTLB: hugetlb_cma is enabled, skip boot time allocation\n");
 		return;
 	}
@@ -3740,7 +3680,7 @@ static void __init hugetlb_init_hstates(void)
 		 */
 		if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
 			continue;
-		if (hugetlb_cma_size && h->order <= HUGETLB_PAGE_ORDER)
+		if (hugetlb_cma_total_size() && h->order <= HUGETLB_PAGE_ORDER)
 			continue;
 		for_each_hstate(h2) {
 			if (h2 == h)
@@ -4642,14 +4582,6 @@ static void hugetlb_register_all_nodes(void) { }
 
 #endif
 
-#ifdef CONFIG_CMA
-static void __init hugetlb_cma_check(void);
-#else
-static inline __init void hugetlb_cma_check(void)
-{
-}
-#endif
-
 static void __init hugetlb_sysfs_init(void)
 {
 	struct hstate *h;
@@ -4833,8 +4765,7 @@ static __init void hugetlb_parse_params(void)
 		hcp->setup(hcp->val);
 	}
 
-	if (!hugetlb_cma_size)
-		hugetlb_cma_only = false;
+	hugetlb_cma_validate_params();
 }
 
 /*
@@ -7904,169 +7835,3 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
 	hugetlb_unshare_pmds(vma, ALIGN(vma->vm_start, PUD_SIZE),
 			ALIGN_DOWN(vma->vm_end, PUD_SIZE));
 }
-
-#ifdef CONFIG_CMA
-static bool cma_reserve_called __initdata;
-
-static int __init cmdline_parse_hugetlb_cma(char *p)
-{
-	int nid, count = 0;
-	unsigned long tmp;
-	char *s = p;
-
-	while (*s) {
-		if (sscanf(s, "%lu%n", &tmp, &count) != 1)
-			break;
-
-		if (s[count] == ':') {
-			if (tmp >= MAX_NUMNODES)
-				break;
-			nid = array_index_nospec(tmp, MAX_NUMNODES);
-
-			s += count + 1;
-			tmp = memparse(s, &s);
-			hugetlb_cma_size_in_node[nid] = tmp;
-			hugetlb_cma_size += tmp;
-
-			/*
-			 * Skip the separator if have one, otherwise
-			 * break the parsing.
-			 */
-			if (*s == ',')
-				s++;
-			else
-				break;
-		} else {
-			hugetlb_cma_size = memparse(p, &p);
-			break;
-		}
-	}
-
-	return 0;
-}
-
-early_param("hugetlb_cma", cmdline_parse_hugetlb_cma);
-
-static int __init cmdline_parse_hugetlb_cma_only(char *p)
-{
-	return kstrtobool(p, &hugetlb_cma_only);
-}
-
-early_param("hugetlb_cma_only", cmdline_parse_hugetlb_cma_only);
-
-void __init hugetlb_cma_reserve(int order)
-{
-	unsigned long size, reserved, per_node;
-	bool node_specific_cma_alloc = false;
-	int nid;
-
-	/*
-	 * HugeTLB CMA reservation is required for gigantic
-	 * huge pages which could not be allocated via the
-	 * page allocator. Just warn if there is any change
-	 * breaking this assumption.
-	 */
-	VM_WARN_ON(order <= MAX_PAGE_ORDER);
-	cma_reserve_called = true;
-
-	if (!hugetlb_cma_size)
-		return;
-
-	for (nid = 0; nid < MAX_NUMNODES; nid++) {
-		if (hugetlb_cma_size_in_node[nid] == 0)
-			continue;
-
-		if (!node_online(nid)) {
-			pr_warn("hugetlb_cma: invalid node %d specified\n", nid);
-			hugetlb_cma_size -= hugetlb_cma_size_in_node[nid];
-			hugetlb_cma_size_in_node[nid] = 0;
-			continue;
-		}
-
-		if (hugetlb_cma_size_in_node[nid] < (PAGE_SIZE << order)) {
-			pr_warn("hugetlb_cma: cma area of node %d should be at least %lu MiB\n",
-				nid, (PAGE_SIZE << order) / SZ_1M);
-			hugetlb_cma_size -= hugetlb_cma_size_in_node[nid];
-			hugetlb_cma_size_in_node[nid] = 0;
-		} else {
-			node_specific_cma_alloc = true;
-		}
-	}
-
-	/* Validate the CMA size again in case some invalid nodes specified. */
-	if (!hugetlb_cma_size)
-		return;
-
-	if (hugetlb_cma_size < (PAGE_SIZE << order)) {
-		pr_warn("hugetlb_cma: cma area should be at least %lu MiB\n",
-			(PAGE_SIZE << order) / SZ_1M);
-		hugetlb_cma_size = 0;
-		return;
-	}
-
-	if (!node_specific_cma_alloc) {
-		/*
-		 * If 3 GB area is requested on a machine with 4 numa nodes,
-		 * let's allocate 1 GB on first three nodes and ignore the last one.
-		 */
-		per_node = DIV_ROUND_UP(hugetlb_cma_size, nr_online_nodes);
-		pr_info("hugetlb_cma: reserve %lu MiB, up to %lu MiB per node\n",
-			hugetlb_cma_size / SZ_1M, per_node / SZ_1M);
-	}
-
-	reserved = 0;
-	for_each_online_node(nid) {
-		int res;
-		char name[CMA_MAX_NAME];
-
-		if (node_specific_cma_alloc) {
-			if (hugetlb_cma_size_in_node[nid] == 0)
-				continue;
-
-			size = hugetlb_cma_size_in_node[nid];
-		} else {
-			size = min(per_node, hugetlb_cma_size - reserved);
-		}
-
-		size = round_up(size, PAGE_SIZE << order);
-
-		snprintf(name, sizeof(name), "hugetlb%d", nid);
-		/*
-		 * Note that 'order per bit' is based on smallest size that
-		 * may be returned to CMA allocator in the case of
-		 * huge page demotion.
-		 */
-		res = cma_declare_contiguous_multi(size, PAGE_SIZE << order,
-					HUGETLB_PAGE_ORDER, name,
-					&hugetlb_cma[nid], nid);
-		if (res) {
-			pr_warn("hugetlb_cma: reservation failed: err %d, node %d",
-				res, nid);
-			continue;
-		}
-
-		reserved += size;
-		pr_info("hugetlb_cma: reserved %lu MiB on node %d\n",
-			size / SZ_1M, nid);
-
-		if (reserved >= hugetlb_cma_size)
-			break;
-	}
-
-	if (!reserved)
-		/*
-		 * hugetlb_cma_size is used to determine if allocations from
-		 * cma are possible.  Set to zero if no cma regions are set up.
-		 */
-		hugetlb_cma_size = 0;
-}
-
-static void __init hugetlb_cma_check(void)
-{
-	if (!hugetlb_cma_size || cma_reserve_called)
-		return;
-
-	pr_warn("hugetlb_cma: the option isn't supported by current arch\n");
-}
-
-#endif /* CONFIG_CMA */
diff --git a/mm/hugetlb_cma.c b/mm/hugetlb_cma.c
new file mode 100644
index 000000000000..e0f2d5c3a84c
--- /dev/null
+++ b/mm/hugetlb_cma.c
@@ -0,0 +1,275 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/mm.h>
+#include <linux/cma.h>
+#include <linux/compiler.h>
+#include <linux/mm_inline.h>
+
+#include <asm/page.h>
+#include <asm/setup.h>
+
+#include <linux/hugetlb.h>
+#include "internal.h"
+#include "hugetlb_cma.h"
+
+
+static struct cma *hugetlb_cma[MAX_NUMNODES];
+static unsigned long hugetlb_cma_size_in_node[MAX_NUMNODES] __initdata;
+static bool hugetlb_cma_only;
+static unsigned long hugetlb_cma_size __initdata;
+
+void hugetlb_cma_free_folio(struct folio *folio)
+{
+	int nid = folio_nid(folio);
+
+	WARN_ON_ONCE(!cma_free_folio(hugetlb_cma[nid], folio));
+}
+
+
+struct folio *hugetlb_cma_alloc_folio(struct hstate *h, gfp_t gfp_mask,
+				      int nid, nodemask_t *nodemask)
+{
+	int node;
+	int order = huge_page_order(h);
+	struct folio *folio = NULL;
+
+	if (hugetlb_cma[nid])
+		folio = cma_alloc_folio(hugetlb_cma[nid], order, gfp_mask);
+
+	if (!folio && !(gfp_mask & __GFP_THISNODE)) {
+		for_each_node_mask(node, *nodemask) {
+			if (node == nid || !hugetlb_cma[node])
+				continue;
+
+			folio = cma_alloc_folio(hugetlb_cma[node], order, gfp_mask);
+			if (folio)
+				break;
+		}
+	}
+
+	if (folio)
+		folio_set_hugetlb_cma(folio);
+
+	return folio;
+}
+
+struct huge_bootmem_page * __init
+hugetlb_cma_alloc_bootmem(struct hstate *h, int *nid, bool node_exact)
+{
+	struct cma *cma;
+	struct huge_bootmem_page *m;
+	int node = *nid;
+
+	cma = hugetlb_cma[*nid];
+	m = cma_reserve_early(cma, huge_page_size(h));
+	if (!m) {
+		if (node_exact)
+			return NULL;
+
+		for_each_online_node(node) {
+			cma = hugetlb_cma[node];
+			if (!cma || node == *nid)
+				continue;
+			m = cma_reserve_early(cma, huge_page_size(h));
+			if (m) {
+				*nid = node;
+				break;
+			}
+		}
+	}
+
+	if (m) {
+		m->flags = HUGE_BOOTMEM_CMA;
+		m->cma = cma;
+	}
+
+	return m;
+}
+
+
+static bool cma_reserve_called __initdata;
+
+static int __init cmdline_parse_hugetlb_cma(char *p)
+{
+	int nid, count = 0;
+	unsigned long tmp;
+	char *s = p;
+
+	while (*s) {
+		if (sscanf(s, "%lu%n", &tmp, &count) != 1)
+			break;
+
+		if (s[count] == ':') {
+			if (tmp >= MAX_NUMNODES)
+				break;
+			nid = array_index_nospec(tmp, MAX_NUMNODES);
+
+			s += count + 1;
+			tmp = memparse(s, &s);
+			hugetlb_cma_size_in_node[nid] = tmp;
+			hugetlb_cma_size += tmp;
+
+			/*
+			 * Skip the separator if have one, otherwise
+			 * break the parsing.
+			 */
+			if (*s == ',')
+				s++;
+			else
+				break;
+		} else {
+			hugetlb_cma_size = memparse(p, &p);
+			break;
+		}
+	}
+
+	return 0;
+}
+
+early_param("hugetlb_cma", cmdline_parse_hugetlb_cma);
+
+static int __init cmdline_parse_hugetlb_cma_only(char *p)
+{
+	return kstrtobool(p, &hugetlb_cma_only);
+}
+
+early_param("hugetlb_cma_only", cmdline_parse_hugetlb_cma_only);
+
+void __init hugetlb_cma_reserve(int order)
+{
+	unsigned long size, reserved, per_node;
+	bool node_specific_cma_alloc = false;
+	int nid;
+
+	/*
+	 * HugeTLB CMA reservation is required for gigantic
+	 * huge pages which could not be allocated via the
+	 * page allocator. Just warn if there is any change
+	 * breaking this assumption.
+	 */
+	VM_WARN_ON(order <= MAX_PAGE_ORDER);
+	cma_reserve_called = true;
+
+	if (!hugetlb_cma_size)
+		return;
+
+	for (nid = 0; nid < MAX_NUMNODES; nid++) {
+		if (hugetlb_cma_size_in_node[nid] == 0)
+			continue;
+
+		if (!node_online(nid)) {
+			pr_warn("hugetlb_cma: invalid node %d specified\n", nid);
+			hugetlb_cma_size -= hugetlb_cma_size_in_node[nid];
+			hugetlb_cma_size_in_node[nid] = 0;
+			continue;
+		}
+
+		if (hugetlb_cma_size_in_node[nid] < (PAGE_SIZE << order)) {
+			pr_warn("hugetlb_cma: cma area of node %d should be at least %lu MiB\n",
+				nid, (PAGE_SIZE << order) / SZ_1M);
+			hugetlb_cma_size -= hugetlb_cma_size_in_node[nid];
+			hugetlb_cma_size_in_node[nid] = 0;
+		} else {
+			node_specific_cma_alloc = true;
+		}
+	}
+
+	/* Validate the CMA size again in case some invalid nodes specified. */
+	if (!hugetlb_cma_size)
+		return;
+
+	if (hugetlb_cma_size < (PAGE_SIZE << order)) {
+		pr_warn("hugetlb_cma: cma area should be at least %lu MiB\n",
+			(PAGE_SIZE << order) / SZ_1M);
+		hugetlb_cma_size = 0;
+		return;
+	}
+
+	if (!node_specific_cma_alloc) {
+		/*
+		 * If 3 GB area is requested on a machine with 4 numa nodes,
+		 * let's allocate 1 GB on first three nodes and ignore the last one.
+		 */
+		per_node = DIV_ROUND_UP(hugetlb_cma_size, nr_online_nodes);
+		pr_info("hugetlb_cma: reserve %lu MiB, up to %lu MiB per node\n",
+			hugetlb_cma_size / SZ_1M, per_node / SZ_1M);
+	}
+
+	reserved = 0;
+	for_each_online_node(nid) {
+		int res;
+		char name[CMA_MAX_NAME];
+
+		if (node_specific_cma_alloc) {
+			if (hugetlb_cma_size_in_node[nid] == 0)
+				continue;
+
+			size = hugetlb_cma_size_in_node[nid];
+		} else {
+			size = min(per_node, hugetlb_cma_size - reserved);
+		}
+
+		size = round_up(size, PAGE_SIZE << order);
+
+		snprintf(name, sizeof(name), "hugetlb%d", nid);
+		/*
+		 * Note that 'order per bit' is based on smallest size that
+		 * may be returned to CMA allocator in the case of
+		 * huge page demotion.
+		 */
+		res = cma_declare_contiguous_multi(size, PAGE_SIZE << order,
+					HUGETLB_PAGE_ORDER, name,
+					&hugetlb_cma[nid], nid);
+		if (res) {
+			pr_warn("hugetlb_cma: reservation failed: err %d, node %d",
+				res, nid);
+			continue;
+		}
+
+		reserved += size;
+		pr_info("hugetlb_cma: reserved %lu MiB on node %d\n",
+			size / SZ_1M, nid);
+
+		if (reserved >= hugetlb_cma_size)
+			break;
+	}
+
+	if (!reserved)
+		/*
+		 * hugetlb_cma_size is used to determine if allocations from
+		 * cma are possible.  Set to zero if no cma regions are set up.
+		 */
+		hugetlb_cma_size = 0;
+}
+
+void __init hugetlb_cma_check(void)
+{
+	if (!hugetlb_cma_size || cma_reserve_called)
+		return;
+
+	pr_warn("hugetlb_cma: the option isn't supported by current arch\n");
+}
+
+bool hugetlb_cma_exclusive_alloc(void)
+{
+	return hugetlb_cma_only;
+}
+
+unsigned long __init hugetlb_cma_total_size(void)
+{
+	return hugetlb_cma_size;
+}
+
+void __init hugetlb_cma_validate_params(void)
+{
+	if (!hugetlb_cma_size)
+		hugetlb_cma_only = false;
+}
+
+bool __init hugetlb_early_cma(struct hstate *h)
+{
+	if (arch_has_huge_bootmem_alloc())
+		return false;
+
+	return hstate_is_gigantic(h) && hugetlb_cma_only;
+}
diff --git a/mm/hugetlb_cma.h b/mm/hugetlb_cma.h
new file mode 100644
index 000000000000..f7d7fb9880a2
--- /dev/null
+++ b/mm/hugetlb_cma.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_HUGETLB_CMA_H
+#define _LINUX_HUGETLB_CMA_H
+
+#ifdef CONFIG_CMA
+void hugetlb_cma_free_folio(struct folio *folio);
+struct folio *hugetlb_cma_alloc_folio(struct hstate *h, gfp_t gfp_mask,
+				      int nid, nodemask_t *nodemask);
+struct huge_bootmem_page *hugetlb_cma_alloc_bootmem(struct hstate *h, int *nid,
+						    bool node_exact);
+void hugetlb_cma_check(void);
+bool hugetlb_cma_exclusive_alloc(void);
+unsigned long hugetlb_cma_total_size(void);
+void hugetlb_cma_validate_params(void);
+bool hugetlb_early_cma(struct hstate *h);
+#else
+static inline void hugetlb_cma_free_folio(struct folio *folio)
+{
+}
+
+static inline struct folio *hugetlb_cma_alloc_folio(struct hstate *h,
+	    gfp_t gfp_mask, int nid, nodemask_t *nodemask)
+{
+	return NULL;
+}
+
+static inline
+struct huge_bootmem_page *hugetlb_cma_alloc_bootmem(struct hstate *h, int *nid,
+						    bool node_exact)
+{
+	return NULL;
+}
+
+static inline void hugetlb_cma_check(void)
+{
+}
+
+static inline bool hugetlb_cma_exclusive_alloc(void)
+{
+	return false;
+}
+
+static inline unsigned long hugetlb_cma_total_size(void)
+{
+	return 0;
+}
+
+static inline void hugetlb_cma_validate_params(void)
+{
+}
+
+static inline bool hugetlb_early_cma(struct hstate *h)
+{
+	return false;
+}
+#endif
+#endif
-- 
2.48.1.601.g30ceb7b040-goog


