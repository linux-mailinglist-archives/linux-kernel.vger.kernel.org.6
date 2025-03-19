Return-Path: <linux-kernel+bounces-567971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9E9A68CAA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2520882FE8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227482561A6;
	Wed, 19 Mar 2025 12:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FzJMB/E4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wV+O180l"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F10254AFC
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 12:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742386908; cv=none; b=VhhcDDPw1taAgIHubfj465oAX6HKMKafBVlgpLexGINrEIiWWh+Sv0xwFbr0o4TjJnQcwp6znbfpaydt3FGEIqSWMDjNfkKZcnqFZARmt6o3FOcOsA1AQ3/G1Mvxvb/Nf5uZIu250R8lGghQR5IkBR8GxLeVFKPNg7svydZUV+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742386908; c=relaxed/simple;
	bh=YbR1C5tBXXJG9ui5vQjt8nY27qbKUkQsFobQWQkVTbI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f64KdtX30QOKAwALVuruLE76Juv8XqS3DL/GhjgWsqDVa+RMfrhzbPNk/QKcwFH9G3krZ/fQnGw7laQeJ3p35zLVR/UzciTpau3VMVQycX/3NjTfClolAZmXTC3wV60E4nmY696bhcCuGmEWHy3FxqUdHCSSus/pXNJ9ek76aQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FzJMB/E4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wV+O180l; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742386904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iV+SPD+4YzviqUg2F4/f+zg3hok9yAvsff0j0iVb+Bg=;
	b=FzJMB/E4Aa2DuxELvwyhpXI/V8dD8irKv0UOu5+BOui6xIw1/Ox1lPMhux5OZi/swDnSM2
	JByo/Km7/AeW1c+sBGjjP2iiuoYMPY8xX6R+hShFmgXBarTmHjp6u85z9JUPs4sK9LodI3
	DAItP4rMk9NCDAy1PZebNsrZ954U9pJgejG2LpE3tcUGhj0knYsyQnehN2P/2UQfidMqd0
	7MV+ZcbUAHztlyJcY673A5lxeCI5+OEF8ZcSzoPrPu0Q0hyiYVGdmOHhGEfnGol9+I67Va
	4ELdZjKHDP50vkwJkRm55HxX0EeQg86iD4WFp43ihmiPojMwMRy2O8Bv40AcQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742386904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iV+SPD+4YzviqUg2F4/f+zg3hok9yAvsff0j0iVb+Bg=;
	b=wV+O180lkPZSCKLXqE0i7fLZRV5aQ4K/2bZwm1LQ+oN7U50YTDrw7m/mgvYuDayy4YcQbh
	bLciOf7NwLtyk4Ag==
To: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v3 00/29] x86: Leaf 0x2 and leaf 0x4 refactorings
Date: Wed, 19 Mar 2025 13:21:08 +0100
Message-ID: <20250319122137.4004-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is a v3 of the CPUID leaf 0x2 and leaf 0x4 code paths cleanup, in
preparation for the x86-cpuid-db CPUID caching data model on top of this
series.

PQ is on top of tip/x86/cpu, as multiple patches from v1 and v2 got
merged there (thanks a lot!).

Changelog v3
============

