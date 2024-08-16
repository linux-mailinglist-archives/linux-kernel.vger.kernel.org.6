Return-Path: <linux-kernel+bounces-289407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEEE9545DE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40A031C2438F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E0420E3;
	Fri, 16 Aug 2024 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Zsj9ssTr"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75542143C72
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 09:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723800871; cv=none; b=gqD36gM29rPTKtqFycKnacdjaFquv0z63jbZ3RBDZaSHlPt1zhmLpdWhRElHwVYbrgqGnJgfU84ho37L1iY232j9XH6W08kmXRrICbPGgHScJ6GsQU/3KxpZAlCf+zXSojqtTTARModacYsbSf+asJXrs2E1mCcfM4uKRtgnpHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723800871; c=relaxed/simple;
	bh=G+FeStMU2scmZhdWu0qFXGPtfM2I8vVu2NtqTriWF/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rhFRperxIOSyZ/bISD1wO1VH7BXlpwfMbeo8RPHei0YhlihzxKVYvYjWII5bEnnr8v6NKSl814dMMp36K9OCeetAsE1ElLkXL+ht6Idd1qe4t6aJ5JW58j5oHNjFV5Tnz945GI2qWTEdl3Jb4nkpjfcAabSCm1/hAMT3FfWbLvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Zsj9ssTr; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-36dd8a35722so946761f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 02:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1723800867; x=1724405667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vX9qDv+2qVxfqHPc5bssG0UIDXBfDyrqbrBJRY4zjpE=;
        b=Zsj9ssTr4NXverPgL/1SD2t/C+/XXFm+YIoM3YoJ1/V3InpEVEQAPUJTM84OEYP65Z
         4ifwHjwck/Y4qOLfhdCHUxivApzp8cJG04bQ9oE/kDcFkvAVHo/O4/F9eaXD++4mzYMo
         /TAtQDTAjAJBZpo2l1Vy4fdP68vZHa8Hjp0vh27VhLdRG+BIgvAni+3YPb/khUn11hPR
         pa2CVrfVrB366iFVcft4u7ZDa55RIWDKIkhInWb/Jwpi5MRkCr5O5NmxAOJLlZBp8fFr
         DFeq9BWjUvSLEKmk3w7hTSLl1Bby+/iF7Lg2D5hUmA/lvIyUcSGVnG6p8b7HXgNLytIB
         fpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723800867; x=1724405667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vX9qDv+2qVxfqHPc5bssG0UIDXBfDyrqbrBJRY4zjpE=;
        b=lzZlLjbcSdlPNfhAV2btCY+FemCHRNfspxwkzY+KMUjRkG8BTuor7BKH/gdMJmWXD9
         027oqd6Puy7I7Wa3zn7rAmO0CnaqNsb2NHiiCalZ0W9NNd2C03oqijkwDGgg/rQkefB2
         B2Dl7gAYZgFXkBtCArV0qRk7bbr0iHI5YJ8QBz8rxmW+WTLRXAhNg5/QOyGDlE1IOuY7
         1ZPRz2Iu7k+P+H07Sey9rcj2gQE8YbTBzjF9lQNDzFGmrBK2A5hqIEkC+N37aV6IOC5A
         Wr0C3DsWqM6ha7/HJOIaCICYAC5FJqyNWQcRzkRQIFME8KAuLqdouW8V2gQr1yJWp6ci
         Iheg==
X-Forwarded-Encrypted: i=1; AJvYcCWb1mCDEn6q7Uojel6IzSp2GkCtAmcRzS9GojIy9FM1/d7k0/ASDf6g5EVXJ2M/dIUZ94ankw/l9HVCOZdCX383vWn3Zj18h7N28EX6
X-Gm-Message-State: AOJu0YwrM17iBLAm35zJwnzMjZicY+zhjclp0UpWZH13smKwbtqVGnMr
	o+7vV4XCmn3Sk3X303oRfKrhT6R/jsB7a/waHRta2I9XZ8Docu+nLtGI79K6H9c8mLfYBQsMJ7c
	De50=
X-Google-Smtp-Source: AGHT+IGgtC2cxTMbZif7IqcMevbWdY6uWFHd/nzCSbeVPSEnWDm3kqpPbo059EvqeLFokloCeitP0g==
X-Received: by 2002:a5d:51c9:0:b0:360:9cf4:58ce with SMTP id ffacd0b85a97d-371946a44c7mr1123283f8f.46.1723800866069;
        Fri, 16 Aug 2024 02:34:26 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:aff3:cc35:cd8f:c520])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718985d9d6sm3212232f8f.64.2024.08.16.02.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 02:34:25 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio fixes for v6.11-rc4
Date: Fri, 16 Aug 2024 11:34:23 +0200
Message-ID: <20240816093423.12622-1-brgl@bgdev.pl>
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

Please pull the following fix for one of the GPIO drivers for the next RC.

Bartosz

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.11-rc4

for you to fetch changes up to aad41832326723627ad8ac9ee8a543b6dca4454d:

  gpio: mlxbf3: Support shutdown() function (2024-08-10 21:35:16 +0200)

----------------------------------------------------------------
gpio fixes for v6.11-rc4

- add the shutdown() callback to gpio-mlxbf3 in order to disable
  interrupts during graceful reboot

----------------------------------------------------------------
Asmaa Mnebhi (1):
      gpio: mlxbf3: Support shutdown() function

 drivers/gpio/gpio-mlxbf3.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

