Return-Path: <linux-kernel+bounces-251714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FDD93089F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 08:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5239CB212C7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 06:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1140134C6;
	Sun, 14 Jul 2024 06:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3jDv97P"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C878A139E
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 06:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720936842; cv=none; b=P0g1M9rjYeVLK8NCwRa+DRQAS4u0kS1qkuPE1hn+P6kIVHXo6v9zwZk5KXEG8A4StaGrrVXt/jHo35PVxPtZLYTRQkS10TMYz6fUKPhh3t5+kWfSTV44z3lbtXDyntEDsDbhnKqpLhB6xqdxSzusyqinmk2GNgCiWWF+ebncQ+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720936842; c=relaxed/simple;
	bh=12X/viCiW1NO3U9k9TxyaA9yGUc2BuyaOOOxjhtSKB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NJINm5P6FUHDZtq+z2LKWq4V8dclhuWNFiyv+2Kq8+74CoN+Nz3/CxJAyDQKSdIhi9yWm3Fqx0NSHT8CaO4aG5G8+lfzrwuvbpzdHC/JveMGcfolP7ICdVmTn8tRVnpMhrfOUrUCI9zGojhAwerWSKbjOKs1WSXWjXQFd/oz3/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3jDv97P; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-64b417e1511so31646107b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 23:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720936839; x=1721541639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bDKAETPyANcHzEAs4TM1y/Y6cW656ty38nv8Y2TNxLc=;
        b=Z3jDv97PLmjaQ0jsdSsFwloDsDL0cJD4ml9CI2kaZ8CeqRxAlxjbijoiSxHGnlGv9Q
         SS9JQH7se0mk/6q9GDz+fKU8yZFS0lcE9+DzznIwBE2061BxqbfTh1c5qpq4DSzqdNea
         TGfX0SoHRB6hP0Doe6yKco60MILqW/uhpXlw0AmOpLgSjcdYXEcGNnh2fzZCfLx0YR6K
         nDAVlnkSlQVo6BU3nOwpuqDgDWFKHAGtWZOEiXYL4K+DD2+o/bR4kq6iTyOi5rFxjsox
         l8zdnHSRQF7A5InL6XRRCizXgBl6+evkNYL0w2NR9S/YH22mlwWuyiiklstwDtS/BxCM
         9mLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720936839; x=1721541639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bDKAETPyANcHzEAs4TM1y/Y6cW656ty38nv8Y2TNxLc=;
        b=nWhUv327YO+Is7QcNq8JR/UkpAwX6/4skjcXRouwKDw3wtTCbCGbachxiXMC6EPcI/
         Y6fSzO4Qx5vgPQTGmhQU8u2nLCdy8IA57rMHxum3PNzbEEgemKs81gaXy0Mg+rGSkhQf
         asp1ww7KNvwS7VfFKPQenf3eQB1FY/bbksa9Lpu0phXk7mV6OTdUJtBAPMLVsWV2L8ZB
         ktyv7jBWsM/FVwu3Cl0xn7WizTkx6R9TBXfQLgq7OD9Q5/ph7gVBo6XwOcZXhbyGLwkr
         NxYzR6nj/4d7vp9APYmgLpeyA3P6fkUPLujpMp0RKugsavCNN56aIMKL7JDwtS9zxXdZ
         Ub3w==
X-Forwarded-Encrypted: i=1; AJvYcCVe6V4cJu1E06SjRQKtltYQKiNZzdTtvTLD06u7hIiLuNWZzsiLTJbC5Mh8CfzIswcdn9PnyqrNKRudByE+E88MnxLUu7OwijYEqfgS
X-Gm-Message-State: AOJu0YxTJS0dFtd3AFM9FW7ywugC1FMLerAlqq2meU0wbjZmutYt0AKH
	r5KCi4nJDCwUSik/OzZPSoW7yisQJIXhNiCvhoz+PwQg5zWKTjU5
