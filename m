Return-Path: <linux-kernel+bounces-233306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A6891B54D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 05:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67B41F2159F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14410763FD;
	Fri, 28 Jun 2024 03:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mk0Y3czk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541337605E
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 03:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719544079; cv=none; b=L0f7OGuysewkj5ekbL3lZvNot08jUb1oy0ByMl5+TQ3SnIblGcCE0FvInjKn57gUBuvtAGfWgW8tF/x8/YjY4elBdykvA+3hpGY07Y1r7Ge/3/p5fXuE8S5+QRPeggRI1BLcoera/DL8QmmyAukl7d/7IiVu9CeTKWfScTJeQX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719544079; c=relaxed/simple;
	bh=1b2JRlKwTFXQCKXls2arw2ZYXd32r3yXKlFqVVcujQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AKIBRq9jVEsLOCot5BApZdFgik6WbLYKde/w/W3BcuyBlcZWhwVf9iEFhc/oe8BEgMeTQbGKRuYvV4f0dkcYD1PiKuJkovzHpkuCIhtbrphAEACAg+7aWciCWby15X3DqAgDW647NH/FXezdR/4L/yIVSLLB+IPg4xIKbaOhwE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mk0Y3czk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BFEC2BBFC;
	Fri, 28 Jun 2024 03:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719544078;
	bh=1b2JRlKwTFXQCKXls2arw2ZYXd32r3yXKlFqVVcujQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mk0Y3czkLU95tgGbkMh1dc7Ujh5UVx4rFxHwXuxVsgEsk/u+S4AReBO1g56nW+Nhh
	 3YmhlRIT03b0vDYM21OStct7U9LXxp1hcClg6Ir+2o7e3MxGkjqKbb5TODMs8B/69m
	 s+9yoffNOB1dnVjRcLRz7Za2COjRzhajsk6g2M9mBVyu1yDZ0XyVjnPwzMhEO2SUBx
	 oWnWAdZdNEGIBe+7XR2MbwfFfO024TyLiN67b3jo42V6s/nL20YHE/H5HsXiKGt9jr
	 6ax09zDtLSK7qDG6FRD4gBONZiiKEkcRz4bX6SQ4ufwhNd7vi0wDAs2fplpKZqB0GJ
	 479dAcAhfe1uA==
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
Subject: [PATCH 19/20] mm/zsmalloc: introduce __zpdesc_clear_zsmalloc
Date: Fri, 28 Jun 2024 11:11:34 +0800
Message-ID: <20240628031138.429622-20-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240628031138.429622-1-alexs@kernel.org>
References: <20240628031138.429622-1-alexs@kernel.org>
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
index c6a44fe04f97..e346b39aba59 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -107,6 +107,11 @@ static inline void __zpdesc_clear_movable(struct zpdesc *zpdesc)
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
index abecc8a5c566..eaf8dad04f2c 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -853,7 +853,7 @@ static void reset_zpdesc(struct zpdesc *zpdesc)
 	zpdesc->zspage = NULL;
 	zpdesc->next = NULL;
 	reset_first_obj_offset(zpdesc);
-	__ClearPageZsmalloc(page);
+	__zpdesc_clear_zsmalloc(zpdesc);
 }
 
 static int trylock_zspage(struct zspage *zspage)
@@ -1026,7 +1026,7 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
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


