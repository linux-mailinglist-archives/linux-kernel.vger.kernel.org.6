Return-Path: <linux-kernel+bounces-565643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7825CA66C9D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DAEF3ADC13
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6E31EFFA8;
	Tue, 18 Mar 2025 07:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cowl+tMD"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B10F185B4C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 07:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742283932; cv=none; b=PmwLFgzFBNE8RciOMvT08ZMWokRF1esC/QBL7+pn2yUESCzsX9KKGtb7RCGTe2Y7sAPtptAsJMxfkcyAOMwNUnt8DbfEUICR3f40GYRqoidA7dxY9vHfRK07VHiy0DmucEC/06NzeuEwwc/OBlemRhauN7httOBTE8FS/4dpAKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742283932; c=relaxed/simple;
	bh=5/FIovSNSR5c/7qz/TJ34uIJy/QRHE/ED9If2++ygGs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=u/Q08nNTSEIVU6nb7SwMRaTltKGEOIVIYw7J54eKXSryikdw8YtIYr0FlNxBmm8IwimT4ZT1Pc5Ca0lmylsDB1GoxXk7F71CsNlJXw8HVKCWCHjGICsRG+5EoHa7TwtlPnWnou6+V4jnLkkabotXOpQCuRhjYZU86u0SlRMMUuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cowl+tMD; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2239c066347so109602225ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 00:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742283929; x=1742888729; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5myKVatSfN7fLvXu2WGUZkTCymQrL+tAPuTPdKmXDM8=;
        b=cowl+tMDl0KJybGiWYGn5JV21DCmKfXUrrDlpUUWQtnRBsbrZ/ZEnkEPXTUbkc8DwL
         5Eb8wQ2RUMACcd1AWfh2rYLPiqsOD73yQi6uzR6AXdTmLTxcOinHKNr2rnT0kdOm+zmi
         G5fni0gyfLOD0l+BWRFRwlDhRRJITcqCeeCik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742283929; x=1742888729;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5myKVatSfN7fLvXu2WGUZkTCymQrL+tAPuTPdKmXDM8=;
        b=rgU94Q8O2qxZ9KI0oWcQso677/MBQVqC0mb3EWicerWhNXUXsFcmPY30wUQAefYMOH
         sJ7W9k7JkZjbHTcl+ohtsrx7uMO/UspPBDTEUU3G8NX1rL1mjMOvStspsSogDtJJCzpx
         S2pNLWxLVzi7Q+kLzWH4qNSfn3owZrlg5N6V/TrvGKzHJMhUwYmQMEaaYFJ7UID1wrqV
         6cRLcfLTNlugtKuHKbLWdw/kcwuvdkYLCiYuafmR/Os7VagL34NSS/+rF8b5jvGzDEwh
         mn5Q3PrfCs/zmFGjENsE5bD2WmhNpscoI2kN+xrDswOfHLa6mc+lCIuobt0XmoNTQclQ
         Fdbg==
X-Forwarded-Encrypted: i=1; AJvYcCU1SdlwT3D2IRpBWmcjnhfaHXFf/Zc7BpstvrO7tbwrIV3ZdOVDgeshBZPs0UmNc7R+TVDdTDdPTwxnDjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpHlhyMh4aIR9HmKIVgVOuqIZF+FRQJiIiL66hE0S345rPe/Po
	O12q7vze4DfnaVaTntBULZ5kBdCI9RS9LkprjDz+u3NUhvOh96nvv62rEZSRWA==
