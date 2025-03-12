Return-Path: <linux-kernel+bounces-557621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25863A5DBA3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F7E7189B4C3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEA023F279;
	Wed, 12 Mar 2025 11:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n+2/v8u0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7549923E348
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 11:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741779290; cv=none; b=IrjykgBrRwrltooEeDJXVNKydkcfiRdkyMAZg/urrfwuOGI5xn3nxEqC8Io8VYra+sh05euH4i6GGH9/bPryf6W/aewdx6v/v0B5jW4CDE75T3jt5KM1f2a/rVOK6SWuxlTNyOkvxScauiVjd2oYBrbZAUX+Ly58NGKl9clplN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741779290; c=relaxed/simple;
	bh=aD+jjzZjn1ZZwgNbkBqMyfBNePvy2KuzSsLhnBYx060=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJ+lbT1eea7Jp2OE9zpMiRKkV2NEgEMx841i4ARgTgQPYWgQxnPjUoHoD1pLICEIWH570/oszI1EJvAw2pZyenyGMQ9kxoVurvh/D+IidS6+fP3Mzrb7JpX0p87QJ74wSXvt3miPRNN+2kOfMXxMAmgfmNKDgclXs3i+PxW6ngs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n+2/v8u0; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741779288; x=1773315288;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aD+jjzZjn1ZZwgNbkBqMyfBNePvy2KuzSsLhnBYx060=;
  b=n+2/v8u0C+vk4hOqz0mhrQdD7XLfZhDom25TY1neJLlylbFwJE0369uv
   BEt8DJy+IRUIwfymRPVfkBXHqvocd6hGnnjYjBQzN6HuXGnxFXggGlFrD
   MQMhOLXru0xAB/XH2bnEh3zS0sXqbBU/jUkWRQvpTERkPbEfQ5MomiV7e
   zYoIBtehQhdlRMgZinIPprRSh9HC/E2DteFKGaSBdo1Gfc2+IzMOTohXH
   ffYgTxvk39iQMHuMhu8NUGJ6Mzq0S8fdReau8k4GKMthGp8b3Gi/wzObr
   DFXLW8z5xkr4qLADrOfEyl9x4KyPhTX1PRqISYWfkLvRcjq9l4gOHlvmN
   Q==;
X-CSE-ConnectionGUID: yK1KO/5JTVO9DMGQi/4WBg==
X-CSE-MsgGUID: KVqTUtdQQJGC42nEv5uSxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="42985153"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="42985153"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 04:34:48 -0700
X-CSE-ConnectionGUID: uzJc9TCpQKmxQ1WZ02lg9g==
X-CSE-MsgGUID: hX4NAt5ARWuITPiNLawTNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="124776008"
Received: from iweiny-desk3.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.124.221.164])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 04:34:43 -0700
From: Kai Huang <kai.huang@intel.com>
To: dave.hansen@intel.com,
	bp@alien8.de,
	tglx@linutronix.de,
	peterz@infradead.org,
	mingo@redhat.com,
	kirill.shutemov@linux.intel.com
Cc: hpa@zytor.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	pbonzini@redhat.com,
	seanjc@google.com,
	rick.p.edgecombe@intel.com,
	reinette.chatre@intel.com,
	isaku.yamahata@intel.com,
	dan.j.williams@intel.com,
	thomas.lendacky@amd.com,
	ashish.kalra@amd.com,
	dwmw@amazon.co.uk,
	bhe@redhat.com,
	nik.borisov@suse.com,
	sagis@google.com,
	Dave Young <dyoung@redhat.com>,
	David Kaplan <david.kaplan@amd.com>
Subject: [RFC PATCH 2/5] x86/kexec: Do unconditional WBINVD for bare-metal in relocate_kernel()
Date: Thu, 13 Mar 2025 00:34:14 +1300
Message-ID: <ebe4c0e8fe1b78c014bbc18832ae0eec8fef419d.1741778537.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741778537.git.kai.huang@intel.com>
References: <cover.1741778537.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For both SME and TDX, dirty cachelines with and without the encryption
bit(s) of the same physical memory address can coexist and the CPU can
flush them back to memory in random order.  During kexec, the caches
must be flushed before jumping to the new kernel to avoid silent memory
corruption to the new kernel.

The WBINVD in stop_this_cpu() flushes caches for all remote CPUs when
they are being stopped.  For SME, the WBINVD in relocate_kernel()
flushes the cache for the last running CPU (which is doing kexec).

