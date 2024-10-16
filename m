Return-Path: <linux-kernel+bounces-367341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A052C9A0124
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3C141C221ED
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 06:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE9318C92B;
	Wed, 16 Oct 2024 06:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="GaR/OYs3"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD63818C356
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 06:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729059200; cv=none; b=Wuz7L3sfvKYbN3TlGJy5bPVI3Rl5mqy/nMgztbsbt6NjUYtslYEKKLb5iLr51PyLVw6d6hBklGOIZE23M12v6shxmbeK4hx266WRr0pQEbRo0CPvSZpQlWaTWTFU+kzCDUIoQOceVJZfqr6SVQdvW9h8aBgDkiYtDcn8ZJ10YwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729059200; c=relaxed/simple;
	bh=DQm92EY9g3g//Bfa0OdblcMWCFRDPlfe/mp4eikh3+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DsiYxNXgBCVwahWmHCOODg5CvOfZ+WEvbxKMQ1pbFanZqebweSi+D4sD3JkTw3Yw/4JmF10oDYEJ8eUwW4qqhBut2YhfIZHG4T49Z421I+wjjKURgxbOnwhatupy+6rP/vFAANTZm6AIJ+8NPoWoS04naDJrsebG6PxgbLmxCzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=GaR/OYs3; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a99f629a7aaso97368566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 23:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1729059197; x=1729663997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tubikTbz3aK504vdDHlUvSlhgJacrpoiHsGwKa1FeHU=;
        b=GaR/OYs3ARt15pfE9sUc0wbwdw1OeGHBgAAt3hxrMtBp+yT+XSWutMqR6FNb3F88mk
         OAwlUik1O199AWQUtsblH4goWXZmrdRvgbOnfnZoLItekMw6WQ515lNSJa1wQ1hC3/Ne
         JUKLBkcAJC8aCJf8ug0D2F3+CDaH2FogXOCE44YOUQDgOQ85laqeynHghqWuwL+oxWoi
         y/C6onUUIrygvuczrU9s1I6b06Q7JF0vgc/ScLHIW8dSBh80iL17jvTyhPmLxkvOhnJu
         dMyVpJ00/DGarCW+DeoanBM+ayds+WiqDUp4TsIOlUGU2dyPTzOGF9WduW+/0MZpTy0q
         jO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729059197; x=1729663997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tubikTbz3aK504vdDHlUvSlhgJacrpoiHsGwKa1FeHU=;
        b=gEG826lgykOWIn+waR7PlJiu1h8kbafYKd2yFeEGezHi4SfZuiab+P8S6m+hSOjcVF
         KDUX0TGN7WzHeRJbwKfVd5s4cv1Abg5biFQvHo2FZOlDBuuU5swX7WiaClpNaBYFO90T
         9RQj0Yd42oA1I3hE6cAdmYoeNJ+iAyBKAsh2rDcG29eL0Fm3lorYs8FoWka0Hn6Fctnh
         1VkseJlBD/hNZLjL37RsOAYFQFak6MEFlZFkbHSXO7IV9kwoiL8IMrnnjj1jGd6YYq6O
         6/ul25Eb5TzmALRiwdBrDQNDzHRgGpgB16OoLeo8AlLWdrgZeRqjwMGCzrBWB8AURQOC
         k2IA==
X-Forwarded-Encrypted: i=1; AJvYcCVB5Eu0QORypZiD6dId9IwAA6c7MMZ1F/Ijqbdfe5qcRS2/VjCXrsLtM92Dlmh5Nyem5dqKsKG2iVrFGfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQVRdw4NzUvGkzSUKiyMgRJemOHkE5QnYxLRVoxc3qZzL2otUo
	Ta3kuboxBAsxd3pcPlOCl7We36mQsHWbWIYD1/z78sBIypmCnA45u1HBcOYObnNmGrbeMKP5FGA
	D
