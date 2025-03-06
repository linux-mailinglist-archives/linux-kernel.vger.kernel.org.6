Return-Path: <linux-kernel+bounces-549823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A11A5579B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CAA916CF56
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EA127604A;
	Thu,  6 Mar 2025 20:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hq/FEjdg"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BD22135A3
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 20:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741293786; cv=none; b=h4yCVipDjc73C9X9BftVlRT4lnELBuPNOTrYS1AG4D8TKE07vEemciIJbVaREgdM5iR6jS603CvDQyittDV1RRMd5TxQjihFAyLcUYGvRWvPn8EXk5TsPG5GByWFQFp9BF8BFZc+s8h9Zw84UTJuQSH3dthTwDijQsRVx5JQbQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741293786; c=relaxed/simple;
	bh=3I8CBekQ5y/NxfRFNZcDsBWqJ6pOTtgFdlfo4wG1dyw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=A5t7leMkG+eKZaExpOxiu38gLNf46bi5RxRhIHxXM2AwVKZcebVidZMJ63ySwybgTaLXzp+qSYoOIUwff4R0BVK4xMYZ65N2YmJtgxTy3qsZNPV36XhjKHLzYiwSxzKwO4MZYalevYQQPT97Gk1rq1GbwS5oH7JVGWmL/gI49WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hq/FEjdg; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso7105185e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 12:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741293782; x=1741898582; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4GimjoaXXladrZg38HxX+WEY/YSmPMUaXL9bgDFdsYs=;
        b=Hq/FEjdgnCAWesbkOC4IhhELsB0SHZoHhzLo7uX056AxRKqgNeC0VGmJjIl7RpeAKo
         xgX24Sy5zh0CFhZaGuNjFPDGZu4M08IIg8eQqyYNQeA8Bib3dhgoJ0ZluEfrsGEA6XBW
         Chm8GzrXpN8XpaNHSmtJCLhXUMlNDdGKoYZxmRmBE5ocsyTxuO8zqwi/XMaJTL7J/2Xh
         /yHbemj8Z/7WWUh/ZVb/jrFhj4o6uQ1e/4uKABaBvuosVOoayuAhFmNmE2H1sLk94/tq
         kLGBtpHOp1MR4VNLNWajM905FM+ol2P5vD+i/IyhhAETfqPGlE/QUDemXAq3cwAhWLHq
         Fv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741293783; x=1741898583;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4GimjoaXXladrZg38HxX+WEY/YSmPMUaXL9bgDFdsYs=;
        b=VmfCYV842aDV0sH9wxKU30vUznap8tACgZiCWpuKiUfVdzTc3v8fe6jE7wLHEFFw6h
         kBlZIctJwPiLfX4puaePNtxawCzxbmJj8qfD/SFr5yYsxyIwPrnjYXndpXjH2EzQQ0Sh
         HOJL6zLGN6BxwwnpOIbUfDfk/pmAcvNh/Gt7llmoD8ureDVIUS4WUVFwCbStod7M3HKj
         +O0Tp0mbUNWCpjw4JoPsl74hbFpOzqLH8yoiwKapNr2hYRfbn4vvsQzGslBpM+izjQSj
         itjF060yu6otC62iZ++3iJTK73vR7qBBtWT6lqEe2HHCIAxZZrZeBKRxRTJQ7Wo1pC/p
         Qs+w==
X-Forwarded-Encrypted: i=1; AJvYcCUclVtAd8uKymNqWhzwNJN8ggd69RvTGiVyL+frIVZvHgXxdp89uD9wHUU+QXqaStxXc+Cxrg2crMsUS7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfu62etyO1IBYXUhKRe3DEMBAVAWxs7KxrfMeXxtvG6UTvivZO
	fN1SszhyWxGIIR3He/wZRzPUugb1T8Dqa5Cmx5dZZRJFBW9umK7+Vi8Ur+sdevg=
