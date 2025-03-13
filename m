Return-Path: <linux-kernel+bounces-559432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C89A5F3C1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1F763A708E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C33267704;
	Thu, 13 Mar 2025 12:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i6Ns9qxm"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031D92676FF
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741867412; cv=none; b=p7iTVqx4DCr5ZgyI/JeL9+Wqo8R/222XcDeB9bo05nqw2DaRnJK5jpxo2YYTINwwi0MZfxX7Ym652wP2I5DkWoGdmnHtRuTG8p7zQt0rVrNeKxexDfhzxhDwleVWnuobBRJAbYk/B+PRbdL24eBaCq9sAp/sWp+pw4qFq/jZZug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741867412; c=relaxed/simple;
	bh=nx7kpSgxEkJipaAu7lH33GZbYOa0QMfX5491dFO/6+A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=u1i9wMFjBVgrJ0BxkepzOlUzs7GbX4L5JQPah1I/DNiDFtqhjgqxMQiViN5WWGS7ZDFC7LmbJL9yS+wyHPchhNdPhoOVZKmCQiho3x/3MBg31vI74Ea+shxRsCoD+c6rpzramuWBVyhqMeOkqMJe3yOZd26yzxdaFZ6IBNH+fu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i6Ns9qxm; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43ceed237efso6127135e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 05:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741867408; x=1742472208; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fNGl6tGD5/LI4v1f0jD3bPnWJc77BwXptrDpG8yXSs8=;
        b=i6Ns9qxm1YPPCtwiQNSSteCP9l0SbCofJqrs1HOHn/q6Z44lDxZAcSQD72blHn1HIz
         YaLIRexSPaHkzJzcGclkaVg+wBHMwA8JUO+5xNFKxUwOhDdIFPUI3ZhikKb3zjGLPAq5
         ocBcwPGDkOY/ucy4VoOOfZx/SS07pq8z7uukSefWd7Fe8qHs9XlZnu7W2OG9MNxsM2Mb
         Yh7IcMwbxqcz5sHjRkKXfAISn+16eVFFRJma9W4T5bBTvZWFCg24FepXF9gKclZBeLro
         P1Vg+XgvO4jMbkaHI97qS0VQsjKgHHDCcBfSrqNYrCpqB90JbM6Eco2kxOGtD3M8YLyC
         J+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741867408; x=1742472208;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fNGl6tGD5/LI4v1f0jD3bPnWJc77BwXptrDpG8yXSs8=;
        b=F+sF61+5q1FkX6X/Wtqp6eyk081Lcq6VfIl4WJ1AUFfKNBGbg+mUk+wH2Kr6jjU7mj
         VW/03jg0BFIKmpeflu1LPF3R3GVvw1Vh6dNRenbsnpS91mJZfKy4qxXeZzd1B30Kxwx7
         1Y9GUqSjy/msYMIROeimo3UnpKySuzf4w2dOTm0Ms5suk0c1Va6eAauXgDM1FHhmGqwC
         hvwh7E1KjOT5d4s2+niWmywgsYZiAXevMbLqmgTmrbyxBbq0Vsivjbizut31hC/VYBQj
         mryTqtv/0cGdRFY1VeizkB5R3UnIgjNNIdlsjpX2UZ/4LwFz8Fg8RgZkV/oAFVj/nDmV
         ibYw==
X-Gm-Message-State: AOJu0YyDeDeGWJLZxRUxHZ8MWam9bdScqu/u2sguZVgRv4li+z8lSyJL
	Omc3qYmtcavTQAwGCid3rs/zSQJ5y8JdO9/+VDqASjjKt4nK3t86aTC3i5dzMxPITeQiLBvTqc4
	K3kXPAWIo00KrupbT7JCV4gnZ6nkt10queSixHxD0GxHEedmtmdTVBLjCWynfiROpc1afqhWTyn
	RLAPIkCIXUFrNDht5KwV/yiy5vBhB+AQ==
X-Google-Smtp-Source: AGHT+IGbaQbw279LlrN6XOdzYV1KoK/rsvovCoLovn6a8ifig6lTjfFVp+BG1c8yk6V/NaRpaFxs+NFy
X-Received: from wmgg26.prod.google.com ([2002:a05:600d:1a:b0:43c:fa87:4fa0])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4f14:b0:43d:7a:471f
 with SMTP id 5b1f17b1804b1-43d01be7e4bmr119312355e9.18.1741867408404; Thu, 13
 Mar 2025 05:03:28 -0700 (PDT)
Date: Thu, 13 Mar 2025 13:03:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=8328; i=ardb@kernel.org;
 h=from:subject; bh=3N2F4ttRD0JrUTdWNB15JOBmiU3jVNhn6hMerwAVSy8=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf3Syd4vjvOMk+QMb11utO86E/WW2T1m5jzhrfxxoooK7
 jXKJic6SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwEQWKzD8d2r17r0hfbvhyvIp
 t7ssf/81/1cgtuDGpjURC13XRroF1zD8D69+5yUv9NS6N/VCiuH1d29Wh/4tT9c8pSHueP0Dk8w KNgA=
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250313120324.1095968-2-ardb+git@google.com>
Subject: [PATCH] x86/boot: Move LA57 trampoline to separate source file
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

