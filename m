Return-Path: <linux-kernel+bounces-197446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 023118D6AC2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 22:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E2821F2615B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 20:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D1217E469;
	Fri, 31 May 2024 20:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcigV4IT"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD26F8004A;
	Fri, 31 May 2024 20:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717187634; cv=none; b=pUXFVePiqnywwoqbDG2/wnnVENESY9SCTdMSXf7FmlOSVelOowUQixATcdjTTHTR7pmimzWchYRafRvES/5774yRIkLJ1W9ce4moJ54/iDiWracey7K65eJ6wrAHnpy+jfkVxoeeKXbwyn/DBnHzqqZDTl2crbXZ+nm0CE2BvI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717187634; c=relaxed/simple;
	bh=+7dtKjLD3lIwHtaoTxtl/YXckyVlH+3H9HrKHHp9Wyc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R1Uo2BKa66+eKRfJHotVv2Bqe1+bmNiTr/qgRwTZ/GYMNiMGS9h3wMNQKZeTx7W/vUJD7YBDS//+V0wJtiiUPBGvyFNYFR8wFfwbJ3XuiM9Z4aC1hnki9CS5zEVCAPHW4pd3UobIV6v6XApiVGFP7n8+sV7intyxj4ueNT3f+ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcigV4IT; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-702342c60dfso1524076b3a.2;
        Fri, 31 May 2024 13:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717187631; x=1717792431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9eRuoPFcU0MhFMvPhG+IPwfqxweonXAAsB8PwcsScg=;
        b=AcigV4ITvTtXUQ8Vr0OW4OA5ZTvrkKSp/HoebcxwOsXcAj6bfbtmCKhcmJDUUn7CSA
         URTtT9jpQmQto8s7MuxvFwSsll6KvCiHciHsVkc45NDF6YeQ15FTrQfxOyvYZF5ii6jG
         dlgBKDwRZRgapXMy3l1eNgJsJzlGnlBZvIlShulj5hiMGmtKjt0GnAwyK2hQxD2M2SKH
         j4qV4g+fOFQGHhldYM9d4m+y+F8BxfOoO6WcGefyrAkP66CTbcsq7wgkKUnAGuYaZxfg
         IbsksG31RViE1IJYsUjFuCx9AY/Xpc79wt7csMJ0jSv++MzD9CErvr+9wZHb+u7OYZ/T
         PdBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717187631; x=1717792431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k9eRuoPFcU0MhFMvPhG+IPwfqxweonXAAsB8PwcsScg=;
        b=tcHprLFygiFgpMcKakaN8ZWzhzrIVgQc/GpYDW1aH/8tclGs+JMnFuhAoQCqVM0SEy
         2M8WbfBBhI5jD3TPKj2blkmQv4DVSRhZYbRKMaB53kEGRi1eoHqX82Se+9f3HeGWpXOR
         bK14YKUeGQu6q7KKFxv0dnxLXaI7TOFReKV6ITG3mKlD0mFqukFmAmFN9klhuin6IHPO
         lT8ZsfBOQx83CUxtU+C5+whTJzKPs/4GWs5Pp7Jty137onZdeg8e+mTVrnhLf2aM5qdA
         sxnDHPzD0apU/+f5ikoc+mwj8ZtR1GA7IJubqUS8ojhawrF1lJgESWkvDuTpY0Nj4I+5
         UNmQ==
X-Gm-Message-State: AOJu0YyjHcXqzhozPQnk8GU19riBksTDBKOTLkNfGi7wkYSY3KQXrNwE
	JPog5XRrrp9sJhg4NzaWJg/lQvtwNkgHGSoiaKB+HD8hTiV8rxAXCMF1kg==
X-Google-Smtp-Source: AGHT+IEebwQED0LbomUMxHV3/JtMtP6ifv2HoXK9xr07GSDVXZFNqgT2x9iCT0AY25eoI+Q2Nd0/kQ==
X-Received: by 2002:a05:6a00:1a86:b0:702:2749:608b with SMTP id d2e1a72fcca58-702477bb6a7mr3438898b3a.1.1717187631553;
        Fri, 31 May 2024 13:33:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702423cb6fasm1767556b3a.8.2024.05.31.13.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 13:33:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Nuno Sa <nuno.sa@analog.com>,
	Radu Sabau <radu.sabau@analog.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 1/2] hwmon: Add PEC attribute support to hardware monitoring core
