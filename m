Return-Path: <linux-kernel+bounces-176987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1658C3840
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 21:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D5C51F21FAB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 19:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F29F537F8;
	Sun, 12 May 2024 19:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4AKdaBm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BED1E49B;
	Sun, 12 May 2024 19:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715542622; cv=none; b=uU1tZi8qS0UvuJ36C3QNvjS1Lsk5luZdfPnpYJ5HinDxf3srQrP+Moe8ZodlSlM9BQImAljiGuXcHEcjariGE4kG1WCs8mJOusNcrtHDQdcueQG/xNWoM304sh5jXyOZL7qj4sEi6ivPB9OjGRvWkHrb2Jk7LBjUcEJFuv9NSCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715542622; c=relaxed/simple;
	bh=G3fKAHoXNuSOhxG4z6fY0m1GA0VfSM6YMAmFNFcbFIs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=P7Y5A9phh85cMbPYyMorrONIYWrQlmpk4thrwNmZggsU4paQqEVlCaOvnJnY2RicGqCuf61YrCXN4wbRhNw4lOqg4oQEtx8O7RJ8Bj4ARME+Jym8NeEwG08E0K4IAvyvzntfOdQoDNAcF+JbLU4zmOq6Wwjrw/74AaVkcoK2dys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4AKdaBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA7CC116B1;
	Sun, 12 May 2024 19:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715542622;
	bh=G3fKAHoXNuSOhxG4z6fY0m1GA0VfSM6YMAmFNFcbFIs=;
	h=From:To:Cc:Subject:Date:From;
	b=F4AKdaBmJKF6MiTekaIcFuljt1y9pAAHHFxActeMtbAVulgDn9sCdvYF6ZotuFbpm
	 RWM2y44ZKXy+PJWJAwDKGQivqoLuLWmPdEXlLbk8d09uKUFBj10lxlXkIgFJDuO+18
	 vurXRNl739aGh5X+tTbkA8udQeSqHVY7TqtCRj9PZIBjGUXP88Bvhy4a7QYgrYrRzU
	 db1uVfBl0Bhj/1j7ISuG1sCE1NV+QE6E04G+u/0yWhAE9N9sf2CWnd8jZsnPwEmUrp
	 DeJyHL5ruE3LgnV/iip3w+e2Mvzo42FSJjWHN3T4EXHaeTX0Tq7NR4LNY4dkISa606
	 KmhQgCz9JVpTQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	cxiaoyi@amazon.com,
	sieberf@amazon.com,
	bodeddub@amazon.com,
	jiamingy@amazon.com
Subject: [RFC IDEA v2 0/6] mm/damon: introduce Access/Contiguity-aware Memory Auto-scaling (ACMA)
Date: Sun, 12 May 2024 12:36:51 -0700
Message-Id: <20240512193657.79298-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Extend DAMOS for access-aware gradual contiguous memory regions
allocation, and implement a module for efficiently and automatically
scaling system memory using the feature.

This is not a valid patchset but a summary of the idea and pseudo-code
level partial implementation examples of the idea.  The implementation
examples are only for helping people's understanding of the idea and how
it would be implemented.  The code is not tested at all.  It is even not
attempted to be compiled ever.

Motivation: Memory Overcommit Virtual Machine Systems
=====================================================

This work is motivated by an effort to improve efficiency and
reliability of a memory over-committed virtual machine system operation
method.  This section describes a business model of such systems, an
available approach, and its limitations.

Business Model
--------------

The business services compute/memory resource for users' workloads.  The
service provider receives the workload from the user, runs the workload
on their guest virtual machines, and returns the workload's output back
to the user.  The provider calculates how much of their resource is
consumed by the workload, and ask the user to pay for the real usage.

To maximize the host-level memory utilization while providing the
highest performance and lowest price to the user, the provider
overcommit the host's memory and automatically scales the guests' memory
based on their estimation of the workload's true memory demand in
runtime.  To avoid low performance or high price resulting from the
provider's mistakes in the auto-scaling, the user can specify the
minimum and maximum amount of memory for their guest machine.

  User                              Service Provider
                                   ┌─────────────────┐
  workload, min/max memory ──────► │                 │
                                   │      ???        │
  workload output, bill    ◄────── │                 │
                                   └─────────────────┘

Existing Approach
-----------------

