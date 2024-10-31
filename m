Return-Path: <linux-kernel+bounces-390774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 087299B7E5F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39C421C2180D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816221B86CF;
	Thu, 31 Oct 2024 15:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XiWNvUaM"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B61E1A263F
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730388435; cv=none; b=XkR1JgU2FFz0QlUBDnCM/BXwkS2fiy6UZsqep7oGtGr526FkfO1XWUwVlAmHHxUXyM35t1DkCwFqcY6iGUjYs+hHHqFF7QMxPAyfZ5xvK7dpfEgKqNqk7xhoUY3M0F7wYYD8rYYaPn2WyHYTw7AWtIvJHwyoNdiBZCK7iu3C/gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730388435; c=relaxed/simple;
	bh=KUAQJafYnMcVigPRpZorye0fOSrdIPLW2FGLlfOeXrI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SWGKiGHyY2ALsVqb0qtDe+bVi75SdwY+50OO3azScGDV1UAspKlQY0OMJUUWHtYZCVhfWBzjOhF4y8O2eqFG83g1rPXD/ytIewRsDvIS/Cmx+7myrUbG70soih5SJtQktNk9WPrMCo7WEQXA5IM+sZKiPhHIebykxVt3t5zxmF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XiWNvUaM; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539eb97f26aso1143573e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730388432; x=1730993232; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iARvgNUgpGuJeduLUMchLuVPcb6x0a/MDX16DJ8FtYc=;
        b=XiWNvUaMX9KTVdfjHi1MLPpWjRYZLIen7lgnae/kXSeVRo1FZF8lBLrMDQJHHLcvDh
         dPupWQ4BU7BGlGw6DmECQvTN4mJvKF4Ig4wkw4HqhKrOpEnoX98JO91bCWE5piJXXeKW
         oT7Mp6n89bilvfb0qRwrvOw0tdQu5VV4sreYJZBrEMYguRwbUFP/tCKlFqESv+AQOEMK
         GqSL2TkZYd3kYEKaEFEeY2w0Hw1NrXE4QJj82mx3zxKyQm18Iei2Bqj3p/viVwm2F0GN
         fk50vg1YP1P9b3pKn1aOGyV8lEkJdD+y43NhKq14Je0J0d5T57VLQmFL57uplMYu05oX
         qtew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730388432; x=1730993232;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iARvgNUgpGuJeduLUMchLuVPcb6x0a/MDX16DJ8FtYc=;
        b=TSllp0lUVRqUYUcz0hlMeTxTOjvjKAwQ7OJXRipXeRCHuPthm32Iq9xNWGzE4NpPxV
         MZMhi0yTeC5e12+GB8hBwc6NIQqdCsCLFS2Cwor0oB0cZosnBNvlQQdjAGT4q04ZtJXB
         u7ZU9ql8SNDxxgHE91aPPUJtmOg49kvZIvtO4jVF/6/kSacRLlAwhcNWd7bflLc0hyqT
         w5q11OWBfoyAACpRLQS48JVr+mXtkfaetOjlTz0JHQyGiXYkAKSHwSDfGLdwuwAfu+wb
         /p6IWyqeGcS3VYoySxDy+B0KNuGiaRXP22dzrJ0X3dVW5GJXkrwrbOvEmp11SNKTsRN9
         r6fw==
X-Forwarded-Encrypted: i=1; AJvYcCWEunECTXx3hvDomSWxttEIzprFk11qkbY6d3bP+LYyIn6WZItBvSwHZHVsehZbsBMC04U8k59BbEpmDQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQowFI1HDjeRmuBEVU56AiQewrVa6AHKdJyqdzaZ8IDeHPvOLC
	ZN0bdeslu1loj9hEERq5+psbNtEdY7GjHaDi3JoYBJay9cYNyU6Snc+f3X1atMA=
X-Google-Smtp-Source: AGHT+IEWcF0+R0QL/6lFuKjPVZ78UfoWB02cUsI4xL/9k/ULH8MPxNidSuG6r6GPzz/NlzRHmcmBRQ==
X-Received: by 2002:a05:6512:ba1:b0:539:fdee:fe04 with SMTP id 2adb3069b0e04-53b7ecd57d5mr3831450e87.11.1730388431614;
        Thu, 31 Oct 2024 08:27:11 -0700 (PDT)
Received: from [192.168.1.64] (2a02-8428-e55b-1101-1e41-304e-170b-482f.rev.sfr.net. [2a02:8428:e55b:1101:1e41:304e:170b:482f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5bf429sm29399475e9.12.2024.10.31.08.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 08:27:11 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 31 Oct 2024 16:26:59 +0100
Subject: [PATCH v2 04/15] iio: proximity: irsd200: simplify code in
 write_event_config callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-iio-fix-write-event-config-signature-v2-4-2bcacbb517a2@baylibre.com>
References: <20241031-iio-fix-write-event-config-signature-v2-0-2bcacbb517a2@baylibre.com>
In-Reply-To: <20241031-iio-fix-write-event-config-signature-v2-0-2bcacbb517a2@baylibre.com>
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
 drivers/iio/proximity/irsd200.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/irsd200.c b/drivers/iio/proximity/irsd200.c
index 6e96b764fed8b577d71c3146210679b0b61d4c38..fb0691da99ee621e19013a64d122f097e793efd9 100644
--- a/drivers/iio/proximity/irsd200.c
+++ b/drivers/iio/proximity/irsd200.c
@@ -662,7 +662,7 @@ static int irsd200_write_event_config(struct iio_dev *indio_dev,
 			return ret;
 
 		return regmap_field_write(
-			data->regfields[IRS_REGF_INTR_COUNT_THR_OR], !!state);
+			data->regfields[IRS_REGF_INTR_COUNT_THR_OR], state);
 	default:
 		return -EINVAL;
 	}

-- 
2.47.0


