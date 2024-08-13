Return-Path: <linux-kernel+bounces-284363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C26E950034
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39AF12841C0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245BB19D07B;
	Tue, 13 Aug 2024 08:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mejI+7CX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC1C183CDD
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723538545; cv=none; b=nRARbZmHf9fKAgI4RfjFKCJ2cSjsBaN7B3v/37x7kpijOS4JvfjiAh+c2Bmh3884/WfPk0AOqT8Lgw1Tqg9tAQyOxMjYLFL3uH6XkJ9jz5paZsu7ZqVJ27Rr9ygc7Jl6tIeu73U5K9qi5e6e0xGpos7emdtd4fMOqPsvgVUeDcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723538545; c=relaxed/simple;
	bh=GGradnuK41+byBnHyefAqZD3LeHddFsDEO4CJxk+f0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=haCNPfejcpiKYo+PZVJuS/d80WlRoWb5meO684XTVfCa0+iOM8OnUr2EiABDbmesvmmsGWm4M70TsNC2CblvdIUP5kpKt95dd3HK1OgglsUjHeRelMNTYR8404ZTkzC4QuZfFZkyL2qYK+m79LCM1kyHvRRP7ITpC7Out+rZ4mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mejI+7CX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BD2C4AF11;
	Tue, 13 Aug 2024 08:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723538545;
	bh=GGradnuK41+byBnHyefAqZD3LeHddFsDEO4CJxk+f0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mejI+7CXbaNN6QrWv+gyGHDhIeialjnXVUEkoTuuLiEMeYDjaTjw2VDn0SOFfEsh+
	 vkOy9tq9upX8uw+PGZwrRA7TL02hSe/SSLQu9ho+WBZ/gGhSAi0deOsMzgTWJj0qFK
	 bAPIKaZJNX23wmCL/wjJgJyg+taUjPfBiJicIxiIJnRybb3u38WhJyPrZjzcKFdfnY
	 dJhLNNOuTQDiHAN8zzMxGCNabpnbvFHoiTF8PrCj8dp/ZbafQ/mgFOcm1LRBCL0w4N
	 TAkESIteUK13GxF+JSJWpscWFt5ewHxF8BP4wjSjo24OLkNaugLTprwReAlL22HdVS
	 6lhrf5QpTGRjQ==
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
Subject: [PATCH v6 20/21] mm/zsmalloc: introduce zpdesc_clear_first() helper
Date: Tue, 13 Aug 2024 16:46:06 +0800
Message-ID: <20240813084611.4122571-21-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240813084611.4122571-1-alexs@kernel.org>
References: <20240813084611.4122571-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

Like the zpdesc_set_first(), introduce zpdesc_clear_first() helper for
ClearPagePrivate(), then clean up a 'struct page' usage in
reset_zpdesc().

Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zsmalloc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 6e7cd5acf5e5..3dbe6bfa656b 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -253,6 +253,11 @@ static inline void zpdesc_set_first(struct zpdesc *zpdesc)
 	SetPagePrivate(zpdesc_page(zpdesc));
 }
 
+static inline void zpdesc_clear_first(struct zpdesc *zpdesc)
+{
+	ClearPagePrivate(zpdesc_page(zpdesc));
+}
+
 static inline void zpdesc_inc_zone_page_state(struct zpdesc *zpdesc)
 {
 	inc_zone_page_state(zpdesc_page(zpdesc), NR_ZSPAGES);
@@ -838,10 +843,8 @@ static inline bool obj_allocated(struct zpdesc *zpdesc, void *obj,
 
 static void reset_zpdesc(struct zpdesc *zpdesc)
 {
-	struct page *page = zpdesc_page(zpdesc);
-
 	__zpdesc_clear_movable(zpdesc);
-	ClearPagePrivate(page);
+	zpdesc_clear_first(zpdesc);
 	zpdesc->zspage = NULL;
 	zpdesc->next = NULL;
 	reset_first_obj_offset(zpdesc);
-- 
2.43.0


