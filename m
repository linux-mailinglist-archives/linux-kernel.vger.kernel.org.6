Return-Path: <linux-kernel+bounces-551817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8058A57155
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 20:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AEF0189AE71
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 19:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C632571B4;
	Fri,  7 Mar 2025 19:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvEZrWCS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8AC2512FF
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 19:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741374898; cv=none; b=qWnqApcXaAeDN9hDZxihVmkc3ucgGI2zvoT9jOqzd6hJxfDhLMdB69XvXs7uUS4v0HT3QBP3Rov4dZbB8FOB+vx83Fk7rZ2gt3K4JCYqB/w9rHSGmKrzVZP5oku6mbER+ljkqCu0ceSYjSyPP/ERYXRjNTUYEchBEb0ARWkUdnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741374898; c=relaxed/simple;
	bh=PXDuvGCw4Oy1Eis85V4fp5z4cmrG5FBbUSIdEJpjrRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OS6NZ/cDg40u1AGeF4EQBQbjE36SC/nOugXC0+xT3t8B5pDtyu1kcLy7tXkJ4O8lAYJ9Khi3AzdQRHia/BHnx8b1WY4ayAMepk/gXMgwJMABPXkfGEZhYNARQy2/niocHgUjvbPBQvWkIYyB+vrkJxHqzaKbpLnDgGhYiO0mM48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvEZrWCS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05FBC4CEF1;
	Fri,  7 Mar 2025 19:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741374897;
	bh=PXDuvGCw4Oy1Eis85V4fp5z4cmrG5FBbUSIdEJpjrRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nvEZrWCSRoFOnd6N/BsTOXW4bJW7+NWmORyrskuqmgATay9yeVUCxqVa+eXmzFRLP
	 hfWDJ8SDaAZM+RfOn+bJSbOVpzDto63WrU1dvCAXPy6rqRN9S9ALwXPiDoraHgOHOi
	 NH6Qcl9jUWBkUff5V02Evu25wem+MmJH7LAhSkdJfADIXiEAr4T0vszdOemjx6u68b
	 7GQx93YhoHVg+cJDYPQSvdQizq2GZjpj5sY0keSSshm6xxFS6xw854G5X365oR79Cn
	 AuLhRfkeeyOYc77U+X3PzueK9ZkHRYE2gNrLsXRXKbY+hFLYgO17p7hDlCxAZwSKcJ
	 8MWL3lKcTpyiA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tqd9r-0000000BQn7-44T1;
	Fri, 07 Mar 2025 20:14:55 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Gavin Shan" <gshan@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Ani Sinha <anisinha@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 13/20] acpi/generic_event_device: add an APEI error device
Date: Fri,  7 Mar 2025 20:14:42 +0100
Message-ID: <52a0315e234bcba0c8a355a6e8ada07fc6e2993a.1741374594.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741374594.git.mchehab+huawei@kernel.org>
References: <cover.1741374594.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Adds a generic error device to handle generic hardware error
events as specified at ACPI 6.5 specification at 18.3.2.7.2:
https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#event-notification-for-generic-error-sources
using HID PNP0C33.

The PNP0C33 device is used to report hardware errors to
the guest via ACPI APEI Generic Hardware Error Source (GHES).

Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/aml-build.c                    | 10 ++++++++++
 hw/acpi/generic_event_device.c         | 13 +++++++++++++
 include/hw/acpi/acpi_dev_interface.h   |  1 +
 include/hw/acpi/aml-build.h            |  2 ++
 include/hw/acpi/generic_event_device.h |  1 +
 5 files changed, 27 insertions(+)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index f8f93a9f66c8..e4bd7b611372 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -2614,3 +2614,13 @@ Aml *aml_i2c_serial_bus_device(uint16_t address, const char *resource_source)
 
     return var;
 }
+
+/* ACPI 5.0b: 18.3.2.6.2 Event Notification For Generic Error Sources */
+Aml *aml_error_device(void)
+{
+    Aml *dev = aml_device(ACPI_APEI_ERROR_DEVICE);
+    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0C33")));
+    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
+
+    return dev;
+}
diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 471d1a7afc76..f029753ab709 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -26,6 +26,7 @@ static const uint32_t ged_supported_events[] = {
     ACPI_GED_PWR_DOWN_EVT,
     ACPI_GED_NVDIMM_HOTPLUG_EVT,
     ACPI_GED_CPU_HOTPLUG_EVT,
+    ACPI_GED_ERROR_EVT,
 };
 
 /*
@@ -116,6 +117,16 @@ void build_ged_aml(Aml *table, const char *name, HotplugHandler *hotplug_dev,
                            aml_notify(aml_name(ACPI_POWER_BUTTON_DEVICE),
                                       aml_int(0x80)));
                 break;
+            case ACPI_GED_ERROR_EVT:
+                /*
+                 * ACPI 5.0b: 5.6.6 Device Object Notifications
+                 * Table 5-135 Error Device Notification Values
+                 * Defines 0x80 as the value to be used on notifications
+                 */
+                aml_append(if_ctx,
+                           aml_notify(aml_name(ACPI_APEI_ERROR_DEVICE),
+                                      aml_int(0x80)));
+                break;
             case ACPI_GED_NVDIMM_HOTPLUG_EVT:
                 aml_append(if_ctx,
                            aml_notify(aml_name("\\_SB.NVDR"),
@@ -295,6 +306,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
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
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index c18f68134246..f38e12971932 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -252,6 +252,7 @@ struct CrsRangeSet {
 /* Consumer/Producer */
 #define AML_SERIAL_BUS_FLAG_CONSUME_ONLY        (1 << 1)
 
+#define ACPI_APEI_ERROR_DEVICE   "GEDD"
 /**
  * init_aml_allocator:
  *
@@ -382,6 +383,7 @@ Aml *aml_dma(AmlDmaType typ, AmlDmaBusMaster bm, AmlTransferSize sz,
              uint8_t channel);
 Aml *aml_sleep(uint64_t msec);
 Aml *aml_i2c_serial_bus_device(uint16_t address, const char *resource_source);
+Aml *aml_error_device(void);
 
 /* Block AML object primitives */
 Aml *aml_scope(const char *name_format, ...) G_GNUC_PRINTF(1, 2);
diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
index d2dac87b4a9f..1c18ac296fcb 100644
--- a/include/hw/acpi/generic_event_device.h
+++ b/include/hw/acpi/generic_event_device.h
@@ -101,6 +101,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
 #define ACPI_GED_PWR_DOWN_EVT      0x2
 #define ACPI_GED_NVDIMM_HOTPLUG_EVT 0x4
 #define ACPI_GED_CPU_HOTPLUG_EVT    0x8
+#define ACPI_GED_ERROR_EVT          0x10
 
 typedef struct GEDState {
     MemoryRegion evt;
-- 
2.48.1


