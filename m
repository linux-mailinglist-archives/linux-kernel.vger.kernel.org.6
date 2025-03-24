Return-Path: <linux-kernel+bounces-574585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C54A6E729
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 00:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A5C018988CD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 23:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E321EE7BB;
	Mon, 24 Mar 2025 23:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvI5xC3O"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B9519C55E;
	Mon, 24 Mar 2025 23:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742858115; cv=none; b=cRwQCeEGmToGH05wT9aAxgs7irDbbJeETYFbj6MPvn4sMnhPiODNqhMPaRmP4+FpYjY58Helj0j+ycmyHKrb2KyhMz46y3qkwEUyx0M6GwhgqTgQyroXb8yEEYpuqaCm/xvFZxfKEm7Lr/yYUV+vkpWGC0+0k3sxu6ZDIOGEkgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742858115; c=relaxed/simple;
	bh=XvxHMNAobexE3Le9lvv2TcboGXtijc21Z4dqIp005zw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gAm02bAlE24rU5tcD/Nq3ZqF+8DwTtiVd76zBuAn2jdFaBv7Js72DaCSJMy19MeRICrNF+2L9lYJ3w09kqyPGCW4ku/XIenGWtYQsN8QBq1UNn5sSXXgxcnTCuieu4Gjh4CIzA6kYr76pthkurnWkqLAFyoOmW5ayKc3bjorm1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvI5xC3O; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2243803b776so22817065ad.0;
        Mon, 24 Mar 2025 16:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742858112; x=1743462912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=uDEAne1cqLXWRxcsGCLmK1sN5PHZYlDqyUXU5Irx4KU=;
        b=DvI5xC3OlZkFYwuS8BaKRyPkdBJxwymF+vwlWs/Q/9yHx5KlM+Hvaj2unyvBFZhisz
         R0+MfYB7W2i7DfqGvu0YBqKZxVi+y6HoYdpy0c6LpdaUKGV8GIgqRqrgvtUrpBg2bGCO
         93O7I2+CXPb9UwlqpeljZdrjXC5yOf3XqHtsfV7JQ/rx5Vj0ksSyb5vLw6EIA+n/ulE2
         vF1/U9tIV77kpXz0UJh2ajs9LEZIbHNLHDXs+a/1mSlMx3pIQvTzwUEzkXmeb1LYIg/e
         oDq22K4N1NpiSGCitAOnXh7edJGih1RfMVGdZ3laVF0KLkoOtXvEJcGC0ZZeCSRML4Tj
         ZbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742858112; x=1743462912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDEAne1cqLXWRxcsGCLmK1sN5PHZYlDqyUXU5Irx4KU=;
        b=vbDW2H6cmOJmwJ4lFdHH8FYdt7MKG6Q7L9ACI2wVuQz99dbBYuuBC64v/5mBB8GBYg
         bHvkvZfXlM6TBAuKBEHEVBcDt9nedYFM3raekhAbJ9Ss5wNYRVkTNudesb2yOYCbNfWA
         ET0Q432ToTqW3Zt7N7lkV53oxppIMbwQIBY/wlBdEoqGmO+YB3nZaTchKWPLiPlhTS6Q
         mDElXLMgjadJlgRZUyakpqEmJVF99oTFQD8gmP8QtgD2Ag2fZ3UP/vSmwQoITVU9HNmO
         wQsgLyg3P/gwKQUluskiCL629JrgA7rqYFRzzeETS6Z3eVpN2JISlzPcmXi2smX1sME5
         lNyQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3TE/wIOijIKfeWelKvjr03ARiTTGdoAh+QHAbNjiduASeKs9m78pUk0UvsX7FkYpv2GmnviwC4IJcyqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD47RU/UXtyXTGtLnK9m7VsaPcXCavxlBhcwbUNn34fEuRcUds
	xT/7ITVYa/Nr2VgCjO36x6JG6F5YADDhK8TPABXerTDpEe2goY4oaLNx2Q==
