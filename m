Return-Path: <linux-kernel+bounces-350485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E63E9905DA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BC19283351
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 14:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADF6216A26;
	Fri,  4 Oct 2024 14:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="r0IIr95F"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAF420FA95
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 14:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728051666; cv=none; b=sPEb+aksm7Sq6RCTMcMfSlWA17CQbLY9J+PVvNxuE9mnN6gMTrmbXKbR6v8HQUR3izMR1Vi2taPtGwNO5K3Otc/n+eMhlUmhhFTGAJpg8S/dozJ4JEKEX/uniakhyDAarrLdVH7STnpgJlTVe8dtm9B/f1pnDbTvJKf9WqkdRXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728051666; c=relaxed/simple;
	bh=dJcgLRow2aaQQBfKxTUsuhyTu7/BG3s5t9lTT/eMid8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PDqPAOdcrxCQ20yrLqvrnjBhhtswZuruP5z79slMyEBmZ4Bmz3c10aHro6NnAe4RmlIqggaI3pqshHx/AR6pHcJhmsWh7yEJ9+EZHXL0sAdWR3Rk/sOeldAqTNJYQ1V5CxTuJs+KUjVFNL1Zi1CLdw9Mgmwpz4q9T1xQ0CpNktY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=r0IIr95F; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42f56ad2afaso27744205e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 07:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728051663; x=1728656463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vKSqvrpEqeBm32KxHqmFUKeU0x5YA9JFbesDhu6KpkQ=;
        b=r0IIr95FQt0fQcuC5vL94FxKBU3HUE0PwniQx/3zMT+Wpa3VUpv+jMaiNK6rVW5vwr
         aDCG1jrOqvNlqQlhroyFxzAE8IcgfzxwCquTWX8Kw/FvNo4ZzjeFhmyEWH2QKd1c1ugT
         cpaRy2/LdPzzuEqOr4i4fTkltaJFebBBzXmOwlVrPpS7XhNhjA4+OmzyRbPNLbb+2I3U
         pHy+4OCHur0rE2BWWgwcKrRsUm/i+f+EEjF0qcYhZsL/0V8ln3NPRg7g9kZ3dKrjO1T7
         HKQdeg37ZCyGH4MW1n8xaNqW/fq65j1F+N4b5pwB6/cfXT5ePuwsUj94Z4SwmVx+Lqv0
         2jKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728051663; x=1728656463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vKSqvrpEqeBm32KxHqmFUKeU0x5YA9JFbesDhu6KpkQ=;
        b=eh/ZM/pDPamG1vCA/q4ZtQNG8vLVftlCnHf9pnYmOTKaXJyRu/Zk3vUeK1UkpfFiq2
         LI09HPn4DrLzmuvvY1Ioi1MFBoTdSZMleEzhF+kMzEgVQoWfia98C2WnGLc2POjLwgIZ
         cu+AddZyCvAy5c0At6HO+nEIoTKwO1L2SuEHWSvGUEga1WpG4H5DjonZ6p7RQiU/3bxz
         j0eYnIkKtZn1YvvFlXdMasS+Vhj5out7DrfAAAvebxpyaDmbBRNBs4fLiruZlPQvn8wC
         hD+SiIb6EjF28fx431BshuvR0XHOGYeJrA31CeSO4v5XByUdyuvQn1u45MkH8ElmNUDc
         T3Ww==
X-Forwarded-Encrypted: i=1; AJvYcCWGTBpWk4q6EWU+g1KTi/51/BSHwkZtH48vyFVaDWteIs0+q1bCwDXDFxsuJ8fBm8+Rd3nKYUyVZV+05hk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiXapwEN5yqKb4TtJPxxv9YoUNY24lCxBXIjtmVVX09nDb+goy
	FcqV9d8uhrKWke/+LNrzpJ67kR7OeSa/p0aoTFrVWTNFPYnbOWSdMVcesC6Qe4T99thLIOoZtM6
	7
X-Google-Smtp-Source: AGHT+IHWgiHQFvysKVnpOzNkinC2CjZNNoOI4K/L06cIjvNqoUz6Mwnu+SLA25Rjpn5vC58pBeVYrQ==
X-Received: by 2002:a05:600c:3ba9:b0:42c:ba83:3f00 with SMTP id 5b1f17b1804b1-42f85a6e0c0mr30150145e9.1.1728051662841;
        Fri, 04 Oct 2024 07:21:02 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:80ea:d045:eb77:2d3b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b24003sm16771995e9.21.2024.10.04.07.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 07:21:02 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio fixes for v6.12-rc2
Date: Fri,  4 Oct 2024 16:21:00 +0200
Message-ID: <20241004142100.53097-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Please pull the following set of fixes for the next RC. Details are in
the signed tag.

Bartosz

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.12-rc2

for you to fetch changes up to 7b99b5ab885993bff010ebcd93be5e511c56e28a:

  gpiolib: Fix potential NULL pointer dereference in gpiod_get_label() (2024-10-03 20:51:47 +0200)

----------------------------------------------------------------
gpio fixes for v6.12-rc2

- fix a potential NULL-pointer dereference in gpiolib core
- fix a probe() regression from the v6.12 merge window and an older bug
  leading to missed interrupts in gpio-davinci

----------------------------------------------------------------
Emanuele Ghidoli (1):
      gpio: davinci: fix lazy disable

Lad Prabhakar (1):
      gpiolib: Fix potential NULL pointer dereference in gpiod_get_label()

Vignesh Raghavendra (1):
      gpio: davinci: Fix condition for irqchip registration

 drivers/gpio/gpio-davinci.c | 10 +++++-----
 drivers/gpio/gpiolib.c      |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

