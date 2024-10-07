Return-Path: <linux-kernel+bounces-352950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1349199266C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8690DB2345C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 07:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FAA18F2F9;
	Mon,  7 Oct 2024 07:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pCbffnnO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yeHAAvDP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pCbffnnO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yeHAAvDP"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299A418CC16
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 07:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728287460; cv=none; b=ckiu+euEH68Srts23Tx91eGTKuewLuEUjFPCX62slGZ0iI1hkXezrggjHlxma1kiFTF1mBz5wDLDEFwuQHvWQlxcPB3nzF+VV2P8yrkcDUWuSk4jom+XegR6GH7cqzsfHGXUguHhUdUT0mMkywJupTyZ8jy6C0KpKlPdGyorXMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728287460; c=relaxed/simple;
	bh=rYzhqHYrufnC3aVgmSofKG0w1LZy7myDL4fbdfZPJdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZVW6Un128k5GyYNFB78fev67YD9+eE4Iu/RSHQG2ix3Vawjm9JCVFniwYumSAa+bM3ewykRh5EKHNAIyUz19sob/0abYQsJr2h8iq9NvkouY/s0zku1bVw2A8ctZLfk1t7fiteqmjn+BVW8eIOCdP8oeZG2sl075K+1/njS3rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pCbffnnO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yeHAAvDP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pCbffnnO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yeHAAvDP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6C4F11FD19;
	Mon,  7 Oct 2024 07:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728287456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BOWmyOrUA49R+sE8zSPv6nz1xxCqaVW3asR97FSYM6k=;
	b=pCbffnnOCFTSKXs4J8B/LuqPT8kBLJXmfQmr2BaL66TTeQXzIaQFcaIMcB+P0aXYWGNf7b
	I0s6EApTHE6em5yJfPkARghd9VLNHiYpUtW6fVcS2dStoI/Q/7DYIU6WIM4waYcAOIOMaU
	5xjEr/0pxAXlTKW40KmyXtC/BseUD5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728287456;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BOWmyOrUA49R+sE8zSPv6nz1xxCqaVW3asR97FSYM6k=;
	b=yeHAAvDPTOQz2A2QfB9YcyolhAigtelpmsrZWnPsTJ/2buFmBF7G7ZHa0ZsGVx82FFI7C2
	xSHcz+noKVsm2/Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728287456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BOWmyOrUA49R+sE8zSPv6nz1xxCqaVW3asR97FSYM6k=;
	b=pCbffnnOCFTSKXs4J8B/LuqPT8kBLJXmfQmr2BaL66TTeQXzIaQFcaIMcB+P0aXYWGNf7b
	I0s6EApTHE6em5yJfPkARghd9VLNHiYpUtW6fVcS2dStoI/Q/7DYIU6WIM4waYcAOIOMaU
	5xjEr/0pxAXlTKW40KmyXtC/BseUD5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728287456;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BOWmyOrUA49R+sE8zSPv6nz1xxCqaVW3asR97FSYM6k=;
	b=yeHAAvDPTOQz2A2QfB9YcyolhAigtelpmsrZWnPsTJ/2buFmBF7G7ZHa0ZsGVx82FFI7C2
	xSHcz+noKVsm2/Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDB4D132BD;
	Mon,  7 Oct 2024 07:50:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6M5oK9+SA2d6cQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 07 Oct 2024 07:50:55 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Peter Xu <peterx@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Donet Tom <donettom@linux.ibm.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Michal Hocko <mhocko@suse.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v4 7/9] mm: Drop hugetlb_get_unmapped_area{_*} functions
Date: Mon,  7 Oct 2024 09:50:35 +0200
Message-ID: <20241007075037.267650-8-osalvador@suse.de>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241007075037.267650-1-osalvador@suse.de>
References: <20241007075037.267650-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_RATELIMIT(0.00)[to_ip_from(RLgqtx3dhxu3ne7bo4p8poxdrt)];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -6.80
X-Spam-Flag: NO

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
 fs/hugetlbfs/inode.c             |  96 ++-------------------------
 include/linux/hugetlb.h          |   7 +-
 7 files changed, 6 insertions(+), 422 deletions(-)

diff --git a/arch/parisc/mm/hugetlbpage.c b/arch/parisc/mm/hugetlbpage.c
index aa664f7ddb63..e9d18cf25b79 100644
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
-	return arch_get_unmapped_area(file, addr, len, pgoff, flags, 0);
-}
 
 
 pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
diff --git a/arch/powerpc/mm/book3s64/slice.c b/arch/powerpc/mm/book3s64/slice.c
index 3a858f6b7270..bc9a39821d1c 100644
--- a/arch/powerpc/mm/book3s64/slice.c
+++ b/arch/powerpc/mm/book3s64/slice.c
@@ -814,14 +814,4 @@ unsigned long vma_mmu_pagesize(struct vm_area_struct *vma)
 
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
index 2c5f34e315d2..935c0ed3aa1e 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -171,96 +171,10 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
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
-__hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
-			    unsigned long len, unsigned long flags)
+hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
+			    unsigned long len, unsigned long pgoff,
+			    unsigned long flags)
 {
 	unsigned long addr0 = 0;
 	struct hstate *h = hstate_file(file);
@@ -272,7 +186,7 @@ __hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 	if (addr)
 		addr0 = ALIGN(addr, huge_page_size(h));
 
-	return mm_get_unmapped_area_vmflags(current->mm, file, addr, len, pgoff,
+	return mm_get_unmapped_area_vmflags(current->mm, file, addr0, len, pgoff,
 					    flags, 0);
 }
 
@@ -1308,7 +1222,7 @@ static const struct file_operations hugetlbfs_file_operations = {
 	.read_iter		= hugetlbfs_read_iter,
 	.mmap			= hugetlbfs_file_mmap,
 	.fsync			= noop_fsync,
-	.get_unmapped_area	= __hugetlb_get_unmapped_area,
+	.get_unmapped_area	= hugetlb_get_unmapped_area,
 	.llseek			= default_llseek,
 	.fallocate		= hugetlbfs_fallocate,
 	.fop_flags		= FOP_HUGE_PAGES,
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 3a81b6126f62..ae4fe8615bb6 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -547,15 +547,10 @@ static inline struct hstate *hstate_inode(struct inode *i)
 #endif /* !CONFIG_HUGETLBFS */
 
 unsigned long
-__generic_hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
+hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 				    unsigned long len, unsigned long pgoff,
 				    unsigned long flags);
 
-unsigned long
-generic_hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
-				  unsigned long len, unsigned long pgoff,
-				  unsigned long flags);
-
 /*
  * huegtlb page specific state flags.  These flags are located in page.private
  * of the hugetlb head page.  Functions created via the below macros should be
-- 
2.46.1


