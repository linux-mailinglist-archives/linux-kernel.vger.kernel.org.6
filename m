Return-Path: <linux-kernel+bounces-184896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 173548CAD8B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CC1C1F234B3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 11:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B22D75815;
	Tue, 21 May 2024 11:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7Y2msQB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227817580B
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 11:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716292126; cv=none; b=XeaJV39T87iZO13O9SLGfv71fo7HPVLb4uiP7xnwHLBd1BKTfO6JktTvgQ76lELBAGDuZbZb3JwPYgljMIKYEZyL5mNBFt+95BbKc/agJYW6S2m2NZlzFIJTuIR2xLB0Kvuwnpv/5rR6SW1a5IU6xvb1TVLkFJtksPbyzLy3sSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716292126; c=relaxed/simple;
	bh=w74oySSkmlGhE0TfH1tB7F1tx4YTKjzIh/pSxeIstk8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GW3LnzU8eAtxTYWlLGsqWEY5MvcWGyNSW8++x41B2HH9nmoGlJycrDs0VMfdHb+GR5VXPrbp74QAd+Je+8gEHi4LsdVHwdOjM4pokVtp9YwiuWOugLTmzpZGfk7A1j+xwLxshMb8cfmreYthH7hFUh1FwwKRfgyUjzinoJ74ep0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7Y2msQB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05DADC2BD11;
	Tue, 21 May 2024 11:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716292125;
	bh=w74oySSkmlGhE0TfH1tB7F1tx4YTKjzIh/pSxeIstk8=;
	h=From:To:Cc:Subject:Date:From;
	b=Z7Y2msQBI4viLlGJ0SpmMkYpvV3AS1iRehsdy1KRmCwEn7RV12UVquGp0XqkpYfNY
	 v2aE1vjDmYa52XjWBtWrRfspwdE0jHGxK+PwYUvpFLIPi52dq2gHNp4JK79Az0x4Vl
	 c9GvyfNDuZc9fnRcOAc2eza0B26LvqOJEZTA6tqIxXr0IKfjh3gc7Ry63ANlZxfqvE
	 adAQpi119naNEOc24zn/tZAvOm++JqXSUymNnxV96y/k3esg9bWhzOiLbxRcuNBs5e
	 odszu3eEZG+axxtfVKk9WsRbhNSkGYXY5+sARrQLydAe3LcYNsSrAFzJ4ITpn5qcE9
	 GJUHONG2kQL6Q==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	David Hildenbrand <david@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org,
	Oscar Salvador <osalvador@suse.de>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Andrew Bresticker <abrestic@rivosinc.com>,
	Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Santosh Mamila <santosh.mamila@catalinasystems.io>,
	Sivakumar Munnangi <siva.munnangi@catalinasystems.io>,
	Sunil V L <sunilvl@ventanamicro.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v3 0/9] riscv: Memory Hot(Un)Plug support 
Date: Tue, 21 May 2024 13:48:21 +0200
Message-Id: <20240521114830.841660-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

================================================================
Memory Hot(Un)Plug support (and ZONE_DEVICE) for the RISC-V port
================================================================

Introduction
============

To quote "Documentation/admin-guide/mm/memory-hotplug.rst": "Memory
hot(un)plug allows for increasing and decreasing the size of physical
memory available to a machine at runtime."

This series adds memory hot(un)plugging, and ZONE_DEVICE support for
the RISC-V Linux port.

MM configuration
================

RISC-V MM has the following configuration:

 * Memory blocks are 128M, analogous to x86-64. It uses PMD
   ("hugepage") vmemmaps. From that follows that 2M (PMD) worth of
   vmemmap spans 32768 pages á 4K which gets us 128M.

 * The pageblock size is the minimum minimum virtio_mem size, and on
   RISC-V it's 2M (2^9 * 4K).

Implementation
==============

The PGD table on RISC-V is shared/copied between for all processes. To
avoid doing page table synchronization, the first patch (patch 1)
pre-allocated the PGD entries for vmemmap/direct map. By doing that
the init_mm PGD will be fixed at kernel init, and synchronization can
be avoided all together.

