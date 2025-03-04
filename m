Return-Path: <linux-kernel+bounces-544248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 939FAA4DF48
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FAB4188E86E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C98204683;
	Tue,  4 Mar 2025 13:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhrTaof2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4329C2036F6
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 13:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741095077; cv=none; b=TkykJSDG0zLvmxF0drGWzIdgn2Hwc1lKJ2FutX4CGTaobNSiGK83HftkN6R78C8+nwpfarGmiP8TOwfuHdJarNRFA0xVhgFu4JhKLQfq9gqcHjRCt9oUHUiM8+/gnEgBUSmOFF6TQAmYedKfyKgOexeG9PbYYvSXI3qCj/3kTDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741095077; c=relaxed/simple;
	bh=GST5qcNeRlg7u6y0ST05fcX+0FAmxCQwqPk5rZdMmvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gk/M3iBiGVXw4Y56nyQh8XVlpnHUd65M/CKXKz99CavED9SiYR5VQ9kiIvo/q9S6Kh2gW+gyxLjUkLuJcAjN1rE7UVZWvPoqhXzG0OrH3ofTnfA8S9uqzq13Xqyo110GkB58fd3KTRJC9C9iimSgecrSp8cmM68WpIyurCLuAzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhrTaof2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8055CC4CEE5;
	Tue,  4 Mar 2025 13:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741095076;
	bh=GST5qcNeRlg7u6y0ST05fcX+0FAmxCQwqPk5rZdMmvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mhrTaof2ZW8bzlwAkf9KYcy89ChGQ63SOkPhYVu/ouN5c7NMvCOvZsWs8VSUB4+JG
	 ck9U5LG/RkeNsdt+GrY1IDPrpUA5NrYcFrLiCBv0SWy22AC80B3bj51PjRK45ZrGmp
	 KiLhjfF9FTdt/jRl5VkqiqtM7+L2oZTQy/47QmvgTU1fLnVWrNKx1rk6Fh2KkXsTzk
	 mftqLLvSYZ+BTOlGzc5TZwZOpyWVqIqNEg/S5U/uwpsT7sw0Cv6ifSqn1OuiMRxheo
	 WDFpcC9AnmZAQcQe7UtQUc3ZQGFxWjsIBqzb7RRRcHHznrNxnifFGFnfOM0Wc7unVi
	 HSqxROUUjs6UA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tpSMc-00000005rnP-1tjP;
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
	Dongjiu Geng <gengdongjiu1@gmail.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Shannon Zhao <shannon.zhaosl@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 1/3] acpi/ghes: move use_hest_addr out of acpi_build_hest()
Date: Tue,  4 Mar 2025 14:30:56 +0100
Message-ID: <e1abcd0e1c5b66d91a7faed5b4147951c11b2e6d.1741094512.git.mchehab+huawei@kernel.org>
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

The only reason why we're passing ags to acpi HEST table build
is to check if migration will be used or not.

