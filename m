Return-Path: <linux-kernel+bounces-554208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9419A594B6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA28D1668D7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EF1226193;
	Mon, 10 Mar 2025 12:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Pe8FyqFG"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652E9226883
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 12:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741610430; cv=none; b=ofchtqYmrtYRTxwEZFoMQRf4cDnTq44c0zjAX1te9EwXOZwencuc4KvrpcSnYhHPkhkLq9UykuOO/Pb6Pn3ogj8UebmcWoZwU/tSAH/OQFOwuXM7atEWKEshk5gWUoSSXEtcv8bJTD3LvfGIa7VPPPkL3Tt2d+LEPExcbpeUw1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741610430; c=relaxed/simple;
	bh=/8NjX3rOzGTLQ756Q1j66Bv/y8E0Nf+JlzA4oIcsVvo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZbQR913J2PedaUHvhbqIr+HCdm/VkPOZbxOz8K/vEEyS8i1BlpLJrTWLMDjiGZCqnJ1+mp9hseoqdEte+74uMcB3/Y8gXSOEUSWkSeMe7jF054zSjC1bSKK+YktVzEoaZ8AJnvGL/2G5smlP1Nxv5GGppvYj5O2+r0hcRZ2vOFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Pe8FyqFG; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3912d2c89ecso3577395f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 05:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741610426; x=1742215226; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D0SW/193dSmdJ4hIuDLKeGIYpk3++UwLKAQ2QPtDVJE=;
        b=Pe8FyqFGEP4HfUQAB2aUsgL2DnXxbIRKLmPaf9zHD3XGYLK29nhrn+NddKP/dIqT2q
         spks4Wjnn+6HepcSzotBcyIhQuJz2K0Dq+8vaBdsWjm250njkAdmwrKyc0EZwsi6bU/H
         08gWJBBSa4oRftYIGioOZH70fDnjmmG2I3y0GTGB+0D1AgXboFefXtdrJqLalDgS7TH2
         dXVwwZ9Yocp0wq4zwt33y+m4FCFfdiUhel+4Xv04DF8J2AFn54ceOR/sTFlrYBfkxyyB
         PN5BYcpSg/14FbVE+SDGdydWC+fTc3CgoHBvvs1mUpWi/q56jCG5VSqD5//yu4mggInf
         oKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741610426; x=1742215226;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D0SW/193dSmdJ4hIuDLKeGIYpk3++UwLKAQ2QPtDVJE=;
        b=AcIN2P19jCaCo+fcWtj5neJRpbGA8KjNKnDyxrMZSRk9GsLX/l3RB9zzNC/U4OWUDA
         ngI2k28hEzZrtgv6kQBBN259Oclt6fqIJU17ZK6vEQ619shyFRkF06q5aCZYA96UmXZ2
         YImgNzQVU5wKLYAhtuHPbrt3KY34iTv3qa25f0y/77ecOl/nRvNOfujAYu8rGOcwEthh
         P134VUOrPTdHP/XVX8Q1MeOt7TRlB+k93428KltytVUwAYJVxkRtCk9R7OGGRlijUY4P
         Dr6703dNjFWMp4qPioy8jRgIxp28zPdV5yxC3Dsz26F+pEBoqWM1by2UzLo+6E46s2Z1
         WOJw==
X-Forwarded-Encrypted: i=1; AJvYcCVeH56WbOdz1JvSI8JgXkfIOZE9TMSEbK4KYuVWBoWrKyJQvn1KcrmU8/oHQnZIV+nTx/oHZSYoJLdZWNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS6rXwwsePnB+GcWd2BItHLrr02++XmTnopqaB6Sem4RlgIral
	/NIqQjFZ7Ve0BlTFiKRcR4O3xFdhOBYMPOIgF1I0fDhTYKWfyDWYt+2D8kBxuHQ=
X-Gm-Gg: ASbGncu6zO5FoxmEFFnHdWFtgjbhxMNluBeeHvK8mbbPvdAHh0TYmwWOZiS6AZ2iUpG
	Z4eCk/t2Gtl4sXRvKatvSU699nb1A63NzfhjhgSdOeR/QW5vkgbZ3iaDeSCo172oN0rXRtyZwlQ
	6rtnCytA5k2nY2G8/q+p+rdd3hskXjfmJWv7MXSfgIltUiZOZzpOZX2whajlutBwPFSm3rIcdha
	BXfL+hCpwljJHSl1EVBX4RzaOttk+xuQJHZToMexhhkRceKMZyMB8io3ExrKDRR7qfc0IVbXGHp
	TlkN2YgNHv7X7/CcC6FppqQv5MH6MYmdO/oRrQ==
X-Google-Smtp-Source: AGHT+IGvPu/1nOs92AdzRzoEoUE+KHkXYbFS1CNbXKzN17IWobEMq+YxPKwtrL34br0uOwNd+vwAKg==
X-Received: by 2002:a05:6000:18a3:b0:391:29f:4f70 with SMTP id ffacd0b85a97d-39132d308dcmr8761092f8f.3.1741610425580;
        Mon, 10 Mar 2025 05:40:25 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:2711:39c0:fb51:b639])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfdc5sm14535865f8f.25.2025.03.10.05.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 05:40:25 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 00/15] gpio: more gpio_chip setter conversions
