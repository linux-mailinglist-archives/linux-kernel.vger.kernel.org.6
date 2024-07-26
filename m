Return-Path: <linux-kernel+bounces-263441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFC093D5E3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF28C1C235D2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D411217C22A;
	Fri, 26 Jul 2024 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vZeYDW9u"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA981EB31
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 15:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722007222; cv=none; b=p7W0B6CMutrKrBNVKYQmqYQ0qnimQCNPIJ+Rjppx0DZp8zk5787FFqy/E1DTAaXdfsb1V+P/4Is5FVRyaxEXJYRQglCAPoNdqj3I68QSi/REzG7Z7ywnvh1S2U5dRoZSw0fmznK+jjOzQTna34FOuzqJ/beoP49US11R9eJ6bzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722007222; c=relaxed/simple;
	bh=CcSVrXgio5wQaIXNHB/uRRuS79CVZUk6owoeEqIgekE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nDiNmgsTjN21/oGEV8yy2UeabCbCpME0vJfW5JD8c6UkXFYLdKT45Y8E58BVwFC5+MdF2ywBui7H9O7GOnOUAJBcGUU5qRXien4bZLy1PilQJOYnunelGpwvOCKyzVp6R0vO0pl8KZoZtNupwHOcNAPPtY8rcr3c8QAQP5hWf+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vZeYDW9u; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3686b285969so1361364f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 08:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722007217; x=1722612017; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0AeN/4B/YnSfiF3EeOkW241sQaeu6ZqWm1AU0eyyb88=;
        b=vZeYDW9uhFs+a+Daq9vAcWiJqJDo4Igy3tE69f86ob8txGXgxIMfVtLoJHxLIvTcvK
         caRPcvMrAn0DiFRtDq+G5MF7s20bWJbumMUVCZwPb1AdkZS0zevCb7KtGxACxhRN/SxO
         ZtvpdssTuXXwkY8SkwZxWcQUzosd8gd5PQ2ynpTYfdFgmclq47tCDw5JqnseMXqNRsLA
         K/hMcVbcWbNLk3ghu0DINc6Qi19ojs36M1TpB4zpwxwvvfzT7Ezg4eqcgEaJlXVDkCXO
         oyw4sC+e3C1Obhtn57dAZ4CSxnJdFcZY/F7pWGTcO+xDLP8LE3T4wwOrIxFWtDaKDKpT
         bMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722007217; x=1722612017;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0AeN/4B/YnSfiF3EeOkW241sQaeu6ZqWm1AU0eyyb88=;
        b=S4O0+jGVMyEraQPnSgxUS+ZA9CfHsiGy6slOW9LiAPnkUVyRe//ccPcJfgG/6A8bkM
         75EZjUz+suTp++4sqc46Kg+XF3HtbOaI277OEx2PKHcMcLe063s7m5KxLd2wN7DEaHs2
         uSmxDyIVi61fyGFfy0D4wdNIACj9+9Mv9zmtBbAM0MnGyDuS9o/dfl2gVTAYnmEHdwE8
         e7IABaCjTwFDwIMRPhASFgXBuXkwT73kyileQXLFDp8oSgrS8YSRP2qrFRJ1GpapVz7W
         gTWXIMhqF5qNhiPY34ZHJ5TizorrYAwjU6XyRJPlmuKI0ZxBSrAh6unUVyCifGLEWxDf
         xhsg==
X-Forwarded-Encrypted: i=1; AJvYcCUsQKBHDnhemlZTZ0kS34Q53xvOFKgoCuwlojOo6V1xbFnrI/Y+0/4KvKMKGKBNpWMkTSpwTMqF8lz9AWrxr4gjFGLOwh4NwaUXFuY1
X-Gm-Message-State: AOJu0Yy5MxCnQV7sioPb4YQeB+vxVMp2KKPL8GLRRqELBZ6JW3nQb8qE
	Sjrz7sj8Vo5+ws2r9dH7eVbNxgvmQbWZdBIR5BtluV7PUCFR0I03X42HJfBVxBI=
X-Google-Smtp-Source: AGHT+IF6BPwk3Uv31HZuM/iBo8zO292n3pIWNBgKAoH7EyLiUKyXSFwiCMisxHtFeKxAAj/I1gjaqw==
X-Received: by 2002:adf:e306:0:b0:366:ebd1:3bc1 with SMTP id ffacd0b85a97d-36b5cecf2abmr42532f8f.3.1722007216739;
        Fri, 26 Jul 2024 08:20:16 -0700 (PDT)
Received: from [192.168.1.61] (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net. [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367c0338sm5500985f8f.1.2024.07.26.08.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 08:20:16 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH 0/5] ad7380: add support for single-ended parts
Date: Fri, 26 Jul 2024 17:20:05 +0200
Message-Id: <20240726-ad7380-add-single-ended-chips-v1-0-2d628b60ccd1@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKW+o2YC/x3MMQqAMAxA0atIZgO1ii1eRRxsEzUgVRoQQby7x
 enzlv+AchZWGKoHMl+icqSCpq4gbnNaGYWKwRrbGWd7nMm13pQQqqR1Z+RETBg3ORVD1zpqYvT
 BByiPM/Mi9/8fp/f9AH7NTG1vAAAA
To: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.13.0

This series will add support for ad7386/7/8 (16/14/12 bits) unsigned,
dual simultaneous sampling, single-ended compatible parts, and the
corresponding ad7386-4/7-4/8-4 4 channels to ad7380 driver.

These parts have a 2:1 multiplexer in front of each ADC. They also include
additional configuration registers that allow for either manual selection
or automatic switching (sequencer mode), of the multiplexer inputs.

From an IIO point of view, all inputs are exported, i.e ad7386/7/8
export 4 channels and ad7386-4/7-4/8-4 export 8 channels.

Inputs AinX0 of multiplexers correspond to the first half of IIO channels
(i.e 0-1 or 0-3) and inputs AinX1 correspond to second half (i.e 2-3 or
4-7). Example for AD7386/7/8 (2 channels parts):

          IIO   | AD7386/7/8
                |         +----------------------------
                |         |     _____        ______
                |         |    |     |      |      |
       voltage0 | AinA0 --|--->|     |      |      |
                |         |    | mux |----->| ADCA |---
       voltage2 | AinA1 --|--->|     |      |      |
                |         |    |_____|      |_____ |
                |         |     _____        ______
                |         |    |     |      |      |
       voltage1 | AinB0 --|--->|     |      |      |
                |         |    | mux |----->| ADCB |---
       voltage3 | AinB1 --|--->|     |      |      |
                |         |    |_____|      |______|
                |         |
                |         +----------------------------

To ease the review, this series is split on several commits, in
particular, sequencer mode is added as an additional commit.

Cheers
Julien

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Julien Stephan (5):
      dt-bindings: iio: adc: ad7380: add single-ended compatible parts
      ad7380: prepare driver for single-ended parts support
      ad7380: add support for single-ended parts
      ad7380: enable sequencer for single-ended parts
      docs: iio: ad7380: add support for single-ended parts

 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    |  13 +
 Documentation/iio/ad7380.rst                       |  42 ++
 drivers/iio/adc/ad7380.c                           | 511 +++++++++++++++++----
 3 files changed, 488 insertions(+), 78 deletions(-)
---
base-commit: 472438c7e0e2261c6737a8321f46ef176eef1c8f
change-id: 20240726-ad7380-add-single-ended-chips-b437d1cc8b8b

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>


