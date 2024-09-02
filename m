Return-Path: <linux-kernel+bounces-310711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2AA968058
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19784B2353C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED6C187329;
	Mon,  2 Sep 2024 07:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tINHAOSK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD04187326
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 07:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725261431; cv=none; b=k/7sKZMs2INqMbKu9r3y3+OiT9VzoDIQ1AbMPBG8VZ+eQyPDAM4a40WuuqaHYHW08dpSUNLNLasv5fHWl3MiCYwQqJRJWsLPUVcgCtOCwddgXwoHa+ZeHqKFyZsKsG+YTnrML97nDmWtFP1zeBesxhaBWj9CZ8gBc2zu/pLRFLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725261431; c=relaxed/simple;
	bh=TqaE/5WJpT1xBdjh2dqdooKapipE1l2P0P7kGVoluZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SP7UHn5iYXn9iW5ORb6jj0ljFv/2u52QqO8OrReVjInFVwTMhkendhKJPx1rrPkLPI+Dqtxq+vkMG/ojvJLrNnciYhpm3D59xDv+f9+E7DUwEpop8vt1x6D/AtdL8fH+j6SEBcOXX3tjNFY1Zse5BM1YEdx7XAIhLx5T7LEWdKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tINHAOSK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59271C4CEC2;
	Mon,  2 Sep 2024 07:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725261431;
	bh=TqaE/5WJpT1xBdjh2dqdooKapipE1l2P0P7kGVoluZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tINHAOSKO69ja64wk58zkCcRcnjShQs6ujw7E9y0QqjTQ2Y9taiVSVw1xtraDIUOF
	 NzJ4/jDvLlYoO4zZIiSJqmsszuMAbnuyMTsOCbm3B+BJIsl+16BsZ+omQXqmXSglnm
	 v0yWrwoutoQuD4ye6gqAqFgIJmwaWmBXfx+V26fOfvQcdN6QCRaB8Tubehki32vm70
	 NbcjUFnlub6UuwvekHSYnnKakVcPvNyKfOZ9EjH2oC/AFPoZAGVtaVXAdiHExx3WCi
	 rQciGFPkmq1gCe+us9jvCXv6Fm8P71mQUUJ1oqY7Z2FfKKB2hmIgeUX36hKv70OFoS
	 aL3Y2UJ4+oxiQ==
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
Subject: [PATCH v7 11/21] mm/zsmalloc: rename reset_page to reset_zpdesc and use zpdesc in it
Date: Mon,  2 Sep 2024 15:21:22 +0800
Message-ID: <20240902072136.578720-12-alexs@kernel.org>
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

zpdesc.zspage matches with page.private, zpdesc.next matches with
page.index. They will be reset in reset_page() which is called prior to
free base pages of a zspage.
Use zpdesc to replace page struct and rename it to reset_zpdesc(), few
page helper still left since they are used too widely.

Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zsmalloc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index caa4a7883ab8..b03bd7e07e98 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -853,12 +853,14 @@ static inline bool obj_allocated(struct zpdesc *zpdesc, void *obj,
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
 	__ClearPageZsmalloc(page);
 }
 
@@ -897,7 +899,7 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 	do {
 		VM_BUG_ON_PAGE(!PageLocked(page), page);
 		next = get_next_page(page);
-		reset_page(page);
+		reset_zpdesc(page_zpdesc(page));
 		unlock_page(page);
 		dec_zone_page_state(page, NR_ZSPAGES);
 		put_page(page);
@@ -1886,7 +1888,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 		zpdesc_inc_zone_page_state(newzpdesc);
 	}
 
-	reset_page(page);
+	reset_zpdesc(zpdesc);
 	zpdesc_put(zpdesc);
 
 	return MIGRATEPAGE_SUCCESS;
-- 
2.46.0


