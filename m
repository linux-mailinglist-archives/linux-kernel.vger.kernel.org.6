Return-Path: <linux-kernel+bounces-212259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F71905D64
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 23:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A23381C210C1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 21:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F16129E93;
	Wed, 12 Jun 2024 21:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GaFV0S57"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ACA86AE3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 21:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718226203; cv=none; b=JYjqIIG7LMgtd6Fiyun/mubrTmzJnhWr+y0Ur35SlMCFbW7Y3WbYDS6GC0po70NdAnRzUMVjvvM49VW2+Pak3akLc5L1OIycW+7TSXPDcZzCu436t+YmM0lZT/AO5NMu5cU0DGOmkr11sEaccmazs0UVHCbnPDsQ7oay+pHnjmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718226203; c=relaxed/simple;
	bh=RNcdsu5M8J+l6BpFm2PvQc2JbQnF0jcrpMXotqoZQQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CgJIYl9W0EcCqkuQ2JHQUaYa0v0MF59N1Zf9J2RgslKudx/DKKUlSA3c4GTC55ODjSSeb2NPyMypDWmVsZ7kawNpGAkGBX2Y3xwfQ0cujeNOe83va6+8xgwbterMzr/kNp+Bk2GzGnmGn8w5ax1VuDL+n+NIBbe2m8R2TQpmCAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GaFV0S57; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c9cc681ee0so110418b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 14:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718226199; x=1718830999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m8+AjDCwdDm/uy92ZopCZV/80gVLrKEBs5ojktWuicI=;
        b=GaFV0S57Sh8g8IRz5lRKB//ofz1ZHcv5TEPpkZ1dNUxNvTDW3KkLR70cR5S4fKJTO/
         WD6G4nrXj8DlymSIToJY95Lq4PeDMldiSMrCO2Gv6cZwPTn7fH3jKM3wz0AHOBE2qWO9
         FPFtaddIakfW2bW6+mpP+7Ew/euoWx24z1ZhYhXRnOD46XxwMsjrpi2b9SqLqimYS80Q
         oEVKKgZHnd+JBImxVf8oFukW2Pql9cginrxqylewNKnUoacstojDK7QZxTtc/nZ4LV/B
         EKwP65Js83OigMtYtTcsI/3hfMrukYC2xeuF5/0TzNnKLWTBY0nRhwRdeeVQThG3ceP/
         fYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718226199; x=1718830999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m8+AjDCwdDm/uy92ZopCZV/80gVLrKEBs5ojktWuicI=;
        b=kqe1McWaoz2dtfCKDnCDs0ddycAvfSfnUc2eMw0CfqhKBLMxkga2V5kRMit31pqMDl
         16qfTH78a4ZUygOVl3DEwT9l31yW11C3OSG6tUR7TU8+cie5B7xOuDmNKEUKXuBZghxJ
         D61f6AZ+1p3j82IXjftzaqhom3Sq+AMDkAdNCwU8llIKxRt74sbcWxkB+DL6+9BOu9i8
         F8cWpo1N4E+SjkxYnDcC6WZyAeVf8/4IQdIb87VyGus+s+V3+8kwdXFJSU3m3/Q455hH
         srpwSOqV8D9Kto6GGtPss515goBUj9kNzEreWRbc2JLKXQ2+MrIaSr7jl3+0kjsLtoji
         VNCA==
X-Forwarded-Encrypted: i=1; AJvYcCWz6z7+VAqslfRpi3uvekKs5McgFw1N9y8vuf/yL5ewNGFVHNoYd4GJIOoISanhlFlIXgW8bV9omy0KGzjWgbdbfKMnR/3qIsvSHmLH
X-Gm-Message-State: AOJu0YxA/mxTX+6g0gc5gJ0PQ/oIkcIIlfSy05uWeVRi2LxOb1b3VWY2
	6H9ngMgM49DhgILUiPur/gNgyzCBHQMAciB84dc3mWcmBBiRGZa9357e0+TVfqw=
X-Google-Smtp-Source: AGHT+IFG9hXHfKhhcsIEt7ahUMFRg3vhKaQFr3sQBZ2FeZGqHgEjq5jtMXoVA0Hk1E/JvmO9j9OGcg==
X-Received: by 2002:a05:6808:ecd:b0:3d2:21c8:e1d5 with SMTP id 5614622812f47-3d23e013a60mr3825908b6e.25.1718226199252;
        Wed, 12 Jun 2024 14:03:19 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d20b68f5a1sm2433368b6e.23.2024.06.12.14.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 14:03:18 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] iio: adc: use devm_regulator_get_enable_read_voltage round 1
Date: Wed, 12 Jun 2024 16:03:04 -0500
Message-ID: <20240612-iio-adc-ref-supply-refactor-v2-0-fa622e7354e9@baylibre.com>
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

Following up from [1], this is the first round of patches to convert the
ADC drivers to use devm_regulator_get_enable_read_voltage().

Some of these are trivial but some aren't so I'm breaking them up into
smaller series to spread out the review load (and my work load).

[1]: https://lore.kernel.org/linux-iio/20240429-regulator-get-enable-get-votlage-v2-0-b1f11ab766c1@baylibre.com

---
Changes in v2:
- avoid else in return value checks
- fix unintentional changes in behavior
- use macros instead of comments for internal reference voltage
- Link to v1: https://lore.kernel.org/r/20240531-iio-adc-ref-supply-refactor-v1-0-4b313c0615ad@baylibre.com

---
David Lechner (5):
      iio: adc: ad7192: use devm_regulator_get_enable_read_voltage
      iio: adc: ad7266: use devm_regulator_get_enable_read_voltage
      iio: adc: ad7292: use devm_regulator_get_enable_read_voltage
      iio: adc: ad7793: use devm_regulator_get_enable_read_voltage
      iio: adc: ad7944: use devm_regulator_get_enable_read_voltage

 drivers/iio/adc/ad7192.c | 100 +++++++++++++++++------------------------------
 drivers/iio/adc/ad7266.c |  33 +++-------------
 drivers/iio/adc/ad7292.c |  36 +++--------------
 drivers/iio/adc/ad7793.c |  24 ++----------
 drivers/iio/adc/ad7944.c |  54 ++++++-------------------
 5 files changed, 62 insertions(+), 185 deletions(-)
---
base-commit: cc1ce839526a65620778617da0b022bd88e8a139
change-id: 20240531-iio-adc-ref-supply-refactor-93f962d40c23