Similarly, to support kexec for TDX host, after stopping all remote CPUs
with cache flushed, the kernel needs to flush cache for the last running
CPU.

Use the existing WBINVD in relocate_kernel() to cover TDX host as well.

Just do unconditional WBINVD to cover both SME and TDX instead of
sprinkling additional vendor-specific checks.  Kexec is a slow path, and
the additional WBINVD is acceptable for the sake of simplicity and
maintainability.

But only do WBINVD for bare-metal because TDX guests and SEV-ES/SEV-SNP
guests will get unexpected (and yet unnecessary) exception (#VE or #VC)
which the kernel is unable to handle at the time of relocate_kernel()
since the kernel has torn down the IDT.

Remove the host_mem_enc_active local variable and directly use
!cpu_feature_enabled(X86_FEATURE_HYPERVISOR) as an argument of calling
relocate_kernel().  cpu_feature_enabled() is always inline but not a
function call, thus it is safe to use after load_segments() when call
depth tracking is enabled.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: David Kaplan <david.kaplan@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Tested-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/include/asm/kexec.h         |  2 +-
 arch/x86/kernel/machine_kexec_64.c   | 14 ++++++--------
 arch/x86/kernel/relocate_kernel_64.S | 15 ++++++++++-----
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 8ad187462b68..48c313575262 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -123,7 +123,7 @@ relocate_kernel_fn(unsigned long indirection_page,
 		   unsigned long pa_control_page,
 		   unsigned long start_address,
 		   unsigned int preserve_context,
-		   unsigned int host_mem_enc_active);
+		   unsigned int bare_metal);
 #endif
 extern relocate_kernel_fn relocate_kernel;
 #define ARCH_HAS_KIMAGE_ARCH
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index a68f5a0a9f37..0e9808eeb63e 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -346,16 +346,9 @@ void __nocfi machine_kexec(struct kimage *image)
 {
 	unsigned long reloc_start = (unsigned long)__relocate_kernel_start;
 	relocate_kernel_fn *relocate_kernel_ptr;
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
@@ -398,6 +391,11 @@ void __nocfi machine_kexec(struct kimage *image)
 	 *
 	 * I take advantage of this here by force loading the
 	 * segments, before I zap the gdt with an invalid value.
+	 *
+	 * load_segments() resets GS to 0.  Don't make any function call
+	 * after here since call depth tracking uses per-CPU variables to
+	 * operate (relocate_kernel() is explicitly ignored by call depth
+	 * tracking).
 	 */
 	load_segments();
 	/*
@@ -412,7 +410,7 @@ void __nocfi machine_kexec(struct kimage *image)
 					   virt_to_phys(control_page),
 					   image->start,
 					   image->preserve_context,
-					   host_mem_enc_active);
+					   !cpu_feature_enabled(X86_FEATURE_HYPERVISOR));
 
 #ifdef CONFIG_KEXEC_JUMP
 	if (image->preserve_context)
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index b44d8863e57f..dc1a59cd8139 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -50,7 +50,7 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	 * %rsi pa_control_page
 	 * %rdx start address
 	 * %rcx preserve_context
-	 * %r8  host_mem_enc_active
+	 * %r8  bare_metal
 	 */
 
 	/* Save the CPU context, used for jumping back */
@@ -107,7 +107,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	/*
 	 * %rdi	indirection page
 	 * %rdx start address
-	 * %r8 host_mem_enc_active
+	 * %r8 bare_metal
 	 * %r9 page table page
 	 * %r11 preserve_context
 	 * %r13 original CR4 when relocate_kernel() was invoked
@@ -156,14 +156,19 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	movq	%r9, %cr3
 
 	/*
-	 * If SME is active, there could be old encrypted cache line
+	 * If SME/TDX is active, there could be old encrypted cache line
 	 * entries that will conflict with the now unencrypted memory
 	 * used by kexec. Flush the caches before copying the kernel.
+	 *
+	 * Do WBINVD for bare-metal only to cover both SME and TDX. Doing
+	 * WBINVD in guest results in an unexpected exception (#VE or #VC)
+	 * for TDX and SEV-ES/SNP guests which then crashes the guest (the
+	 * kernel has torn down the IDT).
 	 */
 	testq	%r8, %r8
-	jz .Lsme_off
+	jz .Lno_wbinvd
 	wbinvd
-.Lsme_off:
+.Lno_wbinvd:
 
 	call	swap_pages
 
-- 
2.48.1


