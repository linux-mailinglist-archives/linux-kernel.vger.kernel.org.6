Return-Path: <linux-kernel+bounces-263991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DC493DDA0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 09:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDA981F22318
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 07:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419D72574B;
	Sat, 27 Jul 2024 07:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="MikX91qo"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B89E2940F
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 07:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722064821; cv=none; b=J01huzc++gys+LQTraIB5bHLfSbWe85suAAZwpiR1ZP0qFex60oBsMaglc9yzM5BhDkdjj4NbOydGdy3RcgJpGaPjj1ZtE4e806XWdepzfgxEE2ULDCRbKNYJOFP4CJj6obd0pfQiTfumJZkWEB8C5ASWWD98kGuENffBjqG5b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722064821; c=relaxed/simple;
	bh=Mj2Cgfna1zlKya0P3RKhQWiKc0MVRcD6WSn1njYEx9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cE5Ko6+WUW6yImlAH6+snqC8LV8VRtxLj1gJ2/RvPMKhmjEdReaQxiMxHgkPVR4tTq86k10JHO7BmUZdoJBF/xIjSjVzHJ2X96Xzth33R68IMIFNBffKtiQhswdDRYGVRUYaiepoC+7Y2vVU8p7OUDlKgm9JHY6Hd7hkDjkBwdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=MikX91qo; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52efaae7edfso2349474e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 00:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1722064817; x=1722669617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=filpyQkk9f0QR0ZeZDqORBnz2FVGnj0jpfuEwjUBe9U=;
        b=MikX91qo6Ezr2r73ZgEIbg0ip+cRIuiFvev1IODTk6hsnULTnBB556ZUKMdDb+kXcD
         cvNf+layU5GMXQuWVLU4JxITuVbEISOIfJ3Kw1kgHcRbA1AWJxzfWy6tNlCSODdixh4W
         qynt9Lq05i93Hdqd9RDjW6dF11KYeDqy0Sb5BlI726EttQEnAxYonq7mz0ALY9aM68B7
         e4R14JYJXQZE+1NedA5k86BObvRhUtPF95H+Cn6rYyR1XfbUzr4cbZQnPHX4Q+SxZMEs
         rz53aZ1LPCwaEpJPBP8FBr+Z6oZzWfHWgtm+DNzk6P0S99o3X035LfUmyoWkLLyHyU7m
         G3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722064817; x=1722669617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=filpyQkk9f0QR0ZeZDqORBnz2FVGnj0jpfuEwjUBe9U=;
        b=DefEmDM0SkAtUrm1j5QCKcg/abBfA59opf+zSKDpvdoMYFTfovEqiilMccIBNrmD9a
         UzpUA9/AVyGch7sXKS1aQ3Z/dihIVecFqa3wqqfDWXyPFKMse7SNx20jq8WjyiPzM9pw
         G33pn91YA8TW+UIkyvs+4JeLccY7vazuc2neMb/zhT5sSeF3qI4wBbH8pDiNGAf456+B
         ppsoggzDEtBMG3okvXMD2K3wleHDmxgb16btY//++jsVkbaoMcyQv0goy05PwQ+l0xrp
         dtlgAuQmMI5rqknNLTVnIibiX8P7bJLYW4sn4RzmQLEUGvMNdFj2KhVKQrSK00Z8Pzbu
         yKRg==
X-Forwarded-Encrypted: i=1; AJvYcCWb1H62OjUhdEj2Ce426kxIdal6anpZZF+I2dJHCtHrITaiAa+yx4goxn+Wa/1LzavKFwxXs3R1j3vB4nQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH9uYHXAEnQls4jiC/0AuCKwvGOsnZB+hIMHFdJ88MDxylE++z
	oEX06j3oX1q7Z5+nfx/WjcfIikbtkziS4S39C9i3Qn8K1cQ9aa32NFZJGq3fiwM=
X-Google-Smtp-Source: AGHT+IFDPYDSILZU3rP/sPsaknvIEFg9+E1jfU5/iGH9hRwxbQl+WMz7VJsnbKT21Rw1A48t2VpFvw==
X-Received: by 2002:a19:770c:0:b0:52c:d626:77aa with SMTP id 2adb3069b0e04-5309b2d9aa9mr1005911e87.58.1722064816895;
        Sat, 27 Jul 2024 00:20:16 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab231f2sm253102866b.7.2024.07.27.00.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 00:20:16 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: mbrugger@suse.com,
	pbrobinson@gmail.com,
	trini@konsulko.com,
	sjg@chromium.org,
	bmeng.cn@gmail.com,
	Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH 07/17] arm: acpi: Add generic ACPI methods
