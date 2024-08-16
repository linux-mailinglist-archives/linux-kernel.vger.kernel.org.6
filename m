Return-Path: <linux-kernel+bounces-289190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2359542F8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9810288CCE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAF0143C55;
	Fri, 16 Aug 2024 07:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmr4TPJO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C730139563
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 07:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723793874; cv=none; b=htOUuMAWweiUshluSVY5AoTj0WlSlYh7h/ndq1cMdzW6HTijuJR2V6wMd1eCJGPjfQZgHIgWodwNn7DaRFV+8751nOimWk3lea4oWnPjUjqRAjd2e3KE1JWLYy82ZP4x26d2PDNlsQf/pk9RtY5YrVupkCYJJCh3ekIstLamKwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723793874; c=relaxed/simple;
	bh=/UrLD39uTtqzLQxF34eTLlBfA+BnxRQyD1jfJGYlCXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BVxyQSc4nCG26X1x0a8SjcOQIQwE9fKWbImgjFIDsLd8Yds7kq75NESFT/gN/pbu3fDUN3FFM+NwxQG5itV9DqRxU1KoImcS3PJFIx/CY/VyL3dVe0OkisVteGiMuY6lWZ3Hg3o2C/zKH/xG+HJ/VlleOfx5atTeA9p1VgAfHOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmr4TPJO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C56C4AF1B;
	Fri, 16 Aug 2024 07:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723793873;
	bh=/UrLD39uTtqzLQxF34eTLlBfA+BnxRQyD1jfJGYlCXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bmr4TPJOs8R126ZTZujoL+kcn4vqs4uJF2xQupXLwWPFzrqf73Bc6iWDbnBEsEzPA
	 5Vn7z74PF+PHT8U9y9vhXVH+olR89WFT2N4yV0UptS7U4hBHn+Sif18rUMP8YHxuwP
	 tMlvrX5tRlJ6NTjCPzfA80YIhvJZXihhEKsdHWZin/8oo/OUQ/U4PCkNF023/498Gp
	 PTnhYX372f1bmpVv0z9OqhxR0NwEoFhCT36YVBSErUM3yvjRtoFut6N9kvHDsyJYkd
	 hRxn9x+chujIKeIkBGiA60VOvsIyhRUevXnHAZnvOQNwPjXbhPxKifQWiDHMMyn1jv
	 21I5Y/d2caiGg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1serWx-000000055f3-31wS;
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
Subject: [PATCH v8 12/13] acpi/ghes: cleanup generic error data logic
Date: Fri, 16 Aug 2024 09:37:44 +0200
Message-ID: <d91565e9ac1c59bd2bb22b06256f5fefcb43a973.1723793768.git.mchehab+huawei@kernel.org>
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

Remove comments that are obvious.

No functional changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/ghes.c | 38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 4f7b6c5ad2b6..a822a5eafaa0 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -130,34 +130,28 @@ static void build_ghes_hw_error_notification(GArray *table, const uint8_t type)
  * ACPI 6.1: 18.3.2.7.1 Generic Error Data
  */
 static void acpi_ghes_generic_error_data(GArray *table,
-                const uint8_t *section_type, uint32_t error_severity,
-                uint8_t validation_bits, uint8_t flags,
-                uint32_t error_data_length, QemuUUID fru_id,
-                uint64_t time_stamp)
+                                         const uint8_t *section_type,
+                                         uint32_t error_severity,
+                                         uint8_t validation_bits,
+                                         uint8_t flags,
+                                         uint32_t error_data_length,
+                                         QemuUUID fru_id,
+                                         uint64_t time_stamp)
 {
     const uint8_t fru_text[20] = {0};
 
-    /* Section Type */
     g_array_append_vals(table, section_type, 16);
-
-    /* Error Severity */
     build_append_int_noprefix(table, error_severity, 4);
+
     /* Revision */
     build_append_int_noprefix(table, 0x300, 2);
-    /* Validation Bits */
+
     build_append_int_noprefix(table, validation_bits, 1);
-    /* Flags */
     build_append_int_noprefix(table, flags, 1);
-    /* Error Data Length */
     build_append_int_noprefix(table, error_data_length, 4);
 
-    /* FRU Id */
     g_array_append_vals(table, fru_id.data, ARRAY_SIZE(fru_id.data));
-
-    /* FRU Text */
     g_array_append_vals(table, fru_text, sizeof(fru_text));
-
-    /* Timestamp */
     build_append_int_noprefix(table, time_stamp, 8);
 }
 
@@ -165,19 +159,17 @@ static void acpi_ghes_generic_error_data(GArray *table,
  * Generic Error Status Block
  * ACPI 6.1: 18.3.2.7.1 Generic Error Data
  */
-static void acpi_ghes_generic_error_status(GArray *table, uint32_t block_status,
-                uint32_t raw_data_offset, uint32_t raw_data_length,
-                uint32_t data_length, uint32_t error_severity)
+static void acpi_ghes_generic_error_status(GArray *table,
+                                           uint32_t block_status,
+                                           uint32_t raw_data_offset,
+                                           uint32_t raw_data_length,
+                                           uint32_t data_length,
+                                           uint32_t error_severity)
 {
-    /* Block Status */
     build_append_int_noprefix(table, block_status, 4);
-    /* Raw Data Offset */
     build_append_int_noprefix(table, raw_data_offset, 4);
-    /* Raw Data Length */
     build_append_int_noprefix(table, raw_data_length, 4);
-    /* Data Length */
     build_append_int_noprefix(table, data_length, 4);
-    /* Error Severity */
     build_append_int_noprefix(table, error_severity, 4);
 }
 
-- 
2.46.0


