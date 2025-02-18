Return-Path: <linux-kernel+bounces-518848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6085A39553
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA80F3A8FD2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54D923A561;
	Tue, 18 Feb 2025 08:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KM5EmLHG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33200239570;
	Tue, 18 Feb 2025 08:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866827; cv=none; b=dDR8lAxgh5gJy8qpQAnxRr+mr7auybnTCWmly9goHmPvypirdpDGkpeHeN7JlfmRAYMenX/mKf4Y864RIGHAkRZTbyDerQmCIrtKd83NWzi9S+48mFpWj+Sy5B54tI4ue9LcUy+ZcaFkgGJHpB272vjkNlwY9ykP5d53ztd/HPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866827; c=relaxed/simple;
	bh=tLFNi6QiCcH4XS9SXJrys5meLjBaYY7ZaQ2eE4lAVKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LIzGojlIh3cUCbgwcd6dw+TGydT56bYceVxsvD7SxRLT3Dme30H4DhFT3Tv+5nxqc29mSQrEDZnL3w1Jgvvlm3VG0Ds1qdwkjyL1Y2nVwE5qa10GRagc9UYcikPer2VVJ7y06ZGHjlT0zGebFS5ldLJtinNpX1UHLgx4E5s5QqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KM5EmLHG; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739866826; x=1771402826;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tLFNi6QiCcH4XS9SXJrys5meLjBaYY7ZaQ2eE4lAVKI=;
  b=KM5EmLHGK5CBB6ScVmq+T26fn6rPezRWRAA/3x8CkK2J+zntSFylkuoC
   cj/4t1fgZY2BbHGIxgXAszJ8cZEul8R4KTjYblXSs4NciUVg21fIg6Out
   4vEwnrGL3pigJQsQbYnPC+LYo5tNsddHveo99hS61aOvmRI0vv7dZz9Fr
   Tmut3ifiMCMsWp8k2oXPpzaxh9PnqET6ox5PQr2Kz8cDjFvqSsHaKqowr
   ylmNWf4nBD3UK2quSki/Nvgz02W8tAksNioqCGxEd5gq7B+sknpQ94Bv/
   Rh7zqyZ72OA46x14kOES0O+V6rcGooQ8/oB9sIZL0LiNLJl/7+6hzArJi
   A==;
X-CSE-ConnectionGUID: PnQHCi8PSHCCnOsKfikMKA==
X-CSE-MsgGUID: 4AAnf1/iTUuTU49vhsL+8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="28150554"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="28150554"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 00:20:25 -0800
X-CSE-ConnectionGUID: ZBHrRLDGSHmtBzW5XHTLlA==
X-CSE-MsgGUID: DOPqudHOR6e9SmDmLLK9pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="119248027"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.49])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 00:20:07 -0800
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
Subject: [PATCH v2 13/14] x86: runtime_const used for KASAN_SHADOW_END
Date: Tue, 18 Feb 2025 09:15:29 +0100
Message-ID: <2a2f08bc8118b369610d34e4d190a879d44f76b8.1739866028.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1739866028.git.maciej.wieczor-retman@intel.com>
References: <cover.1739866028.git.maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On x86, generic KASAN is setup in a way that needs a single
KASAN_SHADOW_OFFSET value for both 4 and 5 level paging. It's required
to facilitate boot time switching and it's a compiler ABI so it can't be
changed during runtime.

Software tag-based mode doesn't tie shadow start and end to any linear
addresses as part of the compiler ABI so it can be changed during
runtime. This notion, for KASAN purposes, allows to optimize out macros
such us pgtable_l5_enabled() which would otherwise be used in every
single KASAN related function.

Use runtime_const infrastructure with pgtable_l5_enabled() to initialize
the end address of KASAN's shadow address space. It's a good choice
since in software tag based mode KASAN_SHADOW_OFFSET and
KASAN_SHADOW_END refer to the same value and the offset in
kasan_mem_to_shadow() is a signed negative value.

Setup KASAN_SHADOW_END values so that they're aligned to 4TB in 4-level
paging mode and to 2PB in 5-level paging mode. Also update x86 memory
map documentation.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
Changelog v2:
- Change documentation kasan start address to non-dense values.

 Documentation/arch/x86/x86_64/mm.rst |  6 ++++--
 arch/x86/Kconfig                     |  3 +--
 arch/x86/include/asm/kasan.h         | 14 +++++++++++++-
 arch/x86/kernel/vmlinux.lds.S        |  1 +
 arch/x86/mm/kasan_init_64.c          |  5 ++++-
 5 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/Documentation/arch/x86/x86_64/mm.rst b/Documentation/arch/x86/x86_64/mm.rst
index f2db178b353f..5014ec322e19 100644
--- a/Documentation/arch/x86/x86_64/mm.rst
+++ b/Documentation/arch/x86/x86_64/mm.rst
@@ -60,7 +60,8 @@ Complete virtual memory map with 4-level page tables
    ffffe90000000000 |  -23    TB | ffffe9ffffffffff |    1 TB | ... unused hole
    ffffea0000000000 |  -22    TB | ffffeaffffffffff |    1 TB | virtual memory map (vmemmap_base)
    ffffeb0000000000 |  -21    TB | ffffebffffffffff |    1 TB | ... unused hole
