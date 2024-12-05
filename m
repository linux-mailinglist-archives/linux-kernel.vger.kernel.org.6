Return-Path: <linux-kernel+bounces-432977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 609719E528C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DE4D166457
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0255B1D9663;
	Thu,  5 Dec 2024 10:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fXb1FGFf"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA69E1DB37F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 10:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395097; cv=none; b=dmiAOPOOBe34ol4SNAD2a5Fq1aYINoK7bUHzukPyb9amwu6VqfgmY5/etfPgI9pxLFmUsKPyY3J3/GkBg/+t8IbmO49FYI0jv3CKPkWRPMvEWwUdVeCvDyf9Kte1FmXwRQjRwvDqYHY3tpkwEQ6sxtQu+JNVdPicjjcy2IUgg/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395097; c=relaxed/simple;
	bh=Xrt6S2p9gVj8iFv//T0E/D73EoMBDaL86AIOToQrt78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lS7L60KmU8uJmGwo1y4xymtHM3OGmlA1kaBN8pMr2iUX4HUPMhyuM3Y4mt5rhd+MZdWYICjKC+E5FHm8iZ+jHbwZEtvQvQBTlR7i/45GqXRAaQJALLdv4oiXkIy6KBUbxiEOE7cOgyiXz/OQDqB6iROMoS7AyWDKyaA+wxhKmkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fXb1FGFf; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7f46d5d1ad5so627107a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 02:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733395095; x=1733999895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83UO5ozW5NdISNbxrvGH5KVgxXxH6sNR5OZieItF5/g=;
        b=fXb1FGFfaKq22NMbAYCJOZZyZbLcjg6IZV/tLLJOFWbY2KtXmglvt/2H7B3GSy6P1l
         zcxzbDddYy7fK7LRT0fsBHymJ/ucMoFNuIGay6QV+9UnNQsuFjgtS7vUGwtJfrZe1wnn
         Sy3+pfsDGXrPHMsDo8fq9L7n+BMdKB9dpBh2qDzhOqM2DedEtlfJfGFAJ6Q7m9+0CRhc
         nxq7dNYLA7OHJZLOI/0kNA4Svh5aiv2GyijmzcFiwb2PYAWMrKvl1Q3pXMOXbqkcZfKA
         MzgPNLeHy1gvLsKlGhAjDZ378bVacfw4f3j+DxlCjUqJTttWo3NjUsw1pqaEKzAyEBI6
         Eaug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733395095; x=1733999895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=83UO5ozW5NdISNbxrvGH5KVgxXxH6sNR5OZieItF5/g=;
        b=JQ2u5UcXnSOopI6+EkX1tPSSM+Y+j8250FZ/Xzzzvna6WywmmGy6i5IThVzKPQcoL2
         ro57wAQ0XmPeFpCjPnpZPg69IBqEOyydRXoK1ZDo/nsfnC40waTlnH7jpkh1n7TC6f/P
         9g6uzva65UKDpke5s8GJ9q0f1Ta+G9l/VI694/EEgT5dGlGAl1Ry6RsuFF0NWTqGca0h
         hheyyVvbhTrqE0wwwq3e6fi8PKx9/D5tGY7glqTd80ZfDjJsjDv6JYIhbQHiBo0zncDz
         JlS7jidRE8Orj8tRpOHqsbwfINcpylqAi/M+n/R3ecv5mxfQoFG7uyJcU3xpGgE+1Keh
         fcaw==
X-Forwarded-Encrypted: i=1; AJvYcCU2P41aRxDSVhCzyfA7vO5WRRzprUJ6psdpBrBKVhWGRdjtxV5UGXItUDgeyiS+QbNfu7kmzh6xr19YQsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtB+LHGJzLwIiDfEkeFb8Go2JHjPqI+kUfpiPYsqNjK96MP8iK
	2ZVPEawciXWXQ/ziVVihMq3GjnivBmltZbev+QS0fC/O0EpJlL+XHq+cm1pM0m8=
