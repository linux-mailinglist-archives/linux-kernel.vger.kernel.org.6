Return-Path: <linux-kernel+bounces-187199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEA98CCE83
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30B37281423
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 08:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C156614D2AC;
	Thu, 23 May 2024 08:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AwcHcfBZ"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4AD14A0BE
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 08:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716453787; cv=none; b=ZoQ4kPUe8SN88uQ9oFCrp1jhjO2/ykT3KcKBtCtj1x3bub9I8D80650KqZsq33pEBeNX5XlWr0tqS999H9YLxfDoFTA3BW/YpGc8P4Okumyf7RiiHFZ9IxGigUrhDqyiQNBsevT5O70aK2JmVG8ZLqJzlnesIw0AB1TzYNczz6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716453787; c=relaxed/simple;
	bh=A2PASoilqpYSI/+vuK5IOoXc5LlU1gMN/yOVGVWPN5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NUaywtYr4dJymF9WKr4ss1GGvQ0vUzFDfRyaY4oO1yWAjGPt0d5PWY2+JVykIGheYRNO3v9zd65VJVJc0MSOi23FYQRVz/zl+GYC0QqKAmkAoGfn8f9NcZCE/XKok0c/1a9MTrfaPR0pHamcA2TFBMdYA3AtShUZHUs/f5If2FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AwcHcfBZ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42101a2ac2cso5382585e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 01:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716453782; x=1717058582; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+HA5hs8xf/jy+EOJ7+HP5joeg+9+VSnSpeoghvWaVeM=;
        b=AwcHcfBZLcQocIxKY1NW7YMW9wBrpbAgNPuXSyxT4GVGblViXTR2hRFK+GAMTOq+/K
         eHYjwDMqjSOcmEpnqO7hxtvujjPU2HecdVkZORGoU/zarF7u/EidePSmue4ETmqr/3Z0
         ymIbnmEJ1YU5/mnvazARmk3RutVyuihy772+3g45SZG9ZmpJWyxdK7cxmUNmQ+58uUhJ
         qhNamIwj5vZewv6ZeN0qtTlCVmxoENKArI7Ho/uqrFwy5uAWOFmgfIbcEEa4BfCrmjt0
         yhKOzsQIz5Rc7KfcySHOVZCehc0XWegKzYq+qEijhaLKZ3Weu2fetltRN3heCo36UowA
         yGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716453782; x=1717058582;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+HA5hs8xf/jy+EOJ7+HP5joeg+9+VSnSpeoghvWaVeM=;
        b=lLgfDGuIQGSOe/0F3TM3k90e+PWXwY7Eh+O0kdE5PTuKd34rymUb25dfEghnt5a5MD
         d48vQKgULBjjOtOcJ74U6MGctN65xGEI/mIgM/RO4JaIhU56y1y2d6c3DK5QFrw3cni5
         dlN63VujqEFxcFQFNH4cgAPLY8N8wlss17TwAkkHdbxSYToMbUBIl7yVzYMf1aAaCbax
         UnLa2K39libjLVDKwEdB7Hh2YOjhzu9GxoBNwwoDo7n8OSDePPuGSoqzyQo4EINYe7U/
         accruevE0xwJ6lEBsLi3i3koHcKK0GI+mpnCiOFjf/XHKr0tOhg3NijCvdGljrUc8e5o
         LrOg==
X-Forwarded-Encrypted: i=1; AJvYcCUfOZW2BUq2kIRLLXrjtFj0dB6y5Gah2Jewecf60oCJzAcpmtGrzHwduBANUrZlyV72bTFCQLC6usGda1BR68pP5XvbNr/hyEOy3m6I
X-Gm-Message-State: AOJu0YxOGdkmKeNJvj7Mkj24YYBRvXo/gsZmSBTjQD/nMXgwLcFj+0Qd
	HGmFMT8PbA2DCITGmSuaQtP/+ckCvW5Z2yQ50LhL/guL1i5zGAmliHNmiOduVgI=
