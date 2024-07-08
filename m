Return-Path: <linux-kernel+bounces-243900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BFB929C39
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 677EA1F21B0B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28224558B7;
	Mon,  8 Jul 2024 06:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiUIttnE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAE254720
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 06:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720420166; cv=none; b=ft+cFirOf6LU6bNBxdjSqWjbcq109+AeqMeL1can+D/G+7R/DIiZfXB3qXS1te48AIvirknGRSsHg5Fx3+6SKgJ31r5z3DNQv4XGPVrvVEErCis0O5FGG/gkS24Mh5kLoL1JUrhLE28oICyADNNSUoez16fuC/JC57mQS/ThfKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720420166; c=relaxed/simple;
	bh=F6gyGa/Nhcaa49tqL1AcCvvFaZR6EdIliZgtM0OjhK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cD6e8OoD0wb/4FvQUXUFSSzfYxwMJYRh0o+lUpDzp8YSbgbgrRUXK9KIPPSfWFfn7mD6SD9L/pEuJdArSjSpx4BLG3lJI6BZmcbyKayomboeNIKHjngSwkgn0UGCG4bzKbMcXxOY9ZG3dMAGxsCZ1OtULVtVNneS7mn0gNbOgiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RiUIttnE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D450C4AF0B;
	Mon,  8 Jul 2024 06:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720420166;
	bh=F6gyGa/Nhcaa49tqL1AcCvvFaZR6EdIliZgtM0OjhK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RiUIttnE915B5POlt/rGkjRDxwMkMUiIsyhchqZid2hdw6qQfozwkJ9cRUtOfaZWY
	 ecSVJ4QQb/fdFBE9zfzyTA2BZQ/RZsYI6z/9adNmf/+XhmJydHF+/B49U4BOPli6FZ
	 i+H2xFep0Wh7TcTsawSQ0/5F+Km/FzU4iOKH5y+BJhwbFrL+YhRlq7VBl8TY9/DR6+
	 9B9+DFLrjkjS9AcDH5+JUEVesyTatZ396Mq4zYeXPyscrToCEr2YgnPtcKHsDEslgD
	 MVG6bEWLnGK/BxKoGIZwYSo/4qLqon08Zeykg32nXyrja7dsffK90F6QWlZSv8eCUu
	 qhdiNIl+Xz0Ug==
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
Subject: [PATCH v3 12/20] mm/zsmalloc: convert __free_zspage() to use zdsesc
Date: Mon,  8 Jul 2024 14:33:33 +0800
Message-ID: <20240708063344.1096626-13-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240708063344.1096626-1-alexs@kernel.org>
References: <20240708063344.1096626-1-alexs@kernel.org>
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
Signed-off-by: Alex Shi (Tencent) <alexs@kernel.org>
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


