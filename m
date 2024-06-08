Return-Path: <linux-kernel+bounces-206947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2823D901029
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 10:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB81B281DD2
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 08:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFF1176FBD;
	Sat,  8 Jun 2024 08:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="amJRXPqB"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92E5178362;
	Sat,  8 Jun 2024 08:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717834376; cv=none; b=Ymb55eDZh5AQosz3cwsequQ1EHvHLk41+L8uZcKviG39Q6KomtVNQpYQ4SuTt8dm2IXI2vigPvGnBI9HRIwHY3MkpIhMg35HpznKwlOGnFrJaqG5KBqtLbvECDfeugsyERm4sgQwYZyzu7/FknY3H72YQQAsCNbyR9Jax5OV7Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717834376; c=relaxed/simple;
	bh=nS0VirJKyYW+dk8nu7ljo2kt+g/A4F+QJmGxE892J9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qLFJW8uSm63vwLtZGrHzFj5rigVlpiZmuXSEIW/qzVSU04htm4g4+jrLfUDlzSvidAi5ssebJ2jRiBfgeXa9P2ozyN0QqedWRV1ZsudApnTcZcFJbHHFnctcCs3/Trb1uaPQdktvY4DN4d4EKeFiMF5V+dgp7qtXjihnpr/i/JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=amJRXPqB; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1717834366;
	bh=nS0VirJKyYW+dk8nu7ljo2kt+g/A4F+QJmGxE892J9I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=amJRXPqBn4lEkEK0kaAX1c495b7B/CEZvd0SVy1YL82RQn8qo0rRHrMfRGd2dyQhB
	 yU+vmiGcBRZgKJO8+U5eATwjzx8ILmIMx7Kt1y61Whz/D93Q7MkHsOs+BUvr4rtlcR
	 tde2QYQPm5yDepBSIj1SKa/+D2CDWZnax/p1z0PU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 08 Jun 2024 10:12:47 +0200
Subject: [PATCH 5/5] hwmon: (cros_ec) Add support for temperature
 thresholds
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240608-cros_ec-hwmon-pwm-v1-5-d29dfc26fbc3@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717834365; l=6121;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=nS0VirJKyYW+dk8nu7ljo2kt+g/A4F+QJmGxE892J9I=;
 b=V5V/b7UZ6qurz6h+lVJBextsKc+zDESr+4BKzZqCx/SRGi4RrU7YqVnGRo32ivPUsbr34MEHs
 Ic103Au6TTsBxT6JaCsU8kxRJcn+szSC9XRcLDCmuaVvNq2zfbj6C96
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Implement reading and writing temperature thresholds through
EC_CMD_THERMAL_GET_THRESHOLD/EC_CMD_THERMAL_SET_THRESHOLD.

Thresholds are mapped as follows between the EC and hwmon:

hwmon_temp_max       - EC_TEMP_THRESH_WARN
hwmon_temp_crit      - EC_TEMP_THRESH_HIGH
hwmon_temp_emergency - EC_TEMP_THRESH_HALT

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 Documentation/hwmon/cros_ec_hwmon.rst |  1 +
 drivers/hwmon/cros_ec_hwmon.c         | 82 +++++++++++++++++++++++++++++++++--
 2 files changed, 80 insertions(+), 3 deletions(-)

diff --git a/Documentation/hwmon/cros_ec_hwmon.rst b/Documentation/hwmon/cros_ec_hwmon.rst
index 3cc345425aac..24ff261ae232 100644
--- a/Documentation/hwmon/cros_ec_hwmon.rst
+++ b/Documentation/hwmon/cros_ec_hwmon.rst
@@ -29,3 +29,4 @@ Supported features:
   - Target fan speed (for fan 1 only)
   - PWM-based fan control
   - Current temperature
+  - Temperature thresholds
diff --git a/drivers/hwmon/cros_ec_hwmon.c b/drivers/hwmon/cros_ec_hwmon.c
index 5cddf78cfe0e..009b94af6df4 100644
--- a/drivers/hwmon/cros_ec_hwmon.c
+++ b/drivers/hwmon/cros_ec_hwmon.c
@@ -29,6 +29,7 @@ struct cros_ec_hwmon_priv {
 	const char *temp_sensor_names[EC_TEMP_SENSOR_ENTRIES + EC_TEMP_SENSOR_B_ENTRIES];
 	u8 usable_fans;
 	bool has_fan_pwm;
+	bool has_temp_threshold;
 	u8 fan_pwm[EC_FAN_SPEED_ENTRIES];
 	enum cros_ec_hwmon_fan_mode fan_mode[EC_FAN_SPEED_ENTRIES];
 };
@@ -97,6 +98,42 @@ static int cros_ec_hwmon_read_temp(struct cros_ec_device *cros_ec, u8 index, u8
 	return 0;
 }
 
