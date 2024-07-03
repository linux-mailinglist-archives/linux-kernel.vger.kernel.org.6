Return-Path: <linux-kernel+bounces-238828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8209092510E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 06:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C45B28C7FD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 04:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B761791EF;
	Wed,  3 Jul 2024 04:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rxj4KWb+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F66F178CC4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 04:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719979342; cv=none; b=btb4tj0gq3BlFGLGQApJ+4OJP4jKEHTMyg9hEnHirBlYN8A4iDZlB4rn8DwPuH7Y3DkQVJA8WmQukKAvGejghIoTL+BSLmCeTr0ODiuGs3lvrn8Mjl4yh2Eunwk1aBs1B7qne5bFkSYSyoeYOAcSHaaVV/vZRluRC+i4mU32luk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719979342; c=relaxed/simple;
	bh=hU+tJyMJYXqvt89j51XXi7aJ8UUcH7P41TCm8J5zHmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hKP1p6pthuqsXC68DC6Iz4mTJaA7xcoZPBpRNrWIbWjoJ2QCUHIwk6X3/UN8CH4bt+Kip/I09xe85pCZMSvFq6k45p0879hTlX0cSLZLcaNpb2EHNc2Qam4YwnACoo7WtMj9PL69T3yxlnwKAheR3/dTAIcBOXCHDVIvmmVpDjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rxj4KWb+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA06C4AF0C;
	Wed,  3 Jul 2024 04:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719979342;
	bh=hU+tJyMJYXqvt89j51XXi7aJ8UUcH7P41TCm8J5zHmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rxj4KWb+WvTzcDWLevWOhyIZvPre2S3FEfiFSoQHVdaD48MPqIaESXA0lOeqDWz4J
	 +PV3qdO7ClN5HuEXB8ZUTc93SoSHRCXfeyZI6fUCocUSJvT7GQ3gYuhhwAhBmiA2gQ
	 7Yd7yqxS9s9YMDPR2GjZ+8cb7cxFRTqV08nofEfWWqVvquRaIH5UowQJOAm9rb6Gk6
	 EqDDetEeLI9t2PnL67Cb00PJ3IQcUEQU3tIyO/IsiBlD8O1p6pNaYiknY4a9ISb+wO
	 E+VQvCq3i2xi4qwqy6BJzM1lJTJPnVc4iWDAyklxFyGuvDzcv8yzDdWvCLl69l39Ja
	 +6L9lNmpQ87Pg==
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
Subject: [PATCH v2 19/20] mm/zsmalloc: introduce __zpdesc_clear_zsmalloc
Date: Wed,  3 Jul 2024 12:06:09 +0800
Message-ID: <20240703040613.681396-20-alexs@kernel.org>
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

Add a helper __zpdesc_clear_zsmalloc() for __ClearPageZsmalloc(), and use
it in callers to make code clear.

Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zpdesc.h   | 5 +++++
 mm/zsmalloc.c | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index 4780d7015267..e6a71c7a3254 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -116,6 +116,11 @@ static inline void __zpdesc_clear_movable(struct zpdesc *zpdesc)
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
index 08ab22f0ab7f..9e87a17ed802 100644
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


