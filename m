Return-Path: <linux-kernel+bounces-431575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CABB49E3FC5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 869B3B44EA2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208DE217F30;
	Wed,  4 Dec 2024 15:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkUIglKK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D0721767D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 15:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733327908; cv=none; b=mIKYukmIIHWIrCvOnjXO+kVu08kcY6cKM4I2PDiGVIqji5UAvPmAz+WGj0Sl9POckSbkmB8o6HYf0hnO8rr5uZM1DoH+jd3lQX7BhRD2dH17uzgt1eaZK+8W0bm9yEUoE+ALyPmrkmQtB7NTWPhsK7m1ZQj4Xdgw7qKvCeRRSyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733327908; c=relaxed/simple;
	bh=wJulQYESwlqAXPVkXZVUiU2AeJ1Jd49Tk06eYN+hXRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVwwMBPk/eRpXIQjzInluaz/ZYmwudP97co4tWXLu+9WGYqUn8NOgzpks7ed0H029/TeVoRs05KOlOlihkdVDzjdIQZiV9IdvCDKAOCX7dT9foyABWyXDOCogORlMNC9ujj5IlSdM7EOFWhr2B7EINDMmg4NbORPSIJCMMN33lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkUIglKK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9524C4CEE1;
	Wed,  4 Dec 2024 15:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733327908;
	bh=wJulQYESwlqAXPVkXZVUiU2AeJ1Jd49Tk06eYN+hXRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JkUIglKKiXtx7Dl4ww0Z6c7uxYOx35BXgKi5h1q86vnrAojzan5c4GdwzrnA6mKzu
	 axtZft3RprPfbkEx2NiS2L9sS4M/vNKoTjeWGSXEIez/VORyq8ZIJxaMMkdx+WCApu
	 Sx70UWIxeHtHtFNKwNrmyOUKf16cKQEAaAJQDXkXFs+YeSXfY7Qc6ePl8Dw5iOuPgt
	 EGrh6jDOERc7rEsMxyfI4550YJ6SnU10t33qJerpXWeuSJ1+R56pNyo/QRLYKz+FlM
	 6SNg1AIZ/bf6r1mieTdmmof3fofgq2hua1F4GGQOFV6MAIF0/uaal99HAbvcfmwlep
	 ehfThNly4jPjg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab@kernel.org>)
	id 1tIrlf-00000000HYy-3S8R;
	Wed, 04 Dec 2024 16:58:23 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>,
	linux-kernel@vger.kernel.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 3/5] acpi/ghes: Use HEST table offsets when preparing GHES records
Date: Wed,  4 Dec 2024 16:57:57 +0100
Message-ID: <b7ead99f3b19b63b9ee7c0672864dd7944c9c825.1733327276.git.mchehab+huawei@kernel.org>
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

There are two pointers that are needed during error injection:

1. The start address of the CPER block to be stored;
2. The address of the ack, which needs a reset before next error.

It is preferable to calculate them from the HEST table.  This allows
checking the source ID, the size of the table and the type of the
HEST error block structures.

Yet, keep the old code, as this is needed for migration purposes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/acpi/ghes.c | 106 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 96 insertions(+), 10 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 4a826c8ca6d4..af55bfe106bf 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -61,6 +61,25 @@
  */
 #define ACPI_GHES_GESB_SIZE                 20
 
+/*
+ * Offsets with regards to the start of the HEST table stored at
+ * ags->hest_addr_le, according with the memory layout map at
+ * docs/specs/acpi_hest_ghes.rst.
+ */
+
+/*
+ * ACPI 6.2: 18.3.2.8 Generic Hardware Error Source version 2
+ * Table 18-382 Generic Hardware Error Source version 2 (GHESv2) Structure
+ */
+#define HEST_GHES_V2_TABLE_SIZE  92
+#define GHES_ACK_OFFSET          (64 + GAS_ADDR_OFFSET)
+
+/*
+ * ACPI 6.2: 18.3.2.7: Generic Hardware Error Source
+ * Table 18-380: 'Error Status Address' field
+ */
+#define GHES_ERR_ST_ADDR_OFFSET  (20 + GAS_ADDR_OFFSET)
+
 /*
  * Values for error_severity field
  */
