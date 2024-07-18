Return-Path: <linux-kernel+bounces-256239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A584B934B53
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1FF6B234CC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B951412C470;
	Thu, 18 Jul 2024 09:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="d/Bri/rw"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D29584DE4
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 09:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721296688; cv=none; b=umGNJAw7vE0Gl+zeAPwaKWXylQa4jJjR6PX5EqGXE0BXLWrDk9ZNpVq1EALAwfGgijg6lKV993MUyOFKC/QmV3d1YJfuPHZCkhulWENpelheH0xFMA9sCO796pgcEFSBuFaWThT/oZ9yxIvKbTtDMeBu+qXIVI/YRfBYhdX8RwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721296688; c=relaxed/simple;
	bh=JmZZOfYeNgwLmbv9ZzZmueAe0OYP+/3+b1TO99PfC5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LOh/uKEMXM5BxAYGWf7wdDC0XeBU9oKujo5OhhTCldePbXUrSsbxAO559a+Af098y3zQzOJIbwGjzVbHFbrpe6rJgLc2oxexirNapNAHlwyVCUNRTx2KZ0eFG5oT+W7q3WJcEXEKtf5bxLNHzR2vgol9LOGCj/ffad8dyPV0tyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=d/Bri/rw; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3684eb5be64so299600f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 02:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721296683; x=1721901483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=apqr4MjpXZ1D4CbWyTpnUc+azdCUdbdHdOC61/0sTcA=;
        b=d/Bri/rwDB9b3xkqiDhdcXpC9RHCJfvMDaT4Dt0wMuLQjTeX01VzH14BgRN3yoxBkg
         rxIQthkCgqWbqEurDT2OFKWXSPoyht/kFjTBpqnjc2iHf8ludFFGgWH35T1UKvJWfnwj
         7zpvIpn6aNEbgWG0q5MLknFtUTyAD/d2N8ddYAlfx8/zjJddcI/+0TV+tHJUOPRRKGbc
         RhfXsp7vfEvhKycPIDrrRHbx5Jlc+6oAyQXwaso+j1HGVr2fM+g4h7QBxnZD8pAhMYcZ
         7uRJ5NPa2Y9sCh5mqeX+pFzbmao5nk+9TdItmn5vh9cndZVcPS4szLgOOWRn2eLbf6i1
         RMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721296683; x=1721901483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=apqr4MjpXZ1D4CbWyTpnUc+azdCUdbdHdOC61/0sTcA=;
        b=ccSMyJBizQEnKGqx/tZRk3Pw6bmE9GkdO8BBCV7TBg6Gj2Yh69LhJrBwzYuoTMIQKE
         u/y4Y9reuMIdMhMqNUzH7Lm+SBzZvOnyzZuZyc/Yd2cfzH8sZh+2XSsH1SANssiBitdq
         kOJ5bW+TnSr3HYgA680d1FOgXNgE/M0GsX5Pvo0T2yIkSz19rg7JkQQ7pydp+1Lw+Ay+
         7kU0A3+RV/PXD6a4FxmTs7aDWoyFYo8P81FRkKt0q3sG/Wsar/SdziyLYPiuv1doX0de
         QANfa38L74OyB8Ajb8Og7UYtcURhawxQNbyMcwL6eHZAiLN8Kgwe74CwDHrBW4t8Ou2t
         1P7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQQyZ2wwc/cC05uBK7NUWOm2FzONNw/xVOmDqH18+fvkoQZ7hcpultqFAZwWNK5GdNHHu3CA5sfYzu3dxRJCmQ4ddpN9r+kmsE9zXx
X-Gm-Message-State: AOJu0YxH2bdpnJMPFFoUx25iUsQj8WeE7gzh3MUiSV3fpa2tpQPou19f
	G+rkf/0L+gEDJcSZbWzAOcnr42ONJtyEdNhupd3KUvc8vEqUG7M1ExSYzfGSw6Y=
