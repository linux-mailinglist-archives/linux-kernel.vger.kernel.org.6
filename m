Return-Path: <linux-kernel+bounces-227243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D95914DE0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A3DA1C22AEE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7459913D537;
	Mon, 24 Jun 2024 13:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C+Ml0eDa"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7067A13D619
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 13:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719234318; cv=none; b=W1BaLxNedgx8iYCuJYLIWrsO8WkqCuWk7koty9HWNAh8rbYfaaGuVr1vcO3lnIhiRSRxBXVXlJ40MGeplO6PxZEnYg82pFV4bqQZGfWvRv2Zmcw9nTxRdZMC8388XRMttMYdMvrcQZ/Bd2G9VxcDGH6yaCpP6Yyl5TfBdlnwXRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719234318; c=relaxed/simple;
	bh=is7TCxCshLLufRyQogRDzT33Qf+QekprGx1wND1gJvw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Kmr6v1xHIRrLTq4OhJKn/CJo9Z7dxMxehHH9hIvt7fDs+T/WQ6mnlc9M8+CWwezyruAUg9G4+z+SuHYY1jUujiYgQ3fRmRf5ot/w+xzboz3cZDUwQpbkG1/qpI/bgVJaI9OjEc/3vZ3+he0IcU85qqOfGjPaxmdkVHAf/mwprlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C+Ml0eDa; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ebec2f11b7so47151341fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 06:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719234312; x=1719839112; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ibe9dWNRlLxFg/ehewdQrXBLVeDGrTx5jXWvFDy8968=;
        b=C+Ml0eDaMBnsP8BZgabNoCLgamqfNLt5ESsyxaYA0rtgeb7nh/bG3mp0eS0LDyHPwH
         /WNuEcrUFb0VV2ejWwLgUZqhxCwXM1J7zwcFuQVTpTbI1KTIabfUHnCIQr+/W+3YV3wh
         jwwG3Zowcjc2CxXGHF3Q84AoBDUdnKPfpDUbHKKrmPGvDW/7thw6OUOvv5yup0otYiGx
         34fCDmLRKaKo3pTXPc1iLK/8ihjIwD3iOMMQzCMw4k04Vt8OayRtBzjeoHffIK+TrOiv
         zpCyCq6o8KHx87ik93l6gjmBgJQ4w3Bi8A3uVtgF5XK8db3U2K1Fc2+yrV6j6t9PRJjH
         Unmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719234312; x=1719839112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ibe9dWNRlLxFg/ehewdQrXBLVeDGrTx5jXWvFDy8968=;
        b=JZhIvwVWuIw4BrfESjbu1QpwaJoufNLkD2DURvbYsHsu+3QI9XdCy2t4OTfcJO0rlq
         fDNA7kE4OSM63pFcPj/FRqwMiwXPrloQxJEzr2Kh/5VylkrociUOp7z/9vwJTTtCi6Fu
         rUQqT7vQnAu5ArT2fQ0CuI6w9jNjwoV4oBvK5zgV8i/3LG27vmv+Kkte0kH9A1mSIbhz
         x1p0DlcxbvwtBufsg3mfXKnH9ekq4UiLHjCuDEqW52h3XNN2SXPoY9mPJAbBzT6Ya59x
         OV5FlMooPWrlHAT+s7PgV2JWJCTU11PoA3uMKPszs7gBp0j46vthUBEyqkltKTkeMsyk
         GVxg==
X-Gm-Message-State: AOJu0Yz4wzItN/o+fr7eWj9I2MESGaoAm/+32YVfcTp4uXdJuU3kjZ5J
	LSzMzfc9IlkUiyvaTGk/QpQmBD3Uxw8Io5gAVYdhCkP86uI96zTpo2X+fQ6+z0fex+5w9sniI3J
	6b02OOQC6/MzkKG58hc0zIX519y0SmIyMp/DaMk5HMsHYah0ORYA=
X-Google-Smtp-Source: AGHT+IGbXX62MuanBZyg06Ty61pAiJ5rSJpXKlv7RL2Y0oriTxD4MpUJGGGU/eDChNuXorpVr6HsC+YSRF/MPvrl6Mk=
X-Received: by 2002:a2e:80d5:0:b0:2ec:4fe0:38bc with SMTP id
 38308e7fff4ca-2ec5b388418mr24793131fa.35.1719234311609; Mon, 24 Jun 2024
 06:05:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 24 Jun 2024 15:05:00 +0200
Message-ID: <CACRpkdaa2OM1=Buz9pY2+HRAZHQnDoRqZDX2VWNoG_Fj=UbsUQ@mail.gmail.com>
Subject: [GIT PULL] pin control fixes for v6.10
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, 
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

here are some accumulated fixes for the v6.10 kernel cycle.
A bit late because midsummer.

A bit of brief details in the signed tag as usual.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v6.10-2

for you to fetch changes up to 4ea4d4808e342ddf89ba24b93ffa2057005aaced:

  pinctrl: rockchip: fix pinmux reset in rockchip_pmx_set (2024-06-17
10:36:56 +0200)

----------------------------------------------------------------
Pin control fixes for the v6.10 series:

- Use flag saving spinlocks in the Renesas rzg2l driver.
  This fixes up PREEMPT_RT problems.

- Remove broken Qualcomm PM8008 that clearly was never
  working. A new version will arrive in the next merge window.

- Add a quirk for LP8764 regmap that was missed and made the TI
  J7200 board unusable.

- Fix persistance on the BCM2835 GPIO outputs kernel parameter
  so this remains consisten across a booted kernel.

- Fix a potential deadlock in create_pinctrl()

- Fix some erroneous bitfields and pinmux reset in the Rockchip
  RK3328 driver.

----------------------------------------------------------------
Claudiu Beznea (1):
      pinctrl: renesas: rzg2l: Use spin_{lock,unlock}_irq{save,restore}

Hagar Hemdan (1):
      pinctrl: fix deadlock in create_pinctrl() when handling -EPROBE_DEFER

Huang-Huang Bao (4):
      pinctrl: rockchip: fix pinmux bits for RK3328 GPIO2-B pins
      pinctrl: rockchip: fix pinmux bits for RK3328 GPIO3-B pins
      pinctrl: rockchip: use dedicated pinctrl type for RK3328
      pinctrl: rockchip: fix pinmux reset in rockchip_pmx_set

Johan Hovold (2):
      pinctrl: qcom: spmi-gpio: drop broken pm8008 support
      dt-bindings: pinctrl: qcom,pmic-gpio: drop pm8008

Linus Walleij (1):
      Merge tag 'renesas-pinctrl-fixes-for-v6.10-tag1' of
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers
into fixes

Stefan Wahren (1):
      pinctrl: bcm2835: Fix permissions of persist_gpio_outputs

Thomas Richard (1):
      pinctrl: tps6594: add missing support for LP8764 PMIC

 .../bindings/pinctrl/qcom,pmic-gpio.yaml           |  3 -
 drivers/pinctrl/bcm/pinctrl-bcm2835.c              |  2 +-
 drivers/pinctrl/core.c                             |  2 +-
 drivers/pinctrl/pinctrl-rockchip.c                 | 68 +++++++++++++++++++---
 drivers/pinctrl/pinctrl-rockchip.h                 |  1 +
 drivers/pinctrl/pinctrl-tps6594.c                  |  1 +
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c           |  1 -
 drivers/pinctrl/renesas/pinctrl-rzg2l.c            |  4 +-
 8 files changed, 65 insertions(+), 17 deletions(-)

