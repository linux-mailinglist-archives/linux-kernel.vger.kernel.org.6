Return-Path: <linux-kernel+bounces-275590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71715948773
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3FDA286F0A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3324539FF3;
	Tue,  6 Aug 2024 02:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRmUrjTQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FC3381B9
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 02:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722910723; cv=none; b=MAXVOUgpHNlCz5G8JcsBRCED/2tasTC27GRcRzLFEWbo/wa0wVQfD4jP757YbSNSJ8ZgdmPbLi3mfi+/fofbNBgFyRg3UoL+IW4IesqnB11/R0l38OKNQZw1x+OnEBoOGtvm4zdT/rDUZncyrfIV0j3+Fbc7Smi1ChC/sVGb2YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722910723; c=relaxed/simple;
	bh=7R27PI6t8PPGIzjMbda+XNUteaxs5t0PfeOafdtKA9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hh0BngyBfqLb7BdTvsmYPTptZHKv2dUztuNsKqgtq9RYaiarELWEdZNx+YIVxbXgRzKm+8NSEA6VCh8uS6KLAHto9SwkaDaUHZx1jRf4CsSEf8cOQRx0H19CaiTHsFSC5hkCH2UpL9+B1cYoy37V8wnYuiBRgw824hGy254XuRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRmUrjTQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CA4C4AF0B;
	Tue,  6 Aug 2024 02:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722910723;
	bh=7R27PI6t8PPGIzjMbda+XNUteaxs5t0PfeOafdtKA9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CRmUrjTQbKnuPQmOwufiAx4cYw8y+lYQTG38+7FslMxb3MSpH7GyZODkN1/ZB59fB
	 s8imNPAIKMRXmNKRZK0mUiaLhD+0PgbBtXwT168RS2gd2u58Rg3m104ej3wIe/snzs
	 NjG9ikTjq5ki9Gnay0a4shcsPz1sNZb4rTFy/MQsccnSfB32pVwCaqCPwnUL4La9DS
	 TWtv6u+zy+LKEbXrV6o32O46jbrvR2Vg73CGnzTQFa+/sr9+klLHfr9ul2ZUl55YGl
	 dcLUtMdq/ti4ucNX5c9ViRpDob04PaaSR2Fjff3vT5pmKjMGlolcDuytY0hd9wT7Fe
	 85JxlEARg1HcQ==
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
Subject: [PATCH v5 13/21] mm/zsmalloc: convert location_to_obj() to take zpdesc
Date: Tue,  6 Aug 2024 10:23:00 +0800
Message-ID: <20240806022311.3924442-14-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240806022311.3924442-1-alexs@kernel.org>
References: <20240806022143.3924396-1-alexs@kernel.org>
 <20240806022311.3924442-1-alexs@kernel.org>
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
index 4b948b84e7f3..e6d1bd8969e5 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -806,15 +806,15 @@ static void obj_to_zpdesc(unsigned long obj, struct zpdesc **zpdesc)
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
@@ -1372,7 +1372,7 @@ static unsigned long obj_malloc(struct zs_pool *pool,
 	kunmap_atomic(vaddr);
 	mod_zspage_inuse(zspage, 1);
 
-	obj = location_to_obj(zpdesc_page(m_zpdesc), obj);
+	obj = location_to_obj(m_zpdesc, obj);
 	record_obj(handle, obj);
 
 	return obj;
@@ -1859,8 +1859,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 
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


