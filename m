Return-Path: <linux-kernel+bounces-525925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D735BA3F75E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDB1E16D6DB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B2A214217;
	Fri, 21 Feb 2025 14:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrI9m+TE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74817210198
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740148536; cv=none; b=Cgstg5aAUp500pZCvIX7mnvF3mPWYW/i4KW0xof9GVg1QcDBMEhdWARKdsPx9C4AmiHVSyq5p3GrRDed4uZKtEPTz3o9VXNeuT6+DzIPMdUU7viCNTbh6W8FjD2xBU3LQNo14+3S4obVzl5g9qPiFVfp1EfHzmQDI1XRmGnQIMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740148536; c=relaxed/simple;
	bh=f3jsJF20lQ2fLkUgkIm1tbMfMYZ0iu0p9OeKwi8Wtyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JrkfgbWzVHiZB6wyANjmjW9DZtAu+OMFS5FEQ85t8cnH+74/khRcmt9WAM+bKf4MtBDd3OlRp1hfS6TGB18BerokqB+Xx/6xonR1hxW1iCtAKnjaykpGo0tvqr5M7XbV2pujVFNuhesZTYS4LHjhLsbiLjQNvNE5/93QljfhHhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrI9m+TE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21E9C4CEED;
	Fri, 21 Feb 2025 14:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740148535;
	bh=f3jsJF20lQ2fLkUgkIm1tbMfMYZ0iu0p9OeKwi8Wtyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HrI9m+TEfowBNw0dp5QT4rRRbxPi/Byv9idDnXLSdLUGyKRJVIJbz2+rPm0hMpHBX
	 3mDeIueWba/n4P9D1VG2Z5M73u2Pex0ATiFFcdEUpykmLCjK0EqUFk3bdYB9D6EbBE
	 7yES/GEN3fb+PnPQ8tPN9l16R2jp+sRJGZo0iaQ8CQeSfzwP8A4C2MyLEGqwB+V8qB
	 LLwwJMrMv60r6O2apLY0kpw6pV/6hc9v2itdbDO2TYjIvw4upy3Mh/q/7cfkRrB4gs
	 gY8sVCB1fcafz7QG1Qnngz2vnuJIqS3L+fACS6dMjunJLQe0FvyFmxdFqoRyCMUzYc
	 onYSpHFQVBy8w==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tlU7m-00000002jDj-2gTs;
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
Subject: [PATCH v4 03/14] acpi/ghes: Use HEST table offsets when preparing GHES records
Date: Fri, 21 Feb 2025 15:35:12 +0100
Message-ID: <0134424ddba15dea8daaf32b09e89f1bf7e81552.1740148260.git.mchehab+huawei@kernel.org>
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

There are two pointers that are needed during error injection:

1. The start address of the CPER block to be stored;
2. The address of the ack.

It is preferable to calculate them from the HEST table.  This allows
checking the source ID, the size of the table and the type of the
HEST error block structures.

Yet, keep the old code, as this is needed for migration purposes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/acpi/ghes.c         | 100 +++++++++++++++++++++++++++++++++++++++++
 include/hw/acpi/ghes.h |   2 +-
 2 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index ba37be9e7022..7efea519f766 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -41,6 +41,12 @@
 /* Address offset in Generic Address Structure(GAS) */
 #define GAS_ADDR_OFFSET 4
 
+/*
+ * ACPI spec 1.0b
+ * 5.2.3 System Description Table Header
+ */
+#define ACPI_DESC_HEADER_OFFSET     36
+
 /*
  * The total size of Generic Error Data Entry
  * ACPI 6.1/6.2: 18.3.2.7.1 Generic Error Data,
@@ -61,6 +67,30 @@
  */
 #define ACPI_GHES_GESB_SIZE                 20
 
