Return-Path: <linux-kernel+bounces-432971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B19B69E5285
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5468716647C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A573D1A8F90;
	Thu,  5 Dec 2024 10:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="M9Gefwf0"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9141DC046
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 10:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395075; cv=none; b=LJ3NbvUIzLgYEm27/jWq0iQxXGiiHuRORFeX4yvAjnAvLfX1gn4S9wnU3j3GQsdqjopFOUZjnKjboRsAMY7CoFi7TbIBbFz3KunnVKwps0u/USu0k1+d62yMOL4006iAxffh3R0mKqgs2hRPm1JlP1NM5Sbq27EOqGgAQ0TY8vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395075; c=relaxed/simple;
	bh=3h/3p3d/jgDr8aXeHN9HrkJ5/RDVlpW+np4nhoQy9uo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kdCqTWHZ53yVOSRUjX7UTfAlcHYOo2jtgYyF/rfMZDiPEvi2eR8wUfgdoT4OOpIMSn+DmWQs5IKBrnIxQUWAqK1xM9Ayvk7DHapEd62HxZnAhAUFEJJg2zOX5komm6OhTLm82zHT8uL/5mGbU5PunKIiQrzx9cWIpuLLhx/MSGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=M9Gefwf0; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7ee11ff7210so653134a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 02:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733395072; x=1733999872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=teCsoKxDGeiN3+DzdoxY3wVIl2UTRwagjcvIS6Z3bMs=;
        b=M9Gefwf0/McuRDvxTm1oJotlatXTQYL2viJY0xcsTTpdAXhIaMfWETVz7a4V08obGa
         fxK1JSHvW2AzeBvEyrjxjSXRHUaxy9h+7NF7xL5z3uYRIvsQX/54tnoX5wsC+KIeN1X1
         ktnm9ctOqmRGufOlYhNSQfalp+1ZZ2WA4F7Gq56dzHKnSOiHu4uGnzndPPZnzLGefbOJ
         6TL1Skl38TVn69asly6Km0INH5U5SjZPBA8sCyY9quCpHlgrB2FkDOQqryQoNfv2hzX1
         /Ia6Z/+638vk4RvZINs0H0UA9LXtAq5oclat5VTADG+KD6YUBLSXlnlLFyYhdQEBogSg
         F4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733395072; x=1733999872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=teCsoKxDGeiN3+DzdoxY3wVIl2UTRwagjcvIS6Z3bMs=;
        b=a8JChBf5eo+2lJGx3niPMwus32Q68XqmEyNuHzWnh+czd+MF3DnjchFjDR8PHB06TG
         oWM0JZhIOYL1+SGFFz8lolGnplD1tciVNF5oXINe0m6V6MFXUNFHBD57OXx/Eg3U5YWZ
         qQb/XNBuXJ7j9z/1ODo/frFA1fHV/iJMosneVy/XkajvQAvNuGXxCa770L/l2k9410l0
         684RWS6QxiyYwOpY0HEOmTNlk9cAfCDuCLALLwc4/+BdP4VKv+LFLrTbfTmTGEgsdjMV
         GHUlIwqi49qb/0OauUpyqN+sSA/1a2zmJ4HY4EIgeed3P6iTG1kW7qcYsSnELcTxB3xA
         3wIg==
X-Forwarded-Encrypted: i=1; AJvYcCWoFKIIJzyXcjkofCZZF8m0j/XvxAlYZz0R3/Oy/Q9DIK3wcFsZVi7uFucQExNP90Gwfg2ecaZML6u1Xa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqgmOWO4ox2Cy+OOXep8uEqItn5LbwowXN2mnzqNcMKjL0B+uO
	CF4tDMLY5g9aBqf2hXObIWCKhT2dfJivVXTX+Ua64RBXcWsEBipODNTKMeyFJDs=
