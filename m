Return-Path: <linux-kernel+bounces-206943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1BE901024
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 10:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7086A1C21082
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 08:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22570176FC6;
	Sat,  8 Jun 2024 08:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="NXHN7oz/"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2D8176AC8;
	Sat,  8 Jun 2024 08:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717834372; cv=none; b=QRdKdxSJcvjEnV/BurLn9HhAM+cDOH+CK6YiA40UoNbzAfRIVJL17U43RDy33dYydzow0cBSy50921yNaiKWbukv7eQmFa8sxQ49Vlb5yhaQs/8eBQCTDCh9RdB20ir5P4klDecaybvuOU4Gwnluavn3J/ogj9DeoDhJ+b1cAcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717834372; c=relaxed/simple;
	bh=C6KO9oyesS6IVjxRm+VykrSOvpDomBKNbdZAZ0v59o0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MpY160BdT/2jWaAwu9l+NNLVf1PIIdgOZKkwMXvCfH0YeWJ6362MjoWsIKO/48B/tt633FaN3kU+98wNyhFPue4Qm/AajoC8HRW1OifUrTP72iX+6DwMbj0gtaih+nZ0RUZAZ/rOKfplxHQDT49cQtKQ+mebAMmW/FlaF0V/x2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=NXHN7oz/; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1717834365;
	bh=C6KO9oyesS6IVjxRm+VykrSOvpDomBKNbdZAZ0v59o0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NXHN7oz/2gN1zP49VsFsEgr8RIpDd6S4Ubu9r4VP1tO7N0DPHwiEjlE3bpLsK1vUw
	 ujkqJVUKgjAjAqdXPbleP2UGsIpFnTxpcRFb/JnkfsimDmejL7DCVB1B7Luci61XVc
	 oiTNaQxEoN6Qzi0DkDIFHbSczd/EOKxfvxdKA6tc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 08 Jun 2024 10:12:44 +0200
Subject: [PATCH 2/5] hwmon: (cros_ec) Add support for fan target speed
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240608-cros_ec-hwmon-pwm-v1-2-d29dfc26fbc3@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717834365; l=3031;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=C6KO9oyesS6IVjxRm+VykrSOvpDomBKNbdZAZ0v59o0=;
 b=qv15PLsgwUIENgiYdWwPSzIS25Z85DAHXFdenwvAT21Qi8sWWX2iex+J9TubAm/k6QtX/Q6AI
 LyGfBnywpG5CY8kNtlj9phjYdCbyFv3Y9xxZZIMt/SHM0ozTkMBhqQ8
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Use EC_CMD_PWM_GET_FAN_TARGET_RPM to retrieve the target fan speed.
The CrOS EC only supports this for the first fan.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 Documentation/hwmon/cros_ec_hwmon.rst |  6 +++++-
 drivers/hwmon/cros_ec_hwmon.c         | 26 +++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/hwmon/cros_ec_hwmon.rst b/Documentation/hwmon/cros_ec_hwmon.rst
index 47ecae983bdb..4aede331baeb 100644
--- a/Documentation/hwmon/cros_ec_hwmon.rst
+++ b/Documentation/hwmon/cros_ec_hwmon.rst
@@ -23,4 +23,8 @@ ChromeOS embedded controller used in Chromebooks and other devices.
 
 The channel labels exposed via hwmon are retrieved from the EC itself.
 
-Fan and temperature readings are supported.
+Supported features:
+
+  - Current fan speed
+  - Target fan speed (for fan 1 only)
+  - Current temperature
diff --git a/drivers/hwmon/cros_ec_hwmon.c b/drivers/hwmon/cros_ec_hwmon.c
index 5514cf780b8b..09b8057e1223 100644
--- a/drivers/hwmon/cros_ec_hwmon.c
+++ b/drivers/hwmon/cros_ec_hwmon.c
@@ -36,6 +36,20 @@ static int cros_ec_hwmon_read_fan_speed(struct cros_ec_device *cros_ec, u8 index
 	return 0;
 }
 
+static int cros_ec_hwmon_read_fan_target(struct cros_ec_device *cros_ec, u16 *speed)
+{
+	struct ec_response_pwm_get_fan_rpm resp;
+	int ret;
+
+	ret = cros_ec_cmd(cros_ec, 0, EC_CMD_PWM_GET_FAN_TARGET_RPM,
+			  NULL, 0, &resp, sizeof(resp));
+	if (ret < 0)
+		return ret;
+
+	*speed = resp.rpm;
+	return 0;
+}
+
 static int cros_ec_hwmon_read_temp(struct cros_ec_device *cros_ec, u8 index, u8 *temp)
 {
 	unsigned int offset;
@@ -91,6 +105,11 @@ static int cros_ec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 			ret = cros_ec_hwmon_read_fan_speed(priv->cros_ec, channel, &speed);
 			if (ret == 0)
 				*val = cros_ec_hwmon_is_error_fan(speed);
+
+		} else if (attr == hwmon_fan_target) {
+			ret = cros_ec_hwmon_read_fan_target(priv->cros_ec, &speed);
+			if (ret == 0)
+				*val = speed;
 		}
 	} else if (type == hwmon_temp) {
 		if (attr == hwmon_temp_input) {
@@ -128,8 +147,13 @@ static umode_t cros_ec_hwmon_is_visible(const void *data, enum hwmon_sensor_type
 					u32 attr, int channel)
 {
 	const struct cros_ec_hwmon_priv *priv = data;
+	u16 speed;
 
 	if (type == hwmon_fan) {
+		if (attr == hwmon_fan_target &&
+		    cros_ec_hwmon_read_fan_target(priv->cros_ec, &speed) == -EOPNOTSUPP)
+			return 0;
+
 		if (priv->usable_fans & BIT(channel))
 			return 0444;
 	} else if (type == hwmon_temp) {
@@ -142,7 +166,7 @@ static umode_t cros_ec_hwmon_is_visible(const void *data, enum hwmon_sensor_type
 
 static const struct hwmon_channel_info * const cros_ec_hwmon_info[] = {
 	HWMON_CHANNEL_INFO(fan,
-			   HWMON_F_INPUT | HWMON_F_FAULT,
+			   HWMON_F_INPUT | HWMON_F_FAULT | HWMON_F_TARGET,
 			   HWMON_F_INPUT | HWMON_F_FAULT,
 			   HWMON_F_INPUT | HWMON_F_FAULT,
 			   HWMON_F_INPUT | HWMON_F_FAULT),

-- 
2.45.2