X-Gm-Gg: ASbGncuQRvLx+LI4/8AAkLN1cl9KRCqm5sCllyzc852rmXDianAoqUDORvN58JYFKuA
	be5q/UfZU87CqKbezYPNEm36MdqLchSCW4lpoC470RtkOLEthx3Dbd39PJB7TZONjb1QRMMMLex
	x/FLCd5Lhag8gn78ybNZWAjoBlg0YpzTGrrmeEmlGF3QIkHI664XsWOI5RY6JEI+fJ1IpzdoNPZ
	bbqJv0ppqhqLPIt5Mryw+jm13NBQc5RGXj5q+fpVxlIrhphJ9XcvF1kCGQwzNkmg5CSzsvAuliF
	kwnx85eXv30VhaoztXFm1FmlWfKhH7WPKhlG8f3u6wTQA3JuSeHiMEA+UUmGBtrL5Fo=
X-Google-Smtp-Source: AGHT+IGmk2nTiV7s08pvMCd8OHe9edENdn8pgAYtk9PDerWDiP2SUUByJ0oxwb6HjjJpnTkkW1LH2g==
X-Received: by 2002:a17:903:17cd:b0:223:f408:c3f8 with SMTP id d9443c01a7336-225e0a4a198mr175109025ad.14.1742283929317;
        Tue, 18 Mar 2025 00:45:29 -0700 (PDT)
Received: from lschyi-p920.tpe.corp.google.com ([2401:fa00:1:10:3904:afc7:e35e:2274])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4ae8sm87328165ad.243.2025.03.18.00.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 00:45:28 -0700 (PDT)
From: Sung-Chi Li <lschyi@chromium.org>
Date: Tue, 18 Mar 2025 15:45:23 +0800
Subject: [PATCH v3] hwmon: (cros_ec) Add set and get target fan RPM
 function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-extend_ec_hwmon_fan-v3-1-4c886385861f@chromium.org>
X-B4-Tracking: v=1; b=H4sIAJIk2WcC/33NTQ7CIBCG4asY1mL4EYiuvIcxDaVDYVEwULGm6
 d2lXRljXL5fMs/MKEPykNF5N6MExWcfQw2+3yHjdOgB+642YoQJwinHMI0QugZM455DDI3VAWt
 hxUnrlpmWo3p5T2D9tKnXW23n8xjTa3tS6Lr+9wrFBAsjpFRKWmaOF+NSHPxjOMTUo5Us7JNRv
 xmGKaZcKiKE0hbEF7MsyxtRWtjmAAEAAA==
X-Change-ID: 20250313-extend_ec_hwmon_fan-a5f59aab2cb3
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>, chrome-platform@lists.linux.dev, 
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sung-Chi Li <lschyi@chromium.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742283927; l=7808;
 i=lschyi@chromium.org; s=20241113; h=from:subject:message-id;
 bh=5/FIovSNSR5c/7qz/TJ34uIJy/QRHE/ED9If2++ygGs=;
 b=iMx2q+Rr+I9wwrYsHocgX1PfEquEOu50fWCx4Ue53jz0cKexDFrv0hzZEZpQMsv+MWXUofkU2
 /pa2Bq+QwumDBrOJAMHwF+GhnyQGMTXv/Oo3JYHbBMwsVQsY8Pmvgk7
X-Developer-Key: i=lschyi@chromium.org; a=ed25519;
 pk=nE3PJlqSK35GdWfB4oVLOwi4njfaUZRhM66HGos9P6o=

The ChromeOS embedded controller (EC) supports closed loop fan speed
control, so add the fan target attribute under hwmon framework, such
that kernel can expose reading and specifying the desired fan RPM for
fans connected to the EC.

When probing the cros_ec hwmon module, we also check the supported
command version of setting target fan RPM. This commit implements the
version 0 of getting the target fan RPM, which can only read the target
RPM of the first fan. This commit also implements the version 1 of
setting the target fan RPM to each fan respectively.

Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
---
ChromeOS embedded controller (EC) supports closed-loop fan control. We
anticipate to have the fan related control from the kernel side, so this
series register the HWMON_F_TARGET attribute, and implement the read and
write function for setting/reading the target fan RPM from the EC side.
---
Changes in v3:
- Drop support of v0 setting target fan RPM, thus also simplify
  implementations.
