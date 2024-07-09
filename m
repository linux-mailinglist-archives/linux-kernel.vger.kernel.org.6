Return-Path: <linux-kernel+bounces-245536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3123A92B40B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 689DA2841A4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27855156243;
	Tue,  9 Jul 2024 09:38:36 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3852155744;
	Tue,  9 Jul 2024 09:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720517915; cv=none; b=npaL2bfZhMVKG3BDYVYzEfDwKfQoIi6Y0r9ZpDIm4RL89oTF/dYxC3NrZkPeXecNz54WbNvGeEEcqLrQqZ01u6TNZ+cADmee++yJwRTOhk1iThOpLMmkxrA1TQL3mWqIhve59ntsIra/N+BcrZZsb79HUefVJiisV19FTLbgIpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720517915; c=relaxed/simple;
	bh=ieoo/lVHCu8KAhAXa5Ty3rQ2sLP5tN2rUtGDpHKZRZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version:Content-Type; b=vF6iY+nsJU93uZ8kyH/PG2zn49qR49F2dktv5fPpZRfknADp7enTXtw7qspsneIACJWcL7pJOs3eFlDGhJb9u1sdNvCyj9NgvFs/4pJGUopPFDMCyJgQfLIHDg5dZvlIKZzimHud8mRGpjzNCkXcgBBcAwJsBuxqQCFSpSw23yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b693a1.dsl.pool.telekom.hu [::ffff:81.182.147.161])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000071EC8.00000000668D03E4.0016EC84; Tue, 09 Jul 2024 11:33:24 +0200
From: Gergo Koteles <soyer@irl.hu>
To: Hans de Goede <hdegoede@redhat.com>,
  =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
  Ike Panhc <ike.pan@canonical.com>
Cc: platform-driver-x86@vger.kernel.org,
  linux-kernel@vger.kernel.org, Gergo Koteles <soyer@irl.hu>
Subject: [PATCH 3/4] platform/x86: ideapad-laptop: move ymc_trigger_ec from lenovo-ymc
Date: Tue,  9 Jul 2024 11:33:07 +0200
Message-ID: <44f63dfa758c811ae941216874fbb1ec77f4a293.1720515666.git.soyer@irl.hu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720515666.git.soyer@irl.hu>
References: <cover.1720515666.git.soyer@irl.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

Some models need to trigger the EC for the yoga mode control to work
properly. EC triggering consists of a VPC call that needs to be
synchronized. The vpc_mutex is in the ideapad-laptop module, so
synchronization is easier there.

Move the ymc_trigger_ec function to the ideapad-laptop module.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 drivers/platform/x86/Kconfig          |  1 +
 drivers/platform/x86/ideapad-laptop.c | 18 ++++++++++++++
 drivers/platform/x86/ideapad-laptop.h |  2 ++
 drivers/platform/x86/lenovo-ymc.c     | 34 ++++-----------------------
 4 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 665fa9524986..ddfccc226751 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -477,6 +477,7 @@ config LENOVO_YMC
 	tristate "Lenovo Yoga Tablet Mode Control"
 	depends on ACPI_WMI
 	depends on INPUT
+	depends on IDEAPAD_LAPTOP
 	select INPUT_SPARSEKMAP
 	help
 	  This driver maps the Tablet Mode Control switch to SW_TABLET_MODE input
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 464cc5fd0088..4dcdbb153dda 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1615,6 +1615,24 @@ static void ideapad_sync_touchpad_state(struct ideapad_private *priv, bool send_
 	priv->r_touchpad_val = value;
 }
 
+void ideapad_ymc_trigger_ec(void)
+{
+	struct ideapad_private *priv;
+	int ret;
+
+	guard(mutex)(&ideapad_shared_mutex);
+
+	priv = ideapad_shared;
+	if (!priv)
+		return;
+
+	scoped_guard(mutex, &priv->vpc_mutex)
+		ret = write_ec_cmd(priv->adev->handle, VPCCMD_W_YMC, 1);
+	if (ret)
+		dev_warn(&priv->platform_device->dev, "Could not write YMC: %d\n", ret);
+}
+EXPORT_SYMBOL_GPL(ideapad_ymc_trigger_ec);
+
 static void ideapad_acpi_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct ideapad_private *priv = data;