X-Google-Smtp-Source: AGHT+IHPLDzIfgK/BifnQdo6doJOM8/tpFYJfvzun4tqGe+2vBGATojTwO9cCkzNqJXzETloX+A32Q==
X-Received: by 2002:a5d:59a2:0:b0:367:9073:3496 with SMTP id ffacd0b85a97d-3683160e527mr3553248f8f.29.1721296683409;
        Thu, 18 Jul 2024 02:58:03 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:8d37:f44a:c212:e320])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3680dab3be3sm13837155f8f.24.2024.07.18.02.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 02:58:02 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Jan Dakinevich <jan.dakinevich@salutedevices.com>,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [PATCH v2 0/9] reset: amlogic: move audio reset drivers out of CCF
Date: Thu, 18 Jul 2024 11:57:44 +0200
Message-ID: <20240718095755.3511992-1-jbrunet@baylibre.com>
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

This patcheset alignes the reset drivers present in the reset and clock
then adds support for the reset driver of audio clock controller found in
the  g12 and sm1 SoC family to the reset tree, using the auxiliary bus.

The infrastructure put in place is meant to be generic enough so we may
eventually also move the reset drivers in the meson8b and aoclk clock
controllers.

Changes since v1 [3]:
 * Fixes formatting errors reported by Stephen.
 * Changed parameters type to unsigned
 * Fix usage of ops passed as parameters, previously ignored.
 * Return 0 instead of an error if reset support is absent
   to properly decouple from the clock and have a weak
   dependency
 * Split the platform and auxiliary modules in 2 distinct modules
   to fix the COMPILE_TEST error reported by ktest robot.

Change since RFC [2]:
 * Move the aux registration helper out of clock too.

[1] https://lore.kernel.org/linux-clk/e3a85852b911fdf16dd9ae158f42b3ef.sboyd@kernel.org
[2] https://lore.kernel.org/linux-clk/20240516150842.705844-1-jbrunet@baylibre.com
[3] https://lore.kernel.org/linux-clk/20240710162526.2341399-1-jbrunet@baylibre.com

Jerome Brunet (9):
  reset: amlogic: convert driver to regmap
  reset: amlogic: use generic data matching function
  reset: amlogic: make parameters unsigned
  reset: amlogic: add driver parameters
  reset: amlogic: use reset number instead of register count
  reset: amlogic: add reset status support
  reset: amlogic: move drivers to a dedicated directory
  reset: amlogic: split the device core and platform probe
  reset: amlogic: add auxiliary reset driver support

 drivers/reset/Kconfig                         |  15 +-
 drivers/reset/Makefile                        |   3 +-
 drivers/reset/amlogic/Kconfig                 |  27 ++++
 drivers/reset/amlogic/Makefile                |   4 +
 .../{ => amlogic}/reset-meson-audio-arb.c     |   0
 drivers/reset/amlogic/reset-meson-aux.c       | 136 ++++++++++++++++
 drivers/reset/amlogic/reset-meson-core.c      | 140 ++++++++++++++++
 drivers/reset/amlogic/reset-meson-pltf.c      |  95 +++++++++++
 drivers/reset/amlogic/reset-meson.h           |  28 ++++
 drivers/reset/reset-meson.c                   | 153 ------------------
 include/soc/amlogic/meson-auxiliary-reset.h   |  23 +++
 11 files changed, 455 insertions(+), 169 deletions(-)
 create mode 100644 drivers/reset/amlogic/Kconfig
 create mode 100644 drivers/reset/amlogic/Makefile
 rename drivers/reset/{ => amlogic}/reset-meson-audio-arb.c (100%)
 create mode 100644 drivers/reset/amlogic/reset-meson-aux.c
 create mode 100644 drivers/reset/amlogic/reset-meson-core.c
 create mode 100644 drivers/reset/amlogic/reset-meson-pltf.c
 create mode 100644 drivers/reset/amlogic/reset-meson.h
 delete mode 100644 drivers/reset/reset-meson.c
 create mode 100644 include/soc/amlogic/meson-auxiliary-reset.h

-- 
2.43.0