The following two patches (patch 2-3) does some preparations, followed
by the actual MHP implementation (patch 4-5). Then, MHP and virtio-mem
are enabled (patch 6-7), and finally ZONE_DEVICE support is added
(patch 8).

MHP and locking
===============

TL;DR: The MHP does not step on any toes, except for ptdump.
Additional locking is required for ptdump.

Long version: For v2 I spent some time digging into init_mm
synchronization/update. Here are my findings, and I'd love them to be
corrected if incorrect.

It's been a gnarly path...

The `init_mm` structure is a special mm (perhaps not a "real" one).
It's a "lazy context" that tracks kernel page table resources, e.g.,
the kernel page table (swapper_pg_dir), a kernel page_table_lock (more
about the usage below), mmap_lock, and such.

`init_mm` does not track/contain any VMAs. Having the `init_mm` is
convenient, so that the regular kernel page table walk/modify
functions can be used.

Now, `init_mm` being special means that the locking for kernel page
tables are special as well.

On RISC-V the PGD (top-level page table structure), similar to x86, is
shared (copied) with user processes. If the kernel PGD is modified, it
has to be synched to user-mode processes PGDs. This is avoided by
pre-populating the PGD, so it'll be fixed from boot.

The in-kernel pgd regions are documented in
`Documentation/arch/riscv/vm-layout.rst`.

The distinct regions are:
 * vmemmap
 * vmalloc/ioremap space
 * direct mapping of all physical memory
 * kasan
 * modules, BPF
 * kernel

Memory hotplug is the process of adding/removing memory to/from the
kernel.

Adding is done in two phases:
 1. Add the memory to the kernel
 2. Online memory, making it available to the page allocator.

