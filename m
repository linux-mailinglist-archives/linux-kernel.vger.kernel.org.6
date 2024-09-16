Return-Path: <linux-kernel+bounces-330926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF9297A62D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 18:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12F3BB23BF3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C588158A3D;
	Mon, 16 Sep 2024 16:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIL3fDAc"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCFA1CAAC;
	Mon, 16 Sep 2024 16:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726505132; cv=none; b=tK2PxPfp6KB62jXALNLwwGnSDo7y9WoXnmjfe3SMKXfBZPeWztSwOSK7iNrpa1hkLyniDeIfrAqUa9ZGpruIkf3/9vYLNnvEEk/p3cITz++Hepvz0fVT1tgoULtUTDo82n2r76KEN63XFU/GJmw1e6Q3NPJSA+pNivlJ9x38ZOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726505132; c=relaxed/simple;
	bh=OvIxlpe8ikMzpVdHb8rBDe7URqZFOOlM1jBnV0YAe/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X+e+uga7t4R9lEyPpGph6vHke8hu4sM05Cz2Qx9la16yo+QA80CtCOEUDyJ9ODIkxN84/D5tnDiPPqr68JMPkMyUShfh9fPnUrI5dAi5hjlIO7ceILZIS6g7yN0pd7iFZ4UXivBSre7fLu3+Vrdwm2UwULfVkr+QSJ+t/Fx0ah4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIL3fDAc; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d87f34a650so3188410a91.1;
        Mon, 16 Sep 2024 09:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726505129; x=1727109929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=oSHt8ilshuMDwX3QcOoNb5eX0HzVZtUBnNZ4jBi3hts=;
        b=JIL3fDAczzPcEsfhoMPm1YnfJA9NivUhXPCLm3YqXoaKwXmDcmhMkDsruxqcpgBD0B
         01R/UvX3nKls9BoeOxQ9NY9DgQmcn8Tb5k/bf6b/efF/80MBXhbdkFJSZSTExrTDH1Fn
         VdTWCbXGhN/TxLSeFXnboBFDDuYj5RfrC6mLFXTBZMwaBNRejoOeeTS/AFxutl2y6RSM
         /1TFX39jnFfy48I+6e2PzPipbyS5dZFnidx+YQ8MyVchDfm61VObjVxlpCPNwWWHVP9K
         vtXjrBPgYfq7EnFSf6V15NmCSdJAQp5yxVfl26ltAy2SgQsxGMKGzcOfUwEwmLcK+4OC
         Xdqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726505129; x=1727109929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSHt8ilshuMDwX3QcOoNb5eX0HzVZtUBnNZ4jBi3hts=;
        b=GtR2KqGp5+M79ckIDm7yPIl59850qzEkATWp9bgUTpC9T2c4KK+FLkRtmv0Unto8bV
         HInlx+IQwaGzJzwDSC0UGoW5sfihgNLXh/XGa8l8AO9PxCsppi11SmZZHquBmTTN2LMZ
         bD9qDVo9o7Y944HmvRb/uQ00QcPukZgEId63fOu4Fj57ScqBpJDDOdxt3V8TaTRw+5rH
         alSVT8oDLVTRi17hcCdMK0PdfxBu16Dnc8SH+fCGcfceZm5e2Xz4Q3UsCL6J5lJAy0VM
         sMTGQkbtFgDV7+wYL1bGULB9mzCPyWr7j9mUO+BV6/G7jEp4ovuU2l0pquDVyLW3qozd
         JRhg==
X-Forwarded-Encrypted: i=1; AJvYcCULVgIZM6DsaI/kho0RxO377BA+lRSDtdQo9YTO0RzRZeovvSMvFcptuPd3vHa48WT36JP9YK7YUZyMWew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0a2E8wf0jPXcePXDEoB+ozCVj86FK/vgA42bbeOdaZb4hRTc+
	14/aHUNh3UcgvZTyQd1hg2BAV/OrBEkwzXNi5E9ImAJoomXlMAnjcXlNpA==
X-Google-Smtp-Source: AGHT+IEI7y/E+mGWgiRqdf5lRu/uApUotJ4tgFoLu1wq010TM1ISDLnHNbugqFDfQbIVbWLD7H5/Gw==
X-Received: by 2002:a17:90b:17c6:b0:2c9:7343:71f1 with SMTP id 98e67ed59e1d1-2db9fcb941cmr25917291a91.14.1726505128608;
        Mon, 16 Sep 2024 09:45:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbcfdc0850sm5408019a91.57.2024.09.16.09.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 09:45:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon updates for v6.12
