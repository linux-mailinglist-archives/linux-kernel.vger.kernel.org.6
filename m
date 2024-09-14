Return-Path: <linux-kernel+bounces-329156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB5C978E31
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 08:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05AC1F2401D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 06:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082018003F;
	Sat, 14 Sep 2024 06:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flDVis94"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0CB22071
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 06:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726294434; cv=none; b=F0aCYdPRJ0MRX0p2oLXVWX3TVAEqzph4H9bGXYF/w41leqT600Uv1MEypBbV6jh0kyjFpoArrl7Gb7qxyGHhcGJMgHGORTOmmELYeMLFD7cNJMDr8qvxWYkWC820VRq3691YJ0Zl+Qpn6SSMx5Iz40oUg6RI+QjPhallzp4OcLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726294434; c=relaxed/simple;
	bh=s03CtzC090j2RGxB3Llbggh35Wu9jELoZhtsNV5VV+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ua1eMN8U2AdIuQ6YRvwuumYwRYgOyi8XJLQ8OV9+ULXHWbIM1uUgt43uwDW+YVrqKJmYED0/LSrdtVdOK3uMrofCry5aGwPrDQjqEIBILZEOb1OVHu6RtKk+TSNq1lGzHp6kIfagisImXIbX6d6+8AFDdWACTPKXnon3bHwVhd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flDVis94; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEDA6C4CECC;
	Sat, 14 Sep 2024 06:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726294433;
	bh=s03CtzC090j2RGxB3Llbggh35Wu9jELoZhtsNV5VV+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=flDVis94v2p7n04h+FVR7hGqCOy1jHs3xqmTO/zx6Vn70u6HxDqfcX8fW4rKxC75Q
	 sQeJJynL4yFUrtBOehjy2R/Ynv69NY8ddC//fSMd/RUHdG5mqZ3d7yWT0/a6zKv3wj
	 UK2LToEDvOEFRwTLG/6SB+G+tkRC3ERqazw3si5gHhQKL/xzTJcmRgHJxCon6UzbVR
	 tTYjFL4jxjGKQeNiV4YI828ZGVYQZ759xsE8Q4EZKLD10eq67l76t61DjWRF9u3UE8
	 4F6SJzj0+OtXJeff7EctSvfXwpk3GUF2gK0pyp5Swoq8AYHAiMKBMcEC2O7IvoJMoi
	 YuyccMhmx6Z6Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1spM2a-00000003V5c-0Aa5;
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
Subject: [PATCH v10 04/21] acpi/ghes: simplify acpi_ghes_record_errors() code
Date: Sat, 14 Sep 2024 08:13:25 +0200
Message-ID: <40b209cf75717796c658b26d0ecd564f63dc8656.1726293808.git.mchehab+huawei@kernel.org>
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

if physical_address is not defined, just return with an error
set.

That reduces the ident of the function and prepares it for
the next changes.

No functional changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/ghes.c | 56 ++++++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 35f793401d06..17b7d9e10f3e 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -417,40 +417,42 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
 
     start_addr = le64_to_cpu(ags->ghes_addr_le);
 
-    if (physical_address) {
+    if (!physical_address) {
+        return -1;
+    }
 
-        if (source_id < ACPI_GHES_ERROR_SOURCE_COUNT) {
-            start_addr += source_id * sizeof(uint64_t);
-        }
+    if (source_id < ACPI_GHES_ERROR_SOURCE_COUNT) {
+        start_addr += source_id * sizeof(uint64_t);
+    }
 
-        cpu_physical_memory_read(start_addr, &error_block_addr,
-                                 sizeof(error_block_addr));
+    cpu_physical_memory_read(start_addr, &error_block_addr,
+                                sizeof(error_block_addr));
 
-        error_block_addr = le64_to_cpu(error_block_addr);
+    error_block_addr = le64_to_cpu(error_block_addr);
 
-        read_ack_register_addr = start_addr +
-            ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
+    read_ack_register_addr = start_addr +
+        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
 
-        cpu_physical_memory_read(read_ack_register_addr,
-                                 &read_ack_register, sizeof(read_ack_register));
+    cpu_physical_memory_read(read_ack_register_addr,
+                                &read_ack_register, sizeof(read_ack_register));
 
-        /* zero means OSPM does not acknowledge the error */
-        if (!read_ack_register) {
-            error_report("OSPM does not acknowledge previous error,"
-                " so can not record CPER for current error anymore");
-        } else if (error_block_addr) {
-            read_ack_register = cpu_to_le64(0);
-            /*
-             * Clear the Read Ack Register, OSPM will write it to 1 when
-             * it acknowledges this error.
-             */
-            cpu_physical_memory_write(read_ack_register_addr,
-                &read_ack_register, sizeof(uint64_t));
+    /* zero means OSPM does not acknowledge the error */
+    if (!read_ack_register) {
+        error_report("OSPM does not acknowledge previous error,"
+            " so can not record CPER for current error anymore");
+    } else if (error_block_addr) {
+        read_ack_register = cpu_to_le64(0);
+        /*
+         * Clear the Read Ack Register, OSPM will write it to 1 when
+         * it acknowledges this error.
+         */
+        cpu_physical_memory_write(read_ack_register_addr,
+            &read_ack_register, sizeof(uint64_t));
 
-            ret = acpi_ghes_record_mem_error(error_block_addr,
-                                             physical_address);
-        } else
-            error_report("can not find Generic Error Status Block");
+        ret = acpi_ghes_record_mem_error(error_block_addr,
+                                            physical_address);
+    } else {
+        error_report("can not find Generic Error Status Block");
     }
 
     return ret;
-- 
2.46.0


