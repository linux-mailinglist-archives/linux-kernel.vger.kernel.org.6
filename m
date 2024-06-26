Return-Path: <linux-kernel+bounces-231453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 314849198F2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 546BE1C21852
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F404192B8C;
	Wed, 26 Jun 2024 20:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DW1Oi/nF"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2AF18EFE4;
	Wed, 26 Jun 2024 20:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719433459; cv=none; b=GghBP05CQ45VpsYqiC5YXcpxMIAxoE+RBYJGwe8YSR6vcDIUeFxpoJWXni8z8PLEHzrHT98s6TEvrVecHVfM5HvctTbGzjFNf6LQ6KYBh/jaHUA3YtTAo8vSRPAQ6itNfLwKFvJZ1GcRNsRbU3pSJR0FsSb0wEgrQ/ENAsCY1ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719433459; c=relaxed/simple;
	bh=VlhpXSfAVou5sh76Hv3DtQZtocT0c0PaKtd6sTC5CZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZXCdqMGhdhypER6u+W3FyGhCQbpAaZM7PK5CsiBf14zOcI2pxfoA7XkB1lYMMg5C7t6DSXlfGeT7Lx5FokOO/ryWfcDyJ/kFR+7NICF4QRu3PKzUo+avjD0Iq5FQz7l5QjikSkBgtEusAwl6x9zAxrXxiIfX6k0VoYv1wmZp7IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DW1Oi/nF; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-36532d177a0so4502800f8f.2;
        Wed, 26 Jun 2024 13:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719433456; x=1720038256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bsME3C7Vr7+mXe6LCLwvVlRdoJqCu5kuUY6joBwriJI=;
        b=DW1Oi/nF3WQs6iJK6DxjQN5TE4cOyF5/zmXNagcAcb57BNPvyqk22Nz2k66pc+Bnf9
         fsaTueQi5aUQudGoN7tGHw25G5SjI5H2DaPU1NCXdSWeumlV5hOQyqgTWauQkn6Qtlen
         +tfUdXEUKCsLvfcDErwFFM8LaWDt9kl5nqXLVhG2kCYd6WvOFuAhR/1ZQ7ubzu34zQ1W
         j/wM+HAMEp66tF9ECgRHWhQlYUH7UCJzk1TXas3TZpwO9csWtVxU/yH6KR5bHt/PBehh
         u0l5WZ4UNAEQhT5ORrWSaZs3ih6hyTIHCqou5E4gox5h7pKJdPEow0OMo987DA2c+9I/
         yNGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719433456; x=1720038256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bsME3C7Vr7+mXe6LCLwvVlRdoJqCu5kuUY6joBwriJI=;
        b=B/HNs/y5FF4ZFmpS6+f8dqzu65FJ5NNxgxZBdCLmfRkMWCdCbs1u7yNO/D3cHWQqVp
         x2Tx9G4nl1pX2ClgyNQPrSreAj7HoheZXALoNpmKklrC6lf7zCMJFZqltpQs8kGVPJBf
         YbmL8k36gtl//18Ogvws7eSJmkssY4dFTZkcDNx/RGUmLLcMyZjt3jy+CIbJUBl6OHiz
         ZWFI+71+8/xzM81+FfqNTplvq2gQRCWhGI0xA6CHr3UdDIaDkKhluXuOvQC885pALaOw
         sFWSTAHDQAOYpcvKEbx9v3B89CaYAmihTc5wiMMXbHxJjnNpsUPbRkWbAd/Q6WAQlnZc
         db2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXsi24THbt2e1tgHnB/tYlryEfIJ+KnluEUbnOnu1yjQB8bZ/O4TpqSD4vf+O/jABDMC3ra1oJSVuUQ/IvJeqlMh4qFjOWGUrX2MFAIhcc6XfMYdovyffbFFRoa8a+HLdMRuqVOmgvfIJljqv6ElC43CpMeoFKY3+c9zb21mtjNuZmYLQ==
X-Gm-Message-State: AOJu0YwIZP7aIwZC6nNeHPbFrstKcEJci3aVSUwHEkRlv1kwXb5UJ7Cj
	dRpv9Ej+AwxWLb30sxXmsmTNhAsYIwzJq2x1BXNJuynWAKnbf6KKn0chsQ==
X-Google-Smtp-Source: AGHT+IFuEDZNAkJbslUvjSwHyMCpevFNCq8h7B05L4Zk905GkK9klbDhtBZcPP7vaQBfe1NKER+rsA==
X-Received: by 2002:a5d:5f49:0:b0:366:f84b:a9eb with SMTP id ffacd0b85a97d-366f84bac02mr6284099f8f.32.1719433455917;
        Wed, 26 Jun 2024 13:24:15 -0700 (PDT)
