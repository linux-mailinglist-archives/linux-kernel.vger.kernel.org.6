Return-Path: <linux-kernel+bounces-337986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAA59851DD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 06:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AF17B2249C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 04:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F89915853A;
	Wed, 25 Sep 2024 04:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spdjOThu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11D614E2E6
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 04:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727237088; cv=none; b=MTcpoILO3/E5eu3s2aG21j8A3hhVCHx3EGU3urF1uyY9/pLNbwPhkFPBa/DoeC+epFRkAL08jJa7QXuixQXWMG3JIB1mbNx3j9aZWVVmKO78XUzGEwGMmTAZ6FqoNZETsFMq6bc0Dtj/Q6HmlJx7QnBj20M87wjc5O068pkuMco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727237088; c=relaxed/simple;
	bh=4fgBhCBxE+wCYyt3lvjzhbEmYlzn+2yibyxudvyc7nI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lkHyUe0VeU7nIIFd0qf5rGf/AH4KBRbLdbrB7oRKxJdX3hxS2hxyZ8x6SKRXtaMFJclcGQsYaaBWIWrnOkqJawFWuFM7bwtdIImTtNff9146zfUB9F/q1lI3DU0i3FiX4NsGdq+BK9VUrDlIzqWG11GkGqe5XkLe4tVwdBhWxxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spdjOThu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351E0C4CEDA;
	Wed, 25 Sep 2024 04:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727237088;
	bh=4fgBhCBxE+wCYyt3lvjzhbEmYlzn+2yibyxudvyc7nI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=spdjOThuqJlCpvX4VT3eEZrJ6YliOpsnI7j4vyKGASS34r7y2XNHZLO2ey4MThAx7
	 oJh/xJNyal9ySBBTbk6imDp4k6QXKwSpz6ddcEwbQ+dKmFg2keqfz+uiC6+2w2HZX7
	 CTANoO7Qd6eF/jehuBVcylrGAZ9VI/UeCc1RiKrVkn5MG2KYpwd1nxrTcM4GDsybaA
	 CMOB2pQ8efQggRi4Q3/Z49pH6isxnhE4pKi99uK/I1PPaWKCicDySCUiaPPIi+/NAc
	 +r+Ubn1Tt9LbbHNz7t33DXwdHCPlIdJMdfGW1/x/N2Tk/yTOaMd7lqUpFFMVgflROj
	 stxFEYp2loTMQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1stJGg-0000000828T-1fIh;
	Wed, 25 Sep 2024 06:04:46 +0200
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
Subject: [PATCH 13/15] acpi/ghes: rename etc/hardware_error file macros
Date: Wed, 25 Sep 2024 06:04:18 +0200
Message-ID: <fb795e722d0b7baf9b1d3c328d7a3b917470194e.1727236561.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1727236561.git.mchehab+huawei@kernel.org>
References: <cover.1727236561.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Now that we have also have a file to store HEST data location,
which is part of GHES, better name the file where CPER records
are stored.

No functional changes.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/ghes.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 209095f67e9a..3d03506fdaf8 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -28,8 +28,8 @@
 #include "hw/nvram/fw_cfg.h"
 #include "qemu/uuid.h"
 
-#define ACPI_GHES_ERRORS_FW_CFG_FILE        "etc/hardware_errors"
-#define ACPI_GHES_DATA_ADDR_FW_CFG_FILE     "etc/hardware_errors_addr"
+#define ACPI_HW_ERROR_FW_CFG_FILE           "etc/hardware_errors"
+#define ACPI_HW_ERROR_ADDR_FW_CFG_FILE      "etc/hardware_errors_addr"
 
 /* The max size in bytes for one error block */
 #define ACPI_GHES_MAX_RAW_DATA_LENGTH   (1 * KiB)
@@ -249,7 +249,7 @@ static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker,
         ACPI_GHES_MAX_RAW_DATA_LENGTH * num_sources);
 
     /* Tell guest firmware to place hardware_errors blob into RAM */
-    bios_linker_loader_alloc(linker, ACPI_GHES_ERRORS_FW_CFG_FILE,
+    bios_linker_loader_alloc(linker, ACPI_HW_ERROR_FW_CFG_FILE,
                              hardware_errors, sizeof(uint64_t), false);
 
     for (i = 0; i < num_sources; i++) {
@@ -258,17 +258,21 @@ static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker,
          * corresponding "Generic Error Status Block"
          */
         bios_linker_loader_add_pointer(linker,
-            ACPI_GHES_ERRORS_FW_CFG_FILE, sizeof(uint64_t) * i,
-            sizeof(uint64_t), ACPI_GHES_ERRORS_FW_CFG_FILE,
-            error_status_block_offset + i * ACPI_GHES_MAX_RAW_DATA_LENGTH);
+                                       ACPI_HW_ERROR_FW_CFG_FILE,
+                                       sizeof(uint64_t) * i,
+                                       sizeof(uint64_t),
+                                       ACPI_HW_ERROR_FW_CFG_FILE,
+                                       error_status_block_offset +
+                                       i * ACPI_GHES_MAX_RAW_DATA_LENGTH);
     }
 
     /*
      * tell firmware to write hardware_errors GPA into
      * hardware_errors_addr fw_cfg, once the former has been initialized.
      */
-    bios_linker_loader_write_pointer(linker, ACPI_GHES_DATA_ADDR_FW_CFG_FILE,
-        0, sizeof(uint64_t), ACPI_GHES_ERRORS_FW_CFG_FILE, 0);
+    bios_linker_loader_write_pointer(linker, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, 0,
+                                     sizeof(uint64_t),
+                                     ACPI_HW_ERROR_FW_CFG_FILE, 0);
 }
 
 /* Build Generic Hardware Error Source version 2 (GHESv2) */
@@ -307,8 +311,10 @@ static void build_ghes_v2(GArray *table_data,
     build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 0x40, 0,
                      4 /* QWord access */, 0);
     bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
-        address_offset + GAS_ADDR_OFFSET, sizeof(uint64_t),
-        ACPI_GHES_ERRORS_FW_CFG_FILE, index * sizeof(uint64_t));
+                                   address_offset + GAS_ADDR_OFFSET,
+                                   sizeof(uint64_t),
+                                   ACPI_HW_ERROR_FW_CFG_FILE,
+                                   index * sizeof(uint64_t));
 
     /* Notification Structure */
     build_ghes_hw_error_notification(table_data, notify);
@@ -327,7 +333,7 @@ static void build_ghes_v2(GArray *table_data,
     bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
                                    address_offset + GAS_ADDR_OFFSET,
                                    sizeof(uint64_t),
-                                   ACPI_GHES_ERRORS_FW_CFG_FILE,
+                                   ACPI_HW_ERROR_FW_CFG_FILE,
                                    (num_sources + index) * sizeof(uint64_t));
 
     /*
@@ -368,11 +374,11 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
                           GArray *hardware_error)
 {
     /* Create a read-only fw_cfg file for GHES */
-    fw_cfg_add_file(s, ACPI_GHES_ERRORS_FW_CFG_FILE, hardware_error->data,
+    fw_cfg_add_file(s, ACPI_HW_ERROR_FW_CFG_FILE, hardware_error->data,
                     hardware_error->len);
 
     /* Create a read-write fw_cfg file for Address */
-    fw_cfg_add_file_callback(s, ACPI_GHES_DATA_ADDR_FW_CFG_FILE, NULL, NULL,
+    fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
         NULL, &(ags->ghes_addr_le), sizeof(ags->ghes_addr_le), false);
 
     ags->present = true;
-- 
2.46.1


