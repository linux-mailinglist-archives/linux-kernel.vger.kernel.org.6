Return-Path: <linux-kernel+bounces-173488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D0C8C00FE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74DE91C2445B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC961272B4;
	Wed,  8 May 2024 15:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J1IuKkWq"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A2F127B4D
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 15:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715182325; cv=none; b=sEs3O3QndvwegEr12um71r+iwCxZ6mw1KRPf8XlMd+JIQeNjGiDGcU12sacwDae7GIWkBWr+wnqA3T7ffILiPHVvzK9GwhuDZCQcowZYIsm8AclE6pG4xlOcLj/VFDoFvEhNQTM/nzbtgKtbowH/nH5S/dU3VEPhOhho4aMa+p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715182325; c=relaxed/simple;
	bh=d6A87ZdDShos4dPJ2y/3IA60bZ8PQJh++57xgXv9pFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ORpF2PmFNROs/xaPXISNfVcuSq2iUk+/HqSogReeT3WZDYANQNZrBOyM/qYWnbP+Lo2YQynNHiGYsz5y0D7DQDjGvKdQzLbva9SfSoaGLX8S9IlMqguijlB05Aiz5UVp5i6bczInNbjziyKr5WMb+ysaD4ZSkhzq20VGBj6gG20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J1IuKkWq; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a59a5f81af4so1187005466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 08:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715182322; x=1715787122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xupSga4L31hmKfvqtY9DNqTyzYiKLL6jl7vTBAe7YEE=;
        b=J1IuKkWq9O7msQM2GQRIHMkA3ijeplNea0j2LWASzHcp4DdL0d6/oQTd0JAYFU/0tk
         UoMGdUxSDrQdqbGkeyyrpCZ7ZIsqIlq6LuoCDl415d5aTVGYoagpPTlyasHZZlTNl6+d
         OIJoiT5DQ2ooij1crRv4EisfSdFNwWPyd1vjgmbsivoRp7aDtD3l6TIIgc9UA748o+ux
         UED64QIxBgfYWGbR81LFAf0zNX2mAMh2B4VH7PKbSJ5JJNfMTaiOyNsmf0QZcxjaR37R
         WKLpy2JWK2ZRd2fhw7dH6PrxgVoyxWCYeR0NYobQovnG7XHs5vmBsLCLnsdwrJAp0m7Z
         fPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715182322; x=1715787122;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xupSga4L31hmKfvqtY9DNqTyzYiKLL6jl7vTBAe7YEE=;
        b=ZGPZeAEUsXOTfekmQW4mnJlSWnGlfLbRqSJsJL1oGF2afUu94O5cqE2V8MlyiPpcvE
         3a/408srI0i1bjTKgWjl+8StSa35ryX78NJp0jOQLHhKEE/joIBj7gMRLAB8/t6KoihM
         BqwHXkhDvNOqn2yDUI1LvPBfFabUl+L5padoXoxCU7uoeFZ+GHSdQaGPE2c8MMaZ0n6e
         3tIyPQjzGYb6FrditKYOBwSUXqYGQOWbglneKoEV3gUqqh5HfvRN9spD3/aKABLzED6K
         gR4YP21+QoKndoZFqE6YQBonQ2aN1Jq7STa4k7rqkMk4qZ244i5jaIMKmPmQ78oRPp4G
         TSLg==
X-Forwarded-Encrypted: i=1; AJvYcCWUnYSsl03TtSxlOqLzyXKIM4zFfEmOjn0g2tHD+mxUOjZXycfqGEzr6S+KXwd304g+yJOnMC8/z+m786mRfgOaRIoG0x4G9s1ZwmUq
X-Gm-Message-State: AOJu0Yw1SW0rUEpq+bmlzcB2N4g6eVOE5shJ/mGRj2M6UnWQwOZIShuL
	o272p9MJijvwhRHKl5CehSImlA5pjeLnT0e3ryk9F0s5/6n8S+RwOS17kZHfm3Q=
X-Google-Smtp-Source: AGHT+IGGZtYVnHUZ4EcfX4aUj9KBc6+H6XRuZCyQOp65StXRn/5tu41dc3BooKDe9AlZc5DJGcUdoQ==
X-Received: by 2002:a17:907:60e:b0:a59:a431:a8ce with SMTP id a640c23a62f3a-a59fb94a3fdmr209508866b.2.1715182322419;
        Wed, 08 May 2024 08:32:02 -0700 (PDT)
Received: from krzk-bin.. ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id em19-20020a170907289300b00a59c2da005csm4557320ejc.215.2024.05.08.08.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 08:32:01 -0700 (PDT)
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
Subject: [GIT PULL] clk: samsung: drivers for v6.10, fixed pull, 2nd try
Date: Wed,  8 May 2024 17:31:56 +0200
Message-ID: <20240508153158.496248-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Updated pull request with fixed issue of non-used local const data.

Best regards,
Krzysztof


The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-clk-6.10-2

for you to fetch changes up to 7c18b0a5aa46cc7e5d3a7ef3f9f8e3aa91bb780f:

  clk: samsung: gs101: drop unused HSI2 clock parent data (2024-05-07 11:47:39 +0200)

----------------------------------------------------------------
Samsung SoC clock drivers changes for 6.10

1. Allow choice of manual or firmware-driven control over PLLs, needed
   to fully implement CPU clock controllers on Exynos850.

2. Correct PLL clock IDs on ExynosAutov9.

3. Google GS101:
   - Propagate certain clock rates to allow setting proper SPI clock
     rates.
   - Add HSI0 and HSI2 clock controllers.
   - Mark certain clocks critical.

4. Convert old S3C64xx clock controller bindings to DT schema.

----------------------------------------------------------------
André Draszik (3):
      dt-bindings: clock: google,gs101-clock: add HSI0 clock management unit
      clk: samsung: gs101: add support for cmu_hsi0
      clk: samsung: gs101: mark some apm UASC and XIU clocks critical

Jaewon Kim (1):
      clk: samsung: exynosautov9: fix wrong pll clock id value

Krzysztof Kozlowski (3):
      dt-bindings: clock: samsung,s3c6400-clock: convert to DT Schema
      Merge branch 'for-v6.10/clk-gs101-bindings' into next/clk
      clk: samsung: gs101: drop unused HSI2 clock parent data

Peter Griffin (2):
      dt-bindings: clock: google,gs101-clock: add HSI2 clock management unit
      clk: samsung: gs101: add support for cmu_hsi2

Sam Protsenko (2):
      clk: samsung: Implement manual PLL control for ARM64 SoCs
      clk: samsung: exynos850: Add CMU_CPUCL0 and CMU_CPUCL1

Tudor Ambarus (2):
      clk: samsung: gs101: propagate PERIC0 USI SPI clock rate
      clk: samsung: gs101: propagate PERIC1 USI SPI clock rate

 .../bindings/clock/google,gs101-clock.yaml         |   55 +-
 .../bindings/clock/samsung,s3c6400-clock.yaml      |   57 +
 .../bindings/clock/samsung,s3c64xx-clock.txt       |   76 --
 drivers/clk/samsung/clk-exynos-arm64.c             |   56 +-
 drivers/clk/samsung/clk-exynos850.c                |  440 +++++++-
 drivers/clk/samsung/clk-exynosautov9.c             |    8 +-
 drivers/clk/samsung/clk-gs101.c                    | 1192 ++++++++++++++++++--
 drivers/clk/samsung/clk.h                          |   15 +-
 include/dt-bindings/clock/google,gs101.h           |  116 ++
 9 files changed, 1807 insertions(+), 208 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,s3c6400-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/samsung,s3c64xx-clock.txt

