Return-Path: <linux-kernel+bounces-284353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0867E950025
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B630028740B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872F516EBE8;
	Tue, 13 Aug 2024 08:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ng8rlXIL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCEC16E89B
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723538513; cv=none; b=qaXoaHD3pLo5KcdY6KbiRrA7L7q3JqQpIrFmD2JHncFZAyMR867qEhWwGiUbMVgjRFqwfC/FxzL9ljdGYYv4ekNrXJHToilWnpQxAiOATffgb0GDjLm/FpVZM48HlSYc/qDC+HDHClV0u3vLvKnEhG41v42gkwFBnhvlHXlgsIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723538513; c=relaxed/simple;
	bh=Zf9TjxFFbO1e13JTKQj4PfBu8BRbAcD0oZRJJHyNdF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQktexD/7dEouMTJTCofdVn/ZeMQpnwsrzkKqFoCkKemNVnQszQX5CjC6x3BW/yhgNxDt39IN7o47pRa10YnUqAstNL0e3jlESah/+0bejKox59cfo7/xqQt30OVIXT/OC8yX6KdYO0caQy0gteRWD9WUZpC/BuLIHYGV0uhKZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ng8rlXIL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA27C4AF11;
	Tue, 13 Aug 2024 08:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723538513;
	bh=Zf9TjxFFbO1e13JTKQj4PfBu8BRbAcD0oZRJJHyNdF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ng8rlXILf+oInKW3qAfGb1XtZwQc0EivxacQrteO99zmio5Op2vaSm9cKsH+s1glz
	 hJ0rJrDKlc0/qijL9tJ01zDCu1RpN1zV2AEN9qj11s9Zx10q5OPDKnwo3duHiTiPNx
	 vKSDhEysjCzTbVyFhzVB73nFhg0avnJsnwNCvZDzwTxe8BfEcu0mqXawP/+s19lgK1
	 phB0C4MjtZvYdtZ79SPDYXjiQjHUc068HvT8fcgQLniUWBeoVsyl6RpGZVF6TwGvSR
	 hW3TDaMc3aKQLK+52Loibwk8NS3uYXPbVig0vN29xtUkM18bRFwOoBXm9j6PKwhxz4
	 /Hx8TbYDOrQnw==
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
Subject: [PATCH v6 12/21] mm/zsmalloc: convert __free_zspage() to use zdsesc
Date: Tue, 13 Aug 2024 16:45:58 +0800
Message-ID: <20240813084611.4122571-13-alexs@kernel.org>
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

Introduce zpdesc_is_locked() and convert __free_zspage() to use zpdesc.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zpdesc.h   |  4 ++++
 mm/zsmalloc.c | 20 ++++++++++----------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index 4b42d8517fcb..a1834d36ccfc 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -125,4 +125,8 @@ static inline struct zone *zpdesc_zone(struct zpdesc *zpdesc)
 	return page_zone(zpdesc_page(zpdesc));
 }
 
+static inline bool zpdesc_is_locked(struct zpdesc *zpdesc)
+{
+	return PageLocked(zpdesc_page(zpdesc));
+}
 #endif
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 6c5dccbc9a60..7b3344c226a0 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -895,23 +895,23 @@ static int trylock_zspage(struct zspage *zspage)
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


