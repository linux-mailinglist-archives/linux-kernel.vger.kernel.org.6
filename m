Return-Path: <linux-kernel+bounces-337980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7B99851D5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 06:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A50BB1F24B12
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 04:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2851581E0;
	Wed, 25 Sep 2024 04:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGczoq10"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77B014D2B7
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 04:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727237088; cv=none; b=By6unlECh8IHBH9SEWvnCuJzHhQEggLywyTVhI0B41WHCGKZbVRdFP+dQS6RXVUCJ/8QJ4Utxk0vCr7oDEd/J6jOHLOxXPg7glz73tQg6iUJlHTyIFRihm1eMuIl2uD3TJjCyVI2Rj4t7PPjZ66l0gZSm3mjJdBaT16BhR+79Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727237088; c=relaxed/simple;
	bh=mqIm3bJtaRAa0O4EuTpOX+hZV2xSkoWyzNnlHh1/o0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ICpEIa8HyYRNvBXKQcoN2agyVC2PCwHIAk557yZCxsHamS9nJeZNwR+lncAfQTeIiqTaX7WDkdPQW9DrFi2cRpdDJ7pZYdAK0C0zZke4tlmM5s54SeleGILGRiA39I51MmgzmR6TTi77SCrdWoJV/5V5TtKDsHKs7GXSCF8bM5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGczoq10; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C595C4AF09;
	Wed, 25 Sep 2024 04:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727237088;
	bh=mqIm3bJtaRAa0O4EuTpOX+hZV2xSkoWyzNnlHh1/o0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GGczoq103eX0TVLS7G6VBiPEdadBiZAX8LkTQR7sWknvkscle5U7yxMt4VhZEgLam
	 R60bkA7MtJFETB55dQRGK++A/9Lwvm9B97Cw33WIvrfnTPCVwGiKRTJZlBZ4xa3qqt
	 Htym8mCD98wrfXSMzKnNaXNGP2gMWqeV+PzzRe1JSKClBTHn7w4CS4xY3t3kZN+ZaP
	 W6Lnl4Ko3YT0mH9amdsKlisLgpstg+F1H1ssw6kohzdPdD2iZaC1ioAtB6ljd4E3no
	 gwD76kDmPK96FJ9qIGoW9wfu/TFVS5ZUMX4KTggH93MGEqAQka1bu5PCpI/8tYTcuL
	 Vhqawk4SyeweA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1stJGg-0000000828H-1KCq;
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
Subject: [PATCH 10/15] acpi/ghes: move offset calculus to a separate function
Date: Wed, 25 Sep 2024 06:04:15 +0200
Message-ID: <5e8c2f0267a21d05ed09c8af616a92d94638c474.1727236561.git.mchehab+huawei@kernel.org>
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
---
 hw/acpi/ghes.c | 52 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 307b5a41d539..900f1571bc97 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -378,11 +378,36 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
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
+    *read_ack_register_addr = ghes_addr + sizeof(uint64_t);
+}
+
 void ghes_record_cper_errors(const void *cper, size_t len,
                              uint16_t source_id, Error **errp)
 {
-    uint64_t error_block_addr, read_ack_register_addr, read_ack_register = 0;
-    uint64_t start_addr;
+    uint64_t cper_addr = 0, read_ack_register_addr = 0, read_ack_register;
     AcpiGedState *acpi_ged_state;
     AcpiGhesState *ags;
 
@@ -396,29 +421,16 @@ void ghes_record_cper_errors(const void *cper, size_t len,
     g_assert(acpi_ged_state);
     ags = &acpi_ged_state->ghes_state;
 
-    /*
-     * Current version supports only one source, as assured during table build,
-     * so no need to change the start offset based on the source ID.
-     */
-    start_addr = le64_to_cpu(ags->ghes_addr_le);
+    get_ghes_offsets(le64_to_cpu(ags->ghes_addr_le),
+                     &cper_addr, &read_ack_register_addr);
 
-    cpu_physical_memory_read(start_addr, &error_block_addr,
-                                sizeof(error_block_addr));
-
-    error_block_addr = le64_to_cpu(error_block_addr);
-    if (!error_block_addr) {
+    if (!cper_addr) {
         error_setg(errp, "can not find Generic Error Status Block");
         return;
     }
 
-    /*
-     * As the current version supports only one source, the ack offset is
-     * just sizeof(uint64_t).
-     */
-    read_ack_register_addr = start_addr + sizeof(uint64_t);
-
     cpu_physical_memory_read(read_ack_register_addr,
-                                &read_ack_register, sizeof(read_ack_register));
+                             &read_ack_register, sizeof(read_ack_register));
 
     /* zero means OSPM does not acknowledge the error */
     if (!read_ack_register) {
@@ -437,7 +449,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
         &read_ack_register, sizeof(uint64_t));
 
     /* Write the generic error data entry into guest memory */
-    cpu_physical_memory_write(error_block_addr, cper, len);
+    cpu_physical_memory_write(cper_addr, cper, len);
 
     return;
 }
-- 
2.46.1


