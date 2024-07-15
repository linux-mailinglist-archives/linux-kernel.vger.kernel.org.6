Return-Path: <linux-kernel+bounces-251962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5D9930C3C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 02:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E6BE1C20A59
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 00:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCA028FD;
	Mon, 15 Jul 2024 00:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYBVk/I6"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C616256D;
	Mon, 15 Jul 2024 00:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721002635; cv=none; b=PW06vBwU4lrvhPBMupSnL0mrRTdvk3eE3PfUCvpgv2EYrqPwy+ID5/3FdMb4LIYQSA9mFR0EL1ZtGvLoAVh+Rx+6hQmfnBy3F6i5jVzrfmVQ8ncT1NgG9Jv9kASTmtpFGGaJn46gLYF6BLyNACYUClDU+lShjSf/RE7JM81hd8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721002635; c=relaxed/simple;
	bh=BanR1i/E5zzE+zeXIafeCWQYnvFXyIBuxo2BNRrD6Tk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=JZrJLnRsqjrJ5Z0XQv4x9L5t8X6tMgzPSFPW2Cje2Uk0o62sNrqOgl1AXeZTj4bLCUjiZfXxVEj5uc1/L6mLe9cFa1QENr+nhqVEgIkIo8/rOP1lUlA3Fxldim2RwEGnz/Cvish6NuyHpWyRDCfcR6P/RRHYofZQhuwOLIFGSec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYBVk/I6; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fb3cf78fbdso21153525ad.1;
        Sun, 14 Jul 2024 17:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721002632; x=1721607432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=23YE02sKGs1ovbki4IWRYzYGC71dt+ZDLu0P218dEWo=;
        b=AYBVk/I6fNtpbiWkrPgdocxbraxB93lZ81w/LXrA5rBRpgvw0vxsIBV+kkIjRAyOuD
         X8PAzBFaG90MRsKimBLoVn6Uoyvkmm032KyxBNelIwxHo7b2tYhaS45b4eykxiEZ0sJ4
         /8EHs7Xs2/DbDMRt0/02vtZJjo698rxjETTpkTxPFS9YH1RCowOGMCuy5wOPrGYWeTYr
         xW1UeT6SUKxNpxO4JDpMNrdOIeAtREuaIR+zzPiGViREEq+bKbuot8yQncIO2mz0bwyZ
         1i78tjp25WHvd79j2WqZJiS4RUzbWZQlghvNOV6x/UF5vYKQGZQ6XYO4/Bj6PBt58lBv
         MfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721002632; x=1721607432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23YE02sKGs1ovbki4IWRYzYGC71dt+ZDLu0P218dEWo=;
        b=PUrUKHmbuaNIhlw0VjxkpRuIVa28lllJE1P63DbqcKkmwFKFqH9m1E3kOkrevxCxL6
         /mDA625c0WthUiA25oDi80DiTtOuoZXv4V3Uk8r/pW87qp5DV47BuTaiAhGqUKvYe78v
         o883sLYzbYrH/jEIVFqtSY8k0LXUe0QbrEQw1IjDM8u0rM+BdIbifEQ/2Te9sdQzpUps
         98lzQlB5v2pYmhg5Dqitnn2ft2Xawt58X1bN62bEq4c8OvBvclXNoTGJeQfekB2FzIYl
         yINzS2ZO94aw4kmmciuyqASxmyKazWBo5HApNnbgMonVblUCo2d6r86DwnGsmQTi9azr
         cLzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHdPjsH23WFG7q5EZeyP6ErMwmgjhH+jCQhhppxvhKrKjk4Acr3bXXGkhZF0ZeDQdzV+VsQ1kOC9G+aNdR5YpF17eXta7ZCgRn5Ip0
X-Gm-Message-State: AOJu0Yzm89B7vFczn1hBCjV/RzCNKNe2pKgzPnj/3Cn634MZw1pYVuB9
	O9QdEYjf4uLpbQaw2L7lAZQJpLG1BL7Hb557iGg7N3RVX01b1nRr5VY/Fg==
