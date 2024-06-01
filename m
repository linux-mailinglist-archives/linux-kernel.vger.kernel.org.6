Return-Path: <linux-kernel+bounces-197918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E11E8D70B8
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 17:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19D4E1F2500A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 15:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69029154C1C;
	Sat,  1 Jun 2024 15:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="RHJ8TfGv"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D11154C19
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 15:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717254348; cv=none; b=b5c81IZtQczBvEttIygUXN3R21SGi9Da9hMS1blcO4nUmHJLXGgfsiqqBo9dLtLWcfS7uUKz8txLRZpqc5gpAFRHLOZ+GE46NUMcvCXa/5760drMKhXF1H/XVM+gLG2hU63Qu/3Rx4PhojBI+36hRQd0uxIIp3AHSs2yiKKvT8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717254348; c=relaxed/simple;
	bh=qhqCGi8o9IAINNxfLRxMEmmSPodYgvrNH462+zJ18l4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gqbVKgJyKBIJ6Gf0bSikQHKF6vYUhYNOEuTPmWdq/nvP3DSYa8PKR7EYtQT5rSt2XqZ3emNp858DYIvHWgCZRV924ifMM1cfwehi3DtjT8A8WqUGvAuGO9ANpe4Ns/vIbIOBJlrdU/LXtCXlN7G6A+rif2HoECap2m+2v73sNyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=RHJ8TfGv; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7024d571d8eso1162716b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 08:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1717254346; x=1717859146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BG93T+gcNC0mbkbP77au2VNz1Cnxnueu2TjA3uMrqLg=;
        b=RHJ8TfGvuwYRlkH8272sfnb4OreNRjQwCYQdTuPbJPiBTQXtvjEWXXe+xGCaokNXs7
         Z5Olt75JXfyrNal161/Vbfv7TiikbQAmCJQ/SgfyD8K2Dc5QmiV/o1loHux2A3uA0Fu4
         HLPwbw0f76Ds0263CrCJpnmMu/VD/dzEml4ta8gKbbkSmZjISgRHoO1LEHwxZS3EWZ9U
         ztEB/mzYlZnfiwV5ZU49bmW8qsvvA1VmlQHbrOhLll/vnMz4p2i6C/GcBELg7d5YxC2N
         RBmMSQUAagsuznccx4i6VMWhjL+c2XThy4y+HKaVxI/YHHSag9wt5Bv2XAW9SH1dZwiB
         TXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717254346; x=1717859146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BG93T+gcNC0mbkbP77au2VNz1Cnxnueu2TjA3uMrqLg=;
        b=bWHMtWgd+ix2DOq4j699kTvZZbsUEcBZoO+r4hVEpDZ0AIinDjc/cQ7S49I8BaB+7b
         +uzG/CK41r+4EUmGjguRHGN1AJCji0Hd849B0HLTWvBwd8p8XQ3goOsLSrqzLXlQZlGF
         Qms9UOmP47zFsxFhlPw3clr2+IqGZB1mOScHJ62kBZh4P2CCE0nHTF49omEsApkDJ2cz
         YN7K1u2wQ8Xm/Fg65nyO9suoyZ+oEYNU3cPqTtt7sQhf1/tJdpKCeXM90Bt0hiU4hPno
         v9SMLJmTpbQvVyP/+foeEZbcpw6+XLmlyKb9obgcHa3V1vy29CZLWwPRes+x1p5MfltN
         s74w==
X-Forwarded-Encrypted: i=1; AJvYcCWXOQHsDUOoZZicrwrLVHUnHWLco0zAklb0j8BqNaUTct7cd1YEDUSWx6vjryR11ALWW2NGWktUXSrsgqI/GMsuFGGUNHeQIPqaOCGl
X-Gm-Message-State: AOJu0Ywx6pHTkGY1bbrpXSiVPrmTddTO0b8wwA9ydT94bFUklrqJ7OW3
	MfJURE8KdnWOcT1AImmcw4cH9OQWFBB6zFlgZdTIOJY6+fgrTJu4sDKzjoyXKDk=
X-Google-Smtp-Source: AGHT+IGt8M7K1Q6B0sZgxbaoEdNcJvuzpgSkdhFy04fdredDtbILIAAzArLyrTUTnKrXnoT2rN90ng==
X-Received: by 2002:a05:6a20:f386:b0:1a7:55f2:c92c with SMTP id adf61e73a8af0-1b26f254173mr5234362637.45.1717254346265;
        Sat, 01 Jun 2024 08:05:46 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.237])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c35a4ba741sm2559410a12.85.2024.06.01.08.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 08:05:45 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
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
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v6 12/17] ACPI: RISC-V: Implement function to add implicit dependencies
Date: Sat,  1 Jun 2024 20:34:06 +0530
Message-Id: <20240601150411.1929783-13-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240601150411.1929783-1-sunilvl@ventanamicro.com>
References: <20240601150411.1929783-1-sunilvl@ventanamicro.com>
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
index 0473428e8d1e..2878ae48131f 100644
--- a/drivers/acpi/riscv/irq.c
+++ b/drivers/acpi/riscv/irq.c
@@ -21,6 +21,12 @@ struct riscv_ext_intc_list {
 	struct list_head list;
 };
 
+struct acpi_irq_dep_ctx {
+	int rc;
+	unsigned int index;
+	acpi_handle handle;
+};
+
 LIST_HEAD(ext_intc_list);
 
 static int irqchip_cmp_func(const void *in0, const void *in1)
@@ -62,6 +68,21 @@ static void riscv_acpi_update_gsi_handle(u32 gsi_base, acpi_handle handle)
 	acpi_handle_err(handle, "failed to find the GSI mapping entry\n");
 }
 
+static acpi_handle riscv_acpi_get_gsi_handle(u32 gsi)
+{
+	struct riscv_ext_intc_list *ext_intc_element;
+	struct list_head *i, *tmp;
+
+	list_for_each_safe(i, tmp, &ext_intc_list) {
+		ext_intc_element = list_entry(i, struct riscv_ext_intc_list, list);
+		if (gsi >= ext_intc_element->gsi_base &&
+		    gsi < (ext_intc_element->gsi_base + ext_intc_element->nr_irqs))
+			return ext_intc_element->handle;
+	}
+
+	return NULL;
+}
+
 int riscv_acpi_get_gsi_info(struct fwnode_handle *fwnode, u32 *gsi_base,
 			    u32 *id, u32 *nr_irqs, u32 *nr_idcs)
 {
@@ -172,3 +193,137 @@ void __init riscv_acpi_init_gsi_mapping(void)
 	if (acpi_table_parse_madt(ACPI_MADT_TYPE_APLIC, riscv_acpi_aplic_parse_madt, 0) > 0)
 		acpi_get_devices("RSCV0002", riscv_acpi_create_gsi_map, NULL, NULL);
 }
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
2.40.1