- Align coding style to existing code, including using if-else rather
  than switch-case, and ensure little endian conversion from read data.
- Only log warning for failed probing get fan target command version
  instead of fail the whole driver.
- Link to v2: https://lore.kernel.org/r/20250317-extend_ec_hwmon_fan-v2-1-13670557afe5@chromium.org

Changes in v2:
- Squash the read, write, and register of fan target attribute to 1
  commit, as they are the same topic.
- Probe the supported command version from EC for setting the target fan
  RPM, and perform the set fan target RPM based on the supported
  version.
- Update the used variable type to kernel types (i.e., u32).
- Link to v1: https://lore.kernel.org/r/20250313-extend_ec_hwmon_fan-v1-0-5c566776f2c4@chromium.org
---
 drivers/hwmon/cros_ec_hwmon.c | 90 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 85 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/cros_ec_hwmon.c b/drivers/hwmon/cros_ec_hwmon.c
index 9991c3fa020ac859cbbff29dfb669e53248df885..d54fd85ccb4350fc297bde62a2d98f386ce1a8de 100644
--- a/drivers/hwmon/cros_ec_hwmon.c
+++ b/drivers/hwmon/cros_ec_hwmon.c
@@ -21,6 +21,7 @@ struct cros_ec_hwmon_priv {
 	struct cros_ec_device *cros_ec;
 	const char *temp_sensor_names[EC_TEMP_SENSOR_ENTRIES + EC_TEMP_SENSOR_B_ENTRIES];
 	u8 usable_fans;
+	int set_fan_target_rpm_version;
 };
 
 static int cros_ec_hwmon_read_fan_speed(struct cros_ec_device *cros_ec, u8 index, u16 *speed)
@@ -36,6 +37,21 @@ static int cros_ec_hwmon_read_fan_speed(struct cros_ec_device *cros_ec, u8 index
 	return 0;
 }
 
