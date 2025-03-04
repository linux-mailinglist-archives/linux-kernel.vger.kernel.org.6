Return-Path: <linux-kernel+bounces-544798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18451A4E677
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89BE98A2CDB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C74E2BD5AB;
	Tue,  4 Mar 2025 15:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PNlPlB31"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AC329B23F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103342; cv=none; b=cBCi5E116yacZHdMb5xNzt+go58PpNsT+yqMIpRNaKz4K5jepG8+prPMDfzLu2WgMzGgdPX299owHDAX7ntGOmVb9QzrhydqfQYjtqEtSOvUbpvjlsmD8xvNv8r54gmpmnJkEfJedb2/eaxadXh+teILVV3TeOHqe88WVl2Z06Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103342; c=relaxed/simple;
	bh=nsp+uT9TiQsWVra7pS0tTd3IXrvabNIr1AHBlduKTTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YB5yXxGojcCx7sHKucmvkPQ+pj+vffeM+GQXdc//uM0ApH2adf4+AgKFmVktCYCayOjHu6o72BUm3DFckPogLSIH0iwp7W9QIZ7A8yC6G9K2Nih3da9NbyiKkoMgFj77dAo5c4863K2hWxmWzhs6MYh1S1GJ4XTiYCC9pZC18gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PNlPlB31; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741103339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wgfV1BFqVf16XcSyPrOW+mvJosHJK6PFcKJVrOW03zU=;
	b=PNlPlB31H18WlJPpmueadNoze99fUHJO4NbsdCQ5vLIST9HL6CNTxPiak1LJAFk9APK8KL
	Bj++Dy9kawqv1gY6Tbf4nuVFJZjpjSB6JOlCYQmXDP/aqkbkVm20Yj/7o/d84443KlXnb7
	sEjK6d/gdntwfGLmelvQQD1IVdDAX+M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-gLBqkiaaMWqkPud3ai1B_Q-1; Tue, 04 Mar 2025 10:48:58 -0500
X-MC-Unique: gLBqkiaaMWqkPud3ai1B_Q-1
X-Mimecast-MFC-AGG-ID: gLBqkiaaMWqkPud3ai1B_Q_1741103336
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3910cd78330so959072f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 07:48:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741103336; x=1741708136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wgfV1BFqVf16XcSyPrOW+mvJosHJK6PFcKJVrOW03zU=;
        b=Hj5/a1XefSeTKHfnYfXYRkLcLdarHjMXZCL2QX0mti4kVVqWR++b0yypbuvPm7urgB
         vBEsQYs3mA41gr5DK+M+R9eYa95ofwVQEx9RLr1Twqjv7Sx+750u+YoQLH5TRmB1KMkR
         kSL9gWOp7XeLkcx53uV0FbJiFq8m3Vuvll3R0t066rBrE8Rl90YSviB0om3PKOoXhV0g
         qp0LWwZu7DBy5zAkMtYitLc6XYWmFMEu5TyFiT2YEeiBkTWGom/2jY6CFHEHlm2FNkCC
         K7YFON1ePGfHaDmSe097As3/yxaSpnN6z9phe57sc/LfsEp2Mu8hhGyJW+/X46LM2kZu
         f2Cg==
X-Gm-Message-State: AOJu0Yz2x8McvexLCUgYg6taOamJ1X8ZSuSWNVmm0BptHak1Iw5+G7eP
	27kWaZoV8EaZ2rsIf17EnjWcnkduYVvfHYxr3bzh9sukPRC0Vs/jUlr9JX3NZSQ2EwmIQ40BYdY
	FVh19JfUctvMC2/dkRSnpeqgIzBfSYyRvYh9VINhvynzb+zVUjmCC55fwTiG63rubQnKjD4D2/k
	mUYRIGNUZbgN2F1N0raEJ7FG1a/xItiSAEwPuig+whowL3
X-Gm-Gg: ASbGncuHTjFQhWmCPaXwo/I2/6N94Ql76CrxhFRXGNSZDVy+mzqZfrgkkHIDyj9JVMn
	9VSB5iOthqPwwBNQNXHZc1dlQttvZxhJjBnkd5Z5KPlHx5OuM3WZhROkSwJJrwDDe0gzrNYgLen
	iMgzdYb7XpyQgH/HG9V8cebnWJvA6SvbPfeuUyCznVTYo7kkMtVhypQPdPRx71IKBmJDHTAB4TH
	Ofo9Y4+X4dPisexHQTY3ewA6OkkN0aKBH/D6FZ+cWiNDgEIPX9F5+AeFr9xf9rag8gmHq8XEQ0m
	KQoxarohLaX29D39y3gIDtjRKTknSjKlzivMDZLR1Xs0XhKtNRfdRRfqvtML5odT/jQij8+TR3o
	K
