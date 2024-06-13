Return-Path: <linux-kernel+bounces-212846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E41906731
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC3B3B20F56
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D45142629;
	Thu, 13 Jun 2024 08:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DejETb7w"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423DB13D8B3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 08:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267954; cv=none; b=Eli5YrXH6HeN6RpN8HY7m168CVnoOSCsnbjB1hY7hLgs3N/+rfY0NerbW8RlHR84mHn7kKKB7ibZvOs2pzqCpNPUA92302VUWvpsr9a0TXpn5oPW9tc5pvrVLdu21j43jKAieAraPknoXC/kx/FOv8g7Xc756ZK/pzgAwuANp6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267954; c=relaxed/simple;
	bh=3FJyfFD0AXGWMPmGWbl3ftbLV5zzpcxB1j/qFhTKknk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NsMo5R+/dLoAxKrewCJtB+001HisxXCynDYuXkdT3zEOSsJpBrsr+vQ23nkts8nxXJj1aaqpy55A6ivr2PnTvE0RttkWCEHs14/VsoiyIkMdF/KkEFskc2mtvj8NCxg8ODJaI3Au8bodFuuO0B5VcuaS/y1Q8Lc66Pj7uH9WwcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DejETb7w; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-254976d3327so115983fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 01:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1718267951; x=1718872751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hl67iH9COLf0aTY3D3whefyOfZy3UdpQMLr6lWpcnhw=;
        b=DejETb7wW2s0VjILwfQ0Aaum6RhX0ndMx1xPhaD79F0z0NyoG68NMohbb6b6BHJ9Bn
         Ym5dOnTq4szHmJFW2MZYHLJLR6rOUZ9ahVvwdWM8Z88kcvppUmk6zAK3OjbefQTvRF5O
         GflQ1g/vlPiRjTq5CHbGRGmd1GKxJGt+2lZIrNpz/MgqcVXZEW1AI3CTNup1PGysLKAg
         PQ0S04LZpxPoKwDsYy8rDdzITI9iJvtj7tExYqNw0OrD2WHnSHSjrclK3H5V5W5CC6MY
         sCwLyDdwQF9+tZL/XyrTIoIhkyT8dOtIsiNsvpwX/0w/e0g6hZUS5ZlK3f6aHEnfEe5R
         I7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718267951; x=1718872751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hl67iH9COLf0aTY3D3whefyOfZy3UdpQMLr6lWpcnhw=;
        b=SE1OU5ZO6/LWcWsdewqNx+nlBzdaiRcytay1FTPiEhyQ5pNzc4mbZgwwfW1geOv0kb
         IH0jDob7BRSRdN/3k/x0kox4hXPYPGgsW+nS7qFBaogvzl4sS7e9oHSKAj1TJVSpxbqC
         EuKdYbZ0G+JMvUBtKG4p2g3T45JE2YpDXkeQsmGngFCpTE6gI3Mp0Agz81KypBaWO8VN
         v+9KWVxslMxg77ZKrDo88cqibpebVZfrubicQcFC8wE94lAeeP8X7PVhk9LF1gnFRLVd
         0qV4H6yiMO2AxCn8+r/hjfocBUxofp7DgNUVcWe3F5Zslss3Z3UUZTGvpLBtQVkNABsW
         mqBA==
X-Forwarded-Encrypted: i=1; AJvYcCV56hKZPT/VoG01wyS1tSfsIDjB26ALo9ZA+FUfYUdW0SoPj652alCCtenWzKXVEhId6r7zoNgcjGtuynnqezrrYEC2YeuuvSo/SfWU
X-Gm-Message-State: AOJu0Ywptpr8oRMJH82yBxed9l0aIasqRd1fcLm5IMPAlie0q4PmxO6x
	GSqDH0UMnpqbEKT3z2Yaq8lDUSBnq+Y+qrQ7GsKClET5HKKJne9Kii4iQV+hGdo=
X-Google-Smtp-Source: AGHT+IF7Kk6RafpOf7Fw87qNvhDWnPOEWoveQm/d41GJcDFjhjd9dL6LGBHufxqdLTEi0UPK89Lnzg==
X-Received: by 2002:a05:6871:5cf:b0:254:c111:12b9 with SMTP id 586e51a60fabf-25514bb928bmr4625947fac.2.1718267950856;
        Thu, 13 Jun 2024 01:39:10 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb980bdsm820856b3a.211.2024.06.13.01.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 01:39:10 -0700 (PDT)
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
Subject: [RFC PATCH 0/3] asynchronously scan and free empty user PTE pages
Date: Thu, 13 Jun 2024 16:38:07 +0800
Message-Id: <cover.1718267194.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This series aims to asynchronously scan and free empty user PTE pages.

1. Background
=============

We often find huge user PTE memory usage on our servers, such as the following:

        VIRT:  55t
        RES:   590g
        VmPTE: 110g
        
