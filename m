Return-Path: <linux-kernel+bounces-236806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5383991E74F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59451F24D34
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4304916EBF9;
	Mon,  1 Jul 2024 18:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F28nitf5"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2879E155736
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 18:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719857927; cv=none; b=Ox6xxn4OxgF7cGbKcDf0Bd0qpJiqrQlYmNb5e/sZmmoOxoXtl4l3XZoQIQWLREwBDn1bvDOMAl7LLBfDEjtmkNzFZJJN7ukVc/gHnzr4U6kedBkxE20ZtYfkzOo1WmfUbxI7XpPp0hdLJpMXXUE7o+wy/Z5V1JxtolU2PEZ0zks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719857927; c=relaxed/simple;
	bh=sUcpqYgS26nZi4iKtVTvVn8xs4FiKMpe50/Pc2MBFaw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DU9j1PiLUnc998PCju1ZONz3UsKKfj1VUMOOru11epdJRZUkvKrcQVClc80wEXAO2rFICC9uT0x+CHeG7F6i/RCRL3djO9TqNRxyQ50dajIYiwG1qoevc22/ECtHiIx8DzGjeW7bIA7OcXPNy+V+/+gRGAbE+Lji/KLv4ioccqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F28nitf5; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-366df217347so1954020f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 11:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719857923; x=1720462723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f9jHABfdrezA5Ty0dwgvQ9b0kb2qoOfwiLYjRI1ipLc=;
        b=F28nitf5wxuJZl0VZs9wRyCEvM1WZvP1ZZDI2gdf7O4JbKJ6gOZ5tX7v7e7rKh5jbT
         JzhD/Jk6u53dH6F/shOnKL4iyHAdl33vy3hWOaEh3nUW/EMps0RkggyAmS2BZGn0qJ0u
         PP3aNJ3UgjgzvUJYH5h4vVru8ZVrBznkNkb/oZDrzmALgehB3mCB2549yEa8jTFdP3IV
         Vh+gms6X2ouveGtia7HH23XuMJSS3uGcOv9igx5afAXCuTYSIfNgsTyJLsrx++CixibQ
         Y8BTqbFmauQ2E0KPNdlrOOTY/qrocD6p1MuH5715LBJkwy99Lpk6gtpHD5RkFMR8CIwv
         I9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719857923; x=1720462723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f9jHABfdrezA5Ty0dwgvQ9b0kb2qoOfwiLYjRI1ipLc=;
        b=Rgw4Q+Spt9s5FbhPEupSu5NJFRPT7Z6fEPzUFbRJo9xFLEgxhVG6S8TS2xTYSTW8pS
         2ToFsMbnMV9SfrwBw3YMdR3TLAdTCHyIje5aLPK4Ic0uShaD6x5+RidguDyWP/MYoFvb
         9w3/vLyGbiIg9qGUD4Nasx/qmbZdlFkVUEy21u9keBbkBgqE7ys4+yNWbFkJdR61LDXv
         zPW9rDIqMxl+LAQzRUswZQbpW0r2tR3SkW8xJlKzdck+oDslDuLQXgPt1ZsFgdC/fdGA
         nFb1DRK5HqXQtzofpbyOv3lhmQU6KsrAmX6BqnpQcG/U0bdS/J4MpvK4oih9LGk4StNy
         mjlA==
X-Forwarded-Encrypted: i=1; AJvYcCX9fq9McL65IipifiEL1Zymi2tc/ZMLqTYuI53FzGF5eN2Z8v5MBHOVueXztix/tFmZFAPthkLo4YhSg4OCQRrRvVfVUBJ8YEWWUclD
X-Gm-Message-State: AOJu0YxHQanYZQ1fOLiJa9ZW5JL596JRmWVyLgv3qgyXc865sewhldvy
	R9fmfNkxubDIK8oXOcuL8Ij0HGJnnNrtY/inOFSbQw/28TNPzpNOObnH3P+wJwqaqYPX0C9w/rN
	R
X-Google-Smtp-Source: AGHT+IHSnCv/NqbvNhifKl5T9krqjKcqSvJYaLByJGA7FQiYRmy8h33KgtjSeA2SuJmC+Th2F1/eNA==
X-Received: by 2002:a05:6000:1566:b0:362:3b56:dbda with SMTP id ffacd0b85a97d-367756997a4mr4259131f8f.9.1719857923301;
        Mon, 01 Jul 2024 11:18:43 -0700 (PDT)
