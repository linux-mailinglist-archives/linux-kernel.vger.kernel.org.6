Return-Path: <linux-kernel+bounces-409343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C939C8B91
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40B9CB2C151
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1116E1FB3C7;
	Thu, 14 Nov 2024 13:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="fwjfI7S6"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D9B1FAEEC
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731589890; cv=none; b=GIWF8rGfhln9qG3G05DOD/X/U+cHSsk9YYNyMCmtoVZg6xWJ3V3y01zTGYLm9xruWvBFjAy2RgtWp5NKtnph83oH7GI3fElqb2iWZ5AdsdnFv+M9Srfe/RoqeeIxDOnpx1rcoPyoE13TDr5EKsYp2sduOpzkeSBTpBQF8FpTnWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731589890; c=relaxed/simple;
	bh=utYro9l01qxU857R7rR1FP4HNMPmtdOxOwKLdUzqIIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qNC/2yQFzrKomEh9kcQ6YwM3ZbGA7jAZS6hzeKv4/Mg1njFp2cVk/tff/taytsUUCTE421pGT97WGxvZ0K8wj/gfCiByvSKZd5tZexpkwIANF2Ur2UdgSAem/+W4U/mRnIqc0O858WiiYFrNUR6slvU+77PE5orKYMMlfNNSJUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=fwjfI7S6; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731589882;
	bh=8lv/TuPEHGTjHOs8oCCK4drdO6rdbHqIJ45DhBhxXp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fwjfI7S6Pwl8F/OGjpFwKhyWhwnvTar8XSUe3jnEx6liyi1QFx9h+peqr3lrU8ywb
	 x273Hi3jk5nlWHK6cqggb8g3lRcDNbJah8VvxGX06WjyjLJ69Lf4F1FHREiCnodWEG
	 s8ewmqOQYa7gk1h7Ca82XCaoMJBqwOnH0Fx0mgZBDAX2EOPfVLpvBbtUYrouPrHrps
	 9jpYljG/Wch0cy5oXVvPfbUsCyc/MkkRho16zREu8qbqPE+8OqMSJek7vfIj7YrmYe
	 km4TY9/67/1PU+YGPCH67zIXWoJF/yDl18hpCgqh8xIe5Doiwpj55aihWPXFmGeI0L
	 fLWxWciBNV1qw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xq0sQ1Rkkz4x6k;
	Fri, 15 Nov 2024 00:11:22 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Cc: <linux-kernel@vger.kernel.org>,
	<geert@linux-m68k.org>,
	<arnd@arndb.de>
Subject: [RFC PATCH 02/10] powerpc/chrp: Remove various dead code
Date: Fri, 15 Nov 2024 00:11:05 +1100
Message-ID: <20241114131114.602234-2-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114131114.602234-1-mpe@ellerman.id.au>
References: <20241114131114.602234-1-mpe@ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove various bits of code that are dead now that PPC_CHRP has been
removed.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig                 |  5 +--
 arch/powerpc/boot/Makefile           |  1 -
 arch/powerpc/include/asm/processor.h |  6 ---
 arch/powerpc/kernel/head_book3s_32.S | 12 ------
 arch/powerpc/kernel/pci_32.c         |  2 +-
 arch/powerpc/kernel/prom_init.c      | 56 ----------------------------
 6 files changed, 3 insertions(+), 79 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a9dd4c39ec00..f79e28f47dea 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -418,11 +418,10 @@ config PPC_DCR
 config PPC_PCI_OF_BUS_MAP
 	bool "Use pci_to_OF_bus_map (deprecated)"
 	depends on PPC32
-	depends on PPC_PMAC || PPC_CHRP
+	depends on PPC_PMAC
 	help
 	  This option uses pci_to_OF_bus_map to map OF nodes to PCI devices, which
-	  restricts the system to only having 256 PCI buses. On CHRP it also causes
-	  the "pci-OF-bus-map" property to be created in the device tree.
+	  restricts the system to only having 256 PCI buses.
 
 	  If unsure, say "N".
 
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 1ff6ad4f6cd2..8a0fb044e885 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -278,7 +278,6 @@ image-$(CONFIG_PPC_PSERIES)		+= zImage.pseries
 image-$(CONFIG_PPC_POWERNV)		+= zImage.pseries
 image-$(CONFIG_PPC_IBM_CELL_BLADE)	+= zImage.pseries
 image-$(CONFIG_PPC_PS3)			+= dtbImage.ps3
-image-$(CONFIG_PPC_CHRP)		+= zImage.chrp
 image-$(CONFIG_PPC_EFIKA)		+= zImage.chrp
 image-$(CONFIG_PPC_PMAC)		+= zImage.pmac
 image-$(CONFIG_PPC_HOLLY)		+= dtbImage.holly
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 6b94de17201c..b00b5ae2cfef 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -53,12 +53,6 @@
 #define _PREP_IBM	0x00	/* ibm prep */
 #define _PREP_Bull	0x03	/* bull prep */
 
