Return-Path: <linux-kernel+bounces-400586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 351ED9C0F9C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 582F81C22F7D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF2921832B;
	Thu,  7 Nov 2024 20:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wHQoezw9"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA88217F3B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 20:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731010843; cv=none; b=Cp0tYtxEr7nIlubG1Cho+imvYnytxfZ0kB+5BWKOp1buK/Lj3J86ry17UsR3XxTQ4QFbfjSbJUnU8gvFvFG314kbTGow5hsV5ISuTyJydvYgj37bSylkPdn1kqtNC6FTci8jE+0CSv9lqBL+zoQSOLpKxgpSqvLOu0jplYveUy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731010843; c=relaxed/simple;
	bh=3RHDmjo9FYFguNvGJrJfXL7WH3Mn/RPW5EohHUKeqY8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q4xHC1GQDJi71cLurGWZGE6VF1p4uoJG2ydpfqjNXnrF8rPGu4ukmvO1bs+C6w8WTkA1Ydq3HSewxdzX5jaMsyQItVIIOx26Amcb46u1b4eJcZmn20N7iVZOgAO7I1YXYoiom4I4sACBgLp01lUP3a6JKiRq/0Jvt2Vyta9iBPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wHQoezw9; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea8a5e862eso17895817b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 12:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731010840; x=1731615640; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1tthOirtAYAbVODGiUuOcdhR/O6us8nRui7ePy/4XFU=;
        b=wHQoezw9Cl4irMe8QCEq4t3frxAd6s3cb8qKAbiOOldr1nhd2jv9RJhJ7bdFyJw/S4
         X4vxCkTjaj3OciE/pjAJu1zIBc6pnSlU4GE9N8mt9ZvXgN+cHbfjitzrmru07ZOwfwP+
         a08RD8/O+RRic7iSQ8BicnN6S9OA33C7kLb+acbDflvDtdzzGj6ehnFA9cpjLOH/C1uy
         jWCEE8VqtJo7uPZyMYSVU1NgRCEc7j93n1fMfyFcgBUQT0+VMcP7TGx2bnArklX7hMMd
         F+e90J5dwaqNcPUN9ySkPsmPdOIkgZvTr2+8XAWCa6ux7Mo5ZC+rxjVmDFetaSL9U/3w
         M6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731010840; x=1731615640;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1tthOirtAYAbVODGiUuOcdhR/O6us8nRui7ePy/4XFU=;
        b=M3fgQWE4ThtMH8wb8HlM5fkGE5UjH0tfVaL/N6DNcRJSdgN7S+Lt1R3iKh3tBNfJu/
         y0lyxr6TDHibAD0Nha6Mqltxb3CQ96DHRdNb2CB+ZTzyayDF+ccrxav0q5FEFUPRHKyx
         5+otbjOQs+FpW/KHO12nDCyoafdomsUffvFsYsmF3hyloZH8f3CNIH7EU3Jsi0eC682c
         QVxEVWgKUYQeX1jDXE3Wi+yzDPz7zBdRRo+tAwcXok59WTjOQ+RvPvg1mAYZk3vqABIM
         QP2UJ0ax9nK8MIzHcYASefoPNbHQ+yF47FzUHvZZbjADWwSYWLlMCIdBfU/ilDQdf4au
         k98g==
X-Forwarded-Encrypted: i=1; AJvYcCV/Q/mVN/mLJ1v2F17TVkKez7r1oGVqYLX74Okj4OqtL78xiZwvA8Y4Nobp9FbBtj+HkHH0YnPbmERp1Dg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVkgm5bX4KiSYVRO4PvlEdo8MRlmuwGzEM1NsV8WZ/2q1bWNOM
	VSwZKz9M6kREnSHCh1B7VZNNhnnNQBpC1q/MKpBZptJaP+HXmaw6VOoduflo9q/8YJXAtAan+eG
	GkA==
