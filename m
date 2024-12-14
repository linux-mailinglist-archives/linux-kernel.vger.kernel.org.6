Return-Path: <linux-kernel+bounces-445942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C99B9F1DB2
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 10:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59D8188BD71
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 09:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBEE190052;
	Sat, 14 Dec 2024 09:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cZW3/K2A"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5191619006F
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 09:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734167093; cv=none; b=HRjNFX+zFe0wfjPd1+nalmAW7PcIhJ5DAcwAhwE6PY0HH/ueVpJ3abDA9QMN6QpNRtyETKUBLPE8fVIX4e7/MHoZwpWd+u+MebXMlAs9HJheRWPuadAtxaOOp5Dftpedx6nSB8eA6IiLUqbTEGjFNnoncmDLIlHVyx51BhWCm+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734167093; c=relaxed/simple;
	bh=jFNmc4kjscGFNYYuudEQBS5d2YJZz2PscMxH+hm6jto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EC520ULqtBzPMh9I2ciXuCcX5G+C+kkloGTY4l99MnvcnGB/he2uw7ozzGlUQCvNbqAkHJzeUNbfa9YOODD3mnEdsLP1yQbbFLTdi+fiCdD1M+mvk7xSrLgeNqdq9GFdlYjnLCz0lGeTEwR0RCsCQ/KOgFYs0nrGhAKSdddvKVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cZW3/K2A; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ee9a780de4so1655458a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 01:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734167090; x=1734771890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxcjg+YJiLOjdKwLGOoVz8JWl+VadyRpr3tadtBHjWA=;
        b=cZW3/K2AaBgWOSre/2646RA7Q2SCn1FlCoJ6EWQqP9Kci4+XwHSyIQZarsfd527o6d
         p5SZunJpyzEDdG/tCOVg7RDvbNpv0ZCeBU7eDAVIeRBBGHNa+UFBcVOyj27fHXvguw47
         KZBjfdT3Rw1R+GFrB/OpyOkG/1eYbTMtxgyElPIDKJNg6GfafAeppv5E2RTOUs8paoSX
         0BHxZmCCE0WRqhzFzlZ1mHBVvuM1nuTbOhfAjWKvLJejKL/T37gpQOAO5uiyfI/fgRnX
         CYUhCCe9M5Db89udM8CDO5X8DFSRVw6EiqEDk+hvR98fBD5WCf/X7doKETDnW1N7PsyR
         6pBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734167090; x=1734771890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kxcjg+YJiLOjdKwLGOoVz8JWl+VadyRpr3tadtBHjWA=;
        b=mmopsmNz1H7E/n0DEJpQgNmYWNhannbHhrUDdjQ/VqewtHAFaxKGHej3TtENEqNXA5
         IU3b0hOey6INeCCCag9BgPlE1SPcNTz+Qlj79yWjjzPuKPdf1KrIo14heHTntP55qgll
         Ebi/aJBuAuq9Sds4DMaqHWPmJpzUZgiibQ8zrkBB96+tak+Lj4AgfkkgAGvojok9/lAH
         /S3DCThufX7Evr/LlwiflZE1eBFr37wECxd0HKEz9ab3WYfjWUSAnAI0fYl7juk/aNJR
         Y3xHlWatIw6OLCnNNhBDuRWqce4iTWEqPi2pATgpkMym59sbyMaaoy4BSbwzY03KUC4f
         PBEQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+84p8KnMGT/yr9IeaRynekD/LUPCRH5Ae3XtDkWm+zVbEDb6TvzS2nIs0nsGCHKKG/Alg4eUBCvvyiaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxDOOJXjlJ29wzf+I5qy35GgAiapNudm3lyop64CvASaoEF9jZ
	9gi+tvjg/4rSXRocnrey+2hsVYAGRfoBP1j6YNKcj3+TF4QrIbx+Ua71pTP/494=
X-Gm-Gg: ASbGncsQTKT0xEXm4CQhsE6kIZIRiB1mA6bJgVI/VARBCThLbx/Nd7Wt2a5iAAmdro3
	6DBLavA9VJD0cM5Jfa9Mq/+VwYk1BOYeYVdSPrB1m1iX2NUDS4AVcVVCPjypL7HJw29gueDQiNw
	3MSwfpU7pQBB0fgyrso9vP49+3j9JgUyi9G/mVRr2XLC2o1DOPZIIEa4zFH/3767/gs++xNVeh2
	2Q18fTQ2+2mbJR10NI5AldV6qsdImEk3kqPyIOcQM2FLG57sVQlDXz/lHCN4iUt88GwfvecESvt
	SKFn7N4feHrsWhUr75eKdFjY3rX6wA==
