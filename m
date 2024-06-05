Return-Path: <linux-kernel+bounces-201811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 063E18FC3C0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B2831C252F5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 06:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F705763F8;
	Wed,  5 Jun 2024 06:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b="x3XEhvDE"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71AA19046F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 06:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717569254; cv=none; b=vDeL0rBDoLmwMRdEyCsKxrvUWGcrBKBrM8JIepcHrKXYJ8ldPdwe8WRMQkJ/YIftuTxmVHqYpzk+KDjKnmNtOwzhjZPZMNe4g/eQ5OZ3YBrNXxcZhQqRXvSkJffZl/CpYkQOzIyVFB35H5p6b+MBI6ymaSmaC2as1qf30aVfj2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717569254; c=relaxed/simple;
	bh=PQEeKXfOM51bNYl7DoVRfJl+cIvwgdZuLjkHjzjiMPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=diFFdwp7MZ3H9pmlMGssfZEikrMndMo5RL7MUQoMgtFQydQUalAn4Pout91QqLLSuboh1jzuWj7xGgUgZGtfKDR7WI1Xj+QYT4vplK9yoKKozF/fd9q3OmlZb1c8WV5y5HoIE/DdZx0hl2KV8AtWWv8fZjvVzt6NbA7RZ313Tdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com; spf=pass smtp.mailfrom=jubnut.com; dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b=x3XEhvDE; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jubnut.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4VvHjs3sWDz9sv0;
	Wed,  5 Jun 2024 08:34:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jubnut.com; s=MBO0001;
	t=1717569249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T3J2wtEYzEfGFdjBljjkZ5VjfAdF2JeuvVcugebR2hw=;
	b=x3XEhvDE3Z9VBTvEa82RCRhGxqgqB5GabcJ8Cf/rCXmI0MBJHq7+oCyUURqojwSRTMTmVi
	zHO3xsSdHO9arDxzRBao76ax6KU+xMhYSK0y6tC79qtinFPV4UNMyKWg5JmGUmgu3vCWYi
	rJPrYRgQZ9iAA7IbM8g53QAbCfaA5GZe5It2MCKrYnuftoBEWvvgnOa67iyxhJ+QhZts8L
	uYsNZ8quJ05z9YYH+e0b9NPLes6dC6JwEVez85bLo2Nw1K/B6LMFEXrqsrdn+G0ka3YCGE
	7Xp402+E39nxkZVWaMXGqExf6WecsBQivmRtV7vhvc2Wj/MHxul6jOwpw62YiA==
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
Subject: [PATCH v3 3/5] platform/chrome: cros_ec_lpc: Add a new quirk for ACPI id
Date: Wed,  5 Jun 2024 07:33:49 +0100
Message-ID: <20240605063351.14836-4-ben@jubnut.com>
In-Reply-To: <20240605063351.14836-1-ben@jubnut.com>
References: <20240605063351.14836-1-ben@jubnut.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4VvHjs3sWDz9sv0

Framework Laptops' ACPI exposes the EC with id "PNP0C09". But
"PNP0C09" is part of the ACPI standard; there are lots of computers
with EC chips with this id, and most of them don't support the cros_ec
protocol.

The driver could find the ACPI device by having "PNP0C09" in the
acpi_match_table, but this would match devices which don't support the
cros_ec protocol. Instead, add a new quirk "CROS_EC_LPC_QUIRK_ACPI_ID"
which allows the id to be specified. This quirk is applied after the
DMI check shows that the device is supported.

Signed-off-by: Ben Walsh <ben@jubnut.com>
---
 drivers/platform/chrome/cros_ec_lpc.c | 50 ++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 7bf13c1d2c67..fa6606da802a 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -39,6 +39,11 @@ static bool cros_ec_lpc_acpi_device_found;
  * be used as the base port for EC mapped memory.
  */
 #define CROS_EC_LPC_QUIRK_REMAP_MEMORY              BIT(0)
+/*
+ * Indicates that lpc_driver_data.quirk_acpi_id should be used to find
+ * the ACPI device.
+ */
+#define CROS_EC_LPC_QUIRK_ACPI_ID                   BIT(1)
 
 /**
  * struct lpc_driver_data - driver data attached to a DMI device ID to indicate
@@ -46,10 +51,12 @@ static bool cros_ec_lpc_acpi_device_found;
  * @quirks: a bitfield composed of quirks from CROS_EC_LPC_QUIRK_*
  * @quirk_mmio_memory_base: The first I/O port addressing EC mapped memory (used
  *                          when quirk ...REMAP_MEMORY is set.)
+ * @quirk_acpi_id: An ACPI HID to be used to find the ACPI device.
  */
 struct lpc_driver_data {
 	u32 quirks;
 	u16 quirk_mmio_memory_base;
+	const char *quirk_acpi_id;
 };
 
 /**
@@ -418,6 +425,26 @@ static void cros_ec_lpc_acpi_notify(acpi_handle device, u32 value, void *data)
 		pm_system_wakeup();
 }
 
+static acpi_status cros_ec_lpc_parse_device(acpi_handle handle, u32 level,
+					    void *context, void **retval)
+{
+	*(struct acpi_device **)context = acpi_fetch_acpi_dev(handle);
+	return AE_CTRL_TERMINATE;
+}
+
+static struct acpi_device *cros_ec_lpc_get_device(const char *id)
+{
+	struct acpi_device *adev = NULL;
+	acpi_status status = acpi_get_devices(id, cros_ec_lpc_parse_device,
+					      &adev, NULL);
+	if (ACPI_FAILURE(status)) {
+		pr_warn(DRV_NAME ": Looking for %s failed\n", id);
+		return NULL;
+	}
+
+	return adev;
+}
+
 static int cros_ec_lpc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -445,6 +472,16 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
 
 		if (quirks & CROS_EC_LPC_QUIRK_REMAP_MEMORY)
 			ec_lpc->mmio_memory_base = driver_data->quirk_mmio_memory_base;
+
+		if (quirks & CROS_EC_LPC_QUIRK_ACPI_ID) {
+			adev = cros_ec_lpc_get_device(driver_data->quirk_acpi_id);
+			if (!adev) {
+				dev_err(dev, "failed to get ACPI device '%s'",
+					driver_data->quirk_acpi_id);
+				return -ENODEV;
+			}
+			ACPI_COMPANION_SET(dev, adev);
+		}
 	}
 
 	/*
@@ -709,23 +746,12 @@ static struct platform_device cros_ec_lpc_device = {
 	.name = DRV_NAME
 };
 
-static acpi_status cros_ec_lpc_parse_device(acpi_handle handle, u32 level,
-					    void *context, void **retval)
-{
-	*(bool *)context = true;
-	return AE_CTRL_TERMINATE;
-}
-
 static int __init cros_ec_lpc_init(void)
 {
 	int ret;
-	acpi_status status;
 	const struct dmi_system_id *dmi_match;
 
-	status = acpi_get_devices(ACPI_DRV_NAME, cros_ec_lpc_parse_device,
-				  &cros_ec_lpc_acpi_device_found, NULL);
-	if (ACPI_FAILURE(status))
-		pr_warn(DRV_NAME ": Looking for %s failed\n", ACPI_DRV_NAME);
+	cros_ec_lpc_acpi_device_found = !!cros_ec_lpc_get_device(ACPI_DRV_NAME);
 
 	dmi_match = dmi_first_match(cros_ec_lpc_dmi_table);
 
-- 
2.45.1


