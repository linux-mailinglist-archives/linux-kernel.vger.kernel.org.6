Return-Path: <linux-kernel+bounces-539150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBD8A4A191
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 835A23A7B4A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEDC275611;
	Fri, 28 Feb 2025 18:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JkvfnVU8"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918831F4C85
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767391; cv=none; b=Dp+4Rxt3x0WAT1yXbu6h/Xkwsrf33Hrc4VHLxXzxkKx2DXHJYiYIKlRwp/MvEIdhGMxGJ1bddrBiNs68uF7xLODvpGm/KHVGqLzHH0Ec+ASuHW5xIf1RswjAwctjqaewPaosIt5dvSUoGhisGynZ1fsGLIoLxi/d8m6o2Tf+SSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767391; c=relaxed/simple;
	bh=0hjkwZjOfvxqyDjE1nraNcnYwtkrcvuweYJHD4hYypA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pb/75Uezgsdye7wlvb3qr2YABaqzGiRjmAPjgnJnrrIKn7+HSCodezpckfQvh4NmYnXY0CimyjUlAVI5XnGHQ+P07nEvCqFlQwHz2dY/5LXsr/r66J1yx0wVak0NRjSlDhKMUqHAN5/ZqYvCyzbnfZFOzCt0IEciCJP/WlT2QZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JkvfnVU8; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fed20dd70cso426774a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740767389; x=1741372189; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qYw/4jzpPhrn2ghi3M0NL4BqtWBXDbsucrgLdEREcUk=;
        b=JkvfnVU8skCalS5fd2DWawgtTgmUJ7CIjTLnQe8iVB1u2RCwBPc59wA5srJ6gDD6U4
         bzRBQIi1xTM+CapW5L+3z+LsMAqCvrOtezta8mNVCoHbgxi/tV3ZGSoT0E9Hc1omlzaI
         AWk+WU/lBEnEN7bP9GpMySZaPn8x8jDQcHbXN+AGLxrYWLdNz8pWsy9wrUrh+tEUoQmw
         H+mlMc0bULmH/yLGBo9X2YuL2pNRux7/V6X3oyWDXKhfUqLH0h7VCIi6NBJfLxjm3O9T
         dE0NgZxiI6Yt1EYAYzlEgtfUxZqFjsfuYxHRGNiHbNkQTxoJr7zHH1sAOVKxRk7tTqdg
         UYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740767389; x=1741372189;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qYw/4jzpPhrn2ghi3M0NL4BqtWBXDbsucrgLdEREcUk=;
        b=g1dsucy1VTRuVqhvPZycP3ijzFPR9PAkt79+WGHFhexponxDq95pCzyxIWUqGjLIFR
         CYZk6Iikg1mmgsowhEln2P3c2ATfnlp4nBSRmQcvPcMH9axoLDVH9eja37mPYkHD9z0J
         X1Zc5D8gzfn/YLPyZCQE8IbWzFtfzYGg8LZgqepCnIM3H6RwDNasXKUZ2Ttz4ARwTszd
         /ujML92JqXnQFIet4KVkAwRCSpEeRj1Zavsem6N2vAORXWESvQ2dsmks8oTM4Kvvjv5Y
         yBz5hPv+K5wcLdIZKtsGGQNRfxCVtwtGIx2goGRftQ4Z3ZWebA7+ATRyfxS6UxYc4jOW
         W9+g==
X-Forwarded-Encrypted: i=1; AJvYcCV5Xagq/LzsqxTFmRRgUVZlzngiihKBwzF3dRhJ1JOj1oB/E73yO0KmzGqN9IjmaWUIsNzGeadED9/w4VY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHBy5IiQpfOh8TPrNYnxd2VGLuDEPqCHcetqPS3PDq56c4lp9i
	xCa+OxkIbaaWdhtzOHcJl1A2kFJi8pWKTgn1ZHkJSYBQ8w9rQkfF9//F0eRkETrcJqH+1Q==
X-Google-Smtp-Source: AGHT+IESZf099U8QrglpAAdw2N5nAQz5IJiwSKjoOaMnJZta22YCE6lq6SYy2PQ3La5jrNurn7grddFo
X-Received: from pjbsu16.prod.google.com ([2002:a17:90b:5350:b0:2fa:24c5:36e])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3ec4:b0:2ee:d96a:5816
 with SMTP id 98e67ed59e1d1-2febab5e105mr7663025a91.10.1740767388824; Fri, 28
 Feb 2025 10:29:48 -0800 (PST)
Date: Fri, 28 Feb 2025 18:29:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228182928.2645936-1-fvdl@google.com>
Subject: [PATCH v5 00/27] hugetlb/CMA improvements for large systems
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, ziy@nvidia.com, david@redhat.com, 
	Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"

