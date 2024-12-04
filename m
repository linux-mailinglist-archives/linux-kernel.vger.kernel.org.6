Return-Path: <linux-kernel+bounces-431578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 572CB9E3F19
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DAA22854B3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACED218598;
	Wed,  4 Dec 2024 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQ7s23vs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DB5217F47
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 15:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733327909; cv=none; b=edWhY7utWuBPCx9KG1V/ydIj3yTkyNNV3+BNHwIrcaKKD+V7kI+tKWXnuso9dWSejMfiKQ+yRk0g/tzuKz2Z7/ZsXnePfjgcp8C+ykJjkvFe9dTeTz/QSPf6fwT8FOWRczNVdFlcjWOgpCYJvVEl6nltMGRSt8xTZacx/KhUGkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733327909; c=relaxed/simple;
	bh=zBOGmzobFvp2lIQ7+789CjkQz81YRefZttUO1zNdg+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZG0V2BJlNIH1lS8xBYZVt6MTnzbID0o2sEZvxG6mDenFL0NgjD3ATOjios+hLvEAW280IWGDqb0VPeiqeTUV9zPvcO/aO2/MBDTCgCuwzhBCn+LqrvEVS3foWyzK8nxBk844j823CuXjrsijvF0h8MZ4/xVYEcKQJPL5EJQJpQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQ7s23vs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5194C4CED1;
	Wed,  4 Dec 2024 15:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733327909;
	bh=zBOGmzobFvp2lIQ7+789CjkQz81YRefZttUO1zNdg+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZQ7s23vsCq4qd0zJln0Od3NDXrLifQWEp2NX3up0vvOpi/7Pg4Z1RP7WaLmpLhMkC
	 bAUL9RpYBDEI3531Mr/j9J8ntvxmrjMA4ogz75cnO5wdgcPh9XyltmfxvVgIC7s1XD
	 zxdyVPx6n3LUHojApHZYS5cUmocaqyEnzdDXEmkEkAqkuWfgLFDK/Zt57ZGD4HZf+M
	 ea1NmaHYrjOEiBFm8mSL4E1WPIOGrf9M+DpZL8Y+ErxeIGY8fNPGHtF01siKgkxUsK
	 eUTEprrUUm4OzSqpAYr9THu/v9DOV8Oe0gshygj3JkqURhjW9St3LmuNFHpQqF13yQ
	 +irUjZynfLykg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab@kernel.org>)
	id 1tIrlf-00000000HYs-3IUo;
	Wed, 04 Dec 2024 16:58:23 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Shannon Zhao <shannon.zhaosl@gmail.com>,
	linux-kernel@vger.kernel.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 1/5] acpi/ghes: Prepare to support multiple sources on ghes
Date: Wed,  4 Dec 2024 16:57:55 +0100
Message-ID: <dbf097af659968071c52fa08dfebcd1261750384.1733327276.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733327276.git.mchehab+huawei@kernel.org>
References: <cover.1733327276.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

The current code is actually dependent on having just one error
structure with a single source.

As the number of sources should be arch-dependent, as it will depend on
what kind of synchronous/assynchronous notifications will exist, change
the logic to dynamically build the table.

Yet, for a proper support, we need to get the number of sources by
reading the number from the HEST table. However, bios currently doesn't
store a pointer to it.

For now just change the logic at table build time, while enforcing that
it will behave like before with a single source ID.

