Return-Path: <linux-kernel+bounces-575088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 571CCA6ED62
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12A0A3ACFB9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1916319B5B4;
	Tue, 25 Mar 2025 10:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RY4b7Rdb"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6924215199A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 10:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742897758; cv=none; b=Q6XgImvXrjm/FQ4aEwWHHBFrzR4xKt4BR6HI8zLsUotAGpT/jv4vGPFGl5dKe/2J7IPASiQ3WrgLb6RufC9s+kUkRiCDxm36G2drw4RcQMRJ1mbeihrUCD5ly4baxkSG5R30tNswep6iwebrtZ2XcfKmZpoLYvWeyL6OC/Q3Xp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742897758; c=relaxed/simple;
	bh=kq3z/F+bkdyrEEPxLj4aaSVutwseYeIy5wfytTS54JM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kFXSSbaYpfHbGjKWDmPlUODGNe2B+Un/nbNklrMvFkpVpusrg89v6IUPGVDwjagqexeFf9gJpGw8JFOaZZdeacOZtqwBPMXBEoxAsIEW49Ut8rkLst2J5alq3iVqB6a/empbNJjaRQ4fEczF5O2EAabIbQ8hhBBGjmX3lPJghPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RY4b7Rdb; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30c0517142bso56583951fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 03:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742897753; x=1743502553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kUX8G/ipswWdxea2g5yuXYGySDqu/Dr7lyepw+RoYJc=;
        b=RY4b7RdbZBgZdMFPyRwUCqyXTtEeVadQnmXCPRBMq7C0+f6RYTGjvkE1nt1x/xtaNr
         NFfLe0v2r6TBPI7WsaCofNSwZ8zc15PIz+pkQCNqPXdBM9G1TEAWhfPeAhuJAsXrz2A+
         VThanqzu+c3WJy8N+CWJMjK/mfhP6fnbZNIeJcN+bCgSyDPR1ZXalflozN8woji/FmDR
         Pq+6MrWgBflrGArCVQ7ZgDzHnnBI5qqZQqeYEwlQbCUQLBTSV+vV1OoZlsP/BJ+Zv/KL
         J7qVV4B80ocBbuj0UOEUlUpU/X0T+FJrKItGGoiKT48eeeEtW9LC1lknsFF0jmHsgw17
         ulKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742897753; x=1743502553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kUX8G/ipswWdxea2g5yuXYGySDqu/Dr7lyepw+RoYJc=;
        b=emZHSKS2xJpdHgkooBRoDgMflLopeyuVlb5ABlzkkbTbatGbHWfgkcUSWulKqvp/PN
         FZc1FRe5Tsz/l9alHuUba6qKS1t6/wD/93pgvoweEqpBxFGeK8BNINBIgdVJS6YK0kYB
         Jk9K46sgyWcMuLCXBxUUWGm28COPTKb1XvaBgYcJ/oGX2qnyyjqW3Bv4mE67WiwHl5Qi
         XQbhCqiWBdXRMRWGk0jEnbRlMug09FU8grLiutf9Xcc0lNDW86NBIYSyRt9Lgt0K3Xe8
         9ckgl3Z7m7qaF6ZP1h86pPjNpYvcBOVhWx5dyOyQxFbVPYFOJnKX335pYjtIGW149pcs
         OjAw==
X-Forwarded-Encrypted: i=1; AJvYcCXYa+zyMe4k/x+h0SpsNdWZgTHVtb7SY5hFWeBb273qZaCH1ZOPnwfsN4TMOIzapRYK2EvD6y5eEGVe48M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8lIQd5xFClYIIOuMNJ2SawjjtqoKdP5GVBvk1OlTuVCqYpwOE
	MORy1ifBkuQUa/u8zKmEZMUKTED4tEJsupQ+uySaInhYUJk2E8LXKdbrDJEIz56mVDGU3Psdz3+
	E
