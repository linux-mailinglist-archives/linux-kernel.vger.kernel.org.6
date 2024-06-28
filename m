Return-Path: <linux-kernel+bounces-233289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A60B591B53C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 05:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 283671F21EB2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9078422638;
	Fri, 28 Jun 2024 03:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxYPxwOw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3895225D4
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 03:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719544016; cv=none; b=YiPKRc+SzhgAxVlpN5NJCGmge5wKU4NECL0ywPRwPD4q2nE3UUH7Dey9Up0uADXTSMm5AFIj8k8F1On5pdkdtzc+4JTjGsxBnNTmEYEMHH8wZA1N84eMlzYLFHbD5cgYLl3OlzHMHaXr0rbBqG4pAf7LlX+lk8h4KkOkhoGmkmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719544016; c=relaxed/simple;
	bh=wX8wNBVCAeYaipWwjXbga4FkUGc1GqAIKlVyc5psJK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i9VXVu41oqlNa1M7mCsny6uQzc2HEk69KZb8XqkAIjN5nlxCeGEYgNqxP7dNaL73q88LXZr8L7o0SaYbKFE3GqAern6g0faDnVFj304O+YB6J1kWXqnd1ICjle/4FLD5fpOOCvurvEeMTXk02UW8Ri+tGpmRXlJmKAROZdocOPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxYPxwOw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89772C2BBFC;
	Fri, 28 Jun 2024 03:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719544016;
	bh=wX8wNBVCAeYaipWwjXbga4FkUGc1GqAIKlVyc5psJK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uxYPxwOwKZkbAWcRCcj/faaq1syYlYM8BWU58yRNfmwar7N4AMMqbCcR61gQJ3hmJ
	 nB9GYWciKXfEiUS4NLgEoiQquUcjB/0zyoiAKOBO8+xHDR4G1NEdIJ+wzy6h/WKB6H
	 CLp9kQKd6Nbc+hxoc8kVP2YhPDyc6geIASE7dPiNVOMTMETM/IOUEOHBiw4hZ7rRVu
	 65oZiddBo5ncFNhCp1hfrtQm0GC4UA4uaVNCI03ksluRAywiDglD098AbmGckA0pU3
	 FHTvWD16NC64U9SYB4VXsPbRUDHmAuFRN4VfeFfhLySAXPbaYWFPevnO5EHDrJ8et0
	 7d+6X6G15pkQg==
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
Subject: [PATCH 02/20] mm/zsmalloc: use zpdesc in trylock_zspage/lock_zspage
Date: Fri, 28 Jun 2024 11:11:17 +0800
Message-ID: <20240628031138.429622-3-alexs@kernel.org>
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

From: Alex Shi <alexs@kernel.org>

To use zpdesc in trylock_zspage/lock_zspage funcs, we add couple of helpers:
zpdesc_lock/zpdesc_unlock/zpdesc_trylock/zpdesc_wait_locked and
zpdesc_get/zpdesc_put for this purpose.

Here we use the folio series func in guts for 2 reasons, one zswap.zpool
only get single page, and use folio could save some compound_head checking;
two, folio_put could bypass devmap checking that we don't need.

Originally-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zpdesc.h   | 30 ++++++++++++++++++++++++
 mm/zsmalloc.c | 64 ++++++++++++++++++++++++++++++++++-----------------
 2 files changed, 73 insertions(+), 21 deletions(-)

diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index a1ab5ebaa936..fd95277843d5 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -53,4 +53,34 @@ static_assert(sizeof(struct zpdesc) <= sizeof(struct page));
 	const struct page *:		(const struct zpdesc *)(p),	\
 	struct page *:			(struct zpdesc *)(p)))
 
+static inline void zpdesc_lock(struct zpdesc *zpdesc)
+{
+	folio_lock(zpdesc_folio(zpdesc));
+}
+
+static inline bool zpdesc_trylock(struct zpdesc *zpdesc)
+{
+	return folio_trylock(zpdesc_folio(zpdesc));
+}
+
+static inline void zpdesc_unlock(struct zpdesc *zpdesc)
+{
+	folio_unlock(zpdesc_folio(zpdesc));
+}
+
+static inline void zpdesc_wait_locked(struct zpdesc *zpdesc)
+{
+	folio_wait_locked(zpdesc_folio(zpdesc));
+}
+
+static inline void zpdesc_get(struct zpdesc *zpdesc)
+{
+	folio_get(zpdesc_folio(zpdesc));
+}
+
+static inline void zpdesc_put(struct zpdesc *zpdesc)
+{
+	folio_put(zpdesc_folio(zpdesc));
+}
+
 #endif
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 67bb80b7413a..9835121109d1 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -435,13 +435,17 @@ static __maybe_unused int is_first_page(struct page *page)
 	return PagePrivate(page);
 }
 
