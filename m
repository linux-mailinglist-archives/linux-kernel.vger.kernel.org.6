Return-Path: <linux-kernel+bounces-238827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE0892510C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 06:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F02F1C20AD6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 04:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71483178377;
	Wed,  3 Jul 2024 04:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SClcJWWi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD7E4776A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 04:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719979338; cv=none; b=GBHkR80Ov0TtJ2z1Z1Dgr/+DpENngp17UGuHctgW87FsZ1ou3fC3RCP4peqa5O2rd8xt2WLqy1RY8jd7u4idGqVbgEuU4nqbwvnm7pz8m8lh0DwA0J1nXNyudMZWtKZ6cZXenC6xqGnZzedP6+l+R0mmED9YjCIbAKHMcVaaA40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719979338; c=relaxed/simple;
	bh=WADQG+KFeKRI6MYgRuTdfJ+b1YmyjJ4toh2DCgrdz3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g2TqabVOpHsIzGX8n0ePmSvc2zs0ms20p8dHPHdceGRHlhTNKNnl4uNO03Cv9SHaaEqJ8K1hO1+v3rpx0IgYARwTc1QjNmlGrchLpQmp276KFDzGJsCP+oOsSXWjLX+fciXFE0ZpMSQN32WsaRchv654LtaUlHFqViO/+TIQ+10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SClcJWWi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD1DC4AF0B;
	Wed,  3 Jul 2024 04:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719979338;
	bh=WADQG+KFeKRI6MYgRuTdfJ+b1YmyjJ4toh2DCgrdz3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SClcJWWiEa+5YwdOV0tQyYXItfPMvdIJTAnwNUIfop+4H0HQMX6ZlDZTA9hyInDUt
	 n474nw2Xna1yNdCGIxwVeOL+AsXksKOajIh2vblG663lUPirNCunRmA1yrrPDSvY4t
	 tAKnQr8OFrdsHf20r/qE1JXENe2kMo+E51gUSfzDg6a/UXszSkdWHn34wdnr1yKv1R
	 kF12ECffDFlANRMIMJ2uT+QygpKzV52sLDqzBCGLDPV5aJ6Wt98lGqf5iak5vpEClN
	 dcelnlI5gfXuQnyhUIPfGTQxg211qR96KWLBHvR4OwbGn8W4VGlyU6VOIxCFdv9j9B
	 w2mMYKGx6JW7g==
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
Subject: [PATCH v2 18/20] mm/zsmalloc: introduce __zpdesc_clear_movable
Date: Wed,  3 Jul 2024 12:06:08 +0800
Message-ID: <20240703040613.681396-19-alexs@kernel.org>
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

Add a helper __zpdesc_clear_movable() for __ClearPageMovable(), and use it
in callers to make code clear.

Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zpdesc.h   | 5 +++++
 mm/zsmalloc.c | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index 296cb1ff944b..4780d7015267 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -111,6 +111,11 @@ static inline void __zpdesc_set_movable(struct zpdesc *zpdesc,
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
index 0493f953fcb5..08ab22f0ab7f 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -846,7 +846,7 @@ static void reset_zpdesc(struct zpdesc *zpdesc)
 {
 	struct page *page = zpdesc_page(zpdesc);
 
-	__ClearPageMovable(page);
+	__zpdesc_clear_movable(zpdesc);
 	ClearPagePrivate(page);
 	zpdesc->zspage = NULL;
 	zpdesc->next = NULL;
-- 
2.43.0


