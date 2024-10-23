Return-Path: <linux-kernel+bounces-378087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5839ACB32
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BECE1F22928
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC7A1AE01B;
	Wed, 23 Oct 2024 13:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="EwrYbO+U"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99391AE016
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 13:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729690146; cv=none; b=F7//1buv1MaPuUu3t40j1S6oWLXYYHbnOzZtGQjljqLZ0jqfXA4Q6uKk0qIY1SisTFbgJ+1zIhwvPCQwifIofHLs0lZAgYyS8dT+craZ5rm8Ei2Nk7C18MyFsBTdGHJSr7V8NowTobirRpNh1VprrOd87L2IVK8d9pjPPsIAxfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729690146; c=relaxed/simple;
	bh=QgrKkY/QPYrM4Vei26iciDuQHDrG/O1TPl9SCa5hIHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A8GWTJB0eBSX4x6HwRVu3PMuslvDPGXUXFP1T4oKoDsemgM3BKBAkqdrVmOR5F9X2ony436ZoIdMunfj4VToi7jT7lS/j619zKQMuqWHnvBRaoOmn5Onvx3yHLlWgEnvECMjYO+1fr/xsiiJ8FYxF1ylmEBXLGpQWd3IqbBuKs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=EwrYbO+U; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4315eeb2601so82224795e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 06:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1729690143; x=1730294943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eNakn2lh4coir6wXgnAEYR67LhROU5Z5DBHvfE4imvQ=;
        b=EwrYbO+U5v3Sr+EVHf3V4jD4ySrU055Ei8RWPRqP1UNAqUnpOtO8iXSMLscuj6YgJJ
         knmGgoJ25L3cxiTM27tzn5GpxcUKVHpQrhNduVPA5k98+tU0CWFGZXXJhjWcu6YHgmUX
         Z2ARrkQtMmnSG166ifOrvH+Cl6QaCaHpujXqDE2k17g8Qb3+t2klJ1/n2GkRsWTaKVtw
         BUkFEYYDPpfp5saspFyv5p7aKYnexCbwvhMqPQOnSpkWyNPiHEasZ0PxNQC1VXflRaXc
         2B1V8kRDoJcFA2t/6ydKqUizGI1TOpikhxfyBEXR9msSyyfrq2wp7lNK7azvpCv1H1XF
         Rx0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729690143; x=1730294943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eNakn2lh4coir6wXgnAEYR67LhROU5Z5DBHvfE4imvQ=;
        b=tqXhoHqd253WA8jM4oV4jKsNnbu/UYPm3fZB9eKF3AgWOB+yQzW2uFnhjiX5PpXrwI
         lBC8U4AqGeby087VByS3nWWfzqsuJmqgs9T8sYsf6GKOjd+jQ0EwMHw6vIrYd9M7Spx9
         LEPWhFr0LZ5pKUFTgjqYWaQgOAcO77rw5Sr74IejvduhxC+5J3NdUevMiSl0snFSJPoX
         ztX9rvPd7CvJ7DkyLMPzRT41EclyFouBqPoAPYH99Zl7aiosuDMD84VLnJZfU2GTQLEh
         eMsPc8G/NWTTHYx5lspsGB8ACV4td79ZiFVGDLj0kuWL2LHvy+5AyMqbfE56JY95iUj7
         xK+w==
X-Forwarded-Encrypted: i=1; AJvYcCUlt3tjwujPYFS/t6snA3wnzRxJnC0z5odKX2YIPjRtiEz1rPdX5VLDpKiRD4EzUY1P/ntxm0EB55nXFkE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylm6sPPr3y6hFAcXm3bnTFOZvkz07j3eviFgAYymM6AIMZdPLn
	3RyFmEs6H/j9K7N6BO0LxwFMyavqcqXlzphGQsIdExfZp2AwGzOujskz/BJkL8TjQUgeWOHP1HR
	j
X-Google-Smtp-Source: AGHT+IEvhQ0zVv23lnTYt3sy0ltCI+BAigOEf3vT4eJzqlr8nxz8TQfTfEuRH8n1EqosBgE/MAolwQ==
X-Received: by 2002:adf:fe45:0:b0:37d:2de3:bf8a with SMTP id ffacd0b85a97d-37efcf15f43mr2133792f8f.26.1729690143064;
        Wed, 23 Oct 2024 06:29:03 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9b186sm8907478f8f.91.2024.10.23.06.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 06:29:02 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v10 18/37] drivers/cpu: Add generic armv8 cpu driver
Date: Wed, 23 Oct 2024 15:20:01 +0200
Message-ID: <20241023132116.970117-19-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241023132116.970117-1-patrick.rudolph@9elements.com>
References: <20241023132116.970117-1-patrick.rudolph@9elements.com>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
---
Changelog v4:
- Export armv8_cpu_fill_ssdt to use it in other CPU drivers
Changelog v6:
- Update header order
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
index 0000000000..19f072be43
--- /dev/null
+++ b/drivers/cpu/armv8_cpu.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 9elements GmbH
+ */
+#include <cpu.h>
+#include <dm.h>
+#include <acpi/acpigen.h>
+#include <asm/armv8/cpu.h>
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
2.46.2


