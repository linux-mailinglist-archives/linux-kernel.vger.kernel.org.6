Return-Path: <linux-kernel+bounces-383650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEE99B1EC2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 15:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E325B281A98
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 14:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB88716C684;
	Sun, 27 Oct 2024 14:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6SooLCK"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A8CC13B;
	Sun, 27 Oct 2024 14:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730039821; cv=none; b=iTFYJX00zWmdKJE1oi2qNLEtMM9Wa+H2nyCjVo+6+DBIBaz4UrxKXhKZ/ANYfTi9kI1Z6WEFBaNkbxh6AUg/nU8e3B1nYlAsqqRa2CohtWAXfdETH7LMeAqyfSdVoLuuptrTAV3J52FehXrCltXd/4yBL2gzvkcNSnVhGhBn/TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730039821; c=relaxed/simple;
	bh=xwWOu7nT23G4YyhQSEEXcfToiXRqnUTQONgVDT6QpY4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EUuanwrvWaVQxtZ7Dm7e3SC0D0KPBS3xd44kFiR3Ic9gbKgPdmQI8mGunGrVmCsvn7gQ8dRshU5l8Uff/xtURuMOCfQY389I6qCe0XRZfLvxqC5NaBP7LF2cPswJoBOD0GIV11xgpn+ho6u0p9t4LfuET4oL5FM99Yjyi+p4Reo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6SooLCK; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a966de2f4d3so43925466b.2;
        Sun, 27 Oct 2024 07:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730039817; x=1730644617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4UZPYEQoi3bWFcLqWNqHS8KS5U5p0uA6DEBBD7qYfXU=;
        b=A6SooLCKQQ8KadgrOfLjDxShdkvTSRGM3uuy7Ka2+5Ng3lyl7ymshv5sRGwPFtEbrf
         TIx94+BoTBtVmk8TUA6WSzDKNY7QQdoYDwPkdAvczO1N9I32BaqvsI7U5O3Ssu+D66IN
         h6bDR8H/wimBsw8NohN8oy5HIAgYiaW/Nvzio9ggl81n0EnUhVKrax/fWfcEadHHHgp+
         CFY/ej6Mpe1sha6YxFln2etKi7Nzerfvz9g9cBA7+Wvu0CBh8agX3ty+qZINo2gqgBWj
         TjU3DSJcHxcqaCdgWpiNrg3K1jwLLaV/yX1XkXg9bqlWmLrG0INwgD1zQLlMb4AH6yIz
         xSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730039817; x=1730644617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4UZPYEQoi3bWFcLqWNqHS8KS5U5p0uA6DEBBD7qYfXU=;
        b=MLQIkLguYSJUhR93Sqs/WROn15jQkHSbFHpJJIDYJ+h4LvTW9A/nwFDRjOPu4Waa/0
         3fzkiciJhgfdJ3oiVpDLwDnuN4l06obl/SBa32WrPaXotIA7yhAd9LF4MYc/2AubqeYb
         ZxnPzQidexhgEdRGLUZ4ZazY9rHBpdDIZDQbCS+zq8zweHfi4uIHu2wBbWaaNiafLsgr
         s1l5YHVqTqcEbv2XrwV2LRBwT08iyFRlJlhV4lhNwT6Glp+T8NhBLP9ZtKO/GxHqHfRi
         ulRq1s+iMU0WQX09t8j1QpGKq8vxrksq8P3KqOcIP3GES9r2vTlEyQdPT8BhYXJZ+Arx
         u9vQ==
X-Forwarded-Encrypted: i=1; AJvYcCVh8MhJpSR6izqHPkX2KpxcdXsCUiwCpTey0+Urt2LGX45rnQra8t1z9IdBRppAHnXIrZYq1Y/s3vik@vger.kernel.org, AJvYcCX+9+wngf6naxpUT8En08lBDULnz9SZ+CHapZa01LKMwe4MH/Oxx29T3FxZbiEDk6QshmG7DYaZtxPP8mG7@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9R406+ELu5TO0HyZe9BXl+NZ/Nla+cgRd7se8EpIJIAMiIeZi
	diAz6K/3VrVRs6O3vo0s5ji1MocypjM4iXnuKr3X12iOrJeNDwBP
