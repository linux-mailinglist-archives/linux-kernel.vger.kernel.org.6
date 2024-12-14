Return-Path: <linux-kernel+bounces-445936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 348F39F1DAB
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 10:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E204168765
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 09:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAF617C7B1;
	Sat, 14 Dec 2024 09:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NxBUg6eP"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCE07EF09
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 09:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734167038; cv=none; b=OxaVS+cJoO+VuKkeKJT2fsS8iwQl7Qm47jpOzUJo5+KP0EtiKdrev00QZySuPRf6YIdTLrJ/012wZ+iIdNRYz2uVFFHlEoQDvmOUUuSAMEyYo8HNQfowcxV6IFMdmw7+xM1cvcQN43LhtwH6CHEdRV2vRgvPVhPsFeXkZpQvI/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734167038; c=relaxed/simple;
	bh=BYquZoRYPXNRHDL38YoR5kg8KSza8ULPTlVHq7lYXtE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HGHMdkjCE9rESj2WtQoRsi98BkRenmvydwru6GvnRVpDChNvfj9RYXJJMGcHGn8qHLeY3AKnE+mu94qkksfoyDg9adO66ghEiF0Qv7qb0D68gpr5mQZRZIzm68WMLnzAcCk/hn842SlJfsyREzE95Q//21+W74wtrhRwbAve3k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NxBUg6eP; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-725dac69699so2193213b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 01:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734167035; x=1734771835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ogKjScRTvWjbxx3zCDWukawvbFfMJH57eI/cAcIUhW0=;
        b=NxBUg6eP3z/QA5465yrtLOjY+clr3fWDwXvvL7o1zwvtmNi6Iz8fPHKsOHeKOtUIDQ
         gy8Zl994lcu4eTcWfhhpvpCds3S4+H/T1eaYOXMQXaHRmGHwMdnJQBulMuPsAW9xlqyw
         0aL9k9p1f8HD3w6dlbODRVuB22dITXZsGc59caDXxNvBWM3jV6iEpS1rthvlO8yh1Mnf
         DyZrAt2sM0yzxNKNiSXYmb6CQq29WOCbpX9gOZo9XvGlTQS36g54yqGXGR3K3XQn0F9Y
         fKi57jBnXOjPv9NaCfOpqqWTM/RkvnFfYFspIobJ6anHTVuXOCkJ+Rdyd6TWlmkWCDbr
         CPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734167035; x=1734771835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ogKjScRTvWjbxx3zCDWukawvbFfMJH57eI/cAcIUhW0=;
        b=HpT+qESp745LA0zjDMvI/beLucygEN8vnVm36JLJziZSXFeu5nOjJdY+w8MvTixjjx
         NlWRrS7awj4D4HxtOKdx+84GjV6IVOar4F1L9y3jkheN2cdkQB+rLQoziTzDWUGJjVzN
         I16/UtzAfrdLyCcGCG9L84SStcmbZn2ZlsnNlRDdZTESDA7Td2gjjM4zY8EexFvfvIcf
         4K05439fDvmjg+cF46KXldgg3j1LO7pHBbb1sOtfMF6wRQYzkNeYg657agsnzaFhCuJb
         erxAoO6d1HQZFS6UMjhTMzlGKfL22rMvPolgnqiKcQDCscm4Qyf0LNbsr67YZ49pL/+S
         R5kA==
X-Forwarded-Encrypted: i=1; AJvYcCUExFaIZQ7I43pdzfxwngcNlpO4yMeLk2xLnXgW3+DTxKWu2FCMW+t6sFgsfUCyr64vujC07KiTNTtZ+fI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQKLV+Nda4GL9WFsU1aft++Zx/OQaW6Kv+Hu4G8WkbpqsETgqK
	GJ7N9NIl20v4/4rzTfgQngr0TqEd7rgmGq5no8CVA/b6xJmqZ4C09AXShuAV5Wc=
X-Gm-Gg: ASbGncsixeau5wUeBJpZXr5lc8fwE9nCkudPRSFxtUDOL1kpqjTOG6IVpL/XLY81aRY
	jS+LhPw6ov60TrYUWdvjRWC0BlAQXIBFaAUYQ63d4hyVl18dxGeZPzrayntseGY6Fmo1jp0N26A
	KohHVl+9Mpies48pASSNvZLtvPmTyQxEiyRciYIviiyp7ftD61x33LWcdKmH4H7gA9PVvA3LAQR
	B9GYuEJ0t8QCsdb0wLBm02SUgrIZa6pV1p+hQKwzqh4KIEZEydyHXFZbebmgqmSs2YkfSicImSs
	KkzAkP7d4PdrNXE5QbPUX23dsmPWjg==
