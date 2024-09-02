Return-Path: <linux-kernel+bounces-310719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 182FC968061
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA4B8B2444C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B713A188916;
	Mon,  2 Sep 2024 07:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmCwtlM6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288B915FA92
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 07:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725261459; cv=none; b=M+b94KV5/zJwjWblvE1KLDMOuHoUU6YQoKOSw9jwErlljdhCkIUlGj7j1lOSw58/Keu88IhtJf+KzFnmqY7NB29Dw50sXZEm3/yiSaQPm6RfH49VNqg1ILwnkguL2k68Kl7fn/c3B1mRCs4Y6YRMGz432osf826fwvuyIpPlpgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725261459; c=relaxed/simple;
	bh=qBTLwe3n68h/nHaRcrmhMxfrsTQQMe/QD9FAr8WVzS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jdMStZc4Y6tYP4MqDIo72EwKF01gO6Hs7LRJaIy3zX9YNXChfRcOF+GUkdKrUTvY4ren53UXbKFaN1asLOqdopLuDstEE7Vs4HLUhCK5rDJfz8h6sGN57Z9yRKvJo3V7dcCHE9HYyzBd33dgA4VCoNPwMb9VMm1sk84izOp09A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmCwtlM6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA3BC4CEC4;
	Mon,  2 Sep 2024 07:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725261459;
	bh=qBTLwe3n68h/nHaRcrmhMxfrsTQQMe/QD9FAr8WVzS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rmCwtlM67H383ue/d1A7wHWuRCZDakd/TZzSnpJeA4VFGc32hDbeOS8FTOWo5sRb0
	 ViqeWCYjWICvSaWY72rsoZUG4M6YX+PGvWQMmy3jIv7c7QCQS60yusdDIeSZK812FQ
	 WLRmX14gVqvnz4Cdklb3OlLQTXo9nCCtLvzPXK8uSEjWqTwzP+fhJ4ututCYbSksjy
	 f7Osa+8CG1OpTfqZwFyicoXReh1YIGFAQgIjmm0MeiZif5Ahk46Xc59XHm09Urv5Zk
	 lBJVGSAjYGJy3i6OlV8Yy5/NI7Ll8uGLNkXK40cfZieLx7/rjrLINdxsuvXMIZaOKL
	 uY/1WpeDffh0Q==
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
Subject: [PATCH v7 19/21] mm/zsmalloc: introduce __zpdesc_clear/set_zsmalloc()
Date: Mon,  2 Sep 2024 15:21:30 +0800
Message-ID: <20240902072136.578720-20-alexs@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902072136.578720-1-alexs@kernel.org>
References: <20240902072136.578720-1-alexs@kernel.org>
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
index 107973a2a36e..411621f00a02 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -838,7 +838,7 @@ static void reset_zpdesc(struct zpdesc *zpdesc)
 	ClearPagePrivate(page);
 	zpdesc->zspage = NULL;
 	zpdesc->next = NULL;
-	__ClearPageZsmalloc(page);
+	__zpdesc_clear_zsmalloc(zpdesc);
 }
 
 static int trylock_zspage(struct zspage *zspage)
@@ -1011,13 +1011,13 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
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
@@ -1807,7 +1807,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	VM_BUG_ON_PAGE(!zpdesc_is_isolated(zpdesc), zpdesc_page(zpdesc));
 
 	/* We're committed, tell the world that this is a Zsmalloc page. */
-	__SetPageZsmalloc(zpdesc_page(newzpdesc));
+	__zpdesc_set_zsmalloc(newzpdesc);
 
 	/* The page is locked, so this pointer must remain valid */
 	zspage = get_zspage(zpdesc);
-- 
2.46.0


