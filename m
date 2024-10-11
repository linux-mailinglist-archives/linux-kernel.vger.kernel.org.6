Return-Path: <linux-kernel+bounces-360921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E05F999A162
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E40021C21B82
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0E8212636;
	Fri, 11 Oct 2024 10:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="sH5JPMa6"
Received: from out0-222.mail.aliyun.com (out0-222.mail.aliyun.com [140.205.0.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6542120FABE
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728642567; cv=none; b=pFBPelDRu8PQ9/bbb7Jy4zcA+xs9JIaCU0KrvllByQdutd978hW8Mnctps+mSM7T1RdVBdkUSgiSPDBtlCKRzlcEbor76drF1tAqgrS3i6ablGN1SPuY58OEkwBS5P4m98vex/cz6B9A+/So5Wm+a1RH75+9RN8aeW8F7GdMoqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728642567; c=relaxed/simple;
	bh=1PF5qlKCHH2hxsepeI6WsPBxUBf7yo+or0Bf5Q8fyHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NI8aHNVh3v9uD5yrG+ZQnf/nNBADKRkRXEHarqma773WTRjvkikSEBFcjri94EfaY+iPAd4KGEbhyvLEfxQ6lnh1esilPBxVrKPv119d9n2CG1q2ZWUFKkHzy/1PZ8KIHLFRCjCXr+Y8nWXHE0bMxgCtN16jQPpkplRsMOFN3IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=sH5JPMa6; arc=none smtp.client-ip=140.205.0.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1728642561; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=0xE8I/eqX8wXeraGOlsIj0r7xfdCnIf/HQneg4xzk8Q=;
	b=sH5JPMa65s1GAzNyZE36D3+f4EA2TfGFIKBmXkv3ugLt+31rlzc2zDVIja8cWy3seVGVVMRQLnV/g+522MjNx4iXO/XdUA8JyaoY68apDRyQ/Ta73yZPABta8vk8Kec6UC5S/T+HQ+1kBjxONliHFYTL0TCB8k3N7ma+gGjmgho=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZeXjAJE_1728642243 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 11 Oct 2024 18:24:04 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
   <benjamin@sipsolutions.net>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>,
  "Benjamin Berg" <benjamin.berg@intel.com>
Subject: [PATCH v2 2/2] um: Rename _PAGE_NEWPAGE to _PAGE_NEEDSYNC
Date: Fri, 11 Oct 2024 18:23:54 +0800
Message-Id: <20241011102354.1682626-3-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011102354.1682626-1-tiwei.btw@antgroup.com>
References: <20241011102354.1682626-1-tiwei.btw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The _PAGE_NEWPAGE bit does not really indicate that this is a new page,
but rather whether this entry needs to be synced or not. Renaming it
to _PAGE_NEEDSYNC will make it more clear how everything ties together.

Suggested-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/asm/page.h           |  2 +-
 arch/um/include/asm/pgtable-2level.h |  2 +-
 arch/um/include/asm/pgtable-4level.h | 14 +++++-----
 arch/um/include/asm/pgtable.h        | 38 ++++++++++++++--------------
 arch/um/kernel/tlb.c                 | 10 ++++----
 5 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/arch/um/include/asm/page.h b/arch/um/include/asm/page.h
index f0ad80fc8c10..99aa459c7c6c 100644
--- a/arch/um/include/asm/page.h
+++ b/arch/um/include/asm/page.h
@@ -56,7 +56,7 @@ typedef struct { unsigned long pud; } pud_t;
 #define pte_set_bits(p, bits) ((p).pte |= (bits))
 #define pte_clear_bits(p, bits) ((p).pte &= ~(bits))
 #define pte_copy(to, from) ((to).pte = (from).pte)
-#define pte_is_zero(p) (!((p).pte & ~_PAGE_NEWPAGE))
+#define pte_is_zero(p) (!((p).pte & ~_PAGE_NEEDSYNC))
 #define pte_set_val(p, phys, prot) (p).pte = (phys | pgprot_val(prot))
 
 typedef unsigned long phys_t;
diff --git a/arch/um/include/asm/pgtable-2level.h b/arch/um/include/asm/pgtable-2level.h
index 8256ecc5b919..ab0c8dd86564 100644
--- a/arch/um/include/asm/pgtable-2level.h
+++ b/arch/um/include/asm/pgtable-2level.h
@@ -31,7 +31,7 @@
         printk("%s:%d: bad pgd %p(%08lx).\n", __FILE__, __LINE__, &(e), \
 	       pgd_val(e))
 
-static inline int pgd_newpage(pgd_t pgd)	{ return 0; }
+static inline int pgd_needsync(pgd_t pgd)	{ return 0; }
 static inline void pgd_mkuptodate(pgd_t pgd)	{ }
 
 #define set_pmd(pmdptr, pmdval) (*(pmdptr) = (pmdval))
diff --git a/arch/um/include/asm/pgtable-4level.h b/arch/um/include/asm/pgtable-4level.h
index f912fcc16b7a..0d279caee93c 100644
--- a/arch/um/include/asm/pgtable-4level.h
+++ b/arch/um/include/asm/pgtable-4level.h
@@ -55,7 +55,7 @@
         printk("%s:%d: bad pgd %p(%016lx).\n", __FILE__, __LINE__, &(e), \
 	       pgd_val(e))
 
-#define pud_none(x)	(!(pud_val(x) & ~_PAGE_NEWPAGE))
+#define pud_none(x)	(!(pud_val(x) & ~_PAGE_NEEDSYNC))
 #define	pud_bad(x)	((pud_val(x) & (~PAGE_MASK & ~_PAGE_USER)) != _KERNPG_TABLE)
 #define pud_present(x)	(pud_val(x) & _PAGE_PRESENT)
 #define pud_populate(mm, pud, pmd) \
@@ -63,7 +63,7 @@
 
 #define set_pud(pudptr, pudval) (*(pudptr) = (pudval))
 
-#define p4d_none(x)	(!(p4d_val(x) & ~_PAGE_NEWPAGE))
+#define p4d_none(x)	(!(p4d_val(x) & ~_PAGE_NEEDSYNC))
 #define	p4d_bad(x)	((p4d_val(x) & (~PAGE_MASK & ~_PAGE_USER)) != _KERNPG_TABLE)
 #define p4d_present(x)	(p4d_val(x) & _PAGE_PRESENT)
 #define p4d_populate(mm, p4d, pud) \
@@ -72,23 +72,23 @@
 #define set_p4d(p4dptr, p4dval) (*(p4dptr) = (p4dval))
 
 
-static inline int pgd_newpage(pgd_t pgd)
+static inline int pgd_needsync(pgd_t pgd)
 {
-	return(pgd_val(pgd) & _PAGE_NEWPAGE);
+	return pgd_val(pgd) & _PAGE_NEEDSYNC;
 }
 
-static inline void pgd_mkuptodate(pgd_t pgd) { pgd_val(pgd) &= ~_PAGE_NEWPAGE; }
+static inline void pgd_mkuptodate(pgd_t pgd) { pgd_val(pgd) &= ~_PAGE_NEEDSYNC; }
 
 #define set_pmd(pmdptr, pmdval) (*(pmdptr) = (pmdval))
 
 static inline void pud_clear (pud_t *pud)
 {
-	set_pud(pud, __pud(_PAGE_NEWPAGE));
+	set_pud(pud, __pud(_PAGE_NEEDSYNC));
 }
 
 static inline void p4d_clear (p4d_t *p4d)
 {
-	set_p4d(p4d, __p4d(_PAGE_NEWPAGE));
+	set_p4d(p4d, __p4d(_PAGE_NEEDSYNC));
 }
 
 #define pud_page(pud) phys_to_page(pud_val(pud) & PAGE_MASK)
diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index 6b1317400190..12bfc58a8580 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -11,7 +11,7 @@
 #include <asm/fixmap.h>
 
 #define _PAGE_PRESENT	0x001
-#define _PAGE_NEWPAGE	0x002
+#define _PAGE_NEEDSYNC	0x002
 #define _PAGE_RW	0x020
 #define _PAGE_USER	0x040
 #define _PAGE_ACCESSED	0x080
@@ -79,22 +79,22 @@ extern unsigned long end_iomem;
  */
 #define ZERO_PAGE(vaddr) virt_to_page(empty_zero_page)
 
-#define pte_clear(mm,addr,xp) pte_set_val(*(xp), (phys_t) 0, __pgprot(_PAGE_NEWPAGE))
+#define pte_clear(mm, addr, xp) pte_set_val(*(xp), (phys_t) 0, __pgprot(_PAGE_NEEDSYNC))
 
-#define pmd_none(x)	(!((unsigned long)pmd_val(x) & ~_PAGE_NEWPAGE))
+#define pmd_none(x)	(!((unsigned long)pmd_val(x) & ~_PAGE_NEEDSYNC))
 #define	pmd_bad(x)	((pmd_val(x) & (~PAGE_MASK & ~_PAGE_USER)) != _KERNPG_TABLE)
 
 #define pmd_present(x)	(pmd_val(x) & _PAGE_PRESENT)
-#define pmd_clear(xp)	do { pmd_val(*(xp)) = _PAGE_NEWPAGE; } while (0)
+#define pmd_clear(xp)	do { pmd_val(*(xp)) = _PAGE_NEEDSYNC; } while (0)
 
-#define pmd_newpage(x)  (pmd_val(x) & _PAGE_NEWPAGE)
-#define pmd_mkuptodate(x) (pmd_val(x) &= ~_PAGE_NEWPAGE)
+#define pmd_needsync(x)   (pmd_val(x) & _PAGE_NEEDSYNC)
+#define pmd_mkuptodate(x) (pmd_val(x) &= ~_PAGE_NEEDSYNC)
 
-#define pud_newpage(x)  (pud_val(x) & _PAGE_NEWPAGE)
-#define pud_mkuptodate(x) (pud_val(x) &= ~_PAGE_NEWPAGE)
+#define pud_needsync(x)   (pud_val(x) & _PAGE_NEEDSYNC)
+#define pud_mkuptodate(x) (pud_val(x) &= ~_PAGE_NEEDSYNC)
 
-#define p4d_newpage(x)  (p4d_val(x) & _PAGE_NEWPAGE)
-#define p4d_mkuptodate(x) (p4d_val(x) &= ~_PAGE_NEWPAGE)
+#define p4d_needsync(x)   (p4d_val(x) & _PAGE_NEEDSYNC)
+#define p4d_mkuptodate(x) (p4d_val(x) &= ~_PAGE_NEEDSYNC)
 
 #define pmd_pfn(pmd) (pmd_val(pmd) >> PAGE_SHIFT)
 #define pmd_page(pmd) phys_to_page(pmd_val(pmd) & PAGE_MASK)
@@ -145,9 +145,9 @@ static inline int pte_young(pte_t pte)
 	return pte_get_bits(pte, _PAGE_ACCESSED);
 }
 
-static inline int pte_newpage(pte_t pte)
+static inline int pte_needsync(pte_t pte)
 {
-	return pte_get_bits(pte, _PAGE_NEWPAGE);
+	return pte_get_bits(pte, _PAGE_NEEDSYNC);
 }
 
 /*
@@ -200,13 +200,13 @@ static inline pte_t pte_mkwrite_novma(pte_t pte)
 
 static inline pte_t pte_mkuptodate(pte_t pte)
 {
-	pte_clear_bits(pte, _PAGE_NEWPAGE);
+	pte_clear_bits(pte, _PAGE_NEEDSYNC);
 	return pte;
 }
 
-static inline pte_t pte_mknewpage(pte_t pte)
+static inline pte_t pte_mkneedsync(pte_t pte)
 {
-	pte_set_bits(pte, _PAGE_NEWPAGE);
+	pte_set_bits(pte, _PAGE_NEEDSYNC);
 	return(pte);
 }
 
@@ -214,11 +214,11 @@ static inline void set_pte(pte_t *pteptr, pte_t pteval)
 {
 	pte_copy(*pteptr, pteval);
 
-	/* If it's a swap entry, it needs to be marked _PAGE_NEWPAGE so
+	/* If it's a swap entry, it needs to be marked _PAGE_NEEDSYNC so
 	 * update_pte_range knows to unmap it.
 	 */
 
-	*pteptr = pte_mknewpage(*pteptr);
+	*pteptr = pte_mkneedsync(*pteptr);
 }
 
 #define PFN_PTE_SHIFT		PAGE_SHIFT
