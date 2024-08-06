Return-Path: <linux-kernel+bounces-275588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400BA948771
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3896B247D4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD881EB2A;
	Tue,  6 Aug 2024 02:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eumQagZu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BED21BF37
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 02:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722910716; cv=none; b=HLqB3enHILyAs1m9Sbpo1QmujMFAnBc0zPKMc5UGIRcwzBnKm85MeWJrnaIubsG8pacE4Kngpuq6gj6/zsqPCzWmDrre3978rPfT1QGlDkdkAf+Bh/dxFUIGE10JzTVWwdhKWhJveAxerFsnh24qkb9+pjWHoDFb0aHKPvamMaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722910716; c=relaxed/simple;
	bh=lIAmwXpKjxS2Hsoj/dTwcnmyf7UY5ner31n75hmLtY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jz+Se64/hhU2k/WsPVRkp5Xbv1l9F90iscCE73dPBvlKrH+DlklS/PrG5PyfOmB+kv884Bkhm83mq2OqZLt0j1BJ7Bt4zKlBJuYw4pNCHNADW7sOaJTVuHPBo1RGhUzKCzy54TilsTFaW4E/gHOjD20jJhA+qzppG0OfTaskW8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eumQagZu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7A6C4AF15;
	Tue,  6 Aug 2024 02:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722910715;
	bh=lIAmwXpKjxS2Hsoj/dTwcnmyf7UY5ner31n75hmLtY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eumQagZuRPiE1JGpb1pdxG+/99Ht5pD7RRzlqeURY/va7iPdIX7vB4gKhr06VJQ3r
	 UWoA8msGRp4eA8sccL2/GzO5mQxkVqzheMiDuAC3F5rJW5N+SCFZtKyAtFO+Lf67rc
	 KTHxlNvMvXZB/J55XLBEOsY745Nro5/dQ9+M95DGwMx671Ot4J8rtSAseOVLtktMQF
	 oFfqu8itoW6TWi2Fvx8KvB0l7TgUW74oWiWh598DDOWMLJ7jNCPpg2iwUlurfumYlt
	 StcwxXKGxg+yrDJ9bj0qQnx/7/ncGtbXfNpvFRVea1X2Pg4QthRUrw4kec6lJhMnIZ
	 D6Wh2QaMAul8g==
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
Subject: [PATCH v5 11/21] mm/zsmalloc: rename reset_page to reset_zpdesc and use zpdesc in it
Date: Tue,  6 Aug 2024 10:22:58 +0800
Message-ID: <20240806022311.3924442-12-alexs@kernel.org>
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

zpdesc.zspage matches with page.private, zpdesc.next matches with
page.index. They will be reset in reset_page() wich is called prior to
free base pages of a zspage.
Use zpdesc to replace page struct and rename it to reset_zpdesc(), few
page helper still left since they are used too widely.

Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zsmalloc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 398b602a3b4d..f4fc79c0bef5 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -845,12 +845,14 @@ static inline bool obj_allocated(struct zpdesc *zpdesc, void *obj,
 	return true;
 }
 
-static void reset_page(struct page *page)
+static void reset_zpdesc(struct zpdesc *zpdesc)
 {
+	struct page *page = zpdesc_page(zpdesc);
+
 	__ClearPageMovable(page);
 	ClearPagePrivate(page);
-	set_page_private(page, 0);
-	page->index = 0;
+	zpdesc->zspage = NULL;
+	zpdesc->next = NULL;
 	reset_first_obj_offset(page);
 	__ClearPageZsmalloc(page);
 }
@@ -890,7 +892,7 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 	do {
 		VM_BUG_ON_PAGE(!PageLocked(page), page);
 		next = get_next_page(page);
-		reset_page(page);
+		reset_zpdesc(page_zpdesc(page));
 		unlock_page(page);
 		dec_zone_page_state(page, NR_ZSPAGES);
 		put_page(page);
@@ -1879,7 +1881,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 		zpdesc_inc_zone_page_state(newzpdesc);
 	}
 
-	reset_page(page);
+	reset_zpdesc(zpdesc);
 	zpdesc_put(zpdesc);
 
 	return MIGRATEPAGE_SUCCESS;
-- 
2.43.0


