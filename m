Return-Path: <linux-kernel+bounces-284350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FA3950022
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6ACE28622E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD59191489;
	Tue, 13 Aug 2024 08:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zn4AO2PP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F1518E043
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723538502; cv=none; b=Z1MIQWn2aD8nmkRqryK/CLx984FkjS/tDYbrBhY/o+yqaWAlOetEHKjtXJTVRAfWZ4+x7IgFqXJm4tImeYfk1csyi34s4OUKtVy4k24L6gQDi6+LU9iaw/qJZNhA5fh2vlnTw/fWkBIBzHI4AiJdA+7rGz/fxgPZpWRjDqSlhzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723538502; c=relaxed/simple;
	bh=TLwbltxTVpT2lgiPJc6Jxl8phogKw6tUJfKuP0Et5M4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g7W9D/Z5+57Ne1ammkD7CYC/yZjamZmG8kV5ompReUQJ8y2AejyT1mbC2koOOVtZpwhrra/RqM/MNitfZp7hz5W1syJEea4n7wBDkCuWiRIbra1iocHAKJgI4Tdo0QzLU3wDVQ/sGEdt6Nne30v/o0QWmGEUNagPnPHjZZ0dTaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zn4AO2PP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6896CC4AF0B;
	Tue, 13 Aug 2024 08:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723538501;
	bh=TLwbltxTVpT2lgiPJc6Jxl8phogKw6tUJfKuP0Et5M4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zn4AO2PPsEJcQ4S/HgpTW9guymMeO2zo3b9e8FX/6yLaPpDw0yvUCSZEF1oFBDj2V
	 ee4zE0Yh6pulxHPa96xkoQA8A38ttfDQppDSn3RBMZez9+OUE2NO1KlMRwQjgRWSfC
	 MW25K0Kbmj/zZZO12e6xpBLe8W8zJA6dBZvuw6mmzVnXgdXxtQ+7LXnPPqAJFP9z8G
	 IaZuTq09bkCVYWjqEmZZLFL5NbsJJEnOzGWh4c7AFa6Af5SoD6Yego+/BzJ2D0mO8w
	 6j7jE3ZKKt/fXyxXpy/uhyjt47zFMj3n8FY+7qL5SI8jqBzoxQRKYHJ8QAxwY7xUe6
	 LnSzxgNYWLTpg==
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
Subject: [PATCH v6 09/21] mm/zsmalloc: convert obj_to_page() and zs_free() to use zpdesc
Date: Tue, 13 Aug 2024 16:45:55 +0800
Message-ID: <20240813084611.4122571-10-alexs@kernel.org>
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

From: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Rename obj_to_page() to obj_to_zpdesc() and also convert it and
its user zs_free() to use zpdesc.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zsmalloc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index b07c14552276..cb90defd3c0a 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -814,9 +814,9 @@ static void obj_to_location(unsigned long obj, struct zpdesc **zpdesc,
 	*obj_idx = (obj & OBJ_INDEX_MASK);
 }
 
-static void obj_to_page(unsigned long obj, struct page **page)
+static void obj_to_zpdesc(unsigned long obj, struct zpdesc **zpdesc)
 {
-	*page = pfn_to_page(obj >> OBJ_INDEX_BITS);
+	*zpdesc = pfn_zpdesc(obj >> OBJ_INDEX_BITS);
 }
 
 /**
@@ -1490,7 +1490,7 @@ static void obj_free(int class_size, unsigned long obj)
 void zs_free(struct zs_pool *pool, unsigned long handle)
 {
 	struct zspage *zspage;
-	struct page *f_page;
+	struct zpdesc *f_zpdesc;
 	unsigned long obj;
 	struct size_class *class;
 	int fullness;
@@ -1504,8 +1504,8 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
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