v2 CPUID headers refactoring, 02b63b33dfc9 ("x86/cpuid: Refactor
<asm/cpuid.h>") got merged + more refactorings on top of it by Ingo.

Apply review remarks from Boris:

   - Drop v2 "x86: treewide: Introduce x86_vendor_amd_or_hygon()"

Apply review remarks from Ingo:

   - Divide the CPUID(2) changes further, quoting from review:

    "One does the functional change - this patch should be as small as
     possible.  This patch turns a piece of 'Intel documents' property
     into 'actual code' that differs from the previous code, which may or
     may not regress in practice.

     The other does the factoring out and the introduction of
     <asm/cpuid/leaf_0x2_api.h>."

    This is now done as:

    patch 01/29 ("x86/cacheinfo: Use leaf 0x2 parsing helpers")
    patch 02/29 ("x86/cpu: Introduce and use leaf 0x2 parsing helpers")
    patch 03/29 ("x86/cacheinfo: Remove leaf 0x2 parsing loop")
    patch 04/29 ("x86/cpu: Remove leaf 0x2 parsing loop")

Plus more testing and minor commit logs massaging overall.

Changelog v2
============

https://lkml.kernel.org/r/20250317164745.4754-1-darwi@linutronix.de

Twelve patches got merged from v1, and they're now at tip/x86/core

Apply Ingo Molnar's review remarks:

   - New <asm/cpuid/> header structure matching what is at <asm/fpu/>:

	<asm/cpuid/>
	  |
	  +-- api.h
	  +-- leaf_0x2_api.h
	  `-- types.h

   - Standardize words usage and header file references across commit
     logs and comments (CPUID, vendor names, <header.h>, etc.)

   - Use cpuid_ prefix for all new functions at <asm/cpuid/api.h> and
     <asm/cpuid/leaf_0x2_api.h>.

   - By the end of this series, leaf 0x2 call sites become:

	const struct leaf_0x2_table *entry;
	union leaf_0x2_regs regs;
	u8 *ptr;

	cpuid_get_leaf_0x2_regs(&regs);
	for_each_leaf_0x2_entry(regs, ptr, entry) {
		switch (entry->c_type) {
			...
		}
	}

Changelog v1
============

https://lkml.kernel.org/r/20250304085152.51092-1-darwi@linutronix.de

As part of the onging x86-cpuid work [*], we've found that the handling
of leaf 0x2 and leaf 0x4 code paths is difficult to work with in its
current state.  This was mostly due to the organic incremental growth of
the x86/cpu and x86/cacheinfo logic since the very early Linux days.

This series cleans up and refactors these code paths in preparation for
the new x86-cpuid model.

Summary:

- Patches 1 to 3 are independent bugfixes that were discovered during
  this refactoring work.

- Patches 4 to 10 are x86/cpu refactorings for code size and
  readability.

- Patch 10 adds standardized and kernel-doc documented logic for
  accessing leaf 0x2 one byte descriptors.

  This makes the leaf 0x2 sanitization logic centralized in one place.
  x86/cpu and x86/cacheinfo is modified to use such macros afterwards.

- Patches 11 to 28 refactors the x86/cacheinfo code.

  Beside readability, some of the unrelated logic (e.g. AMD northbridge
  cache_disable sysfs code) was first splitted from the generic leaf 0x4
  code paths, at the structure relationships level, then gutted-out into
  their own files.

- Patches 29 to 31 consolidate the existing (loop-based lookup) leaf 0x2
  cache and TLB descriptor tables into one hash-based lookup table.
  This reduces code size while still keeping rodata size in check.

  Standardized macros for accessing this consolidated table are also
  added.  Call sites can now just do:

	const struct leaf_0x2_table *entry;
	union leaf_0x2_regs regs;
	u8 *ptr;

	get_leaf_0x2_regs(&regs);
	for_each_leaf_0x2_entry(regs, ptr, entry) {
		switch (entry->c_type) {
			...
		}
	}

  without need to worry about sanitizing registers, skipping certain
  descriptors, etc.

- Patches 32 and 33 uses the consolidated table above for x86/cpu and
  x86/cacheinfo.

- Patches 34 to 40 provide the final set of x86/refactorings.

This series is based on -rc5.  It also applies cleanly on top of
tip/x86/core.

Note, testing was done by comparing below files:

	/proc/cpuinfo
	/sys/devices/system/cpu/
	/sys/kernel/debug/x86/topo/
	dmesg --notime | grep 'Last level [id]TLB entries'

before and after on various old and new x86 machine configurations.

[*] https://gitlab.com/x86-cpuid.org/x86-cpuid-db
    https://x86-cpuid.org

8<-----

Ahmed S. Darwish (25):
  x86/cpu: Remove leaf 0x2 parsing loop
  x86/cacheinfo: Remove leaf 0x2 parsing loop
  x86/cpu: Introduce and use leaf 0x2 parsing helpers
  x86/cacheinfo: Use leaf 0x2 parsing helpers
  x86/cacheinfo: Constify _cpuid4_info_regs instances
  x86/cacheinfo: Align ci_info_init() assignment expressions
  x86/cacheinfo: Standardize _cpuid4_info_regs instance naming
  x86/cacheinfo: Consolidate AMD/Hygon leaf 0x8000001d calls
  x86/cacheinfo: Separate amd_northbridge from _cpuid4_info_regs
  x86/cacheinfo: Move AMD cache_disable_0/1 handling to separate file
  x86/cacheinfo: Use sysfs_emit() for sysfs attributes show()
  x86/cacheinfo: Separate Intel and AMD leaf 0x4 code paths
  x86/cacheinfo: Rename _cpuid4_info_regs to _cpuid4_info
  x86/cacheinfo: Clarify type markers for leaf 0x2 cache descriptors
  x86/cacheinfo: Use enums for cache descriptor types
  x86/cpu: Use enums for TLB descriptor types
  x86/cacheinfo: Use consolidated leaf 0x2 descriptor table
  x86/cpu: Use consolidated leaf 0x2 descriptor table
  x86/cacheinfo: Separate leaf 0x2 handling and post-processing logic
  x86/cacheinfo: Separate Intel leaf 0x4 handling
  x86/cacheinfo: Extract out cache level topology ID calculation
  x86/cacheinfo: Extract out cache self-snoop checks
  x86/cacheinfo: Relocate leaf 0x4 cache_type mapping
  x86/cacheinfo: Introduce cpuid_amd_hygon_has_l3_cache()
  x86/cacheinfo: Apply maintainer-tip coding style fixes

Thomas Gleixner (4):
  x86/cacheinfo: Refactor leaf 0x2 cache descriptor lookup
  x86/cacheinfo: Properly name amd_cpuid4()'s first parameter
  x86/cacheinfo: Use proper name for cacheinfo instances
  x86/cpu: Consolidate CPUID leaf 0x2 tables

 arch/x86/include/asm/cpuid.h              |    1 +
 arch/x86/include/asm/cpuid/api.h          |    9 +
 arch/x86/include/asm/cpuid/leaf_0x2_api.h |   96 ++
 arch/x86/include/asm/cpuid/types.h        |   92 ++
 arch/x86/kernel/amd_nb.c                  |    7 +-
 arch/x86/kernel/cpu/Makefile              |    5 +-
 arch/x86/kernel/cpu/amd_cache_disable.c   |  301 ++++++
 arch/x86/kernel/cpu/cacheinfo.c           | 1042 +++++++--------------
 arch/x86/kernel/cpu/cpu.h                 |    9 +
 arch/x86/kernel/cpu/cpuid_0x2_table.c     |  128 +++
 arch/x86/kernel/cpu/intel.c               |  124 +--
 11 files changed, 980 insertions(+), 834 deletions(-)
 create mode 100644 arch/x86/include/asm/cpuid/leaf_0x2_api.h
 create mode 100644 arch/x86/kernel/cpu/amd_cache_disable.c
 create mode 100644 arch/x86/kernel/cpu/cpuid_0x2_table.c

base-commit: 08d9bb5b0d89826fedc5204c8bd2463220465996
--
2.48.1

