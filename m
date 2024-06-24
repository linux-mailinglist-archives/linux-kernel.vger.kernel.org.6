Return-Path: <linux-kernel+bounces-227872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB6E915799
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 335401F24257
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2ED41A01B7;
	Mon, 24 Jun 2024 20:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HivL3pT0"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663951A01D8
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 20:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719259851; cv=none; b=B3OFpP8hrlFd4pmqNrIFJmNeu4WY+p4Tvw1sa5TA4kb+CZ5BLRD5Y6PF94USTTvNvjI/zHhmHmb6HdYfqNVG8SHIT8f21h2Mi9DqPisjwQAcZv7gu3ZoyEe5pJnzU0lYTZH4mj0QZcIWibyguMAJkMNjiYRb722s4dxancy48Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719259851; c=relaxed/simple;
	bh=otfJwyiaR/AMSfrCJ52iqaJM3hPrIVZyQW79MujtIEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BrApmN/P27nJoJhR6xBOxqryILdXgOQyOJGARdRf1W3p079Xf0hz1pm3fJ+CTmXCK0Vy7cK3cFP1KOSOn+3nennKv+dLDxz11LgVQgKTYFbntWTwb0VU0xWoGPBFJl0Ld3OLcJ26KgQt2MgvnCl7sg2RiZi+tgUqQv9NRqCdTrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HivL3pT0; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-24c9f6338a4so2420827fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 13:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719259847; x=1719864647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r2TgoSRL9L5wWBjYZ6Sxj6viuyRp6IcG3C7GSUS/RsI=;
        b=HivL3pT0JJUSG4ZNOjQWINSTjzwjBfblWKGXWV2D5Es2dCUXHWETW0mHVbZ5sWk+Iq
         U9sH5n0768DMtl8LICfMVL8oI/LEV6a2IeabyjP4N9OiUGWG6P8U1i1KkBHjalMGmqq8
         Cv1sVGJ03Ya55MDEoAS1Q1JlWsoEmGFN0BN+lvpTwLJiXtRz+VAGgD0I3wtnm7j2iOto
         kY/+LIcHNc4Z+CoTW8Ek9FUXTnIIbGcpVvYz3H+627j5kmKSYx6rei8GcLVYL4+PHBTt
         e1+Go7901SE4l0hFnIOZn2DwN/DSsuWEUeprBZ77tXV4LOJKwVRvciSze4a+7kDczvjD
         rMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719259847; x=1719864647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r2TgoSRL9L5wWBjYZ6Sxj6viuyRp6IcG3C7GSUS/RsI=;
        b=Pr8+jCS/j+P7QvNrQd+5pPlJu0wy3w0msb0vqK/Ghqwe9MRkHfWfWjawAfCulrIIMT
         gVM0l1JWhpGCopOWqNROIsilWBVYwDzMW0rejGg5xIe5H5GKEgGnI7QNxb/tBZaXG2Ry
         LZRNvDZOx151EnAUx3ULbY0HYT3uuNEKK5yNBwkXu9xNUFeQvZLlw28F8wW4LeHmkvWA
         McEbpPsjSdSKjXSkIWlB+dqccp+Qyw5VEh8pZOZGtfMf/nLuRy64ooWO7YgAH02xMFAT
         t2VEDJ60MNgUi0y/oGOg0jnUpUiU/18aGMRgQJmAK/JUJsagBC5KUr05jR4Zu7DTwq/S
         zD5g==
X-Forwarded-Encrypted: i=1; AJvYcCWMR4mFQSHjiqMnnT30DNFEJYx3JNZXHbhOY7oJaT37yEJHsoNXZntasW/+okRJ8D/lHflcJdFP5dxtm0jq6yblnBo0XZV3NMwqpRNA
X-Gm-Message-State: AOJu0YzBUO1VNP8PlGjyFVoXLhfbxJ6AlAlSLxDkMAh1MitgIVQj11OF
	weBrszR3tnKkmAAgeMa7ph2wDGAFlZcIyafgDnfE/w1mcgYFU6PHg4k2MHknupM=
X-Google-Smtp-Source: AGHT+IHMKDh3ZI84oMOxEXhb4tWDkpdje0SsXLowckNzjPJL44i9L+pADAs1AOLmQMBT+THN+KMHoQ==
X-Received: by 2002:a05:6871:610:b0:258:7bca:3289 with SMTP id 586e51a60fabf-25cfcfa4355mr6736492fac.51.1719259847299;
        Mon, 24 Jun 2024 13:10:47 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25cd498872csm2056581fac.21.2024.06.24.13.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 13:10:46 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 0/2] spi: add devm_spi_optimize_message() helper
Date: Mon, 24 Jun 2024 15:10:29 -0500
Message-ID: <20240624-devm_spi_optimize_message-v2-0-58155c0180c2@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

In the IIO subsystem, we are finding that it is common to call
spi_optimize_message() during driver probe since the SPI message
doesn't change for the lifetime of the driver. This patch adds a
devm_spi_optimize_message() helper to simplify this common pattern.

---
Changes in v2:
- Dropped already applied SPI patches.
- Added patch to fix missing EXPORT_SYMBOL_GPL.
- Link to v1: https://lore.kernel.org/r/20240621-devm_spi_optimize_message-v1-0-3f9dcba6e95e@baylibre.com

---
David Lechner (2):
      spi: add EXPORT_SYMBOL_GPL(devm_spi_optimize_message)
      iio: adc: ad7944: use devm_spi_optimize_message()

 drivers/iio/adc/ad7944.c | 26 +++-----------------------
 drivers/spi/spi.c        |  1 +
 2 files changed, 4 insertions(+), 23 deletions(-)
---
base-commit: 17436001a6bc42c7f55dc547ca5b1a873208d91d
change-id: 20240621-devm_spi_optimize_message-ebbde029dd7a

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


