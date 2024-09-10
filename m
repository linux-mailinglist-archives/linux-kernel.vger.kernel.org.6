Return-Path: <linux-kernel+bounces-323459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 728E1973D6F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FFF61C2525E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2441AC423;
	Tue, 10 Sep 2024 16:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="w8CBHiPc"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81471AB53D
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725985992; cv=none; b=X6+GrswK1N7QwBRHSPP166HqKgK6lFUcSYsxSV8NnVrlZ9RtR2MjfRY8mtUOdSm6nDenvljFcgOICaJXNWnezLtZ1NajB7IhxZcdPIy+Rmwf5jasCH7IaOswK6XSYHOL7UwzdP2gCOuN35uTgeCDzEiLArlq7LKsrw1Vi4GmABc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725985992; c=relaxed/simple;
	bh=9xw/UbuAm3lkXdgMs5mApQR/yO7d5t0DYqss2FrWhZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hBNGDb/lX26ttyBVaSWoavI736RWcKGk12jzRRIN27VI5oXzuIqlcibWT6I0KIYKOoBdJX1CChrxxpfvXlubdH3Wi/ejVjCS7VrxluJyAHHF/82cbpPRmMZ4KdTLIiegLr6G2meXDugUi2wnJgkqA0zG2ANiQRZbUi4cptXzxgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=w8CBHiPc; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42bb7298bdeso69287535e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725985989; x=1726590789; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7QSINvKV6nbZV2fQuAbJusgVvaCiwjnmEbgnT95Es5s=;
        b=w8CBHiPcbftxlHdvuwYMrvU/P24MweI/ye3/26ElHd+1K7NTEcj7vCF7u9CUmfOhVx
         abli3gPRHlNFLRWJ8htnxMJboFtbNb4a0QYtu689C31SvJRzNf4loQqeH59JSoNpnB0G
         QP5am6paen3+SxQ/Bi9M4zGzLk0PXbeUGOoUF2fCxmwIL22MknNk55bgdxXs0xfrF4ek
         b5VMEwU9ufPs2+ivhE5OUFfRZC4u9oSzlQFHQ637AY1dbEg4r4cQvB3cbtZ3K+35YOGw
         antDEcQKrjrQUnYR0pTEbFoNX6eoWQgq89qNqGaVpQGFCKvtba/DaKLObSni3CciIsXl
         olPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725985989; x=1726590789;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7QSINvKV6nbZV2fQuAbJusgVvaCiwjnmEbgnT95Es5s=;
        b=R9rm9jzzcdR3ajkEp5soWFY8SgyC1+eZVBIDtRkOzl+lOsGSoCFBY0JDaf61vwSwoR
         CFZWMt+PVI4vwTyU+F+7ADRRbrDUMUgt5qsCefp208kXkNhK4n1D5BlTToRMA61D6aFs
         rzwA1dF2hQLE0UKmjXFUC+pT7VBysk/17ced3jQiNfwWzwOJehPu9QaRAjHiXA1ux4N7
         CF7ufv7Sj8FkkBrGN6ntNJOE1mmzFKBVq6Ng6p5lCjH5C42ijOP5wmBDJifNmHFhqVWp
         fnv4aaceBofky07ZkcueAmhMIG7KNb9C4zOOwzTPSGdd1XPRplQxdqer3sOz0N27DT2w
         HfDg==
X-Forwarded-Encrypted: i=1; AJvYcCX0wlnzi41S+4astAFMFT1AXrvl2ij5/g2Gy4E5F2b61a7z1o75UJAcIcaHEAmqUwJ4KJZv4e/MsxM98Ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRcvPYvJtnpCuDXZzMN4/7weVop+49sVAoeQo+h+0pmTVLBNR7
	qHKaZqI+FlvjH6HqqdwoZCanM3n4lb5m2xDD57adXFSb+2maM+GwVBothMHxJoOiRLRTPfT7NcH
	w
X-Google-Smtp-Source: AGHT+IHiOGsYoN/QOonTnWDkK8vql9LoMqXEvKgjoSQX7zg5og4UwUh7/sOiYoeyGJfrJVS7mxl9Uw==
X-Received: by 2002:a05:600c:3c88:b0:426:59fe:ac27 with SMTP id 5b1f17b1804b1-42c9f9e087amr145081685e9.26.1725985989123;
        Tue, 10 Sep 2024 09:33:09 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:8ba7:bfe4:fea9:65b])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42cc1375189sm25076025e9.1.2024.09.10.09.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 09:33:08 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 10 Sep 2024 18:32:49 +0200
