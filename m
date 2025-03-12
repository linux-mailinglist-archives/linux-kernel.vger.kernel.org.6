Return-Path: <linux-kernel+bounces-557922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34683A5DF56
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0B8E1899314
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752392571CA;
	Wed, 12 Mar 2025 14:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FiU4biJp"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D3125179D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741790598; cv=none; b=ttA16ejpGcPz+P6xYtw1YQPj3YIpVGGQ+rYq2QnzWnYh8UQfhxdqsH8yYx4b2SsTeg0qUE+WxNMI9DC4MDXwfuYzoNJX8UCfvWFpNEtw1o/KV5oUGfYDQq6MlBQrVK2PJVjfy3xEpK/D9m/O56N7nhvYnbq8Txr+2N5oveLVl0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741790598; c=relaxed/simple;
	bh=5Y26vNPJ7YfI7L2/bhUr/ij6Re3ySlapDUP9XlHgqiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=StFb2CiPSK28JaJPgfY7x1Os7bjZFka6BUn8Ny6puUMPh1gjTmCxJ7Y5+nnZdGIIF+2krqJE6HoJJoRuLklN3B2zIJt36Wd2riol5InnmziLDMooUYJ0aH/K5WoZCwG3xZ6Ta3OdcX5z3JMUi+7dq9NIYqzVRNKxbAvIIl9RGfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FiU4biJp; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=mkqpwbuf7ByU0xfvlRvrXlds+3LpjxULaClXMZ1zD6k=; b=FiU4biJpxiyp8NJeFDNSNgrH3O
	tZnDWg2pd+US5yJl7J7G/fdhOCFvrmwCKCx/v9/cGvWAFcWHyr2GuUcBrF9xTAkZ/f9FipgPLz3hp
	rBB35afcY3rYtGPSQJ3BC3CHWsIWm1PmFmYQa23ycqxdcI7GHNr84vm241nQ79x2LUQ68fjx4SZFE
	iFl+VV92LrZDfRid6fIafgn4UYd30eaSp8RooFX+wjZdIyKSJFrTZaqM5yE7u5m3/rx6kvuz7VMBX
	yZiAu6ts2ua2zzxysEGCMdzhN9yojTnNRGcEtsfPdyigagyDGnBL1xT2k8uZnXFwxu4UV4yz6yGKx
	aRQigbmw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tsNIS-00000002QEr-2cQq;
	Wed, 12 Mar 2025 14:43:00 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsNIR-00000009uUV-2Th4;
	Wed, 12 Mar 2025 14:42:59 +0000
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
Subject: [PATCH v7 5/8] x86/kexec: Add 8250 MMIO serial port output
Date: Wed, 12 Mar 2025 14:34:17 +0000
Message-ID: <20250312144257.2348250-6-dwmw2@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312144257.2348250-1-dwmw2@infradead.org>
References: <20250312144257.2348250-1-dwmw2@infradead.org>
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

This supports the same 32-bit MMIO-mapped 8250 as the early_printk code.

It's not clear why the early_printk code supports this form and only this
form; the actual runtime 8250_pci doesn't seem to support it. But having
hacked up QEMU to expose such a device, early_printk does work with it,
and now so does the kexec debug code.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/kexec.h         |  1 +
 arch/x86/kernel/early_printk.c       |  3 +++
 arch/x86/kernel/machine_kexec_64.c   | 17 +++++++++++++++++
 arch/x86/kernel/relocate_kernel_64.S | 22 ++++++++++++++++++++++
 4 files changed, 43 insertions(+)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 8cbdb6fd10c2..5081d0b9e290 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -64,6 +64,7 @@ extern unsigned long kexec_pa_swap_page;
 extern gate_desc kexec_debug_idt[];
 extern unsigned char kexec_debug_exc_vectors[];
 extern uint16_t kexec_debug_8250_port;