X-Google-Smtp-Source: AGHT+IHTOZ0bapzfeNKQO9WFhKPQ8x8c3UZUvsf+373KMi/WoNgvN3yeam5w8ZyHJdh0RzvKccuxbw==
X-Received: by 2002:a17:906:730b:b0:a99:5f65:fd9a with SMTP id a640c23a62f3a-a9a336c1c33mr284045866b.21.1729059197089;
        Tue, 15 Oct 2024 23:13:17 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a2981702bsm141743466b.112.2024.10.15.23.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 23:13:16 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v9 23/37] drivers/arm: Implement acpi_fill_madt
Date: Wed, 16 Oct 2024 08:04:09 +0200
Message-ID: <20241016060523.888804-24-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241016060523.888804-1-patrick.rudolph@9elements.com>
References: <20241016060523.888804-1-patrick.rudolph@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fill the MADT table in the GIC driver and armv8 CPU driver to
drop SoC specific code. While the GIC only needs devicetree
data, the CPU driver needs additional information stored in
the cpu_plat struct.

While on it update the only board making use of the existing
drivers and writing ACPI MADT in mainboard code.

TEST: Booted on QEMU sbsa-ref using GICV3 driver model generated MADT.
      Booted on QEMU raspb4 using GICV2 driver model generated MADT.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Cc: Simon Glass <sjg@chromium.org>
---
Changelog v4:
- Read everything from the DT
- Export armv8_cpu_fill_madt() to use it in other CPU drivers
- Depend on IRQ
Changelog v6:
- Update header order
---
 arch/arm/lib/gic-v3-its.c | 89 ++++++++++++++++++++++++++++++++++++++-
 drivers/cpu/Kconfig       |  1 +
 drivers/cpu/armv8_cpu.c   | 80 ++++++++++++++++++++++++++++++++++-
 drivers/cpu/armv8_cpu.h   | 10 +++++
 4 files changed, 178 insertions(+), 2 deletions(-)

diff --git a/arch/arm/lib/gic-v3-its.c b/arch/arm/lib/gic-v3-its.c
index 58f8bf864f..51cc239776 100644
--- a/arch/arm/lib/gic-v3-its.c
+++ b/arch/arm/lib/gic-v3-its.c
@@ -5,9 +5,11 @@
 #include <cpu_func.h>
 #include <dm.h>
 #include <irq.h>
+#include <asm/acpi_table.h>
 #include <asm/gic.h>
 #include <asm/gic-v3.h>
 #include <asm/io.h>
+#include <dm/acpi.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <linux/bitops.h>
 #include <linux/printk.h>
@@ -28,12 +30,14 @@ static u32 lpi_id_bits;
 struct gic_v3_its_priv {
 	ulong gicd_base;
 	ulong gicr_base;
+	ulong gicr_length;
 };
 
 static int gic_v3_its_get_gic_addr(struct gic_v3_its_priv *priv)
 {
 	struct udevice *dev;
 	fdt_addr_t addr;
+	fdt_size_t size;
 	int ret;
 
 	ret = uclass_get_device_by_driver(UCLASS_IRQ,
@@ -51,12 +55,13 @@ static int gic_v3_its_get_gic_addr(struct gic_v3_its_priv *priv)
 	}
 	priv->gicd_base = addr;
 
-	addr = dev_read_addr_index(dev, 1);
+	addr = dev_read_addr_size_index(dev, 1, &size);
 	if (addr == FDT_ADDR_T_NONE) {
 		pr_err("%s: failed to get GICR address\n", __func__);
 		return -EINVAL;
 	}
 	priv->gicr_base = addr;
+	priv->gicr_length = size;
 
 	return 0;
 }
@@ -160,6 +165,42 @@ int gic_lpi_tables_init(u64 base, u32 num_redist)
 	return 0;
 }
 
