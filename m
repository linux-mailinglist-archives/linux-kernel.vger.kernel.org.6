Return-Path: <linux-kernel+bounces-264247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A54293E0BC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 21:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BE9DB214D5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 19:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B6A2BAE8;
	Sat, 27 Jul 2024 19:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="oAR1iXyq"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6888B1D69E
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 19:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722109518; cv=none; b=Wcz2ZQ3bLBLTRXzCWRsjyhKTZjm8oyQV7ggZpzkQNpHzfKjCDARHpAdfZZXXV8SVmmCkY9oKczg1TC5NYFX0obSQE71TEPt3hV6KDIowmrWYj3mdc4mvjULDtDvYWAqbd5dW02vdF2o4Io5QcLTqvUZzDOcIYV6i3LpCqljF4JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722109518; c=relaxed/simple;
	bh=Ys8jpFhJ6wVpL85Kq5iGVVH2LBWXP5tdPOwBXVjy4h8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KCb5g4dTEAA8fHDZmZozm8aC5wHR4vYenaLudA3vOfNWmVTnn3J1rTbJjFzxnV2tqJHXmEXsUWFCchZS4526k0Bi6Tfchd8OEwXIQgRvNCOtPOr4m/1SfdHjdJdbnuJCTo9Hgh36R7tx+sHrSOUAfwiTFbM65wPBe85ACVHK85k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=oAR1iXyq; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4266dc7591fso5502345e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 12:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1722109514; x=1722714314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RrDTas98pBu0wGaxfBeY4MXiXoO3QUidF6ItBOkKdCQ=;
        b=oAR1iXyq4pXaV2776ugwMFZCuY6DnaHEL077DdQN7lCrb1n3omXgh9e+QanvXAAcim
         tYLr3TiIK6W4qYU9+jX/4WQDU7OWLoCzRM6JUg1v4ERw3Oec//iRnwbVK+mskzmGxGRn
         K4KpqRbdOH/lAWY6lYQTwWM35WHfSxtoXKaNz0de0fMjrI3hCH0Xa8w/N1hJKBSYYz1b
         rEIgAwWwH1mIGgtEtHCEqJs3p0Xo/YNP+OcOUazFISz41odmlHN6FW0ta5AHhbWQE9pQ
         5VVtsIh0JnKGQZJip2ebu23O6u9CI1J5GeyTLXvBT873heTPLk0u96y8F0GuHUEN6mw4
         pWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722109514; x=1722714314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RrDTas98pBu0wGaxfBeY4MXiXoO3QUidF6ItBOkKdCQ=;
        b=Wioup5oojxPTvnad/pHC4LXuFZ1G2UMqhKdUZdvoQ8ITB5d4YwJb+sXk6SIVeOV0/g
         NOkFPdklgAYck/bBnJzECr1fmy3fyRavKYntmcipmUeWxLQ7syqHOmrhBcQlYO7j6DZ5
         J9/zDdgfcFt/mkieHKy8vChaeAL26h2aErUsbjfh3Hfxy/wcHXuw/clV+vQGgN7IfMXj
         9leJGoqZHM1wxKnM8+fZnNekJtggTAgWgiSFuLma4nNS1pHnZM7kDQeUMO5GnLby8Nrb
         J+2nFCKXbTuDsHDHcdSfPjQR6i2L6umkw7yREPoh4C06fmq+sZnJCEekndKvJnC3xv/j
         O3mg==
X-Forwarded-Encrypted: i=1; AJvYcCUtljhTrtaSEiPO6B9AP8enrYWV16fPix7hks8YVF1Mbyuk23Uoca4LE6r6M8DwR8yOQPkp5/+gWLx4ttY7+4nGmjwMCFY4JRdtXxRs
X-Gm-Message-State: AOJu0YwM67ta6yoAYlf/IGh4GX0SEEqKMkZpFNfNcQRL9rszWM3QEpkr
	JP7Zs+lln6Pobo7oHkuJ7vhcWFYP7kTBCvDT8+F7+h+I4sR7E8SJX8daQMQsyTv7gIBuzT1VVDM
	Y
X-Google-Smtp-Source: AGHT+IG9Jw7eBdenAV6HXldMRTnnGFgXgz7V+8Sa6r7njTBGXz+xHtf7DXeaAX5M4Nck7FYukoWKrw==
X-Received: by 2002:a05:600c:354a:b0:426:6c70:dd9c with SMTP id 5b1f17b1804b1-42811e0b770mr22159115e9.31.1722109513570;
        Sat, 27 Jul 2024 12:45:13 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:492:8758:7b33:d2a9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428057b7218sm122354125e9.47.2024.07.27.12.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 12:45:13 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio fixes for v6.11-rc1
Date: Sat, 27 Jul 2024 21:45:10 +0200
Message-ID: <20240727194510.5454-1-brgl@bgdev.pl>
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

Please pull the following fix for the upcoming RC.

Thanks,
Bartosz

The following changes since commit b3c0eccb485404d3ea5eaae483b1a2e9e2134d21:

  Merge tag 'gpio-updates-for-v6.11-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux (2024-07-15 17:53:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio-fixes-for-v6.11-rc1

for you to fetch changes up to 3ae08e47742eeebf2190900d31ddac53fdd13a5b:

  gpio: virtuser: avoid non-constant format string (2024-07-19 16:56:27 +0200)

----------------------------------------------------------------
gpio fixes for v6.11-rc1

- don't use sprintf() with non-constant format string

----------------------------------------------------------------
Arnd Bergmann (1):
      gpio: virtuser: avoid non-constant format string

 drivers/gpio/gpio-virtuser.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

