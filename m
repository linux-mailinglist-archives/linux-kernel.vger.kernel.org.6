Return-Path: <linux-kernel+bounces-538685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD35A49BE9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ADDC3AC1FA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F00126E63B;
	Fri, 28 Feb 2025 14:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mpLjnaz3"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF6C26B971
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740752724; cv=none; b=qyT18pq/M02Nz0/Wuen+NG9yCaZXTHUWOGP5IqgYGGdcNso5vYwzaR+uoLWMZdrQTQu99V8zr9pCsFTHOcqG87B0oj/G0Ld/ZA3F76ADIK0x0X6D2QMZhX7cKXT5wCDYLa3fF41aJBOtQgjp687EaZ2szJikMk1G7unIkzL6++I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740752724; c=relaxed/simple;
	bh=OD93U5dLFGEXTO1kuTl1runWg69809IBYyLtRqwrAoY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RLtmpV9pY5t++cMqQq/QO9ZzHP2T28k0r174m5ZbjFaSQe/W9KcfSWIPN1J35t90XWUTdRIJWNXQF98sZEHV/yT762ndve+M9/f77yJdjApPhIUbt9nJzhMbgbBMyu6zlk0nlXc4+1nTmSi5awJIwlm0vQz+JT8BiFqdCZk4C6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mpLjnaz3; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abbec6a0bfeso342906866b.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 06:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740752720; x=1741357520; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vFZdL+qGu3Kdlb1WY6EnuiLBqBXq0ImAyg3+u6p9lEQ=;
        b=mpLjnaz37u6hRW9CuZFaKCBU3y9dhSwUPzPJScEqe+wHOkNI2v+Ijrn8zOoYdcGfRq
         1bHzbg9wIbAQFz0VVY2yOFE7jQyAtrllsBMaGrI906reopsrWrlzNsWyPHBwqFlFWT/y
         HYqNdyG8wgUZyROov7LhhHOEu0Tvq4oSOWIl6vFt6h+ROIO4K0NMAnWALk9z0ceCEygX
         e1/z85RehL4FKMvgFPFPSHOSFh4G0ArEPI5QffgZkAjEieFQAs2mefZTNp/W+nhp9p6B
         FJMNT6C1wMnCvHMPvMyxvicm8jvRBfomgYWYn3XinTMi2Gpn06Zi5v77DJ9ntV7ps9f4
         iO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740752720; x=1741357520;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vFZdL+qGu3Kdlb1WY6EnuiLBqBXq0ImAyg3+u6p9lEQ=;
        b=q23n3ZaKGhNvv8yhWiliERIg4fEFHzqb2+7pDndNUNMyd3tZ0V9xKji0spe/bnG0Sw
         t0lreqSR6So1Hcg4eyzv39CmeEA3LDCos5cIihx6uz4R3BpNofkRqHNsIqncr4jS307n
         pomFSjRMRvPH256NhsR1kYk/MqX5v/ujwV9QsL9L9tipTb+myHsSpHOQ2DbDsjp3KWLb
         ta0VeB7YLjbBkaCiQWLWyYWmxyMvGKlmHJ7RMpzPTBOXvba58kJtB5/zXsQQ9+funLf3
         1CVUBzhhL2wvxTa2qs3WMnw65+0THvhfy++IkcvTHy6QoQkBgIDo2ml2X3sZgc3DkoJZ
         NGbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUotyqiCpnOgqD/DBe8GVB5akmh+Bi33utmX+wEuSnJUgIIDawUMaL1QPwCxEqAHiqKE/iAfF58hyRc9XQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPR9ZRcI2W3OfgwD6iviZvaP/rWLISbCBfFmCgBT4fSZvVb3Uz
	wh/7FxaqD3ylxACOjJ0QYxS1g1TrCM2VGRb7PLiA6hiVLedHlKMvvPLclGWwtao=
X-Gm-Gg: ASbGncvbipc8qROWTblUPGIZrI0rKPnuOaZmmsHp+8c5jwASUKM7EkWfZwfTmEGClc8
	Ea/ZgjgKNmABKnLXumKcRztBP6Rb3pfuqYQrhzkaj+NtmvpGfOjUy/jzqHyoF7s473VRa1MI5tD
	/b0a4VuFo83/HHXbjAt7LcXcHC52IxTwHjb3zlX25tP5c4bGorb/25u9YI7d/GAgs7EjLCo9P20
	gMopsQzUFthrM63weiebp9ajJRFEYUAApETG4xNPfPKP41hJHoyZG4vr0dQXk2DGf0THNK1pTUc
	r0EDThaQoc185pEUIBdyhY/TvDkbu1lTrLqEsaAXko7u7F2+ySOpHdHykZvn9EyXkkd/GEHcN0n
	v/GwRjoGRag==
X-Google-Smtp-Source: AGHT+IFyRz2Nj6++7qxonxO3Nf2WD5ZJe4f3ewJ3NG6rh/2TILHAfxTAqIAZeb/hWN4bQCpsEml6Ag==
X-Received: by 2002:a17:907:7851:b0:abf:425d:5d3 with SMTP id a640c23a62f3a-abf425d09bcmr105655966b.40.1740752719572;
        Fri, 28 Feb 2025 06:25:19 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c75bffcsm298754466b.143.2025.02.28.06.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 06:25:19 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v3 0/6] Maxim Integrated MAX77759 PMIC MFD-based drivers
