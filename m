Return-Path: <linux-kernel+bounces-368177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 453D59A0C4A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7AF5B2657F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8FE20C003;
	Wed, 16 Oct 2024 14:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pPfyjyTc"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824E21DAC9C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 14:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729087915; cv=none; b=u0Bnwy5TyldsaLObg6ZAOMhxtR/la1wxk614Uf3jdr5IHii1lICEt579asFzRXvnt3zdyr9g0s1TIL81ybQWeXNMVCwZNFb8ZVwa8vgTIPznlgQgMpbzyEdwtSjuK39zfpkyXpWaB+8Jz0nkB5DtzQnT01zIniVsXkwKkOisZqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729087915; c=relaxed/simple;
	bh=e68wPyCG2Wg1G446tI30CNWRZh8zq490LxSJEsX5F1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=biVsgeOiMp0NJkFV73fULUoKh70TUEkNuqrHaQsJqxWmCqZcK4PQ475WdZ14kDWDQDR5vBEkIPSeSZqN3euKp7OHSo74wKrFOfkg5utBNaEsdn9n6KLRCko57BAP5ZxX2UUYPgS2ZnoxuocvVGFHVK7+xzJK4oxJY1DinoxZWzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pPfyjyTc; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729087910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ISSouLUnXFGN9ZwaMkrAb5KWVY6BF4Uow2vNhpvRt3E=;
	b=pPfyjyTc5XObNE2yNXJIaGwKRfDXyEgZJRoxZ4Wrgi7yZKsJhQpRSo/k9GTKMo2BCiqYDJ
	CmYW8N6ow6bEdmb0P+MW3tCQbSD3B4j5jbEEuMOn1kAIqFep4Ipy6QsazABEB6DGccjP1P
	P5PuXFbrV53dmqB5lLkjqY20Z7B3jkM=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: swap: Use str_true_false() helper function
Date: Wed, 16 Oct 2024 16:10:41 +0200
Message-ID: <20241016141040.79168-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the helper function str_true_false().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 mm/swap_state.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 4669f29cf555..e0c0321b8ff7 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -889,8 +889,7 @@ struct folio *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
 static ssize_t vma_ra_enabled_show(struct kobject *kobj,
 				     struct kobj_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "%s\n",
-			  enable_vma_readahead ? "true" : "false");
+	return sysfs_emit(buf, "%s\n", str_true_false(enable_vma_readahead));
 }
 static ssize_t vma_ra_enabled_store(struct kobject *kobj,
 				      struct kobj_attribute *attr,
-- 
2.47.0


