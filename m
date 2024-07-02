Return-Path: <linux-kernel+bounces-237343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A56591EF79
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 08:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02E232840FC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 06:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8166112FF71;
	Tue,  2 Jul 2024 06:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w9Xr78KA"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC07812E1C6
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 06:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719903252; cv=none; b=sXAaygOVrfQva3RdPUx4Kq0fCjDhTuYiOnzchLcflH80kv1myZt38SicKOTLKT8jWH0EiBzlH9+x3kKcRiUXGo340Hj9qgMsDI/0gNfChpkzgSzOp91ytIcpJhXkNiIN+wSehZx3G5rhM80h1ocf9LTXGpVtmXbUvnYkMpK58RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719903252; c=relaxed/simple;
	bh=y4y98dQjOJ9EL/JYaGCxbiPTb8w8mi740BjY9VCcMNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hxg8v69P8Zr3nj7s4rFGhPX3oRljIUl6RTXPIiuAPHuMbuqmyV356tK2VYaAvMfj6sWYaQ/J8SWTlhkjKzbyZ/CpKFDirUKRniOhIoA2DYT4edGeh2nwh9LCkpWYderOUudy5A+f9YVsoSCK3KgKlwl+rlOLDtbXUwf3ptGOKRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w9Xr78KA; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42565697036so28493635e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 23:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719903248; x=1720508048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWaI/qlLVf0rq2AzLp1L2BkFMQdEl1Lem1uDXasq8so=;
        b=w9Xr78KAH/onJM7bSB64o7PLsUO5wd1jiKVNg9ppP4xw17Ux2slpS+SNNYm2nHeKXn
         LAhmiaxTMBn1CLhqMHbWAQ4T5ow+eeiInraLqswTJ1m0lnfVp9guSXVt3pHULkA/jUcv
         SEst5u4IjEqYBVRkdwciXz0WijA4ZBMmQzMiw9zMRZvQ27JtIAk45s6ZfGoay0FcIVtv
         apwDhdQcG1dDqMF5jIHVeSbPVLOcB0Gap5oJTpl1srp26dclUjJZqy3wzKdxNAsUm2Bz
         yjECedk/t9GGvYTi4H5YJ+lpa9GtUAsieIJnBIpwY8Oy2rKsPYXpFIdriYEqphAJKs01
         7RfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719903248; x=1720508048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWaI/qlLVf0rq2AzLp1L2BkFMQdEl1Lem1uDXasq8so=;
        b=ofip6reGAH4klbOZaQIGVz9OPc3bYgA5HPAEXUvmuCCYPIhVsZ2McTjwHcjWz4VBWW
         cUAtUkRJbmdFIHxfHCUq+AHTyilBwlAnNWGPXbgpk6eN2bxT4bUqXZvxmwoxr1OI+vg5
         t56UCAmAvBm+ezPWpdHPvfvoQbcWJPbcC9fyXCrUDOKswdmkSvBWHcjWj4d2ySktw9UR
         JSGY1JQRn71T+LYrOffP7cGUWt+8Ccsz9dNxWKD+uCvCMUviIJB85q0iUbC5mrCPMra7
         p44e71radLXjBpAQKXQ8+i/a6wbpfjboZnVq+CX0705KkxDtJ0LidHjCtPKle1+kOAok
         RYrw==
X-Forwarded-Encrypted: i=1; AJvYcCXm7ErVXYhRKe9O/v611DisaEqrNdGlTlP5oWPVSSf18lWyncRoTxst7nI+N8RSnwEb15ea0SYu5Bfgf+lAPKIc2vzMbtNZe3DlT9Ff
X-Gm-Message-State: AOJu0YzVQZ2/KOZw0uFTbMOjwDrs7yubSH5353IlcVwkT7kPkzYFLbWo
	wx1Gm4DssnUB3j2XwyCKNfk/ffCX51ue3tkvJEz9M+W7rSw+Wq5LIlsS5fBzVdk=
X-Google-Smtp-Source: AGHT+IH57wRglnyqOE2lDq2ywjfF5VEUaurwyMspF8FM1R0agOZ3qIzCZ4gQRYgXHQV4iMeKULJWeg==
X-Received: by 2002:a05:600c:3595:b0:424:8743:86b4 with SMTP id 5b1f17b1804b1-4256d4d35a7mr90267845e9.6.1719903248197;
        Mon, 01 Jul 2024 23:54:08 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af55aeasm181446185e9.17.2024.07.01.23.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 23:54:07 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Olof Johansson <olof@lixom.net>,
	Arnd Bergmann <arnd@arndb.de>,
	arm@kernel.org,
	soc@kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] 2/2 ARM: dts: various cleanup for v6.11
Date: Tue,  2 Jul 2024 08:53:58 +0200
Message-ID: <20240702065359.7378-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240702065359.7378-1-krzysztof.kozlowski@linaro.org>
References: <20240702065359.7378-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Bug report for Aspeed-related user-space on using incorrect sysfs ABI is here:
https://github.com/openbmc/phosphor-state-manager/issues/27

