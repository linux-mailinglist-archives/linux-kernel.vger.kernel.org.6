Return-Path: <linux-kernel+bounces-265631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9297493F3E5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A9C2B20DF0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F335149E1B;
	Mon, 29 Jul 2024 11:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6Z5z02c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5770C149DFA
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 11:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722252057; cv=none; b=r/Fvjp1dUlXeGtMCMf6kUhsQKxSa2RY7BgWyxlZwofFMUDP51NXqic3h4E58bm8yLH4wInc3bqpM+COALftWJ/1RwkTcXaY9JPdrFmtZhM7xFUY5k2HZ65ODEnHFfq9hllz0+cy2UQsX51/3cDBvlY9Ap+DGzKS/NrQWdubHlDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722252057; c=relaxed/simple;
	bh=/reSYv2I3LBpywbB8eW2CIXO42cQ1NynjFn2dBL53LI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DvbTDP7Tkk+DZfVxHmgFgILIGTG3mMfd6izbF2eDJqY7JGIL8Pl51AHI0zE+I1hwC2mZhIh641mCsaKoPl0M2YOxYkMk3k7kuE7801vznoQsGEluYtuAL04TSBuyKKtExnKKVb5EySCFY6eqbNUmTJdCHl1W90ahZ7ABtqMorpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6Z5z02c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278FFC32786;
	Mon, 29 Jul 2024 11:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722252056;
	bh=/reSYv2I3LBpywbB8eW2CIXO42cQ1NynjFn2dBL53LI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q6Z5z02cPsiz04Im8TmiPZ0LRtDPvb7j/Z7gsVKUC+vY0bQTeAukeCpSUVaodx8qH
	 7CIS0LLlHtEwTCDlK7Odzu8VbidIbZIBvA+q3YjUryx+a4UHVnii/qXAjvSBqdjqvR
	 4tD5ERJ0Pywjn30AShewyQPZTcxGolFIewnVmUTha0nTO+e+wgxNPbfao/L22WkvZ1
	 QIRFfedl+/ckWEC0oJ4OGBcsN0u7rvH6OsXtffWwPRJe4Y1RQMf034J5/jRZhT06aC
	 Q6nd6bZ+aSHBwOqbIJ778lEu/5fNxKYZs9Xzu4YeC2QTW6M27X8mr9eUEenpkCqCLq
	 YG69szOAWaPKw==
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
Subject: [PATCH v4 12/22] mm/zsmalloc: convert __free_zspage() to use zdsesc
Date: Mon, 29 Jul 2024 19:25:24 +0800
Message-ID: <20240729112534.3416707-13-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729112534.3416707-1-alexs@kernel.org>
References: <20240729112534.3416707-1-alexs@kernel.org>
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
index ad04c8337cae..72c8c072b4c8 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -119,4 +119,8 @@ static inline struct zone *zpdesc_zone(struct zpdesc *zpdesc)
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