-/* CHRP sub-platform types. These are arbitrary */
-#define _CHRP_Motorola	0x04	/* motorola chrp, the cobra */
-#define _CHRP_IBM	0x05	/* IBM chrp, the longtrail and longtrail 2 */
-#define _CHRP_Pegasos	0x06	/* Genesi/bplan's Pegasos and Pegasos2 */
-#define _CHRP_briq	0x07	/* TotalImpact's briQ */
-
 #if defined(__KERNEL__) && defined(CONFIG_PPC32)
 
 extern int _chrp_type;
diff --git a/arch/powerpc/kernel/head_book3s_32.S b/arch/powerpc/kernel/head_book3s_32.S
index cb2bca76be53..c6e297fd36e2 100644
--- a/arch/powerpc/kernel/head_book3s_32.S
+++ b/arch/powerpc/kernel/head_book3s_32.S
@@ -256,20 +256,8 @@ __secondary_hold_acknowledge:
  */
 	START_EXCEPTION(INTERRUPT_MACHINE_CHECK, MachineCheck)
 	EXCEPTION_PROLOG_0
-#ifdef CONFIG_PPC_CHRP
-	mtspr	SPRN_SPRG_SCRATCH2,r1
-	mfspr	r1, SPRN_SPRG_THREAD
-	lwz	r1, RTAS_SP(r1)
-	cmpwi	cr1, r1, 0
-	bne	cr1, 7f
-	mfspr	r1, SPRN_SPRG_SCRATCH2
-#endif /* CONFIG_PPC_CHRP */
 	EXCEPTION_PROLOG_1
 7:	EXCEPTION_PROLOG_2 0x200 MachineCheck
-#ifdef CONFIG_PPC_CHRP
-	beq	cr1, 1f
-	twi	31, 0, 0
-#endif
 1:	prepare_transfer_to_handler
 	bl	machine_check_exception
 	b	interrupt_return
diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index ce0c8623e563..461e1a7f4fc2 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -277,7 +277,7 @@ static int __init pcibios_init(void)
 #endif
 	}
 
-#if defined(CONFIG_PPC_PMAC) || defined(CONFIG_PPC_CHRP)
+#ifdef CONFIG_PPC_PMAC
 #ifdef CONFIG_PPC_PCI_OF_BUS_MAP
 	pci_bus_count = next_busno;
 
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 73210e5bcfa7..94ffc52440bd 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -2792,61 +2792,6 @@ static void __init flatten_device_tree(void)
 		    dt_struct_start, dt_struct_end);
 }
 
-#ifdef CONFIG_PPC_CHRP
-/*
- * Pegasos and BriQ lacks the "ranges" property in the isa node
- * Pegasos needs decimal IRQ 14/15, not hexadecimal
- * Pegasos has the IDE configured in legacy mode, but advertised as native
- */
-static void __init fixup_device_tree_chrp(void)
-{
-	phandle ph;
-	u32 prop[6];
-	u32 rloc = 0x01006000; /* IO space; PCI device = 12 */
-	char *name;
-	int rc;
-
-	name = "/pci@80000000/isa@c";
-	ph = call_prom("finddevice", 1, 1, ADDR(name));
-	if (!PHANDLE_VALID(ph)) {
-		name = "/pci@ff500000/isa@6";
-		ph = call_prom("finddevice", 1, 1, ADDR(name));
-		rloc = 0x01003000; /* IO space; PCI device = 6 */
-	}
-	if (PHANDLE_VALID(ph)) {
-		rc = prom_getproplen(ph, "ranges");
-		if (rc == 0 || rc == PROM_ERROR) {
-			prom_printf("Fixing up missing ISA range on Pegasos...\n");
-
-			prop[0] = 0x1;
-			prop[1] = 0x0;
-			prop[2] = rloc;
-			prop[3] = 0x0;
-			prop[4] = 0x0;
-			prop[5] = 0x00010000;
-			prom_setprop(ph, name, "ranges", prop, sizeof(prop));
-		}
-	}
-
-	name = "/pci@80000000/ide@C,1";
-	ph = call_prom("finddevice", 1, 1, ADDR(name));
-	if (PHANDLE_VALID(ph)) {
-		prom_printf("Fixing up IDE interrupt on Pegasos...\n");
-		prop[0] = 14;
-		prop[1] = 0x0;
-		prom_setprop(ph, name, "interrupts", prop, 2*sizeof(u32));
-		prom_printf("Fixing up IDE class-code on Pegasos...\n");
-		rc = prom_getprop(ph, "class-code", prop, sizeof(u32));
-		if (rc == sizeof(u32)) {
-			prop[0] &= ~0x5;
-			prom_setprop(ph, name, "class-code", prop, sizeof(u32));
-		}
-	}
-}
-#else
-#define fixup_device_tree_chrp()
-#endif
-
 #if defined(CONFIG_PPC64) && defined(CONFIG_PPC_PMAC)
 static void __init fixup_device_tree_pmac(void)
 {
@@ -3109,7 +3054,6 @@ static inline void fixup_device_tree_pasemi(void) { }
 
 static void __init fixup_device_tree(void)
 {
-	fixup_device_tree_chrp();
 	fixup_device_tree_pmac();
 	fixup_device_tree_efika();
 	fixup_device_tree_pasemi();
-- 
2.47.0