X-Google-Smtp-Source: AGHT+IH8cEofDdPO5AW+ExE/DB+fdraWijYPkixsUFC1j8JWg1c9+2I6Y5RryDFAZbl9xgKYU+lFhw==
X-Received: by 2002:a05:6a20:9f05:b0:1d9:6c9c:75ea with SMTP id adf61e73a8af0-1e1dfbfbe78mr8233213637.5.1734167035315;
        Sat, 14 Dec 2024 01:03:55 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([2409:8a28:f4f:a9a4:5d46:4ef0:daa9:1db8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5a90ba0sm905731a12.16.2024.12.14.01.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 01:03:54 -0800 (PST)
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
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 02/12] mm: pgtable: introduce generic p4d_alloc_one() and p4d_free()
Date: Sat, 14 Dec 2024 17:02:48 +0800
Message-Id: <c7faa125f6c40b58f4d35ef7b5413e8a64c0cb9c.1734164094.git.zhengqi.arch@bytedance.com>
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

Several architectures (arm64, riscv, x86) define p4d_alloc_one() as a
wrapper for get_zeroed_page() and p4d_free() as a wrapper for free_page().

For these architectures, provide a generic implementation in
asm-generic/pgalloc.h and convert them to use it. And like other levels
of page tables, add statistics for P4D level page table.

For s390, it also defines p4d_alloc_one() and p4d_free(), but it uses its
own logic, so skip it.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 arch/arm64/include/asm/pgalloc.h | 15 ++++-----
 arch/riscv/include/asm/pgalloc.h | 25 ++++++---------
 arch/x86/include/asm/pgalloc.h   | 16 ++++------
 arch/x86/mm/pgtable.c            |  3 ++
 include/asm-generic/pgalloc.h    | 55 ++++++++++++++++++++++++++++++++
 include/linux/mm.h               | 16 ++++++++++
 6 files changed, 98 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index e75422864d1bd..679c530549327 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -15,6 +15,8 @@
 
 #define __HAVE_ARCH_PGD_FREE
 #define __HAVE_ARCH_PUD_FREE
+#define __HAVE_ARCH_P4D_ALLOC_ONE
+#define __HAVE_ARCH_P4D_FREE
 #include <asm-generic/pgalloc.h>
 
 #define PGD_SIZE	(PTRS_PER_PGD * sizeof(pgd_t))
@@ -87,19 +89,16 @@ static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgdp, p4d_t *p4dp)
 
 static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	gfp_t gfp = GFP_PGTABLE_USER;
+	if (!pgtable_l5_enabled())
+		return NULL;
 
-	if (mm == &init_mm)
-		gfp = GFP_PGTABLE_KERNEL;
-	return (p4d_t *)get_zeroed_page(gfp);
+	return __p4d_alloc_one(mm, addr);
 }
 
 static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
 {
-	if (!pgtable_l5_enabled())
-		return;
-	BUG_ON((unsigned long)p4d & (PAGE_SIZE-1));
-	free_page((unsigned long)p4d);
+	if (pgtable_l5_enabled())
+		__p4d_free(mm, p4d);
 }
 
 #define __p4d_free_tlb(tlb, p4d, addr)  p4d_free((tlb)->mm, p4d)
diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index f52264304f772..bb6e1c5f1fb19 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -14,6 +14,8 @@
 #ifdef CONFIG_MMU
 #define __HAVE_ARCH_PUD_ALLOC_ONE
 #define __HAVE_ARCH_PUD_FREE
+#define __HAVE_ARCH_P4D_ALLOC_ONE
+#define __HAVE_ARCH_P4D_FREE
 #include <asm-generic/pgalloc.h>
 
 static inline void riscv_tlb_remove_ptdesc(struct mmu_gather *tlb, void *pt)
@@ -118,21 +120,10 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 #define p4d_alloc_one p4d_alloc_one
 static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	if (pgtable_l5_enabled) {
-		gfp_t gfp = GFP_PGTABLE_USER;
-
-		if (mm == &init_mm)
-			gfp = GFP_PGTABLE_KERNEL;
-		return (p4d_t *)get_zeroed_page(gfp);
-	}
+	if (!pgtable_l5_enabled)
+		return NULL;
 
-	return NULL;
-}
-
-static inline void __p4d_free(struct mm_struct *mm, p4d_t *p4d)
-{
-	BUG_ON((unsigned long)p4d & (PAGE_SIZE-1));
-	free_page((unsigned long)p4d);
+	return __p4d_alloc_one(mm, addr);
 }
 
 #define p4d_free p4d_free
@@ -145,8 +136,12 @@ static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
 static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
 				  unsigned long addr)
 {
-	if (pgtable_l5_enabled)
+	if (pgtable_l5_enabled) {
+		struct ptdesc *ptdesc = virt_to_ptdesc(p4d);
+
+		pagetable_p4d_dtor(ptdesc);
 		riscv_tlb_remove_ptdesc(tlb, virt_to_ptdesc(p4d));
+	}
 }
 #endif /* __PAGETABLE_PMD_FOLDED */
 
diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
index dcd836b59bebd..d9bc6cae77c9e 100644
--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -8,6 +8,8 @@
 
 #define __HAVE_ARCH_PTE_ALLOC_ONE
 #define __HAVE_ARCH_PGD_FREE
