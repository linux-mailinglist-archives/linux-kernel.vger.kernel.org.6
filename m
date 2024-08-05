Return-Path: <linux-kernel+bounces-274681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26115947B69
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1992282266
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3742915B0E0;
	Mon,  5 Aug 2024 12:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cnyoP/Q+"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6E515AAC2
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 12:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722862549; cv=none; b=pzSbDdTttSNIpQMY+/6kxQYrUc9yzZ9tZtSUNBuMWLE7N+IQRN3bJigVJ/0gTTXsxJLpB2fFRe48liJy36Fr9egb3v7zqzlwdScVZk4k6h7iEuJtzZI+UYX3mNMhuJkCIiNWzSRB61YcE+uXUUpuYlprmIbLXJXyw6KyABl6VIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722862549; c=relaxed/simple;
	bh=6Zqj7FHvoCYJ36fPaO4LFXt10w3cG6QNhV6kOmF2Gz4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oSlu5qYvbGSjYgM3Q67BtoCwEJTDDnXyF5uraA2qwTShb2VrJ0cKsqxZ04GV1EuomzB31vaOKzOt1Q8ClZmojND//+kPv6tYzT++7pJmiLWGM3MDGoNeed5D5XYccd8V/ceK74vEjT3242w7TgAGzWAvNPt0fxP8E2/RyMO7dJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cnyoP/Q+; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70d2879bfb0so1012799b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 05:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722862545; x=1723467345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rNkm4ST7Yt4VxJPQvAz9DzGdsgOTeHEJXPtn+b8/ANA=;
        b=cnyoP/Q+mQmrchqv7g76B3gv8jgq7SkGVSxi3slMjtzpkF5IfDuPSDAcY0+n0zvePA
         U1jMWZAgW93n+QTTJU3TCGExSbM76a7RG9/YhtQxqWOyc1mlmfXMItOg9bFEZ8T7IkFw
         acXHwPzA12izIg7lCArVJ1okoRL4GNARKw5gaZNSHnj30ffgXUOl9uypP+vsj4q2MGu6
         Byxj/J6pwoD0DKxI7fg94zlYClPpm0a4O1O6CG5CiA0DlVQYsDIU6gk3OiWMzuec815w
         /j8L11L7E9f4k1+08+0gTH86BHVPStlBmFk1Pbz5EQRvR6Jgp0S2FPOlM03GZxdl2nXM
         LC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722862545; x=1723467345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rNkm4ST7Yt4VxJPQvAz9DzGdsgOTeHEJXPtn+b8/ANA=;
        b=VyB1GEg3Q30Uwb6DyiJL45+QfF+P/iq0guMCdgiZCEasfmBNog+mgeNQ+6XG410qSm
         TQxTSG6P8Eve9QNF74CRS5Lf9iot6hB8LLPMbHdF++JIUMLgMUX/+TCL4WEE7lPOrt/N
         TQweyNivcj2+BcMcyNQAekZpwF4dTpjRUaAvwjEhU9t9pF1yHtim/vp2or05OM4l9AWp
         Vo32rPshf4/gVoOV6L6r131KYbNY7DG+X49LB66oaH7URkWnJttBZqKqfsc3JD7tNIcL
         87Tf3rtnqHXnkFXGaozO6Yc7jKFhpJn1RyjzhvgfhoIfXcwjFu0l8Iz3QG+W6gFMacey
         Rh4A==
X-Forwarded-Encrypted: i=1; AJvYcCXEapd+c+xMZdite9OJuwMZSlH6KhNx/QXRDeK5bWc45f7pGb9UWHVbJYTPqqh84XqOPg1B6Cug0MVkIvSsma8csxm1M3pICjAkkjoH
X-Gm-Message-State: AOJu0YwaFgvpbg/kGHa05jUJrKMpjEKCVAJSlYFc0FD3wJsnUx9j1CLE
	yCRWyD3WuNbYZ7LuMyYbklGh9Zq6Ge3h6ZEfgDBNgPm18HFwwO7l8DGJsqpAaLc=
