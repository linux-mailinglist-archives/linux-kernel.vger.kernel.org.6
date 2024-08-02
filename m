Return-Path: <linux-kernel+bounces-273174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 582AA94653A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA78A1F22EEB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2962B139587;
	Fri,  2 Aug 2024 21:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZ2d+f2Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F4082486
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 21:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722635064; cv=none; b=aUiEplLVT11NfP15NPZYLJb+YBYGYMsK+WgGEAR3rfhbaFpI32AsWHL4DBU9xCDmJLGUs9d0xnZ+cvLEx+Ih2X/CGzXSobPBIl5sY2WUDLHA5XRTxSo73x6bgYx3zwHG52wuwi6M+yRIFBiEyvluQDwF4hd3VUPuFXvaFuPYn7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722635064; c=relaxed/simple;
	bh=tBLbaTxDMIbrJ1ZF80aRktOv/E8tCJykpKL5ilb5tVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vAaqnYf9M2llLePDSFvm6ahHTHa7dY7qraVDW5ZDUH1LuYSTYr/JrU3B0jNSTmqUr6fe7nZI40MbJ9LWt9ytHK4NnOgc694alx2/i/cg2LN07G3AZ9DVvf4Kq/hpx2VByE1EKbQYMQkn8oP2qSMZQM5J/5w62eV/dTfu4awtC4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZ2d+f2Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B696CC4AF0A;
	Fri,  2 Aug 2024 21:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722635063;
	bh=tBLbaTxDMIbrJ1ZF80aRktOv/E8tCJykpKL5ilb5tVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RZ2d+f2ZdBQH+uBVTT71p5zOXnZ3E3BKViG9mwQBIVz8IZ8uV8i/4I6m7ROwF7BTl
	 onKGwKUFPDKZ63VXS6oARY5bgE9J/zMh1kj/3LuGe+1I7vFLbQuyJR5tVveUMB3x9i
	 L4sZ/VCqdzbe4nKHsRaICWn8VGj4YAVX4f1CeJ/5w9swq3ERDvWK33W1f29u4yPgrI
	 HBc3vUk8j9Qiu0Fld8ZB8o+BHg3tTtM1Hoa4o+qL3J6gU7yRDHYicpfOG46EEfvuaJ
	 GUq/Zymlh3EtZDbMV+EMZVDxdMtDAAtd5Mc4zfWV4SfRHNz2xci8C/NviIxAvuExRz
	 aGgnj+k7dEAAA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1sa04T-00000002naX-3Ctt;
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
	linux-kernel@vger.kernel.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v5 6/7] acpi/ghes: add support for generic error injection via QAPI
Date: Fri,  2 Aug 2024 23:44:01 +0200
Message-ID: <20c491e357340e0062b6ff09867c1661ed4d2479.1722634602.git.mchehab+huawei@kernel.org>
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

Provide a generic interface for error injection via GHESv2.

This patch is co-authored:
    - original ghes logic to inject a simple ARM record by Shiju Jose;
    - generic logic to handle block addresses by Jonathan Cameron;
    - generic GHESv2 error inject by Mauro Carvalho Chehab;

Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Co-authored-by: Shiju Jose <shiju.jose@huawei.com>
Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/ghes.c         | 159 ++++++++++++++++++++++++++++++++++++++---
 hw/acpi/ghes_cper.c    |   2 +-
 include/hw/acpi/ghes.h |   3 +
 3 files changed, 152 insertions(+), 12 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index a745dcc7be5e..e125c9475773 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -395,23 +395,22 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
     ags->present = true;
 }
 
+static uint64_t ghes_get_state_start_address(void)
+{
+    AcpiGedState *acpi_ged_state =
+        ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED, NULL));
+    AcpiGhesState *ags = &acpi_ged_state->ghes_state;
+
+    return le64_to_cpu(ags->ghes_addr_le);
+}
+
 int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
 {
     uint64_t error_block_addr, read_ack_register_addr, read_ack_register = 0;
-    uint64_t start_addr;
+    uint64_t start_addr = ghes_get_state_start_address();
     bool ret = -1;
-    AcpiGedState *acpi_ged_state;
-    AcpiGhesState *ags;
-
     assert(source_id < ACPI_HEST_SRC_ID_RESERVED);
 
-    acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
-                                                       NULL));
-    g_assert(acpi_ged_state);
-    ags = &acpi_ged_state->ghes_state;
-
-    start_addr = le64_to_cpu(ags->ghes_addr_le);
-
     if (physical_address) {
         start_addr += source_id * sizeof(uint64_t);
 
@@ -448,9 +447,147 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
     return ret;
 }
 
