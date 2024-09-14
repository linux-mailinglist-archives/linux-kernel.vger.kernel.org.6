Return-Path: <linux-kernel+bounces-329171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A38DE978E4F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 08:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B55411C22D77
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 06:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9949717BEA5;
	Sat, 14 Sep 2024 06:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKjss2+b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD76877115
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 06:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726294434; cv=none; b=m/XGOYTfv6n4OpipR63qCAZ4GgVUcd5p5+WuhRUagLLKQeuW2Zvz6RXkqP3QfDMg0/uUmXSZlU/isYNiCckdi838ltXYCiBceRm8m2wv+aF3VT2/3vwyUEkEVvdyb8JndW7BUBqi8vL9+11vBVYxISijT8VWSdTqcrmCt+iQ9X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726294434; c=relaxed/simple;
	bh=VPED1MUiUBSfVtEJ06U9EQMoHhokkJihRfvfIUMl7Ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rbAIVFtgKvLNTr94QM5Koc3toj/Lkhc0ZEBfn8xpEg/pkmhgGVFVf+vOi6w1bghRSlUrX8NEz+xgLXdS0+jr3Cai1kveeFUDeUzZAZdkh3kpMbia7aodlIKtD7//VjBTzYtyJNqMWl7NxfLshHBPBdPWgISFwpGFYakigrI/4NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKjss2+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C1AC4CEDB;
	Sat, 14 Sep 2024 06:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726294434;
	bh=VPED1MUiUBSfVtEJ06U9EQMoHhokkJihRfvfIUMl7Ak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AKjss2+bQSv29AjGClOQ7yQKPV+0iUfRCKZvdBfuCUXvNlCvsEM2kGLHevGMMDFvw
	 a7hSEOe2u82SN7MbKwAqd9ZfvKm2sy2aB84M3ZMTZ7ScpLA8mCuJoVsUIfdUbgipCv
	 9QJXivZy0fPNOVlpypb2Ow7be09l6YrPtI04IRrtXqKWE0YGx+3nEg+s0O/E3YbSHo
	 21TlJS66rl6A3e9H9F+a0A5w9BPVuKrIJEIdWrIoWFJXeAM5lmcBrxITiDbwIpFSF1
	 tBhY415BeV30gg/QSVI+8UZtbfUVShCxhuH9BZGgxynXMCjGeAMwi/r/iFVOIazyHX
	 STBkcO2GCm34Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1spM2a-00000003V63-0pHS;
	Sat, 14 Sep 2024 08:13:52 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>,
	linux-kernel@vger.kernel.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v10 10/21] acpi/ghes: make the GHES record generation more generic
Date: Sat, 14 Sep 2024 08:13:31 +0200
Message-ID: <2530b364b179cc17f5d01f4dd2c8697671e31e2a.1726293808.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726293808.git.mchehab+huawei@kernel.org>
References: <cover.1726293808.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Split the code into separate functions to allow using the
common CPER filling code by different error sources.

The generic code was moved to ghes_record_cper_errors(),
and ghes_gen_err_data_uncorrectable_recoverable() now contains
only a logic to fill GEGB part of the record.

The remaining code to generate a memory error now belongs to
acpi_ghes_record_errors() function.

A further patch will give it a better name.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/ghes.c | 101 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 63 insertions(+), 38 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index c88717fb1bef..f54865423f69 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -199,51 +199,30 @@ static void acpi_ghes_build_append_mem_cper(GArray *table,
     build_append_int_noprefix(table, 0, 7);
 }
 
