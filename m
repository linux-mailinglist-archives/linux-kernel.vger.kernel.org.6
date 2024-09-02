Return-Path: <linux-kernel+bounces-310712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD27968059
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A6231C21EC3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B797F18733E;
	Mon,  2 Sep 2024 07:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QibvnDvI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2730117D378
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 07:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725261435; cv=none; b=R03vlyWXqI2GLaEDz7higFlfVbcP6fQMlhdNMQGWKPPUQVvysgYFs94sS3SBs+a9ikjlmXAQxMJueHFEkRmxN1Y0cnGoaKa4IDX0msuT3xm/4xldalRzVapNB4LYo+rTyHHfBpaQcJ/s0/T3wyfmR6T511mSfTgzYiNeaP0CrvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725261435; c=relaxed/simple;
	bh=V2EFOKt+6az/uMmwc5vttTlHqgkkiN0OISIMWGbt/wQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TXsQesSMWxJ6vtU6JsqrcMDIqHISG4IzDM0b0Pzds30b2AubV3lDBMhVvE1WJnbdyZJKjBNAI2mGkNhywwFetHvtf/86Q7VxciSUXAnS+ushiqH1DIIaAPSeQYZsl/xgWVLELPlotX3J1dg5voq4mq9XEO/bhpA1+aA6/vUGnqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QibvnDvI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1A4C4CEC4;
	Mon,  2 Sep 2024 07:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725261434;
	bh=V2EFOKt+6az/uMmwc5vttTlHqgkkiN0OISIMWGbt/wQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QibvnDvIwyvgilFEHEmKNY6ncRz9JForNYuHKUV/SasiGH8CLsNIj6aePH+ZrSs3z
	 hUios/48n2louj3GjCRjC0Oawhx0jRpwnhG35lr8yyZApFk47hBbbHO6FkP2hMeGcl
	 VnE8LOmNM1GyTTtZngN4I4ZEWpAG4b0JKq1MykngZEfVoGoJ8ucTz62ynqEVofLygl
	 vd4Y/uW/yblxNd5EQIvkSlGfKW6yOalNJd/t4sSqw34G5Hamy4yimVdGIf54eP5o2e
	 4jkfeedFF91ZcBTI1Fn/R6LQhRNayDr4GqPp11hZJBPM/uFsHukJ3ZsF1e9RxkbWv3
	 vmzcC3wTHfggg==
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
Subject: [PATCH v7 12/21] mm/zsmalloc: convert __free_zspage() to use zdsesc
Date: Mon,  2 Sep 2024 15:21:23 +0800
Message-ID: <20240902072136.578720-13-alexs@kernel.org>
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
index b03bd7e07e98..5a8fd5fbc962 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -888,23 +888,23 @@ static int trylock_zspage(struct zspage *zspage)
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
2.46.0