It is challenging to estimate real memory demand of guests from the host
in high accuracy.  Meanwhile, the service provider owns the control of
both the host and guests.  Therefore they use a guests-driven
cooperative management.  The guest reports unnecessary pages to the
host, and the host reallocates the reported pages to other guests.
Specifically, free pages reporting is being used.

The host-level reuse of the page is invisible to guests.  Guests can
simply use their pages regardless of the reporting.  If a guest access a
page that reported before, the host detects it via page faults, and give
the memory back to the guest.

Unless the guest is memory-frugal, only small amount of the guests'
memory is reported to the host, and the host-level memory utilization
drops.  To make the guests be memory-frugal with minimum performance
impact, the guests run access-aware proactive memory reclamation using
DAMON.  The basic structure of the system looks like below.

  ┌─────────────────────────────┐      ┌─────────┐
  │  Guest 1                    │      │ Guest 2 │
  │ ┌─────────────────────────┐ │      │         │
  │ │ DAMON-based ReClamation │ │      │         │
  │ └────────────┬────────────┘ │      │         │
  │              │ Reclaim      │      │         │
  │              ▼              │      │         │
  │ ┌─────────────────────────┐ │      │         │
  │ │  Free pages reporting   │ │      │         │
  │ └────────────┬────────────┘ │      │         │
  │              │              │      │         │
  └──────────────┼──────────────┘      └─────────┘
                 │ Report reclaimed         ▲
                 ▼ (free) pages             │ Alloc Guest 1
  ┌───────────────────────────────┐         │ freed memory
  │            Host               ├─────────┘
  └───────────────────────────────┘

The guest uses 4 KiB-size regular page by default while the host uses 2
MiB-size regular page for efficient management of the huge host-level
memory.  Hence, even if a guest reports a 4 KiB-page, the host cannot
use it unless its 511 neighbor pages are also reported.  Letting the
guest reports every 4 KiB-page only increase the reporting overhead.
Hence the free pages reporting is tuned to work in 2 MiB granularity.
To avoid fragmented free pages not being reported, guests also
proactively run memory compaction ('/proc/sys/vm/compact_memory').

The provider further wants to minimize the 'struct page' overhead.  For
that, the guests continuously estimate real memory demands of the
running workload, and hot-[un]plug memory blocks with
'memory_hotplug.memmap_on_memory' so that 'struct page' objects for
offlined memory blocks can also be deallocated.  The guest kernel is
modified to let the user space do hot-[un]plug memory blocks, and report
the hot-unplugged memory block to the host.  This memory
hot-[un]plugging is also being used to keep the user-specified maximum
memory limit.

Limitations
-----------

The approach uses four kernel features, namely free pages reporting,
DAMON-based proactive reclamation, compaction, and memory
hot-[un]plugging.  Utilizing the four kernel features that not designed
to be used together for the specific case from user space in an
efficient way is somewhat challenging.

Memory hot-unplugging is slow and easy to fail.  The problem mainly
comes from the fact that the operation requires isolating and migrating
pages in the block to other blocks, and the operation works in memory
block granularity, which is huge compared to pages.  The minimum amount
of works for doing it is not small, and the probability to meet
unmovable pages in the huge block is not low.  This makes the
guest-level memory scaling beocmes slow and unreliable, which results in
low host-level memory efficiency.

The system-level compaction is not optimized for only the reporting
purpose.  It could consume resource for compacting some part of memory
that anyway will not be able to be reported to the host for reuse.

Both hot-unplugging and compaction require pages isolations and
migrations, which are valid to fail for some reasons.  The operations
may better to be applied to cold pages first, since cold pages would
have lower probability to be pinned or making performance impact.  But
both hot-unplugging and compaction are access pattern oblivious.

There is no control to the reported pages.  This helps keeping the
system simple, but it makes reusing reported pages unreliable.  Any
reported page can be accessed again by the guest.  And even if only one
page among the reported 512 pages are accessed again, the entire 512
pages need to be returned to the guest.

Both the host and guest systems are under the service provider's
control, but the workload is not.  Occasional host-level memory pressure
is hence inevitable.  The host could avoid such situation by setting
the host-driven hard memory limit on guests.  Balloon drivers like
methods could be used.  However, such existing mechanisms lacks the
understanding of the host's different page size and access-oblivious.

Design
======

We mitigate the limitations by introducing a way to get ownership of
contiguous memory regions in an access-aware way, implementing a kernel
module that automatically scales the memory of the system in an
access/contiguity-aware way, and replacing the approach with the module.

Access-aware Contiguous Memory Allocation
-----------------------------------------

