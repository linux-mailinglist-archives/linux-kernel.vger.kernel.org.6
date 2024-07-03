Return-Path: <linux-kernel+bounces-238819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 212DA9250EC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 06:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2AC5282249
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 04:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9563016727B;
	Wed,  3 Jul 2024 04:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVOc+ikQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9502E646
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 04:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719979318; cv=none; b=ILzx2qdtly49r6l3qBvzIZs+A/5SYGsi5hNuTbYZZ4vt3m3kaeMOuqJ2mjbonAnWImBazaG01J0qyAHp7HxAbCilwamGuHAYTypZOkHJ1I00MkXAklwXfcgnHNUvYfJkPh1Jm2XCKIXFdpgrOMscVklVcN/3Bm8i58NW83/C4C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719979318; c=relaxed/simple;
	bh=wTDI0eYHYt7QQuqfYVSh3nHEsVuSO77v1MHzFFaeoFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tVrdTCwTzRoPifPLxCASEdXsscI+YU5m9bPfzzakdh6ZX72Al8MmYDul2znpfv87Ham/l2NhygiS7R1IK33eFFQqKPcSAPzNKFhtWKcB7oHXYC8l3D/y3FOgCVvKBp40BXIQqOedOIDslbxGG0SvXnHCVmQ20nC0Kiyqf11Ck/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVOc+ikQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B10C32781;
	Wed,  3 Jul 2024 04:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719979318;
	bh=wTDI0eYHYt7QQuqfYVSh3nHEsVuSO77v1MHzFFaeoFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gVOc+ikQ0e4uEf4lRf4VFTkicUepq4dYTbwtWmScFz/shEGC3tPJ2Tv3kp+jVx39J
	 02cNh0BzDrMvoMSkuZTHsBlPZovMNzYKU9VGCsNc17yGimfEVfQQ3CNb5lzuXAIK+c
	 vLBE7IJcOkdN1BRsM4pIX8l88EuGTlaSwpUqFmKj6l44HiFqFjGNl68SmrkQ6JlwlG
	 YEv7zNYxkcmEBnWJ62sBfJcYrEnUJwxuyTJf2Kb6E3+qL3UZzdAq666Nr3NlRFnIgS
	 P+qbUaMur7AJrvXSuEPhRwv5psWkuwXQGkQc7n1tj5nhvojIeOMofVoEn+JGscY7nv
	 qedKqn8ZvIBgg==
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
Subject: [PATCH v2 13/20] mm/zsmalloc: convert location_to_obj() to take zpdesc
Date: Wed,  3 Jul 2024 12:06:03 +0800
Message-ID: <20240703040613.681396-14-alexs@kernel.org>
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

As all users of location_to_obj() now use zpdesc, convert
location_to_obj() to take zpdesc.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zsmalloc.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 68fdea7b6e0d..e291c7319485 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -826,15 +826,15 @@ static void obj_to_zpdesc(unsigned long obj, struct zpdesc **zpdesc)
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
@@ -1392,7 +1392,7 @@ static unsigned long obj_malloc(struct zs_pool *pool,
 	kunmap_atomic(vaddr);
 	mod_zspage_inuse(zspage, 1);
 
-	obj = location_to_obj(zpdesc_page(m_zpdesc), obj);
+	obj = location_to_obj(m_zpdesc, obj);
 	record_obj(handle, obj);
 
 	return obj;
@@ -1879,8 +1879,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 
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


