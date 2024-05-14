Return-Path: <linux-kernel+bounces-178417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFA78C4D4E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 09:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9FC428377D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 07:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068BE17999;
	Tue, 14 May 2024 07:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="fdx/36aN"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC91213ACC
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 07:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715673170; cv=none; b=AMJ5MydeI0UCX7dB4c/XpyzkePOvj5ZPLhIQZizrC5hQnwL3x6uMORarDhU1wSjs5FtEXBPHLPQlPjpw0CdHBKKyX2OoOCnAIZbfVayTjB+RCEzpyHExKDFGcj5MqW5tETmraZVq3S+JiC5JoqdAsxsjlnSdgwU76tbA8FZB9LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715673170; c=relaxed/simple;
	bh=OOaEOfAYR5Gh8oK5DJeYpeAymVXp+rXthUNYm11olFA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SKMcgVCkBV0Dzld4nnqf51j7muPEkE2IQIVOr39jk3fyviS8Fml+YYAxI+f9PSS1T4g+0qgDc0E+GMI4Ewm0yMWi33askV1NI/uzcuCGO0ehw3PL/78n4Ui2lPMGVZLHgtr4tXhL9EgTFuXJU8+orVNZ4wNwzz9gC+LR5mOInWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=fdx/36aN; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a5a2d0d8644so1111806466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 00:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1715673165; x=1716277965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RRbZom6ag8wZbaXN8JlgLAmY9gMu1rXQduqBeQbgtG0=;
        b=fdx/36aNHMQtj5SORgPbubr/7tgpKfA/OXn/XJx+ePYRMtCcwODwzTfsWCFcLnlnSw
         g9/0SHe3U016vRPqIcXtT6iJab/6zN3eVBhP4Q+FQ4F/9J+Se5Sr5i6+BDrLhioRLtRy
         mHuyazFtWx5C6LSff4QAq8oHI1sGafpPsAnpkCZYnRXjJFb20raviqHbe67bNKNboc1B
         N27HAmHJszNLpDxWJ4qo17o0Op1uG263uFwSyD5SBiRO/Gy34qsdgfsuvW3eZjMxoIQf
         aV8XYG+qJHqPf+i90p6aylzG4wDwxpscwslrJsLAnkOG+Oy3gQEknv92/c1PTTumI+kC
         MuKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715673165; x=1716277965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RRbZom6ag8wZbaXN8JlgLAmY9gMu1rXQduqBeQbgtG0=;
        b=saEOxCApjkCdTCe+uBxyehboVSB7q1NF+IkMEgqq/WKy0klMGhQWkChM9/BFQ36OTj
         7nfbNdVmMmr/1ohWAyL2c5VfUnjiMf3Jv3Owy4WhI6Em5qqd3+OlcPoB9ENWsNPKjYLs
         Z01fcq+OhwB0mY1Lgrkd5uPA4ARN3lZI7mGSK5h/NHjMk1zobRwLv0JdO1tkQm+l7OyQ
         cEoh0D9lfSi57yuoO+uWYBMedKOGxLxck1rjni9xJ632E2WOAWy5ZzhLPWta7ed9o51E
         tiho+OYGdkrmAhGaTGqdVC6QbYEa3KEKynupF89aat/bZorDZ/23Sn5imchUikNOL4Ew
         WJZw==
X-Forwarded-Encrypted: i=1; AJvYcCUiRpCK2Sijp0EAl6vuF89aQ2bRqjHqOxw26TPtfIh+0Y6mB7iv28gJXimRzSE+W2MLLWYRIPFbBe7fQ+fUG7INr/DhehSCKwF3hYbE
X-Gm-Message-State: AOJu0Yyq6XAKRLWBz9hKQeBEnm0xMt13Z1njxdwO+Z97roOWSNrwefTt
	2tm9wurWbSjOzlUcuNFGnquS22Nw22q5ul9zUUyAOPX6WNItJqZdZAbHcSzLboc=
X-Google-Smtp-Source: AGHT+IHEP9Pihcxscu5GOvum+xRZvm2vozKn++BTGhjVa2EM2uUdG259qd+sevlst3Pm2tIrgRrkMQ==
X-Received: by 2002:a17:906:b7d7:b0:a59:b02a:90e7 with SMTP id a640c23a62f3a-a5a2d6a1708mr884283066b.64.1715673165062;
        Tue, 14 May 2024 00:52:45 -0700 (PDT)
