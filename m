Return-Path: <linux-kernel+bounces-247912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C47192D640
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA7712873D9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14511194C64;
	Wed, 10 Jul 2024 16:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WGtZpZHg"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF50820312
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720628741; cv=none; b=cfXfughlY+sqC2PJweCybG7SkZpWPIOIm5WcJiYqwBMLkdW2jLmh5jjo4/eaZNLilUQJQSE1AJHa2CDE0iwBOhjvZBEPpbIgruwIfw6hD5tzGXGMi75AUZbZzKahv2o5bkJOPH+yAhNRwWC8Va+oe+24yOYJoFX0Btw1XDqUBH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720628741; c=relaxed/simple;
	bh=VDMzQNyBWvaX+LyDfnYeOkaGvtcpUr0lK9oczG4+IGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lBnUWJd3I+hMs+UNJjeBDg66yxGQnk4S/lQ+IHPZlfJc/o+zqaT5by282plPas6RiXp4FzC1pvxvbTSNUUjZkvLCgVTw81rjWx0/idl/AdsE/t/fV1Y9pLJ/Rsk9np0U5l1cPE0XgjymKY0RgwCBqescwP1Ag+HM7IPFNwydkwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WGtZpZHg; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42793fc0a6dso6123705e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720628737; x=1721233537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Itoi30as1ngZorM3ajNlP04W8GNqyHTX6dO5FHlioKM=;
        b=WGtZpZHg58HdTTXE8YKlB9nSMP8md21+j9dJNy8OCM9dfiCC3Ve3dB2du/E7ObhIDA
         x31ol+LiPu7uyGxzM4rXhlqTG2Cb8qFHGbc6si24XD7t5OOxRV9i/565fCoQO1+E0Zzx
         o55uv+BIos1YSZCjDv7okJWaUTvPETSim12nKH1w+q4A1ddGopDG91YnW85rJXvAl13k
         ZyutIGhYRAUKGD0tMjJx+1wCtCRJ+kCwmUa1iMbm0DOWaBKY+3xWVO64zekjsLssTg5z
         jMNUrqWRyqBlAtI3dlAN7x9lqWXzqJ7zK3MJpyhwNYIKyg0a5XgC4Qy59tMdIINJXtk6
         RbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720628737; x=1721233537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Itoi30as1ngZorM3ajNlP04W8GNqyHTX6dO5FHlioKM=;
        b=pF2Q38UIub0DesfwgRapA+gspBi00p1lro+a7gs8wzCM/UZGH8dsheJtLbckps+B4P
         dBpayzp2cAmFaFd4b+szcjdBPpkMq7AFqtO2XGZUucLcbXv4FJF87jiibgmzR9A0enOD
         OUOELGHL1bAaB65UGmeA3fcAsTOKVyO5pbT0hAuK85yn/4sMziinlROeLBCUjRsBoEbo
         W25Wc8hF07lfHs9BPdjjpPqdtprc/R+aU4tVZP5qg1gxNpB85/tdsWlxcaVoIGLnXLCY
         oEQ5PUq0cfMiNmM6FseiU0sFRE9o/xHa6zE7+V+4JqyOnoWeosGdzYF+i1GiFH02pQJO
         ndAw==
X-Forwarded-Encrypted: i=1; AJvYcCWIARPMFHen4A6ZvVJtbhX/JHPpnqwSaZlp4JxcdXTsEkROKwQRvBTFNlbVMPBmGggiQP5SLNsFIuiYZ3JotPWLgJ7NMnVULl7bRp29
X-Gm-Message-State: AOJu0Yyc18+F9wK6jk4qtkexNaARcXmnfr415ER2XPMs3BMxVcZxzggG
	ji/7PKzd/dS81tFbILM45pjUhNS4Bkoai9zR69H7oZIUfvrqVDY8qcv3EJz/dRc=
X-Google-Smtp-Source: AGHT+IE1axe6GsiYtkMrCX2P5tM+A5QO04JhIFS46IYKujHwCFH8Z6rIpT9i8hI5EvL/mtX58GBxMg==
X-Received: by 2002:a05:600c:3ba9:b0:426:647b:1bf7 with SMTP id 5b1f17b1804b1-426708f151bmr40115925e9.32.1720628737303;
        Wed, 10 Jul 2024 09:25:37 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:1c99:6356:8466:36cf])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4266f6e09e5sm88693815e9.5.2024.07.10.09.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 09:25:36 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Jan Dakinevich <jan.dakinevich@salutedevices.com>,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [PATCH 0/8] reset: amlogic: move audio reset drivers out of CCF
Date: Wed, 10 Jul 2024 18:25:09 +0200
Message-ID: <20240710162526.2341399-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

This patchset follows the discussion about having reset driver in the
clock tree [1]. Ideally those should reside in the reset part of tree.

Also the code of the amlogic reset driver is very similar between the 2
trees and could use the same driver code.

This patchset moves the reset driver of audio clock controller of the
g12 and sm1 SoC family to the reset tree, using the auxiliary bus.

The infrastructure put in place is meant to be generic enough so we may
eventually also move the reset drivers in the meson8b and aoclk clock
controllers.

Change since RFC [2]:
 * Move the aux registration helper out of clock too.

[1] https://lore.kernel.org/linux-clk/e3a85852b911fdf16dd9ae158f42b3ef.sboyd@kernel.org
[2] https://lore.kernel.org/linux-clk/20240516150842.705844-1-jbrunet@baylibre.com

Jerome Brunet (8):
  reset: amlogic: convert driver to regmap
  reset: amlogic: add driver parameters
  reset: amlogic: split the device and platform probe
  reset: amlogic: use reset number instead of register count
  reset: amlogic: add reset status support
  reset: amlogic: add toggle reset support
  reset: amlogic: add auxiliary reset driver support
  clk: amlogic: axg-audio: use the auxiliary reset driver

 drivers/clk/meson/Kconfig                   |   1 +
 drivers/clk/meson/axg-audio.c               | 109 +-------
 drivers/reset/Kconfig                       |   1 +
 drivers/reset/reset-meson.c                 | 285 ++++++++++++++++----
 include/soc/amlogic/meson-auxiliary-reset.h |  23 ++
 5 files changed, 271 insertions(+), 148 deletions(-)
 create mode 100644 include/soc/amlogic/meson-auxiliary-reset.h

-- 
2.43.0


