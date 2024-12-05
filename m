Return-Path: <linux-kernel+bounces-433101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6B39E53E5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97A311882AA1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33849202C3F;
	Thu,  5 Dec 2024 11:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H/kH/AdC"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3951F03F6
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 11:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733398109; cv=none; b=odt71Q+TRB3IaYpUy8ZcGOwkeiazI6aYR8pp57t8LVDka9suUhuNArqVsF2iAnz6ED4/a2XaBOvPU+GpNe4DNDRTt33OqfglDuks9IZLiXGZhUArkQbvyGnqgYAV2+zMe8SKbiWc7xKCxsa1xTlSG/f3o7pglMHQKKFbSALhDKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733398109; c=relaxed/simple;
	bh=B27k299H+iLvXKu+g9hQqxuGUviaGecZMriDr8EImaY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Kxl0dIK1zd4fBmVg84HyigFQe3eJ4mBu31W3F4djktDZVPvH3n5rjv8PuAyC2Rk+NFrD+59TyUTx8lNUd0b+13Sj+LXE4E2mbUCreEMPnOfguzu7oLvmE0lRnFCOQ1tbxx6qqRZzYL+0an54YCHcLWXuAfSK33rzssJz06QUQjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H/kH/AdC; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-385d7d51ac8so410674f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 03:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733398105; x=1734002905; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bNb7gvbB68GY4FoEY1goL8tTfrtwnuvDL+QgmlzPOog=;
        b=H/kH/AdCMMbwutuJiDboLGcHA0X5QXxUCYinNEq6/ZMLiKtknICeHKFgh5BBzSG1OP
         z/9/uLeVCKYvvaOmsoqS/DC0Bq+9Km7kdEtDhcslp/bKihGfGZbRgeUkl/MjoLqwlF75
         LrpvN3jhQ6s5S24qHv4QkXVYSupQ6XiIzdy4rDbq5jtXAKKALeMv/ny2Sd1zfduFztCQ
         1KeRmO1MzGOLm4UqGqNsqi4ocd6ydV5eX9pqh7xGIWPc3VbjhqKmSU5k1Q2u3Tyoo6o8
         NEUg8QsstKNU1sADw42q0C8R3WXGbF+n9jlhEfKeaC3hv0Sf1WtQZEOc2gm0Eodi9HdL
         VGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733398105; x=1734002905;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bNb7gvbB68GY4FoEY1goL8tTfrtwnuvDL+QgmlzPOog=;
        b=j9d+9QIXltIKCj6mffm2s1uwZ2mDrk4p7k2969jY+zf6JttwQPdoFf0W9QUYvxtzva
         P7zfDNasqiCr1s9uA111ZbhUdmodFm9/14h0TtyowCt4Usni4dZN4phZMlsobDfEHSaI
         OZRLU8/J6FF3kyPUO9fH5SNDPcievos2IbhT58shdH6+QpHggr4Rc5b4LHR+l5rLZg6R
         z+M8qHQTgvuyWZ3ep9adXAIyXW5NGfYRgDjOcTq8dGaQicLAGJClUrqcBmmcgQYF7VhD
         kRtrlZ3wQDXQ1gcsepiJaUWRZiAFcU4RolO+Z+jq/GLWt2G4c9/FyqrL8Kvby6xQUkrh
         HJSw==
X-Gm-Message-State: AOJu0YxUcfHRrhThwbD4+4LPdxWq8BdkArAqSKZkTJcaBRB18nN6Ws9X
	AKAy/SUQiQYDvPB6eSeZuLCsPUB/C+uR2TPvSNr5tScvWONeMYZ6/su+t/bzEFRXUftRkpfk5dN
	Wb1TQFWbT7xiii4OLNmCWU9ppgfB2kwwKmcljxv5cpkjmpWKfyPEQ9AM0SOX6mbBJ54nBRSywXy
	PdkWmmAOpPyemqLIPkuu/jzounZT9GYg==
X-Google-Smtp-Source: AGHT+IHKOL5KkofYqxsGkgNzag5vUWzV+1c6SDcOeLVaazO9tdXBv9gPns/19Y4FrAN+sbNKkSgJ1qHu
X-Received: from wmbbg26.prod.google.com ([2002:a05:600c:3c9a:b0:434:a2fb:effe])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:59ab:0:b0:385:f4db:e33b
 with SMTP id ffacd0b85a97d-385fd3ec8d6mr8638320f8f.21.1733398105020; Thu, 05
 Dec 2024 03:28:25 -0800 (PST)
