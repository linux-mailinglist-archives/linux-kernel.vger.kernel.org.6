Return-Path: <linux-kernel+bounces-275586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC6194876F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9914F1F25137
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C18537F8;
	Tue,  6 Aug 2024 02:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBV8krES"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C855051C3E
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 02:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722910708; cv=none; b=JyPaZok1XPVhUECKoJ+bPlcxt7XDsoJ+DfaTkXJOf3R+k3FgTIaMmGH/FUwRHwu2p63UtTUyL5WCCtNZ6HR7eGJ3M3j2pvOwDktY1zcjPI3iYnn64SnTxRKMbZyQx/COcOZcZsQ8W6/nJBEv4fxLe36YfMEResKB9iVaoK1yT1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722910708; c=relaxed/simple;
	bh=2XuUwCpmZ+NvY5bJ3CJbiV5pb57fdunEaUBcKFqNcHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CDW3Ej4ijvXl2OcfyVRn4y/iBSsQ776rgoaZDVHLP87FqC0Pv54zrdJRY029fjaR3gorCt081ocTXGOeD62QppIfrEIvNLW18v2/i6V+276bYZJx/xTGcJcr41yBF3W14ca0Rx/DVRBhmzkD5pKHOgEwTh6owFoOH0YzZ1Ys9bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBV8krES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66673C4AF0F;
	Tue,  6 Aug 2024 02:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722910708;
	bh=2XuUwCpmZ+NvY5bJ3CJbiV5pb57fdunEaUBcKFqNcHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QBV8krESkVQBI1btdudXp3KnYlXCSSkzzl+6/65HHV3ctpQCaq1VOxmims7maxwHY
	 wrBU3toUz1xv2/xTaEdWgIGqSdlbQT8ALHlvL6k9uSg7FUZoD2n3R9jk12A6+w3PPG
	 4p9Qjo2J8NR/4mJT1z2wuIu0hKQsn8J025ArD7UIENklvSYRCOSEarp8LcmPNjEITN
	 fnG0iA0wTar2Lb2bdYWWc9r/imZYQ83co9ypl4Ct5PTBSrK62sZ/wIQDLljIBPQAks
	 EsRG+glMxynyTvNGO7qfPVnLA3IEmk1uoQC882anPHSZqeNAp7qpEJjUJ8+3Lp09gw
	 whxLi1wfKYSfw==
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
Subject: [PATCH v5 09/21] mm/zsmalloc: convert obj_to_page() and zs_free() to use zpdesc
Date: Tue,  6 Aug 2024 10:22:56 +0800
Message-ID: <20240806022311.3924442-10-alexs@kernel.org>
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

Rename obj_to_page() to obj_to_zpdesc() and also convert it and
its user zs_free() to use zpdesc.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zsmalloc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index d7400acd0f01..5fac2bb436f8 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -800,9 +800,9 @@ static void obj_to_location(unsigned long obj, struct zpdesc **zpdesc,
 	*obj_idx = (obj & OBJ_INDEX_MASK);
 }
 
-static void obj_to_page(unsigned long obj, struct page **page)
+static void obj_to_zpdesc(unsigned long obj, struct zpdesc **zpdesc)
 {
-	*page = pfn_to_page(obj >> OBJ_INDEX_BITS);
+	*zpdesc = pfn_zpdesc(obj >> OBJ_INDEX_BITS);
 }
 
 /**
@@ -1476,7 +1476,7 @@ static void obj_free(int class_size, unsigned long obj)
 void zs_free(struct zs_pool *pool, unsigned long handle)
 {
 	struct zspage *zspage;
-	struct page *f_page;
+	struct zpdesc *f_zpdesc;
 	unsigned long obj;
 	struct size_class *class;
 	int fullness;
@@ -1490,8 +1490,8 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 	 */
 	read_lock(&pool->migrate_lock);
 	obj = handle_to_obj(handle);
-	obj_to_page(obj, &f_page);
-	zspage = get_zspage(f_page);
+	obj_to_zpdesc(obj, &f_zpdesc);
+	zspage = get_zspage(zpdesc_page(f_zpdesc));
 	class = zspage_class(pool, zspage);
 	spin_lock(&class->lock);
 	read_unlock(&pool->migrate_lock);
-- 
2.43.0


