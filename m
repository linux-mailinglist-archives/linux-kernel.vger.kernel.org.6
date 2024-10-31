Return-Path: <linux-kernel+bounces-390776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E419B7E63
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 506F9B21CCC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800761BC9EE;
	Thu, 31 Oct 2024 15:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="r1kWn1E1"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309051AD9ED
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730388437; cv=none; b=LZJCUF8RqgiCgwegyhccApXiwwx/mVHmCjW33TEkipXSg2SRh9PS9VLHqglEt2XjQLiLXTGaEZPL7vxaRQNl2ARmPpoD+duhu2rmW1ImGpQ1QyokSmfbSyBKzWF1hCo7zv+UKV7YRF/Uo+DHt9gjE+pr8w8aMoOS5m6Z5vvW2wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730388437; c=relaxed/simple;
	bh=Crws9hBcBUgMNyTwteduHmHWY+ibF9suD+aQH3je7N8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eq28ZMNVbpXn9FoQamkENMGUsakgZyX38tLprK+BTJB0oewhBWi78jYj+diACdJiLpH3fcPc+bZCsrcizby8KYxR/6+u4JfmoDwwLf+hcCrwApm4V7WCmFiv6NAuw62vvy71mLbfpAgnwgu6eTLEBbE/rZVZ8SMQckAziRcJbQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=r1kWn1E1; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4314f38d274so11403105e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730388433; x=1730993233; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JeXr3qZeoMT4Q41ImmT91MFFoZboqwE1uhQTfbeavwY=;
        b=r1kWn1E1yxvTzXA45e0pzvuWzpaLc9n7gdq3rd2h+2NGX4GHTIMtS8jjXUsQ7tpZII
         fojQ9BCloMjtlKeHHG73Ab8l7PdrLo4SdF/B7qLv6fHA1SVmRWASQcbZBX5I5xlRcCIB
         jap2avtU7jGqg09+89kMIiZvxfYICeYHMHV4F+qqeGlAfULxqIsgmUhvt+6+SwhAkZY2
         68T2UkuNN5xk9OW7vSmM+wWLvGw8bnsHB5eWz+Njik7nybMCwIJkG0JirhffNDBfLrAY
         /d6bkX622Qd91F7WEQbF9lVz1K5rGqXc9vIxQs4dOruH/dp3wTKva0z2fEyFJXFUl8cm
         KE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730388433; x=1730993233;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JeXr3qZeoMT4Q41ImmT91MFFoZboqwE1uhQTfbeavwY=;
        b=WQngpGu54VDQO4y0t5P9JpPDxRy4b6fkRwsV7m6kJkatIAUEG3IS7BgNMFoFoipcNH
         v0OZw9SQl0RbWW6X3l41mJngb8abE9HDeG7KBlcSOaGHhuX1D+Sc1HZ/MQi7FB2Obw40
         1bKg6D1H7rQsB+s/KwH3CR0WjyF72bGLYhBni/Dxt8KY754IdXaWUVzFNnTMqG4SE1Ir
         ln3qakQR/lEmpCIwowHMP+Nh4YDJPBvqvCLEo7CQUXNOvYrX4bGxNDzv55uKIj0b+Nfu
         PDxfhVx04SubWFVfdkIcr4srx81Mxv58udjZOpt1hNMydtTEAHOrJBGo25/Ng9BW1H/i
         L7XA==
X-Forwarded-Encrypted: i=1; AJvYcCU+uxrGLzZMumbu879aXSZ9PLi06Y7b4FvBzYb4q+MKwJwkfEhUktM5SFqt9rM9Nn7h8WrJkVm+3Ggwpmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzdAnfoxIhFyu1/IcXYymFxNq3NBYvGvAxAt6my0q1vv0ucT7v
	/yF7bfce52RkpxpP69ofYRRITE1PwK8IC1n2xANQacyXNbkw88fQzBFJzeu0+/E=
X-Google-Smtp-Source: AGHT+IHhKXOtU6WrItuY3dPBqGFS+YCmx9LFZrBINQBT3KJgqU4GZtX+T26R8f/M/h9JuV4y1clo3w==
X-Received: by 2002:a05:600c:5486:b0:431:52cc:877a with SMTP id 5b1f17b1804b1-43283296066mr2433515e9.34.1730388433589;
        Thu, 31 Oct 2024 08:27:13 -0700 (PDT)
Received: from [192.168.1.64] (2a02-8428-e55b-1101-1e41-304e-170b-482f.rev.sfr.net. [2a02:8428:e55b:1101:1e41:304e:170b:482f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5bf429sm29399475e9.12.2024.10.31.08.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 08:27:13 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 31 Oct 2024 16:27:01 +0100
Subject: [PATCH v2 06/15] iio: light: adux1020: write_event_config: use
 local variable for interrupt value
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-iio-fix-write-event-config-signature-v2-6-2bcacbb517a2@baylibre.com>
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

state parameter is currently an int, but it is actually a boolean.
iio_ev_state_store is actually using kstrtobool to check user input,
then gives the converted boolean value to write_event_config.  The code
in adux1020_write_event_config re-uses state parameter to store an
integer value. To prepare for updating the write_event_config signature
to use a boolean for state, introduce a new local int variable.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/light/adux1020.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/adux1020.c b/drivers/iio/light/adux1020.c
index 2e0170be077aef9aa194fab51afbb33aec02e513..db57d84da616b91add8c5d1aba08a73ce18c367e 100644
--- a/drivers/iio/light/adux1020.c
+++ b/drivers/iio/light/adux1020.c
@@ -505,7 +505,7 @@ static int adux1020_write_event_config(struct iio_dev *indio_dev,
 				       enum iio_event_direction dir, int state)
 {
 	struct adux1020_data *data = iio_priv(indio_dev);
-	int ret, mask;
+	int ret, mask, val;
 
 	mutex_lock(&data->lock);
 
@@ -526,12 +526,12 @@ static int adux1020_write_event_config(struct iio_dev *indio_dev,
 			mask = ADUX1020_PROX_OFF1_INT;
 
 		if (state)
-			state = 0;
+			val = 0;
 		else
-			state = mask;
+			val = mask;
 
 		ret = regmap_update_bits(data->regmap, ADUX1020_REG_INT_MASK,
-					 mask, state);
+					 mask, val);
 		if (ret < 0)
 			goto fail;
 

-- 
2.47.0


