Return-Path: <linux-kernel+bounces-282781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D902D94E885
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 365FAB213A5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E8216BE0D;
	Mon, 12 Aug 2024 08:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="SFMnKaw9"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23FE16ABF3
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 08:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723451175; cv=none; b=EBJTnkStNAByre0M6r+m6BAGIJPtOa98ZjIlujJjKtAVfSn1NGRf8TTaUyr+gvstzPmPcZukB30e1OyCb8Ok1P93bbmM79KXS1p6RJwycxcZ8ubMdB3YaM+NtwtBGACrb5k2aDgHJrv/Gq5AaqUMCE9oDY2vVmBCQkAIMIpbayE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723451175; c=relaxed/simple;
	bh=HAnJ9wnnADppZW4mHu6Mn2ny84Z1C8S3/Sj/3hYz/o0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KugXWUU1zPVzTJfm+SYMnWSpCF2O00vBIpi/U/u37J8QMzdrOQENCmWUp766ZgdMGPz5vK5zJ64VDAj2liCVcTEggHDxG05Zcr39ah+Sr0ZS4vLWR/cqOiM374AM6HFI6kKLwiIzmRASSA8iZsBiBfYBJvoH1HAQJ+588GXXk24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=SFMnKaw9; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1723451172;
	bh=84M21vyUGQcGCjX/ARQkrZuqRB4Zx/d2+mbl6H4Q7ow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SFMnKaw9wh079Fm21LEZE2EP0FiNYPA6cxjvDY/X293d4Kw0ckMkqmByMFqK9pO5G
	 jznvvg9zyPSEe8BR8lfLSrnywK78obH4o25/CtyUdQGY1T3yS/FPKTiIMBfkOzhZlw
	 lpSQgClEL38ZD8l3i3fEsLw54el67bLM2qmxSfgbx2tt0O5ky7Q5lIgDfS0JyY/38p
	 kRq3QyEWeizG93x51mx9p3qZzdUdxvad09CfVa4yp9B1vxA3gxqJ/ZU1myIJGRQyjQ
	 RZrZb/0mmAAYc9M4x9/2YDVAuQIX5RleBOohv8WkqB1JVrJYmyQfEinFNEbbQwBQgb
	 d62LsD0PLHWsA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Wj6zm00Kgz4x8x;
	Mon, 12 Aug 2024 18:26:11 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linux-mm@kvack.org>
Cc: <linuxppc-dev@lists.ozlabs.org>,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	christophe.leroy@csgroup.eu,
	jeffxu@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org,
	npiggin@gmail.com,
	oliver.sang@intel.com,
	pedro.falcato@gmail.com
Subject: [PATCH v2 3/4] mm: Remove arch_unmap()
Date: Mon, 12 Aug 2024 18:26:04 +1000
Message-ID: <20240812082605.743814-3-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240812082605.743814-1-mpe@ellerman.id.au>
References: <20240812082605.743814-1-mpe@ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that powerpc no longer uses arch_unmap() to handle VDSO unmapping,
there are no meaningful implementions left. Drop support for it
entirely, and update comments which refer to it.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/include/asm/mmu_context.h |  5 -----
 arch/x86/include/asm/mmu_context.h     |  5 -----
 include/asm-generic/mm_hooks.h         | 11 +++--------
 mm/mmap.c                              | 12 +++---------
 4 files changed, 6 insertions(+), 27 deletions(-)

v2: Unchanged except for collecting tags.

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 9b8c1555744e..a334a1368848 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -260,11 +260,6 @@ static inline void enter_lazy_tlb(struct mm_struct *mm,
 
 extern void arch_exit_mmap(struct mm_struct *mm);
 
-static inline void arch_unmap(struct mm_struct *mm,
-			      unsigned long start, unsigned long end)
-{
-}
-
 #ifdef CONFIG_PPC_MEM_KEYS
 bool arch_vma_access_permitted(struct vm_area_struct *vma, bool write,
 			       bool execute, bool foreign);
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 8dac45a2c7fc..80f2a3187aa6 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -232,11 +232,6 @@ static inline bool is_64bit_mm(struct mm_struct *mm)
 }
 #endif
 
-static inline void arch_unmap(struct mm_struct *mm, unsigned long start,
-			      unsigned long end)
-{
-}
-
 /*
  * We only want to enforce protection keys on the current process
  * because we effectively have no access to PKRU for other
diff --git a/include/asm-generic/mm_hooks.h b/include/asm-generic/mm_hooks.h
index 4dbb177d1150..6eea3b3c1e65 100644
--- a/include/asm-generic/mm_hooks.h
+++ b/include/asm-generic/mm_hooks.h
@@ -1,8 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Define generic no-op hooks for arch_dup_mmap, arch_exit_mmap
- * and arch_unmap to be included in asm-FOO/mmu_context.h for any
- * arch FOO which doesn't need to hook these.
+ * Define generic no-op hooks for arch_dup_mmap and arch_exit_mmap
+ * to be included in asm-FOO/mmu_context.h for any arch FOO which
+ * doesn't need to hook these.
  */
 #ifndef _ASM_GENERIC_MM_HOOKS_H
 #define _ASM_GENERIC_MM_HOOKS_H
@@ -17,11 +17,6 @@ static inline void arch_exit_mmap(struct mm_struct *mm)
 {
 }
 
-static inline void arch_unmap(struct mm_struct *mm,
-			unsigned long start, unsigned long end)
-{
-}
-
 static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
 		bool write, bool execute, bool foreign)
 {
diff --git a/mm/mmap.c b/mm/mmap.c
index af4dbf0d3bd4..a86aa58ca37b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2789,7 +2789,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
  *
  * This function takes a @mas that is either pointing to the previous VMA or set
  * to MA_START and sets it up to remove the mapping(s).  The @len will be
- * aligned and any arch_unmap work will be preformed.
+ * aligned.
  *
  * Return: 0 on success and drops the lock if so directed, error and leaves the
  * lock held otherwise.
@@ -2809,16 +2809,12 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 		return -EINVAL;
 
 	/*
-	 * Check if memory is sealed before arch_unmap.
-	 * Prevent unmapping a sealed VMA.
+	 * Check if memory is sealed, prevent unmapping a sealed VMA.
 	 * can_modify_mm assumes we have acquired the lock on MM.
 	 */
 	if (unlikely(!can_modify_mm(mm, start, end)))
 		return -EPERM;
 
-	 /* arch_unmap() might do unmaps itself.  */
-	arch_unmap(mm, start, end);
-
 	/* Find the first overlapping VMA */
 	vma = vma_find(vmi, end);
 	if (!vma) {
@@ -3232,14 +3228,12 @@ int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	struct mm_struct *mm = vma->vm_mm;
 
 	/*
-	 * Check if memory is sealed before arch_unmap.
-	 * Prevent unmapping a sealed VMA.
+	 * Check if memory is sealed, prevent unmapping a sealed VMA.
 	 * can_modify_mm assumes we have acquired the lock on MM.
 	 */
 	if (unlikely(!can_modify_mm(mm, start, end)))
 		return -EPERM;
 
-	arch_unmap(mm, start, end);
 	return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock);
 }
 
-- 
2.45.2


