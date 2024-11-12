Return-Path: <linux-kernel+bounces-405573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF549C5462
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36A3DB29FED
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB9A21442F;
	Tue, 12 Nov 2024 10:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxU90Ih3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F74A2123F3
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731406510; cv=none; b=sPIXE1z2cv62YWzO4UceQvxYF5wgzW/3LNbqBiMCqt8oA+tukUgiNPyW5eeB4VBksRjp486oU6ffCmRudprXIa5yCn9nBEqfxpG/6Ju0bJkYnaXf4MobtE50nBUov8vuLqALiltJBtQ06ubqJHmTWi8U1OlmNrBn1rKzWtNbODc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731406510; c=relaxed/simple;
	bh=QErupS0eevbiyg2wy1zCDXnCTb2oIiNKZApansBSCXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQCTzAa8HCR00SQcRzEhgFD0LiG5fZsdA7lhxxOnkPabwrQscj4hZOalBBVEd8iljrWTMo0R+p5qR0/dourCysw2RhjlmqONRW3P0gsSc1kY5Vw6l+WvF2IL4IXrCrHpvNltoJ32zVB5vNqXH1wDI8f2rraG6mNN+NkiSGSasus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxU90Ih3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02185C4CEE0;
	Tue, 12 Nov 2024 10:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731406510;
	bh=QErupS0eevbiyg2wy1zCDXnCTb2oIiNKZApansBSCXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nxU90Ih33ni3vxhnLgsCJ8ulutsUQdWBFU5htlBmxp58hqtVNmg5v833SQpoSNdS6
	 mhAQNXefnwa55SsLgGInk9tmLnsFIGLAUkrPgj/5Bn/xbFEwuFE1+VYES0c8ps9+Pj
	 +KeHbKtJSSe5/S3xKG6PfjVcvl4O22gp2AmSpKqW3NPa4POiCX0/ObVY7MlKiTw7Gd
	 Wi97wq68ylUZ5D+RhaJUQrjfxbM38yexnSw07IPm4MMHuVnC/Xk0dMtg9YwYi5uRoa
	 2zlXEDKcphRBbhCj5wjnN/wWP9ahwD07icGunppaVoXEdpmxUaqkn5Uwru7n4qMxM7
	 m3YJMdsOtIFKg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tAnvP-00000000JdH-1Gpr;
	Tue, 12 Nov 2024 11:15:07 +0100
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
Subject: [PATCH v3 13/15] acpi/ghes: move offset calculus to a separate function
Date: Tue, 12 Nov 2024 11:14:57 +0100
Message-ID: <14ab5a5e0b26dfa07a8d4479a46889f0f86c14e2.1731406254.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731406254.git.mchehab+huawei@kernel.org>
References: <cover.1731406254.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Currently, CPER address location is calculated as an offset of
the hardware_errors table. It is also badly named, as the
offset actually used is the address where the CPER data starts,
and not the beginning of the error source.

Move the logic which calculates such offset to a separate
function, in preparation for a patch that will be changing the
logic to calculate it from the HEST table.

While here, properly name the variable which stores the cper
address.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/acpi/ghes.c | 41 ++++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index cfe2f061c3eb..8df21bad1165 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -370,10 +370,37 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
     ags->present = true;
 }
 
+static void get_ghes_offsets(uint64_t ghes_addr,
+                             uint64_t *cper_addr,
+                             uint64_t *read_ack_register_addr)
+{
+    if (!ghes_addr) {
+        return;
+    }
+
+    /*
+     * non-HEST version supports only one source, so no need to change
+     * the start offset based on the source ID. Also, we can't validate
+     * the source ID, as it is stored inside the HEST table.
+     */
+
+    cpu_physical_memory_read(ghes_addr, cper_addr,
+                             sizeof(*cper_addr));
+
+    *cper_addr = le64_to_cpu(*cper_addr);
+
+    /*
+     * As the current version supports only one source, the ack offset is
+     * just sizeof(uint64_t).
+     */
+    *read_ack_register_addr = ghes_addr +
+			      ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
+}
+
 void ghes_record_cper_errors(const void *cper, size_t len,
                              uint16_t source_id, Error **errp)
 {
-    uint64_t error_block_addr, read_ack_register_addr, read_ack_register = 0;
+    uint64_t cper_addr = 0, read_ack_register_addr = 0, read_ack_register;
     uint64_t start_addr;
     AcpiGedState *acpi_ged_state;
     AcpiGhesState *ags;
@@ -395,18 +422,14 @@ void ghes_record_cper_errors(const void *cper, size_t len,
 
     start_addr += source_id * sizeof(uint64_t);
 
-    cpu_physical_memory_read(start_addr, &error_block_addr,
-                             sizeof(error_block_addr));
+    get_ghes_offsets(start_addr, &cper_addr, &read_ack_register_addr);
 
-    error_block_addr = le64_to_cpu(error_block_addr);
-    if (!error_block_addr) {
+    cper_addr = le64_to_cpu(cper_addr);
+    if (!cper_addr) {
         error_setg(errp, "can not find Generic Error Status Block");
         return;
     }
 
-    read_ack_register_addr = start_addr +
-                             ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
-
     cpu_physical_memory_read(read_ack_register_addr,
                              &read_ack_register, sizeof(read_ack_register));
 
@@ -427,7 +450,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
         &read_ack_register, sizeof(uint64_t));
 
     /* Write the generic error data entry into guest memory */
-    cpu_physical_memory_write(error_block_addr, cper, len);
+    cpu_physical_memory_write(cper_addr, cper, len);
 
     return;
 }
-- 
2.47.0


