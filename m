Return-Path: <linux-kernel+bounces-256088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDF49348CC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AB2FB22249
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 07:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8D9770E5;
	Thu, 18 Jul 2024 07:28:08 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0842078C88;
	Thu, 18 Jul 2024 07:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721287688; cv=none; b=bcuLWPu7FxqUeLdUBiFEiT/yJ+87fFvbTLTKDLe3eoVgtXIEq8rEt5UYUjelyblcYD1qYtdF01su3Ux2ZsVLUhKf/QdVaxtGNBr8VMzeJ7/9ZZoptsCwKquQA7LvF22Ea2JKeBTzebzpaxIaDcsS5LwLlrBQIlu7IEIx7LWsZqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721287688; c=relaxed/simple;
	bh=IR3xmB7CA+9p9w5sMuZmWGr9nM1s91Aps+vLK2fG6gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JUCL7ZVaAoEpl6CJVBME32CEdzlN/ZAa0AVVKN4XziKejQ89YZT5m8QkN4j92mqdw1/zUEAcYWY5KH0dxm4s2PkbdtRwiVptBCjOgGJ7vApwAzyVrD3fF2U5w2FYwdrzsUFrCsxVOiXPcVueBaxAamFaVXaY7EFVg1fxjzC6Nwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.. (netacc-gpn-104-115-214.pool.yettel.hu [::ffff:91.104.115.214])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000072DD0.000000006698C404.00180BC3; Thu, 18 Jul 2024 09:28:04 +0200
From: Gergo Koteles <soyer@irl.hu>
To: Hans de Goede <hdegoede@redhat.com>,
  =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
  Ike Panhc <ike.pan@canonical.com>
Cc: platform-driver-x86@vger.kernel.org,
  linux-kernel@vger.kernel.org, Gergo Koteles <soyer@irl.hu>
Subject: [PATCH v2 4/4] platform/x86: ideapad-laptop: add a mutex to synchronize VPC commands
Date: Thu, 18 Jul 2024 09:27:16 +0200
Message-ID: <70d3957b315815085cdd8cb04b002cdb4a372ddc.1721258854.git.soyer@irl.hu>
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

Calling VPC commands consists of several VPCW and VPCR ACPI calls.
These calls and their results can get mixed up if they are called
simultaneously from different threads, like acpi notify handler,
sysfs, debugfs, notification chain.

