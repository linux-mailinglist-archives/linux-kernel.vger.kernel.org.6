Return-Path: <linux-kernel+bounces-386469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF8B9B43DF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 911271C21C6A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744B82038B8;
	Tue, 29 Oct 2024 08:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ulqMXKXI"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA40203702
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 08:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730189411; cv=none; b=b7ynEB3/1AMdx11EmqOgdTqMtZYsXBk2DtXAb9ggWuVPHJyRwY9pv0hyyUv7MLbzzTGQi1nFC8eeC8lVN0vRh7ibCvoQa++guWETS9wNdL13EWfOu29D6+jWSqH38oXOKBpVCVrVigN1jHqExX9evjcAC2x3ytaWb8ztcBZFX4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730189411; c=relaxed/simple;
	bh=agzxdNOX8k5I7piiXQkfvAWfonSW+LxIr7o6V6Ai71Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LIS7C8nzvgSlqxG54LMg0olcivBCKp0F9pLrYCYvUEySBvCORMMpEMwTURFaa59GlC+s7xT26JNvTMWg74BwEbmFSQoJMOArQdKuc196z3UFb7K3FwTbADyCjTKG9iBVcqUNHwOfJnn+fZbEj5Jd4dhH/SvcFcpYR6NNISN6vpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ulqMXKXI; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4315ce4d250so6349835e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 01:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730189408; x=1730794208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdLVHEgAnDeeZJpgt9lNzYa9R3kdXRO8iLaUE20D1e4=;
        b=ulqMXKXIUodUM+2C948Xcl6hmy3/HOAeR4kunPb5GVlKkweccS+mSakx5WMFjdgTc6
         tfSDmoTEp5AJJ7kANfR79Pikcnq8jWeIq699nbiVWJ7LKhuudZq+skcnh10jYfbg4Rfz
         lYJWGYY3V48E8pZUGo92qULuf5gD6x2DmXdbIlOEV5tBylk7lWFMcpvKYLfxZcrfwtXs
         l43N1YNCVDfR8qmUMkbRBcasg7xx5JyJmcW6EMePr+VON5ClbmpKGuvze+Jqq5W/ihRe
         Ab+q/qD8psl2zDvf89nH5jVKZxqc1nePPK6+cOAbdI3Dx22UhbJ2D6XtSKJUq7SwhVwZ
         UwmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730189408; x=1730794208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TdLVHEgAnDeeZJpgt9lNzYa9R3kdXRO8iLaUE20D1e4=;
        b=IZBVIp3lIMmw9fi5Qn8ldnYFhxmCaRbwAVwGYl8t2RsQdQlS9l9vB6O84tdjcwx4YF
         jL40NSX4RXnu6ahNvZbqnFY5gGmVwBE1OXC250MB+j726L94zAQ3AWz/QcwTgMKdibC/
         4ZjtNE/5TBVC46mliU2QkF3ElE7u22bK7u0aLt4R8tWZQU4Xhy8iy+Z78IW7bQjaXXdv
         WxaP/EunDAYTQYlodBlr1QFcgspnDBkR+dlGjqbrzlVHJmUG+LB9KKbv8YTVwXfEwEVV
         sMYdZihFhIu8hHmw0aglbrehNK2kgs1l5KoFRgwTcGMRBdfhmMk/pCaLK56XHh6GLxbO
         HjnA==
X-Forwarded-Encrypted: i=1; AJvYcCXnNMNT8iB9OQJS0PCuJpLxoiFK2FSXi1ryoa/20yFxBLROTFnqkBVr1jbO2hvHXFBVs/LcpiGyinqKnMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfhtBdgBIauOHUqayPRvX/ypvROjoXbqJRLBITuc9GVOE7Wlaq
	8iIJzhbCe75h/iLRg7yJBit6l4vfmASWYa9okmqpHvweRjwN+vRMlyoX7B6Klls=
X-Google-Smtp-Source: AGHT+IFPu2wMrS/euT8irH3OgZ7YJEZf2yrxBrSR6HBa5Xa5vaMAfjGfZ6Uj/qbvaqrEJ8cQwUIugg==
X-Received: by 2002:a05:600c:1c91:b0:42c:b9c8:2ba9 with SMTP id 5b1f17b1804b1-4319ad2b318mr37979105e9.6.1730189407813;
        Tue, 29 Oct 2024 01:10:07 -0700 (PDT)
Received: from krzk-bin.. ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b55f784sm165467485e9.19.2024.10.29.01.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 01:10:07 -0700 (PDT)
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
Subject: [GIT PULL 2/3] arm64: dts: samsung: DTS for v6.13
Date: Tue, 29 Oct 2024 09:10:00 +0100
Message-ID: <20241029081002.21106-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029081002.21106-1-krzysztof.kozlowski@linaro.org>
References: <20241029081002.21106-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-6.13

