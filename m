Return-Path: <linux-kernel+bounces-243906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 070B0929C3F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAA951F21BB2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8464374E09;
	Mon,  8 Jul 2024 06:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWOtxdXd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7CB74077
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 06:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720420188; cv=none; b=s5mYP4TZvJrY04s9PdpQNzGjvfWmrIA/A9bVJatVFJmj2oGWrpCUwTsS6g1vmT9ZcZwqVe8zDc4ohx8ZWpCwkkexI46uJTvo41nuAODvmPGDrw9P+ZSyLeUH9Bm8w0akjoVcdKdhz6Fufb01Go/0HvsggnijYipDwJL5wwEA9Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720420188; c=relaxed/simple;
	bh=H24xLCJMLoMGxtoL02JioPie/ckhzBt773ZzPhU2CSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtw3ThVeAkKa6Zw2A4RjZbkOphRJITCaZnKHajWQhJwLY84dMP40Z7YPONbIoKKICot7ntorNuskJ1noHfJdmIYhaSKB10YfA4KJP+ONM4y8IROeoeFmUVWF/YQxw8qQlWhYY7jBMtdGbxta+CyzytSU71SoJYw1Xbu3SbSjMH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWOtxdXd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66EF4C4AF0C;
	Mon,  8 Jul 2024 06:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720420188;
	bh=H24xLCJMLoMGxtoL02JioPie/ckhzBt773ZzPhU2CSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jWOtxdXdW3pAl2WmrOj1bOnrw+gHOrlhH3zXwNH4eP7cA0yNru3LwOhi4tzn80Rbx
	 cVD76ITdy6l5ySTmIFusfFSQBHDl8J2VB4jbf3A54xhBGhKvlLpl8LWFsbDN6yqiiW
	 s2n8BudgTiO2TsxYnXK3NQY9OpoBTNB5iGwrGOdRxzmGT8ouZKbT+91GBd49d5aNq4
	 l09v7kThk+LyOa6yi3Rt5tTRG8o5GcSjP6xGzOshEy/RdkCcZhw0faZV7UOxRLyCzt
	 dixnOcM1H9x7wG3WYr7joJy86clgn16ANgHuJ4rzG9xZ0sTJu/7N4idkcziq+vkXnp
	 VaalbA+QoqWpg==
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
Subject: [PATCH v3 18/20] mm/zsmalloc: introduce __zpdesc_clear_movable
Date: Mon,  8 Jul 2024 14:33:39 +0800
Message-ID: <20240708063344.1096626-19-alexs@kernel.org>
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

Add a helper __zpdesc_clear_movable() for __ClearPageMovable(), and use it
in callers to make code clear.

Signed-off-by: Alex Shi (Tencent) <alexs@kernel.org>
---
 mm/zpdesc.h   | 5 +++++
 mm/zsmalloc.c | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index f64e813f4847..5db4fbe2d139 100644
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
index bb8b5f13a966..e1d3ad50538c 100644
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


