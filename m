Return-Path: <linux-kernel+bounces-539174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF20BA4A1AC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DDD01891A7F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B78277030;
	Fri, 28 Feb 2025 18:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ieyKP8RZ"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DAC277005
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767428; cv=none; b=KLEp9JLlehDT5Rp1kel9kvrdNvhizVwN0kPG7B3nrpxp7vFa9FfrT37kI+EwOYm51LeKF2gKVD/5wgCmq00FIVhVB5meAS+L8HSfo8aHH7UvA8X9epQeKLqLsqLyg8u6he3vdhhFJrkOMMk3p7gF4qBCM1oikWMEvWP//8JUzgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767428; c=relaxed/simple;
	bh=3Lv5Z/ATYlscC4ohH4kKoakZp5reDJ5CLNojylEo6Ic=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CBJFZQ90Rd1KZNuBL+AJS+2yEl+ucpDOolxCAFY4rNN/mr9yeSPIosCmxB3tZpJUchYmwZtxV+UtzA9tw1oHn4hrviSjN8/l8DETiAtdjkwYQB4xaMADXA14Sr3be7HhutHdkJxnvPYBlvJbHSY07oWfynS0vtLNe1B7P1PSidU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ieyKP8RZ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2234dddbd6fso54914895ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740767426; x=1741372226; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GJJkcZXm0UDGyycKT5zJa6qHUoeoBff/K3o/6oYQz4Q=;
        b=ieyKP8RZ59dybxy+2H/6/dDk7PNpX1wcvdj85shbqJ3Ik00cSihG1+Fz9lc6qyKXNV
         RUthr4IZx6YulKf4d601xkTPE/mP1MIJSMu6eKVL/I+w/TujsoNO9sL6CqxBtodOzdgJ
         HXod50EJEavU31a4ft4ywz57uN+A2+1cnwia2GTSJrwTNJc94i1fw7x6r34x+Y7xTHk8
         RghRg26DXceIIsowfkCj+OJjlO76YdsYNjgQjFoeZ04IG752YNpnuJvX8NLm4IRVwZ6d
         5/dhqgBFZ9t/m1mWwpuSamoVpQz0TVHWJRSn0vmTudgP/+WJEbpVZUtbx2gmlv1fGwfk
         1vMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740767426; x=1741372226;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GJJkcZXm0UDGyycKT5zJa6qHUoeoBff/K3o/6oYQz4Q=;
        b=pgEainlfp0kTFdao2wWQWetIb/LPnEuRjRIrqasUYWpfw0d3j2uDUfcZmcMWUmFZaU
         jPL5uzHqwPg4jQoRd9L+OLCmQntvTgdsl/SWus4713BY1kqQcKFMi6AasNQva+pY2vT6
         v//q6Z1voGKiB+RgaA+eDMp63dtBRLGt7eVmqFRq9lZDjN3fvn0gfIpd9I2hxdtIjn1k
         kMLt3VNRC09tFY7ksYTr1AXehJ50y72B8VuNAA0VV/si9IwDfQRI7gntX6eHxYJa7Hc2
         JSDdMCORzprdSJAyPHJfCdYsTnOqaDkDBrW39CdcRmlEqWYf00fUaklTpbMOCUxCqTCx
         P0NA==
X-Forwarded-Encrypted: i=1; AJvYcCU0qoE7DEYCWcnFOTCgz+0rekXNiuczlZKHhrHRG14r9nrTNETPj8gPe6m95J7uJdX7wi7Un0paWSE9dF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs8YifNU01oVfG5e6wFlseKP7QRoKp7NyeTOnsmLH8gRDVGpgg
	wT+MOaWwQAAuDRHpNm4pwPL0BT9cpJKhKnRkjSag/F/ZPXjmtX+TPU2N9LQdujRAKVYzTg==
X-Google-Smtp-Source: AGHT+IFaQfecV0+g8772luhiih5Wz27ZxuM2qewDmjx0CupIM+riybkEMnFN2lTpHGDtl7PIHg8dgK4Y
X-Received: from pjbpw4.prod.google.com ([2002:a17:90b:2784:b0:2ef:82c0:cb8d])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ef47:b0:221:2d4b:b4c6
 with SMTP id d9443c01a7336-2234b05eb87mr134741995ad.17.1740767426169; Fri, 28
 Feb 2025 10:30:26 -0800 (PST)
Date: Fri, 28 Feb 2025 18:29:24 +0000
In-Reply-To: <20250228182928.2645936-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228182928.2645936-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228182928.2645936-24-fvdl@google.com>
Subject: [PATCH v5 23/27] mm/cma: introduce a cma validate function
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, ziy@nvidia.com, david@redhat.com, 
	Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"

Define a function to check if a CMA area is valid, which means:
do its ranges not cross any zone boundaries. Store the result
in the newly created flags for each CMA area, so that multiple
calls are dealt with.

This allows for checking the validity of a CMA area early, which
is needed later in order to be able to allocate hugetlb bootmem
pages from it with pre-HVO.

Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 include/linux/cma.h |  5 ++++
 mm/cma.c            | 60 ++++++++++++++++++++++++++++++++++++---------
 mm/cma.h            |  8 +++++-
 3 files changed, 60 insertions(+), 13 deletions(-)

