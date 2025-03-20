Return-Path: <linux-kernel+bounces-569033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FB9A69DCE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 02:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3F3A18996F5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 01:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0573B1DE3BA;
	Thu, 20 Mar 2025 01:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2/LClWXi"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAB51CDA0B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 01:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742435763; cv=none; b=Tk/G1v62EiMX/BbiEOlvQr/SqtaxxG/49acQGPf/GTdZxFzg9qfVQ5qyKuWQaFv6XyE+FIHEX3y5zMBkQdaQb+eaY9k8l7gpJ2++hyI4DaOIwVQC28eiRNSjJFnKdkoaAxZhkmbPh7pVRrj7UAWoHYEHc6HWcVeuVpw1zytYoMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742435763; c=relaxed/simple;
	bh=VG6FA0QWGa1ge/mOQpccaNvmQF4oFtiPvuAhE51dBMA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uFhhhAw6AQ6yeR6PboGsQSph09FmeJ99anROsSJ456kWAxQe3tjt+EVne4955yHRcEc+eul+LygfzRZd33Ivf6Lfdw6KR9/D0EVsSq+mgd7iZ4Jx4xGtvhwa+romXpfKGqC50JTSGKdUqp8z+d9H44u3PhQCUl4jWAQ3O2C1UPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--changyuanl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2/LClWXi; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--changyuanl.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-224364f2492so2713165ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 18:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742435760; x=1743040560; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fJIWs/RmPeqP5oWmTUDu0YzJ84Cq5pt18XtxjnOkupA=;
        b=2/LClWXiH56w7vyP7kA50Eo+Sq7FiXPpTJ2jPx0eSmmqWhIrAmTXz5++sd5YbXYFck
         vLiNa9+agtJ3LIASC8fKlpenAsiVLuVz4jp9JDSED4ptvlNJCnUenxaTtpSNTCw7U1xc
         YICoDIJ5x3qcOzySTMAREqZaJwQuOYDpdSilR0ZKgvZxVBe4WhgO0PuviW7ghN4nHJF9
         d++SHi35yHnXdAzQZgP/s9bRZR+sxw72iTA7ns+Stl/Zu+GJ4Z8Rq9Z8RlzHUFcDeFCU
         Qv6VS8Kl9oqlSKKDIZO9/mrq/qYL9SwiG/sqbYho7WlgzWnpG3MrtwORiCXjIhgPRRsV
         lN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742435760; x=1743040560;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fJIWs/RmPeqP5oWmTUDu0YzJ84Cq5pt18XtxjnOkupA=;
        b=cuybgzA4Gu2BNr+iXBe/nm/1lwXt9ENWqGe7COmjEhUs/hVsSd99+QePGM4gk/20nC
         5w5XKHhcnCPi+SJatn8J58RQkNLnvZyVLKhgzEl/Le+Uf4RdCN4Z3oF9ep77urHpOwYX
         Qzz2IbEWmcV3af0GQhmFMxkOHFn/SGxS4spGQapToodAaVmAF8DHD6D4Xvhmnc+QbHUA
         s0cIw/uTdENNiLCtNq3SSsy752V2UoBz7jaGinWGryWx2DSnUKfeI4bRaf2u0Ry0ARDc
         Z//LMUWC/FHVw2DLIfAvsa1VcBU/UxkUyClbv67lX15szBEgcZCWzJegvuuoTQKJnJT3
         BOqg==
X-Gm-Message-State: AOJu0YwVtmqND6bmEY7xqd0BgqY0EzAWQiXn88C3zr1smDSXcXuOddEK
	AVFweMNTuYi4PhVdvqFTK07989938T7uQ5J+g1meVfKwDcGRx+bQWB9axcAb4i0Va6SSbFvXvrN
	uxYt6HvEwhhaY8RLUU/8FCu9WaaCBnMJj9MQQgg8eRMOVxw57V2OTrzI89Uk4Xo6IqOjDKw4ZLd
	Cze5s+3e/slcAc1B7b10OIZ/+x8df/rNZnlRg3kE1P3D/kStQ/g0ZHarWw3ag2Mw==
X-Google-Smtp-Source: AGHT+IFSfjHWsJORGvzYZj6vDxkXyKih6HbHAx5dGbvbNQJB/0VzMeC+2VxQ6zbVq6wG2AlSOPhuB4IOuuaqL1wn
X-Received: from pjbqj15.prod.google.com ([2002:a17:90b:28cf:b0:2ff:5df6:7e03])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ebc3:b0:225:ac99:ae0d with SMTP id d9443c01a7336-2264992dd80mr101668955ad.10.1742435760550;
 Wed, 19 Mar 2025 18:56:00 -0700 (PDT)
