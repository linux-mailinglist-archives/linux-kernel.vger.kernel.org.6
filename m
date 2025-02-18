Return-Path: <linux-kernel+bounces-520068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10647A3A535
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88F80173799
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44B9231837;
	Tue, 18 Feb 2025 18:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A8NUwyld"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8B822F590
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902666; cv=none; b=RcdjpGUqbw9A1h6aFkiDg45+G+mC9s6qyQb4ppylKA+jxIy9qGtdbZHpGHBIM9eSajyC2DtXNs8iql3d5Lq+ueT+3K/MYtFZhlz6hqE2h/z5vayYfqkO+Jc5vr/O/czo40BrzSxQ6dgNZb0GUN2/sx9JloDsxM+fJHje+S8y238=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902666; c=relaxed/simple;
	bh=snkXRnTr0fFfl/vxBhniOiaSOdr/N51CbXNJXq6E7kA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nIBVaKZyyxvCxhM8pAY237r7vkwcR8aEUxy2B2cYSyRgsomnVBce/GDySAi+AG78aJqjcHq87cSOWyIuJye3O/EWLRTbRE/5CBQOYLWDbaj7THaRaWhTTSp2/i2pNenCKTfF1nghoXVpYQ0AvIbDp67yVI51Qg15RwyY8SGUNlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A8NUwyld; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-220d1c24b25so120946045ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739902663; x=1740507463; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UoHutzrguVqjpoysXGVpsK7uaSYmPmWovFVvd2hGtrQ=;
        b=A8NUwyld/jT4xXGtlx9YpvVsLrtvbCLxuOvQn/y2cxohQy95kcuiM9t4ZVK4rQQl4h
         BGwm8xgXbkLyiV5vSjCv82ASFpnpm5/7Okx2qGBbbZ2R5iZlgDfboGcFYPE73u+3PbAo
         4MrX7AKbXDaYqpXFU+E22n6sWCZ4pX8FovAoU30m+Nyz28VnGxCybwXsTp/XA7kLOXZ6
         nF3r8/ZcJqKGQ3Ks/xeAyIGRhBTtUfCSH6ggDcUD8rFXmg8SSjgT+Usp+LWXjQVYCYXq
         ZskwID1KtSyRrORmDOTC2lT8R1OZWBYch+IRhbLgOwrTS5FV3KQyVjykOUpp5ZPUe6UD
         vmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739902663; x=1740507463;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UoHutzrguVqjpoysXGVpsK7uaSYmPmWovFVvd2hGtrQ=;
        b=dk7tBCbIqam9+USKdlLG8aS88oVup+ipi6GQCkxoaxWyabBybiv81FnNJyBk94zinO
         PlhexXkqg+P56cPcyDRsR7cIh+H+71QK/FWWESX7cEplm53eR2gvHT5jjjCw4gjRK7Sd
         hXF/Kwk4R4zOqgyeSzZ5k/AVjrxzYZ7Q5NfdQIBmOv8hLNPeRKtCQPENwTkcc+OT2Lkc
         W+1M014AkPOZZ4Ru5aHrettb5n2ac+pTK9gX5ZCD5FruC5zo+jCunWZubYTVlnJXMO7A
         y/o4h2Bocb28sZa6JG5vknM80a2BBmJZAqNIQJF8KSO8iKjylDzzBgFOF7AzvTG58cdS
         S9QQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQjGHhb4m40egU+TbQJsjqve1m3ca2DXvcP+khPbJOibKcIxf4ANe8+vLzF6HDKSqO4Mz55/sjzxe2XNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdkBf+C6ZpoHCuv5SiEJ4dLOM0jMFcl63qcxqIOaZl7yQ2sk5g
	PifWCJkwYzruBi2A8hkUqucqhLx1cgJfE67u6CGoUoGri4+ETg57pcC532Cfdn3CEcNgcw==
X-Google-Smtp-Source: AGHT+IEaOE8EcrNPRUGgu2rvllVobmwvl4zwWyfKp9HM46Gmo8dFTgiEDNQFWvfPVH70G3Wi9jSEtAiS
X-Received: from pffy18.prod.google.com ([2002:aa7:93d2:0:b0:730:9499:1f46])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1903:b0:732:5c88:990
 with SMTP id d2e1a72fcca58-732618c2518mr19287789b3a.17.1739902662836; Tue, 18
 Feb 2025 10:17:42 -0800 (PST)
Date: Tue, 18 Feb 2025 18:16:51 +0000
In-Reply-To: <20250218181656.207178-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250218181656.207178-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250218181656.207178-24-fvdl@google.com>
Subject: [PATCH v4 23/27] mm/cma: introduce a cma validate function
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, Frank van der Linden <fvdl@google.com>
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
index d0227af4bb71..4388d941d381 100644
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
2.48.1.601.g30ceb7b040-goog


