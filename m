Return-Path: <linux-kernel+bounces-421403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 844C39D8AEE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78949167822
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FDD1B85FD;
	Mon, 25 Nov 2024 17:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W1vqJR2F"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2541B6D1A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 17:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732554275; cv=none; b=QhTJSHTaJvp8TeW/eJn8Qazue/HAdkD9QW9xYH//2l2+S4oImk10vGB5NRTSMze0boi8amHMMevXl8QLiFfAt2YDo6FnitR5IA5SxgTnmoFBdiHUfTVkgrQWY1mGJ0bq+29y7BnqlrU76+RGf9hUNPrOJR+60ezHP5VMoQXIl6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732554275; c=relaxed/simple;
	bh=+3dHa0hesP3zVtBbYkDZG9KKwxOD9MHtJYJmD3szKeg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NEPUyfNagLOz0Zt3hWocxjE85qm4LAgCR9niAM+tqfQv90JcOb6gj9DVsT9lRp6XJh9ztgSrv56faxgXz1i+UTZAvuyqMIgrxPeVFniZGf4Dlpd5I1PPCh61kueiLA8vr8HF/OfMBl+fnPASOPftQgPhBaW12AFNWKUywVklrwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W1vqJR2F; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4349d895ef8so15109035e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732554272; x=1733159072; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y6PR1dk2h7+IF5koNJ9Hiduy7O2xkuw2TgrVl4Qj2oc=;
        b=W1vqJR2FL0oqxepNwERVDkkLNhyYD31Gvi8WL6UmakuSvKtnP6nPcbyePwu/KVEBRT
         scW/Ba87QC1p17mEWrpFyuciqa0ae9nQXB3pyFNO2mgzlaCks71UIREKk+jYv2t2o7OK
         e1v72Nl9/3+web8uAEMeoKo43+dSxA+QLpHyTNLy2ul2lUcpnvW0S51FrlTLRF8Z3J9d
         rJOPlqdMwwjXwjJToJdm9wNcaW1fOBoHvguFKEj5QxL9KA5T0KRomMhOw185HxS+Fbpk
         sFATmItR61WrERnhhhBrtiaPn0ihFYLryb14luzUOyjeUpQGlUf/4g4gsN2I6H/JPc4g
         xdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732554272; x=1733159072;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y6PR1dk2h7+IF5koNJ9Hiduy7O2xkuw2TgrVl4Qj2oc=;
        b=J+0wKuLwfwVeJRb30+pGbqEtrq4a8BCySTKueADtJn6vZkRJVAWH+Th3b0SHcg7RWK
         EtvbPVhAuMJGQ0KoQdv6otFo//Ozgl9nS67Ir8LjhfCpSkyQ225qyWkx3jfnc8QsOAb6
         0jIyNBShQKKzkVKNqqszuqGrtmx32Py+DEtOOL4mYizE2HYNSxKVK7D8SGnH3av1qiom
         Q/QT8BEEzDWKkBHdt+cEZDfV/ETIWVv4ALxc3Uk7EYJTknuFs4Y43gmMBquk3DgpcLtK
         G+xwglISS4zPU3Pc2+1a4hOqfsFdfRBy51CPi6ambDcKbE0hDdFPefJ3x3Q4+4tiC8Md
         pWxw==
X-Gm-Message-State: AOJu0YxUFfINYuGVlTgDQqGYiYgRm/DwwxJ/SKI3fBJbHptg1QYNfynJ
	uBIg9ZdjpoP+8novYY7kdN2InWBqZ64yIwKUaHytj1wj+jQtDaRevekMHo4DKoGAoIOb0zczz9r
	3Xg7dnqlpdSYLCGOfDR7jZB1coYqkeOh9qA0d09PjeNbAlglwkFQ7R448eAE+YeX+q+xbAGumie
	hI+0Obm+qcAZ2ZiRFPp7WGb+1e3+m83g==
X-Google-Smtp-Source: AGHT+IHP/NfhOhOrMDpf+TJ/kJJDjJ4W/zFPBBtT1lbimX0fLXAfhJvcsmfNT0bKOvkLGBIyW/57OTxL
X-Received: from wmjl17.prod.google.com ([2002:a7b:c351:0:b0:42c:b336:8685])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:c8f:b0:434:a30b:5445
 with SMTP id 5b1f17b1804b1-434a30b56b9mr14528815e9.19.1732554272190; Mon, 25
 Nov 2024 09:04:32 -0800 (PST)
Date: Mon, 25 Nov 2024 18:04:13 +0100
In-Reply-To: <20241125170411.1898410-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241125170411.1898410-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4688; i=ardb@kernel.org;
 h=from:subject; bh=oV7ao4he/61YWKCmBuI5DWPftgeMewLh5oG5147CmG8=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JId1lHd8Z7aXhB1w49mSIWwvXlTIzdaWu/7wgPPN8gYfA8
 fPnXm3oKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABM5eoyR4azSy1S97ycVn8Qb
 ykQ9SF/ZHee99Yv5l7zsWiMeBzfmfQz/i++pxgkXHn676wXPAUFB2Qomc8WGn6Z8j487bbn29HI VBwA=
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241125170411.1898410-10-ardb+git@google.com>
Subject: [PATCH v3 2/6] x86/boot/64: Determine VA/PA offset before entering C code
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
2.47.0.371.ga323438b13-goog


