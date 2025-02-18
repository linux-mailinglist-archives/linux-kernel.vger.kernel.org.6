Return-Path: <linux-kernel+bounces-520043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A72A3A514
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A338F3AD696
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6296270ECB;
	Tue, 18 Feb 2025 18:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EDk8uOcT"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649962676C5
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902629; cv=none; b=PTXSXgwzimdKf+WYRQA51UAdXPhvEBovrdHJT+tyzlHkkVZ5SicQriW6JcESM8/O1JwkaRRuCqNpdQ5PQQlZuDseIHplJpYMrMUb9bO7wdJOmY0X73QsUPlAb4dWulOUJU0ZkEF8HzcTnIGzHkKzJ0/GU6QhNEryasOHLkYVxsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902629; c=relaxed/simple;
	bh=hzIOfEeOoNQYQAQIiPjvAgIwOfCSEohlTE003Pw8p7c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=H+4OzmxlOTQFrYVHik/5ne2o4ayYnEoWqi5URb/RrK4h+89b8sm6wkknBkcArtqfEQySXYW2Iaguev5cLYth02BdaV2pPP9m5VXWM30JwZDhmGlZu8EwjMY98gvhBudziiBEQ/8kqQNwh+N6vaEnOjOlop3Qjb+i1061QlgeSko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EDk8uOcT; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc0bc05b36so18440493a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739902626; x=1740507426; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jisVN5bTJe7Fi8QsBTJqEyml9eIdvwz50hIBvYWlrsk=;
        b=EDk8uOcTvIQEz+98bwDXubx0pMph+358H4SmY50sLoLmUDJNu8Nb974m4CtxbXG7qH
         JXvitm0oYMKk7enfwYiTZkyAtc/ylV1xNjL3TycXocqmBH084gM93IIDTNGf+Jg7w3gt
         L4cHNeTZpQcERMisJS7tLpe6ScmzoX0hqv7tDMXdQGCcoXReDxc9OtAtKzeHlPFb3ooz
         f9gtOpdvz6RAeb4I/gxLmBdD4wVeZn+04YN0gSUV7vyHyZ2disaiIuLXMAS+sve/MF0i
         S7VxkXTmQaSzYJrJLH5oMp5txYoNpTyOLsfPnGzFAoC7fWju1FFJZxPFCSez70NjAFSx
         Dbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739902626; x=1740507426;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jisVN5bTJe7Fi8QsBTJqEyml9eIdvwz50hIBvYWlrsk=;
        b=O5Fo7NgjME6vLtJMxXr2Ml05VOZF0DgI/D0lTCh7jKBUsVsjH8t5gyRNd2ov0vGm6Q
         VAY+8Rh+QjiKGilbkswoAIKogN1o8xkQEqClGhRc+X/NOPxKkpQLb8YBcdFEjHOYT7I3
         grVRiUYiHiZOIqdGGgknh+e6bi26xlgFBMbEkf3sRDOeMJUOmaUxdFDl9STyRqd3/KG6
         fH8uChQHvoi3LRol08D/BGrB3eUDtdzE9YCijuJrp3e+vdCwHU42GnWTgYVgUF90g2Sv
         8HiFJ+9r4rF9z1wB6ZC9QHJZbYjR3NVY7Trvh+kXyx8bEwVBwNK/To2t8o+vi3NEloeE
         youg==
X-Forwarded-Encrypted: i=1; AJvYcCWRy5yC7F2X2t2k6nbhDBHf8Qd47OMqRt5JUTy6HANkh/PISIdoOFTU1xI8oXStHnrBAJYQkbu35Jb5Ejk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkhQpO+tM0g0TO/v4NuJiOnCF6AullOyWG05tr6LVf2c4Pu9of
	FDfq6c4r6vNCU9UHYxyVCwFooasEH8IJXzD9cx5h9fcpMjtMS9yGeKXeO2pcBoyUwhx6yg==
X-Google-Smtp-Source: AGHT+IGaLH0jnj/yKNp2m9q9TkjCOe3LzVl4lYPJZ/pJ2hRpG0FKvat+KHpmOpia+azxtVdQ4BRqLybW
X-Received: from pfbce6.prod.google.com ([2002:a05:6a00:2a06:b0:730:8e17:ed06])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:778a:b0:1ee:c093:e235
 with SMTP id adf61e73a8af0-1eec093e4f5mr7917342637.41.1739902626668; Tue, 18
 Feb 2025 10:17:06 -0800 (PST)
Date: Tue, 18 Feb 2025 18:16:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250218181656.207178-1-fvdl@google.com>
Subject: [PATCH v4 00/27] hugetlb/CMA improvements for large systems
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"

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
  x86/mm: set ARCH_WANT_SPARSEMEM_VMEMMAP_PREINIT
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
 include/linux/bootmem_info.h                  |   7 +
 include/linux/cma.h                           |   9 +
 include/linux/hugetlb.h                       |  35 +
 include/linux/mm.h                            |  13 +-
 include/linux/mmzone.h                        |  35 +
 mm/Kconfig                                    |   8 +
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
 32 files changed, 2066 insertions(+), 495 deletions(-)
 create mode 100644 mm/hugetlb_cma.c
 create mode 100644 mm/hugetlb_cma.h

-- 
2.48.1.601.g30ceb7b040-goog


