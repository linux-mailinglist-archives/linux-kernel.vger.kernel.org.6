Return-Path: <linux-kernel+bounces-553133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A77A58451
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 14:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 552B33AD315
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 13:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEB71DD894;
	Sun,  9 Mar 2025 13:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxErZIng"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168BC13AD05;
	Sun,  9 Mar 2025 13:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741527041; cv=none; b=N5UrgWm6+Bmm5+b/px0FC5vdLgUq98eusD8icuHtD1pAPu+XySIQCZ85I/VVVlH4CbP1w6/HC3Rs6x4yNdFuIdhM7u44sWyO8jhQMyaEN3ocaGCcTSapu5jSvjyDDOwxrg0pp/kiZwhRgYgbv0LPMlb3Kepqr9OhysvS5SFKOXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741527041; c=relaxed/simple;
	bh=KtoYCVFRdDBGt22qWMUCcP9r+LbYhDeld20HTnAPhbw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=nQkqnLpaLSLsmRhPAJ/fgl4OdQfNuZ3kLEGT5lv+iKgid/TkJjodkpzPOa2devmSYLl+uc5cKz3hLKgNTgDFYPfJ89Wdiklqmxy2uFMWlaEKfi8m2oxhKCkcdzqcwLnUYUnuUrH0NPpBYThz7PQmxvghQgCjQX+bX0DigLKBQwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxErZIng; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3913cf69784so1127016f8f.1;
        Sun, 09 Mar 2025 06:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741527038; x=1742131838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3IZp5z7nS232anPaIUnFqLxoHjUC4RU66ewstLpUgIU=;
        b=JxErZIngdHPCgDwVvjmPLiy3ywIe5NPc6hD4MpfB3kAFEzmmYLbWlX7/lfLFQ6kOQL
         Upp8gQo9E0exmQeViBIDlbqCOLWWcv9vVAASq44Gu1F7GGHAFvAaIcEb3EOkLlXHhMRX
         Wb+ziDiA1yivOnA+LS8gOKuy09zxPTyFtNTWg1pOZOKHKbMtMcbVZ6LgkbaEuhuWmaWl
         CUV4O/XiqViRms//FqbOhu7hlajmdMM+9/pZfle3K0KHA9G0JJE4nnFOrsoTGUu8zgxw
         jJDkloWg8paQzQoKnoo4EaDNQai5VHlX/H7CHCsHGRWIB2jDtb6fVM9VNBAdDPLYgIKy
         /PWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741527038; x=1742131838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3IZp5z7nS232anPaIUnFqLxoHjUC4RU66ewstLpUgIU=;
        b=sfWGZ5sIKKCszKdvoB+Q8CJKx5+ef0BLxLCAWhQLb5/Z5CQzuZJ/OpW0/YIEP+oXVt
         pAly14qDFL5P2yZp/cYJ5n6RbgYpR3+Jope+pFfJJ1DR5N6ax8mQULrX+aIIb/q77Pa2
         wjXVrYL17gTHxP4Q7cWtTbJNBvx4uu15g2HIj80X3xU8fe8S0vR+pYAz82/52kqd/gNz
         4mrd2CqUevIRijn83C1I4333BE8QIZSgPqLbR8whMKhnzwvO1LIwVYQy3e7DQ1+apC9D
         nmm6GdRAFv85fmsrunyF6j/ybCe3enaig+jCmR5XXAacaUha0r8evjiPr8yv3eDFx5FM
         6NLA==
X-Forwarded-Encrypted: i=1; AJvYcCV29lssPRfeHa/fe87kSOsz+YjcW8GXMpDSET/nhtil1Zq+RSi9rDlMPNGLf1tUIkPWK43Wn6tXuB74@vger.kernel.org, AJvYcCWFxu8GjywMj0Z00DKUvvN6qXM1eNhcEAE9UNk5cZ4PIyq7MRH15StehrU8xPBLCBUm3JDit7wSb9RE@vger.kernel.org, AJvYcCWM5AazYWSqP0nI1fY03a8wel+xwdsX9+C0E0VoF23djI/mChkIpIvcQO7oOVMJ0DTtaQXTaJA+bHxs@vger.kernel.org, AJvYcCXsatwIahUU7dKIgj3Gw7lJH/qAWbJPjSVhtjwoNX79xTFcpI7+EcB8kU7QuByQVbTd4Fi0T5z2KuIby4yG@vger.kernel.org
X-Gm-Message-State: AOJu0YxCcrMisfO6r/b2wxmwP397jFChabQUn3/6M1YgyL8MQ9ulr5p/
	MYHJUdyQ1BQQANBGMCDlmlw3J9U/urfKz4YuJf2fQ7bm+DOXrGWqbt4yqA==
X-Gm-Gg: ASbGncvcj2xXQvyZNwR/cZszM4QaKdBKckvag4jsbH7OQQBY9ynE6plT3UHc+6E+hQu
	/BR72px1gURTmOmUpeZGu+7Xh7xKsYhhzzWEvPeVPadGwtNcdjFNnndtDj1C6MjfEgzxrY5dRL1
	r4h1BVXX6XL/PfoXxBFkbiqFpXbBcT0HYJmnwqmSyg3CCalGADJYEoLaG6EG7WmDWwDN+pIWInh
	SI4fHucPuBsw79XSX7BVg0TSaBZnQkw++5Ym1Beamw1oNgquQ33+F4Y1kA+ve5Dae5SZ99Uw24x
	mk73kztnhAa5FNTcFgGTY25xeTCqA3632MbdahNKkvjN2h0WMETw5aOn/Vs2OQkBj1U++9r+/It
	K0TszYTZohKERWQ==