+extern unsigned long kexec_debug_8250_mmio32;
 #endif
 
 /*
diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_printk.c
index ed4e8d0218ad..989117b2d455 100644
--- a/arch/x86/kernel/early_printk.c
+++ b/arch/x86/kernel/early_printk.c
@@ -296,6 +296,9 @@ static __init void early_pci_serial_init(char *s)
 		/* WARNING! assuming the address is always in the first 4G */
 		early_serial_base =
 			(unsigned long)early_ioremap(bar0 & PCI_BASE_ADDRESS_MEM_MASK, 0x10);
+#ifdef CONFIG_KEXEC_CORE
+		kexec_debug_8250_mmio32 = bar0 & PCI_BASE_ADDRESS_MEM_MASK;
+#endif
 		write_pci_config(bus, slot, func, PCI_COMMAND,
 				 cmdreg|PCI_COMMAND_MEMORY);
 	}
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index faf2fb1cd9f6..a2e00a814708 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -76,6 +76,19 @@ map_acpi_tables(struct x86_mapping_info *info, pgd_t *level4p)
 static int map_acpi_tables(struct x86_mapping_info *info, pgd_t *level4p) { return 0; }
 #endif
 
+static int map_mmio_serial(struct x86_mapping_info *info, pgd_t *level4p)
+{
+	unsigned long mstart, mend;
+
+	if (!kexec_debug_8250_mmio32)
+		return 0;
+
+	mstart = kexec_debug_8250_mmio32 & PAGE_MASK;
+	mend = (kexec_debug_8250_mmio32 + PAGE_SIZE + 23) & PAGE_MASK;
+	pr_info("Map PCI serial at %lx - %lx\n", mstart, mend);
+	return kernel_ident_mapping_init(info, level4p, mstart, mend);
+}
+
 #ifdef CONFIG_KEXEC_FILE
 const struct kexec_file_ops * const kexec_file_loaders[] = {
 		&kexec_bzImage64_ops,
@@ -285,6 +298,10 @@ static int init_pgtable(struct kimage *image, unsigned long control_page)
 	if (result)
 		return result;
 
+	result = map_mmio_serial(&info, image->arch.pgd);
+	if (result)
+		return result;
+
 	/*
 	 * This must be last because the intermediate page table pages it
 	 * allocates will not be control pages and may overlap the image.
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index a51b9340934b..d58b4686645c 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -39,6 +39,7 @@ SYM_DATA(kexec_va_control_page, .quad 0)
 SYM_DATA(kexec_pa_table_page, .quad 0)
 SYM_DATA(kexec_pa_swap_page, .quad 0)
 SYM_DATA_LOCAL(pa_backup_pages_map, .quad 0)
+SYM_DATA(kexec_debug_8250_mmio32, .quad 0)
 SYM_DATA(kexec_debug_8250_port, .word 0)
 
 	.balign 16
@@ -413,6 +414,22 @@ pr_char_null:
 	ret
 SYM_CODE_END(pr_char_8250)
 
+SYM_CODE_START_LOCAL_NOALIGN(pr_char_8250_mmio32)
+	UNWIND_HINT_FUNC
+	ANNOTATE_NOENDBR
+.Lxmtrdy_loop_mmio:
+	movb	(LSR*4)(%rdx), %ah
+	testb	$XMTRDY, %ah
+	jnz	.Lready_mmio
+	rep nop
+	jmp .Lxmtrdy_loop_mmio
+
+.Lready_mmio:
+	movb	%al, (%rdx)
+	ANNOTATE_UNRET_SAFE
+	ret
+SYM_CODE_END(pr_char_8250_mmio32)
+
 /*
  * Load pr_char function pointer into %rsi and load %rdx with whatever
  * that function wants to see there (typically port/MMIO address).
@@ -423,6 +440,11 @@ SYM_CODE_END(pr_char_8250)
 	testw	%dx, %dx
 	jnz	1f
 
+	leaq	pr_char_8250_mmio32(%rip), %rsi
+	movq	kexec_debug_8250_mmio32(%rip), %rdx
+	testq	%rdx, %rdx
+	jnz	1f
+
 	leaq	pr_char_null(%rip), %rsi
 1:
 .endm
-- 
2.48.1


