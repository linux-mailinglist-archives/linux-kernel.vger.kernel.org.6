Return-Path: <linux-kernel+bounces-357889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F00997765
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E937E1F2319F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B861E22F9;
	Wed,  9 Oct 2024 21:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sVIe4Vla"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DD82119
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 21:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728508989; cv=none; b=bXv033Zb/ejOIUEofYPyU6R4tHl5nsqAOmpxBspX/SYTw18HpFZXe5Jdib83eNXYRO0hkvT4VBCTuINNOMWSur1At6l5rBH2AkXJzpxLbQhroZldm145yLMJ18OT0RusXOrKhwhIy4nqD6D7YgPN0A5nViqcyfIMJ+0mUatxdRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728508989; c=relaxed/simple;
	bh=tRSw1k/0sr85ExbmOl0gPeC5STZqIEB0X87MsW8wciY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=d9URTRMqFt3XS0WFM4K7MIvfSylYUhJ8sIzmq6lBoRj3zcgHIMShMkO5OgjBnbCJkCv1tnOeksWFzo/EVivwC8IaEqNvnklV9Zu+JRqfTNqPn05fiUeivRBKgBnDW9PKwPdEwJekhQickUoxKJosEWWESnOB/0xruuoZBib7K3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sVIe4Vla; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-710daaadd9bso156411a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 14:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728508986; x=1729113786; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O+Esmh61ONH9tsyHUh8tyGRx4VPfWSAFGr8/A3GrspY=;
        b=sVIe4VlayEp98Dn8Kbu0nDU+IVKjTe+gxDzsbjvCW2/gEn6RRT+VcAQXU+ipCuIcai
         bFoVAooTmmHHllakE3KbrOujtU/1iBnmpkyn2CoUbAt9s2z3U/52KmMxWi9IISBurADG
         dPMFZtwXnw+wcMF3wcKBP1x3narYqyFmwPXo6pg8SEHx6CkhE+3Fd3I/rgwr2YmU0Ae8
         VB6FbqoHNgFHc5kAWkWmvwHZAqnGRJZEAgxb+uke7+ap1qIC7WB2gw8FGTU50ZJY94DG
         qMe7uEicyQ/qTesyuuPUAS/ttp9BhXXzt4WjZYqTc2GfwKjtFGDR9euG1sINj4HwclN5
         /VAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728508986; x=1729113786;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O+Esmh61ONH9tsyHUh8tyGRx4VPfWSAFGr8/A3GrspY=;
        b=TSE4QEUqcyciXVL8xAth9mdlyyect4fsfFhCoEmUwufchiIRXaaklsaaflHBWDgkHI
         //4R0ySbhRGFAoy57K7EF1wKx2smMtlwKQw0KdiQ0Vmqtsp7jdaw/zJzuuc5tRZtuC5W
         RcgZQsHVPRk9ELH5wxxJElbWpYk1aTjc0LxuFRXx7NzfVUUeYqDuJ3PGcc3Nxb/GkBl7
         MmoNKp2qlWG7pSQLdUVJEkoTsDHx6fP+R6grpx4zDf1VhqrjUQVxpBNYrcT8hi2QPoPI
         fBBfMv4Ce2Vwn2iIT39WQUiFCx8pW8lwFr8WEyA8UEcNjzpQdIhHcWMJhwlYo62maU7m
         Lw/A==
X-Forwarded-Encrypted: i=1; AJvYcCUJ0436XpsKjkeQtADyAYxt+v4TJuvCyfALQ7xuJJwHlCtITHeC2dQlj3PPN7jIuKYgAey1RJ41solecUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw51u0MucOhSLnCEjczcuisduAAa1u8YcIBLl4vBgIBHt8dqICP
	yVnHbUrSYeTWg+HNyxVQdvRkrMWK7BVvzwvYjp5y8t//cW65X414esRlKy0KJFI=
X-Google-Smtp-Source: AGHT+IEaJCQb724C+qYxz/hI785RHLentJJFmeUnrLCgmN26JLfX2nQhw7w/BXLmgRfbvojb1I2YWQ==
X-Received: by 2002:a05:6830:3108:b0:70d:e5aa:38af with SMTP id 46e09a7af769-716a9f62f50mr1971315a34.11.1728508985727;
        Wed, 09 Oct 2024 14:23:05 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-716aa70aea2sm140015a34.37.2024.10.09.14.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 14:23:05 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 09 Oct 2024 16:23:04 -0500
Subject: [PATCH] iio: adc: ad4695: Add missing Kconfig select
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-iio-adc-ad4695-fix-kconfig-v1-1-e2a4dfde8d55@baylibre.com>
X-B4-Tracking: v=1; b=H4sIADf0BmcC/x2MywqAIBBFfyVm3YBJL/uVaBE62hBoKEQQ/ntDi
 3vhcOC8UCgzFViaFzLdXDhFga5twB57DITshEEr3XdKGWROuDsr60czoOcHT5ui54B6MtaQn50
 cSODKJPqPr1utH/IC4tZsAAAA
To: Jonathan Cameron <jic23@kernel.org>
Cc: Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Add select IIO_BUFFER and select IIO_TRIGGERED_BUFFER to the Kconfig for
the ad4695 driver.

Fixes: 6cc7e4bf2e08 ("iio: adc: ad4695: implement triggered buffer")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
I didn't see this one in the recent series with similar changes [1][2],
so here is another one.

[1]: https://lore.kernel.org/linux-iio/20241003-ad2s1210-select-v1-0-4019453f8c33@gmail.com/
[2]: https://lore.kernel.org/linux-iio/20241003-iio-select-v1-0-67c0385197cd@gmail.com/
---
 drivers/iio/adc/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 85b82a708c36..98d441d6cc5c 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -52,6 +52,8 @@ config AD4695
 	tristate "Analog Device AD4695 ADC Driver"
 	depends on SPI
 	select REGMAP_SPI
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Analog Devices AD4695 and similar
 	  analog to digital converters (ADC).

---
base-commit: 96be67caa0f0420d4128cb67f07bbd7a6f49e03a
change-id: 20241009-iio-adc-ad4695-fix-kconfig-279c9ef8d9ef

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


