Return-Path: <linux-kernel+bounces-282447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7149494E444
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 03:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F6571C20830
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 01:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFF3847A;
	Mon, 12 Aug 2024 00:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="kamCaM+0"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1DC79D1
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 00:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723424391; cv=none; b=T6Jdg/k/KzZwC1g4xD16bDAjTA/7e6ZdOhh4BVORqpHhpY9pJbFQzCVHKgZU/yvDEjAoWJqL7DFdAYVgCOZbGjo8yTIu+Z4nYcb6SzKIzM9cLnEIWjUdzXsiYeuYjqPWRjHFc9am0RXVsk9q7x0rtqhanB4SUJ+pS0zgKMu+Dqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723424391; c=relaxed/simple;
	bh=C+i0U6VGde+1v9kIi2tE1b1sf1jRuHcxIrWnNcHIpqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RTqcEwvaHSm9cBm9g5whQJ0WjnVEFz5QXUHMoMVyYxXEEocziS1DGDb7HCH5qHH+VQWI3aADiQSNTZAoozD2tGTU+eo0Xxq176PrhUXO+96S3LRf0RHTLB0++34hUYbr23Ctw6x+oepiSzB/wDARhZuav7Q81f1r7IPVCTb4eCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=kamCaM+0; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-396e2d21812so13818915ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 17:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723424387; x=1724029187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8jeK3ESAUl7YxTE1Iy3jfhVYgTpS15SSq0iPGR06s9c=;
        b=kamCaM+07fvJ1p7LbpYKhgflBoWCvxULLOfM7e6S02LIjdKKi1ce55qmL222t72HSr
         +dv5fmTA/STb+AzsNYmgVmpIuBwmNyCQZ1vUyHPu5ZjQ8mLEnK+JhaFzqES1A6tDMiHO
         8l66ifZuwPxWY+y9VORbNDjHbbvyLx6JCkd+nDNnonnSZ9Exyp5CPkkk8/+W1TRgleR5
         l0QLNajWl9Q3CYRI3VmymVggNZNF4Tz4Zi+WKryu6N1l7xKRwDDzKdpkmPPbFV4IlIdJ
         20iAnXdXEMQyuquurlpdWYMW7Zvo3kNvmwifOB8+XotPsk4h4yVbS/F2KeFYx32b8i1z
         aksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723424387; x=1724029187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8jeK3ESAUl7YxTE1Iy3jfhVYgTpS15SSq0iPGR06s9c=;
        b=UTvuWI0z4Tar3q6oZ9Bt7EuW8ayeFxbXb2nBY+wyR0YvhqTQSErp8GC4CYxpqnNLs7
         hBnzeLatclbjsKOyYXNymDI86FH7q6ilK/3drdPCaLwd1Xu8oo3lT+/Fhp/agssyR8xo
         rZ1bP16AbRFobLkD5mYSZX+08YALvIpx3TJ/VQXyL0bfTaU4ReLwt3POg9QBJ8F+5AkJ
         TvY2OyPpcSvI7SavyJqvfT1zXQqXH3V6z9uTwW84clDF4mNeqOUQf0dmKVkah6W2NmSU
         gniSTOQV85ZJCTvMS3Kdck9jNlbDzbZuB5J/x+At8YycDYWuV1dkSLjk2ZR2TipaEpw/
         cGgg==
X-Gm-Message-State: AOJu0Yyi5jwjsJhxjZ6FvBFZx0OhA/roB3d5mnU9RE4M1x42PF4MkZJl
	2PuceWwUVBwUkjqT2egOAE+/NeLSdcIXEw+39JzYfgL0/5HXHQUPL+oPcb2zdc3K5X4hVG/VfRj
	ylaAvDQ==
X-Google-Smtp-Source: AGHT+IFIiqNGjgTEsTyA01AhWlCd5/qrU642pe+8j8qsMImF8/xohIsj9BzQ1yvF+gyWEF8FJGTC6A==
X-Received: by 2002:a05:6e02:1a29:b0:398:81e9:3f9e with SMTP id e9e14a558f8ab-39b813345abmr101145885ab.12.1723424387549;
        Sun, 11 Aug 2024 17:59:47 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbe8cbdcsm3074062a12.61.2024.08.11.17.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 17:59:47 -0700 (PDT)
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
Subject: [PATCH v8 01/17] arm64: PCI: Migrate ACPI related functions to pci-acpi.c
Date: Mon, 12 Aug 2024 06:29:13 +0530
Message-ID: <20240812005929.113499-2-sunilvl@ventanamicro.com>
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

