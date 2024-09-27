Return-Path: <linux-kernel+bounces-342100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC88988A85
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 20:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7037028895E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 18:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA541C0DFB;
	Fri, 27 Sep 2024 18:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EV7lXeD4"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152B31C4603;
	Fri, 27 Sep 2024 18:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727463253; cv=none; b=buglTGFyo6x9Er3/nyI89yh4jH7Iz4TpN/9bsZ26DdNTc8Zj3AnN15zdP8JQ5fEP5EbDiNpyDDO16ncku72UXT/xZxUPNLJyB1lJ02bcCoJFo8ZRTGPr/nHsr1fjWXjoHzLCHAU1O2f/NB7SEbpJ5ZhZhiqtWKy40OzGEudUEJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727463253; c=relaxed/simple;
	bh=UzSIx6tMK7fakxjqhJ2gGRymSF/LaFtJNectiLR9etA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r3vSNAVk5un4b1Tyx8J0/87xMXbeBY375Rsxg2SDZ1wcbbpM4cxftFAuKLV0v2biD8jVLSEZGNGAjSpRb4NP53pvGIgKVYEUzQoifiQXOgi0srvwP27iiU3ve0PtoWUDHQseTtQiZEYRNedStu5KswnGgAXyrveoB7tN9QxuNnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EV7lXeD4; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53567b4c3f4so2667660e87.2;
        Fri, 27 Sep 2024 11:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727463248; x=1728068048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8F2mEDORvcCus0TdIczx3PN7SpYmRkcMp3Rmoy+UPg=;
        b=EV7lXeD4cgPA5zDiiCJbSzXXOAeQhya4EOfVED5+S/xohfwo0MhKhJbEo32xV6wzE5
         x2ypTd0Pvb6Mp+sqZzXuwokCNu/U0BRbYSAiO5VA20rQVi7hFDZnTlIfVzWmH3bpIqjK
         H2q3mgGXN6dXtmJOaiWyek+mKXsgNB1YvqVrXx8pywqA+B/2sTiaeWdlWv2wsqhQasGE
         BFWZWXamuyN1ZZY6SczbmJTOUUsn202pNF58Ngwo2EbGxuPfdXbDmLPy9ul3U5riPnnP
         AHOjrZ4SUwTq9YM/BuQOi+dxj8w7/Rt0uPUAS8SS73doCKF12JBeGpwtFrLMkI3175I4
         8Ufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727463248; x=1728068048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8F2mEDORvcCus0TdIczx3PN7SpYmRkcMp3Rmoy+UPg=;
        b=hpQW3TcE5ryI6c72qrKSyi4rOx4p09r/2g4QwSmzG9xekhp+yy299lUBpudG7U7iKG
         ol76Sko6Ax57nY86JBniBANamR1f1KqWBcpyKnXhShN5j1YYV+IwhNLutTDKCq7iM6/M
         dTrjnbnthXy/nThYjGxYJOR7qSWizwzkR1iQ5PK8xsebdBI+9F3cnaakybnil3tx4Gdj
         LoHpGep/N7Zy4o+rJ3XB/OofKeXUaGb09nwxJa3wsq4vorUnb5DYCKp4o0SaYedASofZ
         PxagHeR/PYDHi+0r7D4mrbLQ64EPWxZEVb/StZ25UKqCE4M8H58s5xPS9fEj5tBfXgD7
         Ozfw==
X-Forwarded-Encrypted: i=1; AJvYcCXRLZ1/q6mQylpXwxFejuQbEfwExMX4+mOSFr/kA1QunwjOcRFPlhxI5EmAGI4rB7BT2DmO8yIPXndJv94jc03bI/fz@vger.kernel.org
X-Gm-Message-State: AOJu0YwQwuvurdLbuSO/EXvucbEY6aEH1Bz1jOtCzVyPHkcC6FBlYC1z
	tibFfENxsvPH/c5b/1jmeEPLqjQNXtBPcVfeSeZc0sJqtG07Lrhh
