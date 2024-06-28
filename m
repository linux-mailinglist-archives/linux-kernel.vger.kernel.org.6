Return-Path: <linux-kernel+bounces-233307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B46A91B54E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 05:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B20301C21C0D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D116846433;
	Fri, 28 Jun 2024 03:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbU3x2Dd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23790446BF
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 03:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719544083; cv=none; b=WDqPJMxWLFnUb9yleIDjPS2pekpeJ9EDgh0oV94tn8vogtKOUN44T5eh0WH5JzXqQfovVaQuCZzXwZLfgkSiUVoARGlT96q7i5kXuF/1jUinG31WZybvYQdZHvAFBC0pzvcWq6kB4sIckUAgAk8tA2X3Sl4EjEGUMIuwY6fRqCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719544083; c=relaxed/simple;
	bh=4MKTXWqqoUrRELMNSTMj+qMl+m60BitHu1nDeXKuUgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jH7sloLmkN0UqAgPU27NqZNgDa8NkkYvta5qLQKGo3STQemnUvPNp4JFTmRR9LhZe5VHSf9OyelIgZFK7gnqsZA3wPdwEwFClkD2fkgSrKIIqdPpIVcUgC7g5AYJyxjX/mIjGtFadHyDcgBJv4TjjYc9eFvoIsSQZCAp8zDE4HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbU3x2Dd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97FBBC32789;
	Fri, 28 Jun 2024 03:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719544082;
	bh=4MKTXWqqoUrRELMNSTMj+qMl+m60BitHu1nDeXKuUgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cbU3x2Ddh8UT1d2qoVfthnhMM+GJKywAez5C89nw56pBJLHMwtkvKj/JzIwEwMFRk
	 wzmpdRUrNHYRvjA6DyL9hLgF2gtdCELLqOT0Ac2uw6PTQ1z+HCS0CPop6sQ5JrxKaL
	 H6DNIP2g8MFFZxd1i8wYTSKZYOUXhQ+x0WRhjXVCeosCcHVhUCN33Xlf7v6uT8OUDw
	 i/46Pz0IAIjX67naNUMaB2vjL8T6s7Fh8s8wMLWP9XALYQ8N1EidkmLu2LRwvgLF0J
	 yE2ElJWpvcfyCD92w/NKVFID3nhC2abtUH7BW1bSfu8OtUlsZUF724zhamgTRYry3Z
	 7pie/+HAHWdWg==
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
Subject: [PATCH 20/20] mm/zsmalloc: introduce __zpdesc_set_zsmalloc()
Date: Fri, 28 Jun 2024 11:11:35 +0800
Message-ID: <20240628031138.429622-21-alexs@kernel.org>
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

Add a helper __zpdesc_set_zsmalloc() for __SetPageZsmalloc(), and use
it in callers to make code clear.

Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zpdesc.h   | 5 +++++
 mm/zsmalloc.c | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index e346b39aba59..ef36fc3de75d 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -107,6 +107,11 @@ static inline void __zpdesc_clear_movable(struct zpdesc *zpdesc)
 	__ClearPageMovable(zpdesc_page(zpdesc));
 }
 
+static inline void __zpdesc_set_zsmalloc(struct zpdesc *zpdesc)
+{
+	__SetPageZsmalloc(zpdesc_page(zpdesc));
+}
+
 static inline void __zpdesc_clear_zsmalloc(struct zpdesc *zpdesc)
 {
 	__ClearPageZsmalloc(zpdesc_page(zpdesc));
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index eaf8dad04f2c..e2a506f53957 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1032,7 +1032,7 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 			cache_free_zspage(pool, zspage);
 			return NULL;
 		}
-		__SetPageZsmalloc(zpdesc_page(zpdesc));
+		__zpdesc_set_zsmalloc(zpdesc);
 
 		zpdesc_inc_zone_page_state(zpdesc);
 		zpdescs[i] = zpdesc;
@@ -1825,7 +1825,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	VM_BUG_ON_PAGE(!zpdesc_is_isolated(zpdesc), zpdesc_page(zpdesc));
 
 	/* We're committed, tell the world that this is a Zsmalloc page. */
-	__SetPageZsmalloc(zpdesc_page(newzpdesc));
+	__zpdesc_set_zsmalloc(newzpdesc);
 
 	/* The page is locked, so this pointer must remain valid */
 	zspage = get_zspage(zpdesc);
-- 
2.43.0


