Return-Path: <linux-kernel+bounces-245537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FA092B40C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 871C81F232B9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741D215664C;
	Tue,  9 Jul 2024 09:38:36 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F380215573D;
	Tue,  9 Jul 2024 09:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720517915; cv=none; b=XPOAWsJ5c0x1l143FsH7JQ8IEvUuqOVNKxg7nXonyUkllCVN+V1NV9+WbCaMdEqT3ZaUa1JqBeykvhFb/ZpF9o7Eay9xMRiy40V8jSyiQ9Luy38hdYS8D4PRSU5qYYjmaUdv2U2RRD1cC/pJLAFv7dvKeVIf00N/Y+vMK1rVj08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720517915; c=relaxed/simple;
	bh=ggH5j6ezVRCW6nQAc+Go7OHQYsjY7gwlTULr/jco9jY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Q2gOEmR4Zk9Th8oKrofUobz+XithniGNUjiEy+UzPzshLlvaDfeDRlCjzp0YnoDmXw1JpJou3kg5x8N9qMgEnK9qC/GPgk2M7oMguylCMVkHry6ZEJmWz6PKBvpnv305ka8ef9aWumblLlvZ7rhChMhU6wVVGui1978S0eYPYhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b693a1.dsl.pool.telekom.hu [::ffff:81.182.147.161])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000071E8C.00000000668D03E4.0016EC7E; Tue, 09 Jul 2024 11:33:24 +0200
From: Gergo Koteles <soyer@irl.hu>
To: Hans de Goede <hdegoede@redhat.com>,
  =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
  Ike Panhc <ike.pan@canonical.com>
Cc: platform-driver-x86@vger.kernel.org,
  linux-kernel@vger.kernel.org, Gergo Koteles <soyer@irl.hu>
Subject: [PATCH 2/4] platform/x86: ideapad-laptop: add a mutex to synchronize VPC commands
Date: Tue,  9 Jul 2024 11:33:06 +0200
Message-ID: <d18138c88fbe5e6c98317135433b89f4f09647c1.1720515666.git.soyer@irl.hu>
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

Calling VPC commands consists of several VPCW and VPCR ACPI calls.
These calls and their results can get mixed up if they are called
simultaneously from different threads, like acpi notify handler,
sysfs, debugfs, lenovo-ymc.

