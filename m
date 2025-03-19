Return-Path: <linux-kernel+bounces-567562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BBCA687C5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13CAF18856F8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB91253335;
	Wed, 19 Mar 2025 09:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lYjvunTK"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661E9253339
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742375888; cv=none; b=bHvhSizVoUy4vEkN8fVqnNy6vBwnxZUDRG7c7x+/M88gQp4Wixwn2gGYI9RzugnKeJu+KgGxon1gijGCaHxVxMG+uxv5qizU08aUCsEbNrPnsyzYaZQxy1+HU4aFIzz1kaOOz/if6iAMPjbfpoKCcgR5N5D68/2DDjd9sAeEMxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742375888; c=relaxed/simple;
	bh=RDv1KyICqiDC1YJ+evku/seJfnaIAeC4xN8jw2DGw20=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cAG8U4M1IUtv/PuiJKWe7hIJAoqaEVHPs1V+IfA9oK3eGGSE7tEpXij8k31mwdzc758vQ/AqZm6RBueilmegeWOA4Df1BYxTjQCOcV9S4XZfVzqXEeKSGM+Fw2uTN8tSBd+sCL5AJWtvvL2Gpz78F9H6ey4Bn0ubaSaRn2fOBqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lYjvunTK; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=2A3RE
	e9nsA+ldu9d0e7nqZBVkqdCOqvQeQRE+0UzZgQ=; b=lYjvunTKIdh1uTICYuWr2
	3VVpIDdq0p4UaTZpWpQ25kKPK7rnr0PWhfhXP/FEtsWhxper8iviMwctlmvYyoB0
	OhlF6SovMu+xfzCzNiNVyHHYBx9BOeeQeB8Uhs6xWV+JgvZ/i/LZOuf1HBwzcsJF
	fdLbxzQGZJ4yVQXJYFM1rQ=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDnV+u6i9pn__i+AQ--.57877S2;
	Wed, 19 Mar 2025 17:17:47 +0800 (CST)
From: Liu Ye <liuyerd@163.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Liu Ye <liuye@kylinos.cn>
Subject: [PATCH v4] mm/page_alloc: Remove unnecessary __maybe_unused in order_to_pindex()
Date: Wed, 19 Mar 2025 17:17:26 +0800
Message-Id: <20250319091726.401158-1-liuyerd@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnV+u6i9pn__i+AQ--.57877S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jry7JrykGr1rAr48AFW8WFg_yoWfKwb_u3
	Wjkrs293s5urn5KwsFkanagw4ft3WkCrn7WFn3Wr1aya42qFW2vw48A3y3AFs8W3y29F4f
	WayqqFW7Gw1agjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnD8n7UUUUU==
X-CM-SenderInfo: 5olx5vlug6il2tof0z/1tbiEAIVTGfagzNuhgAGso

From: Liu Ye <liuye@kylinos.cn>

The `movable` variable is always used when `CONFIG_TRANSPARENT_HUGEPAGE`
is enabled, so the `__maybe_unused` attribute is not necessary.
This patch removes it and keeps the variable declaration within the
`#ifdef` block for better clarity.

Signed-off-by: Liu Ye<liuye@kylinos.cn>

---
V4: Update from.
V3: Update from.
V2: Update from and Signed-off-by.
---
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 542d25f77be8..fe76fd237dd0 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -508,9 +508,9 @@ static void bad_page(struct page *page, const char *reason)
 
 static inline unsigned int order_to_pindex(int migratetype, int order)
 {
-	bool __maybe_unused movable;
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	bool movable;
 	if (order > PAGE_ALLOC_COSTLY_ORDER) {
 		VM_BUG_ON(order != HPAGE_PMD_ORDER);
 
-- 
2.25.1