X-Google-Smtp-Source: AGHT+IFepPF4jucndbUoIG7QT2OfcPM4/Sh437+F5qrC5y0bwIJsnBNsbqtazNv1hhXVXJtX7BVPWw==
X-Received: by 2002:a17:902:c411:b0:1f7:26f:9185 with SMTP id d9443c01a7336-1fbb6cd187fmr143785775ad.10.1721002632075;
        Sun, 14 Jul 2024 17:17:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bb73f8esm28729785ad.40.2024.07.14.17.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 17:17:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon updates for v6.11
Date: Sun, 14 Jul 2024 17:17:09 -0700
Message-Id: <20240715001709.2985905-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull hwmon updates for Linux v6.11 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.11

Thanks,
Guenter
------

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v6.11

for you to fetch changes up to 1ea3fd1eb9869fcdcbc9c68f9728bfc47b9503f1:

  hwmon: (max6697) Fix swapped temp{1,8} critical alarms (2024-07-14 11:49:01 -0700)

----------------------------------------------------------------
hwmon updates for v6.11-rc1

* Obsolete driver removals

  - Removed obsolete adm1021 and max6642 drivers

* New drivers

  - MPS MP2891

  - MPS MP2993

  - MPS MP9941

  - MPS MP5920

  - SPD5118 (Temperature Sensor and EEPROM)

* Added device support to existing drivers

  - g762: G761

  - dell-smm: Dell OptiPlex 7060

  - asus-ec-sensors: ProArt X670E-CREATOR WIFI

  - corsair-psu: HX1200i Series 2023 psu

  - nzxt-smart2: Additional USB IS for NZXT RGB & Fan Controller

* Notable enhancements and fixes

  - Removed use of i2c_match_id()

  - Constified struct regmap_config where feasible

  - Cleaned up amc6821 driver, and converted to use regmap and with_info API

  - Converted max6639 driver to use with_info API; added support for
    additional sysfs attributes

  - Fixed various sysfs attribute underflows

  - Added PEC support to hwmon core, and use in lm90 and max31827 drivers

* Various other minor fixes and improvements

----------------------------------------------------------------
Aleksandr Mezin (1):
      hwmon: (nzxt-smart2) Add support for another version of NZXT RGB & Fan Controller

Alex Vdovydchenko (2):
      dt-bindings: hwmon: Add MPS mp5920
      hwmon: add MP5920 driver

Amna Waseem (2):
      dt-bindings: hwmon: ti,ina2xx: Add ti,alert-polarity-active-high property
      hwmon: (ina2xx) Add device tree support to pass alert polarity

Andrew Davis (31):
      hwmon: (ad7418) Remove use of i2c_match_id()
      hwmon: (adm1021) Remove use of i2c_match_id()
      hwmon: (adm1031) Remove use of i2c_match_id()
      hwmon: (ads7828) Remove use of i2c_match_id()
      hwmon: (adt7475) Remove use of i2c_match_id()
      hwmon: (aht10) Remove use of i2c_match_id()
      hwmon: (dme1737) Remove use of i2c_match_id()
      hwmon: (ds1621) Remove use of i2c_match_id()
      hwmon: (f75375s) Remove use of i2c_match_id()
      hwmon: (fschmd) Remove use of i2c_match_id()
      hwmon: (ina2xx) Remove use of i2c_match_id()
      hwmon: (lm63) Remove use of i2c_match_id()
      hwmon: (lm75) Remove use of i2c_match_id()
      hwmon: (lm78) Remove use of i2c_match_id()
      hwmon: (lm83) Remove use of i2c_match_id()
      hwmon: (lm85) Remove use of i2c_match_id()
      hwmon: (lm90) Remove use of i2c_match_id()
      hwmon: (lm95234) Remove use of i2c_match_id()
      hwmon: (max16065) Remove use of i2c_match_id()
      hwmon: (max1668) Remove use of i2c_match_id()
      hwmon: (max6697) Remove use of i2c_match_id()
      hwmon: (mcp3021) Remove use of i2c_match_id()
      hwmon: (powr1220) Remove use of i2c_match_id()
      hwmon: (sht3x) Remove use of i2c_match_id()
      hwmon: (shtc1) Remove use of i2c_match_id()
      hwmon: (thmc50) Remove use of i2c_match_id()
      hwmon: (tmp401) Remove use of i2c_match_id()
      hwmon: (tmp421) Remove use of i2c_match_id()
      hwmon: (tmp464) Remove use of i2c_match_id()
      hwmon: (w83781d) Remove use of i2c_match_id()
      hwmon: (w83795): Remove use of i2c_match_id()

