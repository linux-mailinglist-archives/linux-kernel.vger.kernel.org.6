Return-Path: <linux-kernel+bounces-283864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9696D94F9D0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 00:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB1281F21D08
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7362619A298;
	Mon, 12 Aug 2024 22:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K3X2lavV"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E561684A6
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 22:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723502910; cv=none; b=Q1/qfgHULEa/1vqd4XiN2WlNW+1JYVqJ5zrI2Z9Rx/jLAIJ//4TSQpPqk4Oj54TdNUjH2UKzEst+cQuYLFeAqXm9UFpLf3q7qGam5V4grf+NGJyLM00Hdp4dv/g7UFZznaESQQwD3/iiFnIYqnprjphBfp/Zov4qhbBf2TKIb9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723502910; c=relaxed/simple;
	bh=QsCDwSyfCUNrMxuWYGmvGxRWub4dzbssP2RU8ZgwzEc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nGVI+Ld7uh06oLMxlNjY4nr4H9rznX0OFJiVUDvfV0dqzxaaouLyb5FgQ1x/rphyOZCXOqL+DrRzESpYu1XvecaV3lf4umEL+D4MehVhiADMUCfAlkGFN8XkQYvwBufYR27HlUhPHDQRL+NZ8iscTO/77cG8hmUN7ThD+VbGCMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K3X2lavV; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6902dc6d3ffso121869477b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 15:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723502908; x=1724107708; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z4tOQNonvu3WucHjBVDac8ntNZIpy85hQ1C4kgQXLs4=;
        b=K3X2lavVQWnaFOO/5gxDqTRefBIzyoE6k+RgImvYTB4ZslemHSnNEzT5xFIcgJAB22
         km6OGo+iUwGAPtx+UDR19PM3oJ4gJF0F6gKYpabsksECf/zBSFRmej3Do8LQveTLMHXa
         ZEp1sjbQ439bqNZcE+cVIr9TSm7+dHXlqiK/aYM3IYSHQaTwb6V8wHsEjfGpUeTbWg5T
         gBvFx7PA0VRDT8oA/yBytdKoMowg8iBaW7mluMAjZgmYgJDhgrMqRi8LZW4XLLEXU0nj
         qdiEQC5zn7Vro6VbCJNI6WMN2ics/4EX/fWv990fWQj8C8jluxo7YtlmDpb0fC2DZCof
         gK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723502908; x=1724107708;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z4tOQNonvu3WucHjBVDac8ntNZIpy85hQ1C4kgQXLs4=;
        b=IQwR3/+eNtUaOj0TqaCL1930V4yS02KEo308O4yHTmJGJ09zOACF+NllgaG+zUoizC
         K6fPT6Ts3DIGGSinVE4ycjuTvfSguwb4pJUIrXCD/bTccCt1ugJZFT4f6ykmm+Kh4793
         lmX21fjYCd846DpdH6qYSP2gRs4NMy3eBQrBBA0RsvQOYYMFYljWEv+VIkPQ0u022gNr
         Xl8vjqQejFRzvvOgY2Y0e90yWg44p7bSmwE9yE6LYP0Ss5Qf7vGUTAhdlf3zHaZgxbB8
         PZlrLOrATcsL7dC1Ft4LnBkvmGGzZcwObxTANFWgTQmDMlPL5LVE59m5XcHhX3NoCE3Q
         z0YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMMaWJ0SVhR0QizOOs8AwbukvSKHi08HjHaItDf1RQKYVdWh0nFxi622mesJ/tv9JC2zGjr2+7f9XxF2q+yeouhfX3Wvjr8AyNvQHV
X-Gm-Message-State: AOJu0Yx1odeJgt5SwMHjgHiG3hyCSpvX9M+D7NulKFL2Rmmrj3TZCFy3
	1VrdWALyhLvByCv7+dAYTtK+FcpmVzZa+zyizHa+vNMOonZum+1vEzVFdyMkiFx1xpzLNWnW6tM
	Apg==
X-Google-Smtp-Source: AGHT+IGlt5ONcDJU5HS/vpv3a/e8q0PCTlMlvhLc6kDsXLASkpvAzlU8vdmVaQqQHVieDd5QnjBXBKwi2P8=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:87e4:5aca:969:682f])
 (user=yuzhao job=sendgmr) by 2002:a0d:e543:0:b0:650:93e3:fe73 with SMTP id
 00721157ae682-6a9759b99e3mr583647b3.5.1723502907708; Mon, 12 Aug 2024
 15:48:27 -0700 (PDT)
Date: Mon, 12 Aug 2024 16:48:23 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240812224823.3914837-1-yuzhao@google.com>
Subject: [PATCH mm-unstable v2] mm/hugetlb_vmemmap: batch HVO work when demoting
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"