X-Google-Smtp-Source: AGHT+IGmWNhert5ebnmEBEANehnSTDBWCLVNkF+841k1TH0tjB/D3zS21KwZ8s5YJg+vyRMQfoaR6w==
X-Received: by 2002:a17:90b:3b52:b0:2ef:2d9f:8e55 with SMTP id 98e67ed59e1d1-2f28fd66b3dmr9591223a91.17.1734167090585;
        Sat, 14 Dec 2024 01:04:50 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([2409:8a28:f4f:a9a4:5d46:4ef0:daa9:1db8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5a90ba0sm905731a12.16.2024.12.14.01.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 01:04:50 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	tglx@linutronix.de,
	david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	yuzhao@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	lorenzo.stoakes@oracle.com,
	akpm@linux-foundation.org,
	rientjes@google.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	linux-riscv@lists.infradead.org
Subject: [PATCH 08/12] riscv: pgtable: move pagetable_dtor() to __tlb_remove_table()
Date: Sat, 14 Dec 2024 17:02:54 +0800
Message-Id: <1e73cf87193d838c64e402896b4252875c212986.1734164094.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1734164094.git.zhengqi.arch@bytedance.com>
References: <cover.1734164094.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move pagetable_dtor() to __tlb_remove_table(), so that ptlock and page
table pages can be freed together (regardless of whether RCU is used).
This prevents the use-after-free problem where the ptlock is freed
immediately but the page table pages is freed later via RCU.

Page tables shouldn't have swap cache, so use pagetable_free() instead of
free_page_and_swap_cache() to free page table pages.

By the way, move the comment above __tlb_remove_table() to
riscv_tlb_remove_ptdesc(), it will be more appropriate.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: linux-riscv@lists.infradead.org
---
 arch/riscv/include/asm/pgalloc.h | 38 ++++++++++++++------------------
 arch/riscv/include/asm/tlb.h     | 14 ++++--------
 2 files changed, 21 insertions(+), 31 deletions(-)

diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index 09c2eff571a49..fc50d14010246 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -18,12 +18,22 @@
 #define __HAVE_ARCH_P4D_FREE
 #include <asm-generic/pgalloc.h>
 
+/*
+ * While riscv platforms with riscv_ipi_for_rfence as true require an IPI to
+ * perform TLB shootdown, some platforms with riscv_ipi_for_rfence as false use
+ * SBI to perform TLB shootdown. To keep software pagetable walkers safe in this
+ * case we switch to RCU based table free (MMU_GATHER_RCU_TABLE_FREE). See the
+ * comment below 'ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE' in include/asm-generic/tlb.h
+ * for more details.
+ */
 static inline void riscv_tlb_remove_ptdesc(struct mmu_gather *tlb, void *pt)
 {
-	if (riscv_use_sbi_for_rfence())
+	if (riscv_use_sbi_for_rfence()) {
 		tlb_remove_ptdesc(tlb, pt);
-	else
+	} else {
+		pagetable_dtor(pt);
 		tlb_remove_page_ptdesc(tlb, pt);
+	}
 }
 
 static inline void pmd_populate_kernel(struct mm_struct *mm,
@@ -109,12 +119,8 @@ static inline void pud_free(struct mm_struct *mm, pud_t *pud)
 static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 				  unsigned long addr)
 {
-	if (pgtable_l4_enabled) {
-		struct ptdesc *ptdesc = virt_to_ptdesc(pud);
-
-		pagetable_dtor(ptdesc);
-		riscv_tlb_remove_ptdesc(tlb, ptdesc);
-	}
+	if (pgtable_l4_enabled)
+		riscv_tlb_remove_ptdesc(tlb, virt_to_ptdesc(pud));
 }
 
 #define p4d_alloc_one p4d_alloc_one
@@ -136,12 +142,8 @@ static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
 static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
 				  unsigned long addr)
 {
-	if (pgtable_l5_enabled) {
-		struct ptdesc *ptdesc = virt_to_ptdesc(p4d);
-
-		pagetable_dtor(ptdesc);
+	if (pgtable_l5_enabled)
 		riscv_tlb_remove_ptdesc(tlb, virt_to_ptdesc(p4d));
-	}
 }
 #endif /* __PAGETABLE_PMD_FOLDED */
 
@@ -170,10 +172,7 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
 				  unsigned long addr)
 {
-	struct ptdesc *ptdesc = virt_to_ptdesc(pmd);
-
-	pagetable_dtor(ptdesc);
-	riscv_tlb_remove_ptdesc(tlb, ptdesc);
+	riscv_tlb_remove_ptdesc(tlb, virt_to_ptdesc(pmd));
 }
 
 #endif /* __PAGETABLE_PMD_FOLDED */
@@ -181,10 +180,7 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 				  unsigned long addr)
 {
-	struct ptdesc *ptdesc = page_ptdesc(pte);
-
-	pagetable_dtor(ptdesc);
-	riscv_tlb_remove_ptdesc(tlb, ptdesc);
+	riscv_tlb_remove_ptdesc(tlb, page_ptdesc(pte));
 }
 #endif /* CONFIG_MMU */
 
diff --git a/arch/riscv/include/asm/tlb.h b/arch/riscv/include/asm/tlb.h
index 1f6c38420d8e0..ded8724b3c4f7 100644
--- a/arch/riscv/include/asm/tlb.h
+++ b/arch/riscv/include/asm/tlb.h
@@ -11,19 +11,13 @@ struct mmu_gather;
 static void tlb_flush(struct mmu_gather *tlb);
 
 #ifdef CONFIG_MMU
-#include <linux/swap.h>
 
-/*
- * While riscv platforms with riscv_ipi_for_rfence as true require an IPI to
- * perform TLB shootdown, some platforms with riscv_ipi_for_rfence as false use
- * SBI to perform TLB shootdown. To keep software pagetable walkers safe in this
- * case we switch to RCU based table free (MMU_GATHER_RCU_TABLE_FREE). See the
- * comment below 'ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE' in include/asm-generic/tlb.h
- * for more details.
- */
 static inline void __tlb_remove_table(void *table)
 {
-	free_page_and_swap_cache(table);
+	struct ptdesc *ptdesc = (struct ptdesc *)table;
+
+	pagetable_dtor(ptdesc);
+	pagetable_free(ptdesc);
 }
 
 #endif /* CONFIG_MMU */
-- 
2.20.1


