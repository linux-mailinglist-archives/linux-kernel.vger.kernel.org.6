Return-Path: <linux-kernel+bounces-553260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A1EA58674
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 18:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32778166101
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 17:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909781EF372;
	Sun,  9 Mar 2025 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h3TQGOOI"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB611DEFCD
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 17:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741542715; cv=none; b=NYDEzjV5JyDh5Mn/+jKyRuI99yuv+Vm2PDb3SIFdEbsmw749eBdxyMGwXB3+vAvVUypsxURfsv8tqDT9MA1OcwiOX7jBCTzW1Fg3oJxFG3Ngm7y3QbJ9nqHvnxXtMe4pS4cf56Olr2WPWnIAkdtwlj2DY3ZG/3VaCGqjVZlsLS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741542715; c=relaxed/simple;
	bh=wqzDb0QwjxRa7XVwLas9r4QBvnQeBCYaIII+SwsSoao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GDtqZe8ooUj0+OIS8AXlwmXztYrFiuW1M721yW0n5MW9XBY1cf1DRzHfnN6e4B8PUAw9scTMr2wrT39SaBt8Pvoh3cH504KvPcpiIiIxUTZrb8GF01jdSdUYgwtkG8L6M9PT7NErYz/hwtbcuwd6tzBeoLdRgT+2IvvzkVtgCqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h3TQGOOI; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3912b75c0f2so184665f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 10:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741542711; x=1742147511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ag3e+knRyg8hgi6gCn3CC6P74JcStlCkhKaiz35snmc=;
        b=h3TQGOOI1zhU8maqRCYUmp9vaDw46f5IS+zcDmbqR4UjgZzDSXKhF5iOw+7DCmwos/
         5QHYylak0iCwcWYweKuBrMobEOMesce5evlKGak7tSraJnAakCHP3M4rncVhUh4cFg6F
         9MsbmKNgqkXP2FAggMcUV+7KHnzkVuu4VmCbONJawMfQPjBMdGW4lcdPdsc/ad1a47ib
         7fwSJ1a4/FgBaXRkp6dquN2EK/K9Jb4YIUe5EbKb+yuw2ugE9Ge0ZvxilC6FdJlQKwLq
         hdOajDBzOuQMVkLPgpd1Er0uTKhp+m/tb8bdF0HMloqQXo0Y7KaWVT5qHVJroEmlkCZD
         i4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741542711; x=1742147511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ag3e+knRyg8hgi6gCn3CC6P74JcStlCkhKaiz35snmc=;
        b=NHB2f9uS6/eeUGHEn4d8iROuMHbMyHlfCvfRg8Akk4JY8tFZautCqXjn1zRxYGjyuT
         ze1vW52y0T12WTLLjowkwESFiUYIUDjV4jWGjmnZetTN2eypKTwjeK8vw8a862iG456a
         bwQJ+KRyjuYSIWAkV2Ki+5sPogxeX496fdVyyrZPdFVHPMC9pAsyGz7g+p8wO/MT7xrq
         XJGTOH4kmM3r7orpj+IYnoYoGbMrb0Jh2yJW3so1rE36C/aKTJ93eFWfz+ov1UR7lJjh
         rEK78NnGIvhExxfxQGqMEGfBTrPg9csAOHn7nHCgC2hzbdi/31Qs0MjxeXHloE03B+95
         g/mQ==
X-Forwarded-Encrypted: i=1; AJvYcCUobcayOlZ7+VzEZ3PKjeHEDO8p2WDFCg4mjrdjgLCx7ifoWxkAw2XP2mO5qLOs9pEXCdysPoh4DE+jmrA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3EzcpR1RbSv9wOMxSZwd+T8Yy14vx+UYJMQ+vP7UnQrD5mILr
	tPJM7qnGcs1Jwbb9X9MUO8vyu6NRLtLTUDmr1BcH5jDUrITez/Ft82/pzHFIfC0=
X-Gm-Gg: ASbGnctqHHmC26DzOIwi3jIcBhJw/sdBWxXLk6xmi0R1iio2K8oyY2cHvCVQyVGD4/k
	L6JU+XKcCdb/rpJzioOLvtt5JBA3sH7d6Oi8v3prLIDdUsZ5tTzG7nQXZk+Q1CcoWYS739p4y+4
	iBLDK8agkjLYz7KF3YyJOhhAwcd/0EWjCY4KEUuCL7jDGMGsarV/pBTyYrqs14wEKVgrMpteAxq
	Iu2Z5ts+7DP+V3QjsKIDzZEDFFyCUMt3UeGupxkr1KQRk9NvfvJfqyk1U7BNJu0RhW3v4jY8Yrr
	EPtSKpo8H9SyGEAQyxTmAet5MFpEZq2cBrXP9pGm02g8YsCPjXEA2AjhK4tdnCgf8F0lhQ==
X-Google-Smtp-Source: AGHT+IFa08ql7h89Y752Zvu7Rau8znLYoWC3F6Ls9EZuW63PkjYBwc7RN80jzLbibjKC9dFckabhWw==
X-Received: by 2002:a05:6000:4021:b0:390:d8ec:1779 with SMTP id ffacd0b85a97d-3913bbd20d1mr1460637f8f.12.1741542711124;
        Sun, 09 Mar 2025 10:51:51 -0700 (PDT)
Received: from krzk-bin.. ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ceeb34904sm39156975e9.30.2025.03.09.10.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 10:51:50 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	linux-clk@vger.kernel.org,
	Sylwester Nawrocki <snawrocki@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] clk: samsung: drivers for v6.15
Date: Sun,  9 Mar 2025 18:51:47 +0100
Message-ID: <20250309175147.6672-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

