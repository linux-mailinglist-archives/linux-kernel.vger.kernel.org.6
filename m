Return-Path: <linux-kernel+bounces-285620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4071395107B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 01:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAF601F25CA8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 23:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5A81AC450;
	Tue, 13 Aug 2024 23:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUr+YmaJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC81B1AC420
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 23:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723591451; cv=none; b=Ycw/oZJPBoL/RHLax6bY8wGi58i6i61Ppqbld2dOMVDRnn50uR66E+YJuoBWaRDHUG9OLpH09ue8ly6jaPmo5DtBlWYiJbQ9cRRd1DuIkNJeW86HsvdKSqtIowbdY+MN0uI0rJwIGkm9RdgXzuxLlRtNXf6hSJzvLdX7w1q3Cis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723591451; c=relaxed/simple;
	bh=Yx0IAnqY4alORAX037P9zQP5s04TdYEo59HvelobeeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Py/xheqr8t2JuO77l98ocw4Oaroe90h+2aGrhSKXdu1j6hxM2Uac01k/qemzEUvWY6La9Cpdl2XlgapfiSCL7qo8bWtCph42BurM/8PIqxiK6AEEzx/fl5uOq9uGTCzqlcpxdMNhJBXSjLM4m77FWym1cjRAJGE5ZJtpesE7lJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUr+YmaJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6165BC4AF0F;
	Tue, 13 Aug 2024 23:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723591451;
	bh=Yx0IAnqY4alORAX037P9zQP5s04TdYEo59HvelobeeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZUr+YmaJCFs7NxYF7N8cwQAzhPDgL1c4NtqDzd6X9FgnfgamSSCMERUwNVyBkZ92L
	 xVbqxMzglhUTBnRE2SM2qdgfcjlTtj5+a+KHzXlOhUEVIJy1kVhIHKM66sEFWBs1df
	 i4XHSdAChTUoi65BHlooq2JmfWk2eKOG7CgVjUIeFBCATRtLZglNS6erIoQVPRatwx
	 l5TxDuDNYgL3kZ4OJ/pEETqXrOcmi/L+qG0F/0abrFI1dUnUwpt66VOaic41OHSLtC
	 AUC67SSMzuwPFFszjIEr5QAu6lH4wAmhu9Hu2qq0H2mThYCqBy+tanlPO1/UU/VX0B
	 HfA90xDUmTT5A==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1se0s5-00000002asG-1RHx;
	Wed, 14 Aug 2024 01:24:09 +0200
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
Subject: [PATCH v7 03/10] acpi/ghes: Add support for GED error device
Date: Wed, 14 Aug 2024 01:23:25 +0200
Message-ID: <f813113e8e7645c2fb654747ecd0726f330af29f.1723591201.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1723591201.git.mchehab+huawei@kernel.org>
References: <cover.1723591201.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

As a GED error device is now defined, add another type
of notification.

Add error notification to GHES v2 using a GED error device GED
triggered via interrupt.

[mchehab: do some cleanups at ACPI_HEST_SRC_ID_* checks and
 rename HEST event to better identify GED interrupt OSPM]

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/ghes.c         | 12 +++++++++---
 include/hw/acpi/ghes.h |  3 ++-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 13b105c5d02d..280674452a60 100644
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
+    case ACPI_HEST_SRC_ID_GED:
+        build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_GPIO);
+        break;
     default:
         error_report("Not support this error source");
         abort();
@@ -370,6 +376,7 @@ void acpi_build_hest(GArray *table_data, BIOSLinker *linker,
     /* Error Source Count */
     build_append_int_noprefix(table_data, ACPI_GHES_ERROR_SOURCE_COUNT, 4);
     build_ghes_v2(table_data, ACPI_HEST_SRC_ID_SEA, linker);
+    build_ghes_v2(table_data, ACPI_HEST_SRC_ID_GED, linker);
 
     acpi_table_end(linker, &table);
 }
@@ -406,7 +413,6 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
     start_addr = le64_to_cpu(ags->ghes_addr_le);
 
     if (physical_address) {
-
         if (source_id < ACPI_HEST_SRC_ID_RESERVED) {
             start_addr += source_id * sizeof(uint64_t);
         }
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index fb80897e7eac..419a97d5cbd9 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -59,9 +59,10 @@ enum AcpiGhesNotifyType {
     ACPI_GHES_NOTIFY_RESERVED = 12
 };
 
+/* Those are used as table indexes when building GHES tables */
 enum {
     ACPI_HEST_SRC_ID_SEA = 0,
-    /* future ids go here */
+    ACPI_HEST_SRC_ID_GED,
     ACPI_HEST_SRC_ID_RESERVED,
 };
 
-- 
2.46.0