Date: Fri, 31 May 2024 13:33:45 -0700
Message-Id: <20240531203346.1396055-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240531203346.1396055-1-linux@roeck-us.net>
References: <20240531203346.1396055-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several hardware monitoring chips optionally support Packet Error Checking
(PEC). For some chips, PEC support can be enabled simply by setting
I2C_CLIENT_PEC in the i2c client data structure. Others require chip
specific code to enable or disable PEC support.

Introduce hwmon_chip_pec and HWMON_C_PEC to simplify adding configurable
PEC support for hardware monitoring drivers. A driver can set HWMON_C_PEC
in its chip information data to indicate PEC support. If a chip requires
chip specific code to enable or disable PEC support, the driver only needs
to implement support for the hwmon_chip_pec attribute to its write
function.

Packet Error Checking is only supported for SMBus devices. HWMON_C_PEC
must therefore only be set by a driver if the parent device is an I2C
device. Attempts to set HWMON_C_PEC on any other device type is not
supported and rejected.

The code calls i2c_check_functionality() to check if PEC is supported
by the I2C/SMBus controller. This function is only available if CONFIG_I2C
is enabled. For this reason, the added code needs to depend on CONFIG_I2C.

Cc: Radu Sabau <radu.sabau@analog.com>
Acked-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Use sysfs_emit()
    Return -EINVAL if the parent device is not an i2c client device
    Added code needs to be enclosed in "#ifdef(CONFIG_I2C)"
    Added Nuno's Acked-by: tag.

 drivers/hwmon/Kconfig |   1 +
 drivers/hwmon/hwmon.c | 147 +++++++++++++++++++++++++++++++++++++-----
 include/linux/hwmon.h |   2 +
 3 files changed, 134 insertions(+), 16 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index e14ae18a973b..7f384a2494c9 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -6,6 +6,7 @@
 menuconfig HWMON
 	tristate "Hardware Monitoring support"
 	depends on HAS_IOMEM
+	depends on I2C || I2C=n
 	default y
 	help
 	  Hardware monitoring devices let you monitor the hardware health
diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 3b259c425ab7..894cbe992bdf 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/gfp.h>
 #include <linux/hwmon.h>
+#include <linux/i2c.h>
 #include <linux/idr.h>
 #include <linux/kstrtox.h>
 #include <linux/list.h>
@@ -309,6 +310,114 @@ static int hwmon_attr_base(enum hwmon_sensor_types type)
 	return 1;
 }
 
