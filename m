Return-Path: <linux-kernel+bounces-203870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D30678FE179
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A56A1F23020
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3350D3A1A8;
	Thu,  6 Jun 2024 08:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F9sgvBJ3"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15032137C37
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717663703; cv=none; b=RRiTmQgTFR+rX+kQb6DhkMxMSXuB/JRb7/j2HA+lWUnac7fnLxxAKleORTzOJqEUteMInGV1gIK0i1j4+fdBEwAtbk+1Wnd516vuQnOTTbCz/1St53aBS5KasKv79LR+jsKzUdEAjLD+Yg/wZEjBIWjwpYFk0DUGpzRBTHKQHg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717663703; c=relaxed/simple;
	bh=Z0NNIzHhaWZJ143ndEEsLQVnT+L4J/ae06XwwJbYU10=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=K2go3sYBXE6Z0MhftzxXZa1fMyDstD6nMSiodvLVaP422BA1aOMU25bN2Gq56NU0AgHCcYmmTdGlQetv+nHi2QBvNqyHWRs58YjGzetCyB00MlGIjxK7RWaLSNP8P5Q66N5kJx44YsDi7h0aJmQOmRo/AEYmgCaamKu4ourJ63o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F9sgvBJ3; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52b8e0e98adso1061670e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 01:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717663696; x=1718268496; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=clNoI1HZOlvZDlF+a49KVrl+gXHl7hyV1SfXg3I8Hww=;
        b=F9sgvBJ3gWwd3vTWHdH0WueAylly1azgGoaJVHe1Pwe6bQIIRrxNoO2L9LVduFbnvC
         0j0T8dbJk1QruJFpgGPnrfJMu9yxz87uo/Yi++eneaM0kEezmWdDkALXpF3litgBTAKr
         X2Y4CKBb462apv1hx4auDXaUGI9/bMzzVJFOENH/JmlzswucjS7wOdFsun4JagvUynsF
         Nvo2wGI39U2a3z8JYEohMcS/KCKTp0k1mtkgoMb3tTOI5ss3hq4SgrRfNQwxSDdseuOO
         7TJaYFHbYGsgT879hzmv1C3/xRi1bwILILemSYDgi1kfLMUFffaXzuZuppkPeCLSNolW
         xCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717663696; x=1718268496;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=clNoI1HZOlvZDlF+a49KVrl+gXHl7hyV1SfXg3I8Hww=;
        b=e2VvS/aIcbG072G+EptZeLrypeESvAMqYg4mwNaYGIymdjVqeP8WRlWJlocI6rIH8+
         +ryfKWY/WkNiddyyfeXOas06fZOvEAu6yPRN/qN2Tw2zqO7LDIs47ZlcOMAFmwlI8yvs
         zJR6v7fmp/De+MbdC9tHN7VO8pk+fj79wxOtAS7C7/hZ1p0fngIQGLFMTl5kDOxFnl5v
         6cYRY+DVidKc0grztWV7wolDXXKKRI5kEWycdlVS5Fn/ZZd6TuOt5kbbz/nzppBh+P19
         xR7d1wbeTbNKEc+3N7aQs+U3/hmlZeIX4R2gR3GpibK4XGttNifBc4jF7/3/qMcGMC0Z
         WtKw==
X-Forwarded-Encrypted: i=1; AJvYcCVtj5WWCZQjMqff4fB41W2cFwKhXZtjJmxJOEP0D+shC9cmuiMidLLR72gPu4XVZYz5gNnOlZdtrlFwlbkhAC87xazn2tW3N9PfwjrN
X-Gm-Message-State: AOJu0YwkMXX2gxTzlyJLIw/UHPALFA3yqHqeNiwP3GAM9K2fNeCFM+YZ
	c19dYB6G7Bq/TeHhwwD08XkfKqo3m6iPmfobOTqhy+v8SS/yE6GjgPp04HVtSbQVUrjcWKutyAR
	c
X-Google-Smtp-Source: AGHT+IG/yuLE8o9z5rgP9gmN4unUSaVfCH4FIg5olqMGVJEGljKPXUFa/spz1zuCEqFtz/oo7RbWcQ==
X-Received: by 2002:a05:6512:614:b0:52b:8610:a7e9 with SMTP id 2adb3069b0e04-52bab509c6cmr2931872e87.62.1717663696062;
        Thu, 06 Jun 2024 01:48:16 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c2c690dsm14227445e9.34.2024.06.06.01.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 01:48:15 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 00/12] arm64: meson: bunch of DT fixes, take 4 (final one
 ??)
