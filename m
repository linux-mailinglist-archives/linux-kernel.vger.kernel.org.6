Return-Path: <linux-kernel+bounces-409302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 342939C8B1B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE9341F22586
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29171FB3FD;
	Thu, 14 Nov 2024 12:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="cK0Z+jeI"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD391FAF03
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 12:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731588689; cv=none; b=MP5R8zEGRuuC3KgJBjIFFBU/8dknSGjSCMZVTN6lQU7DxuJNZ6+TtGkFHytwSmZsS+1dB+U8zxCaQ80227q5KnTz3YzHgoaRSMbQifSjrkC99mgcEdViLeM13Xbik+K3Plsd1VMS6agaCjgm17hQiE4Xm1KNY1yJdozPX6zs2LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731588689; c=relaxed/simple;
	bh=jS4qetC/6XYFNdu4lt7CzaFAUbdBjYkEHhMdJmjUSyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9OxaeJytEAmOnbHHI9pjHXscgg0vTtrbo313xGvKgDUeyZ3dvAAwetn8PTV6PDBc1DnfOP6arF/T0srEwJEidCn5CTedOfQzl9CONkV/qFkYohtuZw1PmlIqv95rEQFd3OTzSEz5jyufDUSYcxlnigHSeH0MMq+h0frpyJ92ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=cK0Z+jeI; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731588680;
	bh=ZUGaNs5IqIAOlBm1IdqFuPq/u1GvPSYCiPGh3HoQ1M8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cK0Z+jeIceTyj/siOsMtqtYIexyqXL8/0AZgmDiR9VumqwMpr+2oNzv2UVEi+4TR+
	 2ggnqicK5DcLE+sUR/oP2s/eKOQEyXNIK+bNrGw1uUvLKOLhIyOEMGlYpEZj876NYI
	 X0hM9yUq2PVvpgklSLax8xQpwI+QqARawdwA08au84V1siFzN6bQU6QHXty/CA/K7E
	 IT7aOw37rpMIiOWf9TkMm9pdpe07qyX/F0fRNL6VCUqlW+q8s+MbjeZ6cqmE7l207b
	 AuQhRg7kvzWWWizkGaRTWZjqhE+eFBMDW8ByA6y9FgVAChb+EHZPItBxbgEaDTS0gH
	 xXO1p51t2DLpg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xq0QJ4dn4z4xG4;
	Thu, 14 Nov 2024 23:51:20 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Cc: <linux-kernel@vger.kernel.org>,
	<jk@ozlabs.org>,
	<arnd@arndb.de>,
	<geoff@infradead.org>
Subject: [RFC PATCH 08/20] powerpc: Remove PPC_OF_PLATFORM_PCI
Date: Thu, 14 Nov 2024 23:50:57 +1100
Message-ID: <20241114125111.599093-8-mpe@ellerman.id.au>
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

The Cell blade support was the last user of PPC_OF_PLATFORM_PCI, so
remove it.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig              |   5 --
 arch/powerpc/kernel/Makefile      |   2 +-
 arch/powerpc/kernel/of_platform.c | 102 ------------------------------
 3 files changed, 1 insertion(+), 108 deletions(-)
 delete mode 100644 arch/powerpc/kernel/of_platform.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 00d6cd943a1f..a6bea6788fe1 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -435,11 +435,6 @@ config PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT
 	  PCI domain dependent and each PCI controller on own domain can have
 	  256 PCI buses, like it is on other Linux architectures.
 
-config PPC_OF_PLATFORM_PCI
-	bool
-	depends on PCI
-	depends on PPC64 # not supported on 32 bits yet
-
 config ARCH_SUPPORTS_UPROBES
 	def_bool y
 
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index f43c1198768c..d6febd297e72 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -70,7 +70,7 @@ obj-y				:= cputable.o syscalls.o switch.o \
 				   signal.o sysfs.o cacheinfo.o time.o \
 				   prom.o traps.o setup-common.o \
 				   udbg.o misc.o io.o misc_$(BITS).o \
