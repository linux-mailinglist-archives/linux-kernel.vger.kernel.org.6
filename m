Return-Path: <linux-kernel+bounces-373336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0351F9A5564
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 19:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BBB71C20DF8
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 17:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290D4195FEC;
	Sun, 20 Oct 2024 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jIrLW1Vd"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF4C194C96
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 17:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729446010; cv=none; b=PqgdZyu+J84fSdV+1WHIjcqBpD6bzj9CHLv5odAT2UfWHj24GzUHY3qFvcjaeyUtAGotG/NfF5nt9IUzp7FhsaSuaSqr73dRgKjecj8RuqveQwheSqMP9yeXSlvIxCjGnwNGmcQkRKExKNy3lyydwJrQ+uPo9DZTvAfl+taWOpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729446010; c=relaxed/simple;
	bh=2PySjemDfX/YXZ1xf2funszs+7EbTC5cyOkh+6oo5QA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ZnP4Z7AhYP34k+x9q2Z2fTo4ls2alOWxJvhDfhCoFhncQenCDUqrUy33u/SlIg6XQrNTAe2EWisxuZ8c3p8JTem1OdER2aGmBMs4txz68jgyJS09Bi1AyN6WsbUmmO+8oFeWLtl4I7Zw9xSciU9z8QMd0c4MV/EAOB+8rGOeIjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jIrLW1Vd; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53a0c160b94so1577997e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 10:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729446006; x=1730050806; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JA6BmeWwEFY/jwQSrDo3imNJ52bplV55SQsd5euBkew=;
        b=jIrLW1VdrtYXp/TclXU+Yld+3j2tlfzdL37bOMTPhhT8k24WKWofO1rtRmalTuTcN1
         1L5GnOjAnKsNRruadZ0TvOyIVXQYup/i1J8a+Q5sErWKfJ+HskXUxON9blcngnWnGA4U
         wTC7D/YyH0kMDrkgN+vynIla8gReIJYsEy6IhuwmDpvUIN9S0P/8c+kJ+Wxv3ArDPDXD
         xR5SzmATo7PT5aeybEgEaRzWDETCb6Vv2OOMJoQJnvm45I4Fg8XqLqa0+nO1P77OeNHK
         1PU92Q+kdMvHcIzbhHmSf7L6rXOUBr+HuzvtfrR1zMHuTuWqEZ/nVdh8tflRlGt6EmR5
         /4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729446006; x=1730050806;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JA6BmeWwEFY/jwQSrDo3imNJ52bplV55SQsd5euBkew=;
        b=vRzGtdi8SE1tov5Lj71RPSzavTiWvTPOUoYVPLRt7y38wrRN9GYwo1RddqEacxqz0q
         HU71BGOc8hBz18eqB6mby8xP1S5+JQmJRb/NqcAyiseYvKALosh4uERVr6O9aKeuPxOv
         87G/IPlMMSbwURxxn/jyGWpjg7r9lzoHhqzEJVbBJ2LVEdndTaqCocZYx3eqglAcIh9n
         04h8wpAwWaHDtsE1YXl7pwvwh/KNKq+4vNJVLqPfbjbS6QPRLnFm/qMuryBknxsTdQhQ
         i6RJVNWgXNTjts1l1J7U0pD0cKzJ99M7ID7z/Paonf+bF74tJj7Fz7Fdlv0GG4Uh7Ftu
         4KZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNFuoK8HfZnI360Rtceo6+BBnaLbewpHMxNS7/p27UrRvFiAaMzSXK6A/B8yQ3yFJ4MJki2qPdFCzeWbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK+/Pn6u/nHXs/3hbNWjZOHO+4dYEp0c0sDGgNvz2ZuXo1wOKW
	HJXk3wKKUEL/Oh2lNPdleLvHOZ6zO2dIk9/zOWB2nMyUXEU1TN0M82YCj+tx6d4pb7FR7Hds/E3
	Oqi1BSOrFBe2EcZ9JOqMSE/aMay15H1vtSoKZZKL4Qp/yfKsz8tA=
X-Google-Smtp-Source: AGHT+IGlgmXQu77sBHLqlXPg31Rg5NJggY/u7DZPakfOAAxehvUSfC/3TPknDBAoQAcKFOB+KaonZte6KYmHd+Bnbnw=
X-Received: by 2002:a05:6512:1116:b0:539:9155:e8b8 with SMTP id
 2adb3069b0e04-53a1520be63mr4950182e87.6.1729446005953; Sun, 20 Oct 2024
 10:40:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 20 Oct 2024 19:39:54 +0200
Message-ID: <CACRpkdZ1K=G+J-Kw1=gbHixuS32DoXGdoja7dOc1O6cR8VeshQ@mail.gmail.com>
Subject: [GIT PULL] Pin control fixes for v6.12
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

here are some pin control fixes for the v6.12 series,
mostly error paths, but one pretty serious interrupt
problem in the Ocelot driver as well.

Details in the signed tag! Please pull it in!

Yours,
Linus Walleij

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v6.12-2

for you to fetch changes up to 93b8ddc54507a227087c60a0013ed833b6ae7d3c:

  pinctrl: ocelot: fix system hang on level based interrupts
(2024-10-12 22:04:38 +0200)

----------------------------------------------------------------
Pin control fixes for the v6.12 kernel series:

- Fix two error paths and a missing semicolon in the
  Intel driver.

- Add a missing ACPI ID for the Intel Panther Lake.

- Check return value of devm_kasprintf() in the Apple
  and STM32 drivers.

- Add a missing mutex_destroy() in the aw9523 driver.

- Fix a double free in cv1800_pctrl_dt_node_to_map()
  in the Sophgo driver.

- Fix a double free in ma35_pinctrl_dt_node_to_map_func()
  in the Nuvoton driver.

- Fix a bug in the Ocelot interrupt handler making the
  system hang.

----------------------------------------------------------------
Andy Shevchenko (2):
      Merge patch series "pinctrl: intel: platform: fix error path in
device_for_each_child_node()"
      pinctrl: intel: platform: Add Panther Lake to the list of supported

Harshit Mogalapalli (2):
      pinctrl: sophgo: fix double free in cv1800_pctrl_dt_node_to_map()
      pinctrl: nuvoton: fix a double free in ma35_pinctrl_dt_node_to_map_func()

Javier Carrasco (2):
      pinctrl: intel: platform: fix error path in device_for_each_child_node()
      pinctrl: intel: platform: use semicolon instead of comma in
ncommunities assignment

Linus Walleij (1):
      Merge tag 'intel-pinctrl-v6.12-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/intel into fixes

Ma Ke (2):
      pinctrl: apple: check devm_kasprintf() returned value
      pinctrl: stm32: check devm_kasprintf() returned value

Rosen Penev (1):
      pinctrl: aw9523: add missing mutex_destroy

Sergey Matsievskiy (1):
      pinctrl: ocelot: fix system hang on level based interrupts

 drivers/pinctrl/intel/Kconfig                  | 1 +
 drivers/pinctrl/intel/pinctrl-intel-platform.c | 5 ++---
 drivers/pinctrl/nuvoton/pinctrl-ma35.c         | 2 +-
 drivers/pinctrl/pinctrl-apple-gpio.c           | 3 +++
 drivers/pinctrl/pinctrl-aw9523.c               | 6 ++++--
 drivers/pinctrl/pinctrl-ocelot.c               | 8 ++++----
 drivers/pinctrl/sophgo/pinctrl-cv18xx.c        | 2 +-
 drivers/pinctrl/stm32/pinctrl-stm32.c          | 9 +++++++--
 8 files changed, 23 insertions(+), 13 deletions(-)

