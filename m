Return-Path: <linux-kernel+bounces-238815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A73B89250E3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 06:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50F611F21A6F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 04:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DB8142E8E;
	Wed,  3 Jul 2024 04:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/vn2l9o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A95137C25
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 04:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719979303; cv=none; b=BXO33PWvIhXYy5YrAK6pJmEFC1NYAaDhD7XW+04p8LAZsDiMiBzggnKtCS7WLShFKK3cd8SSQdXhc5uj70uKoYsK9GWeo5VmRF9MRi6ccmYdhlRCsNiJCboCFASHkD3SYbHJrmjSoGQRAN8H7AX8dopZIdBJFXL57raA8A+ozVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719979303; c=relaxed/simple;
	bh=cpsRKinL3S7LbxZnzQMdHFXcR2a2bxLsePv8cUuJa+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qx5sqftZzSuwfH3T6pIio0iIPSIPSUXUxRGyzXr+EAviP0+UPc3jlnxQSfXt/+Fiu7R/QHQU3fQg1kJDiU6C5Wv3/e0Ez/3UNJTtwvam8hu6iUV8Uw8zcAEk6UtPbM1ZIGS8i0+Ngx+mzdPlvNm0xcplt9bzQ9UmMgPAgrDU5uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/vn2l9o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9464C4AF0E;
	Wed,  3 Jul 2024 04:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719979303;
	bh=cpsRKinL3S7LbxZnzQMdHFXcR2a2bxLsePv8cUuJa+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h/vn2l9o3YSdVOjafhW6qL2RUpxiwj6dLECE60UFuR7t8SZfG4edNba8A/qzaWYOu
	 FtDjnMdg7TiMbLrqMf4E5P4XVWzIrH4IQ2A8brhdPHmObwWoKyZSngO9YkKZdafPBC
	 VcUl09u2ChPvdiYH8WCn/LocRf/ff/wUNAE3SdawSUx+9HQEWHIUOw8LeF65Z15POI
	 1EmLkS2S5y55raDFiV3ohsvIKoFNH3jumJfY+f7TobhdeFJyrjTqOoF5oH6ZlIsSTt
	 3Jq7Xy/bhl2AnZ8am4wTsCkWnlp8TBUcPD/dlOh2lY3B5IaxKoCmRyBdS0hpGQz5od
	 KnkYo94ZbqgjA==
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
Subject: [PATCH v2 09/20] mm/zsmalloc: convert obj_to_page() and zs_free() to use zpdesc
Date: Wed,  3 Jul 2024 12:05:59 +0800
Message-ID: <20240703040613.681396-10-alexs@kernel.org>
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