Step 1 is partially architecture dependent, and updates the init_mm
page table:
 * Update the direct map page tables. The direct map is a linear map,
   representing all physical memory: `virt = phys + PAGE_OFFSET`
 * Add a `struct page` for each added page of memory. Update the
   vmemmap (virtual mapping to the `struct page`, so we can easily
   transform a kernel virtual address to a `struct page *` address.

From an MHP perspective, there are two regions of the PGD that are
updated:
 * vmemmap
 * direct mapping of all physical memory

The `struct mm_struct` has a couple of locks in play:
 * `spinlock_t page_table_lock` protects the page table, and some
    counters
 * `struct rw_semaphore mmap_lock` protect an mm's VMAs

Note again that `init_mm` does not contain any VMAs, but still uses
the mmap_lock in some places.

The `page_table_lock` was originally used to to protect all pages
tables, but more recently a split page table lock has been introduced.
The split lock has a per-table lock for the PTE and PMD tables. If
split lock is disabled, all tables are guarded by
`mm->page_table_lock` (for user processes). Split page table locks are
not used for init_mm.

MHP operations is typically synchronized using
`DEFINE_STATIC_PERCPU_RWSEM(mem_hotplug_lock)`.

Actors
------

The following non-MHP actors in the kernel traverses (read), and/or
modifies the kernel PGD.

 * `ptdump`

   Walks the entire `init_mm`, via `ptdump_walk_pgd()` with the
   `mmap_write_lock(init_mm)` taken.

   Observation: ptdump can race with MHP, and needs additional locking
   to avoid crashes/races.

 * `set_direct_*` / `arch/riscv/mm/pageattr.c`

   The `set_direct_*` functionality is used to "synchronize" the
   direct map to other kernel mappings, e.g. modules/kernel text. The
   direct map is using "as large huge table mappings as possible",
   which means that the `set_direct_*` might need to split the direct
   map.

  The `set_direct_*` functions operates with the
  `mmap_write_lock(init_mm)` taken.

  Observation: `set_direct_*` uses the direct map, but will never
  modify the same entry as MHP. If there is a mapping, that entry will
  never race with MHP. Further, MHP acts when memory is offline.

 * HVO / `mm/hugetlb_vmemmap`

   HVO optimizes the backing `struct page` for hugetlb pages, which
   means changing the "vmemmap" region. HVO can split (merge?) a
   vmemmap pmd. However, it will never race with MHP, since HVO only
   operates at online memory. HVO cannot touch memory being MHP added
   or removed.

 * `apply_to_page_range`

   Walks a range, creates pages and applies a callback (setting
   permissions) for the page.

   When creating a table, it might use `int __pte_alloc_kernel(pmd_t
   *pmd)` which takes the `init_mm.page_table_lock` to synchronize pmd
   populate.

   Used by: `mm/vmalloc.c` and `mm/kasan/shadow.c`. The KASAN callback
   takes the `init_mm.page_table_lock` to synchronize pte creation.

   Observations: `apply_to_page_range` applies to the "vmalloc/ioremap
   space" region, and "kasan" region. *Not* affected by MHP.

 * `apply_to_existing_page_range`

   Walks a range, applies a callback (setting permissions) for the
   page (no page creation).

   Used by: `kernel/bpf/arena.c` and `mm/kasan/shadow.c`. The KASAN
   callback takes the `init_mm.page_table_lock` to synchronize pte
   creation. *Not* affected by MHP regions.

 * `apply_to_existing_page_range` applies to the "vmalloc/ioremap
   space" region, and "kasan" region. *Not* affected by MHP regions.

 *  `ioremap_page_range` and `vmap_page_range`

    Uses the same internal function, and might create table entries at
    the "vmalloc/ioremap space" region. Can call
    `__pte_alloc_kernel()` which takes the `init_mm.page_table_lock`
    synchronizing pmd populate in the region. *Not* affected by MHP
    regions.

Summary:
  * MHP add will never modify the same page table entries, as any of
    the other actors.
  * MHP remove is done when memory is offlined, and will not clash
    with any of the actors.
  * Functions that walk the entire kernel page table need
    synchronization

  * It's sufficient to add the MHP lock ptdump.

Testing
=======

This series adds basic DT supported hotplugging. There is a QEMU
series enabling MHP for the RISC-V "virt" machine here: [1]

ACPI/MSI support is still in the making for RISC-V, and prior proper
(ACPI) PCI MSI support lands [2] and NUMA SRAT support [3], it hard to
try it out.

I've prepared a QEMU branch with proper ACPI GED/PC-DIMM support [4],
and a this series with the required prerequisites [5] (AIA, ACPI AIA
MADT, ACPI NUMA SRAT).


To test with virtio-mem, e.g.:
  | qemu-system-riscv64 \
  |     -machine virt,aia=aplic-imsic \
  |     -cpu rv64,v=true,vlen=256,elen=64,h=true,zbkb=on,zbkc=on,zbkx=on,zkr=on,zkt=on,svinval=on,svnapot=on,svpbmt=on \
  |     -nodefaults \
  |     -nographic -smp 8 -kernel rv64-u-boot.bin \
  |     -drive file=rootfs.img,format=raw,if=virtio \
  |     -device virtio-rng-pci \
  |     -m 16G,slots=3,maxmem=32G \
  |     -object memory-backend-ram,id=mem0,size=16G \
  |     -numa node,nodeid=0,memdev=mem0 \
  |     -serial chardev:char0 \
  |     -mon chardev=char0,mode=readline \
  |     -chardev stdio,mux=on,id=char0 \
  |     -device pci-serial,id=serial0,chardev=char0 \
  |     -object memory-backend-ram,id=vmem0,size=2G \
  |     -device virtio-mem-pci,id=vm0,memdev=vmem0,node=0

where "rv64-u-boot.bin" is U-boot with EFI/ACPI-support (use [6] if
you're lazy).

In the QEMU monitor:
  | (qemu) info memory-devices
  | (qemu) qom-set vm0 requested-size 1G

..to test DAX/KMEM, use the follow QEMU parameters:
  |  -object memory-backend-file,id=mem1,share=on,mem-path=virtio_pmem.img,size=4G \
  |  -device virtio-pmem-pci,memdev=mem1,id=nv1

and the regular ndctl/daxctl dance.

If you're brave to try the ACPI branch, add "acpi=on" to "-machine
virt", and test PC-DIMM MHP (in addition to virtio-{p},mem):

In the QEMU monitor:
  | (qemu) object_add memory-backend-ram,id=mem1,size=1G
  | (qemu) device_add pc-dimm,id=dimm1,memdev=mem1

You can also try hot-remove with some QEMU options, say:
  | -object memory-backend-file,id=mem-1,size=256M,mem-path=/pagesize-2MB
  | -device pc-dimm,id=mem1,memdev=mem-1
  | -object memory-backend-file,id=mem-2,size=1G,mem-path=/pagesize-1GB
  | -device pc-dimm,id=mem2,memdev=mem-2
  | -object memory-backend-file,id=mem-3,size=256M,mem-path=/pagesize-2MB
  | -device pc-dimm,id=mem3,memdev=mem-3

Remove "acpi=on" to run with DT.

Thanks to Alex, Andrew, David, and Oscar for all
comments/tests/fixups.

Changelog
=========

v2->v3:
  Collect tags
  0001-riscv-mm-Properly-forward-vmemmap_populate-altmap
    * New patch, split from attribute change (Alex, Oscar)
  0005-riscv-mm-Add-memory-hotplugging-support
    * Fix page table free to take PG_reserved into consideration (David,
      Oscar)
    * Depend on SPARSE_VMEMMAP (Alex, David, Oscar)
    * Proper TLB flushing (Alex)
  0009-riscv-mm-Add-support-for-ZONE_DEVICE
    * Fixed 32b build

v1->v2:
  Reviewed a lot of MHP locking scenarios
  Various config build issues (e.g. build !CONFIG_MEMORY_HOTPLUG) (Andrew)
  Added arch_get_mappable_range() implementation
  Acquire MHP lock for ptdump, analogous to arm64
  ACPI MHP tests
  Add ZONE_DEVICE patch

References
==========

[1] https://lore.kernel.org/qemu-devel/20240521105635.795211-1-bjorn@kernel.org/
[2] https://lore.kernel.org/linux-riscv/20240501121742.1215792-1-sunilvl@ventanamicro.com/
[3] https://lore.kernel.org/linux-riscv/cover.1713778236.git.haibo1.xu@intel.com/
[4] https://github.com/bjoto/qemu/commits/virtio-mem-pc-dimm-mhp-acpi-v2/
[5] https://github.com/bjoto/linux/commits/mhp-v3-next-acpi
[6] https://github.com/bjoto/riscv-rootfs-utils/tree/acpi


Thanks,
Björn

Björn Töpel (9):
  riscv: mm: Properly forward vmemmap_populate() altmap parameter
  riscv: mm: Pre-allocate vmemmap/direct map PGD entries
  riscv: mm: Change attribute from __init to __meminit for page
    functions
  riscv: mm: Refactor create_linear_mapping_range() for memory hot add
  riscv: mm: Add memory hotplugging support
  riscv: mm: Take memory hotplug read-lock during kernel page table dump
  riscv: Enable memory hotplugging for RISC-V
  virtio-mem: Enable virtio-mem for RISC-V
  riscv: mm: Add support for ZONE_DEVICE

 arch/riscv/Kconfig                    |   3 +
 arch/riscv/include/asm/kasan.h        |   4 +-
 arch/riscv/include/asm/mmu.h          |   4 +-
 arch/riscv/include/asm/pgtable-64.h   |  20 ++
 arch/riscv/include/asm/pgtable-bits.h |   1 +
 arch/riscv/include/asm/pgtable.h      |  19 +-
 arch/riscv/mm/init.c                  | 339 +++++++++++++++++++++++---
 arch/riscv/mm/ptdump.c                |   3 +
 drivers/virtio/Kconfig                |   2 +-
 9 files changed, 349 insertions(+), 46 deletions(-)


base-commit: 92cce91949a497a8a4615f9ba5813b03f7a1f1d5
-- 
2.40.1