X-Google-Smtp-Source: AGHT+IH2+cbukx919Zfls8aFSY9/6eYjbs2ZERJUgHdRr2WnO7PGfws9eZKAHop8OvEf8AdWlM9bnQ==
X-Received: by 2002:a05:6a21:999e:b0:1c2:88eb:1d33 with SMTP id adf61e73a8af0-1c6996288d0mr10091043637.6.1722862545346;
        Mon, 05 Aug 2024 05:55:45 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ecfaf1asm5503030b3a.142.2024.08.05.05.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 05:55:44 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	hughd@google.com,
	willy@infradead.org,
	mgorman@suse.de,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	zokeefe@google.com,
	rientjes@google.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [RFC PATCH v2 0/7] synchronously scan and reclaim empty user PTE pages
Date: Mon,  5 Aug 2024 20:55:04 +0800
Message-Id: <cover.1722861064.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in RFC v2:
 - fix compilation errors in [RFC PATCH 5/7] and [RFC PATCH 7/7] reproted by
   kernel test robot
 - use pte_offset_map_nolock() + pmd_same() instead of check_pmd_still_valid()
   in retract_page_tables() (in [RFC PATCH 4/7])
 - rebase onto the next-20240805

Hi all,

Previously, we tried to use a completely asynchronous method to reclaim empty
user PTE pages [1]. After discussing with David Hildenbrand, we decided to
implement synchronous reclaimation in the case of madvise(MADV_DONTNEED) as the
first step.

So this series aims to synchronously scan and reclaim empty user PTE pages in
zap_page_range_single() (madvise(MADV_DONTNEED) etc will invoke this). In
zap_page_range_single(), mmu_gather is used to perform batch tlb flushing and
page freeing operations. Therefore, if we want to free the empty PTE page in
this path, the most natural way is to add it to mmu_gather as well. There are
two problems that need to be solved here:

1. Now, if CONFIG_MMU_GATHER_RCU_TABLE_FREE is selected, mmu_gather will free
   page table pages by semi RCU:

   - batch table freeing: asynchronous free by RCU
   - single table freeing: IPI + synchronous free

   But this is not enough to free the empty PTE page table pages in paths other
   that munmap and exit_mmap path, because IPI cannot be synchronized with
   rcu_read_lock() in pte_offset_map{_lock}(). So we should let single table
   also be freed by RCU like batch table freeing.

2. When we use mmu_gather to batch flush tlb and free PTE pages, the TLB is not
   flushed before pmd lock is unlocked. This may result in the following two
   situations:

   1) Userland can trigger page fault and fill a huge page, which will cause
      the existence of small size TLB and huge TLB for the same address.

   2) Userland can also trigger page fault and fill a PTE page, which will
      cause the existence of two small size TLBs, but the PTE page they map
      are different.

   For case 1), according to Intel's TLB Application note (317080), some CPUs of
   x86 do not allow it:

   ```
   If software modifies the paging structures so that the page size used for a
   4-KByte range of linear addresses changes, the TLBs may subsequently contain
   both ordinary and large-page translations for the address range.12 A reference
   to a linear address in the address range may use either translation. Which of
   the two translations is used may vary from one execution to another and the
   choice may be implementation-specific.

   Software wishing to prevent this uncertainty should not write to a paging-
   structure entry in a way that would change, for any linear address, both the
   page size and either the page frame or attributes. It can instead use the
   following algorithm: first mark the relevant paging-structure entry (e.g.,
   PDE) not present; then invalidate any translations for the affected linear
   addresses (see Section 5.2); and then modify the relevant paging-structure
   entry to mark it present and establish translation(s) for the new page size.
   ```

   We can also learn more information from the comments above pmdp_invalidate()
   in __split_huge_pmd_locked().

   For case 2), we can see from the comments above ptep_clear_flush() in
   wp_page_copy() that this situation is also not allowed. Even without
   this patch series, madvise(MADV_DONTNEED) can also cause this situation:

           CPU 0                         CPU 1

   madvise (MADV_DONTNEED)
   -->  clear pte entry
        pte_unmap_unlock
                                      touch and tlb miss
				      --> set pte entry 
        mmu_gather flush tlb

   But strangely, I didn't see any relevant fix code, maybe I missed something,
   or is this guaranteed by userland?

   Anyway, this series defines the following two functions to be implemented by
   the architecture. If the architecture does not allow the above two situations,
   then define these two functions to flush the tlb before set_pmd_at().

   - arch_flush_tlb_before_set_huge_page
   - arch_flush_tlb_before_set_pte_page

