Return-Path: <linux-kernel+bounces-178163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DFA8C49E5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 01:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD29C283192
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 23:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A2184FA0;
	Mon, 13 May 2024 23:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiAimj2m"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F8B82488;
	Mon, 13 May 2024 23:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715641712; cv=none; b=dRx4Y7V2MGQe80suj4JZlEN1BPGN2g7ZVXhrXxJmHBDXdeBmr+Q26JkAbvt9W030ykxBq8psjC2xVi7twWhc1dqJEQ4q3xjhVs0cTvr41CuY6vu193QKf6xMN6k4+ZDMdtNuZuMj0DmIphuABE9LhQn3R3oLBmuwwBIcYTUZM0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715641712; c=relaxed/simple;
	bh=1VJYHUcK3Mqg+1/KSiTo2kGolv8vt7rxABY87LG5Sqw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=cEeFlotUsDcKZ6XYhPJHwBGX4GOk+VoyyxJcOgxHzZQIo/OkdlxZC9/h5Wo8kt64zpq5gD1yQ8a6u9rDOCsYqTDh1wTC9MuPMxb/AQHduCbNpomIf4SAFXfYM2+FfONJCVf+SFJ4XXGsTtbmJcSyrlzwx6FyKcSPTIc7I43onFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aiAimj2m; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1eecc71311eso41804685ad.3;
        Mon, 13 May 2024 16:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715641710; x=1716246510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=leL6L1PvJa8LS0SZ4Cjn642ciWjKRXM149tAFx3jFiI=;
        b=aiAimj2m8t9tImvOre/zZVmU07Dh7DoWNzMcDd7YFe1dqPsDxa5RjqNszAz+eQYZt3
         1iQMWI/eHRNSdmpJJ9J2BI8PGRWNzVwhtafdjv0IZDIxm2XTPoQD2LxhhCnQCAXCMwhs
         bgGLBgE6S8+jC2rr8yZFM8seQQrQyFmTNEKRwIF5eEPTPpux09njNexVvGOoaFjTRRkJ
         lFbnEWZzplziC5CHqxPJkgj7r3v9wXo/c8VHUd7YdvAiYXhVbU2kXi+1PE/pw5yWMWS9
         0u3PLZy6BQpegPRxR6B81DoYxVF/Epxretojx33tj3cKIKvHdh6PVmUNuDNA0QpvzByF
         A4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715641710; x=1716246510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=leL6L1PvJa8LS0SZ4Cjn642ciWjKRXM149tAFx3jFiI=;
        b=cmg/j0PsFjtV674ad2iHuRbLck4RhL4u+gIWr4CAg4KRDE58+v74LOF7RE0QKKwMFc
         X+NG/qG5GPMc4fzXgrJsKjIRT1k/muFztdf19nOcM8PR45j+Om3UzTD7X0n7HIfQucSu
         lKrMJInc9/JYB3hA4hGruCzXKcjzi+1UVCm0+IoGFEay1Yqpf948LlpQZIjcN99d7mlx
         rmSiT5Wg6jZ2cdAFZ4d+d2/5Hqsii3YTEiYKCZtamna+uyu8sk1znXaiGc6DOpJRZnir
         j9cXv8HeZZVdcWnCgU71RlgwHPpLRCvVOl4sLTJ35Gi89yr7H/XexMiDfITAN1Q4IGrS
         qi4g==
X-Forwarded-Encrypted: i=1; AJvYcCUXmE0OmrfhrOc5CGKEiMVDI3BPuBaA/EVCObgQL4yYZNjYIAzu62dJ3u44pwnwv6I1xP5Xw1ls8v+hS+0fnGiITcSZPhbU/FnXee3+
X-Gm-Message-State: AOJu0Yyax+Q4fyzYc6y2XQtbY3+akhutheoDgdNecc4ai6eMx2bqomNt
	Wjn2aEreGBXlvQS8uJcaXqZhpUwPFuCKYsoR0yKRyYKalWJ+aObqTPuanw==
X-Google-Smtp-Source: AGHT+IGe4sSCg/QNS2aUTBidv9UWR1Cofd4gzR/34MBMCXI4gjTsRqYGm5/lAI5hmhIGJIhccDnW8A==
X-Received: by 2002:a17:903:1108:b0:1ec:53de:a51d with SMTP id d9443c01a7336-1ef440585f2mr191812495ad.69.1715641709927;
        Mon, 13 May 2024 16:08:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0badb959sm84816595ad.85.2024.05.13.16.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 16:08:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon updates for v6.10
