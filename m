Return-Path: <linux-kernel+bounces-252388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DE193127B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 12:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A22FB22713
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F413188CBB;
	Mon, 15 Jul 2024 10:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rNDXX7vt"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C127A16CD36
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 10:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721040134; cv=none; b=NQ4UIielRoowgX62denWIYGgE1oIQ3Bm0tR6qnWXzTAYNfbea1CC2rLO70J/jJMSKbl0pJyFjEUgXec8FNotHCxJ37twx0VrB6+VigQMiPmo6pqn9uuA76NsnHnYjeVJj9zr2pN6gk5gjfEU9RrDMmr2KrGNMNFyZepAZZGw7+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721040134; c=relaxed/simple;
	bh=bUUlr5c2Y/b9ETzfRJTM3uGHLh+IJTm19dqPlt8KFAc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lWR6LbqhMwAeksqDk+tXogiuBEmcQWRNUYtVeR6J7tYf1P3O7QX6XXFgIObqGoqwQnuFz0wBSWcaVxstKCrr+qjjnfGB0NSBFPhUmy+dwlCh6WnwO15/lRq+jqD2Wq4MQX6hVilYtyzNdvCOv4rvNBevwucb+52emGg4Uhyaa/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rNDXX7vt; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2eea7e2b073so54264301fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 03:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721040131; x=1721644931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yDBDdSaTsIScMjDczsi/TPg8Dl1/nhZKeEyHmoSCz7k=;
        b=rNDXX7vtYOa8jIMJcWx8YFHEmshQkSJSc6J6HZXXcEGKLEL9u4QoaGJSq6bTCffyLW
         /PYuqIDCg8YA8mJ40+yC22UHYh9T2oUpySn8ITZqfjhMLjF9O7RefidHxJ89NGdFx3dP
         W33Amf9QdLIfFg+uOVfgrb4M22MUgekHo11ConkbE7yNpYC/E7uZFMLp1qi9sdfdrf4O
         Tngsa67VUSIA1NDzI6yrCP5zj3PaaTf172AElWHYSGJ2+MdKAss3QGOENDd0+9+tffQS
         lPsehCQWaDJTfhGkaL9h1ID5IHL7VHYBr7lt1b9R0qpzk44RO/v6GdDfhQylGcxwO+U3
         G8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721040131; x=1721644931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yDBDdSaTsIScMjDczsi/TPg8Dl1/nhZKeEyHmoSCz7k=;
        b=oOiNhWp95sNy/iqGAdcBFi9l1naq+qmXl0j6N5oOyB1blDu4vE9hBxaW6axMvxOkLY
         UWfyxauKoftHiTM1GVETAseF+cqgfssvUMHit3sIj2mET2fU7bC4XEUsTd7gNJMBlvcU
         3XdkiDHULB+6eAkqLmKQ/7cEXcRG4COogV8NRiN+ya8viB0B1muaqadUFe+MybfzuiyG
         LnpgXwfy8s+XqsEuumNtfKs2XOOstlfxfbvwOKIb+Ct3wgmMjOqPblwtQFSIwC8NkpSD
         9JEoXIxxZO+zZiGENnjE+Xd/tW4z18CKYfW4N7nytQBdNof1vU8yiUF8Jby8M4TIS/Pf
         YDrA==
X-Forwarded-Encrypted: i=1; AJvYcCUitGZSGWY9aV+PsmTCrgPvaM8cqQj+lv/tei44/lvMvxM7tH/qmtroWGubTCMl0d9Xf0Qcal2YHBr5J2O2ts6TtnJsry34l5f6//ik
X-Gm-Message-State: AOJu0YyY/VL71HmFKl4STa26Wo22z6OfV0PEuty8t+iLf2jUz9TQsjnQ
	TwD8nP1i3wsy5Q1J17VoIILut9bzpCw2hbOyamJvXoXMeXiim23v0SfHmvKv2sg=
X-Google-Smtp-Source: AGHT+IEl8e4sHhD2Ze4AU3LrChP1A0SLmG+ooB5oN5pZc9KeFQr0EPcLXb2erYuWFIJ8V7w/XkyQdg==
X-Received: by 2002:a2e:980b:0:b0:2ee:8749:d4a1 with SMTP id 38308e7fff4ca-2eeb30b9b69mr122007621fa.10.1721040130871;
        Mon, 15 Jul 2024 03:42:10 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2eee18bed4bsm7715921fa.69.2024.07.15.03.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 03:42:10 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC and MEMSTICK updates for v6.11
