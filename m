Return-Path: <linux-kernel+bounces-375568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5399A9769
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 06:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F332B28194D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 04:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EADD824AF;
	Tue, 22 Oct 2024 04:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3PoXnbY"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3135F8563E;
	Tue, 22 Oct 2024 04:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729569766; cv=none; b=ndW5qdIlbP6vAyKrsI+fPISQbZFeRtZdzseiTs0wWGfdSkEJtmVbEy2Lhjx4XaGl4ER74im0q3rNHKjgOOde1yLdT37syigT8VTdzdpO/ksJfM91j9nHcyr5KDagRRWA1jdiAORK6ksECSiAX8fcDnzbIk+d3js1n8kSWXOgwaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729569766; c=relaxed/simple;
	bh=Rr9oJ483zrQlw97GfdztfU4bXnHBS06K6gGpfmk7TYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ScYGmrKbdRuEvJpF6TEqko+Qe48Hy4+NW21WkFEMkJUvMZjD/QLwdGe+K4vblTOsNDeNzsYuBItTpWPkr+LLeCyIarsxkbuPWQ/1sRQYlwUOb8y2Z75bW3xgIDLiNRmr+U+m2vqOGrxZ1mC05xb/25JeWtqP7Nr43eABer2H17Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3PoXnbY; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71e61b47c6cso3977652b3a.2;
        Mon, 21 Oct 2024 21:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729569764; x=1730174564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+VbakcLlqoj4xLjf3FAI0FFGEm/UarNqoU1aaBvySA=;
        b=Z3PoXnbYShTXC6KfCgUcmTZ6UznLb6vvQI4qmG+PxTigZJFVyOwc/fvU9Dgr3tFgMr
         ktYbuhWEvQKUEuAffVSAo1IuMRdSe9e4npxp0TGOduuutNXmguIq+HfxsaCisdvyL2ci
         F87dZKTFwMjcSvRmgkZRj/zqV1SN5t1wiCtXNWx41CKMH6uAJYB1HtKhM78DDl6SQeO1
         gmRtK6SgcOkyDK+QEvInVATE6+M/elBBdiukufvyo3/ImmREFksbLRiIwiH29wixo9JE
         uRWl13PiHU9vzziSQFOZBxnp8CQPm4Jp1U6c5PHfeERnBrQt0WS1xERn1cssBhG9+0Ia
         98+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729569764; x=1730174564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+VbakcLlqoj4xLjf3FAI0FFGEm/UarNqoU1aaBvySA=;
        b=hMpzs71YUH44qOjzntWnW1T+b8q+vH4AEwJDum7gqu2NfnydyEK/DIHAzUl/B/LBC2
         2pWyDWCaZUXe8H4GJ+jtez0QlKdZjK/Uiq4m6kZy/6tR1VfDPj/GLCTzzyfbphQrpTqV
         DeG6i583jUCVWBpgLE1ZBdTrqXi4W90zQh7JMqcGsSf02KZA/lMZZ5RdnEnoyKgI68Lw
         VGsA8BUCBUbMwiUAIFKIsruRg1n6qg899YFPt3wyZ2neXbIQFB+3cFoCGNl1zjSYzAZl
         tchHHGEHjdVxV1axG/xUVDHgpVOMAGMSZ33aPn/3h5meNJbjhucmT+KrmuhseCMBgvGy
         yDQg==
X-Forwarded-Encrypted: i=1; AJvYcCVGQs+L4KUhgQE2GfLrfVbYRWu9J9+fmXuC7oTqhJAZX0xBcHTxcbxpr71AslUxoWglpop7ax7jmLmqaboC@vger.kernel.org, AJvYcCWdbZNoBFXPWWogJppc7/5ga/pR/8VDzh4RGnYotURulzN/IsBOmIr3dEod/yuuBsFKkulAIccAZzFD@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/V1vcMGBn+CUUImTZVnrMX8MG/h7UepLzIeW+O8msFPWjMtUa
	IJvT4vTo0X4JMhrtVb8hxTIOQreprP5RwQExPtJnlg3hPLjRNzPq
X-Google-Smtp-Source: AGHT+IGrc6dzU3hlE8kadMfycwHOsQtAl+ToJea/stKX8GGjURNkw9Ygp+3Aqj0AopEgYe0hp4nr2w==
X-Received: by 2002:a05:6a00:140c:b0:71e:5150:61d6 with SMTP id d2e1a72fcca58-71ea31d290amr20204371b3a.21.1729569764482;
        Mon, 21 Oct 2024 21:02:44 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1408989sm3710207b3a.213.2024.10.21.21.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 21:02:44 -0700 (PDT)
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
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Hal Feng <hal.feng@starfivetech.com>
Cc: Yixun Lan <dlan@gentoo.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v4 2/3] irqchip: add T-HEAD C900 ACLINT SSWI driver
Date: Tue, 22 Oct 2024 12:02:16 +0800
Message-ID: <20241022040218.450573-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241022040218.450573-1-inochiama@gmail.com>
References: <20241022040218.450573-1-inochiama@gmail.com>
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
 drivers/irqchip/Kconfig                      |  12 ++
 drivers/irqchip/Makefile                     |   1 +
 drivers/irqchip/irq-thead-c900-aclint-sswi.c | 176 +++++++++++++++++++
 include/linux/cpuhotplug.h                   |   1 +
 4 files changed, 190 insertions(+)
 create mode 100644 drivers/irqchip/irq-thead-c900-aclint-sswi.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 341cd9ca5a05..b6e8411f28d3 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -611,6 +611,18 @@ config STARFIVE_JH8100_INTC
 
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
index 000000000000..e1051869a7ab
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
+#define ACLINT_xSWI_REGISTER_SIZE	4
+
+#define THEAD_C9XX_CSR_SXSTATUS		0x5c0
+#define THEAD_C9XX_SXSTATUS_CLINTEE	BIT(17)
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