Received: from hackbox.lan ([82.79.124.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0e16a8sm10682587f8f.64.2024.07.01.11.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 11:18:42 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
To: Mike Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: imx@lists.linux.dev,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-clk@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] clk: imx: Updates for v6.11
Date: Mon,  1 Jul 2024 21:18:25 +0300
Message-Id: <20240701181825.916610-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/ tags/clk-imx-6.11

for you to fetch changes up to 466da3d2d967ee87d82060df2bc9c6ad4fc4af49:

  clk: imx: composite-7ulp: Use NULL instead of 0 (2024-06-24 14:22:08 +0300)

----------------------------------------------------------------
i.MX clocks changes for 6.11

- Add reset controller support to audiomix block control
- Add CLK_SET_RATE_PARENT flag to all audiomix clocks and to
  i.MX7D lcdif_pixel_src clock
- Fix parent clocks for earc_phy and audpll on i.MX8MP
- Fix default parents for enet[12]_ref_sel on i.MX6UL
- Add ops in composite 8M and 93 that allow no-op on disable
- Add check for PCC present bit on composite 7ULP register
- Fix fractional part for fracn-gppll on prepare
- Fix clock tree update for TF-A managed clocks on i.MX8M
- Drop CLK_SET_PARENT_GATE for DRAM mux on i.MX7D
- Add the SAI7 IPG clock for i.MX8MN
- Mark the 'nand_usdhc_bus' clock as non-critical on i.MX8MM
- Add LVDS bypass clocks on i.MX8QXP
- Add muxes for MIPI and PHY ref clocks
- Reorder dc0_bypass0_clk, lcd_pxl and dc1_disp clocks on i.MX8QXP
- Add 1039.5MHz and 800MHz rates to fracn-gppll table
- Add CLK_SET_RATE_PARENT for media_disp pixel clocks on i.MX8QXP
- Add some module descriptions to the i.MX generic and the
  i.MXRT1050 driver.
- Fix return value for bypass for composite 7ULP

----------------------------------------------------------------
Adrian Alonso (1):
      clk: imx: imx8mn: add sai7_ipg_clk clock settings

Jacky Bai (2):
      clk: imx: composite-93: keep root clock on when mcore enabled
      clk: imx: imx8mm: Change the 'nand_usdhc_bus' clock to non-critical one

Jeff Johnson (1):
      clk: imx: add missing MODULE_DESCRIPTION() macros

Marek Vasut (1):
      clk: imx: clk-imx8mp: Allow media_disp pixel clock reconfigure parent rate

Oliver F. Brown (1):
      clk: imx: imx8qxp: Add clock muxes for MIPI and PHY ref clocks

Peng Fan (8):
      clk: imx: composite-8m: Enable gate clk with mcore_booted
      clk: imx: Remove CLK_SET_PARENT_GATE for DRAM mux for i.MX7D
      clk: imx: add CLK_SET_RATE_PARENT for lcdif_pixel_src for i.MX7D
      clk: imx: imx8qxp: Add LVDS bypass clocks
      clk: imx: imx8qxp: Register dc0_bypass0_clk before disp clk
      clk: imx: imx8qxp: Parent should be initialized earlier than the clock
      clk: imx: fracn-gppll: update rate table
      clk: imx: composite-7ulp: Use NULL instead of 0

Pengfei Li (1):
      clk: imx: fracn-gppll: fix fractional part of PLL getting lost

Sebastien Laveze (1):
      clk: imx: imx6ul: fix default parent for enet*_ref_sel

Shengjiu Wang (4):
      dt-bindings: clock: imx8mp: Add #reset-cells property
      clk: imx: clk-audiomix: Add reset controller
      clk: imx: clk-audiomix: Add CLK_SET_RATE_PARENT flags for clocks
      clk: imx: clk-audiomix: Correct parent clock for earc_phy and audpll

Ye Li (1):
      clk: imx: composite-7ulp: Check the PCC present bit

Zhipeng Wang (1):
      clk: imx: imx8mp: fix clock tree update of TF-A managed clocks

 .../devicetree/bindings/clock/imx8mp-audiomix.yaml |  3 +
 drivers/clk/imx/Kconfig                            |  1 +
 drivers/clk/imx/clk-composite-7ulp.c               |  7 ++
 drivers/clk/imx/clk-composite-8m.c                 | 53 ++++++++++---
 drivers/clk/imx/clk-composite-93.c                 | 15 ++--
 drivers/clk/imx/clk-fracn-gppll.c                  |  6 ++
 drivers/clk/imx/clk-imx6ul.c                       |  4 +-
 drivers/clk/imx/clk-imx7d.c                        |  6 +-
 drivers/clk/imx/clk-imx8mm.c                       |  2 +-
 drivers/clk/imx/clk-imx8mn.c                       |  1 +
 drivers/clk/imx/clk-imx8mp-audiomix.c              | 86 ++++++++++++++++++++--
 drivers/clk/imx/clk-imx8mp.c                       |  8 +-
 drivers/clk/imx/clk-imx8qxp.c                      | 51 ++++++++-----
 drivers/clk/imx/clk-imxrt1050.c                    |  1 +
 drivers/clk/imx/clk.c                              |  1 +
 drivers/clk/imx/clk.h                              |  4 +
 16 files changed, 197 insertions(+), 52 deletions(-)

