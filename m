Return-Path: <linux-kernel+bounces-409303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC689C8B1C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2B5F1F22599
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220A21FB725;
	Thu, 14 Nov 2024 12:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="ioLlK1DT"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6F91FAF0C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 12:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731588689; cv=none; b=fhrGFu6AQl9kDEK3k0M3GXUgtfQ1GSvb5csy0kH8v8TF6/u9AfMo0HHnJhQ7eL3QayL3UkOyiVFhUoQtshytGLxAieVAQ6ab2+JLntxzMdJ66ojJDFKI/kYBdGvuMFjIVQP3JX159JnmBhyofA7ssrM0lYScHNBLOPxpR7+MuWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731588689; c=relaxed/simple;
	bh=XYF+Jnil2ipEysLiLqivNVxzn4YZlKyQ0lUgP+c+KoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VV7oqlQAoknl2rVnqdNmrX92LG44d2U+6qxXgbu0lWJg8gKvFEa/r4VvxwLMLeRAE797PX9fxgEftD4eEb8K2zck2GjP6dm8eCe15vdToVN8JEYo0+8/0Gm8N6e+Tkk2wQiDJy3p1yEpbEel/2gh4Y1tG+5EOYSIeCuURWkdGn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=ioLlK1DT; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731588681;
	bh=KNw9mp3a3oIXwNqDLpHVNtTGvOCQgwVdDAscbVGZevI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ioLlK1DTpi7iAELxSsPvi6d/T/OipIm2QNlHta45suT+oxgbJJGzzZ4UoMjsxxdoc
	 hd7j0nyjD5C+DKMr8+vvlPLI/6ox3KKZLd2lAVQUL2tRECB66FZyCwdLAa0o0OyQav
	 SV6Qod91JJGEAKau2eVOSDiCgRvyliZ+uh01CRQxIwoEgBwgqvuZn+ye7hbf2baSwP
	 iZdxHPqWzhQlQESoOXmQAaSDWHg+pPXsllq+OxB842mCbXIns2cXT7SYOYRYXGVWfh
	 z6HS6PMr67RoRcw281pcz24VsF2pXcq3nBT1tcMK/FdWjSkW15IzCPTs7hBo4fQ67j
	 VtCpO/YqcfajA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xq0QK4b0nz4xSX;
	Thu, 14 Nov 2024 23:51:21 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Cc: <linux-kernel@vger.kernel.org>,
	<jk@ozlabs.org>,
	<arnd@arndb.de>,
	<geoff@infradead.org>
Subject: [RFC PATCH 10/20] powerpc/io: Remove PPC_INDIRECT_MMIO
Date: Thu, 14 Nov 2024 23:50:59 +1100
Message-ID: <20241114125111.599093-10-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114125111.599093-1-mpe@ellerman.id.au>
References: <20241114125111.599093-1-mpe@ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Cell blade support was the last user of PPC_INDIRECT_MMIO, so it can
now be removed.

PPC_INDIRECT_PIO is still used by Power8 powernv, so it needs to remain.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/io.h  | 58 +++-------------------------------
 arch/powerpc/kernel/setup_64.c |  2 +-
 arch/powerpc/platforms/Kconfig |  3 --
 3 files changed, 6 insertions(+), 57 deletions(-)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index fd92ac450169..fcb4ecca30a4 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -65,8 +65,8 @@ extern resource_size_t isa_mem_base;
 extern bool isa_io_special;
 
 #ifdef CONFIG_PPC32
-#if defined(CONFIG_PPC_INDIRECT_PIO) || defined(CONFIG_PPC_INDIRECT_MMIO)
-#error CONFIG_PPC_INDIRECT_{PIO,MMIO} are not yet supported on 32 bits
+#ifdef CONFIG_PPC_INDIRECT_PIO
+#error CONFIG_PPC_INDIRECT_PIO is not yet supported on 32 bits
 #endif
 #endif
 
