Return-Path: <linux-kernel+bounces-311095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE159684CE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB11B288101
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB66155A2F;
	Mon,  2 Sep 2024 10:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zkQc7j1f"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5217274063
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725273417; cv=none; b=p0bETO7azL5fU6U+V+G3NWtWYgxGZnQK50tPwl3rS3rcdLTBsSuwKWdaWDuYFwLr+KwpssafGPcwRuUiWQJn52d7pgqU8D4Ms6xiyGbIHacYQOf5a3Yv/Aj6y9nRmi9cYF7ToCbCmhcChUi8PRmZPLYQI1IRMVB5AXJW24RQb/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725273417; c=relaxed/simple;
	bh=w4hUKFZRVwTkgdYnXbKcFni55fd49hUz3PeIDGWYnIY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q5xl/BWuk/JQijYhW1O5VaonWaIUlHUREY9lemq3g/jYCy2owJY1FvMQPIMWqLtDToAxQkCt3X/XiIhpxUlzPQJcACranMNIUo0Ln4/jtCM1sZug8C2LjYPCeaNtv+b3kHffCcAm1quuw7VgfZ2PW9ZTerS3DfbWx0LSf+Ac/Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zkQc7j1f; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5353cd2fa28so5297248e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725273412; x=1725878212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pdQfS/StVpF9F5Bh2sPOMyAZPOYpAT6UkHQK3E3HfLE=;
        b=zkQc7j1f9EFZ3MDUuMzs7vH5MNX5dwpVTG/9u6pkdeqAChIAGfzG6CDV1f2HFnZYB/
         luXKy4/otsc5rOxTZtBb0nuvXT7FCzAm40fSAP4uZTQONkclQgY9dgIyOjKi0kXWbiPb
         QF5aUZMLmQZnTF8RtWOPBiXMtLL4YApADAU9eWKbM9yzU5SCCsZv9VbJ4ABk/3RxBO69
         SWVWhYn9vjx6sNPMdHn6gMi61p3tBrfdo0N3MgNHZhehjCVdpGZ/67Nv9cKH1zuCKak/
         taLpEmiQ7EUrck5QbW/LzkPMM9ToUDNAbt4e791CciFJ4RzRIbmhqhKMgWn7BtP7YOY5
         HV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725273412; x=1725878212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pdQfS/StVpF9F5Bh2sPOMyAZPOYpAT6UkHQK3E3HfLE=;
        b=wN/uTSJijxUL5OYR9AgMIE8UHmnB007/ar9zcg1Rx70jZndMq9CvTv0zA7THTz+pud
         7CUqaskSEUNtFRKbRFM/mRS7Kz/B81+Y8o61+dKplTDa7fXkKKpcx3Nt3ZVJ7CqR0BIj
         WBtN0hmlNsPWWPpIv7L5TiKGybHeMiARews4qjypTlP0eK5ABFxQB3rRLtufynVgcT48
         zJmyP1bb+Lv21YGroXuvhrVab/Gj1q0toXa85/7OOp/Aa2rGr476sH8r0b2hAtl+jZNe
         jzFtg3CNJy1u42fRODwgB0fKhmIL2wcJUmqGd+/Y5z5aE+jISBcaBEwhk10/2yl4zFmE
         6feA==
X-Forwarded-Encrypted: i=1; AJvYcCUtTvTlQvjQvZlQA93F9Me8mhNlTk62s9+VCROZ6O79anwQ8vy882e2jqiPRZ4zg80cbvpJxkQu7KRm3ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzbsHrXndkwSY0cA+5t3QM+DNHwykSiZcf9jus1plOA05eH5Ez
	fjffzOPm6U7u2Wm0BiTzTi+CvLwxCXS1c85NMF2RX9Nvz6BXAWuaWVmYS4WYjds=
