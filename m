Return-Path: <linux-kernel+bounces-350007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C25CF98FE9C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 10:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16EA3B2108F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 08:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E63144D01;
	Fri,  4 Oct 2024 08:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pa6z8+4G"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BF913E022;
	Fri,  4 Oct 2024 08:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728029198; cv=none; b=KHwwsxdr56r7vYCAMXfZWyGx1IXqDZEmoIUUydpOV7I0QeGSQfCOJ7fulwqIMUYwC7IuinSlVja7eFvRFzZU/byBPmuAt2oPIpNo0kdGoIodMqT8gHSKR5FbwrhcWESuhXGNVEgzebUuZRsVpf+69V4ZkdYoeSmmRF5X4PFKwLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728029198; c=relaxed/simple;
	bh=+vCPUVtODDEZmpA/odzEVJgwaRyPQ9tusdV4hgiTR6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AIfpEUV5w56KTRZ5hTcU52lD5aF7Y5bCJWzfzXpl9Z/4OY+4g0F4oEhM5/1tvxe0SjAbPJ8Ak3WfctChZdMsX3f9Z+LYSoMfM75f5LALF225pBsDIQmAPfgkc3jWr89sfF6g++8hjGtzc6x3MrTpqW2CwJJhSWmN11zUkrPLqfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pa6z8+4G; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-6e7b121be30so1171399a12.1;
        Fri, 04 Oct 2024 01:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728029196; x=1728633996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOeki1FFkiSfFu4/uP0XEVkPckonCqIa/H1tZhw+oW8=;
        b=Pa6z8+4GvDM2whg8UB8uKzbz168wE5HweHKucNd5mCPM8qVgM5tKFPtbH8qzcO4Nsj
         OgHK/aJrSpn/9tjbwUHUw6uY6P7q3ToAF4wp2N2Rgt9HP/prrzq734olLbin6TfZkg1T
         RA/6lRo3MZUKXAGKXyVQr64DDaJP6popAgF+ICsITOBxKfaX6d9sWH17u6HtCCI0NSI7
         Y1NYfyypYED4/XJ91/ybdIzk5ydV073ipshJcC/AJMEQv7pAPFMJQHsNN96YEXGBqiPy
         Xz5/uucgbXgNjToe4OXN9ByeS1vr2XZYNIDg3sZYIeNHCFP6QoRzt5QqTSXwpwVAhdDX
         qY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728029196; x=1728633996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOeki1FFkiSfFu4/uP0XEVkPckonCqIa/H1tZhw+oW8=;
        b=Cu+UZZOT2j03LuyYRiyf8jtOP2RBq5BOS6i0EIbIRBF//wWfwtsAbFZuV1rEAReb5x
         ZDDMWli9DwfPVMW+KcVwNUwMJQ2D7Z6KYbkSL4NjJ7rX9NHx196Xp7HRA/vLHHgWThIr
         GDIy8/JB4Wsb4GaW1ptIKFpEqEiyI70Hsq5AdlEQmIKSOZhhqA0n5WT47+gEctgqbzYh
         DJ0p84Tb9yIgi8f6AGSgqi29ACz9EM/dhmMgzxaqvN68KD/Farxqedwqb/8C44vnjwD3
         30QPbLfLna2AKRvJVCxqY1S21116Xm/ZQvYmKDEbCCsbRLEc28yoVEZG0ztqUlWk9sgS
         5h7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVGvgtcXA1gpLGAd1K3axWdo4xk/w85i7E4v4vgtOmIF6UM9sJe/kYf11SmtGNiC17fbHTOKLCG/+wfN+hh@vger.kernel.org, AJvYcCWcgm63QwGv3lhIgZqu/0DpjiO/xzzZMWOIsknfuLVFHQTsXEFu20QVy0kXyqyR9C6X/dBn/vc70DVw@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2GrjDHoyh7wn0dIt7Kgd1S665WN67QHCH3gJuQtkpENWxwND+
	WTH6PQ3Yz3XD/HgUk3QPlHO1Y38H3KvWvt8XoWX+28dHrA9oCC8c
X-Google-Smtp-Source: AGHT+IELUKe6yfSED3d2riw0GkuDfFvQjLbY9zF5jW+IyaNrLOoL3ohm/AHnRCoVb/dkQ4mGPps5uw==
X-Received: by 2002:a05:6a20:c997:b0:1d1:1795:4b43 with SMTP id adf61e73a8af0-1d6dfa476cemr3067956637.26.1728029195546;
        Fri, 04 Oct 2024 01:06:35 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71de9473894sm601482b3a.211.2024.10.04.01.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 01:06:35 -0700 (PDT)
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
	Hal Feng <hal.feng@starfivetech.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Yixun Lan <dlan@gentoo.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 2/3] irqchip: add T-HEAD C900 ACLINT SSWI driver
