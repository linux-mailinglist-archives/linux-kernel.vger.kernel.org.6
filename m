Return-Path: <linux-kernel+bounces-279251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C9F94BAF5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D638828384A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387B718C35E;
	Thu,  8 Aug 2024 10:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FcfuIm9g"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450AD18B46D
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 10:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723112890; cv=none; b=RA936PY97YNvRwppO8Tp4/EeWUOwnMjxXkzuHJnS+hwijOUwE2VKwkSCH0TYVqtAMdVO3+ATJIsw2adz6uAVv2rSVOxlyVWXG3ghdIBtIRpUsnbaQd1HazXbQzRPfnxOJbJ96uTFVeVdXltxaxLcgQRlr56a+8eLZkv/wsjvhFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723112890; c=relaxed/simple;
	bh=FJV8WpUSAXHd9iSKbRipWBdZuj3nj2ZfvvNLA6M0Jig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jqnsPEhq2dgZzsRm6Wfv5TEl9ucqNZZ4tMw5xXEXBrQTYZGS7BYtNQVIAW/DFppKVAG9D4R0T3TYN1RC5JRDd00GA+b10ZRwRPf/LFKLDMFH225JvKXEJxII5UoCvJ4bqh0PexeeV0G5WTlVTRefghp9KMJ79qiltZUuNIuyw7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FcfuIm9g; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3683178b226so310589f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 03:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723112887; x=1723717687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=99vHG6KBBSHLQN8ohhXjHSjQ/wjLWpAkbUWnRIGsOKY=;
        b=FcfuIm9ga7WkW5B7GPRJ8riUbfCeVJpzaKl2HWDxw054M2+kOZ9CDnwBF9LaIfuJls
         FSy+N9t4dnqD8eMQpLfwm6dL6rr7LX0/F36IHCshX13ik4eNvNsmLzK+Tn4JftF+PAD0
         k8Y/8it3qqHHFyqNVNRXeRH9bLi/JF7snRymXPWSSxaWZpw+9fCk9A64C+yWh2pwiiJG
         PAdp5bqjaOyoQM9vZEcVDFTb8jKSz3D0C1W1+AJvl1aqRbTB8Ma4itZp9y/6xayRUEzy
         Tz53ZB7LgkS+QCxKpSY4pGGhMEqrn71/nW0GNF3CjJTaCddGUcKenAKs73Xnp7kgB5wj
         vkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723112887; x=1723717687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=99vHG6KBBSHLQN8ohhXjHSjQ/wjLWpAkbUWnRIGsOKY=;
        b=wlhy9P69rZObXzwfN+kD99CSu/AwMm583sbM5aa0oxsagWFAdyRgDcXAUdENZzElUS
         +3cg8NESHeWwYND7mi/w3eg1Gq6kpsIu2gmOisUROqeU8ZD7SN0UPOYBA4lnkFUAi9Ww
         xlSKHKAhb19nBiWE0Ot5Ed9v+o0tFY5dmUU3esJJsj9eK+vYBj9hXwZUiuXPOM7Ig8UF
         oV3w2vE2zPDZV4vHXD9aqsEbk2zWBWKDzUMS8vPbcaMee0ZG0apmmhItoQRwfoqPPA3o
         8ZzeQx7aSZA1Y3d05QXOjkLY2Bh6v1+tBnUJkdKnQZBChAzmb0PP+5G9AAYj3yZWfTGn
         7hqw==
X-Forwarded-Encrypted: i=1; AJvYcCWb0zh43R4vG3K6zbv/FedUO06GHf4lK3xeZwm7WpKqfhnL0DFQZYduavKWwsLhyY0mW2revkbzVcVXf/Wn211mVj4W1aS2k/LdVQgP
X-Gm-Message-State: AOJu0YxQp17WDAnKaeJ9Cw6FRN6jlIjOdvgjpoH1hrhyFs6JFVNWqQqN
	cK9ldA+Oq8nKwvZmlJmWhrtRcBU+5Ptg3k2Pi+ks+UKylSW/citZbsvkDcRL8L0=
X-Google-Smtp-Source: AGHT+IHozoY21BcuIdPpefQDlZte6viZbFzsG4azJdBTs++YWZDu6Dyunzbq/tZpmybC31GPCvae9g==
X-Received: by 2002:a5d:5910:0:b0:368:6336:6051 with SMTP id ffacd0b85a97d-36d274dd07bmr1051331f8f.22.1723112886546;
        Thu, 08 Aug 2024 03:28:06 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:ae7:4e79:8821:15db])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-36d27208c98sm1454596f8f.75.2024.08.08.03.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 03:28:06 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [PATCH v3 7/9] reset: amlogic: move drivers to a dedicated directory
Date: Thu,  8 Aug 2024 12:27:37 +0200
Message-ID: <20240808102742.4095904-8-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240808102742.4095904-1-jbrunet@baylibre.com>
References: <20240808102742.4095904-1-jbrunet@baylibre.com>
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
index 67bce340a87e..0c092ae1b411 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -140,20 +140,6 @@ config RESET_MCHP_SPARX5
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
@@ -343,6 +329,7 @@ config RESET_ZYNQMP
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


