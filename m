Return-Path: <linux-kernel+bounces-265638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E2993F3EC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0AA61F22185
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07AC155382;
	Mon, 29 Jul 2024 11:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpQwJ0V/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246DC145B38
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 11:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722252080; cv=none; b=TOM1fpDWFgzmLl+YOhLBqHaccYkTRVtJicFeOPMW5k3ROzxkHyU0IvNXXI8yXyGBWAay0E4ZAw5Br9GDPkUYWwqerqmi/kvm1DcPtrgUadz+oYwpiFDQicQYiMEovxe5Eqor9GM1CnZ1kp4gmDZaMo9hzwC99+j5fEo49Wc7tyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722252080; c=relaxed/simple;
	bh=PC5jkQnfMoZxwZVAO0ES1OaCQkwLNtrVhI+Kr1f/doM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fBt/WgPXlYbJtyajLevKgLv0GFStcQjlaefM8t1lAMxWMECgVqz3CNG6izCvruBi5lXI6jaJU7Bp5AWwxaTi8H5y/hJudd/2/yl+T9WbVr2NgsYR+mpT+60SNrQWdu+bPX7dV/DIEiXyQf1Jm/foNy+4WtKj9jWHZXzMnRgaH/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpQwJ0V/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CF5C4AF07;
	Mon, 29 Jul 2024 11:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722252079;
	bh=PC5jkQnfMoZxwZVAO0ES1OaCQkwLNtrVhI+Kr1f/doM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NpQwJ0V/9xj+pd3NV/uPFqOuWZuUCH5VTltgNIR8JOiw68vnQc/mmjRL0R+hJWPxS
	 Dqj7sdu4p9fgtW71tq2acbFtvgIwIS+KcTUjHrotVN/yVR/dZRkf2/NTlNH88FSujg
	 vs/cboP6T/die3KPnUcQ3a7vLIHFQAd7vhxELPhr0uAgH0yLI9u4oj4KCueAQQtQ+j
	 hfJa1OSHq5027FOLujL3t3jPAv+nnvPLuFDnOI8ZBS8pVQPq+XweejJbEpa+AAFBUE
	 9ODKZcowCZRBUoWE/Qunc4kTxmTQBQGxTG7Ktvz9eiAMTsjs7iqp18x5xpqq67Z7H0
	 NU6nTU1sOW4uQ==
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
Subject: [PATCH v4 19/22] mm/zsmalloc: introduce __zpdesc_clear_zsmalloc
Date: Mon, 29 Jul 2024 19:25:31 +0800
Message-ID: <20240729112534.3416707-20-alexs@kernel.org>
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

Add a helper __zpdesc_clear_zsmalloc() for __ClearPageZsmalloc(), and use
it in callers to make code clear.

Signed-off-by: Alex Shi <alexs@kernel.org>
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


