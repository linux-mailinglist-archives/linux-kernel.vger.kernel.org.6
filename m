Return-Path: <linux-kernel+bounces-540444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B10FA4B0A3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 09:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EB3F3B63D6
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD531EB18C;
	Sun,  2 Mar 2025 08:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTrVe8sR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED40D1D90AD
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 08:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740903738; cv=none; b=tZYQJbQP+8g4umLaFb/LaWa6dxvKBm4XfcqcW3jAombn3z2ETmWsKl5tPfa+VzlVRGk2/93dFsP6DTlvVKQL3GncRuGEab+o8mFVtoLR8BJyng/LGKd0czVvKm/QIAg84LPdWG2fPT9ME8ovswMosVvWUxI3D4wilM8BnXi0+Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740903738; c=relaxed/simple;
	bh=es2ETtVGYkpOdlK70E1R2FswCTa4mqr2cdRs3u11nog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R67vqFLwlnzwRrpeD/goJMAcFopjS2lCv9/N1Os0uERFKE0YX0HPfaQrvO5QRvbnCY4KG0+SWEJsatPtUFYRs4Gp7SLmyw080zcnQkwIJRX60gDF21Plau03BOExDAq3+A82BRD0Ga6uISQEg1kP84bOkAXjeyVWIhriCgCrlig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTrVe8sR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F29C4CEEB;
	Sun,  2 Mar 2025 08:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740903737;
	bh=es2ETtVGYkpOdlK70E1R2FswCTa4mqr2cdRs3u11nog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YTrVe8sRkEsXqE3xxogWUJBSsfCJRQ14rHWkCia/CWgAVThLG9DvAktWjcqZENdRD
	 0swRd19cnlm5Ffab9Mj9bLXZGbIRo8hQD3a67Noe0/DB/phNwZEZVA6UdaQm6rDwvk
	 Qn+2Q/Gd67Gw+5JcSVx6q0GgplupknQK3YOdjTdb8nfXS6g5A9mp3Lc6GVa3MM1yLf
	 KnuRM0DYVu8EtgidPinbkjH248600cLic1L/YLrxdhv6bXVxDUUW9lKq1+a8kGzXmd
	 PTwpoHs+qoRpdWZ/Y4hbACvjo/vcG/U/qIMEWQ7EqGduhYiKD0X7ujNiDxmY8QflsI
	 3MXqXWtsdIaYw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1toeaU-000000043S0-2qal;
	Sun, 02 Mar 2025 09:22:14 +0100
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
Subject: [PATCH v7 08/19] acpi/ghes: don't hard-code the number of sources for HEST table
Date: Sun,  2 Mar 2025 09:21:55 +0100
Message-ID: <315914fa4e0212d316231ea33939dd03626bf03b.1740903110.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740903110.git.mchehab+huawei@kernel.org>
References: <cover.1740903110.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The current code is actually dependent on having just one error
structure with a single source, as any change there would cause
migration issues.

