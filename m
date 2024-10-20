Return-Path: <linux-kernel+bounces-373390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 162CD9A5637
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 21:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72083B2199A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 19:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452DB19755B;
	Sun, 20 Oct 2024 19:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGqmEBeI"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AF02B9A5;
	Sun, 20 Oct 2024 19:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729453234; cv=none; b=hFQCumVBwHVpqjUJ1ZCXT2voOy5cwtEpibV3u/KtNgVpWPDe3X4OJeUPqHFSIOZ5EqIiuZFLY2NfjGqbrcUGoaK9qPxkcjS7FXAaC6Sh4272ckic3JofDOTmAmbgQzJyr9tvAqxeF5j/CSjRrnZ9xNFqYnojRNvZFj4rMRkNYc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729453234; c=relaxed/simple;
	bh=dr130A5GQ2lBUget9rpDZpLccc1BqWSVhd3YtQ/e+jo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OngLX65QGN2i7l87wG2bCxypK3Q6agOkMjC0QLClTecHVfDkQkkavsQ5S3K3BxFErEnK6GH38W6Ie6RhF14x7TgPkMUsnil1J0RaBTCaQS5eMgy7U14PxcHDRbxZXlybFkStOkHGkTze4+33ojRYoc91mITUEfT97al0iAKubBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGqmEBeI; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c93346dfc8so483641a12.3;
        Sun, 20 Oct 2024 12:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729453230; x=1730058030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Itsp4INdusxqJHDPUbKXM08ZzVa355fgp9+sYyVFtJU=;
        b=dGqmEBeIFepeqDn8S7niVG7hmz2eDD9GSdaXdBPaPdFEWFCEWCxwrM7FPWjD+vq9bi
         402LBBm+USk+568hENJCpAZOPk75g/1sohL12o37QV/x2dMbzI5KojA6neuz5hzxOJqS
         Ji7lzhbe77JhORdC6i6wtoFwQlejMvz+9ua1C+YCDmiCVi6F000ab5AgF9pIx2JDNlio
         /P1ZdWippkahfdiX9IVMz+c3bLOzkoN4GNeOX0MpXUCGtL4ed4nHN46Xkg0puJ9XO+Do
         Qcrtjrmj+nqL8KstEBntT2vDujFVYveHDZ0OVeXzW9AecQlHOTynZdcu24Wczy+HMNbB
         RFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729453230; x=1730058030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Itsp4INdusxqJHDPUbKXM08ZzVa355fgp9+sYyVFtJU=;
        b=Qf5yqwZFbRJQEarkJ4znBgf4i1A2ezX5QYNOSGWM54O9kkGvIomvPSfxWSealLZfYW
         VTv+SopMb6RXf07wDuOtyPkaskH3IkGrAPzZfcaYBm9eNJ3/nHmcUdFaHPIGQ04c6THK
         IathPMhjgrljNRhlL+GzO/wBBTLsh5M+M9rkJ6b0rSjpl1+fAuN5+2JBQ4262HXg59k+
         N1D8wC4lR9zB8LKDNhg1jdBHeAq5Ae0T0hvZRHe6N6ONp0zHbmnfDy+8VMSDPO0s0yx6
         6P4NFGIF5EITmatOt4k8+bkpMIKLWp3qMZ7szmT8PTmZmdJ6Euix9tGBu8jDIKtUax+M
         Md+A==
X-Forwarded-Encrypted: i=1; AJvYcCUf7AA8W4ZyoUEJTy1sbbNOcb8zUGaFHuTn2xvItathia3+D4sLDpZKFHx6mJgY1qZrSQlg07Xl9li6@vger.kernel.org, AJvYcCV4f6OVO4NI5KCcTmiUp+qvgz61fSccCpS89eIjXT3NV6CGDLFUsYzCE9olFd8xbzpf+Q3GqeAMlTBrlDQ5@vger.kernel.org
X-Gm-Message-State: AOJu0YyZi1KPheNCQ9evkKlp11jwH4rAmxNHE7mbO8JNTX9seuNwhrz9
	M2lwYl0bYbKsBw9xhyzg99COf0PWJZvQcPVw1z8ckhHF58MXNbuQ
X-Google-Smtp-Source: AGHT+IEWdEYP2PkryaXCE0xuNP8Bi9bajm9vg8i90nr0xDvLpCLGGVnGGkL1SK7M1GrDP48I5oUG4g==
X-Received: by 2002:a17:906:2b4e:b0:a9a:410d:f86f with SMTP id a640c23a62f3a-a9a69ccf937mr316100366b.14.1729453230041;
        Sun, 20 Oct 2024 12:40:30 -0700 (PDT)
Received: from e8ff02ae9b18.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91578129sm120576966b.186.2024.10.20.12.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 12:40:29 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	marex@denx.de,
	s.trumtrar@pengutronix.de
Cc: l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv2 00/23] Add Enclustra Arria10 and Cyclone5 SoMs
Date: Sun, 20 Oct 2024 19:40:05 +0000
Message-Id: <20241020194028.2272371-1-l.rubusch@gmail.com>
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


Note: Pls, take this as a draft, in particular I have the following
open questions and would appreciate to get some short statement:

1.) Documentation/devicetree/bindings:
Executing the following find...
$ find ./Documentation/devicetree/bindings -name socfpga-\*.txt
...shows 4 text files describing "altr," bindings. I sketch-implemented
the clock binding and could reduce some of my dtbs_check warnings. So, my
questions is, if this is the right way? Shall I try to write .yaml files
for all 4 of them, too? Related to that, who will be maintainer?

2.) Some bindings, e.g. the Silabs clock generator seem to have no
driver, thus show up as warning:
    compatible = "silabs,si5338";
IMHO it is most likely rather to be probed/loaded in the SPL of the
bootloader. Is it problematic to keep those declarations (showing up as
warning in dtbs_check) or how to deal with them?

3.) Please, give me some feedback if the DT and binding adjustments are
going into total wrong direction, or where I may do better. If it is ok,
and acceptable, or what is still missing. I tried to split them, to
allow for better single integration / discussion let me know if this is
ok, too.

---
v1 -> v2:
- split bindings and DT adjustments/additions
- add several fixes to the socfpga.dtsi and socfpga_arria10.dtsi where
  bindings did not match
- extend existing bindings by properties and nods from arria10 setup
- implement the clock binding altr,socfpga-a10.yaml based on existing
  text file, rudimentary datasheet study and requirements of the
  particular DT setup
---
Lothar Rubusch (23):
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
  ARM: socfpga: dts: add compatibility for arria10
  ARM: socfpga: dts: add a10 clock binding yaml
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
 .../bindings/clock/altr,socfpga-a10.yaml      | 107 +++++++++++++
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
 40 files changed, 1097 insertions(+), 93 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/altr,socfpga-a10.yaml
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


