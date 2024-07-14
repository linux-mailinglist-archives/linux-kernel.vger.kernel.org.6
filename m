Return-Path: <linux-kernel+bounces-251959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A886930C34
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 01:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFEF21C20AB9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 23:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3AA8F48;
	Sun, 14 Jul 2024 23:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EK7DQzx5"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC7328FA
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 23:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721001366; cv=none; b=T9qW7cHqipAn4/u/EyTMkcuFmFxsnvAVLTPXszs0T09dATP2Td8z7xhvgA+0RjuPCvOjfZ5SD9R16Y0A8/mMNX/9iPqXYNYuJpllowlfKnWF1gl1efQCg95aBE0qvejuiNbXOD1SGvJhTrudUvyMEZKds+wj1qs9L0PtGNSwjTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721001366; c=relaxed/simple;
	bh=ElBxmtdBto7oBgv7kUfIe7S/l59erU+DSUFlELa14E0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QU2r+4frsLkFPl26dic/jFowP3McwOkfbsC1NBn07bpFG5NCqw6cP7Dd0VYPGW3Im7Jmsr0UEeVk5Ps24DC7KiX6gUJx9eBgO66gbKpCp3bsw8s8PjWYZQth824lDApuxmV9cDH2hSH/mL7w5MxX165dJDSuailogVBK6MHVaS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EK7DQzx5; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52ea7bdde68so4003412e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 16:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721001360; x=1721606160; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WgLjksFUS/fpTTt4dDxH0mDzUxX++BLo+vL4+PdbEI4=;
        b=EK7DQzx5mq5geLpfok7g4LgjfFoyOYZZD/7RpcaSuzlZWd17YLO+g9H9UmeHHpzJ+Q
         7L5CIJ+z/n3hiK0bBPrdZuPCTeqNzsv70C025qJwlyrw//M15PoF1HDJ7aJimhZwNvrf
         3WxLaHhF7NVeOGS3mKeBfstAkz4TvYlB83M6C7d+21ag7L3XNzRjH1xhTWaphIwl092u
         05cYxb3lpt05ONtJ+kCqCcb7jdBKa6kFRW9K+QOAWu81UClHZK+LAt6nV//pzPr/wDNV
         EUq8H3M8an5UxhJycw42Q/eancigJC1AJHr3j3e781LMtjsGRStSRN++aqWP/gSr7u8t
         idrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721001360; x=1721606160;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WgLjksFUS/fpTTt4dDxH0mDzUxX++BLo+vL4+PdbEI4=;
        b=CwadtnGY5d3Ha6NsIVNtkLeBSaOuzjoZRA+Y7dxaUG5roK/Uqus5wGfgFlBgtTZHVC
         UoOD9hFMHtghvwq7fL0CgH/IraZywbTCChveR+yIssOtsLZCV3aKcHWOO/KiMsovaInA
         ZmjJU500cWgmIrwrsBGqSE3gdQXaw/9T1WsDv9kFvdgcU9cKabkXRVwrpCumTvfQHXfZ
         FHod3uIm84aubtP6Vj8zb3ZJKdA2oXdL275tbaxvwQNoAOxmzuNtUEArBQzOE0pTSXqv
         4auVTt7eNINp+QluvOXOtx5D5YJBOoIqlhxq3i0q6dUYWzrFx45b/ECou9IsFLHgi2S9
         h0RA==
X-Gm-Message-State: AOJu0YzR62JNG7AR4u0PtLkj/SkL4BOT6F503UsNQMkObB3MLsJ7cAbq
	p6XvcGxMboYkNEUqNQCEaGpc/d2BEsQjW3dfwSJZLsQiOMpJvO7yR9+O3apWfUw=
X-Google-Smtp-Source: AGHT+IHrM10H3xb9tX0zTngYHwN73jJ1hToYujAvBtl+XhOIQKAhbN9QB0lPSLipBcK2FFEilbfJ3w==
X-Received: by 2002:ac2:5f71:0:b0:52e:9b9f:9377 with SMTP id 2adb3069b0e04-52eb9995381mr8893593e87.21.1721001359681;
        Sun, 14 Jul 2024 16:55:59 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:b07d:2def:f39:af34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7f2356sm168508366b.128.2024.07.14.16.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 16:55:59 -0700 (PDT)
Date: Mon, 15 Jul 2024 01:55:57 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	William Breathitt Gray <wbg@kernel.org>, Lee Jones <lee@kernel.org>
Subject: [GIT PULL] pwm: Changes for 6.11-rc1
Message-ID: <lajhejp2frzxdzjj4zdw645uabt3y77rg6rmbk737cel4bytrp@wqr3zbdu6pg4>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wzyzmm7voeopd3vd"
Content-Disposition: inline


