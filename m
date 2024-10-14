Return-Path: <linux-kernel+bounces-364114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 247A699CB49
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FD21B23839
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFF51AD9C3;
	Mon, 14 Oct 2024 13:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="DLoFBYfT"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9479D1AD403
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 13:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911570; cv=none; b=F4LV7z4zHx4hPxcw9MRWidxPbek7Kgc3Z5u/EeOab+C6M/9ZiKCD/7A+LRmo2WQJt3aNDmp7G0Q3SG54ptzYiScCtXh2Zzxgaud+USrgZxVq6g4/UM8A+pjcIfjr+l9Fr4Bwqag1tF4vN0cyX+PnB3Ic3gC+gVDwD3Z3wPsjIjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911570; c=relaxed/simple;
	bh=ULPS3rx2Rggy2xdUN3QBRwGtRUeMuF6InxvyLJX6C/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQhzZo9jYgI4axM8cMv1oEMOuC8mg+ySxW+BPJDkgogC06bTqtOV4y+vtTmrLhJ84RMxB8Qdeq6j0bJQcen3E1fz/00/l9/snen9Vy+Qsc5i4PLwZqAewvjVAGOoaz43c2nX1mFiUGxB2+YvwjRwm9cKv2JDC87how3em8HfRQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=DLoFBYfT; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d447de11dso3108896f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 06:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1728911567; x=1729516367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrQY2+xb+lugKHBRrv4kxIlkaNKcIVXX7vgDt2h2bH8=;
        b=DLoFBYfT6y+jv8qnwy4Oi9u8QlVPMQLrHRujoUmITWWDZ752qpqM0NnojlvPQpQMpA
         W0JqiypIj2KAikkHzvonb7zFkZEPQaglHqO4YYl5nVnTSc93w1hm73yQR0hdBiMgN2DZ
         rBXRlF8EZ7+Y/X/wDEhplxYTB5IqRkfaRIN329mtJ816z5Sz/RHUdWGPFbDcevVe8zv0
         p5zoAzTzb+QlIOx4gEmARKIJzO1ehFdwsAhA1AWUQCDUFu0E3Vu24/aE3SnMRLv0QTto
         9WRN91H1Ej5VheDWrcmAwUre+bzosZhpYXANThRlYx0q5meirn9c3ouVU8oGmoNK6++W
         eazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728911567; x=1729516367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xrQY2+xb+lugKHBRrv4kxIlkaNKcIVXX7vgDt2h2bH8=;
        b=HLRYJNXrNdZecHcDQTkV0i+Atmq8vXpXFy369Z05axYRdQ6QBH/4kzBviNoKUkprE4
         N8Rr75D4j92Fc+ZDf6KT+O2JoQwW1DuYYA8LPWgoeFnYxlvaGHfpo8qshIPyNjnAWMVV
         nCIpOP7+z5R2te0pfgle6FA5cIKbU6PFwNNMHcZzAnAbIVEMC+5IpK50KYthoUWkkGzz
         gxebXUP1E0D2juqVHJ6o2v425QiwY0qa6sNzmK+jfC+IR6FXpiB5LWSR673TJEWmNkD+
         D1KdhkJ0suTXEYrWGFaD7tGa3CzhHURHbf4WzWdYjZaInXC51HKD9L0qNwqo4GwB/2Zy
         Phlw==
X-Forwarded-Encrypted: i=1; AJvYcCWmQpQV0KAq2aSTrstLIRA/BNUOqzA5VKS7eQUSKYZ0rP9/BsPdsQrLqq9N3zaNadBbBbm3Yo9HuQMHAcY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2WSsoLf7V3eCQff+9TtTSe01RLKtkFw3mlI6hV4F9JnZQQy33
	5bMn+sWkN/PK27vWHv7bYwsYJNw8DAVivoS4bsaj1FFsTsxAn/GeK+U1rQe2D72+CGTs2Ah4a12
	f
X-Google-Smtp-Source: AGHT+IETGgFoZ1bjlSVu60AU5SRrebY+YNFau4xmrCHeSial+TuG5zhX694vVO7ZoOSQcI/L1M6sww==
X-Received: by 2002:a5d:6b83:0:b0:37d:3742:a5a7 with SMTP id ffacd0b85a97d-37d551fe10dmr6259816f8f.33.1728911566855;
        Mon, 14 Oct 2024 06:12:46 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d605c197bsm7103718f8f.38.2024.10.14.06.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 06:12:46 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v8 23/37] drivers/arm: Implement acpi_fill_madt
Date: Mon, 14 Oct 2024 15:10:39 +0200
Message-ID: <20241014131152.267405-24-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241014131152.267405-1-patrick.rudolph@9elements.com>
References: <20241014131152.267405-1-patrick.rudolph@9elements.com>
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
index 0d5545bfb2..ad1c3d7312 100644
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
 #include <linux/bitops.h>
 #include <linux/printk.h>
 #include <linux/sizes.h>
@@ -27,12 +29,14 @@ static u32 lpi_id_bits;
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
@@ -50,12 +54,13 @@ static int gic_v3_its_get_gic_addr(struct gic_v3_its_priv *priv)
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
@@ -159,6 +164,42 @@ int gic_lpi_tables_init(u64 base, u32 num_redist)
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
@@ -188,4 +229,50 @@ U_BOOT_DRIVER(arm_gic_v3) = {
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


