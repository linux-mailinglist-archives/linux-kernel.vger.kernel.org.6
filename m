Return-Path: <linux-kernel+bounces-279452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B46CD94BD81
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D47BC1C21EF3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE21518FC9C;
	Thu,  8 Aug 2024 12:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmZcSBn2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B2E18C935
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723120003; cv=none; b=HEcqoD9smzUFkaiADHYP89wJczqvrBNrao3tPF3mdRcVKSm9URX1ys1EyYW7lA+1nPxE7sgthUb7/sCKjcdyiYKu4u6qVc9Cn0DyvdfEmgPgw4bQq09BAPj3ImmPzl6n4uNooZB0acsaCTcYMXY47V+spAFXGVQbHgIcDju78pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723120003; c=relaxed/simple;
	bh=GnvQcv8WtDyKfoMbqt9an3y4QcokslO3EGVw2j3GXwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jbqnMjGaME/oDNXCGpqSvDc7bSi84Xb4MJFSe6dpvsXisS7QWu3QGTGTQByLTc4/GoDfCwGK8gp6ikKVmrzCGMkYK8ALxDU+PUpH+10OvmqEUshcQ1rrB1jXeiAra662B5S0kIL89+SJ2xCX07LBVGAo/r8+nklavv6Xec2t6MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmZcSBn2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA95C4AF10;
	Thu,  8 Aug 2024 12:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723120003;
	bh=GnvQcv8WtDyKfoMbqt9an3y4QcokslO3EGVw2j3GXwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tmZcSBn2QCmG7nrANuBEmQrOSVQmp9Hw/CZX7FQzrNlVTSszu1UySX/E0mS6dqs9h
	 R/Q4R2Nfv/RcOwL8MLp/oEQiIGJct/5Vi3JZKpFJ32c76N9JLhlCHtDqI7BBg2jWJ+
	 e2/utlIPWCITyvc5cgZO7dhLI54YKZN2qO0wBRm3xzdjwhDnaxs/SE7b722x03MeYB
	 kX7xtFblA2025QyhK1GLrMQ3GGPjfUTr4BNsFohqgHZa82ZQgRrOUTggI/wH80AeLC
	 kHcjOgTE5tmJpZVXdvU1jUKVWqbDKS+pBUyS6AHxKqHGR5ga9MXm13g0uDbLRSOVAc
	 5qlFI5d3I6h4A==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1sc2E4-00000000oDS-3wyD;
	Thu, 08 Aug 2024 14:26:40 +0200
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
Subject: [PATCH v6 05/10] acpi/ghes: rework the logic to handle HEST source ID
Date: Thu,  8 Aug 2024 14:26:31 +0200
Message-ID: <5710c364d7ef6cdab6b2f1e127ef191bdf84e8c2.1723119423.git.mchehab+huawei@kernel.org>
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

The current logic is based on a lot of duct tape, with
offsets calculated based on one define with the number of
source IDs and an enum.

Rewrite the logic in a way that it would be more resilient
of code changes, by moving the source ID count to an enum
and make the offset calculus more explicit.

Such change was inspired on a patch from Jonathan Cameron
splitting the logic to get the CPER address on a separate
function, as this will be needed to support generic error
injection.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/ghes-stub.c    |   3 +-
 hw/acpi/ghes.c         | 225 ++++++++++++++++++++++++++++-------------
 include/hw/acpi/ghes.h |  12 +--
 3 files changed, 158 insertions(+), 82 deletions(-)

diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
index c315de1802d6..8762449870b5 100644
--- a/hw/acpi/ghes-stub.c
+++ b/hw/acpi/ghes-stub.c
@@ -11,7 +11,8 @@
 #include "qemu/osdep.h"
 #include "hw/acpi/ghes.h"
 
-int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
+int acpi_ghes_record_errors(enum AcpiGhesNotifyType notify,
+                            uint64_t physical_address)
 {
     return -1;
 }
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index d6cbeed6e3d5..26e93dd0f6e2 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -34,8 +34,16 @@
 /* The max size in bytes for one error block */
 #define ACPI_GHES_MAX_RAW_DATA_LENGTH   (1 * KiB)
 