As the number of sources should be arch-dependent, as it will depend on
what kind of notifications will exist, and how many errors can be
reported at the same time, change the logic to be more flexible,
allowing the number of sources to be defined when building the
HEST table by the caller.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/ghes.c           | 39 +++++++++++++++++++++------------------
 hw/arm/virt-acpi-build.c |  8 +++++++-
 include/hw/acpi/ghes.h   | 17 ++++++++++++-----
 3 files changed, 40 insertions(+), 24 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 668ca72587c7..f49d0d628fc4 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -238,17 +238,17 @@ ghes_gen_err_data_uncorrectable_recoverable(GArray *block,
  * See docs/specs/acpi_hest_ghes.rst for blobs format.
  */
 static void build_ghes_error_table(AcpiGhesState *ags, GArray *hardware_errors,
-                                   BIOSLinker *linker)
+                                   BIOSLinker *linker, int num_sources)
 {
     int i, error_status_block_offset;
 
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
@@ -263,13 +263,13 @@ static void build_ghes_error_table(AcpiGhesState *ags, GArray *hardware_errors,
 
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
@@ -295,12 +295,14 @@ static void build_ghes_error_table(AcpiGhesState *ags, GArray *hardware_errors,
 }
 
 /* Build Generic Hardware Error Source version 2 (GHESv2) */
-static void build_ghes_v2(GArray *table_data,
-                          BIOSLinker *linker,
-                          enum AcpiGhesNotifyType notify,
-                          uint16_t source_id)
+static void build_ghes_v2_entry(GArray *table_data,
+                                BIOSLinker *linker,
+                                const AcpiNotificationSourceId *notif_src,
+                                uint16_t index, int num_sources)
 {
     uint64_t address_offset;
+    const uint16_t notify = notif_src->notify;
+    const uint16_t source_id = notif_src->source_id;
 
     /*
      * Type:
@@ -331,7 +333,7 @@ static void build_ghes_v2(GArray *table_data,
                                    address_offset + GAS_ADDR_OFFSET,
                                    sizeof(uint64_t),
                                    ACPI_HW_ERROR_FW_CFG_FILE,
-                                   source_id * sizeof(uint64_t));
+                                   index * sizeof(uint64_t));
 
     /* Notification Structure */
     build_ghes_hw_error_notification(table_data, notify);
@@ -351,8 +353,7 @@ static void build_ghes_v2(GArray *table_data,
                                    address_offset + GAS_ADDR_OFFSET,
                                    sizeof(uint64_t),
                                    ACPI_HW_ERROR_FW_CFG_FILE,
-                                   (ACPI_GHES_ERROR_SOURCE_COUNT + source_id)
-                                   * sizeof(uint64_t));
+                                   (num_sources + index) * sizeof(uint64_t));
 
     /*
      * Read Ack Preserve field
@@ -368,22 +369,26 @@ static void build_ghes_v2(GArray *table_data,
 void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
                      GArray *hardware_errors,
                      BIOSLinker *linker,
+                     const AcpiNotificationSourceId *notif_source,
+                     int num_sources,
                      const char *oem_id, const char *oem_table_id)
 {
     AcpiTable table = { .sig = "HEST", .rev = 1,
                         .oem_id = oem_id, .oem_table_id = oem_table_id };
     uint32_t hest_offset;
+    int i;
 
     hest_offset = table_data->len;
 
-    build_ghes_error_table(ags, hardware_errors, linker);
+    build_ghes_error_table(ags, hardware_errors, linker, num_sources);
 
     acpi_table_begin(&table, table_data);
 
     /* Error Source Count */
-    build_append_int_noprefix(table_data, ACPI_GHES_ERROR_SOURCE_COUNT, 4);
-    build_ghes_v2(table_data, linker,
-                  ACPI_GHES_NOTIFY_SEA, ACPI_HEST_SRC_ID_SEA);
+    build_append_int_noprefix(table_data, num_sources, 4);
+    for (i = 0; i < num_sources; i++) {
+        build_ghes_v2_entry(table_data, linker, &notif_source[i], i, num_sources);
+    }
 
     acpi_table_end(linker, &table);
 
@@ -515,8 +520,6 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
         return;
     }
 
-    assert(ACPI_GHES_ERROR_SOURCE_COUNT == 1);
-
     if (!ags->use_hest_addr) {
         get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
                              &cper_addr, &read_ack_register_addr);
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 040d875d4e83..ea9682ee2662 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -893,6 +893,10 @@ static void acpi_align_size(GArray *blob, unsigned align)
     g_array_set_size(blob, ROUND_UP(acpi_data_len(blob), align));
 }
 
+static const AcpiNotificationSourceId hest_ghes_notify[] = {
+    { ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA },
+};
+
 static
 void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
 {
@@ -954,7 +958,9 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
         if (ags) {
             acpi_add_table(table_offsets, tables_blob);
             acpi_build_hest(ags, tables_blob, tables->hardware_errors,
-                            tables->linker, vms->oem_id, vms->oem_table_id);
+                            tables->linker, hest_ghes_notify,
+                            ARRAY_SIZE(hest_ghes_notify),
+                            vms->oem_id, vms->oem_table_id);
         }
     }
 
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 5265102ba51f..8c4b08433760 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -57,13 +57,18 @@ enum AcpiGhesNotifyType {
     ACPI_GHES_NOTIFY_RESERVED = 12
 };
 
-enum {
-    ACPI_HEST_SRC_ID_SEA = 0,
-    /* future ids go here */
-
-    ACPI_GHES_ERROR_SOURCE_COUNT
+/*
+ * ID numbers used to fill HEST source ID field
+ */
+enum AcpiGhesSourceID {
+    ACPI_HEST_SRC_ID_SYNC,
 };
 
+typedef struct AcpiNotificationSourceId {
+    enum AcpiGhesSourceID source_id;
+    enum AcpiGhesNotifyType notify;
+} AcpiNotificationSourceId;
+
 /*
  * AcpiGhesState stores GPA values that will be used to fill HEST entries.
  *
@@ -84,6 +89,8 @@ typedef struct AcpiGhesState {
 void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
                      GArray *hardware_errors,
                      BIOSLinker *linker,
+                     const AcpiNotificationSourceId * const notif_source,
+                     int num_sources,
                      const char *oem_id, const char *oem_table_id);
 void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
                           GArray *hardware_errors);
-- 
2.48.1


