Return-Path: <linux-kernel+bounces-563441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBFAA641E7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA1907A3D1A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 06:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC53219EB6;
	Mon, 17 Mar 2025 06:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A74Kj2bN"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25537219E8F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 06:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742193644; cv=none; b=VcFTWDs6oYrqGNeDG4PtVKAU1HNGoxRamtpcbcmljcLbzPG+DwETRYgB0hE+5rHKEby+g3UoL+3yH/20iWYmAqqyLQuKtxaK22SwskWsIJ+L/aOHPZoU2CxqLUCnpm7WHlnNC5sAn86D7z4VoCJwJ69GlKc7/lrVeGMc+yycCcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742193644; c=relaxed/simple;
	bh=NNI2Z3H1Z1taOsrJKmGeSBymwwLbUWhciwJiqkKYPCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nCal/f3E3KRk972r/8H2NLDrGeTbSYAenXPsjLWJH2fsgE0aocc/bSxs0Zh9vZsUU9NqxbW2gn+MSWoj4h8XMf+QHOmcHDL6LlPUORIRYzouvfzGnj8m8W8ACXnZ0lBGKmRI+wiEtFk1ncBFpGgbnfeQL+g1JxBt8XGfV1afU/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A74Kj2bN; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-226185948ffso7822525ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 23:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742193642; x=1742798442; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RQk6j3M79hEoncMWZINU1Z+Ssb2ztnm1q7nYaYaJel4=;
        b=A74Kj2bN8RzNF6xY27nTGHikvtr0zFUrDIcTicqhIiOR1Oi/MaQSOcogUxezRoh2sY
         rBE2tWf3I+rXXw9Bw+UWXUSbPWUh6zh5cnzwVTWLnQxm5I500kXfEeBaS89ztPOj6eWk
         yVNlzne416Iv25slV/KE+GGd82E3+y2cG3UaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742193642; x=1742798442;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RQk6j3M79hEoncMWZINU1Z+Ssb2ztnm1q7nYaYaJel4=;
        b=S963U0/jK7Zy2Z1eDwWuPmzenZ89WsVv57PYgiBy8uar7tOdJYtJpgvRiLYr3+0QEy
         VIpOONWDAioA+tgC8YsQAq0ueBF6EGt6MXYpyeuaJfehZFIygnSnNUkAjO15b5LfzWF/
         i+qlHTr41ImsPill0hxvbnMiFg/xam9K/xdKA1wnGw5TDCT1K8CAZ9FG4/95ilCSEIXv
         n3vOdDt+7qNbYYkTQ8UFCfKsShiWdVyJZKrX8VVj9nPDKsABq1/ZxyCXmiCMUzotqSTU
         v5qOvQeHyorTkV3x2A4fTDS4gVGoWKNYlh0WVgwS8Z78ZjO6fdVrvnZznGtDRg2VVapD
         PuBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVKwFLFGZ/RMAWN5zwrknO7zGHbdQLiM3FKo8MytDyrJL5+5ct887HRurraQvv4qEAtW5yNTlnxcv/VuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmfXgdy+ExApvM/Jym0bzo65d8X27sH8ywyFYSMGPFL1+Ihk2h
	6Q4WrkPeQnuNfgf5jCHp4aXg07Z8wtMItgoOTZmkCNMAlFCY8dq8ILU+tx8ScoRh2I5XiU55JwI
	=
X-Gm-Gg: ASbGncv1AI9ykNSUgCVmsWjZm3yIeZj0zS2b2iw5mHrfVbIXpGDKYMbYKH37lRdzd2u
	ZbengT8xNXiJ31mF1HETdoYUaDjoDKolzbHVO/FhBLXaPpGWeQWScxg+ZCMw3x7VtBWBCJI0OvQ
	GDy692muX4uGu3w4YPItU63DU92U7vpnTzHNpZ2Im+2J2fO4O+s7w8ttZ+3+zVx3tvP2ixHefi8
	JaC4reyn/cZMcL+JhMfyCVMamQdZ4LNO4oZgWFphATegnWtP78pv95I1ePYgC5URU77VDA4Ex7z
	eVQA+NEBkFdu9FwOuG17fiV1MUaR5atDjkQK8Ctqr/N14CpGBfd7WFJndQ5AkPcT07o=