-/* Support ARMv8 SEA notification type error source and GPIO interrupt. */
-#define ACPI_GHES_ERROR_SOURCE_COUNT        2
+/*
+ * ID numbers used to fill HEST source ID field
+ */
+enum AcpiHestSourceId {
+    ACPI_HEST_SRC_ID_SEA,
+    ACPI_HEST_SRC_ID_GED,
+
+    /* Shall be the last one */
+    ACPI_HEST_SRC_ID_COUNT
+} AcpiHestSourceId;
 
 /* Generic Hardware Error Source version 2 */
 #define ACPI_GHES_SOURCE_GENERIC_ERROR_V2   10
@@ -241,12 +249,12 @@ void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
     int i, error_status_block_offset;
 
     /* Build error_block_address */
-    for (i = 0; i < ACPI_GHES_ERROR_SOURCE_COUNT; i++) {
+    for (i = 0; i < ACPI_HEST_SRC_ID_COUNT; i++) {
         build_append_int_noprefix(hardware_errors, 0, sizeof(uint64_t));
     }
 
     /* Build read_ack_register */
-    for (i = 0; i < ACPI_GHES_ERROR_SOURCE_COUNT; i++) {
+    for (i = 0; i < ACPI_HEST_SRC_ID_COUNT; i++) {
         /*
          * Initialize the value of read_ack_register to 1, so GHES can be
          * writable after (re)boot.
@@ -261,13 +269,13 @@ void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
 
     /* Reserve space for Error Status Data Block */
     acpi_data_push(hardware_errors,
-        ACPI_GHES_MAX_RAW_DATA_LENGTH * ACPI_GHES_ERROR_SOURCE_COUNT);
+        ACPI_GHES_MAX_RAW_DATA_LENGTH * ACPI_HEST_SRC_ID_COUNT);
 
     /* Tell guest firmware to place hardware_errors blob into RAM */
     bios_linker_loader_alloc(linker, ACPI_GHES_ERRORS_FW_CFG_FILE,
                              hardware_errors, sizeof(uint64_t), false);
 
-    for (i = 0; i < ACPI_GHES_ERROR_SOURCE_COUNT; i++) {
+    for (i = 0; i < ACPI_HEST_SRC_ID_COUNT; i++) {
         /*
          * Tell firmware to patch error_block_address entries to point to
          * corresponding "Generic Error Status Block"
@@ -286,12 +294,95 @@ void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
         0, sizeof(uint64_t), ACPI_GHES_ERRORS_FW_CFG_FILE, 0);
 }
 
+static bool acpi_hest_address_offset(enum AcpiGhesNotifyType notify,
+                                     uint64_t *error_block_offset,
+                                     uint64_t *ack_offset,
+                                     uint64_t *cper_offset,
+                                     enum AcpiHestSourceId *source_id)
+{
+    enum AcpiHestSourceId source;
+    uint64_t offset;
+
+    switch (notify) {
+    case ACPI_GHES_NOTIFY_SEA:      /* Only on ARMv8 */
+        source = ACPI_HEST_SRC_ID_SEA;
+        break;
+    case ACPI_GHES_NOTIFY_GPIO:
+        source = ACPI_HEST_SRC_ID_GED;
+        break;
+    default:
+        return true;
+    }
+
+    if (source_id) {
+        *source_id = source;
+    }
+
+    /*
+     * Please see docs/specs/acpi_hest_ghes.rst for the memory layout.
+     * In summary, memory starts with error addresses, then acks and
+     * finally CPER blocks.
+     */
+
+    offset = source * sizeof(uint64_t);
+
+    if (error_block_offset) {
+        *error_block_offset = offset;
+    }
+    if (ack_offset) {
+        *ack_offset = offset + ACPI_HEST_SRC_ID_COUNT * sizeof(uint64_t);
+    }
+    if (cper_offset) {
+        *cper_offset = 2 * ACPI_HEST_SRC_ID_COUNT * sizeof(uint64_t) +
+                       source * ACPI_GHES_MAX_RAW_DATA_LENGTH;
+    }
+
+    return false;
+}
+
+static int ghes_get_hardware_errors_address(enum AcpiGhesNotifyType notify,
+                                            uint64_t *error_block_addr,
+                                            uint64_t *read_ack_addr,
+                                            uint64_t *cper_addr,
+                                            enum AcpiHestSourceId *source_id)
+{
+    AcpiGedState *acpi_ged_state =
+        ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED, NULL));
+    AcpiGhesState *ags = &acpi_ged_state->ghes_state;
+
+    if (acpi_hest_address_offset(notify, error_block_addr, read_ack_addr,
+                                 cper_addr, source_id)) {
+        return -1;
+    }
+
+    if (error_block_addr) {
+        *error_block_addr += le64_to_cpu(ags->ghes_addr_le);
+    }
+
+    if (read_ack_addr) {
+        *read_ack_addr += le64_to_cpu(ags->ghes_addr_le);
+    }
+
+    if (cper_addr) {
+        *cper_addr += le64_to_cpu(ags->ghes_addr_le);
+    }
+
+    return 0;
+}
+
 /* Build Generic Hardware Error Source version 2 (GHESv2) */
