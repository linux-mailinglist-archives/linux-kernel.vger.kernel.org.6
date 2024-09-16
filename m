Return-Path: <linux-kernel+bounces-330806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B86297A48D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 707F91C21D2B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 14:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1716158555;
	Mon, 16 Sep 2024 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PvMcrIpm"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5D31DFCF
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 14:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726498439; cv=none; b=Y8x75LrH5WLj8heHZZF09rZP90ZPUtPpsUjhf51OoeWDlfhOSp715Ri3HvPQDW8j0oY1X7rcVPlwtoW0Vl5eYe008i0nF1U7/lQ4kFqF0DMWQLflM7mrDjcQo/+pgCxIhhtg95OP53fHB3V5jeOedXrIIkTn4zMu78rC4V5vwsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726498439; c=relaxed/simple;
	bh=Mjmos+lFXDQrHLZGm3QtPep32MMtVA3+jp+sLiL6FV0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J2Q2UZx26avUqN1POma0hlzHi4qZ+gSON2KMG1KDNnYrzaytr8wh5OdDLt7VAzpq3RDQiSvPYW3B+rpJT7yct1M/C6lVmutVQ8JFaGCOpnpC4grzFQBjlWmL/Kn/rI7U842xbs+MnS30BtcsjyDvpRAv7+BOQAndoXmCQNypnAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PvMcrIpm; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53653ee23adso4067263e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 07:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726498434; x=1727103234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hYQsqWRG/KA6HCUSesfPALyKBlmIx+m+eouyHIxt56E=;
        b=PvMcrIpmoQpF7GhJVWx/9ze0RTgNVvhIuObVpAnFJQmHPPUtUX3JB8faXpQJvmmM+d
         F6/smaXp20Snv3I1KC0mGzDtWSRsN94j3GwKyVBXh2/ME93z6q9qyo0WHAKC2FtfQjkJ
         NSt4rK7L++aFj1Cr7bwUgBq7vcDyKZQ0imeDXgA0DZg3lOpPWBFFpf2eft0Vb514gOn5
         9WE67QwEts4bnL6/qxJkltV+jdmnG8kzgKEA+SXpIdjFfP2By+ffi2F22dcdxpQchN54
         Zc57DAtX3FgAyUCSeEQebV2hCZR4V8SNwCPCBINK7wG8nZbxK33P9FzFmh3iYzpcaRXf
         UBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726498434; x=1727103234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hYQsqWRG/KA6HCUSesfPALyKBlmIx+m+eouyHIxt56E=;
        b=KVLmNp7FyudnWOVmW/WUOAoB0vj3jsIIjR8z1BSbQlc0g3JbvGn8qsPSuAzz2MDm1U
         xQVdMj/uQUgBqgRQv8TZAU4dNLbSmVSPCwqmVkanX5pWBRSto5I+/tflHTCLpVoNXns8
         QjhO3VzYvGFZBIVuu6M/OgXZrHGBmJ8OjLL/JaocEMIElfZRp+eq0u3nW3wEOmC2xnlU
         KIzDLWwZe8V60MfMTMdyGQtufcUOR1bgzxvqqUg38m5qxXwpikVM5u4xjhjej3jSmdzl
         CykiveMbnEmFj2HsQp5Pb8oUQPxUDGKq6T2/tVZBcPQS7+v33LFtCwzGWxC0XBVGAiEP
         QLEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWpOOf808WfC5Ue8Xi8d3q/wTibl6aiN8TGDq86SRiF19DD+4MdwM+md4GFKzS+Y/71Oi534jTy0iNaXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwoNGZy4cSkUXFY2BFYzCkygUQwRgsJt73C8Zq0XDQoV/OO2Yk
	PJmeDEQKAIHS4+zSvTb2qbnq+5gDwDa/ShajwRKlkKzG6keK1cbA1n3oP5/qJ8w=
X-Google-Smtp-Source: AGHT+IG+u7aKNdd/Yo34zgdyrEIYgD/ChDvyvccnDp+AHTvIcGB+POpqFRdpI5r8Jx5MDpavLi9QfQ==
X-Received: by 2002:a05:6512:1052:b0:533:508f:edf1 with SMTP id 2adb3069b0e04-53678ff4e66mr6943853e87.60.1726498434345;
        Mon, 16 Sep 2024 07:53:54 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5368704688bsm902054e87.57.2024.09.16.07.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 07:53:53 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC updates for v6.12
Date: Mon, 16 Sep 2024 16:53:52 +0200
Message-Id: <20240916145352.388340-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's the pull-request for MMC v6.12.