+static int is_first_zpdesc(struct zpdesc *zpdesc)
+{
+	return PagePrivate(zpdesc_page(zpdesc));
+}
+
 /* Protected by class->lock */
 static inline int get_zspage_inuse(struct zspage *zspage)
 {
 	return zspage->inuse;
 }
 
-
 static inline void mod_zspage_inuse(struct zspage *zspage, int val)
 {
 	zspage->inuse += val;
@@ -455,6 +459,14 @@ static inline struct page *get_first_page(struct zspage *zspage)
 	return first_page;
 }
 
+static struct zpdesc *get_first_zpdesc(struct zspage *zspage)
+{
+	struct zpdesc *first_zpdesc = zspage->first_zpdesc;
+
+	VM_BUG_ON_PAGE(!is_first_zpdesc(first_zpdesc), zpdesc_page(first_zpdesc));
+	return first_zpdesc;
+}
+
 #define FIRST_OBJ_PAGE_TYPE_MASK	0xffff
 
 static inline void reset_first_obj_offset(struct page *page)
@@ -747,6 +759,16 @@ static struct page *get_next_page(struct page *page)
 	return (struct page *)page->index;
 }
 
+static struct zpdesc *get_next_zpdesc(struct zpdesc *zpdesc)
+{
+	struct zspage *zspage = get_zspage(zpdesc_page(zpdesc));
+
+	if (unlikely(ZsHugePage(zspage)))
+		return NULL;
+
+	return zpdesc->next;
+}
+
 /**
  * obj_to_location - get (<page>, <obj_idx>) from encoded object value
  * @obj: the encoded object value
@@ -817,11 +839,11 @@ static void reset_page(struct page *page)
 
 static int trylock_zspage(struct zspage *zspage)
 {
-	struct page *cursor, *fail;
+	struct zpdesc *cursor, *fail;
 
-	for (cursor = get_first_page(zspage); cursor != NULL; cursor =
-					get_next_page(cursor)) {
-		if (!trylock_page(cursor)) {
+	for (cursor = get_first_zpdesc(zspage); cursor != NULL; cursor =
+					get_next_zpdesc(cursor)) {
+		if (!zpdesc_trylock(cursor)) {
 			fail = cursor;
 			goto unlock;
 		}
@@ -829,9 +851,9 @@ static int trylock_zspage(struct zspage *zspage)
 
 	return 1;
 unlock:
-	for (cursor = get_first_page(zspage); cursor != fail; cursor =
-					get_next_page(cursor))
-		unlock_page(cursor);
+	for (cursor = get_first_zpdesc(zspage); cursor != fail; cursor =
+					get_next_zpdesc(cursor))
+		zpdesc_unlock(cursor);
 
 	return 0;
 }
@@ -1663,7 +1685,7 @@ static int putback_zspage(struct size_class *class, struct zspage *zspage)
  */
 static void lock_zspage(struct zspage *zspage)
 {
-	struct page *curr_page, *page;
+	struct zpdesc *curr_zpdesc, *zpdesc;
 
 	/*
 	 * Pages we haven't locked yet can be migrated off the list while we're
@@ -1675,24 +1697,24 @@ static void lock_zspage(struct zspage *zspage)
 	 */
 	while (1) {
 		migrate_read_lock(zspage);
-		page = get_first_page(zspage);
-		if (trylock_page(page))
+		zpdesc = get_first_zpdesc(zspage);
+		if (zpdesc_trylock(zpdesc))
 			break;
-		get_page(page);
+		zpdesc_get(zpdesc);
 		migrate_read_unlock(zspage);
-		wait_on_page_locked(page);
-		put_page(page);
+		zpdesc_wait_locked(zpdesc);
+		zpdesc_put(zpdesc);
 	}
 
-	curr_page = page;
-	while ((page = get_next_page(curr_page))) {
-		if (trylock_page(page)) {
-			curr_page = page;
+	curr_zpdesc = zpdesc;
+	while ((zpdesc = get_next_zpdesc(curr_zpdesc))) {
+		if (zpdesc_trylock(zpdesc)) {
+			curr_zpdesc = zpdesc;
 		} else {
-			get_page(page);
+			zpdesc_get(zpdesc);
 			migrate_read_unlock(zspage);
-			wait_on_page_locked(page);
-			put_page(page);
+			zpdesc_wait_locked(zpdesc);
+			zpdesc_put(zpdesc);
 			migrate_read_lock(zspage);
 		}
 	}
-- 
2.43.0