X-Gm-Gg: ASbGncs7JC0E5yOzIlsb9dfsvtDLF2zji6TOzifPMNwuMUuuSJEL85P+E8gg6hnq6Py
	BynBXi2MMx6b439ar+Fmujc/5UIuO7BcIhCSsqYB4o0XLUG7meI/iy+E4Fvdw13uFgDA3uvrRdr
	lf5voS8SaSxg9QgzbjWL/li2TYKLkUGEqkVAcgJQfw2nvtDx9GlVgD2b1pR/V56oCUzewb0SCXi
	uiwOvEebiD5Xl/rcUCcHQM4CsECwDwkoWzQskPJfLBbLeUf5rDjYCWrLBWiGYXuOn9ZNxODGukg
	P/ol3vFuSo9fVY2iDZuCjX9QULyVUjBA
X-Google-Smtp-Source: AGHT+IHonPj5or3FCVlbY151Zkh3FREpG17bX8AKYVEQ/Cqc6X6geX5o43T/JV8/DVhtAO5u57D41Q==
X-Received: by 2002:a05:6a21:99a2:b0:1d9:c615:944f with SMTP id adf61e73a8af0-1e1653b9f1bmr15516117637.11.1733395095235;
        Thu, 05 Dec 2024 02:38:15 -0800 (PST)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd156f048csm886826a12.39.2024.12.05.02.38.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Dec 2024 02:38:15 -0800 (PST)
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
Subject: [RFC PATCH v2 09/21] riscv: mm: Replace READ_ONCE with atomic pte get function
Date: Thu,  5 Dec 2024 18:37:17 +0800
Message-Id: <20241205103729.14798-10-luxu.kernel@bytedance.com>
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

READ_ONCE can not be applied to pte structure with multipling mapping
entries. This commit replaces READ_ONCE with atomic pte get function.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/pgtable-64.h |  6 +++---
 arch/riscv/include/asm/pgtable.h    | 21 +++++++++++++--------
 arch/riscv/kernel/hibernate.c       | 18 +++++++++---------
 arch/riscv/mm/pgtable.c             | 12 +++++++++---
 kernel/events/core.c                |  6 +++---
 mm/debug_vm_pgtable.c               |  4 ++--
 mm/gup.c                            | 10 +++++-----
 mm/hmm.c                            |  2 +-
 mm/mapping_dirty_helpers.c          |  2 +-
 mm/memory.c                         |  4 ++--
 mm/mprotect.c                       |  2 +-
 mm/ptdump.c                         |  8 ++++----
 mm/sparse-vmemmap.c                 |  2 +-
 mm/vmscan.c                         |  2 +-
 14 files changed, 55 insertions(+), 44 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index efcf63667f93..2649cc90b14e 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -242,7 +242,7 @@ static inline int pud_user(pud_t pud)
 
 static inline void set_pud(pud_t *pudp, pud_t pud)
 {
-	WRITE_ONCE(*pudp, pud);
+	*pudp = pud;
 }
 
 static inline void pud_clear(pud_t *pudp)
@@ -318,7 +318,7 @@ static inline unsigned long _pmd_pfn(pmd_t pmd)
 static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
 {
 	if (pgtable_l4_enabled)
-		WRITE_ONCE(*p4dp, p4d);
+		*p4dp = p4d;
 	else
 		set_pud((pud_t *)p4dp, __pud(p4d_val(p4d)));
 }
@@ -401,7 +401,7 @@ pud_t *pud_offset(p4d_t *p4d, unsigned long address);
 static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
 {
 	if (pgtable_l5_enabled)
-		WRITE_ONCE(*pgdp, pgd);
+		*pgdp = pgd;
 	else
 		set_p4d((p4d_t *)pgdp, __p4d(pgd_val(pgd)));
 }
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index fe42afb4441e..bf724d006236 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -289,7 +289,7 @@ static inline bool pmd_leaf(pmd_t pmd)
 
 static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
 {
-	WRITE_ONCE(*pmdp, pmd);
+	*pmdp = pmd;
 }
 
 static inline void pmd_clear(pmd_t *pmdp)
@@ -713,7 +713,7 @@ static inline int pte_same(pte_t pte_a, pte_t pte_b)
  */
 static inline void set_pte(pte_t *ptep, pte_t pteval)
 {
-	WRITE_ONCE(*ptep, pteval);
+	*ptep = pteval;
 }
 
 static inline pte_t ptep_get(pte_t *ptep)