X-Google-Smtp-Source: AGHT+IGTqsn/Xtckt6+UQcvmaBMjWwhX3GjS38ldjfYHLBKaWt3NH7a5E1E88BJehCRrOBEtvF7Ru96C8rA=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:a4c0:c64f:6cdd:91f8])
 (user=yuzhao job=sendgmr) by 2002:a05:690c:255:b0:6ea:4b3a:6703 with SMTP id
 00721157ae682-6eadc16949bmr149247b3.5.1731010840283; Thu, 07 Nov 2024
 12:20:40 -0800 (PST)
Date: Thu,  7 Nov 2024 13:20:28 -0700
In-Reply-To: <20241107202033.2721681-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107202033.2721681-1-yuzhao@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241107202033.2721681-2-yuzhao@google.com>
Subject: [PATCH v2 1/6] mm/hugetlb_vmemmap: batch-update PTEs
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>, Mark Rutland <mark.rutland@arm.com>, 
	Nanyong Sun <sunnanyong@huawei.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"

Convert vmemmap_remap_walk->remap_pte to ->remap_pte_range so that
vmemmap remap walks can batch-update PTEs.

The goal of this conversion is to allow architectures to implement
their own optimizations if possible, e.g., only to stop remote CPUs
once for each batch when updating vmemmap on arm64. It is not intended
to change the remap workflow nor should it by itself have any side
effects on performance.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/hugetlb_vmemmap.c | 163 ++++++++++++++++++++++++-------------------
 1 file changed, 91 insertions(+), 72 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 57b7f591eee8..46befab48d41 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -22,7 +22,7 @@
 /**
  * struct vmemmap_remap_walk - walk vmemmap page table
  *
- * @remap_pte:		called for each lowest-level entry (PTE).
+ * @remap_pte_range:	called on a range of PTEs.
  * @nr_walked:		the number of walked pte.
  * @reuse_page:		the page which is reused for the tail vmemmap pages.
  * @reuse_addr:		the virtual address of the @reuse_page page.
@@ -32,8 +32,8 @@
  *			operations.
  */
 struct vmemmap_remap_walk {
-	void			(*remap_pte)(pte_t *pte, unsigned long addr,
-					     struct vmemmap_remap_walk *walk);
+	void			(*remap_pte_range)(pte_t *pte, unsigned long start,
+					unsigned long end, struct vmemmap_remap_walk *walk);
 	unsigned long		nr_walked;
 	struct page		*reuse_page;
 	unsigned long		reuse_addr;
@@ -101,10 +101,6 @@ static int vmemmap_pmd_entry(pmd_t *pmd, unsigned long addr,
 	struct page *head;
 	struct vmemmap_remap_walk *vmemmap_walk = walk->private;
 
-	/* Only splitting, not remapping the vmemmap pages. */
-	if (!vmemmap_walk->remap_pte)
-		walk->action = ACTION_CONTINUE;
-
 	spin_lock(&init_mm.page_table_lock);
 	head = pmd_leaf(*pmd) ? pmd_page(*pmd) : NULL;
 	/*
@@ -129,33 +125,36 @@ static int vmemmap_pmd_entry(pmd_t *pmd, unsigned long addr,
 			ret = -ENOTSUPP;
 	}
 	spin_unlock(&init_mm.page_table_lock);
-	if (!head || ret)
+	if (ret)
 		return ret;
 
-	return vmemmap_split_pmd(pmd, head, addr & PMD_MASK, vmemmap_walk);
-}
+	if (head) {
+		ret = vmemmap_split_pmd(pmd, head, addr & PMD_MASK, vmemmap_walk);
+		if (ret)
+			return ret;
+	}
 
-static int vmemmap_pte_entry(pte_t *pte, unsigned long addr,
-			     unsigned long next, struct mm_walk *walk)
-{
-	struct vmemmap_remap_walk *vmemmap_walk = walk->private;
+	if (vmemmap_walk->remap_pte_range) {
+		pte_t *pte = pte_offset_kernel(pmd, addr);
 
-	/*
-	 * The reuse_page is found 'first' in page table walking before
-	 * starting remapping.
-	 */
-	if (!vmemmap_walk->reuse_page)
-		vmemmap_walk->reuse_page = pte_page(ptep_get(pte));
-	else
-		vmemmap_walk->remap_pte(pte, addr, vmemmap_walk);
-	vmemmap_walk->nr_walked++;
+		vmemmap_walk->nr_walked += (next - addr) / PAGE_SIZE;
+		/*
+		 * The reuse_page is found 'first' in page table walking before
+		 * starting remapping.
+		 */
+		if (!vmemmap_walk->reuse_page) {
+			vmemmap_walk->reuse_page = pte_page(ptep_get(pte));
+			pte++;
+			addr += PAGE_SIZE;
+		}
+		vmemmap_walk->remap_pte_range(pte, addr, next, vmemmap_walk);
+	}
 
 	return 0;
 }
 
 static const struct mm_walk_ops vmemmap_remap_ops = {
 	.pmd_entry	= vmemmap_pmd_entry,
-	.pte_entry	= vmemmap_pte_entry,
 };
 
 static int vmemmap_remap_range(unsigned long start, unsigned long end,
@@ -172,7 +171,7 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
 	if (ret)
 		return ret;
 
-	if (walk->remap_pte && !(walk->flags & VMEMMAP_REMAP_NO_TLB_FLUSH))
+	if (walk->remap_pte_range && !(walk->flags & VMEMMAP_REMAP_NO_TLB_FLUSH))
 		flush_tlb_kernel_range(start, end);
 
 	return 0;
@@ -204,33 +203,45 @@ static void free_vmemmap_page_list(struct list_head *list)
 		free_vmemmap_page(page);
 }
 
