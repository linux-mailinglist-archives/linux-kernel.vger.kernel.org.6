Return-Path: <linux-kernel+bounces-332763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F07E397BE87
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 17:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE4C62835DB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 15:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EBE1C8FDE;
	Wed, 18 Sep 2024 15:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="XCe/ojKt"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F2D7A15B
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 15:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726672958; cv=none; b=j4ODo7EQqrHaa3kfKXJFibTyHy4iQdX6cizDCKXE5Q+ud7R3x9pSRw/vt+9+0k9Iei7wmU58iH/ZyZ3aDm9/cUUAR/YVl3euOif5GKbp9CqRRfIqR30pCUX0minEH6vSlVqBN9sY7U14mdbw4KiUCOQUtJw4Ma/8L1LN+eNTwTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726672958; c=relaxed/simple;
	bh=MZLHCP1h47kzoyivY13E06EyzilyHhC1EbhvqKEVF6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMVl3wShKC7dJpJC2DY3nULaJOIa919iFXbMz9ssMejDX5tWAL5CBP7TitITrUQlI3Fce/yFIk4FPZQeIMHzsWpPisqcohkERniWSaOJn04wDH9JVMxYWo/PQ2YfVV01o0GOxtABTbYRRzsysjYN/nrg1aiq3oxecbSEIB5H1gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=XCe/ojKt; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8d2daa2262so727348566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 08:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1726672954; x=1727277754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGmQNVnwMgqJWw2V9noTFVDpJGX2ko2WHTW4N7XqbjU=;
        b=XCe/ojKt2rGxQ9Qwgh4vk9bhr58HRkdZ/Ot4j+URNFDUeKzeH97H5tLl5Rd1UBFjca
         +7JRgU2vcULxoCRPDBKA3VbIILLWXYqXxjD317m4al/vHoz2hd5ziDA2VtUk8WPkxr8T
         UsbrzcNVzIctFpAYeghc5kP3DHTv0kyKqYIiLqc7CjcK5xXCXstL9wc1etJhsv8I/gy2
         yB7uW9ByuA72i0Jsd/EDKkQS6vEmk3UNUDPxKLQ1wpp6P2qICv2kD2upq35XzW/EE8Kx
         IIMKvKa359pmVVPE/nlaQnVjuZ1nm3pfzAJCy0y9XAprIwfXCHKkzJ/JkXPtfpvznaft
         qmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726672954; x=1727277754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGmQNVnwMgqJWw2V9noTFVDpJGX2ko2WHTW4N7XqbjU=;
        b=V3OhRUBqLtOP1FDTe8sNKXT8kgf6a7kllgWH40WjmsyXGgW0C69i7pLmroXJDW7CJU
         42MyvSDw/kYbP81Sj6/qji3031E9eGyvPGoLsL/RFDdZIeLpB/gMw1ccWOaL+N73+HEu
         vhbaTKYnkvQ4m9B7CQD3k8Z2jACeP1KwQ5XcMxI1TCbzlg8zZ++v347Re+qGbCbv0udd
         HQ0CxH7dBPFLSqXGxjOd2PPXgXsosi5s8owJt03vTbtYEtqbKgGjWcOYLXApjpL6LLaQ
         Kiqx9yhguoz2t7E2clIVUV17SNq2aYNC7YN13Vj6ibxamxrF4i6GvdpWmuNMAt4eUlbD
         pJWw==
X-Forwarded-Encrypted: i=1; AJvYcCW6NXkNcHfLke8iUZOONSw7L3l2rhicqnK1fyYVcAwErY3wYB86XvlJANo07z8qplnd8+slAJy0vaKLhhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLSnikgt3eqizGolqofihgmybeM4igNnGwEksgT0pexO/XgfdY
	41zXxea1G8OdxM3FZZ80Lql9Z9rfR5mNTTOs/8zxtQaTiMRlJgkD/O68lLIe2fw=
X-Google-Smtp-Source: AGHT+IEVkKZATYwuPlnQKLFanbssdMNEpIeaJ9on7H+7vB9fXKPAJ5Q5fYaH65CCoGMNCw9hO1Gz/g==
X-Received: by 2002:a17:907:7ba2:b0:a8d:e49:c505 with SMTP id a640c23a62f3a-a9048108047mr1721640266b.45.1726672953691;
        Wed, 18 Sep 2024 08:22:33 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610967b0sm599791266b.42.2024.09.18.08.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 08:22:33 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 18/35] drivers/cpu: Add generic armv8 cpu driver
Date: Wed, 18 Sep 2024 17:20:22 +0200
Message-ID: <20240918152136.3395170-19-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a generic driver that binds to armv8 CPU nodes. The generic driver allows
- to enumerate CPUs present in a system, even when no other driver binds it
- generates ACPI SSDT code for each CPU
- Fill the ACPI MADT table (implemented in a follow up patch)

The newly introduced code could also be reused on other CPU drivers that are
compatible with armv8.

TEST: Booted on QEMU sbsa and verify the driver binds to CPU nodes.
      Confirmed with FWTS that all ACPI processor devices are present.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
---
Changelog v4:
- Export armv8_cpu_fill_ssdt to use it in other CPU drivers

---
 drivers/cpu/Kconfig     |  6 ++++
 drivers/cpu/Makefile    |  2 ++
 drivers/cpu/armv8_cpu.c | 73 +++++++++++++++++++++++++++++++++++++++++
 drivers/cpu/armv8_cpu.h | 21 ++++++++++++
 4 files changed, 102 insertions(+)
 create mode 100644 drivers/cpu/armv8_cpu.c
 create mode 100644 drivers/cpu/armv8_cpu.h