Date: Fri,  4 Oct 2024 16:05:56 +0800
Message-ID: <20241004080557.2262872-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241004080557.2262872-1-inochiama@gmail.com>
References: <20241004080557.2262872-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a driver for the T-HEAD C900 ACLINT SSWI device, which is an
enhanced implementation of the RISC-V ACLINT SSWI specification.
This device allows the system to send ipi via fast device interface.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/irqchip/Kconfig                      |  10 ++
 drivers/irqchip/Makefile                     |   1 +
 drivers/irqchip/irq-thead-c900-aclint-sswi.c | 169 +++++++++++++++++++
 include/linux/cpuhotplug.h                   |   1 +
 4 files changed, 181 insertions(+)
 create mode 100644 drivers/irqchip/irq-thead-c900-aclint-sswi.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 341cd9ca5a05..32671385cbb7 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -611,6 +611,16 @@ config STARFIVE_JH8100_INTC

 	  If you don't know what to do here, say Y.

+config THEAD_C900_ACLINT_SSWI
+	bool "THEAD C9XX ACLINT S-mode IPI Interrupt Controller"
+	depends on RISCV
+	select IRQ_DOMAIN_HIERARCHY
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
index 000000000000..7bd06369b409
--- /dev/null
+++ b/drivers/irqchip/irq-thead-c900-aclint-sswi.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Inochi Amaoto <inochiama@gmail.com>
+ */
+
+#define pr_fmt(fmt) "thead-c900-aclint-sswi: " fmt
+#include <linux/acpi.h>
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
+
+#define ACLINT_xSWI_REGISTER_SIZE	4
+
+struct aclint_sswi_cpu_config {
+	void __iomem	*reg;
+	u32		offset;
+};
+
+static int sswi_ipi_virq __ro_after_init;
+static DEFINE_PER_CPU(struct aclint_sswi_cpu_config, sswi_cpus);
+
+static void thead_aclint_sswi_ipi_send(unsigned int cpu)
+{
+	struct aclint_sswi_cpu_config *config = per_cpu_ptr(&sswi_cpus, cpu);
+
+	writel_relaxed(0x1, config->reg + config->offset);
+}
+
+static void thead_aclint_sswi_ipi_clear(void)
+{
+	unsigned int cpu = smp_processor_id();
+	struct aclint_sswi_cpu_config *config = per_cpu_ptr(&sswi_cpus, cpu);
+
+	writel_relaxed(0x0, config->reg + config->offset);
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
+static int aclint_sswi_ipi_starting_cpu(unsigned int cpu)
+{
+	enable_percpu_irq(sswi_ipi_virq, irq_get_trigger_type(sswi_ipi_virq));
+	return 0;
+}
+
+static int aclint_sswi_parse_irq(struct fwnode_handle *fwnode,
+				 void __iomem *reg)
+{
+	struct of_phandle_args parent;
+	unsigned long hartid;
+	u32 contexts, i;
+	int rc, cpu;
+	struct aclint_sswi_cpu_config *config;
+
+	contexts = of_irq_count(to_of_node(fwnode));
+	if (WARN_ON(!(contexts))) {
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
+		config = per_cpu_ptr(&sswi_cpus, cpu);
+
+		config->offset = i * ACLINT_xSWI_REGISTER_SIZE;
+		config->reg = reg;
+	}
+
+	pr_info("%pfwP: register %u CPU\n", fwnode, contexts);
+
+	return 0;
+}
+
+static int __init aclint_sswi_probe(struct fwnode_handle *fwnode)
+{
+	void __iomem *reg;
+	struct irq_domain *domain;
+	int virq, rc;
+
+	if (!is_of_node(fwnode))
+		return -EINVAL;
+
+	reg = of_iomap(to_of_node(fwnode), 0);
+	if (!reg)
+		return -ENOMEM;
+
+	/* Parse SSWI setting */
+	rc = aclint_sswi_parse_irq(fwnode, reg);
+	if (rc < 0)
+		return rc;
+
+	/* If mulitple SSWI devices are present, do not register irq again */
+	if (sswi_ipi_virq)
+		return 0;
+
+	/* Find and create irq domain */
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
+			  aclint_sswi_ipi_starting_cpu, NULL);
+
+	riscv_ipi_set_virq_range(virq, BITS_PER_BYTE);
+
+	/* Announce that SSWI is providing IPIs */
+	pr_info("providing IPIs using THEAD ACLINT SSWI\n");
+
+	return 0;
+}
+
+static int __init aclint_sswi_early_probe(struct device_node *node,
+					  struct device_node *parent)
+{
+	return aclint_sswi_probe(&node->fwnode);
+}
+
+IRQCHIP_DECLARE(thead_aclint_sswi, "thead,c900-aclint-sswi", aclint_sswi_early_probe);
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
2.46.2


