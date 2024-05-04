Return-Path: <linux-kernel+bounces-168631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A22318BBB0B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 14:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 658A028285D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 12:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8426620DC4;
	Sat,  4 May 2024 12:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GOMg4RNE"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418BF1CA92
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 12:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714824392; cv=none; b=euBpmGoj8IfZ9OGtpL6156/KtYJSV2Cpbwy/XUGqBWTawdkeI+r0D0sgqWg3myFyGZtco6SnrjNYblWWVfdQBL3O1yEWnor68comRx9OuBY5GHihYYv/LoogoidbGFpnpL8eKDRf0fYpIHQFB75ajg3Eoc8O2hXBhhujS2sjaIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714824392; c=relaxed/simple;
	bh=E4NUlF5VQIe9oFr4HXVzgpyXS9FkO1vWaryQVaiCw78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bjrKhsjPL3A/fDunpdxeQjFOoQXDXJsHNtefxtOAPp2UDvba+qdoTq53M1VMiGtbaI4UPEJRBjJDuUw7kdBGbTyX68sJ3XqHM0mQKPkSQijPJfm53JV/f4zIKj1C4wWdUhNuA6el9vL5tMJKNzq7cxOYbs5/J+sNYZnwGvArlQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GOMg4RNE; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e28d8fb942so5261861fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 05:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714824388; x=1715429188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LmoUDmEK4doQTcwFVaJWsAEo654TgpusHYo23zS6+4A=;
        b=GOMg4RNECO7NIaDOAkeA/6t7xQ3eO7ZPlgxPp+q3EYDFwXryN25Xb0tnqFDaQ2sv8X
         GJQTCv4o/euBDSzeUIp0t1ZccqC9XFZRQ46zVSjkAC1YE+zWniseVqO6zk8NhdEpEe+7
         JfOI9L62R5vyMaCe7Vhg7fw7g53aaQSJ0KE7DUPtPmwuUyH5EdDSQiZfUY7YmsyoefrC
         v1rVqjVWfD7ASYAUHU7dO5Ud3zaVcWHhS0EsVjkiuJwY9+28xqA7XSHURxk7BYKD9h14
         GUDfUzlOwBjYtmyXOxzSM2nrFLkoxa3N6fYE60OTCrDppVH5gynEdpUzmmBbBN2pojNF
         GgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714824388; x=1715429188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LmoUDmEK4doQTcwFVaJWsAEo654TgpusHYo23zS6+4A=;
        b=VtY79TOl3Fx0QsYCar8CIFm5g5T0m+B28e6rIiuG3k6gSbhXQk+Qm3IB2U+XgV4mHq
         mCf1TDebNqey3d3HNj2HwvBfb0rFHCPc5j/bSTjJvIEhkGUW8JFFJQvCXHx7Y+mFaUQd
         xWb235ruNnW02GQvlz3an2g9EMdSC+qbLFiNsYWdlAbtrYfeosS3V2aIm04mUC+Tlf4T
         ZlBHeZex39Z8hvvNta4NoDeJs6S7Cy1Hif/U4bT9BfN0UHC+0HZBiTNYQI4cEMVO14ey
         3SYQWXKcg6s997e+rKH1Pkl5BUyRPR32vsZGA33VDVZi+IrdM3yB/bLo/rjJu87g2Rxb
         Kanw==
X-Forwarded-Encrypted: i=1; AJvYcCVYL+msBuNNzvwcpOdpeWJz0SUF5CT4fM8BWrFKEulNDnsPzkDNKiGSLgmEXjdTkuEyeOvsjmTp5mDkFUJRTQuBA8yiAgUco1ACNsyh
X-Gm-Message-State: AOJu0Yw9fSaNSk/Wuii43zr67TjJzQPKAfV/DrhTCxfP5RTjslVMW2Sy
	WDNekmO7rZodFNpbBDoo8TQCyfR5JLPXEL91ZpPFzAyxICgx4gJpDN8pzREAhev+Qp/t5t4o5BZ
	PEgM=
X-Google-Smtp-Source: AGHT+IH9atE4P8OuHxvPaHIfI65XvGoUqbPNzcEeOie682Vh5NLZSyRG6SsdCDxSBhHt7uZBnRTCaw==
X-Received: by 2002:a2e:a416:0:b0:2d4:7292:92c0 with SMTP id p22-20020a2ea416000000b002d4729292c0mr3003429ljn.20.1714824388259;
        Sat, 04 May 2024 05:06:28 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id bd13-20020a05600c1f0d00b0041c012ca327sm9048194wmb.45.2024.05.04.05.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 05:06:27 -0700 (PDT)
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
Subject: [GIT PULL] clk: samsung: drivers for v6.10
Date: Sat,  4 May 2024 14:06:22 +0200
Message-ID: <20240504120624.6574-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-clk-6.10

for you to fetch changes up to 6b32d7474e9b833dc7fadc1b4d4f08af9bd87fde:

  clk: samsung: gs101: mark some apm UASC and XIU clocks critical (2024-05-03 10:34:34 +0200)

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

Krzysztof Kozlowski (2):
      dt-bindings: clock: samsung,s3c6400-clock: convert to DT Schema
      Merge branch 'for-v6.10/clk-gs101-bindings' into next/clk

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
 drivers/clk/samsung/clk-exynos850.c                |  440 ++++++-
 drivers/clk/samsung/clk-exynosautov9.c             |    8 +-
 drivers/clk/samsung/clk-gs101.c                    | 1207 ++++++++++++++++++--
 drivers/clk/samsung/clk.h                          |   15 +-
 include/dt-bindings/clock/google,gs101.h           |  116 ++
 9 files changed, 1822 insertions(+), 208 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,s3c6400-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/samsung,s3c64xx-clock.txt

