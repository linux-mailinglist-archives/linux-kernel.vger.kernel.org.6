Return-Path: <linux-kernel+bounces-256288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1131934C1A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70D601F2374D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF34413A27D;
	Thu, 18 Jul 2024 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0BqZ54Zw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3+XbXImQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0BqZ54Zw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3+XbXImQ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3597413B587
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 10:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721300365; cv=none; b=tW1ffU+1/D6hG6YzrD7o0xHEIOBgPdw6pquVGiOpWrXBTrmv2zA8ex+yw2EGgA0zDcIlO/gdalW4dEYn3dt/Q0gxo9rM+uVwfxASwbIdYZH91o8MQsecbrYKsg4mqLP2Pt0h5teLS2velx3Z0Kc0bqncpKGSdB09SQiTRAJWcfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721300365; c=relaxed/simple;
	bh=CxxCImlYx/cW7ogJJ7JNwJj25oMlHl89RoTEx6g5eeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEXidQfSI8HlYRXvnnAJiqPx37nj/4E+ll+4Q1wXRcQUnNPKVy42Ud6uAvv9tLaVwKMf+avnkL7ODHtTzu+Ag108CQaOaxMFC2gHhQTVopjSOlFirqzbdQK3DHab/EsT6yBa8f6zuucALGhG4D+F1mmLWQLPZSjgR3ZPoHjO398=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0BqZ54Zw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3+XbXImQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0BqZ54Zw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3+XbXImQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 789DF1FBB6;
	Thu, 18 Jul 2024 10:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721300361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ARCGlBH+AErS8v8bA8FKvTTqiUoGdHpGs2CLrGa0UzE=;
	b=0BqZ54ZwKBBe20BdIk0KLtnLclnG8vutmLC2UoziN9moLue+NCej2qJbUunAsIM/I/sPAF
	x5q5b7Hrkag+a5RNvj//GbJpnpyCGvxvRdgSLRs3deMS0DSxkyvd8IU1IGSt26gLxs4iMd
	xjDZM4qG5biNC4dHmaJpXf5NhudzX8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721300361;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ARCGlBH+AErS8v8bA8FKvTTqiUoGdHpGs2CLrGa0UzE=;
	b=3+XbXImQeSNN+5dnreGiTedzW+WLgV8UEQMOxsVdE3MgrleO7d7TxUt1rUHi+pMV6GNW0K
	nJm1JGT6M9RbtmAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721300361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ARCGlBH+AErS8v8bA8FKvTTqiUoGdHpGs2CLrGa0UzE=;
	b=0BqZ54ZwKBBe20BdIk0KLtnLclnG8vutmLC2UoziN9moLue+NCej2qJbUunAsIM/I/sPAF
	x5q5b7Hrkag+a5RNvj//GbJpnpyCGvxvRdgSLRs3deMS0DSxkyvd8IU1IGSt26gLxs4iMd
	xjDZM4qG5biNC4dHmaJpXf5NhudzX8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721300361;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ARCGlBH+AErS8v8bA8FKvTTqiUoGdHpGs2CLrGa0UzE=;
	b=3+XbXImQeSNN+5dnreGiTedzW+WLgV8UEQMOxsVdE3MgrleO7d7TxUt1rUHi+pMV6GNW0K
	nJm1JGT6M9RbtmAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70EBA136F7;
	Thu, 18 Jul 2024 10:59:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4BqjFoj1mGbnVAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 18 Jul 2024 10:59:20 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Peter Xu <peterx@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Michal Hocko <mhocko@suse.com>,
	Donet Tom <donettom@linux.ibm.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 7/9] mm: Drop hugetlb_get_unmapped_area{_*} functions
