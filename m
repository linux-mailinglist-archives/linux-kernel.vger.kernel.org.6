Return-Path: <linux-kernel+bounces-238818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9136D92517C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 06:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08513B29250
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 04:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E8C15B54E;
	Wed,  3 Jul 2024 04:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1t7hQXJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2825158879
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 04:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719979315; cv=none; b=JbbmmHkJNZAS+/5vmALz4k0EQwowm37OJOu1tk8LPYt7fbIyfQ6AiHtjG7tCRvmo8vSVtgX/g8xIRJJb7fFCu3NnP4W/b0yQEgb375kkgw07Cejch+SsEPZwJfPUOj2vc2hUJKlLawiD3nG+ehC8L0D5bqfPFlELvM3GXyPZX/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719979315; c=relaxed/simple;
	bh=rKWZuiJgMM3PFhIFbKbki7RwNRU1BYQ1UAI5bUa3ql8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GTvHQyLxrpzG7EicTVsayxnqFmozIfAdf3Q9lYy2Q1FDvDtWhVclCFeKqhKO3PjA1mc9Ldr3Opd8Nxe+BXbgtkdU8VZIKSAGIsegX18b7NMtmiJbJL9W4I4Ww0o5UgvicIHnLucmhR4Pexyd1qXHzw09OqGFijjBR22YhehIpts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1t7hQXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8A6C32781;
	Wed,  3 Jul 2024 04:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719979314;
	bh=rKWZuiJgMM3PFhIFbKbki7RwNRU1BYQ1UAI5bUa3ql8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f1t7hQXJQvhCEgu9b1n3nE1YlFOxjEC/c/pUUWyfXG22Tw8QUwfCTUD9VZwL94fSY
	 jv3/8d/eHpn1e+fQuoItWy8ZyrfsKIGYgO1xWlKssWAy9Twg9jtJDGp5cvknh2HJWd
	 W5YnUonQE4WtBpZK6/z/Pci54CDg8ZV0li79TV2nbsIfnaWFZcSmGtqrgFhEgf8bOO
	 OgWHm/ztVeQ56/PIb+6/rkbf8o6xP5OOTqlSNjwL6lQI1m8k5SNG5ocMCkzRy7TSwM
	 Nqt/bERDQCtXlJL3/j3SpvyzKvCox2IVzTHeBDk2M3v70gQMtckTQ2XRIaKeFXX8LZ
	 FKT2rzHyQimFQ==
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
Subject: [PATCH v2 12/20] mm/zsmalloc: convert __free_zspage() to use zdsesc
Date: Wed,  3 Jul 2024 12:06:02 +0800
Message-ID: <20240703040613.681396-13-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240703040613.681396-1-alexs@kernel.org>
References: <20240703040613.681396-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Introduce zpdesc_is_locked() and convert __free_zspage() to use zpdesc.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zpdesc.h   |  4 ++++
 mm/zsmalloc.c | 20 ++++++++++----------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index 61d7ba0c626e..6de3c5d095bd 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -117,4 +117,8 @@ static inline struct zone *zpdesc_zone(struct zpdesc *zpdesc)
 	return page_zone(zpdesc_page(zpdesc));
 }
 
+static inline bool zpdesc_is_locked(struct zpdesc *zpdesc)
+{
+	return PageLocked(zpdesc_page(zpdesc));
+}
 #endif
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 6d1971836391..68fdea7b6e0d 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -901,23 +901,23 @@ static int trylock_zspage(struct zspage *zspage)
 static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 				struct zspage *zspage)
 {
-	struct page *page, *next;
+	struct zpdesc *zpdesc, *next;
 
 	assert_spin_locked(&class->lock);
 
 	VM_BUG_ON(get_zspage_inuse(zspage));
 	VM_BUG_ON(zspage->fullness != ZS_INUSE_RATIO_0);
 
-	next = page = get_first_page(zspage);
+	next = zpdesc = get_first_zpdesc(zspage);
 	do {
-		VM_BUG_ON_PAGE(!PageLocked(page), page);
-		next = get_next_page(page);
-		reset_zpdesc(page_zpdesc(page));
-		unlock_page(page);
-		dec_zone_page_state(page, NR_ZSPAGES);
-		put_page(page);
-		page = next;
-	} while (page != NULL);
+		VM_BUG_ON_PAGE(!zpdesc_is_locked(zpdesc), zpdesc_page(zpdesc));
+		next = get_next_zpdesc(zpdesc);
+		reset_zpdesc(zpdesc);
+		zpdesc_unlock(zpdesc);
+		zpdesc_dec_zone_page_state(zpdesc);
+		zpdesc_put(zpdesc);
+		zpdesc = next;
+	} while (zpdesc != NULL);
 
 	cache_free_zspage(pool, zspage);
 
-- 
2.43.0