X-Google-Smtp-Source: AGHT+IGtAjoMGEyaiXNrUjDCZSs3tMw20444MMwWP9faqnEiQBTFdwEyYqTFnRde6GurzjLKiuoGig==
X-Received: by 2002:a05:6512:1281:b0:52e:76e8:e18e with SMTP id 2adb3069b0e04-53546afaf96mr5333721e87.7.1725273411820;
        Mon, 02 Sep 2024 03:36:51 -0700 (PDT)
Received: from neptune.local ([2a02:2f0e:3004:6100:e124:ce40:67a4:fcf0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891da22bsm540876766b.182.2024.09.02.03.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:36:51 -0700 (PDT)
From: Alexandru Ardelean <aardelean@baylibre.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: jic23@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lars@metafoo.de,
	michael.hennerich@analog.com,
	gstols@baylibre.com,
	Alexandru Ardelean <aardelean@baylibre.com>
Subject: [PATCH v2 0/8] iio: adc: ad7606: add support for AD7606C-{16,18} parts
Date: Mon,  2 Sep 2024 13:36:23 +0300
Message-ID: <20240902103638.686039-1-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The AD7606C-16 and AD7606C-18 are pretty similar with the AD7606B.
The main difference between AD7606C-16 & AD7606C-18 is the precision in
bits (16 vs 18).
Because of that, some scales need to be defined for the 18-bit variants, as
they need to be computed against 2**18 (vs 2**16 for the 16 bit-variants).

Because the AD7606C-16,18 also supports bipolar & differential channels,
for SW-mode, the default range of 10 V or ±10V should be set at probe.
On reset, the default range (in the registers) is set to value 0x3 which
corresponds to '±10 V single-ended range', regardless of bipolar or
differential configuration.

Aside from the scale/ranges, the AD7606C-16 is similar to the AD7606B.

This changeset, does a bit of rework to the existing ad7606 driver and then
adds support for the AD7606C-16 & AD7606C-18 parts.

Datasheet links:
  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7606c-16.pdf
  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7606c-18.pdf

Changelog v1 -> v2:
  - v1: https://lore.kernel.org/linux-iio/20240819064721.91494-1-aardelean@baylibre.com/
  - Fixed description in 'iio: adc: ad7606: add 'bits' parameter to channels macros'
  - Added patch 'dt-bindings: iio: adc: document diff-channels corner case
    for some ADCs'
    - diff-channels = <reg reg> can be used to define differential channels
      with dedicated positive + negative pins
  - Re-worked patch 'dt-bindings: iio: adc: add adi,ad7606c-{16,18} compatible strings'
    - Using standard 'diff-channels' & 'bipolar' properties from adc.yaml
  - Re-worked patch 'iio: adc: ad7606: add support for AD7606C-{16,18} parts'
    - Reading 18-bit samples now relies on SPI controllers being able to
      pad 18-bits to 32-bits.
    - Implemented 'diff-channels = <reg reg>' setting
    - Removed some bad/left-over channel configuration code which I forgot
      during development and rebasing.

Alexandru Ardelean (8):
  iio: adc: ad7606: add 'bits' parameter to channels macros
  iio: adc: ad7606: move 'val' pointer to ad7606_scan_direct()
  iio: adc: ad7606: split a 'ad7606_sw_mode_setup()' from probe
  iio: adc: ad7606: wrap channel ranges & scales into struct
  iio: adc: ad7606: rework available attributes for SW channels
  dt-bindings: iio: adc: document diff-channels corner case for some
    ADCs
  dt-bindings: iio: adc: add adi,ad7606c-{16,18} compatible strings
  iio: adc: ad7606: add support for AD7606C-{16,18} parts

 .../devicetree/bindings/iio/adc/adc.yaml      |   4 +
 .../bindings/iio/adc/adi,ad7606.yaml          |  63 +++
 drivers/iio/adc/ad7606.c                      | 430 +++++++++++++++---
 drivers/iio/adc/ad7606.h                      |  78 +++-
 drivers/iio/adc/ad7606_spi.c                  |  71 ++-
 5 files changed, 550 insertions(+), 96 deletions(-)

-- 
2.46.0


