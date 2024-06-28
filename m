Return-Path: <linux-kernel+bounces-234338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD8491C570
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31FB4B2529B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E30F1C9EC6;
	Fri, 28 Jun 2024 18:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJGGwwdF"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1117ADDC0
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 18:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719598144; cv=none; b=ZiZ0fBXGkL6O9mpEtXseoPekwuEGbYlk03nJUaUoi2E8BxgYXyo2j5ZFsCokH5Alhh9l2zIIU/locn63ahFG+6evdtyTkrgGGgmENtCRtVq7pt9Fo99FFN1TJjQG0jwMI4TqyJWTlH8Pm05MJXEjHn7QtQ4FL3A/VKhaH7ekTJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719598144; c=relaxed/simple;
	bh=LkC+AyRW6KOAweUkexREBddR2bp/ahp+8M6DIK9SAVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E1ZvmUmrE6NTqKUkNs7amKRUMtTuefxwlZ8rfQhe2yNpu23wk5z0XGuArDo0n4BVoF62wKwWWpV9qGYiyTJ83ELZ9RMR7DyruTeSqQWkZNqcgIQz+Ws6a7DLFXr9LxRtSLncDdm5Y8uuy4OFlNf0vY8nShIfZGk8ds5QJlAev2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJGGwwdF; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-707f9c3bd02so776525b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 11:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719598142; x=1720202942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gLbYfpHailMRml8tkooKFu5Un3e2ZVQ3TTsmePLSQUo=;
        b=MJGGwwdFvogAfON4PIOsPzZAkYMYHZC05ZsubI2HjJJPyerLAmirY2Bo64kDtmb6Wc
         Q53zG/8nO0avKZ754XN2YazfG1fDDI903i2AE1SZE+A5f2hYM7+NvJhf1uJ+bEuKYEwr
         4jUOXAe2DGcT9IgtGyzIldgk0b49Tzqrh15qE2uybTagrdNEaDLITRqIpR13buTk5f9C
         wHluuy8k6YwGrzSE+UUc3fLw8w9lb+0X2TV+A/5dOO4HCTiHef8I2VJYKPQPpm4OU1Ag
         YVhNIy4yoRv/i1aYaNXIvGIydM78dbnjdgvgueko6alQDrtmgfYd2Lv0+bzK0B+O/qoB
         sb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719598142; x=1720202942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gLbYfpHailMRml8tkooKFu5Un3e2ZVQ3TTsmePLSQUo=;
        b=uFvaoraw+noY9v0PWSewZgC7IZ+urhwL44sQSzF/wXyPkMqE96X/U7mNemshXS9nk9
         MEZI8jlx5ZiVgSiuPaGvuQImM7QVul3mZf3jt4SjLTc8BQcw4GwGuZtfuswG6vk+ciTL
         WxGm0td+lGts42lOwGiQvCbTuO2BSPxGemJ05RuUx83Y10VGTnB0iErMFXAq8nQLfEGs
         YrhY7UcdI7meW5TwZCVJFytHq+N+suLnYbE/ovKObr3+MEz/Gtizn6hd01JZmu0nW/bC
         nJVZlFpuAiEVsBDj40gz8HoECtoqsNLhMcsMpM8/Hvo5us835VLEREm8F8SqqWnD6atQ
         UOpg==
X-Forwarded-Encrypted: i=1; AJvYcCXKMgTfaoYgMpOBlnlmGMIPKWHkd+583NZvu2C/Gdc5b9avLZ2zBNVILIL4l3HgQANCklECqI7ov40J/dWrslE8+022NleHNndKip9S
X-Gm-Message-State: AOJu0Yy7Cdc0osmCGTFL9902VToXZPmLcCjfuDXcvpRwgKHp49K179I9
	laugoHcBWrzdcQg5Q0JqTRg7S7eI77IgpHPOf+YB542QV9MQ0KDa
X-Google-Smtp-Source: AGHT+IFbkw/YIbsa2PVh7LWrxn8qvAeoCj2gyLAqUcrhU9vdDH2p3fp08Z8dbHZsDhlcNXfAx9MKCA==
X-Received: by 2002:a05:6a20:baa2:b0:1bd:2520:1fa5 with SMTP id adf61e73a8af0-1bd25202067mr9679591637.4.1719598142077;
        Fri, 28 Jun 2024 11:09:02 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:c929:2998:720d:a104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080295d1f4sm1982911b3a.91.2024.06.28.11.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 11:09:01 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Haojian Zhuang <haojian.zhuang@gmail.com>,
	Daniel Mack <daniel@zonque.org>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	soc@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] ARM: pxa: use software nodes/properties for GPIOs
Date: Fri, 28 Jun 2024 11:08:40 -0700
Message-ID: <20240628180852.1738922-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series converts legacy pxa boards (spitz, gumstix) to use software
nodes/properties to describe various GPIOs instead of relying on GPIO
lookup tables. The benefit is that structure and behavior is closer to
DT-described GPIOs.

The very first patch ("ARM: spitz: fix GPIO assignment for backlight")
is actually a fix that IMO should be applied sooner rather than later,
the rest of patches are enhancements. The reason it is sent with the
rest of the series is that later changes contextually depend on it.

The last patch ("ARM: spitz: Use software nodes for the ADS7846
touchscreen") soft-depends on corresponding changes by Linus Walleij to
the ads7846 driver in input tree. It compiles without it, but the device
will not sync with display refreshes. I have created an immutable branch
(branched from v6.9) at:

git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git ib/ads7846-hsync

in case you wish to pull it in.

Regretfully it was only compiled as I do not have access to the relevant
hardware.

Dmitry Torokhov (8):
  ARM: spitz: fix GPIO assignment for backlight
  ARM: pxa: consolidate GPIO chip platform data
  ARM: pxa/gumstix: convert vbus gpio to use software nodes
  ARM: spitz: Simplify instantiating SPI controller
  ARM: spitz: Use software nodes to describe audio GPIOs
  ARM: spitz: Use software nodes to describe LCD GPIOs
  ARM: spitz: Use software nodes to describe MMC GPIOs
  ARM: spitz: Use software nodes to describe LED GPIOs

Linus Walleij (2):
  ARM: spitz: Use software nodes to describe SPI CS lines
  ARM: spitz: Use software nodes for the ADS7846 touchscreen

 arch/arm/mach-pxa/devices.c              |  53 +++--
 arch/arm/mach-pxa/devices.h              |   5 +-
 arch/arm/mach-pxa/gumstix.c              |  24 +-
 arch/arm/mach-pxa/pxa25x.c               |   8 +-
 arch/arm/mach-pxa/pxa27x.c               |   9 +-
 arch/arm/mach-pxa/spitz.c                | 284 ++++++++++++-----------
 include/linux/platform_data/mmc-pxamci.h |   4 +-
 7 files changed, 208 insertions(+), 179 deletions(-)

Thanks.

-- 
2.45.2.803.g4e1b14247a-goog


