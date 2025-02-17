Return-Path: <linux-kernel+bounces-517209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97343A37DB8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55E423AF28E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 08:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD531ACEBE;
	Mon, 17 Feb 2025 08:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="UggyotyX"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB431A5B99
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739782696; cv=none; b=IpeA7e7RhMMjcZThBAdtEVfcsgQNPDxT5eDCqsJ4w2bArZnPH5yZPjrweD36T64Sbp8XX76tl5I9FbsjI8c1zCnL1eRKPLxQF/O7hewwgytKCDZuXsMLQr+GLJRazKy+r5qIjtP/xtfV1iEX1XfaykCGa67AZ1euA/8WXhobMpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739782696; c=relaxed/simple;
	bh=KPNhzopPF/v+rf0DL/xDUy/p8rwZ0ENzF3r/iosIwvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DG4DNJ7IuEtL3HdwzcNau5Pr2ns4mW55ofTjBWuo+r/oCn2owpcSqof4oXfKGM5XSuBvfFUAwz02R+jGKDDewPQ3o+0KXtjZwW+HSbNXKaBtYRPsHLvpP9jRGuUuBc5rY6Cjd1eexbq0dxaRl0DHI97XQO80Z6eaJL488aXshE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=UggyotyX; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-219f8263ae0so71578495ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 00:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1739782694; x=1740387494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oop51W2xPzPgS///BRY5kVWjIpIgQEDQeLtCvsidU3M=;
        b=UggyotyXlEGki5PFRr1rVcg/5iogZAkocDAEMAmlRSfTK67Vsrl1UqDLMJkTmH5sMX
         yMly4Rf5jHEg1O7G36uhxz6HNYcElbdpmnDc3FYgrNks2iWTFh7MMtDoA9D5q5I9TlHx
         FqTFYWS5abDFOjVzatkTjKCRLDODdsXXLcCARwiX34lBUrg8kZZ3biG7qex+jLNZoada
         vbpFE5yzGd6LbDUvR1WFoM3+BQ5qbRSgR4QfedJ0BwAeqHQiH0nSKC+bF+Bx4tqW5rgG
         st/4lkdrsQ1wHuipX4bN0ZAI5M71QrxswtyjfokX+ATqlHLIIirEIiAjbO8pcVUBV+Uy
         Co/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739782694; x=1740387494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oop51W2xPzPgS///BRY5kVWjIpIgQEDQeLtCvsidU3M=;
        b=B+uFc2KniH6twa4t3+qZxcAsAFWF33F4D94cFwV0AWnFAKSgWFvYEoSoXzFfH9YLFU
         LdlWK8V3sAr/fxcd2UNP7AUKSKF8+/qI3XxgrhE253OTRRDYEfOK9Vcwj3Pquy74EoMw
         vX2KxEHRJ35ZiJvg0EwST5wdxcDUkZrTS1tfIgRWk7+S0HbBcGlM6r86eDKsZcVfNj+o
         HaTXWAFDR56mglV4qE9iKPYWf53EgSl/JkdzcktXD9maFO5bsoHC5CTUc+qAwGPpMiV6
         EiRllHQTs6Vnd5QORQMicVEmSHNUs79osB/H8MhlAxOuWigxtRy0QiSE83Qx0gnDUWxI
         y84g==
X-Forwarded-Encrypted: i=1; AJvYcCVP5RYH8TNWfnm0HrcUCsSV88qXDcB6RDcO1SHhy5SuuETKX4NI7w/ZmZGWA9//UyKZ7gKKYwL/SbxGvqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2aDBZaTQN6sNI/U6TiWPKqhkQPZXiyyPMDdQBl0nTsAZcWd0P
	Xd3GXQwfrPdx9Woqf2mthBs+hAvvn9rmpY5Tu1WbITh2dhwEdx3kkTm9/0Wq/RQ=
