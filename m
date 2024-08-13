Return-Path: <linux-kernel+bounces-284351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40668950023
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B706C2869ED
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DB819A28C;
	Tue, 13 Aug 2024 08:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOOxP1Wv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B790A197A61
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723538505; cv=none; b=QUw9PPJNtWZaml0wL9vl0aLHokyJUK4gga4WjpxJ3z5pRo7Ta43PnVGWn0g6hyUU9XE01XfuMDDo0NPWWIA9d5C4s/+eIums8NeIo5k5ZLkfWqjJL0KPf0qVqsLXAkpbUSuzUZrArb4FYxewcIHcB4aXJvn2yzPJ6RjG0R6QSqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723538505; c=relaxed/simple;
	bh=UmY8mz0Mo/B8gMn4RPUMsn8q8kByucvcQFpc8ROaoN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YT1vyvZ2gv3QQsF/9jRfn8LGXBxNm7y8KZwkil2l1O7fSuZelEl7Wn+31B+7RRboL6LsTDvMxZOJM1yj1j5XOhMOrufHGwSW6M4aovu6Gzak/4d0+PhIu8Zg5GMU531mPQkXgD2oN8IxR+SwG/fHpoIrTnQ2beFTxkuYWrAfmTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOOxP1Wv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45719C4AF10;
	Tue, 13 Aug 2024 08:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723538505;
	bh=UmY8mz0Mo/B8gMn4RPUMsn8q8kByucvcQFpc8ROaoN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dOOxP1WvR4nlRS/PNgkaS23vVd55SRWG+qIRE209IfYLyLsqGZjR7PklKPuEYICYJ
	 XeL5/VZs+2k81LiQUCMDbY4hJfhw4fIletndPnqrB4P0GXkBkofSmpzqnXYOO081Vr
	 3SsdAS8ceOfC1hyNu2WdynXMx5o2fHHL46sbzY8uTYIY+G2F3A8bGMOAObdCoZUTPj
	 C9KAAb+2OfoGY1Y25Imog1SooutwDOnDEry17xuJOhHxDogxrQXQUpB1DLISTIjOhT
	 YiZI9A/IdZ7bhzYUmI36JbUZqh/Bs9jLalJ5FRfHyT+W2uibxDS6T1OFyvVi1gHpmq
	 ZRXdWlzPjK9Sw==
From: alexs@kernel.org
To: Vitaly Wool <vitaly.wool@konsulko.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	minchan@kernel.org,
	willy@infradead.org,
	senozhatsky@chromium.org,
	david@redhat.com,
	42.hyeyoo@gmail.com,
	Yosry Ahmed <yosryahmed@google.com>,
	nphamcs@gmail.com
Cc: Alex Shi <alexs@kernel.org>
Subject: [PATCH v6 10/21] mm/zsmalloc: add zpdesc_is_isolated()/zpdesc_zone() helper for zs_page_migrate()
Date: Tue, 13 Aug 2024 16:45:56 +0800
Message-ID: <20240813084611.4122571-11-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240813084611.4122571-1-alexs@kernel.org>
References: <20240813084611.4122571-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hyeonggon Yoo <42.hyeyoo@gmail.com>

To convert page to zpdesc in zs_page_migrate(), we added
zpdesc_is_isolated()/zpdesc_zone() helpers. No functional change.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zpdesc.h   | 11 +++++++++++
 mm/zsmalloc.c | 30 ++++++++++++++++--------------
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index 3a65a7d494b7..4b42d8517fcb 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -114,4 +114,15 @@ static inline void __zpdesc_set_movable(struct zpdesc *zpdesc,
 {
 	__SetPageMovable(zpdesc_page(zpdesc), mops);
 }
+
+static inline bool zpdesc_is_isolated(struct zpdesc *zpdesc)
+{
+	return PageIsolated(zpdesc_page(zpdesc));
+}
+
+static inline struct zone *zpdesc_zone(struct zpdesc *zpdesc)
+{
+	return page_zone(zpdesc_page(zpdesc));
+}
+
 #endif
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index cb90defd3c0a..65c4252412b3 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1824,19 +1824,21 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	struct size_class *class;
 	struct zspage *zspage;
 	struct zpdesc *dummy;
+	struct zpdesc *newzpdesc = page_zpdesc(newpage);
+	struct zpdesc *zpdesc = page_zpdesc(page);
 	void *s_addr, *d_addr, *addr;
 	unsigned int offset;
 	unsigned long handle;
 	unsigned long old_obj, new_obj;
 	unsigned int obj_idx;
 
-	VM_BUG_ON_PAGE(!PageIsolated(page), page);
+	VM_BUG_ON_PAGE(!zpdesc_is_isolated(zpdesc), zpdesc_page(zpdesc));
 
 	/* We're committed, tell the world that this is a Zsmalloc page. */
-	__SetPageZsmalloc(newpage);
+	__SetPageZsmalloc(zpdesc_page(newzpdesc));
 
 	/* The page is locked, so this pointer must remain valid */
-	zspage = get_zspage(page);
+	zspage = get_zspage(zpdesc_page(zpdesc));
 	pool = zspage->pool;
 
 	/*
@@ -1853,30 +1855,30 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	/* the migrate_write_lock protects zpage access via zs_map_object */
 	migrate_write_lock(zspage);
 
-	offset = get_first_obj_offset(page);
-	s_addr = kmap_atomic(page);
+	offset = get_first_obj_offset(zpdesc_page(zpdesc));
+	s_addr = zpdesc_kmap_atomic(zpdesc);
 
 	/*
 	 * Here, any user cannot access all objects in the zspage so let's move.
 	 */
-	d_addr = kmap_atomic(newpage);
+	d_addr = zpdesc_kmap_atomic(newzpdesc);
 	copy_page(d_addr, s_addr);
 	kunmap_atomic(d_addr);
 
 	for (addr = s_addr + offset; addr < s_addr + PAGE_SIZE;
 					addr += class->size) {
-		if (obj_allocated(page_zpdesc(page), addr, &handle)) {
+		if (obj_allocated(zpdesc, addr, &handle)) {
 
 			old_obj = handle_to_obj(handle);
 			obj_to_location(old_obj, &dummy, &obj_idx);
-			new_obj = (unsigned long)location_to_obj(newpage,
+			new_obj = (unsigned long)location_to_obj(zpdesc_page(newzpdesc),
 								obj_idx);
 			record_obj(handle, new_obj);
 		}
 	}
 	kunmap_atomic(s_addr);
 
-	replace_sub_page(class, zspage, page_zpdesc(newpage), page_zpdesc(page));
+	replace_sub_page(class, zspage, newzpdesc, zpdesc);
 	/*
 	 * Since we complete the data copy and set up new zspage structure,
 	 * it's okay to release migration_lock.
@@ -1885,14 +1887,14 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	spin_unlock(&class->lock);
 	migrate_write_unlock(zspage);
 
-	get_page(newpage);
-	if (page_zone(newpage) != page_zone(page)) {
-		dec_zone_page_state(page, NR_ZSPAGES);
-		inc_zone_page_state(newpage, NR_ZSPAGES);
+	zpdesc_get(newzpdesc);
+	if (zpdesc_zone(newzpdesc) != zpdesc_zone(zpdesc)) {
+		zpdesc_dec_zone_page_state(zpdesc);
+		zpdesc_inc_zone_page_state(newzpdesc);
 	}
 
 	reset_page(page);
-	put_page(page);
+	zpdesc_put(zpdesc);
 
 	return MIGRATEPAGE_SUCCESS;
 }
-- 
2.43.0


