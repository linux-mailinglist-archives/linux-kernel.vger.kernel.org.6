Return-Path: <linux-kernel+bounces-284360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBE495002F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB9B9B262D5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3550617CA02;
	Tue, 13 Aug 2024 08:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6kjY4QB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7E817C228
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723538541; cv=none; b=r2OIXeshVvM4fh7saDBHZ4ZzFU1JWzy6MrA0AJp4FQqVqoCi8P0D4/e9xxi7zaKClWFhtd0nsGje4fh9EIU3+b/trKcQ30Sp4fK6KQYik2t1/K3U6Z3qV6vZAuW3DcvXGDzAgPSpWsO1TFOWwEr3tqGYhA8RN/ol7201u/K6l94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723538541; c=relaxed/simple;
	bh=7RDgs8VMI/6+eF2Z36b9xbjlJF/pcQYAzN7TZVLEquw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZdXtSNdrj6JVkE1jDfb0x83WVliM7pS+7i/yUsy188f/YwLyIY32IahVtn+IoCfLyyhJoFLMUxogpBR1xDuFQeBOtJ7y2w5o45eC+CHbsIWMaZ3HnqzH2xo9Jbwp4LRpzCFPagi85Ko97Vp2HEnN1ANTyt8BKYsq6U6JWC/W3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6kjY4QB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4173C4AF0B;
	Tue, 13 Aug 2024 08:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723538541;
	bh=7RDgs8VMI/6+eF2Z36b9xbjlJF/pcQYAzN7TZVLEquw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e6kjY4QBWwfbNWiHe8VElP9KCnrcfr8ExLDYLTSGXAyZUKoHjuxSHsysbcFQW3sNz
	 uJOJTUslbpGJu3jmOoWVmgIAI7VIY/0WRpaO/7Imdj3ZxKk0jNedzIdBKEcvY83QS9
	 YY9frlOlRS6WTCJCdPM6OB/PEnbl13D0XWfGM1Y8xZvUWK03GC3pmj/TKRyuK1gziy
	 8l38bTjL3SNjTgdTJmSzABhQZadMZ5IlqQy5ybd4c4HkOqJ7kNnzf/l71n8EdBaMeO
	 3HPTf+qZgh21Pf9MA4I3Qsixy8tr89Dq0GHnmIOqIZ049Ah98ulIdocJHoRVakaR8i
	 p9USBCGEmOmCQ==
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
Subject: [PATCH v6 19/21] mm/zsmalloc: introduce __zpdesc_clear/set_zsmalloc()
Date: Tue, 13 Aug 2024 16:46:05 +0800
Message-ID: <20240813084611.4122571-20-alexs@kernel.org>
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

Add helper __zpdesc_clear_zsmalloc() for __ClearPageZsmalloc(),
__zpdesc_set_zsmalloc() for __SetPageZsmalloc(), and use them in
callers.

Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zpdesc.h   | 10 ++++++++++
 mm/zsmalloc.c |  8 ++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index 747a2d410a35..33f599081281 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -120,6 +120,16 @@ static inline void __zpdesc_clear_movable(struct zpdesc *zpdesc)
 	__ClearPageMovable(zpdesc_page(zpdesc));
 }
 
+static inline void __zpdesc_set_zsmalloc(struct zpdesc *zpdesc)
+{
+	__SetPageZsmalloc(zpdesc_page(zpdesc));
+}
+
+static inline void __zpdesc_clear_zsmalloc(struct zpdesc *zpdesc)
+{
+	__ClearPageZsmalloc(zpdesc_page(zpdesc));
+}
+
 static inline bool zpdesc_is_isolated(struct zpdesc *zpdesc)
 {
 	return PageIsolated(zpdesc_page(zpdesc));
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 64b9ea011111..6e7cd5acf5e5 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -845,7 +845,7 @@ static void reset_zpdesc(struct zpdesc *zpdesc)
 	zpdesc->zspage = NULL;
 	zpdesc->next = NULL;
 	reset_first_obj_offset(zpdesc);
-	__ClearPageZsmalloc(page);
+	__zpdesc_clear_zsmalloc(zpdesc);
 }
 
 static int trylock_zspage(struct zspage *zspage)
@@ -1018,13 +1018,13 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 		if (!zpdesc) {
 			while (--i >= 0) {
 				zpdesc_dec_zone_page_state(zpdescs[i]);
-				__ClearPageZsmalloc(zpdesc_page(zpdescs[i]));
+				__zpdesc_clear_zsmalloc(zpdescs[i]);
 				free_zpdesc(zpdescs[i]);
 			}
 			cache_free_zspage(pool, zspage);
 			return NULL;
 		}
-		__SetPageZsmalloc(zpdesc_page(zpdesc));
+		__zpdesc_set_zsmalloc(zpdesc);
 
 		zpdesc_inc_zone_page_state(zpdesc);
 		zpdescs[i] = zpdesc;
@@ -1814,7 +1814,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	VM_BUG_ON_PAGE(!zpdesc_is_isolated(zpdesc), zpdesc_page(zpdesc));
 
 	/* We're committed, tell the world that this is a Zsmalloc page. */
-	__SetPageZsmalloc(zpdesc_page(newzpdesc));
+	__zpdesc_set_zsmalloc(newzpdesc);
 
 	/* The page is locked, so this pointer must remain valid */
 	zspage = get_zspage(zpdesc);
-- 
2.43.0


