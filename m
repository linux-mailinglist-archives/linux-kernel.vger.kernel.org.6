Return-Path: <linux-kernel+bounces-573016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 239E2A6D186
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 23:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B20B91887005
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 22:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D7A1D2F42;
	Sun, 23 Mar 2025 22:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ov4WAuiv"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D2D1AA791
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 22:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742769567; cv=none; b=Omn5KP5gM/EkROsr+fcCXm1gHIGyl0fWacUgts/KI6BI3rOkV3Be3mFXq/vsGHh5jx/N4KEFrZTf6bgtIZKxSDG/K9W5AwE1ged6cVdra0gHfrDakQvFauewQgRPMX3t/YJYL1L6lublkbFgIwmUgDkliqOwVtL2Ad0PhJOCsTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742769567; c=relaxed/simple;
	bh=U1GZBnGYY6r3HrMU5zOBLDnfgZt9wuKWeXJ20SinsfU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SR4/hRNOEHfk98NzTIXq3HOaDnOWdYX8vnYcFW14UitBhLPJm8323KYXK6PHXuYuYNFvPmbeFOv/g+qNbxXTEAOPIjPURDQNlL8weSAyYSkUvXYNJlvVpaZ8KO5knJybs0jPG1QU7JshmnxGG7Q8hTdCDWEvYKO4wekVFL8ye3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ov4WAuiv; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e5c7d6b96fso6683425a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 15:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742769564; x=1743374364; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y6iYtEOLzvKNxb4FZ4jikJpSxV66bWAZ5GgiMV3ROgo=;
        b=Ov4WAuivlVH0PIYzVtj6mPWZ6N70iuNP2THxrvuHuzRKdAWr9kRkQMWsMrVsCsfKhb
         8/umBd0FW63B7Ao2aSelPc3dF/taBnhomvETltm///wIhLhFDUWVwWqhBdd7VlWFnbid
         clkO2O3ybHWCrbcNujxaSw/qGPEOicfs69LvzEDkaLDZ6ChyF6TyQ9vV75WQcdPRfGYL
         NDs6ct6GfS4FPwtExuoI6h9c2Xd9cnrpegY0Tm8UkLahe9QjdYILRm3KRWOd0yV6RkG2
         gb6aGPqpjMDEEAlXs3tP8LdJhQSp/8OcpPRFkuu69PhyQM7SdB3qpxYKDPmSFtVPVzCI
         cfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742769564; x=1743374364;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y6iYtEOLzvKNxb4FZ4jikJpSxV66bWAZ5GgiMV3ROgo=;
        b=bE8YhX6Y0t5uGow7eODubQ3Frfq0F5dTrAJ/Y5rutylixoNg0ANKdcmGTHexIIKgbX
         xwjFax23uNVb78n536HSJNXQxUHPRkyOAKB1GyFmfly5Ds4im2Zt24t7EOOAhiQHYpqU
         9uC1mx2JpbQmvnvZEU3CIsv2yyrupAyiZwNtQ3ppAhIZpLGBk1pra0lmfwHvFt4lcA6d
         djL4BNwKCFkzuWVEUCb5PZ4626gHSP9CgEsOhnIfzOLTYrZJQ1hxcEwvd1ClZ8L6BHnG
         kQXzqy+SWd0LLPuDB8gzGqtZ7t2cvzc9LvndzD036+zWTHUlAOSS2KTNh9RnTZUVjtgK
         4JiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLOaFGg/4Gt6Ydz3hJ2X95RUE+hsXTvI6OPZVVkaMhxsMA+8CnNZ3v2jzOVBJiJBPIQ2b6OsIf00OF8gU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCpAAinJ/rnEcLi1+v6todWdzo4aTNyunkn1DPdvJ3bC8uzfgL
	NwY0n2WG45Jw6sJR9hBTHztfkhoG7JNTednd6BoHcL7D73d2t4njSKGcZEDQW8M=