X-Gm-Gg: ASbGnct5DuQ4jY4/mRhCSF3bykxB/0w3cYQyZmkEvndl9YTNe0Daz/TrGyQcknMl1fC
	uUdGH5LxqH18u+C2CCtuV788XVRIBVyjwWlcGGT4HKahliGqjbmk2KcjZRKIDkuyXaMWeL9m7oR
	97YixtZi59qvMLMo/t9b8y+UVEiiTDbj4CkSBtMbXNHzBOTMPzIjzuY/UCHQw6M2F9phg4EBgm3
	b/3MJibbzze3LEAIh6pxXZv+wqPOni1Pz8dM14WujT0bq5Com/L4j/IA/JKCFuv/b6fSDrbQky4
	FmVo87if/D/CnC8md04UxC/qP3U8XCYZieeTzkZaychjOkX0k+CwjZ2hPg==
X-Google-Smtp-Source: AGHT+IF/b7ISNDZiumsrAyLKPRIT2eOGJu5v2566YxhoNfsHQMo7QmLAFCn4F040MtFejZM748iY4w==
X-Received: by 2002:a05:6a21:999a:b0:1f5:67c2:e3eb with SMTP id adf61e73a8af0-1fe43439eb8mr24549390637.41.1742858112171;
        Mon, 24 Mar 2025 16:15:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a2a4d89dsm7681873a12.63.2025.03.24.16.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 16:15:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon updates for v6.15
Date: Mon, 24 Mar 2025 16:15:10 -0700
Message-ID: <20250324231510.2019037-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull hwmon updates for Linux v6.15 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.15

Thanks,
Guenter
------

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v6.15

for you to fetch changes up to 2115cbeec8a3ccc69e3b7ecdf97b4472b0829cfc:

  hwmon: emc2305: Use devm_thermal_of_cooling_device_register (2025-03-21 17:07:38 -0700)

----------------------------------------------------------------
hwmon updates for v6.15

- New drivers

  * Driver for HTU31

  * Congatec Board Controller monitoring driver

  * Driver for TI INA233 Current and Power Monitor

- Support for additional chips or boards in existing drivers

  * pmbus/ltc2978: Add support for LT717x and LTM4673

  * asus-ec-sensors: Add PRIME X670E-PRO WIFI

  * k10temp: Add support for cyan skillfish

  * nct6683: Add customer ID for AMD BC-250

  * lm90: Add support for NCT7716, NCT7717 and NCT7718

- Other notable improvements in existing drivers

  * emc2305: Add devicetree support, and use
    devm_thermal_of_cooling_device_register

  * acpi_power_meter: Convert to with_info API

  * dell-smm: Increase the number of fans

  * pmbus/core: Optimize debugfs support and use i2c_client debugfs
    directory

   * hwmon core: Fix the missing of 'average' word in
     hwmon_power_attr_templates

   * Various drivers: Use per-client debugfs entry provided by I2C
     subsystem

----------------------------------------------------------------
Alexander Stein (2):
      dt-bindings: hwmon: gpio-fan: Add optional regulator support
      hwmon: (gpio-fan) Add missing mutex locks

Andrei Lalaev (2):
      dt-bindings: hwmon: Add description for sensor HTU31
      hwmon: add driver for HTU31

Andrey Vatoropin (1):
      hwmon: (xgene-hwmon) use appropriate type for the latency value

Andy Shevchenko (1):
      hwmon: (gsc) drop unneeded assignment for cache_type

Arnd Bergmann (1):
      hwmon: (sg2042) Add back module description/author tags

Cedric Encarnacion (2):
      dt-bindings: hwmon: ltc2978: add support for ltm4673
      hwmon: (pmbus/ltc2978) add support for ltm4673

Florin Leotescu (3):
      dt-bindings: hwmon: Add Microchip emc2305 support
      hwmon: emc2305: Add OF support
      hwmon: emc2305: Use devm_thermal_of_cooling_device_register

