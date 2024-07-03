Return-Path: <linux-kernel+bounces-238829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E179692510F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 06:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 958711F26F41
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 04:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B7F179965;
	Wed,  3 Jul 2024 04:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S95km11Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50725178CC4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 04:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719979346; cv=none; b=BMMkUXB8OO5a/mKwLAHohd0qYoLq/A0OCz6LgDA6tljGX0xiklcL2p4K4bwAv6tfSfEt9xr7Ejbt1ctDjdXu34Ag1Zdh9pfFaVUsyMhybvVtnwUK6I+LonUTmJHl2S8vYdBN9sqHAz7Ye9ArCXRxXZt4K/HfWlCyQQIJGE/JcGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719979346; c=relaxed/simple;
	bh=xf3aTHyp0ikeJrBlj+XtoBw8uMm+YJ3YtskUpiov5H4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C/huOJtxlIeJzmJIhbfPK1wTgs/3WmrFNeU2FdVUMd7yeYLvQmjUbcxEVf3020a9qQr7wGCtV2OyHJ6AFCVNwVURX/4pAgsQPxwBoEOmvT1RGfSVqxrhwoZcHX+RYFMIcxeK+RHoQ19Lm0apy7RKow3IUbjJAeWVhb6DIRF0gZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S95km11Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A954FC32781;
	Wed,  3 Jul 2024 04:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719979346;
	bh=xf3aTHyp0ikeJrBlj+XtoBw8uMm+YJ3YtskUpiov5H4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S95km11YpkihSJvZhp/uEBasmUDA3sdyzUblqTJ0PHexxmxxWnXUj5mtykzJHpNrL
	 XD0RWT9AlXI5pqwVWqcqGazjfUItM50KJOKLYBKitIgobArYWP0maVhIJWPj3Yq0fS
	 sybAhV09B9V1Q7sDjIyjXElsWNUCNqumEPPQgXAFRXYD4otlCHYNLmBIiEUCaOqA/k
	 2eWyrQRHBNjkRAGZQG7t7PJnxkokERgGGw3mKOEfwa19w9CEgKNLYpKeNNXg9xqttq
	 1XwiKETYPDACzuEAZsYk7Nw+G5Bg9RICoxyHVdnSsINHRH3Qe+11uFGhN0hZY5+La2
	 Xii7jQTm0oudA==
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
Subject: [PATCH v2 20/20] mm/zsmalloc: introduce __zpdesc_set_zsmalloc()
Date: Wed,  3 Jul 2024 12:06:10 +0800
Message-ID: <20240703040613.681396-21-alexs@kernel.org>
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

Add a helper __zpdesc_set_zsmalloc() for __SetPageZsmalloc(), and use
it in callers to make code clear.

Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zpdesc.h   | 5 +++++
 mm/zsmalloc.c | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index e6a71c7a3254..d0e5929c1666 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -116,6 +116,11 @@ static inline void __zpdesc_clear_movable(struct zpdesc *zpdesc)
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
index 9e87a17ed802..7bb85447de94 100644
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


