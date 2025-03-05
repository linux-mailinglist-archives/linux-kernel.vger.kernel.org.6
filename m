Return-Path: <linux-kernel+bounces-546616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5544AA4FCD4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D71FC16590C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3D82192F1;
	Wed,  5 Mar 2025 10:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="kMN/xG5Y";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="cdyf4X0l"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763F520D508;
	Wed,  5 Mar 2025 10:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741172016; cv=none; b=oaacM4adX45kYWSxk+E3v1SEarGQOtiLa7tcV0KZjKJwLyE6kXllHzBKbTH3mjeV0OrpX/dRHDl/5k6+8rJqAiKBStq6neriMTSe1iCKtwfDH5ajcwkTEPJYIn8hbdWLwZytCY1phcieEPy3NNe3k9n5XTklMQVOs+hrscuQewU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741172016; c=relaxed/simple;
	bh=7f3eiq8c9Zl8+3eUyWKxTZdcU+vENu8FJOnc9VQEkt0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NYfm/Cr/Rm4yO4LvpWxOgc/Yzmy8D5rZ+AqEDrVYZotR2n+UfRRiMytxRMK23qWBF23EOyL5qnpGAUNF0TFMKJNKVczOMTrzzjOVa00tRX/ve6/TeDM9zG2JVksnBoGv5Lk2sey+MOW/4UmNYp6B/YU/1xVPQzmwp2gYLm+eEW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=kMN/xG5Y; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=cdyf4X0l reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1741172011; x=1772708011;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aafUxfw6iPij9nHv+DrHDc/H4nnT786J23hQpi850og=;
  b=kMN/xG5Y5EMEuhUQ0ShMvYb9IUhgRvpl4hyCC6CAYyIv6CK2iDKUU7LH
   0+7dXogNBNYCMKzgf8w+ql9svyxk0KVjA0QCG2zjLxgT4CdmTn7bbqPHn
   3j0Zm/4+gysQ+2mQmlE9PUP47oz+nyJk+WaTth+vsrwQXRmX4NY6GgsmZ
   FEcGaCPnja1SeVs9yvPE5vW9bGamggRWmSQEPxXYb82M9KggjKl1kNP6x
   b/9gSebY5W6bNvCZbslzbcVzLadGPa7gb98C4RBpNxQNTzpnX7kFhh6df
   yhfJDH8qgstLnX0SHSWMRkkn4Y1R4TuWlN2lQOOvJsdNgCON4y4tuPOIe
   A==;
X-CSE-ConnectionGUID: BPavKzvqTmyG3dI92QJn6w==
X-CSE-MsgGUID: MbqESkNdRZyKfkJOOS86Pw==
X-IronPort-AV: E=Sophos;i="6.14,222,1736809200"; 
   d="scan'208";a="42307507"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 05 Mar 2025 11:53:22 +0100
X-CheckPoint: {67C82D22-23-F35B2447-E1635CDE}
X-MAIL-CPID: 1759D23DFCF55862F4B229D9F25E3B0D_1
X-Control-Analysis: str=0001.0A006366.67C82D25.00D9,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 79448163A96;
	Wed,  5 Mar 2025 11:53:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1741171998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aafUxfw6iPij9nHv+DrHDc/H4nnT786J23hQpi850og=;
	b=cdyf4X0lWf7VMvYeBXGst4fA6rG903DHRsaJJgIG+SRo229zYkj9WxMAlfF/bwjXkb5Gg2
	Kwu0yePXx/eoRMVk5cJx3DvwseOQrkZKSnWjDsJEeSOS5Q1WoXM0Wrz7VnPmQsJnXS9XHb
	bZ/wAuX/sBnuqLRfM7nrdo16OEAkHBnpgrWcG4pNrzqGedNSDUeVV84KPmdsiWKTBbU1fB
	FsL/kbI+VRasXs5jOV8FcMbyiowNpP4mD09wMJCsbSgaeo/SIRrGmPWSDLy8ESuaya6bMD
	1bzOvgPRl46zuwfvX12BFwe1yLj5i1e6XLyQFYw2A6QdQu47w7r5H5/zqndx/Q==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] hwmon: (gpio-fan) Add regulator support
Date: Wed,  5 Mar 2025 11:53:13 +0100
Message-ID: <20250305105314.2009637-1-alexander.stein@ew.tq-group.com>
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

Changes in v2:
* Make regulator non-optional

[1] https://lore.kernel.org/all/20250210145934.761280-1-alexander.stein@ew.tq-group.com/
[2] https://web.git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git/commit/?h=hwmon-next&id=9fee7d19bab635f89223cc40dfd2c8797fdc4988
---
 drivers/hwmon/gpio-fan.c | 81 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 77 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
index cee3fa146d69a..db918d6858325 100644
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
@@ -125,13 +129,38 @@ static int __get_fan_ctrl(struct gpio_fan_data *fan_data)
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
+		if (ret < 0) {
+			dev_err(fan_data->dev,
+				"Failed to runtime_get device: %d\n", ret);
+			return ret;
+		}
+	}
 
 	__set_fan_ctrl(fan_data, fan_data->speed[speed_index].ctrl_val);
+
+	if (fan_data->speed_index > 0 && speed_index == 0) {
+		int ret;
+
+		ret = pm_runtime_put_sync(fan_data->dev);
+		if (ret < 0) {
+			dev_err(fan_data->dev,
+				"Failed to runtime_put device: %d\n", ret);
+			return ret;
+		}
+	}
+
 	fan_data->speed_index = speed_index;
+
+	return 0;
 }
 
 static int get_fan_speed_index(struct gpio_fan_data *fan_data)
@@ -499,6 +528,8 @@ static void gpio_fan_stop(void *data)
 	mutex_lock(&fan_data->lock);
 	set_fan_speed(data, 0);
 	mutex_unlock(&fan_data->lock);
+
+	pm_runtime_disable(fan_data->dev);
 }
 
 static int gpio_fan_probe(struct platform_device *pdev)
@@ -521,6 +552,11 @@ static int gpio_fan_probe(struct platform_device *pdev)
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
@@ -548,6 +584,17 @@ static int gpio_fan_probe(struct platform_device *pdev)
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
@@ -568,6 +615,28 @@ static void gpio_fan_shutdown(struct platform_device *pdev)
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
@@ -595,14 +664,18 @@ static int gpio_fan_resume(struct device *dev)
 	return 0;
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


