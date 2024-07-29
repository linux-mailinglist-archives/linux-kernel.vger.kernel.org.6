Return-Path: <linux-kernel+bounces-265630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B8893F3E4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CDC81C2141D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1191494A9;
	Mon, 29 Jul 2024 11:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1xfuqoT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29E5148FF5
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 11:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722252053; cv=none; b=Aj2fZlYfWrsPECqHwxcsuMu9MoK35fUGFfM8VVFwbMCeqtG0u76LfbNPYU2i3QkiYfo/ETGau0vcAR5K4ruiwA7/s3tFzhEr9hlnTDVLUMOf24tCE7vHPtk78O7LK8BY/wwci7bODjZYY2vj6G2JtvQrzcwmzSEP+SoOhV/rvmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722252053; c=relaxed/simple;
	bh=d7GxkLwHXdQyb6XsJEXUauGOBeH6/SyL3Iuz9vNzPwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kMfKC4clz1olYaEowG1UMDnw7sjuXE7BJcwLSPIVQI6czB6gOZnUVtus6Y5W8rBNfaBX8gqaiKoV2BdsVB4uLWSPyxrC8vJ0tJH7rOonkYmqGNxWGJyDjOq+7R4l0+Fb4O9akNpfh9EzVcCHD1d5zV0pwAPboDsKoSdNFNvVS4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1xfuqoT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9A5C4AF0A;
	Mon, 29 Jul 2024 11:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722252053;
	bh=d7GxkLwHXdQyb6XsJEXUauGOBeH6/SyL3Iuz9vNzPwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y1xfuqoTF8RBa6k5ApOc1e9IzEm4y5wIehqq1Lak4a/tussklfMkbwl3E865wK7Sg
	 NAqDweP7jioqqU8PNGlclmJy+bVTfwgSxrpH6Bn7Cs8W3/dLWLQpvp+BcZMpqoO2qN
	 9d8znmyUTNzACuqjIZz0RwW+widCJiDk03ZWFhnpT0Q3dPKfYpQAwwAS3wU3LIj0Yw
	 7YVZuuB/lWRsQeG2lg59DOcbTCrKpJI5IUFSFF4RsrlXmif7ZmLyWSf4nerSPMXzZm
	 o594WC/rvrMnYCSgW/pSL0QNyaXpuXUSFzjnSM+XwWbty1FHL/hvjGQSyRY2kdY73J
	 IySG9ESyAF6tg==
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
Subject: [PATCH v4 11/22] mm/zsmalloc: rename reset_page to reset_zpdesc and use zpdesc in it
Date: Mon, 29 Jul 2024 19:25:23 +0800
Message-ID: <20240729112534.3416707-12-alexs@kernel.org>
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


