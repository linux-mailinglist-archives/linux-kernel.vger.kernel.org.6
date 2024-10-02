Return-Path: <linux-kernel+bounces-347280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 699CC98D074
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89CC5B24265
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC221E201C;
	Wed,  2 Oct 2024 09:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="B6C+PU9j"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19FB1A2561
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 09:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727862739; cv=none; b=Ut3W299Wc4sfJwUQqyVJzvMP2ca+brueaDpMOtkvrlmibI1Al6YIzI1j8e7WJgNTC5Rh9CsbKbpv/UdNRivVc8BJWVU8kEmjAAMSDNV1U/17jdxiLOmnB/d6I4GUw9U/AzyI654pg77zG79+bg8FuPB0ZCRDxS+m3kbvh/yHBDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727862739; c=relaxed/simple;
	bh=nqZ0vrX/2zxXYKJcMCOl0Qb02TFK4XdFmJnEQkjxTu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nmDEhRAfHm61n3Ih2wgZNkoUf9vIYaBOXHtZP13CJRHwkC5u6yYZyFLEd7vUjjFgaTFcc4eKc+SpS0nOkpFBnb4AOAtPAIqK4oc9tv2lok1r0zTPnK/bbU+Fzzm6CJge+p2IwkYap46e35sgEON4IKFrdhyOpVOismHgA4ZhuyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=B6C+PU9j; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cb1e623d1so60708925e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 02:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1727862736; x=1728467536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uN5BnFsKMozjRRq3SSZ25lyYVWbfWWj0lagNsicv9cw=;
        b=B6C+PU9j+SmC57UKXoPESCxcZ1wwmR31SJqcsIK2q6Nx/4s61cyg8zdtTRLkmVX0q9
         2InMVpJUxid9LylqXgt5BLYyeqC6/eKt+vGyn6f+Y1W6LCQel/dFcMHNkhB+I0zBzktb
         ujuHASJ2sscrmlVmWqSvmGvDcI1uikTFUqHZDqgV0I7F9PByWu9wINJ8EM/SPgt+Yi1z
         aVzx9zftnj77lEK2/tHAwGCRMaMd5i/SYwHNJCk6mLfQ1SgAQFJUyZ5c50Kk9qEd7xGP
         wNtMXapYJuSEgt+EkfaE61lh2Gw7syq8SdIp+igZa2FRS0d3LneVFQSSYVu2bH89FzSC
         AfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727862736; x=1728467536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uN5BnFsKMozjRRq3SSZ25lyYVWbfWWj0lagNsicv9cw=;
        b=XmMNJUW3JhpsQ99imQy2ez7WE8T92ET86JbcnI7nb82w1y/Rmsk3CIIg51HNFexdHQ
         7WHHaVM4B2rwnzuQfMSiW8cEJHpCkI4xBxKSgT4//qzmBjIdaQ1km2RmEQAouXZGh7pu
         uKppl4E2BQBXx8VzVOnUgCqKkaxri7T0rMVihbxWvAQMDw78KYW4T06yA2mQto/YK2V2
         diMN2V9L7zOiXo3KMlEzDEYl6nFHdIlFMeXcHeqTXo47t9HpWv8p96jNOQaSbKTMuAoJ
         TnDGDQkf4HM6UN6VdCr+D038hOJkmEmCS+egkv6CZqPmRbKWLNq64T0MGBeJ4CvfQhuk
         OXMw==
X-Forwarded-Encrypted: i=1; AJvYcCXnYi4uyB5RHETzYzl+sp+fWd34IbqOv5wdr6B5QCTmG6GkTDNUJR5UpoVsEL57TXb+NZQwBVItaclHaEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY5FO0sHkgKgyy2+8J079/E0gSOlPCpsPEhls8+EHOb/2HIrxX
	dWZt3JnsR157OX9/6+5SdWo16z3Cj4lj7epUK1n7cm1wHjl+UQ35FhxmD2BCFQ4=
X-Google-Smtp-Source: AGHT+IHOSpjcpNHtS9tcXuo1greO6gR2Rr1BqQiHfBvEcqFJph94r3vHye/ysRNQ8llDGf8zLotzqA==
X-Received: by 2002:adf:fd0d:0:b0:37c:d4f8:3f2e with SMTP id ffacd0b85a97d-37cfba14b3dmr1607262f8f.55.1727862735870;
        Wed, 02 Oct 2024 02:52:15 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e94c4sm13555292f8f.62.2024.10.02.02.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 02:52:15 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 18/37] drivers/cpu: Add generic armv8 cpu driver
Date: Wed,  2 Oct 2024 11:47:09 +0200
Message-ID: <20241002094832.24933-19-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002094832.24933-1-patrick.rudolph@9elements.com>
References: <20241002094832.24933-1-patrick.rudolph@9elements.com>
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