X-Gm-Gg: ASbGncsyBrL27gtFAzc8359MkNwOYbdGK8gw+8UUAoiMJ7SghApLcWxjpt3Bl0Ala4w
	PFnV1xfClftYQGcPESTSAlg0mZOT2EoshZ91XwqPXwUXWYfHj7pWzusDh1G34B+OX8y/Qk8lybN
	QOphxFuhGopQWSZgyWDFTQs/u0IMFBmrhh3khTMaBO4vrBRqvhAA7lZWJ6MCJ0qVttTWs+q99PW
	FAbfRlKA7vbR4Grj11Bq3fcaDMGYAcIhokEVDz/LbXJ/Cr8otrMtzNUIM98KKs1yusHp9txvK3b
	vFVkx6l6Tu0gEkMHz8gjVCC2wV+UAtl5
X-Google-Smtp-Source: AGHT+IHv/nBjYCvlcRUcvZSgl+N0//z6T9cTlerWiKA9ANKuf1lPaFN2gvQdQxXb4nAsIJJZSEYzng==
X-Received: by 2002:a05:6a20:1d98:b0:1db:efab:390c with SMTP id adf61e73a8af0-1e1653f3f22mr17696126637.35.1733395071049;
        Thu, 05 Dec 2024 02:37:51 -0800 (PST)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd156f048csm886826a12.39.2024.12.05.02.37.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Dec 2024 02:37:50 -0800 (PST)
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
Subject: [RFC PATCH v2 03/21] riscv: mm: Reimplement page table entry structures
Date: Thu,  5 Dec 2024 18:37:11 +0800
Message-Id: <20241205103729.14798-4-luxu.kernel@bytedance.com>
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

After decoupling hardware base page and software base page, each
software page can consists of several hardware base pages now. The pte
struct should be turned to an array of mapping entires to map the
software page. For example, in 64K Page Size kernel, each software page
consists of 16 contiguous hardware pages. Thus the pte struct should
contains 16 mapping entries to map 16 hardware pages.

This commit reimplements pte structure.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/page.h       | 43 +++++++++++++++++++++++----
 arch/riscv/include/asm/pgtable-64.h | 41 +++++++++++++++++++++----
 arch/riscv/include/asm/pgtable.h    | 23 +++++++++++++--
 arch/riscv/mm/pgtable.c             | 46 +++++++++++++++++++++++++++++
 4 files changed, 141 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 7c581a3e057b..9bc908d94c7a 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -63,6 +63,36 @@ void clear_page(void *page);
  * Use struct definitions to apply C type checking
  */
 
