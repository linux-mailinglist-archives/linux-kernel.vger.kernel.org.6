Return-Path: <linux-kernel+bounces-573652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D95FCA6DA3C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 651787A6CA9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A691199FA8;
	Mon, 24 Mar 2025 12:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="YijUECz6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="mwNeQ+iB"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C49C4400;
	Mon, 24 Mar 2025 12:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742820369; cv=none; b=Rkd0Na+kMdO7LeLLKLc7jhqiPOPkvcgfa9dQLa5vWYiUGLNyB+mVkD7CEJAaTimgaL8Nj8LwJGQvndoR7PX+MY4Lfy7wNhf8CeayzA84w1/f087acXf/poUPfzQxTF6fEhmgR4T5wCwYh78emqsGzX7kGL8Jz3hgYOywO5fWfOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742820369; c=relaxed/simple;
	bh=oxTW1PrI7zxnvTAfviKT5O2OKh8U6bxkdbvldlFaQFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uU4EYL4ZdQNflGTZZo3Wh6xst3mfiglmYeiIlH2ZmwVr3LvMKhMI1NIlC5OXRFUfKnuRQmxpwc2yDI6fGyNlhPoDCMKS54ig1rlaveNH1EUuDRybOwNQeA8GOQ4hlnNMAY37XfZSJ34dnE9balmENo6vTMw3wZlVcSfepChSc/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=YijUECz6; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=mwNeQ+iB reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1742820365; x=1774356365;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DX4/VO3OnQRr65r3k5zsXrc0QjpoAW2FHYBe64Wv3so=;
  b=YijUECz6vu7a/SAuwv/PWFFSr6qzWMg1+ijRE02a5zi40ceQ9z9F1Cmi
   SlqlGDNrZbJzLU8H3U6NBYNjxvCc4JJ+o5Xb8Y/JayLrdQMex2Vxi5VEf
   LF39GVc9SbEjRJrG/H84NxhaGtEkQOsFxptnsDKv8/+Xp3wfzcw/PhcHn
   T1FGuILbQQzo8grwuTdvk/+mHd3/QVqBnxUiwjsyMwAv4Stq3tr2FugzI
   7rO2ZX2F7JnjzBPF9vYUJ1geI1Lb6593PZdgiujGUW57vAWGzMBFJqS/t
   7CyDm3OpJdzW1nLfYkhyTvCf3Fxv1YMnSRwSVuEnOMmE7CCPxupUjtYd2
   A==;
X-CSE-ConnectionGUID: YJDNgeQkQxq1mymXzWzL4g==
X-CSE-MsgGUID: FQhoTfolT++Nv+KvZ+nvag==
X-IronPort-AV: E=Sophos;i="6.14,272,1736809200"; 
   d="scan'208";a="43121863"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 24 Mar 2025 13:46:01 +0100
X-CheckPoint: {67E15409-B-F35B2447-E1635CDE}
X-MAIL-CPID: BA32B4495DC1B31DA7A57D267F96BBF6_1
X-Control-Analysis: str=0001.0A006398.67E15403.0066,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 55114167297;
	Mon, 24 Mar 2025 13:45:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1742820357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DX4/VO3OnQRr65r3k5zsXrc0QjpoAW2FHYBe64Wv3so=;
	b=mwNeQ+iBSVgfKds9QENrlVpJcFiuapYgpm7B1+bObeVbZK8K5HXlb8QBpYkNi7PtGbb2AR
	MJpiqTgvsie91/s+cPwfc7ygbDJEy7Qt3an1dS8HXYgKQIDhZP0ItX+SyBSwV2+ml1ClLw
	WzY6dtcONxuRgkzCUsQ99X3tPDVUcOhL6g92eQ9WQwuXYgaBmaeyMKEnbyZNA1VOlFTjd6
	gcaURLZ9sBIfvqIV03DXnRbq4sZ2szY82ze2go+FGAVm6/+Gw42VVcW8YcOQ8O1ANWUM9b
	EJFjG/ks+0uQpz/0P8Fp5kJlxSsz0wJxgYYmmyg+QKw6D9br0DWEkZj13QpTwA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] hwmon: (gpio-fan) Add regulator support
Date: Mon, 24 Mar 2025 13:45:49 +0100
Message-ID: <20250324124550.989292-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

FANs might be supplied by a regulator which needs to be enabled as well.
This is implemented using runtime PM. Every time speed_index changes from
0 to non-zero and vise versa RPM is resumed or suspended.
Intitial RPM state is determined by initial value of speed_index.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Patch 1 & 2 from v1 [1] have already been applied, although number 2 [2] is not
yet showing in next-20250305. Patches 3 & 4 (just removing comments) from v1
have been dropped, so only this patch remains.