As mentioned on the above limitations section, doing page isolations and
migrations, which are core operations of the memory scaling usage, in
fine granularity for cold pages first may makes some improvements.
DAMOS helps applying specific memory operations in an access-aware
manner.  Therefore, we implement the core operations as DAMOS schemes.
For this, we design two new DAMOS actions, namely 'alloc' and 'free'.

'Alloc' DAMOS action migrates in-use pages of the DAMOS target memory
region out of the region, and get the ownership of the pages.  The
action also receives the granularity of the operation to apply at once.
In implementation, 'alloc_contig_range()' may simply be used.  For each
given-granular contig pages that successfully allocated, DAMOS does
nothing but notifies those to the user.  Then the user can use the pages
for their purpose.  In other words, 'alloc' DAMOS action takes ownership
of DAMON-found region of specific access pattern in specific granularity
and passes it to the user.  For example, the guest of the motivation use
case can ask DAMOS to 'alloc' cold regions in 2 MiB granularity and
report those to the host as unnecessary, to scale the memory down.

'Free' DAMOS action returns the ownership of the DAMOS target memory
region to the system.  Same to 'alloc', the user can specify the
granularity of each operation.  Before returning the ownership, DAMOS
notifies the user which pages are gonna be returned to the system, so
that the user can safely forgive the ownership.  In the page fault based
memory overcommit use case, the user would need to do nothing for such
notification, though.

Access/Contiguity-aware Memory Auto-scaling (ACMA)
--------------------------------------------------

Using the two new DAMOS actions, we design a kernel module for replacing
the abovely mentioned approach.  The module is called
Access/Contiguity-aware Memory Auto-scaling (ACMA).  ACMA receives three
user inputs.  Those are the minimum amount of memory to let the system
use ('min-mem'), the maximum amount of memory to let the system use
('max-mem'), and the acceptable level of memory pressure
('mem-pressure').  'Mem-pressure' is represented by memory pressure
stall information (PSI).  Then, it scales the memory of the system while
meeting the condition utilizing three DAMON-based operation schemes,
namely 'reclaim', 'scale-down', and 'scale-up'.

'Reclaim' scheme reclaims memory of the system, coldest pages first,
aiming the 'mem-pressure' amount of memory pressure.  That is, if the
system's memory pressure level is lower than 'mem-pressure', it reclaims
some coldest pages of the system.  The amount of memory to reclaim is
proportional to distance between current pressure level and
'mem-pressure'.  If the memory pressure level becomes higher than
'mem-pressure', it reduces the amount again in a proportional way until
the memory pressure level becomes same to or lower than 'mem-pressure'.
This can be implemented as a DAMOS scheme of 'pageout' action with a
memory pressure type quota tuning goal of 'mem-pressure' value.

'Scale-down' scheme scales the memory down aiming the 'mem-pressure'
memory pressure.  It is implemented as a DAMOS scheme of 'alloc' action
with 2 MiB operation granularity.  Similar to 'reclaim' scheme, it has a
memory pressure type quota tuning goal of 'mem-pressure' target value.
For each allocated 2 MiB contig pages, it applies a vmemmap-remapping
based 'struct page' optimization and reports those to the host so that
the host can reuse.  The scheme has 'address range' type scheme filter.
The filter makes the scheme to be applied to only the memory block of
highest physical address that not completely allocated/reported, and in
the physical address range starting from 'min-mem' and enging at the end
of the physical address space of the system.  Once current 'scale-down'
target memory block is entirely allocated/reported, ACMA updates the
filter to apply the action to next lower-address memory block.

'Scale-up' scheme scales the memory up aiming the 'mem-pressure' memory
pressure.  It is implemented as a DAMOS scheme of 'free' action with 2
MiB operation granularity.  It also uses a memory pressure type quota
tuning goal with 'mem-pressure' target value, but it notifies DAMOS that
the aggressiveness of the scheme and the memory pressure are inversely
proportional.  Similar to 'scale-up' scheme, it uses an 'address range'
type scheme filter.  The filter makes the scheme to be applied to only
the partially or completely 'alloc'-ed and reported memory block of
lowest starting address in the physical address range starting from '0'
and ending at the 'max-mem' of the address space.  Inside the
to-free-pages notification callback, ACMA cancels the vmemmap-remapping
based 'struct page' optimization for the pages.  Once current 'scale-up'
target address range is entirely 'free'-ed, ACMA updates the filter to
apply the action to the just-hotplugged memory block.