+/*
+ * See the memory layout map at docs/specs/acpi_hest_ghes.rst.
+ */
+
+/*
+ * ACPI 6.1: 18.3.2.8 Generic Hardware Error Source version 2
+ * Table 18-344 Generic Hardware Error Source version 2 (GHESv2) Structure
+ */
+#define HEST_GHES_V2_ENTRY_SIZE  92
+
+/*
+ * ACPI 6.1: 18.3.2.7: Generic Hardware Error Source
+ * Table 18-344 Generic Hardware Error Source version 2 (GHESv2) Structure
+ * Read Ack Register
+ */
+#define GHES_READ_ACK_ADDR_OFF          64
+
+/*
+ * ACPI 6.1: 18.3.2.7: Generic Hardware Error Source
+ * Table 18-341 Generic Hardware Error Source Structure
+ * Error Status Address
+ */
+#define GHES_ERR_STATUS_ADDR_OFF  20
+
 /*
  * Values for error_severity field
  */
@@ -412,6 +442,73 @@ static void get_hw_error_offsets(uint64_t ghes_addr,
     *read_ack_register_addr = ghes_addr + sizeof(uint64_t);
 }
 
+static void get_ghes_source_offsets(uint16_t source_id,
+                                    uint64_t hest_addr,
+                                    uint64_t *cper_addr,
+                                    uint64_t *read_ack_start_addr,
+                                    Error **errp)
+{
+    uint64_t hest_err_block_addr, hest_read_ack_addr;
+    uint64_t err_source_entry, error_block_addr;
+    uint32_t num_sources, i;
+
+    hest_addr += ACPI_DESC_HEADER_OFFSET;
+
+    cpu_physical_memory_read(hest_addr, &num_sources,
+                             sizeof(num_sources));
+    num_sources = le32_to_cpu(num_sources);
+
+    err_source_entry = hest_addr + sizeof(num_sources);
+
+    /*
+     * Currently, HEST Error source navigates only for GHESv2 tables
+     */
+    for (i = 0; i < num_sources; i++) {
+        uint64_t addr = err_source_entry;
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
+        if (le16_to_cpu(src_id) == source_id) {
+            break;
+        }
+
+        err_source_entry += HEST_GHES_V2_ENTRY_SIZE;
+    }
+    if (i == num_sources) {
+        error_setg(errp, "HEST: Source %d not found.", source_id);
+        return;
+    }
+
+    /* Navigate though table address pointers */
+    hest_err_block_addr = err_source_entry + GHES_ERR_STATUS_ADDR_OFF +
+                          GAS_ADDR_OFFSET;
+
+    cpu_physical_memory_read(hest_err_block_addr, &error_block_addr,
+                             sizeof(error_block_addr));
+    error_block_addr = le64_to_cpu(error_block_addr);
+
+    cpu_physical_memory_read(error_block_addr, cper_addr,
+                             sizeof(*cper_addr));
+    *cper_addr = le64_to_cpu(*cper_addr);
+
+    hest_read_ack_addr = err_source_entry + GHES_READ_ACK_ADDR_OFF +
+                         GAS_ADDR_OFFSET;
+    cpu_physical_memory_read(hest_read_ack_addr, read_ack_start_addr,
+                             sizeof(*read_ack_start_addr));
+    *read_ack_start_addr = le64_to_cpu(*read_ack_start_addr);
+}
+
 void ghes_record_cper_errors(const void *cper, size_t len,
                              uint16_t source_id, Error **errp)
 {
@@ -437,6 +534,9 @@ void ghes_record_cper_errors(const void *cper, size_t len,
     if (!ags->use_hest_addr) {
         get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
                              &cper_addr, &read_ack_register_addr);
+    } else {
+        get_ghes_source_offsets(source_id, le64_to_cpu(ags->hest_addr_le),
+                                &cper_addr, &read_ack_register_addr, errp);
     }
 
     if (!cper_addr) {
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 454e97b5341c..2f06e433ce04 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -80,7 +80,7 @@ enum {
 typedef struct AcpiGhesState {
     uint64_t hest_addr_le;
     uint64_t hw_error_le;
-    bool use_hest_addr;         /* Currently, always false */
+    bool use_hest_addr; /* True if HEST address is present */
 } AcpiGhesState;
 
 void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
-- 
2.48.1