-   ffffec0000000000 |  -20    TB | fffffbffffffffff |   16 TB | KASAN shadow memory
+   ffffec0000000000 |  -20    TB | fffffbffffffffff |   16 TB | KASAN shadow memory (generic mode)
+   fffff40000000000 |   -8    TB | fffffc0000000000 |    8 TB | KASAN shadow memory (software tag-based mode)
   __________________|____________|__________________|_________|____________________________________________________________
                                                               |
                                                               | Identical layout to the 56-bit one from here on:
@@ -130,7 +131,8 @@ Complete virtual memory map with 5-level page tables
    ffd2000000000000 |  -11.5  PB | ffd3ffffffffffff |  0.5 PB | ... unused hole
    ffd4000000000000 |  -11    PB | ffd5ffffffffffff |  0.5 PB | virtual memory map (vmemmap_base)
    ffd6000000000000 |  -10.5  PB | ffdeffffffffffff | 2.25 PB | ... unused hole
-   ffdf000000000000 |   -8.25 PB | fffffbffffffffff |   ~8 PB | KASAN shadow memory
+   ffdf000000000000 |   -8.25 PB | fffffbffffffffff |   ~8 PB | KASAN shadow memory (generic mode)
+   ffe0000000000000 |   -6    PB | fff0000000000000 |    4 PB | KASAN shadow memory (software tag-based mode)
   __________________|____________|__________________|_________|____________________________________________________________
                                                               |
                                                               | Identical layout to the 47-bit one from here on:
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6df7779ed6da..f4ef64bf824a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -400,8 +400,7 @@ config AUDIT_ARCH
 
 config KASAN_SHADOW_OFFSET
 	hex
-	depends on KASAN
-	default 0xdffffc0000000000
+	default 0xdffffc0000000000 if KASAN_GENERIC
 
 config HAVE_INTEL_TXT
 	def_bool y
diff --git a/arch/x86/include/asm/kasan.h b/arch/x86/include/asm/kasan.h
index a75f0748a4b6..4bfd3641af84 100644
--- a/arch/x86/include/asm/kasan.h
+++ b/arch/x86/include/asm/kasan.h
@@ -5,7 +5,7 @@
 #include <linux/const.h>
 #include <linux/kasan-tags.h>
 #include <linux/types.h>
-#define KASAN_SHADOW_OFFSET _AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
+
 #define KASAN_SHADOW_SCALE_SHIFT 3
 
 /*
@@ -14,6 +14,8 @@
  * for kernel really starts from compiler's shadow offset +
  * 'kernel address space start' >> KASAN_SHADOW_SCALE_SHIFT
  */
+#ifdef CONFIG_KASAN_GENERIC
+#define KASAN_SHADOW_OFFSET _AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
 #define KASAN_SHADOW_START      (KASAN_SHADOW_OFFSET + \
 					((-1UL << __VIRTUAL_MASK_SHIFT) >> \
 						KASAN_SHADOW_SCALE_SHIFT))
@@ -24,12 +26,22 @@
 #define KASAN_SHADOW_END        (KASAN_SHADOW_START + \
 					(1ULL << (__VIRTUAL_MASK_SHIFT - \
 						  KASAN_SHADOW_SCALE_SHIFT)))
+#endif
+
 
 #ifndef __ASSEMBLY__
+#include <asm/runtime-const.h>
 #include <linux/bitops.h>
 #include <linux/bitfield.h>
 #include <linux/bits.h>
 
+#ifdef CONFIG_KASAN_SW_TAGS
+extern unsigned long KASAN_SHADOW_END_RC;
+#define KASAN_SHADOW_END	runtime_const_ptr(KASAN_SHADOW_END_RC)
+#define KASAN_SHADOW_OFFSET	KASAN_SHADOW_END
+#define KASAN_SHADOW_START	(KASAN_SHADOW_END - ((UL(1)) << (__VIRTUAL_MASK_SHIFT - KASAN_SHADOW_SCALE_SHIFT)))
+#endif
+
 #define arch_kasan_set_tag(addr, tag)	__tag_set(addr, tag)
 #define arch_kasan_reset_tag(addr)	__tag_reset(addr)
 #define arch_kasan_get_tag(addr)	__tag_get(addr)
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 0deb4887d6e9..df6c85f8f48f 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -353,6 +353,7 @@ SECTIONS
 
 	RUNTIME_CONST_VARIABLES
 	RUNTIME_CONST(ptr, USER_PTR_MAX)
+	RUNTIME_CONST(ptr, KASAN_SHADOW_END_RC)
 
 	. = ALIGN(PAGE_SIZE);
 
diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index 299a2144dac4..5ca5862a5cd6 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -358,6 +358,9 @@ void __init kasan_init(void)
 	int i;
 
 	memcpy(early_top_pgt, init_top_pgt, sizeof(early_top_pgt));
+	unsigned long KASAN_SHADOW_END_RC = pgtable_l5_enabled() ? 0xfff0000000000000 : 0xfffffc0000000000;
+
+	runtime_const_init(ptr, KASAN_SHADOW_END_RC);
 
 	/*
 	 * We use the same shadow offset for 4- and 5-level paging to
@@ -372,7 +375,7 @@ void __init kasan_init(void)
 	 * bunch of things like kernel code, modules, EFI mapping, etc.
 	 * We need to take extra steps to not overwrite them.
 	 */
-	if (pgtable_l5_enabled()) {
+	if (pgtable_l5_enabled() && !IS_ENABLED(CONFIG_KASAN_SW_TAGS)) {
 		void *ptr;
 
 		ptr = (void *)pgd_page_vaddr(*pgd_offset_k(KASAN_SHADOW_END));
-- 
2.47.1