X-Received: by 2002:a05:6000:188c:b0:38f:3224:65ff with SMTP id ffacd0b85a97d-390ec7c6a8emr13964827f8f.5.1741103335480;
        Tue, 04 Mar 2025 07:48:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpnVEdNPdrzCOWtxMEX5R8OAMo0fpxMs1MbCedgfb3wOXycePEGo2BYRlgc01bVfM8qeQFCg==
X-Received: by 2002:a05:6000:188c:b0:38f:3224:65ff with SMTP id ffacd0b85a97d-390ec7c6a8emr13964780f8f.5.1741103334841;
        Tue, 04 Mar 2025 07:48:54 -0800 (PST)
Received: from localhost (p200300cbc73610009e302a8acd3d419c.dip0.t-ipconnect.de. [2003:cb:c736:1000:9e30:2a8a:cd3d:419c])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390e47a66adsm17850100f8f.25.2025.03.04.07.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 07:48:54 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Tong Tiangen <tongtiangen@huawei.com>
Subject: [PATCH -next v1 3/3] kernel/events/uprobes: uprobe_write_opcode() rewrite
Date: Tue,  4 Mar 2025 16:48:46 +0100
Message-ID: <20250304154846.1937958-4-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304154846.1937958-1-david@redhat.com>
References: <20250304154846.1937958-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uprobe_write_opcode() does some pretty low-level things that really, it
shouldn't be doing: for example, manually breaking COW by allocating
anonymous folios and replacing mapped pages.

Further, it does seem to do some shaky things: for example, writing to
possible COW-shared anonymous pages or zapping anonymous pages that might
be pinned. We're also not taking care of uffd, uffd-wp, softdirty ...
although rather corner cases here. Let's just get it right like ordinary
ptrace writes would.

Let's rewrite the code, leaving COW-breaking to core-MM, triggered by
FOLL_FORCE|FOLL_WRITE (note that the code was already using FOLL_FORCE).

We'll use GUP to lookup/faultin the page and break COW if required. Then,
we'll walk the page tables using a folio_walk to perform our page
modification atomically by temporarily unmap the PTE + flushing the TLB.

Likely, we could avoid the temporary unmap in case we can just
atomically write the instruction, but that will be a separate project.

Unfortunately, we still have to implement the zapping logic manually,
because we only want to zap in specific circumstances (e.g., page
content identical).

Note that we can now handle large folios (compound pages) and the shared
zeropage just fine, so drop these checks.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 kernel/events/uprobes.c | 316 ++++++++++++++++++++--------------------
 1 file changed, 160 insertions(+), 156 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 0276defd6fbfa..4e39280f8f424 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -29,6 +29,7 @@
 #include <linux/workqueue.h>
 #include <linux/srcu.h>
 #include <linux/oom.h>          /* check_stable_address_space */
+#include <linux/pagewalk.h>
 
 #include <linux/uprobes.h>
 
@@ -151,91 +152,6 @@ static loff_t vaddr_to_offset(struct vm_area_struct *vma, unsigned long vaddr)
 	return ((loff_t)vma->vm_pgoff << PAGE_SHIFT) + (vaddr - vma->vm_start);
 }
 