The functions defined in arm64 for ACPI support are required
for RISC-V also. To avoid duplication, move these functions
to common location.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Will Deacon <will@kernel.org>
Tested-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/arm64/kernel/pci.c | 191 ----------------------------------------
 drivers/pci/pci-acpi.c  | 182 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 182 insertions(+), 191 deletions(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index f872c57e9909..fd9a7bed83ce 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -6,28 +6,7 @@
  * Copyright (C) 2014 ARM Ltd.
  */
 
-#include <linux/acpi.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/kernel.h>
-#include <linux/mm.h>
 #include <linux/pci.h>
-#include <linux/pci-acpi.h>
-#include <linux/pci-ecam.h>
-#include <linux/slab.h>
-
-#ifdef CONFIG_ACPI
-/*
- * Try to assign the IRQ number when probing a new device
- */
-int pcibios_alloc_irq(struct pci_dev *dev)
-{
-	if (!acpi_disabled)
-		acpi_pci_irq_enable(dev);
-
-	return 0;
-}
-#endif
 
 /*
  * raw_pci_read/write - Platform-specific PCI config space access.
@@ -61,173 +40,3 @@ int pcibus_to_node(struct pci_bus *bus)
 EXPORT_SYMBOL(pcibus_to_node);
 
 #endif
-
-#ifdef CONFIG_ACPI
-
-struct acpi_pci_generic_root_info {
-	struct acpi_pci_root_info	common;
-	struct pci_config_window	*cfg;	/* config space mapping */
-};
-
-int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
-{
-	struct pci_config_window *cfg = bus->sysdata;
-	struct acpi_device *adev = to_acpi_device(cfg->parent);
-	struct acpi_pci_root *root = acpi_driver_data(adev);
-
-	return root->segment;
-}
-
-int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
-{
-	struct pci_config_window *cfg;
-	struct acpi_device *adev;
-	struct device *bus_dev;
-
-	if (acpi_disabled)
-		return 0;
-
-	cfg = bridge->bus->sysdata;
-
-	/*
-	 * On Hyper-V there is no corresponding ACPI device for a root bridge,
-	 * therefore ->parent is set as NULL by the driver. And set 'adev' as
-	 * NULL in this case because there is no proper ACPI device.
-	 */
-	if (!cfg->parent)
-		adev = NULL;
-	else
-		adev = to_acpi_device(cfg->parent);
-
-	bus_dev = &bridge->bus->dev;
-
-	ACPI_COMPANION_SET(&bridge->dev, adev);
-	set_dev_node(bus_dev, acpi_get_node(acpi_device_handle(adev)));
-
-	return 0;
-}
-
-static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
-{
-	struct resource_entry *entry, *tmp;
-	int status;
-
-	status = acpi_pci_probe_root_resources(ci);
-	resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
-		if (!(entry->res->flags & IORESOURCE_WINDOW))
-			resource_list_destroy_entry(entry);
-	}
-	return status;
-}
-
-/*
- * Lookup the bus range for the domain in MCFG, and set up config space
- * mapping.
- */
-static struct pci_config_window *
-pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)
-{
-	struct device *dev = &root->device->dev;
-	struct resource *bus_res = &root->secondary;
-	u16 seg = root->segment;
-	const struct pci_ecam_ops *ecam_ops;
-	struct resource cfgres;
-	struct acpi_device *adev;
-	struct pci_config_window *cfg;
-	int ret;
-
-	ret = pci_mcfg_lookup(root, &cfgres, &ecam_ops);
-	if (ret) {
-		dev_err(dev, "%04x:%pR ECAM region not found\n", seg, bus_res);
-		return NULL;
-	}
-
-	adev = acpi_resource_consumer(&cfgres);
-	if (adev)
-		dev_info(dev, "ECAM area %pR reserved by %s\n", &cfgres,
-			 dev_name(&adev->dev));
-	else
-		dev_warn(dev, FW_BUG "ECAM area %pR not reserved in ACPI namespace\n",
-			 &cfgres);
-
-	cfg = pci_ecam_create(dev, &cfgres, bus_res, ecam_ops);
-	if (IS_ERR(cfg)) {
-		dev_err(dev, "%04x:%pR error %ld mapping ECAM\n", seg, bus_res,
-			PTR_ERR(cfg));
-		return NULL;
-	}
-
-	return cfg;
-}
-
-/* release_info: free resources allocated by init_info */
-static void pci_acpi_generic_release_info(struct acpi_pci_root_info *ci)
-{
-	struct acpi_pci_generic_root_info *ri;
-
-	ri = container_of(ci, struct acpi_pci_generic_root_info, common);
-	pci_ecam_free(ri->cfg);
-	kfree(ci->ops);
-	kfree(ri);
-}
-
-/* Interface called from ACPI code to setup PCI host controller */
-struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
-{
-	struct acpi_pci_generic_root_info *ri;
-	struct pci_bus *bus, *child;
-	struct acpi_pci_root_ops *root_ops;
-	struct pci_host_bridge *host;
-
-	ri = kzalloc(sizeof(*ri), GFP_KERNEL);
-	if (!ri)
-		return NULL;
-
-	root_ops = kzalloc(sizeof(*root_ops), GFP_KERNEL);
-	if (!root_ops) {
-		kfree(ri);
-		return NULL;
-	}
-
-	ri->cfg = pci_acpi_setup_ecam_mapping(root);
-	if (!ri->cfg) {
-		kfree(ri);
-		kfree(root_ops);
-		return NULL;
-	}
-
-	root_ops->release_info = pci_acpi_generic_release_info;
-	root_ops->prepare_resources = pci_acpi_root_prepare_resources;
-	root_ops->pci_ops = (struct pci_ops *)&ri->cfg->ops->pci_ops;
-	bus = acpi_pci_root_create(root, root_ops, &ri->common, ri->cfg);
-	if (!bus)
-		return NULL;
-
-	/* If we must preserve the resource configuration, claim now */
-	host = pci_find_host_bridge(bus);
-	if (host->preserve_config)
-		pci_bus_claim_resources(bus);
-
-	/*
-	 * Assign whatever was left unassigned. If we didn't claim above,
-	 * this will reassign everything.
-	 */
-	pci_assign_unassigned_root_bus_resources(bus);
-
-	list_for_each_entry(child, &bus->children, node)
-		pcie_bus_configure_settings(child);
-
-	return bus;
-}
-
-void pcibios_add_bus(struct pci_bus *bus)
-{
-	acpi_pci_add_bus(bus);
-}
-
-void pcibios_remove_bus(struct pci_bus *bus)
-{
-	acpi_pci_remove_bus(bus);
-}
-
-#endif
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 9cc447da9475..8ed81a373bd7 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -15,6 +15,7 @@
 #include <linux/pci_hotplug.h>
 #include <linux/module.h>
 #include <linux/pci-acpi.h>
