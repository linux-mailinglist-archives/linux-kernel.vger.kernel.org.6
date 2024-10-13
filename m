Return-Path: <linux-kernel+bounces-362876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 637E199BA89
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 19:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70FEB1C20B2B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 17:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE6B1487E3;
	Sun, 13 Oct 2024 17:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDnOdlzJ"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674F383CDA
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 17:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728840494; cv=none; b=qVLuLKkYFiXRNEIr4aTAw+jAhrYmkzB9eJ/gI99trBuPNluce3v7ltlgfRVtcWdzQ78+/REIzZaii0wfkKTsygCz7or7xn0Krf69e/YbX7vs1UxiKkqxNslr5EgQvigcj9Hini9vwjJBWdHoPl9eUShwH8OZRh6pwIJx3ghUW3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728840494; c=relaxed/simple;
	bh=jhpVZhYii328MqmeRuVbNj/zHk0XX/BzrNf2NoebPHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aaU3w0pr6tZQik5gt+3I/WlwRGAOf6syqU4kiJOSTJmpy0o/Mvl/ofgAnRF1SMB6WipNqXt06wsfYICeDJ27+FR8OIUY6LRDKiZ/BDeDmLMG+NrT9ha54XJrf9vjCo/Io15q1l79m9Els+FCpkmQuEqL1GXfJ+adIVrl6xia1SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDnOdlzJ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso27757766b.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 10:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728840490; x=1729445290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GZ517O2B5oziSwA7FUSNxnxFL0yekuTEbMEgvxeZ5q4=;
        b=nDnOdlzJkkCYHo0MPslG7eJoSkcqVnvCFbZY/gi3v0DdI5VEOn91ZE97yEQjDuhptv
         uKCcBAV+bo5gnp/TsB5uvfFnWGVq3APzX8QccTh3dFQvcAyp/ylHXxWoNomFvUWyw5V8
         SASaVSMS1WDSiDlekBRVmZF9HHfEn+AM90g0cZ61Q0n0F9v3/0cAzcMaPomHxclXY9ib
         Jgc5106+ngd9EVKC722PfIWDEZ+iufNzqhdZrrAeDH5vf6GltgTkXkmWwYn2q3P7Uy4K
         EaLyGNgFRf8ptK6mjHnBwJe5mqoGRE3tI0ongxbPQNOl6+zsWYdq9I8NnCHcSPI4MVu9
         8ttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728840490; x=1729445290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GZ517O2B5oziSwA7FUSNxnxFL0yekuTEbMEgvxeZ5q4=;
        b=KxVbOjSKIqmSUer0ibXnljLoE2T+J1nwCfTHmXsKvyO5IZLXnC8OBlD6V6lOEDQ/Lz
         5kfx+NimSINRi2kLP3vPD7B87jzv7PN+gijvsqa3saaFU7qLo6jDrkY2oiHfpKO7d9ci
         jy42XpOTVoq2hwyHNlJuRK6DBcmqfS8bI4uu28MM2I3Zeik4LQLHiwbMWOvu3nvBjQIY
         06Gzzm+3bpFjlSa7avSxWFI0giu3uUZWvgPSH8JSqeY13n0UGrkNp9brCQ+ubdv0VWPq
         brNLo2IP5+Tt9ctBFF5Tjqh06jywhfBKPfkWlpz5kDd6zHfhoaoheFXVJtwKQoLwW4PH
         +J0A==
X-Forwarded-Encrypted: i=1; AJvYcCX63VIzouyYJUbSfgXlXHZ73qbkC19gOy5bIk2lfUjMRyQZB8l6mkIf9Q6/dGhC5R0xagSpXkOZTVlvvBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGMYmhRBJoMWXXQ1TnMKE8A5djUDwkByka8StjAX/bIqXPGEFJ
	T0Dh33lyhHjjeyJx+LrSRDCJwoHYxSTROGdM00ZhS3hlVOsqWNkV
X-Google-Smtp-Source: AGHT+IFIs2ClvA5uqdoUUQV8py+fxQj/bTtc9+w7fRabD5c/3e7xc58JD5kF5IArgwojNKILS0u90Q==
X-Received: by 2002:a17:906:c10d:b0:a99:4879:ec2d with SMTP id a640c23a62f3a-a99b9307195mr725982566b.5.1728840489280;
        Sun, 13 Oct 2024 10:28:09 -0700 (PDT)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99dfb3539fsm259417066b.134.2024.10.13.10.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 10:28:08 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Jens Frederich <jfrederich@gmail.com>,
	Jon Nettleton <jon.nettleton@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>,
	u.kleine-koenig@baylibre.com,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Harry Wentland <harry.wentland@amd.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jani Nikula <jani.nikula@intel.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Wolfram Sang <wsa@kernel.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Stephen Kitt <steve@sk2.org>,
	Jing Xiangfeng <jingxiangfeng@huawei.com>,
	Daniel Drake <dsd@laptop.org>
Subject: [PATCH v2] staging: olpc_dcon: Remove driver marked as broken since 2022
Date: Sun, 13 Oct 2024 19:27:50 +0200
Message-ID: <20241013172759.7524-1-philipp.g.hortmann@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Andres Salomon contributed this driver in 2010.

The following reasons lead to the removal:
- This driver generates maintenance workload
- Kconfig still depends on BROKEN since 2022.

Link: https://lore.kernel.org/all/Yqw4DynMEtAcZVim@kroah.com/
Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
Changes in v2: non, just had an issue with email addresses

Artifacts of olpc_dcon in MAINTAINERS are removed with this patch.
Removed artifacts in Makefile and Kconfig.
---
---
 MAINTAINERS                                  |   7 -
 drivers/staging/Kconfig                      |   2 -
 drivers/staging/Makefile                     |   1 -
 drivers/staging/olpc_dcon/Kconfig            |  17 -
 drivers/staging/olpc_dcon/Makefile           |   5 -
 drivers/staging/olpc_dcon/TODO               |  15 -
 drivers/staging/olpc_dcon/olpc_dcon.c        | 807 -------------------
 drivers/staging/olpc_dcon/olpc_dcon.h        | 112 ---
 drivers/staging/olpc_dcon/olpc_dcon_xo_1.c   | 201 -----
 drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c | 204 -----
 10 files changed, 1371 deletions(-)
 delete mode 100644 drivers/staging/olpc_dcon/Kconfig
 delete mode 100644 drivers/staging/olpc_dcon/Makefile
 delete mode 100644 drivers/staging/olpc_dcon/TODO
 delete mode 100644 drivers/staging/olpc_dcon/olpc_dcon.c
 delete mode 100644 drivers/staging/olpc_dcon/olpc_dcon.h
 delete mode 100644 drivers/staging/olpc_dcon/olpc_dcon_xo_1.c
 delete mode 100644 drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 89e71b6fb431..4300175d3ee6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21955,13 +21955,6 @@ L:	linux-tegra@vger.kernel.org
 S:	Maintained
 F:	drivers/staging/nvec/
 
-STAGING - OLPC SECONDARY DISPLAY CONTROLLER (DCON)
-M:	Jens Frederich <jfrederich@gmail.com>
-M:	Jon Nettleton <jon.nettleton@gmail.com>
-S:	Maintained
-W:	http://wiki.laptop.org/go/DCON
-F:	drivers/staging/olpc_dcon/
-
 STAGING - REALTEK RTL8712U DRIVERS
 M:	Florian Schilhabel <florian.c.schilhabel@googlemail.com>.
 S:	Odd Fixes
diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index b7f089e071cc..1f9783df641c 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -24,8 +24,6 @@ menuconfig STAGING
 
 if STAGING
 