The root cause is that these processes use some high-performance mmeory
allocators (such as jemalloc, tcmalloc, etc). These memory allocators use
madvise(MADV_DONTNEED or MADV_FREE) to release physical memory, but neither
MADV_DONTNEED nor MADV_FREE will release page table memory, which may cause
huge page table memory usage.

This issue has been discussed on LSFMM 2022 (led by David Hildenbrand):

        topic link: https://lore.kernel.org/linux-mm/7b908208-02f8-6fde-4dfc-13d5e00310a6@redhat.com/
        youtube link: https://www.youtube.com/watch?v=naO_BRhcU68
        
In the past, I have tried to introduce refcount for PTE pages to solve this
problem, but these methods [1][2][3] introduced too much complexity.

[1]. https://lore.kernel.org/lkml/20211110105428.32458-1-zhengqi.arch@bytedance.com/
[2]. https://lore.kernel.org/lkml/20220429133552.33768-1-zhengqi.arch@bytedance.com/
[3]. https://lore.kernel.org/lkml/20220825101037.96517-1-zhengqi.arch@bytedance.com/

2. Infrastructure
=================

Later, in order to freeing retracted page table, Hugh Dickins added a lot of
PTE-related infrastructure[4][5][6]:

    - allow pte_offset_map_lock() etc to fail
    - make PTE pages can be removed without mmap or rmap locks
      (see collapse_pte_mapped_thp() and retract_page_tables())
    - make PTE pages can be freed by RCU (via pte_free_defer())
    - etc
    
These are all beneficial to freeing empty PTE pages.

[4]. https://lore.kernel.org/all/a4963be9-7aa6-350-66d0-2ba843e1af44@google.com/
[5]. https://lore.kernel.org/all/c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com/
[6]. https://lore.kernel.org/all/7cd843a9-aa80-14f-5eb2-33427363c20@google.com/

3. Implementation
=================

For empty user PTE pages, we don't actually need to free it immediately, nor do
we need to free all of it.

Therefore, in this patchset, we register a task_work for the user tasks to
asyncronously scan and free empty PTE pages when they return to user space.
(The scanning time interval and address space size can be adjusted.)

When scanning, we can filter out some unsuitable vmas:

    - VM_HUGETLB vma
    - VM_UFFD_WP vma
    - etc
    
And for some PTE pages that spans multiple vmas, we can also skip.

For locking:

    - use the mmap read lock to traverse the vma tree and pgtable
    - use pmd lock for clearing pmd entry
    - use pte lock for checking empty PTE page, and release it after clearing
      pmd entry, then we can capture the changed pmd in pte_offset_map_lock()
      etc after holding this pte lock. Thanks to this, we don't need to hold the
      rmap-related locks.
    - users of pte_offset_map_lock() etc all expect the PTE page to be stable by
      using rcu lock, so use pte_free_defer() to free PTE pages.
      
For the path that will also free PTE pages in THP, we need to recheck whether the
content of pmd entry is valid after holding pmd lock or pte lock.

4. TODO
=======

Some applications may be concerned about the overhead of scanning and rebuilding
page tables, so the following features are considered for implementation in the
future:

    - add per-process switch (via prctl)
    - add a madvise option (like THP)
    - add MM_PGTABLE_SCAN_DELAY/MM_PGTABLE_SCAN_SIZE control (via procfs file)
    
Perhaps we can add the refcount to PTE pages in the future as well, which would
help improve the scanning speed.

This series is based on next-20240612.

Comments and suggestions are welcome!

Thanks,
Qi

Qi Zheng (3):
  mm: pgtable: move pte_free_defer() out of CONFIG_TRANSPARENT_HUGEPAGE
  mm: pgtable: make pte_offset_map_nolock() return pmdval
  mm: free empty user PTE pages

 Documentation/mm/split_page_table_lock.rst |   3 +-
 arch/arm/mm/fault-armv.c                   |   2 +-
 arch/powerpc/mm/pgtable-frag.c             |   2 -
 arch/powerpc/mm/pgtable.c                  |   2 +-
 arch/s390/mm/pgalloc.c                     |   2 -
 arch/sparc/mm/init_64.c                    |   2 +-
 include/linux/mm.h                         |   4 +-
 include/linux/mm_types.h                   |   4 +
 include/linux/pgtable.h                    |  14 ++
 include/linux/sched.h                      |   1 +
 kernel/sched/core.c                        |   1 +
 kernel/sched/fair.c                        |   2 +
 mm/Makefile                                |   2 +-
 mm/filemap.c                               |   2 +-
 mm/freept.c                                | 180 +++++++++++++++++++++
 mm/khugepaged.c                            |  20 ++-
 mm/memory.c                                |   4 +-
 mm/mremap.c                                |   2 +-
 mm/page_vma_mapped.c                       |   2 +-
 mm/pgtable-generic.c                       |  23 +--
 mm/userfaultfd.c                           |   4 +-
 mm/vmscan.c                                |   2 +-
 22 files changed, 249 insertions(+), 31 deletions(-)
 create mode 100644 mm/freept.c

-- 
2.20.1