Date: Wed, 19 Mar 2025 18:55:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250320015551.2157511-1-changyuanl@google.com>
Subject: [PATCH v5 00/16] kexec: introduce Kexec HandOver (KHO)
From: Changyuan Lyu <changyuanl@google.com>
To: linux-kernel@vger.kernel.org
Cc: graf@amazon.com, akpm@linux-foundation.org, luto@kernel.org, 
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com, 
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com, 
	dave.hansen@linux.intel.com, dwmw2@infradead.org, ebiederm@xmission.com, 
	mingo@redhat.com, jgowans@amazon.com, corbet@lwn.net, krzk@kernel.org, 
	rppt@kernel.org, mark.rutland@arm.com, pbonzini@redhat.com, 
	pasha.tatashin@soleen.com, hpa@zytor.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh+dt@kernel.org, robh@kernel.org, saravanak@google.com, 
	skinsburskii@linux.microsoft.com, rostedt@goodmis.org, tglx@linutronix.de, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, will@kernel.org, 
	devicetree@vger.kernel.org, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, x86@kernel.org, Changyuan Lyu <changyuanl@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

This is a next version of Alexander Graf and Mike Rapoport's
"kexec: introduce Kexec HandOver (KHO)" series
(https://lore.kernel.org/all/20250206132754.2596694-1-rppt@kernel.org/),
with bitmaps for preserving folios and address ranges, new hashtable-based
KHO state tree API, and reduced blackout window with kexec_file_load.

The patches are also available in git:
https://github.com/googleprodkernel/linux-liveupdate/tree/kho/v5

v4 -> v5:
  - New: Preserve folios and address ranges in bitmaps [1]. Removed the
    `mem` property.
  - New: Hash table based API for manipulating the KHO state tree.
  - Change the concept of "active phase" to "finalization phase". KHO
    users can add/remove data into/from KHO DT anytime before the
    finalization phase.
  - Decouple kexec_file_load and KHO FDT creation. kexec_file_load can be
    done before KHO FDT is created.
  - Update the example usecase (reserve_mem) using the new KHO API,
    replace underscores with dashes in reserve-mem fdt generation.
  - Drop the YAMLs for now and add a brief description of KHO FDT before
    KHO schema is stable.
  - Move all sysfs interfaces to debugfs.
  - Fixed the memblock test reported in [2].
  - Incorporate fix for kho_locate_mem_hole() with !CONFIG_KEXEC_HANDOVER
    [3] into "kexec: Add KHO support to kexec file loads".

[1] https://lore.kernel.org/all/20250212152336.GA3848889@nvidia.com/
[2] https://lore.kernel.org/all/20250217040448.56xejbvsr2a73h4c@master/
[3] https://lore.kernel.org/all/20250214125402.90709-1-sourabhjain@linux.ibm.com/

= Original cover letter =

Kexec today considers itself purely a boot loader: When we enter the new
kernel, any state the previous kernel left behind is irrelevant and the
new kernel reinitializes the system.

However, there are use cases where this mode of operation is not what we
actually want. In virtualization hosts for example, we want to use kexec
to update the host kernel while virtual machine memory stays untouched.
When we add device assignment to the mix, we also need to ensure that
IOMMU and VFIO states are untouched. If we add PCIe peer to peer DMA, we
need to do the same for the PCI subsystem. If we want to kexec while an
SEV-SNP enabled virtual machine is running, we need to preserve the VM
context pages and physical memory. See "pkernfs: Persisting guest memory
and kernel/device state safely across kexec" Linux Plumbers
Conference 2023 presentation for details:

  https://lpc.events/event/17/contributions/1485/

To start us on the journey to support all the use cases above, this patch
implements basic infrastructure to allow hand over of kernel state across
kexec (Kexec HandOver, aka KHO). As a really simple example target, we use
memblock's reserve_mem.
With this patch set applied, memory that was reserved using "reserve_mem"
command line options remains intact after kexec and it is guaranteed to
reside at the same physical address.

== Alternatives ==

There are alternative approaches to (parts of) the problems above:

  * Memory Pools [1] - preallocated persistent memory region + allocator
  * PRMEM [2] - resizable persistent memory regions with fixed metadata
                pointer on the kernel command line + allocator
  * Pkernfs [3] - preallocated file system for in-kernel data with fixed
                  address location on the kernel command line
  * PKRAM [4] - handover of user space pages using a fixed metadata page
                specified via command line

All of the approaches above fundamentally have the same problem: They
require the administrator to explicitly carve out a physical memory
location because they have no mechanism outside of the kernel command
line to pass data (including memory reservations) between kexec'ing
kernels.

KHO provides that base foundation. We will determine later whether we
still need any of the approaches above for fast bulk memory handover of for
example IOMMU page tables. But IMHO they would all be users of KHO, with
KHO providing the foundational primitive to pass metadata and bulk memory
reservations as well as provide easy versioning for data.

== Overview ==

We introduce a metadata file that the kernels pass between each other. How
they pass it is architecture specific. The file's format is a Flattened
Device Tree (fdt) which has a generator and parser already included in
Linux. KHO is enabled in the kernel command line by `kho=on`. Drivers can
add/remove data into/from KHO root state tree hash-table anytime. When the
hash-table is converted to FDT (by kernel automatically in the case of
kexec_file_load or by the userspace manually through debugfs kho/out/finalize),
the kernel invokes callbacks to every driver that supports KHO to serialize
its state. When the actual kexec happens, the fdt is part of the image
set that we boot into. In addition, we keep a "scratch regions" available
for kexec: A physically contiguous memory regions that is guaranteed to
not have any memory that KHO would preserve. The new kernel bootstraps
itself using the scratch regions and sets all handed over memory as in use.
When drivers initialize that support KHO, they introspect the fdt and
recover their state from it. This includes memory reservations, where the
driver can either discard or claim reservations.

== Limitations ==

Currently KHO is only implemented for file based kexec. The kernel
interfaces in the patch set are already in place to support user space
kexec as well, but it is still not implemented it yet inside kexec tools.

== How to Use ==

To use the code, please boot the kernel with the "kho=on" command line
parameter.
KHO will automatically create scratch regions. If you want to set the
scratch size explicitly you can use "kho_scratch=" command line parameter.
For instance, "kho_scratch=16M,512M,256M" will reserve a 16 MiB low
memory scratch area, a 512 MiB global scratch region, and 256 MiB
per NUMA node scratch regions on boot.

Make sure to have a reserved memory range requested with reserv_mem
command line option. Then you invoke file based "kexec -l",

  # kexec -l Image --initrd=initrd -s
  # kexec -e

The new kernel will boot up and contain the previous kernel's reserve_mem
contents at the same physical address as the first kernel.

Optionally, you can finalize the KHO FDT early by

  # echo 1 > /sys/kernel/debug/kho/out/finalize

which allows you to preview the FDT to be passed to the next kernel at
/sys/kernel/debug/kho/out/fdt.

== Changelog ==

v3 -> v4:
  - Major rework of scrach management. Rather than force scratch memory
    allocations only very early in boot now we rely on scratch for all
    memblock allocations.
  - Use simple example usecase (reserv_mem instead of ftrace)
  - merge all KHO functionality into a single kernel/kexec_handover.c file
  - rename CONFIG_KEXEC_KHO to CONFIG_KEXEC_HANDOVER

v2 -> v3:
  - Fix make dt_binding_check
  - Add descriptions for each object
  - s/trace_flags/trace-flags/
  - s/global_trace/global-trace/
  - Make all additionalProperties false
  - Change subject to reflect subsysten (dt-bindings)
  - Fix indentation
  - Remove superfluous examples
  - Convert to 64bit syntax
  - Move to kho directory
  - s/"global_trace"/"global-trace"/
  - s/"global_trace"/"global-trace"/
  - s/"trace_flags"/"trace-flags"/
  - Fix wording
  - Add Documentation to MAINTAINERS file
  - Remove kho reference on read error
  - Move handover_dt unmap up
  - s/reserve_scratch_mem/mark_phys_as_cma/
  - Remove ifdeffery
  - Remove superfluous comment

v1 -> v2:
  - Removed: tracing: Introduce names for ring buffers
  - Removed: tracing: Introduce names for events
  - New: kexec: Add config option for KHO
  - New: kexec: Add documentation for KHO
  - New: tracing: Initialize fields before registering
  - New: devicetree: Add bindings for ftrace KHO
  - test bot warning fixes
  - Change kconfig option to ARCH_SUPPORTS_KEXEC_KHO
  - s/kho_reserve_mem/kho_reserve_previous_mem/g
  - s/kho_reserve/kho_reserve_scratch/g
  - Remove / reduce ifdefs
  - Select crc32
  - Leave anything that requires a name in trace.c to keep buffers
    unnamed entities
  - Put events as array into a property, use fingerprint instead of
    names to identify them
  - Reduce footprint without CONFIG_FTRACE_KHO
  - s/kho_reserve_mem/kho_reserve_previous_mem/g
  - make kho_get_fdt() const
  - Add stubs for return_mem and claim_mem
  - make kho_get_fdt() const
  - Get events as array from a property, use fingerprint instead of
    names to identify events
  - Change kconfig option to ARCH_SUPPORTS_KEXEC_KHO
  - s/kho_reserve_mem/kho_reserve_previous_mem/g
  - s/kho_reserve/kho_reserve_scratch/g
  - Leave the node generation code that needs to know the name in
    trace.c so that ring buffers can stay anonymous
  - s/kho_reserve/kho_reserve_scratch/g
  - Move kho enums out of ifdef
  - Move from names to fdt offsets. That way, trace.c can find the trace
    array offset and then the ring buffer code only needs to read out
    its per-CPU data. That way it can stay oblivient to its name.
  - Make kho_get_fdt() const

Alexander Graf (9):
  memblock: Add support for scratch memory
  kexec: add Kexec HandOver (KHO) generation helpers
  kexec: add KHO parsing support
  kexec: add KHO support to kexec file loads
  kexec: add config option for KHO
  arm64: add KHO support
  x86: add KHO support
  memblock: add KHO support for reserve_mem
  Documentation: add documentation for KHO

Changyuan Lyu (1):
  hashtable: add macro HASHTABLE_INIT

Mike Rapoport (Microsoft) (5):
  mm/mm_init: rename init_reserved_page to init_deferred_page
  memblock: add MEMBLOCK_RSRV_KERN flag
  memblock: introduce memmap_init_kho_scratch()
  kexec: enable KHO support for memory preservation
  x86/setup: use memblock_reserve_kern for memory used by kernel

steven chen (1):
  kexec: define functions to map and unmap segments

 .../admin-guide/kernel-parameters.txt         |   25 +
 Documentation/kho/concepts.rst                |   70 +
 Documentation/kho/fdt.rst                     |   62 +
 Documentation/kho/index.rst                   |   14 +
 Documentation/kho/usage.rst                   |  118 ++
 Documentation/subsystem-apis.rst              |    1 +
 MAINTAINERS                                   |    3 +-
 arch/arm64/Kconfig                            |    3 +
 arch/x86/Kconfig                              |    3 +
 arch/x86/boot/compressed/kaslr.c              |   52 +-
 arch/x86/include/asm/setup.h                  |    4 +
 arch/x86/include/uapi/asm/setup_data.h        |   13 +-
 arch/x86/kernel/e820.c                        |   18 +
 arch/x86/kernel/kexec-bzimage64.c             |   36 +
 arch/x86/kernel/setup.c                       |   41 +-
 arch/x86/realmode/init.c                      |    2 +
 drivers/of/fdt.c                              |   33 +
 drivers/of/kexec.c                            |   37 +
 include/linux/hashtable.h                     |    7 +-
 include/linux/kexec.h                         |   12 +
 include/linux/kexec_handover.h                |  202 ++
 include/linux/memblock.h                      |   41 +-
 kernel/Kconfig.kexec                          |   15 +
 kernel/Makefile                               |    1 +
 kernel/kexec_core.c                           |   58 +
 kernel/kexec_file.c                           |   19 +
 kernel/kexec_handover.c                       | 1755 +++++++++++++++++
 kernel/kexec_internal.h                       |   18 +
 mm/Kconfig                                    |    4 +
 mm/internal.h                                 |    2 +
 mm/memblock.c                                 |  303 ++-
 mm/mm_init.c                                  |   19 +-
 tools/testing/memblock/tests/alloc_api.c      |   22 +-
 .../memblock/tests/alloc_helpers_api.c        |    4 +-
 tools/testing/memblock/tests/alloc_nid_api.c  |   20 +-
 35 files changed, 2988 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/kho/concepts.rst
 create mode 100644 Documentation/kho/fdt.rst
 create mode 100644 Documentation/kho/index.rst
 create mode 100644 Documentation/kho/usage.rst
 create mode 100644 include/linux/kexec_handover.h
 create mode 100644 kernel/kexec_handover.c


base-commit: a7f2e10ecd8f18b83951b0bab47ddaf48f93bf47
--
2.48.1.711.g2feabab25a-goog

