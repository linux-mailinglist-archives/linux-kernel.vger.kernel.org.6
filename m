Return-Path: <linux-kernel+bounces-285827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 169F3951340
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 05:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C135F1F2348F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 03:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2896755887;
	Wed, 14 Aug 2024 03:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QnvzCcST"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7964D8BC
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 03:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723607703; cv=none; b=RqFYTYkr5BCJxK586ez+Vj8EEaDXO+obcBKRdcgWcIzAQWvQYBVM8t8RJn2ukPdc33PGB7a8Ykn3SR3R9+5NxN8ZMUOXzJNadpMPeYDMBF4H1ImnTgnoUk6PXnGTKDlxatrKHuPGVLbuedQk/QtRsdnXK4WNdOUOwSk1LO1RrKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723607703; c=relaxed/simple;
	bh=gkuj+QORVAEFJswm0cFxxi72cquXt3ymPdC/VTEwA2k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X+HwrgUUZqo0phHq3/cY6OzOc1gAEd9zmnfV9WOtMea6QTgdQnZczBbifl9yrH5Xi+WAzu305Bat7SleSQvk+W/amKDzgeYbkNqMwxAO/7KbbwxyApzrws2l9VixgAFuTkB+4vLYemghsh5HI89La6FVclJaS0WSAsBf56LVvl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QnvzCcST; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e087ed145caso10458528276.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 20:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723607700; x=1724212500; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KXVmwVL4hZRiA8cTojFTWKVHpRNtdM/qQOsCSMq7lmE=;
        b=QnvzCcSTnXYwW6iM7Saf+7wpdOtcjeqD6bpan3oSNLy6QuXWIMU2ktMlYF2kP966qR
         tX6zy3sb+NJWWxUtQ9OiMgOAUMFrb6k7uwefkbfBmBjU7XrSSCq/ErT70dWHGcdNZTCY
         347RD0fF+xg85FLtOiwpxPuPQckHi/3hjSeeOI6fZ+3Agvsv3qeAR/NVYIXGV3ainXDl
         jfNP03/gMMc6C9yJOBI+FWdTHWqomZ6NsZ65mOXMDJjQFk97uxVbyjeo3iflLIoeXivr
         HHsWmLimEPFc6MoR0PbYRvstbLNMSBBdhhUv1dLfB+U7AGZXlYL40wIcPCo4WdcOVGiv
         LvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723607700; x=1724212500;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KXVmwVL4hZRiA8cTojFTWKVHpRNtdM/qQOsCSMq7lmE=;
        b=H451a9xT55N7BE9oAk/6xhUgB5X1aEmBK/ahIro9q8sEUJOncF8Wl0q7OjageBECqm
         Hm+jyn0cXfhB2+csmwTjVnzMjgD98cP2uVocGTymQH1RPPVSijPltlPEFMt50yQlzIFS
         gxPVj1OMraFqQMtgnxgDNq0gmn9/7dR3ZL8umE1UzOrLpawCmi2exUE6CaUySo10fWLT
         /Kc6sDlQ6rWQBTzouzR+sKy5aOGZzpxy/rAAQ4AO4MFSqt/1MKLHRcdtXjR9A+Rd/mrq
         sFAVu9x1qnPbODIxDku0PMobxoFQF89TIRzJwf6lNjHQ2lDKVkAj7yc8ogcnWdwttoCO
         LJlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbIsmACW37/4Rpzcc+5z4+l5LBSWHMxvuuR2C+td4dMBDpUDd6TY+eIgLr4iOqJssR+Mrq7E6y5jbOXInxg/Rp4HK2gtg60z7xsNWX
X-Gm-Message-State: AOJu0YwQqWmCMOPbIfSgkxBL+zb8iR3H7A/lJyQYL/Q9IkDb19wX5Ie4
	vK6AeiuhadVa6Cm5D+sk5MzZGcD62X8Gb3OJgfmy3hH4vVWIfZt1RNSAPzLaRkZtuW56/KFJ9k3
	/IA==
X-Google-Smtp-Source: AGHT+IHdxjtU6GE8e6uUmdDhkDkgKFsun57md8iAQGJ8zy2FVnTlUkIoTwELvFGK+N9W879dEyGV8DeAgrM=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:c8ad:fcc7:f7cf:f2fd])
 (user=yuzhao job=sendgmr) by 2002:a25:c788:0:b0:e03:62dc:63de with SMTP id
 3f1490d57ef6-e1155ada202mr81659276.6.1723607700515; Tue, 13 Aug 2024 20:55:00
 -0700 (PDT)
Date: Tue, 13 Aug 2024 21:54:50 -0600
In-Reply-To: <20240814035451.773331-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240814035451.773331-1-yuzhao@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240814035451.773331-3-yuzhao@google.com>
Subject: [PATCH mm-unstable v2 2/3] mm/cma: add cma_{alloc,free}_folio()
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"

With alloc_contig_range() and free_contig_range() supporting large
folios, CMA can allocate and free large folios too, by
cma_alloc_folio() and cma_free_folio().

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/cma.h | 16 +++++++++++++
 mm/cma.c            | 55 ++++++++++++++++++++++++++++++++-------------
 2 files changed, 56 insertions(+), 15 deletions(-)

diff --git a/include/linux/cma.h b/include/linux/cma.h
index 9db877506ea8..d15b64f51336 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -52,4 +52,20 @@ extern bool cma_release(struct cma *cma, const struct page *pages, unsigned long
 extern int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data);
 
 extern void cma_reserve_pages_on_error(struct cma *cma);
+
+#ifdef CONFIG_CMA
+struct folio *cma_alloc_folio(struct cma *cma, int order, gfp_t gfp);
+bool cma_free_folio(struct cma *cma, const struct folio *folio);
+#else
+static inline struct folio *cma_alloc_folio(struct cma *cma, int order, gfp_t gfp)
+{
+	return NULL;
+}
+
+static inline bool cma_free_folio(struct cma *cma, const struct folio *folio)
+{
+	return false;
+}
+#endif
+
 #endif
diff --git a/mm/cma.c b/mm/cma.c
index 95d6950e177b..4354823d28cf 100644
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
+	if (WARN_ON(!order || !(gfp | __GFP_COMP)))
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
@@ -564,6 +581,14 @@ bool cma_release(struct cma *cma, const struct page *pages,
 	return true;
 }
 
+bool cma_free_folio(struct cma *cma, const struct folio *folio)
+{
+	if (WARN_ON(!folio_test_large(folio)))
+		return false;
+
+	return cma_release(cma, &folio->page, folio_nr_pages(folio));
+}
+
 int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data)
 {
 	int i;
-- 
2.46.0.76.ge559c4bf1a-goog


