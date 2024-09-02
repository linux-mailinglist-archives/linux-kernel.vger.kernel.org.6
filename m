Return-Path: <linux-kernel+bounces-310713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B3A96805A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB8F8B22C5E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7968187561;
	Mon,  2 Sep 2024 07:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPeK2NyV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3697B187552
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 07:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725261438; cv=none; b=CK9xjgsFN9/7pCJnZeL6dl3iDJciptBn5kUqvNo2/CcuBAco4UIq8tam0fzqrpwiBeOGzBxiKHSeiBS02sr0FyvBRnQYEcMKjbizSDhqjvjSmHI807TI1lOHHttfeuPMJ/2yluKToseDioaAF8GrR5rOqtAEuObB8Gf5s2ziDgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725261438; c=relaxed/simple;
	bh=XMY5jg562sPF99BloXKZJR4HKiDGqicXgdq+2ws9Iy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQD+xxmUDoXuxuQANOMP+27YcQff8VP3a32Vw2hmEjsbTnLPTMs1JHd6OHKXEdnr8VF5vE2PG4H+/Hl3rUIrUxBe2o44/jMWnJTT3z9rosl6i3oYsExRMSl2FtKjy3fmVY1rY6HEnniVAl/Ee/UXSBpD1Ml8J0YLjGkgzXnOudk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPeK2NyV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B362C4CEC4;
	Mon,  2 Sep 2024 07:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725261438;
	bh=XMY5jg562sPF99BloXKZJR4HKiDGqicXgdq+2ws9Iy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NPeK2NyVAp/tWckPu9912WQybh4F4gsYJTs+6ho+SST7R9QNtr+Wb0XlHgJI0twbc
	 3bINCAfA5kKpMF2Q7PrN+D2xXHoHSQd9M2nsfbhEmvC/kMGUJtZQ40YI+NCbthEAvB
	 0XPZVe6lyFovwfqWR2rNwDjMaRrcBQisjgCtJWR3reZwYuJFQnCsYbgAbxvefF059f
	 UZ/3lSpf7g0T4mVBjpcJUPdNbwoy2hnea6sYvK8VwRlZ8WNWuyv4oGjYdw/iHVS6Z9
	 2kAImmM3/NlKqL3WG288/KRhAfKLnwJPAbm9U7O9TIdjYTmFD4EvUA93+Y3WuOibN1
	 KTCCtWBhvfP2w==
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
Subject: [PATCH v7 13/21] mm/zsmalloc: convert location_to_obj() to take zpdesc
Date: Mon,  2 Sep 2024 15:21:24 +0800
Message-ID: <20240902072136.578720-14-alexs@kernel.org>
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

As all users of location_to_obj() now use zpdesc, convert
location_to_obj() to take zpdesc.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zsmalloc.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 5a8fd5fbc962..f94c3a6653c7 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -814,15 +814,15 @@ static void obj_to_zpdesc(unsigned long obj, struct zpdesc **zpdesc)
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
@@ -1379,7 +1379,7 @@ static unsigned long obj_malloc(struct zs_pool *pool,
 	kunmap_atomic(vaddr);
 	mod_zspage_inuse(zspage, 1);
 
-	obj = location_to_obj(zpdesc_page(m_zpdesc), obj);
+	obj = location_to_obj(m_zpdesc, obj);
 	record_obj(handle, obj);
 
 	return obj;
@@ -1866,8 +1866,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 
 			old_obj = handle_to_obj(handle);
 			obj_to_location(old_obj, &dummy, &obj_idx);
-			new_obj = (unsigned long)location_to_obj(zpdesc_page(newzpdesc),
-								obj_idx);
+			new_obj = (unsigned long)location_to_obj(newzpdesc, obj_idx);
 			record_obj(handle, new_obj);
 		}
 	}
-- 
2.46.0