v5:
* make SPARSEMEM_VMEMMAP_PREINIT an internal config option,
  and rename ARCH_WANT_SPARSE_VMEMMAP_PREINIT to
  ARCH_WANT_HUGETLB_VMEMMAP_PREINIT (suggested by
  Johannes Weiner <hannes@cmpxchg.org>)
* warning fixes to mm/cma.c (from Arnd Bergmann <arnd@arndb.de>)

v4:
* This series assumes that the following patch has been applied:
  https://lore.kernel.org/linux-mm/1f9f5fb4-27cd-4981-aa60-789a33376598@redhat.com/
* Drop memblock alloc loop patch that wasn't needed.
* Update documentation to reflect that hugepagesz and hugepages
  are now early parameters.
* Fix uninitialized var warning (from Dan Carpenter <dan.carpenter@linaro.org>)
* In the case of node fallback by memblock_alloc_try_nid_raw, make sure
  to get the actual NUMA node it was allocated from and put it on the
  list for that node, as this is what the pre-HVO code needs.
* Moved some empty static inline function decls to the right patch.
* Fix incorrect memory stats for hugetlb_cma= combined with hugepages=

v3:
* Fix SPDX comment include file format.
* Add new hugetlb_cma.* files to MAINTAINERS
* Document new ranges/ subdir in CMA debugfs.
* Fix powerpc compilation for config without HAVE_BOOTMEM_INFO_NODE
* Fix various other nits found by kernel test robot.
* Use a PFN value of -1 to indicate a non-mirrored mapping
  in sparse-vmemmap.c, not 0.
* Fix incorrect if() statement that got mangled in cma.c

v2:
* Add missing CMA debugfs code.
* Minor cleanups in hugetlb_cma changes.
* Move hugetlb_cma code to its own file to further clean
  things up.

On large systems, we observed some issues with hugetlb and CMA:

1) When specifying a large number of hugetlb boot pages (hugepages=
   on the commandline), the kernel may run out of memory before it
   even gets to HVO. For example, if you have a 3072G system, and
   want to use 3024 1G hugetlb pages for VMs, that should leave
   you plenty of space for the hypervisor, provided you have the
   hugetlb vmemmap optimization (HVO) enabled. However, since
   the vmemmap pages are always allocated first, and then later
   in boot freed, you will actually run yourself out of memory
   before you can do HVO. This means not getting all the hugetlb
   pages you want, and worse, failure to boot if there is an
   allocation failure in the system from which it can't recover.

2) There is a system setup where you might want to use hugetlb_cma
   with a large value (say, again, 3024 out of 3072G like above),
   and then lower that if system usage allows it, to make room
   for non-hugetlb processes. For this, a variation of the problem
   above applies: the kernel runs out of unmovable space to allocate
   from before you finish boot, since your CMA area takes up all
   the space.

3) CMA wants to use one big contiguous area for allocations. Which
   fails if you have the aforementioned 3T system with a gap in the
   middle of physical memory (like the < 40bits BIOS DMA area seen on
   some AMD systems). You then won't be able to set up a CMA area for
   one of the NUMA nodes, leading to loss of half of your hugetlb
   CMA area.

4) Under the scenario mentioned in 2), when trying to grow the
   number of hugetlb pages after dropping it for a while, new
   CMA allocations may fail occasionally. This is not unexpected,
   some transient references on pages may prevent cma_alloc
   from succeeding under memory pressure. However, the hugetlb
   code then falls back to a normal contiguous alloc, which may
   end up succeeding. This is not always desired behavior. If
   you have a large CMA area, then the kernel has a restricted
   amount of memory it can do unmovable allocations from (a well
   known issue). A normal contiguous alloc may eat further in to
   this space.


To resolve these issues, do the following:

* Add hooks to the section init code to do custom initialization
  of memmap pages. Hugetlb bootmem (memblock) allocated pages can
  then be pre-HVOed. This avoids allocating a large number of
  vmemmap pages early in boot, only to have them be freed again
  later, and also avoids running out of memory as described under 1).
  Using these hooks for hugetlb is optional. It requires moving
  hugetlb bootmem allocation to an earlier spot by the architecture.
  This has been enabled on x86.
* hugetlb_cma doesn't care about the CMA area it uses being one
  large contiguous range. Multiple smaller ranges are fine. The
  only requirements are that the areas should be on one NUMA node,
  and individual gigantic pages should be allocatable from them. So,
  implement multi-range support for CMA, avoiding issue 3).
* Introduce a hugetlb_cma_only option on the commandline. This only
  allows allocations from CMA for gigantic pages, if hugetlb_cma=
  is also specified.
* With hugetlb_cma_only active, it also makes sense to be able to
  pre-allocate gigantic hugetlb pages at boot time from the CMA
  area(s). Add a rudimentary early CMA allocation interface, that
  just grabs a piece of memblock-allocated space from the CMA
  area, which gets marked as allocated in the CMA bitmap
  when the CMA area is initialized. With this, hugepages= can
  be supported with hugetlb_cma=, making scenario 2) work.

