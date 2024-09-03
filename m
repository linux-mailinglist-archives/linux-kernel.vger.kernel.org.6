Return-Path: <linux-kernel+bounces-313826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F11296AA4C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 23:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 113D31F21882
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 21:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073211D588F;
	Tue,  3 Sep 2024 21:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WMsDJw++"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD211D223C
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 21:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725399420; cv=none; b=OLvyzEhp/AWojdFiHyQZDQEmoZJQeMqlPkzJ59xfegcYKQ5w2Dpt/n6XNlw90goxqT2lbTnyChUL//EGOADbEvI5QhjcyVu7NFW2qSlX9I1dNEO6Xyp+0QwgUPpe+7Acm5yBLoqQAe8WtHWuZPQ35F/5GHvStCSAxhN2AdH4gPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725399420; c=relaxed/simple;
	bh=tnZrHJow6b58XOY5Zv8kK6c+GD7yokgaYmJEEJuqAkY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IWeBtAFLylg8oJgay/wuMpA2ficTVf4kVC40tH6L8p7bEIn7R2AtGfAJw5ggFmgn8xMsWKHPkb3qoDCiq0heMygstC0oEUbF3vHT7oSCIFiLQ4voitYiyHLNT4ccDpBSRxiLR9fTmT7f8VpXvEi+9yk5Uteei9I5CgPBFFrqYbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WMsDJw++; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1a892d8438so222502276.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 14:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725399417; x=1726004217; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/7NuEBRfCNoI3kJSS18ZDURR7hz7WK5gt1vcDxkEbA=;
        b=WMsDJw++a2d4p/JqmknvbrPBBc2lUFpRgKEB9GMujt4k0mNdwg8zYbMGY7u1ySFZuY
         t9wgS473yToH+X5cWKMi6qPJ52LHZisbbYQ8MRh7hHjIE7mLK6ybWNl7Ztb+QwzPydop
         z5rmQkwrQ0xJJ4HBNbC2b0FoCrzr+gU2cv3Mdqe/XESiYGH+jELMH3yDoinakxI5QzJF
         zMNPV9+MZMeUkXy+IecGJ6Zsp1OZWDETyysN4F1uds43/2WBCAWvziolfrEgqosFJoyd
         t5MLov3NbmYFjSHkpmYD7dGsipeYLyHZTDVU8bXdpGdmcqgRsHKJ7EB6XOozaPU6YX9F
         +OKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725399417; x=1726004217;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/7NuEBRfCNoI3kJSS18ZDURR7hz7WK5gt1vcDxkEbA=;
        b=SzCpmRHIC4BZiByxJsI+7ksmA87zZKS1mMiaYKLN/PcoHDGLgYYZedppoG7sG8Jo2T
         QPSyM72KJc01oSn8DBbrs+GV1zEmiCqg2M4CTccLCpLR+OCXJ8ooEYKUJrMd3jkE+iR3
         XqAlIJlIPabB27eec+joKQV4OrTeLVqrTq/1pNFas8Wl3h9cNvJuBCgPHO7AC7/AKvEb
         +kmyjKryTDmT6KOVviaYnyoebxhoN2ajiOcyJGxgSr1Q1KgI9LcsXA6QAQWNQIAqRueI
         zhD7ZFZ3wFhtPHesJimxpd/pVSBAsfkfvfd8gzw1u9OF8SGy+LUMdQgRa/60v1/V3uyf
         laUg==
X-Forwarded-Encrypted: i=1; AJvYcCXT/1Sn5iS9lk3MiyOPcBChyydqvf6cvZN64caWfJiIdJHrbpBfRv+Rq0RdyDoVeFJlgbM5/yxy2cMBc1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhhdQ87uHSjTnTcwoUenXp4mmZM3aKITHrZTSXGuDQzFJJ2L5t
	7LkvUeyY+RmW5VtClpYg7TTBIRESnzbr528P1CACMr8Bfq8qKq9z3xLVYK2kLEWrvMSjkxzEIXB
	PqA==