X-Google-Smtp-Source: AGHT+IEgXB8XAglpO/+u8eIAozosQjUX70ZSlCyMPcZgIahX51v2m4pBJfTJ8NVJU32cec42EeGwwA==
X-Received: by 2002:a05:600c:1c1c:b0:41f:f592:2fa3 with SMTP id 5b1f17b1804b1-420fd2fee2fmr34719085e9.11.1716453782151;
        Thu, 23 May 2024 01:43:02 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42100f3e03asm18556645e9.17.2024.05.23.01.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 01:43:01 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Thu, 23 May 2024 10:42:42 +0200
Subject: [PATCH v5 13/16] ASoC: mediatek: Add MT8365 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-audio-i350-v5-13-e7e2569df481@baylibre.com>
References: <20240226-audio-i350-v5-0-e7e2569df481@baylibre.com>
In-Reply-To: <20240226-audio-i350-v5-0-e7e2569df481@baylibre.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lee Jones <lee@kernel.org>, Flora Fu <flora.fu@mediatek.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2430; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=A2PASoilqpYSI/+vuK5IOoXc5LlU1gMN/yOVGVWPN5c=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmTwGA1rPY6+2jHY0Jdp8w3wCySWSDsGcI3gF7IUbF
 q4jgYFiJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZk8BgAAKCRArRkmdfjHURe8/D/
 0YvpKzCTSlToY8nBJfWFSHqFFE4a05PMPt+Im7zQRDtWIIYUJJ6saPOfhv3dyJHFQ4s+iimRBUOikt
 wHkaqQWMzcZ5VIIYk1wMG2qpqSYqfeldl6oPj4gqp8Q+p6+zyQ8VJjHN3nbilnthHesZNt4yzeE0G6
 hMSrGS1Wxu9NWk6sBEI46gHKUX7q2A5kbuJV/wI0f3gyN9SVvxQ5Qh7VNwgTSNvwctCB5BH49ktLJU
 4pEd4tY9+iawrsqv0mL3eYI5VOzptiWsMYSzR30T7sRvCJuGQLX1ALajBwhfs5BxiL9cuQZz6PCGD5
 gRSUJ9ifGgIt9M4BnVnyygb+cRlC63P0f0+fISU1TuWVNomt5EJv83Yc/L9gXdeVZ5SWGxCgBX4f9j
 vyNLz9EsVPPqRBHu0QztfxweHST+kMfWLMzVJevN9cx7gqfxmv/+PxdmcwoLNEqeZwR1j2UgMrxLmP
 nxuRazZr/s5GTBPZafxixC4iOllKsMG1qY1XVko16VFJs3jJKE/DHCHy4sS7C8vKk4mcAOJkE23WSv
 t9vylzNJ+AyG53ZX3MELOEAzQfCrDgGmqZz5zMyngf9CEJGXsi9K1USOCJ59+X+7bgD9ewaeXGMD7/
 Bo9cMRdbTHLVb3EeDVaCMkbn+6PtnxgVn8raLgR8emWibVHRnPO9miHIrBoA==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

- Add specific config to enable:
  - MT8365 sound support
  - MT6357 audio codec support
- Add the mt8365 directory and all drivers under it.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 sound/soc/mediatek/Kconfig         | 20 ++++++++++++++++++++
 sound/soc/mediatek/Makefile        |  1 +
 sound/soc/mediatek/mt8365/Makefile | 15 +++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index 5a8476e1ecca..c1c86ecc0601 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -298,3 +298,23 @@ config SND_SOC_MT8195_MT6359
 	  boards with the MT6359 and other I2S audio codecs.
 	  Select Y if you have such device.
 	  If unsure select "N".
+
+config SND_SOC_MT8365
+	tristate "ASoC support for Mediatek MT8365 chip"
+	depends on ARCH_MEDIATEK
+	select SND_SOC_MEDIATEK
+	help
+	  This adds ASoC platform driver support for Mediatek MT8365 chip
+	  that can be used with other codecs.
+	  Select Y if you have such device.
+	  If unsure select "N".
+
+config SND_SOC_MT8365_MT6357
+	tristate "ASoC Audio driver for MT8365 with MT6357 codec"
+	depends on SND_SOC_MT8365 && MTK_PMIC_WRAP
+	select SND_SOC_MT6357
+	help
+	  This adds support for ASoC machine driver for Mediatek MT8365
+	  boards with the MT6357 codec.
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


