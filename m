Return-Path: <linux-kernel+bounces-181224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D14608C792D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BE78B22DF1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C6914D43A;
	Thu, 16 May 2024 15:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a9XskHOq"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C9814D2B5
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 15:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715872818; cv=none; b=k0MvljgS7/+tHBQRXTjqRvoRs9KzrK+yGdkWwQRt9adHgMQ0LJagGrpHS8JjZ15dC97SvNwvzE87qyH/qkpN4Zkl/mG+4hPB4Yo3+QfAwabkTmHkTb1jo1HJvte91FvrQ9hKFLi5xyrdbZ4GNzkgprc/t4ffd2e+wfrMJeCNOOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715872818; c=relaxed/simple;
	bh=ViIbbucNYqTJFJTgNuD1P1jdn5qFqKL2oR9BnOPDp2k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=gIsS512KwxZg1VMBWwzaJFQf5mcUbfbF2J4vpdumwtu1GyfcNttVoTYGp0yDqYHZK826oQS+vMdS/o+eMr5Ttx8D67Z9Yy+PAP0nNuKJElMKCgyu1o+0JVeVU9Z/82HIqpihXA4URQJPf8/vTQ1rjkQaezx+eyjXfxgGapTFxIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a9XskHOq; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a59a0168c75so371888266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715872814; x=1716477614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2yceyVNE4oy37H9VVToLAQUBY2IzkisD+0516yGQ8vc=;
        b=a9XskHOqNB1MZhnwkIpK0QbUc7dE6yrWiXl8WJ86bboXfzzKFcnjXGJfV59SZxgWJW
         n9k65wjvTDSb72U/NM+f1JXUYrzxKvV4NUt7DGuMcZL0lZd1WRoeUp2yfd8vMka41S30
         BdlRToo3y2toCIR05ge8eCe0T2BV30LiBQd/sIlLUP79Xubii89fPVcLtJratNzbNZS0
         xsqmGnnf7q2n9gQDOzQUm7TlHdw7BMPztqeYujBLAuRFYw4StBku3Pc/8m3eWb46mQwi
         ijBwTt91jVgl5S9YMy5YOa3DeELPSWv7Icu+FnjIBaE0ApbW1kgZQRPm8jXLpcQThBru
         2O3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715872814; x=1716477614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2yceyVNE4oy37H9VVToLAQUBY2IzkisD+0516yGQ8vc=;
        b=m9/xOoqlh//G9aRkWP0nRkdOzofx6j613CGuZFPPFPMSSycJFBtcZGZl+m05SIeEdH
         QomCUrzcQcDogsEn94szdYdC26KTGKzOu92jfo8VCll7EX6CXwj6XBvVyyD5Iz8S6hIc
         7xXuMZ3nn490zFNFqdcaOSaDR4GNWcOkX+XUl4lzHRkxn89/5jBnxCneUx3hrav3O3Wx
         H4ML7iDZlpHvdDij9aPS5Rfvsab2S1qR5bFyM80KPaVLSX5DmuPcX3LJbV4JOpjjaD5y
         hhlgS1hI9qPQtKrMbR1wkAlJsnqRwQkZeBfrYdXpMIS11Q+PA1PmFUlNyJf7ZqxoyTjd
         MDCA==
X-Forwarded-Encrypted: i=1; AJvYcCViTZbrWvBn02QO6zmU8dVqbIjlW73KUAvv4q/y0VDYQ89wTEIuKRthi6nMwm0nelSD6wXVncuRMOpQ8iTlUtpemxBUPSmOEK0Kfi8A
X-Gm-Message-State: AOJu0YxuphA6suMYccys5kJhEuyZvIT8kgrn5Nt7RUlbg35xNRn+eF3P
	rh5wwTXZ45RizLwKvVe0jJjfbCgxkZFP8ypYDWAkLoYGKHac8Rj/Z6ROX4UqgofFU5+bzuKuCna
	LBns=
X-Google-Smtp-Source: AGHT+IFQzCLtumyQHqtxZKAIA7z5pVSX8Mvgd3C/OaL16FwLja4nneI7I0mhgOjmmZdZr+XJTDwIjA==
X-Received: by 2002:a17:907:31c3:b0:a5a:88a9:3ef5 with SMTP id a640c23a62f3a-a5a88a94025mr664171466b.39.1715872813921;
        Thu, 16 May 2024 08:20:13 -0700 (PDT)
