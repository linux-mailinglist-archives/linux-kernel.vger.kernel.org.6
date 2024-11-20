Return-Path: <linux-kernel+bounces-416339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A01849D437C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 22:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0118FB22458
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 21:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE181BC068;
	Wed, 20 Nov 2024 21:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mlkZjjwZ"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239FE219ED
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 21:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732138442; cv=none; b=HBejxxZypKQL93RmcaT599L7x1NjLhMNtDiPRv+hMZylk/L1qDFN5Q7O2rOmC540/IRmMTizwe6WR6qVVBvfarA9RvKIEEEsuqnP1E5eoDApG701AwujkOA3AqFxquObV+31/PSIe8OnmTl/t6dd8kgw1DOxcq3q1Lw+3cUkJgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732138442; c=relaxed/simple;
	bh=0NphIvbmT9wu03y38djVTdhK7nQ08QWJClY6NLJjv9I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nWTv0ruvOvSZGpWxajMKPa8YYVjZELkt5R9nBbjBRCP6DsPtj505Vx/Qv+v8C8lF99znxJl7LQtG6LXEmUs6oDpWy8S9b8vHBOk9pR8c8GbKfXpfve+YTB+mgQsyh0dgzmWj6QmCfJclXACVuRMxTfKomg+hcXDuP782lP3j9ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mlkZjjwZ; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2965e10da1bso190438fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 13:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732138439; x=1732743239; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sTH3HCDi+7Bluy/uRzD/tWU3FxIXepMjeUa72N+ULm8=;
        b=mlkZjjwZ2h/lRs+WzX0hGN4EYcbS8UG1RVaaeXhXX7FrHwD9uZGJM3pmVh/iduKH5d
         Qi2IAQcfZ0cxpZs9+NQ0m/ikEO1aSQlF8lI+RX1Wpq11vJCE+AYByuxe2ZdlOdK5TLzd
         HN2ASW3MtzwEdXfafrNqNBQ0mKhaWDxHtvG5TGGalg3NzPSjDZnadB7hKdvSkbEvNoJT
         4GQ0pvRZUZAshXYi/fR/AJ4TPpNrTMBMQbJd1TIY3YxWSTjzbGjFqcOdOoVzCsucOx2k
         14Uod30nc/Np8W3bBGHfc0GmEY6yzEqYjfsZW7iljY3uUwJ6o6xA28uPsP6itIDy8Aza
         0c0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732138439; x=1732743239;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sTH3HCDi+7Bluy/uRzD/tWU3FxIXepMjeUa72N+ULm8=;
        b=IDKZiWjt151pfwG2cZLbmj6pD5myIaiEbDq7ZnKOUMpOUoGVADr0JLzgmXv3yj0Xm/
         7DZXr3LbWhRWESzjf1zqjJsWze2BZDNFNGa0LGOCUM/tHNyCMuRsL8o3oYD5SFyMm/js
         qH0BkfwBf+E1zR/wBUK0isGomnWkT184D+vHM1yJ4jSqb6wQiWPtNYTSIsnrVdUlYKM0
         uprB0MN9QbnlIsOkk5KN3FHoDeFkDdzGiHFf9F9vlZT72LV/7Kyiv7ggvsVGH24Wci6r
         IFyBKjClevIGhttA63FjY0naUAgbzS4RYmPxtFM2TdbRJOJV3HGZLZJr1hWFC/86sIgB
         nu0A==
X-Forwarded-Encrypted: i=1; AJvYcCWZctrBFeAogz05+lNLZs/sE3r9vtJ0Tzh9IvIW/P0dQWshe/Up4Vy0sxs4WimWUAW7wSsOdtysiyBmmNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjeB/ZqccZ5Cpry373Hr89PQfkxq29AduLhXAEcklljlbbqKpB
	7UsFt15ACbCpvYwu6VjOpZMe2kgBy8Wem5+pTKhMg7dLUpSV1QMBGnsZKwuW7WQ=
