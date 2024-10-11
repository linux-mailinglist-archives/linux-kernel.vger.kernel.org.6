Return-Path: <linux-kernel+bounces-360528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7540999C21
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F14B1C21DDC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 05:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BCD1F706F;
	Fri, 11 Oct 2024 05:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="W5S96Js7"
Received: from out0-217.mail.aliyun.com (out0-217.mail.aliyun.com [140.205.0.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7322F26
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 05:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728625138; cv=none; b=XS7PZG4dzEPhHJ+oFWjxC/kL7eajz/C2frRHuFnMU8hg8CFZY+kHcyqPCONdcalDXVdcC+FMZLcyzWh57MQARO96nQAFoxSsROLRK/fg+3TzupFvUOVQMwES1ZWD1zNXbxrlcyuecUL2HS0lZ1CAj9wHY/fK7CDUcCn3mxaRoyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728625138; c=relaxed/simple;
	bh=je7AxxxfVGgQ2asS0FCf9K7XxUDkJ4LgEifkyyTTWtU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oYzwKNuIum0miKJzVvp1dYozI/WzeaNWK/NdSFRZ1F4Av3PqmrGDIR08ZIQbgZj0KO5yzpsqNzs2UryFvBBTNA3o1o6O1UqmdiidMZi317o9OaBYSrIkknUuMbSa4GLLrZ3z50tyNmdfnxxPGLR25+HKjYi88SV9sKDDQz39x8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=W5S96Js7; arc=none smtp.client-ip=140.205.0.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1728625130; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=jNZvmtgMrhrSzhWeEFJbQqmXqmsoe+8jgh3kE3BJ/xc=;
	b=W5S96Js7cYOKInW3LPFdVraRlmEXV5kG3q88xGT/ZEUIsmMUCybdlcYYx8KrmN0zydzc7tbEIxUPNMza1wLUseGToI0xnDVkn1r+x9CG+x1cCEaxf4i47zNlsp6E6pu9xGz4TchH4mm9iSViUbZrOGhOPYkfJwLpaLB1juMU0jQ=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Ze6cW8F_1728625124)
          by smtp.aliyun-inc.com;
          Fri, 11 Oct 2024 13:38:50 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH] um: Abandon the _PAGE_NEWPROT bit
Date: Fri, 11 Oct 2024 13:38:43 +0800
Message-Id: <20241011053843.1623089-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a PTE is updated in the page table, the _PAGE_NEWPAGE bit will
always be set. And the corresponding page will always be mapped or
unmapped depending on whether the PTE is present or not. The check
on the _PAGE_NEWPROT bit is not really reachable. Abandoning it will
allow us to simplify the code and remove the unreachable code.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/asm/pgtable.h           | 40 ++++-----------
 arch/um/include/shared/os.h             |  2 -
 arch/um/include/shared/skas/stub-data.h |  1 -
 arch/um/kernel/skas/stub.c              | 10 ----
 arch/um/kernel/tlb.c                    | 66 +++++++++++--------------
 arch/um/os-Linux/skas/mem.c             | 21 --------
 6 files changed, 37 insertions(+), 103 deletions(-)

diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index bd7a9593705f..a32424cfe792 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -12,7 +12,6 @@
 
 #define _PAGE_PRESENT	0x001
 #define _PAGE_NEWPAGE	0x002
-#define _PAGE_NEWPROT	0x004
 #define _PAGE_RW	0x020
 #define _PAGE_USER	0x040
 #define _PAGE_ACCESSED	0x080
@@ -151,23 +150,12 @@ static inline int pte_newpage(pte_t pte)
 	return pte_get_bits(pte, _PAGE_NEWPAGE);
 }
 
-static inline int pte_newprot(pte_t pte)
-{
-	return(pte_present(pte) && (pte_get_bits(pte, _PAGE_NEWPROT)));
-}
-
 /*
  * =================================
  * Flags setting section.
  * =================================
  */
 