X-Gm-Gg: ASbGncs8/cVKHIlVD6Jc3Xxr0IftvQnQiGOVmAZNq5rWLgNKDoIlacdA8Ob9BA3GEyb
	7TuraRkBD+iizS1kAehy/uppu3A5epIw+Q3z1GPjNXx17hblzNZ1zVQgmUMoE0wU00Pr8WCHPaa
	4AzHzM6u6hAtoC0gSsuBtBEPGTVVdW6OMld6pijlTR7SgzvrvNZk3UagqozoWKcar81oy+4+Id9
	csO9jEihsXJleozGk/RYk6gq6RVyyVG06637bMfE+dGolMMuHOazgvL2RMIzGv4cznzJso+5hXb
	1G9sdUYtA2yXUbIpgrN34+TShdW9pUZSZwsHCTCpPRB03sZc9cu2y0w2LZPbh0ttcgGanJc1EPo
	=
X-Google-Smtp-Source: AGHT+IFFBM1ec0+y9QOjsWkRze+N/TMmKsFw2dds6E7/MII8+8XfXYdGTXLu56qK+wFv8awCozTznQ==
X-Received: by 2002:a05:600c:4450:b0:43b:d531:ca9a with SMTP id 5b1f17b1804b1-43c68702906mr6559645e9.31.1741293782422;
        Thu, 06 Mar 2025 12:43:02 -0800 (PST)
