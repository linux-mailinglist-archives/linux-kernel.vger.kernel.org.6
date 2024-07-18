Return-Path: <linux-kernel+bounces-256246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBCD934B61
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 208ED1F217F1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C038285285;
	Thu, 18 Jul 2024 09:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RfTljWYv"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A0F12EBE7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 09:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721296692; cv=none; b=o3VDINtXMaofR6qlUgmSzWJEjrrnWsk4sMrc6VRAA2iMc9E0ve5hrLcN+0si6On5fT17fmXoMzxkkgrKRf2E0V9L6aYK8RG0qCwv03apNu09iZebGsOfdHH1AKrvQ737rMcq0tZ2TQ8VaL6xV87dO6CrT5e/oH98a9I5XdjD+b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721296692; c=relaxed/simple;
	bh=X9P7ZeWymMLqFZGWrumCo8iBNn8RuORIPL0PHhhDpzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C60rPJpJc/+CkP3H+eJDvP54RPLJBLlXYvcXjoDkHoV13ml2a4yZh2Lm+TMcz0zVO+M5UHgj0u5TWvedjgzn+YAhsE9rY+1MF+AO2Y62mqp9B70KIcixlbcOFi1miQo3X00ukJNl2XtH+0NT6+vt88wVqC3A82nF9MfRuzvgM8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RfTljWYv; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3684bea9728so426583f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 02:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721296689; x=1721901489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/FraBsn5t4nMihNDzTPwopMxXwcMdzGEUC8JHsJV5Dk=;
        b=RfTljWYvQLwezfhk/m42037/Vys4IPtmlTiwmyNDbjd5CwAATkPlK1ZLZDPNbJBF4y
         eZoPOh+ud5i9qbpWw08J++J5ITcdw1Q2E56HlQFDtmwdg8COl0OeVXLXT0qydI4o2pSH
         rlOF24YBzc7qT9tGAZH2FtQolOQslpguolL3jfxdQw9xj8cxlcFl3VgyL8QjhvspZ0co
         Crkihe/0kUnCUggI2PSD3GZMqad2FSvPEemCT+dmbZhBE0mkXnHbo6ZFSz5H6BnZp/eT
         G2+ZFiFOEI9BySMr20BRbuuqGmxRvpTBOZR4zAzvRdh2EYB32dkTT8wGkkw6Z6PMYfot
         wadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721296689; x=1721901489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/FraBsn5t4nMihNDzTPwopMxXwcMdzGEUC8JHsJV5Dk=;
        b=fe+T3eYvXgbRVLxnuvXGRKB0X+r8QgFnnUtcLGcYKVqeZpUt8gcAzUjH0ja7S4Stob
         r0+vzutbDQ8kZFY4rYu7kpPewH/cfqk0N77Fw4vkjPOb7pLYcMv1UkcU4hnU+bIWZxrk
         dXKCOpQFh7Q/FXnnKQMHNBKMM7zcsEKLFnupZUpClv4SEadhZyZ5hIS8fsF6N8Ip8hye
         DZg+aVJJrVqbMeEEFp0/x4DtPL68LiBw+udcWBkKibg+ti88MXZWA8tbgDfXxAQrGV7t
         tFPNa2KJqYW1lQO+/xi3l4LgzxNZfVmlTLPnNJwq2nOGX067i5hi1PVyXQTCCHNsa8Bt
         fA9A==
X-Forwarded-Encrypted: i=1; AJvYcCWxENOovp6JSl96HSN3sttjLCowW3HAT+Rj1CokNFd1lo9IQyfjF3brbLAP2MDJCRYTO30s/NrG7SuGZwh/KRXObstJNwPNwWoFMV0C
X-Gm-Message-State: AOJu0YwPa0OV8OnZ8R9q8oU3bzK8PIEi7DcZeGuVAxB2MsN+htIE9hAi
	mrqVFNrmTbPcu34F+C42djKQk+0I8S/90Og6L9nSHPBlko8hBYgDX4hueviy148=
X-Google-Smtp-Source: AGHT+IFfFHtbCLCHhNC4eT72EfA+0uRA7O4pqzK1FiqFakwv+5WvN9D5HdNF0I2/90lf698t3MbycA==
X-Received: by 2002:a05:6000:2c8:b0:367:9639:66d3 with SMTP id ffacd0b85a97d-368315f3344mr3179887f8f.5.1721296688962;
        Thu, 18 Jul 2024 02:58:08 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:8d37:f44a:c212:e320])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3680dab3be3sm13837155f8f.24.2024.07.18.02.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 02:58:08 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Jan Dakinevich <jan.dakinevich@salutedevices.com>,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [PATCH v2 7/9] reset: amlogic: move drivers to a dedicated directory
Date: Thu, 18 Jul 2024 11:57:51 +0200
Message-ID: <20240718095755.3511992-8-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240718095755.3511992-1-jbrunet@baylibre.com>
References: <20240718095755.3511992-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