+#ifdef CONFIG_ACPIGEN
+/**
+ * acpi_gicv3_fill_madt() - Fill out the body of the MADT
+ *
+ * Write GICD and GICR tables based on collected devicetree data.
+ *
+ * @dev: Device to write ACPI tables for
+ * @ctx: ACPI context to write MADT sub-tables to
+ * Return: 0 if OK
+ */
+static int acpi_gicv3_fill_madt(const struct udevice *dev, struct acpi_ctx *ctx)
+{
+	struct acpi_madt_gicd *gicd;
+	struct acpi_madt_gicr *gicr;
+
+	struct gic_v3_its_priv priv;
+
+	if (gic_v3_its_get_gic_addr(&priv))
+		return -EINVAL;
+
+	gicd = ctx->current;
+	acpi_write_madt_gicd(gicd, dev_seq(dev), priv.gicd_base, 3);
+	acpi_inc(ctx, gicd->length);
+
+	gicr = ctx->current;
+	acpi_write_madt_gicr(gicr, priv.gicr_base, priv.gicr_length);
+	acpi_inc(ctx, gicr->length);
+
+	return 0;
+}
+
+struct acpi_ops gic_v3_acpi_ops = {
+	.fill_madt	= acpi_gicv3_fill_madt,
+};
+#endif
+
 static const struct udevice_id gic_v3_ids[] = {
 	{ .compatible = "arm,gic-v3" },
 	{}
@@ -191,4 +232,50 @@ U_BOOT_DRIVER(arm_gic_v3) = {
 	.id		= UCLASS_IRQ,
 	.of_match	= gic_v3_ids,
 	.ops		= &arm_gic_v3_ops,
+	ACPI_OPS_PTR(&gic_v3_acpi_ops)
+};
+
+#ifdef CONFIG_ACPIGEN
+/**
+ * acpi_gic_its_fill_madt() - Fill out the body of the MADT
+ *
+ * Write ITS tables based on collected devicetree data.
+ *
+ * @dev: Device to write ACPI tables for
+ * @ctx: ACPI context to write MADT sub-tables to
+ * Return: 0 if OK
+ */
+static int acpi_gic_its_fill_madt(const struct udevice *dev, struct acpi_ctx *ctx)
+{
+	struct acpi_madt_its *its;
+	fdt_addr_t addr;
+
+	addr = dev_read_addr_index(dev, 0);
+	if (addr == FDT_ADDR_T_NONE) {
+		pr_err("%s: failed to get GIC ITS address\n", __func__);
+		return -EINVAL;
+	}
+
+	its = ctx->current;
+	acpi_write_madt_its(its, dev_seq(dev), addr);
+	acpi_inc(ctx, its->length);
+
+	return 0;
+}
+
+struct acpi_ops gic_v3_its_acpi_ops = {
+	.fill_madt	= acpi_gic_its_fill_madt,
+};
+#endif
+
+static const struct udevice_id gic_v3_its_ids[] = {
+	{ .compatible = "arm,gic-v3-its" },
+	{}
+};
+
+U_BOOT_DRIVER(arm_gic_v3_its) = {
+	.name		= "gic-v3-its",
+	.id		= UCLASS_IRQ,
+	.of_match	= gic_v3_its_ids,
+	ACPI_OPS_PTR(&gic_v3_its_acpi_ops)
 };
diff --git a/drivers/cpu/Kconfig b/drivers/cpu/Kconfig
index 9c0df331d7..4cc3679c00 100644
--- a/drivers/cpu/Kconfig
+++ b/drivers/cpu/Kconfig
@@ -29,6 +29,7 @@ config CPU_RISCV
 config CPU_ARMV8
 	bool "Enable generic ARMv8 CPU driver"
 	depends on CPU && ARM64
+	select IRQ
 	help
 	  Support CPU cores for armv8 architecture.
 
diff --git a/drivers/cpu/armv8_cpu.c b/drivers/cpu/armv8_cpu.c
index 19f072be43..4eedfe5e2c 100644
--- a/drivers/cpu/armv8_cpu.c
+++ b/drivers/cpu/armv8_cpu.c
@@ -4,10 +4,11 @@
  */
 #include <cpu.h>
 #include <dm.h>
+#include <irq.h>
 #include <acpi/acpigen.h>
 #include <asm/armv8/cpu.h>
-#include <dm/acpi.h>
 #include <asm/io.h>
+#include <dm/acpi.h>
 #include <linux/bitops.h>
 #include <linux/printk.h>
 #include <linux/sizes.h>
@@ -47,8 +48,85 @@ int armv8_cpu_fill_ssdt(const struct udevice *dev, struct acpi_ctx *ctx)
 	return 0;
 }
 
