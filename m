Return-Path: <linux-kernel+bounces-202208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCC28FC931
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 12:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC5B28595D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30983191496;
	Wed,  5 Jun 2024 10:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XF8XhHIs"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB19C1922F8
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 10:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717583790; cv=none; b=obzkt1vsF6bJeH5l3yLay5Y7epUKRohuUbrPtLqT5Ve+jMsyF7lqM/J7XPtmVrXTAB1EfNkDzcz7V4wKnnoSPJ8MICDe245FT1r0iwtttrZA2shur13b4u8PFmlzJFWdn0op9PkX2nwL6l8rvlJKM4Rf4n8Shmy8kHrUMCKA/6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717583790; c=relaxed/simple;
	bh=mSfNhvbZFblrksvDeD/XmI+UMtvac2zLUNZOrNXN8NY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a+yu9VfvhbWaDo4f6HH5c4XGSp0bfhvRgQIFHfsFZDfiuuEoZRn5HON1dL+v2UJuIpboKjs3DVObflKEOCzovrOpMi/IHvbRHRw9PeB0D9oeh/x/BIFRfb2aCMrpLO6o4p9FpcV26cKhYr9sKRS+ko4OLGqUa28R1HTyU8jOSRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XF8XhHIs; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-42159c0fbb0so808715e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 03:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717583787; x=1718188587; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CdALvWoWm/MeH/4RsJxbsYn8sMbeK49Nk2IJPPiKlcc=;
        b=XF8XhHIsO8ILPZ+35wnmXP+aZSdUuakfPFAoIUTAcVr4yxEcEbyEGNscYiN2ShJyLS
         +2kk342eEuHD+kQdq3+HHAQ22uJm5r7pfRFFf3xyPzL2iFVxwdOqHTPCt6rJufooXWNL
         Sdf5GRnLXrDHM09CkI6wGKl9g4qmMEa11ZVOf1cKHMFz0ScQvQG/xd0/vwuyclIcXkgC
         jN2fEjP3cHy+dufG7HId4kl7cvmJ5w8scMZQ9/FnFPh2O1K9LE858W4isDQFozi+ieYb
         m5hSuXdFISbzqHkLFU+GVKU8BMtXExyk49EttkakHKfBEF4sytcyYEyK0MFAM5d0HHQT
         7zZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717583787; x=1718188587;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CdALvWoWm/MeH/4RsJxbsYn8sMbeK49Nk2IJPPiKlcc=;
        b=S8GecVjfHwt0FXKjGohnUp4kFyatlukYk1bAWv8s5WuAa0IfePGwmUW8TYUhasBUOy
         TCdx00VYeIWyXS2CplBhfUPjOx+99+D3FZyxfiNkFUhMbqvhd7gUZIB14rKNaLnPsW45
         Ma5pgjGtO8E2uxTlkztk2Vdprilf/kIom4ps7LdfdKMbS4uteZNeTvLezG53KCflBgrt
         6o20ZSr/p41CMDrybTWZ6rRusGX5/pBin2D3HoOq8SI7G7qnVL2qFV4BYAP9a7leWUXo
         ZkvBcZSpt/NUQr46EOqO9QP5pEbMd3K4mJZUv1QueS32bAZ+OPTZ/xpWDdjo1G6k9ZbE
         mf/Q==
X-Gm-Message-State: AOJu0YzDf3i0OUdIZ8uNsajoXQFEYAqmIjRC8eywLdvCWG7j7qr8ZEhq
	zRhHtN3DG7vSBEsGYBtB5bdnVDHmVyglP54SoGYdqeoa0q98aiXotKJbQpM7Vp9id9fJpXJvQ7Y
	zKcAbRp218noPpfzrJOpIcsWfveLyFZ9PFWYUGYniHcWyb2lVEHOi5RTOxhUAxh9Uo0FLBxwyX7
	pvcmYDIQNQDv+iAbgi48BePXkfqTfmHg==
X-Google-Smtp-Source: AGHT+IHB9DV/UsJRIe7HdeFmlJXtA6ZNvAVqjDSqZmzyPGkvCjW1H/YJ6GxCNDq4h5RYfLGqHbJAx6Si
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:3c94:b0:41f:3f3:2fd5 with SMTP id
 5b1f17b1804b1-42156259597mr143195e9.0.1717583786739; Wed, 05 Jun 2024
 03:36:26 -0700 (PDT)
Date: Wed,  5 Jun 2024 12:16:14 +0200
In-Reply-To: <20240605101610.2824747-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240605101610.2824747-6-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4437; i=ardb@kernel.org;
 h=from:subject; bh=3w3PLjYmxjSrM/q/Li935O15LXzR9XspZXfmEVZ0SVM=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIS3B6l3mYTUPJ757b7M7Exa9O3S6rThm98rUK7XKf/d2b
 Qo8dW5PRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjIVh6G/+7v69ijfQtv6xiG
 xUw0XNJfXSL+ovLRvm6/FbPLb3E93sXwP1zvtvLU9C6Vc2WpC712TQ/KKdt0sPfq0/mdJ8Svpf4 1YAMA
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240605101610.2824747-9-ardb+git@google.com>
Subject: [PATCH v3 3/4] x86/boot/64: Determine VA/PA offset before entering C code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>
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
VA-to-PA offset in asm code, using the kernel VA of common_startup_64
(which we already keep in a global variable for other reasons), and pass
it to the C startup code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/setup.h | 2 +-
 arch/x86/kernel/head64.c     | 8 +++++---
 arch/x86/kernel/head_64.S    | 9 ++++++++-
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index e61e68d71cba..aca18be5a228 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -47,7 +47,7 @@ extern unsigned long saved_video_mode;
 
 extern void reserve_standard_io_resources(void);
 extern void i386_reserve_resources(void);
-extern unsigned long __startup_64(unsigned long physaddr, struct boot_params *bp);
+extern unsigned long __startup_64(unsigned long p2v_offset, struct boot_params *bp);
 extern void startup_64_setup_gdt_idt(void);
 extern void early_setup_idt(void);
 extern void __init do_early_exception(struct pt_regs *regs, int trapnr);
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index a817ed0724d1..81696a4967e6 100644
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
index 330922b328bf..d0e494607acc 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -100,13 +100,20 @@ SYM_CODE_START_NOALIGN(startup_64)
 	/* Sanitize CPU configuration */
 	call verify_cpu
 
+	/*
+	 * Use the 1:1 physical and kernel virtual addresses of
+	 * common_startup_64 to determine the physical-to-virtual offset, and
+	 * pass it as the first argument to __startup_64().
+	 */
+	leaq	common_startup_64(%rip), %rdi
+	subq	0f(%rip), %rdi
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
 
-- 
2.45.1.288.g0e0cd299f1-goog


