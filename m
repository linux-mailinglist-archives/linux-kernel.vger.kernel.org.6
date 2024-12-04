Return-Path: <linux-kernel+bounces-431044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF1B9E3871
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18AA9163327
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116071B218A;
	Wed,  4 Dec 2024 11:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eoDw9nL4"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C101B3922
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 11:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733310618; cv=none; b=r6RuWN+6PJzMlCCvfsOqiTkroczsM0WCLNkr9mTf+xSA/oE2O/D81gwkF8bHKDLeZbkEZcakpW9NhTkY9rTebpDwQ0qoycx2GwjUcNQuKdKasu85Yw9bOY6Tp+F49WV7LiUY+Q2gidl18/4EHrMUUsKodHY+a8LKoRcgEe7rsxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733310618; c=relaxed/simple;
	bh=wu5+Xv+DfArThO4xQ8ioNVrSEjYsAQqgsRpFC1qpXgo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LTmT76PMi4OA+2mBQOWYziLzdxLrApDF5/dlQfVBiffzRWeDwn8x1x4idmRrzLdPm47WcVpjDIymU/0kLTp8dh5kTKA9Wc5Yx43nLNLf4n/uHWGl3JF98ty+rLrHwdCSpXKrsqY2A+RnbetCeOJ060BsTZ1lpz5p1BclSAIePM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eoDw9nL4; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-215c4000c20so16418845ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 03:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733310615; x=1733915415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8v/2J9FQpQc9WZCTNK+PDAJdMK8SXRfaFd/20oYgCX4=;
        b=eoDw9nL4KcRyxuBQZrZcZsKystds7Pm74QaMQUYpsCHvzyhOrFPYkAVzldYGd6ZaEB
         TOFNVeO2+1ADZbD/Heo84MYfuPybPs93IEw4EXm2g3oUw1FaTjMc+Gva+N6w1hpu2aeV
         FszSgfmTldJd400Vfh87gdA3QJkvHQ06UFsozVbYsKrSIlMMEDRKbAhkfbgXiNCTUMug
         3IOjBoLMtPv8FxWNA5WuhnzlqYzzqBU1hvnT2jdcyIkPJN6HbxWPUjHChV+fhYYhzhFG
         M430vel9lTzZiUNIDQhTPv3wpHxbs3DtbSBwNzOPj80Lv1BiCk7jhvdOZkbZUcCEbJD2
         HiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733310615; x=1733915415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8v/2J9FQpQc9WZCTNK+PDAJdMK8SXRfaFd/20oYgCX4=;
        b=boi7HFkT6yZdF1RECmKzVGnv+QLiUPFtJFRNZmVQAzvzup5BKDoOrbXHYxffAkhmgL
         7BRGTpyIYLy2dNDm/NrdxYwxpw18fxIs7EGSKcJhOTIGt8WPGYE4J+NttJp01VVjBoQv
         IhJr9+p9GAY+Hs8RcSHMkvw32LOLzs9b8JMnZdyd4ggrQabYZYLJ7ZsSULA+SeaBREyJ
         HFAQV/b3aLDXUgaSRb43HltlQvi9JPTk7fZxxNkbm7XKppYt15Oapohsrv7ln3krqtty
         VEgZ8OOwOjO3A83OOaOirbe6ta4ukw2YEXTNXMk9uyq8UYDapc2j4qnoTX+FaCf85v1W
         MWsA==
X-Forwarded-Encrypted: i=1; AJvYcCW5UWYDn/7cL3lfgwemL2iBOxRuSj50anEdXZaMcs+M6IoKPKD/auXzdJr/+Nbk6p2eJ6NXaSaKJhLxjgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGzbujpkZ+pnzHTLxL/DJmQ7ablm3UoO8WuZ6BFTfrtzrr/lKB
	IJDs086sjD8zyKt1tOxpmD/M+E5/lPCcZZFDjEdIdpRj2OlPHvUxDHc/XzVajPE=
