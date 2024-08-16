Return-Path: <linux-kernel+bounces-289185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D859542E0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ABCE289A87
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D57813AA2B;
	Fri, 16 Aug 2024 07:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZeNcP1YH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8BD1369BB
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 07:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723793873; cv=none; b=YSMsRalAwH0zm7TF8zRTifShwrY3YB2dRmZF2jPoHre6Nr7HxqXgCei/HHIwZh43pyy/RaFRVyQ5p4UwGdhUNKw+PGF6CMZ/bEKOMmyBn4VUi7VlxZQUEXKUunkDO1HGN1eLTDxj5HvNp0R8veJmk4vE2wxgQ1A3xmKm/nmqZEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723793873; c=relaxed/simple;
	bh=JoJ9jxUPN+bhI+z9iZ5mSppDZu1zv6TnTL8L5TshfvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dUpdg+IXIfd8ZjF2GO8ppEylw+DstaomZe8Jc1XOUgi/a7VHk2McSTfpdlYnqncHQowYbW/lqim4w6MqMLZ07HWFqlcr8zRQTUN/EyBfMztG8z5iou5kECpOPFermI2ks04QKfpxSA+4NUmilf/bAFNgx2oS3EVgVM7nMJc1QtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZeNcP1YH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61703C4AF0F;
	Fri, 16 Aug 2024 07:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723793873;
	bh=JoJ9jxUPN+bhI+z9iZ5mSppDZu1zv6TnTL8L5TshfvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZeNcP1YHkuW16eLBF4Ww3gUQFaLfbFchA0M0JBNxeKjTOCeqKjeu06X3OOtqBFyiu
	 oXa94sMUVuAye2GvmciTOTJTDTkCpDAy9McSLzSkl8sFquEhWwTUnQy/gi7iX3PD+Q
	 sm5CfFlmUBcG1+WGxf9arqr5KPX+PSKkhew6eb9f+jzAcZ/ZNtynTwPRMYpdKsvhlv
	 AgT0hd1L3HqZHAHPX7i/91zCFLfgyIVnhRYpFuH5Z0PRbnORVxXpW4n+GmYcndr9Nd
	 DYqIVUQ1p/VN/dJpst6BYYK5dfRW5sFaQFMUo4GUn7g1TSxUYTHmI0DKzHg7Ffu2i3
	 KENl/UBcWdsmg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1serWx-000000055eR-21uy;
	Fri, 16 Aug 2024 09:37:51 +0200
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
Subject: [PATCH v8 03/13] acpi/ghes: Add support for GED error device
Date: Fri, 16 Aug 2024 09:37:35 +0200
Message-ID: <ba1864f1aa7073abe090eec0c31915f187967140.1723793768.git.mchehab+huawei@kernel.org>
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
 hw/acpi/ghes.c         | 11 +++++++++--
 include/hw/acpi/ghes.h |  3 ++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 13b105c5d02d..df59fd35568c 100644
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