diff --git a/drivers/cpu/Kconfig b/drivers/cpu/Kconfig
index 5c06cd9f60..9c0df331d7 100644
--- a/drivers/cpu/Kconfig
+++ b/drivers/cpu/Kconfig
@@ -26,6 +26,12 @@ config CPU_RISCV
 	help
 	  Support CPU cores for RISC-V architecture.
 
+config CPU_ARMV8
+	bool "Enable generic ARMv8 CPU driver"
+	depends on CPU && ARM64
+	help
+	  Support CPU cores for armv8 architecture.
+
 config CPU_MICROBLAZE
 	bool "Enable Microblaze CPU driver"
 	depends on CPU && MICROBLAZE
diff --git a/drivers/cpu/Makefile b/drivers/cpu/Makefile
index bc75d9b974..773395693a 100644
--- a/drivers/cpu/Makefile
+++ b/drivers/cpu/Makefile
@@ -6,10 +6,12 @@
 
 obj-$(CONFIG_CPU) += cpu-uclass.o
 
+
 obj-$(CONFIG_ARCH_BMIPS) += bmips_cpu.o
 obj-$(CONFIG_ARCH_IMX8) += imx8_cpu.o
 obj-$(CONFIG_ARCH_AT91) += at91_cpu.o
 obj-$(CONFIG_ARCH_MEDIATEK) += mtk_cpu.o
+obj-$(CONFIG_CPU_ARMV8) += armv8_cpu.o
 obj-$(CONFIG_CPU_IMX) += imx8_cpu.o
 obj-$(CONFIG_CPU_MPC83XX) += mpc83xx_cpu.o
 obj-$(CONFIG_CPU_RISCV) += riscv_cpu.o
diff --git a/drivers/cpu/armv8_cpu.c b/drivers/cpu/armv8_cpu.c
new file mode 100644
index 0000000000..1572e087e0
--- /dev/null
+++ b/drivers/cpu/armv8_cpu.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 9elements GmbH
+ */
+#include <acpi/acpigen.h>
+#include <asm/armv8/cpu.h>
+#include <cpu.h>
+#include <dm.h>
+#include <dm/acpi.h>
+#include <asm/io.h>
+#include <linux/bitops.h>
+#include <linux/printk.h>
+#include <linux/sizes.h>
+
+static int armv8_cpu_get_desc(const struct udevice *dev, char *buf, int size)
+{
+	int cpuid;
+
+	cpuid = (read_midr() & MIDR_PARTNUM_MASK) >> MIDR_PARTNUM_SHIFT;
+
+	snprintf(buf, size, "CPU MIDR %04x", cpuid);
+
+	return 0;
+}
+
+static int armv8_cpu_get_info(const struct udevice *dev,
+			      struct cpu_info *info)
+{
+	info->cpu_freq = 0;
+	info->features = BIT(CPU_FEAT_L1_CACHE) | BIT(CPU_FEAT_MMU);
+
+	return 0;
+}
+
+static int armv8_cpu_get_count(const struct udevice *dev)
+{
+	return uclass_id_count(UCLASS_CPU);
+}
+
+#ifdef CONFIG_ACPIGEN
+int armv8_cpu_fill_ssdt(const struct udevice *dev, struct acpi_ctx *ctx)
+{
+	uint core_id = dev_seq(dev);
+
+	acpigen_write_processor_device(ctx, core_id);
+
+	return 0;
+}
+
+struct acpi_ops armv8_cpu_acpi_ops = {
+	.fill_ssdt	= armv8_cpu_fill_ssdt,
+};
+#endif
+
+static const struct cpu_ops cpu_ops = {
+	.get_count = armv8_cpu_get_count,
+	.get_desc  = armv8_cpu_get_desc,
+	.get_info  = armv8_cpu_get_info,
+};
+
+static const struct udevice_id cpu_ids[] = {
+	{ .compatible = "arm,armv8" },
+	{}
+};
+
+U_BOOT_DRIVER(arm_cpu) = {
+	.name		= "arm-cpu",
+	.id		= UCLASS_CPU,
+	.of_match	= cpu_ids,
+	.ops		= &cpu_ops,
+	.flags		= DM_FLAG_PRE_RELOC,
+	ACPI_OPS_PTR(&armv8_cpu_acpi_ops)
+};
diff --git a/drivers/cpu/armv8_cpu.h b/drivers/cpu/armv8_cpu.h
new file mode 100644
index 0000000000..2c4b0252cf
--- /dev/null
+++ b/drivers/cpu/armv8_cpu.h
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 9elements GmbH
+ */
+#include <dm/acpi.h>
+#include <dm/device.h>
+
+#ifndef _ARMV8_CPU_H_
+#define _ARMV8_CPU_H_
+
+/**
+ * armv8_cpu_fill_ssdt() - Fill the SSDT
+ * Parses the FDT and writes the SSDT nodes.
+ *
+ * @dev: cpu device to generate ACPI tables for
+ * @ctx: ACPI context pointer
+ * @return:	0 if OK, or a negative error code.
+ */
+int armv8_cpu_fill_ssdt(const struct udevice *dev, struct acpi_ctx *ctx);
+
+#endif
\ No newline at end of file
-- 
2.46.0


