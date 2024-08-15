Return-Path: <linux-kernel+bounces-287927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C36D8952E49
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E925F1C203E6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8B119F49C;
	Thu, 15 Aug 2024 12:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BtVWOQKt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ED819DFB5
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 12:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723724991; cv=none; b=Qd6D/qebTjA/gXUeBFfoI78rd4QZYeylnIEMzn+lGeDa8+yg1O0du/HkC+f5rnD/rw4yk2SlkYJm65YyEgKAB9BsySJrYEKAFbYWpNxutUU1GbDfR1ORp6y5dtz7qDCuP3KWhW8WRmvra5J6t+8y4atFZtw7CnDP7RxlROLszBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723724991; c=relaxed/simple;
	bh=jESb8fEiC8HdcP1MUMmbvOvsVZtvh3UpBRKynAFvmTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGYnDhxAPBkB6zDpLGiepKOoxLuJrE3k6RQW8EnmFqmsBnwrCZI8HKc0vzz2kVl6fHspWerd2HX7T+iF/cTNoxp+eQmPov8Vgmc3C1Wb8F1vokcg9ZnwSJAJaGHi1iPyjONqVpblRN6e3uFMekzDMuJAfRM97Ys2pXLYB4D1yxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BtVWOQKt; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723724989; x=1755260989;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jESb8fEiC8HdcP1MUMmbvOvsVZtvh3UpBRKynAFvmTk=;
  b=BtVWOQKtKGIOKCThi89qm3w8DyVpzekvhx2969B5C1bRa/jLSw9I0Mwn
   EDTHZhP0Y0QjlNWbqi6kO0fjUyZ9ncg5HLadH2vzPFkaSqweTKFCFudSL
   zf38YcCONohbYax3NEYyQHv62KeVkdFzLw9bR9dSwmMUdjG8liJtIb3FR
   8S5QBW+SRMxa/vGPdqTdD7d2C5WeG45pEfnho/Yk2xQO9JTze8+7Oex4q
   kLiaMBKS+QdzYtXrJI8vRnmxfBrUCzZH1bkP2S3N/yDCmhjH9uY9BKt29
   mquWGC+YIvj1a+X7Q5gpOY1iutCvMuc7r1SAQSPNLIh8FlG/MeCfeaNMu
   A==;
X-CSE-ConnectionGUID: iM5hOLSJSYyokrwaSPCPLA==
X-CSE-MsgGUID: zAHQ/Y8YRimpbNELvba+gQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="22112267"
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="22112267"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 05:29:49 -0700
X-CSE-ConnectionGUID: SdaYVdPOTmWANH60KXqCBg==
X-CSE-MsgGUID: 0DaZz/4KQVmD4U+Rcm71IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="59489481"
Received: from unknown (HELO khuang2-desk.gar.corp.intel.com) ([10.124.223.78])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 05:29:46 -0700
From: Kai Huang <kai.huang@intel.com>
To: dave.hansen@intel.com,
	kirill.shutemov@linux.intel.com,
	bp@alien8.de,
	tglx@linutronix.de,
	peterz@infradead.org,
	mingo@redhat.com
Cc: x86@kernel.org,
	hpa@zytor.com,
	luto@kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.lendacky@amd.com,
	pbonzini@redhat.com,
	seanjc@google.com
Subject: [PATCH v5 4/5] x86/kexec: Reset TDX private memory on platforms with TDX erratum
Date: Fri, 16 Aug 2024 00:29:20 +1200
Message-ID: <878c1c2821ae3edc1a8a86a14f6b61c2df9c36b0.1723723470.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1723723470.git.kai.huang@intel.com>
References: <cover.1723723470.git.kai.huang@intel.com>
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
second kernel to avoid the second kernel seeing potential unexpected
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
index 07ca9d3361a3..87da1b96ad67 100644
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
@@ -332,10 +341,20 @@ void machine_kexec(struct kimage *image)
 	 */
 	host_mem_enc_active = cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT);
 
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
2.45.2


