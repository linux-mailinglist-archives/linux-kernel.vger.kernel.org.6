Return-Path: <linux-kernel+bounces-284741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 133DA9504A5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4283287FC2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277701993AE;
	Tue, 13 Aug 2024 12:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LlUAdA81"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3E11991AF
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723551233; cv=none; b=GmXKmX6/S3lkMiHHH2ctpiNsqh15OkAJpR5P34Lc+qRP661sRtvGwfd0PSsP9R01xhraieHe3u0bnh+4tM3Y9FKtTuipK/jvtYZTLIY626renkvJYOVGPusSXmj5Vkfby7OtJlqQSli6er3xrcSqZ179XjTwm8Oj65WoqBKfvPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723551233; c=relaxed/simple;
	bh=AhtVc0eRB313SzivG95eO+fvDnddIaj+hD0gJVu5zyc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IK3ar7ot52Ty/O4BIfBVKh3ZJpczd63X/7ECilxRWIH9pOytDWGEZtycsd9u7+xvYud4bEuqa8yBVMvDdnvE5pxiek7gglkI9ueaO1O4GxBF/mlO1dVtiyv0mZUwhFHxZiNuWYDwAYLCzwi6KMXsmo8BiuzSeKdrMkF0GFGNaqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LlUAdA81; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a1d42da3baso343428985a.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 05:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723551230; x=1724156030; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=exEVIAJZd/rYdUXslfft3lBWpWIRwR1McJc3b9INl9w=;
        b=LlUAdA81g9wNGeTxYHkTqkJrJDjxHBrv0nj3BkwaduKYWicDObc7qmitZ/DB6rgTB9
         uU9ZwxIgXnI173noR03bRPrBd3QjJiApY1aH3HMzSOl8t4LF1jwq+9J4bwpAHoID44tT
         xMsSA7gvr2VzSPc95u03vFP1VMFKnEJAwG+fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723551230; x=1724156030;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=exEVIAJZd/rYdUXslfft3lBWpWIRwR1McJc3b9INl9w=;
        b=lRGxjhB+mNUxJENVBwTq0CBKpjEDM9kn/9r9SSrWkfi/gcVQ/ZEWA6JcfL8WVkTfXt
         kzoTWTXfDApjJ2iZABOlRjR1oE8+PrGT+3Ald9FhEmmqtJ4TZNITdEoVIahwVCXH4g/h
         FEaTAHuI2IdNeI1riZnLEYeHhj526+gdMMRO7Eqsd0Z7fH76Ws1IqapJENadN0zomuoh
         7NDsicN2jC4H+6HWmfB0oROQsHJzuUFfjZz4/cnYZ1mIgZdJuu8p48WUgOWbtcRj8as4
         09PpNPlrRdSpYRtd2l5W2/f9De7FEpaE7G7RqaGsZxm4ofUmAahpRfPPgXZriqOOn/7V
         EplA==
X-Forwarded-Encrypted: i=1; AJvYcCU5E4kRGIlXh5WVaOBXfXq9G8YMTGKWBD7/5Z0WwDkJRk6/H2o3Wy9DRWCCtktLKgW/z+G2JqUAQm7ALbBBKg2QALXGTXUNF14ZtAsv
X-Gm-Message-State: AOJu0Yw3rC+dOXZiaJKmKmTlUc8R09QlUuGMd08Wyf656OaBnw3xphIU
	z+IoZLGwZADDr3LKngWlQKHMSFjcBE+hsUCduEMhbYj7pzrzboaJ1SWunivhhA==
X-Google-Smtp-Source: AGHT+IHEAC5qNhYBF14RuyiMsQL8IDhPP6lbNZuwJIZWarWyGBLPSFdo+w5w+ficdZzhLBjRgODR3A==
X-Received: by 2002:a05:620a:460a:b0:7a2:db1:573d with SMTP id af79cd13be357-7a4e153e4femr367590785a.36.1723551229916;
        Tue, 13 Aug 2024 05:13:49 -0700 (PDT)
Received: from denia.c.googlers.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7d71ca8sm331765485a.50.2024.08.13.05.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 05:13:49 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 0/6] media: Fix last smatch warnings
Date: Tue, 13 Aug 2024 12:13:47 +0000
Message-Id: <20240813-smatch-clock-v1-0-664c84295b1c@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPtNu2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDC0Nj3eLcxJLkDN3knPzkbF2jtETjJENDcxMLU3MloJaCotS0zAqwcdG
 xtbUAgffoXl4AAAA=
To: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 =?utf-8?q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-staging@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

This series completes the smatch warning cleanout.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Ricardo Ribalda (6):
      media: ar0521: Refactor ar0521_power_off()
      media: i2c: ov5645: Refactor ov5645_set_power_off()
      media: i2c: s5c73m3: Move clk_prepare to its own function
      media: tc358746: Move clk_prepare to its own function
      media: meson: vdec_1: Refactor vdec_1_stop()
      media: meson: vdec: hevc: Refactor vdec_hevc_start and vdec_hevc_stop

 drivers/media/i2c/ar0521.c                   | 15 ++++++++--
 drivers/media/i2c/ov5645.c                   | 15 ++++++++--
 drivers/media/i2c/s5c73m3/s5c73m3-core.c     | 13 ++++++++-
 drivers/media/i2c/tc358746.c                 | 12 +++++++-
 drivers/staging/media/meson/vdec/vdec_1.c    | 16 ++++++++---
 drivers/staging/media/meson/vdec/vdec_hevc.c | 43 +++++++++++++++++++++-------
 6 files changed, 92 insertions(+), 22 deletions(-)
---
base-commit: c80bfa4f9e0ebfce6ac909488d412347acbcb4f9
change-id: 20240813-smatch-clock-2fa3b1174857

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


