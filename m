Return-Path: <linux-kernel+bounces-324260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31801974A61
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D543B247D4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 06:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A00813AA3E;
	Wed, 11 Sep 2024 06:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="f6YD8gjg"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BE886126
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 06:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726035958; cv=none; b=HKs5/+IlAqrqHwTk0IM9ggpcocBAkPr1uGkRDsunLImAeRlKx7t/5Li/0fagP9ViPkfQCMNJXRF58J/JvJrG/aBzlxzUEsTDkR2nb9kkmcRlwqTN3qBg421yx7hesikJ1QNt6XSm2K3krJ3i9GJOGcDDGbz9FyJmDaztsTrIChs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726035958; c=relaxed/simple;
	bh=/LeCBS8mjhKQXS7w1JA5+JeInNGw91NaU0NrjKOWB4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XwH7/Y8lhD+k9cP/gKvuCTLOGt5i1GC+E26NxJXyvI8PoC+YYuFN4Wk2WsqzvazpVrCRj9FXxReKf/BwmX781FOptgs5AYpreNmguTiWSlfSdIp/eIui8y2tpQrXIh+8q9QT2fBG4Oz7kWg+9hz52SE868ZshcoS8E4r/aCzP78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=f6YD8gjg; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8d0d82e76aso91917066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 23:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1726035955; x=1726640755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O82NXY4OOxMCW+IffUo9t7GkjADLqx3XbLoFYIl9DJE=;
        b=f6YD8gjgoC65NChNyEZ87gEtmE602+dGtRM3MkMnXHhUU1Stnzn9LMr0ERfhMuHEiT
         7oFGugbr0ABBNAwxsc1dnHGzwHOjAxkhnkboDSNLyFcPRfwZkhm6oWXhXZSm+XhTSDQr
         zc6Ey6L+o84F1gUPFkpJJKY5McnCLfGpkMNFGEDKzvvCCIqb0KB5kUWMeY2Mla6oG4Ff
         gQt9G+v8M4/9c+o92oh6Tf7gTwv5A8Fgzx+tCzavtpmgOjLEUStBQUIrTFvuFjqKUsvs
         47JwM+KBC7UAZWHBKSqg0LWpZH3f/BTQ8wxFTbnx3sUCvlSxwzY2A0Ng5Vu/X3I2B4uN
         tVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726035955; x=1726640755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O82NXY4OOxMCW+IffUo9t7GkjADLqx3XbLoFYIl9DJE=;
        b=PkPic8+1jDyLP2o8NRyrbNNMWQNBxK4qBqaslo8oyOGCbIwZtM+aSMEQ4I5WLCj5Fh
         wlZMMYYiz5bfnVeK+ABO6E8AO18YXsCNxE/PjBAbsF3O7WN2lg96cUja0O/mM+8yxw8I
         egJAS+dfXhvySjalSoSaGXH3kXZPTKV9GTlBhLjWQt9kzfuZ+HEvnLtPe0MDaGlOh3Vu
         Q0rhK2y2XAo409elqoWBzbAFpZ4bYKlN/xriqBhlCiPmmF/tBaASd83c8HqWMTHUOuGW
         +ktcxDlq/RPtK5CPER/+XDW6gzLoCMq8jhIWca8hBlF0nmwd7U+TkLLUslpATIsJD+wE
         oimA==
X-Forwarded-Encrypted: i=1; AJvYcCXXXv7CKtaGlI7pivl3CPrRz0yQd8EcqfcAFOsK38tOrTqc5LFwmMyT7YNy1PKwR9uL71fA0aj3GY4Ci8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO2sxPHPh9hxrVSXJIMXcccqQPZz1F/i9+X8XU5ys6V7eJHjAm
	F+ZS0Akkhnh5Suq46ABKnRRIdHMjAbqmzMQkxEjDEFZ9nCHnJYjJVHzNdzsEDp5G35SSW1v2jOt
	e
X-Google-Smtp-Source: AGHT+IF9wvhZaq400lmvXyRwGUvCfcTqv4LQ6N9nOAuIRi2LNj5VjQzsN2+WPwcoTqltb9zLaDf2QQ==
X-Received: by 2002:a17:906:dc92:b0:a7a:3928:3529 with SMTP id a640c23a62f3a-a8ffaaa54d0mr286666966b.13.1726035955028;
        Tue, 10 Sep 2024 23:25:55 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25a43365sm575545366b.94.2024.09.10.23.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 23:25:54 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 20/30] drivers/arm: Implement acpi_fill_madt
Date: Wed, 11 Sep 2024 08:24:10 +0200
Message-ID: <20240911062511.494855-21-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911062511.494855-1-patrick.rudolph@9elements.com>
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
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

TEST: Booted on QEMU sbsa using driver model generated MADT.
Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Simon Glass <sjg@chromium.org>
---
 arch/arm/lib/acpi_table.c |  1 +
 arch/arm/lib/gic-v3-its.c | 89 ++++++++++++++++++++++++++++++++++++++-
 drivers/cpu/armv8_cpu.c   | 27 ++++++++++++
 include/cpu.h             | 27 +++++++++++-
 4 files changed, 141 insertions(+), 3 deletions(-)

diff --git a/arch/arm/lib/acpi_table.c b/arch/arm/lib/acpi_table.c
index 8c17e9eb36..75a0bc5b6e 100644
--- a/arch/arm/lib/acpi_table.c
+++ b/arch/arm/lib/acpi_table.c
@@ -10,6 +10,7 @@
 #include <acpi/acpigen.h>
 #include <acpi/acpi_device.h>
 #include <acpi/acpi_table.h>