New clk drivers for Samsung SoC.  This pull includes drivers which you
commented later and pointed out few issues.  Pointed issues are in all Samsung
clk drivers and the ones here just copy existing patterns:

1. Headers: I fixed it for new and existing drivers and this pull request
includes the fixes.
2. device_get_match_data(): I still wait for contributors response. If they do
not respond, I will fix it for next cycle.
3. refdata and platform_driver_probe: I tried fixing it, but incomplete and
need to investigate more.

Best regards,
Krzysztof


The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-clk-6.15

for you to fetch changes up to 017bbc922a09630579ff7b5b314fb186b8c0efcf:

  clk: samsung: Drop unused clk.h and of.h headers (2025-03-07 16:01:22 +0100)

----------------------------------------------------------------
Samsung SoC clock drivers changes for 6.15

1. Exynos990: Add support for the PERIS clock controller in existing
   driver.
2. Exynos2200: Add new driver for several clock controllers (Alive,
   CMGP, HSI, PERIC/PERIS, TOP, UFS and VFS).
3. Exynos7870: Add new driver for several clock controllers (Alive,
   MIF, DISP AUD, FSYS, G3D, ISP, MFC and PERI).
4. Correct undefined behavior / runtime array bounds check of flexible
   array member (last 'hws' element in 'struct clk_hw_onecell_data').
   The code was logically correct for normal case, but not for the
   clang/GCC runtime bounds checking of flexible array member.
5. Few cleanups: spelling, header inclusions.

----------------------------------------------------------------
Colin Ian King (1):
      clk: samsung: Fix spelling mistake "stablization" -> "stabilization"

Igor Belwon (2):
      dt-bindings: clock: exynos990: Add CMU_PERIS block
      clk: samsung: exynos990: Add CMU_PERIS block

Ivaylo Ivanov (3):
      dt-bindings: clock: add Exynos2200 SoC
      clk: samsung: clk-pll: add support for pll_4311
      clk: samsung: introduce Exynos2200 clock driver

Kaustabh Chakraborty (2):
      dt-bindings: clock: add clock definitions and documentation for exynos7870 CMU
      clk: samsung: add initial exynos7870 clock driver

Krzysztof Kozlowski (3):
      Merge branch 'for-v6.15/samsung-clk-dt-bindings' into next/clk
      clk: samsung: Add missing mod_devicetable.h header
      clk: samsung: Drop unused clk.h and of.h headers

Will McVicker (1):
      clk: samsung: Fix UBSAN panic in samsung_clk_init()

 .../bindings/clock/samsung,exynos2200-cmu.yaml     |  247 ++
 .../bindings/clock/samsung,exynos7870-cmu.yaml     |  227 ++
 .../bindings/clock/samsung,exynos990-clock.yaml    |   19 +
 drivers/clk/samsung/Makefile                       |    2 +
 drivers/clk/samsung/clk-cpu.c                      |    2 +-
 drivers/clk/samsung/clk-exynos-audss.c             |    1 +
 drivers/clk/samsung/clk-exynos-clkout.c            |    1 +
 drivers/clk/samsung/clk-exynos2200.c               | 3928 ++++++++++++++++++++
 drivers/clk/samsung/clk-exynos3250.c               |    4 +-
 drivers/clk/samsung/clk-exynos4.c                  |    2 +-
 drivers/clk/samsung/clk-exynos4412-isp.c           |    2 +-
 drivers/clk/samsung/clk-exynos5-subcmu.c           |    1 +
 drivers/clk/samsung/clk-exynos5250.c               |    1 +
 drivers/clk/samsung/clk-exynos5260.c               |    3 -
 drivers/clk/samsung/clk-exynos5410.c               |    2 -
 drivers/clk/samsung/clk-exynos5420.c               |    1 +
 drivers/clk/samsung/clk-exynos5433.c               |    4 +-
 drivers/clk/samsung/clk-exynos7.c                  |    1 -
 drivers/clk/samsung/clk-exynos7870.c               | 1829 +++++++++
 drivers/clk/samsung/clk-exynos7885.c               |    2 +-
 drivers/clk/samsung/clk-exynos850.c                |    2 +-
 drivers/clk/samsung/clk-exynos8895.c               |    2 +-
 drivers/clk/samsung/clk-exynos990.c                |  182 +-
 drivers/clk/samsung/clk-exynosautov9.c             |    2 +-
 drivers/clk/samsung/clk-exynosautov920.c           |    2 +-
 drivers/clk/samsung/clk-fsd.c                      |    2 +-
 drivers/clk/samsung/clk-gs101.c                    |    2 +-
 drivers/clk/samsung/clk-pll.c                      |    1 +
 drivers/clk/samsung/clk-pll.h                      |    1 +
 drivers/clk/samsung/clk-s3c64xx.c                  |    1 -
 drivers/clk/samsung/clk-s5pv210-audss.c            |    1 +
 drivers/clk/samsung/clk-s5pv210.c                  |    1 -
 drivers/clk/samsung/clk.c                          |    4 +-
 drivers/clk/samsung/clk.h                          |    1 +
 include/dt-bindings/clock/samsung,exynos2200-cmu.h |  431 +++
 include/dt-bindings/clock/samsung,exynos7870-cmu.h |  324 ++
 include/dt-bindings/clock/samsung,exynos990.h      |   21 +
 37 files changed, 7231 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynos2200-cmu.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynos7870-cmu.yaml
 create mode 100644 drivers/clk/samsung/clk-exynos2200.c
 create mode 100644 drivers/clk/samsung/clk-exynos7870.c
 create mode 100644 include/dt-bindings/clock/samsung,exynos2200-cmu.h
 create mode 100644 include/dt-bindings/clock/samsung,exynos7870-cmu.h