Received: from uffe-tuxpro14.. ([149.14.240.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5ce877ece2sm85849666b.13.2024.05.16.08.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 08:20:13 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC and MEMSTICK updates for v6.10
Date: Thu, 16 May 2024 17:20:12 +0200
Message-Id: <20240516152012.30550-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's the pull-request for MMC and MEMSTICK for v6.10. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit e027e72ecc1683e04f33aedf0196ad6c3278d309:

  mmc: moxart: fix handling of sgm->consumed, otherwise WARN_ON triggers (2024-04-25 17:48:46 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.10

for you to fetch changes up to 35eea0defb6e46b26e286066e0e77ac5d53e7fba:

  mmc: renesas_sdhi: Add compatible string for RZ/G2L family, RZ/G3S, and RZ/V2M SoCs (2024-05-03 14:33:05 +0200)

----------------------------------------------------------------
MMC core:
 - Increase the timeout period of the ACMD41 command
 - Add card entry for quirks to debugfs
 - Add mmc_gpiod_set_cd_config() function
 - Store owner from SDIO modules with sdio_register_driver()

MMC host:
 - atmel-mci: Some cleanups and a switch to use dev_err_probe()
 - renesas_sdhi: Add support for RZ/G2L, RZ/G3S and RZ/V2M variants
 - renesas_sdhi: Set the SDBUF after reset
 - sdhci: Add support for "Tuning Error" interrupts
 - sdhci-acpi: Add quirk to enable pull-up on the card-detect GPIO on Asus T100TA
 - sdhci-acpi: Disable write protect detection on Toshiba WT10-A
 - sdhci-acpi: Fix Lenovo Yoga Tablet 2 Pro 1380 sdcard slot not working
 - sdhci_am654: Re-work and fix the tuning support for multiple speed-modes
 - sdhci_am654: Add tuning algorithm for delay chain
 - sdhci-esdhc-imx: Add NXP S32G3 support
 - sdhci-of-dwcmshc: Add tuning support for Sophgo CV1800B and SG200X
 - sdhci-of-dwcmshc: Implement SDHCI CQE support
 - sdhci-pci-gli: Use the proper pci_set_power_state() instead of PMCSR writes

MEMSTICK:
 - Convert a couple of drivers to use the ->remove_new() callback

----------------------------------------------------------------
Adrian Hunter (1):
      mmc: sdhci: Add support for "Tuning Error" interrupts

Andy Shevchenko (10):
      mmc: core: Remove unused of_gpio.h
      mmc: mtk-sd: Remove unused of_gpio.h
      mmc: sdhci-s3c: Replace deprecated of_get_named_gpio()
      mmc: sdhci-sprd: Remove unused of_gpio.h
      mmc: slot-gpio: Use irq_handler_t type
      mmc: atmel-mci: Get rid of platform data leftovers
      mmc: atmel-mci: Use temporary variable for struct device
      mmc: atmel-mci: Replace platform device pointer by generic one
      mmc: atmel-mci: Incapsulate used to be a platform data into host structure
      mmc: atmel-mci: Switch to use dev_err_probe()

Angelo Dureghello (1):
      MAINTAINERS: update Angelo Dureghello e-mail address

Bjorn Helgaas (2):
      mmc: sdhci-pci-gli: Use PCI AER definitions, not hard-coded values
      mmc: sdhci-pci-gli: Use pci_set_power_state(), not direct PMCSR writes

Claudiu Beznea (1):
      mmc: renesas_sdhi: Set the SDBUF after reset

Felix Qin (1):
      mmc: core: Increase the timeout period of the ACMD41 command

Hans de Goede (5):
      mmc: core: Add mmc_gpiod_set_cd_config() function
      mmc: sdhci-acpi: Sort DMI quirks alphabetically
      mmc: sdhci-acpi: Fix Lenovo Yoga Tablet 2 Pro 1380 sdcard slot not working
      mmc: sdhci-acpi: Disable write protect detection on Toshiba WT10-A
      mmc: sdhci-acpi: Add quirk to enable pull-up on the card-detect GPIO on Asus T100TA

Jisheng Zhang (2):
      mmc: sdhci-of-dwcmshc: Remove useless "&" of th1520_execute_tuning
      mmc: sdhci-of-dwcmshc: Add tuning support for Sophgo CV1800B and SG200X

Judith Mendez (7):
      mmc: sdhci_am654: Add tuning algorithm for delay chain
      mmc: sdhci_am654: Write ITAPDLY for DDR52 timing
      mmc: sdhci_am654: Add OTAP/ITAP delay enable
      mmc: sdhci_am654: Add ITAPDLYSEL in sdhci_j721e_4bit_set_clock
      mmc: sdhci_am654: Fix ITAPDLY for HS400 timing
      mmc: sdhci_am654: Fix itapdly/otapdly array type
      mmc: sdhci_am654: Update comments in sdhci_am654_set_clock

Krzysztof Kozlowski (13):
      mmc: sdio: store owner from modules with sdio_register_driver()
      Bluetooth: btmrvl_sdio: drop driver owner initialization
      Bluetooth: btmtksdio: drop driver owner initialization
      wifi: ath10k: sdio: simplify module initialization
      wifi: ath10k: sdio: drop driver owner initialization
      wifi: brcm80211: drop driver owner initialization
      wifi: mwifiex: drop driver owner initialization
      wifi: wfx: drop driver owner initialization
      mmc: sdhci-esdhc-mcf: Constify struct sdhci_ops
      mmc: sdhci-omap: Constify struct sdhci_ops
      mmc: sdhci-sprd: Constify struct sdhci_ops
      mmc: sdhci_am654: Constify struct sdhci_ops
      mmc: sdhci-s3c: Choose sdhci_ops based on variant

Lad Prabhakar (3):
      dt-bindings: mmc: renesas,sdhi: Group single const value items into an enum list
      dt-bindings: mmc: renesas,sdhi: Document RZ/G2L family compatibility
      mmc: renesas_sdhi: Add compatible string for RZ/G2L family, RZ/G3S, and RZ/V2M SoCs

Li Zhijian (1):
      mmc: core: Convert sprintf/snprintf to sysfs_emit

Muhammad Usama Anjum (2):
      mmc: dw_mmc-hi3798mv200: Remove unneeded assignment
      mmc: dw_mmc-hi3798cv200: Remove unneeded assignment

Rouven Czerwinski (2):
      mmc: debugfs: convert permissions to octal
      mmc: debugfs: add card entry for quirks

Sergey Khimich (2):
      mmc: cqhci: Add cqhci set_tran_desc() callback
      mmc: sdhci-of-dwcmshc: Implement SDHCI CQE support

Ulf Hansson (4):
      mmc: Merge branch fixes into next
      mmc: Merge branch fixes into next
      mmc: Merge branch fixes into next
      mmc: core: Convert to use __mmc_poll_for_busy() SD_APP_OP_COND too

Uwe Kleine-König (4):
      mmc: davinci: Don't strip remove function when driver is builtin
      memstick: rtsx_pci_ms: Drop if block with always false condition
      memstick: rtsx_pci_ms: Convert to platform remove callback returning void
      memstick: rtsx_usb_ms: Convert to platform remove callback returning void

Wadim Mueller (1):
      dt-bindings: mmc: fsl-imx-esdhc: add NXP S32G3 support

 .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml     |   3 +
 .../devicetree/bindings/mmc/renesas,sdhi.yaml      |  39 ++-
 MAINTAINERS                                        |   2 +-
 drivers/bluetooth/btmrvl_sdio.c                    |   1 -
 drivers/bluetooth/btmtksdio.c                      |   1 -
 drivers/memstick/host/rtsx_pci_ms.c                |   9 +-
 drivers/memstick/host/rtsx_usb_ms.c                |   6 +-
 drivers/mmc/core/block.c                           |   8 +-
 drivers/mmc/core/debugfs.c                         |   7 +-
 drivers/mmc/core/host.c                            |   1 -
 drivers/mmc/core/sd_ops.c                          |  83 ++++--
 drivers/mmc/core/sdio_bus.c                        |   9 +-
 drivers/mmc/core/slot-gpio.c                       |  25 +-
 drivers/mmc/host/Kconfig                           |   1 +
 drivers/mmc/host/atmel-mci.c                       | 309 +++++++++------------
 drivers/mmc/host/cqhci-core.c                      |  11 +-
 drivers/mmc/host/cqhci.h                           |   4 +
 drivers/mmc/host/davinci_mmc.c                     |   4 +-
 drivers/mmc/host/dw_mmc-hi3798cv200.c              |   1 -
 drivers/mmc/host/dw_mmc-hi3798mv200.c              |   1 -
 drivers/mmc/host/mtk-sd.c                          |   1 -
 drivers/mmc/host/renesas_sdhi_core.c               |   3 +
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      |   9 +-
 drivers/mmc/host/sdhci-acpi.c                      |  61 +++-
 drivers/mmc/host/sdhci-esdhc-mcf.c                 |   2 +-
 drivers/mmc/host/sdhci-of-dwcmshc.c                | 305 +++++++++++++++++++-
 drivers/mmc/host/sdhci-omap.c                      |   2 +-
 drivers/mmc/host/sdhci-pci-gli.c                   |  46 ++-
 drivers/mmc/host/sdhci-s3c.c                       |  35 +--
 drivers/mmc/host/sdhci-sprd.c                      |   3 +-
 drivers/mmc/host/sdhci.c                           |  10 +-
 drivers/mmc/host/sdhci.h                           |   3 +-
 drivers/mmc/host/sdhci_am654.c                     | 182 +++++++++---
 drivers/net/wireless/ath/ath10k/sdio.c             |  21 +-
 .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c  |   1 -
 drivers/net/wireless/marvell/mwifiex/sdio.c        |   1 -
 drivers/net/wireless/silabs/wfx/bus_sdio.c         |   1 -
 include/linux/mmc/sdio_func.h                      |   5 +-
 include/linux/mmc/slot-gpio.h                      |   6 +-
 39 files changed, 826 insertions(+), 396 deletions(-)

