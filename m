Return-Path: <linux-kernel+bounces-181202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E69AB8C78F6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DA81281F40
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01FC14D2B7;
	Thu, 16 May 2024 15:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tLq3oeZx"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFC8146D7F
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715872131; cv=none; b=SxlqIYr5IYR4ja6sRgQ2HzxQ8iXCqJ6viCqhdSs7CbY+8h4/g7xsgOCRL45G7AqrtvIzs0t3GVJuBWpgcZGwPbN/2tGUxKX/lOi9cPFJdUZWR/ptotWDcZKvxOkTvEBC+4lVLvicTERxawHYMqFw21RT+sf0sFfKQSi+5zwunBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715872131; c=relaxed/simple;
	bh=we6lbVPR1oC6Gjni/0inzK6tb5qWDsUccHkewq+P1B4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NDaBHP+L0eZMyKZ2cpJtR97J1LqA8K3jM9qAiPNXwhW0wiOvOc6RjmkIO4BNVn90+sEBJhMnL8B6O3IR1fc+XcsTHcRRVENbUqyhy/2sB6zzxV6NK8E4wz+EvSDeuBfts0ldcS5yXGjTiVmopumrMn4bC6XGilSEyjzkff017dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tLq3oeZx; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e3e18c24c1so10088181fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715872128; x=1716476928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7ioxEy7SZPKbhBowmAqXOs3HJ/6GyUDvxxnPo9F3uNU=;
        b=tLq3oeZxCaCNzKGURu5K7x5Ai0VxzLyGpn5p2sR0zr8s7gc+2/sM0b5ogjvVDY3vNT
         xp2y9NhdZRzGWHLuOpiVXM+7EypwGqEHMVjWlh3YzXjGap6Hq86fXuLPOEK/3eKYit+c
         q+6y4N7gt05tnR8ZitYVsRIb5kgRV3PMtnC2/rhkOroR+AVjt3H9TGjawqCGtHSIuImH
         lLvJZmU6ExW4vqpUD3ppeQmdj1kvnGkGQG+7sN7kJKS997QKTFBSRsxqWPtI9VCVxDrA
         rL+qpEXx023uS8v6kT7kwc+kjOrGKgqZwktPQdnva2CG1v4HmTUvRP2GUGZDKqxsSSto
         ZLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715872128; x=1716476928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ioxEy7SZPKbhBowmAqXOs3HJ/6GyUDvxxnPo9F3uNU=;
        b=jj5upE/iUN02TqnkK1CCx4cxLhrufc0Ib5gj9Fc1B/oQgMyq3K/3SYxba3kgVzvhR9
         FiPfpnFylmw674xsqBKQawKnJTTFl1aFS2GhnA57wF1YU/NGDHxeWCf6nkcAwaXiebB/
         qIS3sLV+WcG9eohdtfgaMnZMpuFjB/ZupLDO99goUijUXbefvkPgn+kMKPjmnNv+/W0a
         yOlWLoJif4F5IXYBSNQsbRnPme4s2zQMuueETAAxpXgZfYIkuYoV2j0kjIZ2ajkR6aqb
         g0qiwK8GIZTDfZbfhA1+ky9oQ+gyVCEcxiJOymBgxs1ZMY7al8tyMfmhg5lxrWI1Uaca
         /lHA==
X-Forwarded-Encrypted: i=1; AJvYcCWVS4slJb1aPg9SqDYR4PGYEYt4VjNTEqcxwwzLlkBxSRwPrbY489lg9q1TA8RAMhWkqQeb8FsH6bwb4GbRU7BazgyST2rM/54ntoX8
X-Gm-Message-State: AOJu0YwKm3c3kic9uKBEvhKkYY+DsRxbvLwnuIQujQe1tAAYw19hBNM0
	ar/qjqA1G1pCV11B2nj4vAZ09nd3dBJb8hkUHsWWcOIdWgABNTgmIr5G4bSf5WU=
X-Google-Smtp-Source: AGHT+IGKctbnPBmcJ2QPLjHUp6edy8mIEVUT9pkFFtdxGM+N329/NRHhlQe7LdHxvECgOEtFtlKB4A==
X-Received: by 2002:a2e:4a11:0:b0:2e5:8720:50d2 with SMTP id 38308e7fff4ca-2e5891d3b9dmr83515781fa.0.1715872127572;
        Thu, 16 May 2024 08:08:47 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:1fce:7e5a:e201:edd5])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-41f87c25459sm309351725e9.18.2024.05.16.08.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 08:08:47 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Jan Dakinevich <jan.dakinevich@salutedevices.com>,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [RFC PATCH 0/9] reset: amlogic: move reset drivers out of CCF
Date: Thu, 16 May 2024 17:08:30 +0200
Message-ID: <20240516150842.705844-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

This RFC follows the discussion about having reset driver in the clock tree
[1]. Ideally those should reside in the reset part of tree.

Also the code of the amlogic reset driver is very similar between the 2 trees
and could use the same driver code.

This RFC moves the reset driver of audio clock controller of the g12 and
sm1 SoC family to the reset tree, using the auxiliary bus.

The infrastructure put in place is meant to be generic enough so we may
eventually also move the reset drivers in the meson8b and aoclk clock
controllers.

[1] https://lore.kernel.org/linux-clk/e3a85852b911fdf16dd9ae158f42b3ef.sboyd@kernel.org

Jerome Brunet (9):
  reset: amlogic: convert driver to regmap
  reset: amlogic: add driver parameters
  reset: amlogic: split the device and platform probe
  reset: amlogic: use reset number instead of register count
  reset: amlogic: add reset status support
  reset: amlogic: add toggle reset support
  reset: amlogic: add auxiliary reset driver support
  clk: meson: add auxiliary reset helper driver
  clk: amlogic: axg-audio: use the auxiliary reset driver

 drivers/clk/meson/Kconfig                     |   6 +
 drivers/clk/meson/Makefile                    |   1 +
 drivers/clk/meson/axg-audio.c                 | 108 +--------
 drivers/clk/meson/meson-clk-rst-aux.c         |  84 +++++++
 drivers/clk/meson/meson-clk-rst-aux.h         |  14 ++
 drivers/reset/Kconfig                         |   1 +
 drivers/reset/reset-meson.c                   | 210 ++++++++++++++----
 include/soc/amlogic/meson8b-auxiliary-reset.h |  17 ++
 8 files changed, 293 insertions(+), 148 deletions(-)
 create mode 100644 drivers/clk/meson/meson-clk-rst-aux.c
 create mode 100644 drivers/clk/meson/meson-clk-rst-aux.h
 create mode 100644 include/soc/amlogic/meson8b-auxiliary-reset.h

-- 
2.43.0


