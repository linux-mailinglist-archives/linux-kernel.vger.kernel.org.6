Return-Path: <linux-kernel+bounces-275596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70906948779
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 130451F2625A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2E86F2E6;
	Tue,  6 Aug 2024 02:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HznYQbSG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1646F076
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 02:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722910746; cv=none; b=W0iuWJfjpt+elQX9CYP+eQkCFDJm1u77WgHvmL7rmTadHhlQvmgJWWq1jC+XkHaj6onFUBqOtwXYZD4BxOxscZ9BCG8Ig9xCdmv0U6GaPIwEm+T/hBOgtDJZRuzCZPo7uRm0ES+6d5OB5MuP+hDd2Kzb2jWVG4thH8+3A8Grx/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722910746; c=relaxed/simple;
	bh=oL5cTZYBz5hcMd4ibMjrzRAOxUIAWeTC3GGP5qzznjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KYjvVZxGB0MNS/L0bZCAG/i3uCPhk99ClwXWOb9bVhFW3+EbKOcpwd2tgbW3Nna5haPAm0IbsahJ6MXDb5OkqjUFrheN2JaMh9rteyC91jyQox8dWTDQXES1EkMX4FQKcoGXbJVJqO5tM5//azmFgSawv/YW2mNcIe3vOg4hfHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HznYQbSG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC641C4AF11;
	Tue,  6 Aug 2024 02:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722910745;
	bh=oL5cTZYBz5hcMd4ibMjrzRAOxUIAWeTC3GGP5qzznjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HznYQbSGB5gQ2kI4wcaUCOnPgGomh9VJ4uFtU8YG1LSpwabhCQ5mxFNi8WpsZ6exU
	 K2rMxdEaj7xFao9BCCnDrHgaXr9hQ4jYCcgFfLBKdAml2YEKJ69MLvRMrXZQgAQxqX
	 RONxiHPQHIUEX/m1A/ofr7XuFO/YWOznmfR9zypSe7GLU6pMZS8Xx3aN/pypoyEzh6
	 kLyjt2xVtNmiSUqQtoB2AjBnSdr4Dcc/epjg/GoMU4SEg/Xv2KyIEHTI6BaDEVxS8k
	 gT+v+/dqRQT+ymOFOQz2ckMqoZBnAoBylS3mn63NoXSeKUbYwjnzgDGBG/r5ZOElwK
	 iG0VmI/vVGPxQ==
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
Subject: [PATCH v5 19/21] mm/zsmalloc: introduce __zpdesc_clear/set_zsmalloc()
Date: Tue,  6 Aug 2024 10:23:06 +0800
Message-ID: <20240806022311.3924442-20-alexs@kernel.org>
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
index 1ab47faed49b..d0a1af0ee424 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -119,6 +119,16 @@ static inline void __zpdesc_clear_movable(struct zpdesc *zpdesc)
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
index 7c7432a00a07..0b318db894a8 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -831,7 +831,7 @@ static void reset_zpdesc(struct zpdesc *zpdesc)
 	zpdesc->zspage = NULL;
 	zpdesc->next = NULL;
 	reset_first_obj_offset(zpdesc);
-	__ClearPageZsmalloc(page);
+	__zpdesc_clear_zsmalloc(zpdesc);
 }
 
 static int trylock_zspage(struct zspage *zspage)
@@ -1004,13 +1004,13 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 		if (!zpdesc) {
 			while (--i >= 0) {
 				zpdesc_dec_zone_page_state(zpdescs[i]);
-				__ClearPageZsmalloc(zpdesc_page(zpdescs[i]));
+				__zpdesc_clear_zsmalloc(zpdescs[i]);
 				__free_page(zpdesc_page(zpdescs[i]));
 			}
 			cache_free_zspage(pool, zspage);
 			return NULL;
 		}
-		__SetPageZsmalloc(zpdesc_page(zpdesc));
+		__zpdesc_set_zsmalloc(zpdesc);
 
 		zpdesc_inc_zone_page_state(zpdesc);
 		zpdescs[i] = zpdesc;
@@ -1800,7 +1800,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	VM_BUG_ON_PAGE(!zpdesc_is_isolated(zpdesc), zpdesc_page(zpdesc));
 
 	/* We're committed, tell the world that this is a Zsmalloc page. */
-	__SetPageZsmalloc(zpdesc_page(newzpdesc));
+	__zpdesc_set_zsmalloc(newzpdesc);
 
 	/* The page is locked, so this pointer must remain valid */
 	zspage = get_zspage(zpdesc);
-- 
2.43.0