+static int cros_ec_hwmon_read_fan_target(struct cros_ec_device *cros_ec,
+					 u32 *speed)
+{
+	struct ec_response_pwm_get_fan_rpm r;
+	int ret;
+
+	ret = cros_ec_cmd(cros_ec, 0, EC_CMD_PWM_GET_FAN_TARGET_RPM, NULL, 0,
+			  &r, sizeof(r));
+	if (ret < 0)
+		return ret;
+
+	*speed = le32_to_cpu((__force __le32)r.rpm);
+	return 0;
+}
+
 static int cros_ec_hwmon_read_temp(struct cros_ec_device *cros_ec, u8 index, u8 *temp)
 {
 	unsigned int offset;
@@ -52,6 +68,31 @@ static int cros_ec_hwmon_read_temp(struct cros_ec_device *cros_ec, u8 index, u8
 	return 0;
 }
 
+static int cros_ec_hwmon_set_fan_rpm(struct cros_ec_device *cros_ec, u8 index,
+				     u16 val)
+{
+	struct ec_params_pwm_set_fan_target_rpm_v1 req = {
+		.rpm = val,
+		.fan_idx = index,
+	};
+	int ret;
+
+	ret = cros_ec_cmd(cros_ec, 1, EC_CMD_PWM_SET_FAN_TARGET_RPM, &req,
+			  sizeof(req), NULL, 0);
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
+static int cros_ec_hwmon_write_fan(struct cros_ec_hwmon_priv *priv, u32 attr,
+				   int channel, long rpm)
+{
+	if (attr == hwmon_fan_target)
+		return cros_ec_hwmon_set_fan_rpm(priv->cros_ec, channel, rpm);
+	else
+		return -EOPNOTSUPP;
+}
+
 static bool cros_ec_hwmon_is_error_fan(u16 speed)
 {
 	return speed == EC_FAN_SPEED_NOT_PRESENT || speed == EC_FAN_SPEED_STALLED;
@@ -75,6 +116,7 @@ static int cros_ec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 {
 	struct cros_ec_hwmon_priv *priv = dev_get_drvdata(dev);
 	int ret = -EOPNOTSUPP;
+	u32 target_rpm;
 	u16 speed;
 	u8 temp;
 
@@ -91,6 +133,11 @@ static int cros_ec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 			ret = cros_ec_hwmon_read_fan_speed(priv->cros_ec, channel, &speed);
 			if (ret == 0)
 				*val = cros_ec_hwmon_is_error_fan(speed);
+		} else if (attr == hwmon_fan_target) {
+			ret = cros_ec_hwmon_read_fan_target(
+				priv->cros_ec, &target_rpm);
+			if (ret == 0)
+				*val = target_rpm;
 		}
 	} else if (type == hwmon_temp) {
 		if (attr == hwmon_temp_input) {
@@ -130,7 +177,15 @@ static umode_t cros_ec_hwmon_is_visible(const void *data, enum hwmon_sensor_type
 	const struct cros_ec_hwmon_priv *priv = data;
 
 	if (type == hwmon_fan) {
-		if (priv->usable_fans & BIT(channel))
+		if (!(priv->usable_fans & BIT(channel)))
+			return 0;
+
+		if (attr == hwmon_fan_target) {
+			if (priv->set_fan_target_rpm_version == 1)
+				return (channel == 0) ? 0644 : 0200;
+			else
+				return 0;
+		} else
 			return 0444;
 	} else if (type == hwmon_temp) {
 		if (priv->temp_sensor_names[channel])
@@ -140,13 +195,24 @@ static umode_t cros_ec_hwmon_is_visible(const void *data, enum hwmon_sensor_type
 	return 0;
 }
 
+static int cros_ec_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
+			      u32 attr, int channel, long val)
+{
+	struct cros_ec_hwmon_priv *priv = dev_get_drvdata(dev);
+
+	if (type == hwmon_fan)
+		return cros_ec_hwmon_write_fan(priv, attr, channel, val);
+	else
+		return -EOPNOTSUPP;
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
@@ -178,6 +244,7 @@ static const struct hwmon_channel_info * const cros_ec_hwmon_info[] = {
 static const struct hwmon_ops cros_ec_hwmon_ops = {
 	.read = cros_ec_hwmon_read,
 	.read_string = cros_ec_hwmon_read_string,
+	.write = cros_ec_hwmon_write,
 	.is_visible = cros_ec_hwmon_is_visible,
 };
 
@@ -233,6 +300,18 @@ static void cros_ec_hwmon_probe_fans(struct cros_ec_hwmon_priv *priv)
 	}
 }
 
+static void cros_ec_hwmon_probe_fan_target_cmd_version(struct cros_ec_hwmon_priv *priv)
+{
+	int ret;
+
+	ret =  cros_ec_get_cmd_versions(priv->cros_ec,  EC_CMD_GET_CMD_VERSIONS);
+	if (ret < 0) {
+		dev_warn(priv->cros_ec->dev,
+			"error getting target fan RPM set command version: %d\n", ret);
+	}
+	priv->set_fan_target_rpm_version = (ret > 0) ? 1 : 0;
+}
+
 static int cros_ec_hwmon_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -259,6 +338,7 @@ static int cros_ec_hwmon_probe(struct platform_device *pdev)
 
 	cros_ec_hwmon_probe_temp_sensors(dev, priv, thermal_version);
 	cros_ec_hwmon_probe_fans(priv);
+	cros_ec_hwmon_probe_fan_target_cmd_version(priv);
 
 	hwmon_dev = devm_hwmon_device_register_with_info(dev, "cros_ec", priv,
 							 &cros_ec_hwmon_chip_info, NULL);

---
base-commit: 80e54e84911a923c40d7bee33a34c1b4be148d7a
change-id: 20250313-extend_ec_hwmon_fan-a5f59aab2cb3

Best regards,
-- 
Sung-Chi Li <lschyi@chromium.org>


