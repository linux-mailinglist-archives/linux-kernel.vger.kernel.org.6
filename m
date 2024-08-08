Return-Path: <linux-kernel+bounces-279447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0127094BD78
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1D8A287733
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD81218CC00;
	Thu,  8 Aug 2024 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="os+imooc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2510218A6D2
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 12:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723120003; cv=none; b=ijib/+UdgsWhGuejz4rVC1nbxXzLyBsGwsTzaTqrEVbLgrMGZ3xLdctBK35XMxYsqe0/HxaByYAnO0hiAbfZbbmpK0QzZfkmudoz74QXmhiEv/Sool0OvkUFafyTA0+5S03nIL0AMO0hILwf6Ra9RLGbxH+z90HM4jlNslLl3lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723120003; c=relaxed/simple;
	bh=gdozRKZ3iyoRuHgiHJ0lImhnTPME+Bh4aN1C+ET0Tko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iyl2fORxJ34ABfKSGGt3BeQS4lTpNAOMrbkdD+5hdgebgWL4Uk87jf+w9ziq4HswENMvZHMb3knYlx0jADJzuGIlpeYrkx1jUF8KO88oQmm+wGoqAPyzAoWMToeAS/fLNsjW+kj0lVWeNEDj3j26gK03e9E7fyydQJtu9rV6ONw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=os+imooc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0069C4AF11;
	Thu,  8 Aug 2024 12:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723120002;
	bh=gdozRKZ3iyoRuHgiHJ0lImhnTPME+Bh4aN1C+ET0Tko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=os+imoocozit9CG5uoPjSaDohlz2hzibbsGjWrf3aYILopPlZ3qeFBmYuunrcBgSk
	 hIWmvhmHkBWWqp0V+k8sIXza9SdJf1gtttyFtYEZNGCAhF+GabkmbvxCSkG6CzGbaq
	 JDj+AHquh4hNckUWolMH4jj5JTWkv6jCx0gFQXcMGVtNa2Hoy2fvE4jlpPMMqIafrm
	 BKxJ6+6rhiFbrr3I1iGCCLPN0HbQIXC3IBBy44JiL9RmYvbPsfVC8obyPYIaVh7ndK
	 Xp8bXmL8uDz0IkzyraktZAkbad0lvgphxP5f8nw6s5Qi7ZOZVTLB/ceyVmo2er5DJe
	 IYy6UXq8GosVA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1sc2E4-00000000oDI-3j4n;
	Thu, 08 Aug 2024 14:26:40 +0200
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
Subject: [PATCH v6 03/10] acpi/ghes: Add support for GED error device
Date: Thu,  8 Aug 2024 14:26:29 +0200
Message-ID: <909c4b6c1b90be284f1e5b653e075db7156b00cd.1723119423.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1723119423.git.mchehab+huawei@kernel.org>
References: <cover.1723119423.git.mchehab+huawei@kernel.org>
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
---
 hw/acpi/ghes.c         | 12 +++++++++---
 include/hw/acpi/ghes.h |  3 ++-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 13b105c5d02d..d6cbeed6e3d5 100644
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
+    case ACPI_HEST_NOTIFY_EXTERNAL:
+        build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_GPIO);
+        break;
     default:
         error_report("Not support this error source");
         abort();
@@ -370,6 +376,7 @@ void acpi_build_hest(GArray *table_data, BIOSLinker *linker,
     /* Error Source Count */
     build_append_int_noprefix(table_data, ACPI_GHES_ERROR_SOURCE_COUNT, 4);
     build_ghes_v2(table_data, ACPI_HEST_SRC_ID_SEA, linker);
+    build_ghes_v2(table_data, ACPI_HEST_NOTIFY_EXTERNAL, linker);
 
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
index fb80897e7eac..ce6f82a1155a 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -59,9 +59,10 @@ enum AcpiGhesNotifyType {
     ACPI_GHES_NOTIFY_RESERVED = 12
 };
 
+/* Those are used as table indexes when building GHES tables */
 enum {
     ACPI_HEST_SRC_ID_SEA = 0,
-    /* future ids go here */
+    ACPI_HEST_NOTIFY_EXTERNAL,
     ACPI_HEST_SRC_ID_RESERVED,
 };
 
-- 
2.45.2


