Return-Path: <linux-kernel+bounces-577107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82193A71864
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98DEB7A39B2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3691F239B;
	Wed, 26 Mar 2025 14:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ihBfG6LF"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C824A29
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 14:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742999062; cv=none; b=VGD/u3Fm7STWvUThlIhS6c27d3CVfGgq7K76OC40AwZFodgWd6+YIX7CL7C4VoHlx6cpQvFvT6hDqrJpz9J8hR/XhiFCdq+lDmOz6GJKE5UfxS1v968rx8yokVffmD3rJNxns10Fy/tMU2CMr+dFUBzkjTjAwtQIC2/F8z/G4X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742999062; c=relaxed/simple;
	bh=JDICYBBBEqK2mxI6tNT3Xlbx5yX6kASUL5PXpHSj9rU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CwhPGWwyrCAAoSuOnU5a4nlL2m+wsXrLzFtGeIzQP35jCsedrVKTccdA0TSgUWawuD7GaOnzrkt8uNXsH7tw5fVwZpS7Vmw0hQCES3yFKY/hMF8qulrw+ICiRLFnYwT0FM6iBC6h4gQ3umRX28MFJC+5bP23LLiTSJ8BNpP1wUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ihBfG6LF; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=yk/3sFewOE8EhIIKk8WOQXeNRX9bKeatD8VLAtRoVvA=; b=ihBfG6LFHcgoYlBL5qr1qJ20U3
	hcA7QIyGlUNUYAhNAVgyq8yvVptqZcyvMINl7lfV4MjI90h3HJsfKfzMikfyqxmM8ta2sMQ3VXnhi
	6Nk1bcmLDK9+NyVnbL9iCgMmumEKxmc/khkwOfnkv2Eiyez28k4Ex/gEe0gMvY02dd9FDrv6onFxh
	C8d4IttkFFfmKN2L3U+Xn5sqUOEht6hmfuYTNe+nm4JlcMxPq0xR2Jcg1/T9KKijKEVMzBUvN9vmz
	0/Ev/6UAqS3cE1VcjZ3lPI30u6BBdNb0q9Z8+03Z0Oq11lG/rwgKk3ukjiEIuWdDeKEF2weSzrG8b
	gDQne/qg==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txRfr-00000005oet-0Vkx;
	Wed, 26 Mar 2025 14:24:07 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1txRfq-00000001A9I-1zxT;
	Wed, 26 Mar 2025 14:24:06 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kexec@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	jpoimboe@kernel.org,
	bsz@amazon.de
Subject: [PATCH v9 1/4] x86/kexec: Add 8250 serial port output
Date: Wed, 26 Mar 2025 14:16:01 +0000
Message-ID: <20250326142404.256980-2-dwmw2@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250326142404.256980-1-dwmw2@infradead.org>
References: <20250326142404.256980-1-dwmw2@infradead.org>
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

If a serial port was configured for early_printk, use it for debug output
from the relocate_kernel exception handler too.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/kexec.h         |  1 +
 arch/x86/kernel/early_printk.c       |  6 +++++
 arch/x86/kernel/relocate_kernel_64.S | 39 +++++++++++++++++++++++-----
 3 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index fb4537c58b54..9601094ac0ba 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -64,6 +64,7 @@ extern unsigned long kexec_pa_table_page;
 extern unsigned long kexec_pa_swap_page;
 extern gate_desc kexec_debug_idt[];
 extern unsigned char kexec_debug_exc_vectors[];
+extern uint16_t kexec_debug_8250_port;
 #endif
 
 /*
diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_printk.c
index fc1714bad045..b756ebcbd827 100644
--- a/arch/x86/kernel/early_printk.c
+++ b/arch/x86/kernel/early_printk.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/console.h>
 #include <linux/kernel.h>
+#include <linux/kexec.h>
 #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/screen_info.h>
@@ -144,6 +145,11 @@ static __init void early_serial_hw_init(unsigned divisor)
 	static_call(serial_out)(early_serial_base, DLL, divisor & 0xff);
 	static_call(serial_out)(early_serial_base, DLH, (divisor >> 8) & 0xff);
 	static_call(serial_out)(early_serial_base, LCR, c & ~DLAB);
+
+#if defined(CONFIG_KEXEC_CORE) && defined(CONFIG_X86_64)
+	if (static_call_query(serial_in) == io_serial_in)
+		kexec_debug_8250_port = early_serial_base;
+#endif
 }
 
 #define DEFAULT_BAUD 9600
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 29cb399a34d4..21011cd19c48 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -39,6 +39,7 @@ SYM_DATA(kexec_va_control_page, .quad 0)
 SYM_DATA(kexec_pa_table_page, .quad 0)
 SYM_DATA(kexec_pa_swap_page, .quad 0)
 SYM_DATA_LOCAL(pa_backup_pages_map, .quad 0)
+SYM_DATA(kexec_debug_8250_port, .word 0)
 
 	.balign 16
 SYM_DATA_START_LOCAL(kexec_debug_gdt)
@@ -380,24 +381,50 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 SYM_CODE_END(swap_pages)
 
 /*
- * Generic 'print character' routine (as yet unimplemented)
+ * Generic 'print character' routine
  *  - %al: Character to be printed (may clobber %rax)
  *  - %rdx: MMIO address or port.
  */
-SYM_CODE_START_LOCAL_NOALIGN(pr_char)
+#define XMTRDY          0x20
+
+#define TXR             0       /*  Transmit register (WRITE) */
+#define LSR             5       /*  Line Status               */
+
+SYM_CODE_START_LOCAL_NOALIGN(pr_char_8250)
 	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR
+	addw	$LSR, %dx
+	xchg	%al, %ah
+.Lxmtrdy_loop:
+	inb	%dx, %al
+	testb	$XMTRDY, %al
+	jnz	.Lready
+	rep nop
+	jmp .Lxmtrdy_loop
+
+.Lready:
+	subw	$LSR, %dx
+	xchg	%al, %ah
+	outb	%al, %dx
+pr_char_null:
+	ANNOTATE_NOENDBR
+
 	ANNOTATE_UNRET_SAFE
 	ret
-SYM_CODE_END(pr_char)
+SYM_CODE_END(pr_char_8250)
 
 /*
  * Load pr_char function pointer into %rsi and load %rdx with whatever
  * that function wants to see there (typically port/MMIO address).
  */
-.macro	pr_setup
-	/* No output; pr_char just returns */
-	leaq	pr_char(%rip), %rsi
+.macro pr_setup
+	leaq	pr_char_8250(%rip), %rsi
+	movw	kexec_debug_8250_port(%rip), %dx
+	testw	%dx, %dx
+	jnz	1f
+
+	leaq	pr_char_null(%rip), %rsi
+1:
 .endm
 
 /* Print the nybble in %bl, clobber %rax */
-- 
2.48.1