Subject: [PATCH v5 7/9] reset: amlogic: move drivers to a dedicated
 directory
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-meson-rst-aux-v5-7-60be62635d3e@baylibre.com>
References: <20240910-meson-rst-aux-v5-0-60be62635d3e@baylibre.com>
In-Reply-To: <20240910-meson-rst-aux-v5-0-60be62635d3e@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jiucheng Xu <jiucheng.xu@amlogic.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4173; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=9xw/UbuAm3lkXdgMs5mApQR/yO7d5t0DYqss2FrWhZc=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBm4HS6n8wPd2WR3HfaoRCWgNRnfZ+NRpRnOiLOc
 gAnCM4mHzuJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZuB0ugAKCRDm/A8cN/La
 hQFxD/41k1AeedXrANqdaPu5EeRp+u77A08mMOLI6TEPmKy78HrTQcdOxHVrKcDr8fS3UXuQpiq
 G91PrZSzurQS90IKgIJ0Av/JrTh+2mE3OvHKujuIiYVGlgY6WjgUUtgHUi4y1stDgS16uEe34Mo
 vtRCxFAlmof9ZbyvysEuChKlDYUEyxR/gBkDDiYt0Qy77IgzgbLCRe1tkVIYE/t3twvlvD0X/Qg
 jWSporf9EsnYygm66tqilaxGpM/cbm2XnN9tn0xQVMsDkRz/MIeTBBqMb3PTR8zmXqfB/cjf488
 F52FSaiAd0AYrFUE4hrX19SqQ2jBtkGnjp2LlMTZu13ul8BzP8e9sqcRoJpOM7blhfyPxMRsBYl
 2dc23+DtkT1/H4ehS68Gaw5j12vnQBzJoTTmApHdL5uuZubGWjwdvJ3TZMUUeOgNqiKGBLhyn43
 sh74BNUBWYYQS/kOgml9e3zfIWwmXUZjlEb6AoSFvP4Zfdti5v3mF2ZMrSvtUIlqsgzo41xCuRH
 JxYNL7F4WKu+qflzt27jHYlQDhWaXYdX8tAPg8hWIXzitmThT0F+9vJ6QOZaCiBE79SAvVCJAO2
 8TLxJ9Mp7CSnvDaMTm/9SzQIYal2+E2FOI6aIpgsD43HGluEjwguD/PasFJUafhw5B8FUdNMqH3
 9e03/zOgRtnHjMQ==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

The meson reset driver will be split in two part, one implemeting the ops,
the other providing the platform driver support. This will be done to
facilitate the addition of the auxiliary bus support.

To avoid making a mess in drivers/reset/ while doing so, move the amlogic
reset drivers to a dedicated directory.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/reset/Kconfig                               | 16 +---------------
 drivers/reset/Makefile                              |  3 +--
 drivers/reset/amlogic/Kconfig                       | 14 ++++++++++++++
 drivers/reset/amlogic/Makefile                      |  2 ++
 drivers/reset/{ => amlogic}/reset-meson-audio-arb.c |  0
 drivers/reset/{ => amlogic}/reset-meson.c           |  0
 6 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index c730ba6f678b..d28c4401a310 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -153,21 +153,6 @@ config RESET_MCHP_SPARX5
 	help
 	  This driver supports switch core reset for the Microchip Sparx5 SoC.
 
-config RESET_MESON
-	tristate "Meson Reset Driver"
-	depends on ARCH_MESON || COMPILE_TEST
-	default ARCH_MESON
-	select REGMAP_MMIO
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
@@ -357,6 +342,7 @@ config RESET_ZYNQMP
 	help
 	  This enables the reset controller driver for Xilinx ZynqMP SoCs.
 
+source "drivers/reset/amlogic/Kconfig"
 source "drivers/reset/starfive/Kconfig"
 source "drivers/reset/sti/Kconfig"
 source "drivers/reset/hisilicon/Kconfig"
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 4411a2a124d7..677c4d1e2632 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y += core.o
+obj-y += amlogic/
 obj-y += hisilicon/
 obj-y += starfive/
 obj-y += sti/
@@ -21,8 +22,6 @@ obj-$(CONFIG_RESET_K210) += reset-k210.o
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
index 000000000000..532e6a4f7865
--- /dev/null
+++ b/drivers/reset/amlogic/Kconfig
@@ -0,0 +1,14 @@
+config RESET_MESON
+	tristate "Meson Reset Driver"
+	depends on ARCH_MESON || COMPILE_TEST
+	default ARCH_MESON
+	select REGMAP_MMIO
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
2.45.2


