Return-Path: <linux-kernel+bounces-432979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 144529E528E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3B26284A5E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311041D9A7E;
	Thu,  5 Dec 2024 10:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DXLh/qBo"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62481F429B
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 10:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395106; cv=none; b=tgD14WWMK9vTPkeNH5X/wj+dW8wo+GFTdUfwCE5OvObu/YcQ2Ref6m9LtyBGaiRXtzMHevkMz5wvRt/bPTiZyzVzjHRPit+nZGfJLuij/y9q6CHQneMQnOAKzi0n2vl9omvYhvGVnGpmv1kfSvBCIOBo0Xoj96TeD6v0U1R3Y/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395106; c=relaxed/simple;
	bh=gGgNHGAQnglp1EwvvnTVsa9Hle1YBo1yufwyIxTF2p8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GdCL2c89J/CqbVurJ64j1qtRP8Dw7f8Rg/0crYqM8uP7PbzpclDm24FD4tssVjRTk7F2uqI5FLt2bhqTxUDSd5XQ1/b79N9xH9KQYiFNaXC72ipvw4+eWSMsKGgGlOtqjspUWY4qPFEz3U2h34lWa61EXHSVc0+6cAad8/cq+8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DXLh/qBo; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-29e2a50586dso494572fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 02:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733395104; x=1733999904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIMWQ57ZznUQuD/aiNRYDz3W26VtFUEaOqg8e4FokQk=;
        b=DXLh/qBoWmGDI+SaL7Am02hvd+ZaDvBZUsJI9APctF4J8z3/9S6NBrIBj7RtZktLBi
         +FD4BFS891G5VODXJqFMrOSXbOQAMezUClFXvYpA05bjDtXwRuWtYU6iBWO/qe3YM9oR
         Vk7XWKKfuUy2Icikj78OXZoUkpGKwBsXQT+jq1QopN6yR8Xz44m0D7fu+K2mhRste9aN
         RmZe77KFtORid+0U9s9Udp8nBPhx+GXYCRBWEIR4o9x/UqrXGpzfjmwVvNcp9tBVa47F
         1jf0e5oucD6BojArdtA9663v0AdqRhwV5ZMU9jjWw0GWnvhy1xj4UMOErxBA1TRXy8dM
         BJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733395104; x=1733999904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XIMWQ57ZznUQuD/aiNRYDz3W26VtFUEaOqg8e4FokQk=;
        b=cuX3xQAmZEoiUwRyhGtWxKbhYxk8kPE1gD4c6Ooiyn9yu8aPzp5PGxc1xm8UA/khVr
         9XQMqt3YuNbv8a/Tk8o3a7buZ29d/DN3bnsL9h24x2ySzg/t/UcgSJeR+9iJ42BD6tyo
         25ayqiaVnjqcZ+Y7U+XMWfStkXE0tZHw+xIm/Kztq9J1u58gaJK3zYNc4uAxnv71EWix
         q1zFk+WnSyfJ/0vhZEVkgBukYKKdF70Sn4mO1o4pkEpJrAw35a7qYtVSrixN2061TbkJ
         jI8HWwtdTo3gQEhAd797hGZrggOiKcMkPHhEsyLcmFzluSKXfybFamRgdr2900uZmnuY
         o0ZA==
X-Forwarded-Encrypted: i=1; AJvYcCVN6Ow67FOzHFteY3HmR12URk8nmtfUuXCuck5+Gv9xEF7ki1ZF2+bTnXrM8AFmkfcAO7z4ao7Ib0HXCUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA+R6AsGYbeInT00Z3RzEaBOXvJJOzIG6M9qp0bur6+hp9zdi6
	seoAfGxhnAHdDPhkKoXebD0tz0s+E6PzGLiJ7zjPo0alK9zrQYoCGgYnL5a9ZRk=
X-Gm-Gg: ASbGnctolwQMzr+KLW/5OS+tGTPMnAkH1LLMY2yyCABPsjuHmS0MoBzPE4P9Xa7AEcm
	uVj3x3UaUOn3wR1ED5BUjl6kQt3RfOFOidPRvzlOPwShCCywAxzstBOznfM8Z1c9ts/Kseepq9m
	HN2OknsSjhBrFUEjTdxhjA/WFgJF05hyKowffamKqbxWNEFLpTpMr5M7x1KKiMdrUAnoGrlNHpd
	IOooKKPd3KbujjP08cYMDfTctPpvO0iJuNcPBXCtUdUHyW6WOOU9b2vGplRmyIG1rwkmn0OX1ov
	1BjPF3yld8EKvm6r37pv78dOHgi04lnB
X-Google-Smtp-Source: AGHT+IFGD682lN2KXS9mZyYiAgPgUddfTIrz2tftbpWLW1OwVDgKSjli0UbK/dW/c1XvobnxdhptFQ==
X-Received: by 2002:a05:6870:4944:b0:29d:c5e8:e41f with SMTP id 586e51a60fabf-29e88576409mr11051212fac.5.1733395103681;
        Thu, 05 Dec 2024 02:38:23 -0800 (PST)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd156f048csm886826a12.39.2024.12.05.02.38.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Dec 2024 02:38:23 -0800 (PST)
From: Xu Lu <luxu.kernel@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	ardb@kernel.org,
	anup@brainfault.org,
	atishp@atishpatra.org
Cc: xieyongji@bytedance.com,
	lihangjing@bytedance.com,
	punit.agrawal@bytedance.com,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC PATCH v2 11/21] riscv: mm: Reimplement mk_huge_pte function
