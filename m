Return-Path: <linux-kernel+bounces-540502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E00A4B163
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 13:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0EBE3B2FEC
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 12:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C34C4C85;
	Sun,  2 Mar 2025 12:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="vVEwMdHV"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4092F1ADC6C
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 12:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740917068; cv=none; b=Chxlxic5iawp4mue2Iz0wCVlsdmmvKItbSdTg8eEWuj1Rjcr8SMmUnxBercWRnXFDI2JmoUkAD/yceizfThOwoWImagkSSrT67yOEsVDr33uaNPRSwgLms7UkktD8BfhTdJIh96Ox7V6hto4x5ngn6dQKYlX5zoSdivER4c5ZrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740917068; c=relaxed/simple;
	bh=JY2SMHuBAeQA5ymjsS5TI2bhfemIjAsjx0CTHtgqxv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jZ8ItPLPCBvUVB6so5LxKW915Cx2FyQK1j0Dd5X1gMcUK8jrmr3dvs7dMr3/nRiMSwPtHc22vhOjkNqJB1ZTgx9+pCNE/LIKUiion++6yS7TA7vdOW4rh3nF9zp813GWC67zzj7PISimcYtVnsUnPzUrq7mo41hE58E3M3rMcFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=vVEwMdHV; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4398e839cd4so27971965e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 04:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740917064; x=1741521864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E1qy2jLougotV3caTX4Ep2cJ4NAMVmZ8tLXJeXGlG68=;
        b=vVEwMdHVUQlSITNi3K+AfdgGK9jwdHrfAjPio47pfPuyd0IQevJ5cTicHKcZi/vw11
         dwPTQ6O9lveA171y9jwcG7jQKF+I5c4WMPFOy+6cqJR5uwIrSg3WB2mQusfWJlhftjQ8
         xcm7gQRAauWyAkL9tQ8EhJ0zLPmdejE91w7Ja0qfaXVUh9a+H2hEQ3QOfnQdR4/6YnS1
         dyzBJtMbgocRxo/zABmLwQfljGdCLzNoeafOwO78mNmHUnSRw/NdAHbJ+4zjSvG8Hf6A
         lb0Y64BHwos/oLJ+IOYzqhjKZ1waOrDElt0yZzyYHytvj8vxYZwsExZ6jJD2cHZlDGSM
         YAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740917064; x=1741521864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E1qy2jLougotV3caTX4Ep2cJ4NAMVmZ8tLXJeXGlG68=;
        b=F7DikFdKRvcxp4EOg9tJdh3LVNl2ksHl5KrEUtzukqADkInGQ/CMD1RKFwduKfLVng
         l3MWYTx4sU3HKF5PpynLK3GEzH6mg3dMbSNxukdJ43Di6HZ/q+K26+a8VJv+189Nh15u
         3HCigmAppSecWFywsDh/lsA7D/yObidXB5Zo0eda52/AvOV1p3iHHj2VKy+pHTwrg6A+
         XDmRvwSBii+rJVqFwnnYP9OfNDbD7j5u57xFhs106QBx2xWjkm1wLBOXcYPlRFXGwCMi
         qT9gKqL+071ZCEuZSt+TTKt2O4J5Niwz3qhFJH1KrcUgiqvoVaoX3ONRpUvT+BXXyjEy
         N7pg==
X-Forwarded-Encrypted: i=1; AJvYcCXQuGyQR4bqDgTafGYUZIkvi8g5QK1dD1Vygac3chmtziYYIGxVD9rw3Dj0kuZRzB0JomLnC9atUrGBuHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuVTs6BMhLLQYRt6ygSudZ489YkdFMCqXmlXtR9HFFOdahF//z
	rqpaX4sMBvH2bMgZ80UIeRVtaGtO7bU9+H9JFgSfyBRq/PxkLCz4xtD6Tr5E9os=
X-Gm-Gg: ASbGncvBAEAY9Bao+8qTym+OLbnXCE++9ddu5EsmECbCN69LevJytx/nEv0q8SEg8o0
	BLCK31yMUqTmDiU8uw8B0YdQvEpFecUbx/Za+uCOvxoq/5WsuofBV217EB2ytwiIc5hw4ZMh3/f
	/YiA7GcADmMsb8FP4G0UEB/HqFIanJW/6xCKijjLlVs8d5NT3jecuukuErr1Coboh6g8ARdKjwt
	oqaI0vOA7+uvGU27wEGz+3V6HG2yqh7jpI+4QV0I0vTKEyxdkCoKoQqC7TdPeHgYsfpc1HFI3nJ
	OzPOpeo45XtvvEqeAOErH1yLg4XTYEKd5SnahOaQJwgAQIkXwwAfo9mWO8qYCW3hrorLxLm1GqQ
	nQTG9fEtM37GK9icD/9WGm0FH1p3y
X-Google-Smtp-Source: AGHT+IHR3hYe7lOWShj1M4Lnoxwgm4CAjYEMp+mZTw1yhNs6P9tuRCYrU+0kbP1EGX8xC7w5mMYf4A==
X-Received: by 2002:a05:6000:188d:b0:390:f8b9:7b18 with SMTP id ffacd0b85a97d-390f8b97d3emr4041145f8f.12.1740917064292;
        Sun, 02 Mar 2025 04:04:24 -0800 (PST)
Received: from brgl-pocket.. (2a02-8440-e500-b74f-e98c-3c2c-6d88-f923.rev.sfr.net. [2a02:8440:e500:b74f:e98c:3c2c:6d88:f923])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7d69sm11436906f8f.60.2025.03.02.04.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 04:04:23 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio fixes for v6.14-rc5
Date: Sun,  2 Mar 2025 13:04:10 +0100
Message-ID: <20250302120410.5600-1-brgl@bgdev.pl>
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

Please pull a follow-up fix for a previous commit that introduced a
potential crash and was already backported to stable.

Thanks,
Bartosz

The following changes since commit d082ecbc71e9e0bf49883ee4afd435a77a5101b6:

  Linux 6.14-rc4 (2025-02-23 12:32:57 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.14-rc5

for you to fetch changes up to 64407f4b5807dc9dec8135e1bfd45d2cb11b4ea0:

  gpiolib: Fix Oops in gpiod_direction_input_nonotify() (2025-02-28 16:30:48 +0100)

----------------------------------------------------------------
gpio fixes for v6.14-rc5

- fix a buggy get_direction() retval check

----------------------------------------------------------------
Dan Carpenter (1):
      gpiolib: Fix Oops in gpiod_direction_input_nonotify()

 drivers/gpio/gpiolib.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