Armin Wolf (1):
      hwmon: (dell-smm) Add Dell OptiPlex 7060 to DMI table

Christian Marangi (3):
      dt-bindings: hwmon: g762: Convert to yaml schema
      dt-bindings: hwmon: g76x: Add support for g761
      hwmon: g672: add support for g761

Dan Carpenter (1):
      hwmon: (ltc2991) re-order conditions to fix off by one bug

Eugene Shalygin (1):
      hwmon: (asus-ec-sensors) add ProArt X670E-CREATOR WIFI

Guenter Roeck (36):
      hwmon: (nct6683) Display warning when enabling driver for unknown customer
      hwmon: Add PEC attribute support to hardware monitoring core
      hwmon: (lm90) Convert to use PEC support from hwmon core
      dt-bindings: trivial-devices: Add jedec,spd5118
      hwmon: Add support for SPD5118 compliant temperature sensors
      hwmon: (spd5118) Add suspend/resume support
      hwmon: (spd5118) Add support for reading SPD data
      i2c: smbus: Support DDR5 and LPDDR5 SPD EEPROMs
      hwmon: (spd5118) Add configuration option for auto-detection
      hwmon: (pmbus/max31827) Explain why enum chips must not start with 0
      hwmon: (pmbus/mp2856) Let enum chips start with index 0
      hwmon: (nct6775) Let enum kinds start with index 0
      hwmon: (pmbus/lm25066) Let enum chips start with index 0
      hwmon: (spd5118) Use regmap to implement paging
      hwmon: (spd5118) Add support for Renesas/ITD SPD5118 hub controllers
      hwmon: (jc42) Use common device ID for TSE2004av compliant sensors
      hwmon: (jc42)  Strengthen detect function
      hwmon: (adc128d818) Fix underflows seen when writing limit attributes
      hwmon: (lm95234) Fix underflows seen when writing limit attributes
      hwmon: (nct6775-core) Fix underflows seen when writing limit attributes
      hwmon: (w83627ehf) Fix underflows seen when writing limit attributes
      hwmon: (amc6821) Stop accepting invalid pwm values
      hwmon: (amc6821) Make reading and writing fan speed limits consistent
      hwmon: (amc6821) Rename fan1_div to fan1_pulses
      hwmon: (amc6821) Add support for fan1_target and pwm1_enable mode 4
      hwmon: (amc6821) Reorder include files, drop unnecessary ones
      hwmon: (amc6821) Use tabs for column alignment in defines
      hwmon: (amc6821) Use BIT() and GENMASK()
      hwmon: (amc6821) Drop unnecessary enum chips
      hwmon: (amc6821) Convert to use regmap
      hwmon: (amc6821) Convert to with_info API
      hwmon: (amc6821) Add support for pwm1_mode attribute
      hwmon: (g762) Initialize fans after configuring clock
      hwmon: Remove obsolete adm1021 and max6642 drivers
      hwmon: (max6697) Fix underflow when writing limit attributes
      hwmon: (max6697) Fix swapped temp{1,8} critical alarms

Javier Carrasco (6):
      hwmon: (ltc2991) use device_for_each_child_node_scoped()
      hwmon: (gsc-hwmon) use device_for_each_child_node_scoped()
      hwmon: (ina238) Constify struct regmap_config
      hwmon: (tmp513) Constify struct regmap_config
      hwmon: (tps23861) Constify struct regmap_config
      hwmon: (gsc-hwmon) constify read-only struct regmap_bus

Jeff Johnson (1):
      hwmon: add missing MODULE_DESCRIPTION() macros

Krzysztof Kozlowski (1):
      hwmon: lm70: simplify with spi_get_device_match_data()

Marius Zachmann (1):
      hwmon: (corsair-cpro) Add firmware and bootloader information