-static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
+static void build_ghes_v2(GArray *table_data,
+                          enum AcpiGhesNotifyType notify,
+                          BIOSLinker *linker)
 {
-    uint64_t address_offset;
+    uint64_t address_offset, ack_offset, block_addr_offset;
+    enum AcpiHestSourceId source_id;
 
-    assert(source_id < ACPI_HEST_SRC_ID_RESERVED);
+    if (acpi_hest_address_offset(notify, &block_addr_offset, &ack_offset,
+                                 NULL, &source_id)) {
+        error_report("Error: notify %d not supported", notify);
+        abort();
+    }
 
     /*
      * Type:
@@ -319,22 +410,21 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
     build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 0x40, 0,
                      4 /* QWord access */, 0);
     bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
-        address_offset + GAS_ADDR_OFFSET, sizeof(uint64_t),
-        ACPI_GHES_ERRORS_FW_CFG_FILE, source_id * sizeof(uint64_t));
+                                   address_offset + GAS_ADDR_OFFSET,
+                                   sizeof(uint64_t),
+                                   ACPI_GHES_ERRORS_FW_CFG_FILE,
+                                   block_addr_offset);
 
+    /* Notification Structure */
     switch (source_id) {
     case ACPI_HEST_SRC_ID_SEA:
-        /*
-         * Notification Structure
-         * Now only enable ARMv8 SEA notification type
-         */
         build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_SEA);
         break;
-    case ACPI_HEST_NOTIFY_EXTERNAL:
+    case ACPI_HEST_SRC_ID_GED:
         build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_GPIO);
         break;
     default:
-        error_report("Not support this error source");
+        error_report("Error: Source ID %d not supported", source_id);
         abort();
     }
 
@@ -350,9 +440,10 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
     build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 0x40, 0,
                      4 /* QWord access */, 0);
     bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
-        address_offset + GAS_ADDR_OFFSET,
-        sizeof(uint64_t), ACPI_GHES_ERRORS_FW_CFG_FILE,
-        (ACPI_GHES_ERROR_SOURCE_COUNT + source_id) * sizeof(uint64_t));
+                                   address_offset + GAS_ADDR_OFFSET,
+                                   sizeof(uint64_t),
+                                   ACPI_GHES_ERRORS_FW_CFG_FILE,
+                                   ack_offset);
 
     /*
      * Read Ack Preserve field
@@ -374,9 +465,9 @@ void acpi_build_hest(GArray *table_data, BIOSLinker *linker,
     acpi_table_begin(&table, table_data);
 
     /* Error Source Count */
-    build_append_int_noprefix(table_data, ACPI_GHES_ERROR_SOURCE_COUNT, 4);
-    build_ghes_v2(table_data, ACPI_HEST_SRC_ID_SEA, linker);
-    build_ghes_v2(table_data, ACPI_HEST_NOTIFY_EXTERNAL, linker);
+    build_append_int_noprefix(table_data, ACPI_HEST_SRC_ID_COUNT, 4);
+    build_ghes_v2(table_data, ACPI_GHES_NOTIFY_SEA, linker);
+    build_ghes_v2(table_data, ACPI_GHES_NOTIFY_GPIO, linker);
 
     acpi_table_end(linker, &table);
 }
@@ -395,56 +486,46 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
     ags->present = true;
 }
 