--wzyzmm7voeopd3vd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

the following changes since commit f01af3022d4a46362c5dda3d35dea939f3246d10:

  pwm: stm32: Fix error message to not describe the previous error path (20=
24-06-22 16:13:19 +0200)

that is part of v6.10-rc5 are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/p=
wm/for-6.11-rc1

for you to fetch changes up to 240b129d597cb8a8880eb3a381ff10eb98ca0c07:

  pwm: axi-pwmgen: add .max_register to regmap (2024-07-11 15:44:40 +0200)

Summary of the changes and shortlog below. Please pull these changes for
v6.11-rc1.

Best regards
Uwe

----------------------------------------------------------------
pwm: Changes for v6.11-rc1

This contains the usual mix of fixes, cleanups, two new drivers and
several dt binding updates. The fixes are for minor issues that are
already old (4.11-rc1 and 3.9-rc1) and were found by code review and not
during usage, so I didn't sent them for earlier inclusion.

The changes to include/linux/mfd/stm32-timers.h and
drivers/counter/stm32-timer-cnt.c are part of an immutable branch that
will also be included in the mfd and counter PR. It changes some
register definitions and affects the pwm-stm32 driver.

Thanks go to Andy Shevchenko, AngeloGioacchino Del Regno, Conor Dooley,
David Lechner, Dhruva Gole, Drew Fustini, Frank Li, Jeff Johnson, Junyi
Zhao, Kelvin Zhang, Krzysztof Kozlowski, Lee Jones, Linus Walleij, Linus
Walleij, Michael Hennerich, Nicola Di Lieto, Nicolas Ferre, Nuno Sa,
Paul Cercueil, Raag Jadav, Rob Herring, Sean Anderson, Sean Young,
Shenwei Wang, Stefan Wahren, Trevor Gamblin, Tzung-Bi Shih, Vincent
Whitchurch and William Breathitt Gray for their contributions to this
pull request; they authored changes, spend time reviewing changes and
coordinated the above mentioned immutable branch.

----------------------------------------------------------------

Conor Dooley (1):
      dt-bindings: pwm: describe the cells in #pwm-cells in pwm.yaml

Drew Fustini (2):
      dt-bindings: pwm: Add AXI PWM generator
      pwm: Add driver for AXI PWM generator

Frank Li (2):
      dt-bindings: pwm: fsl-ftm: Convert to yaml format
      dt-bindings: pwm: imx: remove interrupt property from required

Jeff Johnson (1):
      pwm: add missing MODULE_DESCRIPTION() macros

Junyi Zhao (1):
      pwm: meson: Add support for Amlogic S4 PWM

Nicola Di Lieto (1):
      dt-bindings: pwm: Add pwm-gpio

Nicolas Ferre (1):
      dt-bindings: pwm: at91: Add sama7d65 compatible string

Raag Jadav (2):
      pwm: lpss: use devm_pm_runtime_enable() helper
      pwm: lpss: drop redundant runtime PM handles

Sean Young (1):
      bus: ts-nbus: Use pwm_apply_might_sleep()

Shenwei Wang (1):
      pwm: imx-tpm: Enable pinctrl setting for sleep state

Trevor Gamblin (1):
      pwm: axi-pwmgen: add .max_register to regmap

Uwe Kleine-K=F6nig (24):
      mfd: stm32-timers: Unify alignment of register definition
      mfd: stm32-timers: Add some register definitions with a parameter
      counter: stm32-timer-cnt: Use TIM_DIER_CCxIE(x) instead of TIM_DIER_C=
CxIE(x)
      mfd: stm32-timers: Drop unused TIM_DIER_CC_IE
      pwm: stm32: Always do lazy disabling
      pwm: atmel-tcb: Fix race condition and convert to guards
      pwm: jz4740: Another few conversions to regmap_{set,clear}_bits()
      pwm: axi-pwmgen: Make use of regmap_clear_bits()
      pwm: Make use of a symbol namespace for the core
      pwm: cros-ec: Don't care about consumers in .get_state()
      pwm: cros-ec: Simplify device tree xlation
      pwm: Make pwm_request_from_chip() private to the core
      pwm: Remove wrong implementation details from pwm_ops's documentation
      pwm: Drop pwm_apply_state()
      Merge tag 'ib-mfd-counter-v5.11' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/lee/mfd into HEAD
      pwm-stm32: Make use of parametrised register definitions
      pwm: Register debugfs operations after the pwm class
      pwm: Use guards for pwm_lock instead of explicity mutex_lock + mutex_=