Date: Mon, 13 May 2024 16:08:27 -0700
Message-Id: <20240513230827.983884-1-linux@roeck-us.net>
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

Please pull hwmon updates for Linux v6.10 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.10

Thanks,
Guenter
------

The following changes since commit 39cd87c4eb2b893354f3b850f916353f2658ae6f:

  Linux 6.9-rc2 (2024-03-31 14:32:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v6.10

for you to fetch changes up to 5fbf8734fb36cf67339f599f0e51747a6aff690c:

  hwmon: (nzxt-kraken3) Bail out for unsupported device variants (2024-05-12 16:50:11 -0700)

----------------------------------------------------------------
hwmon updates for v6.10

* New drivers

  - Infineon XDP710

  - EC Chip driver for Lenovo ThinkStation motherboards

  - Analog Devices ADP1050

* Improved support for existing drivers

  - emc1403: Convert to with_info API; Support for EMC1428 and EMC1438

  - nzxt-kraken3: Support for NZXT Kraken 2023

  - aquacomputer_d5next: Support for Octo flow sensors

  - pmbus/adm1275: Support for ADM1281

  - dell-smm: Supportt for Precision 7540 and G5 5505

* Other notable cleanup

  - max6639: Use regmap

  - Remove unused structure fields from multiple drivers

  - Drop explicit initialization of struct i2c_device_id::driver_data to 0

  - Improve configuration mode handling in it87 driver

  - jc42: Drop support for I2C_CLASS_SPD

  - Various conversions to devicetree schema

  - Add HAS_IOPORT dependencies as needed

* Minor fixes and improvements to max31790, coretemp, aspeed-g6-pwm-tach,
  pwm-fan, pmbus/mp2975, acpi_power_meter, and lm70 drivers

----------------------------------------------------------------
Aleksa Savic (4):
      hwmon: (aquacomputer_d5next) Add support for Octo flow sensor
      hwmon: (aquacomputer_d5next) Add support for Octo flow sensor pulses
      hwmon: (nzxt-kraken3) Decouple device names from kinds
      hwmon: (nzxt-kraken3) Add support for NZXT Kraken 2023 (standard and Elite) models

Andy Shevchenko (6):
      hwmon: (pmbus/adp1050) Don't use "proxy" headers
      hwmon: (pmbus/mp2975) Replace home made version of __assign_bit()
      hwmon: (pmbus/mp2975) Constify local pointers to pmbus_driver_info
      hwmon: (pmbus/mp2975) Use i2c_get_match_data()
      hwmon: (pwm-fan) Convert to use of_property_read_u32_array()
      hwmon: (pwm-fan) Make use of device properties

Christophe JAILLET (3):
      hwmon: (stts751) Remove an unused field in struct stts751_priv
      hwmon: (npcm750-pwm-fan) Remove an unused field in struct npcm7xx_cooling_device
      hwmon: (npcm750-pwm-fan) Remove another unused field in struct npcm7xx_cooling_device

David Ober (1):
      hwmon: Add EC Chip driver for Lenovo ThinkStation motherboards

Delphine CC Chiu (1):
      hwmon: (max31790) revise the scale to write pwm

Frank Crawford (4):
      hwmon: (it87) Rename FEAT_CONF_NOEXIT to FEAT_NOCONF as more descriptive of requirement
      hwmon: (it87) Do not enter configuration mode for some chiptypes
      hwmon: (it87) Test for chipset before entering configuration mode
      hwmon: (it87) Remove tests nolonger required

Guenter Roeck (4):
      hwmon: (emc1403) Convert to with_info API
      hwmon: (emc1403) Support 11 bit accuracy
      hwmon: (emc1403) Add support for conversion interval configuration
      hwmon: (nzxt-kraken3) Bail out for unsupported device variants

Heiner Kallweit (1):
      hwmon: (jc42) Remove I2C_CLASS_SPD support

Javier Carrasco (8):
      dt-bindings: hwmon: adc128d818: convert to dtschema
      dt-bindings: hwmon: lm87: convert to dtschema
      dt-bindings: hwmon: max6650: convert to dtschema
      dt-bindings: hwmon: as370: convert to dtschema
      dt-bindings: hwmon: ibmpowernv: convert to dtschema
      dt-bindings: hwmon: pwm-fan: drop text file
      dt-bindings: hwmon: stts751: convert to dtschema
      dt-bindings: hwmon: ibm,p8-occ-hwmon: move to trivial devices

Jose Ramon San Buenaventura (2):
      dt-bindings: hwmon: adm1275: add adm1281
      hwmon: (pmbus/adm1275) add adm1281 support

Kai-Heng Feng (2):
      ACPI: IPMI: Add helper to wait for when SMI is selected
      hwmon: (acpi_power_meter) Ensure IPMI space handler is ready on Dell systems

Kousik Sanagavarapu (1):
      hwmon: (lm70) fix links in doc and comments

Lars Petter Mostad (1):
      hwmon: (emc1403) Add support for EMC1428 and EMC1438.

Lukas Bulwahn (1):
      MAINTAINERS: repair file entry in ADP1050 HARDWARE MONITOR DRIVER

Naresh Solanki (1):
      hwmon: (max6639) Use regmap

Niklas Schnelle (1):
      hwmon: add HAS_IOPORT dependencies

Patrick Rudolph (1):
      hwmon: (pmbus/mp2975) Fix IRQ masking

Peter Yin (2):
      dt-bindings: hwmon: Add infineon xdp710 driver bindings
      hwmon: (pmbus) Add support for Infineon XDP710

Radu Sabau (2):
      dt-bindings: hwmon: pmbus: adp1050: add bindings
      hwmon: (pmbus) Add driver for ADP1050

Ricardo Neri (1):
      hwmon: (coretemp) Extend the bitmask to read temperature to 0xff

Seiji Nishikawa (1):
      hwmon: (dell-smm) Add Dell Precision 7540 to fan control whitelist

Tobias Jakobi (1):
      hwmon: (dell-smm) Add Dell G5 5505 to DMI table

Uwe Kleine-König (3):
      hwmon: (aspeed-g6-pwm-tach) Convert to platform remove callback returning void
      hwmon: Drop explicit initialization of struct i2c_device_id::driver_data to 0
      hwmon: Drop explicit initialization of struct i2c_device_id::driver_data to 0 (part 2)

 .../devicetree/bindings/hwmon/adc128d818.txt       |  38 -
 .../devicetree/bindings/hwmon/adi,adm1275.yaml     |   4 +-
 Documentation/devicetree/bindings/hwmon/as370.txt  |  11 -
 .../devicetree/bindings/hwmon/ibm,opal-sensor.yaml |  37 +
 .../devicetree/bindings/hwmon/ibm,p8-occ-hwmon.txt |  25 -
 .../devicetree/bindings/hwmon/ibmpowernv.txt       |  23 -
 Documentation/devicetree/bindings/hwmon/lm87.txt   |  30 -
 .../devicetree/bindings/hwmon/max6650.txt          |  28 -
 .../devicetree/bindings/hwmon/maxim,max6650.yaml   |  70 ++
 .../bindings/hwmon/pmbus/adi,adp1050.yaml          |  49 ++
 .../devicetree/bindings/hwmon/pwm-fan.txt          |   1 -
 .../devicetree/bindings/hwmon/st,stts751.yaml      |  41 +
 .../devicetree/bindings/hwmon/stts751.txt          |  15 -
 .../devicetree/bindings/hwmon/syna,as370.yaml      |  32 +
 .../devicetree/bindings/hwmon/ti,adc128d818.yaml   |  63 ++
 .../devicetree/bindings/hwmon/ti,lm87.yaml         |  69 ++
 .../devicetree/bindings/trivial-devices.yaml       |   4 +
 Documentation/hwmon/adm1275.rst                    |  14 +-
 Documentation/hwmon/adp1050.rst                    |  64 ++
 Documentation/hwmon/aquacomputer_d5next.rst        |   9 +-
 Documentation/hwmon/emc1403.rst                    |  17 +-
 Documentation/hwmon/index.rst                      |   2 +
 Documentation/hwmon/lm70.rst                       |   2 +-
 Documentation/hwmon/nzxt-kraken3.rst               |  19 +-
 Documentation/hwmon/pmbus.rst                      |   2 +-
 Documentation/hwmon/xdp710.rst                     |  83 ++
 MAINTAINERS                                        |   7 +
 drivers/acpi/acpi_ipmi.c                           |  23 +-
 drivers/hwmon/Kconfig                              |  38 +-
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/acpi_power_meter.c                   |  16 +
 drivers/hwmon/ad7414.c                             |   2 +-
 drivers/hwmon/adc128d818.c                         |   2 +-
 drivers/hwmon/adm1026.c                            |   2 +-
 drivers/hwmon/adm1029.c                            |   2 +-
 drivers/hwmon/adm1177.c                            |   2 +-
 drivers/hwmon/adt7410.c                            |   4 +-
 drivers/hwmon/adt7411.c                            |   2 +-
 drivers/hwmon/adt7462.c                            |   2 +-
 drivers/hwmon/adt7470.c                            |   2 +-
 drivers/hwmon/aquacomputer_d5next.c                |  51 +-
 drivers/hwmon/asb100.c                             |   2 +-
 drivers/hwmon/aspeed-g6-pwm-tach.c                 |   6 +-
 drivers/hwmon/atxp1.c                              |   2 +-
 drivers/hwmon/coretemp.c                           |   2 +-
 drivers/hwmon/dell-smm-hwmon.c                     |  15 +
 drivers/hwmon/ds620.c                              |   2 +-
 drivers/hwmon/emc1403.c                            | 846 ++++++++++++++-------
 drivers/hwmon/emc2103.c                            |   2 +-
 drivers/hwmon/emc2305.c                            |   8 +-
 drivers/hwmon/emc6w201.c                           |   2 +-
 drivers/hwmon/ftsteutates.c                        |   2 +-
 drivers/hwmon/g760a.c                              |   2 +-
 drivers/hwmon/g762.c                               |   4 +-
 drivers/hwmon/gl518sm.c                            |   2 +-
 drivers/hwmon/gl520sm.c                            |   2 +-
 drivers/hwmon/hih6130.c                            |   2 +-
 drivers/hwmon/hs3001.c                             |   2 +-
 drivers/hwmon/ina209.c                             |   2 +-
 drivers/hwmon/ina238.c                             |   2 +-
 drivers/hwmon/ina3221.c                            |   2 +-
 drivers/hwmon/it87.c                               | 127 ++--
 drivers/hwmon/jc42.c                               |   4 +-
 drivers/hwmon/lenovo-ec-sensors.c                  | 602 +++++++++++++++
 drivers/hwmon/lineage-pem.c                        |   2 +-
 drivers/hwmon/lm70.c                               |   4 +-
 drivers/hwmon/lm73.c                               |   2 +-
 drivers/hwmon/lm77.c                               |   2 +-
 drivers/hwmon/lm87.c                               |   4 +-
 drivers/hwmon/lm93.c                               |   4 +-
 drivers/hwmon/lm95241.c                            |   4 +-
 drivers/hwmon/lm95245.c                            |   4 +-
 drivers/hwmon/ltc2945.c                            |   2 +-
 drivers/hwmon/ltc2947-i2c.c                        |   2 +-
 drivers/hwmon/ltc2990.c                            |   2 +-
 drivers/hwmon/ltc2991.c                            |   2 +-
 drivers/hwmon/ltc2992.c                            |   2 +-
 drivers/hwmon/ltc4151.c                            |   2 +-
 drivers/hwmon/ltc4215.c                            |   2 +-
 drivers/hwmon/ltc4222.c                            |   2 +-
 drivers/hwmon/ltc4245.c                            |   2 +-
 drivers/hwmon/ltc4260.c                            |   2 +-
 drivers/hwmon/ltc4261.c                            |   2 +-
 drivers/hwmon/max127.c                             |   2 +-
 drivers/hwmon/max1619.c                            |   2 +-
 drivers/hwmon/max31730.c                           |   2 +-
 drivers/hwmon/max31790.c                           |  10 +-
 drivers/hwmon/max6620.c                            |   2 +-
 drivers/hwmon/max6621.c                            |   2 +-
 drivers/hwmon/max6639.c                            | 341 ++++-----
 drivers/hwmon/max6642.c                            |   2 +-
 drivers/hwmon/mc34vr500.c                          |   2 +-
 drivers/hwmon/nct7802.c                            |   2 +-
 drivers/hwmon/nct7904.c                            |   2 +-
 drivers/hwmon/npcm750-pwm-fan.c                    |   7 +-
 drivers/hwmon/nzxt-kraken3.c                       |  58 +-
 drivers/hwmon/pcf8591.c                            |   2 +-
 drivers/hwmon/pmbus/Kconfig                        |  23 +-
 drivers/hwmon/pmbus/Makefile                       |   2 +
 drivers/hwmon/pmbus/adm1266.c                      |   2 +-
 drivers/hwmon/pmbus/adm1275.c                      |   7 +-
 drivers/hwmon/pmbus/adp1050.c                      |  56 ++
 drivers/hwmon/pmbus/inspur-ipsps.c                 |   2 +-
 drivers/hwmon/pmbus/ir35221.c                      |   2 +-
 drivers/hwmon/pmbus/ir36021.c                      |   2 +-
 drivers/hwmon/pmbus/ir38064.c                      |   8 +-
 drivers/hwmon/pmbus/irps5401.c                     |   2 +-
 drivers/hwmon/pmbus/lt7182s.c                      |   2 +-
 drivers/hwmon/pmbus/ltc3815.c                      |   2 +-
 drivers/hwmon/pmbus/max15301.c                     |   4 +-
 drivers/hwmon/pmbus/max16064.c                     |   2 +-
 drivers/hwmon/pmbus/max20751.c                     |   2 +-
 drivers/hwmon/pmbus/max31785.c                     |   6 +-
 drivers/hwmon/pmbus/max8688.c                      |   2 +-
 drivers/hwmon/pmbus/mp2888.c                       |   2 +-
 drivers/hwmon/pmbus/mp2975.c                       | 136 +++-
 drivers/hwmon/pmbus/mp5990.c                       |   2 +-
 drivers/hwmon/pmbus/mpq8785.c                      |   2 +-
 drivers/hwmon/pmbus/pli1209bc.c                    |   2 +-
 drivers/hwmon/pmbus/pm6764tr.c                     |   2 +-
 drivers/hwmon/pmbus/pxe1610.c                      |   6 +-
 drivers/hwmon/pmbus/stpddc60.c                     |   4 +-
 drivers/hwmon/pmbus/tda38640.c                     |   2 +-
 drivers/hwmon/pmbus/tps40422.c                     |   2 +-
 drivers/hwmon/pmbus/tps546d24.c                    |   2 +-
 drivers/hwmon/pmbus/xdp710.c                       | 131 ++++
 drivers/hwmon/pmbus/xdpe12284.c                    |   6 +-
 drivers/hwmon/pmbus/xdpe152c4.c                    |   4 +-
 drivers/hwmon/pt5161l.c                            |   2 +-
 drivers/hwmon/pwm-fan.c                            |  45 +-
 drivers/hwmon/sbrmi.c                              |   2 +-
 drivers/hwmon/sbtsi_temp.c                         |   2 +-
 drivers/hwmon/sht21.c                              |   2 +-
 drivers/hwmon/sht4x.c                              |   2 +-
 drivers/hwmon/smsc47m192.c                         |   2 +-
 drivers/hwmon/stts751.c                            |   3 +-
 drivers/hwmon/tc654.c                              |   4 +-
 drivers/hwmon/tc74.c                               |   2 +-
 drivers/hwmon/tmp102.c                             |   2 +-
 drivers/hwmon/tmp103.c                             |   2 +-
 drivers/hwmon/tmp108.c                             |   2 +-
 drivers/hwmon/w83791d.c                            |   2 +-
 drivers/hwmon/w83792d.c                            |   2 +-
 drivers/hwmon/w83793.c                             |   2 +-
 drivers/hwmon/w83l785ts.c                          |   2 +-
 drivers/hwmon/w83l786ng.c                          |   2 +-
 include/acpi/acpi_bus.h                            |   5 +
 147 files changed, 2582 insertions(+), 968 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/hwmon/adc128d818.txt
 delete mode 100644 Documentation/devicetree/bindings/hwmon/as370.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/ibm,opal-sensor.yaml
 delete mode 100644 Documentation/devicetree/bindings/hwmon/ibm,p8-occ-hwmon.txt
 delete mode 100644 Documentation/devicetree/bindings/hwmon/ibmpowernv.txt
 delete mode 100644 Documentation/devicetree/bindings/hwmon/lm87.txt
 delete mode 100644 Documentation/devicetree/bindings/hwmon/max6650.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max6650.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/adi,adp1050.yaml
 delete mode 100644 Documentation/devicetree/bindings/hwmon/pwm-fan.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/st,stts751.yaml
 delete mode 100644 Documentation/devicetree/bindings/hwmon/stts751.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/syna,as370.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/ti,adc128d818.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/ti,lm87.yaml
 create mode 100644 Documentation/hwmon/adp1050.rst
 create mode 100644 Documentation/hwmon/xdp710.rst
 create mode 100644 drivers/hwmon/lenovo-ec-sensors.c
 create mode 100644 drivers/hwmon/pmbus/adp1050.c
 create mode 100644 drivers/hwmon/pmbus/xdp710.c

