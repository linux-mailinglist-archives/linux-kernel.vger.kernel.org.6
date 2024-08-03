Return-Path: <linux-kernel+bounces-278663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 765F694B349
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 00:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F080D1F224EA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 22:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A06D1553AA;
	Wed,  7 Aug 2024 22:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="DELT7BSy"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C242A4653A
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 22:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723071521; cv=none; b=Ha31sJNc3LP2qYB9/cK1t1l82FSLttTyfD6fQNEk420QZRcgXgQP72wgeE7Ez4hD3O2d0PBa6Qivwr2I7d/Sq27yWcFj7Lh+B4nIL4Yh1i7WPWKzFn3b3D7VOXE6jxqgSW/BP6kss4lwVf3g++q45MkTsweDwkDy2YZt0iEgP0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723071521; c=relaxed/simple;
	bh=B+8bRGXO4DK1cT+o30T7FGqx1ulK2x+MXDKixLIUT7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iS3CRJCnS4M4ntCHiGhIHgmM1z9lglZzwoZ+c4W2hXRyuvkC/eSQrttk+pU7Z1eejIjAGhW/0SEf+2EJSW2vTBemJBgzDh4MigDAYH3IDynQrVagKpd3+Kftt0KWh3hUcus3RFELphb76kw0Z0iJJVAyVPtaE4jC9okYCODjXbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=DELT7BSy; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b79b93a4c9so3181336d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 15:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1723071518; x=1723676318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vSGQ3ghJDXeBny3dBQsvq0Nux9zcDNCjlxZWS4Ivb4=;
        b=DELT7BSyxAZVRBPJsCc03u3MfzXgXmN4nyyaQx5yv5/xPJ2Gn6w2Py79sXICfe5tzP
         ae4rOWXb49reofFQetN9D7iWUmSW5/X3ZUv3eAo9XXflTMafIgfw0S50hSiZEZflRgU3
         suV1TeLCspIEEqp8NcuxIWGZ0ievgsWeoXHV3bxQbcz4OQnooEk6ZhfWxFp7TtZ6kaSK
         IMCh2poKLCMlQzljUvns3PnNvgT+11DJmgsnT/16OYhaeIRPynasM9BvKwsnaIx4SOiT
         s/yqCpqBX+7LYu7tfLosqqzouQ1iSHIH9GxMVvJpgmzmySPu1DJJW8kesKxUkzjY1r3C
         F8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723071518; x=1723676318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8vSGQ3ghJDXeBny3dBQsvq0Nux9zcDNCjlxZWS4Ivb4=;
        b=gNA5EB/XPWnl1dRtoKnFZnktBEm4UQChv4btcUYzLzK97XD+yoROu+NENa8EMbJHFP
         56zTjUPvO/YN8P4f5W4AqFUMspfZd9Eo9lBh4KNnApfoM5YDYe9LeqLFUCrqO1d7fNmf
         jCoxEsL1r8dWXyAdeeYBjYQ0/JtOpGn1hZPV96O4toLIq/gwBWt5XM8W5cOymbmw2ItD
         zZCuRGe6VTCYlmMonHk7HPDiYhkKAFash5EN7/yG8e2HU58QXRPGwn0/QXq84K/Taz50
         qTKODCGkgG4nrWH/4Jru55SihfKI+gHVYUgWYdCa6b4LjJC428HIk0q0sVQQ9/iptqRR
         6iQQ==
X-Gm-Message-State: AOJu0YyMPE24zZVrv6FopoioINSNFg5fPDyC5MaAUwWllEBb/JGhaiRZ
	m9xDM4zQ+rn46Yy7sxuiUszTpaw+op1xN8yd6+mvZS6/jByLlzqbSlryKjs7VMs=
X-Google-Smtp-Source: AGHT+IHrmXvSFPR8DEpCEZoK/8ZCUguaRRqJB0WtVruTixcSBpQ7PFaE5Ryt/O/El3X3FdLuFEvGrg==
X-Received: by 2002:a05:6214:33c3:b0:6b5:81ac:6b84 with SMTP id 6a1803df08f44-6bd6c340ce3mr545126d6.14.1723071518498;
        Wed, 07 Aug 2024 15:58:38 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c7b82cbsm59997096d6.61.2024.08.07.15.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 15:58:38 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	ying.huang@intel.com,
	nphamcs@gmail.com,
	nehagholkar@meta.com,
	abhishekd@meta.com,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH 1/3] migrate: Allow migrate_misplaced_folio APIs without a VMA
