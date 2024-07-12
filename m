Return-Path: <linux-kernel+bounces-250878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E33A92FE13
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CC01283855
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348D3176222;
	Fri, 12 Jul 2024 16:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BU9gJBdS"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CF016EB6A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 16:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720800246; cv=none; b=adWdG7RC92hS7alftx0fzFpK72yD9jIKSuMJygkJUiHD6EPbXOA2nh+8iS1ORJE+0XaR2jkY7uEyjCuTNi6Yo5aTuDLtlveExJOg2Kt3Au9RIBZ+DYNMG3wxYhSyo83pOxhcKvCIrgiXbzxwyaAqJBQZQzrzQHAc1ZWavUUcplc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720800246; c=relaxed/simple;
	bh=P4ob3DNHGvoDf+Ab09PbPElrOsQ+LfpUrw9VboiZdgk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZgogK47r4SPkLouttFqvAJ9MPpur7BKNyt34VoKXSw7OVXqZAsOrz31rplODmLQRkZDjBLZsvv2RbLJy+pAmYa1GjVvjKB6e0ns4w92R94O+zAhC5H5+KiIqWhl80pAEQj0AD9Y7Yj4x26wk3oLZ6gUdqymINTUV7OGkpWsyhE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BU9gJBdS; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-70445f0d9b8so1258411a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 09:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720800243; x=1721405043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4hWTzHco2zA1H+Yf6KhFJuQIO6KQnCWWPpgy+Ns8Ef4=;
        b=BU9gJBdS5vx5ZMWeuJVOxMYVfpk2Q01vP2XJ28ffEDWLksewg/zq8+IaVbvrA77zZj
         DStAt4sO/zA29NikuXIhtNcGLwGp97t2vmw7KbV9Z0vPV/V+bNZNNECf7VUF0CLg3Pgw
         KjqY28/IOZeF/Dk8ENns6k2IeX1CJPHPqSMgZBxVzNMWucaDbwTLVqNtkqLRZFTOHFwj
         ahYQT2UpGVMM/flct8jcITbMT8XSLJADcOb3q86QVstErMjrVTpbJukcowLe011skLoQ
         nCUbURPvb8VeEDDU3ehCgITxeJ+AZU/rnkYoQHBwnzz+9Yc/oF2XqlTZarT0H8nPkmez
         l+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720800243; x=1721405043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4hWTzHco2zA1H+Yf6KhFJuQIO6KQnCWWPpgy+Ns8Ef4=;
        b=KkYv+CMpbq7DHL/hsR9TmXiaOJFASSi50RJtn4TrWQHJuWPI3dESqYs3qtTYEtz2p2
         HbT/GiNromvjbMtxo8dVJkZFOB788SvXL+2tb6ivQn5GS+GWuISoqOzvIB2x74x4r61b
         ffE8ool+kgghL+HcdkTMWGac635PT54j8PB5alZx+K9z3pb6Oqa2xZoy6llO30k555Kv
         BXJQsElLJP3Ev4M7qycjOldoM89R/cuBvtfRY7NtyObaFPyvNg40CA/1IzvBZUBpSwJc
         UtcS/GDjkniSCWODN8hq29DNwfJC0nZRRj9f/BmYL0bdUSysjP+njB/rTah0cnTox7ub
         iafA==
X-Forwarded-Encrypted: i=1; AJvYcCU1UR30kU5cAIgTyqbxIEgCfMXGG43DicIK0g4LizNzk9vZGQLk99QLXdUpKTUgc1iZaCiH1MlgRF5bvthdWEi1NyMQafDoh44FEqke
X-Gm-Message-State: AOJu0YwI0F+BgE4zAxqpSm9NsCO6Nwoq92hNZszM4nnlDSVXju3N4AVa
	y5jZUrnbaNWirsR+75XoJWeare1fWHzfiq0qrSFwkEs/I3npn/vkIcjNBKY6D8g=
X-Google-Smtp-Source: AGHT+IFCqJ3A59Ihz+Gfg/eBOf7wupFOr7aBU0qbjk65rd2ue+xLvcZZiwkaCkV4zEAnRjAPJBxsiw==
X-Received: by 2002:a05:6870:3117:b0:25e:eab:6d32 with SMTP id 586e51a60fabf-25eae783ad4mr9926652fac.5.1720800243107;
        Fri, 12 Jul 2024 09:04:03 -0700 (PDT)
Received: from localhost.localdomain (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70374f78d35sm1615131a34.23.2024.07.12.09.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 09:04:02 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Marius Cristea <marius.cristea@microchip.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Kent Gustavsson <kent@minoris.se>
Cc: David Lechner <dlechner@baylibre.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] iio: use devm_regulator_get_enable_read_voltage round 3
Date: Fri, 12 Jul 2024 11:03:51 -0500
Message-ID: <20240712-iio-regulator-refactor-round-3-v1-0-835017bae43d@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.0
Content-Transfer-Encoding: 8bit

This is the third round of patches to convert IIO drivers to use the
new devm_regulator_get_enable_read_voltage() helper function.

This time, we are converting some Microchip drivers. These weren't as
trivial as some other drivers because of nested functions that need
to know info about the reference voltage, but for the most part, should
be fairly straightforward. And there is a bonus to remove a remove()
callback in one of the drivers.

---
David Lechner (6):
      iio: dac: mcp4728: rename err to ret in probe function
      iio: dac: mcp4728: use devm_regulator_get_enable_read_voltage()
      iio: dac: mcp4922: use devm_regulator_get_enable_read_voltage()
      iio: dac: mcp4922: drop remove() callback
      iio: adc: mcp3564: use devm_regulator_get_enable_read_voltage()
      iio: adc: mcp3911: use devm_regulator_get_enable_read_voltage()

 drivers/iio/adc/mcp3564.c | 54 +++++++++++++------------------------------
 drivers/iio/adc/mcp3911.c | 59 +++++++++++++----------------------------------
 drivers/iio/dac/mcp4728.c | 45 +++++++++++-------------------------
 drivers/iio/dac/mcp4922.c | 47 ++++++-------------------------------
 4 files changed, 52 insertions(+), 153 deletions(-)
---
base-commit: 986da024b99a72e64f6bdb3f3f0e52af024b1f50
change-id: 20240712-iio-regulator-refactor-round-3-17f2a82d2181