X-Google-Smtp-Source: AGHT+IGrhLfsAvm7TepnFYyZFnNQnvfJfyNs0C2+I2pIVsJ8VkyulgKGiaYw+Lrrobm93JwEWI7z/g==
X-Received: by 2002:a17:906:6a24:b0:a9a:3dc0:e128 with SMTP id a640c23a62f3a-a9de5d91898mr242991066b.4.1730039816580;
        Sun, 27 Oct 2024 07:36:56 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b331b0d44sm281127966b.187.2024.10.27.07.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 07:36:56 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	a.fatoum@pengutronix.de
Cc: conor+dt@kernel.org,
	dinguyen@kernel.org,
	marex@denx.de,
	s.trumtrar@pengutronix.de,
	l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv3 00/22] Add Enclustra Arria10 and Cyclone5 SoMs
Date: Sun, 27 Oct 2024 14:36:32 +0000
Message-Id: <20241027143654.28474-1-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device-tree support for the following SoMs:

- Mercury SA1 (cyclone5)
- Mercury+ SA2 (cyclone5)
- Mercury+ AA1 (arria10)

Further add device-tree support for the corresponding carrier boards:

- Mercury+ PE1
- Mercury+ PE3
- Mercury+ ST1

Finally, provide generic support for combinations of the above with
one of the boot-modes
- SD
- eMMC
- QSPI

Almost all of the above can be freely combined. Combinations are
covered by the provided .dts files. This makes an already existing
.dts file obsolete. Further minor fixes of the dtbs_checks are
added separtely.

The current approach shall be partly useful also for corresponding
bootloader integration using dts/upstream. That's also one of the
reasons for the .dtsi split.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
v2 -> v3:
- dropped the patch to add the socfpga clock bindings:
  Documentation/devicetree/bindings/clock/altr,socfpga-a10.yaml
  reason: refactoring the "altr,socfpga-" TXT files to .yaml files is a
  different story involving several other files, thus can be part of a
  future patch series, not related to the current upstreaming the
  Enclustra DTS support, so dropped
- adjust comments on boot mode selection
- adjust titles to several bindings patches

v1 -> v2:
- split bindings and DT adjustments/additions
- add several fixes to the socfpga.dtsi and socfpga_arria10.dtsi where
  bindings did not match
- extend existing bindings by properties and nods from arria10 setup
- implement the clock binding altr,socfpga-a10.yaml based on existing
  text file, rudimentary datasheet study and requirements of the
  particular DT setup
