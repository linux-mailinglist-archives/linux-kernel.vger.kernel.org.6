Return-Path: <linux-kernel+bounces-295491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 600B8959BBB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0806B248E9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10FE16631D;
	Wed, 21 Aug 2024 12:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="mdKykYtk"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DBE1E507
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 12:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724243144; cv=none; b=ZLM2iadjLSVM/r2f2Hufwl+L7F/R8gTlAY/94KsJruRjHnbNolVOO+tIjacCEW7OuemdeGaNCmgrhuRs8kvNsF0xTFiX4fyyN9LidigyHB6CsrAJI/wZrq6N8cxSkrqWzT8+v+IAtfgQbuMZSwq/r/tQB/YUTDcvlQuxC+7EC5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724243144; c=relaxed/simple;
	bh=IuNjvKXxc8195sfjF1M7dyMkYLRReEdhi9cSCYqo5PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ThfMPSDfPELppYpHl9zhl1bGy0Di7T/MBqwq3HGxwNMg6MTsV4j96r9oSlmO5f3qGokPoznrSZDTTm7gA8NobFG5o73i1pJYyzGtKpaskdvECSbxkwojZhM8GHWut6suw3NvKx2JWWngNIxDoRW90CJD1Pv+ymTBJ9Tp+P7yj5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=mdKykYtk; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so51408815e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 05:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1724243140; x=1724847940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iQrxaH5KBXicmydrUIJxyHguplR6xyPZC/0ncboBE2g=;
        b=mdKykYtkOZCsbCm54/SuR7SIiEQlNpkUvy6SwRRZ/ZCh3af0bHtlj2DBX3UN467eYK
         IhbS38tET+XdgGtepcHTGJyExr1R9s3g1aAm/aI6VQTvtZeLaamMpLWGsw74l8MH3VXF
         2Ay/oMnI5Kyz7gphO/1YRn8G1C6E0JMuLu3Xg2jASH7KNt0Wq5GFOqlhZ1HBm0IVXzWG
         hbeiCy3vdRHUkafhYgPHrC2UEhFTmkLgqOeXt5nit9t3N8KMCvoVS9KbqSg+blreFK+E
         Qxvsmw+ScnSkg1dLDZ4Nkokr2hhZ6gDzpN3jlzTuUqyi11md3qavFQ/Ot2sgONJoYL6f
         NaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724243140; x=1724847940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iQrxaH5KBXicmydrUIJxyHguplR6xyPZC/0ncboBE2g=;
        b=lt32u1ybg/KtCs9hMUqZk1XUfEKxMxM8YtPjW2uklZk7fANqJx+R1B5CvdQeiMXsy8
         lVpSrm8+mDBeIQyhdA0zWSNVMstpTYGFr7Tzf0RPBA1+8m7NrYXKhHns6EFZ9rhQDj2N
         q9pU8lqGrBbwQDdWoKIaFrBc5UgQ6hNviBao3o9QDJhie12z/yTsAiu727zyWyU1bcA4
         QsBwntnYYEqBTlmDF9zjK76xNzAmV6tzdJXTSZPcfyOgxlFz1GYn/8jg6caUcAsxJDYb
         DvapNm62/+mH+FZhPcXoUPoFhVM8ybQoCBhhPEm21TKpAtSBneQxBe41NAgR/Kk1UhcS
         2yLw==
X-Gm-Message-State: AOJu0YyOaDXq39ctfHhMA7Yjih8EEuSJJP9a27ILKaAga4kip4jOKipG
	xZmzPUV+jAK1yXvJJF/XdgSyxltKj+wqwekBtYi/O/vcfNkM7ShirhzSM0lHc1k=
X-Google-Smtp-Source: AGHT+IF+DngRbG/MkFlmUkI81Y79IdOW1Bkw3GNZ4jH12LBBRE9JHgmVvPZayZh4m41c6AWUU0XT3w==
X-Received: by 2002:a05:600c:4fd1:b0:426:6f0e:a60 with SMTP id 5b1f17b1804b1-42abd21b97amr16269145e9.17.1724243139621;
        Wed, 21 Aug 2024 05:25:39 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:42a6:b34f:6c18:3851])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abeffe43esm23544075e9.44.2024.08.21.05.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 05:25:39 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH net-next] net: mdio-gpio: remove support for platform data
Date: Wed, 21 Aug 2024 14:25:29 +0200
Message-ID: <20240821122530.20529-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

There are no more board files defining platform data for this driver so
remove the header and drop the support.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 MAINTAINERS                             |  1 -
 drivers/net/mdio/mdio-gpio.c            |  7 -------
 include/linux/platform_data/mdio-gpio.h | 14 --------------
 3 files changed, 22 deletions(-)
 delete mode 100644 include/linux/platform_data/mdio-gpio.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a7cb909ffa1d..146f4eb95e7c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8413,7 +8413,6 @@ F:	include/linux/phy.h
 F:	include/linux/phy_fixed.h
 F:	include/linux/phylib_stubs.h
 F:	include/linux/platform_data/mdio-bcm-unimac.h
-F:	include/linux/platform_data/mdio-gpio.h
 F:	include/trace/events/mdio.h
 F:	include/uapi/linux/mdio.h
 F:	include/uapi/linux/mii.h
diff --git a/drivers/net/mdio/mdio-gpio.c b/drivers/net/mdio/mdio-gpio.c
index 82088741debd..9e194ebfe7d2 100644
--- a/drivers/net/mdio/mdio-gpio.c
+++ b/drivers/net/mdio/mdio-gpio.c
@@ -23,7 +23,6 @@
 #include <linux/mdio-gpio.h>
 #include <linux/module.h>
 #include <linux/of_mdio.h>
-#include <linux/platform_data/mdio-gpio.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
@@ -110,7 +109,6 @@ static struct mii_bus *mdio_gpio_bus_init(struct device *dev,
 					  struct mdio_gpio_info *bitbang,
 					  int bus_id)
 {
-	struct mdio_gpio_platform_data *pdata = dev_get_platdata(dev);
 	struct mii_bus *new_bus;
 
 	bitbang->ctrl.ops = &mdio_gpio_ops;
@@ -127,11 +125,6 @@ static struct mii_bus *mdio_gpio_bus_init(struct device *dev,
 	else
 		strscpy(new_bus->id, "gpio", sizeof(new_bus->id));
 
-	if (pdata) {
-		new_bus->phy_mask = pdata->phy_mask;
-		new_bus->phy_ignore_ta_mask = pdata->phy_ignore_ta_mask;
-	}
-
 	if (device_is_compatible(dev, "microchip,mdio-smi0")) {
 		bitbang->ctrl.op_c22_read = 0;
 		bitbang->ctrl.op_c22_write = 0;
diff --git a/include/linux/platform_data/mdio-gpio.h b/include/linux/platform_data/mdio-gpio.h
deleted file mode 100644
index 13874fa6e767..000000000000
--- a/include/linux/platform_data/mdio-gpio.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * MDIO-GPIO bus platform data structure
- */
-
-#ifndef __LINUX_MDIO_GPIO_PDATA_H
-#define __LINUX_MDIO_GPIO_PDATA_H
-
-struct mdio_gpio_platform_data {
-	u32 phy_mask;
-	u32 phy_ignore_ta_mask;
-};
-
-#endif /* __LINUX_MDIO_GPIO_PDATA_H */
-- 
2.43.0


