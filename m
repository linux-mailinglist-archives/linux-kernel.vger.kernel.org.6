Return-Path: <linux-kernel+bounces-516090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF631A36CDE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 10:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CAFA3B1077
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 09:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B3E19E97C;
	Sat, 15 Feb 2025 09:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="kudGv7dj"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D6E19D8BE
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 09:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739611516; cv=none; b=RT9TYULxni/f3YTmv4qllE76KQCOYlKx0XTvReTQ6k47tjzETS5aBi36AaGHVAI6M0gWjpUvh4RphqXL+mY3Mdg5JLyIQfS/OWIgV7t12YE53LtkrObSXqs41UGBwQc2wtvU23G1dwrHMLc3M0ZXb9rXK2jY2zP2XcHcCV+B9lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739611516; c=relaxed/simple;
	bh=fUEhJUJqOaQ6kqDr/ymTWQoQOscJJR6mrSLqxVNnVhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tVSTayHsmTfNizu/iWD30gd8vxEr+zdbpEX+ayHzV+4T12y6c+cEH5S40+dVCiAOzC2Ynkqn+nmKz9aX0pWVOofKRLc/ky0NFXbCNfdOL2DEJJ4FkKfCbcTXvaOWEGRsOVgNDUZiVXGtDnMeTJlrGo/poKWMIaUVbzAY9WtlCoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=kudGv7dj; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-438a39e659cso19847425e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 01:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739611512; x=1740216312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KbpcipICDHXuME30jOt6GpmvUkIPw+/TuJhtLOZoIJE=;
        b=kudGv7djwhYMRO3Ou4v/47TcrnQk6Hgr7X9RPe6o2yWg/wOQ+nLh0apMEmcMa7M3f9
         sqNguNOtInbQpL8oHKtTVtbigdEv9bmpNU5kaUiOj9WzUuaezgsCaTaCYc7iaWYqXOPZ
         Z/4XRgslioiPTzktxOtjAOpNIUvBKHMR/oGSGhv6gOHGWDl35VQxaxtSkrZ//uOsqERm
         agolgOaUZyKpg9uVbtkiDL4qw7kl17DRaf++i6RwNIV0EwkRSB6FfGljDwhyNqPPBU/D
         GvoJXY/En9vBmbBEvSwec6BcVj3RptnHX9PgJPHevyx+Bn6hVg7HyjfPsDzbZeWE2+4q
         A5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739611512; x=1740216312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KbpcipICDHXuME30jOt6GpmvUkIPw+/TuJhtLOZoIJE=;
        b=MFhbAs7Kg76aeIi2/4HT2HkRt+XG8BC5b+Sc2qZWx6SAUeVbX+UEG7PPoYrUhWrZtQ
         7zZEcPzJKTWDxAWWCPdRQ5nTyaGaLW6sR6R/1sub5MwqD58v4As9puNEw1D1psEv3QBw
         KKtBTEBBNEogHQ403DvA9DJd3Jt6CTtTaWNNI70qvJr8xySoMiQR4AcWiYkstZb0/2WW
         l41arhAIL5tXxpy5CcoHWRPERr2nk384HewYf0vQd0Nh1xzK1NKg6aCjCqi7tOdQhBV2
         /hrpuh8e2IulGHVCvENojCHXMisJsNN26487AoedTy2/rGgwWkZO0YDJqT8FbJtdC17h
         DVgw==
X-Forwarded-Encrypted: i=1; AJvYcCVgtFJVmq4Qpna4Pio+0vGJMLgboxHfN734AFANxV8nEH2kAXg0YnTXcIIvLnrS9fXNHQ6hv/JqdHRuYSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhobbSaFMQWcZJbgm06GsZkmnPbwHe/7Dg5JkuWSsm2a9l/RmR
	iP5o5npuwosy+0dOULbwOWdaWii9VzDrw2PUdvRfgdLGUaM27r3FDZoVcoNlQh0=
X-Gm-Gg: ASbGnct64sAbYWiFGr21M2ajIl4BS4hTZu5Bkle44JDe/rU7HBGZzpMnsL4alrg9tQw
	Tze9hkWhLfdrpy7Z//Pd+stU27Ac0bu3uCx88DjKHAMGMjibZFJKVuaohEwJ0xHORoOQBFlIsSu
	UHumEONMYXV4Jx4yeJPLr8Efq9no4/tMOfUo3Wc/iIUxWHLq/TMr5CaJDiv7afvl/hHxuqO6SOw
	5xPZNhS5X59uAtwIyhwUjW07GXBd2tr6EpvNv1+CLDQ1zYB3NG1aN7UMYEv/+blb40QygU7Z94N
	K0Ltf8YzwFzY
X-Google-Smtp-Source: AGHT+IFkUX2lCfN6as9yUxvWctb2+wcKM91fqinvxlY72zNbgOkS02wV6iv5kqX++4LIwQqaOdaE+A==
X-Received: by 2002:a05:600c:4fc9:b0:439:564a:6503 with SMTP id 5b1f17b1804b1-4396e705d5fmr28556145e9.18.1739611511767;
        Sat, 15 Feb 2025 01:25:11 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:de0:6b3:d799:3d4f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a04ee2fsm95776445e9.4.2025.02.15.01.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 01:25:11 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio fixes for v6.14-rc3 - take 2
Date: Sat, 15 Feb 2025 10:25:08 +0100
Message-ID: <20250215092508.5849-1-brgl@bgdev.pl>
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

Here's a second attempt at the PR with fixes for the upcoming RC. The
sparse warning I mentioned in my previous email turned out to be a false
positive - the "offending" commit wasn't the culprit - but I removed it
anyway and will send it again next week with the sparse issue fixed
separately.

Details for this one are in the signed tag.

Please pull,
Bartosz

The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:

  Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.14-rc3-take2

for you to fetch changes up to 7b4aebeecbbd5b5fe73e35fad3f62ed21aa7ef44:

  gpiolib: Fix crash on error in gpiochip_get_ngpios() (2025-02-13 18:51:39 +0100)

----------------------------------------------------------------
gpio fixes for v6.14-rc3 - take 2

- fix interrupt handling issues in gpio-bcm-kona
- add an ACPI quirk for Acer Nitro ANV14 fixing an issue with spurious
  wake up events
- add missing return value checks to gpio-stmpe
- fix a crash in error path in gpiochip_get_ngpios()

----------------------------------------------------------------
Andy Shevchenko (1):
      gpiolib: Fix crash on error in gpiochip_get_ngpios()

Artur Weber (3):
      gpio: bcm-kona: Fix GPIO lock/unlock for banks above bank 0
      gpio: bcm-kona: Make sure GPIO bits are unlocked when requesting IRQ
      gpio: bcm-kona: Add missing newline to dev_err format string

Mario Limonciello (1):
      gpiolib: acpi: Add a quirk for Acer Nitro ANV14

Wentao Liang (1):
      gpio: stmpe: Check return value of stmpe_reg_read in stmpe_gpio_irq_sync_unlock

 drivers/gpio/gpio-bcm-kona.c | 71 ++++++++++++++++++++++++++++++++++++--------
 drivers/gpio/gpio-stmpe.c    | 15 ++++++++--
 drivers/gpio/gpiolib-acpi.c  | 14 +++++++++
 drivers/gpio/gpiolib.c       |  6 ++--
 4 files changed, 87 insertions(+), 19 deletions(-)