X-Gm-Gg: ASbGncuGolzxE+cZuyn4mE1RcXSFln9oPc+FPNE25+9rG0lEn9DT3yW0za0fh9i4ciP
	TiqQeeXVmB49H8mJ2JFzSLp5xwuSCVBFu03B5MDQvqPXrAuSQg7B+eDt5AOMSjnrVa3TfcJRUdM
	Zssrsb0PP8zpoaw1w3iCRbImo21kk1VRnNqTCZ2PO/TGuV/njnzfr6om4ARes3wuOJSWb8HWLf6
	nbZDDF+9yKNvuSkBqKQUGFfQ8qpZ1EUPJv1MrFj71w92qMWW4graJ0/hsmcG7bpPuYr64BUZ9W5
	piqectZQ1bIx0mJcuUgz9pqX5s8sK/uAuRmH+UvjzwI7x7Hv9bqjwNE=
X-Google-Smtp-Source: AGHT+IHKsFX8G1xeFdGN0LrWZ8KF20LhqcM9UDqb+rrZ1azyG6dWW4gYdjdpQdbPPAsWI3TzMShx/g==
X-Received: by 2002:a05:6a21:7886:b0:1e0:ca1c:8581 with SMTP id adf61e73a8af0-1ee8cb3e424mr12892785637.21.1739782693650;
        Mon, 17 Feb 2025 00:58:13 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([122.171.22.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242546867sm7632018b3a.24.2025.02.17.00.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 00:58:13 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: hpa@zytor.com,
	Marc Zyngier <maz@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v6 03/10] irqchip/riscv-imsic: Move to common MSI lib
Date: Mon, 17 Feb 2025 14:26:49 +0530
Message-ID: <20250217085657.789309-4-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217085657.789309-1-apatel@ventanamicro.com>
References: <20250217085657.789309-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

Simplify the leaf MSI domain handling in the RISC-V IMSIC driver by
using msi_lib_init_dev_msi_info() and msi_lib_irq_domain_select()
provided by common MSI lib.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/Kconfig                    |   8 +-
 drivers/irqchip/irq-riscv-imsic-platform.c | 114 +--------------------
 2 files changed, 6 insertions(+), 116 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index c11b9965c4ad..fe95ef723bb3 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -590,13 +590,7 @@ config RISCV_IMSIC
 	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_IRQ_MATRIX_ALLOCATOR
 	select GENERIC_MSI_IRQ
-
-config RISCV_IMSIC_PCI
-	bool
-	depends on RISCV_IMSIC
-	depends on PCI
-	depends on PCI_MSI
-	default RISCV_IMSIC
+	select IRQ_MSI_LIB
 
 config SIFIVE_PLIC
 	bool
diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
index 5d7c30ad8855..9a5e7b4541f6 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -20,6 +20,7 @@
 #include <linux/spinlock.h>
 #include <linux/smp.h>
 
+#include "irq-msi-lib.h"
 #include "irq-riscv-imsic-state.h"
 
 static bool imsic_cpu_page_phys(unsigned int cpu, unsigned int guest_index,
@@ -174,22 +175,6 @@ static void imsic_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
 }
 
-static int imsic_irq_domain_select(struct irq_domain *domain, struct irq_fwspec *fwspec,
-				   enum irq_domain_bus_token bus_token)
-{
-	const struct msi_parent_ops *ops = domain->msi_parent_ops;
-	u32 busmask = BIT(bus_token);
-
-	if (fwspec->fwnode != domain->fwnode || fwspec->param_count != 0)
-		return 0;
-
-	/* Handle pure domain searches */
-	if (bus_token == ops->bus_select_token)
-		return 1;
-
-	return !!(ops->bus_select_mask & busmask);
-}
-
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
 static void imsic_irq_debug_show(struct seq_file *m, struct irq_domain *d,
 				 struct irq_data *irqd, int ind)
@@ -206,110 +191,21 @@ static void imsic_irq_debug_show(struct seq_file *m, struct irq_domain *d,
 static const struct irq_domain_ops imsic_base_domain_ops = {
 	.alloc		= imsic_irq_domain_alloc,
 	.free		= imsic_irq_domain_free,
-	.select		= imsic_irq_domain_select,
+	.select		= msi_lib_irq_domain_select,
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
 	.debug_show	= imsic_irq_debug_show,
 #endif
 };
 
-#ifdef CONFIG_RISCV_IMSIC_PCI
-
-static void imsic_pci_mask_irq(struct irq_data *d)
-{
-	pci_msi_mask_irq(d);
-	irq_chip_mask_parent(d);
-}
-
-static void imsic_pci_unmask_irq(struct irq_data *d)
-{
-	irq_chip_unmask_parent(d);
-	pci_msi_unmask_irq(d);
-}
-
-#define MATCH_PCI_MSI		BIT(DOMAIN_BUS_PCI_MSI)
-
-#else
-
-#define MATCH_PCI_MSI		0
-
-#endif
-
-static bool imsic_init_dev_msi_info(struct device *dev,
-				    struct irq_domain *domain,
-				    struct irq_domain *real_parent,
-				    struct msi_domain_info *info)
-{
-	const struct msi_parent_ops *pops = real_parent->msi_parent_ops;
-
-	/* MSI parent domain specific settings */
-	switch (real_parent->bus_token) {
-	case DOMAIN_BUS_NEXUS:
-		if (WARN_ON_ONCE(domain != real_parent))
-			return false;
-#ifdef CONFIG_SMP
-		info->chip->irq_set_affinity = irq_chip_set_affinity_parent;
-#endif
-		break;
-	default:
-		WARN_ON_ONCE(1);
-		return false;
-	}
-
-	/* Is the target supported? */
-	switch (info->bus_token) {
-#ifdef CONFIG_RISCV_IMSIC_PCI
-	case DOMAIN_BUS_PCI_DEVICE_MSI:
-	case DOMAIN_BUS_PCI_DEVICE_MSIX:
-		info->chip->irq_mask = imsic_pci_mask_irq;
-		info->chip->irq_unmask = imsic_pci_unmask_irq;
-		break;
-#endif
-	case DOMAIN_BUS_DEVICE_MSI:
-		/*
-		 * Per-device MSI should never have any MSI feature bits
-		 * set. It's sole purpose is to create a dumb interrupt
-		 * chip which has a device specific irq_write_msi_msg()
-		 * callback.
-		 */
-		if (WARN_ON_ONCE(info->flags))
-			return false;
-
-		/* Core managed MSI descriptors */
-		info->flags |= MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS |
-			       MSI_FLAG_FREE_MSI_DESCS;
-		break;
-	case DOMAIN_BUS_WIRED_TO_MSI:
-		break;
-	default:
-		WARN_ON_ONCE(1);
-		return false;
-	}
-
-	/* Use hierarchial chip operations re-trigger */
-	info->chip->irq_retrigger = irq_chip_retrigger_hierarchy;
-
-	/*
-	 * Mask out the domain specific MSI feature flags which are not
-	 * supported by the real parent.
-	 */
-	info->flags &= pops->supported_flags;
-
-	/* Enforce the required flags */
-	info->flags |= pops->required_flags;
-
-	return true;
-}
-
-#define MATCH_PLATFORM_MSI		BIT(DOMAIN_BUS_PLATFORM_MSI)
-
 static const struct msi_parent_ops imsic_msi_parent_ops = {
 	.supported_flags	= MSI_GENERIC_FLAGS_MASK |
 				  MSI_FLAG_PCI_MSIX,
 	.required_flags		= MSI_FLAG_USE_DEF_DOM_OPS |
-				  MSI_FLAG_USE_DEF_CHIP_OPS,
+				  MSI_FLAG_USE_DEF_CHIP_OPS |
+				  MSI_FLAG_PCI_MSI_MASK_PARENT,
 	.bus_select_token	= DOMAIN_BUS_NEXUS,
 	.bus_select_mask	= MATCH_PCI_MSI | MATCH_PLATFORM_MSI,
-	.init_dev_msi_info	= imsic_init_dev_msi_info,
+	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
 };
 
 int imsic_irqdomain_init(void)
-- 
2.43.0


