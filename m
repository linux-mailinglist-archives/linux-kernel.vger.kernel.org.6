Return-Path: <linux-kernel+bounces-336587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF6C983CC5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB9C71F22E52
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04354811EB;
	Tue, 24 Sep 2024 06:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GANG1nte"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B6F12C544
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 06:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727158274; cv=none; b=dHdMW29ImxjKppX8mtBdevc4AcJDn9seSilcVkYxqBhfV7w6a/sfg+qgZNwCHXXuKcN2gKHgulqECH5eUgq01jhoMKzuhT+KeN11n6/kGIpjLDenXzQJeZXBEz1+1BdpFrzYZqwZl7V4m8aTezByvHTRnBd8GejTo3uBx6ynhwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727158274; c=relaxed/simple;
	bh=jM90FoLs4n/oQxSzhPYYLIrDBR33Qih88e32uMrgh9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GIvsXz64/b4eWQ4dmaaz0pa37TgONMazTtd8/Fez7YZ6hcUdLmcTlfpKPpLJsQtVny8yVi5DqGQKbBqZZarMx4uDRgZhq3b8C6hw+dcpkmcH8j2fd3gS0jK4C4iXSBERVJCwNiTl/uQRXMr+Y1aCndJP9qMStCg/7bfcyocuWa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GANG1nte; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2068bee21d8so51320605ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 23:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727158272; x=1727763072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtqkBA88kwvMRDkdpXIuTPjK06Yw44S9bnA3B3TRVKU=;
        b=GANG1nteSJP8So2t/n8yrGVqu8KElvDoag7y0NLYCWubPbvnvqudLdy5hmh3RcAyTF
         Cm5TXG+9mRBD890veQoQhmnWVHmISvIN2NV29v1YdE2WUK7MC4cf8tGka3poM49qSjNh
         WwUJwRrRih066OFBEXt/G3YpS9UsJ0mUro+1DkmhhCzGMRfxCSpsOeCvsWAcxbcIx5tm
         X2Rwkzbdl4XGJNa1MHll9Cbx8zqaDsZCszGCjl+zabmRUmI1nMKJVf6c3ter7F1awmqE
         ctx1XVQoUQS6NElfEC/uubTbK0jGHZFxFMvFETNny/RxBtqngSaV065H7xIa9OHhg6yM
         y1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727158272; x=1727763072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtqkBA88kwvMRDkdpXIuTPjK06Yw44S9bnA3B3TRVKU=;
        b=BGnKXSYTq/jk7WyXWMnzRi+MY0+cjdAM1D2L/+LkBOSF1jZ4DVgdbu8/OWrQuFTQMg
         +lHvlSszjDEx/UXIp4SufWnM6LqG0PF0mTh2NkCnJVdl4dK401i4XwBhregOelvGQUe7
         Sbu5IN1QqCNokH7QdsA+TxxYy/cOwmMlOaZBUXwtGLoDcJwZHGCLf15tW+yPtqfC/yUg
         l2+1Ro5MZ0WqnuAIKjW0T2z0NFpO7v/T5D7kWsP0S4RfZA0mwHK8gv3T2ipqwVQWns9H
         HmMsBDzWcdFmaWY9eM7OcS4KN+Q0ZFLCdktQBvVvqukWDJTe24QbSF0HbOAs/0h6V4S0
         pCsw==
X-Gm-Message-State: AOJu0Yzd1DQEXJ66CLN19DiA1UyRVTaQGoYZYcvdbhR3hdodG8g7kDA6
	7+PCvIW3GMubF3Lb2jj+Al7Y+pp/oxQXfyV3uP+WdZ8ASTn86C+BtrDD25TK6Ek=
X-Google-Smtp-Source: AGHT+IGXhl7eW49ih0T9YK4dpESD/v76/2vHb7m+lE9WqCGFaYPlARnoD/c7DbHxV22Za7qr6kwfpA==
X-Received: by 2002:a17:902:f54f:b0:205:755c:dde6 with SMTP id d9443c01a7336-208d83cc8b6mr212103045ad.30.1727158272107;
        Mon, 23 Sep 2024 23:11:12 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af17229c9sm4344885ad.85.2024.09.23.23.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 23:11:11 -0700 (PDT)
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
	ryan.roberts@arm.com,
	christophe.leroy2@cs-soprasteria.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 07/13] mm: khugepaged: collapse_pte_mapped_thp() use pte_offset_map_rw_nolock()
Date: Tue, 24 Sep 2024 14:09:59 +0800
Message-Id: <07d975c50fe09c246e087303b39998430b1a66bd.1727148662.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1727148662.git.zhengqi.arch@bytedance.com>
References: <cover.1727148662.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In collapse_pte_mapped_thp(), we may modify the pte and pmd entry after
acquring the ptl, so convert it to using pte_offset_map_rw_nolock(). At
this time, the pte_same() check is not performed after the PTL held. So we
should get pgt_pmd and do pmd_same() check after the ptl held.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/khugepaged.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 6498721d4783a..8ab79c13d077f 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1605,7 +1605,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	if (userfaultfd_armed(vma) && !(vma->vm_flags & VM_SHARED))
 		pml = pmd_lock(mm, pmd);
 
-	start_pte = pte_offset_map_nolock(mm, pmd, haddr, &ptl);
+	start_pte = pte_offset_map_rw_nolock(mm, pmd, haddr, &pgt_pmd, &ptl);
 	if (!start_pte)		/* mmap_lock + page lock should prevent this */
 		goto abort;
 	if (!pml)
@@ -1613,6 +1613,9 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	else if (ptl != pml)
 		spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
 
+	if (unlikely(!pmd_same(pgt_pmd, pmdp_get_lockless(pmd))))
+		goto abort;
+
 	/* step 2: clear page table and adjust rmap */
 	for (i = 0, addr = haddr, pte = start_pte;
 	     i < HPAGE_PMD_NR; i++, addr += PAGE_SIZE, pte++) {
@@ -1645,7 +1648,6 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 		nr_ptes++;
 	}
 
-	pte_unmap(start_pte);
 	if (!pml)
 		spin_unlock(ptl);
 
@@ -1658,13 +1660,19 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	/* step 4: remove empty page table */
 	if (!pml) {
 		pml = pmd_lock(mm, pmd);
-		if (ptl != pml)
+		if (ptl != pml) {
 			spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
+			if (unlikely(!pmd_same(pgt_pmd, pmdp_get_lockless(pmd)))) {
+				spin_unlock(pml);
+				goto abort;
+			}
+		}
 	}
 	pgt_pmd = pmdp_collapse_flush(vma, haddr, pmd);
 	pmdp_get_lockless_sync();
 	if (ptl != pml)
 		spin_unlock(ptl);
+	pte_unmap(start_pte);
 	spin_unlock(pml);
 
 	mmu_notifier_invalidate_range_end(&range);
-- 
2.20.1