-source "drivers/staging/olpc_dcon/Kconfig"
-
 source "drivers/staging/rtl8723bs/Kconfig"
 
 source "drivers/staging/rtl8712/Kconfig"
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 40dea97d2090..d25e352d32bd 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -2,7 +2,6 @@
 # Makefile for staging directory
 
 obj-y				+= media/
-obj-$(CONFIG_FB_OLPC_DCON)	+= olpc_dcon/
 obj-$(CONFIG_RTL8723BS)		+= rtl8723bs/
 obj-$(CONFIG_R8712U)		+= rtl8712/
 obj-$(CONFIG_OCTEON_ETHERNET)	+= octeon/
diff --git a/drivers/staging/olpc_dcon/Kconfig b/drivers/staging/olpc_dcon/Kconfig
deleted file mode 100644
index d0ba34cc32f7..000000000000
--- a/drivers/staging/olpc_dcon/Kconfig
+++ /dev/null
@@ -1,17 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-config FB_OLPC_DCON
-	tristate "One Laptop Per Child Display CONtroller support"
-	depends on OLPC && FB && BROKEN
-	depends on I2C
-	depends on GPIO_CS5535 && ACPI
-	select BACKLIGHT_CLASS_DEVICE
-	help
-	  In order to support very low power operation, the XO laptop uses a
-	  secondary Display CONtroller, or DCON.  This secondary controller
-	  is present in the video pipeline between the primary display
-	  controller (integrate into the processor or chipset) and the LCD
-	  panel.  It allows the main processor/display controller to be
-	  completely powered off while still retaining an image on the display.
-	  This controller is only available on OLPC platforms.  Unless you have
-	  one of these platforms, you will want to say 'N'.
-
diff --git a/drivers/staging/olpc_dcon/Makefile b/drivers/staging/olpc_dcon/Makefile
deleted file mode 100644
index 734b2ce26066..000000000000
--- a/drivers/staging/olpc_dcon/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-olpc-dcon-objs += olpc_dcon.o olpc_dcon_xo_1.o olpc_dcon_xo_1_5.o
-obj-$(CONFIG_FB_OLPC_DCON)	+= olpc-dcon.o
-
-
diff --git a/drivers/staging/olpc_dcon/TODO b/drivers/staging/olpc_dcon/TODO
deleted file mode 100644
index 7c263358b44a..000000000000
--- a/drivers/staging/olpc_dcon/TODO
+++ /dev/null
@@ -1,15 +0,0 @@
-TODO:
-	- complete rewrite:
-	  1. The underlying fbdev drivers need to be converted into drm kernel
-	     modesetting drivers.
-	  2. The dcon low-power display mode can then be integrated using the
-	     drm damage tracking and self-refresh helpers.
-	  This bolted-on self-refresh support that digs around in fbdev
-	  internals, but isn't properly integrated, is not the correct solution.
-	- see if vx855 gpio API can be made similar enough to cs5535 so we can
-	  share more code
-
-Please send patches to Greg Kroah-Hartman <greg@kroah.com> and
-copy:
-	Daniel Drake <dsd@laptop.org>
-	Jens Frederich <jfrederich@gmail.com>
diff --git a/drivers/staging/olpc_dcon/olpc_dcon.c b/drivers/staging/olpc_dcon/olpc_dcon.c
deleted file mode 100644
index 75809f9fa108..000000000000
--- a/drivers/staging/olpc_dcon/olpc_dcon.c
+++ /dev/null
@@ -1,807 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Mainly by David Woodhouse, somewhat modified by Jordan Crouse
- *
- * Copyright © 2006-2007  Red Hat, Inc.
- * Copyright © 2006-2007  Advanced Micro Devices, Inc.
- * Copyright © 2009       VIA Technology, Inc.
- * Copyright (c) 2010-2011  Andres Salomon <dilinger@queued.net>
- */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/kernel.h>
-#include <linux/fb.h>
-#include <linux/console.h>
-#include <linux/i2c.h>
-#include <linux/platform_device.h>
-#include <linux/interrupt.h>
-#include <linux/delay.h>
-#include <linux/module.h>
-#include <linux/backlight.h>
-#include <linux/device.h>
-#include <linux/uaccess.h>
-#include <linux/ctype.h>
-#include <linux/panic_notifier.h>
-#include <linux/reboot.h>
-#include <linux/olpc-ec.h>
-#include <asm/tsc.h>
-#include <asm/olpc.h>
-
-#include "olpc_dcon.h"
-
-/* Module definitions */
-
-static ushort resumeline = 898;
-module_param(resumeline, ushort, 0444);
-
-static struct dcon_platform_data *pdata;
-
-/* I2C structures */
-
-/* Platform devices */
-static struct platform_device *dcon_device;
-
-static unsigned short normal_i2c[] = { 0x0d, I2C_CLIENT_END };
-
-static s32 dcon_write(struct dcon_priv *dcon, u8 reg, u16 val)
-{
-	return i2c_smbus_write_word_data(dcon->client, reg, val);
-}
-
-static s32 dcon_read(struct dcon_priv *dcon, u8 reg)
-{
-	return i2c_smbus_read_word_data(dcon->client, reg);
-}
-
-/* ===== API functions - these are called by a variety of users ==== */
-
-static int dcon_hw_init(struct dcon_priv *dcon, int is_init)
-{
-	u16 ver;
-	int rc = 0;
-
-	ver = dcon_read(dcon, DCON_REG_ID);
-	if ((ver >> 8) != 0xDC) {
-		pr_err("DCON ID not 0xDCxx: 0x%04x instead.\n", ver);
-		rc = -ENXIO;
-		goto err;
-	}
-
-	if (is_init) {
-		pr_info("Discovered DCON version %x\n", ver & 0xFF);
-		rc = pdata->init(dcon);
-		if (rc != 0) {
-			pr_err("Unable to init.\n");
-			goto err;
-		}
-	}
-
-	if (ver < 0xdc02) {
-		dev_err(&dcon->client->dev,
-			"DCON v1 is unsupported, giving up..\n");
-		rc = -ENODEV;
-		goto err;
-	}
-
-	/* SDRAM setup/hold time */
-	dcon_write(dcon, 0x3a, 0xc040);
-	dcon_write(dcon, DCON_REG_MEM_OPT_A, 0x0000);  /* clear option bits */
-	dcon_write(dcon, DCON_REG_MEM_OPT_A,
-		   MEM_DLL_CLOCK_DELAY | MEM_POWER_DOWN);
-	dcon_write(dcon, DCON_REG_MEM_OPT_B, MEM_SOFT_RESET);
-
-	/* Colour swizzle, AA, no passthrough, backlight */
-	if (is_init) {
-		dcon->disp_mode = MODE_PASSTHRU | MODE_BL_ENABLE |
-				MODE_CSWIZZLE | MODE_COL_AA;
-	}
-	dcon_write(dcon, DCON_REG_MODE, dcon->disp_mode);
-
-	/* Set the scanline to interrupt on during resume */
-	dcon_write(dcon, DCON_REG_SCAN_INT, resumeline);
-
-err:
-	return rc;
-}
-
-/*
- * The smbus doesn't always come back due to what is believed to be
- * hardware (power rail) bugs.  For older models where this is known to
- * occur, our solution is to attempt to wait for the bus to stabilize;
- * if it doesn't happen, cut power to the dcon, repower it, and wait
- * for the bus to stabilize.  Rinse, repeat until we have a working
- * smbus.  For newer models, we simply BUG(); we want to know if this
- * still happens despite the power fixes that have been made!
- */
-static int dcon_bus_stabilize(struct dcon_priv *dcon, int is_powered_down)
-{
-	unsigned long timeout;
-	u8 pm;
-	int x;
-
-power_up:
-	if (is_powered_down) {
-		pm = 1;
-		x = olpc_ec_cmd(EC_DCON_POWER_MODE, &pm, 1, NULL, 0);
-		if (x) {
-			pr_warn("unable to force dcon to power up: %d!\n", x);
-			return x;
-		}
-		usleep_range(10000, 11000);  /* we'll be conservative */
-	}
-
-	pdata->bus_stabilize_wiggle();
-
-	for (x = -1, timeout = 50; timeout && x < 0; timeout--) {
-		usleep_range(1000, 1100);
-		x = dcon_read(dcon, DCON_REG_ID);
-	}
-	if (x < 0) {
-		pr_err("unable to stabilize dcon's smbus, reasserting power and praying.\n");
-		BUG_ON(olpc_board_at_least(olpc_board(0xc2)));
-		pm = 0;
-		olpc_ec_cmd(EC_DCON_POWER_MODE, &pm, 1, NULL, 0);
-		msleep(100);
-		is_powered_down = 1;
-		goto power_up;	/* argh, stupid hardware.. */
-	}
-
-	if (is_powered_down)
-		return dcon_hw_init(dcon, 0);
-	return 0;
-}
-
-static void dcon_set_backlight(struct dcon_priv *dcon, u8 level)
-{
-	dcon->bl_val = level;
-	dcon_write(dcon, DCON_REG_BRIGHT, dcon->bl_val);
-
-	/* Purposely turn off the backlight when we go to level 0 */
-	if (dcon->bl_val == 0) {
-		dcon->disp_mode &= ~MODE_BL_ENABLE;
-		dcon_write(dcon, DCON_REG_MODE, dcon->disp_mode);
-	} else if (!(dcon->disp_mode & MODE_BL_ENABLE)) {
-		dcon->disp_mode |= MODE_BL_ENABLE;
-		dcon_write(dcon, DCON_REG_MODE, dcon->disp_mode);
-	}
-}
-
-/* Set the output type to either color or mono */
-static int dcon_set_mono_mode(struct dcon_priv *dcon, bool enable_mono)
-{
-	if (dcon->mono == enable_mono)
-		return 0;
-
-	dcon->mono = enable_mono;
-
-	if (enable_mono) {
-		dcon->disp_mode &= ~(MODE_CSWIZZLE | MODE_COL_AA);
-		dcon->disp_mode |= MODE_MONO_LUMA;
-	} else {
-		dcon->disp_mode &= ~(MODE_MONO_LUMA);
-		dcon->disp_mode |= MODE_CSWIZZLE | MODE_COL_AA;
-	}
-
-	dcon_write(dcon, DCON_REG_MODE, dcon->disp_mode);
-	return 0;
-}
-
-/* For now, this will be really stupid - we need to address how
- * DCONLOAD works in a sleep and account for it accordingly
- */
-
-static void dcon_sleep(struct dcon_priv *dcon, bool sleep)
-{
-	int x;
-
-	/* Turn off the backlight and put the DCON to sleep */
-
-	if (dcon->asleep == sleep)
-		return;
-
-	if (!olpc_board_at_least(olpc_board(0xc2)))
-		return;
-
-	if (sleep) {
-		u8 pm = 0;
-
-		x = olpc_ec_cmd(EC_DCON_POWER_MODE, &pm, 1, NULL, 0);
-		if (x)
-			pr_warn("unable to force dcon to power down: %d!\n", x);
-		else
-			dcon->asleep = sleep;
-	} else {
-		/* Only re-enable the backlight if the backlight value is set */
-		if (dcon->bl_val != 0)
-			dcon->disp_mode |= MODE_BL_ENABLE;
-		x = dcon_bus_stabilize(dcon, 1);
-		if (x)
-			pr_warn("unable to reinit dcon hardware: %d!\n", x);
-		else
-			dcon->asleep = sleep;
-
-		/* Restore backlight */
-		dcon_set_backlight(dcon, dcon->bl_val);
-	}
-
-	/* We should turn off some stuff in the framebuffer - but what? */
-}
-
-/* the DCON seems to get confused if we change DCONLOAD too
- * frequently -- i.e., approximately faster than frame time.
- * normally we don't change it this fast, so in general we won't
- * delay here.
- */
-static void dcon_load_holdoff(struct dcon_priv *dcon)
-{
-	ktime_t delta_t, now;
-
-	while (1) {
-		now = ktime_get();
-		delta_t = ktime_sub(now, dcon->load_time);
-		if (ktime_to_ns(delta_t) > NSEC_PER_MSEC * 20)
-			break;
-		mdelay(4);
-	}
-}
-
-static bool dcon_blank_fb(struct dcon_priv *dcon, bool blank)
-{
-	int err;
-
-	console_lock();
-	lock_fb_info(dcon->fbinfo);
-
-	dcon->ignore_fb_events = true;
-	err = fb_blank(dcon->fbinfo,
-		       blank ? FB_BLANK_POWERDOWN : FB_BLANK_UNBLANK);
-	dcon->ignore_fb_events = false;
-	unlock_fb_info(dcon->fbinfo);
-	console_unlock();
-
-	if (err) {
-		dev_err(&dcon->client->dev, "couldn't %sblank framebuffer\n",
-			blank ? "" : "un");
-		return false;
-	}
-	return true;
-}
-
-/* Set the source of the display (CPU or DCON) */
-static void dcon_source_switch(struct work_struct *work)
-{
-	struct dcon_priv *dcon = container_of(work, struct dcon_priv,
-			switch_source);
-	int source = dcon->pending_src;
-
-	if (dcon->curr_src == source)
-		return;
-
-	dcon_load_holdoff(dcon);
-
-	dcon->switched = false;
-
-	switch (source) {
-	case DCON_SOURCE_CPU:
-		pr_info("%s to CPU\n", __func__);
-		/* Enable the scanline interrupt bit */
-		if (dcon_write(dcon, DCON_REG_MODE,
-			       dcon->disp_mode | MODE_SCAN_INT))
-			pr_err("couldn't enable scanline interrupt!\n");
-		else
-			/* Wait up to one second for the scanline interrupt */
-			wait_event_timeout(dcon->waitq, dcon->switched, HZ);
-
-		if (!dcon->switched)
-			pr_err("Timeout entering CPU mode; expect a screen glitch.\n");
-
-		/* Turn off the scanline interrupt */
-		if (dcon_write(dcon, DCON_REG_MODE, dcon->disp_mode))
-			pr_err("couldn't disable scanline interrupt!\n");
-
-		/*
-		 * Ideally we'd like to disable interrupts here so that the
-		 * fb unblanking and DCON turn on happen at a known time value;
-		 * however, we can't do that right now with fb_blank
-		 * messing with semaphores.
-		 *
-		 * For now, we just hope..
-		 */
-		if (!dcon_blank_fb(dcon, false)) {
-			pr_err("Failed to enter CPU mode\n");
-			dcon->pending_src = DCON_SOURCE_DCON;
-			return;
-		}
-
-		/* And turn off the DCON */
-		pdata->set_dconload(1);
-		dcon->load_time = ktime_get();
-
-		pr_info("The CPU has control\n");
-		break;
-	case DCON_SOURCE_DCON:
-	{
-		ktime_t delta_t;
-
-		pr_info("%s to DCON\n", __func__);
-
-		/* Clear DCONLOAD - this implies that the DCON is in control */
-		pdata->set_dconload(0);
-		dcon->load_time = ktime_get();
-
-		wait_event_timeout(dcon->waitq, dcon->switched, HZ / 2);
-
-		if (!dcon->switched) {
-			pr_err("Timeout entering DCON mode; expect a screen glitch.\n");
-		} else {
-			/* sometimes the DCON doesn't follow its own rules,
-			 * and doesn't wait for two vsync pulses before
-			 * ack'ing the frame load with an IRQ.  the result
-			 * is that the display shows the *previously*
-			 * loaded frame.  we can detect this by looking at
-			 * the time between asserting DCONLOAD and the IRQ --
-			 * if it's less than 20msec, then the DCON couldn't
-			 * have seen two VSYNC pulses.  in that case we
-			 * deassert and reassert, and hope for the best.
-			 * see http://dev.laptop.org/ticket/9664
-			 */
-			delta_t = ktime_sub(dcon->irq_time, dcon->load_time);
-			if (dcon->switched && ktime_to_ns(delta_t)
-			    < NSEC_PER_MSEC * 20) {
-				pr_err("missed loading, retrying\n");
-				pdata->set_dconload(1);
-				mdelay(41);
-				pdata->set_dconload(0);
-				dcon->load_time = ktime_get();
-				mdelay(41);
-			}
-		}
-
-		dcon_blank_fb(dcon, true);
-		pr_info("The DCON has control\n");
-		break;
-	}
-	default:
-		BUG();
-	}
-
-	dcon->curr_src = source;
-}
-
-static void dcon_set_source(struct dcon_priv *dcon, int arg)
-{
-	if (dcon->pending_src == arg)
-		return;
-
-	dcon->pending_src = arg;
-
-	if (dcon->curr_src != arg)
-		schedule_work(&dcon->switch_source);
-}
-
-static void dcon_set_source_sync(struct dcon_priv *dcon, int arg)
-{
-	dcon_set_source(dcon, arg);
-	flush_work(&dcon->switch_source);
-}
-
-static ssize_t dcon_mode_show(struct device *dev,
-			      struct device_attribute *attr,
-			      char *buf)
-{
-	struct dcon_priv *dcon = dev_get_drvdata(dev);
-
-	return sprintf(buf, "%4.4X\n", dcon->disp_mode);
-}
-
-static ssize_t dcon_sleep_show(struct device *dev,
-			       struct device_attribute *attr,
-			       char *buf)
-{
-	struct dcon_priv *dcon = dev_get_drvdata(dev);
-
-	return sprintf(buf, "%d\n", dcon->asleep);
-}
-
-static ssize_t dcon_freeze_show(struct device *dev,
-				struct device_attribute *attr,
-				char *buf)
-{
-	struct dcon_priv *dcon = dev_get_drvdata(dev);
-
-	return sprintf(buf, "%d\n", dcon->curr_src == DCON_SOURCE_DCON ? 1 : 0);
-}
-
-static ssize_t dcon_mono_show(struct device *dev,
-			      struct device_attribute *attr,
-			      char *buf)
-{
-	struct dcon_priv *dcon = dev_get_drvdata(dev);
-
-	return sprintf(buf, "%d\n", dcon->mono);
-}
-
-static ssize_t dcon_resumeline_show(struct device *dev,
-				    struct device_attribute *attr,
-				    char *buf)
-{
-	return sprintf(buf, "%d\n", resumeline);
-}
-
-static ssize_t dcon_mono_store(struct device *dev,
-			       struct device_attribute *attr,
-			       const char *buf, size_t count)
-{
-	unsigned long enable_mono;
-	int rc;
-
-	rc = kstrtoul(buf, 10, &enable_mono);
-	if (rc)
-		return rc;
-
-	dcon_set_mono_mode(dev_get_drvdata(dev), enable_mono ? true : false);
-
-	return count;
-}
-
-static ssize_t dcon_freeze_store(struct device *dev,
-				 struct device_attribute *attr,
-				 const char *buf, size_t count)
-{
-	struct dcon_priv *dcon = dev_get_drvdata(dev);
-	unsigned long output;
-	int ret;
-
-	ret = kstrtoul(buf, 10, &output);
-	if (ret)
-		return ret;
-
-	switch (output) {
-	case 0:
-		dcon_set_source(dcon, DCON_SOURCE_CPU);
-		break;
-	case 1:
-		dcon_set_source_sync(dcon, DCON_SOURCE_DCON);
-		break;
-	case 2:  /* normally unused */
-		dcon_set_source(dcon, DCON_SOURCE_DCON);
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return count;
-}
-
-static ssize_t dcon_resumeline_store(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf, size_t count)
-{
-	unsigned short rl;
-	int rc;
-
-	rc = kstrtou16(buf, 10, &rl);
-	if (rc)
-		return rc;
-
-	resumeline = rl;
-	dcon_write(dev_get_drvdata(dev), DCON_REG_SCAN_INT, resumeline);
-
-	return count;
-}
-
-static ssize_t dcon_sleep_store(struct device *dev,
-				struct device_attribute *attr,
-				const char *buf, size_t count)
-{
-	unsigned long output;
-	int ret;
-
-	ret = kstrtoul(buf, 10, &output);
-	if (ret)
-		return ret;
-
-	dcon_sleep(dev_get_drvdata(dev), output ? true : false);
-	return count;
-}
-
-static struct device_attribute dcon_device_files[] = {
-	__ATTR(mode, 0444, dcon_mode_show, NULL),
-	__ATTR(sleep, 0644, dcon_sleep_show, dcon_sleep_store),
-	__ATTR(freeze, 0644, dcon_freeze_show, dcon_freeze_store),
-	__ATTR(monochrome, 0644, dcon_mono_show, dcon_mono_store),
-	__ATTR(resumeline, 0644, dcon_resumeline_show, dcon_resumeline_store),
-};
-
-static int dcon_bl_update(struct backlight_device *dev)
-{
-	struct dcon_priv *dcon = bl_get_data(dev);
-	u8 level = backlight_get_brightness(dev) & 0x0F;
-
-	if (level != dcon->bl_val)
-		dcon_set_backlight(dcon, level);
-
-	/* power down the DCON when the screen is blanked */
-	if (!dcon->ignore_fb_events)
-		dcon_sleep(dcon, !!(dev->props.state & BL_CORE_FBBLANK));
-
-	return 0;
-}
-
-static int dcon_bl_get(struct backlight_device *dev)
-{
-	struct dcon_priv *dcon = bl_get_data(dev);
-
-	return dcon->bl_val;
-}
-
-static const struct backlight_ops dcon_bl_ops = {
-	.update_status = dcon_bl_update,
-	.get_brightness = dcon_bl_get,
-};
-
-static struct backlight_properties dcon_bl_props = {
-	.max_brightness = 15,
-	.type = BACKLIGHT_RAW,
-	.power = BACKLIGHT_POWER_ON,
-};
-
-static int dcon_reboot_notify(struct notifier_block *nb,
-			      unsigned long foo, void *bar)
-{
-	struct dcon_priv *dcon = container_of(nb, struct dcon_priv, reboot_nb);
-
-	if (!dcon || !dcon->client)
-		return NOTIFY_DONE;
-
-	/* Turn off the DCON. Entirely. */
-	dcon_write(dcon, DCON_REG_MODE, 0x39);
-	dcon_write(dcon, DCON_REG_MODE, 0x32);
-	return NOTIFY_DONE;
-}
-
-static int unfreeze_on_panic(struct notifier_block *nb,
-			     unsigned long e, void *p)
-{
-	pdata->set_dconload(1);
-	return NOTIFY_DONE;
-}
-
-static struct notifier_block dcon_panic_nb = {
-	.notifier_call = unfreeze_on_panic,
-};
-
-static int dcon_detect(struct i2c_client *client, struct i2c_board_info *info)
-{
-	strscpy(info->type, "olpc_dcon", I2C_NAME_SIZE);
-
-	return 0;
-}
-
-static int dcon_probe(struct i2c_client *client)
-{
-	struct dcon_priv *dcon;
-	int rc, i, j;
-
-	if (!pdata)
-		return -ENXIO;
-
-	dcon = kzalloc(sizeof(*dcon), GFP_KERNEL);
-	if (!dcon)
-		return -ENOMEM;
-
-	dcon->client = client;
-	init_waitqueue_head(&dcon->waitq);
-	INIT_WORK(&dcon->switch_source, dcon_source_switch);
-	dcon->reboot_nb.notifier_call = dcon_reboot_notify;
-	dcon->reboot_nb.priority = -1;
-
-	i2c_set_clientdata(client, dcon);
-
-	if (num_registered_fb < 1) {
-		dev_err(&client->dev, "DCON driver requires a registered fb\n");
-		rc = -EIO;
-		goto einit;
-	}
-	dcon->fbinfo = registered_fb[0];
-
-	rc = dcon_hw_init(dcon, 1);
-	if (rc)
-		goto einit;
-
-	/* Add the DCON device */
-
-	dcon_device = platform_device_alloc("dcon", -1);
-
-	if (!dcon_device) {
-		pr_err("Unable to create the DCON device\n");
-		rc = -ENOMEM;
-		goto eirq;
-	}
-	rc = platform_device_add(dcon_device);
-	platform_set_drvdata(dcon_device, dcon);
-
-	if (rc) {
-		pr_err("Unable to add the DCON device\n");
-		goto edev;
-	}
-
-	for (i = 0; i < ARRAY_SIZE(dcon_device_files); i++) {
-		rc = device_create_file(&dcon_device->dev,
-					&dcon_device_files[i]);
-		if (rc) {
-			dev_err(&dcon_device->dev, "Cannot create sysfs file\n");
-			goto ecreate;
-		}
-	}
-
-	dcon->bl_val = dcon_read(dcon, DCON_REG_BRIGHT) & 0x0F;
-
-	/* Add the backlight device for the DCON */
-	dcon_bl_props.brightness = dcon->bl_val;
-	dcon->bl_dev = backlight_device_register("dcon-bl", &dcon_device->dev,
-						 dcon, &dcon_bl_ops,
-						 &dcon_bl_props);
-	if (IS_ERR(dcon->bl_dev)) {
-		dev_err(&client->dev, "cannot register backlight dev (%ld)\n",
-			PTR_ERR(dcon->bl_dev));
-		dcon->bl_dev = NULL;
-	}
-
-	register_reboot_notifier(&dcon->reboot_nb);
-	atomic_notifier_chain_register(&panic_notifier_list, &dcon_panic_nb);
-
-	return 0;
-
- ecreate:
-	for (j = 0; j < i; j++)
-		device_remove_file(&dcon_device->dev, &dcon_device_files[j]);
-	platform_device_del(dcon_device);
- edev:
-	platform_device_put(dcon_device);
-	dcon_device = NULL;
- eirq:
-	free_irq(DCON_IRQ, dcon);
- einit:
-	kfree(dcon);
-	return rc;
-}
-
-static void dcon_remove(struct i2c_client *client)
-{
-	struct dcon_priv *dcon = i2c_get_clientdata(client);
-
-	unregister_reboot_notifier(&dcon->reboot_nb);
-	atomic_notifier_chain_unregister(&panic_notifier_list, &dcon_panic_nb);
-
-	free_irq(DCON_IRQ, dcon);
-
-	backlight_device_unregister(dcon->bl_dev);
-
-	if (dcon_device)
-		platform_device_unregister(dcon_device);
-	cancel_work_sync(&dcon->switch_source);
-
-	kfree(dcon);
-}
-
-#ifdef CONFIG_PM
-static int dcon_suspend(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct dcon_priv *dcon = i2c_get_clientdata(client);
-
-	if (!dcon->asleep) {
-		/* Set up the DCON to have the source */
-		dcon_set_source_sync(dcon, DCON_SOURCE_DCON);
-	}
-
-	return 0;
-}
-
-static int dcon_resume(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct dcon_priv *dcon = i2c_get_clientdata(client);
-
-	if (!dcon->asleep) {
-		dcon_bus_stabilize(dcon, 0);
-		dcon_set_source(dcon, DCON_SOURCE_CPU);
-	}
-
-	return 0;
-}
-
-#else
-
-#define dcon_suspend NULL
-#define dcon_resume NULL
-
-#endif /* CONFIG_PM */
-
-irqreturn_t dcon_interrupt(int irq, void *id)
-{
-	struct dcon_priv *dcon = id;
-	u8 status;
-
-	if (pdata->read_status(&status))
-		return IRQ_NONE;
-
-	switch (status & 3) {
-	case 3:
-		pr_debug("DCONLOAD_MISSED interrupt\n");
-		break;
-
-	case 2:	/* switch to DCON mode */
-	case 1: /* switch to CPU mode */
-		dcon->switched = true;
-		dcon->irq_time = ktime_get();
-		wake_up(&dcon->waitq);
-		break;
-
-	case 0:
-		/* workaround resume case:  the DCON (on 1.5) doesn't
-		 * ever assert status 0x01 when switching to CPU mode
-		 * during resume.  this is because DCONLOAD is de-asserted
-		 * _immediately_ upon exiting S3, so the actual release
-		 * of the DCON happened long before this point.
-		 * see http://dev.laptop.org/ticket/9869
-		 */
-		if (dcon->curr_src != dcon->pending_src && !dcon->switched) {
-			dcon->switched = true;
-			dcon->irq_time = ktime_get();
-			wake_up(&dcon->waitq);
-			pr_debug("switching w/ status 0/0\n");
-		} else {
-			pr_debug("scanline interrupt w/CPU\n");
-		}
-	}
-
-	return IRQ_HANDLED;
-}
-
-static const struct dev_pm_ops dcon_pm_ops = {
-	.suspend = dcon_suspend,
-	.resume = dcon_resume,
-};
-
-static const struct i2c_device_id dcon_idtable[] = {
-	{ "olpc_dcon" },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, dcon_idtable);
-
-static struct i2c_driver dcon_driver = {
-	.driver = {
-		.name	= "olpc_dcon",
-		.pm = &dcon_pm_ops,
-	},
-	.class = I2C_CLASS_HWMON,
-	.id_table = dcon_idtable,
-	.probe = dcon_probe,
-	.remove = dcon_remove,
-	.detect = dcon_detect,
-	.address_list = normal_i2c,
-};
-
-static int __init olpc_dcon_init(void)
-{
-	/* XO-1.5 */
-	if (olpc_board_at_least(olpc_board(0xd0)))
-		pdata = &dcon_pdata_xo_1_5;
-	else
-		pdata = &dcon_pdata_xo_1;
-
-	return i2c_add_driver(&dcon_driver);
-}
-
-static void __exit olpc_dcon_exit(void)
-{
-	i2c_del_driver(&dcon_driver);
-}
-
-module_init(olpc_dcon_init);
-module_exit(olpc_dcon_exit);
-
-MODULE_LICENSE("GPL");
diff --git a/drivers/staging/olpc_dcon/olpc_dcon.h b/drivers/staging/olpc_dcon/olpc_dcon.h
deleted file mode 100644
index 41bd1360b56e..000000000000
--- a/drivers/staging/olpc_dcon/olpc_dcon.h
+++ /dev/null
@@ -1,112 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef OLPC_DCON_H_
-#define OLPC_DCON_H_
-
-#include <linux/notifier.h>
-#include <linux/workqueue.h>
-
-/* DCON registers */
-
-#define DCON_REG_ID		 0
-#define DCON_REG_MODE		 1
-
-#define MODE_PASSTHRU	BIT(0)
-#define MODE_SLEEP	BIT(1)
-#define MODE_SLEEP_AUTO	BIT(2)
-#define MODE_BL_ENABLE	BIT(3)
-#define MODE_BLANK	BIT(4)
-#define MODE_CSWIZZLE	BIT(5)
-#define MODE_COL_AA	BIT(6)
-#define MODE_MONO_LUMA	BIT(7)
-#define MODE_SCAN_INT	BIT(8)
-#define MODE_CLOCKDIV	BIT(9)
-#define MODE_DEBUG	BIT(14)
-#define MODE_SELFTEST	BIT(15)
-
-#define DCON_REG_HRES		0x2
-#define DCON_REG_HTOTAL		0x3
-#define DCON_REG_HSYNC_WIDTH	0x4
-#define DCON_REG_VRES		0x5
-#define DCON_REG_VTOTAL		0x6
-#define DCON_REG_VSYNC_WIDTH	0x7
-#define DCON_REG_TIMEOUT	0x8
-#define DCON_REG_SCAN_INT	0x9
-#define DCON_REG_BRIGHT		0xa
-#define DCON_REG_MEM_OPT_A	0x41
-#define DCON_REG_MEM_OPT_B	0x42
-
-/* Load Delay Locked Loop (DLL) settings for clock delay */
-#define MEM_DLL_CLOCK_DELAY	BIT(0)
-/* Memory controller power down function */
-#define MEM_POWER_DOWN		BIT(8)
-/* Memory controller software reset */
-#define MEM_SOFT_RESET		BIT(0)
-
-/* Status values */
-
-#define DCONSTAT_SCANINT	0
-#define DCONSTAT_SCANINT_DCON	1
-#define DCONSTAT_DISPLAYLOAD	2
-#define DCONSTAT_MISSED		3
-
-/* Source values */
-
-#define DCON_SOURCE_DCON        0
-#define DCON_SOURCE_CPU         1
-
-/* Interrupt */
-#define DCON_IRQ                6
-
-struct dcon_priv {
-	struct i2c_client *client;
-	struct fb_info *fbinfo;
-	struct backlight_device *bl_dev;
-
-	wait_queue_head_t waitq;
-	struct work_struct switch_source;
-	struct notifier_block reboot_nb;
-
-	/* Shadow register for the DCON_REG_MODE register */
-	u8 disp_mode;
-
-	/* The current backlight value - this saves us some smbus traffic */
-	u8 bl_val;
-
-	/* Current source, initialized at probe time */
-	int curr_src;
-
-	/* Desired source */
-	int pending_src;
-
-	/* Variables used during switches */
-	bool switched;
-	ktime_t irq_time;
-	ktime_t load_time;
-
-	/* Current output type; true == mono, false == color */
-	bool mono;
-	bool asleep;
-	/* This get set while controlling fb blank state from the driver */
-	bool ignore_fb_events;
-};
-
-struct dcon_platform_data {
-	int (*init)(struct dcon_priv *dcon);
-	void (*bus_stabilize_wiggle)(void);
-	void (*set_dconload)(int load);
-	int (*read_status)(u8 *status);
-};
-
-struct dcon_gpio {
-	const char *name;
-	unsigned long flags;
-};
-
-#include <linux/interrupt.h>
-
-irqreturn_t dcon_interrupt(int irq, void *id);
-
-extern struct dcon_platform_data dcon_pdata_xo_1;
-extern struct dcon_platform_data dcon_pdata_xo_1_5;
-
-#endif
diff --git a/drivers/staging/olpc_dcon/olpc_dcon_xo_1.c b/drivers/staging/olpc_dcon/olpc_dcon_xo_1.c
deleted file mode 100644
index 02c059897784..000000000000
--- a/drivers/staging/olpc_dcon/olpc_dcon_xo_1.c
+++ /dev/null
@@ -1,201 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Mainly by David Woodhouse, somewhat modified by Jordan Crouse
- *
- * Copyright © 2006-2007  Red Hat, Inc.
- * Copyright © 2006-2007  Advanced Micro Devices, Inc.
- * Copyright © 2009       VIA Technology, Inc.
- * Copyright (c) 2010  Andres Salomon <dilinger@queued.net>
- */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/cs5535.h>
-#include <linux/gpio/consumer.h>
-#include <linux/delay.h>
-#include <linux/i2c.h>
-#include <asm/olpc.h>
-
-#include "olpc_dcon.h"
-
-enum dcon_gpios {
-	OLPC_DCON_STAT0,
-	OLPC_DCON_STAT1,
-	OLPC_DCON_IRQ,
-	OLPC_DCON_LOAD,
-	OLPC_DCON_BLANK,
-};
-
-static const struct dcon_gpio gpios_asis[] = {
-	[OLPC_DCON_STAT0] = { .name = "dcon_stat0", .flags = GPIOD_ASIS },
-	[OLPC_DCON_STAT1] = { .name = "dcon_stat1", .flags = GPIOD_ASIS },
-	[OLPC_DCON_IRQ] = { .name = "dcon_irq", .flags = GPIOD_ASIS },
-	[OLPC_DCON_LOAD] = { .name = "dcon_load", .flags = GPIOD_ASIS },
-	[OLPC_DCON_BLANK] = { .name = "dcon_blank", .flags = GPIOD_ASIS },
-};
-
-static struct gpio_desc *gpios[5];
-
-static int dcon_init_xo_1(struct dcon_priv *dcon)
-{
-	unsigned char lob;
-	int ret, i;
-	const struct dcon_gpio *pin = &gpios_asis[0];
-
-	for (i = 0; i < ARRAY_SIZE(gpios_asis); i++) {
-		gpios[i] = devm_gpiod_get(&dcon->client->dev, pin[i].name,
-					  pin[i].flags);
-		if (IS_ERR(gpios[i])) {
-			ret = PTR_ERR(gpios[i]);
-			pr_err("failed to request %s GPIO: %d\n", pin[i].name,
-			       ret);
-			return ret;
-		}
-	}
-
-	/* Turn off the event enable for GPIO7 just to be safe */
-	cs5535_gpio_clear(OLPC_GPIO_DCON_IRQ, GPIO_EVENTS_ENABLE);
-
-	/*
-	 * Determine the current state by reading the GPIO bit; earlier
-	 * stages of the boot process have established the state.
-	 *
-	 * Note that we read GPIO_OUTPUT_VAL rather than GPIO_READ_BACK here;
-	 * this is because OFW will disable input for the pin and set a value..
-	 * READ_BACK will only contain a valid value if input is enabled and
-	 * then a value is set.  So, future readings of the pin can use
-	 * READ_BACK, but the first one cannot.  Awesome, huh?
-	 */
-	dcon->curr_src = cs5535_gpio_isset(OLPC_GPIO_DCON_LOAD, GPIO_OUTPUT_VAL)
-		? DCON_SOURCE_CPU
-		: DCON_SOURCE_DCON;
-	dcon->pending_src = dcon->curr_src;
-
-	/* Set the directions for the GPIO pins */
-	gpiod_direction_input(gpios[OLPC_DCON_STAT0]);
-	gpiod_direction_input(gpios[OLPC_DCON_STAT1]);
-	gpiod_direction_input(gpios[OLPC_DCON_IRQ]);
-	gpiod_direction_input(gpios[OLPC_DCON_BLANK]);
-	gpiod_direction_output(gpios[OLPC_DCON_LOAD],
-			       dcon->curr_src == DCON_SOURCE_CPU);
-
-	/* Set up the interrupt mappings */
-
-	/* Set the IRQ to pair 2 */
-	cs5535_gpio_setup_event(OLPC_GPIO_DCON_IRQ, 2, 0);
-
-	/* Enable group 2 to trigger the DCON interrupt */
-	cs5535_gpio_set_irq(2, DCON_IRQ);
-
-	/* Select edge level for interrupt (in PIC) */
-	lob = inb(0x4d0);
-	lob &= ~(1 << DCON_IRQ);
-	outb(lob, 0x4d0);
-
-	/* Register the interrupt handler */
-	if (request_irq(DCON_IRQ, &dcon_interrupt, 0, "DCON", dcon)) {
-		pr_err("failed to request DCON's irq\n");
-		return -EIO;
-	}
-
-	/* Clear INV_EN for GPIO7 (DCONIRQ) */
-	cs5535_gpio_clear(OLPC_GPIO_DCON_IRQ, GPIO_INPUT_INVERT);
-
-	/* Enable filter for GPIO12 (DCONBLANK) */
-	cs5535_gpio_set(OLPC_GPIO_DCON_BLANK, GPIO_INPUT_FILTER);
-
-	/* Disable filter for GPIO7 */
-	cs5535_gpio_clear(OLPC_GPIO_DCON_IRQ, GPIO_INPUT_FILTER);
-
-	/* Disable event counter for GPIO7 (DCONIRQ) and GPIO12 (DCONBLANK) */
-	cs5535_gpio_clear(OLPC_GPIO_DCON_IRQ, GPIO_INPUT_EVENT_COUNT);
-	cs5535_gpio_clear(OLPC_GPIO_DCON_BLANK, GPIO_INPUT_EVENT_COUNT);
-
-	/* Add GPIO12 to the Filter Event Pair #7 */
-	cs5535_gpio_set(OLPC_GPIO_DCON_BLANK, GPIO_FE7_SEL);
-
-	/* Turn off negative Edge Enable for GPIO12 */
-	cs5535_gpio_clear(OLPC_GPIO_DCON_BLANK, GPIO_NEGATIVE_EDGE_EN);
-
-	/* Enable negative Edge Enable for GPIO7 */
-	cs5535_gpio_set(OLPC_GPIO_DCON_IRQ, GPIO_NEGATIVE_EDGE_EN);
-
-	/* Zero the filter amount for Filter Event Pair #7 */
-	cs5535_gpio_set(0, GPIO_FLTR7_AMOUNT);
-
-	/* Clear the negative edge status for GPIO7 and GPIO12 */
-	cs5535_gpio_set(OLPC_GPIO_DCON_IRQ, GPIO_NEGATIVE_EDGE_STS);
-	cs5535_gpio_set(OLPC_GPIO_DCON_BLANK, GPIO_NEGATIVE_EDGE_STS);
-
-	/* FIXME:  Clear the positive status as well, just to be sure */
-	cs5535_gpio_set(OLPC_GPIO_DCON_IRQ, GPIO_POSITIVE_EDGE_STS);
-	cs5535_gpio_set(OLPC_GPIO_DCON_BLANK, GPIO_POSITIVE_EDGE_STS);
-
-	/* Enable events for GPIO7 (DCONIRQ) and GPIO12 (DCONBLANK) */
-	cs5535_gpio_set(OLPC_GPIO_DCON_IRQ, GPIO_EVENTS_ENABLE);
-	cs5535_gpio_set(OLPC_GPIO_DCON_BLANK, GPIO_EVENTS_ENABLE);
-
-	return 0;
-}
-
-static void dcon_wiggle_xo_1(void)
-{
-	int x;
-
-	/*
-	 * According to HiMax, when powering the DCON up we should hold
-	 * SMB_DATA high for 8 SMB_CLK cycles.  This will force the DCON
-	 * state machine to reset to a (sane) initial state.  Mitch Bradley
-	 * did some testing and discovered that holding for 16 SMB_CLK cycles
-	 * worked a lot more reliably, so that's what we do here.
-	 *
-	 * According to the cs5536 spec, to set GPIO14 to SMB_CLK we must
-	 * simultaneously set AUX1 IN/OUT to GPIO14; ditto for SMB_DATA and
-	 * GPIO15.
-	 */
-	cs5535_gpio_set(OLPC_GPIO_SMB_CLK, GPIO_OUTPUT_VAL);
-	cs5535_gpio_set(OLPC_GPIO_SMB_DATA, GPIO_OUTPUT_VAL);
-	cs5535_gpio_set(OLPC_GPIO_SMB_CLK, GPIO_OUTPUT_ENABLE);
-	cs5535_gpio_set(OLPC_GPIO_SMB_DATA, GPIO_OUTPUT_ENABLE);
-	cs5535_gpio_clear(OLPC_GPIO_SMB_CLK, GPIO_OUTPUT_AUX1);
-	cs5535_gpio_clear(OLPC_GPIO_SMB_DATA, GPIO_OUTPUT_AUX1);
-	cs5535_gpio_clear(OLPC_GPIO_SMB_CLK, GPIO_OUTPUT_AUX2);
-	cs5535_gpio_clear(OLPC_GPIO_SMB_DATA, GPIO_OUTPUT_AUX2);
-	cs5535_gpio_clear(OLPC_GPIO_SMB_CLK, GPIO_INPUT_AUX1);
-	cs5535_gpio_clear(OLPC_GPIO_SMB_DATA, GPIO_INPUT_AUX1);
-
-	for (x = 0; x < 16; x++) {
-		udelay(5);
-		cs5535_gpio_clear(OLPC_GPIO_SMB_CLK, GPIO_OUTPUT_VAL);
-		udelay(5);
-		cs5535_gpio_set(OLPC_GPIO_SMB_CLK, GPIO_OUTPUT_VAL);
-	}
-	udelay(5);
-	cs5535_gpio_set(OLPC_GPIO_SMB_CLK, GPIO_OUTPUT_AUX1);
-	cs5535_gpio_set(OLPC_GPIO_SMB_DATA, GPIO_OUTPUT_AUX1);
-	cs5535_gpio_set(OLPC_GPIO_SMB_CLK, GPIO_INPUT_AUX1);
-	cs5535_gpio_set(OLPC_GPIO_SMB_DATA, GPIO_INPUT_AUX1);
-}
-
-static void dcon_set_dconload_1(int val)
-{
-	gpiod_set_value(gpios[OLPC_DCON_LOAD], val);
-}
-
-static int dcon_read_status_xo_1(u8 *status)
-{
-	*status = gpiod_get_value(gpios[OLPC_DCON_STAT0]);
-	*status |= gpiod_get_value(gpios[OLPC_DCON_STAT1]) << 1;
-
-	/* Clear the negative edge status for GPIO7 */
-	cs5535_gpio_set(OLPC_GPIO_DCON_IRQ, GPIO_NEGATIVE_EDGE_STS);
-
-	return 0;
-}
-
-struct dcon_platform_data dcon_pdata_xo_1 = {
-	.init = dcon_init_xo_1,
-	.bus_stabilize_wiggle = dcon_wiggle_xo_1,
-	.set_dconload = dcon_set_dconload_1,
-	.read_status = dcon_read_status_xo_1,
-};
diff --git a/drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c b/drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c
deleted file mode 100644
index 52cdcd2a89d6..000000000000
--- a/drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c
+++ /dev/null
@@ -1,204 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) 2009,2010       One Laptop per Child
- */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/acpi.h>
-#include <linux/delay.h>
-#include <linux/i2c.h>
-#include <linux/gpio/consumer.h>
-#include <linux/gpio/machine.h>
-#include <asm/olpc.h>
-
-/* TODO: this eventually belongs in linux/vx855.h */
-#define NR_VX855_GPI    14
-#define NR_VX855_GPO    13
-#define NR_VX855_GPIO   15
-
-#define VX855_GPI(n)    (n)
-#define VX855_GPO(n)    (NR_VX855_GPI + (n))
-#define VX855_GPIO(n)   (NR_VX855_GPI + NR_VX855_GPO + (n))
-
-#include "olpc_dcon.h"
-
-/* Hardware setup on the XO 1.5:
- *	DCONLOAD connects to VX855_GPIO1 (not SMBCK2)
- *	DCONBLANK connects to VX855_GPIO8 (not SSPICLK)  unused in driver
- *	DCONSTAT0 connects to VX855_GPI10 (not SSPISDI)
- *	DCONSTAT1 connects to VX855_GPI11 (not nSSPISS)
- *	DCONIRQ connects to VX855_GPIO12
- *	DCONSMBDATA connects to VX855 graphics CRTSPD
- *	DCONSMBCLK connects to VX855 graphics CRTSPCLK
- */
-
-#define VX855_GENL_PURPOSE_OUTPUT 0x44c /* PMIO_Rx4c-4f */
-#define VX855_GPI_STATUS_CHG 0x450  /* PMIO_Rx50 */
-#define VX855_GPI_SCI_SMI 0x452  /* PMIO_Rx52 */
-#define BIT_GPIO12 0x40
-
-#define PREFIX "OLPC DCON:"
-
-enum dcon_gpios {
-	OLPC_DCON_STAT0,
-	OLPC_DCON_STAT1,
-	OLPC_DCON_LOAD,
-};
-
-struct gpiod_lookup_table gpios_table = {
-	.dev_id = NULL,
-	.table = {
-		GPIO_LOOKUP("VX855 South Bridge", VX855_GPIO(1), "dcon_load",
-			    GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP("VX855 South Bridge", VX855_GPI(10), "dcon_stat0",
-			    GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP("VX855 South Bridge", VX855_GPI(11), "dcon_stat1",
-			    GPIO_ACTIVE_LOW),
-		{ },
-	},
-};
-
-static const struct dcon_gpio gpios_asis[] = {
-	[OLPC_DCON_STAT0] = { .name = "dcon_stat0", .flags = GPIOD_ASIS },
-	[OLPC_DCON_STAT1] = { .name = "dcon_stat1", .flags = GPIOD_ASIS },
-	[OLPC_DCON_LOAD] = { .name = "dcon_load", .flags = GPIOD_ASIS },
-};
-
-static struct gpio_desc *gpios[3];
-
-static void dcon_clear_irq(void)
-{
-	/* irq status will appear in PMIO_Rx50[6] (RW1C) on gpio12 */
-	outb(BIT_GPIO12, VX855_GPI_STATUS_CHG);
-}
-
-static int dcon_was_irq(void)
-{
-	u8 tmp;
-
-	/* irq status will appear in PMIO_Rx50[6] on gpio12 */
-	tmp = inb(VX855_GPI_STATUS_CHG);
-
-	return !!(tmp & BIT_GPIO12);
-}
-
-static int dcon_init_xo_1_5(struct dcon_priv *dcon)
-{
-	unsigned int irq;
-	const struct dcon_gpio *pin = &gpios_asis[0];
-	int i;
-	int ret;
-
-	/* Add GPIO look up table */
-	gpios_table.dev_id = dev_name(&dcon->client->dev);
-	gpiod_add_lookup_table(&gpios_table);
-
-	/* Get GPIO descriptor */
-	for (i = 0; i < ARRAY_SIZE(gpios_asis); i++) {
-		gpios[i] = devm_gpiod_get(&dcon->client->dev, pin[i].name,
-					  pin[i].flags);
-		if (IS_ERR(gpios[i])) {
-			ret = PTR_ERR(gpios[i]);
-			pr_err("failed to request %s GPIO: %d\n", pin[i].name,
-			       ret);
-			return ret;
-		}
-	}
-
-	dcon_clear_irq();
-
-	/* set   PMIO_Rx52[6] to enable SCI/SMI on gpio12 */
-	outb(inb(VX855_GPI_SCI_SMI) | BIT_GPIO12, VX855_GPI_SCI_SMI);
-
-	/* Determine the current state of DCONLOAD, likely set by firmware */
-	/* GPIO1 */
-	dcon->curr_src = (inl(VX855_GENL_PURPOSE_OUTPUT) & 0x1000) ?
-			DCON_SOURCE_CPU : DCON_SOURCE_DCON;
-	dcon->pending_src = dcon->curr_src;
-
-	/* we're sharing the IRQ with ACPI */
-	irq = acpi_gbl_FADT.sci_interrupt;
-	if (request_irq(irq, &dcon_interrupt, IRQF_SHARED, "DCON", dcon)) {
-		pr_err("DCON (IRQ%d) allocation failed\n", irq);
-		return 1;
-	}
-
-	return 0;
-}
-
-static void set_i2c_line(int sda, int scl)
-{
-	unsigned char tmp;
-	unsigned int port = 0x26;
-
-	/* FIXME: This directly accesses the CRT GPIO controller !!! */
-	outb(port, 0x3c4);
-	tmp = inb(0x3c5);
-
-	if (scl)
-		tmp |= 0x20;
-	else
-		tmp &= ~0x20;
-
-	if (sda)
-		tmp |= 0x10;
-	else
-		tmp &= ~0x10;
-
-	tmp |= 0x01;
-
-	outb(port, 0x3c4);
-	outb(tmp, 0x3c5);
-}
-
-static void dcon_wiggle_xo_1_5(void)
-{
-	int x;
-
-	/*
-	 * According to HiMax, when powering the DCON up we should hold
-	 * SMB_DATA high for 8 SMB_CLK cycles.  This will force the DCON
-	 * state machine to reset to a (sane) initial state.  Mitch Bradley
-	 * did some testing and discovered that holding for 16 SMB_CLK cycles
-	 * worked a lot more reliably, so that's what we do here.
-	 */
-	set_i2c_line(1, 1);
-
-	for (x = 0; x < 16; x++) {
-		udelay(5);
-		set_i2c_line(1, 0);
-		udelay(5);
-		set_i2c_line(1, 1);
-	}
-	udelay(5);
-
-	/* set   PMIO_Rx52[6] to enable SCI/SMI on gpio12 */
-	outb(inb(VX855_GPI_SCI_SMI) | BIT_GPIO12, VX855_GPI_SCI_SMI);
-}
-
-static void dcon_set_dconload_xo_1_5(int val)
-{
-	gpiod_set_value(gpios[OLPC_DCON_LOAD], val);
-}
-
-static int dcon_read_status_xo_1_5(u8 *status)
-{
-	if (!dcon_was_irq())
-		return -1;
-
-	/* i believe this is the same as "inb(0x44b) & 3" */
-	*status = gpiod_get_value(gpios[OLPC_DCON_STAT0]);
-	*status |= gpiod_get_value(gpios[OLPC_DCON_STAT1]) << 1;
-
-	dcon_clear_irq();
-
-	return 0;
-}
-
-struct dcon_platform_data dcon_pdata_xo_1_5 = {
-	.init = dcon_init_xo_1_5,
-	.bus_stabilize_wiggle = dcon_wiggle_xo_1_5,
-	.set_dconload = dcon_set_dconload_xo_1_5,
-	.read_status = dcon_read_status_xo_1_5,
-};
-- 
2.43.0


