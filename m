Return-Path: <linux-kernel+bounces-379551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7B39AE04C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC9A91C224D6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732B01C32EC;
	Thu, 24 Oct 2024 09:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UEB3NOKi"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1055C1B85E3
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 09:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729761177; cv=none; b=LUucONQbqmSMdR1k6Vspoj68gZ9JzpdzoyxkAd45g6ZB00ZvFFVoCfIVvC2Ld8FY0qET97eyoWagg0h/YSNLilPiK/dWt5fLeWgqqjWe5RDjKPOZ57F4smeQgM2v25hJM/HKw+qiKgXhwnZ32vlGnQ1ALWs469McFAOTrNcAHw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729761177; c=relaxed/simple;
	bh=EvZTfjPuH+Sw2tva9CA/YuYYsffYBvbQ9xRBfy4MGH4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C3DKxZpaXa15JxCfi9t/UAizDHNI5iwVNISXoYdMEbMDwhf6iFWUEPk60UtD7cZXW01TRa5PhN9W/QTRgPiNaOZKGW2XA0NM7bXOknzh8UD4qURUUqt4+k4NGczzB2SlFAid5525lFg6Q7p9RJN7UT9rBRVyC6jcmkcL2lD/zp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UEB3NOKi; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539fe76e802so803557e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 02:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729761173; x=1730365973; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HpXwrqa5mh4an1VW52USOlgjMJ2X4POeKu7/qnEQ85Y=;
        b=UEB3NOKiu7qiJQ+wpnQ+mQ5/yijjJUbHhY6+b09e6YYZm4/CWGkN3fWh1tJlaTQSK/
         S/N629d8wE4wniYUVGp6HM5ShYNr4ob39W+XlMeNkFjDdf33MYlkqq4oPLxVlRFNhWlf
         z7A1vlXEaLKVvsDGbsSLLc7jMunz+7wmUsFZ7LfIJeg6oR1NYHPtMuu4QVmV0x5CNT6d
         XXvhkXS74OoyobaHe7zkzNsKSuv/mAi7mKvAAqHaY4dCuiZZx9pdpB33QYq+4oX0hHpe
         xQ+VzxlzQspIT9IECXZEd9OtEktWpW9xJ05m8mruDuUTGfuOzG+eojB9N31QMqcYEMZb
         0xGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729761173; x=1730365973;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HpXwrqa5mh4an1VW52USOlgjMJ2X4POeKu7/qnEQ85Y=;
        b=E5Q/EA8N6mKcfUnM79scO5XVYmG7N2tDaMvAYlgnl6tL2tNUcu2ep1RK5lTUOHe2k8
         a36UTDdHGoqSnDUrYOb4OuVyUk8bcQxgJxef4R7wqRRd/ZLpHhIz2gnWdlNqpx3mwpiE
         N7cUXgSwMJAmBT/RoD4jCESKNfe2ANdzi6vaBPDUu+8c5CHctBTUIrwDFocF9UwOKfhF
         4M3P9ub5hX28B7bQxLu9ijE5lVC8JrZ/ZUyqJsCnI4N9asMt+Ttc4c6i9d2a9EppA80I
         BTX/GqSWE5MEBUKnvez+mDr1xe2pKKUb7KgrPhM358e1Ooj2UrTea2NWra7oMPLNSjHe
         xmkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDt2bR5LEaRoNV0ngOjWEPElt3BZuKBPEb6+4PDTigUsvKmrIGmxdtxeJDOT1vomV1XvXr4YdZ1K5H004=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtA2dXsOzEakNtpUv5GmPYrZEHdq+Ml3JNIxctUNhOLZxLO1UI
	my8Wfefv8U5QXTbRRqOlTlSchrfQ6hHMY/nGmhu1DHsh2w5SqUkNtVibQfmJBz8=
X-Google-Smtp-Source: AGHT+IHjMTzdOejYpXdaJTcSXe71t6xMLTv/MupAWuwwaYamFeQSYvZEYBgJNNUbqbvWU86WqzOMBw==
X-Received: by 2002:a05:6512:3a82:b0:539:8b02:8f1d with SMTP id 2adb3069b0e04-53b1a3392bcmr2894072e87.30.1729761173024;
        Thu, 24 Oct 2024 02:12:53 -0700 (PDT)
Received: from [192.168.1.64] (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b94071sm10843701f8f.89.2024.10.24.02.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:12:52 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 24 Oct 2024 11:11:27 +0200
Subject: [PATCH 5/7] iio: imu: inv_mpu6050: simplify code in
 write_event_config callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-iio-fix-write-event-config-signature-v1-5-7d29e5a31b00@baylibre.com>
References: <20241024-iio-fix-write-event-config-signature-v1-0-7d29e5a31b00@baylibre.com>
In-Reply-To: <20241024-iio-fix-write-event-config-signature-v1-0-7d29e5a31b00@baylibre.com>
To: Mudit Sharma <muditsharma.info@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Anshul Dalal <anshulusr@gmail.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Cosmin Tanislav <cosmin.tanislav@analog.com>, 
 Ramona Gradinariu <ramona.gradinariu@analog.com>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Dan Robertson <dan@dlrobertson.com>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Matteo Martelli <matteomartelli3@gmail.com>, 
 Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Mariel Tinaco <Mariel.Tinaco@analog.com>, 
 Jagath Jog J <jagathjog1996@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, 
 Kevin Tsai <ktsai@capellamicro.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, chrome-platform@lists.linux.dev, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2

iio_ev_state_store is actually using kstrtobool to check user
input, then gives the converted boolean value to the write_event_config
callback.

Remove useless code in write_event_config callback.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 7 ++-----
 drivers/iio/light/apds9960.c               | 2 --
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 5680be153127711777b6074da18a7a0f86211d6c..21ebf0f7e28fec302cbf8ab890fc53a3de6f36cd 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -1176,21 +1176,18 @@ static int inv_mpu6050_write_event_config(struct iio_dev *indio_dev,
 					  int state)
 {
 	struct inv_mpu6050_state *st = iio_priv(indio_dev);
-	int enable;
 
 	/* support only WoM (accel roc rising) event */
 	if (chan->type != IIO_ACCEL || type != IIO_EV_TYPE_ROC ||
 	    dir != IIO_EV_DIR_RISING)
 		return -EINVAL;
 
-	enable = !!state;
-
 	guard(mutex)(&st->lock);
 
-	if (st->chip_config.wom_en == enable)
+	if (st->chip_config.wom_en == state)
 		return 0;
 
-	return inv_mpu6050_enable_wom(st, enable);
+	return inv_mpu6050_enable_wom(st, state);
 }
 
 static int inv_mpu6050_read_event_value(struct iio_dev *indio_dev,
diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
index 3c14e4c30805e1b596ef2380f94e6aa3e92082b1..3a56eaae5a68f2891d061871c7013f0b5447bb47 100644
--- a/drivers/iio/light/apds9960.c
+++ b/drivers/iio/light/apds9960.c
@@ -762,8 +762,6 @@ static int apds9960_write_event_config(struct iio_dev *indio_dev,
 	struct apds9960_data *data = iio_priv(indio_dev);
 	int ret;
 
-	state = !!state;
-
 	switch (chan->type) {
 	case IIO_PROXIMITY:
 		if (data->pxs_int == state)

-- 
2.47.0


