Return-Path: <linux-kernel+bounces-432972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D26FD9E5286
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C4711673D7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731911DC19F;
	Thu,  5 Dec 2024 10:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="avLg8tQ4"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC8A1DA605
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 10:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395077; cv=none; b=iv1VgK3cQUxBMWkHKUdWxVOe/Algaw+/JwvIx7NoPQoxI4h+9meykItQjjexULTwyASSDg+GWnPeTn8MusEbSRbRPYg5TiaXus9Q3KgjkFTLhp3zpJfqX1N1+lNVdTut2Lwi/mwS13UIOq40ZFk/hqs/VoRO4PtMEJfsmjkKCYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395077; c=relaxed/simple;
	bh=jUNY6BJZlto1cTtwp/89dNrWlebhXYA8qzsooGeN2uc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GlA4PJE6bGd5NXbxZslFoRDMmWr34iasICPKkKunPpxPjCDShUlbFGJqbdPI17hsw24OB/PM8kJfH+/8iDXv2tiMZvv6gUAqKCiAclebeuOLvbY3UpvSGpcFTdrzn+LtyfkjA4bgtBLug4iAIpdJ5vvT4XAvj2aPPCm3+TouPr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=avLg8tQ4; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7fcdbfd8090so606114a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 02:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733395075; x=1733999875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cc/dZWEu2lOmGL5teCDDaBtpVgBp3/NGadgIOM//MYE=;
        b=avLg8tQ4gLQurRtwi2SIY+EgLV0sxOMmf4gm/Gl4AzF3W6Qfb5BPdICuyDTDCqiaWD
         DGCqd62rdV0bkSqjwyiddxjnRxHwvkJ7enTj+A28fFHnGlukQdv0EhkYVVpfV70bkQYK
         fKGUGsqzLoXtavQEEujqbVqwGeiv+3y2xLUXf7d3Z3hpbh2An4ApwQe/sSdGl7kCOHYZ
         e5nVrpuHuD9XYQdaGFyXS5hgpPV/mFicg1U+StAYtbhvNOM5JU4/UZ6wchseldltrWcf
         4ez2fWc7hxSzm58ICXM4+9SDIN9hYKfTBh5JU7Xs87tFtGot+8n2BG0WAeJhvdsx3kIN
         dUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733395075; x=1733999875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cc/dZWEu2lOmGL5teCDDaBtpVgBp3/NGadgIOM//MYE=;
        b=A42/zEfjadE+QtM0EOgfty5Oz8glSH43wb7+RJRi1sJCAuS4s4RNcHHFrCoi0rre7R
         m0uCuWNNh/PKr0stFc5kA1eoPLqYkNfOLzlRF6D8sMoGj6yGUs5rEkfJZBn1pJyHJX6R
         Bqyg+1NWojb/hFal+eNBkmYBd+Xu5JMXrByp5A93WT/+vgJQOz7eXHbAB53hXNzQvpkt
         39t2mOPNcgOt8/YPH7lrCqs9MoHSc3XiDN+GLBMDVWZGeYEpZ5xjJnprMp6SKtjTNy/D
         je7+7IR7KnB91TKlOQG0wj7vgEpM+Lqo7ENuyiVaguH+YU7elKQ/Yi9bLQxawzlwBeOb
         DbqA==
X-Forwarded-Encrypted: i=1; AJvYcCXz5aHVt8huo4CpfQA0bp5ueiYGP7NSxhhooQ4tLsGp/ayX2EJp61n83Oq2YzAwaj/8OxNnc1a4WltuNTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBhoOEpBbC6lYb3bxH8qUFklXMk07xT/RObhR6eFFDJLjq1k9D
	6qoitBPMkRsHze8WwbxywN8mhxcawAcBkmfUlRQ3vn5cThGTGKgOKBPQxlq3ArQ=
X-Gm-Gg: ASbGncv3lycykzfL8xeMJY1jO2ODE9QWk7nMbrkEWU6aWQ+K024Xbjwp/YXXzmEy2Ak
	TLspMjM+a+2BDt4nYaO3CX6KMDfpQVFw2Lz0YcY4/JxsbB9eC727TzkrHHFxfdCM135J5m4mpNu
	OS9ww1q9Djzb2EG70h+81sI5ZGmeI0cSkZBvki813gon6ybcOkMxOwYT1aLeqzQtMDn47lMde8E
	sJIHjdOvuiVESmv2jiL+FBXJW2RJfmE4SheCeg0I9X54xbVGwIkCWFS5cmkEb69F6Atwm54OVMq
	2rS8wBhPNiXR8OsyRJVRgTLpZPLPjLbv
