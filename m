Return-Path: <linux-kernel+bounces-339971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A04C4986CD3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 570E4284081
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 06:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3754218C34C;
	Thu, 26 Sep 2024 06:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dMJ3pJs+"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A15917554A
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 06:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727333264; cv=none; b=NQCzoOJYXAxS48MHDKIIc3Rp32jMY5vVLjBdKmAa6KZJ0lWY+z1olosUoxRE5pKw6qS5AU/w2AnkOv2CH3s2QgVNdk11Br9RfpNVN54OprOVyDGUCr4y0C853shhuwzvC/Da0nlQSlan5Uv98MPkEUAiCtikHpu/Lkb+x2/jXjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727333264; c=relaxed/simple;
	bh=J8iz6TRBjz8Nxahcna8Ou8absZteAFKLGxxh6adklaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Amgr0tQr/TlJVH1IHAEUw7xSdPYJ+x9ZU63/STyTSUnW0i6RMKibWFipVSwQnALTxKRSvEOBIhz+An3oJdO0ygaQ5u1V4dJ0e1RRnHAJHPhZ7O7Bje/8PvzWqTSdtSbETI0Bva+Ht+QMFSzZICvV+pbTBXjF1ZEZAMudvfcgWRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dMJ3pJs+; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4582f9abb43so4181771cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 23:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727333262; x=1727938062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffdIJrLHJ9HLo1zmy1fROVnOG/sDLfcmik2lSMoQorU=;
        b=dMJ3pJs+6KbqqyksF5ltQRBDIHtzWOBPCQRPM90zJCJac+AjZ1QNtnoambk0F2PMXG
         3oYPDXVicIQPbXBnN712lJnW4VWSxGByE73+unXg7lxBPrL0heVxdUul90XZ0AVyKOv5
         wypvcEZd9rWYiUi4R03Lw+dRMysxsid5V97huYBruUXzlyI2l0lRHixDA8JJz56CzjIB
         KmT8ETdn4h/B124tHPvnCGZpMi/tVbAyjVbGDkYFy3VLchjy019qVjvfk7g6CGORFhFV
         Y3Hx+K9x88AFP788wAlt25HmdYoHp/C9UdbeO6d0i5VHdjVtYh7pA3nM0Ctbc0BufcEX
         gnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727333262; x=1727938062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffdIJrLHJ9HLo1zmy1fROVnOG/sDLfcmik2lSMoQorU=;
        b=qDs921lOES3fuOZaw8qiDYOpciQN5Ibo2h+dYD1pd/OPiw7fITQX76tyocB8FtmN1U
         K6XxqFJniSjL6CLMoI59XmWpe65j1juw8KNlwAEql2SonHhdoj8tWaoN65dVaovBArW+
         ETSt/aOIxclLYb3eUWqeGnNozUZqreXwE0051TvOFIEdQAXeAICngDTezZRmYUgRjpbt
         C3usSSWe/c+UYQPfF5EFEBXyYP/MUmFVZYK7HAE2rQkf17v0hH+6NFpxJdt40iJAAy9W
         4014QHBQvnEN06iFQ1KeoEucTr69jx+kBQkEzF9BCP5x34b4QUx+iTkuCyxBxMVSbvP7
         402A==
X-Gm-Message-State: AOJu0YwH7Tw1LPId1QsnXP6U7wsoGMHpXJxXJRtxprvdT6NHbZ4RcLWG
	sGMtPTWFqN7Ky8lgfaN5DIEKCWX6WO9hSgPIZ8MjN5JPQPXxZ+7t5yAtAMNUbLk=
X-Google-Smtp-Source: AGHT+IFPPE2WMfZ0ye6LGa3/R8zXQ/6KjVtS14uw6772ox/YEy7cH2DCZDAwEci91jHXPd4jVDRFUg==
X-Received: by 2002:a05:622a:1493:b0:457:c747:cf3c with SMTP id d75a77b69052e-45b5e0534ebmr99370671cf.57.1727333261763;
        Wed, 25 Sep 2024 23:47:41 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b5257ff1esm23024611cf.38.2024.09.25.23.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 23:47:41 -0700 (PDT)
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
Subject: [PATCH v5 07/13] mm: khugepaged: collapse_pte_mapped_thp() use pte_offset_map_rw_nolock()
Date: Thu, 26 Sep 2024 14:46:20 +0800
Message-Id: <055e42db68da00ac8ecab94bd2633c7cd965eb1c.1727332572.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1727332572.git.zhengqi.arch@bytedance.com>
References: <cover.1727332572.git.zhengqi.arch@bytedance.com>
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
 mm/khugepaged.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 6498721d4783a..854577f39957d 100644
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
 
@@ -1658,14 +1660,19 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	/* step 4: remove empty page table */
 	if (!pml) {
 		pml = pmd_lock(mm, pmd);
-		if (ptl != pml)
+		if (ptl != pml) {
 			spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
+			if (unlikely(!pmd_same(pgt_pmd, pmdp_get_lockless(pmd)))) {
+				flush_tlb_mm(mm);
+				goto unlock;
+			}
+		}
 	}
 	pgt_pmd = pmdp_collapse_flush(vma, haddr, pmd);
 	pmdp_get_lockless_sync();
+	pte_unmap_unlock(start_pte, ptl);
 	if (ptl != pml)
-		spin_unlock(ptl);
-	spin_unlock(pml);
+		spin_unlock(pml);
 
 	mmu_notifier_invalidate_range_end(&range);
 
@@ -1685,6 +1692,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 		folio_ref_sub(folio, nr_ptes);
 		add_mm_counter(mm, mm_counter_file(folio), -nr_ptes);
 	}
+unlock:
 	if (start_pte)
 		pte_unmap_unlock(start_pte, ptl);
 	if (pml && pml != ptl)
-- 
2.20.1


