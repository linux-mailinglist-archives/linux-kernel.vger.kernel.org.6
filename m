Return-Path: <linux-kernel+bounces-267544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 084B99412A8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17252B26B69
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D0A1A071A;
	Tue, 30 Jul 2024 12:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSEe1m5b"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B4019FA76;
	Tue, 30 Jul 2024 12:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722344058; cv=none; b=BAU+OZFF2NM3gBAKsQ1K5dTjMj7bafA/uH9MCu3/wl104/2f9a7NyVhSKy/t2kxOCmrMdyXqchEuHR4s2qGg85GW0Lx/gYKaqRmFTANBVq2SDZFrYm7JfjHA02a8An4wpLxWQI5TisQ6s0hSZFOD2H/bkdf0R81xTH2vNUav9ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722344058; c=relaxed/simple;
	bh=99nW0Cfi/w568LUR5sE7RuC+dO3tcBSiOUXyyhiMJQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Trl7UsrxX3evzgjhvCS9chudrXNkoIdWFWxoQwC80sXBXwXiTlUffIN4IB9fHtamG6FdtLT+Rqy7ZpVc24CgVjy7WQxslFu2MMmXM2QutNDp6R2uu/mNK6wz6lmm+zGHcAUxGYOZi02Liz3l/cvGcYXp7epWAJaLs6e0RyvPhLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSEe1m5b; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-83446a5601bso1188312241.0;
        Tue, 30 Jul 2024 05:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722344055; x=1722948855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1wFF2OykYTq7u4lRnrBlmyhKJmdj3JpsXJVQxU9HeI=;
        b=aSEe1m5b/mwi35UO6EH/POoHfDbXiTCcb+tFg7zg0L7VOibQXH2BqiN1wFQBV3gFV3
         9jSzFDddJam4KRFtXb+Rbp/jao/Pz4pH3Jb4qhfcEpAzNjLExwDIj3qLvna8A7aD6fOc
         G8LcRbOOGrO0Js8c44pq+GrL3z44JJ5IwYEDP/GDBE5hy1v8bX9siP/OvSc7VE3deF+n
         wTkMgzZhWdtLj8lZIOUSvKt9zxFiev4YzQWvasuREp7u78V93J7mBCGrWDz8kR93t4Ai
         1z1bgnCNyCluM+ZjMhckQWVH+anVVQm30OeO9P+jk5qifpj0NuT0acdx11in0OD8lZ0+
         a6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722344055; x=1722948855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a1wFF2OykYTq7u4lRnrBlmyhKJmdj3JpsXJVQxU9HeI=;
        b=vsR2nFSWrmy8tG/Mn0iZ2odNhA6Mz5xr8IZOA0MJQj7gf8CYphKh7D5weU76Y9I6S4
         RGWCygTPRMLvWBfSBqmvda1tUOadlrGfbQNGKB8KpB9+JULkiwPTO3Kp7sY74JC/fIB/
         +DhDvp1AD6tQh24zzo97xWnrgSVQk7RMT6jtK8NJiMcnFhCA+KQhd6SOTa72LuIgq+cQ
         njiYQ2IMHHXo/ZFgLI66nfHDK4tNWb7nhlIxVjuWc7KoYx3HX+FoGKT3gUptbihk0LLM
         h1WUE3h3M8/soMbrO5zYzHZCy1AioHevlEjwKCTSLtYgN0FpZGEJySaXORBjBah6SmyL
         HDxw==
X-Forwarded-Encrypted: i=1; AJvYcCVXe8ob346QlFnxtFyOoemRvs3lSTKxUrbErTIf/NNhK8tSrK+R4YvE/mDH7oTZbcrE2Trdns2vLZxZE3hVJ/6gqKCjjVi8mekeve7VjtKcvhAlewqsx9/36samOy81PL2m8so8m9IM
X-Gm-Message-State: AOJu0YzmorV0kvIKrbbcvGTTShwjfe4a+PB3EfL8oN47+CU+tutTTaK5
	a8XZvfyhZjIZNUE1TaZV6XFqi42+nPGlA1IrsyPimzNXZaBNdYg8
X-Google-Smtp-Source: AGHT+IFv69c1CqQsvpikAHVYWXzas2sO4e5GzupNiWoyXChBgpWC9IWcrnZ5g+GmctsDCyK+p6YuCA==
X-Received: by 2002:a05:6102:54ac:b0:492:a93d:7ca7 with SMTP id ada2fe7eead31-493fa61a794mr12211983137.4.1722344054907;
        Tue, 30 Jul 2024 05:54:14 -0700 (PDT)