@@ -953,10 +953,9 @@ extern int ptep_test_and_clear_young(struct vm_area_struct *vma, unsigned long a
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 				       unsigned long address, pte_t *ptep)
 {
-	pte_t pte = __pte(atomic_long_xchg((atomic_long_t *)ptep, 0));
-
+	pte_t pte = ptep_get(ptep);
+	pte_clear(mm, address, ptep);
 	page_table_check_pte_clear(mm, pte);
-
 	return pte;
 }
 
@@ -964,7 +963,8 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 static inline void ptep_set_wrprotect(struct mm_struct *mm,
 				      unsigned long address, pte_t *ptep)
 {
-	atomic_long_and(~(unsigned long)_PAGE_WRITE, (atomic_long_t *)ptep);
+	pte_t old_pte = ptep_get(ptep);
+	set_pte(ptep, pte_wrprotect(old_pte));
 }
 
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
@@ -1170,8 +1170,9 @@ static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
 static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
 					unsigned long address, pmd_t *pmdp)
 {
-	pmd_t pmd = __pmd(atomic_long_xchg((atomic_long_t *)pmdp, 0));
+	pmd_t pmd = pmdp_get(pmdp);
 
+	pmd_clear(pmdp);
 	page_table_check_pmd_clear(mm, pmd);
 
 	return pmd;
@@ -1188,8 +1189,12 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm,
 static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 				unsigned long address, pmd_t *pmdp, pmd_t pmd)
 {
+	pmd_t old_pmd = pmdp_get(pmdp);
+
 	page_table_check_pmd_set(vma->vm_mm, pmdp, pmd);
-	return __pmd(atomic_long_xchg((atomic_long_t *)pmdp, pmd_val(pmd)));
+	set_pmd(pmdp, pmd);
+
+	return old_pmd;
 }
 
 #define pmdp_collapse_flush pmdp_collapse_flush
