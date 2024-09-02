Return-Path: <linux-kernel+bounces-310718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 422C796805F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1FABB23A30
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3680C1885AD;
	Mon,  2 Sep 2024 07:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXNl4KFK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E4615FA92
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 07:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725261455; cv=none; b=ApfGiCit0J/qkihxDTmDU0Hmr1VnWqb+WBu88GGGUp/84wCoOm/1I6CCdn5MNtEyJBXwqUU6qAKENOcLlXS2zYxF7lQCRF4493zgnVHnijvvaHUiAB5VT6y4/wTkMNWvhLgpusH3IffNbIhLCIfOmtpv6vYzV2udPtjd+nu44dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725261455; c=relaxed/simple;
	bh=kXYRElA12DbhEH97D9heS99VK1p14zBkU2t+ZW1MGTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dANwoH7XZD+0IkF+Id6kpStxYiIL37gnpBku0QgGd6nVDO3Q7NVSnhiNvf/R6Fuzn+Ru8RMrhr7PC7gC6PykEL+WJZnznwhayFd/gxPogybr5n1mLS67WsJ2TkKom1O92SGL3wEObuV+CqC98myDI3J63+4oUJykJpdg8ZvdHYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXNl4KFK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3294C4CEC4;
	Mon,  2 Sep 2024 07:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725261455;
	bh=kXYRElA12DbhEH97D9heS99VK1p14zBkU2t+ZW1MGTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EXNl4KFKTK0kmfyfg0PFMIaOD3FttgGZCH0MnmSSo5zAW04bquMAE2xDfbjMNNVIR
	 xyOchytZAcoeIyzGiM6gh7DHnGBRVYsm0uukeKA7UiBdDmv3Bna/wVYMnlbvQ/wF2G
	 mHIEqY6gnf8yj3FLghQIzw7pDazFPq9rtnwYI/Oxk7Lc9kLqjGKxucW3wXOgHl5Ox+
	 1Oe3QJVe/XVTHUZlHu9WVghZq/41pyRXmUhbaLI+563RJskdW+XeKdRFKxczmafI+1
	 VJ3pKjjHnlgQRmX8cbEnLMbzcoVpRjFIEki8S7ZigdUbQW9rPHfj4lPtEWfk+s2mrS
	 Zza1TaewLy57Q==
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
Subject: [PATCH v7 18/21] mm/zsmalloc: introduce __zpdesc_clear_movable
Date: Mon,  2 Sep 2024 15:21:29 +0800
Message-ID: <20240902072136.578720-19-alexs@kernel.org>
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

Add a helper __zpdesc_clear_movable() for __ClearPageMovable(), and use it
in callers to make code clear.

Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zpdesc.h   | 5 +++++
 mm/zsmalloc.c | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index a1834d36ccfc..747a2d410a35 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -115,6 +115,11 @@ static inline void __zpdesc_set_movable(struct zpdesc *zpdesc,
 	__SetPageMovable(zpdesc_page(zpdesc), mops);
 }
 
+static inline void __zpdesc_clear_movable(struct zpdesc *zpdesc)
+{
+	__ClearPageMovable(zpdesc_page(zpdesc));
+}
+
 static inline bool zpdesc_is_isolated(struct zpdesc *zpdesc)
 {
 	return PageIsolated(zpdesc_page(zpdesc));
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 839fe7eaca8a..107973a2a36e 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -834,7 +834,7 @@ static void reset_zpdesc(struct zpdesc *zpdesc)
 {
 	struct page *page = zpdesc_page(zpdesc);
 
-	__ClearPageMovable(page);
+	__zpdesc_clear_movable(zpdesc);
 	ClearPagePrivate(page);
 	zpdesc->zspage = NULL;
 	zpdesc->next = NULL;
-- 
2.46.0