Received: from brgl-uxlite.. ([149.14.240.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a7b53fc8fsm99184866b.38.2024.05.14.00.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 00:52:44 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
X-Google-Original-From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] gpio: updates for v6.10-rc1
Date: Tue, 14 May 2024 09:52:43 +0200
Message-Id: <20240514075243.7008-1-bartosz.golaszewski@linaro.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

This was a quiet release cycle for the GPIO tree and so the main pull-request
is relatively small. We have one new driver, some minor improvements to the
GPIO core code and across several drivers, some DT and documentation updates
but in general nothing stands out or is controversial. All changes have spent
time in next with no reported issues (or ones that were quickly fixed).

Details are in the signed tag. Please consider pulling.

Best Regards,
Bartosz Golaszewski

The following changes since commit 39cd87c4eb2b893354f3b850f916353f2658ae6f:

  Linux 6.9-rc2 (2024-03-31 14:32:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-updates-for-v6.10-rc1

for you to fetch changes up to 7f45fe2ea3b8c85787976293126a4a7133b107de:

  gpio: nuvoton: Fix sgpio irq handle error (2024-05-07 09:44:33 +0200)

----------------------------------------------------------------
gpio updates for v6.10-rc1

GPIO core:
- remove more unused legacy interfaces (after converting the last remaining
  users to better alternatives)
- update kerneldocs
- improve error handling and log messages in GPIO ACPI code
- remove dead code (always true checks) from GPIOLIB

New drivers:
- add a driver for Intel Granite Rapids-D vGPIO

Driver improvements:
- use -ENOTSUPP consistently in gpio-regmap and gpio-pcie-idio-24
- provide an ID table for gpio-cros-ec to avoid a driver name fallback check
- add support for gpio-ranges for GPIO drivers supporting multiple GPIO banks
- switch to using dynamic GPIO base in gpio-brcmstb
- fix irq handling in gpio-npcm-sgpio
- switch to memory mapped IO accessors in gpio-sch

DT bindings:
- add support for gpio-ranges to gpio-brcmstb
- add support for a new model and the gpio-line-names property to gpio-mpfs

Documentation:
- replace leading tabs with spaces in code blocks
- fix typos

----------------------------------------------------------------
Aapo Vienamo (1):
      gpio: Add Intel Granite Rapids-D vGPIO driver

Andy Shevchenko (21):
      ARM: pxa: spitz: Open code gpio_request_array()
      ARM: sa1100: Open code gpio_request_array()
      gpiolib: legacy: Remove unused gpio_request_array() and gpio_free_array()
      gpiolib: Do not mention legacy GPIOF_* in the code
      gpio: wcove: Use -ENOTSUPP consistently
      gpio: crystalcove: Use -ENOTSUPP consistently
      gpiolib: acpi: Remove never true check in acpi_get_gpiod_by_index()
      gpiolib: acpi: Check for errors first in acpi_find_gpio()
      Documentation: gpio: Replace leading TABs by spaces in code blocks
      gpio: pcie-idio-24: Use -ENOTSUPP consistently
      gpio: regmap: Use -ENOTSUPP consistently
      gpio: sch: Switch to memory mapped IO accessors
      gpio: sch: Utilise temporary variable for struct device
      gpiolib: acpi: Extract __acpi_find_gpio() helper
      gpiolib: acpi: Simplify error handling in __acpi_find_gpio()
      gpiolib: acpi: Move acpi_can_fallback_to_crs() out of __acpi_find_gpio()
      gpiolib: acpi: Pass con_id instead of property into acpi_dev_gpio_irq_get_by()
      gpiolib: Get rid of never false gpio_is_valid() calls
      gpiolib: acpi: Add fwnode name to the GPIO interrupt label
      gpiolib: acpi: Set label for IRQ only lines
      gpiolib: Discourage to use formatting strings in line names

Bartosz Golaszewski (2):
      Merge tag 'v6.9-rc2' into gpio/for-next
      Merge tag 'intel-gpio-v6.10-1' of git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-gpio-intel into gpio/for-next

David Lechner (1):
      Documentation: gpio: fix typo

Doug Berger (4):
      gpio: brcmstb: Use dynamic GPIO base numbers
      dt-bindings: gpio: brcmstb: add gpio-ranges
      gpio: of: support gpio-ranges for multiple gpiochip devices
      gpio: brcmstb: add support for gpio-ranges

Jamie Gibbons (2):
      dt-bindings: gpio: mpfs: add coreGPIO support
      dt-bindings: gpio: mpfs: allow gpio-line-names

Jim Liu (1):
      gpio: nuvoton: Fix sgpio irq handle error

Peng Fan (1):
      gpiolib: use dev_err() when gpiod_configure_flags failed

Tzung-Bi Shih (1):
      gpio: cros-ec: provide ID table for avoiding fallback match

 .../bindings/gpio/brcm,brcmstb-gpio.yaml           |   3 +
 .../bindings/gpio/microchip,mpfs-gpio.yaml         |  17 +-
 Documentation/driver-api/gpio/driver.rst           |  28 +-
 Documentation/driver-api/gpio/legacy.rst           |  16 -
 .../translations/zh_CN/driver-api/gpio/legacy.rst  |  16 -
 Documentation/translations/zh_TW/gpio.txt          |  17 -
 .../userspace-api/gpio/gpio-v2-get-line-ioctl.rst  |   2 +-
 MAINTAINERS                                        |   1 +
 arch/arm/mach-pxa/spitz_pm.c                       |  22 +-
 arch/arm/mach-sa1100/h3600.c                       |  47 ++-
 drivers/gpio/Kconfig                               |  18 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-brcmstb.c                        |  21 +-
 drivers/gpio/gpio-cros-ec.c                        |   8 +
 drivers/gpio/gpio-crystalcove.c                    |   2 +-
 drivers/gpio/gpio-graniterapids.c                  | 383 +++++++++++++++++++++
 drivers/gpio/gpio-npcm-sgpio.c                     |  10 +-
 drivers/gpio/gpio-pca953x.c                        |   2 +-
 drivers/gpio/gpio-pcie-idio-24.c                   |   2 +-
 drivers/gpio/gpio-regmap.c                         |   4 +-
 drivers/gpio/gpio-sch.c                            |  35 +-
 drivers/gpio/gpio-wcove.c                          |   2 +-
 drivers/gpio/gpiolib-acpi.c                        |  65 ++--
 drivers/gpio/gpiolib-legacy.c                      |  49 +--
 drivers/gpio/gpiolib-of.c                          |  23 +-
 drivers/gpio/gpiolib-sysfs.c                       |   2 +-
 drivers/gpio/gpiolib.c                             |  26 +-
 drivers/gpio/gpiolib.h                             |   2 +-
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c |   2 +-
 drivers/pinctrl/pinctrl-cy8c95x0.c                 |   2 +-
 include/linux/acpi.h                               |   8 +-
 include/linux/gpio.h                               |  21 +-
 include/linux/gpio/driver.h                        |   4 +-
 33 files changed, 624 insertions(+), 237 deletions(-)
 create mode 100644 drivers/gpio/gpio-graniterapids.c

