Return-Path: <linux-kernel+bounces-251715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F24593089E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 08:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E10D01F21684
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 06:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E095413ADA;
	Sun, 14 Jul 2024 06:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNirQzGN"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B303101CE
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 06:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720936842; cv=none; b=AzdTE7/AyS+8qg2xV25LcoONFrYjhhI2KF6go0u4P7PB5ois4jGLPRrBO/dt+lKmDhRvHEhqDGXEwaDuC3x//g5+JkeOUArkheszdyKS/biVfGBTYBS8cTj8gucuDKD2Hz35LMMGoD/tMBEAkPkUCTplX6W+v67gMZyfDDsgtOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720936842; c=relaxed/simple;
	bh=BR7nMWrHGwOuwSjm+vtsQ9yxg3NzIiBTQ4is+M0KFow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YRUyKPNlia/02B5a+iKOPSbcpJZGa7zpGpsCZZDdIbxtLZv4ruBFGR1ueD+kD/LE+LI+/8P+Nkm/cYUFeinzvl29VZas6XXWAdwNPX467EkEw4D4Z9gJC8LUB/KfF1Y54zuotWZVt4Eha5wNZjj21zr/qPRVj/zxW9ZDxtmiBEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNirQzGN; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2608c51c97aso178891fac.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 23:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720936840; x=1721541640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8u3uLooAz7uyQs+oApWszHnV6IB5GA+3nL76rqRq1ww=;
        b=bNirQzGNZQXl9zDaGkSBIlISsOe88CunAmDdTh3suiwRYi7w0sBL0YuZ//Eaungng7
         tbO6cl/pHNg67d1avMwvJ0lxs0V6SWIG/2rZ96qXB3h6aJBiIiDwk6LHpvd/2l+4MhWA
         /yMfJx0aiK/HZQWz+0EsUuEolaolg8uHXKip745rWWIc98PgitF3liQmrYh9eUbicnw3
         /CE3m9YsTgVEUCnaeTF2QoW6wiO5gj09RPFPDf7Gk0fXCNV6Z9ogx/H/8MuMcSJcMWap
         PYLvQi2BCeELmAHMHiHx0xDccUiWuaAgck95+bDCoZv9ESxAxJw7+3fl+me71WgR8E/V
         PY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720936840; x=1721541640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8u3uLooAz7uyQs+oApWszHnV6IB5GA+3nL76rqRq1ww=;
        b=n3L8OO8piFwW7h2ajBBcPs1t5NM0cxRAuxHQWvbdq9oqqCdoYoZ7lY0XdzZ89LI4Rm
         TOjS3MGnkKrgOfRIGcWBXgrxe1ItZmADBqH6n+JR6QfbWSsaPWrA8XMI7/LLTNqM0K6C
         qbb0R6qLUgrdGkWY0152Oo6Odpwa37sHPiw9NJlaXADdmwWq0POWp4mEHhShc92TLYEL
         31qAx7xHSh6LwO2hsc5pSsyC0K3drDvAWAjOx2qLQubaw0YetjG57P+ZyzaZ8yIgF2LO
         AHqtwYEu7fD2xry14bQsZOIcs7lK1Gvf1YzMAhchrAwUY2xEdbWAPqrfzgQfERrHP5rh
         L8XQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0dotQ+w/lQACDU4Y5Z7zt27xUopMY3TkrHZFuc8P77TLP99zrdIYey7ihbPJbh5wMvOyAkyHl8MrUkppdhHy4KJ1WYwIDMIGryFBv
X-Gm-Message-State: AOJu0YzLr5YBhgJhB17BfTKwgBMG4KVm0T3O+kPPVLfcW0xH34YPeVUL
	DZIatwCgWn24cA2OFG/P0Dz4N5sN/kd7l5QlyU+GS8S0WyB6DGSR
X-Google-Smtp-Source: AGHT+IFRuhnTzcQJIz+DddVtPe/FyyM1gf/2FjXqguQXDAp8CMwk8lpOjCggUWlHFZWpuA96JHEtDw==
X-Received: by 2002:a05:6871:286:b0:25e:2748:3fe6 with SMTP id 586e51a60fabf-25eae8327e6mr13456450fac.29.1720936839991;
        Sat, 13 Jul 2024 23:00:39 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:977d:d7e0:6495:8c0b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ecd26acsm2033437b3a.217.2024.07.13.23.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 23:00:39 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kerne.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Input: msc_touchkey - remove the driver
