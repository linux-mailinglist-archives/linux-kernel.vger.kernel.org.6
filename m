Return-Path: <linux-kernel+bounces-265627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FB893F3E0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E4552834E0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FCA1487C5;
	Mon, 29 Jul 2024 11:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0HH8kYx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE86146013
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 11:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722252047; cv=none; b=An1REGyO32fSXgBsztKj48IGTdWkEexwq1VB/kQbm2iBYbth+guvWFb3XMq/0JMZHrHGblWwJKEaJ/Vjjo8tuaZ+k3EMK8rM2QivBqEVnB6XBrq9473KwwG4tThCnSxkTGzFFHSVGS/LbW8WtL+R+XDNTKZkKOkj0PI/pdwM8dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722252047; c=relaxed/simple;
	bh=cpsRKinL3S7LbxZnzQMdHFXcR2a2bxLsePv8cUuJa+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LvZqkjkhG4IPC6fVt5NBn9XgHDlIZ9QgsME7AnSAmBmKfmjjT8ICb/WnNKcnwDerUhE7kzKk8iVl3gqJvVjNx/H1QnBvMkDBPcJpWiJ0sXQJk4cpK0aaMAh+lboWVnUtgV+UD6bd7C+81qyNmtTgWf80j7cmgO33lISI+VbC8BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0HH8kYx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60074C32786;
	Mon, 29 Jul 2024 11:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722252047;
	bh=cpsRKinL3S7LbxZnzQMdHFXcR2a2bxLsePv8cUuJa+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T0HH8kYxUU1m2iRXQy2rq8UBV0w9GOrcvJ5BKUKIZP0MxXQhIiJHVXkOYVVvUrFc/
	 rbr+b4ZBiHZ0MUo9TvktNqnYHiM4n+NSgjKL43RRGvYjmPnPKvw+jCbLo9v9YaBpOV
	 F8ve7JyaLosgbP5LMe+oLr2On8GDoBALuQBVqDlOiAmOJRfKpSmn7ZybSNJ+bx+ffS
	 kGkruVAKs3HzjR0cHAJy5RkX9mjF8+0IztbMD5XpjxbMs7PiqUDSQvpqpyofs8/FWt
	 clA7JVTFSXxI9MlNfs/KV9XHHCns4sVh32aFpY9QJcsQ2236XureRRXkHCFAjdfjc5
	 Mr+RgjTe17w4w==
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
Subject: [PATCH v4 09/22] mm/zsmalloc: convert obj_to_page() and zs_free() to use zpdesc
Date: Mon, 29 Jul 2024 19:25:21 +0800
Message-ID: <20240729112534.3416707-10-alexs@kernel.org>
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

Rename obj_to_page() to obj_to_zpdesc() and also convert it and
its user zs_free() to use zpdesc.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zsmalloc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index d3558f3f8bc3..7aa4a4acaec9 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -820,9 +820,9 @@ static void obj_to_location(unsigned long obj, struct zpdesc **zpdesc,
 	*obj_idx = (obj & OBJ_INDEX_MASK);
 }
 
-static void obj_to_page(unsigned long obj, struct page **page)
+static void obj_to_zpdesc(unsigned long obj, struct zpdesc **zpdesc)
 {
-	*page = pfn_to_page(obj >> OBJ_INDEX_BITS);
+	*zpdesc = pfn_zpdesc(obj >> OBJ_INDEX_BITS);
 }
 
 /**
@@ -1496,7 +1496,7 @@ static void obj_free(int class_size, unsigned long obj)
 void zs_free(struct zs_pool *pool, unsigned long handle)
 {
 	struct zspage *zspage;
-	struct page *f_page;
+	struct zpdesc *f_zpdesc;
 	unsigned long obj;
 	struct size_class *class;
 	int fullness;
@@ -1510,8 +1510,8 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
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


