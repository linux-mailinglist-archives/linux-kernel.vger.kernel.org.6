Return-Path: <linux-kernel+bounces-518831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA40A39522
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33713188CCF2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C2022B8D2;
	Tue, 18 Feb 2025 08:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mr2umJ2f"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC76122DFBE;
	Tue, 18 Feb 2025 08:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866572; cv=none; b=fm5e9ZV5C5Y8BQ/6/iMuA4z/bPI18azc1OECpG9JTRe7BhP5A+MAMMtkBPTfRPNZOmxLqXnwe+WABzrw9+XFhIYaHl5ixSbib03iwv1+p+LZwNmmBHh46up+BMgSAPhBHXtjlTnWZIpFPWF/3Ok1v9SbQ9EYcYPvc4hfImZpW+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866572; c=relaxed/simple;
	bh=BbrpRC6/gkMymi8XRn17WTIfF6FZDiYUXMe1DwjmEDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=prBIIDiBjySn1PWFoZRepIkeDZmflKQ93WQmGGnEvCBUZv0WNMQKiudxNaN7GRJaPPWT/VQ7OWMKZvgGCyzYZR4wXNt/oGFMZcjatBe3BxTBgaxnh1GHODEFo4OksZOQFnruQyqSw6SXi1j+BEtOHlUm5ccSZBFVoMw/JXHtH5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mr2umJ2f; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739866571; x=1771402571;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BbrpRC6/gkMymi8XRn17WTIfF6FZDiYUXMe1DwjmEDc=;
  b=Mr2umJ2fRtTsOAe68152it9r2Y2ws+kDNnnmK0xQTpmwMNsVWaGdlzcU
   z6C5RWWxyK0NaFP1O6piVqyjwm9q5/mpq43B5dt050V727eAn7tuJfsyb
   jrw3TjiLxB9nho7i2FWBjVPtObWy1blqp384XolC6r6OLgj134p2dzlIq
   OBbLP8Bu0ivdMgx/MnnKqQvyZFR/5NjrIRsfRWGNKJjUlWo6+Z/odAf+F
   E1ccx2yYxlPQgReY+KWsyc5j063XsQPg52eLYK+NOoY41O6UM9HXVkaXu
   IGjFBUHQsse7p4EBRQEvc8txtOZZVIEbDhRxyP+92P3zVYyv3u36SasBx
   w==;
X-CSE-ConnectionGUID: WWwHkw/cQB2Zeo9jJinkTQ==
X-CSE-MsgGUID: cFusPCwbRzKBZy9mmVlP8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="28149879"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="28149879"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 00:16:10 -0800
X-CSE-ConnectionGUID: 4lVz8jdKThmi+vw7tnu8lA==
X-CSE-MsgGUID: xFRyo/FSQWKQw+ynAaEsIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="119247279"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.49])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 00:15:48 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: kees@kernel.org,
	julian.stecklina@cyberus-technology.de,
	kevinloughlin@google.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	justinstitt@google.com,
	catalin.marinas@arm.com,
	wangkefeng.wang@huawei.com,
	bhe@redhat.com,
	ryabinin.a.a@gmail.com,
	kirill.shutemov@linux.intel.com,
	will@kernel.org,
	ardb@kernel.org,
	jason.andryuk@amd.com,
	dave.hansen@linux.intel.com,
	pasha.tatashin@soleen.com,
	ndesaulniers@google.com,
	guoweikang.kernel@gmail.com,
	dwmw@amazon.co.uk,
	mark.rutland@arm.com,
	broonie@kernel.org,
	apopple@nvidia.com,
	bp@alien8.de,
	rppt@kernel.org,
	kaleshsingh@google.com,
	richard.weiyang@gmail.com,
	luto@kernel.org,
	glider@google.com,
	pankaj.gupta@amd.com,
	andreyknvl@gmail.com,
	pawan.kumar.gupta@linux.intel.com,
	kuan-ying.lee@canonical.com,
	tony.luck@intel.com,
	tj@kernel.org,
	jgross@suse.com,
	dvyukov@google.com,
	baohua@kernel.org,
	samuel.holland@sifive.com,
	dennis@kernel.org,
	akpm@linux-foundation.org,
	thomas.weissschuh@linutronix.de,
	surenb@google.com,
	kbingham@kernel.org,
	ankita@nvidia.com,
	nathan@kernel.org,
	maciej.wieczor-retman@intel.com,
	ziy@nvidia.com,
	xin@zytor.com,
	rafael.j.wysocki@intel.com,
	andriy.shevchenko@linux.intel.com,
	cl@linux.com,
	jhubbard@nvidia.com,
	hpa@zytor.com,
	scott@os.amperecomputing.com,
	david@redhat.com,
	jan.kiszka@siemens.com,
	vincenzo.frascino@arm.com,
	corbet@lwn.net,
	maz@kernel.org,
	mingo@redhat.com,
	arnd@arndb.de,
	ytcoode@gmail.com,
	xur@google.com,
	morbo@google.com,
	thiago.bauermann@linaro.org
