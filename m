Return-Path: <linux-kernel+bounces-379021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6849AD8BE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 01:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CBE61C215C3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB961FF60E;
	Wed, 23 Oct 2024 23:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IWeF66v7"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13551E0087
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 23:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729727680; cv=none; b=UkPWegwlIjJ8yoWY4WNZ/0VJzqM59IjVvjNJy1RwRX8bcEFkTYAMc4gEaj/VH2X27apg7HlvEWNnkuCFDR455+G3md5RCxKp2/PDk+1cCQUec5pwetgDyUVMe2JzSm5Msyj2jnIIDT3+JeFmjRckHQGKA/UgoWwsDaqt0EDAcBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729727680; c=relaxed/simple;
	bh=I4GmRGGB3tkiacRF5gleikU6SA37GO6iMlLu3WWb6eo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JP3HzEiOpaucVLw1zv4L66fVr+eanGLLD3ljDoToT7jJztl7pRpkI5ls1U0KFmLBZ/BaFfcNEFjYzqYwietOztaUtzHwQ8lHhXRlKrt4RY5EYH9CFTElN6vFzwl6Aqa56ZZM1poWl+vb6ZDCD3DMxy1QqnBVpkReHyhizyCEJIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IWeF66v7; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5ebc5b4190eso145658eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 16:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729727677; x=1730332477; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DPfmr5DaiqCsn7BKKUPbilfPKXqx/V+Fx2eV3zkRXcw=;
        b=IWeF66v7rhFiW/6y0xDEIAV9FDw4s4i9RxbCf3PcJGb6Flh5lVzKeTJOvkhGo/YBmM
         PJu1fLHw4r1pTeJmni9PnRnK0SaRW9f4S2mCYL3R/YoD/ZOmIra3UdrGWYgD7+qiB3Jq
         b1Eyk7NeLz3TFCyA7p/5pkOGOCXx3ZMq62sJZNH61dhRMbx+l+4Pvny70v7UxUpME5/E
         RfrBetPO85/cEo05jx5dE1LU20Zf21d3iIVMnKpXj6oE9W2nVLelmgHKMV6cJIEfFHgh
         ViKB3Dc081mWA1PndJfQ2MSJc2LT8+72fYM3Eyn+cUIroEvMZRziRnFU4uIcri1W1f/6
         K4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729727677; x=1730332477;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DPfmr5DaiqCsn7BKKUPbilfPKXqx/V+Fx2eV3zkRXcw=;
        b=fwLoLJsGas1EsQmeGdwjsAitBHLiN/TkI1Yk89USVWpr6ogXEUDwX2JzXKTv6SBayo
         04Y8wkH647EaNR2guIX0NGf/zptcnldBpdvJRcahlGxTTfMW5miyu0vgz15LF3MOIVNA
         Ta62vCoo2bkyme/h4wULjR7yukr7qPzmKdYZHhi+PlNBk/Lui6OZ6KYL6VOIQsNfoaHT
         Jo5ZagXJ+lp4bML0JDK7EAOXK/ENUjME1jwGMm9dMboZ9wj5NesmGjAfoWrVF0kUUsA0
         Ha00sOWHof5s6/9rq6yC3G+ELfBYhe5cnbnJx+1eoLXOoXn99RQ6nSZHDTUt5LY330ax
         0kfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHfkIzqYEJZul0A8uXlJKjIlNmy3O6Gp2/BP8RGEJM9pX6o1BGA2wcCB/uuT0FQPTS808OtfVYF5WlxpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfuTeWut39Tio0Vlw1t6y+JUQ4tl2gZeuJxuMzLXp8J4kCyo9o
	8mnzVhey2QISU/cNdXbijiYLTGGYYcDDcEVxAR8wePiSOwSeTSaamYU+6J9xBHl3GWaiQJBrfZX
	g
X-Google-Smtp-Source: AGHT+IEVKSKJy6sL2E5e5mWOJyf6hp0HoBDaNv5hM2DcLgkFq6rNlqassOJBWoptlq0H1kHReioeYg==
X-Received: by 2002:a05:6820:541:b0:5e5:d0c8:8030 with SMTP id 006d021491bc7-5ebee8e372emr3546007eaf.3.1729727676897;
        Wed, 23 Oct 2024 16:54:36 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec02c2b25bsm132002eaf.39.2024.10.23.16.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 16:54:35 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 00/11] iio: use devm_regulator_get_enable_read_voltage
 round 5
Date: Wed, 23 Oct 2024 18:54:04 -0500
Message-Id: <20241023-iio-regulator-refactor-round-5-v1-0-d0bd396b3f50@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJyMGWcC/1WNywrCMBBFf0WydiSvSuPK/5Au8mwHaiOJLZbSf
 3fszsXAPcPlno3VWDBWdjttrMQFK+aJQJxPzA926iNgIGaSS81boQAxQ4n9PNp3LpSS9UfI8xS
 gASV1a4zyRjnOaORFDfwcgkdHPGCl+nr4FvH7/k/b4On01TTg5pRiiYEkNsAigYNxTpjkhZHa3
 Z1dR3QlXnx+sm7f9y+ZWKZfzQAAAA==
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Here comes another round of reducing boilerplate code by simplifying
getting reference voltages and dropping more driver remove callbacks.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (11):
      iio: dac: ad5380: use devm_regulator_get_enable_read_voltage()
      iio: dac: ad5380: drop driver remove callbacks
      iio: dac: ad5446: use devm_regulator_get_enable_read_voltage()
      iio: dac: ad5446: drop driver remove callbacks
      iio: dac: ad5504: use devm_regulator_get_enable_read_voltage()
      iio: dac: ad5504: drop driver remove callback
      iio: dac: ad5624r: use devm_regulator_get_enable_read_voltage()
      iio: dac: ad5624r: drop driver remove callback
      iio: dac: ad5761: use devm_regulator_get_enable_read_voltage()
      iio: dac: ad5761: drop driver remove callback
      iio: dac: ad5770r: use devm_regulator_get_enable_read_voltage()

 drivers/iio/dac/ad5380.c      |  85 +++++++-------------------------
 drivers/iio/dac/ad5446.c      |  77 +++++++----------------------
 drivers/iio/dac/ad5504.c      |  59 ++++++-----------------
 drivers/iio/dac/ad5624r.h     |   1 -
 drivers/iio/dac/ad5624r_spi.c |  71 +++++----------------------
 drivers/iio/dac/ad5761.c      | 109 +++++++++---------------------------------
 drivers/iio/dac/ad5770r.c     |  41 ++--------------
 7 files changed, 88 insertions(+), 355 deletions(-)
---
base-commit: 9090ececac9ff1e22fb7e042f3c886990a8fb090
change-id: 20240813-iio-regulator-refactor-round-5-3248993c93b0

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


