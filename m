Return-Path: <linux-kernel+bounces-417991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8A09D5BA5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 431411F2343F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45D01DF98F;
	Fri, 22 Nov 2024 09:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFraNgWm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B431DDC39
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732266710; cv=none; b=MJ9+OtdK4a/1G57MVh/Bb1BxD7B0AU0FcGBSiop7iTnRoyXvzWTNDGi3b+HcDEgEOKDsW8W+GeryES3gx4958cLAJERrjmiNEaVhaEm4JNZBLlBz8nTyHukfVok4vrfjRBtdQmP9LiHtxO0UR0JAaTJm8QPciguCQGNDugW5IhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732266710; c=relaxed/simple;
	bh=/J8Ik2gV7ARAny61vMhfWIVszDkkmW/W+wjqFlb9x4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILjWVsYiuVxaMAgits61P581dAQXcWgrlHo4F3+kzcQPW7MrqGVElhMxSKWweuFyJxOW3bN/E/TWVOsUlGHvMzHmMWXVFZbyGRAq3ZhXegGmlL7Pnx3pXTDFvod4EUD9y6vz9fr7pKf02baUAVGtNNZN6dR78Sswjue/Z11v1ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFraNgWm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F8FC4CED7;
	Fri, 22 Nov 2024 09:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732266709;
	bh=/J8Ik2gV7ARAny61vMhfWIVszDkkmW/W+wjqFlb9x4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SFraNgWmycLEBmSZeTbU6FaFmwpA6+S2emG81D+VIn0Y96qJN84pldb/55xtKKquz
	 7nyZGDEj9J7/D8FMfABrk4I/CgzMXpC4TPSsp2sqgdJ2NRXcHS/9bWswdZq08km4lN
	 JlspEpoljbtvIgNNYXkASJAXPitbLBW90Y4FP4eUAu6oelzTHZUCJEMqMP86jTuf6r
	 ROl5muLdvox5UtGTpNVtAlZoS8HFyYdPwL4Ai+3jyq1VMxksS0HdnzVh2j42IUhUZK
	 dmnYSKm7Rx2gpDh5LQitqeDVJzOsDAfaPbeD169k21/yHAlbLU0gLcK75cztfTmip4
	 NHHEh57Egn5UQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tEPhX-00000006l3h-0CNf;
	Fri, 22 Nov 2024 10:11:43 +0100
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
Subject: [PATCH v4 04/15] acpi/ghes: better handle source_id and notification
Date: Fri, 22 Nov 2024 10:11:21 +0100
Message-ID: <0ad66ed39b357d5fbf2e4a6d1fa47d310796cc1c.1732266152.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1732266152.git.mchehab+huawei@kernel.org>
References: <cover.1732266152.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

GHES has two fields that are stored on HEST error source
blocks associated with notifications:

- notification type, which is a number defined at the ACPI spec
  containing several arch-specific synchronous and assynchronous
  types;
- source id, which is a HW/FW defined number, used to distinguish
  between different implemented sources.

There could be several sources with the same notification type,
which is dependent of the way each architecture maps notifications.

Right now, build_ghes_v2() hardcodes a 1:1 mapping between such
fields. Move it to two independent parameters, allowing the
caller function to fill both.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---

Chenges from v10:

- Some changes got moved to the previous patch.

Changes from v8:
- Non-rename/cleanup changes merged altogether;
- source ID is now more generic, defined per guest target.
  That should make easier to add support for 86.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/ghes.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 4a6c45bcb4be..29cd7e4d8171 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -284,9 +284,13 @@ static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
 }
 
 /* Build Generic Hardware Error Source version 2 (GHESv2) */
-static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
+static void build_ghes_v2(GArray *table_data,
+                          BIOSLinker *linker,
+                          enum AcpiGhesNotifyType notify,
+                          uint16_t source_id)
 {
     uint64_t address_offset;
+
     /*
      * Type:
      * Generic Hardware Error Source version 2(GHESv2 - Type 10)
@@ -316,18 +320,8 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
         address_offset + GAS_ADDR_OFFSET, sizeof(uint64_t),
         ACPI_GHES_ERRORS_FW_CFG_FILE, source_id * sizeof(uint64_t));
 
-    switch (source_id) {
-    case ACPI_HEST_SRC_ID_SEA:
-        /*
-         * Notification Structure
-         * Now only enable ARMv8 SEA notification type
-         */
-        build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_SEA);
-        break;
-    default:
-        error_report("Not support this error source");
-        abort();
-    }
+    /* Notification Structure */
+    build_ghes_hw_error_notification(table_data, notify);
 
     /* Error Status Block Length */
     build_append_int_noprefix(table_data, ACPI_GHES_MAX_RAW_DATA_LENGTH, 4);
@@ -369,7 +363,8 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
 
     /* Error Source Count */
     build_append_int_noprefix(table_data, ACPI_GHES_ERROR_SOURCE_COUNT, 4);
-    build_ghes_v2(table_data, ACPI_HEST_SRC_ID_SEA, linker);
+    build_ghes_v2(table_data, linker,
+                  ACPI_GHES_NOTIFY_SEA, ACPI_HEST_SRC_ID_SEA);
 
     acpi_table_end(linker, &table);
 }
-- 
2.47.0