Date: Sat, 27 Jul 2024 09:17:08 +0200
Message-ID: <20240727071742.1735703-8-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
References: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add generic ACPI code to generate
- MADT GICC
- MADT GICD

as commonly used on arm platforms.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
---
 arch/arm/include/asm/acpi_table.h | 18 +++++++++++++
 arch/arm/lib/Makefile             |  1 +
 arch/arm/lib/acpi_table.c         | 44 +++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)
 create mode 100644 arch/arm/lib/acpi_table.c

diff --git a/arch/arm/include/asm/acpi_table.h b/arch/arm/include/asm/acpi_table.h
index e69de29bb2..8a25e93847 100644
--- a/arch/arm/include/asm/acpi_table.h
+++ b/arch/arm/include/asm/acpi_table.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef __ASM_ACPI_TABLE_H__
+#define __ASM_ACPI_TABLE_H__
+
+#ifndef __ACPI__
+
+void acpi_write_madt_gicc(struct acpi_madt_gicc *gicc, uint cpu_num,
+			  uint perf_gsiv, ulong phys_base, ulong gicv,
+			  ulong gich, uint vgic_maint_irq, ulong mpidr,
+			  uint efficiency);
+
+void acpi_write_madt_gicd(struct acpi_madt_gicd *gicd, uint gic_id,
+			  ulong phys_base, uint gic_version);
+
+#endif /* !__ACPI__ */
+
+#endif /* __ASM_ACPI_TABLE_H__ */
diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 67275fba61..a7efed6771 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -86,6 +86,7 @@ obj-y	+= psci-dt.o
 obj-$(CONFIG_DEBUG_LL)	+= debug.o
 
 obj-$(CONFIG_BLOBLIST)  += xferlist.o
+obj-$(CONFIG_GENERATE_ACPI_TABLE) += acpi_table.o
 
 # For EABI conformant tool chains, provide eabi_compat()
 ifneq (,$(findstring -mabi=aapcs-linux,$(PLATFORM_CPPFLAGS)))
diff --git a/arch/arm/lib/acpi_table.c b/arch/arm/lib/acpi_table.c
new file mode 100644
index 0000000000..ea3a6343c9
--- /dev/null
+++ b/arch/arm/lib/acpi_table.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Based on acpi.c from coreboot
+ *
+ * Copyright (C) 2024 9elements GmbH
+ */
+
+#define LOG_CATEGORY LOGC_ACPI
+
+#include <acpi/acpigen.h>
+#include <acpi/acpi_device.h>
+#include <acpi/acpi_table.h>
+#include <string.h>
+
+void acpi_write_madt_gicc(struct acpi_madt_gicc *gicc, uint cpu_num,
+			  uint perf_gsiv, ulong phys_base, ulong gicv,
+			  ulong gich, uint vgic_maint_irq, ulong mpidr,
+			  uint efficiency)
+{
+	memset(gicc, '\0', sizeof(struct acpi_madt_gicc));
+	gicc->type = ACPI_APIC_GICC;
+	gicc->length = sizeof(struct acpi_madt_gicc);
+	gicc->cpu_if_num = cpu_num;
+	gicc->processor_id = cpu_num;
+	gicc->flags = ACPI_MADTF_ENABLED;
+	gicc->perf_gsiv = perf_gsiv;
+	gicc->phys_base = phys_base;
+	gicc->gicv = gicv;
+	gicc->gich = gich;
+	gicc->vgic_maint_irq = vgic_maint_irq;
+	gicc->mpidr = mpidr;
+	gicc->efficiency = efficiency;
+}
+
+void acpi_write_madt_gicd(struct acpi_madt_gicd *gicd, uint gic_id,
+			  ulong phys_base, uint gic_version)
+{
+	memset(gicd, '\0', sizeof(struct acpi_madt_gicd));
+	gicd->type = ACPI_APIC_GICD;
+	gicd->length = sizeof(struct acpi_madt_gicd);
+	gicd->gic_id = gic_id;
+	gicd->phys_base = phys_base;
+	gicd->gic_version = gic_version;
+}
-- 
2.45.2


