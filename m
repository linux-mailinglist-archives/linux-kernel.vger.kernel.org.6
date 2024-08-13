Return-Path: <linux-kernel+bounces-284352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 054CC950024
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3804D1C22ADD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A430B19AD81;
	Tue, 13 Aug 2024 08:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xo7gB3Bq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED79619AD6C
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723538510; cv=none; b=YFQIeygdoUkXY/miKIBOg1ygo366SdVaynTj8FxIb3kil0w0kISc+w4cHu5sDRH9peY+lug7StIu9BNwMDufmkDbQE0gDmaB7qwebilmf0AiRF0/aBiARL9AENnuox+JTBTILXLeme/4gjDSRQ2ZLut+9WAohv4m76YoYXxYqcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723538510; c=relaxed/simple;
	bh=43XgPIuMdTYjompc4vGGiVQL8qZrEOEuMCnAM7TFR7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ctTJLJewnhjo8g3jcjvwzCqbrY67N/e+IifyC+aFOzRJ0+4Lwf7fa2CQizEadlAErxZM/r2gX2rWA9K81lmmFpvM+Ht8B/epsWNKMUolcTyJciSqcN29mQGg8L2wfrn5QgKf5AOLFlU8tIsQ05eT4uFVj7Xvkz++T7PqhuBoPtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xo7gB3Bq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8E3C4AF12;
	Tue, 13 Aug 2024 08:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723538509;
	bh=43XgPIuMdTYjompc4vGGiVQL8qZrEOEuMCnAM7TFR7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xo7gB3BqFWVM4It6qj2lRPdZgFjGIcIeJ/86oumVRtJApctRnsQGjwaEQPKdxMvdd
	 MIjd+B5OVxXlzcGCXoZEk19wwJ3ilpyb4FBBmyoWbikJ/vlYyjgxOR2qyRs2xsJ9jh
	 iXar1Zrpgk0vDVxw1cUMmGUgHjZbTZk5J+utPy+6t3/0MCdFiLgdWnUEKw2G4UJRry
	 IN2pWUO+/6I0YChVjnKMQJyZTj3WiSG9RlNiPrlV7UFTJG92WEm4irz8zk14pmPVYS
	 vkJQj3Rarc8ig0DecFxTs6bgMD/6IU+9OxCfzbfLdQztTGMrRIddglPt1yIUMHeNsk
	 5GoTdMIMtC6/A==
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
Subject: [PATCH v6 11/21] mm/zsmalloc: rename reset_page to reset_zpdesc and use zpdesc in it
Date: Tue, 13 Aug 2024 16:45:57 +0800
Message-ID: <20240813084611.4122571-12-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240813084611.4122571-1-alexs@kernel.org>
References: <20240813084611.4122571-1-alexs@kernel.org>
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
index 65c4252412b3..6c5dccbc9a60 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -859,12 +859,14 @@ static inline bool obj_allocated(struct zpdesc *zpdesc, void *obj,
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
@@ -904,7 +906,7 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 	do {
 		VM_BUG_ON_PAGE(!PageLocked(page), page);
 		next = get_next_page(page);
-		reset_page(page);
+		reset_zpdesc(page_zpdesc(page));
 		unlock_page(page);
 		dec_zone_page_state(page, NR_ZSPAGES);
 		put_page(page);
@@ -1893,7 +1895,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 		zpdesc_inc_zone_page_state(newzpdesc);
 	}
 
-	reset_page(page);
+	reset_zpdesc(zpdesc);
 	zpdesc_put(zpdesc);
 
 	return MIGRATEPAGE_SUCCESS;
-- 
2.43.0