X-Google-Smtp-Source: AGHT+IEg/pmtwT7lVJCZK8BpVYZB76uZfLQXRI3/kWO/yuj5TZlAaT7OiGF/3WHcicI73lmrX/qPnw==
X-Received: by 2002:adf:cb01:0:b0:38f:3245:21fc with SMTP id ffacd0b85a97d-39132db1fdamr6602070f8f.50.1741527038019;
        Sun, 09 Mar 2025 06:30:38 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3912bee262esm11867536f8f.0.2025.03.09.06.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 06:30:37 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Danzberger <dd@embedd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Guo Ren <guoren@kernel.org>,
	Yangyu Chen <cyy@cyyself.name>,
	Ben Hutchings <ben@decadent.org.uk>,
	Felix Fietkau <nbd@nbd.name>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-usb@vger.kernel.org,
	upstream@airoha.com
Subject: [PATCH 00/13] airoha: en7581: clk cleanup + USB support
Date: Sun,  9 Mar 2025 14:29:31 +0100
Message-ID: <20250309132959.19045-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series implement all the changes required to correctly handle
USB support for the Airoha EN7581 SoC.

The first few patch are cleanup for the clock driver and the
introduction of the SCU SSR SoC driver.

The SoC always support USB 2.0 but for USB 3.0 it needs additional
configuration for the Serdes port. Such port can be either configured
for USB usage or for PCIe lines or HSGMII and these are configured
in the SCU space.

To correctly handle this, the SCU is changed to a simple-mfd
implemenetation and the clock controller updated to follow this new
node structure. Both implementation are supported to handle old
binding.

The xHCI USB is based on the Mediatek implementation but the PHY
handling although conceptually similar, is indded different compared
to Mediatek due to SSR checks and different port power up.

The SSR driver expose an API to poll the current status of the Serdes
port and the USB PHY driver validates it. Refer to the specific commit
for additional info.

Consider that there is currently an inconsistency as AN7581 and
EN7581 refer to the same thing. This is due to the fact that
the SoC born under EcoNet but then was acquired by Airoha.

Christian Marangi (13):
  clk: en7523: convert driver to regmap API
  clk: en7523: generalize register clocks function
  dt-bindings: soc: airoha: add SCU SSR Serdes port binding
  dt-bindings: soc: airoha: add Documentation for Airoha AN7581 SCU SSR
  dt-bindings: mfd: add Documentation for Airoha EN7581 SCU
  dt-bindings: clock: airoha: make reg optional for Airoha EN7581
  clk: en7523: support getting regmap from parent node for EN7581
  soc: airoha: add support for configuring SCU SSR Serdes port
  dt-bindings: phy: Add documentation for Airoha AN7581 USB PHY
  phy: airoha: Add support for Airoha AN7581 USB PHY
  usb: host: add ARCH_AIROHA in XHCI MTK dependency
  arm64: dts: airoha: en7581: convert SCU clock node to MFD
    implementation
  arm64: dts: airoha: en7581: add USB and SCU SSR nodes

 .../bindings/clock/airoha,en7523-scu.yaml     |  13 +-
 .../mfd/airoha,en7581-scu-sysctl.yaml         |  68 +++
 .../bindings/phy/airoha,an7581-usb-phy.yaml   | 106 ++++
 .../soc/airoha/airoha,an7581-scu-ssr.yaml     | 106 ++++
 MAINTAINERS                                   |  15 +
 arch/arm64/boot/dts/airoha/en7581.dtsi        |  74 ++-
 drivers/clk/clk-en7523.c                      | 258 ++++----
 drivers/phy/Kconfig                           |   1 +
 drivers/phy/Makefile                          |   3 +-
 drivers/phy/airoha/Kconfig                    |  13 +
 drivers/phy/airoha/Makefile                   |   3 +
 drivers/phy/airoha/phy-airoha-usb.c           | 554 ++++++++++++++++++
 drivers/soc/Kconfig                           |   1 +
 drivers/soc/Makefile                          |   1 +
 drivers/soc/airoha/Kconfig                    |  18 +
 drivers/soc/airoha/Makefile                   |   3 +
 drivers/soc/airoha/airoha-scu-ssr.c           | 195 ++++++
 drivers/usb/host/Kconfig                      |   2 +-
 include/dt-bindings/soc/airoha,scu-ssr.h      |  24 +
 include/linux/soc/airoha/airoha-scu-ssr.h     |  17 +
 include/linux/soc/soc/airoha-scu-ssr.h        |  17 +
 21 files changed, 1355 insertions(+), 137 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/airoha,en7581-scu-sysctl.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/airoha/airoha,an7581-scu-ssr.yaml
 create mode 100644 drivers/phy/airoha/Kconfig
 create mode 100644 drivers/phy/airoha/Makefile
 create mode 100644 drivers/phy/airoha/phy-airoha-usb.c
 create mode 100644 drivers/soc/airoha/Kconfig
 create mode 100644 drivers/soc/airoha/Makefile
 create mode 100644 drivers/soc/airoha/airoha-scu-ssr.c
 create mode 100644 include/dt-bindings/soc/airoha,scu-ssr.h
 create mode 100644 include/linux/soc/airoha/airoha-scu-ssr.h
 create mode 100644 include/linux/soc/soc/airoha-scu-ssr.h

-- 
2.48.1


