Return-Path: <linux-kernel+bounces-243899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 540E2929C38
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E30F0B21128
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F184AEF7;
	Mon,  8 Jul 2024 06:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HA0Ua3KN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0433482D7
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 06:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720420162; cv=none; b=tIAdZuQQrGRgJVuFHotIM75PlHn8+UPhnq2ijve4xTU4XqL+tm6XAsgxgJwPn030f2ymv88QRNFiyb+qUHHqGN7evdJ2g1c0Z0qtLJ9dZAr3WGNoGjWhTV+WkUlJykOIXoK73UG039TZhXXLlOV1DLvase6vlF6j0AIaj2isnaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720420162; c=relaxed/simple;
	bh=78ef+c2vUld0iffCBKj3cSVjaJfSet6R8UzdeRHd7pU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gRjR9vnjGeLxs1Qo+Gv3n/v9pPucAyujIy1Ct0mpZZcWC2SpEMG664cApRylkzX5iisyLSqaflZlYsPkFW9KpKHpZ4QhfTsTx/mn+H8zgvVp+BRU2bWs05SFRYNfZYt7O1UIKcW454/K29XU1RKR5XHhn0mU/UiyaCJvnQlLeAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HA0Ua3KN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70850C116B1;
	Mon,  8 Jul 2024 06:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720420162;
	bh=78ef+c2vUld0iffCBKj3cSVjaJfSet6R8UzdeRHd7pU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HA0Ua3KNiyLRSlvuk8iE+wvrkOCsWZzp0NhLUjf5s2/M8n++cHNi8RMTSGlC5wHEi
	 ga/OjuScMR/XI5u8/qk7ckMACpo/8r2jtib0KRymUrBa73A5JOs5PbPHtMiENWQkNy
	 QOu4Lx0gn6RJy2fFwwquEray1BrfIRfvhthbzt8ZR6j20/xDY9vX2VTSKs0+G2bfTX
	 7nl5N/ADiWZtJ0N82eBiTBBzWhTrr+C3DTl+vxqFhB5GqjpdZXcYkXFZ4x+4kdLCiZ
	 8YaAWhVw7ch+c7m+UhwS5zWToaQnWLCaCPvCPKJtR6CF5CUyoNhQpwoJbIQfLstmLI
	 /YL5eKNTw0BKQ==
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
Subject: [PATCH v3 11/20] mm/zsmalloc: rename reset_page to reset_zpdesc and use zpdesc in it
Date: Mon,  8 Jul 2024 14:33:32 +0800
Message-ID: <20240708063344.1096626-12-alexs@kernel.org>
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

From: Alex Shi (Tencent) <alexs@kernel.org>

zpdesc.zspage matches with page.private, zpdesc.next matches with
page.index. They will be reset in reset_page() wich is called prior to
free base pages of a zspage.
Use zpdesc to replace page struct and rename it to reset_zpdesc(), few
page helper still left since they are used too widely.

Signed-off-by: Alex Shi (Tencent) <alexs@kernel.org>
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


