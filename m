Return-Path: <linux-kernel+bounces-357973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A9D9978A7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 00:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C1C11F21379
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 22:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A5C15D5D9;
	Wed,  9 Oct 2024 22:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKMgObJ7"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5D11E3DDC;
	Wed,  9 Oct 2024 22:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728513882; cv=none; b=BB6Cku+z1Uy5+QuffQOMZB+1g2a1TQM4t4z9PheWFnWQ93TEkbp6Fw0qujN+KWC/gxpiJL8KgS7yY5SWp70Vt4wcAstxakgBByyWBoCiWoYseZ0AOI9dDCopVBSy0VGQ6n8UOw+PVwxFe+CgK+SNR4JoLaQGOBrNCobd6aRKiUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728513882; c=relaxed/simple;
	bh=G+Znt97oRSs6u0DDve0CwkBO9yJZhZxAXIpY01/i+BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQsgx+uOE/CMdSB5T9ghURNopbbZr19Ap5XSrPenDnD+5KM2S0IlmwLO31u9ukXmWPmXCsxsY073WuRV2bg3/UZ/KL73KQPG6pqBmgRQmir3LrKALct8byrj01C20hmc+aPY4FbTbWqHFLHVYyph0Xiq5JUFzmaa6U0WmzkoLYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKMgObJ7; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71def8abc2fso266983b3a.1;
        Wed, 09 Oct 2024 15:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728513880; x=1729118680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQiYNef7ArPYQlhe07XyLMGs/XiAOe7Z31NtUB9uYxQ=;
        b=VKMgObJ7neLXCBALUvpp5CPBCcN2O5bPOef4V7GzdmgrJ43AJieUkZLK90cYtVT1rB
         7dWxQs0rXjhGirQ0A/KRTA9xA8u1wXWhq3PQgrSZdnnECzq789903cJ5ZqfQgYQWWWu4
         QVTqPmZB0+0NU/E7/Q+qc7fZkwMfdJlcY2qulBJtDffU3PBC/txWBLAgKbRsLKyfDT38
         hXOZ4lgMQticOpjG3ra6yCv/TtJYAAi15PZjj2nSRBtkK9WzRqkEU/DVoOe3qQNGwF6a
         6HJxEnvESkTThq2Tnk9HICjbDY37ABxFwGBt65ZUwxoO34sD9+Mri2+a0tMU0o9p87EV
         McSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728513880; x=1729118680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQiYNef7ArPYQlhe07XyLMGs/XiAOe7Z31NtUB9uYxQ=;
        b=FzLanP8W0o8keEetKJdkck9U2R6DlpXAPAmezcafWiH5Fn1y5p5LCIlgIn9rmsdCgm
         OWFquy6JIGIbY2cX/GsrTVbBQn6IgAt8H7PPwQ1rMGptvLYjcOs2DCeaIwa2VbD91lXm
         QGqXseNAw6yRmnHmUs+mOsWNzDw2rhbtrE3rT399rO2LJ0c5CiM6g1rWZEtAGS1tEaQM
         5amCAsk2/JsmF4WqJ5CyltqjUbvdFTwhQ0ZTFmLZGpXQTdyOYlOnCWjgrQ42PKhEQFcj
         xoaN4I3tWIAD34BcncnTokTUifMVtRBs2FLbRSk7A7jm4vFOdoEV876wchlvPo3HyftP
         zDEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHaED3YRz52cxUIFg+hJOB8O2Y8mOR909WgLTo6TqaYwgCJrCckE9IHmau7uDPHf6y73qvhe5n24Xh@vger.kernel.org, AJvYcCWQCn+TbOy8j08iqM3u2pafsU62PiWmx22/5hPBsZvC3N4VDyLq+pg5f+wyOahpRhlU7prjavGZq9xLfJkD@vger.kernel.org
X-Gm-Message-State: AOJu0YzkFMyT0Eb6yGxeE+MqIdJkcxOgIoVL0X7Mlss7EBYY21lU6Cpx
	zddn46SCO9mFFPQV/Yaqm5otfiWglixClTKDvvV7dDXlUe5lGZR3
X-Google-Smtp-Source: AGHT+IFxTbeLG1Jh9xQz1Jop82g/peuBRGEbOM2+MGKlD7JAInvly69FNZ6RedmRdxOnx1QAzgGC5A==
X-Received: by 2002:a05:6a21:1706:b0:1d8:ae07:c02 with SMTP id adf61e73a8af0-1d8ae070e7cmr1797936637.47.1728513879652;
        Wed, 09 Oct 2024 15:44:39 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f680a681sm8792461a12.14.2024.10.09.15.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 15:44:39 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Peter Zijlstra <peterz@infradead.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Guo Ren <guoren@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Jinyu Tang <tangjinyu@tinylab.org>,
	Hal Feng <hal.feng@starfivetech.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Yixun Lan <dlan@gentoo.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 2/3] irqchip: add T-HEAD C900 ACLINT SSWI driver
Date: Thu, 10 Oct 2024 06:44:08 +0800
Message-ID: <20241009224410.53188-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241009224410.53188-1-inochiama@gmail.com>
References: <20241009224410.53188-1-inochiama@gmail.com>
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
 drivers/irqchip/irq-thead-c900-aclint-sswi.c | 166 +++++++++++++++++++
 include/linux/cpuhotplug.h                   |   1 +
 4 files changed, 178 insertions(+)
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
index 000000000000..b96d3b81dc14
--- /dev/null
+++ b/drivers/irqchip/irq-thead-c900-aclint-sswi.c
@@ -0,0 +1,166 @@
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
+
+#define ACLINT_xSWI_REGISTER_SIZE	4
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
+static int __init aclint_sswi_parse_irq(struct fwnode_handle *fwnode,
+					void __iomem *reg)
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
+		per_cpu(sswi_cpu_regs, cpu) = reg + i * ACLINT_xSWI_REGISTER_SIZE;
+	}
+
+	pr_info("%pfwP: register %u CPU%s\n", fwnode, contexts, str_plural(contexts));
+
+	return 0;
+}
+
+static int __init aclint_sswi_probe(struct fwnode_handle *fwnode)
+{
+	struct irq_domain *domain;
+	void __iomem *reg;
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
+static int __init aclint_sswi_early_probe(struct device_node *node,
+					  struct device_node *parent)
+{
+	return aclint_sswi_probe(&node->fwnode);
+}
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
2.47.0