Date: Mon, 16 Sep 2024 09:45:26 -0700
Message-ID: <20240916164526.1161583-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull hwmon updates for Linux v6.12 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.12

Thanks,
Guenter
------

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v6.12

for you to fetch changes up to 2cb4acf2140be8a4f299c0b887cc314845ef6ec8:

  hwmon: Remove devm_hwmon_device_unregister() API function (2024-09-13 07:27:36 -0700)

----------------------------------------------------------------
hwmon updates for v6.12

* New drivers

  - Driver for Sophgo SG2042 external hardware monitor

  - Thermal sensor driver for Surface Aggregator Module

* Added support to existing drivers

  - oxp-sensors: Support for multiple new devices.

  - nct6775: Added G15CF to ASUS WMI monitoring list

* Modernizations

  - ina2xx: Driver cleanup and update to use with_info API

  - lm92: Driver cleanup and update to use regmap and with_info API

  - lm95234: Driver cleanup and update to use regmap and with_info API

  - max1619: Driver cleanup and update to use regmap and with_info API

  - max1668: Driver cleanup and update to use regmap and with_info API

  - max6697: Driver cleanup and update to use regmap and with_info API

* API updates

  - Removed unused devm_hwmon_device_unregister() API function

* Other notable changes

  - Implement and use generic bus access delay for pmbus drivers

  - Use with scoped for each OF child loop in several drivers

  - Module unloading fixes for gsc-hwmon and ntc_thermistor drivers

  - Converted various drivers to use multi-byte regmap operations

  - adt7475: Improved devicetree based configuration

  - ltc2947: Move to firmware agnostic API

  - ltc2978: Converted devicetree description to yaml

  - max16065: Addressed overflows when writing limit attributes

* Various other minor cleanups, fixes and improvements

----------------------------------------------------------------
Andy Shevchenko (2):
      hwmon: (sht21) Use %*ph to print small buffer
      hwmon: (sch5636) Print unknown ID in error string via %*pE

Armin Wolf (1):
      hwmon: (dell-smm) Add Dell Latitude 7320 to fan control whitelist

Chanh Nguyen (1):
      dt-bindings: hwmon: Add maxim max31790

Chris Packham (3):
      dt-bindings: hwmon: Add adt7475 fan/pwm properties
      dt-bindings: hwmon: adt7475: Deprecate adi,pwm-active-state
      hwmon: (adt7475) Add support for configuring initial PWM state

Christophe JAILLET (1):
      hwmon: (pmbus/mpq7932) Constify struct regulator_desc

Cryolitia PukNgae (1):
      hwmon: (oxp-sensors) Fix typo in driver documentation

Denis Pauk (1):
      hwmon: (nct6775) add G15CF to ASUS WMI monitoring list

Derek J. Clark (1):
      hwmon: (oxp-sensors) Add support for multiple new devices.

Frank Li (1):
      dt-bindings: hwmon: Convert ltc2978.txt to yaml

