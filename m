Return-Path: <linux-kernel+bounces-273172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE16946537
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C93D1C2182E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3998137750;
	Fri,  2 Aug 2024 21:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k23NbhNc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186A87A13A
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 21:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722635064; cv=none; b=GblPEVUE2il8RPVNqY134tbr/sXjRRrQ7602FcEgTEPj1ZUj8ECMhxgJ3nXUUBlUNDX89ubXLYHlPgbTKSuOqkZtFQJI0l03Si6+kO9vTznRjikOrG0dF6psozfjAtAalK/ttYTAM9/S2l7QMKvzgOuyqAhw64jwc50yhdNlusk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722635064; c=relaxed/simple;
	bh=ZSlU9yW3n4NevgGhDHVq1qOszSSTbSe+VJ0pqN5i5yU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XmXiP3k87Ry9/HhiuCMOFZGmU/TcR2BsH0b7THHrtnTy1fvh2doXVWdFW95WybmIxVrgGYCyvqnFM5BOijFedxCdWS807E8Zbq7hxK0PuwtlXsbfC01TW+Efb5ovHpgnsOK5/71Sm9Rq78PPCie8CR94S+7oKueZiqyNF5/YzUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k23NbhNc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3F1C4AF0F;
	Fri,  2 Aug 2024 21:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722635063;
	bh=ZSlU9yW3n4NevgGhDHVq1qOszSSTbSe+VJ0pqN5i5yU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k23NbhNcvr7qcW0xNGW/lpc063Ke8p+T3amvRCJSiFCEVRb4H7p9pBQPO4OJZjc02
	 53j4U8mzbsz+hPg8IgcdmW8yhjJ0vaCvj2dpLFta0vt9caHzuWJiQ1imY+Y+6gOVhC
	 Wcs6+zgkYqfLB2ebYMcPy/zpjTAyyi7UYUcsVRSxtA74T/qeBsMtWSSfnZWb10wW7l
	 A8P8LlShEqoplvkwGKaAOe53Zfi/oadN4z6Exx8NDvjC7dLBgEA2uL1+ec4o4T6C+J
	 qtJ0c+7W7CPQy9V+SS4KX8b/U1pk0fQaJD+/UynF0GUD+kbgw+gGNrVbCHbUt6k+F9
	 GsePxlR5709Vw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1sa04T-00000002naP-2z0m;
	Fri, 02 Aug 2024 23:44:21 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>,
	Igor Mammedov <imammedo@redhat.com>,
	linux-kernel@vger.kernel.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH v5 4/7] acpi/ghes: Support GPIO error source
Date: Fri,  2 Aug 2024 23:43:59 +0200
Message-ID: <5d53042ebc5bc73bbc71f600e1ec1dea41f346b9.1722634602.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722634602.git.mchehab+huawei@kernel.org>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Add error notification to GHES v2 using the GPIO source.

[mchehab: do some cleanups at ACPI_HEST_SRC_ID_* checks]

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/ghes.c         | 16 ++++++++++------
 include/hw/acpi/ghes.h |  3 ++-
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 8d0262e6c1aa..a745dcc7be5e 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -34,8 +34,8 @@
 /* The max size in bytes for one error block */
 #define ACPI_GHES_MAX_RAW_DATA_LENGTH   (1 * KiB)
 
-/* Now only support ARMv8 SEA notification type error source */
-#define ACPI_GHES_ERROR_SOURCE_COUNT        1
+/* Support ARMv8 SEA notification type error source and GPIO interrupt. */
+#define ACPI_GHES_ERROR_SOURCE_COUNT        2
 
 /* Generic Hardware Error Source version 2 */
 #define ACPI_GHES_SOURCE_GENERIC_ERROR_V2   10
@@ -290,6 +290,9 @@ void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
 static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
 {
     uint64_t address_offset;
+
+    assert(source_id < ACPI_HEST_SRC_ID_RESERVED);
+
     /*
      * Type:
      * Generic Hardware Error Source version 2(GHESv2 - Type 10)
@@ -327,6 +330,9 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
          */
         build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_SEA);
         break;
+    case ACPI_HEST_SRC_ID_GPIO:
+        build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_GPIO);
+        break;
     default:
         error_report("Not support this error source");
         abort();
@@ -370,6 +376,7 @@ void acpi_build_hest(GArray *table_data, BIOSLinker *linker,
     /* Error Source Count */
     build_append_int_noprefix(table_data, ACPI_GHES_ERROR_SOURCE_COUNT, 4);
     build_ghes_v2(table_data, ACPI_HEST_SRC_ID_SEA, linker);
+    build_ghes_v2(table_data, ACPI_HEST_SRC_ID_GPIO, linker);
 
     acpi_table_end(linker, &table);
 }
@@ -406,10 +413,7 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
     start_addr = le64_to_cpu(ags->ghes_addr_le);
 
     if (physical_address) {
-
-        if (source_id < ACPI_HEST_SRC_ID_RESERVED) {
-            start_addr += source_id * sizeof(uint64_t);
-        }
+        start_addr += source_id * sizeof(uint64_t);
 
         cpu_physical_memory_read(start_addr, &error_block_addr,
                                  sizeof(error_block_addr));
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 6891eafff5ab..33be1eb5acf4 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -59,9 +59,10 @@ enum AcpiGhesNotifyType {
     ACPI_GHES_NOTIFY_RESERVED = 12
 };
 
+/* Those are used as table indexes when building GHES tables */
 enum {
     ACPI_HEST_SRC_ID_SEA = 0,
-    /* future ids go here */
+    ACPI_HEST_SRC_ID_GPIO,
     ACPI_HEST_SRC_ID_RESERVED,
 };
 
-- 
2.45.2