Please note, this pull-request also introduces a new subsystem for so called
Replay Protected Memory Block (RPMB) in drivers/misc/. The first provider
that implements RPMB support is the MMC subsystem for eMMC cards, while the
consumer is the tee/optee subsystem.

More details are available in the commit message that introduces the RPMB
subsystem along with the usual highlights for MMC in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson

The following changes since commit aea62c744a9ae2a8247c54ec42138405216414da:

  mmc: cqhci: Fix checking of CQHCI_HALT state (2024-09-03 14:20:51 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.12

for you to fetch changes up to cd3689b6772fbc1a4513934a5204fd2fa5b4426b:

  mmc: core: Use dev_err_probe for deferred regulators (2024-09-13 14:09:29 +0200)

----------------------------------------------------------------
MMC core:
 - Add documentation for the mmc-test driver
 - Register the eMMC RPMB partition with the RPMB subsystem
 - Some various cleanups

MMC host:
 - dw_mmc-rockchip: Add support for the RK3576 variant
 - renesas_sdhi: Add support for the RZ/V2H(P) variant
 - sdhci_am654: Add a retry mechanism for tuning
 - sdhci-atmel: Convert DT bindings to json schema
 - sdhci-of-dwcmshc: Add eMMC HW reset support for BlueField-3 SoC
 - sdhci-of-dwcmshc: Add support for the RK3576 variant
 - sdhci-of-dwcmshc: Add support for the Sophgo SG2042 variant
 - sdhci-of-ma35d1: Add new driver for the Nuvoton MA35D1 SDHCI

Misc/Tee:
 - Add Replay Protected Memory Block (RPMB) subsystem
 - Let optee probe RPMB device using RPMB subsystem

----------------------------------------------------------------
Alexander Stein (1):
      mmc: core: Use dev_err_probe for deferred regulators

Avri Altman (2):
      mmc: core Convert UNSTUFF_BITS macro to inline function
      Documentation: mmc: Add mmc-test doc

Chanwoo Lee (1):
      mmc: core: Replace the argument of mmc_sd_switch() with defines

Chen Wang (7):
      mmc: sdhci-of-dwcmshc: add common bulk optional clocks support
      mmc: sdhci-of-dwcmshc: move two rk35xx functions
      mmc: sdhci-of-dwcmshc: factor out code for th1520_init()
      mmc: sdhci-of-dwcmshc: factor out code into dwcmshc_rk35xx_init
      mmc: sdhci-of-dwcmshc: add dwcmshc_pltfm_data
      dt-bindings: mmc: sdhci-of-dwcmhsc: Add Sophgo SG2042 support
      mmc: sdhci-of-dwcmshc: Add support for Sophgo SG2042

Christophe JAILLET (1):
      mmc: core: Remove struct mmc_context_info

Dan Carpenter (1):
      optee: Fix a NULL vs IS_ERR() check

Detlev Casanova (3):
      dt-bindings: mmc: Add support for rk3576 dw-mshc
      mmc: dw_mmc-rockchip: Add support for rk3576 SoCs
      dt-bindings: mmc: Add support for rk3576 eMMC

Dharma Balasubiramani (1):
      dt-bindings: mmc: sdhci-atmel: Convert to json schema

Doug Brown (1):
      mmc: sdhci-pxav2: Remove unnecessary null pointer check

Jens Wiklander (7):
      rpmb: add Replay Protected Memory Block (RPMB) subsystem
      mmc: block: register RPMB partition with the RPMB subsystem
      tee: add tee_device_set_dev_groups()
      optee: probe RPMB device using RPMB subsystem
      mmc: block: add RPMB dependency
      optee: add RPMB dependency
      rpmb: fix error path in rpmb_dev_register()

Judith Mendez (2):
      mmc: sdhci_am654: Add retry tuning
      mmc: sdhci_am654: Add prints to tuning algorithm

Krzysztof Kozlowski (1):
      dt-bindings: mmc: renesas,sdhi: add top-level constraints

Lad Prabhakar (4):
      dt-bindings: mmc: renesas,sdhi: Document RZ/V2H(P) support
      mmc: tmio: Use MMC core APIs to control the vqmmc regulator
      mmc: renesas_sdhi: Add RZ/V2H(P) compatible string
      dt-bindings: mmc: renesas,sdhi: Remove duplicate compatible and add clock checks

Liming Sun (1):
      mmc: sdhci-of-dwcmshc: Add hw_reset() support for BlueField-3 SoC

Riyan Dhiman (2):
      mmc: core: Calculate size from pointer
      mmc: core: Convert simple_stroul to kstroul

Seunghwan Baek (1):
      mmc: cqhci: Make use of cqhci_halted() routine

Shan-Chun Hung (2):
      dt-bindings: mmc: nuvoton,ma35d1-sdhci: Document MA35D1 SDHCI controller
      mmc: sdhci-of-ma35d1: Add Nuvoton MA35D1 SDHCI driver

Shawn Lin (1):
      mmc: dw_mmc-rockchip: Add internal phase support

Thorsten Blum (1):
      mmc: mtk-sd: Improve data type in msdc_timeout_cal()

Ulf Hansson (3):
      mmc: Merge branch fixes into next
      mmc: Merge branch fixes into next
      mmc: Merge branch fixes into next

Vladimir Zapolskiy (1):
      mmc: core: remove left-over data structure declarations

 Documentation/ABI/testing/sysfs-class-tee          |  15 +
 .../bindings/mmc/atmel,sama5d2-sdhci.yaml          |  92 ++++
 .../bindings/mmc/nuvoton,ma35d1-sdhci.yaml         |  87 ++++
 .../devicetree/bindings/mmc/renesas,sdhi.yaml      |  13 +-
 .../devicetree/bindings/mmc/rockchip-dw-mshc.yaml  |   2 +
 .../devicetree/bindings/mmc/sdhci-atmel.txt        |  35 --
 .../bindings/mmc/snps,dwcmshc-sdhci.yaml           |  95 ++--
 Documentation/driver-api/mmc/index.rst             |   1 +
 Documentation/driver-api/mmc/mmc-test.rst          | 299 +++++++++++++
 MAINTAINERS                                        |   8 +
 drivers/misc/Kconfig                               |  10 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/rpmb-core.c                           | 231 ++++++++++
 drivers/mmc/core/Kconfig                           |   1 +
 drivers/mmc/core/block.c                           | 250 ++++++++++-
 drivers/mmc/core/mmc.c                             | 106 ++---
 drivers/mmc/core/mmc_ops.h                         |  14 +
 drivers/mmc/core/regulator.c                       |   8 +-
 drivers/mmc/core/sd.c                              | 133 +++---
 drivers/mmc/core/sd_ops.c                          |   3 +-
 drivers/mmc/host/Kconfig                           |  12 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/cqhci-core.c                      |  14 +-
 drivers/mmc/host/dw_mmc-rockchip.c                 | 217 +++++++++-
 drivers/mmc/host/mtk-sd.c                          |  11 +-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      |   1 +
 drivers/mmc/host/sdhci-of-dwcmshc.c                | 478 ++++++++++++++-------
 drivers/mmc/host/sdhci-of-ma35d1.c                 | 314 ++++++++++++++
 drivers/mmc/host/sdhci-pxav2.c                     |   2 +-
 drivers/mmc/host/sdhci_am654.c                     |  54 ++-
 drivers/mmc/host/tmio_mmc_core.c                   |   7 +-
 drivers/tee/optee/Kconfig                          |   1 +
 drivers/tee/optee/core.c                           |  96 ++++-
 drivers/tee/optee/device.c                         |   7 +
 drivers/tee/optee/ffa_abi.c                        |  14 +
 drivers/tee/optee/optee_ffa.h                      |   2 +
 drivers/tee/optee/optee_private.h                  |  26 +-
 drivers/tee/optee/optee_rpc_cmd.h                  |  35 ++
 drivers/tee/optee/optee_smc.h                      |   2 +
 drivers/tee/optee/rpc.c                            | 177 ++++++++
 drivers/tee/optee/smc_abi.c                        |  14 +
 drivers/tee/tee_core.c                             |  19 +-
 include/linux/mmc/core.h                           |  12 -
 include/linux/mmc/host.h                           |  27 +-
 include/linux/rpmb.h                               | 123 ++++++
 include/linux/tee_core.h                           |  12 +
 46 files changed, 2633 insertions(+), 449 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-tee
 create mode 100644 Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml
 create mode 100644 Documentation/devicetree/bindings/mmc/nuvoton,ma35d1-sdhci.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
 create mode 100644 Documentation/driver-api/mmc/mmc-test.rst
 create mode 100644 drivers/misc/rpmb-core.c
 create mode 100644 drivers/mmc/host/sdhci-of-ma35d1.c
 create mode 100644 include/linux/rpmb.h

