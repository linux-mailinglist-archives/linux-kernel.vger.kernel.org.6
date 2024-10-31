Return-Path: <linux-kernel+bounces-389999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3119B7451
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 07:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F0811F24E47
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 06:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A61146D59;
	Thu, 31 Oct 2024 06:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ym543BEZ"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E680145FE4;
	Thu, 31 Oct 2024 06:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730354978; cv=none; b=JtDPSR/w2FP8hXhIG3xoupcgiadFA4si1cV6sUCPNDXkSyXbsNFyjtkHAAIVb9s6Pve12pw0GVgXaDnfTk/4899NaoUrFNPey9MZzqwKwj7hDi/8KOFAvSNz+eRSPQwMN0vDO1lDvBJEwhWMvt1XP6kVg6NMb/pqJ09RoP7QNLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730354978; c=relaxed/simple;
	bh=Fknbi47ITZU0A9AeHDqyI6SMGpptDOmUUWuMG95gFcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KPoyBrc4Ks4Zin/tHqBCENSXTuckbYuF+/asyrCuQPzYJ+BcG9xT17WKaQ1nSNM26DpUw+byPisnpn8tjDkaMBma3axdK+ymomAh2eujTtnsj2hzU8AczV2ZmGN+D0e6QnA54ln9/JqN5QaCkHBaqQkbnVfFZM698+fBZOUx3+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ym543BEZ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20cdbe608b3so6121115ad.1;
        Wed, 30 Oct 2024 23:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730354974; x=1730959774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r55lxlFhBK7JJ//C6HX7v39nTKeSbnaE2FLDN9meifs=;
        b=Ym543BEZGdJvHVZeK4sI7DNZECMJEdjb2nAGuQz11x7g03xcEbyAhHaFy54u7qfOSE
         qm5Qtsqq6Hqq0e0vP1rFCJYp93hM+Rsnnw/Hj+WFEft8FIHGQcJ0CYkv9a3PQYH+mb/G
         jvLfOPLhEpeq+PVzZA+GAL1gLTIjgxPfp4RH/FIZZT6ZE6a5kX6FElEG2dABSFZ2/0mY
         xPxPdgnxsa3Zmg4AliweB3L00X2+wVsWMbsaDBbj8U28wrnGqSAKdSx0eLx3lhyGmGan
         T4RMmJSL67dyxVCQpunZsAik3UvI6uYFdMavyDgXNxDkmSwAKmd7LYTP5m61GpFApOfI
         L/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730354974; x=1730959774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r55lxlFhBK7JJ//C6HX7v39nTKeSbnaE2FLDN9meifs=;
        b=mHhCmw6jmQ6gMjCllBkG02qRUadDZpNKSRbL62diblHL8Pfszqg9QN+baqAMkiYSdW
         z4mZpML8d2r9s4OlU6OqYRFLgp+eUZjcX7ktJmnz44FVpOxa9WYPnCnID4rF2DhnBzNc
         p0N7CG7YbRnFSjzNzsLLq1rZAkINhSEn94kPoCqp8XXTOAiDC7/XNGr8jOeqyRVlaXk3
         oJVqAMl8z0W9S04DI+2GicoYqzKr+0PsDQUEfI0GmW5q/rSi5SCqj+2JQUtGz9v05r+0
         Pr9+obj8qjG25T0/4Qp9yJMB1Oqm6Lkr7yrpU2goFR9iINcLk2pWP50cATr0tPM4hkwe
         jTFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDitjMVF/0BuSjdSDDNyvMm6ikTUreoSEpRSwPuP5nRYNblbnhkcns1jgbTJNUbEtexfOJqZIjZrb6qnFJ@vger.kernel.org, AJvYcCXjFmqIswFrh4E5wmP5CF4ESrkK3NSGNdLIrFD6DjpvbKuYyZsoX+SnDpA1ooGzIUaJXk6kQWVae6N+@vger.kernel.org
X-Gm-Message-State: AOJu0YwJFf8JLHyq1EoWQ9Tdtslol+UDXeFx2pooL3BvSfnt3Ec7O1rf
	7AyQwQBaucvZoMCIw5ZCJC3WX2VJVx8hBWjSAByX2cGoU0luRk9V
X-Google-Smtp-Source: AGHT+IHpfm6kGDCd7jxfM/i31aX3tHwy/QzLz2yvFEAg+WpvPIFw3m7g7kcX2TjdX0tWwn1Fa7YcWg==
X-Received: by 2002:a17:902:cf11:b0:20e:94ba:4e27 with SMTP id d9443c01a7336-210f75365d2mr75715255ad.27.1730354974378;
        Wed, 30 Oct 2024 23:09:34 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056eda5fsm4400275ad.7.2024.10.30.23.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 23:09:34 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Peter Zijlstra <peterz@infradead.org>,
	Inochi Amaoto <inochiama@outlook.com>,
	Guo Ren <guoren@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Anup Patel <apatel@ventanamicro.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v5 2/3] irqchip: add T-HEAD C900 ACLINT SSWI driver
