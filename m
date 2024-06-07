Return-Path: <linux-kernel+bounces-206694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A447900CD1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B2AC1C2149E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66B914B076;
	Fri,  7 Jun 2024 20:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lAdxAtL1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L+bpi+80"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE81145B1A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 20:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717791737; cv=none; b=vBGfitE8OZ9JuOUxpEzESOIGSFl1QGeCsnOQKcWIyPQXZPqePKIee3NQQzltTXtHL2BSYqoz9ufXbdpMSsjKBabOXENRLwKxVANFG8dBkRz+iQGRxG40wcVFKNlALIs2YtrymklbViFKsYa9RApfokmoOy1LZTTrrtbHOqqFnGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717791737; c=relaxed/simple;
	bh=AXLhTJOfOZbd5sWTxrT+P/JVlzoYysMbDWuTt1L3jiE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B+Lx4V4CbTJBfGv7MzlKoNckzbp+XqmrNDKl+9MxHsXbmI9GzeqZlIfaj4CE2STkOiGM3ygTfhruYj6OaWutj60ofKqfExhOX8GZLCxjooTynTfFpmAnxsf+z7QwoWCI9YtEFTriMtZtNmdhhFi7yRkS/0C3XM1sqP0frzk4v9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lAdxAtL1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L+bpi+80; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717791734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4odO1GRTROf7xvMWOl3DqpmsPPjSYUQ/pXHn+xOw3Kc=;
	b=lAdxAtL1WO+adL+dYcUMR8vwNa0xTJsBJmhva63AYlFQDh9iB2KmPI0nzI7rctgnpzjFGp
	1+qM69qhVTlhxLRahmln8BYKQ+cwLZp8ErCCWDQkQj8FO2i88zELxECIhL4SdC/Hj0l7gt
	R8qEf3b85XNA9e/c3Pczr06hu/y8zjSn252U827wfpMt8+eaXa1G4ommneqv3SV+x0qbGO
	VNRfEBde7XqQgX8+HepNazsYzG03lw4WOIQEwZvCsxJJzBukiRkumfLWVuI7FG/ky5hfx2
	RSiJVqD4cHzop2bkP4hf+GuicVGkvaa3KFZFVfuz9GASY+igGnOBEFzlJlyh3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717791734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4odO1GRTROf7xvMWOl3DqpmsPPjSYUQ/pXHn+xOw3Kc=;
	b=L+bpi+80qMhsxa1grxAhSboftzk0iStipUSm9Wd4glNMTF1wlfW63xioVkOhA8Hn8lFmca
	mHo+MnwYL/aHfjAw==
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/8] riscv: replace misleading va_kernel_pa_offset on XIP kernel
Date: Fri,  7 Jun 2024 22:22:08 +0200
Message-Id: <84e5d005c1386d88d7b2531e0b6707ec5352ee54.1717789719.git.namcao@linutronix.de>
In-Reply-To: <cover.1717789719.git.namcao@linutronix.de>
References: <cover.1717789719.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On XIP kernel, the name "va_kernel_pa_offset" is misleading: unlike
"normal" kernel, it is not the virtual-physical address offset of kernel
mapping, it is the offset of kernel mapping's first virtual address to
first physical address in DRAM, which is not meaningful because the
kernel's first physical address is not in DRAM.

For XIP kernel, there are 2 different offsets because the read-only part of
the kernel resides in ROM while the rest is in RAM. The offset to ROM is in
kernel_map.va_kernel_xip_pa_offset, while the offset to RAM is not stored
anywhere: it is calculated on-the-fly.

Remove this confusing "va_kernel_pa_offset" and add
"va_kernel_xip_data_pa_offset" as its replacement. This new variable is the
offset of virtual mapping of the kernel's data portion to the corresponding
physical addresses.

With the introduction of this new variable, also rename
va_kernel_xip_pa_offset -> va_kernel_xip_text_pa_offset to make it clear
that this one is about the .text section.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/page.h | 29 +++++++++++++++++++++--------
 arch/riscv/mm/init.c          |  6 ++++--
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 115ac98b8d72..b1fcf0d733c4 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -112,11 +112,13 @@ struct kernel_mapping {
 	/* Offset between linear mapping virtual address and kernel load address */
 	unsigned long va_pa_offset;
 	/* Offset between kernel mapping virtual address and kernel load address */
-	unsigned long va_kernel_pa_offset;
-	unsigned long va_kernel_xip_pa_offset;
 #ifdef CONFIG_XIP_KERNEL
+	unsigned long va_kernel_xip_text_pa_offset;
+	unsigned long va_kernel_xip_data_pa_offset;
 	uintptr_t xiprom;
 	uintptr_t xiprom_sz;
+#else
+	unsigned long va_kernel_pa_offset;
 #endif
 };
 
