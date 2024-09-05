Return-Path: <linux-kernel+bounces-316687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069F896D2C4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6132283AE1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4E3197A97;
	Thu,  5 Sep 2024 09:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ceTS+Kad"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496AB19755A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 09:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725527256; cv=none; b=Y6Lm5vKfyzEWPGIuJTp7hbKbVH1i6/6ybFXxqf1D+Q0MiRiIfUwT+Z2V4C62TKCohiGB841ru05R/Qa3xfnUv97fb+Mr7eRhYNabNkPh9f2/5OnRPbvuN2GZXLGb9Ppr6xOiEEmwNts7ZdTw5UliJQeBK+DsAnr3lmWNKNgNfp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725527256; c=relaxed/simple;
	bh=vnmd2mVApxPLc2R6K6xVxS7OxGsZNFmbe/RXhcwO8AY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZdZHxJnOzrNLw1HkNhG5SQo+aEwvm8qucE4XRYIrqwin9NFkm0C5UOzuxbROE0kP8kcL+tlEIewDpLyf2cFnJdWXP57uBJWDLWNG0++nlEoZatQwsDMzx7ZOlHlK8GsYREBuV4Pn4SyYLmCg/2y14D+Ife0PcWYmIvbQhiyYlyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ceTS+Kad; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f4f505118fso5668641fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 02:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725527253; x=1726132053; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PtNAnqgNG24R8NK/m4hXcoIVXnpKbw66g/FsBrMA5y0=;
        b=ceTS+Kad/Hug7D1y3EauHJuZUZeTa0trfFs6o4e8n/S3Qjt83udFcau9cFkp9nV6sd
         yp9cfCSq66GNXoSCc+YVLnQ0PGz/O30oMMvFFs8ddM5RDfqtzTUk6JqR3RA3Si/DZ31s
         cXjC7WagcAHs+548pO1cKVZiCOuLxV01PlzpyIBPAIlsmvjg3RNKg6OTgLCDZ8c1IBqy
         VbcwBJeQ6Y5/Q5l5l2PX8srZhboTB7o4C4px+tNSbV1SwSkElhRV95QkM+oVrmupXMA6
         mo3/5RYR4hrIc4LyIZFWz9sZ6544VdadYhNurH5ltpoVcJKeVgaKVZFZDJSvk3jKk6K0
         nryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725527253; x=1726132053;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PtNAnqgNG24R8NK/m4hXcoIVXnpKbw66g/FsBrMA5y0=;
        b=HCtnVwPhjeGGGH08g7CMyjNOsohWlDxhQDnucePdAFu1Y263BN7U5PAbB9fVZPTziQ
         guaz/6woHZESOEKuL7pI38KyPTAaWD/0aX6wJ3nwQcz4sQmgLqq0QaqRkTi10drgqc/d
         Wzum9J+OUQv4WpbXjU3vC8poxxk+5VqUW9Uqq1LaD+wvIJAAe+5GL1j86UiynzqsmCEK
         nGLysRZIZ6uMqhof36/TRtqH9DaVByy3gZI0du0bOkEuuAzZbIcoYYhJ4Uh3GAdli2Cm
         BVR/zh3ROBIi4DzO4lGEPwoVvvzWpuyjpKJZmza9e7fgC7Qv8d+ok0JWqrGVlc4xujfw
         WRZA==
X-Gm-Message-State: AOJu0YyQuLhTHCbzWLmP8b5/eqBuNZ1tfZFI4A3eY/fX5yIOiGboNJFG
	rRKoNWp+JAlLCsf0i/1QWuIvEd4iCXLC0Ac1Nqz1+rfwscOz4iRtEDuo/ehMqcs=
X-Google-Smtp-Source: AGHT+IHUWKL+n+aiFePs4KzsKogKpO5HOL8lwDtIY5ZJCkwGzqAj0Zb5pk1kh5ZSvt9j8riN5kXVJA==
X-Received: by 2002:a05:6512:1043:b0:52b:bf8e:ffea with SMTP id 2adb3069b0e04-53546b93f60mr13156897e87.40.1725527253365;
        Thu, 05 Sep 2024 02:07:33 -0700 (PDT)
