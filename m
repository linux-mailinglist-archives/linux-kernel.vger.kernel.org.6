Return-Path: <linux-kernel+bounces-243902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CDB929C3B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2DAA1C209BB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D161CD1F;
	Mon,  8 Jul 2024 06:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJRGhy3n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FB21CA96
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 06:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720420174; cv=none; b=QeRvfY6N2qSjipcH5d2eR9OzzLvcZyhiUo2Os72C9rELEyjLQRrVkRtrAYc0NuzO4UK2RrJp6rmD8OPZelhM3Y/x3Zv1E/Vvsk/sqZ/v39mAoRss1mr1nrxLYOS8i4WXQi9jC/5dlhOUMYMZv3V0Vparj0cytAaFpEzZTUxptb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720420174; c=relaxed/simple;
	bh=cbT48olUQwlsCFwwUYnjfHlBbFy2rEQMOoWsy01+W3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rsfplf4Vh889/hUM/eAC7JbAQBfKmtMgz8X2LBNU+yNim7iZ9NVg5x+EpRhCG8l6qaUJw99Kp1jZ1CkoivqpJn6RkfXncTkUhnG7/eWHflPlnbwi1MDdJN/UZiO5UjLY9/h6CQ57xvR6tT0HIufQiWwhe+U4Qt3XvQwAnj+d+GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJRGhy3n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7BAC4AF0B;
	Mon,  8 Jul 2024 06:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720420173;
	bh=cbT48olUQwlsCFwwUYnjfHlBbFy2rEQMOoWsy01+W3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UJRGhy3np6draIrQ5dcJhaA8p3BR4ME3fuTKdWducweIJsmTBd+uSKYPdZll3y7rm
	 BxNOBa57Zm1zxbKwTabeuj6D09i+Zx1Uqgc0/aMswDBCkx3BTVd/V86FadDBFg1jSX
	 BwKjViQcGzHORnrteaoEWLQOTQNPKxr/BeqB/dbTV5U0VQTG/0EXsIWSJ2BmctSbcS
	 2viqi+gbSiBA8ugd6tbWwy5+9acn1fm262K3J2Ks5WpmB6jzbUYQUrPsTs9RMuSHtF
	 oCsf2LjiyQPjkrP1tVBJhIa6h36V1RZwq/GgYIqENIYg8Da1WzohE7MWLj8O9AMB8z
	 hNL8CYaHOa2kw==
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
Subject: [PATCH v3 14/20] mm/zsmalloc: convert migrate_zspage() to use zpdesc
Date: Mon,  8 Jul 2024 14:33:35 +0800
Message-ID: <20240708063344.1096626-15-alexs@kernel.org>
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

From: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Use get_first_zpdesc/get_next_zpdesc to replace get_first/next_page. No
functional change.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi (Tencent) <alexs@kernel.org>
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


