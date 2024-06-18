Return-Path: <linux-kernel+bounces-218487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F0490C07B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 02:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03E901C21080
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A5117BD3;
	Tue, 18 Jun 2024 00:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pdJxhlTh"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1476EEAD
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 00:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718671066; cv=none; b=LU6s4kB/tNZpQjatHu13UqLHWJOaZhjKQ+y1U62VHPumVzom6RMuprhLuT2fDBHLuPifd7CBrKY3NHoTYGXmBfe/ke+PhrSwO36PtutNLAtuUzQ0MNoQT7b2J3/TRVY4fmgVD1bxfDmoZ/kkoGE/Qg0avurEs5Hfg1YZC3e9g1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718671066; c=relaxed/simple;
	bh=4jvhi48JvvP8rNBKeGvDsq6pfyedazl0s0KNnT0r+90=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FN4Sg0hYtxYABwRk+y7FAZGXQnLZTAwFPwfOtnngqDWGqUAcUQC1m2WKiuIBs0jJaDW79DNrMjshqGNzmN2hcPNw8k/oJopQ7MdcLybK71jD742kG9+JukUk/TWDMX4Kt+yHEdPAwSPDUsvgW6UuRFu20DaIJSEjZ8ntekK8KLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pdJxhlTh; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6f971cb3c9cso2763869a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 17:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718671064; x=1719275864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tJ9dFj/nuDozXVyK3hNWcLVDpuzjEVXmNkuXi4rgInU=;
        b=pdJxhlThiYZ86jBh5pUCSzWXpinIwAIMkJdgRNN6PUgx9Oj6HtEzybKywwMotekrWc
         ujRVzoH7qj10LYpjk7y2JaRkaJRp/qa1cslVUM2jBvHO+X6cw+irztST0VCEKkN/aGSb
         oYW+KueAmLHphni7Yt5D14QiquyF2H/x08VSoONf8rUo3RzAImYxHnkTTfZWXnrfTFgC
         Od72Is8JOSo9AIQFmPNLqwq1trgWuP3R9Zj5umxx38OhegDE1hDZ5VavuIoEOKzTh0FK
         lfCKEDfD9kf2N5ZOJaSZHwPH+JIc/9AedyIX/HDPfYrLIIQKdAP/DAMO3xfOz6SWIv0F
         Xbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718671064; x=1719275864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tJ9dFj/nuDozXVyK3hNWcLVDpuzjEVXmNkuXi4rgInU=;
        b=L7CPNLyKF1fM/WJEf/3M5aWXYYvNjrNgfECgawL8wEWQ6CpQr4x05OpuIOwHDVi555
         Sxi695oWBsRnd0ZIEJZidPp5CGb9XUfCAo8OGHMrFKVre1R88uvWDfugiJlutug/FnJm
         YDgnY2zTecjrLR/3IGtUNKmdRz9EpyEkBEQpI8cc4CVGCgDWYlryidEnvprIX1PABp9U
         mFXy/rNx/KWeDsC6uSHRULd5lWNTYc60f+Q2jxStYY1EZ8vql00RicBE84t38X7rfwar
         hfixwuEgecqVJc79BH3BgWDWD8w81zB/6eZcbHR1lKAgM9ISQqcEOzOWkTZARSfg9r/I
         hB+g==
X-Forwarded-Encrypted: i=1; AJvYcCX2Rnk2n9WZ62wGiyIhEEANg/XbvrvmyNYbsFv3OZhKVl/+Dj/m3Vq7DaKmZPMsFsv4kf4JtKOxTj+gtbBUiE2zGXWoEo1p5VlatEQW
X-Gm-Message-State: AOJu0Yzx93OzJIK3bplg/j6K6hFYv38O/V0p78BemVk9ZtK9Wo7fC4X8
	CJ1AS6bdgPrNvglSDvG7eaz/FRNQwYeb6LPu3wD+rL2SQxyoASRkjE2M+FINwNM=
X-Google-Smtp-Source: AGHT+IGmDkEHWFbVOSVHrdqw/KQ9HDkYmOLjdE78AYml6rLtXM9nPkxgB4EdXv3a7VRep/PomFnNIQ==
X-Received: by 2002:a05:6870:4728:b0:24f:d9de:3bed with SMTP id 586e51a60fabf-25842b793famr12435193fac.41.1718671063791;
        Mon, 17 Jun 2024 17:37:43 -0700 (PDT)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569934d02dsm2879063fac.48.2024.06.17.17.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 17:37:43 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-samsung-soc@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] hwrng: exynos: Add support for Exynos850
Date: Mon, 17 Jun 2024 19:37:36 -0500
Message-Id: <20240618003743.2975-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exynos850 has True Random Number Generator (TRNG) block which is very
similar to Exynos5250 for which the driver already exists
(exynos-trng.c). There are two differences though:
  1. Additional SSS PCLK clock has to be enabled to make TRNG registers
     accessible.
  2. All SSS registers (including TRNG area) are protected with
     TrustZone and can only be accessed from EL3 monitor. So the
     corresponding SMC calls have to be used instead to interact with
     TRNG block.

This patch series enables TRNG support on Exynos850 SoC. It was tested
on the E850-96 board running Debian rootfs like this:

    8<-------------------------------------------------------------->8
    # cat /sys/devices/virtual/misc/hw_random/rng_current
    exyswd_rng

    # dd if=/dev/hwrng bs=100000 count=1 > /dev/null
    ...
    122KB/s

    # apt install rng-tools5
    # rngtest -c 1000 < /dev/hwrng
    ...
    rngtest: starting FIPS tests...
    rngtest: bits received from input: 20000032
    rngtest: FIPS 140-2 successes: 1000
    rngtest: FIPS 140-2 failures: 0
    rngtest: FIPS 140-2(2001-10-10) Monobit: 0
    rngtest: FIPS 140-2(2001-10-10) Poker: 0
    rngtest: FIPS 140-2(2001-10-10) Runs: 0
    rngtest: FIPS 140-2(2001-10-10) Long run: 0
    rngtest: FIPS 140-2(2001-10-10) Continuous run: 0
    rngtest: input channel speed: (min=941.855; avg=965.515;
             max=968.236)Kibits/s
    rngtest: FIPS tests speed: (min=49.542; avg=52.886;
             max=53.577)Mibits/s
    rngtest: Program run time: 20590194 microseconds
    8<-------------------------------------------------------------->8

Sam Protsenko (7):
  dt-bindings: rng: Rename exynos5250-trng to exynos-trng
  dt-bindings: rng: Add Exynos850 support to exynos-trng
  hwrng: exynos: Improve coding style
  hwrng: exynos: Implement bus clock control
  hwrng: exynos: Add SMC based TRNG operation
  hwrng: exynos: Enable Exynos850 support
  arm64: dts: exynos850: Enable TRNG

 .../bindings/rng/samsung,exynos-trng.yaml     |  85 +++++++
 .../bindings/rng/samsung,exynos5250-trng.yaml |  44 ----
 MAINTAINERS                                   |   2 +-
 arch/arm64/boot/dts/exynos/exynos850.dtsi     |   8 +
 drivers/char/hw_random/exynos-trng.c          | 216 ++++++++++++++----
 5 files changed, 266 insertions(+), 89 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rng/samsung,exynos-trng.yaml
 delete mode 100644 Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.yaml

-- 
2.39.2


