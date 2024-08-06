Return-Path: <linux-kernel+bounces-275587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0269F948770
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B1F51F252EC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1705310A0E;
	Tue,  6 Aug 2024 02:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O01JxTsF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5901FDF5C
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 02:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722910712; cv=none; b=uUzqA2twP3KekbFEZ2+0Ky7XalVNcZre+LP9VItqIN3O+XWJ7QcrPbhtohmUaoV8XeWOLHQCmGvyzDy4sX69/6JcHNEoMs0RwyKL3C+oQU/R3T/wQ4cUAXsNsUfoG4uAEdXaZdlduqCyQYrwlmBForWFHiqSIpM95AceTObLVjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722910712; c=relaxed/simple;
	bh=jd//d/JKjS/cL1w5x1hSjGz2Vv8a8C5I3yz/l4s7SBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bqko8Ifi/zBkBSOL3H7e3PJ6vwBHDIRQEue9aOQwb6fGsCwnCTHkdGIFiGR994I8bAUb2dV/wpPOpd09ejD58JAR4KQX2OTmJXVAJOeV5MiMsfxNa5PCF0yb/sPDJHvP6MbPlmTFibYLolTJ5uoOw2XGQnrK9vEDb1aApW5zr+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O01JxTsF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C64C32782;
	Tue,  6 Aug 2024 02:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722910712;
	bh=jd//d/JKjS/cL1w5x1hSjGz2Vv8a8C5I3yz/l4s7SBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O01JxTsFcnRCOHKuPEnby1tCq8aWX74P/c0exfYMK/J/CPxNyd8q5/bPamjiRPu/D
	 Jbdq5g/rE4MKhzhnGw6Y+VEGx66ZKCcPQDJlAoDr/Ho7DFKt3N+Ej0/Y+xm+s8hkZ1
	 2pbU44Dg9XOKAaX+Ya+IpbEvo2BwfU0yv8ESApwHCdGk424aYgHyqyBtoK8f/UUPay
	 XPT+/plQr4/OmfpRfFVDj3hPa3nI0wbRBKhBeb0/doYypbQPMnKCJu4N90NLDyF7ER
	 gCMoDrX+hji7qleXNI8IYn1jvUXVJzmAni/q1ZINV1LIEht6CBgEA6xQtXk/vEztSv
	 0Xwt2TumKKccg==
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
Subject: [PATCH v5 10/21] mm/zsmalloc: add zpdesc_is_isolated()/zpdesc_zone() helper for zs_page_migrate()
Date: Tue,  6 Aug 2024 10:22:57 +0800
Message-ID: <20240806022311.3924442-11-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240806022311.3924442-1-alexs@kernel.org>
References: <20240806022143.3924396-1-alexs@kernel.org>
 <20240806022311.3924442-1-alexs@kernel.org>
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
index 6a01e09e4beb..20881e7e42be 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -113,4 +113,15 @@ static inline void __zpdesc_set_movable(struct zpdesc *zpdesc,
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
index 5fac2bb436f8..398b602a3b4d 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1810,19 +1810,21 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
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
@@ -1839,30 +1841,30 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
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
@@ -1871,14 +1873,14 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
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