Received: from localhost (fwdproxy-ash-114.fbsv.net. [2a03:2880:20ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d745f404sm628318285a.131.2024.07.30.05.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 05:54:14 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	yuzhao@google.com,
	david@redhat.com,
	baohua@kernel.org,
	ryan.roberts@arm.com,
	rppt@kernel.org,
	willy@infradead.org,
	cerasuolodomenico@gmail.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kernel-team@meta.com,
	Shuang Zhai <zhais@google.com>,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH 4/6] mm: don't remap unused subpages when splitting isolated thp
Date: Tue, 30 Jul 2024 13:46:01 +0100
Message-ID: <20240730125346.1580150-5-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730125346.1580150-1-usamaarif642@gmail.com>
References: <20240730125346.1580150-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yu Zhao <yuzhao@google.com>

Here being unused means containing only zeros and inaccessible to
userspace. When splitting an isolated thp under reclaim or migration,
there is no need to remap its unused subpages because they can be
faulted in anew. Not remapping them avoids writeback or copying during
reclaim or migration. This is particularly helpful when the internal
fragmentation of a thp is high, i.e., it has many untouched subpages.

This is also a prerequisite for THP low utilization shrinker which will
be introduced in later patches, where underutilized THPs are split, and
the zero-filled split pages are freed saving memory.

Signed-off-by: Yu Zhao <yuzhao@google.com>
Tested-by: Shuang Zhai <zhais@google.com>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 include/linux/rmap.h |  2 +-
 mm/huge_memory.c     |  8 ++---
 mm/migrate.c         | 73 +++++++++++++++++++++++++++++++++++++++-----
 mm/migrate_device.c  |  4 +--
 4 files changed, 72 insertions(+), 15 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 0978c64f49d8..805ab09057ed 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -745,7 +745,7 @@ int folio_mkclean(struct folio *);
 int pfn_mkclean_range(unsigned long pfn, unsigned long nr_pages, pgoff_t pgoff,
 		      struct vm_area_struct *vma);
 
-void remove_migration_ptes(struct folio *src, struct folio *dst, bool locked);
+void remove_migration_ptes(struct folio *src, struct folio *dst, bool locked, bool unmap_unused);
 
 /*
  * rmap_walk_control: To control rmap traversing for specific needs
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 76a3b6a2b796..892467d85f3a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2775,7 +2775,7 @@ bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long addr,
 	return false;
 }
 
-static void remap_page(struct folio *folio, unsigned long nr)
+static void remap_page(struct folio *folio, unsigned long nr, bool unmap_unused)
 {
 	int i = 0;
 
@@ -2783,7 +2783,7 @@ static void remap_page(struct folio *folio, unsigned long nr)
 	if (!folio_test_anon(folio))
 		return;
 	for (;;) {
-		remove_migration_ptes(folio, folio, true);
+		remove_migration_ptes(folio, folio, true, unmap_unused);
 		i += folio_nr_pages(folio);
 		if (i >= nr)
 			break;
@@ -2993,7 +2993,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 
 	if (nr_dropped)
 		shmem_uncharge(folio->mapping->host, nr_dropped);
-	remap_page(folio, nr);
+	remap_page(folio, nr, PageAnon(head));
 
 	/*
 	 * set page to its compound_head when split to non order-0 pages, so
@@ -3286,7 +3286,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		if (mapping)
 			xas_unlock(&xas);
 		local_irq_enable();
-		remap_page(folio, folio_nr_pages(folio));
+		remap_page(folio, folio_nr_pages(folio), false);
 		ret = -EAGAIN;
 	}
 
diff --git a/mm/migrate.c b/mm/migrate.c
index b273bac0d5ae..f4f06bdded70 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -177,13 +177,61 @@ void putback_movable_pages(struct list_head *l)
 	}
 }
 
+static bool try_to_unmap_unused(struct page_vma_mapped_walk *pvmw,
+			       struct folio *folio,
+			       unsigned long idx)
+{
+	struct page *page = folio_page(folio, idx);
+	void *addr;
+	bool dirty;
+	pte_t newpte;
+
+	VM_BUG_ON_PAGE(PageCompound(page), page);
+	VM_BUG_ON_PAGE(!PageAnon(page), page);
+	VM_BUG_ON_PAGE(!PageLocked(page), page);
+	VM_BUG_ON_PAGE(pte_present(*pvmw->pte), page);
+
+	if (PageMlocked(page) || (pvmw->vma->vm_flags & VM_LOCKED))
+		return false;
+
+	/*
+	 * The pmd entry mapping the old thp was flushed and the pte mapping
+	 * this subpage has been non present. Therefore, this subpage is
+	 * inaccessible. We don't need to remap it if it contains only zeros.
+	 */
+	addr = kmap_local_page(page);
+	dirty = memchr_inv(addr, 0, PAGE_SIZE);
+	kunmap_local(addr);
+
+	if (dirty)
+		return false;
+
+	pte_clear_not_present_full(pvmw->vma->vm_mm, pvmw->address, pvmw->pte, false);
+
+	if (userfaultfd_armed(pvmw->vma)) {
+		newpte = pte_mkspecial(pfn_pte(page_to_pfn(ZERO_PAGE(pvmw->address)),
+					       pvmw->vma->vm_page_prot));
+		ptep_clear_flush(pvmw->vma, pvmw->address, pvmw->pte);
+		set_pte_at(pvmw->vma->vm_mm, pvmw->address, pvmw->pte, newpte);
+	}
+
+	dec_mm_counter(pvmw->vma->vm_mm, mm_counter(folio));
+	return true;
+}
+
+struct rmap_walk_arg {
+	struct folio *folio;
+	bool unmap_unused;
+};
+
 /*
  * Restore a potential migration pte to a working pte entry
  */
 static bool remove_migration_pte(struct folio *folio,
-		struct vm_area_struct *vma, unsigned long addr, void *old)
+		struct vm_area_struct *vma, unsigned long addr, void *arg)
 {
-	DEFINE_FOLIO_VMA_WALK(pvmw, old, vma, addr, PVMW_SYNC | PVMW_MIGRATION);
+	struct rmap_walk_arg *rmap_walk_arg = arg;
+	DEFINE_FOLIO_VMA_WALK(pvmw, rmap_walk_arg->folio, vma, addr, PVMW_SYNC | PVMW_MIGRATION);
 
 	while (page_vma_mapped_walk(&pvmw)) {
 		rmap_t rmap_flags = RMAP_NONE;
@@ -207,6 +255,8 @@ static bool remove_migration_pte(struct folio *folio,
 			continue;
 		}
 #endif
+		if (rmap_walk_arg->unmap_unused && try_to_unmap_unused(&pvmw, folio, idx))
+			continue;
 
 		folio_get(folio);
 		pte = mk_pte(new, READ_ONCE(vma->vm_page_prot));
@@ -285,13 +335,20 @@ static bool remove_migration_pte(struct folio *folio,
  * Get rid of all migration entries and replace them by
  * references to the indicated page.
  */
-void remove_migration_ptes(struct folio *src, struct folio *dst, bool locked)
+void remove_migration_ptes(struct folio *src, struct folio *dst, bool locked, bool unmap_unused)
 {
+	struct rmap_walk_arg rmap_walk_arg = {
+		.folio = src,
+		.unmap_unused = unmap_unused,
+	};
+
 	struct rmap_walk_control rwc = {
 		.rmap_one = remove_migration_pte,
-		.arg = src,
+		.arg = &rmap_walk_arg,
 	};
 
+	VM_BUG_ON_FOLIO(unmap_unused && src != dst, src);
+
 	if (locked)
 		rmap_walk_locked(dst, &rwc);
 	else
@@ -904,7 +961,7 @@ static int writeout(struct address_space *mapping, struct folio *folio)
 	 * At this point we know that the migration attempt cannot
 	 * be successful.
 	 */
-	remove_migration_ptes(folio, folio, false);
+	remove_migration_ptes(folio, folio, false, false);
 
 	rc = mapping->a_ops->writepage(&folio->page, &wbc);
 
@@ -1068,7 +1125,7 @@ static void migrate_folio_undo_src(struct folio *src,
 				   struct list_head *ret)
 {
 	if (page_was_mapped)
-		remove_migration_ptes(src, src, false);
+		remove_migration_ptes(src, src, false, false);
 	/* Drop an anon_vma reference if we took one */
 	if (anon_vma)
 		put_anon_vma(anon_vma);
@@ -1306,7 +1363,7 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
 		lru_add_drain();
 
 	if (old_page_state & PAGE_WAS_MAPPED)
-		remove_migration_ptes(src, dst, false);
+		remove_migration_ptes(src, dst, false, false);
 
 out_unlock_both:
 	folio_unlock(dst);
@@ -1444,7 +1501,7 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
 
 	if (page_was_mapped)
 		remove_migration_ptes(src,
-			rc == MIGRATEPAGE_SUCCESS ? dst : src, false);
+			rc == MIGRATEPAGE_SUCCESS ? dst : src, false, false);
 
 unlock_put_anon:
 	folio_unlock(dst);
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 6d66dc1c6ffa..a1630d8e0d95 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -424,7 +424,7 @@ static unsigned long migrate_device_unmap(unsigned long *src_pfns,
 			continue;
 
 		folio = page_folio(page);
-		remove_migration_ptes(folio, folio, false);
+		remove_migration_ptes(folio, folio, false, false);
 
 		src_pfns[i] = 0;
 		folio_unlock(folio);
@@ -837,7 +837,7 @@ void migrate_device_finalize(unsigned long *src_pfns,
 
 		src = page_folio(page);
 		dst = page_folio(newpage);
-		remove_migration_ptes(src, dst, false);
+		remove_migration_ptes(src, dst, false, false);
 		folio_unlock(src);
 
 		if (is_zone_device_page(page))
-- 
2.43.0