+#include <linux/pci-ecam.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_qos.h>
 #include <linux/rwsem.h>
@@ -1541,3 +1542,184 @@ static int __init acpi_pci_init(void)
 	return 0;
 }
 arch_initcall(acpi_pci_init);
+
+#if defined(CONFIG_ARM64)
+
+/*
+ * Try to assign the IRQ number when probing a new device
+ */
+int pcibios_alloc_irq(struct pci_dev *dev)
+{
+	if (!acpi_disabled)
+		acpi_pci_irq_enable(dev);
+
+	return 0;
+}
+
+struct acpi_pci_generic_root_info {
+	struct acpi_pci_root_info	common;
+	struct pci_config_window	*cfg;	/* config space mapping */
+};
+
+int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
+{
+	struct pci_config_window *cfg = bus->sysdata;
+	struct acpi_device *adev = to_acpi_device(cfg->parent);
+	struct acpi_pci_root *root = acpi_driver_data(adev);
+
+	return root->segment;
+}
+
+int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	struct pci_config_window *cfg;
+	struct acpi_device *adev;
+	struct device *bus_dev;
+
+	if (acpi_disabled)
+		return 0;
+
+	cfg = bridge->bus->sysdata;
+
+	/*
+	 * On Hyper-V there is no corresponding ACPI device for a root bridge,
+	 * therefore ->parent is set as NULL by the driver. And set 'adev' as
+	 * NULL in this case because there is no proper ACPI device.
+	 */
+	if (!cfg->parent)
+		adev = NULL;
+	else
+		adev = to_acpi_device(cfg->parent);
+
+	bus_dev = &bridge->bus->dev;
+
+	ACPI_COMPANION_SET(&bridge->dev, adev);
+	set_dev_node(bus_dev, acpi_get_node(acpi_device_handle(adev)));
+
+	return 0;
+}
+
+static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
+{
+	struct resource_entry *entry, *tmp;
+	int status;
+
+	status = acpi_pci_probe_root_resources(ci);
+	resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
+		if (!(entry->res->flags & IORESOURCE_WINDOW))
+			resource_list_destroy_entry(entry);
+	}
+	return status;
+}
+
+/*
+ * Lookup the bus range for the domain in MCFG, and set up config space
+ * mapping.
+ */
+static struct pci_config_window *
+pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)
+{
+	struct device *dev = &root->device->dev;
+	struct resource *bus_res = &root->secondary;
+	u16 seg = root->segment;
+	const struct pci_ecam_ops *ecam_ops;
+	struct resource cfgres;
+	struct acpi_device *adev;
+	struct pci_config_window *cfg;
+	int ret;
+
+	ret = pci_mcfg_lookup(root, &cfgres, &ecam_ops);
+	if (ret) {
+		dev_err(dev, "%04x:%pR ECAM region not found\n", seg, bus_res);
+		return NULL;
+	}
+
+	adev = acpi_resource_consumer(&cfgres);
+	if (adev)
+		dev_info(dev, "ECAM area %pR reserved by %s\n", &cfgres,
+			 dev_name(&adev->dev));
+	else
+		dev_warn(dev, FW_BUG "ECAM area %pR not reserved in ACPI namespace\n",
+			 &cfgres);
+
+	cfg = pci_ecam_create(dev, &cfgres, bus_res, ecam_ops);
+	if (IS_ERR(cfg)) {
+		dev_err(dev, "%04x:%pR error %ld mapping ECAM\n", seg, bus_res,
+			PTR_ERR(cfg));
+		return NULL;
+	}
+
+	return cfg;
+}
+
+/* release_info: free resources allocated by init_info */
+static void pci_acpi_generic_release_info(struct acpi_pci_root_info *ci)
+{
+	struct acpi_pci_generic_root_info *ri;
+
+	ri = container_of(ci, struct acpi_pci_generic_root_info, common);
+	pci_ecam_free(ri->cfg);
+	kfree(ci->ops);
+	kfree(ri);
+}
+
+/* Interface called from ACPI code to setup PCI host controller */
+struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
+{
+	struct acpi_pci_generic_root_info *ri;
+	struct pci_bus *bus, *child;
+	struct acpi_pci_root_ops *root_ops;
+	struct pci_host_bridge *host;
+
+	ri = kzalloc(sizeof(*ri), GFP_KERNEL);
+	if (!ri)
+		return NULL;
+
+	root_ops = kzalloc(sizeof(*root_ops), GFP_KERNEL);
+	if (!root_ops) {
+		kfree(ri);
+		return NULL;
+	}
+
+	ri->cfg = pci_acpi_setup_ecam_mapping(root);
+	if (!ri->cfg) {
+		kfree(ri);
+		kfree(root_ops);
+		return NULL;
+	}
+
+	root_ops->release_info = pci_acpi_generic_release_info;
+	root_ops->prepare_resources = pci_acpi_root_prepare_resources;
+	root_ops->pci_ops = (struct pci_ops *)&ri->cfg->ops->pci_ops;
+	bus = acpi_pci_root_create(root, root_ops, &ri->common, ri->cfg);
+	if (!bus)
+		return NULL;
+
+	/* If we must preserve the resource configuration, claim now */
+	host = pci_find_host_bridge(bus);
+	if (host->preserve_config)
+		pci_bus_claim_resources(bus);
+
+	/*
+	 * Assign whatever was left unassigned. If we didn't claim above,
+	 * this will reassign everything.
+	 */
+	pci_assign_unassigned_root_bus_resources(bus);
+
+	list_for_each_entry(child, &bus->children, node)
+		pcie_bus_configure_settings(child);
+
+	return bus;
+}
+
+void pcibios_add_bus(struct pci_bus *bus)
+{
+	acpi_pci_add_bus(bus);
+}
+
+void pcibios_remove_bus(struct pci_bus *bus)
+{
+	acpi_pci_remove_bus(bus);
+}
+
+#endif
-- 
2.43.0


