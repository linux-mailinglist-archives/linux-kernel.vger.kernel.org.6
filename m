Return-Path: <linux-kernel+bounces-423313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B219DA5B4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6E46B25970
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D4E197A6C;
	Wed, 27 Nov 2024 10:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="paHY1RvG"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F197A139D0B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 10:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732703215; cv=none; b=mRdUrqF4sM1PgWio93LMyPH92NzGcIHJW38CneH6g4W2PqH1bY6Fbxjl600MdlRHxXxNXvg9lHQsoF1qcdpNuA1klCwXMwR1P3POqZQ7s6MyDlV1m2RcQ8xcl92KNAdfD1KvT68AvSjGJYz6WiiuzcBFAKxzo38eCrq2JX9n1QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732703215; c=relaxed/simple;
	bh=3HD1WZj7gcV10HfL5nd2E9aHiQo3X7q0EiXoI9r22e8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hlqfkczwIvVh0WPhaHrX8Ah8s+PkAOPBQ0MQNh5MtrhpxPTnnB5evF89xmgvGoMrW+Fw1KG2l6LKpkb2mL9LJLCJ6+5fvN2WsjqBOvFyBZgu6np9YMfJsfs1QWF+mdULGEq/3p+y7UORJ5PrgKv8+Ak5D4YRum+IS5Y6Zpd+m4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=paHY1RvG; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434a766b475so13399215e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 02:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1732703212; x=1733308012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p//qoBIvYJD/MfQs+Cp3gJlNLBTxANT6KYTqpgNXWXE=;
        b=paHY1RvG65MpeNK7WtkNOX2D4au4nchRUOtoH9FV4L5i2qT0MLGz5PJvrd5dmEZUA/
         wJd53YNnOhzxhtNqm7PwSlBqbcAZYRAAHDmIUTiYq2boq21NWnrXBsOSnZXBUV0o8cmo
         FQIRdllVEVd6DeyIUhzr/iw38BG/nmTD724JqX6ijOBwkGduwTdFwMIlH3COsDBriM4m
         w5w+IjKOJZDz930Vl4JWP7klv/65fkT+0krwXcpmreaVrP0tC2WZU6CRP7rGAadAe6KK
         tVon+2k/rltEQ9WP6VyFMtyEAkUi0nnvNqkcyfkZoulTYwF+NMEfTVQkxPcTifVvXQt3
         fv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732703212; x=1733308012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p//qoBIvYJD/MfQs+Cp3gJlNLBTxANT6KYTqpgNXWXE=;
        b=U9eAJ2DyoTJXnQE62zX2viQg/X8Hpyj05XE2/pWeWBQap90EMJtBG6/SbNj8qqAtaU
         AaypqrvJf32gcJov/rPZrp96srdBM1w4HtHyA8OsT6OcSDucWBh7OyBOi7+kiLKnm4l5
         DDGLxJwLWmah0tuKT8yN2xfRKWKMUVBd8ziITV1qigXUMCz1Xp3TXz9PQ3Y8gqgIZYSV
         r7v3hO91eLWbmngluXRHpAjoJtx7mmm0JlHtfmjED3vc7+gTiefXd44WP1JxgNYe7RTR
         D9jmIpieOqHh4U/riPcEY2VIixXkwOVgqtF3PwptjkCLCfsBdO8ot7DbnBLZB85mpXwe
         g8yQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQyGQwUgwZeKYhdXixDdcPAehg4RaU+dq1Tj3LYW5ICWOEaiW169MLUth5V5/reQU15Eo9J9T66AFSZp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYNdFvsVYJsv4izjT8s64qwAq0okkzb7FhlqUGk0lHW5kyX8T4
	zoFhsiGVytVR2cgOOW54vu5SqugnRY3ZwPzgp32FyL2wP4aJjcAQtJf5iZske5TnmQbPKxL7aAO
	C
X-Gm-Gg: ASbGnct4OMnxhG/jv0RvXvUbqvlRvOi85h/oJWYohHbutkNLaAWr71F1u/ZWaz9In3y
	EjkYdaMEMQkNyEZumuGKVPPOATgM+u6EHt/dTcOxLmqTCfi0rF89xoGVKg963owgvPPQP5pMkea
	mnaGUAny/jf9NZIvl89Qt48fy3vDVvnhvhx5p41edegqpv/p6glNhaXEFQXzJ5QCaavyuIsDRYv
	1ZRCB/VOkVNSOGgqE9YD5eEKkYhchCaqnJAnxfCO5LCdRjTQg==
X-Google-Smtp-Source: AGHT+IGx3nNevGUYf6uu8yxDfsPsxhsqBBop5xgFELOXuc/VDJN3HFWLt1Iv2lk1yhnIXiOvsj+liw==
X-Received: by 2002:a05:600c:3844:b0:434:a94f:f8a9 with SMTP id 5b1f17b1804b1-434a9e0b10fmr16361455e9.28.1732703212230;
        Wed, 27 Nov 2024 02:26:52 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:fecd:58cc:bc05:528d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e48edsm16413335e9.42.2024.11.27.02.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 02:26:51 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio fixes for v6.13-rc1
Date: Wed, 27 Nov 2024 11:26:48 +0100
Message-ID: <20241127102648.15637-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Please pull the following set of driver fixes for v6.13-rc1. Apart from
the gpio-exar fix which addresses an older issue, they all fix regressions
from this release cycle but didn't get in before I sent out the big PR
last week.

Thanks,
Bartosz

The following changes since commit 131561f2ca075f3737c2b4821c4d067dfba0f55f:

  Merge tag 'gpio-updates-for-v6.13-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux (2024-11-20 12:37:06 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.13-rc1

for you to fetch changes up to f57c084928661969a337c731cd05e1da97320829:

  gpio: mpsse: Remove usage of the deprecated ida_simple_xx() API (2024-11-22 15:23:31 +0100)

----------------------------------------------------------------
gpio fixes for v6.13-rc1

- fix missing GPIO chip labels in gpio-zevio and gpio-altera
- for the latter: also set GPIO base to -1 to use dynamic range
  allocation
- fix value setting with external pull-up/down resistor in gpio-exar
- use the recommended IDA interfaces in gpio-mpsse

----------------------------------------------------------------
Andy Shevchenko (2):
      gpio: zevio: Add missed label initialisation
      gpio: altera: Add missed base and label initialisations

Christophe JAILLET (1):
      gpio: mpsse: Remove usage of the deprecated ida_simple_xx() API

Sai Kumar Cholleti (1):
      gpio: exar: set value when external pull-up or pull-down is present

 drivers/gpio/gpio-altera.c |  5 +++++
 drivers/gpio/gpio-exar.c   | 10 ++++++----
 drivers/gpio/gpio-mpsse.c  |  4 ++--
 drivers/gpio/gpio-zevio.c  |  6 ++++++
 4 files changed, 19 insertions(+), 6 deletions(-)

