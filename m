Return-Path: <linux-kernel+bounces-379552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CD79AE04F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6FF81F2295D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B8F1C878A;
	Thu, 24 Oct 2024 09:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vO4ZMXMP"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DAF1B6CF1
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 09:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729761181; cv=none; b=vDTRzqQmf6ivy2eMTBc+FaIAoKoJN48fpZkvr65ek1VynP3ztsoHml4blyLptWGLMu5gYNts9Q3JultLUbngsjcK3V/PJ4niOiZYE1G/WUVFkRYVmJgULmaJEF/44qpXde4Lq0hlwrtA6NODzkF384Ra4k03kxrA96jh0rnSW64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729761181; c=relaxed/simple;
	bh=gxT5UJtPsva0rf/TD2YMcs8UCCD2ZDF5U8pMvCjVzqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FFyIeWn61eGqcQwaX20edm0VN/Z2ktCUEvGed6x44hOiIfFLI8fVx6v+iqwk354iPUBTn7z00blq1gMavmKvCsmkrtc6X0/xbl/0/j6XB0HfNeDF3r6coF6PTEwUZgX3CiB16CcPdtnTicB1OQjkjnFhXCx1ss76LvxbN/tdP3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vO4ZMXMP; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d50fad249so458362f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 02:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729761174; x=1730365974; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ExSlIGvQ1qKjNeppy5CslHA0+Ug61+8Wg56jV+Rbdo=;
        b=vO4ZMXMPQLxDzGZzWC0C4qYT4KWHdsYAJ6Lc1fvUQCtANW8saCsYNVZH41sSoMhusb
         RgNutDh6UjMfNYlYUgjBri2wpawg8heedUgB7CFoux5sajv4HO4G6SOXxSiKZ/9iv3W2
         qaaDuMamDHX2ce8tC2XLzU4G/f7S43EpbdNfvqU36o3t8aoCkJ1SKIVuNh9tcqITBUIX
         CLQGRdz6QF0zMO1y0S0reyR6MP7iCuESjKfNa3X/rWCTb3SR6UVsTlzHeesMcazXaAPc
         +EGpHXZRudb/ZZiq+q0WtPSTvt9DuJ0Kp2S9hrBZsS2SzoA7TWvphIABrqkvG1u6rIag
         skgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729761174; x=1730365974;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ExSlIGvQ1qKjNeppy5CslHA0+Ug61+8Wg56jV+Rbdo=;
        b=K3oV+w5g9B1g6AmLiWrNLULIUiNb2Kd5TEn0NSETlCStV5F9FwGaZyny0+Bl+82W2J
         /NqC3dzBFFtiWeiB5MIlMPIEHpXARfFJV/9SC+DCySJJbHgVBu1I4y8KEShCGas8xcRo
         QbYIGmxsVbbYYJCXc6yrWgCSq5OaA/91doQjQhSuup83JpOZ5Idit9WvWnBf+ZBXTO/D
         HcGt2++BCUcKZWGELJ2zwZMwTM+3ljiCjSriiu3GsjmT6sh3kdzd6KYamNuA4OerLpOs
         7tRq7EaRAHaJ79n1GlkCSwhBeu7Tri1o7aJ5tkktUEnVPwuhL0r5qy46sZ9fFvu9l8cA
         G50w==
X-Forwarded-Encrypted: i=1; AJvYcCXmkH4+EEHy70Z1AYc0ccfVK2WqHblTNfMwzRfOOO+sfYfv1nud3p7hYOtZQSWSOhOXHOhgU6wZmBWEZoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YySD6Zd8xgoCrHiq7FE7FpguGtKD3hio2/4krDtjNhh32PRUN5Y
	fPz4fqBezcX7OS1Wwz3D5Q+G14gcjzCb8eWOifhn0BVFty5EEqDqiAU5Og4dDsI=
X-Google-Smtp-Source: AGHT+IHssIn5+2M6/mPZQxU0hUVx3UQF3gcvmL8dKPbUHqhz4gdaCpTX+p1XSijdvMnFvDxT9HuOTQ==
X-Received: by 2002:a5d:66c7:0:b0:37d:50f8:a7f4 with SMTP id ffacd0b85a97d-380458f3f6bmr784047f8f.52.1729761173970;
        Thu, 24 Oct 2024 02:12:53 -0700 (PDT)
Received: from [192.168.1.64] (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b94071sm10843701f8f.89.2024.10.24.02.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:12:53 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 24 Oct 2024 11:11:28 +0200
Subject: [PATCH 6/7] iio: light: stk3310: simplify code in
 write_event_config callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-iio-fix-write-event-config-signature-v1-6-7d29e5a31b00@baylibre.com>
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
 drivers/iio/light/stk3310.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index ed20b67145463d253a0dff28a4c1c3e02e710319..c6f950af5afa0f77a617bd2baf0a08eef5ec26f0 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -330,9 +330,6 @@ static int stk3310_write_event_config(struct iio_dev *indio_dev,
 	struct stk3310_data *data = iio_priv(indio_dev);
 	struct i2c_client *client = data->client;
 
-	if (state < 0 || state > 7)
-		return -EINVAL;
-
 	/* Set INT_PS value */
 	mutex_lock(&data->lock);
 	ret = regmap_field_write(data->reg_int_ps, state);

-- 
2.47.0


