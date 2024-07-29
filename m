Return-Path: <linux-kernel+bounces-265954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1645A93F81C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EE3DB23992
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE97C1552ED;
	Mon, 29 Jul 2024 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Z5lOri+G"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D12A191F8A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 14:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722263046; cv=none; b=OyjQmOH8tsyhal6OqIwea9jXdNeeA7zozBr5Il9W1wWhtgMCMI3QRvuFjApa1gwmxoQy88ae2gIiEIh353IEGWUj8ZNKpiHbYnnuLQfNOL7oqcLOBZpR6Zms+NZKk5gBQXSxe8SXioNzEurzTWg3IveJ5pe9ii4OI8nhve3fBss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722263046; c=relaxed/simple;
	bh=nK3Z34NqvTIdaRuEGgDn01kQf2S/IEQAYX7rT6t0suY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bVgz1DZquLJacP51+Ef1xSI+bStkG1FTkY/EjAkfoqvBo1KLZZ9CW1w7pJmImYen3vUi9vVZ8P4U6XTe/AD8CsFC0TcMqsU8V9PRD+Kpuv+HAudtlyT+z1uwDxX5y/GYGs02Eiyq8Jtw5kzp5EmCvtYViMnGDsr/MZ1ogSZV2Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Z5lOri+G; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc49c0aaffso18638775ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1722263043; x=1722867843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lh+FxZ2Oaqm6/wZ61/7rTE9jIlv42s4WyHVAKuIs34=;
        b=Z5lOri+Ggy9w1tHu4wbuKB4a29IncegmVPlZgWt/9ViKdG68tljnRiALhHjnEhcEW7
         g8H950IGSDJWSdqwN5L/2zXfRZHSglXRjraRxLzS4VQJfv8QTarwDcUCZg+QISQk6hrp
         MX190AJA25MQepS7sKsp1jsILULPS792HKAmiUoPZUB8jqi/zhATjBLjo6DNudO7zPSs
         f7z9POWuasNmxgRZLpyk0jDhsCa5Y6pqRmPrC77Da0bAgMBwyE/eA6r0Xpuc++MHCHls
         j26h6qvjFzK+8N6c6AqrDbMNsdu03qsAv/EevY8I6FdxUM6BiwnVMBCBZtoR+UPAdvqL
         g3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722263043; x=1722867843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7lh+FxZ2Oaqm6/wZ61/7rTE9jIlv42s4WyHVAKuIs34=;
        b=O+sT19R5Nui3g8dlYb/xtOmFQTz+N0WkgbQ43okZsOmNO2dmgEFyiZKQL6Cdhx/X6T
         Bu3zO7HRLVO0sJndxcWSDHBVHO1s7RikKmrO0dSN0OYqGdQvAj9TNTgwInhf1fPgmGZB
         /v99zZpts8QtBY1R+wb9qUWiGfIRXIIaWsKtGXvv4tnKojEPS67Y0x7CxMIUCq+iaIxI
         CnETSHPrx/pEW3PyGKJ//Of2Q9H84pwMCgbXdokNmccsve7+H30DmjWNhDa3T6mN2O0m
         xEmzT/vsvAbrf+y/wW4yKQCzcYZGdocJmpGG1KqK9xsYQxov0/PcqIuW0Y8Z1m01ge2c
         168w==
X-Gm-Message-State: AOJu0Yy3Aetee04SmgKxslzSZUgLjaOEiHnsYudAjVVXhwnmma/bRhU9
	Fg25XQrI31x7iPtJ3fp8OtuT1vzUe16Fb2NujbCW4K0/y9EDFmiUR7aK4AclrMQLQCBtNviXmPD
	FmX6hsw==