Well, we only need migration for arm, as other architectures
will only use the new code. So, move this out of acpi_build_hest(),
as otherwise we can't use it for x86, as the hotplug logic there
may not initialize ags during acpi table build time.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/ghes.c           | 16 ++++++++--------
 hw/arm/virt-acpi-build.c | 12 ++++++++----
 include/hw/acpi/ghes.h   | 25 +++++++++++++------------
 3 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 1fd5ba941771..ea00fed75c16 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -243,7 +243,7 @@ ghes_gen_err_data_uncorrectable_recoverable(GArray *block,
  * Initialize "etc/hardware_errors" and "etc/hardware_errors_addr" fw_cfg blobs.
  * See docs/specs/acpi_hest_ghes.rst for blobs format.
  */
-static void build_ghes_error_table(AcpiGhesState *ags, GArray *hardware_errors,
+static void build_ghes_error_table(GArray *hardware_errors, bool use_hest_addr,
                                    BIOSLinker *linker, int num_sources)
 {
     int i, error_status_block_offset;
@@ -289,7 +289,7 @@ static void build_ghes_error_table(AcpiGhesState *ags, GArray *hardware_errors,
                                        i * ACPI_GHES_MAX_RAW_DATA_LENGTH);
     }
 
-    if (!ags->use_hest_addr) {
+    if (!use_hest_addr) {
         /*
          * Tell firmware to write hardware_errors GPA into
          * hardware_errors_addr fw_cfg, once the former has been initialized.
@@ -372,7 +372,7 @@ static void build_ghes_v2_entry(GArray *table_data,
 }
 
 /* Build Hardware Error Source Table */
-void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
+void acpi_build_hest(GArray *table_data, bool use_hest_addr,
                      GArray *hardware_errors,
                      BIOSLinker *linker,
                      const AcpiNotificationSourceId *notif_source,
@@ -386,7 +386,7 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
 
     hest_offset = table_data->len;
 
-    build_ghes_error_table(ags, hardware_errors, linker, num_sources);
+    build_ghes_error_table(hardware_errors, use_hest_addr, linker, num_sources);
 
     acpi_table_begin(&table, table_data);
 
@@ -398,7 +398,7 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
 
     acpi_table_end(linker, &table);
 
-    if (ags->use_hest_addr) {
+    if (use_hest_addr) {
         /*
          * Tell firmware to write into GPA the address of HEST via fw_cfg,
          * once initialized.
@@ -411,13 +411,13 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
 }
 
 void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
-                          GArray *hardware_error)
+                          bool use_hest_addr, GArray *hardware_error)
 {
     /* Create a read-only fw_cfg file for GHES */
     fw_cfg_add_file(s, ACPI_HW_ERROR_FW_CFG_FILE, hardware_error->data,
                     hardware_error->len);
 
-    if (ags->use_hest_addr) {
+    if (use_hest_addr) {
         fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,
             NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);
     } else {
@@ -529,7 +529,7 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
         return;
     }
 
-    if (!ags->use_hest_addr) {
+    if (ags->hw_error_le) {
         get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
                              &cper_addr, &read_ack_register_addr);
     } else {
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 154337e1a77b..71da17b652b2 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -964,9 +964,11 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
         acpi_ged_state = ACPI_GED(vms->acpi_dev);
         ags = &acpi_ged_state->ghes_state;
         if (ags) {
+            bool use_hest_addr = ags->use_hest_addr;
+
             acpi_add_table(table_offsets, tables_blob);
 
-            if (!ags->use_hest_addr) {
+            if (!use_hest_addr) {
                 notify = hest_ghes_notify_9_2;
                 notify_sz = ARRAY_SIZE(hest_ghes_notify_9_2);
             } else {
@@ -974,7 +976,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
                 notify_sz = ARRAY_SIZE(hest_ghes_notify);
             }
 
-            acpi_build_hest(ags, tables_blob, tables->hardware_errors,
+            acpi_build_hest(tables_blob, use_hest_addr, tables->hardware_errors,
                             tables->linker, notify, notify_sz,
                             vms->oem_id, vms->oem_table_id);
         }
@@ -1143,8 +1145,10 @@ void virt_acpi_setup(VirtMachineState *vms)
     if (vms->ras) {
         assert(vms->acpi_dev);
         acpi_ged_state = ACPI_GED(vms->acpi_dev);
-        acpi_ghes_add_fw_cfg(&acpi_ged_state->ghes_state,
-                             vms->fw_cfg, tables.hardware_errors);
+        AcpiGhesState *ags = &acpi_ged_state->ghes_state;
+
+        acpi_ghes_add_fw_cfg(ags, vms->fw_cfg, ags->use_hest_addr,
+                             tables.hardware_errors);
     }
 
     build_state->rsdp_mr = acpi_add_rom_blob(virt_acpi_build_update,
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index df2ecbf6e4a9..eae6d4d0a562 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -73,31 +73,32 @@ typedef struct AcpiNotificationSourceId {
     enum AcpiGhesNotifyType notify;
 } AcpiNotificationSourceId;
 
-/*
- * AcpiGhesState stores GPA values that will be used to fill HEST entries.
+/**
+ * struct AcpiGhesState - GPA values that will be used to fill HEST entries
  *
- * When use_hest_addr is false, the GPA of the etc/hardware_errors firmware
- * is stored at hw_error_le. This is the default on QEMU 9.x.
+ * @hest_addr_le: GPA of the HEST table. Used on QEMU 10.x and above.
+ * @hw_error_le: GPA of the etc/hardware_errors firmware.
+ *               Used only on arm64 virt-9.x to preserve compatibility
+ *               with QEMU 9.x.
+ * @use_hest_addr: True if HEST address is present. Used only on arm64,
+ *                 to identify if QEMU 9.x migration is needed.
  *
- * When use_hest_addr is true, the GPA of the HEST table is stored at
- * hest_addr_le. This is the default for QEMU 10.x and above.
- *
- * Whe both GPA values are equal to zero means that GHES is not present.
+ * When both GPA values are equal to zero means that GHES is not present.
  */
 typedef struct AcpiGhesState {
     uint64_t hest_addr_le;
     uint64_t hw_error_le;
-    bool use_hest_addr; /* True if HEST address is present */
+    bool use_hest_addr;
 } AcpiGhesState;
 
-void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
+void acpi_build_hest(GArray *table_data, bool use_hest_addr,
                      GArray *hardware_errors,
                      BIOSLinker *linker,
                      const AcpiNotificationSourceId * const notif_source,
                      int num_sources,
                      const char *oem_id, const char *oem_table_id);
-void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
-                          GArray *hardware_errors);
+void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
+                          bool use_hest_addr, GArray *hardware_error);
 int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
                             uint64_t error_physical_addr);
 void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
-- 
2.48.1


