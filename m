Return-Path: <linux-kernel+bounces-168633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E208BBB11
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 14:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E1BF282A9D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 12:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAA820DC8;
	Sat,  4 May 2024 12:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LWMWuL2/"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46897200C3
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 12:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714824760; cv=none; b=aKVWzu4RwHgCUXG5NXqG9HP09CrqYnWCqJCLIW3V2b7yVakb656hag+cf+BnxTPHRqmnZ111l198EAkZGtWhMQo4Mk/y9IgWepPD8vtga9y66BBCY5pFfEjTVi6Gy4UkH/6YQ5xw2J02AFrPtFPt3wZzhNkAvYEf+w6NJdqIYvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714824760; c=relaxed/simple;
	bh=e1jEgB0fjAfZ3F7oHZau9fnKOKNyVck5nUtMXGTsSfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZDfi/d4ZTjV9TwdtpSzkQ+p6DF8H0zhVINXGbJ2KbFtrDonlQcijkwuc+1ZGVIq9S9MNNI6aHOQWrenNKrilAsu7y3rOlFD7Cfhd6gOw9ltCC5CIAxe1ShN3aDTP043PChj1fllWCU9p1PpR2qhmbOFYFjXvV8yV0+LFyxrJSyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LWMWuL2/; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e20f2db068so5377401fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 05:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714824757; x=1715429557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ICI5eXiJ0vUJcoCOr2N1c06yFJQ7Qp0yrnmnXTdidMc=;
        b=LWMWuL2/k0ZnMK6/swxx4YGzxmyVVdGL8ZW2fq1uDKM9LCgE+FTe6gan60cv10i5bQ
         Y0TCSWliEWSZbJ6gswPWea7J1ee8b+XykTC+XNKtZolow2Z/LxVaKOZUe8yCIF8YeebF
         LeVuzgKE220T3GImseP9mMMNJhuAR5DjdJ1cnVwkzCFqcxDGKmIibWQEOQQOtH44E9x/
         SeMpfdv6Nu+3rz6xAXQA2t1i4PGuEIkXDPg/QLmZK7QRfNqJ3ZX1NGyS+22FVasuieX6
         HDEeGo3tWUbu37Lc2HmuW+m20Buv6lQEoKGRHZTgyZpoYYdhLZ2DQfr6Yab066o6ehh9
         Klgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714824757; x=1715429557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ICI5eXiJ0vUJcoCOr2N1c06yFJQ7Qp0yrnmnXTdidMc=;
        b=L52ZzHKwtrwQqVtcNccWY3uK2TOheDuWtAHklcO8P1TpfapXUgAaI+KHXJOwjjD/TK
         MZc3XNMMaH3tBu9w3/XkYBmG51nR0ADNhOGF41LoDlveN+OM6AuU9L8eEgqun862Z/of
         1/CLF64w5yKR4kOHZAopz58D6nxX0VqCaB7Ka2cRPaK+bF9UDl9lSzcpNoo5XXWLSCHk
         tN58bBFz/VrVkMjsAgHCLu9lz8mCTU2KBVaTpmesdw/jKIj7X2rD0UEUZ40Bho2p1wrZ
         Zw6bvYukNvNhM5YZe1Ie8N3Kvyug55xAcGwXaDmpsDaabSrexs2WRD1brmbC6qHnJTzb
         2a7w==
X-Forwarded-Encrypted: i=1; AJvYcCXJpL9NF9IQo9qcibZWnAQS/LRpXJshUKUvsiMlV5r+P25EkuLIidVpr6XfKuCFSEIV7cL4IBwyt2BaRbxhDHIC10n8dA6XRO97AATm
X-Gm-Message-State: AOJu0YxHRtUUDaD+F0v9MAWDDSP20++/Gc4Pfmmcj5TC60O1TY+4bjnm
	TcauvCEKIB+v7rXmDuCT+j4B5tITt6ueRf0numXWD0u2Ou0lJ1HMu8SgXoDULpQ=
