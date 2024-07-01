Return-Path: <linux-kernel+bounces-235850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E0791DA6E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E3C71F20CDB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07208839F7;
	Mon,  1 Jul 2024 08:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hkBBwwz2"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27877BAF7
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823688; cv=none; b=RdSBIhW/M8KHUkVwbFusGol2hwcU9K/KlAmPyj4/1cqZigTs8IqMgh5QndcJAapP07/GKJ/4oW6KmxU4qdn7n4pvDySRVWWVEyOewV+dvhKlQNX/tRP2SIymz/eZGjP2R8f0gXWZ4tRm7mA1kFspJHLdw4MHdK+XjjqQ7jAH5M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823688; c=relaxed/simple;
	bh=5r7BEWHQoxnzwmMWT+5heREZabm5MZa+ke0mnFVRo1s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KPivcfQ2I2i9p3qUr4cO04jBTn42fEhIRRdZnVUivtKxmcrRJCF4mY1wgyYGnq6D7aBXc+q+YBNPg2ukMErrPG3NBjv6+vkvWLuwQhS+1M1+Ww/vQmA+P5/u4u3apSEySrsnh+chu47TzVcKSWyHxkmAMuqZXhr0FjdYqp7jsvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hkBBwwz2; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-25cd2b51fd3so351776fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 01:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1719823684; x=1720428484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=frs6IF5FChuIQRpreMojgjHMqoHuIWxIzozpQca1jl0=;
        b=hkBBwwz2ml42SeAFZiVjILy49TOKHg7YRHK69DOBARAgMxHWZYAz2Oon07HB2wn3X8
         fMvEBOo/ibiWaJB7JyV/Dw3XlYpgAzw9t/bBZZU68AKNZTMvr119u/x9Bo8swVl4ZDXo
         ysQVRrBCjkkqJFltgya06zvdp6RAzx6dC49Y5QSq2Lj+MASc1yTDoCINMsZm1GlMg68y
         G0lniQHFhfdQ1THHy33FPuYd9lYNL9b/2lNexFEZ7fmT4ynqoIT/eAnk/1k9uU2y3gUm
         1vBAdrDxAqDfELDwgjnvidezVso5QvJG+4ABCnNQwtD/VB0GbbfbwAiTKjUTLKJ4m+wg
         duAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719823684; x=1720428484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=frs6IF5FChuIQRpreMojgjHMqoHuIWxIzozpQca1jl0=;
        b=ebLTz1BJ131De0ZqPXmzIwkVTXcPOuNPrlewH4eVzWXiXTe48/Z8WHS38W8apBHm7Q
         nPfwU7IUImp6axwxKHJczUw/oV1yW+u2v+Xx4L41tTU/skmgjLl6hMlU674kduDMX7/i
         iXUzDR8Fwy33GpvmrFYRKmZq3cmZJJTjSkqtQrc3rqsGoCtYyWjt1zy8FkimwTaX1NqF
         qt0FuvmZlxeg7VFJtLm6sH85thggvvLi2xMcNWRSvAGvf3QiWn5ej67BopK2/4MVMKjS
         s6VYGuc/gU9Fn6/+GKegwCH5VnthrwM7g8YzrCjonDrvElhwP99tqSkowv5kkCNorRzE
         pEcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtYVgD2lTN1gyN9eZcHudwYlGr/ofjWO+WglYPPRuME0e91uv1I2aQoR/M+WkX3grilYe71ivoP+eMPDBvGLlwkZKVvQE/enha7pgJ
X-Gm-Message-State: AOJu0YyGGZhvF6iFv6EalOny2QobC4CJyV1C3fl/yae3M0EaWB3vGVCc
	OjGWZU1wF1A1Hg/KDC+qCUtSwbIylR7vDMxfbJ9Okp7PNcu1P8T9GZvnGLkqGrRoDJEpR5ywGcz
	w
X-Google-Smtp-Source: AGHT+IHPVphQRqIO40k0Pi9VpvmEFlcKrx/R+Gbj7SwPvGaCvS/jhgIObiJQSsnIzBruRPyGmuX4Rw==
X-Received: by 2002:a05:6871:7806:b0:254:ecbd:1815 with SMTP id 586e51a60fabf-25db3709c91mr5160698fac.5.1719823684561;
        Mon, 01 Jul 2024 01:48:04 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804a7e7e0sm5932374b3a.204.2024.07.01.01.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 01:48:04 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	hughd@google.com,
	willy@infradead.org,
	mgorman@suse.de,
	muchun.song@linux.dev,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [RFC PATCH 0/7] synchronously scan and reclaim empty user PTE pages
Date: Mon,  1 Jul 2024 16:46:41 +0800
Message-Id: <cover.1719570849.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

This series is based on next-20240627.

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
 arch/x86/include/asm/tlb.h                 |  23 ++++
 arch/x86/kernel/paravirt.c                 |   7 ++
 arch/x86/mm/pgtable.c                      |  15 ++-
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
 mm/khugepaged.c                            |  24 +++-
 mm/memory.c                                |  21 ++--
 mm/migrate_device.c                        |   2 +-
 mm/mmu_gather.c                            |   2 +-
 mm/mprotect.c                              |   8 +-
 mm/mremap.c                                |   4 +-
 mm/page_vma_mapped.c                       |   2 +-
 mm/pgtable-generic.c                       |  21 ++--
 mm/pt_reclaim.c                            | 131 +++++++++++++++++++++
 mm/userfaultfd.c                           |  10 +-
 mm/vmscan.c                                |   2 +-
 29 files changed, 307 insertions(+), 51 deletions(-)
 create mode 100644 mm/pt_reclaim.c

-- 
2.20.1