Changes in v3:
* Remove noisy dev_err calls related to runtime pm
* Properly propagate return codes from set_fan_speed

Changes in v2:
* Make regulator non-optional

[1] https://lore.kernel.org/all/20250210145934.761280-1-alexander.stein@ew.tq-group.com/
[2] https://web.git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git/commit/?h=hwmon-next&id=9fee7d19bab635f89223cc40dfd2c8797fdc4988
---
 drivers/hwmon/gpio-fan.c | 104 +++++++++++++++++++++++++++++++++------
 1 file changed, 90 insertions(+), 14 deletions(-)

diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
index cee3fa146d69a..4c736b7eb5473 100644
--- a/drivers/hwmon/gpio-fan.c
+++ b/drivers/hwmon/gpio-fan.c
@@ -20,6 +20,9 @@
 #include <linux/gpio/consumer.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
 #include <linux/thermal.h>
 
 struct gpio_fan_speed {
@@ -42,6 +45,7 @@ struct gpio_fan_data {
 	bool			pwm_enable;
 	struct gpio_desc	*alarm_gpio;
 	struct work_struct	alarm_work;
+	struct regulator	*supply;
 };
 
 /*
@@ -125,13 +129,32 @@ static int __get_fan_ctrl(struct gpio_fan_data *fan_data)
 }
 
 /* Must be called with fan_data->lock held, except during initialization. */
-static void set_fan_speed(struct gpio_fan_data *fan_data, int speed_index)
+static int set_fan_speed(struct gpio_fan_data *fan_data, int speed_index)
 {
 	if (fan_data->speed_index == speed_index)
-		return;
+		return 0;
+
+	if (fan_data->speed_index == 0 && speed_index > 0) {
+		int ret;
+
+		ret = pm_runtime_resume_and_get(fan_data->dev);
+		if (ret < 0)
+			return ret;
+	}
 
 	__set_fan_ctrl(fan_data, fan_data->speed[speed_index].ctrl_val);
+
+	if (fan_data->speed_index > 0 && speed_index == 0) {
+		int ret;
+
+		ret = pm_runtime_put_sync(fan_data->dev);
+		if (ret < 0)
+			return ret;
+	}
+
 	fan_data->speed_index = speed_index;
+
+	return 0;
 }
 
 static int get_fan_speed_index(struct gpio_fan_data *fan_data)
@@ -189,7 +212,9 @@ static ssize_t pwm1_store(struct device *dev, struct device_attribute *attr,
 	}
 
 	speed_index = DIV_ROUND_UP(pwm * (fan_data->num_speed - 1), 255);
-	set_fan_speed(fan_data, speed_index);
+	ret = set_fan_speed(fan_data, speed_index);
+	if (!ret)
+		ret = count;
 
 exit_unlock:
 	mutex_unlock(&fan_data->lock);
@@ -211,6 +236,7 @@ static ssize_t pwm1_enable_store(struct device *dev,
 {
 	struct gpio_fan_data *fan_data = dev_get_drvdata(dev);
 	unsigned long val;
+	int ret;
 
 	if (kstrtoul(buf, 10, &val) || val > 1)
 		return -EINVAL;
@@ -224,11 +250,14 @@ static ssize_t pwm1_enable_store(struct device *dev,
 
 	/* Disable manual control mode: set fan at full speed. */
 	if (val == 0)
-		set_fan_speed(fan_data, fan_data->num_speed - 1);
+		ret = set_fan_speed(fan_data, fan_data->num_speed - 1);
 
 	mutex_unlock(&fan_data->lock);
 
-	return count;
+	if (ret)
+		return ret;
+	else
+		return count;
 }
 
 static ssize_t pwm1_mode_show(struct device *dev,
@@ -279,7 +308,7 @@ static ssize_t set_rpm(struct device *dev, struct device_attribute *attr,
 		goto exit_unlock;
 	}
 
-	set_fan_speed(fan_data, rpm_to_speed_index(fan_data, rpm));
+	ret = set_fan_speed(fan_data, rpm_to_speed_index(fan_data, rpm));
 
 exit_unlock:
 	mutex_unlock(&fan_data->lock);
@@ -386,6 +415,7 @@ static int gpio_fan_set_cur_state(struct thermal_cooling_device *cdev,
 				  unsigned long state)
 {
 	struct gpio_fan_data *fan_data = cdev->devdata;
+	int ret;
 
 	if (!fan_data)
 		return -EINVAL;
@@ -395,11 +425,11 @@ static int gpio_fan_set_cur_state(struct thermal_cooling_device *cdev,
 
 	mutex_lock(&fan_data->lock);
 
-	set_fan_speed(fan_data, state);
+	ret = set_fan_speed(fan_data, state);
 
 	mutex_unlock(&fan_data->lock);
 
-	return 0;
+	return ret;
 }
 
 static const struct thermal_cooling_device_ops gpio_fan_cool_ops = {
@@ -499,6 +529,8 @@ static void gpio_fan_stop(void *data)
 	mutex_lock(&fan_data->lock);
 	set_fan_speed(data, 0);
 	mutex_unlock(&fan_data->lock);
+
+	pm_runtime_disable(fan_data->dev);
 }
 
 static int gpio_fan_probe(struct platform_device *pdev)
@@ -521,6 +553,11 @@ static int gpio_fan_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, fan_data);
 	mutex_init(&fan_data->lock);
 
+	fan_data->supply = devm_regulator_get(dev, "fan");
+	if (IS_ERR(fan_data->supply))
+		return dev_err_probe(dev, PTR_ERR(fan_data->supply),
+				     "Failed to get fan-supply");
+
 	/* Configure control GPIOs if available. */
 	if (fan_data->gpios && fan_data->num_gpios > 0) {
 		if (!fan_data->speed || fan_data->num_speed <= 1)
@@ -548,6 +585,17 @@ static int gpio_fan_probe(struct platform_device *pdev)
 			return err;
 	}
 
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+	/* If current GPIO state is active, mark RPM as active as well */
+	if (fan_data->speed_index > 0) {
+		int ret;
+
+		ret = pm_runtime_resume_and_get(&pdev->dev);
+		if (ret)
+			return ret;
+	}
+
 	/* Optional cooling device register for Device tree platforms */
 	fan_data->cdev = devm_thermal_of_cooling_device_register(dev, np,
 				"gpio-fan", fan_data, &gpio_fan_cool_ops);
@@ -568,41 +616,69 @@ static void gpio_fan_shutdown(struct platform_device *pdev)
 	}
 }
 
+static int gpio_fan_runtime_suspend(struct device *dev)
+{
+	struct gpio_fan_data *fan_data = dev_get_drvdata(dev);
+	int ret = 0;
+
+	if (fan_data->supply)
+		ret = regulator_disable(fan_data->supply);
+
+	return ret;
+}
+
+static int gpio_fan_runtime_resume(struct device *dev)
+{
+	struct gpio_fan_data *fan_data = dev_get_drvdata(dev);
+	int ret = 0;
+
+	if (fan_data->supply)
+		ret = regulator_enable(fan_data->supply);
+
+	return ret;
+}
+
 static int gpio_fan_suspend(struct device *dev)
 {
 	struct gpio_fan_data *fan_data = dev_get_drvdata(dev);
+	int ret = 0;
 
 	if (fan_data->gpios) {
 		fan_data->resume_speed = fan_data->speed_index;
 		mutex_lock(&fan_data->lock);
-		set_fan_speed(fan_data, 0);
+		ret = set_fan_speed(fan_data, 0);
 		mutex_unlock(&fan_data->lock);
 	}
 
-	return 0;
+	return ret;
 }
 
 static int gpio_fan_resume(struct device *dev)
 {
 	struct gpio_fan_data *fan_data = dev_get_drvdata(dev);
+	int ret = 0;
 
 	if (fan_data->gpios) {
 		mutex_lock(&fan_data->lock);
-		set_fan_speed(fan_data, fan_data->resume_speed);
+		ret = set_fan_speed(fan_data, fan_data->resume_speed);
 		mutex_unlock(&fan_data->lock);
 	}
 
-	return 0;
+	return ret;
 }
 
-static DEFINE_SIMPLE_DEV_PM_OPS(gpio_fan_pm, gpio_fan_suspend, gpio_fan_resume);
+static const struct dev_pm_ops gpio_fan_pm = {
+	RUNTIME_PM_OPS(gpio_fan_runtime_suspend,
+		       gpio_fan_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(gpio_fan_suspend, gpio_fan_resume)
+};
 
 static struct platform_driver gpio_fan_driver = {
 	.probe		= gpio_fan_probe,
 	.shutdown	= gpio_fan_shutdown,
 	.driver	= {
 		.name	= "gpio-fan",
-		.pm	= pm_sleep_ptr(&gpio_fan_pm),
+		.pm	= pm_ptr(&gpio_fan_pm),
 		.of_match_table = of_gpio_fan_match,
 	},
 };
-- 
2.43.0