X-Google-Smtp-Source: AGHT+IFsGT2Vdw+L1RIBMzdvjf4Fs7AZ2Tk7nuuQR7waQL+ySRS5wGAtaSYqVssZLh1iup4uIyzUIg==
X-Received: by 2002:a05:690c:6c84:b0:651:79ee:d14b with SMTP id 00721157ae682-658ef24bc7fmr189434157b3.29.1720936839238;
        Sat, 13 Jul 2024 23:00:39 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:977d:d7e0:6495:8c0b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ecd26acsm2033437b3a.217.2024.07.13.23.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 23:00:38 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kerne.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Input: msc5000_ts - remove the driver
Date: Sat, 13 Jul 2024 23:00:27 -0700
Message-ID: <20240714060029.1528662-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MCS-5000 belongs to the 1st generation of Melfas chips, manufactured in
2000-2007.

The driver relies on custom platform data (no DT support) and there
never were any users of this driver in the mainline kernel. The commit
adding the driver mentioned that the driver was tested on S3C6410 NCP
board (with Samsung S3C6410 SoC) but the touchscreen device was never
added to the board file. This board was removed in v6.3 in commit
743c8fbb90ca ("ARM: s3c: remove most s3c64xx board support").

Remove the driver since there are no users.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/Kconfig      |  12 --
 drivers/input/touchscreen/Makefile     |   1 -
 drivers/input/touchscreen/mcs5000_ts.c | 288 -------------------------
 include/linux/platform_data/mcs.h      |   4 -
 4 files changed, 305 deletions(-)
 delete mode 100644 drivers/input/touchscreen/mcs5000_ts.c

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index c821fe3ee794..0df90c3d743b 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -626,18 +626,6 @@ config TOUCHSCREEN_MAX11801
 	  To compile this driver as a module, choose M here: the
 	  module will be called max11801_ts.
 
-config TOUCHSCREEN_MCS5000
-	tristate "MELFAS MCS-5000 touchscreen"
-	depends on I2C
-	help
-	  Say Y here if you have the MELFAS MCS-5000 touchscreen controller
-	  chip in your system.
-
-	  If unsure, say N.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called mcs5000_ts.
-
 config TOUCHSCREEN_MMS114
 	tristate "MELFAS MMS114 touchscreen"
 	depends on I2C
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index a81cb5aa21a5..04dc8039341b 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -63,7 +63,6 @@ obj-$(CONFIG_TOUCHSCREEN_MAX11801)	+= max11801_ts.o
 obj-$(CONFIG_TOUCHSCREEN_MXS_LRADC)     += mxs-lradc-ts.o
 obj-$(CONFIG_TOUCHSCREEN_MX25)		+= fsl-imx25-tcq.o
 obj-$(CONFIG_TOUCHSCREEN_MC13783)	+= mc13783_ts.o
-obj-$(CONFIG_TOUCHSCREEN_MCS5000)	+= mcs5000_ts.o
 obj-$(CONFIG_TOUCHSCREEN_MELFAS_MIP4)	+= melfas_mip4.o
 obj-$(CONFIG_TOUCHSCREEN_MIGOR)		+= migor_ts.o
 obj-$(CONFIG_TOUCHSCREEN_MMS114)	+= mms114.o