+#include <dm/acpi.h>
 #include <string.h>
 
 void acpi_write_madt_gicc(struct acpi_madt_gicc *gicc, uint cpu_num,
diff --git a/arch/arm/lib/gic-v3-its.c b/arch/arm/lib/gic-v3-its.c
index 22fa46a341..23769c46b5 100644
--- a/arch/arm/lib/gic-v3-its.c
+++ b/arch/arm/lib/gic-v3-its.c
@@ -7,6 +7,8 @@
 #include <asm/gic.h>
 #include <asm/gic-v3.h>
 #include <asm/io.h>
+#include <asm/acpi_table.h>
+#include <dm/acpi.h>
 #include <linux/bitops.h>
 #include <linux/printk.h>
 #include <linux/sizes.h>
@@ -26,12 +28,14 @@ static u32 lpi_id_bits;
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
@@ -49,12 +53,13 @@ static int gic_v3_its_get_gic_addr(struct gic_v3_its_priv *priv)
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
@@ -158,6 +163,42 @@ int gic_lpi_tables_init(u64 base, u32 num_redist)
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
@@ -167,4 +208,50 @@ U_BOOT_DRIVER(arm_gic_v3) = {
 	.name		= "gic-v3",
 	.id		= UCLASS_IRQ,
 	.of_match	= gic_v3_ids,
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
diff --git a/drivers/cpu/armv8_cpu.c b/drivers/cpu/armv8_cpu.c
index 08b8d45f6f..6dcfc14751 100644
--- a/drivers/cpu/armv8_cpu.c
+++ b/drivers/cpu/armv8_cpu.c
@@ -64,8 +64,35 @@ static int acpi_cpu_fill_ssdt(const struct udevice *dev, struct acpi_ctx *ctx)
 	return 0;
 }
 
+static int acpi_cpu_fill_madt(const struct udevice *dev, struct acpi_ctx *ctx)
+{
+	struct acpi_madt_gicc *gicc;
+	struct cpu_plat *cpu_plat;
+
+	cpu_plat = dev_get_parent_plat(dev);
+	if (!cpu_plat)
+		return 0;
+
+	gicc = ctx->current;
+	acpi_write_madt_gicc(gicc,
+			     cpu_plat->gicc_cpu_if_num,
+			     cpu_plat->gicc_perf_gsiv,
+			     cpu_plat->gicc_phys_base,
+			     cpu_plat->gicc_gicv,
+			     cpu_plat->gicc_gich,
+			     cpu_plat->gicc_vgic_maint_irq,
+			     cpu_plat->gicc_gicr_base,
+			     cpu_plat->gicc_mpidr,
+			     cpu_plat->gicc_efficiency);
+
+	acpi_inc(ctx, gicc->length);
+
+	return 0;
+}
+
 struct acpi_ops armv8_cpu_acpi_ops = {
 	.fill_ssdt	= acpi_cpu_fill_ssdt,
+	.fill_madt	= acpi_cpu_fill_madt,
 };
 #endif
 
diff --git a/include/cpu.h b/include/cpu.h
index 0018910d61..c2a4ca08fe 100644
--- a/include/cpu.h
+++ b/include/cpu.h
@@ -13,17 +13,29 @@ struct udevice;
 
 /**
  * struct cpu_plat - platform data for a CPU
- * @cpu_id:	   Platform-specific way of identifying the CPU.
+ * @cpu_id:        Platform-specific way of identifying the CPU.
  * @ucode_version: Microcode version, if CPU_FEAT_UCODE is set
  * @device_id:     Driver-defined device identifier
  * @family:        DMTF CPU Family identifier
  * @id:            DMTF CPU Processor identifier
  * @timebase_freq: the current frequency at which the cpu timer timebase
- *		   registers are updated (in Hz)
+ *                 registers are updated (in Hz)
+ * @gicc_cpu_if_num:     GIC's CPU Interface Number
+ * @gicc_perf_gsiv:      The GSIV used for Performance Monitoring Interrupts
+ * @gicc_phys_base:      Address at which the processor can access this
+ *                       GIC CPU Interface
+ * @gicc_gicv:           Address of the GIC virtual CPU interface registers
+ * @gicc_gich:           Address of the GIC virtual interface control block
+ *                       registers
+ * @gicc_vgic_maint_irq: GSIV for Virtual GIC maintenance interrupt
+ * @gicc_gicr_base:      Physical address of the associated Redistributor
+ * @gicc_mpidr:          MPIDR as defined by ARM architecture
+ * @gicc_efficiency:     Describes the relative power efficiency
  *
  * This can be accessed with dev_get_parent_plat() for any UCLASS_CPU
  * device.
  */
+
 struct cpu_plat {
 	int cpu_id;
 	int ucode_version;
@@ -31,6 +43,17 @@ struct cpu_plat {
 	u16 family;
 	u32 id[2];
 	u32 timebase_freq;
+#if defined(CONFIG_GENERATE_ACPI_TABLE)
+	u32 gicc_cpu_if_num;
+	u32 gicc_perf_gsiv;
+	u64 gicc_phys_base;
+	u64 gicc_gicv;
+	u64 gicc_gich;
+	u32 gicc_vgic_maint_irq;
+	u64 gicc_gicr_base;
+	u64 gicc_mpidr;
+	u8  gicc_efficiency;
+#endif
 };
 
 /* CPU features - mostly just a placeholder for now */
-- 
2.46.0