As a first step, we supported this feature on x86_64 and selectd the newly
introduced CONFIG_ARCH_SUPPORTS_PT_RECLAIM.

In order to reduce overhead, we only handle the cases with a high probability
of generating empty PTE pages, and other cases will be filtered out, such as:

 - hugetlb vma (unsuitable)
 - userfaultfd_wp vma (may reinstall the pte entry)
 - writable private file mapping case (COW-ed anon page is not zapped)
 - etc

For userfaultfd_wp and writable private file mapping cases (and MADV_FREE case,
of course), consider scanning and freeing empty PTE pages asynchronously in
the future.

This series is based on next-20240805.

Comments and suggestions are welcome!

Thanks,
Qi

[1]. https://lore.kernel.org/lkml/cover.1718267194.git.zhengqi.arch@bytedance.com/

Qi Zheng (7):
  mm: pgtable: make pte_offset_map_nolock() return pmdval
  mm: introduce CONFIG_PT_RECLAIM
  mm: pass address information to pmd_install()
  mm: pgtable: try to reclaim empty PTE pages in zap_page_range_single()
  x86: mm: free page table pages by RCU instead of semi RCU
  x86: mm: define arch_flush_tlb_before_set_huge_page
  x86: select ARCH_SUPPORTS_PT_RECLAIM if X86_64

 Documentation/mm/split_page_table_lock.rst |   3 +-
 arch/arm/mm/fault-armv.c                   |   2 +-
 arch/powerpc/mm/pgtable.c                  |   2 +-
 arch/x86/Kconfig                           |   1 +
 arch/x86/include/asm/pgtable.h             |   6 +
 arch/x86/include/asm/tlb.h                 |  19 +++
 arch/x86/kernel/paravirt.c                 |   7 ++
 arch/x86/mm/pgtable.c                      |  23 +++-
 include/linux/hugetlb.h                    |   2 +-
 include/linux/mm.h                         |  13 +-
 include/linux/pgtable.h                    |  14 +++
 mm/Kconfig                                 |  14 +++
 mm/Makefile                                |   1 +
 mm/debug_vm_pgtable.c                      |   2 +-
 mm/filemap.c                               |   4 +-
 mm/gup.c                                   |   2 +-
 mm/huge_memory.c                           |   3 +
 mm/internal.h                              |  17 ++-
 mm/khugepaged.c                            |  32 +++--
 mm/memory.c                                |  21 ++--
 mm/migrate_device.c                        |   2 +-
 mm/mmu_gather.c                            |   9 +-
 mm/mprotect.c                              |   8 +-
 mm/mremap.c                                |   4 +-
 mm/page_vma_mapped.c                       |   2 +-
 mm/pgtable-generic.c                       |  21 ++--
 mm/pt_reclaim.c                            | 131 +++++++++++++++++++++
 mm/userfaultfd.c                           |  10 +-
 mm/vmscan.c                                |   2 +-
 29 files changed, 321 insertions(+), 56 deletions(-)
 create mode 100644 mm/pt_reclaim.c

-- 
2.20.1


