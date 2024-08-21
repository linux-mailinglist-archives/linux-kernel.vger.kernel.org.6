Return-Path: <linux-kernel+bounces-295112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287169596F2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0A64280F8F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 08:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6924D1C8FC9;
	Wed, 21 Aug 2024 08:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Spf+cYDM"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6551BAEFD
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 08:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724228416; cv=none; b=akg6qWG0BweRjE2T9qPjPqJWTsB5gd5DNNVwVz/wp9ha6yKuoH7XbcdEDfU8Sp1rYfO2I5tEKBDpjpj43eOnloEHF7Hk5CcL9yxYx7DPPn0Hmlmff++rheX9GrRG4wMmp7VHXbX8EPV68HnxU2Q4xSj+O4H/9DXxAZJNVBNYrOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724228416; c=relaxed/simple;
	bh=whO6kmMVZ3486illXrVIP3CwwypQL42Bi9p6yT8iY8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eS9KuKh++CXiarZIbPaHYnO0KE22CLIeZ1pegub1Y+WodhV1AqYNlgczycarDR1dtgThdmfJ630M0m1OxwBO83gK8ZNd9PfxUUMNgc4K4iGbG8YIyxenc0d+Fj5UF4zHUaO6fHb/PC2CIiRq4lYL8sdhBmRMVgJpgTkkey7QsoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Spf+cYDM; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d3c0d587e4so4493302a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 01:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724228414; x=1724833214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATsR6rCpxZFOFORcauHss5xESVmegH/7Abibhpgyw90=;
        b=Spf+cYDM7v5YuObDC/7Wvl7J+Y6efhPsBIodCd6xlN7kDe7LUtMFYK/FZ3S0KvIjpf
         D6UZSjjbNIWvz6d766vR0fpiGoUuU7EwwyhdHks6zXIwWOxF81h9yMa8w3LdAcmYPqZa
         ciC4atuTiu1GgKYnc7kZvXBCYa+38CxQxp5bWwB51/s9M4iFqluKAlvkIlUMQsX1DwRp
         //L9QTP4dTCV0RPmWZTAw7fN6oVAqyKMAj7Z0OnvdvQVlA/wbyxjxukMpnKLtzmE4O9l
         9DxNm6HSiYSM9jjG9TO04mQKcTV0JiJWQmHtZGjWzI8hLlF+BWgyuk4jFIXOnjVYbLlf
         obWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724228414; x=1724833214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ATsR6rCpxZFOFORcauHss5xESVmegH/7Abibhpgyw90=;
        b=ZEzuUHgGxfgtoQ1i61GoTrGUHFN/HF0v7Iw8viEm2opfzFGPOPjHrwB6TuG+Cnnpd+
         el+24IXL9r41drm/zeH2caDVdfE6Sc8VnOAxB1SgKtScVIwKOzSZGImnRRkzliouRov2
         s5ubW4ZBauS7NXeh1hzYm4Sbg2qXFhjufksKxBiloC88AAQZdG3BUeP2g01gZP5s275Z
         r7cwxZxPRvBdWamVHemsL0E3KJlrihROFAasMZuBI6s4ClbUZ7Bse2vOKwPvVJaeQ2v9
         hvJC4sg6X3XEpWgFN1O0csVahhC3JGtqjI7s6LaR2wtmAL4+t+EjDYTK1rMFf+p6E24G
         vi5Q==
X-Gm-Message-State: AOJu0YzP8RNDQ4c7H0kScMjqxhHFCd/MdRLg5h6s5bsA6XBXRADLhV20
	A49ME38uX8GNuk1fkEXZZ2XgWzkTvbm1bH1GCESs1GQQhhrFlSYvFVDS/qmG+yE=
X-Google-Smtp-Source: AGHT+IEASO/tYfbmKEqODBO5ptoLkIYqajvyb9bjTzXqrTBGFe58odiOJRUvoUKiSb3oI+1Cc8Ov6A==
X-Received: by 2002:a17:90b:1c01:b0:2c9:9658:d704 with SMTP id 98e67ed59e1d1-2d5ea4c9ab9mr1366119a91.40.1724228414402;
        Wed, 21 Aug 2024 01:20:14 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eb9049b0sm1091453a91.17.2024.08.21.01.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 01:20:14 -0700 (PDT)
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
Subject: [PATCH 07/14] mm: khugepaged: collapse_pte_mapped_thp() use pte_offset_map_maywrite_nolock()
Date: Wed, 21 Aug 2024 16:18:50 +0800
Message-Id: <b71a4053e28d1b0858b6315fb78b9918948b595e.1724226076.git.zhengqi.arch@bytedance.com>
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

In collapse_pte_mapped_thp(), we may modify the pte and pmd entry after
acquring the ptl, so convert it to using pte_offset_map_maywrite_nolock().
At this time, the write lock of mmap_lock is not held, and the pte_same()
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
index 26c083c59f03f..8fcad0b368a08 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1602,7 +1602,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	if (userfaultfd_armed(vma) && !(vma->vm_flags & VM_SHARED))
 		pml = pmd_lock(mm, pmd);
 
-	start_pte = pte_offset_map_nolock(mm, pmd, haddr, &ptl);
+	start_pte = pte_offset_map_maywrite_nolock(mm, pmd, haddr, &pgt_pmd, &ptl);
 	if (!start_pte)		/* mmap_lock + page lock should prevent this */
 		goto abort;
 	if (!pml)
@@ -1610,6 +1610,9 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	else if (ptl != pml)
 		spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
 
+	if (unlikely(!pmd_same(pgt_pmd, pmdp_get_lockless(pmd))))
+		goto abort;
+
 	/* step 2: clear page table and adjust rmap */
 	for (i = 0, addr = haddr, pte = start_pte;
 	     i < HPAGE_PMD_NR; i++, addr += PAGE_SIZE, pte++) {
@@ -1655,6 +1658,16 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
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
@@ -1686,6 +1699,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 		pte_unmap_unlock(start_pte, ptl);
 	if (pml && pml != ptl)
 		spin_unlock(pml);
+pmd_change:
 	if (notified)
 		mmu_notifier_invalidate_range_end(&range);
 drop_folio:
-- 
2.20.1