Additionally, fix some minor bugs, with one worth mentioning:
since hugetlb gigantic bootmem pages are allocated by memblock,
they may span multiple zones, as memblock doesn't (and mostly
can't) know about zones. This can cause problems. A hugetlb page
spanning multiple zones is bad, and it's worse with HVO, when
the de-HVO step effectively sneakily re-assigns pages to a
different zone than originally configured, since the tail pages
all inherit the zone from the first 60 tail pages. This condition
is not common, but can be easily reproduced using ZONE_MOVABLE.
To fix this, add checks to see if gigantic bootmem pages intersect
with multiple zones, and do not use them if they do, giving them
back to the page allocator instead.

The first patch is kind of along for the ride, except that
maintaining an available_count for a CMA area is convenient
for the multiple range support.

Frank van der Linden (27):
  mm/cma: export total and free number of pages for CMA areas
  mm, cma: support multiple contiguous ranges, if requested
  mm/cma: introduce cma_intersects function
  mm, hugetlb: use cma_declare_contiguous_multi
  mm/hugetlb: remove redundant __ClearPageReserved
  mm/hugetlb: use online nodes for bootmem allocation
  mm/hugetlb: convert cmdline parameters from setup to early
  x86/mm: make register_page_bootmem_memmap handle PTE mappings
  mm/bootmem_info: export register_page_bootmem_memmap
  mm/sparse: allow for alternate vmemmap section init at boot
  mm/hugetlb: set migratetype for bootmem folios
  mm: define __init_reserved_page_zone function
  mm/hugetlb: check bootmem pages for zone intersections
  mm/sparse: add vmemmap_*_hvo functions
  mm/hugetlb: deal with multiple calls to hugetlb_bootmem_alloc
  mm/hugetlb: move huge_boot_pages list init to hugetlb_bootmem_alloc
  mm/hugetlb: add pre-HVO framework
  mm/hugetlb_vmemmap: fix hugetlb_vmemmap_restore_folios definition
  mm/hugetlb: do pre-HVO for bootmem allocated pages
  x86/setup: call hugetlb_bootmem_alloc early
  x86/mm: set ARCH_WANT_HUGETLB_VMEMMAP_PREINIT
  mm/cma: simplify zone intersection check
  mm/cma: introduce a cma validate function
  mm/cma: introduce interface for early reservations
  mm/hugetlb: add hugetlb_cma_only cmdline option
  mm/hugetlb: enable bootmem allocation from CMA areas
  mm/hugetlb: move hugetlb CMA code in to its own file

 Documentation/ABI/testing/sysfs-kernel-mm-cma |  13 +
 .../admin-guide/kernel-parameters.txt         |  21 +-
 Documentation/admin-guide/mm/cma_debugfs.rst  |  10 +-
 MAINTAINERS                                   |   2 +
 arch/powerpc/include/asm/book3s/64/hugetlb.h  |   6 +
 arch/powerpc/mm/hugetlbpage.c                 |   1 +
 arch/powerpc/mm/init_64.c                     |   4 +
 arch/s390/mm/init.c                           |  13 +-
 arch/x86/Kconfig                              |   1 +
 arch/x86/kernel/setup.c                       |   4 +-
 arch/x86/mm/init_64.c                         |  18 +-
 fs/Kconfig                                    |   1 +
 include/linux/bootmem_info.h                  |   7 +
 include/linux/cma.h                           |   9 +
 include/linux/hugetlb.h                       |  35 +
 include/linux/mm.h                            |  13 +-
 include/linux/mmzone.h                        |  35 +
 mm/Kconfig                                    |   6 +
 mm/Makefile                                   |   3 +
 mm/bootmem_info.c                             |   4 +-
 mm/cma.c                                      | 739 +++++++++++++++---
 mm/cma.h                                      |  46 +-
 mm/cma_debug.c                                |  61 +-
 mm/cma_sysfs.c                                |  20 +
 mm/hugetlb.c                                  | 582 ++++++++------
 mm/hugetlb_cma.c                              | 275 +++++++
 mm/hugetlb_cma.h                              |  57 ++
 mm/hugetlb_vmemmap.c                          | 199 ++++-
 mm/hugetlb_vmemmap.h                          |  23 +-
 mm/internal.h                                 |  19 +
 mm/mm_init.c                                  |  78 +-
 mm/sparse-vmemmap.c                           | 168 +++-
 mm/sparse.c                                   |  87 ++-
 33 files changed, 2065 insertions(+), 495 deletions(-)
 create mode 100644 mm/hugetlb_cma.c
 create mode 100644 mm/hugetlb_cma.h

-- 
2.48.1.711.g2feabab25a-goog


