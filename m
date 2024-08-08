Return-Path: <linux-kernel+bounces-279244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFEF94BAE3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3CD3B22823
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8994918A6CC;
	Thu,  8 Aug 2024 10:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2Jvz5Ldy"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE22188006
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 10:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723112885; cv=none; b=DwXicC9t2TPWKnLHExGKP263c5NbeF9pQPFrHe84NNFMFOHzAODtSmngvsfUgBHLSyMESC3pPlFk1GCNVLyYIwyIMkoUw0R2MjQvo7drFHeKh5jaMqaSOsxFVymnzTH9e1P2l9B/7bpzerMgMywk+JTGlTWgBrKc8I4GrL6luCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723112885; c=relaxed/simple;
	bh=RjKRijCG2ufoLvhnl64EG+OgM1h0OplxHuh1Hk2SVQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lg3J2ubGzG02QjHumvwT6hMv88JbcjUzffoNa3yjklKwx6eQUD+0vfgjnuFtNlh97XgWx/Jw1mWshJRHBWeqvwaFzGEgCkFPmsgjwisfhhNCp5Lt8jUQpIkcl+oaulQJQYC62P6HUnUw10vaj3U+PwPwkHacISz5o5RyagBW0m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2Jvz5Ldy; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3687f8fcab5so386021f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 03:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723112882; x=1723717682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+ZND/cy3Z516ACCTnpV9ofYo6+loCngOYmYnistIhps=;
        b=2Jvz5Ldy4QvL8rMY3UJ3Wk/jjwZ9CDwhFZZrMI73AzTfS8XjnBO9GgnUyBrZNA+r37
         mnOJoW4Vw0mEpfdUmVJ6v9sK8RvVWZIgJhCMrfLsYn1+Lc5MjCNApG19Fa9UkJB7Ld9d
         l6a4BV5966nSgiMTfVyoqICxYhQJfnRGvOo1cUYXmed0wsusKgzYJOhkF33YCicowZsB
         owHezrz11MM3FRqT4TG9x3DbxpZketh21xqy5EiVWTddCXNRlpi00Y0aa2KDkrrm7Jnb
         rCUMQSTKz9QOBUInCC9OuVG3qFXeH5q7edKzTXUBmdfgFxoqg8HFltAF1yco4af/7/Db
         3gHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723112882; x=1723717682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ZND/cy3Z516ACCTnpV9ofYo6+loCngOYmYnistIhps=;
        b=C817wsYshSVN/BhYQCb3xVPgiGOSQHMQRBvajz4CLnaXNjl6rxqaLMJCxL1KeUZnR9
         svZQRdPPqOkb1XGZxQvcJnRXukHhP0tVoisSNEOqi2UFIgTOLbnpaVxJS7wUQhjKpYfF
         4fTBoGpgpWvL1NrFs29H6o3nIXcAnvly1HcCoXKD3zRslPU7BqBqEOOsvk9lx9a3v1bw
         Dgo1CQnQ4nLWPEku7gnS+vF8+YYGvXYv/icE3tnzZncJKtiWaGS7dsDOfWtPURPKvkEN
         jM25lG6t3XYEay/ifwFEa/9DJYgrtOQwo3SONKfI3ir0aibFqYFYj/2u+8ztkDKj0tWf
         Z1Fw==
X-Forwarded-Encrypted: i=1; AJvYcCUsIj9BnzaBugvQdCEti9TqZdubtgUHMLzHvr6oQLQpd1f8vriGKe7SZaJ4uyA+Ulk2Oy5BDFohH88AMknwEQ0Tcse4v/edzC6Wp95r
X-Gm-Message-State: AOJu0YwT24o6p2I6D7SALXbQ4uKAzV9dZg621Cym51bjPfjhtpqIZtTS
	qMAHgSPf+BE/l2ASUj6HOwMMRSnoT8ksdGwrdGV1tcl8qE8ktW5ok9lkpNpqvvw=
X-Google-Smtp-Source: AGHT+IFYU2RQPPg/KjZXn7ZtFuIvQu6nUFhl4ghGOJZsi+bsUJSY3bvLQMS3+wd7ad+9LDIv7FuIKA==
X-Received: by 2002:a5d:550f:0:b0:367:4383:d9b4 with SMTP id ffacd0b85a97d-36d2757674emr1085501f8f.56.1723112881342;
        Thu, 08 Aug 2024 03:28:01 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:ae7:4e79:8821:15db])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-36d27208c98sm1454596f8f.75.2024.08.08.03.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 03:28:00 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [PATCH v3 0/9] reset: amlogic: move audio reset drivers out of CCF
Date: Thu,  8 Aug 2024 12:27:30 +0200
Message-ID: <20240808102742.4095904-1-jbrunet@baylibre.com>
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
the g12 and sm1 SoC family to the reset tree, using the auxiliary bus.

The infrastructure put in place is meant to be generic enough so we may
eventually also move the reset drivers in the meson8b and aoclk clock
controllers.

This was tested on sm1 vim3l and gxl aml-s905x-cc.

Changes since v2 [4]:
 * Fix undefined read access of the reset register
 * Fix Kconfig symbol description

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
[4] https://lore.kernel.org/linux-clk/20240718095755.3511992-1-jbrunet@baylibre.com

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
 drivers/reset/amlogic/reset-meson-core.c      | 139 ++++++++++++++++
 drivers/reset/amlogic/reset-meson-pltf.c      |  95 +++++++++++
 drivers/reset/amlogic/reset-meson.h           |  28 ++++
 drivers/reset/reset-meson.c                   | 153 ------------------
 include/soc/amlogic/meson-auxiliary-reset.h   |  23 +++
 11 files changed, 454 insertions(+), 169 deletions(-)
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


