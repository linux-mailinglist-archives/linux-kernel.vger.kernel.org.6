Return-Path: <linux-kernel+bounces-412373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F159D0832
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 04:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCC8F1F216F2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 03:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C137D6F06A;
	Mon, 18 Nov 2024 03:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2ttUzOZ"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4BF23A9;
	Mon, 18 Nov 2024 03:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731901122; cv=none; b=bY1DhEPOQJ9Q0toqdZ7KFiw9n61nX10mgLi+ssXBuRs4ZjP1n/btYdsWf46stufwieOoTFlNGizdVjWveoxbJ/WhA/CtKCUJG98VKFKHJAuODiggVaQIMQxgnTJCLDBh/Jr7RTTcjZS37c0QTPpfR1evR4iPTSqXmmQZqcfAsQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731901122; c=relaxed/simple;
	bh=pc6FphSX/rOiVnf2aLGbjXl1r1CLnsxjNNx39nzBmLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZpiggFW8PWvovmII+wUQGqDFeCHXnp7vwvyUHuZEDhGNiAVlj9HMMLtUvHzOANCrMNH50BudP4oUn3NSY/JUqWdfE3sWYN1fGt62XW0O9GNMj+vTtnBAW5EOMDNaRSBTCg0MO/wcKosE0buvzgidz52k1vk79k/9qVpe/P4WDFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2ttUzOZ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c805a0753so33263375ad.0;
        Sun, 17 Nov 2024 19:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731901120; x=1732505920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=CwW1gMUUbSq1XizVvfNi77qzaX3aAB0PB7YmPCMN8wQ=;
        b=E2ttUzOZwtdPdny0ZywZZxx3f97B8YZpaxtK780tztFIJrMTXuKCGLi9irn9Bcw9B0
         D0ejvFIBMR3QLcnqK7yUPiGc6JjwwXaJAOgrnaQD7lqkdVQEVLl7z1VuIZyXK3hv3H1C
         HrgGe0iqWzcND/oPf2O6Zgzn1GZTUjcSCsA0AX5gp//TKuSyAiuC50D79j9uisO/XuL6
         fxod8QtNZgdwEtTfHJ0JEIaULkFmg6nmoylbCfp3xc0BcUvOxGMGiTdYl32a9VGOXiEd
         JqFg0cae8iP3/8sh4rk821MqzEdwsbrM0hGDiI61PttxbBoB+nLNAoUXcubcVPckllCn
         Z0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731901120; x=1732505920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CwW1gMUUbSq1XizVvfNi77qzaX3aAB0PB7YmPCMN8wQ=;
        b=czMgeBU3Nc3Q+SfyyodIVRoIPpbe8GLxY2//8Ajy/xdlsPuSUYepJWvVayk2DOY57J
         N3Re5++taJV/GUXLgugdGa9tCSG0LsGtgR3w6pu01iN427Ae5zT3u4rMTQgTYdF8V1Gx
         06xkOl3msLlGolSF9kIBlV1kBLKQmqvo/PXh2yTXjBcZ6NMs367jQXtMYoSpwC9XUnWY
         IXBJLwFb373iYoJbYurxd6PuGIHZZQX+ONBk6O5VnqL+BdjkGlKC3VFkUmA8qltY9QRU
         LzOTGtRN3XfJ5SFkmwbOR50HqaN78irpXkmsq9aZw0yZbp5s9NYQRKlybd5aoyusHLBZ
         VEGg==
X-Forwarded-Encrypted: i=1; AJvYcCXLiIpjCXo4WReXqIwnvlY19d5am1dOrC28vkRWXIsxTeYU0bBfM2yp74itN3sypTpMlTcbTv8Ap/Q0ZK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8+SzwT5XPtHX40lC9o3xckVpNS8rOGZNQ0QkBDron+lKuAPFS
	b/ZlLz+MM9cYmg1e3U1qFglmKjKAFXicJsB52PbUVQnMz5j4wmflnaaLSA==
