Return-Path: <linux-kernel+bounces-265639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAA693F3EE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB8741C21D55
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AFD15572A;
	Mon, 29 Jul 2024 11:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUHlbM/T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E1F1553BB
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 11:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722252083; cv=none; b=GUUXC6Ho+pLZj7Jr8pTL5gi3Tv4rkP1MMR/XeDvl/TvYEjVYVFSssfq/QbI7tThL0TsDslWT3wM7rVU3sjS26IMs4SJQZAvQ+jBJishifnQhYULv3ABP2NPbuZxJcG/gkA/mZ8+U0r/8dKYPCt2F8A3x1OShRuQKI60+oJbKiFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722252083; c=relaxed/simple;
	bh=U4TlC31Eh5dq6Szo/Iu40dA9+YSQztS7ohMuHhtrtaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h4l5nLcIkXNjYhThn4TN3GQUmZMpl4Sgy1kw8jl+PwQbrk+WhmzP65asYtq1gN5KqVNFeJmE9t2/wHuo6L7f1gsJm6Hzq5Ah+2yEwxiRaAjU/75J14Pw0gE8pkFuHcEwdSOrHOajs5VoNrE1o15WArS5RD9VtWa3IMSAnP6mauc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUHlbM/T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33FA2C32786;
	Mon, 29 Jul 2024 11:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722252083;
	bh=U4TlC31Eh5dq6Szo/Iu40dA9+YSQztS7ohMuHhtrtaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hUHlbM/T2v2RtXsHmp6QIE6F/mi7q6Je8OLzlD/lexCb2P1pX21JgHzDv/TbkSYP7
	 j/i58sijth6hxlaay3bpDMXYY1XTUB32nZXeDQI4c0iNeq3R8hqJif09oqqGFIHW03
	 ycgzafFlbbUM7z1E/+is1BED+Izlg3fW34+e+sdv7n+eawGF0JgSqqNp/X6hI06t5h
	 5wOzG3uFnpYyb7tHw6LyNAC3dMteobqFfLN1K5RoZB9LszFDuRCtlc7BElwgP1BgeK
	 EliDMwNkMg93GXpaKvhxPKwZSgj8Go4CcBcdrVaY57+nI4Kzh5Ueooo/GqGxUhgsZ9
	 XljEaxsXtUaRA==
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
Subject: [PATCH v4 20/22] mm/zsmalloc: introduce __zpdesc_set_zsmalloc()
Date: Mon, 29 Jul 2024 19:25:32 +0800
Message-ID: <20240729112534.3416707-21-alexs@kernel.org>
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

Add a helper __zpdesc_set_zsmalloc() for __SetPageZsmalloc(), and use
it in callers to make code clear.

Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zpdesc.h   | 5 +++++
 mm/zsmalloc.c | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index 05def4d45265..06371ce60cd1 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -119,6 +119,11 @@ static inline void __zpdesc_clear_movable(struct zpdesc *zpdesc)
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
index d88602fb0233..7f8e02df4e3e 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1030,7 +1030,7 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 			cache_free_zspage(pool, zspage);
 			return NULL;
 		}
-		__SetPageZsmalloc(zpdesc_page(zpdesc));
+		__zpdesc_set_zsmalloc(zpdesc);
 
 		zpdesc_inc_zone_page_state(zpdesc);
 		zpdescs[i] = zpdesc;
@@ -1820,7 +1820,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	VM_BUG_ON_PAGE(!zpdesc_is_isolated(zpdesc), zpdesc_page(zpdesc));
 
 	/* We're committed, tell the world that this is a Zsmalloc page. */
-	__SetPageZsmalloc(zpdesc_page(newzpdesc));
+	__zpdesc_set_zsmalloc(newzpdesc);
 
 	/* The page is locked, so this pointer must remain valid */
 	zspage = get_zspage(zpdesc);
-- 
2.43.0