-static inline pte_t pte_mknewprot(pte_t pte)
-{
-	pte_set_bits(pte, _PAGE_NEWPROT);
-	return(pte);
-}
-
 static inline pte_t pte_mkclean(pte_t pte)
 {
 	pte_clear_bits(pte, _PAGE_DIRTY);
@@ -184,17 +172,14 @@ static inline pte_t pte_wrprotect(pte_t pte)
 {
 	if (likely(pte_get_bits(pte, _PAGE_RW)))
 		pte_clear_bits(pte, _PAGE_RW);
-	else
-		return pte;
-	return(pte_mknewprot(pte));
+	return pte;
 }
 
 static inline pte_t pte_mkread(pte_t pte)
 {
-	if (unlikely(pte_get_bits(pte, _PAGE_USER)))
-		return pte;
-	pte_set_bits(pte, _PAGE_USER);
-	return(pte_mknewprot(pte));
+	if (likely(!pte_get_bits(pte, _PAGE_USER)))
+		pte_set_bits(pte, _PAGE_USER);
+	return pte;
 }
 
 static inline pte_t pte_mkdirty(pte_t pte)
@@ -211,18 +196,15 @@ static inline pte_t pte_mkyoung(pte_t pte)
 
 static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
-	if (unlikely(pte_get_bits(pte,  _PAGE_RW)))
-		return pte;
-	pte_set_bits(pte, _PAGE_RW);
-	return(pte_mknewprot(pte));
+	if (likely(!pte_get_bits(pte, _PAGE_RW)))
+		pte_set_bits(pte, _PAGE_RW);
+	return pte;
 }
 
 static inline pte_t pte_mkuptodate(pte_t pte)
 {
 	pte_clear_bits(pte, _PAGE_NEWPAGE);
-	if(pte_present(pte))
-		pte_clear_bits(pte, _PAGE_NEWPROT);
-	return(pte);
+	return pte;
 }
 
 static inline pte_t pte_mknewpage(pte_t pte)
@@ -236,12 +218,10 @@ static inline void set_pte(pte_t *pteptr, pte_t pteval)
 	pte_copy(*pteptr, pteval);
 
 	/* If it's a swap entry, it needs to be marked _PAGE_NEWPAGE so
-	 * fix_range knows to unmap it.  _PAGE_NEWPROT is specific to
-	 * mapped pages.
+	 * update_pte_range knows to unmap it.
 	 */
 
 	*pteptr = pte_mknewpage(*pteptr);
-	if(pte_present(*pteptr)) *pteptr = pte_mknewprot(*pteptr);
 }
 
 #define PFN_PTE_SHIFT		PAGE_SHIFT
@@ -298,8 +278,6 @@ static inline int pte_same(pte_t pte_a, pte_t pte_b)
 	({ pte_t pte;					\
 							\
 	pte_set_val(pte, page_to_phys(page), (pgprot));	\
-	if (pte_present(pte))				\
-		pte_mknewprot(pte_mknewpage(pte));	\
 	pte;})
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index bf539fee7831..09f8201de5db 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -279,8 +279,6 @@ int map(struct mm_id *mm_idp, unsigned long virt,
 	unsigned long len, int prot, int phys_fd,
 	unsigned long long offset);
 int unmap(struct mm_id *mm_idp, unsigned long addr, unsigned long len);
-int protect(struct mm_id *mm_idp, unsigned long addr,
-	    unsigned long len, unsigned int prot);
 
 /* skas/process.c */
 extern int is_skas_winch(int pid, int fd, void *data);
diff --git a/arch/um/include/shared/skas/stub-data.h b/arch/um/include/shared/skas/stub-data.h
index 3fbdda727373..81a4cace032c 100644
--- a/arch/um/include/shared/skas/stub-data.h
+++ b/arch/um/include/shared/skas/stub-data.h
@@ -30,7 +30,6 @@ enum stub_syscall_type {
 	STUB_SYSCALL_UNSET = 0,
 	STUB_SYSCALL_MMAP,
 	STUB_SYSCALL_MUNMAP,
-	STUB_SYSCALL_MPROTECT,
 };
 
 struct stub_syscall {
diff --git a/arch/um/kernel/skas/stub.c b/arch/um/kernel/skas/stub.c
index 5d52ffa682dc..796fc266d3bb 100644
--- a/arch/um/kernel/skas/stub.c
+++ b/arch/um/kernel/skas/stub.c
@@ -35,16 +35,6 @@ static __always_inline int syscall_handler(struct stub_data *d)
 				return -1;
 			}
 			break;
-		case STUB_SYSCALL_MPROTECT:
-			res = stub_syscall3(__NR_mprotect,
-					    sc->mem.addr, sc->mem.length,
-					    sc->mem.prot);
-			if (res) {
-				d->err = res;
-				d->syscall_data_len = i;
-				return -1;
-			}
-			break;
 		default:
 			d->err = -95; /* EOPNOTSUPP */
 			d->syscall_data_len = i;
diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 548af31d4111..23c1f550cd7c 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -23,9 +23,6 @@ struct vm_ops {
 		    int phys_fd, unsigned long long offset);
 	int (*unmap)(struct mm_id *mm_idp,
 		     unsigned long virt, unsigned long len);