Overall Picture of ACMA-running System
--------------------------------------

Below illustrates how the ACMA's three schemes will be applied to
different address ranges.  The effective memory size of the system
starts from 'end' bytes, and automatically be changed depends on the
real memory pressure of the system.  Once it becomes lower than 'max'
bytes, it will never get greater than 'max' bytes, since 'scale-up'
cannot make impact over the limit.  It can also never gets lower than
'min' bytes because 'scale-down' does not cross the line.  'reclaim'
scheme makes the system memory-frugal and helps 'scale-down' by making
free pages that can be migration destinations.  Because all the schemes
auto-tune their aggressiveness based on 'mem-pressure', the system's
memory pressure cannot exceed the user-acceptable level.

          Reclaim
             │
  ┌──────────┴────────────┐
  │                       │
  │          scale-down   │
                 │
         ┌───────┴────────┐
         │                │
  0      min-mem max-mem  end (memory address)
  │              │
  └──────┬───────┘
         │
     Scale-up

Ballooning-ACMA Integration
---------------------------

As mentioned on the limitations section above, the host may want to use
ballooning-like host-driven guest memory limit setup, while existing
implementation is not access/contiguity-aware.  We integrate ballooning
driver and ACMA for such a case.  We modify ballooning to set the
'max-mem' of ACMA instead of the classic page allocation-based
ballooning inflation.  Specifically, we expose a function for setting
the 'max-mem' of ACMA, and update virtio-balloon driver's
virtballoon_changed() to use the function to set effective hard memory
limit of the guest.  In this way, the host can simply use the classical
virtio-balloon interface while the ballooning driver is working in the
access/contiguity-aware efficient way.

Possible Future Usage of Access-aware Memory Allocation
=======================================================

As mentioned on the motivation section above, this work is motivated by
the memory over-commit VM systems.  However, we believe similar
approaches could be used for more use cases.  Introducing two such cases
below.

Contiguous Memory Allocation
----------------------------

For contiguous memory allocation, a large contiguous memory pool is
required.  Current approaches reserve such regions in early boot time
before the memory is fragmented, or define zones of specific types.  The
pool can exclusively used for only the contiguous memory allocation, or
allow non-contiguous memory allocation to use it under special condition
such as allowing only movable pages.  The second approach improves the
memory utilization, but sometimes suffers from pages that movable by
definition, but not easily movable in practice, similar to the memory
block-level page migration for memory hot unplugging that described on
the limitation section.  Even without the migration reliability and the
speed, finding the optimum size of the pool is challenging.

We could use ACMA-like approach for dynamically allocating a memory pool
for contiguous memory allocation.  It will be similar to ACMA but do not
report DAMOS-alloc-ed pages to the host.  Instead, use the regions as
contiguous memory allocation pool.

DRAM Consuming Power Saving
---------------------------

DRAM consumes and emits huge amount of power and carbon, respectively.
On bare-meta machines, we could scale down memory using ACMA, hot-unplug
completely DAMOS-alloc-ed memory blocks, and power off the DRAM device if
the hardware supports such operation.

Discussion Points
=================

- Is there existing better alternatives for memory over-commit VM
  systems?
- Is it ok to reuse pages reporting infrastructure from ACMA?
- Is it ok to reuse virtio-balloon's interface for ACMA-integration?
- Will access-aware migration make real benefit?
- Does future usages of access-aware memory allocation make sense?

SeongJae Park (6):
  mm/damon: implement DAMOS actions for access-aware contiguous memory
    allocation
  mm/damon: add the initial part of access/contiguity-aware memory
    auto-scaling module
  mm/page_reporting: implement a function for reporting specific pfn
    range
  mm/damon/acma: implement scale down feature
  mm/damon/acma: implement scale up feature
  drivers/virtio/virtio_balloon: integrate ACMA and ballooning

 drivers/virtio/virtio_balloon.c |  26 ++
 include/linux/damon.h           |  37 +++
 mm/damon/Kconfig                |  10 +
 mm/damon/Makefile               |   1 +
 mm/damon/acma.c                 | 546 ++++++++++++++++++++++++++++++++
 mm/damon/paddr.c                |  93 ++++++
 mm/damon/sysfs-schemes.c        |   4 +
 mm/page_reporting.c             |  27 ++
 8 files changed, 744 insertions(+)
 create mode 100644 mm/damon/acma.c


base-commit: 40475439de721986370c9d26f53596e2bd4e1416
-- 
2.39.2