X-Google-Smtp-Source: AGHT+IGGV/JkSQ+VFoCz0kjC9J7j+khFpgkUmCpvX0zN6mxzZDu8kLYmmk+DI51FcDZSJGWSUY/kLg==
X-Received: by 2002:a05:6512:3b0e:b0:52c:86d7:fa62 with SMTP id 2adb3069b0e04-5389fc43de2mr3363470e87.23.1727463247796;
        Fri, 27 Sep 2024 11:54:07 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a311:80b0:1c80:9433:9060:39fc:2954])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c882405d39sm1434704a12.18.2024.09.27.11.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 11:54:06 -0700 (PDT)
From: Maya Matuszczyk <maccraft123mc@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
	Maya Matuszczyk <maccraft123mc@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH 2/3] platform: arm64: Add driver for Lenovo Yoga Slim 7x's EC
Date: Fri, 27 Sep 2024 20:53:41 +0200
Message-ID: <20240927185345.3680-2-maccraft123mc@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240927185345.3680-1-maccraft123mc@gmail.com>
References: <20240927185345.3680-1-maccraft123mc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a basic driver for the EC in Qualcomm Snapdragon X1
Elite-based Lenovo Yoga Slim 7x.

For now it supports only reporting that the AP is going to suspend and
the microphone mute button, however the EC seems to also support reading
fan information, other key combinations and thermal data.

Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
---
 MAINTAINERS                                 |   1 +
 drivers/platform/arm64/Kconfig              |  12 ++
 drivers/platform/arm64/Makefile             |   1 +
 drivers/platform/arm64/lenovo-yoga-slim7x.c | 202 ++++++++++++++++++++
 4 files changed, 216 insertions(+)
 create mode 100644 drivers/platform/arm64/lenovo-yoga-slim7x.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0d4bfdde166d..f689cba80fa3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12906,6 +12906,7 @@ LENOVO YOGA SLIM 7X EC DRIVER
 M:	Maya Matuszczyk <maccraft123mc@gmail.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/platform/lenovo,yoga-slim7x-ec.yaml
+F:	drivers/platform/arm64/lenovo-yoga-slim7x.c
 
 LETSKETCH HID TABLET DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
diff --git a/drivers/platform/arm64/Kconfig b/drivers/platform/arm64/Kconfig
index f88395ea3376..9ceae50f8b4e 100644
--- a/drivers/platform/arm64/Kconfig
+++ b/drivers/platform/arm64/Kconfig
@@ -49,4 +49,16 @@ config EC_LENOVO_YOGA_C630
 
 	  Say M or Y here to include this support.
 
+config EC_LENOVO_YOGA_SLIM7X
+	tristate "Lenovo Yoga Slim 7x Embedded Controller driver"
+	depends on ARCH_QCOM || COMPILE_TEST
+	depends on I2C
+	help
+	  Select this option to enable driver for the EC found in the Lenovo
+	  Yoga Slim 7x.
+
+	  This driver currently supports reporting input event for microphone
+	  mute button, and reporting device suspend to the EC so it can take
+	  appropriate actions.
+
 endif # ARM64_PLATFORM_DEVICES
diff --git a/drivers/platform/arm64/Makefile b/drivers/platform/arm64/Makefile
index b2ae9114fdd8..70dfc1fb979d 100644
--- a/drivers/platform/arm64/Makefile
+++ b/drivers/platform/arm64/Makefile
@@ -7,3 +7,4 @@
 
 obj-$(CONFIG_EC_ACER_ASPIRE1)	+= acer-aspire1-ec.o
 obj-$(CONFIG_EC_LENOVO_YOGA_C630) += lenovo-yoga-c630.o