-	int (*mprotect)(struct mm_id *mm_idp,
-			unsigned long virt, unsigned long len,
-			unsigned int prot);
 };
 
 static int kern_map(struct mm_id *mm_idp,
@@ -44,15 +41,6 @@ static int kern_unmap(struct mm_id *mm_idp,
 	return os_unmap_memory((void *)virt, len);
 }
 
-static int kern_mprotect(struct mm_id *mm_idp,
-			 unsigned long virt, unsigned long len,
-			 unsigned int prot)
-{
-	return os_protect_memory((void *)virt, len,
-				 prot & UM_PROT_READ, prot & UM_PROT_WRITE,
-				 1);
-}
-
 void report_enomem(void)
 {
 	printk(KERN_ERR "UML ran out of memory on the host side! "
@@ -65,33 +53,37 @@ static inline int update_pte_range(pmd_t *pmd, unsigned long addr,
 				   struct vm_ops *ops)
 {
 	pte_t *pte;
-	int r, w, x, prot, ret = 0;
+	int ret = 0;
 
 	pte = pte_offset_kernel(pmd, addr);
 	do {
-		r = pte_read(*pte);
-		w = pte_write(*pte);
-		x = pte_exec(*pte);
-		if (!pte_young(*pte)) {
-			r = 0;
-			w = 0;
-		} else if (!pte_dirty(*pte))
-			w = 0;
-
-		prot = ((r ? UM_PROT_READ : 0) | (w ? UM_PROT_WRITE : 0) |
-			(x ? UM_PROT_EXEC : 0));
-		if (pte_newpage(*pte)) {
-			if (pte_present(*pte)) {
-				__u64 offset;
-				unsigned long phys = pte_val(*pte) & PAGE_MASK;
-				int fd = phys_mapping(phys, &offset);
-
-				ret = ops->mmap(ops->mm_idp, addr, PAGE_SIZE,
-						prot, fd, offset);
-			} else
-				ret = ops->unmap(ops->mm_idp, addr, PAGE_SIZE);
-		} else if (pte_newprot(*pte))
-			ret = ops->mprotect(ops->mm_idp, addr, PAGE_SIZE, prot);
+		if (!pte_newpage(*pte))
+			continue;
+
+		if (pte_present(*pte)) {
+			__u64 offset;
+			unsigned long phys = pte_val(*pte) & PAGE_MASK;
+			int fd = phys_mapping(phys, &offset);
+			int r, w, x, prot;
+
+			r = pte_read(*pte);
+			w = pte_write(*pte);
+			x = pte_exec(*pte);
+			if (!pte_young(*pte)) {
+				r = 0;
+				w = 0;
+			} else if (!pte_dirty(*pte))
+				w = 0;
+
+			prot = (r ? UM_PROT_READ : 0) |
+			       (w ? UM_PROT_WRITE : 0) |
+			       (x ? UM_PROT_EXEC : 0);
+
+			ret = ops->mmap(ops->mm_idp, addr, PAGE_SIZE,
+					prot, fd, offset);
+		} else
+			ret = ops->unmap(ops->mm_idp, addr, PAGE_SIZE);
+
 		*pte = pte_mkuptodate(*pte);
 	} while (pte++, addr += PAGE_SIZE, ((addr < end) && !ret));
 	return ret;
@@ -180,11 +172,9 @@ int um_tlb_sync(struct mm_struct *mm)
 	if (mm == &init_mm) {
 		ops.mmap = kern_map;
 		ops.unmap = kern_unmap;
-		ops.mprotect = kern_mprotect;
 	} else {
 		ops.mmap = map;
 		ops.unmap = unmap;
-		ops.mprotect = protect;
 	}
 
 	pgd = pgd_offset(mm, addr);
diff --git a/arch/um/os-Linux/skas/mem.c b/arch/um/os-Linux/skas/mem.c
index 9a13ac23c606..d7f1814b0e5a 100644
--- a/arch/um/os-Linux/skas/mem.c
+++ b/arch/um/os-Linux/skas/mem.c
@@ -217,24 +217,3 @@ int unmap(struct mm_id *mm_idp, unsigned long addr, unsigned long len)
 
 	return 0;
 }
-
-int protect(struct mm_id *mm_idp, unsigned long addr, unsigned long len,
-	    unsigned int prot)
-{
-	struct stub_syscall *sc;
-
-	/* Compress with previous syscall if that is possible */
-	sc = syscall_stub_get_previous(mm_idp, STUB_SYSCALL_MPROTECT, addr);
-	if (sc && sc->mem.prot == prot) {
-		sc->mem.length += len;
-		return 0;
-	}
-
-	sc = syscall_stub_alloc(mm_idp);
-	sc->syscall = STUB_SYSCALL_MPROTECT;
-	sc->mem.addr = addr;
-	sc->mem.length = len;
-	sc->mem.prot = prot;
-
-	return 0;
-}
-- 
2.34.1


