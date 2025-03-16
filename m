Return-Path: <linux-kernel+bounces-563105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 436FEA6370A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 19:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A1E316D93C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 18:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A1F1E1E11;
	Sun, 16 Mar 2025 18:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRJqWWYL"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4E919D8B2;
	Sun, 16 Mar 2025 18:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742151407; cv=none; b=nXs5l8LUteC0TR3yUSYvGbkewBB3IRsB0vgZ9mDy0X7/5W6yKahfe4bl9DjDD0tOWgRn7tP9NbDjCfozzpozj2yzDMCs7VgsqcPEJWMkWym5J6zFNNu/sqNEL4l5kxEFZl4chY+pU1TwvcjEcmC+sz0Dofai0uqF+aNH+X9T6hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742151407; c=relaxed/simple;
	bh=8WFUVTiQW0AVi8fJj1eBXP/Pgith2cmt5T7KY2lRChg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=feHBbrS+5aLdBfWUCUXHcu1GBiOob30f9i3y2Q9JYP7SX1dwoTavLg52c+HyJ50+iRzMITDW5P4PA8M7GXWXhEYPPRGgBmjnxkZuPCwfOgltWjvEYnwef01WKfYZNaOpHNv5qc8znlmXrGd+ZhZBOMm0rNv3DyiNTbsbOjaZy3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRJqWWYL; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso13851335e9.2;
        Sun, 16 Mar 2025 11:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742151404; x=1742756204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eY5jcIBsf0b/NcKS1qmY9rRfEEXRP/Tca7u8ZAMu2m8=;
        b=DRJqWWYL/9JP+KeZ4RY3/ZHwxWm4W6BzNnkp25AcpnGyi9Wfs0nRuBGYfE9DmJxTIj
         8xbzJaUXo/O2f4POOdIg6W6tAu63ujQ4EYYAxcOq2cVAds4Tc09tsrqpHZQC/ED9+lNL
         EWS7M3K6/M7OhS4vck3hLjmJrRlebg0qX5bjydtfIZ4HWGez1Hv65oD64QQaHgdt8nfA
         huv40wKnhYXpYklRxKG73MMKDbkAaq3iHScylgfFhc6HNzLuIVFJCsHj+W3J5zU4J3f+
         Ok8mFXP1BgA6mkYirTbKLql/GBRugRpGE75G3Z/Tty+bOwpg7DPAYK3hAedLk0NCnOlZ
         9M+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742151404; x=1742756204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eY5jcIBsf0b/NcKS1qmY9rRfEEXRP/Tca7u8ZAMu2m8=;
        b=NFroCslb0QsK9Pfva7bqxDFFmMtwtBubVAjUF/JGU597+WkDVLC2b67Qh8dcwfbZL9
         bhALUdR627Ygr//7RIKNLagZX/dnDCa68dg+CParUlItlUbhBDBJMK0czJjzvm++6sGL
         lQIr3u6dv9IyXJv/Lm/H14IKETknURHtz/JT3cA9t+ZKAlsZZBdqlYZEv8yffOawUcTi
         2pR23QLDzltp1LIh28TrErVGv4vuyX9z9nLZf6CwRmAVn+Xa752XAll93W3I+8+cKkGB
         0gdZDzf5tFVUSCzW4aWzpGrX7S5q76DHSXV9cJXS6uihalE9ySir16u/0+WQTG+rsANh
         7/ig==
X-Forwarded-Encrypted: i=1; AJvYcCU/VZwglXj/j0wE37IWYoZx63QqRQp48U//o4Moa3xKmgD8NMORo6o83wmf7P6EoGDafLXy0jnR+ckbt87M@vger.kernel.org, AJvYcCUDMF2AQ1djeYosU9iCVD6erY7y0H/f/X8JVitdqDc5VCTFQAmV4p18xgYIUh6Tz0gLpJJXMkfnJpX8@vger.kernel.org
X-Gm-Message-State: AOJu0YxGxwm1ZLwK40unCxQ+zWJDTs/xPAkANoFeCkqossrPzt/Vwmv/
	JoHKcOFzpAYcLjOqV0HppFnfu2roR6Jmv9OUnrMHeHTCOZX5MgmJ
X-Gm-Gg: ASbGncvh5jxBrfiRuDDz0DLIdCPUIP8GycJU/NV9aOPkBujtJ57dNkoQzQQ2UWGBp6W
	vxLi6t8mWZC9iU2bhonvzKGeDMdmRphrNafMAUU4SrN74XYJB9xCyWntFHQErVNTwg+84CrTT4S
	/hTL8xp43xCnJZSzVhnaPQUu7jd84FazG3S/Newk6WaMQRtaTpbdpEZfF6GbMo7WJh2uFJyix2T
	1UrE1ACmMbVeRcwcHYL1SHM75MgqIUJ1NIRacbbDWpiqZuo28T55IU74FSYM8XPb75NibssAqw3
	ppN2Llw2tKZ8GtOdHHEBpKgMqWu16ZiOWa8LtBDOTD8UsKyij/wbK5gYiQktNodE/s6n
X-Google-Smtp-Source: AGHT+IFXrgw3XrN+TCApbWNShZJAs8R17s1faa0pLtE35kNdsan/Kt1j2yFVTODC5X/sjE+CaW5y1w==
X-Received: by 2002:a05:600c:a21b:b0:43c:fcbc:968c with SMTP id 5b1f17b1804b1-43d1ef4b09amr110453495e9.7.1742151403732;
        Sun, 16 Mar 2025 11:56:43 -0700 (PDT)