Date: Thu, 18 Jul 2024 12:59:01 +0200
Message-ID: <20240718105903.19617-8-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240718105903.19617-1-osalvador@suse.de>
References: <20240718105903.19617-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: 1.20
X-Spamd-Result: default: False [1.20 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: *

Hugetlb mappings are now handled through normal channels just like any
other mapping, so we no longer need hugetlb_get_unmapped_area* specific
functions.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 arch/parisc/mm/hugetlbpage.c     |  23 -------
 arch/powerpc/mm/book3s64/slice.c |  10 ---
 arch/s390/mm/hugetlbpage.c       |  84 ------------------------
 arch/sparc/mm/hugetlbpage.c      | 108 -------------------------------
 arch/x86/mm/hugetlbpage.c        | 100 ----------------------------
 fs/hugetlbfs/inode.c             |  86 ------------------------
 include/linux/hugetlb.h          |   5 --
 7 files changed, 416 deletions(-)

diff --git a/arch/parisc/mm/hugetlbpage.c b/arch/parisc/mm/hugetlbpage.c
index 0356199bd9e7..69c463d6ffd6 100644
--- a/arch/parisc/mm/hugetlbpage.c
+++ b/arch/parisc/mm/hugetlbpage.c
@@ -21,29 +21,6 @@
 #include <asm/mmu_context.h>
 
 
-unsigned long
-hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
-		unsigned long len, unsigned long pgoff, unsigned long flags)
-{
-	struct hstate *h = hstate_file(file);
-
-	if (len & ~huge_page_mask(h))
-		return -EINVAL;
-	if (len > TASK_SIZE)
-		return -ENOMEM;
-
-	if (flags & MAP_FIXED)
-		if (prepare_hugepage_range(file, addr, len))
-			return -EINVAL;
-
-	if (addr)
-		addr = ALIGN(addr, huge_page_size(h));
-
-	/* we need to make sure the colouring is OK */
-	return arch_get_unmapped_area(file, addr, len, pgoff, flags);
-}
-
-
 pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long addr, unsigned long sz)
 {
diff --git a/arch/powerpc/mm/book3s64/slice.c b/arch/powerpc/mm/book3s64/slice.c
index 6914b8de627c..6ce16bc330a2 100644
--- a/arch/powerpc/mm/book3s64/slice.c
+++ b/arch/powerpc/mm/book3s64/slice.c
@@ -811,14 +811,4 @@ unsigned long vma_mmu_pagesize(struct vm_area_struct *vma)
 
 	return 1UL << mmu_psize_to_shift(get_slice_psize(vma->vm_mm, vma->vm_start));
 }
-
-unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
-					unsigned long len, unsigned long pgoff,
-					unsigned long flags)
-{
-	if (radix_enabled())
-		return generic_hugetlb_get_unmapped_area(file, addr, len, pgoff, flags);
-
-	return slice_get_unmapped_area(addr, len, flags, file_to_psize(file), 1);
-}
 #endif
diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index 2675aab4acc7..e8d91428f3d1 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -243,87 +243,3 @@ bool __init arch_hugetlb_valid_size(unsigned long size)
 		return false;
 }
 
-static unsigned long hugetlb_get_unmapped_area_bottomup(struct file *file,
-		unsigned long addr, unsigned long len,
-		unsigned long pgoff, unsigned long flags)
-{
-	struct hstate *h = hstate_file(file);
-	struct vm_unmapped_area_info info = {};
-
-	info.length = len;
-	info.low_limit = current->mm->mmap_base;
-	info.high_limit = TASK_SIZE;
-	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
-	return vm_unmapped_area(&info);
-}
-
-static unsigned long hugetlb_get_unmapped_area_topdown(struct file *file,
-		unsigned long addr0, unsigned long len,
-		unsigned long pgoff, unsigned long flags)
-{
-	struct hstate *h = hstate_file(file);
-	struct vm_unmapped_area_info info = {};
-	unsigned long addr;
-
-	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
-	info.length = len;
-	info.low_limit = PAGE_SIZE;
-	info.high_limit = current->mm->mmap_base;
-	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
-	addr = vm_unmapped_area(&info);
-
-	/*
-	 * A failed mmap() very likely causes application failure,
-	 * so fall back to the bottom-up function here. This scenario
-	 * can happen with large stack limits and large mmap()
-	 * allocations.
-	 */
-	if (addr & ~PAGE_MASK) {
-		VM_BUG_ON(addr != -ENOMEM);
-		info.flags = 0;
-		info.low_limit = TASK_UNMAPPED_BASE;
-		info.high_limit = TASK_SIZE;
-		addr = vm_unmapped_area(&info);
-	}
-
-	return addr;
-}
-
-unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
-		unsigned long len, unsigned long pgoff, unsigned long flags)
-{
-	struct hstate *h = hstate_file(file);
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
-
-	if (len & ~huge_page_mask(h))
-		return -EINVAL;
-	if (len > TASK_SIZE - mmap_min_addr)
-		return -ENOMEM;
-
-	if (flags & MAP_FIXED) {
-		if (prepare_hugepage_range(file, addr, len))
-			return -EINVAL;
-		goto check_asce_limit;
-	}
-
-	if (addr) {
-		addr = ALIGN(addr, huge_page_size(h));
-		vma = find_vma(mm, addr);
-		if (TASK_SIZE - len >= addr && addr >= mmap_min_addr &&
-		    (!vma || addr + len <= vm_start_gap(vma)))
-			goto check_asce_limit;
-	}
-
-	if (!test_bit(MMF_TOPDOWN, &mm->flags))
-		addr = hugetlb_get_unmapped_area_bottomup(file, addr, len,
-				pgoff, flags);
-	else
-		addr = hugetlb_get_unmapped_area_topdown(file, addr, len,
-				pgoff, flags);
-	if (offset_in_page(addr))
-		return addr;
-
-check_asce_limit:
-	return check_asce_limit(mm, addr, len);
-}
diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index cc91ca7a1e18..eee601a0d2cf 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -19,114 +19,6 @@
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
 