Date: Thu, 31 Oct 2024 14:08:58 +0800
Message-ID: <20241031060859.722258-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031060859.722258-1-inochiama@gmail.com>
References: <20241031060859.722258-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a driver for the T-HEAD C900 ACLINT SSWI device. This device allows
the system with T-HEAD cpus to send ipi via fast device interface.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/irqchip/Kconfig                      |  12 ++
 drivers/irqchip/Makefile                     |   1 +
 drivers/irqchip/irq-thead-c900-aclint-sswi.c | 176 +++++++++++++++++++
 include/linux/cpuhotplug.h                   |   1 +
 4 files changed, 190 insertions(+)
 create mode 100644 drivers/irqchip/irq-thead-c900-aclint-sswi.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index d82bcab233a1..62939fa630c2 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -604,6 +604,18 @@ config STARFIVE_JH8100_INTC
 
 	  If you don't know what to do here, say Y.
 
+config THEAD_C900_ACLINT_SSWI
+	bool "THEAD C9XX ACLINT S-mode IPI Interrupt Controller"
+	depends on RISCV
+	depends on SMP
+	select IRQ_DOMAIN_HIERARCHY
+	select GENERIC_IRQ_IPI_MUX
+	help
+	  This enables support for T-HEAD specific ACLINT SSWI device
+	  support.
+
+	  If you don't know what to do here, say Y.
+
 config EXYNOS_IRQ_COMBINER
 	bool "Samsung Exynos IRQ combiner support" if COMPILE_TEST
 	depends on (ARCH_EXYNOS && ARM) || COMPILE_TEST
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index e3679ec2b9f7..583418261253 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -101,6 +101,7 @@ obj-$(CONFIG_RISCV_APLIC_MSI)		+= irq-riscv-aplic-msi.o
 obj-$(CONFIG_RISCV_IMSIC)		+= irq-riscv-imsic-state.o irq-riscv-imsic-early.o irq-riscv-imsic-platform.o
 obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
 obj-$(CONFIG_STARFIVE_JH8100_INTC)	+= irq-starfive-jh8100-intc.o
+obj-$(CONFIG_THEAD_C900_ACLINT_SSWI)	+= irq-thead-c900-aclint-sswi.o
 obj-$(CONFIG_IMX_IRQSTEER)		+= irq-imx-irqsteer.o
 obj-$(CONFIG_IMX_INTMUX)		+= irq-imx-intmux.o
 obj-$(CONFIG_IMX_MU_MSI)		+= irq-imx-mu-msi.o