+#if IS_ENABLED(CONFIG_I2C)
+
+/*
+ * PEC support
+ *
+ * The 'pec' attribute is attached to I2C client devices. It is only provided
+ * if the i2c controller supports PEC.
+ *
+ * The mutex ensures that PEC configuration between i2c device and the hardware
+ * is consistent. Use a single mutex because attribute writes are supposed to be
+ * rare, and maintaining a separate mutex for each hardware monitoring device
+ * would add substantial complexity to the driver for little if any gain.
+ *
+ * The hardware monitoring device is identified as child of the i2c client
+ * device. This assumes that only a single hardware monitoring device is
+ * attached to an i2c client device.
+ */
+
+static DEFINE_MUTEX(hwmon_pec_mutex);
+
+static int hwmon_match_device(struct device *dev, void *data)
+{
+	return dev->class == &hwmon_class;
+}
+
+static ssize_t pec_show(struct device *dev, struct device_attribute *dummy,
+			char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	return sysfs_emit(buf, "%d\n", !!(client->flags & I2C_CLIENT_PEC));
+}
+
+static ssize_t pec_store(struct device *dev, struct device_attribute *devattr,
+			 const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct hwmon_device *hwdev;
+	struct device *hdev;
+	bool val;
+	int err;
+
+	err = kstrtobool(buf, &val);
+	if (err < 0)
+		return err;
+
+	hdev = device_find_child(dev, NULL, hwmon_match_device);
+	if (!hdev)
+		return -ENODEV;
+
+	mutex_lock(&hwmon_pec_mutex);
+
+	/*
+	 * If there is no write function, we assume that chip specific
+	 * handling is not required.
+	 */
+	hwdev = to_hwmon_device(hdev);
+	if (hwdev->chip->ops->write) {
+		err = hwdev->chip->ops->write(hdev, hwmon_chip, hwmon_chip_pec, 0, val);
+		if (err && err != -EOPNOTSUPP)
+			goto unlock;
+	}
+
+	if (!val)
+		client->flags &= ~I2C_CLIENT_PEC;
+	else
+		client->flags |= I2C_CLIENT_PEC;
+
+	err = count;
+unlock:
+	mutex_unlock(&hwmon_pec_mutex);
+	put_device(hdev);
+
+	return err;
+}
+
+static DEVICE_ATTR_RW(pec);
+
+static void hwmon_remove_pec(void *dev)
+{
+	device_remove_file(dev, &dev_attr_pec);
+}
+
+static int hwmon_pec_register(struct device *hdev)
+{
+	struct i2c_client *client = i2c_verify_client(hdev->parent);
+	int err;
+
+	if (!client)
+		return -EINVAL;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_PEC))
+		return 0;
+
+	err = device_create_file(&client->dev, &dev_attr_pec);
+	if (err)
+		return err;
+
+	return devm_add_action_or_reset(hdev, hwmon_remove_pec, &client->dev);
+}
+
+#else /* CONFIG_I2C */
+static int hwmon_pec_register(struct device *hdev)
+{
+	return -EINVAL;
+}
+#endif /* CONFIG_I2C */
+
 /* sysfs attribute management */
 
 static ssize_t hwmon_attr_show(struct device *dev,
@@ -397,10 +506,6 @@ static struct attribute *hwmon_genattr(const void *drvdata,
 	const char *name;
 	bool is_string = is_string_attr(type, attr);
 
-	/* The attribute is invisible if there is no template string */
-	if (!template)
-		return ERR_PTR(-ENOENT);
-
 	mode = ops->is_visible(drvdata, type, attr, index);
 	if (!mode)
 		return ERR_PTR(-ENOENT);
@@ -712,8 +817,8 @@ static int hwmon_genattrs(const void *drvdata,
 
 			attr = __ffs(attr_mask);
 			attr_mask &= ~BIT(attr);
-			if (attr >= template_size)
-				return -EINVAL;
+			if (attr >= template_size || !templates[attr])
+				continue;	/* attribute is invisible */
 			a = hwmon_genattr(drvdata, info->type, attr, i,
 					  templates[attr], ops);
 			if (IS_ERR(a)) {
@@ -849,16 +954,26 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
 	INIT_LIST_HEAD(&hwdev->tzdata);
 
 	if (hdev->of_node && chip && chip->ops->read &&
-	    chip->info[0]->type == hwmon_chip &&
-	    (chip->info[0]->config[0] & HWMON_C_REGISTER_TZ)) {
-		err = hwmon_thermal_register_sensors(hdev);
-		if (err) {
-			device_unregister(hdev);
-			/*
-			 * Don't worry about hwdev; hwmon_dev_release(), called
-			 * from device_unregister(), will free it.
-			 */
-			goto ida_remove;
+	    chip->info[0]->type == hwmon_chip) {
+		u32 config = chip->info[0]->config[0];
+
+		if (config & HWMON_C_REGISTER_TZ) {
+			err = hwmon_thermal_register_sensors(hdev);
+			if (err) {
+				device_unregister(hdev);
+				/*
+				 * Don't worry about hwdev; hwmon_dev_release(),
+				 * called from device_unregister(), will free it.
+				 */
+				goto ida_remove;
+			}
+		}
+		if (config & HWMON_C_PEC) {
+			err = hwmon_pec_register(hdev);
+			if (err) {
+				device_unregister(hdev);
+				goto ida_remove;
+			}
 		}
 	}
 
diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index edf96f249eb5..e94314760aab 100644
--- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -45,6 +45,7 @@ enum hwmon_chip_attributes {
 	hwmon_chip_power_samples,
 	hwmon_chip_temp_samples,
 	hwmon_chip_beep_enable,
+	hwmon_chip_pec,
 };
 
 #define HWMON_C_TEMP_RESET_HISTORY	BIT(hwmon_chip_temp_reset_history)
@@ -60,6 +61,7 @@ enum hwmon_chip_attributes {
 #define HWMON_C_POWER_SAMPLES		BIT(hwmon_chip_power_samples)
 #define HWMON_C_TEMP_SAMPLES		BIT(hwmon_chip_temp_samples)
 #define HWMON_C_BEEP_ENABLE		BIT(hwmon_chip_beep_enable)
+#define HWMON_C_PEC			BIT(hwmon_chip_pec)
 
 enum hwmon_temp_attributes {
 	hwmon_temp_enable,
-- 
2.39.2


