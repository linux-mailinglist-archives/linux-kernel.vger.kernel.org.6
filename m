Return-Path: <linux-kernel+bounces-296768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0431095AEDF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0FC91F26019
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56110186613;
	Thu, 22 Aug 2024 07:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="E09U+T4f"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E61185E50
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310870; cv=none; b=TUt0tAPjEAMVrWcx1vIthGw1IlSDskoulPcF0tDuoK8DKZtaB/uMhbAK8VHMd6kEwPX01KkDUguYctDXjDYwcRk7STfd9ufA5aT6oc+p+UVYpkODn1OkJLkAUM4XEOKywzA1WckisBtuMusCaaAeZCLbjpEaOx7BPp8tiC3yiK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310870; c=relaxed/simple;
	bh=qgClebIsXEeUL9yPTJGCxcrfISQbfQCIihdRM2yOoPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d7i6ZF1kRCtKevWxyKu2fkwPYl2IiQzQrpLCS5BAciQcpwDrmJCzC1I2hnpdGkLRCJLrkuQxne5hnQqjI58XYsj4aqBOtcmcbyDDMcKEL9lg9bxDLxYNpQH9Mmi/PY+aaz6UL/PtSH0qsOFp0egdEqt3PTX27kkmQW3LYv/jEQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=E09U+T4f; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-714302e7285so400158b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 00:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724310868; x=1724915668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jy8AvBGPXewIN0f06tSdN0J5TZbHLAwXxEIbEfEZm70=;
        b=E09U+T4fY5aEPg/kz2jMeahCYGQOUuHYZi7H0ofH2tWyKQOsLheAeZYvSlcrrYBBve
         of7993rzaWvg/x0CTHaN7sMHlwUQSpwYiydp4falUyZDJdyBLhgBxYuK8FeKZlzhbjii
         haBy3hS0ZeHzGXthkXh+z7B94B4/tzqQNYumlcuEtptAvsIy3m40i7MmupAeAkEqgsXO
         IAw+EKE0aEzv9zZo3mMDCfM8r0z8C3hiTJ5KEpF+Rbvf1eDgwufih4pKtPyOya04pRkR
         bekPOiSSEvWyjteotPedSEa/pUVDoksCrC/yNPwod9tOClDXs81EUIpnyYhw9yhVFWKO
         z9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724310868; x=1724915668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jy8AvBGPXewIN0f06tSdN0J5TZbHLAwXxEIbEfEZm70=;
        b=wj8StzBD70GncDzdpRslekaKRkcLy7cONc5OkJAckNk5pInt9lneVryZnU+XsnZ/Wx
         dbV6uJJVaS80+cLw11b3nEOGYHWwkGhIimLBmwAHJnRLfYucujV0wdH96Q9X1IrxHzgp
         78+0euUrNoO+sCWeskEzjLvLCCQ4r5Qup063WjtrAxUK6rHXx0Qwl4NFtNjQGfXvkMKi
         DbreuYj9xDQAkdwGLgkkP4XdiGeUD5AVV1PN01C0bEwYUpEjoG+sDjQCLHYXMQ0LSLS4
         WR9OfG4f/0k1ao2KxQjMs+657/8VHzCkIRm1T8+kbIoLXZYFN2jA0tF83m57DTOmycMg
         MbKw==
X-Gm-Message-State: AOJu0Yzt/SjDaP9yd+Rl//SxIlyfQlZHEMIETNKiNqu6ESkGsIB80SF0
	FtMr/PQ/v1/z9UBQe50vAdXyo6+XN6hkPd1oJ9Z0/hD9/b7YmgerszwzAWq4UD8=
X-Google-Smtp-Source: AGHT+IEV/3obR+4TCbDGR6rVI1h9FT7v1/u/+fxVcK1o1ztnph09CHD4OJqmjxMXnPNwi8/vaSiIPQ==
X-Received: by 2002:a05:6a21:6b0a:b0:1c0:e728:a99e with SMTP id adf61e73a8af0-1cada078d94mr5247385637.26.1724310868515;
        Thu, 22 Aug 2024 00:14:28 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([240e:473:c90:f96:d029:ea8a:4e6d:d272])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ac994a3sm695095a12.16.2024.08.22.00.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 00:14:28 -0700 (PDT)
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
Subject: [PATCH v2 07/14] mm: khugepaged: collapse_pte_mapped_thp() use pte_offset_map_rw_nolock()
Date: Thu, 22 Aug 2024 15:13:22 +0800
Message-Id: <c377dab2bf55950e6155ea051aba3887ed5a2773.1724310149.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1724310149.git.zhengqi.arch@bytedance.com>
References: <cover.1724310149.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In collapse_pte_mapped_thp(), we may modify the pte and pmd entry after
acquring the ptl, so convert it to using pte_offset_map_rw_nolock(). At
this time, the write lock of mmap_lock is not held, and the pte_same()
check is not performed after the PTL held. So we should get pgt_pmd and do
pmd_same() check after the ptl held.

For the case where the ptl is released first and then the pml is acquired,
the PTE page may have been freed, so we must do pmd_same() check before
reacquiring the ptl.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/khugepaged.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 53bfa7f4b7f82..15d3f7f3c65f2 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1604,7 +1604,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	if (userfaultfd_armed(vma) && !(vma->vm_flags & VM_SHARED))
 		pml = pmd_lock(mm, pmd);
 
-	start_pte = pte_offset_map_nolock(mm, pmd, haddr, &ptl);
+	start_pte = pte_offset_map_rw_nolock(mm, pmd, haddr, &pgt_pmd, &ptl);
 	if (!start_pte)		/* mmap_lock + page lock should prevent this */
 		goto abort;
 	if (!pml)
@@ -1612,6 +1612,9 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	else if (ptl != pml)
 		spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
 
+	if (unlikely(!pmd_same(pgt_pmd, pmdp_get_lockless(pmd))))
+		goto abort;
+
 	/* step 2: clear page table and adjust rmap */
 	for (i = 0, addr = haddr, pte = start_pte;
 	     i < HPAGE_PMD_NR; i++, addr += PAGE_SIZE, pte++) {
@@ -1657,6 +1660,16 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	/* step 4: remove empty page table */
 	if (!pml) {
 		pml = pmd_lock(mm, pmd);
+		/*
+		 * We called pte_unmap() and release the ptl before acquiring
+		 * the pml, which means we left the RCU critical section, so the
+		 * PTE page may have been freed, so we must do pmd_same() check
+		 * before reacquiring the ptl.
+		 */
+		if (unlikely(!pmd_same(pgt_pmd, pmdp_get_lockless(pmd)))) {
+			spin_unlock(pml);
+			goto pmd_change;
+		}
 		if (ptl != pml)
 			spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
 	}
@@ -1688,6 +1701,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 		pte_unmap_unlock(start_pte, ptl);
 	if (pml && pml != ptl)
 		spin_unlock(pml);
+pmd_change:
 	if (notified)
 		mmu_notifier_invalidate_range_end(&range);
 drop_folio:
-- 
2.20.1