Date: Sat,  3 Aug 2024 05:47:13 -0400
Message-ID: <20240803094715.23900-2-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240803094715.23900-1-gourry@gourry.net>
References: <20240803094715.23900-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To migrate unmapped pagecache folios, migrate_misplaced_folio and
migrate_misplaced_folio_prepare must handle folios without VMAs.

migrate_misplaced_folio_prepare checks VMA for exec bits, so allow
a NULL VMA when it does not have a mapping. migrate_misplaced_folio
does not require a VMA, remove it from the argument list.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/migrate.h | 6 ++----
 mm/huge_memory.c        | 2 +-
 mm/memory.c             | 2 +-
 mm/migrate.c            | 7 +++----
 4 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 644be30b69c8..553bdb4a65db 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -141,16 +141,14 @@ const struct movable_operations *page_movable_ops(struct page *page)
 #ifdef CONFIG_NUMA_BALANCING
 int migrate_misplaced_folio_prepare(struct folio *folio,
 		struct vm_area_struct *vma, int node);
-int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
-			   int node);
+int migrate_misplaced_folio(struct folio *folio, int node);
 #else
 static inline int migrate_misplaced_folio_prepare(struct folio *folio,
 		struct vm_area_struct *vma, int node)
 {
 	return -EAGAIN; /* can't migrate now */
 }
-static inline int migrate_misplaced_folio(struct folio *folio,
-					 struct vm_area_struct *vma, int node)
+static inline int migrate_misplaced_folio(struct folio *folio, int node)
 {
 	return -EAGAIN; /* can't migrate now */
 }
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f4be468e06a4..f79c42e36d37 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1725,7 +1725,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	spin_unlock(vmf->ptl);
 	writable = false;
 
-	if (!migrate_misplaced_folio(folio, vma, target_nid)) {
+	if (!migrate_misplaced_folio(folio, target_nid)) {
 		flags |= TNF_MIGRATED;
 		nid = target_nid;
 	} else {
diff --git a/mm/memory.c b/mm/memory.c
index 34f8402d2046..1d97bdfd0ed6 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5355,7 +5355,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	ignore_writable = true;
 
 	/* Migrate to the requested node */
-	if (!migrate_misplaced_folio(folio, vma, target_nid)) {
+	if (!migrate_misplaced_folio(folio, target_nid)) {
 		nid = target_nid;
 		flags |= TNF_MIGRATED;
 	} else {
diff --git a/mm/migrate.c b/mm/migrate.c
index e7296c0fb5d5..c648dc08758b 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2546,7 +2546,7 @@ static struct folio *alloc_misplaced_dst_folio(struct folio *src,
 
 /*
  * Prepare for calling migrate_misplaced_folio() by isolating the folio if
- * permitted. Must be called with the PTL still held.
+ * permitted. If VMA is not NULL, Must be called with the PTL still held.
  */
 int migrate_misplaced_folio_prepare(struct folio *folio,
 		struct vm_area_struct *vma, int node)
@@ -2563,7 +2563,7 @@ int migrate_misplaced_folio_prepare(struct folio *folio,
 		 * See folio_likely_mapped_shared() on possible imprecision
 		 * when we cannot easily detect if a folio is shared.
 		 */
-		if ((vma->vm_flags & VM_EXEC) &&
+		if (vma && (vma->vm_flags & VM_EXEC) &&
 		    folio_likely_mapped_shared(folio))
 			return -EACCES;
 
@@ -2614,8 +2614,7 @@ int migrate_misplaced_folio_prepare(struct folio *folio,
  * elevated reference count on the folio. This function will un-isolate the
  * folio, dereferencing the folio before returning.
  */
-int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
-			    int node)
+int migrate_misplaced_folio(struct folio *folio, int node)
 {
 	pg_data_t *pgdat = NODE_DATA(node);
 	int nr_remaining;
-- 
2.43.0


