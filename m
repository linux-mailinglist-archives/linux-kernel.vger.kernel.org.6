Return-Path: <linux-kernel+bounces-295115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 167E09596F9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72290283802
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 09:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAEB1C2DA3;
	Wed, 21 Aug 2024 08:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ezwfIaLk"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D35C1C86F2
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724228436; cv=none; b=hrMUe0yE7kuPYVJUnACRu86yyt/G1Z4R6uom4W/DWQT7Q/U5sq3ZxT78NSqkpJnTQCNZjxnam6KG9jAA/Zu1X6JjLT4VuhifXUziN5URlrL64Nzmwl2MekEva9qQ7ByFTNIlIuZMeXI02UHDCujkdzOAW9viFTZ1agDkY8xxN/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724228436; c=relaxed/simple;
	bh=NiiNJF6H5kOWV296o4Bpn1eahVPpz1/Giwkf5jrcY5g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=swjUIdAJay03P5Nq8DtCMa0DXGr2/u5cW1t59/QxtZZJSj6B0M7c4Ur0MEwOaJUwHVlsJuV1aSLDuBELK0RBTAqTjXRa8rn/hpldTp8+JUkmw1iMnBuNXpmVGgYIzhpqlS6LibmGD1ADhGTzF+2LmVERmhznn+bXiakUFuukCa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ezwfIaLk; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fee6435a34so42386415ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 01:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724228435; x=1724833235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvwQXaavnjACpbuRjCPShfvJkJjZwFPa7EtFYmq5Q9U=;
        b=ezwfIaLkRJoJ/s6lSflT9wI3iDSeYzfVGmfxHof6gERJLoTLwQUDuywqWP+uwvZAe2
         tIJrrJ6zOCUSwa43fhTx4mU7kBOI4U9FhR4iZbhBpHeeEeqyej6jj1ZrhawOIBkMfnQm
         QfDptpENUpUTBFei+zm04bACbja84c7UfvxwpD9tgKmEblkmsJ9gHaoOfxw4u90QLTny
         7qK0KO/9SKGCQEvXnWBzXFyM5AdQd1K1udYy/VRxY23kAY1V77+UlVFi0XXWuNAnez2y
         j0jLYNzhzt2mT5if/NHH3tW/5d4xF2kbtafB6Ezp8ToneSC7XLe0JKLY+SCYnzgCuDjf
         1EvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724228435; x=1724833235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MvwQXaavnjACpbuRjCPShfvJkJjZwFPa7EtFYmq5Q9U=;
        b=CPRYFPFzF3143UuC+XRbcpP6fs8aYhFRtp1slWD9oh86rfS9AVpfuLuvYfxhrnQsD6
         RS94EHqBsHiWR+qh6q3vqeWLHJd/rJroBJCoFN5Zwl2UQt9kEuVeTgsDnpL/Bvuzs5sY
         4fI/TNViQ+RTOdH3zS8hG7JZD2AAaglIlu6QvITr/Nbe5e7MTLNNDrkdXAkZLKUd2IDE
         xIxyo7cb5YFIqoyAD9REY2vJWsCXHoFYLNKNENhJMgyWjqOCOPZt+jt6Yr2SMIhJd54+
         PHo4EzBZJ2An557WoegUP8/BJJHQogbeTJrH9HdA+kIyA/PsiO75zHM2AqZSYhpPIEhD
         DxEQ==
X-Gm-Message-State: AOJu0Ywl/inRo4thToyraC0cQ8izrZ1xZnS39LzWAyDwlYn/pWZtiT5/
	mXEXc94YliImBptzAmkgT2pdNHmjXSVsk2ZkTowGSrrAqaCtG7N4AT222iVEjrI=
