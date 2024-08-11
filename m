Return-Path: <linux-kernel+bounces-282397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE27F94E351
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 23:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F32501C21073
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 21:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB04165EE0;
	Sun, 11 Aug 2024 21:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b+zQpiSd"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DE515FCE7
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 21:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723411300; cv=none; b=REmV3JL3LEyBZ074SD0MtoAG/o8eJC5g1iiqhs5qEET2Ydb8CbGPcyfKx6F2zZU2LjjLUxLgmkMeNK4HBqeRfRex13cpbq9raClyiET6X4s2siufWF59J+MDi8IAfnXpvhtJ8E+6h8NmhoWHMeHOyiCReOUepYqMSSls1jLGB7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723411300; c=relaxed/simple;
	bh=pheRWS/WfgSFG+rDhKvzrJ0Y1XJmoH8WxkVEDAVFjdw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JWtE/AUNiDQWlCuZT3pH6z7NiM8a5NswAP8fztHmgJ8KBoWLLl8tbZKuKUdtSmSHQ7rlMx4cbot4mbWnNgUE76y56269O5jp2/4VGsIBgJ9OKJtWnR14b4mNReU7H2FjjTeCajZwLyUULjPnwHwm8r5zChCuYMi5NRnvnxSrb4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b+zQpiSd; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-66b3b4415c7so84417787b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 14:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723411298; x=1724016098; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MiWur5WPUCFOabKPS7p8sIQsgKEHOpII1M/7n2SnGyU=;
        b=b+zQpiSdwvlv2hA0xXq+G9kEk96QmF433yGTqcnzYqTCZs3OVf7LqbSg2OOv4HXrux
         pBSM7n4yALIeFK2l5qyczqCI5MAqv/RVL8p+DqWeX8RJBhXP83EuWOUceuIzygeXqTZ9
         hu+C3Cxi4aqYDdY3n+ulmmxxZJiU7G0/pRss4KGdZmQJCTocQLCCKbb1u8CUPXV2RB/Q
         cz9uzl/BMVGGwu+GfV7W4EWE1jlrY45EWQpZu6lNTqHilmhZjvVkpQa+ztJ+L/DqSnRC
         LET/CWNrXz+aWsck3BNfom8uQsxMYkyo61vg+nJ1QINbBajpFTRZ9GbKi8JBb/v4SS+E
         +ToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723411298; x=1724016098;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MiWur5WPUCFOabKPS7p8sIQsgKEHOpII1M/7n2SnGyU=;
        b=smHzTLFTf368WLDETkeaGlITkRVX3SASaOk8LryWcjCwhUaZkSvMaxinh3SmAfkq7b
         cJLrHB3FwaWIwTD7szccYuJ9++JZOvvKH6+xz9Tyjpq1Pk0pDHr11GmqeE0NYZETB8uT
         JX2+meHRNhzTKRki4z7V2xHdsJWW9w/m7Mm3eoXZboHWtW2l1A5eXSWz/Z1po3052Ry+
         eli/6mgfZ7K2Nz6iU9W2r+N93EP6PIm+PGs0+/QPm00I0ceJ8blfJyBs+hhAgC4DXomL
         3LYfNUVpGKZzRZ/0NcnijDPdz92a0TKYmYASyjv5BmDbLskKT2t+PJ6n2iJlzqJpPTYJ
         cc2g==
X-Forwarded-Encrypted: i=1; AJvYcCX5ewRh06r9WiCYLM42oIN5rlHjiRic4VgyTisE8KvmJB4mUiXXSH/aq2U6gypAmhiyK+n7TaPJy+ki5aKVj7VE+RxOZrcVZNegvE9H
X-Gm-Message-State: AOJu0YzJQgTVUAD+EdVBSSPxO61R6gubh/Z8gCc+OkEE0oW6VmgY+L64
	fLYp7oT/uV8N4kJFNap0UuMycrMK74nXasAQQwQLkHqyiV/RxDbnIiupC5tmYtEhRLUE+AOSeBQ
	2Yg==
X-Google-Smtp-Source: AGHT+IEHCLQ7KUCLVKLYCjPKQE5Er4aNEmGlPQGmmKueq/o3fFhVzS87gYKaHPAinDZLXmdPberE0nnpI54=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:c9c:12b4:a1e3:7f10])
 (user=yuzhao job=sendgmr) by 2002:a05:690c:2e13:b0:68e:edf4:7b80 with SMTP id
 00721157ae682-69ec86beceamr2524307b3.5.1723411297967; Sun, 11 Aug 2024
 14:21:37 -0700 (PDT)