X-Gm-Gg: ASbGncsMxkMnSglCvb9hUC/Lo0YjQmxkxQYkuyWkeSxeesQDeLYLPBujRy5nI0THpqS
	74t5BiPUGn46eAR0XHt5sg/ad2Iv2y+JiNAL+M5FWwNAFr9MVytj3NhoI+r6Kc502TFjcVCXK3N
	b+1aOrdQVZ6jbWQxyK5DEaoja0JG9H00iTdgT8lbUrc72rdT/V7kZhEenQ8NBwL+tbUl0iiaab0
	s3Q4i5kzKYSXkVy2yYULPg6yZViNOkPLzAXcQ2/k6LUcVj7AaISyNK/pRnepBd+EKy+JLoEEl97
	Cas5kpxfE2Rb8u0=
X-Google-Smtp-Source: AGHT+IH48Wa8LfWoa8qFH8RpsZrm4aa9MAs4O8ws8UrMK3r6was8ohTmagz60VzDfKmxNZy3Wldn3g==
X-Received: by 2002:a17:902:d2cc:b0:215:9ebc:f1ab with SMTP id d9443c01a7336-215bd2514d7mr81044525ad.35.1733310615221;
        Wed, 04 Dec 2024 03:10:15 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21527515731sm107447495ad.192.2024.12.04.03.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 03:10:14 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	peterx@redhat.com,
	akpm@linux-foundation.org
Cc: mgorman@suse.de,
	catalin.marinas@arm.com,
	will@kernel.org,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	x86@kernel.org,
	lorenzo.stoakes@oracle.com,
	zokeefe@google.com,
	rientjes@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 00/11] synchronously scan and reclaim empty user PTE pages
Date: Wed,  4 Dec 2024 19:09:40 +0800
Message-Id: <cover.1733305182.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v4:
 - update the process_addrs.rst in [PATCH v4 01/11]
   (suggested by Lorenzo Stoakes)
 - fix [PATCH v3 4/9] and move it after [PATCH v3 5/9]
   (pointed by David Hildenbrand)
 - change to use any_skipped instead of rechecking pte_none() to detect empty
   user PTE pages (suggested by David Hildenbrand)
 - rebase onto the next-20241203

Changes in v3:
 - recheck pmd state instead of pmd_same() in retract_page_tables()
   (suggested by Jann Horn)
 - recheck dst_pmd entry in move_pages_pte() (pointed by Jann Horn)
 - introduce new skip_none_ptes() (suggested by David Hildenbrand)
 - minor changes in [PATCH v2 5/7]
 - remove tlb_remove_table_sync_one() if CONFIG_PT_RECLAIM is enabled.
 - use put_page() instead of free_page_and_swap_cache() in
   __tlb_remove_table_one_rcu() (pointed by Jann Horn)
 - collect the Reviewed-bys and Acked-bys
 - rebase onto the next-20241112

Changes in v2:
 - fix [PATCH v1 1/7] (Jann Horn)
 - reset force_flush and force_break to false in [PATCH v1 2/7] (Jann Horn)
 - introduce zap_nonpresent_ptes() and do_zap_pte_range()
 - check pte_none() instead of can_reclaim_pt after the processing of PTEs
   (remove [PATCH v1 3/7] and [PATCH v1 4/7])
 - reorder patches
 - rebase onto the next-20241031

Changes in v1:
 - replace [RFC PATCH 1/7] with a separate serise (already merge into mm-unstable):
   https://lore.kernel.org/lkml/cover.1727332572.git.zhengqi.arch@bytedance.com/
   (suggested by David Hildenbrand)
 - squash [RFC PATCH 2/7] into [RFC PATCH 4/7]
   (suggested by David Hildenbrand)
 - change to scan and reclaim empty user PTE pages in zap_pte_range()
   (suggested by David Hildenbrand)
 - sent a separate RFC patch to track the tlb flushing issue, and remove
   that part form this series ([RFC PATCH 3/7] and [RFC PATCH 6/7]).
   link: https://lore.kernel.org/lkml/20240815120715.14516-1-zhengqi.arch@bytedance.com/
 - add [PATCH v1 1/7] into this series
 - drop RFC tag
 - rebase onto the next-20241011

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