-/**
- * __replace_page - replace page in vma by new page.
- * based on replace_page in mm/ksm.c
- *
- * @vma:      vma that holds the pte pointing to page
- * @addr:     address the old @page is mapped at
- * @old_page: the page we are replacing by new_page
- * @new_page: the modified page we replace page by
- *
- * If @new_page is NULL, only unmap @old_page.
- *
- * Returns 0 on success, negative error code otherwise.
- */
-static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
-				struct page *old_page, struct page *new_page)
-{
-	struct folio *old_folio = page_folio(old_page);
-	struct folio *new_folio;
-	struct mm_struct *mm = vma->vm_mm;
-	DEFINE_FOLIO_VMA_WALK(pvmw, old_folio, vma, addr, 0);
-	int err;
-	struct mmu_notifier_range range;
-	pte_t pte;
-
-	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, addr,
-				addr + PAGE_SIZE);
-
-	if (new_page) {
-		new_folio = page_folio(new_page);
-		err = mem_cgroup_charge(new_folio, vma->vm_mm, GFP_KERNEL);
-		if (err)
-			return err;
-	}
-
-	/* For folio_free_swap() below */
-	folio_lock(old_folio);
-
-	mmu_notifier_invalidate_range_start(&range);
-	err = -EAGAIN;
-	if (!page_vma_mapped_walk(&pvmw))
-		goto unlock;
-	VM_BUG_ON_PAGE(addr != pvmw.address, old_page);
-	pte = ptep_get(pvmw.pte);
-
-	/*
-	 * Handle PFN swap PTES, such as device-exclusive ones, that actually
-	 * map pages: simply trigger GUP again to fix it up.
-	 */
-	if (unlikely(!pte_present(pte))) {
-		page_vma_mapped_walk_done(&pvmw);
-		goto unlock;
-	}
-
-	if (new_page) {
-		folio_get(new_folio);
-		folio_add_new_anon_rmap(new_folio, vma, addr, RMAP_EXCLUSIVE);
-		folio_add_lru_vma(new_folio, vma);
-	} else
-		/* no new page, just dec_mm_counter for old_page */
-		dec_mm_counter(mm, MM_ANONPAGES);
-
-	if (!folio_test_anon(old_folio)) {
-		dec_mm_counter(mm, mm_counter_file(old_folio));
-		inc_mm_counter(mm, MM_ANONPAGES);
-	}
-
-	flush_cache_page(vma, addr, pte_pfn(pte));
-	ptep_clear_flush(vma, addr, pvmw.pte);
-	if (new_page)
-		set_pte_at(mm, addr, pvmw.pte,
-			   mk_pte(new_page, vma->vm_page_prot));
-
-	folio_remove_rmap_pte(old_folio, old_page, vma);
-	if (!folio_mapped(old_folio))
-		folio_free_swap(old_folio);
-	page_vma_mapped_walk_done(&pvmw);
-	folio_put(old_folio);
-
-	err = 0;
- unlock:
-	mmu_notifier_invalidate_range_end(&range);
-	folio_unlock(old_folio);
-	return err;
-}
-
 /**
  * is_swbp_insn - check if instruction is breakpoint instruction.
  * @insn: instruction to be checked.
@@ -463,6 +379,105 @@ static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
 	return ret;
 }
 
+static bool orig_page_is_identical(struct vm_area_struct *vma,
+		unsigned long vaddr, struct page *page, bool *pmd_mappable)
+{
+	const pgoff_t index = vaddr_to_offset(vma, vaddr) >> PAGE_SHIFT;
+	struct page *orig_page = find_get_page(vma->vm_file->f_inode->i_mapping,
+					       index);
+	struct folio *orig_folio;
+	bool identical;
+
+	if (!orig_page)
+		return false;
+	orig_folio = page_folio(orig_page);
+
+	*pmd_mappable = folio_test_pmd_mappable(orig_folio);
+	identical = folio_test_uptodate(orig_folio) &&
+		    pages_identical(page, orig_page);
+	folio_put(orig_folio);
+	return identical;
+}
+
+static int __uprobe_write_opcode(struct vm_area_struct *vma,
+		struct folio_walk *fw, struct folio *folio,
+		unsigned long opcode_vaddr, uprobe_opcode_t opcode)
+{
+	const unsigned long vaddr = opcode_vaddr & PAGE_MASK;
+	const bool is_register = !!is_swbp_insn(&opcode);
+	bool pmd_mappable;
+
+	/* We're done if we don't find an anonymous folio when unregistering. */
+	if (!folio_test_anon(folio))
+		return is_register ? -EFAULT : 0;
+
+	/* For now, we'll only handle PTE-mapped folios. */
+	if (fw->level != FW_LEVEL_PTE)
+		return -EFAULT;
+
+	/*
+	 * See can_follow_write_pte(): we'd actually prefer a writable PTE here,
+	 * but the VMA might not be writable.
+	 */
+	if (!pte_write(fw->pte)) {
+		if (!PageAnonExclusive(fw->page))
+			return -EFAULT;
+		if (unlikely(userfaultfd_pte_wp(vma, fw->pte)))
+			return -EFAULT;
+		/* SOFTDIRTY is handled via pte_mkdirty() below. */
+	}
+
+	/*
+	 * We'll temporarily unmap the page and flush the TLB, such that we can
+	 * modify the page atomically.
+	 */
+	flush_cache_page(vma, vaddr, pte_pfn(fw->pte));
+	fw->pte = ptep_clear_flush(vma, vaddr, fw->ptep);
+
+	/* Verify that the page content is still as expected. */
+	if (verify_opcode(fw->page, opcode_vaddr, &opcode) <= 0) {
+		set_pte_at(vma->vm_mm, vaddr, fw->ptep, fw->pte);
+		return -EAGAIN;
+	}
+	copy_to_page(fw->page, opcode_vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
+
+	/*
+	 * When unregistering, we may only zap a PTE if uffd is disabled and
+	 * there are no unexpected folio references ...
+	 */
+	if (is_register || userfaultfd_missing(vma) ||
+	    (folio_ref_count(folio) != folio_mapcount(folio) +
+	     folio_test_swapcache(folio) * folio_nr_pages(folio)))
+		goto remap;
+
+	/*
+	 * ... and the mapped page is identical to the original page that
+	 * would get faulted in on next access.
+	 */
+	if (!orig_page_is_identical(vma, vaddr, fw->page, &pmd_mappable))
+		goto remap;
+
+	dec_mm_counter(vma->vm_mm, MM_ANONPAGES);
+	folio_remove_rmap_pte(folio, fw->page, vma);
+	if (!folio_mapped(folio) && folio_test_swapcache(folio) &&
+	     folio_trylock(folio)) {
+		folio_free_swap(folio);
+		folio_unlock(folio);
+	}
+	folio_put(folio);
+
+	return pmd_mappable;
+remap:
+	/*
+	 * Make sure that our copy_to_page() changes become visible before the
+	 * set_pte_at() write.
+	 */
+	smp_wmb();
+	/* We modified the page. Make sure to mark the PTE dirty. */
+	set_pte_at(vma->vm_mm, vaddr, fw->ptep, pte_mkdirty(fw->pte));
+	return 0;
+}
+
 /*
  * NOTE:
  * Expect the breakpoint instruction to be the smallest size instruction for
@@ -475,116 +490,105 @@ static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
  * uprobe_write_opcode - write the opcode at a given virtual address.
  * @auprobe: arch specific probepoint information.
  * @vma: the probed virtual memory area.
- * @vaddr: the virtual address to store the opcode.
- * @opcode: opcode to be written at @vaddr.
+ * @opcode_vaddr: the virtual address to store the opcode.
+ * @opcode: opcode to be written at @opcode_vaddr.
  *
  * Called with mm->mmap_lock held for read or write.
  * Return 0 (success) or a negative errno.
  */
 int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
