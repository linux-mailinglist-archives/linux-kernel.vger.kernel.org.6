Return-Path: <linux-kernel+bounces-432976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 593579E528B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33CC7167CEF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BAC1D7E35;
	Thu,  5 Dec 2024 10:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jiMUABAQ"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058AD1DF983
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 10:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395093; cv=none; b=YmcsA5kK9OCutVMfc8Gm4YhZlH7yEzDolJDHXfkNS21i2YxYlPqOuH3Hh2aRwAZfJhbBIlYuAEGjsRuIZRDugCowHxdPxXt+BqdEawOBdZBY3VIRZPFtgqf3Pl5Pryd99l+WfBKIM4+rZuBlIcTy8FAX0pWQ9G0K+Jhj8kTfJag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395093; c=relaxed/simple;
	bh=42gI9iWeOqYKXWG+UM1aKNB9ZHJ4WDj8WIzuLk8JrdU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JzIdNEms7mvafm8deF8GQB6bP5deO7CA/46x45jSptdhl75JGDwlsSXlPN5hgxQkK4dolgw4Imtazo/0MSKCHPTTZ1dX4UA6ZhPPOk8MVLq/3L5qab3uQcllxh7Cdkz6dPoJotOyxB9f/KTkI2B4GOSshCWaqjO6GNIhepzJzYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jiMUABAQ; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7fcdbfd8090so606271a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 02:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733395091; x=1733999891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7hmUlID2KY6paYgoqiid5lfsbGFxDDCAN4DBvbC41c=;
        b=jiMUABAQJC8Sf5DBP7eHBzeDaeUTTYJKfm+Vw/cMUP8qq9Pqj/ygZbHwlzXIcub+60
         2Llds1P0jcpKG2FVKh3DOdGesGw66SwsmdruR7fVK4ZPsagjZO6ud5LUJ0XQnfJP6Zv0
         6BTO0ELm9OAQfKP6j0PEx508i+HwRNXcwQKJqPdN/rGPptldfFK5EUPWNkW95iP27j92
         NSFoXvNUmE2epIwZaIFXN+LsU4/9E5coycoEMeKE6A55WKIoqw+kp+WhlH//VqwbQtFc
         BKATaDbUgTheLpHedz4zcYDbZpNcOgZidvFZkGVbR8HTfusgikZGN+YJwJlzqT78gX7n
         dxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733395091; x=1733999891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O7hmUlID2KY6paYgoqiid5lfsbGFxDDCAN4DBvbC41c=;
        b=qonpwgsJ0C+BDiNy3g2uGWa8ma+YNJqvuh4XDTi97qDtCPKRVmCjMbub9D0LmSHINS
         EjKu3O5sCBKF3Te5L7BgEeeTHXD1SG6y+TcmVn8nBxzI8mA3TkFZ9Ls20XDq251RRXur
         n7aUmsm3KvZDqVWRk/+khL5SqQ5j7Xa65q5WKlwUIJTXP8C6CZFfeYDNlXJTkCwN3vr9
         ChmhjZfetNA53Q89iSR1cUmz20O1Y6E1y9NrlzORcuxy+XPpj9xl5FIZmlTYF8E59wFq
         uOb1RSeoxDHMaGo4rPqTBabHE9zuvyM98UCPtBoQcaVYtOHb2EKe8+skDW6m7o5gr460
         z77A==
X-Forwarded-Encrypted: i=1; AJvYcCVD1gPiNvzeNKranbZqA5OExye7lbD70R93SDwJ8KQnGB/EJr0OPiXZL0WZde4/WzIVsuPpc4EJ8hOrIes=@vger.kernel.org
X-Gm-Message-State: AOJu0YwykTUNqKToHrjZk4gU+/UPiETQJHScrijkhSPjZ7RilV26eIXq
	thGvgiez3o1WLbFfz9OD1KLfIVnBcBlRK4ph8pgOOw+8Bjs0DhItp/95BvLGEXE=
X-Gm-Gg: ASbGnctYvcsyl9BzIZfaUnIT3G5eqUF4ZUy/RyzUsiGNVE8mK2Byl37pJStFEFaurQU
	XU7kYUwTETBWRACKDVzvRHFoPNfiw/scRmrEX0XhgY/FqSNf2L7j5Ad+k0d/L3WpCajYKuF8eVV
	L7ScAz2ZZmXPEEXwSPomlC9gUfmTYZEv4vD5N+hP46JopjO928kjx0lhCb4B1POFf4boBTmZLqV
	MpCJhENAYtWy8JowHOaoQBbz0rftgaAM+WS1z0aEXfC8JZ1SHQkwKXuxcOm13n2cBNnGcMzIaOl
	Srl6nWtB0R82EXlMXLlW3MwMPau+Tw+d
