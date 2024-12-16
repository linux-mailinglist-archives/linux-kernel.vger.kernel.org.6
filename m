Return-Path: <linux-kernel+bounces-448305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5579F3E56
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 00:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F0DB18840F8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 23:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6527A1DE4C0;
	Mon, 16 Dec 2024 23:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YtrdpZV5"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391ED1DDA31
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 23:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734392262; cv=none; b=ZBeAtQ4oL/eQ9tsIlsM1cTgNU7ebhKrAkNN0G7D/eytdKlRcb0IwGs3oGjw+o62wlSazPFuUS0FW3RsYuS6fCT3ws5Y+0lg77d9BH0JKi1aS2FufdQfn3Zal99Cvm8UB3SjxloW4UGnbTacC/TiaP3T+k3P7Uhs8nCtNGvZfpfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734392262; c=relaxed/simple;
	bh=66bK3hS4MjiVy30c7KVE9tQcd7zIjJHoi4zEicwN8Po=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NEPVE/bR6yqGDGP4RlevVVZ02LtgTwSxWtPyeQGzmOKlCrEfllQQF/1TXIJiFN/VtUftoGgSxg7PfI+7sOsWHCOvS1VRFGl8KSIIOmjOrKeOGJvApQ83uswR70Uk61leNfhj5LFKuIRQR6kg6h97yhTFYT8Lhzg0SVoo35w091Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YtrdpZV5; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=2QdnXzG6oBq2pMrwUNHKRzdcvGBvqjVeazTvAuBzw50=; b=YtrdpZV5q7RwJLVF+vAMRjX/iH
	svvl4giWUH2iMjCT5ixTY4kEOHrtcZbHf0sb7EjpmCJgmE/sGAbZE5/TzDdZp41nJPLVbK0OwDsxK
	7CRv9x10roEGFw+y3DjL/ybkPrACOs5l3dm3GetsvoZmvSWI9cVn2hEHt2XQqQnC9+/1zuG/pvOlh
	h8sKTArFfHWsPva6AJ2ueEWgthsJtT7pZtQuWLu7h916ye+6ENMw/Cy5CHBM85kTuKjE1/Qv2zxS7
	l+1YD1+ry43OOQg5tRoITUxi0CR0Hs2zxOI2dNwgK02GphYE/IqWU2Qk8pggCLFvwNc7Ssv1ZbqI6
	I8LqVnJQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeB-00000004xiR-2Ak7;
	Mon, 16 Dec 2024 23:37:08 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeA-0000000DeWZ-1mhY;
	Mon, 16 Dec 2024 23:37:06 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Yuntao Wang <ytcoode@gmail.com>,
	David Kaplan <david.kaplan@amd.com>,
	Tao Liu <ltao@redhat.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Rong Xu <xur@google.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	bsz@amazon.de,
	nathan@kernel.org
Subject: [PATCH 9/9] x86/kexec: Use typedef for relocate_kernel_fn function prototype
Date: Mon, 16 Dec 2024 23:24:16 +0000
Message-ID: <20241216233704.3208607-10-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241216233704.3208607-1-dwmw2@infradead.org>
References: <20241216233704.3208607-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Both i386 and x86_64 now copy the relocate_kernel function into the control
page and execute it from there, using an open-coded function pointer.

Use a typedef for it instead.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/kexec.h       | 26 +++++++++++++-------------
 arch/x86/kernel/machine_kexec_32.c |  7 +------
 arch/x86/kernel/machine_kexec_64.c |  6 +-----
 3 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 48e4f44f794f..8ad187462b68 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -111,21 +111,21 @@ static inline void crash_setup_regs(struct pt_regs *newregs,
 }
 
 #ifdef CONFIG_X86_32
-asmlinkage unsigned long
-relocate_kernel(unsigned long indirection_page,
-		unsigned long control_page,
-		unsigned long start_address,
-		unsigned int has_pae,
-		unsigned int preserve_context);
+typedef asmlinkage unsigned long
+relocate_kernel_fn(unsigned long indirection_page,
+		   unsigned long control_page,
+		   unsigned long start_address,
+		   unsigned int has_pae,
+		   unsigned int preserve_context);
 #else
-unsigned long
-relocate_kernel(unsigned long indirection_page,
-		unsigned long pa_control_page,
-		unsigned long start_address,
-		unsigned int preserve_context,
-		unsigned int host_mem_enc_active);
+typedef unsigned long
+relocate_kernel_fn(unsigned long indirection_page,
+		   unsigned long pa_control_page,
+		   unsigned long start_address,
+		   unsigned int preserve_context,
+		   unsigned int host_mem_enc_active);
 #endif
-
+extern relocate_kernel_fn relocate_kernel;
 #define ARCH_HAS_KIMAGE_ARCH
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_kexec_32.c
index 1b373d79cedc..80265162aeff 100644
--- a/arch/x86/kernel/machine_kexec_32.c
+++ b/arch/x86/kernel/machine_kexec_32.c
@@ -160,15 +160,10 @@ void machine_kexec_cleanup(struct kimage *image)
  */
 void machine_kexec(struct kimage *image)
 {
+	relocate_kernel_fn *relocate_kernel_ptr;
 	unsigned long page_list[PAGES_NR];
 	void *control_page;
 	int save_ftrace_enabled;
-	asmlinkage unsigned long
-		(*relocate_kernel_ptr)(unsigned long indirection_page,
-				       unsigned long control_page,
-				       unsigned long start_address,
-				       unsigned int has_pae,
-				       unsigned int preserve_context);
 
 #ifdef CONFIG_KEXEC_JUMP
 	if (image->preserve_context)
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 1440f792a86d..dd75a51463a2 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -344,12 +344,8 @@ void machine_kexec_cleanup(struct kimage *image)
  */
 void __nocfi machine_kexec(struct kimage *image)
 {
-	unsigned long (*relocate_kernel_ptr)(unsigned long indirection_page,
-					     unsigned long pa_control_page,
-					     unsigned long start_address,
-					     unsigned int preserve_context,
-					     unsigned int host_mem_enc_active);
 	unsigned long reloc_start = (unsigned long)__relocate_kernel_start;
+	relocate_kernel_fn *relocate_kernel_ptr;
 	unsigned int host_mem_enc_active;
 	int save_ftrace_enabled;
 	void *control_page;
-- 
2.47.0


