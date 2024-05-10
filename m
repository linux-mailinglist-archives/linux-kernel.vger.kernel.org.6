Return-Path: <linux-kernel+bounces-176092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C237A8C29CD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 20:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDA311C21081
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 18:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC682C683;
	Fri, 10 May 2024 18:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="UBrzni0G"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371D225779
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 18:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715365606; cv=none; b=Ct2Y5J2fe3ufjDy9nhfnHMG91XrWYUiuutJKALlzmrvj4ds35n3mrPmQ0GTSkXQGQZBO/5ebg65GxHt3esFsITl3b96g0fYXlN0fnq9CNURUTrscd5GLYru8gFxqs5iiHlRORVzRHd2EcinvFjSNhYnC6a6dmA6u171CaF+Lxs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715365606; c=relaxed/simple;
	bh=MhTpSYlniw09ynrGEPyV5q2Agl9hNAli8lBhN6J7RRg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O3JKay00SytLzxirliqHIVFoPQOI+gmACt/TyJpKHAxhaL8vzEf9EIiFsiDbassRWr/oWWxojoZ/8+K6yphoq4BP00E+mk3zygFJZh5AdVKY0Y2GiD0GSpdlBuOYOy5+6kBdcajFbaCIGPU5AtgJjrp73TSEIF1gMbZ5DXiiF7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=UBrzni0G; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-350513d2c6aso776915f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 11:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1715365603; x=1715970403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3QEkrlUEm+5W5lnp6HukD9LF+vny0h09LkKwSRX06UI=;
        b=UBrzni0G85wytcUfSXcnGCHf0H+AdUN+jfDwzItNR+6xb3qCMAvhPtrpGDQpmG0V+t
         JIVBThQkIUgl7gO7WXxHxZYLmYjJpxqFY+i65+ll20yIHcFm4YWXln15k0tHfglurPg7
         XyT3WUApoz7TZcoQ7X9W3TEC5NZngjCE5d3R4n3isgmP5j/XATbrRGYpSDqSPGDeCbuD
         fEpCzmu5HVZzW3kDy3SrgEiFrEghLeeaq+j7a3kjXbUe1LzxKC0gG+jcH8ZSGhUIix1D
         FMSqgCwfh/IT+z70rE9998iThzQCUA2EviI3wfy5FoBPQbYLMF11W7Xns4AR4u0hID0f
         /w+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715365603; x=1715970403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3QEkrlUEm+5W5lnp6HukD9LF+vny0h09LkKwSRX06UI=;
        b=fBzbUjmbFEj6Bx6BxxfFxJAYdpygnVlf2l8gV81xUltY/CulPkQ27QJn8c/niGooIW
         U/c6aVm8k96UsG/gmzFyUfT++l/qTJlgl0GvoJREc9c89A0ziRofeBk3d+Ec1cCGZ1Nw
         Xwnt3Xgp1pGvGZwl8RyY5Os/KJ0XM/WNyjhBqI86ZpVliFtOOf3zwnjZrQ3KXPFxZBsc
         F7htmTU8yOLDaAnnmijJMRICiGlCjlUotZsPAhExt4OxOduEM0w1gLRRQ5JXSXmPHqpy
         3ey9BdwH1fDb3Z05aVqEUBAdW9ni9aZ8NeN6FhVfuWaoyUT52c+NTWTrZMe5LslXIFd/
         p+HA==
X-Forwarded-Encrypted: i=1; AJvYcCVjZEgoZdc4e7CKJFIBw5Uzj6bd0BkTuzcE2E/GOmCmJxuLXx+OjB2xhvVB/UInU6AT0J3xWA4wWQHubqQEU9e+WXGhsvUJj4RWrd2T
X-Gm-Message-State: AOJu0YzWPan1t97gQne1fNTLM7E5hf0EF+wbiTfZ8wzKR8zcToDEC/RJ
	5GF0AJ1ZnKAm9oBV2PLSa+5cjQtd7hi/QhqkZBzvLvWIqOddNW0nxyLCCF74gi0=
X-Google-Smtp-Source: AGHT+IFeLwkav5v4iPuh0Gz6pchGRbm+soi1ErYGVONkn6HlYK04px73Z1UuB08Vyrm3T8na5XY68A==
X-Received: by 2002:adf:f60d:0:b0:34e:aef7:4ff9 with SMTP id ffacd0b85a97d-3504aa62e64mr2798361f8f.61.1715365603515;
        Fri, 10 May 2024 11:26:43 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:f6ed:a982:f92e:840c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8a789asm5184745f8f.51.2024.05.10.11.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 11:26:43 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio: fixes for v6.9
Date: Fri, 10 May 2024 20:26:40 +0200
Message-Id: <20240510182640.44486-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Here are some last-minute fixes for this release from the GPIO subsystem.

The first two address a regression in performance reported to me after the
conversion to using SRCU in GPIOLIB that was merged during the v6.9 merge
window. The second patch is not technically a fix but since after the
first one we no longer need to use a per-descriptor SRCU struct, I think
it's worth to simplify the code before it gets released on Sunday.

The next two commits fix two memory issues: one use-after-free bug and
one instance of possibly leaking kernel stack memory to user-space.

Please pull,
Bartosz

The following changes since commit e67572cd2204894179d89bd7b984072f19313b03:

  Linux 6.9-rc6 (2024-04-28 13:47:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.9

for you to fetch changes up to ee0166b637a5e376118e9659e5b4148080f1d27e:

  gpiolib: cdev: fix uninitialised kfifo (2024-05-10 16:38:27 +0200)

----------------------------------------------------------------
gpio fixes for v6.9

- fix a performance regression in GPIO requesting and releasing after
  the conversion to SRCU
- fix a use-after-free bug due to a race-condition
- fix leaking stack memory to user-space in a GPIO uABI corner case

----------------------------------------------------------------
Bartosz Golaszewski (2):
      gpiolib: fix the speed of descriptor label setting with SRCU
      gpiolib: use a single SRCU struct for all GPIO descriptors

Kent Gibson (1):
      gpiolib: cdev: fix uninitialised kfifo

Zhongqiu Han (1):
      gpiolib: cdev: Fix use after free in lineinfo_changed_notify

 drivers/gpio/gpiolib-cdev.c | 18 ++++++++++++--
 drivers/gpio/gpiolib.c      | 58 ++++++++++++++++++++++++++++-----------------
 drivers/gpio/gpiolib.h      | 17 ++++++++-----
 3 files changed, 63 insertions(+), 30 deletions(-)

