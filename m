Return-Path: <linux-kernel+bounces-275589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7E9948772
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66602285874
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A19B2A1DC;
	Tue,  6 Aug 2024 02:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvE9YuJi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD6F28E0F
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 02:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722910720; cv=none; b=SGoE/uS8Eh945ggiQRT3rlO6CHI39X5la19F9rVdip1/qgKVwv4ZfvH06mEXWnr4zZYkmUpGBgeGiDrX23xFJxMWnkyyfxmZ5dsYX+r7kTVUCOJZ3srVJXFu698qSPYBNp6CxKPAKI8txc8eZIdu65pWj5rSseIByyxnYL2ZA0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722910720; c=relaxed/simple;
	bh=aFVskGOXvp/05Uc/SGs92DOGYm3KvLJCDxXlSNzTuX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbWl4pZ7Y2yNa+UzYoYCNcP1CPxhYFUXTuzajvag3xDLqk0YuC2GGvJsy5SSg3g5IB3eB1oF04AZ508n4zikUAiOntFOzP+Za+GS99Visx6fM9pmBaQyKOZgS2Ohs5Hcwa8KK85/I8jTH/9woFs4G+GzTT5hbyc9YbHeEIaq4/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvE9YuJi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D72C32782;
	Tue,  6 Aug 2024 02:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722910719;
	bh=aFVskGOXvp/05Uc/SGs92DOGYm3KvLJCDxXlSNzTuX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cvE9YuJiftrDSE1MdCbV7FmQDTvQ0+TQ0arxnPZndZbNu/MTxGTtjGpfe109H63gU
	 EYlozhNKkNouVY2+GUzBSvklk1lOwJte5Wbw/cdE+8jzyW43VHDfNpeanSC+8PlmFA
	 T1z6KNjfNtMt5abA5/7hG2ehSUx5Ru2Mv+oQLyP1YuD7GTKasFewskGQUq8gJrEt/8
	 5VzOBU3CEAoX4BAIxOH4oznwxYA5GhplD0r91533J0skWDt1FnOyWfJlOEvCQOx7AZ
	 jotgu/PQ420IcxYrbHzQKf4mQnk4BqKD21NVym2jYYv8egk9cSHF8LUQayTgt8GFm+
	 0L1DkJwRroClw==
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
Subject: [PATCH v5 12/21] mm/zsmalloc: convert __free_zspage() to use zdsesc
Date: Tue,  6 Aug 2024 10:22:59 +0800
Message-ID: <20240806022311.3924442-13-alexs@kernel.org>
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

From: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Introduce zpdesc_is_locked() and convert __free_zspage() to use zpdesc.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zpdesc.h   |  4 ++++
 mm/zsmalloc.c | 20 ++++++++++----------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index 20881e7e42be..640f33b5c8bd 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -124,4 +124,8 @@ static inline struct zone *zpdesc_zone(struct zpdesc *zpdesc)
 	return page_zone(zpdesc_page(zpdesc));
 }
 
+static inline bool zpdesc_is_locked(struct zpdesc *zpdesc)
+{
+	return PageLocked(zpdesc_page(zpdesc));
+}
 #endif
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index f4fc79c0bef5..4b948b84e7f3 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -881,23 +881,23 @@ static int trylock_zspage(struct zspage *zspage)
 static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 				struct zspage *zspage)
 {
-	struct page *page, *next;
+	struct zpdesc *zpdesc, *next;
 
 	assert_spin_locked(&class->lock);
 
 	VM_BUG_ON(get_zspage_inuse(zspage));
 	VM_BUG_ON(zspage->fullness != ZS_INUSE_RATIO_0);
 
-	next = page = get_first_page(zspage);
+	next = zpdesc = get_first_zpdesc(zspage);
 	do {
-		VM_BUG_ON_PAGE(!PageLocked(page), page);
-		next = get_next_page(page);
-		reset_zpdesc(page_zpdesc(page));
-		unlock_page(page);
-		dec_zone_page_state(page, NR_ZSPAGES);
-		put_page(page);
-		page = next;
-	} while (page != NULL);
+		VM_BUG_ON_PAGE(!zpdesc_is_locked(zpdesc), zpdesc_page(zpdesc));
+		next = get_next_zpdesc(zpdesc);
+		reset_zpdesc(zpdesc);
+		zpdesc_unlock(zpdesc);
+		zpdesc_dec_zone_page_state(zpdesc);
+		zpdesc_put(zpdesc);
+		zpdesc = next;
+	} while (zpdesc != NULL);
 
 	cache_free_zspage(pool, zspage);
 
-- 
2.43.0


