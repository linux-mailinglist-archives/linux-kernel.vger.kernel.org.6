Return-Path: <linux-kernel+bounces-206942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB446901023
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 10:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93EAF1C21187
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 08:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11183176FBE;
	Sat,  8 Jun 2024 08:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="qo9Wgxe6"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF5E176AB7;
	Sat,  8 Jun 2024 08:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717834372; cv=none; b=YOOU3S27LS8HzplwRQQHVfm4wTpf5gd6i/DHsYiysK3kmNpJbQZSz1VORNJx6YM02l0ucUSH1oM8CG3c6y2YACpzhCfCRjNEiyu1VYnCkxeoVNrpLNLTbfNeX9IzRmYRwlLZDFsATU+ydTLi+RcnA9PJMVCNpQdu6xgmxn9qNao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717834372; c=relaxed/simple;
	bh=cey65pHupnRn7AKD1BC6IG+jnHBcwTWEUtCKuXY67cE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ETFtg1/zczP203P6/Bg0UwChYDzJpaw8H3n2y7mC9ZQ/we7Vu2Ut7nIHa3WnJbjeordg+vJM7Jernf3PdhXAg8dRxokCCw4SfaqUYooNm6idQzu25rjsmDaXRXeSyPRkqGTmHUlLQASeacbiWNko80qeodNyMmqBcRzSB5KNEu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=qo9Wgxe6; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1717834365;
	bh=cey65pHupnRn7AKD1BC6IG+jnHBcwTWEUtCKuXY67cE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qo9Wgxe6BLPHOFk2WVMOAOGhyjN2H81WFz6tp0LF5UPh6D3YItwR1x5WoDWb7gHtZ
	 0q2PbEcbCYKEusDgQhfMshRbWfLzxKcYItq2X++iI+o3GeDreA+FN/Urq8Zw0E0JdH
	 rxL+vkkhR6PTKtNlPI+u6rW6jxpXrdwyDbZsG4NU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 08 Jun 2024 10:12:45 +0200
Subject: [PATCH 3/5] hwmon: (cros_ec) Add support for PWM fan control
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240608-cros_ec-hwmon-pwm-v1-3-d29dfc26fbc3@weissschuh.net>
References: <20240608-cros_ec-hwmon-pwm-v1-0-d29dfc26fbc3@weissschuh.net>
In-Reply-To: <20240608-cros_ec-hwmon-pwm-v1-0-d29dfc26fbc3@weissschuh.net>
To: Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Guenter Roeck <groeck@chromium.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: Dustin Howett <dustin@howett.net>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Stephen Horvath <s.horvath@outlook.com.au>, chrome-platform@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717834365; l=7057;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=cey65pHupnRn7AKD1BC6IG+jnHBcwTWEUtCKuXY67cE=;
 b=1VITW0coHrRX9kNamlVH5dgZxBlx1VogdDAvGzhI9dZbRPF2D6Wj3X89dDPDTUz4x7MxU1RAg
 nPAkFVPSffcCOKVyXFm67ESIBZInt3AkC8ngZiqZAnbPHQKl5Kf1BGl
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Implement setting fan duty cycle and automatic management through
EC_CMD_PWM_SET_FAN_DUTY and EC_CMD_THERMAL_AUTO_FAN_CTRL.

The hardware does not support reading back the values again,
so that is emulated in the driver.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 Documentation/hwmon/cros_ec_hwmon.rst |   1 +
 drivers/hwmon/cros_ec_hwmon.c         | 128 +++++++++++++++++++++++++++++++++-
 2 files changed, 127 insertions(+), 2 deletions(-)

diff --git a/Documentation/hwmon/cros_ec_hwmon.rst b/Documentation/hwmon/cros_ec_hwmon.rst
index 4aede331baeb..3cc345425aac 100644
--- a/Documentation/hwmon/cros_ec_hwmon.rst
+++ b/Documentation/hwmon/cros_ec_hwmon.rst
@@ -27,4 +27,5 @@ Supported features:
 
   - Current fan speed
   - Target fan speed (for fan 1 only)
+  - PWM-based fan control
   - Current temperature