So this series aims to synchronously free the empty PTE pages in
madvise(MADV_DONTNEED) case. We will detect and free empty PTE pages in
zap_pte_range(), and will add zap_details.reclaim_pt to exclude cases other than
madvise(MADV_DONTNEED).

In zap_pte_range(), mmu_gather is used to perform batch tlb flushing and page
freeing operations. Therefore, if we want to free the empty PTE page in this
path, the most natural way is to add it to mmu_gather as well. Now, if
CONFIG_MMU_GATHER_RCU_TABLE_FREE is selected, mmu_gather will free page table
pages by semi RCU:

 - batch table freeing: asynchronous free by RCU
 - single table freeing: IPI + synchronous free

But this is not enough to free the empty PTE page table pages in paths other
that munmap and exit_mmap path, because IPI cannot be synchronized with
rcu_read_lock() in pte_offset_map{_lock}(). So we should let single table also
be freed by RCU like batch table freeing.

As a first step, we supported this feature on x86_64 and selectd the newly
introduced CONFIG_ARCH_SUPPORTS_PT_RECLAIM.

For other cases such as madvise(MADV_FREE), consider scanning and freeing empty
PTE pages asynchronously in the future.

This series is based on next-20241112 (which contains the series [2]).

Note: issues related to TLB flushing are not new to this series and are tracked
      in the separate RFC patch [3]. And more context please refer to this
      thread [4].

Comments and suggestions are welcome!

Thanks,
Qi

[1]. https://lore.kernel.org/lkml/cover.1718267194.git.zhengqi.arch@bytedance.com/
[2]. https://lore.kernel.org/lkml/cover.1727332572.git.zhengqi.arch@bytedance.com/
[3]. https://lore.kernel.org/lkml/20240815120715.14516-1-zhengqi.arch@bytedance.com/
[4]. https://lore.kernel.org/lkml/6f38cb19-9847-4f70-bbe7-06881bb016be@bytedance.com/

Qi Zheng (11):
  mm: khugepaged: recheck pmd state in retract_page_tables()
  mm: userfaultfd: recheck dst_pmd entry in move_pages_pte()
  mm: introduce zap_nonpresent_ptes()
  mm: introduce do_zap_pte_range()
  mm: skip over all consecutive none ptes in do_zap_pte_range()
  mm: zap_install_uffd_wp_if_needed: return whether uffd-wp pte has been
    re-installed
  mm: do_zap_pte_range: return any_skipped information to the caller
  mm: make zap_pte_range() handle full within-PMD range
  mm: pgtable: reclaim empty PTE page in madvise(MADV_DONTNEED)
  x86: mm: free page table pages by RCU instead of semi RCU
  x86: select ARCH_SUPPORTS_PT_RECLAIM if X86_64

 Documentation/mm/process_addrs.rst |   4 +
 arch/x86/Kconfig                   |   1 +
 arch/x86/include/asm/tlb.h         |  20 +++
 arch/x86/kernel/paravirt.c         |   7 +
 arch/x86/mm/pgtable.c              |  10 +-
 include/linux/mm.h                 |   1 +
 include/linux/mm_inline.h          |  11 +-
 include/linux/mm_types.h           |   4 +-
 mm/Kconfig                         |  15 ++
 mm/Makefile                        |   1 +
 mm/internal.h                      |  19 +++
 mm/khugepaged.c                    |  45 +++--
 mm/madvise.c                       |   7 +-
 mm/memory.c                        | 253 ++++++++++++++++++-----------
 mm/mmu_gather.c                    |   9 +-
 mm/pt_reclaim.c                    |  71 ++++++++
 mm/userfaultfd.c                   |  51 ++++--
 17 files changed, 397 insertions(+), 132 deletions(-)
 create mode 100644 mm/pt_reclaim.c

-- 
2.20.1


