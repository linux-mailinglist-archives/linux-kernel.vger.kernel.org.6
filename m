Return-Path: <linux-kernel+bounces-284342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DF9950016
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBE2A28442A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9E416DEBD;
	Tue, 13 Aug 2024 08:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjhJrf/w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A285316C854
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723538474; cv=none; b=utpZRPb1bBs6HrLI+mVmabCSg0Me45U1Q8yy9dORz2NDdmjxOcxC7DD4/OvF0Ga+8bPG8pUEXYoH8mWe+VJlVmc1FPw5CymW53kgkoramJjBWyGEK5er2i9n8ufnJIT9geKZ9b8yyquwRElOb5NmWx2dGuKg2WfmP50DZ/GvFP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723538474; c=relaxed/simple;
	bh=PQtx1dFIRykqdoAci1ap2Dlk7DGGX895wpZmxxTa/no=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKZHfAJKRxVc0JLWL2XeEcHH5kQJ08AVhPXiY9PpnClPGCTav/maArmeGlt9ZffR6e/ddxulspeO2GMkYXn9VTzA2Bbg4ch+gpg1mDG5/WuZd72bLhVdCbSYQiJI0c4NhbqOGl95qXidOszRCMUKelPY8fM1lYEWVflNxh2t820=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjhJrf/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2888C4AF10;
	Tue, 13 Aug 2024 08:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723538474;
	bh=PQtx1dFIRykqdoAci1ap2Dlk7DGGX895wpZmxxTa/no=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JjhJrf/wtkBI9UEBsUcawJtJs8gmNmxHrh1Mo480fI0G6gJrj94bzUPkFtEItVqaS
	 vvk0HHpWOyA7tNNTEQi1OU+L8oYA8et3hJzE0UaFiy78T/w0wveVetYoCybv1xZK62
	 NzuSeIFYgYQ6JtJxEw3MRxT41R0yHnWLIUbY2OTTnF8YYcp2OAEnS6xAlUbToI8mEI
	 ot2el35HS7YnXfjX0Jak615XPEbamwZncUhoSUIXXPWDvOhKVojS7FDYeyhsjH78nq
	 WuhR1Ueh4Scg40xQw0c26/I0EtwDGn1eQe2qGoIibIksi2gBQ+R+qISZyjaFJIxj1N
	 bcX3wurSiw0Pg==
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
Subject: [PATCH v6 02/21] mm/zsmalloc: use zpdesc in trylock_zspage()/lock_zspage()
Date: Tue, 13 Aug 2024 16:45:48 +0800
Message-ID: <20240813084611.4122571-3-alexs@kernel.org>
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

From: Alex Shi <alexs@kernel.org>

To use zpdesc in trylock_zspage()/lock_zspage() funcs, we add couple of helpers:
zpdesc_lock()/zpdesc_unlock()/zpdesc_trylock()/zpdesc_wait_locked() and
zpdesc_get()/zpdesc_put() for this purpose.

Here we use the folio series func in guts for 2 reasons, one zswap.zpool
only get single page, and use folio could save some compound_head checking;
two, folio_put could bypass devmap checking that we don't need.

BTW, thanks Intel LKP found a build warning on the patch.

Originally-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zpdesc.h   | 30 ++++++++++++++++++++++++
 mm/zsmalloc.c | 64 ++++++++++++++++++++++++++++++++++-----------------
 2 files changed, 73 insertions(+), 21 deletions(-)

diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index 721ef8861131..782b5ad67cda 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -69,4 +69,34 @@ static_assert(sizeof(struct zpdesc) <= sizeof(struct page));
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
index 30f0a7abbda3..25c90224f21f 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -433,13 +433,17 @@ static __maybe_unused int is_first_page(struct page *page)
 	return PagePrivate(page);
 }
 
+static inline bool is_first_zpdesc(struct zpdesc *zpdesc)
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
@@ -453,6 +457,14 @@ static inline struct page *get_first_page(struct zspage *zspage)
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
@@ -745,6 +757,16 @@ static struct page *get_next_page(struct page *page)
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
@@ -815,11 +837,11 @@ static void reset_page(struct page *page)
 
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
@@ -827,9 +849,9 @@ static int trylock_zspage(struct zspage *zspage)
 
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
@@ -1658,7 +1680,7 @@ static int putback_zspage(struct size_class *class, struct zspage *zspage)
  */
 static void lock_zspage(struct zspage *zspage)
 {
-	struct page *curr_page, *page;
+	struct zpdesc *curr_zpdesc, *zpdesc;
 
 	/*
 	 * Pages we haven't locked yet can be migrated off the list while we're
@@ -1670,24 +1692,24 @@ static void lock_zspage(struct zspage *zspage)
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


