Return-Path: <linux-kernel+bounces-567524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F83A68759
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A77F17B93B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A034721148F;
	Wed, 19 Mar 2025 09:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DBbq1CTr"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376282AEE2
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742374829; cv=none; b=dFLvN+HDX51/j7uAHY9uFxB6eZjK/5I75ia+IHCG4FXyrdp/MfkOMSYMcgl8CWz5vY311t5Xc8DDBR5O/zX3Sd/yVhAhQsUcFMFWfVD0fwyKFvYamdw4bsTvkyLdRVB10MWCVjPvhCWzZvhqTk5J/iKsEnmqNLfs3gJZUjedaD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742374829; c=relaxed/simple;
	bh=o/DwjLwBeyHWppk/kzjejchkvG5Z6FbweZaFSqjUV4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lgk6+RjZZWA2LL+zuswHXhXnFF2AaPeXp+axXXySBL4qTw96EBUnPLxso07wDe5PIsFJHjYxq6vh32Wlb08mTG/9lPqTnD51fxQU70A0nujGegjdiCD8VSRRMgLEpc8pkwKeuMGVrbu3Wf1U9tQJWJmm/4crNRXH/e0n87WY2tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DBbq1CTr; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=rbiMc
	zqE1kEPPcuWwzMJFBRrEV3cexuWl26w1yN+L6s=; b=DBbq1CTraB6nqy/yyNcdL
	uW9XxW710fOqa4XccJETWWfi5bnPM7s1MWw2YTyNt2pDUyF8QIF0tfzGr0w4OPA7
	87nY7jj8/yq7UWJXZ8DCfIBQml3oRrANm/lQLMClF5b6JRAQ4WR+mbWrXfUsD2B7
	OeRIgVJ8FnYW2YTbVVdmYo=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDX7taVh9pnVNm+AQ--.29185S2;
	Wed, 19 Mar 2025 17:00:05 +0800 (CST)
From: Liu Ye <liuyerd@163.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Liu Ye <liuye@kylinos.cn>
Subject: [PATCH v2] mm/page_alloc: Remove unnecessary __maybe_unused in order_to_pindex()
Date: Wed, 19 Mar 2025 17:00:03 +0800
Message-Id: <20250319090003.392988-1-liuyerd@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX7taVh9pnVNm+AQ--.29185S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrWrtF4UCrWkAw4fCrWUtwb_yoWfKwb_u3
	Wakrs29r9xur95KwsrCanIgw4ft3WkCrn7KFn3Wr13ta42qFW2vw48A3y3Arn8WrWI9FW5
	Wan0qFW7Gw1agjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnqXdUUUUUU==
X-CM-SenderInfo: 5olx5vlug6il2tof0z/1tbiEAIVTGfagzNuhgAAsu

From: Liu Ye <liuye@kylinos.cn>

From : Liu Ye <liuye@kylinos.cn>

The `movable` variable is always used when `CONFIG_TRANSPARENT_HUGEPAGE`
is enabled, so the `__maybe_unused` attribute is not necessary.
This patch removes it and keeps the variable declaration within the
`#ifdef` block for better clarity.

Signed-off-by: Liu Ye<liuye@kylinos.cn>

---
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


