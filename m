Return-Path: <linux-kernel+bounces-282129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7437194DFF0
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 06:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBD3A1C20BFB
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 04:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8252FFBE8;
	Sun, 11 Aug 2024 04:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i6lz7Dbg"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5769E57D
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 04:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723349830; cv=none; b=nE4zzDXhRrUuZ3jvzraAbaTp9lyNiI+A5980Ddgxe712i/L5CgMPxsmfutw+9mYfNNHatuioBjNPuj1mLcPKGgBRQSyMVn+NqLG8cAHM5uAa8bi5odpCpTWyNzc10Ukt2qj+uW4gEysSdfL6q1pFiqdzjFNdYHmNkKUOdYBcU5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723349830; c=relaxed/simple;
	bh=04z5CYMMJdUAhf0RZ93F/MaGg0ihwe/hjHSw3LGSy/k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qlM1NsXSNZrvyxmlMV3rVYN5vQpq/tPvMa3zA5QDmycXZq0x1354zGY/Be0hg2KLrrIcnYC7HSnTJHFxCrR2VXiABUy0bKKtxNF/CDxQq/vdhJrPCyAKpHvKvm7eEPJvWKXdL27MGuY8NpmtjAmEmZ54j7drDLCbbjQcJHnphag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i6lz7Dbg; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0872023b7dso5422244276.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 21:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723349828; x=1723954628; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CGvOB/Cc5Xh5ChLX3RFa1zTgz8++Mz21jXe5s6NT+Nc=;
        b=i6lz7DbgXZ/sNO9TKbd63xKASBl8Qq0oicExRolV29mZf0AMb9cQGpbfdUNNyBU9V/
         bB/FJRlWgRhd/EYX/zkP9MmVHlN3E97qmcA5rsSzCFGPi4/eKlTn7B5uHyEX8DZ6WgHH
         U/l0hLrAtyjt12Wbet7PhmCaanLSxfOrb38KrGdIYCYY21HA5LV6T4TGSO/lg4I2pJ7J
         ehFc2Rz1cHv9trD3oCybFlOECkD/uIvsiNIG6ZQUT2Yk06ULEY5W5gCuNEcc/Luu7q9y
         j+HelYvM/keXHZh1hIMkcHXyn1XbzeHpzi5VLkt512bGrc0qx3C5pg2eS2qY7489p12R
         61Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723349828; x=1723954628;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CGvOB/Cc5Xh5ChLX3RFa1zTgz8++Mz21jXe5s6NT+Nc=;
        b=aGnpwK4LgUN7RhCNXrSM+5oAzcTUE/Zml78kRolCYz6loKdrL26r1s4x+EwT5BZb1c
         Zn0BSB+doUnUEHogJOjLiMtYB/xSyO3ADGzS5t1xbh3WiEbMP9h3x8+wTErRoTB9tYlh
         g3LJZfNW8zzlViFHzwYstRBfMrJ5OBwmmFSm0RO035Gf0dTel4koExYp9riv/z4xT43o
         WQSu3XMhffIZaXY6ngxWNME3g31jbfKWcAouanx7PFrKH9WZKym8uYcZuB3u1yvk8Q85
         azYbEtB+xToLKDHN7mXLNoX2GDe+LPjC72YRskwLsUlzzxfxB9AuerBd8ny7/AvtZYw5
         XBeg==
X-Forwarded-Encrypted: i=1; AJvYcCXk9IOOCporng0veIlEIX6RbN4OLGnAPR2sqy1m7g35u51xOttFuzFTFvd24151mmH3p1LESArmphhzlYFNiTzwEIDxxCNB5Y9ltKk+
X-Gm-Message-State: AOJu0YyAgpWW5NeOfX7q4KmkY/KQPq7uzlxxbrTdAr+7OYtY28T6praZ
	Pi6NpqOsqrKHdaqTaUVzpq8zbmP0z3UoOEu5VgLVAniSxNj/TaOfPw6BCO84LpTmCW+G7Sd5Z9h
	XpA==
X-Google-Smtp-Source: AGHT+IG1YyOFlQolnluyZMc4+th+WGGFkvrkwTs+aMnvM123+KndA3b6M5O2eiME21KpXCS9suqGjCcgOwI=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:f2a1:be95:1189:128])
 (user=yuzhao job=sendgmr) by 2002:a25:a146:0:b0:e0b:af9b:fb7e with SMTP id
 3f1490d57ef6-e0eb98dcd0bmr11666276.1.1723349827717; Sat, 10 Aug 2024 21:17:07
 -0700 (PDT)
Date: Sat, 10 Aug 2024 22:17:03 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240811041703.2775153-1-yuzhao@google.com>
Subject: [PATCH mm-unstable v1] mm/hugetlb_vmemmap: batch HVO work when demoting
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
when batched, only twice (1 de-HVO plus 1 HVO request). And
performance between the two cases are significantly different, e.g.,
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

Fixes: bd225530a4c7 ("mm/hugetlb_vmemmap: fix race with speculative PFN walkers")
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/hugetlb.c | 155 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 91 insertions(+), 64 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1fdd9eab240c..444cda461d1e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3921,100 +3921,123 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
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
+	dst->max_huge_pages += nr_demoted * (pages_per_huge_page(src) / pages_per_huge_page(dst));
+
+	if (rc < 0)
+		return rc;
+
+	if (nr_demoted)
+		return nr_demoted;
 	/*
 	 * Only way to get here is if all pages on free lists are poisoned.
 	 * Return -EBUSY so that caller will not retry.
@@ -4249,6 +4272,8 @@ static ssize_t demote_store(struct kobject *kobj,
 	spin_lock_irq(&hugetlb_lock);
 
 	while (nr_demote) {
+		long rc;
+
 		/*
 		 * Check for available pages to demote each time thorough the
 		 * loop as demote_pool_huge_page will drop hugetlb_lock.
@@ -4261,11 +4286,13 @@ static ssize_t demote_store(struct kobject *kobj,
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


