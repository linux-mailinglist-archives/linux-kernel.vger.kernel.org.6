Return-Path: <linux-kernel+bounces-563528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AA6A6437C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41D7F1890E97
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B32521ADA4;
	Mon, 17 Mar 2025 07:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="2lhYLSly"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C580A21ABCC
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 07:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742196361; cv=none; b=rI7bpuL8aV02OuT5Gqd3Yb8CCQZOV++SbjZYVLVckxRDS5sZ+bYAen+2bEKzvmzeuu1IY6V6TdbFSvBsyzDjmh/2ZsMEHqrFBF8s8h3C1pZFCG8b+L7ouRmQncHpWZ3brL8kdA3kbe4Nzw62b9VKoNnXQ7UYWqbwGd5E+750mKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742196361; c=relaxed/simple;
	bh=WLAseXMIobgoPi2SfhEUrHpYJNesug4mAmigjE7aaTM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZSV10gbc3GyNUK6eyyQ7JnX4g/yfAqhQRG7xt08kT3/n12+ZMnWV+6HRVE08Dc1tVVqzn+wOyMwfj8ZX39WxZx6xUhrZYTXTGSrxFXpsbVyjdXa5GpHCCQ9O2zd9GUfImDKUSET1YD6kzCF1Bm8yIMmBk+CEG75v2r4xwxsB1VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=2lhYLSly; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39143200ddaso2506575f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 00:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742196357; x=1742801157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l2Rgxfmy4wvi0IV1iIeDi36GnLsMRf14zDXApk09KVM=;
        b=2lhYLSlySA42bxDoziQbgLFYlj3wNDWf6JlYZD1g9KAXZVdQb/BC1xrMMTRyDGOtxx
         t5o/ojm7L9gS2JNt0XjHo+18ojzV31pLO1x2kQtq2dzw/+vGiiP+dLr445HJYGuWw8KR
         15yfTBzHO5puChIv5R+KVfTnisIEtHnHGJYXoFHaTZcPQswmwE6SMsXBCwU8oXfQ96Lo
         woMqziodehrcYblxDQqppkz+ncUGLqCXobkeC9B9LoC2ej6ZX9PtdPPznxin0DXcWZGv
         vdVV2c1QqjMkRgukad07htpspd8eJKyoYh21Dkl11IUPbkMyp+vMYx7elJ3iYIJY7Ucr
         tRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742196357; x=1742801157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l2Rgxfmy4wvi0IV1iIeDi36GnLsMRf14zDXApk09KVM=;
        b=hWiWrCOwt1poFRq0bdHQpZjBp/zmrSuIs5NIlY7GkDIJCMnVloP0CzUmZIaRrKHDq8
         SJjCmQ1JDdmRyhedna7kO/jvzpAubcH2FBMChIazFSuKuzWOT7j1TKQDq7NeEEBjHbZG
         YzY6dUAbo/XvU5L9hBoWalfCveea/FEWrzLVUOO+aRtfweMkpWb9VEb858TtT3f6bHuE
         15oewdaRHrsx+Io5/vbNSNkDBGHDyjTXKmltfqGeGvyPD+xTatV4XSbpduaYjKOurs0c
         BavF/8beuPcC48TLoxvnlE8cKYsQt4baQ4Zsh7Er4h+RC6Z1y+I7Uyu0dHdQLSnHI+vm
         8X6g==
X-Forwarded-Encrypted: i=1; AJvYcCUgXv+mNFr59q3mXPW/dlC88g5eYExYqguz2PUa2eYtRCutcOKrHghLUNpHHgx1vHngKZ1JY5YqO4Gu13g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywflnjhe9PEHqdJiv4gCr0laz5L0o/nPHZne//dCzm9TL/B5QIW
	iir+amC+3EKCyRAtIZKcFbPqPuyJbM7h54LdpSJzn3v92MwwKhIG6vBri1neU+M=
X-Gm-Gg: ASbGncuonSs7f6lstugFF9dRMXJYd81udZaKJjO01j9ZZXxnb22C2KKS8atxrgMZcm/
	1v2v5zu6B1TUEQM4uVc9GiEP89nJijnEG6YYVIPNIyXChrKQ7T+9B4rdN+djo6AJw/gpzOKO7fl
	H+gv03Z0omAxoDlyMcrENgHvjbDMTgF3OsvMVvLJQ+0fflZIkWS7O5qS8wzrPy+cleEEdiFl2Bw
	vngTTcdsvfQ0qpdG/5A1ZUlmWPDrqFz6hiCFh+KyG4VXqvat0Z/M+oZtmxUSa7DGuY/MWbZ97RL
	01VkpzmXaaKQVg1BBAXt01ZNrSYuhcPAobsGF6iJA9+bVaGDmyT8e4mJyDA/bq7cmg==
X-Google-Smtp-Source: AGHT+IGFDMFLc6+xi+GWz3Dc64P/p7dYSStQUrPd9vMMUlqPXgkzGWncVuX7U3JZiTVznPWilKKpOg==
X-Received: by 2002:a05:6000:18a8:b0:391:2d8f:dd56 with SMTP id ffacd0b85a97d-3971ded3840mr11909327f8f.29.1742196356823;
        Mon, 17 Mar 2025 00:25:56 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com ([31.32.81.187])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8881187sm13887907f8f.41.2025.03.17.00.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 00:25:56 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Qinglin Pan <panqinglin2020@iscas.ac.cn>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH] riscv: Fix hugetlb retrieval of number of ptes in case of !present pte
