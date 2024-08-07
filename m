Return-Path: <linux-kernel+bounces-277903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A30994A7EC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE1A1C21927
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A951E7A33;
	Wed,  7 Aug 2024 12:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="re1F/HFl"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0FB1E673E
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 12:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723034481; cv=none; b=DG+e537QMAUEv+UZIqkrUkCMo3d8vrb+XpKI9hhA4OD/Mo42ly+HoodIs36OR/EQ1CIM7eRuWrshFgsByRtl0b2iwyuIxlwkrLW0TKteI/QBcIS3x2dpjnR6ih56LKWCBK5bxlavKpBWWbz++ikyjoKc9r6KnTKCafsrU+N5gUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723034481; c=relaxed/simple;
	bh=nwsawbgPE9DKXMD/rk5K3Gd3GJ+Mgf1vFc/XKJTYnMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u4HWREo5YsW4XTgbIDN719DW+KXMfR/Mv/CnQbw+vzcKuv80zFtg2swFPmNqL0vbYlgC8pUNKaYNyQlv6DuNt5g0QJ2Z6uzPhu+M40h55B0jClG6IADmrL0c3VL31p7FhD0KB6oB5KAOVhurMLdMQ24Ypeclj0L5mXaiXvmf5Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=re1F/HFl; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1723034478;
	bh=QjfKRN3jFgFE9slzX/Y7/OFqIAzh7Vj4YduCO+Bbs98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=re1F/HFllgXuLG0vL03AaY1ZdY9ENmZMfwFbyeOUiEJQCOf3WuIi8t9ohKoypRrwe
	 TjwlXQOS/9cYjEzOnNTn/fu97NsI9/LjkXfLrh7a2jt+O9No/p9gDwiHgfYSKPB6ca
	 XHWAAbp2+kQLMbHzwi0+IAqRLON3nuzaoCKUPKJEZn/0fr7kodZgSUtdMv6l9gFK8B
	 Fe/csI1WU6YFiiAh3nZHdIS3qXBtbpVtjoedRXqfktjVN1rA8m6M7oWGmKEmfOKS1a
	 GxNGEayC9TISOdGLQHPApNFmAcUEyzG/YJiE+u3VM+OBsjZl69jGJIubsSbogLVszK
	 +y50sJBEiKt/A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Wf8tP6syQz4wbp;
	Wed,  7 Aug 2024 22:41:17 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linux-mm@kvack.org>
Cc: <linuxppc-dev@lists.ozlabs.org>,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	christophe.leroy@csgroup.eu,
	jeffxu@chromium.org,
	jeffxu@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org,
	npiggin@gmail.com,
	oliver.sang@intel.com,
	pedro.falcato@gmail.com
Subject: [PATCH 3/4] mm: Remove arch_unmap()
Date: Wed,  7 Aug 2024 22:41:02 +1000
Message-ID: <20240807124103.85644-3-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807124103.85644-1-mpe@ellerman.id.au>
References: <20240807124103.85644-1-mpe@ellerman.id.au>
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
---
 arch/powerpc/include/asm/mmu_context.h |  5 -----
 arch/x86/include/asm/mmu_context.h     |  5 -----
 include/asm-generic/mm_hooks.h         | 11 +++--------
 mm/mmap.c                              | 12 +++---------
 4 files changed, 6 insertions(+), 27 deletions(-)

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
index 24bd6aa9155c..adaaf1ef197a 100644
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


