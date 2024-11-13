Return-Path: <linux-kernel+bounces-407242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 446339C6AA8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E2BA283165
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 08:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1778618C344;
	Wed, 13 Nov 2024 08:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPgju8VN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49A318A94C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 08:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731487058; cv=none; b=Vj7B0KrAwtAGYL25tqIA1FVJD2tUFwvOewcdCzrFJ0caQeJjBk4Hh9F3ixiqD1TJQ3sMMdRRn1yUYu9VQWqoTME3oMpPA+YN8OjcHIR+KvLef/S0tXO3pEHtlVylOCAurhr7nHARYmIzFhnFbNYXy0rxv8mq31Xm4/gTKHJw+4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731487058; c=relaxed/simple;
	bh=8qim0oXtsrKwoB2KDVZMyLso0M4oIrQlnS9SZWFYKkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b0G8w30Hof2W0mH4NYzaBDCfVFx9eTs4qubA2KzAh7nDUVRVWsA5X9tHY2vRuF32lMdbUf/1D/Ipujk7OL8jpolxTJLuMnCjaRagMV0j6J82kz/q5J5RQ79RFPAd1QRevbX1dI+v6fju7ZEVPAVwAN51gWJpofQ1R5jyXGEVSjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPgju8VN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59221C4AF09;
	Wed, 13 Nov 2024 08:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731487058;
	bh=8qim0oXtsrKwoB2KDVZMyLso0M4oIrQlnS9SZWFYKkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CPgju8VNDSvgnfyFzlFHosYG3OgKweljhKDybtP7tjmWHUGoN4SyFt2HHOd2LR3lo
	 StNu6oGLOnSKNJOkoHLSbAyl70zad0u6i0drhhFESMsI+xMCibVxutwSXXXtiyPCEv
	 Ist0f6XQPybEaDYys7OgNPUZhGoinu4ydXhwCpYV0KUFstJujT/jCDzL3Ko47fgr7+
	 1UnbMLTQXA7M1aie7X2O4sGWXInSLu3LqKtW07zqSTOMiJ9OSI6fXFLrjxortsyeUk
	 BXvCkhvFvCckbMvNDS9VGn+WPGqg3yv0warXdnqM3VjzmDbRqNtNCBvczGDEsjoc0S
	 w2WvanPkrm4Vg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tB8sZ-00000001KwA-3dKi;
	Wed, 13 Nov 2024 09:37:35 +0100
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
Subject: [PATCH 4/6] acpi/ghes: Use HEST table offsets when preparing GHES records
Date: Wed, 13 Nov 2024 09:37:01 +0100
Message-ID: <cf60aee0059d12755c1b9deb2dddb355d8543297.1731486604.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731486604.git.mchehab+huawei@kernel.org>
References: <cover.1731486604.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

There are two pointers that are needed during error injection:

1. The start address of the CPER block to be stored;
2. The address of the ack, which needs a reset before next error.

Calculate them preferrable from the HEST table, as this allows
checking the source ID, the size of the table and the type of
HEST error block structures.

Yet, keep the old code, as this is needed for migration purposes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/ghes.c | 98 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 88 insertions(+), 10 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index c93bbaf1994a..9ee25efe8abf 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -61,6 +61,23 @@
  */
 #define ACPI_GHES_GESB_SIZE                 20
 
+/*
+ * Offsets with regards to the start of the HEST table stored at
+ * ags->hest_addr_le, according with the memory layout map at
+ * docs/specs/acpi_hest_ghes.rst.
+ */
+
+/* ACPI 6.2: 18.3.2.8 Generic Hardware Error Source version 2
+ * Table 18-382 Generic Hardware Error Source version 2 (GHESv2) Structure
+ */
+#define HEST_GHES_V2_TABLE_SIZE  92
+#define GHES_ACK_OFFSET          (64 + GAS_ADDR_OFFSET)
+
+/* ACPI 6.2: 18.3.2.7: Generic Hardware Error Source
+ * Table 18-380: 'Error Status Address' field
+ */
+#define GHES_ERR_ST_ADDR_OFFSET  (20 + GAS_ADDR_OFFSET)
+
 /*
  * Values for error_severity field
  */
@@ -218,14 +235,6 @@ static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker,
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
@@ -425,6 +434,70 @@ static void get_hw_error_offsets(uint64_t ghes_addr,
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
+        /* It is GHES. Compare CPER source address */
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
+    cpu_physical_memory_read(error_block_addr, cper_addr,
+                             sizeof(*cper_addr));
+
+    cpu_physical_memory_read(hest_read_ack_addr, read_ack_start_addr,
+                             sizeof(*read_ack_start_addr));
+}
+
 void ghes_record_cper_errors(const void *cper, size_t len,
                              uint16_t source_id, Error **errp)
 {
@@ -445,8 +518,13 @@ void ghes_record_cper_errors(const void *cper, size_t len,
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
 
     cper_addr = le64_to_cpu(cper_addr);
     if (!cper_addr) {
-- 
2.47.0


