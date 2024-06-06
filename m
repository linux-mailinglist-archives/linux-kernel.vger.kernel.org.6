Return-Path: <linux-kernel+bounces-205030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C55478FF674
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 23:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 716CF288915
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 21:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400F313A869;
	Thu,  6 Jun 2024 21:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rYBop3Ua"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E397D1BDEF
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 21:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717708128; cv=none; b=me9knnBbyB+EPVwHHYMsDLOctPG65AZMQMQV1zs1Nf4vhJpEoBbsOAHUwKdanAxUvL6nrPZsC1mVXqGwACEDkRC/4YIFe/Xe4DxBILqRtPC9CLvyeKCzBM1aPW/S6Ma1TkGs6WL2DRlNXhSqlsewqhFqzeYeYksQvbx6Z8jmqu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717708128; c=relaxed/simple;
	bh=Ug/ACKKxEbkTvVoY6/kaf5EGZWfVHkLFkeiakUZyeGQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FHptWThjPjW695Fvq2VyhVBnouT1Lgxppi+cC2cNZuAJLIoYaIQMbxV4UqjmfdGVJfpuYmLZ/PFtMS0P8Pt3iZX1bwVgdva/hUeCjsELhY7Qf1QPL8wwMf8c4OTl+6ckpa61H0R1c4Bs986DkxZE0YREMeiywTPSOkHCGydjx8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rYBop3Ua; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-627956be166so26293077b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 14:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717708126; x=1718312926; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mye/YuqNKSozWj2ToP+PBiLkrDhSqJxsbKIKLkePCYI=;
        b=rYBop3UaIbJ3XsOynHOJGLw03U2q16/TPCde7tC47zFQ+PEUCZ/qDqjNoPAUHCEgr4
         B4sXseS20mcyLEzLd9R3ahFU2GLOpzzwB7xceeBzPvTOK0BNxmPasvwAMAQEWb46aQaA
         /mIJ5CX16okZuf0N4jN903uQjsIqQcrF8zy72pHCzTjhioAq6U60sGWuW5gt8ssmIDkZ
         V79Kip5sYrQPW+1KHjDktCvv6wBmA0zZy148ODYW7tvl0D9toUyj9QXnz3TH4hlen2/A
         jPjKxEkm01v7BLb2tYpxzo4b+6Z3q0UOw+LUKsWki4gkV/XUNY255IU2AIazxsnnC0+I
         Mi2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717708126; x=1718312926;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mye/YuqNKSozWj2ToP+PBiLkrDhSqJxsbKIKLkePCYI=;
        b=T/vNS2kTsIwW8+jB6j6k//4PmDOWGhbGGG1CDpyO9QgbGSLYP8Wgo64uIdaIxHNDt/
         XhVKsjyKusv1Amp6bEgysYssCNd4k++qiDDWlGWN6/jP7Xhfk1+6EgqZNbTzWXRviZjG
         L8ZzPbXIioAKy9vL6RCOKU4kylNgAU05DIfD6g1ZEOb8XoKbITBg+7LmIFOrz+c/XaeN
         i236wych+Jn657/Rb67AF432weEPt0Q2X3n8C5emDJ3rnwL8jbf17AU89PzDYJxsiEaD
         WsaHOsPdmRYUGAYWP5xn/Y2wjkNRg7pHtAc1dNeV/3x8QAZECyy6dayE2qTLBVSNaxvY
         3kgg==
X-Forwarded-Encrypted: i=1; AJvYcCW60OXiV9uLOBX9iQUXaB3E4NDTrCY8nmEBrLmsTOxMvyTJjnl0pKnHlzhTI/iIrQQFnSPghtttEEOrLyUXjYmiADNiOgMIYXL5vXcn
X-Gm-Message-State: AOJu0YwrIyub2lBhKRqUSot6kUwfsRmieLr05G4GgboVizdywN3By3hj
	o16hUMQrR7Jf1phApzjBI45p1o2IvhrlpOIbwbSDcSOSxVeVLYb9C18Nlr2WGB1kOCh68VbGjDd
	KycwCptpcXH+BqbHAXw==
X-Google-Smtp-Source: AGHT+IG5eZu2alNNou1PgVUYAuSn0/HSugrHQxS37yxt94oc6r8ncA4WHMp4irRp7eN3oydZ5YZmw9L8MaKII7dQ
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:100a:b0:df4:ece5:2720 with
 SMTP id 3f1490d57ef6-dfaf6608d72mr164831276.13.1717708125555; Thu, 06 Jun
 2024 14:08:45 -0700 (PDT)
Date: Thu,  6 Jun 2024 21:08:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240606210840.1650341-1-yosryahmed@google.com>
Subject: [PATCH] mm: swap: remove 'synchronous' argument to swap_read_folio()
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

