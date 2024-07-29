Return-Path: <linux-kernel+bounces-265633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAB493F3E7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 892ED1F211C2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511DB14A4DB;
	Mon, 29 Jul 2024 11:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5gCrlI0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF701465A1
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 11:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722252063; cv=none; b=aNiX8FpQa9WfrH4pyrNOj9S1pPL1t/cKLTshqo485efxAD5gBiylwlZc1Bopp5WsgfjLosNpQwd/bNEMZGu4GNrph7Tu8jp/BuwZuzRysdxEj0Hi43WbYMck+RHkBTCVOgfxLhrJqeQQfazPbggCt8hge34YoS2I8euBRjsWn+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722252063; c=relaxed/simple;
	bh=K3GUIiHemMLy8fa8RNH072Iq/pXEu/mTjv8z/3myXkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MNljwLlWCzrYw5Iagc+T4/1UKkmjwMbUjzFFOUdEO9G0mUbxadosey1ueXF0lpWocxYIpOOHURMApaWglBiXd27oDaidHxG2LV9Dci5CXXhLHSGAqiV+mNcBP2Soj1b9/oqabJr85uJQjNpvXcpt+vy+S8ucxKCEnf0tbV06LNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5gCrlI0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A282AC4AF0C;
	Mon, 29 Jul 2024 11:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722252063;
	bh=K3GUIiHemMLy8fa8RNH072Iq/pXEu/mTjv8z/3myXkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o5gCrlI0q81yaT0XVXU2oqnN965qfPvIFAFcpm5o8+/9uozJOlLo7KU+gwBQ+kwOP
	 iAnLxsVxjYVw3zhS0k4gOkFU4woJ9SVcQP/bLhknsUR1zUBYaLZMii9yqmeKAuapKI
	 U/yfn6gsE25TokO5tBSpDviaM4NXHWSY5+3PCs9Yvqwi0cNmLTS6l+swpRFFoUEw47
	 glc2GKCDOuvKDd4g1VWHlltI66gYTXQC67wpWqGAQwrBq4RLqouYP96rjmrEw+3uab
	 QDMOv8TaAYsoO6R5qrWC/i34oo75n8qUzH2KXjSeYp09IZ7uZoph5jQun18uSGhPaj
	 mQRK84Tevde6Q==
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
Subject: [PATCH v4 14/22] mm/zsmalloc: convert migrate_zspage() to use zpdesc
Date: Mon, 29 Jul 2024 19:25:26 +0800
Message-ID: <20240729112534.3416707-15-alexs@kernel.org>
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


