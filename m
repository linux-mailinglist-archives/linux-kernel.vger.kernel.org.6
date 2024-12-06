Return-Path: <linux-kernel+bounces-435382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2499E76EE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ABFC18820F1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9416420458B;
	Fri,  6 Dec 2024 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHGqBHgr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04CC1FFC70
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 17:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505687; cv=none; b=h1MZgpWbfxK19ZS0di13BMRZcQok8AvYL5dOjxL2W2pof41VLvwiSQuCceYsWgdM6FTJQj4L8jW9mq/HXzoqpeIe7r79hfC8GYOkRnejjRNOgL3F56hlAylh49KgQdWrQpkpr9SqI9xiO3Y0rre0kSdvMN7RhFJnR4/zcdXi2O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505687; c=relaxed/simple;
	bh=Zdz33+JrFuLWEYr3Q523j6TOZr8k9EjWwbpOCTAVnQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SK/b+MBE2tuJVeS1ySju5OxKbOCGRPqk7blH2zxnK6zR5bOu7lq7gb5jQ7LtqjUn0Toqmjcku3bbWfxmIYNMTaYsv+EJgUkyQEGmEtGrf7JChxHoWGxlAH4OtnEw2Y/8ArIXSCrnQOJDi/sGNEHegbm7uKtplKRrAV/WPiMN/iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHGqBHgr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C11BC4CEE2;
	Fri,  6 Dec 2024 17:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733505687;
	bh=Zdz33+JrFuLWEYr3Q523j6TOZr8k9EjWwbpOCTAVnQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kHGqBHgrTkKq/Zk8zYE6eSMP1lRJlVYPCDdMzYTAFuav9fXb6QncOiJpjZPA3pcnk
	 BjEUuVG6Kus1F8ELkzHBT5pAfGrsZ8mH26p4sJdZI1yFsJZi/LZgv79dUsoLNXvNco
	 D/m3PLXzP8xn0Lbfi5a8WR9QmMBPK908glmmeCYBIJP9epMbXp4qs50oBORhhqQPRm
	 BYe0FtU9UesP4SKOES5bPw9qcQMiltRoOlAouG4S9jhUAzvmjj4esjALWrb0GZj2It
	 bG+/YWTyy6JEIq70R79kFWiVs4y0nw2RKkQUCetTw4353XRifH0tWdg2me0+nnoxt2
	 w7BgmWGBwyGrQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tJc17-00000005RJm-2LeZ;
	Fri, 06 Dec 2024 18:21:25 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>,
	Igor Mammedov <imammedo@redhat.com>,
	linux-kernel@vger.kernel.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 04/31] acpi/ghes: better handle source_id and notification
Date: Fri,  6 Dec 2024 18:12:26 +0100
Message-ID: <a4870548c06fe72c2eb4d16c50f369e6a4262aca.1733504943.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733504943.git.mchehab+huawei@kernel.org>
References: <cover.1733504943.git.mchehab+huawei@kernel.org>
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
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
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
2.47.1


