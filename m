Return-Path: <linux-kernel+bounces-303293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48782960A4B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7822BB24748
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15EA1B5EDA;
	Tue, 27 Aug 2024 12:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vYm4frDR"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E85D1A7077
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 12:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761774; cv=none; b=r2KBC6xvU3lVGb9KZNDu05bxEGD4zw29w0xPU0BzKGC7AWTM4XYCKl0Mc+ge1GYzC9YVc7APa9OTFPOgccndxgjQuYLBwM1zT2du0olDsaO+dhGOlxfcnEDBKtrdLq46QdvRJ4Egv6I8rb9oQeJwmlkK9+cffAg2oG4o/QlK1d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761774; c=relaxed/simple;
	bh=wP2AVbCMtrN5VtbZj7tTRuLCXB5q6tl+tSebAQqIpqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DSJ2L/CAQSgOxNNlxB+jDAhyy63ObT/qxqH65Yo+Qttfa1lB/eAysYryYqPqE4d8P0rZOnXgU7h0PqU2r3Z+BKN8WSP8H4XwONlRHeJzqojGkPLIciukQMCv3+kiMAIg9OdXFblncn8cHaqejMBfiUZN+iTJ2CDvaCugj7SpD3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vYm4frDR; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3719419c2aaso168072f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 05:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724761770; x=1725366570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fL31jwiSCqggQr8vCejcnZYNEtXeVayNVEVXtcMxsQo=;
        b=vYm4frDR0K+x1KKRTaZjAiBMdzoniwXbbJU3ScqUF6JFE1fBae96BJhgKyMBdFg552
         VTj9+dtTPPAgZeqMeuvWJzl3dncJf+qq9/p0wQUGem/4HQuU2uDvDSM0Khqh+1QPVDBN
         ld32qKDpucg9nbs51WFL3B0yFEOlhF9Pfj3RdeGUAbwySVGIgdgGOKjilZXQ9Enus6+R
         dXQHr9T4SIpHuRz3NCbSvtAoNFIxaV8Mok0VBfhpiiAnrJUkyn65Ir/2V/Jf15eacvSq
         xOJB/0/uitpedL3pXaN7okk2OUnagJyS7KvTpgYBO4M1nqJ+WvsxIfKk1lKo4iB5gNjl
         cDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724761770; x=1725366570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fL31jwiSCqggQr8vCejcnZYNEtXeVayNVEVXtcMxsQo=;
        b=K1e91WAVIAVYPU0gUKsmW0QCgrWbf2QLoA03jLj3y+jzMEOHSckf5JRV0kKixCN7ex
         oI7zADg00uhFlZITF/n1g/eF8lSaevV8QVnighELSeRcYfP36gn82p/oCox9YDPQByl2
         +nkc9lbA7ggiuh05qA/PfQuwFrMk8opOcm37AWhk0kwcqvcNuHat/qOX6526XGZp15zw
         kJgikqucKZjifNL4Xwpa6P8iU+1TcvD/Hj7ZnMxfnx8zRFqecjo5rk0wME0xHOOUq2z+
         JUNhz/3ZrtwkJeNjcSExGnyrtAVuTL7I+mBM62B2c2Oaa1LsmIepcv6EmxDrGHhBFp2k
         2zDw==
X-Forwarded-Encrypted: i=1; AJvYcCXHjnb+iRyg3/r9DMfy3oy9z0mPdEjwK7a3T6nA96+l5PvSflpUqcnPm5xb9M1uXY6AsxHHQrXRGNPVjcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyobMGPj2WGimiqT0yp84T6jnIO8WE0ttP28N2FMjOmLHj/B8TG
	OdEmPmQVgyM9Q2tJy8odHNq+pqJeSDQccmrL75u3GXgD8G9x11CDjHwSB640vKM=
X-Google-Smtp-Source: AGHT+IEs/GSUZdufo34i3JJju+48AQe7CSrCAmrcnZ54qyfZuxk0qpho9VhpbqydQfb6yzephaTVZQ==
X-Received: by 2002:a5d:648e:0:b0:373:6bf:9608 with SMTP id ffacd0b85a97d-37311843370mr5383974f8f.2.1724761770204;
        Tue, 27 Aug 2024 05:29:30 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730821a9fcsm12900533f8f.94.2024.08.27.05.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 05:29:29 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Olof Johansson <olof@lixom.net>,
	Arnd Bergmann <arnd@arndb.de>,
	arm@kernel.org,
	soc@kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] memory: drivers for v6.12
Date: Tue, 27 Aug 2024 14:29:25 +0200
Message-ID: <20240827122926.30794-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I might have one more smaller pull request coming later.

Best regards,
Krzysztof


The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-6.12

for you to fetch changes up to ff390189b7f2cfa20c644bc58b4462b5e2621838:

  memory: mtk-smi: Use devm_clk_get_enabled() (2024-08-25 11:02:17 +0200)