+static int cros_ec_hwmon_read_temp_threshold(struct cros_ec_device *cros_ec, u8 index,
+					     enum ec_temp_thresholds threshold, u32 *temp)
+{
+	struct ec_params_thermal_get_threshold_v1 req = {};
+	struct ec_thermal_config resp;
+	int ret;
+
+	req.sensor_num = index;
+	ret = cros_ec_cmd(cros_ec, 1, EC_CMD_THERMAL_GET_THRESHOLD,
+			  &req, sizeof(req), &resp, sizeof(resp));
+	if (ret < 0)
+		return ret;
+
+	*temp = resp.temp_host[threshold];
+	return 0;
+}
+
+static int cros_ec_hwmon_write_temp_threshold(struct cros_ec_device *cros_ec, u8 index,
+					      enum ec_temp_thresholds threshold, u32 temp)
+{
+	struct ec_params_thermal_get_threshold_v1 get_req = {};
+	struct ec_params_thermal_set_threshold_v1 set_req = {};
+	int ret;
+
+	get_req.sensor_num = index;
+	ret = cros_ec_cmd(cros_ec, 1, EC_CMD_THERMAL_GET_THRESHOLD,
+			  &get_req, sizeof(get_req), &set_req.cfg, sizeof(set_req.cfg));
+	if (ret < 0)
+		return ret;
+
+	set_req.sensor_num = index;
+	set_req.cfg.temp_host[threshold] = temp;
+	return cros_ec_cmd(cros_ec, 1, EC_CMD_THERMAL_SET_THRESHOLD,
+			   &set_req, sizeof(set_req), NULL, 0);
+}
+
 static bool cros_ec_hwmon_is_error_fan(u16 speed)
 {
 	return speed == EC_FAN_SPEED_NOT_PRESENT || speed == EC_FAN_SPEED_STALLED;
@@ -115,11 +152,24 @@ static long cros_ec_hwmon_temp_to_millicelsius(u8 temp)
 	return kelvin_to_millicelsius((((long)temp) + EC_TEMP_SENSOR_OFFSET));
 }
 
+static enum ec_temp_thresholds cros_ec_hwmon_attr_to_thres(u32 attr)
+{
+	if (attr == hwmon_temp_max)
+		return EC_TEMP_THRESH_WARN;
+	else if (attr == hwmon_temp_crit)
+		return EC_TEMP_THRESH_HIGH;
+	else if (attr == hwmon_temp_emergency)
+		return EC_TEMP_THRESH_HALT;
+	else
+		return 0;
+}
+
 static int cros_ec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 			      u32 attr, int channel, long *val)
 {
 	struct cros_ec_hwmon_priv *priv = dev_get_drvdata(dev);
 	int ret = -EOPNOTSUPP;
+	u32 threshold;
 	u16 speed;
 	u8 temp;
 
@@ -166,6 +216,14 @@ static int cros_ec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 			ret = cros_ec_hwmon_read_temp(priv->cros_ec, channel, &temp);
 			if (ret == 0)
 				*val = cros_ec_hwmon_is_error_temp(temp);
+
+		} else if (attr == hwmon_temp_max || attr == hwmon_temp_crit ||
+			   attr == hwmon_temp_emergency) {
+			ret = cros_ec_hwmon_read_temp_threshold(priv->cros_ec, channel,
+								cros_ec_hwmon_attr_to_thres(attr),
+								&threshold);
+			if (ret == 0)
+				*val = kelvin_to_millicelsius(threshold);
 		}
 	}
 
@@ -235,6 +293,10 @@ static int cros_ec_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
 
 		else if (attr == hwmon_pwm_enable)
 			ret = cros_ec_hwmon_write_pwm_enable(priv, channel, val);
+	} else if (type == hwmon_temp) {
+		ret = cros_ec_hwmon_write_temp_threshold(priv->cros_ec, channel,
+							 cros_ec_hwmon_attr_to_thres(attr),
+							 millicelsius_to_kelvin(val));
 	}
 
 	return ret;
@@ -259,8 +321,16 @@ static umode_t cros_ec_hwmon_is_visible(const void *data, enum hwmon_sensor_type
 			return 0644;
 
 	} else if (type == hwmon_temp) {
-		if (priv->temp_sensor_names[channel])
-			return 0444;
+		if (priv->temp_sensor_names[channel]) {
+			if (attr == hwmon_temp_max ||
+			    attr == hwmon_temp_crit ||
+			    attr == hwmon_temp_emergency) {
+				if (priv->has_temp_threshold)
+					return 0644;
+			} else {
+				return 0444;
+			}
+		}
 	}
 
 	return 0;
@@ -278,7 +348,8 @@ static const struct hwmon_channel_info * const cros_ec_hwmon_info[] = {
 			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
 			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE),
 
-#define CROS_EC_HWMON_TEMP_PARAMS (HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL)
+#define CROS_EC_HWMON_TEMP_PARAMS (HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL | \
+				   HWMON_T_MAX | HWMON_T_CRIT | HWMON_T_EMERGENCY)
 	HWMON_CHANNEL_INFO(temp,
 			   CROS_EC_HWMON_TEMP_PARAMS,
 			   CROS_EC_HWMON_TEMP_PARAMS,
@@ -325,9 +396,14 @@ static void cros_ec_hwmon_probe_temp_sensors(struct device *dev, struct cros_ec_
 	struct ec_params_temp_sensor_get_info req = {};
 	struct ec_response_temp_sensor_get_info resp;
 	size_t candidates, i, sensor_name_size;
+	u32 threshold;
 	int ret;
 	u8 temp;
 
+	ret = cros_ec_hwmon_read_temp_threshold(priv->cros_ec, 0, EC_TEMP_THRESH_HIGH, &threshold);
+	if (ret == 0)
+		priv->has_temp_threshold = 1;
+
 	if (thermal_version < 2)
 		candidates = EC_TEMP_SENSOR_ENTRIES;
 	else

-- 
2.45.2