---
Lothar Rubusch (22):
  ARM: dts: socfpga: fix typo
  ARM: dts: socfpga: align bus name with bindings
  ARM: dts: socfpga: align dma name with binding
  ARM: dts: socfpga: align fpga-region name
  ARM: dts: socfpga: add label to clock manager
  ARM: dts: socfpga: add missing cells properties
  ARM: dts: socfpga: fix missing ranges
  ARM: dts: socfpga: add clock-frequency property
  ARM: dts: socfpga: add ranges property to sram
  ARM: dts: socfpga: remove arria10 reset-names
  dt-bindings: net: snps,dwmac: add support for Arria10
  ARM: dts: socfpga: add Enclustra boot-mode dtsi
  ARM: dts: socfpga: add Enclustra base-board dtsi
  ARM: dts: socfpga: add Enclustra Mercury SA1
  dt-bindings: altera: add Enclustra Mercury SA1
  ARM: dts: socfpga: add Enclustra Mercury+ SA2
  dt-bindings: altera: add binding for Mercury+ SA2
  ARM: dts: socfpga: add Mercury AA1 combinations
  dt-bindings: altera: add Mercury AA1 combinations
  ARM: dts: socfpga: removal of generic PE1 dts
  dt-bindings: altera: removal of generic PE1 dts
  ARM: dts: socfpga: add Enclustra SoM dts files

 .../devicetree/bindings/arm/altera.yaml       |  24 ++-
 .../devicetree/bindings/net/snps,dwmac.yaml   |   2 +
 arch/arm/boot/dts/intel/socfpga/Makefile      |  25 ++-
 arch/arm/boot/dts/intel/socfpga/socfpga.dtsi  |   6 +-
 .../dts/intel/socfpga/socfpga_arria10.dtsi    |  26 ++--
 .../socfpga/socfpga_arria10_mercury_aa1.dtsi  | 141 ++++++++++++++---
 .../socfpga_arria10_mercury_aa1_pe1_emmc.dts  |  16 ++
 .../socfpga_arria10_mercury_aa1_pe1_qspi.dts  |  16 ++
 .../socfpga_arria10_mercury_aa1_pe1_sdmmc.dts |  16 ++
 .../socfpga_arria10_mercury_aa1_pe3_emmc.dts  |  16 ++
 .../socfpga_arria10_mercury_aa1_pe3_qspi.dts  |  16 ++
 .../socfpga_arria10_mercury_aa1_pe3_sdmmc.dts |  16 ++
 .../socfpga_arria10_mercury_aa1_st1_emmc.dts  |  16 ++
 .../socfpga_arria10_mercury_aa1_st1_qspi.dts  |  16 ++
 .../socfpga_arria10_mercury_aa1_st1_sdmmc.dts |  16 ++
 .../socfpga/socfpga_arria10_mercury_pe1.dts   |  55 -------
 .../socfpga/socfpga_cyclone5_mercury_sa1.dtsi | 143 +++++++++++++++++
 .../socfpga_cyclone5_mercury_sa1_pe1_emmc.dts |  16 ++
 .../socfpga_cyclone5_mercury_sa1_pe1_qspi.dts |  16 ++
 ...socfpga_cyclone5_mercury_sa1_pe1_sdmmc.dts |  16 ++
 .../socfpga_cyclone5_mercury_sa1_pe3_emmc.dts |  16 ++
 .../socfpga_cyclone5_mercury_sa1_pe3_qspi.dts |  16 ++
 ...socfpga_cyclone5_mercury_sa1_pe3_sdmmc.dts |  16 ++
 .../socfpga_cyclone5_mercury_sa1_st1_emmc.dts |  16 ++
 .../socfpga_cyclone5_mercury_sa1_st1_qspi.dts |  16 ++
 ...socfpga_cyclone5_mercury_sa1_st1_sdmmc.dts |  16 ++
 .../socfpga/socfpga_cyclone5_mercury_sa2.dtsi | 146 ++++++++++++++++++
 .../socfpga_cyclone5_mercury_sa2_pe1_qspi.dts |  16 ++
 ...socfpga_cyclone5_mercury_sa2_pe1_sdmmc.dts |  16 ++
 .../socfpga_cyclone5_mercury_sa2_pe3_qspi.dts |  16 ++
 ...socfpga_cyclone5_mercury_sa2_pe3_sdmmc.dts |  16 ++
 .../socfpga_cyclone5_mercury_sa2_st1_qspi.dts |  16 ++
 ...socfpga_cyclone5_mercury_sa2_st1_sdmmc.dts |  16 ++
 ...cfpga_enclustra_mercury_bootmode_emmc.dtsi |  12 ++
 ...cfpga_enclustra_mercury_bootmode_qspi.dtsi |   8 +
 ...fpga_enclustra_mercury_bootmode_sdmmc.dtsi |   8 +
 .../socfpga_enclustra_mercury_pe1.dtsi        |  33 ++++
 .../socfpga_enclustra_mercury_pe3.dtsi        |  55 +++++++
 .../socfpga_enclustra_mercury_st1.dtsi        |  15 ++
 39 files changed, 990 insertions(+), 93 deletions(-)
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe1_emmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe1_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe1_sdmmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe3_emmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe3_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe3_sdmmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_st1_emmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_st1_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_st1_sdmmc.dts
 delete mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_pe1.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1.dtsi
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe1_emmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe1_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe1_sdmmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe3_emmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe3_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe3_sdmmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_st1_emmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_st1_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_st1_sdmmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2.dtsi
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe1_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe1_sdmmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe3_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe3_sdmmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_st1_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_st1_sdmmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_emmc.dtsi
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_qspi.dtsi
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_sdmmc.dtsi
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_pe1.dtsi
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_pe3.dtsi
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_st1.dtsi

-- 
2.25.1