Guenter Roeck (56):
      hwmon: (adt7470) Use multi-byte regmap operations
      hwmon: (tmp401) Use multi-byte regmap operations
      hwmon: (lm95245) Use multi-byte regmap operations
      hwmon: (nct7802) Use multi-byte regmap operations
      hwmon: (adt7x10) Use multi-byte regmap operations
      hwmon: (tmp464) Use multi-byte regmap operations
      hwmon: (max6639) Use multi-byte regmap operations
      hwmon: (amc6821) Use multi-byte regmap operations
      hwmon: (lm95234) Reorder include files to be in alphabetic order
      hwmon: (lm95234) Use find_closest to find matching update interval
      hwmon: (lm95234) Convert to use regmap
      hwmon: (lm95234) Convert to with_info hwmon API
      hwmon: (lm95234) Add support for tempX_enable attribute
      hwmon: (lm95234) Use multi-byte regmap operations
      hwmon: (max16065) Fix overflows seen when writing limits
      hwmon: (max16065) Fix alarm attributes
      hwmon: (max6697) Reorder include files
      hwmon: (max6697) Drop platform data support
      hwmon: (max6697) Use bit operations where possible
      hwmon: (max6697) Convert to use regmap
      hwmon: (max6697) Convert to with_info hwmon API
      hwmon: (max6697) Add support for tempX_min and tempX_min_alarm
      hwmon: (max1668) Reorder include files to alphabetic order
      hwmon: (max1668) Use BIT macro
      hwmon: (max1668) Convert to use regmap
      hwmon: (max1668) Replace chip type with number of channels
      hwmon: (max1668) Convert to use with_info hwmon API
      hwmon: (max6697) Document discrepancy in overtemperature status bit values
      hwmon: (max1619) Clamp temperature range when writing limits
      hwmon: (max1619) Reorder include files to alphabetic order
      hwmon: (max1619) Mask valid alarm bits
      hwmon: (max1619) Convert to use regmap
      hwmon: (max1619) Convert to with_info API
      hwmon: (max1619) Add support for update_interval attribute
      hwmon: (max1619) Improve chip detection code
      hwmon: (lm92) Improve auto-detection accuracy
      hwmon: (lm92) Reorder include files to alphabetic order
      hwmon: (lm92) Replace chip IDs with limit register resolution
      hwmon: (lm92) Convert to use regmap
      hwmon: (lm92) Convert to with_info hwmon API
      hwmon: (lm92) Update documentation
      hwmon: (ina2xx) Reorder include files to alphabetic order
      hwmon: (ina2xx) Replace platform data with device properties
      hwmon: (ina2xx) Use bit operations
      hwmon: (ina2xx) Mark regmap_config as const
      hwmon: (ina2xx) Use local regmap pointer if used more than once
      hwmon: (ina2xx) Re-initialize chip using regmap functions
      hwmon: (ina2xx) Fix various overflow issues
      hwmon: (ina2xx) Consolidate chip initialization code
      hwmon: (ina2xx) Set alert latch
      hwmon: (ina2xx) Move ina2xx_get_value()
      hwmon: (ina2xx) Convert to use with_info hwmon API
      hwmon: (ina2xx) Pass register to alert limit write functions
      hwmon: (ina2xx) Add support for current limits
      hwmon: (ina2xx) Use shunt voltage to calculate current
      hwmon: Remove devm_hwmon_device_unregister() API function

Inochi Amaoto (2):
      dt-bindings: hwmon: Add Sophgo SG2042 external hardware monitor support
      hwmon: Add sophgo SG2042 external hardware monitor support

Javier Carrasco (2):
      hwmon: (ltc2992) use device_for_each_child_node_scoped() to access child nodes
      hwmon: (chipcap2) Drop cc2_disable() in the probe and return dev_err_probe()

Jinjie Ruan (8):
      hwmon: (aspeed-g6-pwm-tacho): Simplify with scoped for each OF child loop
      hwmon: (aspeed-pwm-tacho): Simplify with scoped for each OF child loop
      hwmon: (ina3221): Simplify with scoped for each OF child loop
      hwmon: (lm90): Simplify with scoped for each OF child loop
      hwmon: (nct7802): Simplify with scoped for each OF child loop
      hwmon: (npcm750-pwm-fan): Simplify with scoped for each OF child loop
      hwmon: (tmp421): Simplify with scoped for each OF child loop
      hwmon: (tmp464): Simplify with scoped for each OF child loop

Johannes Kirchmair (1):
      hwmon: (pwmfan) Do not force disable pwm controller

Liao Chen (1):
      hwmon: (gsc-hwmon) fix module autoloading

Mario Limonciello (1):
      hwmon: (k10temp): Use cpu_feature_enabled() for detecting zen

Maximilian Luz (1):
      hwmon: Add thermal sensor driver for Surface Aggregator Module

Nathan Chancellor (1):
      hwmon: (oxp-sensors) Add missing breaks to fix -Wimplicit-fallthrough with clang

Nuno Sa (1):
      hwmon: (ltc2947) Move to firmware agnostic API

Patrick Rudolph (5):
      hwmon: pmbus: Implement generic bus access delay
      hwmon: pmbus: max15301: Use generic code
      hwmon: pmbus: ucd9000: Use generic code
      hwmon: pmbus: zl6100: Use generic code
      hwmon: pmbus: pli12096bc: Add write delay

Rob Herring (Arm) (2):
      hwmon: (vexpress) Use of_property_present()
      hwmon: (stts751) Add "st" vendor prefix to "stts751" compatible string

Shen Lichuan (1):
      hwmon: (pc87360) Use min() macro

Yue Haibing (1):
      hwmon: (sch5627) Remove unused declaration sch56xx_watchdog_unregister()