X-Google-Smtp-Source: AGHT+IGvST1WW6xrrmRCUrQ9geHSg+2is3Fy2cyAzWBdbqKnhPLUHPqAQ6MYtun3HvFH4+LCOhrjkQ==
X-Received: by 2002:a17:902:e84e:b0:224:c76:5e56 with SMTP id d9443c01a7336-225e0a6b222mr134440485ad.27.1742193642285;
        Sun, 16 Mar 2025 23:40:42 -0700 (PDT)
Received: from lschyi-p920.tpe.corp.google.com ([2401:fa00:1:10:77b5:e0b8:95d2:83db])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbcb24sm67619675ad.169.2025.03.16.23.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 23:40:41 -0700 (PDT)
From: Sung-Chi Li <lschyi@chromium.org>
Date: Mon, 17 Mar 2025 14:40:26 +0800
Subject: [PATCH v2] hwmon: (cros_ec) Add set and get target fan RPM
 function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-extend_ec_hwmon_fan-v2-1-13670557afe5@chromium.org>
X-B4-Tracking: v=1; b=H4sIANnD12cC/32NQQ6DIBBFr2JmXRrFgmlXvUdjCOIgsxAasNTGe
 PdSD9Dle8l/f4OEkTDBrdogYqZEwRfgpwqM035CRmNh4DUXddu0DNcF/ajQKPeeg1dWe6aFFVe
 tB26GFsryGdHSelQffWFHaQnxc5zk5mf/93LDaiaMkLLrpOXmcjcuhple8znECfp937+jYcglu
 QAAAA==
X-Change-ID: 20250313-extend_ec_hwmon_fan-a5f59aab2cb3
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>, chrome-platform@lists.linux.dev, 
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sung-Chi Li <lschyi@chromium.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742193640; l=8426;
 i=lschyi@chromium.org; s=20241113; h=from:subject:message-id;
 bh=NNI2Z3H1Z1taOsrJKmGeSBymwwLbUWhciwJiqkKYPCc=;
 b=ICbiLycT3VjgaMdDZnSIQZOmLY1PFd1I1c7IyKvp7jnTi9I4PzfXt5M6yyXhm3oHEWFVCwZgZ
 PiU2t7CIWcQACWIOg18QJIiP/9FAM5PZ278hQspJIav1d8egOr31QrA
X-Developer-Key: i=lschyi@chromium.org; a=ed25519;
 pk=nE3PJlqSK35GdWfB4oVLOwi4njfaUZRhM66HGos9P6o=

The ChromeOS embedded controller (EC) supports closed loop fan speed
control, so add the fan target attribute under hwmon framework, such
that kernel can expose reading and specifying the desired fan RPM for
fans connected to the EC.

When probing the cros_ec hwmon module, we also check the supported
command version of setting target fan RPM. This commit implements the
version 0 of getting the target fan RPM, which can only read the target
RPM of the first fan. This commit also implements the version 0 and 1 of
setting the target fan RPM, where the version 0 only supports setting
all fan to the same RPM, while version 1 supports setting different RPM
to each fan respectively.

Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
---
ChromeOS embedded controller (EC) supports closed-loop fan control. We
anticipate to have the fan related control from the kernel side, so this
series register the HWMON_F_TARGET attribute, and implement the read and
write function for setting/reading the target fan RPM from the EC side.
---
Changes in v2:

- Squash the read, write, and register of fan target attribute to 1
  commit, as they are the same topic.
- Probe the supported command version from EC for setting the target fan
  RPM, and perform the set fan target RPM based on the supported
  version.
- Update the used variable type to kernel types (i.e., u32).
- Link to v1: https://lore.kernel.org/r/20250313-extend_ec_hwmon_fan-v1-0-5c566776f2c4@chromium.org
---
 drivers/hwmon/cros_ec_hwmon.c | 130 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 125 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/cros_ec_hwmon.c b/drivers/hwmon/cros_ec_hwmon.c
