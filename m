Return-Path: <linux-kernel+bounces-265403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B013B93F0A9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EA7F1F22C54
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71303143C60;
	Mon, 29 Jul 2024 09:10:48 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C2D14388F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722244247; cv=none; b=pcvCx5KaE1fP4L5yxvniAMgpVymRHPDCH38rSKzJOg5VGtFu3WF/Wj/rDQb7dHO3srcv0DWyrEWC/nRXSr/2ofgp9Tl2TpLuiO8l61hFQZNfv6W4Eia7h5B3actRCsyAhbrNkNqVVzt/QjRSAVj54OVm8wvNuM7gGAOphgleBOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722244247; c=relaxed/simple;
	bh=G1/8Fdwr/toGCioQxQLShNLSucpbCV3cLjXaIyEliPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kE+UDQIOMlsc0EAf2Cxi0IX7cIs91Zrt3cpL+VcRZHWH9hHU+/CQbi4wKDnKAnqdHb/sFyQV4qL9IAeho+R9iocfuS/atKpR3jCHHu9QN+WKnIFl3jfF+EKV9ROfQP30olOLmQUMHGjnIKKGESIeHAsfL19ytqrNEppOu3uXegk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5DB3821BDA;
	Mon, 29 Jul 2024 09:10:43 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9DAF91368A;
	Mon, 29 Jul 2024 09:10:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SJ2GIJFcp2Z4BgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 29 Jul 2024 09:10:41 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Peter Xu <peterx@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Donet Tom <donettom@linux.ibm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Michal Hocko <mhocko@suse.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 7/9] mm: Drop hugetlb_get_unmapped_area{_*} functions
Date: Mon, 29 Jul 2024 11:10:16 +0200
Message-ID: <20240729091018.2152-8-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240729091018.2152-1-osalvador@suse.de>
References: <20240729091018.2152-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 5DB3821BDA
X-Spam-Level: 
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00

Hugetlb mappings are now handled through normal channels just like any
other mapping, so we no longer need hugetlb_get_unmapped_area* specific
functions.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 arch/parisc/mm/hugetlbpage.c     |  21 ------
 arch/powerpc/mm/book3s64/slice.c |  10 ---
 arch/s390/mm/hugetlbpage.c       |  85 ------------------------
 arch/sparc/mm/hugetlbpage.c      | 108 -------------------------------
 arch/x86/mm/hugetlbpage.c        | 101 -----------------------------
 fs/hugetlbfs/inode.c             |  91 --------------------------
 include/linux/hugetlb.h          |   4 --
 7 files changed, 420 deletions(-)

diff --git a/arch/parisc/mm/hugetlbpage.c b/arch/parisc/mm/hugetlbpage.c
index 0356199bd9e7..e9d18cf25b79 100644
--- a/arch/parisc/mm/hugetlbpage.c
+++ b/arch/parisc/mm/hugetlbpage.c
@@ -21,27 +21,6 @@
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
 
 
 pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
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
index ded0eff58a19..7c79cf1bc7d7 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -242,88 +242,3 @@ bool __init arch_hugetlb_valid_size(unsigned long size)
 	else
 		return false;
 }
-
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
index 807a5859a3c4..58f7f2bd535d 100644
--- a/arch/x86/mm/hugetlbpage.c
+++ b/arch/x86/mm/hugetlbpage.c
@@ -19,107 +19,6 @@
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
index 5d47a2785a5d..3f0b8abbf851 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -167,97 +167,6 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	return ret;
 }
 
-/*
- * Called under mmap_write_lock(mm).
- */
-
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
-	struct vm_area_struct *vma, *prev;
-	struct hstate *h = hstate_file(file);
-	const unsigned long mmap_end = arch_get_mmap_end(addr, len, flags);
-
-	if (len & ~huge_page_mask(h))
-		return -EINVAL;
-	if (len > mmap_end - mmap_min_addr)
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
-		vma = find_vma_prev(mm, addr, &prev);
-		if (mmap_end - len >= addr && addr >= mmap_min_addr &&
-		    (!vma || addr + len <= vm_start_gap(vma)) &&
-		    (!prev || addr >= vm_end_gap(prev)))
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
index 1413cdcfdb1a..bd82a0f34275 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -553,10 +553,6 @@ unsigned long
 hugetlb_mmap_check_and_align(struct file *file, unsigned long addr,
 			     unsigned long len, unsigned long flags);
 
-unsigned long
-generic_hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
-				  unsigned long len, unsigned long pgoff,
-				  unsigned long flags);
 
 /*
  * huegtlb page specific state flags.  These flags are located in page.private
-- 
2.45.2


