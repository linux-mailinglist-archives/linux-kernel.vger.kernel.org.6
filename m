Return-Path: <linux-kernel+bounces-320839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CB9971135
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9AE41F2578E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B931B2EC0;
	Mon,  9 Sep 2024 08:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VJHW4br2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7ED1B29D5
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 08:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725869223; cv=none; b=UtTNLyMK8kWuE0kHa7+ui3BytWdsg/yioxPb1uBke5Sqh3ak8p3dNjBqfSWGZjV+0aqvNVUYE+rFjNVq7Ro+TgEifcyhBDb/EVRAwQCycobm4uN94SSoUcus7H8J8nf+fPu9LWVJoj4EiJlECE+65c2x3GdsVppNVnKZmKDHgGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725869223; c=relaxed/simple;
	bh=PcFU0Gx6JqMMeGol8qszwfn6/x2c4Z86AVwAu7S4Cmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vp+Gum7CW3n2atWnLZCS6Z2rv4Pr2y2tWXwLOSiWMW+zI+EtiOeamzdxT80uAdQ88uki3ZxNBLzXIe+2y8fhFNuHYUWxvFw9aoEEz6nfXwGQYrOQYsGK88wtE03Gx5nWa+bBkhiCC5qe5erXTU0sy/br3N3akwRQzba7FCHTAbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VJHW4br2; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725869222; x=1757405222;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PcFU0Gx6JqMMeGol8qszwfn6/x2c4Z86AVwAu7S4Cmo=;
  b=VJHW4br2Kdl0upgjDfpOMbzLB/bro6FfdCM1n+Zg6g5TkPrvI4pCYr87
   ezNiwIHQhxT1e8zGUFragqRzuUm1JPtig/DZP9swY1sxKVEnDJZZ/FVB/
   2vD2XqWiC/aMMY6bGsJXVVN2oqZuUt2CcoTL6PLyKMqynO0bZcm0NcYPY
   KvrlVu8bG5+u3/Kz17SiSWR//W+SklcBV/nMNIsct1kItneOOU7f96SND
   k/jajv4YFvHOtxhmdzCOLv3NLXgIdDZ72HrJ9JwEhCxAsdIc66TZV1yO2
   9Vy2bJu8CZoztsT7/AAcdhqNoKycvCEwa4cZikKRvXXGm6fP2RwV3r6Nw
   g==;
X-CSE-ConnectionGUID: 7MgjGU58TWCjmCXZjD7ceg==
X-CSE-MsgGUID: za4ILQLGSd2IRSXk4tfHig==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="24410606"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="24410606"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 01:07:02 -0700
X-CSE-ConnectionGUID: 0qwEEJarQ6eJKotfLCWCnQ==
X-CSE-MsgGUID: V/CuGS4WQKqPOQCWrgPcgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="67327062"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.124.222.253])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 01:06:59 -0700
From: Kai Huang <kai.huang@intel.com>
To: dave.hansen@intel.com,
	bp@alien8.de,
	tglx@linutronix.de,
	peterz@infradead.org,
	mingo@redhat.com,
	hpa@zytor.com,
	kirill.shutemov@linux.intel.com
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	pbonzini@redhat.com,
	seanjc@google.com,
	dan.j.williams@intel.com,
	thomas.lendacky@amd.com,
	rick.p.edgecombe@intel.com,
	isaku.yamahata@intel.com,
	ashish.kalra@amd.com,
	bhe@redhat.com,
	nik.borisov@suse.com,
	sagis@google.com
Subject: [PATCH v6 4/5] x86/kexec: Reset TDX private memory on platforms with TDX erratum
Date: Mon,  9 Sep 2024 20:06:26 +1200
Message-ID: <1a1845ad625963f346a47e470a9621574fd5ca96.1725868065.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1725868065.git.kai.huang@intel.com>
References: <cover.1725868065.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL;DR:

On the platforms with TDX "partial write machine check" erratum, during
kexec, convert TDX private memory back to normal before jumping to the
second kernel to avoid the second kernel potentially seeing unexpected
machine check.

Long version:

The first few generations of TDX hardware have an erratum.  A partial
write to a TDX private memory cacheline will silently "poison" the
line.  Subsequent reads will consume the poison and generate a machine
check.  According to the TDX hardware spec, neither of these things
should have happened.