-static void vmemmap_remap_pte(pte_t *pte, unsigned long addr,
-			      struct vmemmap_remap_walk *walk)
+static void vmemmap_remap_pte_range(pte_t *pte, unsigned long start, unsigned long end,
+				    struct vmemmap_remap_walk *walk)
 {
-	/*
-	 * Remap the tail pages as read-only to catch illegal write operation
-	 * to the tail pages.
-	 */
-	pgprot_t pgprot = PAGE_KERNEL_RO;
-	struct page *page = pte_page(ptep_get(pte));
-	pte_t entry;
-
-	/* Remapping the head page requires r/w */
-	if (unlikely(addr == walk->reuse_addr)) {
-		pgprot = PAGE_KERNEL;
-		list_del(&walk->reuse_page->lru);
+	int i;
+	struct page *page;
+	int nr_pages = (end - start) / PAGE_SIZE;
 
+	for (i = 0; i < nr_pages; i++) {
+		page = pte_page(ptep_get(pte + i));
+
+		list_add(&page->lru, walk->vmemmap_pages);
+	}
+
+	page = walk->reuse_page;
+
+	if (start == walk->reuse_addr) {
+		list_del(&page->lru);
+		copy_page(page_to_virt(page), (void *)walk->reuse_addr);
 		/*
-		 * Makes sure that preceding stores to the page contents from
-		 * vmemmap_remap_free() become visible before the set_pte_at()
-		 * write.
+		 * Makes sure that preceding stores to the page contents become
+		 * visible before set_pte_at().
 		 */
 		smp_wmb();
 	}
 
-	entry = mk_pte(walk->reuse_page, pgprot);
-	list_add(&page->lru, walk->vmemmap_pages);
-	set_pte_at(&init_mm, addr, pte, entry);
+	for (i = 0; i < nr_pages; i++) {
+		pte_t val;
+
+		/*
+		 * The head page must be mapped read-write; the tail pages are
+		 * mapped read-only to catch illegal modifications.
+		 */
+		if (!i && start == walk->reuse_addr)
+			val = mk_pte(page, PAGE_KERNEL);
+		else
+			val = mk_pte(page, PAGE_KERNEL_RO);
+
+		set_pte_at(&init_mm, start + PAGE_SIZE * i, pte + i, val);
+	}
 }
 
 /*
@@ -252,27 +263,39 @@ static inline void reset_struct_pages(struct page *start)
 	memcpy(start, from, sizeof(*from) * NR_RESET_STRUCT_PAGE);
 }
 
-static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
-				struct vmemmap_remap_walk *walk)
+static void vmemmap_restore_pte_range(pte_t *pte, unsigned long start, unsigned long end,
+				      struct vmemmap_remap_walk *walk)
 {
-	pgprot_t pgprot = PAGE_KERNEL;
+	int i;
 	struct page *page;
-	void *to;
-
-	BUG_ON(pte_page(ptep_get(pte)) != walk->reuse_page);
+	int nr_pages = (end - start) / PAGE_SIZE;
 
 	page = list_first_entry(walk->vmemmap_pages, struct page, lru);
-	list_del(&page->lru);
-	to = page_to_virt(page);
-	copy_page(to, (void *)walk->reuse_addr);
-	reset_struct_pages(to);
+
+	for (i = 0; i < nr_pages; i++) {
+		BUG_ON(pte_page(ptep_get(pte + i)) != walk->reuse_page);
+
+		copy_page(page_to_virt(page), (void *)walk->reuse_addr);
+		reset_struct_pages(page_to_virt(page));
+
+		page = list_next_entry(page, lru);
+	}
 
 	/*
 	 * Makes sure that preceding stores to the page contents become visible
-	 * before the set_pte_at() write.
+	 * before set_pte_at().
 	 */
 	smp_wmb();
-	set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
+
+	for (i = 0; i < nr_pages; i++) {
+		pte_t val;
+
+		page = list_first_entry(walk->vmemmap_pages, struct page, lru);
+		list_del(&page->lru);
+
+		val = mk_pte(page, PAGE_KERNEL);
+		set_pte_at(&init_mm, start + PAGE_SIZE * i, pte + i, val);
+	}
 }
 
 /**
@@ -290,7 +313,6 @@ static int vmemmap_remap_split(unsigned long start, unsigned long end,
 			       unsigned long reuse)
 {
 	struct vmemmap_remap_walk walk = {
-		.remap_pte	= NULL,
 		.flags		= VMEMMAP_SPLIT_NO_TLB_FLUSH,
 	};
 
@@ -322,10 +344,10 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 {
 	int ret;
 	struct vmemmap_remap_walk walk = {
-		.remap_pte	= vmemmap_remap_pte,
-		.reuse_addr	= reuse,
-		.vmemmap_pages	= vmemmap_pages,
-		.flags		= flags,
+		.remap_pte_range	= vmemmap_remap_pte_range,
+		.reuse_addr		= reuse,
+		.vmemmap_pages		= vmemmap_pages,
+		.flags			= flags,
 	};
 	int nid = page_to_nid((struct page *)reuse);
 	gfp_t gfp_mask = GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
@@ -340,8 +362,6 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 	 */
 	walk.reuse_page = alloc_pages_node(nid, gfp_mask, 0);
 	if (walk.reuse_page) {
-		copy_page(page_to_virt(walk.reuse_page),
-			  (void *)walk.reuse_addr);
 		list_add(&walk.reuse_page->lru, vmemmap_pages);
 		memmap_pages_add(1);
 	}
