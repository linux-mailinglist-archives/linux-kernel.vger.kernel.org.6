Return-Path: <linux-kernel+bounces-279446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B8E94BD7C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1E69B2385F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBF618CC02;
	Thu,  8 Aug 2024 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWu9vQjE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250B5189BB6
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 12:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723120003; cv=none; b=t2aYs0VN0fNVBfaDdsBewFnPb/AcbeBDhXuzFpTKE7G4RWjfAs99w4fteM319sfq/fZJ2xHZklqeKLbOuz1vQDTUa+k/S6efslrW1mABlq/BOeV2QyffeZ0VfcNUUViagnPRotTiUKaxPGJp36f0J9z/SWGYspgZFzQdOOATRD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723120003; c=relaxed/simple;
	bh=+COdGK7bRLdFc3Xci68sxDJkHe3wEhoAcFT7ySCk4ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zeplcj7MapeiOR12MGljzvkUGPzQxrpXGgUf7IT2ISJeRwBrxon0xLJp7OkqSHBkxzjelBmgeNkz+ylO/B+C3ymjiLEoDmR88XA8qlFbwD02/MAtwxNu3HrDImpDtPcx4CKZsEqTU0RjqLRrjyte0pklxcCrVNu3Pl6nrsHqtfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWu9vQjE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93DFC4AF09;
	Thu,  8 Aug 2024 12:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723120002;
	bh=+COdGK7bRLdFc3Xci68sxDJkHe3wEhoAcFT7ySCk4ZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gWu9vQjEcTRVFLLmZpxD2QYzEkZJrbkYr9Ky9/wKv6R4cp5t1CBxkT4C5ZsCfhB6K
	 ZRyg+e8xqQKlkKXJVc+xZaoIh3jCd8BrkE/5Cr6H0sPzclPIEtbriVMZ74R8ENbWWz
	 eGhOwCJQlG9wohWC7GObp/87bFfRXSBPiNYJDPRs1+ieZjVSKn0OtNEUWVd+U0fI8X
	 y0QGQB/wMuy1HPqAFEr7krrs+RO6oQkDVtRXD12B44X10unsWB92AA/1yvx75tXyzW
	 fGchbqaVvOKX2fz+skrIn4BA74oV1p+R0E90Ysu2e0H9sg5oBLOIdqTVrqnQMRCjf2
	 iAY5eFiVQvSgA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1sc2E4-00000000oDC-3VKA;
	Thu, 08 Aug 2024 14:26:40 +0200
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
Subject: [PATCH v6 01/10] acpi/generic_event_device: add an APEI error device
Date: Thu,  8 Aug 2024 14:26:27 +0200
Message-ID: <f43b43fa2e80cbbecf6e47986d768029d531d29f.1723119423.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1723119423.git.mchehab+huawei@kernel.org>
References: <cover.1723119423.git.mchehab+huawei@kernel.org>
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
---
 hw/acpi/aml-build.c                    | 10 ++++++++++
 hw/acpi/generic_event_device.c         |  8 ++++++++
 include/hw/acpi/acpi_dev_interface.h   |  1 +
 include/hw/acpi/aml-build.h            |  2 ++
 include/hw/acpi/generic_event_device.h |  1 +
 5 files changed, 22 insertions(+)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 6d4517cfbe3d..cb167523859f 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -2520,3 +2520,13 @@ Aml *aml_i2c_serial_bus_device(uint16_t address, const char *resource_source)
 
     return var;
 }
+
+/* ACPI 5.0: 18.3.2.6.2 Event Notification For Generic Error Sources */
+Aml *aml_error_device(void)
+{
+    Aml *dev = aml_device(ACPI_APEI_ERROR_DEVICE);
+    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0C33")));
+    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
+
+    return dev;
+}
diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 15b4c3ebbf24..1673e9695be3 100644
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
@@ -295,6 +301,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
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
index a3784155cb33..44d1a6af0c69 100644
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
index 40af3550b56d..9ace8fe70328 100644
--- a/include/hw/acpi/generic_event_device.h
+++ b/include/hw/acpi/generic_event_device.h
@@ -98,6 +98,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
 #define ACPI_GED_PWR_DOWN_EVT      0x2
 #define ACPI_GED_NVDIMM_HOTPLUG_EVT 0x4
 #define ACPI_GED_CPU_HOTPLUG_EVT    0x8
+#define ACPI_GED_ERROR_EVT          0x10
 
 typedef struct GEDState {
     MemoryRegion evt;
-- 
2.45.2