== Background ==

Virtually all kernel memory accesses operations happen in full
cachelines.  In practice, writing a "byte" of memory usually reads a 64
byte cacheline of memory, modifies it, then writes the whole line back.
Those operations do not trigger this problem.

This problem is triggered by "partial" writes where a write transaction
of less than cacheline lands at the memory controller.  The CPU does
these via non-temporal write instructions (like MOVNTI), or through
UC/WC memory mappings.  The issue can also be triggered away from the
CPU by devices doing partial writes via DMA.

== Problem ==

A fast warm reset doesn't reset TDX private memory.  Kexec() can also
boot into the new kernel directly.  Thus if the old kernel has left any
TDX private pages on the platform with this erratum, the new kernel
might get unexpected machine check.

Note that w/o this erratum any kernel read/write on TDX private memory
should never cause machine check, thus it's OK for the old kernel to
leave TDX private pages as is.

Also note only the normal kexec needs to worry about this problem, but
not the crash kexec: 1) The kdump kernel only uses the special memory
reserved by the first kernel, and the reserved memory can never be used
by TDX in the first kernel; 2) The /proc/vmcore, which reflects the
first (crashed) kernel's memory, is only for read.  The read will never
"poison" TDX memory thus cause unexpected machine check (only partial
write does).

== Solution ==

In short, with this erratum, the kernel needs to explicitly convert all
TDX private pages back to normal (using MOVDIR64B to reset these pages)
to give the new kernel a clean slate after kexec().

The BIOS is also expected to disable fast warm reset as a workaround to
this erratum, thus this implementation doesn't try to reset TDX private
memory for the normal reboot case in the kernel but depends on the BIOS
to enable the workaround.

Reset TDX private pages in machine_kexec() so that: 1) all remote cpus
are stopped with cache flushed and there's no more TDX activity; 2) no
memory reset overhead for the normal reboot case since the BIOS is
expected to turn on the workaround.

There are different types of TDX private pages.  The TDX module itself
uses PAMT (Physical Address Metadata Table) to track each TDX memory
page's state.  TDX guests also have guest private memory and secure-EPT
pages.

It would be ideal to reset all types of TDX private memory once for all
in machine_kexec(), but there are practical problems to do so:

1) There's no existing infrastructure to track TDX private pages;
2) It's not feasible to query the TDX module about page type, because
   VMX, which making SEAMCALL requires, has already been disabled;
3) Even if it is feasible to query the TDX module, the result may not be
   accurate.  E.g., the remote CPU could be stopped right before the
   MOVDIR64B.

One temporary solution is to blindly convert all memory pages, but it's
problematic to do so too, because not all pages are mapped as writable
in the direct mapping.  It can be done by switching to the identical
mapping created for kexec(), or a new page table, but the complication
is overkill.

Therefore, rather than doing something dramatic, only reset PAMT pages
in machine_kexec().  All the in-kernel TDX users (e.g., KVM) need to
reset TDX private pages that they manage before the machine_kexec() by
registering either the reboot notifier or the syscore shutdown ops.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---

v5 -> v6:
 - No change

v4 -> v5:
 - Remove the TDX-specific notifier, since there's no need to handle
   crash kexec specially.
 - Minor update to changelog and comments.

v3 -> v4:
 - No change

v2 -> v3:
 - No change

v1 -> v2:
 - Remove using reboot notifier to stop TDX module as it doesn't
   cover crash kexec.  Change to use a variable with barrier instead.
   (Rick)
 - Introduce kexec_save_processor_start() to make code better, and
   make the comment around calling site of tdx_reset_memory() more
   concise. (Dave)
 - Mention cache for all other cpus have been flushed around
   native_wbinvd() in tdx_reset_memory(). (Dave)
 - Remove the extended alternaties discussion from the comment, but leave
   it in the changelog. Point out what does current code do and point out
   risk. (Dave)