Date: Mon, 10 Mar 2025 13:40:14 +0100
Message-Id: <20250310-gpiochip-set-conversion-v1-0-03798bb833eb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK7dzmcC/x3MSwqAIBRG4a3EHXfBHha0lWgQ9lt3oqIRgbT3r
 OEZfCdTQhQkmqpMEZck8a5EU1dkjtXtYNlKU6tarbpG8R7Em0MCJ5xsvLsQP8O9wQg9bFZrS0W
 HCCv3f56X53kB7YYVe2kAAAA=
To: Ray Jui <rjui@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@gmail.com>, Michael Buesch <m@bues.ch>, 
 Thomas Richard <thomas.richard@bootlin.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Andy Shevchenko <andy@kernel.org>, 
 Support Opensource <support.opensource@diasemi.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, chrome-platform@lists.linux.dev, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1977;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=/8NjX3rOzGTLQ756Q1j66Bv/y8E0Nf+JlzA4oIcsVvo=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnzt2xSm4P2dQUEH6/WXgLwh0Og3Dk1vWZ8fyc9
 3DxKuhoy8uJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ87dsQAKCRARpy6gFHHX
 cu4DEACMU/mbub1Wl/BAjiWgnjjXiGBySayfhIbiMgAGkBuRBylXg8baXdUi0i2sV6iwqrGE9OI
 s6HWytFr0Toai6HD8p6ilSac1y+EANFTsA6dyxH0lmGfeZr3JEtUtPhcp7tPrqkXV9EQEZa13qa
 LOiKYFy+5ZAonelieCiU1V6gPkjvE3EefjjB/xtCgJtrXlC55s3e5eCNj/OZ/MsAeGNbsDF5GDR
 SoKvCr86OQkk5NcO3hJ0FUAeodmCwwAv7jOyPRCtgNLFYelkMXXD4elNoIkAvGkQFVd0GLSZ8gz
 DZPIHGl00Z3yc4ciDQ6a5eq1daOl2SjjXiIqOwKn+OTTuhuNHNv5u3BxGUF/58kgHQDfjvs8KU9
 EAHspWUutD4i2GQnQMP6aklZMkvLmR3kukhKE4NKUmw2YLm9T5C1Y4h/S92YhtYNJV6EDJk2Yqf
 VNnmDw2qQi+gsxBKpBgV8AQl2hOSJQd0Q+tPHpFqNccUWqmAlMplHA41zSVrRdGf3Ho+8OCO0RC
 VogMfrduLhGTtcvOEdVtWCkNHCJo9pHHKmY9nN4TcC5N1fqAyZJdpWv7TDCSnfBD647CtXn9WuL
 sgprAl0gX46CqLn65AdKb5Pbb18qBNjd6rzy//bZgue1kaepXWwTgDIx/tCvXy2xm95Vly5eTq1
 nq3itWNk4h69CVQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

This is another round of GPIO driver conversions to using the
int-returning value setter callbacks.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Bartosz Golaszewski (15):
      gpio: bcm-kona: use lock guards
      gpio: bcm-kona: use new line value setter callbacks
      gpio: bd71815: use new line value setter callbacks
      gpio: bd71828: use new line value setter callbacks
      gpio: bd9571mwv: use new line value setter callbacks
      gpio: bt8xx: allow to build the module with COMPILE_TEST=y
      gpio: bt8xx: use lock guards
      gpio: bt8xx: use new line value setter callbacks
      gpio: cgbc: use new line value setter callbacks
      gpio: creg-snps: use new line value setter callbacks
      gpio: cros-ec: use new line value setter callbacks
      gpio: crystalcove: use new line value setter callbacks
      gpio: cs5535: use new line value setter callbacks
      gpio: da9052: use new line value setter callbacks
      gpio: da9055: use new line value setter callbacks

 drivers/gpio/Kconfig            |  2 +-
 drivers/gpio/gpio-bcm-kona.c    | 69 +++++++++++++----------------------------
 drivers/gpio/gpio-bd71815.c     | 15 ++++-----
 drivers/gpio/gpio-bd71828.c     | 15 ++++-----
 drivers/gpio/gpio-bd9571mwv.c   |  8 ++---
 drivers/gpio/gpio-bt8xx.c       | 48 ++++++++++------------------
 drivers/gpio/gpio-cgbc.c        | 24 ++++++++------
 drivers/gpio/gpio-creg-snps.c   | 10 +++---
 drivers/gpio/gpio-cros-ec.c     | 13 +++-----
 drivers/gpio/gpio-crystalcove.c | 12 +++----
 drivers/gpio/gpio-cs5535.c      |  6 ++--
 drivers/gpio/gpio-da9052.c      | 34 +++++++-------------
 drivers/gpio/gpio-da9055.c      | 14 +++------
 13 files changed, 107 insertions(+), 163 deletions(-)
---
base-commit: 21c853ad93097619c7966542e838c54c37f57c90
change-id: 20250310-gpiochip-set-conversion-4ce7e56df55f

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


