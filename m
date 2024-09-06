Return-Path: <linux-kernel+bounces-318982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788AE96F61F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 238622841FD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3700A1EA65;
	Fri,  6 Sep 2024 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CSpZXmDc"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8321799F
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 14:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725631281; cv=none; b=rW3S7uHS1JOzzpZqvP0EEVwR2v3D9w4ipXkRe0L5xhwVTBWk0pHbx03aO0PUzzFMeX1d+L44Ng+0r+cURlHZC7cmJdkJkbKCJ1s8NaJgyTOJKXa7MRfziaLKeow2eQqISwNVXkrRdqpjumpGcB4RO9UI8ZHdYQC5KEerCPRZ7uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725631281; c=relaxed/simple;
	bh=0TZGFFblseD1XzUlKvxPGUFM77Kk+EJiwlfN3a5N3lw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qB1axZcktklu+6OIaEB9i8ZyHf2Bmkm0kdZUSEL9chZlfhFD9BefjAUT29CREDxJayfAydLFTYzxhZp2uj2A3YxXlQWFi0iIUl9eJoCo28OaAv1YUKG2PpQ+M2jHyN+z/zivAXoowSxfeYaaRZHGH726TRJ/fdjdh3ksFgAXZJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CSpZXmDc; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-536536f6f8fso332474e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 07:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725631278; x=1726236078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AcUWsTK40ufzjzSKkiyJYxbNIJ0fv8WDhSYTnJO0Ltc=;
        b=CSpZXmDcbzaZ2t6PDtoQdFf48+1jVMzMJ/KwdE/bqQTqthokSV4t0M5ZMgkB15socK
         lcl+X0rbJldz/fmhXFpvtACNIKI9KDVSzGkoLpuSv8+y/Ej0OiWYsJVBRnIMahfbX3hY
         Wa6vUG9RwYu5boC8BIdqsiKYSzjaXT/cEYqwxWL2D20ZvrE1MKIJcbZJnsk2Tr16mlPG
         tBlLv1UmfBTGRCreRSnyCevDzscL4EGJ6TYI2ej/IxMuzzx/VV8M9x0lIfB6CzONgb9p
         iBJZUdNTp5gEvFUQpXS6gYJVfBdygtjyIsG1P3EOofVOmIzy/YUE/9kJltfjTwKQQsEo
         3Nqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725631278; x=1726236078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AcUWsTK40ufzjzSKkiyJYxbNIJ0fv8WDhSYTnJO0Ltc=;
        b=A3N7ereCnBE32H8VZAgQF8W6PcGM+UwfG4MM6/dwTJUtY4RIAGXmgCrICq6Hl8tIty
         68SQ7cRIT0zGiBgXKi2Zm62OuA22WOsRnTrrwHIfj9CRZOAgryCpIhTARifMFz1+AIvz
         7bPv9wcks2atFwyFXIrd0BUay/FAPhYLcuOJ7DxR6s3Bfxm1rW2R1nRrQ0DM/HhU4fVQ
         nRUrD2ycU5dh2lUOXsdvmC1YrBp1GoxB/4Ftf2J5QqfPf1hXamNToiEQsWcVEG6WlrPX
         +2/VbhSL/QREDI8+2O9TH+ouKUqYQBjT7McvuhSoM3wGN6Ku1ox9KBczpaCVX5gmqqTJ
         Wj4w==
X-Forwarded-Encrypted: i=1; AJvYcCV0s5YQQWvK9Em1BKsvqeo6Zd3wSjVKYVShz+vTI/G7DmA1k+C7pCr5UFTRCloOLiSgZO6VyZsevGXco0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza/x/58k+l2vrj4bnBDjSC73HvoCZlo0Ib+1ATMF/GyXZ/Q4Xa
	8SKRFTvj+0tCQXiiX9fXQmW7rfaqRbIpz6wCyrWlX+HRLzkEr3GyyhRoRfLMhif2KBF2R/mf0XF
	s