X-Google-Smtp-Source: AGHT+IHbEOK4fVgmqFCn4T84ALhR/xBKYInyH1RV8Ugvahqt2YHHrGpIWPwGC34ww4f3ko0WEWYg3w==
X-Received: by 2002:a05:6a20:cfa4:b0:1e0:d104:4dbd with SMTP id adf61e73a8af0-1e16542f238mr16645992637.46.1733395091287;
        Thu, 05 Dec 2024 02:38:11 -0800 (PST)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd156f048csm886826a12.39.2024.12.05.02.38.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Dec 2024 02:38:11 -0800 (PST)
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
Subject: [RFC PATCH v2 08/21] riscv: mm: Reimplement page table entry atomic get function
Date: Thu,  5 Dec 2024 18:37:16 +0800
Message-Id: <20241205103729.14798-9-luxu.kernel@bytedance.com>
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

This commit implements lockless functions to atomically fetch pte's
value. For each pte structure, we atomically fetch the first mapping
entry, and then fetch the following entries and compare them with the
first mappin entry plus certain step path in a loop. If we find any
difference in their pfns or prots, then the pte structure has been
modified and need to be reloaded.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/pgtable.h | 156 +++++++++++++++++++++++++++++++
 include/linux/pgtable.h          |  21 +++++
 2 files changed, 177 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index ba4a083b7210..fe42afb4441e 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -220,6 +220,18 @@ static inline unsigned long satp_pfn(unsigned long satp)
 	return hwpfn_to_pfn(hwpfn);
 }
 
+static inline unsigned long __pte_pgprot(unsigned long pteval)
+{
+	unsigned long prot_mask = GENMASK(_PAGE_HWPFN_SHIFT - 1, 0);
+
+	return pteval & prot_mask;
+}
+
+static inline pgprot_t pte_pgprot(pte_t pte)
+{
+	return __pgprot(__pte_pgprot(pte_val(pte)));
+}
+
 static inline int __pgd_leaf(unsigned long pgdval)
 {
 	return __pgd_present(pgdval) && (pgdval & _PAGE_LEAF);
@@ -734,6 +746,150 @@ static inline pgd_t pgdp_get(pgd_t *pgdp)
 }
 #define pgdp_get	pgdp_get
 