-		unsigned long vaddr, uprobe_opcode_t opcode)
+		const unsigned long opcode_vaddr, uprobe_opcode_t opcode)
 {
+	const unsigned long vaddr = opcode_vaddr & PAGE_MASK;
 	struct mm_struct *mm = vma->vm_mm;
 	struct uprobe *uprobe;
-	struct page *old_page, *new_page;
 	int ret, is_register, ref_ctr_updated = 0;
-	bool orig_page_huge = false;
 	unsigned int gup_flags = FOLL_FORCE;
+	struct mmu_notifier_range range;
+	struct folio_walk fw;
+	struct folio *folio;
+	struct page *page;
 
 	is_register = is_swbp_insn(&opcode);
 	uprobe = container_of(auprobe, struct uprobe, arch);
 
-retry:
+	if (WARN_ON_ONCE(!is_cow_mapping(vma->vm_flags)))
+		return -EINVAL;
+
+	/*
+	 * When registering, we have to break COW to get an exclusive anonymous
+	 * page that we can safely modify. Use FOLL_WRITE to trigger a write
+	 * fault if required. When unregistering, we might be lucky and the
+	 * anon page is already gone. So defer write faults until really
+	 * required. Use FOLL_SPLIT_PMD, because __uprobe_write_opcode()
+	 * cannot deal with PMDs yet.
+	 */
 	if (is_register)
-		gup_flags |= FOLL_SPLIT_PMD;
-	/* Read the page with vaddr into memory */
-	ret = get_user_pages_remote(mm, vaddr, 1, gup_flags, &old_page, NULL);
+		gup_flags |= FOLL_WRITE | FOLL_SPLIT_PMD;
+
+retry:
+	ret = get_user_pages_remote(mm, vaddr, 1, gup_flags, &page, NULL);
 	if (ret != 1)
-		return ret;
+		goto out;
 
-	ret = verify_opcode(old_page, vaddr, &opcode);
+	ret = verify_opcode(page, opcode_vaddr, &opcode);
+	put_page(page);
 	if (ret <= 0)
-		goto put_old;
-
-	if (is_zero_page(old_page)) {
-		ret = -EINVAL;
-		goto put_old;
-	}
-
-	if (WARN(!is_register && PageCompound(old_page),
-		 "uprobe unregister should never work on compound page\n")) {
-		ret = -EINVAL;
-		goto put_old;
-	}
+		goto out;
 
 	/* We are going to replace instruction, update ref_ctr. */
 	if (!ref_ctr_updated && uprobe->ref_ctr_offset) {
 		ret = update_ref_ctr(uprobe, mm, is_register ? 1 : -1);
 		if (ret)
-			goto put_old;
+			goto out;
 
 		ref_ctr_updated = 1;
 	}
 
-	ret = 0;
-	if (!is_register && !PageAnon(old_page))
-		goto put_old;
-
-	ret = anon_vma_prepare(vma);
-	if (ret)
-		goto put_old;
-
-	ret = -ENOMEM;
-	new_page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma, vaddr);
-	if (!new_page)
-		goto put_old;
-
-	__SetPageUptodate(new_page);
-	copy_highpage(new_page, old_page);
-	copy_to_page(new_page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
-
 	if (!is_register) {
-		struct page *orig_page;
-		pgoff_t index;
-
-		VM_BUG_ON_PAGE(!PageAnon(old_page), old_page);
-
-		index = vaddr_to_offset(vma, vaddr & PAGE_MASK) >> PAGE_SHIFT;
-		orig_page = find_get_page(vma->vm_file->f_inode->i_mapping,
-					  index);
-
-		if (orig_page) {
-			if (PageUptodate(orig_page) &&
-			    pages_identical(new_page, orig_page)) {
-				/* let go new_page */
-				put_page(new_page);
-				new_page = NULL;
-
-				if (PageCompound(orig_page))
-					orig_page_huge = true;
-			}
-			put_page(orig_page);
-		}
+		/*
+		 * In the common case, we'll be able to zap the page when
+		 * unregistering. So trigger MMU notifiers now, as we won't
+		 * be able to do it under PTL.
+		 */
+		mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm,
+					vaddr, vaddr + PAGE_SIZE);
+		mmu_notifier_invalidate_range_start(&range);
+	}
+
+	/* Walk the page tables again, to perform the actual update. */
+	folio = folio_walk_start(&fw, vma, vaddr, 0);
+	if (folio) {
+		ret = __uprobe_write_opcode(vma, &fw, folio, opcode_vaddr,
+					    opcode);
+		folio_walk_end(&fw, vma);
+	} else {
+		ret = -EAGAIN;
 	}
 
-	ret = __replace_page(vma, vaddr & PAGE_MASK, old_page, new_page);
-	if (new_page)
-		put_page(new_page);
-put_old:
-	put_page(old_page);
+	if (!is_register)
+		mmu_notifier_invalidate_range_end(&range);
 
-	if (unlikely(ret == -EAGAIN))
+	switch (ret) {
+	case -EFAULT:
+		gup_flags |= FOLL_WRITE | FOLL_SPLIT_PMD;
+		fallthrough;
+	case -EAGAIN:
 		goto retry;
+	default:
+		break;
+	}
 
+out:
 	/* Revert back reference counter if instruction update failed. */
-	if (ret && is_register && ref_ctr_updated)
+	if (ret < 0 && is_register && ref_ctr_updated)
 		update_ref_ctr(uprobe, mm, -1);
 
 	/* try collapse pmd for compound page */
-	if (!ret && orig_page_huge)
+	if (ret > 0)
 		collapse_pte_mapped_thp(mm, vaddr, false);
 
-	return ret;
+	return ret < 0 ? ret : 0;
 }
 
 /**
-- 
2.48.1


