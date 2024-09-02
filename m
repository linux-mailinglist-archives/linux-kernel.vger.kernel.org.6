Return-Path: <linux-kernel+bounces-310714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C37596805B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7EB6B236F7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F47D17F4E5;
	Mon,  2 Sep 2024 07:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTv2JYWK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B368515FA92
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 07:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725261441; cv=none; b=D8idqp1q5RYglP364lNqIPiTBQ9Q0oSlVImMScP2+0PekVL4ENGBW8yRe9Q3laX0vyWnAkgwFJYMmo6x+4dbLRwNRHOtSqsKBLgsg9SGUtzShYk/eq7HCjVqsPOGw2ZWhwIEVEdDf9RPbB53FcrJDAvQBlIwirQupqDsjhZjURE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725261441; c=relaxed/simple;
	bh=oMrU85lTLRKqEwjZvX+/RAn/IsBRgGpZpbsgEGeKZYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SEXxDNVyW6kW30Ci3YT4hC4+i3w8awSB0zRNzOzxiJ4ho9gnkpmloXBXQMFAcF4yLbJm6JiTUPQ3+83waKZ3KFu2n8FAysF8pbi5wPQfoqBfYcmXj100bN4oUjSXdoBVd2JI+zL7aSj7UeivnX8j1rJLbUTQzwtt0H5RXvRLcEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTv2JYWK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE76C4CEC2;
	Mon,  2 Sep 2024 07:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725261441;
	bh=oMrU85lTLRKqEwjZvX+/RAn/IsBRgGpZpbsgEGeKZYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uTv2JYWKBWs/eY3vQwV4b7d46Dw+8FnfttVYa627PvUXCjgj8YFZiXNE2cONgQ2vD
	 JkgfML6hEagHjvBeo08sMYm5L9jLkSjtkTdRS7T2LkNHQcFsDx2bVCHMuvp3eznYve
	 SC/wsNxQ0jT08WxCgk5l1VnUbaEx4JcQxRDMcaxevO06zXMJubQ+lKPSu3nErUeF92
	 QQGh6bVLa6es1W1dR3HomaK6ZvUGMjggVhm7u6kO/swf/AcMtavkx6lsFCqJXQU6Mi
	 1Vo67rxmdi0vb2Ei+Mo06rE6WDhBAFTKNqdPX1iPelhAwfZsjP4PMzXFTcnadVGpX5
	 LyF4L2q+hsbNQ==
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
Subject: [PATCH v7 14/21] mm/zsmalloc: convert migrate_zspage() to use zpdesc
Date: Mon,  2 Sep 2024 15:21:25 +0800
Message-ID: <20240902072136.578720-15-alexs@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902072136.578720-1-alexs@kernel.org>
References: <20240902072136.578720-1-alexs@kernel.org>
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
index f94c3a6653c7..aeb8cab5767b 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1623,14 +1623,14 @@ static void migrate_zspage(struct zs_pool *pool, struct zspage *src_zspage,
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
2.46.0