-/* Slightly simplified from the non-hugepage variant because by
- * definition we don't have to worry about any page coloring stuff
- */
-
-static unsigned long hugetlb_get_unmapped_area_bottomup(struct file *filp,
-							unsigned long addr,
-							unsigned long len,
-							unsigned long pgoff,
-							unsigned long flags)
-{
-	struct hstate *h = hstate_file(filp);
-	unsigned long task_size = TASK_SIZE;
-	struct vm_unmapped_area_info info = {};
-
-	if (test_thread_flag(TIF_32BIT))
-		task_size = STACK_TOP32;
-
-	info.length = len;
-	info.low_limit = TASK_UNMAPPED_BASE;
-	info.high_limit = min(task_size, VA_EXCLUDE_START);
-	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
-	addr = vm_unmapped_area(&info);
-
-	if ((addr & ~PAGE_MASK) && task_size > VA_EXCLUDE_END) {
-		VM_BUG_ON(addr != -ENOMEM);
-		info.low_limit = VA_EXCLUDE_END;
-		info.high_limit = task_size;
-		addr = vm_unmapped_area(&info);
-	}
-
-	return addr;
-}
-
-static unsigned long
-hugetlb_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
-				  const unsigned long len,
-				  const unsigned long pgoff,
-				  const unsigned long flags)
-{
-	struct hstate *h = hstate_file(filp);
-	struct mm_struct *mm = current->mm;
-	unsigned long addr = addr0;
-	struct vm_unmapped_area_info info = {};
-
-	/* This should only ever run for 32-bit processes.  */
-	BUG_ON(!test_thread_flag(TIF_32BIT));
-
-	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
-	info.length = len;
-	info.low_limit = PAGE_SIZE;
-	info.high_limit = mm->mmap_base;
-	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
-	addr = vm_unmapped_area(&info);
-
-	/*
-	 * A failed mmap() very likely causes application failure,
-	 * so fall back to the bottom-up function here. This scenario
-	 * can happen with large stack limits and large mmap()
-	 * allocations.
-	 */
-	if (addr & ~PAGE_MASK) {
-		VM_BUG_ON(addr != -ENOMEM);
-		info.flags = 0;
-		info.low_limit = TASK_UNMAPPED_BASE;
-		info.high_limit = STACK_TOP32;
-		addr = vm_unmapped_area(&info);
-	}
-
-	return addr;
-}
-
-unsigned long
-hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
-		unsigned long len, unsigned long pgoff, unsigned long flags)
-{
-	struct hstate *h = hstate_file(file);
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
-	unsigned long task_size = TASK_SIZE;
-
-	if (test_thread_flag(TIF_32BIT))
-		task_size = STACK_TOP32;
-
-	if (len & ~huge_page_mask(h))
-		return -EINVAL;
-	if (len > task_size)
-		return -ENOMEM;
-
-	if (flags & MAP_FIXED) {
-		if (prepare_hugepage_range(file, addr, len))
-			return -EINVAL;
-		return addr;
-	}
-
-	if (addr) {
-		addr = ALIGN(addr, huge_page_size(h));
-		vma = find_vma(mm, addr);
-		if (task_size - len >= addr &&
-		    (!vma || addr + len <= vm_start_gap(vma)))
-			return addr;
-	}
-	if (!test_bit(MMF_TOPDOWN, &mm->flags))
-		return hugetlb_get_unmapped_area_bottomup(file, addr, len,
-				pgoff, flags);
-	else
-		return hugetlb_get_unmapped_area_topdown(file, addr, len,
-				pgoff, flags);
-}
 
 static pte_t sun4u_hugepage_shift_to_tte(pte_t entry, unsigned int shift)
 {
diff --git a/arch/x86/mm/hugetlbpage.c b/arch/x86/mm/hugetlbpage.c
index 807a5859a3c4..e0c03fe3a994 100644
--- a/arch/x86/mm/hugetlbpage.c
+++ b/arch/x86/mm/hugetlbpage.c
@@ -19,107 +19,7 @@
 #include <asm/tlbflush.h>
 #include <asm/elf.h>
 
-#ifdef CONFIG_HUGETLB_PAGE
-static unsigned long hugetlb_get_unmapped_area_bottomup(struct file *file,
-		unsigned long addr, unsigned long len,
-		unsigned long pgoff, unsigned long flags)
-{
-	struct hstate *h = hstate_file(file);
-	struct vm_unmapped_area_info info = {};
-
-	info.length = len;
-	info.low_limit = get_mmap_base(1);
-
-	/*
-	 * If hint address is above DEFAULT_MAP_WINDOW, look for unmapped area
-	 * in the full address space.
-	 */
-	info.high_limit = in_32bit_syscall() ?
-		task_size_32bit() : task_size_64bit(addr > DEFAULT_MAP_WINDOW);
-
-	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
-	return vm_unmapped_area(&info);
-}
-
-static unsigned long hugetlb_get_unmapped_area_topdown(struct file *file,
-		unsigned long addr, unsigned long len,
-		unsigned long pgoff, unsigned long flags)
-{
-	struct hstate *h = hstate_file(file);
-	struct vm_unmapped_area_info info = {};
-
-	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
-	info.length = len;
-	info.low_limit = PAGE_SIZE;
-	info.high_limit = get_mmap_base(0);
-
-	/*
-	 * If hint address is above DEFAULT_MAP_WINDOW, look for unmapped area
-	 * in the full address space.
-	 */
-	if (addr > DEFAULT_MAP_WINDOW && !in_32bit_syscall())
-		info.high_limit += TASK_SIZE_MAX - DEFAULT_MAP_WINDOW;
-
-	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
-	addr = vm_unmapped_area(&info);
-
-	/*
-	 * A failed mmap() very likely causes application failure,
-	 * so fall back to the bottom-up function here. This scenario
-	 * can happen with large stack limits and large mmap()
-	 * allocations.
-	 */
-	if (addr & ~PAGE_MASK) {
-		VM_BUG_ON(addr != -ENOMEM);
-		info.flags = 0;
-		info.low_limit = TASK_UNMAPPED_BASE;
-		info.high_limit = TASK_SIZE_LOW;
-		addr = vm_unmapped_area(&info);
-	}
 
-	return addr;
-}
-
-unsigned long
-hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
-		unsigned long len, unsigned long pgoff, unsigned long flags)
-{
-	struct hstate *h = hstate_file(file);
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
-
-	if (len & ~huge_page_mask(h))
-		return -EINVAL;
-
-	if (len > TASK_SIZE)
-		return -ENOMEM;
-
-	/* No address checking. See comment at mmap_address_hint_valid() */
-	if (flags & MAP_FIXED) {
-		if (prepare_hugepage_range(file, addr, len))
-			return -EINVAL;
-		return addr;
-	}
-
-	if (addr) {
-		addr &= huge_page_mask(h);
-		if (!mmap_address_hint_valid(addr, len))
-			goto get_unmapped_area;
-
-		vma = find_vma(mm, addr);
-		if (!vma || addr + len <= vm_start_gap(vma))
-			return addr;
-	}
-
-get_unmapped_area:
-	if (!test_bit(MMF_TOPDOWN, &mm->flags))
-		return hugetlb_get_unmapped_area_bottomup(file, addr, len,
-				pgoff, flags);
-	else
-		return hugetlb_get_unmapped_area_topdown(file, addr, len,
-				pgoff, flags);
-}
-#endif /* CONFIG_HUGETLB_PAGE */
 
 #ifdef CONFIG_X86_64
 bool __init arch_hugetlb_valid_size(unsigned long size)
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index d02b4bc6c5e9..4902220adf42 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -171,92 +171,6 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
  * Called under mmap_write_lock(mm).
  */
 
