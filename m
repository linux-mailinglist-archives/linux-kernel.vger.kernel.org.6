Return-Path: <linux-kernel+bounces-544247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E79A4DF47
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C86253A6135
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0910F204680;
	Tue,  4 Mar 2025 13:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAHnmGcO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4321E2036F5
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 13:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741095077; cv=none; b=aPywFOzAw+0g9Ohiz31I94rUjpVfKRahHK7Qyxkb0SBrNiikBZx4PBETgLD/dVO2WIqMtny26OrPDGMKGAMZXVvMgIRmbFbZC2eGqr48ZOalID7FgFcWijIm1bspXh6ZbActG7Q+eQOseT+OeLthfU3yuB+DIX6tOWnpEjpUXqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741095077; c=relaxed/simple;
	bh=XdC1WV9yBOfdA2FRBZWRs2sr1CJF0slV+rmf0X8pSDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kse9xsr3rpyoWoqZJo1eko4UpEDkBLuWjEV/NoK80R0y9LGZgaSio7kNsMGag82UGkkFFKBe+HjxQxRXICCgx3BTyfI/l+9n2fXfjDYBp32+Rxj93cMm9jmQgzcFP9IVPehq7rMQEmSaBCyhXLJGxD18SJyl3swFzJ98LWkHcHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAHnmGcO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88350C4AF0C;
	Tue,  4 Mar 2025 13:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741095076;
	bh=XdC1WV9yBOfdA2FRBZWRs2sr1CJF0slV+rmf0X8pSDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MAHnmGcOwcGxHesS9lQGNLDf9bM/lsaF5nf9YVh7ROjDeC5/2bsaCDEKi5MvvPIj0
	 RD6OnRx9iZJJoFUKx2I81UrdujNkypIz4RO0tgcakJteBibmVmcad9s97rVUVBfAvi
	 wJwBaUorA5X45c5uHhMFTrmH0/F0YVyOX4u+4PENaBxnnpzBZdNNeh1vHB05nKcRbx
	 Ms8A7OyCxAViO0cdV4uMu+bEORLTqjCEzOWfe+doagPGLUss+6RfZdt2VLAz5e/y5W
	 kapYSToeivdxSOz2ubZ/Ago82eT5vH3jB36SWFEjk2Zz9MLk4xdUbE0qUkmRQWl+vg
	 +x6DO5Z8BWzzg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tpSMc-00000005rnT-20pO;
	Tue, 04 Mar 2025 14:31:14 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Ani Sinha <anisinha@redhat.com>,
	Eduardo Habkost <eduardo@habkost.net>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 2/3] hw/i186: add support for HEST table with SCI
Date: Tue,  4 Mar 2025 14:30:57 +0100
Message-ID: <02ae08c5e6e1116e587f208159a2ecf80979181d.1741094512.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741094512.git.mchehab+huawei@kernel.org>
References: <cover.1741094512.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Can be tested by setting machine to:
	q35,ras=on

E.g.:

qemu-system-x86_64 --enable-kvm -cpu host -m 4g,maxmem=8G,slots=8 \
	-M q35,nvdimm=on,ras=on \
	-monitor stdio -no-reboot -drive if=pflash,file=OVMF_CODE.fd,format=raw \
	-kernel ../linux/arch/x86_64/boot/bzImage \
	-device pcie-root-port,id=root_port1 -device virtio-blk-pci,drive=hd \
	-device virtio-net-pci,netdev=mynet,id=bob \
	-drive if=none,file=debian.qcow2,format=qcow2,id=hd \
	-object memory-backend-ram,size=4G,id=mem0 \
	-netdev type=user,id=mynet,hostfwd=tcp::5555-:22 \
	-qmp tcp:localhost:4445,server=on,wait=off \
	-append 'earlycon nomodeset root=/dev/vda1 fsck.mode=skip tp_printk maxcpus=4 console=ttyS0 console=tty0'

TODO: add a notifier logic.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/i386/Kconfig      |  1 +
 hw/i386/acpi-build.c | 33 +++++++++++++++++++++++++++++++++
 hw/i386/pc.c         | 42 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/i386/pc.h |  5 +++++
 4 files changed, 81 insertions(+)

diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index d34ce07b215d..a07d5aa1a138 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -60,6 +60,7 @@ config PC_ACPI
     select ACPI_CPU_HOTPLUG
     select ACPI_MEMORY_HOTPLUG
     select ACPI_PCI_BRIDGE
+    select ACPI_APEI
     select ACPI_VIOT
     select SMBUS_EEPROM
     select PFLASH_CFI01
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 3fffa4a33280..cf11231b5fe6 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -38,6 +38,7 @@
 #include "hw/nvram/fw_cfg.h"
 #include "hw/acpi/bios-linker-loader.h"
 #include "hw/acpi/acpi_aml_interface.h"
+#include "hw/acpi/generic_event_device.h"
 #include "hw/input/i8042.h"
 #include "hw/acpi/memory_hotplug.h"
 #include "system/tpm.h"
@@ -69,6 +70,7 @@
 #include "hw/acpi/utils.h"
 #include "hw/acpi/pci.h"
 #include "hw/acpi/cxl.h"
+#include "hw/acpi/ghes.h"
 
 #include "qom/qom-qobject.h"
 #include "hw/i386/amd_iommu.h"
@@ -2431,6 +2433,10 @@ static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
     return true;
 }
 
