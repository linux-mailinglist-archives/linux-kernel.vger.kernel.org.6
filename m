Return-Path: <linux-kernel+bounces-265944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 365D493F802
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E83D02833B7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFB719007A;
	Mon, 29 Jul 2024 14:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="S96h38p5"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26D7190058
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 14:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262994; cv=none; b=pZkcdVfyG8NAUwqgwEQ8Gtniy4lyWqVoJHSGFA13/EVcFjX7tsXCBjKT1/Zrey/XAT1+7G3aMD3jI2gap4QK5aLi/XLxov5li38tKX87+uVNIPBkg2Z1PD1meUwAxFiMlhLdWVIPNcqTmyDHVdk5+LQwMUQh45RXZDsFFvJLPUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262994; c=relaxed/simple;
	bh=My3CH+lxqRC1ZfX93NQY26GkZQdIRwImIJElB/31blU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uc4ilJK8KvN4VzJ+jKNvXqKpE8VHYod3r5ai7zCfuJdHluJAyxh2rwDIze9XhYhCCctO7t1KKXFR4jwTcawB7QvzKXHV8gaSyedV2qXXYhu0edwrRAey+/7mMG5uMniBgDaSvXpa+OwQ2XVHe+0+NVITdht5Oq6MNHRmZmLPzek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=S96h38p5; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fec34f94abso20410575ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1722262992; x=1722867792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpUpzTn31uAv59eRsYCCTGHf2UwttQw3/INKSz7Rgp0=;
        b=S96h38p5rNgdz2Z5AxqkZ6Ai5K2pBUiRuuNHo0IejcAZCJbFDuYHUybLcuySTdCMyC
         LSvUny/wRnu2aImVGnDfDN6I0O7s6CfcOpEdTHbn1usfneS9mi5UxaOqpsOqV/dnfCy8
         HQllK+QMtxHbXytWCpKJY9cBJ5V+zUyVanGFXwyd/WoG1EF30q/x/Iv3mgk5dKf5rFcU
         VsN4/S9XLrxgn9I3u4IvPflMZpKhWQaaWpRiTQ9fYyFavFf/QRRS3Q6YmqcUIRUBJQA6
         pgsEScJA9DaSyF6fqWzcCvpZfwDHd96wLqlEADZC9MlCw8H3NHkS+pgVcRG3ZNp1bbZy
         Zolg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722262992; x=1722867792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpUpzTn31uAv59eRsYCCTGHf2UwttQw3/INKSz7Rgp0=;
        b=Eq8bAP4TQuI5AORRxqfPFUv7e3qkUZKcVYe7Yrb/3AOyiRCBiEQyyHL7Hdesc+oKk5
         huX54AloZV/mQvyk8EuXWPJ5fUntcZ+xwSqFgUxJpiqBU3sy8wqvsg9Cq6t98kUQxPI2
         YwsExhWKprmSP7Z10PHhrHxUSCt7QIhPkcD+ycd6Gr85GKDKIelYoxmj2Zsh1rBw9Dva
         3FcPgAUKQyLlyOI4CQRsHeF9VJbVScNIb8RkZ+U7ZLsQVTnTTjPjvv/7T4NiVGRzqUOu
         ju/X6Un2c+3QgwM59xSFDpfN6CCGjcxkWefRnI9ovYO+8VBUczq7Q/9dJdGf84jWh7O0
         +XZw==
X-Gm-Message-State: AOJu0YxJ84wHaosxDaBxVyvAVXRYBBxicmebpAOfUlV3LmkTyIWPkcDE
	gc2eaB/PJfl+SHuuEecGE15yvpEbYp8pO30NuEwyljoIZ+qm0bz+tJY1veEhLBHXAgLIa0N949W
	TK+G1Jg==
X-Google-Smtp-Source: AGHT+IH8iPMjHAqTJtzMrAyY/pfHaeY/boKXW8uZbGvPFkTDNr09tJ3EGqjomR/myMHI4FJBrBAsNQ==
X-Received: by 2002:a17:903:1c4:b0:1fd:668b:ac4b with SMTP id d9443c01a7336-1ff0481ada8mr54039975ad.15.1722262991841;
        Mon, 29 Jul 2024 07:23:11 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fa988dsm83512965ad.263.2024.07.29.07.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 07:23:11 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-pci@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v7 03/17] ACPI: bus: Add acpi_riscv_init function
Date: Mon, 29 Jul 2024 19:52:25 +0530
Message-ID: <20240729142241.733357-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729142241.733357-1-sunilvl@ventanamicro.com>
References: <20240729142241.733357-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new function for RISC-V to do architecture specific initialization
similar to acpi_arm_init(). Some of the ACPI tables are architecture
specific and there is no reason trying to find them on other
architectures.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/bus.c          |  1 +
 drivers/acpi/riscv/Makefile |  2 +-
 drivers/acpi/riscv/init.c   | 12 ++++++++++++
 include/linux/acpi.h        |  6 ++++++
 4 files changed, 20 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/riscv/init.c

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 284bc2e03580..48d277657203 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1459,6 +1459,7 @@ static int __init acpi_init(void)
 	acpi_hest_init();
 	acpi_ghes_init();
 	acpi_arm_init();
+	acpi_riscv_init();
 	acpi_scan_init();
 	acpi_ec_init();
 	acpi_debugfs_init();
diff --git a/drivers/acpi/riscv/Makefile b/drivers/acpi/riscv/Makefile
index 86b0925f612d..877de00d1b50 100644
--- a/drivers/acpi/riscv/Makefile
+++ b/drivers/acpi/riscv/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y					+= rhct.o
+obj-y					+= rhct.o init.o
 obj-$(CONFIG_ACPI_PROCESSOR_IDLE)	+= cpuidle.o
 obj-$(CONFIG_ACPI_CPPC_LIB)		+= cppc.o
diff --git a/drivers/acpi/riscv/init.c b/drivers/acpi/riscv/init.c
new file mode 100644
index 000000000000..5f7571143245
--- /dev/null
+++ b/drivers/acpi/riscv/init.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023-2024, Ventana Micro Systems Inc
+ *	Author: Sunil V L <sunilvl@ventanamicro.com>
+ *
+ */
+
+#include <linux/acpi.h>
+
+void __init acpi_riscv_init(void)
+{
+}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 3fff86f95c2f..892025d873f0 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1531,6 +1531,12 @@ void acpi_arm_init(void);
 static inline void acpi_arm_init(void) { }
 #endif
 
+#ifdef CONFIG_RISCV
+void acpi_riscv_init(void);
+#else
+static inline void acpi_riscv_init(void) { }
+#endif
+
 #ifdef CONFIG_ACPI_PCC
 void acpi_init_pcc(void);
 #else
-- 
2.43.0