X-Google-Smtp-Source: AGHT+IEA0IERrJMVRep0HIEJfScJ16JhQtj/WdB3oMlrbTyvrSoqe//NvEXdVU3Seu11zobAb4MPFg==
X-Received: by 2002:a05:6a21:3989:b0:1db:e3f6:55f with SMTP id adf61e73a8af0-1e1653b992amr15407579637.18.1733395075109;
        Thu, 05 Dec 2024 02:37:55 -0800 (PST)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd156f048csm886826a12.39.2024.12.05.02.37.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Dec 2024 02:37:54 -0800 (PST)
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
Subject: [RFC PATCH v2 04/21] riscv: mm: Reimplement page table entry constructor function
Date: Thu,  5 Dec 2024 18:37:12 +0800
Message-Id: <20241205103729.14798-5-luxu.kernel@bytedance.com>
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

This commit reimplements the page table entry constructor. As each page
can contains several hardware pages now, the pte constructor need to
initialize all mapping entries of these hardware pages. Note that the
step path between mapping entries differs in different page table entry
levels. For example, in PTE level, the step path between hardware
mapping entries is hardware page size (aka 4K). In PMD level, the step
path is (2 ^ 9) * hardware page size (aka 2M), etc.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/pgtable-32.h |  5 +++
 arch/riscv/include/asm/pgtable-64.h | 41 +++++++++++++++++++---
 arch/riscv/include/asm/pgtable.h    | 54 ++++++++++++++++++++++++-----
 arch/riscv/mm/pgtable.c             | 47 +++++++++++++++++++++++++
 4 files changed, 133 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable-32.h b/arch/riscv/include/asm/pgtable-32.h
index 159a668c3dd8..2959ab72f926 100644
--- a/arch/riscv/include/asm/pgtable-32.h
+++ b/arch/riscv/include/asm/pgtable-32.h
@@ -37,4 +37,9 @@
 static const __maybe_unused int pgtable_l4_enabled;
 static const __maybe_unused int pgtable_l5_enabled;
 
+static inline int __pgd_present(unsigned long pgdval)
+{
+	return pgdval & _PAGE_PRESENT;
+}
+
 #endif /* _ASM_RISCV_PGTABLE_32_H */
diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index e736873d7768..efcf63667f93 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -204,9 +204,14 @@ static inline u64 riscv_page_io(void)
 					  _PAGE_USER | _PAGE_GLOBAL |	\
 					  _PAGE_MTMASK))
 
+static inline int __pud_present(unsigned long pudval)
+{
+	return pudval & _PAGE_PRESENT;
+}
+
 static inline int pud_present(pud_t pud)
 {
-	return (pud_val(pud) & _PAGE_PRESENT);
+	return __pud_present(pud_val(pud));
 }
 
 static inline int pud_none(pud_t pud)
@@ -219,11 +224,16 @@ static inline int pud_bad(pud_t pud)
 	return !pud_present(pud);
 }
 
-#define pud_leaf	pud_leaf
+static inline bool __pud_leaf(unsigned long pudval)
+{
+	return __pud_present(pudval) && (pudval & _PAGE_LEAF);
+}
+
 static inline bool pud_leaf(pud_t pud)
 {
-	return pud_present(pud) && (pud_val(pud) & _PAGE_LEAF);
+	return __pud_leaf(pud_val(pud));
 }
+#define pud_leaf	pud_leaf
 
 static inline int pud_user(pud_t pud)
 {
@@ -321,14 +331,30 @@ static inline int p4d_none(p4d_t p4d)
 	return 0;
 }
 
+static inline int __p4d_present(unsigned long p4dval)
+{
+	return p4dval & _PAGE_PRESENT;
+}
+
 static inline int p4d_present(p4d_t p4d)
 {
 	if (pgtable_l4_enabled)
-		return (p4d_val(p4d) & _PAGE_PRESENT);
+		return __p4d_present(p4d_val(p4d));
 
 	return 1;
 }
 