X-Google-Smtp-Source: AGHT+IHcJJ7ZUpRxIoDgsE0liV0w2H+LBbMjTY1pRliLvaH8zHgZTiy3qiBM12OS8Q+p8MlCNj4oPg==
X-Received: by 2002:a17:902:d4c6:b0:1fd:73e6:83ce with SMTP id d9443c01a7336-1ff046eca8bmr56689045ad.0.1722263043208;
        Mon, 29 Jul 2024 07:24:03 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fa988dsm83512965ad.263.2024.07.29.07.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 07:24:02 -0700 (PDT)
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
Subject: [PATCH v7 12/17] ACPI: RISC-V: Implement function to add implicit dependencies
Date: Mon, 29 Jul 2024 19:52:34 +0530
Message-ID: <20240729142241.733357-13-sunilvl@ventanamicro.com>
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

RISC-V interrupt controllers for wired interrupts are platform devices
and hence their driver will be probed late. Also, APLIC which is one
such interrupt controller can not be probed early since it needs MSI
services. This needs a probing order between the interrupt controller
driver and the device drivers.

_DEP is typically used to indicate such dependencies. However, the
dependency may be already available like GSI mapping. Hence, instead of
an explicit _DEP, architecture can find the implicit dependencies and
add to the dependency list.

For RISC-V, add the dependencies for below use cases.

1) For devices which has IRQ resource, find out the interrupt controller
using GSI number map and add the dependency.

2) For PCI host bridges:
        a) If _PRT indicate PCI link devices, add dependency on the link
           device.
        b) If _PRT indicates GSI, find out the interrupt controller
           using GSI number map and add the dependency.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/riscv/irq.c | 155 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 155 insertions(+)

diff --git a/drivers/acpi/riscv/irq.c b/drivers/acpi/riscv/irq.c
index 9028787c73a7..cced960c2aef 100644
--- a/drivers/acpi/riscv/irq.c
+++ b/drivers/acpi/riscv/irq.c
@@ -20,6 +20,12 @@ struct riscv_ext_intc_list {
 	struct list_head	list;
 };
 
+struct acpi_irq_dep_ctx {
+	int		rc;
+	unsigned int	index;
+	acpi_handle	handle;
+};
+
 LIST_HEAD(ext_intc_list);
 
 static int irqchip_cmp_func(const void *in0, const void *in1)
@@ -178,3 +184,152 @@ void __init riscv_acpi_init_gsi_mapping(void)
 	if (acpi_table_parse_madt(ACPI_MADT_TYPE_APLIC, riscv_acpi_aplic_parse_madt, 0) > 0)
 		acpi_get_devices("RSCV0002", riscv_acpi_create_gsi_map, NULL, NULL);
 }