diff --git a/drivers/irqchip/irq-thead-c900-aclint-sswi.c b/drivers/irqchip/irq-thead-c900-aclint-sswi.c
new file mode 100644
index 000000000000..b0e366ade427
--- /dev/null
+++ b/drivers/irqchip/irq-thead-c900-aclint-sswi.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Inochi Amaoto <inochiama@gmail.com>
+ */
+
+#define pr_fmt(fmt) "thead-c900-aclint-sswi: " fmt
+#include <linux/cpu.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/pci.h>
+#include <linux/spinlock.h>
+#include <linux/smp.h>
+#include <linux/string_choices.h>
+#include <asm/sbi.h>
+#include <asm/vendorid_list.h>
+
+#define THEAD_ACLINT_xSWI_REGISTER_SIZE		4
+
+#define THEAD_C9XX_CSR_SXSTATUS			0x5c0
+#define THEAD_C9XX_SXSTATUS_CLINTEE		BIT(17)
+
+static int sswi_ipi_virq __ro_after_init;
+static DEFINE_PER_CPU(void __iomem *, sswi_cpu_regs);
+
+static void thead_aclint_sswi_ipi_send(unsigned int cpu)
+{
+	writel_relaxed(0x1, per_cpu(sswi_cpu_regs, cpu));
+}
+
+static void thead_aclint_sswi_ipi_clear(void)
+{
+	writel_relaxed(0x0, this_cpu_read(sswi_cpu_regs));
+}
+
+static void thead_aclint_sswi_ipi_handle(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+
+	chained_irq_enter(chip, desc);
+
+	csr_clear(CSR_IP, IE_SIE);
+	thead_aclint_sswi_ipi_clear();
+
+	ipi_mux_process();
+
+	chained_irq_exit(chip, desc);
+}
+
+static int thead_aclint_sswi_starting_cpu(unsigned int cpu)
+{
+	enable_percpu_irq(sswi_ipi_virq, irq_get_trigger_type(sswi_ipi_virq));
+
+	return 0;
+}
+
+static int thead_aclint_sswi_dying_cpu(unsigned int cpu)
+{
+	thead_aclint_sswi_ipi_clear();
+
+	disable_percpu_irq(sswi_ipi_virq);
+
+	return 0;
+}
+
+static int __init thead_aclint_sswi_parse_irq(struct fwnode_handle *fwnode,
+					      void __iomem *reg)
+{
+	struct of_phandle_args parent;
+	unsigned long hartid;
+	u32 contexts, i;
+	int rc, cpu;
+
+	contexts = of_irq_count(to_of_node(fwnode));
+	if (!(contexts)) {
+		pr_err("%pfwP: no ACLINT SSWI context available\n", fwnode);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < contexts; i++) {
+		rc = of_irq_parse_one(to_of_node(fwnode), i, &parent);
+		if (rc)
+			return rc;
+
+		rc = riscv_of_parent_hartid(parent.np, &hartid);
+		if (rc)
+			return rc;
+
+		if (parent.args[0] != RV_IRQ_SOFT)
+			return -ENOTSUPP;
+
+		cpu = riscv_hartid_to_cpuid(hartid);
+
+		per_cpu(sswi_cpu_regs, cpu) = reg + i * THEAD_ACLINT_xSWI_REGISTER_SIZE;
+	}
+
+	pr_info("%pfwP: register %u CPU%s\n", fwnode, contexts, str_plural(contexts));
+
+	return 0;
+}
+
+static int __init thead_aclint_sswi_probe(struct fwnode_handle *fwnode)
+{
+	struct irq_domain *domain;
+	void __iomem *reg;
+	int virq, rc;
+
+	/* If it is T-HEAD CPU, check whether SSWI is enabled */
+	if (riscv_cached_mvendorid(0) == THEAD_VENDOR_ID &&
+	    !(csr_read(THEAD_C9XX_CSR_SXSTATUS) & THEAD_C9XX_SXSTATUS_CLINTEE))
+		return -ENOTSUPP;
+
+	if (!is_of_node(fwnode))
+		return -EINVAL;
+
+	reg = of_iomap(to_of_node(fwnode), 0);
+	if (!reg)
+		return -ENOMEM;
+
+	/* Parse SSWI setting */
+	rc = thead_aclint_sswi_parse_irq(fwnode, reg);
+	if (rc < 0)
+		return rc;
+
+	/* If mulitple SSWI devices are present, do not register irq again */
+	if (sswi_ipi_virq)
+		return 0;
+
+	/* Find riscv intc domain and create IPI irq mapping */
+	domain = irq_find_matching_fwnode(riscv_get_intc_hwnode(), DOMAIN_BUS_ANY);
+	if (!domain) {
+		pr_err("%pfwP: Failed to find INTC domain\n", fwnode);
+		return -ENOENT;
+	}
+
+	sswi_ipi_virq = irq_create_mapping(domain, RV_IRQ_SOFT);
+	if (!sswi_ipi_virq) {
+		pr_err("unable to create ACLINT SSWI IRQ mapping\n");
+		return -ENOMEM;
+	}
+
+	/* Register SSWI irq and handler */
+	virq = ipi_mux_create(BITS_PER_BYTE, thead_aclint_sswi_ipi_send);
+	if (virq <= 0) {
+		pr_err("unable to create muxed IPIs\n");
+		irq_dispose_mapping(sswi_ipi_virq);
+		return virq < 0 ? virq : -ENOMEM;
+	}
+
+	irq_set_chained_handler(sswi_ipi_virq, thead_aclint_sswi_ipi_handle);
+
+	cpuhp_setup_state(CPUHP_AP_IRQ_THEAD_ACLINT_SSWI_STARTING,
+			  "irqchip/thead-aclint-sswi:starting",
+			  thead_aclint_sswi_starting_cpu,
+			  thead_aclint_sswi_dying_cpu);
+
+	riscv_ipi_set_virq_range(virq, BITS_PER_BYTE);
+
+	/* Announce that SSWI is providing IPIs */
+	pr_info("providing IPIs using THEAD ACLINT SSWI\n");
+
+	return 0;
+}
+
+static int __init thead_aclint_sswi_early_probe(struct device_node *node,
+						struct device_node *parent)
+{
+	return thead_aclint_sswi_probe(&node->fwnode);
+}
+IRQCHIP_DECLARE(thead_aclint_sswi, "thead,c900-aclint-sswi", thead_aclint_sswi_early_probe);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 2361ed4d2b15..799052249c7b 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -147,6 +147,7 @@ enum cpuhp_state {
 	CPUHP_AP_IRQ_EIOINTC_STARTING,
 	CPUHP_AP_IRQ_AVECINTC_STARTING,
 	CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
+	CPUHP_AP_IRQ_THEAD_ACLINT_SSWI_STARTING,
 	CPUHP_AP_IRQ_RISCV_IMSIC_STARTING,
 	CPUHP_AP_IRQ_RISCV_SBI_IPI_STARTING,
 	CPUHP_AP_ARM_MVEBU_COHERENCY,
-- 
2.47.0


