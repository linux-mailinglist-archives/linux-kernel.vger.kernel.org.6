Return-Path: <linux-kernel+bounces-303266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2F99609EE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF2751F23F7E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034231A2556;
	Tue, 27 Aug 2024 12:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ivuIv5/2"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5251A01BC
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 12:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761217; cv=none; b=R3Y0KqcOjD3jLRy4eeFY091ZOMdyt+80wQwK5cy5Q0RzDNk8ot9xz7Jh+B2bG8mosYHYHNF/Gk+D/+gs45QqeHA3iiLJTIEOwI7fvMSvnxaTw4bbeNb5dRcmGyhc79kF1TSiVcJgszQJ9oolf/xoJNhUVbaXEQ19vKZTT3VHNis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761217; c=relaxed/simple;
	bh=hPKFaWEwOaTEBTuH3e8c+46iBkaH7ro4nsEsef3YavQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mC1tkZqneiKNt3tI/jbSAvIvO28kUF9kEu86lZs5JORJHPiukVEHjqgV7K9BNCbyOz5pDW0LwNJYYzpAvRWgRfruzkHQelUxjzxBGWClcWynCZ1UW+AjIDArKhm24mL4NtCUiiJ39S4itPYU4kh8lDuRQyyp6i+KFU8oy7+vVEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ivuIv5/2; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42b964d7526so2401465e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 05:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724761214; x=1725366014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HIsTjVY/9B3Lg0x8GUp3KD2J/JTusOKcRSUTrZvqKe0=;
        b=ivuIv5/29ImbmVoktkjhaOeZ3HwB1H0BoEiyT8mNLmxNOIs28XCtqIKGbFwmiM6Thh
         ybfGeL+aekuATrp8o4TRyr7mvd3CV/54m9kFfOQVl2Rp9sNvUEMjr4JGRurN+Ih3V5s1
         QY62JdMnfx/ESHlYQp6J+EEg/Ovzu4YMbidYBMkcCPF0M2qtyuQdm46tAqkrSyFWipqE
         0EOHJg6m6atC73TREdqyPDGfhVMI6Hoy5yJ2ImHCmAou3cTbW0CaRIWx5LyEt40GPo9H
         IboNlV9GchqzPiIghqWu8wbDHDjUGePCYuq3NtRwpgL/cDKO1klmaAmhDGTewZ6kpRkL
         lcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724761214; x=1725366014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HIsTjVY/9B3Lg0x8GUp3KD2J/JTusOKcRSUTrZvqKe0=;
        b=WwbpexnPJoBD1P/mf6l9NRViBSPDNQ5LZm3xo5Pquv7+wJf5yUYc0McJfLh/C25uf4
         X31ckwPmQhH1lnyluroh1Y+CO2+6+BBpYTv+LRPoeIScYSlMHhMXUosBSVAkDTfRR7f9
         St6WlzF/ENYF/uDwsbmT5eGXDCKWFJYHWKFmlWZyE2vNR9fvXYI8m+4OPgtvUh2XYck7
         6nw47Z+r3xFGZSUn8M7aRAUhOv9DpjZUjxwBh14ALVehOZyMtfdS2tqURP53lExuPKJ2
         jRcjxFKj3SbBKIzyfkoAdgpqAJ7BH0Ooq98UXRPRPid7wt82JEPhw3YY1cD/4wrdk6cS
         Kn1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVfbroK01qh0g6fOT355/s8K2OpC6cRrbsh2SXxPMW9N/+XTEFxTfJUzGkCEGUXXl0oPK051cTJqIWVCxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd71Z8RzJUU4kGeMMuRmKZOJqGdVG8vJTK50YvQGdQyuuTMs5e
	rmJA8YzAij9yBLpHydC/2zI/pW1ADKUnrRH4qARTC8FhtFUCD14hbz8pIrFiqCw=
X-Google-Smtp-Source: AGHT+IG7i+eJRpMoQOnkdmCfoetSOU/Ebdq4Tdm/WCPxTSYkVwHF2O1bCXT1ZVNBiOJqcbCk+GKFmg==
X-Received: by 2002:a05:600c:4f92:b0:426:6cd1:d104 with SMTP id 5b1f17b1804b1-42acca0a4f2mr60118695e9.4.1724761213899;
        Tue, 27 Aug 2024 05:20:13 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abefc626fsm222544605e9.31.2024.08.27.05.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 05:20:13 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sylwester Nawrocki <snawrocki@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] pinctrl: samsung: drivers for v6.12
Date: Tue, 27 Aug 2024 14:20:10 +0200
Message-ID: <20240827122011.30158-1-krzysztof.kozlowski@linaro.org>
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

  https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung.git tags/samsung-pinctrl-6.12

for you to fetch changes up to 39dbbd4e6778ac5580313ba34409855250633c61:

  pinctrl: samsung: Use kmemdup_array instead of kmemdup for multiple allocation (2024-08-23 15:40:55 +0200)

----------------------------------------------------------------
Samsung pinctrl drivers changes for v6.12

1. Few cleanups: use more appropriate of_property_present(), use scoped
   OF nodes handling and switch to kmemdup_array().

2. Implement configuring pull-up and pull-down via GPIOLIB.

----------------------------------------------------------------
Peng Fan (1):
      pinctrl: samsung: Use scope based of_node_put() cleanups

Rob Herring (Arm) (1):
      pinctrl: samsung: Use of_property_present()

Shen Lichuan (1):
      pinctrl: samsung: Use kmemdup_array instead of kmemdup for multiple allocation

Vishnu Reddy (1):
      pinctrl: samsung: Add support for pull-up and pull-down

 drivers/pinctrl/samsung/pinctrl-exynos-arm.c |  14 ++++
 drivers/pinctrl/samsung/pinctrl-exynos.c     |  16 +---
 drivers/pinctrl/samsung/pinctrl-s3c64xx.c    |  14 ++++
 drivers/pinctrl/samsung/pinctrl-samsung.c    | 108 ++++++++++++++++++++++-----
 drivers/pinctrl/samsung/pinctrl-samsung.h    |  21 ++++++
 5 files changed, 141 insertions(+), 32 deletions(-)