Date: Thu,  5 Dec 2024 12:28:07 +0100
In-Reply-To: <20241205112804.3416920-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241205112804.3416920-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4688; i=ardb@kernel.org;
 h=from:subject; bh=CVdCAQPjLUiDyPJjHktJs3oAxj/txjSvWAOADaDmc9Q=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIT2wz+Pl5jXOx7KUN2x6qVw+IWuj/EPHQAuvCyaxah4RX
 eKerdc7SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwES+PmX4n7Cw+r2Kqd7RWtGP
 VRId+dk/LY89u8Iz37hh9vO73gUR9gx/5W59VWSvvCwiWWB2spqpY2vhdpY9F/fWnV7ynTnvWIs 5MwA=
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241205112804.3416920-11-ardb+git@google.com>
Subject: [PATCH v4 2/7] x86/boot/64: Determine VA/PA offset before entering C code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Implicit absolute symbol references (e.g., taking the address of a
global variable) must be avoided in the C code that runs from the early
1:1 mapping of the kernel, given that this is a practice that violates
assumptions on the part of the toolchain. I.e., RIP-relative and
absolute references are expected to produce the same values, and so the
compiler is free to choose either. However, the code currently assumes
that RIP-relative references are never emitted here.

So an explicit virtual-to-physical offset needs to be used instead to
derive the kernel virtual addresses of _text and _end, instead of simply
taking the addresses and assuming that the compiler will not choose to
use a RIP-relative references in this particular case.

Currently, phys_base is already used to perform such calculations, but
it is derived from the kernel virtual address of _text, which is taken
using an implicit absolute symbol reference. So instead, derive this
VA-to-PA offset in asm code, and pass it to the C startup code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/setup.h |  2 +-
 arch/x86/kernel/head64.c     |  8 +++++---
 arch/x86/kernel/head_64.S    | 12 +++++++++---
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index 0667b2a88614..85f4fde3515c 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -49,7 +49,7 @@ extern unsigned long saved_video_mode;
 
 extern void reserve_standard_io_resources(void);
 extern void i386_reserve_resources(void);
-extern unsigned long __startup_64(unsigned long physaddr, struct boot_params *bp);
+extern unsigned long __startup_64(unsigned long p2v_offset, struct boot_params *bp);
 extern void startup_64_setup_gdt_idt(void);
 extern void early_setup_idt(void);
 extern void __init do_early_exception(struct pt_regs *regs, int trapnr);
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 4b9d4557fc94..a7cd4053eeb3 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -138,12 +138,14 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
  * doesn't have to generate PC-relative relocations when accessing globals from
  * that function. Clang actually does not generate them, which leads to
  * boot-time crashes. To work around this problem, every global pointer must
- * be accessed using RIP_REL_REF().
+ * be accessed using RIP_REL_REF(). Kernel virtual addresses can be determined
+ * by subtracting p2v_offset from the RIP-relative address.
  */
-unsigned long __head __startup_64(unsigned long physaddr,
+unsigned long __head __startup_64(unsigned long p2v_offset,
 				  struct boot_params *bp)
 {
 	pmd_t (*early_pgts)[PTRS_PER_PMD] = RIP_REL_REF(early_dynamic_pgts);
+	unsigned long physaddr = (unsigned long)&RIP_REL_REF(_text);
 	unsigned long pgtable_flags;
 	unsigned long load_delta;
 	pgdval_t *pgd;
@@ -163,7 +165,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	 * Compute the delta between the address I am compiled to run at
 	 * and the address I am actually running at.
 	 */
-	load_delta = physaddr - (unsigned long)(_text - __START_KERNEL_map);
+	load_delta = __START_KERNEL_map + p2v_offset;
 	RIP_REL_REF(phys_base) = load_delta;
 
 	/* Is the address not 2M aligned? */
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 56163e2124cf..31345e0ba006 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -94,13 +94,19 @@ SYM_CODE_START_NOALIGN(startup_64)
 	/* Sanitize CPU configuration */
 	call verify_cpu
 
+	/*
+	 * Derive the kernel's physical-to-virtual offset from the physical and
+	 * virtual addresses of common_startup_64().
+	 */
+	leaq	common_startup_64(%rip), %rdi
+	subq	.Lcommon_startup_64(%rip), %rdi
+
 	/*
 	 * Perform pagetable fixups. Additionally, if SME is active, encrypt
 	 * the kernel and retrieve the modifier (SME encryption mask if SME
 	 * is active) to be added to the initial pgdir entry that will be
 	 * programmed into CR3.
 	 */
-	leaq	_text(%rip), %rdi
 	movq	%r15, %rsi
 	call	__startup_64
 
@@ -128,11 +134,11 @@ SYM_CODE_START_NOALIGN(startup_64)
 
 	/* Branch to the common startup code at its kernel virtual address */
 	ANNOTATE_RETPOLINE_SAFE
-	jmp	*0f(%rip)
+	jmp	*.Lcommon_startup_64(%rip)
 SYM_CODE_END(startup_64)
 
 	__INITRODATA
-0:	.quad	common_startup_64
+SYM_DATA_LOCAL(.Lcommon_startup_64, .quad common_startup_64)
 
 	.text
 SYM_CODE_START(secondary_startup_64)
-- 
2.47.0.338.g60cca15819-goog