-				   of_platform.o prom_parse.o firmware.o \
+				   prom_parse.o firmware.o \
 				   hw_breakpoint_constraints.o interrupt.o \
 				   kdebugfs.o stacktrace.o syscall.o
 obj-y				+= ptrace/
diff --git a/arch/powerpc/kernel/of_platform.c b/arch/powerpc/kernel/of_platform.c
deleted file mode 100644
index adc76fa58d1e..000000000000
--- a/arch/powerpc/kernel/of_platform.c
+++ /dev/null
@@ -1,102 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *    Copyright (C) 2006 Benjamin Herrenschmidt, IBM Corp.
- *			 <benh@kernel.crashing.org>
- *    and		 Arnd Bergmann, IBM Corp.
- */
-
-#undef DEBUG
-
-#include <linux/string.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/export.h>
-#include <linux/mod_devicetable.h>
-#include <linux/pci.h>
-#include <linux/platform_device.h>
-#include <linux/atomic.h>
-
-#include <asm/errno.h>
-#include <asm/topology.h>
-#include <asm/pci-bridge.h>
-#include <asm/ppc-pci.h>
-#include <asm/eeh.h>
-
-#ifdef CONFIG_PPC_OF_PLATFORM_PCI
-
-/* The probing of PCI controllers from of_platform is currently
- * 64 bits only, mostly due to gratuitous differences between
- * the 32 and 64 bits PCI code on PowerPC and the 32 bits one
- * lacking some bits needed here.
- */
-
-static int of_pci_phb_probe(struct platform_device *dev)
-{
-	struct pci_controller *phb;
-
-	/* Check if we can do that ... */
-	if (ppc_md.pci_setup_phb == NULL)
-		return -ENODEV;
-
-	pr_info("Setting up PCI bus %pOF\n", dev->dev.of_node);
-
-	/* Alloc and setup PHB data structure */
-	phb = pcibios_alloc_controller(dev->dev.of_node);
-	if (!phb)
-		return -ENODEV;
-
-	/* Setup parent in sysfs */
-	phb->parent = &dev->dev;
-
-	/* Setup the PHB using arch provided callback */
-	if (ppc_md.pci_setup_phb(phb)) {
-		pcibios_free_controller(phb);
-		return -ENODEV;
-	}
-
-	/* Process "ranges" property */
-	pci_process_bridge_OF_ranges(phb, dev->dev.of_node, 0);
-
-	/* Init pci_dn data structures */
-	pci_devs_phb_init_dynamic(phb);
-
-	/* Create EEH PE for the PHB */
-	eeh_phb_pe_create(phb);
-
-	/* Scan the bus */
-	pcibios_scan_phb(phb);
-	if (phb->bus == NULL)
-		return -ENXIO;
-
-	/* Claim resources. This might need some rework as well depending
-	 * whether we are doing probe-only or not, like assigning unassigned
-	 * resources etc...
-	 */
-	pcibios_claim_one_bus(phb->bus);
-
-	/* Add probed PCI devices to the device model */
-	pci_bus_add_devices(phb->bus);
-
-	return 0;
-}
-
-static const struct of_device_id of_pci_phb_ids[] = {
-	{ .type = "pci", },
-	{ .type = "pcix", },
-	{ .type = "pcie", },
-	{ .type = "pciex", },
-	{ .type = "ht", },
-	{}
-};
-
-static struct platform_driver of_pci_phb_driver = {
-	.probe = of_pci_phb_probe,
-	.driver = {
-		.name = "of-pci",
-		.of_match_table = of_pci_phb_ids,
-	},
-};
-
-builtin_platform_driver(of_pci_phb_driver);
-
-#endif /* CONFIG_PPC_OF_PLATFORM_PCI */
-- 
2.47.0