Add a mutex to synchronize VPC commands.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 drivers/platform/x86/ideapad-laptop.c | 62 +++++++++++++++++++--------
 1 file changed, 45 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 66b34e99147e..d2e7dd5027b8 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -154,6 +154,7 @@ struct ideapad_rfk_priv {
 
 struct ideapad_private {
 	struct acpi_device *adev;
+	struct mutex vpc_mutex; /* protects the VPC calls */
 	struct rfkill *rfk[IDEAPAD_RFKILL_DEV_NUM];
 	struct ideapad_rfk_priv rfk_priv[IDEAPAD_RFKILL_DEV_NUM];
 	struct platform_device *platform_device;
@@ -435,6 +436,8 @@ static int debugfs_status_show(struct seq_file *s, void *data)
 	struct ideapad_private *priv = s->private;
 	unsigned long value;
 
+	guard(mutex)(&priv->vpc_mutex);
+
 	if (!read_ec_data(priv->adev->handle, VPCCMD_R_BL_MAX, &value))
 		seq_printf(s, "Backlight max:  %lu\n", value);
 	if (!read_ec_data(priv->adev->handle, VPCCMD_R_BL, &value))
@@ -553,7 +556,8 @@ static ssize_t camera_power_show(struct device *dev,
 	unsigned long result;
 	int err;
 
-	err = read_ec_data(priv->adev->handle, VPCCMD_R_CAMERA, &result);
+	scoped_guard(mutex, &priv->vpc_mutex)
+		err = read_ec_data(priv->adev->handle, VPCCMD_R_CAMERA, &result);
 	if (err)
 		return err;
 
@@ -572,7 +576,8 @@ static ssize_t camera_power_store(struct device *dev,
 	if (err)
 		return err;
 
-	err = write_ec_cmd(priv->adev->handle, VPCCMD_W_CAMERA, state);
+	scoped_guard(mutex, &priv->vpc_mutex)
+		err = write_ec_cmd(priv->adev->handle, VPCCMD_W_CAMERA, state);
 	if (err)
 		return err;
 
@@ -625,7 +630,8 @@ static ssize_t fan_mode_show(struct device *dev,
 	unsigned long result;
 	int err;
 
-	err = read_ec_data(priv->adev->handle, VPCCMD_R_FAN, &result);
+	scoped_guard(mutex, &priv->vpc_mutex)
+		err = read_ec_data(priv->adev->handle, VPCCMD_R_FAN, &result);
 	if (err)
 		return err;
 
@@ -647,7 +653,8 @@ static ssize_t fan_mode_store(struct device *dev,
 	if (state > 4 || state == 3)
 		return -EINVAL;
 
-	err = write_ec_cmd(priv->adev->handle, VPCCMD_W_FAN, state);
+	scoped_guard(mutex, &priv->vpc_mutex)
+		err = write_ec_cmd(priv->adev->handle, VPCCMD_W_FAN, state);
 	if (err)
 		return err;
 
@@ -700,7 +707,8 @@ static ssize_t touchpad_show(struct device *dev,
 	unsigned long result;
 	int err;
 
-	err = read_ec_data(priv->adev->handle, VPCCMD_R_TOUCHPAD, &result);
+	scoped_guard(mutex, &priv->vpc_mutex)
+		err = read_ec_data(priv->adev->handle, VPCCMD_R_TOUCHPAD, &result);
 	if (err)
 		return err;
 
@@ -721,7 +729,8 @@ static ssize_t touchpad_store(struct device *dev,
 	if (err)
 		return err;
 
-	err = write_ec_cmd(priv->adev->handle, VPCCMD_W_TOUCHPAD, state);
+	scoped_guard(mutex, &priv->vpc_mutex)
+		err = write_ec_cmd(priv->adev->handle, VPCCMD_W_TOUCHPAD, state);
 	if (err)
 		return err;
 
@@ -1118,6 +1127,8 @@ static int ideapad_rfk_set(void *data, bool blocked)
 	struct ideapad_rfk_priv *priv = data;
 	int opcode = ideapad_rfk_data[priv->dev].opcode;
 
+	guard(mutex)(&priv->priv->vpc_mutex);
+
 	return write_ec_cmd(priv->priv->adev->handle, opcode, !blocked);
 }
 
@@ -1131,6 +1142,8 @@ static void ideapad_sync_rfk_state(struct ideapad_private *priv)
 	int i;
 
 	if (priv->features.hw_rfkill_switch) {
+		guard(mutex)(&priv->vpc_mutex);
+
 		if (read_ec_data(priv->adev->handle, VPCCMD_R_RF, &hw_blocked))
 			return;
 		hw_blocked = !hw_blocked;
@@ -1302,8 +1315,9 @@ static void ideapad_input_novokey(struct ideapad_private *priv)
 {
 	unsigned long long_pressed;
 
-	if (read_ec_data(priv->adev->handle, VPCCMD_R_NOVO, &long_pressed))
-		return;
+	scoped_guard(mutex, &priv->vpc_mutex)
+		if (read_ec_data(priv->adev->handle, VPCCMD_R_NOVO, &long_pressed))
+			return;
 
 	if (long_pressed)
 		ideapad_input_report(priv, 17);
@@ -1315,8 +1329,9 @@ static void ideapad_check_special_buttons(struct ideapad_private *priv)
 {
 	unsigned long bit, value;
 
-	if (read_ec_data(priv->adev->handle, VPCCMD_R_SPECIAL_BUTTONS, &value))
-		return;
+	scoped_guard(mutex, &priv->vpc_mutex)
+		if (read_ec_data(priv->adev->handle, VPCCMD_R_SPECIAL_BUTTONS, &value))
+			return;
 
 	for_each_set_bit (bit, &value, 16) {
 		switch (bit) {
@@ -1346,6 +1361,8 @@ static int ideapad_backlight_get_brightness(struct backlight_device *blightdev)
 	unsigned long now;
 	int err;
 
+	guard(mutex)(&priv->vpc_mutex);
+
 	err = read_ec_data(priv->adev->handle, VPCCMD_R_BL, &now);
 	if (err)
 		return err;
@@ -1358,6 +1375,8 @@ static int ideapad_backlight_update_status(struct backlight_device *blightdev)
 	struct ideapad_private *priv = bl_get_data(blightdev);
 	int err;
 
+	guard(mutex)(&priv->vpc_mutex);
+
 	err = write_ec_cmd(priv->adev->handle, VPCCMD_W_BL,
 			   blightdev->props.brightness);
 	if (err)
@@ -1435,6 +1454,8 @@ static void ideapad_backlight_notify_power(struct ideapad_private *priv)
 	if (!blightdev)
 		return;
 
+	guard(mutex)(&priv->vpc_mutex);
+
 	if (read_ec_data(priv->adev->handle, VPCCMD_R_BL_POWER, &power))
 		return;
 
@@ -1447,7 +1468,8 @@ static void ideapad_backlight_notify_brightness(struct ideapad_private *priv)
 
 	/* if we control brightness via acpi video driver */
 	if (!priv->blightdev)
-		read_ec_data(priv->adev->handle, VPCCMD_R_BL, &now);
+		scoped_guard(mutex, &priv->vpc_mutex)
+			read_ec_data(priv->adev->handle, VPCCMD_R_BL, &now);
 	else
 		backlight_force_update(priv->blightdev, BACKLIGHT_UPDATE_HOTKEY);
 }
@@ -1613,7 +1635,8 @@ static void ideapad_sync_touchpad_state(struct ideapad_private *priv, bool send_
 	int ret;
 
 	/* Without reading from EC touchpad LED doesn't switch state */
-	ret = read_ec_data(priv->adev->handle, VPCCMD_R_TOUCHPAD, &value);
+	scoped_guard(mutex, &priv->vpc_mutex)
+		ret = read_ec_data(priv->adev->handle, VPCCMD_R_TOUCHPAD, &value);
 	if (ret)
 		return;
 
@@ -1673,7 +1696,8 @@ static void ideapad_laptop_trigger_ec(void)
 	if (!priv->features.ymc_ec_trigger)
 		return;
 
-	ret = write_ec_cmd(priv->adev->handle, VPCCMD_W_YMC, 1);
+	scoped_guard(mutex, &priv->vpc_mutex)
+		ret = write_ec_cmd(priv->adev->handle, VPCCMD_W_YMC, 1);
 	if (ret)
 		dev_warn(&priv->platform_device->dev, "Could not write YMC: %d\n", ret);
 }
@@ -1719,11 +1743,13 @@ static void ideapad_acpi_notify(acpi_handle handle, u32 event, void *data)
 	struct ideapad_private *priv = data;
 	unsigned long vpc1, vpc2, bit;
 
-	if (read_ec_data(handle, VPCCMD_R_VPC1, &vpc1))
-		return;
+	scoped_guard(mutex, &priv->vpc_mutex) {
+		if (read_ec_data(handle, VPCCMD_R_VPC1, &vpc1))
+			return;
 
-	if (read_ec_data(handle, VPCCMD_R_VPC2, &vpc2))
-		return;
+		if (read_ec_data(handle, VPCCMD_R_VPC2, &vpc2))
+			return;
+	}
 
 	vpc1 = (vpc2 << 8) | vpc1;
 
@@ -2027,6 +2053,8 @@ static int ideapad_acpi_add(struct platform_device *pdev)
 	priv->adev = adev;
 	priv->platform_device = pdev;
 
+	mutex_init(&priv->vpc_mutex);
+
 	ideapad_check_features(priv);
 
 	err = ideapad_sysfs_init(priv);
-- 
2.45.2