Received: from [127.0.1.1] (88-127-185-239.subs.proxad.net. [88.127.185.239])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-535406e5549sm2554188e87.0.2024.09.05.02.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 02:07:32 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Thu, 05 Sep 2024 11:06:59 +0200
Subject: [PATCH v8 2/5] ASoC: mediatek: Add MT8365 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-audio-i350-v8-2-e80a57d026ce@baylibre.com>
References: <20240226-audio-i350-v8-0-e80a57d026ce@baylibre.com>
In-Reply-To: <20240226-audio-i350-v8-0-e80a57d026ce@baylibre.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 devicetree@vger.kernel.org, Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2518; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=vnmd2mVApxPLc2R6K6xVxS7OxGsZNFmbe/RXhcwO8AY=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBm2XTOF6LibJjBVJ0Mak7b6zJc2UIL1Q3Y4UZZbXqc
 enhjEwyJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZtl0zgAKCRArRkmdfjHURboWD/
 9iL3VX1TG8/wPmhbnzb23RJymY0ctV1TF9XW5qW+DpmtYy+Fn12ijWcAcP/1m2jDCoTaHUMzqoQtaM
 PCd1PxmHLubIUpVyynAzHyuUBEb0+2ee2Y7sorWs04g1yQvQaWGtwYd3SmTeImXQ2ZttJTyMcu+aqq
 L1zVk3Ll+zMefprEcVicTt7crtY22HSS/yT3m/nxyiM7HjTv1c7EJMdlBmrpFa3ui3osM2IPhwNd7b
 pGAZGyqZxjjBQuXAz2OZKK6VunOSgFgYWUWbo73Qw3gF4QStKafcUgDxlftZbnYzNFHl3KtYeqAzs3
 37nnwatWubylC2gK7uHUn1Khnson1gqnkGseoosC5gWAliwN2WHbCewJ0WwYWrlrC5ye/FHUTjSlv0
 Q58wqvvBH/A2YWiRunc6iVAPGbybr6gFnJ6mICGGTh1tR0lHiJ1SN/mMXdMkH+iz2Xk2JTCAp1bGZ5
 zAJjQ02YeORd1+pEDbfEqlE2YjzfRrhKETjcb6NghsfTN/n75/Th9ptavVpvBfTR0NxnMnXBW3GPSr
 bWy79yPi0Fzpu72GxEg+JHtjszZBDTekMqKDwFEj4Wt7eR3RV4IAJV96xI824j4M94aot549UwpnLo
 GCNYYDcnV30g8FxJ0r2AUpPVhb3pQzOFxuP2ZdzH49YfrMeeF0FKkzVQE1Qg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

- Add specific config to enable:
  - MT8365 sound support
  - MT6357 audio codec support
- Add the mt8365 directory and all drivers under it.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 sound/soc/mediatek/Kconfig         | 20 ++++++++++++++++++++
 sound/soc/mediatek/Makefile        |  1 +
 sound/soc/mediatek/mt8365/Makefile | 15 +++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index 5a8476e1ecca..e6f7a5a49794 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -298,3 +298,23 @@ config SND_SOC_MT8195_MT6359
 	  boards with the MT6359 and other I2S audio codecs.
 	  Select Y if you have such device.
 	  If unsure select "N".
+
+config SND_SOC_MT8365
+	tristate "ASoC support for MediaTek MT8365 chip"
+	depends on ARCH_MEDIATEK
+	select SND_SOC_MEDIATEK
+	help
+	  This adds ASoC platform driver support for MediaTek MT8365 chip
+	  that can be used with other codecs.
+	  Select Y if you have such device.
+	  If unsure select "N".
+
+config SND_SOC_MT8365_MT6357
+	tristate "ASoC Audio driver for MT8365 with MT6357 codec"
+	depends on SND_SOC_MT8365 && MTK_PMIC_WRAP
+	select SND_SOC_MT6357
+	help
+	  This adds support for ASoC machine driver for MediaTek MT8365
+	  boards with the MT6357 PMIC codec.
+	  Select Y if you have such device.
+	  If unsure select "N".
diff --git a/sound/soc/mediatek/Makefile b/sound/soc/mediatek/Makefile
index 3938e7f75c2e..4b55434f2168 100644
--- a/sound/soc/mediatek/Makefile
+++ b/sound/soc/mediatek/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_SND_SOC_MT8186) += mt8186/
 obj-$(CONFIG_SND_SOC_MT8188) += mt8188/
 obj-$(CONFIG_SND_SOC_MT8192) += mt8192/
 obj-$(CONFIG_SND_SOC_MT8195) += mt8195/
+obj-$(CONFIG_SND_SOC_MT8365) += mt8365/
diff --git a/sound/soc/mediatek/mt8365/Makefile b/sound/soc/mediatek/mt8365/Makefile
new file mode 100644
index 000000000000..52ba45a8498a
--- /dev/null
+++ b/sound/soc/mediatek/mt8365/Makefile
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# MTK Platform driver
+snd-soc-mt8365-pcm-objs := \
+	mt8365-afe-clk.o \
+	mt8365-afe-pcm.o \
+	mt8365-dai-adda.o \
+	mt8365-dai-dmic.o \
+	mt8365-dai-i2s.o \
+	mt8365-dai-pcm.o
+
+obj-$(CONFIG_SND_SOC_MT8365) += snd-soc-mt8365-pcm.o
+
+# Machine driver
+obj-$(CONFIG_SND_SOC_MT8365_MT6357) += mt8365-mt6357.o

-- 
2.25.1


