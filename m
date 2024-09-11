Return-Path: <linux-kernel+bounces-324258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD64974A5F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64C8EB23D93
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 06:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20607E591;
	Wed, 11 Sep 2024 06:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="PI9Rmhh3"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27407182D2
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 06:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726035955; cv=none; b=Zzs1l+BqKux3lWW5Qeox3S/t7fjfc59ULCeUj97Ix7+xDpWDwdfX+Rzi3NeE4tz3+Ao+TXn+MjqEeBtndyeOf1hN6UopHvlNmXWuhBkI9zHODkEvCWbCDAH88ZWxYT+TjVykOsWokR3LWtJy+FslzloT5HfIZYQ7ImAJY/h59r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726035955; c=relaxed/simple;
	bh=t+3VXOqyBXOlffj72JT0arqjpOEbfD9KIJI9DBIVv3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uHQVaE9Lex+BjjUZAyiqAS32wdToEKVoSzXZCQLt5re7DuM5L66a4eSuDOAvAGAQy+rVUORwJr17SF3VxUTW1w798gGK7BNfCkYd+qQrPSgk4ygGW8muypz5/CJxRfDfoQBbMHR16r0da+syBHEyQrQ2cu/jFXEB+hTyuH7tUPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=PI9Rmhh3; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c24c92f699so6949242a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 23:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1726035951; x=1726640751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGJkVoDUw0zvkbGlCYIx1J4whRUd5TwtylIf9yCkL5I=;
        b=PI9Rmhh3sKWZ4YsJkxoJbplJZajwXXsW3SQalgTgRvQTtu20YWHlBDzuo89FkT193+
         74PKVzCiIKaU1VI3PVOKYJjkYxOZnc1Su3l0vuUcaFdwGRFTWi8pvZu2BjlKRwbpP0JF
         kFEe1hhs293CpDKk1hygsxYJT21STI1l5resfRa/UarwhJA9fd9kvx1unv/y4MFIJouW
         Zh/euW4hz/+7FggHMEIRrK6NkSq1ryfKEtH7qWra0XoYOBU0Eq/IzyQ2YMv2jVFxICa9
         f9wkmhfT/TDDjiFtrNqzqRFYUv4zEPA7kxNOmQofzb+HSbvl9bnLCEk2aqMcP2ufenDn
         gNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726035951; x=1726640751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qGJkVoDUw0zvkbGlCYIx1J4whRUd5TwtylIf9yCkL5I=;
        b=wEvm8LmQiQpk3ML3hZcw5+6XoaQaIT/ljtdPRPYwBrmjb2waduMNp5B2s88mzkAXxE
         exMFyl8/VrRtJf1+7X4raoJZ8B/4EUVbDxSP2ll+415hm45oMISfSmIDHUVjKnp4vxA3
         EPf3l4VFS+kuonTrcAZuh4szzWH0boTFvbz3LDCazjrvMi5OlQp8j2msppTSD668mtI0
         pK7inKtXf+8fzbwoI3yfvxpLUUx1j+8062jrbxDUlLxiPEdR+ChiYd4BH+QuW+y/16g8
         +hcHiH1Zh3/GpLz8rEdCaOCEQZlJ8eMMsEaba9RQsY4/jwnw4/sGG1G7TsfCpIsrb0Be
         qOGw==
X-Forwarded-Encrypted: i=1; AJvYcCVRhiRez43zIZegqjaAypRQmY0DZ9wWbJ//8bX+QzTEbZ/QHXAXeMeM/N1lMqrKruOw3ZGSLDXx/cOEyJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmG1Dia3CRLXG1Lmv6ZWjM54OSc+QJuY7/WYAj8x631LIbH9J8
	KpM/GmlLbc0dqk8B8m25/4AdHfpwucMKx+YUOXWxAXsmWA2+Gj7jNbwmCv+gF6Y=
X-Google-Smtp-Source: AGHT+IH67Y4FQFD/320k5qGNmwEHjL7ICaQY7s/xPFN498SuS049dLVB8gAOT5GXiWsiIpA18IAIOg==
X-Received: by 2002:a17:907:7255:b0:a8d:4d76:a75e with SMTP id a640c23a62f3a-a8ffab83375mr261302266b.30.1726035951308;
        Tue, 10 Sep 2024 23:25:51 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25a43365sm575545366b.94.2024.09.10.23.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 23:25:50 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 18/30] drivers/cpu: Add generic armv8 cpu driver
Date: Wed, 11 Sep 2024 08:24:08 +0200
Message-ID: <20240911062511.494855-19-patrick.rudolph@9elements.com>
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

Add a generic driver that binds to armv8 CPU nodes.

TEST: Booted on QEMU sbsa and verify the driver binds to CPU nodes.
      Confirmed with FWTS that all ACPI processor devices are present.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
---
 drivers/cpu/Kconfig     |  6 +++
 drivers/cpu/Makefile    |  2 +
 drivers/cpu/armv8_cpu.c | 90 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+)
 create mode 100644 drivers/cpu/armv8_cpu.c

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
index 0000000000..08b8d45f6f
--- /dev/null
+++ b/drivers/cpu/armv8_cpu.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2019 Broadcom.
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
+	ofnode node;
+	int num = 0;
+
+	ofnode_for_each_subnode(node, dev_ofnode(dev->parent)) {
+		const char *device_type;
+
+		if (!ofnode_is_enabled(node))
+			continue;
+
+		device_type = ofnode_read_string(node, "device_type");
+		if (!device_type)
+			continue;
+
+		if (!strcmp(device_type, "cpu"))
+			num++;
+	}
+
+	return num;
+}
+
+#ifdef CONFIG_ACPIGEN
+static int acpi_cpu_fill_ssdt(const struct udevice *dev, struct acpi_ctx *ctx)
+{
+	uint core_id = dev_seq(dev);
+
+	acpigen_write_processor_device(ctx, core_id);
+
+	return 0;
+}
+
+struct acpi_ops armv8_cpu_acpi_ops = {
+	.fill_ssdt	= acpi_cpu_fill_ssdt,
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
-- 
2.46.0