for you to fetch changes up to 0a4907eea61d1b7d602a817f6c1de31609c48367:

  dt-bindings: arm: samsung: Document Exynos9810 and starlte board binding (2024-10-27 20:58:44 +0100)

----------------------------------------------------------------
Samsung DTS ARM64 changes for v6.13

1. Add new SoC Samsung Exynos8895 and new board using it: Samsung
   Galaxy S8 (SM-G950F) mobile phone.  Only small support so far:
   CPUs (Samsung Mongoose M2), main clock controllers (FSYS, PERIC,
   TOP), pin controllers, SPI for cameras, timers.

2. Add new SoC Samsung Exynos990 and new board using it: Samsung
   Galaxy Note20 5G (c1s/SM-N981B) mobile phone.  Only minimal support
   so far: CPUs (Samsung Mongoose M5), pin controllers, timers.

3. Prepare for adding new SoC Samsung Exynos9810 - add bindings.  The
   SoC DTSI was not yet ready, but it is posted on the mailing lists so
   should come soon.

4. ExynosAutov920: Add several clock controllers.

----------------------------------------------------------------
Igor Belwon (4):
      dt-bindings: arm: cpus: Add Samsung Mongoose M5
      dt-bindings: arm: samsung: samsung-boards: Add bindings for Exynos 990 boards
      arm64: dts: exynos: Add initial support for the Exynos 990 SoC
      arm64: dts: exynos: Add initial support for Samsung Galaxy Note20 5G (c1s)

Ivaylo Ivanov (10):
      dt-bindings: arm: cpus: Add Samsung Mongoose M2
      dt-bindings: arm: samsung: Document dreamlte board binding
      dt-bindings: soc: samsung: exynos-pmu: Add exynos8895 compatible
      arm64: dts: exynos: Add initial support for exynos8895 SoC
      arm64: dts: exynos: Add initial support for Samsung Galaxy S8
      dt-bindings: clock: samsung: Add Exynos8895 SoC
      dt-bindings: timer: exynos4210-mct: Add samsung,exynos8895-mct compatible
      arm64: dts: exynos8895: Add clock management unit nodes
      arm64: dts: exynos8895: Add Multi Core Timer (MCT) node
      arm64: dts: exynos8895: Add spi_0/1 nodes

Krzysztof Kozlowski (2):
      Merge branch 'for-v6.13/clk-dt-bindings' into next/dt64
      Merge branch 'for-v6.13/clk-dt-bindings' into next/dt64

Markuss Broks (3):
      dt-bindings: arm: cpus: Add Samsung Mongoose M3
      dt-bindings: soc: samsung: exynos-pmu: Add exynos9810 compatible
      dt-bindings: arm: samsung: Document Exynos9810 and starlte board binding

Sunyeal Hong (2):
      dt-bindings: clock: exynosautov920: add peric1, misc and hsi0/1 clock definitions
      arm64: dts: exynosautov920: add peric1, misc and hsi0/1 clock DT nodes

 Documentation/devicetree/bindings/arm/cpus.yaml    |    3 +
 .../bindings/arm/samsung/samsung-boards.yaml       |   18 +
 .../bindings/clock/samsung,exynos8895-clock.yaml   |  239 +++
 .../bindings/soc/samsung/exynos-pmu.yaml           |    2 +
 .../bindings/timer/samsung,exynos4210-mct.yaml     |    2 +
 arch/arm64/boot/dts/exynos/Makefile                |    2 +
 arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dts |  126 ++
 arch/arm64/boot/dts/exynos/exynos8895-pinctrl.dtsi | 1094 ++++++++++
 arch/arm64/boot/dts/exynos/exynos8895.dtsi         |  386 ++++
 arch/arm64/boot/dts/exynos/exynos990-c1s.dts       |  115 +
 arch/arm64/boot/dts/exynos/exynos990-pinctrl.dtsi  | 2195 ++++++++++++++++++++
 arch/arm64/boot/dts/exynos/exynos990.dtsi          |  251 +++
 arch/arm64/boot/dts/exynos/exynosautov920.dtsi     |   50 +
 include/dt-bindings/clock/samsung,exynos8895.h     |  453 ++++
 include/dt-bindings/clock/samsung,exynosautov920.h |   47 +
 15 files changed, 4983 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynos8895-clock.yaml
 create mode 100644 arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dts
 create mode 100644 arch/arm64/boot/dts/exynos/exynos8895-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos8895.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos990-c1s.dts
 create mode 100644 arch/arm64/boot/dts/exynos/exynos990-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos990.dtsi
 create mode 100644 include/dt-bindings/clock/samsung,exynos8895.h