@@ -371,10 +391,9 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 		 * They will be restored in the following call.
 		 */
 		walk = (struct vmemmap_remap_walk) {
-			.remap_pte	= vmemmap_restore_pte,
-			.reuse_addr	= reuse,
-			.vmemmap_pages	= vmemmap_pages,
-			.flags		= 0,
+			.remap_pte_range	= vmemmap_restore_pte_range,
+			.reuse_addr		= reuse,
+			.vmemmap_pages		= vmemmap_pages,
 		};
 
 		vmemmap_remap_range(reuse, end, &walk);
@@ -425,10 +444,10 @@ static int vmemmap_remap_alloc(unsigned long start, unsigned long end,
 {
 	LIST_HEAD(vmemmap_pages);
 	struct vmemmap_remap_walk walk = {
-		.remap_pte	= vmemmap_restore_pte,
-		.reuse_addr	= reuse,
-		.vmemmap_pages	= &vmemmap_pages,
-		.flags		= flags,
+		.remap_pte_range	= vmemmap_restore_pte_range,
+		.reuse_addr		= reuse,
+		.vmemmap_pages		= &vmemmap_pages,
+		.flags			= flags,
 	};
 
 	/* See the comment in the vmemmap_remap_free(). */
-- 
2.47.0.277.g8800431eea-goog