@@ -261,9 +261,9 @@ extern void _memcpy_toio(volatile void __iomem *dest, const void *src,
  * for PowerPC is as close as possible to the x86 version of these, and thus
  * provides fairly heavy weight barriers for the non-raw versions
  *
- * In addition, they support a hook mechanism when CONFIG_PPC_INDIRECT_MMIO
- * or CONFIG_PPC_INDIRECT_PIO are set allowing the platform to provide its
- * own implementation of some or all of the accessors.
+ * In addition, they support a hook mechanism when CONFIG_PPC_INDIRECT_PIO
+ * is set allowing the platform to provide its own implementation of some
+ * of the accessors.
  */
 
 /*
@@ -277,51 +277,7 @@ extern void _memcpy_toio(volatile void __iomem *dest, const void *src,
 /* Shortcut to the MMIO argument pointer */
 #define PCI_IO_ADDR	volatile void __iomem *
 
-/* Indirect IO address tokens:
- *
- * When CONFIG_PPC_INDIRECT_MMIO is set, the platform can provide hooks
- * on all MMIOs. (Note that this is all 64 bits only for now)
- *
- * To help platforms who may need to differentiate MMIO addresses in
- * their hooks, a bitfield is reserved for use by the platform near the
- * top of MMIO addresses (not PIO, those have to cope the hard way).
- *
- * The highest address in the kernel virtual space are:
- *
- *  d0003fffffffffff	# with Hash MMU
- *  c00fffffffffffff	# with Radix MMU
- *
- * The top 4 bits are reserved as the region ID on hash, leaving us 8 bits
- * that can be used for the field.
- *
- * The direct IO mapping operations will then mask off those bits
- * before doing the actual access, though that only happen when
- * CONFIG_PPC_INDIRECT_MMIO is set, thus be careful when you use that
- * mechanism
- *
- * For PIO, there is a separate CONFIG_PPC_INDIRECT_PIO which makes
- * all PIO functions call through a hook.
- */
-
-#ifdef CONFIG_PPC_INDIRECT_MMIO
-#define PCI_IO_IND_TOKEN_SHIFT	52
-#define PCI_IO_IND_TOKEN_MASK	(0xfful << PCI_IO_IND_TOKEN_SHIFT)
-#define PCI_FIX_ADDR(addr)						\
-	((PCI_IO_ADDR)(((unsigned long)(addr)) & ~PCI_IO_IND_TOKEN_MASK))
-#define PCI_GET_ADDR_TOKEN(addr)					\
-	(((unsigned long)(addr) & PCI_IO_IND_TOKEN_MASK) >> 		\
-		PCI_IO_IND_TOKEN_SHIFT)
-#define PCI_SET_ADDR_TOKEN(addr, token) 				\
-do {									\
-	unsigned long __a = (unsigned long)(addr);			\
-	__a &= ~PCI_IO_IND_TOKEN_MASK;					\
-	__a |= ((unsigned long)(token)) << PCI_IO_IND_TOKEN_SHIFT;	\
-	(addr) = (void __iomem *)__a;					\
-} while(0)
-#else
 #define PCI_FIX_ADDR(addr) (addr)
-#endif
-
 
 /*
  * Non ordered and non-swapping "raw" accessors
@@ -632,11 +588,7 @@ __do_out_asm(_rec_outl, "stwbrx")
 #define DEF_PCI_HOOK_pio(x)	NULL
 #endif
 
-#ifdef CONFIG_PPC_INDIRECT_MMIO
-#define DEF_PCI_HOOK_mem(x)	x
-#else
 #define DEF_PCI_HOOK_mem(x)	NULL
-#endif
 
 /* Structure containing all the hooks */
 extern struct ppc_pci_io {
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index e67f3048611f..7284c8021eeb 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -892,7 +892,7 @@ unsigned long memory_block_size_bytes(void)
 }
 #endif
 
-#if defined(CONFIG_PPC_INDIRECT_PIO) || defined(CONFIG_PPC_INDIRECT_MMIO)
+#ifdef CONFIG_PPC_INDIRECT_PIO
 struct ppc_pci_io ppc_pci_io;
 EXPORT_SYMBOL(ppc_pci_io);
 #endif
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index d11ade7cf7b3..b78c132d47ab 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -186,9 +186,6 @@ config PPC_INDIRECT_PIO
 	bool
 	select GENERIC_IOMAP
 
-config PPC_INDIRECT_MMIO
-	bool
-
 source "drivers/cpufreq/Kconfig"
 
 menu "CPUIdle driver"
-- 
2.47.0


