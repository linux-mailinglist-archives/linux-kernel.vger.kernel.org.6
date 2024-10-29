Return-Path: <linux-kernel+bounces-387704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C999B54F1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 22:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4464B1C2289E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 21:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D468520969F;
	Tue, 29 Oct 2024 21:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uFDUo/Yt"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5953F20A5FE
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 21:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730236749; cv=none; b=O/opjc/bzshnbYGNCBK85gw03TucXf8vWVwPFlu8OHU7BLaR5lZNIVJz5BpUPORQXERGOW+l5FI1mlU0SfZnwerIZhIIgf8AyqhbBFAgz7qN0fahrW1njLeBkuEA/pDKdPBzNzhb1R5bbTYo01M0tw6usSyg7efjAMf0Ibalf64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730236749; c=relaxed/simple;
	bh=pTM0zMdu3d6TO9urzgyfiUUlPjCSI6OIMoF7GWE/KtA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kCJH/RKUYchIeUrIOkDNQ7RAq4Woxe7fXD9/JyTtJLEgAac2qnaXvL3gol+mK6uYtw2YqQ4J9L15JB3q/oWMT3SY/rJuHRZXJtkLqT1+ZXUwW3CPbx+6GRaKlseiknSZ9Jq7sAiBy8Io1Qx6XYaTcUt1MVP74vN+UAHkBagZxh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uFDUo/Yt; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3e6104701ffso3664229b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 14:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730236745; x=1730841545; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x1eyK4YeafZM3wWbxx8SgDvrmQ+/xdJDtwtTgNckCGQ=;
        b=uFDUo/YtT/plC2lRd8HNa3IAb08SCXC9qtTccrzgrUQ0hwU3T5Aku1/ysh9JYrEGWS
         OW3lFbz+UmJm0xXdArKcVcdhIjmJr7tRiTwQqhGaS830VKh719tBA/tHSxxDzcWY7yOs
         lXkRjsjnW24T6hM1DWIuV3Dit/zcQukr/aGG+rX7LHAi2geIZwouqDl7t082a4VMfN2P
         UTKjGtpPpDnp1GHILccA5C91mmliCNjn8+I6L6hMeEu6sli7YVBt23L8Mo3qhRBxJExg
         lJe2VfZrs54xAAwuwqFVM6xiJKVmTLyN2X6TvsEe2l3MKr8M5Q311ZZczN96z1AuIOt8
         Elng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730236745; x=1730841545;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1eyK4YeafZM3wWbxx8SgDvrmQ+/xdJDtwtTgNckCGQ=;
        b=BASiXRsETP74gGMEOdeRJt3ix2ZRRQ0kPWmQPVt4APvf3a/SSY9MuT9uiv/DZTmHtq
         Vtk+1MvcUBO87ymcu4q+ESMc0c9+nqszT59VKkkLYetoScD5ybCUaiNb1VT4PwOg43lV
         gnbwYK96CZIdsDz875fGs8Al42gEfdTL5HUB+M7zvTYl4pHMC8WQv3VUMmWqdL8HRNCl
         maRJJ1pmy5Gy7rt9o/NbdvV+JzGSQ7oHhM8oNsKOUzxh5sjWQ992ZL1LxP1ZFWedy45v
         1f+qABf+xIQ9Vcg6JUMwty1+uSNr7Y5osd3IrpfqZBqbBgkajkLGaatdAXnh2lnkaRou
         W8Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUWGh+oec/p833LzpakDVy6GId9kfeewfHEzy+zTFqOzYbn6ukGl6q5qaqnY7lGTy2wA7Bwsou+jT2N1xg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaQSEZSgZRkIY655GehsoE0yq3gkFc1mhWGibUJ9gfPKdokCri
	pNua0MN6i2JXNKcsIwRTQ/g/xsCKUurFIw/APf0TdHTsfWWOvaIqgtT82K4GTPM=
X-Google-Smtp-Source: AGHT+IHNyylNNYk4pJl4v9Wic0OnFFDI+mUGd5rmtr8KeXqE5vw1L04LSd4rV1eOn4xDGik8dGnw4g==
X-Received: by 2002:a05:6808:2183:b0:3e5:fd08:d020 with SMTP id 5614622812f47-3e6384c54ebmr12182255b6e.42.1730236745444;
        Tue, 29 Oct 2024 14:19:05 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e6325b87ecsm2280559b6e.54.2024.10.29.14.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 14:19:04 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 29 Oct 2024 16:18:50 -0500
Subject: [PATCH v2 2/2] iio: adc: ad7606: finish pwm_get_state_hw() TODO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-pwm-export-pwm_get_state_hw-v2-2-03ba063a3230@baylibre.com>
References: <20241029-pwm-export-pwm_get_state_hw-v2-0-03ba063a3230@baylibre.com>
In-Reply-To: <20241029-pwm-export-pwm_get_state_hw-v2-0-03ba063a3230@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, Guillaume Stols <gstols@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Replace the call to pwm_get_state() with a call to pwm_get_state_hw() in
the ad7606 driver. This allows reading the sampling_frequency attribute
to return the rate the hardware is actually running at rather than the
rate that was requested. These may differ when the hardware isn't
capable of running at exactly the requested frequency.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

I went ahead and made this patch since it is trivial, but it would be
nice to get a Tested-by from Guillaume to make sure it actually works
as expected.
---
 drivers/iio/adc/ad7606.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 8b2046baaa3e..1581eb31b8f9 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -762,11 +762,9 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 		*val = st->oversampling;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		/*
-		 * TODO: return the real frequency intead of the requested one once
-		 * pwm_get_state_hw comes upstream.
-		 */
-		pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
+		ret = pwm_get_state_hw(st->cnvst_pwm, &cnvst_pwm_state);
+		if (ret < 0)
+			return ret;
 		*val = DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC, cnvst_pwm_state.period);
 		return IIO_VAL_INT;
 	}

-- 
2.43.0


