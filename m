Return-Path: <linux-kernel+bounces-303628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5108961213
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13B651C22D81
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674DB1CDFCE;
	Tue, 27 Aug 2024 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aa5dKryM"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753C51C6F51
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 15:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772331; cv=none; b=fKA7Ex1A5Zw24zTBdO8mmQdW5oqeHO73M1A70RBvuqkDbEknJA9T9Q/gh4h52My3EqdrAKlOjMk6xeWMWXFgwg4CPmTVHoCLNVmR/YI9QeFNzWE0IxeDRomYpGzLyYWfRo3C37sAKwf4KeJh0HEEDjqGk9gHTjRWjpBeVpMyhg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772331; c=relaxed/simple;
	bh=g8PzivK/LOA7LwMV2nTLLVuvJxR4cEPe+e5NQo45z6w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=sExmJb9prchCBMI3Nll+OG7LWLqvYnSFwkkdbwkxL4pmiLp1bzYouFpuf/bsb3Bqs0q540Cpl+qwk7WRa+HAl0mMF426t15jQyHTPj89LFgAuJIXcoiMpxbo2m+9vN6OkA482aR0zTdfK+euCztcYr0dUhR+khrWnRfQzJgqUU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aa5dKryM; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5342109d726so3597064e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 08:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724772326; x=1725377126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nrb5Vc3qSwLA43ufwjhdVQVpmhMVD2NR4A5ewZ/IEPQ=;
        b=aa5dKryMYJsfYdjJniNlM03TLiezYqKR3qaouTy1CDUNjN/dwGjiRXkqKsAr4brOEP
         2yiGHWMBh9VXLGeXasSejxKBi3+dZlsOYqxsoiPNy1k9iDV39lc79BvVthH4UolLGHMB
         AdGLumz/vfKdXEku4fTFrK/B/DSb5gRyOORfsstUSTZAbAm0okuWi7f8SRPPxinMw0No
         PJvA9Yb25KEJDPPRNzmmh5j5TViewT3hHEwY2wjM9U1jtoVDSJKKHuMeap9pmxySnsfJ
         sPwOLYyn+fohYDqGniI+B2UbLuqKVCd1IGbM8+LtLzRJ9LbtoRaZaJRnyaKYo2Wr/V0c
         koYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724772326; x=1725377126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nrb5Vc3qSwLA43ufwjhdVQVpmhMVD2NR4A5ewZ/IEPQ=;
        b=CAj4X6DyknzLRjGpymIrPZ8/TQgRbGahI58gkffAa739HBUGwiRpnRnX5sBFcs4sFT
         NuJVsqgQ7cN7FyhhrpEP4Rgnr+xT5TjZtWzXGJ35XpRJ3SaEU/Oawy2SISxUxur8vHyv
         eBmyLtV6IB/3A+h11XcZFqsdGJFe5nWEWmNc0yIL3X2PkfN0txLdK80RBY3GD34rBMsN
         +XnnhtNjtBJcDVoPNwF7ILhR8rsdYhFuju1zldafhFvDe0KQjl6GyNwZa1giL9q4g7/n
         emtSiD8KB1tw1zyM4OLwPl0AMl/skNcgnqitmIoct8P0MlPXl0PnpVyjCxmtyRtyvceV
         66Rw==
X-Forwarded-Encrypted: i=1; AJvYcCXtgLeNP0SZo9dUf7Dhq5rGGCaQWPEP0YMDb3W5aGR31LVBMhPIAFe8kSX0rU8j1LCn2jpDn+sei3jUWbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNE9qypdohQH7T7By3MzT0htCWdygxqYxnmuT+l16teCfp7Hb7
	VIGtFWV8ybdjsz8F9cURwU/9I3eSr0D54TFahcQkMLbArOFej/dUK2DBUbuiSsjVpcyuf7MYniO
	MQar3xLXoE2EMyYlKvxyassMNx5Kd5fUaDJ+4KkDbR8i3MbzEkLY=
X-Google-Smtp-Source: AGHT+IH1xiFBwEH0y6vYTLzLWKM2ZFp4UQ78DvCJUlStFVOLhnp4iZFm3fkMY7odrrlxKwE6UBfkjJxYmnJ0rIj3h90=
X-Received: by 2002:a05:6512:3b06:b0:52b:faa1:7c74 with SMTP id
 2adb3069b0e04-5344dd6b5b6mr1295153e87.5.1724772325851; Tue, 27 Aug 2024
 08:25:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 27 Aug 2024 17:25:15 +0200
Message-ID: <CACRpkdbWs10eU-jSiN9H6UNkTNA7K8PS3gAfUxe+T6dktJsSyA@mail.gmail.com>
Subject: [GIT PULL] pin control fixes for v6.11
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

here are some pin control fixes that have been stacking
up in my tree. All driver fixes!

Details in the signed tag as usual.

Please pull it in!

Yours,
Linus Walleij


The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b=
:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v6.11-2

for you to fetch changes up to 128f71fe014fc91efa1407ce549f94a9a9f1072c:

  pinctrl: rockchip: correct RK3328 iomux width flag for GPIO2-B pins
(2024-08-24 16:39:51 +0200)

----------------------------------------------------------------
Pin control fixes for the v6.11 series:

- Fix the hwirq map and pin offsets in the Qualcomm X1E80100 driver.

- Fix the pin range handling in the AT91 driver so it works again.

- Fix a NULL-dereference risk in pinctrl single.

- Fix a serious biasing bug in the Mediatek driver.

- Fix the level trigged IRQ in the StarFive JH7110.

- Fix the iomux width in the Rockchip GPIO2-B pin handling.

----------------------------------------------------------------
Hal Feng (1):
      pinctrl: starfive: jh7110: Correct the level trigger
configuration of iev register

Huang-Huang Bao (1):
      pinctrl: rockchip: correct RK3328 iomux width flag for GPIO2-B pins

Konrad Dybcio (2):
      pinctrl: qcom: x1e80100: Update PDC hwirq map
      pinctrl: qcom: x1e80100: Fix special pin offsets

Ma Ke (1):
      pinctrl: single: fix potential NULL dereference in pcs_get_function()

N=C3=ADcolas F. R. A. Prado (1):
      pinctrl: mediatek: common-v2: Fix broken bias-disable for
PULL_PU_PD_RSEL_TYPE

Thomas Blocher (1):
      pinctrl: at91: make it work with current gpiolib

 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c   | 55 ++++++++++++------=
----
 drivers/pinctrl/pinctrl-at91.c                     |  5 +-
 drivers/pinctrl/pinctrl-rockchip.c                 |  2 +-
 drivers/pinctrl/pinctrl-single.c                   |  2 +
 drivers/pinctrl/qcom/pinctrl-x1e80100.c            | 35 +++++++-------
 drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c |  4 +-
 6 files changed, 57 insertions(+), 46 deletions(-)