X-Google-Smtp-Source: AGHT+IF3P/4155uMvmGYpoowuXrhy2v6aHwudYM9PJFMCLkX9j2rCBHO6+Z7X1wkaLdhxTlExnQxpQ==
X-Received: by 2002:a17:90b:3b41:b0:2d3:b5ca:dedf with SMTP id 98e67ed59e1d1-2d5e9a0db5cmr1626393a91.17.1724228434854;
        Wed, 21 Aug 2024 01:20:34 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eb9049b0sm1091453a91.17.2024.08.21.01.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 01:20:34 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	hughd@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	vishal.moola@gmail.com,
	peterx@redhat.com,
	ryan.roberts@arm.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 10/14] mm: page_vma_mapped_walk: map_pte() use pte_offset_map_maywrite_nolock()
Date: Wed, 21 Aug 2024 16:18:53 +0800
Message-Id: <e23662d6be464b6ed89d6abde13df1b4694f6583.1724226076.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1724226076.git.zhengqi.arch@bytedance.com>
References: <cover.1724226076.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the caller of map_pte(), we may modify the pvmw->pte after acquiring
the pvmw->ptl, so convert it to using pte_offset_map_maywrite_nolock(). At
this time, the write lock of mmap_lock is not held, and the pte_same()
check is not performed after the pvmw->ptl held, so we should get pmdval
and do pmd_same() check to ensure the stability of pvmw->pmd.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/page_vma_mapped.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index ae5cc42aa2087..da806f3a5047d 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -13,9 +13,11 @@ static inline bool not_found(struct page_vma_mapped_walk *pvmw)
 	return false;
 }
 
-static bool map_pte(struct page_vma_mapped_walk *pvmw, spinlock_t **ptlp)
+static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
+		    spinlock_t **ptlp)
 {
 	pte_t ptent;
+	pmd_t pmdval;
 
 	if (pvmw->flags & PVMW_SYNC) {
 		/* Use the stricter lookup */
@@ -25,6 +27,7 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, spinlock_t **ptlp)
 		return !!pvmw->pte;
 	}
 
+again:
 	/*
 	 * It is important to return the ptl corresponding to pte,
 	 * in case *pvmw->pmd changes underneath us; so we need to
@@ -32,10 +35,11 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, spinlock_t **ptlp)
 	 * proceeds to loop over next ptes, and finds a match later.
 	 * Though, in most cases, page lock already protects this.
 	 */
-	pvmw->pte = pte_offset_map_nolock(pvmw->vma->vm_mm, pvmw->pmd,
-					  pvmw->address, ptlp);
+	pvmw->pte = pte_offset_map_maywrite_nolock(pvmw->vma->vm_mm, pvmw->pmd,
+						   pvmw->address, &pmdval, ptlp);
 	if (!pvmw->pte)
 		return false;
+	*pmdvalp = pmdval;
 
 	ptent = ptep_get(pvmw->pte);
 
@@ -69,6 +73,12 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, spinlock_t **ptlp)
 	}
 	pvmw->ptl = *ptlp;
 	spin_lock(pvmw->ptl);
+
+	if (unlikely(!pmd_same(pmdval, pmdp_get_lockless(pvmw->pmd)))) {
+		spin_unlock(pvmw->ptl);
+		goto again;
+	}
+
 	return true;
 }
 
@@ -278,7 +288,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			step_forward(pvmw, PMD_SIZE);
 			continue;
 		}
-		if (!map_pte(pvmw, &ptl)) {
+		if (!map_pte(pvmw, &pmde, &ptl)) {
 			if (!pvmw->pte)
 				goto restart;
 			goto next_pte;
@@ -307,6 +317,12 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 		if (!pvmw->ptl) {
 			pvmw->ptl = ptl;
 			spin_lock(pvmw->ptl);
+			if (unlikely(!pmd_same(pmde, pmdp_get_lockless(pvmw->pmd)))) {
+				pte_unmap_unlock(pvmw->pte, pvmw->ptl);
+				pvmw->ptl = NULL;
+				pvmw->pte = NULL;
+				goto restart;
+			}
 		}
 		goto this_pte;
 	} while (pvmw->address < end);
-- 
2.20.1