Guenter Roeck (8):
      hwmon: (pmbus/core) Fix various coding style issues
      hwmon: (pmbus/core) Use local debugfs variable in debugfs initialization
      hwmon: (pmbus/core) Use the new i2c_client debugfs directory
      hwmon: (pmbus/core) Make debugfs code unconditional
      hwmon: (pmbus/core) Declare regulator notification function as void
      hwmon: (pmbus/core) Optimize debugfs block data attribute initialization
      hwmon: (pmbus/core) Optimize debugfs status attribute initialization
      hwmon: (pmbus/core) Report content of CAPABILITY register in debugfs

Huisong Li (3):
      hwmon: (acpi_power_meter) Fix the fake power alarm reporting
      hwmon: Fix the missing of 'average' word in hwmon_power_attr_templates
      hwmon: (acpi_power_meter) Replace the deprecated hwmon_device_register

Jonathan Stroud (1):
      dt-bindings: hwmon: Add UCD90320 gpio description

Kim Seer Paller (3):
      hwmon: (pmbus/ltc2978) Add support for LT717x - docs
      dt-bindings: hwmon: ltc2978: add support for LT717x
      hwmon: (pmbus/ltc2978) add support for lt717x

Krzysztof Kozlowski (1):
      dt-bindings: hwmon: Drop stray blank line in the header

Kurt Borja (1):
      hwmon: (dell-smm) Increment the number of fans

Leo Yang (2):
      dt-bindings: hwmon: ti,ina2xx: Add INA233 device
      hwmon: Add driver for TI INA233 Current and Power Monitor

Maud Spierings (3):
      hwmon: (ntc_thermistor) Fix module name in the Kconfig
      dt-bindings: hwmon: ntc-thermistor: fix typo regarding the deprecation of the ntc, compatibles
      hwmon: (ntc_thermistor) return error instead of clipping on OOB

Mikhail Paulyshka (2):
      hwmon: (nct6683) Add customer ID for AMD BC-250
      hwmon: (k10temp) add support for cyan skillfish

Ming Yu (2):
      dt-bindings: hwmon: lm90: Add support for NCT7716, NCT7717 and NCT7718
      hwmon: (lm90): Add support for NCT7716, NCT7717 and NCT7718

Purva Yeshi (1):
      docs: hwmon: Fix spelling and grammatical issues

Shengyu Qu (1):
      hwmon: (asus-ec-sensors) add PRIME X670E-PRO WIFI

Thomas Richard (1):
      hwmon: Add Congatec Board Controller monitoring driver

Thorsten Blum (1):
      hwmon: (pmbus/core) Replace deprecated strncpy() with strscpy()

