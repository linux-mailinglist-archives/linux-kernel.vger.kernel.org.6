Return-Path: <linux-kernel+bounces-444867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5595C9F0DAA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53D10188D4DC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 13:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83A31E0DDF;
	Fri, 13 Dec 2024 13:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Z2VhocKb"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D0F1DF975
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 13:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734097687; cv=none; b=GAGtRUnQkkFIdJYR1/CL3QSrgIaqS/QGU0qQh0PHFbBiIlJm/InlxGWjzyYtaIJgxpGqW9xLtyJV3EmWFYSiyaZAig+N+Fd2TquaM2RKZF+sJdjgUfci+VXzA3yDnS0dekHJRbARc6AAk1Z22277Jgk/wCA6KqH5bUdya66V2Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734097687; c=relaxed/simple;
	bh=d5AMuzQAIUe4zZRfscmd84/yBM7yc7yYL1lGkrPAECU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qIs8r2jqvL+rxVU32LoHUp98r+VydjRg3gqgmbRhzk9FnZQrXN19E/pe0s4n+QgFy4IdQfCvKcftqh20X+XRaVnc7puvRzXvzUxrua7+z9lRJo2VkPUAeCF0VQIjDSDvajnIKYQDBRQ5t6KNxnzJ/rxv5dJapU/GMAVjWZEYWxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Z2VhocKb; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37ed3bd6114so845524f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 05:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1734097683; x=1734702483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KBWZdrFZq/ypPQinnhBf3j/mX7D/y4Qq7vq6ZAbMa+A=;
        b=Z2VhocKbZADymy4FFUzkxnYdhixfhfA6X4da1Aad6LRC9ZMFXeYsLWCisbB8ZJKe4E
         gS6pvnnK3Ep9EnarOvAhhaNFQO83JSos9DiqF5QrsMdd88AM6wpf4qnKm5Cz6shL5+IT
         Sl+17Pm3NC3S1cOA4EKhpUIshtFWPt4SQExG2Ws71IKFD9FRigXPnJCmQQF4L+f2sWJR
         SfifXwrHVzKi+zloW9DjAkEjE6Wk7oWYzvHQdXrqLHK3YKLvsToZU4hzCikp3D88SpCz
         T9l2qprMU+WiB2Wn7ZGQ2DK9a1h8QIqjDxNVW0nUrFYDbYzFdhKzNbfIfxfp+2W5BUpH
         0lFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734097683; x=1734702483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KBWZdrFZq/ypPQinnhBf3j/mX7D/y4Qq7vq6ZAbMa+A=;
        b=m4FJqUHbnrQm0tOVQzluhkXdtZSbYc5krptECs1+SJjrwJgwtLbS6TmQXcRKI6KaKj
         WJtOL9RxU26GFNH6rUca6GHb5p5tlcnGkAb1UaVAhGjb9163zLtLShaUlTeE+2SrhSgL
         0eEWKFNofwtzcR/6lMryoklgce4Xo5IdXrUug6Qfg692PL0yWE4TZ/iH5jg+a7wb7esW
         UX6cnf8TXTTNRMSniveKFkW/S9NPoW5e3alFzlPmEzqTOZGc41JL5jbSLoZqj8GOSUGS
         CvpVfj3i6ICrqsNfTLXpKiywgkc8WlnONrUCKtB212bWCq9/IEhM6yfIzgQs4RHaSEKF
         t0hg==
X-Forwarded-Encrypted: i=1; AJvYcCWXQrrcNNLjCBRrhQUkljgLIZ7ouW6QrmAtcozFs8W74r4nMB4fa//RmFpNKx2jtNdMfKntiqxVH0V8HQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAc4FvQRakHTY7t/GgP5uWVCRwxDibX46f3F3K3PvWmmQRDZQm
	SHvc1M8M35udqS3UPy15SF8snSEaGiNy44GH+Vp5haMQvTpMmhs885jqPc31Lco=
X-Gm-Gg: ASbGncsX3sEoE46p4Hbyr4y9r2M+fwQq2vfxeqcK4oua7TaFYKJOxsS8no187CTGG6O
	gEG/b2bXxVLZYO63c6G6Na8xSOZj/2LSbc9zKAqZ1Vdr8b5SCwV0X6UJjAzuI0+7F8Vfu+VT9i5
	8jh51v7Y17kB2+GSGcD6A+czo8mYGt8u9pmyYGmv+SoN7v+DcOdM3kLG7TZEhzG1FXotitYr2lk
	XXW+BeCN244/87AtQThnVsS+XUbK93VyO7PrS7iKYSFBclJ/ttQ1k5S
X-Google-Smtp-Source: AGHT+IEenn2RiVtEughxbHvKg8aFKAq3s3PmhZ70Hj4Ex/nlW2usPkV2ZibyhXQ0qLvW5EMP4wZVsw==
X-Received: by 2002:a05:6000:1ac9:b0:386:3357:b4ac with SMTP id ffacd0b85a97d-3888e0b8529mr1738371f8f.42.1734097683311;
        Fri, 13 Dec 2024 05:48:03 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:78c8:31ce:3ab7:987f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878248f71esm7386927f8f.2.2024.12.13.05.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 05:48:02 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio fixes for v6.13-rc3
Date: Fri, 13 Dec 2024 14:47:59 +0100
Message-ID: <20241213134801.49391-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Please pull the following set of GPIO driver fixes for the next RC.

Thanks,
Bartosz

The following changes since commit fac04efc5c793dccbd07e2d59af9f90b7fc0dca4:

  Linux 6.13-rc2 (2024-12-08 14:03:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.13-rc3

for you to fetch changes up to 9ac4b58fcef0f9fc03fa6e126a5f53c1c71ada8a:

  gpio: idio-16: Actually make use of the GPIO_IDIO_16 symbol namespace (2024-12-10 11:38:57 +0100)

----------------------------------------------------------------
gpio fixes for v6.13-rc3

- fix several low-level issues in gpio-graniterapids
- fix an initialization order issue that manifests itself with
  __counted_by() checks in gpio-ljca
- don't default to y for CONFIG_GPIO_MVEBU with COMPILE_TEST enabled
- move the DEFAULT_SYMBOL_NAMESPACE define before the export.h include
  in gpio-idio-16

----------------------------------------------------------------
Alan Borzeszkowski (5):
      gpio: graniterapids: Fix vGPIO driver crash
      gpio: graniterapids: Fix incorrect BAR assignment
      gpio: graniterapids: Determine if GPIO pad can be used by driver
      gpio: graniterapids: Check if GPIO line can be used for IRQs
      gpio: graniterapids: Fix GPIO Ack functionality

Bartosz Golaszewski (1):
      Merge tag 'v6.13-rc2' into gpio/for-current

Geert Uytterhoeven (1):
      gpio: GPIO_MVEBU should not default to y when compile-testing

Haoyu Li (1):
      gpio: ljca: Initialize num before accessing item in ljca_gpio_config

Shankar Bandal (2):
      gpio: graniterapids: Fix invalid GPI_IS register offset
      gpio: graniterapids: Fix invalid RXEVCFG register bitmask

Uwe Kleine-König (1):
      gpio: idio-16: Actually make use of the GPIO_IDIO_16 symbol namespace

 drivers/gpio/Kconfig              |  3 ++-
 drivers/gpio/gpio-graniterapids.c | 52 ++++++++++++++++++++++++++++++---------
 drivers/gpio/gpio-idio-16.c       |  5 ++--
 drivers/gpio/gpio-ljca.c          |  2 +-
 4 files changed, 47 insertions(+), 15 deletions(-)