Date: Sun, 11 Aug 2024 15:21:28 -0600
In-Reply-To: <20240811212129.3074314-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240811212129.3074314-1-yuzhao@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240811212129.3074314-3-yuzhao@google.com>
Subject: [PATCH mm-unstable v1 2/3] mm/cma: add cma_alloc_folio()
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"

With alloc_contig_range() and free_contig_range() supporting large
folios, CMA can allocate and free large folios too, by
cma_alloc_folio() and cma_release().

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/cma.h |  1 +
 mm/cma.c            | 47 ++++++++++++++++++++++++++++++---------------
 2 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/include/linux/cma.h b/include/linux/cma.h
index 9db877506ea8..086553fbda73 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -46,6 +46,7 @@ extern int cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 					struct cma **res_cma);
 extern struct page *cma_alloc(struct cma *cma, unsigned long count, unsigned int align,
 			      bool no_warn);
+extern struct folio *cma_alloc_folio(struct cma *cma, int order, gfp_t gfp);
 extern bool cma_pages_valid(struct cma *cma, const struct page *pages, unsigned long count);
 extern bool cma_release(struct cma *cma, const struct page *pages, unsigned long count);
 
diff --git a/mm/cma.c b/mm/cma.c
index 95d6950e177b..46feb06db8e7 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -403,18 +403,8 @@ static void cma_debug_show_areas(struct cma *cma)
 	spin_unlock_irq(&cma->lock);
 }
 
-/**
- * cma_alloc() - allocate pages from contiguous area
- * @cma:   Contiguous memory region for which the allocation is performed.
- * @count: Requested number of pages.
- * @align: Requested alignment of pages (in PAGE_SIZE order).
- * @no_warn: Avoid printing message about failed allocation
- *
- * This function allocates part of contiguous memory on specific
- * contiguous memory area.
- */
-struct page *cma_alloc(struct cma *cma, unsigned long count,
-		       unsigned int align, bool no_warn)
+static struct page *__cma_alloc(struct cma *cma, unsigned long count,
+				unsigned int align, gfp_t gfp)
 {
 	unsigned long mask, offset;
 	unsigned long pfn = -1;
@@ -463,8 +453,7 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
 
 		pfn = cma->base_pfn + (bitmap_no << cma->order_per_bit);
 		mutex_lock(&cma_mutex);
-		ret = alloc_contig_range(pfn, pfn + count, MIGRATE_CMA,
-				     GFP_KERNEL | (no_warn ? __GFP_NOWARN : 0));
+		ret = alloc_contig_range(pfn, pfn + count, MIGRATE_CMA, gfp);
 		mutex_unlock(&cma_mutex);
 		if (ret == 0) {
 			page = pfn_to_page(pfn);
@@ -494,7 +483,7 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
 			page_kasan_tag_reset(nth_page(page, i));
 	}
 
-	if (ret && !no_warn) {
+	if (ret && !(gfp & __GFP_NOWARN)) {
 		pr_err_ratelimited("%s: %s: alloc failed, req-size: %lu pages, ret: %d\n",
 				   __func__, cma->name, count, ret);
 		cma_debug_show_areas(cma);
@@ -513,6 +502,34 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
 	return page;
 }
 
+/**
+ * cma_alloc() - allocate pages from contiguous area
+ * @cma:   Contiguous memory region for which the allocation is performed.
+ * @count: Requested number of pages.
+ * @align: Requested alignment of pages (in PAGE_SIZE order).
+ * @no_warn: Avoid printing message about failed allocation
+ *
+ * This function allocates part of contiguous memory on specific
+ * contiguous memory area.
+ */
+struct page *cma_alloc(struct cma *cma, unsigned long count,
+		       unsigned int align, bool no_warn)
+{
+	return __cma_alloc(cma, count, align, GFP_KERNEL | (no_warn ? __GFP_NOWARN : 0));
+}
+
+struct folio *cma_alloc_folio(struct cma *cma, int order, gfp_t gfp)
+{
+	struct page *page;
+
+	if (WARN_ON(order && !(gfp | __GFP_COMP)))
+		return NULL;
+
+	page = __cma_alloc(cma, 1 << order, order, gfp);
+
+	return page ? page_folio(page) : NULL;
+}
+
 bool cma_pages_valid(struct cma *cma, const struct page *pages,
 		     unsigned long count)
 {
-- 
2.46.0.76.ge559c4bf1a-goog