X-Gm-Gg: ASbGncsXDNPei6la2o4i06n2ihm8WYG7ahZ38BuygKQV7kw9zg3sl0zj/9ymdxj7wbf
	+5nRqAqJc4LSYgTBphS8kcAWhZmqkAaO0BKVEWv1S+qAj7CFvpwdls2CTzWApZ2DPCpDs/6swMC
	+jnPj3kF9ahrh8lWa50D6fv9FPgNobSUDWpVIxbICvYw1XY1e52FhHAK3T25tEqUDKdEuxQdCjs
	uKeYUnBVm6CfRIsppyqBpCPhvNyd4JPQnFfZU6MKi91XV0U7/rTVo/WU+oFuBkqPx3/dpGEKVBA
	u6qJrw==
X-Google-Smtp-Source: AGHT+IE1jYWRIFwOGN1GIoXzgvJh/6wxnmL6YNbp8pqTQGHPXV42t86/TGrMPJbbfqesfn4VE5QRlQ==
X-Received: by 2002:a05:6871:7584:b0:297:3e4:af9 with SMTP id 586e51a60fabf-29703e410e7mr8430fac.15.1732138438982;
        Wed, 20 Nov 2024 13:33:58 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29651852c27sm4487365fac.2.2024.11.20.13.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 13:33:58 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 00/11] iio: use devm_regulator_get_enable_read_voltage
 round 6
Date: Wed, 20 Nov 2024 15:33:23 -0600
Message-Id: <20241120-iio-regulator-cleanup-round-6-v1-0-d5a5360f7ec3@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKNVPmcC/x3MSwqAIBAA0KvErBtQ6UdXiRZaUw2ExpgRRHdPW
 r7NeyCSMEXoiweELo4cfIYuC5g261dCnrPBKFNpbRQyBxRa027PIDjtZH06UELyMzbYdk7VjlT
 T6g7ycQgtfP//ML7vB8JpBcxvAAAA
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

This series includes the last of the low-hanging fruit for converting
to devm_regulator_get_enable_read_voltage().

By low-hanging fruit, I mean that these are the drivers that read the
voltage of a regulator in the probe function. If you grep for this, you
will still find a few that do this, but in those cases, they usually
have power management where we need a handle to the regulator to power
things down and back up in suspend/resume. So we can't take advantage of
this helper function in those cases.

There is another class of drivers that could potentially make use of
this helper function that I haven't addressed. There are many drivers
that call regulator_get_voltage() in the IIO_CHAN_INFO_SCALE case of
the read_raw() callback. In most of these cases we could move the call
to regulator_get_voltage() to the probe function and store the value in
the private data structure instead. For those, we would need to be a bit
careful though to make sure the the intention wasn't to handle a change
in voltage during operation.

As a bonus, this series also includes a few other minor cleanups to fix
some copy/paste typos and remove some driver remove() callbacks.

---
David Lechner (11):
      iio: dac: ad5624r: fix struct name in doc comment
      iio: dac: ad5686: fix struct name in doc comment
      iio: dac: ad5686: use devm_regulator_get_enable_read_voltage()
      iio: dac: ad5686: drop driver remove function
      iio: dac: ad7293: use devm_regulator_get_enable_read_voltage()
      iio: dac: ad8801: use devm_regulator_get_enable_read_voltage()
      iio: dac ad8801: drop driver remove function
      iio: dac: ltc2632: use devm_regulator_get_enable_read_voltage()
      iio: dac ltc2632: drop driver remove function
      iio: dac: ltc2688: use devm_regulator_get_enable_read_voltage()
      iio: dac: max5821: use devm_regulator_get_enable_read_voltage()

 drivers/iio/dac/ad5624r.h    |  2 +-
 drivers/iio/dac/ad5686-spi.c |  6 ----
 drivers/iio/dac/ad5686.c     | 62 ++++++++-------------------------
 drivers/iio/dac/ad5686.h     |  6 +---
 drivers/iio/dac/ad5696-i2c.c |  6 ----
 drivers/iio/dac/ad7293.c     | 66 ++++++------------------------------
 drivers/iio/dac/ad8801.c     | 81 +++++++-------------------------------------
 drivers/iio/dac/ltc2632.c    | 69 +++++++++++--------------------------
 drivers/iio/dac/ltc2688.c    | 44 ++++++------------------
 drivers/iio/dac/max5821.c    | 36 +++-----------------
 10 files changed, 74 insertions(+), 304 deletions(-)
---
base-commit: 414c97c966b69e4a6ea7b32970fa166b2f9b9ef0
change-id: 20241120-iio-regulator-cleanup-round-6-78b05be06718

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


