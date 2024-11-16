Return-Path: <linux-kernel+bounces-411732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A989CFEFE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 14:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 541A81F2367C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 13:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7421993B6;
	Sat, 16 Nov 2024 13:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCL2+psk"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10697190468;
	Sat, 16 Nov 2024 13:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731762631; cv=none; b=SevJY9cyKmAkg6W2XIY2ZePnRgOoBdVBOFmr9+W/v/EfUBnyDHNQgUeVbJrgm6n2jpo6QtAhKk1Va3wUf76fvKMCl0sYc3ZVoQKdG90vSRyaIyQh0tFhUEXAzprPM8GqQgNNzjAapDj7d4weZOeNr7x8KuzhtRfWdErA/skQox8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731762631; c=relaxed/simple;
	bh=gVGVqOq7uXtzj1rz8P4MsrVEHcULhIjk4fPat9AsyRU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cppiKe8TkFRaPMIk1LphDvLbUiF6NVXn39tmKoeHb+RAdr81MMeWd+Y3C6ZSBZ++0/F2WOX6sXPjU0q0iWvshupZTtorwBWT2Pphhiz7YHYmrl+BeB2eJ8o3/0GffuD3bZvEPRgDb1YPX/IHVfFYLRaknocTtnl4rbLciA2dQM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCL2+psk; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4315ce4d250so1923665e9.2;
        Sat, 16 Nov 2024 05:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731762628; x=1732367428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9iqbdM7kNZ/+3rab6reN6VV15BR7su8vopmTeFTw4+M=;
        b=CCL2+pskGexkem7nsx0XtptYg5+qA5caEg7SY79jkOhQ4Pn6PjxbEpayMpZcMBCOk7
         Hlfjd1YoEUV69cYTOJLtLJg1SRfo6LbCAl+k/uM3qhDP1R9fyBlrcP2YI7VnTuu26axw
         LrOUfarO6jIhwyp+cDyZRknOCu49zbJrbyEHlNpPg08g51REo3uyHoUszWQ0xxXaswh9
         /YSkw1rQiUQGy1yZ0m+lmV5UI4Wrm7or/5M75FaSCXPGnqHyMccmX0fVLRNdONr3nVMU
         znqE30IAF7cDrFaEUJE96xyuhQSnbNlcbUUVLK6u64RutFjFrBqn3sVN4dNzkjwKpI/E
         VxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731762628; x=1732367428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9iqbdM7kNZ/+3rab6reN6VV15BR7su8vopmTeFTw4+M=;
        b=Bf6NTMpbhtLCVbQTanl1mYand0TV2OA5IYRNcdixBPN1g6NvWJ+t4scREPpQH6Ypnq
         A3JXr7XVTM2myt+n2FoO138SjjR4HFsGekeYokYepcZ+PhB5ce/DCu3gb0RqsvD5IYGp
         3mghTsix2zXTZ4zIFJKNFxIBXAr4qIDgBGXS3i0vwJECmX5Rd5py+asW4pjdbL91m1cC
         7cWKlOE9rD/XaDkWHoCgXlRz6QEv5Ql3tnFWwLBWjOE1cRmKTjsqzLsYMibHKF7SIHdO
         IJgiI9sgmFPTEmhF9oqC30N5lFXTEHJSjFD/CzqbyzLZVcAiRmgnnINXWfx7vZ2Ipfj1
         SJvg==
X-Forwarded-Encrypted: i=1; AJvYcCUZbaFPGvlgJysfeeh+4NN18qTwq8x+A866OaQFk3e6Xl52Mva4ACHPfziJ3nHMWdsPmwZF9nP1VoVyZTBv@vger.kernel.org, AJvYcCWtsyk9xH+P6NTNOiu7WX7WPzreAjAZMhQSzGB9BOfh9gSQup3s8/3utw7FFypDMwMnS+zOLy33WqZe@vger.kernel.org
X-Gm-Message-State: AOJu0YwPRDBFM6BdECSetu+NIk7xFmU680s5U5o6CHjL5e2eHga3pagj
	E6tmeMc6CfAOsYVzO9W9PmjAWnlWYspyVHUVKWX60PfrlmqMmUYt
X-Google-Smtp-Source: AGHT+IE3nIVH2QuMmOKV9l14mgj8Dp3kwFNCRaMSGMZNFej+xLe37i1mxhEODWlajGs9a444YZmecQ==
X-Received: by 2002:a05:600c:4f8a:b0:42c:b9c8:2ba9 with SMTP id 5b1f17b1804b1-432df78f5a7mr22333835e9.6.1731762627087;
        Sat, 16 Nov 2024 05:10:27 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da28ba80sm92424375e9.29.2024.11.16.05.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 05:10:26 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org
Cc: marex@denx.de,
	s.trumtrar@pengutronix.de,
	l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 00/11] Add Enclustra Arria10 and Cyclone5 SoMs
Date: Sat, 16 Nov 2024 13:10:14 +0000
Message-Id: <20241116131025.114542-1-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
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

All of the above can be freely combined. Combinations are covered by
the provided .dts files. This makes an already existing .dts file
obsolete. Further minor fixes of the dtbs_checks are added separtely.

The current approach is also required  for corresponding bootloader
integration using dts/upstream. That's also one of the reasons for
the .dtsi split.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
v4 -> v5:
- separate generic socfpga dt fixes from this patch set. The focus of this
  patch set is the dts/dtsi files and related bindings, not additional
  intel/socfpga refactoring

v3 -> v4:
- add separate patch to match "snps,dwmac" compatible in corresponding
  driver, required by binding check
- replace non-standard node names in .dtsi files by node names recommended
  by the device tree standard v0.4

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
Lothar Rubusch (11):
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
 arch/arm/boot/dts/intel/socfpga/Makefile      |  25 ++-
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
 36 files changed, 971 insertions(+), 78 deletions(-)
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
2.39.2


