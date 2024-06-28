Return-Path: <linux-kernel+bounces-233299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CA991B546
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 05:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C82231C20840
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392711CF8D;
	Fri, 28 Jun 2024 03:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLYMc/7u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0E421342
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 03:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719544053; cv=none; b=A82lG483coMeXPjjYAEX0Kx76tUe00DpqwP9U2YA6YJA3i1SucIQr2kCowpKtHw6w8IzPXPyJErqg3CNqfZxAAe8zcKNApMplP2n2iEXE2wMraeWDxbLvxETLodEkrXvcd/71IyNnxTKi2oY4Pxo6n4PdyTrmH3mXkbh8o+0gSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719544053; c=relaxed/simple;
	bh=rDBA9PQhfrX2sld8/x0O9UG/mVNkTt8p9w0g00Zl/Is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pqiL6F2cG+4gza4y28kg7/8sOAsJiiocKLMv8lH46b1yWaV9xNrANIK0XpPz4azzD3Nf3HYCE4rS9s/yAiD6nnMwoSmXZYVhOLp3mdqqBO7oK619k/Zznu0GPfVsgGq9F/8zPuCEgotRxNYwXyBkerf2cqK8zEPjS5PtdDQpVg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLYMc/7u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812C8C32789;
	Fri, 28 Jun 2024 03:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719544053;
	bh=rDBA9PQhfrX2sld8/x0O9UG/mVNkTt8p9w0g00Zl/Is=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mLYMc/7u901OlvwzejVebGRJEyPAEygoLhV89brKlhhYjxZ0icIH+7gy5VLMEhstY
	 nC7sgqj0XdoqBL5QlBfnBN+qP+BIpEJN0PjpCOSOS2WuR74IrOaEn/iLirkfQxTzS+
	 UkAx8p2uK7Z8em0W7vDigSNNjGWkjfZxdeqM90qox2/0MhzJ8EBVvPhWtBO936eT5i
	 AnutNkwsiJvqnDczkg2qwn5VxLl1uIwZDool0UvbpMRsJO7a5R6tn9KT0sHs1oQWWC
	 7L62XReP/pejWZpdCCQx8KXAehDgaiohDLewX5nNd2thVBKgKwWv6LbGWHl/ZVXaNP
	 WDThjKrP9FPBg==
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
Subject: [PATCH 12/20] mm/zsmalloc: convert __free_zspage() to use zdsesc
Date: Fri, 28 Jun 2024 11:11:27 +0800
Message-ID: <20240628031138.429622-13-alexs@kernel.org>
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

Introduce zpdesc_is_locked() and convert __free_zspage() to use zpdesc.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zpdesc.h   |  4 ++++
 mm/zsmalloc.c | 20 ++++++++++----------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index 2e35b8220e05..186ff9711ffb 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -109,4 +109,8 @@ static inline struct zone *zpdesc_zone(struct zpdesc *zpdesc)
 	return page_zone(zpdesc_page(zpdesc));
 }
 
+static inline bool zpdesc_is_locked(struct zpdesc *zpdesc)
+{
+	return PageLocked(zpdesc_page(zpdesc));
+}
 #endif
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 216f8e6950ef..bf5a1b63bb17 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -903,23 +903,23 @@ static int trylock_zspage(struct zspage *zspage)
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


