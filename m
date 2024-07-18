Return-Path: <linux-kernel+bounces-256086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 582A79348C8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0B4E1F21032
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 07:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7A778C8E;
	Thu, 18 Jul 2024 07:28:06 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BEA770E5;
	Thu, 18 Jul 2024 07:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721287685; cv=none; b=cr1FaK5A5JkSolZ5fMtOCJB+TjZln2dxVMZkVSN+4/KeN9qMOi7xcFyVg4p0VCe0PzWebXWrvautL+o80fi5SV9KMn8pDEPJZiwt3LwqfUQj6US/1pdRL6u5shrB9nb2OzWGCKa0RLRr8wUKr8wWfWnlIBh3Rr0C+LkB+6EnI/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721287685; c=relaxed/simple;
	bh=KDF/DC7JiIUOwFN1Vd8dUQhSAM3Xx+hQUlid0gBx8so=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HWnVNa+iXC1mOy2EqtKbFfaUS28B5PyldYEMzMzQP/Qb/DgtNoQUcZWpexQSW4HYK1dAH7qrUoR63sCwrYSQAEj7gYDDOJjS7X8MY/Hw7NGNTeD8lvRMbwzXd7TZc96/MAjiPZAoP8lKH84IWY1ABHTXS+9/wl6YVnK17TfugCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.. (netacc-gpn-104-115-214.pool.yettel.hu [::ffff:91.104.115.214])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000072DC6.000000006698C400.00180BB3; Thu, 18 Jul 2024 09:28:00 +0200
From: Gergo Koteles <soyer@irl.hu>
To: Hans de Goede <hdegoede@redhat.com>,
  =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
  Ike Panhc <ike.pan@canonical.com>
Cc: platform-driver-x86@vger.kernel.org,
  linux-kernel@vger.kernel.org, Gergo Koteles <soyer@irl.hu>
Subject: [PATCH v2 2/4] platform/x86: ideapad-laptop: move ymc_trigger_ec from lenovo-ymc
Date: Thu, 18 Jul 2024 09:27:14 +0200
Message-ID: <8c90b1b6d7be7d80650568975d79ef35d18e551c.1721258854.git.soyer@irl.hu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1721258854.git.soyer@irl.hu>
References: <cover.1721258854.git.soyer@irl.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

Some models need to trigger the EC after each YMC event for the yoga
mode control to work properly. EC triggering consist of a VPC call from
the lenovo-ymc module. Except for this, all VPC calls are in the
ideapad-laptop module.

Since ideapad-laptop has a notification chain, a new YMC_EVENT action
can be added and triggered from the lenovo-ymc module. Then the
ideapad-laptop can trigger the EC.

If the triggering is in the ideapad-laptop module, then the ec_trigger
module parameter should be there as well.

Move the ymc_trigger_ec functionality and the ec_trigger module
parameter to the ideapad-laptop module.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 drivers/platform/x86/Kconfig          |  1 +
 drivers/platform/x86/ideapad-laptop.c | 49 ++++++++++++++++++++++
 drivers/platform/x86/ideapad-laptop.h |  4 ++
 drivers/platform/x86/lenovo-ymc.c     | 60 +--------------------------
 4 files changed, 56 insertions(+), 58 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 6dbd40e2aeda..4af0a060cd47 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -464,6 +464,7 @@ config LENOVO_YMC
 	tristate "Lenovo Yoga Tablet Mode Control"
 	depends on ACPI_WMI
 	depends on INPUT