Batch the HVO work, including de-HVO of the source and HVO of the
destination hugeTLB folios, to speed up demotion.

After commit bd225530a4c7 ("mm/hugetlb_vmemmap: fix race with
speculative PFN walkers"), each request of HVO or de-HVO, batched or
not, invokes synchronize_rcu() once. For example, when not batched,
demoting one 1GB hugeTLB folio to 512 2MB hugeTLB folios invokes
synchronize_rcu() 513 times (1 de-HVO plus 512 HVO requests), whereas
when batched, only twice (1 de-HVO plus 1 HVO request). And the
performance difference between the two cases is significant, e.g.,
  echo 2048kB >/sys/kernel/mm/hugepages/hugepages-1048576kB/demote_size
  time echo 100 >/sys/kernel/mm/hugepages/hugepages-1048576kB/demote

Before this patch:
  real     8m58.158s
  user     0m0.009s
  sys      0m5.900s

After this patch:
  real     0m0.900s
  user     0m0.000s
  sys      0m0.851s

Note that this patch changes the behavior of the `demote` interface
when de-HVO fails. Before, the interface aborts immediately upon
failure; now, it tries to finish an entire batch, meaning it can make
extra progress if the rest of the batch contains folios that do not
need to de-HVO.

Fixes: bd225530a4c7 ("mm/hugetlb_vmemmap: fix race with speculative PFN walkers")
Signed-off-by: Yu Zhao <yuzhao@google.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
---
 mm/hugetlb.c | 156 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 92 insertions(+), 64 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1fdd9eab240c..d2b9555e6c45 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3921,100 +3921,124 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	return 0;
 }
 
