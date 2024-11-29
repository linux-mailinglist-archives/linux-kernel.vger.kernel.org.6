Return-Path: <linux-kernel+bounces-425201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D09329DBECD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 03:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B7F6164A36
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 02:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59F714F12D;
	Fri, 29 Nov 2024 02:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="C8de6NLX"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49C41EA65
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 02:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732848792; cv=none; b=ummoj/mMfkPd3Nx/GrnNF9lmF8H7jH/K/lYvUIta2zrn4K45kJH1Wcd0c+Gf2Wd+Eni9stK1cxeEtQe8nZK+P4OyiTG6kFQ7D34/SC8d/1uuQJrlL0FZFPP4gP2mrx6k1/e/pkx11DjWoLvMfu5c9bA7aS+m0RrbMDdpxTKR0m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732848792; c=relaxed/simple;
	bh=hV4CJ8jIP2Z2qcpCB+gDG80Q94XgtY6CFLip8fceSm0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aPugAxtiSWDSY6tjW3nqGvPKZzIvnjUv76aDv0Vc9PnILLM+Y2UzzQnzl5F9iNNI1HETam+x1bTT8XASVvCUiiubzZs29q10vBufEYWoC0lZFUt5/rGX4kIvN9Rr/90wGirXgbQcFBJEP/v44hWlz/L5x+BfXqGtKSfvmoi1q5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=C8de6NLX; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=iAZhN
	5QA1fVtJxok5Hv4iANgsbTu1WmImQVILA5WLKo=; b=C8de6NLXQRLSmrnogsPMv
	NGFCsRFI+x4CccNUOEqADPh3JWFjym3e+z3L8wSOcmtXYjWad836fneN+7kAaukl
	Tzl8DdblXOoqxxZEr/Sfg5xVOeztPoQkFTzFQslbb1RIJ2kBvlX162Q5ZVEs27EL
	V8jMf5ijwWFzrOGdl5IKhQ=
Received: from localhost.localdomain (unknown [111.35.188.140])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDXjT5eLElnqS_yKQ--.30366S4;
	Fri, 29 Nov 2024 10:52:27 +0800 (CST)
From: David Wang <00107082@163.com>
To: surenb@google.com,
	yuzhao@google.com,
	kent.overstreet@linux.dev,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	David Wang <00107082@163.com>
Subject: [PATCH v2] mm/codetag: swap tags when migrate pages
Date: Fri, 29 Nov 2024 10:52:13 +0800
Message-Id: <20241129025213.34836-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241128102619.707071-1-00107082@163.com>
References: <20241128102619.707071-1-00107082@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXjT5eLElnqS_yKQ--.30366S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFWkZrW3JFyxtF43Cw1Dtrb_yoWrZrWkpF
	W0g3W7Ga98JFy7WrWv9r1qvr13X3yxt3yxAFWaka4fu3W3tw4vkw1Dt34jqF45ZFyUJFna
	vr4vqF1Fg3WUJa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE8nYUUUUUU=
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiMximqmdJKQiGQgAAss

Current solution to adjust codetag references during page migration is
done in 3 steps:
1. sets the codetag reference of the old page as empty (not pointing
to any codetag);
2. subtracts counters of the new page to compensate for its own allocation;
3. sets codetag reference of the new page to point to the codetag of
the old page.
This does not work if CONFIG_MEM_ALLOC_PROFILING_DEBUG=n because
set_codetag_empty() becomes NOOP. Instead, let's simply swap codetag
references so that the new page is referencing the old codetag and the
old page is referencing the new codetag. This way accounting stays
valid and the logic makes more sense.

Fixes: e0a955bf7f61 ("mm/codetag: add pgalloc_tag_copy()")
Signed-off-by: David Wang <00107082@163.com>
Closes: https://lore.kernel.org/lkml/20241124074318.399027-1-00107082@163.com/
Acked-by: Suren Baghdasaryan <surenb@google.com>
Suggested-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/pgalloc_tag.h |  4 ++--
 lib/alloc_tag.c             | 36 ++++++++++++++++++++++--------------
 mm/migrate.c                |  2 +-
 3 files changed, 25 insertions(+), 17 deletions(-)

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
index 2414a7ee7ec7..35f7560a309a 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -189,26 +189,34 @@ void pgalloc_tag_split(struct folio *folio, int old_order, int new_order)
 	}
 }
 
-void pgalloc_tag_copy(struct folio *new, struct folio *old)
+void pgalloc_tag_swap(struct folio *new, struct folio *old)
 {
-	union pgtag_ref_handle handle;
-	union codetag_ref ref;
-	struct alloc_tag *tag;
+	union pgtag_ref_handle handle_old, handle_new;
+	union codetag_ref ref_old, ref_new;
+	struct alloc_tag *tag_old, *tag_new;
 
-	tag = pgalloc_tag_get(&old->page);
-	if (!tag)
+	tag_old = pgalloc_tag_get(&old->page);
+	if (!tag_old)
+		return;
+	tag_new = pgalloc_tag_get(&new->page);
+	if (!tag_new)
 		return;
 
-	if (!get_page_tag_ref(&new->page, &ref, &handle))
+	if (!get_page_tag_ref(&old->page, &ref_old, &handle_old))
 		return;
+	if (!get_page_tag_ref(&new->page, &ref_new, &handle_new)) {
+		put_page_tag_ref(handle_old);
+		return;
+	}
+
+	/* swap tags */
+	__alloc_tag_ref_set(&ref_old, tag_new);
+	update_page_tag_ref(handle_old, &ref_old);
+	__alloc_tag_ref_set(&ref_new, tag_old);
+	update_page_tag_ref(handle_new, &ref_new);
 
-	/* Clear the old ref to the original allocation tag. */
-	clear_page_tag_ref(&old->page);
-	/* Decrement the counters of the tag on get_new_folio. */
-	alloc_tag_sub(&ref, folio_size(new));
-	__alloc_tag_ref_set(&ref, tag);
-	update_page_tag_ref(handle, &ref);
-	put_page_tag_ref(handle);
+	put_page_tag_ref(handle_old);
+	put_page_tag_ref(handle_new);
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


