Return-Path: <linux-kernel+bounces-287924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D253952E45
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3A7D1C22518
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2F019DF76;
	Thu, 15 Aug 2024 12:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NlkNcDcX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3943C19D897
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 12:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723724985; cv=none; b=BkVDp+SG9oRGGK+lsyHAU+1vfWl1ym4xN+JhWtXf640cbKJvTpl6UBIaylpYkaHLNdLEvtcFV/YFNx7FRC7EkDxi+Z303nxHiFUQtFKuQtg6S9cG9O8DzsFYRhqZdymdtkEgJk0k09u2AT3F5b5pF9gwgV711f9gV5JfQJ4hQmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723724985; c=relaxed/simple;
	bh=UttqBvpZoKKLFR80hy05flF/93dogdULoEdz0bQr4mM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e97frx9fOawAK95WMytbmr/YY9J4Kuj/SdjyBzYCx9u2rWxhZwz26WwOp5LVifSD3Sg4BtdcfhF+7gkJPQ9qepSQtD3yjhqzuEZC75zIb2r3Dm95rIpy+ZXzcembYLFFYNfnx+T1knEZmVRSts7pFm5RqQuaxNzdfNBDIUFPNvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NlkNcDcX; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723724984; x=1755260984;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UttqBvpZoKKLFR80hy05flF/93dogdULoEdz0bQr4mM=;
  b=NlkNcDcXrzdW8PygLvFevzZPKsK/KElgUyYGFg9xJd/XBWxBHptEegZU
   1QN9xMrvAdy4xCswH1Oi9AvKWjtcgSdxdA4tMY6qCqBS/Lkd82Gqt2Kmb
   Vcun9xZjVZkBZJHmJgzjEACl4NeiaaVcRE6yxvVRuBsRsONSFZbmy+7L7
   Xxj3DQ0frzv0fO2ncDBu3FiZTmxhnf04bsx1AiJtUXZwLEATRiW+WWgN8
   AMJH9DCQCI97ld5aTxoy6GcLmF7XmZgEPB99DZ1Mp/HRZACqco9rIYu5q
   RUzApHttvtm6CRtKpBeVx+Xu+8wM2GCEwGLmw0U+Vt/WOiQ6ncJTu8lLi
   g==;
X-CSE-ConnectionGUID: nRYPqMbZS9aPJLUCswH5OQ==
X-CSE-MsgGUID: 8quKxT3rQLqTTjDbc4PcFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="22112238"
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="22112238"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 05:29:43 -0700
X-CSE-ConnectionGUID: gUFwCKPlSzGPEAqP0QtgCw==
X-CSE-MsgGUID: m8XZBriHRy6UqjtL9lwvvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="59489467"
Received: from unknown (HELO khuang2-desk.gar.corp.intel.com) ([10.124.223.78])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 05:29:40 -0700
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
Subject: [PATCH v5 2/5] x86/kexec: do unconditional WBINVD for bare-metal in relocate_kernel()
Date: Fri, 16 Aug 2024 00:29:18 +1200
Message-ID: <47d9f1150a6852c9a403b9e25858f5658c50a51d.1723723470.git.kai.huang@intel.com>
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

Signed-off-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dave Young <dyoung@redhat.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
---

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
 arch/x86/kernel/machine_kexec_64.c   |  2 +-
 arch/x86/kernel/relocate_kernel_64.S | 19 +++++++++++++++----
 3 files changed, 17 insertions(+), 6 deletions(-)

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
index 9c9ac606893e..07ca9d3361a3 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -392,7 +392,7 @@ void machine_kexec(struct kimage *image)
 				       (unsigned long)page_list,
 				       image->start,
 				       image->preserve_context,
-				       host_mem_enc_active);
+				       !boot_cpu_has(X86_FEATURE_HYPERVISOR));
 
 #ifdef CONFIG_KEXEC_JUMP
 	if (image->preserve_context)
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 042c9a0334e9..a1a8a79d6b78 100644
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
2.45.2


