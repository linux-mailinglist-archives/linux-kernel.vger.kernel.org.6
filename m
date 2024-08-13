Return-Path: <linux-kernel+bounces-285618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7334295107D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 01:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1122E1C21E90
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 23:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794C61AC452;
	Tue, 13 Aug 2024 23:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTK5MBEC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DCA1ABEDC
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 23:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723591451; cv=none; b=CwnJEUgjWru1tT3B+iaVgZV13AdsomNHVLKoMzyjVRizS4sAGd0CoyJ/cfomMOnwIxFAG6dHPK8PqZjn6cA32lAd+K7EsABjKJAqzbMRl/QGyB7i+NfivvXJbA4HLhcLoBneDW1KpdeJbGTyZTrJd0Xp+vFwilD7nkPPy9FuL8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723591451; c=relaxed/simple;
	bh=7SZ1So9xfJQq48rQZfysiQEF2+M+2VHIMENgBvOnmBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jk9g5VsXHMRQ2tqvcx2tntJfSLfF7MFauQp1mLnXQzTampHafDiPME2jDzWQ0uhzmjXiOal5uC9KjB2WJs8HV8LXPs0Yqrxx41dqjg4JURVIgT0IeAHO5baw7QsEcOU0b4DukoK3uzPzandPpFHBxNCF2NIdatiXzleHsyvk+gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTK5MBEC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3F3C4AF10;
	Tue, 13 Aug 2024 23:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723591451;
	bh=7SZ1So9xfJQq48rQZfysiQEF2+M+2VHIMENgBvOnmBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nTK5MBECnzDZzBeugqMxgAZwqQ9opBQO48aKxxt9N3UW1YlqSqehUfKqEZ5x/OqUU
	 B+t51h7DztOunj02fc4+x4Ywxa1GzdjB7xmbLXCLa8SZViuF/GG1rcYBY+WUemSUo9
	 Ug9vyoixyBuNIHcqsPf6oYvDdglRmuzj9VYWTZ+VB9EYLCKa0+ma44n5q2ekG6hBqE
	 72dE1W7Jj9rzBRsgSaawGBtPTXnpbYSsgtm8Ewj2dpVU+GCSuNu6ZiudJ51pkIHFzp
	 PrfhpV5pYsOlBwED1jWw7jzBbko1BUVREF0bTjSgXLz9WtrEtddd2/mwTspYSFix15
	 FYMNStd6VIINQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1se0s5-00000002asU-1mFo;
	Wed, 14 Aug 2024 01:24:09 +0200
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
Subject: [PATCH v7 06/10] acpi/ghes: add support for generic error injection via QAPI
Date: Wed, 14 Aug 2024 01:23:28 +0200
Message-ID: <2104a34f6233dc4a220739348f1a21689fbd3354.1723591201.git.mchehab+huawei@kernel.org>
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
 hw/acpi/ghes.c         | 57 ++++++++++++++++++++++++++++++++++++++++++
 hw/acpi/ghes_cper.c    |  2 +-
 include/hw/acpi/ghes.h |  3 +++
 3 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index f93499d7d647..2f6b50d57ed2 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -495,6 +495,63 @@ int acpi_ghes_record_errors(enum AcpiGhesNotifyType notify,
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
+    cper_addr += 2 * ACPI_HEST_SRC_ID_COUNT * sizeof(uint64_t);
+    cper_addr += source * ACPI_GHES_MAX_RAW_DATA_LENGTH;
+
+    read_ack_start_addr = le64_to_cpu(ags->hest_addr_le);
+    read_ack_start_addr += source * HEST_GHES_V2_TABLE_SIZE + HEST_ACK_OFFSET;
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
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 2524b5e64624..dacd82c6857e 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -74,6 +74,9 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
 int acpi_ghes_record_errors(enum AcpiGhesNotifyType notify,
                             uint64_t error_physical_addr);
 
+void ghes_record_cper_errors(uint8_t *cper, size_t len,
+                             enum AcpiGhesNotifyType notify,Error **errp);
+
 /**
  * acpi_ghes_present: Report whether ACPI GHES table is present
  *
-- 
2.46.0


