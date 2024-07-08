Return-Path: <linux-kernel+bounces-243898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5E5929C37
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6E4B1F21476
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE54144C6C;
	Mon,  8 Jul 2024 06:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hebeQ3k0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4198943AC0
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 06:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720420159; cv=none; b=IY/zmcXuvk+3f9IautOexn3VM6UohzHTDXuGdTds2yYVBn8fPSFLJG2gII0NQThuDCVd/6K8tkmsSfuV2gJJhC94tG9iSSXu3W2hEYCWc6rqWV3AMH9YA0zeZk22kO3++GBECUmB+C5PeZPJZKe+cy09glzcwV+hTfqRQcxD8IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720420159; c=relaxed/simple;
	bh=eLEoZgV0ypx4IcCw8JtJdFgQAqXajv6Dsx6/oMszAA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AUf6F1noacmUOJfssqrLyEiPgkLHSYct5M+GsSYKsGx+WK9IbSdUa6dsTHiIYPNmy109LvloD90mIScs+cXcRdfkI6s6vz7tyEX2Nh1MQHNTHuTIKjBI3daLXABqyOTCJgQyqJH5nu1JIMakTm7dOxxYHymieheP93yIjZ0OQBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hebeQ3k0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E61C116B1;
	Mon,  8 Jul 2024 06:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720420158;
	bh=eLEoZgV0ypx4IcCw8JtJdFgQAqXajv6Dsx6/oMszAA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hebeQ3k0Iltjd3ERyywf5cF9ODSAm8MNeYFZ8QxgekeMq8VG+m6vhC9W32CO4ABH+
	 VNQ5WsibBUHoCie0KvD+wxpe1WwWSm8Mz8PAfB/bZT2Sf2qGd6xr+Q9NIGJ/m62uwG
	 o3gZug61V9v0A0bPozSxKy3eoUDzZ8U/L9/FYbbPgp2F+wsCcYJJ8qqBYoHl1nEXZY
	 iI5i+1DBM8BbNOgDhV6ZehdXQXE80fsySTLO/uiZ8Sb6krWbmGzBEH6jr98MU30fHI
	 vbfw3bUjscXkgBXIjC5Ar39fojb32Wmqggul321fu6Sr4qllQHUwE+bEWRbsjTo/jz
	 exGZ62Z3odasg==
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
Subject: [PATCH v3 10/20] mm/zsmalloc: add zpdesc_is_isolated/zpdesc_zone helper for zs_page_migrate
Date: Mon,  8 Jul 2024 14:33:31 +0800
Message-ID: <20240708063344.1096626-11-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240708063344.1096626-1-alexs@kernel.org>
References: <20240708063344.1096626-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hyeonggon Yoo <42.hyeyoo@gmail.com>

To convert page to zpdesc in zs_page_migrate(), we added
zpdesc_is_isolated/zpdesc_zone helpers. No functional change.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi (Tencent) <alexs@kernel.org>
---
 mm/zpdesc.h   | 11 +++++++++++
 mm/zsmalloc.c | 30 ++++++++++++++++--------------
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index 2293453f5d57..ad04c8337cae 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -108,4 +108,15 @@ static inline void __zpdesc_set_movable(struct zpdesc *zpdesc,
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
index 7aa4a4acaec9..9bc9b14187ed 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1830,19 +1830,21 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
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
@@ -1859,30 +1861,30 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
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
@@ -1891,14 +1893,14 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
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


