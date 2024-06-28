Return-Path: <linux-kernel+bounces-233298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E14791B545
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 05:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04E6D1F2159F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CFE1CFBE;
	Fri, 28 Jun 2024 03:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G93JlV8Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CD01CA8A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 03:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719544050; cv=none; b=N8X/rg1rNX737cLmJhEFIpXcphiYlu1APZrGAAZ8/o3xon7Xu5rWq/T+WeX62AKIOFvJJrGl1trjdNnJWJS6jfGpqFyN57NFJhL8oh3Xk/8skIbLTDrH6UU03UNLbdHBeeOzlI9kN2BJqWiUN7BG5XAIU49WUbVOC9QGwBi/e9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719544050; c=relaxed/simple;
	bh=WVCo5FocoDi8mJGyEARAUtW59QMXLmGoSt30iD6IwAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GIqzvCJBbToR1mpOsSMhC0fPkeEZrt2t51hiIJpWMfoFLQbhSm46H2UCkxAjSMSkvaaTVrgODB5uT6aLAC5bLKa6VdGw/3FmqjrqLkpF+SzkzlXPlCMvCVnF8mYWGFZ03sLKsWTmWCXhVxYRdoBSVPwRaY9++Pg+BPy2bXBQ2tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G93JlV8Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF836C116B1;
	Fri, 28 Jun 2024 03:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719544049;
	bh=WVCo5FocoDi8mJGyEARAUtW59QMXLmGoSt30iD6IwAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G93JlV8YYzxWgG9GYE5JjU2ygzVYPZRfSW0u+Lv+XKD+uGl5mDGQzi1sW2Ses9l1a
	 jAqs4GDKakVW2T7olETXuSfQGUxe3N79I+c8/cGoDeT2dP/Qw0Y2SuS5rGQLiufXU5
	 cOLPgU28kk/KZq11ozpMKKNWpsjd4HHmGqk0MlEem4feI7RiQOLPstDBogmGArrQPa
	 LcgEy1h/AuWnFZj+aEkAbS3r6jb/tOYSB09HoP/8yXn74PQtbDa7t5ldfdFxCMsP7Q
	 a2HDHZ12nEeMpUneZSsUIak2KUFzhCLVi5SF4Or2usMTBhpCCoUqLLHZLhaZQkpljK
	 xnmC1xGKfZrYA==
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
Subject: [PATCH 11/20] mm/zsmalloc: rename reset_page to reset_zpdesc and use zpdesc in it
Date: Fri, 28 Jun 2024 11:11:26 +0800
Message-ID: <20240628031138.429622-12-alexs@kernel.org>
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
index 251a6e63e58a..216f8e6950ef 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -867,12 +867,14 @@ static inline bool obj_allocated(struct zpdesc *zpdesc, void *obj,
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
@@ -912,7 +914,7 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 	do {
 		VM_BUG_ON_PAGE(!PageLocked(page), page);
 		next = get_next_page(page);
-		reset_page(page);
+		reset_zpdesc(page_zpdesc(page));
 		unlock_page(page);
 		dec_zone_page_state(page, NR_ZSPAGES);
 		put_page(page);
@@ -1904,7 +1906,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 		zpdesc_inc_zone_page_state(newzpdesc);
 	}
 
-	reset_page(page);
+	reset_zpdesc(zpdesc);
 	zpdesc_put(zpdesc);
 
 	return MIGRATEPAGE_SUCCESS;
-- 
2.43.0


