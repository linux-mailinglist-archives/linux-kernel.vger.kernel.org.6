Return-Path: <linux-kernel+bounces-446120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC2A9F2013
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 18:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7EC7166A82
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 17:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964751A8F6D;
	Sat, 14 Dec 2024 17:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Yzbs6lUF"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E9F19A2B0
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 17:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734197194; cv=none; b=QNIKf6sK0Im3FzyycHXeP5wpT66WhX/xZTKm+Y3RgtxJ3el9/JolO2Qk9jPevzmOvkffMzWs16Cq/Z1m3yMPh7JHcEseCkDJiXxCgeHtB7UIBVzBoDpOa9ycVRHmcmd8wtV2umWeYJeHXoZOfWKur1JrnMY5iJOemeZ351ZVsQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734197194; c=relaxed/simple;
	bh=Mfh/oKVyV/v62tUmOG9j432HyhjKXncy+MsddMkaJpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o6CCjfJy/0QSL0aNsXUayh4pCWtEH2T52bQY4sCs+NELmZqRoAhjw3BL14aZneVVS4CxHX6VUyB24H9uLV3t3xblOQQVvbPuBC8dtHpwdYtSykDvWXhrpl9gpdQBqWjaXFyshJmZKQ78h/LFpM1eAsUMllwv4myLF8nPwW0D04k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Yzbs6lUF; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ee50ffcf14so3084852a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 09:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1734197193; x=1734801993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTMHZPsDjixID3LZgZypNI5zerTGwhJ3oNH3JU/CG6w=;
        b=Yzbs6lUFltKMt/QaYfH66ZTlMnbXxkZaLtXcoz7XpRQ5bVsjRws+9GTKr014n13tzq
         Geh+wq0x1i3zlusju7pHVaZzQnNR1u8hCIt9XK+G4kLQl3fWEbwU0NzTH+lB386OL0iz
         7IX26MYFYZDL1QCpv07lv88KVh6ypjXaL/l8uuc1jgFwKJi0sRtPiZXSH4D+1hL24Et7
         BHooeAdHefdYN4vf8d+XrnS+vhrRH3lRyjvl9qlfQoysjAaiLmxVyX1ESGjDpPVH8Tee
         VV2ZFGvbjP5/e4cI1/BeFdXCFhKfrUCcJL1f9b48x7EIkg9W+TLouxXlpHYILTRC73ir
         Zcdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734197193; x=1734801993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WTMHZPsDjixID3LZgZypNI5zerTGwhJ3oNH3JU/CG6w=;
        b=UzRGCWYW/aK2ofsiDUi1kSrwfz7PURUXhdOrOgWXH3abCs/2F3gIrZrM4SYcokJAYe
         /5iXrXW1pc/RXELpk4Kd5AlzY3VoQnWDdtqnJIRG5ZJFCZr6wmdTv5Y3C5wN/eKpUyYm
         uEj4d+KOpOc69pXK2BleARigDTpn4mwT+WJeQQPzZSlLI2yuzQrBl3yo7MXlSil+Nb7T
         TCTATF6ORhsm3yymD0Q9PLUsQ31izUXsLFbCv4aY0ZGVFoEdAnz9mIk9+UoLlihvZgTY
         vLWxTRIZqcRH+325ZBiAPs0ryUU4xinyKmtT7bCraivp0xnlxIUrRDnsf0vIoKm7ZTAw
         q6iA==
X-Forwarded-Encrypted: i=1; AJvYcCVPAcRhFVH8aJbE5rrOcEQ3Kojt6/RYIj2zjtRskCOZFU7QZ+RETC4BigIMBk0bqLj6hXF+MBoRN3qZCDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxprhSsQMfDAfptcGO2zvPT1Ydwt7sxEbWI5M9TmdXF8109+Rza
	2oyDOPvvgrm3+0PM78edf28TtGtLc1nKTqNXCCaetBgrK7bdn5qWsgwLZBKJ2maUAVGGbdi2Xwk
	K
X-Gm-Gg: ASbGnctX0hdMnMCTTVOhCrJofZZC2V6GyNLm+aZgSphylFQA0rzV+N72ZcGnafKPn8o
	qyYBhW6odytfJ5gqwnly2PWql3GxxhxJ1xSlAxfbCuizkfepEpGX6ZtnRR6jZsXzGMrfDs94dGQ
	mfdb7X6obj8UVzopf0nlX5yNa45OenjfJptLbbBkvO9Se21jWtyWanQxxp67vi0ktVTi2tN/Nx4
	LKSIZ/21Uw9CQs20wuEDUwQwOxmpcU9/KGF/7Nf98X2WuRhu/7HWBtbN2d+JnztXJanKVhpcjM4
	SveZcapQ57ijFSE=
X-Google-Smtp-Source: AGHT+IH7cEjTQcM+udD/U5XRPprvWKA6NBoe1GlzDD6yjgsEVTNKRYALRcnCyPJucGTbfWHoFFxtSg==
X-Received: by 2002:a17:90b:4d05:b0:2ef:ad27:7c1a with SMTP id 98e67ed59e1d1-2f13ab74905mr16256697a91.2.1734197192577;
        Sat, 14 Dec 2024 09:26:32 -0800 (PST)
Received: from localhost.localdomain ([223.185.132.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142f9e186sm5049811a91.41.2024.12.14.09.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 09:26:32 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>,
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
Subject: [PATCH v2 04/11] irqchip/riscv-imsic: Move to common MSI lib
Date: Sat, 14 Dec 2024 22:55:42 +0530
Message-ID: <20241214172549.8842-5-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241214172549.8842-1-apatel@ventanamicro.com>
References: <20241214172549.8842-1-apatel@ventanamicro.com>
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
index 55d7122121e2..6b767b8c974f 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -587,13 +587,7 @@ config RISCV_IMSIC
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
index dc6f63f657e4..2fab20d2ce3e 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -20,6 +20,7 @@
 #include <linux/spinlock.h>
 #include <linux/smp.h>
 
+#include "irq-msi-lib.h"
 #include "irq-riscv-imsic-state.h"
 
 static bool imsic_cpu_page_phys(unsigned int cpu, unsigned int guest_index,
@@ -201,22 +202,6 @@ static void imsic_irq_domain_free(struct irq_domain *domain, unsigned int virq,
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
@@ -233,110 +218,21 @@ static void imsic_irq_debug_show(struct seq_file *m, struct irq_domain *d,
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