-static unsigned long
-hugetlb_get_unmapped_area_bottomup(struct file *file, unsigned long addr,
-		unsigned long len, unsigned long pgoff, unsigned long flags)
-{
-	struct hstate *h = hstate_file(file);
-	struct vm_unmapped_area_info info = {};
-
-	info.length = len;
-	info.low_limit = current->mm->mmap_base;
-	info.high_limit = arch_get_mmap_end(addr, len, flags);
-	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
-	return vm_unmapped_area(&info);
-}
-
-static unsigned long
-hugetlb_get_unmapped_area_topdown(struct file *file, unsigned long addr,
-		unsigned long len, unsigned long pgoff, unsigned long flags)
-{
-	struct hstate *h = hstate_file(file);
-	struct vm_unmapped_area_info info = {};
-
-	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
-	info.length = len;
-	info.low_limit = PAGE_SIZE;
-	info.high_limit = arch_get_mmap_base(addr, current->mm->mmap_base);
-	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
-	addr = vm_unmapped_area(&info);
-
-	/*
-	 * A failed mmap() very likely causes application failure,
-	 * so fall back to the bottom-up function here. This scenario
-	 * can happen with large stack limits and large mmap()
-	 * allocations.
-	 */
-	if (unlikely(offset_in_page(addr))) {
-		VM_BUG_ON(addr != -ENOMEM);
-		info.flags = 0;
-		info.low_limit = current->mm->mmap_base;
-		info.high_limit = arch_get_mmap_end(addr, len, flags);
-		addr = vm_unmapped_area(&info);
-	}
-
-	return addr;
-}
-
-unsigned long
-generic_hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
-				  unsigned long len, unsigned long pgoff,
-				  unsigned long flags)
-{
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
-	struct hstate *h = hstate_file(file);
-	const unsigned long mmap_end = arch_get_mmap_end(addr, len, flags);
-
-	if (len & ~huge_page_mask(h))
-		return -EINVAL;
-	if (len > TASK_SIZE)
-		return -ENOMEM;
-
-	if (flags & MAP_FIXED) {
-		if (prepare_hugepage_range(file, addr, len))
-			return -EINVAL;
-		return addr;
-	}
-
-	if (addr) {
-		addr = ALIGN(addr, huge_page_size(h));
-		vma = find_vma(mm, addr);
-		if (mmap_end - len >= addr &&
-		    (!vma || addr + len <= vm_start_gap(vma)))
-			return addr;
-	}
-
-	/*
-	 * Use MMF_TOPDOWN flag as a hint to use topdown routine.
-	 * If architectures have special needs, they should define their own
-	 * version of hugetlb_get_unmapped_area.
-	 */
-	if (test_bit(MMF_TOPDOWN, &mm->flags))
-		return hugetlb_get_unmapped_area_topdown(file, addr, len,
-				pgoff, flags);
-	return hugetlb_get_unmapped_area_bottomup(file, addr, len,
-			pgoff, flags);
-}
-
 unsigned long
 hugetlb_mmap_check_and_align(struct file *file, unsigned long addr,
 			     unsigned long len, unsigned long flags)
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 9183ef95dfb6..a83a2b331bab 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -559,11 +559,6 @@ unsigned long
 hugetlb_mmap_check_and_align(struct file *file, unsigned long addr,
 			     unsigned long len, unsigned long flags);
 
-unsigned long
-generic_hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
-				  unsigned long len, unsigned long pgoff,
-				  unsigned long flags);
-
 /*
  * huegtlb page specific state flags.  These flags are located in page.private
  * of the hugetlb head page.  Functions created via the below macros should be
-- 
2.45.2