Date: Thu, 06 Jun 2024 10:48:07 +0200
Message-Id: <20240606-topic-amlogic-upstream-bindings-fixes-dts-v1-0-62e812729541@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMd3YWYC/x2MQQoCMQwAv7LkbKDWbgW/Ih7iNtaA25amirDs3
 w2ehmFgNlDuwgqXaYPOH1GpxeR4mGB5UsmMkszBOx9cdBFHbbIgra+aje+mozOteJeSpGTFh3x
 ZMQ3FSPPZU5rDyQewX+v8j7a73vb9ByxXC697AAAA
To: Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6130;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Z0NNIzHhaWZJ143ndEEsLQVnT+L4J/ae06XwwJbYU10=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmYXfJOh1HVavEBIRhO4ENEnVQkyDOfpbdd/oGJ13K
 kSxAAcmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZmF3yQAKCRB33NvayMhJ0c4lD/
 9TuwdUpGz16RXXBi7HFVOXHBvWhlCIdtkewCvf/dxxRj+RGof6VXA9ekyfV3xZ+xMaOomyebezNkEy
 yCUPsVz4Y1gfxmT+A+8uJZujmflqTEABsMQCuhTXLVLQz3HiK6i8Mz+QbWSBGWAu14MnIupvQ94cZG
 dZrukB4XCed/JKJofENpcCPUz3Wvskz/7w/+n7WkApQymXtziTbj8RPmznHGrD5rfeYYrHR9SDX/n0
 jdoVzCqCI5C1U6Jkkn8njJAFCSEm/sP0m+3Kr76KTaTKhNzqMp1GWCAa9Pd4Sn4DOPIPRZ5x754Dp1
 zfoTHtmz6h7+7gGMYp24mlgMUmeR2RGFt5hJpDa/t0+vKnpzlm9UdPefLfQKmqFblHBvVKApPnfYKt
 fjpWMP/y1BJjKKeixTu7LhV8h9BYo52AHek88qE7OzaRDk19NGkF5lAV63fteD/gz99leLuU1+VVYs
 +H6hmw8HUoOKJaeheAobVQTLPChNaTo4MDke2K/3kK6lXieUltS1sc1j11WyoY3cU+o96+zjUQT2Va
 kbanoG/IE2qcNT/fzY7tJMSgBdf64EQLr9JazZspEXMT2O22cZyWPIW9vDSnFQXbX4EexWrOQDxE+D
 mGReQwAtAt5gJjm0yCGXw7fLtY/+SpL7fza3hp8uRupH1ryf5o77W307Y+nQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Along with the following:
- https://lore.kernel.org/all/20240422-t7-reset-v2-1-cb82271d3296@amlogic.com/
- https://lore.kernel.org/all/20240513224552.800153-1-jan.dakinevich@salutedevices.com/
- https://lore.kernel.org/all/20240605-topic-amlogic-upstream-bindings-fixes-power-domains-spifc-v1-1-380f29ba4a16@linaro.org/
- https://lore.kernel.org/all/20240605-topic-amlogic-upstream-bindings-convert-spdif-receiver-v1-1-262465adbac2@linaro.org/
- https://lore.kernel.org/all/20240605-topic-amlogic-upstream-bindings-fixes-power-domains-mmc-v1-1-4acbb8cc2626@linaro.org/
- https://lore.kernel.org/all/20240605-topic-amlogic-upstream-bindings-fixes-power-domains-nvmem-v1-1-ef6f10c86a63@linaro.org/
- https://lore.kernel.org/all/20240605-topic-amlogic-upstream-bindings-fixes-power-domains-phy-v1-1-c819b0ecd8c8@linaro.org/
- https://lore.kernel.org/all/20240605-topic-amlogic-upstream-bindings-fixes-power-domains-rng-v1-1-0a55a7ba55e4@linaro.org/
- https://lore.kernel.org/all/20240605-topic-amlogic-upstream-bindings-fixes-audio-widgets-v1-1-65bd7cc2e09b@linaro.org/
- https://lore.kernel.org/all/20240605-topic-amlogic-upstream-bindings-fixes-power-domains-sardac-v1-1-40a8de6baa59@linaro.org/
- https://lore.kernel.org/all/20240606-topic-amlogic-upstream-bindings-convert-g12a-tohdmitx-v2-1-70d44fa30790@linaro.org/

this bunch of changes fixes 99% of the remaining dts check errors.

The two remaining bindings conversions for arm64/amlogic are:
- ti,tas5707
- everest,es7241

