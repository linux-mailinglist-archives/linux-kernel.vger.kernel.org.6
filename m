Return-Path: <linux-kernel+bounces-238820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7088D9250EE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 06:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 131531F2646E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 04:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E939116C6BE;
	Wed,  3 Jul 2024 04:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAi8VdfB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC2E376E1
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 04:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719979323; cv=none; b=XLeIIa3Sq46Ywhf4K7N5oRsIJ8yCwjCWFsNe7KhfM8ECaZ3ITBh/J/PILza/QdoE3ma8W8+T0R8mOP+6lNZ0fmdzgti97eARE/oeZMR2tqGHg1UAsCVjEx/UIHles6ET895A+cKCvKgoDcazCUHsQrVvl/gDf/8ENSnThk5+7UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719979323; c=relaxed/simple;
	bh=K3GUIiHemMLy8fa8RNH072Iq/pXEu/mTjv8z/3myXkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/UmLZW3pXew+7T+vmIqVl7/+ceRbnqMV/tmlNsArXTwh5ywKPP35Cs1ih4pBMD0+T1hManL0B6Uj1UMM/+Pc8AAElqMRVXWCSwgwIquOCM7hr1TmCJ+TXdyxlD/tKUMrWXJtowfVqMXc7jUbtsg3oS96RPEOQfHQ/616fcnWhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAi8VdfB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D940C32781;
	Wed,  3 Jul 2024 04:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719979322;
	bh=K3GUIiHemMLy8fa8RNH072Iq/pXEu/mTjv8z/3myXkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UAi8VdfBMIZrg0juq8txVEnN9W0EIBUjwpsOIiZcXYiKs8oR980Yy+uHO+fcF89px
	 gU3DFwUpEt4cZuy68LLq7XCBh43WC3tWvg/b4RPgShtXhVSLkiqtHB6Cw08GmHBaVy
	 t6TqfuihXAZJUFK2cGbb3I5U/kDa7LC25OR2aSeCr9jAJietiU90ZjWEIYzzKKbxcN
	 IWqeUfxpYZiX8g7ytLWs+EQNJ2gLMuYGRelGem7bQ9Fgma33GDoN8rvUrqdybqMNJr
	 Ao86j0XjV9Ea2MaRgEYnIk5y5CDjM9z8tG8mHiz0IxMP9HeX7MTYQa268tc5x3zpae
	 OkY1Nxw+l3/6Q==
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
Subject: [PATCH v2 14/20] mm/zsmalloc: convert migrate_zspage() to use zpdesc
Date: Wed,  3 Jul 2024 12:06:04 +0800
Message-ID: <20240703040613.681396-15-alexs@kernel.org>
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

From: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Use get_first_zpdesc/get_next_zpdesc to replace get_first/next_page. No
functional change.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zsmalloc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index e291c7319485..7d039b0c66db 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1636,14 +1636,14 @@ static void migrate_zspage(struct zs_pool *pool, struct zspage *src_zspage,
 	unsigned long used_obj, free_obj;
 	unsigned long handle;
 	int obj_idx = 0;
-	struct page *s_page = get_first_page(src_zspage);
+	struct zpdesc *s_zpdesc = get_first_zpdesc(src_zspage);
 	struct size_class *class = pool->size_class[src_zspage->class];
 
 	while (1) {
-		handle = find_alloced_obj(class, page_zpdesc(s_page), &obj_idx);
+		handle = find_alloced_obj(class, s_zpdesc, &obj_idx);
 		if (!handle) {
-			s_page = get_next_page(s_page);
-			if (!s_page)
+			s_zpdesc = get_next_zpdesc(s_zpdesc);
+			if (!s_zpdesc)
 				break;
 			obj_idx = 0;
 			continue;
-- 
2.43.0


