Return-Path: <linux-kernel+bounces-243907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CCB929C41
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA1201F21BD5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C4A770E8;
	Mon,  8 Jul 2024 06:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEHuelEs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0E6768EE
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 06:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720420192; cv=none; b=CUb1zCls21hnc3NPyX3NZn4hCA68LqHv+Jm+mi4CbJXKygCuuisUloxCgzkGKYuJdOjC7wbiJ+NL5LlkzROiWjoRaettlAA9kfXtQAA+YNDwMyEi4GlPsUqcRtx+sJAm+RCsRPziPTbLleuddQ2BwBAhEypvKMftBPWvOo19IAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720420192; c=relaxed/simple;
	bh=ld5kbfQznGqvmPXTBRxo+Gb6MyvpG3bwUJO7MMXVjOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=brwdhlEe4aNysnJtbszy/OLBLVOzFHRPDeL0lLIz4gMp9ZEq1/YtFl+aG6/oWdrJTsJp8smGYfCYA9M31/vsVChX0jcfZ7pRwDQ1YDIwJ9azdR2dQqDwN1Yk+e/7J6s7bjnpIckYovXD8UL1AumZAzPv3L7bvlTDGwdzz+8fyNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEHuelEs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38EDC4AF0C;
	Mon,  8 Jul 2024 06:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720420191;
	bh=ld5kbfQznGqvmPXTBRxo+Gb6MyvpG3bwUJO7MMXVjOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UEHuelEsMNDLfNwnCkG7vPJYg9IVTB41xkci7s51NiPFoDJgxr1CUaRji/cVlqlNA
	 vYdN8sXnViZNe3kSp0lsazF7+z8vLY4xWfdHqBLMGbC9cmI4uqUdMGYDo3TQBRCOan
	 bINlkUPVQMuXuhIZ+Nmq7VOu7niPAgJ43p5dnvdDeoiuXWitnqDwZtAzukSp15x9ZK
	 cWnFn0H6I99oVMAEI4Rc5Q3DCx5/rPZKTYyg1s6wKXmbZf96IvA0lyCPzp1T9ncpt5
	 0eZQBV6bEE+3Jborz9xlh5OA8pkf9vfMZbQks6eVJYhboRqe0qKCucYlARPqFpn8/R
	 Gv4XpWfGxrqZQ==
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
Subject: [PATCH v3 19/20] mm/zsmalloc: introduce __zpdesc_clear_zsmalloc
Date: Mon,  8 Jul 2024 14:33:40 +0800
Message-ID: <20240708063344.1096626-20-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240708063344.1096626-1-alexs@kernel.org>
References: <20240708063344.1096626-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi (Tencent) <alexs@kernel.org>

Add a helper __zpdesc_clear_zsmalloc() for __ClearPageZsmalloc(), and use
it in callers to make code clear.

Signed-off-by: Alex Shi (Tencent) <alexs@kernel.org>
---
 mm/zpdesc.h   | 5 +++++
 mm/zsmalloc.c | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index 5db4fbe2d139..05def4d45265 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -119,6 +119,11 @@ static inline void __zpdesc_clear_movable(struct zpdesc *zpdesc)
 	__ClearPageMovable(zpdesc_page(zpdesc));
 }
 
+static inline void __zpdesc_clear_zsmalloc(struct zpdesc *zpdesc)
+{
+	__ClearPageZsmalloc(zpdesc_page(zpdesc));
+}
+
 static inline bool zpdesc_is_isolated(struct zpdesc *zpdesc)
 {
 	return PageIsolated(zpdesc_page(zpdesc));
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index e1d3ad50538c..d88602fb0233 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -851,7 +851,7 @@ static void reset_zpdesc(struct zpdesc *zpdesc)
 	zpdesc->zspage = NULL;
 	zpdesc->next = NULL;
 	reset_first_obj_offset(zpdesc);
-	__ClearPageZsmalloc(page);
+	__zpdesc_clear_zsmalloc(zpdesc);
 }
 
 static int trylock_zspage(struct zspage *zspage)
@@ -1024,7 +1024,7 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 		if (!zpdesc) {
 			while (--i >= 0) {
 				zpdesc_dec_zone_page_state(zpdescs[i]);
-				__ClearPageZsmalloc(zpdesc_page(zpdescs[i]));
+				__zpdesc_clear_zsmalloc(zpdescs[i]);
 				free_zpdesc(zpdescs[i]);
 			}
 			cache_free_zspage(pool, zspage);
-- 
2.43.0