@@ -212,14 +231,6 @@ static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker,
 {
     int i, error_status_block_offset;
 
-    /*
-     * TODO: Current version supports only one source.
-     * A further patch will drop this check, after adding a proper migration
-     * code, as, for the code to work, we need to store a bios pointer to the
-     * HEST table.
-     */
-    assert(num_sources == 1);
-
     /* Build error_block_address */
     for (i = 0; i < num_sources; i++) {
         build_append_int_noprefix(hardware_errors, 0, sizeof(uint64_t));
@@ -419,6 +430,76 @@ static void get_hw_error_offsets(uint64_t ghes_addr,
     *read_ack_register_addr = ghes_addr + sizeof(uint64_t);
 }
 
+static void get_ghes_source_offsets(uint16_t source_id, uint64_t hest_addr,
+                                    uint64_t *cper_addr,
+                                    uint64_t *read_ack_start_addr,
+                                    Error **errp)
+{
+    uint64_t hest_err_block_addr, hest_read_ack_addr;
+    uint64_t err_source_struct, error_block_addr;
+    uint32_t num_sources, i;
+
+    if (!hest_addr) {
+        return;
+    }
+
+    cpu_physical_memory_read(hest_addr, &num_sources, sizeof(num_sources));
+    num_sources = le32_to_cpu(num_sources);
+
+    err_source_struct = hest_addr + sizeof(num_sources);
+
+    /*
+     * Currently, HEST Error source navigates only for GHESv2 tables
+     */
+
+    for (i = 0; i < num_sources; i++) {
+        uint64_t addr = err_source_struct;
+        uint16_t type, src_id;
+
+        cpu_physical_memory_read(addr, &type, sizeof(type));
+        type = le16_to_cpu(type);
+
+        /* For now, we only know the size of GHESv2 table */
+        if (type != ACPI_GHES_SOURCE_GENERIC_ERROR_V2) {
+            error_setg(errp, "HEST: type %d not supported.", type);
+            return;
+        }
+
+        /* Compare CPER source address at the GHESv2 structure */
+        addr += sizeof(type);
+        cpu_physical_memory_read(addr, &src_id, sizeof(src_id));
+
+        if (src_id == source_id) {
+            break;
+        }
+
+        err_source_struct += HEST_GHES_V2_TABLE_SIZE;
+    }
+    if (i == num_sources) {
+        error_setg(errp, "HEST: Source %d not found.", source_id);
+        return;
+    }
+
+    /* Navigate though table address pointers */
+    hest_err_block_addr = err_source_struct + GHES_ERR_ST_ADDR_OFFSET;
+    hest_read_ack_addr = err_source_struct + GHES_ACK_OFFSET;
+
+    cpu_physical_memory_read(hest_err_block_addr, &error_block_addr,
+                             sizeof(error_block_addr));
+
+    error_block_addr =  le64_to_cpu(error_block_addr);
+
+    cpu_physical_memory_read(error_block_addr, cper_addr,
+                             sizeof(*cper_addr));
+
+    *cper_addr = le64_to_cpu(*cper_addr);
+
+    cpu_physical_memory_read(hest_read_ack_addr, read_ack_start_addr,
+                             sizeof(*read_ack_start_addr));
+
+    *read_ack_start_addr = le64_to_cpu(*read_ack_start_addr);
+}
+
 void ghes_record_cper_errors(const void *cper, size_t len,
                              uint16_t source_id, Error **errp)
 {
@@ -439,8 +520,13 @@ void ghes_record_cper_errors(const void *cper, size_t len,
     }
     ags = &acpi_ged_state->ghes_state;
 
-    get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
-                         &cper_addr, &read_ack_register_addr);
+    if (!ags->hest_addr_le) {
+        get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
+                             &cper_addr, &read_ack_register_addr);
+    } else {
+        get_ghes_source_offsets(source_id, le64_to_cpu(ags->hest_addr_le),
+                                &cper_addr, &read_ack_register_addr, errp);
+    }
 
     if (!cper_addr) {
         error_setg(errp, "can not find Generic Error Status Block");
-- 
2.47.1


