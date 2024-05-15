Return-Path: <linux-kernel+bounces-179482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3BF8C6059
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 07:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 477282828A5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 05:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E083EA7B;
	Wed, 15 May 2024 05:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b="Z4gXrivh"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA2D3BBEF
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 05:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715752610; cv=none; b=C6LQCMgmbUXC5wQRkt5wpextgDtfGlnnn0OyhWism4Mq0tI1UKB3pkbDUHJe1wEFPKA83yEM1npIHn5COlnQUG8RMgEfIvJxszQXBWzn8AWiK6BguJzq4zMI+gxNLuAnql1GZ6BUcH5wgidAGgjBB3Ozrv4F4NbXiDMM8RRTYyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715752610; c=relaxed/simple;
	bh=x0Ce6SNi7t9wumEB4tfAmXukeqbDL2EpNciA2Omy+sI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAoscJ6KHoZ62rABfHOVz29Gsd5mM0ZaM/OiGNR37R/QtVLZBW6oH6vM4Gaf6dLrSDwYtc2WkPjw7OBbETA0vojPVCsQzJDDCm63Nc0iUlfEKcW3fc+zxKb1B3PQ8rg1gfwbgGlh3GjzggMz80hwcCtT3fcv0qfmVslNDHhKynw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com; spf=pass smtp.mailfrom=jubnut.com; dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b=Z4gXrivh; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jubnut.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4VfMtK468Qz9srm;
	Wed, 15 May 2024 07:56:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jubnut.com; s=MBO0001;
	t=1715752601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VoL3zK3L1j4stcNJ2+pIA/oRroKbL5dxiIbE/+qQ8c8=;
	b=Z4gXrivhuTI1CBryzUlYqeX8xAFA1Ab2JDOcV+EYzO5NmhvmdVBr7DW/ouIQkMtVXry0/e
	pGPNRwfhi7GymDzjXA20UoqsB1WmD3xHRsuieYDQeZsT1o6yp8TlTTk9TPxxG6BNHH3wjf
	AgYKghYs/xzBs+1CE+JI+YCAvxRkeDe2udCgI1BctXUA+FU5obk24/T2fjbNHw+qKlIpLD
	38bQ5kJv7pEIBbDHGPC4umEQTwoODGtfyyhXW/eG5Xfd7fi+SQ5USTv5wIUJXNTmt8LBlc
	JuflCzffx6uKYl7w6stGAli58K906V9IKECTY76jaepjWUdNsnEHirj25AFjVA==
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
Subject: [PATCH 3/6] platform/chrome: cros_ec_lpc: Pass driver_data in static variable
Date: Wed, 15 May 2024 06:56:28 +0100
Message-ID: <20240515055631.5775-4-ben@jubnut.com>
In-Reply-To: <20240515055631.5775-1-ben@jubnut.com>
References: <20240515055631.5775-1-ben@jubnut.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4VfMtK468Qz9srm

The module init passed extra data to the driver via the driver_data of
a new platform device. But when an ACPI device already existed, no
platform device was created, so this extra data wasn't passed to the
driver.

Stop using the driver_data and use a static variable instead.

Signed-off-by: Ben Walsh <ben@jubnut.com>
---
 drivers/platform/chrome/cros_ec_lpc.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index e638c7d82e22..b27519fbdf58 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -76,6 +76,8 @@ struct lpc_driver_ops {
 
 static struct lpc_driver_ops cros_ec_lpc_ops = { };
 
+static const struct lpc_driver_data *cros_ec_lpc_driver_data;
+
 /*
  * A generic instance of the read function of struct lpc_driver_ops, used for
  * the LPC EC.
@@ -435,7 +437,6 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
 	acpi_status status;
 	struct cros_ec_device *ec_dev;
 	struct cros_ec_lpc *ec_lpc;
-	struct lpc_driver_data *driver_data;
 	u8 buf[2] = {};
 	int irq, ret;
 	u32 quirks;
@@ -446,15 +447,15 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
 
 	ec_lpc->mmio_memory_base = EC_LPC_ADDR_MEMMAP;
 
-	driver_data = platform_get_drvdata(pdev);
-	if (driver_data) {
-		quirks = driver_data->quirks;
+	if (cros_ec_lpc_driver_data) {
+		quirks = cros_ec_lpc_driver_data->quirks;
 
 		if (quirks)
 			dev_info(dev, "loaded with quirks %8.08x\n", quirks);
 
 		if (quirks & CROS_EC_LPC_QUIRK_REMAP_MEMORY)
-			ec_lpc->mmio_memory_base = driver_data->quirk_mmio_memory_base;
+			ec_lpc->mmio_memory_base
+				= cros_ec_lpc_driver_data->quirk_mmio_memory_base;
 	}
 
 	/*
@@ -735,7 +736,10 @@ static int __init cros_ec_lpc_init(void)
 
 	dmi_match = dmi_first_match(cros_ec_lpc_dmi_table);
 
-	if (!cros_ec_lpc_acpi_device_found && !dmi_match) {
+	if (dmi_match) {
+		/* Pass the DMI match's driver data down to the platform device */
+		cros_ec_lpc_driver_data = dmi_match->driver_data;
+	} else if (!cros_ec_lpc_acpi_device_found) {
 		pr_err(DRV_NAME ": unsupported system.\n");
 		return -ENODEV;
 	}
@@ -748,9 +752,6 @@ static int __init cros_ec_lpc_init(void)
 	}
 
 	if (!cros_ec_lpc_acpi_device_found) {
-		/* Pass the DMI match's driver data down to the platform device */
-		platform_set_drvdata(&cros_ec_lpc_device, dmi_match->driver_data);
-
 		/* Register the device, and it'll get hooked up automatically */
 		ret = platform_device_register(&cros_ec_lpc_device);
 		if (ret) {
-- 
2.45.0