+#define __HAVE_ARCH_P4D_ALLOC_ONE
+#define __HAVE_ARCH_P4D_FREE
 #include <asm-generic/pgalloc.h>
 
 static inline int  __paravirt_pgd_alloc(struct mm_struct *mm) { return 0; }
@@ -149,20 +151,16 @@ static inline void pgd_populate_safe(struct mm_struct *mm, pgd_t *pgd, p4d_t *p4
 
 static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	gfp_t gfp = GFP_KERNEL_ACCOUNT;
+	if (!pgtable_l5_enabled())
+		return NULL;
 
-	if (mm == &init_mm)
-		gfp &= ~__GFP_ACCOUNT;
-	return (p4d_t *)get_zeroed_page(gfp);
+	return __p4d_alloc_one(mm, addr);
 }
 
 static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
 {
-	if (!pgtable_l5_enabled())
-		return;
-
-	BUG_ON((unsigned long)p4d & (PAGE_SIZE-1));
-	free_page((unsigned long)p4d);
+	if (pgtable_l5_enabled())
+		return __p4d_free(mm, p4d);
 }
 
 extern void ___p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d);
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 69a357b15974a..3d6e84da45b24 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -94,6 +94,9 @@ void ___pud_free_tlb(struct mmu_gather *tlb, pud_t *pud)
 #if CONFIG_PGTABLE_LEVELS > 4
 void ___p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d)
 {
+	struct ptdesc *ptdesc = virt_to_ptdesc(p4d);
+
+	pagetable_p4d_dtor(ptdesc);
 	paravirt_release_p4d(__pa(p4d) >> PAGE_SHIFT);
 	paravirt_tlb_remove_table(tlb, virt_to_page(p4d));
 }
diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 7c48f5fbf8aa7..dbf61819b3581 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -215,6 +215,61 @@ static inline void pud_free(struct mm_struct *mm, pud_t *pud)
 
 #endif /* CONFIG_PGTABLE_LEVELS > 3 */
 
+#if CONFIG_PGTABLE_LEVELS > 4
+
+static inline p4d_t *__p4d_alloc_one_noprof(struct mm_struct *mm, unsigned long addr)
+{
+	gfp_t gfp = GFP_PGTABLE_USER;
+	struct ptdesc *ptdesc;
+
+	if (mm == &init_mm)
+		gfp = GFP_PGTABLE_KERNEL;
+	gfp &= ~__GFP_HIGHMEM;
+
+	ptdesc = pagetable_alloc_noprof(gfp, 0);
+	if (!ptdesc)
+		return NULL;
+
+	pagetable_p4d_ctor(ptdesc);
+	return ptdesc_address(ptdesc);
+}
+#define __p4d_alloc_one(...)	alloc_hooks(__p4d_alloc_one_noprof(__VA_ARGS__))
+
+#ifndef __HAVE_ARCH_P4D_ALLOC_ONE
+/**
+ * p4d_alloc_one - allocate memory for a P4D-level page table
+ * @mm: the mm_struct of the current context
+ *
+ * Allocate memory for a page table using %GFP_PGTABLE_USER for user context
+ * and %GFP_PGTABLE_KERNEL for kernel context.
+ *
+ * Return: pointer to the allocated memory or %NULL on error
+ */
+static inline p4d_t *p4d_alloc_one_noprof(struct mm_struct *mm, unsigned long addr)
+{
+	return __p4d_alloc_one_noprof(mm, addr);
+}
+#define p4d_alloc_one(...)	alloc_hooks(p4d_alloc_one_noprof(__VA_ARGS__))
+#endif
+
+static inline void __p4d_free(struct mm_struct *mm, p4d_t *p4d)
+{
+	struct ptdesc *ptdesc = virt_to_ptdesc(p4d);
+
+	BUG_ON((unsigned long)p4d & (PAGE_SIZE-1));
+	pagetable_p4d_dtor(ptdesc);
+	pagetable_free(ptdesc);
+}
+
+#ifndef __HAVE_ARCH_P4D_FREE
+static inline void p4d_free(struct mm_struct *mm, pud_t *p4d)
+{
+	__p4d_free(mm, p4d);
+}
+#endif
+
+#endif
+
 #ifndef __HAVE_ARCH_PGD_FREE
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5e73e53c34e9e..807a12ed8ec96 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3237,6 +3237,22 @@ static inline void pagetable_pud_dtor(struct ptdesc *ptdesc)
 	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
 }
 
+static inline void pagetable_p4d_ctor(struct ptdesc *ptdesc)
+{
+	struct folio *folio = ptdesc_folio(ptdesc);
+
+	__folio_set_pgtable(folio);
+	lruvec_stat_add_folio(folio, NR_PAGETABLE);
+}
+
+static inline void pagetable_p4d_dtor(struct ptdesc *ptdesc)
+{
+	struct folio *folio = ptdesc_folio(ptdesc);
+
+	__folio_clear_pgtable(folio);
+	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
+}
+
 extern void __init pagecache_init(void);
 extern void free_initmem(void);
 
-- 
2.20.1