Received: from giga-mm.. ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffb6292sm84692335e9.1.2025.03.16.11.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 11:56:43 -0700 (PDT)
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: sophgo@lists.linux.dev,
	soc@lists.linux.dev
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jisheng Zhang <jszhang@kernel.org>,
	Haylen Chu <heylenay@outlook.com>,
	Chao Wei <chao.wei@sophgo.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 0/7] arm64 support for Milk-V Duo Module 01 EVB
Date: Sun, 16 Mar 2025 19:56:30 +0100
Message-ID: <20250316185640.3750873-1-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds very basic support for Milk-V Duo Module 01 EVB [1] in
arm64 mode. The SoC (SG2000) is dual-arch, RiscV and ARM64, the latter has
been chosen because the upstream toolchain can be utilized.

Sophgo SG2000 seems to be a continuation of the Cvitek CV18xx series, same
peripherals with an addition of ARM64 core. Therefore it would be
beneficial not to copy-paste the peripherals' device-tree, but rather split
the most suitable riscv DT into ARCH-specific and peripherals parts and
just include the latter on the arm64 side.

This series adds the device-tree for Milk-V Duo Module 01 EVB, which
in turn contains Milk-V Duo Module 01 (separate .dtsi) on it, which has
SG2000 SoC inside (separate .dtsi).

This series has been tested with Sophgo-provided U-Boot binary [2]: it
boots from SD card; pinctrl, serial, GPIO drivers are functional (same
as for RiscV-based CV18xx SoCs).

Partial SoC documentation is available [3].

This series lacks the support of:
- USB
- Audio
- Ethernet
- WiFi
- Bluetooth
- eMMC
- Video

Changelog:
v5:
- PSCI node in DT
v4:
- minimized patch 1/7 (cleanups dropped)
- cv18xx-cpu-intc.dtsi instead of cv18xx-cpu.dtsi+cv18xx-intc.dtsi in
patch 1/7
v3:
- &cpus node has been moved into cv18xx-cpu.dtsi, &plic and &clint nodes
were moved into cv18xx-intc.dtsi to reduce code duplication;
v2:
- dropped all patches related to the new reboot driver and corresponding DT
and bindings;
- grouped DT-related and config-related patches together;
- added patch moving sophgo.yaml from riscv into soc (to share it with
ARM); added SG2000 SoC and Milk-V Duo Module 01 EVB into it;
- other changes are documented in the corresponding patches;

[1] https://milkv.io/docs/duo/getting-started/duo-module-01
[2] https://github.com/milkv-duo/duo-buildroot-sdk-v2/releases/
[3] https://github.com/sophgo/sophgo-doc/releases/download/sg2000-trm-v1.01/sg2000_trm_en.pdf

Alexander Sverdlin (7):
  riscv: dts: sophgo: cv18xx: Move RiscV-specific part into SoCs' .dtsi
    files
  dt-bindings: soc: sophgo: Move SoCs/boards from riscv into soc, add
    SG2000
  arm64: dts: sophgo: Add initial SG2000 SoC device tree
  arm64: dts: sophgo: Add Duo Module 01
  arm64: dts: sophgo: Add Duo Module 01 Evaluation Board
  arm64: Add SOPHGO SOC family Kconfig support
  arm64: defconfig: Enable rudimentary Sophgo SG2000 support

 .../{riscv => soc/sophgo}/sophgo.yaml         |  7 +-
 arch/arm64/Kconfig.platforms                  |  6 ++
 arch/arm64/boot/dts/Makefile                  |  1 +
 arch/arm64/boot/dts/sophgo/Makefile           |  2 +
 .../sophgo/sg2000-milkv-duo-module-01-evb.dts | 31 +++++++
 .../sophgo/sg2000-milkv-duo-module-01.dtsi    | 85 +++++++++++++++++
 arch/arm64/boot/dts/sophgo/sg2000.dtsi        | 81 +++++++++++++++++
 arch/arm64/configs/defconfig                  |  4 +
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi       |  5 +
 arch/riscv/boot/dts/sophgo/cv1812h.dtsi       |  5 +
 arch/riscv/boot/dts/sophgo/cv181x.dtsi        |  2 +-
 .../boot/dts/sophgo/cv18xx-cpu-intc.dtsi      | 54 +++++++++++
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi        | 91 +++++--------------
 arch/riscv/boot/dts/sophgo/sg2002.dtsi        |  5 +
 14 files changed, 309 insertions(+), 70 deletions(-)
 rename Documentation/devicetree/bindings/{riscv => soc/sophgo}/sophgo.yaml (80%)
 create mode 100644 arch/arm64/boot/dts/sophgo/Makefile
 create mode 100644 arch/arm64/boot/dts/sophgo/sg2000-milkv-duo-module-01-evb.dts
 create mode 100644 arch/arm64/boot/dts/sophgo/sg2000-milkv-duo-module-01.dtsi
 create mode 100644 arch/arm64/boot/dts/sophgo/sg2000.dtsi
 create mode 100644 arch/riscv/boot/dts/sophgo/cv18xx-cpu-intc.dtsi

-- 
2.48.1


