Return-Path: <linux-kernel+bounces-318947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F160196F581
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABD39283453
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87761D1F4B;
	Fri,  6 Sep 2024 13:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CDma5fnN"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100561CFEA7
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 13:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725629729; cv=none; b=GexTam4iXFug0e8GX5zGRK7nhCCOrq8cI6X4nylS0Gzm7ndpSrBHqPK73AXKyUr5C01ufz4EVnSUMuBpskbT49M0wGO7PMo4AFCCcO20xHA/+wWuR0k2UOgg2MQgy5jLfwc514u1Z4v3XZS/bsIBoJaRe+v71MHYRwurRjmUph0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725629729; c=relaxed/simple;
	bh=yrGWoxCpwHnlg0sdrbvMgawxznUl/m0tFw6lwaYIwVQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HppISypbhIKIKawCri2UEG9hYurikOh+1pLR/fSt1dIXI9qm8WB7FDuBEVmscTM/dgn9/KPhWVUbu5KA7m4HB94x5TwTTu7SxkRWXSdp58k0okLoVI6YaLq45bThUSKHwTXa5ul3mGtn837v6h/15GiqGuVNsnUCJ7SfzIs4irs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CDma5fnN; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-374d29ad870so1114796f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 06:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725629725; x=1726234525; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A7e2t080sCK0X27JFCHbHxpErVD3WPN9VMtlJLZs3BY=;
        b=CDma5fnNggkCuZsBcCfBp5LgdodsscAdBLXzWhYMJ4LKE1VLgvR0iue9xIJHlUb/Y7
         1iaVdJ1dqLtEuA8OQ+Ga1VLGqfHHKOEY4XptQ1HsKiO3zP/P3sxLCbu0AG/CzAls0nVI
         zLPUOQHO/UeDo+mtUO5ItaUsu16tHOBvn05RboGRtAUZB5BKN6R8js+i7xPTJdg85EeF
         +zLHM1olOZB/x7lDN5Z5VZWibziJuL5EtJYy5Ca/L6AyMVTMP8d0J9k/uwicdRAd0ktZ
         XX52ioonuFEWl8Ikz/gQHcn14cifGflOLkFaUDJM2luPOM7zRtAG6+84Zqj6oiUe+/YN
         bgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725629725; x=1726234525;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7e2t080sCK0X27JFCHbHxpErVD3WPN9VMtlJLZs3BY=;
        b=V9hyAMrrcvNjXfHcn+XbW1kScqZLBgnWUATKwgSX33O3bDbqS6o/eh7BAIr0TYuDk4
         fQqko8Dk6bPJfAlIYki+inUt/Tw4Gv8u6LwN5EdL09zUdZ5hwQm7+ZuRe12/pMGGaQqb
         SvG1lh5qFTY+F6pbIsVOf3Hvbi4whQKRf+NWSG+TQBsfD/K3zb4VKZ8dC5LPLLSImz2c
         wPQvphRVmzcQ6+pa/6eFveetaoE2iCs1X46iMeKMp/bbxNSe/ubyZT811QApmLCrozo0
         p/bo70dd/s782s7a6aPeWejLCVUVSURRdJgOkTLfzywJxsrqbXmm7i3F8hpkFIymnDWf
         zEQw==
X-Forwarded-Encrypted: i=1; AJvYcCUbr9fH5oc1Z4ymmaTOj9o7tdML2HGenZ4hPhrtuZDpPsX5mNtFARZs2t+aoeHkMSgr6klWESOL/tWneq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBEBhs7aND+TkvpbgPnjCGRyAMhppdpp+Rb1mfqjRloVpljOxA
	G2A/E7AwPKgf7dt6RMFVhtTuo78rTo6EwNwHUQTAGVhZuLdqfOWmiVvjqgYrsWTmqZV0UL8f2wI
	C
X-Google-Smtp-Source: AGHT+IHTMY70b2wlGnBeKNWQ1H9t8xY5YyM7J9AJV6VQM+f6aKmz2fjdTwT/C0XAKinvOj3j1jrQmg==
X-Received: by 2002:a5d:58c1:0:b0:368:5a8c:580b with SMTP id ffacd0b85a97d-378895c73d1mr2022486f8f.19.1725629725133;
        Fri, 06 Sep 2024 06:35:25 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:b0ad:b504:10d4:481d])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3749eea60e2sm21684597f8f.62.2024.09.06.06.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 06:35:24 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 06 Sep 2024 15:34:52 +0200
Subject: [PATCH v4 7/9] reset: amlogic: move drivers to a dedicated
 directory
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-meson-rst-aux-v4-7-08824c3d108b@baylibre.com>
References: <20240906-meson-rst-aux-v4-0-08824c3d108b@baylibre.com>
In-Reply-To: <20240906-meson-rst-aux-v4-0-08824c3d108b@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jiucheng Xu <jiucheng.xu@amlogic.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4127; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=yrGWoxCpwHnlg0sdrbvMgawxznUl/m0tFw6lwaYIwVQ=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBm2wUT1wWu7fYlSNotSd/YCXGraANoQxIW+ZEPS
 XPNFQxPKCyJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZtsFEwAKCRDm/A8cN/La
 hZihEACuzpcQEZLYGWXGGYjSdQb2I7XyOrvYAwbZ/bhUGUbWntGZO2HkWalrWET3GnMTnCeu1g5
 n3CDJpxVbSOke6/YnOGA86Z6L4QxjDE18SB3x3XvQ7Jx0JcHzVYpULT+Rb/2J/ItXbpe5tiC8CE
 /k75o3tYZuc4KUTQDjjXnenlqbcMupjzGuj9w9PbyXPchrLC7H7qEMuicnD3owMstSeinZtExx9
 KyffddVYX1zkYzI6xQXhbm2Vp6vCYu4kKgtE25HQN3UdqgU+iu/XrT8TDMFwKdSacOWsBuOwXuO
 pAALO6F9cgglE9WFAl+c+hFVkcFIAJ/YhsYMIrWzxekYRsREDZGEBabKt45wp7tdNDueU6UkaM2
 xwG4MKaKjJN0GVOUsjDpGagr2c/sDCHtf/5kOpEtKbkCq99lhftOcHFSfT8iqd2pce1vFjUqfa5
 ZBJONWyc/hUS+l2bUE/KC/C71xLW+juq36/70HAW33dF5wmx1n7o/p7o26G4DF31HKB33gfqao7
 f+6X9ZwK5iZUp2LrlfgtdXE1uqxzwM0tc4vBTSl0TdW7b+6G1LXxEPMWXC4uGdC4TkGw/QaKYj9
 JvsKrF6QE9jR9vSHbdBiqQNjRHdCoJ+QQ3VsncLkgP7MpsXz5AYVHewJyK8/AzOS2JUlzBp3zf1
 a4WeASVXIgbJhjw==
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
 drivers/reset/Kconfig                               | 15 +--------------
 drivers/reset/Makefile                              |  3 +--
 drivers/reset/amlogic/Kconfig                       | 13 +++++++++++++
 drivers/reset/amlogic/Makefile                      |  2 ++
 drivers/reset/{ => amlogic}/reset-meson-audio-arb.c |  0
 drivers/reset/{ => amlogic}/reset-meson.c           |  0
 6 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 5484a65f66b9..d28c4401a310 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -153,20 +153,6 @@ config RESET_MCHP_SPARX5
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
@@ -356,6 +342,7 @@ config RESET_ZYNQMP
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
2.45.2


