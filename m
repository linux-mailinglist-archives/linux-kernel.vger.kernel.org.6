Return-Path: <linux-kernel+bounces-282449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B492094E448
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 03:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 689E3281FDF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 01:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10ABC6AB6;
	Mon, 12 Aug 2024 01:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ivTerrKN"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FA31170F
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 01:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723424403; cv=none; b=mfcw1O7yaqa1C8N+ZImu80x4J9xlQWcVOgIqHwwBWOJwFn2npbjhk8iFKoZKISsFPEHVRDdg6YX3aFUs9EuGawj98hK8gcF8l/YJagEL/dMCHGRdnI6c5FLz0j/V0VszwFQ3wNAVZh+F96UJc+qXYjDDP8/W8+pxzM+Pw4kTHMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723424403; c=relaxed/simple;
	bh=/NjNF2gM7TvKKHeRf2SUhc4H3zCep0Sq72OK0O5um8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MK6/Q//RqY76QcRvXAYdFsq8Ts9UJS9koxdKprLlKifZzwcmzqzFGy9g7uK+MoB4fbUEwQKOHCcHTNjepTKRehS4AdE9+NDIPxhoDnu9bt5iiEms4ceqFnvrMrnEeZi1p+ov1JKeKdi7NAFhG81xxeWq58EfcvR5yc8wf2bLaCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ivTerrKN; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-709346604a7so1610574a34.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 18:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723424400; x=1724029200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kH+4pIB9prP9kOEprexbBfphBFyJQXg0yq2xsmagq1s=;
        b=ivTerrKNNS6WArC5x33F/kCeZPN5TzZe/Ir6m3js0N7gW5mNsEqnnXvkz4B+5n7kk0
         lWSCZ69kwuVYIv7/TtNBu5q5JQUWOTd0TgpVr9mGW3LMQXw3G3Ax7BymOheqMySmzitE
         M1OWrJ1F1906ltefFffZW11duYc5+AlpAUqtC2ZqmJecDRxoP33Kr+V2upaefQ1KK5tc
         IOtfTbyBDG43QG6ZP5wN8fqK+wpaGSkHw6YXXz4HoHSDpqU44G06WVfk/zh14pvX3GuA
         le4DPF4SPkfX8nhELfo5i7+/na2evVuHgKBDgtuNtBAEuAsTrjosVFL/Gs6tL1ptMAr1
         bGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723424400; x=1724029200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kH+4pIB9prP9kOEprexbBfphBFyJQXg0yq2xsmagq1s=;
        b=swePLRUMRDDECAjsn6YAC5eL5MuWBg+jplGs03wdS8fXKD4eHvxHRUr5tkywFv6ldK
         gzv4LV73VV0ihuYvYD8KBk7T2bFCkU0LopXLkb1zjK+eBdh0m7k1c9CmbxT4JIplggK2
         LdpCtkZWYRE4OULRqAbUj7bowRsk2B5DZ4kV/zgTNLVW750r+//uAOTecDrzwnn9FeHm
         JS3gIznUA2sgQPZTt0aTBnpZDwvyhykslTkMqOLta9MhEaWuc8meoP0lXbW7LjsByOs/
         VKmyH9FEOaHwZXQBaKcQPRA9f4WdlI94v/f15rlW1lhvnTkTR1J9lluQdIpga1WQwU5+
         HJjA==
X-Gm-Message-State: AOJu0YwSTovaGzVPY1/vcFx/AlEqkk47TQoZCLFhIR4G1ZVejbW/K1z1
	JignhGs1drIM5oKEKMK7O+TdsDQq3P3+ZZR/UXHD/JS/xT3NgMlc9870jwJGJLF4FT6TpoMrwqw
	g+1r/EA==
X-Google-Smtp-Source: AGHT+IHrAlknP9L5C6h6kRrSytyVyD8ukh4CBeZCWs5vO7PGS1mxPUN26YUu6El93VBg0yE0hzkTrQ==
X-Received: by 2002:a05:6830:6c0f:b0:708:8c07:c646 with SMTP id 46e09a7af769-70b748745c5mr11624369a34.33.1723424400027;
        Sun, 11 Aug 2024 18:00:00 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbe8cbdcsm3074062a12.61.2024.08.11.17.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 17:59:59 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
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
	Haibo Xu <haibo1.xu@intel.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH v8 03/17] ACPI: bus: Add acpi_riscv_init() function
Date: Mon, 12 Aug 2024 06:29:15 +0530
Message-ID: <20240812005929.113499-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812005929.113499-1-sunilvl@ventanamicro.com>
References: <20240812005929.113499-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=cp1252
Content-Transfer-Encoding: 8bit

Add a new function for RISC-V to do architecture specific initialization
similar to acpi_arm_init(). Some of the ACPI tables are architecture
specific and there is no reason trying to find them on other
architectures. So, add acpi_riscv_init() similar to acpi_arm_init().

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Tested-by: Björn Töpel <bjorn@rivosinc.com>
---
 drivers/acpi/bus.c          |  1 +
 drivers/acpi/riscv/Makefile |  2 +-
 drivers/acpi/riscv/init.c   | 11 +++++++++++
 include/linux/acpi.h        |  6 ++++++
 4 files changed, 19 insertions(+), 1 deletion(-)
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
index 000000000000..a875a76aa44c
--- /dev/null
+++ b/drivers/acpi/riscv/init.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023-2024, Ventana Micro Systems Inc
+ *	Author: Sunil V L <sunilvl@ventanamicro.com>
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


