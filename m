Return-Path: <linux-kernel+bounces-271449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BE2944E63
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F5F81F24143
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13961A99C8;
	Thu,  1 Aug 2024 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPCMjIXc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8F2198A10
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 14:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722523638; cv=none; b=TYAnNeu2mAiYRlIWjN/I90GukxX6e0Eug4RRXd/B6vcSnC1LPXAVGN+rpiWxWRmh1PV/GWa+DpukSuJKugIpG4QMjPh6adP6K8VpDo93RhkvpMUctWco3Jzg5XU6ZWd7bGPHzf8MBwuqhufFLK8k2LjyzILYvtovtsi+w+v0FDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722523638; c=relaxed/simple;
	bh=lzZeLSx62/9+XmtaXqmWuty+3/8CulkJ9V68HTTwfN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aTJlRIu+X4gQ1LzCqJHYMxwSkNx8twLY36GuRT9tr3t/ZnNvUirLDlIYSf75RZ/gG95XzlE5kgRhGQtDxPukycRO1Pu5npnEWbD8r9iZL8T0hU0e03SlbqOxnTqgp6+PFLrzxBsMXPanP2hZ7pkpGeEQ5eMYnMBP4ivkA5lmBek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPCMjIXc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0BBBC4AF10;
	Thu,  1 Aug 2024 14:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722523637;
	bh=lzZeLSx62/9+XmtaXqmWuty+3/8CulkJ9V68HTTwfN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sPCMjIXcb2OwUJTYSb60jP8op6LR36GR1okXTfhng4gUs8WsQ6JT0WSFtDrnC2Lgu
	 bmPfWnVwCSgthLK1wlUwqbr86FwGxw5Rb2gIE8t9OfDTrH9TkpnGmWzU4ASW58HM6q
	 zQnJkwRamVFeKa5OLJ1FflMnnjQwrVqDqlpYxZ4H2BO3QofouyOiwbm6kOgZOZyqO2
	 4wPMXay83InlmgxUAdOg3CGCD22X2Rd7yzFDYZGwDSmm6QnfUuYFWnmRPpEiAFWAJA
	 1hKV7JZLB1yRx/sE2yFFZCnD3R0CCOv/aQDMoeo2PDFp5cm4tKcETQUjJp7LTMaF+H
	 G3/R4RWy6wwgw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1sZX5H-00000001WCW-2vaH;
	Thu, 01 Aug 2024 16:47:15 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>,
	linux-kernel@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: [PATCH v4 2/7] acpi/generic_event_device: add an APEI error device
Date: Thu,  1 Aug 2024 16:47:05 +0200
Message-ID: <dcb985466bdecced64e6fddde5969e9cc0a17432.1722523312.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722523312.git.mchehab+huawei@kernel.org>
References: <cover.1722523312.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Adds a Generic Event Device to handle generic hardware error
events, supporting General Purpose Event (GPE) as specified at
ACPI 6.5 specification at 18.3.2.7.2:
https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#event-notification-for-generic-error-sources
using HID PNP0C33.

The PNP0C33 device is used to report hardware errors to
the bios via ACPI APEI Generic Hardware Error Source (GHES).

Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/generic_event_device.c         | 17 +++++++++++++++++
 include/hw/acpi/acpi_dev_interface.h   |  1 +
 include/hw/acpi/generic_event_device.h |  3 +++
 3 files changed, 21 insertions(+)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 15b4c3ebbf24..b9ad05e98c05 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -26,6 +26,7 @@ static const uint32_t ged_supported_events[] = {
     ACPI_GED_PWR_DOWN_EVT,
     ACPI_GED_NVDIMM_HOTPLUG_EVT,
     ACPI_GED_CPU_HOTPLUG_EVT,
+    ACPI_GED_ERROR_EVT
 };
 
 /*
@@ -116,6 +117,11 @@ void build_ged_aml(Aml *table, const char *name, HotplugHandler *hotplug_dev,
                            aml_notify(aml_name(ACPI_POWER_BUTTON_DEVICE),
                                       aml_int(0x80)));
                 break;
+            case ACPI_GED_ERROR_EVT:
+                aml_append(if_ctx,
+                           aml_notify(aml_name(ACPI_APEI_ERROR_DEVICE),
+                                      aml_int(0x80)));
+                break;
             case ACPI_GED_NVDIMM_HOTPLUG_EVT:
                 aml_append(if_ctx,
                            aml_notify(aml_name("\\_SB.NVDR"),
@@ -153,6 +159,15 @@ void acpi_dsdt_add_power_button(Aml *scope)
     aml_append(scope, dev);
 }
 
+void acpi_dsdt_add_error_device(Aml *scope)
+{
+    Aml *dev = aml_device(ACPI_APEI_ERROR_DEVICE);
+    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0C33")));
+    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
+    aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
+    aml_append(scope, dev);
+}
+
 /* Memory read by the GED _EVT AML dynamic method */
 static uint64_t ged_evt_read(void *opaque, hwaddr addr, unsigned size)
 {
@@ -295,6 +310,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
         sel = ACPI_GED_MEM_HOTPLUG_EVT;
     } else if (ev & ACPI_POWER_DOWN_STATUS) {
         sel = ACPI_GED_PWR_DOWN_EVT;
+    } else if (ev & ACPI_GENERIC_ERROR) {
+        sel = ACPI_GED_ERROR_EVT;
     } else if (ev & ACPI_NVDIMM_HOTPLUG_STATUS) {
         sel = ACPI_GED_NVDIMM_HOTPLUG_EVT;
     } else if (ev & ACPI_CPU_HOTPLUG_STATUS) {
diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
index 68d9d15f50aa..8294f8f0ccca 100644
--- a/include/hw/acpi/acpi_dev_interface.h
+++ b/include/hw/acpi/acpi_dev_interface.h
@@ -13,6 +13,7 @@ typedef enum {
     ACPI_NVDIMM_HOTPLUG_STATUS = 16,
     ACPI_VMGENID_CHANGE_STATUS = 32,
     ACPI_POWER_DOWN_STATUS = 64,
+    ACPI_GENERIC_ERROR = 128,
 } AcpiEventStatusBits;
 
 #define TYPE_ACPI_DEVICE_IF "acpi-device-interface"
diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
index 40af3550b56d..b8f2f1328e0c 100644
--- a/include/hw/acpi/generic_event_device.h
+++ b/include/hw/acpi/generic_event_device.h
@@ -66,6 +66,7 @@
 #include "qom/object.h"
 
 #define ACPI_POWER_BUTTON_DEVICE "PWRB"
+#define ACPI_APEI_ERROR_DEVICE   "GEDD"
 
 #define TYPE_ACPI_GED "acpi-ged"
 OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
@@ -98,6 +99,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
 #define ACPI_GED_PWR_DOWN_EVT      0x2
 #define ACPI_GED_NVDIMM_HOTPLUG_EVT 0x4
 #define ACPI_GED_CPU_HOTPLUG_EVT    0x8
+#define ACPI_GED_ERROR_EVT          0x10
 
 typedef struct GEDState {
     MemoryRegion evt;
@@ -120,5 +122,6 @@ struct AcpiGedState {
 void build_ged_aml(Aml *table, const char* name, HotplugHandler *hotplug_dev,
                    uint32_t ged_irq, AmlRegionSpace rs, hwaddr ged_base);
 void acpi_dsdt_add_power_button(Aml *scope);
+void acpi_dsdt_add_error_device(Aml *scope);
 
 #endif
-- 
2.45.2