diff --git a/drivers/hwmon/cros_ec_hwmon.c b/drivers/hwmon/cros_ec_hwmon.c
index 09b8057e1223..48b7073a4991 100644
--- a/drivers/hwmon/cros_ec_hwmon.c
+++ b/drivers/hwmon/cros_ec_hwmon.c
@@ -7,6 +7,7 @@
 
 #include <linux/device.h>
 #include <linux/hwmon.h>
+#include <linux/math.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -17,10 +18,19 @@
 
 #define DRV_NAME	"cros-ec-hwmon"
 
+enum cros_ec_hwmon_fan_mode {
+	cros_ec_hwmon_fan_mode_full = 0,
+	cros_ec_hwmon_fan_mode_manual = 1,
+	cros_ec_hwmon_fan_mode_auto = 2,
+};
+
 struct cros_ec_hwmon_priv {
 	struct cros_ec_device *cros_ec;
 	const char *temp_sensor_names[EC_TEMP_SENSOR_ENTRIES + EC_TEMP_SENSOR_B_ENTRIES];
 	u8 usable_fans;
+	bool has_fan_pwm;
+	u8 fan_pwm[EC_FAN_SPEED_ENTRIES];
+	enum cros_ec_hwmon_fan_mode fan_mode[EC_FAN_SPEED_ENTRIES];
 };
 
 static int cros_ec_hwmon_read_fan_speed(struct cros_ec_device *cros_ec, u8 index, u16 *speed)
@@ -50,6 +60,27 @@ static int cros_ec_hwmon_read_fan_target(struct cros_ec_device *cros_ec, u16 *sp
 	return 0;
 }
 
+static int cros_ec_hwmon_set_fan_auto(struct cros_ec_device *cros_ec, u8 index)
+{
+	struct ec_params_auto_fan_ctrl_v1 req = {
+		.fan_idx = index,
+	};
+
+	return cros_ec_cmd(cros_ec, 1, EC_CMD_THERMAL_AUTO_FAN_CTRL,
+			   &req, sizeof(req), NULL, 0);
+}
+
+static int cros_ec_hwmon_set_fan_duty_cycle(struct cros_ec_device *cros_ec, u8 index, u8 percent)
+{
+	struct ec_params_pwm_set_fan_duty_v1 req = {
+		.fan_idx = index,
+		.percent = percent,
+	};
+
+	return cros_ec_cmd(cros_ec, 1, EC_CMD_PWM_SET_FAN_DUTY,
+			   &req, sizeof(req), NULL, 0);
+}
+
 static int cros_ec_hwmon_read_temp(struct cros_ec_device *cros_ec, u8 index, u8 *temp)
 {
 	unsigned int offset;
@@ -111,6 +142,17 @@ static int cros_ec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 			if (ret == 0)
 				*val = speed;
 		}
