Return-Path: <linux-kernel+bounces-238817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2AE9250EB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 06:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73ADA1C23373
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 04:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051B0155C81;
	Wed,  3 Jul 2024 04:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpDb5OJz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4585022EE8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 04:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719979311; cv=none; b=X+xltNvvDQ8G9GRAjHGxjpqiykt1V7/FR6XJhFAOEcUKcbwNZkTKFuv9BjSqC5MLX9Y7A+hgLWlzbR+QBNx+W9+vwwpTxyPRk2pMzhOt3ynx3voEsgJrGvPxQH1iHqWsZZ61/Ua/6QGhtO91I3nbmnUi4d9/C+k17uGsMU18nV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719979311; c=relaxed/simple;
	bh=d7GxkLwHXdQyb6XsJEXUauGOBeH6/SyL3Iuz9vNzPwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqom+MaH3znl6yIx2LsMYxE4Qj6jgsdBnP7wHbQ8Z8GERQ48vNZLu4U83NFqAE7ChovsfaOmwdXF8mzaawsaNZTX3bKDkERPzlXu2vqqcpXE/NmemaGltUTzJ+RDRls1e800Kojt2yEegMtws3be9gTRu/wU7hgUZWjXS4RYde8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpDb5OJz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF31EC4AF0B;
	Wed,  3 Jul 2024 04:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719979310;
	bh=d7GxkLwHXdQyb6XsJEXUauGOBeH6/SyL3Iuz9vNzPwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NpDb5OJzKlBHlmXy9eSfpYJA66+cDPSqPT/zmcenz11JqH6X7j4xggFBVksX4hHDr
	 hrjebT56ic9Us0wcGrhTL9GrCCBcw2YKhHWj5Y/X7PXOoNg8AJDlaRCV1/bY5oVTjW
	 7reZHFTfGlB5U+5CYeaRbolfCWAWin7oIgpneC1lVlHKzPLBeY8NnMzeV6hQm2+Uq+
	 dyrqduH1axDvKQqlOLJqHrP2wLCJgyLxxzsoUfUu5MC/7ZxEDhAjZdajB8AmIPr8yV
	 YuDrR4c//Kevf275D86Y0FW1sKewkadQl9n708d6mCQmWAu/FzFHMBk7NsFvLKFIyz
	 O1sJ+oFdqQ6xA==
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
Subject: [PATCH v2 11/20] mm/zsmalloc: rename reset_page to reset_zpdesc and use zpdesc in it
Date: Wed,  3 Jul 2024 12:06:01 +0800
Message-ID: <20240703040613.681396-12-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240703040613.681396-1-alexs@kernel.org>
References: <20240703040613.681396-1-alexs@kernel.org>
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
index 9bc9b14187ed..6d1971836391 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -865,12 +865,14 @@ static inline bool obj_allocated(struct zpdesc *zpdesc, void *obj,
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
@@ -910,7 +912,7 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 	do {
 		VM_BUG_ON_PAGE(!PageLocked(page), page);
 		next = get_next_page(page);
-		reset_page(page);
+		reset_zpdesc(page_zpdesc(page));
 		unlock_page(page);
 		dec_zone_page_state(page, NR_ZSPAGES);
 		put_page(page);
@@ -1899,7 +1901,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 		zpdesc_inc_zone_page_state(newzpdesc);
 	}
 
-	reset_page(page);
+	reset_zpdesc(zpdesc);
 	zpdesc_put(zpdesc);
 
 	return MIGRATEPAGE_SUCCESS;
-- 
2.43.0


