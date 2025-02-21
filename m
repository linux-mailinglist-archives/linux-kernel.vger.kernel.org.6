Return-Path: <linux-kernel+bounces-525917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F69A3F758
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F315C7AA5F2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A487C20FAA1;
	Fri, 21 Feb 2025 14:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkOg8kSC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011F2204C00
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740148536; cv=none; b=r4ZSWMRvbn1Y3QqnjunL1HOtqdIEqsPmRkOIK8FVgU9QXH1MVMzhX9m8atvbr1YkVfamvFXC7Ly+M3WjZbGhaS0t5wReZUIpfPU97S5rsbyp5Xj8lnu07SJuUX9PVTsW/REc+EXD8FXPayomUm/lssC3lfGphc41C0WoxPb9MWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740148536; c=relaxed/simple;
	bh=qAIVJ7bN6f2yBDwuU20QQ4WQc7s+du72Ms2RhFi8SIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZeFaBFQuuyL7ZqUYgdR4sj04MdTLbErK4+93l9myzV8jTaNdu4XQKnhbJrsQ64/Odo1bpdJ7gokKzCPAPb/IIlgqNEdI553hEL9veXri8PF20FihaZaVP96Sf5DBBpEtTRCtijtjqVUd8t8MOWhVqnGYD+s09TFZU3szzyKnmKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkOg8kSC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AFC7C4CEE8;
	Fri, 21 Feb 2025 14:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740148535;
	bh=qAIVJ7bN6f2yBDwuU20QQ4WQc7s+du72Ms2RhFi8SIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lkOg8kSCnIwbIr0OHwndKJQjdA3oGPDefOYuhwuJhckkIw5PRao9V400yRbNQ9rnG
	 /05D6Po+E46XLb4HwRjhqZG8g6wcV8mwjrxNzOxBV9iU4NNdqqnw4E6an2QnODoHF5
	 Mu9kE04uOBTtJWFVMmcBfr2Xtu8vM2jGBLmMtNG13MhBrT+PLcLCoQlrgSohb3eXrn
	 wM54NGi/W3TvgXzIvkUrRRlbvy7AbuEXgvk5kgxLhrvTnGae78U60olYmUnDsJGh9+
	 knfx5JwcjZOxihlnwy+WcDYAeuJLtbz8O2ZJyF7mQQqCIcJjGX1LPSExGPYX2y4UH1
	 tZKoegyLFMpUg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tlU7m-00000002jDf-2ZME;
	Fri, 21 Feb 2025 15:35:30 +0100
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/14] acpi/ghes: add a firmware file with HEST address
Date: Fri, 21 Feb 2025 15:35:11 +0100
Message-ID: <0866291724e8c276c5f7066991ce08250d7857d3.1740148260.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740148260.git.mchehab+huawei@kernel.org>
References: <cover.1740148260.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Store HEST table address at GPA, placing its the start of the table at
hest_addr_le variable.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/ghes.c         | 22 ++++++++++++++++++++--
 include/hw/acpi/ghes.h |  7 ++++++-
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index e49a03fdb94e..ba37be9e7022 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -30,6 +30,7 @@
 
 #define ACPI_HW_ERROR_FW_CFG_FILE           "etc/hardware_errors"
 #define ACPI_HW_ERROR_ADDR_FW_CFG_FILE      "etc/hardware_errors_addr"
+#define ACPI_HEST_ADDR_FW_CFG_FILE          "etc/acpi_table_hest_addr"
 
 /* The max size in bytes for one error block */
 #define ACPI_GHES_MAX_RAW_DATA_LENGTH   (1 * KiB)
@@ -341,6 +342,9 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
 {
     AcpiTable table = { .sig = "HEST", .rev = 1,
                         .oem_id = oem_id, .oem_table_id = oem_table_id };
+    uint32_t hest_offset;
+
+    hest_offset = table_data->len;
 
     build_ghes_error_table(ags, hardware_errors, linker);
 
@@ -352,6 +356,17 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
                   ACPI_GHES_NOTIFY_SEA, ACPI_HEST_SRC_ID_SEA);
 
     acpi_table_end(linker, &table);
+
+    if (ags->use_hest_addr) {
+        /*
+         * Tell firmware to write into GPA the address of HEST via fw_cfg,
+         * once initialized.
+         */
+        bios_linker_loader_write_pointer(linker,
+                                         ACPI_HEST_ADDR_FW_CFG_FILE, 0,
+                                         sizeof(uint64_t),
+                                         ACPI_BUILD_TABLE_FILE, hest_offset);
+    }
 }
 
 void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
@@ -361,7 +376,10 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
     fw_cfg_add_file(s, ACPI_HW_ERROR_FW_CFG_FILE, hardware_error->data,
                     hardware_error->len);
 
-    if (!ags->use_hest_addr) {
+    if (ags->use_hest_addr) {
+        fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,
+            NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);
+    } else {
         /* Create a read-write fw_cfg file for Address */
         fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
             NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
@@ -501,7 +519,7 @@ bool acpi_ghes_present(void)
         return false;
     }
     ags = &acpi_ged_state->ghes_state;
-    if (!ags->hw_error_le)
+    if (!ags->hw_error_le && !ags->hest_addr_le)
         return false;
 
     return true;
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index a3d62b96584f..454e97b5341c 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -71,9 +71,14 @@ enum {
  * meaning an offset from the etc/hardware_errors firmware address. This
  * is the default on QEMU 9.x.
  *
- * An offset value equal to zero means that GHES is not present.
+ * When use_hest_addr is true, the stored offset is placed at hest_addr_le,
+ * meaning an offset from theHEST table address from etc/acpi/tables firmware.
+ * This is the default for QEMU 10.x and above.
+ *
+ * If both offset values are equal to zero, it means that GHES is not present.
  */
 typedef struct AcpiGhesState {
+    uint64_t hest_addr_le;
     uint64_t hw_error_le;
     bool use_hest_addr;         /* Currently, always false */
 } AcpiGhesState;
-- 
2.48.1