Received: from gpeter-l.roam.corp.google.com ([145.224.67.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd9470e2sm30081715e9.33.2025.03.06.12.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 12:43:01 -0800 (PST)
From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v3 0/4] samsung: pinctrl: Add support for
 eint_fltcon_offset and filter selection on gs101
Date: Thu, 06 Mar 2025 20:42:34 +0000
Message-Id: <20250306-pinctrl-fltcon-suspend-v3-0-f9ab4ff6a24e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALoIymcC/4XNTQqDMBCG4atI1k3Jn6R25T1KF0kcdUASSWxoE
 e/e6KZ0Ubp8P5hnVpIgIiRyrVYSIWPC4EvIU0XcaPwAFLvSRDBRMy4YndG7JU60nxYXPE2PNIP
 vqJBSGi61U50i5XiO0OPzgG/30iOmJcTX8Sfzff1LZk4ZBa0bxqwwl1q1E3oTwznEgexmFh9HM
 v7TEcUxGqBvrFVK2i9n27Y3yVaqygUBAAA=
X-Change-ID: 20250120-pinctrl-fltcon-suspend-2333a137c4d4
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 andre.draszik@linaro.org, tudor.ambarus@linaro.org, willmcvicker@google.com, 
 semen.protsenko@linaro.org, kernel-team@android.com, 
 jaewon02.kim@samsung.com, Peter Griffin <peter.griffin@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3165;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=3I8CBekQ5y/NxfRFNZcDsBWqJ6pOTtgFdlfo4wG1dyw=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBnygjO1FoQGjv5WeO6HKLDs5Z3pU7BeLco3mKZb
 JrQPhD83pGJAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCZ8oIzgAKCRDO6LjWAjRy
 uh6CD/0e3PFcWK5hQCDVm8D0hG5a9L0DcyFK5AY5V3V0os/VHVy2PDL9bwNHCbiYme2oPf3lFCg
 O3SG6AThUsy/5ubHJaGkVCguuXbGbTO6Hi1M1jeCRAOOzKvIdlDoUYTOKoIX9BLHeKC5rS/FUof
 WY2MG8jqRDAG6S0GP6RdP0Ga//cBzApEUskyLgdXr2K8woZSlleQ+B662bOYVm3II9KKQgVG82O
 VVg9rifHPa/l+cnI4lL98o12pWcTPWK9UD8krJrkDS3UTl+Eu4xWRywSmYFjYVdgEQF7lbDZvNd
 s6flonruKPVDDZAG4HLihYFFsNNFEhtyc52qhVeRmkFJxHkJo3HkSxU4roq7+OcPbFsPsLvXh/T
 lO6qnJwxhH20G9U0KxvgeFILR63k9kpMu9e+zZ9gBra2KkcSzu/3IOb6rrmV0qS+G/Wwh+eWPFC
 NBTMdz0XExh1O/4p2sAZWGz2VyaivgdjLD930JNziBmYMih4K1Ne1usDgT8tL/F2U0gXifuv1dy
 AWrH6RtSZShQ6Of3ulZoa1m1bvz4offCkKbz4PFEyv/91U2p+OoOhO5v2xTLPYmXhbZ3yrc0yr1
 6wZY26wW2kq6kgCCejZsiRw41CaXv2e53F77BEf887Vxga8RVIdHQRtyWgAACNgZNYz+W0vyAPb
 MefopIujLpsI7nA==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

Hi folks,

This series fixes support for correctly saving and restoring fltcon0
and fltcon1 registers on gs101 for non-alive banks where the fltcon
register offset is not at a fixed offset (unlike previous SoCs).
This is done by adding a eint_fltcon_offset and providing GS101
specific pin macros that take an additional parameter (similar to
how exynosautov920 handles it's eint_con_offset).

Additionally the SoC specific suspend and resume callbacks are
re-factored so that each SoC variant has it's own callback containing
the peculiarities for that SoC.

Finally support for filter selection on alive banks is added, this is
currently only enabled for gs101. The code path can be excercised using
`echo mem > /sys/power/state`

regards,

Peter

To: Krzysztof Kozlowski <krzk@kernel.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
To: Alim Akhtar <alim.akhtar@samsung.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: andre.draszik@linaro.org
Cc: tudor.ambarus@linaro.org
Cc: willmcvicker@google.com
Cc: semen.protsenko@linaro.org
Cc: kernel-team@android.com
Cc: jaewon02.kim@samsung.com

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
Changes in v3:

- Ensure EXYNOS_FLTCON_DIGITAL bit is cleared (Andre)
- Make it obvious that exynos_eint_set_filter() is conditional on bank type (Andre)
- Make it obvious exynos_set_wakeup() is conditional on bank type (Andre)
- Align style where the '+' is placed first (Andre)
- Remove unnecessary braces (Andre)
- Link to v2: https://lore.kernel.org/r/20250301-pinctrl-fltcon-suspend-v2-0-a7eef9bb443b@linaro.org

Changes in v2:
- Remove eint_flt_selectable bool as it can be deduced from EINT_TYPE_WKUP (Peter)
- Move filter config register comment to header file (Andre)
- Rename EXYNOS_FLTCON_DELAY to EXYNOS_FLTCON_ANALOG (Andre)
- Remove misleading old comment (Andre)
- Refactor exynos_eint_update_flt_reg() into a loop (Andre)
- Split refactor of suspend/resume callbacks & gs101 parts into separate patches (Andre)
- Link to v1: https://lore.kernel.org/r/20250120-pinctrl-fltcon-suspend-v1-0-e77900b2a854@linaro.org

---
Peter Griffin (4):
      pinctrl: samsung: add support for eint_fltcon_offset
      pinctrl: samsung: add dedicated SoC eint suspend/resume callbacks
      pinctrl: samsung: add gs101 specific eint suspend/resume callbacks
      pinctrl: samsung: Add filter selection support for alive bank on gs101

 drivers/pinctrl/samsung/pinctrl-exynos-arm64.c | 150 ++++++-------
 drivers/pinctrl/samsung/pinctrl-exynos.c       | 294 +++++++++++++++----------
 drivers/pinctrl/samsung/pinctrl-exynos.h       |  50 ++++-
 drivers/pinctrl/samsung/pinctrl-samsung.c      |  12 +-
 drivers/pinctrl/samsung/pinctrl-samsung.h      |  12 +-
 5 files changed, 318 insertions(+), 200 deletions(-)
---
base-commit: 0761652a3b3b607787aebc386d412b1d0ae8008c
change-id: 20250120-pinctrl-fltcon-suspend-2333a137c4d4

Best regards,
-- 
Peter Griffin <peter.griffin@linaro.org>