Yuntao Liu (1):
      hwmon: (ntc_thermistor) fix module autoloading

 .../devicetree/bindings/hwmon/adt7475.yaml         |  37 +-
 .../devicetree/bindings/hwmon/lltc,ltc2978.yaml    |  94 +++
 .../devicetree/bindings/hwmon/ltc2978.txt          |  62 --
 .../devicetree/bindings/hwmon/maxim,max31790.yaml  |  70 ++
 .../bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml    |  43 +
 Documentation/hwmon/hwmon-kernel-api.rst           |   7 -
 Documentation/hwmon/ina2xx.rst                     |   4 +
 Documentation/hwmon/index.rst                      |   1 +
 Documentation/hwmon/lm92.rst                       |  26 +-
 Documentation/hwmon/max1619.rst                    |   4 -
 Documentation/hwmon/oxp-sensors.rst                |  56 +-
 Documentation/hwmon/sg2042-mcu.rst                 |  78 ++
 MAINTAINERS                                        |   6 +
 drivers/hwmon/Kconfig                              |  26 +-
 drivers/hwmon/Makefile                             |   2 +
 drivers/hwmon/adt7470.c                            |  22 +-
 drivers/hwmon/adt7475.c                            | 130 +++
 drivers/hwmon/adt7x10.c                            |  18 +-
 drivers/hwmon/amc6821.c                            |  30 +-
 drivers/hwmon/aspeed-g6-pwm-tach.c                 |   4 +-
 drivers/hwmon/aspeed-pwm-tacho.c                   |   8 +-
 drivers/hwmon/chipcap2.c                           |  33 +-
 drivers/hwmon/dell-smm-hwmon.c                     |   8 +
 drivers/hwmon/gsc-hwmon.c                          |   1 +
 drivers/hwmon/hwmon.c                              |  18 -
 drivers/hwmon/ina2xx.c                             | 895 +++++++++++---------
 drivers/hwmon/ina3221.c                            |   7 +-
 drivers/hwmon/k10temp.c                            |  26 +-
 drivers/hwmon/lm90.c                               |   7 +-
 drivers/hwmon/lm92.c                               | 457 +++++++----
 drivers/hwmon/lm95234.c                            | 869 ++++++++------------
 drivers/hwmon/lm95245.c                            | 110 +--
 drivers/hwmon/ltc2947-core.c                       |  20 +-
 drivers/hwmon/ltc2992.c                            |  19 +-
 drivers/hwmon/max16065.c                           |  17 +-
 drivers/hwmon/max1619.c                            | 495 ++++++-----
 drivers/hwmon/max1668.c                            | 487 ++++-------
 drivers/hwmon/max6639.c                            |  40 +-
 drivers/hwmon/max6697.c                            | 907 +++++++++------------
 drivers/hwmon/nct6775-platform.c                   |   1 +
 drivers/hwmon/nct7802.c                            |  69 +-
 drivers/hwmon/npcm750-pwm-fan.c                    |   5 +-
 drivers/hwmon/ntc_thermistor.c                     |   1 +
 drivers/hwmon/oxp-sensors.c                        | 301 ++++++-
 drivers/hwmon/pc87360.c                            |   2 +-
 drivers/hwmon/pmbus/max15301.c                     |  92 +--
 drivers/hwmon/pmbus/mpq7932.c                      |   2 +-
 drivers/hwmon/pmbus/pli1209bc.c                    |  26 +-
 drivers/hwmon/pmbus/pmbus.h                        |  10 +
 drivers/hwmon/pmbus/pmbus_core.c                   |  92 ++-
 drivers/hwmon/pmbus/ucd9000.c                      |  64 +-
 drivers/hwmon/pmbus/zl6100.c                       |  66 +-
 drivers/hwmon/pwm-fan.c                            |  11 +-
 drivers/hwmon/sch5636.c                            |   3 +-
 drivers/hwmon/sch56xx-common.h                     |   1 -
 drivers/hwmon/sg2042-mcu.c                         | 388 +++++++++
 drivers/hwmon/sht21.c                              |   5 +-
 drivers/hwmon/stts751.c                            |   2 +-
 drivers/hwmon/surface_temp.c                       | 235 ++++++
 drivers/hwmon/tmp401.c                             |  17 +-
 drivers/hwmon/tmp421.c                             |   7 +-
 drivers/hwmon/tmp464.c                             |  40 +-
 drivers/hwmon/vexpress-hwmon.c                     |   2 +-
 include/linux/hwmon.h                              |   1 -
 include/linux/platform_data/max6697.h              |  33 -
 65 files changed, 3740 insertions(+), 2880 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/lltc,ltc2978.yaml
 delete mode 100644 Documentation/devicetree/bindings/hwmon/ltc2978.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml
 create mode 100644 Documentation/hwmon/sg2042-mcu.rst
 create mode 100644 drivers/hwmon/sg2042-mcu.c
 create mode 100644 drivers/hwmon/surface_temp.c
 delete mode 100644 include/linux/platform_data/max6697.h

