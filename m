Return-Path: <linux-kernel+bounces-201813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 005198FC3C2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0CD4288B47
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 06:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2208418C32B;
	Wed,  5 Jun 2024 06:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b="S36yVREk"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB23818C345
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 06:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717569262; cv=none; b=JJOdUkSjzJjCCxyy8EYcXjjG8utGc5ces2cRb4ADz0BaFjVacTJIh4l7OlZ6GiraaP/exqUIxCRz2uevpW/yJaEV9CnJVubDhAcL0as9OYzXOS6DgVlHKeUDZrfRCCvWOEaEpnpNquSd+2XdmMSfPHjwcJ+anfuHGe7anbwVQDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717569262; c=relaxed/simple;
	bh=lhDXj1RB5ptV6uXT4ckCeg8oBkuwyd08q0QZzlPROxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NSWWBGhETQVEoEekHNs3+Mjpiz6rdvvoFPb/QHrtc+m4BUb0zpcJ/L/32vF2llPYT/LXcA4JFxcFGyJSzCo+JHpLfvkHthv1xjcWZkHdrl6toAWWCZTuBgJz+QSQPqW4d/n7jLth0Qu2q/Freb3duOWFfYlmAyrHgmz/QiMCfSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com; spf=pass smtp.mailfrom=jubnut.com; dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b=S36yVREk; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jubnut.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4VvHjv2k9xz9t1h;
	Wed,  5 Jun 2024 08:34:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jubnut.com; s=MBO0001;
	t=1717569251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=drjap9tia8UdmkKJqnXc1ZCFCy2/bIrsAH1vVPQ//D0=;
	b=S36yVREk5LH90meIPR5eibShC3SN6nQnRv4x2u/vwC51c3Lo9UDdb4ZIjfPrgzNV0mpevw
	oTGBTdA1/STkOJeMoYkvB/hldoOYTBiqd38o3vunmieoTYTr1eLQ6gIhAkuGDazkSUYQWn
	enRUQFX+E6VdURe+JRmPps+H9B6Sruk5j8+NW99xAGORbRHNX/GDrdQjKYJaVscnvqOZRL
	Tb0jYhdQMJ1nhNkt3XNIuwVa6MPzeCRi/9xKOwtzeq4WBk3Wd1Cw2S/DYC6EpMFf6BzKeX
	bcUMp66AgTdbRzdp3ErzcF6rijeDkYuDAIhrf2YdwO5q/6VVdxuxF8DJBJVrdg==
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
Subject: [PATCH v3 4/5] platform/chrome: cros_ec_lpc: Add a new quirk for AML mutex
Date: Wed,  5 Jun 2024 07:33:50 +0100
Message-ID: <20240605063351.14836-5-ben@jubnut.com>
In-Reply-To: <20240605063351.14836-1-ben@jubnut.com>
References: <20240605063351.14836-1-ben@jubnut.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new quirk "CROS_EC_LPC_QUIRK_AML_MUTEX" which provides the name
of an AML mutex to protect MEC memory access.

Signed-off-by: Ben Walsh <ben@jubnut.com>
---
 drivers/platform/chrome/cros_ec_lpc.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index fa6606da802a..5d9cc8df208b 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -44,6 +44,11 @@ static bool cros_ec_lpc_acpi_device_found;
  * the ACPI device.
  */
 #define CROS_EC_LPC_QUIRK_ACPI_ID                   BIT(1)
+/*
+ * Indicates that lpc_driver_data.quirk_aml_mutex_name should be used
+ * to find an AML mutex to protect access to Microchip EC.
+ */
+#define CROS_EC_LPC_QUIRK_AML_MUTEX                 BIT(2)
 
 /**
  * struct lpc_driver_data - driver data attached to a DMI device ID to indicate
@@ -52,11 +57,14 @@ static bool cros_ec_lpc_acpi_device_found;
  * @quirk_mmio_memory_base: The first I/O port addressing EC mapped memory (used
  *                          when quirk ...REMAP_MEMORY is set.)
  * @quirk_acpi_id: An ACPI HID to be used to find the ACPI device.
+ * @quirk_aml_mutex_name: The name of an AML mutex to be used to protect access
+ *                        to Microchip EC.
  */
 struct lpc_driver_data {
 	u32 quirks;
 	u16 quirk_mmio_memory_base;
 	const char *quirk_acpi_id;
+	const char *quirk_aml_mutex_name;
 };
 
 /**
@@ -482,6 +490,17 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
 			}
 			ACPI_COMPANION_SET(dev, adev);
 		}
+
+		if (quirks & CROS_EC_LPC_QUIRK_AML_MUTEX) {
+			const char *name
+				= driver_data->quirk_aml_mutex_name;
+			ret = cros_ec_lpc_mec_acpi_mutex(ACPI_COMPANION(dev), name);
+			if (ret) {
+				dev_err(dev, "failed to get AML mutex '%s'", name);
+				return ret;
+			}
+			dev_info(dev, "got AML mutex '%s'", name);
+		}
 	}
 
 	/*
-- 
2.45.1