X-Gm-Gg: ASbGncu30HTrR+tGy70Q5GrmBiUPT1Nm9f1OJFqQoSNlN41lh5YsqKnNbE9WQePI80C
	P3d56QRRQ5hhSIMHnlicXhbof/X/S27FWwVBRhX1d2tKjJK8hPH2jV7oYTYeu5BD8e+5BrJCaeI
	lJOJ16VCKDTBbQ3j57T7A2rBWkJjAx2YzLGpPCxqHgsGizYraV26jahrECFcjNBW1nIwdtUm6u/
	FGVX9d/EF0ZyjU6eOt26ZayribCeJ/4PDpy0UZhuXKQHi32hUM5Cux0Qam26wfZd6RB+dGCvHOc
	iwQC70MsWy8JKRbfk9PyfdOYIRcAOHnA9S3mQjS/iQ+9X32oCAQ0cJrB4ldNKk29IodTJnjG5pB
	oxhI6VYY93OUWjWux4IjzijGp1KVN
X-Google-Smtp-Source: AGHT+IEIOL0z5HA/hLP6WtRx6lJP7L04Jhc7tA0I6WD3ChE8RIO8/jUcJg4qby8Yzu9BdJqid0N+FA==
X-Received: by 2002:a17:906:478d:b0:ac3:b12c:b1f2 with SMTP id a640c23a62f3a-ac3f251ac58mr885252666b.35.1742769563641;
        Sun, 23 Mar 2025 15:39:23 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef86e44dsm559686666b.31.2025.03.23.15.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 15:39:23 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH 00/34] Samsung S2MPG10 PMIC MFD-based drivers
Date: Sun, 23 Mar 2025 22:39:16 +0000
Message-Id: <20250323-s2mpg10-v1-0-d08943702707@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJSN4GcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYyND3WKj3IJ0QwPd1DTTFMPUpBRjAxNjJaDqgqLUtMwKsEnRsbW1AEr
 g09xZAAAA
X-Change-ID: 20250321-s2mpg10-ef5d1ebd3043
To: Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

This series adds initial support for the Samsung S2MPG10 PMIC using the
MFD framework. This is a PMIC for mobile applications and is used on
the Google Pixel 6 and 6 Pro (oriole / raven).

*** dependency note ***

This depends on the Samsung ACPM driver in Linux next, and runtime
depends on some fixes for it:
https://lore.kernel.org/all/20250321-acpm-atomic-v1-0-fb887bde7e61@linaro.org/
https://lore.kernel.org/all/20250319-acpm-fixes-v2-0-ac2c1bcf322b@linaro.org/

*** dependency note end ***

+++ Kconfig update +++

There is a Kconfig symbol update in this series, because the existing
Samsung S2M driver has been split into core and transport (I2C & ACPM)
parts. CONFIG_MFD_SEC_CORE is now truly a core driver, and
the I2C code that was part of it is now enabled via CONFIG_MFD_SEC_I2C.

This was necessary because unlike the other S2M PMICs, S2MPG10 doesn't
talk via I2C, but via the Samsung ACPM firmware.

+++ Kconfig update end +++

This series must be applied in-order, due to interdependencies of some
of the patches. There are also various cleanup patches to the S2M
drivers. I've kept them ordered as:
  * DT bindings (patches 1 ... 2)
  * EXPORT_SYMBOL ACPM's devm_acpm_get_by_phandle() (patch 3)
  * S2M MFD prep for adding S2MPG10 to MFD core (patches 4 ... 11)
  * S2MPG10 core driver (patch 12)
  * S2M MFD cleanup patches (patches 14 ... 25)
  * S2MPG10 clock driver (patch 26)
  * S2M RTC prep for adding S2MPG10 (patch 27 ... 28)
  * S2MPG10 RTC driver (patch 29)
  * S2M RTC cleanup patches (patches 30 ... 33)

I realise these are many, but since some prep-work was required to be
able to add S2MPG anyway, I wanted to get the cleanup patches in as
well :-) Let me know if I should postpone them to a later date instead.

The S2MPG10 includes buck converters, various LDOs, power meters, RTC,
clock outputs, and additional GPIOs interfaces.

This series adds support in the top-level device driver, and for the
RTC and clock. Importantly, having the RTC driver allows to do a proper
reset of the system. Drivers or driver updates for the other components
will be added in future patches.

