Return-Path: <linux-kernel+bounces-435391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB409E76FB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC9C02877E1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B2F21B193;
	Fri,  6 Dec 2024 17:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Az4PvQf5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26388203D50
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505688; cv=none; b=jCDQ80ebPOhGmLQZGYE/AkMbG7Wa44If+//Ggm/Y+StrNPvEekv/Rze+Sn/2GTXEMz+0kfY62YaMvIlXifi5jJ5Zvqyn/tIdYxtPI9N/xfqBAkRocZm5kQxrWpvEk0LaWzGKd4BCaoq5sBOPg29Jx3cYQjh85bliKpPOs1+ORGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505688; c=relaxed/simple;
	bh=er2E7uTLlujIsFePhTmXIu236pd9wB9P2GkaIjEE/Vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbe/P3BJdht9EE7ud8j1WXgXTrwu5se3nP1gu04ckh6G7tvi2BI3euYfhKr2d1ShZFBp+Nriq2BhFyzGue3IBJqpQKmlRW4noNZDJyZZYrrpKAJ82UQV7ssfPFuzgnoLC2sje9677cRtePtuN3tNbBe1Rsh6mXQ5F06uKus9DhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Az4PvQf5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA3CC4CEF1;
	Fri,  6 Dec 2024 17:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733505687;
	bh=er2E7uTLlujIsFePhTmXIu236pd9wB9P2GkaIjEE/Vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Az4PvQf5z6o4c4kCG/+EirRQhEa7/X4gsITbf3DX80llVBSpeo8T68D0FB5ldmGOr
	 hZ/LrmENNciDqSxQcs8B84G3FzGraY3iaezyQj62wLmjUJ8HVBYqh4RZgrMUlirt3/
	 D+eWLla2FB5a83FhdfZMvwOVy6FWy4HcS4XP9b7nztZxHri657txv7LSMTcsP4BcnL
	 T5iV7XTTc2Vj7BbBJpLpu+zubHf6qwFa0WFDlIYw1eALYO74LCEPpcxOYH96ZzXJSW
	 DoAXNH31GpF+D75wudtQB0QQFHgIQs4jpP9EVkwgurcUG+ILzCuqhwPPWFoDeKtqTM
	 bhjfmBBlna5tA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tJc17-00000005RKI-3L7S;
	Fri, 06 Dec 2024 18:21:25 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>,
	Igor Mammedov <imammedo@redhat.com>,
	linux-kernel@vger.kernel.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 12/31] acpi/ghes: rename etc/hardware_error file macros
Date: Fri,  6 Dec 2024 18:12:34 +0100
Message-ID: <cf5b3f343d35fa6477b5287d4263c4d3991bb8d4.1733504943.git.mchehab+huawei@kernel.org>
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

Now that we have also have a file to store HEST data location,
which is part of GHES, better name the file where CPER records
are stored.

No functional changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/acpi/ghes.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 2df5ddf68a13..52c2b69d3664 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -28,8 +28,8 @@
 #include "hw/nvram/fw_cfg.h"
 #include "qemu/uuid.h"
 
-#define ACPI_GHES_ERRORS_FW_CFG_FILE        "etc/hardware_errors"
-#define ACPI_GHES_DATA_ADDR_FW_CFG_FILE     "etc/hardware_errors_addr"
+#define ACPI_HW_ERROR_FW_CFG_FILE           "etc/hardware_errors"
+#define ACPI_HW_ERROR_ADDR_FW_CFG_FILE      "etc/hardware_errors_addr"
 
 /* The max size in bytes for one error block */
 #define ACPI_GHES_MAX_RAW_DATA_LENGTH   (1 * KiB)
@@ -234,7 +234,7 @@ static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
         ACPI_GHES_MAX_RAW_DATA_LENGTH * ACPI_GHES_ERROR_SOURCE_COUNT);
 
     /* Tell guest firmware to place hardware_errors blob into RAM */