---
 arch/x86/include/asm/tdx.h         |  2 ++
 arch/x86/kernel/machine_kexec_64.c | 27 +++++++++++++---
 arch/x86/virt/vmx/tdx/tdx.c        | 49 ++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index eba178996d84..ed3ac9a8a079 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -116,11 +116,13 @@ static inline u64 sc_retry(sc_func_t func, u64 fn,
 int tdx_cpu_enable(void);
 int tdx_enable(void);
 const char *tdx_dump_mce_info(struct mce *m);
+void tdx_reset_memory(void);
 #else
 static inline void tdx_init(void) { }
 static inline int tdx_cpu_enable(void) { return -ENODEV; }
 static inline int tdx_enable(void)  { return -ENODEV; }
 static inline const char *tdx_dump_mce_info(struct mce *m) { return NULL; }
+static inline void tdx_reset_memory(void) { }
 #endif	/* CONFIG_INTEL_TDX_HOST */
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 225242840467..4195b9ee007b 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -29,6 +29,7 @@
 #include <asm/set_memory.h>
 #include <asm/cpu.h>
 #include <asm/efi.h>
+#include <asm/tdx.h>
 
 #ifdef CONFIG_ACPI
 /*
@@ -315,6 +316,14 @@ void machine_kexec_cleanup(struct kimage *image)
 	free_transition_pgtable(image);
 }
 
+static void kexec_save_processor_start(struct kimage *image)
+{
+#ifdef CONFIG_KEXEC_JUMP
+	if (image->preserve_context)
+		save_processor_state();
+#endif
+}
+
 /*
  * Do not allocate memory (or fail in any way) in machine_kexec().
  * We are past the point of no return, committed to rebooting now.
@@ -325,10 +334,20 @@ void machine_kexec(struct kimage *image)
 	int save_ftrace_enabled;
 	void *control_page;
 
-#ifdef CONFIG_KEXEC_JUMP
-	if (image->preserve_context)
-		save_processor_state();
-#endif
+	kexec_save_processor_start(image);
+
+	/*
+	 * Convert TDX private memory back to normal (when needed) to
+	 * avoid the second kernel potentially seeing unexpected machine
+	 * check.
+	 *
+	 * However skip this when preserve_context is on.  By reaching
+	 * here, TDX (if ever got enabled by the kernel) has survived
+	 * from the suspend when preserve_context is on, and it can
+	 * continue to work after jumping back from the second kernel.
+	 */
+	if (!image->preserve_context)
+		tdx_reset_memory();
 
 	save_ftrace_enabled = __ftrace_enabled_save();
 
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index c33417fe4086..a69a65f57616 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1518,3 +1518,52 @@ void __init tdx_init(void)
 
 	check_tdx_erratum();
 }
+
+void tdx_reset_memory(void)
+{
+	if (!boot_cpu_has(X86_FEATURE_TDX_HOST_PLATFORM))
+		return;
+
+	/*
+	 * Kernel read/write to TDX private memory doesn't cause
+	 * machine check on hardware w/o this erratum.
+	 */
+	if (!boot_cpu_has_bug(X86_BUG_TDX_PW_MCE))
+		return;
+
+	/*
+	 * Converting TDX private pages back to normal must be done
+	 * after all remote cpus have been stopped so that no more
+	 * TDX activity can happen and caches have been flushed.
+	 */
+	WARN_ON_ONCE(num_online_cpus() != 1);
+
+	/*
+	 * The system can only have TDX private memory after the TDX
+	 * module has been initialized.  tdx_reboot_notifier() has made
+	 * sure @tdx_module_status reflects the module initialization
+	 * status correctly and is immutable by now thus can be read
+	 * w/o holding lock.
+	 */
+	if (tdx_module_status != TDX_MODULE_INITIALIZED)
+		return;
+
+	/*
+	 * All remote cpus have been stopped, and their caches have
+	 * been flushed in stop_this_cpu().  Now flush cache for the
+	 * last running cpu _before_ converting TDX private pages.
+	 */
+	native_wbinvd();
+
+	/*
+	 * It's ideal to cover all types of TDX private pages here, but
+	 * currently there's no unified way to tell whether a given page
+	 * is TDX private page or not.
+	 *
+	 * Only convert PAMT here.  All in-kernel TDX users (e.g., KVM)
+	 * are responsible for converting TDX private pages that are
+	 * managed by them by either registering reboot notifier or
+	 * shutdown syscore ops.
+	 */
+	tdmrs_reset_pamt_all(&tdx_tdmr_list);
+}
-- 
2.46.0