Cc: linux-doc@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org
Subject: [PATCH v2 00/14] kasan: x86: arm64: KASAN tag-based mode for x86
Date: Tue, 18 Feb 2025 09:15:16 +0100
Message-ID: <cover.1739866028.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes v2:
- Split the series into one adding KASAN tag-based mode (this one) and
  another one that adds the dense mode to KASAN (will post later).
- Removed exporting kasan_poison() and used a wrapper instead in
  kasan_init_64.c
- Prepended series with 4 patches from the risc-v series and applied
  review comments to the first patch as the rest already are reviewed.

======= Introduction
The patchset aims to add a KASAN tag-based mode for the x86 architecture
with the help of the new CPU feature called Linear Address Masking
(LAM). Main improvement introduced by the series is 2x lower memory
usage compared to KASAN's generic mode, the only currently available
mode on x86.

There are two relevant series in the process of adding KASAN tag-based
support to x86. This one focuses on implementing and enabling the
tag-based mode for the x86 architecture by using LAM. The second one
attempts to add a new memory saving mechanism called "dense mode" to the
non-arch part of the tag-based KASAN code. It can provide another 2x
memory savings by packing tags denser in the shadow memory.

======= How KASAN tag-based mode works?
When enabled, memory accesses and allocations are augmented by the
compiler during kernel compilation. Instrumentation functions are added
to each memory allocation and each pointer dereference.

The allocation related functions generate a random tag and save it in
two places: in shadow memory that maps to the allocated memory, and in
the top bits of the pointer that points to the allocated memory. Storing
the tag in the top of the pointer is possible because of Top-Byte Ignore
(TBI) on arm64 architecture and LAM on x86.

The access related functions are performing a comparison between the tag
stored in the pointer and the one stored in shadow memory. If the tags
don't match an out of bounds error must have occurred and so an error
report is generated.

The general idea for the tag-based mode is very well explained in the
series with the original implementation [1].

[1] https://lore.kernel.org/all/cover.1544099024.git.andreyknvl@google.com/

======= Differences summary compared to the arm64 tag-based mode
- Tag width:
	- Tag width influences the chance of a tag mismatch due to two
	  tags from different allocations having the same value. The
	  bigger the possible range of tag values the lower the chance
	  of that happening.
	- Shortening the tag width from 8 bits to 4, while it can help
	  with memory usage, it also increases the chance of not
	  reporting an error. 4 bit tags have a ~7% chance of a tag
	  mismatch.

- TBI and LAM
	- TBI in arm64 allows for storing metadata in the top 8 bits of
	  the virtual address.
	- LAM in x86 allows storing tags in bits [62:57] of the pointer.
	  To maximize memory savings the tag width is reduced to bits
	  [60:57].

- KASAN offset calculations
	- When converting addresses from memory to shadow memory the
	  address is treated as a signed number.
	- On arm64 due to TBI half of tagged addresses will be positive
	  and half negative. KASAN shadow offset means the middle point
	  of the shadow memory there.
	- On x86 - due to the top bit of the pointer always being set in
	  kernel address space - all the addresses will be negative when
	  treated as signed offsets into shadow memory. KASAN shadow
	  offset means the end of the shadow memory there.

======= Testing
Checked all the kunits for both software tags and generic KASAN after
making changes.

In generic mode the results were:

kasan: pass:59 fail:0 skip:13 total:72
Totals: pass:59 fail:0 skip:13 total:72
ok 1 kasan

and for software tags:

kasan: pass:63 fail:0 skip:9 total:72
Totals: pass:63 fail:0 skip:9 total:72
ok 1 kasan

======= Benchmarks
All tests were ran on a Sierra Forest server platform with 512GB of
memory. The only differences between the tests were kernel options:
	- CONFIG_KASAN
	- CONFIG_KASAN_GENERIC
	- CONFIG_KASAN_SW_TAGS
	- CONFIG_KASAN_INLINE [1]
	- CONFIG_KASAN_OUTLINE [1]

More benchmarks are noted in the second series that adds the dense mode
to KASAN. That's because most values on x86' tag-based mode are tailored
to work well with that.

Boot time (until login prompt):
* 03:48 for clean kernel
* 08:02 / 09:45 for generic KASAN (inline/outline)
* 08:50 for tag-based KASAN
* 04:50 for tag-based KASAN with stacktrace disabled [2]

Compilation time comparison (10 cores):
* 7:27 for clean kernel
* 8:21/7:44 for generic KASAN (inline/outline)
* 7:41 for tag-based KASAN

[1] Based on hwasan and asan compiler parameters used in
scripts/Makefile.kasan it looks like inline/outline modes have a bigger
impact on generic mode than the tag-based mode. In the former inlining
actually increases the kernel image size and improves performance. In
the latter it un-inlines some code portions for debugging purposes when
the outline mode is chosen but no real difference is visible in
performance and kernel image size.

