Return-Path: <linux-kernel+bounces-325865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3A9975F3C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 04:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10B861F24083
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 02:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE79086126;
	Thu, 12 Sep 2024 02:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dm30xq9Q"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE09C5BAF0;
	Thu, 12 Sep 2024 02:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726109539; cv=none; b=F7o1joCdPgp5WJIDOpjs6vW+9ZurySzWtU9L2prWg89V3iv9aWLfXdVUTHtanMVH5dIM8iTBDwtwIyKFu5hVTtE8LSE7OmFz9v58LbE7bqtXaPPqTifqvtb7Q/scHlRIh07LTsm0qq+teucats0c1vbp8vGp6IYFwDjT1nWM7hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726109539; c=relaxed/simple;
	bh=ArWBrF/C2L6bQSvwqgqishKw794D0LhTAW90+YbhQS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t4YCUN6pLivHAvn3BFKfdaQXmQvuZqjFY9zvhGW5I1COUb/Z3FG1rFSH1uBF0re10npMj5yLhI4jEyzBurBOhICTDa2gX7E0VIFKp4Rck2F2htNQrHPovw7UwVOEUk5aTmY1XMtFXvqsMmtohyYHLLCGDCx1SWCku5NjLOCeQPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dm30xq9Q; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7d666fb3fb9so222551a12.0;
        Wed, 11 Sep 2024 19:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726109537; x=1726714337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GN8Y5jLtGngAPKb20laPRiEUlwzjLCXpSghC4FPie78=;
        b=Dm30xq9QYh1cvLBbxb3X8fqM1tCqxJkgKiIiPH0Liz8jJuzYNrFFKbVOQDoVgF92Y2
         jX6VpZvt5nosOBTh2FWRZPbd5SDdmddqRr4yp1O979eZtN0jJH+0tCCgQn+2Dp/FhQfv
         zjQOP1lTLc0ct8chHepquDXcIYHxfFZWa/C9T7kZYJLn8mDiZv9Yud3k2gndnuWuNaOQ
         QRX6l27BHhfUD3IJv49NzFP3pnLRT9iz4uBAdxc7cWM/G2Vg+T03SG5F0vKLpW/0mGdv
         P3IM9PM5fYiqbjW27sHOcMpZQkITYVF90y8ALUhhUUHmPneucF4sg+OlhCkgFpjj6Xc8
         dlOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726109537; x=1726714337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GN8Y5jLtGngAPKb20laPRiEUlwzjLCXpSghC4FPie78=;
        b=UoloGZRYNqYWRJBrtveVFz6ZVev7Ajd5BTW3Y5Yaknx1GlYqhIppu2cV/wv1NmSdUy
         lexefaGs+g5D6MNixT+CTRDw7wzBy7XnsU80WJ9X14SEpj/RnGeVB/HBsP3P5zjVlc44
         LJRhx6a7aQqbRvhY/UswQCiITOrTjPTxpzt9qTw1iKo/xIvXlcF0+/2PMNc82GHaIniU
         ET6nIaAhLW//Zrtqk0KpcSV5k22C/K5qk2LFs4i2zQME++WUHU4eagzWsznKxHsFSUND
         E9b2wIX5mNxAwX+ER27DfWk7/p8/zygaYE5/3Ccpylr2wvOzWTulJbWIF6Xy2Qm8AIhV
         ftsg==
X-Forwarded-Encrypted: i=1; AJvYcCWR2guwzFCJgRdK3X3wmKkfEekgiC1rYIiQzH9wwXZmr8+kG6DLGDUb/Vu7D2DiEtyj7Un9dvV/1pSRhBkx@vger.kernel.org, AJvYcCWrIvPoAJwKAahO2CM4ZleNswFzpfVWcZZbJ7b/V9bhCcgH//3OMtlhAs3aiZv0+FYODVF6EvdBg3EE@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5P+izBYvk1KGjKCLvcx51TYgoadBsjRtIRtOXU3WQkBPTYCw8
	d74jiB8hEqWwiSaGjIt/Xp/LXewKB11ZWulkrRmNWfW8NsWWtJVIUA20I+oTHJ4=
X-Google-Smtp-Source: AGHT+IFmfVrBqKtjEq474kWG0li+Uj14wPYbL5vT/8+W1a0u51o+IZpRgcjA2sklD/7gZZupssq1WA==
X-Received: by 2002:a05:6a21:1519:b0:1cf:3248:48a0 with SMTP id adf61e73a8af0-1cf756c3ee2mr1960305637.18.1726109536661;
        Wed, 11 Sep 2024 19:52:16 -0700 (PDT)
Received: from luna.turtle.lan ([2601:1c2:c184:dc00::315])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fbbf877sm569023a12.50.2024.09.11.19.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 19:52:16 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ondrej Jirman <megi@xff.cz>,
	Chris Morgan <macromorgan@hotmail.com>,
	Alex Zhao <zzc@rock-chips.com>,
	Dragan Simic <dsimic@manjaro.org>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Jing Luo <jing@jing.rocks>,
	Kever Yang <kever.yang@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Daniel=20Kukie=C5=82a?= <daniel@kukiela.pl>,
	Joshua Riek <jjriek@verizon.net>,
	Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH 0/5] Turing RK1 SoM DT updates
Date: Wed, 11 Sep 2024 19:50:29 -0700
Message-ID: <20240912025034.180233-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello list,

It's been a little under a year since support for the Turing RK1 RK3588-based
SoM board, was introduced upstream. Since then, the driver developers have had
great successes in further RK3588 enablement, achieving such enhancements as:
- Stable thermal ADC support
- USBDP PHY support
- Panthor: a driver for the Mali-G610 GPU found in RK3588

Accordingly I am pleased to present this DT patchset, which leverages those
driver advancements to enable the corresponding features in the Turing RK1:
- Automatic fan speed control (patch 3/5)
- USB support (patch 4/5)
- GPU support (patch 5/5)

It also includes a bugfix (patch 2/5) for a previously-discussed [1] PCIe boot
hang problem, for which it was decided [2] that a fix required first splitting
apart the pinctrl defs for the low-speed signals (patch 1/5).

These patches are ordered by importance. Please apply this series partially if
deemed necessary.

Thank you for your time,
Sam

[1]: https://lore.kernel.org/lkml/20231205202900.4617-1-CFSworks@gmail.com/
[2]: https://lore.kernel.org/lkml/6311244.MhkbZ0Pkbq@diego/

Sam Edwards (5):
  arm64: dts: rockchip: Split up RK3588's PCIe pinctrls
  arm64: dts: rockchip: Fix Turing RK1 PCIe3 hang
  arm64: dts: rockchip: Enable automatic fan control on Turing RK1
  arm64: dts: rockchip: Enable all 3 USBs on Turing RK1
  arm64: dts: rockchip: Enable GPU on Turing RK1

 .../dts/rockchip/rk3588-base-pinctrl.dtsi     | 271 ++++++++++++++----
 .../boot/dts/rockchip/rk3588-turing-rk1.dtsi  | 137 ++++++++-
 .../boot/dts/rockchip/rk3588s-rock-5a.dts     |   6 +-
 3 files changed, 363 insertions(+), 51 deletions(-)

-- 
2.44.2


