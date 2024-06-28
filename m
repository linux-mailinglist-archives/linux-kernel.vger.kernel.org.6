Return-Path: <linux-kernel+bounces-233297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6824691B544
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 05:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 676F51C2129A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F1D6F2EC;
	Fri, 28 Jun 2024 03:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYpxeUZE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DD56F2E5
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 03:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719544046; cv=none; b=LpcKlatxlfArtflVyoSq2xf55pFU2NMFoU5Triz0LEtXOttVVC5/ybv5z4c9+QzNaZHpflT4DY2q2qAKzEDjE/WlcGR+j4aXHH8j8ePqzm8GnQlnPsS5VOctU5swsElTZS3BXTcmLQ6ThDiuD+3yndwBrl2syvDmdeB4hAi/K3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719544046; c=relaxed/simple;
	bh=lrAcBtSPY8wF6yEhTYORr+zHxr4lEQSsuXyA2QNdVVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qe5/+RauRDafjl/jVNhfBmaE8WJ91MUZg+SpQdZcJ777wtmuYtFslpuLH7NUAfZ/MSkhQsFZVk0jxFTFfQD3Ojlhzly9muVg2XGCP/XyQO41efJZ8IMcSoVS3CG1VbkoA4N5XfQW8YwOh9xr0t1YJEuhYrgfmzuQWIQhYANFvHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYpxeUZE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA8BC116B1;
	Fri, 28 Jun 2024 03:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719544046;
	bh=lrAcBtSPY8wF6yEhTYORr+zHxr4lEQSsuXyA2QNdVVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OYpxeUZEAarVD5SnSCfgAbdk57grg3isCoQNmyTfbmHWGcxRADl1KA0GOLSwNsskB
	 1LQ/VpAl4JEWfjQiJXUpI80DZ98V1A82SK/ZeiZy4Dik+eGYGzuIR5W4BVCiaZ3uT6
	 Bp4+4/OlTxkjz2cxCoEmrLAnnozkhD8LBnhHpPn+mBir2MUoS3t31oZxuqRGdiXY9+
	 7YHLfuEPWLEtKBZLqm2gMIR/DXTs7xnUEYLYYZ5m6qjLL0rczZzWptVCpk7eykyEof
	 41Hd/z51hpHJWSSAZXHTHQuNpIjqUI+MH33JNtZgqR8PQmPy0us8dObV2536bZ6yNP
	 03ZYClyRuJqKg==
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
	42.hyeyoo@gmail.com
Cc: Alex Shi <alexs@kernel.org>
Subject: [PATCH 10/20] mm/zsmalloc: add zpdesc_is_isolated/zpdesc_zone helper for zs_page_migrate
Date: Fri, 28 Jun 2024 11:11:25 +0800
Message-ID: <20240628031138.429622-11-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240628031138.429622-1-alexs@kernel.org>
References: <20240628031138.429622-1-alexs@kernel.org>
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
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zpdesc.h   | 11 +++++++++++
 mm/zsmalloc.c | 30 ++++++++++++++++--------------
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index f998d65c59d6..2e35b8220e05 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -98,4 +98,15 @@ static inline void __zpdesc_set_movable(struct zpdesc *zpdesc,
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
index 3ef8e13fb9e6..251a6e63e58a 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1835,19 +1835,21 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
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
@@ -1864,30 +1866,30 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
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
@@ -1896,14 +1898,14 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
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