+	depends on IDEAPAD_LAPTOP
 	select INPUT_SPARSEKMAP
 	help
 	  This driver maps the Tablet Mode Control switch to SW_TABLET_MODE input
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index e4d32a788339..1d61bd921528 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -145,6 +145,7 @@ struct ideapad_private {
 		bool touchpad_ctrl_via_ec : 1;
 		bool ctrl_ps2_aux_port    : 1;
 		bool usb_charging         : 1;
+		bool ymc_ec_trigger       : 1;
 	} features;
 	struct {
 		bool initialized;
@@ -188,6 +189,12 @@ MODULE_PARM_DESC(touchpad_ctrl_via_ec,
 	"Enable registering a 'touchpad' sysfs-attribute which can be used to manually "
 	"tell the EC to enable/disable the touchpad. This may not work on all models.");
 
+static bool ymc_ec_trigger __read_mostly;
+module_param(ymc_ec_trigger, bool, 0444);
+MODULE_PARM_DESC(ymc_ec_trigger,
+	"Enable EC triggering work-around to force emitting tablet mode events. "
+	"If you need this please report this to: platform-driver-x86@vger.kernel.org");
+
 /*
  * shared data
  */
@@ -1498,10 +1505,50 @@ static void ideapad_sync_touchpad_state(struct ideapad_private *priv, bool send_
 	priv->r_touchpad_val = value;
 }
 
+static const struct dmi_system_id ymc_ec_trigger_quirk_dmi_table[] = {
+	{
+		/* Lenovo Yoga 7 14ARB7 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82QF"),
+		},
+	},
+	{
+		/* Lenovo Yoga 7 14ACN6 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82N7"),
+		},
+	},
+	{ }
+};
+
+static void ideapad_laptop_trigger_ec(void)
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
+	if (!priv->features.ymc_ec_trigger)
+		return;
+
+	ret = write_ec_cmd(priv->adev->handle, VPCCMD_W_YMC, 1);
+	if (ret)
+		dev_warn(&priv->platform_device->dev, "Could not write YMC: %d\n", ret);
+}
+
 static int ideapad_laptop_nb_notify(struct notifier_block *nb,
 				    unsigned long action, void *data)
 {
 	switch (action) {
+	case IDEAPAD_LAPTOP_YMC_EVENT:
+		ideapad_laptop_trigger_ec();
+		break;
 	}
 
 	return 0;
@@ -1667,6 +1714,8 @@ static void ideapad_check_features(struct ideapad_private *priv)
 	priv->features.ctrl_ps2_aux_port =
 		ctrl_ps2_aux_port || dmi_check_system(ctrl_ps2_aux_port_list);
 	priv->features.touchpad_ctrl_via_ec = touchpad_ctrl_via_ec;
+	priv->features.ymc_ec_trigger =
+		ymc_ec_trigger || dmi_check_system(ymc_ec_trigger_quirk_dmi_table);
 
 	if (!read_ec_data(handle, VPCCMD_R_FAN, &val))
 		priv->features.fan_mode = true;
diff --git a/drivers/platform/x86/ideapad-laptop.h b/drivers/platform/x86/ideapad-laptop.h
index 3eb0dcd6bf7b..948cc61800a9 100644
--- a/drivers/platform/x86/ideapad-laptop.h
+++ b/drivers/platform/x86/ideapad-laptop.h
@@ -14,6 +14,10 @@
 #include <linux/errno.h>
 #include <linux/notifier.h>
 
+enum ideapad_laptop_notifier_actions {
+	IDEAPAD_LAPTOP_YMC_EVENT,
+};
+
 int ideapad_laptop_register_notifier(struct notifier_block *nb);
 int ideapad_laptop_unregister_notifier(struct notifier_block *nb);
 void ideapad_laptop_call_notifier(unsigned long action, void *data);
diff --git a/drivers/platform/x86/lenovo-ymc.c b/drivers/platform/x86/lenovo-ymc.c
index e1fbc35504d4..e0bbd6a14a89 100644
--- a/drivers/platform/x86/lenovo-ymc.c
+++ b/drivers/platform/x86/lenovo-ymc.c
@@ -20,32 +20,10 @@
 #define LENOVO_YMC_QUERY_INSTANCE 0
 #define LENOVO_YMC_QUERY_METHOD 0x01
 
-static bool ec_trigger __read_mostly;
-module_param(ec_trigger, bool, 0444);
-MODULE_PARM_DESC(ec_trigger, "Enable EC triggering work-around to force emitting tablet mode events");
-
 static bool force;
 module_param(force, bool, 0444);
 MODULE_PARM_DESC(force, "Force loading on boards without a convertible DMI chassis-type");
 
-static const struct dmi_system_id ec_trigger_quirk_dmi_table[] = {
-	{
-		/* Lenovo Yoga 7 14ARB7 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "82QF"),
-		},
-	},
-	{
-		/* Lenovo Yoga 7 14ACN6 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "82N7"),
-		},
-	},
-	{ }
-};
-
 static const struct dmi_system_id allowed_chasis_types_dmi_table[] = {
 	{
 		.matches = {
@@ -62,21 +40,8 @@ static const struct dmi_system_id allowed_chasis_types_dmi_table[] = {
 
 struct lenovo_ymc_private {
 	struct input_dev *input_dev;
-	struct acpi_device *ec_acpi_dev;
 };
 
-static void lenovo_ymc_trigger_ec(struct wmi_device *wdev, struct lenovo_ymc_private *priv)
-{
-	int err;
-
-	if (!priv->ec_acpi_dev)
-		return;
-
-	err = write_ec_cmd(priv->ec_acpi_dev->handle, VPCCMD_W_YMC, 1);
-	if (err)
-		dev_warn(&wdev->dev, "Could not write YMC: %d\n", err);
-}
-
 static const struct key_entry lenovo_ymc_keymap[] = {
 	/* Laptop */
 	{ KE_SW, 0x01, { .sw = { SW_TABLET_MODE, 0 } } },
@@ -125,11 +90,9 @@ static void lenovo_ymc_notify(struct wmi_device *wdev, union acpi_object *data)
 
 free_obj:
 	kfree(obj);
-	lenovo_ymc_trigger_ec(wdev, priv);
+	ideapad_laptop_call_notifier(IDEAPAD_LAPTOP_YMC_EVENT, &code);
 }
 
-static void acpi_dev_put_helper(void *p) { acpi_dev_put(p); }
-
 static int lenovo_ymc_probe(struct wmi_device *wdev, const void *ctx)
 {
 	struct lenovo_ymc_private *priv;
@@ -143,29 +106,10 @@ static int lenovo_ymc_probe(struct wmi_device *wdev, const void *ctx)
 			return -ENODEV;
 	}
 
-	ec_trigger |= dmi_check_system(ec_trigger_quirk_dmi_table);
-
 	priv = devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
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
@@ -192,7 +136,6 @@ static int lenovo_ymc_probe(struct wmi_device *wdev, const void *ctx)
 	dev_set_drvdata(&wdev->dev, priv);
 
 	/* Report the state for the first time on probe */
-	lenovo_ymc_trigger_ec(wdev, priv);
 	lenovo_ymc_notify(wdev, NULL);
 	return 0;
 }
@@ -217,3 +160,4 @@ module_wmi_driver(lenovo_ymc_driver);
 MODULE_AUTHOR("Gergo Koteles <soyer@irl.hu>");
 MODULE_DESCRIPTION("Lenovo Yoga Mode Control driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IDEAPAD_LAPTOP);
-- 
2.45.2


