Return-Path: <linux-kernel+bounces-337124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E959845B1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EC991F213D4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC8C1A76DC;
	Tue, 24 Sep 2024 12:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LVvYtaO4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908DD1A76CF
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727180062; cv=none; b=if3lN4m4sOuxcZrALDdG8sH2W2TTIQQnSemKbTMJT28uw/9LnvUGfZDTul9SfRiNHHEG8La7DksTbqwJLRneor2Ofq+/T5UcxhYtccnLj1QR40B3dack/cAj2E4Pk597bhUqUgAYF1eU0o9bFpY/DfFeEQ3OLJwcpbgMGjzTlTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727180062; c=relaxed/simple;
	bh=3xAr1fBNzxdVYzWS6YJPPW42FxFGJe2ZvmoVf930Cbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ky9gGBcPodsmi7dBJuDyAjnKEQBX06hl70Ab91wDc1a87LOlvZQd+bUSlzRGCbqdKpdQpW2BkB7G/rOsyATheMW4qUTnY+3idKt7x0wEiA24xZUCk2gafzJ8k+DAokY7LmswzkQtH563RlZDwcJ5HtPtoH+Kw2p9YKcHqGGM/0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LVvYtaO4; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727180060; x=1758716060;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3xAr1fBNzxdVYzWS6YJPPW42FxFGJe2ZvmoVf930Cbg=;
  b=LVvYtaO4WV1XjjpBid8UCgQKw48wPft+6OoH4L8+jLYaWq2dfUse4Gol
   3XfEbUXtU2wwesvGvO0AgVSGpUg4XdbeUoPNY2weP/jcKSvuQgLSwlzBH
   AyDryeZtzi3EvI8G0yzU+806tT0uTha45clepgydgtAYnc5LvYDiHVzOr
   kUi+GM3VRCq/253Z6eRvNUKP0czJQREfMgDmzuV8rMKV0/i6wLnLFZwfI
   4YpYLwk5hRpCQo7iF85EzmRfGXZWEoWPBiWuiVpntQaP4PbPXoVXWITII
   8j5klZJVcfuKNBMGf4dBR/0zRk/9ar3qZcQBKbbhissb3xWvgcwfd3K1f
   w==;
X-CSE-ConnectionGUID: o1vPqqfvQhKSVilZJNTMrw==
X-CSE-MsgGUID: nAfk5UNZQHiCTI67kI4MWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="29881874"
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="29881874"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 05:14:20 -0700
X-CSE-ConnectionGUID: ezaBS902TW+zyH0TeuZXLg==
X-CSE-MsgGUID: Wg/TojsiTrmzi8hdAOhKdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="71473247"
Received: from ccbilbre-mobl3.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.124.221.10])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 05:14:16 -0700
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
	sagis@google.com,
	Dave Young <dyoung@redhat.com>,
	David Kaplan <david.kaplan@amd.com>
Subject: [PATCH v7 2/5] x86/kexec: do unconditional WBINVD for bare-metal in relocate_kernel()
Date: Wed, 25 Sep 2024 00:13:54 +1200
Message-ID: <afd9722e12df95cf3bad49ec48ae4516784395d6.1727179214.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1727179214.git.kai.huang@intel.com>
References: <cover.1727179214.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both SME and TDX can leave caches in incoherent state due to memory
encryption.  During kexec, the caches must be flushed before jumping to
the second kernel to avoid silent memory corruption to the second kernel.

During kexec, the WBINVD in stop_this_cpu() flushes caches for all
remote cpus when they are being stopped.  For SME, the WBINVD in
relocate_kernel() flushes the cache for the last running cpu (which is
executing the kexec).

Similarly, to support kexec for TDX host, after stopping all remote cpus
with cache flushed, the kernel needs to flush cache for the last running
cpu.

Use the existing WBINVD in relocate_kernel() to cover TDX host as well.

However, instead of sprinkling around vendor-specific checks, just do
unconditional WBINVD to cover both SME and TDX.  Kexec is not a fast path
so having one additional WBINVD for platforms w/o SME/TDX is acceptable.