+/*
+ * Error register block data layout
+ *
+ * | +---------------------+ ges.ghes_addr_le
+ * | |error_block_address0 |
+ * | +---------------------+
+ * | |error_block_address1 |
+ * | +---------------------+ --+--
+ * | |    .............    | GHES_ADDRESS_SIZE
+ * | +---------------------+ --+--
+ * | |error_block_addressN |
+ * | +---------------------+
+ * | | read_ack0           |
+ * | +---------------------+ --+--
+ * | | read_ack1           | GHES_ADDRESS_SIZE
+ * | +---------------------+ --+--
+ * | |   .............     |
+ * | +---------------------+
+ * | | read_ackN           |
+ * | +---------------------+ --+--
+ * | |      CPER           |   |
+ * | |      ....           | GHES_MAX_RAW_DATA_LENGT
+ * | |      CPER           |   |
+ * | +---------------------+ --+--
+ * | |    ..........       |
+ * | +---------------------+
+ * | |      CPER           |
+ * | |      ....           |
+ * | |      CPER           |
+ * | +---------------------+
+ */
+
+/* Map from uint32_t notify to entry offset in GHES */
+static const uint8_t error_source_to_index[] = { 0xff, 0xff, 0xff, 0xff,
+                                                 0xff, 0xff, 0xff, 1, 0};
+
+static bool ghes_get_addr(uint32_t notify, uint64_t *error_block_addr,
+                          uint64_t *read_ack_addr)
+{
+    uint64_t base;
+
+    if (notify >= ACPI_GHES_NOTIFY_RESERVED) {
+        return false;
+    }
+
+    /* Find and check the source id for this new CPER */
+    if (error_source_to_index[notify] == 0xff) {
+        return false;
+    }
+
+    base = ghes_get_state_start_address();
+
+    *read_ack_addr = base +
+        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
+        error_source_to_index[notify] * sizeof(uint64_t);
+
+    /* Could also be read back from the error_block_address register */
+    *error_block_addr = base +
+        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
+        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
+        error_source_to_index[notify] * ACPI_GHES_MAX_RAW_DATA_LENGTH;
+
+    return true;
+}
+
 NotifierList generic_error_notifiers =
     NOTIFIER_LIST_INITIALIZER(error_device_notifiers);
 
+void ghes_record_cper_errors(AcpiGhesCper *cper, Error **errp,
+                             uint32_t notify)
+{
+    int read_ack = 0;
+    uint32_t i;
+    uint64_t read_ack_addr = 0;
+    uint64_t error_block_addr = 0;
+    uint32_t data_length;
+    GArray *block;
+
+    if (!ghes_get_addr(notify, &error_block_addr, &read_ack_addr)) {
+        error_setg(errp, "GHES: Invalid error block/ack address(es)");
+        return;
+    }
+
+    cpu_physical_memory_read(read_ack_addr,
+                             &read_ack, sizeof(uint64_t));
+
+    /* zero means OSPM does not acknowledge the error */
+    if (!read_ack) {
+        error_setg(errp,
+                   "Last CPER record was not acknowledged yet");
+        read_ack = 1;
+        cpu_physical_memory_write(read_ack_addr,
+                                  &read_ack, sizeof(uint64_t));
+        return;
+    }
+
+    read_ack = cpu_to_le64(0);
+    cpu_physical_memory_write(read_ack_addr,
+                              &read_ack, sizeof(uint64_t));
+
+    /* Build CPER record */
+
+    /*
+     * Invalid fru id: ACPI 4.0: 17.3.2.6.1 Generic Error Data,
+     * Table 17-13 Generic Error Data Entry
+     */
+    QemuUUID fru_id = {};
+
+    block = g_array_new(false, true /* clear */, 1);
+    data_length = ACPI_GHES_DATA_LENGTH + cper->data_len;
+
+    /*
+        * It should not run out of the preallocated memory if
+        * adding a new generic error data entry
+        */
+    assert((data_length + ACPI_GHES_GESB_SIZE) <=
+            ACPI_GHES_MAX_RAW_DATA_LENGTH);
+
+    /* Build the new generic error status block header */
+    acpi_ghes_generic_error_status(block, ACPI_GEBS_UNCORRECTABLE,
+                                    0, 0, data_length,
+                                    ACPI_CPER_SEV_RECOVERABLE);
+
+    /* Build this new generic error data entry header */
+    acpi_ghes_generic_error_data(block, cper->guid,
+                                ACPI_CPER_SEV_RECOVERABLE, 0, 0,
+                                cper->data_len, fru_id, 0);
+
+    /* Add CPER data */
+    for (i = 0; i < cper->data_len; i++) {
+        build_append_int_noprefix(block, cper->data[i], 1);
+    }
+
+    /* Write the generic error data entry into guest memory */
+    cpu_physical_memory_write(error_block_addr, block->data, block->len);
+
+    g_array_free(block, true);
+
+    notifier_list_notify(&generic_error_notifiers, NULL);
+}
+
 bool acpi_ghes_present(void)
 {
     AcpiGedState *acpi_ged_state;
diff --git a/hw/acpi/ghes_cper.c b/hw/acpi/ghes_cper.c
index 7aa7e71e90dc..d7ff7debee74 100644
--- a/hw/acpi/ghes_cper.c
+++ b/hw/acpi/ghes_cper.c
@@ -39,7 +39,7 @@ void qmp_ghes_cper(CommonPlatformErrorRecord *qmp_cper,
         return;
     }
 
-    /* TODO: call a function at ghes */
+    ghes_record_cper_errors(&cper, errp, ACPI_GHES_NOTIFY_GPIO);
 
     g_free(cper.data);
 }
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 06a5b8820cd5..ee6f6cd96911 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -85,6 +85,9 @@ typedef struct AcpiGhesCper {
     size_t data_len;
 } AcpiGhesCper;
 
+void ghes_record_cper_errors(AcpiGhesCper *cper, Error **errp,
+                             uint32_t notify);
+
 /**
  * acpi_ghes_present: Report whether ACPI GHES table is present
  *
-- 
2.45.2