+obj-$(CONFIG_EC_LENOVO_YOGA_SLIM7X) += lenovo-yoga-slim7x.o
diff --git a/drivers/platform/arm64/lenovo-yoga-slim7x.c b/drivers/platform/arm64/lenovo-yoga-slim7x.c
new file mode 100644
index 000000000000..8f6d523395bc
--- /dev/null
+++ b/drivers/platform/arm64/lenovo-yoga-slim7x.c
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024 Maya Matuszczyk <maya.matuszczyk@gmail.com>
+ */
+#include <linux/auxiliary_bus.h>
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/irqreturn.h>
+#include <linux/lockdep.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/notifier.h>
+#include <linux/slab.h>
+#include <linux/input.h>
+//#include <linux/platform_data/lenovo-yoga-slim7x.h>
+
+// These are the registers that i know about available from SMBUS
+#define EC_IRQ_REASON_REG 0x05
+#define EC_SUSPEND_RESUME_REG 0x23
+#define EC_IRQ_ENABLE_REG 0x35
+#define EC_BACKLIGHT_STATUS_REG 0x83
+#define EC_MIC_MUTE_LED_REG 0x84
+#define EC_AC_STATUS_REG 0x90
+
+// Valid values for EC_SUSPEND_RESUME_REG
+#define EC_NOTIFY_SUSPEND_ENTER 0x01
+#define EC_NOTIFY_SUSPEND_EXIT 0x00
+#define EC_NOTIFY_SCREEN_OFF 0x03
+#define EC_NOTIFY_SCREEN_ON 0x04
+
+// These are the values in EC_IRQ_REASON_REG that i could find in DSDT
+#define EC_IRQ_MICMUTE_BUTTON 0x04
+#define EC_IRQ_FAN1_STATUS_CHANGE 0x30
+#define EC_IRQ_FAN2_STATUS_CHANGE 0x31
+#define EC_IRQ_FAN1_SPEED_CHANGE 0x32
+#define EC_IRQ_FAN2_SPEED_CHANGE 0x33
+#define EC_IRQ_COMPLETED_LUT_UPDATE 0x34
+#define EC_IRQ_COMPLETED_FAN_PROFILE_SWITCH 0x35
+#define EC_IRQ_THERMISTOR_1_TEMP_THRESHOLD_CROSS 0x36
+#define EC_IRQ_THERMISTOR_2_TEMP_THRESHOLD_CROSS 0x37
+#define EC_IRQ_THERMISTOR_3_TEMP_THRESHOLD_CROSS 0x38
+#define EC_IRQ_THERMISTOR_4_TEMP_THRESHOLD_CROSS 0x39
+#define EC_IRQ_THERMISTOR_5_TEMP_THRESHOLD_CROSS 0x3a
+#define EC_IRQ_THERMISTOR_6_TEMP_THRESHOLD_CROSS 0x3b
+#define EC_IRQ_THERMISTOR_7_TEMP_THRESHOLD_CROSS 0x3c
+#define EC_IRQ_RECOVERED_FROM_RESET 0x3d
+#define EC_IRQ_LENOVO_SUPPORT_KEY 0x90
+#define EC_IRQ_FN_Q 0x91
+#define EC_IRQ_FN_M 0x92
+#define EC_IRQ_FN_SPACE 0x93
+#define EC_IRQ_FN_R 0x94
+#define EC_IRQ_FNLOCK_ON 0x95
+#define EC_IRQ_FNLOCK_OFF 0x96
+#define EC_IRQ_FN_N 0x97
+#define EC_IRQ_AI 0x9a
+#define EC_IRQ_NPU 0x9b
+
+struct yoga_slim7x_ec {
+	struct i2c_client *client;
+	struct input_dev *idev;
+	struct mutex lock;
+};
+
+static irqreturn_t yoga_slim7x_ec_irq(int irq, void *data)
+{
+	struct yoga_slim7x_ec *ec = data;
+	struct device *dev = &ec->client->dev;
+	int val;
+
+	guard(mutex)(&ec->lock);
+
+	val = i2c_smbus_read_byte_data(ec->client, EC_IRQ_REASON_REG);
+	if (val < 0) {
+		dev_err(dev, "Failed to get EC IRQ reason: %d\n", val);
+		return IRQ_HANDLED;
+	}
+
+	switch (val) {
+	case EC_IRQ_MICMUTE_BUTTON:
+		input_report_key(ec->idev, KEY_MICMUTE, 1);
+		input_sync(ec->idev);
+		input_report_key(ec->idev, KEY_MICMUTE, 0);
+		input_sync(ec->idev);
+		break;
+	default:
+		dev_info(dev, "Unhandled EC IRQ reason: %d\n", val);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int yoga_slim7x_ec_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct yoga_slim7x_ec *ec;
+	int ret;
+
+	ec = devm_kzalloc(dev, sizeof(*ec), GFP_KERNEL);
+	if (!ec)
+		return -ENOMEM;
+
+	mutex_init(&ec->lock);
+	ec->client = client;
+
+	ec->idev = devm_input_allocate_device(dev);
+	if (!ec->idev)
+		return -ENOMEM;
+	ec->idev->name = "yoga-slim7x-ec";
+	ec->idev->phys = "yoga-slim7x-ec/input0";
+	input_set_capability(ec->idev, EV_KEY, KEY_MICMUTE);
+
+	ret = input_register_device(ec->idev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to register input device\n");
+
+	ret = devm_request_threaded_irq(dev, client->irq,
+					NULL, yoga_slim7x_ec_irq,
+					IRQF_ONESHOT, "yoga_slim7x_ec", ec);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Unable to request irq\n");
+
+	ret = i2c_smbus_write_byte_data(client, EC_IRQ_ENABLE_REG, 0x01);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to enable interrupts\n");
+
+	return 0;
+}
+
+static void yoga_slim7x_ec_remove(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(client, EC_IRQ_ENABLE_REG, 0x00);
+	if (ret < 0)
+		dev_err(dev, "Failed to disable interrupts: %d\n", ret);
+}
+
+static int yoga_slim7x_ec_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(client, EC_SUSPEND_RESUME_REG, EC_NOTIFY_SCREEN_OFF);
+	if (ret)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(client, EC_SUSPEND_RESUME_REG, EC_NOTIFY_SUSPEND_ENTER);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int yoga_slim7x_ec_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(client, EC_SUSPEND_RESUME_REG, EC_NOTIFY_SUSPEND_EXIT);
+	if (ret)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(client, EC_SUSPEND_RESUME_REG, EC_NOTIFY_SCREEN_ON);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct of_device_id yoga_slim7x_ec_of_match[] = {
+	{ .compatible = "lenovo,yoga-slim7x-ec" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, yoga_slim7x_ec_of_match);
+
+static const struct i2c_device_id yoga_slim7x_ec_i2c_id_table[] = {
+	{ "yoga-slim7x-ec", },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, yoga_slim7x_ec_i2c_id_table);
+
+static DEFINE_SIMPLE_DEV_PM_OPS(yoga_slim7x_ec_pm_ops,
+		yoga_slim7x_ec_suspend,
+		yoga_slim7x_ec_resume);
+
+static struct i2c_driver yoga_slim7x_ec_i2c_driver = {
+	.driver = {
+		.name = "yoga-slim7x-ec",
+		.of_match_table = yoga_slim7x_ec_of_match,
+		.pm = &yoga_slim7x_ec_pm_ops
+	},
+	.probe = yoga_slim7x_ec_probe,
+	.remove = yoga_slim7x_ec_remove,
+	.id_table = yoga_slim7x_ec_i2c_id_table,
+};
+module_i2c_driver(yoga_slim7x_ec_i2c_driver);
+
+MODULE_DESCRIPTION("Lenovo Yoga Slim 7x Embedded Controller");
+MODULE_LICENSE("GPL");
-- 
2.45.2