swap_read_folio() reads the folio synchronously if synchronous is passed
as true or if SWP_SYNCHRONOUS_IO is set in swap_info_struct. The only
caller that passes synchronous=true is in do_swap_page() in the
SWP_SYNCHRONOUS_IO case.

Hence, the argument is redundant, it is only set to true when the swap
read would have been synchronous anyway. Remove it.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/memory.c     |  2 +-
 mm/page_io.c    |  6 +++---
 mm/swap.h       |  6 ++----
 mm/swap_state.c | 10 +++++-----
 4 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index db91304882312..2b3ef08e8bb7d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4113,7 +4113,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 
 				/* To provide entry to swap_read_folio() */
 				folio->swap = entry;
-				swap_read_folio(folio, true, NULL);
+				swap_read_folio(folio, NULL);
 				folio->private = NULL;
 			}
 		} else {
diff --git a/mm/page_io.c b/mm/page_io.c
index 41e8d738c6d28..f1a9cfab6e748 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -493,10 +493,10 @@ static void swap_read_folio_bdev_async(struct folio *folio,
 	submit_bio(bio);
 }
 
-void swap_read_folio(struct folio *folio, bool synchronous,
-		struct swap_iocb **plug)
+void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 {
 	struct swap_info_struct *sis = swp_swap_info(folio->swap);
+	bool synchronous = sis->flags & SWP_SYNCHRONOUS_IO;
 	bool workingset = folio_test_workingset(folio);
 	unsigned long pflags;
 	bool in_thrashing;
@@ -521,7 +521,7 @@ void swap_read_folio(struct folio *folio, bool synchronous,
 		folio_unlock(folio);
 	} else if (data_race(sis->flags & SWP_FS_OPS)) {
 		swap_read_folio_fs(folio, plug);
-	} else if (synchronous || (sis->flags & SWP_SYNCHRONOUS_IO)) {
+	} else if (synchronous) {
 		swap_read_folio_bdev_sync(folio, sis);
 	} else {
 		swap_read_folio_bdev_async(folio, sis);
diff --git a/mm/swap.h b/mm/swap.h
index 2c0e96272d498..baa1fa946b347 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -11,8 +11,7 @@ struct mempolicy;
 /* linux/mm/page_io.c */
 int sio_pool_init(void);
 struct swap_iocb;
-void swap_read_folio(struct folio *folio, bool do_poll,
-		struct swap_iocb **plug);
+void swap_read_folio(struct folio *folio, struct swap_iocb **plug);
 void __swap_read_unplug(struct swap_iocb *plug);
 static inline void swap_read_unplug(struct swap_iocb *plug)
 {
@@ -83,8 +82,7 @@ static inline unsigned int folio_swap_flags(struct folio *folio)
 }
 #else /* CONFIG_SWAP */
 struct swap_iocb;
-static inline void swap_read_folio(struct folio *folio, bool do_poll,
-		struct swap_iocb **plug)
+static inline void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 {
 }
 static inline void swap_write_unplug(struct swap_iocb *sio)
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 0803eedeabe3d..994723cef8217 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -567,7 +567,7 @@ struct folio *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	mpol_cond_put(mpol);
 
 	if (page_allocated)
-		swap_read_folio(folio, false, plug);
+		swap_read_folio(folio, plug);
 	return folio;
 }
 
@@ -684,7 +684,7 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 		if (!folio)
 			continue;
 		if (page_allocated) {
-			swap_read_folio(folio, false, &splug);
+			swap_read_folio(folio, &splug);
 			if (offset != entry_offset) {
 				folio_set_readahead(folio);
 				count_vm_event(SWAP_RA);
@@ -701,7 +701,7 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 					&page_allocated, false);
 	if (unlikely(page_allocated)) {
 		zswap_folio_swapin(folio);
-		swap_read_folio(folio, false, NULL);
+		swap_read_folio(folio, NULL);
 	}
 	return folio;
 }
@@ -834,7 +834,7 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 		if (!folio)
 			continue;
 		if (page_allocated) {
-			swap_read_folio(folio, false, &splug);
+			swap_read_folio(folio, &splug);
 			if (addr != vmf->address) {
 				folio_set_readahead(folio);
 				count_vm_event(SWAP_RA);
@@ -853,7 +853,7 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 					&page_allocated, false);
 	if (unlikely(page_allocated)) {
 		zswap_folio_swapin(folio);
-		swap_read_folio(folio, false, NULL);
+		swap_read_folio(folio, NULL);
 	}
 	return folio;
 }
-- 
2.45.2.505.gda0bf45e8d-goog