X-Google-Smtp-Source: AGHT+IGGSeNgfu3VxAiHe7OfPaoKscE8qEOTQ+EoyIisWRyArXESs2P4m407AuhgVZ//yoQWwR8kUho664U=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:bb58:3d85:3f9c:c6c6])
 (user=yuzhao job=sendgmr) by 2002:a25:8592:0:b0:e0e:c9bc:3206 with SMTP id
 3f1490d57ef6-e1d0e78ad12mr315276.5.1725399417227; Tue, 03 Sep 2024 14:36:57
 -0700 (PDT)
Date: Tue,  3 Sep 2024 15:36:48 -0600
In-Reply-To: <20240903213649.3566695-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240903213649.3566695-1-yuzhao@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240903213649.3566695-2-yuzhao@google.com>
Subject: [PATCH mm-unstable v1 2/3] mm/codetag: fix pgalloc_tag_split()
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Suren Baghdasaryan <surenb@google.com>
Cc: Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"

Only tag the new head pages when splitting one large folio to multiple
ones of a lower order. Tagging tail pages can cause imbalanced "calls"
counters, since only head pages are untagged by pgalloc_tag_sub() and
reference counts on tail pages are leaked, e.g.,
  # echo 2048kB >/sys/kernel/mm/hugepages/hugepages-1048576kB/demote_size
  # echo 700 >/sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
  # time echo 700 >/sys/kernel/mm/hugepages/hugepages-1048576kB/demote
  # grep alloc_gigantic_folio /proc/allocinfo

Before this patch:
  0  549427200  mm/hugetlb.c:1549 func:alloc_gigantic_folio

  real  0m2.057s
  user  0m0.000s
  sys   0m2.051s

After this patch:
  0          0  mm/hugetlb.c:1549 func:alloc_gigantic_folio

  real  0m1.711s
  user  0m0.000s
  sys   0m1.704s

Not tagging tail pages also improves the splitting time, e.g., by
about 15% when demoting 1GB hugeTLB folios to 2MB ones, as shown
above.

Fixes: be25d1d4e822 ("mm: create new codetag references during page splitting")
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/mm.h          | 30 ++++++++++++++++++++++++++++++
 include/linux/pgalloc_tag.h | 31 -------------------------------
 mm/huge_memory.c            |  2 +-
 mm/hugetlb.c                |  2 +-
 mm/page_alloc.c             |  4 ++--
 5 files changed, 34 insertions(+), 35 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index b31d4bdd65ad..a07e93adb8ad 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4137,4 +4137,34 @@ void vma_pgtable_walk_end(struct vm_area_struct *vma);
 
 int reserve_mem_find_by_name(const char *name, phys_addr_t *start, phys_addr_t *size);
 
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+static inline void pgalloc_tag_split(struct folio *folio, int old_order, int new_order)
+{
+	int i;
+	struct alloc_tag *tag;
+	unsigned int nr_pages = 1 << new_order;
+
+	if (!mem_alloc_profiling_enabled())
+		return;
+
+	tag = pgalloc_tag_get(&folio->page);
+	if (!tag)
+		return;
+
+	for (i = nr_pages; i < (1 << old_order); i += nr_pages) {
+		union codetag_ref *ref = get_page_tag_ref(folio_page(folio, i));
+
+		if (ref) {
+			/* Set new reference to point to the original tag */
+			alloc_tag_ref_set(ref, tag);
+			put_page_tag_ref(ref);
+		}
+	}
+}
+#else /* !CONFIG_MEM_ALLOC_PROFILING */
+static inline void pgalloc_tag_split(struct folio *folio, int old_order, int new_order)
+{
+}
+#endif /* CONFIG_MEM_ALLOC_PROFILING */
+
 #endif /* _LINUX_MM_H */
