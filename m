Return-Path: <linux-kernel+bounces-258515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 235BA938908
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 08:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C13CF1F21605
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 06:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514311B95B;
	Mon, 22 Jul 2024 06:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVL2WE7O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE3217C6C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 06:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721630776; cv=none; b=occtQKOtysiJqpdZn+xDlFgYEv8xB7Ioo6WmmrCpyNHWJibDq/+OBnJMtF3WRFw1OokkCvDPTUUV3IZGmuCXIqv325L0UsGKoCjwvFjlDtw6fy38Cegu/2Rn2z/rqu63TKng7rgxQJ/PbNDDf23/7UNDUvU04x3NVy3/4fjHikw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721630776; c=relaxed/simple;
	bh=3+tNSaQ8a39Ggzkv/WVrggnD0uGXWcuNnDojR+LSc44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uQhqy/ovmbr61lRRs4YMn6j6XvVwZe9fB552ppPqAXuKFXnuoOFoifbuD3ebjURbSQB5IDdth8HCha2d2hZrBXh7wmyY1noK4Kh2ayGBiKN5cRnhjIPQOWOKH2cG+x4Mb6sUGwn0amh74ulP7bm413Jtqfay5cZl3L9wtEyifpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVL2WE7O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4741EC4AF0A;
	Mon, 22 Jul 2024 06:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721630776;
	bh=3+tNSaQ8a39Ggzkv/WVrggnD0uGXWcuNnDojR+LSc44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oVL2WE7OZyykfjc+U2h2ZDFYoXmJtfncWZ00gq3o3UjqBibGgSeFarIwrqFI2rh5F
	 fWU37+OYJd9BVpLWc8QGKcjj26Jl41p3Ixybo90RMiN9czMab0tZjslu8tLdMuy7cb
	 L/5pz4+gZ6qJoNpGuaLvJvneqkTsmM+t4FcCFekjJhgI0hswZ7JhbdoJKtmXcNrHLm
	 pA7bKJzR5nshm4UvQcDZbbyJXKg3clgCcdRQviH+9N9WDQQvwuI6/7WgLWEgJbn2Br
	 w5TTtEMBnbcRyfZlWOtGFkV9U2G1kMSOog/hLMYKZPT32MwV6Gjt5fJpE/u7zw3Wt8
	 OAesAlhtMmIAA==
Received: from mchehab by mail.kernel.org with local (Exim 4.97.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1sVmoI-00000000WQo-12C9;
	Mon, 22 Jul 2024 08:46:14 +0200
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
Subject: [PATCH v3 3/7] acpi/ghes: Support GPIO error source.
Date: Mon, 22 Jul 2024 08:45:55 +0200
Message-ID: <64a31a09fe6b11bebad1c592ad20071a9d93fee5.1721630625.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1721630625.git.mchehab+huawei@kernel.org>
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
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

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/ghes.c         | 8 ++++++--
 include/hw/acpi/ghes.h | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index e9511d9b8f71..5b8bc6eeb437 100644
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
@@ -327,6 +327,9 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
          */
         build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_SEA);
         break;
+    case ACPI_HEST_SRC_ID_GPIO:
+        build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_GPIO);
+        break;
     default:
         error_report("Not support this error source");
         abort();
@@ -370,6 +373,7 @@ void acpi_build_hest(GArray *table_data, BIOSLinker *linker,
     /* Error Source Count */
     build_append_int_noprefix(table_data, ACPI_GHES_ERROR_SOURCE_COUNT, 4);
     build_ghes_v2(table_data, ACPI_HEST_SRC_ID_SEA, linker);
+    build_ghes_v2(table_data, ACPI_HEST_SRC_ID_GPIO, linker);
 
     acpi_table_end(linker, &table);
 }
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 674f6958e905..4f1ab1a73a06 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -58,6 +58,7 @@ enum AcpiGhesNotifyType {
 
 enum {
     ACPI_HEST_SRC_ID_SEA = 0,
+    ACPI_HEST_SRC_ID_GPIO = 1,
     /* future ids go here */
     ACPI_HEST_SRC_ID_RESERVED,
 };
-- 
2.45.2


