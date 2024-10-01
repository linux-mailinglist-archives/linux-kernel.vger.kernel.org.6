Return-Path: <linux-kernel+bounces-345812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 776DC98BB6F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31EF928203E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981591C174B;
	Tue,  1 Oct 2024 11:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVJlenmF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49B619AD48
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 11:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727782997; cv=none; b=OppId9zNsatcIQtdU13wFKvIAQhYbO9ErLquEEvWE6SlYVxb6S350Rnc+bQKH5zUCuf0qAzZXDsJuOLsN8X3jF/dwkfCcwm/AW5o6tPycWVkqSFNaLRZl67HYEE+xCrOS+Kb7Sisz7JFCm1eqN3a3CtB7OQjfYHo8LboCozOf3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727782997; c=relaxed/simple;
	bh=rH14cOwaAW34hdFT10uPKx79P1tpskTOouy7QlMnEpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z56u/h4Tgmdjk23+Zy8ab4upbDIeX6idI7GLuhU/InQG2Q4+UOSzQ6Gayrmpqm2KoIiLU2m9g3sgT4tVzzUL01V1OpBEV/HxBaFiCL+IOjbPNtNkLzh4pIrbjitzqbWm1PJjUn4mxEn5/qJG7puIMgRzgJAwfEf/7ySZwkDZPaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVJlenmF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D11C4CECD;
	Tue,  1 Oct 2024 11:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727782996;
	bh=rH14cOwaAW34hdFT10uPKx79P1tpskTOouy7QlMnEpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WVJlenmFs6EVd0AgpyhvOht9k9HhhS7vq7o5/Af2o172yDc9qUewyTji3gTDzewk7
	 nVAN1NmN8k1OeZa+ml17fdbnGUQM2jDICVvOXWAF8quQ75Nxq8GjSundoyO/O0haaI
	 yM7hAbnrCx7Z1GKzmVvWmzZi3meGXiHo0RV/wS67FWq+EKhdrOjtRq2lIcBcSUJ7M8
	 xJC+DzrhvuGHiieSrHG7FsPaOhN8SqfrQPKQexSFNb+2aa3hrLY2JLAWOdI2bpuXWR
	 eI+z8rkoZcne3+o46N6j4HlyaR5sK1YgrRLu01ijvJoZLB188lvlsuzFjxsrJL+rxg
	 Jsq1V8r+uTr4g==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1svbHd-0000000Adcv-3IYJ;
	Tue, 01 Oct 2024 13:43:13 +0200
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
Subject: [PATCH RFC 2/5] acpi/ghes: Use HEST table offsets when preparing GHES records
Date: Tue,  1 Oct 2024 13:42:47 +0200
Message-ID: <9eacb24e5e13b2028be90d19e936868a921f8e34.1727782588.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1727782588.git.mchehab+huawei@kernel.org>
References: <cover.1727782588.git.mchehab+huawei@kernel.org>
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
 hw/acpi/ghes.c | 93 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 83 insertions(+), 10 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 2c2cf444edeb..313a6e453af6 100644
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
@@ -425,6 +434,65 @@ static void get_ghes_offsets(uint64_t ghes_addr,
     *read_ack_register_addr = ghes_addr + sizeof(uint64_t);
 }
 
+static void get_hest_offsets(uint16_t source_id, uint64_t hest_addr,
+                             uint64_t *cper_addr,
+                             uint64_t *read_ack_start_addr,
+                              Error **errp)
+{
+    uint64_t hest_err_block_addr, hest_read_ack_start_addr;
+    uint64_t err_source_struct, error_block_addr;
+    uint32_t num_sources, i;
+
+    if (!hest_addr) {
+        return;
+    }
+
+    cpu_physical_memory_read(hest_addr, &num_sources, sizeof(num_sources));
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
+
+        /* For now, we only know the size of GHESv2 table */
+        assert(type == ACPI_GHES_SOURCE_GENERIC_ERROR_V2);
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
+    hest_read_ack_start_addr = err_source_struct + GHES_ACK_OFFSET;
+
+    cpu_physical_memory_read(hest_err_block_addr, &error_block_addr,
+                             sizeof(error_block_addr));
+
+    cpu_physical_memory_read(error_block_addr, cper_addr,
+                             sizeof(*cper_addr));
+
+    cpu_physical_memory_read(hest_read_ack_start_addr, read_ack_start_addr,
+                             sizeof(*read_ack_start_addr));
+}
+
 void ghes_record_cper_errors(const void *cper, size_t len,
                              uint16_t source_id, Error **errp)
 {
@@ -445,8 +513,13 @@ void ghes_record_cper_errors(const void *cper, size_t len,
     }
     ags = &acpi_ged_state->ghes_state;
 
-    get_ghes_offsets(le64_to_cpu(ags->hw_error_le),
-                     &cper_addr, &read_ack_register_addr);
+    if (!ags->hest_addr_le) {
+        get_ghes_offsets(le64_to_cpu(ags->hw_error_le),
+                         &cper_addr, &read_ack_register_addr);
+    } else {
+        get_hest_offsets(source_id, le64_to_cpu(ags->hest_addr_le),
+                         &cper_addr, &read_ack_register_addr, errp);
+    }
 
     if (!cper_addr) {
         error_setg(errp, "can not find Generic Error Status Block");
-- 
2.46.1