@@ -134,12 +136,18 @@ extern phys_addr_t phys_ram_base;
 #else
 void *linear_mapping_pa_to_va(unsigned long x);
 #endif
+
+#ifdef CONFIG_XIP_KERNEL
 #define kernel_mapping_pa_to_va(y)	({					\
 	unsigned long _y = (unsigned long)(y);					\
-	(IS_ENABLED(CONFIG_XIP_KERNEL) && _y < phys_ram_base) ?			\
-		(void *)(_y + kernel_map.va_kernel_xip_pa_offset) :		\
-		(void *)(_y + kernel_map.va_kernel_pa_offset + XIP_OFFSET);	\
+	(_y < phys_ram_base) ?							\
+		(void *)(_y + kernel_map.va_kernel_xip_text_pa_offset) :	\
+		(void *)(_y + kernel_map.va_kernel_xip_data_pa_offset);		\
 	})
+#else
+#define kernel_mapping_pa_to_va(y) ((void *)((unsigned long)(y) + kernel_map.va_kernel_pa_offset))
+#endif
+
 #define __pa_to_va_nodebug(x)		linear_mapping_pa_to_va(x)
 
 #ifndef CONFIG_DEBUG_VIRTUAL
@@ -147,12 +155,17 @@ void *linear_mapping_pa_to_va(unsigned long x);
 #else
 phys_addr_t linear_mapping_va_to_pa(unsigned long x);
 #endif
+
+#ifdef CONFIG_XIP_KERNEL
 #define kernel_mapping_va_to_pa(y) ({						\
 	unsigned long _y = (unsigned long)(y);					\
-	(IS_ENABLED(CONFIG_XIP_KERNEL) && _y < kernel_map.virt_addr + XIP_OFFSET) ? \
-		(_y - kernel_map.va_kernel_xip_pa_offset) :			\
-		(_y - kernel_map.va_kernel_pa_offset - XIP_OFFSET);		\
+	(_y < kernel_map.virt_addr + XIP_OFFSET) ?				\
+		(_y - kernel_map.va_kernel_xip_text_pa_offset) :		\
+		(_y - kernel_map.va_kernel_xip_data_pa_offset);			\
 	})
+#else
+#define kernel_mapping_va_to_pa(y) ((unsigned long)(y) - kernel_map.va_kernel_pa_offset)
+#endif
 
 #define __va_to_pa_nodebug(x)	({						\
 	unsigned long _x = x;							\
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 28f9c37443c8..313459329d16 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1092,11 +1092,14 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	kernel_map.phys_addr = (uintptr_t)CONFIG_PHYS_RAM_BASE;
 	kernel_map.size = (uintptr_t)(&_end) - (uintptr_t)(&_start);
 
-	kernel_map.va_kernel_xip_pa_offset = kernel_map.virt_addr - kernel_map.xiprom;
+	kernel_map.va_kernel_xip_text_pa_offset = kernel_map.virt_addr - kernel_map.xiprom;
+	kernel_map.va_kernel_xip_data_pa_offset = kernel_map.virt_addr - kernel_map.phys_addr
+						+ (uintptr_t)&_sdata - (uintptr_t)&_start;
 #else
 	kernel_map.page_offset = _AC(CONFIG_PAGE_OFFSET, UL);
 	kernel_map.phys_addr = (uintptr_t)(&_start);
 	kernel_map.size = (uintptr_t)(&_end) - kernel_map.phys_addr;
+	kernel_map.va_kernel_pa_offset = kernel_map.virt_addr - kernel_map.phys_addr;
 #endif
 
 #if defined(CONFIG_64BIT) && !defined(CONFIG_XIP_KERNEL)
@@ -1118,7 +1121,6 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	 */
 	kernel_map.va_pa_offset = IS_ENABLED(CONFIG_64BIT) ?
 				0UL : PAGE_OFFSET - kernel_map.phys_addr;
-	kernel_map.va_kernel_pa_offset = kernel_map.virt_addr - kernel_map.phys_addr;
 
 	/*
 	 * The default maximal physical memory size is KERN_VIRT_SIZE for 32-bit
-- 
2.39.2