diff --git a/arch/riscv/kernel/hibernate.c b/arch/riscv/kernel/hibernate.c
index 155be6b1d32c..5018d38f5280 100644
--- a/arch/riscv/kernel/hibernate.c
+++ b/arch/riscv/kernel/hibernate.c
@@ -171,7 +171,7 @@ static int temp_pgtable_map_pte(pmd_t *dst_pmdp, pmd_t *src_pmdp, unsigned long
 	pte_t *src_ptep;
 	pte_t *dst_ptep;
 
-	if (pmd_none(READ_ONCE(*dst_pmdp))) {
+	if (pmd_none(pmdp_get_lockless(dst_pmdp))) {
 		dst_ptep = (pte_t *)get_safe_page(GFP_ATOMIC);
 		if (!dst_ptep)
 			return -ENOMEM;
@@ -183,7 +183,7 @@ static int temp_pgtable_map_pte(pmd_t *dst_pmdp, pmd_t *src_pmdp, unsigned long
 	src_ptep = pte_offset_kernel(src_pmdp, start);
 
 	do {
-		pte_t pte = READ_ONCE(*src_ptep);
+		pte_t pte = ptep_get_lockless(src_ptep);
 
 		if (pte_present(pte))
 			set_pte(dst_ptep, __pte(pte_val(pte) | pgprot_val(prot)));
@@ -200,7 +200,7 @@ static int temp_pgtable_map_pmd(pud_t *dst_pudp, pud_t *src_pudp, unsigned long
 	pmd_t *src_pmdp;
 	pmd_t *dst_pmdp;
 
-	if (pud_none(READ_ONCE(*dst_pudp))) {
+	if (pud_none(pudp_get_lockless(dst_pudp))) {
 		dst_pmdp = (pmd_t *)get_safe_page(GFP_ATOMIC);
 		if (!dst_pmdp)
 			return -ENOMEM;
@@ -212,7 +212,7 @@ static int temp_pgtable_map_pmd(pud_t *dst_pudp, pud_t *src_pudp, unsigned long
 	src_pmdp = pmd_offset(src_pudp, start);
 
 	do {
-		pmd_t pmd = READ_ONCE(*src_pmdp);
+		pmd_t pmd = pmdp_get_lockless(src_pmdp);
 
 		next = pmd_addr_end(start, end);
 
@@ -239,7 +239,7 @@ static int temp_pgtable_map_pud(p4d_t *dst_p4dp, p4d_t *src_p4dp, unsigned long
 	pud_t *dst_pudp;
 	pud_t *src_pudp;
 
-	if (p4d_none(READ_ONCE(*dst_p4dp))) {
+	if (p4d_none(p4dp_get_lockless(dst_p4dp))) {
 		dst_pudp = (pud_t *)get_safe_page(GFP_ATOMIC);
 		if (!dst_pudp)
 			return -ENOMEM;
@@ -251,7 +251,7 @@ static int temp_pgtable_map_pud(p4d_t *dst_p4dp, p4d_t *src_p4dp, unsigned long
 	src_pudp = pud_offset(src_p4dp, start);
 
 	do {
-		pud_t pud = READ_ONCE(*src_pudp);
+		pud_t pud = pudp_get_lockless(src_pudp);
 
 		next = pud_addr_end(start, end);
 
@@ -278,7 +278,7 @@ static int temp_pgtable_map_p4d(pgd_t *dst_pgdp, pgd_t *src_pgdp, unsigned long
 	p4d_t *dst_p4dp;
 	p4d_t *src_p4dp;
 
-	if (pgd_none(READ_ONCE(*dst_pgdp))) {
+	if (pgd_none(pgdp_get_lockless(dst_pgdp))) {
 		dst_p4dp = (p4d_t *)get_safe_page(GFP_ATOMIC);
 		if (!dst_p4dp)
 			return -ENOMEM;
@@ -290,7 +290,7 @@ static int temp_pgtable_map_p4d(pgd_t *dst_pgdp, pgd_t *src_pgdp, unsigned long
 	src_p4dp = p4d_offset(src_pgdp, start);
 
 	do {
-		p4d_t p4d = READ_ONCE(*src_p4dp);
+		p4d_t p4d = p4dp_get_lockless(src_p4dp);
 
 		next = p4d_addr_end(start, end);
 
@@ -317,7 +317,7 @@ static int temp_pgtable_mapping(pgd_t *pgdp, unsigned long start, unsigned long
 	unsigned long ret;
 
 	do {
-		pgd_t pgd = READ_ONCE(*src_pgdp);
+		pgd_t pgd = pgdp_get_lockless(src_pgdp);
 
 		next = pgd_addr_end(start, end);
 
diff --git a/arch/riscv/mm/pgtable.c b/arch/riscv/mm/pgtable.c
index f57ada26a183..150aea8e2d7a 100644
--- a/arch/riscv/mm/pgtable.c
+++ b/arch/riscv/mm/pgtable.c
@@ -128,9 +128,15 @@ int ptep_test_and_clear_young(struct vm_area_struct *vma,
 			      unsigned long address,
 			      pte_t *ptep)
 {
-	if (!pte_young(ptep_get(ptep)))
-		return 0;
-	return test_and_clear_bit(_PAGE_ACCESSED_OFFSET, &pte_val(*ptep));
+	int r = 1;
+	pte_t pte = ptep_get(ptep);
+
+	if (!pte_young(pte))
+		r = 0;
+	else
+		set_pte(ptep, pte_mkold(pte));
+
+	return r;
 }
 EXPORT_SYMBOL_GPL(ptep_test_and_clear_young);
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index df27d08a7232..84d49c60f55b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7709,7 +7709,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
 	pte_t *ptep, pte;
 
 	pgdp = pgd_offset(mm, addr);
-	pgd = READ_ONCE(*pgdp);
+	pgd = pgdp_get_lockless(pgdp);
 	if (pgd_none(pgd))
 		return 0;
 
@@ -7717,7 +7717,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
 		return pgd_leaf_size(pgd);
 
 	p4dp = p4d_offset_lockless(pgdp, pgd, addr);
-	p4d = READ_ONCE(*p4dp);
+	p4d = p4dp_get_lockless(p4dp);
 	if (!p4d_present(p4d))
 		return 0;
 
@@ -7725,7 +7725,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
 		return p4d_leaf_size(p4d);
 
 	pudp = pud_offset_lockless(p4dp, p4d, addr);
-	pud = READ_ONCE(*pudp);
+	pud = pudp_get_lockless(pudp);
 	if (!pud_present(pud))
 		return 0;
 
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index bc748f700a9e..1cec548cc6c7 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -438,7 +438,7 @@ static void __init pmd_huge_tests(struct pgtable_debug_args *args)
 	 * X86 defined pmd_set_huge() verifies that the given
 	 * PMD is not a populated non-leaf entry.
 	 */
-	WRITE_ONCE(*args->pmdp, __pmd(0));
+	set_pmd(args->pmdp, __pmd(0));
 	WARN_ON(!pmd_set_huge(args->pmdp, __pfn_to_phys(args->fixed_pmd_pfn), args->page_prot));
 	WARN_ON(!pmd_clear_huge(args->pmdp));
 	pmd = pmdp_get(args->pmdp);
@@ -458,7 +458,7 @@ static void __init pud_huge_tests(struct pgtable_debug_args *args)
 	 * X86 defined pud_set_huge() verifies that the given
 	 * PUD is not a populated non-leaf entry.
 	 */
-	WRITE_ONCE(*args->pudp, __pud(0));
+	set_pud(args->pudp, __pud(0));
 	WARN_ON(!pud_set_huge(args->pudp, __pfn_to_phys(args->fixed_pud_pfn), args->page_prot));
 	WARN_ON(!pud_clear_huge(args->pudp));
 	pud = pudp_get(args->pudp);
diff --git a/mm/gup.c b/mm/gup.c
index ad0c8922dac3..db444d732028 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1004,7 +1004,7 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
 	struct mm_struct *mm = vma->vm_mm;
 
 	pudp = pud_offset(p4dp, address);
-	pud = READ_ONCE(*pudp);
+	pud = pudp_get_lockless(pudp);
 	if (!pud_present(pud))
 		return no_page_table(vma, flags, address);
 	if (pud_leaf(pud)) {
@@ -1029,7 +1029,7 @@ static struct page *follow_p4d_mask(struct vm_area_struct *vma,
 	p4d_t *p4dp, p4d;
 
 	p4dp = p4d_offset(pgdp, address);
-	p4d = READ_ONCE(*p4dp);
+	p4d = p4dp_get_lockless(p4dp);
 	BUILD_BUG_ON(p4d_leaf(p4d));
 
 	if (!p4d_present(p4d) || p4d_bad(p4d))
@@ -3259,7 +3259,7 @@ static int gup_fast_pud_range(p4d_t *p4dp, p4d_t p4d, unsigned long addr,
 
 	pudp = pud_offset_lockless(p4dp, p4d, addr);
 	do {
-		pud_t pud = READ_ONCE(*pudp);
+		pud_t pud = pudp_get_lockless(pudp);
 
 		next = pud_addr_end(addr, end);
 		if (unlikely(!pud_present(pud)))
@@ -3285,7 +3285,7 @@ static int gup_fast_p4d_range(pgd_t *pgdp, pgd_t pgd, unsigned long addr,
 
 	p4dp = p4d_offset_lockless(pgdp, pgd, addr);
 	do {
-		p4d_t p4d = READ_ONCE(*p4dp);
+		p4d_t p4d = p4dp_get_lockless(p4dp);
 
 		next = p4d_addr_end(addr, end);
 		if (!p4d_present(p4d))
@@ -3307,7 +3307,7 @@ static void gup_fast_pgd_range(unsigned long addr, unsigned long end,
 
 	pgdp = pgd_offset(current->mm, addr);
 	do {
-		pgd_t pgd = READ_ONCE(*pgdp);
+		pgd_t pgd = pgdp_get_lockless(pgdp);
 
 		next = pgd_addr_end(addr, end);
 		if (pgd_none(pgd))
diff --git a/mm/hmm.c b/mm/hmm.c
index 7e0229ae4a5a..fa56b735883e 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -423,7 +423,7 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
 	/* Normally we don't want to split the huge page */
 	walk->action = ACTION_CONTINUE;
 
-	pud = READ_ONCE(*pudp);
+	pud = pudp_get_lockless(pudp);
 	if (!pud_present(pud)) {
 		spin_unlock(ptl);
 		return hmm_vma_walk_hole(start, end, -1, walk);
diff --git a/mm/mapping_dirty_helpers.c b/mm/mapping_dirty_helpers.c
index 2f8829b3541a..8771432c3300 100644
--- a/mm/mapping_dirty_helpers.c
+++ b/mm/mapping_dirty_helpers.c
@@ -149,7 +149,7 @@ static int wp_clean_pud_entry(pud_t *pud, unsigned long addr, unsigned long end,
 			      struct mm_walk *walk)
 {
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
-	pud_t pudval = READ_ONCE(*pud);
+	pud_t pudval = pudp_get_lockless(pud);
 
 	/* Do not split a huge pud */
 	if (pud_trans_huge(pudval) || pud_devmap(pudval)) {
diff --git a/mm/memory.c b/mm/memory.c
index bdf77a3ec47b..03ee104cb009 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6428,12 +6428,12 @@ int follow_pfnmap_start(struct follow_pfnmap_args *args)
 		goto out;
 
 	p4dp = p4d_offset(pgdp, address);
-	p4d = READ_ONCE(*p4dp);
+	p4d = p4dp_get_lockless(p4dp);
 	if (p4d_none(p4d) || unlikely(p4d_bad(p4d)))
 		goto out;
 
 	pudp = pud_offset(p4dp, address);
-	pud = READ_ONCE(*pudp);
+	pud = pudp_get_lockless(pudp);
 	if (pud_none(pud))
 		goto out;
 	if (pud_leaf(pud)) {
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 6f450af3252e..a165ab597a73 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -447,7 +447,7 @@ static inline long change_pud_range(struct mmu_gather *tlb,
 			break;
 		}
 
-		pud = READ_ONCE(*pudp);
+		pud = pudp_get_lockless(pudp);
 		if (pud_none(pud))
 			continue;
 
diff --git a/mm/ptdump.c b/mm/ptdump.c
index 106e1d66e9f9..b8a2ad43392f 100644
--- a/mm/ptdump.c
+++ b/mm/ptdump.c
@@ -30,7 +30,7 @@ static int ptdump_pgd_entry(pgd_t *pgd, unsigned long addr,
 			    unsigned long next, struct mm_walk *walk)
 {
 	struct ptdump_state *st = walk->private;
-	pgd_t val = READ_ONCE(*pgd);
+	pgd_t val = pgdp_get_lockless(pgd);
 
 #if CONFIG_PGTABLE_LEVELS > 4 && \
 		(defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS))
@@ -53,7 +53,7 @@ static int ptdump_p4d_entry(p4d_t *p4d, unsigned long addr,
 			    unsigned long next, struct mm_walk *walk)
 {
 	struct ptdump_state *st = walk->private;
-	p4d_t val = READ_ONCE(*p4d);
+	p4d_t val = p4dp_get_lockless(p4d);
 
 #if CONFIG_PGTABLE_LEVELS > 3 && \
 		(defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS))
@@ -76,7 +76,7 @@ static int ptdump_pud_entry(pud_t *pud, unsigned long addr,
 			    unsigned long next, struct mm_walk *walk)
 {
 	struct ptdump_state *st = walk->private;
-	pud_t val = READ_ONCE(*pud);
+	pud_t val = pudp_get_lockless(pud);
 
 #if CONFIG_PGTABLE_LEVELS > 2 && \
 		(defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS))
@@ -99,7 +99,7 @@ static int ptdump_pmd_entry(pmd_t *pmd, unsigned long addr,
 			    unsigned long next, struct mm_walk *walk)
 {
 	struct ptdump_state *st = walk->private;
-	pmd_t val = READ_ONCE(*pmd);
+	pmd_t val = pmdp_get_lockless(pmd);
 
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 	if (pmd_page(val) == virt_to_page(lm_alias(kasan_early_shadow_pte)))
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index c0388b2e959d..6621fb096fd0 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -337,7 +337,7 @@ int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
 			return -ENOMEM;
 
 		pmd = pmd_offset(pud, addr);
-		if (pmd_none(READ_ONCE(*pmd))) {
+		if (pmd_none(pmdp_get_lockless(pmd))) {
 			void *p;
 
 			p = vmemmap_alloc_block_buf(PMD_SIZE, node, altmap);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 28ba2b06fc7d..2bc78c339fd1 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3608,7 +3608,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned long start, unsigned long end,
 	pud = pud_offset(p4d, start & P4D_MASK);
 restart:
 	for (i = pud_index(start), addr = start; addr != end; i++, addr = next) {
-		pud_t val = READ_ONCE(pud[i]);
+		pud_t val = pudp_get_lockless(&pud[i]);
 
 		next = pud_addr_end(addr, end);
 
-- 
2.20.1