The meson reset driver will be split in two part, one implemeting the ops,
the other providing the platform driver support. This will be done to
facilitate the addition of the auxiliary bus support.

To avoid making a mess in drivers/reset/ while doing so, move the amlogic
reset drivers to a dedicated directory.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/reset/Kconfig                             | 15 +--------------
 drivers/reset/Makefile                            |  3 +--
 drivers/reset/amlogic/Kconfig                     | 13 +++++++++++++
 drivers/reset/amlogic/Makefile                    |  2 ++
 .../reset/{ => amlogic}/reset-meson-audio-arb.c   |  0
 drivers/reset/{ => amlogic}/reset-meson.c         |  0
 6 files changed, 17 insertions(+), 16 deletions(-)
 create mode 100644 drivers/reset/amlogic/Kconfig
 create mode 100644 drivers/reset/amlogic/Makefile
 rename drivers/reset/{ => amlogic}/reset-meson-audio-arb.c (100%)
 rename drivers/reset/{ => amlogic}/reset-meson.c (100%)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 36cfdb81cd34..3015fb8bb6e5 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -139,20 +139,6 @@ config RESET_MCHP_SPARX5
 	help
 	  This driver supports switch core reset for the Microchip Sparx5 SoC.
 
-config RESET_MESON
-	tristate "Meson Reset Driver"
-	depends on ARCH_MESON || COMPILE_TEST
-	default ARCH_MESON
-	help
-	  This enables the reset driver for Amlogic Meson SoCs.
-
-config RESET_MESON_AUDIO_ARB
-	tristate "Meson Audio Memory Arbiter Reset Driver"
-	depends on ARCH_MESON || COMPILE_TEST
-	help
-	  This enables the reset driver for Audio Memory Arbiter of
-	  Amlogic's A113 based SoCs
-
 config RESET_NPCM
 	bool "NPCM BMC Reset Driver" if COMPILE_TEST
 	default ARCH_NPCM
@@ -342,6 +328,7 @@ config RESET_ZYNQMP
 	help
 	  This enables the reset controller driver for Xilinx ZynqMP SoCs.
 
+source "drivers/reset/amlogic/Kconfig"
 source "drivers/reset/starfive/Kconfig"
 source "drivers/reset/sti/Kconfig"
 source "drivers/reset/hisilicon/Kconfig"
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 27b0bbdfcc04..bf089176c9f4 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y += core.o
+obj-y += amlogic/
 obj-y += hisilicon/
 obj-y += starfive/
 obj-y += sti/
@@ -20,8 +21,6 @@ obj-$(CONFIG_RESET_K210) += reset-k210.o
 obj-$(CONFIG_RESET_LANTIQ) += reset-lantiq.o
 obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
 obj-$(CONFIG_RESET_MCHP_SPARX5) += reset-microchip-sparx5.o
-obj-$(CONFIG_RESET_MESON) += reset-meson.o
-obj-$(CONFIG_RESET_MESON_AUDIO_ARB) += reset-meson-audio-arb.o
 obj-$(CONFIG_RESET_NPCM) += reset-npcm.o
 obj-$(CONFIG_RESET_NUVOTON_MA35D1) += reset-ma35d1.o
 obj-$(CONFIG_RESET_PISTACHIO) += reset-pistachio.o
diff --git a/drivers/reset/amlogic/Kconfig b/drivers/reset/amlogic/Kconfig
new file mode 100644
index 000000000000..7ed9cf50f038
--- /dev/null
+++ b/drivers/reset/amlogic/Kconfig
@@ -0,0 +1,13 @@
+config RESET_MESON
+	tristate "Meson Reset Driver"
+	depends on ARCH_MESON || COMPILE_TEST
+	default ARCH_MESON
+	help
+	  This enables the reset driver for Amlogic Meson SoCs.
+
+config RESET_MESON_AUDIO_ARB
+	tristate "Meson Audio Memory Arbiter Reset Driver"
+	depends on ARCH_MESON || COMPILE_TEST
+	help
+	  This enables the reset driver for Audio Memory Arbiter of
+	  Amlogic's A113 based SoCs
diff --git a/drivers/reset/amlogic/Makefile b/drivers/reset/amlogic/Makefile
new file mode 100644
index 000000000000..55509fc78513
--- /dev/null
+++ b/drivers/reset/amlogic/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_RESET_MESON) += reset-meson.o
+obj-$(CONFIG_RESET_MESON_AUDIO_ARB) += reset-meson-audio-arb.o
diff --git a/drivers/reset/reset-meson-audio-arb.c b/drivers/reset/amlogic/reset-meson-audio-arb.c
similarity index 100%
rename from drivers/reset/reset-meson-audio-arb.c
rename to drivers/reset/amlogic/reset-meson-audio-arb.c
diff --git a/drivers/reset/reset-meson.c b/drivers/reset/amlogic/reset-meson.c
similarity index 100%
rename from drivers/reset/reset-meson.c
rename to drivers/reset/amlogic/reset-meson.c
-- 
2.43.0