+#ifdef CONFIG_RISCV_USE_SW_PAGE
+
+#define HW_PAGES_PER_PAGE	(1 << (PAGE_SHIFT - HW_PAGE_SHIFT))
+
+struct page_table_entry {
+	union {
+		unsigned long pgds[HW_PAGES_PER_PAGE];
+		unsigned long p4ds[HW_PAGES_PER_PAGE];
+		unsigned long puds[HW_PAGES_PER_PAGE];
+		unsigned long pmds[HW_PAGES_PER_PAGE];
+		unsigned long ptes[HW_PAGES_PER_PAGE];
+	};
+};
+
+/* Page Global Directory entry */
+typedef struct page_table_entry pgd_t;
+
+/* Page Table entry */
+typedef struct page_table_entry pte_t;
+
+#define pte_val(x)	((x).ptes[0])
+#define pgd_val(x)	((x).pgds[0])
+
+pte_t __pte(unsigned long pteval);
+pgd_t __pgd(unsigned long pgdval);
+#define __pte		__pte
+#define __pgd		__pgd
+
+#else /* CONFIG_RISCV_USE_SW_PAGE */
+
 /* Page Global Directory entry */
 typedef struct {
 	unsigned long pgd;
@@ -73,18 +103,21 @@ typedef struct {
 	unsigned long pte;
 } pte_t;
 
+#define pte_val(x)	((x).pte)
+#define pgd_val(x)	((x).pgd)
+
+#define __pte(x)	((pte_t) { (x) })
+#define __pgd(x)	((pgd_t) { (x) })
+
+#endif /* CONFIG_RISCV_USE_SW_PAGE */
+
 typedef struct {
 	unsigned long pgprot;
 } pgprot_t;
 
 typedef struct page *pgtable_t;
 
-#define pte_val(x)	((x).pte)
-#define pgd_val(x)	((x).pgd)
 #define pgprot_val(x)	((x).pgprot)
-
-#define __pte(x)	((pte_t) { (x) })
-#define __pgd(x)	((pgd_t) { (x) })
 #define __pgprot(x)	((pgprot_t) { (x) })
 
 #ifdef CONFIG_64BIT
diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index 963aa4be9eed..e736873d7768 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -41,6 +41,35 @@ extern bool pgtable_l5_enabled;
 #define PMD_SIZE        (_AC(1, UL) << PMD_SHIFT)
 #define PMD_MASK        (~(PMD_SIZE - 1))
 
+#ifdef CONFIG_RISCV_USE_SW_PAGE
+
+/* Page 4th Directory entry */
+typedef struct page_table_entry p4d_t;
+
+#define p4d_val(x)	((x).p4ds[0])
+p4d_t __p4d(unsigned long p4dval);
+#define __p4d		__p4d
+#define PTRS_PER_P4D	(PAGE_SIZE / sizeof(p4d_t))
+
+/* Page Upper Directory entry */
+typedef struct page_table_entry pud_t;
+
+#define pud_val(x)      ((x).puds[0])
+pud_t __pud(unsigned long pudval);
+#define __pud		__pud
+#define PTRS_PER_PUD    (PAGE_SIZE / sizeof(pud_t))
+
+/* Page Middle Directory entry */
+typedef struct page_table_entry pmd_t;
+
+#define pmd_val(x)      ((x).pmds[0])
+pmd_t __pmd(unsigned long pmdval);
+#define __pmd		__pmd
+
+#define PTRS_PER_PMD    (PAGE_SIZE / sizeof(pmd_t))
+
+#else /* CONFIG_RISCV_USE_SW_PAGE */
+
 /* Page 4th Directory entry */
 typedef struct {
 	unsigned long p4d;
@@ -69,6 +98,8 @@ typedef struct {
 
 #define PTRS_PER_PMD    (PAGE_SIZE / sizeof(pmd_t))
 
+#endif /* CONFIG_RISCV_USE_SW_PAGE */
+
 /*
  * rv64 PTE format:
  * | 63 | 62 61 | 60 54 | 53  10 | 9             8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
@@ -98,7 +129,7 @@ enum napot_cont_order {
 #define for_each_napot_order_rev(order)						\
 	for (order = NAPOT_ORDER_MAX - 1;					\
 	     order >= NAPOT_CONT_ORDER_BASE; order--)
-#define napot_cont_order(val)	(__builtin_ctzl((val.pte >> _PAGE_PFN_SHIFT) << 1))
+#define napot_cont_order(val)	(__builtin_ctzl((pte_val(val) >> _PAGE_PFN_SHIFT) << 1))
 
 #define napot_cont_shift(order)	((order) + PAGE_SHIFT)
 #define napot_cont_size(order)	BIT(napot_cont_shift(order))
@@ -279,7 +310,7 @@ static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
 	if (pgtable_l4_enabled)
 		WRITE_ONCE(*p4dp, p4d);
 	else
-		set_pud((pud_t *)p4dp, (pud_t){ p4d_val(p4d) });
+		set_pud((pud_t *)p4dp, __pud(p4d_val(p4d)));
 }
 
 static inline int p4d_none(p4d_t p4d)
@@ -327,7 +358,7 @@ static inline pud_t *p4d_pgtable(p4d_t p4d)
 	if (pgtable_l4_enabled)
 		return (pud_t *)pfn_to_virt(__page_val_to_pfn(p4d_val(p4d)));
 
-	return (pud_t *)pud_pgtable((pud_t) { p4d_val(p4d) });
+	return (pud_t *)pud_pgtable(__pud(p4d_val(p4d)));
 }
 #define p4d_page_vaddr(p4d)	((unsigned long)p4d_pgtable(p4d))
 
@@ -346,7 +377,7 @@ static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
 	if (pgtable_l5_enabled)
 		WRITE_ONCE(*pgdp, pgd);
 	else
-		set_p4d((p4d_t *)pgdp, (p4d_t){ pgd_val(pgd) });
+		set_p4d((p4d_t *)pgdp, __p4d(pgd_val(pgd)));
 }
 
 static inline int pgd_none(pgd_t pgd)
@@ -384,7 +415,7 @@ static inline p4d_t *pgd_pgtable(pgd_t pgd)
 	if (pgtable_l5_enabled)
 		return (p4d_t *)pfn_to_virt(__page_val_to_pfn(pgd_val(pgd)));
 
-	return (p4d_t *)p4d_pgtable((p4d_t) { pgd_val(pgd) });
+	return (p4d_t *)p4d_pgtable(__p4d(pgd_val(pgd)));
 }
 #define pgd_page_vaddr(pgd)	((unsigned long)pgd_pgtable(pgd))
 
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 9d3947ec3523..f9aed43809b3 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -574,6 +574,25 @@ static inline void __set_pte_at(struct mm_struct *mm, pte_t *ptep, pte_t pteval)
 
 #define PFN_PTE_SHIFT		_PAGE_PFN_SHIFT
 
+#ifdef CONFIG_RISCV_USE_SW_PAGE
+static inline pte_t pte_advance_pfn(pte_t pte, unsigned long nr)
+{
+	unsigned int i;
+
+	if (pte_present(pte) && !pte_napot(pte))
+		for (i = 0; i < HW_PAGES_PER_PAGE; i++)
+			pte.ptes[i] += nr << _PAGE_PFN_SHIFT;
+
+	return pte;
+}
+#else
+static inline pte_t pte_advance_pfn(pte_t pte, unsigned long nr)
+{
+	return __pte(pte_val(pte) + (nr << _PAGE_PFN_SHIFT));
+}
+#endif
+#define pte_advance_pfn		pte_advance_pfn
+
 static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 		pte_t *ptep, pte_t pteval, unsigned int nr)
 {
@@ -584,7 +603,7 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 		if (--nr == 0)
 			break;
 		ptep++;
-		pte_val(pteval) += 1 << _PAGE_PFN_SHIFT;
+		pteval = pte_advance_pfn(pteval, 1);
 	}
 }
 #define set_ptes set_ptes
@@ -882,7 +901,7 @@ extern pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
 	  ((offset) << __SWP_OFFSET_SHIFT) })
 
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
-#define __swp_entry_to_pte(x)	((pte_t) { (x).val })
+#define __swp_entry_to_pte(x)	(__pte((x).val))
 
 static inline int pte_swp_exclusive(pte_t pte)
 {
diff --git a/arch/riscv/mm/pgtable.c b/arch/riscv/mm/pgtable.c
index 4ae67324f992..0c6b2fc6be58 100644
--- a/arch/riscv/mm/pgtable.c
+++ b/arch/riscv/mm/pgtable.c
@@ -5,6 +5,52 @@
 #include <linux/kernel.h>
 #include <linux/pgtable.h>
 
+#ifdef CONFIG_RISCV_USE_SW_PAGE
+
+pte_t __pte(unsigned long pteval)
+{
+	pte_t pte;
+
+	return pte;
+}
+EXPORT_SYMBOL(__pte);
+
+pgd_t __pgd(unsigned long pgdval)
+{
+	pgd_t pgd;
+
+	return pgd;
+}
+EXPORT_SYMBOL(__pgd);
+
+#ifdef CONFIG_64BIT
+p4d_t __p4d(unsigned long p4dval)
+{
+	p4d_t p4d;
+
+	return p4d;
+}
+EXPORT_SYMBOL(__p4d);
+
+pud_t __pud(unsigned long pudval)
+{
+	pud_t pud;
+
+	return pud;
+}
+EXPORT_SYMBOL(__pud);
+
+pmd_t __pmd(unsigned long pmdval)
+{
+	pmd_t pmd;
+
+	return pmd;
+}
+EXPORT_SYMBOL(__pmd);
+#endif /* CONFIG_64BIT */
+
+#endif /* CONFIG_RISCV_USE_SW_PAGE */
+
 int ptep_set_access_flags(struct vm_area_struct *vma,
 			  unsigned long address, pte_t *ptep,
 			  pte_t entry, int dirty)
-- 
2.20.1


