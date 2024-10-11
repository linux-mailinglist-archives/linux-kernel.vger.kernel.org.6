Return-Path: <linux-kernel+bounces-360928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E0999A176
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0D852808EC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5215F20CCCA;
	Fri, 11 Oct 2024 10:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="Xs/dNG5/"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8771E32BA
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728642903; cv=none; b=W/3aCegGoOFNlcF3qcW1Gs5W/WyOYeYklYkH9+Gr7qrUOe0sSkXDjXdXt52Th1z4nuJKB41n8hknKtgfvrfOK8de6SeHys9D6CZriOtMhDBOEUnwQFrCiNB+9kDx16LNtIFA9fre5Mr41/jP75/ojpNeaxfOkZo9UxhAnamh3Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728642903; c=relaxed/simple;
	bh=nqZ0vrX/2zxXYKJcMCOl0Qb02TFK4XdFmJnEQkjxTu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9z8VtcDtI0jV8QzTOvvwENW2XmuyaM9Cxi6TWaVpKL1qgYOs7+u3db55/n/Br1hOLh4TcaLWMaeJzOoduJKDnPJLzHPylBAEikRDLYR3L5dYa4aBMBF0X/wqH+La31H8x78n34WwTwu70gyq4XQUueHZAuVZ5esXhg9uwGdhtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=Xs/dNG5/; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c9150f9ed4so2377306a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 03:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1728642900; x=1729247700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uN5BnFsKMozjRRq3SSZ25lyYVWbfWWj0lagNsicv9cw=;
        b=Xs/dNG5/VLuSDtKJZXG7YKEF3WJ+fNEzonocNVuLhcqD7UoRA4Tpig2GwSliGn1OQ2
         c6vpWZNlxNKXOmPMHLnHTa0zkIv8ZFyEKdAkj1PDtBxC926KIfyp9679qrMMYdyEcpks
         fW2QByc3s7POsMbAciC/FRi+ejxvl9KwD0uRtOxK4F5sDVSUcTF8YtbHmDHYjE99aNss
         OvQ40EAEevUwUK9DS/R16FGTz34oQ8QKG3WSFT560dMaIU5FyVeXDRRZupakPrjITwmc
         oND2fsqG3E4/c3guXTQuDyOQoePnoS8uyikMVX90cjN8a/7wXbJVeOy6ynfszxdZkwUa
         UhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728642900; x=1729247700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uN5BnFsKMozjRRq3SSZ25lyYVWbfWWj0lagNsicv9cw=;
        b=vjRCFEp7aBWFbsuo+1Egc66E8FzrVZSx98ar7TwAxDSdjPS8pDl0USTqXMCKU8Cdij
         4E+CFzeHrDJm7b0AqF1g7R3cioxTju+Nhf32t+IN2DsjqB4cSsSczvZNHNFU5Do5VCTl
         GcZLR6R7567MWnvP9YYP1lX1ifrEaBc8rsnHBE5HiwP39UZWEP0f4EOBCQblnJt59ANV
         4iJr+UXRr5FD2Bh5pVIGfosEuoGCH5ZK3IvYHkojGVsqRk5FEzO4zcjbAvmH1nvYW3iJ
         BUjFUdp/YWaqqS85miBqKAMUgvYehGaKP2NnsF7JAl2WiuK3fF91/yXv5Gpf1TFqbqts
         C8+A==
X-Forwarded-Encrypted: i=1; AJvYcCVhs008e3OCit5AfvdZSWrCojcqDDeVL004AGnZxUaCwZivMYafivrFxy5tjeEXFiGKkOL2EM3QKjqxuXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVTHGDfw4XU7GG/kzazp+XWtUl6vjFKzhhDu9CzolfrVXu07KQ
	8MZOKXxfNn0WW392XkgV5vQNe/xoLIRBNlQzTHLP+sxx7YMGbWnkn4JCH17hBls=
X-Google-Smtp-Source: AGHT+IHmIweIkLJye6Erb8jP3HC9O8b8p7BBTT5AwSNsII6eU8WVB7/0uOYMUP8NBJepkMNO3R3m1g==
X-Received: by 2002:a17:906:cadf:b0:a99:78a5:77d7 with SMTP id a640c23a62f3a-a99b941f114mr173503566b.5.1728642899722;
        Fri, 11 Oct 2024 03:34:59 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80f29besm195353466b.211.2024.10.11.03.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 03:34:59 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v7 18/37] drivers/cpu: Add generic armv8 cpu driver
Date: Fri, 11 Oct 2024 12:22:59 +0200
Message-ID: <20241011102419.12523-19-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011102419.12523-1-patrick.rudolph@9elements.com>
References: <20241011102419.12523-1-patrick.rudolph@9elements.com>
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


