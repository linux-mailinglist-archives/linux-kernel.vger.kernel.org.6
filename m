Return-Path: <linux-kernel+bounces-567538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86492A6877C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3CE57A4A27
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3E8251793;
	Wed, 19 Mar 2025 09:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SC+1TGEy"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B2825178D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742375260; cv=none; b=sAfRAlU7HnSljswWNMIE5xCRkk4BGclZjtGG454NXTJfoZHURVcyhA1cs2j0Xw8TJltHwVnrpx8h0uSER8kfrh35xVp1tCbFUbT+j5uVfsOdIHgYDo8fA2J8bGwEi3bqP9/1aarWE17ad0tF5DzXPgUJj4HE7fSyp1wQJSAKrFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742375260; c=relaxed/simple;
	bh=5URbDiaZl8biD7TDajd8O40GLV+pSBfz7MbkvzF/5IE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KB/gmdvLISjCC0eqkNd4PzQUzn8dxI+6lRQlxCUNA/GFJaRws91eSOFW3qIdVRuT12RDthvEITq7gkWLrEVtt6DTEs4KJgdgrUlXCp5miyPStbBBGRCKjB0gCYndPWyT+shj87Ho32iS2ACAYQYKs02YmZrcoYCeivpJcHAvUlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SC+1TGEy; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=lNjTe
	3Zo3VdidNMJkiMzeRJy9FgxAcYxL6SbtvlWNN8=; b=SC+1TGEy+ZsJa9Nsa802R
	1u7s7r7BDDIPDBYw3JAFg1/ptIeetfaBeeFtYynD18Jubh/7c/aTnF6ffvyQl1i4
	NbafDpLUuVLB0pqHKVx2Sd3z/eZU6MOsnL+3h6lA1wfMIA5b4bkFB/KSw80RZpJX
	gQ4/xMUHq0Y9hZkXzLBzfE=
Received: from localhost.localdomain (unknown [223.70.253.31])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAXYaZGidpnJGiERg--.39703S2;
	Wed, 19 Mar 2025 17:07:19 +0800 (CST)
From: Liu Ye <liuyerd@163.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Liu Ye <liuye@kylinos.cn>
Subject: [PATCH v3] mm/page_alloc: Remove unnecessary __maybe_unused in order_to_pindex()
Date: Wed, 19 Mar 2025 17:06:58 +0800
Message-Id: <20250319090658.394633-1-liuyerd@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgAXYaZGidpnJGiERg--.39703S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrWrtF4UCrWkAw4fCrWUtwb_yoWDGrg_u3
	WUKrs29r98urn5GwsrCanIgw4ft3WkCrn7GFn3Wr13ta42qFW2vw48A3y3AFn8WrW29FWr
	Wa1qqFW7Gw1agjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnqQ6JUUUUU==
X-CM-SenderInfo: 5olx5vlug6il2tof0z/1tbiEAIVTGfagzNuhgABsv

From: Liu Ye <liuye@kylinos.cn>

From: Liu Ye <liuye@kylinos.cn>

The `movable` variable is always used when `CONFIG_TRANSPARENT_HUGEPAGE`
is enabled, so the `__maybe_unused` attribute is not necessary.
This patch removes it and keeps the variable declaration within the
`#ifdef` block for better clarity.

Signed-off-by: Liu Ye<liuye@kylinos.cn>

---
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


