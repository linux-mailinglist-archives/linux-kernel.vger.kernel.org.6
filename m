Return-Path: <linux-kernel+bounces-233300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D51A91B547
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 05:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D44CB21D87
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54534249ED;
	Fri, 28 Jun 2024 03:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIUTcWXK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9CF21342
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 03:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719544057; cv=none; b=HWSc4mxBnXWvHVRNemNiu+EnpIzheMQtVVCoIrPNNFoWvcOshKMB4U7kuewIkeq5eAQYJ432zUDsXSxkF8tr+xJF+b0FDQTU7+fUpyECzW/+Q5gWrqeL7I0JsMO+Y8ijuLIxSd8uA6ijVpB21TUijI8TviuZdT/DBBJ7cNfdaSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719544057; c=relaxed/simple;
	bh=gedDp0RHU7Zb19ZIAumudrHJ1RWmViS9C8nGeod0zds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rzl34+byiKnyFu3YnStKPzInhHH0RPZlpO3krSnMmLAmRd2i86QqMyG77VQe8ZRr8DJnRW7foD4So7P6gnjVFE8T5z6V4YeQ84Bwd0oFFHe30kGiwhUaPV25OcfL/6n5Xjivov2HzqdEz3aIZVLNPsb2fMNJiHnaq9FsSEAUbtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIUTcWXK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C8CC116B1;
	Fri, 28 Jun 2024 03:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719544057;
	bh=gedDp0RHU7Zb19ZIAumudrHJ1RWmViS9C8nGeod0zds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oIUTcWXK+xs8W0Bn+nZd+E2zqjNEJ8xxmE/ynQKaenuBx0s++2m7yO67tPFf51YlB
	 QNtpHUsRZ3/KM9uiJkqmmWApsGNcD5Z4brLMBJm7rD9XT6E+m8POORQcq0+eM6IZhX
	 A3xTV3/hWWTqz+QxjbnhnqWH3t0NQdJefRAGWm4AaAoiasyGi7TJXpct7XkGKoyPEf
	 bo8vRCiWJxJtEFuXHFms5scP7tUJ2i+4wyOJBLnYWfUmoIVDKACDbY8HbwIfv5bR8q
	 OPBReFRDgjZSfMO/MF1XAy2s/p8kAdKbeWbZLIC+70s8CeBaHItKYNJoWCiVttKUU3
	 6qDrwLqLmgX3w==
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
Subject: [PATCH 13/20] mm/zsmalloc: convert location_to_obj() to take zpdesc
Date: Fri, 28 Jun 2024 11:11:28 +0800
Message-ID: <20240628031138.429622-14-alexs@kernel.org>
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

As all users of location_to_obj() now use zpdesc, convert
location_to_obj() to take zpdesc.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zsmalloc.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index bf5a1b63bb17..e8af01768ae0 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -828,15 +828,15 @@ static void obj_to_zpdesc(unsigned long obj, struct zpdesc **zpdesc)
 }
 
 /**
- * location_to_obj - get obj value encoded from (<page>, <obj_idx>)
- * @page: page object resides in zspage
+ * location_to_obj - get obj value encoded from (<zpdesc>, <obj_idx>)
+ * @zpdesc: zpdesc object resides in zspage
  * @obj_idx: object index
  */
-static unsigned long location_to_obj(struct page *page, unsigned int obj_idx)
+static unsigned long location_to_obj(struct zpdesc *zpdesc, unsigned int obj_idx)
 {
 	unsigned long obj;
 
-	obj = page_to_pfn(page) << OBJ_INDEX_BITS;
+	obj = zpdesc_pfn(zpdesc) << OBJ_INDEX_BITS;
 	obj |= obj_idx & OBJ_INDEX_MASK;
 
 	return obj;
@@ -1395,7 +1395,7 @@ static unsigned long obj_malloc(struct zs_pool *pool,
 	kunmap_atomic(vaddr);
 	mod_zspage_inuse(zspage, 1);
 
-	obj = location_to_obj(zpdesc_page(m_zpdesc), obj);
+	obj = location_to_obj(m_zpdesc, obj);
 
 	return obj;
 }
@@ -1884,8 +1884,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 
 			old_obj = handle_to_obj(handle);
 			obj_to_location(old_obj, &dummy, &obj_idx);
-			new_obj = (unsigned long)location_to_obj(zpdesc_page(newzpdesc),
-								obj_idx);
+			new_obj = (unsigned long)location_to_obj(newzpdesc, obj_idx);
 			record_obj(handle, new_obj);
 		}
 	}
-- 
2.43.0


