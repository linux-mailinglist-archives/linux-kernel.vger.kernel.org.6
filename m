Return-Path: <linux-kernel+bounces-220154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 687A690DD9A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17418285AF4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B35178386;
	Tue, 18 Jun 2024 20:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rg9FeT+7"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DE815EFAF
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 20:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718743528; cv=none; b=jmeIOfGm9tLGroDJ2g9Z8QhMwxhvJEboHsa0jcfaidRONUS/JaJbIeF0xTWNa8VS7bKb/ve/q3d2wV8+LQ8C6tKoxW28mYjoup979FCG/ssVXrn6Rdsq/HZnbiQ1VwZc6mFbq9bjrVF1H8IBbO8bn091RSa69FwgCB0pioB2g9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718743528; c=relaxed/simple;
	bh=z1UyjqdAyG0LPVZ5wG40NVLSXp+qn3yQzxOTXQ/gFjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JILIpkNJrMiTA3tr8L2rDmZpYAYO/Ktkhf9oHcI+ns5VgMoyUsSlMFgTCnflsHUzvHFCBXakfdiG5h8b0CvuMcZz2iRoZyNXOC57jWCv2VC38+LseLg/7Hgi47IJmegvLFtTB/5zo9+PxThiC3G+uYA/Gv4Awe1FkmOyeXBIOVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rg9FeT+7; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5ba090b0336so2843155eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 13:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718743524; x=1719348324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JhcEpUixYW1NlD8vTPxrTj/5Uvw5ZqhDNkVhL4sqgko=;
        b=Rg9FeT+7RruPCgAHq/kcseEtTwCRg78pmXU9nPUAJh4ywffkhonr/P9vH3AAUlh8Qv
         E/+5aYnHmE5xOsXDQHGXQTn9O3JY47upIx8KoffVuVOoxIHwekD+gm2Cowvi2tjfdfnB
         rnkaxx/ngGJAfQxPDMFXPB4xucTMzJXr7K7xxQ97Ruwvre2G6QpUMtbAMIe+6UVuHGcM
         1KYF2SJi4Xl5VLMtu8Wxh7SbNabisyEB4TttxI3nmJ5wv2sMrikbmvgf/R1OvoNTgugh
         x1xI590/yyYO9USFG/zQ25x2Aad007vQgu9KSzGVLomfaPZy3a5TAlCIQdqELGdQdsJ5
         USkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718743524; x=1719348324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JhcEpUixYW1NlD8vTPxrTj/5Uvw5ZqhDNkVhL4sqgko=;
        b=P4eCuiRYzitqIa2NgB0JueDtl1KRQ0B8NOmIraF+rwLbd9+7qlNwHrBKh3XToRviFE
         1PwqJs5w8BcPomb5iIJ0qoYya1EaQYnYfbz2w/rD+8rb2G/SONc9YzHtKHhy0Bt0kXC3
         Oi3wiWdttE2jWLS9LDM6c2RN5NUtHT6rIZ0nYIkjjnk2eOgVUwDNHC0YFSXCqDg4dfwA
         SB4LWZVERg2MN64fIESWTEwYihdYQWxep/NHCnzeD4rN2w6DiB/YSTYaFcfhbFw4gaQv
         4J8cU+euvtTZxHJTLAjpITYDny765hX2GDoEa+HnRnAN7/gfhdJKxnPoeJD+qLTVKZDi
         Hn8A==
X-Forwarded-Encrypted: i=1; AJvYcCXKcIRBFejAcZgDq6qqUdurDrXlzTKxbMuIaoIHZ5ju8TrRiJRPLDI6z+AArwBHsQDcLZUuscmBMPK3sb7V6ue+9eu2FDRlf1wOgXSX
X-Gm-Message-State: AOJu0Yw+J9uto3esigYesMME2K/+gt9KwCu0+iheDm0y37hd3YpfRjxi
	5dVYWzm8yDL9bqlSD1ssc76vKsZnW+dJawWBGFauez3K+NftNFCzbF0h8Ho231H8//+DDyqmdJ/
	zLgM=
X-Google-Smtp-Source: AGHT+IF2pnET8e+kKpto1cAvMwXd1n2tX30Z+TpufXJVT8R7Pig00Ik8aCpU+HEcP1N7AhulSTEWpw==
X-Received: by 2002:a05:6870:7013:b0:254:a778:6fbd with SMTP id 586e51a60fabf-25c94901c85mr1114518fac.6.1718743524442;
        Tue, 18 Jun 2024 13:45:24 -0700 (PDT)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6fb5b1f57a1sm1971383a34.46.2024.06.18.13.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 13:45:24 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Anand Moon <linux.amoon@gmail.com>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-samsung-soc@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] hwrng: exynos: Add support for Exynos850
Date: Tue, 18 Jun 2024 15:45:16 -0500
Message-Id: <20240618204523.9563-1-semen.protsenko@linaro.org>
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
    12081400.rng

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

Changes in v2:
  - Removed the patch for renaming the dt-bindings doc file
  - Added the patch for using devm_clk_get_enabled() to get the clock
  - Addressed all review comments for v1 series

Sam Protsenko (7):
  dt-bindings: rng: Add Exynos850 support to exynos-trng
  hwrng: exynos: Improve coding style
  hwrng: exynos: Use devm_clk_get_enabled() to get the clock
  hwrng: exynos: Implement bus clock control
  hwrng: exynos: Add SMC based TRNG operation
  hwrng: exynos: Enable Exynos850 support
  arm64: dts: exynos850: Enable TRNG

 .../bindings/rng/samsung,exynos5250-trng.yaml |  40 +++-
 arch/arm64/boot/dts/exynos/exynos850.dtsi     |   8 +
 drivers/char/hw_random/exynos-trng.c          | 216 +++++++++++++-----
 3 files changed, 206 insertions(+), 58 deletions(-)

-- 
2.39.2