Date: Mon, 17 Mar 2025 08:25:51 +0100
Message-Id: <20250317072551.572169-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ryan sent a fix [1] for arm64 that applies to riscv too: in some hugetlb
functions, we must not use the pte value to get the size of a mapping
because the pte may not be present.

So use the already present size parameter for huge_pte_clear() and the
newly introduced size parameter for huge_ptep_get_and_clear(). And make
sure to gather A/D bits only on present ptes.

Fixes: 82a1a1f3bfb6 ("riscv: mm: support Svnapot in hugetlb page")
Link: https://lore.kernel.org/all/20250217140419.1702389-1-ryan.roberts@arm.com/ [1]
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/mm/hugetlbpage.c | 76 ++++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 31 deletions(-)

diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index b4a78a4b35cf..375dd96bb4a0 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -148,22 +148,25 @@ unsigned long hugetlb_mask_last_page(struct hstate *h)
 static pte_t get_clear_contig(struct mm_struct *mm,
 			      unsigned long addr,
 			      pte_t *ptep,
-			      unsigned long pte_num)
+			      unsigned long ncontig)
 {
-	pte_t orig_pte = ptep_get(ptep);
-	unsigned long i;
-
-	for (i = 0; i < pte_num; i++, addr += PAGE_SIZE, ptep++) {
-		pte_t pte = ptep_get_and_clear(mm, addr, ptep);
-
-		if (pte_dirty(pte))
-			orig_pte = pte_mkdirty(orig_pte);
-
-		if (pte_young(pte))
-			orig_pte = pte_mkyoung(orig_pte);
+	pte_t pte, tmp_pte;
+	bool present;
+
+	pte = ptep_get_and_clear(mm, addr, ptep);
+	present = pte_present(pte);
+	while (--ncontig) {
+		ptep++;
+		addr += PAGE_SIZE;
+		tmp_pte = ptep_get_and_clear(mm, addr, ptep);
+		if (present) {
+			if (pte_dirty(tmp_pte))
+				pte = pte_mkdirty(pte);
+			if (pte_young(tmp_pte))
+				pte = pte_mkyoung(pte);
+		}
 	}
-
-	return orig_pte;
+	return pte;
 }
 
 static pte_t get_clear_contig_flush(struct mm_struct *mm,
@@ -212,6 +215,26 @@ static void clear_flush(struct mm_struct *mm,
 	flush_tlb_range(&vma, saddr, addr);
 }
 
+static int num_contig_ptes_from_size(unsigned long sz, size_t *pgsize)
+{
+	unsigned long hugepage_shift;
+
+	if (sz >= PGDIR_SIZE)
+		hugepage_shift = PGDIR_SHIFT;
+	else if (sz >= P4D_SIZE)
+		hugepage_shift = P4D_SHIFT;
+	else if (sz >= PUD_SIZE)
+		hugepage_shift = PUD_SHIFT;
+	else if (sz >= PMD_SIZE)
+		hugepage_shift = PMD_SHIFT;
+	else
+		hugepage_shift = PAGE_SHIFT;
+
+	*pgsize = 1 << hugepage_shift;
+
+	return sz >> hugepage_shift;
+}
+
 /*
  * When dealing with NAPOT mappings, the privileged specification indicates that
  * "if an update needs to be made, the OS generally should first mark all of the
@@ -226,22 +249,10 @@ void set_huge_pte_at(struct mm_struct *mm,
 		     pte_t pte,
 		     unsigned long sz)
 {
-	unsigned long hugepage_shift, pgsize;
+	size_t pgsize;
 	int i, pte_num;
 
-	if (sz >= PGDIR_SIZE)
-		hugepage_shift = PGDIR_SHIFT;
-	else if (sz >= P4D_SIZE)
-		hugepage_shift = P4D_SHIFT;
-	else if (sz >= PUD_SIZE)
-		hugepage_shift = PUD_SHIFT;
-	else if (sz >= PMD_SIZE)
-		hugepage_shift = PMD_SHIFT;
-	else
-		hugepage_shift = PAGE_SHIFT;
-
-	pte_num = sz >> hugepage_shift;
-	pgsize = 1 << hugepage_shift;
+	pte_num = num_contig_ptes_from_size(sz, &pgsize);
 
 	if (!pte_present(pte)) {
 		for (i = 0; i < pte_num; i++, ptep++, addr += pgsize)
@@ -295,13 +306,14 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 			      unsigned long addr,
 			      pte_t *ptep, unsigned long sz)
 {
+	size_t pgsize;
 	pte_t orig_pte = ptep_get(ptep);
 	int pte_num;
 
 	if (!pte_napot(orig_pte))
 		return ptep_get_and_clear(mm, addr, ptep);
 
-	pte_num = napot_pte_num(napot_cont_order(orig_pte));
+	pte_num = num_contig_ptes_from_size(sz, &pgsize);
 
 	return get_clear_contig(mm, addr, ptep, pte_num);
 }
@@ -351,6 +363,7 @@ void huge_pte_clear(struct mm_struct *mm,
 		    pte_t *ptep,
 		    unsigned long sz)
 {
+	size_t pgsize;
 	pte_t pte = ptep_get(ptep);
 	int i, pte_num;
 
@@ -359,8 +372,9 @@ void huge_pte_clear(struct mm_struct *mm,
 		return;
 	}
 
-	pte_num = napot_pte_num(napot_cont_order(pte));
-	for (i = 0; i < pte_num; i++, addr += PAGE_SIZE, ptep++)
+	pte_num = num_contig_ptes_from_size(sz, &pgsize);
+
+	for (i = 0; i < pte_num; i++, addr += pgsize, ptep++)
 		pte_clear(mm, addr, ptep);
 }
 
-- 
2.39.2