-int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
+int acpi_ghes_record_errors(enum AcpiGhesNotifyType notify,
+                            uint64_t physical_address)
 {
-    uint64_t error_block_addr, read_ack_register_addr, read_ack_register = 0;
-    uint64_t start_addr;
-    bool ret = -1;
-    AcpiGedState *acpi_ged_state;
-    AcpiGhesState *ags;
-
-    assert(source_id < ACPI_HEST_SRC_ID_RESERVED);
-
-    acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
-                                                       NULL));
-    g_assert(acpi_ged_state);
-    ags = &acpi_ged_state->ghes_state;
-
-    start_addr = le64_to_cpu(ags->ghes_addr_le);
-
-    if (physical_address) {
-        if (source_id < ACPI_HEST_SRC_ID_RESERVED) {
-            start_addr += source_id * sizeof(uint64_t);
-        }
-
-        cpu_physical_memory_read(start_addr, &error_block_addr,
-                                 sizeof(error_block_addr));
-
-        error_block_addr = le64_to_cpu(error_block_addr);
-
-        read_ack_register_addr = start_addr +
-            ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
-
-        cpu_physical_memory_read(read_ack_register_addr,
-                                 &read_ack_register, sizeof(read_ack_register));
-
-        /* zero means OSPM does not acknowledge the error */
-        if (!read_ack_register) {
-            error_report("OSPM does not acknowledge previous error,"
-                " so can not record CPER for current error anymore");
-        } else if (error_block_addr) {
-            read_ack_register = cpu_to_le64(0);
-            /*
-             * Clear the Read Ack Register, OSPM will write it to 1 when
-             * it acknowledges this error.
-             */
-            cpu_physical_memory_write(read_ack_register_addr,
-                &read_ack_register, sizeof(uint64_t));
-
-            ret = acpi_ghes_record_mem_error(error_block_addr,
-                                             physical_address);
-        } else
-            error_report("can not find Generic Error Status Block");
+    uint64_t error_block_addr, read_ack_register = 0;
+    uint64_t cper_addr, read_ack_start_addr;
+    int ret;
+
+    ret = ghes_get_hardware_errors_address(notify, NULL,
+                                           &read_ack_start_addr,
+                                           &cper_addr, NULL);
+
+    if (ret || !physical_address) {
+        error_report("can not find Generic Error Status Block for notify %d",
+                     notify);
+        return ret;
+    }
+
+    cpu_physical_memory_read(cper_addr, &error_block_addr,
+                             sizeof(error_block_addr));
+
+    error_block_addr = le64_to_cpu(error_block_addr);
+
+    cpu_physical_memory_read(read_ack_start_addr,
+                             &read_ack_register, sizeof(read_ack_register));
+
+    /* zero means OSPM does not acknowledge the error */
+    if (!read_ack_register) {
+        error_report("OSPM does not acknowledge previous error,"
+                     " so can not record CPER for current error anymore");
+    } else if (error_block_addr) {
+        read_ack_register = cpu_to_le64(0);
+        /*
+            * Clear the Read Ack Register, OSPM will write it to 1 when
+            * it acknowledges this error.
+            */
+        cpu_physical_memory_write(read_ack_start_addr,
+            &read_ack_register, sizeof(uint64_t));
+
+        ret = acpi_ghes_record_mem_error(error_block_addr,
+                                         physical_address);
     }
 
     return ret;
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index a7a18c7b50cf..2fcfa1cc8090 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -29,7 +29,7 @@
 extern NotifierList acpi_generic_error_notifiers;
 
 /*
- * Values for Hardware Error Notification Type field
+ * ACPI spec values for Hardware Error Notification Type field
  */
 enum AcpiGhesNotifyType {
     /* Polled */
@@ -60,13 +60,6 @@ enum AcpiGhesNotifyType {
     ACPI_GHES_NOTIFY_RESERVED = 12
 };
 
-/* Those are used as table indexes when building GHES tables */
-enum {
-    ACPI_HEST_SRC_ID_SEA = 0,
-    ACPI_HEST_NOTIFY_EXTERNAL,
-    ACPI_HEST_SRC_ID_RESERVED,
-};
-
 typedef struct AcpiGhesState {
     uint64_t ghes_addr_le;
     bool present; /* True if GHES is present at all on this board */
@@ -77,7 +70,8 @@ void acpi_build_hest(GArray *table_data, BIOSLinker *linker,
                      const char *oem_id, const char *oem_table_id);
 void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
                           GArray *hardware_errors);
-int acpi_ghes_record_errors(uint8_t notify, uint64_t error_physical_addr);
+int acpi_ghes_record_errors(enum AcpiGhesNotifyType notify,
+                            uint64_t error_physical_addr);
 
 typedef struct AcpiGhesCper {
     uint8_t *guid;
-- 
2.45.2