Date: Fri, 28 Feb 2025 14:25:14 +0000
Message-Id: <20250228-max77759-mfd-v3-0-0c3627d42526@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEvHwWcC/3XMQQ7CIBCF4as0rMXAVCB15T2Mi6GFdhJbDBhS0
 /Tu0q7UxOV7yfcvLLlILrFztbDoMiUKUxn1oWLtgFPvOHVlMxCgBMCJjzgbY1TDR99xRDRYS5B
 WAyvkEZ2nec9db2UPlJ4hvvZ6ltv7J5QlFxys97X2TSeUutxpwhiOIfZsK2X41PpHQ9GolbMOb
 Cuw+dLrur4BB777OOcAAAA=
X-Change-ID: 20250224-max77759-mfd-aaa7a3121b62
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-hardening@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

Hi,

This series improves support for the Maxim Integrated MAX77759
companion PMIC for USB Type-C applications using the MFD framework.

This series must be applied in-order, due to interdependencies of some
of the patches:
* to avoid use of undocumented compatibles by the newly added drivers,
  the bindings are added first in this series
* patch 1 ("dt-bindings: gpio: add max77759 binding") also creates a
  new MAINTAINERS entry, including a wildcard match for the other
  bindings in this series
* patch 3 ("dt-bindings: mfd: add max77759 binding") references the
  bindings added in patch 1 and 2 and can not work if those aren't
  available
* patch 4 ("mfd: max77759: add Maxim MAX77759 core mfd driver") adds
  the core MFD driver, which also exposes an API to its leaf drivers
  and is used by patches 5 and 6
* patches 5 and 6 won't compile without patch 4

The MAX77759 PMIC includes Battery Charger, Fuel Gauge, temperature
sensors, USB Type-C Port Controller (TCPC), NVMEM, and a GPIO expander.

This PMIC is used on the Google Pixel 6 and 6 Pro (oriole / raven).

This series adds support for the top-level MFD device, the gpio, and
nvmem cells. Other components are excluded for the following reasons:

    While in the same package, Fuel Gauge and TCPC have separate and
    independent I2C addresses, register maps, interrupt lines, and
    aren't part of the top-level package interrupt hierarchy.
    Furthermore, a driver for the TCPC part exists already (in
    drivers/usb/typec/tcpm/tcpci_maxim_core.c).

    I'm leaving out temperature sensors and charger in this submission,
    because the former are not in use on Pixel 6 and I therefore can
    not test them, and the latter can be added later, once we look at
    the whole charging topic in more detail.

To make maintainers' work easier, I am planning to send the relevant
DTS and defconfig changes via a different series, unless everything
is expected to go via Lee's MFD tree in one series?

Cheers,
Andre'

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
Changes in v3:
- collect tags
- mfd: drop gpio-controller and gpio-cells, GPIO is provided by the
  child (Rob)
- gpio: drop duplicate init of 'handled' variable in irq handler
- gpio: use boolean with IRQ_RETVAL() (Linus)
- gpio: drop 'virq' variable inside irq handler to avoid confusion
  (Linus)
- gpio: drop assignment of struct gpio_chip::owner (Linus)
- Link to v2: https://lore.kernel.org/r/20250226-max77759-mfd-v2-0-a65ebe2bc0a9@linaro.org

Changes in v2:
- reorder bindings patches to avoid validation failures
- add dependency information to cover letter (Krzysztof)
- fix max77759_gpio_direction_from_control() in gpio driver
- gpio: drop 'interrupts' property from binding and sort properties
  alphabetically (Rob)
- nvmem: drop example from nvmem binding as the MFD binding has a
  complete one (Rob)
- nvmem: rename expected nvmem subdev nodename to 'nvmem-0' (Rob)
- mfd: add kernel doc
- mfd: fix an msec / usec typo
- mfd: error handling of devm_mutex_init (Christophe)
- whitespace fixes & tidy-ups (Christophe)
- Link to v1: https://lore.kernel.org/r/20250224-max77759-mfd-v1-0-2bff36f9d055@linaro.org

---
André Draszik (6):
      dt-bindings: gpio: add max77759 binding
      dt-bindings: nvmem: add max77759 binding
      dt-bindings: mfd: add max77759 binding
      mfd: max77759: add Maxim MAX77759 core mfd driver
      gpio: max77759: add Maxim MAX77759 gpio driver
      nvmem: max77759: add Maxim MAX77759 NVMEM driver

 .../bindings/gpio/maxim,max77759-gpio.yaml         |  44 ++
 .../devicetree/bindings/mfd/maxim,max77759.yaml    |  99 +++
 .../bindings/nvmem/maxim,max77759-nvmem.yaml       |  32 +
 MAINTAINERS                                        |  10 +
 drivers/gpio/Kconfig                               |  13 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-max77759.c                       | 524 +++++++++++++++
 drivers/mfd/Kconfig                                |  20 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/max77759.c                             | 737 +++++++++++++++++++++
 drivers/nvmem/Kconfig                              |  12 +
 drivers/nvmem/Makefile                             |   2 +
 drivers/nvmem/max77759-nvmem.c                     | 156 +++++
 include/linux/mfd/max77759.h                       |  98 +++
 14 files changed, 1749 insertions(+)
---
base-commit: 0226d0ce98a477937ed295fb7df4cc30b46fc304
change-id: 20250224-max77759-mfd-aaa7a3121b62

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


