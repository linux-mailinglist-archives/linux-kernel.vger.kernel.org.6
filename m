Return-Path: <linux-kernel+bounces-404311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5119C4244
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DDEE1F25DA9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 16:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B31A1A0BC3;
	Mon, 11 Nov 2024 15:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="g88XP/oX"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EB7142E6F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 15:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731340788; cv=none; b=kYAEpJBvxTj5czBPSsYkK7oEZWTexCUDYOh4ufNqDrmC01MyD2yX+uk6frBH2zol1j+e7pTdkXWAZcRYkWU5Kio10+rxXGbDmgceW8Dscx4DAl+a+EPZ38HwWI72NJHgEO4y4wFV6ZHb3OK3HYJggkRpcw0rkfREYWFAkzv+47k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731340788; c=relaxed/simple;
	bh=mhGJZFEfk5MkHnXe7qqUfuL+zQl1LNFP4u13j9VbxHQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=K28yIMgOqwdI/AbV3WQIoYZq7Hfl+kcHzvTTH2X5vAkXl0Hoki3JhD/FctLer3d7FEuWjkyFcJaUcuKdlNx6Uqf3pkMxqoflLOhOwqpJLdI4Xk77RACX87wxTX03CBPrQ9Z9W+FEPTRu7hpsfw/uGYotRCe/PcW/Byy5U1icKas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=g88XP/oX; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a3b7442db5so18611895ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 07:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731340784; x=1731945584; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2cKPgBQ3l65Z4+uJjlyHn0q9Q0ROrxH+n4NCTmhTAGo=;
        b=g88XP/oXkyQ9M3Qvqbg6Cqs4eyijMWZO8DuuxurOeYK0PrkCh3InSpTU2yRJRnWrH0
         kcP4X5HTehI6m3DqD2N9uSCMng0M8XI4sWENPX8ag08URWMYj5sBKzk0S+nGpknC94Q6
         PbupuSaOI87ByzIe6gGF92PY21MAyNLO+NSkZ4iKePALHwU5h4auIrfZ+V8OxrFspHo7
         UEf8K87HA/R0YUtZtpyGB5w1zGF0bu5nwcTO/j6lw1cwi+a87XB6hzZT7WM7EJVQgrUR
         dpO5lvLVdCrWXh3ojvVp494lgNXTdBa3TwCG6YwjUXNC4NFhHgxr8ISUp3FytBixQLcx
         0duw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731340784; x=1731945584;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2cKPgBQ3l65Z4+uJjlyHn0q9Q0ROrxH+n4NCTmhTAGo=;
        b=TrWWOWy0iM4+Yx0I0OcakZbUrVU/CC+UQEyg/KRpVnBgnnIHoEBYf6YUiOFrQ1SwMV
         F9NF9eRj5RVEdATWBlXBcrncpHlKHsVQvpsXauDXB1Zhw1eXFyIBu3gDmHhGDSRX7jeF
         WtqCpTQZTahXQKZe3YNpjQ0zdZjBtrMmxmAk8QBFbr8wdXKKNMwwbAHsj/P5fdMNt2AV
         j2q+5ynNESAMSV5V5BF4/Se9qI+Z7i2KFiZ6JOaS1fOtBMzefRxeB1GTwpckKTVBS4wS
         uWUqC0jPhOuoJx8bBz/tyd58fZ33lE66lQUumoqApORgKSqJghewD0eRgVYO4n7fpUEI
         IlKQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+r6sYmVfL1rbdTqin04BP2Lreuq6p3L/AUPVO5XkuTPPxXw/BLnPDwe1PhsgEA6Q4vmA/DtPBytXTWKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF8p9r1sqPBo5EF01Mq/uZPBJeNPRsD2imRlDxIT11LrL6dvj9
	yRZ4ryytArzS/V4hOnIvKybjvTk5bQSeoWtzww85ZhOAkD7GRy5Ch9m7UFhXa6ua3kdTY/CQRx6
	g
X-Google-Smtp-Source: AGHT+IEPM1W+ZQMFu0TrS0mFB0rJ26DhnT3cGpDFG7+8qykw873wAuNaEJ8cHZ9YoP5VuJ3St8ImUQ==
X-Received: by 2002:a05:6e02:1706:b0:3a6:acdf:1a19 with SMTP id e9e14a558f8ab-3a6f1a22195mr134301545ab.18.1731340784057;
        Mon, 11 Nov 2024 07:59:44 -0800 (PST)
Received: from [127.0.1.1] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de787d62c6sm1410986173.81.2024.11.11.07.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 07:59:43 -0800 (PST)
From: Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH 0/3] iio: adc: ad4695: add new regmap callbacks, timing
 improvements
Date: Mon, 11 Nov 2024 10:59:41 -0500
Message-Id: <20241111-tgamblin-ad4695_improvements-v1-0-698af4512635@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO0pMmcC/x3M3QpAQBBA4VfRXNtisH5eRdJgMGWXdiUl725z7
 r6b84BnJ+yhiR5wfImX3QakcQTjSnZhJVMwYIJ5GlLnQmbYxCqacl0XvZjD7RcbtqdXJWVIGnU
 1ooawOBzPcv/7tnvfD5CuebhuAAAA
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.14.1

The AD4695 driver currently operates all SPI reads/writes at the speed
appropriate for register access, rather than the max rate for the bus.
Data reads should ideally operate at the latter speed, but making this
change universally makes it possible for data to be corrupted during use
and for unexpected behavior to occur on driver subsequent driver
binds/unbinds. To solve this, introduce custom regmap bus callbacks for
the driver that explicitly set a lower speed only for these operations.

The first patch in this series is a fix introduced after discovering the
corresponding issue during testing of the callbacks. This is a timing
fix that ensures the AD4695 datasheet's timing specs are met, as before
the busy signal would sometimes fail to toggle again following the end
of the conversion sequence. Adding an extra delay in the form of a blank
transfer before every CS deassert in ad4695_buffer_preenable() allows
this requirement to be met.

The second patch is an improvement that increases the robustness of the
exit message in ad4695_exit_conversion_mode(), this time by adding a
delay before the actual exit command. This helps avoid the possibility
that the exit message will be read as data, causing corruption on some
buffered reads.

For additional context, see:
https://lore.kernel.org/linux-iio/20241028163907.00007e12@Huawei.com/

Suggested-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
Trevor Gamblin (3):
      iio: adc: ad4695: fix buffered read timing in ad4695_buffer_preenable()
      iio: adc: ad4695: make ad4695_exit_conversion_mode() more robust
      iio: adc: ad4695: add custom regmap bus callbacks

 drivers/iio/adc/Kconfig  |   2 +-
 drivers/iio/adc/ad4695.c | 135 ++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 118 insertions(+), 19 deletions(-)
---
base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
change-id: 20241111-tgamblin-ad4695_improvements-7a32a6268c26

Best regards,
-- 
Trevor Gamblin <tgamblin@baylibre.com>