Wolfram Sang (7):
      hwmon: (isl28022) Use per-client debugfs entry
      hwmon: (ina3221) Use per-client debugfs entry
      hwmon: (ltc4282) Use per-client debugfs entry
      hwmon: (sg2042) Use per-client debugfs entry
      hwmon: (tps23861) Use per-client debugfs entry
      hwmon: (sht3x) Use per-client debugfs entry
      hwmon: (pt5161l) Use per-client debugfs entry

 .../devicetree/bindings/hwmon/adi,ad741x.yaml      |   1 -
 .../devicetree/bindings/hwmon/adi,adm1275.yaml     |   1 -
 .../devicetree/bindings/hwmon/adi,ltc2991.yaml     |   1 -
 .../devicetree/bindings/hwmon/gpio-fan.yaml        |   3 +
 .../devicetree/bindings/hwmon/lltc,ltc2978.yaml    |   5 +
 .../devicetree/bindings/hwmon/maxim,max20730.yaml  |   1 -
 .../devicetree/bindings/hwmon/maxim,max6639.yaml   |   1 -
 .../devicetree/bindings/hwmon/maxim,max6650.yaml   |   1 -
 .../bindings/hwmon/microchip,emc2305.yaml          | 111 +++
 .../devicetree/bindings/hwmon/national,lm90.yaml   |   6 +
 .../devicetree/bindings/hwmon/ntc-thermistor.yaml  |   2 +-
 .../devicetree/bindings/hwmon/nuvoton,nct6775.yaml |   1 -
 .../devicetree/bindings/hwmon/nuvoton,nct7363.yaml |   1 -
 .../devicetree/bindings/hwmon/nuvoton,nct7802.yaml |   1 -
 .../bindings/hwmon/pmbus/ti,ucd90320.yaml          |   9 +
 .../devicetree/bindings/hwmon/ti,adc128d818.yaml   |   1 -
 .../devicetree/bindings/hwmon/ti,ads7828.yaml      |   1 -
 .../devicetree/bindings/hwmon/ti,ina2xx.yaml       |  31 +-
 .../devicetree/bindings/hwmon/ti,lm87.yaml         |   1 -
 .../devicetree/bindings/hwmon/ti,tmp513.yaml       |   1 -
 .../devicetree/bindings/hwmon/ti,tps23861.yaml     |   1 -
 .../devicetree/bindings/hwmon/winbond,w83781d.yaml |   1 -
 .../devicetree/bindings/trivial-devices.yaml       |   2 +
 Documentation/hwmon/abituguru-datasheet.rst        |   8 +-
 Documentation/hwmon/abituguru.rst                  |   2 +-
 Documentation/hwmon/asus_ec_sensors.rst            |   1 +
 Documentation/hwmon/cgbc-hwmon.rst                 |  63 ++
 Documentation/hwmon/dell-smm-hwmon.rst             |  14 +-
 Documentation/hwmon/htu31.rst                      |  37 +
 Documentation/hwmon/ina233.rst                     |  75 ++
 Documentation/hwmon/index.rst                      |   3 +
 Documentation/hwmon/lm90.rst                       |  43 +
 Documentation/hwmon/ltc2978.rst                    |  36 +-
 Documentation/hwmon/nct6683.rst                    |   3 +-
 MAINTAINERS                                        |  14 +
 drivers/hwmon/Kconfig                              |  25 +-
 drivers/hwmon/Makefile                             |   2 +
 drivers/hwmon/acpi_power_meter.c                   | 864 ++++++++++-----------
 drivers/hwmon/asus-ec-sensors.c                    |  10 +
 drivers/hwmon/cgbc-hwmon.c                         | 304 ++++++++
 drivers/hwmon/dell-smm-hwmon.c                     |   5 +-
 drivers/hwmon/emc2305.c                            |  38 +-
 drivers/hwmon/gpio-fan.c                           |  16 +-
 drivers/hwmon/gsc-hwmon.c                          |   1 -
 drivers/hwmon/htu31.c                              | 350 +++++++++
 drivers/hwmon/hwmon.c                              |   4 +-
 drivers/hwmon/ina3221.c                            |   9 +-
 drivers/hwmon/isl28022.c                           |  44 +-
 drivers/hwmon/k10temp.c                            |   2 +
 drivers/hwmon/lm90.c                               |  82 +-
 drivers/hwmon/ltc4282.c                            |  44 +-
 drivers/hwmon/nct6683.c                            |   3 +
 drivers/hwmon/ntc_thermistor.c                     |  15 +-
 drivers/hwmon/pmbus/Kconfig                        |  15 +-
 drivers/hwmon/pmbus/Makefile                       |   1 +
 drivers/hwmon/pmbus/ina233.c                       | 191 +++++
 drivers/hwmon/pmbus/ltc2978.c                      |  69 +-
 drivers/hwmon/pmbus/pmbus_core.c                   | 377 ++++-----
 drivers/hwmon/pt5161l.c                            |  46 +-
 drivers/hwmon/sg2042-mcu.c                         |  42 +-
 drivers/hwmon/sht3x.c                              |  67 +-
 drivers/hwmon/tps23861.c                           |  31 +-
 drivers/hwmon/xgene-hwmon.c                        |   2 +-
 include/linux/pci_ids.h                            |   1 +
 64 files changed, 2151 insertions(+), 992 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml
 create mode 100644 Documentation/hwmon/cgbc-hwmon.rst
 create mode 100644 Documentation/hwmon/htu31.rst
 create mode 100644 Documentation/hwmon/ina233.rst
 create mode 100644 drivers/hwmon/cgbc-hwmon.c
 create mode 100644 drivers/hwmon/htu31.c
 create mode 100644 drivers/hwmon/pmbus/ina233.c