Date: Thu,  5 Dec 2024 18:37:19 +0800
Message-Id: <20241205103729.14798-12-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241205103729.14798-1-luxu.kernel@bytedance.com>
References: <20241205103729.14798-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Huge pte can be pud, pmd, or svnapot pte. Huge ptes from different page
table levels have different pte constructors. This commit reimplements
mk_huge_pte function. We take vma struct as argument to check the target
huge pte level and applying corresponding constructor.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/hugetlb.h |  5 +++++
 arch/riscv/mm/hugetlbpage.c      | 23 ++++++++++++++++++++++-
 arch/s390/include/asm/hugetlb.h  |  2 +-
 include/asm-generic/hugetlb.h    |  5 ++++-
 mm/debug_vm_pgtable.c            |  2 +-
 mm/hugetlb.c                     |  4 ++--
 6 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/hugetlb.h b/arch/riscv/include/asm/hugetlb.h
index faf3624d8057..eafd00f4b74f 100644
--- a/arch/riscv/include/asm/hugetlb.h
+++ b/arch/riscv/include/asm/hugetlb.h
@@ -51,6 +51,11 @@ pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags);
 
 #endif /*CONFIG_RISCV_ISA_SVNAPOT*/
 
+#ifdef CONFIG_RISCV_USE_SW_PAGE
+#define __HAVE_ARCH_MK_HUGE_PTE
+pte_t mk_huge_pte(struct vm_area_struct *vma, struct page *page, pgprot_t pgprot);
+#endif
+
 #include <asm-generic/hugetlb.h>
 
 #endif /* _ASM_RISCV_HUGETLB_H */
diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index 42314f093922..8896c28ec881 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -2,6 +2,27 @@
 #include <linux/hugetlb.h>
 #include <linux/err.h>
 
+#ifdef CONFIG_RISCV_USE_SW_PAGE
+pte_t mk_huge_pte(struct vm_area_struct *vma, struct page *page, pgprot_t pgprot)
+{
+	pte_t pte;
+	unsigned int shift = huge_page_shift(hstate_vma(vma));
+
+	if (shift == PGDIR_SHIFT)
+		pte = pgd_pte(pfn_pgd(page_to_pfn(page), pgprot));
+	else if (shift == P4D_SHIFT)
+		pte = p4d_pte(pfn_p4d(page_to_pfn(page), pgprot));
+	else if (shift == PUD_SHIFT)
+		pte = pud_pte(pfn_pud(page_to_pfn(page), pgprot));
+	else if (shift == PMD_SHIFT)
+		pte = pmd_pte(pfn_pmd(page_to_pfn(page), pgprot));
+	else
+		pte = pfn_pte(page_to_pfn(page), pgprot);
+
+	return pte;
+}
+#endif /* CONFIG_RISCV_USE_SW_PAGE */
+
 #ifdef CONFIG_RISCV_ISA_SVNAPOT
 pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
@@ -74,7 +95,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
 
 out:
 	if (pte) {
-		pte_t pteval = ptep_get_lockless(pte);
+		pte_t pteval = ptep_get(pte);
 
 		WARN_ON_ONCE(pte_present(pteval) && !pte_huge(pteval));
 	}
diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetlb.h
index cf1b5d6fb1a6..cea9118d4bba 100644
--- a/arch/s390/include/asm/hugetlb.h
+++ b/arch/s390/include/asm/hugetlb.h
@@ -79,7 +79,7 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 	__set_huge_pte_at(mm, addr, ptep, pte_wrprotect(pte));
 }
 
-static inline pte_t mk_huge_pte(struct page *page, pgprot_t pgprot)
+static inline pte_t mk_huge_pte(struct vm_area_struct *vma, struct page *page, pgprot_t pgprot)
 {
 	return mk_pte(page, pgprot);
 }
diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index 594d5905f615..90765bc03bba 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -5,10 +5,13 @@
 #include <linux/swap.h>
 #include <linux/swapops.h>
 
-static inline pte_t mk_huge_pte(struct page *page, pgprot_t pgprot)
+#ifndef __HAVE_ARCH_MK_HUGE_PTE
+static inline pte_t mk_huge_pte(struct vm_area_struct *vma, struct page *page,
+				pgprot_t pgprot)
 {
 	return mk_pte(page, pgprot);
 }
+#endif
 
 static inline unsigned long huge_pte_write(pte_t pte)
 {
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 1cec548cc6c7..24839883d513 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -919,7 +919,7 @@ static void __init hugetlb_basic_tests(struct pgtable_debug_args *args)
 	 * as it was previously derived from a real kernel symbol.
 	 */
 	page = pfn_to_page(args->fixed_pmd_pfn);
-	pte = mk_huge_pte(page, args->page_prot);
+	pte = mk_huge_pte(args->vma, page, args->page_prot);
 
 	WARN_ON(!huge_pte_dirty(huge_pte_mkdirty(pte)));
 	WARN_ON(!huge_pte_write(huge_pte_mkwrite(huge_pte_wrprotect(pte))));
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 190fa05635f4..2b33eb46408f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5140,10 +5140,10 @@ static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,
 	unsigned int shift = huge_page_shift(hstate_vma(vma));
 
 	if (writable) {
-		entry = huge_pte_mkwrite(huge_pte_mkdirty(mk_huge_pte(page,
+		entry = huge_pte_mkwrite(huge_pte_mkdirty(mk_huge_pte(vma, page,
 					 vma->vm_page_prot)));
 	} else {
-		entry = huge_pte_wrprotect(mk_huge_pte(page,
+		entry = huge_pte_wrprotect(mk_huge_pte(vma, page,
 					   vma->vm_page_prot));
 	}
 	entry = pte_mkyoung(entry);
-- 
2.20.1