Add a mutex to synchronize VPC commands.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 drivers/platform/x86/ideapad-laptop.c | 59 +++++++++++++++++++--------
 1 file changed, 43 insertions(+), 16 deletions(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 1ace711f7442..464cc5fd0088 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -126,6 +126,7 @@ struct ideapad_rfk_priv {
 
 struct ideapad_private {
 	struct acpi_device *adev;
+	struct mutex vpc_mutex; /* protects the VPC calls */
 	struct rfkill *rfk[IDEAPAD_RFKILL_DEV_NUM];
 	struct ideapad_rfk_priv rfk_priv[IDEAPAD_RFKILL_DEV_NUM];
 	struct platform_device *platform_device;
@@ -294,6 +295,8 @@ static int debugfs_status_show(struct seq_file *s, void *data)
 	struct ideapad_private *priv = s->private;
 	unsigned long value;
 
+	guard(mutex)(&priv->vpc_mutex);
+
 	if (!read_ec_data(priv->adev->handle, VPCCMD_R_BL_MAX, &value))
 		seq_printf(s, "Backlight max:  %lu\n", value);
 	if (!read_ec_data(priv->adev->handle, VPCCMD_R_BL, &value))
@@ -412,7 +415,8 @@ static ssize_t camera_power_show(struct device *dev,
 	unsigned long result;
 	int err;
 
-	err = read_ec_data(priv->adev->handle, VPCCMD_R_CAMERA, &result);
+	scoped_guard(mutex, &priv->vpc_mutex)
+		err = read_ec_data(priv->adev->handle, VPCCMD_R_CAMERA, &result);
 	if (err)
 		return err;
 
@@ -431,7 +435,8 @@ static ssize_t camera_power_store(struct device *dev,
 	if (err)
 		return err;
 
-	err = write_ec_cmd(priv->adev->handle, VPCCMD_W_CAMERA, state);
+	scoped_guard(mutex, &priv->vpc_mutex)
+		err = write_ec_cmd(priv->adev->handle, VPCCMD_W_CAMERA, state);
 	if (err)
 		return err;
 
@@ -484,7 +489,8 @@ static ssize_t fan_mode_show(struct device *dev,
 	unsigned long result;
 	int err;
 
-	err = read_ec_data(priv->adev->handle, VPCCMD_R_FAN, &result);
+	scoped_guard(mutex, &priv->vpc_mutex)
+		err = read_ec_data(priv->adev->handle, VPCCMD_R_FAN, &result);
 	if (err)
 		return err;
 
@@ -506,7 +512,8 @@ static ssize_t fan_mode_store(struct device *dev,
 	if (state > 4 || state == 3)
 		return -EINVAL;
 
-	err = write_ec_cmd(priv->adev->handle, VPCCMD_W_FAN, state);
+	scoped_guard(mutex, &priv->vpc_mutex)
+		err = write_ec_cmd(priv->adev->handle, VPCCMD_W_FAN, state);
 	if (err)
 		return err;
 
@@ -591,7 +598,8 @@ static ssize_t touchpad_show(struct device *dev,
 	unsigned long result;
 	int err;
 
-	err = read_ec_data(priv->adev->handle, VPCCMD_R_TOUCHPAD, &result);
+	scoped_guard(mutex, &priv->vpc_mutex)
+		err = read_ec_data(priv->adev->handle, VPCCMD_R_TOUCHPAD, &result);
 	if (err)
 		return err;
 
@@ -612,7 +620,8 @@ static ssize_t touchpad_store(struct device *dev,
 	if (err)
 		return err;
 
-	err = write_ec_cmd(priv->adev->handle, VPCCMD_W_TOUCHPAD, state);
+	scoped_guard(mutex, &priv->vpc_mutex)
+		err = write_ec_cmd(priv->adev->handle, VPCCMD_W_TOUCHPAD, state);
 	if (err)
 		return err;
 
@@ -1005,6 +1014,8 @@ static int ideapad_rfk_set(void *data, bool blocked)
 	struct ideapad_rfk_priv *priv = data;
 	int opcode = ideapad_rfk_data[priv->dev].opcode;
 
+	guard(mutex)(&priv->priv->vpc_mutex);
+
 	return write_ec_cmd(priv->priv->adev->handle, opcode, !blocked);
 }
 
@@ -1018,6 +1029,8 @@ static void ideapad_sync_rfk_state(struct ideapad_private *priv)
 	int i;
 
 	if (priv->features.hw_rfkill_switch) {
+		guard(mutex)(&priv->vpc_mutex);
+
 		if (read_ec_data(priv->adev->handle, VPCCMD_R_RF, &hw_blocked))
 			return;
 		hw_blocked = !hw_blocked;
@@ -1191,8 +1204,9 @@ static void ideapad_input_novokey(struct ideapad_private *priv)
 {
 	unsigned long long_pressed;
 
-	if (read_ec_data(priv->adev->handle, VPCCMD_R_NOVO, &long_pressed))
-		return;
+	scoped_guard(mutex, &priv->vpc_mutex)
+		if (read_ec_data(priv->adev->handle, VPCCMD_R_NOVO, &long_pressed))
+			return;
 
 	if (long_pressed)
 		ideapad_input_report(priv, 17);
@@ -1204,8 +1218,9 @@ static void ideapad_check_special_buttons(struct ideapad_private *priv)
 {
 	unsigned long bit, value;
 
-	if (read_ec_data(priv->adev->handle, VPCCMD_R_SPECIAL_BUTTONS, &value))
-		return;
+	scoped_guard(mutex, &priv->vpc_mutex)
+		if (read_ec_data(priv->adev->handle, VPCCMD_R_SPECIAL_BUTTONS, &value))
+			return;
 
 	for_each_set_bit (bit, &value, 16) {
 		switch (bit) {
@@ -1238,6 +1253,8 @@ static int ideapad_backlight_get_brightness(struct backlight_device *blightdev)
 	unsigned long now;
 	int err;
 
+	guard(mutex)(&priv->vpc_mutex);
+
 	err = read_ec_data(priv->adev->handle, VPCCMD_R_BL, &now);
 	if (err)
 		return err;
@@ -1250,6 +1267,8 @@ static int ideapad_backlight_update_status(struct backlight_device *blightdev)
 	struct ideapad_private *priv = bl_get_data(blightdev);
 	int err;
 
+	guard(mutex)(&priv->vpc_mutex);
+
 	err = write_ec_cmd(priv->adev->handle, VPCCMD_W_BL,
 			   blightdev->props.brightness);
 	if (err)
@@ -1327,6 +1346,8 @@ static void ideapad_backlight_notify_power(struct ideapad_private *priv)
 	if (!blightdev)
 		return;
 
+	guard(mutex)(&priv->vpc_mutex);
+
 	if (read_ec_data(priv->adev->handle, VPCCMD_R_BL_POWER, &power))
 		return;
 
@@ -1339,7 +1360,8 @@ static void ideapad_backlight_notify_brightness(struct ideapad_private *priv)
 
 	/* if we control brightness via acpi video driver */
 	if (!priv->blightdev)
-		read_ec_data(priv->adev->handle, VPCCMD_R_BL, &now);
+		scoped_guard(mutex, &priv->vpc_mutex)
+			read_ec_data(priv->adev->handle, VPCCMD_R_BL, &now);
 	else
 		backlight_force_update(priv->blightdev, BACKLIGHT_UPDATE_HOTKEY);
 }
@@ -1564,7 +1586,8 @@ static void ideapad_sync_touchpad_state(struct ideapad_private *priv, bool send_
 	int ret;
 
 	/* Without reading from EC touchpad LED doesn't switch state */
-	ret = read_ec_data(priv->adev->handle, VPCCMD_R_TOUCHPAD, &value);
+	scoped_guard(mutex, &priv->vpc_mutex)
+		ret = read_ec_data(priv->adev->handle, VPCCMD_R_TOUCHPAD, &value);
 	if (ret)
 		return;
 
@@ -1597,11 +1620,13 @@ static void ideapad_acpi_notify(acpi_handle handle, u32 event, void *data)
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
 
@@ -1906,6 +1931,8 @@ static int ideapad_acpi_add(struct platform_device *pdev)
 	priv->adev = adev;
 	priv->platform_device = pdev;
 
+	mutex_init(&priv->vpc_mutex);
+
 	ideapad_check_features(priv);
 
 	err = ideapad_sysfs_init(priv);
-- 
2.45.2