This will need a DT update for Oriole / Raven to enable this device. I
will send that out separately.

Cheers,
Andre'

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
André Draszik (34):
      dt-bindings: mfd: samsung,s2mps11: add s2mpg10
      dt-bindings: clock: samsung,s2mps11: add s2mpg10
      firmware: exynos-acpm: export devm_acpm_get_by_phandle()
      mfd: sec: drop non-existing forward declarations
      mfd: sec: sort includes alphabetically
      mfd: sec: update includes to add missing and remove superfluous ones
      mfd: sec: move private internal API to internal header
      mfd: sec: fix open parenthesis alignment (of_property_read_bool)
      mfd: sec: slightly rework runtime platform data allocation
      mfd: sec: split into core and transport (i2c) drivers
      defconfigs: rename CONFIG_MFD_SEC_CORE to CONFIG_MFD_SEC_I2C
      mfd: sec: add support for S2MPG10 PMIC
      mfd: sec: merge separate core and irq modules
      mfd: sec: sort struct of_device_id entries and the device type switch
      mfd: sec: use dev_err_probe() where appropriate
      mfd: sec: s2dos05/s2mpu05: use explicit regmap config
      mfd: sec: drop generic regmap config
      mfd: sec: s2dos05: doesn't support interrupts (it seems)
      mfd: sec: don't ignore errors from sec_irq_init()
      mfd: sec: rework platform data and regmap instantiating
      mfd: sec: change device_type to int
      mfd: sec: don't compare against NULL / 0 for errors, use !
      mfd: sec: use sizeof(*var), not sizeof(struct type_of_var)
      mfd: sec: convert to using MFD_CELL macros
      mfd: sec: convert to using REGMAP_IRQ_REG() macros
      clk: s2mps11: add support for S2MPG10 PMIC clock
      rtc: s5m: cache value of platform_get_device_id() during probe
      rtc: s5m: prepare for external regmap
      rtc: s5m: add support for S2MPG10 RTC
      rtc: s5m: fix a typo: peding -> pending
      rtc: s5m: switch to devm_device_init_wakeup
      rtc: s5m: replace regmap_update_bits with regmap_clear/set_bits
      rtc: s5m: replace open-coded read/modify/write registers with regmap helpers
      MAINTAINERS: add myself as reviewer for Samsung S2M MFD

 .../devicetree/bindings/clock/samsung,s2mps11.yaml |   1 +
 .../devicetree/bindings/mfd/samsung,s2mps11.yaml   |  34 +-
 MAINTAINERS                                        |   3 +-
 arch/arm/configs/exynos_defconfig                  |   2 +-
 arch/arm/configs/multi_v7_defconfig                |   2 +-
 arch/arm/configs/pxa_defconfig                     |   2 +-
 arch/arm64/configs/defconfig                       |   2 +-
 drivers/clk/clk-s2mps11.c                          |   8 +
 drivers/firmware/samsung/exynos-acpm.c             |   1 +
 drivers/mfd/Kconfig                                |  35 +-
 drivers/mfd/Makefile                               |   5 +-
 drivers/mfd/sec-acpm.c                             | 471 ++++++++++++++++++++
 drivers/mfd/sec-common.c                           | 284 ++++++++++++
 drivers/mfd/sec-core.c                             | 481 ---------------------
 drivers/mfd/sec-core.h                             |  32 ++
 drivers/mfd/sec-i2c.c                              | 259 +++++++++++
 drivers/mfd/sec-irq.c                              | 461 +++++++-------------
 drivers/rtc/rtc-s5m.c                              | 197 ++++++---
 include/linux/mfd/samsung/core.h                   |   7 +-
 include/linux/mfd/samsung/irq.h                    | 103 +++++
 include/linux/mfd/samsung/rtc.h                    |  37 ++
 include/linux/mfd/samsung/s2mpg10.h                | 310 +++++++++++++
 22 files changed, 1872 insertions(+), 865 deletions(-)
---
base-commit: c4d4884b67802c41fd67399747165d65c770621a
change-id: 20250321-s2mpg10-ef5d1ebd3043

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


