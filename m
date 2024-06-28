Return-Path: <linux-kernel+bounces-233296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1582091B543
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 05:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3D891F22657
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7A2612EB;
	Fri, 28 Jun 2024 03:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asuZ1JAY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CB659147
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 03:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719544043; cv=none; b=av69WvjYAUKvwuyuKtEhmwE+P8but1uAW50I+PRzQNNyd1gUPxE7MyV/tUb/6XIbp/odX9EPFEYxfiemT6p40fOBJAC9cuB/+YLcoA+jtZGjjW2phZRtOQX3Mm1PW7HwZ+/Am4WtQUOUMXxzfHyjEuART2sK4V2LJpRNH0Ha+nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719544043; c=relaxed/simple;
	bh=f1FIB9i8kXKQZtzU8kTMr1QDsZX4ItRyZ1ReJH3drr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h65sz/Buw3JQKn7fyDtuWfkcPVzzmJAsxwtYirsdIh+vWMFNkr9rUzlPG00qdCseSFzZ6bD3+kU8An4hXLesysMkEvlkLgaCBRbwpIpuNKlBoE6+I64Uu0x2ndTyY1b2QEKajvYpyH1DtFK24e3bXMyyYcnAy/++SUjy8dssfcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asuZ1JAY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2EEC4AF0C;
	Fri, 28 Jun 2024 03:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719544042;
	bh=f1FIB9i8kXKQZtzU8kTMr1QDsZX4ItRyZ1ReJH3drr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=asuZ1JAYGbKula5yKxocWKi3XyNBBP9kf53ah/IL0JHq81kjKvUKY3mJqyO7C04nj
	 55mdth8Bvias1bnoJbA9Yl82dad+PZtD0AdoIoQCbd/rEiLLmUVt7peD2R1uj4Z+kh
	 BbN31tKf37MrNy9lcLxSbysArq5k0GH2C6A/e3qUjSoUddir51w3pGo6kBtLKfhBSB
	 39GgUBPrsDKVMJ+53C1BLXuD93wxHgw3Se1SSYCtGZTJWr3Tstzvbm8LDFTQIZH8M2
	 3ppPPAsXRhXnYvn8MycTdHq/au5R9QsL3F0ULCwRm7axJh4eFmoRLDYbAdbETSgYvu
	 k1jLByx8bIr4Q==
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
Subject: [PATCH 09/20] mm/zsmalloc: convert obj_to_page() and zs_free() to use zpdesc
Date: Fri, 28 Jun 2024 11:11:24 +0800
Message-ID: <20240628031138.429622-10-alexs@kernel.org>
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

From: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Rename obj_to_page() to obj_to_zpdesc() and also convert it and
its user zs_free() to use zpdesc.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zsmalloc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index e90e3a638068..3ef8e13fb9e6 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -822,9 +822,9 @@ static void obj_to_location(unsigned long obj, struct zpdesc **zpdesc,
 	*obj_idx = (obj & OBJ_INDEX_MASK);
 }
 
-static void obj_to_page(unsigned long obj, struct page **page)
+static void obj_to_zpdesc(unsigned long obj, struct zpdesc **zpdesc)
 {
-	*page = pfn_to_page(obj >> OBJ_INDEX_BITS);
+	*zpdesc = pfn_zpdesc(obj >> OBJ_INDEX_BITS);
 }
 
 /**
@@ -1500,7 +1500,7 @@ static void obj_free(int class_size, unsigned long obj)
 void zs_free(struct zs_pool *pool, unsigned long handle)
 {
 	struct zspage *zspage;
-	struct page *f_page;
+	struct zpdesc *f_zpdesc;
 	unsigned long obj;
 	struct size_class *class;
 	int fullness;
@@ -1514,8 +1514,8 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
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