diff --git a/include/linux/pgalloc_tag.h b/include/linux/pgalloc_tag.h
index 207f0c83c8e9..59a3deb792a8 100644
--- a/include/linux/pgalloc_tag.h
+++ b/include/linux/pgalloc_tag.h
@@ -80,36 +80,6 @@ static inline void pgalloc_tag_sub(struct page *page, unsigned int nr)
 	}
 }
 
-static inline void pgalloc_tag_split(struct page *page, unsigned int nr)
-{
-	int i;
-	struct page_ext *first_page_ext;
-	struct page_ext *page_ext;
-	union codetag_ref *ref;
-	struct alloc_tag *tag;
-
-	if (!mem_alloc_profiling_enabled())
-		return;
-
-	first_page_ext = page_ext = page_ext_get(page);
-	if (unlikely(!page_ext))
-		return;
-
-	ref = codetag_ref_from_page_ext(page_ext);
-	if (!ref->ct)
-		goto out;
-
-	tag = ct_to_alloc_tag(ref->ct);
-	page_ext = page_ext_next(page_ext);
-	for (i = 1; i < nr; i++) {
-		/* Set new reference to point to the original tag */
-		alloc_tag_ref_set(codetag_ref_from_page_ext(page_ext), tag);
-		page_ext = page_ext_next(page_ext);
-	}
-out:
-	page_ext_put(first_page_ext);
-}
-
 static inline struct alloc_tag *pgalloc_tag_get(struct page *page)
 {
 	struct alloc_tag *tag = NULL;
@@ -142,7 +112,6 @@ static inline void clear_page_tag_ref(struct page *page) {}
 static inline void pgalloc_tag_add(struct page *page, struct task_struct *task,
 				   unsigned int nr) {}
 static inline void pgalloc_tag_sub(struct page *page, unsigned int nr) {}
-static inline void pgalloc_tag_split(struct page *page, unsigned int nr) {}
 static inline struct alloc_tag *pgalloc_tag_get(struct page *page) { return NULL; }
 static inline void pgalloc_tag_sub_pages(struct alloc_tag *tag, unsigned int nr) {}
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0993dfe9ae94..aa8a4c938ba9 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3244,7 +3244,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	/* Caller disabled irqs, so they are still disabled here */
 
 	split_page_owner(head, order, new_order);
-	pgalloc_tag_split(head, 1 << order);
+	pgalloc_tag_split(folio, order, new_order);
 
 	/* See comment in __split_huge_page_tail() */
 	if (folio_test_anon(folio)) {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3faf5aad142d..a8624c07d8bf 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3778,7 +3778,7 @@ static long demote_free_hugetlb_folios(struct hstate *src, struct hstate *dst,
 		list_del(&folio->lru);
 
 		split_page_owner(&folio->page, huge_page_order(src), huge_page_order(dst));
-		pgalloc_tag_split(&folio->page, 1 <<  huge_page_order(src));
+		pgalloc_tag_split(folio, huge_page_order(src), huge_page_order(dst));
 
 		for (i = 0; i < pages_per_huge_page(src); i += pages_per_huge_page(dst)) {
 			struct page *page = folio_page(folio, i);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c242d61fc4fd..13ce8e8899ed 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2822,7 +2822,7 @@ void split_page(struct page *page, unsigned int order)
 	for (i = 1; i < (1 << order); i++)
 		set_page_refcounted(page + i);
 	split_page_owner(page, order, 0);
-	pgalloc_tag_split(page, 1 << order);
+	pgalloc_tag_split(page_folio(page), order, 0);
 	split_page_memcg(page, order, 0);
 }
 EXPORT_SYMBOL_GPL(split_page);
@@ -5020,7 +5020,7 @@ static void *make_alloc_exact(unsigned long addr, unsigned int order,
 		struct page *last = page + nr;
 
 		split_page_owner(page, order, 0);
-		pgalloc_tag_split(page, 1 << order);
+		pgalloc_tag_split(page_folio(page), order, 0);
 		split_page_memcg(page, order, 0);
 		while (page < --last)
 			set_page_refcounted(last);
-- 
2.46.0.469.g59c65b2a67-goog