X-Google-Smtp-Source: AGHT+IGxwJBcS6ur/ISrIb451SXgJwoafjIWoBwWmaWGlrViYY7pqBQ5Im5mXTGuORxnOWPe5VNdQw==
X-Received: by 2002:a17:903:944:b0:211:e9c0:31c6 with SMTP id d9443c01a7336-211e9c0344fmr110427805ad.12.1731901119945;
        Sun, 17 Nov 2024 19:38:39 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2120c71fccbsm17232165ad.249.2024.11.17.19.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 19:38:39 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon updates for v6.13-rc1
Date: Sun, 17 Nov 2024 19:38:36 -0800
Message-ID: <20241118033837.3586271-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull hwmon updates for Linux v6.13-rc1 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.13-rc1

Thanks,
Guenter
------

The following changes since commit 2d5404caa8c7bb5c4e0435f94b28834ae5456623:

  Linux 6.12-rc7 (2024-11-10 14:19:35 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v6.13-rc1

for you to fetch changes up to 3996187f80a0e24bff1959609065d49041cf648d:

  hwmon: (pmbus/isl68137) add support for voltage divider on Vout (2024-11-13 12:08:07 -0800)

----------------------------------------------------------------
hmon updates for v6.13-rc1

* New drivers

  - ISL28022 power monitor

  - Nuvoton NCT7363Y

* Added support for new chips to existing drivers

  - The tmp180 driver now supports NXP p3t1085, including its I3C mode

  - The ina2xx driver now supports SY24655 and INA260

  - The amc6821 driver now supports tsd,mule

* Other notable improvements

  - The sht4x driver now supports the chip heater

  - The pmbus/isl68137 driver now supports a voltage divider on Vout

  - The cros_ec driver registers with the thermal framework

  - The pmbus/ltc2978 driver now supports LTC7841

  - The PMBus core now allow drivers to override WRITE_PROTECT

* Various other minor improvements and cleanups

----------------------------------------------------------------
Abhinav Saxena (2):
      hwmon: (f71882fg) Fix grammar in fan speed trip points explanation
      hwmon: (sch5627, max31827) Fix typos in driver documentation

Andy Shevchenko (1):
      hwmon: (jc42) Drop of_match_ptr() protection

Antoni Pokusinski (1):
      hwmon: (sht4x): add heater support

Arnd Bergmann (1):
      hwmon: tmp108: fix I3C dependency

Ban Feng (2):
      dt-bindings: hwmon: Add NCT7363Y documentation
      hwmon: Add driver for I2C chip Nuvoton NCT7363Y

Everest K.C. (1):
      hwmon: (max31827) Fix spelling errors reported by codespell

Farouk Bouabid (2):
      dt-bindings: hwmon: add support for ti,amc6821
      hwmon: (amc6821) add support for tsd,mule

Frank Li (4):
      dt-bindings: hwmon: ti,tmp108: Add nxp,p3t1085 compatible string
      hwmon: (tmp108) Add NXP p3t1085 support
      hwmon: (tmp108) Add helper function tmp108_common_probe() to prepare I3C support
      hwmon: (tmp108) Add support for I3C device

Grant Peltier (2):
      dt-bindings: hwmon: isl68137: add bindings to support voltage dividers
      hwmon: (pmbus/isl68137) add support for voltage divider on Vout

Guenter Roeck (3):
      hwmon: (ina2xx) Add support for has_alerts configuration flag
      hwmon: (ina2xx) Add support for INA260
      MAINTAINERS: Remove Aleksandr Mezin as NZXT-SMART2 driver maintainer

Heiner Kallweit (9):
      hwmon: Add static visibility member to struct hwmon_ops
      hwmon: (i5500_temp) Simplify specifying static visibility attribute
      hwmon: (surface_fan) Simplify specifying static visibility attribute
      hwmon: (sl28cpld) Simplify specifying static visibility attribute
      hwmon: (gsc) Simplify specifying static visibility attribute
      hwmon: (powerz) Simplify specifying static visibility attribute
      hwmon: (raspberrypi) Simplify specifying static visibility attribute
      hwmon: (intel-m10-bmc) Simplify specifying static visibility attribute
      hwmon: (nzxt-kraken2) Simplify specifying static visibility attribute

Huisong Li (1):
      hwmon: (acpi_power_meter) Fix fail to load module on platform without _PMD method

Jerome Brunet (4):
      hwmon: (pmbus) add documentation for existing flags
      hwmon: (pmbus/core) allow drivers to override WRITE_PROTECT
      hwmon: (pmbus/core) clear faults after setting smbalert mask
      dt-bindings: hwmon: pmbus: add ti tps25990 support

Marek Vasut (2):
      dt-bindings: hwmon: pwm-fan: Document start from stopped state properties
      hwmon: (pwm-fan) Introduce start from stopped state handling

Mariel Tinaco (3):
      dt-bindings: hwmon: ltc2978: add support for ltc7841
      hwmon: (pmbus/ltc7841) add support for LTC7841 - docs
      hwmon: (pmbus/ltc2978) add support for ltc7841

Naresh Solanki (3):
      hwmon: (max6639) : Configure based on DT property
      dt-bindings: hwmon: pmbus: Add bindings for MPS MP297x
      dt-bindings: hwmon: pmbus: Add bindings for Vicor pli1209bc

Pei Xiao (1):
      hwmon: (nct6775-core) Fix overflows seen when writing limit attributes

Sarah Maedel (1):
      hwmon: (nct6775) Add 665-ACE/600M-CL to ASUS WMI monitoring list

Shen Lichuan (1):
      hwmon: (pmbus/mpq8785) Convert comma to semicolon

Sung-Chi, Li (1):
      hwmon: (cros_ec) register thermal sensors to thermal framework

Uwe Kleine-König (2):
      hwmon: Drop explicit initialization of struct i2c_device_id::driver_data to 0
      hwmon: Switch back to struct platform_driver::remove()

Wenliang Yan (2):
      dt-bindings: Add SY24655 to ina2xx devicetree bindings
      hwmon: (ina226) Add support for SY24655

Yikai Tsai (2):
      dt-bindings: hwmon: add renesas,isl28022
      hwmon: (isl28022) new driver for ISL28022 power monitor

 .../devicetree/bindings/hwmon/lltc,ltc2978.yaml    |   2 +
 .../devicetree/bindings/hwmon/nuvoton,nct7363.yaml |  66 +++
 .../bindings/hwmon/pmbus/isil,isl68137.yaml        | 148 ++++++
 .../bindings/hwmon/pmbus/mps,mp2975.yaml           |  75 +++
 .../bindings/hwmon/pmbus/ti,tps25990.yaml          |  83 ++++
 .../bindings/hwmon/pmbus/vicor,pli1209bc.yaml      |  62 +++
 .../devicetree/bindings/hwmon/pwm-fan.yaml         |  10 +
 .../bindings/hwmon/renesas,isl28022.yaml           |  64 +++
 .../devicetree/bindings/hwmon/ti,amc6821.yaml      |  86 ++++
 .../devicetree/bindings/hwmon/ti,ina2xx.yaml       |   1 +
 .../devicetree/bindings/hwmon/ti,tmp108.yaml       |   8 +-
 .../devicetree/bindings/trivial-devices.yaml       |  16 -
 Documentation/hwmon/f71882fg.rst                   |   9 +-
 Documentation/hwmon/ina2xx.rst                     |  46 +-
 Documentation/hwmon/index.rst                      |   2 +
 Documentation/hwmon/isl28022.rst                   |  63 +++
 Documentation/hwmon/ltc2978.rst                    |  12 +
 Documentation/hwmon/max31827.rst                   |   2 +-
 Documentation/hwmon/nct7363.rst                    |  35 ++
 Documentation/hwmon/pmbus-core.rst                 |  15 +
 Documentation/hwmon/sch5627.rst                    |   2 +-
 Documentation/hwmon/sht4x.rst                      |  14 +
 Documentation/hwmon/tmp108.rst                     |   8 +
 MAINTAINERS                                        |  29 +-
 drivers/hwmon/Kconfig                              |  31 +-
 drivers/hwmon/Makefile                             |   2 +
 drivers/hwmon/abituguru.c                          |   2 +-
 drivers/hwmon/abituguru3.c                         |   4 +-
 drivers/hwmon/acpi_power_meter.c                   |   3 +-
 drivers/hwmon/amc6821.c                            |  14 +-
 drivers/hwmon/aspeed-g6-pwm-tach.c                 |   2 +-
 drivers/hwmon/cros_ec_hwmon.c                      |   1 +
 drivers/hwmon/da9052-hwmon.c                       |   2 +-
 drivers/hwmon/dme1737.c                            |   2 +-
 drivers/hwmon/f71805f.c                            |   2 +-
 drivers/hwmon/f71882fg.c                           |   2 +-
 drivers/hwmon/gsc-hwmon.c                          |   9 +-
 drivers/hwmon/hwmon.c                              |  19 +-
 drivers/hwmon/i5500_temp.c                         |   8 +-
 drivers/hwmon/i5k_amb.c                            |   2 +-
 drivers/hwmon/ina2xx.c                             | 152 +++++-
 drivers/hwmon/intel-m10-bmc-hwmon.c                |   9 +-
 drivers/hwmon/isl28022.c                           | 535 +++++++++++++++++++++
 drivers/hwmon/jc42.c                               |   6 +-
 drivers/hwmon/max197.c                             |   2 +-
 drivers/hwmon/max6639.c                            |  83 +++-
 drivers/hwmon/mc13783-adc.c                        |   2 +-
 drivers/hwmon/nct6775-core.c                       |   7 +-
 drivers/hwmon/nct6775-platform.c                   |   2 +
 drivers/hwmon/nct7363.c                            | 447 +++++++++++++++++
 drivers/hwmon/nzxt-kraken2.c                       |   9 +-
 drivers/hwmon/occ/p9_sbe.c                         |   4 +-
 drivers/hwmon/pc87360.c                            |   2 +-
 drivers/hwmon/pc87427.c                            |   2 +-
 drivers/hwmon/pmbus/Kconfig                        |   6 +-
 drivers/hwmon/pmbus/isl68137.c                     | 210 +++++++-
 drivers/hwmon/pmbus/ltc2978.c                      |  20 +-
 drivers/hwmon/pmbus/mp2891.c                       |   4 +-
 drivers/hwmon/pmbus/mp2993.c                       |   4 +-
 drivers/hwmon/pmbus/mp9941.c                       |   4 +-
 drivers/hwmon/pmbus/mpq8785.c                      |   2 +-
 drivers/hwmon/pmbus/pmbus_core.c                   |  16 +-
 drivers/hwmon/powerz.c                             |   8 +-
 drivers/hwmon/pwm-fan.c                            |  33 +-
 drivers/hwmon/raspberrypi-hwmon.c                  |   8 +-
 drivers/hwmon/sch5636.c                            |   2 +-
 drivers/hwmon/sg2042-mcu.c                         |   4 +-
 drivers/hwmon/sht15.c                              |   2 +-
 drivers/hwmon/sht4x.c                              | 184 ++++++-
 drivers/hwmon/sis5595.c                            |   2 +-
 drivers/hwmon/sl28cpld-hwmon.c                     |   9 +-
 drivers/hwmon/smsc47m1.c                           |   2 +-
 drivers/hwmon/spd5118.c                            |   2 +-
 drivers/hwmon/surface_fan.c                        |  10 +-
 drivers/hwmon/tmp108.c                             |  75 ++-
 drivers/hwmon/ultra45_env.c                        |   2 +-
 drivers/hwmon/via-cputemp.c                        |   2 +-
 drivers/hwmon/via686a.c                            |   2 +-
 drivers/hwmon/vt1211.c                             |   2 +-
 drivers/hwmon/vt8231.c                             |   4 +-
 drivers/hwmon/w83627hf.c                           |   2 +-
 drivers/hwmon/w83781d.c                            |   2 +-
 drivers/hwmon/xgene-hwmon.c                        |   2 +-
 include/linux/hwmon.h                              |   5 +-
 include/linux/platform_data/max6639.h              |  15 -
 85 files changed, 2620 insertions(+), 250 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/isil,isl68137.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/mps,mp2975.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/ti,tps25990.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/vicor,pli1209bc.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/renesas,isl28022.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/ti,amc6821.yaml
 create mode 100644 Documentation/hwmon/isl28022.rst
 create mode 100644 Documentation/hwmon/nct7363.rst
 create mode 100644 drivers/hwmon/isl28022.c
 create mode 100644 drivers/hwmon/nct7363.c
 delete mode 100644 include/linux/platform_data/max6639.h