+static const AcpiNotificationSourceId hest_ghes_notify[] = {
+    {ACPI_HEST_SRC_ID_QMP, ACPI_GHES_NOTIFY_GPIO},
+};
+
 static
 void acpi_build(AcpiBuildTables *tables, MachineState *machine)
 {
@@ -2587,6 +2593,15 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
         cxl_build_cedt(table_offsets, tables_blob, tables->linker,
                        x86ms->oem_id, x86ms->oem_table_id, &pcms->cxl_devices_state);
     }
+    if (pcms->ras) {
+        printf("ADD HEST\n");
+        acpi_add_table(table_offsets, tables_blob);
+        acpi_build_hest(tables_blob, true, tables->hardware_errors,
+                        tables->linker, hest_ghes_notify,
+                        ARRAY_SIZE(hest_ghes_notify),
+                        x86ms->oem_id, x86ms->oem_table_id);
+        printf("ADD HEST: added\n");
+    }
 
     acpi_add_table(table_offsets, tables_blob);
     build_waet(tables_blob, tables->linker, x86ms->oem_id, x86ms->oem_table_id);
@@ -2742,6 +2757,24 @@ void acpi_setup(void)
     }
 #endif
 
+    if (pcms->ras) {
+        AcpiGhesState *ags;
+        AcpiGedState *acpi_ged_state;
+
+        acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
+                                                           NULL));
+        if (acpi_ged_state) {
+            printf("GHES FW_CFG: %p\n", acpi_ged_state);
+
+            ags = &acpi_ged_state->ghes_state;
+
+            acpi_ghes_add_fw_cfg(ags, x86ms->fw_cfg, true,
+                                 tables.hardware_errors);
+
+            printf("GHES FW_CFG: end\n");
+        }
+    }
+
     vmgenid_dev = find_vmgenid_dev();
     if (vmgenid_dev) {
         vmgenid_add_fw_cfg(VMGENID(vmgenid_dev), x86ms->fw_cfg,
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 63a96cd23f84..b9c32dbdbcd8 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -47,6 +47,7 @@
 #include "qobject/qlist.h"
 #include "qemu/error-report.h"
 #include "hw/acpi/cpu_hotplug.h"
+#include "hw/acpi/ghes.h"
 #include "acpi-build.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/cxl/cxl_host.h"
@@ -1683,6 +1684,37 @@ static void pc_machine_set_max_fw_size(Object *obj, Visitor *v,
     pcms->max_fw_size = value;
 }
 
+static bool virt_get_ras(Object *obj, Error **errp)
+{
+    PCMachineState *pcms = PC_MACHINE(obj);
+
+    return pcms->ras;
+}
+
+static void virt_set_ras(Object *obj, bool value, Error **errp)
+{
+    PCMachineState *pcms = PC_MACHINE(obj);
+
+    pcms->ras = value;
+}
+
+static void pc_sci_error(Notifier *n, void *opaque)
+{
+    uint16_t *source_id = opaque;
+
+    fprintf(stderr, "GHES error for source ID: %d\n", *source_id);
+
+    /* Currently, only QMP injection is supported */
+    if (*source_id != ACPI_HEST_SRC_ID_QMP)
+        return;
+
+    fprintf(stderr, "GHES error notified for QMP\n");
+
+    // TODO: add something equivalent to:
+    // PCMachineState *s = container_of(n, PCMachineState, ghes_sci_notifier);
+    // acpi_send_event(s->acpi_dev, ACPI_GENERIC_ERROR);
+    // by calling acpi_update_sci();
+}
 
 static void pc_machine_initfn(Object *obj)
 {
@@ -1717,6 +1749,10 @@ static void pc_machine_initfn(Object *obj)
     if (pcmc->pci_enabled) {
         cxl_machine_init(obj, &pcms->cxl_devices_state);
     }
+
+    pcms->ghes_sci_notifier.notify = pc_sci_error;
+    notifier_list_add(&acpi_generic_error_notifiers,
+                        &pcms->ghes_sci_notifier);
 }
 
 static void pc_machine_reset(MachineState *machine, ResetType type)
@@ -1853,6 +1889,12 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, PC_MACHINE_SMBIOS_EP,
         "SMBIOS Entry Point type [32, 64]");
 
+    object_class_property_add_bool(oc, "ras", virt_get_ras,
+                                   virt_set_ras);
+    object_class_property_set_description(oc, "ras",
+                                          "Set on/off to enable/disable reporting host memory errors "
+                                          "to a KVM guest using ACPI and guest external abort exceptions");
+
     object_class_property_add_bool(oc, "fd-bootchk",
         pc_machine_get_fd_bootchk,
         pc_machine_set_fd_bootchk);
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 103b54301f82..105b087e7af6 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -30,6 +30,9 @@ typedef struct PCMachineState {
     /* State for other subsystems/APIs: */
     Notifier machine_done;
 
+    /* Triggered when a new SCI GHES error raises */
+    Notifier ghes_sci_notifier;
+
     /* Pointers to devices and objects: */
     PCIBus *pcibus;
     I2CBus *smbus;
@@ -51,6 +54,8 @@ typedef struct PCMachineState {
     bool i8042_enabled;
     bool default_bus_bypass_iommu;
     bool fd_bootchk;
+    bool ras;
+
     uint64_t max_fw_size;
 
     /* ACPI Memory hotplug IO base address */
-- 
2.48.1


