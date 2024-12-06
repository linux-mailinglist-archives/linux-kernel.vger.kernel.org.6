Return-Path: <linux-kernel+bounces-435400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D5D9E770B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8644E1883A55
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E40921AA09;
	Fri,  6 Dec 2024 17:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmipS22S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73979203D56
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505688; cv=none; b=BKWyTEk3xE64AxtSFd79h7YuqJdpZO13F38Tee+SIa+cXqcIxtSlqb5aIfuS6k0eOc3XS9bAsHPqH91KI9pwZiLMQjyes4EyeJ1iTPq9sQ7ETyn4pGd2S1Z/rQ8B5yLKQpu6ZIa0xzFsg6vO0mSZyBhsgeIVACInF8Der9R1bW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505688; c=relaxed/simple;
	bh=WdvNgQYWShtxIcm6i2e5IyxmF2QzEyH+E6nYU6VJMwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KfLkI32NT/Giqa0entnhJGNd/L5AlHwXfD209c4U+GwhgiNnfrgKP8U6zpTpcPC5pRkfHA75Qpje3jc80RZyP41FMKxZjPxGNo7jNjRaGgD64FD4NpdYtJl93TMBvduCOzK+TaOYsYgIpK0mphiTb0amkSIJsrkR6+dKrjMjy6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmipS22S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A4DC4CEDE;
	Fri,  6 Dec 2024 17:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733505687;
	bh=WdvNgQYWShtxIcm6i2e5IyxmF2QzEyH+E6nYU6VJMwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lmipS22S0xFcj7zeHfFbGWONRb/0RcaK6mb+9jhVva21LHmVYBRQM5FzIfYZXTSj0
	 q8qkNos//97wfy3QAdYNssoiyH74x+yUOR94+/KYJK53cYxgiXo3dfwJyMcGcYANny
	 aCpWwyeyYWTZK22aLLTKFFaEk+sZa+wBBTYjBP2z7It0dUxD8JS0cDIS/zkx4f/siu
	 eRlJo2FSOOniR6Iyv4/S/DChg+Knt6DTRt+psfnXEWQs8HYh0WFHMkumJal/iyj6jz
	 R3rsL7Zy29iSrbt3WchqI2z83lqePoIxLD4mu/KrU2PaT+UHrAK4uKnOE9b+AoKbaM
	 gBA0ukMpNiuUg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tJc18-00000005RKs-0Dd4;
	Fri, 06 Dec 2024 18:21:26 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Ani Sinha <anisinha@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Shannon Zhao <shannon.zhaosl@gmail.com>,
	linux-kernel@vger.kernel.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 21/31] arm/virt: Wire up a GED error device for ACPI / GHES
Date: Fri,  6 Dec 2024 18:12:43 +0100
Message-ID: <99c66bcc0229403ae61c5044371fed9b82e03b8c.1733504943.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733504943.git.mchehab+huawei@kernel.org>
References: <cover.1733504943.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Adds support to ARM virtualization to allow handling
generic error ACPI Event via GED & error source device.

It is aligned with Linux Kernel patch:
https://lore.kernel.org/lkml/1272350481-27951-8-git-send-email-ying.huang@intel.com/

Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Igor Mammedov <imammedo@redhat.com>

---

Changes from v8:

- Added a call to the function that produces GHES generic
  records, as this is now added earlier in this series.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/arm/virt-acpi-build.c |  1 +
 hw/arm/virt.c            | 12 +++++++++++-
 include/hw/arm/virt.h    |  1 +
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 46ce3f3bb07a..eb5b61f636d2 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -857,6 +857,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     }
 
     acpi_dsdt_add_power_button(scope);
+    aml_append(scope, aml_error_device());
 #ifdef CONFIG_TPM
     acpi_dsdt_add_tpm(scope, vms);
 #endif
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 1a381e9a2bd7..795d215521a3 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -678,7 +678,7 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
     DeviceState *dev;
     MachineState *ms = MACHINE(vms);
     int irq = vms->irqmap[VIRT_ACPI_GED];
-    uint32_t event = ACPI_GED_PWR_DOWN_EVT;
+    uint32_t event = ACPI_GED_PWR_DOWN_EVT | ACPI_GED_ERROR_EVT;
 
     if (ms->ram_slots) {
         event |= ACPI_GED_MEM_HOTPLUG_EVT;
@@ -1010,6 +1010,13 @@ static void virt_powerdown_req(Notifier *n, void *opaque)
     }
 }
 
+static void virt_generic_error_req(Notifier *n, void *opaque)
+{
+    VirtMachineState *s = container_of(n, VirtMachineState, generic_error_notifier);
+
+    acpi_send_event(s->acpi_dev, ACPI_GENERIC_ERROR);
+}
+
 static void create_gpio_keys(char *fdt, DeviceState *pl061_dev,
                              uint32_t phandle)
 {
@@ -2403,6 +2410,9 @@ static void machvirt_init(MachineState *machine)
 
     if (has_ged && aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
         vms->acpi_dev = create_acpi_ged(vms);
+        vms->generic_error_notifier.notify = virt_generic_error_req;
+        notifier_list_add(&acpi_generic_error_notifiers,
+                          &vms->generic_error_notifier);
     } else {
         create_gpio_devices(vms, VIRT_GPIO, sysmem);
     }
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index aca4f8061b18..24ab84cd623d 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -176,6 +176,7 @@ struct VirtMachineState {
     DeviceState *gic;
     DeviceState *acpi_dev;
     Notifier powerdown_notifier;
+    Notifier generic_error_notifier;
     PCIBus *bus;
     char *oem_id;
     char *oem_table_id;
-- 
2.47.1