Date: Sat, 13 Jul 2024 23:00:28 -0700
Message-ID: <20240714060029.1528662-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
In-Reply-To: <20240714060029.1528662-1-dmitry.torokhov@gmail.com>
References: <20240714060029.1528662-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MCS-5000/5080 chips belong to the 1st generation of Melfas chips,
manufactured in 2000-2007.

The driver relies on custom platform data (no DT support) and there
never were any users of this driver in the mainline kernel. It is likely
that the driver was (like mcs5000_ts driver) was tested on S3C6410 NCP
board (with Samsung S3C6410 SoC), but the touchkey device was never
added to the board file. This board was removed in v6.3 in commit
743c8fbb90ca ("ARM: s3c: remove most s3c64xx board support").

Remove the driver since there are no users.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/Kconfig        |  12 --
 drivers/input/keyboard/Makefile       |   1 -
 drivers/input/keyboard/mcs_touchkey.c | 268 --------------------------
 include/linux/platform_data/mcs.h     |  26 ---
 4 files changed, 307 deletions(-)
 delete mode 100644 drivers/input/keyboard/mcs_touchkey.c
 delete mode 100644 include/linux/platform_data/mcs.h

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 1d0c5f4c0f99..72f9552cb571 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -421,18 +421,6 @@ config KEYBOARD_MAX7359
 	  To compile this driver as a module, choose M here: the
 	  module will be called max7359_keypad.
 
-config KEYBOARD_MCS
-	tristate "MELFAS MCS Touchkey"
-	depends on I2C
-	help
-	  Say Y here if you have the MELFAS MCS5000/5080 touchkey controller
-	  chip in your system.
-
-	  If unsure, say N.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called mcs_touchkey.
-
 config KEYBOARD_MPR121
 	tristate "Freescale MPR121 Touchkey"
 	depends on I2C
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index aecef00c5d09..b8d12a0524e0 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -41,7 +41,6 @@ obj-$(CONFIG_KEYBOARD_LPC32XX)		+= lpc32xx-keys.o
 obj-$(CONFIG_KEYBOARD_MAPLE)		+= maple_keyb.o
 obj-$(CONFIG_KEYBOARD_MATRIX)		+= matrix_keypad.o
 obj-$(CONFIG_KEYBOARD_MAX7359)		+= max7359_keypad.o
-obj-$(CONFIG_KEYBOARD_MCS)		+= mcs_touchkey.o
 obj-$(CONFIG_KEYBOARD_MPR121)		+= mpr121_touchkey.o
 obj-$(CONFIG_KEYBOARD_MT6779)		+= mt6779-keypad.o
 obj-$(CONFIG_KEYBOARD_MTK_PMIC) 	+= mtk-pmic-keys.o