[2] Memory allocation and freeing performance suffers heavily from saving
stacktraces that can be later displayed in error reports.

======= Compilation
Clang was used to compile the series (make LLVM=1) since gcc doesn't
seem to have support for KASAN tag-based compiler instrumentation on
x86.

======= Dependencies
Series bases on four patches taken from [1] series. Mainly the idea of
converting memory addresses to shadow memory addresses by treating them
as signed as opposed to unsigned. I tried applying review comments to
the first patch, while the other three are unchanged.

The base branch for the series is the tip x86/mm branch.

[1] https://lore.kernel.org/all/20241022015913.3524425-1-samuel.holland@sifive.com/

======= Enabling LAM for testing the series without LASS
Since LASS is needed for LAM and it can't be compiled without it I
enabled LAM during testing with the patch below:

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2275,7 +2275,7 @@ config RANDOMIZE_MEMORY_PHYSICAL_PADDING
 config ADDRESS_MASKING
 	bool "Linear Address Masking support"
 	depends on X86_64
-	depends on COMPILE_TEST || !CPU_MITIGATIONS # wait for LASS
+	#depends on COMPILE_TEST || !CPU_MITIGATIONS # wait for LASS
 	help
 	  Linear Address Masking (LAM) modifies the checking that is applied
 	  to 64-bit linear addresses, allowing software to use of the

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2401,9 +2401,10 @@ void __init arch_cpu_finalize_init(void)

 		/*
 		 * Enable this when LAM is gated on LASS support
+		 */
 		if (cpu_feature_enabled(X86_FEATURE_LAM))
 			USER_PTR_MAX = (1ul << 63) - PAGE_SIZE;
-		 */
+
 		runtime_const_init(ptr, USER_PTR_MAX);

 		/*

Maciej Wieczor-Retman (10):
  kasan: arm64: x86: Make special tags arch specific
  x86: Add arch specific kasan functions
  x86: Reset tag for virtual to physical address conversions
  x86: Physical address comparisons in fill_p*d/pte
  mm: Pcpu chunk address tag reset
  x86: KASAN raw shadow memory PTE init
  x86: LAM initialization
  x86: Minimal SLAB alignment
  x86: runtime_const used for KASAN_SHADOW_END
  x86: Make software tag-based kasan available

Samuel Holland (4):
  kasan: sw_tags: Use arithmetic shift for shadow computation
  kasan: sw_tags: Check kasan_flag_enabled at runtime
  kasan: sw_tags: Support outline stack tag generation
  kasan: sw_tags: Support tag widths less than 8 bits

 Documentation/arch/x86/x86_64/mm.rst |  6 ++--
 MAINTAINERS                          |  2 +-
 arch/arm64/Kconfig                   | 10 +++---
 arch/arm64/include/asm/kasan-tags.h  |  9 +++++
 arch/arm64/include/asm/kasan.h       |  6 ++--
 arch/arm64/include/asm/memory.h      | 14 +++++++-
 arch/arm64/include/asm/uaccess.h     |  1 +
 arch/arm64/mm/kasan_init.c           |  7 ++--
 arch/x86/Kconfig                     |  9 +++--
 arch/x86/boot/compressed/misc.h      |  1 +
 arch/x86/include/asm/kasan-tags.h    |  9 +++++
 arch/x86/include/asm/kasan.h         | 50 +++++++++++++++++++++++++---
 arch/x86/include/asm/page.h          | 17 +++++++---
 arch/x86/include/asm/page_64.h       |  2 +-
 arch/x86/kernel/head_64.S            |  3 ++
 arch/x86/kernel/setup.c              |  2 ++
 arch/x86/kernel/vmlinux.lds.S        |  1 +
 arch/x86/mm/init.c                   |  3 ++
 arch/x86/mm/init_64.c                | 11 +++---
 arch/x86/mm/kasan_init_64.c          | 24 ++++++++++---
 arch/x86/mm/physaddr.c               |  1 +
 include/linux/kasan-enabled.h        | 15 +++------
 include/linux/kasan-tags.h           | 19 ++++++++---
 include/linux/kasan.h                | 14 ++++++--
 include/linux/mm.h                   |  6 ++--
 include/linux/page-flags-layout.h    |  7 +---
 mm/kasan/hw_tags.c                   | 10 ------
 mm/kasan/kasan.h                     |  2 ++
 mm/kasan/report.c                    | 26 ++++++++++++---
 mm/kasan/sw_tags.c                   |  9 +++++
 mm/kasan/tags.c                      | 10 ++++++
 mm/percpu-vm.c                       |  2 +-
 scripts/gdb/linux/mm.py              |  5 +--
 33 files changed, 237 insertions(+), 76 deletions(-)
 create mode 100644 arch/arm64/include/asm/kasan-tags.h
 create mode 100644 arch/x86/include/asm/kasan-tags.h

-- 
2.47.1