----------------------------------------------------------------
Memory controller drivers for v6.12

1. Tegra210 EMC: Driver refactoring and rework.
2. Tegra186 EMC: Drop unused function.
3. FSL WEIM: Correct fsl,weim-cs-timing property to properly validate it
   as an array.
4. TI AEMIF: Drop platform data support.
5. TI EMIF: Switch to of_property_read_bool().

6. Several cleanups in multiple drivers: TI AEMIF and EMIF, Tegra
   EMC/MC, Atmel EBI, Samsung Exynos5422 DMC, STM32 FMC2 EBI, OMAP GPMC,
   PL172 and PL1353 SMC.  These are mostly code simplifying around
   probe() like using
    - devm_clk_get_enabled(),
    - dev_err_probe(),
    - scoped device node handling (cleanup.h),
    - scoped for each OF child loops,
    - scoped/guard locks.

----------------------------------------------------------------
Bartosz Golaszewski (4):
      memory: ti-aemif: remove platform data support
      memory: ti-aemif: use devm_clk_get_enabled() and shrink the code
      memory: ti-aemif: don't needlessly iterate over child nodes
      memory: ti-aemif: Revert "memory: ti-aemif: don't needlessly iterate over child nodes"

Diogo Ivo (7):
      memory: tegra: Remove periodic compensation duplicate calls
      memory: tegra: Move DQSOSC measurement to common place
      memory: tegra: Reword and correct comments
      memory: tegra: Change macros to interpret parameter as integer
      memory: tegra: Loop update_clock_tree_delay()
      memory: tegra: Move compare/update current delay values to a function
      memory: tegra: Rework update_clock_tree_delay()

Krzysztof Kozlowski (21):
      memory: tegra186-emc: drop unused to_tegra186_emc()
      dt-bindings: memory-controllers: renesas,rpc-if: add top-level constraints
      memory: atmel-ebi: use scoped device node handling to simplify error paths
      memory: atmel-ebi: simplify with scoped for each OF child loop
      memory: samsung: exynos5422-dmc: simplify dmc->dev usage
      memory: samsung: exynos5422-dmc: use scoped device node handling to simplify error paths
      memory: stm32-fmc2-ebi: simplify with scoped for each OF child loop
      memory: stm32-fmc2-ebi: simplify with dev_err_probe()
      memory: tegra-mc: simplify with scoped for each OF child loop
      memory: tegra124-emc: simplify with scoped for each OF child loop
      memory: tegra20-emc: simplify with scoped for each OF child loop
      memory: tegra30-emc: simplify with scoped for each OF child loop
      memory: ti-aemif: simplify with dev_err_probe()
      memory: ti-aemif: simplify with scoped for each OF child loop
      memory: emif: drop unused 'irq_state' member
      memory: emif: simplify locking with guard()
      memory: omap-gpmc: simplify locking with guard()
      memory: pl172: simplify with dev_err_probe()
      memory: pl172: simplify with devm_clk_get_enabled()
      memory: pl353-smc: simplify with dev_err_probe()
      memory: pl353-smc: simplify with devm_clk_get_enabled()

Rob Herring (Arm) (2):
      memory: emif: Use of_property_read_bool()
      dt-bindings: memory-controllers: fsl,imx-weim: Fix "fsl,weim-cs-timing" schema

Rong Qianfeng (1):
      memory: mtk-smi: Use devm_clk_get_enabled()

 .../memory-controllers/fsl/fsl,imx-weim.yaml       |  25 +-
 .../memory-controllers/renesas,rpc-if.yaml         |   4 +-
 drivers/memory/atmel-ebi.c                         |  35 +-
 drivers/memory/emif.c                              |  31 +-
 drivers/memory/mtk-smi.c                           |   6 +-
 drivers/memory/omap-gpmc.c                         |  24 +-
 drivers/memory/pl172.c                             |  30 +-
 drivers/memory/pl353-smc.c                         |  50 +--
 drivers/memory/samsung/exynos5422-dmc.c            |  90 ++--
 drivers/memory/stm32-fmc2-ebi.c                    |  23 +-
 drivers/memory/tegra/mc.c                          |  11 +-
 drivers/memory/tegra/tegra124-emc.c                |   7 +-
 drivers/memory/tegra/tegra186-emc.c                |   5 -
 drivers/memory/tegra/tegra20-emc.c                 |   7 +-
 drivers/memory/tegra/tegra210-emc-cc-r21021.c      | 455 +++++----------------
 drivers/memory/tegra/tegra30-emc.c                 |   7 +-
 drivers/memory/ti-aemif.c                          |  74 +---
 include/linux/platform_data/ti-aemif.h             |  45 --
 18 files changed, 236 insertions(+), 693 deletions(-)
 delete mode 100644 include/linux/platform_data/ti-aemif.h