diff --git a/drivers/input/touchscreen/mcs5000_ts.c b/drivers/input/touchscreen/mcs5000_ts.c
deleted file mode 100644
index 5aff8dcda0dc..000000000000
--- a/drivers/input/touchscreen/mcs5000_ts.c
+++ /dev/null
@@ -1,288 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * mcs5000_ts.c - Touchscreen driver for MELFAS MCS-5000 controller
- *
- * Copyright (C) 2009 Samsung Electronics Co.Ltd
- * Author: Joonyoung Shim <jy0922.shim@samsung.com>
- *
- * Based on wm97xx-core.c
- */
-
-#include <linux/module.h>
-#include <linux/i2c.h>
-#include <linux/interrupt.h>
-#include <linux/input.h>
-#include <linux/irq.h>
-#include <linux/platform_data/mcs.h>
-#include <linux/slab.h>
-
-/* Registers */
-#define MCS5000_TS_STATUS		0x00
-#define STATUS_OFFSET			0
-#define STATUS_NO			(0 << STATUS_OFFSET)
-#define STATUS_INIT			(1 << STATUS_OFFSET)
-#define STATUS_SENSING			(2 << STATUS_OFFSET)
-#define STATUS_COORD			(3 << STATUS_OFFSET)
-#define STATUS_GESTURE			(4 << STATUS_OFFSET)
-#define ERROR_OFFSET			4
-#define ERROR_NO			(0 << ERROR_OFFSET)
-#define ERROR_POWER_ON_RESET		(1 << ERROR_OFFSET)
-#define ERROR_INT_RESET			(2 << ERROR_OFFSET)
-#define ERROR_EXT_RESET			(3 << ERROR_OFFSET)
-#define ERROR_INVALID_REG_ADDRESS	(8 << ERROR_OFFSET)
-#define ERROR_INVALID_REG_VALUE		(9 << ERROR_OFFSET)
-
-#define MCS5000_TS_OP_MODE		0x01
-#define RESET_OFFSET			0
-#define RESET_NO			(0 << RESET_OFFSET)
-#define RESET_EXT_SOFT			(1 << RESET_OFFSET)
-#define OP_MODE_OFFSET			1
-#define OP_MODE_SLEEP			(0 << OP_MODE_OFFSET)
-#define OP_MODE_ACTIVE			(1 << OP_MODE_OFFSET)
-#define GESTURE_OFFSET			4
-#define GESTURE_DISABLE			(0 << GESTURE_OFFSET)
-#define GESTURE_ENABLE			(1 << GESTURE_OFFSET)
-#define PROXIMITY_OFFSET		5
-#define PROXIMITY_DISABLE		(0 << PROXIMITY_OFFSET)
-#define PROXIMITY_ENABLE		(1 << PROXIMITY_OFFSET)
-#define SCAN_MODE_OFFSET		6
-#define SCAN_MODE_INTERRUPT		(0 << SCAN_MODE_OFFSET)
-#define SCAN_MODE_POLLING		(1 << SCAN_MODE_OFFSET)
-#define REPORT_RATE_OFFSET		7
-#define REPORT_RATE_40			(0 << REPORT_RATE_OFFSET)
-#define REPORT_RATE_80			(1 << REPORT_RATE_OFFSET)
-
-#define MCS5000_TS_SENS_CTL		0x02
-#define MCS5000_TS_FILTER_CTL		0x03
-#define PRI_FILTER_OFFSET		0
-#define SEC_FILTER_OFFSET		4
-
-#define MCS5000_TS_X_SIZE_UPPER		0x08
-#define MCS5000_TS_X_SIZE_LOWER		0x09
-#define MCS5000_TS_Y_SIZE_UPPER		0x0A
-#define MCS5000_TS_Y_SIZE_LOWER		0x0B
-
-#define MCS5000_TS_INPUT_INFO		0x10
-#define INPUT_TYPE_OFFSET		0
-#define INPUT_TYPE_NONTOUCH		(0 << INPUT_TYPE_OFFSET)
-#define INPUT_TYPE_SINGLE		(1 << INPUT_TYPE_OFFSET)
-#define INPUT_TYPE_DUAL			(2 << INPUT_TYPE_OFFSET)
-#define INPUT_TYPE_PALM			(3 << INPUT_TYPE_OFFSET)
-#define INPUT_TYPE_PROXIMITY		(7 << INPUT_TYPE_OFFSET)
-#define GESTURE_CODE_OFFSET		3
-#define GESTURE_CODE_NO			(0 << GESTURE_CODE_OFFSET)
-
-#define MCS5000_TS_X_POS_UPPER		0x11
-#define MCS5000_TS_X_POS_LOWER		0x12
-#define MCS5000_TS_Y_POS_UPPER		0x13
-#define MCS5000_TS_Y_POS_LOWER		0x14
-#define MCS5000_TS_Z_POS		0x15
-#define MCS5000_TS_WIDTH		0x16
-#define MCS5000_TS_GESTURE_VAL		0x17
-#define MCS5000_TS_MODULE_REV		0x20
-#define MCS5000_TS_FIRMWARE_VER		0x21
-
-/* Touchscreen absolute values */
-#define MCS5000_MAX_XC			0x3ff
-#define MCS5000_MAX_YC			0x3ff
-
-enum mcs5000_ts_read_offset {
-	READ_INPUT_INFO,
-	READ_X_POS_UPPER,
-	READ_X_POS_LOWER,
-	READ_Y_POS_UPPER,
-	READ_Y_POS_LOWER,
-	READ_BLOCK_SIZE,
-};
-
-/* Each client has this additional data */
-struct mcs5000_ts_data {
-	struct i2c_client *client;
-	struct input_dev *input_dev;
-	const struct mcs_platform_data *platform_data;
-};
-
-static irqreturn_t mcs5000_ts_interrupt(int irq, void *dev_id)
-{
-	struct mcs5000_ts_data *data = dev_id;
-	struct i2c_client *client = data->client;
-	u8 buffer[READ_BLOCK_SIZE];
-	int err;
-	int x;
-	int y;
-
-	err = i2c_smbus_read_i2c_block_data(client, MCS5000_TS_INPUT_INFO,
-			READ_BLOCK_SIZE, buffer);
-	if (err < 0) {
-		dev_err(&client->dev, "%s, err[%d]\n", __func__, err);
-		goto out;
-	}
-
-	switch (buffer[READ_INPUT_INFO]) {
-	case INPUT_TYPE_NONTOUCH:
-		input_report_key(data->input_dev, BTN_TOUCH, 0);
-		input_sync(data->input_dev);
-		break;
-
-	case INPUT_TYPE_SINGLE:
-		x = (buffer[READ_X_POS_UPPER] << 8) | buffer[READ_X_POS_LOWER];
-		y = (buffer[READ_Y_POS_UPPER] << 8) | buffer[READ_Y_POS_LOWER];
-
-		input_report_key(data->input_dev, BTN_TOUCH, 1);
-		input_report_abs(data->input_dev, ABS_X, x);
-		input_report_abs(data->input_dev, ABS_Y, y);
-		input_sync(data->input_dev);
-		break;
-
-	case INPUT_TYPE_DUAL:
-		/* TODO */
-		break;
-
-	case INPUT_TYPE_PALM:
-		/* TODO */
-		break;
-
-	case INPUT_TYPE_PROXIMITY:
-		/* TODO */
-		break;
-
-	default:
-		dev_err(&client->dev, "Unknown ts input type %d\n",
-				buffer[READ_INPUT_INFO]);
-		break;
-	}
-
- out:
-	return IRQ_HANDLED;
-}
-
-static void mcs5000_ts_phys_init(struct mcs5000_ts_data *data,
-				 const struct mcs_platform_data *platform_data)
-{
-	struct i2c_client *client = data->client;
-
-	/* Touch reset & sleep mode */
-	i2c_smbus_write_byte_data(client, MCS5000_TS_OP_MODE,
-			RESET_EXT_SOFT | OP_MODE_SLEEP);
-
-	/* Touch size */
-	i2c_smbus_write_byte_data(client, MCS5000_TS_X_SIZE_UPPER,
-			platform_data->x_size >> 8);
-	i2c_smbus_write_byte_data(client, MCS5000_TS_X_SIZE_LOWER,
-			platform_data->x_size & 0xff);
-	i2c_smbus_write_byte_data(client, MCS5000_TS_Y_SIZE_UPPER,
-			platform_data->y_size >> 8);
-	i2c_smbus_write_byte_data(client, MCS5000_TS_Y_SIZE_LOWER,
-			platform_data->y_size & 0xff);
-
-	/* Touch active mode & 80 report rate */
-	i2c_smbus_write_byte_data(data->client, MCS5000_TS_OP_MODE,
-			OP_MODE_ACTIVE | REPORT_RATE_80);
-}
-
-static int mcs5000_ts_probe(struct i2c_client *client)
-{
-	const struct mcs_platform_data *pdata;
-	struct mcs5000_ts_data *data;
-	struct input_dev *input_dev;
-	int error;
-
-	pdata = dev_get_platdata(&client->dev);
-	if (!pdata)
-		return -EINVAL;
-
-	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
-	if (!data) {
-		dev_err(&client->dev, "Failed to allocate memory\n");
-		return -ENOMEM;
-	}
-
-	data->client = client;
-
-	input_dev = devm_input_allocate_device(&client->dev);
-	if (!input_dev) {
-		dev_err(&client->dev, "Failed to allocate input device\n");
-		return -ENOMEM;
-	}
-
-	input_dev->name = "MELFAS MCS-5000 Touchscreen";
-	input_dev->id.bustype = BUS_I2C;
-	input_dev->dev.parent = &client->dev;
-
-	__set_bit(EV_ABS, input_dev->evbit);
-	__set_bit(EV_KEY, input_dev->evbit);
-	__set_bit(BTN_TOUCH, input_dev->keybit);
-	input_set_abs_params(input_dev, ABS_X, 0, MCS5000_MAX_XC, 0, 0);
-	input_set_abs_params(input_dev, ABS_Y, 0, MCS5000_MAX_YC, 0, 0);
-
-	data->input_dev = input_dev;
-
-	if (pdata->cfg_pin)
-		pdata->cfg_pin();
-
-	error = devm_request_threaded_irq(&client->dev, client->irq,
-					  NULL, mcs5000_ts_interrupt,
-					  IRQF_TRIGGER_LOW | IRQF_ONESHOT,
-					  "mcs5000_ts", data);
-	if (error) {
-		dev_err(&client->dev, "Failed to register interrupt\n");
-		return error;
-	}
-
-	error = input_register_device(data->input_dev);
-	if (error) {
-		dev_err(&client->dev, "Failed to register input device\n");
-		return error;
-	}
-
-	mcs5000_ts_phys_init(data, pdata);
-	i2c_set_clientdata(client, data);
-
-	return 0;
-}
-
-static int mcs5000_ts_suspend(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-
-	/* Touch sleep mode */
-	i2c_smbus_write_byte_data(client, MCS5000_TS_OP_MODE, OP_MODE_SLEEP);
-
-	return 0;
-}
-
-static int mcs5000_ts_resume(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct mcs5000_ts_data *data = i2c_get_clientdata(client);
-	const struct mcs_platform_data *pdata = dev_get_platdata(dev);
-
-	mcs5000_ts_phys_init(data, pdata);
-
-	return 0;
-}
-
-static DEFINE_SIMPLE_DEV_PM_OPS(mcs5000_ts_pm,
-				mcs5000_ts_suspend, mcs5000_ts_resume);
-
-static const struct i2c_device_id mcs5000_ts_id[] = {
-	{ "mcs5000_ts" },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, mcs5000_ts_id);
-
-static struct i2c_driver mcs5000_ts_driver = {
-	.probe		= mcs5000_ts_probe,
-	.driver = {
-		.name = "mcs5000_ts",
-		.pm   = pm_sleep_ptr(&mcs5000_ts_pm),
-	},
-	.id_table	= mcs5000_ts_id,
-};
-
-module_i2c_driver(mcs5000_ts_driver);
-
-/* Module information */
-MODULE_AUTHOR("Joonyoung Shim <jy0922.shim@samsung.com>");
-MODULE_DESCRIPTION("Touchscreen driver for MELFAS MCS-5000 controller");
-MODULE_LICENSE("GPL");
diff --git a/include/linux/platform_data/mcs.h b/include/linux/platform_data/mcs.h
index fcc6f2a1f5c3..f3b0749f1630 100644
--- a/include/linux/platform_data/mcs.h
+++ b/include/linux/platform_data/mcs.h
@@ -16,10 +16,6 @@ struct mcs_platform_data {
 	void (*poweron)(bool);
 	void (*cfg_pin)(void);
 
-	/* touchscreen */
-	unsigned int x_size;
-	unsigned int y_size;
-
 	/* touchkey */
 	const u32 *keymap;
 	unsigned int keymap_size;
-- 
2.45.2.993.g49e7a77208-goog


