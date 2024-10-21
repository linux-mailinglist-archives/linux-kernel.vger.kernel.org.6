Return-Path: <linux-kernel+bounces-373565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9AA9A58DF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 04:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C5D61F215C7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 02:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305781E4A4;
	Mon, 21 Oct 2024 02:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ee3/Ydnh"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9595615C0
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 02:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729477942; cv=none; b=O1b0SQrU3aWlltWSz/glUXUJYUQ63YdDpuJuGDz8BgNEbI6+LmzmZdH3muvL7A++MbOvveBTXilhgtviCq8d2T5Q9b+D285eRUqMNZ9zfS6I5Rp0cpFaB8/D9AtkB/G+KMGTAioFa5x+7XX/KCmCxjajqno80lCvJ+685FvEUMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729477942; c=relaxed/simple;
	bh=Daju35WUgjpPsBoONAp6Pf6fDAJSepgSnT6QIpluYV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZwjLF8ipH/fwtI4+PHxl/4xYmRiXMDYUXF2t5BdTjSz4ewJ5Vu57QIKWvKL8v/lP6MEzM6M1/GmiREq1wQqPqtcJXU2EAsauM2e/QXrk8yGwZqmjDb5dcS0ZAe7QHdwuJsEH5H2tB3QTy5mxgd9eiLxSMehi8l74ZolAXqVnZ40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ee3/Ydnh; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71e72db7bb1so2913421b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 19:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729477940; x=1730082740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JWG/7LkAlgP90UDcguaLP9EXEksqFk5VlcNJRKMNtNM=;
        b=Ee3/YdnhQXzyuYyUwT7rkOqtmStMfXTac9IvLUH5z5OkB8rKC7xzG06DffNhO1tHP1
         nW95lPDBDMDfNCYjLwU7bQX3NO6HmejEo2rp2bNQspFtGizAV8P3iPw7YTXIw1xaNWqv
         NI0jOodVKZpi3DPbDHd2cDU2gO95TgxfooAepSG9TjTt4g1PDWbD1oqVLS2GcIggcJK4
         cAOB7hhrG4x5DnpFBLrQxW3M4nZZEL7i+0VYQK0bRaj6wLJK6J1Tu4d5fDrIfTuJFvzK
         gHN1tZ6q36UO+/StfDO1emFx4wUexVO9/dxTVlj8AdcwStJNqrdAefvlriZUUes7TgdJ
         qBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729477940; x=1730082740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JWG/7LkAlgP90UDcguaLP9EXEksqFk5VlcNJRKMNtNM=;
        b=iQvqmiPdrHVmWnYF/ZIFEb5kqY/xaMLI+hmOhg5RrBAHVnCqvWSeAy2sswmorv7V68
         tJS7T+Xr58fffHaJHUfPK6wMLcB5PxEqshpb6a6JymNmMIkCITy0ufcc46F7CiNl/C9H
         I2JbQS8tL2rqDhUe+byt5IoNTAxrUH9loHRLH/m7WJFwXcPBNP1DE2wGysjdRGiLClPp
         4aHAq+e2ej1CD6nLRswDjZi9bBnCPZZB2AJ0y/S94P+rSDKO7jRBVIQgzM/hQdFlFsF2
         JQnrwMKOvTGRNJUYElgLI6lENnyOwjGe28qNOOmtm6mwYMgbPwfjNjyambFp90MA9/JL
         NdUw==
X-Forwarded-Encrypted: i=1; AJvYcCWQCOAu7uU9tNvfcwc2+CeCr/hqo0pgEKfZbSItMooACj1WEv+rql8vgjIHBpJRWzMH4B8Wdb/9wbhYZ84=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFQJOEBgfKaMPHy/a6skU/bY2L8NRbri6YyVMFnMwUtKuXGOgJ
	57yTnp4ngpQax2aoCnmusewKBL5T/RI9ChVZjinWA33DfTlnjiV6zoCl17yx
X-Google-Smtp-Source: AGHT+IFYyk8CVrDwkRticBp6a2dhSCiUkF6YX3DPNYLpCeSb/uvVMWqMV67+Y7VVEu3+lA81yhm5ag==
X-Received: by 2002:a05:6a20:e605:b0:1d9:ce8:35aa with SMTP id adf61e73a8af0-1d92c590f39mr13959549637.49.1729477939747;
        Sun, 20 Oct 2024 19:32:19 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0f64cfsm15969195ad.284.2024.10.20.19.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 19:32:19 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-staging@lists.linux.dev
Cc: Rui Miguel Silva <rmfrfs@gmail.com>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	greybus-dev@lists.linaro.org (moderated list:GREYBUS SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] staging: greybus: gpio: use gpiochip_get_data
Date: Sun, 20 Oct 2024 19:32:17 -0700
Message-ID: <20241021023217.319545-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of container_of, we can populate gpiochip_add_data 's last
parameter and use gpiochip_get_data. It seems to be the standard.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/staging/greybus/gpio.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/greybus/gpio.c b/drivers/staging/greybus/gpio.c
index 9b26e148d40f..16bcf7fc8158 100644
--- a/drivers/staging/greybus/gpio.c
+++ b/drivers/staging/greybus/gpio.c
@@ -42,11 +42,6 @@ struct gb_gpio_controller {
 	struct mutex		irq_lock;
 };
 