diff --git a/drivers/input/keyboard/mcs_touchkey.c b/drivers/input/keyboard/mcs_touchkey.c
deleted file mode 100644
index 2410f676c7f9..000000000000
--- a/drivers/input/keyboard/mcs_touchkey.c
+++ /dev/null
@@ -1,268 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Touchkey driver for MELFAS MCS5000/5080 controller
- *
- * Copyright (C) 2010 Samsung Electronics Co.Ltd
- * Author: HeungJun Kim <riverful.kim@samsung.com>
- * Author: Joonyoung Shim <jy0922.shim@samsung.com>
- */
-
-#include <linux/module.h>
-#include <linux/i2c.h>
-#include <linux/interrupt.h>
-#include <linux/input.h>
-#include <linux/irq.h>
-#include <linux/slab.h>
-#include <linux/platform_data/mcs.h>
-#include <linux/pm.h>
-
-/* MCS5000 Touchkey */
-#define MCS5000_TOUCHKEY_STATUS		0x04
-#define MCS5000_TOUCHKEY_STATUS_PRESS	7
-#define MCS5000_TOUCHKEY_FW		0x0a
-#define MCS5000_TOUCHKEY_BASE_VAL	0x61
-
-/* MCS5080 Touchkey */
-#define MCS5080_TOUCHKEY_STATUS		0x00
-#define MCS5080_TOUCHKEY_STATUS_PRESS	3
-#define MCS5080_TOUCHKEY_FW		0x01
-#define MCS5080_TOUCHKEY_BASE_VAL	0x1
-
-enum mcs_touchkey_type {
-	MCS5000_TOUCHKEY,
-	MCS5080_TOUCHKEY,
-};
-
-struct mcs_touchkey_chip {
-	unsigned int status_reg;
-	unsigned int pressbit;
-	unsigned int press_invert;
-	unsigned int baseval;
-};
-
-struct mcs_touchkey_data {
-	void (*poweron)(bool);
-
-	struct i2c_client *client;
-	struct input_dev *input_dev;
-	struct mcs_touchkey_chip chip;
-	unsigned int key_code;
-	unsigned int key_val;
-	unsigned short keycodes[];
-};
-
-static irqreturn_t mcs_touchkey_interrupt(int irq, void *dev_id)
-{
-	struct mcs_touchkey_data *data = dev_id;
-	struct mcs_touchkey_chip *chip = &data->chip;
-	struct i2c_client *client = data->client;
-	struct input_dev *input = data->input_dev;
-	unsigned int key_val;
-	unsigned int pressed;
-	int val;
-
-	val = i2c_smbus_read_byte_data(client, chip->status_reg);
-	if (val < 0) {
-		dev_err(&client->dev, "i2c read error [%d]\n", val);
-		goto out;
-	}
-
-	pressed = (val & (1 << chip->pressbit)) >> chip->pressbit;
-	if (chip->press_invert)
-		pressed ^= chip->press_invert;
-
-	/* key_val is 0 when released, so we should use key_val of press. */
-	if (pressed) {
-		key_val = val & (0xff >> (8 - chip->pressbit));
-		if (!key_val)
-			goto out;
-		key_val -= chip->baseval;
-		data->key_code = data->keycodes[key_val];
-		data->key_val = key_val;
-	}
-
-	input_event(input, EV_MSC, MSC_SCAN, data->key_val);
-	input_report_key(input, data->key_code, pressed);
-	input_sync(input);
-
-	dev_dbg(&client->dev, "key %d %d %s\n", data->key_val, data->key_code,
-		pressed ? "pressed" : "released");
-
- out:
-	return IRQ_HANDLED;
-}
-
-static void mcs_touchkey_poweroff(void *data)
-{
-	struct mcs_touchkey_data *touchkey = data;
-
-	touchkey->poweron(false);
-}
-
-static int mcs_touchkey_probe(struct i2c_client *client)
-{
-	const struct i2c_device_id *id = i2c_client_get_device_id(client);
-	const struct mcs_platform_data *pdata;
-	struct mcs_touchkey_data *data;
-	struct input_dev *input_dev;
-	unsigned int fw_reg;
-	int fw_ver;
-	int error;
-	int i;
-
-	pdata = dev_get_platdata(&client->dev);
-	if (!pdata) {
-		dev_err(&client->dev, "no platform data defined\n");
-		return -EINVAL;
-	}
-
-	data = devm_kzalloc(&client->dev,
-			    struct_size(data, keycodes, pdata->key_maxval + 1),
-			    GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	input_dev = devm_input_allocate_device(&client->dev);
-	if (!input_dev) {
-		dev_err(&client->dev, "Failed to allocate input device\n");
-		return -ENOMEM;
-	}
-
-	data->client = client;
-	data->input_dev = input_dev;
-
-	if (id->driver_data == MCS5000_TOUCHKEY) {
-		data->chip.status_reg = MCS5000_TOUCHKEY_STATUS;
-		data->chip.pressbit = MCS5000_TOUCHKEY_STATUS_PRESS;
-		data->chip.baseval = MCS5000_TOUCHKEY_BASE_VAL;
-		fw_reg = MCS5000_TOUCHKEY_FW;
-	} else {
-		data->chip.status_reg = MCS5080_TOUCHKEY_STATUS;
-		data->chip.pressbit = MCS5080_TOUCHKEY_STATUS_PRESS;
-		data->chip.press_invert = 1;
-		data->chip.baseval = MCS5080_TOUCHKEY_BASE_VAL;
-		fw_reg = MCS5080_TOUCHKEY_FW;
-	}
-
-	fw_ver = i2c_smbus_read_byte_data(client, fw_reg);
-	if (fw_ver < 0) {
-		dev_err(&client->dev, "i2c read error[%d]\n", fw_ver);
-		return fw_ver;
-	}
-	dev_info(&client->dev, "Firmware version: %d\n", fw_ver);
-
-	input_dev->name = "MELFAS MCS Touchkey";
-	input_dev->id.bustype = BUS_I2C;
-	input_dev->evbit[0] = BIT_MASK(EV_KEY);
-	if (!pdata->no_autorepeat)
-		input_dev->evbit[0] |= BIT_MASK(EV_REP);
-	input_dev->keycode = data->keycodes;
-	input_dev->keycodesize = sizeof(data->keycodes[0]);
-	input_dev->keycodemax = pdata->key_maxval + 1;
-
-	for (i = 0; i < pdata->keymap_size; i++) {
-		unsigned int val = MCS_KEY_VAL(pdata->keymap[i]);
-		unsigned int code = MCS_KEY_CODE(pdata->keymap[i]);
-
-		data->keycodes[val] = code;
-		__set_bit(code, input_dev->keybit);
-	}
-
-	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
-	input_set_drvdata(input_dev, data);
-
-	if (pdata->cfg_pin)
-		pdata->cfg_pin();
-
-	if (pdata->poweron) {
-		data->poweron = pdata->poweron;
-		data->poweron(true);
-
-		error = devm_add_action_or_reset(&client->dev,
-						 mcs_touchkey_poweroff, data);
-		if (error)
-			return error;
-	}
-
-	error = devm_request_threaded_irq(&client->dev, client->irq,
-					  NULL, mcs_touchkey_interrupt,
-					  IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-					  client->dev.driver->name, data);
-	if (error) {
-		dev_err(&client->dev, "Failed to register interrupt\n");
-		return error;
-	}
-
-	error = input_register_device(input_dev);
-	if (error)
-		return error;
-
-	i2c_set_clientdata(client, data);
-	return 0;
-}
-
-static void mcs_touchkey_shutdown(struct i2c_client *client)
-{
-	struct mcs_touchkey_data *data = i2c_get_clientdata(client);
-
-	if (data->poweron)
-		data->poweron(false);
-}
-
-static int mcs_touchkey_suspend(struct device *dev)
-{
-	struct mcs_touchkey_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
-
-	/* Disable the work */
-	disable_irq(client->irq);
-
-	/* Finally turn off the power */
-	if (data->poweron)
-		data->poweron(false);
-
-	return 0;
-}
-
-static int mcs_touchkey_resume(struct device *dev)
-{
-	struct mcs_touchkey_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
-
-	/* Enable the device first */
-	if (data->poweron)
-		data->poweron(true);
-
-	/* Enable irq again */
-	enable_irq(client->irq);
-
-	return 0;
-}
-
-static DEFINE_SIMPLE_DEV_PM_OPS(mcs_touchkey_pm_ops,
-				mcs_touchkey_suspend, mcs_touchkey_resume);
-
-static const struct i2c_device_id mcs_touchkey_id[] = {
-	{ "mcs5000_touchkey", MCS5000_TOUCHKEY },
-	{ "mcs5080_touchkey", MCS5080_TOUCHKEY },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, mcs_touchkey_id);
-
-static struct i2c_driver mcs_touchkey_driver = {
-	.driver = {
-		.name	= "mcs_touchkey",
-		.pm	= pm_sleep_ptr(&mcs_touchkey_pm_ops),
-	},
-	.probe		= mcs_touchkey_probe,
-	.shutdown       = mcs_touchkey_shutdown,
-	.id_table	= mcs_touchkey_id,
-};
-
-module_i2c_driver(mcs_touchkey_driver);
-
-/* Module information */
-MODULE_AUTHOR("Joonyoung Shim <jy0922.shim@samsung.com>");
-MODULE_AUTHOR("HeungJun Kim <riverful.kim@samsung.com>");
-MODULE_DESCRIPTION("Touchkey driver for MELFAS MCS5000/5080 controller");
-MODULE_LICENSE("GPL");
diff --git a/include/linux/platform_data/mcs.h b/include/linux/platform_data/mcs.h
deleted file mode 100644
index f3b0749f1630..000000000000
--- a/include/linux/platform_data/mcs.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2009 - 2010 Samsung Electronics Co.Ltd
- * Author: Joonyoung Shim <jy0922.shim@samsung.com>
- * Author: HeungJun Kim <riverful.kim@samsung.com>
- */
-
-#ifndef __LINUX_MCS_H
-#define __LINUX_MCS_H
-
-#define MCS_KEY_MAP(v, c)	((((v) & 0xff) << 16) | ((c) & 0xffff))
-#define MCS_KEY_VAL(v)		(((v) >> 16) & 0xff)
-#define MCS_KEY_CODE(v)		((v) & 0xffff)
-
-struct mcs_platform_data {
-	void (*poweron)(bool);
-	void (*cfg_pin)(void);
-
-	/* touchkey */
-	const u32 *keymap;
-	unsigned int keymap_size;
-	unsigned int key_maxval;
-	bool no_autorepeat;
-};
-
-#endif	/* __LINUX_MCS_H */
-- 
2.45.2.993.g49e7a77208-goog