@@ -258,7 +258,7 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 #define __HAVE_ARCH_PTE_SAME
 static inline int pte_same(pte_t pte_a, pte_t pte_b)
 {
-	return !((pte_val(pte_a) ^ pte_val(pte_b)) & ~_PAGE_NEWPAGE);
+	return !((pte_val(pte_a) ^ pte_val(pte_b)) & ~_PAGE_NEEDSYNC);
 }
 
 /*
@@ -308,7 +308,7 @@ extern pte_t *virt_to_pte(struct mm_struct *mm, unsigned long addr);
  *   <--------------- offset ----------------> E < type -> 0 0 0 1 0
  *
  *   E is the exclusive marker that is not stored in swap entries.
- *   _PAGE_NEWPAGE (bit 1) is always set to 1 in set_pte().
+ *   _PAGE_NEEDSYNC (bit 1) is always set to 1 in set_pte().
  */
 #define __swp_type(x)			(((x).val >> 5) & 0x1f)
 #define __swp_offset(x)			((x).val >> 11)
diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 23c1f550cd7c..cf7e0d4407f2 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -57,7 +57,7 @@ static inline int update_pte_range(pmd_t *pmd, unsigned long addr,
 
 	pte = pte_offset_kernel(pmd, addr);
 	do {
-		if (!pte_newpage(*pte))
+		if (!pte_needsync(*pte))
 			continue;
 
 		if (pte_present(*pte)) {
@@ -101,7 +101,7 @@ static inline int update_pmd_range(pud_t *pud, unsigned long addr,
 	do {
 		next = pmd_addr_end(addr, end);
 		if (!pmd_present(*pmd)) {
-			if (pmd_newpage(*pmd)) {
+			if (pmd_needsync(*pmd)) {
 				ret = ops->unmap(ops->mm_idp, addr,
 						 next - addr);
 				pmd_mkuptodate(*pmd);
@@ -124,7 +124,7 @@ static inline int update_pud_range(p4d_t *p4d, unsigned long addr,
 	do {
 		next = pud_addr_end(addr, end);
 		if (!pud_present(*pud)) {
-			if (pud_newpage(*pud)) {
+			if (pud_needsync(*pud)) {
 				ret = ops->unmap(ops->mm_idp, addr,
 						 next - addr);
 				pud_mkuptodate(*pud);
@@ -147,7 +147,7 @@ static inline int update_p4d_range(pgd_t *pgd, unsigned long addr,
 	do {
 		next = p4d_addr_end(addr, end);
 		if (!p4d_present(*p4d)) {
-			if (p4d_newpage(*p4d)) {
+			if (p4d_needsync(*p4d)) {
 				ret = ops->unmap(ops->mm_idp, addr,
 						 next - addr);
 				p4d_mkuptodate(*p4d);
@@ -181,7 +181,7 @@ int um_tlb_sync(struct mm_struct *mm)
 	do {
 		next = pgd_addr_end(addr, mm->context.sync_tlb_range_to);
 		if (!pgd_present(*pgd)) {
-			if (pgd_newpage(*pgd)) {
+			if (pgd_needsync(*pgd)) {
 				ret = ops.unmap(ops.mm_idp, addr,
 						next - addr);
 				pgd_mkuptodate(*pgd);
-- 
2.34.1