-    bios_linker_loader_alloc(linker, ACPI_GHES_ERRORS_FW_CFG_FILE,
+    bios_linker_loader_alloc(linker, ACPI_HW_ERROR_FW_CFG_FILE,
                              hardware_errors, sizeof(uint64_t), false);
 
     for (i = 0; i < ACPI_GHES_ERROR_SOURCE_COUNT; i++) {
@@ -243,17 +243,21 @@ static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
          * corresponding "Generic Error Status Block"
          */
         bios_linker_loader_add_pointer(linker,
-            ACPI_GHES_ERRORS_FW_CFG_FILE, sizeof(uint64_t) * i,
-            sizeof(uint64_t), ACPI_GHES_ERRORS_FW_CFG_FILE,
-            error_status_block_offset + i * ACPI_GHES_MAX_RAW_DATA_LENGTH);
+                                       ACPI_HW_ERROR_FW_CFG_FILE,
+                                       sizeof(uint64_t) * i,
+                                       sizeof(uint64_t),
+                                       ACPI_HW_ERROR_FW_CFG_FILE,
+                                       error_status_block_offset +
+                                       i * ACPI_GHES_MAX_RAW_DATA_LENGTH);
     }
 
     /*
      * tell firmware to write hardware_errors GPA into
      * hardware_errors_addr fw_cfg, once the former has been initialized.
      */
-    bios_linker_loader_write_pointer(linker, ACPI_GHES_DATA_ADDR_FW_CFG_FILE,
-        0, sizeof(uint64_t), ACPI_GHES_ERRORS_FW_CFG_FILE, 0);
+    bios_linker_loader_write_pointer(linker, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, 0,
+                                     sizeof(uint64_t),
+                                     ACPI_HW_ERROR_FW_CFG_FILE, 0);
 }
 
 /* Build Generic Hardware Error Source version 2 (GHESv2) */
@@ -290,8 +294,10 @@ static void build_ghes_v2(GArray *table_data,
     build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 0x40, 0,
                      4 /* QWord access */, 0);
     bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
-        address_offset + GAS_ADDR_OFFSET, sizeof(uint64_t),
-        ACPI_GHES_ERRORS_FW_CFG_FILE, source_id * sizeof(uint64_t));
+                                   address_offset + GAS_ADDR_OFFSET,
+                                   sizeof(uint64_t),
+                                   ACPI_HW_ERROR_FW_CFG_FILE,
+                                   source_id * sizeof(uint64_t));
 
     /* Notification Structure */
     build_ghes_hw_error_notification(table_data, notify);
@@ -308,9 +314,11 @@ static void build_ghes_v2(GArray *table_data,
     build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 0x40, 0,
                      4 /* QWord access */, 0);
     bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
-        address_offset + GAS_ADDR_OFFSET,
-        sizeof(uint64_t), ACPI_GHES_ERRORS_FW_CFG_FILE,
-        (ACPI_GHES_ERROR_SOURCE_COUNT + source_id) * sizeof(uint64_t));
+                                   address_offset + GAS_ADDR_OFFSET,
+                                   sizeof(uint64_t),
+                                   ACPI_HW_ERROR_FW_CFG_FILE,
+                                   (ACPI_GHES_ERROR_SOURCE_COUNT + source_id)
+                                   * sizeof(uint64_t));
 
     /*
      * Read Ack Preserve field
@@ -346,11 +354,11 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
                           GArray *hardware_error)
 {
     /* Create a read-only fw_cfg file for GHES */
-    fw_cfg_add_file(s, ACPI_GHES_ERRORS_FW_CFG_FILE, hardware_error->data,
+    fw_cfg_add_file(s, ACPI_HW_ERROR_FW_CFG_FILE, hardware_error->data,
                     hardware_error->len);
 
     /* Create a read-write fw_cfg file for Address */
-    fw_cfg_add_file_callback(s, ACPI_GHES_DATA_ADDR_FW_CFG_FILE, NULL, NULL,
+    fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
         NULL, &(ags->ghes_addr_le), sizeof(ags->ghes_addr_le), false);
 
     ags->present = true;
-- 
2.47.1


