Return-Path: <linux-kernel+bounces-300238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 040BA95E0E6
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 05:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A28AA1F21A7B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 03:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB5F288BD;
	Sun, 25 Aug 2024 03:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3It3ses"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FB62868D
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 03:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724557636; cv=none; b=VaYSSmOsIYmGan2cbglSwNRLgfUjlshfMJ/g4uCX4q0PAagVnBweq+7UcO5N+a8DzgPPcvpBeggQl6lbjmOiBQ6BYw7u1DZHs7SVUg8gKHR15Z1Jvmi6fwvAc3DCuuKI+nQcDp/DzEMY2IvnVngIViZOd46wPBEb1Epy7dNTwCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724557636; c=relaxed/simple;
	bh=E6O1ctgUa677iujWilUPezrhy9zE9/BtlDSwRGei2z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e84GqK3jmIOfLf75jwlmBGIwaVPQRw8TF1sw5Ds8XJQf1jaEi5L2zys8+3GB48D8ck7hDnxBsvRtkq3wTIvEj6C9rlnNTftUCleY2OIgPmOFYbjmwkVshErs9HfGJ+clpylDR/LR05v7KhSHjcIpYhnenGOoDjqVfJhkFL01XbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3It3ses; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76053C32782;
	Sun, 25 Aug 2024 03:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724557635;
	bh=E6O1ctgUa677iujWilUPezrhy9zE9/BtlDSwRGei2z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F3It3sesLMosz1WG6Hn3C/YaLe35RYNjjX4YpjaEl0cYkEmY1umuGu2QjoLyu5C8O
	 4B6oKkseQQsr1U2SZzCrhM5eaG1oLNsLSOq+QmGcItGFx8Npsp07VtjwQOoimeidBg
	 LfyWy75lWrjrhXGQnkG0pSocjK9l5VKULmXAMacNiNoP9aOEp8iug9w1RHDYi2+RF5
	 qreOc1pGMJB1nxcHfiRin2Wvlfld2tVNZKa3xeQBx3nf8qweJVqOCftdkbRXCRn1fZ
	 gWJKJwFbXWZnB/KXI/u0JmBlVs+cKCCU0vJoIBS5F0CrOQHIlk/IAnzIrap5QGCFfr
	 3QXZLrG6nTlSA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab@kernel.org>)
	id 1si4Ch-00000001RMp-2gQI;
	Sun, 25 Aug 2024 05:46:11 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Shannon Zhao <shannon.zhaosl@gmail.com>,
	linux-kernel@vger.kernel.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v9 07/12] arm/virt: Wire up a GED error device for ACPI / GHES
Date: Sun, 25 Aug 2024 05:46:02 +0200
Message-ID: <8282df4f346be0235a153d4710ed6ec11d099942.1724556967.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724556967.git.mchehab+huawei@kernel.org>
References: <cover.1724556967.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

Adds support to ARM virtualization to allow handling
generic error ACPI Event via GED & error source device.

It is aligned with Linux Kernel patch:
https://lore.kernel.org/lkml/1272350481-27951-8-git-send-email-ying.huang@intel.com/

Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
index 39100c2822c2..9c36da3c831f 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -858,6 +858,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     }
 
     acpi_dsdt_add_power_button(scope);
+    aml_append(scope, aml_error_device());
 #ifdef CONFIG_TPM
     acpi_dsdt_add_tpm(scope, vms);
 #endif
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 687fe0bb8bc9..22448e5c5b73 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -677,7 +677,7 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
     DeviceState *dev;
     MachineState *ms = MACHINE(vms);
     int irq = vms->irqmap[VIRT_ACPI_GED];
-    uint32_t event = ACPI_GED_PWR_DOWN_EVT;
+    uint32_t event = ACPI_GED_PWR_DOWN_EVT | ACPI_GED_ERROR_EVT;
 
     if (ms->ram_slots) {
         event |= ACPI_GED_MEM_HOTPLUG_EVT;
@@ -1009,6 +1009,13 @@ static void virt_powerdown_req(Notifier *n, void *opaque)
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
@@ -2385,6 +2392,9 @@ static void machvirt_init(MachineState *machine)
 
     if (has_ged && aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
         vms->acpi_dev = create_acpi_ged(vms);
+        vms->generic_error_notifier.notify = virt_generic_error_req;
+        notifier_list_add(&acpi_generic_error_notifiers,
+                          &vms->generic_error_notifier);
     } else {
         create_gpio_devices(vms, VIRT_GPIO, sysmem);
     }
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index d62d8d9db5ae..1c682d43fdac 100644
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
2.46.0


