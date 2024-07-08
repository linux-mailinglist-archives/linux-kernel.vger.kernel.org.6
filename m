Return-Path: <linux-kernel+bounces-243901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C671A929C3A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 702AA1F21B97
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA4E125DE;
	Mon,  8 Jul 2024 06:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVk5iNSo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D11A6E2AE
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 06:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720420170; cv=none; b=Hn7CcRKo1L+uwjXuKM5sRn3LEC3BjY4kV7gfZLvlQTmh2HD7Evqi1fiN5uYhotD4/h9gwFVOhGPL0Wa2vfkGJk6ZZrItg4i0ZaeqyP5no//UdIuqNtm0pPhNVD0ZR4rmhnlcplDSxGiayonNuoFgKcB9KFhJuOy4HS+FHMYPic4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720420170; c=relaxed/simple;
	bh=FoPFFhZjgJ7k8SPuHkOnh4ZOuMsrgriGi5An3x0tRys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lS9PdtJVyKm2VDScARwAGuZm0hTm3h8BKDJ3SPDCmhKF5u0W4kMBkPHEeBTSDd4WoymvJC9WdyT+YUccEa7toqdskBMOg3E4YGEjfxBWlhZO9LnzSRnoay0wHiyrli8Y1OWZ0BAUYWRZf4XKL3TNuAaverbqaQ2efAGm/i0jSx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVk5iNSo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C84C116B1;
	Mon,  8 Jul 2024 06:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720420170;
	bh=FoPFFhZjgJ7k8SPuHkOnh4ZOuMsrgriGi5An3x0tRys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SVk5iNSoWEypU6s06xUAyZFEaiQ1Lg9SaOx3SHhS8HIM3gOa6jnzHjXuVpb7C+u+G
	 CUS6gTMu1aJOHfYMh1aiodRaOueC1INYKRIwcbJuEHMDRzbhoYUUdn+dw/UhRWFQPb
	 YOqyBMdjtfNuVZCvBM094GknA+ub5pPohmKxG+mvZ+Nm6SKp7IV/SH+zPDLRreMD2G
	 sucCviNkh1ywa/cuflg9Ocj6Jy66eePgmkIiHVrIOVmO5I4t6DiBpMje8pB+6w7hz4
	 FOMaRLVBR7AfGWwpT4+oLOQkdenToTM2w5UgRWJw1jw7MRLjGW75nLcW44/UPvFNgM
	 KHaM1Hk6JxHRw==
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
Subject: [PATCH v3 13/20] mm/zsmalloc: convert location_to_obj() to take zpdesc
Date: Mon,  8 Jul 2024 14:33:34 +0800
Message-ID: <20240708063344.1096626-14-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240708063344.1096626-1-alexs@kernel.org>
References: <20240708063344.1096626-1-alexs@kernel.org>
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
Signed-off-by: Alex Shi (Tencent) <alexs@kernel.org>
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