Best regards,
Krzysztof


The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git tags/dt-cleanup-6.11

for you to fetch changes up to 90b6de4550aac6ac97448d3d26429a0a55dbaa34:

  ARM: dts: omap am5729-beagleboneai: drop unneeded ti,enable-id-detection (2024-06-26 18:57:21 +0200)

----------------------------------------------------------------
Minor improvements in ARM DTS for v6.11

Few cleanups and improvements which were missed by their maintainers:

1. Add Krzysztof as odd-fixer for old ARM platforms: Alphascale, AXM
   LSI, Moxa, TI Nspire and VT8500 (with Alexey Charkov).

2. VT8500: align node names with bindings (USB, panel timings).

3. Cirrus: align node names with bindings (panel timings).

4. TI Nspire: correct unit addresses, correct watchdog compatible and
   properties while making it disabled (never tested).

5. Nuvoton, Aspeed: align node names with bindings (I2C).

   IMPORTANT: At least for Aspeed it is known to affect some user-space
   tools, because that user-space looks for specific node path via
   /sys/firmware/devicetree. The /sys/firmware/devicetree is not the ABI
   and any user-space relying on it:
    - Prevents any changes in DTS, e.g. node renaming or moving,
      changing unit addresses (re-arranging child bus addressing).
    - Is using undocumented interface.
    - Is neither reliable nor understandable.

6. TI OMAP and Davinci: align node names with bindings (panel timings),
   drop incorrect property.

7. STI: document in bindings codec child to fix dtbs_checks.

----------------------------------------------------------------
Andrew Davis (2):
      ARM: dts: nspire: Add unit name addresses to memory nodes
      ARM: dts: nspire: Add full compatible for watchdog node

Krzysztof Kozlowski (10):
      ARM: dts: vt8500: align panel timings node name with dtschema
      ARM: dts: cirrus: align panel timings node name with dtschema
      MAINTAINERS: ARM: moxa: add Krzysztof Kozlowski as maintainer
      MAINTAINERS: ARM: axm: add Krzysztof Kozlowski as maintainer
      MAINTAINERS: ARM: vt8500: add Alexey and Krzysztof as maintainers
      MAINTAINERS: ARM: nspire: add Krzysztof Kozlowski as maintainer
      MAINTAINERS: ARM: alphascale: add Krzysztof Kozlowski as maintainer
      ARM: dts: ti: align panel timings node name with dtschema
      dt-bindings: soc: sti: st,sti-syscon: document codec node
      ARM: dts: omap am5729-beagleboneai: drop unneeded ti,enable-id-detection

Mohammad Shehar Yaar Tausif (1):
      ARM: dts: vt8500: replace "uhci" nodename with generic name "usb"

Rob Herring (Arm) (2):
      arm: dts: nuvoton: Use standard 'i2c' bus node name
      arm: dts: aspeed: Use standard 'i2c' bus node name

 .../devicetree/bindings/soc/sti/st,sti-syscon.yaml |  9 +++++
 MAINTAINERS                                        | 41 +++++++++++++++++++++-
 arch/arm/boot/dts/aspeed/aspeed-g4.dtsi            | 28 +++++++--------
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi            | 28 +++++++--------
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi            | 32 ++++++++---------
 arch/arm/boot/dts/cirrus/ep7211-edb7211.dts        |  2 +-
 arch/arm/boot/dts/nspire/nspire-classic.dtsi       |  2 +-
 arch/arm/boot/dts/nspire/nspire-cx.dts             |  2 +-
 arch/arm/boot/dts/nspire/nspire.dtsi               |  5 ++-
 arch/arm/boot/dts/nuvoton/nuvoton-npcm730-kudo.dts | 22 ++++++------
 .../dts/nuvoton/nuvoton-npcm750-runbmc-olympus.dts | 22 ++++++------
 arch/arm/boot/dts/ti/davinci/da850-evm.dts         |  2 +-
 arch/arm/boot/dts/ti/omap/am335x-guardian.dts      |  2 +-
 arch/arm/boot/dts/ti/omap/am335x-pdu001.dts        |  2 +-
 arch/arm/boot/dts/ti/omap/am335x-pepper.dts        |  2 +-
 arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts  |  1 -
 arch/arm/boot/dts/vt8500/vt8500-bv07.dts           |  2 +-
 arch/arm/boot/dts/vt8500/vt8500.dtsi               |  2 +-
 arch/arm/boot/dts/vt8500/wm8505-ref.dts            |  2 +-
 arch/arm/boot/dts/vt8500/wm8505.dtsi               |  2 +-
 arch/arm/boot/dts/vt8500/wm8650-mid.dts            |  2 +-
 arch/arm/boot/dts/vt8500/wm8650.dtsi               |  2 +-
 arch/arm/boot/dts/vt8500/wm8750.dtsi               |  4 +--
 arch/arm/boot/dts/vt8500/wm8850-w70v2.dts          |  2 +-
 arch/arm/boot/dts/vt8500/wm8850.dtsi               |  4 +--
 25 files changed, 137 insertions(+), 87 deletions(-)

