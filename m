Return-Path: <linux-kernel+bounces-206642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99442900C38
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 21:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1779DB22E07
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 19:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A04143865;
	Fri,  7 Jun 2024 19:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="uc2J6KzB"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2155333EE
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 19:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717787153; cv=none; b=AC1NVVx4cXtCKUfLdYs/H+iG1X6NCAyHSiIyXVGjZcF+2ld32pfm0r5qWs71TlmKKfvpRclLBcuXWJgTwKUeFQljIhwKHnNQNhrGlLkSn5GfvScCczsaCxRyp8CqMZXQQA60Skf0lp/3FNYYYnZPS+jr6zAHsOu85yFlXLO7clo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717787153; c=relaxed/simple;
	bh=ngIRetO5CkzK9IehqPyRMoWnWCmFj8wR8sAvGODMxoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fGvNJE/Bosnu6DXxC2FmnhzKCbos/bkkFeA2BFifGXDzpRXFj+m6/6CL9Bif7A31KhbSC8xjkOQq8Bl4wkE0qcREzI6NGYQGOpr1pxv7wXpDvzUo6cJWtQXGJPudJZutWwWhtPFRhCzaFjRYpR3LZ9d6TVUa+TG3gbgTuMLrD2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=uc2J6KzB; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52b976b5d22so3490754e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 12:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1717787148; x=1718391948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HxA1BM/AGy1NJKtSG9weBu/7I9Z1wHNH2yZVYRhiSUs=;
        b=uc2J6KzB0KGOJZsAZru7aXcHjV6viq0bWYprxqt86vuwkWDOBcbDunnO6Orp6I9L7R
         Loo2bIc/h/fUwf/g/l3bRZvZoyue8gezZym/hPWKMgasZ1bqqOIj9UJgFIlg8Ka3QIve
         AaJL9Rk4V7xJa0CSaLaFWf4I+2vwo3Wx8dkNOTJVHmrCY3ZMx9XC8RFX2oFRo0Z3fYov
         gLU0XYbyAb4droaYIA4xEb2uqklQpJ+yVF9slSvBX3iqdmHSDQkOdWQTa44uhhVn5fqV
         GUxmhKv4DgMgTIcTk7YMkS/u91KjNyEyLnuiis/knCyvfhkNOWpKU1F/PbLHxTVnI51e
         M8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717787148; x=1718391948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HxA1BM/AGy1NJKtSG9weBu/7I9Z1wHNH2yZVYRhiSUs=;
        b=XUdCvl6YQxxVcQZtB8S02hr2jo17P3t/+nsa2A8G4U2XTsuuEbGUte5Ac/AOcvAhYF
         th84KgAZ/XTxMCJAbvwVJbbMh3IpdYpEND+oHgmTBdy6zRIODAp9KKdwVEAW4q4f5RCP
         f5YNqwkrlA8o3UOYg7Q6ifGmDh/qiJHQPnQLb2bst10/NbYyB2lfUcUqGAtoZP52ZiM9
         qJhw4dY2IBtvcRLAUqoyIMiVAP7mk3t2jo+buIqCrTjaH+WAdHjtv+cbYOBda6YkEpzl
         3A2U6TrIxZUFpld3e5GJlR7hvUAMfdYyBhHC+uJYefYSmUbwUgTXdKxAOZzgx6veVzca
         X2hA==
X-Forwarded-Encrypted: i=1; AJvYcCWPveDn7KF1IrX4YNmOMnTEHDGGxRZ+uLGPBfRsuDI+fk7kym9ql8tnWtOSRTkAMMJCWYz6OAqJYE6p+GZfReY87s9J1ZxrwAQOk9Aw
X-Gm-Message-State: AOJu0Yw1jGLsOdg0NtcTQoQxVqPa/mbRgd2L8b423YgWfyHPKJPNj0SF
	wvCPNFrJn1Cp44hJDYuVYdEQJxd1779RcHGLuA8v6IrHBrAiRAm+7qzNlhrJnJ0=
X-Google-Smtp-Source: AGHT+IHVKb+PdYi2LkaUjU+Hnrgq0RwwwvnqIkhYpv6Wpv6EPxqYa+IjzsJMUHeSRfkORqd071am5Q==
X-Received: by 2002:a05:6512:6c9:b0:52b:51f9:a37d with SMTP id 2adb3069b0e04-52bb9fd2d5amr2767729e87.56.1717787148108;
        Fri, 07 Jun 2024 12:05:48 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:69a7:93d5:5355:af67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215811d49esm91861115e9.27.2024.06.07.12.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 12:05:47 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
X-Google-Original-From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio: fixes for v6.10-rc3
Date: Fri,  7 Jun 2024 21:05:40 +0200
Message-ID: <20240607190540.30622-1-bartosz.golaszewski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

Please pull the following set of driver fixes for the next RC. Most of the
diff concerns a single driver - gpio-tqmx86. Details are in the signed tag.

Bartosz

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.10-rc3

for you to fetch changes up to 64054eb716db52e4246527dc9414377c5bc5b01d:

  gpio: add missing MODULE_DESCRIPTION() macros (2024-06-07 10:05:21 +0200)

----------------------------------------------------------------
gpio updates for v6.10-rc3

- set of interrupt handling and Kconfig fixes for gpio-tqmx86
- add a buffer for storing output values in gpio-tqmx86 as reading back the
  registers always returns the input values
- add missing MODULE_DESCRIPTION()s to several GPIO drivers

----------------------------------------------------------------
Gregor Herburger (1):
      gpio: tqmx86: fix typo in Kconfig label

Jeff Johnson (1):
      gpio: add missing MODULE_DESCRIPTION() macros

Matthias Schiffer (3):
      gpio: tqmx86: introduce shadow register for GPIO output value
      gpio: tqmx86: store IRQ trigger type and unmask status separately
      gpio: tqmx86: fix broken IRQ_TYPE_EDGE_BOTH interrupt type

 drivers/gpio/Kconfig        |   2 +-
 drivers/gpio/gpio-gw-pld.c  |   1 +
 drivers/gpio/gpio-mc33880.c |   1 +
 drivers/gpio/gpio-pcf857x.c |   1 +
 drivers/gpio/gpio-pl061.c   |   1 +
 drivers/gpio/gpio-tqmx86.c  | 110 ++++++++++++++++++++++++++++++++------------
 6 files changed, 85 insertions(+), 31 deletions(-)