But only do WBINVD for bare-metal because TDX guests and SEV-ES/SEV-SNP
guests will get unexpected (and yet unnecessary) exception (#VE or #VC)
which the kernel is unable to handle at this stage.

Note commit 93c1800b3799 ("x86/kexec: Fix bug with call depth tracking")
moved calling 'cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)' as an argument
of relocate_kernel() to an earlier place before load_segments() by
adding a variable 'host_mem_enc_active'.  The reason was the call to
cc_platform_has() after load_segments() caused a fault and system crash
when call depth tracking is active because load_segments() resets GS to
0 but call depth tracking uses per-CPU variable to operate.

Use !cpu_feature_enabled(X86_FEATURE_HYPERVISOR) to check whether the
kernel runs on bare-metal.  cpu_feature_enabled() is always inline but
not a function call, thus it is safe to use it after load_segments()
when call depth tracking is enabled.  Remove the 'host_mem_enc_active'
variable and use cpu_feature_enabled() directly as the argument when
calling relocate_kernel().

Signed-off-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: David Kaplan <david.kaplan@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Tested-by: David Kaplan <david.kaplan@amd.com>
---

v6 -> v7:
 - Add a comment to load_segments() to call out not to make function
   call after it - David Kaplan.
 - Add David's Tested-by.

v5 - >v6:
 - Use cpu_feature_enabled() instead of boot_cpu_has() - Boris
 - Resolve rebase conflict with commit 93c1800b3799 ("x86/kexec: Fix bug
   with call depth tracking")

v4 -> v5:
 - Add Tom's tag

v3 -> v4:
 - Use "exception (#VE or #VC)" for TDX and SEV-ES/SEV-SNP in changelog
   and comments.  (Kirill, Tom)
 - "Save the bare_metal" -> "Save the bare_metal flag" (Tom)
 - Point out "WBINVD is not necessary for TDX and SEV-ES/SEV-SNP guests"
   in the comment.  (Tom)

v2 -> v3:
 - Change to only do WBINVD for bare metal


---
 arch/x86/include/asm/kexec.h         |  2 +-
 arch/x86/kernel/machine_kexec_64.c   | 14 ++++++--------
 arch/x86/kernel/relocate_kernel_64.S | 19 +++++++++++++++----
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index ae5482a2f0ca..b3429c70847d 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -128,7 +128,7 @@ relocate_kernel(unsigned long indirection_page,
 		unsigned long page_list,
 		unsigned long start_address,
 		unsigned int preserve_context,
-		unsigned int host_mem_enc_active);
+		unsigned int bare_metal);
 #endif
 
 #define ARCH_HAS_KIMAGE_ARCH
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 9c9ac606893e..6c24b0e4051e 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -322,16 +322,9 @@ void machine_kexec_cleanup(struct kimage *image)
 void machine_kexec(struct kimage *image)
 {
 	unsigned long page_list[PAGES_NR];
-	unsigned int host_mem_enc_active;
 	int save_ftrace_enabled;
 	void *control_page;
 
-	/*
-	 * This must be done before load_segments() since if call depth tracking
-	 * is used then GS must be valid to make any function calls.
-	 */
-	host_mem_enc_active = cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT);
-
 #ifdef CONFIG_KEXEC_JUMP
 	if (image->preserve_context)
 		save_processor_state();
@@ -378,6 +371,11 @@ void machine_kexec(struct kimage *image)
 	 *
 	 * I take advantage of this here by force loading the
 	 * segments, before I zap the gdt with an invalid value.
+	 *
+	 * Note this resets GS to 0.  Don't make any function call after
+	 * here since call depth tracking uses per-cpu variables to
+	 * operate (relocate_kernel() is explicitly ignored by call
+	 * depth tracking).
 	 */
 	load_segments();
 	/*
@@ -392,7 +390,7 @@ void machine_kexec(struct kimage *image)
 				       (unsigned long)page_list,
 				       image->start,
 				       image->preserve_context,
-				       host_mem_enc_active);
+				       !cpu_feature_enabled(X86_FEATURE_HYPERVISOR));
 
 #ifdef CONFIG_KEXEC_JUMP
 	if (image->preserve_context)
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index e9e88c342f75..19821c3fbc46 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -52,7 +52,7 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	 * %rsi page_list
 	 * %rdx start address
 	 * %rcx preserve_context
-	 * %r8  host_mem_enc_active
+	 * %r8  bare_metal
 	 */
 
 	/* Save the CPU context, used for jumping back */
@@ -80,7 +80,7 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	pushq $0
 	popfq
 
-	/* Save SME active flag */
+	/* Save the bare_metal flag */
 	movq	%r8, %r12
 
 	/*
@@ -161,9 +161,20 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	movq	%r9, %cr3
 
 	/*
-	 * If SME is active, there could be old encrypted cache line
+	 * The kernel could leave caches in incoherent state on SME/TDX
+	 * capable platforms.  Just do unconditional WBINVD to avoid
+	 * silent memory corruption to the new kernel for these platforms.
+	 *
+	 * For SME, need to flush cache here before copying the kernel.
+	 * When it is active, there could be old encrypted cache line
 	 * entries that will conflict with the now unencrypted memory
-	 * used by kexec. Flush the caches before copying the kernel.
+	 * used by kexec.
+	 *
+	 * Do WBINVD for bare-metal only to cover both SME and TDX.  It
+	 * isn't necessary to perform a WBINVD in a guest and performing
+	 * one could result in an exception (#VE or #VC) for a TDX or
+	 * SEV-ES/SEV-SNP guest that can crash the guest since, at this
+	 * stage, the kernel has torn down the IDT.
 	 */
 	testq	%r12, %r12
 	jz .Lsme_off
-- 
2.46.0