+#ifdef CONFIG_RISCV_USE_SW_PAGE
+static inline pte_t ptep_get_lockless(pte_t *ptep)
+{
+	unsigned long pteval;
+	pte_t pte;
+	int i;
+
+retry:
+	pteval = READ_ONCE(ptep->ptes[0]);
+	pte = *ptep;
+	for (i = 0; i < HW_PAGES_PER_PAGE; i++) {
+		if (__page_val_to_pfn(pteval) !=
+		    __page_val_to_pfn(pte.ptes[i]))
+			goto retry;
+		if ((__pte_pgprot(pteval) | _PAGE_DIRTY | _PAGE_ACCESSED) !=
+		    (__pte_pgprot(pte.ptes[i]) | _PAGE_DIRTY | _PAGE_ACCESSED))
+			goto retry;
+
+		if (__pte_present(pteval) && !__pte_napot(pteval))
+			pteval += 1 << _PAGE_HWPFN_SHIFT;
+	}
+
+	return pte;
+}
+#define ptep_get_lockless	ptep_get_lockless
+
+static inline pmd_t pmdp_get_lockless(pmd_t *pmdp)
+{
+	unsigned long pmdval;
+	pmd_t pmd;
+	int i;
+
+retry:
+	pmdval = READ_ONCE(pmdp->pmds[0]);
+	pmd = *pmdp;
+	for (i = 0; i < HW_PAGES_PER_PAGE; i++) {
+		if (__page_val_to_pfn(pmdval) !=
+		    __page_val_to_pfn(pmd.pmds[i]))
+			goto retry;
+		if ((__pte_pgprot(pmdval) | _PAGE_DIRTY | _PAGE_ACCESSED) !=
+		    (__pte_pgprot(pmd.pmds[i]) | _PAGE_DIRTY | _PAGE_ACCESSED))
+			goto retry;
+
+		if (__pmd_leaf(pmdval))
+			pmdval += (1 << (PMD_SHIFT - PAGE_SHIFT)) <<
+					_PAGE_HWPFN_SHIFT;
+		else if (__pmd_present(pmdval))
+			pmdval += 1 << _PAGE_HWPFN_SHIFT;
+	}
+
+	return pmd;
+}
+#define pmdp_get_lockless	pmdp_get_lockless
+
+static inline void pmdp_get_lockless_sync(void)
+{
+}
+
+static inline pud_t pudp_get_lockless(pud_t *pudp)
+{
+	unsigned long pudval;
+	pud_t pud;
+	int i;
+
+retry:
+	pudval = READ_ONCE(pudp->puds[0]);
+	pud = *pudp;
+	for (i = 0; i < HW_PAGES_PER_PAGE; i++) {
+		if (__page_val_to_pfn(pudval) !=
+		    __page_val_to_pfn(pud.puds[i]))
+			goto retry;
+		if ((__pte_pgprot(pudval) | _PAGE_DIRTY | _PAGE_ACCESSED) !=
+		    (__pte_pgprot(pud.puds[i]) | _PAGE_DIRTY | _PAGE_ACCESSED))
+			goto retry;
+
+		if (__pud_leaf(pudval))
+			pudval += (1 << (PUD_SHIFT - PAGE_SHIFT)) <<
+					_PAGE_HWPFN_SHIFT;
+		else if (__pud_present(pudval))
+			pudval += 1 << _PAGE_HWPFN_SHIFT;
+	}
+
+	return pud;
+}
+#define pudp_get_lockless	pudp_get_lockless
+
+static inline p4d_t p4dp_get_lockless(p4d_t *p4dp)
+{
+	unsigned long p4dval;
+	p4d_t p4d;
+	int i;
+
+retry:
+	p4dval = READ_ONCE(p4dp->p4ds[0]);
+	p4d = *p4dp;
+	for (i = 0; i < HW_PAGES_PER_PAGE; i++) {
+		if (__page_val_to_pfn(p4dval) !=
+		    __page_val_to_pfn(p4d.p4ds[i]))
+			goto retry;
+		if ((__pte_pgprot(p4dval) | _PAGE_DIRTY | _PAGE_ACCESSED) !=
+		    (__pte_pgprot(p4d.p4ds[i]) | _PAGE_DIRTY | _PAGE_ACCESSED))
+			goto retry;
+
+		if (__p4d_leaf(p4dval))
+			p4dval += (1 << (P4D_SHIFT - PAGE_SHIFT)) <<
+					_PAGE_HWPFN_SHIFT;
+		else if (__p4d_present(p4dval))
+			p4dval += 1 << _PAGE_HWPFN_SHIFT;
+	}
+
+	return p4d;
+}
+#define p4dp_get_lockless	p4dp_get_lockless
+
+static inline pgd_t pgdp_get_lockless(pgd_t *pgdp)
+{
+	unsigned long pgdval;
+	pgd_t pgd;
+	int i;
+
+retry:
+	pgdval = READ_ONCE(pgdp->pgds[0]);
+	pgd = *pgdp;
+	for (i = 0; i < HW_PAGES_PER_PAGE; i++) {
+		if (__page_val_to_pfn(pgdval) !=
+		    __page_val_to_pfn(pgd.pgds[i]))
+			goto retry;
+		if ((__pte_pgprot(pgdval) | _PAGE_DIRTY | _PAGE_ACCESSED) !=
+		    (__pte_pgprot(pgd.pgds[i]) | _PAGE_DIRTY | _PAGE_ACCESSED))
+			goto retry;
+
+		if (__pgd_leaf(pgdval))
+			pgdval += (1 << (PGDIR_SHIFT - PAGE_SHIFT)) <<
+					_PAGE_HWPFN_SHIFT;
+		else if (__pgd_present(pgdval))
+			pgdval += 1 << _PAGE_HWPFN_SHIFT;
+	}
+
+	return pgd;
+}
+#define pgdp_get_lockless	pgdp_get_lockless
+
+#endif /* CONFIG_RISCV_USE_SW_PAGE */
+
 void flush_icache_pte(struct mm_struct *mm, pte_t pte);
 
 static inline void __set_pte_at(struct mm_struct *mm, pte_t *ptep, pte_t pteval)
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index e8b2ac6bd2ae..b629c48b980b 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -598,6 +598,27 @@ static inline void pmdp_get_lockless_sync(void)
 }
 #endif
 
+#ifndef pudp_get_lockless
+static inline pud_t pudp_get_lockless(pud_t *pudp)
+{
+	return pudp_get(pudp);
+}
+#endif
+
+#ifndef p4dp_get_lockless
+static inline p4d_t p4dp_get_lockless(p4d_t *p4dp)
+{
+	return p4dp_get(p4dp);
+}
+#endif
+
+#ifndef pgdp_get_lockless
+static inline pgd_t pgdp_get_lockless(pgd_t *pgdp)
+{
+	return pgdp_get(pgdp);
+}
+#endif
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #ifndef __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR
 static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
-- 
2.20.1