unlock
      pwm: Use guards for export->lock instead of explicity mutex_lock + mu=
tex_unlock
      pwm: Use guards for pwm_lookup_lock instead of explicity mutex_lock +=
 mutex_unlock
      pwm: xilinx: Simplify using devm_ functions
      pwm: Allow pwm state transitions from an invalid state
      pwm: atmel-tcb: Simplify checking the companion output
      pwm: atmel-tcb: Make private data variable naming consistent

Vincent Whitchurch (1):
      pwm: Add GPIO PWM driver

 .../devicetree/bindings/pwm/adi,axi-pwmgen.yaml    |  48 ++++
 .../devicetree/bindings/pwm/atmel,at91sam-pwm.yaml |   4 +-
 .../devicetree/bindings/pwm/fsl,vf610-ftm-pwm.yaml |  92 ++++++++
 Documentation/devicetree/bindings/pwm/imx-pwm.yaml |   1 -
 .../devicetree/bindings/pwm/pwm-fsl-ftm.txt        |  55 -----
 .../devicetree/bindings/pwm/pwm-gpio.yaml          |  46 ++++
 Documentation/devicetree/bindings/pwm/pwm.yaml     |   6 +-
 Documentation/driver-api/gpio/drivers-on-gpio.rst  |   7 +-
 MAINTAINERS                                        |   9 +
 drivers/bus/ts-nbus.c                              |   2 +-
 drivers/counter/stm32-timer-cnt.c                  |   4 +-
 drivers/pwm/Kconfig                                |  24 ++
 drivers/pwm/Makefile                               |   2 +
 drivers/pwm/core.c                                 | 187 ++++++++--------
 drivers/pwm/pwm-atmel-tcb.c                        | 113 +++++-----
 drivers/pwm/pwm-axi-pwmgen.c                       | 242 +++++++++++++++++=
++++
 drivers/pwm/pwm-cros-ec.c                          |  64 +-----
 drivers/pwm/pwm-gpio.c                             | 241 +++++++++++++++++=
+++
 drivers/pwm/pwm-imx-tpm.c                          |  16 +-
 drivers/pwm/pwm-imx1.c                             |   1 +
 drivers/pwm/pwm-imx27.c                            |   1 +
 drivers/pwm/pwm-intel-lgm.c                        |   1 +
 drivers/pwm/pwm-jz4740.c                           |   9 +-
 drivers/pwm/pwm-lpss-pci.c                         |  22 --
 drivers/pwm/pwm-lpss-platform.c                    |  10 +-
 drivers/pwm/pwm-mediatek.c                         |   1 +
 drivers/pwm/pwm-meson.c                            |  39 ++++
 drivers/pwm/pwm-pxa.c                              |   1 +
 drivers/pwm/pwm-samsung.c                          |   1 +
 drivers/pwm/pwm-spear.c                            |   1 +
 drivers/pwm/pwm-stm32.c                            |  27 +--
 drivers/pwm/pwm-visconti.c                         |   1 +
 drivers/pwm/pwm-xilinx.c                           |  27 +--
 include/linux/mfd/stm32-timers.h                   | 179 +++++++--------
 include/linux/pwm.h                                |  26 +--
 35 files changed, 1068 insertions(+), 442 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.ya=
ml
 create mode 100644 Documentation/devicetree/bindings/pwm/fsl,vf610-ftm-pwm=
=2Eyaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-gpio.yaml
 create mode 100644 drivers/pwm/pwm-axi-pwmgen.c
 create mode 100644 drivers/pwm/pwm-gpio.c

--wzyzmm7voeopd3vd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaUZYkACgkQj4D7WH0S
/k4aTgf9E8oOaPv1vvIY6e+gTrRP7gZLj+CW9S6ckwfD79xpl3JgYzsSKHKsmNav
6V4a2y/OnnZkl+xaRBd5M9xnNqkTJThcN33DJTeXcGNgP7nBryiJ6N4OX52Po7yP
zh+sZX8uGgBGHJryT/2+X/d0xxSe9UzJcA9V7hDIkInPLon2xHBhElvjaikNUx/V
GobwfONv2UUW6GeumholBClc9orQ3usHsubwV/ydBKryafier9KP+pGyJVuLaV/q
ZT99H7BJSHFoEohhrQEixKNII+kx3dFpESK9AkLPthh/uX9LpzFIbbq1VTyau8JN
/FnILzrsAWnaKqXk35GF7fD/Hw2PxQ==
=/7lq
-----END PGP SIGNATURE-----

--wzyzmm7voeopd3vd--