-static inline struct gb_gpio_controller *gpio_chip_to_gb_gpio_controller(struct gpio_chip *chip)
-{
-	return container_of(chip, struct gb_gpio_controller, chip);
-}
-
 static struct gpio_chip *irq_data_to_gpio_chip(struct irq_data *d)
 {
 	return d->domain->host_data;
@@ -278,7 +273,7 @@ static void _gb_gpio_irq_set_type(struct gb_gpio_controller *ggc,
 static void gb_gpio_irq_mask(struct irq_data *d)
 {
 	struct gpio_chip *chip = irq_data_to_gpio_chip(d);
-	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
+	struct gb_gpio_controller *ggc = gpiochip_get_data(chip);
 	struct gb_gpio_line *line = &ggc->lines[d->hwirq];
 
 	line->masked = true;
@@ -288,7 +283,7 @@ static void gb_gpio_irq_mask(struct irq_data *d)
 static void gb_gpio_irq_unmask(struct irq_data *d)
 {
 	struct gpio_chip *chip = irq_data_to_gpio_chip(d);
-	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
+	struct gb_gpio_controller *ggc = gpiochip_get_data(chip);
 	struct gb_gpio_line *line = &ggc->lines[d->hwirq];
 
 	line->masked = false;
@@ -298,7 +293,7 @@ static void gb_gpio_irq_unmask(struct irq_data *d)
 static int gb_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 {
 	struct gpio_chip *chip = irq_data_to_gpio_chip(d);
-	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
+	struct gb_gpio_controller *ggc = gpiochip_get_data(chip);
 	struct gb_gpio_line *line = &ggc->lines[d->hwirq];
 	struct device *dev = &ggc->gbphy_dev->dev;
 	u8 irq_type;
@@ -336,7 +331,7 @@ static int gb_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 static void gb_gpio_irq_bus_lock(struct irq_data *d)
 {
 	struct gpio_chip *chip = irq_data_to_gpio_chip(d);
-	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
+	struct gb_gpio_controller *ggc = gpiochip_get_data(chip);
 
 	mutex_lock(&ggc->irq_lock);
 }
@@ -344,7 +339,7 @@ static void gb_gpio_irq_bus_lock(struct irq_data *d)
 static void gb_gpio_irq_bus_sync_unlock(struct irq_data *d)
 {
 	struct gpio_chip *chip = irq_data_to_gpio_chip(d);
-	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
+	struct gb_gpio_controller *ggc = gpiochip_get_data(chip);
 	struct gb_gpio_line *line = &ggc->lines[d->hwirq];
 
 	if (line->irq_type_pending) {
@@ -407,21 +402,21 @@ static int gb_gpio_request_handler(struct gb_operation *op)
 
 static int gb_gpio_request(struct gpio_chip *chip, unsigned int offset)
 {
-	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
+	struct gb_gpio_controller *ggc = gpiochip_get_data(chip);
 
 	return gb_gpio_activate_operation(ggc, (u8)offset);
 }
 
 static void gb_gpio_free(struct gpio_chip *chip, unsigned int offset)
 {
-	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
+	struct gb_gpio_controller *ggc = gpiochip_get_data(chip);
 
 	gb_gpio_deactivate_operation(ggc, (u8)offset);
 }
 
 static int gb_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
 {
-	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
+	struct gb_gpio_controller *ggc = gpiochip_get_data(chip);
 	u8 which;
 	int ret;
 
@@ -435,7 +430,7 @@ static int gb_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
 
 static int gb_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
 {
-	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
+	struct gb_gpio_controller *ggc = gpiochip_get_data(chip);
 
 	return gb_gpio_direction_in_operation(ggc, (u8)offset);
 }
@@ -443,14 +438,14 @@ static int gb_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
 static int gb_gpio_direction_output(struct gpio_chip *chip, unsigned int offset,
 				    int value)
 {
-	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
+	struct gb_gpio_controller *ggc = gpiochip_get_data(chip);
 
 	return gb_gpio_direction_out_operation(ggc, (u8)offset, !!value);
 }
 
 static int gb_gpio_get(struct gpio_chip *chip, unsigned int offset)
 {
-	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
+	struct gb_gpio_controller *ggc = gpiochip_get_data(chip);
 	u8 which;
 	int ret;
 
@@ -464,7 +459,7 @@ static int gb_gpio_get(struct gpio_chip *chip, unsigned int offset)
 
 static void gb_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
 {
-	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
+	struct gb_gpio_controller *ggc = gpiochip_get_data(chip);
 
 	gb_gpio_set_value_operation(ggc, (u8)offset, !!value);
 }
@@ -472,7 +467,7 @@ static void gb_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
 static int gb_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 			      unsigned long config)
 {
-	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
+	struct gb_gpio_controller *ggc = gpiochip_get_data(chip);
 	u32 debounce;
 
 	if (pinconf_to_config_param(config) != PIN_CONFIG_INPUT_DEBOUNCE)
@@ -579,7 +574,7 @@ static int gb_gpio_probe(struct gbphy_device *gbphy_dev,
 	if (ret)
 		goto exit_line_free;
 
-	ret = gpiochip_add_data(gpio, NULL);
+	ret = gpiochip_add_data(gpio, ggc);
 	if (ret) {
 		dev_err(&gbphy_dev->dev, "failed to add gpio chip: %d\n", ret);
 		goto exit_line_free;
-- 
2.47.0


