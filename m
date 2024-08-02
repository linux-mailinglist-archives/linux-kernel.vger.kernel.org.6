Return-Path: <linux-kernel+bounces-273170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05718946538
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4391828388B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5ABD13775B;
	Fri,  2 Aug 2024 21:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+GR71yS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1866E73446
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 21:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722635064; cv=none; b=NAntT0xYgc/sytAip/laEbuBBfVub9eax7bB9mQDoRpNOsD/XUxgu8JBa/VChla1LCTrTWnmfUVOK5JU4+rpR1nmd3Vpw+cXEkJXl/ivhEllM1xtu9Kmcmr1MRXS+w5iIqNOnFEDLz2IZ7nab9JOp8hM76Dpz2J2TW+kH9J1OVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722635064; c=relaxed/simple;
	bh=oBrmRMT6eVkZhSBwJ/tCQXBFfP8uBbfVpOcor3ldlVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZjOLdtM/r8wmpdI40eVl35Sr7mJxLwoCaG2hBgDmUaBXb4hn0r0zQncmr5d+Y0sxvXBGsFiM7einZQ+mYaEPjkdK7MOJn6w1orcOzdzX2ztGTCZCSXDbuHaP3MHQbbUMZp42MkwnzTyWKWKbuV7R5Ph2weS0hKAxlAPH3a98r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+GR71yS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9E5C4AF09;
	Fri,  2 Aug 2024 21:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722635063;
	bh=oBrmRMT6eVkZhSBwJ/tCQXBFfP8uBbfVpOcor3ldlVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P+GR71ySO4elhXHLcBnJY5xs7O1P+RAm2L5b5NPqDn/+LOJAXp6bzkLZduF/0HWBO
	 IqpYVcn2/bexTq+s1risYu7u9OKAx247lEgTkyV1YYKHpRy5wY0WnvKqpCObnezwiR
	 YQnn9aNIBdYbXJnuMElohcL6mMS9DnzjdnLjyx0nx8FFnhbkpmQ2FkxJ5ewlU4m228
	 pc6VHXb3zm9Zr/D2K+HwRKDIwIiCO0PWA02eFLqE8Grtzyl1YhAPm44yHLuRQOpdnA
	 1RQSD9G1fTlOtWsBoHlv9QR8D1iNqVKDC5Lb2bSTMMusUT+303X1p/pB9naf1niVD1
	 2WZ93wpP1Zicw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1sa04T-00000002naJ-2sEj;
	Fri, 02 Aug 2024 23:44:21 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Shannon Zhao <shannon.zhaosl@gmail.com>,
	linux-kernel@vger.kernel.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v5 3/7] arm/virt: Wire up GPIO error source for ACPI / GHES
Date: Fri,  2 Aug 2024 23:43:58 +0200
Message-ID: <d0607d8f6116ff841b6c6a17d20f6d7077063045.1722634602.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722634602.git.mchehab+huawei@kernel.org>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Adds support to ARM virtualization to allow handling
a General Purpose Event (GPE) via GED error device.

It is aligned with Linux Kernel patch:
https://lore.kernel.org/lkml/1272350481-27951-8-git-send-email-ying.huang@intel.com/

Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/ghes.c           |  3 +++
 hw/arm/virt-acpi-build.c |  1 +
 hw/arm/virt.c            | 16 +++++++++++++++-
 include/hw/acpi/ghes.h   |  3 +++
 include/hw/arm/virt.h    |  1 +
 5 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index e9511d9b8f71..8d0262e6c1aa 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -444,6 +444,9 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
     return ret;
 }
 
+NotifierList generic_error_notifiers =
+    NOTIFIER_LIST_INITIALIZER(error_device_notifiers);
+
 bool acpi_ghes_present(void)
 {
     AcpiGedState *acpi_ged_state;
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index f76fb117adff..f8bbe3e7a0b8 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -858,6 +858,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     }
 
     acpi_dsdt_add_power_button(scope);
+    acpi_dsdt_add_error_device(scope);
 #ifdef CONFIG_TPM
     acpi_dsdt_add_tpm(scope, vms);
 #endif
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 687fe0bb8bc9..8b315328154f 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -73,6 +73,7 @@
 #include "standard-headers/linux/input.h"
 #include "hw/arm/smmuv3.h"
 #include "hw/acpi/acpi.h"
+#include "hw/acpi/ghes.h"
 #include "target/arm/cpu-qom.h"
 #include "target/arm/internals.h"
 #include "target/arm/multiprocessing.h"
@@ -677,7 +678,7 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
     DeviceState *dev;
     MachineState *ms = MACHINE(vms);
     int irq = vms->irqmap[VIRT_ACPI_GED];
-    uint32_t event = ACPI_GED_PWR_DOWN_EVT;
+    uint32_t event = ACPI_GED_PWR_DOWN_EVT | ACPI_GED_ERROR_EVT;
 
     if (ms->ram_slots) {
         event |= ACPI_GED_MEM_HOTPLUG_EVT;
@@ -1009,6 +1010,15 @@ static void virt_powerdown_req(Notifier *n, void *opaque)
     }
 }
 
+static void virt_generic_error_req(Notifier *n, void *opaque)
+{
+    VirtMachineState *s = container_of(n, VirtMachineState, generic_error_notifier);
+
+    if (s->acpi_dev) {
+        acpi_send_event(s->acpi_dev, ACPI_GENERIC_ERROR);
+    }
+}
+
 static void create_gpio_keys(char *fdt, DeviceState *pl061_dev,
                              uint32_t phandle)
 {
@@ -2397,6 +2407,10 @@ static void machvirt_init(MachineState *machine)
      vms->powerdown_notifier.notify = virt_powerdown_req;
      qemu_register_powerdown_notifier(&vms->powerdown_notifier);
 
+     vms->generic_error_notifier.notify = virt_generic_error_req;
+     notifier_list_add(&generic_error_notifiers,
+                       &vms->generic_error_notifier);
+
     /* Create mmio transports, so the user can create virtio backends
      * (which will be automatically plugged in to the transports). If
      * no backend is created the transport will just sit harmlessly idle.
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 674f6958e905..6891eafff5ab 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -23,6 +23,9 @@
 #define ACPI_GHES_H
 
 #include "hw/acpi/bios-linker-loader.h"
+#include "qemu/notify.h"
+
+extern NotifierList generic_error_notifiers;
 
 /*
  * Values for Hardware Error Notification Type field
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index a4d937ed45ac..ad9f6e94dcc5 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -175,6 +175,7 @@ struct VirtMachineState {
     DeviceState *gic;
     DeviceState *acpi_dev;
     Notifier powerdown_notifier;
+    Notifier generic_error_notifier;
     PCIBus *bus;
     char *oem_id;
     char *oem_table_id;
-- 
2.45.2