+static inline int __p4d_leaf(unsigned long p4dval)
+{
+	return 0;
+}
+
+static inline int p4d_leaf(p4d_t p4d)
+{
+	return __p4d_leaf(p4d_val(p4d));
+}
+#define p4d_leaf	p4d_leaf
+
 static inline int p4d_bad(p4d_t p4d)
 {
 	if (pgtable_l4_enabled)
@@ -388,10 +414,15 @@ static inline int pgd_none(pgd_t pgd)
 	return 0;
 }
 
+static inline int __pgd_present(unsigned long pgdval)
+{
+	return pgdval & _PAGE_PRESENT;
+}
+
 static inline int pgd_present(pgd_t pgd)
 {
 	if (pgtable_l5_enabled)
-		return (pgd_val(pgd) & _PAGE_PRESENT);
+		return __pgd_present(pgd_val(pgd));
 
 	return 1;
 }
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index f9aed43809b3..1d5f533edbd5 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -220,8 +220,19 @@ static inline unsigned long satp_pfn(unsigned long satp)
 	return hwpfn_to_pfn(hwpfn);
 }
 
+static inline int __pgd_leaf(unsigned long pgdval)
+{
+	return __pgd_present(pgdval) && (pgdval & _PAGE_LEAF);
+}
+
+static inline int pgd_leaf(pgd_t pgd)
+{
+	return __pgd_leaf(pgd_val(pgd));
+}
+#define pgd_leaf	pgd_leaf
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-static inline int pmd_present(pmd_t pmd)
+static inline int __pmd_present(unsigned long pmdval)
 {
 	/*
 	 * Checking for _PAGE_LEAF is needed too because:
@@ -229,15 +240,20 @@ static inline int pmd_present(pmd_t pmd)
 	 * the present bit, in this situation, pmd_present() and
 	 * pmd_trans_huge() still needs to return true.
 	 */
-	return (pmd_val(pmd) & (_PAGE_PRESENT | _PAGE_PROT_NONE | _PAGE_LEAF));
+	return (pmdval & (_PAGE_PRESENT | _PAGE_PROT_NONE | _PAGE_LEAF));
 }
 #else
-static inline int pmd_present(pmd_t pmd)
+static inline int __pmd_present(unsigned long pmdval)
 {
-	return (pmd_val(pmd) & (_PAGE_PRESENT | _PAGE_PROT_NONE));
+	return (pmdval & (_PAGE_PRESENT | _PAGE_PROT_NONE));
 }
 #endif
 
+static inline int pmd_present(pmd_t pmd)
+{
+	return __pmd_present(pmd_val(pmd));
+}
+
 static inline int pmd_none(pmd_t pmd)
 {
 	return (pmd_val(pmd) == 0);
@@ -248,11 +264,16 @@ static inline int pmd_bad(pmd_t pmd)
 	return !pmd_present(pmd) || (pmd_val(pmd) & _PAGE_LEAF);
 }
 
-#define pmd_leaf	pmd_leaf
+static inline bool __pmd_leaf(unsigned long pmdval)
+{
+	return __pmd_present(pmdval) && (pmdval & _PAGE_LEAF);
+}
+
 static inline bool pmd_leaf(pmd_t pmd)
 {
-	return pmd_present(pmd) && (pmd_val(pmd) & _PAGE_LEAF);
+	return __pmd_leaf(pmd_val(pmd));
 }
+#define pmd_leaf	pmd_leaf
 
 static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
 {
@@ -306,9 +327,14 @@ static __always_inline bool has_svnapot(void)
 	return riscv_has_extension_likely(RISCV_ISA_EXT_SVNAPOT);
 }
 
+static inline unsigned long __pte_napot(unsigned long val)
+{
+	return val & _PAGE_NAPOT;
+}
+
 static inline unsigned long pte_napot(pte_t pte)
 {
-	return pte_val(pte) & _PAGE_NAPOT;
+	return __pte_napot(pte_val(pte));
 }
 
 static inline pte_t pte_mknapot(pte_t pte, unsigned int order)
@@ -324,11 +350,16 @@ static inline pte_t pte_mknapot(pte_t pte, unsigned int order)
 
 static __always_inline bool has_svnapot(void) { return false; }
 
-static inline unsigned long pte_napot(pte_t pte)
+static inline unsigned long __pte_napot(unsigned long pteval)
 {
 	return 0;
 }
 