-static int demote_free_hugetlb_folio(struct hstate *h, struct folio *folio)
+static long demote_free_hugetlb_folios(struct hstate *src, struct hstate *dst,
+				       struct list_head *src_list)
 {
-	int i, nid = folio_nid(folio);
-	struct hstate *target_hstate;
-	struct page *subpage;
-	struct folio *inner_folio;
-	int rc = 0;
+	long rc;
+	struct folio *folio, *next;
+	LIST_HEAD(dst_list);
+	LIST_HEAD(ret_list);
 
-	target_hstate = size_to_hstate(PAGE_SIZE << h->demote_order);
-
-	remove_hugetlb_folio(h, folio, false);
-	spin_unlock_irq(&hugetlb_lock);
-
-	/*
-	 * If vmemmap already existed for folio, the remove routine above would
-	 * have cleared the hugetlb folio flag.  Hence the folio is technically
-	 * no longer a hugetlb folio.  hugetlb_vmemmap_restore_folio can only be
-	 * passed hugetlb folios and will BUG otherwise.
-	 */
-	if (folio_test_hugetlb(folio)) {
-		rc = hugetlb_vmemmap_restore_folio(h, folio);
-		if (rc) {
-			/* Allocation of vmemmmap failed, we can not demote folio */
-			spin_lock_irq(&hugetlb_lock);
-			add_hugetlb_folio(h, folio, false);
-			return rc;
-		}
-	}
-
-	/*
-	 * Use destroy_compound_hugetlb_folio_for_demote for all huge page
-	 * sizes as it will not ref count folios.
-	 */
-	destroy_compound_hugetlb_folio_for_demote(folio, huge_page_order(h));
+	rc = hugetlb_vmemmap_restore_folios(src, src_list, &ret_list);
+	list_splice_init(&ret_list, src_list);
 
 	/*
 	 * Taking target hstate mutex synchronizes with set_max_huge_pages.
 	 * Without the mutex, pages added to target hstate could be marked
 	 * as surplus.
 	 *
-	 * Note that we already hold h->resize_lock.  To prevent deadlock,
+	 * Note that we already hold src->resize_lock.  To prevent deadlock,
 	 * use the convention of always taking larger size hstate mutex first.
 	 */
-	mutex_lock(&target_hstate->resize_lock);
-	for (i = 0; i < pages_per_huge_page(h);
-				i += pages_per_huge_page(target_hstate)) {
-		subpage = folio_page(folio, i);
-		inner_folio = page_folio(subpage);
-		if (hstate_is_gigantic(target_hstate))
-			prep_compound_gigantic_folio_for_demote(inner_folio,
-							target_hstate->order);
-		else
-			prep_compound_page(subpage, target_hstate->order);
-		folio_change_private(inner_folio, NULL);
-		prep_new_hugetlb_folio(target_hstate, inner_folio, nid);
-		free_huge_folio(inner_folio);
+	mutex_lock(&dst->resize_lock);
+
+	list_for_each_entry_safe(folio, next, src_list, lru) {
+		int i;
+
+		if (folio_test_hugetlb_vmemmap_optimized(folio))
+			continue;
+
+		list_del(&folio->lru);
+		/*
+		 * Use destroy_compound_hugetlb_folio_for_demote for all huge page
+		 * sizes as it will not ref count folios.
+		 */
+		destroy_compound_hugetlb_folio_for_demote(folio, huge_page_order(src));
+
+		for (i = 0; i < pages_per_huge_page(src); i += pages_per_huge_page(dst)) {
+			struct page *page = folio_page(folio, i);
+
+			if (hstate_is_gigantic(dst))
+				prep_compound_gigantic_folio_for_demote(page_folio(page),
+									dst->order);
+			else
+				prep_compound_page(page, dst->order);
+			set_page_private(page, 0);
+
+			init_new_hugetlb_folio(dst, page_folio(page));
+			list_add(&page->lru, &dst_list);
+		}
 	}
-	mutex_unlock(&target_hstate->resize_lock);
 
-	spin_lock_irq(&hugetlb_lock);
+	prep_and_add_allocated_folios(dst, &dst_list);
 
-	/*
-	 * Not absolutely necessary, but for consistency update max_huge_pages
-	 * based on pool changes for the demoted page.
-	 */
-	h->max_huge_pages--;
-	target_hstate->max_huge_pages +=
-		pages_per_huge_page(h) / pages_per_huge_page(target_hstate);
+	mutex_unlock(&dst->resize_lock);
 
 	return rc;
 }
 
-static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
+static long demote_pool_huge_page(struct hstate *src, nodemask_t *nodes_allowed,
+				  unsigned long nr_to_demote)
 	__must_hold(&hugetlb_lock)
 {
 	int nr_nodes, node;
-	struct folio *folio;
+	struct hstate *dst;
+	long rc = 0;
+	long nr_demoted = 0;
 
 	lockdep_assert_held(&hugetlb_lock);
 
 	/* We should never get here if no demote order */
-	if (!h->demote_order) {
+	if (!src->demote_order) {
 		pr_warn("HugeTLB: NULL demote order passed to demote_pool_huge_page.\n");
 		return -EINVAL;		/* internal error */
 	}
+	dst = size_to_hstate(PAGE_SIZE << src->demote_order);
 
-	for_each_node_mask_to_free(h, nr_nodes, node, nodes_allowed) {
-		list_for_each_entry(folio, &h->hugepage_freelists[node], lru) {
+	for_each_node_mask_to_free(src, nr_nodes, node, nodes_allowed) {
+		LIST_HEAD(list);
+		struct folio *folio, *next;
+
+		list_for_each_entry_safe(folio, next, &src->hugepage_freelists[node], lru) {
 			if (folio_test_hwpoison(folio))
 				continue;
-			return demote_free_hugetlb_folio(h, folio);
+
+			remove_hugetlb_folio(src, folio, false);
+			list_add(&folio->lru, &list);
+
+			if (++nr_demoted == nr_to_demote)
+				break;
 		}
+
+		spin_unlock_irq(&hugetlb_lock);
+
+		rc = demote_free_hugetlb_folios(src, dst, &list);
+
+		spin_lock_irq(&hugetlb_lock);
+
+		list_for_each_entry_safe(folio, next, &list, lru) {
+			list_del(&folio->lru);
+			add_hugetlb_folio(src, folio, false);
+
+			nr_demoted--;
+		}
+
+		if (rc < 0 || nr_demoted == nr_to_demote)
+			break;
 	}
 
+	/*
+	 * Not absolutely necessary, but for consistency update max_huge_pages
+	 * based on pool changes for the demoted page.
+	 */
+	src->max_huge_pages -= nr_demoted;
+	dst->max_huge_pages += nr_demoted << (huge_page_order(src) - huge_page_order(dst));
+
+	if (rc < 0)
+		return rc;
+
+	if (nr_demoted)
+		return nr_demoted;
 	/*
 	 * Only way to get here is if all pages on free lists are poisoned.
 	 * Return -EBUSY so that caller will not retry.
@@ -4249,6 +4273,8 @@ static ssize_t demote_store(struct kobject *kobj,
 	spin_lock_irq(&hugetlb_lock);
 
 	while (nr_demote) {
+		long rc;
+
 		/*
 		 * Check for available pages to demote each time thorough the
 		 * loop as demote_pool_huge_page will drop hugetlb_lock.
@@ -4261,11 +4287,13 @@ static ssize_t demote_store(struct kobject *kobj,
 		if (!nr_available)
 			break;
 
-		err = demote_pool_huge_page(h, n_mask);
-		if (err)
+		rc = demote_pool_huge_page(h, n_mask, nr_demote);
+		if (rc < 0) {
+			err = rc;
 			break;
+		}
 
-		nr_demote--;
+		nr_demote -= rc;
 	}
 
 	spin_unlock_irq(&hugetlb_lock);
-- 
2.46.0.76.ge559c4bf1a-goog