Date: Mon, 15 Jul 2024 12:42:09 +0200
Message-Id: <20240715104209.177921-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's the pull-request for MMC and MEMSTICK for v6.11. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 16198eef11c1929374381d7f6271b4bf6aa44615:

  mmc: davinci_mmc: Prevent transmitted data size from exceeding sgm's length (2024-07-11 17:48:54 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.11

for you to fetch changes up to b85e021853976aaebd3788e7e721020570754199:

  MAINTAINERS: add 's32@nxp.com' as relevant mailing list for 'sdhci-esdhc-imx' driver (2024-07-12 11:07:54 +0200)

----------------------------------------------------------------
MMC host:
 - Convert from using tasklet to the BH workqueue
 - dw_mmc-bluefield: Add support for eMMC HW reset
 - mmc_spi: Allow spi controllers incapable of lower than 400kHz
 - sdhci: Rework code to eliminate SDHCI_QUIRK_UNSTABLE_RO_DETECT
 - sdhci-brcmstb: Add support for the BCM2712 variant
 - sdhci-esdhc-imx: Disable card-detect as system wakeup on S32G platforms
 - sdhci-msm: Add support for the SDX75 variant
 - sdhci-of-dwcmshc: Enable CQE support for some Rockchip variants
 - sdhci-of-esdhc: Convert DT-bindings to yaml
 - sdhci-sprd: Convert DT-bindings to yaml

MEMSTICK:
 - rtsx_pci_ms: Remove the unused Realtek PCI memstick driver

----------------------------------------------------------------
Adrian Hunter (1):
      mmc: sdhci: Eliminate SDHCI_QUIRK_UNSTABLE_RO_DETECT

Allen Pais (2):
      mmc: sdhi: Convert from tasklet to BH workqueue
      mmc: Convert from tasklet to BH workqueue

Andrea della Porta (3):
      dt-bindings: arm: bcm: Add BCM2712 SoC support
      dt-bindings: mmc: Add support for BCM2712 SD host controller
      mmc: sdhci-brcmstb: Add BCM2712 support

Bastien Curutchet (1):
      mmc: davinci_mmc: report all possible bus widths

Ciprian Costea (3):
      mmc: sdhci-esdhc-imx: disable card detect wake for S32G based platforms
      mmc: sdhci-esdhc-imx: obtain the 'per' clock rate after its enablement
      MAINTAINERS: add 's32@nxp.com' as relevant mailing list for 'sdhci-esdhc-imx' driver

Conor Dooley (1):
      mmc: mmc_spi: allow for spi controllers incapable of getting as low as 400k

Frank Li (2):
      dt-bindings: mmc: mmc-spi-slot: Change voltage-ranges to uint32-matrix
      dt-bindings: mmc: Convert fsl-esdhc.txt to yaml

Geert Uytterhoeven (2):
      mfd: tmio: Remove obsolete .set_clk_div() callback
      mmc: tmio: Remove obsolete .set_pwr() callback()

Heiko Stuebner (1):
      mmc: sdhci-of-dwcmshc: set CQE irq-handler for rockchip variants

Javier Carrasco (1):
      mmc: sdhci_am654: Constify struct regmap_config

Jeff Johnson (1):
      mmc: add missing MODULE_DESCRIPTION() macros

Kai-Heng Feng (1):
      memstick: rtsx_pci_ms: Remove Realtek PCI memstick driver

Liming Sun (2):
      mmc: dw_mmc: Add support for platform specific eMMC HW reset
      mmc: dw_mmc-bluefield: Add support for eMMC HW reset

Naina Mehta (1):
      dt-bindings: mmc: sdhci-msm: Document the SDX75 compatible

Neil Armstrong (1):
      dt-bindings: mmc: meson-gx: add optional power-domains

Peter Robinson (1):
      mmc: sdhci-brcmstb: Add ARCH_BCM2835 option

