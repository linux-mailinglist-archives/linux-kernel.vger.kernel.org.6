Return-Path: <linux-kernel+bounces-284354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06871950027
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B39E92876C1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE0F170A0E;
	Tue, 13 Aug 2024 08:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyU1F0CU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A0216DEBD
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723538517; cv=none; b=E2GZ+VJifIiOhVQolue4UVifON8lxo5CWLfRVENltHyW/EEQQqFKG9smQjgIY+oCuso2ufgDOGfawuNCt8tOu7fgjJ0VtYD52JH2x+DvRoDM956sKeEHwPjWYT3GkN+PRBRkWoroawIGv0nkmYdQ1Dqh6iDl16FTCUHRn59qVzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723538517; c=relaxed/simple;
	bh=P2h4TL0al2Tdq16vEvHZlxJuPRha9tB1mdH4uW7GsvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kfx0+WR6Hgx5CBEZPVNPj6a6i2jl+QvR+G80wskUlYnjotZ0Va2Fn+0/hPWPQWELKUrrYabrstm09IBZWQw14PhRa5JPXhnD1RcvicPnSln1qLnX/OAKuL42WoJyaKGmxk4eTOCgH4DWNrUAdomCdD8PcRICYuc+0YrO1bbl+Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyU1F0CU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 094C4C4AF09;
	Tue, 13 Aug 2024 08:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723538517;
	bh=P2h4TL0al2Tdq16vEvHZlxJuPRha9tB1mdH4uW7GsvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SyU1F0CUC5fJJ+b0xwqG/Ht51CluyUnYwwigzprVYJCkZsEq4VEoBHyVwwQ2VHi+8
	 3QoMrvaINRWhJ/usOIFbXtV2ZefP60g2/PcvhoM6VIgi9e9J5p0EcYK7sudn+/ET3Z
	 BiXsmhroLMiO0q5npsqO+h9hJRPRkv/trQP27fIIiGhqhZJt+2OdqFtovOSWnue1zN
	 yc4GNEfoV6BOTJicX27tXNKpte65+7eeh9T6ZKi1C+gw/Wt9/mMOG5Qx6CYVTu3ouo
	 1qWLwB/0gyxRxR3udXWKOGCr8+5kajpmf1mzvCscAOe45l1aezR3oeHw+vkUDjAd7d
	 Vb9d+lE8wwL/Q==
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
Subject: [PATCH v6 13/21] mm/zsmalloc: convert location_to_obj() to take zpdesc
Date: Tue, 13 Aug 2024 16:45:59 +0800
Message-ID: <20240813084611.4122571-14-alexs@kernel.org>
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

As all users of location_to_obj() now use zpdesc, convert
location_to_obj() to take zpdesc.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zsmalloc.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 7b3344c226a0..9218f1e6e8ef 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -820,15 +820,15 @@ static void obj_to_zpdesc(unsigned long obj, struct zpdesc **zpdesc)
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
@@ -1386,7 +1386,7 @@ static unsigned long obj_malloc(struct zs_pool *pool,
 	kunmap_atomic(vaddr);
 	mod_zspage_inuse(zspage, 1);
 
-	obj = location_to_obj(zpdesc_page(m_zpdesc), obj);
+	obj = location_to_obj(m_zpdesc, obj);
 	record_obj(handle, obj);
 
 	return obj;
@@ -1873,8 +1873,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 
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


