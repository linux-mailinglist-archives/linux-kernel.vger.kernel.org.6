Return-Path: <linux-kernel+bounces-433550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6989E59CD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39C001885676
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9C522258E;
	Thu,  5 Dec 2024 15:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HbuxAzcv"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8EE21A425
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733412843; cv=none; b=B45Cczjc2f5R/y2o9XljDDG0bcXpKXcLdM4RQ0Z9NGLHYLfEnQAAgjV6SkMFONzBS6cbTeFUAAy7cI7NEUzMHW4YUu/ukJ7O7snVFvW5GxRxGBVi5EfW9hOikoda2Z0UKuVRxFWOYjxKlniRE6R3CQDxPkZifk72dx3KQ/dNyxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733412843; c=relaxed/simple;
	bh=QJxzlm/nn8Yq8Tsj0Zor4e8z8UaVsFNQs4U9DwetKYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SdSzjLTKzWEhNUUtgn5uTDVKz3EUyxuGmCRAVQhj/zeeJtFzrDmaYHm4OAFfexZxbiSb9R324nA1I0J9cShpCqD8IqzRnR/hG/DC+1Q4F1mJhr9Lfd/2UFNEiSez3f9oEjzNfJAEDRf1i3mpJ8lgl4M+ik5KbFK2hDIly29R9tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HbuxAzcv; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=uDB0B/y8BEIJAdSME/L53tegScvP1ehfXftaZ5ENwBE=; b=HbuxAzcvCqgu1FNHrdyDdXlOty
	G2S21AHOBLt7BRpjnXpVDN/RYVqTvMmJZEizd8rICM3T3sg4LT8i/ROehao65+EYgI9c7tlolq841
	NOcC4/o6Phlhx7bZjdMG2l1D+Us/1rLVHvxJn4Rhv0RIjDCqVR6L9rSsSFXxvdFs9JK4Lc96nZ5p9
	QPsIjaW54Wm5BcDLxOmAhRMX+UVy19xDc6FmZCEHPhjssL0k1xMvHAw56fBQJW30cCCZYb/DGYVpf
	QLea1vNyCaDD7x8GAjxx3/rglzUlaPqu0Y3MTD37RnOXEWVkDEBFPW2Q7QKXTg3xySfovcyBJ9RMo
	6mAJQ4+A==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDrO-00000002wF0-0lhX;
	Thu, 05 Dec 2024 15:33:46 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDrN-0000000DyMV-3szs;
	Thu, 05 Dec 2024 15:33:45 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kexec@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	jpoimboe@kernel.org,
	bsz@amazon.de
Subject: [PATCH v5 18/20] x86/kexec: Add 8250 serial port output
Date: Thu,  5 Dec 2024 15:05:24 +0000
Message-ID: <20241205153343.3275139-19-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241205153343.3275139-1-dwmw2@infradead.org>
References: <20241205153343.3275139-1-dwmw2@infradead.org>
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
 arch/x86/kernel/relocate_kernel_64.S | 37 +++++++++++++++++++++++-----
 3 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index c14b0a2704c0..f37d2d9fda3f 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -63,6 +63,7 @@ extern unsigned long kexec_pa_table_page;
 extern unsigned long kexec_pa_swap_page;
 extern gate_desc kexec_debug_idt[];
 extern unsigned char kexec_debug_exc_vectors[];
+extern uint16_t kexec_debug_8250_port;
 #endif
 
 /*
diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_printk.c
index 44f937015e1e..bf06866ee90a 100644
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
@@ -141,6 +142,11 @@ static __init void early_serial_hw_init(unsigned divisor)
 	serial_out(early_serial_base, DLL, divisor & 0xff);
 	serial_out(early_serial_base, DLH, (divisor >> 8) & 0xff);
 	serial_out(early_serial_base, LCR, c & ~DLAB);
+
+#ifdef CONFIG_KEXEC_DEBUG
+	if (serial_in == io_serial_in)
+		kexec_debug_8250_port = early_serial_base;
+#endif
 }
 
 #define DEFAULT_BAUD 9600
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index cd349b6d34a7..01a31e4a0664 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -38,6 +38,7 @@ SYM_DATA(kexec_va_control_page, .quad 0)
 SYM_DATA(kexec_pa_table_page, .quad 0)
 SYM_DATA(kexec_pa_swap_page, .quad 0)
 SYM_DATA_LOCAL(pa_backup_pages_map, .quad 0)
+SYM_DATA(kexec_debug_8250_port, .word 0)
 
 #ifdef CONFIG_KEXEC_DEBUG
 	.balign 16
@@ -364,23 +365,47 @@ SYM_CODE_END(swap_pages)
 
 #ifdef CONFIG_KEXEC_DEBUG
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
2.47.0