+int armv8_cpu_fill_madt(const struct udevice *dev, struct acpi_ctx *ctx)
+{
+	struct acpi_madt_gicc *gicc;
+	struct cpu_plat *cpu_plat;
+	struct udevice *gic;
+	u64 gicc_gicv = 0;
+	u64 gicc_gich = 0;
+	u64 gicc_gicr_base = 0;
+	u64 gicc_phys_base = 0;
+	u32 gicc_perf_gsiv = 0;
+	u64 gicc_mpidr;
+	u32 gicc_vgic_maint_irq = 0;
+	int addr_index;
+	fdt_addr_t addr;
+	int ret;
+	struct irq req_irq;
+
+	cpu_plat = dev_get_parent_plat(dev);
+	if (!cpu_plat)
+		return 0;
+
+	ret = irq_get_interrupt_parent(dev, &gic);
+	if (ret) {
+		log_err("%s: Failed to find interrupt parent for %s\n",
+			__func__, dev->name);
+		return -ENODEV;
+	}
+
+	addr_index = 1;
+
+	if (device_is_compatible(gic, "arm,gic-v3")) {
+		addr = dev_read_addr_index(gic, addr_index++);
+		if (addr != FDT_ADDR_T_NONE)
+			gicc_gicr_base = addr;
+	}
+
+	addr = dev_read_addr_index(gic, addr_index++);
+	if (addr != FDT_ADDR_T_NONE)
+		gicc_phys_base = addr;
+
+	addr = dev_read_addr_index(gic, addr_index++);
+	if (addr != FDT_ADDR_T_NONE)
+		gicc_gich = addr;
+
+	addr = dev_read_addr_index(gic, addr_index++);
+	if (addr != FDT_ADDR_T_NONE)
+		gicc_gicv = addr;
+
+	ret = irq_get_by_index(gic, 0, &req_irq);
+	if (!ret)
+		gicc_vgic_maint_irq = req_irq.id;
+
+	gicc_mpidr = dev_read_u64_default(dev, "reg", 0);
+	if (!gicc_mpidr)
+		gicc_mpidr = dev_read_u32_default(dev, "reg", 0);
+
+	/*
+	 * gicc_vgic_maint_irq and gicc_gicv are the same for every CPU
+	 */
+	gicc = ctx->current;
+	acpi_write_madt_gicc(gicc,
+			     dev_seq(dev),
+			     gicc_perf_gsiv, /* FIXME: needs a PMU driver */
+			     gicc_phys_base,
+			     gicc_gicv,
+			     gicc_gich,
+			     gicc_vgic_maint_irq,
+			     gicc_gicr_base,
+			     gicc_mpidr,
+			     0); /* FIXME: Not defined in DT */
+
+	acpi_inc(ctx, gicc->length);
+
+	return 0;
+}
+
 struct acpi_ops armv8_cpu_acpi_ops = {
 	.fill_ssdt	= armv8_cpu_fill_ssdt,
+	.fill_madt	= armv8_cpu_fill_madt,
 };
 #endif
 
diff --git a/drivers/cpu/armv8_cpu.h b/drivers/cpu/armv8_cpu.h
index 2c4b0252cf..48c705e98d 100644
--- a/drivers/cpu/armv8_cpu.h
+++ b/drivers/cpu/armv8_cpu.h
@@ -18,4 +18,14 @@
  */
 int armv8_cpu_fill_ssdt(const struct udevice *dev, struct acpi_ctx *ctx);
 
+/**
+ * armv8_cpu_fill_madt() - Fill the MADT
+ * Parses the FDT and writes the MADT subtables.
+ *
+ * @dev: cpu device to generate ACPI tables for
+ * @ctx: ACPI context pointer
+ * @return:	0 if OK, or a negative error code.
+ */
+int armv8_cpu_fill_madt(const struct udevice *dev, struct acpi_ctx *ctx);
+
 #endif
\ No newline at end of file
-- 
2.46.2


