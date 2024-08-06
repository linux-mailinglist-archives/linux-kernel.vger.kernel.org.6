Return-Path: <linux-kernel+bounces-275595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AA9948778
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A91661F260A8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AC35D8F0;
	Tue,  6 Aug 2024 02:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJ4wy4eK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B22238DC7
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 02:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722910742; cv=none; b=kGWIEsndlz5TABRoPgkbJ6KVrKeehYK+Aipl32IWYFp5f4iTren7JZ1ma8fNbiLYbk9tl7h+w6u2Z4qnMHM+Z6aLoqZe7gvHtUP+jl740Iy0RE9j/InRkWU33oOCiSJBIFMQKGDWb1KV0bkXMdb/ONubOxkcUNegpKtLVk8rmKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722910742; c=relaxed/simple;
	bh=gO5yNLlLwsCfZqvTP2RVzms7OfZiyAMCAW6p5U5JaUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9rdlWT6OD7tMTM33EAPKOen5y+waVpz/18wQr2LBH78YG4PMyizVnnYo3CfOtOGh9ajgffnIfLgNQhEG3HF6lRtNikduWMMIqF71sqPSXEeTbqGYisiT9cBkIonczDrU7W6L/2Onw2GpbtsTobzdYCvXE0OroH5JgKxR5jmEds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJ4wy4eK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9B0C4AF0C;
	Tue,  6 Aug 2024 02:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722910742;
	bh=gO5yNLlLwsCfZqvTP2RVzms7OfZiyAMCAW6p5U5JaUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GJ4wy4eK4qW7kRgbBTYCXZtWl8AumXoo42ILqjgP/YgqVhQuJCoip2c2h9Nz7JxV/
	 Y+POjNOqPqoYGnzttSb8PWI6rk2905cz6tpbM6fPqqHkcZAESSGqoduGWf9qcJC5uy
	 fdj1He4fUsZ+XfS2s6kIB6S2Vcb7Bxox8DH2QYPvI1HsZZTySzchbOkR4W7LNgBlzA
	 VMUbijwI55mKeVswvC6FPobdGxl25MGMZkfiag52ZV5yHMqh0c+r1IyRmuyzBvSkot
	 lmUQeCUa0om8RhsQedOxNuawS8lii5OvwvYr7I3/LzmSnTIKMnm+jenS/B2PwIE8So
	 gKZLae5Vm8ryQ==
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
Subject: [PATCH v5 18/21] mm/zsmalloc: introduce __zpdesc_clear_movable
Date: Tue,  6 Aug 2024 10:23:05 +0800
Message-ID: <20240806022311.3924442-19-alexs@kernel.org>
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

Add a helper __zpdesc_clear_movable() for __ClearPageMovable(), and use it
in callers to make code clear.

Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zpdesc.h   | 5 +++++
 mm/zsmalloc.c | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index 640f33b5c8bd..1ab47faed49b 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -114,6 +114,11 @@ static inline void __zpdesc_set_movable(struct zpdesc *zpdesc,
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
index e2cfee57a39a..7c7432a00a07 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -826,7 +826,7 @@ static void reset_zpdesc(struct zpdesc *zpdesc)
 {
 	struct page *page = zpdesc_page(zpdesc);
 
-	__ClearPageMovable(page);
+	__zpdesc_clear_movable(zpdesc);
 	ClearPagePrivate(page);
 	zpdesc->zspage = NULL;
 	zpdesc->next = NULL;
-- 
2.43.0