Received: from localhost.localdomain ([105.235.128.80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a2f8268sm16630315f8f.79.2024.06.26.13.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 13:24:15 -0700 (PDT)
From: Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Golle <daniel@makrotopia.org>,
	jason-ch chen <Jason-ch.Chen@mediatek.com>,
	Sam Shih <sam.shih@mediatek.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>,
	Yassine Oudjana <yassine.oudjana@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 0/2] MediaTek MT6735 main clock and reset drivers
Date: Wed, 26 Jun 2024 21:24:03 +0100
Message-ID: <20240626202406.846961-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yassine Oudjana <y.oudjana@protonmail.com>

These patches are part of a larger effort to support the MT6735 SoC family in
mainline Linux. More patches (unsent or sent and pending review or revision) can
be found here[1].

This series adds support for the main clock and reset controllers on the
Mediatek MT6735 SoC:
- apmixedsys (global PLLs)
- topckgen (global divisors and muxes)
- infracfg (gates and resets for infrastructure blocks)
- pericfg (gates and resets for peripherals)

MT6735 has other more specialized clock/reset controllers, support for which is
not included in this series:
- mfgcfg (GPU)
- imgsys (camera)
- mmsys (display)
- vdecsys (video decoder)
- vencsys (video encoder)
- audsys (audio)

Changes since v3:
- Squash DT binding patches.
- Use mtk_clk_simple_probe/mtk_clk_simple_remove for topckgen.
- Add MODULE_DEVICE_TABLE in all drivers.
Changes since v2:
- Add "CLK_" prefix to infracfg and pericfg clock definitions to avoid possible
  clashes with reset bindings.
- Replace "_RST" suffix with "RST_" prefix to maintain consistency with clock
  bindings.
- Use macros to define clocks.
- Abandon mtk_clk_simple_probe/mtk_clk_simple_remove in favor of custom
  functions in apmixedsys and topckgen drivers for the time being. 
- Capitalize T in MediaTek in MODULE_DESCRIPTION.
Changes since v1:
- Rebase on some pending patches.
- Move common clock improvements to a separate series.
- Use mtk_clk_simple_probe/remove after making them support several clock types
  in said series.
- Combine all 4 drivers into one patch, and use one Kconfig symbol for all
  following a conversation seen on a different series[2].
- Correct APLL2 registers in apmixedsys driver (were offset backwards by 0x4).
- Make irtx clock name lower case to match the other clocks.

[1] https://gitlab.com/mt6735-mainline/linux/-/commits/mt6735-staging
[2] https://lore.kernel.org/linux-mediatek/CAGXv+5H4gF5GXzfk8mjkG4Kry8uCs1CQbKoViBuc9LC+XdHH=A@mail.gmail.com/

Yassine Oudjana (2):
  dt-bindings: clock: Add MediaTek MT6735 clock and reset bindings
  clk: mediatek: Add drivers for MediaTek MT6735 main clock and reset
    drivers

 .../arm/mediatek/mediatek,infracfg.yaml       |   8 +-
 .../arm/mediatek/mediatek,pericfg.yaml        |   1 +
 .../bindings/clock/mediatek,apmixedsys.yaml   |   4 +-
 .../bindings/clock/mediatek,topckgen.yaml     |   4 +-
 MAINTAINERS                                   |  16 +
 drivers/clk/mediatek/Kconfig                  |   9 +
 drivers/clk/mediatek/Makefile                 |   1 +
 drivers/clk/mediatek/clk-mt6735-apmixedsys.c  | 138 ++++++
 drivers/clk/mediatek/clk-mt6735-infracfg.c    |  79 ++++
 drivers/clk/mediatek/clk-mt6735-pericfg.c     |  92 ++++
 drivers/clk/mediatek/clk-mt6735-topckgen.c    | 394 ++++++++++++++++++
 .../clock/mediatek,mt6735-apmixedsys.h        |  16 +
 .../clock/mediatek,mt6735-infracfg.h          |  25 ++
 .../clock/mediatek,mt6735-pericfg.h           |  37 ++
 .../clock/mediatek,mt6735-topckgen.h          |  79 ++++
 .../reset/mediatek,mt6735-infracfg.h          |  31 ++
 .../reset/mediatek,mt6735-pericfg.h           |  31 ++
 17 files changed, 960 insertions(+), 5 deletions(-)
 create mode 100644 drivers/clk/mediatek/clk-mt6735-apmixedsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt6735-infracfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt6735-pericfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt6735-topckgen.c
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-apmixedsys.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-infracfg.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-pericfg.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-topckgen.h
 create mode 100644 include/dt-bindings/reset/mediatek,mt6735-infracfg.h
 create mode 100644 include/dt-bindings/reset/mediatek,mt6735-pericfg.h

-- 
2.45.1