+
+	} else if (type == hwmon_pwm) {
+		if (attr == hwmon_pwm_input) {
+			*val = priv->fan_pwm[channel];
+			ret = 0;
+
+		} else if (attr == hwmon_pwm_enable) {
+			*val = priv->fan_mode[channel];
+			ret = 0;
+		}
+
 	} else if (type == hwmon_temp) {
 		if (attr == hwmon_temp_input) {
 			ret = cros_ec_hwmon_read_temp(priv->cros_ec, channel, &temp);
@@ -143,6 +185,61 @@ static int cros_ec_hwmon_read_string(struct device *dev, enum hwmon_sensor_types
 	return -EOPNOTSUPP;
 }
 
+static int cros_ec_hwmon_write_pwm_input(struct cros_ec_hwmon_priv *priv, int channel, long val)
+{
+	u8 percent;
+	int ret;
+
+	if (val < 0 || val > 255)
+		return -EINVAL;
+
+	percent = DIV_ROUND_CLOSEST(val * 100, 255);
+
+	if (priv->fan_mode[channel] == cros_ec_hwmon_fan_mode_manual) {
+		ret = cros_ec_hwmon_set_fan_duty_cycle(priv->cros_ec, channel, percent);
+		if (ret < 0)
+			return ret;
+	}
+
+	priv->fan_pwm[channel] = percent;
+	return 0;
+}
+
+static int cros_ec_hwmon_write_pwm_enable(struct cros_ec_hwmon_priv *priv, int channel, long val)
+{
+	int ret;
+
+	if (val == cros_ec_hwmon_fan_mode_full)
+		ret = cros_ec_hwmon_set_fan_duty_cycle(priv->cros_ec, channel, 100);
+	else if (val == cros_ec_hwmon_fan_mode_manual)
+		ret = cros_ec_hwmon_set_fan_duty_cycle(priv->cros_ec, channel,
+						       priv->fan_pwm[channel]);
+	else if (val == cros_ec_hwmon_fan_mode_auto)
+		ret = cros_ec_hwmon_set_fan_auto(priv->cros_ec, channel);
+	else
+		return -EINVAL;
+
+	priv->fan_mode[channel] = val;
+	return ret;
+}
+
+static int cros_ec_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
+			       u32 attr, int channel, long val)
+{
+	struct cros_ec_hwmon_priv *priv = dev_get_drvdata(dev);
+	int ret = -EOPNOTSUPP;
+
+	if (type == hwmon_pwm) {
+		if (attr == hwmon_pwm_input)
+			ret = cros_ec_hwmon_write_pwm_input(priv, channel, val);
+
+		else if (attr == hwmon_pwm_enable)
+			ret = cros_ec_hwmon_write_pwm_enable(priv, channel, val);
+	}
+
+	return ret;
+}
+
 static umode_t cros_ec_hwmon_is_visible(const void *data, enum hwmon_sensor_types type,
 					u32 attr, int channel)
 {
@@ -156,6 +253,11 @@ static umode_t cros_ec_hwmon_is_visible(const void *data, enum hwmon_sensor_type
 
 		if (priv->usable_fans & BIT(channel))
 			return 0444;
+
+	} else if (type == hwmon_pwm) {
+		if (priv->has_fan_pwm && priv->usable_fans & BIT(channel))
+			return 0644;
+
 	} else if (type == hwmon_temp) {
 		if (priv->temp_sensor_names[channel])
 			return 0444;
@@ -170,6 +272,11 @@ static const struct hwmon_channel_info * const cros_ec_hwmon_info[] = {
 			   HWMON_F_INPUT | HWMON_F_FAULT,
 			   HWMON_F_INPUT | HWMON_F_FAULT,
 			   HWMON_F_INPUT | HWMON_F_FAULT),
+	HWMON_CHANNEL_INFO(pwm,
+			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
+			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
+			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
+			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE),
 	HWMON_CHANNEL_INFO(temp,
 			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
 			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
@@ -201,6 +308,7 @@ static const struct hwmon_channel_info * const cros_ec_hwmon_info[] = {
 static const struct hwmon_ops cros_ec_hwmon_ops = {
 	.read = cros_ec_hwmon_read,
 	.read_string = cros_ec_hwmon_read_string,
+	.write = cros_ec_hwmon_write,
 	.is_visible = cros_ec_hwmon_is_visible,
 };
 
@@ -249,10 +357,26 @@ static void cros_ec_hwmon_probe_fans(struct cros_ec_hwmon_priv *priv)
 	size_t i;
 	int ret;
 
+	ret = cros_ec_cmd_versions(priv->cros_ec, EC_CMD_PWM_SET_FAN_DUTY);
+	if (ret >= 0 && ret & EC_VER_MASK(1))
+		priv->has_fan_pwm = 1;
+
 	for (i = 0; i < EC_FAN_SPEED_ENTRIES; i++) {
 		ret = cros_ec_hwmon_read_fan_speed(priv->cros_ec, i, &speed);
-		if (ret == 0 && speed != EC_FAN_SPEED_NOT_PRESENT)
-			priv->usable_fans |= BIT(i);
+		if (ret < 0)
+			continue;
+		if (speed == EC_FAN_SPEED_NOT_PRESENT)
+			continue;
+
+		priv->usable_fans |= BIT(i);
+
+		if (priv->has_fan_pwm) {
+			priv->fan_mode[i] = cros_ec_hwmon_fan_mode_auto;
+			ret = cros_ec_hwmon_set_fan_auto(priv->cros_ec, i);
+			if (ret != 0)
+				priv->has_fan_pwm = 0;
+		}
+
 	}
 }
 

-- 
2.45.2