A future patch will add a HEST table bios pointer and change the logic
at acpi_ghes_record_errors() to dynamically use the new size.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/acpi/ghes.c           | 43 ++++++++++++++++++++++++++--------------
 hw/arm/virt-acpi-build.c |  5 +++++
 include/hw/acpi/ghes.h   | 21 +++++++++++++-------
 3 files changed, 47 insertions(+), 22 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 5efa50413af3..b77e5c9d1b19 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -206,17 +206,26 @@ ghes_gen_err_data_uncorrectable_recoverable(GArray *block,
  * Initialize "etc/hardware_errors" and "etc/hardware_errors_addr" fw_cfg blobs.
  * See docs/specs/acpi_hest_ghes.rst for blobs format.
  */
-static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
+static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker,
+                                   int num_sources)
 {
     int i, error_status_block_offset;
 
+    /*
+     * TODO: Current version supports only one source.
+     * A further patch will drop this check, after adding a proper migration
+     * code, as, for the code to work, we need to store a bios pointer to the
+     * HEST table.
+     */
+    assert(num_sources == 1);
+
     /* Build error_block_address */
-    for (i = 0; i < ACPI_GHES_ERROR_SOURCE_COUNT; i++) {
+    for (i = 0; i < num_sources; i++) {
         build_append_int_noprefix(hardware_errors, 0, sizeof(uint64_t));
     }
 
     /* Build read_ack_register */
-    for (i = 0; i < ACPI_GHES_ERROR_SOURCE_COUNT; i++) {
+    for (i = 0; i < num_sources; i++) {
         /*
          * Initialize the value of read_ack_register to 1, so GHES can be
          * writable after (re)boot.
@@ -231,13 +240,13 @@ static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
 
     /* Reserve space for Error Status Data Block */
     acpi_data_push(hardware_errors,
-        ACPI_GHES_MAX_RAW_DATA_LENGTH * ACPI_GHES_ERROR_SOURCE_COUNT);
+        ACPI_GHES_MAX_RAW_DATA_LENGTH * num_sources);
 
     /* Tell guest firmware to place hardware_errors blob into RAM */
     bios_linker_loader_alloc(linker, ACPI_HW_ERROR_FW_CFG_FILE,
                              hardware_errors, sizeof(uint64_t), false);
 
-    for (i = 0; i < ACPI_GHES_ERROR_SOURCE_COUNT; i++) {
+    for (i = 0; i < num_sources; i++) {
         /*
          * Tell firmware to patch error_block_address entries to point to
          * corresponding "Generic Error Status Block"
@@ -263,10 +272,12 @@ static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
 /* Build Generic Hardware Error Source version 2 (GHESv2) */
 static void build_ghes_v2(GArray *table_data,
                           BIOSLinker *linker,
-                          enum AcpiGhesNotifyType notify,
-                          uint16_t source_id)
+                          const AcpiNotificationSourceId *notif_src,
+                          uint16_t index, int num_sources)
 {
     uint64_t address_offset;
+    const uint16_t notify = notif_src->notify;
+    const uint16_t source_id = notif_src->source_id;
 
     /*
      * Type:
@@ -297,7 +308,7 @@ static void build_ghes_v2(GArray *table_data,
                                    address_offset + GAS_ADDR_OFFSET,
                                    sizeof(uint64_t),
                                    ACPI_HW_ERROR_FW_CFG_FILE,
-                                   source_id * sizeof(uint64_t));
+                                   index * sizeof(uint64_t));
 
     /* Notification Structure */
     build_ghes_hw_error_notification(table_data, notify);
@@ -317,8 +328,7 @@ static void build_ghes_v2(GArray *table_data,
                                    address_offset + GAS_ADDR_OFFSET,
                                    sizeof(uint64_t),
                                    ACPI_HW_ERROR_FW_CFG_FILE,
-                                   (ACPI_GHES_ERROR_SOURCE_COUNT + source_id)
-                                   * sizeof(uint64_t));
+                                   (num_sources + index) * sizeof(uint64_t));
 
     /*
      * Read Ack Preserve field
@@ -333,19 +343,23 @@ static void build_ghes_v2(GArray *table_data,
 /* Build Hardware Error Source Table */
 void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
                      BIOSLinker *linker,
+                     const AcpiNotificationSourceId * const notif_source,
+                     int num_sources,
                      const char *oem_id, const char *oem_table_id)
 {
     AcpiTable table = { .sig = "HEST", .rev = 1,
                         .oem_id = oem_id, .oem_table_id = oem_table_id };
+    int i;
 
-    build_ghes_error_table(hardware_errors, linker);
+    build_ghes_error_table(hardware_errors, linker, num_sources);
 
     acpi_table_begin(&table, table_data);
 
     /* Error Source Count */
-    build_append_int_noprefix(table_data, ACPI_GHES_ERROR_SOURCE_COUNT, 4);
-    build_ghes_v2(table_data, linker,
-                  ACPI_GHES_NOTIFY_SEA, ACPI_HEST_SRC_ID_SEA);
+    build_append_int_noprefix(table_data, num_sources, 4);
+    for (i = 0; i < num_sources; i++) {
+        build_ghes_v2(table_data, linker, &notif_source[i], i, num_sources);
+    }
 
     acpi_table_end(linker, &table);
 }
@@ -410,7 +424,6 @@ void ghes_record_cper_errors(const void *cper, size_t len,
     }
     ags = &acpi_ged_state->ghes_state;
 
-    assert(ACPI_GHES_ERROR_SOURCE_COUNT == 1);
     get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
                          &cper_addr, &read_ack_register_addr);
 
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index e059317b002e..bd5582bc75f8 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -889,6 +889,10 @@ static void acpi_align_size(GArray *blob, unsigned align)
     g_array_set_size(blob, ROUND_UP(acpi_data_len(blob), align));
 }
 
+static const AcpiNotificationSourceId hest_ghes_notify[] = {
+    { ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA },
+};
+
 static
 void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
 {
@@ -944,6 +948,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     if (vms->ras) {
         acpi_add_table(table_offsets, tables_blob);
         acpi_build_hest(tables_blob, tables->hardware_errors, tables->linker,
+                        hest_ghes_notify, ARRAY_SIZE(hest_ghes_notify),
                         vms->oem_id, vms->oem_table_id);
     }
 
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 39619a2457cb..9f0120d0d596 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -57,20 +57,27 @@ enum AcpiGhesNotifyType {
     ACPI_GHES_NOTIFY_RESERVED = 12
 };
 
-enum {
-    ACPI_HEST_SRC_ID_SEA = 0,
-    /* future ids go here */
-
-    ACPI_GHES_ERROR_SOURCE_COUNT
-};
-
 typedef struct AcpiGhesState {
     uint64_t hw_error_le;
     bool present; /* True if GHES is present at all on this board */
 } AcpiGhesState;
 
+/*
+ * ID numbers used to fill HEST source ID field
+ */
+enum AcpiGhesSourceID {
+    ACPI_HEST_SRC_ID_SYNC,
+};
+
+typedef struct AcpiNotificationSourceId {
+    enum AcpiGhesSourceID source_id;
+    enum AcpiGhesNotifyType notify;
+} AcpiNotificationSourceId;
+
 void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
                      BIOSLinker *linker,
+                     const AcpiNotificationSourceId * const notif_source,
+                     int num_sources,
                      const char *oem_id, const char *oem_table_id);
 void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
                           GArray *hardware_errors);
-- 
2.47.1


