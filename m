Return-Path: <linux-kernel+bounces-289182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0A39542DB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4CD71F218CC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9381313AA41;
	Fri, 16 Aug 2024 07:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZePAw1p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB867136671
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 07:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723793873; cv=none; b=L8YkaNosz2jitsS8EKEWsJKhkNtjL9KUlCgK1edu26GyPPeh9XHBwPIhN5fmxEMZF9mLYxfaNsfsBn40ufY0ghhEvaW7S9WXkuGWy2VUWwa54M5fAs3mf/n1DQ+svALXpuZH2j8szbdQGDOk3Q0rAC4Ajazo1QWIXfIsZwVhuRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723793873; c=relaxed/simple;
	bh=zSq5f2sPQEwbW1zp/QMXwMnIVQB5Xva8uz7Azz6AAiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQii7gjHagNuScythGGHvcKGXlGSGaWu/NskR/cTPSTIZb2kvshzOxBJDp0CZ0PQAon/kXhS6NVED1ESnckTNaQQXTtqyTPGS9qVBbhUr9QBIfgRBYqYPw3tHb5lc0p2P6d+CO8invmk5TAshI85i3bWHNgJ40IKWmD5BMJS2bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZePAw1p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF9AC4AF0B;
	Fri, 16 Aug 2024 07:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723793873;
	bh=zSq5f2sPQEwbW1zp/QMXwMnIVQB5Xva8uz7Azz6AAiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uZePAw1p5aB/VUFch0aN8OpTG2gL/EphQLsS5xyxUOkyU/yEy3p8YUf3Av9w1JSb3
	 Y9TO3VCNFD2ESE5RLtZeb6QgcJqlxt1Q+DsaRZ3aokUUaYoLN2Kf49rXYC5k67TOHb
	 qmRkCEIJwC14x8ml3TT4dPKwE/XtoNMhHO0+oRdMwlPV/hhuKdl2hiB7UrRWfS61KR
	 kvKW10hLSdVfmJwN37CiRBjNzt2fxsNISrgxkDXhHH0Qfh3Rypf0jQBbDCHUUBz9xO
	 Z0mtuRssKa3GQZa90Lg5I5oUQcLz+szJGhFp29OXV0mq3lPedo0Lk7jrL3GQ+FjxuI
	 JN24w6A1tgqVA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1serWx-000000055ef-2Mdl;
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
Subject: [PATCH v8 06/13] acpi/ghes: add support for generic error injection via QAPI
Date: Fri, 16 Aug 2024 09:37:38 +0200
Message-ID: <2c8970b5d54d17b601dc65d778cc8b5fb288984b.1723793768.git.mchehab+huawei@kernel.org>
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

Provide a generic interface for error injection via GHESv2.

This patch is co-authored:
    - original ghes logic to inject a simple ARM record by Shiju Jose;
    - generic logic to handle block addresses by Jonathan Cameron;
    - generic GHESv2 error inject by Mauro Carvalho Chehab;

Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Co-authored-by: Shiju Jose <shiju.jose@huawei.com>
Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/ghes.c      | 57 +++++++++++++++++++++++++++++++++++++++++++++
 hw/acpi/ghes_cper.c |  2 +-
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 7870f51e2a9e..a3ae710dcf81 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -500,6 +500,63 @@ int acpi_ghes_record_errors(enum AcpiGhesNotifyType notify,
 NotifierList acpi_generic_error_notifiers =
     NOTIFIER_LIST_INITIALIZER(error_device_notifiers);
 
+void ghes_record_cper_errors(uint8_t *cper, size_t len,
+                             enum AcpiGhesNotifyType notify, Error **errp)
+{
+    uint64_t cper_addr, read_ack_start_addr;
+    enum AcpiHestSourceId source;
+    AcpiGedState *acpi_ged_state;
+    AcpiGhesState *ags;
+    uint64_t read_ack;
+
+    if (ghes_notify_to_source_id(notify, &source)) {
+        error_setg(errp,
+                   "GHES: Invalid error block/ack address(es) for notify %d",
+                   notify);
+        return;
+    }
+
+    acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
+                                                       NULL));
+    g_assert(acpi_ged_state);
+    ags = &acpi_ged_state->ghes_state;
+
+    cper_addr = le64_to_cpu(ags->ghes_addr_le);
+    cper_addr += ACPI_HEST_SRC_ID_COUNT * sizeof(uint64_t);
+    read_ack_start_addr = cper_addr + source * sizeof(uint64_t);
+
+    cper_addr += ACPI_HEST_SRC_ID_COUNT * sizeof(uint64_t);
+    cper_addr += source * ACPI_GHES_MAX_RAW_DATA_LENGTH;
+
+    cpu_physical_memory_read(read_ack_start_addr,
+                             &read_ack, sizeof(uint64_t));
+
+    /* zero means OSPM does not acknowledge the error */
+    if (!read_ack) {
+        error_setg(errp,
+                   "Last CPER record was not acknowledged yet");
+        read_ack = 1;
+        cpu_physical_memory_write(read_ack_start_addr,
+                                  &read_ack, sizeof(uint64_t));
+        return;
+    }
+
+    read_ack = cpu_to_le64(0);
+    cpu_physical_memory_write(read_ack_start_addr,
+                              &read_ack, sizeof(uint64_t));
+
+    /* Build CPER record */
+
+    if (len > ACPI_GHES_MAX_RAW_DATA_LENGTH) {
+        error_setg(errp, "GHES CPER record is too big: %ld", len);
+    }
+
+    /* Write the generic error data entry into guest memory */
+    cpu_physical_memory_write(cper_addr, cper, len);
+
+    notifier_list_notify(&acpi_generic_error_notifiers, NULL);
+}
+
 bool acpi_ghes_present(void)
 {
     AcpiGedState *acpi_ged_state;
diff --git a/hw/acpi/ghes_cper.c b/hw/acpi/ghes_cper.c
index 92ca84d738de..2328dbff7012 100644
--- a/hw/acpi/ghes_cper.c
+++ b/hw/acpi/ghes_cper.c
@@ -29,5 +29,5 @@ void qmp_ghes_cper(const char *qmp_cper,
         return;
     }
 
-    /* TODO: call a function at ghes */
+    ghes_record_cper_errors(cper, len, ACPI_GHES_NOTIFY_GPIO, errp);
 }
-- 
2.46.0


