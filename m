Return-Path: <linux-kernel+bounces-555905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC37EA5BE1D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 069C97A6614
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC66923F37E;
	Tue, 11 Mar 2025 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G7Snc1bH"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1672356D3
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741689811; cv=none; b=jiXVT2rsiXQz+n7yF9qu7nxn/SWRCqupYwUHFuyV9a6YwVW+wQ4QHEHaXsnJjgEaCOFLveBgk+xW3UZWG0rnQsGuHqixOjNnwSy9DTG+TbCdiqOD9/IQcHue574N7ZMiuSn/aOXRlWAxZGAZPPbgnaynLjoFIoDkzYIrlzJbbzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741689811; c=relaxed/simple;
	bh=TF2pt+VlYvXsO/bDy6P04Ye6e61vp/s0aMmqW7gn1Oc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=KyayDKCNdx/ZCtR9o6JoKnrM30EWpv0IbcBrSYpfhUvCbwJRRjsq+dj/gCWTmlTJ8+MRp7cSxfkzlBPb/3QigaMNzf8v8QPxfrZ2DRZv0ZbsjdDHZtelFidhsEpEvqacDxJvNMM/1NtrDgk6t/Vhl8CpcT5gTiUfN3D8FhxVXyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G7Snc1bH; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5499bd3084aso2800182e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 03:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741689807; x=1742294607; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dBFMdhOL1E36IC9V9YqTpC1340SUGaSyuFxF0T9JfTQ=;
        b=G7Snc1bHsTOUNmiv7dNJCeUukp4+dxZJ2kNKNAKAj6W8T/EdiZnN0G8qRHJBjlKAsW
         VweCIJaS+860fbEkfRuGn1yw7rU4jUKvmXspBciQbeF6Ej6o2+TIs2/fvVIbFwJReZde
         i6f06PD5JuJmKiwR+5/T9jiVk+ggN3lYEbm3H9TtnxPp6X87h1x447NSG1+Jgq2Imzna
         S1P3Ls0sEgrOckhPgMh8C7RZcJG7LZqb1JYsjSz0k1/pN/WsKF3W9gIM51Lzdrh5lQIT
         1cw2oqMzvY2unlk1sCryl+wuITFvA5Te0JA4+bTrl/C72Eo3sIC2O2VBQ+e+i3dBA3p8
         rSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741689807; x=1742294607;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dBFMdhOL1E36IC9V9YqTpC1340SUGaSyuFxF0T9JfTQ=;
        b=CPK/P07Do3xc2/ULhqbFbepsNnlEQKcm+KpzIgywti980+08NtfkfyrDycUeu+BI+O
         GY5Rwjoxwg5ql/+zKcciDEyf7WSBCkn6jL5y6Kf9rxsVD4Bgi+J9yxePpQ0YFpE9sYom
         lzBZT1dNa0TVGgf/BIcCcyhPdirL0w/Pjawhir5y9BXeOnk987ItLUWhsZHd8s/Q09QG
         OULrV2NhkJrio5mXnpvOaHXyt8OR/900u9n0vdmvOo0nFyRQDODZAbxu5HxqAJ3VO7nX
         HREc1swb+8W22TFni0Xjk3EHLHDD+UvttEoQeRz2nyPFXQGV5Du01G0dummylBDRy/z8
         IHOg==
X-Gm-Message-State: AOJu0YwHjkyzRGj6LNrstR2VqdZx5e1MOKow00/vih3GN+w6dG0ZIdWf
	IzHBTNn1uW+NmwiYE9oLVVXNIzVsVefgJNr5nYCZTArjbDddhPWnia5IGpyAAvHt456g6LbwFF4
	Ifx3wM0+gC6gcYKcq+qMni14jCemEhVOHE/aQKw==
X-Gm-Gg: ASbGncsoIFfG/66/bdsj/hhFRm+9aqgdk8swPorHGdnMeuhKU9P1mBBO/sziapqkdKL
	VQsZ1XvqKZpOxH/jFsEoCNv+MRRr+Lv7mKKN4VTvThvSBoBpOB6lhixujV94MaDabYnZAJAprUD
	5g3boG7eB+8L5JnaoyC45aZwCgMA==
X-Google-Smtp-Source: AGHT+IGS4R1q+LV5vAuY4Bv9EtMuTTEYniQOjcVnb44o4oTeSd8Lkb4YxR/Qp2OF8HLFDaQ1BDJuRSqkimJ6DUZKF74=
X-Received: by 2002:ac2:4981:0:b0:549:91d7:4b51 with SMTP id
 2adb3069b0e04-54991d74bdfmr3668992e87.2.1741689807375; Tue, 11 Mar 2025
 03:43:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 11 Mar 2025 11:43:16 +0100
X-Gm-Features: AQ5f1JofDKmAv94-INk5bhpi9KjVa5U3EneTkYX1fDYQF4TcIsOLZq83AfAeqtI
Message-ID: <CACRpkdZmBznW3b132Wze8t2zC=-8YuEW+5aQD1qSSr3w2OFfZg@mail.gmail.com>
Subject: [GIT PULL] pin control fixes for v6.14
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, 
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

some three pin control fixes for the v6.14 series.

Details in the signed tag.

Please pull it in.

Yours,
Linus Walleij

The following changes since commit d082ecbc71e9e0bf49883ee4afd435a77a5101b6:

  Linux 6.14-rc4 (2025-02-23 12:32:57 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v6.14-3

for you to fetch changes up to 7ff4faba63571c51004280f7eb5d6362b15ec61f:

  pinctrl: spacemit: enable config option (2025-02-25 17:22:36 +0100)

----------------------------------------------------------------
Some further v6.14 fixes:

- Fix the regmap settings for bcm281xx, this was missing the
  stride.

- NULL check for the Nuvoton npcm8xx devm_kasprintf()

- Enable the Spacemit pin controller by default in the
  SoC config. The SoC will not boot without it so this one
  is prett much required.

----------------------------------------------------------------
Artur Weber (1):
      pinctrl: bcm281xx: Fix incorrect regmap max_registers value

Charles Han (1):
      pinctrl: nuvoton: npcm8xx: Add NULL check in npcm8xx_gpio_fw

Yixun Lan (1):
      pinctrl: spacemit: enable config option

 arch/riscv/Kconfig.socs                   | 1 +
 drivers/pinctrl/bcm/pinctrl-bcm281xx.c    | 2 +-
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c | 3 +++
 drivers/pinctrl/spacemit/Kconfig          | 3 ++-
 drivers/pinctrl/spacemit/pinctrl-k1.c     | 2 +-
 5 files changed, 8 insertions(+), 3 deletions(-)

