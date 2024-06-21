Return-Path: <linux-kernel+bounces-223930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA42911A89
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 07:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09F5AB21E32
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 05:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C80116D9A2;
	Fri, 21 Jun 2024 05:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiYuYRr7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E230D16D9B0
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 05:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718948571; cv=none; b=q0kM/3TuerY0RYSMgz/yY+o4FZ39Ck/JCyEPrL8FnAi8zpiZM/5UVKY3OE6ilH2Gc9zMKzfWogmAfK6ci74VVQwlPQPkaSlHAt/n3vWeLPM9YAncRt14Lw4oFd5Mzsd2iuFqzflTtoRb0aud8BKeEI/fMMtNJiqAfGC5H0DoUJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718948571; c=relaxed/simple;
	bh=8UKqY3YZXZR0aUnfYfC3JUjUQBkkwh7XEloB41aBdHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SCkQzZIKATKMUi67Ue1TvKDWX8FtBAinc39q8wIZuqKRk+OHuMF8aYe+BkcRbbxxljnShwvkcvT3HuQ/78/Hkxsmlu2Y9zYx6rdCABVG+nYx/CcP74RV1/eO1alphvT0b//N0nz302Xn+iTPRy32SNa9SropDJNh7Tk6jUQfyog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiYuYRr7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005ACC4AF0A;
	Fri, 21 Jun 2024 05:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718948570;
	bh=8UKqY3YZXZR0aUnfYfC3JUjUQBkkwh7XEloB41aBdHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fiYuYRr7TQp0GCGNgZH88c7pREIwo5/3qN3AIwrtns1l+dudvt+tFgoUVKq89TKyo
	 snExeZWvBIrJREOD7QT35f6EX4JapxfIAgg5B6Sx6sjis+GMfr8SkGndW+9RtZ0TsF
	 5iuRxriNkO5bDJtffxS9vW3ofHEI3ZyYIYGJbFlRGORoDyZnSK4kn3GXmNYyTPM6Oz
	 gMsTqYpy2JUKfNelSOh95H/jOdtAd+QPOBTQrWHQDstm9U894OjWvPuAzmoGkOOse9
	 EPDkIaAE/YTiIkhb32EhxY50or0Iin8djeYzNKtChW6gJNoW8To2gLSidmMn9ywxi+
	 s5yhy6YbOy6rw==
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
Subject: [PATCH 15/15] mm/z3fold: introduce __zpdesc_clear_movable
Date: Fri, 21 Jun 2024 13:46:55 +0800
Message-ID: <20240621054658.1220796-16-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240621054658.1220796-1-alexs@kernel.org>
References: <20240621054658.1220796-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

Add a helper __zpdesc_clear_movable() for __ClearPageMovable(), and use it
in callers, that make code clear.

Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/z3fold.c | 4 ++--
 mm/zpdesc.h | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 35e48440c517..e23d56f46760 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -352,7 +352,7 @@ static void free_z3fold_page(struct zpdesc *zpdesc, bool headless)
 {
 	if (!headless) {
 		zpdesc_lock(zpdesc);
-		__ClearPageMovable(zpdesc_page(zpdesc));
+		__zpdesc_clear_movable(zpdesc);
 		zpdesc_unlock(zpdesc);
 	}
 	__free_page(zpdesc_page(zpdesc));
@@ -1322,7 +1322,7 @@ static int z3fold_page_migrate(struct page *newpage, struct page *page,
 	 * so we only have to reinitialize it.
 	 */
 	INIT_LIST_HEAD(&new_zhdr->buddy);
-	__ClearPageMovable(zpdesc_page(zpdesc));
+	__zpdesc_clear_movable(zpdesc);
 
 	zpdesc_get(newzpdesc);
 	z3fold_page_lock(new_zhdr);
diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index 44473382f2cc..1319575dc31a 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -79,4 +79,9 @@ static inline void __zpdesc_set_movable(struct zpdesc *zpdesc,
 	__SetPageMovable(zpdesc_page(zpdesc), mops);
 }
 
+static inline void __zpdesc_clear_movable(struct zpdesc *zpdesc)
+{
+	__ClearPageMovable(zpdesc_page(zpdesc));
+}
+
 #endif
-- 
2.43.0