X-Gm-Gg: ASbGncsapxXin0rr6ooZESx6fO0lFGgGRGpDhYZrIF7mvfQ+2QmY+06e8AuLB5DRRPr
	5oSirgTD0M8VVhIiTF0l3xv0ggChNEJrZEHWyHCoMXXfsJN8FQDbnqfs7S38DYGJqHzHFbHthSj
	gt2Xbag/mdtvO1GLNC4j0/lU3tj/zsmfgiJVdr+/DbZaSbpZDCGPCAfSOTBenvEpWHgHwjGBIoa
	7hw8Y332JV52UM4NGMSiSXOF8QR4eRDXfljfN2QzsPjeMqoL2PvD2Nd5+McA0S8JHTAzytYVnOE
	WLnK8wqE4V+1QuHVNkVhI6AXNROkvXNGJMUuIGos1xt2WYj1ryAzL2FZIvdn8cyHvRwXdAABMez
	b2EYSbn5wTN95r7A/Lpg=
X-Google-Smtp-Source: AGHT+IHnO39V4+b6f1jfx33CjnYElfBanHZKx/akSem4UqrpMiaVwGrwOnGjhZ0e5y3d7myuygRTsQ==
X-Received: by 2002:a05:651c:1546:b0:30b:b7c3:ea71 with SMTP id 38308e7fff4ca-30d7e222a65mr64186041fa.15.1742897753356;
        Tue, 25 Mar 2025 03:15:53 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30d7d910e86sm17475501fa.102.2025.03.25.03.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 03:15:52 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC and MEMSTICK updates for v6.15
