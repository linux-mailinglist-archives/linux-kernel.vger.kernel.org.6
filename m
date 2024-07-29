Return-Path: <linux-kernel+bounces-265951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9A393F815
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 499191C22129
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A9919149B;
	Mon, 29 Jul 2024 14:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="epHVoGJJ"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75FB16631A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 14:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722263034; cv=none; b=Ft9tGRR80IiHahaVxeH9ChMPotmRxZ0Fn4xEv1ndWQpdcYVLHXpqKAEZWgotgvMu94qKJ5Xxe61Z9lZ9fsI6Nj4jMyfCkV8JAZDtiKI28hJB7ro7EXzlvt2TSVA6LwLWJbWfrpct2Tb2LBWKclaQEVyeCIN7Eu7dSwB9ntM6buY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722263034; c=relaxed/simple;
	bh=0BRXE0HINhvBM6jlUkXiX5qm7dADdRByHIusW0vynz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PbxFRucV3WvVBAxhtITlU/CvCAloxgl67GR/LlfBR0XIlw1v16H5Aed6iZ1BO25LOd4qpw/RHcEowJHp8iMuW8QxrlPd5bP6SaK4/KOCg9i2aJuiEmS7zGe1t5XAQfrxjq7xBy6/ACA71V+zQKRbz32hehTJexeTmMoB77msZTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=epHVoGJJ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fc5549788eso23956795ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1722263032; x=1722867832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbM0a+feX6KT++9LC9tUXyb/bLPakmTLy8AENK3qxq4=;
        b=epHVoGJJ8VmOwSU9/iKLQpE+2ey/hZ5bUi0xGwJZl66GoU++ihy8rnFAI6KUEr74ad
         4Q9SRm6M4ATrJFtWCxurHkx4QlgwX0UzSOuj8Usb3uw52qHJ+8ApGvdSprXi29PQqPQQ
         yusWacOmkVn5ZNr/ToArzHP8iAHHbPHuCk7sZ75GATo8zgLuNa9dIbts9HCzv3w783iQ
         w7EXSKvhjHnkYmC2t/hI3H6Fc8Ls4nVndTzd86dt6pMSmAL1qqp4QsZTgHDvnG69VqNN
         CWS/iz0MBzD9Z11G0H6jT4i7/KjpDIyYPa/GkiEe72WFuxkOcPZ28+RiwNYpS3PB+AIF
         DCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722263032; x=1722867832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbM0a+feX6KT++9LC9tUXyb/bLPakmTLy8AENK3qxq4=;
        b=Rcm/UoPBXY4vicSYeSmHfvIGkGf/cYQ1IS9uqGtCqYlLDc7/vov1MEP2FI0lEfvy/W
         GjPP2EHG0hs5tQWSb3EdoVlxf7WSBd4wcs/VofHc+3ZZxlrcGI3q4yB3QsUjKuyEtaUb
         mVkgyP12SQa3K8x/c0pym4gUGJyiwt/l/LEdDzu0hkZDyn/gKqBU38dNK29QGx86UWDi
         vsQRLnS6hb3SuP86t8lrxXecuBHf0VsTG5EXXnERFLiQORvBfAQ/rg4VF+TclQNHDsKk
         yZTlS89Qd+7V7WhvWrNDqHRzK1h3g7Sfp0Pox5bDWFuCIevX03aNLi1xNoMRu/WLbYuE
         BRvA==
X-Gm-Message-State: AOJu0Yx7oY7vX9HwLALjKbdG3S42tooBBrMMK3LR0JDmNEIx6YGzDT6R
	+QeH/ndDRAXJqTVy+MRZ4WnBbcrzOiCIuj2fkBW4ELIc9B4OChPwWHNgDiYw1hNPtYmOuG4pFcH
	woPBSLA==
X-Google-Smtp-Source: AGHT+IFH4IFEEqFnFuD3LFxB9/YGdoZ1voAL0RS56DOiFLXrkbkYEDIaLZyWRT2+lCXe+UQYlpMB3Q==
X-Received: by 2002:a17:902:d4ce:b0:1fd:a360:447b with SMTP id d9443c01a7336-1ff048b7daemr104566225ad.52.1722263031612;
        Mon, 29 Jul 2024 07:23:51 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fa988dsm83512965ad.263.2024.07.29.07.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 07:23:51 -0700 (PDT)
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
Subject: [PATCH v7 10/17] ACPI: RISC-V: Implement function to reorder irqchip probe entries
Date: Mon, 29 Jul 2024 19:52:32 +0530
Message-ID: <20240729142241.733357-11-sunilvl@ventanamicro.com>
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

On RISC-V platforms, the RINTC structures should be probed before any
other interrupt controller structures and IMSIC before APLIC. This order
is established by using MADT sub table types which are ordered in the
incremental order from the RINTC. So, add the architecture function for
RISC-V to reorder the interrupt controller probing as per the hierarchy
like below.

  ACPI_MADT_TYPE_RINTC = 24,
  ACPI_MADT_TYPE_IMSIC = 25,
  ACPI_MADT_TYPE_APLIC = 26,
  ACPI_MADT_TYPE_PLIC = 27

This means processing all RINTC structures (in the order of appearance
in MADT), followed by IMSIC strucutre and then all APLIC/PLIC
structures.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/riscv/Makefile |  2 +-
 drivers/acpi/riscv/irq.c    | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/riscv/irq.c

diff --git a/drivers/acpi/riscv/Makefile b/drivers/acpi/riscv/Makefile
index 877de00d1b50..a96fdf1e2cb8 100644
--- a/drivers/acpi/riscv/Makefile
+++ b/drivers/acpi/riscv/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y					+= rhct.o init.o
+obj-y					+= rhct.o init.o irq.o
 obj-$(CONFIG_ACPI_PROCESSOR_IDLE)	+= cpuidle.o
 obj-$(CONFIG_ACPI_CPPC_LIB)		+= cppc.o
diff --git a/drivers/acpi/riscv/irq.c b/drivers/acpi/riscv/irq.c
new file mode 100644
index 000000000000..835eb6eccd53
--- /dev/null
+++ b/drivers/acpi/riscv/irq.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023-2024, Ventana Micro Systems Inc
+ *	Author: Sunil V L <sunilvl@ventanamicro.com>
+ */
+
+#include <linux/acpi.h>
+#include <linux/sort.h>
+
+static int irqchip_cmp_func(const void *in0, const void *in1)
+{
+	struct acpi_probe_entry *elem0 = (struct acpi_probe_entry *)in0;
+	struct acpi_probe_entry *elem1 = (struct acpi_probe_entry *)in1;
+
+	return (elem0->type > elem1->type) - (elem0->type < elem1->type);
+}
+
+/*
+ * On RISC-V, RINTC structures in MADT should be probed before any other
+ * interrupt controller structures and IMSIC before APLIC. The interrupt
+ * controller subtypes in MADT of ACPI spec for RISC-V are defined in
+ * the incremental order like RINTC(24)->IMSIC(25)->APLIC(26)->PLIC(27).
+ * Hence, simply sorting the subtypes in incremental order will
+ * establish the required order.
+ */
+void arch_sort_irqchip_probe(struct acpi_probe_entry *ap_head, int nr)
+{
+	struct acpi_probe_entry *ape = ap_head;
+
+	if (nr == 1 || !ACPI_COMPARE_NAMESEG(ACPI_SIG_MADT, ape->id))
+		return;
+	sort(ape, nr, sizeof(*ape), irqchip_cmp_func, NULL);
+}
-- 
2.43.0