Stanislav Jakubek (1):
      dt-bindings: mmc: sdhci-sprd: convert to YAML

Ulf Hansson (3):
      mmc: Merge branch fixes into next
      mmc: Merge branch fixes into next
      mmc: Merge branch fixes into next

Wolfram Sang (1):
      MAINTAINERS: drop entry for VIA SD/MMC controller

 .../devicetree/bindings/arm/bcm/bcm2835.yaml       |   6 +
 .../bindings/mmc/amlogic,meson-gx-mmc.yaml         |   3 +
 .../bindings/mmc/brcm,sdhci-brcmstb.yaml           |   1 +
 .../devicetree/bindings/mmc/fsl,esdhc.yaml         | 105 ++++
 .../devicetree/bindings/mmc/fsl-esdhc.txt          |  52 --
 .../devicetree/bindings/mmc/mmc-spi-slot.yaml      |  16 +-
 .../devicetree/bindings/mmc/sdhci-msm.yaml         |   1 +
 .../devicetree/bindings/mmc/sdhci-sprd.txt         |  67 ---
 .../devicetree/bindings/mmc/sprd,sdhci-r11.yaml    | 112 ++++
 MAINTAINERS                                        |   7 +-
 drivers/memstick/host/Kconfig                      |  10 -
 drivers/memstick/host/Makefile                     |   1 -
 drivers/memstick/host/rtsx_pci_ms.c                | 638 ---------------------
 drivers/mmc/core/core.c                            |   1 +
 drivers/mmc/core/pwrseq_emmc.c                     |   1 +
 drivers/mmc/core/pwrseq_sd8787.c                   |   1 +
 drivers/mmc/core/pwrseq_simple.c                   |   1 +
 drivers/mmc/core/sdio_uart.c                       |   1 +
 drivers/mmc/host/Kconfig                           |   2 +-
 drivers/mmc/host/atmel-mci.c                       |  35 +-
 drivers/mmc/host/au1xmmc.c                         |  37 +-
 drivers/mmc/host/cb710-mmc.c                       |  14 +-
 drivers/mmc/host/cb710-mmc.h                       |   3 +-
 drivers/mmc/host/davinci_mmc.c                     |  11 +-
 drivers/mmc/host/dw_mmc-bluefield.c                |  18 +-
 drivers/mmc/host/dw_mmc.c                          |  30 +-
 drivers/mmc/host/dw_mmc.h                          |  11 +-
 drivers/mmc/host/mmc_spi.c                         |   5 +-
 drivers/mmc/host/of_mmc_spi.c                      |   1 +
 drivers/mmc/host/omap.c                            |  17 +-
 drivers/mmc/host/renesas_sdhi.h                    |   4 +-
 drivers/mmc/host/renesas_sdhi_core.c               |   3 +
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      |  26 +-
 drivers/mmc/host/renesas_sdhi_sys_dmac.c           |   9 +-
 drivers/mmc/host/sdhci-bcm-kona.c                  |   2 +-
 drivers/mmc/host/sdhci-brcmstb.c                   |  60 ++
 drivers/mmc/host/sdhci-esdhc-imx.c                 |  16 +-
 drivers/mmc/host/sdhci-of-dwcmshc.c                |   1 +
 drivers/mmc/host/sdhci-pci-core.c                  |  27 +-
 drivers/mmc/host/sdhci.c                           |  31 +-
 drivers/mmc/host/sdhci.h                           |   3 +-
 drivers/mmc/host/sdhci_am654.c                     |   2 +-
 drivers/mmc/host/tifm_sd.c                         |  15 +-
 drivers/mmc/host/tmio_mmc.h                        |   6 +-
 drivers/mmc/host/tmio_mmc_core.c                   |  13 +-
 drivers/mmc/host/uniphier-sd.c                     |  12 +-
 drivers/mmc/host/via-sdmmc.c                       |  25 +-
 drivers/mmc/host/wbsd.c                            |  74 +--
 drivers/mmc/host/wbsd.h                            |  10 +-
 include/linux/mfd/tmio.h                           |   2 -
 50 files changed, 556 insertions(+), 993 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
 delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/sprd,sdhci-r11.yaml
 delete mode 100644 drivers/memstick/host/rtsx_pci_ms.c