Date: Tue, 25 Mar 2025 11:15:51 +0100
Message-ID: <20250325101551.26387-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's the pull-request with updates for MMC and MEMSTICK for v6.15. Details
about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 723ef0e20dbb2aa1b5406d2bb75374fc48187daa:

  mmc: sdhci-brcmstb: add cqhci suspend/resume to PM ops (2025-03-17 11:42:42 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.15

for you to fetch changes up to c48e13e83513bd7eb4efffeeb562df9e4e1452d0:

  mmc: core: Remove redundant null check (2025-03-21 09:48:37 +0100)

----------------------------------------------------------------
MMC host:
 - atmel-mci: Convert DT bindings to json schema
 - dw_mmc: Add support for the Exynos7870 variant
 - dw_mmc-rockchip: Add support for the RK3562/3528 variants
 - omap: Fix potential memory leak in the probe error path
 - renesas_sdhi: Add support for RZ/G3E variants
 - sdhci: Disable SD card clock before changing parameters
 - sdhci-esdhc-imx: Add support for the i.MX94 variant
 - sdhci-of-dwcmshc: Add support for the RK3562/RK3528 variants
 - sdhci-omap: Disable aggressive PM for eMMC/SD-cards
 - sdhci-pci-core: Wait for VDD to settle on card power off
 - sdhci-pxav3: Fix busy-signalling by using MMC_CAP_NEED_RSP_BUSY
 - sunxi-mmc: Add support for the A523 variant

MEMSTICK:
 - rtsx_usb_ms: Fix potential use-after-free during remove

----------------------------------------------------------------
Andre Przywara (2):
      dt-bindings: mmc: sunxi: Simplify compatible string listing
      dt-bindings: mmc: sunxi: add compatible strings for Allwinner A523

Avri Altman (1):
      mmc: core: Remove redundant null check

Biju Das (2):
      dt-bindings: mmc: renesas,sdhi: Document RZ/G3E support
      mmc: renesas_sdhi: Add support for RZ/G3E SoC

Dan Carpenter (1):
      mmc: renesas_sdhi: fix error code in renesas_sdhi_probe()

Dharma Balasubiramani (2):
      dt-bindings: mmc: mmc-slot: Make compatible property optional
      dt-bindings: mmc: atmel,hsmci: Convert to json schema

Dr. David Alan Gilbert (1):
      mmc: slot-gpio: Remove unused mmc_gpio_set_cd_isr

Dragan Simic (1):
      mmc: core: Trim trailing whitespace from card product names

Erick Shepherd (2):
      mmc: sdhci: Disable SD card clock before changing parameters
      mmc: host: Wait for Vdd to settle on card power off

Frank Li (2):
      dt-bindings: mmc: Change to additionalProperties to fix fail detect Unevaluated property
      dt-bindings: mmc: fsl-imx-esdhc: Add i.MX94 support

Jaehoon Chung (1):
      mmc: sdhci-of-dwcmshc: Change to dwcmshc_phy_init for reusing codes

Jiri Slaby (SUSE) (1):
      tty: mmc: sdio: use bool for cts and remove parentheses

Jonas Karlman (1):
      dt-bindings: mmc: sdhci-of-dwcmhsc: Add compatible string for RK3528

Karel Balej (1):
      mmc: sdhci-pxav3: set NEED_RSP_BUSY capability

Kaustabh Chakraborty (3):
      dt-bindings: mmc: samsung,exynos-dw-mshc: add exynos7870 support
      mmc: dw_mmc: add a quirk for accessing 64-bit FIFOs in two halves
      mmc: dw_mmc: add exynos7870 DW MMC support

Kever Yang (2):
      dt-bindings: mmc: Add support for rk3562 eMMC
      dt-bindings: mmc: rockchip-dw-mshc: Add support for rk3562

Luo Qiu (1):
      memstick: rtsx_usb_ms: Fix slab-use-after-free in rtsx_usb_ms_drv_remove

Miaoqian Lin (1):
      mmc: omap: Fix memory leak in mmc_omap_new_slot

Ulf Hansson (3):
      mmc: Merge branch fixes into next
      mmc: sdhci-omap: Disable MMC_CAP_AGGRESSIVE_PM for eMMC/SD
      mmc: Merge branch fixes into next

Yao Zi (1):
      dt-bindings: mmc: rockchip-dw-mshc: Add compatible string for RK3528

 .../bindings/mmc/allwinner,sun4i-a10-mmc.yaml      |  38 +++---
 .../bindings/mmc/amlogic,meson-mx-sdio.yaml        |   3 +
 .../devicetree/bindings/mmc/atmel,hsmci.yaml       | 106 +++++++++++++++++
 .../devicetree/bindings/mmc/atmel-hsmci.txt        |  73 ------------
 .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml     |   1 +
 .../devicetree/bindings/mmc/mmc-controller.yaml    |   2 +-
 .../devicetree/bindings/mmc/mmc-slot.yaml          |   1 -
 .../devicetree/bindings/mmc/renesas,sdhi.yaml      |  16 +++
 .../devicetree/bindings/mmc/rockchip-dw-mshc.yaml  |   2 +
 .../bindings/mmc/samsung,exynos-dw-mshc.yaml       |   2 +
 .../bindings/mmc/snps,dwcmshc-sdhci.yaml           |   5 +-
 drivers/memstick/host/rtsx_usb_ms.c                |   1 +
 drivers/mmc/core/core.c                            |   2 +-
 drivers/mmc/core/mmc.c                             |   6 +-
 drivers/mmc/core/sd.c                              |   4 +
 drivers/mmc/core/sdio_uart.c                       |   2 +-
 drivers/mmc/core/slot-gpio.c                       |  12 --
 drivers/mmc/host/dw_mmc-exynos.c                   |  41 ++++++-
 drivers/mmc/host/dw_mmc.c                          |  94 ++++++++++++++-
 drivers/mmc/host/dw_mmc.h                          |  27 +++++
 drivers/mmc/host/omap.c                            |  19 ++-
 drivers/mmc/host/renesas_sdhi.h                    |   1 +
 drivers/mmc/host/renesas_sdhi_core.c               | 131 +++++++++++++++++++++
 drivers/mmc/host/sdhci-of-dwcmshc.c                |  72 +++--------
 drivers/mmc/host/sdhci-omap.c                      |   4 +-
 drivers/mmc/host/sdhci-pci-core.c                  |   6 +-
 drivers/mmc/host/sdhci-pxav3.c                     |   1 +
 drivers/mmc/host/sdhci.c                           |   9 +-
 drivers/mmc/host/tmio_mmc.h                        |  10 ++
 include/linux/mmc/slot-gpio.h                      |   1 -
 30 files changed, 508 insertions(+), 184 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/atmel,hsmci.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/atmel-hsmci.txt