X-Google-Smtp-Source: AGHT+IFj+qJ3fbIHVe57Z8zbN5Rs15TtFjm6vsXzOPnENrewemL6r+rTHyYA8LfnEUOPnluH4G2KLw==
X-Received: by 2002:a2e:94d6:0:b0:2e0:37be:b70f with SMTP id r22-20020a2e94d6000000b002e037beb70fmr3228987ljh.26.1714824757350;
        Sat, 04 May 2024 05:12:37 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id hn26-20020a05600ca39a00b0041a68d4fe76sm10802937wmb.0.2024.05.04.05.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 05:12:36 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Olof Johansson <olof@lixom.net>,
	Arnd Bergmann <arnd@arndb.de>,
	arm@kernel.org,
	soc@kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] arm64: dts: samsung: dts for v6.10, part two
Date: Sat,  4 May 2024 14:12:32 +0200
Message-ID: <20240504121233.7589-1-krzysztof.kozlowski@linaro.org>
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

On top of previous DTS64 pull request.

Best regards,
Krzysztof


The following changes since commit a45c3a9b1ef9571741d40bf10f22ce3c60bc5111:

  arm64: dts: exynos: gs101: define all PERIC USI nodes (2024-03-28 10:51:16 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-6.10-2

for you to fetch changes up to 4db286b0a29aa3576a401b637ac5910dac22117f:

  arm64: dts: exynos: gs101: specify empty clocks for remaining pinctrl (2024-05-03 10:36:56 +0200)

----------------------------------------------------------------
Samsung DTS ARM64 changes for v6.10, part two

Few changes exclusively for Google GS101:
1. Add HSI0 and HSI2 clock controllers (CMUs).
2. Add USB 3.1 Dual Role Device (DRD) support.
3. Add UFS (Universal Flash Storage) support.
4. Document bus clocks in pin controllers necessary for accessing
   registers.

----------------------------------------------------------------
André Draszik (8):
      dt-bindings: clock: google,gs101-clock: add HSI0 clock management unit
      arm64: dts: exynos: gs101: enable cmu-hsi0 clock controller
      arm64: dts: exynos: gs101: add USB & USB-phy nodes
      arm64: dts: exynos: gs101-oriole: enable USB on this board
      arm64: dts: exynos: gs101: specify bus clock for pinctrl (far) alive
      arm64: dts: exynos: gs101: specify bus clock for pinctrl_peric[01]
      arm64: dts: exynos: gs101: specify bus clock for pinctrl_hsi2
      arm64: dts: exynos: gs101: specify empty clocks for remaining pinctrl

Krzysztof Kozlowski (1):
      Merge branch 'for-v6.10/clk-gs101-bindings' into next/dt64

Peter Griffin (6):
      dt-bindings: clock: google,gs101-clock: add HSI2 clock management unit
      arm64: dts: exynos: gs101: enable cmu-hsi2 clock controller
      dt-bindings: soc: google: exynos-sysreg: add dedicated hsi2 sysreg compatible
      arm64: dts: exynos: gs101: Add the hsi2 sysreg node
      arm64: dts: exynos: gs101: Add ufs and ufs-phy dt nodes
      arm64: dts: exynos: gs101: enable ufs, phy on oriole & define ufs regulator

 .../bindings/clock/google,gs101-clock.yaml         |  55 ++++++++-
 .../soc/samsung/samsung,exynos-sysreg.yaml         |   2 +
 arch/arm64/boot/dts/exynos/google/gs101-oriole.dts |  42 +++++++
 arch/arm64/boot/dts/exynos/google/gs101.dtsi       | 128 +++++++++++++++++++++
 include/dt-bindings/clock/google,gs101.h           | 116 +++++++++++++++++++
 5 files changed, 341 insertions(+), 2 deletions(-)

