Return-Path: <linux-kernel+bounces-289189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085869542F6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64619B27DB6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF538143886;
	Fri, 16 Aug 2024 07:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2vnlcYZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C75E139566
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 07:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723793874; cv=none; b=WECBG9mVlvxLWieXNOx4xUTC+eUkNTwExstFIeZwhAtjTkmOXcJ/Axx6TSP0J9zSwHwAWCB97oTAei8rEXYXt8IU3wtc8JNonbn/ua2Z1LH/UlajLgfOeW3GoxGfShKUkjArvQlAl3YA8LOeJq08s8ZcO6OtZA1Z8Oq3MziKVz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723793874; c=relaxed/simple;
	bh=bWfj8/aqYfKMeMa4cF07zxom827l/axtbZeMVPNCd5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pVQc3aI2JtR5lSAhqDINgc4O09CZtb4m8QP7DBWyCmk032OrQYmuEX9a/b8XSx+C3Wx86wNsBfIRa04roY96gyTXb3FcMjsp/81CBDK2Mv1QZNhwNbhjFxV2RuEXiw2EhmQ+TJNl9phCxDMHMXqCSpEpzP6RFImiw5PWDXI9e18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2vnlcYZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD7AC4AF4D;
	Fri, 16 Aug 2024 07:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723793873;
	bh=bWfj8/aqYfKMeMa4cF07zxom827l/axtbZeMVPNCd5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B2vnlcYZl3B+bR6aYarmnwAA79sdioTCBa+SOqID5fEXXtFEkVqjkUzcBotpt0ACL
	 /e21hSUA5dUH0FSPxM0cZGdoQ7RDCY4RDWkMbhp5rs9LRKmUiMg/4U9slpXWytFK6O
	 WoBjmpSscAUCsbAetXM931E9iQajtRRCSjaQq6kssTaUm4wA3rtUWPPhH9RPP/y8Jg
	 CBu2bk2FeifPx8aF7rEIQqmAE/YEKaT5eG6hPRtk5fJXDD3lI7LGC+x8+L8FFaWvpB
	 DS0hpZkoJttupvKoj57wo18bynsHGVytm9k2JQJt9RPEcIAiiAaZldAAeB+1RBkQnE
	 t8ij01M7lmH2w==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1serWx-000000055f7-38jG;
	Fri, 16 Aug 2024 09:37:51 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>,
	Igor Mammedov <imammedo@redhat.com>,
	linux-kernel@vger.kernel.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v8 13/13] acpi/ghes: check if the BIOS pointers for HEST are correct
Date: Fri, 16 Aug 2024 09:37:45 +0200
Message-ID: <52e6058feba318d01f54da6dca427b40ea5c9435.1723793768.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1723793768.git.mchehab+huawei@kernel.org>
References: <cover.1723793768.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The OS kernels navigate between HEST, error source struct
and CPER by the usage of some pointers. Double-check if such
pointers were properly initializing, ensuring that they match
the right address for CPER.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/ghes.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index a822a5eafaa0..51e2e40e5a9c 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -85,6 +85,9 @@ enum AcpiHestSourceId {
 #define HEST_GHES_V2_TABLE_SIZE  92
 #define GHES_ACK_OFFSET          (64 + GAS_ADDR_OFFSET + ACPI_HEST_HEADER_SIZE)
 
+/* ACPI 6.2: 18.3.2.7: Generic Hardware Error Source */
+#define GHES_ERR_ST_ADDR_OFFSET  (20 + GAS_ADDR_OFFSET + ACPI_HEST_HEADER_SIZE)
+
 /*
  * Values for error_severity field
  */
@@ -425,7 +428,10 @@ NotifierList acpi_generic_error_notifiers =
 void ghes_record_cper_errors(const void *cper, size_t len,
                              enum AcpiGhesNotifyType notify, Error **errp)
 {
-    uint64_t cper_addr, read_ack_start_addr;
+    uint64_t hest_read_ack_start_addr, read_ack_start_addr;
+    uint64_t read_ack_start_addr_2, err_source_struct;
+    uint64_t hest_err_block_addr, error_block_addr;
+    uint64_t cper_addr, cper_addr_2;
     enum AcpiHestSourceId source;
     AcpiGedState *acpi_ged_state;
     AcpiGhesState *ags;
@@ -450,6 +456,28 @@ void ghes_record_cper_errors(const void *cper, size_t len,
     cper_addr += ACPI_HEST_SRC_ID_COUNT * sizeof(uint64_t);
     cper_addr += source * ACPI_GHES_MAX_RAW_DATA_LENGTH;
 
+    err_source_struct = le64_to_cpu(ags->hest_addr_le) +
+                        source * HEST_GHES_V2_TABLE_SIZE;
+
+    /* Check if BIOS addr pointers were properly generated */
+
+    hest_err_block_addr = err_source_struct + GHES_ERR_ST_ADDR_OFFSET;
+    hest_read_ack_start_addr = err_source_struct + GHES_ACK_OFFSET;
+
+    cpu_physical_memory_read(hest_err_block_addr, &error_block_addr,
+                             sizeof(error_block_addr));
+
+    cpu_physical_memory_read(error_block_addr, &cper_addr_2,
+                             sizeof(error_block_addr));
+
+    cpu_physical_memory_read(hest_read_ack_start_addr, &read_ack_start_addr_2,
+			     sizeof(read_ack_start_addr_2));
+
+    assert(cper_addr == cper_addr_2);
+    assert(read_ack_start_addr == read_ack_start_addr_2);
+
+    /* Update ACK offset to notify about a new error */
+
     cpu_physical_memory_read(read_ack_start_addr,
                              &read_ack, sizeof(uint64_t));
 
-- 
2.46.0


