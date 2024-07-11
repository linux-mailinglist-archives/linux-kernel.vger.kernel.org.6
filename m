Return-Path: <linux-kernel+bounces-249254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C4192E8DB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3446A1F216DA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68FF15ECDB;
	Thu, 11 Jul 2024 13:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G3LHeXQ5"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E5415EFA5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720703054; cv=none; b=LmKB4GIcFlbOKVesDyDgyA2j5GG51tq6X+kLKERIagaa58QTl6PNlySYXBsj5rSGDbtEJJK52QJinCGF050/KslhVYUAjDDsk0ZaK3Ev38ldaPvwXeMlCECvc/EKwWaB2gxvEQvfB4YO6ToftJcXxBd3yeFUeAiPOCP9zU4WSfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720703054; c=relaxed/simple;
	bh=2gmPdT0S1DZkXUT65dIsk8pvo2LbGTl5e1ca5nTJcBY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pcFpNl3GWJ1/Tn2dg4+FjEujoPTjw1o6ocKSqMGdU2x+dbrWKyCTA3ZkXkZKeY0xPSCjxpOoEdk/qSaBttIQiu5S+Pgql0YmOsFDcuXZjQbn2bcwsP+OITiMMgXZYrXNupdp0Si0nD3qzC6ZsftWHqsAz1P0mKHse0+nwKPZRug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G3LHeXQ5; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720703049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3MGObJu/3MJ/LX6Yb+8U9JI9LiQ7r/lgAYHryvrfHwM=;
	b=G3LHeXQ5DuvAxMOvJatjKgUWr1oiY5szAUrS63hOj0QnROLQ4zmNh92aEbDDZuOQIJSM45
	eu8xNSSs0cudNPOnMtMW5vy0ToGk7XE523IcdR6Dex2v2Xki52iVFnybitIvvN6CxILRr1
	VtrXAnhmWwNBHq9mlzbpXAuNr5ip8yc=
X-Envelope-To: willy@infradead.org
X-Envelope-To: david@redhat.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: yajun.deng@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yajun Deng <yajun.deng@linux.dev>
To: akpm@linux-foundation.org,
	willy@infradead.org,
	david@redhat.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] mm: unified folio_test_anon()/folio_anon_vma() and use them
Date: Thu, 11 Jul 2024 21:03:51 +0800
Message-Id: <20240711130351.2830-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In folio_get_anon_vma() and folio_lock_anon_vma_read(), we get anon_vma
from folio, but the code isn't clean enough. Instead, folio_test_anon()
and folio_anon_vma() can do this.

They have the same functionality, but their implementations are not
identical.

Unify folio_test_anon() and folio_anon_vma(), and use them.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 include/linux/page-flags.h |  3 ++-
 mm/rmap.c                  | 20 +++++++++-----------
 mm/util.c                  |  6 +++---
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 5769fe6e4950..6e2197b22f5f 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -691,7 +691,8 @@ static __always_inline bool PageMappingFlags(const struct page *page)
 
 static __always_inline bool folio_test_anon(const struct folio *folio)
 {
-	return ((unsigned long)folio->mapping & PAGE_MAPPING_ANON) != 0;
+	return ((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS) ==
+		PAGE_MAPPING_ANON;
 }
 
 static __always_inline bool PageAnon(const struct page *page)
diff --git a/mm/rmap.c b/mm/rmap.c
index 86787df6e212..3f5d9879591c 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -499,16 +499,14 @@ void __init anon_vma_init(void)
 struct anon_vma *folio_get_anon_vma(struct folio *folio)
 {
 	struct anon_vma *anon_vma = NULL;
-	unsigned long anon_mapping;
 
 	rcu_read_lock();
-	anon_mapping = (unsigned long)READ_ONCE(folio->mapping);
-	if ((anon_mapping & PAGE_MAPPING_FLAGS) != PAGE_MAPPING_ANON)
+	anon_vma = folio_anon_vma(folio);
+	if (!anon_vma)
 		goto out;
 	if (!folio_mapped(folio))
 		goto out;
 
-	anon_vma = (struct anon_vma *) (anon_mapping - PAGE_MAPPING_ANON);
 	if (!atomic_inc_not_zero(&anon_vma->refcount)) {
 		anon_vma = NULL;
 		goto out;
@@ -550,12 +548,12 @@ struct anon_vma *folio_lock_anon_vma_read(struct folio *folio,
 retry:
 	rcu_read_lock();
 	anon_mapping = (unsigned long)READ_ONCE(folio->mapping);
-	if ((anon_mapping & PAGE_MAPPING_FLAGS) != PAGE_MAPPING_ANON)
+	anon_vma = folio_anon_vma(folio);
+	if (!anon_vma)
 		goto out;
 	if (!folio_mapped(folio))
 		goto out;
 
-	anon_vma = (struct anon_vma *) (anon_mapping - PAGE_MAPPING_ANON);
 	root_anon_vma = READ_ONCE(anon_vma->root);
 	if (down_read_trylock(&root_anon_vma->rwsem)) {
 		/*
@@ -774,16 +772,16 @@ static bool should_defer_flush(struct mm_struct *mm, enum ttu_flags flags)
 unsigned long page_address_in_vma(struct page *page, struct vm_area_struct *vma)
 {
 	struct folio *folio = page_folio(page);
+	struct anon_vma *anon_vma;
 	pgoff_t pgoff;
 
-	if (folio_test_anon(folio)) {
-		struct anon_vma *page__anon_vma = folio_anon_vma(folio);
+	anon_vma = folio_anon_vma(folio);
+	if (anon_vma) {
 		/*
 		 * Note: swapoff's unuse_vma() is more efficient with this
 		 * check, and needs it to match anon_vma when KSM is active.
 		 */
-		if (!vma->anon_vma || !page__anon_vma ||
-		    vma->anon_vma->root != page__anon_vma->root)
+		if (!vma->anon_vma || vma->anon_vma->root != anon_vma->root)
 			return -EFAULT;
 	} else if (!vma->vm_file) {
 		return -EFAULT;
@@ -791,7 +789,7 @@ unsigned long page_address_in_vma(struct page *page, struct vm_area_struct *vma)
 		return -EFAULT;
 	}
 
-	/* The !page__anon_vma above handles KSM folios */
+	/* The !anon_vma above handles KSM folios */
 	pgoff = folio->index + folio_page_idx(folio, page);
 	return vma_address(vma, pgoff, 1);
 }
diff --git a/mm/util.c b/mm/util.c
index bc488f0121a7..668dab9e27e6 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -782,11 +782,11 @@ EXPORT_SYMBOL(vcalloc_noprof);
 
 struct anon_vma *folio_anon_vma(struct folio *folio)
 {
-	unsigned long mapping = (unsigned long)folio->mapping;
+	unsigned long mapping = (unsigned long)READ_ONCE(folio->mapping);
 
-	if ((mapping & PAGE_MAPPING_FLAGS) != PAGE_MAPPING_ANON)
+	if (!folio_test_anon(folio))
 		return NULL;
-	return (void *)(mapping - PAGE_MAPPING_ANON);
+	return (struct anon_vma *)(mapping - PAGE_MAPPING_ANON);
 }
 
 /**
-- 
2.25.1


