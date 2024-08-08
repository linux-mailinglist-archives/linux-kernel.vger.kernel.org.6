Return-Path: <linux-kernel+bounces-279450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4F394BD7B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C9FE1C22A32
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F415318CC04;
	Thu,  8 Aug 2024 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSbMU3s/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251A618C35C
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 12:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723120003; cv=none; b=VW774cMyr6Q+nGvPcnp7+XsE0wqyNKwUCdw4thr+QCDcpJUtWI2U5ajRx/1dbQwZyVgr09l+YYymGg1eluLcCpnq+24fmILnUFS4WxfF12fkQaUfp6lh5G635Ci/79etEeNH1MXnzre6Im/8VOxZilGTkGFULKcpStPZvkbRMOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723120003; c=relaxed/simple;
	bh=6/P38/7rRzxEe+1VVilVCabjUis4nPl0EUCTfasTwqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHrey7977m0rKz+Lhu95lZx1WSmztoOmFvkprm5tJJ545nW603C+lTLzteLYLwNVsoiq35frr1563oDtUvvZgZvzIlpaB9uhRgOpAUVyGx43ByAZ5cK6PuFMY8Ght8svZhPic4sXs+GVswvc/2YKDIPcY6BItIVAMTIvaN6e2sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSbMU3s/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25FAC4AF0D;
	Thu,  8 Aug 2024 12:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723120002;
	bh=6/P38/7rRzxEe+1VVilVCabjUis4nPl0EUCTfasTwqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NSbMU3s/OpMWBkLfM5zDOw4cy59etPtjJ2dOSt0soGSsXPtQrHyLnKkSL+wQ2v31M
	 r9MyazEC6q6Brqylp1n15hrHR/wd0YgUO3YztLdENrb9dRAuyi+hPl+jZ6HH+++ggF
	 iKJMkP+iS0oKx74sPK3U9e4elk7JoxvLLBBC813gdfvPRLen6eceMzCnWZYk4+Dg/f
	 vv4XgpwqQvkkq7hFdWwGqLAWYsNVLJehNvxxtd4T3qVEVNVxd4+Juy4BNaAd2JB5GD
	 Nn8e4wl4iUFvVudsYA8ou4upGfHT+NN0d9wCaC7qIb1fwKYxx9QDjAeHDkzIPFOros
	 QJL7scZJH6VSw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1sc2E4-00000000oDW-43xD;
	Thu, 08 Aug 2024 14:26:40 +0200
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
Subject: [PATCH v6 06/10] acpi/ghes: add support for generic error injection via QAPI
Date: Thu,  8 Aug 2024 14:26:32 +0200
Message-ID: <ab419c5dda274a94eefb6eaf9fecab3197f87fe1.1723119423.git.mchehab+huawei@kernel.org>
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
 hw/acpi/ghes.c         | 78 ++++++++++++++++++++++++++++++++++++++++++
 hw/acpi/ghes_cper.c    |  2 +-
 include/hw/acpi/ghes.h |  3 ++
 3 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 26e93dd0f6e2..8525481bb828 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -534,6 +534,84 @@ int acpi_ghes_record_errors(enum AcpiGhesNotifyType notify,
 NotifierList acpi_generic_error_notifiers =
     NOTIFIER_LIST_INITIALIZER(error_device_notifiers);
 
+void ghes_record_cper_errors(AcpiGhesCper *cper, Error **errp,
+                             enum AcpiGhesNotifyType notify)
+{
+    uint64_t cper_addr, read_ack_start_addr;
+    uint64_t read_ack = 0;
+    uint32_t data_length;
+    GArray *block;
+    uint32_t i;
+
+    if (ghes_get_hardware_errors_address(notify, NULL, &read_ack_start_addr,
+                                         &cper_addr, NULL)) {
+        error_setg(errp,
+                   "GHES: Invalid error block/ack address(es) for notify %d",
+                   notify);
+        return;
+    }
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
+    /*
+     * Invalid fru id: ACPI 4.0: 17.3.2.6.1 Generic Error Data,
+     * Table 17-13 Generic Error Data Entry
+     */
+    QemuUUID fru_id = {};
+
+    block = g_array_new(false, true /* clear */, 1);
+    data_length = ACPI_GHES_DATA_LENGTH + cper->data_len;
+
+    /*
+     * It should not run out of the preallocated memory if
+     * adding a new generic error data entry
+     */
+    if ((data_length + ACPI_GHES_GESB_SIZE) >
+        ACPI_GHES_MAX_RAW_DATA_LENGTH) {
+        error_setg(errp, "GHES CPER record is too big: %d",
+                   data_length);
+    }
+
+    /* Build the new generic error status block header */
+    acpi_ghes_generic_error_status(block, ACPI_GEBS_UNCORRECTABLE,
+                                    0, 0, data_length,
+                                    ACPI_CPER_SEV_RECOVERABLE);
+
+    /* Build this new generic error data entry header */
+    acpi_ghes_generic_error_data(block, cper->guid,
+                                ACPI_CPER_SEV_RECOVERABLE, 0, 0,
+                                cper->data_len, fru_id, 0);
+
+    /* Add CPER data */
+    for (i = 0; i < cper->data_len; i++) {
+        build_append_int_noprefix(block, cper->data[i], 1);
+    }
+
+    /* Write the generic error data entry into guest memory */
+    cpu_physical_memory_write(cper_addr, block->data, block->len);
+
+    g_array_free(block, true);
+
+    notifier_list_notify(&acpi_generic_error_notifiers, NULL);
+}
+
 bool acpi_ghes_present(void)
 {
     AcpiGedState *acpi_ged_state;
diff --git a/hw/acpi/ghes_cper.c b/hw/acpi/ghes_cper.c
index 7aa7e71e90dc..d7ff7debee74 100644
--- a/hw/acpi/ghes_cper.c
+++ b/hw/acpi/ghes_cper.c
@@ -39,7 +39,7 @@ void qmp_ghes_cper(CommonPlatformErrorRecord *qmp_cper,
         return;
     }
 
-    /* TODO: call a function at ghes */
+    ghes_record_cper_errors(&cper, errp, ACPI_GHES_NOTIFY_GPIO);
 
     g_free(cper.data);
 }
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 2fcfa1cc8090..5a7bdb08f8e2 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -79,6 +79,9 @@ typedef struct AcpiGhesCper {
     size_t data_len;
 } AcpiGhesCper;
 
+void ghes_record_cper_errors(AcpiGhesCper *cper, Error **errp,
+                             enum AcpiGhesNotifyType notify);
+
 /**
  * acpi_ghes_present: Report whether ACPI GHES table is present
  *
-- 
2.45.2