I'm too lazy to do them right now, so if someone is interested
in doing the conversion, please do it!

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (12):
      arm64: dts: amlogic: meson-g12b-bananapi: remove invalid fan on wrong pwm_cd controller
      arm64: dts: amlogic: move ao_pinctrl into aobus
      arm64: dts: amlogic: move assigned-clocks* from sound to clkc_audio node
      arm64: dts: amlogic: sm1: fix tdm audio-controller clock order
      arm64: dts: amlogic: sm1: fix tdm controllers compatible
      arm64: dts: amlogic: g12a-u200: drop invalid sound-dai-cells
      arm64: dts: amlogic: g12a-u200: add missing AVDD-supply to acodec
      arm64: dts: amlogic: axg: fix tdm audio-controller clock order
      arm64: dts: amlogic: c3: use correct compatible for gpio_intc node
      arm64: dts: amlogic: a1: use correct node name for mmc controller
      arm64: dts: amlogic: a1: drop the invalid reset-name for usb@fe004400
      arm64: dts: amlogic: gxbb-odroidc2: fix invalid reset-gpio property

 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi        |   3 +-
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi          |   3 +-
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts     |  17 +-
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi         |  24 +-
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi  | 427 ++++++++++-----------
 arch/arm64/boot/dts/amlogic/meson-g12a-fbx8am.dts  |  16 +-
 .../boot/dts/amlogic/meson-g12a-radxa-zero.dts     |  16 +-
 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts  |  16 +-
 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts    |  18 +-
 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts |  16 +-
 .../dts/amlogic/meson-g12b-bananapi-cm4-cm4io.dts  |  18 +-
 .../meson-g12b-bananapi-cm4-mnt-reform2.dts        |  18 +-
 .../boot/dts/amlogic/meson-g12b-bananapi.dtsi      |  30 +-
 .../arm64/boot/dts/amlogic/meson-g12b-gsking-x.dts |  16 +-
 .../boot/dts/amlogic/meson-g12b-gtking-pro.dts     |  16 +-
 arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts  |  16 +-
 .../dts/amlogic/meson-g12b-odroid-go-ultra.dts     |  16 +-
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dtsi     |  18 +-
 .../boot/dts/amlogic/meson-g12b-odroid-n2l.dts     |  18 +-
 .../boot/dts/amlogic/meson-g12b-radxa-zero2.dts    |  16 +-
 .../boot/dts/amlogic/meson-g12b-ugoos-am6.dts      |  16 +-
 .../boot/dts/amlogic/meson-gx-libretech-pc.dtsi    |  17 +-
 .../arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi |  18 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts |  17 +-
 .../boot/dts/amlogic/meson-gxbb-nanopi-k2.dts      |  17 +-
 .../boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts    |  17 +-
 .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts |  19 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts    |  17 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts    |  17 +-
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi      |  17 +-
 .../boot/dts/amlogic/meson-gxbb-wetek-hub.dts      |  17 +-
 .../boot/dts/amlogic/meson-gxbb-wetek-play2.dts    |  17 +-
 .../dts/amlogic/meson-gxl-s805x-libretech-ac.dts   |  17 +-
 .../boot/dts/amlogic/meson-gxl-s805x-p241.dts      |  17 +-
 .../dts/amlogic/meson-gxl-s905x-khadas-vim.dts     |  17 +-
 .../amlogic/meson-gxl-s905x-libretech-cc-v2.dts    |  17 +-
 .../dts/amlogic/meson-gxl-s905x-libretech-cc.dts   |  17 +-
 .../boot/dts/amlogic/meson-gxl-s905x-p212.dts      |  17 +-
 .../boot/dts/amlogic/meson-gxm-khadas-vim2.dts     |  17 +-
 .../arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts |  17 +-
 arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts |  17 +-
 arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi |  16 +-
 .../dts/amlogic/meson-libretech-cottonwood.dtsi    |  16 +-
 .../boot/dts/amlogic/meson-sm1-a95xf3-air-gbit.dts |  16 +-
 .../boot/dts/amlogic/meson-sm1-a95xf3-air.dts      |  16 +-
 .../boot/dts/amlogic/meson-sm1-bananapi-m2-pro.dts |  16 +-
 .../boot/dts/amlogic/meson-sm1-bananapi-m5.dts     |  16 +-
 arch/arm64/boot/dts/amlogic/meson-sm1-h96-max.dts  |  16 +-
 arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi  |  16 +-
 arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts   |  16 +-
 .../boot/dts/amlogic/meson-sm1-x96-air-gbit.dts    |  16 +-
 arch/arm64/boot/dts/amlogic/meson-sm1-x96-air.dts  |  16 +-
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi         |  36 +-
 53 files changed, 679 insertions(+), 630 deletions(-)
---
base-commit: c3f38fa61af77b49866b006939479069cd451173
change-id: 20240606-topic-amlogic-upstream-bindings-fixes-dts-6a572ad54324

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