+static inline unsigned long pte_napot(pte_t pte)
+{
+	return __pte_napot(pte_val(pte));
+}
+
 #endif /* CONFIG_RISCV_ISA_SVNAPOT */
 
 /* Yields the page frame number (PFN) of a page table entry */
@@ -356,9 +387,14 @@ static inline pte_t pfn_pte(unsigned long pfn, pgprot_t prot)
 
 #define mk_pte(page, prot)       pfn_pte(page_to_pfn(page), prot)
 
+static inline int __pte_present(unsigned long pteval)
+{
+	return (pteval & (_PAGE_PRESENT | _PAGE_PROT_NONE));
+}
+
 static inline int pte_present(pte_t pte)
 {
-	return (pte_val(pte) & (_PAGE_PRESENT | _PAGE_PROT_NONE));
+	return __pte_present(pte_val(pte));
 }
 
 #define pte_accessible pte_accessible
diff --git a/arch/riscv/mm/pgtable.c b/arch/riscv/mm/pgtable.c
index 0c6b2fc6be58..f57ada26a183 100644
--- a/arch/riscv/mm/pgtable.c
+++ b/arch/riscv/mm/pgtable.c
@@ -10,6 +10,13 @@
 pte_t __pte(unsigned long pteval)
 {
 	pte_t pte;
+	unsigned int i;
+
+	for (i = 0; i < HW_PAGES_PER_PAGE; i++) {
+		pte.ptes[i] = pteval;
+		if (__pte_present(pteval) && !__pte_napot(pteval))
+			pteval += 1 << _PAGE_HWPFN_SHIFT;
+	}
 
 	return pte;
 }
@@ -18,6 +25,16 @@ EXPORT_SYMBOL(__pte);
 pgd_t __pgd(unsigned long pgdval)
 {
 	pgd_t pgd;
+	unsigned int i;
+
+	for (i = 0; i < HW_PAGES_PER_PAGE; i++) {
+		pgd.pgds[i] = pgdval;
+		if (__pgd_leaf(pgdval))
+			pgdval += (1 << (PGDIR_SHIFT - PAGE_SHIFT)) <<
+					_PAGE_HWPFN_SHIFT;
+		else if (__pgd_present(pgdval))
+			pgdval += 1 << _PAGE_HWPFN_SHIFT;
+	}
 
 	return pgd;
 }
@@ -27,6 +44,16 @@ EXPORT_SYMBOL(__pgd);
 p4d_t __p4d(unsigned long p4dval)
 {
 	p4d_t p4d;
+	unsigned int i;
+
+	for (i = 0; i < HW_PAGES_PER_PAGE; i++) {
+		p4d.p4ds[i] = p4dval;
+		if (__p4d_leaf(p4dval))
+			p4dval += (1 << (P4D_SHIFT - PAGE_SHIFT)) <<
+					_PAGE_HWPFN_SHIFT;
+		else if (__p4d_present(p4dval))
+			p4dval += 1 << _PAGE_HWPFN_SHIFT;
+	}
 
 	return p4d;
 }
@@ -35,6 +62,16 @@ EXPORT_SYMBOL(__p4d);
 pud_t __pud(unsigned long pudval)
 {
 	pud_t pud;
+	unsigned int i;
+
+	for (i = 0; i < HW_PAGES_PER_PAGE; i++) {
+		pud.puds[i] = pudval;
+		if (__pud_leaf(pudval))
+			pudval += (1 << (PUD_SHIFT - PAGE_SHIFT)) <<
+					_PAGE_HWPFN_SHIFT;
+		else if (__pud_present(pudval))
+			pudval += 1 << _PAGE_HWPFN_SHIFT;
+	}
 
 	return pud;
 }
@@ -43,6 +80,16 @@ EXPORT_SYMBOL(__pud);
 pmd_t __pmd(unsigned long pmdval)
 {
 	pmd_t pmd;
+	unsigned int i;
+
+	for (i = 0; i < HW_PAGES_PER_PAGE; i++) {
+		pmd.pmds[i] = pmdval;
+		if (__pmd_leaf(pmdval))
+			pmdval += (1 << (PMD_SHIFT - PAGE_SHIFT)) <<
+					_PAGE_HWPFN_SHIFT;
+		else if (__pmd_present(pmdval))
+			pmdval += 1 << _PAGE_HWPFN_SHIFT;
+	}
 
 	return pmd;
 }
-- 
2.20.1