diff --git a/include/linux/cma.h b/include/linux/cma.h
index 03d85c100dcc..62d9c1cf6326 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -60,6 +60,7 @@ extern void cma_reserve_pages_on_error(struct cma *cma);
 #ifdef CONFIG_CMA
 struct folio *cma_alloc_folio(struct cma *cma, int order, gfp_t gfp);
 bool cma_free_folio(struct cma *cma, const struct folio *folio);
+bool cma_validate_zones(struct cma *cma);
 #else
 static inline struct folio *cma_alloc_folio(struct cma *cma, int order, gfp_t gfp)
 {
@@ -70,6 +71,10 @@ static inline bool cma_free_folio(struct cma *cma, const struct folio *folio)
 {
 	return false;
 }
+static inline bool cma_validate_zones(struct cma *cma)
+{
+	return false;
+}
 #endif
 
 #endif
diff --git a/mm/cma.c b/mm/cma.c
index 61ad4fd2f62d..5e1d169e24fa 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -99,6 +99,49 @@ static void cma_clear_bitmap(struct cma *cma, const struct cma_memrange *cmr,
 	spin_unlock_irqrestore(&cma->lock, flags);
 }
 
+/*
+ * Check if a CMA area contains no ranges that intersect with
+ * multiple zones. Store the result in the flags in case
+ * this gets called more than once.
+ */
+bool cma_validate_zones(struct cma *cma)
+{
+	int r;
+	unsigned long base_pfn;
+	struct cma_memrange *cmr;
+	bool valid_bit_set;
+
+	/*
+	 * If already validated, return result of previous check.
+	 * Either the valid or invalid bit will be set if this
+	 * check has already been done. If neither is set, the
+	 * check has not been performed yet.
+	 */
+	valid_bit_set = test_bit(CMA_ZONES_VALID, &cma->flags);
+	if (valid_bit_set || test_bit(CMA_ZONES_INVALID, &cma->flags))
+		return valid_bit_set;
+
+	for (r = 0; r < cma->nranges; r++) {
+		cmr = &cma->ranges[r];
+		base_pfn = cmr->base_pfn;
+
+		/*
+		 * alloc_contig_range() requires the pfn range specified
+		 * to be in the same zone. Simplify by forcing the entire
+		 * CMA resv range to be in the same zone.
+		 */
+		WARN_ON_ONCE(!pfn_valid(base_pfn));
+		if (pfn_range_intersects_zones(cma->nid, base_pfn, cmr->count)) {
+			set_bit(CMA_ZONES_INVALID, &cma->flags);
+			return false;
+		}
+	}
+
+	set_bit(CMA_ZONES_VALID, &cma->flags);
+
+	return true;
+}
+
 static void __init cma_activate_area(struct cma *cma)
 {
 	unsigned long pfn, base_pfn;
@@ -113,19 +156,12 @@ static void __init cma_activate_area(struct cma *cma)
 			goto cleanup;
 	}
 
+	if (!cma_validate_zones(cma))
+		goto cleanup;
+
 	for (r = 0; r < cma->nranges; r++) {
 		cmr = &cma->ranges[r];
 		base_pfn = cmr->base_pfn;
-
-		/*
-		 * alloc_contig_range() requires the pfn range specified
-		 * to be in the same zone. Simplify by forcing the entire
-		 * CMA resv range to be in the same zone.
-		 */
-		WARN_ON_ONCE(!pfn_valid(base_pfn));
-		if (pfn_range_intersects_zones(cma->nid, base_pfn, cmr->count))
-			goto cleanup;
-
 		for (pfn = base_pfn; pfn < base_pfn + cmr->count;
 		     pfn += pageblock_nr_pages)
 			init_cma_reserved_pageblock(pfn_to_page(pfn));
@@ -145,7 +181,7 @@ static void __init cma_activate_area(struct cma *cma)
 		bitmap_free(cma->ranges[r].bitmap);
 
 	/* Expose all pages to the buddy, they are useless for CMA. */
-	if (!cma->reserve_pages_on_error) {
+	if (!test_bit(CMA_RESERVE_PAGES_ON_ERROR, &cma->flags)) {
 		for (r = 0; r < allocrange; r++) {
 			cmr = &cma->ranges[r];
 			for (pfn = cmr->base_pfn;
@@ -172,7 +208,7 @@ core_initcall(cma_init_reserved_areas);
 
 void __init cma_reserve_pages_on_error(struct cma *cma)
 {
-	cma->reserve_pages_on_error = true;
+	set_bit(CMA_RESERVE_PAGES_ON_ERROR, &cma->flags);
 }
 
 static int __init cma_new_area(const char *name, phys_addr_t size,
diff --git a/mm/cma.h b/mm/cma.h
index ff79dba5508c..bddc84b3cd96 100644
--- a/mm/cma.h
+++ b/mm/cma.h
@@ -49,11 +49,17 @@ struct cma {
 	/* kobject requires dynamic object */
 	struct cma_kobject *cma_kobj;
 #endif
-	bool reserve_pages_on_error;
+	unsigned long flags;
 	/* NUMA node (NUMA_NO_NODE if unspecified) */
 	int nid;
 };
 
+enum cma_flags {
+	CMA_RESERVE_PAGES_ON_ERROR,
+	CMA_ZONES_VALID,
+	CMA_ZONES_INVALID,
+};
+
 extern struct cma cma_areas[MAX_CMA_AREAS];
 extern unsigned int cma_area_count;
 
-- 
2.48.1.711.g2feabab25a-goog