-static int acpi_ghes_record_mem_error(uint64_t error_block_address,
-                                      uint64_t error_physical_addr)
+static void
+ghes_gen_err_data_uncorrectable_recoverable(GArray *block,
+                                            const uint8_t *section_type,
+                                            int data_length)
 {
-    GArray *block;
-
-    /* Memory Error Section Type */
-    const uint8_t uefi_cper_mem_sec[] =
-          UUID_LE(0xA5BC1114, 0x6F64, 0x4EDE, 0xB8, 0x63, 0x3E, 0x83, \
-                  0xED, 0x7C, 0x83, 0xB1);
-
     /* invalid fru id: ACPI 4.0: 17.3.2.6.1 Generic Error Data,
      * Table 17-13 Generic Error Data Entry
      */
     QemuUUID fru_id = {};
-    uint32_t data_length;
 
-    block = g_array_new(false, true /* clear */, 1);
-
-    /* This is the length if adding a new generic error data entry*/
-    data_length = ACPI_GHES_DATA_LENGTH + ACPI_GHES_MEM_CPER_LENGTH;
     /*
-     * It should not run out of the preallocated memory if adding a new generic
-     * error data entry
+     * Calculate the size with this block. No need to check for
+     * too big CPER, as CPER size is checked at ghes_record_cper_errors()
      */
-    assert((data_length + ACPI_GHES_GESB_SIZE) <=
-            ACPI_GHES_MAX_RAW_DATA_LENGTH);
+    data_length += ACPI_GHES_GESB_SIZE;
 
     /* Build the new generic error status block header */
     acpi_ghes_generic_error_status(block, ACPI_GEBS_UNCORRECTABLE,
         0, 0, data_length, ACPI_CPER_SEV_RECOVERABLE);
 
     /* Build this new generic error data entry header */
-    acpi_ghes_generic_error_data(block, uefi_cper_mem_sec,
+    acpi_ghes_generic_error_data(block, section_type,
         ACPI_CPER_SEV_RECOVERABLE, 0, 0,
         ACPI_GHES_MEM_CPER_LENGTH, fru_id, 0);
-
-    /* Build the memory section CPER for above new generic error data entry */
-    acpi_ghes_build_append_mem_cper(block, error_physical_addr);
-
-    /* Write the generic error data entry into guest memory */
-    cpu_physical_memory_write(error_block_address, block->data, block->len);
-
-    g_array_free(block, true);
-
-    return 0;
 }
 
 /*
@@ -424,16 +403,22 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
     ags->present = true;
 }
 
-int acpi_ghes_record_errors(int source_id, uint64_t physical_address)
+void ghes_record_cper_errors(const void *cper, size_t len,
+                             uint16_t source_id, Error **errp)
 {
     uint64_t hest_read_ack_start_addr, read_ack_start_addr;
     uint64_t hest_addr, cper_addr, err_source_struct;
     uint64_t hest_err_block_addr, error_block_addr;
-    uint32_t num_sources, i, ret;
+    uint32_t num_sources, i;
     AcpiGedState *acpi_ged_state;
     AcpiGhesState *ags;
     uint64_t read_ack;
 
+    if (len > ACPI_GHES_MAX_RAW_DATA_LENGTH) {
+        error_setg(errp, "GHES CPER record is too big: %ld", len);
+        return;
+    }
+
     acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
                                                        NULL));
     g_assert(acpi_ged_state);
@@ -442,9 +427,6 @@ int acpi_ghes_record_errors(int source_id, uint64_t physical_address)
     hest_addr = le64_to_cpu(ags->hest_addr_le);
 
     cpu_physical_memory_read(hest_addr, &num_sources, sizeof(num_sources));
-    if (!physical_address) {
-        return -1;
-    }
 
     err_source_struct = hest_addr + sizeof(num_sources);
 
@@ -472,8 +454,8 @@ int acpi_ghes_record_errors(int source_id, uint64_t physical_address)
         err_source_struct += HEST_GHES_V2_TABLE_SIZE;
     }
     if (i == num_sources) {
-        error_report("HEST: Source %d not found.", source_id);
-        return -1;
+        error_setg(errp, "HEST: Source %d not found.", source_id);
+        return;
     }
 
     /* Navigate though table address pointers */
@@ -495,12 +477,55 @@ int acpi_ghes_record_errors(int source_id, uint64_t physical_address)
     cpu_physical_memory_read(read_ack_start_addr,
                              &read_ack, sizeof(read_ack));
 
+    /* zero means OSPM does not acknowledge the error */
+    if (!read_ack) {
+        error_setg(errp,
+                   "Last CPER record was not acknowledged yet");
+        return;
+    }
+
     read_ack = cpu_to_le64(0);
     cpu_physical_memory_write(read_ack_start_addr,
                               &read_ack, sizeof(read_ack));
 
-    ret = acpi_ghes_record_mem_error(error_block_addr, physical_address);
-    return ret;
+    /* Write the generic error data entry into guest memory */
+    cpu_physical_memory_write(cper_addr, cper, len);
+}
+
+int acpi_ghes_record_errors(int source_id, uint64_t physical_address)
+{
+    /* Memory Error Section Type */
+    const uint8_t guid[] =
+          UUID_LE(0xA5BC1114, 0x6F64, 0x4EDE, 0xB8, 0x63, 0x3E, 0x83, \
+                  0xED, 0x7C, 0x83, 0xB1);
+    Error *errp = NULL;
+    GArray *block;
+
+    if (!physical_address) {
+        error_report("can not find Generic Error Status Block for source id %d",
+                     source_id);
+        return -1;
+    }
+
+    block = g_array_new(false, true /* clear */, 1);
+
+    ghes_gen_err_data_uncorrectable_recoverable(block, guid,
+                                                ACPI_GHES_MAX_RAW_DATA_LENGTH);
+
+    /* Build the memory section CPER for above new generic error data entry */
+    acpi_ghes_build_append_mem_cper(block, physical_address);
+
+    /* Report the error */
+    ghes_record_cper_errors(block->data, block->len, source_id, &errp);
+
+    g_array_free(block, true);
+
+    if (errp) {
+        error_report_err(errp);
+        return -1;
+    }
+
+    return 0;
 }
 
 bool acpi_ghes_present(void)
-- 
2.46.0