+
+static acpi_handle riscv_acpi_get_gsi_handle(u32 gsi)
+{
+	struct riscv_ext_intc_list *ext_intc_element;
+	struct list_head *i;
+
+	list_for_each(i, &ext_intc_list) {
+		ext_intc_element = list_entry(i, struct riscv_ext_intc_list, list);
+		if (gsi >= ext_intc_element->gsi_base &&
+		    gsi < (ext_intc_element->gsi_base + ext_intc_element->nr_irqs))
+			return ext_intc_element->handle;
+	}
+
+	return NULL;
+}
+
+static acpi_status riscv_acpi_irq_get_parent(struct acpi_resource *ares, void *context)
+{
+	struct acpi_irq_dep_ctx *ctx = context;
+	struct acpi_resource_irq *irq;
+	struct acpi_resource_extended_irq *eirq;
+
+	switch (ares->type) {
+	case ACPI_RESOURCE_TYPE_IRQ:
+		irq = &ares->data.irq;
+		if (ctx->index >= irq->interrupt_count) {
+			ctx->index -= irq->interrupt_count;
+			return AE_OK;
+		}
+		ctx->handle = riscv_acpi_get_gsi_handle(irq->interrupts[ctx->index]);
+		return AE_CTRL_TERMINATE;
+	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
+		eirq = &ares->data.extended_irq;
+		if (eirq->producer_consumer == ACPI_PRODUCER)
+			return AE_OK;
+
+		if (ctx->index >= eirq->interrupt_count) {
+			ctx->index -= eirq->interrupt_count;
+			return AE_OK;
+		}
+
+		/* Support GSIs only */
+		if (eirq->resource_source.string_length)
+			return AE_OK;
+
+		ctx->handle = riscv_acpi_get_gsi_handle(eirq->interrupts[ctx->index]);
+		return AE_CTRL_TERMINATE;
+	}
+
+	return AE_OK;
+}
+
+static int riscv_acpi_irq_get_dep(acpi_handle handle, unsigned int index, acpi_handle *gsi_handle)
+{
+	struct acpi_irq_dep_ctx ctx = {-EINVAL, index, NULL};
+
+	if (!gsi_handle)
+		return 0;
+
+	acpi_walk_resources(handle, METHOD_NAME__CRS, riscv_acpi_irq_get_parent, &ctx);
+	*gsi_handle = ctx.handle;
+	if (*gsi_handle)
+		return 1;
+
+	return 0;
+}
+
+static u32 riscv_acpi_add_prt_dep(acpi_handle handle)
+{
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_pci_routing_table *entry;
+	struct acpi_handle_list dep_devices;
+	acpi_handle gsi_handle;
+	acpi_handle link_handle;
+	acpi_status status;
+	u32 count = 0;
+
+	status = acpi_get_irq_routing_table(handle, &buffer);
+	if (ACPI_FAILURE(status)) {
+		acpi_handle_err(handle, "failed to get IRQ routing table\n");
+		kfree(buffer.pointer);
+		return 0;
+	}
+
+	entry = buffer.pointer;
+	while (entry && (entry->length > 0)) {
+		if (entry->source[0]) {
+			acpi_get_handle(handle, entry->source, &link_handle);
+			dep_devices.count = 1;
+			dep_devices.handles = kcalloc(1, sizeof(*dep_devices.handles), GFP_KERNEL);
+			if (!dep_devices.handles) {
+				acpi_handle_err(handle, "failed to allocate memory\n");
+				continue;
+			}
+
+			dep_devices.handles[0] = link_handle;
+			count += acpi_scan_add_dep(handle, &dep_devices);
+		} else {
+			gsi_handle = riscv_acpi_get_gsi_handle(entry->source_index);
+			dep_devices.count = 1;
+			dep_devices.handles = kcalloc(1, sizeof(*dep_devices.handles), GFP_KERNEL);
+			if (!dep_devices.handles) {
+				acpi_handle_err(handle, "failed to allocate memory\n");
+				continue;
+			}
+
+			dep_devices.handles[0] = gsi_handle;
+			count += acpi_scan_add_dep(handle, &dep_devices);
+		}
+
+		entry = (struct acpi_pci_routing_table *)
+			((unsigned long)entry + entry->length);
+	}
+
+	kfree(buffer.pointer);
+	return count;
+}
+
+static u32 riscv_acpi_add_irq_dep(acpi_handle handle)
+{
+	struct acpi_handle_list dep_devices;
+	acpi_handle gsi_handle;
+	u32 count = 0;
+	int i;
+
+	for (i = 0;
+	     riscv_acpi_irq_get_dep(handle, i, &gsi_handle);
+	     i++) {
+		dep_devices.count = 1;
+		dep_devices.handles = kcalloc(1, sizeof(*dep_devices.handles), GFP_KERNEL);
+		if (!dep_devices.handles) {
+			acpi_handle_err(handle, "failed to allocate memory\n");
+			continue;
+		}
+
+		dep_devices.handles[0] = gsi_handle;
+		count += acpi_scan_add_dep(handle, &dep_devices);
+	}
+
+	return count;
+}
+
+u32 arch_acpi_add_auto_dep(acpi_handle handle)
+{
+	if (acpi_has_method(handle, "_PRT"))
+		return riscv_acpi_add_prt_dep(handle);
+
+	return riscv_acpi_add_irq_dep(handle);
+}
-- 
2.43.0