diff --git a/drivers/platform/x86/ideapad-laptop.h b/drivers/platform/x86/ideapad-laptop.h
index 4498a96de597..4dcbed842b0b 100644
--- a/drivers/platform/x86/ideapad-laptop.h
+++ b/drivers/platform/x86/ideapad-laptop.h
@@ -13,6 +13,8 @@
 #include <linux/jiffies.h>
 #include <linux/errno.h>
 
+void ideapad_ymc_trigger_ec(void);
+
 enum {
 	VPCCMD_R_VPC1 = 0x10,
 	VPCCMD_R_BL_MAX,
diff --git a/drivers/platform/x86/lenovo-ymc.c b/drivers/platform/x86/lenovo-ymc.c
index e1fbc35504d4..0819e9823ca9 100644
--- a/drivers/platform/x86/lenovo-ymc.c
+++ b/drivers/platform/x86/lenovo-ymc.c
@@ -62,19 +62,14 @@ static const struct dmi_system_id allowed_chasis_types_dmi_table[] = {
 
 struct lenovo_ymc_private {
 	struct input_dev *input_dev;
-	struct acpi_device *ec_acpi_dev;
 };
 
-static void lenovo_ymc_trigger_ec(struct wmi_device *wdev, struct lenovo_ymc_private *priv)
+static void lenovo_ymc_trigger_ec(void)
 {
-	int err;
-
-	if (!priv->ec_acpi_dev)
+	if (!ec_trigger)
 		return;
 
-	err = write_ec_cmd(priv->ec_acpi_dev->handle, VPCCMD_W_YMC, 1);
-	if (err)
-		dev_warn(&wdev->dev, "Could not write YMC: %d\n", err);
+	ideapad_ymc_trigger_ec();
 }
 
 static const struct key_entry lenovo_ymc_keymap[] = {
@@ -125,11 +120,9 @@ static void lenovo_ymc_notify(struct wmi_device *wdev, union acpi_object *data)
 
 free_obj:
 	kfree(obj);
-	lenovo_ymc_trigger_ec(wdev, priv);
+	lenovo_ymc_trigger_ec();
 }
 
-static void acpi_dev_put_helper(void *p) { acpi_dev_put(p); }
-
 static int lenovo_ymc_probe(struct wmi_device *wdev, const void *ctx)
 {
 	struct lenovo_ymc_private *priv;
@@ -149,23 +142,6 @@ static int lenovo_ymc_probe(struct wmi_device *wdev, const void *ctx)
 	if (!priv)
 		return -ENOMEM;
 
-	if (ec_trigger) {
-		pr_debug("Lenovo YMC enable EC triggering.\n");
-		priv->ec_acpi_dev = acpi_dev_get_first_match_dev("VPC2004", NULL, -1);
-
-		if (!priv->ec_acpi_dev) {
-			dev_err(&wdev->dev, "Could not find EC ACPI device.\n");
-			return -ENODEV;
-		}
-		err = devm_add_action_or_reset(&wdev->dev,
-				acpi_dev_put_helper, priv->ec_acpi_dev);
-		if (err) {
-			dev_err(&wdev->dev,
-				"Could not clean up EC ACPI device: %d\n", err);
-			return err;
-		}
-	}
-
 	input_dev = devm_input_allocate_device(&wdev->dev);
 	if (!input_dev)
 		return -ENOMEM;
@@ -192,7 +168,7 @@ static int lenovo_ymc_probe(struct wmi_device *wdev, const void *ctx)
 	dev_set_drvdata(&wdev->dev, priv);
 
 	/* Report the state for the first time on probe */
-	lenovo_ymc_trigger_ec(wdev, priv);
+	lenovo_ymc_trigger_ec();
 	lenovo_ymc_notify(wdev, NULL);
 	return 0;
 }
-- 
2.45.2


