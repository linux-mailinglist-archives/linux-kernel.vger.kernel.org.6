Return-Path: <linux-kernel+bounces-265632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC6493F3E6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECB961C21B18
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4656A149DEA;
	Mon, 29 Jul 2024 11:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="soKprBYq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E09814659C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 11:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722252060; cv=none; b=Cr87Ow7Vq35prP9FiCo8ER6eBMVFWmp1escTKBdjD5zQGCKLBYhMlniKRh/HJZcHm/A8tAhMYEMEVET45vU+P1XZJ/OfMLVaqWiSJZfDo/bTueBkiaUzFB9hERm1Pxe/4y4Mapy0xlAEEIzy37sWd2mIy3sTxHw/i9rqd3GoBlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722252060; c=relaxed/simple;
	bh=wTDI0eYHYt7QQuqfYVSh3nHEsVuSO77v1MHzFFaeoFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=utmWBfS23nBMQyNJ2+Q57eZnWMEtcTSOZxR/d4M20x0SSonPWtS8Dih6GFnNht0aOqKaHQROYX0oJQT1e/983iBw+2U/Y1Ll2uwi/f5gPAHaQ/4+GUL+wwHE+aKpr10kqShHqJKVazbNhgsdrn3BjDulsbQ0P2zUOeVVnL/fL44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=soKprBYq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64837C4AF07;
	Mon, 29 Jul 2024 11:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722252060;
	bh=wTDI0eYHYt7QQuqfYVSh3nHEsVuSO77v1MHzFFaeoFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=soKprBYqWURfg25sfItqMlUmjCEOrgiYtNAVU0eDQr68G1KVfp/73qZOeW7TOTupC
	 a4MzcCvbu8bHoU4pupUZtFb30ceJnWgg7D5Dgq74Dc8Lu42X2pxdIrA1XU8XJoRuTr
	 XKCxYMaMOprZnX8ZS/+ih6s8whodTe32MyaDzTAgQr/CuJ/erKwRgmD2ZTw0b73hGS
	 1rQiKJMZNSv8vii8ZRFqvcMR1hnxy9BF4gx+gEwTHVcXLWhB4Fap9uUH9Om8FWwo13
	 O6qln7YSujzOPOMEVbMY6RhnaWzjgGqu53rtHRuM8XNeT3KFntHVNBXeVkhf4nO+Ob
	 8tHZuDQsRuUMQ==
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
Subject: [PATCH v4 13/22] mm/zsmalloc: convert location_to_obj() to take zpdesc
Date: Mon, 29 Jul 2024 19:25:25 +0800
Message-ID: <20240729112534.3416707-14-alexs@kernel.org>
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


