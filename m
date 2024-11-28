Return-Path: <linux-kernel+bounces-424546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 691E89DB5AD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8E01B270B1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578E718C939;
	Thu, 28 Nov 2024 10:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Md8ueVcS"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02AD157E6B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 10:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732789621; cv=none; b=AblA4hAqQl/Pruj/QQkK1z8Lxq6fxSHvbLSs0XfQSDPt60MCMejDXkHWkCkPb8q8DCQdxI7YDtzv+h8X8wxLj7QLobcRgJcfgU9KNfFOzVWA52Hsi2+eCUtvcjtjgDArNKSs/KYr5HvIQb9eoCuc56wJORMcrVQlgNdaBzhat3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732789621; c=relaxed/simple;
	bh=ia45UhDT9bIFkVLJWoe4XCcXAbtJu+kPCR/e3jMR+Z8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=acQ6sOT0xQS+ASwxyp9+47Y081D6cc6KhD+8Gig3oFGDUmjMBh41BYNdRPr4q7ijEny3vrpvlKcLE5USgeF7PBB+/bkHB1M0xm56vax5n5hgU9gCJ9/ZnlmKgRG+GXotM09VgySK+5iI3uzEcI40nzZfd/ztVk18uCdON2Es+Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Md8ueVcS; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=PlN/J
	wIS08XOn3UybnRLA84jTD+KAdku/dbRhzO6KGc=; b=Md8ueVcSicnAnQS4Kd45n
	BrIWQ3k6HvfYs4gXiqd1I2TEzXQqqUsfeV/HtvTiWw+li4Roq/D+vT45CM2RSqQG
	GzKZXJb7Fuzpce0lgbHavmEr2aft8nYNQNrYXZK/rpTMdD6ltMghhyh7fR57pg7F
	7lhk8730PTrprlJt+Pglkc=
Received: from localhost.localdomain (unknown [111.35.188.140])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDXry1MRUhn8LrHAw--.22498S4;
	Thu, 28 Nov 2024 18:26:34 +0800 (CST)
From: David Wang <00107082@163.com>
To: surenb@google.com,
	kent.overstreet@linux.dev,
	yuzhao@google.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	David Wang <00107082@163.com>
Subject: [PATCH] mm/codetag: swap tags when migrate pages
Date: Thu, 28 Nov 2024 18:26:19 +0800
Message-Id: <20241128102619.707071-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXry1MRUhn8LrHAw--.22498S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr15JF1fKFWfWF4xXFy8AFb_yoW5KFy7pF
	Wj9wnxGa98GFy7WFWvvF4qvw13J397Kay7AFW2ga4fu3WYyr4kKryDt34jqF4UuFyUJFn2
	vrsFqr1jgF1UJ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE8nYUUUUUU=
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiMxulqmdIPjvEigAAsD

The initial solution for codetag adjustment during page migration
uses three kinds of low level plumbings, those steps can be replaced
by swapping tags, which only needs one kind of low level plumbing,
and code is more clear.

Signed-off-by: David Wang <00107082@163.com>
Link: https://lore.kernel.org/lkml/20241124074318.399027-1-00107082@163.com/
---
 include/linux/pgalloc_tag.h |  4 ++--
 lib/alloc_tag.c             | 35 +++++++++++++++++++----------------
 mm/migrate.c                |  2 +-
 3 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/include/linux/pgalloc_tag.h b/include/linux/pgalloc_tag.h
index 0e43ab653ab6..3469c4b20105 100644
--- a/include/linux/pgalloc_tag.h
+++ b/include/linux/pgalloc_tag.h
@@ -231,7 +231,7 @@ static inline void pgalloc_tag_sub_pages(struct alloc_tag *tag, unsigned int nr)
 }
 
 void pgalloc_tag_split(struct folio *folio, int old_order, int new_order);
-void pgalloc_tag_copy(struct folio *new, struct folio *old);
+void pgalloc_tag_swap(struct folio *new, struct folio *old);
 
 void __init alloc_tag_sec_init(void);
 
@@ -245,7 +245,7 @@ static inline struct alloc_tag *pgalloc_tag_get(struct page *page) { return NULL
 static inline void pgalloc_tag_sub_pages(struct alloc_tag *tag, unsigned int nr) {}
 static inline void alloc_tag_sec_init(void) {}
 static inline void pgalloc_tag_split(struct folio *folio, int old_order, int new_order) {}
-static inline void pgalloc_tag_copy(struct folio *new, struct folio *old) {}
+static inline void pgalloc_tag_swap(struct folio *new, struct folio *old) {}
 
 #endif /* CONFIG_MEM_ALLOC_PROFILING */
 
diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index 2414a7ee7ec7..b45efde50c40 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -189,26 +189,29 @@ void pgalloc_tag_split(struct folio *folio, int old_order, int new_order)
 	}
 }
 
-void pgalloc_tag_copy(struct folio *new, struct folio *old)
+void pgalloc_tag_swap(struct folio *new, struct folio *old)
 {
-	union pgtag_ref_handle handle;
-	union codetag_ref ref;
-	struct alloc_tag *tag;
+	union pgtag_ref_handle handles[2];
+	union codetag_ref refs[2];
+	struct alloc_tag *tags[2];
+	struct folio *folios[2] = {new, old};
+	int i;
 
-	tag = pgalloc_tag_get(&old->page);
-	if (!tag)
-		return;
+	for (i = 0; i < 2; i++) {
+		tags[i] = pgalloc_tag_get(&folios[i]->page);
+		if (!tags[i])
+			return;
+		if (!get_page_tag_ref(&folios[i]->page, &refs[i], &handles[i]))
+			return;
+	}
 
-	if (!get_page_tag_ref(&new->page, &ref, &handle))
-		return;
+	swap(tags[0], tags[1]);
 
-	/* Clear the old ref to the original allocation tag. */
-	clear_page_tag_ref(&old->page);
-	/* Decrement the counters of the tag on get_new_folio. */
-	alloc_tag_sub(&ref, folio_size(new));
-	__alloc_tag_ref_set(&ref, tag);
-	update_page_tag_ref(handle, &ref);
-	put_page_tag_ref(handle);
+	for (i = 0; i < 2; i++) {
+		__alloc_tag_ref_set(&refs[i], tags[i]);
+		update_page_tag_ref(handles[i], &refs[i]);
+		put_page_tag_ref(handles[i]);
+	}
 }
 
 static void shutdown_mem_profiling(bool remove_file)
diff --git a/mm/migrate.c b/mm/migrate.c
index 2ce6b4b814df..cc68583c86f9 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -745,7 +745,7 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
 		folio_set_readahead(newfolio);
 
 	folio_copy_owner(newfolio, folio);
-	pgalloc_tag_copy(newfolio, folio);
+	pgalloc_tag_swap(newfolio, folio);
 
 	mem_cgroup_migrate(folio, newfolio);
 }
-- 
2.39.2