index 9991c3fa020ac859cbbff29dfb669e53248df885..b118a355f67d7238a6f596cf01a49d5b621b31d6 100644
--- a/drivers/hwmon/cros_ec_hwmon.c
+++ b/drivers/hwmon/cros_ec_hwmon.c
@@ -21,6 +21,12 @@ struct cros_ec_hwmon_priv {
 	struct cros_ec_device *cros_ec;
 	const char *temp_sensor_names[EC_TEMP_SENSOR_ENTRIES + EC_TEMP_SENSOR_B_ENTRIES];
 	u8 usable_fans;
+	int set_fan_target_rpm_version;
+};
+
+union ec_params_pwm_set_fan_target_rpm {
+	struct ec_params_pwm_set_fan_target_rpm_v0 v0;
+	struct ec_params_pwm_set_fan_target_rpm_v1 v1;
 };
 
 static int cros_ec_hwmon_read_fan_speed(struct cros_ec_device *cros_ec, u8 index, u16 *speed)
@@ -36,6 +42,25 @@ static int cros_ec_hwmon_read_fan_speed(struct cros_ec_device *cros_ec, u8 index
 	return 0;
 }
 
+static int cros_ec_hwmon_read_fan_target(struct cros_ec_device *cros_ec,
+					 u8 index, u32 *speed)
+{
+	struct ec_response_pwm_get_fan_rpm r;
+	int ret;
+
+	// Currently only supports reading the first fan.
+	if (index > 0)
+		return -EOPNOTSUPP;
+
+	ret = cros_ec_cmd(cros_ec, 0, EC_CMD_PWM_GET_FAN_TARGET_RPM, NULL, 0,
+			  &r, sizeof(r));
+	if (ret < 0)
+		return ret;
+
+	*speed = r.rpm;
+	return 0;
+}
+
 static int cros_ec_hwmon_read_temp(struct cros_ec_device *cros_ec, u8 index, u8 *temp)
 {
 	unsigned int offset;
@@ -52,6 +77,49 @@ static int cros_ec_hwmon_read_temp(struct cros_ec_device *cros_ec, u8 index, u8
 	return 0;
 }
 
+static int cros_ec_hwmon_set_fan_rpm(struct cros_ec_device *cros_ec,
+				     int version, u8 index, u16 val)
+{
+	union ec_params_pwm_set_fan_target_rpm req;
+	int req_size;
+	int ret;
+
+	if (version == 0) {
+		if (index != 0)
+			dev_warn(
+				cros_ec->dev,
+				"v0 only supports setting all fan to same RPM (cannot just set idx %d), set all to %d\n",
+				index, val);
+
+		req_size = sizeof(req.v0);
+		req.v0.rpm = val;
+	} else if (version == 1) {
+		req_size = sizeof(req.v1);
+		req.v1.rpm = val;
+		req.v1.fan_idx = index;
+	} else
+		return -EOPNOTSUPP;
+
+	ret = cros_ec_cmd(cros_ec, version, EC_CMD_PWM_SET_FAN_TARGET_RPM, &req,
+			  req_size, NULL, 0);
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
+static int cros_ec_hwmon_write_fan(struct cros_ec_hwmon_priv *priv, u32 attr,
+				   int channel, long rpm)
+{
+	switch (attr) {
+	case hwmon_fan_target:
+		return cros_ec_hwmon_set_fan_rpm(
+			priv->cros_ec, priv->set_fan_target_rpm_version,
+			channel, rpm);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static bool cros_ec_hwmon_is_error_fan(u16 speed)
 {
 	return speed == EC_FAN_SPEED_NOT_PRESENT || speed == EC_FAN_SPEED_STALLED;
@@ -75,6 +143,7 @@ static int cros_ec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 {
 	struct cros_ec_hwmon_priv *priv = dev_get_drvdata(dev);
 	int ret = -EOPNOTSUPP;
+	u32 target_rpm;
 	u16 speed;
 	u8 temp;
 
@@ -91,6 +160,11 @@ static int cros_ec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 			ret = cros_ec_hwmon_read_fan_speed(priv->cros_ec, channel, &speed);
 			if (ret == 0)
 				*val = cros_ec_hwmon_is_error_fan(speed);
+		} else if (attr == hwmon_fan_target) {
+			ret = cros_ec_hwmon_read_fan_target(
+				priv->cros_ec, channel, &target_rpm);
+			if (ret == 0)
+				*val = target_rpm;
 		}
 	} else if (type == hwmon_temp) {
 		if (attr == hwmon_temp_input) {
@@ -130,8 +204,15 @@ static umode_t cros_ec_hwmon_is_visible(const void *data, enum hwmon_sensor_type
 	const struct cros_ec_hwmon_priv *priv = data;
 
 	if (type == hwmon_fan) {
-		if (priv->usable_fans & BIT(channel))
+		if (!(priv->usable_fans & BIT(channel)))
+			return 0;
+
+		switch (attr) {
+		case hwmon_fan_target:
+			return 0644;
+		default:
 			return 0444;
+		}
 	} else if (type == hwmon_temp) {
 		if (priv->temp_sensor_names[channel])
 			return 0444;
@@ -140,13 +221,26 @@ static umode_t cros_ec_hwmon_is_visible(const void *data, enum hwmon_sensor_type
 	return 0;
 }
 
+static int cros_ec_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
+			      u32 attr, int channel, long val)
+{
+	struct cros_ec_hwmon_priv *priv = dev_get_drvdata(dev);
+
+	switch (type) {
+	case hwmon_fan:
+		return cros_ec_hwmon_write_fan(priv, attr, channel, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static const struct hwmon_channel_info * const cros_ec_hwmon_info[] = {
 	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
 	HWMON_CHANNEL_INFO(fan,
-			   HWMON_F_INPUT | HWMON_F_FAULT,
-			   HWMON_F_INPUT | HWMON_F_FAULT,
-			   HWMON_F_INPUT | HWMON_F_FAULT,
-			   HWMON_F_INPUT | HWMON_F_FAULT),
+			   HWMON_F_INPUT | HWMON_F_FAULT | HWMON_F_TARGET,
+			   HWMON_F_INPUT | HWMON_F_FAULT | HWMON_F_TARGET,
+			   HWMON_F_INPUT | HWMON_F_FAULT | HWMON_F_TARGET,
+			   HWMON_F_INPUT | HWMON_F_FAULT | HWMON_F_TARGET),
 	HWMON_CHANNEL_INFO(temp,
 			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
 			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
@@ -178,6 +272,7 @@ static const struct hwmon_channel_info * const cros_ec_hwmon_info[] = {
 static const struct hwmon_ops cros_ec_hwmon_ops = {
 	.read = cros_ec_hwmon_read,
 	.read_string = cros_ec_hwmon_read_string,
+	.write = cros_ec_hwmon_write,
 	.is_visible = cros_ec_hwmon_is_visible,
 };
 
@@ -233,6 +328,27 @@ static void cros_ec_hwmon_probe_fans(struct cros_ec_hwmon_priv *priv)
 	}
 }
 
+static int cros_ec_hwmon_probe_fan_target_cmd_version(struct cros_ec_hwmon_priv *priv)
+{
+	struct ec_params_get_cmd_versions_v1 params = {
+		.cmd = EC_CMD_PWM_SET_FAN_TARGET_RPM,
+	};
+	struct ec_response_get_cmd_versions response;
+	int ret;
+
+	ret = cros_ec_cmd(priv->cros_ec, 1, EC_CMD_GET_CMD_VERSIONS, &params,
+			  sizeof(params), &response, sizeof(response));
+	if (ret < 0) {
+		dev_err(priv->cros_ec->dev,
+			"error getting target fan RPM set command version: %d\n", ret);
+		return ret;
+	}
+
+	priv->set_fan_target_rpm_version = (response.version_mask & EC_VER_MASK(1)) ? 1 : 0;
+
+	return 0;
+}
+
 static int cros_ec_hwmon_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -260,6 +376,10 @@ static int cros_ec_hwmon_probe(struct platform_device *pdev)
 	cros_ec_hwmon_probe_temp_sensors(dev, priv, thermal_version);
 	cros_ec_hwmon_probe_fans(priv);
 
+	ret = cros_ec_hwmon_probe_fan_target_cmd_version(priv);
+	if (ret < 0)
+		return ret;
+
 	hwmon_dev = devm_hwmon_device_register_with_info(dev, "cros_ec", priv,
 							 &cros_ec_hwmon_chip_info, NULL);
 

---
base-commit: 80e54e84911a923c40d7bee33a34c1b4be148d7a
change-id: 20250313-extend_ec_hwmon_fan-a5f59aab2cb3

Best regards,
-- 
Sung-Chi Li <lschyi@chromium.org>