Naresh Solanki (3):
      dt-bindings: hwmon: Add max6639
      hwmon: (max6639) : Update hwmon init using info structure
      hwmon: (max6639) : Add additional hwmon attributes for fan and pwm

Noah Wang (6):
      dt-bindings: hwmon: Add MPS mp2993
      hwmon: add MP2993 driver
      dt-bindings: hwmon: Add MPS mp9941
      hwmon: add MP9941 driver
      dt-bindings: hwmon: Add MPS mp2891
      hwmon: add MP2891 driver

Radu Sabau (1):
      hwmon: (max31827) Add PEC support

Sean Anderson (1):
      hwmon: iio: Use iio_read_channel_processed_scale for IIO_POWER

Stanislav Jakubek (1):
      dt-bindings: hwmon: ti,tmp108: document V+ supply, add short description

Thomas Weißschuh (1):
      hwmon: (core) Make hwmon_class const

Uwe Kleine-König (1):
      hwmon: (pmbus/ltc4286) Drop unused i2c device ids

Wayne Tung (1):
      hwmon: (adt7475) Fix default duty on fan is disabled

Wilken Gottwalt (1):
      hwmon: corsair-psu: add USB id of HX1200i Series 2023 psu

 Documentation/devicetree/bindings/hwmon/g762.txt   |   47 -
 .../devicetree/bindings/hwmon/gmt,g762.yaml        |   95 ++
 .../devicetree/bindings/hwmon/maxim,max6639.yaml   |   92 ++
 .../devicetree/bindings/hwmon/ti,ina2xx.yaml       |    9 +
 .../devicetree/bindings/hwmon/ti,tmp108.yaml       |   12 +
 .../devicetree/bindings/trivial-devices.yaml       |   10 +
 Documentation/hwmon/adm1021.rst                    |  153 ---
 Documentation/hwmon/amc6821.rst                    |    7 +-
 Documentation/hwmon/asus_ec_sensors.rst            |    1 +
 Documentation/hwmon/corsair-cpro.rst               |    8 +
 Documentation/hwmon/corsair-psu.rst                |    6 +-
 Documentation/hwmon/dell-smm-hwmon.rst             |    2 +
 Documentation/hwmon/index.rst                      |    7 +-
 Documentation/hwmon/max31827.rst                   |   13 +-
 Documentation/hwmon/max6642.rst                    |   27 -
 Documentation/hwmon/mp2891.rst                     |  179 +++
 Documentation/hwmon/mp2993.rst                     |  150 +++
 Documentation/hwmon/mp5920.rst                     |   91 ++
 Documentation/hwmon/mp9941.rst                     |   92 ++
 Documentation/hwmon/spd5118.rst                    |   63 +
 MAINTAINERS                                        |   21 +
 drivers/hwmon/Kconfig                              |   56 +-
 drivers/hwmon/Makefile                             |    3 +-
 drivers/hwmon/ad7418.c                             |    7 +-
 drivers/hwmon/adc128d818.c                         |    4 +-
 drivers/hwmon/adm1021.c                            |  505 -------
 drivers/hwmon/adm1031.c                            |    4 +-
 drivers/hwmon/ads7828.c                            |    7 +-
 drivers/hwmon/adt7475.c                            |   18 +-
 drivers/hwmon/aht10.c                              |    3 +-
 drivers/hwmon/amc6821.c                            | 1402 ++++++++++----------
 drivers/hwmon/asus-ec-sensors.c                    |   10 +
 drivers/hwmon/asus_atk0110.c                       |    1 +
 drivers/hwmon/corsair-cpro.c                       |   89 ++
 drivers/hwmon/corsair-psu.c                        |    7 +-
 drivers/hwmon/dell-smm-hwmon.c                     |    7 +
 drivers/hwmon/dme1737.c                            |    4 +-
 drivers/hwmon/ds1621.c                             |    4 +-
 drivers/hwmon/f75375s.c                            |   46 +-
 drivers/hwmon/fschmd.c                             |    2 +-
 drivers/hwmon/g762.c                               |   43 +-
 drivers/hwmon/gsc-hwmon.c                          |    9 +-
 drivers/hwmon/hwmon.c                              |  149 ++-
 drivers/hwmon/iio_hwmon.c                          |   11 +-
 drivers/hwmon/ina238.c                             |    2 +-
 drivers/hwmon/ina2xx.c                             |   39 +-
 drivers/hwmon/jc42.c                               |   49 +-
 drivers/hwmon/lm63.c                               |    5 +-
 drivers/hwmon/lm70.c                               |    6 +-
 drivers/hwmon/lm75.c                               |   10 +-
 drivers/hwmon/lm78.c                               |    4 +-
 drivers/hwmon/lm83.c                               |   16 +-
 drivers/hwmon/lm85.c                               |    7 +-
 drivers/hwmon/lm90.c                               |   61 +-
 drivers/hwmon/lm95234.c                            |   14 +-
 drivers/hwmon/ltc2991.c                            |   15 +-
 drivers/hwmon/max16065.c                           |   10 +-
 drivers/hwmon/max1668.c                            |    4 +-
 drivers/hwmon/max31827.c                           |   23 +-
 drivers/hwmon/max6639.c                            |  608 ++++++---
 drivers/hwmon/max6642.c                            |  314 -----
 drivers/hwmon/max6697.c                            |   12 +-
 drivers/hwmon/mcp3021.c                            |    6 +-
 drivers/hwmon/mr75203.c                            |    1 +
 drivers/hwmon/nct6683.c                            |    2 +
 drivers/hwmon/nct6775-core.c                       |    2 +-
 drivers/hwmon/nct6775.h                            |    2 +-
 drivers/hwmon/nzxt-smart2.c                        |    1 +
 drivers/hwmon/pmbus/Kconfig                        |   36 +
 drivers/hwmon/pmbus/Makefile                       |    4 +
 drivers/hwmon/pmbus/lm25066.c                      |    2 +-
 drivers/hwmon/pmbus/ltc4286.c                      |    4 +-
 drivers/hwmon/pmbus/mp2856.c                       |    8 +-
 drivers/hwmon/pmbus/mp2891.c                       |  600 +++++++++
 drivers/hwmon/pmbus/mp2993.c                       |  261 ++++
 drivers/hwmon/pmbus/mp5920.c                       |   90 ++
 drivers/hwmon/pmbus/mp9941.c                       |  319 +++++
 drivers/hwmon/powr1220.c                           |    6 +-
 drivers/hwmon/sht3x.c                              |   20 +-
 drivers/hwmon/shtc1.c                              |    4 +-
 drivers/hwmon/spd5118.c                            |  703 ++++++++++
 drivers/hwmon/thmc50.c                             |    4 +-
 drivers/hwmon/tmp401.c                             |    2 +-
 drivers/hwmon/tmp421.c                             |    6 +-
 drivers/hwmon/tmp464.c                             |    5 +-
 drivers/hwmon/tmp513.c                             |    2 +-
 drivers/hwmon/tps23861.c                           |    2 +-
 drivers/hwmon/w83627ehf.c                          |    4 +-
 drivers/hwmon/w83781d.c                            |    4 +-
 drivers/hwmon/w83795.c                             |    4 +-
 drivers/i2c/i2c-smbus.c                            |    6 +-
 include/linux/hwmon.h                              |    2 +
 92 files changed, 4473 insertions(+), 2314 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/hwmon/g762.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/gmt,g762.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
 delete mode 100644 Documentation/hwmon/adm1021.rst
 delete mode 100644 Documentation/hwmon/max6642.rst
 create mode 100644 Documentation/hwmon/mp2891.rst
 create mode 100644 Documentation/hwmon/mp2993.rst
 create mode 100644 Documentation/hwmon/mp5920.rst
 create mode 100644 Documentation/hwmon/mp9941.rst
 create mode 100644 Documentation/hwmon/spd5118.rst
 delete mode 100644 drivers/hwmon/adm1021.c
 delete mode 100644 drivers/hwmon/max6642.c
 create mode 100644 drivers/hwmon/pmbus/mp2891.c
 create mode 100644 drivers/hwmon/pmbus/mp2993.c
 create mode 100644 drivers/hwmon/pmbus/mp5920.c
 create mode 100644 drivers/hwmon/pmbus/mp9941.c
 create mode 100644 drivers/hwmon/spd5118.c

