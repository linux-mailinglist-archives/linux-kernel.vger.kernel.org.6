Return-Path: <linux-kernel+bounces-433545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 010AB9E59C6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A54B7282A6A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE95821D59E;
	Thu,  5 Dec 2024 15:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kqMflxyk"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E62F219A8B
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733412842; cv=none; b=ZJDvsclqunyZlRnU7Sc8eFzFYhI54CISY6YpeE3Np6kmQADeOHEfdy7Hdiw9G098x43x1mE8X9Yrb/7K0yhO184tFTYi9f0kvApCqPDEsbBBbDJ5B0aazcfH7+KAORqb/b7Px1+5h2zGZ/cFmOGj6u8G5lmp91Bj4NKZzRKGATo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733412842; c=relaxed/simple;
	bh=d/rcHGFVpabsugcMuJjixlE+qifllnL/bcRd0B7VP1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZOtIU+Z3k2z9mQ/dT9t93oFmP4j2kZeTvmYPqmSaEu//LP6n9Fqj4TZRKBVxeu+hBlFtL0Q2pxAtQ4qKjZ3MBflBaohaESkgsELnyDjH9E4DaXcKLEvJ9HF9b7l6bpYsGcnmBmY5nGQGocr7q3U/QCjwipPdiXPUGnoxXODPcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kqMflxyk; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=XfpEhjmH63kNBWPhAreO4Ksae3ZbgsIvDAhpnywLoo0=; b=kqMflxykmjWVp7vgk+q9LTk3x2
	FydR4yMOa7CqgfuCoP3qpgW/OKTIldOFv0/cXyN7YWYJw2WyLiIFG+EgMkNkrDR3FfsaGIEvEi4/g
	pszLDoz8h84HxPnslRcmGn6Qev9OrqSRESlshDp3pZ3oDReP8Fk7Q9I81o2t/fwRIuzofyjPcChMd
	emQi9pI6ZKxWpxU0jdQ8eUxjJO6l0PJfFkAVMNPpvKB0llDzC78aYI6H12aZYzRRJoA0FG75ViPoY
	J4//l4Mfx8akgHd4XamrDQl8+kQ8wF+pfM5reuxFJgm3Iv/PfSleH/Uahph1wub2CCluKFLXYkkx4
	rTG96sJw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDrO-00000002wF1-0igl;
	Thu, 05 Dec 2024 15:33:46 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDrN-0000000DyMZ-41Z0;
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
Subject: [PATCH v5 19/20] x86/kexec: Add 8250 MMIO serial port output
Date: Thu,  5 Dec 2024 15:05:25 +0000
Message-ID: <20241205153343.3275139-20-dwmw2@infradead.org>
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

This supports the same 32-bit MMIO-mapped 8250 as the early_printk code.

It's not clear why the early_printk code supports this form and only this
form; the actual runtime 8250_pci doesn't seem to support it. But having
hacked up QEMU to expose such a device, early_printk does work with it,
and now so does the kexec debug code.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/kexec.h         |  1 +
 arch/x86/kernel/early_printk.c       |  3 +++
 arch/x86/kernel/machine_kexec_64.c   | 22 ++++++++++++++++++++++
 arch/x86/kernel/relocate_kernel_64.S | 21 +++++++++++++++++++++
 4 files changed, 47 insertions(+)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index f37d2d9fda3f..76843a174947 100644
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
index bf06866ee90a..14f548e095c9 100644
--- a/arch/x86/kernel/early_printk.c
+++ b/arch/x86/kernel/early_printk.c
@@ -296,6 +296,9 @@ static __init void early_pci_serial_init(char *s)
 		/* WARNING! assuming the address is always in the first 4G */
 		early_serial_base =
 			(unsigned long)early_ioremap(bar0 & PCI_BASE_ADDRESS_MEM_MASK, 0x10);
+#ifdef CONFIG_KEXEC_DEBUG
+		kexec_debug_8250_mmio32 = bar0 & PCI_BASE_ADDRESS_MEM_MASK;
+#endif
 		write_pci_config(bus, slot, func, PCI_COMMAND,
 				 cmdreg|PCI_COMMAND_MEMORY);
 	}
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index f9a68c6ec815..18307f3481e6 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -76,6 +76,24 @@ map_acpi_tables(struct x86_mapping_info *info, pgd_t *level4p)
 static int map_acpi_tables(struct x86_mapping_info *info, pgd_t *level4p) { return 0; }
 #endif
 
+#ifdef CONFIG_KEXEC_DEBUG
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
+#else
+static int map_mmio_serial(struct x86_mapping_info *info, pgd_t *level4p) { return 0; }
+#endif
+
+
 #ifdef CONFIG_KEXEC_FILE
 const struct kexec_file_ops * const kexec_file_loaders[] = {
 		&kexec_bzImage64_ops,
@@ -285,6 +303,10 @@ static int init_pgtable(struct kimage *image, unsigned long control_page)
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
index 01a31e4a0664..12001f389d0b 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -38,6 +38,7 @@ SYM_DATA(kexec_va_control_page, .quad 0)
 SYM_DATA(kexec_pa_table_page, .quad 0)
 SYM_DATA(kexec_pa_swap_page, .quad 0)
 SYM_DATA_LOCAL(pa_backup_pages_map, .quad 0)
+SYM_DATA(kexec_debug_8250_mmio32, .quad 0)
 SYM_DATA(kexec_debug_8250_port, .word 0)
 
 #ifdef CONFIG_KEXEC_DEBUG
@@ -394,6 +395,21 @@ pr_char_null:
 	ret
 SYM_CODE_END(pr_char_8250)
 
+SYM_CODE_START_LOCAL_NOALIGN(pr_char_8250_mmio32)
+	UNWIND_HINT_FUNC
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
@@ -404,6 +420,11 @@ SYM_CODE_END(pr_char_8250)
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
2.47.0


