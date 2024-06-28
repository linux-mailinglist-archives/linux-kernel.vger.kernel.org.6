Return-Path: <linux-kernel+bounces-233741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 633A291BC6E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 941471C226FE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 10:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800B5156C62;
	Fri, 28 Jun 2024 10:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="lgkQozZf"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0570115886E
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 10:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719569508; cv=none; b=JgDjy0P5rQxW6woQ/j3KcZ81lKyimRe/jDlIl3IYwfPj+D8w51Po6ar3KcjqUqXjtEAN8m7nlQ3MXURNTfAnr5JzzruuLXmE55z4vW+AEWRwkLgaK1WZ1oAUseO333xxccyx1Dsu28+mLOfJdHY63q/O0hr1l10muXZQqynb93c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719569508; c=relaxed/simple;
	bh=typWC4rPgvkMNHZP8pTloCLl29F5JtXSoQZOOaQJYYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EfAqUV1SAl4PKBw+ZFPV4E+6ZHGs0ISqc4t3XIcaMckOLmXrWX+b48JBBWNOq1lstLzXmoBPnWKrSOJ04Wxnm8RuJ9zNRWYdTtdmP/2FPybuLQXQobqmmipOw3nCnn0T0Wmo0Br0iGbGs0qYBaSq37gTb8TfzCEGIYI70MWTjjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=lgkQozZf; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52e743307a2so539299e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 03:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719569504; x=1720174304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hdl3PSGh9S35qMafYON8RkQ3hcQRYs7QhYzWmfguxkE=;
        b=lgkQozZf7NjIHf2QY+Wcul8Wg9FG1le+YzpaX5wKrHNS1JKv0hfB62altafh33ooBZ
         GJse1fTEFO91ZtvYm/oelnXPeUpUALiPlOhsrxhjNYbYk0cYtYQmHnNVnOxBVgnbEmxf
         yiersIckzN1PhqpUnUsTTv6mEz4GYRzsJNWVjDtSifoX8tq6GfqQeuErUxrOrqNIX1HL
         HaSal/gzrAkC61pa1S4pMZ93lUhxmubQnaKxdJBuEr2/yPMrntP2I4PtyfY0e9ot5nr0
         fjZmt9VM12iCN5k9YB0jUwiIFFqI3UAl524HBUrj60HbPxlX6d+Y1ABPtRnFnSyyDBgJ
         sb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719569504; x=1720174304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hdl3PSGh9S35qMafYON8RkQ3hcQRYs7QhYzWmfguxkE=;
        b=m4272PMOBlJtLLwazAE7OP5L4mv2l2S1wpQPvuyk/h2rfc3/ZxMiHtEGA3AqNRLbOt
         nJygF1fQma7H0RizMU/hUYrUETSXtKPMq7JIr+Hz8wZgLBV1qsFfqRejA5dJf/SJXKzU
         sw+vDLOc9ZLTiW4so4YJ5TJcZHe1EhWk3nq5arBTqnb9In2KuVbZkHbZVYTiDcNR6CPz
         QkWPCfPASNYHzzqnQGx2BLcgIMPPviBuAc9MCKfhiVvARqgEQfhIA5y3PNmjtsKtWuGs
         1zNM+++8CdljvRj9EETmsE3rNKdRmsZlqu4Wpe9F2MQ9N8hxmS2YYbdejosjewyC0yIF
         slgw==
X-Forwarded-Encrypted: i=1; AJvYcCVh/OBxu15YS9/sQcV9P0ccNX0N0c38Wo4epka2UyG2OWIPY0XuVsvCR+aNIpbsqQpx7Ux3drdEEoW/yfiXiF9M13Z9HyDyFOHKXE5R
X-Gm-Message-State: AOJu0Yy4Jlhl03lSc6naMgbJaBEvL99esF+s1/qBRdZgO5fe3Jafq15y
	vezAMz6eCjPtyS31wa7ir/u0Q5dDxys3tL6BTxdqpIsPn/Pd+iinMb1DfnmDmgg=
X-Google-Smtp-Source: AGHT+IE1Jbfv4vSYbSR7uNEWi1U7MEHfMoI5hKODYdtbPQiRI+uquKnCoEotcjusij8xGEohrV3uEg==
X-Received: by 2002:ac2:4d97:0:b0:52c:e170:9d38 with SMTP id 2adb3069b0e04-52ce183ad20mr10824150e87.31.1719569503961;
        Fri, 28 Jun 2024 03:11:43 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:cb0e:590a:642a:e1f9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fc434sm1770895f8f.76.2024.06.28.03.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 03:11:43 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
X-Google-Original-From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] gpio: fixes for v6.10-rc6
Date: Fri, 28 Jun 2024 12:11:42 +0200
Message-ID: <20240628101142.33339-1-bartosz.golaszewski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

Please pull the following set of GPIO fixes for the next RC. We have an
assortment of driver fixes and two commits addressing a bad behavior of
the GPIO uAPI when reconfiguring requested lines.

Best Regards,
Bartosz Golaszewski

The following changes since commit 83a7eefedc9b56fe7bfeff13b6c7356688ffa670:

  Linux 6.10-rc3 (2024-06-09 14:19:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.10-rc6

for you to fetch changes up to b440396387418fe2feaacd41ca16080e7a8bc9ad:

  gpiolib: cdev: Ignore reconfiguration without direction (2024-06-27 17:21:28 +0200)

----------------------------------------------------------------
gpio fixes for v6.10-rc6

- fix a race condition in i2c transfers by adding a missing i2c lock
  section in gpio-pca953x
- validate the number of obtained interrupts in gpio-davinci
- add missing raw_spinlock_init() in gpio-graniterapids
- fix bad character device behavior: disallow GPIO line reconfiguration
  without set direction both in v1 and v2 uAPI

----------------------------------------------------------------
Aapo Vienamo (1):
      gpio: graniterapids: Add missing raw_spinlock_init()

Aleksandr Mishin (1):
      gpio: davinci: Validate the obtained number of IRQs

Ian Ray (1):
      gpio: pca953x: fix pca953x_irq_bus_sync_unlock race

Kent Gibson (2):
      gpiolib: cdev: Disallow reconfiguration without direction (uAPI v1)
      gpiolib: cdev: Ignore reconfiguration without direction

 drivers/gpio/gpio-davinci.c       |  5 +++++
 drivers/gpio/gpio-graniterapids.c |  2 ++
 drivers/gpio/gpio-pca953x.c       |  2 ++
 drivers/gpio/gpiolib-cdev.c       | 28 +++++++++++++++++-----------
 4 files changed, 26 insertions(+), 11 deletions(-)