To permit the EFI stub to call this code even when building the kernel
without the legacy decompressor, move the trampoline out of the latter's
startup code.

No functional change intended.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
This is part of an ongoing effort on my part to make the existing,
generic EFI zboot format work on x86 as well. This work is tentatively
aimed for the v6.16 cycle, but some standalone changes such as this one
can be pulled forward to reduce the impact of many boot code changes
landing at once (as this always makes for fun debugging).

 arch/x86/boot/compressed/Makefile     |   1 +
 arch/x86/boot/compressed/head_64.S    | 103 ------------------
 arch/x86/boot/compressed/la57toggle.S | 112 ++++++++++++++++++++
 3 files changed, 113 insertions(+), 103 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 606c74f27459..0e0b238e8363 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -98,6 +98,7 @@ ifdef CONFIG_X86_64
 	vmlinux-objs-$(CONFIG_AMD_MEM_ENCRYPT) += $(obj)/mem_encrypt.o
 	vmlinux-objs-y += $(obj)/pgtable_64.o
 	vmlinux-objs-$(CONFIG_AMD_MEM_ENCRYPT) += $(obj)/sev.o
+	vmlinux-objs-y += $(obj)/la57toggle.o
 endif
 
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 1dcb794c5479..3dc86352cdbe 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -483,110 +483,7 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 	jmp	*%rax
 SYM_FUNC_END(.Lrelocated)
 
-/*
- * This is the 32-bit trampoline that will be copied over to low memory. It
- * will be called using the ordinary 64-bit calling convention from code
- * running in 64-bit mode.
- *
- * Return address is at the top of the stack (might be above 4G).
- * The first argument (EDI) contains the address of the temporary PGD level
- * page table in 32-bit addressable memory which will be programmed into
- * register CR3.
- */
-	.section ".rodata", "a", @progbits
-SYM_CODE_START(trampoline_32bit_src)
-	/*
-	 * Preserve callee save 64-bit registers on the stack: this is
-	 * necessary because the architecture does not guarantee that GPRs will
-	 * retain their full 64-bit values across a 32-bit mode switch.
-	 */
-	pushq	%r15
-	pushq	%r14
-	pushq	%r13
-	pushq	%r12
-	pushq	%rbp
-	pushq	%rbx
-
-	/* Preserve top half of RSP in a legacy mode GPR to avoid truncation */
-	movq	%rsp, %rbx
-	shrq	$32, %rbx
-
-	/* Switch to compatibility mode (CS.L = 0 CS.D = 1) via far return */
-	pushq	$__KERNEL32_CS
-	leaq	0f(%rip), %rax
-	pushq	%rax
-	lretq
-
-	/*
-	 * The 32-bit code below will do a far jump back to long mode and end
-	 * up here after reconfiguring the number of paging levels. First, the
-	 * stack pointer needs to be restored to its full 64-bit value before
-	 * the callee save register contents can be popped from the stack.
-	 */
-.Lret:
-	shlq	$32, %rbx
-	orq	%rbx, %rsp
-
-	/* Restore the preserved 64-bit registers */
-	popq	%rbx
-	popq	%rbp
-	popq	%r12
-	popq	%r13
-	popq	%r14
-	popq	%r15
-	retq
-
 	.code32
-0:
-	/* Disable paging */
-	movl	%cr0, %eax
-	btrl	$X86_CR0_PG_BIT, %eax
-	movl	%eax, %cr0
-
-	/* Point CR3 to the trampoline's new top level page table */
-	movl	%edi, %cr3
-
-	/* Set EFER.LME=1 as a precaution in case hypervsior pulls the rug */
-	movl	$MSR_EFER, %ecx
-	rdmsr
-	btsl	$_EFER_LME, %eax
-	/* Avoid writing EFER if no change was made (for TDX guest) */
-	jc	1f
-	wrmsr
-1:
-	/* Toggle CR4.LA57 */
-	movl	%cr4, %eax
-	btcl	$X86_CR4_LA57_BIT, %eax
-	movl	%eax, %cr4
-
-	/* Enable paging again. */
-	movl	%cr0, %eax
-	btsl	$X86_CR0_PG_BIT, %eax
-	movl	%eax, %cr0
-
-	/*
-	 * Return to the 64-bit calling code using LJMP rather than LRET, to
-	 * avoid the need for a 32-bit addressable stack. The destination
-	 * address will be adjusted after the template code is copied into a
-	 * 32-bit addressable buffer.
-	 */
-.Ljmp:	ljmpl	$__KERNEL_CS, $(.Lret - trampoline_32bit_src)
-SYM_CODE_END(trampoline_32bit_src)
-
-/*
- * This symbol is placed right after trampoline_32bit_src() so its address can
- * be used to infer the size of the trampoline code.
- */
-SYM_DATA(trampoline_ljmp_imm_offset, .word  .Ljmp + 1 - trampoline_32bit_src)
-
-	/*
-         * The trampoline code has a size limit.
-         * Make sure we fail to compile if the trampoline code grows
-         * beyond TRAMPOLINE_32BIT_CODE_SIZE bytes.
-	 */
-	.org	trampoline_32bit_src + TRAMPOLINE_32BIT_CODE_SIZE
-
-	.text
 SYM_FUNC_START_LOCAL_NOALIGN(.Lno_longmode)
 	/* This isn't an x86-64 CPU, so hang intentionally, we cannot continue */
 1:
diff --git a/arch/x86/boot/compressed/la57toggle.S b/arch/x86/boot/compressed/la57toggle.S
new file mode 100644
index 000000000000..9ee002387eb1
--- /dev/null
+++ b/arch/x86/boot/compressed/la57toggle.S
@@ -0,0 +1,112 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/linkage.h>
+#include <asm/segment.h>
+#include <asm/boot.h>
+#include <asm/msr.h>
+#include <asm/processor-flags.h>
+#include "pgtable.h"
+
+/*
+ * This is the 32-bit trampoline that will be copied over to low memory. It
+ * will be called using the ordinary 64-bit calling convention from code
+ * running in 64-bit mode.
+ *
+ * Return address is at the top of the stack (might be above 4G).
+ * The first argument (EDI) contains the address of the temporary PGD level
+ * page table in 32-bit addressable memory which will be programmed into
+ * register CR3.
+ */
+
+	.section ".rodata", "a", @progbits
+SYM_CODE_START(trampoline_32bit_src)
+	/*
+	 * Preserve callee save 64-bit registers on the stack: this is
+	 * necessary because the architecture does not guarantee that GPRs will
+	 * retain their full 64-bit values across a 32-bit mode switch.
+	 */
+	pushq	%r15
+	pushq	%r14
+	pushq	%r13
+	pushq	%r12
+	pushq	%rbp
+	pushq	%rbx
+
+	/* Preserve top half of RSP in a legacy mode GPR to avoid truncation */
+	movq	%rsp, %rbx
+	shrq	$32, %rbx
+
+	/* Switch to compatibility mode (CS.L = 0 CS.D = 1) via far return */
+	pushq	$__KERNEL32_CS
+	leaq	0f(%rip), %rax
+	pushq	%rax
+	lretq
+
+	/*
+	 * The 32-bit code below will do a far jump back to long mode and end
+	 * up here after reconfiguring the number of paging levels. First, the
+	 * stack pointer needs to be restored to its full 64-bit value before
+	 * the callee save register contents can be popped from the stack.
+	 */
+.Lret:
+	shlq	$32, %rbx
+	orq	%rbx, %rsp
+
+	/* Restore the preserved 64-bit registers */
+	popq	%rbx
+	popq	%rbp
+	popq	%r12
+	popq	%r13
+	popq	%r14
+	popq	%r15
+	retq
+
+	.code32
+0:
+	/* Disable paging */
+	movl	%cr0, %eax
+	btrl	$X86_CR0_PG_BIT, %eax
+	movl	%eax, %cr0
+
+	/* Point CR3 to the trampoline's new top level page table */
+	movl	%edi, %cr3
+
+	/* Set EFER.LME=1 as a precaution in case hypervsior pulls the rug */
+	movl	$MSR_EFER, %ecx
+	rdmsr
+	btsl	$_EFER_LME, %eax
+	/* Avoid writing EFER if no change was made (for TDX guest) */
+	jc	1f
+	wrmsr
+1:
+	/* Toggle CR4.LA57 */
+	movl	%cr4, %eax
+	btcl	$X86_CR4_LA57_BIT, %eax
+	movl	%eax, %cr4
+
+	/* Enable paging again. */
+	movl	%cr0, %eax
+	btsl	$X86_CR0_PG_BIT, %eax
+	movl	%eax, %cr0
+
+	/*
+	 * Return to the 64-bit calling code using LJMP rather than LRET, to
+	 * avoid the need for a 32-bit addressable stack. The destination
+	 * address will be adjusted after the template code is copied into a
+	 * 32-bit addressable buffer.
+	 */
+.Ljmp:	ljmpl	$__KERNEL_CS, $(.Lret - trampoline_32bit_src)
+SYM_CODE_END(trampoline_32bit_src)
+
+/*
+ * This symbol is placed right after trampoline_32bit_src() so its address can
+ * be used to infer the size of the trampoline code.
+ */
+SYM_DATA(trampoline_ljmp_imm_offset, .word  .Ljmp + 1 - trampoline_32bit_src)
+
+	/*
+         * The trampoline code has a size limit.
+         * Make sure we fail to compile if the trampoline code grows
+         * beyond TRAMPOLINE_32BIT_CODE_SIZE bytes.
+	 */
+	.org	trampoline_32bit_src + TRAMPOLINE_32BIT_CODE_SIZE
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


