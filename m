Return-Path: <linux-kernel+bounces-179484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA588C605B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 07:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD4CEB21F98
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 05:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A67F446BD;
	Wed, 15 May 2024 05:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b="nV5ZNoCY"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392154175A
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 05:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715752613; cv=none; b=MXkftjV+P+9vuJAoL2k4gh8OL+xyVYic6bT+fjB/5qyf8nbYj58GH4loQJPO3DSfNiNNjUB9h7tVDaRf1bgMsIdNHZHm9tYG4kMsc3GQxXwHNEeSaTWAPkkUUEvao4EFCtoF+gR/ww9bbkie2sQpUZVi5fxqBFQKcBVVHMxX5/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715752613; c=relaxed/simple;
	bh=K+VP68HCvfFFdGmWMTrvq+V5aUwfknlhvQc7PiWu+Ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SYoEFhkAf7rUhnCO2iQ6karFORw24Lh/BDf2FDOvGBjluMO65zF76POdEYINVFhDRtWZNYYd9Jgnzbjr6LVe4q8TxVFdT/PO+ESRq2yDyY4rQEMFF7sxvNYWTBpqbDtKx0k9hRNn3Cesu417w8q9sIO8uxSF24ttZb7uKbh+IdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com; spf=pass smtp.mailfrom=jubnut.com; dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b=nV5ZNoCY; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jubnut.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4VfMtP0kd1z9sdZ;
	Wed, 15 May 2024 07:56:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jubnut.com; s=MBO0001;
	t=1715752605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P92v+w98Jljb+c9QhFtRBSt+CRxl2epw8ENibcEK1wM=;
	b=nV5ZNoCYd4EMV2Gmgs75jYWwJ7Ddai/pv4xPc97gPRopDvdunCy2o7w1/bCHza4xnoAhnc
	xSklzX8hl0PVLylhZy7zlVuD2tdPdao8chiAee8z5r8+4yg2r1j7kp9FW4mb4xsHwXg6mr
	mZHllbuUBalb0x5wqBhGKjMyYa8lHx7Ii5GucjKR9j9ilFqCwskwBOWHdev8bb4FVRHCMI
	obe+/NIFgLrCECg0eDymVKq8gp25VvXsoB+MKBdG6uu/DMeDUM5trTDMg/FG2hVgDLnUWJ
	Dy8w6cWc8qaVIM9Zuca201R9nW+Tuc3hgI8ZiZKDBM1JqovhUJ8Ig+NuKdSluA==
From: Ben Walsh <ben@jubnut.com>
To: Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	"Dustin L. Howett" <dustin@howett.net>,
	Kieran Levin <ktl@frame.work>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Mario Limonciello <mario.limonciello@amd.com>,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Ben Walsh <ben@jubnut.com>
Subject: [PATCH 5/6] platform/chrome: cros_ec_lpc: Correct ACPI name for Framework Laptop
Date: Wed, 15 May 2024 06:56:30 +0100
Message-ID: <20240515055631.5775-6-ben@jubnut.com>
In-Reply-To: <20240515055631.5775-1-ben@jubnut.com>
References: <20240515055631.5775-1-ben@jubnut.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Framework Laptops' ACPI exposes the EC as name "PNP0C09". Use this to
find the device. This makes it easy to find the AML mutex via the
ACPI_COMPANION device.

The name "PNP0C09" is part of the ACPI standard, not Chrome-specific,
so only recognise the device if the DMI data is recognised too.

Signed-off-by: Ben Walsh <ben@jubnut.com>
---
 drivers/platform/chrome/cros_ec_lpc.c | 38 ++++++++++++++++-----------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index ab7779b57a13..a9200f0a1a37 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -29,10 +29,12 @@
 #include "cros_ec_lpc_mec.h"
 
 #define DRV_NAME "cros_ec_lpcs"
-#define ACPI_DRV_NAME "GOOG0004"
 
-/* True if ACPI device is present */
-static bool cros_ec_lpc_acpi_device_found;
+/*
+ * Index into cros_ec_lpc_acpi_device_ids of ACPI device,
+ * negative for ACPI device not found.
+ */
+static int cros_ec_lpc_acpi_device_found;
 
 /*
  * Indicates that lpc_driver_data.quirk_mmio_memory_base should
@@ -598,7 +600,8 @@ static void cros_ec_lpc_remove(struct platform_device *pdev)
 }
 
 static const struct acpi_device_id cros_ec_lpc_acpi_device_ids[] = {
-	{ ACPI_DRV_NAME, 0 },
+	{ "PNP0C09", 0 },    /* Standard ACPI EC name. Must be first in list */
+	{ "GOOG0004", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, cros_ec_lpc_acpi_device_ids);
@@ -737,30 +740,33 @@ static struct platform_device cros_ec_lpc_device = {
 	.name = DRV_NAME
 };
 
-static acpi_status cros_ec_lpc_parse_device(acpi_handle handle, u32 level,
-					    void *context, void **retval)
+static int cros_ec_lpc_find_acpi_dev(const struct acpi_device_id *acpi_ids)
 {
-	*(bool *)context = true;
-	return AE_CTRL_TERMINATE;
+	int i;
+
+	for (i = 0; acpi_ids[i].id[0]; ++i) {
+		if (acpi_dev_present(acpi_ids[i].id, NULL, -1))
+			return i;
+	}
+
+	return -1;
 }
 
 static int __init cros_ec_lpc_init(void)
 {
 	int ret;
-	acpi_status status;
 	const struct dmi_system_id *dmi_match;
 
-	status = acpi_get_devices(ACPI_DRV_NAME, cros_ec_lpc_parse_device,
-				  &cros_ec_lpc_acpi_device_found, NULL);
-	if (ACPI_FAILURE(status))
-		pr_warn(DRV_NAME ": Looking for %s failed\n", ACPI_DRV_NAME);
+	cros_ec_lpc_acpi_device_found = cros_ec_lpc_find_acpi_dev(
+		cros_ec_lpc_driver.driver.acpi_match_table);
 
 	dmi_match = dmi_first_match(cros_ec_lpc_dmi_table);
 
 	if (dmi_match) {
 		/* Pass the DMI match's driver data down to the platform device */
 		cros_ec_lpc_driver_data = dmi_match->driver_data;
-	} else if (!cros_ec_lpc_acpi_device_found) {
+	} else if (cros_ec_lpc_acpi_device_found <= 0) {
+		/* Standard EC "PNP0C09" not supported without DMI data */
 		pr_err(DRV_NAME ": unsupported system.\n");
 		return -ENODEV;
 	}
@@ -772,7 +778,7 @@ static int __init cros_ec_lpc_init(void)
 		return ret;
 	}
 
-	if (!cros_ec_lpc_acpi_device_found) {
+	if (cros_ec_lpc_acpi_device_found < 0) {
 		/* Register the device, and it'll get hooked up automatically */
 		ret = platform_device_register(&cros_ec_lpc_device);
 		if (ret) {
@@ -786,7 +792,7 @@ static int __init cros_ec_lpc_init(void)
 
 static void __exit cros_ec_lpc_exit(void)
 {
-	if (!cros_ec_lpc_acpi_device_found)
+	if (cros_ec_lpc_acpi_device_found < 0)
 		platform_device_unregister(&cros_ec_lpc_device);
 	platform_driver_unregister(&cros_ec_lpc_driver);
 }
-- 
2.45.0