X-Google-Smtp-Source: AGHT+IGlmv2AbsdgjpYnNyWtkoQ9kk+XTDqlQ7jIgkBs4spQQBM+yrJuJHUBTyoACaiSEwgScqbw0g==
X-Received: by 2002:a05:6512:2356:b0:535:681d:34b6 with SMTP id 2adb3069b0e04-5365882c1f9mr813526e87.10.1725631276738;
        Fri, 06 Sep 2024 07:01:16 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a6236d194sm277544866b.113.2024.09.06.07.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 07:01:15 -0700 (PDT)
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
Subject: [GIT PULL] clk: samsung: drivers for v6.12
Date: Fri,  6 Sep 2024 16:01:10 +0200
Message-ID: <20240906140111.70922-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-clk-6.12

for you to fetch changes up to 485e13fe2fb649e60eb49d8bec4404da215c1f5b:

  clk: samsung: add top clock support for ExynosAuto v920 SoC (2024-08-23 09:21:35 +0200)

----------------------------------------------------------------
Samsung SoC clock drivers changes for 6.12

1. Exynos850: Add clock for Thermal Management Unit.
2. Exynos7885: Fix duplicated ID in the header, add missing TOP PLLs and
   add clocks for USB block in the FSYS clock controller.
3. ExynosAutov9: Add DPUM clock controller
4. ExynosAutov920: Add new (first) clock controllers: TOP and PERIC0
   (and a bit more complete bindings).

----------------------------------------------------------------
David Virag (7):
      dt-bindings: clock: exynos7885: Fix duplicated binding
      dt-bindings: clock: exynos7885: Add CMU_TOP PLL MUX indices
      dt-bindings: clock: exynos7885: Add indices for USB clocks
      clk: samsung: exynos7885: Update CLKS_NR_FSYS after bindings fix
      clk: samsung: exynos7885: Add missing MUX clocks from PLLs in CMU_TOP
      clk: samsung: clk-pll: Add support for pll_1418x
      clk: samsung: exynos7885: Add USB related clocks to CMU_FSYS

Krzysztof Kozlowski (3):
      Merge branch 'for-v6.12/clk-dt-bindings' into next/clk
      Merge branch 'for-v6.12/clk-dt-bindings' into next/clk
      Merge branch 'for-v6.12/clk-dt-bindings' into next/clk

Kwanghoon Son (2):
      dt-bindings: clock: exynosautov9: add dpum clock
      clk: samsung: exynosautov9: add dpum clock support

Sam Protsenko (2):
      dt-bindings: clock: exynos850: Add TMU clock
      clk: samsung: exynos850: Add TMU clock

Sunyeal Hong (3):
      dt-bindings: clock: add ExynosAuto v920 SoC CMU bindings
      clk: samsung: clk-pll: Add support for pll_531x
      clk: samsung: add top clock support for ExynosAuto v920 SoC

 .../bindings/clock/samsung,exynosautov9-clock.yaml |   19 +
 .../clock/samsung,exynosautov920-clock.yaml        |  162 +++
 drivers/clk/samsung/Makefile                       |    1 +
 drivers/clk/samsung/clk-exynos7885.c               |   93 +-
 drivers/clk/samsung/clk-exynos850.c                |    7 +-
 drivers/clk/samsung/clk-exynosautov9.c             |   83 ++
 drivers/clk/samsung/clk-exynosautov920.c           | 1173 ++++++++++++++++++++
 drivers/clk/samsung/clk-pll.c                      |   62 +-
 drivers/clk/samsung/clk-pll.h                      |    2 +
 include/dt-bindings/clock/exynos7885.h             |   32 +-
 include/dt-bindings/clock/exynos850.h              |    1 +
 include/dt-bindings/clock/samsung,exynosautov9.h   |   11 +
 include/dt-bindings/clock/samsung,exynosautov920.h |  191 ++++
 13 files changed, 1802 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynosautov920-clock.yaml
 create mode 100644 drivers/clk/samsung/clk-exynosautov920.c
 create mode 100644 include/dt-bindings/clock/samsung,exynosautov920.h

